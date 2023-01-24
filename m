Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3547679521
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 11:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjAXK0u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAXK0s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 05:26:48 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2037.outbound.protection.outlook.com [40.92.107.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA183EC77;
        Tue, 24 Jan 2023 02:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgfleJlM7nUlvfhYMuACF0khT1ogBuJ1PAGbvuJ4xi3eS5aQjUfHHzH1wC2rXSdam4Ezp0YlQufwaCBvC0cCeaulWDPppTiPD9ATyYPkHAv/QZyGZrs7UUer7imhIcxPCBEe35x4RVpWubzUSkhtI35NNdluuvMdbMfEzgBr7tsVg/al74+Uj/vFfA3rzLdFLHFLKZzl7gvSPiNqlJc/rxKWjWi5LCLzDLxYQ9TqL0osAl+MD35BnbL4kthhmD6ikp4/j6w4xkLFwuQDzwWGliiRIVxiglZ82L6zvJHTQBFylXSlYwo47zmrwYj/DBptFNlrlkwOF3K0xu773jl80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWWwivdLaZySq4dWBE8SLQzAZccWHFAiRY/32ZTiREI=;
 b=XBoTe+Z1Kj/1zjKgkNNqMCsj1CK8aq1ccMTeuVkp+mFvs1IIZx1eeVmkZTzZ5RhRZBpxCFpYYVWSeR3aErgo1xA6blCy11B3drH8zEdrUxeYTeNX6k0iui2oEm2sf3l+SZkkPzv2IpYnGcRcyGsuf7+VzmuZDBQ1Z1xv7qfyl8YRnfQdZVOn36kS2Zg52OgciVNCaqK2gEObinRPXU6V6ojNJgAoC0De3WZmVvPr9Hkh1r0HIs45bDFmV0kTWg6Ajrekj0yDhN4CeRD3NIL7izwEZULndNQK3ICLbX36geLgWkfU9mK+w/+Sk2cEkGmVvlbw6gZlqgfDkWcQsuwgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWWwivdLaZySq4dWBE8SLQzAZccWHFAiRY/32ZTiREI=;
 b=e+J+8k9p1nyc90UFtDGWWfKPKNscjdFrnhyt6GAFs/KAKLi5b/EfSWqqKDdC1zP7vAvS5k0xiEel0s14LV9/t2nOT/GhedsMGjbb7Tiro6YkAVyqkM9ZyQa4kcKcLyEV4Q46nY1t4yp7hVu97c9fg/kbJ5nccUfnLGRmSMTYbRiPsaNy9VkeDsCviRvbzKc+8ixm3D7X5Sth/BCCJH/dXtvlDmbPNhwFPvW35Ts/RntdoEPdMG7ucQ1whwhujSSL7+na2Gf9zRjpkDhLJIMjaWxpob8vW8/gs1EwsgZ6NYaXXiTCFRodgDyDajfUYJ66o8UCViEphogE4rcF+7j2eQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PNXPR01MB6851.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16; Tue, 24 Jan 2023 10:26:39 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 10:26:39 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Thread-Topic: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Thread-Index: AQHZLx8nX302o6VY+EKTA1QgXCWC+K6sFqCAgAEkuoCAACMCgA==
Date:   Tue, 24 Jan 2023 10:26:39 +0000
Message-ID: <E139A30F-4181-48C5-B8E2-77DBA3DC077A@live.com>
References: <20230124192103.71673c69@redecorated-mbp>
In-Reply-To: <20230124192103.71673c69@redecorated-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Tv4wMl9v7jEWShcLl/sErL+Ac85ROVWF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PNXPR01MB6851:EE_
x-ms-office365-filtering-correlation-id: 3d815349-0b02-48db-f9ec-08dafdf57ac7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61Nfgsw+zW89HgwGbGQ7zA6rrQ/6FXog2z4pC6mdoVxipqWrt5iS2xjSTZefPODeDLcVekIbEn4uD48cKlMmfm0iu8pOlXs3hAia5BTMaVsOo8Mj7i21YQ6nWVj3Z5LPtoixdB+B1eYJkpfRNgU+qcsPQeEWcvK6KY9jeDt5OEcTBXU6CbNBLKLqtrRidVNodcX3Yw45oswkLRalf7FIGl/68iHq1rZP0zkNb+JCa/TdUgRWBnCDqTmyMaY2H0WSVbZTb2vMMgmh/AqTbNWDkW6GlzPOheVdvgXb8hh1FkXeus+lN4LW3PuVYeyKDlWiJzIdU26+ymQcJJKPbHR/ifGchj7j4s1EzO/0fVL9f8Dttx/lT2NfyuQruTIjNDUIbvHHJ2IPP1P4utl4VgpxElyFZhKAFPtVSJE11MJsveh/66XRPFlR656Gj7591duF+YHEQf7LA+5Q3YVk7FlfMr4duoU7b4lNNYDaA9Dxo8l5IiSE9r+O9azV6n3jJa1xkpbRCyxUGAG/Q2e4ftNC27R1PHRA+GH75brf7yyDmJyHYlWF3VSt3Q5V+1/crdEm+gZwwtJHrWsP0QruWicKN9wBNPCF1OKs/3DLJkE7RlxnAXtiSi9OFBKJAerY+jWHz1VngkNMl6meZYvYkxrPJA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9mkonQGwnnjsIvp0f+aycoFBdlye2utRPlW+Ovc1dRJGBMRUclIQmCfLgGa?=
 =?us-ascii?Q?jGTlRmb6pW9pkuUKior6RWN67+HDAcLOQzythtK0B5iyCg6ufsKRrewbR2Xy?=
 =?us-ascii?Q?Wetl7w0gETOjwihY2TxoOIZIgMzGOSVADH32M+BvISGOc9aotSOJUglwL2K+?=
 =?us-ascii?Q?zg19tz/8kzD2ogvDywU7bkseo5QCL+jCTPWrnI3/x79nvz66z3bkQSqCRaM9?=
 =?us-ascii?Q?K4Jid9WcAFe+/u1DClk2BrKOd13/XYMycYzNuxUKj4m/nhRjRPG/80Wh80C6?=
 =?us-ascii?Q?cIUOnmeafSgzePUsREgNHOOIuXq4DMHpdleN4gvDtIP1q54BXDwkPO+AEa2h?=
 =?us-ascii?Q?uD0kyA/ubEjcaNppGFwW6oi5pjqEK2193WXbJdK+sNe372NUVcJPQyV+fEDH?=
 =?us-ascii?Q?VXAATe8CZ0cszV6HlAUQaYwcl7N1H44WCZEn1bNC+dJY/f6p/hVqTA4S3F1d?=
 =?us-ascii?Q?z0ITAoaFixeaxP49E2qPe3nwmvP6XOT5O6ZWQ9x4tE7j1lU/mQJQhvT+X1+B?=
 =?us-ascii?Q?dQ3AoGoC0+IXU0Ch27n5XMa2a557n7q+25dbluZO4+kIcSTgIwoh+aGDSwYm?=
 =?us-ascii?Q?Kj+U7u+cTeGj3RjTbLmS+uY2X9yI15zwRgLi2L25FhWD7J7SQJZSUHg1Y9XO?=
 =?us-ascii?Q?S82nL5jfOFP7/1ykUxXBUzTwKVu3OYaxdl6RBN8xM7slhSvCBn9PTyTOsq7D?=
 =?us-ascii?Q?Z0Jl8pq7rq7BoKSfk9ndElURdDYCnftCk4eBZktMvcqLz8YCrYF5HMLlOmxI?=
 =?us-ascii?Q?VfGNXW2NvfS772Qu/NWZMJswmiPYX8vSrvuGhQMPfqtBkHSURYu6COXwxknm?=
 =?us-ascii?Q?R9Uw9eq5E2YR2PYuikMnu39+auf3diGNa6xetMI/0PgxehRm6pwjMloiBglT?=
 =?us-ascii?Q?gD4GCaQdm+dBS4RAmjZ/zGzCkb6jVTe3YAJWDfV1BuSu+3QDXyREMOJ+nDVk?=
 =?us-ascii?Q?460zDkzCBk0DBMRjo7STYYrfEfxjff2cMrf/7MQzfVKohcj8BO3Msz1BzI4D?=
 =?us-ascii?Q?4LlMueQgiccmK7/QI9SjhqPO3HE1Gy/c9CWUWeqwszRGOwBOmzcpJ2QQbkwy?=
 =?us-ascii?Q?I8kHfJ8ZFxVIrG7IgdXrxxXEouWB7t8ho/zR75GwziMw6Ohz7G730nF5y9DA?=
 =?us-ascii?Q?u6ukBshsIfe1Xeshcv90NAlzg4B9uRk4/28mWevKIxz1fMGazd0CSEITNeCT?=
 =?us-ascii?Q?HYDBZ4Jugnru945+d9ArurzLZ/erDxHD8tbAIPXDVniFsTRbp6DdGfGpMJ0z?=
 =?us-ascii?Q?3cBNHOJbQv2ZtdHaQHfyhRzT0CvlTw3qUx6ZErUNnA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DED9E72FB551634EB72E296FA1C627EE@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d815349-0b02-48db-f9ec-08dafdf57ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 10:26:39.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> I'm the one that wrote those patches for gmux on the mmio T2 macs, and
> I've rebased them onto Hans' patchset with patch numbers 2004-2006 here
> https://github.com/t2linux/linux-t2-patches/tree/gmux
>=20
> It seems to work fine on my T2 Macbookpro16,1, the display backlight
> controls work and there aren't any other, not working, backlights
> present.
>=20
>> ls /sys/class/backlight
> gmux_backlight@

Thanks Orlando

Since I own the same Mac as Orlando, his testing should be good enough.
