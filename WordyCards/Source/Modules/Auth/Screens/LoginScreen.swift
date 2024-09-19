//
//  LoginScreen.swift
//  WordyCards
//
//  Created by Sebastian on 24/08/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var loginForm = LoginFormViewModel()
    @EnvironmentObject var router: AuthRouter
    
    var body: some View {
        VStack(){
            VStack(spacing:30){
                HStack(){
                    Image("Icon")
                    Spacer()
                }
                
                HStack(){
                    Text("Inicia sesion").typography(.bold, 40)
                    Spacer()
                }
            }.padding(.bottom, 40)
            
            TextFieldView(
                label: "Tu correo",
                placeholder: "Email",
                hasError: !loginForm.isEmailValid && loginForm.isPressedSubmit,
                errorMessage: "Ingresa un correo valido",
                value: $loginForm.email)
            
            TextFieldView(
                label: "Contraseña",
                placeholder: "******",
                isSecure: true,
                hasError: !loginForm.isPasswordValid && loginForm.isPressedSubmit,
                errorMessage: "Este campo es requerido",
                value: $loginForm.password)
            
            
            ButtonView(
                label: "Ingresar",
                isLoading: authViewModel.isLoading,
                action: {
                    loginForm.isPressedSubmit = true
                    Task{
                        if(loginForm.isEmailValid && loginForm.isPasswordValid){
                            await authViewModel.login(credentials: LoginBodyRequest(email: loginForm.email, password: loginForm.password))
                        }
                    }
                })
            
            ButtonView(label: "Registrarse", isOutline: true, action: {
                router.navigateTo(route: .register)
            })
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .background(.backgroundSecondary)
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
    LoginScreen()
        .environmentObject(AuthViewModel())
        .environmentObject(AuthRouter())
}
