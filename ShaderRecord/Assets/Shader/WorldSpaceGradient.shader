Shader "Sikapaper/WorldSpaceGradient"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[Header(Gradient Values)]
		_ColorHigh("High Color", Color) = (1, 1, 1, 1)
		_ColorLow("Low Color", Color) = (1, 1, 1, 1)
		_GradientOrigin("Gradient Origin", float) = 1
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
				float2 uv : TEXCOORD0;
				float4 position : SV_POSITION;
				float3 worldPosition : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _ColorHigh;
			float4 _ColorLow;
			float _GradientOrigin;

			// Step 2
			v2f vert (appdata v)
			{
				v2f OUT;
				OUT.position = UnityObjectToClipPos(v.vertex);
				OUT.uv = v.uv;
				OUT.worldPosition = mul(unity_ObjectToWorld, v.vertex);

				return OUT;
			}

			// Step 4
			fixed4 frag (v2f i) : SV_Target
			{
				// Step 5
				float4 mainTextureColor = tex2D(_MainTex, i.uv);
				float4 gradientColor = lerp(_ColorLow, _ColorHigh, i.worldPosition.y * _GradientOrigin);

                return mainTextureColor * gradientColor;
			}
			ENDCG
		}
	}
}
