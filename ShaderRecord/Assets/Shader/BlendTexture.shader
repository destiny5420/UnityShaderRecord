Shader "Sikapaper/BlendTexture"
{
	Properties
	{
		_FirstTex ("FirstTexture", 2D) = "white" {}
		_SecondTex ("SecondTexture", 2D) = "white" {}
		_BlendAmount ("BlendAmount", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// Step 1
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			// Step 3
			struct v2f
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _FirstTex;
			sampler2D _SecondTex;
			float _BlendAmount;

			// Step 2
			v2f vert (appdata v)
			{
				v2f OUT;

				OUT.position = UnityObjectToClipPos(v.vertex);
				OUT.uv = v.uv;

				return OUT;
			}

			// Step 4
			fixed4 frag (v2f i) : SV_Target
			{
				// Step 5
				float4 fFirstColor = tex2D(_FirstTex, i.uv);
				float4 fSecondColor = tex2D(_SecondTex, i.uv);
				float4 fEndColor = lerp(fFirstColor, fSecondColor, _BlendAmount);

				return fEndColor;
			}
			ENDCG
		}
	}
}
