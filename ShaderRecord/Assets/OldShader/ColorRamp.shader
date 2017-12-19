// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "OldShader/ColorRamp"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ColorRampTex("ColorRamTexture", 2D) = "white" {}
		_ColorRampEvaluationX("ColorRampEvaluationX", Range(0, 1)) = 0
		_ColorRampEvaluationY("_ColorRampEvaluationY", Range(0, 1)) = 0
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

			sampler2D _ColorRampTex;
			float4 _ColorRampTex_ST;

			float _ColorRampEvaluationX;
			float _ColorRampEvaluationY;

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
				fixed4 fMainTextureColor = tex2D(_MainTex, i.uv);
				
				float2 fPosUVOnRampColor = float2(_ColorRampEvaluationX, _ColorRampEvaluationY);
				fixed4 fRampTextureColor = tex2D(_ColorRampTex, fPosUVOnRampColor);

				fixed4 fEndColor = fMainTextureColor * fRampTextureColor;
				return fEndColor;
			}
			ENDCG
		}
	}
}
