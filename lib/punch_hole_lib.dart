import 'dart:io';
import 'dart:isolate';

Future<void> runServerSock(int port) async{
  var servSock = await ServerSocket.bind("0.0.0.0", port, shared: true);
  servSock.listen(
    (event) { print(event);},
    onError: (error){print(error);},
    onDone: (){
      print("server left");
      servSock.close();
    }
  );
}

Future<bool> punchHoleToPeer(
    InternetAddress peerIP,
    int peerPort,
    int hostPort,
    {int retries = 10 }
) async{
  print(peerIP);
  print(peerPort);
  print(hostPort);
  int currTry = 0;
  Socket? sendSock;
  //var tIso = await Isolate.spawn(runServerSock, hostPort);
  while (currTry < retries){
    try {
      sendSock = await Socket.connect(
          peerIP, peerPort,
          sourcePort: hostPort,
          timeout: const Duration(seconds: 2)
      );
      sendSock.write("lmaolmao");
      var subscription = sendSock.listen(
              (event) { print(event);},
          onError: (error){print(error);},
          onDone: (){
            print("server left");
            sendSock?.destroy();
          }
      );
      await Future.delayed(const Duration(seconds: 2));
      subscription.cancel();
      sendSock.destroy();
    }
    catch (e){
      print(e);
      sendSock?.destroy();
      sendSock = null;
    }
    currTry += 1;
    await Future.delayed(const Duration(seconds: 2));
  }
  //tIso.kill(priority: Isolate.immediate);
  return false;
}