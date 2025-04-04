Return-Path: <linux-acpi+bounces-12756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B4A7BFC6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6764A17C25A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFE1F4169;
	Fri,  4 Apr 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qvFJqhzl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A101F3BBD
	for <linux-acpi@vger.kernel.org>; Fri,  4 Apr 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777872; cv=fail; b=gjS+qMFu4LfZCVrljFRpE7yfsgSZlZMDoY7r0HVx76eLnrYlYqTNOQkGwMDNdCFim2T76u/lI9VQTpWMP4W5AH9EiV6Rm9l8ns/RjfNg3XpkaA/PQhqJlplvPQxuXF5ASTl8Y9y+AdqrGAUl24EHXXpiKNdi1e1wocKwCIKA8B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777872; c=relaxed/simple;
	bh=4EZwVO/PplmB8OVHE/HqtvowSCnjuBqB9ydvDY1a5SM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HecXEBHiPfkqUhDvqKZNhzV4H6rxQj8BStb5BoZdlVq2PiAjTOAuQvAvFioM/XaWZHqMn26eEZwmk6+sDH69qrhSVpxLoPOJK3FJoaGmB3CrqwJ1DZzaHTBM53Ml94WymGN83f1kyBnnMdDochrm9MlGw0CQj/lCt5a5E4ng7+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qvFJqhzl; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi8ZlfAQ0nAMC5+O0PTEnn4DCcGjTXETqyNnFnwQCFnetAXHHeroB2ekOPIDa6qrFkbUAWRGqIrLjiFbP6y4wAZ9NdFZ4lAcpuSBZU89+brfgGK+Lq9pPiHQrpqeZFgFHYSNTWuZkfQeTg/kZdiATjnAE0/YZKLqDsyRdB/DWSN3bUFmA6aHhDnxetFLd+lfTJQq1NlS+10flo9LIuX1rn3RXtITkyIV/Ik8vhwEld5o9x/nnUs6lKmv6DSIU9Q1vmsLyMT5R2Ku9Y8CKE1ZBLZMZj21Do2Wdm8YmbNn/cQcWxSiR31uf8gglZRBpJeMqyztELv0xtWPjq0k85RbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vakhJ//VcHEmxzWYUXlX55SKuL2xSbAg6viUuGts1TI=;
 b=dUGq5ZGMbb+JoIsMD5fLKme6kf4V6VKnPg1aVloHa1ZqxxaLssw8oUUKUMaV1r7wdY4uB/WhN87t2LM71fo0SMblH8KafSKvWGR+Yx8dX8rQOj52uJhcMRWIBZowTscazO7NWCyM322xPEe9N+mIvvlrAh/grkuDiwTX6cBd3OgtE089lv0nMChnjxsPKP5qjDPgRgv2kyb2H7XG8yqlAIgVaAjlM6f3aa7wOSu81MZRybAnvAk95A5TzzHpddwQt5f0ma0WEt0Ims9zR77ZbLbxwefG6Znp0bOXXgpcQIW9xIH0mep63wWMG5HQxgaEuG4EF98828lhxKc54AALjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vakhJ//VcHEmxzWYUXlX55SKuL2xSbAg6viUuGts1TI=;
 b=qvFJqhzldFf04mVL0kETlEsQzEj5b9u3c1UF8MoirE9MYZmcCDnhirj6lnoPMQoQkuDPO52xQiNv9iosLmrHUHOhoZJVrtxxD9+30UyTWdNF6tAgZJEZpsZ3Be/d/KsuHKLU5wlGHXo9k1rgjPrGtKhAVRLE805GZZgGZXU6jKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 14:44:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 14:44:28 +0000
Message-ID: <b29c0f42-accb-4f67-a172-f92735db3522@amd.com>
Date: Fri, 4 Apr 2025 09:44:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: button: Only send `KEY_POWER` when suspended
To: Mario Limonciello <superm1@kernel.org>, rafael@kernel.org
Cc: Ian Laurie <nixuser@mail.com>, Yijun Shen <yijun_shen@dell.com>,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 "Gong, Richard" <Richard.Gong@amd.com>
References: <20250404113636.2390281-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250404113636.2390281-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:806:127::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e43464-1e86-4597-bf13-08dd73873383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTBlenUvTWE3U3lZRUF4MFdaUmJ4ODlMcHZONUhnK09KMGZ5bUd3cXQ0N0JM?=
 =?utf-8?B?ZkRWR1E4WlZ0YncwUU1CQ3EyKzZoaDcyeVRzRE1xdHV2S2NhZzBFZG9zODZX?=
 =?utf-8?B?TjVmZVM3blhKb1JxeVdiZEpRdlF1dEpMVW5CdVIyM2VuWUZBclg3Q2VpdzlD?=
 =?utf-8?B?cG1uWDV5aXZ1Z2R5dGNRUXhvSnVpZnZwLzNsQ1NXOU5uZ3RidUhIeWs2MTVG?=
 =?utf-8?B?cisvYnJkd0JGUUpUU2pzQ0RuMmc3bjhSRFVrWWFEWTVGTy85UUpoTWF1L2pF?=
 =?utf-8?B?U0FQMkRQMHVlSmtoYkk5NjI4bjlDYStDL1czTHdMTWlXalkvT3ZrbHRabWNn?=
 =?utf-8?B?d09qMkJBUU8rMFE4WlQybmNPNER3aW03WmltcXlTZ0ZtR1UrbTh6RERLTVl4?=
 =?utf-8?B?Vm1ZZks0b1Nvb2NGd0NLNTRHWmxVaVpkRE8zWFQ2RGpRZjdCQ2RYdnJTckNz?=
 =?utf-8?B?WnB3OGVXT0VSbjE0SjJwTVdoMkpPR1NRV3loS05DbWVtdC9IbGlzSjBOci82?=
 =?utf-8?B?TW5Mb0hnRHBPMXRFWkRaZURJUWVkOXhZSmlYZ1poQ3NhWWl4MWFONXlDZGFw?=
 =?utf-8?B?NmE1QXF5c1lGUWcxdGRtSk1nYVk2aEZnb1BXdEVWdS9SNmFKanprd2FIb2p6?=
 =?utf-8?B?VUQxcFRxOW9JYUFXak91c2tQbFJsaUI5dU9vVUtQOVRoVDV5dU8wdDdESnIx?=
 =?utf-8?B?SFNZcEp3UXcrdEJFOVdqbnJia1hmMitUeCtEdjlzUmlENU9hZWR3YW9Fa0Qw?=
 =?utf-8?B?R25iUUJuaWdOdWZEZi83NlVvOUJvRENRZzJKaU45bVl3SzB3djhkdFJ0a0Yw?=
 =?utf-8?B?aVgweUtyZEhIMXM5U0Y2Mk1ORUljMExSUm95UGlRQkVsbmFseUlhWGVBU1l0?=
 =?utf-8?B?SzJDTWlocEdubUNKN0htWmJvdkJVYTZ3UklKZnJvbm9Qd1dnQ1grZldoTEll?=
 =?utf-8?B?MTk1MERxaVZhQXREdThBMC8rRk4xbjJyKzFmalp0ai9ZV0RCVEhCT2NCeG52?=
 =?utf-8?B?Skk3a3I0QVVmZWRpbW1ubzVtRVZUb3A2ZW9CM1RaR2hRb05OK1BCV3U2cy9k?=
 =?utf-8?B?SWI1dGY3M1UzdDJNMTF6ZlF4RHg4VGJXaCtYSjFnbTRFNk9BbGVTdTl6WXlh?=
 =?utf-8?B?VVpmVnFBWE1Md05sdmpHVmx0Q016MnFqUUUwVG04T3ZDeDFRbDFucHRuUmlW?=
 =?utf-8?B?T0t3aVBublBaTExCNXh0Mi8yKzlrbmc2MWM5enVMMGZna0hpdzJjcGQreXc1?=
 =?utf-8?B?dTY1bEZYZDcydHljaFhKM05KQVlpUDk1bjlKMDc0TDByVGhBeW83cFlDZmsr?=
 =?utf-8?B?bGFTQzJTN0RMNmhzYWprY3d5WG9BZFpVM3JCV1NaSHdBeFViYVFXUHppZmNi?=
 =?utf-8?B?bElYdEthZTZzaEhGeVVndDBJenJ3eFFMSXZ5cG90QU9mSTNIUXJXZFNuOHJG?=
 =?utf-8?B?dmlMNG5zckJmVnQrSFhqdDRZdEZhSlZWRmtTMmtVVXY3OU56ck52ekkwOG14?=
 =?utf-8?B?eEh5b3JXeUZsYlJEOVFvdG5CM3FKbVN2TGdwZzV6QzEvaVFjK1Z0VDZBb2Vt?=
 =?utf-8?B?VlNhTlhoMjROMi9oNDZxYk5HUTczYW5xR05nZ0ZkOFZVQTlPTkJySlZJSVJQ?=
 =?utf-8?B?SDN4ZmRjZTVNdWxrd3hpbFJvKzMwbTRiY3lhRUdRWnZjMkxOMDI5L3owc1Zt?=
 =?utf-8?B?azRRUGdpeXFaWGY3VUpCRS93SVl0MnhBMEdWdlhOdmZ1VDN2UzlSZ1hWT2sy?=
 =?utf-8?B?bm44UGovNUdVWThPbmFBcUZJZWdXNzNpQ3dlRWpBMzVQQjF4OXZ2N2FQcTVi?=
 =?utf-8?B?SG9samVsRk5kN0ZTSzM0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDU5QnJ6d3oyc0RncXFySHl3SkdQRGJMNnAvVmJwK2FnUlRHS1JiWGpOYmF1?=
 =?utf-8?B?SmFtdnhLMVN6QlpxT1pGWUFVcTFoWGsxTnhwd1hTYm9OTk5vUSthMFptWUl3?=
 =?utf-8?B?WC9ubWpicXNnYTdhaE9yZUpIUTNwY05TTFhzWUxYbnB1cEFldGVDcWdubEMz?=
 =?utf-8?B?ME9zb3p2UnBtVm1EK0IyMWFBT25Qc1BkVTk0Vm4zR3E2ZnRWMnhWbjNMNjgw?=
 =?utf-8?B?YzduVFBRaFBjYnl2QkRqaWVRK2dxMmE1ejdRemE4Ym92YUx3clRXQnA0RlpJ?=
 =?utf-8?B?T3R6bGIxYjV0dlVtOUovOEhWaFVNRHVSTlBEZE0zQ0pSV3NvWFFTYUx1c0lM?=
 =?utf-8?B?SmpwUnNyQ3BoTGVKWlNRTlM0dG9KSEZhSUVHMEVlNGxFazdEV3p2L21oMW9F?=
 =?utf-8?B?ZVdqbXo1dnVuMzkyMVZIekVIRDNqVDFDdWZNNkNGeDliWmJadWF0VTJ2cnp5?=
 =?utf-8?B?WDM4UHhHdTI4WGVVbC9Jb1NYMnQwNDdSOWxHUk5rTW83dWEzeFVDeEhRSk9P?=
 =?utf-8?B?dUNNakhOYlNBTS9FR1l6VzNjSU9rbE9WK3RKODNqSzE1WGpoZ0Y5ak1LTDA5?=
 =?utf-8?B?ZDdtUFhQUEJGWEFJd1NQaFlvQ2lCb2VkOE1BRTFLNUJ4QmsxRGcvMENCZUNi?=
 =?utf-8?B?aDA2a3ZXWjVtTkFNMXZrVDJkQ0N0L0xLVm5SczVTUzRBK0x1OENIRlpPRVBs?=
 =?utf-8?B?TVRzUHJEQm92M3ZJOGJNVUxpc3NDd1F4Sks2WlBKQm9KbHFJNUdjVVhzSkM2?=
 =?utf-8?B?dkgzZDR6NXcyUEUyYXNKRUhjV1FJNTEwYzNLZEFzLzVrV29YV24zeHlWUThv?=
 =?utf-8?B?L1FwWTFmelB4eC9TT1FUTm1mR1VsRW4rUUtLMkFJQTd5bHRFbWI5T1prN2NT?=
 =?utf-8?B?RXZmNlQwOTRNWDNnT0tOTlEwbk84WERPMkpPTkwycWdnVVd6TGNBZjV0VU9K?=
 =?utf-8?B?TmtIeStQRW92RUNMTGtPRTA2TjhNOFJrNjhIV08zNzR5Uk1oakx0NVBFTyty?=
 =?utf-8?B?NzlTQWlmSCtVODRYUXFVT202RTJTRUg0bnIxTkhVMUZqT252TklvTXhkWTJW?=
 =?utf-8?B?Ry9lc01rMGE4SGd0K0xTcmJEelMzQnAxUDlKejZ4NE9BSVJlLytVMEFXMnNI?=
 =?utf-8?B?UGVCaFJ4ejJuci9NaDloZzM4V0RKa0d5VkJzcGNPZUZpVGZvenV3RmdaWXJl?=
 =?utf-8?B?MG96ZGF6WlMwNm55dVd1dVZRTGsvdjRrYWE3SWczeCt5bG1qQXVLTmFaTWRx?=
 =?utf-8?B?YUMra3J3NU5JL0taTUtaQ2JVcHdKazRtNnpTVm0xMm1VMm4wTnd1L1UwSW5Z?=
 =?utf-8?B?TEpaMFFKalVMOWJEbUg3TWNGenBTbEZvNXNITjEveXJGNllHc21jcWQxNWJM?=
 =?utf-8?B?MzJNY2FRRS9BWkRhdDRBRGFKbEFJV3BNLzlKMitIRFdiKzRLT0lDbmQ2U213?=
 =?utf-8?B?MlUrd2VvdXlRZVorcjNJS0RHa0xhWjhqSFpaUktURzlVbWFUcXY3Y2ljVjlW?=
 =?utf-8?B?TzJxVTVwTU5EVUc0aHZOcGV2V0JzN1RtNTNpd2pPSFZJYzhtS2J0Z2pWSFZZ?=
 =?utf-8?B?N2VicVdsNXZxbXhVcXNmdWhXYWdjZE56OXZVMmMySGZVQnBYRUNiMGZrbTZ0?=
 =?utf-8?B?N1J3blNndU1Mc1BNRVJ0bVdEM0thOEhSQnpjeVFLQmhFejQ4Nnp4NGVwNzVj?=
 =?utf-8?B?VjZROXNlYlFaNjZPN3VPU01FVkV6NGg1a3c2dEFweWozVjNLenN5dTBNaUww?=
 =?utf-8?B?S29tS0daMEEyb2hmTWxDNyt4eDNiRmVPNHVQZWcveW5NckNmK0JtUkFlN0NF?=
 =?utf-8?B?eVZES2dFR0xOYnBrcHI0MW9qL3R3WkhZSHNudVk4Q0VFMm5wSVR2UUVjZnMr?=
 =?utf-8?B?eUw4R3VRT0Y4TlRXWmtHUWgrY1NYbG9qT3RJQURCRGluZEwyL1MxWDRWaSsy?=
 =?utf-8?B?U0c2cUlvQ28wUVB5SWNNaisvL1NxOC8ydzFjSUFDTmNvTFNyNVRPS1d1NnBY?=
 =?utf-8?B?MHJ4VU5aSXVlano1NWk2OVBLaGpVQnFhVE9KZVBJcmJETm9OdUJKMXRYQk52?=
 =?utf-8?B?Wi9jZ2NieG1BK0NTM3V0R1AySzMwZm1FUFJnbDR4eTJtNnFjMkFQVld5c01v?=
 =?utf-8?Q?G3ldGYNgFyUdHRCaVQJ/vG5ME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e43464-1e86-4597-bf13-08dd73873383
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:44:27.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp/LDUbQQ4ockjTyLtR7DU1/OOxLeoVUGhOqvtDGVGrbeSSMjxk7yV+GJg9GDptBRNLkxMyNC1wwuifH37cnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

On 4/4/2025 6:36 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit a7e23ec17feec ("ACPI: button: Install notifier for system events
> as well") modified the ACPI button behavior to send
> `ACPI_BUTTON_NOTIFY_WAKE` events.  This caused a regression on a
> "Dell Optiplex 3040" sending `KEY_POWER` randomly at runtime.
> 
> Adjust logic so that `ACPI_BUTTON_NOTIFY_WAKE` can not send `KEY_POWER`
> unless system is suspended.
> 
> Fixes: a7e23ec17feec ("ACPI: button: Install notifier for system events as well")
> Reported-by: Ian Laurie <nixuser@mail.com>
> Closes: https://lore.kernel.org/linux-acpi/CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com/T/#md8071e480212201f23e4929607386750d3b6bc13
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2357044
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Yijun Shen <yijun_shen@dell.com>
> Cc: Richard Gong <richard_gong@amd.com>
> ---
>   drivers/acpi/button.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 90b09840536dd..515224943c3cf 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -444,10 +444,18 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>   	struct input_dev *input;
>   	int keycode;
>   
> +	button = acpi_driver_data(device);
> +
>   	switch (event) {
>   	case ACPI_BUTTON_NOTIFY_STATUS:
> +		acpi_pm_wakeup_event(&device->dev);
> +		if (button->suspended)
> +			return;
>   		break;
>   	case ACPI_BUTTON_NOTIFY_WAKE:
> +		acpi_pm_wakeup_event(&device->dev);
> +		if (!button->suspended)
> +			return;
>   		break;

Thinking through this case, this probably isn't enough; it's going to 
lead to a situation that Yijun sees the system wake up followed by a 
KEY_POWER.

I'll spin a new version for testing.

>   	default:
>   		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> @@ -455,12 +463,6 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>   		return;
>   	}
>   
> -	acpi_pm_wakeup_event(&device->dev);
> -
> -	button = acpi_driver_data(device);
> -	if (button->suspended)
> -		return;
> -
>   	input = button->input;
>   	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
>   


