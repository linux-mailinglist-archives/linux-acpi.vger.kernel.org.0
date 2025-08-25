Return-Path: <linux-acpi+bounces-16051-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14AFB34A83
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F917A34D5
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E830F545;
	Mon, 25 Aug 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="42DLx2RP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5C31077A;
	Mon, 25 Aug 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147239; cv=fail; b=byW9wbXpNGK+cBFyrqJf05YthWxwFPWmYW+YLFAqfIbbdkMvcLeRkYRRncVDgpzrHkN7tRCXWk+8+je9GvO+iOOs2udAmBs0MgLIUE7aROp/IQ51g28tMkswk7BbVHzYXYMzMTSUqz0sr6CjZPvYP4AVUMnQk18gHVDf0EEBWEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147239; c=relaxed/simple;
	bh=S4t9G/UciPveRZnCSRIXp6emZhySCLoeSMhRrYkV/UU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dxa9jYQgiaEJMN6FZnZgVKSKReuTianbfymgmHkPqe7+6NY9UkyZpU0kTky8vocUDptvkR8OiC72E1dbtu/pkHwhNHbyERSRKh3eFEzLcxJSybbviv6arZATNf6IF+c834B/nthgAAjvQA9NVGISuSjymFj4gF1pFUtpo3jdfGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=42DLx2RP; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFbS6lr6L+rh8DkqJOcM6FgtFUvGOLGxSWZgO8D44g8iCMKH+pCQkKQFEHowGKrBSpl14O2L7mIyeNeSp4sBGDkzZCUMmMN0nRAcUuqSeSWJ8suwNd+VfC/A8CxG8rITsucXtHslE05Az+IDSUu7oRtKLEsRAaX9ksItWMzTjkkw2ok3D7PO7Q13L86SggoKc/RNUCADkP2VpmRMA4A5XrEy2/UEC2Nj5zYxwlsR0dHxPDu7BObPlheMMOu95RlB+fhSHO/07CiIhXhcH5LPO147I3KcSE+iouyGg/QyQU7DuPhKpvoFKKkU4oxMnjIgpwIGw99hAbeTMj72smcrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fKgrAqaSrAlz195fEd9gVL3dcvcfzpJT45QidSmZMM=;
 b=nzetLO1qR0nvg0oaF7OO/3AhgewH1r5qzcMvzplEkO5tmHKz0WxYq+/SlimIMuKIFPjz6v9U8E10aJEBdPvnzKQzTx4d5Zp7l+mSuDcNDecjb+qG8uBMHySYMjA2Rj0TrQte5NAg3tVEuV/Q+WzjF9PcXtt3hhUHvBRBtDpEyE1fdmldd+Vd3XYS71Zf3UI0sD2ZIViHBytC9kJE6YE9vepDkj6OBRtjO+OdQYrsrwwaWTHsbKskVzxbtb67Jg6II8jRQI0sVr3VaJ+uqMJIb/NZcH8fhR9CIh+jRna/hSE6DBT8qbKf0yTM//wiIiL2pBzFKyRjyfAX7HM7LjJ95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fKgrAqaSrAlz195fEd9gVL3dcvcfzpJT45QidSmZMM=;
 b=42DLx2RPwYkHzPXGD4IQPDFaVTQq0/GxknZtBh31CLKpQ1f9PxMFWEVmRrabarO7YIkFJeWwG1ZT5WemGKJDQn5d3/4cZ6nYaHlDJdZ9BBbjsSMO3cMyb0lUIRJZPRibp5uveL3bhDBEHuV7DSSBqohLJamWQqTQmS6rxhMDzVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 25 Aug
 2025 18:40:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 18:40:31 +0000
Message-ID: <507095d6-512a-4561-bc90-12a34a43302a@amd.com>
Date: Mon, 25 Aug 2025 13:40:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250823200121.1320197-8-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0382707c-6087-47cb-1a55-08dde406deb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWZxYnJHZEJxb0dJSlovNUdEUStwUm9MSlVROEhMRlZjSlppTzh6SnprS2pW?=
 =?utf-8?B?dWRtSldvb1pwUUp1T2xYMWxyQS82c0xTN015dGR1MXc2NHN0R3FXQ0tqZWFD?=
 =?utf-8?B?RUNMeEdtY25TcldHUXBJL1JPWTVSWk4zZDJnY0RqNGFISlR2dXRJRWNJdUNK?=
 =?utf-8?B?eFdTaCs2ckNITlFNRmFYZmgvZzQrWnlKUitBc3NLSGQ5ZU5YWnM5TGNrYnZC?=
 =?utf-8?B?ZE5hNUg0eUc5aFZocy9oSno3R0RMM0h2c1IxenlRVW90Z09MZE9CS0hMSFVl?=
 =?utf-8?B?Q0lhNzNwNGk1M3ZrQ3VDNkFlRUdDUE1ySm1TMGQ0QlpqTkZWaWZrRFN0NWNp?=
 =?utf-8?B?TkdGQi9oRW9TSVMrSnh1SVhNNFZkdG8xK29rWTFPelNsMm9QaDFVaklLVm1n?=
 =?utf-8?B?OVcvcEJuMCs4aURJclVmWmJjNEE4MmhQTFp6Y2xUSGJ3WTBDSWgwK3RZR3BD?=
 =?utf-8?B?ZGhDN1VIcm1mTnNZemVkSDlFL1lXNjlDb0twcFVsY3h4dE53K0IyNW5FclFX?=
 =?utf-8?B?N09YOVBrTFJRQktNSTBrbm9zRHI5NVJiSzB1OXBIMGN2UzJ0QmlUbnpFdDV4?=
 =?utf-8?B?VGdUTEV1V3V4L0pUZkJ4SEJsRzVNcnYxNXZnWWhNanh2OWd4UzVVeGg5TXpP?=
 =?utf-8?B?eXB5QW84MTRKRmpVZmtaU21xNTJ0eW8rSkdXVFA4WHVteVJGVDRFaml2eXNj?=
 =?utf-8?B?L0FCZTF5YkVyWnVWWXBjQmZBZVpEU25Uemo5RTVRRTdTSG1yVTBkdmZiR1ho?=
 =?utf-8?B?eWVHMDN1eGtadUZOYUs4d3htVkZEU1YyQkhTVGdWNnpWZjI2d0o1ZkE1b3Rh?=
 =?utf-8?B?dEJiZXdiN29oMnd2ZnJPeERUaVlrcTNCNlMrbHc3UjJYNEtuQXl4UThtMzhE?=
 =?utf-8?B?VW1lbE4ySDBBUFRtOEZIUGs4bXRrT3dwM05xN2pZN1ZUWFl6VG9BY1pPeTJT?=
 =?utf-8?B?eUNFbHpiUGNkcUQyak9tUkN1YWVvNkJVSGVVcFpMSGNTV2FIbWJiK3VaYXhQ?=
 =?utf-8?B?VFRZclZTU2JIY2QwOXFkdFY3U0tiWUhBVHpVK1cyb1htSjV0VWFNUkxXMVRn?=
 =?utf-8?B?d2FKdU02QnVDL2M2RGhRMEZOclV6NktTSnJjbWZDbmtMRG1oUmx1OGxQcmpL?=
 =?utf-8?B?SENjWXppTGNYWlZnazFaRWpwck9xYmNGaENmRVdiZldNcXRSVm5kWEVEeE12?=
 =?utf-8?B?SGluQkhtV1JTRks3Z2lmckkyT3k0MTF0NDVQZTZkdjBrVU5LL00reHpxN1pF?=
 =?utf-8?B?UU1iQjQ0MTA4clVWajVqdlNOcUIrMlhHM2JENDJsRkN1YjlxNmloTVN0L0RN?=
 =?utf-8?B?VDZJU1h6M2h5MFdvbWZwQXcyS21kQVpUVlMrMGdvdzFuSnZuTWNTQXVRK3B3?=
 =?utf-8?B?V29ubC9yQkljTS81SGdyT0dLSUNLN1NsUE1yVzYyVmxmQXZQdmVSR2dpd09T?=
 =?utf-8?B?bERacWhNWmhOR21BamJDOEFuZ0I0KzVVQTdNWWo1RnZGbVhxeUJzVHBUbVZT?=
 =?utf-8?B?SFJyN0R4czJrYVljQmlqd01lZUZ4MEZkemtQclRnV0FRcm95bVY0a3VEcHAz?=
 =?utf-8?B?K2U0dUNoTTNIb0tqYUlGZFAraEREQUdRTlRtYXlMU0k3dDZ1Q2FkSHFSK0ps?=
 =?utf-8?B?bWtOQjVsTzdXZHRVbk1KVUdCOTgzYTlUc21YNlNZMUY4RllmbllqZThCNFZn?=
 =?utf-8?B?VXNwTVVtZExHTk1qZXVaTkQwbDdOMXgwSHF1SVBkWEpqMVdMS1Z4L0NDTHBC?=
 =?utf-8?B?dC95QTVWNGZrbk5DZUxSSUdhSXc1NU9BYU4yUmNFcXU0OU1Oa2VjSlp0b2NF?=
 =?utf-8?B?UU5WdlhkRVE4a1JjZ2NnbVZWQVRYMERYbS80YUVrd3ZOaGZoNHZRWUN1Zktj?=
 =?utf-8?B?TzQrbWZRcTRqY1dsbk1ydzFFaDA1eDhuN3cvWXZsVmE5MjZ0bmJ3OXdOWVNL?=
 =?utf-8?B?eXlYUTZSWTJtd21nZWtRbDh0ZHRhblUwZGlUaWR1aHpaeDZvcjZQYnY0V25Z?=
 =?utf-8?B?WXM1NUQ5NmR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBLQ0VkUGh3WldVMUE3d1NKUTg5Q01zMVBFQXdsWHdweUtKOVZJakFock9w?=
 =?utf-8?B?YUZqTU5qdzM3Z3BTR1BxdGlteFFWbVJuWDFaaDE5RlFGNml6L0FFaFNSRGQ0?=
 =?utf-8?B?WlZLak1RR2xYbVVBTkZXVThkWVFXMmtuNWRjKzNxeG85anEzcjlteDM1ZVNz?=
 =?utf-8?B?Mmt0UUM2cmMvZlVNT2ZzTFlYaGFJMVNnOTVTMFhCNXZRbjlrc3l3UHNQdVVn?=
 =?utf-8?B?ckEwdnRENzhVMUpsNlQxUU9rYTU1OVVMdjhuZ25qRE5BcHVPU0hGak4wVWJa?=
 =?utf-8?B?WFFPaW4xYWYxUmRaN2hKVmJ2bmxuMVNaNFBJYjA5MWFETWx2dytHTjVKU0o4?=
 =?utf-8?B?NzdScFdSSUsvRXE2UzFpQmlYdDJxQUpwY05SWWJwRlpFMkxGVnFEUyswN3dE?=
 =?utf-8?B?Yk5RUk5TTlFxNVEzekJXSlJvODhJR0IzZ0NXQ0NKZHNpaEdtQ0dMaGhCWHFo?=
 =?utf-8?B?REZ0WDNnZWJoNEhHSnB5N25SaWFORkwvbEhISnh3VVo4YjBXMDZUMnZpL1k2?=
 =?utf-8?B?Q1BjRTBTZUsxTDVUY2dKdVhJcmFPOE1vcmhkRWZxSEdQUmdCempNNVloYXJM?=
 =?utf-8?B?bGNpcTUzOThCL3AwNVFzRXQ3QUlaU1drQXdCVUpOU2ZhNHdvUFBkV3lPcFJp?=
 =?utf-8?B?cVVoYmZxSGlKMWVGTjZnWm1XRE51QUd1VzNMdnVSUzlwNjdmLzVIckpSOWNt?=
 =?utf-8?B?QlV5QzZ4NkZ0a3VnK1BmWUh1aU1acFJlYzUweDBNaitwcm5DK2NlYmtmTkh1?=
 =?utf-8?B?SkQ1RE54a084aUVheXF0U3pqZGo2OXd1NEM0Z3FVVUVQcjBPVWs2TUl0YTdM?=
 =?utf-8?B?d0tEa2dYS2IyaTdsZVdlOFdTa3lyY2VTV1Z5TVowRFZDcWdHRXdMVm9wMHZ3?=
 =?utf-8?B?V2hDSXEzMjY3N1laU3dnMEtwL0tMaTU2QyszVFl2S3JYaEFIenYveWxRWlRY?=
 =?utf-8?B?QnN2OEFmZ0FFRktKYW5mdmdKRG1FSWNlOUVDSHo1MkJqTjhSUjdsczFvZlNh?=
 =?utf-8?B?NXJOMWFwNjB0djI4bUpyRURkQ0c2Q1RLS2U5SjA1UjNmUXhIaDExTU5ab0xJ?=
 =?utf-8?B?MGFTOUZKazNEWWNzU0VFSm5uTXJDVjZ6NjRUYUxJdWwvWG5Lb3plTWZzcEhI?=
 =?utf-8?B?Wkgzbmg0VENDNWtlL1QzWlVmR2NuUXFlYkI5VFluZENnQ2JnWTNtMmdaV3R1?=
 =?utf-8?B?MHNNcDdlZERxbWZ1ZEN0VG94ckR0bUhBTjZPS1FrVWpyMDhRZ0puQ2g0c1Ji?=
 =?utf-8?B?M05RVnVJbDhQb01jMGpNcHFFdXY4aElOQThsME1Wa3FKSmQ3UHJlTXRGRlgy?=
 =?utf-8?B?MndRbWh1VlJWcXpDc2VSRm8wM3pCQ0NOS3lqWGhPWWNWNFhkallCUW1jazhH?=
 =?utf-8?B?aStycjJSazJ6UG1ZWlgwRnZJK09JWEdWaHd5VkVIS2hSNS9vNTRaYmFXT1VR?=
 =?utf-8?B?NGh3enBxeWJBZGJ6c1gvUjE1SG9qRHRTZk1yU3pCbWdZU0ZFNzR6MCtXMS84?=
 =?utf-8?B?Yzd2dWtYQmJXMGE1MFZlVUVUR01LaGdNMFlGQlBTRXlTN0RBczNPVU8xSFlT?=
 =?utf-8?B?VzhOZnM1NWluc2hUZUI4bEVyY0hTS0NiSFBQK2poVjdYbEdrMGFaT20vQUpF?=
 =?utf-8?B?NHBxakVlK3p6VHliYTFHUXFMZjNVN2tmVlpHZ2x3MUZJQlpYYjhEbnl2QmVN?=
 =?utf-8?B?cWxzSEJHVXBXeEdOTGtHTlRNaUhCNTRKMmxjMlp2ckJqRzMwRWVEdFdYN2dh?=
 =?utf-8?B?ZzBJYnF2cTdDdUVwZ2Z1KzhMQVlicXJyRmc2WWs0TjA0WFlqYmp3TktRYktJ?=
 =?utf-8?B?NlJvWTA3bENVQm1YRThIdFdUQithckFTMXdKQXBadlNFeWhCZjFCZkM4SU9t?=
 =?utf-8?B?aENpU09zYWhDM3dRVEh5ZkJEaUJrTXMwNU8zczlnd2cyT0k1bHNOckR5VjRM?=
 =?utf-8?B?aVlyelBIWnhET0IvcUo1WnRXY1ZzQ0IvZTJoZkVHUjZMRDNkWFA4bHVNM1Bn?=
 =?utf-8?B?UUNWeW9VejJQNXZmb3M2Y2VWQk9vcDJCc3hnakg4NnpOK3dUVzBFUFg3Ty95?=
 =?utf-8?B?SnkwMjNkWkZ0bHdMSkZEdXJ2MHIyNTZvdDFRRk1MWU1Gb25neGxSWlVmYUJF?=
 =?utf-8?Q?HC24HxGKZ17SCahVpF6/pxstr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0382707c-6087-47cb-1a55-08dde406deb4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:40:31.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXngjsHXyS7heOp+qp3lWLTXfoaI2VOThsmEO+POyJQGlECM/P0Urn6jpgYxct0A3Gpl7go+ESy0Se3MlpQNAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

On 8/23/2025 3:01 PM, Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection at system startup. When autonomous mode
> is enabled, the hardware automatically adjusts CPU performance based on
> workload demands using Energy Performance Preference (EPP) hints from
> the OS.
> 
> This parameter allows to configure the autonomous mode on all CPUs
> without requiring runtime sysfs manipulation if the 'auto_sel' register
> is present.
> 
> When auto_sel_mode=1:
> - All CPUs are configured for autonomous operation during driver init
> - EPP is set to performance preference (0x0) by default
> - Min/max performance bounds use defaults
> - CPU frequency scaling is handled by hardware rather than OS
> 
> Also ensure that when autonomous mode is active, the set_target callback
> returns early since hardware controls frequency scaling directly.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  12 ++
>   drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
>   2 files changed, 168 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 86f395f2933b..ea58deb88c36 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -911,6 +911,18 @@
>   			Format:
>   			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>   
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Autonomous Performance Level Selection.
> +			When Autonomous selection is enabled, then the hardware is
> +			allowed to autonomously select the CPU frequency.
> +			In Autonomous mode, Energy Performance Preference(EPP)
> +			provides input to the hardware to favour performance (0x0)
> +			or energy efficiency (0xff).
> +			Format: <bool>
> +			Default: disabled.
> +			0: force disabled
> +			1: force enabled

I don't think you can actually force enable.  If the hardware doesn't 
support it, setting 1 won't do anything.

IoW really setting 1 is "enable if supported".

> +
>   	cpuidle.off=1	[CPU_IDLE]
>   			disable the cpuidle sub-system
>   
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 5e1bbb5f67b8..bbf654c56ff9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -27,6 +27,8 @@
>   #include <acpi/cppc_acpi.h>
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
> +/* Autonomous Selection */
> +static bool auto_sel_mode;
>   
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
> @@ -272,6 +274,14 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>   	freqs.old = policy->cur;
>   	freqs.new = target_freq;
>   
> +	/*
> +	 * In autonomous mode, hardware handles frequency scaling directly
> +	 * based on workload demands and EPP hints, so OS frequency requests
> +	 * are not needed.
> +	 */
> +	if (cpu_data->perf_caps.auto_sel)
> +		return ret;
> +
>   	cpufreq_freq_transition_begin(policy, &freqs);
>   	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>   	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
> @@ -555,6 +565,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   		goto free_mask;
>   	}
>   
> +	ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
> +		goto free_mask;
> +	}
> +
>   	return cpu_data;
>   
>   free_mask:
> @@ -642,6 +658,79 @@ static int cppc_cpufreq_set_max_perf(struct cpufreq_policy *policy, u64 val,
>   	return (ret == -EOPNOTSUPP) ? 0 : ret;
>   }
>   
> +static int cppc_cpufreq_update_autosel_epp(struct cpufreq_policy *policy, int auto_sel, u32 epp)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	pr_debug("cpu%d: curr epp:%u, curr mode:%u, new epp:%u, new mode:%d\n", cpu,
> +		 cpu_data->perf_ctrls.energy_perf, cpu_data->perf_caps.auto_sel, epp, auto_sel);
> +
> +	mutex_lock(&cppc_cpufreq_update_autosel_config_lock);

As I noticed below a case you missed the mutex unlock, this feels like a 
good candidate for

guard(mutex)();

> +
> +	ret = cppc_set_epp(cpu, epp);
> +	if (ret) {
> +		pr_warn("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
> +		goto out;
> +	}
> +	cpu_data->perf_ctrls.energy_perf = epp;
> +
> +	ret = cppc_set_auto_sel(cpu, auto_sel);
> +	if (ret) {
> +		pr_warn("failed to set auto_sel for cpu:%d (%d)\n", cpu, ret);
> +		return ret;

Looks like a case that you didn't unlock the mutex.

> +	}
> +	cpu_data->perf_caps.auto_sel = auto_sel;
> +
> +out:
> +	mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
> +	return ret;
> +}
> +
> +static int cppc_cpufreq_update_autosel_mperf_ctrls(struct cpufreq_policy *policy, u32 min_p,
> +						   u32 max_p, bool update_reg, bool update_policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	pr_debug("cpu%d: curr max_perf:%u, curr min_perf:%u, new max_perf:%u, new min_perf:%u\n",
> +		 cpu, cpu_data->perf_ctrls.max_perf, cpu_data->perf_ctrls.min_perf, max_p, min_p);
> +
> +	ret = cppc_cpufreq_set_min_perf(policy, min_p, update_reg, update_policy);
> +	if (ret) {
> +		pr_debug("failed to set min_perf for cpu:%d (%d)\n", cpu, ret);
> +		return ret;
> +	}
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, max_p, update_reg, update_policy);
> +	if (ret) {
> +		pr_debug("failed to set max_perf for cpu:%d (%d)\n", cpu, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cppc_cpufreq_update_autosel_configs(struct cpufreq_policy *policy, int auto_sel,
> +					       u32 epp, u32 min_perf, u32 max_perf,
> +					       bool update_reg, bool update_policy)
> +{
> +	int ret;
> +
> +	ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, max_perf,
> +						      update_reg, update_policy);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_cpufreq_update_autosel_epp(policy, auto_sel, epp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int cpu = policy->cpu;
> @@ -710,11 +799,28 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> -	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	if (cpu_data->perf_caps.auto_sel) {
> +		ret = cppc_set_enable(cpu, true);
> +		if (ret) {
> +			pr_err("Failed to enable CPPC on cpu%d (%d)\n", cpu, ret);
> +			goto out;
> +		}
> +
> +		ret = cppc_cpufreq_update_autosel_configs(policy, true,
> +							  CPPC_EPP_PERFORMANCE_PREF,
> +							  caps->lowest_nonlinear_perf,
> +							  caps->nominal_perf, true, false);
> +		if (ret) {
> +			pr_debug("Failed to update autosel configs on CPU%d(%d)\n", cpu, ret);
> +			goto out;
> +		}
> +	} else {
> +		ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -736,6 +842,13 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>   
>   	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
>   
> +	if (cpu_data->perf_caps.auto_sel) {
> +		ret = cppc_cpufreq_update_autosel_epp(policy, false,
> +						      CPPC_EPP_ENERGY_EFFICIENCY_PREF);
> +		if (ret)
> +			return;
> +	}
> +
>   	ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>   	if (ret)
>   		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> @@ -920,17 +1033,10 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>   	 * On enabling auto_select: set min/max_perf register and update policy.
>   	 * On disabling auto_select: update only policy.
>   	 */
> -	ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg, true);
> -	if (ret) {
> -		pr_warn("failed to %s update min policy for cpu:%d (%d)\n",
> -			val > 0 ? "set min_perf and" : "", cpu, ret);
> -		return ret;
> -	}
> -
> -	ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg, true);
> +	ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, max_perf, update_reg, true);
>   	if (ret) {
> -		pr_warn("failed to %s update max policy for cpu:%d (%d)\n",
> -			val > 0 ? "set max_perf and" : "", cpu, ret);
> +		pr_warn("failed to %s update policy for cpu:%d (%d)\n",
> +			val > 0 ? "set min/max_perf and" : "", cpu, ret);
>   		return ret;
>   	}
>   
> @@ -1139,13 +1245,44 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.name = "cppc_cpufreq",
>   };
>   
> +static void cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
> +{
> +	int cpu, ret;
> +
> +	for_each_present_cpu(cpu) {
> +		ret = cppc_set_epp(cpu, epp);
> +		if (ret)
> +			pr_debug("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
> +
> +		ret = cppc_set_auto_sel(cpu, auto_sel);
> +		if (ret)
> +			pr_debug("failed to set auto_sel for cpu:%d (%d)\n", cpu, ret);
> +	}
> +}
> +
>   static int __init cppc_cpufreq_init(void)
>   {
> +	bool auto_sel;
>   	int ret;
>   
>   	if (!acpi_cpc_valid())
>   		return -ENODEV;
>   
> +	if (auto_sel_mode) {
> +		/*
> +		 * Check if autonomous selection is supported by testing CPU 0.
> +		 * If supported, enable autonomous mode on all CPUs.
> +		 */
> +		ret = cppc_get_auto_sel(0, &auto_sel);
> +		if (!ret) {
> +			pr_info("Enabling autonomous mode on all CPUs\n");
> +			cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
> +		} else {
> +			pr_warn("Autonomous selection not supported, disabling auto_sel_mode\n");
> +			auto_sel_mode = false;
> +		}
> +	}
> +
>   	cppc_freq_invariance_init();
>   	populate_efficiency_class();
>   
> @@ -1160,8 +1297,12 @@ static void __exit cppc_cpufreq_exit(void)
>   {
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
> +	auto_sel_mode = 0;
>   }
>   
> +module_param(auto_sel_mode, bool, 0000);
> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");

Why default to disabled?  As a precaution?  We enable EPP by default in 
the *-pstate drivers if the hardware supports it, I would think it makes 
sense here too.

> +
>   module_exit(cppc_cpufreq_exit);
>   MODULE_AUTHOR("Ashwin Chaugule");
>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");


