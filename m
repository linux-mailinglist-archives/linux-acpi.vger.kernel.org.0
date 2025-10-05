Return-Path: <linux-acpi+bounces-17587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5DBB9317
	for <lists+linux-acpi@lfdr.de>; Sun, 05 Oct 2025 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDA3C1C44
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353C1114;
	Sun,  5 Oct 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ER8gm/Mm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6431189;
	Sun,  5 Oct 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759622990; cv=fail; b=uScyezHouEM2qsMf85XBWKpGwQxDMC2AZBuBznh+iCAkQ0e+aMGTs23CBdtb7UQuKxEOCX0GM0b0aACxlRBxNslW4P88XJpLgYBG8UrXy9dyea4Azq+PfdsLc0b935O7CckZ6ny+9Egyz/D1cGXAajAje9WCz8zrB98Iwmlde7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759622990; c=relaxed/simple;
	bh=ZedEjozI6quY16umNsnqj4MX5POSFS1IuxzN34xmQn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJ70rE8BA3mFtN0ODmPzXrXWwivqXrD+tLTOPh4ifJyLMN2AaJO7zpAr1DK4q3z9KEfUvdEEzC8EFYhbs31wCJsmrZCLSQ8afTMweU9GctEzHy8/zX8vepht7Y1cVHlv3t6JmV4CJJn+mB6ZvxqT/dVsWhesXeeN22/jLvc+neQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ER8gm/Mm; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODg7xUOAfl/QHnC7zkoji2rfeu66VrnoMRKD1i1jgb80alRnen2iY4ryTL9vbiYgtkh0e2ld0kflYyJhEpeGP8aweTnqEvu/gX9QA5JGIR1o6rJ4KVui9aiYLs/kdU+H2kHV426dejSYLCeulOllOYirhxAjQX70u9cY8eVkNu8UOpzwW4cOVB1MRfFEyS6111saP0hL+BRubApULHhuuJ4UneXZ9U1XZhw4n9pVqq7WbjCk+5IssBLVAPCV/bq5S0JGFgX8ACFh+FeGvcNlvd8R75IqbvTB2e3B54vtibilOg1oeJNiAX3Oe1QN0xe30lCPA0hwZMHfr7TdsF7rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr4qx+/Hns6sjZdv4hrZMh8weJqk8FtJcV61yVrikD8=;
 b=Lf3AIqyo1prIIoK2IT4y0fRPVpXf44320uDXrtuIAK/aFqmvHgzOJkuamRkzxk/maV2HBfyjuGE/WmYd+MlHiRmkT8xUmahWWCCrhHzyNXLbWlMpVvwmm0OwT2aifVtm7afXbzgO/iDxKVP2p6KdkWoUz9relJpKWSO2XIPsMEUndBH0SRc3PD8oe9Fxab8QeNeupim8R+6xqUWZqedHpri2uFHjpqTJFHSaQfKbmsbxpCgWjzXJI63cUyipgFOwAqudD5jT27ahEb7ckomhYwf7dj+YYA3Yq5sxZ2nAWzmQPp4C3ClW6VRwizDULgAb8YNK4s1rZk0d2U+XF2I8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr4qx+/Hns6sjZdv4hrZMh8weJqk8FtJcV61yVrikD8=;
 b=ER8gm/Mm1o2hy2unPz40AhV2LDQrpzmfoU1eS75eBqlu5iKyqq60Rwl5oXIsJrTs5sOeT+SPOv4cwr7rUtwUIQZcIMc2AWo2veoq6CLM+xFASO390jDFcicLmWiiOQCd0JQeN8ix7w5PhT6KM8TNqkFzpiOvG81DRFPa1IokxsB4zXYUT44srdPBpsv2Uvj+SsFNpgm8IY8A445EtiEmP4EfEhiWaQhTxrS5glz5E8Rss6gKfFQYHl19Aq0dqP75wHG6yql2pX2j1o0tuYvJg2W8J6FcRrkvyw3y2NnVTDz6VDO5iO1D0tSE4ED9nOIKJ5fZ+qgCJoSPQghYUVxDKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Sun, 5 Oct
 2025 00:09:41 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9182.015; Sun, 5 Oct 2025
 00:09:40 +0000
Message-ID: <f43bbd94-f611-4817-b5b2-35c5c1d236e8@nvidia.com>
Date: Sat, 4 Oct 2025 17:09:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
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
 <20250910204309.20751-13-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb1eafa-f65f-4491-a9ea-08de03a37aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtrOW5oMnpSaXBpSVQyMGEzdU1kaXhQSEd1aUt5WjVGWjBNSXVZLzdOY211?=
 =?utf-8?B?VTNVcWpMRGhzcS9XT3c0Mjh4aTlSbityU2FhT2VIUlo5U1ZrSm51Y2NpOUpJ?=
 =?utf-8?B?R2tnaWlQeUtXRndBdFNPMkswTDVmazFEd094MktNbk1UUkJybU9CaThMWms2?=
 =?utf-8?B?eHNsLzdsR2V5YWhUUGl3bmJvN2FrbXZuS3VJd2dWRXV2Mlg3S3lwaW1PWkdQ?=
 =?utf-8?B?K00rcE5NNUk4TmZHV1VoellWTldCNllCb2dvd1FpSTh4N1FQY2c1TUxtVjEr?=
 =?utf-8?B?WjlwSXR4NXdCOUgzbjFYckZLZVlBRmZpbko5cFNZVmVOZmYreVU1QUpUVE02?=
 =?utf-8?B?Qm9DeWZiSU1mNEZ5eC92bjJiNTAwdGdYSFh1UHBvRUtPWkhWZko4bjJkak9H?=
 =?utf-8?B?MlJ1dDJNWjlQaXBpVkZQamNOU3ViaEJyWFh0Um94cVpxOEFoWXBjQmVEQmpT?=
 =?utf-8?B?bDZmMk8yNDhOMVFONnpEbVRTaUFQLzgzMGtvemszVG5WMTFVYi9ic1JyK3lK?=
 =?utf-8?B?UEliT09ua295M3Z0cUduS1NVSmc4VW1Vdm9XOGwvNzE4ZEFzREFUMW9SVVg1?=
 =?utf-8?B?d3JrdW9OYUVmbDUwYnFLaFJxMS9hNzVnOHBxekk4VlQyWTVOdDRvcEx3SWdE?=
 =?utf-8?B?VDJ5c2lyUW4rNnhrelljTTNKM3JLcXRSWS9uSnJkSU1STm9TNi9CbzJpOE1a?=
 =?utf-8?B?TU5zQUZObEFXUkhvdENRNTMyM3BWQmNnY09uN3BxV0dZazVtMzdKc0w1NEox?=
 =?utf-8?B?ZXh5OEVqU0IwbkdtRXJFYWJpSUt5dFFjYjg4UWo2eEJ3by9WZzZzT0g1b00y?=
 =?utf-8?B?aDNHc2lWa1oybVJwclZ1ZVNPOW5wbjVsV3NBWnJYemtGRjlLZDhicGpQT3NN?=
 =?utf-8?B?ek12dU5sVkM4WU9oKzVXazdOUUZaeTBlcUVvUDVleCtMWU5kMGNwbng3UzJQ?=
 =?utf-8?B?czQ4ekN1aUpOREswV0MrMUQ4S2x3SEtHUDI2N3IxeC9GU2tUSERRVHkxdVVh?=
 =?utf-8?B?RXJEbU13R3V0YTlJeGhPczRBRSttNDB5dHZEQnJucHRkTnltOXZrVFB0SUtX?=
 =?utf-8?B?N2Vhci9MVG01YjgzQWF0RDdEZlJXUk5tS1VXNjd3NWxXZ1dMcVdWWnlFRHRQ?=
 =?utf-8?B?dzYxZ00wQmNEeE5aeEhZN2lXbWV6UFpUYW84TmpYOHFNamd3d2JNTW5PdHVG?=
 =?utf-8?B?MWdFUUtPWnpoYVlobWxaajE4NkdTZWZVelJncFBiK3ZNSjBlNzdoYUJQOHdW?=
 =?utf-8?B?QTY0ZmhrV09RSytPbmt1MEVqTWlvOERkcnd5THFTbENpNmEzbUxhNXBYeWt3?=
 =?utf-8?B?OExTL3RMUVlSeGtrOVJtMWhvY2trczNKQzBVdzZMWmNMbGV6eXNteWozTXIw?=
 =?utf-8?B?QWdSN2VTSXNGNExtdVlBSEpTTmhOTVpTd0Rjb0t6N2lXTmJYOWdsRmpycmM1?=
 =?utf-8?B?aS9EN2kxd3B0djVYazMxNFJvOWtieFlXWWhxZ1lhMGM0U285bVhuWVJLNEZL?=
 =?utf-8?B?NmMwSjNZTFJxOGVXUUhZbTV3R3lPRnhPZXFKb0Z6QUtFbElUTTNzK2IwMFRz?=
 =?utf-8?B?N2FtZ2pBRVhQbzVkNWFDR1k4L0pPbmFiVGU4ZXBnK1cyUG1QdlcvNVFac0FO?=
 =?utf-8?B?QVB1NU1NUmFtTW8vcUNTUUxFMUw5emllSVJFTkx1TlB2Um1LUTh0NnBGOVVH?=
 =?utf-8?B?cWN3K1l5TnlnL2lhWFZITVlFLzBsSEE4eU1GN1dtUjFTU01WM2JnaFRQSU5w?=
 =?utf-8?B?MWR5emdKV3FiTFR3V2E5WXM1N1FMSFdKRFhHOFVBTWhieG5lQWNxSHlEbjVn?=
 =?utf-8?B?UG5NMGhZY2U3SGR2bUlndHNXZ1pGSDBUeHlmaTI0OWlXTUZMQ2hjdllGamJr?=
 =?utf-8?B?c3RwKzIrQXhROWk5L2ZGQk4rSTFnN3BiTWJ3WHVwa2J4ZVJmd0kwSUN0OEpH?=
 =?utf-8?Q?Do/khbAIfQqRUwVpQqF40XnkVhQfq7Zw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmpiY01KNXlvcnZyS05LbERYSXh2UU03MGRIWE1BOWJycG1TY09NR2FrODdp?=
 =?utf-8?B?eWh6R0RmODFVTnlnY0dVUFo0Vyt1VUFjRG5Rbk9tVTJGcXNkZmV4NzBtNnA3?=
 =?utf-8?B?UEpJT1c4NWlNeGJPZitIa1BzU2c0U2plVjgwbzFMVUJ6R3ZHWU15Q1A5cnd4?=
 =?utf-8?B?UFVMSzkyejh2Um4rN1JUTkJIcDdLQ0l0eXZCNnpTNy8rK1ZlcEhkanZQZFZS?=
 =?utf-8?B?d1lwbDFKditKQnRWVGlKM1dnL3pJYUw2cVh6UWdOelU3eDBjVHNQOW5PaXFR?=
 =?utf-8?B?cVo3MVZXNHkxN1lVSjdtaDlHOWdpZURJdTVVUHkxSUNaZmxraEN5WEZrR2lH?=
 =?utf-8?B?MHlua2FmOFRqamQ5WDRJZi9DVk1vUkZxWmNPTVNnNTdFanpmMmowaXhsWkZQ?=
 =?utf-8?B?V05zYUduaFRBd3M0SGFaalhvU01EWFI1aUtxTFcrZHVMWUhSRmdpS2FXK1lC?=
 =?utf-8?B?c2xwckxzckhjNDNDdzRrQ215MmtHaDZBQ3ZRenNLY0pOTU1xZHRSS3VtdUQ5?=
 =?utf-8?B?b29Za3N2SlljODVSdzd3N01YUnN3c0JtdjQ2ZTgyVFRHTWw3UG4vRnRGUWFo?=
 =?utf-8?B?MTg3TGpTQkpFV3ZnZEtaR3UzZDg4RGZBYjdtNmxXVjk4VExibEZDUHZNWjY4?=
 =?utf-8?B?cDViWERvRU1KK0oxNjVTZERqekVkV0doSFNrQ3UwYkk1Y1FISzFidVEzdEE2?=
 =?utf-8?B?LzdpS2pDUVhQSCtZeDd2UmNhSnZ5TlI2QmtRVHBGTmJ0Z0pvZ1Jma0tiUGZ6?=
 =?utf-8?B?OXZiMTg4a1I2MFNFYVlBTmJXcHMzYzE4blFUUzA1dDdFR0h4bEYzWXhaQTMv?=
 =?utf-8?B?VkMzd25FVEsrTTdkM3pNRXJXZWFpQk43WDRZVUJkZHkzZjZmOXVPNHFoVlZI?=
 =?utf-8?B?ZTJ4KzBFVURiTlZVc1p5anVvWGNDZ0x6OTAyZUZVOFJKelJObjMzbWd4NldO?=
 =?utf-8?B?Y2FTNTZaVmljOENybkxpNGxrclU5M2pqWjdxTFhURDJyMWlCUnFCUHR3YXBN?=
 =?utf-8?B?NGRsaFI0U2UzdVZ1aUI5RFc2NGpvTkliVE1QbURVdnJid1JyTVRTZEhRekJl?=
 =?utf-8?B?Q2g0OWpBdkhCYnpIbTNQYlZxZ3dqMXFqT01sMkI1Qlkrb29DQk5VNUMvYlRT?=
 =?utf-8?B?bWZvQlQvc2tzNkFFVXNqSjVkZFY3ZnlJTnQ1Zk4zRHBETXdHOTUzWEYwOWRk?=
 =?utf-8?B?aHFUR3lQc0VNZktkUE54YitQN3ZEb2xQVGkvRWZQMkhsa0NkTnNEeWdKakk4?=
 =?utf-8?B?TmVadDZKaUpZOFYvVmpKT2pTcUxnR3loTExZUzZUNnNwTDR3UXZKM0lIWTM5?=
 =?utf-8?B?V0hpbDlmMkg0WnQ1WmtTZnEyektqMENSa09sSTd4MmpBWkJPTFRzK1E3K3RR?=
 =?utf-8?B?Tjg2Nk5EVzBhNFMyN3lTb2xCYk1zejVYS0lIZk9IM3RWb2RCem9QdDA3MG1O?=
 =?utf-8?B?U1BlYTdWWVNSeDlrNjJoT2ovUURRRCtDY1hkS0xOcFVLRUJKcmdPWHVuVllp?=
 =?utf-8?B?a2hXOGtDblFCdEJhV2k1M1c1SXJoeWRUbFBlQVRVYk9YVHN3QlIzbFBPNks3?=
 =?utf-8?B?dlA1K1h6V1YvN0U4VlB4U0ZNdld0WDRCOUhaNysvMys1ZCtMdmNSb2FSSHJO?=
 =?utf-8?B?OTZIbUtKTHMxVEtiNTR2NXowdUlPb2pKLzlvMG9RTWxsdGpoZGhReHhnbndJ?=
 =?utf-8?B?eXh4Y1gzMnd3U05OQ1BveHVLaUwxV09vYmdhOUFJRGluTjlmSHlGOWR3Mnlj?=
 =?utf-8?B?SjFHTXpnNXo1NzdFRjBVN2tHT1A3dWl6TEhybERyMlFFOTFDbHJVVzlQU01N?=
 =?utf-8?B?eC9rN09qQ3ovSmREUSs0RVR2TzZpa0RZb3ZzRzVYS0RhcTNZU1RkdFRzbEJp?=
 =?utf-8?B?cW85TFBtT1lueXA1RXUwcUdOOStUTEZybVpwWXdYeGlDRDFPOVp5KzBkeGpK?=
 =?utf-8?B?L0tCbzFGLzZXbmw3b1NwMG5xYVEyallFS1VBSzl2c1Z0MmFCY1N1YmFIWWVB?=
 =?utf-8?B?TlVMdk4vaGJzY2ZWY0RjU045MFpmRzcrS3NEc09SVy9kWkltcDhCc3o4ZnNP?=
 =?utf-8?B?NmxNMWlRV1FjaEJnMWlZWEI3cHQ3bWpVbFdVdEhXMFNpQnhObXRWZ3lueWF5?=
 =?utf-8?Q?70Exe0Cj41BBQMATDGtq3AZa+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb1eafa-f65f-4491-a9ea-08de03a37aa6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 00:09:40.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mDFnzAbSgCpVyxTWmg3AoKMjKHizE7jfRekfE3e7CmbvqF9Ed8A1rPyJJmlAq+NBQ8ZrfIf2iE5vMi451qqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> mailboxes it must be able to sleep, meaning a mutex must be used. The
> SCMI platforms can't support an overflow interrupt.
>
> Clearly these two can't exist for one MSC at the same time.
>
> Add helpers for the MON_SEL locking. The outer lock must be taken in a
> pre-emptible context before the inner lock can be taken. On systems with
> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
> will fail to be 'taken' if the caller is unable to sleep. This will allow
> callers to fail without having to explicitly check the interface type of
> each MSC.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Change since v1:
>   * Made accesses to outer_lock_held READ_ONCE() for torn values in the failure
>     case.
> ---
>   drivers/resctrl/mpam_devices.c  |  3 +--
>   drivers/resctrl/mpam_internal.h | 37 +++++++++++++++++++++++++++++----
>   2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 24dc81c15ec8..a26b012452e2 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -748,8 +748,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>   
>   		mutex_init(&msc->probe_lock);
>   		mutex_init(&msc->part_sel_lock);
> -		mutex_init(&msc->outer_mon_sel_lock);
> -		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +		mpam_mon_sel_lock_init(msc);
>   		msc->id = pdev->id;
>   		msc->pdev = pdev;
>   		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 828ce93c95d5..4cc44d4e21c4 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -70,12 +70,17 @@ struct mpam_msc {
>   
>   	/*
>   	 * mon_sel_lock protects access to the MSC hardware registers that are
> -	 * affected by MPAMCFG_MON_SEL.
> +	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
> +	 * Access to mon_sel is needed from both process and interrupt contexts,
> +	 * but is complicated by firmware-backed platforms that can't make any
> +	 * access unless they can sleep.
> +	 * Always use the mpam_mon_sel_lock() helpers.
> +	 * Accessed to mon_sel need to be able to fail if they occur in the wrong
> +	 * context.
>   	 * If needed, take msc->probe_lock first.
>   	 */
> -	struct mutex		outer_mon_sel_lock;
> -	raw_spinlock_t		inner_mon_sel_lock;
> -	unsigned long		inner_mon_sel_flags;
> +	raw_spinlock_t		_mon_sel_lock;
> +	unsigned long		_mon_sel_flags;
>   
>   	void __iomem		*mapped_hwpage;
>   	size_t			mapped_hwpage_sz;
> @@ -83,6 +88,30 @@ struct mpam_msc {
>   	struct mpam_garbage	garbage;
>   };
>   
> +/* Returning false here means accesses to mon_sel must fail and report an error. */
> +static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
> +{
> +	WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO);
> +
> +	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	return true;
> +}
> +
> +static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
> +{
> +	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +}
> +
> +static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
> +{
> +	lockdep_assert_held_once(&msc->_mon_sel_lock);
> +}
> +
> +static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
> +{
> +	raw_spin_lock_init(&msc->_mon_sel_lock);
> +}
> +
>   struct mpam_class {
>   	/* mpam_components in this class */
>   	struct list_head	components;

The inner and outer locks were defined and used in patch #7; but they 
are replaced by _mon_sel_lock in this patch.

I'm wondering if this patch should be merged into patch #7. This patch 
seems is redundant.

Thanks.

-Fenghua



