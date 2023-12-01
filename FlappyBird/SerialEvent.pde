void serialEvent(Serial port)
{
  try {
    // シリアル通信受信地格納用
    String inString = port.readStringUntil('\n');

    if (inString != null) {
      inString = trim(inString);
      println(inString);
      float[] serialData = float(split(inString, ','));
      println(serialData);
      keys.setStateSensor(serialData);
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}
