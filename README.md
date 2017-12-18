# UnityShaderRecord
This is shader record for myself.

> ### VertexScaleByTime (模型的Mesh根據遊戲時間而改變頂點大小) <br />
> 此Shader主要是在Vertex轉換成Fragment階段,讓Vertex根據時間而有所變化<br />
> * _Time.y: 這邊就是遊戲的時間,會一直蕾加上去<br />
> * Sin: 隨著時間不同做變化, Max:1  Min:-1<br />

> ### BlendTexture (控制參數讓物件貼圖從第一張切換至第二張) <br />
> 此Shader主要是在Fragment階段,讓第一張貼圖及第二張貼圖轉換成float之後<br />
> 使用lerp以及_BlendAmount參數控制顯示哪張貼圖<br />
> * _FirstTex: 第一張貼圖<br />
> * _SecondTex: 第二張貼圖<br />
> * _BlendAmount: 控制顯示貼圖的參數<br />

> ### RampTexture (色階貼圖混合模型顏色) <br />
> 此Shader主要是利用一張色階貼圖在原本的貼圖上製作混色效果<br />
> * _MainTex: 主要貼圖<br />
> * _ColorRampTex: 色階貼圖<br />
> * _ColorRampEvaluationX: 取得色階貼圖UV的X座標<br />
> * _ColorRampEvaluationY: 取得色階貼圖UV的Y座標<br />
>
> ![Alt text](https://drive.google.com/uc?export=view&id=18CvXxMejbc9FZi8hBa0reo79IK48dg8B)<br />

> ### Cutout (利用一張黑白漸層的貼圖做透空效果) <br />
> 此Shader主要是在最後Fragment階段,利用clip讀取黑白貼圖,負值不渲染的手法達到透空<br />
> 當_CutValue = 0時，沒有東西被剔除<br />
> 當_CutValue = 0.1時，黑色部分被剔除<br />
> 當_CutValue = 0.1 ~ 0.9時，黑色及灰色部分被剔除<br />
> 當_CutValue = 1時，黑色、灰色及白色部分被剔除<br />
> * _MainTex: 主要貼圖<br />
> * _CutTex: 剔除黑白貼圖<br />
> * _CutValue: 控制透空多寡的參數<br />
