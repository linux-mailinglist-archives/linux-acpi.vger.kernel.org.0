Return-Path: <linux-acpi+bounces-20683-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O1bOf8NeWmHuwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20683-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:11:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62199B02
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BE2303B142
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3736681A;
	Tue, 27 Jan 2026 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlrHZ157"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD413659E5;
	Tue, 27 Jan 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541084; cv=fail; b=CMClPFnhIFKJXGu4ArW0rI+D7hlXYzhXx2UuEZLP+TyTGR6DTd+haGcGn/J3HE6UkEd9SwJqoRQd4iO+BFVcUoejPDwmxOXvuk28X1SE3omsL9Rd858JXlrlKSPxW9DeXTWjycdN5lGaNwIpRbAY43yPBN3PyYaSBmmi5GN5adQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541084; c=relaxed/simple;
	bh=BAv10tBc1eK4xWxN/KWFRJ+YZwQvKYCbc+rZFJbqVag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZozaY3C//M/SwkUMZug5UJoeRouR5fXm6C0Ajnvb6lhdFuwF+Uq2k+vIJe5aQ/NCzoWiT32pAm8qpipfJUnwA2KckYSTLZNmIQA2wDm+CgKpkeg37yi1+CyVzDhqQdBPqsEZDt9Dd6a5tLoiiLeKldPeaAvViP3qNePVmzKRMhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlrHZ157; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZH0Wvgmyp96W94APnrdRSo51woDDOsumvCwKJCqIiCwFcsFL7q6g0KETFmmz4wfrZn6g6rndtxCI9JYimo6ulqJomyXAjYZ8/lAK/fKX57xJyXA71PPeHipM8ts8YVpJt77kYhLKGdgkc+h5FGjTYN1gOMT9gdi/jv0ptE/2zwN+yoSbTCrpW4nrkDpTZvwRSmgG1OmhxuHbiAAnlbqGnTk4128SJoKWXZYZm8yWLF5KU4SFVMFJ/h5vrLCBKryRFJzXxhgJNQ2AAcuLjRArcIYdemW1jQKQffb+29CiMT5arxHeAuWmTT/7akGA/rXKYa5AYsOgCaU+fOndt1kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5yt1uCPxU9XHEf04lQeINGdrgBW4s90IhnJ0akCL8g=;
 b=YovnPO6pGRLTWNexfdD+fR+1t9603vN+dgyIY6xdSluwZoqcLTQLsMJWQVo6QHDCnDqc4a3O7krjn+FBoyZSRx9HGFsAmQJUOAgAasHShr/LUj79PAj7Q9RfbDgzUwmMx5t8qVd2FubXyxiDNYFG9ixrIRXyJdjDXDdEz5kOPrDif7T84bXUnwf3CcmIL+riPhGqmrHA8r0iOX1T4kJ+WDpsNGhw/DapA8pisPeb5wCqIRCRyTfWhj0ddevkOQubeBTRYhJ8APpf7T3p4FHxJhl5Ufj3E2dEnZ9n282jUk1Ne4aNPWdB5P6ydJ7mNJCJHlbWTTv0+DGKgJZu4Zniew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5yt1uCPxU9XHEf04lQeINGdrgBW4s90IhnJ0akCL8g=;
 b=VlrHZ157SCfAangxOxfFN/ivABffSuADXNLBO85wOoOKezMAVt1y5DhvR/fmG0wUO5yBFa3B/ncE/QfBQ9gN2ahghSZP7FxHIL1W8UUyWPF7jyI0VyLPSHjAKTim6ToiXxieny5J3zIwwdWRCAwrDhDPTHeFVgXj3lzfHP40LW+93O/BXd+4uxCo20dqlKNvdBO6XrnmfWbNm8WVjufHrz1ro/wUKkwQbpfFJRpcLAdLTTo2QIYKrduHoWL81RSUMN4H41zJX+sl8Lg2fHMLSvDjeB7m39nMmXzOFj0A5BgSnFN2qAhjb24Z1yJQfIUzO1ReE0+bnicDLYfxnztAuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:11:15 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:11:15 +0000
Message-ID: <4bcd55a1-da5f-4161-aadf-594724c76627@nvidia.com>
Date: Wed, 28 Jan 2026 00:41:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] ACPI: CPPC: Clean up cppc_perf_caps and
 cppc_perf_ctrls structs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-3-sumitg@nvidia.com>
 <CAJZ5v0i-fgbpfd-iHcNNtnFU79Whs+Maknx3ou4oNOADzAZmxg@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0i-fgbpfd-iHcNNtnFU79Whs+Maknx3ou4oNOADzAZmxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c30c90-2e01-4f1c-76f0-08de5dd7d760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c21ncnRUUWQ5M0tmZG9HNzdLck1zdzhoM1FQS1gzRG5rVmRIZ0M4aUEwTDVu?=
 =?utf-8?B?bzBDRVliQ3R3RkRNMFVScVpjYzFzVEppb1FXRE9PNVdRMW1ETWRuR1ZMNTJk?=
 =?utf-8?B?djRFUG11c3lBc3I3S3RzMWd2LzNNQlM2Tk5nVmUwM1FzTWxnMHNRUE5iSmZB?=
 =?utf-8?B?Tm5qTEhjVjIyd1o5TzU1Y1ZWNUJZdEF1TFM0TXpnMlBCdFpvSTlzV2ZxQTJa?=
 =?utf-8?B?bW94L25yOHFYQVkyUWxPTUYramRQOFBTUUhCK2x5M2FQdVZLbGhyZ1lzNGIz?=
 =?utf-8?B?TTBRNjlQSm9LZ0Q5VkRQd1BzQkVGNDJlSGcvMGdnY05Ya3B0bGcvZFBmMmV6?=
 =?utf-8?B?bVpYUTNPaGIrc1UrSm1LR0hDaWZnaDU1cWxGR29PZmdRajlFbFFXNjZSL1BL?=
 =?utf-8?B?OVI5cDhvMWQyQUd6cjFENThsajZRaVhUd1Qwc00wT0VENzZycm5IS2o2ejVs?=
 =?utf-8?B?RHYyKzFMcDBENkMxOXh0RGhmRlcxY3RvMmc0Kyt4YmE3NFBmblN2L1YveDZx?=
 =?utf-8?B?KzFKcXJFUmFic3EzZjkyMFVXVUovaHpJaHR6dkEwVFBtRzNNc0ZTWmZyNWlo?=
 =?utf-8?B?aHJNc1I4SE9IejIyN2xoYVNKSUNFVlZjRE5mSlVBc0tWaXRVR3lHak54MHlF?=
 =?utf-8?B?RmVRNzkzbW1KRmVoallGRldDY2xodGJHM1hSMnhhdW5wWXV1UUNYdFNCUS9p?=
 =?utf-8?B?c2RDbmRuTktvbVlWZFZGTWk3VWFQOWhncStwRnVUbDBDS0V6L2UzVUVLVlZw?=
 =?utf-8?B?NGY1R0pJNUJoMXpvek1Zdk5taXRKVXNqRU1xejY0dEM2QWJrbUlxWVM3dDVC?=
 =?utf-8?B?eFlRZkdJREZsN0Y3SEg5aXRzUDZHOFNDdjJqZXFKK3RBS290V3p0MXp3TEZo?=
 =?utf-8?B?YmhHejdsWDhJWUw3TFNlMXNFSVM1SHUxVHVrUGh2KzZOMHhEa1QyRjZTdkFX?=
 =?utf-8?B?dmRudUYxaEFiM2FXbnV4RjlVbU1QS0FlZW1haGlqUnM4ZU5aVzNZQkVaZDdH?=
 =?utf-8?B?RXZrN3BWOElNWHV4L1lQZ3ZFVmVrT1JHWnYwV3B6bGZEcGRHYkcxQXlLWEpW?=
 =?utf-8?B?dFNUYlZ2bGtRT3g4bi9HWEtYKzJjSW5Lc2NVbUhVa1ZVZ1hTRTNMYUx2ODhS?=
 =?utf-8?B?TUN5N2RRR1NOd3Z4ZXJGR1RwT1hjZHRod0U5dStKMjJjeFM0VmdHaHNSQjky?=
 =?utf-8?B?bmFwcXdRb0JJNVRLb0NlNzQzREE3aHBrVWswZHR0NXZsWkFVcUx2bDZ5SU5S?=
 =?utf-8?B?UVdzK2p1VTlSYnJLU2lBbVBZckxaL2hQbWxNcHNuYWpmaHlKaGRRQU14SGo0?=
 =?utf-8?B?NmY5SGlDYXYrc0ZHVXIzQjNqTVJwVHB2bTI0dTUzd2huRXlWaGpJZzhYUGdz?=
 =?utf-8?B?WFZCZU9uVEd5SFJaMU1zL3NWRVRwUXBlQmFRckVZRTdVV1VaSmxLbHl5S3Zl?=
 =?utf-8?B?b05NaEtMbjFUVFFEeFVxUVAxNUN0WGJZYnFzN281TGNZR2h1bWR4dmZzMHhB?=
 =?utf-8?B?ckczaVhoVjlkbUx0dHkwQTNVMjBRS093MGFXYS9YWG5xNXdTTVhzbGFyTE5y?=
 =?utf-8?B?UjFQbkhxKzBLZjl1RXc1VGUvejhYaUl1a2pIWkdRSU9TNFFuSHZlSFFGaGpP?=
 =?utf-8?B?N21CQm5oU0g0YU5pbG9ybFUyYXlJVWtTclV3SThoOHdBNnZveHZvRmpsd0Jq?=
 =?utf-8?B?YXpWQVU0aWxCMVBIdG8yT3dTVXhadDVvTnd6bUlTZHhIRS9aN2IvTzlXdXpY?=
 =?utf-8?B?dmxQekh5dFNyOVBqWUNsS0lJUHlLOUxUZzRHcW9zN0trcXFGUmhidC8zSWhk?=
 =?utf-8?B?SzY4aGoyVkMzbmp4ZUlHeXhIREE0dDhXdlZnKy8vYTZnWnYrSGUrdUVPZC8z?=
 =?utf-8?B?a3p6ZURvU1dGRGpkME5jV2RLa0lsWWxQS0RBVW1tTUJyMjZrTmNqeXIwOVIw?=
 =?utf-8?B?c1VWaDNNb01RVitSaTN1RXhpMlV1NGJ4bW9iZFFTTWxBMzJjQ1V1dUhiQ3Qx?=
 =?utf-8?B?dldTcGlBbWsxSTI5VTZPczhlUlRNNTBZTmtpRVBFS0ZYV3VOVjJwcE1oK3U1?=
 =?utf-8?B?YlM3RjZvZGFDckJNWTBsMjZtUUV1OE1sYWRuY3BsQ0xrZGtjL1diVzRiampD?=
 =?utf-8?Q?S2nQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWRoNkp4T0x5UzdIbVJtbUQvNzBvZ05ocUI2dGloWEJvKzJ2aWNpcDE1Um5s?=
 =?utf-8?B?VzE0WVY0NDZQL0FUakRPR2JPQWpGN1FRazdMbVp0ek1Td1hEUWVUZEtZMDQ3?=
 =?utf-8?B?dXgyVGNOenBlRnAxcmNMQ3JXZmlJU3NJV1p1LzlONUpTMzlqSkdBamkyV092?=
 =?utf-8?B?cG1nQWIxUmJlUXI4VVNibWkyV2ZJeGlYWWZvUGs2OWNmaDNaVWpxMXFSSDFE?=
 =?utf-8?B?bEtVekRRMDhrcHgydlBYYktVS0tUbnd3b0NBeTd4Yys2NXlXWEE0Z1BzbmRr?=
 =?utf-8?B?Sm94L2wvVTZ5KzBHOUlPVGJkMUQyREhsTHo0cDQ0Ry9lVnFYZDg1T0cxUU1W?=
 =?utf-8?B?QXNrZW5ucVFtQ055dGJKN050S3F0YUJVR3laN2hjUWZGcFFNOGxIVSs5amZm?=
 =?utf-8?B?WkZQK2J0QjRzY1hXYjlOdERzNGRXQlZ0TFo3WWl3VjJPY0VzWTNsSnlLZFI3?=
 =?utf-8?B?b293WHVHbXdhVFFyaVB3MWkzZ1p0cnlXTTVONW5XaXJTTjJLZThUVFcvSmEv?=
 =?utf-8?B?WXBUam1vdGJyNFRtUnlEVmk2VXc1c0lqUHdGU09rMUgweVBlMUJYaWFaMy9F?=
 =?utf-8?B?OEgwS0orVzlGNXpyVlo3TmhIMDlKQk1HR0ZRZ00rTGRyeCt1R29lMGthSGc2?=
 =?utf-8?B?cWVlb3h5RFJFbEM5SUNNMVVGSTB2M3V1QzgxN0JHb3pkZUlTdEpGRnlRYVk4?=
 =?utf-8?B?b2RXTTBsTHZ2aDc5Z2xMWlVZN2hEeFBwSThKcEJ5QXlFaXUrSXlKdTFxaith?=
 =?utf-8?B?VThvOWRDYi9xbHdLTXh5blNPbDhXUFZwQmNTc3R6RkFaT1V3U3NqQkZYSVU5?=
 =?utf-8?B?K3V1aVRsa0xyZmRQNjY3cVdHL29raklSNVFCRGswQmlIdUI4cWs4dm9UNU8r?=
 =?utf-8?B?dDNQOEwxYng2UDJCVGdCbDRLczk2ZldjdnRlNGNHSWVoMll4dW1xaHByc3Bo?=
 =?utf-8?B?VlkrWk5ldzR3aVpZZmZnSEM4ZWVGWUtUd2lCYysreFJJOVJiaWxzNGszRHl6?=
 =?utf-8?B?V2Z5bkp6S0pIS2xWbGFSSXpld3pGbTZDWnFqa29CUGNFeCthMlBaTzBlVmZ2?=
 =?utf-8?B?N2UrdDFZOGVaQkJyZDM3UWEvRG1TY3lmNy9rZmpobzRPalk5cUFFYjVFV0ov?=
 =?utf-8?B?Qk54eXZpSndjQWZmbzhiTDN4c1ZraFB0bldqUzF0R3BpSTc3RTh6aDFzcHV2?=
 =?utf-8?B?OWpEUTg4OWgxSjZGVGcwOXIwNnFvYktqdVpFTHZwRTVPdDA2dTVYbzFvSVlM?=
 =?utf-8?B?TWdHY01NVVhFOTB4bE53a2wvWlhrRCtyRGo3OURQVll3QVRlaDVOckF3VnN6?=
 =?utf-8?B?VlloaEk2VW54dEVUNmdvenUycEJzc0twTjNXN1RHWXYra2UyL3hhUjJGWFBW?=
 =?utf-8?B?YlEzbFFXV2R2VXJmU2lLdE14Z3h5S1AwMjM4OEdyNTFWdXoyRU1yQmhxbGlO?=
 =?utf-8?B?RWRjcTVGM2phSlc3aGJzb2dxVDdGY0UvSnpZTHNRT0YwTXpJMmYyTWZjQ0Zu?=
 =?utf-8?B?cWZYcFpSTEJsRTU1cG1nK3FrTG5oSHl2VkN0b2xudGx6ZXlUa2tGczdUb0Jl?=
 =?utf-8?B?M0NDY0Y2Ry95SHNjUXB1N0ErZDZOU2JpalVYRnl4TXU3eWUxNC8zUjlZYnVM?=
 =?utf-8?B?TjIrT0VlanhXV1lZWGc0WkgwSEVOYWZwQ3dEUS9qcmhCUjFva3pMY0lNR3lZ?=
 =?utf-8?B?UjB0MmxNL1F1MXZJTGN4N1VFU0hsaTlhQmNib3RRNWt2TXdDVTcvYnZVTGVE?=
 =?utf-8?B?dkRNdGp5bW0zcjJEVUhGWjJQSXMySkpVaXJuNkpDbDBJRFFzQ2pCckNjd2JF?=
 =?utf-8?B?T1pmeFJTWlAvNEg2Y2YwVVdhOW1zRWxJSzBCN0dkNUhBUVB6Z0NHVUpaSkxZ?=
 =?utf-8?B?K2lmTDZqVzhPYjBORmdzbms5ODczb3JlNC80WStZbXZGbk1JcW1HMTZ1Z0I3?=
 =?utf-8?B?OEVjOHNkNGNwZmw3Qy9LYTRSWUIwakhEWlBWazBHTm9FTW12Q1g4MHVrTkpr?=
 =?utf-8?B?UnZkaitxK2pSZnZLT1Naa2I0ZU1UZHUrYTBxWlhGd3Q5RHNzWG1Td0JCcDk1?=
 =?utf-8?B?YzFVbGdCYU1GUkx5R3NMSGhEUTErR2J6dmljWTJZN05FdHhqU3gzRnNNVS9w?=
 =?utf-8?B?cUN2SWlzZzBZVXRrdk1QSklkTTA1ZldWUE1qOC9XSG9mOHVLQzI0cU5UZ1F4?=
 =?utf-8?B?Mk9kM2FCcnkrcTZzeG1TbmxycHVVNTJPajlRNnlIYVFLWFpSUk5YL2p6RVNo?=
 =?utf-8?B?Z2JBNDNyUWMxUnU2SFV1N2MzdjUyVi9KNXlYZDVRbXJtZVZjV1U3bUNOSkYx?=
 =?utf-8?B?N0lxalQvWTB5MmY4Qms4R1ljYVhOMGExL0dUaGNYSmlwcUtPSW93Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c30c90-2e01-4f1c-76f0-08de5dd7d760
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:11:15.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqz/+AfCTxu9YqK1dvkdu337maxsGZZx8wjznWbZHZz9ajBiZp+NUpNVPidj6CQ6ZCqYjllB6xHofmBMkCxsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20683-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,arm.com:email,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D62199B02
X-Rspamd-Action: no action


On 27/01/26 21:57, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jan 20, 2026 at 3:57 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>>    the same is available in 'struct cppc_perf_ctrls' which is used.
>> - Move the 'auto_sel' field from 'struct cppc_perf_caps' to
>>    'struct cppc_perf_ctrls' as it represents a control register.
>>
>> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   include/acpi/cppc_acpi.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 4bcdcaf8bf2c..6573a759eb8d 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -119,8 +119,6 @@ struct cppc_perf_caps {
>>          u32 lowest_nonlinear_perf;
>>          u32 lowest_freq;
>>          u32 nominal_freq;
>> -       u32 energy_perf;
>> -       bool auto_sel;
>>   };
>>
>>   struct cppc_perf_ctrls {
>> @@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
>>          u32 min_perf;
>>          u32 desired_perf;
>>          u32 energy_perf;
>> +       bool auto_sel;
>>   };
>>
>>   struct cppc_perf_fb_ctrs {
>> --
> It looks like this patch and the next one can be applied independently
> of the other patches in the series.
>
> Do you want me to do that?

Yes, this patch is independent and can be applied.

Also, the 'patch 3'  can be applied independently.
- patch 3: 'ACPI: CPPC: Rename EPP constants for clarity'

Thank you,
Sumit Gupta



