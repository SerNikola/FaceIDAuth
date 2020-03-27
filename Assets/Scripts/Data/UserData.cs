using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "userData", menuName ="Yord/User Data")]
public class UserData : ScriptableObject
{
    public string email;
    public string password;
}
