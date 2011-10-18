package code.system 
{
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Score extends Object
	{
		public var name:String; //Name of player
		public var points:Number; //Score of player
		public var time:Number; //Time taken in seconds
		
		public function Score(_name:String, _points:Number, _time:Number) 
		{
			name = _name;
			points = _points;
			time = _time;
		}
		
	}

}