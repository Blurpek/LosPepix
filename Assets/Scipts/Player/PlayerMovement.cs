using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour
{

    public float speed;
    public float jumpForce = 10f;

    private Rigidbody2D rb2D;

    void Start()
    {
        rb2D = GetComponent<Rigidbody2D>();
    }

    void FixedUpdate()
    {
        float moveHorizontal = Input.GetAxis("Horizontal");
        Vector2 movement = new Vector2(moveHorizontal, 0.0f);
        rb2D.AddForce(movement * speed);
        if (isGrounded())
        {
            if (Input.GetButtonDown("Jump"))
            {
                Vector2 jump = new Vector2(0.0f, jumpForce);
                rb2D.AddForce(jump);
            }
        }
    }

    bool isGrounded()
    {
        if(rb2D.velocity.y == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}