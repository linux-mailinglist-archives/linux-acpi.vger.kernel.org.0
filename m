Return-Path: <linux-acpi+bounces-7481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DDB94D7FE
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 22:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F041C2240B
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC5167D98;
	Fri,  9 Aug 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R86QuqL4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5933D1;
	Fri,  9 Aug 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234876; cv=fail; b=PzEXJcWsJ30SG/WXyVo3zO+pqvlPHGMuWjeo79ru+y35hWq/1g+TsZIRMDMxgaChaLYO8T+I6gU1nGXRXQeCTbC5JEQLNrcmG6oP8stLsK31GnrXespdockmfmOb0dt6b84Xo/Ocu63H/VNzIESJif/ZDsVCog7bBFRwE/0uJZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234876; c=relaxed/simple;
	bh=/pqxb5IJTnf4VDXkxb7dQv66P4T/9x/9wLCKlYsqh8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YG9ee2KeQ8H34z2dW+bJfQ6O/T0zjp6UAWYTA+XLHB0l3S7N3pqil2eitdEXY0iJJ/fB9NsAXCgYE7sT4vuhxlSR2dlXhGt08mAlJcoB4J/rn6BBDcNSCdrAGEPzVTWPq4cjlU9STBTW60MMBd/5XQmBURzGACneyFX14jYgWQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R86QuqL4; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG83N8XB1wslMgUOrRTj221l2xNkmCWhk7JTtLmv3ZBZspedNweEOUDuXog3SQp+x1/jgRJaewJwUuJu7FUclRyhRHEhq54pSD+6LlYd4EeyVwx6d4GlDOXloXA2CVaDjFCsE1C1lI+iEGJdI5TDuVxXh0LRMtyemwfEkIKa+7SQZfOoBX0S8evEeazcjrCe/CCP7K6C61d1BNCUU0X2AmFETiteHIH/deyto0WjzmE4QCELI91C/McKVbO+oRNV60dhnw+LezJwhsaXMBMFWzocSa1uC9SR1Yi7k7nAcLmzndeW7M1IgiCah/vlSQakpGZonmYm1qzAbkdFlsAbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDxImB31e2wRj+NGD3gAtQtcBBefJMvP7Ntap6D7vJA=;
 b=b9SF66YPbRj++VY7w8JF5mW+xny0yqwqZlpzyDM7QDltIVKPEYG4fN3eqzirfjmxS/PhZ1c6yMpRNdK4h2QZm/Ejq/lZNXmVuqBnT9ehUR/1DDkdyuaGVpSRF1Stg9fxFrSDbUPMVjeJ0B5nnSp1jy5Idjtc+oQDTQxQ/Hml2Cy9p7Buk42vhqiWbhsJtm3LUKE6oJ+rMbby4HOjiQPmEzK+sk+zwr5EPRCdOZU96zcYCrkLjkuJ1eBose5ziePMADdIsENco5tzxqknfZDR5TLSyQ+pAByhN5NB2Oq8/gXSEvGv7v4HaEPTviYPtFIs0stHte+4udYBxFtUoatgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDxImB31e2wRj+NGD3gAtQtcBBefJMvP7Ntap6D7vJA=;
 b=R86QuqL4ROhfX4S7hhCUiyJNU3PaXXRP5JdWH6HrbNtQ6uP1L7v0GbV5RsqrdjdaMLVLKur+M9nMAie5qhDXHLqa9k30CzCCklvqap/vIuNM1kbyjBQqEFR8dHm9d8C22jpzQlncGiNdGnDXiQYozdvMmtue/I44bkl/tXATue+w0rl5jD+AdGhuG4a0/FmtlsMfIhKY1el5lorI8iKLM4KL7dPol7GcroI5mWwYVuQF3AFFOX1fRsjz2VYBTyo0yoLzu0OQ2kdIw0ASRp0g/aqXfJADDN6epeFu6pT9m+jmDSkwHkE9G5kPFdszYKj3oKX3JVnn5uMjcFjLlR3IWg==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 9 Aug
 2024 20:21:11 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 20:21:11 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Thread-Topic: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful
 shutdown
Thread-Index: AQHavAVnSip1teEVHEWRQznyc68BkbIfuw5w
Date: Fri, 9 Aug 2024 20:21:11 +0000
Message-ID:
 <CH3PR12MB7738B275AEBE6B167CFFA308D7BA2@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20240611134327.30975-1-asmaa@nvidia.com>
In-Reply-To: <20240611134327.30975-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|LV3PR12MB9096:EE_
x-ms-office365-filtering-correlation-id: 1d8aa7a3-26b2-49d8-5ebf-08dcb8b0cf9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Rpq7Q7FLRfiBGQrO0vlGOImRd7G14gwQkxyw9CbcpgeaXsSyNA3K2WqwYVHN?=
 =?us-ascii?Q?nibFkozbICyni5KPx2V5T6N8R4B+MV2s+5buUhgf9CFvwJM11Ctl28GqguXC?=
 =?us-ascii?Q?oEVv+5NW3kgCFlM3WYRr0HObT1iMEDi74x2kVeH0pn+CwL6uhNjpqO4Rw6yx?=
 =?us-ascii?Q?1roi/tz3ocPpnuryOt8B00sxXNgOoxUcSjjsK3mRF048nPgfY2LyPHy6os3i?=
 =?us-ascii?Q?IKdYyllqL5dQ5OhzQNTL0mIl3YJGjKZ6XoMVapWEL/RK70N02RB/O+jIRexE?=
 =?us-ascii?Q?hg0ZVBglVeCPmRrBqERCPTZ7wI+KOkQyc8aqiwC/tEfkD+SQNN3tXXiJQ2cQ?=
 =?us-ascii?Q?8GQR+DQkc/4zqEpHiywtCHEeGtVpT7Xo5e6UIywogCRj10Z7mi6V8wwKZI+r?=
 =?us-ascii?Q?XAevXZdyw9u/sxTHCwgTYUtiXdrPyN98p/yYGruK+cu5TOJp2CL9080RHVWZ?=
 =?us-ascii?Q?U+kRLeaBHO4wmnB0KNSb0UiXWaECMFymHK8W7wzN228amBJMxQlxS6ue5tZ3?=
 =?us-ascii?Q?0JaLZQSylOaCs0ZzF/ISVV6D3CrsWe2nD+IzvJNxVG5uOojTgpsSiwav8s5X?=
 =?us-ascii?Q?ISZdOaOzFwwYq5ldCTX8Ceu3us2pGVkEcz3f7Y980+B1VS2gJxR1QQ8Oks0z?=
 =?us-ascii?Q?l9hfass3W6HiMdHjdxDvd9+OG5Z8j87kX6QAB0/nuYdVqltqgiluMZjAWpwb?=
 =?us-ascii?Q?TghIbt3taA2kY+CIx5Y3LvBIXsXT3lLPXP16n+nKI03Yx44QH7vsTw29+Nd4?=
 =?us-ascii?Q?SCk+AXn4WlJ3XHCnwLftAE1HQr6QJBGleffaNgJ7p2zLOrMWC7JNTe0tIJQg?=
 =?us-ascii?Q?yozJiHw8J0d3JSHRBOm5dSTerC0enpAOvTneAh/iKvPmV7nHUM6UqGDewZ6e?=
 =?us-ascii?Q?W62UDLmzOXYp6tQMrxbVqabVMGL/8G7jCGOYAZaKuL/69Gzp9nN2Hbhd5DA7?=
 =?us-ascii?Q?bWiWEsfETBQUf6xf4dsK6AM21vCjCBDMNoRD1YJuvpleUzQLv0fMe+NClVW1?=
 =?us-ascii?Q?Lji+2pqfEMWP9DsbZaQqFsS5SQDYyRerkp+ElTETN6rzwcklIezAEOZV0m4I?=
 =?us-ascii?Q?VwONhqWLM4P6i8EYAcQ0eg/5r0hs2NUcprqzKEch659pI9usqVGy5DDNo9RL?=
 =?us-ascii?Q?i8sKNFen6ArQz2FxB+zI2oWe6ES26lr6z8VqaMejzgGjXCpjyOw1Jrw46OxG?=
 =?us-ascii?Q?MK+Fyr6sggywfIjsfEyD/mJ/BCz9RE1bY1JAt6Y28YX6Z4skMWTMjiqb3L2N?=
 =?us-ascii?Q?mZlY6f+Otbw6oPFwzB/0Idg3MzvvGOTs9cJFgUw1mtrZiyuL99Zuz6AOyPva?=
 =?us-ascii?Q?CyjxWVqiN8Wa7MS4I6dY6saxSApxwEepl2o0iRqoNryKVJTjMphWKTka/J3c?=
 =?us-ascii?Q?Uo6/FOOIH0/DOo3L/lFRc4dH0WUMxtQohMHw/xdi4JOsdWk50g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OjsIF8BQwuiYY9qvKOE0Tx9+Xzg/tAnlDILzzgR4OljChtGBwL0OWUzh6UtP?=
 =?us-ascii?Q?v7DAAdYsi+1Y2gTQEOvb3PE7rGLjVoIaP6dt3pODTKWxhXTDpvFOw+MIE/Kr?=
 =?us-ascii?Q?OBR0XO6doJUlyceMDgM0a+OwUqylRg4wgoC51hgKspm/pv1hJNO2102C5Fzm?=
 =?us-ascii?Q?EQ+HKh/g+kWH9MDrDfPk+f5nHjFh07eO0vuy4XE1WFQbk7kAsDN/mZkK1I4/?=
 =?us-ascii?Q?J5t5BNP30WMlRHygDkOxw+X70DnTJ2+DZFjnFXRYwAqTOmfqAtL+vcl9W3gD?=
 =?us-ascii?Q?VBUIqFvvgfCNb5T7l+kvu7GcOSFd9WSCWYsSRKstO+zIg1Hevzfw42m8rzLW?=
 =?us-ascii?Q?VdK0d+TzNrTyzZhsCVr7IGW7+X23ztslBwlskUeLzM7CGO2RcnQms4gVL2js?=
 =?us-ascii?Q?yz4b+XJ+be2UXMvu3VIIqjKqqfe/8Ny8iBt2PEVp5eZK3vxCf0mDYHKgqxWs?=
 =?us-ascii?Q?hqeYVhQDRekufEAhrpNt7MnN1SrqFRG+oYLFh43nbJzPtEEkDq0MVENAxHAj?=
 =?us-ascii?Q?jo+vClHAQNpmOpmRTQ2zELQFbvBFnfpA4rousjBoVgO8Ytkpt/khZo4LgyVf?=
 =?us-ascii?Q?zelG0+WicTIFGncJ//wIZZmC2OPW/ktjSrUTEesDWs5WoJo5Yk3NPGh7Sb2k?=
 =?us-ascii?Q?gGXx8PWhWm/zwkv0DTM3eksKaINzfk2F6qzOUlA+Gs4zD4wkCVngt1bUKcb4?=
 =?us-ascii?Q?V+M9Yw9ac4CXQAUPy4arZGUxqvXY1ysg3URjPGOwubOu1o9ooPKg/lSOQOrF?=
 =?us-ascii?Q?FomUxVC9VibxsZqIzOAzza+xZEB9FMyCQfKAtEbykPgdx7xBIayd8Lc5jf0x?=
 =?us-ascii?Q?LxehzjBvZ2MyRS46H71D0YxcOw6+As01NKvZaxidZWhSuG7AsU6wVRcZBzYN?=
 =?us-ascii?Q?Sr8PEUscOwo8lFrDUGRn4NIxtMAG84GH3MGEYYu7X45sjgkzsqo/sQ56FLvo?=
 =?us-ascii?Q?S0BmI4bW0v4QfD9G/LSLgjTZ5z7yZSnA63UTybwLKsIoEvbmkhI+2cl2MxpM?=
 =?us-ascii?Q?3z3hUMv9+L5TSxH7VIZwrctYdpJohYB2HRc7FIiwSqmcjYPeNfSW8IDGMgBf?=
 =?us-ascii?Q?VSaIeX6A4epUznkWb8+tfbaxdM5ipkdk1Yi9Vk5nLBsoa1MUqORa1hjKFhG2?=
 =?us-ascii?Q?C1gUXfcEH9oMMl8I9htYsPoPU1Okx6DjMeN1/Td7Resi2++xSF6mUudxeCAl?=
 =?us-ascii?Q?jQeDP8lo9wDXBgTn7LZOenW6p25MrwYvShEbnvFV+od71cHUfiYfsHkszB5f?=
 =?us-ascii?Q?lVFEAQagbABI9GdVbXnUbkSf/DlEkEj9SmjixsaTx83E7aVIIMfYQ9UqeQ5L?=
 =?us-ascii?Q?4sotPsteI5d5MioN5JjUz+PCE1/PCvNNddi5Cd6cfYLXWYJt/0/HPf+fb3MP?=
 =?us-ascii?Q?0nKoe9xe2DKUXcHkebnsUgbspTY4I6NQbqPGY9T2IwXW/2yIHp+/YOqkoQ7Y?=
 =?us-ascii?Q?ZF4mVnIu9sdsU5+Ml2KQmexo9wHXzuC9SbLyI1LrwrAGJ1bqYgTnwse2W/9D?=
 =?us-ascii?Q?W/6mUDSdnQTLrGJuUBUF00Lz4MsL/n0kaN0MYEbkby6uhLgXCFmq8EzjmUUY?=
 =?us-ascii?Q?LoepkZyx6VXUm7EnVHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8aa7a3-26b2-49d8-5ebf-08dcb8b0cf9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 20:21:11.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Is1zKS7fDcdYpG6Z3qWukDq3sGhRWZUO7G+FXQRkjbkSmVdqQ8aClRDTtz4J7mFUKhyQz41i3udTb68AFldChg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

Hi Sebastian,=20

Did you get a chance to review this second patch?

Thank you!
Asmaa

> -----Original Message-----
> From: Asmaa Mnebhi <asmaa@nvidia.com>
> Sent: Tuesday, June 11, 2024 9:43 AM
> To: sebastian.reichel@collabora.com; linux-pm@vger.kernel.org; linux-
> acpi@vger.kernel.org
> Cc: Asmaa Mnebhi <asmaa@nvidia.com>; David Thompson
> <davthompson@nvidia.com>
> Subject: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful shutdow=
n
>=20
> The OCP board used a BlueField's GPIO pin for entering low power mode.
> That board was not commercialized and has been dropped from production
> so all its code is unused.
> The new hardware requirement is to trigger a graceful shutdown when that
> GPIO pin is toggled. So replace the unused low power mode with a graceful
> shutdown.
>=20
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/power/reset/pwr-mlxbf.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-
> mlxbf.c index 1775b318d0ef..4f1cd1c0018c 100644
> --- a/drivers/power/reset/pwr-mlxbf.c
> +++ b/drivers/power/reset/pwr-mlxbf.c
> @@ -18,7 +18,6 @@
>=20
>  struct pwr_mlxbf {
>  	struct work_struct reboot_work;
> -	struct work_struct shutdown_work;
>  	const char *hid;
>  };
>=20
> @@ -27,22 +26,17 @@ static void pwr_mlxbf_reboot_work(struct
> work_struct *work)
>  	acpi_bus_generate_netlink_event("button/reboot.*", "Reboot
> Button", 0x80, 1);  }
>=20
> -static void pwr_mlxbf_shutdown_work(struct work_struct *work) -{
> -	acpi_bus_generate_netlink_event("button/power.*", "Power
> Button", 0x80, 1);
> -}
> -
>  static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)  {
>  	const char *rst_pwr_hid =3D "MLNXBF24";
> -	const char *low_pwr_hid =3D "MLNXBF29";
> +	const char *shutdown_hid =3D "MLNXBF29";
>  	struct pwr_mlxbf *priv =3D ptr;
>=20
>  	if (!strncmp(priv->hid, rst_pwr_hid, 8))
>  		schedule_work(&priv->reboot_work);
>=20
> -	if (!strncmp(priv->hid, low_pwr_hid, 8))
> -		schedule_work(&priv->shutdown_work);
> +	if (!strncmp(priv->hid, shutdown_hid, 8))
> +		orderly_poweroff(true);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -70,10 +64,6 @@ static int pwr_mlxbf_probe(struct platform_device
> *pdev)
>  	if (irq < 0)
>  		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv-
> >hid);
>=20
> -	err =3D devm_work_autocancel(dev, &priv->shutdown_work,
> pwr_mlxbf_shutdown_work);
> -	if (err)
> -		return err;
> -
>  	err =3D devm_work_autocancel(dev, &priv->reboot_work,
> pwr_mlxbf_reboot_work);
>  	if (err)
>  		return err;
> --
> 2.30.1


