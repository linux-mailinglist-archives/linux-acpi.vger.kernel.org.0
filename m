Return-Path: <linux-acpi+bounces-8890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D669A7225
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 20:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FE1C21230
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821051E884B;
	Mon, 21 Oct 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a8U8T7QZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BD1991AE;
	Mon, 21 Oct 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534662; cv=fail; b=UMFzFMYAFydqX/Z4WPxGVAZcVSOmPK1mAgZ+S9vFFPLJKD0ycJ2nDBkf8XeYX4fUmlwYczE58VFjZC5znoluXKh9TmBS+yiyYdc0RsPpI1oOzslVFYpGo3/PKSOiKgiTGVcXIs/y5SrE5L4BAB4x4486h3g+kPNWT10et6zcAtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534662; c=relaxed/simple;
	bh=xT+06liBec3HhjEXBOi9wsKN1DC49iFTz7bUehg+Uyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ip6qup+BbxgcHMcSVG/Iq2fzZAAp54yDkYjb/Z404QZG8SI0VSMGV4sB4MgaMNwz6my+h66U9RMF8fQibYRaN+nPGcMj3fXBil1n3WhnG55ppyQUdwEK7mdCd6mRxFa0MEyVE0djfXqxDRLh6JcOT5UKsIDZ6jJNJ1ubyN4DGH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a8U8T7QZ; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJKVXdX2QcESjmGmcVaraY5Jwr8Ta/HsJdJzlWaqD6mt0L+yr/QnRLDDKzz2HkxWJ0bDsDyFbs/YsVohKrwAo0vNvd9d99KUhx7QyrPUCHMwXtaZhtK9Cq2QOkz+0TLINIr/XLESFDlNgQTrq6Yh1bE0cMNeUFB6YeZqdY4dwLvN4QDHXPOhIwS/mOmJxIvMYURHOCbflHQ1xjyMvXrqYREF8hJSccX7EGKLu0cbDtu9ECMEP9JvLodEClOyHBM+JdXFoUip75NksUyVl02Uzeywhb5FI/t7HsMIj3KycePzHK/lcvKjeUObbb43E8CvKadz+tI+LMMrxyZDDX8yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrHMGrfQ6zkhK5avat9xJfNcy3WrT3PRb2D6oerqWnc=;
 b=w5dvB/5bq1uYCwNBba5OzbKqsbRxFaMYuQrBurc84q+PtJOn/1PgODNzNx7L7R9sTxBiHGprDKwvYKwNY/eG7LhNj1jnTjtxd08uF99blSaZUAhhY7KAIKuZPDSii498e/4pQkr1IQ6PrsV1WjX5iQUJrQpsedjMYJfq/d85hBBycmAkEZwnT7kL8916T7dm6Qm5YNWXbI0KMZBKc64aaWMCe08q20mXw4BN/28eabgA+zoLnuTSAHxmdewmHEM4xGkg8XMXyTeE2XTw6FdBrLUSKxoHOxtF8ZoLe1Z//qQBeOu2To3AAhbMRm8oS46JN57GDbS7gKSKKc8wVe1w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrHMGrfQ6zkhK5avat9xJfNcy3WrT3PRb2D6oerqWnc=;
 b=a8U8T7QZlTQhB34Nb9KjhxhaDj5PzppK1qm/PJMr4PXzKsKaWCsjKEUq3W8NuvILbv3ur9OVhLpt0Id2WHF7tVdsGBYVho2wIFKTJ3Wd4jVOd+PcjFz1m+IeDepQxYVdTYYWv/62EFHFBVdLWaizqH9E8BDTMuOU021s14EBPiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 18:17:37 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 18:17:37 +0000
Message-ID: <10e0ebf0-f11d-4c69-9821-c8830495c4bd@amd.com>
Date: Mon, 21 Oct 2024 13:17:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/cpufeatures: Rename
 X86_FEATURE_HETERO_CORE_TOPOLOGY to X86_FEATURE_AMD_HETEROGENEOUS_CORES
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20241021175509.2079-1-mario.limonciello@amd.com>
 <20241021175509.2079-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241021175509.2079-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b530c5-10e3-406f-ee4e-08dcf1fca438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekhXYXBVbWpmVjhLWmttSFM0QmN1M0ttUHozZVJBQWM5N3R2TFl6Y3ZnZTBx?=
 =?utf-8?B?b0FHVmVwU1dBMUpYVTlnSFFvbllxRC9HOGFvbDdRYjdjdzN3NSt6MXhXY2F3?=
 =?utf-8?B?NmhKN3hETm9BcFltMmp2RDRUZW1TOVQ3TGMySGduZ0Z1ZnBnQVFpUDQ3R1Z2?=
 =?utf-8?B?SG1Cc2c0OXhRV3kwTGlIVkdHeXAxUjJXVitSbG5qMC9McWNIZFdiTFZFZ25Q?=
 =?utf-8?B?ZEk5UkQ1TkozY0FvQzBEeXc3RWgvMjg2L3IzRWVueDgxb2c1bjBNUVFmZ1dJ?=
 =?utf-8?B?Y2M2TE4rSUlFWW5pdXVaS0V4WXA5aENuUWVWblNLVG9abnRwMlBMcjJkRytv?=
 =?utf-8?B?elJiQW1RZGNSV1MrOE9iTUZsNXE0dVJGL0VqMnRDZHlWWm9VdXI1Y0M0RFNw?=
 =?utf-8?B?ek5SM1ZzMnBYUDREZUlZamNaR3gyRUxYZThVRSs5Y0U2eGtsYXBnK3d2TWo4?=
 =?utf-8?B?eUJGcGdPYVZiSTJab0oxQzRlY1R3M21RK2FnbHBMUHA1NUZzek1Zbnl3akYy?=
 =?utf-8?B?NVZJRlhncmh1RmRVc0xnemFNcHE2dTlqaXJKekRlQStxaWg3TWN3S0diWmFF?=
 =?utf-8?B?Uk9pcVBSOGxqZU1kVVFpZ1hNOUdVMHNacXVMWjc3eFVQeExUejdTR0djd3o5?=
 =?utf-8?B?Qmh2MjhNN0xvOVNWYnk3akViNzAxM05uMVdJdWpVakl0WWhNeldTVlozdGh2?=
 =?utf-8?B?ZGNYdU5xQWFCa0F1Z1lyZThxL2gvWll6dzJ3Q21HR3c2MGVoZm1ZNlA1b01V?=
 =?utf-8?B?cU1yak1GdDJEdW1JNkFJanpxa1NKbCtSU25rQUtKUFNRTW1oVjg5dk1pOHhN?=
 =?utf-8?B?T3kwMzZpamJDbG1GbVY5RGYrZ3BCU2V6R2RFM0RlYlVONjlMdk5RNlBJS2k5?=
 =?utf-8?B?WTNyMVI1RXlZUk0vdmhzeXQyb3hXaWZsVjY0enByMFYvWWoyZWl5QXh5OG9n?=
 =?utf-8?B?MDErSko4MWhYalBUUjJZdlpGS2FuRC9ES0F1SkJnYXpWa3JyL2dOTnhJSmx5?=
 =?utf-8?B?a3hSY1RSR3lsQlVUaW5pd3RZVzJJTHFYR2xZZ0RLM3B6Um93dktBK2hWemkz?=
 =?utf-8?B?MUhWYnZzWWNWOEt5UXBHV0FYM0M0eWVWNkZacExsOTFtOENhVVVDcEhxdS9s?=
 =?utf-8?B?S0pxbVgyUkIyWHk5b3Z5UzJudS9XZXk5dmdzaExyNkhiZm1Sd053VGo2Yjkw?=
 =?utf-8?B?WDlXdHE3UWdSUks3YVV4WVFzTVZLRCtpSTVUOXBMeE9yNm5pZ2pQRmJQZmNB?=
 =?utf-8?B?cTBLYTF1ckk1dzkwRjNBdE9oNk1NYmJtTmJSR3l0Q3BpQ1VKQUtEWG11WDBE?=
 =?utf-8?B?dlRnVU91RXdZZkJEWFpVNzdTbi9Wd3FjMUpXYU1NQkRGZjhjRzRkK2x1NEh2?=
 =?utf-8?B?alBpSVc1SHhhMzVNWEJ6NGF4SEUyWDdia2tHc001K1dIVGtQNTFnRU10NzEx?=
 =?utf-8?B?QmJuT09rVXdieXU0eHdTalBEREUwMXh5RE14SG9WT0VENzdvWnhZOXZhbVhQ?=
 =?utf-8?B?d2RwcmdUM0hOc0ZIMmhoaUg0Sk9hK0N2U050eitDMHNOd3dSZlBWdlRyMTh2?=
 =?utf-8?B?bmYzWHZHc2lrSk1EdFN3aTc4RVNKMHdBQTlRbDJZV3pQQ3pmbzJ4cXJoSmJF?=
 =?utf-8?B?eldyTy9UOTk5dnlVS1g5NUhRellyam1NOHpvNzQ1NXNhZ1p0OUgwOUFRd09Q?=
 =?utf-8?B?dEtZSUZpdllVM3NkS09zc3dGeTdCVW9MOWpYMEovTmlwYk5OQ1Q4emJTWG1l?=
 =?utf-8?Q?3E1d11Ulztz+8iU0X91T0faA8t992lqx9HwB2Bm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE9pdUR4WVJNMGVPZ2gvRFVuaHJlUUJhMnRmWnVtd3owaElhd1dsQ3BaOTgx?=
 =?utf-8?B?L3dsaFhXZkdDQ09ELzFWMGgvb3ZrR0xHS09qM3FVNm1oMkQ4OFp5RHQ1a0Fr?=
 =?utf-8?B?cmlPb0pRa0I3bnNNckpESHdETkFSemRmdG1aZm56aVFuUU9hbzN4S0JNeVJN?=
 =?utf-8?B?VFpWa0Z6UHowaU82T1RWVVNpQ2UwY0xJK25ZQndkdlJJcHRPVmV2Skp5NXJp?=
 =?utf-8?B?dThwY3JNMWZnQUdxamhKc2hES3cvZWZTdmRJcXBpQzlvd3p6STBNMmZPckVw?=
 =?utf-8?B?QXJ0QWtuL1ppWlUvOHRuMG1NY3ZUSldSTW1GYjR4bnNpMmp3cVlydFZCb1Bj?=
 =?utf-8?B?UVhNU2IzdzRYa0dVcDlkUGV0cGVUUTZtYVJkYTY3RVYxN0FOTnpsSlZCY3Qr?=
 =?utf-8?B?aldtVyswUTJJTjJvTWtRaklwOFMzSHFoOWdyeHRPcVBsYmVCZGZsZ09raU1Z?=
 =?utf-8?B?YnUzWFdEMENqeVdyYWVxVGJMRXVocnc4YytJZC9iSmRDUHd4TzN4N1BxdWQy?=
 =?utf-8?B?c0gyWS8xQkE5VHlPZE1aVDhVSnNiYTNScFRZaWZvWnlCZ2FpQzB2YjdkQW5r?=
 =?utf-8?B?T0xiVDNVTWV0aUw3VlM0WTBoL0tLQy9BVjJyeGRSUnBpMkFKNXdtM1ZGeEkz?=
 =?utf-8?B?OVFJMnBabVhaeFJxSWJzMW9uVi9USnNBUjZNSWdUMmtyYk53bk1YektaWmVO?=
 =?utf-8?B?cytxeUpKN1JER3hCT0NxS3d4NjhmU2t3cVZrNk4zK0NYcGxtYVZyOGx4YTRr?=
 =?utf-8?B?YzI5NjZscDVOcElvMXZDWXIyWSswdDRLaFoxWGM0YWN5R1Q1eDhUa1VWcmVK?=
 =?utf-8?B?Qzd2d3RPZnJTbkNVUit6NkNvRGVOV0Z4UW94MzF0YzdSS0RyK25Wd0FzOHhR?=
 =?utf-8?B?RU81bEZGSFQwOWtEZlp5OE1uQXJSVHV1SnFYU285cGZ1ak9JNFZhZjNXSmxt?=
 =?utf-8?B?c1hmcjlybEcwSEhySVJFeCtWRitxcUNLKzNZcDBmTmV0cW1PaCtkckwwUFFl?=
 =?utf-8?B?NGlEOG1WUmhRemRNNmUvQlNTQUhnbEEvaUNHK0FEcnBqdXZ6bk1LQ0ptdEJn?=
 =?utf-8?B?WlIzakNFOG9nKzFBTVpaZXZJUnF0Sm5qUGFqVGlSbDIvVENGL2RXUXBZOHNY?=
 =?utf-8?B?MmVGS3VBM0RqdGNVMmc4bTFKUVdqNVJBT3hoSSs2U2RkNU81WmZZSXBNWlNi?=
 =?utf-8?B?MStvUEY2cHF6Nm5RRUtFMW5MUmpYcFkwMytKUmFJRzV3VjE5MWxobk1RQjAv?=
 =?utf-8?B?TWFFUTc1ODdWNTF2OEtkMG53QXF2RkVPb0Fmb001K3IzMW5kV2VXSldUQVVI?=
 =?utf-8?B?N2lTVHJwRTIrT0tWeFZ2VkowazNHZm51WFVKWXlWMG9KYzE1WFM4MkRtc2l3?=
 =?utf-8?B?bE1uV0hnT1QzaXd4NkluWWg1SUVnNnVmaHlHL1g5QmFhN2UxZ2ppd1ZIU1Ro?=
 =?utf-8?B?enR2RmJQNUhvUTh0Zk8rRjQ2dGwyOTJCTXlBMWt5dnlGVTczUXRVQlhwWW5k?=
 =?utf-8?B?dFEwUkR3eUhucXg3ZUF3Y1hFRUdyWU1FYnY2Yy93NFZDcGJVakp1bU51SUxO?=
 =?utf-8?B?WU9HaFNSQVA0UGs3OUNuOXFrU1E0Q1NaUW9HdW1wMVg5QlFGZzk5eWFYNyt4?=
 =?utf-8?B?clBkWEgxalU2d1BIMDFmdnhZQncrUVFYejJQbFQwZ2hmZTFHSGFoZ2VTS3Y1?=
 =?utf-8?B?M0JyZDlDa3dVeFlXVDhqNXNRbjhLTEM1MEhVRFJKR1ZPMW9saThpNHh2WFVB?=
 =?utf-8?B?UjNMUWJaOElubmVBaGswSUFaRGp0SzRZT1JtVHR2MVlybHQ3THI3N3hxdHha?=
 =?utf-8?B?NkZraGFTVktaV2FlRXB0N2dNUC9GZTR6SjNtdUhod0dhSm02VUcydXljY2JR?=
 =?utf-8?B?NU0yd2JOZGJzQW1adUFyNFg5Zm1rTDR6QlM4YXZSM21NZ1hGRDRSNlRxbnpt?=
 =?utf-8?B?T1Z4OXZLNmVlYktaOHhnQmZDdXFoTUx5K0VOcGk3K0FHSmNnMjZCcDRscHJ6?=
 =?utf-8?B?N2c3NnhneGF0VEI1ZmV4RkNuWnVxeGFId1NoK2ZIc2RZMXB5RFViTGh5U1U0?=
 =?utf-8?B?YXZ3U0lsakw4cEI5Q1p5eGswMmFCV2t1cWJzTW1mb08wMWhiK0dYNkxXa0pq?=
 =?utf-8?Q?zWoM8cq9Ga6r0EdXsgnDHyRk+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b530c5-10e3-406f-ee4e-08dcf1fca438
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:17:37.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygRjJamxT0DU4I6YGMg2VAmQPNJgIUsI1vceu9gZEuBiwRw4JNHeibLXOSGoEpmMtsrm/xBogXIUlqrhIX07eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

On 10/21/2024 12:55, Mario Limonciello wrote:
> X86_FEATURE_AMD_HETEROGENEOUS_CORES makes it clear this is an AMD feature
> and matches the APM value of HeterogeneousCores
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 2 +-
>   arch/x86/kernel/cpu/amd.c          | 2 +-
>   arch/x86/kernel/cpu/scattered.c    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 424bb7ae8914a..7f6c9fc465293 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -473,7 +473,7 @@
>   #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>   #define X86_FEATURE_AMD_FAST_CPPC		(21*32 + 5) /* Fast CPPC */
> -#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
> +#define X86_FEATURE_AMD_HETEROGENEOUS_CORES	(21*32 + 6) /* Heterogeneous Core Topology */
>   
>   /*
>    * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 8ad5f1385f0ec..0f533e6260d29 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1223,7 +1223,7 @@ enum amd_core_type amd_get_core_type(void)
>   		     core_type                  :4;
>   	} props;
>   
> -	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
>   		return CPU_CORE_TYPE_NO_HETERO_SUP;
>   
>   	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index d7f2c19abce33..307a917415343 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -52,7 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>   	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>   	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>   	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> -	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
> +	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
>   	{ 0, 0, 0, 0, 0 }
>   };
>   


I talked to Boris offline about this and I misinterpreted Rafael's 
intent with "the former".  The original patches will need to be dropped 
and I will redo patches 2 and 4 in this series considering that.

