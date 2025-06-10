using Godot;
using System;

public partial class Turret : Node2D
{
	[Export] private Node2D Head;
	[Export] private PackedScene bulletPrefab;

	private AnimatedSprite2D anim;
	private Marker2D bulletSpawnPos;

	public override void _Ready()
	{
		base._Ready();
		anim = GetNode<AnimatedSprite2D>("Visuals/Head/HitFlashAnim");
		bulletSpawnPos = GetNode<Marker2D>("Visuals/Head/Bullet Spawn Position");
	}



	public override void _Process(double delta)
	{
		RotateHandler();
		if (Input.IsActionJustPressed("ui_accept"))
		{
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		anim.Play();

		// Bullet'ı sahneye instantiate et
		Node2D bullet = bulletPrefab.Instantiate<Node2D>();

		// Başlangıç pozisyonu: Head'in ucundan olsun
		bullet.GlobalPosition = bulletSpawnPos.GlobalPosition;

		// Mermi yönü: Head'in baktığı yön (Head'in yukarı bakan hali baz alınır)
		 Vector2 direction = -Head.Transform.Y.Normalized();
		
		// Bullet sahnesine yönü set edelim (set_bullet_dir() metodunun tanımlı olduğunu varsayıyorum)
		bullet.Call("set_bullet_dir", direction);

		// Sahneye ekle (genellikle en üst seviye node'a)
		GetTree().Root.AddChild(bullet);
	}


	private void RotateHandler()
	{
		Vector2 toMouse = GetGlobalMousePosition() - Head.GlobalPosition;
		// Yukarıya göre açıyı al (0 derece = yukarı)
		float angle = Mathf.RadToDeg(Mathf.Atan2(toMouse.X, -toMouse.Y));
		// Clamp ile -90 / +90 derece aralığına sınırlıyoruz
		float clamped = Mathf.Clamp(angle, -90f, 90f);
		Head.RotationDegrees = clamped;
	}
}
