// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "OldShader/VectexScaleByTime"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ScaleValue("ScaleValue", Range(0, 5)) = 1
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

			float _ScaleValue;

			// Step 2
			v2f vert(appdata v)
			{
				v2f o;

				v.vertex.xyz *= sin(_Time.y);

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				fixed4 fEndColor = tex2D(_MainTex, i.uv);
				return fEndColor;
			}
			ENDCG
		}
	}
}
