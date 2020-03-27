using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AddressableAssets;

public class UserDatabase : ScriptableObject
{
    static public bool loaded { get { return m_Loaded; } }

    static protected bool m_Loaded = false;
    static protected Dictionary<string, UserData> _usersDict;

    public static IEnumerator Load()
    {
        if (_usersDict == null)
        {
            _usersDict = new Dictionary<string, UserData>();

            yield return Addressables.LoadAssetsAsync<UserData>("userData", op =>
            {
                if (op != null)
                {
                    if (!_usersDict.ContainsKey(op.email))
                        _usersDict.Add(op.email, op);
                }
            });

            m_Loaded = true;
        }
    }

    static public List<UserData> GetAll() {
        return (m_Loaded) ? new List<UserData>(_usersDict.Values) : null;
    }

    static public UserData GetUser(string email)
    {
        UserData data;

        if (_usersDict == null || !_usersDict.TryGetValue(email, out data))
            return null;

        return data;
    }
}
