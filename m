Return-Path: <linux-acpi+bounces-20071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C5D04102
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C6936064DF
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F564FF858;
	Thu,  8 Jan 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmvzU0Ne"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714D5011B8;
	Thu,  8 Jan 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882082; cv=fail; b=OASyfeGiLQdTD83roYLkC/dTLkywx85MlpRo64kzGxO+mL1jN/z1DIr4jVj9rskKmeZ9kxl+VQTYRc4fsBeOL5GJRH5zP0BxY1ScaWmAAmywtR7FxSMKsB+GnjwHQrcL2w3rf0pKjQW3NFJWkmZOKpjyLVKa6UlHOf9o0/9JyvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882082; c=relaxed/simple;
	bh=ZaWMgY8lbhkLPgsTs+sOUOk0Xr2gk1UyKH28aHdBbK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toqT/57/tuOX2GW5efT+Zr8zxW3Uss1XsJF7vik/Gjk4GLfvxgAsCKrtZRJbm2PviHYWqbDyqc7aJrx7CL2jmdqUZ6d83sU/2rOKmuP/i9IG8W3BBwYJWdyqlqvOlMXm+BibGSHtyetfZ5HthbCRrCICmfywlZmxakjYJFmmp4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmvzU0Ne; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7Q/UcHBOIPixi9ukYCAyLIe1NxXiTNgrf2YH0dhSCvbUv8aN9L1eIva/m2KzWrySuanqJEQIkqmmSI5EZXoJvgAJmiQLR+z60dhea8JElrME9d+JBls58rBhk1TUfRR1Euic/90BchoE8CeJCRJ07NmI7oNbMQr1yCzY9bxNQW/5CDcIbVom+0j36XpY8m//k5PnMBqe0gX3cPbkGSELi1rO2SH955h3s4iJmstuYvd+mK3u/See3NQmDVkpJSlxQ2TYRjseKhh5QFd/W9pAhZKQOnJWRPNZ+dIfSrT+D7e+bKpMBn5iJI16JoJAuZC0Ghn6jxnR0zsJWXR0Whq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxOCvbudOELPhQIql3zvn6TSnL7YqKJMrqhsvKi0FTw=;
 b=A1Y9ps9QCFtKPLJOLaM8kvQqmULMEKeFX9KrJCiEjHcCrrZQnVRtWsdu3JRDmdJR3RYDV+8meo8VE1vbgzgAE8sKG8AOnFeTRrYCSX/MPzHABE/cw2G2jsUyYX6mCa5Yu3hKxEpVYMbdsTLyqnhkmJ1BD4vBCm/TP7IXdoUcILbWdmWRKiUbMXgTwBvXsWEC1S3jMMeeYnMM3ra97m/TO8JcAWmgrMWdC3S+Qau6eRUxJu0ZTH2o61HrL/hk8Iv2CQi3F+gh1pR2ZjCaqVLcsmtXj3TY71ijYZodAoOSmu0gq2vQnzw6YsWr6sr3jqMO7Cd8hAceSwXeJMrgRI08tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxOCvbudOELPhQIql3zvn6TSnL7YqKJMrqhsvKi0FTw=;
 b=pmvzU0Ne4KIXl50E0YwgnAkJhz28knHalYInhTI0lfv7MaQEi7DJkZoeKcawApk1oIdprRXfdfGw4OXX1tF/8/CnL5VOng9Y5RfIlxFv6dqdeUMcmyt/10VbULJ4DH1ztUVOHWGDSU5Hyh1TDEcrXxyCLbt2hw9j/22fZO377EoQd2g2x0UG3J0VUDzyHxGPYq1CNQAY/JFewtFz1DwOveGF9M+6MZ5JlNHkKQbjfUQE8tcPOcMAtwfRbalBP1GKjSQu3pz1slHlZgPQLILwyhZ2M1FlTfZpTaFLpJZB/Ek2bj8dn+ogo2OpMk0XaQrrNwqjrK+cXls5E06HNwUy1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:21:14 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:21:14 +0000
Message-ID: <fb876f94-f92e-4c8a-9b64-fe9118a15595@nvidia.com>
Date: Thu, 8 Jan 2026 19:51:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] cpufreq: CPPC: sync policy limits when toggling
 auto_select
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-10-sumitg@nvidia.com>
 <ae4ff90a-d2c4-4c13-9d65-a0f266bb4b4b@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ae4ff90a-d2c4-4c13-9d65-a0f266bb4b4b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 28099d4f-375e-4ced-c41c-08de4ec12db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RYRkJkZStwK2k2a2lqRzdMaE1aM2lGcHRkYnFOLzNsWm9FTEcvM09TMDk4?=
 =?utf-8?B?SjFMZUlqZ2VJOTNTSVpNUlptMnZOWGc2YkNrR1RWOXRzem4wVFQvV05ud1pC?=
 =?utf-8?B?OWxORGZCMFI1UE1GUGQ3dGVacjdUWVJDa2tjZ253Q3JJRUJxT25GQzBKRnBj?=
 =?utf-8?B?UHRRc0daYlJLK0tVWGM3R09qVVRXTmJtMlE4TS8wdnhZbWhrZnFyQTRiNmdU?=
 =?utf-8?B?ZWtSWnFwcGJlTlhLMXBzbjhVb3NwWmZRaE9CRlJ3amRHVE4zVlNmN0lPc3Ri?=
 =?utf-8?B?SmQ0aUVEOW5Ra3JCczZBVFdSM2ZLUG4vK2J6ekVCTUxUNUdUUUhtSGFnc0U0?=
 =?utf-8?B?aFNVRllIVERiZVdKdEZMOXEzaUpxWWN4cFE1NWhZVGhVRGFheFUxRTlobmhP?=
 =?utf-8?B?WUQ0ZkE2eVArTWx6a1hpSktnaEd4ekNqYXozYXo2b0VNMVlyU1YzKzhPZ01E?=
 =?utf-8?B?REJrZ3Y0UzZiRjdQK3FUZzZpcjQ3Z1Q3d1ZvTVJnZUxoOHJ3WFd2WjJQS0hD?=
 =?utf-8?B?aTF0RmI2b29nNzliVnBWWUVSNFh4c3pZMWROZVBMMDl0ZXEzUm9WZHRyRmxs?=
 =?utf-8?B?Q1Awd0N4OVY3STFCUktReVloYWtVazZibzZ0N2E4M3JTMmI5N2tTcEhWTERy?=
 =?utf-8?B?c0pxb0h5WmhYSTV2ekM0VnFCWE4zUjNiVStUcldZb1l0dEZtTG5DK0xlL0Nm?=
 =?utf-8?B?dysyR2JVWFJKa3Nmbk5RR3pzS0ozVTkxS2RVUWdqQTkvckNLNkpCaURoWk5I?=
 =?utf-8?B?czV6blhyNmk2SDkzSjZkbFg3WlUvQlZJK1dPS2pnZ0RGMzljSldYSDU3cFZW?=
 =?utf-8?B?RWxMZXpWaEcybkFiRzZpZXU5U1VtV2dydERJVEI3OVNzTmxDcHJ6N1h2Y2ow?=
 =?utf-8?B?Szh0TFhlZnNLd1pIcUhFTlpCV2VPYkgvSnoycWhDZlhuakJkcjJtaURGTUh6?=
 =?utf-8?B?NHcxTTlFb1FGUCswa2RSS0s3eEttQlpzdFpVOGtPV29nVnEwdWFoVlgxY1NU?=
 =?utf-8?B?ZlhLZmg0M1ZvaUh3bWxsYk03c0xDN2JPV3hIcXp2dC9md3JnMGEzb2xsSWV5?=
 =?utf-8?B?VkV5enRlN3N1cWw4SkNlMGh5OTd6d1R4dUQwWEVvaEYxdGFuekE0WnlHZWFR?=
 =?utf-8?B?YkFKcjFkcExSQ1J2UEdHaERpNnV2VVNJTFlDUm1GcW5mUy80a1pld0VJZHZW?=
 =?utf-8?B?cVptZTZ4Z3ZGSWhmZjlBRzVaaUU4Z1dXMDhLblhubHNDRFJNMTB5OFNIbnQr?=
 =?utf-8?B?a05jSlU4Nkw5MEFrNkEyek40UmdYTlBpbmpRRFV0enpta3MwWHBTQ08yOVNj?=
 =?utf-8?B?eG1MOWRMblJhUEdtUnZsMVlUVTJsM2w4TzFHRzZzR0pwY1YycmwwTTNscFZn?=
 =?utf-8?B?WFVNT3czRFp5QTFNa1dZSW1mZW1EdlBFUzVZWHA5NncrTzBZZGJFcERxV2lE?=
 =?utf-8?B?dnE5NnpvbFNVbnRVTVZEQ0hNTjYvd2ZjVWs0WEMweDBvSG5XejlINGtUNE9E?=
 =?utf-8?B?ZERkNnlSUDI5dnVqNm9laGVaWG9YS0lRYUtueldJMlJkck15K1E2YzZNK2dN?=
 =?utf-8?B?L1N6YUl1WDQ4MFFQYld6YytUb3NKTXFSckcxUmtadjNCR3Yxb2xoTXg5MlR3?=
 =?utf-8?B?bkRrczhvRVBaVFNnTk1MMWxUR2Y3TFBFK0tCY29heGVBNzRnMkl3b3U4UUJh?=
 =?utf-8?B?UGFqTVlRNUdJRGxrYW5RNEZvUjM5Z0cwbUd4YkN2UXE1UzFxUjZxVDZDOURC?=
 =?utf-8?B?TGk4Uys5MmlxcjF4YVJNY00zK29tT1hNc1ZhNnJEcWl5bTVUSkRpMkFIaGM5?=
 =?utf-8?B?akY5N2lVK1lMQllteDRmYzhtV0ZwY2RYU3oxMWFFaUhvd0JJN09HTG5nVjZj?=
 =?utf-8?B?SWZFV1p6RENqS2h4eHVYWEpYY1IzcmFPNURWTjMxaWdEeE55c1pGY0N4cjlH?=
 =?utf-8?B?ODErZzZwdW5jYkZpSFdVR1NkRWpndWJQTjJRc3NCVEZYUVdJcitsNVRPV2g3?=
 =?utf-8?Q?rcRgk8E5tEdiQF75llEzFTX1FZ9Etk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My80UDZhUmdzY0t1KzZ3emluMDlhOUhxdkh4ZzI0TWdSaTU1KzFGMFE5VG11?=
 =?utf-8?B?SGZtWDdudTB5N2hjSWh2WTBtSFA5NDgzVCs2bHJla1BoWnBnSVZVeWtsMGdB?=
 =?utf-8?B?N3Z5MjlOK0pFSXZxeG1neHB4ZVhRN0Zockxva3pLc3J1Qzd0d3RhY3ZYa1ln?=
 =?utf-8?B?RC9IYWtkNWwxRWJGVkpkMmpPS2xTVnNuMzFhZXJtK1B0VW1JTnpwUTdSeC9u?=
 =?utf-8?B?NnN1NDhBZDN2dHlGT2kweEhvSWhYc2lIdWxrb0NEeno1WjhvNWhZVkxrNmRY?=
 =?utf-8?B?dE5Manl6MUpxWmVEZ2JDbnkzdk9sM1ZFMDQvelNHSlA1UTZ1WHZCRThDc1lv?=
 =?utf-8?B?YTduZDlEdWlycFVIczJPYXVEYXFUWWoyR05iTE1RbmIvMDZwV3p3bU9UWTRq?=
 =?utf-8?B?VkxwQmtWeGF6WVQreFA5V0pXNXFXK0NSYWdkNmxKWXMyWGJNU3RtYjBQNW9K?=
 =?utf-8?B?MWgrU0dlL0FoNFRSOEg4ZFpyakx4SVNBV3R3ZW8yckNLR2VaQ2pwTVlXQTlZ?=
 =?utf-8?B?M3hXSUxsNXd5b2sxNEV5YVlUUldXTHBMSXFTQmFNV2hPbW5yUU5tajYwWnJw?=
 =?utf-8?B?Y0szT1RhSE9kOXJyQ2t0WUJCRS9VTTdxbmhVcjdJQ080M2xjOTdpamE1c0w1?=
 =?utf-8?B?L2F4Vks3OXdrZHZURGRWbWFEVkRVZFhwdnEvOHVXcVJqMGhSVXpjd1FjaFFu?=
 =?utf-8?B?bVluaDAwL3ZmZytGaW5HdlAvN1RESFYybDcwaUErTitFWW52NFlJK0ZoNGJQ?=
 =?utf-8?B?NnY4amxZMEpUWlJQS1RHSTR4RkR6Y2pzSm5NbE1MR0w4aHl2aTMvL1U1RFJo?=
 =?utf-8?B?cTFsSi9TUXRNWkQ5cmY1RVVhaGV0WnIwNUZqNGc5TlRhK3JrUVdJQ0FTUENE?=
 =?utf-8?B?THNmY0VqNHZQeXdnNmJuSlVIVDZLNXNjRjl6amg3S0hkaFpjZDlsK05TZFVp?=
 =?utf-8?B?N1hQaEIwL1JZQTFiaGFGVnliMGJQdUJmM2RqMWo1R1dyaVlaSHhrVnRCT1U5?=
 =?utf-8?B?alJocVp0NHJxY0xUd0hUYWxWNjhrNDhkOXlKZm5OM1J4UFIrdXZ1Z2d3QnEw?=
 =?utf-8?B?bmI5MlJRdXFEbUpYMW5xMjBnNU80NVF4eDI4MkkzblVGSld6aGVZRWZBTldy?=
 =?utf-8?B?ZktsT01LVDM4ODJNTVRiWW44eXlWcEhibWh5UzRnazExOEJ2NDJ1Q3FORVNy?=
 =?utf-8?B?cGl2dFlQTTczUmJuOGd1NzQxemIyTnY5R2pnd3czd2NJa1pFOXMxZkppbmo0?=
 =?utf-8?B?R3BVUTJVWUx2WnNpMXdYZWRMUlg2WjZld2pIbHU4S2ZkRVorWitRT0hwRVFo?=
 =?utf-8?B?QkZBTTlyQi9pZ2FEcjlpUitvWS9QSjgvd0J3YTFoTVBXYkJWOGI3VnZneXdw?=
 =?utf-8?B?aHBXS0x6dGFoTFhUMDk0VkRNOTlmL1FJZTdiR2h0ay8xNGVKdDB5N3ZvdE5u?=
 =?utf-8?B?dHcrNkxkS2dxdFA5c3BNRFlwMW5reDdkcGdUNUhod3ozeEZkSzFOQ2hRRkU4?=
 =?utf-8?B?ZGd1Z05CdTdSZVB4dG1aUEM5MEZVd0NUOFl2UTd3ei9HR215cXQ2Y1haWTNt?=
 =?utf-8?B?RUFFWGhBSmV4QlVNQzFZbjhOTS85RU8zRWJENDhIc0VkMW9oaWhKMTJPamov?=
 =?utf-8?B?SWlINFNVUmJUNVI0N29ITCtVMVpoemxPV1B5a0oxRi8vb3ZuNFNSMkppbTBP?=
 =?utf-8?B?STl0RndGZGZsTVRURXcxVUtIcXAzQWI4Q1lvcTlnQU5OQ2NKNG91NU1SeGlo?=
 =?utf-8?B?SG5Wc3NIVVFKM3MxQWl5SUk3TURmeFpxRzNmUXRKRG1YNnBCQTV4ZDErTUxK?=
 =?utf-8?B?K1d0UVN0NVpXRURKYXlWQUFaeU9YSnhoeVlkc0FhLzVRNTJZa0ZFZXlvRkFN?=
 =?utf-8?B?aEFXdEM3Mmkwcjd2VjhUQ2YvbzlGUldvUlUyQ09jbTdWL1dYZ2tuQ1pFbWh6?=
 =?utf-8?B?YjlQV1lrMzJNYm1mK0hNeTVTSmswUStrOW0xSzdGZHZtUlV0UjhsOVBVSU9u?=
 =?utf-8?B?RjRTK3ZQNjFXRUpudm1oWU9VMkRFbEg4Y2FFNktSY1hSMm9qbUovSUtSNW1j?=
 =?utf-8?B?ZXlqVWEyZmsvQ2YwZENlZEtPNTFHVzV5bnZVaDJNL0dlYVAvVkhhU2d5QmVm?=
 =?utf-8?B?Z2NWT0tSSnRFZnRwWGI5MWRWaG56eVFmbFpERWtlOTlnOVlwa1IyWDlCMUVw?=
 =?utf-8?B?S2o0dHZ2d2J6cFVTRGN3UEtxcDcvWjIwaHFMZ0tCWUxEcGs5NUh0b09aN2dk?=
 =?utf-8?B?QjRFRzM4T1VxN2xrYkwwMWl3MUxLaTBncVhXL3JKUCttTDlTM2NPZHMxS3Vu?=
 =?utf-8?B?YlhlUENTSTdUZGZhZUhvU29sT05rZ0RYdEpGdHYrK3lzTHF5ODl6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28099d4f-375e-4ced-c41c-08de4ec12db3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:21:13.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC1N9ot0MyJy/CUXj7bcuwSZU4YYyh1GF1I/TGTKrFcUHfHScTLc+vEmjf1CrIv+PkBlLLnwY12VGWP0K2IqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427


On 26/12/25 08:25, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> When CPPC autonomous selection (auto_select) is enabled or disabled,
>> the policy min/max frequency limits should be updated appropriately to
>> reflect the new operating mode.
>>
>> Currently, toggling auto_select only changes the hardware register but
>> doesn't update the cpufreq policy constraints, which can lead to
>> inconsistent behavior between the hardware state and the policy limits
>> visible to userspace.
>>
>> Add cppc_cpufreq_update_autosel_config() function to handle the
>> auto_select toggle by syncing min/max_perf values with policy
>> constraints. When enabling auto_sel, restore preserved min/max_perf
>> values to policy limits. When disabling, reset policy to defaults
>> while preserving hardware register values for later use.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 112 +++++++++++++++++++++++++++------
>>   1 file changed, 92 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 0202c7b823e6..b1f570d6de34 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
>>    * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
>>    * @policy: cpufreq policy
>>    * @val: performance value to set
>> + * @update_reg: whether to update hardware register
>>    * @update_policy: whether to update policy constraints
>>    * @is_min: true for min_perf, false for max_perf
>>    *
>> + * When @update_reg is true, writes to HW registers and preserves values.
>>    * When @update_policy is true, updates cpufreq policy frequency limits.
>> + *
>> + * @update_reg is false when disabling auto_sel to preserve HW values.
>> + * The preserved value is used on next enabling of the autonomous mode.
>>    * @update_policy is false during cpu_init when policy isn't fully set up.
>>    */
>>   static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>> -                                     bool update_policy, bool is_min)
>> +                                     bool update_reg, bool update_policy,
>> +                                     bool is_min)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> @@ -563,19 +569,22 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>
>>        perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>>
>> -     ret = is_min ? cppc_set_min_perf(cpu, perf) :
>> -                    cppc_set_max_perf(cpu, perf);
>> -     if (ret) {
>> -             if (ret != -EOPNOTSUPP)
>> -                     pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
>> -                             is_min ? "min" : "max", (u64)perf, cpu, ret);
>> -             return ret;
>> -     }
>> +     if (update_reg) {
>> +             ret = is_min ? cppc_set_min_perf(cpu, perf) :
>> +                            cppc_set_max_perf(cpu, perf);
>> +             if (ret) {
>> +                     if (ret != -EOPNOTSUPP)
>> +                             pr_warn("CPU%d: set %s_perf=%llu failed (%d)\n",
>> +                                     cpu, is_min ? "min" : "max",
>> +                                     (u64)perf, ret);
>> +                     return ret;
>> +             }
>>
>> -     if (is_min)
>> -             cpu_data->perf_ctrls.min_perf = perf;
>> -     else
>> -             cpu_data->perf_ctrls.max_perf = perf;
>> +             if (is_min)
>> +                     cpu_data->perf_ctrls.min_perf = perf;
>> +             else
>> +                     cpu_data->perf_ctrls.max_perf = perf;
>> +     }
>>
>>        if (update_policy) {
>>                freq = cppc_perf_to_khz(caps, perf);
>> @@ -592,11 +601,74 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>        return 0;
>>   }
>>
>> -#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
>> -     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
>> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy)     \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
>> +                                  true)
>> +
>> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy)     \
>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
>> +                                  false)
>> +
>> +/**
>> + * cppc_cpufreq_update_autosel_config - Update autonomous selection config
>> + * @policy: cpufreq policy
>> + * @is_auto_sel: enable/disable autonomous selection
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>> +                                           bool is_auto_sel)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 min_perf = caps->lowest_nonlinear_perf;
>> +     u64 max_perf = caps->nominal_perf;
>> +     unsigned int cpu = policy->cpu;
>> +     bool update_reg = is_auto_sel;
>> +     bool update_policy = true;
>> +     int ret;
>> +
>> +     guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> +
>> +     if (is_auto_sel) {
>> +             /* Use preserved values if available, else use defaults */
>> +             if (cpu_data->perf_ctrls.min_perf)
>> +                     min_perf = cpu_data->perf_ctrls.min_perf;
>> +             if (cpu_data->perf_ctrls.max_perf)
>> +                     max_perf = cpu_data->perf_ctrls.max_perf;
>> +     }
> So if !is_auto_sel, min_perf and max_perf reg will be set to
> lowest_nonlinear_perf and nominal_perf, but perf_ctrls.min_perf and
> perf_ctrls.max_perf remain the old value. A little bit strange I think. And
> when this happen, min_freq_req and max_freq_req will retain the value last
> set by the users through min_perf and max_perf. It's that alright?

When disabling: Reset policy to defaults for normal governor control,
but preserve HW min/max_perf values and cached values for when
auto_sel is re-enabled.
When enabling: Restore policy to preserved min/max_perf values.

>> +
>> +     /*
>> +      * Set min/max performance and update policy constraints.
>> +      *   When enabling: update both HW registers and policy.
>> +      *   When disabling: update policy only, preserve HW registers.
>> +      * Continue even if min/max are not supported, as EPP and autosel
>> +      * might still be supported.
>> +      */
>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg,
>> +                                     update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg,
>> +                                     update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     /* Update auto_sel register */
>> +     ret = cppc_set_auto_sel(cpu, is_auto_sel);
>> +     if (ret && ret != -EOPNOTSUPP) {
>> +             pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n",
>> +                     is_auto_sel, cpu, ret);
>> +             return ret;
>> +     }
>> +     if (!ret)
>> +             cpu_data->perf_ctrls.auto_sel = is_auto_sel;
>> +
>> +     return 0;
> Better to return ret.

Here, return 0 is intentional.
If cppc_set_auto_sel() returns -EOPNOTSUPP, we still consider the
function successful since auto_sel is an optional register.

>> +}
>> +
>>
>> -#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
>> -     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>   {
>>        struct cppc_cpudata *cpu_data;
>> @@ -889,7 +961,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>        if (ret)
>>                return ret;
> Since you already store auto_sel value in perf_ctrls, We can compare the
> new value with perf_ctrls.auto_sel here, and just return if they are the
> same.

Will add in v6.

Thank you,
Sumit Gupta

....



