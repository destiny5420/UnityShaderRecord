﻿Shader "Sikapaper/Cutout"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[Header(Cutout Visuals)]
		_CutTex ("CutoutTexture", 2D) = "white" {}
		_CutValue ("CutRange", Range(0, 1)) = 0
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

			sampler2D _MainTex;
			sampler2D _CutTex;
			float _CutValue;

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
