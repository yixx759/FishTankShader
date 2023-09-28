Shader "Unlit/FishTankC"
{
    Properties
    {
        _MainCol ("col", color) = (1,1,1,1)
        _Defor ("def", float) = 1
        _Defor2 ("def2", float) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 100

        GrabPass{
            
            "_Back"
        }
        
    
        
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
         

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 grb : TEXCOORD1;
             
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex, _Back;
            float4 _MainTex_ST;
            float4  _MainCol;
             float _Defor,_Defor2;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.grb = ComputeGrabScreenPos(o.vertex);
                
                return o;
            }

           float4 frag (v2f i) : COLOR
            {

                float4 nuuv = i.grb;
                nuuv.xy += (sin((i.grb.y*  _Defor2) +_Time.y)/_Defor);
                float4 col = tex2Dproj(_Back, nuuv);
                
                return col*_MainCol;
            }
            ENDCG
        }
    }
}
