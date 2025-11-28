Return-Path: <linux-acpi+bounces-19354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46824C92561
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6D144E5656
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65E329C56;
	Fri, 28 Nov 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQ85TyBO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C02405EB;
	Fri, 28 Nov 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764340176; cv=fail; b=EHWxb54XFhI4oOTxmBeiCguhvImJctuFWyYwrzDqHB+zJ3RR3MEjnji5sOQtr3F7rsWKFqx0yxLO5ewi0+nvqVYH1nUEn1TK+sZRyn9E0NoaMYK+OMweHCeF+I4+ORfy5In6q9jRo5Fx93pLSl6QUhRTigfTl+IEDaeHZIN5das=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764340176; c=relaxed/simple;
	bh=B+SMPKdBPiU2T7ogkma5QRkRkXLzzDKK+q3Wu6TR6w8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XG3AbNn0vnyYJxMmIzF8SAd4ig1Z+qUDJIMDPOFL6bJFlxpBzheWpY52IAq5MiNlo6zILto7irMsJqZyQsyss/u6xtBdS0UV0xkbLCwb05f5GLSXsi0QtjuU6CgZM1DRkClbMZ6TTnnQmL0AU/z56Pi5kUjHoIhI8cl7bmnkcV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQ85TyBO; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+5MU7eLo36kpeYR7nKZ7teG5IzdSGkSpzCaTNro0nksqF2JtwNoGnYwJ0BdT+TdlN2LX9IK3ho6qWGs8TdrhAN7eeDPiodv/WOahD3Cf2ao3GznPFClm4xpO1NBbc1hDil0y/icLhML6J8ItpRw+mEOup1mDYB7GwzrMXpeDpn31AGAoSxbxNHsXOGsCu02UHfn7NzNFSwcTzoJd4Pbk2yWIxpyV05RRVFN0EnVna4oTMBIJKIf8KGJ70p+EZss4QdSr/xMfroO9Z0gkbUbb+YxVsEg4sO5LQ2IRRUOiqEfD/oCi4x2HBahnhlsttb7XdYkb3L5Bbw0RUftMAHLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKkkMveFE5XZs1K2/iOjSwUEw87vxxAYfNUmamVfJkM=;
 b=HokvPKBf03B1YnBsMQDelLIZejwKw3XOvwUupc3bhxdpdA+qTLKVJKHjg19Ay8aAVIXqgKqU+oTBSWgYkSqPXdkloAd+msfocUpKgb4tXOBA2Lb2h8RBdjm0GW/3X6tIVxeA/LcKj1dv11DVUAhaEq2MKKp+V3WVURPbD3QTidiXj7+Mub7h2gekxVU1PnKMNR42OScN7lb3eXQA6DO/b0jTKwCw/ChcLHrbqmgJSoIFtL5KXXlRBeLKwN+BHraGQmmHTgvZjEAH+61hPkg7xkL+cHoIidP1CULEwRa/TyN9mPmPPSrIpNC8VJ9Y/mXKe4ROahH6csY/a0wm3U8R4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKkkMveFE5XZs1K2/iOjSwUEw87vxxAYfNUmamVfJkM=;
 b=jQ85TyBOgK2Ypu3U1X9wobgBWTUjF4CYRoXE7eQVqxQ5ipMysWbH9VEJnYc29hSeI4K4rYr7sA16Nhc20i2oAHyk/h+JpcJ8BYhDu2wmJ/1hC+lkk3s2d3bOe55nFEfr8giI84O04Kk1BqCAAcUPm/zs3RlhD65wBLHHaGZ97SrCi7QduvQdcfRdQ6KHfZew1kTleYyunn+azxig9JeZZivpT6mUNboe7FX7IJlrFVxTshbjj5mo+jLa7hWoi1Pm8ZaaByO8fcCwha3eVtxy5bLWtGKvr/w9oRQCo5DeDDvrrqzcAK9oM3CFCAhDUUe2c6j/a9QdQahlWBrD5kKkjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 14:29:30 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 14:29:30 +0000
Message-ID: <0e24a618-4a42-4fa8-b9ed-6d7db9b1a8fc@nvidia.com>
Date: Fri, 28 Nov 2025 19:59:18 +0530
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
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <08c65096-dc70-42dd-a085-900605c3fe4b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: e3eff392-7534-43bd-78f1-08de2e8a8af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTN4bm52VHhyTC9VWnR2bEErU3ZIL2NScUp6WjRaR0w4SlZnR3ZxbUQ0QmhL?=
 =?utf-8?B?LzQ0L21ta0JYd29wa2V5ZVpwVWs3a202cXFTZGJBOEgzZURCU2toZUNYbTlP?=
 =?utf-8?B?RDNIdHVjeGlvN25DamtOTVlqODNHZmhFTHJiUHZRNk1MZE83RWZDcUM0L3Jr?=
 =?utf-8?B?RzBwRTJRdk43MU90MFhld0VDRzRZTElUcThpWHQ5YTgweTQxazZLVmZjeWcz?=
 =?utf-8?B?c1VvellPaFY0aUNtZmg1dEQrWnljQTk4aGhqYldnSkhleFJxOFBHU1hHTm5s?=
 =?utf-8?B?WCtwcm5ScGh5eitsTGx0bEdWV1JuTjNoUDhxY1Z0T0c0OHViK09MbS80TVk1?=
 =?utf-8?B?eHJ1V0lMaXBUUnQ3eUgxdFBENnVWL0pLK2tiUUhCQ2dyWVgyWEVub2R0T2Fj?=
 =?utf-8?B?N1hHdXZXSGIrRTliV2RzaHdMbHhtUzZZTnJiMjlsRTVVaFM3eUh5TUdoYlU4?=
 =?utf-8?B?SS9mN3FKRmMvamtjSksxcWRRbERPTSs3dEw0YUdWdzlUYm52ZjFUcC9xTGxK?=
 =?utf-8?B?b1lJL1VCb203aERLcHdxdXdLZnFNRUtsellaMXBHUFNWQ0Iyb1RMQlZ4Tzg0?=
 =?utf-8?B?czhzZkZnN2oxNzNEM3lzM2V6RnFwZlYveVpQY2p1UTRWUk0wdHczMmpwMzMr?=
 =?utf-8?B?aWhNMFdIV3BvZTNlWk1GWDFrSnEzMFB3K2p1NXB5eDV5WVpyNE5VSmhxejBW?=
 =?utf-8?B?N3FaWkNubWFFdHZOYXdQcEVnSkVhZC9tK3pwUFFNazVCcGJrVjAvOGtiWGVI?=
 =?utf-8?B?TG5sbi9ieUI3aGYxUXhNSDBkck9hY0Fmcm95MmF6enFXNEQ5V25iM05YUmRW?=
 =?utf-8?B?bEtlbmVacjZ0anpRY2Y2dWV2QmcvcDZRS2dsQnNRaHk1MnZaMWtjK055Z0Y3?=
 =?utf-8?B?a0RLMysyRlhiM0NuVkRqSzhBKy95NVFhYW9aY0UvcDlXcm9ScVBQWWFLYXRH?=
 =?utf-8?B?V3ZaOHZKVHRuMk9aTjBqbDVtRUp1enZKQlZCY0dLTlpuQWxPbzZzb0tMay91?=
 =?utf-8?B?L2NXY1V5VStHeko3aXdpWXdwSGg0aTZzK3VlSkFxK29BcEFGWnMrMHd1K1lL?=
 =?utf-8?B?bWI3TStoMlZwSnlnbzlPUU85Yy8zS3pOU0VreDVlUW5BNEw0cWpSRVYwZkpY?=
 =?utf-8?B?dEVZUkZQaldPNGhSS2pBaUovSFJqMTA0V1VEejVDWS8rOFp3VVFBNWdmemJS?=
 =?utf-8?B?S1VJNGdha1ZNR0hvMW8vbks4RndTbTNuWFVDRFJJdlFqckdyM3R3dlA2UzYr?=
 =?utf-8?B?UDhheUxxZVdZTXJFbmh0Ly9qWUhIRThUNGJEMmRrNkx2dlBsVEY5RGozSm5G?=
 =?utf-8?B?WE11cmR0aFBjOUtoV2Npb2xUTUd4c3VnK2pWOE80cFVMa0hrbk82Zm1OelUy?=
 =?utf-8?B?dGdOamxOTHduS3lVM3lYR2lzbytST0IwU0NJSC9zb09UcUxDVjNYaDA2UUN3?=
 =?utf-8?B?dTVFNFloNndCY2hzaGZiN2VKNE5aNUJyeTBkNXBHQXJTOHp1eUVnbVVwVFNK?=
 =?utf-8?B?Y2JLZW9pNmxPeituQ0RFb0dZQUg4dURINXl4VU5aZC8rR3BXdlNUWGtwbUI1?=
 =?utf-8?B?UWN2d0xDN3dTeHlFYUpvKzdNcW81ZVcyVzlsRFgrbHhRTm9PUzhla2RBUUkv?=
 =?utf-8?B?MzJBWlAvRXpnTE1xaktQUDJ5b205YkV5M2JRZHNxRWx5cWNPekdLc0NJVzdX?=
 =?utf-8?B?cUdnaUF3Sk4wZ3cyK1VNc0toUEdsbVl3NmZsQTl0QittMUI2aWx4N0tRNzR4?=
 =?utf-8?B?ejJIZ1ZQWnpzOTVsK0VBR25qcWZzVUhWMXR6NU1FL3ZsR2RqZHlGaUsrbEow?=
 =?utf-8?B?NitCUTgxeVRqbmdVUnBFRjAwbnNlL2xHak1FSGQzSERZOW1pMnNrUjBPZHpa?=
 =?utf-8?B?NnVCQlN4a0tPQ3RKV2ZhWUl6TGZwSlR0cUY2Zjdqdk16emFsZzBTUlBFaE5T?=
 =?utf-8?Q?vCvMwhKAEHKqaOTXnZNAPKXJ/zJa6rM0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkYzdVEvWjdvK3Jkc0VuRjl0TEhoRThjWS9qcVJndTZ1Snl6ODBiUDluWW1X?=
 =?utf-8?B?dHY5YmpPejhWN3JZaWZaMU1wZS9BY2xxUUhXcVY1MVUvRHdPTFV0dGhnM2pF?=
 =?utf-8?B?eWxaVnFDSUdYMUh1SzJBZmVtYXNORk1UNG4yR0RIZzdGWTdoNEZEWHZvd1B5?=
 =?utf-8?B?RUwxc0d4WFFqdUJNTXVXTHByOHBncWVMWHZiMytEU2hNVDg5TGZkdjJ4UWpn?=
 =?utf-8?B?VHVTcmtrbTBLSGdwZmYzbUFVa2JiWkd3dHVGdHNJZGdrNUhyZmFmaVkrUTc5?=
 =?utf-8?B?bWtjUUYwQiszNW9xamRCTUlVT0gvaVgreXQxeThNTGxvTVRKdzJpY2xReXB2?=
 =?utf-8?B?VnNMazJaakw3QlIzSTc2V1VQakxaTUM4YXdnWEQyQ2dMVUx5LzNLWEcvcTN4?=
 =?utf-8?B?OG1pZkJlNlY4Njk1U3hoSDZKUUJIRDQ2Qjl6QTV5NDFOcmdyL1ZibDVLZUR1?=
 =?utf-8?B?cVJKc1JFV3lDbmdvNjBYeFBaZzE1UUpMem1NdnduUEJpUEJRU2o2VkZSKzBx?=
 =?utf-8?B?dUNDMGg5d1RzRk0yaXBSOFlWVmt2Z1dudWxzUGcwcW13NFlVLzV1UWZXZWth?=
 =?utf-8?B?dm9xMGN3THhkV0pLdVplUy9LTkdSQ3Jqb25lTW1DYnhKRTh5TmZ6T0lDUXFl?=
 =?utf-8?B?U1k1QXZMdzhQQmdxT3lVZTJXdlVSRFhSQWRReGZldkpOcDJWZFJvcTFmeFI0?=
 =?utf-8?B?SEVTVTluWFZSN3l6UmorbldyWDdJR2NWQVlOMEd5eHFsMHlmWjhrQVpNelo1?=
 =?utf-8?B?bC9MWGNYRkU1UzNZMUM3T3AreWZOTnhyOXZnbGNna0VuYS9IcGpwUytTZ2tl?=
 =?utf-8?B?UlYyUi9IME1PTEhoY2VhMUoxZ2swbmhScnRFOEhRQSs3SEtZRWRGYjE0c1Zi?=
 =?utf-8?B?bWZKUm9lTVFmVGtubk4yN2VrSGJia1M4WXRrRmxZeGZUVW03K25KR1g2Zzl1?=
 =?utf-8?B?UnFoKzQwSnpiT3VISUJkdmxTVElkZHF3djZPM1gyNWdnNmgvaWJJYzRYbTVj?=
 =?utf-8?B?VFZSQjFxY3lpeXZHclRqcHdPQWgvQkhKTWozcjBiNDI2UURjWGpFVGR3eVVu?=
 =?utf-8?B?MjNSSGluMlc4aDdVUU5PUVRMZzh5WWZaU2h0UjNBK1piclVadW1EejdLMmpx?=
 =?utf-8?B?YUhUb3VaNmV4cy9keGwwdmFUQ0NGWTlJYkVRQVBNYlJqeDJPT3o2VzlDZVNx?=
 =?utf-8?B?bG0rbWJsT0FYRk5IcUV3clQyWmVsZFlZN0phakh6RGNOcmhvTW5YVTZLWkVp?=
 =?utf-8?B?UXhxQkp0ZkVHMDhZc2MvOEt1Ny8rWmFzTEdoMkJXejV4bFQ4NWtjKzV0Qm5o?=
 =?utf-8?B?aDliaVJtbDViQTh4WWVSZnZ5L2xYS2xRMDlFNGFydXRrL0NHaXVwY3p2UGdq?=
 =?utf-8?B?cnpTK2lkaFV2YnpZODVaYlFxS21FWXlLOHNHVHpndis4c213ZC85ZEhKUW8r?=
 =?utf-8?B?ODhlVldSdytIMGViejRZWm96QnQ0Q2dWa1BtRjZ3dUt6ZE94eUUzZ0Z0NXRp?=
 =?utf-8?B?R0JkMzR3NUtaL3Frb1N5UmdnM2tpaXBiWVdHQ0htZ3VYZUJFeDZjOFVZMm5k?=
 =?utf-8?B?aHZ1YW5vaW8xR05TbGVLdjdta25wOVhTRjJuVzJleFY3ekV5Zmw5YmZFNWZW?=
 =?utf-8?B?NXIxcWhvekExS2d0RklXZTRGdHE4RXFyZUxpN0cwbE5TcGZNUHl1VjUxeWow?=
 =?utf-8?B?emE0YlgrcFlnSkRQd3hTSWw0RFZDMHNabXhhM1VJT0RuT29HMkJvN3g1QnZK?=
 =?utf-8?B?NkZFem9MM1lONTJoSjNBN0RGM01UY0dpTkhpQ09Dbnp6a1FoamxCSkgxRE1v?=
 =?utf-8?B?UlZKVFNmWXRHNW05N1BTQzNYdERLZGFqd1ExY2xXdjNkL056TWFIamE4RFE1?=
 =?utf-8?B?bFp1YWNsRGRnU2FtR0tqeHgyMjc4KzZtZ3hpSnhwNVNKeld0V204TFdLT0s4?=
 =?utf-8?B?U2U2NGt0RnBNT0ZvdWJuTm9lMlNEc0RwY3hmQTZ4MmpQTG9EL3hxa2tta3Uv?=
 =?utf-8?B?NStoZXI4ZjBTZDZWMVZaM2xXTjQzMGRtM3FrQVBDYTU0cWtyeStjMlZIbHM0?=
 =?utf-8?B?VGZNYzh5a2ZZSlVKNUp5aUh2WjRZSTUreTRTakpweVEvQmozR1RwcUd5ajNn?=
 =?utf-8?Q?d0VbTj4UxYmu4oWtFyEj85sy1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eff392-7534-43bd-78f1-08de2e8a8af2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 14:29:30.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9ThHrTRbq8azRHNOo7XKImVR9D13h72eyTSs0Lji7PB2qC5rV7eZ8e7HMovu3qbLRytraQVhqYUGGvZOzlLJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818


On 27/11/25 20:23, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 11/5/25 12:38, Sumit Gupta wrote:
>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>> autonomous performance selection at system startup. When autonomous mode
>> is enabled, the hardware automatically adjusts CPU performance based on
>> workload demands using Energy Performance Preference (EPP) hints.
>>
>> This parameter allows to configure the autonomous mode on all CPUs
>> without requiring runtime sysfs manipulation if the 'auto_sel' register
>> is present.
>>
>> When auto_sel_mode=1:
>> - All CPUs are configured for autonomous operation during module init
>> - EPP is set to performance preference (0x0) by default
>> - Min/max performance bounds use defaults
>> - CPU frequency scaling is handled by hardware instead of OS governor
>>
>> For Documentation/:
>> Reviewed-by: Randy Dunlap<rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>   drivers/cpufreq/cppc_cpufreq.c                | 197 +++++++++++++++---
>>   2 files changed, 182 insertions(+), 27 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index b8f8f5d74093..048f84008a7e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -929,6 +929,18 @@
>>                       Format:
>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous 
>> performance selection.
>> +                     When enabled, hardware automatically adjusts 
>> CPU frequency
>> +                     on all CPUs based on workload demands. In 
>> Autonomous mode,
>> +                     Energy Performance Preference(EPP) hints guide 
>> hardware
>> +                     toward performance(0x0) or energy efficiency 
>> (0xff).
>> +                     Requires ACPI CPPC autonomous selection 
>> register support.
>> +                     Format: <bool>
>> +                     Default: 0 (disabled)
>> +                     0: use cpufreq governors
>> +                     1: enable if supoorted by hardware
>> +
>>       cpuidle.off=1   [CPU_IDLE]
>>                       disable the cpuidle sub-system
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index d1b44beaddda..0a55ab011317 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,8 +28,12 @@
>>   #include <acpi/cppc_acpi.h>
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>> +
>>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>
>> +/* Autonomous Selection */
>> +static bool auto_sel_mode;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>       FIE_UNSET = -1,
>> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct 
>> cpufreq_policy *policy,
>>       freqs.old = policy->cur;
>>       freqs.new = target_freq;
>>
>> +     /*
>> +      * In autonomous selection mode, hardware handles frequency 
>> scaling directly
>> +      * based on workload and EPP hints. So, skip the OS frequency 
>> set requests.
>> +      */
>>       cpufreq_freq_transition_begin(policy, &freqs);
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (!cpu_data->perf_caps.auto_sel)
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>
>>       if (ret)
>> @@ -565,6 +574,12 @@ static struct cppc_cpudata 
>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>               goto free_mask;
>>       }
>>
>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret) {
>> +             pr_debug("Err reading CPU%d perf ctrls:ret:%d\n", cpu, 
>> ret);
>> +             goto free_mask;
>> +     }
>> +
>>       return cpu_data;
>>
>>   free_mask:
>> @@ -666,11 +681,81 @@ static int 
>> cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>>       return 0;
>>   }
>>
>> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy 
>> *policy, u32 epp)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     pr_debug("cpu%d, eppcurr:%u,new:%u\n", cpu, 
>> cpu_data->perf_ctrls.energy_perf, epp);
>> +
>> + guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> Do we need to take the mutex ? Or is it reserved to auto_sel ?

Will move this to parent function.
Explained more in reply of the previous patch '7/8'.

>> +
>> +     ret = cppc_set_epp(cpu, epp);
>> +     if (ret) {
>> +             pr_warn("failed to set energy_perf forcpu:%d (%d)\n", 
>> cpu, ret);
>> +             return ret;
>> +     }
>> +     cpu_data->perf_ctrls.energy_perf = epp;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection 
>> configuration
>> + * @policy: cpufreq policy for the CPU
>> + * @min_perf: minimum performance value to set
>> + * @max_perf: maximum performance value to set
>> + * @auto_sel: autonomous selection mode enable/disable (also 
>> controls min/max perf reg updates)
>> + * @epp_val: energy performance preference value
>> + * @update_epp: whether to update EPP register
>> + * @update_policy: whether to update policy constraints
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy 
>> *policy,
>> +                                           u64 min_perf, u64 
>> max_perf, bool auto_sel,
>> +                                           u32 epp_val, bool 
>> update_epp, bool update_policy)
>> +{
>> +     const unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     /*
>> +      * Set min/max performance registers and update policy 
>> constraints.
>> +      *   When enabling: update both registers and policy.
>> +      *   When disabling: update policy only.
>> +      * Continue even if min/max are not supported, as EPP and autosel
>> +      * might still be supported.
>> +      */
>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, 
>> update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, 
>> update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     if (update_epp) {
>> +             ret = cppc_cpufreq_update_epp_val(policy, epp_val);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", 
>> min_perf, max_perf, cpu);
>> +
>> +     return 0;
>> +}
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>       unsigned int cpu = policy->cpu;
>>       struct cppc_cpudata *cpu_data;
>>       struct cppc_perf_caps *caps;
>> +     u64 min_perf, max_perf;
>>       int ret;
>>
>>       cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     if (cpu_data->perf_caps.auto_sel) {
>> +             ret = cppc_set_enable(cpu, true);
> The CPPC enable register is optional.
> However this doesn't mean CPPC is not working.

Ya, changed this in v5.

>> +             if (ret) {
>> +                     pr_err("Failed to enable CPPC on cpu%d (%d)\n", 
>> cpu, ret);
>> +                     goto out;
>> +             }
>> +
>> +             min_perf = cpu_data->perf_ctrls.min_perf ?
>> +                        cpu_data->perf_ctrls.min_perf : 
>> caps->lowest_nonlinear_perf;
>> +             max_perf = cpu_data->perf_ctrls.max_perf ?
>> +                        cpu_data->perf_ctrls.max_perf : 
>> caps->nominal_perf;
>> +
>> +             ret = cppc_cpufreq_update_autosel_config(policy, 
>> min_perf, max_perf, true,
>> + CPPC_EPP_PERFORMANCE_PREF, true, false);
>> +             if (ret) {
>> +                     cppc_set_enable(cpu, false);
>> +                     goto out;
>> +             }
>> +     } else {
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>> ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>       }
>>
>>       cppc_cpufreq_cpu_fie_init(policy);
>> @@ -910,7 +1015,6 @@ static int 
>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>       u64 min_perf = caps->lowest_nonlinear_perf;
>>       u64 max_perf = caps->nominal_perf;
>> -     int ret;
>>
>>       if (enable) {
>>               if (cpu_data->perf_ctrls.min_perf)
>> @@ -919,26 +1023,8 @@ static int 
>> cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>                       max_perf = cpu_data->perf_ctrls.max_perf;
>>       }
>>
>> -     /*
>> -      * Set min/max performance registers and update policy 
>> constraints.
>> -      *   When enabling: update both registers and policy.
>> -      *   When disabling: update policy only.
>> -      * Continue even if min/max are not supported, as EPP and autosel
>> -      * might still be supported.
>> -      */
>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
>> -     if (ret && ret != -EOPNOTSUPP)
>> -             return ret;
>> -
>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
>> -     if (ret && ret != -EOPNOTSUPP)
>> -             return ret;
>> -
>> -     ret = cppc_cpufreq_update_autosel_val(policy, enable);
>> -     if (ret)
>> -             return ret;
>> -
>> -     return 0;
>> +     return cppc_cpufreq_update_autosel_config(policy, min_perf, 
>> max_perf, enable,
>> +                                               0, false, true);
>>   }
>>
>>   static ssize_t store_auto_select(struct cpufreq_policy *policy, 
>> const char *buf, size_t count)
>> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver 
>> cppc_cpufreq_driver = {
>>       .name = "cppc_cpufreq",
>>   };
>>
>> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
>> +{
>> +     int cpu, ret;
>> +
>> +     for_each_present_cpu(cpu) {
>> +             ret = cppc_set_epp(cpu, epp);
> Isn't the EPP optional ?

Moving this to cppc_cpufreq_cpu_init in v5. Will add handling for 
EOPNOTSUPP.


> If autonomous selection is available but not EPP, we will bail out.

I couldn't find in spec that EPP is mandatory when auto_select is enabled.


>> +             if (ret) {
>> +                     pr_warn("Failed to set EPP on CPU%d (%d)\n", 
>> cpu, ret);
>> +                     goto disable_all;
>> +             }
>> +
>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>
> Also, it is possible that a platform only supports autonomous selection.
> In this case, writing to auto_sel will fail, but auto_sel is still 
> relevant.

I am not sure if we will have such platform which only supports Autonomous
mode and has auto_sel as read only. Will add handling for EOPNOTSUPP if we
have such cases as the cppc_get_reg_val() will returns this error.

Thank you,
Sumit Gupta

....


