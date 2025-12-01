Return-Path: <linux-acpi+bounces-19369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF49C97C63
	for <lists+linux-acpi@lfdr.de>; Mon, 01 Dec 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A728C3A3293
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Dec 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE333195EF;
	Mon,  1 Dec 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+nIbrH1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713E30FC1F;
	Mon,  1 Dec 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598205; cv=fail; b=bs8XgJbUfb/rFerhjALU8/Vkarr4SXc/o3jvhtyR7ZjA1UiQRX/1T6ruyKC+wIds8HBpsXjgNjd9hvLCOtIW3TLgUD3KYKXYPr3tTGF2gE+n1SqetC2obpD8tBy/rcu0PXQDlYfbfbC0JZHSjaUO9wgojhQ9a1g8qFMRZYOpJAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598205; c=relaxed/simple;
	bh=2HZd8Zwq51TmKc1o+5RSkpDDrYy2b02F3GIeA7055dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvSkaNrHCgiaMBSt+baTTLgCxcHQgZqV2mZAKjCSwk8R2s8ywoad6647lVTI8QUR1gYtv2w1AIINDEq6WENfButTauHe1NVkaH/1e+Gf/UBYfB65j0xtYxAXp0lmE32Owck0ghcsDm3Ljo3lg6hhQKBdGEjzbCVsWuSeDRM3tqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+nIbrH1; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx2bNeDXteJ3K0IhKMd9/t2iEOTBFuwApTVWIY+95Ys/DAvsiBkr8sTInUHgAr01kZ/xbAfrBWVAY3qpFhJlkTi9soxFfqXlBtbKDfKvaxvCu70zNDTTUSBg3/EFyi+4uXC4af5lFk0kNuCM1Dq/VtwFO+d8ZSeCWNcdHr/U3EzxMfj5tYJIVC4iKZRePkET9tgDF9QG6wWJKshL7CQsL18pZTj5h4nvowl0o3Q/m1SKnrpg1lnH7kOQFdU50FCyXDiS8JHJot2+vBlX9LyveD3Mi4SbxgCB7ut1I9mCfRAh1iaCgdO2G09wAyZJ4eoZaKXbbi1jpHV3P3f3iuXqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KIcwS1jNFbcY5/NWx5xNQK9PHBUTF1QWoD5Gs3/pxU=;
 b=dOO6AAJep80Z65F61lQUUpDX0X0OKdCf59ADOSwZ2tTTutwnTErs2vhEQAGU743yIL4UJ4CLf48b0kLEXoetS2vhULbYSAUAi/CwTAK/6whFUipdCss7HtreiGvqH54uuPic9FyPlvXEjjfAkraB0RF6Dv+HZRK1LB4Z1g0G39nD1LcdPloUuUWIT3UfdqzU5m9VLsRWbNV0VQmSkOuTKr07t7sKAT4v2TQmyEEZa5XtYraEc1WcNMjrcwhWEm9bmSX5N/yN8MOM+JJdd5ut3ryvhnB2yIZAd3IRP2i8gi1zeKtQ2YOuwPwojKJy0TJjVAe7wy7DIy9aK7CClJDaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KIcwS1jNFbcY5/NWx5xNQK9PHBUTF1QWoD5Gs3/pxU=;
 b=O+nIbrH1Rlx+9qzVZQAGovKA6kbaiVjr91Rb9EFrjA0hfSD39HzlxY94WDlU6mOXBb/elKOkLUf63RXeU+GRZJCE4GR6STNj9TCZm7j9niyHPLURnN7P3xQIWaBBGjbKKOBH/oaPpdihtxqYOEEQNljT2ELZS6FYWoDAcqwlwriEYpitYuvbses3LU+oYyFcN3Y8ASc5cOWoeR4askpgLGzZrQKcWCtbxJofXDaLT9qTGLQOIwZyXBmR1WvgmNMtZebWwX5hL185jSjDQ8wr6Yb0D7U1NyXuFFbJOUR08zfGurTXkfN78/BFJ8ssrf4Fr5IHRFh0kovI5OJZ1CAhjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:09:57 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 14:09:57 +0000
Message-ID: <cba8314f-7e01-464b-9ba2-e337395a453b@nvidia.com>
Date: Mon, 1 Dec 2025 19:39:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, ray.huang@amd.com, rdunlap@infradead.org,
 zhenglifeng1@huawei.com, robert.moore@intel.com, lenb@kernel.org,
 viresh.kumar@linaro.org, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com,
 rafael@kernel.org, gautham.shenoy@amd.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-9-sumitg@nvidia.com>
 <08c65096-dc70-42dd-a085-900605c3fe4b@arm.com>
 <0e24a618-4a42-4fa8-b9ed-6d7db9b1a8fc@nvidia.com>
 <22a86779-102e-48ce-a79e-4a324c554984@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <22a86779-102e-48ce-a79e-4a324c554984@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0280.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::18) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ebe27d-9be9-44fb-e29d-08de30e34eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEpBZnpNTGd5Z2ZUQlRVeWU3OG5VdEVKeFBoMXdEKyt2RGxoazFSY0g5V1Bj?=
 =?utf-8?B?R0NDTkxWL25BZUdnQ00yN2ZjMzNuUWFVRjFnaWhRSTU2VExlc1F6V0l2SGhO?=
 =?utf-8?B?eDFVRitib0JyTWJieUsyRnJWVGx5QmlVUzBrdjcyTUFRMkR2VUhGcHMxTC9I?=
 =?utf-8?B?Mzl6SjI3TGh4OU5kenBna1RPZFJXTGpFYldQaEpLOTNMM2E5ZmNSTVphT21D?=
 =?utf-8?B?alFvdXp2VVNNR2ZCZFhBMEZSRjg3QkU1Ny9hQVBZeUpmcS9sSmdFbUhYd0tx?=
 =?utf-8?B?T1VhUGhZNDNiZWV5QWVTWWpKazNxM2ttOHBmQWRiakZ2WklSMDZEQUkzWjNw?=
 =?utf-8?B?VGZJMU5ob0FJRnBqTzFBb2JLcU1nY3J5dHJld1FxSlhnRjFpQUUwRytqblF1?=
 =?utf-8?B?V3N3S1ROajFKUmNlWWFSanVoSCtBREE0UjdoeXpleTFTeXUvdGJLK2hKckZI?=
 =?utf-8?B?UElwRXpUSk0wdkxmd1M0KzJmQUtTZ0pTcEk2dVRiZnkyR252ZUN6bldMSUpX?=
 =?utf-8?B?RUNrVENHVjVLNWwydUlSSzQxRmxjY2VBNEJQRDlocjFlYjBvWW9GenJiQ21m?=
 =?utf-8?B?NGdqaUswbllWOTNlMkZKR1NEZG54Qi9WMWdOeEF0ZnpTNDU5dGprK2lpREZj?=
 =?utf-8?B?c04ybGFaN3djKzdZbEp6Q25QNUpmUDRaWEhNV2VERXZOZWswSGJ5NWNHZHdJ?=
 =?utf-8?B?MTRza1hNRlozaUY2MnI5OHlQZy9GN3Ryd21KVXpvUEJVcDdEbmczQUxLajVH?=
 =?utf-8?B?QSsvZXZTclc1TmdMK2V4dHZEd0R3dDgvK1J0YTdyTW5DdkJyaVdIQ3ZSWnlY?=
 =?utf-8?B?WFFkOFphdThWM1p0ZjdaR0cwdVkrSUl4K0JqdmJqWEJRV25obEhudHVLYjlj?=
 =?utf-8?B?ai90Nkw0TEdsa3J3NExUN3p3UFRBaEJxeGNrQ2wrSjBFVGwyMHRnb0c2MmJr?=
 =?utf-8?B?V2kxNzRBYmNnMHRDbnA2SW9mSSttdHJNR3N2Q2N3dFZhM3ZpVkZzaWtqK2Qx?=
 =?utf-8?B?YkZROGZGb1JPMld0c29PQ2ZiVENiZWtSRzFCVndlaTFFMEZGQXR6QzNNMmZT?=
 =?utf-8?B?MWgwUXozMjRzdFZleWR4LzlTUDBVbWtMVlo5R1B4dm5mTTl6R0VMYVl0cUtI?=
 =?utf-8?B?eitXQWZvaXZwSXo3WHR5Rmd0RXZPZlhVNHgrZ1lxVlo3Z1ZML0JMZzJYdUpQ?=
 =?utf-8?B?R2tEbi81aGtFcGRKM1BLSWpSTWlmZUY1bUtqU0FjQTVRcHRoVG1vL3l2NXFI?=
 =?utf-8?B?KzArM3pLNWRYQ3hzeDBpaEtyQjhYdCs3RVc0R3VELy9JbFRDaTZ3VHlGY3JS?=
 =?utf-8?B?Tmc0MjVOYTJSTVpaOUJjOUx3YUdNUXNkSEZGdXhIaURzMXZRWGErRDN0d1ZH?=
 =?utf-8?B?TGdqZEZPdlIzb1UrckFObGMvNE5kbkVlangyNVlJNU9HVEN3YWFXMEY0Vzc4?=
 =?utf-8?B?bXkyTSthMXgvb08xVEJBcGlnaVJoblFjNUxPT3VZcU03NHB5UU8xZU5sMmR6?=
 =?utf-8?B?Q0EzV29MSDVVSk51eCtjOUtXTFlnVUJXMGFSV2ZYSXlraHNaOWN6SlVycEZq?=
 =?utf-8?B?NkllMUtlK2tabnNUaU90WkdpeXNIU3h4aVZFMndKM2NJeUJKd21yVXBMQk40?=
 =?utf-8?B?S1MwRE1IblBucmQ5eVBScGs5Tjc4L0VaRFdjSkdPb3Rmdk9CQUZDMndjQ3FK?=
 =?utf-8?B?bW1MWjFQSFNBRkxDODdjcnY5S3krVnpPZ1ZuRFdXcE1NakFCcnArTkNTNzlC?=
 =?utf-8?B?aUZlZDlUT3IvS0E1aWhvL2ozRzI4VjF5dVFJVmNROCsxMG03cFRTOFR5VmYw?=
 =?utf-8?B?dTR6a29TNFFNeTYva1EwbCtKVFIwcHBMdlBMRlR0ajk3cGV0VHRiNU84MW1r?=
 =?utf-8?B?SlVHcW9qS09EYjM2OHpSY1RTcTg5VVg4RnlBb214NWoxcHlyOXRoR25JTFpD?=
 =?utf-8?Q?nAV3TR8WdzU1RExY33UoOqkp97kQ3GyM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE9hSkMyUk1zTWdWMGdwQXpNaXVGUW5aRDZTd3g0ZnFvL3RwODZuVEZrZ0hw?=
 =?utf-8?B?blAwKzBrVjVIdUkzTGRsVEw2WEpCYkpVVk1mM3d6ZjN0WlRNZTg3Y21FcWdq?=
 =?utf-8?B?YVVocVowb25EZWNlSCs5TWQzRGdPcjhoNUwzVHl2RFZnVnlFK0JWRTVKM3Ux?=
 =?utf-8?B?SWZJUHNrQllMUWNIaGMrNkZGdUR3MThQdEFDUUZTa1JXeEtPMFRoaEErZGMr?=
 =?utf-8?B?bnFPay9NOFh6d1VmeTdVVWRIRUJMTHRyL0VTQThBQ0dUZVhJZ0czaEZpaEFT?=
 =?utf-8?B?TVc5emhDYXd4S20xekpnZXF4Yis1N29tTEZzdjlHRWJOUGYrbjRVNE1DYkFu?=
 =?utf-8?B?clhnQ1d4Z2NCb1BvSTR1OTljUW8xWkpKTGVRNUNSK3lMVFFLZHovMjVhM09m?=
 =?utf-8?B?Si9iTGFqT1FIYkVaeGk4ZkZ6cXFlOU1wSTlRWWNGa1Iyb0J1dDZwUmc4V0t0?=
 =?utf-8?B?aWhtNmJKSTVUdDRjcld4WmtmeFcxdlFRMTdWallqcjUzZkpGdXhPSDBNNWFE?=
 =?utf-8?B?TEFpS0hVZ0RlT1laTWhjRUxMZGo3MmxSUWpCUndxdFZnUTV0YVNvczdMdzhG?=
 =?utf-8?B?cTZjbDZvSkhpTm1DNVlKdGRPejZzZnhUUXFZNWF1bXJ3bHpISGJURSt3TVBw?=
 =?utf-8?B?aENIbGRXSThwY1VZSkJMY2NIVWNvUWJoZVE1WVNFWE0zTFFPU3BjRUVpSWJl?=
 =?utf-8?B?Vi9ZTW52ZnBmSEtEcmxOS1pTQ1NSamJTSUdTRXc0dFpOY0JtM2hFYml2Z0Ri?=
 =?utf-8?B?cE0vNXBEKzAvZmtycUgvdktETzVQNEIzb1RlUDhNQzRmNWRMNlduVGN3aklt?=
 =?utf-8?B?b1VOUTBZbzJDMVBONlg4eGM1SzdKTGo0V2FVMW41Sm02MWhOb21FY0JUWURB?=
 =?utf-8?B?c2luendNbkY1TzJTaDMyQXU3U3FONHhxcW5oLytLaE1obWhwcWJnakRDMVFH?=
 =?utf-8?B?bWJOSVFNVjZLQnpOSVVvcFpNWjY0N3hWQ1Rnc21lVlBoUzN0eExJNmRyNXFv?=
 =?utf-8?B?OFFtd211UHhURDFLTnBpZmtnWk9TbVVmWi9yc21iclc3YklaU0lLa1c1QStx?=
 =?utf-8?B?Y0RpcENpaEFmTkRzVlhzQ2VRY0pSd0d6dndJQysrd09uNFViZGRtNUZNV04x?=
 =?utf-8?B?dkdhSTNaQ0N2SkNzak1ySS92Yi9mUmNJdzZLL0l3T05VQStINnlXSjVEeU9M?=
 =?utf-8?B?SkR3bGgrTHY1YVRaaUlEK3pCQnQyNmJNVXFUSmdzbWNmRVJnRHZTUHJiN2Mv?=
 =?utf-8?B?RzQxRmpqMkJ4UEp3SzBZKzdtV3p6MjhBTXc5MTRLSDdROTRLRS9ZTVhDWURM?=
 =?utf-8?B?V1hVcUJ0anhYajIrSU9SaHlWMERpbUdEQllyVE9JVkozTTg4MlVDTXZGcFdF?=
 =?utf-8?B?dE8xa3ljZkhrSDJZSWF3V0hyS1BNVWhxMm1SZEVSOVZCOUpWa1l6aTRJNEJp?=
 =?utf-8?B?VEp6L2pqVE1XQTd4WFBYYnZjb1JZWkNUbUVBdjNrMVhoTzhYSkJOMnJoZDhW?=
 =?utf-8?B?b0VrbFNqZkdmak9YZzlEQ3pVOVhQVWZCYldvd2hPdXZ2UHo1YXpsTml6VUFK?=
 =?utf-8?B?VGkxekNXeVkwMTZmU3c2NEs5bnl0c0UyYVhHTWl3YXA0c2RuOVk4ekU1MjNH?=
 =?utf-8?B?b2M3cURIMzNRa2hFdEc4K2JocStpeGNUWjQzOElqUFlSUmtOV2tLSkNEKzln?=
 =?utf-8?B?MEdwQ0x1aFlZOVU1MDluYnhTUE1OWVJTUlRsd2o5VDk0bVZiU0k1SG92ZWkz?=
 =?utf-8?B?M2FELzNUZnhZTzEvOFlFNmNpSjhVZm5HWXgwMEowSlVRSnF2K0thck0wSnpG?=
 =?utf-8?B?TEtpa085U2dSWHdSMlhCTjdBeEQ0R2NmSmMvZkM3bHhleStZWDA3ck9Ia1JG?=
 =?utf-8?B?TTh0MXJyN2drdXdoeWptNWx4aVl6RmFnMk4wTFpGU2ZiWm1wSjN1VmNHRkpD?=
 =?utf-8?B?SklnaUlVU1NXM3FkWnAySnBiSlNjWjBuRExFcGg1VHBoUVJCY0JEMk8xWGJK?=
 =?utf-8?B?VFhXTFZzWHpsRjVWVVRSUVIwSllXbU5XS25GTERjNXljMnNCUFlSYnh1MzJI?=
 =?utf-8?B?MDJWUkZnODI4TFVrTDhPN0V6QlR0Y1lMcm5uUlAxalYwVEJ5S3NWM24xTUww?=
 =?utf-8?Q?uFHmuAU+zoBnu0oEPrNBgjrpn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ebe27d-9be9-44fb-e29d-08de30e34eb3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:09:57.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn5a+NCrJhTszn1TWQmTsqW3yRcJ4y8yX7UXaByQRR/SsaWw3RMAXOjlkssPYUIz9XdCYzRNhHb/8HwFd1CVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344


>>>
>>>
>>> On 11/5/25 12:38, Sumit Gupta wrote:
>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>>> autonomous performance selection at system startup. When autonomous
>>>> mode
>>>> is enabled, the hardware automatically adjusts CPU performance 
>>>> based on
>>>> workload demands using Energy Performance Preference (EPP) hints.
>>>>
>>>> This parameter allows to configure the autonomous mode on all CPUs
>>>> without requiring runtime sysfs manipulation if the 'auto_sel' 
>>>> register
>>>> is present.
>>>>
>>>> When auto_sel_mode=1:
>>>> - All CPUs are configured for autonomous operation during module init
>>>> - EPP is set to performance preference (0x0) by default
>>>> - Min/max performance bounds use defaults
>>>> - CPU frequency scaling is handled by hardware instead of OS governor
>>>>
>>>> For Documentation/:
>>>> Reviewed-by: Randy Dunlap<rdunlap@infradead.org>
>>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 197
>>>> +++++++++++++++---
>>>>   2 files changed, 182 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index b8f8f5d74093..048f84008a7e 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -929,6 +929,18 @@
>>>>                       Format:
>>>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>>>
>>>> +     cppc_cpufreq.auto_sel_mode=
>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>> performance selection.
>>>> +                     When enabled, hardware automatically adjusts
>>>> CPU frequency
>>>> +                     on all CPUs based on workload demands. In
>>>> Autonomous mode,
>>>> +                     Energy Performance Preference(EPP) hints guide
>>>> hardware
>>>> +                     toward performance(0x0) or energy efficiency
>>>> (0xff).
>>>> +                     Requires ACPI CPPC autonomous selection
>>>> register support.
>>>> +                     Format: <bool>
>>>> +                     Default: 0 (disabled)
>>>> +                     0: use cpufreq governors
>>>> +                     1: enable if supoorted by hardware
>>>> +
>>>>       cpuidle.off=1   [CPU_IDLE]
>>>>                       disable the cpuidle sub-system
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index d1b44beaddda..0a55ab011317 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -28,8 +28,12 @@
>>>>   #include <acpi/cppc_acpi.h>
>>>>
>>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>> +
>>>>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>>>
>>>> +/* Autonomous Selection */
>>>> +static bool auto_sel_mode;
>>>> +
>>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>   static enum {
>>>>       FIE_UNSET = -1,
>>>> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct
>>>> cpufreq_policy *policy,
>>>>       freqs.old = policy->cur;
>>>>       freqs.new = target_freq;
>>>>
>>>> +     /*
>>>> +      * In autonomous selection mode, hardware handles frequency
>>>> scaling directly
>>>> +      * based on workload and EPP hints. So, skip the OS frequency
>>>> set requests.
>>>> +      */
>>>>       cpufreq_freq_transition_begin(policy, &freqs);
>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +     if (!cpu_data->perf_caps.auto_sel)
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>>>
>>>>       if (ret)
>>>> @@ -565,6 +574,12 @@ static struct cppc_cpudata
>>>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>>               goto free_mask;
>>>>       }
>>>>
>>>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>>>> +     if (ret) {
>>>> +             pr_debug("Err reading CPU%d perf ctrls:ret:%d\n", cpu,
>>>> ret);
>>>> +             goto free_mask;
>>>> +     }
>>>> +
>>>>       return cpu_data;
>>>>
>>>>   free_mask:
>>>> @@ -666,11 +681,81 @@ static int
>>>> cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>>>>       return 0;
>>>>   }
>>>>
>>>> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy
>>>> *policy, u32 epp)
>>>> +{
>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +     unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     pr_debug("cpu%d, eppcurr:%u,new:%u\n", cpu,
>>>> cpu_data->perf_ctrls.energy_perf, epp);
>>>> +
>>>> + guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>>> Do we need to take the mutex ? Or is it reserved to auto_sel ?
>>
>> Will move this to parent function.
>> Explained more in reply of the previous patch '7/8'.
>>
>>>> +
>>>> +     ret = cppc_set_epp(cpu, epp);
>>>> +     if (ret) {
>>>> +             pr_warn("failed to set energy_perf forcpu:%d (%d)\n",
>>>> cpu, ret);
>>>> +             return ret;
>>>> +     }
>>>> +     cpu_data->perf_ctrls.energy_perf = epp;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection
>>>> configuration
>>>> + * @policy: cpufreq policy for the CPU
>>>> + * @min_perf: minimum performance value to set
>>>> + * @max_perf: maximum performance value to set
>>>> + * @auto_sel: autonomous selection mode enable/disable (also
>>>> controls min/max perf reg updates)
>>>> + * @epp_val: energy performance preference value
>>>> + * @update_epp: whether to update EPP register
>>>> + * @update_policy: whether to update policy constraints
>>>> + *
>>>> + * Return: 0 on success, negative error code on failure
>>>> + */
>>>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy
>>>> *policy,
>>>> +                                           u64 min_perf, u64
>>>> max_perf, bool auto_sel,
>>>> +                                           u32 epp_val, bool
>>>> update_epp, bool update_policy)
>>>> +{
>>>> +     const unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     /*
>>>> +      * Set min/max performance registers and update policy
>>>> constraints.
>>>> +      *   When enabling: update both registers and policy.
>>>> +      *   When disabling: update policy only.
>>>> +      * Continue even if min/max are not supported, as EPP and 
>>>> autosel
>>>> +      * might still be supported.
>>>> +      */
>>>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel,
>>>> update_policy);
>>>> +     if (ret && ret != -EOPNOTSUPP)
>>>> +             return ret;
>>>> +
>>>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel,
>>>> update_policy);
>>>> +     if (ret && ret != -EOPNOTSUPP)
>>>> +             return ret;
>>>> +
>>>> +     if (update_epp) {
>>>> +             ret = cppc_cpufreq_update_epp_val(policy, epp_val);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n",
>>>> min_perf, max_perf, cpu);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>   {
>>>>       unsigned int cpu = policy->cpu;
>>>>       struct cppc_cpudata *cpu_data;
>>>>       struct cppc_perf_caps *caps;
>>>> +     u64 min_perf, max_perf;
>>>>       int ret;
>>>>
>>>>       cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>>>> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct
>>>> cpufreq_policy *policy)
>>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>
>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> -     if (ret) {
>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. 
>>>> ret:%d\n",
>>>> -                      caps->highest_perf, cpu, ret);
>>>> -             goto out;
>>>> +     if (cpu_data->perf_caps.auto_sel) {
>>>> +             ret = cppc_set_enable(cpu, true);
>>> The CPPC enable register is optional.
>>> However this doesn't mean CPPC is not working.
>>
>> Ya, changed this in v5.
>>
>>>> +             if (ret) {
>>>> +                     pr_err("Failed to enable CPPC on cpu%d
>>>> (%d)\n", cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>> +
>>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?
>>>> +                        cpu_data->perf_ctrls.min_perf :
>>>> caps->lowest_nonlinear_perf;
>>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?
>>>> +                        cpu_data->perf_ctrls.max_perf :
>>>> caps->nominal_perf;
>>>> +
>>>> +             ret = cppc_cpufreq_update_autosel_config(policy,
>>>> min_perf, max_perf, true,
>>>> + CPPC_EPP_PERFORMANCE_PREF, true, false);
>>>> +             if (ret) {
>>>> +                     cppc_set_enable(cpu, false);
>>>> +                     goto out;
>>>> +             }
>>>> +     } else {
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret) {
>>>> +                     pr_debug("Err setting perf value:%d on CPU:%d.
>>>> ret:%d\n",
>>>> +                              caps->highest_perf, cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>>       }
>>>>
>>>>       cppc_cpufreq_cpu_fie_init(policy);
>>>> @@ -910,7 +1015,6 @@ static int
>>>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>>>       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>>>       u64 min_perf = caps->lowest_nonlinear_perf;
>>>>       u64 max_perf = caps->nominal_perf;
>>>> -     int ret;
>>>>
>>>>       if (enable) {
>>>>               if (cpu_data->perf_ctrls.min_perf)
>>>> @@ -919,26 +1023,8 @@ static int
>>>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>>>                       max_perf = cpu_data->perf_ctrls.max_perf;
>>>>       }
>>>>
>>>> -     /*
>>>> -      * Set min/max performance registers and update policy
>>>> constraints.
>>>> -      *   When enabling: update both registers and policy.
>>>> -      *   When disabling: update policy only.
>>>> -      * Continue even if min/max are not supported, as EPP and 
>>>> autosel
>>>> -      * might still be supported.
>>>> -      */
>>>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
>>>> -     if (ret && ret != -EOPNOTSUPP)
>>>> -             return ret;
>>>> -
>>>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
>>>> -     if (ret && ret != -EOPNOTSUPP)
>>>> -             return ret;
>>>> -
>>>> -     ret = cppc_cpufreq_update_autosel_val(policy, enable);
>>>> -     if (ret)
>>>> -             return ret;
>>>> -
>>>> -     return 0;
>>>> +     return cppc_cpufreq_update_autosel_config(policy, min_perf,
>>>> max_perf, enable,
>>>> +                                               0, false, true);
>>>>   }
>>>>
>>>>   static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>>> const char *buf, size_t count)
>>>> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver
>>>> cppc_cpufreq_driver = {
>>>>       .name = "cppc_cpufreq",
>>>>   };
>>>>
>>>> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64
>>>> epp)
>>>> +{
>>>> +     int cpu, ret;
>>>> +
>>>> +     for_each_present_cpu(cpu) {
>>>> +             ret = cppc_set_epp(cpu, epp);
>>> Isn't the EPP optional ?
>>
>> Moving this to cppc_cpufreq_cpu_init in v5. Will add handling for
>> EOPNOTSUPP.
>>
>>
>>> If autonomous selection is available but not EPP, we will bail out.
>>
>> I couldn't find in spec that EPP is mandatory when auto_select is
>> enabled.
>
> I was thinking about the case where the platform:
> - supports auto_sel
> - doesn't support EPP
> Then won't this function return an error code and not set auto_sel even
> though
> we could have enabled it (without setting the EPP value) ?
>

Ya, right. For that will handle EOPNOTSUPP after reading EPP.

Thank you,
Sumit Gupta


>
>>
>>
>>>> +             if (ret) {
>>>> +                     pr_warn("Failed to set EPP on CPU%d (%d)\n",
>>>> cpu, ret);
>>>> +                     goto disable_all;
>>>> +             }
>>>> +
>>>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>>>
>>> Also, it is possible that a platform only supports autonomous 
>>> selection.
>>> In this case, writing to auto_sel will fail, but auto_sel is still
>>> relevant.
>>
>> I am not sure if we will have such platform which only supports
>> Autonomous
>> mode and has auto_sel as read only. Will add handling for EOPNOTSUPP
>> if we
>> have such cases as the cppc_get_reg_val() will returns this error.
>>
>> Thank you,
>> Sumit Gupta
>>
>> ....
>>

