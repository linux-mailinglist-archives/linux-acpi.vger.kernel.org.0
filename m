Return-Path: <linux-acpi+bounces-18835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B65C546F1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB134E122A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DBD2C11E6;
	Wed, 12 Nov 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LYWZVIzT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD32C0F96;
	Wed, 12 Nov 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978957; cv=fail; b=Y+q6GFjki0zUBd9BxphHZZZXYk6YgyW5faK5OP1sfUdK+qfK4Zl/JzKE5LRUp3wHx/P8Bw+fA0cx7h4XnAUwvUt02DUaPZFGCYuHkoWhNznedJPLyjK18w5lCeg3ZUpMI9deQbeHvL2FToL4MBpfZNQJJDMKedhP3O9hRywMrTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978957; c=relaxed/simple;
	bh=pt8cfpMgzFMT8IVmz85gdS9bRFvwqY3b+IzHNqSgSIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2VSwDSg63ckKdKVzDtG1SnJsAgSu6o9T1Uz/ibyXldQ2F7/V00rYw70ndGsuN4sTR2JKWd2FlyFlAMyU/jQzIdHnEC2tsIh8k/PfdfPcGYcg78+ZI5c+8+p21DS8EFbXPUt/nRj61tuQA/dyTADbYFYVQvEsxu8vX5/invM9W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LYWZVIzT; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvB3DR0oJX2/Z9UQc1vwhPPKHibWZESx/YJWZhGT+852kFCeTL/yC9hyO7CcTgZbQCV1Tiy1hjHXb27P2ZmOB17yHLbbHeeKnkJLq4ezXErHLJXgOSmUHktuCBwYbWxkq7aQoC93nrWpQZ2ZbEG63sdNlZQcN8kOqA+SGRGgddjlHQQ2eCK25Wcpk8DOWQajksHQWCuNsJ4Zy+ZAdFgxNTTSPmtLgoypNi9SfveXkpWOpFpu+z/UOFtrwWew5Cx4qujELzaTWQ7cmC6zMBjPJHvkOvWz6bAW8HcLYyvmUuoBP2drDfq3a0kebaZtu6g/Fek4roXTuXsCgQA9bYO4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyNeouXkZHZrJZYabzmpO+sSNRTvehS06fKUh0vWrGo=;
 b=hqbf6+bj3MstLYuRVkiyd23aTOlvcib0fnDJ/bso67G1CYOPAkyamlI7khWIdWkeKfcNT7o5gHAJHyNnNLVLnJWpOz3TgE6KfS5rCJeg5XO4q1ULxEAD8kRyw1IaDl1F8MRiWWHQQVbzADSumt/yGUQ972dyuSaGqfwSNNH0nOaldHoWctTL8C4gVAyxBhC0matFYGe5/0Ykn3knkzyau967wux0eF1tjHCG0eYYWS8RaIm+O2k+nkO5k29zb80QDfk3kA1WtKton1dOZdr5xwKOtE3d1BLkC4GG70SddPFNjnPXEfS6E0hd8mi1+Z2GLzAAyHFgum1jFV/RGH8Nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyNeouXkZHZrJZYabzmpO+sSNRTvehS06fKUh0vWrGo=;
 b=LYWZVIzThal5LV6VkH3i6s0IwkfY/38YjOxGLJLwmayR7761XSWqjux/38wwkWRf8Rih/OewAQCYgPF+kGZp4tJRkaI2EYCyb4BzfHjApTlupYBUlmHbhAmNPHAnb07AygdwQyENkmPIDmgMS6BTXib81/quaZiioEPa+2kp5s3a8fi5WxR8Ydeex8Ls0pGJrPXuOQ+fLUzBgpLKyfHqRUgvY2X93kab7ijtrEily8sSgEo0qb6EuJ7tkS4Mp1RqSmxkB5L6zVB7Y24l0+fLT7C7kbq/McS9ExIqfZlgSl9OQNJ6iiF8g++TsF1IGhWvhjX31ckw3nh0hpSDZbnQ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Wed, 12 Nov 2025 20:22:22 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 12 Nov 2025
 20:22:22 +0000
Message-ID: <df461f78-2dd4-4c94-9c66-e587c229d148@nvidia.com>
Date: Wed, 12 Nov 2025 12:22:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-4-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-4-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c31150-12a9-4956-5e9f-08de22292f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEkrcENCQ2oxWHVoS1o4SFlBdVNHdzJ1dExGUVNmSS9zTDhUSmRiYWFQMU42?=
 =?utf-8?B?M0xJU3RSRTBQZXBzaVpKS3JuaVh2MENvcGZ1VzFpQjR2RFByWk1ybU9tdGF6?=
 =?utf-8?B?S0RHUzFHZG51bHZFWHJjM0RTNHNJOFNXeXJUemdWOXVWMlRWWkhmVjZ5Ynhv?=
 =?utf-8?B?Mk42SW9mRVJCUHordGtKTGtWQWhWdjc5eVI3RWVOOERpcEFLWTlvM0dTSGEv?=
 =?utf-8?B?SHBKMEdNd1paeUZyY1g4MXhVby9QMGNjWEswc2dlWElIOG56Vitacnlic1Bx?=
 =?utf-8?B?NnhQMFhIN2wrenk2M3lsa2dsVGsyeUFpL1E3dnJsd2pJSjQvTW1FeDl6bUtH?=
 =?utf-8?B?ZmlicTBNZERQUTNBUXZadTlwZSs1VjZUSFBCT3Z2V3FkVmhFRG44Nko5NHo3?=
 =?utf-8?B?dFhGTm1uMUV0WUNodmRGeDRYWWFtMDNVaWhtTGlqb2pRNmpwaGMxTnc1M0th?=
 =?utf-8?B?YWZMKy9WSCtjUnVRSFRHQnhIT05xRkpNYitvbzBWYnBmWkgvVjRLRmVDT0FC?=
 =?utf-8?B?byt1T1pUQmIzbTVFNlpRa2Zrb2sxOHR6Q0F3OE9Yc3RxYjB4R2dZY1kvYkxw?=
 =?utf-8?B?TW03dEhQVjEwaTE5c2hQU1FxdVpJU2cxTmFwUjBOT2hpemxFdkYrdHFBSXBx?=
 =?utf-8?B?d1NUTHFFMkRPZUtaK2orN21zTFlQc1B0OFdidzFtYkJVaWpZT215cmVXSEVZ?=
 =?utf-8?B?Ym9xcTI1TDdpMGFTREU0K0FXbHFDQitrdlRkUkJpOEZZRFB4NU56V2pVaUJ4?=
 =?utf-8?B?dHpyRHlrRHViQkhWUnVEKzkrQWhKUVdDU01iUkowcTZkZjdDS3pWOU9GNUdC?=
 =?utf-8?B?a0ZaTjB0NWZsbHFGR0ZGYnI1aHBWVnBBajMyTFIwZTFuZmN2QThhUE8yek5v?=
 =?utf-8?B?M2pxTFlsZDJycUJQc2VxMG1ETnprSFFiTW5Zd0RFQnIrblhtSXVUVFdmUjhX?=
 =?utf-8?B?elFFSVZBQkJ3UlUwb0JsUWUxVHlRY0ZZRjBoNldSTW5tTUNic2dtMVlyakJE?=
 =?utf-8?B?by8yUVBER1Bxd2ExMDNOcXArSzFHRkpHbjBSN0xmVnBsNTBNT0VBYkg3ajZ6?=
 =?utf-8?B?bzJRKzU4Q3BrdDBQckwyUDFmbTIvRStMd216WCtvYTZjN1BKMzgwZmJnYU1S?=
 =?utf-8?B?YXByZGYrNmxjK2o2UU5ubGQ0QjFCbDNCaFlGczBKUEFzemVFcWQ3bm1idnZW?=
 =?utf-8?B?WkZmZ1RwVlZ2QjhseTlFSUw0K2d1K3BrZkVJRG52b2lrdEpVdSt6UGNwQTF1?=
 =?utf-8?B?cks1TTBzQVJrN21RZWdPT1BnTy9lc0Q0T2xYZExaVThrSUlPSFZGRTdKbzBV?=
 =?utf-8?B?dGJwRGpFaWFHemZUVEZzTzFGQ0U1elRVcytpYXdlc3Z5TDU0Z0VTNjdoUTd6?=
 =?utf-8?B?OW52UzFlb3JkQmNiWmZHMUw5MDg3Uld4aFlHM1lFSUduTzFxa2ducVFqNEhW?=
 =?utf-8?B?WmJ5YXBWZ041eW90ZSt6c1l2WjdPVnRHVmtFWS8zTDFMZ3cxdFh5T0NDSUIr?=
 =?utf-8?B?ZytNakpYVk1SSHdsR3dzVCs0YnB1U2Vjcy9IemR6dE9YVjVjQWdXNHlxQWty?=
 =?utf-8?B?a0FhNXQzYVRERStZckNNandZbmE0M3BldTdyWUhFajhldW1mdnNnLzlmR3hi?=
 =?utf-8?B?Tkx2cGxKaTBGS04reGp2bWpvaERsN2JVMFduMUxsNXJKaDhSWXhyL1RBNnFP?=
 =?utf-8?B?OUR5N1lROHVGT3ZBTUE4NlNmeDZtYjJUenhScmlWUkFCOEJDa2hBSUd5WDkr?=
 =?utf-8?B?d0MwbVgwbm1QYWhZZ3UvYXhoa0VEcmkyZHpkRHlpNU4zdTJNOTNHN29vT3li?=
 =?utf-8?B?RFhKbkJma0RXYnJFb3NPa1BmdTNnWGNwV2FmeEpKbUMwQW4rajVBR2x0dHFP?=
 =?utf-8?B?YWIzSUNuaWJVbXpaT3RyODZ3TzJZOWpBWllPd25SYmxOUFh4RjRFeXloVlV0?=
 =?utf-8?Q?NSqmR5vBQKWlloKZRdSk+tT+tFkOQIsf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVJLNFF2RHh4YzRqQitrekUxalIyM0QyNE42ODRaRVl0M3AwbU1FRFVlK1o0?=
 =?utf-8?B?dnA5MFBPSTVreHF1NWwyR0FLWmc4L3hsS3FTckkrcE8yN3d6dnhjQWlxTWFD?=
 =?utf-8?B?UDNhaEZUYThYWlh6OGYrMWEzSnFWODZqZkJIWW0zb0FZYzVTWldrOUVNWXQv?=
 =?utf-8?B?TjlvTHk1QkN5QnBzeGI0dHRMMEJsUi9ReXFBZzZsME5YV2VrMGtUa1hkZFQ3?=
 =?utf-8?B?RTZRSkVvY3pydUt3ZjBMbm9JUU1yejNoVjdHdUtSSEZFeDlEU2V1SFNCV2g5?=
 =?utf-8?B?YzY2MlBRK3RucEpUejJIdmtmU0pmekhmTDJiRlROcXZUSmsweXZyK3N1dnpT?=
 =?utf-8?B?WVMvQVNJSWFuQWRGYzZ6amJyOXgyZWw4ZE9qUVFPbllKTkUvbVNrMHV2aUdM?=
 =?utf-8?B?QlNFUzhWaVluQWJQRVhUaUFBQVE5REJHZTRnTEdLaTBDeC9WcTdBTXk3TEVk?=
 =?utf-8?B?ME1hU2UwTXpLbktXdFkralBrYkF2SDQ3clpFTzRtRzcyRXA5TThndlliaDRC?=
 =?utf-8?B?M3hpMmNQSlV0MVNybWk0NVBHQ1pkMkw2eFJUanAwNXpHQlJPdEp5ODlmQ3Z1?=
 =?utf-8?B?NW9jYjVQblhSbHRVRUNJVlNheG1FNFVTb0syR1pvNUdDM0ZVOXY4cVdGS1d0?=
 =?utf-8?B?MlVvc3Nmb29jUU9XNW9DUlc1VGVUWDJGNzdHbU1TeUdsK3FWcm9BY0FrWXNL?=
 =?utf-8?B?RndRTm9SZ0VKVzgvL1B4WDRCKzVqYytMVytjRURzYVRnTmx4RmdxSVBEQnpm?=
 =?utf-8?B?V3RVVVJPWXcyMVlmWitIV2ZEbHVsVW5DOWxmNlI3ZUhNem80VGRCVVBSUi9o?=
 =?utf-8?B?Rmw5V2gzOXp1dlhNd2tYd2pSTk5Dcmd5WGM5ZEY0dEtleHc2RE9jMkNvUUdo?=
 =?utf-8?B?N3Z4L0pldGJpekhuUkFzbEhOOWFwSFlxQ200OU5WdDJMZHZmUEd5VnZWNkVX?=
 =?utf-8?B?RGFEVHcxelVZenpKalpVNmRJVHN5OExLZlNSeVgvNHptVFNmai9kaVF3dlUz?=
 =?utf-8?B?YVhaNEMzQVJiL0Z5anlMUkZpUnBsbDlPYzlmUU5ZTldPZjdqekNhb3MxQjBm?=
 =?utf-8?B?OFZYclZscnlGM2RvSjZiTXd5anpyZ3BXVmZiTUpoRlhLeFZUYkpDekk0TWNj?=
 =?utf-8?B?QUJXdUx3SE16TEJJRWYxQTJiekJCVklQZzUzd0Z4eGcreVJ4WWRBSkZ6NGM0?=
 =?utf-8?B?WVg3dzFCV2hKQU1Rc2kwbHNGKzBJZVBVU1NIaUs5VkVnZFgrTzM2VlpZU3E4?=
 =?utf-8?B?d1N1NXh2bzdOc3lvQ0tHcXVNYXVsWG5JcldrWW5wanhYbUFvN1BzOERBM1RP?=
 =?utf-8?B?WE9SZ1dLZDVpSGxoRUFhZDNWR0hLWndVNFZsamZRK1d4WTh2aXNDd0g4elAy?=
 =?utf-8?B?S3pHM3lJdThObUUzbjFocUdDZDlhcnJBenIrYkJZZzg5Qk83cDhGV2tOVS91?=
 =?utf-8?B?USs3Y3hBZjJJeG8vUGg4T2FOZStNWEZKaEV6YWZrclV6ektpRHNzS2d3NEF1?=
 =?utf-8?B?RmlYb1Z5RTBpWlVlREpyMWZlVEQ4TVZNdm9oMG04bTd0TTQ2WnZwYjRnUlpE?=
 =?utf-8?B?Z1VsQ0xJTFhNbUFuei9rNjE1ZS9zTWJUamtEdFZqWUE4MVRVMlZ3Ky8xbitq?=
 =?utf-8?B?VUtyRis0M1ZPU0swVzcxeTNnWElIUnRKQ2dER0ZwVlA2Nkw2dUg2NXpVNVdM?=
 =?utf-8?B?N0NiOSt4ckNhZDJFcllKSDZGcTNCdGVmYWZ6akNrekEwVDMyQ1VEUlhXK3ov?=
 =?utf-8?B?NmVJT04zSWVHTlFmOXI3QmpaSE15a0JxczMyRTJmOHZVVk5yMytvL2NOZjQy?=
 =?utf-8?B?Qjh4Tjg4cHRGb1lDblJJTkYyNklUdzV0UlZsUnM4NkpKSU5nS0tXdmpzVDJI?=
 =?utf-8?B?KzJPU1BaUlpUNVlLTkJSbzk1YVJNWU1RaEtlTjV5VExpSHJwSUxlQnBZTy9k?=
 =?utf-8?B?bmNIZllyeEtHS1hqZmMrdy9uVzBQdE1sb0NXSVhpdVlHWWJSYWlLVHI1VHNw?=
 =?utf-8?B?eTg3WUl5RitRdDc3VzZ5c1B1cHpacWJsWnUyemhxQ1dsa1FKc1FpU3B5Vm9V?=
 =?utf-8?B?Z0tUTGlxWm1vRGF1OHllYnhUdmYrWmlCa2J0K0M4cTAwZ2dZOHV0QUFxazZV?=
 =?utf-8?Q?Z4kwkdi59PfLfhTME6FhjQOV5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c31150-12a9-4956-5e9f-08de22292f85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:22:22.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKAQStrgqwKYWMO7OKzFaWklWzrAv9+mJeK/uyv6tH570VhNzCoSZ/xh5nfPGqaY1i7hqOMOu2fHvInAmdHKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620



On 11/7/25 04:34, Ben Horgan wrote:
> In actbl2.h, struct acpi_pptt_cache describes the fields in the original
> cache type structure. In PPTT table version 3 a new field was added at the
> end, cache_id. This is described in struct acpi_pptt_cache_v1. Introduce
> the new, acpi_pptt_cache_v1_full to contain both these structures. Update
> the existing code to use this new struct. This simplifies the code, removes
> a non-standard use of ACPI_ADD_PTR and allows using the length in the
> header to check if the cache_id is valid.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

