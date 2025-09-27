import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:spacescout2/localization.dart';
import 'package:spacescout2/payment_transaction.dart';

class PaymentScreen extends StatefulWidget {
  final String language;
  final String userName;
  final String userEmail;

  const PaymentScreen({
    super.key,
    required this.language,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController amountController = TextEditingController(text: "199.00");
  final TextEditingController noteController = TextEditingController();
  String selectedMethod = 'UPI';
  bool processing = false;
  List<PaymentTransaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('transactions');
    if (raw == null) {
      setState(() => transactions = []);
      return;
    }
    final list = (jsonDecode(raw) as List)
        .map((e) => PaymentTransaction.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() {
      transactions = list.reversed.toList();
    });
  }

  Future<void> _saveTransactions(List<PaymentTransaction> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('transactions', jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  Future<void> _clearTransactions(String clearedLabel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('transactions');
    setState(() => transactions = []);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(clearedLabel)));
  }

  Future<void> _payNow(String invalidAmountMsg) async {
    final parsed = double.tryParse(amountController.text.trim().replaceAll(",", ""));
    if (parsed == null || parsed <= 0) {
      _snack(invalidAmountMsg);
      return;
    }

    setState(() => processing = true);
    await Future.delayed(const Duration(seconds: 2));

    final txn = PaymentTransaction(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      amountPaise: (parsed * 100).round(),
      currency: 'INR',
      method: selectedMethod,
      createdAt: DateTime.now(),
      status: 'success',
      description: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
    );

    final updated = [...transactions.reversed, txn];
    await _saveTransactions(updated);
    await _loadTransactions();

    setState(() => processing = false);

    if (!mounted) return;
    final texts = localizedText(widget.language);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(texts["paymentSuccessTitle"]!),
        content: Text('${texts["paymentSuccessMsg"]!}\n${texts["txnId"]!}: ${txn.id}'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(texts["ok"]!))],
      ),
    );
  }

  void _snack(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(widget.language);

    return Scaffold(
      appBar: AppBar(
        title: Text(texts["payment"]!),
        actions: [
          IconButton(
            tooltip: texts["clearHistory"]!,
            icon: const Icon(Icons.delete_outline),
            onPressed: transactions.isEmpty
                ? null
                : () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(texts["clearHistory"]!),
                        content: Text(texts["clearConfirmMsg"]!),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(texts["cancel"]!)),
                          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(texts["clear"]!)),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _clearTransactions(texts["cleared"]!);
                    }
                  },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(labelText: texts["amount"]!, hintText: "199.00"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: noteController,
                          decoration: InputDecoration(labelText: texts["note"]!, hintText: texts["noteHint"]!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedMethod,
                    decoration: InputDecoration(labelText: texts["method"]!),
                    items: const [
                      DropdownMenuItem(value: 'UPI', child: Text('UPI')),
                      DropdownMenuItem(value: 'Card', child: Text('Card')),
                      DropdownMenuItem(value: 'NetBanking', child: Text('Net Banking')),
                    ],
                    onChanged: (v) => setState(() => selectedMethod = v ?? 'UPI'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: processing
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.lock),
                      label: Text(processing ? texts["processing"]! : texts["payNow"]!),
                      onPressed: processing ? null : () => _payNow(texts["invalidAmount"]!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(texts["history"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton.icon(
                onPressed: transactions.isEmpty
                    ? null
                    : () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(texts["clearHistory"]!),
                            content: Text(texts["clearConfirmMsg"]!),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(texts["cancel"]!)),
                              ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(texts["clear"]!)),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await _clearTransactions(texts["cleared"]!);
                        }
                      },
                icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                label: Text(texts["clear"]!),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text(texts["noTxns"]!)),
            )
          else
            ...transactions.map((t) {
              final amount = (t.amountPaise / 100).toStringAsFixed(2);
              return Dismissible(
                key: ValueKey(t.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) async {
                  final updated = transactions.where((e) => e.id != t.id).toList().reversed.toList();
                  await _saveTransactions(updated);
                  await _loadTransactions();
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      t.status == 'success' ? Icons.check_circle : Icons.error,
                      color: t.status == 'success' ? Colors.green : Colors.red,
                    ),
                    title: Text('₹$amount • ${t.method}'),
                    subtitle: Text('${t.id}\n${t.createdAt}'),
                    isThreeLine: true,
                    trailing: Text(t.currency),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}