-- Seguridad y estetica
--Sebastian Santamaria


-- Llave 5: Seguridad
-- Si el producto es de alta prioridad, se oculta el nombre 
DROP FUNCTION IF EXISTS llave5_encriptar_nombre;
DELIMITER //
CREATE FUNCTION llave5_encriptar_nombre(p_nombre VARCHAR(255), p_prioridad INT) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    IF p_prioridad > 3 THEN
        RETURN TO_BASE64(p_nombre); -- Ofuscación de seguridad
    ELSE
        RETURN p_nombre;
    END IF;
END //
DELIMITER ;

-- Llave 6: Bitacora
-- Registra el rastro de la transformacion
DROP PROCEDURE IF EXISTS llave6_registrar_log;
DELIMITER //
CREATE PROCEDURE llave6_registrar_log(IN p_id_producto INT, IN p_mensaje TEXT)
BEGIN
    INSERT INTO logs_hashy (nombre_funcion, mensaje_accion)
    VALUES ('Pipeline_Hashy', CONCAT('Producto ID: ', p_id_producto, ' - ', p_mensaje));
END //
DELIMITER ;

-- Llave 7: Filtro de salida
-- Valida si el dulce es apto para una venta
DROP FUNCTION IF EXISTS llave7_veredicto;
DELIMITER //
CREATE FUNCTION llave7_veredicto(p_precio_finca DECIMAL(10,2), p_precio_mercado DECIMAL(10,2), p_meses_validez INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_precio_finca < p_precio_mercado AND p_meses_validez > 0 THEN
        RETURN 'APROBADO';
    ELSE
        RETURN 'DESCARTADO';
    END IF;
END //
DELIMITER ;
