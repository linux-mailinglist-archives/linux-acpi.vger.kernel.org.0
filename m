Return-Path: <linux-acpi+bounces-19523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC5CB0CDA
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC2193019773
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4C30499A;
	Tue,  9 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1GCYaCw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB27224B0D;
	Tue,  9 Dec 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303859; cv=fail; b=gHkMNUPJ8E9JTMFtUxZBzJU70oKzcjsEDgC2ALW5ut8Mk2zBfrdZxm7SYTzW0SuBFf1On5ovSWiG0ohVJ+Fuxh2iKAPaxMswnE9yYxwkZGoijtOO0/bC9jevkDWajDPO2c8nffGI49ORaQG3jBDv51xdAgSukHJabbqdZdf3EIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303859; c=relaxed/simple;
	bh=lGHCYuOMWWy/C/apvUEL6sAzbpIwxOhyhGM5+DXqDF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUB3+FA+OPfxg0L3xIVyDmBnQ7CNvXP2qsH5WPuXE2ik5zGSszKV5hXOFkHGA2MbGdNWiHgEAuTtYXQUmjW6CW3zhFEMKbpq/eqBT4cEXl54lgEv3P+ChMjHMPyUD2iZ6qjSKaVftjlGKPrJ3b3Fb0VeYolGej3cKHsiuOfFdwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1GCYaCw; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyyRkq7oHl2y443+WzGP5xfp0D9m+rzHaSCr/CmzpqVXgtyzA/iOaAtlL4LVQK2845zB4a9M2krDXdtBa1nq8ynwrlyqodRlV+cpitFVyl/qlEHzODCaVd3UY6DlQ9BZcRa8EszbmChRSj3+TNXx3f5s1VMTvhc2Y9F7FQGb5XPS3P+5bZvRw+o/xilt8JvJCmZC6NAUJtf+x9TUFCRRxxY97+HaXuAbmlmguUmjGCuXqg9Ok0G/Nkw07Hiy68LG3cvN6vDROjSZzAS6xvJR3kmjCQ9F2BJTKWIvs+ySKpMvPsEnjOXLRQe11OOiWUr4XyevnO1Yz6NsURmrCyvvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNCkCSS2edwnwnS0AC5c5CPPJPANBPrcj12g36BC+Ms=;
 b=dgka98UccXDR2F8WtcdI+7fpjDYwRKm1Gpbovr+Fp/QzdnqcMmfk11B98CFDvYII+jtdfPwLNrLoWbnafwlH8gSuCZ+jpvTmiukWZSHaMC1BaZ75jN7s4TBeCa0MRIyTZFK7YyBtXpXt3P8RIL9JO3PqJrph0vqABmVZQe1mgX1NPXqypVjFrdQbAgfpudWJjGkTaFl7Xo0RH1fw79XbU4UEaBmNKWwfo67HQD+XRXeKPzpGuLurcrSNknZrxxk2xRJcrreZPX+454dvkv0tG7sU8eDQ1tGhcEDRA7blLDKUNnFE/Afg/S9UnLQ7E5PSZCCzdo73JRbP9B/ygle7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNCkCSS2edwnwnS0AC5c5CPPJPANBPrcj12g36BC+Ms=;
 b=B1GCYaCwB9L12iPL01wyr6ePSegH3j5zdOPzYqtxI+4oflIwpCcjjGGkCHAit1jG2J1JYSXLY7mcgll7wxN3eiNKMlbgauyY7PeInsgRovjKcXx1NKCldhJ4Gg3dd7MXkClJhVd+EB7UruTB//P80lxJBfx2ZJjZpKAl8eLHUFr/Oew1xS38Bc0eryo7kkENV0bAwms1TAdEgUqP0NzSxD4bJPcMq2XtN9erEN/D882GSLDWd1oMHP4aRe8iQ0rV/U8Y/+m2r4Gk7ZcYUqaFhS0mL5dN/tpORCX5LsfdB8L80BygqT0h5Xo0mZVEnjw86CpSYnYVMGwB1NKuIECPUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:10:54 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 18:10:53 +0000
Message-ID: <c3fd7249-3cba-43e9-85c6-eadd711c0527@nvidia.com>
Date: Tue, 9 Dec 2025 23:40:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
To: Pierre Gondois <pierre.gondois@arm.com>, mario.limonciello@amd.com
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 zhenglifeng1@huawei.com, corbet@lwn.net, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rdunlap@infradead.org,
 sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-4-sumitg@nvidia.com>
 <8fb77549-ce33-4c89-959b-57113eb716b6@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8fb77549-ce33-4c89-959b-57113eb716b6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d877829-2d02-40cb-ef7a-08de374e4a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEg3N0JZeDI1TCtjVGFyWWkwbEN1ZzN0aDhxVjcxYnpjVjhFb3pwRWJHOXlD?=
 =?utf-8?B?MHBxNUNZaFIxUnltTjdZOVFhVitrNXk4Rnl0ZU8zUnhVNDIrUjI3K0JZdzNC?=
 =?utf-8?B?ZURwN2djYTJ6aFBCRTl1VzRPbzhvMXR3ZkJmbkRDWXVubjl4akFkdG9oZW1N?=
 =?utf-8?B?YUk2dy8yTDJoK1pYQzlmUllyMk1KdVhDZlcwTi9RQ1VsUThUekI4MXd0VTYr?=
 =?utf-8?B?UnF0VzViRTROMXhyUnd0QnNZYW05UHg3ZDYvWmc5VkFIUCtBSUUxY3YwV1NX?=
 =?utf-8?B?eUtXUUdKNXlXdjFGczEyUXRpK0ZxeTZQWFllZVRKSGNYWFhLdjlpQ2ZzbjJ6?=
 =?utf-8?B?eHJKMkg2VUdyK3Z2a29XUlY0WFVkUDVoVG1sWFZCUWlrQnN5UHFkZllYczhU?=
 =?utf-8?B?bzBEVkdSMlpZYXlIT0NOdEFrM3F1bm5yakVaV2dsRlZpbTdLOWt1eWNYY1VP?=
 =?utf-8?B?NkJodHM3bkRlNjRCQ0E5eHdJdytzTGVLaXI4OHRMcHVkYkgyendselJYZ2pJ?=
 =?utf-8?B?SUVmakVOQ0srQ2VHblRFMUZEZ01KclN1NlZUR3Q1NU5wMi9GVHBvSjgzWjFm?=
 =?utf-8?B?cDlGR2E2c3Q3VXhOMkhVVlR6bGduOTAvdkdwS01PTmdNNnJTMng4SGtjc3Fa?=
 =?utf-8?B?Q0E3TEhJci9UczE4b0lPcVYyUzBoNlRCb042d2E5Mk5kWUJocU5lcE1vbXgv?=
 =?utf-8?B?ZEhncFdIc0t2cFM0WGNCUmE0alZwM20vNkdmSkhWNkpOSTF4R2I3QUlJakZK?=
 =?utf-8?B?NzBJYVhySFVhZ3NMeWdMYXo0YUlmSkVKektUTWRDakJDenFuTEVnc2RxU1Bp?=
 =?utf-8?B?ZTE2K3kwOHNMQ0JrZUZPUXJDTkc1eEExdkR6ZmNuS09wbk9LWXBBamhQWkUr?=
 =?utf-8?B?MWl3MmNRbHhlTmU5OVFaYXI0elliM0tUaHlPMlBzWmRpd2g3eE91VTNnN0d5?=
 =?utf-8?B?NmcvVW8wMG0yT2RGRkVkbHVMaGRvaVg5a1p5QVMyeGNSaytPb3EvbGtteWZs?=
 =?utf-8?B?c3Y5MTBLQVBUQkpRUkZEOEx3R3BCb0FnbTFxY29Yb3B0T3I1aVZlR0N6OEZw?=
 =?utf-8?B?Yis4OUhaVElGeXVacHc4L1VYYm4zRStrYUs2ZWI4TjFkT0lGNHlQRU5MN3Y5?=
 =?utf-8?B?RFpMaFp0Z1FTRjliSlJkNmhmT3lxVW5rTVgxenVwZGNuU2NSZEU5RzV5UEhC?=
 =?utf-8?B?S1FrZGxWZC9QZERlcm9ubTUrbHFxTUJxWnowNnBGR3kwdFVqUkZJbzdGdVlD?=
 =?utf-8?B?blV4ZkFJTG1QRzhMdENXcHNiUGY4YkVWNlBDOXIxb3ZKY25meWlna0NZSTVK?=
 =?utf-8?B?ZEFkTERiUU5TYVpFbVk2cVp6QmNhS1djK3BSZ0lQcjRCNUwrUDF3SFMrSmI2?=
 =?utf-8?B?clpSdmlhZnU1a1JOeXcwbWwxNm1BU291MjJRb3FPcUFpejU0NEFvK3I4OTla?=
 =?utf-8?B?cElUekJuMjNqSFVuWTk5NjZGS3k1WVVtQ2dMeSttV0JZNlZVYWRtc1NmWnhR?=
 =?utf-8?B?RHZSNVR0YmdzZVE0V3ViZHd2cWQydTE3K0dNaklyc1VkQXlGYVgvQUhBdndJ?=
 =?utf-8?B?T09WSEMrdG8ybGZNNVlWZktHWGhQQjdRT2pnYnBZTEdydUUvY2c1YjZBU3Ra?=
 =?utf-8?B?bWVLMEY0ZmZ3MU05MTJna2Z2SHN1MzhNaGtDbmJXbFRYWXVVVDdtbXJPSElq?=
 =?utf-8?B?bHRORUoybmdFY0NXQXhDZTBZQThEQ0txeDBydlpvOVFQNzExZTBMTE9QYTNL?=
 =?utf-8?B?V1lvcnlIM1JQU3FKbWlJWmhETG1MaStrMmpNWU8yUUFnNVZNblVaK2M5L2d4?=
 =?utf-8?B?Y3NmUFEyVVZRV3FlWFR2QnEyakZORWhhYzc4UE9TdzRyQ2NuTklDdkJMaENN?=
 =?utf-8?B?dWozV05GMEJMbjhiZ1pOYTBCYmg5eGFjZUFGWTQwaWNwUHBzUTBzc1VyVDlu?=
 =?utf-8?Q?j86TvmM3g17wboUPTmbieD9shPaejf0c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b00wcWVTUXViRXJBODE4eXU3RXRqWmpVeXdYeGk2YnJDbVlBV214dmxIOVZW?=
 =?utf-8?B?WU15V0pFUVZGWWJqaHNoNHpTcVFoR1Q3RFlDUnBkZUhPcG1ab2JjQ0M4M3I1?=
 =?utf-8?B?SjhIMUR0eUdmL3Y1bG8vbThkVzQvd0ZkWXFFOHc1dXpHaEcxZFRTenhsSFhs?=
 =?utf-8?B?TFNjdG5SbEZTN25OY01nVzNEV3Vvd3ZiTzhnWDd4RXlVTHlzM1dNWlYvZ3hT?=
 =?utf-8?B?ZXFMK2I3NGVGUWVVTlNKNVIxdFhpWExwbnhPZEw0eURQWUMvZlViZDd0RHIr?=
 =?utf-8?B?U2NtYWdrVHYwMThBOFJwcEdiSStrVzJJZ2w1ZmdkL3pkYzgxbG9WUFVGdHVD?=
 =?utf-8?B?TU10MzZLaXNFUDJyeExoUGZRUWNiTHBrajZjZGxjMmFnSmxYdTNzalZ6eUZK?=
 =?utf-8?B?a0NVRDhvWjdpZkVsc1VFYURValM3dUpGMEl6Q3NKL2djT1g0WXprS3JzcVkv?=
 =?utf-8?B?ZTMwaGxCM1Q2bUxwMlFjOTl4TDR6dTUyd2pmbjNMemt4NktGTHFqZ1lzL1Az?=
 =?utf-8?B?R3lhbFg4QmpOR3JsT09USEpFd2hzQVIxVURKNUlYVXFmQUFLNnJBT0E5M0xQ?=
 =?utf-8?B?UG5TR3UrTndHMGtCTTlIdGxyRXZETmxWMFR1SzZWNVpjZkNMbTJrdWlYY1M5?=
 =?utf-8?B?aW5tcFNWOTVXL1B3a2Mrek1OZlhyQUhxS3RiNzVZWVBSNkJhTnFaR1ZOWjhn?=
 =?utf-8?B?cStUUll6dkpZQUxoYzFFcm9yOEw1TVB4TS8wVUcvbVFSRmVIUkQrMG96WHcy?=
 =?utf-8?B?T1lOdjBTcjlnMU9SdXBSazVQTjRzdHNMV01QdjF0b1RNMEtZdjNKOTYyTnJv?=
 =?utf-8?B?RllPRHY4dCtQNkwxS3dFN1RjZGlvYjgyL3ZRSTNnZWRjdm1IcG1ieU9RYlhT?=
 =?utf-8?B?T3NDRkY4NDNDUlBkMEJuYTJZNTlzbXF3MFlvT0dGWXZMMERwSTY1ZStBckZM?=
 =?utf-8?B?ZEU3dXVEZ0J0cm9FZmQ3MUVPMUh5WVZBRENOZ1Zya3ZSRVptVlNoYXcvMzVX?=
 =?utf-8?B?cWk0Wk9BcmN3VjJuTjRFOVN5VXd4TE9PWHdQL2xpYllwL1BTZDZzMkQ3Q0kz?=
 =?utf-8?B?c3NBYm1xMVlkVVhtZm9xZXBoaUllaGwyQzlpcTNrLytvd1NITkZ0ZjNmQ29Y?=
 =?utf-8?B?NXVrMk5UK1oyQ09RWnRRMk5yK2E0eUlkUVNBNVhUYTlobGtaR1JqUmxYSVYx?=
 =?utf-8?B?UDJPTlNqSkVRcGJab3VySU53VFlSS2RaejNCVXdwTDZody96UlI4T3B6TE5t?=
 =?utf-8?B?cnlUSkdob01KbFMxY2JRUkJPeW5UVmZPWXBuUndONDJmeDU4cU5lTG45R3JQ?=
 =?utf-8?B?NS9jR1o0SkI1UCtPd1JaYlg0bTJ5ZC9JOWwxSzNxWHplVjZUb2RQelRpelNT?=
 =?utf-8?B?dHdkSVhpa1BTMFZtSzdzRjlNeUczTmY5RTFkTmtDMWlGUHltamZ2RGxSc0xK?=
 =?utf-8?B?bldWR2dCVTRkTHkwUVlCWmlCNTRFekNjbGN2Z1cyY1dKVExSWmU3SmRwanRW?=
 =?utf-8?B?R082bllST3lVczc0THgwM2dyU3luVE16OFlqdlRWcUFKcDdlSVNnMXhJVDZH?=
 =?utf-8?B?bFVvb3c0Y3VMYWtRK3BnTXowYWdJN3RyblhSSXV5MW4zYUpDTEVqNzhiWGor?=
 =?utf-8?B?M0ZOYWdwUnRJSFRyQ2M3SVZmdjBweFFCbVNoS3NtT1dOTE0wM2pQa2Z2enRO?=
 =?utf-8?B?RHN6bDF2dDM1VlF5elBoUHdrSHJ5M05FL0FyT0VURDBRUGlraGU4K2ZCNVVz?=
 =?utf-8?B?N3h4L2VLYlJhMlRNMWdzWE1Mb1BvVjhHYzFOVXhOTCtTV1Z3ZFFYaVNoMG15?=
 =?utf-8?B?WUhUczgrekhvQ0FKL0lzRXB3N0JHRVhoZHRiRVk0YWpaQVoydUF1RlJrTVl5?=
 =?utf-8?B?OWgwc3Y3clBvK0pENUJ4TDlZZ2xqVklPUHlVbUo1SVdoNjh1OE1Eemh2Rldn?=
 =?utf-8?B?WWc4dlBMNUJldGhOUHJDYjhwM3JwcnpsNXpGMjBNY1VrL2RlSDFxUmlwTlBr?=
 =?utf-8?B?K3gvY21TaU1DcVplK3pCYVMzQlZmdEtKaFlSZHVuQTN1eFpmdVRKcVViVGxp?=
 =?utf-8?B?L1lua05vSnd2LzREYUNrbXpZUjVVNVpHUDdkbFBId0hGUmZlZC9DcmMycENy?=
 =?utf-8?Q?D/w0Jb4L9ONTyCwZ8wk9gT2+A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d877829-2d02-40cb-ef7a-08de374e4a9c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:10:53.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdQAva3P8HvHhl2q+nBEq+/1lVmGwQEW2O8LfzMMp9uc5ArHJ8bIp8boLbEx1l8zZwNpGWV108yudGnFxLrJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634


On 27/11/25 20:24, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit, Mario,
>
> On 11/5/25 12:38, Sumit Gupta wrote:
>> - Add auto_sel read support in cppc_get_perf_caps().
>> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
>> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>>    the same is available in 'struct cppc_perf_ctrls' which is used.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++--------
>>   include/acpi/cppc_acpi.h |  1 -
>>   2 files changed, 34 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 05672c30187c..757e8ce87e9b 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1344,8 +1344,8 @@ int cppc_get_perf_caps(int cpunum, struct 
>> cppc_perf_caps *perf_caps)
>>       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>       struct cpc_register_resource *highest_reg, *lowest_reg,
>>               *lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
>> -             *low_freq_reg = NULL, *nom_freq_reg = NULL;
>> -     u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f 
>> = 0;
>> +             *low_freq_reg = NULL, *nom_freq_reg = NULL, 
>> *auto_sel_reg = NULL;
>> +     u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f 
>> = 0, auto_sel = 0;
>
> I am not sure this is really useful to get the auto_sel value register
> in this function as:
> - All of the other registers read are read-only
> - The name of the function doesn't match: the autonomous selection is
> not really
> related to perf. capabilities
>
> I assume this change comes from the presence of the auto_sel register 
> in the
> 'struct cppc_perf_caps', but IMO this register should be placed in
> another structure.
>
> I assume this is ok to let it in 'struct cppc_perf_caps' for now, but I
> think we should not
> fetch the value with all the other perf. capabilities values.
>

Yes, reading it here in cppc_get_perf_caps() as it was part of
'struct cppc_perf_caps' in the existing code which i agree looks wrong.
I am adding cppc_get_perf() api to read performance controls in 'patch 
2/8'.
Additionally, I can move the 'auto_sel' field from 'struct cppc_perf_caps'
to 'struct cppc_perf_ctrls' and read it within cppc_get_perf() with other
performance controls.


>
>>       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>       struct cppc_pcc_data *pcc_ss_data = NULL;
>>       int ret = 0, regs_in_pcc = 0;
>> @@ -1362,11 +1362,12 @@ int cppc_get_perf_caps(int cpunum, struct 
>> cppc_perf_caps *perf_caps)
>>       low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>>       nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
>>       guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>
>>       /* Are any of the regs PCC ?*/
>>       if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>>               CPC_IN_PCC(lowest_non_linear_reg) || 
>> CPC_IN_PCC(nominal_reg) ||
>> -             CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
>> +             CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || 
>> CPC_IN_PCC(auto_sel_reg)) {
>>               if (pcc_ss_id < 0) {
>>                       pr_debug("Invalid pcc_ss_id\n");
>>                       return -ENODEV;
>> @@ -1414,6 +1415,9 @@ int cppc_get_perf_caps(int cpunum, struct 
>> cppc_perf_caps *perf_caps)
>>       perf_caps->lowest_freq = low_f;
>>       perf_caps->nominal_freq = nom_f;
>>
>> +     if (CPC_SUPPORTED(auto_sel_reg))
>> +             cpc_read(cpunum, auto_sel_reg, &auto_sel);
>> +     perf_caps->auto_sel = (bool)auto_sel;
>>
>>   out_err:
>>       if (regs_in_pcc)
>> @@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct 
>> cppc_perf_ctrls *perf_ctrls, bool enable)
>>       struct cpc_register_resource *auto_sel_reg;
>>       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>       struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     bool autosel_support_in_ffh_or_sysmem;
>> +     bool epp_support_in_ffh_or_sysmem;
>>       int ret;
>>
>>       if (!cpc_desc) {
>> @@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct 
>> cppc_perf_ctrls *perf_ctrls, bool enable)
>>       auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>       epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>
>> +     epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>> +                             (CPC_IN_FFH(epp_set_reg) || 
>> CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>> +     autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>> +                             (CPC_IN_FFH(auto_sel_reg) || 
>> CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>> +
>>       if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>               if (pcc_ss_id < 0) {
>>                       pr_debug("Invalid pcc_ss_id forCPU:%d\n", cpu);
>> @@ -1589,14 +1600,29 @@ int cppc_set_epp_perf(int cpu, struct 
>> cppc_perf_ctrls *perf_ctrls, bool enable)
>>               /* after writing CPC, transfer the ownership of PCC to 
>> platform */
>>               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>               up_write(&pcc_ss_data->pcc_lock);
>> -     } else if (osc_cpc_flexible_adr_space_confirmed &&
>> -                CPC_SUPPORTED(epp_set_reg) && 
>> CPC_IN_FFH(epp_set_reg)) {
>> -             ret = cpc_write(cpu, epp_set_reg, 
>> perf_ctrls->energy_perf);
>
> I think this is a bit out of the scope of this patchset, but I'm not
> sure this is necessary
> to check the value of "osc_cpc_flexible_adr_space_confirmed" here.
> Indeed, acpi_cppc_processor_probe() already loops over the CPPC fields
> and should detect when a field is using an address space that is not
> allowed by "osc_cpc_flexible_adr_space_confirmed".
>
> From what I understand:
>
> - osc_cpc_flexible_adr_space_confirmed was introduced to check that CPPC
> registers are in the correct address space
>
> - this broke some amd platforms that didn't configure the _OSC method
> correctly
>
> - 8b356e536e69 ("ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> supported") introduced cpc_supported_by_cpu() to bypass the check of
> osc_cpc_flexible_adr_space_confirmed. Indeed, the broken amd platforms
> don't configure the _OSC method, but it is possible to check if there is
> CPPC support by reading an MSR register.
>
> - an amd platform failed to set the EPP register. This seems to be due
> to the EPP register being located in FFH and not in PCC. However the
> handler only supported PCC at that time: 7bc1fcd39901 ("ACPI: CPPC: Add
> AMD pstate energy performance preference cppc control") The bug report
> thread: bugzilla.kernel.org/show_bug.cgi?id=218686
>
> - to allow setting the EPP value when it is located in FFH, the
> following patch was done: aaf21ac93909 ("ACPI: CPPC: Add support for
> setting EPP register in FFH") This patch seems to have added a check
> over the _OSC flexible bit value due to this comment:
> https://bugzilla.kernel.org/show_bug.cgi?id=218686#c83 However the CPPC
> registers are always allowed to be located in the FFH and PCC address
> space. Cf: 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address
> space")
>
> ------------
>
> Just to summarize, I think the check over
> osc_cpc_flexible_adr_space_confirmed could/should be removed. Ideally in
> a separate patch.
>
> If Mario could confirm this is correct this would be nice.
>

Can send a separate patch with this change.

Thank you,
Sumit Gupta


>
>> +     } else if (osc_cpc_flexible_adr_space_confirmed) {
>> +             if (!epp_support_in_ffh_or_sysmem && 
>> !autosel_support_in_ffh_or_sysmem) {
>> +                     ret = -EOPNOTSUPP;
>> +             } else {
>> +                     if (autosel_support_in_ffh_or_sysmem) {
>> +                             ret = cpc_write(cpu, auto_sel_reg, 
>> enable);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
>> +
>> +                     if (epp_support_in_ffh_or_sysmem) {
>> +                             ret = cpc_write(cpu, epp_set_reg, 
>> perf_ctrls->energy_perf);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
>> +             }
>>       } else {
>> -             ret = -ENOTSUPP;
>> -             pr_debug("_CPC in PCC and _CPC in FFH are not 
>> supported\n");
>> +             ret = -EOPNOTSUPP;
>>       }
>>
>> +     if (ret == -EOPNOTSUPP)
>> +             pr_debug("_CPC in PCC and _CPC in FFH are not 
>> supported\n");
>> +
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 7190afeead8b..42e37a84cac9 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -119,7 +119,6 @@ struct cppc_perf_caps {
>>       u32 lowest_nonlinear_perf;
>>       u32 lowest_freq;
>>       u32 nominal_freq;
>> -     u32 energy_perf;
>>       bool auto_sel;
>>   };
>>

