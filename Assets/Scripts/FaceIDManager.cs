using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

public class FaceIDManager : MonoBehaviour
{
    public Text infoText;

    string state;
    string hasFaceID;
    string success;

    [DllImport("__Internal")]
    private static extern void setup();

    [DllImport("__Internal")]
    private static extern void faceLogin();

    public void FaceLogin()
    {
#if UNITY_IOS && !UNITY_EDITOR
        faceLogin();
#endif
    }

    public void SetAuthState(string state)
    {
        this.state = state;
    }

    public void SetHasFaceID(string value)
    {
        this.hasFaceID = value;
    }

    public void SetLoginSuccess(string success)
    {
        this.success = success;
    }
    private void Awake()
    {
        StartCoroutine(UserDatabase.Load());
#if UNITY_IOS && !UNITY_EDITOR
        setup();
#endif
    }
    
    private void Update()
    {
        if (UserDatabase.loaded)
        {
            foreach (UserData user in UserDatabase.GetAll())
            {
                Debug.Log(user.email);
            }
        }
        infoText.text = string.Format("state: {0},\nhasFaceID: {1},\nsuccess: {2}", state, hasFaceID, success);
    }

}
