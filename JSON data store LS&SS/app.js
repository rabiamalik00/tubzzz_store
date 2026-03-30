
var data=fetch('data.json');

data.then((data)=>{


    return data.json()

    }).then((data)=>{

        console.log(response1)
        localStorage.setItem('jsondata1',json.stringify(data))
        sessionStorage.setItem('jsondata1',json.stringify(data))
})