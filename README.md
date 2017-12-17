# UnityShaderRecord
This is shader record for myself.

### VertexScaleByTime (模型的Mesh根據遊戲時間而改變頂點大小) <br />

> 此Shader主要是在Vertex轉換成Fragment階段,讓Vertex根據時間而有所變化<br />
> * _Time.y: 這邊就是遊戲的時間,會一直蕾加上去<br />
> * Sin: 隨著時間不同做變化, Max:1  Min:-1<br />

### BlendTexture (控制參數讓物件貼圖從第一張切換至第二張) <br />

> 此Shader主要是在Fragment階段,讓第一張貼圖及第二張貼圖轉換成float之後<br />
> 使用lerp以及_BlendAmount參數控制顯示哪張貼圖<br />
> * _FirstTex: 第一張貼圖<br />
> * _SecondTex: 第二張貼圖<br />
> * _BlendAmount: 控制顯示貼圖的參數<br />
