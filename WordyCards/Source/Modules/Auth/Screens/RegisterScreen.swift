//
//  RegisterScreen.swift
//  WordyCards
//
//  Created by Sebastian on 3/09/24.
//

import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var registerForm = RegisterFormViewModel()
    @EnvironmentObject var router: AuthRouter
    
    var body: some View {
        VStack(){
            VStack(spacing:30){
                HStack(){
                    Button(action: {router.navigateBack()}, label: {
                        Image(systemName: "arrow.backward").typography(.bold, 30)
                    })
                    
                    Spacer()
                    Image("Icon")
                }
                
                HStack(){
                    Text("Registrarse").typography(.bold, 40)
                    Spacer()
                }
            }.padding(.bottom, 40)
            
            TextFieldView(
                label: "Nombre",
                placeholder: "Tu nombre",
                hasError: !registerForm.isNameValid && registerForm.isPressedSubmit,
                errorMessage: "El nombre debe tener minimo 3 caracteres",
                value: $registerForm.name)
            
            TextFieldView(
                label: "Tu correo",
                placeholder: "Email",
                hasError: !registerForm.isEmailValid && registerForm.isPressedSubmit,
                errorMessage: "Ingresa un correo valido",
                value: $registerForm.email)
            
            TextFieldView(
                label: "Contraseña",
                placeholder: "******",
                isSecure: true,
                hasError: !registerForm.isPasswordValid && registerForm.isPressedSubmit,
                errorMessage: "La contraseña debe tener minimo 6 caracteres",
                value: $registerForm.password)
            
            TextFieldView(
                label: "Confirma la contraseña",
                placeholder: "******",
                isSecure: true,
                hasError: !registerForm.isConfirmPasswordValid && registerForm.isPressedSubmit,
                errorMessage: "Las contraseñas no coinciden",
                value: $registerForm.confirmPassword)
            
            
            ButtonView(
                label: "Registrarse",
                isLoading: authViewModel.isLoading,
                action: {
                    registerForm.isPressedSubmit = true
                    Task{
                        if(registerForm.isValidForm){
                            let isSuccess = await authViewModel.register(data: RegisterBodyRequest(
                                name: registerForm.name,
                                email: registerForm.email,
                                password: registerForm.password,
                                confirmPassword: registerForm.confirmPassword)
                            )
                            
                            if(isSuccess){
                                router.navigateBack()
                            }
                        }
                    }
                })
            
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(.backgroundSecondary)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $authViewModel.showAlert) {
            Alert(
                title: Text("Algo salio mal"),
                message: Text(authViewModel.errorMessage ?? "Error desconocido"),
                dismissButton: .default(Text("Cerrar")) {
                    authViewModel.errorMessage = nil
                    authViewModel.showAlert = false
                }
            )
        }
    }
}

#Preview {
    RegisterScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(AuthRouter())
}
