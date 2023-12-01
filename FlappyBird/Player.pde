public class Player {
    private PVector pos;
    private PVector vec;
    private final int SPEED = 4;
    Track track;

    private Player(float x, float y) {
        pos = new PVector(x, y);
        vec = new PVector(0, 0);
        track = new Track();
    }

    public void draw() {
        update();
        push();
        track.draw();
        image(fileIO.planeImage, pos.x-fileIO.planeImage.width/2, pos.y-fileIO.planeImage.height/2);
        //noFill();
        //stroke(200, 200, 0);
        //strokeWeight(2);
        //circle(pos.x, pos.y, fileIO.planeImage.height);
        pop();
    }

    private void update() {
        if (IS_CONTROLLER) {
            if (keys.getStateController()) {
                vec.y = -SPEED;
            } else {
                vec.y = SPEED;
            }
        } else {
            if (keys.getStateSymbol("SPACE")) {
                vec.y = -app.gameSpeed;
            } else {
                vec.y = app.gameSpeed;
            }
        }
        pos.add(vec);
        track.addPoint(pos.x, pos.y);
    }

    public PVector getPos() {
        return pos;
    }
}
