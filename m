Return-Path: <linux-acpi+bounces-6776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B95928A4C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009991C22782
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3915EFAA;
	Fri,  5 Jul 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Hvf4/ZC4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2095.outbound.protection.outlook.com [40.92.103.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8BC166312;
	Fri,  5 Jul 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187791; cv=fail; b=RVpj6WUKEKi6UcJKjMP1QgfCnM4GGpMt8RmbvwEEED8jgP2FDelXGoygaTPXdOGRIZEOw+eDcpKQsANxYWhBVEc+EoR+p44VJG6ajJJ0cZsx4q51diA4SjoKzPLW+aa1XS7BWAfM7VGgD4p1w3lhSCm6/3pm4F7/1B8UHZb1uvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187791; c=relaxed/simple;
	bh=frfI5qBfh1idMYfYz/3kWjKnhIMBs9XKUgTEMLzLC3c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZhaQoz9j9xmM/tM4qyhBl8phmECAMs5NHwJcAXP1MJzDsoaPrj0yYN/0YUE2PMG3rlgYv+w16Gg8johl3DMI9A4Ku5fzC7V4cei/vvFsfTFocy3DXBqo2/I6t1yz2mXaiK1YlV3gW1YwiRTPXTdqaUafkISxOXRQVV3tIQWa4iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Hvf4/ZC4; arc=fail smtp.client-ip=40.92.103.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crBfpiXyytejJGLEhr/kDAvDuUPmBRv5aWMoXbL9tLKCYjrpOfE2GZIC8BFUdYIv2iO9fcWI8F7Ki+iB/LCxXNAVWZDf8894gYdAoT/Uaof5HnpAGne8TPMbMACrF3pRC5tltTQvmz0CmOOS3USNhuaoiLOv48DhiY71IXYPW9VQEhTDYPlLkDjgPK7HJpo/kpi1yRL5FZUDpGD+BtZy1/LnP1vB23uc2fYELAx6SHjWvhdRL9BnCBZKAWSRMEQCPmZPgQPSAKIYQykwVRTDPZSFcHwizh2UfWeQ74sqxwZ+Rx5M496OC4eGteISAtAxNAuFVFbVKoK1+cg6Ea5TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJV0jvngV9A4aPBml5AZyzhSYM8YVr5qENEr1i1dUZk=;
 b=fH74/AkJ7SsV8CDxJczSWdCo330qe/V47Plp9Pa5KVGxTO3X2tW4wjFaS+JkufhKLJHcxswqkv7FFGz1NiR4Iyh3XnTSEGgGPyal3Ri23/baeIPtMhqWx9E7vL/Lkapd7KEzCR7CxeTkl5hxCpOQqCcy8qOxdn+RZJWxjN/TBqr6zzR0f658saiTA2RWZI5HO8HKh7yeKgyzoz+tmmvnew1/qtO9tLrta8m4pdP9H8LuxyWn89e0D16sBoiKlZcasb/Tm+TO7ULyJwGkIZta1UpW1XB/bRiKSffekcOCjzMHhHJzVS0FQ8nByeYB0rj+xQeBo5kiM9fXWGI2AXuGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJV0jvngV9A4aPBml5AZyzhSYM8YVr5qENEr1i1dUZk=;
 b=Hvf4/ZC4DlAgXvj/yz75WNNfZFxVxElmbkJWacCDV10MQkiY9EgQZMBWlEs1KN6FecU5ncRE9DQHmmS08OAVWtm1IU9dGWEpfUyN19xnNxmyc8eW8vNIizjCYMVRvp6x1bKhR3cHP56HtukY/UM156DK6MpQFz0x3uausxrALqGhCdpwNfP7XGCS4vOn/rfyVmvyUys+Yd205WaCFPU/sxhbkqKYU58KM1L9bGuTSc3CkXeMrTz5rSWrUn6XdU0gSWLhueeHoz3WT2gmulFyjjSUkDQ2o0gdWhIwQtwL4s49nnT4mNWYcDqQCaathoM7McZSL5XttEXfpmFIHKDm5w==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB1690.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:188::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.30; Fri, 5 Jul 2024 13:56:24 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:56:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Hans de Goede <hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>
Subject: [PATCH] acpi video: force native for some T2 macbooks
Thread-Topic: [PATCH] acpi video: force native for some T2 macbooks
Thread-Index: AQHazuMfcCUGNLn5UESaQ1fR8caaNw==
Date: Fri, 5 Jul 2024 13:56:24 +0000
Message-ID: <3DA0EAE3-9EB7-492B-96FC-988503BBDCCC@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [hIECwYxCu5oFB+SdMjn4Hq6I62U1L4Inecnteyv++TpABFEqxutd3rF4Cjvwv/fkAFMycTKr6B0=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB1690:EE_
x-ms-office365-filtering-correlation-id: 25a74352-66c7-49c6-edeb-08dc9cfa4246
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 /ivvE1HaLG/+rLt03b/LFVJVvcZKEw/ny05TdyY8ARfYt4jrsDg03LLQlyUd69nwRVfWBI+SbvrXzP4PzoJdjnlhqInqroYdajxoiWne9/+1o2j41L9CsDXlDYYAmc85xCrl17t/mncHD6PIxxgfbgRt/pTBW/nOKqCDKdOz+nqcGifR7p7iuhH963tnOEfUxpasL9NKYx9+xXN2xsbhspm60dZyfXNXCWrHjUVE80NxuCKI8KBIQK/bI3ilGztYzE8LiUMns7q9RJP0J/XLNDWiFHGpZ/Xyx46Nr2u/UJAd28ie8aEAakmRLb8yGnyR0nRpqtgslDAaujEKL+4izbJ4nxWcRcaNuR5kwyBUemgfc88xjoFPls/B578nEhUWLKvZ3mLFhXzfBOJWV48Zp61ldTLLkRbsW/RKSQ2ljtULjSzRHA1YyzTeEcNzy7dZiLty+SSHxekXcZowPaOXfCIFXRFMQMaII2htddPvzYJ5Eoh+g9sVDf64rLbabRUBJ78KNvGqFx0heKESQhwTkY4Mf5rt9JNRL2wHRGaKaPRXrDaQ5qS3YQq+2XCNmo3c6XBJuWj2TXdtdN5UzVDwIs2cO6LNM/UiUyMiO+7SSfFhwqVOpFuFGuMaNiPp6mFrRstRjFginJkyVcUWxP14JPK189Y9+23SIb0CbeAOHMdROBGT2YTc/W3MBV3j8auU1M+1YG7NC/3GfBuRPRt3kJ4/931npULPprtPrtg+MhQmJa00WuHEOdD8WLUZ/NwR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ixm19qSvM/JKfXSKRRx7lPr9ieqQJ+C6fOSVJtzLIgaDqL4UGH16YjLVtis?=
 =?us-ascii?Q?RNpjQard41J2uZ2nwuKhSBXITp2L6EOishxbFgCS9wFiN92VMvZmE04mMiBS?=
 =?us-ascii?Q?7jiD+rfRors1z4qhZhUZtk9g3FEYT3ayTn9lPSW4I7PzMhuudYlxwgLcen+t?=
 =?us-ascii?Q?2IgGNxbnD0i6uS+QvezWD59FUmr/6s39j9vLHWOwd1rw4L5j4eC8Qt/CH51l?=
 =?us-ascii?Q?oH0ohgfHBgi2sOGX4zDuA3Sk2Sg2pL7MoDsAyPeA2t1Ckoy3Rm/l/zs5IHq0?=
 =?us-ascii?Q?q7/VgpydcSvQBJF3jcgwm1mmihDh+chF011WjQxqnMruLnmMAfx/w9kcsv0i?=
 =?us-ascii?Q?jibNdqfICsGZ/4X35JKKqYaLDMDWTjakJVC0SkA2XMiQgqtGqDUNJk3PQjdT?=
 =?us-ascii?Q?+obUdg4wNvja5/VDD9f+gpa49FzxxHvuvVVsg1uyAonYW3R56kKn68lopk+4?=
 =?us-ascii?Q?REJYacpsBEP/7lxTUvlMiLlTqL1pEshecWZ8CCEi/wAADkgBC/LUon7QE86Q?=
 =?us-ascii?Q?lNVsK8+TAcEtCmThM3Sw7DydwoT14HJqCU/ZFSIv/9J45oouQ52+m+gJiHPC?=
 =?us-ascii?Q?R0rfRCnm+vrFbNNzTr11gnflz8heRCIQwcbRcfscXzFqy+D+Z1dTt6FS2DIR?=
 =?us-ascii?Q?TeAdxfilnEumBOHKBKEdhl8BgsztVp9bnGPnrja/ozobhtJ80NPUQ0J/e2DA?=
 =?us-ascii?Q?cqPtL8v7HDJmoSf0c9g4cjjbppse2HpUhMzQ4PXcSkgu852hXITisyvh/QDc?=
 =?us-ascii?Q?FdFaCh2c8F9OCuBnxB5MKX7V/NmohO7k5EQiwtof6q8KZSHaAuuSbUJpqpFD?=
 =?us-ascii?Q?ZKcRUYWqh4hgW9vLF4khWgPUH1PDjtLFqMbwHTk6KXWiu9zsmv9ctuWXKDgO?=
 =?us-ascii?Q?PqnZnzFV/NEXzafR9WuEMHZoKykEO2LH4qG6si+PxQQgjC7MeFlo2zW3dDcv?=
 =?us-ascii?Q?Jnjkd4vDgcJ4vBIjPyYnF4lHIL98+gsCn4Xf5Mnvq/FFzAwpA84fVhcK2qaa?=
 =?us-ascii?Q?QJTRyN2udUviC2T9c0ih8IyQIzIozTVlKSQia/EnEuSeYdkU/iIH+I53/50F?=
 =?us-ascii?Q?hKwT3dwMaSl4YAjdnRX3BiVVlygBGaXfCigyw8kbNgKdDnf3mRKwXbO5Zn/t?=
 =?us-ascii?Q?U+xjzcWqLCUvypNU/g0Bm6XStRjcHV4RW/7uWiX2itJ4zg7J3vzalbVPidXx?=
 =?us-ascii?Q?147ku3f7NYi8YMtEVApPyxRZZ5QgX2DIY9aHLHYL9bahbQ/SsMJx66hERtV9?=
 =?us-ascii?Q?ITaUlBEgbTGU7dfECHKvloNGXLJL9Us0sR114YXXU5lcZT7qa7xYlQqgURD+?=
 =?us-ascii?Q?0RPd8o+8mprdWudIfHUSsEXw?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6B428ABF0C180438BB727861688695F@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a74352-66c7-49c6-edeb-08dc9cfa4246
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 13:56:24.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1690

From: Orlando Chamberlain <orlandoch.dev@gmail.com>

The intel backlight is needed for these, previously users had nothing in
/sys/class/backlight.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 442396f6ed1f..baf7264d7b94 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -513,6 +513,14 @@ static const struct dmi_system_id video_detect_dmi_tab=
le[] =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback =3D video_detect_force_native,
+	 /* Apple MacBook Air 9,1 */
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=3D1217249 */
 	 .callback =3D video_detect_force_native,
@@ -522,6 +530,14 @@ static const struct dmi_system_id video_detect_dmi_tab=
le[] =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
 		},
 	},
+	{
+	 .callback =3D video_detect_force_native,
+	 /* Apple MacBook Pro 16,2 */
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,2"),
+		},
+	},
 	{
 	 .callback =3D video_detect_force_native,
 	 /* Dell Inspiron N4010 */
--=20
2.42.1


