Return-Path: <linux-acpi+bounces-20605-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACNnGwsxdWmrBwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20605-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:52:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116497EF75
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215D8300CC29
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7683225A3D;
	Sat, 24 Jan 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fV+v6Ial"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA761391;
	Sat, 24 Jan 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769287941; cv=fail; b=Siw341EehCuPWc4zb/EFNl1e/vpVoILC5/RBMnyZIZeJ85DNVm9BjIc8+/hs/sXlkv+8JgBtlGFDpVme+yUylaq+1n/GtfQ7dlbuzDhiXP7+P9ElbDpJV3ShfXLOZYBtEjjh4+1T6NZV356P4XtIqXpzQXHVYu3mhA3zEM+3Tx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769287941; c=relaxed/simple;
	bh=j73f5wD8B9j2RHE295zjPmE3KH9/DuqdAqmJxryGRJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BlxbMtLW7anf93iZYP7fi65hhD2S6ppyrk9pOGAOnVnYwLEh6x1+d+xoWFlVN3zgjByEPJAR8aZHguLZqVMLE2atgSemUhgfQbP1HfE/XNqoNnEZpz0tDWSddf+YZ+vXLDUN0B900JKx1xbipi7kQo/kaLjYuBe4nQvrtDShVr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fV+v6Ial; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iir5nOlPSpvd2XEVx2N6yp9ZtD6di2od8/EXIIXuuDC+d5Kps7UKW2t77Ig3fnI0likwS47/3DuDyju0gUCpiHziHdtBRG9ms2Kjww/1KotJEcwgemRZ6Y0IZEcp2Za02Om6NZ7nNkwQIiVDmojVsB8ktr4XtN4PT5Cxh6xU+ggjZ4noAWi4bkHncDNiPCbHT4v81XMiG51bwr8lB0tAXMQYVZ2O/URTZBciSerreQt7771o9Awl1oE4awBqpuHXGG8GdCd5XnNhvGE1CAPiV/VUvU3Wd6hvqaQfVzl3SIbyEqsQmOCRv8wlZo13DwjGIbEAH18Fkryt8mxZ2w7BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs+ksI2Spxji4pslUiCXn6siGezN0g99UVXvXePm1LY=;
 b=dO29M6iPhL3BVfLL8I9qWT3vYYqxJsw8y14ZX1OcuVP0B6YYtZICcElSpAlCjZVGC9+9l5GmsRRPmf+UuRRnfg5cbOi/QiQ0N4epDJ+Ezt4n70b7VPxku4aNDj1QEGwFhrcrsjgHbzDDic4QWStamoSAaT6npixmrB8m26CYo+Hp6iPJ49JQsQPu7RBhz8KkyAUthVQIBkLjms+/PqXPcQb7fqX6qFqhF1zvsNr4xBqwt3NEKfKSTL8MRMbLhPKcKSuri69Kr3tUhpq7LTk1BDiI0zeOw/H5kWa3kl8omqbr2atRd8DliWi4v7SNDcoax0r1GHQzNB/I/sTRMlB7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs+ksI2Spxji4pslUiCXn6siGezN0g99UVXvXePm1LY=;
 b=fV+v6IalUyR92J90a4XaAm5C2JUNhcawoUt6aEBLeF5sNz9xu65pkyZAILJv6x5+ddlUzTdrfyRiZ1UAm6Mf30xUcvpwDiveTYvYtykFtU6DkD6DTJnKRMmRlta0JXCh+iBWEhPp4dpncSoH0U0T5MTxJeOv0vfVCKCrYF3APekbFf1VjTyOIFVtrYJsTg3hSXAsSI3sRy3PFp79BYXq6pSpPlD4Y+68FQwXufXTjl/ngqvDH0Mc/feHZ6VKsmvqnYxQcAKCsCUjF/5a/oe178mq5izpvurmB2QQzwgZdA3x5pIpqTQIQPSlTDezVMTwy91wWGNXZEQ3ULrb/h+V3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 20:52:16 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 20:52:16 +0000
Message-ID: <bc107957-dd07-4e12-8c54-57b2f40e9d94@nvidia.com>
Date: Sun, 25 Jan 2026 02:22:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
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
 <20260120145623.2959636-7-sumitg@nvidia.com>
 <c4a655ac-8674-45fe-8eb5-a0513d3b9bdd@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c4a655ac-8674-45fe-8eb5-a0513d3b9bdd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0270.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::8) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b98d0c9-8a72-45f3-7565-08de5b8a7533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdVOHBGamFkSWVDQmd0K2ZwZzJ6SkY1N3QrQ3BUZ2Z1SkJMZGwvZkVvQWR6?=
 =?utf-8?B?US9TS3FVbTEwVDVPZ2IwYjZzWDZPZVBBV2pRczJRLzRFay90SGxVT3RYUmQ2?=
 =?utf-8?B?dmFsaFlIWVIrTWJkZjgyMlRDR3RKbW9FTmtBRUJ4cStBekdXQ0w0YStZSGpY?=
 =?utf-8?B?VDZJck1uckpSVW44R0RicWNXd2ltai9DemZ0dUptdnVOVDRKcmR3YmgyajJt?=
 =?utf-8?B?WUxsSTh3aldMOEp6Q3RTbjEzazVMc0VUbkZyNitYbno4NUszNVhpU2RrRXFt?=
 =?utf-8?B?S1k1Y1ZzZnJIYXlIT1VOcXdzWVhjV1FrZWNVNFVPdFM2N2N4bElucURsKy8y?=
 =?utf-8?B?SDRsSmVZTWJHY29tclNuVk82czdwaUdVOHR3eGFsQmE4TXVrZWUwOVpkdWly?=
 =?utf-8?B?Qjd6eG9kdjNmNUd1bFlkSEZDSjBveE01R0J2bmwzNmljRVdpejgyT3RZOUpH?=
 =?utf-8?B?YUcyUENmbUgzNXIrblZPbHh6eTc2bm0rUjJkOGh4RTVtMGdjbHQyTm1LazNt?=
 =?utf-8?B?WmpOenY4TXliWVJQeVV2UFA0Q2FwNGxMOWVzc3ZzbzdxNU1FbWx6VnQwOFU3?=
 =?utf-8?B?dWJCY1hhdU0wT2xINkNoTzZrS1NESjhpUzZYSmRSd1ZpdFdyaWduZXpDNGts?=
 =?utf-8?B?UU8xWTA1TXAvTkxRTTkzMERUeld0cldiaGVBZ2RuL0h1aDJXakhkQU10dHh2?=
 =?utf-8?B?U29kaGs0azdxenByWU5WcndXbGJoZXE2STk3ZVZqWDVFSHJqTUxRS2o4VWhE?=
 =?utf-8?B?dS9NcFhSdDM5UmpzZEhaZG1kc3Y3akdiOEZkOTBBYUNWSno2dXZmelhWaVBU?=
 =?utf-8?B?aVZraWVUclpkVTg2cUVyTHZ2a3FTTitPSDFleWgrcGFLenBvejlpQmtMWmRu?=
 =?utf-8?B?WWxoeWpkVnZJUllrVENBQVUvZENhK254ZDRTcFFhQXRDaHMxMEdXRnZ0YW1J?=
 =?utf-8?B?cnAzOExDMUVpNjFJWWZMYnpubEl1aEtROWpsU2I2SGkwckp5UHhMN2xEVVV2?=
 =?utf-8?B?eVlzK1VkcWdiZ1ZObGpLd1orV04wSnVhNHZsenFkOGJOcHJKcHNWd0VsdXMy?=
 =?utf-8?B?MVV3Zm5FcHdOUFloeFhRQlpUWVpwZHVlUFRxVlhzUWVFV1VaSDR0Y0sxMVdy?=
 =?utf-8?B?aHNhdk42Nk1YYXh3YVlSZTF1N2FCMWhmaXhValhiTnBpM29wcG5MNFVqQ05l?=
 =?utf-8?B?NzZHVFl4SkJpYVQyWC8rZFY4YnpFRXo3V0F2ZkMxUGt6OE83c1lkT0RpVzJ5?=
 =?utf-8?B?dkRIZ3E0cFJjRnU5anRaaGRQak54cXQ0YlVFUVYrMzI4MzlXMS8rak55MnQz?=
 =?utf-8?B?bzVNWnA5NXVnQnNwcVZRaGU5SnZNKzhmMWFFdjEyNUlUZWlmbVdwODROaFRn?=
 =?utf-8?B?aHFMQnNudkRVOHBJZWpta1lXUkJqa3NqL3FCUGkyM3QvM3Jkak9xaWRDRFpD?=
 =?utf-8?B?dDZuWnl0U3dqRVNPNzM1c25hSnZiYUZ3UUxqSHVkcnN3VDlQMkF3eHRKL251?=
 =?utf-8?B?cCtoUFRxSjRkM3F5ays5bmxHejZwdnFVaHN6a0VrblZ5TU0vaTB1QzFpSzgr?=
 =?utf-8?B?clVhakx3dHRRYXNNbnlRYkpKakhnbHpCcWM0bTZEZnM5QVFsWlU4UWNNWkY2?=
 =?utf-8?B?ajFxakhHdzdtK1pjK0ZabjdDK1NPK2NiOENmeWFWNzYrd3ZpRDBhMWlKMjBU?=
 =?utf-8?B?SVBYRzJlOE03SnR6NGQ0Mk1xaUQzSGNvYkVRZTUvMEE0b1BSbkpmbjNFZjZT?=
 =?utf-8?B?Z20wVlVSdnllQWNFbC9JV1U4ZmJmVzFseWE3ejhreUJSWmkwZW9ZN2JGVitW?=
 =?utf-8?B?VDlLaDhJQWFEd3JadTF3NGZuM2YrQ2djMkNuZzNDdGRmaHpFUlNKMWY5b1dv?=
 =?utf-8?B?cXZQNnVodXlJcFEwaE9IM2drM0NYeXlaclhNYmZaa3VTNVc0UTZPVkwyZmZm?=
 =?utf-8?B?SCttU256Rm9nNWVEQ0IvNWxrWjQ2dGNGMkZkRjFFN3ZraW9CNVVQdlRFWFEy?=
 =?utf-8?B?OUVhakdMQ1JhL2NTZHh5eGpGL1RidnA0WkQ3RWVCTU8rOVZMYkg5QWFxN29Z?=
 =?utf-8?B?Z0EzYWJsZjlabmFMZW1KcW5WRERWMlNQWC8wWXlSZlExbFU0SU5KU0Nyc2tw?=
 =?utf-8?Q?YTVWFWDqGVsiRj6kJ7xpQ/gzg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDFqZitSWnc3aStuYkF6VnhmdTVIS3pURmNqaHRUU2I3enhxeWZHNTZXcHZ3?=
 =?utf-8?B?d2IvSGdVNzU2NnJwYWloV3RSR3I4b091K3NNVkFNZDl6dHNSWmZZbVBCMXRM?=
 =?utf-8?B?Z0RHcFo3MEgyZmpwemJTa3d2Lzd1VjN6MWx4c3ZuWWo4eGwzbTRLVzZndlRn?=
 =?utf-8?B?L21aSDg1WXpyVFV4ODVyMk1VOUIyN29nUG1FczgvY09GVWlJb2dvckpUWmR6?=
 =?utf-8?B?MFRzQXZ4ZzU3bGVEKzNSejdpWXhpYXJKdG5uSlRyamU3YmhhNWZUbjdBekxw?=
 =?utf-8?B?Y3Y5WFBUcjJPNjVaK2FmdUVpang2S2VWZzlCOFN4aFM3c2ZTZ3VCM3pQdll0?=
 =?utf-8?B?U2U1SGhnUXpKdkNRTFVidG1lVWJBQ2I4c1Jjc2NhMmpBSVNoREtSL01xcWR1?=
 =?utf-8?B?OWU3QkdRMjBtT0wzZlNFeXRCdURlVHNmRTA1b2hvNS9zU0ZheUk2RnA5WFkx?=
 =?utf-8?B?WWk2YXNrVmpORjkzd0RkM2hWQWxTRlJuVEVFbkZCdVg3bzk3ajVQZ28rUkpn?=
 =?utf-8?B?WGpRTWxUK1VIZ29nN3dvempQZkJFeUwwcE1aN3ZZenNmQmNpTEIvNmhFeW93?=
 =?utf-8?B?WHJYeTI2SHcxSWxSWHExcCs2NXlTem8rTzRPZnIvbk4rTU1nWVZLUE11Sk5I?=
 =?utf-8?B?eFRUQjdOMGY4dVdXYUpGUzBmY3QzdGJHRUlWcFNTRUtQejQwYUdhaklZeFJJ?=
 =?utf-8?B?bzY3Z0gwUURVL1RjdTlQK2xBSUpWUUM3R2pwOE5adVRjUG5iUFNuY1JNSnYz?=
 =?utf-8?B?bjJNYnJFK2lYTVpRa1FrVkp5ajVaMzR3WTVXS0NsNU5WNjYyUGwxNnZacW9p?=
 =?utf-8?B?dUlCaUZ2cC9LaGZXNmM2YUZOb0M4ZU9hWXBlR0NldXlpeXR2QWwweDM2aEkz?=
 =?utf-8?B?NnRDdU9MSk9vcDI5cmZ3dG5hcmN3QUNHcW1hU0F2SEtNMDR5ZHNSbmltMnZp?=
 =?utf-8?B?SmRPdmkrNkh5QVZWTVo5RUY2UDBteE5abG5Bb3pYNjNZd2xPYm13Nk5jRE4v?=
 =?utf-8?B?dEMzL1FZQi9hSWV0ZUpqZTVJYmpydHJKdER2a1Nsc1N6bVdtM3lDM2hIcVZG?=
 =?utf-8?B?TFhwbVJOeGgzandDRzMyK1BSK0FZMzVFUFduWVlFejZDNDZUZHJYOW56SmxL?=
 =?utf-8?B?VFJWQnJNNHVhek5UUHlUSUM0NXpERXEvdGhXeExEbHJOb0tVcGpTVWsrNGdZ?=
 =?utf-8?B?LzZOamg3SjZvQUF0dUNHT2VONmw4NzFQUnhLeHhydGNuYW5GV05wdTJVWVZm?=
 =?utf-8?B?bmZvR1JPS3I1b1Fuc2FmSkZFclAzdEVjeEcvc21EVHVYbEJrcXQwNDIyNno3?=
 =?utf-8?B?eE0xbnM5MGtUbzcwbWdrV1BQOVpGWXh4clR3bldFcjgyK1kvOHlyOElCL3Zk?=
 =?utf-8?B?NVU5UmljelRFSncyQTMvSlJHRTk2Z3AxMUxXUXlTYkE2UmVZLzNZYVpMSWk5?=
 =?utf-8?B?dDBCNDlPa29ZSFExN01qUnkzZkJqNituTGxUVVZzM1ZFNk4xVmRVbDgxNHhw?=
 =?utf-8?B?TTUrcVlBa1BWcE5RNFcvZGg0dU04NE90NlljTUtwd3o4MjNCSTNnS0xWM1ZF?=
 =?utf-8?B?MENad3Z1SFFpQnZaM1BsR2E5czdnOUlLeGhVTnowL1Evd21IUlU3cW4vc0Fp?=
 =?utf-8?B?MUxwYUgxbzJoOVF4dGZaT3NNRkRUOHhOWW8xWGNNb0JXRzlsUW94amxrZmFz?=
 =?utf-8?B?N0YrSE1YT2V1cU1PSFZ0Q0k1M3hNaWcrYUg3aytKMS9DcTYyeEVIQXE5Y28y?=
 =?utf-8?B?aWE3OVZ4cGtZQmo3STJSZ09VN0VyQlhicTdnWlRZdEVuVkcxRHcwc1pRNUta?=
 =?utf-8?B?UERSeDdia2c5UUZnYmpBdVk2dlowZXhNQmZtcHJZWHdQYUNMSnlvK0Jzakpw?=
 =?utf-8?B?VnBEaGlqR200Ykd3TCt1NWJWcjFvd3ljWm4rVmlId0ZIVi9rYk1nRzQyRU4y?=
 =?utf-8?B?aFVFMjhsNnR3NHRiUTNJTjFyZ21POXFVdzhqS2RxTjNFQWxVL01jVnlUSGQ3?=
 =?utf-8?B?K0ZpQlhzSS9FeEw5ZFZsMnQvU2MySVZLUWc1eDVUdW5oUVZQYTJyaC82bW1F?=
 =?utf-8?B?WjltVmFTNDR4NXo0VDI3dEpkbXNSWkZTMzdvdnV0cGFQY2tBUlRiNzVSRkVS?=
 =?utf-8?B?NkVEeFU5aU1ZbUUzUk4reU51d1p3NmxsUnZyS3FZVjF5Q3ZpcEJjNTZzbGc0?=
 =?utf-8?B?OStienBRdnZzKzZZYkNlR0RDcUJvOVJQU2pwTDNaYSthTVdyQUt5WjFSVlo2?=
 =?utf-8?B?VjFXR2FDZUV3SXNHZUVZd0l4c0czdm9NMHgwS3Z5UzgxTXBpNkRJQkwydzVs?=
 =?utf-8?Q?lTdvTGC7xY+4ZK2fwE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b98d0c9-8a72-45f3-7565-08de5b8a7533
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 20:52:16.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDYOeeCrcG4HLnon/ynJgazlm/AELW8cLIHuZrgz4z7yI3wgVfmEeVLHExOFF/Mk3vq4rl8moD6N2/PWDiZplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20605-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 116497EF75
X-Rspamd-Action: no action


On 22/01/26 18:05, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2026/1/20 22:56, Sumit Gupta wrote:
>> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
>> write the MIN_PERF and MAX_PERF registers.
>>
>> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
>> to expose these controls to userspace. The sysfs values are in frequency
>> (kHz) for consistency with other cpufreq sysfs files.
>>
>> A mutex is used to serialize sysfs store operations to ensure hardware
>> register writes and perf_ctrls updates are atomic.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h       |  20 +++++
>>   3 files changed, 221 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 45c6bd6ec24b..46bf45f8b0f3 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>
>> +/**
>> + * cppc_get_min_perf - Read minimum performance register.
>> + * @cpu: CPU from which to read register.
>> + * @min_perf: Return address.
>> + */
>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
>> +
>> +/**
>> + * cppc_set_min_perf - Write minimum performance register.
>> + * @cpu: CPU to which to write register.
>> + * @min_perf: the desired minimum performance value to be updated.
>> + */
>> +int cppc_set_min_perf(int cpu, u32 min_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> ACPI spec says it 'must be set to a value that is less than or equal to
> that specified by the Maximum Performance Register'. So it may be better
> to check it before setting value.

Yes, I added that check in v1[1]. But missed adding it in later versions.
Will add below check in v7. Thank you for pointing.
--------
   static ssize_t store_min_perf(struct cpufreq_policy *policy, const 
char *buf,
                               size_t count)
   {
         .....
         /* Convert frequency (kHz) to performance value */
         perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);

+       if (perf > cpu_data->perf_ctrls.max_perf)
+               return -EINVAL;
--------
[1] https://lore.kernel.org/lkml/20250211103737.447704-4-sumitg@nvidia.com/

>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
>> +
>> +/**
>> + * cppc_get_max_perf - Read maximum performance register.
>> + * @cpu: CPU from which to read register.
>> + * @max_perf: Return address.
>> + */
>> +int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
>> +
>> +/**
>> + * cppc_set_max_perf - Write maximum performance register.
>> + * @cpu: CPU to which to write register.
>> + * @max_perf: the desired maximum performance value to be updated.
>> + */
>> +int cppc_set_max_perf(int cpu, u32 max_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>> +
>>   /**
>>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>>    * Continuous Performance Control package EnableRegister field.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 229880c4eedb..66e183b45fb0 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,8 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -570,6 +572,35 @@ static void populate_efficiency_class(void)
>>   }
>>   #endif
>>
>> +/* Set min/max performance HW register and cache the value */
>> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
>> +                                   u64 val, bool is_min)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     unsigned int cpu = policy->cpu;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>> +
>> +     ret = is_min ? cppc_set_min_perf(cpu, perf) :
>> +                    cppc_set_max_perf(cpu, perf);
>> +     if (ret) {
>> +             if (ret != -EOPNOTSUPP)
>> +                     pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
>> +                             cpu, is_min ? "min" : "max", perf, ret);
>> +             return ret;
>> +     }
>> +
>> +     if (is_min)
>> +             cpu_data->perf_ctrls.min_perf = perf;
>> +     else
>> +             cpu_data->perf_ctrls.max_perf = perf;
>> +
>> +     return 0;
> I think cppc_set_XXX and updating cpudata->perf_ctrls.XXX can be extract
> out for not only min_perf and max_perf but also auto_sel and energy_perf
> and anything else in perf_ctrls.

Updating cached value of auto_sel and energy_perf in patch 9.
I think the current code is simple. Adding an abstraction seems to be
overdoing it for this case.

Thank you,
Sumit Gupta

....



