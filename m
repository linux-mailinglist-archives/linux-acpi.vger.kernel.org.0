Return-Path: <linux-acpi+bounces-19009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D5C68CDE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1634B2ABD9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F9134D4EF;
	Tue, 18 Nov 2025 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NP5e7sCl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79D34A3A2;
	Tue, 18 Nov 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461223; cv=fail; b=WE/fjkZ3zfLnajJEHbYBYeHlPvcsUAhlmyxc0zBY33Hw7bmqDnbL41xjY8npCoZCF3U9QL5JE8p0gO7b1AcSBxraBUN2P2jy6/E/itIVNWBkP5CA8BUDQQm2waGOOMLGeIS70rMuc0caX/m4kUzA8e6rR0qVWsF8eKBU1Le9JDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461223; c=relaxed/simple;
	bh=autuPiB8AgjoINdSFOxSzh2JeetVE+v6ydzNwcGNYxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cdWRGlIPKkI5keSzZhd/rJMsQhfWIClUMYsqUnyG8ThpL3nxp9DV6hzfzcR6V59Cgv3V/ci+Ge9pcGRI59SlnDFiwbt1YfZS1gq6KmZGVvjdpAXJ2xHUqeNjoOqfMq7bE8b0cFiNSX027d1Ui7JdphYge3BPZspkD5qiopagRoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NP5e7sCl; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMPFxPMYOIJ2nH8S6LjQaENvDvi2/uUMWhwgAslBJ9faw7W/d0WmsXIWbyqPMImHMa5xy8UNaLBawxS3LG92dqVd31hE2FaCJ8Q8RAWOyynlSwTRI0FMq6xTUi0PQlmWzD8li3QoiKJAPqp0U1sdyBd6h8B/ZQ4fMM2zpWWsEsmUBt0Rht/DjE7ABhjsY8PPMQ3U8LaVHnA2p7WQUQFPp/+txEAEP1Q0PnWmKL5e4oCE1Di4dir0LZeoryARpHzuiHhr0SHJouPkvwysKpYbwz/u++fFtNo99sPr81AZhowJtAT+yrqBX6HWa+N8XLjClBB8coNnyYPGeRQVFl3TEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaaqqaUCazQ/ZHhkXQarez+BkFQjXPiNGiJXGF1iDAU=;
 b=BUbplXrn/JzvrumN2PQ0N3uKUux1skdEQsTW0dnvzghmvGlI5LIosBt7nxMaElepLPmtSgOia5zyFScpQT+GHMrVnBLmvcUWtQD7LNyX33Qg0KjQWBQD4EyNoxA9s/JxIcPQRj2gnI5pIOWTMPmPI0oHMDYJPQ0Z8iGSzAzMC/lM+P1tNuG1sPECMPL/QIQN4NPObDEl46TE1ZfZk7b4B/ixh33nsorkPOhxJcedJdVammvu31jOLQ6avGSC/I167Z5+HM33A3CPhO4Y7y3uD83GHcXzjdyO2dRRkg0BvkCMqJA+55xVRjU/K3owrgsM7j4/JQ94JZXNAvocZa3MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaaqqaUCazQ/ZHhkXQarez+BkFQjXPiNGiJXGF1iDAU=;
 b=NP5e7sCloNeWMZ2UNJoVE4myQyQNb90yuWfxdf64q9pDwm2KGvqU4BqHmBPuJyLeVbXPNP2yFpK0ClgYe+yxI9dXyvnBiiHYKLu+XauAzUT+93CcDAJGalctem5EzVVk4NqryIMLLsXv5joQin4rJ962RirTWuo+uUDLM0E4pPcx9zINaOlbXYOqd0Ijdv1kSfWmfY+is7y9z1ijC2r4ITk5iRY72pr7cN5UzBkICCPzUgKHKxNBMDZwm/hrZjcVRsYIUCIdB0GpkycmOouKM2ge2eFmxJe/N9zRaLFX1aroEmyc/wxFsWwBu+0yvgTKJgOL4q5Rt+wp7kJ34bDRfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:20:13 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:20:13 +0000
Message-ID: <c71152d2-acf3-4a06-aea5-164f661bfe2d@nvidia.com>
Date: Tue, 18 Nov 2025 15:50:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited register
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-6-sumitg@nvidia.com> <aRXCelsE0kKi4uoU@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aRXCelsE0kKi4uoU@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd50215-b38d-41ee-9724-08de268c0f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFIRmxnN29lenNvbGM2Q2NiZjM3S0JTQ3UvRFFLTklKdmdWbkc1eFd6dGpN?=
 =?utf-8?B?aC9NbEpuQWJRZEQ3cnBpU0c5WmxCSitOamN3OTZMZCtlalM3emhMVVNYa3ZD?=
 =?utf-8?B?akVtZnNzRkFjUUFJSmE5WTlERGFiS2F3akxMckVFWTYrdXFOb0RIdUtvY3Jn?=
 =?utf-8?B?K3M1TEZtSWNyNHBteE1NWHkxdXNWeHF6Y0g2a3BBSE03Vnc4Qng0MUYyWkdt?=
 =?utf-8?B?VnRKMitRS2F3SXVDNWN6V05OMDRuSXNDVjh2WG44V01IaDczMzBRMFRxTGFm?=
 =?utf-8?B?T2k5NUY2c0pkSEtLamgvbnovV2t0eWdQNzhaYlhINFlOMEllbEQ3bWMwbS9H?=
 =?utf-8?B?Q042Rkpoc2oxS0FmNStPVzlNeGpScXZ1RmhnZW5vbkJWRm5CWkZlcmRiWk91?=
 =?utf-8?B?Sy9mU2NhRUFySVdCT1ZFTm1KeDNJVitIeHcwZnRzVU1hdWc0ckFMdUdrRmNX?=
 =?utf-8?B?WFdPSnhmdDlXczI2VVBaWFdPTkMwUFdXbHNQNmdWR0tZandldXNVbEkrd1lS?=
 =?utf-8?B?cXVaeGJVOEtkcUJUUGJ0Z00wSVZwMGNxaGpKUHpDVGY2YlVYUzFSdGNMWTlH?=
 =?utf-8?B?NTN5WmhzZUVTM3hodzFYVFpDbS9ZeUx3VnhyUDZYNUFMbWtUaEpQT2VIb0ZQ?=
 =?utf-8?B?Qlo3L1U3RlY3bDhPUWJBQjlVU1NyYmlNbllXOC9FQ3JRN3FSN051OTU3c1RI?=
 =?utf-8?B?QXJIUWxvRWFrTTQ3SktRczdwWnd6UHErc251WFRGd09CYXg4Nk9KYkVKWmRy?=
 =?utf-8?B?QTluck1XbWNSTEpXRVhFTlU4d0ZOb0JnZWxEN3QzNDVRRUd4QnRmZDVNZFVq?=
 =?utf-8?B?amhqbHJwNzZhQkpTK3pJc3puVmFKVnNYclRkSFlrQVZaNEYySk1BUmF2Rzkw?=
 =?utf-8?B?MllmOUp5RWk5TzZ0ay9DYXRva2dZcHc3SkZvbGxKTU9QZmZiY3VSREh6b0Jj?=
 =?utf-8?B?OHZRRzVuM1J1ek12R3UvRk9YRzgzKzRhSjFTNTNLWkRJSHBDaDBTRDY5c3Vy?=
 =?utf-8?B?YnVRbDZhVDh1VDBxUCsydGQrb1h5Q2luQ1loUkY5bXFMWWp3VDlzUW5zcWtQ?=
 =?utf-8?B?bENwL2QyVURBSUdFWjcwalNGaFpONmtGZXVLMm8rQjJIdGRrNDBack5LOVpl?=
 =?utf-8?B?TVFXU0VzUHhpRXMwbFZsb21kTmg4K0VlblpzOENwb2tNNDVIazlDaWM3Y0F0?=
 =?utf-8?B?OFlUV3o1SXhjeWNzMnhqSlROcFNzMkY3VDRLTXVsQjBranBxUG5oRkd1clMx?=
 =?utf-8?B?MWRqV0lhelQvTUlVQXRiTXBqbEZSdVpZK2srRysweTRFckI0MzVsUVZ4VG9Z?=
 =?utf-8?B?UnZyUUtUeENyWXBOK1RndzNFc2c0ZE05dEs4cWMvc1BhU0MxV3RUeUFqQmow?=
 =?utf-8?B?Q3BRekY0MWVmdjJKak81cGhvVllXYUpzL3NXMmtCMHIvVkFhSWZjRGxZMTRy?=
 =?utf-8?B?UlBzNVorKzk5WnUwajdGRGQwN0xsUUtkNVp1VXlPOG8rdk14QjBvWVdaTVBX?=
 =?utf-8?B?WnluK04xK29xbE5VOXJOQkNFT0VFbWZyNStWNmNnTmNXK21RbXJFREF3WFY5?=
 =?utf-8?B?Vi9tQ3J5MzFKSCtUZFlUUW1vUWc4NVNsaUU1SlJQTnVRK0huUnJ0VmFqR3Y5?=
 =?utf-8?B?dSs0bE5mRWIySTZTMWNBNDF4enY4Ly9Md2FZcGZWNm5mQW1oYi9QTlZCTDZx?=
 =?utf-8?B?QnZneGEvWit4VlFjMTlUYmUwb3VkUk5UWWF3bEdRbnZVN0tGVlRNRmp4ajNF?=
 =?utf-8?B?R1JFL1loMjRnd3doTiszK2w4OTdXRVBtc1hyZUVtN29Vam5Bck5IdzNVNkNI?=
 =?utf-8?B?T1h2RCs2eGRjZEJabEttL0R0NnRIV3B3YmkwQnQwbHM3RW9iTFBKMTJxY1pQ?=
 =?utf-8?B?WmpDdXI0ZzlSNWFyNzFnUHE2M2thTHhHWkhtSzhTTGxCUXMyMU94aGo4VEha?=
 =?utf-8?Q?+T+yPe4sudnP05q3Bfj890DuNEN38vyo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azZaSCt6MlF3Z3UrT0V2UEc0cEc1L0JQVkZhMzVwRUVNTkR6RStRNFpGcXYw?=
 =?utf-8?B?M3BHY1loL3d0MllsOW5OUjJRalFlNzRVcVdSbytaVnF4MEpVYU9vcHFvVVdD?=
 =?utf-8?B?c1BOdEJxVFdVUUMycGVjMXNWOXVYeEV3M21XdWE5V1Btc1lsMnk1U25aSm9n?=
 =?utf-8?B?amZvbmYvclZ1aU10SGdmd2JqR2VkdFFnZmpGWTFzV1hpV3RYaFBJTkpTeThV?=
 =?utf-8?B?SXg1eEVMZHQ3NkNhbHJldDRkWkRCdStkM1c2OG5YblZ2cElPUnovUHdRb2lu?=
 =?utf-8?B?R0NUZUdVQWNBLzBEQS9HR295V3lwWkpVbld5YUZKS1RhZW42R0JYK08zNzJn?=
 =?utf-8?B?L2Vadk1ZYkRQLzNDdlpzKzJMU2krTmRaekFIRG53VkYzSVhEc20yWTRrTXRZ?=
 =?utf-8?B?cXRGMGxpemVaODlKVVNibjZEVGljRDQ5R3hSTGovRzlTVXVYMmVzeGJUUEly?=
 =?utf-8?B?QzA0SkNoSS9FL3lsNTQ4ZHFPbm1DZytOWFpHclBNMHJ3Ky9RdHJmVWZEWEcz?=
 =?utf-8?B?aVhPeFRKR3BhczU2WFZXNHdlOU9IaGs2WjMvT0x0d0tpc3NlVFRRMFloNENG?=
 =?utf-8?B?dHQ0NW96T0FLSjkzVXF6WUlTamxWd1pMT3VDcUxWL2hNTDJONUVOSUV6NUJn?=
 =?utf-8?B?OEJQQVpBaFBRL1BvMlFKVVl4L1BIOFBKc2ZLUkRWOWw3bzE2Ly9icjU2cTBx?=
 =?utf-8?B?SjQ5UEo1b3kxOFVkMERhcmVoZ1VUSXBwUThzN28rSVJLMVoxemJKdW44dm5Q?=
 =?utf-8?B?MDhLOFNyUUk4cGdralc0UjlmYXkzREQ1bUZtTExML3F1bnhZeGFlMVJjQ0p6?=
 =?utf-8?B?ajlpdzhySWpXaVVhc0o3Vld5ODFQZCt4dFR5akkxRGVIbHdxZ2Q3WmNZNmJo?=
 =?utf-8?B?QlI4OXhhU1JrYytZVUlscEJCeGRkTnRQcHAwOW1SUDZneitURWdHb21mSnh0?=
 =?utf-8?B?dkwveWpvMjliTmJlVnJheG1pa1FUdlh0THFkTC9mOHhPcTNWN2hEUjBZTnFt?=
 =?utf-8?B?ZnprMHNEOFJBTmdwc1ZOUW1jeG1od1NwVzVvSjUxemQ5VFVDaGlnUmlRclhn?=
 =?utf-8?B?TWYvUHVneWYxT2Q4K2ZJWTZac0pDWjdZUnBoR0cweTdvRWNxVmpRVzA3NE5Y?=
 =?utf-8?B?WTJQaDFNK1Y2Z3U0eTFoaDh1NUhxMTVBTU5keVQ2T1dFQXdZMlJHNlgvOW1V?=
 =?utf-8?B?YWV2SWpzWC9BRUlSM1lCQ1BFTEc3WFFhTEJad2VEcmlXQW5rYWlXaHR1bnhj?=
 =?utf-8?B?dWpjUTFJQW5aMXJMNk5DWTdWWkI4bHFuZHdac3BjTHVVTWhpWi9XZ09HSzJI?=
 =?utf-8?B?c29odGo0ZzkvSG1DWTRaYk5oQ3ExUDZHelhNblQxcGk2c3V5MXNJdUpKS0c1?=
 =?utf-8?B?OTlTWXJmSEFRMGFoeFR2YTI0RGlUOStmUjdhT1lrak1Ta0ZxTHM1ak1XQmhF?=
 =?utf-8?B?eE1jQXdmZEdGUlhOR1JISkpUUlh6Z0ZNRUxlbGE3cmJkWkdPWGhPbGVzOXhw?=
 =?utf-8?B?dE1EUnFjekEwS0hpaWdpL2krTzNOcGlUbXNmYXd6SmpPc0RmTHFnenJDdmFo?=
 =?utf-8?B?Z0p5QnkrVk94SHFtVjRWRVVITHF6OFVpbWNCS2ZNNjdrckNycE5TMGVFcDVP?=
 =?utf-8?B?cndXZFBnMnE5NzZPYmlZaTFyOXZEd1czMlpOV29vbWhITmg3d1VPVis2ZXVm?=
 =?utf-8?B?QmVjdW5OcG5mbHlSUDlCeVZodng0V01tb2tqcFNqMFBsdlVObzBlRENWcm1r?=
 =?utf-8?B?RkhScnY1eXhwWnJleVp3cXVic2NXVkJhL0xwRTBDa3ZPVnA5SVhtbDAydW1s?=
 =?utf-8?B?dkh0anhQbE1MeEZMQ3dSdG13V1dRVXVENGdVU0FOaG1LczhmVmpicklJNVJD?=
 =?utf-8?B?Y3NQbGxQQXdCdHFIN1JEVk9vdThiUDBuNnIyL2pTUmVPT3hlOE1nNDBYRk9y?=
 =?utf-8?B?ZEZkOE5CVWtGVmd1Y1p3NFdMcnJsZHNyUVVBQy9kSEsxYkxOL1JDYlQzMURi?=
 =?utf-8?B?YXF1RC9DZmQ5NFBsbG91OWJIcE94OFBMSW45YzBJUHZUTDc1dUdpMTNnNERs?=
 =?utf-8?B?UmZldTFFNkJab2gvT0loc2pGV285TEJPTC81UHJvU252MGszdGVCUXN3QkRZ?=
 =?utf-8?Q?VwBb8PLSecYL2mYFevvVM1aCO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd50215-b38d-41ee-9724-08de268c0f50
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:20:13.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb5ZFS4KKk5FzsrXz9VLyzaAImj+44upRX0yr2VLLFqPUoHurwCXMYEoJthCXGZ+TH9XaOmXr7RuVjTfm4Q1iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766


On 13/11/25 17:05, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> On Wednesday 05 Nov 2025 at 17:08:41 (+0530), Sumit Gupta wrote:
>> Add sysfs interface to read/write the Performance Limited register.
>>
>> The Performance Limited register indicates to the OS that an
>> unpredictable event (like thermal throttling) has limited processor
>> performance. This register is sticky and remains set until reset or
>> OS clears it by writing 0.
>>
>> The interface is exposed as:
>>   /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> What is the intended use of this interface? The performance limited
> register has a specific format of status bits with feedback about
> performance being limited temporarily and the user can only clear it.
>
> "Contains a resource descriptor with a single Register() descriptor
> that describes the register to read to determine if performance was
> limited. A nonzero value indicates performance was limited. This
> register is sticky, and will remain set until reset or OSPM clears
> it by writing 0. See the section “Performance Limiting” for more
> details." Also, "The performance limited register should only be used
> to report short term, unpredictable events (e.g., PROCHOT being
> asserted)."
>
> Therefore, I'm not seeing the value of exposing this via sysfs.
>
> Thanks,
> Ionela.
>

This enables users to detect if platform throttling impacted a workload.
Users clear the register before execution, run the workload, then check
afterward if set, hardware throttling (thermal/power/current limits)
occurred during that time window. The write operation can be restricted
to only accept 0 (clearing) to prevent writing arbitrary values.

Thank you,
Sumit Gupta

....



