I'm trying to recreate this in Flutter:

https://codepen.io/cassidoo/pen/KRdLvL

![gif of codepen](http://res.cloudinary.com/ericwindmill/image/upload/c_scale,w_500/v1524935504/flutter_by_example/inspiration.gif)

### This is what I have:
![first gif of so far](http://res.cloudinary.com/ericwindmill/image/upload/v1524935505/flutter_by_example/so_far.gif)

The problem with this approach is that I need there to be **six** animation steps, rather than four.
That way, I could make the first and last bar do full turns, and the animation would start over after the sixth step,
which is second time the second bar turns.

I can't figure out how to pass multiple animations to a single bar, or have an animation that works in intervals.
i.e. If I could have bar two animation from `.3` to `.4` and from `.7` to `.8`.
 
### Another approach, (which is mainly commented out in the code), looks like this.
![second approach gif](http://res.cloudinary.com/ericwindmill/image/upload/v1524935505/flutter_by_example/other_approach.gif)

Basically, I'm using two different animations - a forward animation and a backward anmaition.

The issue I'm finding here is *mainly* that I'm using setState, and there for repainting the bars back into their original position.
I cant figure out how to keep the bars in their end positions from animation one.


