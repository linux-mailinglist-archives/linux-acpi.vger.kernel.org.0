Return-Path: <linux-acpi+bounces-16252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59BB3E54C
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600DF1A846D8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553E3314DE;
	Mon,  1 Sep 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0W2rF3z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5231DE2A0;
	Mon,  1 Sep 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733838; cv=fail; b=MpfIwjWGYqd3xQEx6qv63bPMTq+Eqe6Gmg325FIDG67ooZ1fpgAJi45vmLB1kBpLTLAljyRmbEf/HqsFkIfzOygTxjKV90NN/RbotRsxFjIJbB0qk7I8ketuaVkw5Zc0UROa5nntNleVMpprgrdXw1HhmaRjlqM0QMGQ1ktgL10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733838; c=relaxed/simple;
	bh=N/XF4L8+icDgTrYR7Tn1yjBbJvR6dLpJr/JNT94xFmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gk5fyYdhUdJdV6NPnhO3nSR+dM3XA57ak/ZlmCccdX46eP4QJvnO5X6LgFGydhowtJ4zxIWQVlqX13zjc0Gk6tsemKKWiwLty0o1KbYqLVaZXzlHPDjxdyWxldX5m8iTGxqJUFTLXNY26Xpf8pSKYuINKvXBIBYxu4tC4HucY9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0W2rF3z; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhJkiI+u3vEglirUAMi3nMGWh8dLQt5hEae9pEyk1S2NAXSQ9lCSl9M0mUiMSS8PeZ7yMeWqQatmCrXe4pkvbD1ZSokmSBaA1qvgTZ+LvsxHANch7E+7dn/1MSyPE8rc1JAY3NwKrTPtwHlGY+1eAkwuxmyXys+G1y0wJn1BSfsVe4LS3e2vU0SSg+MFK8rlsyImVPd0JwI4rYzSryvDD5eXadWRNoP4Y91Nl0F8aP8H/ZrKTivoMhvqXKy/dydWJr3RbevgSkvsFcPI2FchIrkIbMGBsaWB5Dk0Qbo9oR6kUAYT1fu7A/iPAhYyKeTDALY4eFOOKKtoxJbRLhWvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPizuBOcMz35VnJLt4YQHbt41peRBWGG9k1pjBwvaMg=;
 b=FVk6Vk0NITRl3p1ic+FvRGLUz224x432MCEdIgKJLMhTVLHA9vTKomO8fcEtK1T54N2v94WqjZa9oAcQ6zMzcmUrf9pWpn+SYX5Xt27q1eZ3RJGcFSkOl00Oa3BTUGnZ6KMQtpJWpFDGyP1xRceDRL7fBQVa5yvBp0yZwLuRdCiPmOP9a4eXDhE9hxW38+etRo1BQbGyBAJPu2U/eG/b5aJ7MSn38cF6IWhg6yz639WP5cJ8QM8ZhI0+unM0wsbGZ/iRAUPh6v8dwt6MCIDNjc97W3+3p7BOwn07jvbrdqd38cUuYLbXV7mq50GM2y0NEkQNPV+7ZhqkuuDtV8oaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPizuBOcMz35VnJLt4YQHbt41peRBWGG9k1pjBwvaMg=;
 b=c0W2rF3z4BTf6GPG2aoUhtGBD7jgn83CDtgC47rAMM9A0USdOq/tDEJ/edFbWPAE1jNw/ku+OW5ebgfyLvw1+7NMJOC+lCpH+gcZaiNdtSqmaa9DJDMz6cso7+Rg3bS4rlydBX8jxzTapkXVHPVnAOW3SwvRkRsv+DlrFtz1LKPqhS9AUACMFo+NyGDMAC1mD5Th7DcI+H3DNuebw277lztfqPM8OrJZEll//+MNhrIG211Rj6qHW2I7ljCTv478t9kL51kBFW6U0CZftU+6CMAfJNTESEGzEPYHNuwpeW8jjJd7lizlt5Na+xL2+EGqCJYeTpM04lc8ENSrJC5YvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 13:37:11 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:37:10 +0000
Message-ID: <30b46202-d377-4455-9551-5874e1e9f104@nvidia.com>
Date: Mon, 1 Sep 2025 19:07:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
 <507095d6-512a-4561-bc90-12a34a43302a@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <507095d6-512a-4561-bc90-12a34a43302a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a07b93a-62fd-4052-ce99-08dde95ca6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWRmVm5sZWFVODJNSGlsT3pwb3Nqb2cySy9nUDRhOGh5VzNsVnhrWjQwanZU?=
 =?utf-8?B?Z0hIQWhXNGdobWdDRHBtTlJVY1dGazN3c3BBVi9YZytDQW9MWm9jUUsyaTZP?=
 =?utf-8?B?d0VVZmMrYis3dlhUMjBONUROOTNIZU5zUGVQWU1DWVBnN3FkL1c1SklYNkNl?=
 =?utf-8?B?TVVZZStxQkpNUWludk15V2RyR2lKTlRua2hpYVlKdUZCLzdMNTVYUEtqeGVM?=
 =?utf-8?B?S3NRaGt3dCszeGZyT1h2VWxXcDluVXZwR3lMdXUvaXFTYVRFdWoxNVhOQkxF?=
 =?utf-8?B?TmFhUzZBQWQzZ0ZWVWtKcGtnNWszaXZEaS9hN2JQMVRSd01MNnpKcEpCM0RI?=
 =?utf-8?B?THVsbmpiZjE1VmZkTGlLUjkzdUROT1VCNFZUbk5oS0tOTTB3ZXZ2TlVoaXVj?=
 =?utf-8?B?aUhUR2h4UWdtS2ZGYkcxMm1aZlo0bU5xZk4vTlRmSExnVDdyNDE2UDdKc1py?=
 =?utf-8?B?RkJnTG5qOUNnQWV4dFNLVlpoeGlheVBFMXJZa2trVTVEanptZzBlM0VINVBV?=
 =?utf-8?B?d216ZGRvNkQzM0NsbXMzVC80eUs0NXUzaTdpNW5HSzlHMkV6N3N3UzZ1ZlpE?=
 =?utf-8?B?T3QyYmxkNVR4Zkd3ZEQ2cmhnbGpwWlk2NWgxWWszWnQzeWIwQi9GL3piZWVP?=
 =?utf-8?B?UDU5TldWek1ISUU2SVozaEZ2RmZhNVdQVkNzNXVDQlZmY2svMFdJNk1QcnZj?=
 =?utf-8?B?eHBhUUJPY09PbFVaZkN1RmF0OFFQeENlK1FNTTZJRmpnaTdyenh5ZkFOL0Zu?=
 =?utf-8?B?SzJOTS9DT1NUWG1sdmlZRFV4bkRlaGgvbEFpRFNrRVEvZlRacWJjRGdkWWMr?=
 =?utf-8?B?RHk3VmFWYTJ6T0RtcTJpa2QraURJRWNCNjBYWkhub0JIWnQ1L2kzaFNkWFBj?=
 =?utf-8?B?TERvZGZ0ZXZWOHFqZ2l3TFlmajk3eTV1VThvQTBDT0xGZ0ZxZmZtM1ZOM2F3?=
 =?utf-8?B?ZldHd1FSaXhCb1RwZkpJVjlDaU5Vc3I0Vzd5VGlrdDUvYWFjeUZnVHN6SCtO?=
 =?utf-8?B?a05JRmJiazdTdys1MVgzaHZvekNsVVdUSjFSQ3ZZYVhGSmgrZDZEUEJsbm5Q?=
 =?utf-8?B?anFTVTVkNG4zQkVHdThIcGUxMFlyWEpyajYyZElEUHVCajBRUStjTXZuY2t3?=
 =?utf-8?B?SmxyVjRUZU5yajRaWWdQeGJzd3VuM21wRENJZXUzK2dqR1F6MUVYWGQxT2pQ?=
 =?utf-8?B?V0daUWp0cDEwYWtHemNTVlhpWVhPbWNSRnBTZmJUM2F2SjQ4WFNDYjMwODVs?=
 =?utf-8?B?emphelg0a1daeGwwNk5yNkxGVEZrbWpYZzA3ZU1wZ1RtRjRhK3lEb3J0Y1VF?=
 =?utf-8?B?SnhGVVh1emNUVjV6RFc1cE9iSzdZenkzTEYvaFBCaFg2OTl5QmJrNG9TTlFt?=
 =?utf-8?B?UmpOYWpuMzVCcmhiM1RjUXQ1UndBWkpSMUxRa3VQWFdIUFJPY0kzd0hFR3Aw?=
 =?utf-8?B?aDJyRTcwRmJUeE5mQ3ZHWE5UQXgrUy9Na3MxbUJtVTYrdjJWcEJyYzZpUXo1?=
 =?utf-8?B?NW5haDFtVHJWNU5qemtNZEF0U0huM3NhbGRkNzk0Q2FjbHdOaHpabEhUUUxV?=
 =?utf-8?B?MWh2ZUFqb3hhMHRLUDI2WTdOdHJKMGlJRndxRGFuRkJZWUw4SVZpdUpvODRS?=
 =?utf-8?B?cjlBMEpIK0N6WTdKZnhNZ1VJeU9DZTBWQXRIVENGNGd3bEtzZHp1blNBMzFS?=
 =?utf-8?B?d3Q5V2N1cFVaUG4rOTdibFI4emNGb0hTV2NqUnErSU9kcWVCVmRJU012REZW?=
 =?utf-8?B?U1U4dkJJaUZwekNkQ1B4VkhhUG9kWStUUEU0UnNkb2wvZ0krTjZneUVNU0Ry?=
 =?utf-8?B?MVZzc3pnNndmRXVYUG5rUS9mVWVjSTU2OGx4OWJUYmpxK3UrUDI4cXJIUzNC?=
 =?utf-8?B?em1HV1diSVdIblQxVXl6NEdaZXpsRTUxTG8vMEFLR0Z5Uit4d2hzdzJnQXNJ?=
 =?utf-8?B?NzFPQitpc3Q4dHFKcjdqSU1ETlhvMzV2dm1ZM1JwNWtrMjdQUmpVdmxCb09Q?=
 =?utf-8?B?bjRsUFdqQTN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0FHNzlaQjhRM1ZIYWkvQXdIM1EwaTJ6WVNJaXNYdjVaQXZCamZPRWNVU2ox?=
 =?utf-8?B?S1dabUttVjdKaUJjU0FvSkN3MnU1clFqRzR2Wk5FTjh2UitMRXFNVU9ob2py?=
 =?utf-8?B?SEdMR1dlWmVjNThjRWg5a0FuckZxYVpWZkZXMnMxRm1Db1BwMThNVEY1QWdo?=
 =?utf-8?B?Y2xHNFE5dmVMSXlTdFdBM09SVHo1d3BHcGE0OXlqUTNkUWI2KzVEaGlhR1lt?=
 =?utf-8?B?K1NPemFYYXNCUUpsWUJzdmtvNlBVRzlvTFUwK251VnczZFJTZWhLeUwzbWkz?=
 =?utf-8?B?MEJVWG0zalk4ZXJORWZUdHNYdjI1TVQ3ZVh3OFZMR3BvNmkwRkZCRFhGM3Rm?=
 =?utf-8?B?U2dIK1htdUEzcEhlVVlaRHgwTjk4VGNNS2F5ZkZ2VmlvejBlUjVDTmpPbGJ4?=
 =?utf-8?B?VkZIYTZ1Y1gvSWY3eFFLdHBjdkw3WUh6Tk5uNHNpUm1hSGlkSzVQZG9HbEZL?=
 =?utf-8?B?ajdtR1RHbHdFZFNaR3FGNG4wSVB5SElRVkhrSTBYYWtOQlkxZm55MnNEc1c2?=
 =?utf-8?B?aGJ3SEhJeWl2UzFDZ3FnMlZLdGd2L000S3BTUDNyZUpxUkY0cnlVSlBjUWZC?=
 =?utf-8?B?WkpwQzQxblowYVh0b0VEb3VJbXZkVmoydG0rR1UwTll4Zk9BWFplQTNBa1pZ?=
 =?utf-8?B?YVFnYllqTlBQQ0JHeGo0aEFwUjdaSDBKMVdDNVljQ085S3FJY3lxcnNMZmR2?=
 =?utf-8?B?NDI3aWtkTS9jeklOY216STIrVnNiOEduU2dpNHFWUWtHU1haaDNiSkZRWEwr?=
 =?utf-8?B?RnJNamRzQkZuNWUwVHVDUjlsRnRnMHdkc2RPMnNVSWVIcnpWRVJTazhQQ3dF?=
 =?utf-8?B?YUdWR1hNQVpxUGl3UGNLd08xajlROS96R2lETk1zMnlENGtINnowUjJSTVBG?=
 =?utf-8?B?SW5ERUhaUGNyWTZ6V0dDOG1FUGtGWlg1QmY3UG5lMG1ZNmJaVTdJWllGcVRy?=
 =?utf-8?B?SHJ1b3R1bG9wT1FxV1paaW5DWkgydG5RdTBuZy9xQ21LNStxWEtFTExJRWFD?=
 =?utf-8?B?LytjSlBZWjhwby93SnVSRktjaVpZcWgyV3k4Y0NXM1V2VzBodEJraHhPSTZh?=
 =?utf-8?B?Z0NJWjQ4M3BwQ0haMzZHU0xrTVlybmxmeTFkenc4MjA4a0FTdU5laWg2bnc0?=
 =?utf-8?B?VFEyMTd0b0tHWG5pbHZRS0tlVTJHcURLZGxPTUxQaVJ5Yy95blhxdDdJZEN2?=
 =?utf-8?B?cEx4Mks4S3pLSWhBL2xsUzN0RXo1M29LaXA0REFsMmFjMTNmbkc1SVpUcHBo?=
 =?utf-8?B?OVpJVHZWYXYzWDFycEI5eDBleFd1YkVtU1hyQWNjUTN2QjVHQnVnWlhnaGtt?=
 =?utf-8?B?VEkvSE9xdEJBcXBLY1VjUzQyOUZJR2VrL3BsTXM5STYzdk9PQ3ZhN3FmdlVs?=
 =?utf-8?B?c1FtM3ZIenpqWkhTTVg4R2tvbmUvdXQxdHhVYXYzaDZLOVU5dmsxQzMxTXVO?=
 =?utf-8?B?b2pPNnFhbk03VklkaURRcE1SUStEVzRmeGd1cXFUQTFOcElZZEVZMXlGVFB6?=
 =?utf-8?B?SHVNdDFYTmtDUVlkTlQ4WlBVT2s5czFyc05ZQ1ZMRjBCNEkxdzBKdWh5SUNv?=
 =?utf-8?B?bVJvbXdJYzdhd3M3OHdIWm45VVlDUnhVYzQwYm5TMksycE1xN0hTUW9BZTZj?=
 =?utf-8?B?TEY0TVp6K1lpUnFkdVZVRjNyMEMzZHFPeGZ3VGd4NU9nR3hKN2hyTXc0UTdJ?=
 =?utf-8?B?UW5iNmxyMVFlSXN3ZDBKd1I1ZllUWWtWSk5BVkduQlVjZjFWaTF3WU9yVHN6?=
 =?utf-8?B?VndoMVVaRU1WNE9qa1gzRDFlMm1TTWhqZWdXNklFY0JuQ0R6NlplVTZJTUpi?=
 =?utf-8?B?c25uOVZqL3hLYi9ISlQrUXNrOFU5RGhrNGdQNzNhUUhGYzc0c3RnRzczYzRE?=
 =?utf-8?B?cTdOTldZK1U4SnlLVVlEYmxnZjRvTHNadnZjUjU1dTJWVGNJVFJES0JKSXl6?=
 =?utf-8?B?Ym1TOU1TaFpEeGhOeGtCV2l6eXRpMUJwRWFFdmY4aXRRbmVOeE0raXVwNDdh?=
 =?utf-8?B?ZDk0VHVXMmJETjZFZ3FpMGc2ZXVCZ3NuQjQ5bFpPWkVuZC9vV0hpYTFCajlj?=
 =?utf-8?B?N1Z5NGhNNGk1VzFSSnZ5WmxyK3hrU2ZJMndTeGN1d3YrK053SWViRXdxUTZC?=
 =?utf-8?Q?n+bDAb7wcIStVlCzlQIKYcynt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a07b93a-62fd-4052-ce99-08dde95ca6d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:37:10.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+2Or+PKQqeWl1kfGFC7qZ2J+yRm7JKD7tzw3hMCkRnlhnwKeQhamYfhykiUmBMeAlH0/vLqxRhU2OBprbpQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317


On 26/08/25 00:10, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/23/2025 3:01 PM, Sumit Gupta wrote:
>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>> autonomous performance selection at system startup. When autonomous mode
>> is enabled, the hardware automatically adjusts CPU performance based on
>> workload demands using Energy Performance Preference (EPP) hints from
>> the OS.
>>
>> This parameter allows to configure the autonomous mode on all CPUs
>> without requiring runtime sysfs manipulation if the 'auto_sel' register
>> is present.
>>
>> When auto_sel_mode=1:
>> - All CPUs are configured for autonomous operation during driver init
>> - EPP is set to performance preference (0x0) by default
>> - Min/max performance bounds use defaults
>> - CPU frequency scaling is handled by hardware rather than OS
>>
>> Also ensure that when autonomous mode is active, the set_target callback
>> returns early since hardware controls frequency scaling directly.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>   drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
>>   2 files changed, 168 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 86f395f2933b..ea58deb88c36 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -911,6 +911,18 @@
>>                       Format:
>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Autonomous Performance Level Selection.
>> +                     When Autonomous selection is enabled, then the 
>> hardware is
>> +                     allowed to autonomously select the CPU frequency.
>> +                     In Autonomous mode, Energy Performance 
>> Preference(EPP)
>> +                     provides input to the hardware to favour 
>> performance (0x0)
>> +                     or energy efficiency (0xff).
>> +                     Format: <bool>
>> +                     Default: disabled.
>> +                     0: force disabled
>> +                     1: force enabled
>
> I don't think you can actually force enable.  If the hardware doesn't
> support it, setting 1 won't do anything.
>
> IoW really setting 1 is "enable if supported".
>

Yes, will change in v3.


>> +
>>       cpuidle.off=1   [CPU_IDLE]
>>                       disable the cpuidle sub-system
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 5e1bbb5f67b8..bbf654c56ff9 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -27,6 +27,8 @@
>>   #include <acpi/cppc_acpi.h>
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>> +/* Autonomous Selection */
>> +static bool auto_sel_mode;
>>
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>> @@ -272,6 +274,14 @@ static int cppc_cpufreq_set_target(struct 
>> cpufreq_policy *policy,
>>       freqs.old = policy->cur;
>>       freqs.new = target_freq;
>>
>> +     /*
>> +      * In autonomous mode, hardware handles frequency scaling directly
>> +      * based on workload demands and EPP hints, so OS frequency 
>> requests
>> +      * are not needed.
>> +      */
>> +     if (cpu_data->perf_caps.auto_sel)
>> +             return ret;
>> +
>>       cpufreq_freq_transition_begin(policy, &freqs);
>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>> @@ -555,6 +565,12 @@ static struct cppc_cpudata 
>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>               goto free_mask;
>>       }
>>
>> +     ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>> +     if (ret) {
>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, 
>> ret);
>> +             goto free_mask;
>> +     }
>> +
>>       return cpu_data;
>>
>>   free_mask:
>> @@ -642,6 +658,79 @@ static int cppc_cpufreq_set_max_perf(struct 
>> cpufreq_policy *policy, u64 val,
>>       return (ret == -EOPNOTSUPP) ? 0 : ret;
>>   }
>>
>> +static int cppc_cpufreq_update_autosel_epp(struct cpufreq_policy 
>> *policy, int auto_sel, u32 epp)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     pr_debug("cpu%d: curr epp:%u, curr mode:%u, new epp:%u, new 
>> mode:%d\n", cpu,
>> +              cpu_data->perf_ctrls.energy_perf, 
>> cpu_data->perf_caps.auto_sel, epp, auto_sel);
>> +
>> +     mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
>
> As I noticed below a case you missed the mutex unlock, this feels like a
> good candidate for
>
> guard(mutex)();
>

I will check about 'guard(mutex)()' and change accordingly in v3.

>> +
>> +     ret = cppc_set_epp(cpu, epp);
>> +     if (ret) {
>> +             pr_warn("failed to set energy_perf for cpu:%d (%d)\n", 
>> cpu, ret);
>> +             goto out;
>> +     }
>> +     cpu_data->perf_ctrls.energy_perf = epp;
>> +
>> +     ret = cppc_set_auto_sel(cpu, auto_sel);
>> +     if (ret) {
>> +             pr_warn("failed to set auto_sel for cpu:%d (%d)\n", 
>> cpu, ret);
>> +             return ret;
>
> Looks like a case that you didn't unlock the mutex.

ACK.

>
>> +     }
>> +     cpu_data->perf_caps.auto_sel = auto_sel;
>> +
>> +out:
>> + mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
>> +     return ret;
>> +}
>> +
>> +static int cppc_cpufreq_update_autosel_mperf_ctrls(struct 
>> cpufreq_policy *policy, u32 min_p,
>> +                                                u32 max_p, bool 
>> update_reg, bool update_policy)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     pr_debug("cpu%d: curr max_perf:%u, curr min_perf:%u, new 
>> max_perf:%u, new min_perf:%u\n",
>> +              cpu, cpu_data->perf_ctrls.max_perf, 
>> cpu_data->perf_ctrls.min_perf, max_p, min_p);
>> +
>> +     ret = cppc_cpufreq_set_min_perf(policy, min_p, update_reg, 
>> update_policy);
>> +     if (ret) {
>> +             pr_debug("failed to set min_perf for cpu:%d (%d)\n", 
>> cpu, ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, max_p, update_reg, 
>> update_policy);
>> +     if (ret) {
>> +             pr_debug("failed to set max_perf for cpu:%d (%d)\n", 
>> cpu, ret);
>> +             return ret;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int cppc_cpufreq_update_autosel_configs(struct cpufreq_policy 
>> *policy, int auto_sel,
>> +                                            u32 epp, u32 min_perf, 
>> u32 max_perf,
>> +                                            bool update_reg, bool 
>> update_policy)
>> +{
>> +     int ret;
>> +
>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, 
>> max_perf,
>> +                                                   update_reg, 
>> update_policy);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_update_autosel_epp(policy, auto_sel, epp);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return 0;
>> +}
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>       unsigned int cpu = policy->cpu;
>> @@ -710,11 +799,28 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>
>> -     ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     if (cpu_data->perf_caps.auto_sel) {
>> +             ret = cppc_set_enable(cpu, true);
>> +             if (ret) {
>> +                     pr_err("Failed to enable CPPC on cpu%d (%d)\n", 
>> cpu, ret);
>> +                     goto out;
>> +             }
>> +
>> +             ret = cppc_cpufreq_update_autosel_configs(policy, true,
>> + CPPC_EPP_PERFORMANCE_PREF,
>> + caps->lowest_nonlinear_perf,
>> + caps->nominal_perf, true, false);
>> +             if (ret) {
>> +                     pr_debug("Failed to update autosel configs on 
>> CPU%d(%d)\n", cpu, ret);
>> +                     goto out;
>> +             }
>> +     } else {
>> +             ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>> ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>       }
>>
>>       cppc_cpufreq_cpu_fie_init(policy);
>> @@ -736,6 +842,13 @@ static void cppc_cpufreq_cpu_exit(struct 
>> cpufreq_policy *policy)
>>
>>       cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
>>
>> +     if (cpu_data->perf_caps.auto_sel) {
>> +             ret = cppc_cpufreq_update_autosel_epp(policy, false,
>> + CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>> +             if (ret)
>> +                     return;
>> +     }
>> +
>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>       if (ret)
>>               pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> @@ -920,17 +1033,10 @@ static ssize_t store_auto_select(struct 
>> cpufreq_policy *policy,
>>        * On enabling auto_select: set min/max_perf register and 
>> update policy.
>>        * On disabling auto_select: update only policy.
>>        */
>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg, 
>> true);
>> -     if (ret) {
>> -             pr_warn("failed to %s update min policy for cpu:%d 
>> (%d)\n",
>> -                     val > 0 ? "set min_perf and" : "", cpu, ret);
>> -             return ret;
>> -     }
>> -
>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg, 
>> true);
>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf, 
>> max_perf, update_reg, true);
>>       if (ret) {
>> -             pr_warn("failed to %s update max policy for cpu:%d 
>> (%d)\n",
>> -                     val > 0 ? "set max_perf and" : "", cpu, ret);
>> +             pr_warn("failed to %s update policy for cpu:%d (%d)\n",
>> +                     val > 0 ? "set min/max_perf and" : "", cpu, ret);
>>               return ret;
>>       }
>>
>> @@ -1139,13 +1245,44 @@ static struct cpufreq_driver 
>> cppc_cpufreq_driver = {
>>       .name = "cppc_cpufreq",
>>   };
>>
>> +static void cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 
>> epp)
>> +{
>> +     int cpu, ret;
>> +
>> +     for_each_present_cpu(cpu) {
>> +             ret = cppc_set_epp(cpu, epp);
>> +             if (ret)
>> +                     pr_debug("failed to set energy_perf for cpu:%d 
>> (%d)\n", cpu, ret);
>> +
>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>> +             if (ret)
>> +                     pr_debug("failed to set auto_sel for cpu:%d 
>> (%d)\n", cpu, ret);
>> +     }
>> +}
>> +
>>   static int __init cppc_cpufreq_init(void)
>>   {
>> +     bool auto_sel;
>>       int ret;
>>
>>       if (!acpi_cpc_valid())
>>               return -ENODEV;
>>
>> +     if (auto_sel_mode) {
>> +             /*
>> +              * Check if autonomous selection is supported by 
>> testing CPU 0.
>> +              * If supported, enable autonomous mode on all CPUs.
>> +              */
>> +             ret = cppc_get_auto_sel(0, &auto_sel);
>> +             if (!ret) {
>> +                     pr_info("Enabling autonomous mode on all CPUs\n");
>> +                     cppc_cpufreq_set_epp_autosel_allcpus(true, 
>> CPPC_EPP_PERFORMANCE_PREF);
>> +             } else {
>> +                     pr_warn("Autonomous selection not supported, 
>> disabling auto_sel_mode\n");
>> +                     auto_sel_mode = false;
>> +             }
>> +     }
>> +
>>       cppc_freq_invariance_init();
>>       populate_efficiency_class();
>>
>> @@ -1160,8 +1297,12 @@ static void __exit cppc_cpufreq_exit(void)
>>   {
>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>       cppc_freq_invariance_exit();
>> +     auto_sel_mode = 0;
>>   }
>>
>> +module_param(auto_sel_mode, bool, 0000);
>> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level 
>> Selection");
>
> Why default to disabled?  As a precaution?  We enable EPP by default in
> the *-pstate drivers if the hardware supports it, I would think it makes
> sense here too.
>

Kept disabled by default both as precaution and to enable it based on 
preference.
Someone may want to try different config values during bringup, 
verification etc.

Thank you,
Sumit Gupta

>> +
>>   module_exit(cppc_cpufreq_exit);
>>   MODULE_AUTHOR("Ashwin Chaugule");
>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ 
>> spec");
>

