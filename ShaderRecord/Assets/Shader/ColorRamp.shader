Shader "Sikapaper/ColorRamp"
{
	Properties
	{
		_MainTex ("MainTexture", 2D) = "white" {}
		[NoScaleOffset]_ColorRampTex ("ColorRamTexture", 2D) = "white" {}
		_ColorRampEvaluationX ("ColorRampEvaluationX", Range(0, 1)) = 0.5
		_ColorRampEvaluationY ("ColorRampEvaluationY", Range(0, 1)) = 0.5
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
			sampler2D _ColorRampTex;
			float _ColorRampEvaluationX;
			float _ColorRampEvaluationY;

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
				float4 mainTextureColor = tex2D(_MainTex, i.uv);

				// get uv position
				float2 posUVOnRampTexture = float2(_ColorRampEvaluationX, _ColorRampEvaluationY);
				float4 rampTextureColor = tex2D(_ColorRampTex, posUVOnRampTexture);

				float4 endColor = mainTextureColor * rampTextureColor;

				return endColor;
			}
			ENDCG
		}
	}
}
