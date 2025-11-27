Return-Path: <linux-acpi+bounces-19323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD8C8F02E
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFF43BCAB8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF458335099;
	Thu, 27 Nov 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KYU033Za";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KYU033Za"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9A334C0A;
	Thu, 27 Nov 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255296; cv=fail; b=ILLed6ymdk4GmDKzKmQGvs+oT4ZJpZDMQLVvA0bfnimWJ/dPfyiTj9djLHRorrM0pjQN5lOig/PG2kMslbajsWe6QXYQO3oFRfFBbBJ8OxGQfaOQKu2mrgmi0DF3IR1c6GjgZV2vxUo/++vxSSawIknycxb37frvrqjeI4JtN7A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255296; c=relaxed/simple;
	bh=NSo4XRehT3h6B5nSiMWtJcxAsmhlrGgv8Yw4M/TnrzM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKBTW9lJLidYMvzzLeNuIhpZ5kakSknUL13NjiMLWdrquCQ3imoGwwDsoaFxsJMbGlWOFX3v5asXgfjv0H8ypBQty8XfhpLSuQUI9E+zsnDU2p598Hpg7y+1E1ffDhU7RPMD/xi42mcv1y2KPbl3469qCPbYoGtpz55a/ztnQQs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KYU033Za; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KYU033Za; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ca7OCriyvTpslAz4/YW333npjSR+NS7gItm8nns1NsrwqUdqYqKJuYwlTypcvJ5kFwFo4d/Qgryi5m0lUo6m94YgALypURPQQacyeXIrcE+GBtfRnGvjqIWRjZrNhVH02WWrfBbx6trowKdtTpzNnOyLzu+VnR1pNvhBZ9fyKSwDjpDr/OOA02jMClN1+S1nLrnlU3nfUV1ffe5arXvkpfs6Gbp6cMNwaIfFjt9a/ULUkNdDiWBNjU9f73Y9KmlO0QeeuwSxF/HFTCc42Mtv5u7xDhwWFHImWbI9zZ12cg/RVS3282n03Nz0UaRNxzWQel1T0uMZ93G7VVti+fMdbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFhpovNIW4zoU6IpWBva3F+yRZ5QcDQYLcPce/PdK/g=;
 b=wRuQgSQtdfIO3YZQ5mcCHicOuRHz9AeaA+taG0AicocU4W436Eo/M9h/7pC9IaJnvA/UYegVD4WbRqufcDb3dB5aQVd3jlyNgnuhnNpBysbZ/XBPpJTBa0rqECOpk1CUOyt1TgRXpDEL+ifNKVCaODjkbqA+P84O0h/D+jTMxUsJG/6ozdSVKMiPTLnJstYH2/pruDv6yPnp9xMUahruZ9eyXoOvFE96Jsd3yPOJpy2Dj0VOmajaMHQDZXFJ9AND2BpDn4KIVeLtBBmS38llU7Jweojjgfu2uYfoLOQhu3hKBZWdtNQV76Tb8yaa5cpwZDwlY1bfBWBZNQA9D5S7bQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFhpovNIW4zoU6IpWBva3F+yRZ5QcDQYLcPce/PdK/g=;
 b=KYU033ZaQLw4yRhR33flC/6b5jWzJ4AO7sQVo1xAhH7OhrNuU4wncj7Jw+QONCBGx9ijKL7Z+h9ibztvuAHKjPQvb9xBvQI9YMAmgootDgfJHwQ4U+vsIBL9TBC4ctbslyCmYKpLbcbjhL4jOo+yza0wbF5IGdOVme5ZmJf4AI4=
Received: from AS4PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::15)
 by PAWPR08MB10258.eurprd08.prod.outlook.com (2603:10a6:102:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 14:54:50 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::9) by AS4PR09CA0012.outlook.office365.com
 (2603:10a6:20b:5e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgv7jYny2dFUlwd1AICf0nA5OTyHUfaM95K3QYV13fshaspYnWNT2OMFHNJj+07PJrAHlb3k1Yy/7wW6JxXQiEkegf+XaCUUX6s65S173idaxqHg55qRj9I5cl8I8VAlj0RsjSaL4jG5uCWCNm/z7UFxamUHB29kdKkbQGz14NdWIFg4+vYeRtgVnuWgYqQsvSwmi+uSyGUhcvvoJB/y2Z+aRjuxmoiHV1c2baW6QmeBhVIogowon8lK+e9x4/3rGGYrwAPdBM8BecFdsqs3ukLvaFPvxBaqCN5TIIHac/JK4HiRZ8LONjHK6DjzIJGvj59JxcUVPdZ6SwLOCs2JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFhpovNIW4zoU6IpWBva3F+yRZ5QcDQYLcPce/PdK/g=;
 b=IJBgwMrPKCrMltZOxKGqhd1BfdT5ftuhT8A/AdvIRgOFAq53/zvSf+0o2HJx6+xhqUmzGKY1nUlsa8Jd/wRmNtiMZMA1yXXtPZY5CxW8vXuCHw+ZKuTCa3G/UqiBT0OEBQAOaAcWxof5BAp2LSDt7aZk71OVPAW9rMyP1RRsVpTDI7/6eAnaiqAe1d3RgG5ujVUg3kXZhMxkV5CP/zXbrmYvCaK2KkINHKB8eX7KMCSdLR2QJQ1IVHddq6aCzobX16fGMYGDokgHUqtC6yo19ML0NXcG9C6VSbbLy1Qxo8EmPmQFXG0kwIXNq37GjuYeC4xFhy9XU+UQRfUSuptRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFhpovNIW4zoU6IpWBva3F+yRZ5QcDQYLcPce/PdK/g=;
 b=KYU033ZaQLw4yRhR33flC/6b5jWzJ4AO7sQVo1xAhH7OhrNuU4wncj7Jw+QONCBGx9ijKL7Z+h9ibztvuAHKjPQvb9xBvQI9YMAmgootDgfJHwQ4U+vsIBL9TBC4ctbslyCmYKpLbcbjhL4jOo+yza0wbF5IGdOVme5ZmJf4AI4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:18 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:54:18 +0000
Message-ID: <1decddd7-54d7-4e7e-922d-b68b901bf9aa@arm.com>
Date: Thu, 27 Nov 2025 15:54:12 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 5/8] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited register
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, corbet@lwn.net,
 robert.moore@intel.com, lenb@kernel.org, viresh.kumar@linaro.org,
 rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-6-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-6-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|AM3PEPF00009B9C:EE_|PAWPR08MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b7b59d-3b59-4433-4f7f-08de2dc4eac7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MzJWeU1odHprZkovVmt2MWtUOURaMmJWMHV3czJmWHF1c3FzWjd1RmFyRWJz?=
 =?utf-8?B?UHpyczdKYVlZdm8ycVBXZmx3UkdIaUYvdzdQb0hncXRJM3cveGpobmxEaklQ?=
 =?utf-8?B?ckZQOUVWbjY3bDRvNWpUc0tiUDNFVmtNbGYwYmdCbXVsK0RDQWQvNlpuQit1?=
 =?utf-8?B?aVZpQmVOclJMTVg1L0NXYk5WSVM3S09FZENqNlBQL1RUcHA4Zm9UZ3dBQ2Zw?=
 =?utf-8?B?WnRNMUdGTU9mai9VaFhqTHRxQUppdmVPMlRpbzZwdjZGUWN5Snd1NkQ5ZCtn?=
 =?utf-8?B?OHdqb3Z2OENNT2tCMlFyYjdub0pJWEZnWVRrNG9LYU9ieitCdm1pVTRDbVor?=
 =?utf-8?B?ditrSys1RXpkbmtJZTZYZnJNa2YyL0VMakUwcER4ZFZuZmlnd3lmcmU1WEtK?=
 =?utf-8?B?VkRtRjl3MDlUeXZveFVDb2d4MlRkUlZPVlJQaUtDV1l0UEEvRWVrMmd1Vy8w?=
 =?utf-8?B?S1BHYjJvTTJRSEV1dnZqUkFzeFRzRzkrS0FjMWNuSHQ4SXJyMjI2YTZaNjJi?=
 =?utf-8?B?QlhYWDA4S0dxd0loSDlmY2s5ZkdnQ1VaeEpMdHBXNHhsdjJQVEJ5MFhGUXRY?=
 =?utf-8?B?dmJEWjMvVWZDeFQ4SnFPUlVqU3RKaHZlc3g5cDY4bVpNVmFHaGhQTXIvSG1z?=
 =?utf-8?B?NGtrSnVMOUZ6aFNMZ0d2NWpIQ05SOG94M0dLTVU5dnJkOUsvY3VkRi84RmhS?=
 =?utf-8?B?OFduWlJUQko5ZVlQRXN6MmJ3RUM3NW1MdnlkYnNnOHpwN1pXNFlOeXFVOFNx?=
 =?utf-8?B?VUlHNG9SS0IzRG9lcnI4OUlDWjJrVGtOdndGdE9CODhuYlVrMDBlTGhjMUsr?=
 =?utf-8?B?N3RmeFpPbjJQNmtIZ2lCQ3VSNU9vbU1XVzk4RGFjYXpCZWxZeXgxL1lxdjM0?=
 =?utf-8?B?WXJNUGZZb3FvWVdxN3l0dVJvT2g5cWVMNFk0Um82eEdhZExLZXpaUFUxTkFy?=
 =?utf-8?B?LzY0dkVmWWxBTmVBTGlkRDJRYVRvMHBUT3YrNjN2V3Y0WURka251WEFOTGhI?=
 =?utf-8?B?eUYvSUNqa2tNaGwvbk4rTmtROExoVllyN2pPVTdZYWt2R29nN3RoZFlvWEZ1?=
 =?utf-8?B?VE5oUS9lbzlReWxBckNOZi9MTlQ4dkJUWm5mdURza1J0N01YaDl5dkNNRzVz?=
 =?utf-8?B?Uk0zSklOK2U2RVlBcjBIS0dHWDRSUVhuZGI3MXhTVExSa0NsUEdkZStVQnlz?=
 =?utf-8?B?bkNaWnlmdXdra3FURXNpQ2hYWThQUDZFWVpQZFBnNkpxZzREekd5VkFlVTR5?=
 =?utf-8?B?aWRWN21henZwMU8rdlR1anVGMTVhOC9pN2dzQTZaMWxGWk5sR3FNalVtK05T?=
 =?utf-8?B?UFV6WGxvNFRKVGYzMHNiK1RaZUUvL1dzK0FONU1CQi90QXBsbnp6ckxNUzRS?=
 =?utf-8?B?dkczclFvMElJTzhocmdwNVY0WlZ6Y0czQ2dvM1hYWkxaSlB5eGVhdlZKQ2Fz?=
 =?utf-8?B?U2J0bktqTGhJWC95b0lZdkp0QnU2MU85YS8zQnFndDZSYlM1Nmd0M092dmhs?=
 =?utf-8?B?RDJEQkg1alJUUEFvcGdOLzdxSGRxVjVlazJiRG4wTXE2MFNwb0NUSU92V2th?=
 =?utf-8?B?TVpkWGE3MmxoZTlzWTd6SkRNU2liTktDVGZJRGxRakNueWVSNUxPYWl3eXdw?=
 =?utf-8?B?ZlFyenVDMWZSb2lNL001cEFTQ2FEMlYzUUpqNGM3ZzdSVGtRMFlVbkYzL1pD?=
 =?utf-8?B?QTd6ekFCbW9yUGpBT1F5RUxNY1dJYnJQdTBzeGFQRGdrTzBBN1BKZjRad2hS?=
 =?utf-8?B?ODI3Mmt0aVJIUC9LUzM0eERXTDgzM0tjUUlTQWNPU3JoVmwvb0FhZVVGZDYw?=
 =?utf-8?B?OGJhVmtwSjlzOWdqRjZYbllib1RNVlFjNXFSSGZ4dXFWL0pVdTJEaEkydmtj?=
 =?utf-8?B?bDdLNzlTdWpqUzRWQWpzek1yTTVQNFJCZFp4ZnZEZGoxcW9wLzA1NFJGRHBW?=
 =?utf-8?Q?45rVI/GV+nA9+uZV8luWpJZUVuiN6/YM?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a6616863-12a5-452d-167e-08de2dc4d70c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|35042699022|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1PQ3o5TFZMZ2dYRWpSdTJXMGQzbndOcHp0eHBOeUw5WXF5RFRST3hNTUQ1?=
 =?utf-8?B?NTcxbGtLNG5xZ1FnaVgxdExaa0xwbVFWMlREeGNoemtYQ1lVNkJ5d3dobldD?=
 =?utf-8?B?RXVjOUQvaU1oaGdlYjFKMCs0T3dZT2JLRGtJMnVoWU9IaXlUV2RoSzVhZ1Fr?=
 =?utf-8?B?WVUxcG92OUlRd3hqQ0NKN0FCck5KTTZSMUJvVFQ3MjZYWjEwU0U5a0YwTXZF?=
 =?utf-8?B?Z0orajZnRDBIYk9ReER1UVhuV1A2ci8xdnFEWGFtODNIeG4ySnpFOTJYaGkr?=
 =?utf-8?B?NjBlWjh3dW5BZmFXSTBnU3FsT1E1YXg1N0hyNWYvMFl0TG5neDR6amxpZDlH?=
 =?utf-8?B?dUV4YW05UldoZEFucW9ZQnlZL3ovc21RdXRMbTRBR2VmcVdxRndXSDhHRkNq?=
 =?utf-8?B?R081VHg2ZUpZbmNIU2hJR3V5SU5sbnpSTFpGTEJjcHNCanRoMTlYRC9OUHpv?=
 =?utf-8?B?UjFEZS9HYWhtQ3hhaitDZDQwcmx1eG5CeU9vam0vemN6WWlOb21SdTlaekJs?=
 =?utf-8?B?RHRqRUNTZW92ZlU4UDM3NE5yNldPTTkvYlozNWtmSW9YOVFjYkJuZ0lDZkhN?=
 =?utf-8?B?WUJhclUwdlhMa3JpR0NvbUhQWVBjSlZiNWxWV0tNVThJeFRNTjkrVE1HSE5o?=
 =?utf-8?B?N0JCMVFETEhsbVlvd0ZQWFo4bGlhU0dEbGl4UjRUTVBkcFRHQndpbDJVTjVm?=
 =?utf-8?B?aUZ5bmVIVllzSGh1Y25YOVlTQTN0Q0lyMU4xWVROemdPNncvS1lCRVgxQ2pH?=
 =?utf-8?B?RHFXaDdldjR5d3FDTlJ0dkhKV0JZYm52RC92LzZuK21YVkFCOENhY2ovZURT?=
 =?utf-8?B?dEkyVXhkTjdhMlkzeDFrQjlobkhVcWxUcloxdnRqQTNjMDc3YTBzZ3dzVFFT?=
 =?utf-8?B?MHFHZkZjekhHR05uQVdlbG5vRXFqbU55emp2UXZnYy8wTUVMMG5pMEIrNUZr?=
 =?utf-8?B?NHZSTDRFMlFCem02c0RkWDZ5YkU4bXBpc1g5ekVWVzMrUFBYNXJ2akx1L2V6?=
 =?utf-8?B?V2JsRk40VEpRT3NZcWt2eHp4S21qbmxxNHN2eGlGanhuM0ZrV3dXeHpZZkU3?=
 =?utf-8?B?aC9zYktlMHVlQW1ON3hkNXgzSXd5N3NwU05HYUhzUGZKQWJuNnlDWVdaTFRu?=
 =?utf-8?B?Z2FaeENleFBDTnpPMy9NQnN5d2ViYW5PY2RWTUhoelBiaGxZNUNGekxUT3Vr?=
 =?utf-8?B?ZjlaWmJVWkVwbS9HN2tROTZ4S2FFU1Rad0dNb1BqUEphMm92ellWQUZlT0tZ?=
 =?utf-8?B?UEVlbWlLWGZCb1VKWGd0ZHFURXRyT21ZWDA4UWpUdWZvM3RETkE4TVVXSlla?=
 =?utf-8?B?dmZ3TThOMmpzVFdrZWhYcnlsck40eWZBZTF3TytXZ0xMNC9vQ1dSSVdzZlF0?=
 =?utf-8?B?bWY0MVE5WWxXLzdWdTY2ZlZqUWUzTi80UXhDTllQZ3NmVitIcFdQUU5WK2xo?=
 =?utf-8?B?WEZBbkxOQjhKUEtNdHI5MmFBbDVtT2Ryc3NKeWZzdXNoNE54YmI4TWNrcXFN?=
 =?utf-8?B?bHpBYkgxT25zNXJmR0V4ejdMREpuMFpWMFQ4aVl6c2pUN2xTbndiNWlxMHZ0?=
 =?utf-8?B?bXVISXhrc0FpNGhnUVJ2VC9oYWFQdVhrOHVadWxjaytjNVlsNFRmMVNnd2JU?=
 =?utf-8?B?VU9VWVBmZS9XVERXbHFFd2F6V3dwM2FDNDl2MXBrUDlNTXRFMGpqSGFwSWZG?=
 =?utf-8?B?RGIvMlhad252eHZ0TEt6MjRjKzhQSEZPZjBXOG5xNFNnNi9oVXB6U3U2bUhu?=
 =?utf-8?B?OElBY0ZVdG5zZFZndjNic0lTSHVpQjh5YnFqRGk0dDQwOVJsS2FsbjJOSVdj?=
 =?utf-8?B?UXovYWxWY3dQWFdrOHNMOXgxeU5oTDhja1RGa0ZaUnpSMzN5dis1d2JsZG8y?=
 =?utf-8?B?bDlpS0ZjaVJxMGVWVlg5eEV0RzQ2aWtYYlBaYzRMbTdQc0J3QjJCM0xJYkEx?=
 =?utf-8?B?Rll4S2FzcXFrUHhOaWcvZENYMVEyQ1B0Z1EvK1NBM2dia01STkV6RVQ5b2dl?=
 =?utf-8?B?aW42eHRTVk02aU4rV1VSaVljRFh6NkVyb1VtdmM0TlRBVnlSUWNIMENJRWdC?=
 =?utf-8?B?b0JZejN0L202bkYwNVk0V0d6eEZkM3pNeVY2TXlLa2RYYWFsa21weXlkcTh1?=
 =?utf-8?Q?Q1sM=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(35042699022)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:50.8001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b7b59d-3b59-4433-4f7f-08de2dc4eac7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10258


On 11/5/25 12:38, Sumit Gupta wrote:
> Add sysfs interface to read/write the Performance Limited register.
>
> The Performance Limited register indicates to the OS that an
> unpredictable event (like thermal throttling) has limited processor
> performance. This register is sticky and remains set until reset or
> OS clears it by writing 0.
>
> The interface is exposed as:
>   /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 12 ++++++++++++
>   include/acpi/cppc_acpi.h       | 10 ++++++++++
>   3 files changed, 48 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ef53eb8a1feb..9b8da3ef06db 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1810,6 +1810,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>   
> +/**
> + * cppc_get_perf_limited - Get the Performance Limited register value.
> + * @cpu: CPU from which to get Performance Limited register.
> + * @perf_limited: Pointer to store the Performance Limited value.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
> +
> +/**
> + * cppc_set_perf_limited() - Write the Performance Limited register.
> + * @cpu: CPU on which to write register.
> + * @perf_limited: Value to write to the perf_limited register.
> + *
> + * Return: 0 for success, -EIO on register access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_set_perf_limited(int cpu, u64 perf_limited)
> +{
> +	return cppc_set_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}

There are currently only 2 bits used:
- 0 Desired_Excursion
- 1 Minimum_Excursion
It might be worth defining these bits and mask the values when trying to 
set the register.

------

Also NIT:

The spec. says:
" All accesses to the Performance Limited Register must be made using 
interlocked operations, by both accessing entities."

I am not sure I understand which synchronization issues are faced.
It's just to report the comment from the spec.


> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
> +
>   /**
>    * cppc_get_perf - Get a CPU's performance controls.
>    * @cpu: CPU for which to get performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index cde6202e9c51..a425ad575aa6 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1043,12 +1043,23 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf, si
>   	return count;
>   }
>   
> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_perf_limited, buf);
> +}
> +
> +static ssize_t store_perf_limited(struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_perf_limited, buf, count);
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>   cpufreq_freq_attr_rw(min_perf);
>   cpufreq_freq_attr_rw(max_perf);
> +cpufreq_freq_attr_rw(perf_limited);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
> @@ -1057,6 +1068,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&energy_performance_preference_val,
>   	&min_perf,
>   	&max_perf,
> +	&perf_limited,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index be7de1222eee..8baff46f2ac7 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -177,6 +177,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>   extern int cppc_set_min_perf(int cpu, u64 min_perf);
>   extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>   extern int cppc_set_max_perf(int cpu, u64 max_perf);
> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>   extern int amd_detect_prefcore(bool *detected);
> @@ -285,6 +287,14 @@ static inline int cppc_set_max_perf(int cpu, u64 max_perf)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>   {
>   	return -ENODEV;

