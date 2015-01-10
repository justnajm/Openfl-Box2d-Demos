import box2D.dynamics.*;
import box2D.collision.*;
import box2D.collision.shapes.*;
import box2D.dynamics.joints.*;
import box2D.dynamics.contacts.*;
import box2D.common.*;
import box2D.common.math.*;

class ContactListenerBreakable extends B2ContactListener
{
	private var test:TestBreakable;
	public function new(test:TestBreakable)
	{
		super();
		this.test = test;
	}
	
	override public function postSolve(contact:B2Contact, impulse:B2ContactImpulse):Void 
	{
		if (test.m_broke)
		{
			// The body already broke
			return;
		}
		
		// Should the body break?
		var count:Int = contact.getManifold().m_pointCount;
		
		var maxImpulse:Float = 0.0;
// 		for (var i:int = 0; i < count; i++)
		for(i in 0...count)
		{
			maxImpulse = B2Math.max(maxImpulse, impulse.normalImpulses[i]);
		}
		
		if (maxImpulse > 50)
		{
			test.m_break = true;
		}
	}
}