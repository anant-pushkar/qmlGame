
var score=0;
var xVal=100;
var yVal=100;
var xOffset=20;
var isActive=0;
function checkCollision(){
    if(isActive==1){
        if(rect2.x-rect1.x<200 && rect2.x-rect1.x>-200 && rect2.y-rect1.y<200 && rect2.y-rect1.y>-200){
           score--;
           indicator.color = "red"
            if(rect2.x-rect1.x<100 && rect2.x-rect1.x>-100 && rect2.y-rect1.y<100 && rect2.y-rect1.y>-100)
                spaceShip.opacity=0.6
            else
                spaceShip.opacity=0.8
       }else{
           indicator.color = "blue"
            spaceShip.opacity=1.2
       }
        scoreText.text = score
        if(score>100)
            health.color="green"
        else if(score>0){
            health.color="yellow"
        }
        else if(score>-200){
            health.color="orange"
        }
        else
            health.color="red"
        showfuel();
    }
}

function showfuel(){
    if(isActive==1){
        if(score>0){
            danger.width=0;
            safe.width=score<400?score:400;
        }else{
            safe.width=0;
            danger.width = score>-400 ? -score : 400;
            danger.x = backgroundImg.width/2-danger.width;
        }
    }
}

function moveLeft(){
    if(isActive==1)xVal-=100;
}

function moveRight(){
    if(isActive==1)xVal+=100;
}

function moveUp(){
    if(isActive==1)yVal-=100;
}

function moveDown(){
    if(isActive==1)yVal+=100;
}
