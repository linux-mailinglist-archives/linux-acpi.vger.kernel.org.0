Return-Path: <linux-acpi+bounces-17493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1ECBB26D5
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 05:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527F31C685D
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56A23D7D0;
	Thu,  2 Oct 2025 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMuuKHJq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21B35965;
	Thu,  2 Oct 2025 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759375290; cv=fail; b=XzyhjysTZWxDhjNc1vcrq6kdSA3ex8PToBCvLtR5n2BrzV4XPnsoE8kiPycYYIIb3xSpUXTWv+U+E7a7Pvs5Qm7DN04/Q0vN5tgCDjzksIrq8Mbek1skaNQF3+Z4rw9nAizCYRXyPWFZTo5Cyd+x9/6onYuVCYfAwKQLCMPwzjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759375290; c=relaxed/simple;
	bh=yOT+dAaRq4RBjZYKKhsB7QJoLVsSVSnNqFJUTyIyyfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pPrlgDWSH6zwktCotPSBBUKeBPMAq1ONkA3qk2y8oMwY4so7kjHW2vVGn9WlE3F3fZGYi+FFQdl0GPC81NZrnLTeR1BvZm7UDxEE8x3lgF392Igsims96crp2SNSOxAewXRv5IHB4FBqDqBa7jDhybvv9kL/DnqY5WzHqSHC4M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMuuKHJq; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR0DoduAHySOlG9DW2kkivJLGL5bmG553ME9orp2cmozeULiuOyUB+LbE7mAkdgerRzD3OYRlbTNDzg46GTr1GvBnuiNTWeKP8yl6ZSsdW4aUB+tmM/NF78BFN4zIlRBATXy9c9t21bZSyTTP/4tRZ44rh9TDJ0hDAauEY51p7A+NwE+42bj6QHTF9e4HFkhAvkuTjVnbFOsrFwBq+Q0UBRJErT8rhARR8NvidxgOkIdr8S34wmxNlnpfjE4AD8OgcGXxOJBk9ilOOkSHaQjbnlGzQ6wiBJQsSczRjA3SFl1s6r4KXsBKalCAaBS5LudeYgS+fswd9Przp6xWeOeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbB5YHq6WM7mUBljA7YEAMdNvo8TjUutQbtlw0XcUSM=;
 b=ZUnZH7FpzX/7os2AMNolcIDCrMmzK/MsEu6yDTBjg5BncY0hrAbEQ+AMxsuu5udgsDB8SJ0k0dGQGLtNYdTPaorcdNggXxLj1E+UCBxV001QzNwxqiZRBjg305bqwcLefg8Ed0QA4UcZTAq41uXXjrvKCBB890NN2FegscpdInqi44OhNGBxEikTNfRBj/UdVzoDqSgk6Ly0+TOI8yY9dKr/d7QUIgNjXWIHgp6dkvybbaneYfQ4FXy8ashX48yg+nmBo3ClYdsg6AkhujBmoMZga8RRc1qGpWkJA8/cW4LHBdW1nayGs+e4NxSSBsCOgm84vq2Dv8Ts1OVK9KEwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbB5YHq6WM7mUBljA7YEAMdNvo8TjUutQbtlw0XcUSM=;
 b=GMuuKHJqi2k8jWZnd5s1XvpbEM4FRzfFn0csOfCicXPm5teZxZlO3LMwd720OXa2WyMcZMiAl9DC1y/hkUGpQfaVbXLM4/8dpMEekcqzbmCnleFUKwDXbcmQ3zRyVjEmdXiljMs9MQlCx/fmMDTCCwnNLSDwfBmt0RwiE2/yR8YN7/MlJ7SG/6Ds0Lckeo8WmtnLwkTmmV4NgikC3eTvsy2bhjRbfqqT+FfwlCzTq4+Yinx3eq8n+GIPXU/6oO6N9Wla2UCdqOYvMICx+1Gzizj7m/AEsapHOE8r4N2/v1u6BHGKoMJ1Qv0TWfRUVGy78g1YBFofvTIyTQM3onQaDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 2 Oct
 2025 03:21:21 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 03:21:21 +0000
Message-ID: <53c52ef8-823e-4627-8fff-e09da33d8e7b@nvidia.com>
Date: Wed, 1 Oct 2025 20:21:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-7-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 963c1dbe-417d-434d-29fd-08de0162c22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhLVlA1NVlaNE91djhVMEtLeTZIaUhiYnBMdmRjRGxwY0laTC9BNXhIZVpo?=
 =?utf-8?B?SFhsTTdobDV6UGUrVDZJUDFwck1YNUdWVnEwOGpZOEJOOUZaZFkxWkF6WFNN?=
 =?utf-8?B?NVJUWVdqOGhEUzVVcnZLZUU0QVZXVktXMG9ZVXhLcGxzeEdzNE55SFBQNlBr?=
 =?utf-8?B?b3F4VmVyMmJRc0dpSkFBRjdLYzRSTHNCQ2p3NG54RXJqVVNTdk9SVTRIUHpZ?=
 =?utf-8?B?NmI3MUF4ZktuK3YwK2RuWmExcW5GK0xZZ1IzM2QreUt5ZTRkeUx1YmdJdXJC?=
 =?utf-8?B?eWxoaXdIRU15L2crbkhDOU1uTmlmaDFtWFFPVUVjZlZjZmFsRUc3K1NReWNW?=
 =?utf-8?B?N3hKMGdIdzdqd3JuNDE3dS9aTjhEV2JpeU1PMUZiOER5cmFjLzIxWVFGRmRv?=
 =?utf-8?B?TUp6TWlHN1NlNTliS010VUNrdnNhdEY0WjV6TVB2ai9BZGh1a2VjM0daQVo2?=
 =?utf-8?B?OGw3Nk9ldnFIbGdqTnlvT1BZdzBJZTJSd3lDVFErTC85dkVYMW95NlcwSGl1?=
 =?utf-8?B?M2NZS25LYWl3a0ZjR1ZsZXR4WW1qWXNnV1pLVlNVbUNNTnM5ZndHd0U2OFJa?=
 =?utf-8?B?RjcyQ2lna2ZCOG00bDM1aXFrczNENHRSM1VJY2tHTkg0SDFWTjRJc2RFd3NZ?=
 =?utf-8?B?NUJhYVZQbmNIQ2YyMjNFL2V4MndEU0lCdFJEV2xNMUZVMk9TWHM1WHFiVmtt?=
 =?utf-8?B?UG1WWmZ2akpVR2VQeEs5Uk5kaFdpSXNObXB6dkJ1R1FMcjZjalV6N2U0STFh?=
 =?utf-8?B?b2M3ZE5FMDFMR3dHNE43RSs5YkpFSDBKazk5RllZUVBoRUhXOFI4dkw2aGV0?=
 =?utf-8?B?TmNCZ0V0UEZ0eldrclI0T1JJTDE5azdYMThMbUZ4akVlVUNJVFNzTEpUajlX?=
 =?utf-8?B?MmNmcGxUSXpka1NzRFlzdFRpRkRYY1lyaE5tVHRCeTNoQWRXTTUxcWtoNGJ3?=
 =?utf-8?B?aWQvK1VObFlSSzFMdTBRN3N6OEE3cGp0OU9jSmRCczFSMlVnZUw5YjA0UGF4?=
 =?utf-8?B?UFhuNTNCOUFWemIwYmF2blI2M2VXd1dBRDNlVVJhM0h6SEtmdjd6OUlSWExO?=
 =?utf-8?B?eWhNcFM2Sk1SQjZ0RTlQNUgxRDdPQ25xbEw1K1lFeklCSnBqaXJ5bWU3R3VX?=
 =?utf-8?B?UTBxTm44eERCRTFQY1VtYVlWODY3aXRxYWIxUWg1OTZjZUVrM3VYV01LUFRO?=
 =?utf-8?B?N1hyeWJxVnl5dFd3U2Z5MlFUV0xjQzFzR3BVQWt4S25OdkNiNUZlUGl6WmNK?=
 =?utf-8?B?c0FqbitHcXdNMzM1TnMxcFFUOTBDK0FYV2JSd2EwV2JpTG9QUXlPdUVTZWRu?=
 =?utf-8?B?WE8wRjJwdVJDMVN5WWV6MXNacm5ETk9LSHlhSFFuNzJWQnVqVXN3L2ZmOUhp?=
 =?utf-8?B?eUF2TWw0UnlZcHA3c0Urb0xyL0MxUExSWlRrRTkzS3AwMTFBV05NNUNHKzZz?=
 =?utf-8?B?eGdKdXVQeEduaXRmSjV1Qmh4NldqSlV5L3o2S1NidDB1azhQSFBISGNKM1o2?=
 =?utf-8?B?ZlZGZDJybVh0ZHozTHRrTE5sQUVLUFhLaFVpVHYxUmVmMVVOUUhPOTRLalNq?=
 =?utf-8?B?M1lZV2hudUZMcFFEcHBGWEF3dlZvVDNEMHNjeTRUUlRqdGFTV2JQaFpReXE1?=
 =?utf-8?B?QXFaSE1QWFM5V1VUd1UrV3RQb3NPTXowVk0yRDA2N1VpQllXQ1gwMW84ajlr?=
 =?utf-8?B?VGVSV0tTU0pPM0VQVjNrQTRUdHVlcTdQWit4cFloTlFlYVhkV2g5dGZWL3Ba?=
 =?utf-8?B?WHRDLzk4bVdIcW8yTHBmcGdTblZsa21kb2VhYVFJZ0xDMVVoNmZuTnNkN1ZW?=
 =?utf-8?B?TnB1ZjZyeU9CcDJ5QXgrR3BzUDBnL0hUTFNpUk5FVVd0NkpnbHZhM2wzYmNo?=
 =?utf-8?B?c1QyVDhRY3lNTVVCUjk5aW1hY3V4cUIzRjdYVzN5MWNlZkNoMHh4U3UzRHJG?=
 =?utf-8?B?ZnFYQWljR0JlYm96OVRRSUVzdXRleExnWGFyMXFrOHZMQ3QrWTlCMjNjb0R3?=
 =?utf-8?B?QjZjZ0dtYU93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG5IaElYU3dCM3FyL2dvTUZnSVl1a2VSSjlrU1g2eHo1N0FWVmU3cGZyZ0VL?=
 =?utf-8?B?aUNmcEpMaWpUeks0VE11SnFsQ1dVWnA5MW1zY2lYTXpNMGNsZXMxeExEZ0Rv?=
 =?utf-8?B?MFFFTklOeVlBMVFnY2ZodVRCL3NPNktYN0k4aFlNMWZnbVdrcCtkQmV3STVF?=
 =?utf-8?B?enVwd3JRQlhIV0ozQkV5VXZWQUtTRFg3YnRSWll0L2txak5yU2VhbksxYU5S?=
 =?utf-8?B?Z3B0S3lwMDNwanlHWDRVSHFiQUZqbG9ENVhiMmpaWWVHQW1WeC9FeUlFRmIz?=
 =?utf-8?B?djB0L0ZOU0FrMVlwY3Rncy9QcVRRcldhNG5GdVNzRWZhaTVLV2xIbGRydGgy?=
 =?utf-8?B?WVJwbzZTL3podHZaZElLdm9MajNsdGJUeWdvd1N5MzA0a3J0NkJvMnZ1MitM?=
 =?utf-8?B?U2l0VXhDNEZQbDVod1dwdnZQV0dpdC9ZNTREZFhoUlJWbHA0Tlp0dU92UlJu?=
 =?utf-8?B?NGZXOFd5QjJvYXFwZSthS3hMS0pKaHRjRUtxQ00zbUZON2syTWlTVjhQS1VY?=
 =?utf-8?B?YnBVSkRyRnNmU1UrRXJ1T3ZLZ283TG01L2VmbFppM3lpT2pvYnZjU0cyMlFL?=
 =?utf-8?B?cC9iVkp4R25JRmFvemlYdVc3bHJFRlowT09QUEJLd0lScmREMnkxeTY5VkUz?=
 =?utf-8?B?Z1ZWeHM3NjZoby9qVnRpK1lIRUpBZHliQy9ubEpQVUR1VHNtWFpkRzFsS3d6?=
 =?utf-8?B?aHpOSkZxcFZOakhiamsvblhKVWxidkViTEtIcmlwMmhiN2tJWW5pYVJDYVUv?=
 =?utf-8?B?ZWxNc2NLN3BNdktlK01qZTFPTEVPUXRsS0d4QXdBRTBsb3p6YTlCQ2tVYndP?=
 =?utf-8?B?Smg1c2hiRXV3ODN2TWhxbERhNnl5RGJqSDFVNTdxZ0tZNHArZnlscitQbVd6?=
 =?utf-8?B?WERWU0RDNWRaYjRtMzcwNk1GTDR5Z3FvekpRM2ZOaG9qZ2JISFBtUHdWZnFz?=
 =?utf-8?B?YnJUYXBiZ2p1a1RDd05sY1B3czNTU1Z0TDdCNWVwejhQRDkyQkVGTjh2YUoy?=
 =?utf-8?B?bDViUEdXaFdrMHNtWGxCdXBSVWpoZ2trQWpQSmRRcy93TUN0ei9VQVRrWGF1?=
 =?utf-8?B?Q1ZEeERBalc3T2RpRnAyS1l3eEJGdURMci9vckFNODlNV1JkS3dwekhQU3hH?=
 =?utf-8?B?a3B0dzFob2Ird1BxTnc2ZGQ2NmlndldwMDFnSzV5ZjNtU2s2eVVoK3dhejBw?=
 =?utf-8?B?YkVpU2w0OVBSZE53MnZYMmVsZ1N3b2t4di9renh3NDVUOXNtM3QwZitINzdj?=
 =?utf-8?B?c0N2VWZXZDVvMGxpd3AxQlpzbm9SVTFxckNhRlRSdGpnM0dIZSs5K1YyallI?=
 =?utf-8?B?a1VZNkJXREtEWi9TUktldlZyRzFJTngyTjBQZUo4NlQvcW1FZVRJbWhvelAy?=
 =?utf-8?B?dVRwcWVncWE4ckJ2UDZEM3Ixc2VDZUM3OHZlK0R0KzBWL2tPUDFHek5zdXlz?=
 =?utf-8?B?TmhWNVc4YURJZ05WbitYK1g2cUltRDdIVDVSUERXVytpL2xqWVpsdTg5WWN4?=
 =?utf-8?B?ZmZsaHRCaDZNOVVCa2ZvVHNWNnJ1Nm5GbGdCK1NEZ1Z4cDFrNjlPU0RjUjB0?=
 =?utf-8?B?OFNaMENkR1ZxTTZHRlZhRytGakU1R2k3bmJSK3NJSStMRHlTaG12cWVncFR4?=
 =?utf-8?B?Vkx2dUdITjlhMENlTzRuWEdMS25KaVJUQlAzRTdDZHVOL2U3YStPeVpFejN5?=
 =?utf-8?B?VVhKTzREbEZlYjJPdWpZNDhNeWpTb01Ub3VzZ01xMkVIazcvL0VCUUQxOUZH?=
 =?utf-8?B?Ulpld2hkc3QyNEx1Z3c5ZG40VVZWcHplbHk3T1JsTUFKM2ZlOFI2cVJvdkpn?=
 =?utf-8?B?dnNBTEdjZlFic2ZCN3A2eTFmMmJhQTB4NElaMGpLWmw5by96RG1BeXRtUUM0?=
 =?utf-8?B?a2pOMnRxMWJ2RkFwMWgwaDRXcnlRMHNyU0FDRFVudEF5Y1F2R0V6UVZMUjJ6?=
 =?utf-8?B?RzIreGhzUlhZb0NtNlM5WElVL2pIN1c3djVwVS9EdEQraXlNVnByam1ITTlI?=
 =?utf-8?B?YmMvNjRYMzZmM1BVRnl2alBBVmJzQXZ2VmhHWmFnK2I1N1pkWjNDSFBwRG1H?=
 =?utf-8?B?bjNYRXFyemZvQXhBV3VjVEs0aWVqaHp3YTlueXlXSTNJNWd2a0ZuRm9qaDBZ?=
 =?utf-8?Q?r1BFhTcgrNZ6pMNb4vtVLG932?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963c1dbe-417d-434d-29fd-08de0162c22e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 03:21:21.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VvhybRSCkrgFhXl7MSzdJA3JM4FKkx/cXSGP4zcX5tLBclUYZd8O8PSBzYrZMkpqtegeNVZDcOHnmYBC08uWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
>
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data.
>
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Signed-off-by: James Morse <james.morse@arm.com>
>
> ---
> Changes since v1:
>   * Whitespace.
>   * Gave GLOBAL_AFFINITY a pre-processor'd name.
>   * Fixed assumption that there are zero functional dependencies.
>   * Bounds check walking of the MSC RIS.
>   * More bounds checking in the main table walk.
>   * Check for nonsense numbers of function dependencies.
>   * Smattering of pr_debug() to help folk feeding line-noise to the parser.
>   * Changed the comment flavour on the SPDX string.
>   * Removed additional table check.
>   * More comment wrangling.
>
> Changes since RFC:
>   * Used DEFINE_RES_IRQ_NAMED() and friends macros.
>   * Additional error handling.
>   * Check for zero sized MSC.
>   * Allow table revisions greater than 1. (no spec for revision 0!)
>   * Use cleanup helpers to retrive ACPI tables, which allows some functions
>     to be folded together.
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/mpam.c   | 361 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/tables.c       |   2 +-
>   include/linux/acpi.h        |  12 ++
>   include/linux/arm_mpam.h    |  48 +++++
>   7 files changed, 427 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/acpi/arm64/mpam.c
>   create mode 100644 include/linux/arm_mpam.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4be8a13505bf..6487c511bdc6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>   
>   config ARM64_MPAM
>   	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>   	help
>   	  Memory System Resource Partitioning and Monitoring (MPAM) is an
>   	  optional extension to the Arm architecture that allows each
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>   
>   config ACPI_APMT
>   	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ACPI_FFH)		+= ffh.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
>   obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>   obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..fd9cfa143676
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/*
> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
> +
> +static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
> +				   u32 flags, int *irq,
> +				   u32 processor_container_uid)
> +{
> +	int sense;
> +
> +	if (!intid)
> +		return false;
> +
> +	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
> +	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return false;
> +
> +	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
> +
> +	if (16 <= intid && intid < 32 && processor_container_uid != GLOBAL_AFFINITY) {
> +		pr_err_once("Partitioned interrupts not supported\n");
> +		return false;
> +	}
> +
> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
> +	if (*irq <= 0) {
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> +			    intid);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx)
> +{
> +	u32 flags, aff;
> +	int irq;
> +
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->overflow_interrupt_affinity;
> +	else
> +		aff = GLOBAL_AFFINITY;
> +	if (acpi_mpam_register_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
> +
> +	flags = tbl_msc->error_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->error_interrupt_affinity;
> +	else
> +		aff = GLOBAL_AFFINITY;
> +	if (acpi_mpam_register_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
> +}
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res)
> +{
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id = res->locator.cache_locator.cache_reference;
> +		level = find_acpi_cache_level_from_id(cache_id);
> +		if (level <= 0) {
> +			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);

Since level could be negative value here, printing it as %u converts it 
to positive value and will cause debug difficulty. For example, -ENOENT 
returned by find_acpi_cache_level_from_id() will be printed as 
4294967294(instead of -2) which is hard to know the error code.

Suggest to change this to %d:

			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);

> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid == NUMA_NO_NODE)
> +			nid = 0;
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
> +				       255, nid);
> +	default:
> +		/* These get discovered later and treated as unknown */
> +		return 0;
> +	}
> +}
> +
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	int i, err;
> +	char *ptr, *table_end;
> +	struct acpi_mpam_resource_node *resource;
> +
> +	ptr = (char *)(tbl_msc + 1);
> +	table_end = ptr + tbl_msc->length;
> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
> +		u64 max_deps, remaining_table;
> +
> +		if (ptr + sizeof(*resource) > table_end)
> +			return -EINVAL;
> +
> +		resource = (struct acpi_mpam_resource_node *)ptr;
> +
> +		remaining_table = table_end - ptr;
> +		max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
> +		if (resource->num_functional_deps > max_deps) {
> +			pr_debug("MSC has impossible number of functional dependencies\n");
> +			return -EINVAL;
> +		}
> +
> +		err = acpi_mpam_parse_resource(msc, resource);
> +		if (err)
> +			return err;
> +
> +		ptr += sizeof(*resource);
> +		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];
> +	bool acpi_id_valid = false;
> +	struct acpi_device *buddy;
> +	char uid[11];
> +	int err;
> +
> +	memset(&hid, 0, sizeof(hid));
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));
> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id = tbl_msc->instance_id_linked_device;
> +		acpi_id_valid = true;
> +	}
> +
> +	err = snprintf(uid, sizeof(uid), "%u",
> +		       tbl_msc->instance_id_linked_device);
> +	if (err >= sizeof(uid)) {

err could be negative error code. This error validation only checks size 
but not error code.

Better to change it to

         if (err < 0 || err >= sizeof(uid))

[SNIP]

Thanks.

-Fenghua


