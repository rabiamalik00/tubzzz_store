
var data=fetch('data.json');

data.then((response1)=>{


    return response1.json();

    }).then((response1)=>{

        
        console.log(response1);
        localStorage.setItem('jsondata',JSON.stringify(response1))
        sessionStorage.setItem('jsondata',JSON.stringify(response1))

})