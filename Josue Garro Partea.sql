--Josue Garro parte A . Llaves 1 y 2
--Lab 6 

--llave 1: fn_cernidor(p_id)
--verifica si un numero es primo 
DELIMITER //
CREATE FUNCTION fn_cernidor(p_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_es_primo BOOLEAN DEFAULT TRUE;
    DECLARE v_divisor INT DEFAULT 2;
    DECLARE v_limite INT;
    
--si es menor a 2 no es primo 
    IF p_id < 2 THEN
        RETURN FALSE;
    END IF;
    
--calcula la raiz cuadrada del numero
    SET v_limite = FLOOR(SQRT(p_id));
    
--busca divisores desde 2 hasta la raiz cuadrada
    WHILE v_divisor <= v_limite DO
        IF p_id MOD v_divisor = 0 THEN
            SET v_es_primo = FALSE;
        END IF;
        SET v_divisor = v_divisor + 1;
    END WHILE;
    
    RETURN v_es_primo;
END //

DELIMITER ;

--llave 2: fn_reloj_arena(p_fecha, p_meses)
--verifica si algo vencio o esta fresco 

DELIMITER //

CREATE FUNCTION fn_reloj_arena(p_fecha DATE, p_meses INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_fecha_vencimiento DATE;
    DECLARE v_fecha_actual DATE;
    DECLARE v_resultado VARCHAR(10);
    
--para obtener la fecha actual del servidor 
    SET v_fecha_actual = CURDATE();
    
--suma los meses a la fecha de ingreso
    SET v_fecha_vencimiento = DATE_ADD(p_fecha, INTERVAL p_meses MONTH);
    
--los compara y ve si ya vencio 
    IF v_fecha_vencimiento >= v_fecha_actual THEN
        SET v_resultado = 'Fresco';
    ELSE
        SET v_resultado = 'Expirado';
    END IF;
    
    RETURN v_resultado;
END //

DELIMITER ;