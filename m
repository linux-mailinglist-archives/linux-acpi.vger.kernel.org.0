Return-Path: <linux-acpi+bounces-17299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4795B9DD3A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 09:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BB423B63
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79C49659;
	Thu, 25 Sep 2025 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHcsbBRI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90542A82;
	Thu, 25 Sep 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784617; cv=fail; b=Y5Pakpk+39SawiYLlkAndauNp7g//Asl/5nFNoIs/sLKZRQd11A8GaAcHne4SddoezyOF5d2jIOlq/mrUazgtcJJ2ETspSiMyj3wJtUMeXuorFhyWceluPuu55unYI+H4p+hpuqWNsz/opSLedO6KJlAfB2zoWZZwaSn1LlKBlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784617; c=relaxed/simple;
	bh=QwUoO4qIZso/YB6AoqvZ1fTC2rpin6++JAgZYddZDxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMg8e+W6k6muYkbSH1ZMXj/vzjwHhCjSGjfQDo9+Wh/vdlx1M4YwJTSV7NtExPXPnvfsfK6EO5TfMw+oNtBdiFby4x46Jg23C5zRpLO+Cur5L3T83pYJfYuHbMfDfInR4GiqQW8dv/UP5sCexzUKWQMo8mpZYZc+CozhJVlhSPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHcsbBRI; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/xWKHAtSTXvR3RAXxGGUurdRoxBsqLHbenPIq+cYc4dkxFRjdxWXRzHM2C8TFxJTldJDYt6stfPSH2/oIlwvaEb0mEjkPxiXVJUWSPcxuLaufmUcie6RBmaqGciIcrITef1M2RYWYmqPeqMLWsP3lQ5gvIv+4eAF0FqO4+5ccF1SfWDfGpelFVvxP01zKEM263BfQJ81vDJWeT8XOHt/OOX2EY3Q/EY9Wm7etSrk0Hc0Ik4yH33QyAuANzVEEzDMaggyyV3uEMgPjifdbIaZ6Jz1voIK3pCoKf+Uw2WNOR+0F+flBNxEKUTLcloCLvxFoO1Y1jNs6Wy6aQajQDswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSaLSM41eP2s0RVJ6Ohkzv5VzKHvosjx/a3okk1pVBY=;
 b=EpKFxSA//6F5HFDjzXsz5wJk9OUtlg2az9ybkt6GcR/c+x0A5N08tBA2SHMeHu+aolYJ70SE0NGIzzvQOrY7UkBqXi9s5GW/dQ9FhuW7x0tbZZwDOg7GSE8CHXQ6VfWnmyNBcWc6IFOcwl3U/0G2qvohTpME31AWhBFaEjG35MN+rvG4JB1PjUIF3RqxJ1YTxO0mGJhYiC//lBA43ve+oXTitoRt6lShcWRp74PGwYZkPDU0jAiffQbDWqZFRUScwdwEa5S/Qopqn35528kHqHpjiyHN3sxjyczSH245GO/fjskUCdC2wnrhXYr7MJmiMTUyFgWvQZcrh97dabInEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSaLSM41eP2s0RVJ6Ohkzv5VzKHvosjx/a3okk1pVBY=;
 b=mHcsbBRIxkA+Gz4cNbyj33N9yzPiw05rty3PrwGMoQGozVlARfp7EwpklQJCReaohDBtU1rittbn1gfggKIZR5UjWVbB2jJFx1tGexwJWFJSJ7MIOpyciLbeJ2223OXCyummk3mqHSVl4RCA8cOaQFLVqYh5B0CLaWwhx2yoqF55+T95CGK9k5nhT6idQRKWlRzGNJL5JgGNkcFiQjMoofxQlKa38TXW5r4KjFQ0fathhaYxOgHctphbqhOjPPeeUY0lgX+6N3fZyOV4HyDzAQ6W7BPYz8d+Oi+FOEviy7RZ88N0BM19xygF4r71UE3FmlnB6AMhH6u/4DR2hEGJEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Thu, 25 Sep
 2025 07:16:52 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Thu, 25 Sep 2025
 07:16:52 +0000
Message-ID: <1249c061-dde7-4966-9c8c-2fa958fad37b@nvidia.com>
Date: Thu, 25 Sep 2025 00:16:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/29] arm_mpam: Extend reset logic to allow devices to
 be reset any time
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
 <20250910204309.20751-18-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-18-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: abf98fbd-acd9-4e5a-4120-08ddfc037f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBSZWVSUjZwL2xuRkIxTzZ0U0ZhOElMbklpWWgyOGpYWTBkRkJPTFNuTHJh?=
 =?utf-8?B?bWNkOW5aTDZscXVTb1cyWExld0ZxOC91NG1zSFFiZlFRRGNQNjZ4MFVoNlVi?=
 =?utf-8?B?UWZjejJZc210Y1pqdDdBNFVwNFNkNGhhYzRxNkRzOGlsbVViYjdKRnVvWUxz?=
 =?utf-8?B?eGtXYVEvSnFLd01EMUVzNCtJTDllZjk3ciswTzdzT2VzODBjMHpKNmo0eW14?=
 =?utf-8?B?OXdNZ2dScThOSFExRUZvcmNJOTdXV2w3L3FnaFYzVXZQcW9Db2pDTVltOXBp?=
 =?utf-8?B?L2JLQ2lGRDNIU1hXcDNJLzNFZEpSTG40RUl2MVlIWW1Bck1nd2xTbEI3MmJH?=
 =?utf-8?B?ZVh5QWJvUUhaajZTeE40b3ViUDZkSVJTdTdZM2FKSjNYWndGL3lWS0xMbEJq?=
 =?utf-8?B?czExRjIyL2JlOTdKcHRqV2VrTlA0UzN5OVhpYlE4WlVwb1hiMDErbWE4Z21v?=
 =?utf-8?B?ekw1Y2dIMHp0VVlNRUZYMDhTOGhLa3RuejZ0ZGwwRnovZlRHVXlJb3JnNWRU?=
 =?utf-8?B?N01LbUV4Y3lrY2RwYmtkV3NMSFlxb0pqTmRrdHo3WVBoRW1uSkpwNGgvVGhC?=
 =?utf-8?B?dFdwTlZTVTlob3VXSWQzNDZKaFh6TlNIWGJKdVJISnFzZDNBMjlmSVhuNGQv?=
 =?utf-8?B?dzdSUDBqUmxUL3ErdTVWUXFmNm04TUVWMm1EcHMva3JUMEs1VFdLYS9PQjJS?=
 =?utf-8?B?UjF3NXZGdVM1YmxPMGxLR1hmNzM4cHBuSXB5WHRTY0VaOGR6TzBEWHRMd20z?=
 =?utf-8?B?YTNnOGNWaG9NTDlIbm42THV4WEV0djZ3VisveWY2Y0h6MUcxZGg0QU95a1Bs?=
 =?utf-8?B?Q1BBU3R5b0lyRU5XWkwrTGhhQy93a05uOFliVHM5OEVyWG4xVUhSOG1kV3d1?=
 =?utf-8?B?OHA2cXU5ekFVakVjL0xCT2w4N1dXS3VQeWNqZUJuNzJQeHhxVXZMbWhOUUUx?=
 =?utf-8?B?T010QU15NUxnWUc0SGVnVTdiL2poNytDRXBTSXdrOWI5YUcraW9pTDkxRWRj?=
 =?utf-8?B?WFRoL3BpVkxQYzgxa2RZWUxqQkJBa05sMzJaY0F5dExEY1BXQ0NFc0U1TUJC?=
 =?utf-8?B?NTFPMTltNjJyd2tSNmVwVEtjWWdhOFV2T2Y1ajZBNzAybzljZWNDSFlub1BJ?=
 =?utf-8?B?NldBK3BVTjE5Y0xyRWdEdi82OEVGa3F5VmNZY2wxNlRGbTJObkIxc1gvK0xC?=
 =?utf-8?B?Q2svajBsaDQwWDg1NnlTaWV6NjRmYy9QNXgzK2dPa2tmbTEzQjZ1ODVzWXRs?=
 =?utf-8?B?THRjdWNHdkFxSy92WWxSRGJZNTEwbnJaRi94MzRxMjlna1lHN0lLM3Z5MUE4?=
 =?utf-8?B?MW40RXBkUEUvZFhyYkExc1BqbUhtVG9mcDJKbERyVEdmVEV1Zmphc1JuTTRU?=
 =?utf-8?B?UWlmQm1UdENNbHFxbWVJMlEzWDU0RFcxL2YwWGdBOFhkUmJ2Q1loUUc0S3c4?=
 =?utf-8?B?MXkzK2JjTEtjempFMXAyRnBRWGVFUnhMVFRBRFo3bEEvZFI1N3ZsekpnMWRI?=
 =?utf-8?B?d1lnVDdSNklHdFY4cG9aTFJVNmZDYUlpTDhheUNYR0VwMlZkaDNKblBoS2Zk?=
 =?utf-8?B?aXNsVXpUOUUxV1lDNEs5OE5uclZsblNSbEdSckZsM2QzTHVTOWQ5Zk4zNzM3?=
 =?utf-8?B?SHlCQkdQeGhuVkxMYjhMVGExL1dwVFJtY0VETDV1Q1R0VS9hWnlnVTFlb2Fj?=
 =?utf-8?B?aWluOWVsR3JUcnRtV0REMlo2RzlWM3hORmIvdU41ZVkvUXlZZlF6YmY2RnpY?=
 =?utf-8?B?cUZsZ0ZuUk43TjV3dGtrbTRvOFIrNjZwTk9kTUJWUmk0WkRSbUZScXlDcmxa?=
 =?utf-8?B?RVNHalU3Y015YjdxcmxLUWpWVFNwTml2elFKS21sZlpLcVp5cjJmdjZ4QVVv?=
 =?utf-8?B?SzE4dTBLMzVWWE1GbmJweEZOVlNSa05nUjlPanhvRDhaS3UzQnMyUmRmQXBZ?=
 =?utf-8?Q?1Rsm2cGXr/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdibkI1WEdkb3hzOThFbWZQSVZCZHhIcUltb2ZDN1JCK0xrNUNIckE3Ri9V?=
 =?utf-8?B?K2k4MEhMTlNSZG5Xa0tXVkEzeGI4MlhPczZVRkN0ZnZVMVF5N3QzbnQvSXFv?=
 =?utf-8?B?Q2UrSE1QTVdTWjlTUy8rNmhrbWsxYWUxcjRHNmNZdmVTREFsbk93V2R2d2VE?=
 =?utf-8?B?eWh6TVlGTTNoYkVha2ZaVndlckdWKzNOMlBrWW42UE5zUTJhQ2hXcnhoelQ2?=
 =?utf-8?B?aStQRi9jbjQ2c0dDc3ZiRWJ3VkpBOTBNMm44cGlrMWoyNWo4SG8zSVBNdjl4?=
 =?utf-8?B?ZHc5cnRGZ1FoeU5STzlHOEYwaTNrTU1KOW52YlE5WGltL1FGcTVoSHk3M3Bs?=
 =?utf-8?B?MjhNdUVERysvS1hOL1dxRGk1dU52dUNOV1hjZnFZTEVFRk1OTmNiVHhIaC9J?=
 =?utf-8?B?Z3IrODVQeWJBU3pJa3ZwdWplS2lWc2NLNG9ITjJrc0IwTFl1WjlwSTZQZ25u?=
 =?utf-8?B?TjNqYlU3QURyM3FIOVVJUWN3TjBCb3Z4YlBQNU9KWDFDeDdYL3I4cTk1V2Vj?=
 =?utf-8?B?UzZWWUFLcUhFVjVWcytuTVRlVGFWcHJubERuajJ1ajk5T0hqbENqcC9nRncr?=
 =?utf-8?B?Q2JScS8yVTl1THNBbFloMTV3ZUhxNWZuQVcySytzZkpLendlc2dEdHpCTFdV?=
 =?utf-8?B?Nkp6Njdad0V1T25NaThEOWRKYmsySHI0UVZOdlE4aVNlb0VEN2ZRK2FpZEJK?=
 =?utf-8?B?YnpVaGRnN1V3bWpKeUtPd3dIY2tMQUM3RDRVd3J0cWk5MG85WUpreTR4RTRj?=
 =?utf-8?B?WkZWVHVQdVlUZW5EY0RFREsrRGY5OEFYMTNoUGluWEZmd1UwYi9ZZFA4UUVQ?=
 =?utf-8?B?NXdTTGJIcmNMem9JZVJLbSsvdnBMUlpwNFo0VjgzR3BHelAvdnNVdGx5R2pt?=
 =?utf-8?B?RUtzTHZldW1PeHdhODRaMmNkL2RqeFJGb2FTQmE1a0NldThlMGJqT3RrR0tV?=
 =?utf-8?B?R0hKMlRsTjl3NVFzd3AxVldsTDRHVUcxQ082WjdJaGV6bEFxSmJCNUJOQUVo?=
 =?utf-8?B?K25zbmdQaXZHSnYxOS90dFZ1YlNidGlocGlFdkpIeTVMQmRYRWl3WnlvL2dl?=
 =?utf-8?B?a0phTWFhNGkvenZFWmpGdWJiV0NCSWROaUQyaEdqbHVlNGl0dlhaUUpHdGVH?=
 =?utf-8?B?Uy9raGFLMjJDd29XSXpGTktlQTZrenJyVW5QY3p1TkZINDM1U2M0cGl5M2E5?=
 =?utf-8?B?QnNwK3o1dU9qaGEwQ2VJWkVIRnJNdE5zaW9qb1VUYzNZaWF3N2czYmcwL25a?=
 =?utf-8?B?ak1JYnR1MDllNTBsb3RsSjd0S2VBSnVleC83YzlNT0hZc3hMa0ovTkVSSHI3?=
 =?utf-8?B?MzFMR0xSODd3bFUvamxObGQ3OS9yd0VCb0VybGE2bzJoOGttaEtiZ3YzRnZu?=
 =?utf-8?B?SUo4R1FsMzBPRDZvWERSUnhTSk5wRTdnQzkyZ2MxNGhOQ2hSelRDbnJFZFIv?=
 =?utf-8?B?cmZQK2I2aVJxRDJRdWZXVlVRV3dQVXZ2ck9ZWEREdk9ZOGtOK3Uxd0hEMEJo?=
 =?utf-8?B?OEwzRDhrOFRTRnpJTVhVVHlVSG52OEpwWjh5bDhHRDExQ1RXaURnNytTSVFG?=
 =?utf-8?B?d2FMSW5IQlIvenp4ZGpRb290c2ZlRkU0cElvT1ZUV1JzZnFaS0t0YnVqR1FF?=
 =?utf-8?B?dUxqcHZ5ZmRybnJoa21Sc2ovMGhFRkFxNUFxTVBxTHAyZXVlb1hQM0JvY0ht?=
 =?utf-8?B?K2xHdzllVCtVTUtRRE51bnloN0J0NUN2b0hYOU9UR1FVZnY3OHBVdlVHamVC?=
 =?utf-8?B?M1VvN2tnekVZSzlKZmpvajdWT3FsU0NidlJSOFpLd1BrZWVEY0llYjQ5MnVB?=
 =?utf-8?B?Rjd2bDJVbExyOXVaV1JWek41R1U0R2d0Tzh0eUxnQllJenZBdjRBTXZOcTMv?=
 =?utf-8?B?QWxSU2wxRHY5VkI5ZGRQWnFUMnF6Zmpsb2tFeEtSblVFaVBsZEVLajRKRlFH?=
 =?utf-8?B?UEgyWkVic1ZUblRWanljS3ZNMlRjb09ZVmtVZ3lKYndGSzNLeExlR1haVU01?=
 =?utf-8?B?djVZaTlnYVg2SVNxUmQ5dzlqSmNTSmRwUFphSkF2QXBqRnpBQldRUjI0cmZt?=
 =?utf-8?B?eTdHNTMzU1dicDdLbFJLUzBGcWpqOS9LS25QWEp5YUFGOVo1MGxhYy9OT0Jn?=
 =?utf-8?Q?kW+vDBarYDhzZ3Rmq3jelnWO3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf98fbd-acd9-4e5a-4120-08ddfc037f8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:16:52.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQUXi6O1R5vYFIIT76e+3Tq+xHOvTTYQ5m/1A/uHcpG0vm1SkqFIi7HMyvy3+XnzfJfYTXI7s4qVyL5PRaMx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
>
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * more complete use of _srcu helpers.
>   * Use guard macro for srcu.
>   * Dropped a might_sleep() - something else will bark.
> ---
>   drivers/resctrl/mpam_devices.c | 56 ++++++++++++++++++++++++++++++++--
>   1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index e7faf453b5d7..a9d3c4b09976 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -842,8 +842,6 @@ static int mpam_reset_ris(void *arg)
>   	u16 partid, partid_max;
>   	struct mpam_msc_ris *ris = arg;
>   
> -	mpam_assert_srcu_read_lock_held();
> -
>   	if (ris->in_reset_state)
>   		return 0;
>   
> @@ -1340,8 +1338,56 @@ static void mpam_enable_once(void)
>   	       mpam_partid_max + 1, mpam_pmg_max + 1);
>   }
>   
> +static void mpam_reset_component_locked(struct mpam_component *comp)
> +{
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_cpus_held();
> +
> +	guard(srcu)(&mpam_srcu);
> +	

Nested locks on mpam_srcu in this call chain:

mpam_disable() -> mpam_reset_class() -> mpam_reset_class_locked() -> 
mpam_component_locked()

There are redundant locks on mpam_srcu in mpam_disabled(), 
mpam_reset_class_locked(), and mpam_reset_component_locked().

It's better to guard mpam_srcu only in the top function mpam_disable() 
for simpler logic and lower overhead.

> list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		msc = vmsc->msc;
> +
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +					 srcu_read_lock_held(&mpam_srcu)) {
> +			if (!ris->in_reset_state)
> +				mpam_touch_msc(msc, mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +		}
> +	}
> +}
> +
> +static void mpam_reset_class_locked(struct mpam_class *class)
> +{
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_cpus_held();
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(comp, &class->components, class_list,
> +				 srcu_read_lock_held(&mpam_srcu))
> +		mpam_reset_component_locked(comp);
> +}
> +
> +static void mpam_reset_class(struct mpam_class *class)
> +{
> +	cpus_read_lock();
> +	mpam_reset_class_locked(class);
> +	cpus_read_unlock();
> +}
> +
> +/*
> + * Called in response to an error IRQ.
> + * All of MPAMs errors indicate a software bug, restore any modified
> + * controls to their reset values.
> + */
>   void mpam_disable(struct work_struct *ignored)
>   {
> +	int idx;
> +	struct mpam_class *class;
>   	struct mpam_msc *msc, *tmp;
>   
>   	mutex_lock(&mpam_cpuhp_state_lock);
> @@ -1351,6 +1397,12 @@ void mpam_disable(struct work_struct *ignored)
>   	}
>   	mutex_unlock(&mpam_cpuhp_state_lock);
>   
> +	idx = srcu_read_lock(&mpam_srcu);
It's better to change to guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
> +				 srcu_read_lock_held(&mpam_srcu))
> +		mpam_reset_class(class);
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>   	mutex_lock(&mpam_list_lock);
>   	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, all_msc_list)
>   		mpam_msc_destroy(msc);

Thanks.

-Fenghua


