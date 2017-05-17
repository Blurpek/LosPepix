using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerJump : MonoBehaviour
{

    public float jumpForce = 10f;

    private Rigidbody2D rb2D;

    void Start()
    {
        rb2D = GetComponent<Rigidbody2D>();
    }

    void FixedUpdate()
    {
        if (Input.GetButtonDown("Jump"))
        {
            Vector2 movement = new Vector2(0.0f, jumpForce);
            rb2D.AddForce(movement);
            Debug.Log("dziala!");
        }
    }
}
