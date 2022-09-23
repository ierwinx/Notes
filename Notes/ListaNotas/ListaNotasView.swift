import SwiftUI
import CoreData

struct ListaNotasView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Notas.fecha, ascending: false)],
        predicate: NSPredicate(format: "fecha <= %@", Date() as CVarArg), //Predicate no es necesario pero se muestra para hacer busquedas mas especificas
        animation: .spring())
    private var arrNotes: FetchedResults<Notas>
    
    @StateObject private var listaNotasViewModel = ListaNotasViewModel()
    @State private var bLinkAdd = false
    @State private var bLinkEdit = false

    var body: some View {
        NavigationView {
            List {
                ForEach(arrNotes) { nota in
                    Button {
                        DispatchQueue.main.async {
                            listaNotasViewModel.bEdit = true
                        }
                        listaNotasViewModel.setData(nota: nota)
                        bLinkEdit = true
                    } label: {
                        HStack {
                            Text(nota.titulo ?? "")
                                .bold()
                                .padding()
                            Spacer()
                        }
                    }
                    .background {
                        NavigationLink("", destination: AddNoteView(objViewModel: listaNotasViewModel, bShow: $bLinkEdit), isActive: $bLinkEdit)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        
                        Button(role: .destructive) {
                            listaNotasViewModel.deleteNode(viewContext: viewContext, nota: nota)
                        } label: {
                            Label {
                                Text("Borrar")
                            } icon: {
                                Image(systemName: "trash")
                            }
                        }
                        
                        Button {
                            listaNotasViewModel.bEdit = true
                            listaNotasViewModel.setData(nota: nota)
                            bLinkEdit = true
                            NavigationLink("", destination: AddNoteView(objViewModel: listaNotasViewModel, bShow: $bLinkEdit), isActive: $bLinkEdit)
                        } label: {
                            Label {
                                Text("Editar")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        .tint(.orange)
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        listaNotasViewModel.bEdit = false
                        listaNotasViewModel.setData(nota: nil)
                        bLinkAdd.toggle()
                    } label: {
                        HStack {
                            Label("Add Note", systemImage: "plus")
                            Spacer()
                        }
                    }
                    .background(
                        NavigationLink("", destination: AddNoteView(objViewModel: listaNotasViewModel, bShow: $bLinkAdd), isActive: $bLinkAdd)
                    )
                }
            }
            .navigationTitle("Notas")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListaNotasView()
    }
}
