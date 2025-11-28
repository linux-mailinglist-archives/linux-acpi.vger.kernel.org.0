Return-Path: <linux-acpi+bounces-19356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC18C92691
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 16:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DA33AC4C1
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40932C94E;
	Fri, 28 Nov 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jQ6rCYgF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jQ6rCYgF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC6329E48;
	Fri, 28 Nov 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342417; cv=fail; b=iwWAGYx3enev1GagdGzLpwdKw0k9uaZR8Cv5IJISi9oBzYuC3bd81s1zAXT7FNwBDlFiCnc3EnMTUjvBq9BtJ5vsK/9EIr1hTQ12J7OX6SJutWDyzGEBHXIROrIIA5ejvXmIEjwdoHNWsE7DvGpQJTuzM1DOyo1/q8ukJzCuUUo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342417; c=relaxed/simple;
	bh=E9nKXj1zpBE3Ey7cK6MvFuY9LJYC5ednSlJkdO7tnec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TyAarMQSnkERNx9AiY1x7umReqUJNkW5G/cjZGVdg8AFg89DI/AA1eS4wHD4G6o1beKsLMtEUKqa5BVis2vfELKW72519+P/SdguASObwSQR6i8vHf2QrDpqeJGa6nabk77idrgGhBxrWMrVwV2Wfu4be0BsjtiKRCKX7XaKVdQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jQ6rCYgF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jQ6rCYgF; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lcg5XrX9QDCBQbxDTSh7PWY7ywWYlW+7fmedDOj1Yi3YZgOInYfVSYWusNB6hSjwyRsBVmcqaGqhXcQJcLD/VVh/ukY06Q7h9OZBlymETbwfoK5TNwGF8h/mN/spTwSUnh7K23+XxbUcPs01AHU02V7+v3Qzk3Ur89YhITtMu+Kjb6H35npPGCKc6yQ21pvq2R4pdK7843au4m+BvLQTnadqWO55CnuEgGSACVuWu9fCK60g42zVifDeMzfP3jLeeXaUMouCv9r7+aTdc8YxhIT4ZpAfqxR2Xv0qpkQlXVG0qwDsQOY7yX10q/VTOdvfhdLL5G0j4VS3EB0jTlrR9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA+qm1XYb4FOfmD3mNNS0j9xZ7Wpiy1asxIPU+AcGt0=;
 b=LoCPZvbQ8rBXlxtzB7bMCTNtkCvw4Dv2P4vEVoJN2Cdj8pC6Ancqy1MfxDpx+CGHcVenU0u/4JuhMcOn5GbL6AGQZcnLD/F8lY8xJ7M03aExxnIRI+xmrwJcSd/HqAhsTbAGlHfjN3jwcZkZ9jRDCpHMf0XBfRBv7YyY3EAFFmp2vvYSqFF47HrHP717bz3DGj+tQNchuh2XfaMSTWYtHKHoZyPnQYCGQmHSp80i7No0U/l+DJpzYKICepaPxrJnXHn+UV3umHpDOFSNpS46/fnMXxqZcIoqMRcz0JLPfb+r2z2NJSgIgTZCSka1TBZarRCn4gkWZPssRhM8u8jj1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA+qm1XYb4FOfmD3mNNS0j9xZ7Wpiy1asxIPU+AcGt0=;
 b=jQ6rCYgFcEvMG6TZ4OlG9isFszh8JSOtvpuKYdxlG02K1IHUyG4fDGcffFFFxFv9Ez4gwMYCUnpTYihn91fsae6UrLth4vhMKApjavY3FQEMDyQzmYVuooIjPyFcEd49y7fjicpMskJOgkWEtY8p4G5d/1noC8GJsfSHsniORuk=
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by GV1PR08MB10608.eurprd08.prod.outlook.com
 (2603:10a6:150:15e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 15:06:48 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::99) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.15 via Frontend Transport; Fri,
 28 Nov 2025 15:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7 via
 Frontend Transport; Fri, 28 Nov 2025 15:06:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hda0GCY6YfsZ7iLwDeAVECsC8s7oy1CTuG3EvyHX39AKYA5Mrg9eH5Lk/Pq3RjUUodZWTsRvwoMYQQc7BHhPffmVJ9jlYpqo+Sl+779d0yr4Uu0im5fCkY4go8j9mW/Jz2wU5YM2pwUI2I4zKh/libH2ohJ+2ftLQpGRSWDEacmrBx5xuf4W/1NZ213oeMaboPA/NinvMcZ4AoxEBjcbwl13Emmx7LVgtiPh/tI3qldx2uHjIPzmG0c/wEYuC9a+MQ7DyZdjhZf8XbTl9K9y/18z8A2nt1YejG+la9wt392AL2ZuWZQx1i9XHXKclwnUXQvId1An/zcRdX/fiESksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA+qm1XYb4FOfmD3mNNS0j9xZ7Wpiy1asxIPU+AcGt0=;
 b=lAR9va+M1p5Z7cBszuzj1n6LPSvZuVynzoaeW+RZFnVsF9B92k+XvBEOn+jDP7X7oOODZfZzKXBfpKty3zrlA1loAOztvYlDZrKM5Q7wkZ/mssyRJwBtg7vJQYE74xrzTbEjkcd44Jv7Dw+i5FEgy7nPUAVPfSxVqOn6c1LHi37UIAxzjXllMs+2DiwonbyKM1HZ2kHEgC4fYToe2TrdQrD1H25TaDhwK4vZgXbIwlj3Zj8NXfN2FsAlxbBz0qdZi1GzelhX8QiqJono5rput5r9WRtXMBf4h9luYw4wlo+FbERihzebcDIm7SrK4HyH8WahcEHWFptiv89quvzsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA+qm1XYb4FOfmD3mNNS0j9xZ7Wpiy1asxIPU+AcGt0=;
 b=jQ6rCYgFcEvMG6TZ4OlG9isFszh8JSOtvpuKYdxlG02K1IHUyG4fDGcffFFFxFv9Ez4gwMYCUnpTYihn91fsae6UrLth4vhMKApjavY3FQEMDyQzmYVuooIjPyFcEd49y7fjicpMskJOgkWEtY8p4G5d/1noC8GJsfSHsniORuk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB8575.eurprd08.prod.outlook.com (2603:10a6:20b:55e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 15:05:45 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 15:05:45 +0000
Message-ID: <22a86779-102e-48ce-a79e-4a324c554984@arm.com>
Date: Fri, 28 Nov 2025 16:05:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, ray.huang@amd.com, rdunlap@infradead.org,
 zhenglifeng1@huawei.com, robert.moore@intel.com, lenb@kernel.org,
 viresh.kumar@linaro.org, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com,
 rafael@kernel.org, gautham.shenoy@amd.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-9-sumitg@nvidia.com>
 <08c65096-dc70-42dd-a085-900605c3fe4b@arm.com>
 <0e24a618-4a42-4fa8-b9ed-6d7db9b1a8fc@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0e24a618-4a42-4fa8-b9ed-6d7db9b1a8fc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB8575:EE_|DU6PEPF00009523:EE_|GV1PR08MB10608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0671b341-3c4c-484d-930c-08de2e8fc0b4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cHJ1aVpsajU1cTV1TW1ZRXVCUmhuaXlSdUV0Q09DY3Vtb016aEtBbHhkc3ZN?=
 =?utf-8?B?eGNqUEY5QSsySyt4dnFaa1Y1ZG94eWpheDhsc3NrdnNkMVB5d21yazRLM3di?=
 =?utf-8?B?TDU4TmptSW5KdklaSXEzWXh5aVhUQmtQZXVZZE80MFcwK1JVMU5ycnZubFZk?=
 =?utf-8?B?SUZudk53OFJEaWFLQzYveVFRMTRMQzFEZ1BRR2dIb3ZaZUtyKzZTZnFRcHR3?=
 =?utf-8?B?L3MzYlNQSGFGajVKSTIwZUJmUGZzN2V3N2RHUENRZWRmWTJZdjY3OVhVQUpK?=
 =?utf-8?B?S2xiYk4vTEkzd0xxa2NwNWZDSjhKVk4zZ2RFYU1ZS2J2ZDJncTU2RU81YVJZ?=
 =?utf-8?B?SS9NVG1jVUZMOGVKV0VzVCs2OEFpREdQby9FT3haZU5HeThiVDF0Vk9hWHNU?=
 =?utf-8?B?SFF1aHNiczVnR3daeVdnQzRXWTMrMEhjZWlBdGJkNjZjVTNGT3VlTndQUnB4?=
 =?utf-8?B?RG5HWEhtZkFRZW5XTG5CZlBjMXlJMU9HOEEwdXY1bnlhTER2aE5LaWFKOXdk?=
 =?utf-8?B?dno5U2g0S3dYbVcvYm5jYUdqTC9aeUo3WkloWVY5L1VDVWR6VGs2SDNuc3Ir?=
 =?utf-8?B?aW9YQ3Y2T1piRkdYcE5xS0VHYVdqK0hncnhsd050b3U4YVg0WVpMU1Q4L0cz?=
 =?utf-8?B?ejh3K01XdlR0dUdZeTBZbjY3NEVvNEQyMlJMQnMvYzVTYURCc2VPc0RIaEhz?=
 =?utf-8?B?LzUxQ3RhS1p4aTBreTdLaUdkYVFFZGthc2M3VEJiV3pidUdhNGVoV3A3QThL?=
 =?utf-8?B?bjZ2a0VoSWQwOFBValRlOVprNTFDOTFjRjI2VkxTUzh1eHNQaHhlekppd3Bx?=
 =?utf-8?B?dTVqWnJDQzdKdGMyQm9wRjFoTWUzTVRvTzVMNFQ1ck5IaFgwOFdvelBFenph?=
 =?utf-8?B?dXlSVVZHb0wxM2ZsV2lwTkd5RStOeEY5ZW1OZXN0alJvaWkwaVA2NUpMYWxv?=
 =?utf-8?B?d0N4TUVLUitwczREU2cxcTlGZ1ZvMWFVcktIWk5vYjFnQXJFRFc3QzRGc0ZN?=
 =?utf-8?B?RlExbGpSUFRnUlVjQ2lMRlZxY3FlbHBkaTB6Sm96VnU5M3NjeUpSc1Q0VDJz?=
 =?utf-8?B?aW1uUmZnd3dCdDF1eWt1WDhXaTZFNEFIdzJCV1phZ2JJek5sZkZSRFBpNEJO?=
 =?utf-8?B?V0hvVCtkZ01oNTVNWll5NERJZWoxdUd5bnl2WU4rVXdVaEVXSmRpZ1l3VmRZ?=
 =?utf-8?B?L0RJTThneUVvVWUwQWpMNitXdTRnVVRvN0pDVUZra0o4YmdnMHFBVWpUb1Iz?=
 =?utf-8?B?K0pWdmVKb25zYXBUdWlnV296Q3ZTOUh6enZja2YzTVJqdmgvK081OUQ3WTRa?=
 =?utf-8?B?UytiR2ZKVnRYSzByZEhZdGduYzJUbFVGSGREZHhOenZWVUlFWk5hWTBkTDJH?=
 =?utf-8?B?dnNnNkV4T0dtZkE1S3J1TS9Rbk4vRWVDeS80RzhyV2VqNTkvczlGNmpvMTRn?=
 =?utf-8?B?MFNsbnAwMjNvZlMrVmt0NE9IVTJBWWZOdUV4M1NQckEzcktsTXFSY3dEdzBh?=
 =?utf-8?B?YURTTC9GLzVwdnBOcFNBY1dXWXM2MDVHRWNpRUNoR1VyMk5tSkNxSVZnK1dS?=
 =?utf-8?B?NnVCM0xtOXF2TVlIOUZKeDFWSnVNMDk4a1VIOVNWM2l2YmNtaWZuaGl6MDl2?=
 =?utf-8?B?d2lhYTV2WlhRdzVtZVZUMndVNFJ0S3FRMHROUWsxczV1WmJwK2FMQzM4OVFw?=
 =?utf-8?B?YkdRMzRjYnp2dDJpZHhjSTBEbXkybkpGbXIyTEFwSS9KekR4bi9TOGFaYURX?=
 =?utf-8?B?ZS9Sd0wvL2JlWUVWbXJhTEwvOHVhVnhuaGNwbXRsR2YzM2dnVSsxWDFqSkRl?=
 =?utf-8?B?a2g4MEdOK2RnelRWT3F3aTNRakFJMDc3Q3NvNkZjL3NHa0RFeDI5MHFwTHh3?=
 =?utf-8?B?b3hSaUx3Z2YyV1U0ZkZjNzlKY3BWa25nMVMwMDNSeXJZWVltQUNSYTl1cE9G?=
 =?utf-8?Q?ck3wGomhylHKY8mdVTGDXP9wFuQlLgWA?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8575
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d488ba02-496b-4d52-a274-08de2e8f9b2b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|82310400026|376014|7416014|14060799003|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JwMDg1TTdoQlB2ZVpwcG9PT1JLSHkzUnhJZGxWQU9GNEdRL3IyaHg2UXFm?=
 =?utf-8?B?RU1FLzk5SThIT3BxSDZ4YWNiT3FUV1VtczNnVWVlSVNPa3A0UTk2ZkNnbEJL?=
 =?utf-8?B?L20xZ0lySjRKOWN4RXBMWVF1STFNZlo2dXpiOEhDTWlJQzdSUjMyZHVVWXRv?=
 =?utf-8?B?T0N5K2dkOTBCZU4xeStUYW5yUzNwN3NKbWNLcGx6d1FUTEZNZXVIek13ZC9h?=
 =?utf-8?B?YXd4QjF3ZWtBcVNVZzFCNmVzRDJFZjZQaWVRdm10Z0tNb1I4QzgzbG92Z2Nq?=
 =?utf-8?B?azBRbTFQc0FIT0JJS3R4VzVHbkNnWGh5aDJGc0VLekp4NWZYVVd0NFFsUllp?=
 =?utf-8?B?MHdNL2hrTWhjdnNYQ2hqL2h4b1FjVG0yNmFTbElSR2Zab1ZZb2M0NktsanNY?=
 =?utf-8?B?cjZZTGZFT2UycU0weFVTejAzMlE3b013TW9zVUJ0NHBSY1BaLzk1NEluYzVk?=
 =?utf-8?B?MzFDc24zR2NCbGdoVDQ1Q2tUYmZMN052Mkk4Qkt2bzIrS21YL2JPUjhSUjZB?=
 =?utf-8?B?TzZhUlhzOHdxVTFMMnlYdFYrc0F1azVGSDRpOXhZUEZQc1p6YTFNSzRVTytR?=
 =?utf-8?B?NDVwQi9jL1JnajJuVHdvUk84TGJmMHdsSENFbVpYbmpzemQxZXpodkVwQlJB?=
 =?utf-8?B?M053ckdlT2o5VDVZMkRUWEVmVDRQRXFmZ3lldit1QWdHa2dQRlM1Ykd0RWJK?=
 =?utf-8?B?clkwcEJHbm9iYVpCSkE1blg5OExkV05XQUpmUUhGRTRPdVBmNFV1QWFxdXQ2?=
 =?utf-8?B?VWhpRUt2ZXd1RVhBajYwZXErbEt2VSs0aERJdFZHaTdXZzFxM0RDSTF2TTdv?=
 =?utf-8?B?ZEw0NmxybmVuRm8yRWlvcm5xQm1ZSkhQVGdRZFp0WFgvZCtzYWNEZnQ4dmN1?=
 =?utf-8?B?Q05tdjN0cW1YekxkQ20zS3pxM29Gdjg1NThrZkc4aTBraFU4dkswSno2S0JZ?=
 =?utf-8?B?K0ZNbjNSUjc1Y0ViU3NaQWtVdU1IWjJRM0RlQWwxdTFEV0JNZkxwMzQ4d2ZN?=
 =?utf-8?B?bWIwU29Zb1BHOHRuT0Z0WHlFZ3BtNUN0ZDBxOTZhNkNHNldaWEtqaXFJSmJM?=
 =?utf-8?B?ekJJUUVHN2R1NEd5SUxDV3lQa1JYdXpzYnp5UTJRTkR3UHBFNkVOd0RJQ3NJ?=
 =?utf-8?B?RUViazE5VForbm5ENUZmYjRDM1Z0OW1jMXA5QmZ3dmhZU0hNMERzWXBnMzFn?=
 =?utf-8?B?U29jWGgraHBuZ3V3dHJlTTZ1Nm4yV2pvdVNRUUJudTFxb1lVbVRDc2ZzSzRX?=
 =?utf-8?B?WXhsa0I5dzhCRGhuMFRPTlJSekRXbWk5OXFpSC8weG9PdFhpZkRBRitBNzBy?=
 =?utf-8?B?cERTc2pPNTdxYUR0aS9PK0plVnFIczB6cnBCbHVIWEdjWFpJUGJ2cFprWllx?=
 =?utf-8?B?RGd5U0hueUo1KzU2bklqYUpmNVZqdFZtT1VUa1ZYcnJFRHFyOFZFOW1WWlVZ?=
 =?utf-8?B?RDgyUVo3OUhrQWdGdzhBc2R5T2grN0Urd3BoS015QmxBSmh4MkRwSlFWS2VF?=
 =?utf-8?B?dFI1QTJuclFjMFl1MHkxbS80Wjc0Zm9UaUYwYzVGTGY1Wng4SklGNWJCcklI?=
 =?utf-8?B?bGJHNlVFbkZpL2RDK1o0bkZUbXN4a0NFbytLYjVhdTBic2hZY2VIdTR4cC9Z?=
 =?utf-8?B?NzUrcUlwRVIxWUZ4WS83Sy94NS9lOWJSNm9lcHlEcnFoTjlvbFV5UUZvanUz?=
 =?utf-8?B?MkxBWWFralZ5bDhIUTlYYjhKbjdzWXN5Qm9FTGpIRmt0aG1qbGF1d0Q1bDVB?=
 =?utf-8?B?blJhMWlSUnFFdXJqejFyQStGYXVFNmo5ZjdPUTRrVzVuRVI5QWYrUlBGakV1?=
 =?utf-8?B?c2tmNElUTW9vcnZVc3NPSUNhMjAzbm55OGpUTjBkWWN2bVlVeGM0T0F6YThn?=
 =?utf-8?B?cDBOV3pUeXpGbmg1bnV0UmhDRjBaT3crQ1FseXVTZjYxbCt4SnNucmo4bFVy?=
 =?utf-8?B?VEJlcHR6c0VTOVl4S2duVUpsTVVIbnBxRllwdUtRU0IrRkUrNC9LeGtPa1dt?=
 =?utf-8?B?cmJYRTlSWGJPckNGbFptOElFTnRVN3ZWUEtYdTZramlvdmg4TzVVL0dGd3cx?=
 =?utf-8?B?OWFhbVBvRmdzM2pYN1o0YXM2R0FnN3FOUzliRGUzWDIrZWxsYXZreDdvTFhx?=
 =?utf-8?Q?teZY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(82310400026)(376014)(7416014)(14060799003)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 15:06:48.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671b341-3c4c-484d-930c-08de2e8fc0b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10608

Hello Sumit,


On 11/28/25 15:29, Sumit Gupta wrote:
>
> On 27/11/25 20:23, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 11/5/25 12:38, Sumit Gupta wrote:
>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>> autonomous performance selection at system startup. When autonomous 
>>> mode
>>> is enabled, the hardware automatically adjusts CPU performance based on
>>> workload demands using Energy Performance Preference (EPP) hints.
>>>
>>> This parameter allows to configure the autonomous mode on all CPUs
>>> without requiring runtime sysfs manipulation if the 'auto_sel' register
>>> is present.
>>>
>>> When auto_sel_mode=1:
>>> - All CPUs are configured for autonomous operation during module init
>>> - EPP is set to performance preference (0x0) by default
>>> - Min/max performance bounds use defaults
>>> - CPU frequency scaling is handled by hardware instead of OS governor
>>>
>>> For Documentation/:
>>> Reviewed-by: Randy Dunlap<rdunlap@infradead.org>
>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 197 
>>> +++++++++++++++---
>>>   2 files changed, 182 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>>> b/Documentation/admin-guide/kernel-parameters.txt
>>> index b8f8f5d74093..048f84008a7e 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -929,6 +929,18 @@
>>>                       Format:
>>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>>
>>> +     cppc_cpufreq.auto_sel_mode=
>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous 
>>> performance selection.
>>> +                     When enabled, hardware automatically adjusts 
>>> CPU frequency
>>> +                     on all CPUs based on workload demands. In 
>>> Autonomous mode,
>>> +                     Energy Performance Preference(EPP) hints guide 
>>> hardware
>>> +                     toward performance(0x0) or energy efficiency 
>>> (0xff).
>>> +                     Requires ACPI CPPC autonomous selection 
>>> register support.
>>> +                     Format: <bool>
>>> +                     Default: 0 (disabled)
>>> +                     0: use cpufreq governors
>>> +                     1: enable if supoorted by hardware
>>> +
>>>       cpuidle.off=1   [CPU_IDLE]
>>>                       disable the cpuidle sub-system
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index d1b44beaddda..0a55ab011317 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -28,8 +28,12 @@
>>>   #include <acpi/cppc_acpi.h>
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>> +
>>>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>>
>>> +/* Autonomous Selection */
>>> +static bool auto_sel_mode;
>>> +
>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>   static enum {
>>>       FIE_UNSET = -1,
>>> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct 
>>> cpufreq_policy *policy,
>>>       freqs.old = policy->cur;
>>>       freqs.new = target_freq;
>>>
>>> +     /*
>>> +      * In autonomous selection mode, hardware handles frequency 
>>> scaling directly
>>> +      * based on workload and EPP hints. So, skip the OS frequency 
>>> set requests.
>>> +      */
>>>       cpufreq_freq_transition_begin(policy, &freqs);
>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +     if (!cpu_data->perf_caps.auto_sel)
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>>
>>>       if (ret)
>>> @@ -565,6 +574,12 @@ static struct cppc_cpudata 
>>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>               goto free_mask;
>>>       }
>>>
>>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>>> +     if (ret) {
>>> +             pr_debug("Err reading CPU%d perf ctrls:ret:%d\n", cpu, 
>>> ret);
>>> +             goto free_mask;
>>> +     }
>>> +
>>>       return cpu_data;
>>>
>>>   free_mask:
>>> @@ -666,11 +681,81 @@ static int 
>>> cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>>>       return 0;
>>>   }
>>>
>>> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy 
>>> *policy, u32 epp)
>>> +{
>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>> +     unsigned int cpu = policy->cpu;
>>> +     int ret;
>>> +
>>> +     pr_debug("cpu%d, eppcurr:%u,new:%u\n", cpu, 
>>> cpu_data->perf_ctrls.energy_perf, epp);
>>> +
>>> + guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> Do we need to take the mutex ? Or is it reserved to auto_sel ?
>
> Will move this to parent function.
> Explained more in reply of the previous patch '7/8'.
>
>>> +
>>> +     ret = cppc_set_epp(cpu, epp);
>>> +     if (ret) {
>>> +             pr_warn("failed to set energy_perf forcpu:%d (%d)\n", 
>>> cpu, ret);
>>> +             return ret;
>>> +     }
>>> +     cpu_data->perf_ctrls.energy_perf = epp;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection 
>>> configuration
>>> + * @policy: cpufreq policy for the CPU
>>> + * @min_perf: minimum performance value to set
>>> + * @max_perf: maximum performance value to set
>>> + * @auto_sel: autonomous selection mode enable/disable (also 
>>> controls min/max perf reg updates)
>>> + * @epp_val: energy performance preference value
>>> + * @update_epp: whether to update EPP register
>>> + * @update_policy: whether to update policy constraints
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy 
>>> *policy,
>>> +                                           u64 min_perf, u64 
>>> max_perf, bool auto_sel,
>>> +                                           u32 epp_val, bool 
>>> update_epp, bool update_policy)
>>> +{
>>> +     const unsigned int cpu = policy->cpu;
>>> +     int ret;
>>> +
>>> +     /*
>>> +      * Set min/max performance registers and update policy 
>>> constraints.
>>> +      *   When enabling: update both registers and policy.
>>> +      *   When disabling: update policy only.
>>> +      * Continue even if min/max are not supported, as EPP and autosel
>>> +      * might still be supported.
>>> +      */
>>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, 
>>> update_policy);
>>> +     if (ret && ret != -EOPNOTSUPP)
>>> +             return ret;
>>> +
>>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, 
>>> update_policy);
>>> +     if (ret && ret != -EOPNOTSUPP)
>>> +             return ret;
>>> +
>>> +     if (update_epp) {
>>> +             ret = cppc_cpufreq_update_epp_val(policy, epp_val);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", 
>>> min_perf, max_perf, cpu);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>   {
>>>       unsigned int cpu = policy->cpu;
>>>       struct cppc_cpudata *cpu_data;
>>>       struct cppc_perf_caps *caps;
>>> +     u64 min_perf, max_perf;
>>>       int ret;
>>>
>>>       cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>>> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>
>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> -     if (ret) {
>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -                      caps->highest_perf, cpu, ret);
>>> -             goto out;
>>> +     if (cpu_data->perf_caps.auto_sel) {
>>> +             ret = cppc_set_enable(cpu, true);
>> The CPPC enable register is optional.
>> However this doesn't mean CPPC is not working.
>
> Ya, changed this in v5.
>
>>> +             if (ret) {
>>> +                     pr_err("Failed to enable CPPC on cpu%d 
>>> (%d)\n", cpu, ret);
>>> +                     goto out;
>>> +             }
>>> +
>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?
>>> +                        cpu_data->perf_ctrls.min_perf : 
>>> caps->lowest_nonlinear_perf;
>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?
>>> +                        cpu_data->perf_ctrls.max_perf : 
>>> caps->nominal_perf;
>>> +
>>> +             ret = cppc_cpufreq_update_autosel_config(policy, 
>>> min_perf, max_perf, true,
>>> + CPPC_EPP_PERFORMANCE_PREF, true, false);
>>> +             if (ret) {
>>> +                     cppc_set_enable(cpu, false);
>>> +                     goto out;
>>> +             }
>>> +     } else {
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret) {
>>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>>> ret:%d\n",
>>> +                              caps->highest_perf, cpu, ret);
>>> +                     goto out;
>>> +             }
>>>       }
>>>
>>>       cppc_cpufreq_cpu_fie_init(policy);
>>> @@ -910,7 +1015,6 @@ static int 
>>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>>       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>>       u64 min_perf = caps->lowest_nonlinear_perf;
>>>       u64 max_perf = caps->nominal_perf;
>>> -     int ret;
>>>
>>>       if (enable) {
>>>               if (cpu_data->perf_ctrls.min_perf)
>>> @@ -919,26 +1023,8 @@ static int 
>>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>>                       max_perf = cpu_data->perf_ctrls.max_perf;
>>>       }
>>>
>>> -     /*
>>> -      * Set min/max performance registers and update policy 
>>> constraints.
>>> -      *   When enabling: update both registers and policy.
>>> -      *   When disabling: update policy only.
>>> -      * Continue even if min/max are not supported, as EPP and autosel
>>> -      * might still be supported.
>>> -      */
>>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
>>> -     if (ret && ret != -EOPNOTSUPP)
>>> -             return ret;
>>> -
>>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
>>> -     if (ret && ret != -EOPNOTSUPP)
>>> -             return ret;
>>> -
>>> -     ret = cppc_cpufreq_update_autosel_val(policy, enable);
>>> -     if (ret)
>>> -             return ret;
>>> -
>>> -     return 0;
>>> +     return cppc_cpufreq_update_autosel_config(policy, min_perf, 
>>> max_perf, enable,
>>> +                                               0, false, true);
>>>   }
>>>
>>>   static ssize_t store_auto_select(struct cpufreq_policy *policy, 
>>> const char *buf, size_t count)
>>> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver 
>>> cppc_cpufreq_driver = {
>>>       .name = "cppc_cpufreq",
>>>   };
>>>
>>> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 
>>> epp)
>>> +{
>>> +     int cpu, ret;
>>> +
>>> +     for_each_present_cpu(cpu) {
>>> +             ret = cppc_set_epp(cpu, epp);
>> Isn't the EPP optional ?
>
> Moving this to cppc_cpufreq_cpu_init in v5. Will add handling for 
> EOPNOTSUPP.
>
>
>> If autonomous selection is available but not EPP, we will bail out.
>
> I couldn't find in spec that EPP is mandatory when auto_select is 
> enabled.

I was thinking about the case where the platform:
- supports auto_sel
- doesn't support EPP
Then won't this function return an error code and not set auto_sel even 
though
we could have enabled it (without setting the EPP value) ?


>
>
>>> +             if (ret) {
>>> +                     pr_warn("Failed to set EPP on CPU%d (%d)\n", 
>>> cpu, ret);
>>> +                     goto disable_all;
>>> +             }
>>> +
>>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>>
>> Also, it is possible that a platform only supports autonomous selection.
>> In this case, writing to auto_sel will fail, but auto_sel is still 
>> relevant.
>
> I am not sure if we will have such platform which only supports 
> Autonomous
> mode and has auto_sel as read only. Will add handling for EOPNOTSUPP 
> if we
> have such cases as the cppc_get_reg_val() will returns this error.
>
> Thank you,
> Sumit Gupta
>
> ....
>

