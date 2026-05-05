import SwiftUI
import ServiceManagement

struct SettingsView: View {
    @State private var openAtLogin = SMAppService.mainApp.status == .enabled

    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        Form {
            Section {
                Toggle("Open at Login", isOn: $openAtLogin)
                    .onChange(of: openAtLogin) { _, newValue in
                        toggleOpenAtLogin(newValue)
                    }
            }

            Section("About") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Modafinil")
                        .font(.system(size: 15, weight: .semibold))
                    Text("Version \(version)")
                        .font(.modCaption)
                        .foregroundStyle(.secondary)
                    Text("Keeps your Mac awake.")
                        .font(.modCaption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                    Text("Made by Patrick")
                        .font(.modCaption)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, 4)
            }
        }
        .formStyle(.grouped)
        .frame(width: 380, height: 260)
    }

    private func toggleOpenAtLogin(_ newValue: Bool) {
        do {
            if newValue {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            openAtLogin = SMAppService.mainApp.status == .enabled
        }
    }
}
