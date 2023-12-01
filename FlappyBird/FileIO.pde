public class FileIO {
    public PImage planeImage;
    public PImage[] planetImages; 
    
    FileIO() {
        planeImage = loadImage("./images/plane.png");
        planeImage.resize(floor(planeImage.width*0.3), floor(planeImage.height*0.3));
        planetImages = new PImage[6];
        for(int i=0; i<planetImages.length; i++) {
            planetImages[i] = loadImage("images/planet"+i+".png");
        }
    }
}
