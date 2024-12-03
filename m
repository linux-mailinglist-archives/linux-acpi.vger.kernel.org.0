Return-Path: <linux-acpi+bounces-9904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574E9E2F2B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 23:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE92DB3E6C1
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01827209686;
	Tue,  3 Dec 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="htlkjG9X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC5209674;
	Tue,  3 Dec 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263002; cv=fail; b=clIG7jKWh23CE/biDxASbwvGe7q/VZLBl/mT9pkJ96s2UFLNdktAiskptLFrVACqgMv4hUjVTez8cVqnIIYcj2aoi9Pel52vnIjadOhrsVGbmTkN8lpwxiJ7CKAQM0VQYFpYX7gOQ91ns+ll7WSkc8XtcsE9WrZBC/3xPXqJd0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263002; c=relaxed/simple;
	bh=F+Dyx+d5KxLlVcvHAHW+FCN21qWFRYi+AJhYAZT/WnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBbLfQ2m8Nt6egFmfuPf31EQaV7H5J4qQentsK/cz42raVPbCNkHVr811N6GpI1HAnGplODpl6Hu5RKBgolOTS1QFlbXAH0NLFc7bEJRs60andl+r8cfc/rVhsQLen0EEfvakH0RqinmTFTT+cR3Zdx5EVT/Q62uVlqQzcipxRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=htlkjG9X; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct0r5iw6vpyODee8j1tNocgw3z1qfzYOgNzQAVwvRM1VeX77w2TbOrX9w+/Ix0O1i1v5BdjJuZtIUBf0oyc57k2iM8AWMzS5oePdA1sHYhtiVywcOVPY2aor+MTbBUey95bX+RcBooAYz6C/yKjMngu4ei1VZdUCPyZ6dxwrd7gA80vElFrk7eEeyOKCEXENKKhFLz24SP/PN4DTAaNS8OFu/xCzNyRWKP5gs1KhjwaHtOiv8HW9gBjJwWmKk64Z1e+8+wLPOLzQzqBWY7aZyaLkFgOmsH0UCmu2To/Dliic5IR1A5bqe9O4pUyg1FlQ2LNT2BXDogMCDFtZVtW+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6rspozmjC7OQIjspIKfW+4A3FKP471SwM8+Wt9iuWM=;
 b=kDvB0tyqd+z17MkVTgiJzhjf6/+89kVu2yXkIYnwdVvt8AdKmAY/x1N+AG9/GGqcni/GyQO4nIIKyF1GjD/zerJUy4OqWnDJLRJbknZBefjCcdLavoIw81p5juuLAb+kjgwowiIMQ36KWV1LBX2QJQcSXvKvxBbZDIeXe4w7TZciPiZRt05EhdZAxNNhNQjV/o0X+FS+gIEO8dO/LYSoQ1h9Va6w/VFWHDQ3RAiSJ7/kKemNzWXRlZexMLCTlcHec5GLYvBBadBrDvGEwq7JBJgUXat5C9Hy6SXvE/YVvdcta1ZEp3zae6rnt02/Ow2fMBSoDah1kNF2gAGz1rlFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6rspozmjC7OQIjspIKfW+4A3FKP471SwM8+Wt9iuWM=;
 b=htlkjG9XiTd2TTDUCAsuhVx1KroMDVGAEVlk6GCJ8OC4gUvUfw+M6F7/iBFgRaYPwaxpAtZxi0feOfVZkeZZG/+BmE1uuYom6JhBxm20ONBRiud+BR6YDulYgJG/65WFe2D19L2IbLazMqAxFohzxdq47SX/5zbDZUr86ZeE24E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 21:56:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:56:38 +0000
Message-ID: <4062ace2-7881-4621-ba3c-4d09bc58a23a@amd.com>
Date: Tue, 3 Dec 2024 15:56:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/12] x86/process: Clear hardware feedback history for
 AMD processors
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-10-mario.limonciello@amd.com>
 <20241202155951.GH35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241202155951.GH35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:21::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fcf04c-755a-48fc-60ac-08dd13e55c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm1LYld2TlBBdmpLcE1mbWdodFphVzY5cGJXZnViOUczdzJkWUpkUFdCeXN2?=
 =?utf-8?B?TmtmZnZRbzNiTDFoUlNOU0RCdWZKWjVBUkt2QVdLUVdkVXNrLzc2dmFZV3Vu?=
 =?utf-8?B?MFpTS2dFVFA3VEFsQW5tNlNyNEIyK2IyZXBWTmpVbzdxT1Y3dzFEWUpvZ2Z2?=
 =?utf-8?B?QkhXa0lkbzBNaEEwS0lyYkxtTmU1RnFKZW9rVXJLWXpnUnE1NW5NNkt2WGpV?=
 =?utf-8?B?S3k5RUR6MHNBajBsd1lEMktlMy95dk5nUVhjTlVYT3ZPMFJEQllmSmU2Z3ZF?=
 =?utf-8?B?TEQyQnFKQWIwWTcxYlBpcC9SaHNFanVKL2J5dHdvM3lySGxYOVA2TlZJS0JL?=
 =?utf-8?B?NXQ0Z1owMnZJUXdrYmlhNGlwVVpnOEZlT0JOSjdmUHZlb1RTSlNFN09XSTB2?=
 =?utf-8?B?UitTS2JMNk9pY0sweDlUYkF2ZVhIYzEybmRYVWZoVDN0eFptTmJ5Nm83MWxC?=
 =?utf-8?B?WWZDWXR3K2lHZ040eWo1dmZMVTZLVlM2c1dOZ282OFoyU1c1YmpzTHBEb291?=
 =?utf-8?B?RWtRYkZLTXRCaitSclZLK1pnWkNMMzh1bVBEYndLTkhkQ3Zpc3VCM3VTdzlq?=
 =?utf-8?B?Yko3MjVyMmNSNlhibXZaQ1VUWHM5VFVwUDFVTVBFMFN4WE5TWVFpZzFiU00r?=
 =?utf-8?B?eC80MjRtbDVuZzc5c25OajlRYWw1bDEycGNzcnZxSzZ6OE1kVkpEd0poWHd5?=
 =?utf-8?B?dW5xc0k5VTY4NWxJczVQT2E5MGNnRXVuUlpVSkRXSUp0N0kxYjBCbWpjUG1N?=
 =?utf-8?B?dkd2VFN6NWRTY1ZZNnlIU1VnQVRXdHRNcnFVVVB1MFZkWHFNUDZnUTd3dWsy?=
 =?utf-8?B?V0xUY1hlVGttemJoQTFuUU5wL21tMS9CZkp1eWt4L0xmeEZYOWtGZWdZemFX?=
 =?utf-8?B?Rks3aDc0aDkxUWVYTGlOS2JaZkZZRzVJY2dTRU1kL2NCdHc0empiYjlQRHkr?=
 =?utf-8?B?MW5nR29oQ1A2SHRFVnRLc2FMY3VScExCanQxZlhpNFhQa2x4TC9jMWxRSlZK?=
 =?utf-8?B?OTZUYU04Y0lVQnlCOWRGWkRQVWVFMkRQUkxRWk9rR2tkdTZpY2lpbk5BTHow?=
 =?utf-8?B?THhoaHgzbkJyVTlWL0NpekhqdExiNStuTDlXTk4rTDRuS1I2S1ZaZ3pJUnJQ?=
 =?utf-8?B?Y3FMcWpUV1E0M1Z1TmROMThsZkp4NHdic0t3VmZ5Q3V6allRdmIvM3NOZFVM?=
 =?utf-8?B?ODRFMTdSMU1NaUxvTkNYUmlWeFc1eDVCSEFvTXlXanY2Y3JlMzh2ZmN0ek4v?=
 =?utf-8?B?WXpSdHRsV004cTRxZXlJRVpmNkNGZW9tR2lETnlzdnhmdjhFdms0STZpQWU2?=
 =?utf-8?B?SkRBd3F6eWhQNTVMMmVtNEJpaTVyZzZ4VFBmdVlzcXFiMEVVUkx1bC9SOUg4?=
 =?utf-8?B?M0J2bkpaSnR1NWNLbTZCZ1RMT3dWTDNtTjQ2TU5EeGdFUVZtSVF4Tm5HTUdx?=
 =?utf-8?B?TlF4a3VwWlBuUndYRThDb241Y0hjVG1zOTJSb1dONkY4Z3BmL1RqNE1xdVRi?=
 =?utf-8?B?bHNIS3JXN1M2YnNpUFVtZHdiS0pzMDVwcVluZXZzT0R3VEdaZXVuU0NJbXo2?=
 =?utf-8?B?cjhmRW9Da0EraDcvUnFpWjZCV0hWTkF0bnEyRWh1ZWJ3aUZWVy8rVExxZ0U2?=
 =?utf-8?B?WFh0K2Q4NWJYMmhKU3B1L0R6dVZERlljRUExS1JNaUVmWndpazhEczdYR3J3?=
 =?utf-8?B?eGU1cWd6WG9yVDhWWTZENlUzZENrazJRNm4yMzQrdFRYdERQczdGQWdyakdP?=
 =?utf-8?B?K3JPbkFsL2JpaGZ5WjZONWJJcVJHRlhwVDBuck1mMkJ3ZWVFYUxUMHN1VWlk?=
 =?utf-8?B?c2szbzJ3MVJ2cXgzVlZBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2pjaVE4QVg2MytVN25JSDY5bElvSHhxeTJDYjJGaXF1N3BvbDJxZXJjb0xV?=
 =?utf-8?B?Mlh1dDVNb3V2dXJMYldvRitpVEFTV3FRTXFMbkcrdzY3RUkzL3BicCtPTCs2?=
 =?utf-8?B?dUQ3bVdyTWp3S0Q2T1R4T29OVEhhZTBOU1ZnZmRyLys0amI1V29KNHBtVHVo?=
 =?utf-8?B?RTB5anBxTllXSjhXWFhEWituZ1I4enhiQVMzWHZyRU0wTkY1MGJKRTZmWEw0?=
 =?utf-8?B?Mm96bUh1NDVFQk9OcU40QXN5Zkk3b1prZUxxL3N2bndDbWh6emVrWVFHa1BK?=
 =?utf-8?B?eVlmbDRKOUhXcDQycmV5M2JOSldEb3dSeUVkQ3NtS1oveXFUOUoydktPYnlI?=
 =?utf-8?B?VkdQSDRKMkE2ei9LeGtCYnhFbmh0U1VaOHdzTHIxNHl2SnVWY1NhbFVKMXJq?=
 =?utf-8?B?UG9hSWI3R081bkkzRjNlcGNhbEowWEpMZUNmRGp2a0ltelI0N0gzdWtGcjRw?=
 =?utf-8?B?YldOa20wQ00wRkZPL1dQU0pRbXlWQWc3N1JZeGRpMklGbnJEVGNXZWM5Vlhm?=
 =?utf-8?B?OFBjOTI5Y0RQMko1TkpBSDVpdGpiYjlWZHZtV25sTzNJU3NGZzVBcm1Rd0NV?=
 =?utf-8?B?ZXhiVVREbmhHYngyMHI5RXFjQi9jY2pwc1RMT1U2aWV0d2FjOU5KbUNmdVRI?=
 =?utf-8?B?ZDkxL0dNRUtTZ1BqWFM2OVZvMnhiQktoakhCalR6N1kxNVVxVWRlSGluQ0NG?=
 =?utf-8?B?TWVJSlphTXNPRXBlZEdZWW1ZdGQraFV5Z3F4NXAxWUxmUDNCVnhWM3NEbjhZ?=
 =?utf-8?B?RDNJZmlodUxoRGErM3ZpMUNpdzJSQ3hWK1dZbng3RlhzVjNwZzkvdHEzejM1?=
 =?utf-8?B?aDRBc1d3L2hiaU9MTk5pL2dPNFpVN3RmQUZJTy9tK2haaXMwRzlYdFphSDJT?=
 =?utf-8?B?MkhDalBldVdVVkgrVElhd29oelFkZXJHRGpZcHQ4a0V5bXJmOVJURENsU0Zy?=
 =?utf-8?B?YUZaUjkyamVPaXZMbFdXOGpUZ1BueFpGQVhaSGhTcWVsUUZvQ3ZmdnphOWVp?=
 =?utf-8?B?TisrbnlzWVd0QTh4bGhHdEpnSTBZZS81N0xEV09DSS9qTmJKeS9iRjR2S2ZD?=
 =?utf-8?B?eisrODBpV244UGtiSDh4c2hwZG1DMUw5WFZDVmFTZ1p0eG5KdTNyMzkzTjg5?=
 =?utf-8?B?QzBvV1JacDFGMWk5NTA4U293OENBc2ROa1VPb2k1NCtBY3ZTS3IzMEgyRERS?=
 =?utf-8?B?eittcWFaeExORlZBK2o4aWVjRTNTVTk3bHNiZ2NDWG5QazNjTUdHUXEwRHBm?=
 =?utf-8?B?eEFxWU56dkRJZkpaQXBBaWJ1YUJpZG15NW9ZRTQwNnZidTlsaFkrdGcvV09Y?=
 =?utf-8?B?WG1PblM1cm92Y3l6MkRocnJUOENsU3N5QVUzSjM5cXJJMDhIWC9xcDhwckxj?=
 =?utf-8?B?WFNLZ1dwcE1CZzlDV1A3RHNTSDAzUDh3U1VjZmd3WEl5ZzBCUmRqWS9GTHZM?=
 =?utf-8?B?V0tIRDVtT0xOQWVWbVlQRFl1dVYvb3NSb2RwM290MWxRQ0M1Zm96Y3R6ckU3?=
 =?utf-8?B?UzNHbTlEM1I5NkdDTmI0WC9lNDc2UkFibjVlcjdYOGtCbnRrUXBGUXFJSWRx?=
 =?utf-8?B?Z211RGJFbUdtVENYNU5jUDg3eTRGSS9KeGVlYXl3cXNDdDc2cUh3eWo4M0xh?=
 =?utf-8?B?QnUyOFZHMHdBWXBVNU5ZWXJhMnNQRDdsL1NzcUM0VkROa284USsyV0NIK2pt?=
 =?utf-8?B?SnpZRVdpdUJWRmVma0FTTmhnQmVwS1k5bUh3RHA3TzVxYUQxWXI3MXRaYWZy?=
 =?utf-8?B?cnYxam5NemFTaFNKdzFtTlA3SVZGaXFXaDJWK1pUQ0lzM3NTdjh1TEl3RTAz?=
 =?utf-8?B?NnFuQUNVeVkyeWZZZ2srQVdCMXlXQXUrTW5NNjlJWTFhbWUyYkJIY0NSdG03?=
 =?utf-8?B?ZWlaZGVhaWNpSWdJV2tQWGF1N2JDNkVTcWpJY2kzMzdXdzZ0dTNKbkZ2NmN4?=
 =?utf-8?B?aEpnZS9OZXg3V3hSSzIxNEswZ3Z4OVBjNHhIN2Y0ZXRMTmNqUHJiOG1KS21N?=
 =?utf-8?B?MytvanZsaWZoT28rLzdkZWJoQWZZbGg4eFhRYUNMczlyU05zYzNwdTl6ZFRO?=
 =?utf-8?B?ZVowYkpIQyswQjd2SFFnS0NZSlhUOEVRdW5KcEdpbGdhRFN5R0U3UG1RTjlo?=
 =?utf-8?Q?JDt6omDPwguQB5oFdEX5DXvF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fcf04c-755a-48fc-60ac-08dd13e55c8e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:56:37.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tjP4H8zapzFJ9uPqW1HPF3Kamb1KhbwXhdg4JNgmDsXEynF7No+OdtnNOYhMdKqYULYp1NaPTSyR5hxPPt4Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

On 12/2/2024 09:59, Peter Zijlstra wrote:
> On Sat, Nov 30, 2024 at 08:07:00AM -0600, Mario Limonciello wrote:
>> From: Perry Yuan <perry.yuan@amd.com>
>>
>> Incorporate a mechanism within the context switching code to reset
>> the hardware history for AMD processors. Specifically, when a task
>> is switched in, the class ID was read and reset the hardware workload
>> classification history of CPU firmware and then it start to trigger
>> workload classification for the next running thread.
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index 226472332a70d..371e0e8f987fa 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>>   	/* Load the Intel cache allocation PQR MSR. */
>>   	resctrl_sched_in(next_p);
>>   
>> +	/* Reset hw history on AMD CPUs */
>> +	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
>> +
>>   	return prev_p;
>>   }
> 
> BTW, how many cycles for this WRMSR ?

When I measured it the average delay was ~119ns with a wider range of 
delays (standard deviation was 25% greater).

> 
> And, as already stated, I'm failing to find the actual classification
> code, but assuming that's RDMSR(s?), how much for them?
> 

As mentioned on patch 1 comments the current patch series doesn't use 
any classification data produced by the hardware.

