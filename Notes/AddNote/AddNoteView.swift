import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var objViewModel: ListaNotasViewModel
    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 10)
            HStack {
                Text("Titulo:").padding(.leading, 15)
                    .foregroundColor(.red)
                TextField("Escribe un titulo creativo", text: $objViewModel.titulo)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            
            DatePicker("Seleciona", selection: $objViewModel.fecha)
                .padding()
                .foregroundColor(.red)
            
            Divider()
            TextEditor(text: $objViewModel.descripcion)
            Divider()
            
            Spacer()
            Button(objViewModel.bEdit ? "Actualizar" : "Guardar") {
                if objViewModel.bEdit {
                    objViewModel.updateNote(viewContext: viewContext)
                } else {
                    objViewModel.saveNote(viewContext: viewContext)
                }
            }
            .padding([.leading, .trailing], 50)
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(25)
            
            Spacer().frame(height: 20)
        }
        .navigationTitle(objViewModel.bEdit ?  "Edita la nota" : "Agrega una nota")
    }
    
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(objViewModel: ListaNotasViewModel())
    }
}
