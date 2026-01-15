Return-Path: <linux-acpi+bounces-20391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE5D2539E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BCE3046F8A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC893AE71F;
	Thu, 15 Jan 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T2bjXVOR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093B3AE710;
	Thu, 15 Jan 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490174; cv=fail; b=oSWA2OIPrcyav8mA4VANvhACAQFiLGD9f/Q/uqXU0+bKDQO4B8oRwgUnBWahngmih/5JI9CQDgJ3eyiLiYhpVTKWzzPAIA1hIwLbsbx7ntU2iT0uqfeIydUR3hiWXRpwcZ8EMWBeLRsrnTBJcxSXGugYcvxz8uKaiUDYrqtvfSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490174; c=relaxed/simple;
	bh=H540evpoDyE/1b5oFS3AMCKhs1iDkMqKnR6lv2ACJ04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IpfbzugaJt7Uf7W1qmfCoRndieXteKdCCFcutRIwki+KReSRWPn5RxjW4H5HVOERuKLHHbk7cEM1JyKeDiCcziOSks+1FFUoo1GzE9mOi+PM730ydMu6kpRJ8mcNxnRkLAUIZwzTbX+CxX9+dWXXEAeRiRaO2XRHxNzi294ODv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T2bjXVOR; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNNzSP5552deE7DiqKHOMw7E0OhKKHzbpb3RjNQYqJgGIvuUoSweIYMMfqxE2VtE9e6kpkxLAdkLL4T59BdnPte1dx62FxSTyDELEbS3HRkj/VVqXly0Zis5uViNAaybHOBM5jxeLIN+IRzuriXDGLY1zQMKCNQv7esDrsiziBcRpk+8Ix2Kd8toyEyxFWQm+FDDPgW+vPC0+fKJS2w9Iuyp3Krn3oEOa1f85li0H6lPcZsOrfSsXEc4OKXMIhZ2FmPKD5Aa9qO3zvJJzAb5+163YEgZpUish1+HchOPyIazyGnODqF90YNK7s4cFWjAYFPrMOEPPCDEcXXdZe3omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRvigFdwGMNoL5tyqHu6/Ny/IryE/nXn87VbhU6wv5I=;
 b=lbhEUKhy4tB2Ee8l+1kWQX+bG72GzTMIGShB+wdSB465rYSZB0e8JkKK4bDJKFqzPj7PB0FidM8nTif4ZUFhOAkMRxQOWk8NIa+9uz0OmFhYfrKlcllA4AZm/vs3KYQoBQIV6s7sO6JKD4hpcJ8dNYWQ77V4dG1vHSQUVHhhKRLRxk4weBGTS5LMpin2ELV1ijHul0qJIzw4FH24hG0dOW36b5vVFBIWZkpOJ/tpIh6b/MIhBzkhEOU1khKYyNS9hEMRJWnFfXehn7gs5OG2SERQdP3CK2Zir/TRtSmCqGCdMk2OnJJXbHEKpVWJi5Ty2Qypaq+FBH1FQnD7REqEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRvigFdwGMNoL5tyqHu6/Ny/IryE/nXn87VbhU6wv5I=;
 b=T2bjXVORjUD7jlYdTc84UYV4dSnw/CD7eZmZsjj38FsHcJOxUP0zVyYJ+HrFpVmDBceCO8Ak35Tx/earpR4ued9Df37ZAvTR25smg1emA7PcWy8byezhp1nq2ZmGzLgNsP+aielC2Rp3ZBJrJVfBee/EGIgiDLop/GkUMAP7nsgeO2m8wZVmBQVOM2CKiJ3ea485/tm8ReIXf9ElHdOGh5ll4ruB16DulODoTVseBbx9aWFqttgDM6160RORhB99Ij4gWZXEOj+oVNYx3BuhwJ4eudubenllUnbRVBRdlbLwuyxisiBMgZ7I6j4lMcHMBJMbWLgHbhhTe1ez0X9AkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 15:15:56 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 15:15:56 +0000
Message-ID: <1e63f0e5-1790-42f1-90d5-b0ecd0cfa618@nvidia.com>
Date: Thu, 15 Jan 2026 20:45:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
 <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
 <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0efeae-0a9d-4611-b277-08de5448faaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VXQjJBL0gzR3pyRkFiSlUxdmRtOEhaNkY0QXpuYjZYL3ZIeGw2Q1N0WTNL?=
 =?utf-8?B?OXFHOGFiMVZpMnZDdDdBaXptRm8xQTlPdUprcjFiRVZhMDRscVphZ1oyby9z?=
 =?utf-8?B?czBNV1BLUFJuY2VmaG9Udk53YjhRWGVkWW94WHNpN1Q4aEErU1FLZFRJNWsy?=
 =?utf-8?B?bklCTDV3dXIxQ25zOUQxNWs0VVdnZVU0U25qVVVHUzR6Tk44REJ4bHBMY2lT?=
 =?utf-8?B?TWZuYXZuZWhzRGo4UEc0LzVkMkdnNFpNb2RVd3hvSVJLMkFsRWY3NEF5OGJq?=
 =?utf-8?B?UWw3d0t1cmc1emhnYXk3M0ViTGZLeFc2VENZT25EaWMyUXh2ZDY5MjV0NUhn?=
 =?utf-8?B?eldsaG5qeUFEbUZGS0phK3lkeHR6MnV5dnNoVDNFK25NZURGZGpVK1pSREtu?=
 =?utf-8?B?TTRkTTRmcFNSTDZ1dlJtMzNpTzFMVGk5VG5BM0xBQ1p2QkpxbFg5Y1VhbVk2?=
 =?utf-8?B?aFVNUXFjL3dROVNuNFlUTjdGZndRTWQzL09YSlZWVnVnVGd1WWpsQnF6K3hO?=
 =?utf-8?B?QVhKMkk4aEZEMGdXWUI4M1Rtd3VDeE4rV0pOZHFnbmFJdnJDeFZrRi9zOWpo?=
 =?utf-8?B?d2VueUpPLzNEdE42aFpSYjVUU2N4YWhtK3AxQVZQc2xVam5BUnZNUFZ5cE9L?=
 =?utf-8?B?dmJUVkpvdWdIYjEvZGpobndZWEVHTXZobGVWbWtva0ErckVnK0FMTngrT2xv?=
 =?utf-8?B?ZUdPU0hqUVltZWxESlMzNDlLSDNLY3ZtaFJBaEc4ekd4RW9acEQrYnIybFJh?=
 =?utf-8?B?RjdqcHlNYUlBUmt6Zlc2aUtPbjZwQ1l5NTZtN0hWTXppY3JuR0orSDZxT2dl?=
 =?utf-8?B?RU1GK1EyYTYxZHRYaHZqbkNTWTNoUEJEcEZJckxxWFVhcTE5TTRFdWhFYUdk?=
 =?utf-8?B?TCtsTmZlbWNjUkxwamdPOUQ4N0I1MGcyQmw4bW9NRWZidVNCbXB2Qm5tNUMv?=
 =?utf-8?B?WjhUVmZLQkFGeFRPaThSdGg0V2Z1YzYwM3dTbytmbjhoYzZ3S05INkIvYjV2?=
 =?utf-8?B?ai95L2NZNlUyMDFjTnA2bGxDNGtpdk1tVnQzMHc1NThvSXZzcUZoNGFwU1ZF?=
 =?utf-8?B?SzNLeHpITjZoTnBtTGtQbGlYQlp6SExkbTdGVnJPWmx3ZldKdktISEhua292?=
 =?utf-8?B?RDhjajRDeWN1Rm9EZFJFOXV2OWo5cXVSaU81cjFOTC8yUktMUFBMZU9YdGZJ?=
 =?utf-8?B?MFI1WkVkYUFwaE0vWEtNUW5zeGEwbzBnbk5keHZsUURRYjVpY2E5TEwrZW0v?=
 =?utf-8?B?eHB4OUVXZlBZVUM0cklubi9JOHUrMlF5a3VHRkZIMUs5VFF6VmZpWmMxSm81?=
 =?utf-8?B?ZGdWc20zbG9SbW9JcGUxazQ5MnJlUk96OUtNNEh2SlVwbVdGSlZSYkRKMDdi?=
 =?utf-8?B?UU83ZzlFdEVvd1N2QWg5cVZCeVh4UkNyR09GTFdXWmFxWnkrZCt1OVZ6dE5B?=
 =?utf-8?B?NGlaWXBUYXF3THhJK1dLMytjWWQzR0lNR3U0SEZuWXJYLzFXR2pkUU90azlF?=
 =?utf-8?B?cDdPRDBMUStxYUFKMHVLZHJLMGx6Qm51dW54M0hWay80dlQ5bU95S0J2eStG?=
 =?utf-8?B?SzdpaXhUZW1tWWxZUG15dlNYTEVhNno1U0JuZ3BxNFA4aTJCWUJ6MGRoTitT?=
 =?utf-8?B?UURvcjU0cWcrMXY4ckdmNnZFOGs5VTJxdTR3NnY1bWhyb0VIb0U1U1JnMWVJ?=
 =?utf-8?B?bVp1cHdWUHFLZFl5N2ExYVRROVZYZ3YwYjUyS3lDNTYvdmhCWjhZdnY2OWhs?=
 =?utf-8?B?Yy92aUloN0dWbTZXaVZoSG1DNGkyN0ZnSThyak5DTXZIVSt2a04wQU8rZFRt?=
 =?utf-8?B?alFCTzBGZWl2eGtINWFSbGhVYjVHWDVsUGMzU2todVBwVEJCMnMzcTh2L0tv?=
 =?utf-8?B?bVlhOG1iZjdPVHB6eStndGJsblpzdm9UUnhCc0NGOGdtaWFJUUgvUFBPT056?=
 =?utf-8?B?dkZYQ29aRm9DV1UvYTM4U0VTR3lOQmhjNm4xREJBWC9aeEZWelVXa2N4QzlY?=
 =?utf-8?B?cDRXM2Evems1MXc2Q1RtVUY3OUIzV3lEWFVteGU5L0Z6VVVmM0xEUEJadXhJ?=
 =?utf-8?B?bUFWWWtLeU0vSUJRTVlrajNJYlY1OFRGVnB2ckJjeTJzb0JwdnUvUVFKa25C?=
 =?utf-8?Q?zRyBPyTWcrEPoRIh5IV+PTrmF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5RWXY3N0YxcmplMlVIN3N3QU5Ga1F1Q1Y2K3dpRmxzTnMxR0NtTythall3?=
 =?utf-8?B?STRwVE1KTmlZTzM5RVhPN3U2dEwzaldNTCtDSnZmVHU0bGhSM09aUktQeHVn?=
 =?utf-8?B?ZVlLbU1ISUZkelRTOUhFbzVGUndYRFc5d09oSmxodmwzRW01bC9Xanh0VnMr?=
 =?utf-8?B?bmpiT09QWFdxQThVeG1WUDl1QXBhcnVyR3B3VnBKRFVpdmRKVXJpdkllM3Y5?=
 =?utf-8?B?Yzk5WktnOXpGR2JuZzhJVmlDNzJ2ODc0TTczSmhzUlhHdlR4RGRSQ0w0dStY?=
 =?utf-8?B?RVE3MkZoZ016M3c2ZnpGQmxYdHM3ck1LYTNES1NtVkI4bk0rUXV5SjJReDlX?=
 =?utf-8?B?bW5Pa3hacFVZOEJST0V6WFJqQ0k1cmFWSXdIRStDdThIdlFSdENSeHhLMks0?=
 =?utf-8?B?cXROOTJqdWZnT1I0QmdxOFNUK0ZWeGpxZzdRNVVudGlscjd3T1RwdkZmemJ5?=
 =?utf-8?B?eHZQSEEra0wvRTZ2MWdHYitkM291NHpzUVF2SFQzN1RtRnR1REZiWmJNYjh2?=
 =?utf-8?B?Mm40Kzk1ZzE2bVRIa2JBdkRWQkxPNFpCRmliZzdoeldiZWd6b2xrSm5UQmNW?=
 =?utf-8?B?MXBKYzlsS3g2amsxY0ZJNTVLR0NjZElBOEltNjBYdWJEV2hSQVIrYW9YOHBj?=
 =?utf-8?B?Y2JERFhYM09vY1ZDeUJqRFJyMmxyaVBJd2QyVktwK3M0V29DMlFNL09VR3ZK?=
 =?utf-8?B?Nkp0WERLQkRVYXBySjRwQlhISldPL29IdG01TnMrS2xpZ3dxY2R0V2NVQUlp?=
 =?utf-8?B?N1hoS0w2YURkRGpJV0M3WnhzdmluNUdwdi9qOGZiTnkvZXdaRWFtc0R5OG9X?=
 =?utf-8?B?elVoMEZPa1VlWHF2RGRpKzRYbTN0NFBrRm1jSEdPWTJRaE95bks5YmJaS0Jq?=
 =?utf-8?B?VXBrTWxDak1NcTV5dXVGMEhVL0pDWDBsY0hwWDVIK2dabVJJSVFLV25JWGly?=
 =?utf-8?B?L0ZCMkZmb2ZqMzJMaitDWHRlS0htTER3Vlg0czhtbm5RZlNyNVBkU3ZPOTVk?=
 =?utf-8?B?azRVdklVamtMcmRTdlFxK1RPanhGa3BWckxmRU5XcUx3dnlpOTdxM05RUktQ?=
 =?utf-8?B?eW1KRTVQUWROYkg4SU1yWWVIWlVwOGNLaUQ5Uy8xTE4wV1hSdllVcm9jMFo1?=
 =?utf-8?B?TEJXY215dWw2bHR1MHJ2RmljTklOZFBuSVpVT1VITmhTaXg2ZDY3K0U5MmNV?=
 =?utf-8?B?WXhEUERrOURvTGhoT3lNRnVXOWhPU1VsN1cwaStZUllDMHdxb0NQT3ZlcVhj?=
 =?utf-8?B?dGdBRXE3a3U0UFFudGV0eGVVdDlGMENualJ6ZVVqMS9Fei8wc2dEdm5vZTJG?=
 =?utf-8?B?U2V6SS9JRmkxUk8wRjRyNUlBMzM4Vi9CNTdIa0cycENxeVJNU05jemJPUFZR?=
 =?utf-8?B?R0k3anZIZmRCckFrODhwWVZvVUlSSEVMSFgyazhvS3lCOUh1TWZ0QSs2aWlp?=
 =?utf-8?B?VE1NdjFDZ2dDWUx6a3NQeXJqSjUwU1owNmZOaWk1Yi9kek9obnlLY3RYUHIz?=
 =?utf-8?B?V1I1VnhHbHR6VVdGMEtMR0VvTE1GZlRLN0p5WHRvL3M2QnZ0SzMrZVByY2gy?=
 =?utf-8?B?Q3lmZWE5akdqTCs3dGoyZnZiQml2V0t1alA1RkR1VGozRE5DUk0ya0w3bFVw?=
 =?utf-8?B?Q2plN2xaTStlamJvbGw2TnNMczlRUjQ1QXYrUU43WDRZaStlOG1kaGJJZmt0?=
 =?utf-8?B?dXJKdVRVdDQvbEw1UjFTL0kxWVhEYUJxK1NrQUVOclRwdldqMTZ3cjF5bnZV?=
 =?utf-8?B?T0FCcnk2V2ducmRTSEF1ZzhCR1czWS9rUzc0cmZqSHQ1aFBKSDdEZ2QvcWha?=
 =?utf-8?B?bHZ2dkxrRkpUbDV3em1RaWR3T2p3UjZwWW1ETVp0dEIxS0lXQlJZajgwNkxv?=
 =?utf-8?B?ZzczekJ1REpySThpMFVJMFFVODBSWm94L3lvSC9rMWd4OHQzdktqekFycHRm?=
 =?utf-8?B?WXE2Mk84RzcvZFFtWDRCcER2RU5ac2llNGhQVkdZbVJINXRsbmFqMlZ0M3p3?=
 =?utf-8?B?SUpsTGcxems5QXNtRGFUMkI2NjJ6dElIenlNYVJxODJqTUIzSWNhT1g3OHJB?=
 =?utf-8?B?d2pZRXJtcWROZU9PSGZYamhqSU9ySFRSeGZsZGxRZUJxL0NlNXBrdHdpWkFQ?=
 =?utf-8?B?V242ajNubWRnVHg5M01Ob0ZHR0piSzRRN1FIWmJLZzVyZWxtRzhrc2ViSUIw?=
 =?utf-8?B?NzNJNXhUd1ZyVEJMVmZFRXU0WmxMdGpBczlMS0Z0bU9ocXAwVlRpYVM0Slhk?=
 =?utf-8?B?b0RQSmJWZkxjM1F5UURDQ2pDNlVsRnY2d1VBamJ2b3J2bHNJSHEzUjRhYVNy?=
 =?utf-8?Q?pISCKuZlLr3sqzHdi/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0efeae-0a9d-4611-b277-08de5448faaa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:15:55.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG6uLqhIQToH/bTBaJ9w2ZVMhIy/PvCwcdrfLYsg1ymWkjelh7MUdvM/Wey7USCZMXH253g3NSiwpFzo1c9HBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159


On 12/01/26 17:14, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 1/9/26 15:37, Sumit Gupta wrote:
>>
>> On 08/01/26 22:16, Pierre Gondois wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello Sumit, Lifeng,
>>>
>>> On 12/23/25 13:13, Sumit Gupta wrote:
>>>> When autonomous selection (auto_sel) is enabled, the hardware controls
>>>> performance within min_perf/max_perf register bounds making the
>>>> scaling_min/max_freq effectively read-only.
>>>
>>> If auto_sel is set, the governor associated to the policy will have no
>>> actual control.
>>>
>>> E.g.:
>>> If the schedutil governor is used, attempts to set the
>>> frequency based on CPU utilization will be periodically
>>> sent, but they will have no effect.
>>>
>>> The same thing will happen for the ondemand, performance,
>>> powersave, userspace, etc. governors. They can only work if
>>> frequency requests are taken into account.
>>>
>>> ------------
>>>
>>> This looks like the intel_pstate governor handling where it is possible
>>> not to have .target() or .target_index() callback and the hardware 
>>> is in
>>> charge (IIUC).
>>> For this case, only 2 governor seem available: performance and
>>> powersave.
>>>
>>
> Thanks for pointing me to the first version, I forgot how your
> first implementation was.
>
>
>> In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
>> target*() hooks, using setpolicy() instead (similar to AMD pstate).
>> However, this approach doesn't allow per-CPU control: if we boot with 
>> the
>> EPP driver, we can't dynamically disable auto_sel for individual CPUs 
>> and
>> return to OS governor control (no target hook available). AMD and Intel
>> pstate drivers seem to set HW autonomous mode for all CPUs globally,
>> not per-CPU. So, changed it in v2.
>> [1]
>> https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/
>>
> Ok right.
> This is something I don't really understand in the current intel/amd 
> cpufreq
> drivers. FWIU:
> - the cpufreq drivers abstractions allow to access different hardware
> - the governor abstraction allows to switch between different algorithms
> to select the 'correct' frequency.
>
> So IMO switching to autonomous selection should be done by switching
> to another governor and the 'auto_sel' file should not be accessible to
> users.
>
> ------------
>
> Being able to enable/disable the autonomous selection on a per-policy
> base seems a valid use-case. It also seems to fit the per-policy governor
> capabilities.
> However toggling the auto_sel on different CPUs inside the same policy
> seems inappropriate (this is is not what is done in  this patchset IIUC).
>

I agree about the new governor approach.

We can make the auto_select interface read-only to reflect the current 
state,
and users would use scaling_governor to switch to/from hw_autonomous.
This keeps governor control in one place.
Alternatively, we could have writes to auto_select trigger the governor
switch for backward compatibility - but that might be confusing to have
two ways to switch governors.

As suggested, i will split this patchset into two:
1) v6 with patches 1-7: CPPC register access APIs and sysfs interfaces
    - These are straightforward and provide foundational HW access.
2) Meanwhile work on new patch series for hw_autonomous governor.
Please let me know if any other thoughts.

Thank you,
Sumit Gupta


>
>>
>>> ------------
>>>
>>> In our case, I think it is desired to unload the scaling governor
>>> currently in
>>> use if auto_sel is selected. Letting the rest of the system think it 
>>> has
>>> control
>>> over the freq. selection seems incorrect.
>>> I am not sure what to replace it with:
>>> -
>>> There are no specific performance/powersave modes for CPPC.
>>> There is a range of values between 0-255
>>> -
>>> A firmware auto-selection governor could be created just for this case.
>>> Being able to switch between OS-driven and firmware driven freq.
>>> selection
>>> is not specific to CPPC (for the future).
>>> However I am not really able to say the implications of doing that.
>>>
>>> ------------
>>>
>>> I think it would be better to split your patchset in 2:
>>> 1. adding APIs for the CPPC spec.
>>> 2. using the APIs, especially for auto_sel
>>>
>>> 1. is likely to be straightforward as the APIs will still be used
>>> by the driver at some point.
>>> 2. is likely to bring more discussion.
>>>
>>
>> We discussed adding a hw_auto_sel governor as a second step, though the
>> approach may need refinement during implementation.
>
> I didn't find in the thread adding a new governor was discussed in the
> threads, in case you have a direct link.
>
>>
>> Deferred it (to second step) because adding a new governor requires
>> broader discussion.
>>
>> This issue already exists in current code - store_auto_select() enables
>> auto_sel without any governor awareness. These patches improve the
>> situation by:
>> - Updating scaling_min/max_freq when toggling auto_sel mode
>> - Syncing policy limits with actual HW min/max_perf bounds
>> - Making scaling_min/max_freq read-only in auto_sel mode
>>
>> Would it be acceptable to merge this as a first step, with the governor
>> handling as a follow-up?
>> If not and you prefer splitting, which grouping works better:
>>   A) Patches 1-8 then 9-11.
>>   B) "ACPI: CPPC *" patches then "cpufreq: CPPC *" patches.
>>
> If it's possible I would like to understand what the end result should
> look like. If ultimately enabling auto_sel implies switching governor
> I understand, but I didn't find the thread that discussed about that
> unfortunately.
>
>
>>
>>>
>>>> Enforce this by setting policy limits to min/max_perf bounds in
>>>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs 
>>>> interfaces
>>>> to change performance limits in autonomous mode.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index b1f570d6de34..b3da263c18b0 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -305,7 +305,37 @@ static unsigned int
>>>> cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>>
>>>>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>>>   {
>>>> -     cpufreq_verify_within_cpu_limits(policy);
>>>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>>>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>>>> +     struct cpufreq_policy *cpu_policy;
>>>> +     struct cppc_cpudata *cpu_data;
>>>> +     struct cppc_perf_caps *caps;
>>>> +
>>>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
>>>> +     if (!cpu_policy)
>>>> +             return -ENODEV;
>>>> +
>>>> +     cpu_data = cpu_policy->driver_data;
>>>> +     caps = &cpu_data->perf_caps;
>>>> +
>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>>> +             u32 min_perf, max_perf;
>>>> +
>>>> +             /*
>>>> +              * Set policy limits to HW min/max_perf bounds. In
>>>> autonomous
>>>> +              * mode, scaling_min/max_freq is effectively read-only.
>>>> +              */
>>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>>>> +                        caps->lowest_nonlinear_perf;
>>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?:
>>>> caps->nominal_perf;
>>>> +
>>>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>>>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>>>
>>> policy->min/max values are overwritten, but the governor which is
>>> supposed to use them to select the most fitting frequency will be
>>> ignored by the firmware I think.
>>>
>>
>> Yes.
>>
>>>> +     } else {
>>>> +             cpufreq_verify_within_limits(policy, min_freq, 
>>>> max_freq);
>>>> +     }
>>>> +
>>>> +     cpufreq_cpu_put(cpu_policy);
>>>>       return 0;
>>>>   }
>>>>

