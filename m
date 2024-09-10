Return-Path: <linux-acpi+bounces-8219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A25973D75
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F661C25287
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E6181B87;
	Tue, 10 Sep 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ws8wgDKz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168214F12C;
	Tue, 10 Sep 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986171; cv=fail; b=ptEhTVNHQh1BRmtQ6w7wGe69+QAqE8TdPlOFeuEk9KZMVLv3S7FCiKgERDxEkh8az5Ksu0jxagkq3eNc3NTHTXAorbeHmcFZK36+f73U893SjMT+WdDXooi4uTeTqcvgvHGJojx6EZKJq3j0NMciRjeZ/fSxhImeT+luonDnpGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986171; c=relaxed/simple;
	bh=+9L7FzHCFCjXelxnl79ep3fOVVzZXrxu6h6K6DMN9pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ey0dYSiaouk+Thicnz7AK76tCPeDIg3cR9c89SJbQ/x02wPIrC/YOPFS2xq/jWyCjPOSw2PguaqpHYKTGaoYpyTkXJQXn5QX0BBNFCHAlDTW7CBtTdgk4NRQSgf4LoD+c8pTPfHa8aD3iB8+f+NBdSldcdX8BsMpcKIgE2z2Ans=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ws8wgDKz; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYZn+JSl/cV6iVWo7UGAGIL9nzmNr4ozNpm20Ep/gjA3DmaQD4ilqYVhzINNeT8pp9GLutN670uTjsHSmH+hP3k+P21Xs5Dtw2Nxe5vAOE2Bg1qv7DEiYhcCr5RHjEyHr3SW7le+JcVVrjQVo+D8l98jdm4Of4fPcPBu0AZkqKF2+gtoxcFb0N97TiahmLijAIuip8iiI3DN78PB6Hh3qQIO95CLJM705wFl+a8U4lHQe1+74mLWM3mquAwli9wYE6cAtPCQmKvRXpaNcfofQlNgsn5s2rahJmi5GJqm5XjkAcicf7Lzq437BwaG6JsiUCbGZzD+/258UeejiAr6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX9gN5+6PpRZeTAVFgyvFqxmbPq+b0riI3eIjXHyTsc=;
 b=BZFyMtwCjeT5fFAhnKve0Ma0q552sTYYod0A7oowAadGGxSBRhVQuBaPf3bgVJnVHETC9wKvZvBF9MH1bXach5RfGPAq9SAlza2YiRGXqdb5rA87wVVedkDq72LCHESr4RUrgo71hCx/A2l3jZLLZIskgl2XcqwEqTpb+kg7BkInM4ZdDGu2pCGNM/uWO7i04kV5O3Ar08pv/EhhhUHcUPgFXAKDgl6xNmQE47l0Rn9lwMr6rEFV764d1D6gb9n3e2P7nj/SWdjyW1kdDWuRahvQ74zewSeNkSNwwv4t0KnsdEWXiMk1HzTYgCUHxZwXj35NwVPpVNtP8UOc8V3+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX9gN5+6PpRZeTAVFgyvFqxmbPq+b0riI3eIjXHyTsc=;
 b=Ws8wgDKzeetJCBS8i3i355TGS9X9JqVjYO4ErbplJRcNFfhE/1OBipPmLRdtZ3l7/GzLAnMdY1C/4/5+D3pYhewvVzaMpeyL29ODJTp/UWfVf7UwttpY0A1CSx91M/7ccUkyAUpQPEjQMQUbC5VSqv/QtaeayTP/7hxi80XNRrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 16:36:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 16:36:06 +0000
Message-ID: <f2ae5b0e-9864-45c1-a5a8-d968909ec247@amd.com>
Date: Tue, 10 Sep 2024 11:36:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] cpufreq: amd-pstate: Add documentation for
 `amd_pstate_hw_prefcore`
To: Russell Haley <yumpusamongus@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
 <20240905163007.1350840-11-superm1@kernel.org>
 <53f402cb-1a0d-4b48-b92a-e968ea77a138@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <53f402cb-1a0d-4b48-b92a-e968ea77a138@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:806:d2::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe7266f-823d-49ed-ba1e-08dcd1b6ab05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkdPTlJWc21tYU9xNGs4a3JUZk00eXZuQW9aYnF0NU5wTFdDRmVKTzY3QmF5?=
 =?utf-8?B?dVNzNWdNdWVJY1ZCeEw4QUtIblNPcFVReEs2Rjhxb1MrVG1zbEJPOFpOQkZY?=
 =?utf-8?B?aFZSYU5aL1dZbkJNdXFXVnEyOXdvMDZvdFVXS2wxMzJsMnp1K3JYRUFLdXhr?=
 =?utf-8?B?bE0wQkk5dWNHZnpGK2F4ZlpEc3VKcFpEbnBNZ2VSZzlTdElHVC9uZzFlbjMw?=
 =?utf-8?B?dERSY0tEM2Z3d3IxRENWSE1VY1R2M0p1bnhFTkt0dVRtZlEwUmNiMWlhWHBi?=
 =?utf-8?B?b3JkLzlCOFJsbG42S01rc3Y1RFFFbmpwLzdoZmpKL3ZDMWpzYzMvMGxVUEQ5?=
 =?utf-8?B?TUdTSXdQOTFhV2FWdVJpOHVYWkNNUm1IRGhtdDZIa0htalNVV0lkY0ZiL2M1?=
 =?utf-8?B?NFJyNDF0d2lISTZ2Mk1ja1JKSGpFZXVKNFBKWVlvYm4wKzBOTjQ2d1k1aHc2?=
 =?utf-8?B?NG8yVXJCUjIySUl0V0ZIKzhCQWpiOHd3SCt4THVwckRMZEgxUkh1ckx4QVlL?=
 =?utf-8?B?V0lUaDNiK0JDRjlRUDFiTi92aXlXR1BKVVo1RmhMTXFzVVJ5UDQ5NExDaVQy?=
 =?utf-8?B?TXRZZDY5ZzFoL3VvLyszazZiNGlEUmRLU2ZrMGR6TGFvcXVXdVYxeU5qb3JY?=
 =?utf-8?B?Q2lYcDlESWRGRFpiTEFxaG1TRUJ5M2o3TkVxbHd2bWFDSENZNHZNVllwbmc2?=
 =?utf-8?B?N0JWeWhtOXVtNkZlTGhaSmFmbkE0NE9IOTkxUUxXTlNDeVc5VkFpV0R6ZmxX?=
 =?utf-8?B?NGZjUnliQ3ZjLzJqODNiMlVuSjROck14dnBhMTZqK0JQUU16MElRamFSOVJJ?=
 =?utf-8?B?UUJhTXpKaldqcEdaNjlMQ2xIZHBHcGJkZkxSSWkwakgyVFp2ZFFuQ1ZHenkx?=
 =?utf-8?B?dkROVjNiNmZTbyt6dUtKT3BpUTZNaVRCOEFKY0pqb3pWUzRJUmlsRUZoVWtk?=
 =?utf-8?B?UzliQmoycmJFamdkLzNraVhpT3JiUDhKVFpqVUMvMHpERFpsY3ZDaE5NaWRv?=
 =?utf-8?B?dEJoRE9zalV1OUJKbm96OTVjM3d4d2tacWR1bmRyUzd1MnZleXR1OW5GdEpK?=
 =?utf-8?B?ZUVIaC9wckwyK0YwUzJuUzBGRWYwN0QwVFE1SHQyOFJSazlObWRmMnAvY3c4?=
 =?utf-8?B?cEp0aFV4OXNqRDRPY05lendTTnY1QWFvMHdOdVVHSTRxdzJDY04wczRBdDZ5?=
 =?utf-8?B?aitDV2J3V0VlSlpRRURGV2x5Y0ZGRVZTSStXMlNIYThvN1Q5cEs2Sm9ncDVY?=
 =?utf-8?B?OGsrMTdjN25vTndmTlZNdm5KbnVGY1ZpZzlqbUZMRjdGVTF2bHI2TmVIQjVn?=
 =?utf-8?B?WGNqSWp0SWZKMmpTV3FqSzJORVJkcjU2T3hkdCtsNEdEeGZyTGlaWWxKVmxo?=
 =?utf-8?B?dHIvSVpvUks5RlBNRmZjS2FUcHBudHNwaGlCR2I3QTRYYWFQSFBCSit5Y2Rl?=
 =?utf-8?B?ODN3RnFzVm1IQ2xvdGp2WG9YSm1MaVowV3l0U3lxTTYwVmdhclZHalhYNGQr?=
 =?utf-8?B?OGJ5M01SSTBac1poVi9aMEdoaXV6VGhOSmdpM2FDZTJUVWZYbmJZSjRYVHZw?=
 =?utf-8?B?c040UWFWYnVHYmYvU09RNkQvK1VXVlk0UlRXbjZWMk4zczNvbmpoZXMxKzBw?=
 =?utf-8?B?QTYrSUlFMzNmNmloRFV3RVI2R1RvMGZmU2J0MzlzY1M2Nmx6bGFzYmxwdy9B?=
 =?utf-8?B?UlZJNjA3MGhTazRUc0EwU2JIVzJ2cTlaYWQvRFdUNEJ3bnBFa3kwOTdrd2lu?=
 =?utf-8?B?d3V3ZjVPRktCekh3SU1iWlVUS3VFQldiWmVUUTNjeFk4ejZIZXFCVUIvSE1j?=
 =?utf-8?B?QnY0NmJJZlpxakZDMDZNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1l5c25CYUIxc0hDK1dDTklTcTFkTVRNSms5ZnJYU1BRQWRpdmV2R3kvWStk?=
 =?utf-8?B?dVNVQUg4Mnh5TTFvVXViTktzaHB3ejN1SGhlSXhtT3V1UG5tWlNWUU1HSHZO?=
 =?utf-8?B?Qlo3NENNNUdDNThKUjVRNVNMaW5ldGlkYllOek1RZlZJL25WVUJIb3RUZjNv?=
 =?utf-8?B?V1IzVXlJTDJ5eGRCSExBV00yYWN6SmMxc2lnU2VVYTJYUjRhTzI5ckthWVlY?=
 =?utf-8?B?ZGRvM3c2WkI1VjVVVTNwUVc0eERPejlCc0dFb3BBWWRXQ01DUTRsemtGdVc2?=
 =?utf-8?B?ckNpZjc4cmwxakdtN2JPVHdwTUNNdVd4aW1hY0Z3cXd2R3FNcGFBRVBGKzMw?=
 =?utf-8?B?aHhJM3BvMHFlT3hDcmpraG95Zmg3bkVVWklzbnhqSW0wSHh3VlVLRTlnbmEx?=
 =?utf-8?B?ajJmcng3U2pFa3VXc29hNUtWekJ0OUx4Ym8vU0tHMzZwSlc0UmhQdjZBalBi?=
 =?utf-8?B?Yk9TVzZ0RG5XY01OOHVRcHVoUEhKRjMzRHg3ZDR2S2wwQzkvYi9BTjdyZWtk?=
 =?utf-8?B?QUtEcWhDdUlWelNZdFlpeWNRVmlMMWZneFl1M1Y3NlNaYlFZMzFtNENnY09n?=
 =?utf-8?B?bTYybFBORUI0aTdqOXp0d1d6ck1MRG5vc1dVVnR6bjNSM3BpNWgwRHhNRE5v?=
 =?utf-8?B?Nk93YUErVU5lYVRHYXB5WG4vRmEvTEJwUjBvTnU4VS9xR0RJQ2NoV0F0S2pq?=
 =?utf-8?B?dDVvQi8vbllPVXNPa0lXSTBEMmNqL1k0dkVzdUZUY1JrRWhqMTdTWmVPNTlv?=
 =?utf-8?B?UzljUTA1UnZYdi8wQVN6MEpwZGhyVUNTSWhkVWVpWWp1TWVtNis4a0dZNUxp?=
 =?utf-8?B?enNoVVpxREdGTkQ1RERHeDVlMkhhUUwyUG5UU015bEFhc1Bya3pDTTJwcnEy?=
 =?utf-8?B?K0F4a0tXdFA2cHNkYTE2Yml1ckZvaFRGcXlFSjFkYkVUa2JvaVNNeGhWRDBD?=
 =?utf-8?B?NzFVTlFFbGNlbWNYVmlZOTcxSmNVZy9uMW4zM0xIbHRNV3JTNjgxL1B2ZzQx?=
 =?utf-8?B?NytueXZCYVoxekREVTJZcUdKMitDZ3NPaXNMRjg3bHd3Ym1XQThsQ2Nwb21D?=
 =?utf-8?B?L0pDMVpJSEhQV1E1TkZoallva3NhQjRiRzBrdEZ4TVY3UXlSL1VOS1hBd3Vy?=
 =?utf-8?B?djJFeXkxT1NKVExpMmJBMkJDcDdETmlJdGxJNXdPOVdZdWVtYjdYZW9jUTVv?=
 =?utf-8?B?Ym45ZTZGOU9RMG1udlNqYi9BL1dkV1JCSjgzbzVPTmx3czRubmdhT2Y0WnQ0?=
 =?utf-8?B?RG1hYmgxYmFkeS83ZjVyTlZVdEZvdkpMYkgvYnZtS1J2NnRUVGFaQTZhbCtz?=
 =?utf-8?B?Z2h5bmg0TksrYndmS3REZ29KckhST1ZabWVUQUd2MUx6bHRWUVVzd1J6Mk1r?=
 =?utf-8?B?OUFTQld1bVBlTXY1aGJJcUpMTEtROVk3dUNmUlNZd3pIWVd1V3pZcnBBMWNW?=
 =?utf-8?B?MFZpVGljaGpvUkNNUDlsK1haamwwVzNleW5LamNIVFJQTDIrcXlaS0M5YnlQ?=
 =?utf-8?B?RWtkb29HMUJzR29rckVVajl1L0xoc0FRaGoxTzdjYyt2aEdlSFhpVXJkQW5q?=
 =?utf-8?B?aTNIb21SZXFPN3JSRGxSdjJWeEhOdS9FdDdCR0hvQWRaRkk1YWdaTjRtNlJJ?=
 =?utf-8?B?ekdHT21lcEZuUG13UVZmWXRTUkV2d25Ud25DeW5KSDkrUWc4WTVNZnowa0Mv?=
 =?utf-8?B?dTJScWdQMVBML1ZaUjZJd1VNcjR2c3pPV1hUd1JlRkJFQ3RPQ0g5OVlRK2Ju?=
 =?utf-8?B?bStKZk9zUTdjNFBiblcyRWtybWFDZWJ3Rk0zekYzUnRQNUw3T1VaeGJWcjJ3?=
 =?utf-8?B?a2dGNnk1YXljWlZCemErdElDc2l4aXJuVVA4cG94dkhyZ0x0OW05UUhmTEJK?=
 =?utf-8?B?Qy9oVGpPQTdLVlltSkhvSlU5N3YvN0tSZDlrRjFNVHBSM2hYbHlobnhhQTBy?=
 =?utf-8?B?U3BNZW05RElPNDJ0NDJqQUVrUmZBSVhOeG9WczU5c0FWdkhXamtQTVlZdHhH?=
 =?utf-8?B?WnFJNTI5Z0xnK3B4OFNtWW5NWDQ5YXFZUTBIK2F4eVJRVEk2cllWWmlDZ0Rr?=
 =?utf-8?B?Ym5XRi96WWJDUkJKWEhSOFBMLzRjRkk0WTZuQnVsS2p5REJtZUZSbzdTMnZZ?=
 =?utf-8?Q?EvqusP/MGzadMUoiTSnyVtJ78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe7266f-823d-49ed-ba1e-08dcd1b6ab05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:36:06.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrRlzSuzy/fZHtoialscqp6Ob1rN4HAUMSsHlXUvyMQ7b6mJ49utdbtJZ++Vq8yY/aBM//OuJSQ4Qpsg7iTRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810

On 9/10/2024 05:19, Russell Haley wrote:
> On 9/5/24 11:30 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Explain that the sysfs file represents both preferred core being
>> enabled by the user and supported by the hardware.
>>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>   * Add tag
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index e13915c540648..d5c050ea390dc 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -263,6 +263,11 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>>   <perf_cap_>`_.)
>>   This attribute is read-only.
>>   
>> +``amd_pstate_hw_prefcore``
>> +
>> +Whether the platform supports the preferred core feature and it has been
>> +enabled. This attribute is read-only.
>> +
>>   ``energy_performance_available_preferences``
>>   
>>   A list of all the supported EPP preferences that could be used for
> 
> I notice I am confused. If the attribute is read only, how can it be
> enabled by the user?

It is enabled by default.  It can be disabled by the user via the kernel 
command line:

amd_prefcore=disable

This is documented separately in kernel-parameters.txt.

