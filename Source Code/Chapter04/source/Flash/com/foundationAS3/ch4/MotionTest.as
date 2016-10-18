package com.foundationAS3.ch4 {
    import flash.display.MovieClip;
    import fl.motion.Animator;

    public class MotionTest extends MovieClip {

        private var ball_animator:Animator;

        public function MotionTest() {
            // Create and position ball
            var ball:Ball = new Ball();
            addChild(ball);
            ball.x = 50;
            ball.y = 150;

            var ball_xml:XML = <Motion duration="24" xmlns="fl.motion.*" xmlns:geom="flash.geom.*" xmlns:filters="flash.filters.*">
                <source>
                    <Source frameRate="12" x="50" y="50" scaleX="1" scaleY="1" rotation="0" elementType="movie clip" symbolName="Ball" class="Ball">
                        <dimensions>
                            <geom:Rectangle left="-25" top="-25" width="50" height="50"/>
                        </dimensions>
                        <transformationPoint>
                            <geom:Point x="0.5" y="0.5"/>
                        </transformationPoint>
                    </Source>
                </source>

                <Keyframe index="0" tweenSnap="true" tweenSync="true">
                    <tweens>
                        <SimpleEase ease="0"/>
                    </tweens>
                </Keyframe>

                <Keyframe index="12" tweenSnap="true" tweenSync="true" x="450">
                    <tweens>
                        <SimpleEase ease="0"/>
                    </tweens>
                </Keyframe>

                <Keyframe index="23" x="0"/>
            </Motion>;

            ball_animator = new Animator(ball_xml, ball);
            ball_animator.autoRewind = true;
            ball_animator.repeatCount = 0;
            ball_animator.play();
        }

    }
}