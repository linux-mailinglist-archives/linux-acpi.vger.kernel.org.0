Return-Path: <linux-acpi+bounces-12926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D8A82FDA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2509C1B611E3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C20278169;
	Wed,  9 Apr 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ND3ojiG4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62B278160;
	Wed,  9 Apr 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225172; cv=fail; b=VKJKA7gZpha21n4u5FHW0u6uvqD9sLck8oYUeiIZrljFO3lBRVryVZMeRpQqQyTw4lUPm1LuEbIphLh4VCcDrgCaBl0wceErP80YsvDr3vnKWFBciA2GPLoN8UwEMdBTB9bWK5LPVQUGHteXieo5tR97kFWumGCM1zduCrKuHZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225172; c=relaxed/simple;
	bh=lFd2rDz9dTGmp7qGExmubpfBc54PWXW24EbYrXra1Is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MbQgOeyDfpsVcYiFMFlAPNucwmrmmDaaVUWKbckK9cY0XPOpkamH50108X5oxz8Pj2gbGiT0q0bd64nRAXT6euy1DRYEwSV/q/Lo2ld4K00HAPdZ/M1fRsBhYGp+2UGBUR5RJzjNnBwPPWrODB7wAp+3Y2b0Zobf6SaKAuq2KAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ND3ojiG4; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRppQZ96/FaPbdifNq95DXNtJ1m7trB8p3c8+R2PRqfRFyVifGrWUGJVqUC09mYQBMxaisdLr+2tV67b2joYp7wKCRcKNjD4pfOCL4qLGK6HTvgkUimS+IXuDGrgBOImz22e9/oTBrNCi9OX0VakpDPbiWxmP7+EHjCYVaLzhkmB3Pc3Th9CalP44cZwdugzbq8E7y6jTBGmitIthFgq7pDssnNuS5UzVtpO6CiCVETkIykwXDiXjQzZJC8HUQ3SlakJOFDKpHQAahaM81wC0lXnnqdGjY4ZX5f3A4FmJZTCW7Layqg+tAVlNPaMqx56paPcItSUzIktA9LKEtQ7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVerIAozjBOwfVwKpeL/tnskRJV35QL75GFQ4/kiG2A=;
 b=qVMIfEr0uAkypsz7E39Nn/KoOV43sfyVp1ih29xeyC/Ttzm5BoF5vj8w1HYgf2ilkPVtOkVHZOd15TUYdQpQAmiF7zVEQ/f8B/4rn0dUkEyeYobS93TB7XWRZNaGT4sOIwp/sQZcXQrNS/T2UtGwe2PQADNMlamXdFJG70cAMyS0nlrQl4rfBUcEe/bfu//+rwcBj9vGJLaTW3r1EKZN4nIyyMuBw8UU2/GbEbvitQwQqYj4UuIZbne3e8zm39c70/lUkg2YO2nQUQjyasKSWP1ea6cBCCxZQTxckFgDOXbWHsAsosk2x1vC3ejelsGeDAwQ/F+0fMiqkeBkZyXt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVerIAozjBOwfVwKpeL/tnskRJV35QL75GFQ4/kiG2A=;
 b=ND3ojiG40BeIXTE3WcEL84KAwuD6drcbrDyk7V+LOF6tjJl9xkHhcLdvr/oJo1cmhruuGSctVYHGKxGWGNjTUxjVKfKAoX6V9uGMcf/PxKEwbSwia2+ge/Yux1wQXhdKADGI41wMR3uT/aDtQumYPuWQC5aOyY10HngVZbWaBKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 18:59:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 18:59:26 +0000
Message-ID: <e5dc4906-2b28-4adc-8e8e-ddd5d7cc985c@amd.com>
Date: Wed, 9 Apr 2025 13:59:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] ACPI: CPPC: Add three functions related to
 autonomous selection
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 gautham.shenoy@amd.com, ray.huang@amd.com, perry.yuan@amd.com,
 pierre.gondois@arm.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 cenxinghai@h-partners.com, hepeng68@huawei.com
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
 <20250409065703.1461867-9-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250409065703.1461867-9-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: d86bcae4-a5dd-4444-d811-08dd7798a62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNpRmIva0VaOEtPWEZ0MHNRbkdDY3R4aXVkTW0xN0dyNGFVOE5vK25BVDBU?=
 =?utf-8?B?SGZzbmYzTFlkaFdiL2RCR2NDQU5aQlB0RzdlQUxWeEw1RjhjSGpXbWgzWFJG?=
 =?utf-8?B?NFVEcmRPTjdzdXZGcmhGYisvZDBZWEV1Zjhnd0U4N1duQ1JvM0JGRjVWMXRH?=
 =?utf-8?B?dGlMNEFCeFdyN3plb2EyYXhSMDJNenJsSjViRm53dzBzZlkzMFhRb3FGZEtl?=
 =?utf-8?B?dTFMZnpCdVVEZVNhbzRyajE0dGQrU3g5L1hyb3NFNHJoNHdIdktBbis5bUZL?=
 =?utf-8?B?cEQrNUE4LzhvejVTd1h3dG5WMFMzNFRTRmtVVnFCTWcwMW5lRXdGa0wvamxu?=
 =?utf-8?B?bUx0ekxYOTBGMlhwaFNCWWFpcE5VZXo0SFd2STBIM2hLQjRpS2xFM2tLWEF1?=
 =?utf-8?B?T2VUbFdBNHBMYmRPT29yLy91bW5Cdzk0dVhqd3pnZUx4dE5vbHV0R0RCTHVu?=
 =?utf-8?B?RnFySnZ5dzMyaUZWQWlBRXA1b1B5b29waFpiZ1YyVlN4TEROdGNtQStoQVRP?=
 =?utf-8?B?VVNvV2xpUWQwVEpLWkZ2TmVhLzlYZlBwaTFPOE9abmoyTHZPSHZQekFnMUo4?=
 =?utf-8?B?bFZkTE9FWWV6bFFzMDZ4T1ZOQjYxSVVaS0llTlZjcE5UaDVCcmdoc2hXeVpH?=
 =?utf-8?B?RFZxZC85TGtuWTU0TUtpSGZxTVNpa1NZNHZuQnVSSGdEUXA5Q09GNkhsdFVa?=
 =?utf-8?B?RzRSUm5iUDZ3cnplR1dvdW5BVDQ1b0NsTXFQS0ZFYkYzSlh0a2FZZnhhaTBB?=
 =?utf-8?B?N2VPbFNGRUwyeFhYSFN2Z3BLUU1PV3F4U0oxUFRxalI1OFJycGsrWUx0ZTB0?=
 =?utf-8?B?M0srY0RzcGNVVDN1VFU0UHpxWnExQlZoWm12ZVlnbkpLYkFnc0VrVHV1L0NJ?=
 =?utf-8?B?dXVtSnZaVFQ5QjJMNDU4T21qdkhIVVVEbTRRbGFPaGtFaTR6WjVHSERxOHZE?=
 =?utf-8?B?M0tpcnNZUVhBa08xa1FseW9HVkl1dlI3Ty8wbnR4M0Y5VHRoR0NSMk13Q1lY?=
 =?utf-8?B?a2NQaXV1eWhKMU5kMHkxcDBDcWY4bWIxTEJWelcwY1hrNmxQK09BNGlTVzN6?=
 =?utf-8?B?a2t1Uzc3T2Q4d1NmMmIyc21LczRDS2lVRk05dGx6OU4zcDZCRnRvMElQZGlS?=
 =?utf-8?B?NWk1ZDNXbmhiSS9xak5uK2E0TFB0Y0ZVd0FPc1JNK29DN0tkSEpleUd5Mmdn?=
 =?utf-8?B?YVh4dndHajhveDY3aUFLZ1ZUN09nWWdtMitJWEN5KzJoTVRoZGkzM25xamhJ?=
 =?utf-8?B?RnUrbUxKWjFlZ055ZFFhQjBtdnMrSFlJTVFobDhGNlFPSjRJSFpjdEROQ2V4?=
 =?utf-8?B?R2grWHE4QmY0VXRNMjlFZGNieWt6b0JMVm9tRzFpMTNaTG1XUmdlYlB2OC9q?=
 =?utf-8?B?dWdpWjViMW01TXJyTEV4c1Y2ZTlRR3FHazhUV1VQd2szV3Z4cmhNTkw5VmRH?=
 =?utf-8?B?OXZpbjFFTGdNTFBSWjdmTkxMM0o2Vm05WTJnaEhpcWVkdXJZTGxBRkJzcTVR?=
 =?utf-8?B?eGlrVWFUb0VmemdQOVJmRFdFRUhaUzJab2xrNmIvYzdNWWE4Yjh5ZDJMbmEr?=
 =?utf-8?B?MGxnM0dHaG9XSmFWZDBOM3FqWmZWa3pTRm9WWEw5MGg0T09PUE9vZ2pPWW4r?=
 =?utf-8?B?V09aZ2Q5WTBTNVVkT3JncGxVRkZMKzZ6Q0drZm90YUJveElkWDZ4UTBSUmFK?=
 =?utf-8?B?N3k2Yi8wUUg4RkZpaVVneTJRY3ZMeXZTTkhBVHRucHVRTkhmUkhkVjRFTHkx?=
 =?utf-8?B?RXRKcVN5b2hoNDcwUDhhVVJvbUdyV1VVMy84c3FPblFRMSt2WmJINHB4NHVK?=
 =?utf-8?B?RFNUeUZiU3NJc0JMTzdvempLTFV5NjlBWXY3MlFld3lQb2p3WklmWkpFVytW?=
 =?utf-8?Q?tI3ebSOXEwG8E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVQ5TlhVekFKTnBla3VxOG56Vm94OWxDUWpBWE5NTFlPUUxrSmZzcVNuaHcy?=
 =?utf-8?B?dTlqREU4a0RKam41UzdJajFGSlFGQlpXMmZqWWZVTlhLSUlqSVJPTEtvQlpR?=
 =?utf-8?B?UkxHTGlkUFNQYmZRL0syVG5vZTIvd1NiL1VzcVlxQmpqamYrUklmazJWdlV2?=
 =?utf-8?B?Rm01SDVmRXFCQ2N5d3FJUlVYWVVmYVZybmhQRFl2Qkl6TFJVM1kxZ3VUZVlw?=
 =?utf-8?B?ZlBMY05ub3M4TmRmdHI1bldZOURSRXpKSGVVSXBIWEdiOC9JTU45KzlOdWsx?=
 =?utf-8?B?QVN2aEQ0bTRkMHVhTDBPVUxaL0krRkpzWmhsNXpDcUs4UXBUWmNucHlRZDR0?=
 =?utf-8?B?VDNUdkZHd3AyMFVQSEFCWUVEVTNidmVUUzB3VlR1ZWxRekhsRFE0ckhiZEM1?=
 =?utf-8?B?NHJ2eEV0RHQvOUQyT2J0NVVCZXVtSWx6MkJ6TjZBV2FlS2t0NnBOL0d1dXl6?=
 =?utf-8?B?N3d2dmdFVnMySlJNQjMrcFRqekJ3VEVleDZ3NXhvN1h3dCtWSDZNb3hZNjN6?=
 =?utf-8?B?Vk51aEQ0cUc1dzBmb0tkVVFYYkl4Qnd2Q0grS011V2l1OGxMcHEwNWZydnB1?=
 =?utf-8?B?cm9YenpUTDBaNm1kRmNBTXFHeXBpQnhlWW96cWpvQ0ZuOUx6N2RmbE1ua1Ey?=
 =?utf-8?B?bEg4TExwUEk4YWh2elNKVVpYeFVnRDltWm1jUm9JYk9XYzU4Q0gybXZ0NlNR?=
 =?utf-8?B?SFdDSGpvb3FIb2NXVno4WEV1Sk14T24vbUFOOWlBMUhyOHBGSnoxcjJPek96?=
 =?utf-8?B?UEczRWtKMDl6ODByMEM2T1oyTnRlWExmSkRhVi9ZVlVidWg4Um9KUkI5cHFF?=
 =?utf-8?B?YjlLalE5a2UvQzlWbHA5UVU1QVZXV2M1U050RUxNMXF0Nk90eWZIQ2FQVS9W?=
 =?utf-8?B?eDczZFdCZ2lrWi9kVDc3SnNacWRBUW9nVStIZyswcHUwVVZleUcrVWl3SnlP?=
 =?utf-8?B?eFVvaWN5U1hrRXJCRzNmQk4vQWM0Ry9VR0YrWXlGWXlTNnlud1dXY3AwT1pM?=
 =?utf-8?B?ZFZtSGYvYjdyODN0WWg5Ylc1eFVxbW51cDFWRmJjMUVPTjhQYkpISzVLZ2hH?=
 =?utf-8?B?OG0xbHYwOGlDejVLd2UrTGpoMU45RFhRbGlyV1MvY2pQY3lSdGtub0VoOEQv?=
 =?utf-8?B?OTBMKytUSUg0YlRYUTJjSXpxcWUyNUE0QTk5azVaU1pMaldYcFB1UkpkSktF?=
 =?utf-8?B?dDdYNTRLaHVkMzYxeW5MdHNHcFVYaEk3TDkySjh6YWNCbkVJeFRnaldkVzVH?=
 =?utf-8?B?SHpJZzQvV3QxMFZaTThiRjZMeGE5KzU0aEhJRURxTkEzeGowOXRNd3BFS1F4?=
 =?utf-8?B?V040WE9HUEJjRDZPN1UyeTY2citGZ2kwUlBNdVhCeWpSVFV6ZkdYSVBoZnZx?=
 =?utf-8?B?b3ZOaUtVQS96MDRCQ3U2ZE5pNmdsRTNmUjBtbDNFRll5OExFS2orL3RoQ3V6?=
 =?utf-8?B?R3NpREhpc2puaCtzWjNucndWUkpsSW1QQXRicUsyK2lOKy8wSTcwUWRLSnkw?=
 =?utf-8?B?M2JuUXJxaEU4MGRRcjNYYjNJbFBuMFdFbzFCbm5NQjd1WWhyYXdVSXh6bjBT?=
 =?utf-8?B?UkJFcWd3WGEwTFU4V3IyOVMyQkZXeDRmRlo3SDF5UlVnODRibkpkOStoUzgy?=
 =?utf-8?B?elZoNHJaTkJlMVg3VXRLbFA3ZGNZeHFYd21sdHdvYkI1OTVKcmRPWVlEL3hi?=
 =?utf-8?B?R2wvbU9jSzVoLzY1TGd5Z2dLMENDVnJpSXFrcjRvYlZ2andDV0QwRXlBVk5q?=
 =?utf-8?B?N0lmODZIelJWckpGM0tzbG1vZzNSUmhhTzg5Qk05RUY4dXE0LzJXK3YwMlB3?=
 =?utf-8?B?OTlhdXl3STBnYnFYWXhjbDkrYS9hMFZhd3hrTyt2ZFkyeXdENjZuZUZRYWtK?=
 =?utf-8?B?Z05vNmEzNGlFcGRzbDdoUUdTdWY0amtyWlZtQi8vRFBRRXl5ZFErMjRDSDJB?=
 =?utf-8?B?U2JyQnNCL2g2bkFMelBEc3JoNmFvdmh1dXNreWppdnYxbG92cTc4QWFZVFJR?=
 =?utf-8?B?czJtQ2lETHZWcGZ4dmFZWEl0Yk9NYTFRUHJRa043WTN4ZlBEeS9lanVRaUFW?=
 =?utf-8?B?bkh3bHhzNDVTOEl1blVMbVFkT1o4S3pmRjhqK0lnZ09HdHBRTzhYYXl2N2RQ?=
 =?utf-8?Q?CyuGe4FzP6SkLp8iUZ4G7g+Q7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86bcae4-a5dd-4444-d811-08dd7798a62f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 18:59:26.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khDFKl6h6H0TzT82/P1B3pCNlR1e4p5pgK5d05yUfVgHywclO09a7+qs6om6hShJjrfKVNeGBhQnCQ6Bk6r7hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693

On 4/9/2025 1:57 AM, Lifeng Zheng wrote:
> cppc_set_epp - write energy performance preference register value, based on
> ACPI 6.5, s8.4.6.1.7
> 
> cppc_get_auto_act_window - read autonomous activity window register value,
> based on ACPI 6.5, s8.4.6.1.6
> 
> cppc_set_auto_act_window - write autonomous activity window register value,
> based on ACPI 6.5, s8.4.6.1.6
> 
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h | 24 ++++++++++++
>   2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ef2394c074e3..3d5eace44af5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1608,6 +1608,86 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   
> +/**
> + * cppc_set_epp() - Write the EPP register.
> + * @cpu: CPU on which to write register.
> + * @epp_val: Value to write to the EPP register.
> + */
> +int cppc_set_epp(int cpu, u64 epp_val)

Any reason this is a u64 argument when the biggest value you can support 
is 0xFF?  Presumably you could drop the the bounds check below if you 
limited the variable size.

> +{
> +	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +		return -EINVAL;
> +
> +	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp);
> +
> +/**
> + * cppc_get_auto_act_window() - Read autonomous activity window register.
> + * @cpu: CPU from which to read register.
> + * @auto_act_window: Return address.
> + *
> + * According to ACPI 6.5, s8.4.6.1.6, the value read from the autonomous
> + * activity window register consists of two parts: a 7 bits value indicate
> + * significand and a 3 bits value indicate exponent.
> + */
> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> +{
> +	unsigned int exp;
> +	u64 val, sig;
> +	int ret;
> +
> +	ret = cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, &val);
> +	if (ret)
> +		return ret;
> +
> +	sig = val & CPPC_AUTO_ACT_WINDOW_MAX_SIG;
> +	exp = (val >> CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) & CPPC_AUTO_ACT_WINDOW_MAX_EXP;
> +	*auto_act_window = sig * int_pow(10, exp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);

Since this is exported code, do you perhaps want a check that 
auto_act_window is not NULL to avoid a possible accidental NULL pointer 
dereference?

> +
> +/**
> + * cppc_set_auto_act_window() - Write autonomous activity window register.
> + * @cpu: CPU on which to write register.
> + * @auto_act_window: usec value to write to the autonomous activity window register.
> + *
> + * According to ACPI 6.5, s8.4.6.1.6, the value to write to the autonomous
> + * activity window register consists of two parts: a 7 bits value indicate
> + * significand and a 3 bits value indicate exponent.
> + */
> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +	/* The max value to stroe is 1270000000 */

store

> +	u64 max_val = CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_AUTO_ACT_WINDOW_MAX_EXP);
> +	int exp = 0;
> +	u64 val;
> +
> +	if (auto_act_window > max_val)
> +		return -EINVAL;
> +
> +	/*
> +	 * The max significand is 127, when auto_act_window is larger than
> +	 * 129, discard the precision of the last digit and increase the
> +	 * exponent by 1.
> +	 */
> +	while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
> +		auto_act_window /= 10;
> +		exp += 1;
> +	}
> +
> +	/* For 128 and 129, cut it to 127. */
> +	if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
> +		auto_act_window = CPPC_AUTO_ACT_WINDOW_MAX_SIG;
> +
> +	val = (exp << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_window;
> +
> +	return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
> +
>   /**
>    * cppc_get_auto_sel() - Read autonomous selection register.
>    * @cpu: CPU from which to read register.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 31767c65be20..325e9543e08f 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -32,6 +32,15 @@
>   #define	CMD_READ 0
>   #define	CMD_WRITE 1
>   
> +#define CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE	(7)
> +#define CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE	(3)
> +#define CPPC_AUTO_ACT_WINDOW_MAX_SIG	((1 << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
> +#define CPPC_AUTO_ACT_WINDOW_MAX_EXP	((1 << CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
> +/* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
> +#define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
> +
> +#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +
>   /* Each register has the folowing format. */
>   struct cpc_reg {
>   	u8 descriptor;
> @@ -159,6 +168,9 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> +extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>   extern int cppc_set_auto_sel(int cpu, bool enable);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
> @@ -229,6 +241,18 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_epp(int cpu, u64 epp_val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_sel(int cpu, bool *enable)
>   {
>   	return -EOPNOTSUPP;


