
document.getElementById('btn').addEventListener('click',()=>{

    fetch('https:/uselessfacts.jsph.pl/random.json?language=en')
    .then(response=>{
        return response.json();
    })
    .then(data=>{
        document.getElementById('factdisplay').textContent=data.text;

    })
});