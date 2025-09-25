Return-Path: <linux-acpi+bounces-17298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA2B9DBB8
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17F83AA910
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1D2E172E;
	Thu, 25 Sep 2025 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfMTQCxJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DF3C01;
	Thu, 25 Sep 2025 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783231; cv=fail; b=W1XiYZ535kCyzd1j9zpMV5BCSh3+PMC19LX5g1SgndBbwcS57D3rssXiLIo8gGpz8ePJB+0I5FAblxP9jVP48yMnINk/Tzo8vRZ8ySNUfqj+HRnZKVO1JosC1c4h39S9wyXTGPQvcc90hbMyGmgPDWbe1Ef6Tm6sGxNbQkLpm6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783231; c=relaxed/simple;
	bh=WIJ4v+IHoS3VtAWRcUbB3NwcaYkwUP2/txWZeWp2eMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHM9j85WrimYiSYKTnZR4cNLXybc1gaT8DCzLOdWRhZrs7GhF7NGpiIfm5xLiU7KGfaIGFgYYN8kZDWYTdLT4gvIhygwuDTgtgpe7jqVOcoA7E9FDw1KqiV9pEjSSh/Pbud1yGfYSzp2neSI9F6OFdqzyGXEueiglv4KQp4Lr04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfMTQCxJ; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrNiFO8lhSpIfbJzwmA2ac/O3bhbqXKLg77SvLGIGJvI5rnITcvnLAPA0R32waKdML97AUEzEKOg8AgP/QYZP1/05KlS+0zCjiVK2AeirtidHCIaR/PCcorUe/VxkqyanRPhRymOPEHT/gyG+Z8ElvUnW1klR3Ys8Y/TzOxuXg99JOLJLaKjQhC5dsZLrsyqpOtZHjqfrHDvP7KdgqGls7ihtUbk8YhrfOlFsi2HudzADSpFRXGoDeKTpLuSgwjzDMTXs58DQ4i8gyngmAMh/o0sEiX6yiboxjKQMazfeSSuk/Im3DlTKJqHQ3WF2CfK0ddz3bBh4eROitAisEso7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CMn0ScplneJtBj9Ey3tV34nDZEUE6m4hY0w7XvxKKc=;
 b=KwIU58AjCl+HqfmIbJ/lybrjtT41qJUKJ+12WAFNb4A9xQcGnEwe41QzTvBrJHzw3+yfn/TGkB6VHkVLQCUix7cmdn6gc1Un5kpy3hMFPD0mggCLSNkXbQ8gAYoxh8ReLu6EN/XfIF2NViha25QWN2qHo7QNNkYtvEF6zXZpBGRS95/5BMLhhm0PnoRMJ7T66siZ2G7YkAOzVl64r1zwMlNWbpte+KMMz3cfcitv5ckvug3zwTjx9yzDiWMjIHX5QydHZM736sOOeajNiOgxPdUgpYRfzmqDk/JMeyuT7Jm53UqWg1Ud63aY/MA5yeWzJh7ogKITOKtiqd7gFxVttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CMn0ScplneJtBj9Ey3tV34nDZEUE6m4hY0w7XvxKKc=;
 b=bfMTQCxJaFDXgslygJFBssyfXkab80d7L1gygtVzP9cnleinhIjIwJKqDc30RAnwOcMSNwfySk1OuYbmyOfoVTMG/uRZll2Z4Y3gNkAWLjIKjOLFh+cQrs6bdfNfiLTy/o48t4e98IdVn/8NemYqhG2ZgwA/auE1rEfl/ciguzvNyFVXNZZ2TOYV25tRuAuGj86JOqULzqkUOWDHy3CqOPSHqLM3Kujob4wkLeU/DPlvdNyQXdp1sQPgfsSEGBbW/MxZuzBMBAmmb6C/OAFX8ol3uBbMn01ZhmX76jTeS1XL/RpZRmcY2BP0przJArLKkDckZCAL44YzHYxqIIuSgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 06:53:45 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Thu, 25 Sep 2025
 06:53:45 +0000
Message-ID: <3359b947-6adb-4d77-97e1-5abb0b9d2a4e@nvidia.com>
Date: Wed, 24 Sep 2025 23:53:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
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
 <20250910204309.20751-21-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 108e8473-125d-43f3-4725-08ddfc00456d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dy9PUEZoVlcyeENwN1JFY1k2Q2FRWSszUWtYbm5wM1lnRnMrS2tqWUU3bUN3?=
 =?utf-8?B?VW0rT3RMRWtjcStyMDdoampzdjU2Y1FpU1d2OXNLdXV2TEFOb042dHBmdE9v?=
 =?utf-8?B?WEd2TTFoQk5VOEFrZHJROWFaeEpnWnV5b0tzRW0vVXBaa2NneEZIdXovYTg4?=
 =?utf-8?B?UnZUOTVnNGM0VkNWdWFwYm9NbVpHa0s2Z3VGbUFTVEtQZzZncnp0Vi9SYis5?=
 =?utf-8?B?WjhqczRWNENxWEljZDlMbjZ2ekpuZXRBcjFSQ2Rwd2FnQUFmdFBZMkhlMDBy?=
 =?utf-8?B?OCs4RzVUUFBNbmFyNFR6eFNySHJqZ29IWUFONVo2Nml2M1FOQ0hrY2FJOFJR?=
 =?utf-8?B?RE5pWVNYajY0QndJL25reUpxNTFudUVoencvV1NSeVhNS09FVU9wcXJVRStw?=
 =?utf-8?B?MzU5UXJrMTNidXhjUlFDYWgzZG9TYUkxTnBXakxEUTVyRzErZE5zN3l5VVNY?=
 =?utf-8?B?Z2t6VEk2N01ObEo0bTR5bVlqcmRaOTNoWnZOMFhrU0kyd0tneFZsaE5Ecm9W?=
 =?utf-8?B?NldRQW1pQXlFSmYyRFZjdmpRdkVJcHFNbFdweDVBUXRCcE5xZEYxdGJOVE5w?=
 =?utf-8?B?bzMrbFRSTTRVUU10eVQ1bXh6TGZVdkdYWG5VenBqTlIxYTdVRkFtRFlYdlVN?=
 =?utf-8?B?L2lHekJVQ1ZUM2pjeWhONDNEeWxnb1o4YURiRmhTSG1Ud3Y5TG9aSFN6amNK?=
 =?utf-8?B?eUoxOGp4OWpVWmlBN2M0UnNZOVNmUkpGbUoxM1NpSHZJQXMwY24xaHFIeitK?=
 =?utf-8?B?Z3FQeHFYWXZaRkVmTGhuQUttWUFCbERRR0ZqbktncUFWcTZTRHJRU3JZMUlY?=
 =?utf-8?B?eWkxU2piZmNiU0ZiS2x0OUkwRzNaeGhMTjBucGFHSWxSRjk3VmpTUzEyZXox?=
 =?utf-8?B?U05TTnZYc2tZSnQvYTMxd0dDTUREWWJGNFdTWGFVQVZJSHFFNTFnZ2ovK2M4?=
 =?utf-8?B?V0tCclRzZmJwSnJGTTBZOVdJUnVUckdnTFNnRG1qNWVJRndlQjNsV0trZjNG?=
 =?utf-8?B?Wld5VkhMcWR1eUpmNGR4d3dRblBaOTE2dUZMSVMvLzhwNUwrWjlOaFQzeE9u?=
 =?utf-8?B?dWExSjlRcnBJb1JoTDZFQ0pWNXZMaUIvdXI1ODRsTFp1MjJDRW1KR0RnYlVS?=
 =?utf-8?B?czZ0UzN1WXNyQjFraVN0bTM4RXNNeWxaT3lCTmR6b3hvZjczb24rYUFuY3hn?=
 =?utf-8?B?Unh4R3VVelU0dk05U2VyVGxTajN2MjIvNzBjdUEyZ1BFYW01QjZQblZyUU5G?=
 =?utf-8?B?UC9Cb3dRV3hZVVdkNzI3YVNSQTBYbVZMS3VlMGczRFdWUVBCaTZ6TER0cW1v?=
 =?utf-8?B?b0RIRlhTQXh0NVJWZURvNThaZEV0MjNqeGxZT3loQ0Ria2pQRFdReUFKK1h3?=
 =?utf-8?B?M2JrZG4rSHpoT3hVZWp4YzJaNUllTDZsOGpoWlA4OXhCQWd1MVJxazkzaTRE?=
 =?utf-8?B?cmtmYlFCV1VESlVTU1dGS3ZMWmxBNW14UkpaTCsrMDRXVnBPM045Q0xONEY0?=
 =?utf-8?B?TFVFTnozY2NpMEsrd0R0MGtaL0RPN1VOZE5vUFhQZm0yWW9kTFNNaHlpUUFn?=
 =?utf-8?B?bUlhOEZCeHdEZm11SHltUU05OEd3VTNTUklROFVjaG5jdGJucGExT3J2cDlG?=
 =?utf-8?B?VUR3VWNRSG50YkprdkI5WXdvWUZsVXdXbkxkUlJhNHdRZ1dnempzYjhEMlNL?=
 =?utf-8?B?K0U1R2JpMmh0SCtWZHlreXhlT0pMZTRGTm90MTIydHVRQ1Q4cG9MOEtmNWdj?=
 =?utf-8?B?YTlYUE4rMThOa0pxMDlPOWszeldkdm5HOXBQbGtGVXA4MlRZbGRQTGdmVWpt?=
 =?utf-8?B?NEFrbFM1VXdIYTkyWFkyaDQyQ2RiNW0wRmpNRVo1QjlzR2FIUVpPeVhrZ0RB?=
 =?utf-8?B?VmxIZHU3YnpoWHVKamNYSjVPR2EvL1RhUGJBNnM0bjBtcEtmcm8xYkpSTGtH?=
 =?utf-8?Q?+HzHHlDVU9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkpaRUVhUDFENm9QWHliZjlqVW1iM2JtRC84NjdXZlFhajRVRVhNU0R0L1dk?=
 =?utf-8?B?dkF1VzJCZkJjRXBlUVBMbEtmVjRuVVoxTSsyV3hicEt5ZUF5M01JY0VNWHZr?=
 =?utf-8?B?bm1zcFk4Mk15MEdCcDYyMG1QaDA5WitPZTlFZGp1emplY0hFZkExOW1NcjMx?=
 =?utf-8?B?eVhaWUxaemM5UDByUVU2UnpCZ1liemFYVEMxWXltN1dBcVExclp4U2VRUUow?=
 =?utf-8?B?QXJnQkRHZEt1ZlRXTHBWWFlYRVduVFBTaWxLV0o5bzZKWkYwN3ltanZ0OWh4?=
 =?utf-8?B?MDR4OU5hd2ppcG1nSnVHS3NVSXdXWGdreDB5MytFWm40cnZaeENUNDNvK1FU?=
 =?utf-8?B?RTlFMnF2M2E0Y3EvR0RhTTUxcmxrV3Z3TDNRemZWQWNjQTdLMk1KclU3QjN2?=
 =?utf-8?B?NkZQTld1KzlFQ0J0dStHUWNiV0g1T1I1aC8xNXl2REZ1V0lEbW5oM0h6S1ZZ?=
 =?utf-8?B?VVErbklzelFKOUhaREFGbXFZRitEY3JLZWI4RHkrOFRFSWdyUklySTFIUVl0?=
 =?utf-8?B?TDhDNjlNbzdmazgvRUd0T2EzSXEyV25ZTEJ1a0xXK2ErRUtWNDAxZnhWQkd2?=
 =?utf-8?B?NjVSY3JqSzZLWjFFRW52VThCVC8rN2Nld0t2bGxWUGcyRFM0WnJmQW5yWVg0?=
 =?utf-8?B?a3JPbUtBVnY0TzJobUltZ2VSY25aUURpc0xGTk9OUWRuSWtvK28xMVFiQ3hC?=
 =?utf-8?B?ZzdGcitSOGJMbUp0Yno0TVVtWmZWRm5jdU9GRlZEN1BVMjNnUE1kVFdzVE9C?=
 =?utf-8?B?U0xNbE1RN3pUeDVCOTlyOTcrem90UEgwZThrOS9CYjVtVlRMMG5lM1h0L2pN?=
 =?utf-8?B?RS8xRGpGOFcwa3ZjN0FiSGs5UlBGZnR0WnRXVUlhcGhLVmRHa0l0U2x5Lzdl?=
 =?utf-8?B?ZUt2blNMUkZZSzN4QnVXOURNWjV6RjhLL2E5WGV1V3FlZjdzY29xSWU1MDNa?=
 =?utf-8?B?aHE0WForR21HR0pxOExmVXdkdjJXUWpKNWI2TUR4Q1J4d1pKQWE2aWJScllY?=
 =?utf-8?B?TnExYzJHdjRTY3NLNTc4TkJWQ1ZXR24rYnNxV0FvMVZLdXFIVXhlTm04b2Rr?=
 =?utf-8?B?T2NkTXdDVEYvTkZzaVZEWTg3QXI1dUgzOVdRKy83ZXp3ZURqS3V5cDRJUTBM?=
 =?utf-8?B?bVBHMDRQcXlGNzJqeHZ3bkViVE9nRGVHeWVzTm5vVWg5dmk4blNab0NSR1Vt?=
 =?utf-8?B?VFh1MVNTa29KeVM2MjYzR09vZzJ5NlBFUHE2UWVEdlArQ2xLbmt5UzU2aVph?=
 =?utf-8?B?WXlmNWZOTEJEY2VnQmxGQmU3TVhnY2oxc0VJdFRWZHNqbzJrZ2pKbGQydnZJ?=
 =?utf-8?B?dUY4MUFUTHZFUHJESmg2RytuaUwyQWQ3dHJUREFkM0VzelBnL0lmR1A4VzJu?=
 =?utf-8?B?V25FTkgwU1RkZXM1Z2p0OGxpUFJDNXgxS1UrcHVuanlUdEEzVU9wUk9DZlA1?=
 =?utf-8?B?dXVrVU56NCs0WmQ0RXdMZmZLd3Y4YmxDV3JKdWFZTFZaM2ZiRnorbWJrbW9O?=
 =?utf-8?B?Y0FISTlXVEJXKzFhZThDR0FKSWtBYnVUVTduSURwT2tRbElTSjJhd3hUUStI?=
 =?utf-8?B?VlpXQVY4VnVEemVTNGJ6Ynhlb3pVTTVNclFrOWFUWkg1TDVzbWY5bS9wUVFQ?=
 =?utf-8?B?SWlaWTVLbENpaWFOWXdOMlhxakxPN2pXUmxJUE1jdW9KUjJzQ0VZMjVFbDNm?=
 =?utf-8?B?M2gvSXZseFhGMXRqdzZUNVVZaTkwUG1XeFZUd0VtMDZDMnYxdWZmcVdIV1Nh?=
 =?utf-8?B?dG5XdHlYeHM2UisxU2FlNWdkQnhUQmtUZk5CUlNJN1pPZ3IrNU1rMXJoY0p4?=
 =?utf-8?B?UGhGc1Q0YjZ3UTNVMlpRaCt3L1hId2FxWEszYmRMRmVpVGxSVkNRMHNvZGVC?=
 =?utf-8?B?QjhWV0Z4MGFJYzdHZnB1UjZGdzl3Y3dvRFRxc1RHbTRCbHlocHNmSzBQN3VH?=
 =?utf-8?B?WDV2ZkY5Y251aGtuMEQxYnJuMzJ4WEY3UFBKV3o5dk1KQXg2WGFrZElITGht?=
 =?utf-8?B?T2ZZOUQxNy80bWNjSUpsOXhVNXVSSlhzeG9xaGliZERwd2FEdFJLcUZJSkN4?=
 =?utf-8?B?MzhFY2h0R2R1QlJ5UEhNM1A4RkJYeUVtWkc1c2VuY2RhSWNwbmRmVEc5eDNi?=
 =?utf-8?Q?/CBDWhjjuh50gJyRZxh77LnM6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108e8473-125d-43f3-4725-08ddfc00456d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 06:53:45.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhAjdTyW78DuKdDFzH6TDvT/kxQlI2YOelQ+chdKfi5aVNCZRKcSqLc8kQCgUd9yHZdB2vpLN5iA4JpW+AwYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

Hi, James,

On 9/10/25 13:43, James Morse wrote:
> When CPUs come online the MSC's original configuration should be restored.
>
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Switched entry_rcu to srcu versions.
>
> Changes since RFC:
>   * Added a comment about the ordering around max_partid.
>   * Allocate configurations after interrupts are registered to reduce churn.
>   * Added mpam_assert_partid_sizes_fixed();
>   * Make reset use an all-ones instead of zero config.
> ---
>   drivers/resctrl/mpam_devices.c  | 269 +++++++++++++++++++++++++++++---
>   drivers/resctrl/mpam_internal.h |  29 +++-
>   2 files changed, 271 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index ec1db5f8b05c..7fd149109c75 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -114,6 +114,16 @@ static LLIST_HEAD(mpam_garbage);
>   /* When mpam is disabled, the printed reason to aid debugging */
>   static char *mpam_disable_reason;
>   
> +/*
> + * Once mpam is enabled, new requestors cannot further reduce the available
> + * partid. Assert that the size is fixed, and new requestors will be turned
> + * away.
> + */
> +static void mpam_assert_partid_sizes_fixed(void)
> +{
> +	WARN_ON_ONCE(!partid_max_published);
> +}
> +
>   static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>   {
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> @@ -363,12 +373,16 @@ static void mpam_class_destroy(struct mpam_class *class)
>   	add_to_garbage(class);
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp);
> +
>   static void mpam_comp_destroy(struct mpam_component *comp)
>   {
>   	struct mpam_class *class = comp->class;
>   
>   	lockdep_assert_held(&mpam_list_lock);
>   
> +	__destroy_component_cfg(comp);
> +
>   	list_del_rcu(&comp->class_list);
>   	add_to_garbage(comp);
>   
> @@ -833,50 +847,105 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   	__mpam_write_reg(msc, reg, bm);
>   }
>   
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */
> +static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>   {
>   	struct mpam_msc *msc = ris->vmsc->msc;
>   	struct mpam_props *rprops = &ris->props;
>   
> -	mpam_assert_srcu_read_lock_held();
> -
>   	mutex_lock(&msc->part_sel_lock);
>   	__mpam_part_sel(ris->ris_idx, partid, msc);
>   
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
> +		if (cfg->reset_cpbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +		else
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +	}
>   
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_part, cfg)) {
> +		if (cfg->reset_mbw_pbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
> +	}
>   
> -	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_min, cfg))
>   		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>   
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_max, cfg))
> +		mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
>   
> -	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
> +	if (mpam_has_feature(mpam_feat_mbw_prop, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_prop, cfg))
>   		mpam_write_partsel_reg(msc, MBW_PROP, 0);
>   	mutex_unlock(&msc->part_sel_lock);
>   }
>   
> +struct reprogram_ris {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_config *cfg;
> +};
> +
> +/* Call with MSC lock held */
> +static int mpam_reprogram_ris(void *_arg)
> +{
> +	u16 partid, partid_max;
> +	struct reprogram_ris *arg = _arg;
> +	struct mpam_msc_ris *ris = arg->ris;
> +	struct mpam_config *cfg = arg->cfg;
> +
> +	if (ris->in_reset_state)
> +		return 0;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max = mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid = 0; partid <= partid_max; partid++)
> +		mpam_reprogram_ris_partid(ris, partid, cfg);
> +
> +	return 0;
> +}
> +
> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
> +{
> +	memset(reset_cfg, 0, sizeof(*reset_cfg));
> +
> +	reset_cfg->features = ~0;
> +	reset_cfg->cpbm = ~0;
> +	reset_cfg->mbw_pbm = ~0;
> +	reset_cfg->mbw_max = MPAMCFG_MBW_MAX_MAX;
> +
> +	reset_cfg->reset_cpbm = true;
> +	reset_cfg->reset_mbw_pbm = true;
> +}
> +
>   /*
>    * Called via smp_call_on_cpu() to prevent migration, while still being
>    * pre-emptible.
>    */
>   static int mpam_reset_ris(void *arg)
>   {
> -	u16 partid, partid_max;
> +	struct mpam_config reset_cfg;
>   	struct mpam_msc_ris *ris = arg;
> +	struct reprogram_ris reprogram_arg;
>   
>   	if (ris->in_reset_state)
>   		return 0;
>   
> -	spin_lock(&partid_max_lock);
> -	partid_max = mpam_partid_max;
> -	spin_unlock(&partid_max_lock);
> -	for (partid = 0; partid < partid_max; partid++)
> -		mpam_reset_ris_partid(ris, partid);
> +	mpam_init_reset_cfg(&reset_cfg);
> +
> +	reprogram_arg.ris = ris;
> +	reprogram_arg.cfg = &reset_cfg;
> +
> +	mpam_reprogram_ris(&reprogram_arg);
>   
>   	return 0;
>   }
> @@ -922,6 +991,40 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   	}
>   }
>   
> +static void mpam_reprogram_msc(struct mpam_msc *msc)
> +{
> +	u16 partid;
> +	bool reset;
> +	struct mpam_config *cfg;
> +	struct mpam_msc_ris *ris;
> +
> +	/*
> +	 * No lock for mpam_partid_max as partid_max_published has been
> +	 * set by mpam_enabled(), so the values can no longer change.
> +	 */
> +	mpam_assert_partid_sizes_fixed();
> +
> +	guard(srcu)(&mpam_srcu);
mpam_srcu is locked in caller mpam_cpu_online(). It's unnecessary to 
call guard(srcu)(&mpam_srcu) here again for simpler logic and less overhead.
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +			continue;
> +		}
> +
> +		reset = true;
> +		for (partid = 0; partid <= mpam_partid_max; partid++) {
> +			cfg = &ris->vmsc->comp->cfg[partid];
> +			if (cfg->features)
> +				reset = false;
> +
> +			mpam_reprogram_ris_partid(ris, partid, cfg);
> +		}
> +		ris->in_reset_state = reset;
> +	}
> +}
> +
>   static void _enable_percpu_irq(void *_irq)
>   {
>   	int *irq = _irq;
> @@ -944,7 +1047,7 @@ static int mpam_cpu_online(unsigned int cpu)
>   			_enable_percpu_irq(&msc->reenable_error_ppi);
>   
>   		if (atomic_fetch_inc(&msc->online_refs) == 0)
> -			mpam_reset_msc(msc, true);
> +			mpam_reprogram_msc(msc);
>   	}
>   	srcu_read_unlock(&mpam_srcu, idx);

[SNIP]

Thanks.

-Fenghua


