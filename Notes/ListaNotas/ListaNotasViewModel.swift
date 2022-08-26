import Foundation
import Combine
import CoreData

class ListaNotasViewModel: ObservableObject {
    
    @Published var titulo = ""
    @Published var descripcion = ""
    @Published var fecha = Date()
    @Published var bEdit = false
    @Published var nota: Notas?
    
    func saveNote(viewContext: NSManagedObjectContext) {
        let newNote = Notas(context: viewContext)
        newNote.fecha = fecha
        newNote.titulo = titulo
        newNote.descripcion = descripcion
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func updateNote(viewContext: NSManagedObjectContext) {
        do {
            self.nota?.setValue(self.titulo, forKey: "titulo")
            self.nota?.setValue(self.descripcion, forKey: "descripcion")
            self.nota?.setValue(self.fecha, forKey: "fecha")
            
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteNode(viewContext: NSManagedObjectContext, nota: Notas) {
        do {
            viewContext.delete(nota)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func setData(nota: Notas?) {
        self.nota = nota
        self.titulo = nota?.titulo ?? ""
        self.descripcion = nota?.descripcion ?? ""
        self.fecha = nota?.fecha ?? Date()
    }
    
}
