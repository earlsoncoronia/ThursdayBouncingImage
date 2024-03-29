
/*
 * Main.eq
 * Generated by Eqela Studio 2.0b7.4
 */

public class Main : SEScene
{
	SESprite bg;
	SESprite fg;
	SESprite text;

	String display;
	bool move_right=true;
	bool move_left=false;
	bool move_up=false;
	bool move_down=true;
	int speed=50;
	double rotation=0;
	int bounce=0;
	
		
	public void initialize(SEResourceCache rsc)
	{
		base.initialize(rsc);
		rsc.prepare_font("myfont", "arial bold color=white",60);
		
		bg = add_sprite_for_color(Color.instance("#9900CC"), get_scene_width(), get_scene_height());
		bg.move(0,0);
		
	//	fg = add_sprite_for_color(Color.instance("green"), get_scene_width()*0.1, get_scene_height()*0.1);
	//	fg.move(100,100);
		
		text = add_sprite_for_text("Bouncing Rectangle", "myfont");
		text.move(0, get_scene_height()-text.get_height());

		display = "Bounces= %d".printf().add(Primitive.for_integer(bounce)).to_string();

		rsc.prepare_image("myimage","JokerFace", get_scene_width()*0.1);
		fg = add_sprite_for_image(SEImage.for_resource("myimage"));
		fg.move(100,100);
		
	}

	public void update(TimeVal now, double delta)
	{
		
		base.update(now,delta);
		speed+=100;
		rotation+=MathConstant.M_PI_4 / 4;
		fg.set_rotation(rotation);
		
		if(move_right)
		{
			fg.move(fg.get_x()+delta*speed,fg.get_y());
			if(fg.get_x()+fg.get_width() > get_scene_width())
			{
				bounce++;
				display = "Bounces= %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				speed=50;
				move_right=false;
				move_left=true;
			}

		}
					
		if(move_left)
		{
			fg.move(fg.get_x()-delta*speed,fg.get_y());
			if(fg.get_x()< 0)
			{
				bounce++;
				display = "Bounces= %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				speed=50;
				move_right=true;
				move_left=false;
			}
		}

		if(move_down)
		{
			fg.move(fg.get_x(),fg.get_y()+delta*speed);
			if(fg.get_y()+fg.get_height() > get_scene_height())
			{
				bounce++;
				display = "Bounces= %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				speed=50;
				move_down=false;
				move_up=true;
			}
		}
		
		if(move_up)
		{
			fg.move(fg.get_x(),fg.get_y()-delta*speed);
			if(fg.get_y() < 0)
			{
				bounce++;
				display = "Bounces= %d".printf().add(Primitive.for_integer(bounce)).to_string();
				text.set_text(display);
				
				speed=50;
				move_down=true;
				move_up=false;
			}
		}
	}
	
	public void set_rotation(double angle)
	{
		rotation = angle;
	}

	public double get_rotation()
	{
		return(rotation);
	}

	public void cleanup()
	{
		base.cleanup();
		SESprite.remove(bg);
		SESprite.remove(fg);
		SESprite.remove(text);
	}
}
