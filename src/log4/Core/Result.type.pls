
create or replace TYPE Result
AUTHID DEFINER
as OBJECT
(
	value INTEGER
	,static function ACCEPT return Result DETERMINISTIC
	,static function NEUTRAL return Result DETERMINISTIC
	,static function DENY return Result DETERMINISTIC
	--ACCEPT INTEGER,
	--NEUTRAL INTEGER,
	--DENY INTEGER
 /**
         * Returns the Result for the given string.
         *
         * @param name The Result enum name, case-insensitive. If null, returns, null
         * @return a Result enum value or null if name is null
         */
		,static function toResult(name VARCHAR2) return Result
        --public static Result toResult(final String name) {
            --return toResult(name, null);
        --}

/**
         * Returns the Result for the given string.
         *
         * @param name The Result enum name, case-insensitive. If null, returns, defaultResult
         * @param defaultResult the Result to return if name is null
         * @return a Result enum value or null if name is null
         */
		,static function toResult(name VARCHAR2, defaultresult Result) return Result
        --public static Result toResult(final String name, final Result defaultResult) {
            --return EnglishEnums.valueOf(Result.class, name, defaultResult);
        --}

		--,static function valueOf(name VARCHAR2) return Result
	, MAP member function compare return integer
) final ;
/
show errors

create or replace TYPE BODY Result
AS
		static function toResult(name VARCHAR2) return Result
		is
		begin
            return toResult(name, null);
		end;

		static function toResult(name VARCHAR2, defaultresult Result) return Result
		IS
		BEGIN
			--return EnglishEnums.valueOf(Result.class, name, defaultResult);
            return defaultresult;
		END;
	static function ACCEPT return Result DETERMINISTIC
	is
	begin
		return Result(0);
	end;
	static function NEUTRAL return Result DETERMINISTIC
	is
	begin
		return Result(1);
	end;
	static function DENY return Result DETERMINISTIC
	is
	begin
		return Result(2);
	end;
	MAP member function compare return integer
	is
	begin
		return value;
	end;
END;
/
show errors
-- vim: ts=4 sw=4 filetype=sqloracle


