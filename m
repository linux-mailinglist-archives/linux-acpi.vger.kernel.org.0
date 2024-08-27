Return-Path: <linux-acpi+bounces-7859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFE960238
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D471C20FD8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68A142E7C;
	Tue, 27 Aug 2024 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zl5dxS1r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8110A3E;
	Tue, 27 Aug 2024 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741341; cv=fail; b=YNBL2bsaAueTGon5oQop/3UIRVySca892bIXyad9G0SlOdvBRMMj0a2107hDPfA8V1Y3Qobz9+8xFY2b4wmsGARzC9LFMpH1Z2s6ZM7KFU+wQM+24KSV5Fa/lsMYbz6TCKi6+7lTD67HcN0BKUfzCsbj5ox+JL3vSESg34vpSQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741341; c=relaxed/simple;
	bh=MEEYPCRJWvbx/Yu3wZm7D6EvhaAjLHy6yRTD1ZJC0/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgfNqceX2OAzY6hSLd/qA/3JmRW4tIVPfKfSCk0lX1BqAxWigAVZdGWvryEViFKAvriCudWZ/rP43JKmyOQUMgZd96tPRfpqLkIXOFM6Hn9vTok03lcbG8ycMJxqzqRQhh8WfCgWPbP82grv5CrIu8SapGU46qte0XO6d0JfQWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zl5dxS1r; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwcLJgpUrWKplxItxGgnm1m/VOPnk8eMdFtlsdgBWEDdGNsYaJI1nVYdaTAKjvD9MeYd0C/NvpMTrCXb9N3pJFzqCsFcQ2Vza7I6JjC8XOd9PXxjvm9TeolsV7Mm4HOas+IHjCGkI6ewkW4bjyjYZ2RzPKMicVLthBFm1oyYYpTy5nyFsW2E8unLfjp0ziQvc0OMvvangRyDnnuM4JxTyakv6QQPOX/yhG+dJlT/iWu9f8IipfCoFBop66u66+aX1+s+Wsn8rCBtfuA/HQsxciaVYQcfhhAwb3rLe2Lwdpp4fclsykC+oCIIf/036FsXKSdhT5EwNGhowUCmTkFF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0OZ8P0XXGHfRNih2brws5sCikJiZ+rbFI7P2h7W+Co=;
 b=U28EXKYhxdmV4uCef3/tyj/pAs0OaN/ZTE4xhnYNrAdMlw9LgGhP3ynSim4S5NIgCgBsRr3NzG3tT9Z0EBULbpLO0KUW7JIKnqBozdwEJkbLKcKhjQt6QQ6Yh7u/2r6JpR19ry/G8Uw3oqzZn/X2VrhRwhhk2TUrlFfQqzthsRdg2MdDHteeGFhzmnMsYaEp6gmvjV98WI7EUovdhcF16KXMznILyfIknlN1hKqdc8mlrMz+UrYI9o2jjBt7igmwQWo/f8EOnGfGGFyWwovD4H+KRkRUd/5Z7p4rZ6aljHS/BaLkAB1mbR7nREZCUi56M2iS0NqsFYN0UemSr8s9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0OZ8P0XXGHfRNih2brws5sCikJiZ+rbFI7P2h7W+Co=;
 b=Zl5dxS1r+hNqwM9HQrMF+dsgN5S9xjjcLxFqf02g6Cvg6ucslyNriyrerU5mKAD4c51dUUIqu0IqE8pmtjMMjkaCjctbiC/yNsjJxWq1Dcvl2l9LhaGbu2WtiFj4suvxyC10nsGpraMTLhxN9AnRqm9VwTVJ4Lp+KaJH/WRyt6A=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:48:56 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:48:56 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT
 AND 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 7/8] cpufreq: amd-pstate: Optimize
 amd_pstate_update_limits()
Thread-Topic: [PATCH 7/8] cpufreq: amd-pstate: Optimize
 amd_pstate_update_limits()
Thread-Index: AQHa9/0nTmOOr/V3akSzY2XTwVGPorI6qhkA
Date: Tue, 27 Aug 2024 06:48:56 +0000
Message-ID:
 <CYYPR12MB86550D88264815DA8425FF259C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-8-superm1@kernel.org>
In-Reply-To: <20240826211358.2694603-8-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6d4af297-a9e2-4a97-8ce8-6d69735753df;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:47:52Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: 1125d274-c2fd-4e81-d9d4-08dcc66452ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zunRQl1ZSroYYf/335Q4q2KzoKN2nBFs2HAYHF+akA8FJgnZaWT5NEMiwDT+?=
 =?us-ascii?Q?uxniFuUwtsimHW2Ih9ZLPI/c4AJBqSRdLBK32kFlTnnVJSO8FZb3V/f0/G5T?=
 =?us-ascii?Q?6MW/RSz4En71Ck0zQ7D/QKvOIrxGwAhJ9ANX+CJqWjsjhfSYWFVT/PBxLbX3?=
 =?us-ascii?Q?Dl04XS7M7p+rc1x2S26RNqBkJXn890ACcZfjljHPApNId0chmreIEQ7PaERX?=
 =?us-ascii?Q?uMnAUmO4fdh/rGKFJdXo/8Z+vS/4pPwCTSkyj/nt13vuyKWvs5Hvu4ZtCaZa?=
 =?us-ascii?Q?7HYCEcNqoiAl7/2ZLvwlnsNcnNZMGfJucDAivJvsr5u9kk1bLDK9H2EF3dbP?=
 =?us-ascii?Q?lWOJ0jLW1uMc98o9rzr0uox97boXNbie4wyo+t4/EmqAP82SAaTD+XZeVGvi?=
 =?us-ascii?Q?SxHi+6X1BJ9vxChol2qXxPqj+Wmar/UAk7F1Baf10DE1CPF3sW6TnOWYBAP9?=
 =?us-ascii?Q?FwB8pJ5T/TbkY0NV9N2H2zvZ8b7tuieJ3uf3ncfTZpMl9ndye13xFA/Eg3G6?=
 =?us-ascii?Q?hsRY7xyb2/FL6thmAa91rJXYA2cFBSw+kpfrNnhdpVyv2qf7cIHL32vTcEfV?=
 =?us-ascii?Q?hHSIcpF7O0RICG3bdJxdm4jf0cf7l5xJgAaoS3mdO3G8+T0ar0X5QxxTvljV?=
 =?us-ascii?Q?ihxFTfqkA07WT2sjgY7yi7h5gVgP8ReW4FTwdThxNIFMmTG7ZdvqNGAV2GMM?=
 =?us-ascii?Q?Ylrkz2AEsnKA5qeSc56lzFy5wQa9x58TzmNFRXfYwiDP2GPNsBMp7Ms5PGlP?=
 =?us-ascii?Q?jCQb+PFgsJj40q+jrnb4yuKwlgYeWyehE1SNFRkZOajWJ3dWsVCrX3I2ZcO0?=
 =?us-ascii?Q?r0dqP3MnN5HTUON2dvRB9u4zTo6tMOG34RjzxqKvGWAtqQx8bJ5ROm6H3H40?=
 =?us-ascii?Q?l+8u7X/dfDS8AFqwMTy40BkPEgHkOJ8/ShV2P7E+ZEncyS2THtJM8WjewtYT?=
 =?us-ascii?Q?l/jtxYnCTVCPoe3eh1UVzPyMadzZnSlR82DdSzX0gFhSAxTmEFIgSt4jgxAK?=
 =?us-ascii?Q?WS8GzkhOSeMju+iAz4uI+/Vv9hag2DFk28iZhsaX8akTHnkhzR8t7K/HCypX?=
 =?us-ascii?Q?MR+JThH76QZnoLAmZ7P3oyaDUf8wFabxzw8yxoGGKofOTukErWnjSocE0WKo?=
 =?us-ascii?Q?37H0HVljFwdC3oSZbosDHu4iiZHrdym11/FLH0lsMHBb0Rn91kjzkoOfV02x?=
 =?us-ascii?Q?nETnSonEBaCJV/alkbzo2QiiO9Gxa5FvD/3SxGykWj2wUxWS1pLKcYE8GoFO?=
 =?us-ascii?Q?IGaFToCZVJ05ZtL4puxg66lZOaOyBmHrMKCvADH3A/ubiHTE36OIvRmdSBfl?=
 =?us-ascii?Q?duZ/wpK+WLRCUbfXcVGJSrlb6CWuHFdikn5sY5AewiDKFEYIQChaqRro4uam?=
 =?us-ascii?Q?qy7xmPn8BlQigBK38qOc2bjwwv4EauiNoGSk773gHWDVupAP0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MTaoJjjfle3/6vO/8j2w0ONrJjL8Afq/2vqIDIjl5D7fHjuAiwJJjKV5zZ8W?=
 =?us-ascii?Q?yJF3+bL8cxZu7eEXNg4QHs3ISnnWYkGV2h6ttBuu3ngmednc5w/NyAncryWL?=
 =?us-ascii?Q?j5VtuYztQfWE+DVsXjTiJhe9E6vfbJ/lgJn7+yRu+5D1u9Vau7clC2TJkaub?=
 =?us-ascii?Q?UdI4h9Rxf9pbtY8xM+09A+Cwe2YL64X5TACkbmGArz63BjTIQjOMwPawACLM?=
 =?us-ascii?Q?C2d5gid9c8gxn8GoBy+i2dr7J6cZleKOfYO0RS+QeNqmLxgLWfveNMj5pPGB?=
 =?us-ascii?Q?z5y1G9JrBXMaWgrK+arwQFy/O6T2/6YN37KvegaqbNWyJpCkIU5DD1GoUtAN?=
 =?us-ascii?Q?++k06Ndv+S7AA4t1yBBwcosCbZDTzrTJPdaxuO9NIL1AsJBtRN9dRR3Bgs27?=
 =?us-ascii?Q?PFyTJt6iT+ON6EJKp+WWaMCORNNtHCt1+TIA5GsgUwNjyYgTFMIKQlElwb+X?=
 =?us-ascii?Q?zu/ldUQ4VZDzr7LS5Z4rDoFAqG4SXKeeiqwhVgCAGv9jsU+mLRMlPKbD5aht?=
 =?us-ascii?Q?ABLdwSgMNaccwzfJsLSf6yZjjpejGXGrO9cXlNeLDvunq5cNHughdVYImjae?=
 =?us-ascii?Q?fFrpqEBe/iDW4ZW3BAQ5LHg7ylCnavH5qcdJhVAD2GJtMFZFAQml3ojdG2VS?=
 =?us-ascii?Q?dgF3cg0ympCJQROzVDFt1iWO3JfKcKpMcXCbYZT5CgeYls2uwCnItaMapVMq?=
 =?us-ascii?Q?0cDWU/pOmEo5Jl+7z5Y0fYYKdHaZRVzmAjcxCHc2EqpAM7dIjRv1hvus6Emn?=
 =?us-ascii?Q?y/jDDu8b+ItOcC1gMgGhJ1UHJEpwviKYrY1Si4IFpxTc/YJD69ZcSWvOzrGs?=
 =?us-ascii?Q?V3q6w/PXTIQGMMzTXr14NZA3xfz0Z0OUXZbwm/sVIearNgKpiGkDHXGfoULS?=
 =?us-ascii?Q?uM2x1ViFSV3mG8tgoc6iY+L64oYzZajtv3k4c4abm/TaNCuc03e7/vHU2+c0?=
 =?us-ascii?Q?X5Lhu9felv2mRF4Rziocx+aBj5PJlmn6CaIS2jZ9+fncVbETttRI9CLrBNJm?=
 =?us-ascii?Q?GdvHdtnyoPBFLK7W5zy4cPSdbu1nqTWXKwUXOKoq7ifY94Yrh9M2Q2IAWF/H?=
 =?us-ascii?Q?HcodzoxCGcHdhts1ZI4me96OBbh/ShgW7Ac0JJGlgSbabgdbTocRNlAlNZjR?=
 =?us-ascii?Q?fbjF2wFA17OMOfKK3DtIZZlRoh6/PARBGUjIm/EsMUYrw2SK/TpkWgU9qtjQ?=
 =?us-ascii?Q?lgRDlA6J+pnN6wLG70bkzyCLaiCfjM0KCHZUVRdEZK41Lb8eQWDTtPDmaks4?=
 =?us-ascii?Q?CkcJ79gRvISetFb7HOZw2XX8HdGDgQNKJdrrkeigH2OVro8A5DovVLGGvjlJ?=
 =?us-ascii?Q?1qALq1D6gNmoYU8nTJ3uVFjKZwjnHD/MXGjH2dBMP0vpGw5ypUNWtDCOD1lI?=
 =?us-ascii?Q?GTEj2eRBTtOGOoZ1fsjiQtmTUqptljkNoV1QcastIa8YH1Ncdk2YQXn9X/Lc?=
 =?us-ascii?Q?LPoT/FZvdFx33/dxKSOMC/eg+1KONOO2UxrPE+vaRZktHki0VGEeIAcRU/O3?=
 =?us-ascii?Q?OCrJ6mvOS7lJAMFFSNj2Cv4+IDt+1+lgug0KIfesUWHq3G97XXynx1jd86Sa?=
 =?us-ascii?Q?Hyp4FzOTiMSJlYJGDx8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1125d274-c2fd-4e81-d9d4-08dcc66452ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:48:56.5350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWiiy6q2iVzCv5C0iuBhZzUNfBPti2vKu0rnNmXNQX1YRKxHyplY5z00DVyH46goMf8sgN5dH0LT52Ec+F7DmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Tuesday, August 27, 2024 5:14 AM
> To: Borislav Petkov <bp@alien8.de>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT) <x86@kernel.org>;
> Rafael J . Wysocki <rafael@kernel.org>; open list:X86 ARCHITECTURE (32-BI=
T
> AND 64-BIT) <linux-kernel@vger.kernel.org>; open list:ACPI <linux-
> acpi@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 7/8] cpufreq: amd-pstate: Optimize
> amd_pstate_update_limits()
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Don't take and release the mutex when prefcore isn't present and avoid
> initialization of variables that will be initially set in the function.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 75568d0f84623..ed05d7a0add10 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -798,17 +798,17 @@ static void amd_pstate_update_limits(unsigned int
> cpu)
>       int ret;
>       bool highest_perf_changed =3D false;
>
> -     mutex_lock(&amd_pstate_driver_lock);
> -     if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
> -             goto free_cpufreq_put;
> +     if (!amd_pstate_prefcore)
> +             return;
>
> +     mutex_lock(&amd_pstate_driver_lock);
>       ret =3D amd_get_highest_perf(cpu, &cur_high);
>       if (ret)
>               goto free_cpufreq_put;
>
>       prev_high =3D READ_ONCE(cpudata->prefcore_ranking);
> -     if (prev_high !=3D cur_high) {
> -             highest_perf_changed =3D true;
> +     highest_perf_changed =3D (prev_high !=3D cur_high);
> +     if (highest_perf_changed) {
>               WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
>
>               if (cur_high < CPPC_MAX_PERF)
> --
> 2.43.0
>

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.

