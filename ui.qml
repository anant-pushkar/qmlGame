import Qt 4.7
import "variables.js" as GameScript

Rectangle {
  width: 640
  height: 480
  id:background
  Image {
      id: backgroundImg
      source: "qrc:/bg"
      height: parent.height
      width: parent.width
  }

  Rectangle{
      color: "#999999"
      opacity: 0.5
      z: 20
      id:instructions
      x:100
      width: backgroundImg.width-200
      y:100
      height: backgroundImg.height-200
      Behavior on x {SpringAnimation { spring: 2; damping: 0.2 }}
      Text {
          text: "<h1>Fuel up!</h1><br>
                    This is 2050 and Earth has seen a major attack from the martians to take<br>
                    away all the sources of energy we have. As the captain of the last human <br>
                    ship left, you manage to damage one of the last martian cargo taking off<br>
                    which spilled away a few fuel pods into the outer space. Your job is to  <br>
                    collect asmany fuelpods as you can for your planet by bringing themclose to <br>
                    the fuel-collector at the back of your ship. But beware of the <br>
                    fuel sucking space monsters.<br><br>
                    Press space to start game<br> press Esc to minimize game."
          opacity:1
          font.pointSize: 24
          z: 21
          color: "black"
          anchors{
              left:parent.left +10
              bottom: parent.bottom -200
          }

          textFormat: Text.RichText
          font.bold: true
        }

  }

  Rectangle {
       id:indicator
       width: 70; height: 70
       color: "blue"
       Rectangle {
            id:health
            x:10
            y:10
            width: 50; height: 50
            color: "blue"
            Text {
                text: "Score"
                font.pointSize: 10
                x:0
                z: 20
                color: "black"
                textFormat: Text.RichText
                font.bold: true
              }
           Text {
               text: "0"
               font.pointSize: 24
               z: 20
               color: "black"
               anchors.centerIn: parent
               id:scoreText
               textFormat: Text.RichText
               font.bold: true
             }
           Rectangle{
               x:backgroundImg.width/2
               y:10
               height: 20
               color: "red"
               id: danger
           }
           Text {
               text: "Fuel Level"
               font.pointSize: 10
               x:safe.x-40
               y:40
               z: 20
               color: "white"
               textFormat: Text.RichText
               font.bold: true
             }
           Rectangle{
               x:backgroundImg.width/2
               y:10
               height: 20
               color: "blue"
               id: safe
           }
       }

       Rectangle {
           id: rect2
           width: 100; height: 100
           x: rect1.x - 5; y: rect1.y - 5
           color: "transparent"
           Image {
               id: demon
               smooth: true
               source: "qrc:/demon"
               height: parent.height
               width: parent.width
               opacity: 0.7


           }

           Behavior on x {
               SmoothedAnimation {
                   velocity: 100
                   onRunningChanged: {
                       scoreText.text = GameScript.score
                       if(GameScript.score>100)
                           health.color="green"
                       else if(GameScript.score>0){
                           safe.width=GameScript.score*3
                       }
                       else if(GameScript.score>-200){
                           health.color="orange"
                       }
                       else
                           health.color="red"
                       GameScript.checkCollision()
                       GameScript.showfuel()
                   }
               }
           }
           Behavior on y {
               SmoothedAnimation {
                   velocity: 100
                   onRunningChanged: {
                       scoreText.text = GameScript.score
                       if(GameScript.score>100)
                           health.color="green"
                       else if(GameScript.score>0){
                           safe.width=GameScript.score*3
                       }
                       else if(GameScript.score>-200){
                           health.color="orange"
                       }
                       else
                           health.color="red"
                       GameScript.checkCollision()
                       GameScript.showfuel()
                   }
               }
           }
       }

       Rectangle {
           id: rect1
           width: 160; height: 160
           color: "transparent"
           Image {
               id: spaceShip
               smooth: true
               source: "qrc:/spaceShipSprites/ship"
               height: parent.height
               width: parent.width


           }
           x:GameScript.xVal
           y:GameScript.yVal

           Behavior on x {SpringAnimation { spring: 2; damping: 0.2 }}

           Behavior on y {SpringAnimation { spring: 2; damping: 0.2 }}

           Behavior on opacity {SpringAnimation { spring: 2; damping: 0.2 }}
       }

       Rectangle{
           width:60
           height:60
           id:food1
           x:-10
           y:200
           color: "transparent"
           Image {
               id: fuel
               source: "qrc:/spaceShipSprites/fuel"
               smooth: true
               height: parent.height
               width: parent.width

           }
           SmoothedAnimation on x {
                 to: food1.x+10;
                 velocity: 30
                 onRunningChanged: {
                     if(food1.x-rect1.x-60<40 && food1.x-rect1.x-60>-40 && food1.y-rect1.y-140<40 && food1.y-rect1.y-140>-40){
                         if(GameScript.isActive==1){
                             GameScript.score+=20
                            food1.x=-10
                            food1.y=(Math.floor(Math.random()*backgroundImg.height*0.8)+backgroundImg.height*0.1)
                            restart()
                         }
                     }
                     if(food1.x-rect1.x-140<100 && food1.x-rect1.x-140>-100 && food1.y-rect1.y-60<100 && food1.y-rect1.y-60>-100){
                         GameScript.xOffset*=-1;
                     }
                     GameScript.checkCollision()
                     GameScript.showfuel()
                 }

                 onCompleted: {
                     if(food1.x>backgroundImg.width)if(GameScript.isActive==1){
                        food1.y=(Math.floor(Math.random()*backgroundImg.height-400)+500)
                        food1.x=-10
                     }
                     restart()
                 }
               }
       }

       Rectangle{
           width:60
           height:60
           id:food2
           x:499
           y:300
           color: "transparent"
           Image {
               source: "qrc:/spaceShipSprites/fuel"
               smooth: true
               height: parent.height
               width: parent.width

           }
           SmoothedAnimation on x {
                 to: food2.x-10;
                 velocity: 50
                 onRunningChanged: {
                     if(food2.x-rect1.x-60<40 && food2.x-rect1.x-60>-40 && food2.y-rect1.y-140<40 && food2.y-rect1.y-140>-40){
                         if(GameScript.isActive==1){
                             GameScript.score+=13
                            food2.x=backgroundImg.width-100
                            food2.y=(Math.floor(Math.random()*backgroundImg.height*0.8)+backgroundImg.height*0.1)
                            restart()
                         }
                     }
                     if(food2.x-rect1.x-140<100 && food2.x-rect1.x-140>-100 && food2.y-rect1.y-60<100 && food2.y-rect1.y-60>-100){
                         GameScript.xOffset*=-1;
                     }
                     GameScript.checkCollision()
                     GameScript.showfuel()
                 }

                 onCompleted: {
                     if(food2.x<0)if(GameScript.isActive==1){
                        food2.y=(Math.floor(Math.random()*backgroundImg.height-400)+500)
                        food2.x=backgroundImg.width-400
                     }
                     restart()
                 }
               }
       }

       Rectangle{
           width:60
           height:60
           id:food3
           x:600
           y:700
           color: "transparent"
           Image {
               source: "qrc:/spaceShipSprites/fuel"
               smooth: true
               height: parent.height
               width: parent.width

           }
           SmoothedAnimation on x {
                 to: food3.x-10;
                 velocity: 90
                 onRunningChanged: {
                     if(food3.x-rect1.x-60<40 && food3.x-rect1.x-60>-40 && food3.y-rect1.y-140<40 && food3.y-rect1.y-140>-40){
                         if(GameScript.isActive==1){
                             GameScript.score+=40
                            food3.x=backgroundImg.width-100
                            food3.y=(Math.floor(Math.random()*backgroundImg.height*0.8)+backgroundImg.height*0.1)
                            restart()
                         }
                     }
                     if(food3.x-rect1.x-140<100 && food3.x-rect1.x-140>-100 && food3.y-rect1.y-60<100 && food3.y-rect1.y-60>-100){
                         GameScript.xOffset*=-1;
                     }
                     GameScript.checkCollision()
                     GameScript.showfuel()
                 }

                 onCompleted: {
                     if(food3.x<0)if(GameScript.isActive==1){
                        food3.y=(Math.floor(Math.random()*backgroundImg.height-400)+500)
                        food3.x=backgroundImg.width-400
                     }
                     restart()
                 }
               }
       }


       focus: true

       Keys.onRightPressed:{
           if(rect1.x<parent.width-100){
               if(GameScript.isActive==1)rect1.x+=100
           }
      }
       Keys.onLeftPressed:{
           if(rect1.x>50){
               if(GameScript.isActive==1)rect1.x-=100
           }
       }
       Keys.onUpPressed: {
           if(rect1.y>50){
                if(GameScript.isActive==1)rect1.y-=100
           }
       }
       Keys.onDownPressed: {
           if(rect1.y<parent.height-100){
               if(GameScript.isActive==1)rect1.y+=100
           }
       }
       Keys.onSpacePressed: {
           GameScript.isActive =( GameScript.isActive+1)%2;
           if(GameScript.isActive==1)
                instructions.x=-2000
           else
               instructions.x=100

       }
       Keys.onEscapePressed: {
           Qt.quit()
       }
   }


}
