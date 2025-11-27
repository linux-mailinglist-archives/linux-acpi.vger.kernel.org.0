Return-Path: <linux-acpi+bounces-19322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24094C8F02B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0133B71AC
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9C335087;
	Thu, 27 Nov 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IgAgdKgo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IgAgdKgo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD4334C19;
	Thu, 27 Nov 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255296; cv=fail; b=SIYHLqIB05Rv2uT3KuVNgyVD2u2cMZH7Mvr2rCn8cf7f4OK4EtyPHXpHsQhBhFPlOkyeoxykgdsBzFwGFcoqrfaFQK+FVXODNke+o6qN9I1QlirG53l+Nxt8PF8eU0s3kHycDyQV324dSFyk4/gPwDvls/iUGFrjwPgQdQaO0Tg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255296; c=relaxed/simple;
	bh=xtM6+wsWUEZimjNIELZJT2G5e+g82xFpx54FLphSlVE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ga1Uyb6CfQdOYSKTNScAMxVQfAL9vg/sTc2SVHcbrBjEpi1KibnGS/bu2TwCz+h+AlIJkHnJwgPCmoeMCkj3mWDjzoWFXe4N6tQbl7tzVlSckVT7IzfiY5umH7DMTx6VGDPeEDut2qPHHh0WkKTXGjzg+vt+SMeqVnLzjcdQWIA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IgAgdKgo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IgAgdKgo; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QEVYACmCEctiUT8ipU6eJDwZgBCWGFEct2e7e2xuvzBhwYOuEnhQwvMAS/y+/KBvknDbilb3k1yu7F/LOl100Jagt0fJHtvRCp2uEPSENAUQ+jAlNnjK1DHag3DWLsWHBw86jOWYFDf8s6JGqFm8gcuF/YOiHxSgkXhqSYRfyTDDid2/2qj1AGuAjE/HaR+uQbiDlyW/YtI3XtuLRBfPsNmLRYEYzL88CHueNlkNFX48qdX2F32Qedq0fqyOVHX+EvTlwpbOur+qkB9Sw2ZxWIBhxvjIYM1j9BHRIDXeUTFnYzSTe28luuMAFR0KRuNjrLHXG8db989YkDNIGw1w8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwxxnCSupYXy93VAAKsncS7R/ZTlq7HRxrIa0gIObZk=;
 b=ehfPXNPlBpijHBjfxzUeBGvWXZZZ6wgbRSznW67ebV8IJ6nKvke5mXssNPwFnwhOfTQfQhKINzJYp6Eei6S5hppm9dWZHF6JB3Uq9+Tm6LLpXBGoEIUloZIlB0jesW0ZaRkzSR7B0UymHBuMP6Ms2Y7C65dIhuMtamyYgGHydjPusSvPen9oGrRhDKOUHW0S5JlH63ge/aArb80Ay8IMnAxfeSvz7CQa71+YVRjbGnIyh1oRYSKiTVWo6UOP/Z7F2IKJYFG4Dj/RSH3fEOsJt7TXleiwheirVa010CUhIrY+YXx433jHvdXXI+H51Um2seRVPW05KlfHKf/tJD9oew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwxxnCSupYXy93VAAKsncS7R/ZTlq7HRxrIa0gIObZk=;
 b=IgAgdKgoasWd5pmQbl4C7gPE/Q0I7v5/q0vXyxDapa88w6QFMebKjIhTgBCib1yI3/fWpcfFPaJS+uO/yMIFlGd2JwILzyAJ+2U3fajFsQ/1x8T/CbzNwODglAw3L6/NewWiutfB9qhZamCW6GO+ygyf8oUoAmccrIsyOx7fzec=
Received: from AM9P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::22)
 by GV2PR08MB11740.eurprd08.prod.outlook.com (2603:10a6:150:305::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:47 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::78) by AM9P195CA0017.outlook.office365.com
 (2603:10a6:20b:21f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaggXSXoweY/GxFyNZAvN7zYKJKoH3j8QSalJwN4/UFo6SzWwhiOG3a4aYhzBSdglOVqSgCQfVmWsXw4aNhhn0yKc8LuiiqH4LeUtURcRQeCpOQ6w8nLquXuvQIlmJfXVt247l2lDNzxpps8IdbSU7UssQWaedSCFMG3vQ4uZCpVuITA1iqbMBFTql39fXzkdYL+o474mXUHcjtHc4YXXS6lLOiKuxNqpTCq7k1WJwFNR9Keci1Pmpr44RvnBpuuiROSxR7NEV49n7Zilpzn8a/ZsgWCR4xAd2IEmyWs7gzh/K/UlXGMOHC9VLzcTKs6doV9SoHF7wb4siPF0Iz8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwxxnCSupYXy93VAAKsncS7R/ZTlq7HRxrIa0gIObZk=;
 b=mT09sk+k5VwO3959KrfxmA5O5vwRC8E48tDud6/fRdn0cKYtfUGV85j8/w+JjynrtP6nZPwCjSj9KXJnqkFeBowgOJUdPlHof3aObcANc8oFXYxP84mk3AeeWWYbH34j8E8DPq8BFsco6B/Fqatm5u8SmbBbiMbSqgXn5k1IIqNDRHEOXiHQKyyT2ovrVVDoz3UYzbncZN4oLvh6ub7v5ZaJ/RGo9DRYHBlJZoElp+CrBMmsh5p/RXKjm3Su4cO6OsWRLtp3/B+AZHgMLmAts2crk08pSFE99vo0RFl+lrrxLkonWzVisqb65iKGPkbAy8NdqT0sgbiOyqP9ysLHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwxxnCSupYXy93VAAKsncS7R/ZTlq7HRxrIa0gIObZk=;
 b=IgAgdKgoasWd5pmQbl4C7gPE/Q0I7v5/q0vXyxDapa88w6QFMebKjIhTgBCib1yI3/fWpcfFPaJS+uO/yMIFlGd2JwILzyAJ+2U3fajFsQ/1x8T/CbzNwODglAw3L6/NewWiutfB9qhZamCW6GO+ygyf8oUoAmccrIsyOx7fzec=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:13 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:54:13 +0000
Message-ID: <23baedfe-176a-42fd-9e5c-c8ad78107708@arm.com>
Date: Thu, 27 Nov 2025 15:54:07 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, mario.limonciello@amd.com, gautham.shenoy@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, corbet@lwn.net,
 robert.moore@intel.com, lenb@kernel.org, viresh.kumar@linaro.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rafael@kernel.org, ray.huang@amd.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-5-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|AM3PEPF00009B9D:EE_|GV2PR08MB11740:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0c55ab-aa5b-4482-06d3-08de2dc4e85a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S3d2YTgxNzFoV2dNSFAxZjYwSGZsd2NmMVg2QWFVZ3lOWTk2QmRRdnhWR0tI?=
 =?utf-8?B?UDFOcWZKSHY1UTdFbEVObk95Z0ZHaWpRTjBnTHlXV05jSXljZEFHcUhyUjhh?=
 =?utf-8?B?ZzJwSHpZeUJBZHNlcHppR3Z5TnBMdkJ1Qm1DMHhleW5XUTUzeFE1Q2x5Q0Zu?=
 =?utf-8?B?emZWSHkraFBQQ0w4K1FhczBHZkIvTHFQdS9LaXZ6d0lXa0Z2STVHMktqeXdV?=
 =?utf-8?B?YUFRYzJXRzZQVVFQb3AwU1ZzNHBGVEM5L0ZXWTFRSXM3SzVIY0RrOTEzS1BV?=
 =?utf-8?B?SElSTkN2OHhHdStMZDZwR01nZi9KTit2QytsOFBGN2MzSnpjbUpRNWdkU3py?=
 =?utf-8?B?MHh2a2VEZ0Vuc0JmbW1mR3QwdkJOeGlxUW1lMEtvazNoYU9tK2lQV0RmVnJT?=
 =?utf-8?B?eFRlVDZMM0xpSHpldEIzeTFlRnZ6UHdrRUxCWk5ON3p5NDE5SXF5cTZKU1Br?=
 =?utf-8?B?UkkyQ0tuL3dMbUNvc1p0RnBVMFQxRC9VVkQyYzRybmM4NmhBL211NHNTNm01?=
 =?utf-8?B?ZXhZdThWZHZuaENzbVdreDRRdlgvVlFTV3kwaFlJVnE4Q3pTRC9tNlh5UHhh?=
 =?utf-8?B?cUNEb0FtckpTY0JadVg4RFNyNFVFT3JQeTBiSW5INVZKbXltYm5GK0lkZ21r?=
 =?utf-8?B?WFlIRnJ1ZHhFWUtvV2lhVDdoMFN6MmtSNnFZTXQrSTlvbm5lTStNSkhsa2Qw?=
 =?utf-8?B?RVhxcGE2YllURC9qMGo1ZVBEOVZOeWErRUx0ai9veXFiTDVHL1JtMHpwNUdP?=
 =?utf-8?B?RlVWWHBLczlEZTZML1JzNmprYWM0SXZ4UWpYWFJlWGdBbGJaeFlObTQvTjY0?=
 =?utf-8?B?Q3NjT1hkRVVibURIRU9hV3pyUWFhM2dma2pLSTFVVEFxajd3OW9sR3JrL3FC?=
 =?utf-8?B?aFMrYWpub3RCZkpSTWI4WmZsRlJ1VkRuWHkxM241UHhSYjJZOFREellLS2E1?=
 =?utf-8?B?MXdVVDdmbWlHbFZoSFF0V2N5UHZsdS9ydlBiY0VNUmFUaFV2VE1JdnVnbkZG?=
 =?utf-8?B?bWdsbU4xdjlsdG91VmpPS1dsVWZ4L0ZTTXlqbkFsSDlMSHRhWEo4enI4MUR1?=
 =?utf-8?B?Rk8rUndTTWFBd1pTK3M1bUUvdGxtek9pQ0JUcnV6TGV0blZkU0c5RVNUMVl1?=
 =?utf-8?B?aXZRaEg5aFJOUVZyVXJBWEZwQmpHS21KZlVxcTV2dmZLMjNaamNXSkZJQlhQ?=
 =?utf-8?B?S0RXa0lsaFR5RVVsNVpmanhZSy9HOGRjMEZWZ0dVYkhOMlBQTnFZREVBZ1RM?=
 =?utf-8?B?ZTFMZ1VZczJlLzY3aWRyY3dMR0tXVVE0dkM2YllIcDV5UVZNdjVtNURQck9p?=
 =?utf-8?B?bjFTMGhqSURBaU9vK2VzTFpHbEJjNVNHcU5rY1VMb2NweFRuKy8rTTlraGdK?=
 =?utf-8?B?Vmd5ZEVBNGV5THlNYWdFQTBlSmg1cVRodXRCUEtCTXNacnU5anhMc3drM1By?=
 =?utf-8?B?VnJTRGZobDVOSFViMG5uZ08rUXlQYXVDLzhiM1QxVVB3QUFZZEU0b2F0QUJR?=
 =?utf-8?B?K1JKRnI1d0FoRkVlSTEwTStYMlhnVkJBTGtGU2NBTlpMNmxmeE9ZN1NQdTRU?=
 =?utf-8?B?ZENNVmIzWG9qQ2EzUjJwRWNoWUVUb29YZWRNWDZuc3BCNGFkSUpIZzdCbVAy?=
 =?utf-8?B?dGVMbDkyZ1p0REJPekg1RlVXaUNvMS9tN2ZnQ2s5Nk1yWWR5L2lZbmVyTStS?=
 =?utf-8?B?THlQTHRvVDFtZjFGZTVHTEJla1Z4MW5vaHFaaEZTN0MvRmwxeUpQOXpPeFpV?=
 =?utf-8?B?MFI4UWhTanluZkJXTHNwcTdBNXZwQlM2WUtRNTBPS0RNUlNvbW9OWTZaUkp5?=
 =?utf-8?B?K280QkNZUitlZDhIYkFWaTFJY20vdHZFbFJUb2JWaWV1ZmhVdml4NW41cWlv?=
 =?utf-8?B?MzJQMVhzbDJuSFZYaTN3RENZaWRtM0xhS3c4VmpMMmdiczZTMGxESWtQNjV5?=
 =?utf-8?B?TTZoS3A2UFh6eGxEZGUrSENUYmkrbXdNWEFsMWl4SS9pcjl5dTFkL0Q5Q01Y?=
 =?utf-8?B?NnViQ1FTbWNBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bd6c0b26-ec9c-4ce7-30cd-08de2dc4d41d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|7416014|376014|14060799003|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlNOR0FybWUva2h0WFhCbFNYM2pXSThXMmVwcWw4NjNqSDI4dFFjMTVDSG5w?=
 =?utf-8?B?b3B6azRjTWtmREtJRUtjKzJzVmVPRUZDVGI4TXhwRmowcW5uMFhKUEFFWGJK?=
 =?utf-8?B?c3B3cys1cG5JMFRKa1EwZHBXVkNlUWlLZGpCQUNCUTJEdlk2VkdVamtUby9Y?=
 =?utf-8?B?OWRleDJBYmJ1YWJwZTBwcFhHcFlKSkFFdzBpRHVVRWs2VjB1K0ZxSVN6NUZV?=
 =?utf-8?B?dE8xQzlHZVFxMThyN1ZkZmp2Nk1MY0l4QUhNYmExQjIrZkdqY0N0NDlHVGxx?=
 =?utf-8?B?V1BDaU5pekxBVk9tZTZ6RW1heGl1VU5ubFZYOTBld3V1WkZLR0gyWE9mK1l4?=
 =?utf-8?B?QUkydkFqWlpnbzBZMys1Sll3bllrSDBBV3VDTTUzSGZKVklsSHlQbmtSTXJC?=
 =?utf-8?B?SGNWb2hGSlhyREhrSkYxa3NZMnowZGdxckdNZkhobjRIVTlZamNtb0VndjBw?=
 =?utf-8?B?ODRoR2s1UkRpR2wybXBKUk1Dd0JJNW5LdkJTNXpveFFFVzljc3hFRS9RZlla?=
 =?utf-8?B?UFlOcGlBTDZObWoxWVg0cDZUV01Vd2FyQlBzZ01OeE5FZCt5b0IxdVRzMlNm?=
 =?utf-8?B?NU1oUGMzeVNoVnZVK3IrYnh4ZjFLM2VSN3NLVzhYQzZsQUYyazRxZllSMGM5?=
 =?utf-8?B?Tlhsays3MkVMZEU5Z3YxcXBod0V2UzFQbWlOS0dnU20vQlFHeFdQTUFsOXV1?=
 =?utf-8?B?bVNRTzRXS2FLbEpyY3UvTURsMkRWOXdnaEtUbWNJVTRTM2JmZllqZ1B0SmdK?=
 =?utf-8?B?dUpBV1VEc29OK0Q3Q1RpWFd3ZnQ2ZDROMEpWcGc4M3NtOElUUUxqNkp5eUJW?=
 =?utf-8?B?akxwcDZZQXR6UkZQSExaWHZqaFFRN3pOUjQrSEtCU2lrSHcrOCt4b2p0NEND?=
 =?utf-8?B?YnhUMEZ1elUxc0grR0MrVFdFc2hUbXhEN3RDTUpWK0RHZkN5enFDcjgrWnRh?=
 =?utf-8?B?eUVRL0hLNXNIVFpRRGc2QmJEcmh2SG1SM2tWdURzdXM4ZFAxT0lCRXFOV0tv?=
 =?utf-8?B?TUFLT0VqMEpPNmJUZGdGczNDTGU4akNwZlpGcnVsZko0OWo0YmYyTjR2MmNP?=
 =?utf-8?B?SXM0cHRyZENiWUdWM3hIWmtWSkNMM1AvYVUzNmZTbGg3ZitWR1dVRDF3Y0hM?=
 =?utf-8?B?VTFCZXBrYlQ5Rkk5NmxreEVqRC9kU0F6K2poK0puWmNybmZZZEM0bXRBQ0xS?=
 =?utf-8?B?R1dhTXRPSUNlODdLV2hlZmFabnhmUDJPVDZJaEVxanNrKzBjTEZhdnZsMVFW?=
 =?utf-8?B?d3NFSnFiekNYc2Eva2dGUDcyL2lFczZjb1QwOGtFcXBSS1BLeEsvczZlQXVq?=
 =?utf-8?B?RVNzVWI0K3Z6c2FMZnAzUjNPTXRIT3VEc01rbFBxdDhCdWVZOHVNYjUrUVd2?=
 =?utf-8?B?QmJVTWNsejZtVWo1SFVjVVZlZ2FlVVVOMjMyRmRFd1pHYk1QVHE3ZFJXYlFS?=
 =?utf-8?B?RGZZaTFyZ2dDOWYzalBPTjBkTUFOSlNub2pSRFE3cHBzSDB6YnFIY0h3eUNW?=
 =?utf-8?B?eUR5Y21qMXdEQXp2UVl4WGMxVWFRUkJScG56U3Q2K0lhcVRQOU1BL0owVGtI?=
 =?utf-8?B?aFc4T1ZRdXFSMlFqa2tJSzRZdGJhT1g0SytncVNHdFI0ZjZ4eWFJNzk4WEd1?=
 =?utf-8?B?N0JXMFg2WVh3ZGRybFJoYXJQd3dObnozS210aDFlZ1hmOFJBdkUyMXFETm9o?=
 =?utf-8?B?WUJERnR2N2wxR3lDODRZNlY0eDIzMHlIWVFaWWhZM3hBMEY5dldhTWtqZmUw?=
 =?utf-8?B?d1dhTDRMQzMyT0hJTW5WU1pKcThJZDFuelNGQzlRZFdrcDFMOVVONTZoTG5H?=
 =?utf-8?B?S2RPdThHYzFqSURadk12TVpIRWoyUXVSRUJFRGxKWEF4aWRCTGY4aTRLTFho?=
 =?utf-8?B?aklFTXBLUkY5Z1VrZXhWODRhQWlGRTBzNlVXTWZheU1tcytwWVdjYzNlRk1x?=
 =?utf-8?B?MEhFYTRicnlEcndBZVcvS2xMejhJWG1iVTVTa3hUZUNCcHMvSXlkUVZkMXRl?=
 =?utf-8?B?QzJFZXF2cmFDODJKRElzR1gya21oSHZZZjNMLzZoMUE4bEs0N3Ftb244Rjgv?=
 =?utf-8?B?YjNzbjB4Y3lLVE1XNXBsNUNBaERnYSsveGlLaFJCOXgvTjNDQnRUZDViQVZp?=
 =?utf-8?Q?lXmc=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(7416014)(376014)(14060799003)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:46.7302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c55ab-aa5b-4482-06d3-08de2dc4e85a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11740


On 11/5/25 12:38, Sumit Gupta wrote:
> CPPC allows platforms to specify minimum and maximum performance
> limits that constrain the operating range for CPU performance scaling
> when Autonomous Selection is enabled. These limits can be dynamically
> adjusted to implement power management policies or workload-specific
> optimizations.
>
> Add cppc_get_min_perf() and cppc_set_min_perf() functions to read and
> write the MIN_PERF register, allowing dynamic adjustment of the minimum
> performance floor.
>
> Add cppc_get_max_perf() and cppc_set_max_perf() functions to read and
> write the MAX_PERF register, enabling dynamic ceiling control for
> maximum performance.
>
> Expose these capabilities through cpufreq sysfs attributes that accept
> frequency values in kHz (which are converted to/from performance values
> internally):
> - /sys/.../cpufreq/policy*/min_perf: Read/write min perf as freq (kHz)
> - /sys/.../cpufreq/policy*/max_perf: Read/write max perf as freq (kHz)
>
> The frequency-based interface provides a user-friendly abstraction which
> is similar to other cpufreq sysfs interfaces, while the driver handles
> conversion to hardware performance values.
>
> Also update EPP constants for better clarity:
> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF
> - Add CPPC_EPP_PERFORMANCE_PREF for the performance-oriented setting
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c       |  55 ++++++++++-
>   drivers/cpufreq/cppc_cpufreq.c | 166 +++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h       |  23 ++++-
>   3 files changed, 242 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 757e8ce87e9b..ef53eb8a1feb 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1634,7 +1634,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>    */
>   int cppc_set_epp(int cpu, u64 epp_val)
>   {
> -	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>   		return -EINVAL;
>   
>   	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> @@ -1757,6 +1757,59 @@ int cppc_set_enable(int cpu, bool enable)
>   	return cppc_set_reg_val(cpu, ENABLE, enable);
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
> +/**
> + * cppc_get_min_perf - Get the min performance register value.
> + * @cpu: CPU from which to get min performance.
> + * @min_perf: Return address.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
> +
> +/**
> + * cppc_set_min_perf() - Write the min performance register.
> + * @cpu: CPU on which to write register.
> + * @min_perf: Value to write to the MIN_PERF register.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_set_min_perf(int cpu, u64 min_perf)
> +{
> +	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
> +
> +/**
> + * cppc_get_max_perf - Get the max performance register value.
> + * @cpu: CPU from which to get max performance.
> + * @max_perf: Return address.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
> +
> +/**
> + * cppc_set_max_perf() - Write the max performance register.
> + * @cpu: CPU on which to write register.
> + * @max_perf: Value to write to the MAX_PERF register.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_set_max_perf(int cpu, u64 max_perf)
> +{
> +	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
> +
>   /**
>    * cppc_get_perf - Get a CPU's performance controls.
>    * @cpu: CPU for which to get performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index cf3ed6489a4f..cde6202e9c51 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -23,10 +23,12 @@
>   #include <uapi/linux/sched/types.h>
>   
>   #include <linux/unaligned.h>
> +#include <linux/cleanup.h>
>   
>   #include <acpi/cppc_acpi.h>
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
> +static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>   
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
> @@ -582,6 +584,68 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>   	policy->driver_data = NULL;
>   }
>   
> +/**
> + * cppc_cpufreq_set_mperf_limit - Generic function to set min/max performance limit
> + * @policy: cpufreq policy
> + * @val: performance value to set
> + * @update_reg: whether to update hardware register

I m not sure I see in which case we might not want to update the 
hardware register.
Isn't the min/max_perf values relevant even when autonomous selection is
disabled/absent ?


> + * @update_policy: whether to update policy constraints
> + * @is_min: true for min_perf, false for max_perf
> + */
> +static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
> +					bool update_reg, bool update_policy, bool is_min)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	unsigned int cpu = policy->cpu;
> +	struct freq_qos_request *req;
> +	unsigned int freq;
> +	u32 perf;
> +	int ret;
> +
> +	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
> +	freq = cppc_perf_to_khz(caps, perf);
> +
> +	pr_debug("cpu%d, %s_perf:%llu, update_reg:%d, update_policy:%d\n", cpu,
> +		 is_min ? "min" : "max", (u64)perf, update_reg, update_policy);
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +
> +	if (update_reg) {
> +		ret = is_min ? cppc_set_min_perf(cpu, perf) : cppc_set_max_perf(cpu, perf);
> +		if (ret) {
> +			if (ret != -EOPNOTSUPP)
> +				pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
> +					is_min ? "min" : "max", (u64)perf, cpu, ret);
> +			return ret;
> +		}
> +
> +		if (is_min)
> +			cpu_data->perf_ctrls.min_perf = perf;
> +		else
> +			cpu_data->perf_ctrls.max_perf = perf;
> +	}
> +
> +	if (update_policy) {
> +		req = is_min ? policy->min_freq_req : policy->max_freq_req;
> +
> +		ret = freq_qos_update_request(req, freq);

IIUC, we are adding a qos constraint to the min_freq_req or 
max_freq_req. However these constraints should match the 
scaling_min/max_freq sysfs interface. So doesn't it mean that if we set 
the 'max_perf', we are overwriting the the max_freq_req constraint ?

If you have frequencies between 600000:1200000 # Init state: 
max_perf:1200000 scaling_max_freq:1200000 # echo 10000000 > max_perf 
max_perf:1000000 scaling_max_freq:1000000 # echo 900000 > 
scaling_max_freq max_perf:1000000 scaling_max_freq:900000 # echo 1200000 
 > scaling_max_freq max_perf:1000000 scaling_max_freq:1200000

The 2 values are not in sync. Is it the desired behaviour ?


> +		if (ret < 0) {
> +			pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
> +				is_min ? "min" : "max", cpu, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, true)
> +
> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
> +
>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int cpu = policy->cpu;
> @@ -881,16 +945,118 @@ static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *po
>   	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp, buf, count);
>   }
>   
> +/**
> + * show_min_perf - Show minimum performance as frequency (kHz)
> + *
> + * Reads the MIN_PERF register and converts the performance value to
> + * frequency (kHz) for user-space consumption.
> + */
> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_min_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_min_perf - Set minimum performance from frequency (kHz)
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MIN_PERF register.
> + */
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	ret = cppc_cpufreq_set_min_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * show_max_perf - Show maximum performance as frequency (kHz)
> + *
> + * Reads the MAX_PERF register and converts the performance value to
> + * frequency (kHz) for user-space consumption.
> + */
> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)

I think it might collide with the scaling_min/max_freq.
I saw that you answered this point at:
https://lore.kernel.org/lkml/b2bd3258-51bd-462a-ae29-71f1d6f823f3@nvidia.com/

But I m not sure I understood why it is needed to have 2 interfaces.
Would it be possible to explain it again ?

I don't see any case where we would like to make a distinction between:
- scaling_max_freq, i.e. the maximal freq. the cpufreq driver is allowed 
to set
- max_perf, i.e. the maximal perf. level the firmware will set

------------

Another point is that the min/max_perf interface actually uses freq. values.

> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_max_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +/**
> + * store_max_perf - Set maximum performance from frequency (kHz)
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MAX_PERF register.
> + */
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, perf, true, cpu_data->perf_caps.auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
> +cpufreq_freq_attr_rw(min_perf);
> +cpufreq_freq_attr_rw(max_perf);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
>   	&auto_select,
>   	&auto_act_window,
>   	&energy_performance_preference_val,
> +	&min_perf,
> +	&max_perf,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 42e37a84cac9..be7de1222eee 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -39,7 +39,8 @@
>   /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>   #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>   
> -#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +#define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>   
>   /* Each register has the folowing format. */
>   struct cpc_reg {
> @@ -172,6 +173,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>   extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
> +extern int cppc_set_min_perf(int cpu, u64 min_perf);
> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
> +extern int cppc_set_max_perf(int cpu, u64 max_perf);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>   extern int amd_detect_prefcore(bool *detected);
> @@ -264,6 +269,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_min_perf(int cpu, u64 min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_max_perf(int cpu, u64 max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>   {
>   	return -ENODEV;

