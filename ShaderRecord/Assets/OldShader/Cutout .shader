// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "OldShader/Cutout"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_CutTex("CutoutTexture", 2D) = "white" {}
		_CutValue("CutRange", Range(0, 1)) = 0
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" }

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// Step 1
			struct appdata
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			// Step 3
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _CutTex;
			float4 _CutTex_ST;

			float _CutValue;

			// Step 2
			v2f vert(appdata v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				// Step 5
				float4 cutoutTextureColor = tex2D(_CutTex, i.uv);

				// 不算出負值部分
				clip(cutoutTextureColor - (_CutValue * 1.01));

				float4 endTextureColor = tex2D(_MainTex, i.uv);
				return endTextureColor;
			}
			ENDCG
		}
	}
}
