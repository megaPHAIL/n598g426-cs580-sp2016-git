//
//  SqlParameter.swift
//  Jetz Mobile Service
//
//  Created by Tyler McDonald on 1/6/15.
//  Copyright (c) 2015 Stasyx. All rights reserved.
//

import Foundation

public class SqlParameter {

    private let m_strName: String
    private let m_objType: DBType
    private let m_objDirection: Direction
    private let m_lngSize: Int
    private var m_objValue: String!  //RCB: 05/28/2015 Use var instead of let to allow optional set of objValue in init.
    
    public enum DBType: Int {
        case INT = 8, BIT = 2, REAL = 13, BIGINT = 0, XML = 25, VARCHAR = 22, NVARCAR = 12, CHAR = 3, TEXT = 18, VARIANT = 23, DATETIME = 4, VARBINARY = 21, BINARY = 1, TIMESTAMP = 19, UNIQUEIDENTIFIER = 14
    }
    
    // raw value enum will auto increment if no value specified
    public enum Direction: Int {
        case Unknown = 0, adParamInput, adParamOutput, adParamInputOutput, adParamReturnValue
    }
    
    // can only pass strings for value
    init(strName: String, objType: DBType, objDirection: Direction, lngSize: Int, objValue: String?) {
        if strName.hasPrefix("@") { m_strName = strName }
        else { m_strName = "@" + strName }
        m_objType = objType
        m_objDirection = objDirection
        m_lngSize = lngSize
        if objValue != nil { m_objValue = objValue! }
    }
    
    public func toString() -> String {
        var strNull: String
        var strXML: String
        
        if m_objValue.isEmpty { strNull = "1" }
        else { strNull = "0" }
        
        strXML = "<Parameter><Name><![CDATA[\(m_strName)]]></Name><Type><![CDATA[\(m_objType.rawValue)]]></Type><Direction><![CDATA[\(m_objDirection.rawValue)]]></Direction><Size><![CDATA[\(m_lngSize)]]></Size><NullValue><![CDATA[\(strNull)]]></NullValue><Value><![CDATA[\(m_objValue)]]></Value></Parameter>"
        
        return strXML
    }
}