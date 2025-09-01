Return-Path: <linux-acpi+bounces-16251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92435B3E486
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528F2163941
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCB229B36;
	Mon,  1 Sep 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PRD5PiBF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8814AD20;
	Mon,  1 Sep 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732739; cv=fail; b=DaOfw4SHeA5DITzerE0joehkIMjI4XLTE37hVWe3uNCYspTiB6BKshPRAwrUCBa+DTPfFWwA+TLqlZEuQL3t2QcuI3krmYGu4XlXi6Q6dkPAnm0RhbAUpz+3XWkrRnFzjl7xrOCYr+nAA/RXHq7ZcGxULAFFveE2wMapUTB98Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732739; c=relaxed/simple;
	bh=XIH4x6HHsj9H02RirIlUj3Qfb/LiXhnSMnI9m3oAhpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYRgaWt+mWf9mgaDI/JdZZcp/moj2b5wU+W7D1BYdJoEpeB+o+06JcCuKJxSC0jS7fzTjsKxsqK+OcMKwHetXyO5l4QIN0Tz37FESS0WByRm+jIwax/2pNwbf6HeytXP0TRzgpiJe5UV0KW0i4oz2Usex6K3S9W1j6TWYuFCPCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PRD5PiBF; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0ReqpBrFACFatL2cTnKnDtkYd+w/PxmiYGZhQlPx2jsvYuOoUhbVpyi8Ml7CbL/EmzLzSLoscV90yn2hOI7mVQA98u6eD01to8gTT6MtwlbLelBPwbJkuzyjy4UpgE8pC/JR2FBt8+BhDqA1GtH4F77pEotBFqeeKGgOGICLcK2xyfFsIFdPoRa1ciULBRcC1qxAAr9v0RyBeGnHrFxBp7LWOLt28Giyq8MeHuYcQ9d46agb2Zk28BcRy5eQ/DYEbmiHAm5PFJSuk1kX7RxgKgiOi9fOFS1KFu5TcvwppIImwuXTIo6oAUCDcFBbHr3rZrBbXNsH/5eH3fIpk7zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juiVcbavbXd8s553n7Z3V517GPcoueXahRQ3G8OPxiM=;
 b=rcKSgMLasgltafU1cMIZ4pu/uGoxPVKPphGA+fS2O2CHN+3nYNSeMeqrklLP4uAF8w1deJ1O3r2MxDbiFkGlgorjXQV/eKZXnAWLiA7zbTqrwiPf7sCK20n+1furOEjbNPJZ5z9hDwnmdAjieZje++sRdbrnieb5nLSVB7uvNTK3+N+llKrJbvXuwBJQTwifBC6VwdkrhXLf10iSB4UDy3IgtsmCDz1XAmfFwmyRs6ItUR6X6kcUyWH19a9x9Y89Uxh6FOMarFnpbONp7GgOzVjv8v/dEWjuK4fkNSKO1ZIAPGZtn5dhrkPDPnxsUtT6n6BCD245KPN8by+0ThVhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juiVcbavbXd8s553n7Z3V517GPcoueXahRQ3G8OPxiM=;
 b=PRD5PiBFn4KUZYo8AQra0o3dyZgcurYS+G1YRp8mukETo1RfncsvipoIs/SpYeCjNR2DB8kucV2iBBtntR+OPa8Ah2+XQUpHlfrX80iw0/3hXqxFM99TNMAPQq8anpmTIq8+MGlEfhY1eOMhq1c0Y2MaygAGObHXK5KoNubVMayRy3ZTNQzOjA88c21vELRU40b+mYh3EsUYOxDXVcbUXRpkI/Gln1pSeQPiKPLEa25wMh6mS2yn1zqkZ+59RVV6uzr6A1VQtS8dsFK2GGhbrRAy9i0XW7fDo7L9p6frmF4q1zFbXbCssuScUy1zP+et/JRv3loGjPTruhTJkX/BUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:18:55 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:18:55 +0000
Message-ID: <f9a1252d-25a0-4da8-9748-4b17798ed4e3@nvidia.com>
Date: Mon, 1 Sep 2025 18:48:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Randy Dunlap <rdunlap@infradead.org>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
 <d35459bc-cf52-4fd5-886a-e9f6db7fda5e@infradead.org>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d35459bc-cf52-4fd5-886a-e9f6db7fda5e@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: e632ea89-3335-4183-5fc9-08dde95a1a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckF1djhRMVM4R0xkVWdFb3RBUHJYdW42VHd2UFpCdVI5eitFNzcvcHRjc3dZ?=
 =?utf-8?B?QnZtL09vZGVQUkdLTHZ2aWdtMGtyVm5saGU1bUZQZU5tcittSGdWdXFJb1g4?=
 =?utf-8?B?ZTdCT1M5OWJZVWxUVlZ6TjJOZEhEY213SDF4RkUxRkl2RkZYT2pTYVoyVmlY?=
 =?utf-8?B?Y3dBdkpHdUk1d3pXZER3Ni9CU3BCK0hDQ2lGdXRDVDVOakk1TjFnT0s0dU5h?=
 =?utf-8?B?dlBKdmowWVBEQUlNZ1JIUkN4a2FSOTJGSjByVm9PU0wvb1hZQnBOalVGaFpt?=
 =?utf-8?B?NFpuUjUzNHM1U3BnQ0FyeW95T1FXUkwrOE9ncUpPc3BmVVprbFdrbFpTWGdY?=
 =?utf-8?B?QjY2bUFsRm5TT1BraFlZUDVRc0wzRmJKYXcrL1BWM3A1bmNoaEpjT1ZWT2w5?=
 =?utf-8?B?NVpoaFQ1cmExRHhqYlZkcWcrY2o5alpGUzI5bUJrdVFnMHRPaEl6cUNqdmsy?=
 =?utf-8?B?Q3FCQ1pEWXpHUm01YlpQR3VnSjJoOUNyRFB5WW1MUkU3WVBVeExGRStDNWdR?=
 =?utf-8?B?eEpEdC91NVo4V1hBQld3cDBpT3dPU0Z4eGxoVnoyMkRscGp1VmVRU2t1WWZT?=
 =?utf-8?B?VEdCWlJ1Q1BiSTVxclhKdSs2RU4zaXVJd3k3cnhNeHJicUxaTCt0Z1czeC9Y?=
 =?utf-8?B?R0lFeklHb2QrOU4xVTV6NEhHWHdMTi9NZHQ0d0g4RC9LYTNDb3F1M0tLSnZE?=
 =?utf-8?B?RXZhSzNCZVRvMjIxa2swUWNmRnFhVW54TVU2WnQrdmdDd0xQVDV0QzlDOE1Q?=
 =?utf-8?B?R3c1OGFTNWtDa0prbzRsUEsvMDBteCtwKzVCZjN2MjQwbEJVQmFXRkhpZkxj?=
 =?utf-8?B?WnVUd0dwNDk2UnpWa3BXS05ZTVNPTjVOR09WYjViYXJyVFU4RHNOYjZBcW9o?=
 =?utf-8?B?bFRtQzVwRTJ6NFNXUWdYTFF4U2lEdGZ6TDFMZHoyWXR5dFRZaDl4YTZnc3VP?=
 =?utf-8?B?ZzlmQmdRMmRUK293d2FJYWNicU1OMEFqcVFLOHNPSUxUa0dvKzJTbHN1VE8w?=
 =?utf-8?B?UmNvN0I5N1YvZUMwK0JZaUlMRWlTQ2FzTWVPVjZwTk1kdU9qRG5SZ05KeDhm?=
 =?utf-8?B?QkRzVStJMDdoL1ZoN045aGRUVHFpZE5IOExSNmVReHEzckQ4TXhBRnNycDNH?=
 =?utf-8?B?MFZLQzJxMTNZR0dvbE1KWmFsa2lBT0JRZHRWNmtQNzl5TFhjdG1yd2gwSGV5?=
 =?utf-8?B?aTY5MEJQNGVkQXdBMjlWNUdqMEEvY3RPa1JNZFdCbUpuNng0Mm5oTEpwZzE3?=
 =?utf-8?B?dnFOMDRUMnpKRENXVW50alltY2E4aFF6NTBJSm9qWFpUK3ZLUXl4cmpRTmxq?=
 =?utf-8?B?MWYvdWdPeHlZbVFHbHhFUXIyWFFwVDZndlBwMUl3MTR6NXFaUEhNbHp3WWlB?=
 =?utf-8?B?TS9UeGRYaTErZlJpR0xiNlFRUlN3YzdwaDVNS2Z2b0hCMEx2YS9YWGdBb3ph?=
 =?utf-8?B?NUxmdjlScWwvVE5Uc3E2Mkd3bUhlT3F6WE1xOHFTYldYelJNMTRneGdtYWRB?=
 =?utf-8?B?SU03ajNhTzNMSGxqSWdDVGpJMC9BVWY0cmxXTWVjL1lyMXJvck5leVRnd09n?=
 =?utf-8?B?QmtIR24rUzRLeWc4YUdxYlZiNjU1THlNS3Vmc2JqR0lrK3N5Z2RBdzNHbVhi?=
 =?utf-8?B?SSt0ZTdKdGRNU1BqSHEwcVErYTgwSFlJQkpWS1hyQUlxeHlRVmQwOTkzeXBD?=
 =?utf-8?B?R0k2Mk5GTDJmRXRDS3F2WjFZK0RkMmtheVRaVkc3bEJOY0xwdURmaGh3UTVB?=
 =?utf-8?B?Q1N4WTlGNDVPckJnUlRMOUhhbFZneEpqMExWVGtIbFhIbVpORXYyVjBkMDlW?=
 =?utf-8?B?R0h2MmdwWGZKZzBvR1o5ZHVGOUdodmplVlQ0a1VQYjNnbTlNUTJvZHhFSWhH?=
 =?utf-8?B?L3prbE5sR1RJRzJYY1VWNFc5NC9xd28zUXV1eTdwYkdET29OeGNEYmd1NmI5?=
 =?utf-8?B?TDd0TjBlQ1pxZzREUXJ2aGJnZFRzK0VFN0xPVnZTZkh5SStPQWhCZlpkTk1X?=
 =?utf-8?B?NkVwaXZJWmpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0RONU9jOC93aVMyS01ITHBSZmV3ZHhwTHBhUkZyQlRpZzZnZUNNbFZkOEpp?=
 =?utf-8?B?Rndxc2NRdXBpTkVZa2EyQzB4aTYwQ255QlhIV2pGQkVVODR5S3puL1dHR0ZI?=
 =?utf-8?B?am1LRkx3aE45NVZFaGNmVlBMVmM4U2lmSWNQb2x6SlFyYVJCYVM4Yk5LTC9W?=
 =?utf-8?B?Q3pRRkNsYmRVUUt5OTRjSXBKZ2xSUHhuMHl6TTVGWFRHelYrQTVzOHF2Mjlp?=
 =?utf-8?B?VDUvMzFtVWpkWEQvaGQzSW5ONnRXV0gveFY1cTBNZmZjZFZMd2xOZzdqb2ov?=
 =?utf-8?B?WDNzVHlEOUJiZ3M5alU1YVU4TlNmRkljQ2c2N2VIb2owb1lPUHpqMW1pdFRr?=
 =?utf-8?B?ZmliZmhoNzZaZ1FZSHdubFlWbTNXYXE4U3BOWjh3czlEOXArSitET28xdG1n?=
 =?utf-8?B?Z0Y5SS8rYmczTk51RTA4dWxSTzJYb291bFFyd3dGajdJcWczVFROQ0F4Rmlw?=
 =?utf-8?B?WmxIMjFrZU1VaUl3RHFXRVhHbjR3QjEwZHA5VU50NEx5d3dWZXEvOXVxVTla?=
 =?utf-8?B?RW14dlFjYTdrbmhPOGlFMWtQRmk4NTBiak9KaVByUlpMRGhtOTY4VkpkRWFt?=
 =?utf-8?B?RUsrV2IreTZMaFZnd21VVmhldStQd3kyVGtnb1NpaTd5Qk5hNi91aVZUNFN6?=
 =?utf-8?B?TFZBTzI0Y3hZYUtjT3FXQWhSY0gvSnFwQS9jblNWQmYyc3REdVlqdVpnOFBU?=
 =?utf-8?B?S0xzcjkzOFg5WGt3RDlRakt1UTl6dUQvYlZ1YkkxUVJ6akZSa0FiZnV1dCs0?=
 =?utf-8?B?dkJHL2RqS2dKYm0rZk9ramFnSEhTSit6Q2NVSnJDNGpRVmVIMkJxMTdYMkpR?=
 =?utf-8?B?Sml2a3FRV1ZjMmtkNnRRQTl0VXBsVW5NdzJLNE1ZcmJiUkFQVmtOZlNIRWNt?=
 =?utf-8?B?SDFqRWZXQXZLZ1IzcjN5REtiUWxGTjYxSFpWMVN5WHg4aFY1VFJkQVZ3SzNy?=
 =?utf-8?B?c3lBVC9MU1phclgrTXVGdFgzdSt3SVNJUWdTRWRvU3dRdXJYS09GNXRWTUt4?=
 =?utf-8?B?Z054cm84OXF5OEd6NjlnT0Yvb2VlR3dsM0EyV05aMmZrWDRlQ25URWNMdGhp?=
 =?utf-8?B?SndoQWw0R0dCTUNaYzhiWlRGZFdSck5xM3ZXdWlmWEsxSjJyQi9KWWNqbk5h?=
 =?utf-8?B?SHJDWnVVQ1V6VVV0eHl1a0xGZXFyUmEzdCtWUThsN2hKOEZqdUQyQWE5TU5B?=
 =?utf-8?B?c3k4aUxaNmFsUzg2R3dDNHBFdXRZL0pFUk95aVpXOEFZSWxSbVlRTkN6YXJQ?=
 =?utf-8?B?QXNheFQ1QjNaam02c3daZEQ2V1NtSXpGM3JCYThlYVJKcHhJSjYyTmZ5NURF?=
 =?utf-8?B?amRMUUFLaDRCTmRJckVFb0FYdm1LZkdXVnlsdFBFQTdHcFZQYnhybzhybG1j?=
 =?utf-8?B?dmloS1psSkEwM0k0bllyTHAxbUdNM3U2QU8waHU0WHFhNDMyanB1MHU5YWRY?=
 =?utf-8?B?dHdnVVltMnZWM1JQZVlRYVYxdkpPSlA4bEpGaFdGaTlvODdtQjdqa2hiU2xZ?=
 =?utf-8?B?VlU2aFdZSkNDS1ZLT1lTTWhHR0VYZjFPZndUSUdTWGhyS28xdXJXKy9NYTl2?=
 =?utf-8?B?bGd3T2UrRHRsdUVEYitidEhiTm9vUy85VWhROFg0bENTTTI3UjF3YmlPNjg5?=
 =?utf-8?B?ZmZITzlGRThYNWZHdGpWdDBuS09EYzdLTzk3Ujl0ZjBsR3BXNHl6SVBydjRq?=
 =?utf-8?B?N2xNTmc2eDFKOGUxb1FuMXJMNFJaK0IvNllmRXhGdWdYcnVKeGg4VkV3MDZQ?=
 =?utf-8?B?cUxueGMzSEZpalZtcGRabUdOelJ4T1RzMk9BSnNRbkI5djFFOWFxcUdSYUZG?=
 =?utf-8?B?TnZyanFEZGQ3V2c4SDZmUVQ1eXNwUENyRVZDZ0doS2ZsNjlaYmhDTElFV25w?=
 =?utf-8?B?dGdZMFo3RUtuSU1xNjZEYUxyUG9rbkJFWWIzYWVUVHR2V1JCNnFGaUdMTjlh?=
 =?utf-8?B?R2s0YjJ3YjdRUHJ0VHREUmg4U2pyaUpML2Mxdnh6T3RCVzRlSXVmM1ZoWldq?=
 =?utf-8?B?QUlSeHRjcldINURZb0o3WFZxdERhQ053VzBqVkEzeTFkckZVV0Q1SU1jSVNF?=
 =?utf-8?B?RUI5Zzg4ZXdBSHpWL0ZlSlBHaVJHRFZabmFld3A2dXc1RnZleno5Zy9QVnFN?=
 =?utf-8?Q?kkHiGYqywpxYvTGhOhdmsXUx7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e632ea89-3335-4183-5fc9-08dde95a1a3b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:18:55.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPhX1VPxiDaye7fgbZvb6cdiuH6F0Lkv5RpF53lQJVaxDYnxDJ+cn5gnJO9wA+1ZplL8EB+M30lHE1/XEo0shg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905


On 24/08/25 05:38, Randy Dunlap wrote:
>
> On 8/23/25 1:01 PM, Sumit Gupta wrote:
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
>
>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>   drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
>>   2 files changed, 168 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 86f395f2933b..ea58deb88c36 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -911,6 +911,18 @@
>>   			Format:
>>   			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>   
>> +	cppc_cpufreq.auto_sel_mode=
>> +			[CPU_FREQ] Autonomous Performance Level Selection.
>> +			When Autonomous selection is enabled, then the hardware is
>> +			allowed to autonomously select the CPU frequency.
>> +			In Autonomous mode, Energy Performance Preference(EPP)
>> +			provides input to the hardware to favour performance (0x0)
>> +			or energy efficiency (0xff).
>> +			Format: <bool>
>> +			Default: disabled.
>> +			0: force disabled
>> +			1: force enabled
>> +
>>   	cpuidle.off=1	[CPU_IDLE]
>>   			disable the cpuidle sub-system
>>   
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 5e1bbb5f67b8..bbf654c56ff9 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> [snip]
>
>>   
>> +module_param(auto_sel_mode, bool, 0000);
> Hm. Is this changed to readable at some point or
> does it stay invisible?

Yes, it stays invisible. I am not sure about future as of now.

Thank you,
Sumit Gupta
>
>> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
>> +
>>   module_exit(cppc_cpufreq_exit);
>>   MODULE_AUTHOR("Ashwin Chaugule");
>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
> For Documentation/:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>

