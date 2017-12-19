// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "OldShader/BlendTexture"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("SecondTexture", 2D) = "white" {}
		_BlendAmount("BlendAmount", Range(0, 1)) = 0.5
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

			sampler2D _SecondTex;
			float4 _SecondTex_ST;

			float _BlendAmount;

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
				fixed4 fFirstColor = tex2D(_MainTex, i.uv);
				fixed4 fSecondColor = tex2D(_SecondTex, i.uv);
				fixed4 fEndColor = lerp(fFirstColor, fSecondColor, _BlendAmount);
				return fEndColor;
			}
			ENDCG
		}
	}
}
