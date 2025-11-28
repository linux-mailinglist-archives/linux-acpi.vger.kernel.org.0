Return-Path: <linux-acpi+bounces-19352-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D1C923A4
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6550534A7F6
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A431D756;
	Fri, 28 Nov 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVbaZJQd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A11A704B;
	Fri, 28 Nov 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338952; cv=fail; b=kcTKNTlxmb0IZpv5OgYj/fqGuLsK2qA81+huKC6J5/RD4z5Y9ZfdhRt9WkYaZtAkB6hxkOte221TovS1icSSDqtLX+552tSdntMFoudTX6vmkTR5cM3/zMPV+WViQuE/esyvEccL/keGEjCpQigU0x0anXzzWQJBc5q0JKIZLrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338952; c=relaxed/simple;
	bh=XuNOtILHTYjvR5B58lcSF092s8JdHbto0CdO2TfpBR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6mwqiMQ0w0/b6W0VtH6Q46Uhi+zk2w0pB3Vi/HEaBSwzhfgD5eWlWZIVkCNy+pyYgrDYnnfA7TDCWXajJ7dwB6fdKvI+wHOulM3tpdrk/gKUJwLs1BOWELzuC6HxKCd2T0p/IgC7AR/x6Sur4BOJ20KAzjDj+D9DyQLZ0BR7dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVbaZJQd; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmKYLe0QXoQNzguqlQfYA/UrYfrlgnFQBu2UhsZ4/MDcPWo6qFel2Y9aR38UGCjVtkWWDibfcY9v+MYA8AWgbpmaTss95L7gj8eHEFckca5Q5kT/wrEM4NU/fT3gkBdWHyGLRT9CNdwkmYqZH8I9C39oh+hj2SNrANBrnYEACx6nAsBqZikRLafRh8wT9aBMrKYkIdK2FPGWB268c6LLEgX62TL+peOCk9dLSxgx9U2gB6OmSk479z0ZVK5b81BY5PRwM1SNkoUsZu0PrXf68XpMqDmPjeVkhBLxzgdk2VOJ8XhwEq/FUPUydVh0ewdfyqJOPGCTSiqzqukfqTJCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjLnFm/Oko5f6+snKEi6SJn0IrsDK7a08vhdR+OsTac=;
 b=PAxP5SsU6WV0DBwkau3A0uTwkQ3ihAtB9A6lbK0x9Cq9sJLppQ41aigPsH5chJhdvN0Fef2nIeByOTcroJwJ+VYiQICwGGtjM85x6/Iz7lmR8phbwdwVkDx/mIlMV4F8XcZhyoIBCespLO2tHRtw08VQushD6cuH/u1ePWXZAsjVB9rnk0hSYR7caPe8+zqyUIsLaxIoJr7vJ+XcfeDYy7/aO874AwMFuc7BKm0tORn7Z/ofgcNboPDHo9zlPjP2rnceiUqIKO07wisTfFBXj1i2guJ2oLdSbWo0KYe2fcTdeIxiRFppYCinz0m67Rp2Usl56m+ItzdnE3w7IVblfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjLnFm/Oko5f6+snKEi6SJn0IrsDK7a08vhdR+OsTac=;
 b=NVbaZJQdjkDDxcW7swqSBHDXV1o8nP1tGUnlymU3cxob7ZiTSvNyWqv2kFndHdFIjV8kI2JxEWTXsVym2nzCF39VTeP8BBXSNmJ2jQqzk1MMh8OgYNKamYCBFbQmFNQPEvp9oGJvzOIFpAuqvKEbYJ5Js+52Z9lU/J6S5sDepZc9/kjCLYFOi4GjSpaLKQsNZj/Gc4K5L8nc9/waBYrwxgchcmkwMUsTV1WiwKC26eq+b3ZtRhyBUAVGbITlhlV3G4EP/bmfqpAoqV6lPYT92wvSMHzh/HObz8fxwWTmEYlLKa4SsNEAcVLkHXKGTUsNIp21jSt+cCMXy1uMH1mMPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 14:09:07 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 14:09:06 +0000
Message-ID: <ff17a1d4-1bdb-4ea1-8c11-b8f49a73d22c@nvidia.com>
Date: Fri, 28 Nov 2025 19:38:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] cpufreq: CPPC: update policy min/max when toggling
 auto_select
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, mario.limonciello@amd.com, ray.huang@amd.com,
 zhenglifeng1@huawei.com, corbet@lwn.net, robert.moore@intel.com,
 lenb@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rdunlap@infradead.org,
 gautham.shenoy@amd.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-8-sumitg@nvidia.com>
 <4e80be28-df9c-4c73-a8fd-a28cf3f8f3ad@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4e80be28-df9c-4c73-a8fd-a28cf3f8f3ad@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0199.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: f4aa17b4-85ad-4391-66a1-08de2e87b156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjlvUTF1YlB1U1JTNkN5eUU5R3ZaVU9nUUJwTWFJa05SbDZKN3J5YjdGaDNT?=
 =?utf-8?B?YW9XNkZ5eWJ0eUhjYUZiYnlEanBXT3krdXh3dUxlVHFoSmRCa3dsTzdyZ1lG?=
 =?utf-8?B?SWlDOWZ3Q055RHRSQzVnaHF2VWt5Y1dxTVd1SjNPTEo2TEpNamxtVllJaVF1?=
 =?utf-8?B?MXBZTEdUQ0xLSzdMd2RYdTBkTDFjSGxjbzdobG8rakplYkRyNXlwOEY0OXdB?=
 =?utf-8?B?MVhxSW9CODBYNXlrQnVUU0MxSjdRUzlaNTdUaU52bHBSYlkvaUJaaGVEVDl2?=
 =?utf-8?B?ZVBuajdFaGcyTkFRTUQvN0p1L0Rla0J2MjdFUVJZbGpYRE43dEVHY0JzZ0R2?=
 =?utf-8?B?RHNQZk56WkpHa0ZpSlJLbXN6Z2NVN3hjVGRsWkNEZ1o3ZUZEaU5SUUxwNUQ4?=
 =?utf-8?B?amR5NCtEK25QQmJEanAyeXd6MEY4MmNybGljQnB5QUpKV0xNWVVqZFF0cnBR?=
 =?utf-8?B?UGNtelIxVS9yNlY0VXZGRk92VUs4T2k1N1NDTGs4K2lyQ1F6bWI1WmNSL2lR?=
 =?utf-8?B?UXZDdWZpSEMwNXAzUkpGbUxybFBkNmJMSExHNHYvS25ucStPNXhqbTZTQkZF?=
 =?utf-8?B?RDdKSkZCTWM3OTFMam5yRFRZQU4xZFYyTVhjcEhvRVlQVEdrcTBOKzZOWHhW?=
 =?utf-8?B?b1ZNY2dzNXFTNi9odHFicGhFZ0FGdDBYT2prb3pKNzZMUGl6TjZwdVNOMmhV?=
 =?utf-8?B?eFhkU29ybGU1ckxjMVlVMk4ycU5ldjY1OWhkS3RzUGtrTFpkcFBNdGE2cC9Y?=
 =?utf-8?B?YlRLcmlJRXZOQm1SbWxlRTc2V05JQ1BzQVBUNXdyYkJ4MFlZekF6bDF0RTlm?=
 =?utf-8?B?L0FMTHB0ZTVTQkRlUDRlRUMxZ2ZoTXNoYkwyay8zOGdCSllZT1hOaEozN3M5?=
 =?utf-8?B?VU9LNUZ2R0hRNDJPeU5HR21hQUNtVHhsU3h0NTd0L2R3b3pDQlJLNjZGNUgy?=
 =?utf-8?B?YWFxNFo4U2NkbkZodStBeThDQVVmRXRDWWNQcjgwc0R3RUdWa3FFTUFjTEhT?=
 =?utf-8?B?MFg2ZURvbnBuZ1plTWhuU3RWbkl2c3ErYmtqV0xoVHFqZ2ZaM3NSeitnOFht?=
 =?utf-8?B?am95Wkc1d2ordkoxaEhoN1VxNEZXTTFPNGtaa1hPME0wRnVsRDNLZlJETU9q?=
 =?utf-8?B?eWx2a1MxTENTYWVvK3d6cmprcXVTOC9FZllQUlB0bnE1Q0FLc3pDa1k0elFQ?=
 =?utf-8?B?SXF1bjl3U1hZSEd6djFRK0liUjFrZ1J3aW0zN1hSemJ2OWUrTUswMExOSzEz?=
 =?utf-8?B?S2dPZTR2TXpuaGxKUUxOV1BrbnB0NVhobTYzVmtHQkVGMmFqc2xWWFJKQ2R1?=
 =?utf-8?B?MktUSGpNWWZtZldFcU5zelZLMXQ2aHFXT1JUUUlZWW5ZZHhYTjczMVpoZ1Ni?=
 =?utf-8?B?bVNOeWlMVy8wV3RBZUN4SnNucWI5SzdENUNKUGNpUGRmUnFnWHRVdUovVHEx?=
 =?utf-8?B?YkRnYWphL28zaDlrdFljQVhvMGE1OElnVTBMWTgyOGtYZ0I3SFFjdlFCQmJB?=
 =?utf-8?B?bFdwYlNHMC8vU1M0UWcySHBDdGxQMWJjaVdlK2hOaHJDMEtLTTI0UlFEdVFr?=
 =?utf-8?B?RklXQlNPRlVSR1NldVc4UjJwTW16M1lHNTJmUzR6RUtHdG9HVnBBVmFrMnU4?=
 =?utf-8?B?MUZLY09kQzIrNnNxQ2hhUzVFVml2a1NIZmsrcjh1RE1LaGxHMktORWlZOVBI?=
 =?utf-8?B?VFdTcWMvbVIvaktoYkpNR0l5WWFmSHFRT3RBOFBZZ2NyMXNmMFZsd0ZJeDNz?=
 =?utf-8?B?WEh1dGFNdnNINTJCK0trR0pHSjFkODE0cW1KWGlpMlNOeUdmT3JMM2lUSWlt?=
 =?utf-8?B?QWVEdUZHelhHZGdaRkIwWkFya0dZR0M2OE03K3UyS1RqRElKQ0paMjU4T2Y0?=
 =?utf-8?B?eEpUc1hLMUgwWmhxYzRGSnVLUUgvcDlycFFGYXBZaFVsNkoyOTJ6M01kWThF?=
 =?utf-8?Q?R0qMNbDLmLKim8qBa+TRd81HPjjX4G3b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVE2bHUyZHFDV3Y2eVUvYWxuajRTMHR1S0F2NHlZS2VLY3p6aytoSk9INmNK?=
 =?utf-8?B?dTVuOEpBUnZuZWFJZmQvVUdTSHNzcStNNENrKzUzM0hpTFhVOXFPUWtUcENt?=
 =?utf-8?B?bTlzTGZEMElUVXlkZjVxbVczU0JlNDhORnZHbTJqbU1LcjBVV29NZDExbHZp?=
 =?utf-8?B?ZUdxa3RIdXYyZjhCV0l0b1gwV2JSOWZjTWJiWmNjWXI2cmtNUksvT2dYT0l0?=
 =?utf-8?B?ZVhwWFdldEZxUEtmOUEzNDluWjJnWHA1SzFsdnJCV3J3cUI5QXUyaVAxVS9E?=
 =?utf-8?B?Misvc2tXVVBrZWFqRlpNanpjRE4vemtSbEh0eWRDWnZKblh0cVZ6YzJvNDlV?=
 =?utf-8?B?YVh5RDNhQ2hYOW9rSlFFMkk2amdGRjIvRm5PaGZiTURuRExlcXRUWGFBT1kr?=
 =?utf-8?B?U0tsT0ZqOVhTTnJ4LzYvMVUycEpTWHI5bnhKcXZ1Z0R5UHY1T3dCRXM3dTBF?=
 =?utf-8?B?QU5jbm82WnZuYUVRNkU5aHFsWWNuQ2NGcDdJOE9EQm1kWkc3eU41YXlvUFZF?=
 =?utf-8?B?U3lXSkdLdUIyQnhjUXZxc1o1WFBlS0FzeXhEamsyVFR2aTc3MkN1VU0vOW5s?=
 =?utf-8?B?aE1la0VRTXpGcmFBdG9SZkF5Uy93YUNwVnozUnVISDUrWklPTlo2T05HWnNH?=
 =?utf-8?B?cWc0UzVnRGlmbThEcVBSZyt6RnZxZlE3YjhXUzA1NVFqSTI0b0pmY29UZkRq?=
 =?utf-8?B?QTU1RGhSd3F3aW44K2JWREtPYmQ1cXdYc0FhWllPbmFrakd2am0vN3JOWW5N?=
 =?utf-8?B?WFlGZFNXZCtyZlpqRjNmV29OZCt5b2hiRklHVmw1dFEwWkdvczFrSVBxcG1z?=
 =?utf-8?B?ZXRENU5sTjBQVEF0OWJUUCtjRUVrQlFjRmVncDZJR1BNUUNPNjJGVjhkcWZZ?=
 =?utf-8?B?YVV6dkJDU2ZZQTY3Yi9SYyt6UDJKOW5NTTNWMzFJOHNOVDM5eHZPc2hIMEJr?=
 =?utf-8?B?dHR2UVg0Mkh6WjhkSlo2bEZJME5LSlJDRVBHK3Bpcnh1ZnJUc1FQQS90RGhU?=
 =?utf-8?B?MTVOWElQeGcvWTlXOTRveno3OEZxNUZlZjNxWHVyb0NlSEJGV3dYdzNzQ08w?=
 =?utf-8?B?YndRSDhKeXJ3NFVaWmlxZUFnaHlJcVVmTWtuanNCVUNJR1lNNE41RGF3OWJU?=
 =?utf-8?B?WGhRWTlQZFdJVFU4VEhBQTdIVUNXVmtCN0RIN3RjaEZnc0dxS1RldFNjTUJC?=
 =?utf-8?B?ZENEa0JSUEZxZXlKdlpWd3JrVkJDQ2hUcU1lT0JGSWZyRTc1R0U4UG1ieEp5?=
 =?utf-8?B?dVZTUmVReTZ5TDZxSlNFdnU4ZVNFdVRiUjZsa2duUFNJTGxLOWFHeHVJN01U?=
 =?utf-8?B?NUQwd1V0cHk5ZVdkSXZ0elpMb1B6b2I3SjJkZlR1Y2FvUm4rZ25JNmVoTXZB?=
 =?utf-8?B?bUIxcU9ySWVjWE5Kdyt6czBmTkhmU2orVjY4VHRyNWoxRVlqMWRGa3Q0Y0pk?=
 =?utf-8?B?N04rM3pqME9NKzNMeng5UkpPUkNuZmZYUFBpTDdZWTZteWh5S2pmY3N0cVc5?=
 =?utf-8?B?dG0vT28zVE1CTVFHRUJncks2bHo4bU1BMnBhTXh3NU9tMGtNZk5TMDZUYUli?=
 =?utf-8?B?bzZnL1I2SXRzbTM5L0JXYUE5Q21LQk5UQktDSm5Hck84LzkwaGo5MzhuQ2Nq?=
 =?utf-8?B?alJRMUpmNXRrYUpYV1VXZnhFbFNlNWZaT081cmlwb0ttQ3JIaEp2WFVPWG4x?=
 =?utf-8?B?M2J0d2xwZHJLMWVGS3FyMk9FK2RjZUQ4OWdkK2ZoZVE4VDc5LzRHOG9ONUp3?=
 =?utf-8?B?Tk51T2I2anNmdGhXeDdjbFdTcFhDK3IyS01vTThIUTlMVTk3NytidXN3cklC?=
 =?utf-8?B?bVZBUVJpRlM4L3BuZjNkZG56Smg0RHNWbnFUWlhwT29MSWdwd3Myc05mT1I4?=
 =?utf-8?B?em84QTNBekRNT2ZLeUQ2VHlIUmZjSGZrbStxKytyYmlBZkEvWVlJYXVpVWpC?=
 =?utf-8?B?WVlOYXpDVk9PbWhNZlcvbnJmV3g5RERyN2szeXVLVDkxNGJrRXlqV0lUYVNq?=
 =?utf-8?B?dUdRa29WZkE5bzU3TEYrKzhFWDUvY0t2N1NQUzlMNGQzQnFCeWhtSDF2elN2?=
 =?utf-8?B?VTdCY25ibzF5eFVWeWZiN0VSMm0yOEtWdVIzSUJkemk5czJabEtCQVZ5dXVm?=
 =?utf-8?Q?Wjz8QeM2rtYEYC14oxGcPjhHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aa17b4-85ad-4391-66a1-08de2e87b156
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 14:09:06.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuK5FuxkIcUQ+eq0JDPwX0zqQjmdU5lNNG81x42uMa0pi8pS+W+BGA7GBhiZLv4ok0OfZru1n+O/AouIJqC+EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084


On 27/11/25 20:23, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 11/5/25 12:38, Sumit Gupta wrote:
>> When CPPC autonomous selection (auto_select) is enabled or disabled,
>> the policy min/max frequency limits should be updated appropriately to
>> reflect the new operating mode.
>>
>> Currently, toggling auto_select only changes the hardware register but
>> doesn't update the cpufreq policy constraints, which can lead to
>> inconsistent behavior between the hardware state and the policy limits
>> visible to userspace and other kernel components.
>>
>> When auto_select is enabled, preserve the current min/max performance
>> values to maintain user-configured limits. When disabled, the hardware
>> operates in a default mode where the OS directly controls performance,
>> so update the policy limits accordingly.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 67 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index a425ad575aa6..d1b44beaddda 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -646,6 +646,26 @@ static int cppc_cpufreq_set_mperf_limit(struct 
>> cpufreq_policy *policy, u64 val,
>>   #define cppc_cpufreq_set_max_perf(policy, val, update_reg, 
>> update_policy) \
>>       cppc_cpufreq_set_mperf_limit(policy, val, update_reg, 
>> update_policy, false)
>>
>> +static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy 
>> *policy, bool auto_sel)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     pr_debug("cpu%d, auto_selcurr:%u,new:%d\n", cpu, 
>> cpu_data->perf_caps.auto_sel, auto_sel);
>> +
>> + guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> Would it be possible to explain why we need this mutex specifically for
> auto_sel ?

Used lock to protect writes to auto_sel related registers (min_perf,
max_perf, epp, auto_sel) of a CPU from concurrent update by multiple
CPUs. Re-looked it and it seems better to take lock at parent function
and make sure all register writes happen together. That will prevent
concurrent sysfs operations from different CPUs from interleaving.


>> +
>> +     ret = cppc_set_auto_sel(cpu, auto_sel);
>> +     if (ret) {
>> +             pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n", 
>> auto_sel, cpu, ret);
>> +             return ret;
>> +     }
>> +     cpu_data->perf_caps.auto_sel = auto_sel;
>> +
>> +     return 0;
>> +}
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>       unsigned int cpu = policy->cpu;
>> @@ -879,8 +899,49 @@ static ssize_t show_auto_select(struct 
>> cpufreq_policy *policy, char *buf)
>>       return sysfs_emit(buf, "%d\n", val);
>>   }
>>
>> -static ssize_t store_auto_select(struct cpufreq_policy *policy,
>> -                              const char *buf, size_t count)
>> +/**
>> + * cppc_cpufreq_update_auto_select - Update autonomous selection 
>> config for policy->cpu
>> + * @policy: cpufreq policy
>> + * @enable: enable/disable autonomous selection
>> + */
>> +static int cppc_cpufreq_update_auto_select(struct cpufreq_policy 
>> *policy, bool enable)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 min_perf = caps->lowest_nonlinear_perf;
>> +     u64 max_perf = caps->nominal_perf;
>> +     int ret;
>> +
>> +     if (enable) {
>> +             if (cpu_data->perf_ctrls.min_perf)
>> +                     min_perf = cpu_data->perf_ctrls.min_perf;
>> +             if (cpu_data->perf_ctrls.max_perf)
>> +                     max_perf = cpu_data->perf_ctrls.max_perf;
>> +     }
>
> I think the min/max performance values are still relevant when 
> auto_sel is
> disabled/absent. So:
> - enabling/disabling autonomous selection
> - setting min/max perf values
> should not have any dependency I think.
>

When enable auto_sel, update both the min/max_perf registers and policy
limits with respective values.
When disable, update only policy limits with the default mode values
and not update the min/max_perf registers. These register values last set
by user are kept and used to update policy limits when auto_sel is enabled
next time.

Thank you,
Sumit Gupta


>
>> +
>> +     /*
>> +      * Set min/max performance registers and update policy 
>> constraints.
>> +      *   When enabling: update both registers and policy.
>> +      *   When disabling: update policy only.
>> +      * Continue even if min/max are not supported, as EPP and autosel
>> +      * might still be supported.
>> +      */
>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_update_autosel_val(policy, enable);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t store_auto_select(struct cpufreq_policy *policy, 
>> const char *buf, size_t count)
>>   {
>>       bool val;
>>       int ret;
>> @@ -889,7 +950,7 @@ static ssize_t store_auto_select(struct 
>> cpufreq_policy *policy,
>>       if (ret)
>>               return ret;
>>
>> -     ret = cppc_set_auto_sel(policy->cpu, val);
>> +     ret = cppc_cpufreq_update_auto_select(policy, val);
>>       if (ret)
>>               return ret;
>>

