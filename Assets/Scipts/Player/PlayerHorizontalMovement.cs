using UnityEngine;
using System.Collections;

public class PlayerHorizontalMovement : MonoBehaviour
{

    public float speed;

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
    }
}