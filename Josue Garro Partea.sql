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

    IF p_id IS NULL THEN
        SET v_es_primo = FALSE;
    ELSEIF p_id < 2 THEN
        SET v_es_primo = FALSE;
    ELSE
        SET v_limite = FLOOR(SQRT(p_id));

        WHILE v_divisor <= v_limite AND v_es_primo = TRUE DO
            IF p_id MOD v_divisor = 0 THEN
                SET v_es_primo = FALSE;
            END IF;
            SET v_divisor = v_divisor + 1;
        END WHILE;
    END IF;

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

    IF p_fecha IS NULL OR p_meses IS NULL THEN
        SET v_resultado = 'Expirado';
    ELSE
        SET v_fecha_actual = CURDATE();
        SET v_fecha_vencimiento = DATE_ADD(p_fecha, INTERVAL p_meses MONTH);

        IF v_fecha_vencimiento >= v_fecha_actual THEN
            SET v_resultado = 'Fresco';
        ELSE
            SET v_resultado = 'Expirado';
        END IF;
    END IF;

    RETURN v_resultado;
END //

DELIMITER ;