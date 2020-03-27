using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LoginUI : MonoBehaviour
{
    public LoginSystem loginSystem;
    public InputField emailField;
    public InputField passwordField;
    public Button loginButton;

    private void Awake()
    {
        loginButton.interactable = false;
    }
    public void OnInputEndEdit(string value)
    {
        loginButton.interactable = !string.IsNullOrEmpty(emailField.text) && !string.IsNullOrEmpty(passwordField.text);
    }
    public void Login()
    {

    }
}
