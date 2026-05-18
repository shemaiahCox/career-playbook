using UnityEngine;

/// <summary>
/// Beginner lab: see how Unity calls your code every frame vs every physics step.
/// Attach this to any GameObject in an empty scene and press Play.
/// </summary>
public class SampleGameLoop : MonoBehaviour
{
    // [SerializeField] exposes private fields to the Inspector (good encapsulation habit).
    [SerializeField]
    [Tooltip("Degrees per second around the X axis — uses deltaTime so FPS does not change speed.")]
    private float rotationDegreesPerSecond = 45f;

    [SerializeField]
    [Tooltip("How many physics steps have run — compare to Update call count in the debugger.")]
    private int fixedUpdateCounter;

    [SerializeField]
    private int updateCounter;

    // Awake runs once when the scene loads — even if the GameObject starts disabled.
    private void Awake()
    {
        Debug.Log($"{nameof(SampleGameLoop)}: Awake — object ID {GetInstanceID()}");
    }

    // Start runs before the first Update, after all Awakes in the scene.
    private void Start()
    {
        Debug.Log($"{nameof(SampleGameLoop)}: Start");
    }

    /// <summary>
    /// Called every render frame — frequency matches your monitor / vsync settings.
    /// Good for input polling and visuals that must feel smooth.
    /// </summary>
    private void Update()
    {
        updateCounter++;

        // Time.deltaTime is seconds since last frame (~0.016 at 60 FPS).
        float delta = Time.deltaTime;

        // Frame-rate independence: multiply rate *per second* by *seconds elapsed this frame*.
        float degreesThisFrame = rotationDegreesPerSecond * delta;
        transform.Rotate(Vector3.right, degreesThisFrame, Space.Self);

        // Example: lightweight input (jump to richer patterns later).
        if (Input.GetKeyDown(KeyCode.Space))
        {
            Debug.Log("Space pressed — read in Update()");
        }
    }

    /// <summary>
    /// Called on a fixed timestep (default 0.02s → 50 Hz) for physics coherence.
    /// Use when applying Rigidbody forces so all colliders agree on time stepping.
    /// </summary>
    private void FixedUpdate()
    {
        fixedUpdateCounter++;
        // Intentionally no rotation here — compare counters in the Inspector under Play Mode.
        // Uncomment to experiment with physics-clock driven motion:
        // rigidbody.MoveRotation(rigidbody.rotation * Quaternion.Euler(0f, rotationDegreesPerSecond * Time.fixedDeltaTime, 0f));
    }
}
