Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A958DFCF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHNVac (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 17:30:32 -0400
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:53168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfHNVab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Aug 2019 17:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNSfa/KyNffg0PM0oiRDQEIJkuUuneHCO+wl5y2t2WuFS5fDOHDwVbO5+OTjXdrHuji7mjjyzqRZA6SkCEQ2gllwE3G6QaCYLHD6sJ+ZHY9sFrH/72RBU6zBGaKAOIqIbVKV9oHgLoMxY3PAYRCITjH1mIMVZeyENm3csX2I/kfJF70hDbQAgY1/NrlqW9x6e51FIWiInsZ7GH0xTcjDQUYRDYfP1P5dw+FSbdYRISLEa/aqcUX8qgMFCPmSX8TUAhz3RMb/YPY3ucK3y62TaQTkdkKejd36MeeA/Z+7m04Y+183QpnWasOKFfeAzYrN1t2qYVO68BolzkZ0+Baaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlIYGOloPVWyUKw7Wtom+JcvbAkMnWNMsOEnnW7bcqE=;
 b=lhbjiQAEq1iYxkdj/ZxMPmJIukVchYXBTeXCqtTNP5X3MtHhz1rqs5LTKtyEoaA1Hr3tKXSuElBwJU/tR25bwq2jKqJfkUFyQBg42tNw4wwGn+DDv+ji5trXmLcAwa4NOiUvbWaAlIBVxBT9LNznmpExU9hT1sHNstn2LeymO4x5CaN25WTIgheyHKPix7RBPCvtRB0If2V3tYEYSLz7bXrJdqbmV1bNRZgn5eiwnSf20/16B3baMWF3wtongyf2bH/dJ3efOu2LiOfo9q/v6ZtYje5L0SYD+2yIAvz2+rntoPZkwL3fvyHgS0p2c+w7CTw1nn9ebkvJkWIZqTLUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlIYGOloPVWyUKw7Wtom+JcvbAkMnWNMsOEnnW7bcqE=;
 b=FXfhGWPVQi96J3bL+2HHDYqtHli4p8SG4hwzn0QGVeiJbtdNBcmMZqWdtloJilisMRuEmvPFX1QqqHheKZh/qzeReUZ7+zQ428BiAmmaFmpto0X0qrazFtqdRx3of1q5clX1VqFyomCeEcoJKBH7NRZM3+92a4FedkaBaVXTFes=
Received: from CY4PR12MB1815.namprd12.prod.outlook.com (10.175.63.21) by
 CY4PR12MB1333.namprd12.prod.outlook.com (10.168.169.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 21:29:49 +0000
Received: from CY4PR12MB1815.namprd12.prod.outlook.com
 ([fe80::2124:68e0:3c8c:a6ec]) by CY4PR12MB1815.namprd12.prod.outlook.com
 ([fe80::2124:68e0:3c8c:a6ec%11]) with mapi id 15.20.2157.022; Wed, 14 Aug
 2019 21:29:49 +0000
From:   "Duran, Leo" <leo.duran@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Parsing PXM from ACPI (DSDT)
Thread-Topic: Parsing PXM from ACPI (DSDT)
Thread-Index: AdVSCEGThmsUNGQZSm2XEI5B9E2GMQA3cq8AAAA9gMAAAAlkEA==
Date:   Wed, 14 Aug 2019 21:29:49 +0000
Message-ID: <CY4PR12MB1815251BBCB062AAA8EEB39CF9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
References: <CY4PR12MB1815927E36A8A9A0E5B18734F9D20@CY4PR12MB1815.namprd12.prod.outlook.com>
 <CY4PR12MB18156AA493BA8F3C28F0377FF9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
 <CY4PR12MB1815E6208E334CE4EA8F2670F9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1815E6208E334CE4EA8F2670F9AD0@CY4PR12MB1815.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leo.duran@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8efd5b99-e136-4659-8f87-08d720fe894c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1333;
x-ms-traffictypediagnostic: CY4PR12MB1333:
x-microsoft-antispam-prvs: <CY4PR12MB1333EBCB4891F4F34BE57D51F9AD0@CY4PR12MB1333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(76116006)(186003)(256004)(66556008)(11346002)(66946007)(26005)(6116002)(66446008)(64756008)(486006)(52536014)(5660300002)(476003)(9686003)(446003)(7696005)(71190400001)(6506007)(71200400001)(3846002)(76176011)(2906002)(8936002)(102836004)(14454004)(86362001)(2940100002)(66476007)(81156014)(81166006)(33656002)(4326008)(8676002)(478600001)(6436002)(110136005)(74316002)(2501003)(305945005)(99286004)(7736002)(53936002)(25786009)(54906003)(66066001)(55016002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1333;H:CY4PR12MB1815.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ix34BLrzBgL6c4rE7DjsWPqQZNV4zKNqVsROK1RXiBDtjbzmRrKWfTTFLsCF2L8iSGYIU3W1EAt8IOBQerD7o6yv4WPloJ0JQR9j+jLSQUs8/rLIxpZ4kLoQlKrW4fFwlcCKEnuVe3EAZn0HMr9pOdXgmYLxXHd8pKvGxMzHJfWVdFQ+ZQxw/PCPhhhN9EfV62fcEtQl1vCtQnpGQK1ErG39LOufaZkpjH4vbLVH8iOn9tlYlTs1HFXWzCuhEFZInL86uwf1VuaQWPr6g4j+jLnJHRZgBw0BeKVAH3OX4Qx0dLW0Td2voOYK9qYkMfwUSNZXcNrSrolRTRsZ/Vfm1QMeZfiSzA/GKU1f2647+6YK8nt6Unkn/JZ/AdOsClAecPz8OLxCqmSRAZyna1eUtWbL2laC62YzSb7nSU5ZWRY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efd5b99-e136-4659-8f87-08d720fe894c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 21:29:49.2393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwomju+mjsyfacgupsKBUgZufHxsZ/K3l724d7qY9ohAGIPXlfDrqb1gHUz0ExRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGVsbG8sDQpJcyBub3QgY2xlYXIgb3IgZXZpZGVudCB0byBtZSBpZiB0aGUga2VybmVsIHBhcnNl
cyBfUFhNIHZhbHVlcyBiZWxvdyAob3IgdW5kZXIpIHRoZSByb290LWNvbXBsZXguDQoNCkZvciBl
eGFtcGxlLCBpbiBteSBleHBlcmllbmNlOg0KVGhpcyBBU0wgc2FtcGxlIGZvciBQWE0gYXQgdGhl
IHJvb3QtY29tcGxleCBsZXZlbCBwcm9kdWNlcyB0aGUgZXhwZWN0ZWQgTlVNQSBhc3NpZ25tZW50
IGZyb20g4oCcbHN0b3Bv4oCdOg0KU2NvcGUgKFxfU0IpIHsNCiAgLy8gLi4uDQogIERldmljZSAo
UENJMCkgeyAvLyBSb290IFBDSSBCdXMgKEhvc3QtQnJpZGdlKQ0KICAgIE5hbWUgKF9ISUQsIEVJ
U0FJRCgiUE5QMEEwOCIpKQ0KICAgIE5hbWUgKF9DSUQsIEVJU0FJRCgiUE5QMEEwMyIpKQ0KICAg
IE5hbWUgKF9CQk4sIDApDQogICAgTWV0aG9kIChfQ1JTLDApIHsNCiAgICAgIC8vIFJldHVybiBj
dXJyZW50IHJlc291cmNlcyBmb3IgaG9zdCBicmlkZ2UgMA0KICAgIH0NCiAgICBOYW1lIChfUFJU
LCBQYWNrYWdlKCkgew0KICAgICAvLyBQYWNrYWdlIHdpdGggUENJIElSUSByb3V0aW5nIHRhYmxl
IGluZm9ybWF0aW9uDQogICAgfSkNCiAgICBNZXRob2QgKF9QWE0sIDAsIE5vdFNlcmlhbGl6ZWQp
IHsNCiAgICAgIFJldHVybiAoMCkNCiAgICB9DQogIH0NCiAgLy8gLi4uDQp9DQoNCkhvd2V2ZXIs
DQpUaGlzIEFTTCBzYW1wbGUgZm9yIFBYTSBhdCB0aGUgUDJQIHJvb3QtYnJpZGdlIGxldmVsIGRv
ZXMgbm90IHByb2R1Y2UgdGhlIGV4cGVjdGVkIE5VTUEgYXNzaWdubWVudCBmcm9tIOKAnGxzdG9w
b+KAnToNCiAoT2YgY291cnNlLCB0aGUgYXNzdW1wdGlvbiBpcyB0aGF0IG11bHRpcGxlIE5VTUEg
bm9kZXMgYWN0dWFsbHkgZXhpc3Qgb24gdGhlIHN5c3RlbSkNCg0KIFNjb3BlIChcX1NCKSB7DQog
IC8vIC4uLg0KICBEZXZpY2UgKFBDSTApIHsgLy8gUm9vdCBQQ0kgQnVzIChIb3N0LUJyaWRnZSkN
CiAgICBOYW1lIChfSElELCBFSVNBSUQgKCJQTlAwQTA4IikpDQogICAgTmFtZSAoX0NJRCwgRUlT
QUlEICgiUE5QMEEwMyIpKQ0KICAgIE5hbWUgKF9CQk4sIDApDQogICAgTWV0aG9kIChfQ1JTLDAp
IHsNCiAgICAgIC8vIFJldHVybiBjdXJyZW50IHJlc291cmNlcyBmb3IgaG9zdCBicmlkZ2UgMA0K
ICAgIH0NCiAgICBOYW1lIChfUFJULCBQYWNrYWdlKCkgew0KICAgICAgLy8gUGFja2FnZSB3aXRo
IFBDSSBJUlEgcm91dGluZyB0YWJsZSBpbmZvcm1hdGlvbg0KICAgIH0pDQoNCsKgwqDCoCBEZXZp
Y2UgKFAyUDApIHsgLy8gRmlyc3QgUENJLXRvLVBDSSBicmlkZ2UgKFBvcnQwKQ0KwqDCoMKgwqDC
oCBOYW1lIChfQURSLCAweDAwMDcwMDAxKSAvLyBEZXZpY2UjN2gsIEZ1bmMjMSBvbiBidXMgUENJ
MA0KwqDCoMKgwqDCoCBOYW1lIChfUFJULCBQYWNrYWdlKCkgew0KwqDCoMKgwqDCoCAgIC8vIFBh
Y2thZ2Ugd2l0aCBQQ0kgSVJRIHJvdXRpbmcgdGFibGUgaW5mb3JtYXRpb24NCsKgwqDCoMKgwqAg
fSkNCiAgICAgIE1ldGhvZCAoX1BYTSwgMCwgTm90U2VyaWFsaXplZCkgew0KICAgICAgICBSZXR1
cm4gKDApDQogICAgICB9DQrCoMKgwqAgfQ0KDQrCoMKgwqAgRGV2aWNlIChQMlAxKSB7IC8vIFNl
Y29uZCBQQ0ktdG8tUENJIGJyaWRnZSAoUG9ydDEpDQrCoMKgwqDCoMKgIE5hbWUgKF9BRFIgLDB4
MDAwODAwMDEpIC8vIERldmljZSM4aCwgRnVuYyMxIG9uIGJ1cyBQQ0kwDQrCoMKgwqDCoMKgIE5h
bWUgKF9QUlQsIFBhY2thZ2UoKSB7DQrCoMKgwqDCoMKgICAgLy8gUGFja2FnZSB3aXRoIFBDSSBJ
UlEgcm91dGluZyB0YWJsZSBpbmZvcm1hdGlvbg0KwqAgICDCoCB9KSANCiAgICAgIE1ldGhvZCAo
X1BYTSwgMCwgTm90U2VyaWFsaXplZCkgew0KICAgICAgICAgUmV0dXJuICgxKQ0KICAgICAgfQ0K
wqDCoMKgIH0NCiAgfQ0KICAvLyAuLi4NCn0NCg0KVGhhbmtzLA0KTGVvLg0KDQo=
