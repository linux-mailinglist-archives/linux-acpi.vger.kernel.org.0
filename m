Return-Path: <linux-acpi+bounces-8906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05269AB396
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346A01F2295B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E921BC07B;
	Tue, 22 Oct 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yuqYv0aN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86F1B5829;
	Tue, 22 Oct 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613594; cv=fail; b=NSuU0xmkQH15/ZHporcVNuvhEEHw1I61FSGssYsioWQDU3L8gSEergOGfMBopCl5gAcVOiGKfJdiSf7MHqgea8ANMgZ9FTqAkvCtI3yT+6QCEyB1gf8Y7nJtuEM9Sn2TlaYTlpj5++kZo7+iHo4dLK5HFuNycOTpkYrk8LY3tiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613594; c=relaxed/simple;
	bh=IuQMsxJpNYRwqEJ/mfMqC+mok5O832uDlMNuQvhQxho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NbPVfc4UiNz0SaLVwvGTsCxzQXKrrXWgllPAj2xsdwXpEoYCqb6NgM8rxwFJ9l6V7wWsGOFOON1UzPQpsbYy6tfzq6aG3vRwZdS8gLcwLUJpUmYBwPxtnS1sZMjg1by6hT804EhT60gIcX4flkJwoHsjJnsrPPDAaz3pv7Y2QjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yuqYv0aN; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLk4noohswrYcYnLiRY4exo1336UQsvYYUBTGirTreEAEendlpz5/mM/Mb+JYGhf8XzT+ivF0f8GhjkNrighWEBHERRrecwfQ2IVtqybYxZVlIAm5AFIe36ILnSjzBlYp+tr3Wr0KFmHvASgXuXue6Iy5qSAa2HqUeOvmxUM8iDTcgHorQvqCEvdWeSy4vUhFc3OfTqe0qrlKqtpHXVRyvbWK64d5t4B+hkry29uX/nho5HqKLtVYgR1ZUBtpsccQbLkLLpyvXkKM1/M1qJRVaGenq2AbWkprqSxOCItYgLV+U67fIoWp4SOzrsEz7STWDi8KQVsb9XIHDVyqFCgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usLbZj9qfdMOc2uxXnRhWyAGh3c2Tm7lt7e6yrgq5d8=;
 b=nUIWmpvHaJCxaerG/6xsd9z0atVWK8FMfs2pFGcUwOO1dXeEQNuaGJm46+EupaKEVCAwm7oeXv79Hk1egyKanOJre5Fk+lcRucw8clRaXjq/HWkSZLXYUu2t3mWLqJT3SjkAfKUH3o8hYWFqXbaZSggD+ws4FS/D2Lus6x/u18Be3t8yNPNGnWjAfB5Di5arHIJygZMI5tuB36kSIbkcgewoXDZDGMLGZf3AEwCz2iCdPDj/AIsdkM8LqZuKV60D4HJApSu/7zFAkY11m6XaxUZacerCIEhTQqDzbnWvS8b734w2fLxLbrgBxhQPdgpitW6HlfW5r57ZxExcQbTdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usLbZj9qfdMOc2uxXnRhWyAGh3c2Tm7lt7e6yrgq5d8=;
 b=yuqYv0aNTxDc2sNKilqXPKiSKnawvbbpePw+wS3uGAhTe48Yfo2tSum0fP/MqTK/+BeS3TGSHmBmkN8ss4NdkHqWBo6c0ztm6ZbT6vMZnOGiXsLGGWXsFMvpztMQYaI5+rkFe+jLTl9eU8OzwHWVHZnTUhFa9AiJCRPp/VohqVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Tue, 22 Oct
 2024 16:13:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 16:13:03 +0000
Message-ID: <13fd2271-f64e-4573-afdb-9881b8c399fe@amd.com>
Date: Tue, 22 Oct 2024 11:13:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
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
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
 <4476c7a5-bc48-4686-b815-3fae0838b7f9@intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4476c7a5-bc48-4686-b815-3fae0838b7f9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: aeec83de-9017-43be-e7a1-08dcf2b467cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZWcEUyRnZmQjJZbmw5SGNaVHRWU2owZDNiUW4wTEpVc1ZFY25YU2xhZWlV?=
 =?utf-8?B?WTI0Nng3RGRMUU9xTFRYZXJwUm5GQzNPWHdwdlE4TE5OTW91NnhtdW5lc1ZU?=
 =?utf-8?B?Q1IvTkRZcWU1MTZZLys3Vm5rVmwwdms2MVZPdmpnQVExcnArMEpvSnF3N0tQ?=
 =?utf-8?B?bll1VFpZb2JHcDZtUlFZQ2RNR3YzUHNqZG1PMG4wWm1yaXNlTlRxRld1U0Fp?=
 =?utf-8?B?aDRnTithQ2Y3QzY0ZEtXMC9JRVB3VVAvT3A3Q2t6N2cra3B6czBGNW9jUkZq?=
 =?utf-8?B?bFFBM0RGVE5BUVBucWVLSUNRbHAvcEEvM1ZwQjBkZkFhWGJiajRvS1hWc3pQ?=
 =?utf-8?B?QzNkMWJTYnY0WnNkRWpBbDFKMEo4S1Y2djJWS3NiYm1pWEg0OWNTOW9kRVlH?=
 =?utf-8?B?VjF3WmdYUWQyY0MxalFZVnVkK0NDUldCY2xjb2lvUnVtVmk4TFhPN21xUTI3?=
 =?utf-8?B?SDg2WVBVM0V3V1lqVUErNHR2LzVYdlZKQkFVWTRaa2NxdWpPbmpuU0xPbWpq?=
 =?utf-8?B?YStNM3FUNVYwOXZPai9vZHgweVpCUUVOT3dKSzY1cTZwbk9Gcks5NXJudnFY?=
 =?utf-8?B?aXExM1ZLWFhqUmFKWjJUMThwQmlxS0lRVkdTVENiOVB2a09TL1JSRXZUSjlz?=
 =?utf-8?B?eWVyd2FSbGl6QmJuS3c4elB4dWVoeHM0Nzhkc0l3UWtKa1ZUcWZ2SElJUG9o?=
 =?utf-8?B?b1ZpQlF1dzFRNDQ1VzRlVTRnWGZaeWdzdTNKbmkxVDdxR01ueWgwYVdjcDlL?=
 =?utf-8?B?U0lGOXZnOGI2eW1IR1hFMVFEbzBVUnZKYlBTMmJwUXM4K3VOU1JvUmZuU2JH?=
 =?utf-8?B?Q05BZFlkSFJsK1VnNk1FMHhRNnR3K3pCUGVDZXFudnJJbVVSc1pXQTJ0UWlp?=
 =?utf-8?B?WWJtMUtPT0NzUkVGeTNscTVGVEtmNHo4aE51NWFHNUFyOSsvNHNWeU5WMTYx?=
 =?utf-8?B?UitlTitLRmp4NFNLWkkzZVFweGJzSTZrUXQ1VmJ0U3NtOGwyZ1NrSGhaakVz?=
 =?utf-8?B?dGluUWplMVhEOGVQMFhwU0loSlpFM0FqcldYZmZyRWFuQzRUMjkwdFJNNk1X?=
 =?utf-8?B?NEJHNDZ0SnRpdkM3QWhYUHMwUE1Ob0RUa2dhSjR3eE5kZi8zaVh5SmY3UXJo?=
 =?utf-8?B?REc4RkVCZTBTMXRoWE8yWWQvUEJqa0xLQXRWRXcybXFsZmE2K2JtSlE0dC9O?=
 =?utf-8?B?SVZSV05BcXFBNFFMSVRmS1ZFdmFyb2xiaHA2TmRVUWw4dUtLenAwSCtoOGxq?=
 =?utf-8?B?blg5cnNFZ29yRVZuT1VLZWc2UnpDRExWcTNieGI1Ni9GMkNGQmM0cTJjd2FK?=
 =?utf-8?B?bnordXJ1dG5hbGZaMmRHVHZGTDBFUXVLWEkwUmVDYlh0a1VjbC9ObUxiREhG?=
 =?utf-8?B?N21jT0pNd1F3TzF0SG1UTUF6MlJEdEtjWTcwTVBDUWl3c3FZQm8raTlNeW9u?=
 =?utf-8?B?Rlg1aUJKNTEzR1R2aW9VRTZJZnl2M2xrdk1seS9obzE5NnAyWGV2UnFjN3Br?=
 =?utf-8?B?aS83ZWZWaWQzSnZNMm1YSWFsSWFCNHgrbm8wQ3hqdUx4cDU3TEVlMHRTSktu?=
 =?utf-8?B?T1hyY2k2ZHgySGlQVVJOQzhqMVk0NVFsQXFCdi9rUk5lY1JpalpHVWdXVDE0?=
 =?utf-8?B?a2Jsb3h5QkpvZDlqczhHSk5MV1FSbGpCVXY1Z3docDAyWW9NcEIwQmJuZjY1?=
 =?utf-8?B?RE8zUEd5UWlDZTNhL2g2THJpcFo2eTFEMm9zR21Jb2IxbVE3alprejlzTGFY?=
 =?utf-8?Q?+BQOyp0AEv3t/EVrb6FSEikVoDoPYmgs43cBNGt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1lHOExUNnNOQ1RkS3BzUVlxUWhZYzJJdEFCdElxRDVjZ2VZMFlCM3VYMlJI?=
 =?utf-8?B?SVhHUFFPRFpNMTlKRTQzS2dOV2lnbjB2eFUvUWhCK1h5SHdvYzVsdG1UTm5U?=
 =?utf-8?B?QWFjK0dLbm5ydEM3SzlLb0JhNmxyZVdjZGlYT3ZIc1M2VHlzbEplbFJaWWNL?=
 =?utf-8?B?em5FcnNFZGJ3NW5GVDZtS0dMSittVk9CR3NvWVQ0M3hjU2xQcXVNQTNlcmkx?=
 =?utf-8?B?YlI4UmNtZ2FwQUU0UWhEMFNvQVNab0JaT1Z6Q3RJMTRPSUk0NHZjM3dyWDlq?=
 =?utf-8?B?Qkc2aWxsb3M3azBnRTVScW1tN2Jqa3NteExOMHowOUJ3c2JTTVNLemxjbVMw?=
 =?utf-8?B?YS9PSDBaQ2NmZUsyVmUwRDZITFZnRzkwVkxuaWxZY2MrY0sxUGdPRHQ2WFha?=
 =?utf-8?B?STVSQldhTlk2V0ppT3R3MXNVRVJkM0VyNzNabDU4RjR6Z2VyclVRWFp4VGJ6?=
 =?utf-8?B?UXRLNTlaNTBUcmdKMGxXREwwek5MYVRwSWNmU2EvUjI5WkxRM2RxMXhDMGpq?=
 =?utf-8?B?Y3hTaDgyWUFFNlV6RXVIT2EwZkNHZ1BLeW82VWFoQkw5VjJtdXlTUFNjZytL?=
 =?utf-8?B?MUxEZEZUY1ZURWg4eGFMTno4UWNnVjdhMEtBM1lVUnFNc0EzR0daMkQwRHF5?=
 =?utf-8?B?Qng2bFhWai9NVERaeGV0dmV4QTNZRS9IS1dNTWpLWU8zeVdBSHh1MDM2TldC?=
 =?utf-8?B?ZGxlcnNWekN3bW1LSlRLUDhmUlhyUzhIMHFYS3R5SHQya1B0YmJab21saVJQ?=
 =?utf-8?B?VDJqSHk4WkJ1MmpJTlJ2dDNDaFJUTm5yMEtuZGRSL1ZvNG94bC93dG80eWtz?=
 =?utf-8?B?U29HcndZOXIvYzJXUndMM2xIWEFSYkFnNm54QzQ0dlhIMkduWWt1VDJJTXM5?=
 =?utf-8?B?aURRWVFGTXM4TXkrd2hSUWMyRWJqSjhLMnordXlJZENlQlIwQW5yc28xVVBC?=
 =?utf-8?B?dStjM0VMZmp4MDFrL0MxQmloVzdkeEgzd0M0bHd0S2lyZWcwdktuWGgxYTd4?=
 =?utf-8?B?alBISVFWblJDeTlZbk1GNzI5eTYreDhkdUgwQlFrYW1ETXFQL2F4d0l1QmFL?=
 =?utf-8?B?VWRHM3ArRmpyZDVKSXpmNllBQ3NwWEZ1MlB6RHFxZkIrR0dGOVVGTmw4a1hh?=
 =?utf-8?B?M1pXTDl2WmgvN0xaWGFjcnVEQk16bmY3MGNBUkd0OHR5UzYvYXBaUzcySkxn?=
 =?utf-8?B?Tjc2NEV6WVAvRTBKdlJpbEhSZGphL1RUVkJkWWlGeHQyVHR2a2JEN1lsWVdG?=
 =?utf-8?B?WE42WCtlRFNVRVZxRkROTnhLVmJQSzVLcGpBQ01zNmlVL0Q4Q24vQmVUeUJy?=
 =?utf-8?B?VmxOUnpqSmtXbjhPN3VUZ2oxMjBwMnZuL01LaG9yd2VZemZCOFovTWtTWXN5?=
 =?utf-8?B?dC9OQU0xMktsRW9tUXd2M1hibXJHQ1UvTlpNK2hBazVQbkc3SFkreGFEN2N2?=
 =?utf-8?B?MUc0OThlMSszWjg4NW9vVmlLNXo3cmlaaWNmSGxWd0hhWVlyS2M1TGN1b2dO?=
 =?utf-8?B?T3hEeHJOWDVXRHpTazJNZFd6MFlLMUZqczdHc0xhVW1vaDRpSldXdE8xeTY2?=
 =?utf-8?B?YWZSbUQ3VG9wdys3bEVKU3VERWltNHVZeVpzbDNkRVExVmJwcDQrdnpzaHIr?=
 =?utf-8?B?NTRlQW5wTHVFYkFGVmlwMmVLUU1QRlNEdXJCM0FWYm5xS3RLZ1BYNXd4bVkr?=
 =?utf-8?B?YnZQWEtwTnl0ZFE4dkttYXpoTGkvS0ZmQ0I3MDFpMzF4WG14Rno0MGVnVEV0?=
 =?utf-8?B?ZDJHNUh2Q1FQOWg4M09NWTE1ek9RTkJuVTVmTXlSaWtBckZlbFJEN0Z4VlFv?=
 =?utf-8?B?MFB3UElwQ1FIbG9wMndYaVJFTjZ5d2d4Q2VzTVRzMlM2RW9CU1Jrb3R5eU9q?=
 =?utf-8?B?MWIwQzAyNVM3ZWRhdXFHSExVZEJMN0NKNWlubEl1OWE5NS8ySGFIUXcxbTVE?=
 =?utf-8?B?cTBJd1daRmRwdm9VVGhMWXdFK2JXTHBxYVRqUE4xUjVndkN2Q1dYVEVwV2Rq?=
 =?utf-8?B?NHZnWUdBWTNBYk5EZFVHVHF4ZzVvVTc4MHh1RU5JUlVOWUlRWElSR1NIWTZS?=
 =?utf-8?B?UG51TFhMRWUvemhsTDZyTHlMZDdPZDF0dXhzenIwaVp6S0hEWTVtaWp3THRE?=
 =?utf-8?Q?/3sEBiSNuGJbJfYo8DmsAuvLA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeec83de-9017-43be-e7a1-08dcf2b467cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:13:03.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ021QsoS6xaFErNHheyMKa3I103kms8F8YYzSp2l7Kqd9VcDIVtdu2F1xdkPkMOSMM3JB+4mAWTN/q8ArYECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

On 10/22/2024 11:03, Dave Hansen wrote:
> On 10/22/24 04:57, Borislav Petkov wrote:
>> +enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
>> +{
>> +	switch (c->topo.intel_type) {
>> +	case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
>> +	case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
>> +	}
>> +	return TOPO_CPU_TYPE_UNKNOWN;
>> +}
> 
> This makes me feel a _bit_ uneasy.  0x20 here really does mean "Atom
> microarchitecture" and 0x40 means "Core microarchitecture".
> 
> We want to encourage folks to use this new ABI when they want to find
> the fastest core to run on.  But we don't want them to use it to bind to
> a CPU and then deploy Atom-specific optimizations.
> 
> We *also* don't want the in-kernel code to do be doing things like:
> 
> 	if (get_intel_cpu_type() == TOPO_CPU_TYPE_EFFICIENCY)
> 		setup_force_cpu_bug(FOO);
> 
> That would fall over if Intel ever mixed fast and slow core types with
> the same microarchitecture, which is what AMD is doing today.
> 
> Having:
> 
> 	TOPO_CPU_TYPE_EFFICIENCY, and
> 	TOPO_CPU_TYPE_PERFORMANCE
> 
> is totally fine in generic code.  But we also need to preserve the:
> 
> 	TOPO_HW_CPU_TYPE_INTEL_ATOM
> 	TOPO_HW_CPU_TYPE_INTEL_CORE
> 
> values also for use in vendor-specific code.

What you're suggesting is to keep an enum in the intel.c code and any 
code that needs to match atom vs core can directly use

c->topo.intel_type == TOPO_HW_CPU_TYPE_INTEL_ATOM

Right?

> 
> In the ABI, I think we should probably make this an explicit
> power/performance interface rather than "cpu_type".  As much as I like
> the human readable "performance" and "efficiency", I'm worried it won't
> be flexible enough for future maniacal hardware designers.  To be 100%
> clear, all the hardware designs that I know of would fit in a two-bucket
> ("performance" and "efficiency") scheme.  But we've got to decide
> whether to commit to that forever.

As it stands today none of this is exported anywhere but debugfs; so I 
wouldn't say we have ABI concerns (yet).  Could we wait until the one 
that breaks the mold shows up?

