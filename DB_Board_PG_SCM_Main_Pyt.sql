

/*###################################################

■  Anonymous Code Blocks

    DO $$
        # PL/Python code
    $$ LANGUAGE plpython3u;

    아래 에러를 만날 수 있다.

        ERROR:  language "plpython3u" does not support inline code execution

###################################################*/


SET CLIENT_ENCODING='UTF8';


CREATE SCHEMA IF NOT EXISTS SCM_Main;

SET search_path=SCM_Main,"$user",public;


/* 아래 함수에서 인수 AS_Key 와 AS_Value 를 args 를 사용하여 접근하고 있음에 주의한다. */

CREATE OR REPLACE FUNCTION UPyt_AddInSD(AS_Key TEXT, AS_Value TEXT) RETURNS VOID AS
$$
    SD[args[0]]=args[1];
$$
LANGUAGE plpython3u; /*##########################################################*/

CREATE OR REPLACE FUNCTION UPyt_AddInGD(AS_Key TEXT, AS_Value TEXT) RETURNS VOID AS
$$
    GD[args[0]]=args[1];
$$
LANGUAGE plpython3u; /*##########################################################*/


CREATE OR REPLACE FUNCTION UPyt_AddMapInSD(ASA_Key TEXT[], AJ_Value JSON='{}') RETURNS INT AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ] = eval(args[1]);
        
        return int(True); #*********************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddMapInSD(ASA_Key TEXT[], AJ_Value JSON='{}') RETURNS INT */

CREATE OR REPLACE FUNCTION UPyt_AddMapInGD(ASA_Key TEXT[], AJ_Value JSON='{}') RETURNS INT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ]=eval(args[1]);
        
        return int(True); #*******************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddMapInGD(ASA_Key TEXT[], AJ_Value JSON='{}') RETURNS INT */


CREATE OR REPLACE FUNCTION UPyt_AddData(
    AS_Search TEXT, AS_Value TEXT='{}') RETURNS INT AS
$$
    VarsSearch=args[0]; VarsValue=args[1];
    try   :
        if not VarsSearch.startswith("GD"):
            VarsSearch="GD"+VarsSearch;  #**************#;
        
        exec(VarsSearch+"="+VarsValue);  return int(True);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddData(
    AS_Search TEXT, AS_Value TEXT='{}') RETURNS INT */
/*

    d_success=> SELECT UPyt_AddData('["test"]', '"my"');
     upyt_adddata 
    --------------
                1

    d_success=> SELECT UPYt_ShowGD();
                           upyt_showgd                        
    ----------------------------------------------------------
     {'test': 'my', '@_Error_': "name 'asdf' is not defined"}
    (1 row)

    d_success=> SELECT UPyt_AddData('["test"]', '[1,4,"10"]');
     upyt_adddata 
    --------------
                1

-- 2017-07-28 11:03:00 */


CREATE OR REPLACE FUNCTION UPyt_AddInSD(ASA_Key TEXT[], AS_Value TEXT) RETURNS INT AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap = VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ] = args[1];
        
        return int(True); #***************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInSD(ASA_Key TEXT[], AS_Value TEXT) RETURNS INT */

CREATE OR REPLACE FUNCTION UPyt_AddInGD(ASA_Key TEXT[], AS_Value TEXT) RETURNS INT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ] = args[1];
        
        return int(True); #***************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInGD(ASA_Key TEXT[], AS_Value TEXT) RETURNS INT */


CREATE OR REPLACE FUNCTION UPyt_AddInSD(ASA_Key TEXT[], AY_Value BYTEA) RETURNS INT AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ] = args[1];
        
        return int(True); #***************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInSD(ASA_Key TEXT[], AY_Value BYTEA) RETURNS INT */

CREATE OR REPLACE FUNCTION UPyt_AddInGD(ASA_Key TEXT[], AY_Value BYTEA) RETURNS INT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        VaroMap[ args[0][ConiKeyArrSize-1] ]=args[1];
        
        return int(True); #*************************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return int(False);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInGD(ASA_Key TEXT[], AY_Value BYTEA) RETURNS INT */
/*

    SELECT UPyt_AddMapInGD(Array['1']);
    SELECT UPyt_AddMapInGD(Array['1', '1-1']);
    SELECT UPyt_AddMapInGD(Array['1', '1-2']);
    SELECT UPyt_AddMapInGD(Array['2'], '{"2-1": "2-1-value", "2-2": "2-2-value"}');
    SELECT UPyt_AddMapInGD(Array['3']);

    SELECT UPyt_AddInGD(Array['3', '3-1'], '3-1'::BYTEA);
    SELECT UPyt_AddInGD(Array['3', '3-2'], '3-2'::BYTEA);

    SELECT UPyt_GetBinByGD(Array['3', '3-1']);
    SELECT UPyt_GetBinByGD(Array['3', '3-2']);

    SELECT UPyt_AddInGD(Array['1', '1-1', '1-1-1'], '1-1-1-value');
    SELECT UPyt_AddInGD(Array['1', '1-1', '1-1-2'], '1-1-2-value');
    SELECT UPyt_AddInGD(Array['1', '1-1', '1-1-3'], '1-1-3-value');

    SELECT UPyt_ShowGD();

    SELECT UPyt_CutInGD(Array['1', '1-1', '1-1-1']);
    SELECT UPyt_CutInGD(Array['1', '1-1', '1-1-2']);
    SELECT UPyt_CutInGD(Array['1', '1-1', '1-1-3']);

    SELECT UPyt_ShowGD();

    SELECT UPyt_CutInGD(Array['1', '1-1']);
    SELECT UPyt_CutInGD(Array['1', '1-2']);
    SELECT UPyt_CutInGD(Array['2', '2-1']);
    SELECT UPyt_CutInGD(Array['2', '2-2']);
    SELECT UPyt_CutInGD(Array['3', '3-1']);
    SELECT UPyt_CutInGD(Array['3', '3-2']);

    SELECT UPyt_ShowGD();

    SELECT UPyt_CutInGD(Array['1']);
    SELECT UPyt_CutInGD(Array['2']);
    SELECT UPyt_CutInGD(Array['3']);
    SELECT UPyt_ShowGD();

-- 2017-07-25 15:41:00 */


CREATE OR REPLACE FUNCTION UPyt_CutInSD(AS_Key TEXT) RETURNS INT AS
$$
    try   :
        del SD[args[0]]; return int(True);
    except:
        return int(True); #*************#
$$
LANGUAGE plpython3u; /*###########################################*/

CREATE OR REPLACE FUNCTION UPyt_CutInGD(AS_Key TEXT) RETURNS INT AS
$$
    try   :
        del GD[args[0]]; return int(True);
    except:
        return int(True); #*************#
$$
LANGUAGE plpython3u; /*###########################################*/


CREATE OR REPLACE FUNCTION UPyt_CutInSD(ASA_Key TEXT[]) RETURNS INT AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        del VaroMap[ args[0][ConiKeyArrSize-1] ] ;
    except:
        return int(False);
    
    return int(True); #********************#;
$$
LANGUAGE plpython3u; /*##############################################*/

CREATE OR REPLACE FUNCTION UPyt_CutInGD(ASA_Key TEXT[]) RETURNS INT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        del VaroMap[ args[0][ConiKeyArrSize-1] ] ;
    except:
        return int(False);
    
    return int(True); #********************#;
$$
LANGUAGE plpython3u; /*##############################################*/


CREATE OR REPLACE FUNCTION UPyt_EnumKeyInSD() RETURNS SETOF TEXT AS
$$
    try   :
        for VarsKey in SD: yield ("%s" % VarsKey) ;
    except: pass;
    
    return; #*************************************#
$$
LANGUAGE plpython3u; /*###########################################*/

CREATE OR REPLACE FUNCTION UPyt_EnumKeyInGD() RETURNS SETOF TEXT AS
$$
    try   :
        for VarsKey in GD: yield ("%s" % VarsKey) ;
    except: pass;
    
    return; #*************************************#
$$
LANGUAGE plpython3u; /*###########################################*/


CREATE OR REPLACE FUNCTION
    UPyt_EnumKeyInSD(ASA_Key TEXT[]) RETURNS SETOF TEXT AS
$$
    VaroMap=SD;  VarsKey="";
    try   :
        for VarsKey in args[0]: VaroMap=VaroMap[VarsKey];
        for VarsKey in VaroMap: yield ("%s" % VarsKey)  ;
    except: pass;
    
    return; #*************#;
$$
LANGUAGE plpython3u; /*##################################*/

CREATE OR REPLACE FUNCTION
    UPyt_EnumKeyInGD(ASA_Key TEXT[]) RETURNS SETOF TEXT AS
$$
    VaroMap=GD;  VarsKey="";
    try   :
        for VarsKey in args[0]: VaroMap=VaroMap[VarsKey];
        for VarsKey in VaroMap: yield ("%s" % VarsKey)  ;
    except: pass;
    
    return; #*************#;
$$
LANGUAGE plpython3u; /*##################################*/


CREATE OR REPLACE FUNCTION UPyt_EnumData(
    AS_Eval TEXT, AB_ArrayIfList BOOL=FALSE) RETURNS SETOF TEXT[] AS
$$
    """ AB_ArrayIfList==TRUE 이면, 각 Row 를 배열로 간주한다. 그렇다면
        쿼리 명령문 자체에서 첨자를 사용해 특정 원소에만 접근할 수 있다.
    """
    import json;
    
    VarsEval=args[0];  VarbArrayIfList=args[1];
    
    try   :
        if not VarsEval.startswith("GD"):
            VarsEval="GD"+VarsEval; #***********#;
        # plpy.notice("# VarsEval=%s" % VarsEval);
        VaroValue=eval(VarsEval); #*************#;
        
        if   type(VaroValue)==type({}):
            yield [json.dumps(VaroValue)];
        elif type(VaroValue)==type([]) or \
             type(VaroValue)==type(()):
        #+++++++++++++++++++++++++++++++++#
            if VarbArrayIfList:
                for VarsKey in VaroValue: yield  (VarsKey)  ;
            else:
                for VarsKey in VaroValue: yield [(VarsKey)] ;
        else:
            yield [json.dumps(VaroValue)];
    except: pass;
    
    return; #**#;
$$
LANGUAGE plpython3u; /*FUN UPyt_EnumData(
    AS_Eval TEXT, AB_ArrayIfList BOOL=FALSE) RETURNS SETOF TEXT[] */
/*

    d_success=> SELECT (UPyt_EnumData(''))[1]::JSON;
                                          upyt_enumdata                                       
    ------------------------------------------------------------------------------------------
     {"test":[["1","2"],["3","5"],["ABC","YZ","KY"]],"@_Error_":"name 'asdf' is not defined"}
    (1 row)

    d_success=> SELECT UPyt_Exec('GD["test"]=[[1,2],[3,5], ["ABC", "YZ", "KY"]]');
     upyt_exec 
    -----------
             1
    (1 row)

    d_success=> SELECT (UPyt_EnumData(''))[1]::JSON;
                                          upyt_enumdata                                       
    ------------------------------------------------------------------------------------------
     {"test":[["1","2"],["3","5"],["ABC","YZ","KY"]],"@_Error_":"name 'asdf' is not defined"}
    (1 row)

-- 2017-07-28 00:08:00 */


CREATE OR REPLACE FUNCTION UPyt_ShowSD() RETURNS TEXT AS
$$
    try   : return ("%s" % SD) ;
    except: return ""          ;
$$
LANGUAGE plpython3u; /*FUN UPyt_ShowSD() RETURNS TEXT */

CREATE OR REPLACE FUNCTION UPyt_ShowGD() RETURNS TEXT AS
$$
    try   : return ("%s" % GD) ;
    except: return ""          ;
$$
LANGUAGE plpython3u; /*FUN UPyt_ShowGD() RETURNS TEXT */


CREATE OR REPLACE FUNCTION UPyt_GetBySD(AS_Key TEXT) RETURNS TEXT AS
$$
    if args[0] in SD:
        return ("%s" % SD[args[0]]);
    return "";
$$
LANGUAGE plpython3u; /*############################################*/

CREATE OR REPLACE FUNCTION UPyt_GetByGD(AS_Key TEXT) RETURNS TEXT AS
$$
    if args[0] in GD:
        return ("%s" % GD[args[0]]);
    return "";
$$
LANGUAGE plpython3u; /*############################################*/
/*

    SELECT UPyt_AddInSD('key1', 'value1'), UPyt_AddInGD('key1', 'value1');
    SELECT UPyt_AddInSD('key2', 'value2'), UPyt_AddInGD('key2', 'value2');

    SELECT UPyt_GetBySD('key1'), UPyt_GetByGD('key1');
    SELECT UPyt_GetBySD('key2'), UPyt_GetByGD('key2');

    -- 위 테스트 결과 GD 를 이용한 경우에만 전역 변수를 흉내낼 수 있었다.

-- 2015-12-17 11:54:00 */


CREATE OR REPLACE FUNCTION UPyt_GetByEval(AS_Eval TEXT) RETURNS TEXT AS
$$
    """ 반환 자료를 JSON 형태로 바로 바꿀 수 있어서 좋다. """
    
    import json;  VarsEval=args[0];
    
    try:
        if not VarsEval.startswith("GD"):
            VarsEval="GD"+VarsEval; #***********#;
        
        # plpy.notice("# VarsEval=%s" % VarsEval);
        VaroValue=eval(VarsEval); #*************#;
        
        return json.dumps(VaroValue)  ;
    except: pass;
    
    return ""   ;
$$
LANGUAGE plpython3u; /*FUN UPyt_GetByEval(AS_Eval TEXT) RETURNS TEXT */
/*

    SELECT UPyt_GetByEval('');

    SELECT UPyt_Exec('GD["test"]=[[1,2],[3,5], ["ABC", "YZ", "KY"]]');
    SELECT UPyt_GetByEval('');
    SELECT UPyt_GetByEval('["test"]');

        d_success=>     SELECT UPyt_GetByEval('["test"]');
                     upyt_getbyeval              
        -----------------------------------------
         [["1","2"],["3","5"],["ABC","YZ","KY"]]
        (1 row)

        d_success=>     SELECT UPyt_GetByEval('["test"]')::JSON ;
                     upyt_getbyeval              
        -----------------------------------------
         [["1","2"],["3","5"],["ABC","YZ","KY"]]
        (1 row)

        d_success=>     SELECT UPyt_GetByEval('["test"]')::JSON->0 ;
         ?column?  
        -----------
         ["1","2"]
        (1 row)

        d_success=>     SELECT UPyt_GetByEval('["test"]')::JSON->0->1 ;
         ?column? 
        ----------
         "2"
        (1 row)

-- 2017-07-28 00:55:00 */


CREATE OR REPLACE FUNCTION UPyt_GetBySD(ASA_Key TEXT[]) RETURNS TEXT AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return ("%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return ""; #********************#;
$$
LANGUAGE plpython3u; /*##############################################*/

CREATE OR REPLACE FUNCTION UPyt_GetByGD(ASA_Key TEXT[]) RETURNS TEXT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return ("%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return ""; #********************#;
$$
LANGUAGE plpython3u; /*##############################################*/


CREATE OR REPLACE FUNCTION UPyt_GetBinBySD(ASA_Key TEXT[]) RETURNS BYTEA AS
$$
    VaroMap=SD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return (b"%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return b""; #********************#;
$$
LANGUAGE plpython3u; /*###################################################*/

CREATE OR REPLACE FUNCTION UPyt_GetBinByGD(ASA_Key TEXT[]) RETURNS BYTEA AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return (b"%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return b""; #********************#;
$$
LANGUAGE plpython3u; /*###################################################*/


CREATE OR REPLACE FUNCTION UPyt_GetIntByGD(AS_Key TEXT) RETURNS BIGINT AS
$$
    try   :
            return int(GD[args[0]]);
    except: return 0;
$$
LANGUAGE plpython3u; /*FUN UPyt_GetIntByGD(AS_Key TEXT) RETURNS BIGINT*/
CREATE OR REPLACE FUNCTION UPyt_GetIntBySD(AS_Key TEXT) RETURNS BIGINT AS
$$
    try   :
            return int(SD[args[0]]);
    except: return 0;
$$
LANGUAGE plpython3u; /*FUN UPyt_GetIntBySD(AS_Key TEXT) RETURNS BIGINT*/

CREATE OR REPLACE FUNCTION UPyt_GetIntByGD(ASA_Key TEXT[]) RETURNS BIGINT AS
$$
    VaroMap=GD;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return int("%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return 0; #*********************#;
$$
LANGUAGE plpython3u; /*FUN UPyt_GetIntByGD(ASA_Key TEXT) RETURNS BIGINT*/
CREATE OR REPLACE FUNCTION UPyt_GetIntBySD(ASA_Key TEXT[]) RETURNS BIGINT AS
$$
    VaroMap = CD ;  ConiKeyArrSize=len(args[0]);
    try   :
        for VariIndex in range(1, ConiKeyArrSize):
            VaroMap=VaroMap[ args[0][VariIndex-1] ];
        return int("%s" % VaroMap[ args[0][ConiKeyArrSize-1] ] ) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return 0; #*********************#;
$$
LANGUAGE plpython3u; /*FUN UPyt_GetIntBySD(ASA_Key TEXT) RETURNS BIGINT*/
/*
-- 예전에 U_GetBigInt() 을 사용했던 코드

CREATE OR REPLACE FUNCTION UPyt_GetIntByGD(ASA_Key TEXT[]) RETURNS BIGINT AS
    $$ BEGIN RETURN U_GetBigInt(UPyt_GetByGD(ASA_Key)); END; $$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION UPyt_GetIntBySD(ASA_Key TEXT[]) RETURNS BIGINT AS
    $$ BEGIN RETURN U_GetBigInt(UPyt_GetBySD(ASA_Key)); END; $$ LANGUAGE plpgsql;

*/

CREATE OR REPLACE FUNCTION UPyt_Compile(AS_Script TEXT, AS_Key TEXT) RETURNS INT AS
$$
    try: #******************#:
        VaroCompile=compile(args[0], "<string>", "exec");
        if "@_CompileMap_" not in GD:
            GD["@_CompileMap_"]={};
        GD["@_CompileMap_"][args[1]]=VaroCompile; #****#;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE); return int(False);
    
    return int(True);
$$
LANGUAGE plpython3u; /*FUN UPyt_Compile(AS_Script TEXT, AS_Key TEXT) RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_Exec(AS_Script TEXT) RETURNS INT AS
$$
    try: #******************#:
        exec(args[0].strip());
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE); return int(False);
    
    return int(True);
$$
LANGUAGE plpython3u; /*FUN UPyt_Exec(AS_Script TEXT) RETURNS INT*/
/*

    SELECT UPyt_Exec('GD["test key"]="test value";');
    SELECT UPyt_GetByGD('test key');
    SELECT UPyt_CutInGD('test key');

-- 2017-07-24 22:38:00 */


CREATE OR REPLACE FUNCTION UPyt_ExecByKey(AS_Key TEXT) RETURNS INT AS
$$
    try: #******************#:
        exec(GD["@_CompileMap_"][args[0]]);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE); return int(False);
    
    return int(True);
$$
LANGUAGE plpython3u; /*FUN UPyt_ExecByKey(AS_Key TEXT) RETURNS INT*/
/*

    SELECT UPyt_Compile('GD["test key"]="test value";', 'PythonCodeKey');
    SELECT UPyt_ExecByKey('PythonCodeKey');
    SELECT UPyt_GetByGD('test key');
    SELECT UPyt_EnumKeyInGD();
    SELECT UPyt_CutInGD('test key');
    SELECT UPyt_CutInGD(Array['@_CompileMap_', 'PythonCodeKey']);

-- 2017-07-24 22:38:00 */


-- 아래 UPyt_AddInJson() 부터 UPyt_SetInJsonArr() 까지는 굳이 필요없을 것 같다.
-- JSON 연산자가 다양하기 지원하기 때문에, 굳이 쓸 필요가 없을 것이다.

CREATE OR REPLACE FUNCTION UPyt_AddInJson(
    AJ_Data JSON, AS_Key TEXT, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON AS
$$
    # AJ_Data 사전에 AS_Key 항목을 AS_Value 로 설정한다.
    
    import json;
    
    VarmMap  =eval(args[0]);
    VarsKey  =     args[1] ;
    VarsValue=     args[2] ;
    VarbEval =     args[3] ;
    
    if VarbEval>0: VarsValue=eval(VarsValue);
    
    if type(VarmMap)==type({}):
        VarmMap[VarsKey]=VarsValue;
    return json.dumps(VarmMap);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInJson(
    AJ_Data JSON, AS_Key TEXT, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON */
/*

    SELECT UPyt_AddInJson('{"One":"1"}'::JSON, 'Key1', 'Value1'           );
    SELECT UPyt_AddInJson('{"One":"1"}'::JSON, 'Key2', '{"Two":"2"}', TRUE);

-- 2017-08-30 23:11:00 */


CREATE OR REPLACE FUNCTION UPyt_AddInJsonEval(
    AJ_Data JSON, AS_Key TEXT, AS_Value TEXT) RETURNS JSON AS
$$
BEGIN  RETURN UPyt_AddInJson(AJ_Data, AS_Key, AS_Value, TRUE);  END;
$$ LANGUAGE plpgsql; /*FUN UPyt_AddInJsonEval(
    AJ_Data JSON, AS_Key TEXT, AS_Value TEXT) RETURNS JSON */
/*

    SELECT UPyt_AddInJsonEval('{"One":"1"}'            ::JSON, 'Key2', '{"Two":"2"}'  );
    SELECT UPyt_AddInJsonEval('{"One":"1", "Key2":"2"}'::JSON, 'Key2', '{"Two":"2-1"}');

-- 2017-11-04 20:28:00 */


CREATE OR REPLACE FUNCTION UPyt_AddInJsonArr(
    AJ_Data JSON, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON AS
$$
    # AJ_Data 리스트 끝에 AS_Value 를 추가한다.
    
    import json;
    
    VarmMap  =eval(args[0]);
    VarsValue=     args[1] ;
    VarbEval =     args[2] ;
    
    if VarbEval>0: VarsValue=eval(VarsValue);
    
    if type(VarmMap)==type([]): #+++++++#;
        VarmMap.append(VarsValue);
    return json.dumps(VarmMap);
$$
LANGUAGE plpython3u; /*FUN UPyt_AddInJsonArr(
    AJ_Data JSON, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON */
/*

    SELECT UPyt_AddInJsonArr('[1,3,5]'::JSON, 'Value1'                    );
    SELECT UPyt_AddInJsonArr('[1,3,5]'::JSON, '["Add", {"One":"1"}]', TRUE);

-- 2017-08-30 23:11:00 */


CREATE OR REPLACE FUNCTION UPyt_SetInJsonArr(
    AJ_Data JSON, AI_Index INT, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON AS
$$
    # AJ_Data 리스트의 AI_Index 번째 원소의 값을 AS_Value 로 설정한다.
    
    import json;
    
    VarmMap  =eval(args[0]);
    VariIndex=     args[1] ;
    VarsValue=     args[2] ;
    VarbEval =     args[3] ;
    
    if VarbEval>0: VarsValue=eval(VarsValue);
    
    if type(VarmMap)==type([]):
        try   :
            VarmMap[VariIndex]=VarsValue ;
        except: pass;
    return json.dumps(VarmMap);
$$
LANGUAGE plpython3u; /*FUN UPyt_SetInJsonArr(
    AJ_Data JSON, AI_Index INT, AS_Value TEXT, AB_Eval BOOL=FALSE) RETURNS JSON */
/*

    SELECT UPyt_SetInJsonArr('[1,3,5]'::JSON, 0, 'Value1'                    );
    SELECT UPyt_SetInJsonArr('[1,3,5]'::JSON, 1, '["Add", {"One":"1"}]', TRUE);

-- 2017-08-30 23:11:00 */


CREATE OR REPLACE FUNCTION UPyt_ReplaceBin(
    AS_Origin Bytea, AS_Search Bytea, AS_Replace Bytea) RETURNS Bytea AS
$$
    VarbsOrigin =args[0];
    VarbsSearch =args[1];
    VarbsReplace=args[2];
    
    return VarbsOrigin.replace(VarbsSearch, VarbsReplace);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ReplaceBin(
    AS_Origin Bytea, AS_Search Bytea, AS_Replace Bytea) RETURNS Bytea*/
/*

    SELECT Convert_From(UPyt_ReplaceBin('my'::BYTEA, 'm'::BYTEA, 'M-M'::Bytea), 'UHC') ;
    SELECT Convert_From(UPyt_ReplaceBin(E'my\n'::BYTEA, E'\n'::BYTEA, ''::Bytea), 'UHC') ;

    -- 2016-03-25 02:10:00 */


CREATE OR REPLACE FUNCTION UPyt_Replace(
    AS_Origin TEXT, AS_Search TEXT, AS_Replace TEXT, AI_MaxCnt INT=0) RETURNS TEXT AS
$$
    import re; # RegExp_Replace() 로는 조금 부족했다.
    
    """
        아래에 보이는 r"some string" 형식의 표시에서  은 raw 를 뜻한다.
        \ 에 대한 처리를 좀 간단히 하는 의미가 있다. 아래는 같은 뜻이다.

        bool(re.search( "\\\\\w+",  "\\apple"));
        bool(re.search(r"\\\w+"  , r"\apple" ));
    """
    
    VarsOrigin =(r"%s" % args[0]);
    VarsSearch =(r"%s" % args[1]);
    VarsReplace=         args[2] ;
    VariMaxCnt =         args[3] ;
    
    try: #++++++++++++++++++++++++++#;
        return re.sub(
            VarsSearch, VarsReplace, VarsOrigin, VariMaxCnt);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_Replace(
    AS_Origin TEXT, AS_Search TEXT, AS_Replace TEXT, AI_MaxCnt INT=0) RETURNS TEXT */
/*

    SELECT UPyt_AddInGD('MyKey',
        '{
             "단지명"     :"해성"                         ,
             "지번 주소"  :"서울시 광진구 구의동 47-23"   ,
             "도로명 주소":"서울시 광진구 자양로46길 9"   ,
             "입주일"     :"2002.11"                      ,
             "건설사"     :"삼인종합건설(주)"             ,
             "층정보"     :"총 13세대 / 총 1개동 / 총 5층",
             "면적"       :"50㎡,54A㎡,56B㎡,65㎡,68A㎡,68B㎡,71㎡,86A㎡,87B㎡,87C㎡,94㎡",
             "세대수"     :"13세대"                       ,
             "동수"       :"1개동"                        ,
             "준공년월"   :"2002년11월"                   ,
             "총주차대수" :"12 대"                        ,
             "세대당주차" :"0.92 대"                      ,
             "난방방식"   :"개별난방"                     ,
             "난방연료"   :"도시가스"                     ,
             "용적율"     :"221%"                         ,
             "건폐율"     :"54%"                          ,
             "최고층"     :"5층"                          ,
             "최저층"     :"4층"                          ,
             "WDate"      :"최초게재일 2017.09.25"        ,
             "SesItm_No"  :"1022600"                      ,
             "DongCode"   :"1121510300"                   ,
             "ComplexCode":"114738"
        }' );

    SELECT UPyt_Replace(UPyt_GetBySD('MyKey'), '"(SesItm_No|DongCode)".*?:.*?".*?"', ''   ) ;
    SELECT UPyt_Replace(UPyt_GetBySD('MyKey'), '"(SesItm_No|DongCode)".*?:.*?".*?"', '', 1) ;

    -- RegExp_Replace() 에서는 위 정규식의 결과가 엉뚱했다.

    SELECT UPyt_CutInGD('MyKey');


    SELECT UPyt_Replace('CopyRight derik 1990-2010', '\b(\d{4}-\d{4})\b', '<I>\1</I>') ;

        ----------------------------------
         CopyRight derik <I>1990-2010</I>
        (1 row)

    SELECT UPyt_Replace('CopyRight derik 1990-2010', '\b(?P<year>\d{4}-\d{4})\b', '<I>\g<year></I>') ;

        ----------------------------------
         CopyRight derik <I>1990-2010</I>
        (1 row)

    SELECT UPyt_Replace('CopyRight derik 1990-2010', '\b(?P<year1>\d{4})-(?P<year2>\d{4})\b', '<I>\g<year1>-\g<year2></I>') ;

    SELECT UPyt_Replace('최초게재일 2017.09.25', '최초게재일 (\d{4}).(\d{2}).(\d{2})', '\1-\2-\3') ;

-- 2017-08-11 21:14:00 */


CREATE OR REPLACE FUNCTION UPyt_Search(AS_Origin TEXT, AS_RegExp TEXT) RETURNS INT AS
$$
    """
        조건에 맞는지를 검사한다. re.match() 는 문자열을 공백으로 나눈 후에 검색함에 주의.
    """
    import re;
    
    VarsOrigin =         args[0] ;
    VarsSearch =(r"%s" % args[1]);
    
    try: #++++++++++++++++++#;
        VariOption = eval( GD.get("@_RegExpOpt", "0") );
        if VariOption<1 :
            return int(bool( re.search(VarsSearch, VarsOrigin)             ) );
        else            :
            return int(bool( re.search(VarsSearch, VarsOrigin, VariOption) ) );
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return 0;
$$
LANGUAGE plpython3u; /*FUN UPyt_Search(AS_Origin TEXT, AS_RegExp TEXT) RETURNS INT */
/*

    SELECT UPyt_Search('I Apple', '\w{1,}');
    SELECT UPyt_Search('I Apple', '\w{6,}');

-- 2017-08-12 17:26:00 */


CREATE OR REPLACE FUNCTION UPyt_FindAll(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS SETOF TEXT AS
$$
    import re;
    
    VarsOrigin =         args[0] ;
    VarsSearch =(r"%s" % args[1]);
    
    try: #++++++++++++++++++#;
        VarlFind   = None;
        VariOption = eval( GD.get("@_RegExpOpt", "0") );
        
        if VariOption<1 :
            VarlFind = re.findall(VarsSearch, VarsOrigin            );
        else            :
            VarlFind = re.findall(VarsSearch, VarsOrigin, VariOption);
        
        for VarsFind in VarlFind: yield (VarsFind);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE); return;
    
    return; #+++++++++++++++#:
$$
LANGUAGE plpython3u; /*FUN UPyt_FindAll(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS SETOF TEXT */
/*

    SELECT UPyt_FindAll('A BC DEF', '[A-Z]+');
    SELECT UPyt_FindAll('A BC DEF', '[a-z]+');

    SELECT UPyt_AddInGD('@_RegExpOpt', 're.I');

    SELECT UPyt_FindAll('A BC DEF', '[A-Z]+');
    SELECT UPyt_FindAll('A BC DEF', '[a-z]+');

    SELECT UPyt_CutInGD('@_RegExpOpt');

-- 2017-08-12 18:00:00 */


CREATE OR REPLACE FUNCTION UPyt_FindArr(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS TEXT[] AS
$$
    import re;
    
    VarsOrigin =         args[0] ;
    VarsSearch =(r"%s" % args[1]);
    
    try: #++++++++++++++++++#;
        VarlFind   = None;
        VariOption = eval( GD.get("@_RegExpOpt", "0") );
        
        if VariOption<1 :
            VarlFind = re.findall(VarsSearch, VarsOrigin            );
        else            :
            VarlFind = re.findall(VarsSearch, VarsOrigin, VariOption);
        
        if VarlFind==None: return [];
        return VarlFind; #*********#;
    
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return []; #++++++++++++#:
$$
LANGUAGE plpython3u; /*FUN UPyt_FindArr(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS SETOF TEXT */
/*

    SELECT UPyt_FindArr('A BC DEF', '[A-Z]+');

-- 2017-08-12 18:00:00 */


CREATE OR REPLACE FUNCTION UPyt_SplitAll(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS SETOF TEXT AS
$$
    import re;
    
    VarsOrigin =         args[0] ;
    VarsSearch =(r"%s" % args[1]);
    
    try: #++++++++++++++++++#;
        VarlSplit = re.split(VarsSearch, VarsOrigin );
        
        for VarsSplit in VarlSplit: yield (VarsSplit);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE); return;
    
    return; #+++++++++++++++#:
$$
LANGUAGE plpython3u; /*FUN UPyt_SplitAll(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS TEXT[] */

CREATE OR REPLACE FUNCTION UPyt_SplitArr(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS TEXT[] AS
$$
    """
        AS_RegExp 에 하위 표현식이 있을 경우는
        반환 문자열 배열에 분리 문자가 포한된다.
    """
    import re;
    
    VarsOrigin =         args[0] ;
    VarsSearch =(r"%s" % args[1]);
    
    try: #++++++++++++++++++#;
        VarlSplit = re.split(VarsSearch, VarsOrigin );
        if VarlSplit==None: return [];
        return VarlSplit; #*********#;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return []; #++++++++++++#:
$$
LANGUAGE plpython3u; /*FUN UPyt_SplitArr(
    AS_Origin TEXT, AS_RegExp TEXT) RETURNS TEXT[] */
/*

    SELECT UPyt_SplitAll('A BC DEF', '\s');
    SELECT UPyt_SplitArr('A BC DEF', '\s');
    SELECT UPyt_SplitArr('A BC,DEF', '[\s,]');
    SELECT UPyt_SplitArr('A/BC,DEF', '\s|,|/');
    SELECT UPyt_SplitArr('A/BC,DEF', '(\s|,|/){1}'); -- 하위 표현식이 있을 경우는 반환 문자열 배열에 분리 문자가 포한된다.

        d_success=> SELECT UPyt_SplitArr('A/BC,DEF', '\s|,|/');
         upyt_splitarr 
        ---------------
         {A,BC,DEF}
        (1 row)

        Time: 4.056 ms
        d_success=> SELECT UPyt_SplitArr('A/BC,DEF', '(\s|,|/)');
          upyt_splitarr   
        ------------------
         {A,/,BC,",",DEF}
        (1 row)

-- 2017-08-12 18:00:00 */


CREATE OR REPLACE FUNCTION UPyt_ShowCode(
        AS_Text  TEXT,     AI_Offset INT=0,     AI_Limit INT=0,
    OUT AIO_Code INT , OUT ASO_Hex   TEXT , OUT ASO_Data TEXT )
RETURNS SETOF RECORD AS /*#############*/
$$
    VarsOrigin = args[0]       ;
    VariOffset = args[1]       ;
    VariLimit  = args[2]       ;
    VariSize   =len(VarsOrigin);
    
    if VariLimit<1                  : VariLimit=VariSize           ;
    if VariLimit>VariSize-VariOffset: VariLimit=VariSize-VariOffset;
    
    for i in VarsOrigin[VariOffset:(VariLimit+VariOffset)]:
        VarsHex=''.join('%02x'%ord(i) for j in i);  yield (ord(i), VarsHex, i);
    #++++++++++++++++++++++++++++++++++++++++++++++++++++#:
    
    """

    ■  아래 함수 정의는 오류다. OUT 이 지정된 인수를 가진 함수에서는
        RETURN NEXT 뒤에 변수를 가질 수 없다.

            RETURN NEXT cannot have a parameter in function with OUT parameters
        --
        CREATE OR REPLACE FUNCTION U_ShowCode(
                AS_Text  TEXT,     AI_Ofset INT=0, AI_Limit INT=0,
            OUT AIO_Code INT , OUT ASO_Data TEXT) RETURNS SETOF RECORD AS
        $_$
        DECLARE
            VO_RowObj    RECORD              ;
            CI_TextSize INT :=LENGTH(AS_Text);
            VS_NowData  TEXT:=''             ;
            i           INT :=0              ;
        BEGIN

            IF AI_Limit<1 /*#############*/ THEN
                AI_Limit:=CI_TextSize         ; END IF;
            IF AI_Limit>CI_TextSize-AI_Ofset THEN
                AI_Limit:=CI_TextSize-AI_Ofset; END IF;

            FOR i IN 1 .. AI_Limit LOOP

                VS_NowData:=SubString(AS_Text, AI_Ofset+i, 1);

                SELECT -------
                    Ascii(VS_NowData) AS Cdoe, VS_NowData AS Data
                INTO VO_RowObj;

                RETURN NEXT VO_RowObj;

            END LOOP; /*#############*/

            RETURN;
        END;
        $_$
        LANGUAGE 'plpgsql'; /*##########################*/
    """
$$
LANGUAGE plpython3u; /*FUN UPyt_ShowCode(
        AS_Text  TEXT,     AI_Offset INT=0,     AI_Limit INT=0,
    OUT AIO_Code INT , OUT ASO_Hex   TEXT , OUT ASO_Data TEXT )
RETURNS SETOF RECORD ##################*/
/*

    d_success=> SELECT UPyt_ShowCode('ABCD1234');
     upyt_showcode 
    ---------------
     (65,41,A)
     (66,42,B)
     (67,43,C)
     (68,44,D)
     (49,31,1)
     (50,32,2)
     (51,33,3)
     (52,34,4)
    (8 rows)

    d_success=> SELECT * FROM UPyt_ShowCode('ABCD1234');
     aio_code | aso_hex | aso_data 
    ----------+---------+----------
           65 | 41      | A
           66 | 42      | B
           67 | 43      | C
           68 | 44      | D
           49 | 31      | 1
           50 | 32      | 2
           51 | 33      | 3
           52 | 34      | 4
    (8 rows)

    d_success=> SELECT * FROM UPyt_ShowCode('그러나1234');
     aio_code | aso_hex | aso_data
    ----------+---------+----------
        44536 | adf8    | 그
        47084 | b7ec    | 러
        45208 | b098    | 나
           49 | 31      | 1
           50 | 32      | 2
           51 | 33      | 3
           52 | 34      | 4
    (7 rows)

-- 2017-08-21 13:40:00 */


CREATE OR REPLACE FUNCTION UPyt_ShowCodes(
        AS_Text TEXT, AI_ShowUnit  INT=10, AI_Offset INT=0, AI_Limit INT=0,
    OUT ASO_Hex TEXT, OUT ASO_Data TEXT  )
RETURNS SETOF RECORD AS /*##############*/
$$
    VarsOrigin  = args[0]       ;
    VariShowUnit= args[1]       ;
    VariOffset  = args[2]       ;
    VariLimit   = args[3]       ;
    VariSize    =len(VarsOrigin);
    
    if VariLimit<1                  : VariLimit=VariSize           ;
    if VariLimit>VariSize-VariOffset: VariLimit=VariSize-VariOffset;
    
    if VariLimit   <1: return        ;
    if VariShowUnit<1: VariShowUnit=1;
    
    VarsHex=""; VarsData=""; VariNowNo=0;
    
    for i in VarsOrigin[VariOffset:(VariLimit+VariOffset)]:
        VarsHex  +=''.join('%02x'%ord(i) for j in i);
        VarsData +=i ;
        VariNowNo+=1 ;
        if VariNowNo==VariShowUnit:
            yield (VarsHex, VarsData);
            VarsHex=""; VarsData=""; VariNowNo=0;
    #++++++++++++++++++++++++++++++++++++++++++++++++++++#:
    
    if VariNowNo!=0: yield (VarsHex, VarsData);
$$
LANGUAGE plpython3u; /*FUN UPyt_ShowCodes(
        AS_Text TEXT, AI_ShowUnit  INT=10, AI_Offset INT=0, AI_Limit INT=0,
    OUT ASO_Hex TEXT, OUT ASO_Data TEXT  )
RETURNS SETOF RECORD ###################*/
/*

    SELECT UPyt_ShowCodes('ABCD1234', 3);
    SELECT * FROM UPyt_ShowCodes('ABCD1234', 3);

-- 20187-08-21 14:42:00*/


CREATE OR REPLACE FUNCTION UPyt_ShowCodes(
        AY_Byte Bytea, AI_ShowUnit  INT=10, AI_Offset INT=0, AI_Limit INT=0,
    OUT ASO_Hex TEXT , OUT ASO_Data TEXT )
RETURNS SETOF RECORD AS /*##############*/
$$
    VaryOrigin  = args[0]       ;
    VariShowUnit= args[1]       ;
    VariOffset  = args[2]       ;
    VariLimit   = args[3]       ;
    VariSize    =len(VaryOrigin);
    
    if VariLimit<1                  : VariLimit=VariSize           ;
    if VariLimit>VariSize-VariOffset: VariLimit=VariSize-VariOffset;
    
    if VariLimit   <1: return        ;
    if VariShowUnit<1: VariShowUnit=1;
    
    VarsHex=""; VarsData=""; VariNowNo=0;
    
    for i in VaryOrigin[VariOffset:(VariLimit+VariOffset)]:
        VarsHex  +=''.join('%02x'%i);
        VarsData +=chr(i);
        VariNowNo+=1     ;
        if VariNowNo==VariShowUnit:
            yield (VarsHex, VarsData);
            VarsHex=""; VarsData=""; VariNowNo=0;
    #++++++++++++++++++++++++++++++++++++++++++++++++++++#:
    
    if VariNowNo!=0: yield (VarsHex, VarsData);
$$
LANGUAGE plpython3u; /*FUN UPyt_ShowCodes(
        AY_Byte Bytea, AI_ShowUnit  INT=10, AI_Offset INT=0, AI_Limit INT=0,
    OUT ASO_Hex TEXT , OUT ASO_Data TEXT )
RETURNS SETOF RECORD ###################*/
/*

    SELECT UPyt_ShowCodes('ABCD1234'::BYTEA, 3);
    SELECT * FROM UPyt_ShowCodes('ABCD1234'::BYTEA, 3);

-- 20187-08-22 09:21:00*/


CREATE OR REPLACE FUNCTION UPyt_GetCWD() RETURNS TEXT AS
$$
    import os ########
    
    return os.getcwd()
$$
LANGUAGE plpython3u; /*FUN UPyt_GetCWD() RETURNS TEXT */


CREATE OR REPLACE FUNCTION
    UPyt_MakeDir(AS_Dir TEXT, AI_Rights INT=0) RETURNS INT AS
$$
    import os;
    
    # mkdir() 의 기본 권한은 511.
    try   :
        if args[1]>0:
              os.mkdir(args[0], args[1]);
        else: os.mkdir(args[0]         );
        return int(True ); #************#
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE)   ; return int(False);
$$
LANGUAGE plpython3u; /*FUNCTION
    UPyt_MakeDir(AS_Dir TEXT, AI_Rights INT=0) RETURNS INT*/

CREATE OR REPLACE FUNCTION UPyt_RmDir(AS_Dir TEXT) RETURNS INT AS
$$
    import os;
    
    try   :
        os.rmdir(args[0]); return int(True );
    except:                return int(False);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_RmDir(AS_Dir TEXT) RETURNS INT*/
/*
    SELECT UPyt_MakeDir('myDir');
    SELECT UPyt_GetByGD('@_Error_');
    SELECT UPyt_RmDir('myDir');
    SELECT UPyt_GetByGD('@_Error_');

-- 2016-09-04 22:03:00 */


CREATE OR REPLACE FUNCTION UPyt_SaveFileBin(
    AS_FileName TEXT, AS_BinData Bytea, AB_DoAppend BOOL=TRUE, AI_Rights INT=0)
RETURNS INT AS /*#########################*/
$$
    import os;
    
    VarsFileName=args[0];
    VarbsBinData=args[1];
    VB_DoAppend =args[2];
    VI_Rights   =args[3];
    
    GD["@_Error_"]="";
    
    VariWriteByte=-1  ;
    VaroFile     =None;
    
    if len(VarbsBinData)<1: return int(False);
    
    try:
        if VB_DoAppend:
            VaroFile=open(VarsFileName, "ba+");
        else:
            VaroFile=open(VarsFileName, "bw+");
    
    except  IOError:
        GD["@_Error_"]=("%s" % IOError ); return int(False);
    #except IOError:
    
    if VI_Rights>0:
        try   :
            os.chmod(VarsFileName, VI_Rights);
        except: pass;
    #************#:
    
    try    :
        VariWriteByte=VaroFile.write(VarbsBinData);
    finally:
        VaroFile.close();  return int(VariWriteByte>0);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_SaveFileBin(
    AS_FileName TEXT, AS_BinData Bytea, AB_DoAppend BOOL=TRUE, AI_Rights INT=0)
RETURNS INT ##################################*/


CREATE OR REPLACE FUNCTION UPyt_SaveFile(
    AS_FileName TEXT, AS_SaveData TEXT, AB_DoAppend BOOL=TRUE, AI_Rights INT=0)
RETURNS INT AS /*######################*/
$$
    import os;
    
    VarsFileName=args[0];
    VarsSaveData=args[1];
    VB_DoAppend =args[2];
    VI_Rights   =args[3];
    
    GD["@_Error_"]="";
    
    VariWriteByte=-1  ;
    VaroFile     =None;
    
    if len(VarsSaveData)<1: return int(False);
    
    try:
        if VB_DoAppend:
            VaroFile=open(VarsFileName, "a+");
        else:
            VaroFile=open(VarsFileName, "w+");
    
    except  IOError:
        GD["@_Error_"]=("%s" % IOError ); return int(False);
    #*************#:
    
    if VI_Rights>0 :
        try   :
            os.chmod(VarsFileName, VI_Rights);
        except: pass;
    #*************#:
    
    try    :
        VariWriteByte=VaroFile.write(VarsSaveData);
    finally:
        VaroFile.close();  return int(VariWriteByte>0);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_SaveFile(
    AS_FileName TEXT, AS_SaveData TEXT, AB_DoAppend BOOL=TRUE, AI_Rights INT=0)
RETURNS INT ###############################*/


CREATE OR REPLACE FUNCTION UPyt_LoadFileBin(
    AS_FileName TEXT, AI_ReadSize BIGINT=-1, AI_Offset BIGINT=0) RETURNS BYTEA AS
$$
    """  pg_read_binary_file() 함수가 이미 있다.  """

    import os;
    
    VarsFileName=args[0];
    VariMaxRead =args[1];
    VariOffset  =args[2];
    
    GD["@_Error_"]=""  ;
    
    VarbsReadByte =b"" ;
    VaroFile      =None;
    
    if len(VarsFileName)<1: return VarbsReadByte;
    
    try:
        VaroFile=open(VarsFileName, "br");
        VaroFile.seek(VariOffset        );
    except  IOError:
        GD["@_Error_"]=("%s" % IOError ); return VarbsReadByte;
    #*************#:
    
    try    :
        VarbsReadByte=VaroFile.read(VariMaxRead);
    finally:
        VaroFile.close();  return VarbsReadByte ;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_LoadFileBin(
    AS_FileName TEXT, AI_ReadSize BIGINT=-1, AI_Offset BIGINT=0) RETURNS BYTEA*/


CREATE OR REPLACE FUNCTION UPyt_LoadFile(
    AS_FileName TEXT, AI_ReadSize BIGINT=-1, AS_EncType TEXT='UTF8', AI_Offset BIGINT=0)
RETURNS TEXT AS /*#####################*/
$$
    """
    ■  파일 내용에 "한123글" 이라고 되어 있다면,

            AI_ReadSize==2 and AI_Offset==0 => "한1 "
            AI_ReadSize==2 and AI_Offset==1 => "한12"
            AI_ReadSize==2 and AI_Offset==2 => "23"
        
        이 나온다. "한"같은 글자가 cache 되어 있나 보다. 그리고 pgsql 의 LENGTH() 함수로
        반환 길이를 보면, 한글이 있는 경우, 길이가 AI_ReadSize 보다 작게 나온다.

        -- 2016-12-04 16:53:00

    ■  pg_read_file() 함수가 이미 있다. 그런데 AS_EncType TEXT 인수가 있는 것이 다르다.

    """
    import os, codecs;
    
    VarsFileName=args[0];
    VariMaxRead =args[1];
    VarsEncType =args[2];
    VariOffset  =args[3];
    
    GD["@_Error_"]=""  ;
    
    VarsReadByte  =""  ;
    VaroFile      =None;
    
    if len(VarsFileName)<1: return VarsReadByte;
    
    try:
        VaroFile=codecs.open( \
            VarsFileName, "r", VarsEncType, "strict");
        if VariOffset>0:
            VariNowOffset=0     ;
            ConiReadUnit =1012*2;
            while True:
                if VariNowOffset+ConiReadUnit>=VariOffset:
                    VariNeedSize=VariOffset-VariNowOffset;
                    VaroFile.read(VariNeedSize);    break;
                VaroFile.read(ConiReadUnit);
                VariNowOffset+=ConiReadUnit;
        #*************#:
    except  IOError:
        GD["@_Error_"]=("%s" % IOError ); return VarsReadByte;
    #*************#:
    
    try    :
        VarsReadByte=VaroFile.read(VariMaxRead);
    finally:
        VaroFile.close();  return VarsReadByte ;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_LoadFile(
    AS_FileName TEXT, AI_ReadSize BIGINT=-1, , AS_EncType TEXT='UTF8', AI_Offset BIGINT=0)
RETURNS TEXT  ##############################*/


CREATE OR REPLACE FUNCTION UPyt_GetSubSearch(
    AS_Origin TEXT, AS_Search1 TEXT, AS_Search2 TEXT, AB_ValidIfNot BOOL=TRUE) RETURNS TEXT AS
$$
    def GetSubSearch(ArgsOrigin, ArgsSearch1, ArgsSearch2, ArgbValidIfNot=False):
        VariFindPos1 = ArgsOrigin.find(ArgsSearch1);
        if VariFindPos1<0: return ""; #************#
        
        VarsOrigin2 = ArgsOrigin[VariFindPos1+len(ArgsSearch1):];
        VariFindPos2= VarsOrigin2.find(ArgsSearch2)             ;
        
        if VariFindPos2<0:
            if ArgbValidIfNot: return VarsOrigin2[0:];
            return ""; #*****************************#
        
        return VarsOrigin2[0:VariFindPos2];
    """
    def GetSubSearch(ArgsOrigin, ArgsSearch1, ArgsSearch2, ArgbValidIfNot=False):
    """
    
    return GetSubSearch(args[0], args[1], args[2], args[3]);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_GetSubSearch(
    AS_Origin TEXT, AS_Search1 TEXT, AS_Search2 TEXT, AB_ValidIfNot BOOL=TRUE) RETURNS TEXT*/
/*

    SELECT UPyt_GetSubSearch('ABC1234DEF', 'ABC', 'DEF'  );
    SELECT UPyt_GetSubSearch('ABC1234DEF', 'ABC', 'DEFGH');

-- 2016-06-11 23:43:00 */


CREATE OR REPLACE FUNCTION UPyt_GetUrlEnc(AS_Origin TEXT) RETURNS TEXT AS
$$
    # url encode 인데, percent encode 라고도 한다.
    
    from requests.utils import quote;  return quote(args[0]);
$$
LANGUAGE plpython3u; /*################################################*/

CREATE OR REPLACE FUNCTION UPyt_GetUrlDec(AS_Origin TEXT) RETURNS TEXT AS
$$
    from requests.utils import unquote;  return unquote(args[0]);
$$
LANGUAGE plpython3u; /*################################################*/


CREATE OR REPLACE FUNCTION UPyt_OpenUrlByType(
    AS_Url      TEXT      , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap  TEXT='{}' , AS_DataMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_ReqType  TEXT='GET', AS_JsonMap     TEXT='{}', AS_SaveKey   TEXT=''  ,
    AS_SaveKey2 TEXT='') RETURNS BYTEA AS ----
$$
    """############################################################
    ■  AS_CookieMap 는 아래 형태다.

        {
            "CookieKey1" : {"value":"val1", "domain":"", "path":""},
            "CookieKey2" : {"value":"val2", "domain":"", "path":""},
            "CookieKey3" : {"value":"val3", "domain":"", "path":""}
        }
        -- 2016-12-01 23:24:00

    ■  requests.get() 함수는 data=AS_DataMap 인수를 무시한다.

    ############################################################"""
    
    import re, urllib, requests;
    
    VarsUrl        =args[0];
    VariMaxBodySize=args[1];
    VariTimeOut    =args[2];
    VarsReqType    =args[6];
    VarsSaveKey    =args[8].strip();
    VarsSaveKey2   =args[9].strip();
    """
        VarsSaveKey : 이 값이 있으면, 수신 body 를
        GD['_OpenUrl_RecvBinMap'][VarsSaveKey] 에 저장한다.
    """
    # plpy.notice("# Url=%s, VarsReqType=%s" % (VarsUrl, VarsReqType) );
    
    GD["@_Error_"         ]=""  ;
    GD["@_OpenUrl_ResCode"]=""  ;
    GD["@_OpenUrl_Head"   ]=""  ;
    
    VaroRequest            =None;
    
    try:
        
        VaroHeadMap = {}   ;
        VaroDataMap = {}   ;
        VaroCookMap = {}   ;
        VaroJsonMap = {}   ;
        VarbsHtml   = b''  ;
        VaroRequest = None ;
        VarpfRequest= None ;
        VaroCookJar = requests.cookies.RequestsCookieJar();
        
        if len(args[3])>2: VaroHeadMap = eval(args[3]);
        if len(args[4])>2: VaroDataMap = eval(args[4]);
        if len(args[5])>2: VaroCookMap = eval(args[5]);
        if len(args[7])>2: VaroJsonMap = eval(args[7]);
        
        for VarsKey in VaroCookMap:
            VaroCookJar.set( 
                VarsKey, VaroCookMap[VarsKey].get("value" , ""),\
                domain=  VaroCookMap[VarsKey].get("domain", ""),\
                path  =  VaroCookMap[VarsKey].get("path"  , ""));
        #************************#:
        
        if   VarsReqType=="GET"    : VarpfRequest=requests.get    ;
        elif VarsReqType=="POST"   : VarpfRequest=requests.post   ;
        elif VarsReqType=="HEAD"   : VarpfRequest=requests.head   ;
        elif VarsReqType=="PUT"    : VarpfRequest=requests.put    ;
        elif VarsReqType=="OPTIONS": VarpfRequest=requests.options;
        else                       : VarpfRequest=requests.get    ;
        
        VaroRequest=VarpfRequest( \
            VarsUrl            , data=VaroDataMap, cookies=VaroCookJar, \
            headers=VaroHeadMap, json=VaroJsonMap, timeout=VariTimeOut, stream=True);
        
        if VariMaxBodySize>0:
            #
            ConiRecvChunkSize=1024*10;
            
            for VarbsChunk in VaroRequest. \
                iter_content(chunk_size=ConiRecvChunkSize):
            #********************************************#:
                if len(VarbsHtml)+len(VarbsChunk)>=VariMaxBodySize:
                    VariNeedSize =VariMaxBodySize-len(VarbsHtml);
                    VarbsHtml   +=VarbsChunk[0:VariNeedSize]    ;
                    break;
                VarbsHtml+=VarbsChunk;
            #********************************************#:
        else: # VariMaxBodySize<=0
            VarbsHtml=VaroRequest.content;
        #**#:
        
        GD["@_OpenUrl_ResCode"  ]= ("%s" % VaroRequest.status_code);
        GD["@_OpenUrl_Head"     ]= ("%s" % VaroRequest.headers    );
        GD["@_OpenUrl_Connect"  ]= ("%s" % VaroRequest.connection );
        GD["@_OpenUrl_Close"    ]= ("%s" % VaroRequest.close      );
        GD["@_OpenUrl_Elapse"   ]= ("%s" % VaroRequest.elapsed    );
        GD["@_OpenUrl_Url"      ]= ("%s" % VaroRequest.url        );
        GD["@_OpenUrl_Encoding" ]= ("%s" % VaroRequest.encoding   );
        GD["@_OpenUrl_CookieCnt"]= len(VaroRequest.cookies)        ;
        GD["@_OpenUrl_CookieStr"]= ("%s" % VaroRequest.cookies    );
        GD["@_OpenUrl_CookieMap"]= {}                              ;
        
        VariCookieNo=1; #*******************#:
        
        for VarsCookie in VaroRequest.cookies:
            GD["@_OpenUrl_CookieMap"] \
                [str(VariCookieNo)]=("%s" % VarsCookie);
            # plpy.notice("# Cookie=%s" % VarsCookie  );
            VariCookieNo=VariCookieNo+1;
        #***********************************#:
        
        if VarsSaveKey !="":
            if ("%s" % type(GD.get('@_OpenUrl_RecvBinMap')))!="<class 'dict'>":
                GD['@_OpenUrl_RecvBinMap']={};
            GD['@_OpenUrl_RecvBinMap'][VarsSaveKey ]=VarbsHtml;        return b'';
        if VarsSaveKey2!="":
            if ("%s" % type(GD.get('@_OpenUrl_RecvMap'   )))!="<class 'dict'>":
                GD['@_OpenUrl_RecvMap'   ]={};
            GD['@_OpenUrl_RecvMap'   ][VarsSaveKey2]=VaroRequest.text; return b'';
        #*****************#:
        
        VaroRequest.close();  return VarbsHtml;
        
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        #
        if VarsSaveKey!="":
            if type(GD.get('@_OpenUrl_RecvBinMap'))!=type({}):
                GD['@_OpenUrl_RecvBinMap']={};
            if VarsSaveKey in GD['@_OpenUrl_RecvBinMap']: #++#
                del GD['@_OpenUrl_RecvBinMap'][VarsSaveKey];
        #****************#:
    
    if VaroRequest!=None: VaroRequest.close();
    
    return b''; #+++++++++++++++++++++++++++#;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_OpenUrlByType(
    AS_Url      TEXT      , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap  TEXT='{}' , AS_DataMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_ReqType  TEXT='GET', AS_JsonMap     TEXT='{}', AS_SaveKey   TEXT=''  ,
    AS_SaveKey2 TEXT=''   )
RETURNS BYTEA ##################################*/


CREATE OR REPLACE FUNCTION UPyt_OpenUrlPost(
    AS_Url     TEXT     , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap TEXT='{}', AS_PostMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_JsonMap TEXT='{}', AS_SaveKey     TEXT=''  ) RETURNS BYTEA AS
$$
BEGIN /* 명시적 POST 사용 */
    RETURN UPyt_OpenUrlByType(
        AS_Url    , AI_MaxBodySize, AI_TimeOut, AS_HeadMap,
        AS_PostMap, AS_CookieMap  , 'POST'    , AS_JsonMap, AS_SaveKey);
END ;
$$
LANGUAGE plpgsql; /*FUN    UPyt_OpenUrlPost(
    AS_Url     TEXT     , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap TEXT='{}', AS_PostMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_JsonMap TEXT='{}', AS_SaveKey     TEXT='') RETURNS BYTEA */


CREATE OR REPLACE FUNCTION UPyt_OpenUrl(
    AS_Url     TEXT      , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap TEXT='{}' , AS_PostMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_ReqType TEXT='GET', AS_JsonMap     TEXT='{}', AS_SaveKey   TEXT=''  )
RETURNS BYTEA AS /*###################*/
$$
BEGIN
    IF AS_ReqType='GET' AND LENGTH(AS_PostMap)>2 THEN
        RETURN UPyt_OpenUrlByType(
            AS_Url    , AI_MaxBodySize, AI_TimeOut, AS_HeadMap,
            AS_PostMap, AS_CookieMap  , 'POST'    , AS_JsonMap, AS_SaveKey);
    ELSE
        RETURN UPyt_OpenUrlByType(
            AS_Url    , AI_MaxBodySize, AI_TimeOut, AS_HeadMap,
            AS_PostMap, AS_CookieMap  , AS_ReqType, AS_JsonMap, AS_SaveKey);
    END IF;
END ;
$$
LANGUAGE plpgsql; /*FUNCTION UPyt_OpenUrl(
    AS_Url     TEXT      , AI_MaxBodySize INT =0   , AI_TimeOut   INT =5   ,
    AS_HeadMap TEXT='{}' , AS_PostMap     TEXT='{}', AS_CookieMap TEXT='{}',
    AS_ReqType TEXT='GET', AS_JsonMap     TEXT='{}', AS_SaveKey   TEXT=''  ) RETURNS BYTEA */
/*

    SELECT UPyt_OpenUrl('http://www.naver.com', AI_MaxBodySize:=500), UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_OpenUrl('http://www.12345.com', AI_MaxBodySize:=500), UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_OpenUrl('http://www.naning9.com/index.html?branduid=33477&ref=naver_open'),
        UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');

    SELECT Convert_From(UPyt_OpenUrl('http://www.naver.com', AI_MaxBodySize:=500), 'utf-8');
        SELECT UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT Convert_From(UPyt_OpenUrl('http://www.naning9.com/index.html?branduid=33477&ref=naver_open', AI_MaxBodySize:=500), 'UHC');
        SELECT UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');

    -- 2016-03-21 17:42:00


    SELECT UPyt_OpenUrl('http://www.phpschool.com', AI_MaxBodySize:=500),
        UPyt_GetByGD('@_OpenUrl_ResCode') As "ResCode", UPyt_GetByGD('@_Error_') As "Error", UPyt_GetByGD('@_OpenUrl_Head') As "ResHead",
        UPyt_GetByGD('@_OpenUrl_CookieCnt') As "CookieCnt", UPyt_GetByGD('@_OpenUrl_CookieSum') As "CookieSum",
        UPyt_GetByGD('@_OpenUrl_Cookie1') As "Cookie1", UPyt_GetByGD('@_OpenUrl_Cookie2') As "Cookie2",
        UPyt_GetByGD('@_OpenUrl_Cookie1_Key') As "Cookie1-Key", UPyt_GetByGD('@_OpenUrl_Cookie1_Val') As "Cookie1-Val",
        UPyt_GetByGD('@_OpenUrl_Cookie2_Key') As "Cookie2-Key", UPyt_GetByGD('@_OpenUrl_Cookie2_Val') As "Cookie2-Val";

    SELECT Convert_From(UPyt_OpenUrl('http://www.styledonut.com/test.php', 100, 5, '', '', '{"myCookie1":"1234567890=", "myCookie2":"ABCD$EFGHI"}'), 'utf-8'),
        UPyt_GetByGD('@_OpenUrl_ResCode') As "ResCode", UPyt_GetByGD('@_Error_') As "Error", UPyt_GetByGD('@_OpenUrl_Head') As "ResHead",
        UPyt_GetByGD('@_OpenUrl_CookieCnt') As "CookieCnt", UPyt_GetByGD('@_OpenUrl_CookieSum') As "CookieSum",
        UPyt_GetByGD('@_OpenUrl_Cookie1') As "Cookie1", UPyt_GetByGD('@_OpenUrl_Cookie2') As "Cookie2",
        UPyt_GetByGD('@_OpenUrl_Cookie1_Key') As "Cookie1-Key", UPyt_GetByGD('@_OpenUrl_Cookie1_Val') As "Cookie1-Val",
        UPyt_GetByGD('@_OpenUrl_Cookie2_Key') As "Cookie2-Key", UPyt_GetByGD('@_OpenUrl_Cookie2_Val') As "Cookie2-Val";

    -- 2016-07-03 19:10:00

    SELECT UPyt_OpenUrl('http://www.naver.com', 1000, AS_SaveKey:='BodyNaver'),
        UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_GetBinByGD(Array['@_OpenUrl_RecvBinMap', 'BodyNaver']);
    SELECT Convert_From(UPyt_GetBinByGD(Array['@_OpenUrl_RecvBinMap', 'BodyNaver']), 'UTF8');
    SELECT UPyt_CutInGD(Array['@_OpenUrl_RecvBinMap', 'BodyNaver']);

    -- 2017-07-25 17:54:00

    SELECT UPyt_OpenUrlByType('http://www.naver.com', AS_SaveKey:='BodyNaver', AS_SaveKey2:='BodyNaver'),
        UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_GetBinByGD(Array['@_OpenUrl_RecvBinMap', 'BodyNaver']);
    SELECT UPyt_GetByGD   (Array['@_OpenUrl_RecvMap'   , 'BodyNaver']); -- 길이가 0.

    -- AS_SaveKey2 을 지정해서 테스트한 것인데, GD['@_OpenUrl_RecvMap'] 가 비어 있다.
    -- VaroRequest.text 이 DB 의 문자셋과 python 의 문자셋이 달라서일 것이라고 본다.

    -- 2017-08-07 14:28:00


    아래는 psycopg2 를 이용해 UPyt_OpenUrl() 의 bytea 형 반환값을 TEXT 로 받아서, binary(bytes 문자열)로 바꾸어 파일에 저장하는 예제다.

        import psycopg2 as PG2
        
        #================== Database Connection =================== st
        VarsConnStr = "host='localhost' dbname ='d_styledonut' user='styledonut' password='styledonut_pw'"
        VaroConnObj=None;
        try:
            VaroConnObj = PG2.connect(VarsConnStr)
        except:
            print("error database connection")
        
        VaroCursor=VaroConnObj.cursor()
        #================== Database Connection =================== ed
        
        # sql_string = "SELECT * FROM DB_Board LIMIT 5"
        # sql_string = "SELECT UPyt_OpenUrl('http://www.naver.com')::TEXT"
        sql_string = "SELECT UPyt_OpenUrl('http://www.naning9.com/index.html?branduid=33477&ref=naver_open')::TEXT"
        VaroCursor.execute(sql_string)
        VaroResult = VaroCursor.fetchall()
        
        VarsHexData=VaroResult[0][0]
        VarsHexData=VarsHexData.replace("\\x", "");
        
        print(VarsHexData ); ###################
        VarbsBinData=bytes.fromhex(VarsHexData);
        print(VarbsBinData); ###################
        
        VaroFile=open("m.txt", "bw");
        VaroFile.write(VarbsBinData);
        VaroFile.flush();
        VaroFile.close();
        
        VaroConnObj.commit();

    -- 2016-03-22 02:02 #####################################################*/


CREATE OR REPLACE FUNCTION UPyt_OpenUrlEx(
    AS_Url     TEXT      , AS_SaveKey     TEXT='_Default', AS_Decode    TEXT='UTF8',
                           AI_MaxBodySize INT =0         , AI_TimeOut   INT =5     ,
    AS_HeadMap TEXT='{}' , AS_DataMap     TEXT='{}'      , AS_CookieMap TEXT='{}'  ,
    AS_ReqType TEXT='GET', AS_JsonMap     TEXT='{}') RETURNS BYTEA AS
$$
    /*  수신한 binary 데이타를 AS_Decode 기준으로 변환해서

            GD['@_OpenUrl_RecvMap'][AS_SaveKey]

        에 저장한다. python 의 bytes 형 문자열의 decode 함
        수로는 가끔 에러가 나서, 이 함수가 필요하다.    */
DECLARE
    VI_RetCode  INT  :=0        ;
    VY_RecvBody BYTEA:=''::BYTEA;
BEGIN

    AS_SaveKey:=Trim(AS_SaveKey);
    AS_Decode :=Trim(AS_Decode );

    VY_RecvBody:=UPyt_OpenUrlByType(
        AS_Url     , AI_MaxBodySize, AI_TimeOut  ,
        AS_HeadMap , AS_DataMap    , AS_CookieMap,
        AS_ReqType , AS_JsonMap    , AS_SaveKey  );

    IF AS_Decode!='' THEN /*#### IF-Main ####*/

        VI_RetCode:=UPyt_AddInGD(
            Array['@_OpenUrl_RecvMap', AS_SaveKey],
            Convert_From(
                UPyt_GetBinByGD(
                    Array['@_OpenUrl_RecvBinMap', AS_SaveKey] ),
                AS_Decode)
            /*---------*/
        /*###################*/ );

        IF VI_RetCode<1 THEN
            PERFORM UPyt_AddMapInGD(Array['@_OpenUrl_RecvMap']);
            PERFORM UPyt_AddInGD(
                Array['@_OpenUrl_RecvMap', AS_SaveKey],
                Convert_From(
                    UPyt_GetBinByGD(
                        Array['@_OpenUrl_RecvBinMap', AS_SaveKey] ),
                    AS_Decode)
                /*---------*/
            /*###############*/ );
        END IF;

    END IF; /*################## IF-Main ####*/

    RETURN VY_RecvBody;
END;
$$ LANGUAGE plpgsql; /*FUN UPyt_OpenUrlEx(
    AS_Url     TEXT      , AS_SaveKey     TEXT='_Default', AS_Decode    TEXT='UTF8',
                           AI_MaxBodySize INT =0         , AI_TimeOut   INT =5     ,
    AS_HeadMap TEXT='{}' , AS_DataMap     TEXT='{}'      , AS_CookieMap TEXT='{}'  ,
    AS_ReqType TEXT='GET', AS_JsonMap     TEXT='{}') */
/*

    SELECT UPyt_OpenUrlEx('http://land.naver.com/article/', AI_MaxBodySize:=100000);
    SELECT UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']);

-- 2017-07-26 16:10:00 */


CREATE OR REPLACE FUNCTION UPyt_SaveUrl(
    AS_Url         TEXT         , AS_SaveFile  TEXT='_Default.txt', AI_RecvBodyUnit BIGINT=10000,
    AI_MaxBodySize BIGINT=0     , AI_TimeOut   INT =5             , AS_HeadMap      TEXT  ='{}' ,
    AS_DataMap     TEXT  ='{}'  , AS_CookieMap TEXT='{}'          , AB_DoAppend     BOOL  =TRUE ,
    AS_ReqType     TEXT  ='POST', AS_JsonMap   TEXT='') RETURNS BIGINT AS
$$
    """############################################################

    ■  AS_Url 의 수신 body 를 AI_RecvBodyUnit 만큼씩 읽어서 최대
        AI_MaxBodySize 만큼 AS_SaveFile 로 저장한다.
        AI_MaxBodySize 이 0 이면 전체 body 를 저장한다.

    ■  AS_CookieMap 는 아래 형태다.

        {
            "CookieKey1" : {"value":"val1", "domain":"", "path":""},
            "CookieKey2" : {"value":"val2", "domain":"", "path":""},
            "CookieKey3" : {"value":"val3", "domain":"", "path":""}
        }

    ############################################################"""
    
    import re, urllib, requests;
    
    VarsUrl         =args[0];
    VarsSaveFile    =args[1];
    VariRecvBodyUnit=args[2];
    VariMaxBodySize =args[3];
    VariTimeOut     =args[4];
    VarbDoAppend    =args[8];
    VarsReqType     =args[9];
    
    # plpy.notice("# Url=%s" % VarsUrl);
    
    GD["@_Error_"         ]="";
    GD["@_OpenUrl_ResCode"]="";
    GD["@_OpenUrl_Head"   ]="";
    
    VariAllRecvSize=0; VaroFile=None;
    
    try           :
        if VarbDoAppend: VaroFile=open(VarsSaveFile, "ba+");
        else           : VaroFile=open(VarsSaveFile, "bw+");
    except IOError:
        GD["@_Error_"]=("%s" % IOError ); return VariAllRecvSize;
    #************#:
    
    try:
        
        VaroHeadMap = {}  ;
        VaroDataMap = {}  ;
        VaroCookMap = {}  ;
        VaroJsonMap = {}  ;
        VaroRequest = None;
        VarpfRequest= None;
        VaroCookJar = requests.cookies.RequestsCookieJar();
        
        if len(args[5 ])>2: VaroHeadMap = eval(args[5 ]);
        if len(args[6 ])>2: VaroPostMap = eval(args[6 ]);
        if len(args[7 ])>2: VaroCookMap = eval(args[7 ]);
        if len(args[10])>2: VaroJsonMap = eval(args[10]);
        
        for VarsKey in VaroCookMap:
            VaroCookJar.set( 
                VarsKey, VaroCookMap[VarsKey].get("value" , ""),\
                domain=  VaroCookMap[VarsKey].get("domain", ""),\
                path  =  VaroCookMap[VarsKey].get("path"  , ""));
        #************************#:
        
        if   VarsReqType=="GET"    : VarpfRequest=requests.get    ;
        elif VarsReqType=="POST"   : VarpfRequest=requests.post   ;
        elif VarsReqType=="HEAD"   : VarpfRequest=requests.head   ;
        elif VarsReqType=="PUT"    : VarpfRequest=requests.put    ;
        elif VarsReqType=="OPTIONS": VarpfRequest=requests.options;
        else                       : VarpfRequest=requests.get    ;
        
        VaroRequest=VarpfRequest( \
            VarsUrl            , data   =VaroDataMap, cookies=VaroCookJar, \
            headers=VaroHeadMap, timeout=VariTimeOut, stream =True        );
        
        for VarbsChunk in \
            VaroRequest.iter_content(chunk_size=VariRecvBodyUnit):
            if  VariMaxBodySize>0 and \
                VariAllRecvSize+len(VarbsChunk)>=VariMaxBodySize:
            #---------------------------------------------------#
                VariNeedSize=VariMaxBodySize-VariAllRecvSize;
                VaroFile.write(VarbsChunk[0:VariNeedSize]);
                VariAllRecvSize=VariMaxBodySize;  break;
            #---------------------------------------------------#
            VaroFile.write(VarbsChunk);  VariAllRecvSize+=len(VarbsChunk);
        #*******************************************************#:
        
        GD["@_OpenUrl_ResCode"  ]= ("%s" % VaroRequest.status_code);
        GD["@_OpenUrl_Head"     ]= ("%s" % VaroRequest.headers    );
        GD["@_OpenUrl_CookieCnt"]= len(VaroRequest.cookies)        ;
        GD["@_OpenUrl_CookieStr"]= ("%s" % VaroRequest.cookies    );
        GD["@_OpenUrl_CookieMap"]= {}                              ;
        
        VariCookieNo=1; #*******************#:
        for VarsCookie in VaroRequest.cookies:
            GD["@_OpenUrl_CookieMap"] \
                [str(VariCookieNo)]=("%s" % VarsCookie);
            # plpy.notice("# Cookie=%s" % VarsCookie  );
            VariCookieNo=VariCookieNo+1;
        #***********************************#:
        
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    VaroFile.close();  return VariAllRecvSize;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_SaveUrl(
    AS_Url         TEXT       , AS_SaveFile  TEXT='_Default.txt', AI_RecvBodyUnit BIGINT=10000,
    AI_MaxBodySize BIGINT=0   , AI_TimeOut   INT =5             , AS_HeadMap      TEXT  ='{}' ,
    AS_DataMap     TEXT  ='{}', AS_CookieMap TEXT='{}'          , AB_DoAppend     BOOL  =TRUE ,
    AS_ReqType     TEXT  ='POST') RETURNS BIGINT*/
/*

    SELECT UPyt_SaveUrl('http://www.meosidda.com/web/ghost_mall/new_naver_shop.com.html.temp', AB_DoAppend:=FALSE, AI_MaxBodySize:=100);
    SELECT UPyt_SaveUrl('http://www.meosidda.com/web/ghost_mall/new_naver_shop.com.html.temp', AB_DoAppend:=FALSE);
    SELECT UPyt_ListLine('_Default.txt', 'UTF8', AI_MaxLine:=100);

    SELECT UPyt_SaveUrl('http://www.flymodel.co.kr/web/ghost_mall/new_naver_shop.com.html.temp', AB_DoAppend:=FALSE);
    SELECT UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_ListLine('_Default.txt', 'UTF8', AI_MaxLine:=100);

    SELECT UPyt_SaveUrl('http://www.bboram.co.kr/list/navernewopen_new.html', AB_DoAppend:=FALSE);
    SELECT UPyt_GetByGD('@_OpenUrl_ResCode'), UPyt_GetByGD('@_Error_'), UPyt_GetByGD('@_OpenUrl_Head');
    SELECT UPyt_ListLine('_Default.txt', 'UHC', AI_MaxLine:=10);

-- 2016-09-24 04:56:00 */


CREATE OR REPLACE FUNCTION UPyt_GetUrlImgSize(
    AS_Url      TEXT       , AI_TimeOut INT=5, AB_DoLog BOOL=FALSE,
    AS_TempName TEXT='Temp', AB_Delete BOOL=TRUE) RETURNS INT[] AS
$$
    """
        AS_Url 이 가리키는 이미지 파일의 가로, 세로 크기를 구한다.
        AS_TempName 는 다운받은 이미지를 저장하는 임시 파일명. -- 2016-04-09 04:56:00
        
        AB_Delete=TRUE 이면 다운받은 파일을 삭제한다. -- 2016-04-14 00;39:00
    """
    
    from PIL import Image;
    import os, re, urllib, http.cookiejar;
    
    VarsUrl      =args[0];
    VariTimeout  =args[1];
    VarbDoLog    =args[2];
    VarsTempFile =args[3];
    VarbDelete   =args[4];
    VarsTempFile2=""     ;
    VaraSize     =[0,0]  ;
    
    if len(VarsUrl)<1: return VaraSize;
    
   
    VarsUrlExt =re.sub(r"(.*\.)(.+)"    , r"\2", VarsUrl);
    VarsUrlPath=re.sub(r"(.*/)+(.+\..+)", r"\1", VarsUrl); # 참고용.
    VarsUrlFile=re.sub(r"(.*/)+(.+\..+)", r"\2", VarsUrl); # 참고용.
    
    """
        위 2 줄의 코드는 아래와 같다.
        
        VarsUrlPath=re.sub(r"(.*/)(.+\..+)", r"\1", VarsUrl);
        VarsUrlFile=re.sub(r"(.*/)(.+\..+)", r"\2", VarsUrl);
    """
    
    VaroImage     = None;
    VaroResponse  = None;
    VaroCookieJar = http.cookiejar.LWPCookieJar();
    VaroOpener = urllib.request.build_opener(
        urllib.request.HTTPCookieProcessor(VaroCookieJar) );
    urllib.request.install_opener(VaroOpener);
    
    try:
        
        VaroRequest = urllib.request.Request(VarsUrl);
        
        if VarbDoLog: plpy.notice("# Url=%s" %  VarsUrl);
        
        try   :
            VaroResponse= VaroOpener. \
                open(VaroRequest, None, VariTimeout);
        except Exception as ArgoE:
            if VarbDoLog:
                plpy.notice("! Request Error : %s" % ArgoE);
            return VaraSize;
        
        VaroHtml = VaroResponse.read(); #++++++++++++++++++#
        
        if VarbDoLog: plpy.notice(
            "# Response Code=%d, Recv Head >>>> %s" % \
                (VaroResponse.getcode(), VaroResponse.info() ) );
        
        if   len(VarsTempFile)>0:
            VarsTempFile2=VarsTempFile+"."+VarsUrlExt;
        elif len(VarsUrlFile )>0:
            VarsTempFile2=VarsUrlFile;
        else:
            VarsTempFile2="Temp"     ;
        
        VaroFile=open(VarsTempFile2, "bw+");
        VaroFile.write(VaroHtml);
        VaroFile.close(        );
        
        
        if VarbDoLog: plpy.notice(
            "# Saved Name=%s" % VarsTempFile2);
        
        try   :
            VaroImage = Image.open(VarsTempFile2);
        except:
            if VarbDoLog: plpy.notice(
                "! fail to open(%s)" % VarsTempFile2);
            if VarbDelete:
                try   : os.remove(VarsTempFile2);
                except: pass                    ;
            #**********************************#;
            return VaraSize;
        ######:
        
        
        VaraSize[0], VaraSize[1] = VaroImage.size ;
        
        VaroImage.close(); ########################
        
        if VarbDelete:
            try   : os.remove(VarsTempFile2);
            except: pass                    ;
    
    except Exception as ArgoE:
        if VarbDoLog:
            plpy.notice("! Error : %s" % ArgoE);
        return VaraSize;
    
    return VaraSize; #########
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_GetUrlImgSize(
    AS_Url      TEXT       , AI_TimeOut INT=5, AB_DoLog BOOL=FALSE,
    AS_TempName TEXT='Temp', AB_Delete BOOL=TRUE) RETURNS INT[] */
/*

    SELECT UPyt_GetUrlImgSize('http://bydeux.freeimg.mywisa.com/_data/product/201502/06/12790e5ce7b3ec8f4129040961e98783.jpg'   );
    SELECT UPyt_GetUrlImgSize('http://hiblogger.freeimg.mywisa.com/_data/product/201510/15/0a70335de14c1bd87c0e241b9a73a30b.jpg');
    SELECT UPyt_GetUrlImgSize('http://www.amai.co.kr/shopimages/chups/0230020004902.jpg');
    SELECT UPyt_GetUrlImgSize('http://www.amai.co.kr/shopimages/chups/0290060001022.jpg');

-- 2016-04-09 04:29:00 */


CREATE OR REPLACE FUNCTION
    UPyt_MakeBinHex(AY_Binary BYTEA) RETURNS TEXT AS
$$
    # AY_Binary 를 16진수 문자열로 바꾸어 반환한다.
    # DB 에서 ::TEXT 로 변환하면 앞에 \x 가 붙어서 성가시다.
    
    ArgyBinary = args[0];  return ''.join('%02x'%i for i in ArgyBinary);
$$
LANGUAGE plpython3u; /*FUNC
    UPyt_MakeBinHex(AY_Binary BYTEA) RETURNS TEXT*/


CREATE OR REPLACE FUNCTION UPyt_GetMxRecord(AS_Domain TEXT, AI_TimeOut INT=5) RETURNS TEXT[] AS
$$
    """
        dnspython 이 python3 과 연동이 잘 안되어서 nslookup 명령을
        사용하여 MX record 를 구한다.

        AI_TimeOut 은 추후를 위해 설계한 것. -- 2016-03-25 18:41:00
    """
    
    import re
    import sys
    import subprocess
    
    
    Vars_DEBUG="";
    Vari_DEBUG=0 ;
    try   :
        if "_DEBUG" in GD:
            Vars_DEBUG=GD["_DEBUG"];
        Vari_DEBUG=int(Vars_DEBUG) ;
    except:
        Vari_DEBUG=0; ##############
    
    
    VarsDomain=args[0];
    
    VaroMaxList = [] ;
    VarsCmd     = "" ;
    VarbsOutput = b'';
    VarsOutput  = "" ;
    
    VarsPlatform=sys.platform;
    
    if VarsPlatform.startswith('win'):
        
        try    :
            VarsCmd     = ("nslookup -type=mx %s" % VarsDomain ) ;
            VarbsOutput = subprocess.check_output(VarsCmd, shell = True );
            VarsOutput  = VarbsOutput.decode('UHC');
        except :
            return VaroMaxList;
        finally:
            if Vari_DEBUG>0: plpy.notice("# VarsCmd=%s" % VarsCmd);
        
        VaroPattern = re.compile(r"(?=mail\sexchanger\s\=\s)(.*)")
        VaroWordList=VaroPattern.findall(VarsOutput)
        VaroMaxList =[];
        
        for VarsWord in VaroWordList:
            VarsMxNo=None; VarsMxName=None;
            VarsMxName=VarsWord.replace("mail exchanger = ", "");
            VaroMaxList.append(VarsMxName);
        
        return VaroMaxList; ###############
        
    #if VarsPlatform.startswith('win'):
    
    
    try    :
        VarsCmd     = \
            ("nslookup -type=mx %s | grep 'mail exchanger = '" % VarsDomain ) ;
        VarbsOutput = subprocess.check_output(VarsCmd, shell = True );
        VarsOutput  = VarbsOutput.decode('UTF-8');
    except :
        return VaroMaxList;
    finally:
        if Vari_DEBUG>0: plpy.notice("# VarsCmd=%s" % VarsCmd);
    
    VaroPattern = re.compile(r"(?=mail\sexchanger\s\=\s)(.*)")
    VaroWordList=VaroPattern.findall(VarsOutput)
    
    for VarsWord in VaroWordList:
        VarsMxNo=None; VarsMxName=None;
        VarsMxNo, VarsMxName=VarsWord. \
            replace("mail exchanger = ", "").split(" ");
        VaroMaxList.append(VarsMxName);
    
    return VaroMaxList; ###############
$$
LANGUAGE plpython3u; /*UPyt_GetMxRecord(AS_Domain TEXT, AI_TimeOut INT=5) RETURNS TEXT[]*/
/*

    SELECT UPyt_AddInGD('_DEBUG', '1');

    SELECT UPyt_GetMxRecord('naver.com');

                        upyt_getmxrecord 
        ------------------------------------------------
         {mx3.naver.com.,mx1.naver.com.,mx4.naver.com.}

    SELECT UPyt_GetMxRecord('empal.com');
    SELECT UPyt_GetMxRecord('t.4');

    SELECT UPyt_GetMxRecord('daum.net');

                                   upyt_getmxrecord                            
        -----------------------------------------------------------------------
         {mx4.hanmail.net.,mx3.hanmail.net.,mx1.hanmail.net.,mx2.hanmail.net.}
        (1 row)

    SELECT UPyt_GetMxRecord('gmail.com');

        -[ RECORD 1 ]----+------------------------------------------------------------------------------------------------------------------------------------------------------------------
        upyt_getmxrecord | {alt3.gmail-smtp-in.l.google.com.,alt1.gmail-smtp-in.l.google.com.,gmail-smtp-in.l.google.com.,alt4.gmail-smtp-in.l.google.com.,alt2.gmail-smtp-in.l.google.com.}

-- 2016-03-25 18:03:00 */


CREATE OR REPLACE FUNCTION UPyt_SendMail(
    AS_Sender   TEXT , ASA_Recver  TEXT[]      , AS_Subjec    TEXT       , AS_Content   TEXT       ,
    AS_MxDomain TEXT , AS_MimeType TEXT='plain', ASA_SaveFile TEXT[]='{}', ASA_FileName TEXT[]='{}',
    AI_Port     INT=0, AI_TimeOut  INT =5 ) RETURNS INT AS
$$
    """
    ■  AS_MimeType 이 "html" 이면 AS_Content 도 html 형식이어야 한다.
    ■  첨부파일 배열 ASA_SaveFile 의 각 파일에 대해 별도의 파일명을 설정하고 싶다면,
        ASA_FileName 에 설정한다. -- 2016-10-16 08:05:00
    """
    
    GD["@_Error_"]="";
    
    try    :
        import os, sys, smtplib, mimetypes  ;
        
        from email    import encoders       ;
        from optparse import OptionParser   ;
        
        from email.header         import Header         ;
        from email.message        import Message        ;
        from email.mime.text      import MIMEText       ;
        from email.mime.audio     import MIMEAudio      ;
        from email.mime.base      import MIMEBase       ;
        from email.mime.image     import MIMEImage      ;
        from email.mime.multipart import MIMEMultipart  ;
    except:
        GD["@_Error_"]="import Error";  return int(False);
    #****#:
    
    
    VarsComma    = ', '     ;
    VarsSender   = args[0]  ;
    VaraRecver   = args[1]  ;
    VarsSubject  = Header(s=args[2], charset="utf-8");
    VarsContent  = args[3]  ;
    VarsMxDomain = args[4]  ;
    VarsMimeType = args[5]  ;
    VaraSaveName = args[6]  ;
    VaraFileName = args[7]  ;
    VariSmptPort = args[8]  ;
    VariTimeOut  = args[9]  ;
    
    if VariSmptPort<1   : VariSmptPort=25     ;
    if VariTimeOut <1   : VariTimeOut =1      ;
    if VarsMimeType=="" : VarsMimeType="plain";
    
    if VarsSender  =="" : GD["@_Error_"]="Empty Sender"   ; return int(False);
    if len(VaraRecver)<1: GD["@_Error_"]="Empty Recver"   ; return int(False);
    if VarsSubject =="" : GD["@_Error_"]="Empty Subect"   ; return int(False);
    if VarsContent =="" : GD["@_Error_"]="Empty Content"  ; return int(False);
    if VarsMxDomain=="" : GD["@_Error_"]="Empty MX Domain"; return int(False);
    
    
    VaroMultiPart= MIMEMultipart();
    
    VaroMultiPart['Subject'] = VarsSubject               ;
    VaroMultiPart['To'     ] = VarsComma.join(VaraRecver);
    VaroMultiPart['From'   ] = VarsSender                ;
    VaroMultiPart.preamble   = \
        'You will not see this in a MIME-aware mail reader.\n';
    
    VaroMimeText = MIMEText(
        VarsContent, VarsMimeType, _charset="utf-8");
    VaroMultiPart.attach(VaroMimeText);
    
    try:
        
        for (i, VarsFile) in enumerate(VaraSaveName):
            VaroMimeBase = MIMEBase("application", "octet-stream");
            VaroMimeBase.set_payload(open(VarsFile, "rb").read()) ;
            encoders.encode_base64(VaroMimeBase);
            
            VarsFileName="";
            if i<len(VaraFileName):
                VarsFileName=VaraFileName[i]; #********#
            if VarsFileName==""   :
                VarsFileName=os.path.basename(VarsFile);
            
            VaroMimeBase.add_header(
                "Content-Disposition", "attachment", filename=VarsFileName);
            VaroMultiPart.attach(VaroMimeBase)
        
    except IOError:
        GD["@_Error_"]="File Open Error"; return int(False);
    #************#:
    
    
    try   :
        VaroSmtpLib = smtplib.SMTP(
            VarsMxDomain, VariSmptPort, timeout=VariTimeOut);
        VaroSmtpLib.      sendmail(
            VarsSender, VaraRecver, VaroMultiPart.as_string());
        VaroSmtpLib.quit();
    except IOError:
        GD["@_Error_"] = ("Send Error : %s" % IOError);
        
        return int(False); """ ******************** """
    #************#:
    
    return int(True);
$$
LANGUAGE plpython3u; /* UPyt_SendMail(
    AS_Sender   TEXT , ASA_Recver  TEXT[]      , AS_Subjec    TEXT       , AS_Content   TEXT       ,
    AS_MxDomain TEXT , AS_MimeType TEXT='plain', ASA_SaveFile TEXT[]='{}', ASA_FileName TEXT[]='{}',
    AI_Port     INT=0, AI_TimeOut  INT =5 ) RETURNS INT */
/*

    SELECT UPyt_SendMail(
        'akbarofmg@naver.com', '{akbarofmg@naver.com}', '레판토 해전',
        '그러나 지중해에서는 일이 그리 간단하지가 않았다.', 'mx1.naver.com', 'plain',
        '{my.txt, your.txt}'::TEXT[], '{내-파일.txt, 니-파일.txt}'::TEXT[]);
    SELECT UPyt_GetByGD('@_Error_');

    SELECT UPyt_SendMail(
        'akbarofmg@naver.com', '{akbarofmg@naver.com}', '레판토 해전',
        '그러나 지중해에서는 일이 그리 간단하지가 않았다.', 'mx1.naver.com',
        'plain', '{my.txt, your.txt}'::TEXT[]);
    SELECT UPyt_GetByGD('@_Error_');

    SELECT UPyt_SendMail(
        'akbarofmg@naver.com', '{akbarofmg@naver.com}', '레판토 해전',
        '<h1>그러나 지중해에서는 일이 그리 간단하지가 않았다.</h1>',
        'mx1.naver.com', 'html'                                    );

    SELECT UPyt_SendMail(
        'admin@styledonut.com', '{akbarofmg@daum.net}', '레판토 해전',
        '<h1>그러나 지중해에서는 일이 그리 간단하지가 않았다.</h1>',
        'mx1.hanmail.net', 'html'                                   );

    SELECT UPyt_SendMail(
        'admin@styledonut.com', '{akbarofmg@gmail.com}', '레판토 해전',
        '<h1>그러나 지중해에서는 일이 그리 간단하지가 않았다.</h1>',
        'alt1.gmail-smtp-in.l.google.com', 'html'                   );

    SELECT UPyt_GetByGD('@_Error_');

-- 2016-03-25 22:32:00 */


CREATE OR REPLACE FUNCTION UPyt_MysqlInit(
    AS_ObjKey TEXT='', AS_Host   TEXT='127.0.0.1', AS_User TEXT='root',
    AS_Pass   TEXT='', AS_DBName TEXT='mysql'    , AI_Port INT =3306  , AI_TimeOut INT=5) RETURNS INT AS
$$
    
    GD["@_Error_"]="";
    
    ConsMysqlMainKey="_MysqlConn_";
    VaroConnObj     =None         ;
    VaromConnMap    ={}           ;
    
    if ConsMysqlMainKey not in GD:
        GD[ConsMysqlMainKey] = {} ;
    
    try    :
        import pymysql;
    except :
        GD["@_Error_"]="import Error";  return int(False);
    #######:
    
    VarsObjKey  = args[0];
    VarsConnHost= args[1];
    VarsConnUser= args[2];
    VarsConnPass= args[3];
    VarsConnName= args[4];
    VariConnPort= args[5];
    VariTimeOut = args[6];
    
    if VarsObjKey  =="": VarsObjKey  ="_Default_";
    if VarsConnHost=="": VarsConnHost="127.0.0.1";
    if VarsConnUser=="": VarsConnUser="root"     ;
    if VarsConnName=="": VarsConnName="mysql"    ;
    if VariConnPort==0 : VariConnPort=3306       ;
    
    try   :
        if VarsObjKey in GD[ConsMysqlMainKey]:
            GD["@_Error_"] = "Already Exists"; return int(True);
    except:
        GD[ConsMysqlMainKey]={};
    
    try:
        VaroConnObj = pymysql.connect( #*****#
            host  =VarsConnHost ,
            user  =VarsConnUser ,
            passwd=VarsConnPass ,
            db    =VarsConnName ,
            port  =VariConnPort ,
            connect_timeout=VariTimeOut); #**#
        
    except Exception as ArgoE:
        GD["@_Error_"] = \
            ("! fail to Connect : %s"  % ArgoE);
        return int(False);
    
    VaromConnMap["Conn"]=VaroConnObj ;
    VaromConnMap["Host"]=VarsConnHost;
    VaromConnMap["User"]=VarsConnUser;
    VaromConnMap["Pass"]=VarsConnPass;
    VaromConnMap["Name"]=VarsConnName;
    VaromConnMap["Port"]=VariConnPort;
    VaromConnMap["Curs"]=VaroConnObj.cursor();
    VaromConnMap["Curs"].execute("SET Names UTF8");
    
    GD[ConsMysqlMainKey][VarsObjKey]=VaromConnMap;
    
    return int(True); #**************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_MysqlInit(
    AS_ObjKey TEXT='', AS_Host   TEXT='127.0.0.1', AS_User TEXT='root',
    AS_Pass   TEXT='', AS_DBName TEXT='mysql'    , AI_Port INT =3306  , AI_TimeOut INT=5) RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_MysqlFini(AS_ObjKey TEXT='') RETURNS INT AS
$$
    
    ConsMysqlMainKey="_MysqlConn_";
    VarsObjKey      = args[0]     ;
    
    if VarsObjKey=="": VarsObjKey="_Default_";
    
    if ConsMysqlMainKey not in GD: return int(False);
    
    try   :
        GD[ConsMysqlMainKey][VarsObjKey]["Conn"].close();
        GD[ConsMysqlMainKey][VarsObjKey]["Curs"].close();
        
        del GD[ConsMysqlMainKey][VarsObjKey]; #*********#
    except:
        return int(False);
    
    return int(True); #**#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_MysqlFini(AS_ObjKey TEXT='') RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_MysqlDesc(AS_ObjKey TEXT='') RETURNS TEXT AS
$$
    ConsMysqlMainKey="_MysqlConn_";
    VarsObjKey      = args[0]     ;
    
    if VarsObjKey=="": VarsObjKey="_Default_";
    
    try   :
        return "%s" % GD[ConsMysqlMainKey][VarsObjKey];
    except:
        return ""; #**********************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_MysqlDesc(AS_ObjKey TEXT='') RETURNS TEXT*/

CREATE OR REPLACE FUNCTION UPyt_MysqlDescRow() RETURNS SETOF TEXT AS
$$
    ConsMysqlMainKey="_MysqlConn_";
    
    try   :
        for VarsConnKey in GD[ConsMysqlMainKey].keys():
            yield "key=%s : %s" % \
                (VarsConnKey, GD[ConsMysqlMainKey][VarsConnKey]);
    except: return; #*********************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_MysqlDescRow() RETURNS SETOF TEXT*/


CREATE OR REPLACE FUNCTION UPyt_MysqlQuery(
    AS_Query TEXT, AS_ObjKey TEXT='') RETURNS SETOF RECORD AS
$$
    ConsMysqlMainKey="_MysqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_Default_";
    
    try   : VaroCursor = \
        GD[ConsMysqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"; return;
    
    try   : VaroCursor. \
        execute(VarsQuery.encode("UTF8"));
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return;
    
    VaroNowRow=VaroCursor.fetchone();
    
    while VaroNowRow is not None:
        yield VaroNowRow; VaroNowRow \
            = VaroCursor.fetchone();
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_MysqlQuery(
    AS_Query TEXT, AS_ObjKey TEXT='') RETURNS SETOF RECORD*/


CREATE OR REPLACE FUNCTION UPyt_MysqlQueryNone(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS BOOL AS
$$
    """ 결과 값이 없는 쿼리를 수행한다. """
    ConsMysqlMainKey="_MysqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_Default_";
    
    try   : VaroCursor = \
        GD[ConsMysqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"  ; return False;
    
    try   : VaroCursor. \
        execute(VarsQuery.encode("UTF8"));
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return False;
    
    VaroNowRow=VaroCursor.fetchone();
    
    while VaroNowRow is not None:
        if args[2]:
            plpy.notice("# data : %s" % VaroNowRow[0]);
        #********#:
        VaroNowRow = VaroCursor.fetchone();
        """ row 를 그냥 버린다.         """
    
    return True; #************************#
$$
LANGUAGE plpython3u; /*UPyt_MysqlQueryNone(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS BOOL*/


CREATE OR REPLACE FUNCTION UPyt_MysqlQueryOne(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS TEXT AS
$$
    """ 결과 값이 하나인 쿼리를 수행한다. """
    ConsMysqlMainKey="_MysqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_Default_";
    
    try   : VaroCursor = \
        GD[ConsMysqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"; return False;
    
    try   : VaroCursor. \
        execute(VarsQuery.encode("UTF8"));
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return False;
    
    VaroNowRow=VaroCursor.fetchone();
    
    if VaroNowRow is None: return "";
    
    
    VarsValue =VaroNowRow[0]        ;
    VaroNowRow=VaroCursor.fetchone();
    
    while VaroNowRow is not None:
        if args[2]:
            plpy.notice("# data : %s" % VaroNowRow[0]);
        #********#:
        VaroNowRow = VaroCursor.fetchone();
        """ row 를 그냥 버린다.         """
    
    return VarsValue; #********#:
$$
LANGUAGE plpython3u; /*UPyt_MysqlQueryOne(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS TEXT*/
/*

    -- mysql 프로토콜을 사용하는 sphinx 에 접속하는 예.

    SELECT UPyt_MysqlInit('', '', '', '', '', 9306);
    SELECT UPyt_MysqlInit('', '', '', '', '', 9306), UPyt_GetByGD('@_Error_');
    SELECT UPyt_MysqlDesc('');

    SELECT * FROM UPyt_MysqlQuery('SELECT 1') AS T(T1 int);

    SELECT * FROM UPyt_MysqlQuery(
        'SELECT id, GdsDspl_Name, OrderDay FROM DGdsDspl_GoodsDisplay
            WHERE  MATCH(''"후드""티"'') ORDER BY OrderDay DESC LIMIT 4')
        AS T(T1 BIGINT, T2 TEXT, T3 TEXT);
    SELECT UPyt_GetByGD('@_Error_');

    SELECT UPyt_MysqlFini('');

-- 2016-04-23 11:34:00 */


/*#######################################################

"""

    # a example in which pymysql is used
    
    #-*- coding: utf-8 -*-
    
    import pymysql
    
    VaroConnSphinx=None;
    
    try:
        VaroConnSphinx = pymysql.connect( ######
            host  ="127.0.0.1"  ,
            user  ="root"       ,
            passwd=""           ,
            db    =""           ,
            port  =9306         ,
            connect_timeout=5); ################
        
    except Exception as ArgoE:
        print("! fail to Connect Sphinx : %s"  % ArgoE);
    
    
    VaroCurSphinx = VaroConnSphinx.cursor();
    VarsFethQry   = " SELECT * FROM DShpGds_ShopGoods_delta WHERE " + \
                    " MATCH('\"후드\"\"티\"') ORDER BY ShpGds_Day DESC LIMIT 4" ;
    
    print("# Fetch Query=%s" % VarsFethQry);
    
    VaroCurSphinx.execute("Set Names UTF8");
    VaroCurSphinx.execute(VarsFethQry.encode("UTF8")) ;
    VaroNowRow=VaroCurSphinx.fetchone();
    
    while VaroNowRow is not None:
        
        print(VaroNowRow);
        
        VaroNowRow=VaroCurSphinx.fetchone();
"""
#######################################################*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlInit(
    AS_ObjKey TEXT='', AS_Host   TEXT='127.0.0.1', AS_User TEXT='postgres',
    AS_Pass   TEXT='', AS_DBName TEXT='template1', AI_Port INT =5432      , AI_TimeOut INT=5) RETURNS INT AS
$$
    
    GD["@_Error_"]="";
    
    ConsPgsqlMainKey="_PgsqlConn_";
    VaroConnObj     =None         ;
    VaromConnMap    ={}           ;
    
    if ConsPgsqlMainKey not in GD :
        GD[ConsPgsqlMainKey] = {} ;
    
    try    :
        import psycopg2 as PG2    ;
        import psycopg2.extensions;
    except :
        GD["@_Error_"]="import Error";  return int(False);
    #*****#:
    
    VarsObjKey  = args[0];
    VarsConnHost= args[1];
    VarsConnUser= args[2];
    VarsConnPass= args[3];
    VarsConnName= args[4];
    VariConnPort= args[5];
    VariTimeOut = args[6];
    
    if VarsObjKey  =="": VarsObjKey  ="_DefaultPG_";
    if VarsConnHost=="": VarsConnHost="127.0.0.1";
    if VarsConnUser=="": VarsConnUser="postgres" ;
    if VarsConnName=="": VarsConnName="template1";
    if VariConnPort==0 : VariConnPort=5432       ;
    
    try   :
        if VarsObjKey in GD[ConsPgsqlMainKey]:
            GD["@_Error_"] = "Already Exists"; return int(True);
    except:
        GD[ConsPgsqlMainKey]={};
    
    try:
        VarsConnStr = ( \
            "host='%s'     dbname ='%s' user='%s' "         \
            "password='%s' port   =%s   connect_timeout=%s" %
             (  VarsConnHost, VarsConnName, VarsConnUser  , \
                VarsConnPass, VariConnPort, VariTimeOut ) ) ;
        VaroConnObj = PG2.connect(VarsConnStr);
        
    except Exception as ArgoE:
        GD["@_Error_"] = \
            ("! fail to Connect : %s"  % ArgoE);
        return int(False)    ;
    
    VaromConnMap["Conn"]=VaroConnObj ;
    VaromConnMap["Host"]=VarsConnHost;
    VaromConnMap["User"]=VarsConnUser;
    VaromConnMap["Pass"]=VarsConnPass;
    VaromConnMap["Name"]=VarsConnName;
    VaromConnMap["Port"]=VariConnPort;
    VaromConnMap["Curs"]=VaroConnObj.cursor();
    VaromConnMap["Curs"].execute("SET Client_Encoding='UTF8'");
    
    GD[ConsPgsqlMainKey][VarsObjKey]=VaromConnMap;
    
    return int(True); #**************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_PgsqlInit(
    AS_ObjKey TEXT='', AS_Host   TEXT='127.0.0.1', AS_User TEXT='postgres',
    AS_Pass   TEXT='', AS_DBName TEXT='template1', AI_Port INT =5432      , AI_TimeOut INT=5) RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlFini(AS_ObjKey TEXT='') RETURNS INT AS
$$
    
    ConsPgsqlMainKey="_PgsqlConn_";
    VarsObjKey      = args[0]     ;
    
    if VarsObjKey=="": VarsObjKey="_DefaultPG_";
    
    if ConsPgsqlMainKey not in GD: return int(False);
    
    try   :
        GD[ConsPgsqlMainKey][VarsObjKey]["Conn"].close();
        GD[ConsPgsqlMainKey][VarsObjKey]["Curs"].close();
        
        del GD[ConsPgsqlMainKey][VarsObjKey]; #*********#
    except:
        return int(False);
    
    return int(True); #**#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_PgsqlFini(AS_ObjKey TEXT='') RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlDesc(AS_ObjKey TEXT='') RETURNS TEXT AS
$$
    ConsPgsqlMainKey="_PgsqlConn_";
    VarsObjKey      = args[0]     ;
    
    if VarsObjKey=="": VarsObjKey="_DefaultPG_";
    
    try   :
        return "%s" % GD[ConsPgsqlMainKey][VarsObjKey];
    except:
        return ""; #**********************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_PgsqlDesc(AS_ObjKey TEXT='') RETURNS TEXT*/

CREATE OR REPLACE FUNCTION UPyt_PgsqlDescRow() RETURNS SETOF TEXT AS
$$
    ConsPgsqlMainKey="_PgsqlConn_";
    
    try   :
        for VarsConnKey in GD[ConsPgsqlMainKey].keys():
            yield "key=%s : %s" % \
                (VarsConnKey, GD[ConsPgsqlMainKey][VarsConnKey]);
    except: return; #*********************************#
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_PgsqlDescRow() RETURNS SETOF TEXT*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlQuery(
    AS_Query TEXT, AS_ObjKey TEXT='') RETURNS SETOF RECORD AS
$$
    ConsPgsqlMainKey="_PgsqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    VaroNowRow      = None        ;
    
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_DefaultPG_" ;
    
    try   : VaroCursor = \
        GD[ConsPgsqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"  ; return;
    
    try   :
        VaroCursor. \
            execute(VarsQuery.encode("UTF8"));
        VaroNowRow=VaroCursor.fetchone();
        while VaroNowRow is not None    :
            yield VaroNowRow;
            VaroNowRow = VaroCursor.fetchone();
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return;
    """
    ■  fetchone() 에서 아래 에러가 떨어질 수 있다.

            'cp949' codec can't decode byte 0xec in position 253: illegal multibyte sequence

        이것을 피해갈려면, 쿼리 자체에서 BYTEA 형으로 바꾸거나 BYTE 형을 다시 TEXT 로 변환
        하는 부분이 있어야 한다. -- 2016-12-17 22:59:00
    """
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_PgsqlQuery(
    AS_Query TEXT, AS_ObjKey TEXT='') RETURNS SETOF RECORD*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlQueryNone(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS BOOL AS
$$
    """ 결과 값이 없는 쿼리를 수행한다. """
    
    ConsPgsqlMainKey="_PgsqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    VaroNowRow      = None        ;
    
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_DefaultPG_" ;
    
    try   : VaroCursor = \
        GD[ConsPgsqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"  ; return False;
    
    try   : VaroCursor. \
        execute(VarsQuery.encode("UTF8"));
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return False;
    
    return True; #**********************#;
$$
LANGUAGE plpython3u; /*UPyt_PgsqlQueryNone(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS BOOL*/


CREATE OR REPLACE FUNCTION UPyt_PgsqlQueryOne(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS TEXT AS
$$
    """ 결과 값이 하나인 쿼리를 수행한다. """
    
    ConsPgsqlMainKey="_PgsqlConn_";
    
    VarsQuery       = args[0]     ;
    VarsObjKey      = args[1]     ;
    VaroCursor      = None        ;
    VaroNowRow      = None        ;
    GD["@_Error_"]  = ""          ;
    
    
    if VarsObjKey=="": VarsObjKey="_DefaultPG_" ;
    
    try   : VaroCursor = \
        GD[ConsPgsqlMainKey][VarsObjKey]["Curs"];
    except:
        GD["@_Error_"]="No Cursor"  ; return "" ;
    
    try   : VaroCursor. \
        execute(VarsQuery.encode("UTF8"));
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return "" ;
    
    try   :
        VaroNowRow=VaroCursor.fetchone();
        
        if VaroNowRow is None: return "";
        
        
        VarsValue =VaroNowRow[0]        ;
        VaroNowRow=VaroCursor.fetchone();
        
        while VaroNowRow is not None:
            if args[2]:
                plpy.notice("# data : %s" % VaroNowRow[0]);
            VaroNowRow = VaroCursor.fetchone();
            #* row 를 그냥 버린다. **********#;
        
    except Exception as AroE:
        GD["@_Error_"]=("%s" % AroE); return "" ;
    
    return VarsValue; #****#:
$$
LANGUAGE plpython3u; /*UPyt_PgsqlQueryOne(
    AS_Query TEXT, AS_ObjKey TEXT='', AB_DoLog BOOL=False) RETURNS TEXT*/
/*

    SELECT UPyt_PgsqlInit(
        AS_User:='styledonut', AS_Pass:='styledonut_pw', AS_DBName:='d_styledonut');

    SELECT UPyt_PgsqlDesc   ();
    SELECT UPyt_PgsqlDescRow();
    SELECT UPyt_PgsqlQueryNone('SET Client_Encoding=UTF8');
    SELECT Convert_From(T1::BYtea, 'UTF8') FROM UPyt_PgsqlQuery(
        ' SELECT Row_To_Json(DLog)::TEXT::bytea::TEXT FROM DLog ORDER BY Lg_No DESC LIMIT 3') As T(T1 TEXT);

    SELECT UPyt_PgsqlFini();

*/


CREATE OR REPLACE FUNCTION UPyt_CImage_GetSize(
    AS_ImgFile TEXT, AB_DoLog BOOL=FALSE) RETURNS INT[] AS
$$
    """
        AS_ImgFile 이미지 파일의 가로, 세로 크기를 구한다. -- 2016-05-16 13:48:00
    """
    
    from PIL import Image;
    
    VarsImgFile =args[0] ;
    VarbDoLog   =args[1] ;
    VaraSize    =[0,0]   ;
    VaroImage   = None   ;
    
    if len(VarsImgFile)<1: return VaraSize;
    
    try                      :
        VaroImage = Image.open(VarsImgFile);
    except Exception as ArgoE:
        
        if VarbDoLog: plpy.notice(
            "! fail to open(%s) :%s " % (VarsImgFile, ArgoE) );
        
        return VaraSize;    
    #*****#    
    
    VaraSize[0], VaraSize[1] = VaroImage.size;
    
    VaroImage.close();  return VaraSize; #####
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_CImage_GetSize(
    AS_ImgFile TEXT, AB_DoLog BOOL=FALSE) RETURNS INT[]*/
/*

    SELECT UPyt_CImage_GetSize('/home/sauron/my.gif', TRUE);
    SELECT UPyt_CImage_GetSize('/home/styledonut/html/apache_pb.png', TRUE);
    SELECT UPyt_CImage_GetSize('/home/styledonut/html/apache_pb.gif', TRUE);

        Time: 3.811 ms
        d_styledonut=>     SELECT UPyt_CImage_GetSize('/home/styledonut/html/apache_pb.png', TRUE);
         upyt_cimage_getsize 
        ---------------------
         {259,32}
        (1 row)

        Time: 16.235 ms
        d_styledonut=>     SELECT UPyt_CImage_GetSize('/home/styledonut/html/apache_pb.gif', TRUE);
         upyt_cimage_getsize 
        ---------------------
         {50,20}
        (1 row)

-- 2016-05-16 14:09:00 */


CREATE OR REPLACE FUNCTION UPyt_CImage_Crop(
    AS_ImgFile TEXT, AI_MaxWidth INT, AI_MaxHeight INT, AB_DoLog BOOL=FALSE) RETURNS TEXT AS
$$
    """
        AS_ImgFile 이미지의 가로, 세로 크기가 AI_MaxWidth 나 AI_MaxHeight 을 넘으면,
        이 길이에 맞게 이미지를 자른다. -- 2016-05-16 14:16:00
    """
    
    import os, os.path; from PIL import Image;
    
    def CropImage(ArgsImgIn, ArgiMaxWidth, ArgiMaxHeight):
    
        VarsaFileSplit = os.path.splitext(ArgsImgIn);
        
        if VarsaFileSplit[1]=='': return "No Ext";
        
        VarsImgOut = \
            VarsaFileSplit[0]+"_new."+VarsaFileSplit[1];
        
        try:
            
            VaroImgIn = Image.open(ArgsImgIn)   ;
            (VariImgX, VariImgY)=VaroImgIn.size ;
            
            if VariImgX<=ArgiMaxWidth and VariImgY<=ArgiMaxHeight:
                VaroImgIn.close(); return "Need not to crop";
            
            if ArgiMaxWidth >VariImgX: ArgiMaxWidth =VariImgX;
            if ArgiMaxHeight>VariImgY: ArgiMaxHeight=VariImgY;
            
            VaroBox   = (0, 0, ArgiMaxWidth, ArgiMaxHeight);
            VaroImgOut= VaroImgIn.crop(VaroBox)         ;
            VaroImgOut.save(VarsImgOut)                 ;
            
            VaroImgIn.close(); VaroImgOut.close(); ######
            
            os.remove(ArgsImgIn);
            os.rename(VarsImgOut, ArgsImgIn);
            
        except Exception as ArgoE: return ("%s" % ArgoE);
        
        return ""; ######################################
    
    #def CropImage(ArgsImgIn, ArgiMaxWidth, ArgiMaxHeight):
    
    
    VarbDoLog =args[3];
    VarsMesage=CropImage(args[0], args[1], args[2]);
    
    if VarbDoLog: plpy.notice(VarsMesage);
    
    return VarsMesage; ###################
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_CImage_Crop(
    AS_ImgFile TEXT, AI_MaxWidth INT, AI_MaxHeight INT, AB_DoLog BOOL=FALSE) RETURNS INT[]*/
/*

    SELECT UPyt_CImage_GetSize('/usr/local/pgsql/data/apache_pb.png', TRUE);

    \! cp /usr/local/pgsql/data/apache_pb.png /usr/local/pgsql/data/apache_pb2.png

    SELECT UPyt_CImage_Crop('/usr/local/pgsql/data/apache_pb2.png', 200, 30, TRUE);

        Time: 3.811 ms
        d_styledonut=> SELECT UPyt_CImage_GetSize('/usr/local/pgsql/data/apache_pb.png', TRUE);
         upyt_cimage_getsize 
        ---------------------
         {259,32}
        (1 row)

        Time: 16.235 ms
        d_styledonut=> SELECT UPyt_CImage_GetSize('/usr/local/pgsql/data/apache_pb2.png', TRUE);
         upyt_cimage_getsize 
        ---------------------
         {200,30}
        (1 row)

-- 2016-05-16 14:48:00 */


CREATE OR REPLACE FUNCTION UPyt_ListFile(
    AS_Direct   TEXT=''   , AB_AddDir   BOOL=FALSE, AS_Pattern TEXT='',
    AB_OnlyFile BOOL=FALSE, AS_Encoding TEXT='utf-8'
) RETURNS SETOF TEXT AS /*#############*/
$$
    import os, re;
    
    VarsFile    =""     ;
    VarsDirect  =args[0];
    VarbAddDir  =args[1];
    VarsPattern =args[2];
    VarbOnlyFile=args[3];
    VarsEncoding=args[4];
    VarsFullPath=""     ;
    
    if len(VarsDirect)<1: VarsDirect=os.getcwd();
    
    try:
        
        for VarsFile in os.listdir(VarsDirect):
            
            if len(VarsEncoding)>0:
                """ 아래 코드는 python(3 이상)버전별로 확인이 필요하다.
                    일단 3.6.8 에서는 정상.
                """
                VarsFile=VarsFile.encode(
                    VarsEncoding, "surrogateescape").decode(VarsEncoding);
            if VarsPattern!='':
                if re.compile(VarsPattern).match(VarsFile)==None: continue;
            if VarbOnlyFile:
                VarsFullPath=os.path.join(VarsDirect, VarsFile);
                if os.path.isdir(VarsFullPath):
                    continue;
                #*****************************#
            if VarbAddDir:
                yield os.path.join(VarsDirect, VarsFile);
            else:
                yield VarsFile; """ ***************** """
        ######################################:
    
    except Exception as ArgoE: plpy.notice("%s" % ArgoE);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ListFile(
    AS_Direct   TEXT=''   , AB_AddDir   BOOL=FALSE, AS_Pattern TEXT='',
    AB_OnlyFile BOOL=FALSE, AS_Encoding TEXT='utf-8'
) RETURNS SETOF TEXT #######################*/
/*

    SELECT UPyt_ListFile();
    SELECT UPyt_ListFile('', TRUE);

    SELECT UPyt_ListFile('', FALSE, '.*txt');
    SELECT UPyt_ListFile('', false, E'.*\.txt');

    -- 아래 2 개 쿼리에서 AS_Pattern 의 값은 같다.
    SELECT UPyt_ListFile('', AS_Pattern:='\d*.txt'  );
    SELECT UPyt_ListFile('', AS_Pattern:=E'\\d*.txt');
         upyt_listfile
        ---------------
         682.txt
         677.txt
         684.txt
         674.txt
         675.txt
         678.txt
         683.txt
         676.txt
         679.txt
         681.txt
        (10 rows)

    SELECT UPyt_DeleteFile(File)
        FROM UPyt_ListFile('', AS_Pattern:=E'\\d*.txt') AS File;

-- 2016-05-16 15:40:00 */


CREATE OR REPLACE FUNCTION UPyt_ListDir(
    AS_Direct TEXT='.', AB_ExcludeDir BOOL=FALSE, AB_HaveSize BOOL=FALSE)
RETURNS SETOF TEXT[] AS /*############*/
$$
    import os;  from os.path import join, getsize;
    
    VarsFile    =""     ;
    VarsNowDir  =args[0];
    VarbExclDir =args[1];
    VarbHaveSize=args[2];
    
    for VarsRoot, VaraDirs, VaraFiles in os.walk(VarsNowDir):
        if VarbExclDir==False:
            yield (VarsRoot, "", len(VaraFiles), 0);
        
        for VarsFile in VaraFiles:
            if VarbHaveSize==False:
                yield (VarsRoot, VarsFile, 0, 0       );
            else:
                yield (VarsRoot, VarsFile, 0,
                    getsize(join(VarsRoot, VarsFile)) );
    #++++++++++++++++++++++++++++++++++++++++++++++++++++++#:
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ListDir(
    AS_Direct TEXT='.', AB_ExcludeDir BOOL=FALSE, AB_HaveSize BOOL=FALSE)
RETURNS SETOF TEXT[] #####################*/


CREATE OR REPLACE FUNCTION UPyt_ListDirFile(
    AS_Direct TEXT='.', AB_HaveSize BOOL=FALSE) RETURNS SETOF TEXT[] AS
$$
    # 디렉토리의 파일 정보만 출력하는데, 디렉토리와 파일명을 붙인다.
    # 주로 파일 단위 작업을 할 때 UPyt_ListDir() 보다 편할 것이다.
    # -- 2016-12-23 15:19:00
    
    import os;  from os.path import join, getsize;
    
    VarsFile    =""     ;
    VarsNowDir  =args[0];
    VarbHaveSize=args[1];
    
    for VarsRoot, VaraDirs, VaraFiles in os.walk(VarsNowDir):
        for VarsFile in VaraFiles:
            if VarbHaveSize==False:
                yield [join(VarsRoot, VarsFile)       ];
                """#####################################
                    yield (join(VarsRoot, VarsFile));
                    은 문자의 배열이 반환됨에 주의.
                #####################################"""
            else:
                yield (join(VarsRoot, VarsFile),
                    getsize(join(VarsRoot, VarsFile)) );
    #++++++++++++++++++++++++++++++++++++++++++++++++++++++#:
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ListDirFile(
    AS_Direct TEXT='.', AB_HaveSize BOOL=FALSE) RETURNS SETOF TEXT[]*/


CREATE OR REPLACE FUNCTION UPyt_ShellExec(
    AS_Command TEXT, AB_SaveText BOOL=FALSE, AS_Encode TEXT='UHC') RETURNS INT AS
$$
    
    import sys, subprocess;
    
    VarsCommand =args[0];
    VarbSaveText=args[1];
    VarsEncode  =args[2];
    
    GD["@_Error_"] = "" ;
    
    if VarbSaveText==False:
        try                      :
            subprocess.check_output(VarsCommand, shell = True );
        except Exception as ArgoE:
            GD["@_Error_"] = ("%s" % ArgoE);  return int(False);
        
        return int(True);
    #*********************#
    
    try                      :
        GD["@_MessageBin_"] = subprocess.check_output(VarsCommand, shell = True );
        GD["@_Message_"   ] = GD["@_MessageBin_"].decode(VarsEncode);
    except Exception as ArgoE:
        GD["@_Error_"     ] = ("%s" % ArgoE);  return int(False);
    """
        GD["@_MessageBin_"] 는 byte 문자열인데,
        UPyt_GetByGD('@_MessageBin_') 으로 보면,
        b' 로 시작하고 있다.
    """    
    return int(True);
$$
LANGUAGE plpython3u; /*UPyt_ShellExec(
    AS_Command TEXT, AB_SaveText BOOL=FALSE, AS_Encode TEXT='UHC') RETURNS INT*/
    /*

    SELECT UPyt_ShellExec('ls');

    SELECT
        UPyt_ShellExec('ls', TRUE   ),
        UPyt_GetByGD('@_Message_'   ),
        UPyt_GetByGD('@_MessageBin_'),
        UPyt_GetByGD('@_Error_'     );
    SELECT * FROM UPyt_ListLineByData(UPyt_GetByGD('@_Message_'));

    SELECT
        UPyt_ShellExec('pwd', TRUE  ),
        UPyt_GetByGD('@_Message_'   ),
        UPyt_GetByGD('@_MessageBin_'),
        UPyt_GetByGD('@_Error_'     );
    SELECT * FROM UPyt_ListLineByData(UPyt_GetByGD('@_Message_'));

    SELECT UPyt_ShellExec('ps aux', TRUE);
    SELECT * FROM UPyt_ListLineByData(UPyt_GetByGD('@_Message_'));

    SELECT UPyt_ShellExec('ps aux | grep ''phantomjs'' | awk ''{print $2}''', TRUE);
    SELECT * FROM UPyt_ListLineByData(UPyt_GetByGD('@_Message_'));

-- 2016-05-17 01:56:00 */


CREATE OR REPLACE FUNCTION UPyt_ListLine(
    AS_File    TEXT    , AS_Encoding TEXT='',
    AI_MaxLine INT=1000, AI_SkipLine INT =0 ) RETURNS SETOF TEXT AS
$$
    """ AS_File 파일의 내용을 읽어와서 줄 단위로 반환한다.  """
    
    import re, codecs, datetime;
    
    VariMaxLines=args[2];
    VariSkipLine=args[3];
    VariNowLines=0      ;
    
    VariMaxLines+=VariSkipLine;
    """
        위 코드가 없다면, AI_SkipLine 이후에, 최소 1 이상,
        최대 AI_MaxLine-AI_SkipLine 개의 행만 출력된다. 즉
        AI_SkipLine>0 일때 문제가 된다. -- 2016-10-02 18:54:00
    """
    
    if args[1]=='':
        try:
          with open(args[0]) as VaroFile:
            while True:
                VarsLine=VaroFile.readline();
                if not VarsLine: break      ;
                VarsLine=VarsLine.strip   ();
                if VarsLine=="": continue   ;
                VariNowLines+=1;
                if VariNowLines<=VariSkipLine: continue;
                yield VarsLine ;
                if VariNowLines>=VariMaxLines: break   ;
            #********#:
            return;
            
        except Exception as ArgoE:
            plpy.notice("%s" % ArgoE); return;
    #************#:
    
    try:
      with codecs.open(
        args[0], "r", args[1], "strict") as VaroFile:
    #**#
        for i, VarsLine in enumerate(VaroFile):
            VarsLine=VarsLine.strip();
            if VarsLine=="": continue;
            VariNowLines+=1;
            if VariNowLines<=VariSkipLine: continue;
            yield VarsLine ;
            if VariNowLines>=VariMaxLines: break   ;
    except Exception as ArgoE:
        plpy.notice("%s" % ArgoE);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ListLine(
    AS_File    TEXT    , AS_Encoding TEXT='',
    AI_MaxLine INT=1000, AI_SkipLine INT =0 ) RETURNS SETOF TEXT*/
/*

    SELECT UPyt_ListLine('back_g5_banner_filename.txt');
    SELECT UPyt_ListLine('back_g5_banner_filename.txt', 'utf-8');

-- 2016-05-17 23:15:00 */


CREATE OR REPLACE FUNCTION UPyt_ListLineByData(
    AS_Data TEXT, AB_ExcludeEmpty BOOL=TRUE, AS_Spliter TEXT=E'\n') RETURNS SETOF TEXT AS
$$
    """ AS_Data 을 줄 단위로 나누어 반환한다. AB_ExcludeEmpty 이
        True 이면 빈 줄은 반환하지 않는다. -- 2016-09-01 07:27:00
    """
    VarolData=args[0].split(args[2]);
    
    for VarsLine in VarolData:
        VarsLine=VarsLine.strip();
        if args[1]==True:
            if VarsLine!="": yield VarsLine;
        else: yield VarsLine;
    #***********************#:
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_ListLineByData(
    AS_Data TEXT, AB_ExcludeEmpty BOOL=TRUE, AS_Spliter TEXT=E'\n') RETURNS SETOF TEXT*/


CREATE OR REPLACE FUNCTION UPyt_DeleteFile(AS_File TEXT) RETURNS INT AS
$$
    import os;  VarsFile=args[0];
    
    try :
        if os.path.isfile(VarsFile):
            os.unlink(VarsFile); return int(True);
        
        return int(False);
        
    except Exception as ArgoE:
        plpy.notice("%s" % ArgoE); return int(False);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_DeleteFile(AS_File TEXT) RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_RenameFile(AS_File1 TEXT, AS_File2 TEXT) RETURNS INT AS
$$
    import os;
    
    try:
        os.rename(args[0], args[1]); return int(True );
    except Exception as ArgoE:
        plpy.notice("%s" % ArgoE);   return int(False);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_RenameFile(AS_File1 TEXT, AS_File2 TEXT) RETURNS INT*/


CREATE OR REPLACE FUNCTION UPyt_Now() RETURNS TIMESTAMP AS
$$
    import datetime; VaroNow = datetime.datetime.now();
    
    return VaroNow.strftime('%Y-%m-%d %H:%M:%S') ;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_Now() RETURNS TIMESTAMP*/

CREATE OR REPLACE FUNCTION UPyt_Now2() RETURNS TIMESTAMP AS
$$
    import datetime;  return datetime.datetime.now() ;
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_Now2() RETURNS TIMESTAMP*/


CREATE OR REPLACE FUNCTION UPyt_GetBase64Enc(ABa_Data BYTEA) RETURNS BYTEA AS
$$
    import base64; return base64.b64encode(args[0]);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_GetBase64Enc(ABa_Data BYTEA) RETURNS BYTEA*/

CREATE OR REPLACE FUNCTION UPyt_GetBase64Dec(ABa_Data BYTEA) RETURNS BYTEA AS
$$
    import base64; return base64.b64decode(args[0]);
$$
LANGUAGE plpython3u; /*FUNCTION UPyt_GetBase64Dec(ABa_Data BYTEA) RETURNS BYTEA*/
/*
    SELECT
        UPyt_GetBase64Enc('11'::BYTEA),
        Convert_From(UPyt_GetBase64Enc('11'::BYTEA), 'UTF8'),
        Convert_From(
            UPyt_GetBase64Dec(Convert_From(
                    UPyt_GetBase64Enc('11'::BYTEA), 'UTF8')::BYTEA),
            'UTF8');

     upyt_getbase64enc | convert_from | convert_from 
    -------------------+--------------+--------------
     \x4d54453d        | MTE=         | 11
    (1 row)

-- 2016-09-03 12:43:00 */


CREATE OR REPLACE FUNCTION UPyt_QueryArr(
    AS_Query TEXT, AI_LimitCnt INT=0, AS_SaveKey TEXT='') RETURNS SETOF TEXT[] AS
$$
    VarsQuery   =args[0];
    VariLimitCnt=args[1];
    VarsSaveKey =args[2];
    
    if VariLimitCnt<1:
        VaroResult=plpy.execute(VarsQuery); #**********#;
    else:
        VaroResult=plpy.execute(VarsQuery, VariLimitCnt);
    
    GD["@_RowCnt_"]=VaroResult.nrows();
    GD["@_AttCnt_"]=0;  VarlAttName=[];
    
    try   : VarlAttName=VaroResult.colnames();
    except:
        """ UPDATE 나 CREATE 등의 쿼리의 경우. """
        return;
    #****#:
    
    GD["@_AttCnt_"]=len(VarlAttName);
    
    if VarsSaveKey=="":
        for VarmItem in VaroResult:
            VarlRow=[]   ;
            for VarsAttName in VarlAttName:
                    VarlRow.append(VarmItem[VarsAttName]);
            yield VarlRow;
        #************************#:
    else:
        if ("%s" % type(GD.get('@_RowsMap_')))!="<class 'dict'>":
            GD["@_RowsMap_"]={};
        GD["@_RowsMap_"][VarsSaveKey]=[]; #********************#:
        
        VaroNowList=GD["@_RowsMap_"][VarsSaveKey];
        
        for VarmItem in VaroResult:
            VarlRow=[]   ;
            for VarsAttName in VarlAttName:
                VarlRow.append(VarmItem[VarsAttName]);
            VaroNowList.append(VarlRow);
        #************************#:
    #**#:
$$
LANGUAGE plpython3u; /*FUN UPyt_QueryArr(
    AS_Query TEXT, AI_LimitCnt INT=0, AS_SaveKey TEXT='') RETURNS SETOF TEXT[] */
/*

    SELECT UPyt_QueryArr('SELECT * FROM DBoardInfo LIMIt 10');
    SELECT UPyt_GetIntByGD('@_RowCnt_'), UPyt_GetIntByGD('@_AttCnt_');
    SELECT UPyt_GetIntByGD(Array['@_RowCnt_']),
           UPyt_GetIntByGD(Array['@_AttCnt_']);

    SELECT UPyt_QueryArr('SELECT * FROM DBoardInfo LIMIt 10', AS_SaveKey:='_Default');
    SELECT UPyt_GetByGD(Array['@_RowsMap_', '_Default']);

-- 2017-07-26 14:50:00 */


CREATE OR REPLACE FUNCTION UPyt_QueryOne(AS_Query TEXT) RETURNS TEXT AS
$$
    VarsQuery =args[0];  VariLimitCnt=1;
    VaroResult=plpy.execute(VarsQuery, VariLimitCnt);
    
    GD["@_RowCnt_"]=VaroResult.nrows();
    GD["@_AttCnt_"]=0;  VarlAttName=[];
    
    try   : VarlAttName=VaroResult.colnames();
    except:
        """ UPDATE 나 CREATE 등의 쿼리의 경우. """
        return "";
    #****#:
    
    GD["@_AttCnt_"]=len(VarlAttName);
    
    for VarmItem in VaroResult:
        for VarsAttName in VarlAttName:
            return (VarmItem[VarsAttName]);
    #************************#:
    
    return "";
$$
LANGUAGE plpython3u; /*FUN UPyt_QueryOne(AS_Query TEXT) RETURNS TEXT */


CREATE OR REPLACE FUNCTION UPyt_QueryInt(AS_Query TEXT) RETURNS TEXT AS
$$
    VarsQuery =args[0];  VariLimitCnt=1;
    VaroResult=plpy.execute(VarsQuery, VariLimitCnt);
    
    GD["@_RowCnt_"]=VaroResult.nrows();
    GD["@_AttCnt_"]=0;  VarlAttName=[];
    
    try   : VarlAttName=VaroResult.colnames();
    except:
        """ UPDATE 나 CREATE 등의 쿼리의 경우. """
        return 0;
    #****#:
    
    GD["@_AttCnt_"]=len(VarlAttName);
    
    for VarmItem in VaroResult:
        for VarsAttName in VarlAttName:
            try   : return int(VarmItem[VarsAttName]);
            except: return 0;
    #************************#:
    
    return 0;
$$
LANGUAGE plpython3u; /*FUN UPyt_QueryInt(AS_Query TEXT) RETURNS TEXT */


CREATE OR REPLACE FUNCTION UPyt_QueryNone(AS_Query TEXT) RETURNS INT AS
$$
    VarsQuery =args[0];  VariLimitCnt=1;
    VaroResult=plpy.execute(VarsQuery, VariLimitCnt);
    
    GD["@_RowCnt_"]=VaroResult.nrows();
    GD["@_AttCnt_"]=0;  VarlAttName=[];
    
    try   : VarlAttName=VaroResult.colnames();
    except:
        """ UPDATE 나 CREATE 등의 쿼리의 경우. """
        return int(False);
    #****#:
    
    GD["@_AttCnt_"]=len(VarlAttName);
    
    return int(True); #************#;
$$
LANGUAGE plpython3u; /*FUN UPyt_QueryOne(AS_Query TEXT) RETURNS TEXT */




CREATE OR REPLACE FUNCTION UPyt_CHtml_Init(
    AS_Html TEXT, AS_ObjKey TEXT='_Default') RETURNS INT AS
$$
    import lxml.html, cssselect;
    
    """ CSS 선택자.

        □  모든 태그 선택 : *
        □  a    태그 선택 : a
        □  class 가 link 인 모든 태그 선택 : .link
        □  class 가 link 인 a    태그 선택 : a.link
        □  id 가 home    인 a    태그 선택 : a#home
        □  a 태그의 자식 중 span 태그 선택 : a > span
        □  a 태그의 자손 중 span 태그 선택 : a span
        □  속성 title 의 값이 home 인 a 태그 선택 : a[title=home]

    """
    
    VarsHtml=args[0].strip();
    VarsKey =args[1].strip();
    
    try   :
        if "@_Lxml_Map" not in GD:
            GD["@_Lxml_Map"]={};
        GD["@_Lxml_Map"][VarsKey] = \
            lxml.html.fromstring(VarsHtml) ;
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        return int(False); #********#;
    
    return int(True);
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_Init(
    AS_Html TEXT, AS_ObjKey TEXT='_Default') RETURNS INT */
/*
    SELECT UPyt_OpenUrlEx('http://land.naver.com/article/', AI_MaxBodySize:=100000);
    SELECT UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']);

    SELECT UPyt_CHtml_Init( UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']) );
    SELECT UPyt_CHtml_Fini();

-- 2017-07-26 17:07:00 */


CREATE OR REPLACE FUNCTION UPyt_CHtml_Fini(AS_ObjKey TEXT='_Default') RETURNS INT AS
$$
    try   :
        del GD["@_Lxml_Map"][args[0]];
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        return int(False); #********#;
    
    return int(True);
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_Fini(AS_ObjKey TEXT='_Default') RETURNS INT */


CREATE OR REPLACE FUNCTION UPyt_CHtml_Search(
    AS_Search TEXT, AS_ObjKey TEXT='_Default') RETURNS SETOF TEXT[] AS
$$
    import json;
    
    VarsSearch=args[0].strip();
    VarsKey   =args[1].strip();
    
    try   :
        VarlEleList = GD["@_Lxml_Map"] \
            [VarsKey].cssselect(VarsSearch);
        for VaroItem in VarlEleList:
            yield [ VaroItem.text_content(), \
                    (json.dumps(VaroItem.attrib)) \
                  ];
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        return; #***********#;
    
    return; #---------------#;
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_Search(
    AS_Search TEXT, AS_ObjKey TEXT='_Default') RETURNS SETOF TEXT[] */
/*

    SELECT UPyt_CHtml_Init('<div style="margin:10px;">my1</div><div>my2</div>');
    SELECT UPyt_CHtml_Search('div');
    SELECT UPyt_CHtml_Fini();


    SELECT UPyt_OpenUrlEx('http://land.naver.com/article/');
 -- SELECT UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']);

    SELECT UPyt_CHtml_Init( UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']) );
 -- SELECT UPyt_CHtml_Search('div#map option');
    SELECT UPyt_CHtml_Search('div#map > div.location > div.loc_view > div#loc_view1 option');
    SELECT T1[1], T1[2]::JSON->>'value' FROM (
        SELECT UPyt_CHtml_Search(
            'div#map > div.location > div.loc_view > div#loc_view1 option') ) AS T(T1);

        d_success=> SELECT UPyt_CHtml_Search(
            'div#map > div.location > div.loc_view > div#loc_view1 option');
        -----------------------------------------------------------------
         {서울시,"{\"value\":\"1100000000\"}"}
         {경기도,"{\"value\":\"4100000000\"}"}
         {인천시,"{\"value\":\"2800000000\"}"}
         {부산시,"{\"value\":\"2600000000\"}"}
         {대전시,"{\"value\":\"3000000000\"}"}
         {대구시,"{\"value\":\"2700000000\"}"}
         {울산시,"{\"value\":\"3100000000\"}"}
         {세종시,"{\"value\":\"3600000000\"}"}
         {광주시,"{\"value\":\"2900000000\",\"selected\":\"selected\"}"}
         {강원도,"{\"value\":\"4200000000\"}"}
         {충청북도,"{\"value\":\"4300000000\"}"}
         {충청남도,"{\"value\":\"4400000000\"}"}
         {경상북도,"{\"value\":\"4700000000\"}"}
         {경상남도,"{\"value\":\"4800000000\"}"}
         {전라북도,"{\"value\":\"4500000000\"}"}
         {전라남도,"{\"value\":\"4600000000\"}"}
         {제주도,"{\"value\":\"5000000000\"}"}
        (17 rows)

        Time: 8.388 ms


        d_success=>
            SELECT T.T1[2] FROM ( SELECT UPyt_CHtml_Search(
                    'div#map > div.location > div.loc_view > div#loc_view1 option') ) AS T(T1);
                      t1
        ----------------------------------------------
         {"value":"1100000000"}
         {"value":"4100000000"}
         {"value":"2800000000"}
         {"value":"2600000000"}
         {"value":"3000000000"}
         {"value":"2700000000"}
         {"value":"3100000000"}
         {"value":"3600000000"}
         {"value":"2900000000","selected":"selected"}
         {"value":"4200000000"}
         {"value":"4300000000"}
         {"value":"4400000000"}
         {"value":"4700000000"}
         {"value":"4800000000"}
         {"value":"4500000000"}
         {"value":"4600000000"}
         {"value":"5000000000"}
        (17 rows)

        Time: 8.981 ms


        d_success=>
            SELECT T1[1] AS "SiDo", T1[2]::JSON->>'value' AS "Code" FROM (
                SELECT UPyt_CHtml_Search(
                    'div#map > div.location > div.loc_view > div#loc_view1 option') ) AS T(T1);
           SiDo   |    Code
        ----------+------------
         서울시   | 1100000000
         경기도   | 4100000000
         인천시   | 2800000000
         부산시   | 2600000000
         대전시   | 3000000000
         대구시   | 2700000000
         울산시   | 3100000000
         세종시   | 3600000000
         광주시   | 2900000000
         강원도   | 4200000000
         충청북도 | 4300000000
         충청남도 | 4400000000
         경상북도 | 4700000000
         경상남도 | 4800000000
         전라북도 | 4500000000
         전라남도 | 4600000000
         제주도   | 5000000000
        (17 rows)


    SELECT UPyt_CHtml_Fini();


    SELECT UPyt_OpenUrlEx(format(  -- 경기도
        'http://land.naver.com/article/cityInfo.nhn?cortarNo=%s&rletNo=&rletTypeCd=A01&tradeTypeCd=&hscpTypeCd=A01%%3AA03%%3AA04&cpId=&location=&siteOrderCode=', 4100000000));

    SELECT UPyt_CHtml_Init( UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']) );
    SELECT UPyt_CHtml_Search('div#map > div.location > div.loc_view > div#loc_view2 option');
    SELECT T1[1] As "시/군/구", T1[2]::JSON->>'value' AS "Code" FROM ( SELECT UPyt_CHtml_Search(
                'div#map > div.location > div.loc_view > div#loc_view2 option') ) AS T(T1) OFFSET 1;

            시/군/구     |    Code
        -----------------+------------
         가평군          | 4182000000
         고양시 덕양구   | 4128100000
         고양시 일산동구 | 4128500000
         고양시 일산서구 | 4128700000
         과천시          | 4129000000
         광명시          | 4121000000
         광주시          | 4161000000
         구리시          | 4131000000
         군포시          | 4141000000
         김포시          | 4157000000
         남양주시        | 4136000000
         동두천시        | 4125000000
         부천시          | 4119000000
         성남시 분당구   | 4113500000
         성남시 수정구   | 4113100000
         성남시 중원구   | 4113300000
         수원시 권선구   | 4111300000
         수원시 영통구   | 4111700000
         수원시 장안구   | 4111100000
         수원시 팔달구   | 4111500000
         시흥시          | 4139000000
         안산시 단원구   | 4127300000
         안산시 상록구   | 4127100000
         안성시          | 4155000000
         안양시 동안구   | 4117300000
         안양시 만안구   | 4117100000
         양주시          | 4163000000
         양평군          | 4183000000
         여주시          | 4167000000
         연천군          | 4180000000
         오산시          | 4137000000
         용인시 기흥구   | 4146300000
         용인시 수지구   | 4146500000
         용인시 처인구   | 4146100000
         의왕시          | 4143000000
         의정부시        | 4115000000
         이천시          | 4150000000
         파주시          | 4148000000
         평택시          | 4122000000
         포천시          | 4165000000
         하남시          | 4145000000
         화성시          | 4159000000
        (42 rows)

    SELECT ZDong_SiGuGun FROM DZipDong WHERE ZDong_SiDo='경기도' GROUP BY ZDong_SiDo, ZDong_SiGuGun;

          zdong_sigugun  
        -----------------
         가평군
         고양시 덕양구
         고양시 일산동구
         고양시 일산서구
         과천시
         광명시
         광주시
         구리시
         군포시
         김포시
         남양주시
         동두천시
         부천시
         성남시 분당구
         성남시 수정구
         성남시 중원구
         수원시 권선구
         수원시 영통구
         수원시 장안구
         수원시 팔달구
         시흥시
         안산시 단원구
         안산시 상록구
         안성시
         안양시 동안구
         안양시 만안구
         양주시
         양평군
         여주시
         연천군
         오산시
         용인시 기흥구
         용인시 수지구
         용인시 처인구
         의왕시
         의정부시
         이천시
         파주시
         평택시
         포천시
         하남시
         화성시
        (42 rows)

    SELECT UPyt_CHtml_Fini();


    SELECT UPyt_OpenUrlEx(format( -- 경기도 가평군
        'http://land.naver.com/article/divisionInfo.nhn?cortarNo=%s&rletNo=&rletTypeCd=A01&tradeTypeCd=&hscpTypeCd=A01%%3AA03%%3AA04&cpId=&location=&siteOrderCode=', 4182000000));

    SELECT UPyt_CHtml_Init( UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']) );
    SELECT UPyt_CHtml_Search('div#map > div.location > div.loc_view > div#loc_view3 option');
    SELECT T1[1] AS "읍/면/동/리", T1[2]::JSON->>'value' As "Code" FROM (
        SELECT UPyt_CHtml_Search(
                'div#map > div.location > div.loc_view > div#loc_view3 option') ) AS T(T1) OFFSET 1;

         읍/면/동/리 |    Code
        -------------+------------
         가평읍      | 4182025000
         북면        | 4182035000
         상면        | 4182033000
         설악면      | 4182031000
         조종면      | 4182034500
         청평면      | 4182032500
        (6 rows)

        -- 위 쿼리가 아래랑 행정 구역이 안 맞네. 삽질이 많이 필요하겠네.

            d_success=> SELECT ZDong_SiGuGun, ZDong_Dong FROM DZipDong WHERE ZDong_SiDo='경기도' AND ZDong_SiGuGun='가평군' GROUP BY ZDong_SiDo, ZDong_SiGuGun, ZDong_Dong LIMIT 10;
             zdong_sigugun |  zdong_dong   
            ---------------+---------------
             가평군        | 가평읍 개곡리
             가평군        | 가평읍 경반리
             가평군        | 가평읍 금대리
             가평군        | 가평읍 달전리
             가평군        | 가평읍 대곡리
             가평군        | 가평읍 두밀리
             가평군        | 가평읍 마장리
             가평군        | 가평읍 복장리
             가평군        | 가평읍 산유리
             가평군        | 가평읍 상색리
            (10 rows)

    SELECT UPyt_CHtml_Fini();


    SELECT UPyt_OpenUrlEx(format( -- 경기도 가평군 가평읍
        'http://land.naver.com/article/articleList.nhn?rletTypeCd=A01&tradeTypeCd=&hscpTypeCd=A01%%3AA03%%3AA04&cortarNo=%s', 4182025000));

    SELECT UPyt_CHtml_Init( UPyt_GetByGD(Array['@_OpenUrl_RecvMap', '_Default']) );
    SELECT UPyt_CHtml_Search('div#map > div.location > div.loc_view > div#loc_view4 option');
    SELECT T1[1] AS "단지", T1[2]::JSON->>'value' As "Code" FROM (
        SELECT UPyt_CHtml_Search(
                'div#map > div.location > div.loc_view > div#loc_view4 option') ) AS T(T1) OFFSET 1;

               단지       |  Code  
        ------------------+--------
         J정동            | 109564
         가평선힐         | 24038
         가평에이원파란채 | 23076
         세대넥스빌       | 14452
         송안             | 113691
         신초             | 23686
         에덴             | 114753
         우림필유1단지    | 22552
         우림필유2단지    | 104322
         유성             | 24164
         정동             | 109394
         준수             | 104812
         중앙             | 103635
         태광             | 15866
         해오름           | 103313
        (15 rows)

    SELECT UPyt_CHtml_Fini();


-- 2017-07-26 17:07:00 */


CREATE OR REPLACE FUNCTION UPyt_CHtml_SearchOne(
    AS_Search TEXT, AI_ElemNo INT=0, AS_ObjKey TEXT='_Default') RETURNS TEXT[] AS
$$
    import json;
    
    VarsSearch=args[0].strip();
    VariElemNo=args[1]        ;
    VarsKey   =args[2].strip();
    
    try   :
        VaroElement = GD["@_Lxml_Map"] \
            [VarsKey].cssselect(VarsSearch)[VariElemNo];
        return  \
        [       \
            VaroElement.text_content(),      \
            (json.dumps(VaroElement.attrib)) \
        ];
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return [""]; #******************#;
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_SearchOne(
    AS_Search TEXT, AI_ElemNo INT=0, AS_ObjKey TEXT='_Default') RETURNS TEXT[] */
/*

    SELECT UPyt_CHtml_Init(
        '<div class="myc1" id="id1">mydata1</div>' ||
        '<div class="myc2" id="id2">mydata2</div>' );

    SELECT UPyt_CHtml_SearchOne('div');

        -- 이래 결과가 서로 다름에 주의.

        d_success=> SELECT UPyt_CHtml_SearchOne('div', 0);
         upyt_chtml_searchone  
        -----------------------
         {mydata1mydata2,"{}"}
        (1 row)

        d_success=> SELECT UPyt_CHtml_SearchOne('div', 1);
                      upyt_chtml_searchone               
        -------------------------------------------------
         {mydata1,"{\"class\":\"myc1\",\"id\":\"id1\"}"}
        (1 row)

        d_success=> SELECT UPyt_CHtml_SearchOne('div', 2);
                      upyt_chtml_searchone               
        -------------------------------------------------
         {mydata2,"{\"class\":\"myc2\",\"id\":\"id2\"}"}
        (1 row)

        d_success=> SELECT UPyt_CHtml_SearchOne('div', 3);
         upyt_chtml_searchone 
        ----------------------
         {""}
        (1 row)


    SELECT UPyt_CHtml_Fini();


-- 2017-08-02 15:43:00 */



CREATE OR REPLACE FUNCTION UPyt_CHtml_SearchText(
    AS_Search TEXT, AS_ObjKey TEXT='_Default') RETURNS SETOF TEXT AS
$$
    VarsSearch=args[0].strip();
    VarsKey   =args[1].strip();
    
    try   :
        VarlEleList = GD["@_Lxml_Map"] \
            [VarsKey].cssselect(VarsSearch);
        for VaroItem in VarlEleList:
            yield (VaroItem.text_content());
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        return; #***********#;
    
    return; #+++++++++++++++#;
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_SearchText(
    AS_Search TEXT, AS_ObjKey TEXT='_Default') RETURNS SETOF TEXT */


CREATE OR REPLACE FUNCTION UPyt_CHtml_SearchTextOne(
    AS_Search TEXT, AI_ElemNo INT=0, AS_ObjKey TEXT='_Default') RETURNS TEXT AS
$$
    VarsSearch=args[0].strip();
    VariElemNo=args[1]        ;
    VarsKey   =args[2].strip();
    
    try   :
        VaroElement = GD["@_Lxml_Map"] \
            [VarsKey].cssselect(VarsSearch)[VariElemNo];
        return VaroElement.text_content();
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
    
    return ""; #********************#;
$$
LANGUAGE plpython3u; /*FUN UPyt_CHtml_SearchTextOne(
    AS_Search TEXT, AI_ElemNo INT=0, AS_ObjKey TEXT='_Default') RETURNS TEXT */
/*

    SELECT UPyt_CHtml_Init(
        '<div class="myc1" id="id1">mydata1</div>' ||
        '<div class="myc2" id="id2">mydata2</div>' );

    SELECT UPyt_CHtml_SearchText   ('div');
    SELECT UPyt_CHtml_SearchTextOne('div');

    SELECT UPyt_CHtml_Fini();

-- 2017-08-02 23:34:00 */


CREATE OR REPLACE FUNCTION UPyt_ChangeXmlToJsonByID(
    AS_Xml TEXT, AS_SaveKey TEXT='') RETURNS JSON AS
$$
    """
    ■  요소명은 data 로 통일하고 고유한 id 가 반드시 있는 경우에, id 별 map 을 만들어
        Postgresql 에서 JSON 으로 접근할 수 있게 한다.

    ■  아래 처럼 xml 헤더가 있어도 되고, 헤더에 DOCTYPE 부분이 없어도 된다.

        <?xml version="1.0" encoding="UTF8"?>
        <!DOCTYPE data[
        <!ELEMENT data ANY>
        <!ENTITY nbsp " " >
        <!ATTLIST data id ID #REQUIRED>
        ]>
        <data>
            <data id="id-data1" name="Liechtenstein"       capital="&amp;#xD;&#xA;몰라1" />
            <data id="id-data2" name="Singapore(싱가포르)" capital="&lt;몰라2&quot;'" />
            <data id="id-data3" name="Panama(파나마)"      capital="몰라3" />
            <data id="id-data-set">
                <data id="id-data3-1" name="Panama(파나마)-1" capital="몰라3-1" />
                <data id="id-data3-2" name="Panama(파나마)-2" capital="몰라3-2" />
                <data id="id-data3-3" name="Panama(파나마)-3" capital="몰라3-3" />
            </data>
        </data>

        -- 2018-02-02 15:54:00
    """
    import json;  import xml.etree.ElementTree as ET;
    
    VarsXml       =args[0].strip();
    VarsSaveKey   =args[1].strip();
    VarmReturn    ={};
    VarmSave      ={};
    GD["@_Error_"]="";
    
    if VarsSaveKey!='':
        if "_JsonByID_" not in GD:
            GD["_JsonByID_"]={};
        VarmSave=GD["_JsonByID_"];
    #>>>>>>>>>>>>>>>>>#
    
    try:
        VaroRoot = ET.fromstring(VarsXml);
    except Exception as ArgoE:
        GD["@_Error_"]=("%s" % ArgoE);
        return None; # Null 을 반환.
    #>>>>>>>>>>>>>>>>>>>>>>>>#
    
    for VaroProp in VaroRoot.iter('data'):
        VarmAttri=VaroProp.attrib;
        if "id" in VarmAttri:
            VarsID=VarmAttri["id"];  del VarmAttri["id"];
            VarmReturn[VarsID]=VarmAttri;
    #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
    
    if VarsSaveKey!='':
        VarmSave[VarsSaveKey]=VarmReturn; return "{}";
    #>>>>>>>>>>>>>>>>>#
    
    return json.dumps(VarmReturn);
$$
LANGUAGE plpython3u; /*FUN UPyt_ChangeXmlToJsonByID(
    AS_Xml TEXT, AS_SaveKey TEXT='') RETURNS JSON */
/*

    SELECT UPyt_ChangeXmlToJsonByID('<data id="my" t="그러나&#xA;" q="ㅋㅋㅋ" />') ;
    SELECT UPyt_ChangeXmlToJsonByID('<data id="my" t="그러나&#xA;" q="ㅋㅋㅋ" />', 'MyJson') ;
    SELECT UPyt_ShowGD();

    SELECT UPyt_ChangeXmlToJsonByID('
        <data id="id-MainSet" RowCnt="3">
            <data id="id-Row1" Name="myName1" Age="11" />
            <data id="id-Row2" Name="myName2" Age="12" />
            <data id="id-Row3" Name="myName3" Age="13" />
        </data>'
    ) ;
    SELECT UPyt_ChangeXmlToJsonByID('
        <data id="id-MainSet" RowCnt="3">
            <data id="id-Row1" Name="myName1" Age="11" />
            <data id="id-Row2" Name="myName2" Age="12" />
            <data id="id-Row3" Name="myName3" Age="13" />
        </data>'
    ) ->'id-MainSet'->>'RowCnt';
    SELECT UPyt_ChangeXmlToJsonByID('
        <data id="id-MainSet" RowCnt="3">
            <data id="id-Row1" Name="myName1" Age="11" />
            <data id="id-Row2" Name="myName2" Age="12" />
            <data id="id-Row3" Name="myName3" Age="13" />
        </data>', 'MyJson'
    ) ;

    SELECT UPyt_ShowGD();

    SELECT UPyt_CutInGD(Array['_JsonByID_', 'MyJson']);
    SELECT UPyt_CutInGD(Array['_JsonByID_']          );

-- 2018-02-02 15:47:00 */


CREATE OR REPLACE FUNCTION UPyt_Sha256Encode(AS_Origin TEXT) RETURNS TEXT AS
$$
    import hashlib;  return hashlib.sha256(args[0].encode()).hexdigest();
$$
LANGUAGE plpython3u; /*FUN UPyt_Sha256Encode(AS_Origin TEXT) RETURNS TEXT */


CREATE OR REPLACE FUNCTION UPyt_GetUUID() RETURNS TEXT AS
$$
    import uuid;  return "%s" % uuid.uuid4();
$$
LANGUAGE plpython3u; /*FUN UPyt_GetUUID() RETURNS TEXT */
