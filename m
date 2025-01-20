Return-Path: <linux-acpi+bounces-10764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E617A1722B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F6C1887D37
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F31E9B00;
	Mon, 20 Jan 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FgsUTQUU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF2182BC;
	Mon, 20 Jan 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395076; cv=fail; b=loVNyT2IYlcGYQ8MU8d4P0V3divv1ZXqSfpc5hHxSXMeo/TRpDSouX97mipldGFxiJgOg0FPSxsavouFP4/znbzpEMBRWQfj9HmvX3UK26j1N5T4bCAMBvOLqACoCSPv2zJzXlbBYYTIjnFRZTtMfqLlp4q5aGSxkOdz6NSSiRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395076; c=relaxed/simple;
	bh=/gJOvJmK6IcwpcDLpsjAfFlmZhzOi7i3FPsPlqXQCJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGYAb52iu5xNda5EtsjnCEz+TsF92e70NxRrBUZ7d7jE2XjfGOSvCVbLzpGwejPsS/elQaqTJuAt06swcU+5tvRhUnspYAetz6v+FQtn0PYZBNqlloXUdivY5gnRqnjXYZRiKNMSFZ7xoV1yyvngjR7Z1vbTSQZwgsYhSwfAAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FgsUTQUU; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH/jcc8OfSwAbgTQIqTH/GxwoGmEu6mcFi59ZTlpsZt+EBQaF0RInj0tYgihX9wvFwcFWADq6PTl7yaxyCN3YeZJVtAJjW+vn49AHQVVosfuHFrOdd+r3oATQHjyT9gRFJ0j2V38kBi16w6ZGf32s0vfqWr69O77huCaM0FgjM81UIT5TmLbSIU7ST1Z6KWVQtduXUNCA2n7bPjLOVclVd+G0ZCfP8CGhcwFmt2V8Rh0K5M9FmZJGQWnto+m/1FJZDGUAIwzvKTp+gUzU6nh8c3Ebji0tcXBVd785ugUEHFNpyBRhRlfqu4oineG3bi2dvzpyNeYj/zEHNxbAwKuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBzCoV+zMbaSZaVCzZvIX97wkulRV5/GTckpcpN+718=;
 b=vu7xLhOldSNaAeO6zgzwXKP2p82icdJlgDalQp70R/j/TNVcbn1R5wkf/ymsqz3uWCSqryVDKvvyGb6t0Adef1Ztx3PVeFbAaRiR2az5m/JjdNpQN0goSmBqHtOdp6Q4EaM+IGpTkBrUbh9+ztbi3uPDEPTMa88Hc2XkJ7YYSEg/dfXfrEey98DZHcJqNsntVWuDj2lgsGVGkSf8eo2nsB591ug1UF9QGGMcMJn1SxYz84Bz3HVdxIKQOqn48T9byvbwNKHG6EgI+yEoEJyFQi58iCGGUurbybm84Th4m5VeVzLaFZCbAuBptPMozAqGKeZlpB5xropX2VkLyQus2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBzCoV+zMbaSZaVCzZvIX97wkulRV5/GTckpcpN+718=;
 b=FgsUTQUUTL0gE6nAXHceHVxDi+mNOzUMK7Cgqwzqbs6cRYFtwqGzroYYLUKiXlijHWy+UOUEOnIdm3W39LgVl2COARlwx0QC38gk62ZcxJgjnFb9Pr0nmwdl1mTaMIu3GfF3gM/xhQ8rEdDypVeqE8O5PzrgxoAUg/aZJ2ooPKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 17:44:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:44:31 +0000
Message-ID: <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
Date: Mon, 20 Jan 2025 11:44:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Pierre Gondois <pierre.gondois@arm.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Russell Haley <yumpusamongus@gmail.com>, rafael@kernel.org, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
 <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
 <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: a96df3cc-3fd7-4387-878f-08dd397a1891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdxUnZncHgzYTZ0blRaTGYzQVhMRkxFRUwrNXB0cCtNOFpmVkFXclhLVmQ0?=
 =?utf-8?B?Z0RRZHZJd25VVEJtK1pBOW5iZ1lvZmpsNnh5S1E5a2tNV2NUcVRhSDZ5dCsx?=
 =?utf-8?B?SHRCeCtHQldtRDc3NGxmQWdRT3NXUmhUcHBPMzVGVzhTV1pDVGJkcjZXUXZV?=
 =?utf-8?B?c1cxTWRucm5QcFBScGNoNVI1UTlGQWo0Y3Zmd1NLY2o5VTRsZzRMbjJoTXBt?=
 =?utf-8?B?bXQzT1ZoWlBtUU9ya0tpVlhCWFQvTFhGL0xicmJUYk1JWVNqSTJTUEFyTThZ?=
 =?utf-8?B?YnQyQ21ZWDdLZHBjYjA1WWFoT1BKWCsvZjJOSUtwUkY5V2M1Y3Jqc0NWQ001?=
 =?utf-8?B?dHJKdnVyZkFaYWFoRjhtRFJDbE5OWXFDQTRYNTBwWmExTFY1MEh6TnVwNGxw?=
 =?utf-8?B?RHZ5VkN5UVFMS05pM0xqQStPTTcvbVRhWFZWY3lsb2I1TWhodEVRaWVOMUlK?=
 =?utf-8?B?anpxTTlsTVJ1VjB4NGo1T1htc3hlSWluamR6OG5SUE5JRmcvT1pva2FJcmpC?=
 =?utf-8?B?VW1SZEt2RmR5NzBwNjVrUSsyTW44OFBxQWNDWThkeWp5WFUyTThjWk4yaTJS?=
 =?utf-8?B?dGRtcFpjRHFDTS9nSEF2RXlFUG9xeE9vdnllaDJuQmdBV3NVbVBDVnc0ZWZY?=
 =?utf-8?B?YWRIUjZKbGJKazJGQ1RNdHFTNlRiSEtmd3JVdGF2Nk5zem95elNBSlFjTm53?=
 =?utf-8?B?LzVQTUQ4MmFJWkxWa0R1TWhDOXpxMXkvV3NYVWg5M2ZaaWdBWnhjdzBoSW1z?=
 =?utf-8?B?UDM3M2REajZncE5oc2JWcXRuVmIySkgxS3h3b3FLZmkwemM4V0crQzFJWE50?=
 =?utf-8?B?RW1QQ3NiSEVRK0hIajdNVVlnRE1hNkd1V2NybG96Q1VnNHZDK3N0ak5iMHNn?=
 =?utf-8?B?VU1DTWVZZEJOK0I2YXZLM3R6bUFPbnZMdUtQSDRNWHFONUZ4MDBQK2NKeXZN?=
 =?utf-8?B?NUc2bzJwMXp1aitKTmM3UXd3c0dYNlplT3FpRWJ2OXBoSmE2eHY1cmpYV3Y2?=
 =?utf-8?B?WnBSREZubGNhOFBJd21ORExocVo1MGJWWGxyQXB5L1JuNXB2b1VYeXM0UEpK?=
 =?utf-8?B?dGtNM0NkWTBtUEJMSE5HcE8waEgvNDVXUEFkWVl2cEJkOHpxRFFJUSszSE5O?=
 =?utf-8?B?M0QwRUpSb2twakl5TWdtQTZyVXpGUFUvS3RlQWxURlpxcHBkeVFLQ3Y4QlBI?=
 =?utf-8?B?dURKZTZCMll3QzBjUm4wd3hzL0s0M2pMUTV0Rjc5bGQvQVlpRE5xMGpjZHlG?=
 =?utf-8?B?cUZmQnUxRXhhZU5PRkx6OU5yMDVNOWhKU2R6THoweXlOb2w2TEs3Z3lQM3M0?=
 =?utf-8?B?VHl6WjA1ZEdLcVoxZXo5THNKMDl0a2p6TnIyaUlZN3RJbVpsRDBCNFR0VTJy?=
 =?utf-8?B?NGdKS25ya1ZLcFFlT3RieFdnbFk1T0NYdWVNLy9Zc3BlQnZYWk9uZW5XMVFD?=
 =?utf-8?B?NzgybFFQY0krUlJxSDNNbjNQSVhZYmZ1WVVuTjhET3JwVTYrUXFNc2lZLzFT?=
 =?utf-8?B?V0NWVGJxSXlwd0owZ1FVd0VYQ3lYby9oTFhsVS9WYWlDeVprUlY1SnEreU82?=
 =?utf-8?B?SFlYcEhzZ3dJamZCTGJqWnlnYS81OVNqS0JmR2ZIMXkxaU1rWkR6QjBKYzk2?=
 =?utf-8?B?b3FYOVdDeElVUmpzcU1hbS9oMk16OENaZmdra0pvdFMxb2NCSGhVNm1WYkxL?=
 =?utf-8?B?ZC90anBqcUpCdXl6dCswb09qNFN6Rm1qekY5QmFsdFNlaUt6VGowUnZOWFgv?=
 =?utf-8?B?SjdJUHIvUkg4Sk80dGkwQW9WUStLWFJMUTVXMGllRXd5ajF6bFF0OU0yZmZt?=
 =?utf-8?B?SHNuM2pIQVlVYytUVU9nV2pFWVBSY1gwKzhZTXRvU1ZXRlVNZTErNDZlOVJT?=
 =?utf-8?Q?sHrfCnXEXWdh7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGFucjlmOXZ6K1hHU09nOWlWby9GcDBVanlBZGRNT212T3FPSituQVFubXVJ?=
 =?utf-8?B?ajhuNGorSFRoUlcyUnJQWkVJMFUzemZVS215VGlZNVlBMjgxcnIxR1RDYVAz?=
 =?utf-8?B?ODAvKzcxN2EydzBkS3Q0NjQ5cVFJVEhPMGQ5OHk4NE8vR1gyL29CWElERlpS?=
 =?utf-8?B?b3hwRHZ4TzRjSWpMV1ZVTTdvSUorV1dYSjZZVER1YmM3YnFZOUZtUHJhNXZu?=
 =?utf-8?B?VFhEc2NFazFmcWNMaXNyNEw4VlBFVE5Hd3dRVDNoeUJiYTIzSDloaFZKYjY1?=
 =?utf-8?B?UzBlNFhaWkdLcHY2REVYRmNHQnZpNGtCSS81K25WdmlIR0MrWG43cDgybzJl?=
 =?utf-8?B?Vk1XL0JWQ1BpTDZnaW9kS0kvMW45M05ldCtDTmdYekxkMTdnTHRGM2szajEz?=
 =?utf-8?B?KzdCaWZHRkRvUmp2MDY5ZHkwQjFscXRFNFBqT2lRYjg2UEhJNkkvc3dvQXF1?=
 =?utf-8?B?dWdTUTZhMnRzYlNDUmZldTBCMzdJT1lPM05PK1hGdXUyTFZpbnVJNE10Mjd5?=
 =?utf-8?B?UHl4ZW9LMWJrdW0yVUExZHY2bkVLaXg2L2E5L0Z2aldLNG1iaHFseHRyeUR5?=
 =?utf-8?B?UUJRQmtBUTR4ekgxb2ZuamMyRjlCdUw2S0hCc0lLVll4OUd5SU9aMGg4UktR?=
 =?utf-8?B?M1l6TU5Rc2NJUlA2Nk5yd0JBcDNZWGtNV1UrSGtWR1pIcGhjOGVuL3lQenJq?=
 =?utf-8?B?bkU2VllvMlJldnJ0NHpqVzlJeWZCb0xuVUdQK2lIZEtmdXlVSmVueHRyZlUx?=
 =?utf-8?B?M3EwMTVsTk1lUjF2Y1RsaTQ3Ri9yZkdrTmYvb1REbjVNSmEyWUNEVklNTmZk?=
 =?utf-8?B?aDh4UjN5MGxYMGtndmhqMldBZWYzR1gyaE5KTDIxWU1FYTBRaHhvUlFGTDVt?=
 =?utf-8?B?OHBQS2ZCa3ZrbmRMS1pvYzY2TEJuYnhDVlp0MVgyQkQ0ZEE1M2xTYXp0NUNW?=
 =?utf-8?B?RkN0NzNPTURkY2d0SnRVZnZEK0ZEN2hsR3JINmZWYkJPYThYRUxoeFlxamxD?=
 =?utf-8?B?WDZOS281dFl6SkkxVnB4d0NFZjNrcjFtcXhnSHJiejR2bkxVNTRrMkJpUSt6?=
 =?utf-8?B?Y1lKdDM4R2FXYm40aWorRVNQRHdHbllTTEJoK2xQbFpqNnhsYVhnQjdSOWd2?=
 =?utf-8?B?RE1ZdDVHdVdkVktleGdqbElnRGh0TWlzYVh2Y2ZoNEkra0dZTjlqYU83UGY1?=
 =?utf-8?B?SXFoNDd1OUlEQUw3b3VUbE1VK2U2Kzl5VDVOUFZ4NEFWMWxPVkdvNXVBZVYy?=
 =?utf-8?B?R2RQNEczQ0JsMVdOT3JJekJOQm5EaXRMZmMzdEo5cFE3bVM0TDVuRkQ0aXd5?=
 =?utf-8?B?WW80cG9rM0I4RzRyTkNqdk9qWkl4RTNnS1BLbW5JUGRwaDNTOGFKWGV4VHpX?=
 =?utf-8?B?TnZDalVDaExwNWkzNk9BTnJOb0JROFdQWVJEWFNXc0c2NHNjUmovVk5XbDhF?=
 =?utf-8?B?RCswV082OXB1ZEJ5RTVGTHpTS3kzdllNbGZSaHVld1lacGI4b2JVTkFjVGQ4?=
 =?utf-8?B?NXloSjQ4LzZVMk9QK1RZbkpaeVdjRTl5T1A1ekZIWG9lOG9Ba1p4VUR2TTIy?=
 =?utf-8?B?WkpzdExPMXdxNUpMMUZiRnc5TjlSVVFReHQ5WldvRWwyQlFCTDFlRVczbXNz?=
 =?utf-8?B?am9GaW1NeDhLbmxOM2RQdmJKRWZ1aXhWVm5qVG81V0Njek84THRhTHlMOTlh?=
 =?utf-8?B?M2JTMHgrUENXYmVvVEtMNUp2YngwcFNuMG81dVhOOU96elBpSldubi9idjVr?=
 =?utf-8?B?Z2FhU1JnSjE5c3BRRzZNaFMzb0hPd0NzZy9iRG01czdHYW5qc1Z6OWtEYzFh?=
 =?utf-8?B?aUExdk1aRkF1Y09ETlRrMFBqTElVRVNlUTNVYXNGaHZZSlQ5K3RhNUp3MHQz?=
 =?utf-8?B?WE8ySnIxNzBabzdUaGxPWjZUbVFEWk9JVmxWdWlDV1JnaHNDY1dwWGRBVGZq?=
 =?utf-8?B?b2M2SGl1eTM3MUp0U3NSRmNxYVdJYXN5VVdjS1pQOTVmenFlSzZvTkdhSlFK?=
 =?utf-8?B?WjI5TjJFTFJnSEZmZGlYM3A5ZnZ0bGFIRzBMc05qTEZNOWdOODJBTlorL0pn?=
 =?utf-8?B?eVQxVDd6WlcvbkVMMS9NMWFieUVRZEliRURlRjFaSTNLR3pwQ3pjSUV1N2ZO?=
 =?utf-8?Q?SJYgmt3r2HtVkuO3oswMbpqma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96df3cc-3fd7-4387-878f-08dd397a1891
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 17:44:31.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bazp24TnCXvkvRQSYo+gAGB/tOssDmtOboVwoQE+VDVtduIgLqYHmGZV/7FxBcfVf496aVgqps9748tagi6fMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716

On 1/20/2025 08:49, Pierre Gondois wrote:
> 
> 
> On 1/20/25 04:15, zhenglifeng (A) wrote:
>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>
>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> I noticed something here just as a user casually browsing the 
>>>>> mailing list.
>>>>>
>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>> Add sysfs interfaces for CPPC autonomous selection in the 
>>>>>> cppc_cpufreq
>>>>>> driver.
>>>>>>
>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>> ---
>>>>>>    .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++++++ 
>>>>>> +++++++
>>>>>>    2 files changed, 163 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/ 
>>>>>> Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same CPU 
>>>>>> frequency coordination domain
>>>>>>            This file is only present if the acpi-cpufreq or the 
>>>>>> cppc-cpufreq
>>>>>>            drivers are in use.
>>>>>
>>>>> [...snip...]
>>>>>
>>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>> +Date:        October 2024
>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>> +Description:    Energy performance preference
>>>>>> +
>>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>>> +        represents a range of values from 0 (performance 
>>>>>> preference) to
>>>>>> +        0xFF (energy efficiency preference) that influences the 
>>>>>> rate of
>>>>>> +        performance increase/decrease and the result of the 
>>>>>> hardware's
>>>>>> +        energy efficiency and performance optimization policies.
>>>>>> +
>>>>>> +        Writing to this file only has meaning when Autonomous 
>>>>>> Selection is
>>>>>> +        enabled.
>>>>>> +
>>>>>> +        This file only presents if the cppc-cpufreq driver is in 
>>>>>> use.
>>>>>
>>>>> In intel_pstate driver, there is file with near-identical semantics:
>>>>>
>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>>
>>>>> It also accepts a few string arguments and converts them to integers.
>>>>>
>>>>> Perhaps the same name should be used, and the semantics made exactly
>>>>> identical, and then it could be documented as present for either
>>>>> cppc_cpufreq OR intel_pstate?
>>>>>
>>>>> I think would be more elegant if userspace tooling could Just Work 
>>>>> with
>>>>> either driver.
>>>>>
>>>>> One might object that the frequency selection behavior that results 
>>>>> from
>>>>> any particular value of the register itself might be different, but 
>>>>> they
>>>>> are *already* different between Intel's P and E-cores in the same CPU
>>>>> package. (Ugh.)
>>>>
>>>> Yes, I should use the same name. Thanks.
>>>>
>>>> As for accepting string arguments and converting them to integers, I 
>>>> don't
>>>> think it is necessary. It'll be a litte confused if someone writes a 
>>>> raw
>>>> value and reads a string I think. I prefer to let users freely set this
>>>> value.
>>>>
>>>> In addition, there are many differences between the implementations of
>>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>>> amd-pstate...). It is really difficult to explain all this 
>>>> differences in
>>>> this document. So I'll leave it to be documented as present for
>>>> cppc_cpufreq only.
>>>
>>> At least the interface to userspace I think we should do the best we 
>>> can to be the same between all the drivers if possible.
>>>
>>> For example; I've got a patch that I may bring up in a future kernel 
>>> cycle that adds raw integer writes to amd-pstates 
>>> energy_performance_profile to behave the same way intel-pstate does.
>>
>> I agree that it's better to keep this interface consistent across 
>> different
>> drivers. But in my opinion, the implementation of intel_pstate
>> energy_performance_preference is not really nice. Someone may write a raw
>> value but read a string, or read strings for some values and read raw
>> values for some other values. It is inconsistent. It may be better to use
>> some other implementation, such as seperating the operations of r/w 
>> strings
>> and raw values into two files.
> 
> I agree it would be better to be sure of the type to expect when reading 
> the
> energy_performance_preference file. The epp values in the range 0-255 
> with 0
> being the performance value for all interfaces.
> 
> In the current epp strings, it seems there is a big gap between the 
> PERFORMANCE
> and the BALANCE_PERFORMANCE strings. Maybe it would be good to complete it:
> EPP_PERFORMANCE        0x00
> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
> EPP_BALANCE        0x80      // new state
> EPP_BALANCE_POWERSAVE    0xC0
> EPP_POWERSAVE        0xFF
> 
> NIT: The mapping seems to be slightly different for intel_pstate and 
> amd-pstate
> currently:
> drivers/cpufreq/amd-pstate.c
> #define AMD_CPPC_EPP_PERFORMANCE        0x00
> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
> #define AMD_CPPC_EPP_POWERSAVE            0xFF
> 
> arch/x86/include/asm/msr-index.h
> #define HWP_EPP_PERFORMANCE        0x00
> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------ Different from 
> AMD_CPPC_EPP_BALANCE_POWERSAVE
> #define HWP_EPP_POWERSAVE        0xFF
> 
>>
>> I think it's better to consult Rafael and Viresh about how this should
>> evolve.
> 
> Yes indeed

Maybe it's best to discuss what the goal of raw EPP number writes is to 
decide what to do with it.

IE in intel-pstate is it for userspace to be able to actually utilize 
something besides the strings all the time?  Or is it just for debugging 
to find better values for strings in the future?

If the former maybe we're better off splitting to 
'energy_performance_preference' and 'energy_performance_preference_int'.

If the latter maybe we're better off putting the integer writes and 
reads into debugfs instead and making 'energy_performance_preference' 
return -EINVAL while a non-predefined value is in use.

