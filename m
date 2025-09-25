Return-Path: <linux-acpi+bounces-17297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C43B9DAB6
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BA57B5D56
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDB2EC548;
	Thu, 25 Sep 2025 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMYNAR4j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E02EBDF2;
	Thu, 25 Sep 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782023; cv=fail; b=lssHUaPu8qsdFgS/cNtq36oRWh/qsZZKdMiTcgnpFzRcay2jzW6H2TEoj8/MFJNjIV6BWCALFuUnA1f6S3bEH3qApCmtvLxzmxxShQ8H0NRtkRjhsEhlS0sxmmeF/O5atVfn3TBA2tHNXIup04GrWkfWsqNqtJwpb//m+tLo6UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782023; c=relaxed/simple;
	bh=a9pK29yiDulSYASVjHLAPzLow3t0Ka9PIgnfh8mPYXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qku8mh3CEazyNgIP5VdddfsxRcVbLMvqmkKq5zn/bW50Xnn7l7nHQK1jT1rAydltOL/WqFGFXqCIQDjCFs+T2oiRV06nqRKt5lwAEVimvucXbGb6jDyd6l7Jo8VV2jGZQNK5BA9WYONdMfnecmYEDOnc3BcLYYJhjH3LlnSz4cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMYNAR4j; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv9VNyVPqaZuWpTjs/hGlbZPiCmaQhT0gPApAiU1UrXTGeSuY7CwM8pZ8qVE0kzpl6/FihrbBf/IChrICVlWZMIELnqsVHaNsW3uJWQRJH/Cx4CElfMBrrL8H2XsC3hLnMsHt3b8GqmGAje6i8GtgVTrcEXK1sBbAo6kjOYkg0S6cfkllvVwJDF5hLt9P5w4q6W06TpLSDj6LiM9jqvKa0PMs5wd/34TnxtIKVhnRDMFicC7tq9r1mNWZU0zBHi9u++o7/RIod0jH1mLH6wylgLWawo9nSt3vmjOzNlO20/jE/beDiRdEg+ASqjNBIKWQy/+ttB57IOk79xqZB4yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3d/+HAepxOekFMNhxnzDaS9pXEMQxhri0eS8XVmQJQ=;
 b=LZAgi1WOuAgLvjtMlV8jHKBYJzxMWXQdIyaQ4N37ZF2mjxvIMsJ7mEa/lCa0nJmnGKvBfDlFPrE9xQnNy3rTsVGBpAT+R1AvL+70A3RtiZMddtSjGFJyjqXAmT9m0FWPO9peBC8R4dAC8xgUNjeD3o9jUvhELmjaMWPj3Yw9KlFWzqdH5iwY18ewZQh6yEA+66KOGCtLvdYTSc2BvM/1X1OhrkWV3u+nTmsGfhSlHxsTvhSv9BaGHycWoZlGdQJy34oBUatV6qV85xCGRCyvIZx72S0xeyCUIejDA5kli922EK2lm9ZzlWWLvP08PO8iQAt9iQzJGdvkRd3+AHyNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3d/+HAepxOekFMNhxnzDaS9pXEMQxhri0eS8XVmQJQ=;
 b=mMYNAR4jWKZ7FO8NF5talhBCCcxLbGYdwotfSQt+A9KBWcEQREzxPkJJMbCKybrdLHd/+Ng9lHE3xPfrZll8YaAIRWBuZtkZPFLIF/brx9o9wEGm6c1rH23tKGN3ojrBdBa2q1ZvnNdMf3tPBp38adRiz295b4QtaYsvbxsJK07w+a7if3t6REpFWHvcTxdCnBHGGN3xX0k/8OyFfLLoeIgnjBw91+By6EE3YqLbUuizgacpuNuzLm9uzoBEHN0NQvV0Hg2JK9Fzmmag2CB5qgm9djZxSerQiiBCGb0yIIONW0a1mzG9gqLhVYj13SfuwYBktnZ8FI7E/tsV68nS0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 06:33:34 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Thu, 25 Sep 2025
 06:33:34 +0000
Message-ID: <83ec74cb-02c3-4be4-a182-c2c69619abaf@nvidia.com>
Date: Wed, 24 Sep 2025 23:33:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com,
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
 <20250910204309.20751-19-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-19-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dcfe80-19db-4116-3922-08ddfbfd7327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm1Ba0gzQmlzQzA4R0Z0L0hGU29lS2NRYWNDdFhzTTFSL29aT0Vib3dqQXAz?=
 =?utf-8?B?cWhPL1dDQkpTNElmck5rMUl4eml3bVh4V1pIRVdYNXRUemhuNDJHeWdUTjM1?=
 =?utf-8?B?N1JiZ05iaFJ2em9hZXdHK2NsSmxvWTJlejJnUzhyZlViaTgvR1hWY2tKTENk?=
 =?utf-8?B?c3hPMVhCdC9SYThoQmNZQUFybjRUY0NvZDE4YkpnTWlvTDU2b1hRQ25mSm5T?=
 =?utf-8?B?ekt5SUs0TEJDOEt2ODRDZjdlTGNBMTRHMXBDVmpNUURhNlNZT2g0eHZJcVQy?=
 =?utf-8?B?cnJDV3lXNFJWZklVNnRnWkZQYTgxY0I5bWZ5ek93SENWTDFCc0cxT2ZhWUo1?=
 =?utf-8?B?bG9HYk5rdE8zUmxLL0xpODBzSEE0R2oreTNWejR1b3cvWmdadlVpRkR4UVhs?=
 =?utf-8?B?RENUNE40bEVmbDF5djV3czQrWkt3ek1kc0JnZTVUS1ArTVR2bVhEcFdaaGhY?=
 =?utf-8?B?ZW5pdWplYnJIbnlCTytQN2lvTmQxYW9kYW5LS0d1bVZNMm1rek5LTXR5aURl?=
 =?utf-8?B?YXNzSmoyakY5N2IyUkd1MmZmRVBGZWE3a3RUeE9qS3pGM3ZQTXpGaWJzT3Vl?=
 =?utf-8?B?aFVUUUhFQlBpY1BaUEM5UlA5N3YzMXZ0SVM4RWN4TStMYStEUjg5ZFRDeUFq?=
 =?utf-8?B?aGgrVjBScFYrZ3ZiZXhBZmlZcGVZM0pEcERwdUlDNUFaMjJ0dmoyVEtVaXR0?=
 =?utf-8?B?UXdwbk11V3crOXNPTFVTdWkrUEUvSlI3bWVCS3hTY1NKK1F4aG5DMU1EOUJY?=
 =?utf-8?B?ckMreUQybHIrV1Q2dFp3NWw1MFpNcUpqZHZ5VDRrT25aSlhCZDRRa2pNY0xQ?=
 =?utf-8?B?QlN2ZXMydWJTa1Rzc2ZqdlVrV2tZRjd3Q3ptYXJMdC8ycGp4Sno3ZWVJZ2h2?=
 =?utf-8?B?TDdWRHllRW1ISUZ4QkhjNFhNbGEvZnlTaW04dTZmZ1NFbDJjUjVMOXB1RWZJ?=
 =?utf-8?B?NmVTcS91dGE1aXVOQ2oraFlJc3h0Sm5XRjI3cDFCNnNQVGZJY2pPd2l6NEI5?=
 =?utf-8?B?cHN2YVI2bnpXL2d2bCthT0JCTUw0S2JzcWY1aVkzWEFIcHB1UnBRZW9HOHdq?=
 =?utf-8?B?bGxLU0VIK25nRk5GMzk4RnNXcEFrN0dlK2liK1laUVdoTWw4QlZjU3RWVnhy?=
 =?utf-8?B?cEQrTnpZTXV6YjF6bzNnNVMxVTBHMmtPdXRSZmROVkd2V0N2OUJscFBKSHpy?=
 =?utf-8?B?c0hvNHBlT2docWFLcXFXS0o4cVhhTU5RL2w1N1NmMkFkeFN5am43VTJpUTRS?=
 =?utf-8?B?QnA1NDhMMklDeTEvZThHcXZoOERhMmdxby9QYWJEdnhOeHJYRFpsbnZCY2NN?=
 =?utf-8?B?UmpLUVR5ZExzVVUvR3NXS3BDMHlqYkJVbXpxTHpHMEIrdmhQNmtVYXpzbGlz?=
 =?utf-8?B?ZDU3eVVVREdFeGVUcHZpUGo4dmxuSldSRkphQmV0VFlSb0MzKzJQR2JWdDcw?=
 =?utf-8?B?VlZDNjBlT3IxM0VWZGljdXhmdnVVNDJiMFpsWVF1Wnp6bit5RTFsV0k3SFNo?=
 =?utf-8?B?bDFleVp6c05rN3hwZHh3WnlZK1VaRnFTaC85SEtFK3hIRG9RUVl2MlRKc3h1?=
 =?utf-8?B?dENoZ1c0a0VOY21yMXl1NkVialphZjJuazd6eTFNTGkyRXlDa0trdVdrQ2J2?=
 =?utf-8?B?QmZjRmdwQjlzUUVtc0psS2lBWmFSZ05lZjN0YjFKM3RLUytTWlpjUCtheGQr?=
 =?utf-8?B?SXZQWGRZV1I2dW45REFuWjMxS2RvcUxuUVl2T2owT1RsdTM4RFlUeFFmcDY5?=
 =?utf-8?B?a2ZMUzczV1dYUUU2V0tiUmpicTAxcDRmZldIb0UxKzMwdE9Bd3BuTmJWMUxI?=
 =?utf-8?B?TmN3R1dSK0xFa1ROK0Z4bnQwS0FaY0IxTHdxdFJ4Z1NDSS9ObllSMWFMdE1T?=
 =?utf-8?B?VGZ4bXFhMk94eHNXZzZreWUxVmt1a0NDTWdOSUhINE9JSjRWb0lRUGdLS0hn?=
 =?utf-8?Q?uQ76PnliDq2CCG9ga/8xiT34ROD4fgs2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmNVbUg0UTZnQ0RKd3kzeVlVdm40dzdPaDE2MGNKaGpWZ3BTa1g4VlFNZFhx?=
 =?utf-8?B?Q1cvaWxxZGdUb1lsOXd5Qmt4ZzlmWGIxMVg0cm92Mk5kbWREMTBGeEVBWldl?=
 =?utf-8?B?QUpmRzQxVi9ITjRQQkQxNkZ4YklRVmNiSVlZbTZDNWUvZ2VJeThiK0ExWjRY?=
 =?utf-8?B?MVYydlgyZXRGTnFHMk4yT1RnakpzQzgrUDlmTWhyRElxdm5hcTB2UWVtZEY4?=
 =?utf-8?B?UGNzdlRUdTE2Y1MydGh4YUZVZGRvajZGWGxEQWVOOGV3bjFnNkJQaWpNMlU2?=
 =?utf-8?B?YXRteGpVQ0FJTjlyMFB0RWVsNUJiSUh0RkZxOEdkMHkwbkQ5VThmeWRxMzhp?=
 =?utf-8?B?VDB0VHBnWmlsVHh5d3RiR0lKeGx2aFF4Ukg4aGluNWp2eFo2K016TldjREw2?=
 =?utf-8?B?cDdqTkdrM0FFTW9sWDJTZDVYQjlkdmtPK0FiQkFxcGNheEwrU3IzejNTT005?=
 =?utf-8?B?L1JMNk9ZcTgyazNCeVRMRjZBQlZHOEZBSnBkenhXTnJSZGgwZnc2dHF6dDky?=
 =?utf-8?B?TjUxS1ZnQUlkdHAyMDdnVWM2L1J5TDdUMm5JWTFoM1M4djRqWHVkUG5Xdkhv?=
 =?utf-8?B?M1FXeDBVT25nWUhwQXZyNzJuaTJOM0dtSmwwQjhHZDZIT2tzV1lkVkx3MVNn?=
 =?utf-8?B?WFlaQm1ldHBTc2dYTGZvYndWUnp1VC8rVFVnZzh2anZZZnA4MHBNdDJjQ3Nu?=
 =?utf-8?B?cWVZUjUwV0dtbUdFeWNpbk1SM1ZPVDhTL3hRd0ppWVNTZWVzM3NlaEhLNE80?=
 =?utf-8?B?cFp4SzI2TUVUQ21MWXNXZDhCY1BKdUF0bGRuc2FzY21sNC9BTVRnQzQ3MHNI?=
 =?utf-8?B?RFJpV1RZSVdrSHdSZUF4SXNnMVFnOEdTZ0kzZmhNMi9SQlBvTnllT0FZbUQr?=
 =?utf-8?B?TmQ3L2dvemxrMW05NkUvZUx2aUR0ZUZBck5ZNlhWLzNNTnBSMEVkVS9EcXNK?=
 =?utf-8?B?OHlTVHlvUVF3ZUFOclRicm8wWnlhakZOcVVIVzRaV1pKRmhwbklmUk05TGp2?=
 =?utf-8?B?MFRrR2o2VWNrbmsxUXdZbjZyMFU1cXd1dzN5M0ptY1Z6UjBSQ3V0MzEzNS9o?=
 =?utf-8?B?WFlMM1ErQ09vaFJPZUVOd0RKS29XdzNlVTVkVXBhVWs5aCt4QnoxNTVkbFVP?=
 =?utf-8?B?dzdMTkRNVHVQcDVONTRaKzEwcEs5Wmk0UUxTanI0U21jKzN1c3l6SFZkOTdm?=
 =?utf-8?B?ZnBRRk9PekpuaWZkQ2N2Y29NS2d5RTRGZXZCOEhHV1JrSTdQTUZKNk10cE5Y?=
 =?utf-8?B?cjNFSXJRUy9MclJtdmwzSXRqZ2FpdUUyL01XeFhxdEJyT1h3Tjd5ZTUxeG95?=
 =?utf-8?B?RHI3ck85cGtGS1lnT0RJVkZhOVFvSVAvSUN6aHlGUXFIOUdZRmZXMXo2dHA2?=
 =?utf-8?B?NnVWeEE3Ui9Ed0tpdStZbWYyT1hhYjlTZlhicDhJcG5leU5XWHUwbjkyWEtk?=
 =?utf-8?B?REpVUFZldHNIZTFFK3htb2V2UHlwbGxUQ1VINjRmOUkxazYyZGJKUXNidVZ4?=
 =?utf-8?B?YTZyYkN0cHltWGtVZlB5K29xREp6OGh2WkxQemI0OEw5dHppUk5UQXZXMUlL?=
 =?utf-8?B?Tm1KRFhjVTJoNzRrZ1dwQVR1QzRjQmc4RW54U3VQdU5meU5ZVXAxTmtSeVdI?=
 =?utf-8?B?bHEwWng5S2had25ZZEh4aXF0RnlyaUNIcUozS2JrdWt1WTBWVUNZZll2WTlM?=
 =?utf-8?B?Tkxhemtka2o0eWIwVGNPRUZIallGV2tob2VzeDY0Mm0vS3IxbktWSktKNkV0?=
 =?utf-8?B?bkVhQjZ2VGVLQVUwMzlld1FCeS9HeXdsVTRKRjA2L2FWc1JVUFIrUWlyaFdv?=
 =?utf-8?B?d3I1RERoTEdNaXZkSkROMmpjRkhRcVo3SnF3SFRmckNQRXF1M2ppaUdKU3o2?=
 =?utf-8?B?dXJRazBYdm9PQjlNQzhhNWJnV0luZEMvRlZoNHNaOGIwSmlaWXZlOERhcjhD?=
 =?utf-8?B?MlhFbkJkM21XL0VFT2lhaVNWbE4zd3Q5VDBQSkZCNU5ZbUV1T0JUSHFaTWx4?=
 =?utf-8?B?Sm1DU3BSWTRGM2FxcUFMWDZFaUlSVWQxUm9ZRUJLWGszS251dmNwemZ5R3VI?=
 =?utf-8?B?RXVMSzBpZ0ZEL1JMbVIyZWVKK2xCUFRzQnA1QTlva3ExeXVvNE5heThBL3B3?=
 =?utf-8?Q?fubIyLIMSDa+LmSTrZqALTdGF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dcfe80-19db-4116-3922-08ddfbfd7327
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 06:33:34.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0gIRbxx5Cf8ZKPLOeZecsTj9Z3btsqryx+HCH6/cMmW6FQXfJ+MdxzYX+/iV3owHIDakRfOf1L8zjWp5Ci1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
>
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process
> context as it takes mutex. It also unregisters the interrupts, meaning
> it can't be done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
>
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
>
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.
>
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Made mpam_unregister_irqs() safe to race with itself.
>   * Removed threaded interrupts.
>   * Schedule mpam_disable() from cpuhp callback in the case of an error.
>   * Added mpam_disable_reason.
>   * Use alloc_percpu()
>
> Changes since RFC:
>   * Use guard marco when walking srcu list.
>   * Use INTEN macro for enabling interrupts.
>   * Move partid_max_published up earlier in mpam_enable_once().
> ---
>   drivers/resctrl/mpam_devices.c  | 277 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  10 ++
>   2 files changed, 284 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index a9d3c4b09976..e7e4afc1ea95 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -14,6 +14,9 @@
>   #include <linux/device.h>
>   #include <linux/errno.h>
>   #include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>   #include <linux/list.h>
>   #include <linux/lockdep.h>
>   #include <linux/mutex.h>
> @@ -166,6 +169,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>   	return (idr_high << 32) | idr_low;
>   }
>   
> +static void mpam_msc_zero_esr(struct mpam_msc *msc)
> +{
> +	__mpam_write_reg(msc, MPAMF_ESR, 0);
> +	if (msc->has_extd_esr)
> +		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
> +}
> +
> +static u64 mpam_msc_read_esr(struct mpam_msc *msc)
> +{
> +	u64 esr_high = 0, esr_low;
> +
> +	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
> +	if (msc->has_extd_esr)
> +		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
> +
> +	return (esr_high << 32) | esr_low;
> +}
> +
>   static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
>   {
>   	lockdep_assert_held(&msc->part_sel_lock);
> @@ -754,6 +775,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>   		msc->partid_max = min(msc->partid_max, partid_max);
>   		msc->pmg_max = min(msc->pmg_max, pmg_max);
> +		msc->has_extd_esr = FIELD_GET(MPAMF_IDR_HAS_EXTD_ESR, idr);
>   
>   		mutex_lock(&mpam_list_lock);
>   		ris = mpam_get_or_create_ris(msc, ris_idx);
> @@ -768,6 +790,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		mutex_unlock(&msc->part_sel_lock);
>   	}
>   
> +	/* Clear any stale errors */
> +	mpam_msc_zero_esr(msc);
> +
>   	spin_lock(&partid_max_lock);
>   	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
>   	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
> @@ -895,6 +920,13 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   	}
>   }
>   
> +static void _enable_percpu_irq(void *_irq)
> +{
> +	int *irq = _irq;
> +
> +	enable_percpu_irq(*irq, IRQ_TYPE_NONE);
> +}
> +
>   static int mpam_cpu_online(unsigned int cpu)
>   {
>   	int idx;
> @@ -906,6 +938,9 @@ static int mpam_cpu_online(unsigned int cpu)
>   		if (!cpumask_test_cpu(cpu, &msc->accessibility))
>   			continue;
>   
> +		if (msc->reenable_error_ppi)
> +			_enable_percpu_irq(&msc->reenable_error_ppi);
> +
>   		if (atomic_fetch_inc(&msc->online_refs) == 0)
>   			mpam_reset_msc(msc, true);
>   	}
> @@ -959,6 +994,9 @@ static int mpam_cpu_offline(unsigned int cpu)
>   		if (!cpumask_test_cpu(cpu, &msc->accessibility))
>   			continue;
>   
> +		if (msc->reenable_error_ppi)
> +			disable_percpu_irq(msc->reenable_error_ppi);
> +
>   		if (atomic_dec_and_test(&msc->online_refs))
>   			mpam_reset_msc(msc, false);
>   	}
> @@ -985,6 +1023,51 @@ static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
>   	mutex_unlock(&mpam_cpuhp_state_lock);
>   }
>   
> +static int __setup_ppi(struct mpam_msc *msc)
> +{
> +	int cpu;
> +	struct device *dev = &msc->pdev->dev;
> +
> +	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
> +	if (!msc->error_dev_id)
> +		return -ENOMEM;
> +
> +	for_each_cpu(cpu, &msc->accessibility) {
> +		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
> +
> +		if (empty) {
> +			dev_err_once(dev, "MSC shares PPI with %s!\n",
> +				     dev_name(&empty->pdev->dev));
> +			return -EBUSY;
> +		}
> +		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
> +{
> +	int irq;
> +
> +	irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +	if (irq <= 0)
> +		return 0;
> +
> +	/* Allocate and initialise the percpu device pointer for PPI */
> +	if (irq_is_percpu(irq))
> +		return __setup_ppi(msc);
> +
> +	/* sanity check: shared interrupts can be routed anywhere? */
> +	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
> +		pr_err_once("msc:%u is a private resource with a shared error interrupt",
> +			    msc->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * An MSC can control traffic from a set of CPUs, but may only be accessible
>    * from a (hopefully wider) set of CPUs. The common reason for this is power
> @@ -1060,6 +1143,10 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>   			break;
>   		}
>   
> +		err = mpam_msc_setup_error_irq(msc);
> +		if (err)
> +			break;
> +
>   		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>   					     &msc->pcc_subspace_id))
>   			msc->iface = MPAM_IFACE_MMIO;
> @@ -1318,11 +1405,172 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
>   	}
>   }
>   
> +static char *mpam_errcode_names[16] = {
> +	[0] = "No error",
> +	[1] = "PARTID_SEL_Range",
> +	[2] = "Req_PARTID_Range",
> +	[3] = "MSMONCFG_ID_RANGE",
> +	[4] = "Req_PMG_Range",
> +	[5] = "Monitor_Range",
> +	[6] = "intPARTID_Range",
> +	[7] = "Unexpected_INTERNAL",
> +	[8] = "Undefined_RIS_PART_SEL",
> +	[9] = "RIS_No_Control",
> +	[10] = "Undefined_RIS_MON_SEL",
> +	[11] = "RIS_No_Monitor",
> +	[12 ... 15] = "Reserved"
> +};
> +
> +static int mpam_enable_msc_ecr(void *_msc)
> +{
> +	struct mpam_msc *msc = _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
> +
> +	return 0;
> +}
> +
> +/* This can run in mpam_disable(), and the interrupt handler on the same CPU */
> +static int mpam_disable_msc_ecr(void *_msc)
> +{
> +	struct mpam_msc *msc = _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, 0);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
> +{
> +	u64 reg;
> +	u16 partid;
> +	u8 errcode, pmg, ris;
> +
> +	if (WARN_ON_ONCE(!msc) ||
> +	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &msc->accessibility)))
> +		return IRQ_NONE;
> +
> +	reg = mpam_msc_read_esr(msc);
> +
> +	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
> +	if (!errcode)
> +		return IRQ_NONE;
> +
> +	/* Clear level triggered irq */
> +	mpam_msc_zero_esr(msc);
> +
> +	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
> +	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
> +	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
> +
> +	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> +			   msc->id, mpam_errcode_names[errcode], partid, pmg,
> +			   ris);
> +
> +	/* Disable this interrupt. */
> +	mpam_disable_msc_ecr(msc);
> +
> +	/*
> +	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
> +	 * unregister the interrupt from the threaded part of the handler.
> +	 */
> +	mpam_disable_reason = "hardware error interrupt";
> +	schedule_work(&mpam_broken_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
> +{
> +	struct mpam_msc *msc = *(struct mpam_msc **)dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static irqreturn_t mpam_spi_handler(int irq, void *dev_id)
> +{
> +	struct mpam_msc *msc = dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static int mpam_register_irqs(void)
> +{
> +	int err, irq;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
> +		/* We anticipate sharing the interrupt with other MSCs */
> +		if (irq_is_percpu(irq)) {
> +			err = request_percpu_irq(irq, &mpam_ppi_handler,
> +						 "mpam:msc:error",
> +						 msc->error_dev_id);
> +			if (err)
> +				return err;
> +
> +			msc->reenable_error_ppi = irq;
> +			smp_call_function_many(&msc->accessibility,
> +					       &_enable_percpu_irq, &irq,
> +					       true);
> +		} else {
> +			err = devm_request_irq(&msc->pdev->dev,irq,
> +					       &mpam_spi_handler, IRQF_SHARED,
> +					       "mpam:msc:error", msc);
> +			if (err)
> +				return err;
> +		}
> +
> +		set_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags);
> +		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +		set_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mpam_unregister_irqs(void)
> +{
> +	int irq, idx;
> +	struct mpam_msc *msc;
> +
> +	cpus_read_lock();
> +	/* take the lock as free_irq() can sleep */
> +	idx = srcu_read_lock(&mpam_srcu);
guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags))
> +			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
> +
> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags)) {
> +			if (irq_is_percpu(irq)) {
> +				msc->reenable_error_ppi = 0;
> +				free_percpu_irq(irq, msc->error_dev_id);
> +			} else {
> +				devm_free_irq(&msc->pdev->dev, irq, msc);
> +			}
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	cpus_read_unlock();
> +}
> +

[SNIP]

Thanks.

-Fenghua


