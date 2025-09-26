# SpaceScout Owner Portal

SpaceScout lets property owners post rental/sale listings with rich descriptions and image galleries. This repo contains the owner-facing Flutter app wired to Firebase Authentication, Storage, and Realtime Database.

## Project structure

- `lib/add_listing_screen.dart` – create listings, upload images, and push metadata to Realtime Database
- `lib/owner_screen1.dart` – stream listings owned by the signed-in user
- `lib/login_signup.dart/` – authentication flows (email/password)
- `lib/firebase_options.dart` – generated configuration pointing to the Firebase project `project-6d3ff`
- `android/app/google-services.json` – Android-specific Firebase credentials

## Prerequisites

- Flutter SDK 3.24+ (project uses Dart 3.8)
- A Firebase project (currently `project-6d3ff`) with Authentication, Realtime Database, and Storage enabled
- Auth rules allowing email/password sign-in
- Realtime Database rules similar to:

```json
{
	"rules": {
		"listings": {
			".read": "auth != null",
			".write": "auth != null && (
				!data.exists() && newData.child('ownerId').val() == auth.uid ||
				data.exists() && data.child('ownerId').val() == auth.uid && newData.child('ownerId').val() == auth.uid
			)",
			".indexOn": ["ownerId"]
		}
	}
}
```

Adjust validation clauses to match your business rules.

## Firebase configuration

The repo already contains generated configuration for the Firebase project `project-6d3ff`. If you need to regenerate or point to a different project:

```powershell
dart pub global activate flutterfire_cli
flutterfire configure --project=<your-project-id> --platforms=android,ios,macos,web,windows
```

Download the updated platform files (e.g., `GoogleService-Info.plist`) and place them under the appropriate platform directories if you target iOS/macos.

## Running the app

```powershell
flutter pub get
flutter run
```

## Testing

```powershell
flutter test
```

The included widget test ensures the sign-in screen renders correctly.

## Deployment tips

- Ensure Firebase Storage rules permit authenticated uploads to `listings/{uid}/...`.
- Collect analytics or crash reporting by enabling the desired Firebase products and regenerating configuration files.
- If you add new platforms, rerun `flutterfire configure` to keep `firebase_options.dart` up to date.

---

For further Flutter guidance, see the [Flutter documentation](https://docs.flutter.dev/).
