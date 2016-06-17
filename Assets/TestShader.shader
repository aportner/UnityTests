Shader "Custom/TestShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				float4 v2 = v.vertex;

				//v2.x += cos(v.vertex.y + _Time.z);
				//v2.y += sin(v.vertex.x + _Time.w);

				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v2);
				o.uv = v.uv;

				return o;
			}

			sampler2D _MainTex;

			float4 frag(v2f i) : SV_Target
			{
				float2 uv = 3 * i.uv;

				uv.x += sin(1 - 2 * i.uv.y + _Time.w) * .5;
				//uv.y += cos(i.uv.x + _Time.w) * .5;

				float4 color = tex2D(_MainTex, uv);

				color.a = 0.5 + 0.5 * sin(1 * (i.uv.y + _Time.y));

				return color;
			}

			ENDCG
		}
	}
}