import { LightningElement } from 'lwc';
import callGeminiApi from '@salesforce/apex/GeminiService.callGeminiApi';

export default class AskGoogleGemini extends LightningElement {
    question;
    response;
    showResponse=false;
    handleInputChange(event){
        this.question = event.target.value;
        console.log('value change: '+this.question);
        
    }
    async handleClick(event){
        console.log('in click');
        
        try{
            if(this.question != null){
                const res = await callGeminiApi({question: this.question});
                const parsed = JSON.parse(res);
                this.response = parsed.candidates[0].content.parts[0].text;
                this.showResponse = true;
                this.question = null;
            }
        } catch(e){
            console.log('exception: '+e.body.message);
            
        }
        
    }
}