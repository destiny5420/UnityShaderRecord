# UnityShaderRecord
This is shader record for myself.

1. VertexScaleByTime (模型的Mesh根據遊戲時間而改變頂點大小) <br />
-------------

此Shader主要是在Vertex轉換成Fragment階段,讓Vertex根據時間而有所變化<br />

* _Time.y: 這邊就是遊戲的時間,會一直蕾加上去<br />
* Sin: 隨著時間不同做變化, Max:1  Min:-1<br />
