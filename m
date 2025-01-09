Return-Path: <linux-acpi+bounces-10487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51875A07DF9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190837A2EEB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C73178CC8;
	Thu,  9 Jan 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Gk6ciCr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE517557C;
	Thu,  9 Jan 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441156; cv=fail; b=d2rm7tNqzG/GjvdntLLEOn4C8trcWzZjtIJYspvKF8FLGegc82u1xdsp/yMNRJIl7K7LOFhWudHHWLivS/ohz26wAU9tnDS+srxfnCnax5BpklQtKa9nodQmXIpqSTujaWON4g/J6/T32Dxk7e9+NRq7ZTrwfrJWfbXuviBujIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441156; c=relaxed/simple;
	bh=fb6QyuwL0S6KaRw9sCDVH7TSGBFj8y9TcoDOVgJ+8v4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ej/gz1RI3WB6ePNP+rWYDy1hkSC3DetViZTpwJIGzXMLfpHYNbh8zbpdKN+m1gKU8WNebIph5tqkHPw79HwzhoN6sYD8k2lGzIc4gcMFTRA8QFPLQB0HhbfD+7rxBp5BxK6K9W4C03QtflW4JUaoYNeBY3z079MgnhxjPbSgaNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Gk6ciCr; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvnsRBQNsTyOSRhr78DUpcWni5vXsqEHZk33OJbieD2nkQcCM+/mcxtY0QdhBc2RUiOVGXl1RxZO7u5Muv42i4yNJBMo9M6S6NEDSe2n5n2jCGPTOsZzTAMVNNPREOKAeAawh/MzY5JpZ82P1iWQGLojoziAOC3/ht6z6gy4XkpGzkfgGr/oc/fBHNt/KLFGTC92bYM5LZf7s3Zpm3/J8ArjuHe8v2Sra2pBTPuePXo9l/vCOq3hZOXk2GNHc1U+VvgEUNsxQ+cOY12+5Du/q9miVoKKQtKnhI5wwJpozJypvjUOk9sSD2IqNZBNHz7BbHvpf5r7GjuS9dvNTX1Qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSo990eDyt5OwAUMNw4tTVctD1lo/+T01N3BrErT3Z8=;
 b=G6nqHW1syKgiRkh3qmIvn3wqWZ9dCHtVQVA2CM3T+soxV1sQTtb2DP/OZwVVg5Ph203tdflpLBctsaaJs9XY1tHC16jRqL1xeaBmO41S0/bbd3L4jQxToZPWDl4Bvd1zsM3uKqMSFAP+yaM5tQpkAvSTawkid8iaECAHAzZmsOmtzLdn53v4EEmCGFCWyX+EirGXA7B1vqomTgzhNAjp4WAONAjzNkPrUWrMPD7lstOe+KvJV8xE4y8zaBUJYz1/r48d5Wm9eVpXYsoPNSGcyAwW8oZc+PjFdreAkvX/hflQHEW67qHlUVB1CBuG8kYez5byyEhnNewSZj0FUf2+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSo990eDyt5OwAUMNw4tTVctD1lo/+T01N3BrErT3Z8=;
 b=0Gk6ciCrRLDK4FbqzYrNNgo5046pgt6DBmlVuE9XHm9DGnDixfho9LvcGckWajASw0dhKe1Jn1tYVL7OtZuPOhXlLqnliu1nvgysq7v0t8FXhzrfONgSof1TR3n0ESVYTXWBKlEczo857sCoYU2QVz15Bf7bN9Mhzew8fHz3Amc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 9 Jan
 2025 16:45:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:45:53 +0000
Message-ID: <ed79eae8-41a8-4728-b2ea-dcda59badd64@amd.com>
Date: Thu, 9 Jan 2025 10:45:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] platform/x86: thinkpad_acpi: Use
 devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-14-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-14-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:806:120::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: d40dfc7d-0f4a-48e9-d74c-08dd30cd14a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHN4UkcwbnUvS3RIaFVJdXV3ZUhQV3RyZk0vMC8zaFozbWdxVGhLUHlxa1RO?=
 =?utf-8?B?Z1gzSFNrV3YxK21UeHZudlA2NDRIMzdoT1FRWnUzOTJsSGxCaXdMaE5QcUxL?=
 =?utf-8?B?dmdvejdYN1RxdUV4UXp1T1BJdW5nQmYvWm9WcXFvNDlscVp4dy9rMXdTUEdK?=
 =?utf-8?B?Mk5hMVhoNGhRUGFtNDJKeHFkVjNrZVp3NDBaVXArWmtIRjVRL1FYQnJrcWI2?=
 =?utf-8?B?cjdad1IrUVB0SWtCVTlEekN3VGpmbEp3VWZTYXJjNmR0OUxDRVNKaFhUME5m?=
 =?utf-8?B?MW9heElHdFowSmY1aHFDQVFSRVFhTkV5QXR4UkFYdkExZWZCb1JtREtTQWVH?=
 =?utf-8?B?VDZ0Nng5YWFlSU9KbTJkZFlCUDdxWjdxaGFPRUN3blplakNpMG54ZFduRzkv?=
 =?utf-8?B?eEExcnFMcHF5bEpUMVpmTmllZXhzUlQ2RHBYeTVJTk4vaEM0SXRsWFRVV3ND?=
 =?utf-8?B?VXZuRGhsODFHUjlodU1wWXZQWW5Ib2ZEbTJaTW55Q2xiNzBWSDFjcWsyQjNC?=
 =?utf-8?B?TkVHM2VzYmJ4MmJoZkc1KzBkTEw3UUpxdjN4NUVheTFvaXBVcHovNFU0MC85?=
 =?utf-8?B?Qmp4bXJqcDBZZDI3eUlpNXpJWlFoclh0RDQwTnM0K3ZOKzlaYjFjT08wbysz?=
 =?utf-8?B?dTdkeFh2b21vZEExQU9xUDVXYTd6ek9OMlByUmhOdjVwOUNLYmg0MGVKeU5M?=
 =?utf-8?B?QWtlWW8xYzBEL09WNTFiMTEvcCtldE5GaHlvdnNLSkJVTXdLSlVRUlhLd3Bp?=
 =?utf-8?B?c0pzcnlHWDZjUlFPV09WMFZWT21xdS9WdU9Qa0RQLy9PYkxsZmNueGhFenkw?=
 =?utf-8?B?WHdNSFo3QzNwck13Z0RGQitBb241c0p1VkkxcGJEczV6RmNuYVVTSFJaaU5l?=
 =?utf-8?B?bHBJWnh1S0RwanBaSHFhTWJVd1E1YjcwQjRrdkM3VmNoMUNVTkVuNFU2ajN5?=
 =?utf-8?B?KzhESVAzYlB4TE15UzJaTVZURjNocDNPZ09IRXlMYlBHWTJIYXM5Tnp2dHg3?=
 =?utf-8?B?ZUZmRm1mbkc2WFdsM3dxWklodkwxMWhJdXY5MkYrMVJrdTVSOU90REtQaFdR?=
 =?utf-8?B?M2tweXdTaUZwR2NjYTN1YlI1cktRK2JlMy9GVHVXTnNQQ0tMcUp3SG9pRE15?=
 =?utf-8?B?OTg2bHZsNHppR0ZUejhpOG4xb21uY0NQdVFRNFVjS3pwaWNRdmMrNFZRb0ZG?=
 =?utf-8?B?MjZINEVHVDlZQ3FWSXVnRHM3QlBRM0VxS3R2QWJBRUx3NE5VenZhUEVQMHFq?=
 =?utf-8?B?Z3pJTy9LOGN5LzhITEF1bnZSblFzb1F3bGJEUEdKV2FHNFdFaG5WUEM0QzhK?=
 =?utf-8?B?dmViaTc0WTJiSi9VZi9tU2M3VWtZZXpCRkVEN1drRXZ0UG1zREhPTTBNVkxS?=
 =?utf-8?B?Y3graTNKUTM2L1lJS3RSTndJMzluT1pwUnRxdDdmMXA5V0ZVZm5BOW14alhW?=
 =?utf-8?B?NXE3R2JCZFVocTUrYjYrRDlQWFEvZ2xBTzQ4by8rRUxxa3oxNDdyNWJpOXdU?=
 =?utf-8?B?YkxmSVZXRS81WWFVTTlIY2NrMWFUNTVLNFRQV3Q5eDM2SStRQzF2Q2M2cjdz?=
 =?utf-8?B?b0UwUEtIdDNIbmhlQ1piQ09Qc3Y0Z0x5dk5wTkV5Vk41cHMwVSt5cXNoS21n?=
 =?utf-8?B?dkRpR0tURk1DY0hwZ3lsVVlQV3AvWWJnODBoVlQ1ZUJUaFFVYXVrb0Y5c3VM?=
 =?utf-8?B?OTFMdjVNcHNrazVocitmd2Y1MWNlazdyY2E3VWU1ajBvNkE5S2g2UkdtSmhn?=
 =?utf-8?B?b1lZb1Z0VUQzR2NtMlNvMTY0cjR2Yko2Y3RrQ3RxVktqSGQ1RHhiUVVxcE9S?=
 =?utf-8?B?UlI4dGxRbXBVS3d2ejhKMnlMQURrajdmTFFaZVBmVGNhRk9sMjFScWNIeVRU?=
 =?utf-8?Q?kyCHJE1uTyLrj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEwwSUxWWmFBV0JzZEdNVG5leHJLUlpFZ1JSNEgySFp1ekVEanduVDVxQTNK?=
 =?utf-8?B?cFZDRGMwei9memdqTzhGQk00bWNEazFUbnFCK1liWnRYc3k2VjJjZGowbEpB?=
 =?utf-8?B?S0pvMUpZUWUvUng2MnBLa05pWVFLdXVsQWVRNktKZHhLZU55UVN3ODJiQmJy?=
 =?utf-8?B?cmpUUnZ5a3h4cEphTGlMekNEVHBJWEczQXhBeWhKc05xcmtHZmpkMHhDTUxD?=
 =?utf-8?B?VVRXbVIxK3R0YXRmQnJiRXB0SnBVZDBFdkQwYzVMQlJVb2thQjBIRHRqdERr?=
 =?utf-8?B?OG5FM3EwQlM4eCtBSENrMnJ1ZkNyYlY0Qk1EY25mNi9YQ3FHM29SbmRZTW1a?=
 =?utf-8?B?QU5IM1ZWWkMwVllQK1BJcEh5YWxCakk3cVYydW5RMmtGZmg5WHNYT2RtU1JE?=
 =?utf-8?B?bFlHMjM1aE4vZHZwcTdKLzVJQlo0dUlMNzNiRGo4aldjMVBBdVB0M3RtKzZP?=
 =?utf-8?B?dWFiNVdzZThpZVNzNU5YaFN3WmFhNGZxb1R3N3ZjczJLcGd4SWxUVW5HWTF5?=
 =?utf-8?B?dzN1dVFTeVg5SlNWZzdQUWVXTjUvalZoaTR5dmg0N1lqMGxqdGI5UWpmK3pH?=
 =?utf-8?B?QlZiNjdPbUphUlFVbmR2azZkTkFnZEVpOFFJR0NFWkcrRUZWK1JZRFRkMk44?=
 =?utf-8?B?ZkNLUWh6YkkyTDJpdUpVOVhmbDIzNW9vRlFjZzNacVpRazE2KzVRVUV1cmM4?=
 =?utf-8?B?MjVUakxTQ3BIR1J4Z01Yc1RsNXEzRmF4TFFHcVRjYzRJUHdIVWtvNm96R0dp?=
 =?utf-8?B?Z2xQRDRhblo3Q0V2d0RQTWZRUXJ4NDVyamd3d2VrbnErMkxyU3hIazZsbE5W?=
 =?utf-8?B?ZEtzbFhsc2dnQ3lzcTFhR3Btd0kzR1I2U2ZCOFY3ZFFON0Y1aC9ZOE5ET1lU?=
 =?utf-8?B?UFZLbEwxc0d6VzdDdnNqUWRaQnlrZDdRSmVIcUtsTVkzd3piT1lPOUVoMk5o?=
 =?utf-8?B?VlBEWFJNaG83M01sMUR1Y1I1blhpQTlxdDhtRUtlK3dXVExzRFN2NWtiOVZh?=
 =?utf-8?B?NDBRekdURWU3TmhGODFIeFN1eUdDTHExL2VTY3pRMUFsRzQ0akRLUVdNY1I0?=
 =?utf-8?B?bXhJK3F2TGFzQzQzU1lJbnRjYjFtbVBldXhHbG55V2NwY1IzRndBQmx4TXpR?=
 =?utf-8?B?dzVkb1gxSStYL0VuL0xPZUlldVNjL2pKd3hQdEJiOGdyTVlYRFZnTmtQMmxT?=
 =?utf-8?B?VGtwY2ZMa2JYbGc4L1pld2YxRTNFSWZPYjYvb1ZUMmxGWEdyVHl5T2pUcXhl?=
 =?utf-8?B?QVBpTWRTZ2Z2d3JHNG1vZnAzMzBsWlJxVjd4ZU14bkRReHlYRFFBNWFQTy9R?=
 =?utf-8?B?UExTSktORlVqS2dJK0lsWk9BZmZreVQyZDM0ME9adm9xWHprbkZtbWErQzR4?=
 =?utf-8?B?cDlha25xeS9TMFc4Y0Y5ekZ6RVhmQlUyVkhOMzFNK1ZGVGU5TXBnOXlJL3R5?=
 =?utf-8?B?TXFRZEFBMTRlV24wZHh4S3hxZy9RMkVITFFLTjR5eE5aaVFkT0N4VVk2cXdV?=
 =?utf-8?B?emlaaWRYcllWK2pxeTM1MU8ydkVOV01FN2pmb2JMZktLRFU3MS9hTTBRR1cz?=
 =?utf-8?B?WTVQYXBjZjlUSGZVbElrM0kwL1dhbWVOaGs2eC96VG8vMUhSRUJqWTRzTFYr?=
 =?utf-8?B?NlFYQ2FOK0V4RC9lYkEvUzdSRS9LU1lNclYzT3BSWVdKK3paQzFoa24xMDB1?=
 =?utf-8?B?Nk8rZnBNRUx0VWpwNVJSMEdaWTVwZnlFbG1KUDNsZnUyWWJSQjdqbXFqZTE0?=
 =?utf-8?B?Q09jY2hBSFMzSGVNdGdPVHNJaU1pZnJZM0RJQWt6NmpUME45YjlLMGVtdkgx?=
 =?utf-8?B?aFNkRjVuNmkzWW5lSGcrdGNmZi82WE5VTUZKbFZQalM0bzJpbjNvMCs1TlBi?=
 =?utf-8?B?TXI4ZCtXb09LSlI4Y09ZM0s0dFM2TzdPN05xK2tvckg3TzVWdzI3NXhZMGU3?=
 =?utf-8?B?Q1Y2R0cxM2U4V3cvMzF0cENGSFVGQW1mWGJ6Vy93bjVLWmcza0s4YmFXTjMx?=
 =?utf-8?B?U0g2OVNlNGszME9wRXFDN0lNc211NW8rTXkvbm83c0VuM01aQkhhN0dKWTVj?=
 =?utf-8?B?dnV0V2RmWnl3VVBHZUJmTjBwVkxjbU13cDR1d3FYTWVPWjZNeGpNcXlrdXBC?=
 =?utf-8?Q?9MLoxztvqwdnvUUl10b03UcQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40dfc7d-0f4a-48e9-d74c-08dd30cd14a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:45:53.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pspi4rMyzqJiN9MThUZsoWNwKhQfuND6sx7hq1cedfj74+4O/t3i+nBPeDpELMSPRkhVFg8nffUMmBfyXs/hbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/thinkpad_acpi.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index a72790cc5e0e..a0b8987bc328 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   
>   	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dytc_profile, NULL);
> +	err = devm_platform_profile_register(&dytc_profile, NULL);
>   	/*
>   	 * If for some reason platform_profiles aren't enabled
>   	 * don't quit terminally.
> @@ -10667,14 +10667,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   	return 0;
>   }
>   
> -static void dytc_profile_exit(void)
> -{
> -	platform_profile_remove(&dytc_profile);
> -}
> -
>   static struct ibm_struct  dytc_profile_driver_data = {
>   	.name = "dytc-profile",
> -	.exit = dytc_profile_exit,
>   };
>   
>   /*************************************************************************


