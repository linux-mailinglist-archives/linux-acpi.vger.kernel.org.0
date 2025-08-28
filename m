Return-Path: <linux-acpi+bounces-16123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EACB3904B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069D13AC866
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891A1A256B;
	Thu, 28 Aug 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sEBjQK72"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434442905;
	Thu, 28 Aug 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342716; cv=fail; b=GFP6BkbrctOXnl37hOrRmGzANTE9ZwafWCFa9Y6QEEPLfIjUWX4rNDuUJLzd2Ys7C+SXUtwoNxA0jcGJ412ODZqXp0o4HiTuAKN0jiCy1QJlzjU81JbQzAMjtSng6WGlaUnBo0VEhFRcM+Lm/ZDtNH0Th70C7l1Vd/rIzZlPC2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342716; c=relaxed/simple;
	bh=B6v93a/USqXYQEqXPZaQWw+yPhgAiTuiBaKPhRmEuQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=liOf1VK6a3eUuTp+cT1IGBk/PXvj0sQEtGeZFHKYqzBkK560kEJkxB6DglBR+T7Ye5gE69j7vycSESoM2ofzZPDcWGldepmZq94SGRymIlKmzpoZyl7F5MHuF1u60ECLMs/FIBJzquB/3fmXyYcvajjKeFbo15mPOGiywHz8s4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sEBjQK72; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgijoD9pq54LjOmWa+cuOWAlYL389ivmw+lrlHB3v4NHSBbzfUClNxdsCG6uGTeYIm0ekEu2KFTCV3iO2ND5XWBU7b0yUCQ877jHFWKVcmqtPompujdMPJeqY6YtFCe20Bt9A0IT/5lBEmMJckvC/+ByD+SAqjXt+MsUzzWiU63+OMprCzKdfCHx8OqhrNf8uVA6PfSfYJcxcmZS6b7aLeL1KbQzasae32syRiSqmBuntCa0uuIwZWIKuzOXWcW2UpaSXW2s6TbuuPh5B6P7ul8S7bewExCGiKQkjRqGvoCElfh8HmFzx/tBtE5QQ3SAy4AoPxBk9w2p2plqVbb+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwGvqs5d9QV9d5qiizggaDyblMn3Av0CsSpdCQrzO98=;
 b=CDdEmvfRrCiYhXV/tRFaSRGAHovO9KUS4i6YaR9lwGw+MDlHq38BDfbZ+uT0Kv0lMzrRtNiqwUrxe/GcwlMEzPT6qgYk6lSINArMK2W5v99jqju/kEc4R1vflU6Oz6Y1ywqiPFlOvpiIIsUTrBvEJF+mK3elxAsRti09qDMdPBWoV/clkKpSAgyw9wbwaSPZW1doZQtQ8aBfvygqH7RJthWk0PVVLg1nFP9EFHhoCGeL06ZGMTfkXZLq93H0Cf4GIs5K88Duw1dPQmUQF6BHa64TcqAIE53SfqS2UEvOHgAsioMJxyOnRuouC3ltPtCmxXnor3N6x2xI8uUdR29OpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwGvqs5d9QV9d5qiizggaDyblMn3Av0CsSpdCQrzO98=;
 b=sEBjQK72it18Rpm9G+MFoZ2kK8KvF7mFsBii8q1XiPAEoWFcSld7MrGSiH063XWMVZ3PVEv/0myhwCDPSLgpaDhumwGJQKCnVtGhsrgYt50+lGb9ccaaH7OLWbhPlUMw4jRQHHWJvV2mlE4G2WH/A/WPjERtPPQA3TCmHqhffi7g9/nS0vH3kZ4BNQV8kNsqsYiuCygvUTvKB04egZzLXoTZrHefuxQas+gpIVGCnzPDnpGxfR+JF2UzkIspKodb7uv+AAS/HyPXLiHdJhcEw/BQQQQx1oEeNWN6665lY93al3lnGt0cjFefA4eGlrSjCfVkkAZ/KDgP+Hgns8uDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 00:58:30 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%3]) with mapi id 15.20.8989.017; Thu, 28 Aug 2025
 00:58:30 +0000
Message-ID: <b2fb792f-92ba-4bee-8a2a-e434405653e9@nvidia.com>
Date: Wed, 27 Aug 2025 17:58:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] arm_mpam: Track bandwidth counter state for
 overflow and power management
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-63-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250822153048.2287-63-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afe7577-26d0-4b35-d4f2-08dde5ce00ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REVjckhSUDE5MUEwQ2dwUmRZNFhpMGhVcmVIOFdsN3E1LzlVMGl2REU4ZVNL?=
 =?utf-8?B?M1ZhRzc2eWZGdVFwRm41MVRSVzZqMHR4bERmY2ZIWjh1R3I4WFdNVXBwZGlW?=
 =?utf-8?B?QXhRNVEzdWliZ3N0anBtbXllTGNCeThZa2lpK0tybXVnbmtEZEtxaU90ekFj?=
 =?utf-8?B?Z2RRSGEzbkZiNXgzSDVFdzdaS2hXNS9OVWhPNDFoRWs1S0k2UkNSNlNUcGZl?=
 =?utf-8?B?bmpET3pzQnJzUmxEVlBVdG0xLzl5RDFpMXVoMjA2TFhtOEFLb1IxWWRFUDVH?=
 =?utf-8?B?OWgxWEo0bitwQ1FrSGRZeEtoT0huYytaWU9YbnNvZ2JxTUlmNkVCeFdMR0Vw?=
 =?utf-8?B?cmR6R2NJMkhWYVkweXlqQW84WS9saDhzWGhYMnZ2NithdEtWMk1rZnYzS0VD?=
 =?utf-8?B?ckxmY2t0dkROanNWMEdKNnhuRndTbyt4QVpQNE82MHlFaDM1eHAwakJ0MzQx?=
 =?utf-8?B?K1EycE9DTC84dytkdlowRVB1NEZoNmErMHBEaldmWnlDYkcxakRoSHBsQXFh?=
 =?utf-8?B?TERvSWFZYzlSRGlEQWY2NUpPeFlPSVRzeFI5aDlWN3FWZjI2YzJ0NGNIN0h5?=
 =?utf-8?B?dHY3VW92NDBXNXVLRCsrOURocTZKcWVIdCtaaXdFd3Z1bll5ZXFFTVhxOXlM?=
 =?utf-8?B?RnRsSUhnRzlGQ2JQUUJrSU5NSHl3TW8xZklXSDFkQXl2MzYvdzVSNWRYdlFp?=
 =?utf-8?B?YVZiajNkMUFmZmFMbVJzODlTUWtEaDNkMGpHbkYrUG93UzJqdjFSRlB5MWd5?=
 =?utf-8?B?ZUpEM1dQWUpqVVkzVWxZT25YSC92SVM3RExDcFJZSXlkcjI4MXprMUdGRFQ2?=
 =?utf-8?B?ZGpTOHNkeGFFTW5YRzJnYlFiMFVVRXhhUnd2b2FiRWdWbmh3MVBzZVhuNzl1?=
 =?utf-8?B?SFNUd2ZPQjlrOTJPb2pEQlB5OXFRK1dKTURTT2t6ZHFraWFMQW9hRFBYUnN1?=
 =?utf-8?B?RHVNbDhIeC9PUWJiRXN5Ti9QYVZoTWFnRXI0RHVlMDBMMHppRVJXekdnQ1d5?=
 =?utf-8?B?aVQyOExZd0hDMExic21jYmV5NFhrcEtUdy96Y0JIWEJkM1pseFMzb0xVQXVy?=
 =?utf-8?B?U2hZVlphOG4yRWV4VUpycGN5YU5IQkp4bUVycjR1c29HUnd5VHhWNUZ4b3Yy?=
 =?utf-8?B?T3d1SkkwWHVDcWdJZEFublRnUjZhRVloRFlROWpUMDFTTDlKWHpDdUdJZC9x?=
 =?utf-8?B?R2VrK3VMSi9EZy9ZQ0xIWjJIUkdKeFNKVzRiVk91ejJXLzIzQnRRbFBwL0FP?=
 =?utf-8?B?WlppZlA0ZTVSVUVWZ0YrcFJDdm1hbEpGaC83MW1pUURVV0dkcDhtUkFXRUhO?=
 =?utf-8?B?bUFWTWN5SnFVZDF6VnlOTDI1aDFLWGl2enlSa1JHWnM4VE1OekNkbkZrMS92?=
 =?utf-8?B?SUUxd3B4YmJGblFRS2NFWkRnVEIwMitCcXVyTGdMeEc2YTNDQUJYR2hJMHRq?=
 =?utf-8?B?MkRycHFMT3hPVk91OWw4RDdZSEhDODBQZXpUSTdiZmtwL1BNTVBRTEVVdjAz?=
 =?utf-8?B?SGpTTlB4ZURFcHZiQkdTb042eUlxRFFRS0ZDRDJIQ3VKV3BiRU41OTNEc0p6?=
 =?utf-8?B?VDcxZlhuTHZQckRhL3FxOGsxYk9vRm9PSEkzZisweSt3NWx6Zm5sODNqVGF1?=
 =?utf-8?B?RUM5b1NzaDFSclB3TjZ1b2tVbE5xSlB3SW9Qc2IvTkRlY2g1RkNoenBIZnl1?=
 =?utf-8?B?djZ4SlJ4YzFYMnZqWTJRaGxhM0hFTVJiRmZ5SHQxL3BNWVg2SnNVRDZXeUUz?=
 =?utf-8?B?Y0gybmFENkdPeVNxVG9WMGV6WUo2Mm5yRm5VUGdpSTNRcVorZ1JUOTk2OWNl?=
 =?utf-8?B?d0RDRmhNWVI1bitSejZ1OUtSdDJWYWJjQ2xyNVlkbFFIT0VUR1J1dlZobDNR?=
 =?utf-8?B?M0JmU085bTdzcU9RU2swUzdWeCtrNkJCOWcwUGpTL1N3c21FM2FNK0o3anRE?=
 =?utf-8?Q?tqSh/vjeK0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME5RZ1M0ajNvaEVKVDhQOUJIWTBKY29WODcvQ0hSbytaYVkwQmE1YnAvZUhC?=
 =?utf-8?B?M2ZLVEoxYzJJb2FmeVVXMGdoQmh5RVZXVmxTRmRtdExVS0VMRC90YlA3elZk?=
 =?utf-8?B?T2RXMkVHZ2Fhd0NoL0IyeGJvbVhrTmFLWTkzUXE3WENIcXlMRXFaWHV4bG43?=
 =?utf-8?B?eHgrSklaRTVLejlaQVFjUmNjUEQxMW1GbzlsdUNSZlYwZ1AzQ2N1eURCZmtm?=
 =?utf-8?B?a3JIOGlUUGNwemJ4MnlLeEk5bWVrWkR0MGppSkdEZ2xYam1uaDA0WkNLK09s?=
 =?utf-8?B?c1dxNUJWQ3NmUWhaRGEvemR2SldtdUdNaVo4aXhweW9Qb3M1cEE0cEYwWGtK?=
 =?utf-8?B?U0YwUVEwcGdhVWllME9tSzEyTEN0SVhoOHNhQWF1WXlLeUpiSVVCM3MzZmpD?=
 =?utf-8?B?c0Z5QUg5REtubUxvcFhGd2NOdGRuV1N4b0RTNWtMZENlVjFMdGtrZEg2ZlRk?=
 =?utf-8?B?emFZbjl0ekx4a3A5VUpuMkp3Y3h0WGdrZDZWN1VQN2FSajA2cHRtR21pWE03?=
 =?utf-8?B?K01DakpZM1hoRWhlNmh5OWxLeXFueUltV1dDcWpCOHpKTkpvN1JDRDY1elM4?=
 =?utf-8?B?anNuQzcyd1ZIcHRLZmw4K0lyL1BLS1RJVkdPNG1TaXBNdGZmSng4eEVxZjA2?=
 =?utf-8?B?QmU0c1psTUlpTms3WjJ6MGxwWnNhbW1oWFl6cS9yTThGQTcySk9UMG82V2RK?=
 =?utf-8?B?QzRaUEtiOWhSUFJJMUcyblY5UTJGeFNMM0JrYm0yUHhlSkVyUnBmME5pYW1I?=
 =?utf-8?B?S3RlM2c0SnRHK1hnc1VNam4wemE3d1h1VUZSTkZPV2JvNW5CZ2o2dG8vSnVv?=
 =?utf-8?B?Z0hVWVp4VkRQY0x3Wmk3SDZJWHdKWDRlMFNOc0xCY0ZGNE9UbGFEQ0pNdlZW?=
 =?utf-8?B?cFAybVBYa0x5VTRkdWtybTF5ZUMxT3dPNDUrelpWVjZDRVk5cE1ZYjNCR3pL?=
 =?utf-8?B?V2lncWg1NktvWFFNTU1wRkVHSzh5eXBEeTA0YnFFL1ozbk44WkZLenhhdGVi?=
 =?utf-8?B?dnF0UlQrNDAzNXJmTVBUSURrZ2VXV0tKVDdKZEpnSklKQlRCS3cwY3NVMkdj?=
 =?utf-8?B?VklnZGtBN2tZY2E5NktScTkyTVVYU1NVVFpBYXowaGowdXF4L1hCWDA0Unkx?=
 =?utf-8?B?NnVEY3F1UUFBTmlyZTlhd2V5N1VrT29BQ05sS2I4ZzZkclFjQ3ZhSmFPcTFy?=
 =?utf-8?B?YlV0MjJMckVmbFhQbDIzck1NaVIxZUZRQmNlSHBSVW1zNnRMOU5TTDdWKzVY?=
 =?utf-8?B?U0o1N3JiT3F6dnpoWGl3dDJid1BhYUI1dHZlUTdVYi9wOCtBNTFBZURYb09q?=
 =?utf-8?B?WG1DYWZsd3lUQk9CRmp6akY5c0swNlFqTHVaQ1pLT3J6Tk5XVW9SUUZnZjFJ?=
 =?utf-8?B?aktFTDRQNDJHcUZhRDF5R1NaU0ltVHBTZGEvbXRvQkk4U3czSUwzM3JySS9M?=
 =?utf-8?B?RTAzc3FCVExGZmMyaUNSTXJMK05PZ2RraENjNE54SVZsQ2czRW9kTm5jS01M?=
 =?utf-8?B?NlBjaVExN1FHeTQ4VnFIRXRUcUhNcGc0QWNQU2p6VXRWR3RtaEhGeWVBeTFj?=
 =?utf-8?B?dGg5QmUyYzNQM1o2ZlEwTlJ1VUF4dGlzaHdkYVRxSUJadTFHeHozTCtKcEp6?=
 =?utf-8?B?L1A5bzM4Qk1zN2dVNXBvTXNoWlFlaHpEUDVPa1hPV3BTbWxqOEdEckhQS2Q2?=
 =?utf-8?B?QWZtc2QwWEtCQjcwcW5zbVBQUUNTaUNWaFZzVU85a2VlYld3SmhBcisyVVJ2?=
 =?utf-8?B?UGdkQjczTnpNUlNSeWNSK3RyekU4NXZxY01taUxaNm5FTGwwRW1WMFVyaW1M?=
 =?utf-8?B?ak9UZVZMWlF4ZGYzd04yb2dYdU1WbW94eUF0c08ycjZwUzYySnBEVldqaDBZ?=
 =?utf-8?B?Q1E5WTB0cnNhUUxzeHVFMXRTK2pSc3dVV0JBM1c3Sld3VzdjTkdWbTZsNkl4?=
 =?utf-8?B?TTFxWE5hanFZWDAxbHk5Y2UzUTJxUzlNaVkxZVFpMS9VUXlxelpSMzAzVTk3?=
 =?utf-8?B?VHMzSFVLVXA3bE9ZSVVZZzBya05hV040bDNpaVJyYTQrTzRlTW9keXpQQkdy?=
 =?utf-8?B?bjd4MnRPbDFPa0VRV0NHUE5VbWsrdkMwc0dScURHZm9tWjhnRUVCVzBGcTR4?=
 =?utf-8?Q?5OhkYCUENbMZd7v2ebY54Hwcv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afe7577-26d0-4b35-d4f2-08dde5ce00ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:58:30.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSXDRTumzkmabQgpH1bkPUT6eaVMdyEXaEwOR9VeEkG6QsRvm+8YhQ1sGwHwBjbfPeALbHQFkgAX4BN278Tu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050

Hi, James,

On 8/22/25 08:30, James Morse wrote:
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
>
> The value read may be lower than the previous value read in the case
> of overflow and when the hardware is reset due to CPU hotplug.
>
> Add struct mbwu_state to track the bandwidth counter to allow overflow
> and power management to be handled.
>
> Signed-off-by: James Morse <james.morse@arm.com>
[SNIP]
> @@ -2291,11 +2395,35 @@ static void mpam_unregister_irqs(void)
>   
>   static void __destroy_component_cfg(struct mpam_component *comp)
>   {
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
>   	add_to_garbage(comp->cfg);
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		mpam_mon_sel_outer_lock(msc);
> +		if (mpam_mon_sel_inner_lock(msc)) {
> +			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
> +				add_to_garbage(ris->mbwu_state);
> +			mpam_mon_sel_inner_unlock(msc);
> +		}
> +		mpam_mon_sel_outer_lock(msc);

s/mpam_mon_sel_outer_lock(msc);/mpam_mon_sel_outer_unlock(msc);/

Or this will hit a dead lock.

[SNIP]

Thanks.

-Fenghua


