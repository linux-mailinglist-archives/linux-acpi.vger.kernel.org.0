Return-Path: <linux-acpi+bounces-20661-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOpJLrDFeGmltAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20661-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:03:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3856954D1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51C4830684A6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CA35B152;
	Tue, 27 Jan 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCD/Ey53"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028035A952;
	Tue, 27 Jan 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521905; cv=fail; b=u/geWwmBc+frKaC7wLm1hcAXQDJg+NynlmguY9TrWth7VEew+iHgBhI54N4KO+79RBX3Mab7f/8PHCC0H0dxcJZyKQUghONOYUIExE4lGDA3I6bVlF9FP3meQReLJKAgt2vssOgqwaJjjHe5WDsIj+m5A8od4Uizgu9ny8UqWbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521905; c=relaxed/simple;
	bh=Yy8U7pD5sRAiHFk/JmUwVgcTy/fWe7vUeYf2PXQtBaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UgS+MgI6/Zw2INmkqa96PW6+6/+q7xfkBkcipF5Vuf4pYNmOXOSXjHluSLqugPwlKcGUWUDJdx3WheYGkH+tFI4ytOTfKVjslDsyp6FqOYo7/+m54yy+vBPoZvFBZml+R6nGNXcVkrhA8khwDcTiVrmp8Yz7l5rcCV7xHXK5Z78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OCD/Ey53; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6YcqX7+3winfitVkwtHh9ejoiFaSZz5/VWbOBEcQAfI+y9dhcIuw0c1SYTES0ARsYLm3DchT9EtSm1USAYX26GpRvDC85SnDci6lgw34DQx5EMoMWEm7bXnDUrCChWL7GysFLgImvmA9nB0JsNfad37xo68I3EUYuJp+YukBmfRE/57FToOAPY4Bn4VxgTang+vib/bpilDmfvbur146/uX3s+XMfmK2jmMapCJokcL/DNXVc4ndSCmZII6eHG7kAC/ITeFRsQ+QQf4ALH+QeEvuoyVjntuB8yXya1iC3a57dRm1BmCdjdn4YkVeM3XlLdTU1AUdqthPG+X453YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=777FxNYHGvoQLh9RNmwrFp/jCFkAigrRVpO4qidmxAk=;
 b=U/e23Ci8iG+r98UF5/izNHmRvDaRPqp4O/bpZvhi/ccTo4MqbHMzbMxByJi+QMdlwx04XbhDGJpbmHPfH8EnTZpRhcvZVM7Bt4MUPj9dUHeKiIxXq+1wFH3QFOzhQ7Ydkv6dViHK1+sgobtc6mVrgcHLMcBMImI9UwCUq3yFoJYCJKd3tpZpS4KcVGKwGEtLFSagDnXJa73nfEs+qBaIxaiE1jhNaEm6C0yvrCD9Ee0kz+59yvS12bbuYlPPw2g6OJOn+imu1ef4JkwDozJjFE6wKme7kNiJeTrTsW/6QJbM8tMW0eTeSy2QFAwPJB445G63sXPHcFhFo9DPtMiclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=777FxNYHGvoQLh9RNmwrFp/jCFkAigrRVpO4qidmxAk=;
 b=OCD/Ey53ZkUjSefDvAeILK8aWKyndpWl2crcpr8kdEgdv8PNHQk+H2eJOSf+OdqtlmT8hMUQgYmgrkmhD2K/2orhmnDaIYQ76rQ8Mc33CI/XeW0uZRhk+UFwn05Z+/oJOPHda0wWw7pvm7NxL6S+PuT7HaOH06U88V3N6IsLwZ/D21hkMO6he6SbTS6bgucxRifipQW2euSn9rlOpeXfJFEFo1i6uF4OOHZCdE+sivt4qjtV1lI9Znt9vrGR99lWuOdHM1KJOn3hzGK/K2694Zi06fvZhV0XGsP+uS8IGIkCCNxY0Kx/G+GBUdu/oO2u0iLLnjXwOuCxr2SDIWNYPA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 13:51:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 13:51:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>, Yuntao Dai <d1581209858@live.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"mailbox@lists.linux.dev" <mailbox@lists.linux.dev>
Subject: RE: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Thread-Topic: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Thread-Index: AQHcjxf4DgFLbEkKB02YPJvzs0YZjLVl3e+AgAApT6A=
Date: Tue, 27 Jan 2026 13:51:41 +0000
Message-ID:
 <PAXPR04MB8459042676EF3E77D71C19428890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
 <aXieA6vpJEUvEKRe@bogus>
In-Reply-To: <aXieA6vpJEUvEKRe@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7614:EE_
x-ms-office365-filtering-correlation-id: 77a618d7-9f45-44a8-ae22-08de5dab336d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7a41j3h+JiIlGIHEkoyscvVUEGyF0PoSmhVFKVe9YAkjgmJJCHE6z+Wmrgll?=
 =?us-ascii?Q?EH83uKGQ6eTc7u89DiiFyKjoEx33DnWN0xMqjDKxiDK00+ZArbUX2Nu1JkJE?=
 =?us-ascii?Q?uCh/X5RfGWY8q9fj3/aE/eA/8X0QBl7HUqkqCygxSX76jUl9t3MRqgoRRAqw?=
 =?us-ascii?Q?n8ORtIKTjv6XsrSb7gbCDZVXtjUEElhiJNX2kNc1tjsXSF1lo6BKJlEJSuQH?=
 =?us-ascii?Q?Y9gSaqam2mcpXKohFslKC0TSRB1xgI8OnsnO8QrU3zeJs+1LsCIbORYIqERb?=
 =?us-ascii?Q?3aPpeXRrGxKKZGgiEnNJtyg5b4A2q6oHzp0qMRPihew7zbG82nvRG5viS6IO?=
 =?us-ascii?Q?UvJsZmYH7qe7dPFDcEOcTT+0PRpis/YzUCQH+/idGqhej0ahgqDi7KBbE+yI?=
 =?us-ascii?Q?yUSllcE02wc0KUu4ymn6a6LXSnpgZfllRnl44VZkXcIdiOPlt64SM8j/0y+z?=
 =?us-ascii?Q?qRgrqZvQfN2pxEycIE/nb6CmosBDZcU4dJ36yuFXEhZ5+aHC5BmTEJTCj6kt?=
 =?us-ascii?Q?pItgNySLt1YL2ipAA3uNsnke5Nh289Lv6hIcH1p4gIG9P4yGtjzXk9dcukmM?=
 =?us-ascii?Q?/tWNeMYefNQnWY81eS2wvVSzF+GokKloNfYg1cFIesJRtngIdYS06jR/g7/e?=
 =?us-ascii?Q?DIEvG8E8Ahv3YfAe26qsAm1nHrr76DXANNyzxY+GlQ02Qvb0qY56P7Br0jMU?=
 =?us-ascii?Q?+gU/N5jzAvYSpKnD4o8vXuOKh/tPdvS8nltEuMyGxGfo5V4rOd8R9S928mcH?=
 =?us-ascii?Q?oNp9m46ooF/S1CUVoKjYkXzmxlSZoyi7Ky4khy6sf7aAWlIn/AJiFWPccweT?=
 =?us-ascii?Q?AFnLD8xiN1Mq+8CKvvC/ErjA2BzE7obe6qS1e2DPYijDc1vOtOBjD/qmCGTi?=
 =?us-ascii?Q?+21djiqJpcJTFecWEMDnx96rnQ7Z8lOczxjpmqFj4dlR1X2AixApICWuA7p0?=
 =?us-ascii?Q?i7lKlY7gGpCefEo2/v4l8caD7woOqUFzGQBjJWlc86hXL3G2ya1V6v873BZx?=
 =?us-ascii?Q?o+ms8xrMkm04MMBe8yG9wnh+fnDz5tayMO5O2uL/fXkK9MW5TZRIedkHjMXo?=
 =?us-ascii?Q?21cxHsWYGwXe/5odD2m/YNk5FT1BTLaUygs1mCv6JyWvoKCYw0KTcbnlqTZQ?=
 =?us-ascii?Q?LHTNVsb/dOW1Ra6WA325EBd8Qk3HMV5u+fOxMu4w641aMkFuGJti82eJzwi9?=
 =?us-ascii?Q?SCsLtHtc40eu2QckbARerFFyhBvAkxVaw20YxlC8vwlmT/eHbuzHv6bGd2XU?=
 =?us-ascii?Q?8QncmjYPGLJhFR85/0novA/euLSDxh86WX2eMGCrpa2+FzR32w7p0BS6e0at?=
 =?us-ascii?Q?oH3+g5XrPU+MphejVSKzRFsvhXyJFQ8ol0kLrBLYGObNJSmLf3zP1tN5AoYa?=
 =?us-ascii?Q?EazRJtgE5gQLEd4rl1tjNJIiaNMZUZLCNM7LbOlaHB1GHsRV6x0frTlM5y6W?=
 =?us-ascii?Q?1sMM2JhQrGZZZDHw8AwyXwlkCs0vyvhWFBYv1sZLXZCejuO1G/Bnf6RsU2Lb?=
 =?us-ascii?Q?5dn6MJaF9MFF1CkMbnpoAvGXHYusxv5EE5EJ6cEIWqKqPDq+aEro2Nq5+t2W?=
 =?us-ascii?Q?P4DCnLAuA8tZupXV2h6z2CkEQ1LQEZShW9GKdeNkoQO23p25NTXiyQWlyW9e?=
 =?us-ascii?Q?G+2trg+3GGepewhjHnGLj10=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?73yOP7OPXfw7VWneKClfLeCHDEZW/S9B9FWTC8d353e53+GYt2LbfYGZrY0e?=
 =?us-ascii?Q?xNNf4bbaJD/uTDbWPVtZZIFw8Gz3eRp0QLD5AOV6Ppc1cYdSCdWruWk5/ag2?=
 =?us-ascii?Q?XcfAF45wmlAV54kovUG7VyxTi/njRspLgYUPtBMG3bUzsW6HcIfOJ9ilGcqk?=
 =?us-ascii?Q?tWUFyZO8+he9uyaq5+Ceih7xS6IDMuU5mM905rMm8KIh2y75RJoqflvW1o1o?=
 =?us-ascii?Q?UWuOZ7zmGTmvHWjcD+cuzUvVnUljXPGvbFGNI4kNvkeGbUizrzB40wT5T5y7?=
 =?us-ascii?Q?4vcXEfCTFgB0ioSY8hy6F7Q6yrm9T7dlB3+H4hygagSk59cl47KpV424i1eR?=
 =?us-ascii?Q?TuEhHaMALEe0uPdtNx1K6SAzrc+uBdCqanxw+i0Vowfhn+OQ4xQM2w6Ty0oL?=
 =?us-ascii?Q?KRJ92xw2pheaTxo0o4RrdaUwkSNBLTtgRwZIFVENZN8nn+CIgM0S8keKG8wA?=
 =?us-ascii?Q?TebZ+N5zzgO8Y+UH4sGA8tuRSdBgi5A6EirgPZDnGkmP9Ixwp55Waa4RK7Tv?=
 =?us-ascii?Q?IFcIZ+nNi2CQ/AdRJwgqD1FUNRNZZvll+4dM+JdWWeAXPR3udEeRmWRxs2Q4?=
 =?us-ascii?Q?Q8YPGuJFRF1ls4DnDHuvjKWOFqDMpVk8BRueO9o822/wx7qCDoGK90wpS1jY?=
 =?us-ascii?Q?0zriYlNsfE/F5vjEjcoFn1+ZYKY+1MxHWN1DR1ue824Qy6Z0cGA8rlZ+wh4s?=
 =?us-ascii?Q?4KOuFFIV1o9lLzSsNEg74MoF/wh3Vakzm/LDu1E6KPJ157f7HQBjrw/isUBG?=
 =?us-ascii?Q?OeB//xGZSdE9aouoIzrywEUgqalrp6xuD5K3gDizTDFP9YBlF4RJ4nOh1Zf5?=
 =?us-ascii?Q?jiKTXc+47g2VgVuTzdNJF60neSutGr3JZWxc+cHLolVhsDBWw90FrFVPOJSG?=
 =?us-ascii?Q?k3oqzWqJJrDPQBAFKs4o0/rja0s3D/ZyUGzj4oz+X1oW8m7iLEX5qOGxfZyN?=
 =?us-ascii?Q?PSj9ePUValXl6vPJVixn6oxNlmP72reFMUO1JbGQSwczPvyfIbObPRzeqgm4?=
 =?us-ascii?Q?Og4/ADVkR5dFY2N76IAKJ54BD5s7JjaKt5S4Evub7iBtnX7VlO3DMWHaZjPo?=
 =?us-ascii?Q?DFU6QaLxF+ITYRif5xKQSgEqfhEO1kJMM7O+IS9F75NX4jCrFM9Dq3gv8Qg+?=
 =?us-ascii?Q?FfPRj2nUJJP/tYdlg3G+4FlZVOMm2MzvgK4KNQ5FTpLTXSUeNWSL84lQfOUr?=
 =?us-ascii?Q?kXHeSzqPeHIDFPYxxF/A2h+8y7/kaM/JzZGiph4ZlCXEVpeyjugt4QMdp1Pz?=
 =?us-ascii?Q?KLEPJNf0mCS1MrqE0glUfCkl9bMSVBearhP3/39IRADN28/ZP23TYmrL5g4G?=
 =?us-ascii?Q?a6AM7Br1iEjd+8KuTrzuETyef/mZSj5zN/TMGx1310yxbmpOexqjrm2eCoGY?=
 =?us-ascii?Q?EMoUQlIdCZ037ZN5Rbit+Th4UF2cefak9+yiUbELQ1YYx/YC61R5XXD3Wx0X?=
 =?us-ascii?Q?VOVDLfSBttC2UuObeGqFChAyr6c9XJVkxGkPhHoCeIjO4aJ9KDvtykuP2Vhd?=
 =?us-ascii?Q?/sQeXWKSyLKPxcHe1zpwSK4fIjmi6SyOcLuLHzUCHIkvo/8EE0Eu3VXHGEgS?=
 =?us-ascii?Q?kt3s7g3MWTGq8oAHtz67IBpB1zP5BHJK9R1o1YPiLc/DmDW+Mo9tSSyJyTyw?=
 =?us-ascii?Q?6cU/qXjV73fCWtsusYNy5AZxn8saH5vID5aPsaWnPdbqmKqBvNaZ9z1SW0C1?=
 =?us-ascii?Q?yJUDaB6AFd2mIm59NBOEs4IH0IA7TKqOn9lKBAnTVdE4ojto?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a618d7-9f45-44a8-ae22-08de5dab336d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 13:51:41.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdbwnQP4OyHnJ+qp643vu9hLK1jzBQ8N0VYUeS8ZmFrVrJdnt+h3gpBBzy2OOlut6dON/Sn9i6O3BVjDQlnulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-20661-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@nxp.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: C3856954D1
X-Rspamd-Action: no action

Hi Sudeep,

> Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
>=20
> On Tue, Jan 27, 2026 at 07:02:53AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > mailbox_client.h is should be used by consumer drivers, not mailbox
> > provider.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
> >  drivers/mailbox/cv1800-mailbox.c     | 1 -
> >  drivers/mailbox/omap-mailbox.c       | 1 -
> >  drivers/mailbox/pcc.c                | 1 -
> >  4 files changed, 4 deletions(-)
> >
>=20
> [...]
>=20
> >
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c index
> >
> 22e70af1ae5d14e6e8c684fe032c2864f6ae4d6c..6ca84596e7637114f6
> 6d32a95d12
> > c863e942b756 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -55,7 +55,6 @@
> >  #include <linux/log2.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mailbox_controller.h> -#include
> > <linux/mailbox_client.h>  #include <linux/io-64-nonatomic-lo-hi.h>
> > #include <acpi/pcc.h>
> >
>=20
> There is a call to mbox_bind_client() in pcc.c that is declared in
> linux/mailbox_client.h

Thanks for raising this.

>=20
> You didn't see any build warning or errors with this change ?=20

I not see build warning or errors with aarch64 yocto scarthgap
toolchain. Log as below:

~/l/linux-next (b4/mailbox-v1)> ./build.sh
*** Default configuration is based on 'defconfig'
#
# No change to .config
#
  CALL    scripts/checksyscalls.sh
  CC      drivers/mailbox/mailbox.o
  CC      drivers/mailbox/arm_mhu.o
  CC      drivers/mailbox/arm_mhu_db.o
  CC      drivers/mailbox/imx-mailbox.o
  CC      drivers/mailbox/platform_mhu.o
  CC      drivers/mailbox/pcc.o
  CC      drivers/mailbox/bcm2835-mailbox.o

Esp if
> build as module.

CONFIG_PCC could not be select as module.

TBH, per my understanding, pcc_mbox_request_channel
should be implemented in consumer driver.
drivers/mailbox/ is for mailbox controller.

Regards
Peng.

>=20
> --
> Regards,
> Sudeep


