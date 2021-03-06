--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PERFIL_GRUPO_ALTERAR]
	@ID_PERFIL_GRUPO INT,
	@NOME_PERFI NVARCHAR(100),
	@DESCRICAO_PERFI NVARCHAR(300) =NULL,
	@FL_ATIVO BIT ,
	--@ID_EMPRE INT= NULL,
	--@TP_EMPRE SMALLINT= NULL,
	--@FL_EXCLU BIT ,
	@COD_LOG_UTILIZADOR INT	=NULL	
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	IF NOT EXISTS(SELECT * FROM [GRUPOS]	WHERE GRUPO_NOME=@NOME_PERFI AND DESCRICAO_GRUPO=@DESCRICAO_PERFI AND FL_EXCLU=0)
			UPDATE GRUPOS SET @NOME_PERFI=@NOME_PERFI, DESCRICAO_GRUPO=@DESCRICAO_PERFI,ACTIVO=@FL_ATIVO
			WHERE ID_GRUPO=@ID_PERFIL_GRUPO
			EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPO','ALTERAR',@ID_PERFIL_GRUPO
	ELSE
		BEGIN
			RAISERROR('ESTE GRUPO JÁ EXISTE!',16,1)
		END
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PERFIL_GRUPO_CONSULTA]
AS
BEGIN
	SELECT * FROM GRUPOS	WHERE FL_EXCLU=0
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PERFIL_GRUPO_CONSULTA_ID]
	@ID_PERFIL_GRUPO INT
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT * FROM PERFIL_GRUPO 
	WHERE FL_EXCLU=0 AND ID_PERFIL_GRUPO=@ID_PERFIL_GRUPO
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PERFIL_GRUPO_EXCLUIR]
	@ID_PERFIL_GRUPO INT,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	UPDATE PERFIL_GRUPO SET FL_EXCLU=1
	WHERE ID_PERFIL_GRUPO=@ID_PERFIL_GRUPO
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPO','EXCLUIR',@ID_PERFIL_GRUPO
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PERFIL_GRUPO_INSERIR]
	@NOME_PERFI NVARCHAR(100),
	@DESCRICAO_PERFI NVARCHAR(300) =NULL,
	@FL_ATIVO BIT ,
	@COD_LOG_UTILIZADOR INT	=NULL	
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM GRUPOS	WHERE GRUPO_NOME=@NOME_PERFI AND DESCRICAO_GRUPO=@DESCRICAO_PERFI AND FL_EXCLU=0)
	BEGIN
	INSERT INTO     [GRUPOS]
					(GRUPO_NOME
				   ,DESCRICAO_GRUPO
				   ,[ID_EMPRE]
				   ,[TP_EMPRE]
				   ,[FL_EXCLU])
			 VALUES
					(@NOME_PERFI
				   ,@DESCRICAO_PERFI 
				   ,1
				   ,2
				   ,0)
		 DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPO) FROM GRUPOS) 
         EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERFIL_GRUPO','ALTERAR',@IDENTITTY,NULL
	ELSE
		BEGIN
			RAISERROR('ESTE GRUPO JÁ EXISTE!',16,1)
		END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_IMAGEM_MENU_ARQUIVO_DOWNLOAD]
AS
BEGIN
		-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
		-- INTERFERING	WITH SELECT STATEMENTS.
		SET NOCOUNT ON;
		-- INSERT STATEMENTS FOR PROCEDURE HERE
		SELECT 
		BT_ARQUIVO,
		DS_ARQUIVO_EXTENCAO,
		DS_GUID,
		ID_ARQUIVO,
		NM_ARQUIVO,
		SIZE,
		TP_ARQUIVO
	 	FROM IMAGEM_MENU 
	   	WHERE FL_EXCLU=0
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_IMAGEM_MENU_ARQUIVO_DOWNLOAD_ID]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
		SELECT 
		IM.BT_ARQUIVO,
		IM.DS_ARQUIVO_EXTENCAO,
		IM.DS_GUID,
		IM.ID_ARQUIVO,
		IM.NM_ARQUIVO,
		IM.SIZE,
		IM.TP_ARQUIVO,
		IR.DT_CADAS,
		IR.COD_MENU,
		IR.COD_IMAGEM
	 	FROM MENUS M 
		INNER JOIN	IMAGEM_MENU_RELACIONAMENTO IR 
		ON M.ID_NIVEL_ITEM=IR.COD_MENU
		INNER JOIN IMAGEM_MENU IM
		ON IM.ID_ARQUIVO=IR.COD_IMAGEM
	   	WHERE ID_NIVEL_ITEM=IR.COD_MENU
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_IMAGEM_MENU_ARQUIVO_INCLUIR]
(






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID 	INT    = NULL OUTPUT ,
	@NM_ARQUIVO    NVARCHAR(255)    ,
	@DS_ARQUIVO_EXTENCAO    NVARCHAR(050)    = NULL ,
	@TP_ARQUIVO    SMALLINT    ,
	@BT_ARQUIVO    VARBINARY (MAX)   = NULL ,
	@SIZE INT,
	@DS_GUID    NVARCHAR(300)    = NULL 
   ---@FL_EXCLU    BIT     
)
AS
   BEGIN
	SET NOCOUNT ON;
	 	IF NOT EXISTS(SELECT * FROM IMAGEM_MENU 	   
	   	WHERE 
		NM_ARQUIVO=@NM_ARQUIVO 
		AND TP_ARQUIVO=@TP_ARQUIVO 
	 	AND FL_EXCLU=0
		)
			BEGIN
				INSERT INTO [DBO].[IMAGEM_MENU]
				 (
					NM_ARQUIVO, 
					DS_ARQUIVO_EXTENCAO, 
					TP_ARQUIVO, 
					BT_ARQUIVO, 
					DS_GUID, 
					SIZE,
					FL_EXCLU 
					VALUES
					(
						@NM_ARQUIVO, 
						@DS_ARQUIVO_EXTENCAO, 
						@TP_ARQUIVO, 
						@BT_ARQUIVO, 
						@DS_GUID, 
						@SIZE,
						0
					)
			ELSE
				BEGIN
					UPDATE IMAGEM_MENU
					SET 
					NM_ARQUIVO =@NM_ARQUIVO, 
					DS_ARQUIVO_EXTENCAO=@DS_ARQUIVO_EXTENCAO, 
					TP_ARQUIVO=@TP_ARQUIVO, 
					BT_ARQUIVO=@BT_ARQUIVO, 
					DS_GUID=@DS_GUID, 
					SIZE=@SIZE
					WHERE 
					NM_ARQUIVO =@NM_ARQUIVO 
					AND DS_ARQUIVO_EXTENCAO=@DS_ARQUIVO_EXTENCAO
					AND TP_ARQUIVO=@TP_ARQUIVO
					AND BT_ARQUIVO=@BT_ARQUIVO
					AND DS_GUID=@DS_GUID
					AND SIZE=@SIZE					
				END
	SET NOCOUNT OFF;
   END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_IMAGEM_MENU_ARQUIVO_RELACIONAMENTO_INSERIR]
	@COD_MENU INT,
	@COD_IMAGEM INT,
 	@COD_LOG_UTILIZADOR INT
AS
BEGIN
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	IF NOT EXISTS(SELECT * FROM IMAGEM_MENU_RELACIONAMENTO	WHERE COD_MENU=@COD_MENU AND FL_EXCLU=0)
	INSERT INTO [DBO].[IMAGEM_MENU_RELACIONAMENTO]
		([COD_MENU]
		,[COD_IMAGEM]
		,FL_EXCLU)
	VALUES
		(@COD_MENU 
		,@COD_IMAGEM
		,0)
	ELSE
	BEGIN
		UPDATE IMAGEM_MENU_RELACIONAMENTO
		SET COD_MENU = @COD_MENU, COD_IMAGEM = @COD_IMAGEM
		WHERE COD_MENU=@COD_MENU
	END
	DECLARE @IDENTITTY INT = (SELECT MAX(ID_IMAGEM_MENU_ARQUIVO_RELACIONAMENTO) FROM IMAGEM_MENU_RELACIONAMENTO)
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'RELACIONAMENT DE IMAGEM DOS MENUS','INSERIR', @IDENTITTY,NULL
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_MODELO_EMAIL_CONSULTA_CHAVES]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_MODELO INT
AS
  BEGIN
      SELECT ME.[ID_MODELO],
             ME.[IDD_MODELO],
             ME.[MODELO],
             ME.[DESCRICAO_TO],
             ME.[DESCRICAO_CC],
             ME.[EMAIL_TO],
             ME.[EMAIL_CC],
             C.CHAVE,
			 C.DESCRICAO
      FROM   PARAMETROS_MODELOS_EMAIL_CHAVES C
	  INNER JOIN PARAMETROS_MODELOS_EMAIL ME
             ON C.COD_PARAMETROS_MODELOS_EMAIL = ME.IDD_MODELO              
      WHERE  
	  ME.FL_EXCLU = 0
             AND C.FL_EXCLU = 0
             AND ME.IDD_MODELO = @ID_MODELO
      ORDER  BY MODELO ASC
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_ALTERAR]
@ID_LIMITE_FUNCIONARIO INT,
@COD_APPS INT,
@COD_FUNCIONARIO INT,
@COD_TIPO_AUTORIDADE INT,
@COD_MOEDA INT = NULL,
@PLAFOUND NVARCHAR(30) = NULL
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM LIMITE_FUNCIONARIO WHERE 
FL_EXCLU = 0 AND
COD_APPS = @COD_APPS AND
COD_FUNCIONARIO = @COD_FUNCIONARIO AND
COD_TIPO_AUTORIDADE = @COD_TIPO_AUTORIDADE AND
COD_MOEDA = @COD_MOEDA AND
PLAFOUND = @PLAFOUND
AND ID_LIMITE_FUNCIONARIO <> @ID_LIMITE_FUNCIONARIO
)
UPDATE LIMITE_FUNCIONARIO
SET
[COD_APPS] = @COD_APPS,
[COD_FUNCIONARIO] = @COD_FUNCIONARIO,
[COD_TIPO_AUTORIDADE] = @COD_TIPO_AUTORIDADE,
[COD_MOEDA] = @COD_MOEDA,
[PLAFOUND] = @PLAFOUND
WHERE ID_LIMITE_FUNCIONARIO = @ID_LIMITE_FUNCIONARIO
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LIMITE FUNCIONARIO','ALTERAR',@ID_LIMITE_FUNCIONARIO ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE LIMITE FUNCIONARIO COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_LIMITE_FUNCIONARIO)  FROM LIMITE_FUNCIONARIO WHERE FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_CONSULTAR_FILTROS] @COD_APPS             NVARCHAR(MAX) = NULL,
                                                                  @APPS_NOME            NVARCHAR(MAX) = NULL,
                                                                  @COD_FUNCIONARIO      NVARCHAR(MAX) = NULL,
                                                                  @FUNCIONARIO_NOME     NVARCHAR(MAX) = NULL,
                                                                  @COD_TIPO_AUTORIDADE  NVARCHAR(MAX) = NULL,
                                                                  @TIPO_AUTORIDADE_NOME NVARCHAR(MAX) = NULL,
                                                                  @COD_MOEDA            NVARCHAR(MAX) = NULL,
                                                                  @MOEDA_NOME           NVARCHAR(MAX) = NULL,
                                                                  @PLAFOUND             NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
  SELECT
LIMITE_FUNCIONARIO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA  AS APPS_SIGLA
,LIMITE_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO
,LIMITE_FUNCIONARIO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA AS MOEDA_SIGLA
,LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO
,LIMITE_FUNCIONARIO.PLAFOUND
FROM LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
WHERE LIMITE_FUNCIONARIO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
'
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_APPS = ''' + @COD_APPS + ''''
      IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
            SET @SQL=@SQL + ' AND APPS.APPS_NOME LIKE ''%' + @APPS_NOME + '%'''
      IF @COD_FUNCIONARIO IS NOT NULL
         AND @COD_FUNCIONARIO <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_FUNCIONARIO = ''' + @COD_FUNCIONARIO + ''''
      IF @FUNCIONARIO_NOME IS NOT NULL
         AND @FUNCIONARIO_NOME <> ''
            SET @SQL=@SQL + ' AND FUNCIONARIO.FUNCIONARIO_NOME LIKE ''%' + @FUNCIONARIO_NOME + '%'''
      IF @COD_TIPO_AUTORIDADE IS NOT NULL
         AND @COD_TIPO_AUTORIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE = ''' + @COD_TIPO_AUTORIDADE + ''''
      IF @TIPO_AUTORIDADE_NOME IS NOT NULL
         AND @TIPO_AUTORIDADE_NOME <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME LIKE ''%' + @TIPO_AUTORIDADE_NOME + '%'''
      IF @COD_MOEDA IS NOT NULL
         AND @COD_MOEDA <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_MOEDA = ''' + @COD_MOEDA + ''''
      IF @MOEDA_NOME IS NOT NULL
         AND @MOEDA_NOME <> ''
            SET @SQL=@SQL + ' AND MOEDA.MOEDA_NOME LIKE ''%' + @MOEDA_NOME + '%'''
        END
      IF @PLAFOUND IS NOT NULL
         AND @PLAFOUND <> ''
        BEGIN
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.PLAFOUND L
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@APPS_NOME NVARCHAR(MAX),
@DESCRICAO NVARCHAR(MAX) = NULL,
@SIGLA NVARCHAR(100) = NULL,
@FL_CONTEMPLA_AUTORIDADES BIT = NULL
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM APPS WHERE 
APPS_NOME = @APPS_NOME AND
FL_EXCLU = 0 AND
DESCRICAO = @DESCRICAO AND
SIGLA = @SIGLA AND
FL_CONTEMPLA_AUTORIDADES = @FL_CONTEMPLA_AUTORIDADES
AND ID_APPS <> @ID_APPS
)
UPDATE APPS
SET
[APPS_NOME] = @APPS_NOME,
[DESCRICAO] = @DESCRICAO,
[SIGLA] = @SIGLA,
[FL_CONTEMPLA_AUTORIDADES] = @FL_CONTEMPLA_AUTORIDADES
WHERE ID_APPS = @ID_APPS
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'APPS','ALTERAR',@ID_APPS ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE APPS COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_LIMITE_FUNCIONARIO INT
AS
  BEGIN
      SELECT LIMITE_FUNCIONARIO.COD_APPS,
             APPS.ID_APPS,
             APPS.APPS_NOME,
             APPS.DESCRICAO AS A_DESCRICAO,
             APPS.SIGLA AS A_SIGLA,
             LIMITE_FUNCIONARIO.COD_FUNCIONARIO,
             FUNCIONARIO.ID_FUNCIONARIO,
             FUNCIONARIO.FUNCIONARIO_NOME,
             FUNCIONARIO.COD_FUNCAO,
             FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_BALCAO,
             LIMITE_FUNCIONARIO.COD_MOEDA,
             MOEDA.ID_MOEDA,
             MOEDA.MOEDA_NOME,
             MOEDA.SIGLA AS M_SIGLA,
             LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME,
             TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO,
             TIPO_AUTORIDADE.COD_SITUACAO,
             LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO,
             LIMITE_FUNCIONARIO.PLAFOUND
      FROM   LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
             LEFT JOIN APPS APPS
               ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
             LEFT JOIN FUNCIONARIO FUNCIONARIO
               ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
             LEFT JOIN MOEDA MOEDA
               ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
             INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE
               ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
      WHERE  LIMITE_FUNCIONARIO.FL_EXCLU = 0
             AND APPS.FL_EXCLU = 0
             AND FUNCIONARIO.FL_EXCLU = 0
             AND [ID_LIMITE_FUNCIONARIO] = @ID_LIMITE_FUNCIONARIO
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_CONSULTAR_COUNT]
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX) = '
SELECT  COUNT(ID_APPS)  FROM APPS WHERE FL_EXCLU = 0
'
EXEC (@SQL)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_CONSULTAR_INDEX]
AS
  BEGIN
      SELECT LIMITE_FUNCIONARIO.COD_APPS,
             APPS.ID_APPS,
             APPS.APPS_NOME,
             APPS.DESCRICAO            AS APPS_DESCRICAO,
             APPS.SIGLA                AS APPS_SIGLA,
             LIMITE_FUNCIONARIO.COD_FUNCIONARIO,
             FUNCIONARIO.ID_FUNCIONARIO,
             FUNCIONARIO.FUNCIONARIO_NOME,
             FUNCIONARIO.COD_FUNCAO,
             FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_BALCAO,
             FUNCIONARIO.USUARIO,
             LIMITE_FUNCIONARIO.COD_MOEDA,
             MOEDA.ID_MOEDA,
             MOEDA.MOEDA_NOME,
             MOEDA.SIGLA               AS MOEDA_SIGLA,
             LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME,
             TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO,
             TIPO_AUTORIDADE.COD_SITUACAO,
             LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO,
             LIMITE_FUNCIONARIO.PLAFOUND
      FROM   LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
             LEFT JOIN APPS APPS
               ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
             LEFT JOIN FUNCIONARIO FUNCIONARIO
               ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
             LEFT JOIN MOEDA MOEDA
               ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
             INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE
               ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
      WHERE  LIMITE_FUNCIONARIO.FL_EXCLU = 0
             AND APPS.FL_EXCLU = 0
             AND FUNCIONARIO.FL_EXCLU = 0
      ORDER  BY FUNCIONARIO.FUNCIONARIO_NOME
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_CONSULTAR_FILTROS]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_APPS                  NVARCHAR(MAX) = NULL,
                                                    @APPS_NOME                NVARCHAR(MAX) = NULL,
                                                    @DESCRICAO                NVARCHAR(MAX) = NULL,
                                                    @SIGLA                    NVARCHAR(MAX) = NULL,
                                                    @FL_CONTEMPLA_AUTORIDADES NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
  SELECT



,A.FL_CONTEMPLA_AUTORIDADES,
 (SELECT COUNT(COD_APPS) FROM   PERCURSOS P WHERE P.COD_APPS = A.ID_APPS         
                     AND P.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '''') AS TOTAL_PERCURSOS,
					   (SELECT COUNT(COD_APPS)
              FROM   TIPO_AUTORIDADE T
              WHERE  T.COD_APPS = A.ID_APPS
                     AND T.FL_EXCLU = 0
					 AND A.FL_CONTEMPLA_AUTORIDADES = 1
                     AND T.TIPO_AUTORIDADE_NOME <> '''') AS TOTAL_AUTORIDADES
FROM APPS A
WHERE A.FL_EXCLU = 0
      IF @ID_APPS IS NOT NULL
         AND @ID_APPS <> ''
            SET @SQL=@SQL + ' AND A.ID_APPS = ''' + @ID_APPS + ''''
      IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
            SET @SQL=@SQL + ' AND A.APPS_NOME LIKE ''%' + @APPS_NOME + '%'''
      IF @DESCRICAO IS NOT NULL
         AND @DESCRICAO <> ''
            SET @SQL=@SQL + ' AND A.DESCRICAO LIKE ''%' + @DESCRICAO + '%'''
      IF @SIGLA IS NOT NULL
         AND @SIGLA <> ''
            SET @SQL=@SQL + ' AND A.SIGLA LIKE ''%' + @SIGLA + '%'''
      IF @FL_CONTEMPLA_AUTORIDADES IS NOT NULL
         AND @FL_CONTEMPLA_AUTORIDADES <> ''
        BEGIN
            SET @SQL=@SQL + ' AND A.FL_CONTEMPLA_AUTORIDADES LIKE ''%' + @FL_CONTEMPLA_AUTORIDADES + '%'''
        END
      SET @SQL=@SQL + '
  GROUP BY
A.ID_APPS
,A.APPS_NOME
,A.DESCRICAO
,A.SIGLA
,A.FL_CONTEMPLA_AUTORIDADES
'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_IMPORTAR_1] @FUNCIONARIO_NOME   NVARCHAR(MAX),                                              
                                                 @COD_LOG_UTILIZADOR INT,                                                
                                                 @USUARIO            NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   FUNCIONARIO
                    WHERE  FUNCIONARIO_NOME = @FUNCIONARIO_NOME
                           AND FL_EXCLU = 0                           
                           AND USUARIO = @USUARIO)
        BEGIN
            INSERT INTO [DBO].[FUNCIONARIO]
                        ([FUNCIONARIO_NOME],
                         [FL_EXCLU],
                         [COD_FUNCAO],
                         [COD_BALCAO],
                         [USUARIO],
                         [NUMERO])
            VALUES      ( @FUNCIONARIO_NOME,
                          0,
                          NULL,
                          @USUARIO,
                          NULL )
            SELECT MAX(ID_FUNCIONARIO) AS IDENTITTY
            FROM   FUNCIONARIO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_FUNCIONARIO) FROM
        FUNCIONARIO)
            ----EXEC PROC_LOGS_INSERIR
            ----  @COD_LOG_UTILIZADOR,
            ----  'FUNCIONARIO',
            ----  'INSERIR',
            ----  @IDENTITTY,
            ----  NULL
        END
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_CONSULTAR_LISTA_DROP]
AS
BEGIN
SELECT
LIMITE_FUNCIONARIO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,LIMITE_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,LIMITE_FUNCIONARIO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO
,LIMITE_FUNCIONARIO.PLAFOUND
FROM LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS AND APPS.FL_EXCLU=0
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO AND FUNCIONARIO.FL_EXCLU=0
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA AND MOEDA.FL_EXCLU=0
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE AND TIPO_AUTORIDADE.FL_EXCLU=0
WHERE LIMITE_FUNCIONARIO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
 ORDER BY FUNCIONARIO.FUNCIONARIO_NOME
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_APPS INT
AS
  BEGIN
      SELECT A.ID_APPS,
             A.APPS_NOME,
             A.DESCRICAO,
             A.SIGLA,
             A.FL_CONTEMPLA_AUTORIDADES,
             (SELECT COUNT(COD_APPS)
              FROM   PERCURSOS P
              WHERE  P.COD_APPS = A.ID_APPS
                     AND P.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '')       AS TOTAL_PERCURSOS,
              (SELECT COUNT(COD_APPS)
              FROM   TIPO_AUTORIDADE T
              WHERE  T.COD_APPS = A.ID_APPS
                     AND T.FL_EXCLU = 0
					 AND A.FL_CONTEMPLA_AUTORIDADES = 1
                     AND T.TIPO_AUTORIDADE_NOME <> '') AS TOTAL_AUTORIDADES
      FROM   APPS A
      WHERE  A.FL_EXCLU = 0
             AND [ID_APPS] = @ID_APPS
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_EXCLUIR]
@ID_LIMITE_FUNCIONARIO INT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE LIMITE_FUNCIONARIO
SET FL_EXCLU = 1 WHERE 
[ID_LIMITE_FUNCIONARIO] = @ID_LIMITE_FUNCIONARIO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LIMITE FUNCIONARIO','EXCLUIR',@ID_LIMITE_FUNCIONARIO ,NULL

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_CONSULTAR_INDEX]
AS
  BEGIN
      SELECT A.ID_APPS,
             A.APPS_NOME,
             A.DESCRICAO,
             A.SIGLA,
             A.FL_CONTEMPLA_AUTORIDADES,
 (SELECT COUNT(COD_APPS) FROM   PERCURSOS P WHERE P.COD_APPS = A.ID_APPS         
                     AND P.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_PERCURSOS,
					   (SELECT COUNT(COD_APPS)
              FROM   TIPO_AUTORIDADE T
              WHERE  T.COD_APPS = A.ID_APPS
                     AND T.FL_EXCLU = 0
					 AND A.FL_CONTEMPLA_AUTORIDADES = 1
                     AND T.TIPO_AUTORIDADE_NOME <> '') AS TOTAL_AUTORIDADES
      FROM   APPS A
      WHERE  A.FL_EXCLU = 0
      ORDER  BY A.APPS_NOME
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_CONSULTAR_LISTA_DROP]
AS
  BEGIN
      SELECT A.ID_APPS,
             A.APPS_NOME,
             A.DESCRICAO,
             A.SIGLA,
             A.FL_CONTEMPLA_AUTORIDADES,
 (SELECT COUNT(COD_APPS) FROM   PERCURSOS P WHERE P.COD_APPS = A.ID_APPS         
                     AND P.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_PERCURSOS,
					   (SELECT COUNT(COD_APPS)
              FROM   TIPO_AUTORIDADE T
              WHERE  T.COD_APPS = A.ID_APPS
                     AND T.FL_EXCLU = 0
					 AND A.FL_CONTEMPLA_AUTORIDADES = 1
                     AND T.TIPO_AUTORIDADE_NOME <> '') AS TOTAL_AUTORIDADES
      FROM   APPS A
      WHERE  A.FL_EXCLU = 0
      ORDER  BY A.APPS_NOME
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_FUNCIONARIO_INSERIR] @COD_APPS            INT,
                                                        @COD_FUNCIONARIO     INT,
                                                        @COD_TIPO_AUTORIDADE INT,
                                                        @COD_MOEDA           INT = NULL,
                                                        @PLAFOUND            NVARCHAR(30) = NULL,
                                                        @COD_LOG_UTILIZADOR  INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   LIMITE_FUNCIONARIO
                    WHERE  FL_EXCLU = 0
                           AND COD_APPS = @COD_APPS
                           AND COD_FUNCIONARIO = @COD_FUNCIONARIO
                           AND COD_TIPO_AUTORIDADE = @COD_TIPO_AUTORIDADE
                           AND COD_MOEDA = @COD_MOEDA
                           AND PLAFOUND = @PLAFOUND)
            INSERT INTO [DBO].[LIMITE_FUNCIONARIO]
                        ([FL_EXCLU],
                         [COD_APPS],
                         [COD_FUNCIONARIO],
                         [COD_TIPO_AUTORIDADE],
                         [COD_MOEDA],
                         [PLAFOUND])
            VALUES      ( 0,
                          @COD_APPS,
                          @COD_FUNCIONARIO,
                          @COD_TIPO_AUTORIDADE,
                          @COD_MOEDA,
                          @PLAFOUND )
            SELECT MAX(ID_LIMITE_FUNCIONARIO) AS IDENTITTY
            FROM   LIMITE_FUNCIONARIO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_LIMITE_FUNCIONARIO) FROM
        LIMITE_FUNCIONARIO)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'LIMITE FUNCIONARIO',
              'INSERIR',
              @IDENTITTY,
              NULL
      ELSE
        BEGIN
            RAISERROR('JÁ EXISTE REGISTO DE LIMITE FUNCIONARIO COM ESTES DADOS!',16,1)
        END
  END 


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE APPS
SET FL_EXCLU = 1 WHERE 
[ID_APPS] = @ID_APPS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'APPS','EXCLUIR',@ID_APPS ,NULL

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_INSERIR] @APPS_NOME                NVARCHAR(MAX),
                                          @DESCRICAO                NVARCHAR(MAX) = NULL,
                                          @SIGLA                    NVARCHAR(100) = NULL,
                                          @FL_CONTEMPLA_AUTORIDADES BIT = NULL,
                                          @COD_LOG_UTILIZADOR       INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   APPS
                    WHERE  APPS_NOME = @APPS_NOME
                           AND FL_EXCLU = 0
                           AND DESCRICAO = @DESCRICAO
                           AND SIGLA = @SIGLA
                           AND FL_CONTEMPLA_AUTORIDADES = @FL_CONTEMPLA_AUTORIDADES)
        BEGIN
            INSERT INTO [DBO].[APPS]
                        ([APPS_NOME],
                         [FL_EXCLU],
                         [DESCRICAO],
                         [SIGLA],
                         [FL_CONTEMPLA_AUTORIDADES])
            VALUES      ( @APPS_NOME,
                          0,
                          @DESCRICAO,
                          @SIGLA,
                          @FL_CONTEMPLA_AUTORIDADES )
            SELECT MAX(ID_APPS) AS IDENTITTY
            FROM   APPS
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_APPS) FROM
        APPS)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'APPS',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_ALTERAR]
@ID_LIMITE_GRUPO INT,
@COD_APPS INT,
@COD_GRUPO_RESPONSABILIDADE INT,
@COD_TIPO_AUTORIDADE INT,
@COD_MOEDA INT = NULL,
@PLAFOUND NVARCHAR(30) = NULL
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM LIMITE_GRUPO WHERE 
FL_EXCLU = 0 AND
COD_APPS = @COD_APPS AND
COD_GRUPO_RESPONSABILIDADE = @COD_GRUPO_RESPONSABILIDADE AND
COD_TIPO_AUTORIDADE = @COD_TIPO_AUTORIDADE AND
COD_MOEDA = @COD_MOEDA AND
PLAFOUND = @PLAFOUND
AND ID_LIMITE_GRUPO <> @ID_LIMITE_GRUPO
)
UPDATE LIMITE_GRUPO
SET
[COD_APPS] = @COD_APPS,
[COD_GRUPO_RESPONSABILIDADE] = @COD_GRUPO_RESPONSABILIDADE,
[COD_TIPO_AUTORIDADE] = @COD_TIPO_AUTORIDADE,
[COD_MOEDA] = @COD_MOEDA,
[PLAFOUND] = @PLAFOUND
WHERE ID_LIMITE_GRUPO = @ID_LIMITE_GRUPO
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LIMITE GRUPO','ALTERAR',@ID_LIMITE_GRUPO ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE LIMITE GRUPO COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_LIMITE_GRUPO)  FROM LIMITE_GRUPO WHERE FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_FILTROS] @COD_APPS                    NVARCHAR(MAX) = NULL,
                                                            @APPS_NOME                   NVARCHAR(MAX) = NULL,
                                                            @COD_GRUPO_RESPONSABILIDADE  NVARCHAR(MAX) = NULL,
                                                            @GRUPO_RESPONSABILIDADE_NOME NVARCHAR(MAX) = NULL,
                                                            @COD_TIPO_AUTORIDADE         NVARCHAR(MAX) = NULL,
                                                            @TIPO_AUTORIDADE_NOME        NVARCHAR(MAX) = NULL,
                                                            @COD_MOEDA                   NVARCHAR(MAX) = NULL,
                                                            @MOEDA_NOME                  NVARCHAR(MAX) = NULL,
                                                            @PLAFOUND                    NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
  SELECT
LIMITE_GRUPO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA
,LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO AS GR_DESCRICAO
,LIMITE_GRUPO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA AS MOEDA_SIGLA
,LIMITE_GRUPO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_GRUPO.ID_LIMITE_GRUPO
,LIMITE_GRUPO.PLAFOUND
FROM LIMITE_GRUPO LIMITE_GRUPO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND TIPO_AUTORIDADE.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
'
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_APPS = ''' + @COD_APPS + ''''
      IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
            SET @SQL=@SQL + ' AND APPS.APPS_NOME LIKE ''%' + @APPS_NOME + '%'''
      IF @COD_GRUPO_RESPONSABILIDADE IS NOT NULL
         AND @COD_GRUPO_RESPONSABILIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE = ''' + @COD_GRUPO_RESPONSABILIDADE + ''''
      IF @GRUPO_RESPONSABILIDADE_NOME IS NOT NULL
         AND @GRUPO_RESPONSABILIDADE_NOME <> ''
            SET @SQL=@SQL + ' AND GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME LIKE ''%' + @GRUPO_RESPONSABILIDADE_NOME + '%'''
      IF @COD_TIPO_AUTORIDADE IS NOT NULL
         AND @COD_TIPO_AUTORIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_TIPO_AUTORIDADE = ''' + @COD_TIPO_AUTORIDADE + ''''
      IF @TIPO_AUTORIDADE_NOME IS NOT NULL
         AND @TIPO_AUTORIDADE_NOME <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME LIKE ''%' + @TIPO_AUTORIDADE_NOME + '%'''
      IF @COD_MOEDA IS NOT NULL
         AND @COD_MOEDA <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_MOEDA = ''' + @COD_MOEDA + ''''
      IF @MOEDA_NOME IS NOT NULL
         AND @MOEDA_NOME <> ''
        BEGIN
            SET @SQL=@SQL + ' AND MOEDA.MOEDA_NOME LIKE ''%' + @MOEDA_NOME + '%'''
        END
      IF @PLAFOUND IS 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_PERCURSOS_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_APPS_PERCURSOS)  FROM APPS_PERCURSOS WHERE FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_ID]
@ID_LIMITE_GRUPO INT
AS
BEGIN
SELECT
LIMITE_GRUPO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO
,LIMITE_GRUPO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_GRUPO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_GRUPO.ID_LIMITE_GRUPO
,LIMITE_GRUPO.PLAFOUND
FROM LIMITE_GRUPO LIMITE_GRUPO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND TIPO_AUTORIDADE.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
AND
[ID_LIMITE_GRUPO] = @ID_LIMITE_GRUPO
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_ID_GRUPO_RESP] @COD_APPS                    NVARCHAR(MAX) = NULL,                                                          
                                                            @COD_GRUPO_RESPONSABILIDADE  NVARCHAR(MAX) = NULL                                                          
AS
  BEGIN
  SELECT


,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA


,GRUPO_RESPONSABILIDADE.DESCRICAO AS GR_DESCRICAO


,MOEDA.SIGLA AS MOEDA_SIGLA


,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO

,LIMITE_GRUPO.PLAFOUND
FROM LIMITE_GRUPO LIMITE_GRUPO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND TIPO_AUTORIDADE.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
 AND LIMITE_GRUPO.COD_APPS =  @COD_APPS
AND LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE = @COD_GRUPO_RESPONSABILIDADE
GROUP BY
LIMITE_GRUPO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO
,LIMITE_GRUPO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_GRUPO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_GRUPO.ID_LIMITE_GRUPO
,LIMITE_GRUPO.PLAFOUND 
ORDER BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_INDEX]
AS
  BEGIN
      SELECT LIMITE_GRUPO.COD_APPS,
             APPS.ID_APPS,
             APPS.APPS_NOME,
             APPS.DESCRICAO                   AS APPS_DESCRICAO,
             APPS.SIGLA                       AS APPS_SIGLA,
             LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE,
             GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE,
             GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME,
             GRUPO_RESPONSABILIDADE.DESCRICAO AS GR_DESCRICAO,
             LIMITE_GRUPO.COD_MOEDA,
             MOEDA.ID_MOEDA,
             MOEDA.MOEDA_NOME,
             MOEDA.SIGLA AS MOEDA_SIGLA,
             LIMITE_GRUPO.COD_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE,
             TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME,
             TIPO_AUTORIDADE.DESCRICAO        AS TA_DESCRICAO,
             TIPO_AUTORIDADE.COD_SITUACAO,
             LIMITE_GRUPO.ID_LIMITE_GRUPO,
             LIMITE_GRUPO.PLAFOUND
      FROM   LIMITE_GRUPO LIMITE_GRUPO
             LEFT JOIN APPS APPS
               ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
             LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
               ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
             LEFT JOIN MOEDA MOEDA
               ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
             LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE
               ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
      WHERE  LIMITE_GRUPO.FL_EXCLU = 0
             AND APPS.FL_EXCLU = 0
             AND TIPO_AUTORIDADE.FL_EXCLU = 0
             AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
      ORDER  BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_CONSULTAR_LISTA_DROP]
AS
BEGIN
SELECT
LIMITE_GRUPO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO
,LIMITE_GRUPO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_GRUPO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_GRUPO.ID_LIMITE_GRUPO
,LIMITE_GRUPO.PLAFOUND
FROM LIMITE_GRUPO LIMITE_GRUPO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS AND APPS.FL_EXCLU=0
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE AND GRUPO_RESPONSABILIDADE.FL_EXCLU=0
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA AND MOEDA.FL_EXCLU=0
LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE AND TIPO_AUTORIDADE.FL_EXCLU=0
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND TIPO_AUTORIDADE.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
 ORDER BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_PERCURSOS_CONSULTAR_LISTA_DROP]
AS
  BEGIN
      WITH EMP_CTE ( ID_APPS, APPS_NOME, DESCRICAO, SIGLA )
           AS (SELECT DISTINCT APPS.ID_APPS,


               FROM   PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
                        ON PERCURSOS_FUNCIONARIO.COD_PERCURSOS = PERCURSOS.ID_PERCURSOS
                        ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
                        ON APPS.ID_APPS = PERCURSOS.COD_APPS
               WHERE  PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
                      AND APPS.FL_EXCLU = 0
                      AND FUNCIONARIO.FL_EXCLU = 0
                                   UNION ALL
               SELECT DISTINCT APPS.ID_APPS,
                               APPS.APPS_NOME,
                               APPS.DESCRICAO,
                               APPS.SIGLA
               FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
                      INNER JOIN FUNCAO FUNCAO
                        ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
                      INNER JOIN PERCURSOS PERCURSOS
                        ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
                      INNER JOIN FUNCIONARIO FUNCIONARIO
                        ON FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                      INNER JOIN APPS APPS
                        ON PERCURSOS.COD_APPS = APPS.ID_APPS
               WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
                      AND PERCURSOS.FL_EXCLU = 0
                      AND FUNCAO.FL_EXCLU = 0
                      )
      SELECT DISTINCT ID_APPS,
                      APPS_NOME,
                      DESCRICAO,
                      SIGLA
      FROM   EMP_CTE
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_EXCLUIR]
@ID_LIMITE_GRUPO INT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE LIMITE_GRUPO
SET FL_EXCLU = 1 WHERE 
[ID_LIMITE_GRUPO] = @ID_LIMITE_GRUPO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LIMITE GRUPO','EXCLUIR',@ID_LIMITE_GRUPO ,NULL

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_INSERIR]
@COD_APPS INT,
@COD_GRUPO_RESPONSABILIDADE INT,
@COD_TIPO_AUTORIDADE INT,
@COD_MOEDA INT = NULL,
@PLAFOUND NVARCHAR(30) = NULL
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM LIMITE_GRUPO WHERE 
FL_EXCLU = 0 AND
COD_APPS = @COD_APPS AND
COD_GRUPO_RESPONSABILIDADE = @COD_GRUPO_RESPONSABILIDADE AND
COD_TIPO_AUTORIDADE = @COD_TIPO_AUTORIDADE AND
COD_MOEDA = @COD_MOEDA AND
PLAFOUND = @PLAFOUND

INSERT INTO [DBO].[LIMITE_GRUPO]
[FL_EXCLU],
[COD_APPS],
[COD_GRUPO_RESPONSABILIDADE],
[COD_TIPO_AUTORIDADE],
[COD_MOEDA],
[PLAFOUND]
VALUES
(
0,
@COD_APPS,
@COD_GRUPO_RESPONSABILIDADE,
@COD_TIPO_AUTORIDADE,
@COD_MOEDA,
@PLAFOUND
)
SELECT MAX(ID_LIMITE_GRUPO) AS IDENTITTY FROM LIMITE_GRUPO WHERE FL_EXCLU = 0
DECLARE @IDENTITTY INT = (SELECT MAX(ID_LIMITE_GRUPO) FROM LIMITE_GRUPO)
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LIMITE GRUPO','INSERIR',@IDENTITTY ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE LIMITE GRUPO COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_ALTERAR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@COD_PAIS INT,
	@PROVINCIA VARCHAR(30),
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	IF NOT EXISTS(SELECT * FROM PROVINCIAS	WHERE COD_PAIS=@COD_PAIS AND PROVINCIA=@PROVINCIA AND FL_EXCLU=0)
			UPDATE [DBO].[PROVINCIAS]
				SET [COD_PAIS] = @COD_PAIS,[PROVINCIA] =@PROVINCIA 
				WHERE ID_PROVINCIA=@ID_PROVINCIA
				EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PROVINCIAS','ALTERAR',@ID_PROVINCIA,NULL
	ELSE
		BEGIN
			RAISERROR('ESTA PROVINCIA JÁ EXISTE!',16,1)
		END
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_CONSULTA]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT P.ID_PROVINCIA,P.PROVINCIA,PA.PAIS,P.COD_PAIS FROM PROVINCIAS P INNER JOIN PAISES PA
	ON P.COD_PAIS=PA.ID_PAIS
	WHERE P.FL_EXCLU=0 
	ORDER BY P.PROVINCIA ASC
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LIMITE_GRUPO_UTILIZADOR_IMPORTAR] @APPS_SIGLA                       NVARCHAR(100) = NULL,
                                                              @APPS_NOME                        NVARCHAR(100) = NULL,
                                                              @GRUPO_RESPONSABILIDADE_NOME      NVARCHAR(100) = NULL,
                                                              @GRUPO_RESPONSABILIDADE_DESCRICAO NVARCHAR(100) = NULL,
                                                              @SITUACAO                         NVARCHAR(100) = NULL,
                                                              @TIPO_AUTORIDADE_NOME             NVARCHAR(100) = NULL,
                                                              @TIPO_AUTORIDADE_DESCRICAO        NVARCHAR(100) = NULL,
                                                              @PLAFOUND                         NVARCHAR(100) = NULL,
                                                              @MOEDA_NOME                       NVARCHAR(100) = NULL,
                                                              @TIPO_ENTIDADE                    INT,
                                                              @COD_LOG_UTILIZADOR               INT,
                                                              @NUMERO_FUNCIONARIO               NVARCHAR(15) = NULL
AS
  BEGIN
      EXEC PROC_APPS_INSERIR   	
      @APPS_NOME,
      '',
      @APPS_SIGLA,
      1,
      @COD_LOG_UTILIZADOR
      EXEC PROC_SITUACAO_IMPORTAR
        @SITUACAO,
      EXEC PROC_MOEDA_IMPORTAR
        @MOEDA_NOME,
        @COD_LOG_UTILIZADOR
      DECLARE @COD_APPS INT = (SELECT TOP (1) ID_APPS FROM APPS WHERE
  APPS_NOME = @APPS_NOME AND SIGLA = @APPS_SIGLA AND FL_EXCLU = 0)
      DECLARE @COD_SITUACAO INT = (SELECT TOP (1) ID_SITUACAO FROM SITUACAO WHERE
  SIGLA = @SITUACAO AND FL_EXCLU = 0)
      UPDATE APPS
      SET    FL_CONTEMPLA_AUTORIDADES = 1
      WHERE  ID_APPS = @COD_APPS
      EXEC PROC_TIPO_AUTORIDADE_IMPORTAR
        @TIPO_AUTORIDADE_NOME,
        @TIPO_AUTORIDADE_DESCRICAO,
        @COD_SITUACAO,
        @COD_LOG_UTILIZADOR,
        @COD_APPS
      --END
      DECLARE @COD_TIPO_AUTORIDADE INT = (SELECT TOP (1) ID_TIPO_AUTORIDADE FROM TIPO_AUTORIDADE WHERE
  TIPO_AUTORIDADE_NOME = @TIPO_AUTORIDADE_NOME AND DESCRICAO = @TIPO_AUTORIDADE_DESCRICAO AND COD_SITUACAO=@COD_SITUACAO AND COD_APPS = @COD_APPS AND FL_EXCLU = 0)
	  DECLARE @COD_MOEDA INT = (SELECT TOP (1) ID_MOEDA FROM MOEDA WHERE  SIGLA = @MOEDA_NOME AND FL_EXCLU = 0)
      IF ( @TIPO_ENTIDADE = 1 )
        BEGIN
                       DECLARE @COD_FUNCIONARIO INT
            IF( @NUMERO_FUNCIONARIO IS NOT NULL
                AND @NUMERO_FUNCIONARIO <> '' )


                                          WHERE  NUMERO = @NUMERO_FUNCIONARIO

            ELSE
              BEGIN
			   EXEC PROC_FUNCIONARIO_IMPORTAR_1
              @GRUPO_RESPONSABILIDADE_DESCRICAO,
              @COD_LOG_UTILIZADOR,
              @GRUPO_RESPONSABILIDADE_NOME
                  SET @COD_FUNCIONARIO = (SELECT TOP (1) ID_FUNCIONARIO
                                          FROM   FUNCIONARIO
                                          WHERE  USUARIO = @GRUPO_RESPONSABILIDADE_NOME
                                                 AND FUNCIONARIO_NOME = @GRUPO_RESPONSABILIDADE_DESCRICAO
                                                 AND FL_EXCLU = 0)
              END
            EXEC PROC_LIMITE_FUNCIONARIO_INSERIR
              @COD_APPS,
              @COD_FUNCIONARIO,
              @COD_TIPO_AUTORIDADE,
              @COD_MOEDA,
              @PLAFO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_AUDIT_INSERIR] @TABELA   NVARCHAR(50),
                                           @COLUNA   NVARCHAR(50),
                                           @V_ANTES  NVARCHAR(MAX),
                                           @V_DEPOIS NVARCHAR(MAX),
										   @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      INSERT INTO [DBO].[AUDIT]
                  ([TABELA],
                   [COLUNA],
                   [V_ANTES],
                   [V_DEPOIS],
                   [DT_CADASTRO],
				   [COD_UTILIZADORES]
				   )
      VALUES      ( @TABELA,
                    @COLUNA,
                    @V_ANTES,
                    @V_DEPOIS,
                    GETDATE(),
					@COD_LOG_UTILIZADOR 
					)
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_CONSULTA_PAIS]
	@COD_PAIS INT=NULL,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	SET NOCOUNT ON;
	IF @COD_PAIS<>'' AND @COD_PAIS IS NOT NULL
			SELECT P.ID_PROVINCIA,P.PROVINCIA, PA.ID_PAIS, PA.PAIS FROM PROVINCIAS P INNER JOIN PAISES PA ON P.COD_PAIS=PA.ID_PAIS	WHERE P.FL_EXCLU=0 AND P.COD_PAIS=@COD_PAIS
		END
	ELSE
		BEGIN
			SELECT P.ID_PROVINCIA,P.PROVINCIA, PA.ID_PAIS, PA.PAIS FROM PROVINCIAS P INNER JOIN PAISES PA ON P.COD_PAIS=PA.ID_PAIS	WHERE P.FL_EXCLU=0 AND P.COD_PAIS=0
		END	
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LOGIN_AUTENTICAR] @EMAIL    VARCHAR(200),
                                              @PASSWORD VARCHAR(100) =NULL
AS
  BEGIN
      DECLARE @COUNT INT
      --VER SE O EMAIL EXISTE
      IF EXISTS(SELECT *
                FROM   UTILIZADORES
                WHERE  EMAIL = @EMAIL
                       AND FL_EXCLU = 0)
        BEGIN
            -- VER SE A CONTA ESTÁ ACTIVA
            IF EXISTS(SELECT *
                      FROM   UTILIZADORES
                      WHERE  EMAIL = @EMAIL
                             AND BLOQUEADO = 0)
              BEGIN
                  -- VER SE A SENHA ESTÁ CORRECTA
                  IF EXISTS(SELECT *
                            FROM   UTILIZADORES
                            WHERE  EMAIL = @EMAIL
                                   AND PALAVRA_PASSE = @PASSWORD)
                    BEGIN
                        -- VER SE A CONTA É DE UM SUPER ADMINISTRADOR
                        IF EXISTS(SELECT *
                                  FROM   UTILIZADORES
                                  WHERE  EMAIL = @EMAIL
                                         AND PALAVRA_PASSE = @PASSWORD
                                         AND FL_EXCLU = 0
                                         AND FL_ADMIN_PLATA = 1)
                              -- VER SE É A PRIMEIRA SESSÃO
                              IF EXISTS(SELECT *
                                        FROM   UTILIZADORES
                                        WHERE  EMAIL = @EMAIL
                                               AND PASS_TEMP = '')
                                    SELECT 1 AS RETURNCODE
                              ELSE
                                    SELECT 2 AS RETURNCODE
                                END
                          END
                        ELSE
                          BEGIN
                              IF EXISTS(SELECT ID_GRUPO
                                        FROM   GRUPOS G
                                               LEFT OUTER JOIN UTILIZADORES U
                                                 ON G.ID_GRUPO = U.COD_GRUPO
                                        WHERE  U.EMAIL = @EMAIL
                                               AND U.FL_EXCLU = 0)
                                BEGIN
                                    IF EXISTS(SELECT ID_GRUPO
                                              FROM   GRUPOS G
                                                     LEFT OUTER JOIN UTILIZADORES U
                                                       ON G.ID_GRUPO = U.COD_GRUPO
                                              WHERE  U.EMAIL = @EMAIL
                                                     AND G.ACTIVO_STR = 'SIM')
                                          IF EXISTS(SELECT *
                                                    FROM   UTILIZADORES
                                                    WHERE  EMAIL = @EMAIL
                                                           AND PASS_TEMP = '')
                                                SELECT 1 AS RETURNCODE
                                          ELSE
                                            BEGIN
                                                SELECT 2 AS RETURNCODE
                                            END
                                    ELSE
                                      BEGIN
                                          RAISERROR('O GRUPO AONDE FAZ PARTE ENCONTRA-SE INACTIVO, POR FAVOR CONTACTE O ADMINISTRADOR!',16,1)
                                      END
           
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@NM_BALCAO NVARCHAR(MAX),
@DESCRICAO NVARCHAR(MAX) = NULL
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE BALCAO
SET
[NM_BALCAO] = @NM_BALCAO,
[DESCRICAO] = @DESCRICAO
WHERE ID_BALCAO = @ID_BALCAO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'BALCAO','ALTERAR',@ID_BALCAO ,NULL


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_EXCLUIR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
			UPDATE [DBO].[PROVINCIAS]
				SET FL_EXCLU=1
				WHERE ID_PROVINCIA=@ID_PROVINCIA	
				EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PROVINCIAS','EXCLUIR',@ID_PROVINCIA,NULL	
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LOGIN_AUTENTICAR_DOMINIO] @EMAIL VARCHAR(200)
AS
  BEGIN
      --VER SE O EMAIL EXISTE
      IF EXISTS(SELECT *
                FROM   UTILIZADORES
                WHERE  USUARIO_DOMINIO = @EMAIL
                       AND FL_EXCLU = 0)
            -- VER SE A CONTA ESTÁ ACTIVA
            IF EXISTS(SELECT *
                      FROM   UTILIZADORES
                      WHERE  USUARIO_DOMINIO = @EMAIL
                             AND BLOQUEADO = 0)
                  -- VER SE A CONTA É DE UM SUPER ADMINISTRADOR
                  IF EXISTS(SELECT *
                            FROM   UTILIZADORES
                            WHERE  USUARIO_DOMINIO = @EMAIL
                                   AND FL_EXCLU = 0
                                   AND FL_ADMIN_PLATA = 1)
                        -- VER SE É A PRIMEIRA SESSÃO
                        IF EXISTS(SELECT *
                                  FROM   UTILIZADORES
                                  WHERE  USUARIO_DOMINIO = @EMAIL
                                         AND PASS_TEMP = '')
                              SELECT 1 AS RETURNCODE


                              SELECT 2 AS RETURNCODE

                  ELSE
                    BEGIN
                        IF EXISTS(SELECT ID_GRUPO
                                  FROM   GRUPOS G
                                         LEFT OUTER JOIN UTILIZADORES U
                                           ON G.ID_GRUPO = U.COD_GRUPO
                                  WHERE  U.USUARIO_DOMINIO = @EMAIL
                                         AND U.FL_EXCLU = 0)
                              IF EXISTS(SELECT ID_GRUPO
                                        FROM   GRUPOS G
                                               LEFT OUTER JOIN UTILIZADORES U
                                                 ON G.ID_GRUPO = U.COD_GRUPO
                                        WHERE  U.USUARIO_DOMINIO = @EMAIL
                                               AND G.ACTIVO_STR = 'SIM')
                                    IF EXISTS(SELECT *
                                              FROM   UTILIZADORES
                                              WHERE  USUARIO_DOMINIO = @EMAIL
                                                     AND PASS_TEMP = '')
                                          SELECT 1 AS RETURNCODE
                                    ELSE
                                      BEGIN
                                          SELECT 2 AS RETURNCODE
                                      END
                              ELSE
                                BEGIN
                                    RAISERROR('O GRUPO AONDE FAZ PARTE ENCONTRA-SE INACTIVO, POR FAVOR CONTACTE O ADMINISTRADOR!',16,1)
                                END
                        ELSE
                          BEGIN
                              RAISERROR('ESTE USUÁRIO NÃO FAZ PARTE DE NENHUM GRUPO DE USUÁRIOS, POR FAVOR CONTACTE O ADMINISTRADOR!',16,1)
                          END
                    END
            ELSE
              BEGIN
                  RAISERROR('A SUA CONTA ENCONTRA-SE BLOQUEADA, POR FAVOR CONTACTE O ADMINISTRADOR!',16,1)
              END
      ELSE
        BEGIN
            RAISERROR('ESTE UTILIZADOR NÃO EXISTE, POR FAVOR CONTACTE O ADMINISTRADOR!',16,1)
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_BALCAO)  FROM BALCAO WHERE FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_INSERIR]
	@COD_PAIS INT =NULL,
	@PROVINCIA VARCHAR(30),
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM PROVINCIAS	WHERE COD_PAIS=@COD_PAIS AND PROVINCIA=@PROVINCIA AND FL_EXCLU=0)
			INSERT INTO [DBO].[PROVINCIAS]
        	([COD_PAIS]
    	,[PROVINCIA]
    	,[FL_EXCLU])
			VALUES
				(@COD_PAIS,
				@PROVINCIA,
				0)
	DECLARE @IDENTITTY INT = (SELECT MAX(ID_PROVINCIA) FROM PROVINCIAS)
				EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PROVINCIAS','INSERIR',@IDENTITTY,NULL
	ELSE
		BEGIN
			RAISERROR('ESTA PROVINCIA JÁ EXISTE!',16,1)
		END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PROVINCIAS_INSERIR_ENTIDADES] 
	-- PAÍS
	@PAIS VARCHAR(20),
	-- UTILIZADOR_LOGS
	@COD_LOG_UTILIZADOR INT	= NULL
AS
BEGIN
	SET NOCOUNT ON;
	-- PROVÍNCIAS
	IF(@PAIS <> '')	BEGIN IF NOT EXISTS(SELECT * FROM PAISES	WHERE PAIS=@PAIS AND FL_EXCLU =0)
	BEGIN 
	INSERT INTO [DBO].[PAISES] ([PAIS],	[FL_EXCLU])	
	VALUES(@PAIS,0)  	
    DECLARE @IDENTITTY INT = (SELECT MAX(ID_PAIS) FROM PAISES)
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PAÍS','INSERIR', @IDENTITTY, NULL 
	END  ELSE BEGIN RAISERROR('ESTE PAÍS JÁ EXISTE',16,1) 
	END	
	END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_BALCAO INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT BALCAO.DESCRICAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
 (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_BALCAO = BALCAO.ID_BALCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS
      FROM   BALCAO BALCAO
      WHERE  BALCAO.FL_EXCLU = 0
             AND [ID_BALCAO] = @ID_BALCAO
  END
    SET ANSI_NULLS ON 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LOGIN_LOGOUT_INSERIR]
	@COD_LOG_UTILIZADOR INT,
	@TIPO_DE_LOG INT
AS
BEGIN
  	IF(@TIPO_DE_LOG = 1)
	    EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LOGIN','LOGIN',NULL,NULL
  	IF(@TIPO_DE_LOG = 2)
	BEGIN
	    EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'LOGIN','LOGOUT',NULL,NULL
	END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_CONSULTAR_INDEX]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT BALCAO.DESCRICAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
 (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_BALCAO = BALCAO.ID_BALCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS
      FROM   BALCAO BALCAO
      WHERE  BALCAO.FL_EXCLU = 0
	  ORDER BY BALCAO.NM_BALCAO
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- =============================================
-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
CREATE PROCEDURE [DBO].[PROC_LOGIN_NOME]
	@EMAIL VARCHAR(200),
	@PASSWORD VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;	
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT 
	UTILIZADOR, 
	ID_UTILIZADOR, 
	EMAIL,
	PALAVRA_PASSE,
	ISNULL([COD_GRUPO],0) COD_GRUPO,
	FL_ADMIN_PLATA 
	FROM UTILIZADORES
	WHERE EMAIL=@EMAIL 
	AND FL_EXCLU=0 
	AND	BLOQUEADO=0
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
BALCAO.DESCRICAO
,BALCAO.ID_BALCAO
,BALCAO.NM_BALCAO
FROM BALCAO BALCAO
WHERE BALCAO.FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- =============================================
-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
CREATE PROCEDURE [DBO].[PROC_LOGIN_NOME_DOMINIO] @EMAIL    VARCHAR(200)
AS
  BEGIN
      SELECT UTILIZADOR,
             ID_UTILIZADOR,
             EMAIL,
             PALAVRA_PASSE,
             ISNULL([COD_GRUPO], 0) COD_GRUPO,
             FL_ADMIN_PLATA
      FROM   UTILIZADORES
      WHERE  USUARIO_DOMINIO = @EMAIL
             AND FL_EXCLU = 0
             AND BLOQUEADO = 0
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE BALCAO
SET FL_EXCLU = 1 WHERE 
[ID_BALCAO] = @ID_BALCAO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'BALCAO','EXCLUIR',@ID_BALCAO ,NULL


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- =============================================
-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
CREATE PROCEDURE [DBO].[PROC_LOGIN_SESSAO]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;	
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT 
	UTILIZADOR, 
	ID_UTILIZADOR, 
	EMAIL,
	PALAVRA_PASSE,
	ISNULL([COD_GRUPO],0) COD_GRUPO,
	FL_ADMIN_PLATA 
	FROM UTILIZADORES
	WHERE ID_UTILIZADOR=@ID_UTILIZADOR 
	AND FL_EXCLU=0 
	AND	BLOQUEADO=0	
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_BALCAO_INSERIR] @NM_BALCAO          NVARCHAR(MAX),
                                            @DESCRICAO          NVARCHAR(MAX) = NULL,
                                            @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   BALCAO
                    WHERE  NM_BALCAO = @NM_BALCAO
                           AND DESCRICAO = @DESCRICAO
                           AND FL_EXCLU = 0)
        BEGIN
            INSERT INTO [DBO].[BALCAO]
                        ([NM_BALCAO],
                         [DESCRICAO],
                         [FL_EXCLU])
            VALUES      ( @NM_BALCAO,
                          @DESCRICAO,
                          0 )
            SELECT MAX(ID_BALCAO) AS IDENTITTY
            FROM   BALCAO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_BALCAO) FROM
        BALCAO)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'BALCAO',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_LOGS_CONSULTA]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT
	C.ID_LOG,	
	C.ACCAO,	
	C.COD_MODULO_ACCAO,
	C.MODULO,
	C.DATA,
	C.IP_ADRESS,
	M.UTILIZADOR
	FROM LOGS C
	LEFT OUTER JOIN UTILIZADORES M
	ON C.COD_UTILIZADOR=M.ID_UTILIZADOR	
	ORDER BY DATA DESC, UTILIZADOR DESC  
	--ASC,M.UTILIZADOR ASC	 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MENUS_CONSULTA_GRUPO_POR_PROFUNDIDADE] 






	@DT_ALT datetime2(7),	@ID                                                  @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID     INT= NULL,
                                                  @PROFUNDIDADE INT = NULL
AS
  BEGIN
      DECLARE @COD_GRUPO INT = (SELECT COD_GRUPO FROM UTILIZADORES WHERE
  ID_UTILIZADOR=@ID_UTILIZADOR AND FL_EXCLU=0)
      IF EXISTS(SELECT *
                FROM   [UTILIZADORES]
                WHERE  ID_UTILIZADOR = @ID_UTILIZADOR
                       AND FL_ADMIN_PLATA = 1)















			AND PROFUNDIDADE = @PROFUNDIDADE






                        WHEN 'GRUPOS' THEN 3.3
                        WHEN 'UTILIZADORES' THEN 3.4
                        WHEN 'CADASTROS' THEN 4
                        WHEN 'PAÍSES' THEN 4.1
                        WHEN 'PROVÍNCIAS' THEN 4.2
						 WHEN 'APPS' THEN 5
						 WHEN 'PERCURSO' THEN 6
						 WHEN 'GRUPO DE RESPONSABILIDADE' THEN 6.1
						 WHEN 'BALCÃO' THEN 7
						 WHEN 'FUNÇÃO' THEN 8
						 WHEN 'CENTRO DE CUSTOS' THEN 8.1
						 WHEN 'GESTÃO DE FUNÇÕES' THEN 8.2
						 WHEN 'FUNCIONÁRIO' THEN 9
                        WHEN 'IMPORTAR DADOS' THEN 10
                        WHEN 'PERCURSOS' THEN 10.1
                        WHEN 'CENTRO DE CUSTO' THEN 10.2
                        WHEN 'FUNÇÕES' THEN 10.3
                        WHEN 'RELATÓRIOS' THEN 11
                        ELSE 12
                      END
        END
      ELSE IF ( @COD_GRUPO IS NOT NULL
           AND @COD_GRUPO <> 0 )
        BEGIN
            SELECT [ID_NIVEL_ITEM],
                   [NM_NIVEL_ITEM],
                   [DS_NIVEL_ITEM],
                   ISNULL([DS_PESQUISA], 0)       DS_PESQUISA,
                   ISNULL([ID_NIVEL_ITEM_PAI], 0) ID_NIVEL_ITEM_PAI,
                   [DS_SUB_ITENS],
                   ISNULL([PROFUNDIDADE], 0)      PROFUNDIDADE,
                   DS_MENU_LINK,
                   IM.BT_ARQUIVO
            FROM   [DBO].[MENUS] M
                   LEFT OUTER JOIN IMAGEM_MENU_RELACIONAMENTO IR
                     ON COD_MENU = ID_NIVEL_ITEM
                   LEFT OUTER JOIN IMAGEM_MENU IM
                     ON IM.ID_ARQUIVO = IR.COD_IMAGEM
                   INNER JOIN GRUPOS_MENUS_REL R
                     ON R.COD_MENU = M.ID_NIVEL_ITEM
            WHERE  M.FL_EXCLU = 0
                   AND R.COD_GRUPO = @COD_GRUPO
                   AND R.FL_EXCLU = 0
				   AND PROFUNDIDADE = @PROFUNDIDADE
            ORDER  BY CASE NM_NIVEL_ITEM
                        WHEN 'PÁGINA INICIAL' THEN 1
                        WHEN 'MEU CADASTRO' THEN 2
                        WHEN 'PARÂMETROS' THEN 3
                        WHEN 'MODELO DE EMAIL' THEN 3.0
                        WHEN 'EMPRESA' THEN 3.1
                        WHEN 'PERCURSOS' THEN 3.2
                        WHEN 'GRUPOS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_LOGS_CONSULTA_FILTER] @UTILIZADOR VARCHAR (100) = NULL,
                                                  @ACCAO      VARCHAR (100) = NULL,
                                                  @MODULO     VARCHAR (100) = NULL,
                                                  @DATA_DE    VARCHAR (100) = NULL,
                                                  @DATA_ATE   VARCHAR (100) = NULL
AS
  BEGIN
      IF( @DATA_DE IS NOT NULL AND @DATA_ATE IS NOT NULL )














                   AND ( CAST(CONVERT(DATE, @DATA_DE, 103) AS DATE) <= CAST(CONVERT(DATE, DATA, 103) AS DATE))
                   AND  CAST(CONVERT(DATE, @DATA_ATE, 103) AS DATE)   >=  CAST(CONVERT(DATE, DATA, 103) AS DATE)
            ORDER  BY DATA ASC,

      ELSE
        BEGIN
            SELECT C.ID_LOG,
                   C.ACCAO,
                   C.COD_MODULO_ACCAO,
                   C.MODULO,
                   C.DATA,
                   C.IP_ADRESS,
                   M.UTILIZADOR
            FROM   LOGS C
                   LEFT OUTER JOIN UTILIZADORES M
                     ON C.COD_UTILIZADOR = M.ID_UTILIZADOR
            WHERE  
			       M.UTILIZADOR COLLATE LATIN1_GENERAL_CI_AI LIKE +'%' + @UTILIZADOR + '%' COLLATE LATIN1_GENERAL_CI_AI
                   AND C.ACCAO COLLATE LATIN1_GENERAL_CI_AI LIKE +'%' + @ACCAO + '%' COLLATE LATIN1_GENERAL_CI_AI
                   AND C.MODULO COLLATE LATIN1_GENERAL_CI_AI LIKE +'%' + @MODULO + '%' COLLATE LATIN1_GENERAL_CI_AI
            ORDER  BY 
			          DATA ASC,			       
                      UTILIZADOR DESC
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE[DBO].[PROC_EMPRESA_ALTERAR]	@GUIDE uniqueidentifier,










 

	@DT_ALT datetime2(7),
	@ID_EMPRE           INT,
                                            @DS_RAZAO_SOCIA     NVARCHAR(255)=NULL,
                                            @NM_FANTA           NVARCHAR(255)=NULL,
                                            @DS_ENDER           NVARCHAR(100)=NULL,
                                            @NR_ENDER           INT,
                                            @DS_ENDER_COMPL     NVARCHAR(100)=NULL,
                                            @DS_BAIRR           NVARCHAR(100)=NULL,
                                            @DS_ENDER_REFER     NVARCHAR(100)=NULL,
                                            @DS_ENDER_CIDAD     NVARCHAR(100)=NULL,
                                            @NR_DDI             INT,
                                            @NR_DDD             INT,
                                            @DS_TELEF           NVARCHAR(20)=NULL,
                                            @DS_SITE            NVARCHAR(255)=NULL,
                                            @DS_EMAIL           NVARCHAR(100)=NULL,
                                            @DS_EMAIL_PRIVA     NVARCHAR(100)=NULL,
                                            @DS_IP_WAN1         NVARCHAR(30)=NULL,
                                            @DS_IP_WAN2         NVARCHAR(30)=NULL,
                                            @EN_STATS           SMALLINT=NULL,
                                            --  @FL_EXCLU BIT ,






	@DT_ALT datetime2(7),	@ID                                            @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID           INT,
                                            @DS_SMTP_SENHA      VARCHAR(200) =NULL,
                                            @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      SET NOCOUNT ON;
      -- INSERT STATEMENTS FOR PROCEDURE HERE
      IF NOT EXISTS(SELECT *
                    FROM   EMPRESA
                    WHERE  FL_EXCLU = 0
                           AND ID_EMPRE <> @ID_EMPRE
                           AND NM_FANTA = @NM_FANTA
                           AND DS_RAZAO_SOCIA = @DS_RAZAO_SOCIA
                           AND DS_SITE = @DS_SITE
                           AND DS_EMAIL = @DS_EMAIL
                           AND [DS_IP_WAN2] = @DS_IP_WAN2
                           AND [NR_DDD] = @NR_DDD
                           AND [NR_DDI] = @NR_DDI
                           AND [DS_ENDER_CIDAD] = @DS_ENDER_CIDAD
                           AND [DS_ENDER_REFER] = @DS_ENDER_REFER
                           AND [DS_BAIRR] = @DS_BAIRR
                           AND [DS_ENDER_COMPL] = @DS_ENDER_COMPL)
            UPDATE EMPRESA
            SET    [DS_RAZAO_SOCIA] = @DS_RAZAO_SOCIA,
                   [NM_FANTA] = @NM_FANTA,
                   [DS_ENDER] = @DS_ENDER,
                   [NR_ENDER] = @NR_ENDER,
                   [DS_ENDER_COMPL] = @DS_ENDER_COMPL,
                   [DS_BAIRR] = @DS_BAIRR,
                   [DS_ENDER_REFER] = @DS_ENDER_REFER,
                   [DS_ENDER_CIDAD] = @DS_ENDER_CIDAD,
                   [NR_DDI] = @NR_DDI,
                   [NR_DDD] = @NR_DDD,
                   [DS_TELEF] = @DS_TELEF,
                   [DS_SITE] = @DS_SITE,
                   [DS_EMAIL] = @DS_EMAIL,
                   [DS_EMAIL_PRIVA] = @DS_EMAIL_PRIVA,
                   [DS_IP_WAN1] = @DS_IP_WAN1,
                   [DS_IP_WAN2] = @DS_IP_WAN2,
                   [EN_STATS] = @EN_STATS,
                   [ID_PAIS] = @ID_PAIS,
                   [DS_SMTP_SENHA] = @DS_SMTP_SENHA
            WHERE  ID_EMPRE = @ID_EMPRE
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'EMPRESAS',
              'ALTERAR',
              @ID_EMPRE,
              NULL
      ELSE
        BEGIN
            RAISERROR('ESTA EMPRESA JÃ EXISTE!',16,1)
        END
  END
SET ANSI_NULLS ON
SET 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE[DBO].[PROC_EMPRESA_ALTERAR_IMAGENS] @BT_IMAGEM_LOGO     VARBINARY(MAX) = NULL,
                                                    @BT_IMAGEM_RETRATO  VARBINARY(MAX) = NULL,
                                                    @BT_IMAGEM_PAIZAGEM VARBINARY(MAX) = NULL,
                                                    @BT_IMAGEM_PEQUENA  VARBINARY(MAX) = NULL,
                                                    @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      --ALTERAÇÃO DO LOGOTIPO DA EMPRESA
      IF( @BT_IMAGEM_LOGO IS NOT NULL )

            SET    BT_IMAGE_LOGO = @BT_IMAGEM_LOGO

              'LOGOTIPO DA EMPRESA',



      --ALTERAÇÃO DO CABEÇARIO RETRATO DO RELATÓRIO
      IF( @BT_IMAGEM_RETRATO IS NOT NULL )

            SET    BT_IMAGE_RELATORIO_RETRATO_LOGO = @BT_IMAGEM_RETRATO

              'RELATÓRIO RETRATO DA EMPRESA',



      --ALTERAÇÃO DO CABEÇARIO PAIZAGEM DO RELATÓRIO
      IF( @BT_IMAGEM_PAIZAGEM IS NOT NULL )

            SET    BT_IMAGE_RELATORIO_PAISAGEM_LOGO = @BT_IMAGEM_PAIZAGEM

              'RELATÓRIO PAIZAGEM DA EMPRESA',



      --ALTERAÇÃO DA IMAGEM PEQUENA
      IF( @BT_IMAGEM_PEQUENA IS NOT NULL )
        BEGIN
            UPDATE EMPRESA
            SET    BT_IMAGE_RELATORIO_PEQUENO = @BT_IMAGEM_PEQUENA
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'IMAGEM PEQUENA DA EMPRESA',
              'ALTERAR',
              NULL,
              NULL
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_LIMITE_FUNCIONARIO_CONSULTAR] @COD_APPS            NVARCHAR(MAX) = NULL,
                                                              @COD_FUNCIONARIO     NVARCHAR(MAX) = NULL,
                                                              @USUARIO             NVARCHAR(MAX) = NULL,
                                                              @COD_TIPO_AUTORIDADE NVARCHAR(MAX) = NULL,
                                                              @COD_MOEDA           NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '  
  SELECT


























FROM LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
LEFT JOIN GRUPO_RESPONSABILIDADE GR ON GR .ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
WHERE LIMITE_FUNCIONARIO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_APPS = ''' + @COD_APPS + ''''
      IF @COD_FUNCIONARIO IS NOT NULL
         AND @COD_FUNCIONARIO <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_FUNCIONARIO = ''' + @COD_FUNCIONARIO + ''''
      IF @COD_TIPO_AUTORIDADE IS NOT NULL
         AND @COD_TIPO_AUTORIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE = ''' + @COD_TIPO_AUTORIDADE + ''''
      IF @COD_MOEDA IS NOT NULL
         AND @COD_MOEDA <> ''
            SET @SQL=@SQL + ' AND LIMITE_FUNCIONARIO.COD_MOEDA = ''' + @COD_MOEDA + ''''
      IF @USUARIO IS NOT NULL
         AND @USUARIO <> ''
        BEGIN
            SET @SQL=@SQL + ' AND FUNCIONARIO.USUARIO = ''' + @USUARIO + ''''
        END
      SET @SQL=@SQL + '
  GROUP BY
LIMITE_FUNCIONARIO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,APPS.FL_CONTEMPLA_AUTORIDADES
,LIMITE_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO
,FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
,GR.GRUPO_RESPONSABILIDADE_NOME
,LIMITE_FUNCIONARIO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,TIPO_AUTORIDADE.COD_APPS
,LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO
,LIMITE_FUNCIONARIO.PLAFOUND
ORDER BY 
APPS.APPS_NOME
'
      EXEC(@SQL)
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_EMPRESA_CONSULTA]
AS
  BEGIN
      SELECT [ID_EMPRE],
             [DS_RAZAO_SOCIA],
             [NM_FANTA],
             [DS_ENDER],
             [NR_ENDER],
             [DS_ENDER_COMPL],
             [DS_BAIRR],
             [DS_ENDER_REFER],
             [DS_ENDER_CIDAD],
             [NR_DDI],
             [NR_DDD],
             [DS_TELEF],
             [DS_SITE],
             [DS_EMAIL],
             [DS_EMAIL_PRIVA],
             [DS_IP_WAN1],
             [DS_IP_WAN2],
             [EN_STATS],
             ISNULL([BT_IMAGE_LOGO], 0)                    [BT_IMAGE_LOGO],
             E.[FL_EXCLU],
             P.[ID_PAIS],
             ISNULL([BT_IMAGE_RELATORIO_RETRATO_LOGO], 0)  [BT_IMAGE_RELATORIO_RETRATO_LOGO],
             ISNULL([BT_IMAGE_RELATORIO_PAISAGEM_LOGO], 0) [BT_IMAGE_RELATORIO_PAISAGEM_LOGO],
             ISNULL([BT_IMAGE_RELATORIO_PEQUENO], 0)       [BT_IMAGE_RELATORIO_PEQUENO],
             DS_SMTP_SENHA,
             P.PAIS
      FROM   EMPRESA E
             INNER JOIN PAISES P
               ON E.ID_PAIS = P.ID_PAIS
      WHERE  E.FL_EXCLU = 0
      ORDER  BY E.[NM_FANTA] ASC
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_EMPRESA_CONSULTA_COUNT]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT ISNULL(COUNT(ID_EMPRE),0) FROM EMPRESA	WHERE FL_EXCLU=0
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_LOGS_INSERIR] @COD_LOG_UTILIZADOR INT,
                                          @MODULO             VARCHAR(80),
                                          @ACCAO              VARCHAR(20),
                                          @COD_MODULO_ACCAO   INT =NULL,
										  @IP_UTILIZADOR NVARCHAR(MAX) = NULL
AS
  BEGIN
      INSERT INTO [DBO].[LOGS]
                  ([COD_UTILIZADOR],
                   [DATA],
                   [MODULO],
                   [ACCAO],
                   [COD_MODULO_ACCAO],
                   [IP_ADRESS])
      VALUES      ( @COD_LOG_UTILIZADOR,
                    SYSDATETIME(),
                    @MODULO,
                    @ACCAO,
                    @COD_MODULO_ACCAO,
                    NULL 
					)
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_EMPRESA_CONSULTA_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_EMPRE INT
AS
  BEGIN
      -- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
      -- INTERFERING	WITH SELECT STATEMENTS.
      SET NOCOUNT ON;
      -- INSERT STATEMENTS FOR PROCEDURE HERE
      SELECT[ID_EMPRE],
            [DS_RAZAO_SOCIA],
            [NM_FANTA],
            [DS_ENDER],
            [NR_ENDER],
            [DS_ENDER_COMPL],
            [DS_BAIRR],
            [DS_ENDER_REFER],
            [DS_ENDER_CIDAD],
            [NR_DDI],
            [NR_DDD],
            [DS_TELEF],
            [DS_SITE],
            [DS_EMAIL],
            [DS_EMAIL_PRIVA],
            [DS_IP_WAN1],
            [DS_IP_WAN2],
            [EN_STATS],
            ISNULL([BT_IMAGE_LOGO], 0) [BT_IMAGE_LOGO],
            E.[FL_EXCLU],
            P.[ID_PAIS],
            [BT_IMAGE_RELATORIO_RETRATO_LOGO],
            [BT_IMAGE_RELATORIO_PAISAGEM_LOGO],
            [BT_IMAGE_RELATORIO_PEQUENO],
            DS_SMTP_SENHA,
            P.PAIS
      FROM   EMPRESA E
             INNER JOIN PAISES P
               ON E.ID_PAIS = P.ID_PAIS
      WHERE  E.FL_EXCLU = 0
             AND ID_EMPRE = @ID_EMPRE
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_EMPRESA_EXCLUIR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_EMPRE           INT,
                                             @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      UPDATE EMPRESA
      SET    FL_EXCLU = 1
      WHERE  ID_EMPRE = @ID_EMPRE
      EXEC PROC_LOGS_INSERIR
        @COD_LOG_UTILIZADOR,
        'EMPRESA',
        'EXCLUIR',
        @ID_EMPRE,
        NULL
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_EMPRESA_INSERIR]
	--@ID_EMPRE INT,
	@DS_RAZAO_SOCIA NVARCHAR(255)=NULL,
	@NM_FANTA NVARCHAR(255)=NULL,
	@DS_ENDER NVARCHAR(100)=NULL,
	@NR_ENDER INT ,
	@DS_ENDER_COMPL NVARCHAR(100)=NULL,
	@DS_BAIRR NVARCHAR(100)=NULL,
	@DS_ENDER_REFER NVARCHAR(100)=NULL,
	@DS_ENDER_CIDAD NVARCHAR(100)=NULL,
	@NR_DDI INT ,
	@NR_DDD INT ,
	@DS_TELEF NVARCHAR(20)=NULL,
	@DS_SITE NVARCHAR(255)=NULL,
	@DS_EMAIL NVARCHAR(100)=NULL,
	@DS_EMAIL_PRIVA NVARCHAR(100)=NULL,
	@DS_IP_WAN1 NVARCHAR(30)=NULL,
	@DS_IP_WAN2 NVARCHAR(30)=NULL,
	@EN_STATS SMALLINT=NULL,
	@BT_IMAGE_LOGO VARBINARY(MAX)=NULL,






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT ,
	@BT_IMAGE_RELATORIO_RETRATO_LOGO VARBINARY(MAX)=NULL,
	@BT_IMAGE_RELATORIO_PAISAGEM_LOGO VARBINARY(MAX)=NULL,
	@BT_IMAGE_RELATORIO_PEQUENO VARBINARY(MAX)=NULL,
	@DS_SMTP_SENHA VARCHAR(200) =NULL,
	@COD_LOG_UTILIZADOR INT
AS
BEGIN
	IF NOT EXISTS(SELECT *FROM EMPRESA	WHERE FL_EXCLU=0 AND NM_FANTA=@NM_FANTA AND DS_RAZAO_SOCIA=@DS_RAZAO_SOCIA
	AND DS_SITE=@DS_SITE AND DS_EMAIL=@DS_EMAIL)
			INSERT INTO [DBO].[EMPRESA]
        	( [DS_RAZAO_SOCIA]
    	,[NM_FANTA]
    	,[DS_ENDER]
    	,[NR_ENDER]
    	,[DS_ENDER_COMPL]
    	,[DS_BAIRR]
    	,[DS_ENDER_REFER]
    	,[DS_ENDER_CIDAD]
    	,[NR_DDI]
    	,[NR_DDD]
    	,[DS_TELEF]
    	,[DS_SITE]
    	,[DS_EMAIL]
    	,[DS_EMAIL_PRIVA]
    	,[DS_IP_WAN1]
    	,[DS_IP_WAN2]
    	,[EN_STATS]
    	,[BT_IMAGE_LOGO]
    	,[FL_EXCLU]
    	,[ID_PAIS]
    	,[BT_IMAGE_RELATORIO_RETRATO_LOGO]
    	,[BT_IMAGE_RELATORIO_PAISAGEM_LOGO]
    	,[BT_IMAGE_RELATORIO_PEQUENO]
        ,[DS_SMTP_SENHA])
     VALUES
         (@DS_RAZAO_SOCIA
    	,@NM_FANTA
    	,@DS_ENDER
    	,@NR_ENDER
    	,@DS_ENDER_COMPL
    	,@DS_BAIRR
    	,@DS_ENDER_REFER
    	,@DS_ENDER_CIDAD
    	,@NR_DDI
    	,@NR_DDD
    	,@DS_TELEF
    	,@DS_SITE
    	,@DS_EMAIL
    	,@DS_EMAIL_PRIVA
    	,@DS_IP_WAN1
    	,@DS_IP_WAN2
    	,@EN_STATS
    	,@BT_IMAGE_LOGO
    	,0
    	,@ID_PAIS
    	,@BT_IMAGE_RELATORIO_RETRATO_LOGO
    	,@BT_IMAGE_RELATORIO_PAISAGEM_LOGO
    	,@BT_IMAGE_RELATORIO_PEQUENO
		   ,@DS_SMTP_SENHA)
           DECLARE @IDENTITTY INT = (SELECT MAX(ID_EMPRE) FROM EMPRESA) 
		   EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'EMPRESA','INSERIR',@IDENTITTY,NULL
	ELSE
		BEGIN
			RAISERROR('ESTA EMPRESA JÁ EXISTE!',16,1)
		END
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_EMPRESA_INSERIR_ENTIDADES] 
	-- PAÍS
	@PAIS VARCHAR(20),
	-- UTILIZADOR_LOGS
	@COD_LOG_UTILIZADOR INT	= NULL
AS
BEGIN
	SET NOCOUNT ON;
	-- PROVÍNCIAS
	IF(@PAIS <> '')	BEGIN IF NOT EXISTS(SELECT * FROM PAISES	WHERE PAIS=@PAIS AND FL_EXCLU =0)
	BEGIN INSERT INTO [DBO].[PAISES] ([PAIS],	[FL_EXCLU])	VALUES(@PAIS,0) 
    DECLARE @IDENTITTY INT = (SELECT MAX(ID_PAIS) FROM PAISES) 
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PAÍS','INSERIR', @IDENTITTY, NULL 
	END  
	ELSE BEGIN RAISERROR('ESTE PAÍS JÁ EXISTE',16,1) 
	END	
	END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_MATRIZ_FUNCIONARIOS_PERCURSOS]	@GUIDE uniqueidentifier,












	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO_PERC VARCHAR(10) = NULL,













	@DT_ALT datetime2(7),	@ID          VARCHAR(10) = NULL,













	@DT_ALT datetime2(7),	@ID             VARCHAR(10) = NULL,






	@DT_ALT datetime2(7),	@ID                                                               @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID        VARCHAR(10) = NULL
AS
  BEGIN
  DECLARE @SQL VARCHAR(MAX) =''
SET @SQL = '
	  WITH EMP_CTE ( 
	           ID_FUNCIONARIO,
			   FUNCIONARIO_NOME,
			   NUMERO,
			   ID_FUNCAO,
			   FUNCAO_NOME,
			   CODIGO,
			   ID_UE,
			   UE_NOME,	
			   UE_DESCRICAO,
			   ID_APPS,
			   APPS_NOME,
			   DESCRICAO,
			   SIGLA,
			   ID_PERCURSOS,
			  PERCURSOS_NOME,
			   PERCURSOS_CODIGO	  
	   )
           AS (		   
		  SELECT  DISTINCT
		       FUNCIONARIO.ID_FUNCIONARIO,














               FROM FUNCIONARIO FUNCIONARIO                      
                      LEFT JOIN PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
                        ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO AND PERCURSOS_FUNCIONARIO.FL_EXCLU = 0 
						  LEFT JOIN PERCURSOS PERCURSOS
                        ON PERCURSOS_FUNCIONARIO.COD_PERCURSOS = PERCURSOS.ID_PERCURSOS AND PERCURSOS.FL_EXCLU = 0
                      LEFT JOIN APPS APPS
                        ON APPS.ID_APPS = PERCURSOS.COD_APPS AND APPS.FL_EXCLU = 0
					  LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO AND FUNCAO.FL_EXCLU = 0
					  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE	
               WHERE FUNCIONARIO.FL_EXCLU = 0 '
      IF @ID_FUNCIONARIO_PERC IS NOT NULL
         AND @ID_FUNCIONARIO_PERC <> ''
            SET @SQL=@SQL + ' AND ID_FUNCIONARIO = ''' + @ID_FUNCIONARIO_PERC + ''''           
      IF @ID_FUNCAO IS NOT NULL
         AND @ID_FUNCAO <> ''
            SET @SQL=@SQL + ' AND ID_FUNCAO=' + @ID_FUNCAO           
      IF @ID_APP IS NOT NULL
         AND @ID_APP <> ''
            SET @SQL=@SQL + ' AND ID_APPS=' + @ID_APP           
      IF @ID_PERCURSO IS NOT NULL
         AND @ID_PERCURSO <> ''
        BEGIN
            SET @SQL=@SQL + ' AND ID_PERCURSOS=' + @ID_PERCURSO           
        END
			  SET @SQL =@SQL + '
			  UNION ALL
			  SELECT  DISTINCT
			   FUNCIONARIO.ID_FUNCIONARIO,
			   FUNCIONARIO.FUNCIONARIO_NOME,
			   FUNCIONARIO.NUMERO,
			   FUNCAO.ID_FUNCAO,
			   FUNCAO.FUNCAO_NOME,
			   FUNCAO.CODIGO,
			   UE.ID_UE,
			   UE.UE_NOME,	
			   UE.DESCRICAO AS UE_DESCRICAO,
			   APPS.ID_APPS,
			   APPS.APPS_NOME,
			   APPS.DESCRICAO,
			   APPS.SIGLA,
			   PERCURSOS.ID_PERCURSOS,
			   PERCURSOS.PERCURSOS_NOME,
			   PERCURSOS.CODIGO AS PERCURSOS_CODIGO
               FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
                      LEFT JOIN FUNCAO FUNCAO
                        ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
                      INNER JOIN PERCURSOS PERCURSOS
                        ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
                      INNER JOIN FUNCIONARIO FUNCIONARIO
                        ON FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                      INNER JOIN APPS APPS
                        ON PERCURSOS.COD_APPS = APPS.ID_APPS
					  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE
               WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
                      AND PERCURSOS.FL_E
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_LIMITES_CONSULTAR] @COD_APPS             NVARCHAR(MAX) = NULL,
                                                   @APPS_NOME            NVARCHAR(MAX) = NULL,
                                                   @COD_FUNCIONARIO      NVARCHAR(MAX) = NULL,
                                                   @FUNCIONARIO_NOME     NVARCHAR(MAX) = NULL,
                                                   @COD_TIPO_AUTORIDADE  NVARCHAR(MAX) = NULL,
                                                   @TIPO_AUTORIDADE_NOME NVARCHAR(MAX) = NULL,
                                                   @COD_MOEDA            NVARCHAR(MAX) = NULL,
                                                   @MOEDA_NOME           NVARCHAR(MAX) = NULL,
                                                   @PLAFOUND             NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
WITH EMP_CTE ( 
APPS_NOME
,APPS_DESCRICAO
,APPS_SIGLA
,GRUPO_FUNCIONARIO_NOME
,GRUPO_FUNCIONARIO_DESCRICAO
,MOEDA_NOME
,MOEDA_SIGLA
,TIPO_AUTORIDADE_NOME
,TA_DESCRICAO
,PLAFOUND
)
AS (
APPS.APPS_NOME

,FUNCIONARIO.USUARIO
,FUNCIONARIO.FUNCIONARIO_NOME



,LIMITE_FUNCIONARIO.PLAFOUND
FROM LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
INNER JOIN APPS APPS ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
WHERE LIMITE_FUNCIONARIO.FL_EXCLU = 0
AND APPS.FL_EXCLU = 0
AND FUNCIONARIO.FL_EXCLU = 0
  '












            SET @SQL=@SQL + ' AND MOEDA_NOME = ''' + @MOEDA_NOME + ''''
      IF @PLAFOUND IS NOT NULL
         AND @PLAFOUND <> ''
            SET @SQL=@SQL + ' AND PLAFOUND LIKE ''%' + @PLAFOUND + '%'''
		SET @SQL=@SQL+'
UNION ALL
SELECT
 APPS.APPS_NOME
,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA AS MOEDA_SIGLA
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,LIMITE_GRUPO.PLAFOUND
FROM LIMITE_GRUPO LIMITE_GRUPO
INNER JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
 '
 IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
            SET @SQL=@SQL + ' AND APPS_NOME = ''' + @APPS_NOME + ''''
      IF @TIPO_AUTORIDADE_NOME IS NOT NULL
         AND @TIPO_AUTORIDADE_NOME <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE_NOME = ''' + @TIPO_AUTORIDADE_NOME + ''''
        END
      IF @MOEDA_NOME IS NOT NULL
         AND @MOEDA_NOME <> ''
        BEGIN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_MATRIZ_FUNCIONARIOS_LIMITES]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO NVARCHAR(MAX) = NULL
AS
  BEGIN
 WITH EMP_CTE ( 
COD_APPS
,ID_APPS
,APPS_NOME
,DESCRICAO
,SIGLA
,FL_CONTEMPLA_AUTORIDADES
,COD_FUNCIONARIO
,ID_FUNCIONARIO
,FUNCIONARIO_NOME
,COD_FUNCAO
,NUMERO
,COD_BALCAO
,USUARIO
,COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE_NOME
,COD_MOEDA
,ID_MOEDA
,MOEDA_NOME
,MD_SIGLA
,COD_TIPO_AUTORIDADE
,ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE_NOME
,PA_DESCRICAO
,COD_SITUACAO
,ID_LIMITE_FUNCIONARIO
,PLAFOUND
	   )
           AS (		   
		   SELECT  DISTINCT





,LIMITE_FUNCIONARIO.COD_FUNCIONARIO
















,LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO
FROM LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO

LEFT JOIN GRUPO_RESPONSABILIDADE GR ON GR .ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE


  AND ID_FUNCIONARIO = @ID_FUNCIONARIO
 UNION ALL
 SELECT 
LIMITE_FUNCIONARIO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,APPS.FL_CONTEMPLA_AUTORIDADES
,LIMITE_FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO
,FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
,GR.GRUPO_RESPONSABILIDADE_NOME
,LIMITE_FUNCIONARIO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,LIMITE_FUNCIONARIO.ID_LIMITE_GRUPO
,LIMITE_FUNCIONARIO.PLAFOUND
FROM  LIMITE_GRUPO LIMITE_FUNCIONARIO
INNER JOIN GRUPO_RESPONSABILIDADE GR ON GR .ID_GRUPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE = LIMITE_FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
WHERE LIMITE_FUNCIONARIO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
 AND ID_FUNCIONARIO = @ID_FUNCIONARIO
 )
    SELECT * FROM  EMP_CTE
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:    <AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:  <DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_ESTADOS_CONSULTA]
AS
  BEGIN
      SET NOCOUNT ON;
      SELECT *
      FROM   ESTADO
      WHERE  FL_EXCLU = 0
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_LIMITE_GRUPO_CONSULTAR] @COD_APPS                   NVARCHAR(MAX) = NULL,
                                                        @COD_GRUPO_RESPONSABILIDADE NVARCHAR(MAX) = NULL,
                                                        @COD_TIPO_AUTORIDADE        NVARCHAR(MAX) = NULL,
                                                        @COD_MOEDA                  NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
  SELECT





















FROM LIMITE_GRUPO LIMITE_GRUPO
LEFT JOIN APPS APPS ON APPS.ID_APPS = LIMITE_GRUPO.COD_APPS
LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
LEFT JOIN MOEDA MOEDA ON MOEDA.ID_MOEDA = LIMITE_GRUPO.COD_MOEDA
LEFT JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_GRUPO.COD_TIPO_AUTORIDADE
WHERE LIMITE_GRUPO.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND TIPO_AUTORIDADE.FL_EXCLU = 0
 AND GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_APPS = ''' + @COD_APPS + ''''
      IF @COD_GRUPO_RESPONSABILIDADE IS NOT NULL
         AND @COD_GRUPO_RESPONSABILIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE = ''' + @COD_GRUPO_RESPONSABILIDADE + ''''
      IF @COD_TIPO_AUTORIDADE IS NOT NULL
         AND @COD_TIPO_AUTORIDADE <> ''
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_TIPO_AUTORIDADE = ''' + @COD_TIPO_AUTORIDADE + ''''
      IF @COD_MOEDA IS NOT NULL
         AND @COD_MOEDA <> ''
        BEGIN
            SET @SQL=@SQL + ' AND LIMITE_GRUPO.COD_MOEDA = ''' + @COD_MOEDA + ''''
        END
      SET @SQL=@SQL + '
  GROUP BY
LIMITE_GRUPO.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,APPS.FL_CONTEMPLA_AUTORIDADES
,LIMITE_GRUPO.COD_GRUPO_RESPONSABILIDADE
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.DESCRICAO
,LIMITE_GRUPO.COD_MOEDA
,MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
,LIMITE_GRUPO.COD_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.COD_SITUACAO
,TIPO_AUTORIDADE.COD_APPS
,LIMITE_GRUPO.ID_LIMITE_GRUPO
,LIMITE_GRUPO.PLAFOUND
'
      EXEC(@SQL)
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_ALTERAR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCAO          INT,
                                            @FUNCAO_NOME        NVARCHAR(MAX),
                                            @CODIGO             NVARCHAR(50)=NULL,
                                            @COD_UE             NVARCHAR(50)=NULL,
                                            @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      UPDATE FUNCAO
      SET    [FUNCAO_NOME] = @FUNCAO_NOME,
             [CODIGO] = @CODIGO,
             [COD_UE] = @COD_UE
      WHERE  ID_FUNCAO = @ID_FUNCAO
    EXEC PROC_LOGS_INSERIR
      @COD_LOG_UTILIZADOR,
      'FUNCAO',
      'ALTERAR',
      @ID_FUNCAO,
      NULL 
  END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_LIMITE_FUNCIONARIO_CONSULTAR_1]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO NVARCHAR(MAX) = NULL
AS
  BEGIN
      WITH EMP_CTE ( COD_APPS, ID_APPS, APPS_NOME, DESCRICAO, SIGLA, FL_CONTEMPLA_AUTORIDADES, COD_FUNCIONARIO, ID_FUNCIONARIO, FUNCIONARIO_NOME, COD_FUNCAO, NUMERO, COD_BALCAO, USUARIO, COD_GRUPO_RESPONSABILIDADE, GRUPO_RESPONSABILIDADE_NOME, COD_MOEDA, ID_MOEDA, MOEDA_NOME, MD_SIGLA, COD_TIPO_AUTORIDADE, ID_TIPO_AUTORIDADE, TIPO_AUTORIDADE_NOME, PA_DESCRICAO, COD_SITUACAO, ID_LIMITE_FUNCIONARIO, PLAFOUND )
           AS (SELECT DISTINCT LIMITE_FUNCIONARIO.COD_APPS,
                               APPS.ID_APPS,
                               APPS.APPS_NOME,
                               APPS.DESCRICAO,
                               APPS.SIGLA,
                               APPS.FL_CONTEMPLA_AUTORIDADES,
                               LIMITE_FUNCIONARIO.COD_FUNCIONARIO,
                               FUNCIONARIO.ID_FUNCIONARIO,
                               FUNCIONARIO.FUNCIONARIO_NOME,
                               FUNCIONARIO.COD_FUNCAO,
                               FUNCIONARIO.NUMERO,
                               FUNCIONARIO.COD_BALCAO,
                               FUNCIONARIO.USUARIO,
                               FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
                               GR.GRUPO_RESPONSABILIDADE_NOME,
                               LIMITE_FUNCIONARIO.COD_MOEDA,
                               MOEDA.ID_MOEDA,
                               MOEDA.MOEDA_NOME,
                               MOEDA.SIGLA,
                               LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE,
                               TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE,
                               TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME,
                               TIPO_AUTORIDADE.DESCRICAO,
                               TIPO_AUTORIDADE.COD_SITUACAO,
                               LIMITE_FUNCIONARIO.ID_LIMITE_FUNCIONARIO,
                               LIMITE_FUNCIONARIO.PLAFOUND
               FROM   LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
                      LEFT JOIN APPS APPS
                        ON APPS.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
                      LEFT JOIN FUNCIONARIO FUNCIONARIO
                        ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
                      LEFT JOIN MOEDA MOEDA
                        ON MOEDA.ID_MOEDA = LIMITE_FUNCIONARIO.COD_MOEDA
                      INNER JOIN TIPO_AUTORIDADE TIPO_AUTORIDADE
                        ON TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE = LIMITE_FUNCIONARIO.COD_TIPO_AUTORIDADE
                      LEFT JOIN GRUPO_RESPONSABILIDADE GR
                        ON GR .ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
               WHERE  LIMITE_FUNCIONARIO.FL_EXCLU = 0
                      AND APPS.FL_EXCLU = 0
                      AND FUNCIONARIO.FL_EXCLU = 0
					  AND ID_FUNCIONARIO = @ID_FUNCIONARIO
               UNION ALL
               SELECT 
                      LIMITE_FUNCIONARIO.COD_APPS,
                      APPS.ID_APPS,
                      APPS.APPS_NOME,
                      APPS.DESCRICAO,
                      APPS.SIGLA,
                      APPS.FL_CONTEMPLA_AUTORIDADES,
                      LIMITE_FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
                      FUNCIONARIO.ID_FUNCIONARIO,
                      FUNCIONARIO.FUNCIONARIO_NOME,
                      FUNCIONARIO.COD_FUNCAO,
                      FUNCIONARIO.NUMERO,
                      FUNCIONARIO.COD_BALCAO,
                      FUNCIONARIO.USUARIO,
                      FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
                      GR.GRUPO_RESPONSABILIDADE_NOME,
                      LIMITE_FUNCIONARIO.COD_MOEDA,
                      MOEDA.ID_MOEDA,
                      MOEDA.MOEDA_NOME,
                      MOEDA.SIGLA,
                      LIMITE_FUNCION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APP_CONSULTAR_ID_FUNCIONARIO]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO INT
AS
BEGIN  
WITH EMP_CTE ( 
ID_APPS,
APPS_NOME, 
SIGLA,
DESCRICAO
)
AS (




FROM   FUNCAO_PERCURSOS FPP
INNER JOIN PERCURSOS P
ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
INNER JOIN APPS A
ON A.ID_APPS = P.COD_APPS
INNER JOIN FUNCIONARIO F ON F.COD_FUNCAO = FPP.COD_FUNCAO
WHERE  FPP.FL_EXCLU = 0
AND P.FL_EXCLU = 0
AND F.ID_FUNCIONARIO =  @ID_FUNCIONARIO
UNION ALL
SELECT DISTINCT 
A.ID_APPS, 
A.APPS_NOME, 
A.SIGLA,
A.DESCRICAO
FROM   LIMITE_FUNCIONARIO LIMITE_FUNCIONARIO
LEFT JOIN APPS A
ON A.ID_APPS = LIMITE_FUNCIONARIO.COD_APPS
LEFT JOIN FUNCIONARIO FUNCIONARIO
ON FUNCIONARIO.ID_FUNCIONARIO = LIMITE_FUNCIONARIO.COD_FUNCIONARIO
WHERE  LIMITE_FUNCIONARIO.FL_EXCLU = 0
AND A.FL_EXCLU = 0
AND FUNCIONARIO.FL_EXCLU = 0
AND LIMITE_FUNCIONARIO.COD_FUNCIONARIO =  @ID_FUNCIONARIO
)   
SELECT 	DISTINCT  
ID_APPS,APPS_NOME, SIGLA,DESCRICAO
FROM   EMP_CTE
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_CONSULTA_POR_PROFUNDIDADE] @PROFUNDIDADE      NVARCHAR(100) = NULL,
                                                                  @ID_NIVEL_ITEM_PAI NVARCHAR(100) = NULL
AS
  BEGIN
      IF( @ID_NIVEL_ITEM_PAI <> '0' )












                   AND ID_NIVEL_ITEM_PAI = @ID_NIVEL_ITEM_PAI
      ELSE
        BEGIN
            SELECT DISTINCT [ID_NIVEL_ITEM],
                            [NM_NIVEL_ITEM],
                            [DS_NIVEL_ITEM],
                            [DS_PESQUISA],
                            ISNULL([ORDEM], 0)             ORDEM,
                            ISNULL([ID_NIVEL_ITEM_PAI], 0) ID_NIVEL_ITEM_PAI,
                            [FL_EXCLU],
                            [DS_SUB_ITENS],
                            ISNULL([PROFUNDIDADE], 0)      PROFUNDIDADE
            FROM   [MENUS]
            WHERE  FL_EXCLU = 0
                   AND PROFUNDIDADE = @PROFUNDIDADE
        END
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_FUNCIONARIO_PERCURSOS_CONSULTAR]	@GUIDE uniqueidentifier,












	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO NVARCHAR(MAX) = NULL,













	@DT_ALT datetime2(7),	@ID     NVARCHAR(MAX) = NULL,






	@DT_ALT datetime2(7),	@ID                                                                 @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID        NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
	    WITH EMP_CTE ( 
		       ID_FUNCIONARIO,
			   FUNCIONARIO_NOME,
			   ID_FUNCAO,
			   FUNCAO_NOME,
			   CODIGO,
			   ID_UE,
			   UE_NOME,	
			   UE_DESCRICAO,
			   ID_APPS,
			   APPS_NOME,
			   DESCRICAO,
			   SIGLA,
			   ID_PERCURSOS,
			   PERCURSOS_NOME,
			   PERCURSOS_CODIGO
		)
           AS (
		 SELECT  DISTINCT
		       FUNCIONARIO.ID_FUNCIONARIO,




			   UE.UE_NOME,






			   PERCURSOS.CODIGO AS PERCURSOS_CODIGO 
               FROM   PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
                        ON PERCURSOS_FUNCIONARIO.COD_PERCURSOS = PERCURSOS.ID_PERCURSOS
                        ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
                        ON APPS.ID_APPS = PERCURSOS.COD_APPS
					  LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO AND FUNCAO.FL_EXCLU = 0
					  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE					 
               WHERE  PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
                      AND APPS.FL_EXCLU = 0
                      AND FUNCIONARIO.FL_EXCLU = 0
					  					   '




      IF @ID_FUNCIONARIO IS NOT NULL
         AND @ID_FUNCIONARIO <> ''
            SET @SQL=@SQL + ' AND ID_FUNCIONARIO = ''' + @ID_FUNCIONARIO + ''''
      IF @ID_APP IS NOT NULL
         AND @ID_APP <> ''
            SET @SQL=@SQL + ' AND ID_APPS = ''' + @ID_APP + ''''
      SET @SQL=@SQL + '
               UNION ALL
			   SELECT  DISTINCT
			   FUNCIONARIO.ID_FUNCIONARIO,
			   FUNCIONARIO.FUNCIONARIO_NOME,
			   FUNCAO.ID_FUNCAO,
			   FUNCAO.FUNCAO_NOME,
			   FUNCAO.CODIGO,
			   UE.ID_UE,
			   UE.UE_NOME,	
			   UE.DESCRICAO AS UE_DESCRICAO,
			   APPS.ID_APPS,
			   APPS.APPS_NOME,
			   APPS.DESCRICAO,
			   APPS.SIGLA,
			   PERCURSOS.ID_PERCURSOS,
			   PERCURSOS.PERCURSOS_NOME,
			   PERCURSOS.CODIGO AS PERCURSOS_CODIGO
               FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
                      LEFT JOIN FUNCAO FUNCAO
                        ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
                      INNER JOIN PERCURSOS PERCURSOS
                        ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
                      INNER JOIN FUNCIONARIO FUNCIONARIO
                        ON FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                      INNER JOIN APPS APPS
                        ON PERCURSOS.COD_APPS = APPS.ID_APPS
					  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE
               WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
                      AND PERCURSOS.FL_EXCLU = 0
                      AND FUNCAO.FL_EXCLU = 0
					   '
      IF @ID_FUNCAO IS NOT NULL
         AND @ID_FUNCAO <> ''
        BEGIN
            SET @SQL=@SQL + ' AND ID_FUNCAO = ''' + @ID_FUNCAO + ''''
        END
      IF @ID_FUNCIONARIO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MENUS_ALTERAR]
	@NM_NIVEL_ITEM NVARCHAR(550),
	@NOVO_NIVEL_ITEM NVARCHAR(550),
	@COD_LOG_UTILIZADOR INT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE MENUS SET NM_NIVEL_ITEM=@NOVO_NIVEL_ITEM	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'MENUS','ALTERAR',NULL,NULL
	DECLARE @COUNTER INT = 0
	DECLARE @TOTAL INT = (SELECT COUNT(*) FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS])
	DECLARE @ID_NI INT 	 
	WHILE (@COUNTER <> (@TOTAL))
	BEGIN 	  
	   SET @ID_NI = (SELECT ID_NIVEL_ITEM FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS] ORDER BY ID_NIVEL_ITEM OFFSET @COUNTER ROWS FETCH NEXT 1 ROWS ONLY)
	   DECLARE @NM_NI NVARCHAR(1000) = (SELECT NM_NIVEL_ITEM FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM = @ID_NI)
       DECLARE @DS_PSQUISA NVARCHAR(1000) = (SELECT DS_PESQUISA FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM = @ID_NI)
	   DECLARE @PRODUNDIDADE INT = (SELECT LEN(@DS_PSQUISA) - LEN(REPLACE(@DS_PSQUISA, '>', '')))
     	IF(@COUNTER = 0) BEGIN UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS]  SET NM_NIVEL_ITEM= 'MENU_RAIZ', DS_NIVEL_ITEM =  'MENU_RAIZ',DS_PESQUISA =  'MENU_RAIZ',ID_NIVEL_ITEM_PAI = NULL	WHERE ID_NIVEL_ITEM = @ID_NI END
	   DECLARE @ID_NI_PAI INT = (SELECT ID_NIVEL_ITEM_PAI FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM = @ID_NI)
	   DECLARE @NM_NI_PAI  NVARCHAR(1000) = (SELECT NM_NIVEL_ITEM FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM = @ID_NI_PAI)
	   DECLARE @DS_PSQUISA_PAI NVARCHAR(1000) = (SELECT DS_PESQUISA FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM = @ID_NI_PAI)
	 	IF(@DS_PSQUISA_PAI IS NOT NULL)
	      -- ACTUALIZAR A COLUNA DS PESQUISA
		  UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS] SET DS_PESQUISA = CONCAT (@DS_PSQUISA_PAI, ' > ' , @NM_NI )	WHERE ID_NIVEL_ITEM = @ID_NI
	   END  
	 	IF(@COUNTER <> 0)
	   BEGIN
	      -- ACTUALIZAR A COLUNA DS NIVEL ITEM
	      UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS] SET DS_NIVEL_ITEM = @NM_NI_PAI	WHERE ID_NIVEL_ITEM = @ID_NI	      
	   END
	   DECLARE @COUNT_DS_SUB_ITENS INT = (SELECT COUNT(*) FROM [GESTAO_DE_FORMACAO].[DBO].[MENUS]	WHERE ID_NIVEL_ITEM_PAI = @ID_NI AND FL_EXCLU = 0)
         -- ACTUALIZAR A COLUNA DS SUB ITENS
	UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS] SET DS_SUB_ITENS =  @COUNT_DS_SUB_ITENS	WHERE ID_NIVEL_ITEM = @ID_NI	     
	     -- ACTUALIZAR A COLUNA PROFUNDIDADE
	UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS] SET PROFUNDIDADE = @PRODUNDIDADE	WHERE ID_NIVEL_ITEM = @ID_NI
	     -- ACTUALIZAR A COLUNA DS MENU 
	UPDATE [GESTAO_DE_FORMACAO].[DBO].[MENUS] SET DS_MENU_LINK = (SELECT REPLACE(@NM_NI,' ','_')) 	WHERE ID_NIVEL_ITEM = @ID_NI
	  DECLARE @DS_MENU_LINK NVARCHAR(MAX) = (SELECT DS_MENU_LINK FROM MENUS	WHERE ID_NIVEL_ITEM = @ID_NI)
	  SET @DS_MENU_LINK = UPPER(@DS_MENU_LINK)	  
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'À', 'A')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Á', 'A')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ã', 'A')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Â', 'A')	  
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'È', 'E')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'É', 'E')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ê', 'E')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ì', 'I')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Í', 'I')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Î', 'I')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ò', 'O')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ó', 'O')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Õ', 'O')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ô', 'O')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ù', 'U')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'Ç', 'C')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'''', '')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'`', '')
	  SET @DS_MENU_LINK =  REPLACE(@DS_MENU_LINK,'-', '')
	  UPDATE MENUS SET DS_MENU_LIN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_ALTERAR]
@ID_FUNCAO_APPS INT,
@COD_FUNCAO INT = NULL,
@COD_APPS INT = NULL
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCAO_APPS
SET
[COD_FUNCAO] = @COD_FUNCAO,
[COD_APPS] = @COD_APPS
WHERE ID_FUNCAO_APPS = @ID_FUNCAO_APPS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCAO APPS','ALTERAR',@ID_FUNCAO_APPS ,NULL


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_FUNCIONARIO_CONSULTAR] @FUNCIONARIO_NOME NVARCHAR(MAX) = NULL,
                                                       @COD_FUNCAO      NVARCHAR(MAX) = NULL,
                                                       @COD_UE     NVARCHAR(MAX) = NULL,
                                                       @COD_BALCAO           NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '    SELECT  FUNCIONARIO.ID_FUNCIONARIO,  FUNCIONARIO.FUNCIONARIO_NOME,  
 BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
             BALCAO.DESCRICAO                    AS B_DESCRICAO,
FUNCIONARIO.NUMERO,FUNCIONARIO.COD_FUNCAO,  FUNCAO.FUNCAO_NOME + '' - '' +   FUNCAO.CODIGO AS FUNCAO_NOME,  FUNCAO.CODIGO,  UE.DESCRICAO AS UE_DESCRICAO,  UE.UE_NOME
FROM FUNCIONARIO FUNCIONARIO  LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO AND FUNCAO.FL_EXCLU = 0  LEFT JOIN UE ON UE.ID_UE = FUNCAO.COD_UE AND UE.FL_EXCLU = 0 
 LEFT JOIN BALCAO BALCAO ON BALCAO.ID_BALCAO=FUNCIONARIO.COD_BALCAO
WHERE FUNCIONARIO.FL_EXCLU = 0  '
      IF @FUNCIONARIO_NOME IS NOT NULL
         AND @FUNCIONARIO_NOME <> ''
            SET @SQL=@SQL + ' AND FUNCIONARIO.FUNCIONARIO_NOME LIKE ''%' + @FUNCIONARIO_NOME + '%'''
      IF @COD_FUNCAO IS NOT NULL
         AND @COD_FUNCAO <> ''
            SET @SQL=@SQL + ' AND FUNCAO.ID_FUNCAO = ''' + @COD_FUNCAO + ''''
      IF @COD_UE IS NOT NULL
         AND @COD_UE <> ''
            SET @SQL=@SQL + ' AND UE.ID_UE = ''' + @COD_UE + ''' '
      IF @COD_BALCAO IS NOT NULL
         AND @COD_BALCAO <> ''
        BEGIN
            SET @SQL=@SQL + ' AND BALCAO.ID_BALCAO = ''' + @COD_BALCAO + ''''
        END
      SET @SQL=@SQL + 'GROUP BY FUNCIONARIO.ID_FUNCIONARIO,BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO, BALCAO.DESCRICAO, FUNCIONARIO.FUNCIONARIO_NOME, FUNCIONARIO.NUMERO,FUNCIONARIO.COD_FUNCAO, FUNCAO.FUNCAO_NOME, FUNCAO.CODIGO, UE.DESCRICAO, UE.UE_NOME 
			 ORDER BY FUNCIONARIO.FUNCIONARIO_NOME '
      EXEC(@SQL)
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_MENUS_CONSULTA]
AS
BEGIN
	SET NOCOUNT ON;
 SELECT 
	 [ID_NIVEL_ITEM]
    ,[NM_NIVEL_ITEM]
    ,[DS_NIVEL_ITEM]
    ,[DS_PESQUISA]
    ,ISNULL([ID_NIVEL_ITEM_PAI],0) ID_NIVEL_ITEM_PAI
    ,[DS_SUB_ITENS]
    ,ISNULL([PROFUNDIDADE],0) PROFUNDIDADE
	,DS_MENU_LINK
	,IM.BT_ARQUIVO
	FROM [DBO].[MENUS] M
  LEFT OUTER JOIN	IMAGEM_MENU_RELACIONAMENTO IR ON COD_MENU = ID_NIVEL_ITEM
  LEFT OUTER JOIN	IMAGEM_MENU IM ON IM.ID_ARQUIVO = IR.COD_IMAGEM
 	WHERE M.FL_EXCLU=0 
	ORDER BY CASE NM_NIVEL_ITEM 
  	WHEN 'PÁGINA INICIAL' THEN 1
  	WHEN 'MEU CADASTRO' THEN 2
  	WHEN 'PARÂMETROS' THEN 3
  	WHEN 'MODELO DE EMAIL' THEN 3.0
  	WHEN 'EMPRESA' THEN 3.1
  	WHEN 'LOGS' THEN 3.2
  	WHEN 'GRUPOS' THEN 3.3
  	WHEN 'UTILIZADORES' THEN 3.4
  	WHEN 'CADASTROS' THEN 4
  	WHEN 'PAÍSES' THEN 4.1
  	WHEN 'PROVÍNCIAS' THEN 4.2
  	WHEN 'HIERARQUIA' THEN 4.3
  	WHEN 'INSTITUIÇÃO' THEN 4.4
  	WHEN 'CURSO' THEN 4.5
  	WHEN 'TIPO DE CURSO' THEN 4.6
  	WHEN 'REQUISITOS' THEN 4.7
  	WHEN 'GESTÃO DE CURSOS' THEN 4.8
  	WHEN 'FORMAÇÃO PROFISSIONAL' THEN 4.9
  	WHEN 'NÍVEL ACADÉMICO' THEN 5
  	WHEN 'GESTÃO DE SALAS' THEN 5.1
  	WHEN 'TIPO DE SALA' THEN 5.2
  	WHEN 'RECURSOS' THEN 5.3
  	WHEN 'CADASTRO DE SALAS' THEN 5.4
  	WHEN 'PLANIFICAÇÃO DE SALAS' THEN 5.5
  	WHEN 'FORMADOR' THEN 6
  	WHEN 'FORMAÇÃO' THEN 7
  	WHEN 'PACOTE DE FORMAÇÃO' THEN 7.1
  	WHEN 'GESTÃO DE FORMAÇÃO' THEN 7.2
  	WHEN 'FORMANDO' THEN 8
  	WHEN 'FICHA DE INSCRIÇÃO' THEN 9   
  	WHEN 'PROJECTOS' THEN 10
  	WHEN 'RELATÓRIOS' THEN 11
   ELSE 9 END                  
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_FUNCAO_APPS)  FROM FUNCAO_APPS WHERE FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@SIGLA NVARCHAR(3) = NULL,
@SITUACAO_NOME NVARCHAR(20) = NULL
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM SITUACAO WHERE 
FL_EXCLU = 0 AND
SIGLA = @SIGLA AND
SITUACAO_NOME = @SITUACAO_NOME
AND ID_SITUACAO <> @ID_SITUACAO
)
UPDATE SITUACAO
SET
[SIGLA] = @SIGLA,
[SITUACAO_NOME] = @SITUACAO_NOME
WHERE ID_SITUACAO = @ID_SITUACAO
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'SITUACAO','ALTERAR',@ID_SITUACAO ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE SITUACAO COM ESTES DADOS!',16,1)
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_FUNCAO_CONSULTAR] @FUNCAO_NOME NVARCHAR(MAX) = NULL,
                                                  @CODIGO      NVARCHAR(MAX) = NULL,
                                                  @COD_UE     NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
	  SELECT
  FUNCAO.ID_FUNCAO,
  FUNCAO.FUNCAO_NOME,
  FUNCAO.CODIGO,
  FUNCAO.COD_UE,
  UE.UE_NOME  + '' - '' + UE.DESCRICAO AS UE_NOME,
  UE.DESCRICAO
  FROM FUNCAO FUNCAO
  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE
  WHERE FUNCAO.FL_EXCLU = 0
  AND FUNCAO.FUNCAO_NOME IS NOT NULL
  AND FUNCAO.FUNCAO_NOME <> ''''
  '
      --EXEC @SQL
      IF @FUNCAO_NOME IS NOT NULL
         AND @FUNCAO_NOME <> ''
            SET @SQL=@SQL + ' AND FUNCAO.FUNCAO_NOME LIKE ''%' + @FUNCAO_NOME + '%'''
      IF @CODIGO IS NOT NULL
         AND @CODIGO <> ''
            SET @SQL=@SQL + ' AND FUNCAO.CODIGO LIKE ''%' + @CODIGO + '%'''
      IF @COD_UE IS NOT NULL
         AND @COD_UE <> ''
        BEGIN
            SET @SQL=@SQL + ' AND UE.ID_UE = ''' + @COD_UE + ''''
        END
      SET @SQL=@SQL + 'GROUP BY
 FUNCAO.ID_FUNCAO,
 FUNCAO.FUNCAO_NOME,
 FUNCAO.CODIGO,
 FUNCAO.COD_UE,
 UE.UE_NOME,
 UE.DESCRICAO
'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MENUS_CONSULTA_GRUPO]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_UTILIZADOR      INT= NULL,
                                                  @PARAM_PACOTE_CURSO NVARCHAR(2) = NULL
AS
  BEGIN
      DECLARE @COD_GRUPO INT = (SELECT COD_GRUPO FROM UTILIZADORES WHERE
  ID_UTILIZADOR=@ID_UTILIZADOR AND FL_EXCLU=0)
      IF EXISTS(SELECT *
                FROM   [UTILIZADORES]
                WHERE  ID_UTILIZADOR = @ID_UTILIZADOR
                       AND FL_ADMIN_PLATA = 1)

























                        WHEN 'PAÍSES' THEN 4.1
                        WHEN 'PROVÍNCIAS' THEN 4.2
						 WHEN 'APPS' THEN 5
						 WHEN 'PERCURSO' THEN 6
						 WHEN 'GRUPO DE RESPONSABILIDADE' THEN 6.1
						 WHEN 'BALCÃO' THEN 7
						 WHEN 'FUNÇÃO' THEN 8
						 WHEN 'CENTRO DE CUSTOS' THEN 8.1
						 WHEN 'GESTÃO DE FUNÇÕES' THEN 8.2
						 WHEN 'FUNCIONÁRIO' THEN 9
                        WHEN 'IMPORTAR DADOS' THEN 10
                        WHEN 'PERCURSOS' THEN 10.1
                        WHEN 'CENTRO DE CUSTO' THEN 10.2
                        WHEN 'FUNÇÕES' THEN 10.3
                        WHEN 'RELATÓRIOS' THEN 11
                        ELSE 12
                      END
        END
      ELSE IF ( @COD_GRUPO IS NOT NULL
           AND @COD_GRUPO <> 0 )
        BEGIN
            SELECT [ID_NIVEL_ITEM],
                   [NM_NIVEL_ITEM],
                   [DS_NIVEL_ITEM],
                   ISNULL([DS_PESQUISA], 0)       DS_PESQUISA,
                   ISNULL([ID_NIVEL_ITEM_PAI], 0) ID_NIVEL_ITEM_PAI,
                   [DS_SUB_ITENS],
                   ISNULL([PROFUNDIDADE], 0)      PROFUNDIDADE,
                   DS_MENU_LINK,
                   IM.BT_ARQUIVO
            FROM   [DBO].[MENUS] M
                   LEFT OUTER JOIN IMAGEM_MENU_RELACIONAMENTO IR
                     ON COD_MENU = ID_NIVEL_ITEM
                   LEFT OUTER JOIN IMAGEM_MENU IM
                     ON IM.ID_ARQUIVO = IR.COD_IMAGEM
                   INNER JOIN GRUPOS_MENUS_REL R
                     ON R.COD_MENU = M.ID_NIVEL_ITEM
            WHERE  M.FL_EXCLU = 0
                   AND R.COD_GRUPO = @COD_GRUPO
                   AND R.FL_EXCLU = 0
            ORDER  BY CASE NM_NIVEL_ITEM
                        WHEN 'PÁGINA INICIAL' THEN 1
                        WHEN 'MEU CADASTRO' THEN 2
                        WHEN 'PARÂMETROS' THEN 3
                        WHEN 'MODELO DE EMAIL' THEN 3.0
                        WHEN 'EMPRESA' THEN 3.1
                        WHEN 'PERCURSOS' THEN 3.2
                        WHEN 'GRUPOS' THEN 3.3
                        WHEN 'UTILIZADORES' THEN 3.4
                        WHEN 'CADASTROS' THEN 4
                  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_CONSULTAR_ID]
@ID_FUNCAO_APPS INT
AS
SET NOCOUNT ON;
BEGIN
SELECT
FUNCAO_APPS.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,FUNCAO_APPS.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
,FUNCAO_APPS.ID_FUNCAO_APPS
FROM FUNCAO_APPS FUNCAO_APPS
LEFT JOIN APPS APPS ON APPS.ID_APPS = FUNCAO_APPS.COD_APPS
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCAO_APPS.COD_FUNCAO
WHERE FUNCAO_APPS.FL_EXCLU=0
AND
[ID_FUNCAO_APPS] = @ID_FUNCAO_APPS
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_SITUACAO)  FROM SITUACAO WHERE FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_FUNCAO_APPS_CONSULTAR] @FUNCAO_NOME                    NVARCHAR(MAX) = NULL,
                                                        @APPS_NOME                      NVARCHAR(MAX) = NULL
AS
  BEGIN
      SET NOCOUNT ON;
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
	  SELECT
  FP.ID_FUNCAO_PERCURSOS,



  FROM FUNCAO_PERCURSOS FP
  LEFT JOIN FUNCAO F ON F.ID_FUNCAO = FP.COD_FUNCAO
  LEFT JOIN PERCURSOS P ON P.ID_PERCURSOS = FP.COD_PERCURSOS 
  LEFT JOIN APPS A ON A.ID_APPS = P.COD_APPS
  WHERE FP.FL_EXCLU = 0
  '
      IF @FUNCAO_NOME IS NOT NULL
         AND @FUNCAO_NOME <> ''
            SET @SQL=@SQL + ' AND F.FUNCAO_NOME LIKE ''%' + @FUNCAO_NOME + '%'''
      IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
        BEGIN
            SET @SQL=@SQL + ' AND A.APPS_NOME LIKE ''%' + @APPS_NOME + '%'''
        END
      SET @SQL=@SQL + 'GROUP BY
 FP.ID_FUNCAO_PERCURSOS,
  FP.COD_FUNCAO,
  F.FUNCAO_NOME,
  P.COD_APPS,
  A.APPS_NOME
'
      EXEC(@SQL)
  END
    SET ANSI_NULLS ON 


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_MENUS_EXCLUIR]
	@NM_NIVEL_ITEM NVARCHAR(550),
	@COD_LOG_UTILIZADOR INT
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	UPDATE MENUS SET FL_EXCLU=1
	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'MENUS','EXCLUIR',NULL
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_CONSULTAR_ID_FUNCAO]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
  BEGIN
      SELECT
P.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,FP.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
FROM FUNCAO_PERCURSOS FP
INNER JOIN PERCURSOS P ON P.ID_PERCURSOS = FP.COD_PERCURSOS 
LEFT JOIN APPS APPS ON APPS.ID_APPS = P.COD_APPS
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FP.COD_FUNCAO
WHERE FP.FL_EXCLU=0
AND P.FL_EXCLU=0
AND APPS.FL_EXCLU=0
AND FUNCAO.FL_EXCLU=0
AND FP.COD_FUNCAO= @ID_FUNCAO
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_CONSULTAR_FILTROS] @SIGLA         NVARCHAR(MAX) = NULL,
                                                        @SITUACAO_NOME NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
  SELECT


FROM SITUACAO SITUACAO
WHERE SITUACAO.FL_EXCLU = 0
      IF @SIGLA IS NOT NULL
         AND @SIGLA <> ''
            SET @SQL=@SQL + ' AND SITUACAO.SIGLA LIKE ''%' + @SIGLA + '%'''
      IF @SITUACAO_NOME IS NOT NULL
         AND @SITUACAO_NOME <> ''
        BEGIN
            SET @SQL=@SQL + ' AND SITUACAO.SITUACAO_NOME LIKE ''%' + @SITUACAO_NOME + '%'''
        END
      SET @SQL=@SQL + 'GROUP BY
SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA
,SITUACAO.SITUACAO_NOME
 ORDER BY SITUACAO.SITUACAO_NOME
'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_BALCAO_PERCURSOS_CONSULTAR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_BALCAO NVARCHAR(MAX) = NULL
AS
  BEGIN
        SET NOCOUNT ON;
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '    
SELECT DISTINCT   
FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,  

FUNCAO.CODIGO AS FUNCAO_CODIGO,  

PERCURSOS.CODIGO AS PERCURSOS_CODIGO,
UE.DESCRICAO AS UE_DESCRICAO,





FROM FUNCAO_PERCURSOS FUNCAO_PERCURSOS  
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO AND FUNCAO.FL_EXCLU = 0  
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS AND PERCURSOS.FL_EXCLU =0   
LEFT JOIN APPS A ON A.ID_APPS = PERCURSOS.COD_APPS AND A.FL_EXCLU = 0   
INNER JOIN FUNCIONARIO F ON F.COD_FUNCAO = FUNCAO.ID_FUNCAO  
INNER JOIN BALCAO B ON B.ID_BALCAO = F.COD_BALCAO 
LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE
WHERE 
FUNCAO_PERCURSOS.FL_EXCLU = 0 
AND B.FL_EXCLU=0 
AND PERCURSOS.PERCURSOS_NOME IS NOT NULL  
AND PERCURSOS.PERCURSOS_NOME <> ''''  '
      IF @ID_BALCAO IS NOT NULL
         AND @ID_BALCAO <> ''
        BEGIN
            SET @SQL=@SQL + ' AND B.ID_BALCAO = ''' + @ID_BALCAO + ''''
        END
      SET @SQL=@SQL + '
	GROUP BY 
	FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,  
FUNCAO_PERCURSOS.COD_FUNCAO,  
FUNCAO.FUNCAO_NOME, 
FUNCAO.CODIGO,  
FUNCAO_PERCURSOS.COD_PERCURSOS,  
PERCURSOS.PERCURSOS_NOME,  
PERCURSOS.CODIGO,
UE.UE_NOME,
UE.DESCRICAO,
A.APPS_NOME,  
A.ID_APPS,  
F.FUNCIONARIO_NOME,  
F.ID_FUNCIONARIO,  
B.ID_BALCAO,
B.NM_BALCAO 
	'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 	
CREATE PROCEDURE[DBO].[PROC_MENUS_INSERIR]
	@TIPO INT,
			@NM_NIVEL_ITEM NVARCHAR(510),
			@NOVO_NIVEL_ITEM NVARCHAR(510),
			@COD_LOG_UTILIZADOR INT,
			@IMAGEM  NVARCHAR(50)  = NULL      
AS
	 DECLARE @DS_NIVEL_ITEM NVARCHAR(510)=@NM_NIVEL_ITEM
    	,@ID_NIVEL_ITEM_PAI INT
    	,@DS_SUB_ITENS NVARCHAR(MAX)=NULL 
		   ,@DS_PESQUISA NVARCHAR(MAX)=''
		   ,@PROFUNDIDADE INT		   
IF @TIPO=1
		   SELECT @ID_NIVEL_ITEM_PAI=ID_NIVEL_ITEM_PAI FROM MENUS	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM AND FL_EXCLU=0
		   SELECT @PROFUNDIDADE=PROFUNDIDADE FROM MENUS	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM AND FL_EXCLU=0
		  SELECT @DS_PESQUISA=DS_PESQUISA FROM MENUS	WHERE	ID_NIVEL_ITEM=@ID_NIVEL_ITEM_PAI AND FL_EXCLU=0
		  SET @DS_PESQUISA=@DS_PESQUISA + ' > '+ @NOVO_NIVEL_ITEM


















	         DECLARE @IDENTITTY INT = (SELECT MAX(ID_NIVEL_ITEM) FROM NIVEL_ITEM)
		     EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'HIERARQUIA','INSERIR',@IDENTITTY,NULL
ELSE
BEGIN
		   SELECT @ID_NIVEL_ITEM_PAI=ID_NIVEL_ITEM FROM MENUS	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM
		   SELECT @PROFUNDIDADE=PROFUNDIDADE FROM MENUS	WHERE NM_NIVEL_ITEM=@NM_NIVEL_ITEM
		   SELECT @DS_PESQUISA=DS_PESQUISA FROM MENUS	WHERE NM_NIVEL_ITEM=NM_NIVEL_ITEM
		   SET @PROFUNDIDADE=@PROFUNDIDADE+1
		   SET @DS_PESQUISA=@DS_PESQUISA+' > '+ @NOVO_NIVEL_ITEM
INSERT INTO [DBO].[MENUS]
        	([NM_NIVEL_ITEM]
    	,[DS_NIVEL_ITEM]
    	,[DS_PESQUISA]
    	,[ID_NIVEL_ITEM_PAI]
    	,[FL_EXCLU]
    	,[DS_SUB_ITENS]
    	,[PROFUNDIDADE]
     VALUES
        	(
			@NOVO_NIVEL_ITEM 
    	,@DS_NIVEL_ITEM 
    	,@DS_PESQUISA
    	,@ID_NIVEL_ITEM_PAI 
		   ,0
    	,@DS_SUB_ITENS 
    	,@PROFUNDIDADE 
			)
	         DECLARE @IDENTITTYY INT = (SELECT MAX(ID_NIVEL_ITEM) FROM NIVEL_ITEM)
		     EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'HIERARQUIA','INSERIR',@IDENTITTYY,NULL
		   END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_CONSULTAR_INDEX]
AS
SET NOCOUNT ON;
BEGIN
SELECT
P.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,FP.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
FROM FUNCAO_PERCURSOS FP
INNER JOIN PERCURSOS P ON P.ID_PERCURSOS = FP.COD_PERCURSOS 
LEFT JOIN APPS APPS ON APPS.ID_APPS = P.COD_APPS
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FP.COD_FUNCAO
WHERE FP.FL_EXCLU=0
AND P.FL_EXCLU=0
AND APPS.FL_EXCLU=0
AND FUNCAO.FL_EXCLU=0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_CONSULTAR_ID]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
BEGIN
SELECT
SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA
,SITUACAO.SITUACAO_NOME
FROM SITUACAO SITUACAO
WHERE SITUACAO.FL_EXCLU = 0
AND
[ID_SITUACAO] = @ID_SITUACAO
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_REL_FUNCAO_PERCURSOS_CONSULTAR] @COD_FUNCAO     NVARCHAR(MAX) = NULL,
                                                            @PERCURSOS_NOME NVARCHAR(MAX) = NULL,
                                                            @COD_APP        NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
    SELECT
  FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,
  FUNCAO.FUNCAO_NOME + '' - '' + FUNCAO.CODIGO AS FUNCAO_NOME,

  A.APPS_NOME,
  A.ID_APPS  
  FROM FUNCAO_PERCURSOS FUNCAO_PERCURSOS
  LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO AND FUNCAO.FL_EXCLU = 0
  LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS AND PERCURSOS.FL_EXCLU =0
  LEFT JOIN APPS A ON A.ID_APPS = PERCURSOS.COD_APPS AND A.FL_EXCLU = 0 
  WHERE FUNCAO_PERCURSOS.FL_EXCLU = 0
AND PERCURSOS.PERCURSOS_NOME <> ''''
  '
      IF @COD_FUNCAO IS NOT NULL
         AND @COD_FUNCAO <> ''
            SET @SQL=@SQL + ' AND FUNCAO_PERCURSOS.COD_FUNCAO = ''' + @COD_FUNCAO + ''''
      IF @PERCURSOS_NOME IS NOT NULL
         AND @PERCURSOS_NOME <> ''
            SET @SQL=@SQL + ' AND PERCURSOS.PERCURSOS_NOME LIKE ''%' + @PERCURSOS_NOME + '%'''
      IF @COD_APP IS NOT NULL
         AND @COD_APP <> ''
        BEGIN
            SET @SQL=@SQL + ' AND A.ID_APPS = ''' + @COD_APP + ''''
        END
      SET @SQL=@SQL + 'GROUP BY
 FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,
  FUNCAO_PERCURSOS.COD_FUNCAO,
  FUNCAO.FUNCAO_NOME,
  FUNCAO_PERCURSOS.COD_PERCURSOS,
  PERCURSOS.PERCURSOS_NOME,
  A.APPS_NOME ,
  A.ID_APPS ,
  FUNCAO.CODIGO
'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
P.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,FP.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
FROM FUNCAO_PERCURSOS FP
INNER JOIN PERCURSOS P ON P.ID_PERCURSOS = FP.COD_PERCURSOS 
LEFT JOIN APPS APPS ON APPS.ID_APPS = P.COD_APPS AND APPS.FL_EXCLU=0
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FP.COD_FUNCAO AND FUNCAO.FL_EXCLU=0
WHERE FP.FL_EXCLU=0
AND P.FL_EXCLU=0
AND APPS.FL_EXCLU=0
AND FUNCAO.FL_EXCLU=0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_CONSULTAR_INDEX]
AS
  BEGIN
      SELECT SITUACAO.ID_SITUACAO,
             SITUACAO.SIGLA,
             SITUACAO.SITUACAO_NOME
      FROM   SITUACAO SITUACAO
      WHERE  SITUACAO.FL_EXCLU = 0
      ORDER  BY SITUACAO.SIGLA
  END
SET ANSI_NULLS ON 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_EXCLUIR]
@ID_FUNCAO_APPS INT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCAO_APPS
SET FL_EXCLU = 1 WHERE 
[ID_FUNCAO_APPS] = @ID_FUNCAO_APPS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCAO APPS','EXCLUIR',@ID_FUNCAO_APPS ,NULL


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_CONSULTAR_LISTA_DROP]
AS
  BEGIN
      SELECT SITUACAO.ID_SITUACAO,
             SITUACAO.SIGLA,
             SITUACAO.SITUACAO_NOME
      FROM   SITUACAO SITUACAO
      WHERE  SITUACAO.FL_EXCLU = 0
      ORDER  BY SITUACAO.SIGLA
  END
SET ANSI_NULLS ON 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_INSERIR] @COD_FUNCAO         INT = NULL,
                                                 @COD_APPS           INT = NULL,
                                                 @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   FUNCAO_APPS
                    WHERE  FL_EXCLU = 0
                           AND COD_FUNCAO = @COD_FUNCAO
                           AND COD_APPS = @COD_APPS)
        BEGIN
            INSERT INTO [DBO].[FUNCAO_APPS]
                        ([FL_EXCLU],
                         [COD_FUNCAO],
                         [COD_APPS])
            VALUES      ( 0,
                          @COD_FUNCAO,
                          @COD_APPS )
            SELECT MAX(ID_FUNCAO_APPS) AS IDENTITTY
            FROM   FUNCAO_APPS
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_FUNCAO_APPS) FROM
        FUNCAO_APPS)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'FUNCAO APPS',
              'INSERIR',
              @IDENTITTY,
              NULL
        END     
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE SITUACAO
SET FL_EXCLU = 1 WHERE 
[ID_SITUACAO] = @ID_SITUACAO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'SITUACAO','EXCLUIR',@ID_SITUACAO ,NULL

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_PERCURSOS_EXCLUIR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCAO INT,
                                                      @COD_LOG_UTILIZADOR  INT
AS
BEGIN
   DELETE FROM FUNCAO_PERCURSOS WHERE COD_FUNCAO = @ID_FUNCAO
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_IMPORTAR] @SIGLA              NVARCHAR(3) = NULL,                                              
                                               @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   SITUACAO
                    WHERE  FL_EXCLU = 0
                           AND SIGLA = @SIGLA
						   )
        BEGIN
            INSERT INTO [DBO].[SITUACAO]
                        ([FL_EXCLU],
                         [SIGLA],
                         [SITUACAO_NOME])
            VALUES      ( 0,
                          @SIGLA,
                          '' )
            SELECT MAX(ID_SITUACAO) AS IDENTITTY
            FROM   SITUACAO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_SITUACAO) FROM
        SITUACAO)
            ----EXEC PROC_LOGS_INSERIR
            ----  @COD_LOG_UTILIZADOR,
            ----  'SITUACAO',
            ----  'INSERIR',
            ----  @IDENTITTY,
            ----  NULL
        END
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_PERCURSOS_INSERIR] @COD_FUNCAO         INT,
                                                         @COD_APPS           INT,
                                                         @COD_PERCURSOS      INT,
                                                         @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      EXEC PROC_FUNCAO_APPS_INSERIR
        @COD_APPS,
      EXEC PROC_FUNCAO_PERCURSOS_INSERIR
        @COD_FUNCAO,
        @COD_PERCURSOS,
        @COD_LOG_UTILIZADOR
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_SITUACAO_INSERIR] @SIGLA              NVARCHAR(3) = NULL,
                                              @SITUACAO_NOME      NVARCHAR(20) = NULL,
                                              @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   SITUACAO
                    WHERE  FL_EXCLU = 0
                           AND SIGLA = @SIGLA
                           )
            INSERT INTO [DBO].[SITUACAO]
                        ([FL_EXCLU],
                         [SIGLA],
                         [SITUACAO_NOME])
            VALUES      ( 0,
                          @SIGLA,
                          @SITUACAO_NOME )
            SELECT MAX(ID_SITUACAO) AS IDENTITTY
            FROM   SITUACAO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_SITUACAO) FROM
        SITUACAO)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'SITUACAO',
              'INSERIR',
              @IDENTITTY,
              NULL
      ELSE
        BEGIN
            RAISERROR('JÁ EXISTE REGISTO DE SITUACAO COM ESTES DADOS!',16,1)
        END
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_APPS_PERCURSOS_INSERIR_1]
  @COD_FUNCAO         INT,
  --@COD_APPS           INT,
  --@COD_PERCURSOS      INT,
  @COD_LOG_UTILIZADOR INT,
  @ARRAY_CODIGOS      NVARCHAR(MAX)
AS
BEGIN    
	--DECLARE @LIST VARCHAR(MAX) = '3844_377_69051,3844_377_69096,3844_377_69099,3844_377_69098,3844_377_69100,3844_377_69104,3844_377_69131,3844_377_69105,3844_377_69106,3844_377_69107,3844_377_69108,3844_377_69110,3844_377_69109,3844_377_69111,3844_377_69112,3844_377_69127,3844_377_69128,3844_377_69129,3844_377_69113,3844_377_69115,3844_377_69114,3844_377_69116,3844_377_69117,3844_377_69130,3844_377_69118,3844_377_69121,3844_377_69125,3844_377_69122,3844_377_69119,3844_377_69120,3844_377_69124,3844_377_69126,3844_377_69123,3844_377_69082,3844_377_69095,3844_377_69083,3844_377_69084,3844_377_69085,3844_377_69086,3844_377_69087,3844_377_69089,3844_377_69088,3844_377_69091,3844_377_69090,3844_377_69092,3844_377_69093,3844_377_69094,3844_377_69052,3844_377_69053,3844_377_69064,3844_377_69058,3844_377_69059,3844_377_69060,3844_377_69061,3844_377_69062,3844_377_69063,3844_377_69057,3844_377_69055,3844_377_69054,3844_377_69056,3844_377_69065,3844_377_69070,3844_377_69071,3844_377_69068,3844_377_69072,3844_377_69075,3844_377_69073,3844_377_69074,3844_377_69066,3844_377_69069,3844_377_69067,3844_377_69079,3844_377_69076,3844_377_69077,3844_377_69230,3844_377_69231,3844_377_69081,3844_377_69080,3844_377_69078,3844_377_69101,3844_377_69102,3844_377_69103,3844_377_69759,3844_377_69272,3844_377_69277,3844_377_69280,3844_377_69281,3844_377_69278,3844_377_69279,3844_377_69273,3844_377_69276,3844_377_69275,3844_377_69274,3844_377_69284,3844_377_69283,3844_377_69287,3844_377_69288,3844_377_69291,3844_377_69290,3844_377_69285,3844_377_69286,3844_377_69289,3844_377_69292,3844_377_69301,3844_377_69294,3844_377_69293,3844_377_69295,3844_377_69300,3844_377_69297,3844_377_69298,3844_377_69299,3844_377_69296,3844_377_69282,3844_377_69262,3844_377_69270,3844_377_69269,3844_377_69264,3844_377_69265,3844_377_69267,3844_377_69266,3844_377_69271,3844_377_69263,3844_377_69268,3844_377_69637,3844_377_69577,3844_377_69382,3844_377_69642,3844_377_69464,3844_377_69380,3844_377_69825,3844_377_69510,3844_377_69394,3844_377_69396,3844_377_69395,3844_377_69399,3844_377_69397,3844_377_69398,3844_377_69401,3844_377_69402,3844_377_69302,3844_377_69828,3844_377_69829,3844_377_69835,3844_377_69823,3844_377_69840,3844_377_69841,3844_377_69837,3844_377_69844,3844_377_69826,3844_377_69836,3844_377_69824,3844_377_69670,3844_377_69671,3844_377_69690,3844_377_69691,3844_377_69688,3844_377_69687,3844_377_69673,3844_377_69675,3844_377_69676,3844_377_69677,3844_377_69678,3844_377_69679,3844_377_69680,3844_377_69681,3844_377_69682,3844_377_69684,3844_377_69685,3844_377_69686,3844_377_69319,3844_377_69318,3844_377_69315,3844_377_69317,3844_377_69316,3844_377_69321,3844_377_69322,3844_377_69320,3844_377_69303,3844_377_69700,3844_377_69703,3844_377_69702,3844_377_69701,3844_377_69706,3844_377_69707,3844_377_69708,3844_377_69709,3844_377_69704,3844_377_69705,3844_377_69559,3844_377_69561,3844_377_69563,3844_377_69562,3844_377_69564,3844_377_69565,3844_377_69558,3844_377_69560,3844_377_69527,3844_377_69618,3844_377_69624,3844_377_69625,3844_377_69626,3844_377_69623,3844_377_69640,3844_377_69632,3844_377_69639,3844_377_69635,3844_377_69634,3844_377_69636,3844_377_69633,3844_377_69631,3844_377_69630,3844_377_69645,3844_377_69646,3844_377_69643,3844_377_69644,3844_377_69621,3844_377_69622,3844_377_69619,3844_377_69620,3844_377_69628,3844_377_69629,3844_377_69627,3844_377_69641,3844_377_69537,3844_377_69651,3844_377_69652,3844_377_69654,3844_377_69653,3844_377_69566,3844_377_69538,3844_377_69544,3844_377_69541,3844_377_69540,3844_377_69543,3844_377_69542,3844_377_69539,3844_377_69606,3844_377_69546,3844_377_69608,3844_377_69585,3844_377_69576,3844_377_69578,3844_377_69581,3844_377_69580,3844_377_69582,3844_377_69579,3844_377_69583,3844_377_69584,3844_377_69567,3
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_ALTERAR]
@ID_TIPO_AUTORIDADE INT,
@TIPO_AUTORIDADE_NOME INT,
@DESCRICAO NVARCHAR(MAX),
@COD_SITUACAO INT,
@COD_APPS INT
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM TIPO_AUTORIDADE WHERE 
FL_EXCLU = 0 AND
TIPO_AUTORIDADE_NOME = @TIPO_AUTORIDADE_NOME AND
DESCRICAO = @DESCRICAO AND
COD_SITUACAO = @COD_SITUACAO AND
COD_APPS = @COD_APPS
AND ID_TIPO_AUTORIDADE <> @ID_TIPO_AUTORIDADE
)
UPDATE TIPO_AUTORIDADE
SET
[TIPO_AUTORIDADE_NOME] = @TIPO_AUTORIDADE_NOME,
[DESCRICAO] = @DESCRICAO,
[COD_SITUACAO] = @COD_SITUACAO,
[COD_APPS] = @COD_APPS
WHERE ID_TIPO_AUTORIDADE = @ID_TIPO_AUTORIDADE
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'TIPO AUTORIDADE','ALTERAR',@ID_TIPO_AUTORIDADE ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE TIPO AUTORIDADE COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_FUNCAO)  FROM FUNCAO WHERE FL_EXCLU = 0
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_TIPO_AUTORIDADE)  FROM TIPO_AUTORIDADE T
INNER JOIN APPS APPS ON APPS.ID_APPS = T.COD_APPS
WHERE APPS.FL_EXCLU = 0
AND T.FL_EXCLU = 0
 AND APPS.FL_CONTEMPLA_AUTORIDADES=1
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@MOEDA_NOME NVARCHAR(MAX),
@SIGLA NVARCHAR(20)
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
IF NOT EXISTS(SELECT * FROM MOEDA WHERE 
MOEDA_NOME = @MOEDA_NOME AND
FL_EXCLU = 0 AND
SIGLA = @SIGLA
AND ID_MOEDA <> @ID_MOEDA
)
UPDATE MOEDA
SET
[MOEDA_NOME] = @MOEDA_NOME,
[SIGLA] = @SIGLA
WHERE ID_MOEDA = @ID_MOEDA
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'MOEDA','ALTERAR',@ID_MOEDA ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE MOEDA COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_CONSULTAR_FILTROS] @TIPO_AUTORIDADE_NOME NVARCHAR(MAX) = NULL,
                                                               @DESCRICAO            NVARCHAR(MAX) = NULL,
                                                               @COD_SITUACAO         NVARCHAR(MAX) = NULL,
                                                               @SITUACAO_NOME        NVARCHAR(MAX) = NULL,
                                                               @COD_APPS             NVARCHAR(MAX) = NULL,
                                                               @APPS_NOME            NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
  SELECT


,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA

,SITUACAO.SIGLA AS SITUACAO_SIGLA
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
FROM TIPO_AUTORIDADE TIPO_AUTORIDADE
LEFT JOIN APPS APPS ON APPS.ID_APPS = TIPO_AUTORIDADE.COD_APPS
LEFT JOIN SITUACAO SITUACAO ON SITUACAO.ID_SITUACAO = TIPO_AUTORIDADE.COD_SITUACAO
WHERE TIPO_AUTORIDADE.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND SITUACAO.FL_EXCLU = 0
  AND APPS.FL_CONTEMPLA_AUTORIDADES=1
      IF @TIPO_AUTORIDADE_NOME IS NOT NULL
         AND @TIPO_AUTORIDADE_NOME <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME = ''' + @TIPO_AUTORIDADE_NOME + ''''
      IF @DESCRICAO IS NOT NULL
         AND @DESCRICAO <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.DESCRICAO LIKE ''%' + @DESCRICAO + '%'''
      IF @COD_SITUACAO IS NOT NULL
         AND @COD_SITUACAO <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.COD_SITUACAO = ''' + @COD_SITUACAO + ''''
      IF @SITUACAO_NOME IS NOT NULL
         AND @SITUACAO_NOME <> ''
            SET @SQL=@SQL + ' AND SITUACAO.SITUACAO_NOME LIKE ''%' + @SITUACAO_NOME + '%'''
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND TIPO_AUTORIDADE.COD_APPS = ''' + @COD_APPS + ''''
      IF @APPS_NOME IS NOT NULL
         AND @APPS_NOME <> ''
        BEGIN
            SET @SQL=@SQL + ' AND APPS.APPS_NOME LIKE ''%' + @APPS_NOME + '%'''
        END
      SET @SQL=@SQL + 'GROUP BY
TIPO_AUTORIDADE.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,TIPO_AUTORIDADE.COD_SITUACAO
,SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA
,SITUACAO.SITUACAO_NOME
,TIPO_AUTORIDADE.DESCRICAO
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME ORDER BY TIPO_AUTORIDADE.COD_APPS
'
      EXEC(@SQL)
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_MOEDA)  FROM MOEDA WHERE FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_FILTROS] @COD_FUNCAO  NVARCHAR(MAX) = NULL,
                                                      @CODIGO       NVARCHAR(MAX) = NULL,
                                                      @COD_UE NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
	  SELECT
			 FUNCAO.COD_UE,
             UE.ID_UE,
             UE.UE_NOME,
             UE.DESCRICAO                          AS UE_DESCRICAO,
             FUNCAO.CODIGO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.ID_FUNCAO,
             (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS,
            (SELECT COUNT(DISTINCT P.COD_APPS)




                     AND P.PERCURSOS_NOME <> '''')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '''')   AS TOTAL_PERCURSOS
  FROM FUNCAO FUNCAO
  LEFT JOIN UE UE ON UE.ID_UE = FUNCAO.COD_UE
  LEFT JOIN EMPRESA EMPRESA ON EMPRESA.FL_EXCLU = 0
  WHERE FUNCAO.FL_EXCLU = 0
  AND FUNCAO.FUNCAO_NOME<>''''
  AND FUNCAO.FUNCAO_NOME IS NOT NULL'
      IF @COD_FUNCAO IS NOT NULL
         AND @COD_FUNCAO <> ''
            SET @SQL=@SQL + ' AND FUNCAO.ID_FUNCAO = ''' + @COD_FUNCAO + ''''
      IF @CODIGO IS NOT NULL
         AND @CODIGO <> ''
            SET @SQL=@SQL + ' AND FUNCAO.CODIGO LIKE ''%' + @CODIGO + '%'''
      IF @COD_UE IS NOT NULL
         AND @COD_UE <> ''
        BEGIN
            SET @SQL=@SQL + ' AND FUNCAO.COD_UE = ''' + @COD_UE + ''''
        END
      SET @SQL=@SQL + ' GROUP BY
		 FUNCAO.COD_UE
		,UE.ID_UE
		,UE.UE_NOME
		,UE.DESCRICAO
		,FUNCAO.CODIGO
		,FUNCAO.FUNCAO_NOME
		,FUNCAO.ID_FUNCAO
'
      EXEC(@SQL)
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_CONSULTAR_ID]
@ID_TIPO_AUTORIDADE INT
AS
BEGIN
SELECT
TIPO_AUTORIDADE.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA
,TIPO_AUTORIDADE.COD_SITUACAO
,SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA AS SITUACAO_SIGLA
,SITUACAO.SITUACAO_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
FROM TIPO_AUTORIDADE TIPO_AUTORIDADE
LEFT JOIN APPS APPS ON APPS.ID_APPS = TIPO_AUTORIDADE.COD_APPS
LEFT JOIN SITUACAO SITUACAO ON SITUACAO.ID_SITUACAO = TIPO_AUTORIDADE.COD_SITUACAO
WHERE TIPO_AUTORIDADE.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND SITUACAO.FL_EXCLU = 0
  AND APPS.FL_CONTEMPLA_AUTORIDADES=1
AND
[ID_TIPO_AUTORIDADE] = @ID_TIPO_AUTORIDADE
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCAO INT
AS
  BEGIN
      SELECT FUNCAO.COD_UE,
             UE.ID_UE,
             UE.UE_NOME,
             UE.DESCRICAO                          AS UE_DESCRICAO,
             FUNCAO.CODIGO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.ID_FUNCAO,
             (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS,
			 (SELECT COUNT(DISTINCT P.COD_APPS)




                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_PERCURSOS
      FROM   FUNCAO FUNCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
      WHERE  FUNCAO.FL_EXCLU = 0
             AND [ID_FUNCAO] = @ID_FUNCAO
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_CONSULTAR_INDEX]
AS
BEGIN
SELECT
TIPO_AUTORIDADE.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA
,TIPO_AUTORIDADE.COD_SITUACAO
,SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA AS SITUACAO_SIGLA
,SITUACAO.SITUACAO_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
FROM TIPO_AUTORIDADE TIPO_AUTORIDADE
LEFT JOIN APPS APPS ON APPS.ID_APPS = TIPO_AUTORIDADE.COD_APPS
LEFT JOIN SITUACAO SITUACAO ON SITUACAO.ID_SITUACAO = TIPO_AUTORIDADE.COD_SITUACAO
WHERE TIPO_AUTORIDADE.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND SITUACAO.FL_EXCLU = 0
  AND APPS.FL_CONTEMPLA_AUTORIDADES=1
 ORDER BY TIPO_AUTORIDADE.COD_APPS
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_CONSULTAR_ID]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
SET NOCOUNT ON;
BEGIN
SELECT
MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
FROM MOEDA MOEDA
WHERE MOEDA.FL_EXCLU = 0
AND
[ID_MOEDA] = @ID_MOEDA
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_ID_CCUSTO]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_CCUSTO INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCAO.COD_UE,
             UE.ID_UE,
             UE.UE_NOME,
             UE.DESCRICAO                          AS UE_DESCRICAO,
             FUNCAO.CODIGO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.ID_FUNCAO,
             (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS,
			 (SELECT COUNT(DISTINCT P.COD_APPS)




                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_PERCURSOS
      FROM   FUNCAO FUNCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
      WHERE  FUNCAO.FL_EXCLU = 0
             AND COD_UE = @ID_CCUSTO
      ORDER  BY FUNCAO.FUNCAO_NOME
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_CONSULTAR_LISTA_DROP]
AS
BEGIN
SELECT
TIPO_AUTORIDADE.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO AS APPS_DESCRICAO
,APPS.SIGLA AS APPS_SIGLA
,TIPO_AUTORIDADE.COD_SITUACAO
,SITUACAO.ID_SITUACAO
,SITUACAO.SIGLA AS SITUACAO_SIGLA
,SITUACAO.SITUACAO_NOME
,TIPO_AUTORIDADE.DESCRICAO AS TA_DESCRICAO
,TIPO_AUTORIDADE.ID_TIPO_AUTORIDADE
,TIPO_AUTORIDADE.TIPO_AUTORIDADE_NOME
FROM TIPO_AUTORIDADE TIPO_AUTORIDADE
LEFT JOIN APPS APPS ON APPS.ID_APPS = TIPO_AUTORIDADE.COD_APPS AND APPS.FL_EXCLU=0
LEFT JOIN SITUACAO SITUACAO ON SITUACAO.ID_SITUACAO = TIPO_AUTORIDADE.COD_SITUACAO AND SITUACAO.FL_EXCLU=0
WHERE TIPO_AUTORIDADE.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
 AND SITUACAO.FL_EXCLU = 0
 AND APPS.FL_CONTEMPLA_AUTORIDADES=1
 ORDER BY TIPO_AUTORIDADE.COD_APPS
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_CONSULTAR_INDEX]
AS
SET NOCOUNT ON;
BEGIN
SELECT
MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
FROM MOEDA MOEDA
WHERE MOEDA.FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_INDEX]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCAO.COD_UE,
             UE.ID_UE,
             UE.UE_NOME,
             UE.DESCRICAO                          AS UE_DESCRICAO,
             FUNCAO.CODIGO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.ID_FUNCAO,
             (SELECT COUNT(FUNCIONARIO.ID_FUNCIONARIO)
              FROM   FUNCIONARIO FUNCIONARIO
              WHERE  FUNCIONARIO.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FUNCIONARIO.FL_EXCLU = 0) AS TOTAL_FUNCIONARIOS,
			 (SELECT COUNT(DISTINCT P.COD_APPS)




                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_PERCURSOS
      FROM   FUNCAO FUNCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
      WHERE  FUNCAO.FL_EXCLU = 0
	   AND FUNCAO.FUNCAO_NOME<>''
	  AND FUNCAO.FUNCAO_NOME IS NOT NULL
      ORDER  BY FUNCAO.FUNCAO_NOME
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_EXCLUIR]
@ID_TIPO_AUTORIDADE INT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE TIPO_AUTORIDADE
SET FL_EXCLU = 1 WHERE 
[ID_TIPO_AUTORIDADE] = @ID_TIPO_AUTORIDADE
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'TIPO AUTORIDADE','EXCLUIR',@ID_TIPO_AUTORIDADE ,NULL
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
MOEDA.ID_MOEDA
,MOEDA.MOEDA_NOME
,MOEDA.SIGLA
FROM MOEDA MOEDA
WHERE MOEDA.FL_EXCLU = 0
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_INTEGRACAO]
AS
  BEGIN
      SELECT FUNCAO.COD_UE,
             UE.ID_UE,
             UE.UE_NOME,
             UE.DESCRICAO,
             FUNCAO.CODIGO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.ID_FUNCAO
      FROM   FUNCAO FUNCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
      WHERE  FUNCAO.FL_EXCLU = 0
	  AND (
	  SELECT COUNT(DISTINCT P.COD_APPS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND FPP.FL_EXCLU = 0 AND P.FL_EXCLU=0) <> 0
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_IMPORTAR] @TIPO_AUTORIDADE_NOME INT,
                                                      @DESCRICAO            NVARCHAR(MAX),
                                                      @COD_SITUACAO         INT,
                                                      @COD_LOG_UTILIZADOR   INT,
													  @COD_APPS INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   TIPO_AUTORIDADE
                    WHERE  FL_EXCLU = 0
                           AND TIPO_AUTORIDADE_NOME = @TIPO_AUTORIDADE_NOME
                           AND DESCRICAO = @DESCRICAO
                           AND COD_SITUACAO = @COD_SITUACAO)
        BEGIN
            INSERT INTO [DBO].[TIPO_AUTORIDADE]
                        ([FL_EXCLU],
                         [TIPO_AUTORIDADE_NOME],
                         [DESCRICAO],
                         [COD_SITUACAO],
						 [COD_APPS]
						 )
            VALUES      ( 0,
                          @TIPO_AUTORIDADE_NOME,
                          @DESCRICAO,
                          @COD_SITUACAO,
						  @COD_APPS)
            SELECT MAX(ID_TIPO_AUTORIDADE) AS IDENTITTY
            FROM   TIPO_AUTORIDADE
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_TIPO_AUTORIDADE) FROM
        TIPO_AUTORIDADE)
            ----EXEC PROC_LOGS_INSERIR
            ----  @COD_LOG_UTILIZADOR,
            ----  'TIPO AUTORIDADE',
            ----  'INSERIR',
            ----  @IDENTITTY,
            ----  NULL
        END
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE MOEDA
SET FL_EXCLU = 1 WHERE 
[ID_MOEDA] = @ID_MOEDA
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'MOEDA','EXCLUIR',@ID_MOEDA ,NULL
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_CONSULTAR_LISTA_DROP]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT DISTINCT FUNCAO.COD_UE,
                      UE.ID_UE,
                      UE.UE_NOME,
                      UE.DESCRICAO,
                      FUNCAO.CODIGO,
                      FUNCAO.FUNCAO_NOME,
                      FUNCAO.ID_FUNCAO
      FROM   FUNCAO FUNCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
                  AND UE.FL_EXCLU = 0
      WHERE  FUNCAO.FL_EXCLU = 0
	  AND FUNCAO.FUNCAO_NOME<>''
	  AND FUNCAO.FUNCAO_NOME IS NOT NULL
      ORDER  BY FUNCAO.FUNCAO_NOME
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_TIPO_AUTORIDADE_INSERIR]
@TIPO_AUTORIDADE_NOME INT,
@DESCRICAO NVARCHAR(MAX),
@COD_SITUACAO INT,
@COD_APPS INT
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM TIPO_AUTORIDADE WHERE 
FL_EXCLU = 0 AND
TIPO_AUTORIDADE_NOME = @TIPO_AUTORIDADE_NOME AND
DESCRICAO = @DESCRICAO AND
COD_SITUACAO = @COD_SITUACAO AND
COD_APPS = @COD_APPS

INSERT INTO [DBO].[TIPO_AUTORIDADE]
[FL_EXCLU],
[TIPO_AUTORIDADE_NOME],
[DESCRICAO],
[COD_SITUACAO],
[COD_APPS]
VALUES
(
0,
@TIPO_AUTORIDADE_NOME,
@DESCRICAO,
@COD_SITUACAO,
@COD_APPS
)
SELECT MAX(ID_TIPO_AUTORIDADE) AS IDENTITTY FROM TIPO_AUTORIDADE WHERE FL_EXCLU = 0
DECLARE @IDENTITTY INT = (SELECT MAX(ID_TIPO_AUTORIDADE) FROM TIPO_AUTORIDADE)
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'TIPO AUTORIDADE','INSERIR',@IDENTITTY ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE TIPO AUTORIDADE COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_IMPORTAR] @SIGLA              NVARCHAR(20),
                                            @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  IF(@SIGLA IS NOT NULL AND @SIGLA <> '')
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   MOEDA
                    WHERE  FL_EXCLU = 0
                           AND SIGLA = @SIGLA)
        BEGIN
            INSERT INTO [DBO].[MOEDA]
                        ([MOEDA_NOME],
                         [FL_EXCLU],
                         [SIGLA])
            VALUES      ( '',
                          0,
                          @SIGLA )
            SELECT MAX(ID_MOEDA) AS IDENTITTY
            FROM   MOEDA
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_MOEDA) FROM
        MOEDA)
            ----EXEC PROC_LOGS_INSERIR
            ----  @COD_LOG_UTILIZADOR,
            ----  'MOEDA',
            ----  'INSERIR',
            ----  @IDENTITTY,
            ----  NULL
        END
  END 
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCAO
SET FL_EXCLU = 1 WHERE 
[ID_FUNCAO] = @ID_FUNCAO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCAO','EXCLUIR',@ID_FUNCAO ,NULL



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_MOEDA_INSERIR] @MOEDA_NOME         NVARCHAR(MAX),
                                           @SIGLA              NVARCHAR(20),
                                           @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  IF(@SIGLA IS NOT NULL AND @SIGLA <> '')
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   MOEDA
                    WHERE  MOEDA_NOME = @MOEDA_NOME
                           AND FL_EXCLU = 0
                           AND SIGLA = @SIGLA)
            INSERT INTO [DBO].[MOEDA]
                        ([MOEDA_NOME],
                         [FL_EXCLU],
                         [SIGLA])
            VALUES      ( @MOEDA_NOME,
                          0,
                          @SIGLA )
            SELECT MAX(ID_MOEDA) AS IDENTITTY
            FROM   MOEDA
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_MOEDA) FROM
        MOEDA)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'MOEDA',
              'INSERIR',
              @IDENTITTY,
              NULL
      ELSE
        BEGIN
            RAISERROR('JÁ EXISTE REGISTO DE MOEDA COM ESTES DADOS!',16,1)
        END
  END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_DEPARTAMENTO_ACTUALIZAR]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @COUNTER_NI INT = 0
	DECLARE @TOTAL_NI INT = (SELECT COUNT(*) FROM DEPARTAMENTO)
	DECLARE @ID_NI INT 	 		
	WHILE (@COUNTER_NI <> (@TOTAL_NI))
	BEGIN 	  
	   SET @ID_NI = (SELECT ID_DEPARTAMENTO FROM DEPARTAMENTO ORDER BY ID_DEPARTAMENTO OFFSET @COUNTER_NI ROWS FETCH NEXT 1 ROWS ONLY)
	UPDATE DEPARTAMENTO SET 
	   QUANT_FUNCIONARIOS = (SELECT COUNT(ID_UTILIZADOR) FROM UTILIZADORES	WHERE COD_DEPARTAMENTO = @ID_NI  AND FL_EXCLU=0),
	   DS_SUB_ITENS = (SELECT COUNT(ID_DEPARTAMENTO) FROM DEPARTAMENTO	WHERE COD_DEPARTAMENTO_PAI = @ID_NI  AND FL_EXCLU=0)	WHERE ID_DEPARTAMENTO=@ID_NI AND FL_EXCLU=0
	   SET @COUNTER_NI = @COUNTER_NI + 1  
	END
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_IMPORTAR] @FUNCAO_NOME        NVARCHAR(MAX),
                                             @CODIGO             NVARCHAR(50),
                                             @UE_NOME            NVARCHAR(MAX) = NULL,
                                             @UE_DESCRICAO       NVARCHAR(MAX) = NULL,
                                             @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      EXEC PROC_UE_INSERIR
        @UE_NOME,
        @UE_DESCRICAO,
        @COD_LOG_UTILIZADOR,
		0
      DECLARE @COD_UE INT = (SELECT TOP(1) ID_UE FROM UE WHERE
  DESCRICAO = @UE_DESCRICAO AND UE_NOME = @UE_NOME)
      EXEC PROC_FUNCAO_INSERIR
        @FUNCAO_NOME,
        @CODIGO,
        @COD_UE,
        @COD_LOG_UTILIZADOR
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_ACTUALIZAR]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @COUNTER_NI INT = 0
	DECLARE @TOTAL_NI INT = (SELECT COUNT(*) FROM NIVEL_ITEM)
	DECLARE @ID_NI INT 	 		
	WHILE (@COUNTER_NI <> (@TOTAL_NI))
	BEGIN 	  
	   SET @ID_NI = (SELECT ID_NIVEL_ITEM FROM NIVEL_ITEM ORDER BY ID_NIVEL_ITEM OFFSET @COUNTER_NI ROWS FETCH NEXT 1 ROWS ONLY)
	UPDATE NIVEL_ITEM SET 
	   QUANT_FUNCIONARIOS = (SELECT COUNT(ID_UTILIZADOR) FROM UTILIZADORES	WHERE COD_NIVEL_ITEM = @ID_NI  AND FL_EXCLU=0),
	   DS_SUB_ITENS = (SELECT COUNT(ID_NIVEL_ITEM) FROM NIVEL_ITEM	WHERE ID_NIVEL_ITEM_PAI = @ID_NI  AND FL_EXCLU=0)	WHERE ID_NIVEL_ITEM=@ID_NI AND FL_EXCLU=0
	   SET @COUNTER_NI = @COUNTER_NI + 1  
	END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_INSERIR] @FUNCAO_NOME        NVARCHAR(MAX),
                                            @CODIGO             NVARCHAR(50)=NULL,
                                            @COD_UE             NVARCHAR(50) = NULL,
                                            @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   FUNCAO
                    WHERE  FUNCAO_NOME = @FUNCAO_NOME
                           AND FL_EXCLU = 0
                           AND CODIGO = @CODIGO
                           AND COD_UE = @COD_UE)
        BEGIN
            INSERT INTO [DBO].[FUNCAO]
                        ([FUNCAO_NOME],
                         [FL_EXCLU],
                         [CODIGO],
                         [COD_UE])
            VALUES      ( @FUNCAO_NOME,
                          0,
                          @CODIGO,
                          @COD_UE )
            SELECT MAX(ID_FUNCAO) AS IDENTITTY
            FROM   FUNCAO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_FUNCAO) FROM
        FUNCAO)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'FUNCAO',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
		ELSE
		BEGIN
		RAISERROR('JÁ EXISTE UMA FUNÇÃO COM ESTES DADOS!',16,1)
		END
  END 


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_ALTERAR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_NIVEL_ITEM      INT,
                                                @NM_NIVEL_ITEM      NVARCHAR(510),
                                                @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      UPDATE NIVEL_ITEM
      SET    NM_NIVEL_ITEM = @NM_NIVEL_ITEM
      WHERE  ID_NIVEL_ITEM = @ID_NIVEL_ITEM
      EXEC PROC_LOGS_INSERIR
        @COD_LOG_UTILIZADOR,
        'HIERARQUIA',
        'ALTERAR',
        @ID_NIVEL_ITEM,
        NULL
      EXEC PROC_NIVEL_ITEM_ACTUALIZAR
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_ALTERAR]
@ID_FUNCAO_PERCURSOS INT,
@COD_FUNCAO INT = NULL,
@COD_PERCURSOS INT = NULL
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCAO_PERCURSOS
SET
[COD_FUNCAO] = @COD_FUNCAO,
[COD_PERCURSOS] = @COD_PERCURSOS
WHERE ID_FUNCAO_PERCURSOS = @ID_FUNCAO_PERCURSOS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCAO PERCURSOS','ALTERAR',@ID_FUNCAO_PERCURSOS ,NULL



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_CONSULTA]
AS
  BEGIN
      SET NOCOUNT ON;
	  SELECT DISTINCT N.ID_NIVEL_ITEM,












	  AND ID_NIVEL_ITEM_PAI IS NULL
	  UNION ALL
      SELECT DISTINCT N.ID_NIVEL_ITEM,
      N.NM_NIVEL_ITEM,
      N.DS_NIVEL_ITEM,
      N.DS_PESQUISA,
      ISNULL(N.ORDEM, 0)             ORDEM,
      ISNULL(N.ID_NIVEL_ITEM_PAI, 0) ID_NIVEL_ITEM_PAI,
      ISNULL(N.ID_NIVEL, 0)          ID_NIVEL,
      N.FL_EXCLU,
      N.DS_SUB_ITENS,
      ISNULL(N.PROFUNDIDADE, 0)      PROFUNDIDADE,
	  (SELECT NM_NIVEL_ITEM FROM NIVEL_ITEM NP WHERE NP.ID_NIVEL_ITEM = N.ID_NIVEL_ITEM_PAI AND FL_EXCLU = 0) AS NIVEL_ITEM_PAI
      FROM   [NIVEL_ITEM] N
	  INNER JOIN NIVEL_ITEM NP ON NP.ID_NIVEL_ITEM = N.ID_NIVEL_ITEM_PAI
      WHERE  
	  N.FL_EXCLU = 0
	  AND NP.FL_EXCLU = 0
      ORDER  BY 
	  PROFUNDIDADE ASC,
	  ORDEM,
	  NM_NIVEL_ITEM
  END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_FUNCAO_PERCURSOS)  FROM FUNCAO_PERCURSOS WHERE FL_EXCLU = 0
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_EXCLUIR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_NIVEL_ITEM      INT,
                                                @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      UPDATE NIVEL_ITEM
                  SET    FL_EXCLU = 1
                  WHERE  ID_NIVEL_ITEM = @ID_NIVEL_ITEM
                  EXEC PROC_LOGS_INSERIR
                    @COD_LOG_UTILIZADOR,
                    'HIERARQUIA',
                    'EXCLUIR',
                    @ID_NIVEL_ITEM,
                    NULL
                  EXEC PROC_NIVEL_ITEM_ACTUALIZAR
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_NIVEL_ITEM_INSERIR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_NIVEL_ITEM_PAI  INT,
                                                @NOVO_NIVEL_ITEM    NVARCHAR(510),
                                                @COD_LOG_UTILIZADOR INT,
                                                @TIPO               INT
AS
  BEGIN
      DECLARE @PROFUNDIDADE INT = (SELECT PROFUNDIDADE FROM NIVEL_ITEM WHERE ID_NIVEL_ITEM = @ID_NIVEL_ITEM_PAI AND FL_EXCLU =0) + 1
      DECLARE @ID_NIVEL_ITEM_PAI1 INT = (SELECT ID_NIVEL_ITEM_PAI FROM NIVEL_ITEM WHERE
  ID_NIVEL_ITEM = @ID_NIVEL_ITEM_PAI AND FL_EXCLU =0)
      DECLARE @DS_PESQUISA NVARCHAR(MAX) = (SELECT DS_PESQUISA FROM NIVEL_ITEM WHERE ID_NIVEL_ITEM = @ID_NIVEL_ITEM_PAI AND FL_EXCLU =0) + ' > ' + @NOVO_NIVEL_ITEM
      IF( @TIPO = 1 )
















                                @ID_NIVEL_ITEM_PAI1,




                  DECLARE @IDENTITTY INT = (SELECT MAX(ID_NIVEL_ITEM) FROM




                    @IDENTITTY,


      IF( @TIPO = 2 )
        BEGIN
            IF NOT EXISTS (SELECT *
                           FROM   NIVEL_ITEM
                           WHERE  NM_NIVEL_ITEM = @NOVO_NIVEL_ITEM
                                  AND PROFUNDIDADE = @PROFUNDIDADE
                                  AND ID_NIVEL_ITEM_PAI = @ID_NIVEL_ITEM_PAI
                                  AND FL_EXCLU = 0)
              BEGIN
                  INSERT INTO [NIVEL_ITEM]
                              ([NM_NIVEL_ITEM],
                               [ID_NIVEL_ITEM_PAI],
                               [DS_NIVEL_ITEM],
                               [DS_PESQUISA],
                               [DS_SUB_ITENS],
                               [PROFUNDIDADE],
                               [FL_EXCLU])
                  VALUES      ( @NOVO_NIVEL_ITEM,
                                @ID_NIVEL_ITEM_PAI,
                                @NOVO_NIVEL_ITEM,
                                @DS_PESQUISA,
                                0,
                                @PROFUNDIDADE,
                                0 )
                  DECLARE @IDENTITTY1 INT = (SELECT MAX(ID_NIVEL_ITEM) FROM
              NIVEL_ITEM)
                  EXEC PROC_LOGS_INSERIR
                    @COD_LOG_UTILIZADOR,
                    'HIERARQUIA',
                    'INSERIR',
                    @IDENTITTY1,
                    NULL
              END
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_ID]
@ID_FUNCAO_PERCURSOS INT
AS
SET NOCOUNT ON;
BEGIN
SELECT
FUNCAO_PERCURSOS.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
,FUNCAO_PERCURSOS.COD_PERCURSOS
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
,PERCURSOS.DESCRICAO
,PERCURSOS.CODIGO
,FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS
FROM FUNCAO_PERCURSOS FUNCAO_PERCURSOS
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
WHERE FUNCAO_PERCURSOS.FL_EXCLU=0
AND
[ID_FUNCAO_PERCURSOS] = @ID_FUNCAO_PERCURSOS
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_ID_FUNCAO]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCAO INT = NULL,
                                                                  @COD_APPS  INT
AS
  BEGIN
      SELECT DISTINCT FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,
                      FUNCAO_PERCURSOS.COD_FUNCAO,
                      FUNCAO.FUNCAO_NOME,
                      FUNCAO.CODIGO    AS CODIGO_FUNCAO,
                      FUNCAO_PERCURSOS.COD_PERCURSOS,
                      PERCURSOS.PERCURSOS_NOME,
                      PERCURSOS.CODIGO AS PERCURSOS_CODIGO
      FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
             INNER JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
             INNER JOIN PERCURSOS PERCURSOS
               ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
             INNER JOIN APPS APP
               ON APP.ID_APPS = PERCURSOS.COD_APPS
      WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
             AND FUNCAO_PERCURSOS.COD_FUNCAO = @ID_FUNCAO
             AND PERCURSOS.COD_APPS = @COD_APPS
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_ID_FUNCAO1]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCAO INT
AS
  BEGIN
      SELECT DISTINCT FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS,
                      FUNCAO_PERCURSOS.COD_FUNCAO,
                      FUNCAO.FUNCAO_NOME,
                      FUNCAO.CODIGO    AS CODIGO_FUNCAO,
                      FUNCAO_PERCURSOS.COD_PERCURSOS,
                      PERCURSOS.PERCURSOS_NOME,
                      PERCURSOS.CODIGO AS PERCURSOS_CODIGO
      FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
             INNER JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
             INNER JOIN PERCURSOS PERCURSOS
               ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
             INNER JOIN APPS APP
               ON APP.ID_APPS = PERCURSOS.COD_APPS
      WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
             AND FUNCAO_PERCURSOS.COD_FUNCAO = @ID_FUNCAO
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_INDEX]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCAO_PERCURSOS.COD_FUNCAO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             FUNCAO_PERCURSOS.COD_PERCURSOS,
             PERCURSOS.ID_PERCURSOS,
             PERCURSOS.PERCURSOS_NOME,
             PERCURSOS.DESCRICAO,
             PERCURSOS.CODIGO,
             FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS
      FROM   FUNCAO_PERCURSOS FUNCAO_PERCURSOS
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO
             LEFT JOIN PERCURSOS PERCURSOS
               ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS
      WHERE  FUNCAO_PERCURSOS.FL_EXCLU = 0
	  AND PERCURSOS.PERCURSOS_NOME <>''
  END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@UE_NOME NVARCHAR(100),
@DESCRICAO NVARCHAR(500) = NULL
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE UE
SET
[UE_NOME] = @UE_NOME,
[DESCRICAO] = @DESCRICAO
WHERE ID_UE = @ID_UE
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'UE','ALTERAR',@ID_UE ,NULL



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
FUNCAO_PERCURSOS.COD_FUNCAO
,FUNCAO.ID_FUNCAO
,FUNCAO.FUNCAO_NOME
,FUNCAO.CODIGO
,FUNCAO.COD_UE
,FUNCAO_PERCURSOS.COD_PERCURSOS
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
,PERCURSOS.DESCRICAO
,PERCURSOS.CODIGO
,FUNCAO_PERCURSOS.ID_FUNCAO_PERCURSOS
FROM FUNCAO_PERCURSOS FUNCAO_PERCURSOS
LEFT JOIN FUNCAO FUNCAO ON FUNCAO.ID_FUNCAO = FUNCAO_PERCURSOS.COD_FUNCAO AND FUNCAO.FL_EXCLU=0
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = FUNCAO_PERCURSOS.COD_PERCURSOS AND PERCURSOS.FL_EXCLU=0
WHERE FUNCAO_PERCURSOS.FL_EXCLU=0
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_UE)  FROM UE WHERE FL_EXCLU = 0
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_EXCLUIR]
@ID_FUNCAO_PERCURSOS INT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCAO_PERCURSOS
SET FL_EXCLU = 1 WHERE 
[ID_FUNCAO_PERCURSOS] = @ID_FUNCAO_PERCURSOS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCAO PERCURSOS','EXCLUIR',@ID_FUNCAO_PERCURSOS ,NULL



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_UE INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT UE.DESCRICAO,
             UE.ID_UE,
             UE.UE_NOME,
			 (SELECT COUNT(ID_FUNCAO) FROM FUNCAO WHERE COD_UE = UE.ID_UE AND FUNCAO.FL_EXCLU=0) AS TOTAL_FUNCOES
      FROM   UE UE
      WHERE  UE.FL_EXCLU = 0
             AND [ID_UE] = @ID_UE
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_IMPORTAR] @COD_FUNCAO         INT = NULL,
                                                       @APPS_NOME          NVARCHAR(100) = NULL,
                                                       @SIGLA_APP          NVARCHAR(100) = NULL,
                                                       @PERCURSOS_NOME     NVARCHAR(100) = NULL,






	@DT_ALT datetime2(7),	@ID                                                       @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID       NVARCHAR(100) = NULL,
                                                       @COD_LOG_UTILIZADOR INT = NULL
AS
  BEGIN
      EXEC PROC_APPS_INSERIR
        @APPS_NOME,
        @SIGLA_APP,
		0,
      DECLARE @COD_APPS INT = (SELECT TOP (1) ID_APPS FROM APPS WHERE
  APPS_NOME = @APPS_NOME AND SIGLA = @SIGLA_APP AND FL_EXCLU = 0)
      DECLARE @COD_PERCURSOS INT = (SELECT TOP(1) ID_PERCURSOS FROM PERCURSOS WHERE
  PERCURSOS_NOME = @PERCURSOS_NOME AND CODIGO = @ID_PERCURSO AND FL_EXCLU = 0)
      EXEC PROC_FUNCAO_PERCURSOS_INSERIR
        @COD_FUNCAO,
        @COD_PERCURSOS,
        @COD_LOG_UTILIZADOR
      EXEC PROC_PERCURSOS_INSERIR
        @PERCURSOS_NOME,
        '',
        @ID_PERCURSO,
        @COD_APPS,
        @COD_LOG_UTILIZADOR,
		0
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_CONSULTAR_INDEX]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT UE.DESCRICAO,
             UE.ID_UE,
             UE.UE_NOME,
			  (SELECT COUNT(ID_FUNCAO) FROM FUNCAO WHERE COD_UE = UE.ID_UE AND FUNCAO.FL_EXCLU = 0) AS TOTAL_FUNCOES
      FROM   UE UE
      WHERE  UE.FL_EXCLU = 0
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCAO_PERCURSOS_INSERIR] @COD_FUNCAO         INT = NULL,
                                                      @COD_PERCURSOS      INT = NULL,
                                                      @COD_LOG_UTILIZADOR INT
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   FUNCAO_PERCURSOS
                    WHERE  FL_EXCLU = 0
                           AND COD_FUNCAO = @COD_FUNCAO
                           AND COD_PERCURSOS = @COD_PERCURSOS
                           AND @COD_FUNCAO <> ''
                           AND @COD_PERCURSOS <> '')
        BEGIN
            INSERT INTO [DBO].[FUNCAO_PERCURSOS]
                        ([FL_EXCLU],
                         [COD_FUNCAO],
                         [COD_PERCURSOS])
            VALUES      ( 0,
                          @COD_FUNCAO,
                          @COD_PERCURSOS )
            SELECT MAX(ID_FUNCAO_PERCURSOS) AS IDENTITTY
            FROM   FUNCAO_PERCURSOS
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_FUNCAO_PERCURSOS) FROM
        FUNCAO_PERCURSOS)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'FUNCAO PERCURSOS',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
		ELSE
 BEGIN
    RAISERROR('ESTE REGISTO JÁ EXISTE!',16,1)
END
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
UE.DESCRICAO
,UE.ID_UE
,UE.UE_NOME
FROM UE UE
WHERE UE.FL_EXCLU=0
END



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_ALTERAR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO     INT,
                                                 @FUNCIONARIO_NOME   NVARCHAR(MAX),
                                                 @COD_FUNCAO         INT = NULL,
                                                 @COD_BALCAO         INT = NULL,
                                                 @COD_LOG_UTILIZADOR INT,
                                                 @NUMERO             NVARCHAR(MAX) = NULL,
                                                 @USUARIO            NVARCHAR(MAX) = NULL,
												 @EMAIL            NVARCHAR(MAX) = NULL,
												 @COD_GRUPO_RESPONSABILIDADE INT = NULL
AS
    IF( @FUNCIONARIO_NOME IS NOT NULL
        AND @FUNCIONARIO_NOME <> ''

          DECLARE @FUNCIONARIO_NOME_ANTES NVARCHAR(MAX) = (SELECT TOP(1) FUNCIONARIO_NOME FROM FUNCIONARIO WHERE
          IF( @FUNCIONARIO_NOME_ANTES <> @FUNCIONARIO_NOME )


                  FUNCIONARIO_NOME,
                  @FUNCIONARIO_NOME_ANTES,
                  @FUNCIONARIO_NOME,


    IF( @COD_FUNCAO IS NOT NULL
        AND @COD_FUNCAO <> '' )
          DECLARE @COD_FUNCAO_ANTES NVARCHAR(MAX) = (SELECT TOP(1) COD_FUNCAO FROM FUNCIONARIO WHERE
          IF( @COD_FUNCAO_ANTES <> @COD_FUNCAO )


                  COD_FUNCAO,
                  @COD_FUNCAO_ANTES,
                  @COD_FUNCAO,


    IF( @COD_BALCAO IS NOT NULL
        AND @COD_BALCAO <> '' )
          DECLARE @COD_BALCAO_ANTES NVARCHAR(MAX) = (SELECT TOP(1) COD_BALCAO FROM FUNCIONARIO WHERE
          IF( @COD_BALCAO_ANTES <> @COD_BALCAO )


                  COD_BALCAO,
                  @COD_BALCAO_ANTES,
                  @COD_BALCAO,


    IF( @NUMERO IS NOT NULL
        AND @NUMERO <> '' )
          DECLARE @NUMERO_ANTES NVARCHAR(MAX) = (SELECT TOP(1) NUMERO FROM FUNCIONARIO WHERE
      ID_FUNCIONARIO = @ID_FUNCIONARIO)
          IF( @NUMERO_ANTES <> @NUMERO )


                  NUMERO,
                  @NUMERO_ANTES,
                  @NUMERO,


    IF( @USUARIO IS NOT NULL
        AND @USUARIO <> '' )
          DECLARE @USUARIO_ANTES NVARCHAR(MAX) = (SELECT TOP(1) USUARIO FROM FUNCIONARIO WHERE
      USUARIO = @USUARIO)
          IF( @USUARIO_ANTES <> @USUARIO )


                  USUARIO,
                  @USUARIO_ANTES,
                  @USUARIO,


    IF( @EMAIL IS NOT NULL
        AND @EMAIL <> '' )
      BEGIN
          DECLARE @EMAIL_ANTES NVARCHAR(MAX) = (SELECT TOP(1) EMAIL FROM FUNCIONARIO WHERE
      EMAIL = @EMAIL)
          IF( @EMAIL_ANTES <> @EMAIL )
            BEGIN
                EXEC PROC_AUDIT_INSERIR
                  FUNCIONARIO,
                  EMAIL,
                  @EMAIL_ANTES,
                  @EMAIL,
                  @COD_LOG_UTILIZADOR
            END
      END
  ------=================================================================================================================
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_CONSULTAR_LISTA_HOME]
AS
BEGIN
SELECT UE.DESCRICAO,
             UE.ID_UE,
             UE.UE_NOME,
			 (SELECT COUNT(FP.ID_FUNCAO_PERCURSOS) FROM FUNCAO_PERCURSOS FP INNER JOIN FUNCAO F ON F.COD_UE = UE.ID_UE 
			 AND FP.COD_FUNCAO = F.ID_FUNCAO 
			 AND FP.FL_EXCLU =0 
			 AND F.FL_EXCLU =0
			 ) AS TOTAL_PERCURSOS
			 FROM   UE UE
      WHERE  UE.FL_EXCLU = 0
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PAISES_ALTERAR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@PAIS VARCHAR(30),
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM PAISES	WHERE ID_PAIS<>@ID_PAIS AND PAIS=@PAIS AND FL_EXCLU=0)
			UPDATE PAISES SET PAIS=@PAIS
			WHERE ID_PAIS=@ID_PAIS
			EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PAISES','ALTERAR',@ID_PAIS,NULL
	ELSE
		BEGIN
			RAISERROR('ESTE UTILIZADOR JÁ EXISTE!',16,1)
		END
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_FUNCIONARIO)  FROM FUNCIONARIO WHERE FL_EXCLU = 0
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE UE
SET FL_EXCLU = 1 WHERE 
[ID_UE] = @ID_UE
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'UE','EXCLUIR',@ID_UE ,NULL



SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PAISES_CONSULTA]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT * FROM PAISES
	WHERE FL_EXCLU=0 AND PAIS<>''
	ORDER BY PAIS ASC
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [dbo].[PROC_LOGIN_ERRO_AUTENTICAR] @EMAIL_USUARIO NVARCHAR(MAX),
                                                   @TIPO          NVARCHAR(1)
AS
  BEGIN
      DECLARE @COD_LOG_UTILIZADOR INT
      IF( @TIPO = '1' )


                                      WHERE  EMAIL = @EMAIL_USUARIO

      IF( @TIPO = '2' )
            SET @COD_LOG_UTILIZADOR= (SELECT TOP(1) ID_UTILIZADOR
                                      FROM   UTILIZADORES
                                      WHERE  USUARIO_DOMINIO = @EMAIL_USUARIO
                                             AND FL_EXCLU = 0)
      IF( @COD_LOG_UTILIZADOR IS NOT NULL
          AND @COD_LOG_UTILIZADOR <> '' )
        BEGIN
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'LOGIN',
              'ERRO DE AUTENTICAÇÃO',
              NULL,
              NULL
        END
  END
SET ANSI_NULLS ON 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PAISES_EXCLUIR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	SET NOCOUNT ON;
			UPDATE PAISES SET FL_EXCLU=1
			WHERE ID_PAIS=@ID_PAIS
		EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PAISES','EXCLUIR',@ID_PAIS,NULL
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UE_INSERIR] @UE_NOME            NVARCHAR(100),
                                        @DESCRICAO          NVARCHAR(500) = NULL,
                                        @COD_LOG_UTILIZADOR INT,
										@TIPO INT = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   UE
                    WHERE  UE_NOME = @UE_NOME
                           AND FL_EXCLU = 0
                           AND DESCRICAO = @DESCRICAO)
        BEGIN
            INSERT INTO [DBO].[UE]
                        ([UE_NOME],
                         [FL_EXCLU],
                         [DESCRICAO])
            VALUES      ( @UE_NOME,
                          0,
                          @DESCRICAO )
            SELECT MAX(ID_UE) AS IDENTITTY
            FROM   UE
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_UE) FROM
        UE)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'UE',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
		ELSE
		IF(@TIPO=1)
		BEGIN
		RAISERROR('JÁ EXISTE UM CENTRO DE CUSTOS COM ESTES DADOS!',16,1)
		END
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PAISES_INSERIR]
	@PAIS VARCHAR(30),
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
	--DECLARE @SQL VARCHAR(MAX)
	IF NOT EXISTS(SELECT * FROM PAISES	WHERE PAIS=@PAIS AND FL_EXCLU=0)
			INSERT INTO [DBO].[PAISES]
        	([PAIS]
    	,[FL_EXCLU])
			VALUES
        	(@PAIS
    	,0)
           DECLARE @IDENTITTY INT = (SELECT MAX(ID_PAIS) FROM PAISES)
		   EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PAISES','INSERIR',NULL,NULL
	ELSE
		BEGIN
			RAISERROR('ESTE PAÍS JÁ EXISTE!',16,1)			
		END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,P.,P.NAME>
-- ALTER DATE: <ALTER DATE,P.,P.>
-- DESCRIPTION:	<DESCRIPTION,P.,P.>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_CONSULTA]
AS
BEGIN
   SET NOCOUNT ON;
   SELECT 
      P.[ID_PARAMETRO]
	 ,P.[SMTP_EMAIL_REMETENTE]
	 ,P.[SMTP_EMAIL_PASSWORD]
     ,P.[SMTP_SERVER]
	 ,P.[SMTP_PORT]   
	 ,P.[SAUDACAO]
	 ,E.NM_FANTA 
	FROM PARAMETROS P
	LEFT OUTER  JOIN EMPRESA E ON E.FL_EXCLU = 0
	WHERE P.FL_EXCLU=0 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_FILTROS] @STR_ID_FUNCIONARIO          NVARCHAR(MAX) = NULL,
                                                           @COD_FUNCAO                  NVARCHAR(MAX) = NULL,
                                                           @FUNCAO_NOME                 NVARCHAR(MAX) = NULL,
                                                           @NUMERO                      NVARCHAR(MAX) = NULL,
                                                           @COD_BALCAO                  NVARCHAR(MAX) = NULL,
                                                           @BALCAO_NOME                 NVARCHAR(MAX) = NULL,
                                                           @USUARIO                     NVARCHAR(MAX) = NULL,
														    @EMAIL                     NVARCHAR(MAX) = NULL,
                                                           @COD_GRUPO_RESPONSABILIDADE  NVARCHAR(MAX) = NULL,
                                                           @GRUPO_RESPONSABILIDADE_NOME NVARCHAR(MAX) = NULL,
														   @COD_PERCURSO NVARCHAR(MAX) = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + ' 
	  SELECT
	  FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_FUNCAO,
			  FUNCIONARIO.USUARIO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             FUNCIONARIO.COD_BALCAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
             BALCAO.DESCRICAO                    AS B_DESCRICAO,
             FUNCIONARIO.FUNCIONARIO_NOME,
			 FUNCIONARIO.EMAIL,
             FUNCIONARIO.ID_FUNCIONARIO,
              (SELECT COUNT(DISTINCT P.COD_APPS)


              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND P.PERCURSOS_NOME <> '''')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCIONARIO.COD_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '''') AS TOTAL_PERCURSOS,
					 FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
					 GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
      FROM   FUNCIONARIO FUNCIONARIO
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO
             LEFT JOIN BALCAO BALCAO
               ON BALCAO.ID_BALCAO = FUNCIONARIO.COD_BALCAO
			    LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
               ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE			
			   LEFT JOIN PERCURSOS_FUNCIONARIO PF ON PF.COD_FUNCIONARIO = FUNCIONARIO.ID_FUNCIONARIO AND PF.FL_EXCLU= 0
      WHERE  FUNCIONARIO.FL_EXCLU = 0
	  '
      IF @STR_ID_FUNCIONARIO IS NOT NULL
         AND @STR_ID_FUNCIONARIO <> ''
            SET @SQL=@SQL + ' AND FUNCIONARIO.ID_FUNCIONARIO = ''' + @STR_ID_FUNCIONARIO + ''''
      IF @COD_FUNCAO IS NOT NULL
         AND @COD_FUNCAO <> ''
            SET @SQL=@SQL + ' AND FUNCIONARIO.COD_FUNCAO = ''' + @COD_FUNCAO + ''''
      IF @FUNCAO_NOME IS NOT NULL
         AND @FUNCAO_NOME <> ''
            SET @SQL=@SQL + ' AND FUNCAO.FUNCAO_NOME LIKE ''%' + @FUNCAO_NOME + '%'''
      IF @NUMERO IS NOT NULL
         AND @NUMERO <> ''
            SET @SQL=@SQL + ' AND FUNCIONARIO.NUMERO = ''' + @NUMERO + ''''
        END
      IF @COD_BALCAO IS NOT NULL
         AND @COD_BALCAO <> ''
        BEGIN
            SET @SQL=@SQL + ' A
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_APPS_COM_AUTORIDADES_CONSULTAR]
AS
  BEGIN
      SELECT DISTINCT APPS.ID_APPS,
                      APPS.APPS_NOME,
                      APPS.DESCRICAO,
                      APPS.SIGLA
      FROM   APPS APPS 
      WHERE  APPS.FL_EXCLU = 0
             AND APPS.FL_CONTEMPLA_AUTORIDADES = 1
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_INSERIR_ALTERAR]
	  @SMTP_SERVER NVARCHAR(50) =NULL,
   	  @SMTP_PORT NVARCHAR(50) =NULL,
   	  @SMTP_EMAIL_REMETENTE NVARCHAR(50) =NULL,
   	  @SMTP_EMAIL_PASSWORD NVARCHAR(50) =NULL,	  	
	  @COD_LOG_UTILIZADOR INT	=NULL,
	  @SAUDACAO NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	  DECLARE @ID_PARAMETRO_1 INT = NULL
	IF  EXISTS(SELECT * FROM PARAMETROS	WHERE 





		SET @ID_PARAMETRO_1 = (
		SELECT ID_PARAMETRO FROM PARAMETROS 	WHERE 
		[SMTP_SERVER]=@SMTP_SERVER 
		AND SMTP_EMAIL_REMETENTE = @SMTP_EMAIL_REMETENTE
		AND SMTP_PORT=@SMTP_PORT 
		AND SAUDACAO = @SAUDACAO
	)


      UPDATE [DBO].[PARAMETROS]
		FL_EXCLU= 0	WHERE ID_PARAMETRO = @ID_PARAMETRO_1
	ELSE
	BEGIN
	  UPDATE [DBO].[PARAMETROS]
      SET 
		FL_EXCLU= 1 
		IF(@SMTP_EMAIL_PASSWORD <> '')



















	  ELSE
	  BEGIN
	  DECLARE @LAST_PASSWORD NVARCHAR(MAX) = (SELECT @SMTP_EMAIL_PASSWORD FROM PARAMETROS	WHERE FL_EXCLU=0)
		INSERT INTO [DBO].[PARAMETROS]
		[SMTP_SERVER]
		,SMTP_PORT
		,SMTP_EMAIL_REMETENTE
		,SMTP_EMAIL_PASSWORD
		,SAUDACAO 
		,FL_EXCLU
		)
		VALUES
		(
		  @SMTP_SERVER,
		  @SMTP_PORT,
		  @SMTP_EMAIL_REMETENTE,
		  @SMTP_EMAIL_PASSWORD,
		  @SAUDACAO,
		  0
	  )
	  END
	END
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_FUNCIONARIO INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_FUNCAO,
             FUNCIONARIO.USUARIO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             FUNCIONARIO.COD_BALCAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
             UE.DESCRICAO                        AS UE_DESCRICAO,
             BALCAO.DESCRICAO                    AS B_DESCRICAO,
             FUNCIONARIO.FUNCIONARIO_NOME,
			  FUNCIONARIO.EMAIL,
             FUNCIONARIO.ID_FUNCIONARIO,
             (SELECT COUNT(DISTINCT P.COD_APPS)


              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCIONARIO.COD_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_PERCURSOS,
             FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
             GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
      FROM   FUNCIONARIO FUNCIONARIO
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO
             LEFT JOIN BALCAO BALCAO
               ON BALCAO.ID_BALCAO = FUNCIONARIO.COD_BALCAO
             LEFT JOIN UE UE
               ON UE.ID_UE = FUNCAO.COD_UE
             LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
               ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
      WHERE  FUNCIONARIO.FL_EXCLU = 0
             AND [ID_FUNCIONARIO] = @ID_FUNCIONARIO
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_MODELO_EMAIL_ALTERAR]






	@DT_ALT datetime2(7),	@ID	  @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	  @CABEÇALHO NVARCHAR(MAX) =NULL,
   	  @EMAIL_COPIA NVARCHAR(MAX) =NULL,
	  @COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	SET NOCOUNT ON;
	  UPDATE [DBO].[PARAMETROS_MODELOS_EMAIL]
      SET 
	  MODELO = @CABEÇALHO
	 	WHERE ID_MODELO=@ID_MODELO AND FL_EXCLU=0
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_INDEX]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_FUNCAO,
             FUNCIONARIO.USUARIO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             FUNCIONARIO.COD_BALCAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
             BALCAO.DESCRICAO                    AS B_DESCRICAO,
             FUNCIONARIO.FUNCIONARIO_NOME,
			  FUNCIONARIO.EMAIL,
             FUNCIONARIO.ID_FUNCIONARIO,
             (SELECT COUNT(DISTINCT P.COD_APPS)


              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCIONARIO.COD_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_PERCURSOS,
					 FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE,
					 GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
      FROM   FUNCIONARIO FUNCIONARIO
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO
             LEFT JOIN BALCAO BALCAO
               ON BALCAO.ID_BALCAO = FUNCIONARIO.COD_BALCAO
			    LEFT JOIN GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
               ON GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE = FUNCIONARIO.COD_GRUPO_RESPONSABILIDADE
      WHERE  FUNCIONARIO.FL_EXCLU = 0
      ORDER  BY FUNCIONARIO.FUNCIONARIO_NOME,
                FUNCAO.FUNCAO_NOME,
                BALCAO.NM_BALCAO
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_MODELO_EMAIL_CONSULTA]
AS
BEGIN
   SET NOCOUNT ON;
   SELECT 
      ME.[ID_MODELO]
	, ME.[IDD_MODELO]
    , ME.[MODELO]
    , ME.[DESCRICAO_TO]
	, ME.[DESCRICAO_CC]
    , ME.[EMAIL_TO]
    , ME.[EMAIL_CC]
	,P.SMTP_EMAIL_REMETENTE
	FROM PARAMETROS_MODELOS_EMAIL ME
	LEFT OUTER JOIN PARAMETROS P ON P.SMTP_EMAIL_REMETENTE <> ''
	WHERE ME.FL_EXCLU=0 AND P.FL_EXCLU =0 
	ORDER BY IDD_MODELO ASC
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


 -- AUTHOR:		<AUTHOR,,NAME>
 -- ALTER DATE: <ALTER DATE,,>
 -- DESCRIPTION:	<DESCRIPTION,,>
 -- =============================================
 
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_MODELO_EMAIL_CONSULTA_ID]






	@DT_ALT datetime2(7),	@ID 	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
 AS
 BEGIN
    SET NOCOUNT ON;
    SELECT 
     ME.[ID_MODELO]
 	,ME.[IDD_MODELO]
    ,ME.[MODELO]
    ,ME.[DESCRICAO_TO]
 	,ME.[DESCRICAO_CC]
    ,ME.[EMAIL_TO]
    ,ME.[EMAIL_CC]
 	,P.[SAUDACAO]
 	,E.[NM_FANTA]
 	,P.SMTP_EMAIL_REMETENTE 		
	FROM PARAMETROS_MODELOS_EMAIL ME 
 	LEFT OUTER JOIN PARAMETROS P ON P.SMTP_EMAIL_REMETENTE <> ''
 	LEFT OUTER JOIN EMPRESA E ON E.FL_EXCLU=0 
 	WHERE ME.FL_EXCLU=0 AND P.FL_EXCLU =0 AND ID_MODELO = @ID_MODELO
 	ORDER BY MODELO ASC
 END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_INDEX__ID_FUNCAO]
@COD_FUNCAO INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_FUNCAO,
			  FUNCIONARIO.USUARIO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             FUNCIONARIO.COD_BALCAO,
             BALCAO.ID_BALCAO,
             BALCAO.NM_BALCAO,
             BALCAO.DESCRICAO                    AS B_DESCRICAO,
             FUNCIONARIO.FUNCIONARIO_NOME,
             FUNCIONARIO.ID_FUNCIONARIO,
			  FUNCIONARIO.EMAIL,
             (SELECT COUNT(DISTINCT P.COD_APPS)


              WHERE  FPP.COD_FUNCAO = FUNCAO.ID_FUNCAO
                     AND P.PERCURSOS_NOME <> '')   AS TOTAL_ACESSOS,
             (SELECT COUNT(COD_PERCURSOS)
              FROM   FUNCAO_PERCURSOS FPP
                     INNER JOIN PERCURSOS P
                       ON P.ID_PERCURSOS = FPP.COD_PERCURSOS
              WHERE  FPP.COD_FUNCAO = FUNCIONARIO.COD_FUNCAO
                     AND FPP.FL_EXCLU = 0
                     AND P.PERCURSOS_NOME <> '') AS TOTAL_PERCURSOS
      FROM   FUNCIONARIO FUNCIONARIO
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO
             LEFT JOIN BALCAO BALCAO
               ON BALCAO.ID_BALCAO = FUNCIONARIO.COD_BALCAO
      WHERE  FUNCIONARIO.FL_EXCLU = 0
	  AND FUNCIONARIO.COD_FUNCAO = @COD_FUNCAO
      ORDER  BY FUNCIONARIO.FUNCIONARIO_NOME,
                FUNCAO.FUNCAO_NOME,
                BALCAO.NM_BALCAO
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_MODELO_EMAIL_INSERIR_EMAIL_CC]






	@DT_ALT datetime2(7),	@ID	  @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
   	@EMAIL_COPIA NVARCHAR(MAX),
	  @COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	  SET NOCOUNT ON;		
	  UPDATE [DBO].[PARAMETROS_MODELOS_EMAIL]
      SET 
	  EMAIL_CC = @EMAIL_COPIA
	 	WHERE ID_MODELO=@ID_MODELO AND FL_EXCLU=0 AND ID_MODELO = @ID_MODELO
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_CONSULTAR_LISTA_DROP]
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_FUNCAO,
			 FUNCIONARIO.USUARIO,
             FUNCAO.ID_FUNCAO,
             FUNCAO.FUNCAO_NOME,
             FUNCAO.CODIGO,
             FUNCAO.COD_UE,
             BALCAO.ID_BALCAO,
             FUNCIONARIO.COD_BALCAO,
             BALCAO.NM_BALCAO,
             BALCAO.DESCRICAO AS B_DESCRICAO,
             FUNCIONARIO.FUNCIONARIO_NOME,
			  FUNCIONARIO.EMAIL,
             FUNCIONARIO.ID_FUNCIONARIO
      FROM   FUNCIONARIO FUNCIONARIO
             LEFT JOIN FUNCAO FUNCAO
               ON FUNCAO.ID_FUNCAO = FUNCIONARIO.COD_FUNCAO
                  AND FUNCAO.FL_EXCLU = 0
             LEFT JOIN BALCAO BALCAO
               ON BALCAO.ID_BALCAO = FUNCIONARIO.COD_BALCAO
      WHERE  FUNCIONARIO.FL_EXCLU = 0
      ORDER  BY FUNCIONARIO.FUNCIONARIO_NOME
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,P.,P.NAME>
-- ALTER DATE: <ALTER DATE,P.,P.>
-- DESCRIPTION:	<DESCRIPTION,P.,P.>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETRO_PLATAFORMA_CONSULTA]
AS
BEGIN
   SET NOCOUNT ON;
   SELECT 
      P.[ID_PARAMETRO_DA_PLATAFORMA]  
	 ,P.[SAUDACAO] 
	FROM PARAMETROS_DA_PLATAFORMA P
	WHERE P.FL_EXCLU=0 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE FUNCIONARIO
SET FL_EXCLU = 1 WHERE 
[ID_FUNCIONARIO] = @ID_FUNCIONARIO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'FUNCIONARIO','EXCLUIR',@ID_FUNCIONARIO ,NULL
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_ALTERAR]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_UTILIZADOR       INT,
                                                  @UTILIZADOR          VARCHAR(30),
                                                  @EMAIL               VARCHAR(60),
                                                  @PASSWORD            VARCHAR(200)=NULL,
                                                  @BLOQUEADO           BIT,
                                                  @COD_NIVEL_ITEM      INT = NULL,
                                                  @FL_ADMIN_PLATAFORMA BIT=NULL,
                                                  @COD_GRUPO           INT=NULL,
                                                  @BT_IMAGEM           VARBINARY(MAX)=NULL,
                                                  @COD_LOG_UTILIZADOR  INT =NULL,
                                                  @USUARIO_DOMINIO     VARCHAR(30) = NULL
AS
  BEGIN
      IF( @USUARIO_DOMINIO IS NOT NULL AND @USUARIO_DOMINIO <> '' AND EXISTS(SELECT * FROM   UTILIZADORES WHERE  USUARIO_DOMINIO = @USUARIO_DOMINIO AND ID_UTILIZADOR <> @ID_UTILIZADOR))
        BEGIN
           RAISERROR('ESTE UTILIZADOR DO DOMÍNIO JÁ EXISTE!',16,1)
      ELSE
        BEGIN   
			  IF NOT EXISTS(SELECT *
                          FROM   UTILIZADORES
                          WHERE  ID_UTILIZADOR != @ID_UTILIZADOR
                                 AND EMAIL = @EMAIL)
                  IF @PASSWORD IS NOT NULL
                     AND @PASSWORD <> ''


						USUARIO_DOMINIO =@USUARIO_DOMINIO,
                               BLOQUEADO = @BLOQUEADO,
                               PALAVRA_PASSE = @PASSWORD,
                               PASS_TEMP = @PASSWORD,

                               FL_ADMIN_PLATA = @FL_ADMIN_PLATAFORMA


                  ELSE

                        SET    UTILIZADOR = @UTILIZADOR,
						USUARIO_DOMINIO = @USUARIO_DOMINIO,
                               EMAIL = @EMAIL,
                               COD_NIVEL_ITEM = @COD_NIVEL_ITEM,
                               COD_GRUPO = @COD_GRUPO,
                               FL_ADMIN_PLATA = @FL_ADMIN_PLATAFORMA,
                               BLOQUEADO = @BLOQUEADO


                  IF @BT_IMAGEM IS NOT NULL
                     AND @BT_IMAGEM <> ''
                    BEGIN
                        UPDATE [DBO].[UTILIZADORES]
                        SET    BT_IMAGEM = @BT_IMAGEM
                        WHERE  ID_UTILIZADOR = @ID_UTILIZADOR
                               AND FL_EXCLU = 0
                    END
                  EXEC PROC_LOGS_INSERIR
                    @COD_LOG_UTILIZADOR,
                    'UTILIZADORES',
                    'ALTERAR',
                    @ID_UTILIZADOR,
                    NULL
                  EXEC PROC_NIVEL_ITEM_ACTUALIZAR
            ELSE
              BEGIN
                  RAISERROR('ESTE EMAIL JÁ EXISTE EM UMA OUTRA CONTA!',16,1)
              END
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETROS_EMAIL_SENDER_CONSULTA]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@EMAIL_ACCAO NVARCHAR(50)
AS
BEGIN
   SET NOCOUNT ON;
   SELECT 
      P.[ID_PARAMETRO]
	 ,P.[SMTP_EMAIL_REMETENTE]
     ,P.[SMTP_SERVER]
	 ,P.[SMTP_PORT]
     ,P.[SMTP_EMAIL_PASSWORD]
	 ,P.[SAUDACAO] 
	 ,ME.MODELO
	 ,ME.DESCRICAO_TO
	 ,ME.DESCRICAO_CC
	 ,ME.EMAIL_CC
	 ,U.UTILIZADOR
	 ,E.NM_FANTA
	FROM PARAMETROS P
	LEFT OUTER  JOIN PARAMETROS_MODELOS_DE_EMAIL ME ON ME.IDD_MODELO = @ID_MODELO
	LEFT OUTER  JOIN UTILIZADORES U ON U.EMAIL = @EMAIL_ACCAO
	LEFT OUTER  JOIN EMPRESA E ON E.FL_EXCLU = 0
	WHERE P.FL_EXCLU=0 
	ORDER BY MODELO ASC
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_IMPORTAR] @FUNCIONARIO_NOME   NVARCHAR(MAX),
                                                  @FUNCAO_NOME        NVARCHAR(MAX),
                                                  @CODIGO             NVARCHAR(50),
                                                  @UE_NOME            NVARCHAR(MAX) = NULL,
                                                  @UE_DESCRICAO       NVARCHAR(MAX) = NULL,
                                                  @BALCAO             NVARCHAR(MAX),
                                                  @NUMERO             NVARCHAR(MAX) = NULL,
                                                  @COD_LOG_UTILIZADOR INT,
                                                  @USUARIO            NVARCHAR(MAX) = NULL,
												   @EMAIL            NVARCHAR(MAX) = NULL
AS
  BEGIN
      IF( @BALCAO <> '' )
        BEGIN
            EXEC PROC_BALCAO_INSERIR
              @BALCAO,
              '',
              @COD_LOG_UTILIZADOR
        END
      DECLARE @COD_UE INT = (SELECT TOP (1) ID_UE FROM UE WHERE
  DESCRICAO = @UE_DESCRICAO AND FL_EXCLU = 0)
      DECLARE @COD_FUNCAO INT = ( SELECT TOP (1) ID_FUNCAO FROM FUNCAO WHERE
  FUNCAO_NOME=@FUNCAO_NOME AND COD_UE=@COD_UE AND @FUNCAO_NOME <> '' AND FL_EXCLU= 0)
      DECLARE @COD_BALCAO INT = ( SELECT TOP (1) ID_BALCAO FROM BALCAO WHERE
  NM_BALCAO=@BALCAO AND @BALCAO <> '' AND FL_EXCLU = 0)
      EXEC PROC_FUNCIONARIO_INSERIR
	  @FUNCIONARIO_NOME           ,
                                                 @COD_FUNCAO                 ,
                                                 @COD_LOG_UTILIZADOR         ,
                                                 @COD_BALCAO                 ,
                                                 @NUMERO                     ,
                                                 @USUARIO                    ,
												 @EMAIL,
                                                 NULL 
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_ALTERAR_PASS]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_UTILIZADOR      INT,
                                                       @UTILIZADOR         VARCHAR(50),
                                                       @EMAIL              VARCHAR(60),
                                                       @PASSWORD           VARCHAR(MAX),
                                                       @BT_IMAGEM          VARBINARY(MAX)=NULL,
                                                       @COD_LOG_UTILIZADOR INT =NULL
AS
  BEGIN
      SET NOCOUNT ON;
      DECLARE @TEMP VARCHAR(MAX)
      SELECT @TEMP = PASS_TEMP
      FROM   UTILIZADORES
      IF NOT EXISTS(SELECT *
                    FROM   UTILIZADORES
                    WHERE  ID_UTILIZADOR != @ID_UTILIZADOR
                           AND EMAIL = @EMAIL)
            IF @PASSWORD != ''
               AND @PASSWORD IS NOT NULL


                         EMAIL = @EMAIL,
                         PALAVRA_PASSE = @PASSWORD,
                         PASS_TEMP = NULL

            ELSE

                  SET    UTILIZADOR = @UTILIZADOR,
                         EMAIL = @EMAIL

            IF @BT_IMAGEM IS NOT NULL
               AND @BT_IMAGEM <> ''
              BEGIN
                  UPDATE [DBO].[UTILIZADORES]
                  SET    BT_IMAGEM = @BT_IMAGEM
                  WHERE  ID_UTILIZADOR = @ID_UTILIZADOR
                         AND FL_EXCLU = 0
              END
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'UTILIZADORES',
              'ALTERAR - MEU CADASTRO',
              @ID_UTILIZADOR,
              NULL
      ELSE
        BEGIN
            RAISERROR('ESTE EMAIL JÁ EXISTE EM UMA OUTRA CONTA!',16,1)
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETROS_EMAIL_SENDER_CONSULTA_NOME_CC]
	@EMAIL_CC NVARCHAR(50)
AS
BEGIN
   SET NOCOUNT ON;
 	IF(EXISTS (SELECT UTILIZADOR FROM UTILIZADORES	WHERE EMAIL = @EMAIL_CC AND FL_EXCLU=0))
       DECLARE @UTILIZADOR NVARCHAR(100) = (SELECT UTILIZADOR FROM UTILIZADORES	WHERE EMAIL = @EMAIL_CC AND FL_EXCLU=0)
	SELECT @UTILIZADOR AS RETURNCODE
   ELSE
   BEGIN
	SELECT 'SR (A)' AS RETURNCODE
   END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:    <AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:  <DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_CONSULTA]
AS
  BEGIN
      -- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
      -- INTERFERING  WITH SELECT STATEMENTS.
      SET NOCOUNT ON;
      -- INSERT STATEMENTS FOR PROCEDURE HERE
      SELECT ID_UTILIZADOR,
             U.EMAIL,
             U.UTILIZADOR,
 U.USUARIO_DOMINIO,
             U.BLOQUEADO,
             U.BT_IMAGEM,
             N.DS_PESQUISA,
             N.ID_NIVEL_ITEM,
             N.NM_NIVEL_ITEM,
             ISNULL(U.FL_ADMIN_PLATA, 0) FL_ADMIN_PLATA,
             CASE
               WHEN U.COD_GRUPO IS NULL
                    AND U.FL_ADMIN_PLATA = 1 THEN ''
               WHEN U.COD_GRUPO IS NOT NULL
                    AND U.FL_ADMIN_PLATA = 0 THEN G.GRUPO_NOME
             END                         AS GRUPO_NOME,
             U.COD_GRUPO
      FROM   UTILIZADORES U
             LEFT OUTER JOIN NIVEL_ITEM N
               ON U.COD_NIVEL_ITEM = N.ID_NIVEL_ITEM
             LEFT OUTER JOIN DBO.GRUPOS G
               ON G.ID_GRUPO = U.COD_GRUPO
      WHERE  U.FL_EXCLU = 0
             AND U.UTILIZADOR <> ''
      ORDER  BY U.UTILIZADOR ASC
  END

SET ANSI_NULLS ON 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_FUNCIONARIO_INSERIR] @FUNCIONARIO_NOME           NVARCHAR(MAX),
                                                 @COD_FUNCAO                 INT = NULL,
                                                 @COD_LOG_UTILIZADOR         INT,
                                                 @COD_BALCAO                 INT = NULL,
                                                 @NUMERO                     NVARCHAR(MAX) = NULL,
                                                 @USUARIO                    NVARCHAR(MAX) = NULL,
												 @EMAIL                    NVARCHAR(MAX) = NULL,
                                                 @COD_GRUPO_RESPONSABILIDADE INT = NULL
AS
BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   FUNCIONARIO
                    WHERE  FUNCIONARIO_NOME = @FUNCIONARIO_NOME                          
                           AND COD_FUNCAO = @COD_FUNCAO
                           AND COD_BALCAO = @COD_BALCAO
                           AND NUMERO = @NUMERO
                           --AND USUARIO = @USUARIO
						   AND EMAIL = @EMAIL
						   AND FL_EXCLU = 0
						   )
        BEGIN
            INSERT INTO [DBO].[FUNCIONARIO]
                        ([FUNCIONARIO_NOME],
                         [FL_EXCLU],
                         [COD_FUNCAO],
                         [COD_BALCAO],
                         [USUARIO],
                         [NUMERO],
						 [EMAIL],
                         [COD_GRUPO_RESPONSABILIDADE])
            VALUES      ( @FUNCIONARIO_NOME,
                          0,
                          @COD_FUNCAO,
                          @COD_BALCAO,
                          @USUARIO,
                          @NUMERO,
						  @EMAIL,
                          @COD_GRUPO_RESPONSABILIDADE )
            SELECT MAX(ID_FUNCIONARIO) AS IDENTITTY
            FROM   FUNCIONARIO
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_FUNCIONARIO) FROM FUNCIONARIO)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'FUNCIONARIO',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
		ELSE
		BEGIN
		RAISERROR('JÁ EXISTE UM FUNCIONÁRIO COM ESTES DADOS!',16,1)
		END
  END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_CONSULTA_COUNT]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT COUNT(*) FROM UTILIZADORES
	WHERE FL_EXCLU=0 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PARAMETROS_GESTAO_DE_EMAIL_INSERIR] @EMAIL_DESTINATARIO NVARCHAR(100),
                                                                @ASSUNTO            NVARCHAR(100),
                                                                @DESCRICAO          NVARCHAR(MAX) = NULL,
																@DESCRICAO_ERRO          NVARCHAR(MAX) = NULL,
                                                                @DT_ENVIO           DATETIME = NULL,
                                                                @ESTADO             BIT
AS
  BEGIN
      INSERT INTO [DBO].[PARAMETROS_GESTAO_EMAIL]
                  (EMAIL_DESTINATARIO,
                   ASSUNTO,
                   ESTADO,
                   DESCRICAO,
				   DESCRICAO_ERRO,
                   DT_ENVIO,
                   DT_CADASTRO,
                   FL_EXCLU)
      VALUES      ( @EMAIL_DESTINATARIO,
                    @ASSUNTO,
                    @ESTADO,
                    @DESCRICAO,
					@DESCRICAO_ERRO,
                    @DT_ENVIO,
                    GETDATE(),
                    0 )
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_CONSULTA_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_UTILIZADOR INT
AS
  BEGIN
      SELECT U.ID_UTILIZADOR,
             U.EMAIL,
             U.UTILIZADOR,
             U.BLOQUEADO,
             U.BT_IMAGEM,
             U.PASS_TEMP,
			 U.USUARIO_DOMINIO,
             N.ID_NIVEL_ITEM,
             N.NM_NIVEL_ITEM,
             N.DS_PESQUISA,
             ISNULL(U.COD_GRUPO, 0)      COD_GRUPO,
             ISNULL(G.GRUPO_NOME, '')    GRUPO_NOME,
             ISNULL(U.FL_ADMIN_PLATA, 0) FL_ADMIN_PLATA
      FROM   UTILIZADORES U
             LEFT OUTER JOIN NIVEL_ITEM N
               ON U.COD_NIVEL_ITEM = N.ID_NIVEL_ITEM
             LEFT OUTER JOIN DBO.GRUPOS G
               ON G.ID_GRUPO = U.COD_GRUPO
      WHERE  U.FL_EXCLU = 0
             AND ID_UTILIZADOR = @ID_UTILIZADOR
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_EXCLUIR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
	UPDATE [DBO].[UTILIZADORES] SET FL_EXCLU=1
	WHERE ID_UTILIZADOR=@ID_UTILIZADOR
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'UTILIZADORES','EXCLUIR',@ID_UTILIZADOR,NULL
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_INSERIR] @UTILIZADOR          VARCHAR(20),
                                                  @EMAIL               VARCHAR(60),
                                                  @BLOQUEADO           BIT,
                                                  @FL_ADMIN_PLATAFORMA BIT=NULL,
                                                  @COD_GRUPO           INT=NULL,
                                                  @BT_IMAGEM           VARBINARY(MAX)=NULL,
                                                  @COD_NIVEL_ITEM      INT=NULL,
                                                  @COD_LOG_UTILIZADOR  INT =NULL,
                                                  @SENHA_PADRAO        NVARCHAR(100),
                                                  @USUARIO_DOMINIO     VARCHAR(20) = NULL
AS
  BEGIN
      SET NOCOUNT ON;
      --DECLARE @COD_NIVEL_ITEM INT	
      DECLARE @PASS_TEMP VARCHAR (200)
      SELECT @PASS_TEMP = DS_SMTP_SENHA
      FROM   DBO.EMPRESA E
      WHERE  E.FL_EXCLU = 0
 IF( @USUARIO_DOMINIO IS NOT NULL AND @USUARIO_DOMINIO <> '' AND EXISTS(SELECT * FROM   UTILIZADORES WHERE  USUARIO_DOMINIO = @USUARIO_DOMINIO))
        BEGIN
           RAISERROR('ESTE UTILIZADOR DO DOMÍNIO JÁ EXISTE!',16,1)
        END
      ELSE
      BEGIN
            IF NOT EXISTS(SELECT *
                          FROM   UTILIZADORES
                          WHERE  EMAIL = @EMAIL)
                  IF NOT EXISTS(SELECT *
                                FROM   UTILIZADORES
                                WHERE  UTILIZADOR = @UTILIZADOR
                                       AND EMAIL = @EMAIL
                                       AND BT_IMAGEM = @BT_IMAGEM
                                       AND BLOQUEADO = @BLOQUEADO)
                        INSERT INTO [DBO].[UTILIZADORES]
                                    ([UTILIZADOR],
                                     [EMAIL],
                                     [BLOQUEADO],
                                     [FL_EXCLU],
                                     [PASS_TEMP],
                                     [PALAVRA_PASSE],
                                     [COD_NIVEL_ITEM],
                                     [COD_GRUPO],
                                     [FL_ADMIN_PLATA],
                                     [BT_IMAGEM],
                                     [USUARIO_DOMINIO])
                        VALUES      (@UTILIZADOR,
                                     @EMAIL,
                                     @BLOQUEADO,
                                     0
                                     --SENHA TEMPORÁRIA PARA O NOVO UTILIZADOR = 654321
                                     ,
                                     @SENHA_PADRAO,
                                     @COD_NIVEL_ITEM,
                                     @COD_GRUPO,
                                     @FL_ADMIN_PLATAFORMA,
                                     @BT_IMAGEM,
                                     @USUARIO_DOMINIO )
                        DECLARE @IDENTITTY INT = (SELECT MAX(ID_UTILIZADOR) FROM
                    UTILIZADORES)
                        EXEC PROC_LOGS_INSERIR
                          @COD_LOG_UTILIZADOR,
                          'UTILIZADORES',
                          'INSERIR',
                          @IDENTITTY,
                          NULL
                  ELSE
                    BEGIN
                        RAISERROR('ESTE UTILIZADOR JÁ EXISTE!',16,1)
                    END
              END
            ELSE
              BEGIN
             
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_UTILIZADORES_INSERIR_ENTIDADES]
  -- GRUPO DE UTILIZADORES
  @GRUPO_NOME         VARCHAR(20),
  @DESCRICAO_GRUPO    VARCHAR(60),
  @COD_LOG_UTILIZADOR INT = NULL
AS
  BEGIN
      SET NOCOUNT ON;
      --DECLARE @COD_NIVEL_ITEM INT  
      DECLARE @PASS_TEMP VARCHAR (200)
      SELECT @PASS_TEMP = DS_SMTP_SENHA
      FROM   DBO.EMPRESA E
      WHERE  E.FL_EXCLU = 0
      -- GRUPOS
      IF( @GRUPO_NOME <> '' )
        BEGIN
            IF NOT EXISTS(SELECT *
                          FROM   GRUPOS
                          WHERE  GRUPO_NOME = @GRUPO_NOME)
                  INSERT INTO [DBO].[GRUPOS]
                              ([GRUPO_NOME],
                               [DESCRICAO_GRUPO],
                               [ACTIVO_STR],
                               [FL_EXCLU])
                  VALUES      ( @GRUPO_NOME,
                                @DESCRICAO_GRUPO,
                                'SIM',
                                0 )
                  DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPO) FROM
              GRUPOS)
                  EXEC PROC_LOGS_INSERIR
                    @COD_LOG_UTILIZADOR,
                    'GRUPOS',
                    'INSERIR',
                    @IDENTITTY,
                    NULL
            ELSE
              BEGIN
                  RAISERROR('ESTE GRUPO JÁ EXISTE',16,1)
              END
        END
  END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_MENUS_ALTERAR] @COD_LOG_UTILIZADOR INT,
                                                 @COD_MENU           INT,
                                                 @COD_GRUPO          INT,






	@DT_ALT datetime2(7),	@ID                                                 @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID     INT,
                                                 @ESTADO             BIT
AS
  BEGIN
      SET NOCOUNT ON;
      IF ( @ESTADO = 1 )





























            ELSE
                  INSERT INTO [DBO].[GRUPOS_MENUS_REL]
                              ([COD_MENU],
                               [COD_GRUPO],
                               [DT_INSERCAO],
                               [ID_UTILIZADOR],
                               [FL_EXCLU])
                  VALUES      ( @COD_MENU,
                                @COD_GRUPO,
                                GETDATE(),
                                @ID_UTILIZADOR,
                                0)


                    'INSERIR',



      ELSE
        BEGIN
            IF EXISTS(SELECT *
                      FROM   DBO.GRUPOS_MENUS_REL GMR
                      WHERE  GMR.COD_MENU = @COD_MENU
                             AND GMR.COD_GRUPO = @COD_GRUPO
                             AND GMR.FL_EXCLU = 0)
              BEGIN
                  UPDATE [DBO].[GRUPOS_MENUS_REL]
                  SET    FL_EXCLU = 1
                  WHERE  [DBO].[GRUPOS_MENUS_REL].COD_GRUPO = @COD_GRUPO
                         AND COD_MENU = @COD_MENU
                         AND FL_EXCLU = 0
                  EXEC PROC_LOGS_INSERIR
                    @COD_LOG_UTILIZADOR,
                    'GRUPOS_MENUS_REL',
                    'ALTERAR',
                    @COD_GRUPO,
                    NULL
              END
        END
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_PARAMETROS_UTILIZADORES_ESQUECI_SENHA] 	
 	@EMAIL VARCHAR(60),
	@SENHA VARCHAR(200)
AS
BEGIN
    DECLARE @COD_UTILIZADOR VARCHAR(50) = (SELECT ID_UTILIZADOR FROM UTILIZADORES	WHERE EMAIL = @EMAIL) 
	SET NOCOUNT ON;
	DECLARE @TEMP VARCHAR(200)
	SELECT @TEMP=PASS_TEMP FROM UTILIZADORES	
	BEGIN
 	  UPDATE [DBO].[UTILIZADORES] 
 	    SET
 	    EMAIL=@EMAIL,
 	    PALAVRA_PASSE=NULL,
		PASS_TEMP=@SENHA
	WHERE EMAIL=@EMAIL AND FL_EXCLU = 0
	  EXEC PROC_LOGS_INSERIR @COD_UTILIZADOR,'UTILIZADORES','ALTERAR - ESQUECI SENHA',@COD_UTILIZADOR,NULL
	END
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPO_MENUS_CONSULTA]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT GM.ID_GRUPOS_MENU_REL, GM.COD_MENU, GM.COD_GRUPO, GM.DT_INSERCAO, GM.ID_UTILIZADOR, U.UTILIZADOR,M.NM_NIVEL_ITEM,G.GRUPO_NOME
	FROM DBO.GRUPOS_MENUS_REL GM
	INNER JOIN DBO.MENUS M ON M.ID_NIVEL_ITEM = GM.COD_MENU 
	INNER JOIN DBO.GRUPOS G ON G.ID_GRUPO = GM.COD_GRUPO
	INNER JOIN DBO.UTILIZADORES U ON U.ID_UTILIZADOR = GM.ID_UTILIZADOR
	WHERE GM.FL_EXCLU=0
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_ALTERAR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
@PERCURSOS_NOME NVARCHAR(MAX),
@DESCRICAO NVARCHAR(MAX) = NULL,
@CODIGO NVARCHAR(50),
@COD_APPS INT = NULL
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
IF NOT EXISTS(SELECT * FROM PERCURSOS WHERE 
PERCURSOS_NOME = @PERCURSOS_NOME AND
FL_EXCLU = 0 AND
DESCRICAO = @DESCRICAO AND
CODIGO = @CODIGO AND
COD_APPS = @COD_APPS
AND ID_PERCURSOS <> @ID_PERCURSOS
)
UPDATE PERCURSOS
SET
[PERCURSOS_NOME] = @PERCURSOS_NOME,
[DESCRICAO] = @DESCRICAO,
[CODIGO] = @CODIGO,
[COD_APPS] = @COD_APPS
WHERE ID_PERCURSOS = @ID_PERCURSOS
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERCURSOS','ALTERAR',@ID_PERCURSOS ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE PERCURSOS COM ESTES DADOS!',16,1)
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPO_MENUS_CONSULTA_ID]
	@COD_GRUPO INT
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT GM.ID_GRUPOS_MENU_REL, GM.COD_MENU, GM.COD_GRUPO, GM.DT_INSERCAO, GM.ID_UTILIZADOR, U.UTILIZADOR,M.NM_NIVEL_ITEM,G.GRUPO_NOME
	FROM DBO.GRUPOS_MENUS_REL GM
	INNER JOIN DBO.MENUS M ON M.ID_NIVEL_ITEM = GM.COD_MENU 
	INNER JOIN DBO.GRUPOS G ON G.ID_GRUPO = GM.COD_GRUPO
	INNER JOIN DBO.UTILIZADORES U ON U.ID_UTILIZADOR = GM.ID_UTILIZADOR
	WHERE GM.FL_EXCLU=0 AND G.ID_GRUPO=@COD_GRUPO
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_CONSULTAR_COUNT]
AS
SET NOCOUNT ON;
BEGIN
SELECT  COUNT(ID_PERCURSOS)  FROM PERCURSOS WHERE FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPO_MENUS_EXCLUIR]
	@ID_GRUPOS_MENUS_REL INT,
	@COD_LOG_UTILIZADOR INT	
AS
BEGIN
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	UPDATE [DBO].[GRUPOS_MENUS_REL]
   SET [DBO].[GRUPOS_MENUS_REL].FL_EXCLU=1
    	WHERE [DBO].[GRUPOS_MENUS_REL].ID_GRUPOS_MENU_REL=@ID_GRUPOS_MENUS_REL
	  EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPOS_MENUS_REL','EXCLUIR',@ID_GRUPOS_MENUS_REL,NULL
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPO_MENUS_INSERIR] 
	@COD_LOG_UTILIZADOR INT,
	@COD_MENU INT,
	@COD_GRUPO INT
AS
BEGIN
	INSERT INTO [DBO].[GRUPOS_MENUS_REL]
        	([COD_MENU]
    	,[COD_GRUPO]
    	,[DT_INSERCAO]
    	,[ID_UTILIZADOR]
    	,[FL_EXCLU])
     VALUES
        	(
			@COD_MENU ,
			@COD_GRUPO ,
			GETDATE(),
			@COD_LOG_UTILIZADOR,
			0)
	         DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPOS_MENU_REL) FROM GRUPOS_MENUS_REL)
			EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PRIVILEGIOS DE ACESSO','INSERIR',@IDENTITTY,NULL
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_CONSULTAR_ID]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
SET NOCOUNT ON;
BEGIN
SELECT
PERCURSOS.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,PERCURSOS.CODIGO
,PERCURSOS.DESCRICAO
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
FROM PERCURSOS PERCURSOS
LEFT JOIN APPS APPS ON APPS.ID_APPS = PERCURSOS.COD_APPS
WHERE PERCURSOS.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
AND
[ID_PERCURSOS] = @ID_PERCURSOS
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_ALTERAR]
@ID_GRUPO_AUTORIDADE INT,
@GRUPO_RESPONSABILIDADE_NOME NVARCHAR(50),
@DESCRICAO NVARCHAR(50)
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM GRUPO_RESPONSABILIDADE WHERE 
GRUPO_RESPONSABILIDADE_NOME = @GRUPO_RESPONSABILIDADE_NOME AND
FL_EXCLU = 0 AND
DESCRICAO = @DESCRICAO
AND ID_GRUPO_AUTORIDADE <> @ID_GRUPO_AUTORIDADE
)
UPDATE GRUPO_RESPONSABILIDADE
SET
[GRUPO_RESPONSABILIDADE_NOME] = @GRUPO_RESPONSABILIDADE_NOME,
[DESCRICAO] = @DESCRICAO
WHERE ID_GRUPO_AUTORIDADE = @ID_GRUPO_AUTORIDADE
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPO RESPONSABILIDADE','ALTERAR',@ID_GRUPO_AUTORIDADE ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE GRUPO RESPONSABILIDADE COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_ACESSO_RAPIDO_CONSULTAR_ICONE]
@LINK NVARCHAR(50)
AS
BEGIN
DECLARE @SQL NVARCHAR(MAX) = ''
SET @SQL=@SQL+'
SELECT TOP(1)
ISNULL(IM.BT_ARQUIVO, CAST('''' AS VARBINARY(MAX))) AS BT_IMAGEM, M.NM_NIVEL_ITEM
FROM MENUS M 
LEFT JOIN IMAGEM_MENU_RELACIONAMENTO IMR ON IMR.COD_MENU = M.ID_NIVEL_ITEM
LEFT JOIN IMAGEM_MENU IM ON IM.ID_ARQUIVO = IMR.COD_IMAGEM
WHERE M.FL_EXCLU = 0
AND IM.BT_ARQUIVO IS NOT NULL
AND M.DS_MENU_LINK LIKE ''%' + @LINK + '%'''
EXEC (@SQL)
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_CONSULTAR_ID_APPS]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_APPS INT
AS
    SET NOCOUNT ON;
  BEGIN
      SELECT PERCURSOS.COD_APPS,
             APPS.ID_APPS,
             APPS.APPS_NOME,
             APPS.DESCRICAO,
             APPS.SIGLA,
             PERCURSOS.CODIGO,
             PERCURSOS.DESCRICAO,
             PERCURSOS.ID_PERCURSOS,
             PERCURSOS.PERCURSOS_NOME
      FROM   PERCURSOS PERCURSOS
             INNER JOIN APPS APPS
               ON APPS.ID_APPS = PERCURSOS.COD_APPS
      WHERE  PERCURSOS.FL_EXCLU = 0
             AND APPS.FL_EXCLU = 0
             AND COD_APPS = @ID_APPS
  END 

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_GRUPO_AUTORIDADE)  FROM GRUPO_RESPONSABILIDADE WHERE FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_ACESSO_RAPIDO_INSERIR]
@LINK NVARCHAR(MAX)
,@COD_UTILIZADOR INT
AS
BEGIN
DELETE FROM ACESSO_RAPIDO WHERE LINK=@LINK AND COD_UTILIZADOR=@COD_UTILIZADOR
INSERT INTO [DBO].[ACESSO_RAPIDO]
[LINK]
,[COD_UTILIZADOR]
,[DT_CADASTRO]
,[FL_EXCLU]
VALUES
(
@LINK
,@COD_UTILIZADOR
,GETDATE()
,0
)
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_CONSULTAR_INDEX]
AS
SET NOCOUNT ON;
BEGIN
SELECT
PERCURSOS.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,PERCURSOS.CODIGO
,PERCURSOS.DESCRICAO
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
FROM PERCURSOS PERCURSOS
LEFT JOIN APPS APPS ON APPS.ID_APPS = PERCURSOS.COD_APPS
WHERE PERCURSOS.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
END


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_CONSULTAR_FILTROS]
 @GRUPO_RESPONSABILIDADE_NOME NVARCHAR(MAX) = NULL,
 @DESCRICAO NVARCHAR(MAX) = NULL
AS
BEGIN
  DECLARE @SQL NVARCHAR(MAX) =''
  SET @SQL=@SQL+'
  SELECT


FROM GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
WHERE GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
  IF @GRUPO_RESPONSABILIDADE_NOME IS NOT NULL AND @GRUPO_RESPONSABILIDADE_NOME<>''
      SET @SQL=@SQL+' AND GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME LIKE ''%'+@GRUPO_RESPONSABILIDADE_NOME+'%'''
  IF @DESCRICAO IS NOT NULL AND @DESCRICAO<>''
  BEGIN
      SET @SQL=@SQL+' AND GRUPO_RESPONSABILIDADE.DESCRICAO LIKE ''%'+@DESCRICAO+'%'''
  END
  SET @SQL=@SQL+'GROUP BY
GRUPO_RESPONSABILIDADE.DESCRICAO
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
 ORDER BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
'
EXEC(@SQL)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_ACESSO_RAPIDO_CONSULTAR]
@NUM_TOP INT,
@COD_UTILIZADOR INT
AS
BEGIN
SELECT TOP(5)


ISNULL(IM.BT_ARQUIVO, CAST('' AS VARBINARY(MAX))) AS BT_IMAGEM
FROM ACESSO_RAPIDO A
INNER JOIN MENUS M ON REPLACE(LINK, 'INSERIR/', 'LISTA/') = M.DS_MENU_LINK
INNER JOIN IMAGEM_MENU_RELACIONAMENTO IMR ON IMR.COD_MENU = M.ID_NIVEL_ITEM
INNER JOIN IMAGEM_MENU IM ON IM.ID_ARQUIVO = IMR.COD_IMAGEM
WHERE A.FL_EXCLU = 0
AND M.FL_EXCLU = 0
AND IMR.FL_EXCLU = 0
AND IM.FL_EXCLU =0
AND A.COD_UTILIZADOR = @COD_UTILIZADOR
GROUP BY 
A.COD_UTILIZADOR,
A.LINK,
A.DT_CADASTRO,
M.NM_NIVEL_ITEM,
IM.BT_ARQUIVO,
ID_ACESSO_RAPIDO
ORDER BY ID_ACESSO_RAPIDO DESC
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_CONSULTAR_LISTA_DROP]
AS
SET NOCOUNT ON;
BEGIN
SELECT
PERCURSOS.COD_APPS
,APPS.ID_APPS
,APPS.APPS_NOME
,APPS.DESCRICAO
,APPS.SIGLA
,PERCURSOS.CODIGO
,PERCURSOS.DESCRICAO
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
FROM PERCURSOS PERCURSOS
LEFT JOIN APPS APPS ON APPS.ID_APPS = PERCURSOS.COD_APPS AND APPS.FL_EXCLU=0
WHERE PERCURSOS.FL_EXCLU = 0
 AND APPS.FL_EXCLU = 0
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_CONSULTAR_ID]
@ID_GRUPO_AUTORIDADE INT
AS
BEGIN
SELECT
GRUPO_RESPONSABILIDADE.DESCRICAO
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
FROM GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
WHERE GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
AND
[ID_GRUPO_AUTORIDADE] = @ID_GRUPO_AUTORIDADE
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_EXCLUIR]






	@DT_ALT datetime2(7),	@ID@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
,@COD_LOG_UTILIZADOR INT
AS
SET NOCOUNT ON;
BEGIN
UPDATE PERCURSOS
SET FL_EXCLU = 1 WHERE 
[ID_PERCURSOS] = @ID_PERCURSOS
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERCURSOS','EXCLUIR',@ID_PERCURSOS ,NULL


SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_CONSULTAR_INDEX]
AS
BEGIN
SELECT
GRUPO_RESPONSABILIDADE.DESCRICAO
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
FROM GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
WHERE GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
 ORDER BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_ALTERAR]
@ID_PERCURSOS_FUNCIONARIO INT,
@COD_PERCURSOS INT,
@COD_FUNCIONARIO INT
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM PERCURSOS_FUNCIONARIO WHERE 
FL_EXCLU = 0 AND
COD_PERCURSOS = @COD_PERCURSOS AND
COD_FUNCIONARIO = @COD_FUNCIONARIO
AND ID_PERCURSOS_FUNCIONARIO <> @ID_PERCURSOS_FUNCIONARIO
)
UPDATE PERCURSOS_FUNCIONARIO
SET
[COD_PERCURSOS] = @COD_PERCURSOS,
[COD_FUNCIONARIO] = @COD_FUNCIONARIO
WHERE ID_PERCURSOS_FUNCIONARIO = @ID_PERCURSOS_FUNCIONARIO
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERCURSOS FUNCIONARIO','ALTERAR',@ID_PERCURSOS_FUNCIONARIO ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE PERCURSOS FUNCIONARIO COM ESTES DADOS!',16,1)
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_CONSULTAR_LISTA_DROP]
AS
BEGIN
SELECT
GRUPO_RESPONSABILIDADE.DESCRICAO
,GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
,GRUPO_RESPONSABILIDADE.ID_GRUPO_AUTORIDADE
FROM GRUPO_RESPONSABILIDADE GRUPO_RESPONSABILIDADE
WHERE GRUPO_RESPONSABILIDADE.FL_EXCLU = 0
 ORDER BY GRUPO_RESPONSABILIDADE.GRUPO_RESPONSABILIDADE_NOME
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_CONSULTAR_COUNT]
AS
BEGIN
SELECT  COUNT(ID_PERCURSOS_FUNCIONARIO)  FROM PERCURSOS_FUNCIONARIO WHERE FL_EXCLU = 0
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_EXCLUIR]
@ID_GRUPO_AUTORIDADE INT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE GRUPO_RESPONSABILIDADE
SET FL_EXCLU = 1 WHERE 
[ID_GRUPO_AUTORIDADE] = @ID_GRUPO_AUTORIDADE
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPO RESPONSABILIDADE','EXCLUIR',@ID_GRUPO_AUTORIDADE ,NULL
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_CONSULTAR_FILTROS] @COD_PERCURSOS    NVARCHAR(MAX) = NULL,
                                                                     @PERCURSOS_NOME   NVARCHAR(MAX) = NULL,
                                                                     @COD_FUNCIONARIO  NVARCHAR(MAX) = NULL,
                                                                     @FUNCIONARIO_NOME NVARCHAR(MAX) = NULL,
                                                                     @COD_APPS         NVARCHAR(MAX) = NULL
AS
  BEGIN
      DECLARE @SQL NVARCHAR(MAX) =''
      SET @SQL=@SQL + '
  SELECT










,PERCURSOS.CODIGO AS PERCURSOS_CODIGO

FROM PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = PERCURSOS_FUNCIONARIO.COD_PERCURSOS
WHERE PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
 AND PERCURSOS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
      IF @COD_APPS IS NOT NULL
         AND @COD_APPS <> ''
            SET @SQL=@SQL + ' AND PERCURSOS.COD_APPS = ''' + @COD_APPS + ''''
      IF @COD_PERCURSOS IS NOT NULL
         AND @COD_PERCURSOS <> ''
            SET @SQL=@SQL + ' AND PERCURSOS_FUNCIONARIO.COD_PERCURSOS = ''' + @COD_PERCURSOS + ''''
      IF @PERCURSOS_NOME IS NOT NULL
         AND @PERCURSOS_NOME <> ''
            SET @SQL=@SQL + ' AND PERCURSOS_FUNCIONARIO.PERCURSOS_NOME LIKE ''%' + @PERCURSOS_NOME + '%'''
      IF @COD_FUNCIONARIO IS NOT NULL
         AND @COD_FUNCIONARIO <> ''
            SET @SQL=@SQL + ' AND PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO = ''' + @COD_FUNCIONARIO + ''''
      IF @FUNCIONARIO_NOME IS NOT NULL
         AND @FUNCIONARIO_NOME <> ''
        BEGIN
            SET @SQL=@SQL + ' AND PERCURSOS_FUNCIONARIO.FUNCIONARIO_NOME LIKE ''%' + @FUNCIONARIO_NOME + '%'''
        END
      SET @SQL=@SQL + 'GROUP BY
PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO
,PERCURSOS_FUNCIONARIO.COD_PERCURSOS
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
,PERCURSOS.DESCRICAO
,PERCURSOS.CODIGO
,PERCURSOS.COD_APPS
,PERCURSOS_FUNCIONARIO.ID_PERCURSOS_FUNCIONARIO
ORDER BY PERCURSOS.CODIGO
'
      EXEC(@SQL)
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_IMPORTAR] @GRUPO_RESPONSABILIDADE_NOME NVARCHAR(50),
                                                            @DESCRICAO                   NVARCHAR(50),
                                                            @COD_LOG_UTILIZADOR          INT
AS
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   GRUPO_RESPONSABILIDADE
                    WHERE  GRUPO_RESPONSABILIDADE_NOME = @GRUPO_RESPONSABILIDADE_NOME
                           AND FL_EXCLU = 0
                           AND DESCRICAO = @DESCRICAO)
        BEGIN
            INSERT INTO [DBO].[GRUPO_RESPONSABILIDADE]
                        ([GRUPO_RESPONSABILIDADE_NOME],
                         [FL_EXCLU],
                         [DESCRICAO])
            VALUES      ( @GRUPO_RESPONSABILIDADE_NOME,
                          0,
                          @DESCRICAO )
            SELECT MAX(ID_GRUPO_AUTORIDADE) AS IDENTITTY
            FROM   GRUPO_RESPONSABILIDADE
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPO_AUTORIDADE) FROM
        GRUPO_RESPONSABILIDADE)
            ----EXEC PROC_LOGS_INSERIR
            ----  @COD_LOG_UTILIZADOR,
            ----  'GRUPO RESPONSABILIDADE',
            ----  'INSERIR',
            ----  @IDENTITTY,
            ----  NULL
        END
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_CONSULTAR_ID]	@GUIDE uniqueidentifier,






	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),
	@ID_PERCURSOS_FUNCIONARIO INT
AS
  BEGIN
      SELECT PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO,
             FUNCIONARIO.ID_FUNCIONARIO,
             FUNCIONARIO.FUNCIONARIO_NOME,
             FUNCIONARIO.COD_FUNCAO,
             FUNCIONARIO.NUMERO,
             FUNCIONARIO.COD_BALCAO,
             FUNCIONARIO.USUARIO,
             PERCURSOS_FUNCIONARIO.COD_PERCURSOS,
             PERCURSOS.ID_PERCURSOS,
             PERCURSOS.PERCURSOS_NOME,
             PERCURSOS.DESCRICAO AS P_DESCRICAO,
             PERCURSOS.CODIGO,
             PERCURSOS.COD_APPS,
             PERCURSOS_FUNCIONARIO.ID_PERCURSOS_FUNCIONARIO,
			 APPS.APPS_NOME,
			 APPS.SIGLA
      FROM   PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
             LEFT JOIN FUNCIONARIO FUNCIONARIO
               ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
             LEFT JOIN PERCURSOS PERCURSOS
               ON PERCURSOS.ID_PERCURSOS = PERCURSOS_FUNCIONARIO.COD_PERCURSOS
			   INNER JOIN APPS APPS ON APPS.ID_APPS = PERCURSOS.COD_APPS
      WHERE  PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
             AND PERCURSOS.FL_EXCLU = 0
             AND FUNCIONARIO.FL_EXCLU = 0
			 AND APPS.FL_EXCLU = 0
             AND ID_PERCURSOS_FUNCIONARIO = @ID_PERCURSOS_FUNCIONARIO
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_GRUPO_RESPONSABILIDADE_INSERIR]
@GRUPO_RESPONSABILIDADE_NOME NVARCHAR(50),
@DESCRICAO NVARCHAR(50)
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM GRUPO_RESPONSABILIDADE WHERE 
GRUPO_RESPONSABILIDADE_NOME = @GRUPO_RESPONSABILIDADE_NOME AND
FL_EXCLU = 0 AND
DESCRICAO = @DESCRICAO

INSERT INTO [DBO].[GRUPO_RESPONSABILIDADE]
[GRUPO_RESPONSABILIDADE_NOME],
[FL_EXCLU],
[DESCRICAO]
VALUES
(
@GRUPO_RESPONSABILIDADE_NOME,
0,
@DESCRICAO
)
SELECT MAX(ID_GRUPO_AUTORIDADE) AS IDENTITTY FROM GRUPO_RESPONSABILIDADE WHERE FL_EXCLU = 0
DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPO_AUTORIDADE) FROM GRUPO_RESPONSABILIDADE)
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPO RESPONSABILIDADE','INSERIR',@IDENTITTY ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE GRUPO RESPONSABILIDADE COM ESTES DADOS!',16,1)
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_CONSULTAR_INDEX]
AS
BEGIN
SELECT
PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO
,PERCURSOS_FUNCIONARIO.COD_PERCURSOS
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
,PERCURSOS.DESCRICAO
,PERCURSOS.CODIGO
,PERCURSOS.COD_APPS
,PERCURSOS_FUNCIONARIO.ID_PERCURSOS_FUNCIONARIO
FROM PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = PERCURSOS_FUNCIONARIO.COD_PERCURSOS
WHERE PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
 AND PERCURSOS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
 ORDER BY PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
END

SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_ALTERAR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@GRUPO_NOME NVARCHAR(50)=NULL,
	@DESCRICAO_GRUPO NVARCHAR(MAX)=NULL,
	@ACTIVO_STR NVARCHAR(MAX)=NULL,
	@COD_LOG_UTILIZADOR INT=NULL	
	AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM GRUPOS	WHERE ID_GRUPO=@ID_GRUPO AND DESCRICAO_GRUPO=@DESCRICAO_GRUPO AND GRUPO_NOME=@GRUPO_NOME AND ACTIVO_STR = @ACTIVO_STR  AND FL_EXCLU=0)
		BEGIN
			UPDATE [DBO].[GRUPOS]
				SET [GRUPO_NOME] =@GRUPO_NOME, [DESCRICAO_GRUPO] =@DESCRICAO_GRUPO, [ACTIVO_STR] = @ACTIVO_STR    
				WHERE
				ID_GRUPO=@ID_GRUPO
				EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPOS','ALTERAR',@ID_GRUPO,NULL
		END
END





SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_CONSULTAR_LISTA_DROP]
AS
BEGIN
SELECT
PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
,FUNCIONARIO.ID_FUNCIONARIO
,FUNCIONARIO.FUNCIONARIO_NOME
,FUNCIONARIO.COD_FUNCAO
,FUNCIONARIO.NUMERO
,FUNCIONARIO.COD_BALCAO
,FUNCIONARIO.USUARIO 
,PERCURSOS_FUNCIONARIO.COD_PERCURSOS
,PERCURSOS.ID_PERCURSOS
,PERCURSOS.PERCURSOS_NOME
,PERCURSOS.DESCRICAO
,PERCURSOS.CODIGO
,PERCURSOS.COD_APPS
,PERCURSOS_FUNCIONARIO.ID_PERCURSOS_FUNCIONARIO
FROM PERCURSOS_FUNCIONARIO PERCURSOS_FUNCIONARIO
LEFT JOIN FUNCIONARIO FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO AND FUNCIONARIO.FL_EXCLU=0
LEFT JOIN PERCURSOS PERCURSOS ON PERCURSOS.ID_PERCURSOS = PERCURSOS_FUNCIONARIO.COD_PERCURSOS AND PERCURSOS.FL_EXCLU=0
WHERE PERCURSOS_FUNCIONARIO.FL_EXCLU = 0
 AND PERCURSOS.FL_EXCLU = 0
 AND FUNCIONARIO.FL_EXCLU = 0
 ORDER BY PERCURSOS_FUNCIONARIO.COD_FUNCIONARIO
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_CONSULTA]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT ID_GRUPO, GRUPO_NOME, DESCRICAO_GRUPO, ACTIVO, ACTIVO_STR FROM GRUPOS	
		WHERE FL_EXCLU = 0 
	 ORDER BY ID_GRUPO ASC	 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_EXCLUIR]
@ID_PERCURSOS_FUNCIONARIO INT
,@COD_LOG_UTILIZADOR INT
AS
BEGIN
UPDATE PERCURSOS_FUNCIONARIO
SET FL_EXCLU = 1 WHERE 
[ID_PERCURSOS_FUNCIONARIO] = @ID_PERCURSOS_FUNCIONARIO
END
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERCURSOS FUNCIONARIO','EXCLUIR',@ID_PERCURSOS_FUNCIONARIO ,NULL
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_CONSULTA_COUNT]
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT COUNT (*) FROM GRUPOS	
		WHERE FL_EXCLU = 0 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_FUNCIONARIO_INSERIR]
@COD_PERCURSOS INT,
@COD_FUNCIONARIO INT
,@COD_LOG_UTILIZADOR INT
AS
IF NOT EXISTS(SELECT * FROM PERCURSOS_FUNCIONARIO WHERE 
FL_EXCLU = 0 AND
COD_PERCURSOS = @COD_PERCURSOS AND
COD_FUNCIONARIO = @COD_FUNCIONARIO

INSERT INTO [DBO].[PERCURSOS_FUNCIONARIO]
[FL_EXCLU],
[COD_PERCURSOS],
[COD_FUNCIONARIO]
VALUES
(
0,
@COD_PERCURSOS,
@COD_FUNCIONARIO
)
SELECT MAX(ID_PERCURSOS_FUNCIONARIO) AS IDENTITTY FROM PERCURSOS_FUNCIONARIO WHERE FL_EXCLU = 0
DECLARE @IDENTITTY INT = (SELECT MAX(ID_PERCURSOS_FUNCIONARIO) FROM PERCURSOS_FUNCIONARIO)
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'PERCURSOS FUNCIONARIO','INSERIR',@IDENTITTY ,NULL
ELSE
BEGIN
   RAISERROR('JÁ EXISTE REGISTO DE PERCURSOS FUNCIONARIO COM ESTES DADOS!',16,1)
END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_CONSULTA_ID]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
    -- INSERT STATEMENTS FOR PROCEDURE HERE
	SELECT ID_GRUPO, GRUPO_NOME ,DESCRICAO_GRUPO, ACTIVO_STR FROM GRUPOS
		WHERE FL_EXCLU=0 AND ID_GRUPO=@ID_GRUPO
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_IMPORTAR] @APPS_NOME          NVARCHAR(100) = NULL,
                                                @SIGLA_APP          NVARCHAR(100) = NULL,
                                                @PERCURSOS_NOME     NVARCHAR(100) = NULL,






	@DT_ALT datetime2(7),	@ID                                                @ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@ID       NVARCHAR(100) = NULL,
                                                @COD_LOG_UTILIZADOR INT
AS
  BEGIN
      EXEC PROC_APPS_INSERIR
        @APPS_NOME,
        @SIGLA_APP,
        0,
        @COD_LOG_UTILIZADOR
      DECLARE @COD_APPS INT = (SELECT TOP (1) ID_APPS FROM APPS WHERE
  APPS_NOME = @APPS_NOME AND SIGLA = @SIGLA_APP AND FL_EXCLU = 0)
      EXEC PROC_PERCURSOS_INSERIR
        @PERCURSOS_NOME,
        '',
        @ID_PERCURSO,
        @COD_APPS,
        @COD_LOG_UTILIZADOR,
		1
  END 
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_EXCLUIR]






	@DT_ALT datetime2(7),	@ID	@ID
	@GUIDE uniqueidentifier,
	@NM_UTILIZADOR varchar(200),
	@COD_UTILIZADOR int,
	@NM_UTILIZADOR_ALT varchar(200),
	@COD_UTILIZADOR_ALT int,
	@DT_CAD datetime2(7),
	@DT_ALT datetime2(7),	@IDINT,
	@COD_LOG_UTILIZADOR INT	=NULL
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING	WITH SELECT STATEMENTS.
	SET NOCOUNT ON;	
	UPDATE GRUPOS SET FL_EXCLU=1
	WHERE ID_GRUPO=@ID_GRUPO
EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPOS','EXCLUIR',@ID_GRUPO,NULL
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROCEDURE [DBO].[PROC_PERCURSOS_INSERIR] @PERCURSOS_NOME     NVARCHAR(MAX),
                                               @DESCRICAO          NVARCHAR(MAX) = NULL,
                                               @CODIGO             NVARCHAR(50),
                                               @COD_APPS           INT = NULL,
                                               @COD_LOG_UTILIZADOR INT,
											   @TIPO INT = NULL
AS
    SET NOCOUNT ON;
  BEGIN
      IF NOT EXISTS(SELECT *
                    FROM   PERCURSOS
                    WHERE  PERCURSOS_NOME = @PERCURSOS_NOME
                           AND FL_EXCLU = 0
                           AND DESCRICAO = @DESCRICAO
                           AND CODIGO = @CODIGO
                           AND COD_APPS = @COD_APPS)
        BEGIN
            INSERT INTO [DBO].[PERCURSOS]
                        ([PERCURSOS_NOME],
                         [FL_EXCLU],
                         [DESCRICAO],
                         [CODIGO],
                         [COD_APPS])
            VALUES      ( @PERCURSOS_NOME,
                          0,
                          @DESCRICAO,
                          @CODIGO,
                          @COD_APPS )
            SELECT MAX(ID_PERCURSOS) AS IDENTITTY
            FROM   PERCURSOS
            WHERE  FL_EXCLU = 0
            DECLARE @IDENTITTY INT = (SELECT MAX(ID_PERCURSOS) FROM
        PERCURSOS)
            EXEC PROC_LOGS_INSERIR
              @COD_LOG_UTILIZADOR,
              'PERCURSOS',
              'INSERIR',
              @IDENTITTY,
              NULL
        END
ELSE
 IF(@TIPO=1)
 BEGIN
    RAISERROR('JÁ EXISTE REGISTO DE PERCURSOS COM ESTES DADOS!',16,1)
	END
END
  END
SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- AUTHOR:		<AUTHOR,,NAME>
-- ALTER DATE: <ALTER DATE,,>
-- DESCRIPTION:	<DESCRIPTION,,>
-- =============================================
CREATE PROCEDURE [DBO].[PROC_GRUPOS_INSERIR]
 	@GRUPO_NOME NVARCHAR(50),
	@DESCRICAO_GRUPO NVARCHAR(MAX),
	@ACTIVO_STR NVARCHAR(MAX),
	@COD_LOG_UTILIZADOR INT	=NULL
	AS
BEGIN
	SET NOCOUNT ON;
	 IF NOT EXISTS(SELECT * FROM GRUPOS	WHERE GRUPO_NOME= @GRUPO_NOME AND ACTIVO_STR=@ACTIVO_STR AND FL_EXCLU=0)
	BEGIN			
	INSERT INTO [DBO].[GRUPOS]
	([GRUPO_NOME]
	,[DESCRICAO_GRUPO]
	,[ACTIVO_STR]
	,[FL_EXCLU])
     VALUES
	(@GRUPO_NOME,
	@DESCRICAO_GRUPO,
	@ACTIVO_STR,		  
	0)		
	DECLARE @IDENTITTY INT = (SELECT MAX(ID_GRUPO) FROM GRUPOS)
	EXEC PROC_LOGS_INSERIR @COD_LOG_UTILIZADOR,'GRUPOS','INSERIR',@IDENTITTY,NULL
	SELECT MAX(ID_GRUPO) AS IDENTITTY FROM GRUPOS	WHERE FL_EXCLU =0
	END
	ELSE
	BEGIN
	RAISERROR('ESTE GRUPO JÁ EXISTE!',16,1)
	END 
END




SET ANSI_NULLS ON
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
