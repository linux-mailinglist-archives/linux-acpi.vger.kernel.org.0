Return-Path: <linux-acpi+bounces-20604-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8UFpN2ssdWlTBgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20604-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:32:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E967EE67
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FBE3009514
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C821FF2E;
	Sat, 24 Jan 2026 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImymtVTr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E11373;
	Sat, 24 Jan 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769286760; cv=fail; b=cihAYLVW63VGAF9sFreDqeeMpYE6ZwyShKe9z++fwI026J+fBA/e4y9vdV5FhTyO2OorEykQCTcweyPZL9mQuOSJrIngUcva6gRTdXmxWXZV5Gkc4K+MVmRIiCBgXDZnLzhVgFgbGtPTYe13kggTv1cdQ7Th/L50les0AKhHu7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769286760; c=relaxed/simple;
	bh=d3LocIHtUZtMDAJ3yuN5wc8W7oFLmPN4l6oqO1mHxw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IW8CeDCYclbzGOMxCiv4Ny+lJgB91M8tOWzxfoiJSbThtkiDdA51MfYxIn9H7p8gZheiSJavqzrAQbkxp8j+pZui7pUUF0lvptdmUGmcTzu8pp/rJlzruC6Md/s5YGWOArFRbfRCVDzoHk25l1u8SiW366hGIWHxsiRHT0AJkk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImymtVTr; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO0fwqg60y0mT7KbCW7x+4iUXqr3n5C8gI3RED7MI+E8/BhaU36pk0NQMi0ZyU2PPEpoM+MfRU9AHtabzrY8ReTJqDORFBW0seqLaNRTzCADW81DsT/q5toYcH18tEcL1uUzGphDhTi2QMbwMEozFCBUevS2a0QKgCCQ4Dyf4sxS2o0LNQHllPbOMAJoIHW1owVxwnQadE1V3PtPrcocss3sV/DaXaSzS9irGT2zqu4ngxqmQ+sMdD+HLvzFQSjNvc7dNsz6KUzl7+ktzIED1DqhBZB8aQWNiSsDWbOFjHYq+PI9yUs3O7jah1rLBxagohTfkhlwYnh/XLFVCRynEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFGM5EREqp1sV/0KE1p4lC9xFJeCjLxV1993bUFRJs8=;
 b=a7Ox4DIN+t1e6DecTauEPlzUXCHwGwb6Ekc4EydmRFphhov2E3tLVIW4LN3WjtCfWa8JaaAAbLLp4nOv+eS2gTzjIedrvwZnE8hhRfUQKTFVxYuae34G6oS+PbZ5zGjDgeYGT4WQ1Wnlr94/r1iRtaiRsWSLMFD4R3BPn0YMBLmXC5b5FtN/By928H5bwsZUOy54mbUB3ipyk4EiF79Ir8om1hEU6pWa/aRSdM6IF46loD3hXaQazRkdbLhus9Ey75hVNsUU4PGu2kbe/AgIEZgZgFpTC7BtFnI+I/AnvHWHGnx1foeTYLE+ncfnVXiyKfauyXCJfD8FGwMOfj2exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFGM5EREqp1sV/0KE1p4lC9xFJeCjLxV1993bUFRJs8=;
 b=ImymtVTr/Wb4urPY+gGsQj7GbHQDaZWRLqHQhsln85cwgvOTeIkVBnOTGJhOQz/v7Jpr3y8KSud9W6Ckygao23AdY9fylljsywnOq3QdOK9iGGVU5fJEuiQjUqHR/OQoIgqQCV5nPAO6uCRT1fOsjaSY+E4mfXpDRltW1afQ4kIfQflGoGUk2gEIyVhW2zJ617S56Ibweq0QMIQQqYgW4khdGrmPnqA1zi1xQw/uO/11Gi3yWArK5kY7hBGOpx+PxBu0FMBcR8LOa7FpZyKB7qbH8j24+lA5bgS976fHW3SRhm0qEUO38TUk1LbEhPdGhZl/blnO+hxpgd3Ti8dDpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 20:32:35 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 20:32:35 +0000
Message-ID: <2ce31807-bf89-4c79-82d0-31a5cda2a6a5@nvidia.com>
Date: Sun, 25 Jan 2026 02:02:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-7-sumitg@nvidia.com>
 <b68a4273-ad39-4d3e-a556-1b409b50944d@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b68a4273-ad39-4d3e-a556-1b409b50944d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e70e57-40d5-4d94-3bf9-08de5b87b500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFBFUHlRMGxnM0UycHpMY0RhQWhSeWF6NjI2S2xGMk82c2hRTUV4UHNHcEU0?=
 =?utf-8?B?SWY2ckFFK1lFbVhrdkpPMk55RklDbFpNbk5nUHFoNUxwdVAxL3RLbmhHaDFG?=
 =?utf-8?B?OEVnckg0RHA0VS9uc1FINlZxRmZkL2RqNU9YM2lxbVFMMzl2cHg3MGVNenpm?=
 =?utf-8?B?ZWxGTXV0WEdjRjc4RE0yWEtuTW9PSEJnQXIwb09VQUgwbE5FZ0hKUWNKSTEv?=
 =?utf-8?B?QlNOK2U3ZEczdmljWkRTZmd2U3VkSUFhZmx6WUhFczVrL1VaTTYrWE5QNHhN?=
 =?utf-8?B?WFJpa0JYbkN6VHNsS0ZUNFc5WFNRWlpkcHFZUlZFT0V5dzQ3WlZEQzNLbXIv?=
 =?utf-8?B?d0p3aDB6c2NqMlVqUk11RVpTL0c2dlFXL2g0Y0pjeSszKytxMEZPRUFkYVps?=
 =?utf-8?B?ZkZVQ3d4cHd1cTZZMTJSVndmKzYwMDJ4RDdaWnFiYld2ZzJva2VLTUJHV29N?=
 =?utf-8?B?clR4ZVFENlA4UDhoSUlqZ1JRbmVxTjZ3NDZmMElVQ3hXQUJ5VWIxaDhoVVVT?=
 =?utf-8?B?VnZmSGp0cjBzRXY4V3kwbWc5ZXlkamRMM2lTaDhKbUI2Vmpya1loWGpCZ2Ni?=
 =?utf-8?B?VUIxY25qbjlLNGZqZE9zMW94T0RzMExTM1E4RlN2em1ocTNFWEQwaXdWWm5F?=
 =?utf-8?B?T0VuK2lXV01XTFRJeVhmNnBRUEgrbEtRaUU2THpSQWpJRFpPelQ5cEEvaXRu?=
 =?utf-8?B?NVBmbUZPeEdsWDlTRnd0Qmloc1dlbXQ2dlV2bU5uU1pGcUx2WFRVenBodllK?=
 =?utf-8?B?SWlzaU5ZOHFwY2hmSmNxemc3alU0ZnBBa2ROUlovNnM4MFNkdnRRNkJGM0FJ?=
 =?utf-8?B?Q0tIcHA3QkEzcDRoVVVxdlR4VkJVR3pTK1pWWUw1djcyeG9HcjNVNzJxb0Mw?=
 =?utf-8?B?U21kWGtUTWxmSjMzWlpsajQ3eFQ2MFp0bWwvbm5lcEVpbDJLb2lXZkxJdDVS?=
 =?utf-8?B?dHR5ZDByamVHUzY0bityNXY4MkU2WFJEcU04NXRNQ1dNWjI0aHRRT21xcmd3?=
 =?utf-8?B?Z0JOeldaSFhZRnM3ZkxwbEtWVWthMmtHYkxGcFdjQU9oQTcrcTlSOXRqZDNZ?=
 =?utf-8?B?WGloSnUvWVFWRk4vYnFCM0JBandFdThTR20vaXA5c1dTU3RvZ3pkV2tmanZ3?=
 =?utf-8?B?TjlFcThVYXRyTzdWQm1kVTFtY25BQktBcWhBWXpQd1VOdXNPTGJUalpVTkdB?=
 =?utf-8?B?M0FFNmdicFJmZGQ1VGJyOU1zZDFFb0M4S1dqckxUYzlES21aNCtQSmYxclZH?=
 =?utf-8?B?Q09pMzR0eUZFRFZVUGJXWW0vVEZGNHJHZEc3QTA3VjhOZEJ2bERvNEJlTk9O?=
 =?utf-8?B?Z3N0VG9GOTk1WmZleHIzZFRCaEl6K1c3RDBjSmZWeVpKdzM4VnMycU9uVk4v?=
 =?utf-8?B?bHpvZklkS1N1VDNmQlFhKzg2bWNEalcyczFsREtSWUMxcW83R0ZzeE9sZndR?=
 =?utf-8?B?VmJMdzBhNFowVWRKU3c4VzlQdy93dXh3VUs3T01WK0NjTHcxUXRxUDNuY2p2?=
 =?utf-8?B?RzZIUjV5TnA3WkNHb05oRnNndytuNmYzSXVNbXhNdnNRRTNYcGxDc0g5Y0Q2?=
 =?utf-8?B?UmdudDNjT3VCWUJ4WDlZZjd4bWo1R01vQzA3djNMT0ZQZVFkdzZGUUc3WlU4?=
 =?utf-8?B?aUhscStLbWxmNWVLaWlEaUVvZDhac3hlLy9XRngzaUNYUW9qVjF5cWFQbGE2?=
 =?utf-8?B?UzhGZzYrWXk2bGF0MGZJVjlUcTF4UjF0NUVGakpYaFN1eVBZRlhCNHZBRCtD?=
 =?utf-8?B?VzdyY0ZWNHRNb0dmei9udDFBRVlGbmo3VERPbFQ5MU42eUJoM2I4VzYzUG9s?=
 =?utf-8?B?YTV6K0lqa2s2S2tMUHlaYXlnNGcvMDBaOXVVWmVoZGlpODZlZHo2MGd3bzVO?=
 =?utf-8?B?aFNVRmJGc09tak1oOElyZjFPTnpVbkxDcHRrN1lRekdlQ0U3c2pyUW1zSlFB?=
 =?utf-8?B?V2E3Ync2bnZGbmQzVDBVbGVqeXYwdlZJVHNVQ1kvU0tlZTd0K0VHaEwxdC9S?=
 =?utf-8?B?UDVkNE9WTXh5VTYvUDFBcHJUNDNQa0t4SDk5OC96V1IrK1FaeVo5cUF1VzBG?=
 =?utf-8?B?WDErRkFLNkE5MHcyTENQdEZIZGZVazE4RXp1Z2FKY09KS2FaOVNNdWY1SlpO?=
 =?utf-8?B?cWljK2dJVEdDc3lnbmorMnhhRnVzWlZxZVdsZFBGL1o0YlhoYmpaZTBtL2cx?=
 =?utf-8?B?Mmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZzdy9FaURsV2g1Q2JKbEdpYWlCZENxcWEyOWNhVUZaYktNMGxSell5Nmhu?=
 =?utf-8?B?aGZMMU16MlNJVVpxL2VIQ0FBRGxUaHFiNkVRdTlmZjh4Ny9zT2tEZ3pEbTAx?=
 =?utf-8?B?R0JDdHNZUC81MmJKblZoUXpncUk4TnZac254R1lFeTRDT2FYbDIzM2VISC8r?=
 =?utf-8?B?TVZpMEUzc3JQb3JhM1R6NUJWU3F3R24vNXAzSzR0QjBoaEdEczFwZkE3TzJj?=
 =?utf-8?B?dGE0UkZDeFlJK3o5MWlIOWFtSHBidEVPK2lxZDhUQkdTOEViYXdrdTArZm9R?=
 =?utf-8?B?UDZvcmtRRnR5bDBJMzV2U3BrODlWN1g0ckVqamw3R21pUEt0UFhsSlVNVUpi?=
 =?utf-8?B?a1BTVHR4RnN5SFMxKzg4djhrbjJDUUVlYTJTVHZzRFdZakM1SmVGcFVMOXpC?=
 =?utf-8?B?SGdNYWxKcFJSOGxmM2c0MmttdVJJNDl6Yy9qU1ZzVUhLN1d1aDZIcitXTDVH?=
 =?utf-8?B?L1lpVEpHYlRIMUZkcnJOdk55S3FEQVFVSHNxY1VhbXFoT2p2V0t0UnJZWlBW?=
 =?utf-8?B?cjhnSUUzK2NoRmhiRTJ5VWpvVko5K2U4czhjZ0t6Qi9iVjVjaGRKZTRaVldp?=
 =?utf-8?B?cFNzNWNTVWJ4TW9HMDNsL0lCVkZ0ODl0WVRkMHZMNUMvUXFDaWowNDhYaUp0?=
 =?utf-8?B?cy9mdmVOYTVyTUNnc0hEOWpjMk5BSFR5RThtTEs1Rno2eEw5cUlIbURML3Y5?=
 =?utf-8?B?MklLQnlLVThpWDQzUklaTkgvQUZpZXEwdmhzUzIvekhjMGIzZ092aHBBb0Jv?=
 =?utf-8?B?UG44Q3Z3RThSY3RaZEFJb3VkWHdKR004R1pYdXBQN2dkTE5lbVhBZXN6RFEx?=
 =?utf-8?B?N05xR2RWSTcvVVZldW5FM3Q4aDYwa2kwajUyODk3T3dJelI2MExaSzN0RVNH?=
 =?utf-8?B?UGx6M1dZc1FPU0JvWTZEczhZRCsvOGJ6TzBqZmJZenp6ckUwOW5CVWRVQjhV?=
 =?utf-8?B?N2RBKzhqbTBvcGxyeGsyaER6OW5keVlRcU1qVyt0MHM3SHNXaEdqMDVXVXlq?=
 =?utf-8?B?MTFpOGp0c0hIMTlpcHVMTEVZVG9FWmwzVWtmS3ErZGFJd0V0WENuaVVTaUFx?=
 =?utf-8?B?bHhzZVV0MTlQZklwbnNzVVgvVGVLMDVaTHJjNHNWeW5ySk9jN29vSzRyYVBp?=
 =?utf-8?B?R01FK0xtdGNqcGxTbzJmbjFLaXpQalBpOEZ5bStISHA5bElBZjBhWTBSdnpE?=
 =?utf-8?B?YUFMYy9WUU5uUlFqV1ZQWVdway9WY2JsOWU4cnFaREQ1ZnBHK2VlcjAvbHFK?=
 =?utf-8?B?NHNtLzdBUk1XUjRwaHpvUFBYbHlIZFFQNkhzT0lOZFY5T3JhU0ZaQlQ5ZTYx?=
 =?utf-8?B?UzNBaCtXVTJtZ3BBRnJ0d3ZFV2JBTDlpKzI5cnVYMEEwb1phTXdVakllWWJY?=
 =?utf-8?B?TFhualhMMUpPVjVqVktoS0prVHgvUDl0RkpoVFc3eVNVaTNQYWFyMThESzky?=
 =?utf-8?B?SDFiRTlaUjdBM3VGd1E1MGRscWZpT1cralphcCtidWJKK0k1ejg3RFBaUmlB?=
 =?utf-8?B?NTdxd0dTdElkMmNqNWQ1Sm93b2hpckZraWVPdHZKQS92V1dUaVk3N2Q1VTBN?=
 =?utf-8?B?OExUbldjMWlpVlIwaisxMWQ4ZVhDcnBmTUdKT0VoM2lQalNxK2RORllwaWNl?=
 =?utf-8?B?NTBlNnZvdzBLUlNya3U1cW0zdUgzZDd0YTZZRlFCdE91aVFHWmpXM1BNVHJl?=
 =?utf-8?B?Z0RZK3RJY1JHU010Sis3RndsWXMyKzAzL2l6Mjc4YTBsVnFLaC9Ma21GVFU0?=
 =?utf-8?B?NzdhSHFPY01LU24zRE53UHRsVXFWckdER1cyQ3NuSTVNSXdybHBFTGFRS0lI?=
 =?utf-8?B?MGJQVTJsUmpSazErcCtOcUVEc0R6T1Q2TDNmekpQN2Q2OWFXSkxReWttTHZ6?=
 =?utf-8?B?S1Q1MkI1b0F1RUF6ek5mUTRCRThPSEN1MXd1aDB1aURpY2tIZlVvN2JUUUEy?=
 =?utf-8?B?SVJ0bDhxWmdsV0VGT0VFZllpSVFoaXVQSTBEQ2d3emZGZWZaUWdSemJPRjRZ?=
 =?utf-8?B?cklQTVYxSTdOQzlLTy9QSEhlb0wvcTQyN2RONUZHZHkyR0JXNVJLdW9LTnZr?=
 =?utf-8?B?YUJRUHlZcGlOOXNzTG5BZUpjdGs4VDRWV2lWYTJCOEFSZENrQW0vdjIxWjkw?=
 =?utf-8?B?ZG5xbnZzR25QV0cyWkJCcEY0YU9hNlU2WXBaemF6dUlDM1JOWlk4aHBuZXJu?=
 =?utf-8?B?UXhmZ1VuSWV0RGhXcmZka08rRXNiT0hzeEVsTDVvZnNpenhtdEpXS3pCcWh4?=
 =?utf-8?B?WWc1elJ3OUtTYndyRlNtR1M2MjRoSGNHTlUzSVFnUE93bkpCV0Z2d3IxaU1M?=
 =?utf-8?Q?jmw+uderaeGOVRRm1x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e70e57-40d5-4d94-3bf9-08de5b87b500
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 20:32:35.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZbxrWmyEJWpTnPJbFu9D827x7c1snQaHKtfkXWajtM/1SMktbvIJl1ge4zLC1ZR87+44+0oGXGG289z9ehUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20604-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 16E967EE67
X-Rspamd-Action: no action


On 22/01/26 17:06, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 1/20/26 15:56, Sumit Gupta wrote:
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
>>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h       |  20 +++++
>>   3 files changed, 221 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 45c6bd6ec24b..46bf45f8b0f3 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>
>> +/**
>> + * cppc_get_min_perf - Read minimum performance register.
>> + * @cpu: CPU from which to read register.
>> + * @min_perf: Return address.
>> + */
>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
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
>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
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
>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
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
>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>> +
>>   /**
>>    * cppc_set_enable - Set to enable CPPC on the processor by writing 
>> the
>>    * Continuous Performance Control package EnableRegister field.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 229880c4eedb..66e183b45fb0 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,8 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
>> +
>
> Shouldn't concurrent access be handled by the policy->rwsem ?
>
> I think this can be checked using either:
> - lockdep_assert_held_write(&policy->rwsem)
> - lockdep_assert_held_read(&policy->rwsem)
>
> in store/show_max_perf() for instance.
>

You're right. The cpufreq sysfs already holds policy->rwsem for
show/store callbacks. I'll remove the mutex and add lockdep
assertions for the expected locking.
--------
File: drivers/cpufreq/cpufreq.c
   static ssize_t store(struct kobject *kobj, struct attribute *attr,
                      const char *buf, size_t count)
   {
       struct cpufreq_policy *policy = to_policy(kobj);
       ....
       guard(cpufreq_policy_write)(policy);
--------

Thank you,
Sumit Gupta


>
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>       FIE_UNSET = -1,
>> @@ -570,6 +572,35 @@ static void populate_efficiency_class(void)
>>   }
>>   #endif
>>
>> +/* Set min/max performance HW register and cache the value */
>> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
>> +                                   u64 val, bool is_min)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     unsigned int cpu = policy->cpu;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>> +
>> +     ret = is_min ? cppc_set_min_perf(cpu, perf) :
>> +                    cppc_set_max_perf(cpu, perf);
>> +     if (ret) {
>> +             if (ret != -EOPNOTSUPP)
>> +                     pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
>> +                             cpu, is_min ? "min" : "max", perf, ret);
>> +             return ret;
>> +     }
>> +
>> +     if (is_min)
>> +             cpu_data->perf_ctrls.min_perf = perf;
>> +     else
>> +             cpu_data->perf_ctrls.max_perf = perf;
>> +
>> +     return 0;
>> +}
>> +
>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int 
>> cpu)
>>   {
>>       struct cppc_cpudata *cpu_data;
>> @@ -918,16 +949,142 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, 
>> cppc_get_auto_act_window,
>>   CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>>                        cppc_get_epp_perf, cppc_set_epp)
>>
>> +/**
>> + * show_min_perf - Show minimum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + *
>> + * Reads the MIN_PERF register and converts the performance value to
>> + * frequency (kHz).
>> + */
>> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_min_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Use lowest_perf if register is uninitialized (0) */
>> +     if (perf == 0)
>> +             perf = caps->lowest_perf;
>> +
>> +     /* Convert performance to frequency (kHz) for user */
>> +     return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
>> +}
>> +
>> +/**
>> + * store_min_perf - Set minimum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer containing the frequency value
>> + * @count: size of @buf
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MIN_PERF register.
>> + */
>> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const 
>> char *buf,
>> +                           size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     guard(mutex)(&cppc_cpufreq_autonomous_lock);
>> +     ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>> +/**
>> + * show_max_perf - Show maximum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + *
>> + * Reads the MAX_PERF register and converts the performance value to
>> + * frequency (kHz).
>> + */
>> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_max_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Use highest_perf if register is uninitialized or out of 
>> range */
>> +     if (perf == 0 || perf > caps->highest_perf)
>> +             perf = caps->highest_perf;
>> +
>> +     /* Convert performance to frequency (kHz) for user */
>> +     return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
>> +}
>> +
>> +/**
>> + * store_max_perf - Set maximum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer containing the frequency value
>> + * @count: size of @buf
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MAX_PERF register.
>> + */
>> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const 
>> char *buf,
>> +                           size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     guard(mutex)(&cppc_cpufreq_autonomous_lock);
>> +     ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>> +cpufreq_freq_attr_rw(min_perf);
>> +cpufreq_freq_attr_rw(max_perf);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &freqdomain_cpus,
>>       &auto_select,
>>       &auto_act_window,
>>       &energy_performance_preference_val,
>> +     &min_perf,
>> +     &max_perf,
>>       NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 3fc796c0d902..b358440cd0e2 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 
>> *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>> +extern int cppc_set_min_perf(int cpu, u32 min_perf);
>> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>> +extern int cppc_set_max_perf(int cpu, u32 max_perf);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 
>> *numerator);
>>   extern int amd_detect_prefcore(bool *detected);
>> @@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, 
>> bool enable)
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_min_perf(int cpu, u32 min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_max_perf(int cpu, u32 max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 
>> *highest_perf)
>>   {
>>       return -ENODEV;

