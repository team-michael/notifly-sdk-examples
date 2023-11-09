# notifly-sdk-examples (Swift)

## How to run the swift sample app? 🚀

### 1. Configure your secrets in notifly-example/Constants.swift

You can get your development environment in the following link: [Notifly Dev Setting Page](https://notifly.tech/console/settings?environment=0)

- project_id
- username
- password

### 2. locate your firebase secrets in your swift project.

    - GoogleService-Info.plist (for ios)

### 3. move to the project directory and install dependencies

```bash
cd notifly-example && pod install
```

### 4. run the project

```bash
open notifly-example.xcworkspace
```

### 5. build and run the sample app

if the message, `[Notifly Info]  📡 Notifly SDK is successfully initialized.` is printed in the console, it means that the sample app is successfully connected to the notifly server.
