import SwiftUI

@main
struct NotesApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListaNotasView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
