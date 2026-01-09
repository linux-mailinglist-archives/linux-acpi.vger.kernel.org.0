Return-Path: <linux-acpi+bounces-20088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6409D06D54
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 03:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FA3303C292
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 02:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CB29AAF8;
	Fri,  9 Jan 2026 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HdAjfh1e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010046.outbound.protection.outlook.com [52.101.229.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FA22CBC6;
	Fri,  9 Jan 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924915; cv=fail; b=eCYULVZKo3g3ZqJ4JHdS7KufAvKAR/IB2KLR/FNYKKh52/tebhDq2SAPxSjp9NREsxa2UWdDvT5bTIB71eEFcRyxX84lRRx0jdgskj63SKGx+ZhwY9HIjAqPE0U61rzU/h+lRm3XOdWUfoLSfyM6PEbiD6vkvb0eRbNg1gUoqyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924915; c=relaxed/simple;
	bh=vT6ptg+doXBLJJ0jYO1Lp5N0vmYxm89Z3sUzx5pFVGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XSnhDVSfqTKDAKM3XoTh2KLLJYSH/rW+HGbJQAZD67b3CMq8418PxUCrL9xCkvBBI/AE6Oc1LGAKzoVDgcvZTdpD/I4GhBvnLcsi99q6T+xRX1XJ36EYVYOg7E75r+ytl7y79jOcGFaSbbvjFVHDUkWJ9hw+B5MiNU7pNdg1HME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HdAjfh1e; arc=fail smtp.client-ip=52.101.229.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjPkjQnOG3opV0RvXieNoMSgLg5IilDrp6MvUtu2W4zEFru9gMh7vMC5DdqKqSuT0L9dRVG6rpF/MElKrzz8jX1VHZvGoKnJzTuqq+14+kBGvopjP1STE8Ex8fQu/0uwj6BFcttgn5anu5lo39q3zw3xnJZExE38XkswZLpMw4sm54a/qLmN50s3rBuPU0oSzoMrqh1ZVWOLagfUGfgXj954IL6Olj39faAVTghYSz13yfqTnz+03aWbJ8SCabouq02a2j3Nxm4CazVvlE8Fxp3FO90ypqPF36aqCE5PVy6dG57JWJo3Pui/IaJJ8fkhO+7ChsN5Q9kvTYK6i4HeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT6ptg+doXBLJJ0jYO1Lp5N0vmYxm89Z3sUzx5pFVGI=;
 b=C7Ml34qvPRvnl2LUzeEuDOMolW7dI3Hee4rMD6vtJWXLicsaKFRbNwP9NsGSbRnb5qw5yJRzyD+Nv2HPQ0KQFoQZ5/O1SnKCs5D/Sts76ReyHZYT16Dx5hMc8HCIp2OU/OTVCva4rJGEA7OK8oO37eIwbPYD0Mnjz4YI2sFazNun9XeRteJrAObxnCpU6fMO9KWPFjMF9PkTL2ifGwKcfEv5AHDu1GxeYLDllkVjfDGulIYPKe95CQ8I17kwVnfAcjzMxLuUja2aAA/Jq0ZG3npmrYfY/rT5pMYMXFA3nu9cxmdMMawTOB3DNkLVxH8//VuIB9pwqUUzn6ZmCa5sVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT6ptg+doXBLJJ0jYO1Lp5N0vmYxm89Z3sUzx5pFVGI=;
 b=HdAjfh1eJDqBfsOLmCiIzqFD3/GwEoD4lflObinPZLFepSrMFXM10HJwIIVdbIjOSayKVsR0BG6+yQnw+nzsoLe/sYntBakJqc8Th4brBQJhE6AKGF8BQJIz0AWCSyae31hEtxqDhEHwez/ZH4lLBVY3XfjAwhN8NyMC2tHCqUoQzjdA0r0geO/CfTiLYKycDsJ3syTbE3bNsUXT5H0hNAdpA4HpjaV4qBazH3fvnVEpM8dxEdso+jOXMXtj7NWh4l0ykOh6ede8CLOUYSTOumwWV+gMoC0myjWPXXdU8LgE8ZlSZF0AxoQ252YrD4CQcwby0esc+BRActC9d3x2ww==
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7)
 by OS7PR01MB14488.jpnprd01.prod.outlook.com (2603:1096:604:387::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 02:15:10 +0000
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a]) by OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a%5]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 02:15:10 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Catalin
 Marinas <catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Koichi Okuno (Fujitsu)"
	<fj2767dz@fujitsu.com>
CC: "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v6] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v6] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcgHRh/8wYXAYS30KxTHUO52hTH7VI26uAgAA6ufA=
Date: Fri, 9 Jan 2026 02:15:10 +0000
Message-ID:
 <OSCPR01MB1631084FB785C1EC4C01BB3AAD582A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
References: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
 <176790957965.1541183.5588102547570547773.b4-ty@kernel.org>
In-Reply-To: <176790957965.1541183.5588102547570547773.b4-ty@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MDU3Nzg5MTUtMjg3NS00YzllLWE4ZTMtY2YwY2I0MjM3?=
 =?utf-8?B?NzY3O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI2LTAxLTA5VDAyOjAwOjA0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB16310:EE_|OS7PR01MB14488:EE_
x-ms-office365-filtering-correlation-id: 07094a91-c83e-42ff-6451-08de4f24ea9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEJDMU5GbVhKYUE3SjJCUEt6Qm85Y3lId1RCTHJnWDBEVUtRWU5EdWh4NHRk?=
 =?utf-8?B?SUJtcXpON2ljNVdJSGpBcFc0eW5FUGJPUlBDRGRwaUpRYWsreFJEdGZqSWdZ?=
 =?utf-8?B?THJHTk9pTmNWUWNOWkdkNFFCbWQxWE1uNTdmSzc4MkZ5SmQyb0orMFlYOTlr?=
 =?utf-8?B?aGl4L1FINVV4L2RydFBXbFRzY2ZaUHh3VkI4MWF2VCtidFg2dnlqc3NacUM0?=
 =?utf-8?B?dCt4anl2cWxSVG1uUGg0RjVTd3BRTEZMd2tXeWg4MmVWeEJpRk9DTjMxYmxo?=
 =?utf-8?B?azYrc1M5OUo5cDBJRGMwQ085VkIwaE1weDVtbjFWSlYycVprV1VzclBLKzk1?=
 =?utf-8?B?WWtZcDlHQmxsc3lCaS9iQ2tqZDhwbkNVN01ENGFaL1hSZ3I2TVdRNmdQR0JL?=
 =?utf-8?B?V3BBSUJBVnBTUC9lQWJ2OGh3ekZtSlM2Ry90cDluMmpKQlBWSW54bllaMzVs?=
 =?utf-8?B?bnlxeUVsbXdvbEV1Mm5ndHFZZmw3cDF6MVdhOTJZU3UzdXYrZlVwK0NwU3Rs?=
 =?utf-8?B?Z3djakpPcUZpcHNLV2xvSjRIczNYVXdVU09LVWVSYll6MDNQeDIvaHh0NFZa?=
 =?utf-8?B?Ny81RUk5cDJXSTdqZit1cTAyU0E4UkdONE9oMFNXeE5mSUUwTHJSWmVsS3hn?=
 =?utf-8?B?N2FxdHhSdDA3UUYvN2E0WXZxNlQ2UDc0SFV2L1NKUTRSUHE0ZWtqSDg3cTNM?=
 =?utf-8?B?UjBsTUduak1KT2xkT01xaW9uMHc4ay9uWGhkcFJKQVQ0bGxuMUNSMk9GZVFw?=
 =?utf-8?B?MTcxMFdUOExTVGwrekN5Q0x5dmJoZTQzMXQxcXA0UEJRRE1ITjE1KzNkM29t?=
 =?utf-8?B?NFBnSFZnOUNwL2MrTGNnT3VQSDVPQXU3bTJTTW9rV1REUm5QajNMTStXUThh?=
 =?utf-8?B?eEw1VjVhMlVFazQ1OWVkeTZBSG9EUGM5Vm1KRzJ0UE1CUmZ3YUQ2Q09hSHZJ?=
 =?utf-8?B?V3kwZ1dEYzBsbEpudVc4Ri9Ob0tUbDEzZXVSV1lwQnNKOGpJUmtydEVBK0NN?=
 =?utf-8?B?cnliOFlZWUljYS9tZS9pTTUzNGQwNjNHSVVHSHgvMGp2VWhnOGVWMkpvdDJj?=
 =?utf-8?B?YmN5SURtb1A4TnFxclVqd1BxMGY3UC9TTEQwWTAvbk1yMzlKNmVrRGNuYTk4?=
 =?utf-8?B?NG9RVSs4KzBoS0dHVXNoMUY0MVlxTy9xenBBdDRwWlFYREdtSjJOdGc1ejN6?=
 =?utf-8?B?YTNrMXlMMEl1ZlY3Um1CeEY1QnVWR1dEdXBKbDgrL2ZhQWYxaWRMSjRsNkNP?=
 =?utf-8?B?b3A4cWgwWGswb1F4S2Y3VEl1Y1J4bEhLanFQZE05MERSWkRVc3A5NFU1bEoy?=
 =?utf-8?B?bFFMYVdISEJJZ1ZEVlpFUzNvczI2dDdDMlh3Ly9yZG40YnNrdjdERS9xMkhB?=
 =?utf-8?B?eWFEMDFBbEJBT005T3BGQStxRHRkbTRRTGZzVjZsQlVwZGQyb0ZNdm1XanZi?=
 =?utf-8?B?OXdvS0tyVklDVEw4UDhRdGc5V29GQWFjN2xkdGFPVzdMVVVPSHJ4M014c3hy?=
 =?utf-8?B?NXQxLzI0a3JZYmRjcjdJMGxTR1dBUmV5cUNGQjZveDFYQUlQemVoNDFtbGtX?=
 =?utf-8?B?Ujd6dmtCWDhCVWtVSVBKZ1BKdjhhOVlqQit1dFd3R2VmSmVaMmg4SURyNXhx?=
 =?utf-8?B?SzRybUJGczNkKzlIdndDZW5nMjAzWE1wVHdYNWNlNVdxZ1JDY2ZtMTdxSWJE?=
 =?utf-8?B?MDBmWkwrWUlTY21UaEZTamprSVo4N0pZTWFjRURBa0dveWhvTFdLVndaNE9w?=
 =?utf-8?B?WDNoUHUxTWt4MkFSRGxZbWtxaHJveElTU0lnVFUxZ2g0NExJakNFOEh2UUgv?=
 =?utf-8?B?c0ltTCtXeDkxZTN2K2Y1a3p5SmlrZmdhRnhQaVcvY3dHV1EzRC9vQWVONVNh?=
 =?utf-8?B?RnJOUElhU1VrYi9PN1Y0dEIwQUJCbDlJd29Mb3Jvd0ZCbXRMWE9zeFYwRmF6?=
 =?utf-8?B?cUxXTmpjODhReUdWd0tDUUV5ODZJNmFRcWxHOTI2STJ4anhZUHBlV0dpY2oy?=
 =?utf-8?Q?G25f5HcCH/O8+SlIAmianHHHeEkMFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB16310.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWlma1pkaC9FazZhQ1IyV0tTY1NMWko2cHVINmQ3eHl3cTdxem91bjlGSXo4?=
 =?utf-8?B?WU9USVptMTFqUm9hRTJkcG1jU3BzUnlCbnY1OWtxdmR1SEx3OWJYb3ZDS0Zt?=
 =?utf-8?B?Z2lDR0ZEOGlscGU4SytrN2w0YnVGRFAwem9GZG1MQ2UzUHZ6eU5Va01NQUdO?=
 =?utf-8?B?cFl5Tk94NytjKzc4em5ZcGJ5a0FJZDFob2xRd2E5QmgraFBxWFl4WTZVRkpq?=
 =?utf-8?B?bERySEc1ZTZFQzFzc1NnVkYvNnljMTRJL1hwby9iMmxOQ3FwYmtPeWM5Rmlt?=
 =?utf-8?B?R2tZWlljWFpYbG9tOGRONDFiQVpLUVZlWmUvblZ0azVxRlFLdzFSNjJPcXBv?=
 =?utf-8?B?cFRtOUxGN1FNNDZEYzVJTTRHUFVoU1F6MlVUeGdSZDEvS0E4cXZtbDRlbi9J?=
 =?utf-8?B?RVJvT3EzcUFtNUpiNUp3aVA2Z0gzNmVxS2ZXUEdoSCtXSjhzcUpQTEtrL3Zu?=
 =?utf-8?B?TkdjaW14YU14UUQxZjVUV1l6K0dCVFdya1FDdkNPTUlNZHBSNzdvTG1FbEJU?=
 =?utf-8?B?T1d0blBFVzBCRGN3STBGTllyZk55Z3EzejVwWEdBTVQ2dDR2Ly9WZDFtM2l1?=
 =?utf-8?B?NjJyYTZMb1B1eDNzcXI0c0Y2RFVYalRMWDJtR1RJbDdpRHZWbUxQalZsQ21p?=
 =?utf-8?B?YmRCTjYvMmEwc3BVUGMxNGlzUGRMa0VNbVp0RG93Z2tSVzZtYkx4WlpmczhZ?=
 =?utf-8?B?b1pMdThzUnJiS3FSTVdrdDhxcEI5a1c1SGI1Wk9PY3VFc0MvdlpLZTFQSm1r?=
 =?utf-8?B?UnhITXJwUUUwOGE4YVdOWmhqOEM3OTNiUnpUVWRPeHNtMFI4Tjl1YVNwaC9U?=
 =?utf-8?B?QTJPcXl1YTZkdjlpYUZTQUtnanI3TDBIYkhwazN6bW14ZTdaeHhtcXFEc0po?=
 =?utf-8?B?cnFlTkIrOERTMmphekR0TlpseGYraUY4WW0zbWlhcHhXR1E2eVZGS29SY3lW?=
 =?utf-8?B?SjR0V1FKQXE4ZUsrcnUzSE0xbUIrNTlPaUlpM3Zoc0FzYUFRbEhuZ3IzRWRz?=
 =?utf-8?B?REZ2bG81SGU5dE9sOEl5Z2RZQmRQMXNqck5NV05rRHFHUG45QkdrMGN6Y3Jh?=
 =?utf-8?B?bVV4d0hmeHJDQUliZk5FcjArTFJ3M0lydUtscWFuWTJmVmlNVHRQN1BvdFl5?=
 =?utf-8?B?aUlTYnM4dVBTWUU5Yk4yZFJ5RDF4RVhsRGlBZkhZZlJqL1A4QW4xdWg2N1ph?=
 =?utf-8?B?NW5OYjlNZlBjRGRSUCtMMFZYb3djd2kyMHpxMUdCUGJqVUlxamtBdnNwUktY?=
 =?utf-8?B?S3pxVXo4S2lOVVYrVzg0Z096QldrZnQrZ2JobjhPNXVScnovRzVQVXBTV2t5?=
 =?utf-8?B?emxBd2lUVjFnTnUxYXV2NEhDN0ljSE9sUTM4eDIyWTVNSEk2MmJacWRVZTgx?=
 =?utf-8?B?L0ljQ29LRFozMWpwVFFrSmFrcFBPZEdOVzlTa2pXR2x5b3VBdEttUmlBaCth?=
 =?utf-8?B?bDBNdVRxZUR6NUtGclNxdzUyeDk0UnZmUHo5V0Q4RGNHc3RockgyMmRobVlK?=
 =?utf-8?B?Wjh3di9vTlJTMXBScko0TTVVT0ZZUVRMQm9NdU9Ya09GM2c5V3lhVmJHcU1M?=
 =?utf-8?B?azIveGhYa2RVQjdTZ2tZeHluclRlbG5WK0VTd1Y1UjBOc05kWGRaMU5GOExJ?=
 =?utf-8?B?WlJ5QWtBWnBheE0vUHUzaFk4VFgvNjdnUG5CSjFpV3IwYlJYQWZDdjU1eDBi?=
 =?utf-8?B?SFNKZEwyM21EOTRQeUZuaDBRVnZSeTFlUmpSSi9uTUdyZy9OV0RkWUxUVlBX?=
 =?utf-8?B?RUVaTE14cVh4dmFCWU1oYjdtWjN5eVlBQkw2ZU13dDV6UmNUbTk3dmdhU09P?=
 =?utf-8?B?WVpyQjMzSGxmbHg2ZXN0enZ0aVdRY2xuU09pTFdGQU1mVmZKMW05dE1jOStF?=
 =?utf-8?B?b29GT3BjUEhFQ2svbytwWVdrMkN3VXVEQ3NzRGlXVGJDQ0ZpbStQWnc3aTl5?=
 =?utf-8?B?TGJ6aDJUY1dURldyd3g2eTBNSzlId2FObWc4Q0I5clM2cjNWMmprVmZmVDIw?=
 =?utf-8?B?Zkpnd2x1cmJRaUI1NmNPanY3SC8zdFBzZmhMMC9ld1VxRStQY2tlU0F1dHcw?=
 =?utf-8?B?VTZRMVhmMWNhYlhCZERPRXp5Ym12cXUvMkxkREZTT2tmd09yTEFLSlFLc1hq?=
 =?utf-8?B?Z1JLWVlCRS92MnNiQnoyak83d2dCdHRaSG9kZk9JdmZvWjd2L1dVWjc3K0pB?=
 =?utf-8?B?UEFLT21ydm1nUWpOT0ZXd0pMTXMrS1gxUUhHYTVSdlNRWEtiL3d4Rlg3cTlN?=
 =?utf-8?B?dlI4QWJlN1UyYzBOT3IxeGpvYU5JMEZqQjBLMnJKb3kwekpYTGVmQmVyek9j?=
 =?utf-8?B?NGhxb1RMcnI1OWFmeGdXYlppNGwyeDYwS2w5emcwdGZNNjBzMzVjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB16310.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07094a91-c83e-42ff-6451-08de4f24ea9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 02:15:10.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1n4qUht/5J+Hkn4hZibTxp0p2Zl4CGM+ma6yUGAohyBTKGcjTRYeimuwALOAhXYf11dF5OKCxfVZLGbXk89IOFFzJknB2Ip1JkJietw4Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14488

SGkgV2lsbCBhbmQgSGFuanVuLA0KDQo+IE9uIFRodSwgMDggSmFuIDIwMjYgMTY6NTY6MDkgKzA5
MDAsIEthenVoaXJvIEFiZSB3cm90ZToNCj4gPiBBR0RJIGhhcyB0d28gdHlwZXMgb2Ygc2lnbmFs
aW5nIG1vZGVzOiBTREVJIGFuZCBpbnRlcnJ1cHQuDQo+ID4gQ3VycmVudGx5LCB0aGUgQUdESSBk
cml2ZXIgb25seSBzdXBwb3J0cyBTREVJLg0KPiA+IFRoZXJlZm9yZSwgYWRkIHN1cHBvcnQgZm9y
IGludGVycnVwdCBzaWduYWxpbmcgbW9kZS4NCj4gPiBUaGUgaW50ZXJydXB0IHZlY3RvciBpcyBy
ZXRyaWV2ZWQgZnJvbSB0aGUgQUdESSB0YWJsZSwgYW5kIGNhbGwgcGFuaWMNCj4gPiBmdW5jdGlv
biB3aGVuIGFuIGludGVycnVwdCBvY2N1cnMuDQo+ID4NCj4gPg0KPiA+IFsuLi5dDQo+IA0KPiBB
cHBsaWVkIHRvIGFybTY0IChmb3ItbmV4dC9hY3BpKSwgdGhhbmtzIQ0KPiANCj4gWzEvMV0gQUNQ
STogQUdESTogQWRkIGludGVycnVwdCBzaWduYWxpbmcgbW9kZSBzdXBwb3J0DQo+ICAgICAgIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvYXJtNjQvYy9mN2Q1ZTllNzAzMDINCj4gDQoNClRoYW5rIHlv
dSwgV2lsbCBhbmQgSGFuanVuIQ0KDQpCZXN0IFJlZ2FyZHMsDQpLYXp1aGlybyBBYmUNCg0KDQo+
IENoZWVycywNCj4gLS0NCj4gV2lsbA0KPiANCj4gaHR0cHM6Ly9maXhlcy5hcm02NC5kZXYNCj4g
aHR0cHM6Ly9uZXh0LmFybTY0LmRldg0KPiBodHRwczovL3dpbGwuYXJtNjQuZGV2DQo=

