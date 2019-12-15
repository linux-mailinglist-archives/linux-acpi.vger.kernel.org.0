Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC711F848
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Dec 2019 16:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOPM5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Dec 2019 10:12:57 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:11416
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfLOPM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Dec 2019 10:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeOsMEWCTMVuxVJtHuq1D76hdRpp7ZJLWOMHi4JqYJyvkLfipLIgOVrtppzCQLsLfs3c2iR5Mv0UieFE5vPVgT7unwRGMW9CV9k2whBU/tmGYCOUZHOFedgedvwTWSUAT71Bv48Yt8Qr+rVxow6E5tgldK9E6tauocLT5Xh6nCqFVLHunBpi753jUR/hvFnbimuRAFm1V+A+hNPbLyMTQ+PEgS36arYhj5i0lGAG8VUO0GEQeVHMI9h9Ra+ewbLc1f71PUwYC87iT6aopFaDg65kFlG7U/voGQ4+UQoOYS2GpKixrPmVarWThCKkuLFK+/v7BcNTw43NgqZ+VBMIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tm6bigb9pw6q5wkD2O4cHpNdQ9yYpIxCCo22z4izG4=;
 b=WPVwfn1r2vEhRx+AhxqYmFqMPdT/FD85MbB2drab+xT/NhTaBZvwpsoRv73RjcR9R9uxa/qBdytbe5Di7mLXbUWqcbNOej2nwrV+iRxM+LeONJwPASXXHaX/gN3AwZY6AaLm0eYYrJIAhEEs0cnN/Ic8mT0rYMkut5oZtmqE4QsFnpc6hgZPSzFvSCO8TgWApSjYWHu2bdVc6vnPEKYWWMaE7CL06Xmm9inQO5S/sfxsNXcT2idjrT1ZuJrIq3Qq9A6UIuEKG84pqj7kipcVSverY/xaDDCnelqE1LdCRbvKx1V1OGXe6CmgCwPSV6GzoaaRI4gReH+HmTrZxprXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tm6bigb9pw6q5wkD2O4cHpNdQ9yYpIxCCo22z4izG4=;
 b=la6cKcNUEGXAMkvdOyCX16gEwkt8zzu30Yf0WSBBk/YXg88mW0r5lTJROitU4rjXHHvdB1Gu+X5qVSXRQ511ENMoHE7k6QN1RgVdKbhpOlRUE1wjGEDjab2O8jGmOqj0pd3SXj+bi7FpuhlHZwie+ccJpjFFguERlymCz5y9fj8=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2477.eurprd04.prod.outlook.com (10.168.64.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Sun, 15 Dec 2019 15:12:53 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6%12]) with mapi id 15.20.2538.019; Sun, 15 Dec
 2019 15:12:52 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH] ACPI/IORT: fix the iort_id_map function
Thread-Topic: [PATCH] ACPI/IORT: fix the iort_id_map function
Thread-Index: AQHVs1oeh+jJ/g/JdU2kvN0Bjpwx5w==
Date:   Sun, 15 Dec 2019 15:12:52 +0000
Message-ID: <20191215203303.29811-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::16) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1fa71a8-ddb2-4fe7-9b3a-08d781714141
x-ms-traffictypediagnostic: VI1PR0401MB2477:|VI1PR0401MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2477375FE040EEA25CDAB94DF1560@VI1PR0401MB2477.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(8936002)(66556008)(66476007)(64756008)(2906002)(5660300002)(66946007)(66446008)(4326008)(86362001)(8676002)(52116002)(2616005)(81166006)(316002)(6512007)(71200400001)(110136005)(6486002)(54906003)(186003)(36756003)(6506007)(81156014)(478600001)(44832011)(1076003)(966005)(4744005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2477;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+Yr4wEMl+vOocw6btbDzsDn8LMw9d3SBAYqXuglpCUqs+Clz+XJdje0SyROXNprfoZsylbdXoUFVWd3rB8uLA0gd772ISkapGPIO0b94Ln/Y3/WjdQ7dXHPnc/Y3p+tU+QQBzNEvFZ3i8p8ZMvtlsM6jXaFxpKQJwwwzBIMm0djWTsvz69NGSiCRAwW5a3OqZwIpYv57VwChzNqlap4/6ocaWtUhmkTJCZKCD02UuoVfWPkMo6QH8+nT2FILfOAy5K1vDGTHDiziMMG4wFNZ9SKRHA9l7RW8egQ6ok6BQLFFrCCjCzFg+girB7QmHU64lgYlqgdwDf4xLfM1nc673y0OvUdgJZ7Pl2Xse1xs4uMdXvpk0Fzsr/9isDaf51i2udpoxUoL0LEcogYOsTUVpA60rJs/Dj2YVAfKgpusFj9NWO9yvDnrHxKA3Zjvl0e+sDaad7yl7f0M7A29gAJY+rYlO7vlRMpjLuTIASDpa8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fa71a8-ddb2-4fe7-9b3a-08d781714141
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 15:12:52.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGWa8tpoABN7o1KQJ6rf/la3citPNxvtrTwh5GnDZz0POUvXUgvduDIBiCo1x/FKdOJ+3p/kAPwVeKh24wP32Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2477
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As per http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_I=
O_Remapping_Table.pdf
in ID mappings:
Number of IDs =3D The number of IDs in the range minus one.

Therefore, it's valid for ID mapping to contain single device mapping which
would have Number of IDs field 0.

The iort_id_map doesn't handle this case, fix this case.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..b9b108d0ca0b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -315,7 +315,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map=
, u8 type, u32 rid_in,
 	}
=20
 	if (rid_in < map->input_base ||
-	    (rid_in >=3D map->input_base + map->id_count))
+	    (rid_in > map->input_base + map->id_count))
 		return -ENXIO;
=20
 	*rid_out =3D map->output_base + (rid_in - map->input_base);
--=20
2.17.1

