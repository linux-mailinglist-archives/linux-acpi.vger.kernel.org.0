Return-Path: <linux-acpi+bounces-17494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7693BB2719
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 05:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E83319C6437
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714E23E32D;
	Thu,  2 Oct 2025 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xd6XdDJc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E628643E;
	Thu,  2 Oct 2025 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376112; cv=fail; b=d1dnrFaJfT1sB9wSVDqIdzECHvGHD5d11YcDJNeIHfGsGXlvjj7XMNU9RnU9IAScNTSbX+95SNl2+QZPNAtkBJUj7m5/kpviIqqpA2aXV44DLu/MPZ1dF6CgE+X6c5n/LyX4eg2TIjM3NgbIZ0hJ+aNg9GsI+LliW4Zka7YakHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376112; c=relaxed/simple;
	bh=Kcl6+/xSCFdAETFLs4cM7hbZZ8K2yP29oQeLlsiYPoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqZSoQ7GRuvq/Ru9Gwl044H9UIuuZKubDs7GK8eKSPxYZSXe01PlYrfz+g6hMNoBOibB4fXD/+YyajK9YIPMI3g6we7+rOqD0LmeD5zXSG8JKxn2Wz2b5WLONQWixnYyCE4vn3nyaaZDMyUeYZchWv/r2tas7QKX1khIhL1TlAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xd6XdDJc; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp+XKjpdTe9403CvxtbKK3Mnaahol6umZqva7/Vpx02uTULg/DgP9rHMxxupNWj9L8qcb6ZG7fgROXNHwux+I7Jsy43nWt0FcLo7zu2JIqSjd9ALLUrLfACYhTJJq+iVyPy3/kGp7MMt0gnyHOj14aQJvxJOZSU1h8Or2pj+IUMCPeNNBW+3ymFVNTVKRtX1ja17wLeJxpOKO3rdZjTPBjFPrkPa5F87XEVxTuh3OjgVoJJQla/uJ7tclc9RXi0LgDbh/1/prQox+S0QizrJNJIr4deIR9f/CVX4Rki7GXB11xBu71pjtBmkTfiIvrW90nMzTq+RtXWSyv6YVEIRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcl6+/xSCFdAETFLs4cM7hbZZ8K2yP29oQeLlsiYPoQ=;
 b=u4QriR3A+55NJr0RV03SYsNY9vz4hmSPiSzHF7QR9kBI4x13acBDBbIXwUKkx5EgGSvfy/bCkPYJLL45N1RkqlLcbS+vhIQrb//icgywD+5oIbF0GqYyUBt7Wz9yrHNt3JqvglhYk1zFlNz77JfnFtmZ8oilqrFdGH9UCfomd6tBPVp36QoEE6bewPfoYjVBcYp8l6I/VP7JICIzx2oVi/HdYl4gKAqVAQoVS9hjgAjTzhb/4vEqTFG1CIWlGVz+6Ip8KxfDojt/cuJOnsI56ACPGTnHKnGEszQsB2UfPggX+YSJo8w83lrtMrhL+2MXc9cU6QAd2dPjiZoGqlWDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcl6+/xSCFdAETFLs4cM7hbZZ8K2yP29oQeLlsiYPoQ=;
 b=Xd6XdDJcdUAxbLz+Itt94vVNg0+UOcl7WOPTJwEt6bmiFjGv8sdaBxOH3bqE6bs8e2Mghvagi4G2iKyZpM9H1YzwSb+mG2UVhg1W6Xh6RcJlxr1ZeF0IZKR1x++pIER/aeJpoXzQUfAOLj4uzuEoC78DJqBr3eUZx76Pp2Bnz+/AvqPKlddIXL6W9JFDCUZGzzf09yzhb+W0DWOTeYKOL674ljLEKoxkm+vjmEiv+lT2u1RKnEFLgORwVKUNN074gKepoDz1ycMojmPCgDslDrtvfEK2vjkVs137uMtVfqWh7yMQFqtyhW4zXMly4cm1UBNroAA/ICrI0vfyOLd0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 2 Oct
 2025 03:35:02 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 03:35:02 +0000
Message-ID: <89d5a73c-2a48-4aec-9249-07c71ca214ec@nvidia.com>
Date: Wed, 1 Oct 2025 20:35:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
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
 <20250910204309.20751-2-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d04b141-2185-48f3-995a-08de0164abb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anJzTm9mdXRja3NQTExOY0FnY2VXOHlvMmtwU0pYd2ZqUkovcDY5WDhQVjBK?=
 =?utf-8?B?bGZwUXR0NGV4UkMvQVhZblowMHRsRFJGSElQREJ4SWZpTHdzT3dXL3RBWFJj?=
 =?utf-8?B?VWt5ZkVkcnBLTUs4ZFBvb0lwV3ZaemZOa0I3THBLWUtyRDhzbEFLMm8vQ01Y?=
 =?utf-8?B?Q1orbGdtY0lQeXRnaWFUcXZwZkIveGpZV3FVYm9GWUhKKysyQ0R1ZkZjWUxq?=
 =?utf-8?B?Y1RhQjB4SU9pSzM1TXpaUTFhUlFOd2lnME8raU0vL2hSK2MwRk9LUDhYOUtW?=
 =?utf-8?B?clduRnNqK1UzWVdweWVpVUVxcDduREFNTFFCdCtkaW9xc2doeU14MlZLMTJV?=
 =?utf-8?B?YmRTM0ZSTm4xTXZ1UmtlendSQzVxK0NIOFpnR2VEeTRwaks3RGdYd3h1QzFN?=
 =?utf-8?B?TDNhZHJoQ0RFdFZlRFpoeTNzNDR2RmZMaE51RmRKS1ZPM08rSzNsaDQ2QnF3?=
 =?utf-8?B?NFFHVDBoN1Qyejc0Q3drTWFTOUM2dHh2OVhucXpNY1RRbGwxYStoSHhURGVG?=
 =?utf-8?B?UU9NanNDKytFb25Jem53KzM4N1dyZGJHZHp3QnM2K255akRZTzlKWHIwNmVz?=
 =?utf-8?B?cnpkbFFCcUJuak5yVnNUODJ5QW1acjdWNHJ5Vnh3K1kyQkRRYnV1OU5TTVJx?=
 =?utf-8?B?dEkyTUFvU2l6cys1b0c3ZjNYRXUyNEE0bmVyZHBNcWJOQlpCaDhvQ1R5SFMx?=
 =?utf-8?B?MEtDMkZodWJaRWpUM1ZaNTZNUk45eUxCemtrRXdWcVk3TGw3UVV2dHQwQ1Nq?=
 =?utf-8?B?OTFXV3VsSU5qUHRpamt5YXUzRVM4Z3dOT3ZVem5NNzRsOTNDcWNndW1EQ3FI?=
 =?utf-8?B?UmlpMk5pVGpKYUdtenR2NW5VZTdUSk56L0pBSWZ1SFlNZ24zNkNKK1lvWFNX?=
 =?utf-8?B?TkN6Z0JNd0RoU1JUTGszcXl4cnp3bnQ1eTFuOVI5N3NuUStUbEtaKzBsSWZj?=
 =?utf-8?B?VlhHNWJSTmNpcE9HQUhEcXl5NkRQQ3BYVkdrWmdvVUttYmgzai9hMG9xdU1w?=
 =?utf-8?B?d3RlNGcrc1p4M1c2RStLb3JFVkFkZU9MQksxMTRCbXhPMjBabGZVWkNmbEY2?=
 =?utf-8?B?TjNuMUI4ZlNJamhrZ0FWdERaK25mcy8reTNBdjZqSjdzN1hmSStEYTlDT2Iy?=
 =?utf-8?B?aDVoVnQwOTFrREExQW05VGo0bzZmaDlKQ3h1dGpQM3pqNDBWdWVqL1IyNkFj?=
 =?utf-8?B?U0ZQa1ZjVmF5MGVZalQ3eDdZQVREVDR3T1l1aGRkWGY4bTdIT2tkeVBvTmsx?=
 =?utf-8?B?N1lZa2JWVmE3TVNsemtTSWlVUXcrT0dpV2VDVWlXUnVZSzA4YVVwOEJaZStD?=
 =?utf-8?B?MlVPTkRUODVxMDlianF6MnZuTDVzMmcycmZWdzU1cVdaUThOM2x0YlBmaFlp?=
 =?utf-8?B?S0ZzRE5ZaGdoQ3dXd05nUDVsRm5vT3cyRXl5dkJES1B0YkI3U0dQYTdabS9a?=
 =?utf-8?B?VVkveTlOeXpxcGRsZDdoK3dvaS80aDBiMjBaZ09TelNSMGdjeVBpTllxM3A0?=
 =?utf-8?B?ZVFtVFRRWFRCZHNlZEVuTkExenJQTmxKN1F4M21DSDh6UXFLUHgzTndjQmd0?=
 =?utf-8?B?T0I5MDF6MlRScFhFQVp1aldSRDR2MWd1YzVFVU5jMEtZV2JJS21PUlZjUS9S?=
 =?utf-8?B?dUN6NUJQMkpMc0tmYTRqMFdYa2pZR1BqbXBqbXZUOURTdDhmcWJqWGxMSitl?=
 =?utf-8?B?Q3NTSjZPeHlZU1pwZjRlemNXS2trbzNndjJJSGtaclJlcTdaUHo0SXF1SWZy?=
 =?utf-8?B?dDdnMktrbzdFRU1GLys4YjZHWDNmYzN2MldETk9XTU1zTWw5Z2NoL3lUSzNt?=
 =?utf-8?B?VUlseGVzVEgwdGNYSXRST1VVck5IOWIrN29RUkYvek9vbVRabW83bWFteG5V?=
 =?utf-8?B?TjZhM21QaTQ1ZkpNSkRyZFppT0hUMFcwVVMxTzVXME5XRVFrQS9zU2NxQmNa?=
 =?utf-8?Q?319b7fSvsZ+YXojmeYQhSVCpX+VPpCyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHlMTmdKbkdYaG82Z2V6M3V0UEkvUGowTDhHeWVBb3NQRVFzUHJhVVRXTERs?=
 =?utf-8?B?ZE5POGozS3NtVTQxVnlxWGZoUjloamduNk55b2lBYmlSLzhid3ZVZW95dnFa?=
 =?utf-8?B?Rkd5QnRVck1xaEpNUmN4VTZpamdGSURIaWZzeGZ5VldxK3dSbURDa0gxRW9o?=
 =?utf-8?B?T01mNUYyRTBIOHZqdDBPNlVpSUlUOE1hV20vbThSUGFpSmNFdFV0NzJ2R0du?=
 =?utf-8?B?Z0wvV2lTdmdiMGxsTFFtN0RjRHNYNVJhcGVSL1RGTXlsUDl3Ry9VTThnZG1Y?=
 =?utf-8?B?RjJSR05id1dnM0xNbGF0MC9ha1MzWVZXYTloNVUzWjlteVUxWklVTTFYR3RT?=
 =?utf-8?B?cjc1L3RvS1FqTklkV0h3MkRWZjhjc29DVk43UVFWaEJwNE56MU9NaHZ5RTNX?=
 =?utf-8?B?Ly9lbXBZT3J2dFZMN1l1MGVuV3F2aDJkckpSdzhXeGdVU3Z3NmcxSUwrL1FM?=
 =?utf-8?B?N2tpQlRRTFQ5YUxGU2EyOG1saFBsdTBJVFJYNXF0UGx3bkExaTR1S2JtSFJP?=
 =?utf-8?B?TUN1b0pjSTZmOGRPVExKM2w1bHMwTVlSVlNGeVBnM1BjQkNtazBFWlI0NkM4?=
 =?utf-8?B?dXp1RXAveXMzYVd4b01CQTh5UmhIYVBaZlAyaFVtUy9iQWpYR0xJRXNpSnVs?=
 =?utf-8?B?VWJBSTJEM2F4SlNyWStNd0hyaFk2WGVSeXB1VVJvKzhOTDliWWZDdCs0VDhT?=
 =?utf-8?B?UVFNVTVMcE5GUExhV0M0NncrZ1NjZGdhUUZpZ2ZJRVNWckV5YWQyUW1IdXVO?=
 =?utf-8?B?TmNCMG51Q0ZVL2FFL2ZMdkFkUnZKbmVzanJML3ptZnJtK3VnSks4SkhhWEp0?=
 =?utf-8?B?dHpxOXB4aWs4SXRCVG5vdzdlWjRNWmY4MzhLR2locHF6WXJkM21heXArNW5l?=
 =?utf-8?B?Z3BNNmVPRXJXRmQ5S1dqdmR4cCtGYkcwZDlRTmxBOGEyd3IwSWpVSmNrcFUr?=
 =?utf-8?B?RXpoUHhKT0x0a04wNVBTb2FqZ0NKVXRCb3ZSZGhVNUdFY2tBeVJqKzRVbE1o?=
 =?utf-8?B?cnR0MlB4SysyRGJpc1pQYWkyQ05ncks1QlQwN1hpYXdROWwrV0RnTVlCdUVy?=
 =?utf-8?B?S2J2OFRsS285eEM0SE82cXJVYjAwNVVzK3BHMGkxSExHNmpzRk04KzlJOUlG?=
 =?utf-8?B?aHdHc25KT2ROeFZQa3oyY0RLR2xaQXVtdGlLS2xtQTMrWWo2T2UrY3JuSmJX?=
 =?utf-8?B?cnBzQkpscnNpWkgxSVBmU21hUHZySmVNQ3BUUjd0YVVwamR5bExvU3ZHWXBD?=
 =?utf-8?B?b1BpQWEzaFZBSGdIaXJpQXdJNUZLczZFSnp6dlE1SHFKejRZbVFFN1RPUFlX?=
 =?utf-8?B?YkttTTRGUTNqMEhpYVA3YUVDMGlRZ0p2TXFOTmZ3UDdyMi9QSm81L2JCRDdI?=
 =?utf-8?B?WFZDeUFxMGRudzRVMlVFNUxNdzVtVDNFMzJtUUZDWnJ2L2NUbDE2eFNvVVpv?=
 =?utf-8?B?eXZYaEUyTWlWZUp2cjlsaXJtVTgzTVRKT2RkWnJKMThBNW92dTdUaXdSK3RX?=
 =?utf-8?B?MEJYc2ZmYmV1ajFieit4NmdDSy9hemt5VTVVSVRRWTFJUE5udU1Xa0tYcVM1?=
 =?utf-8?B?WWhROTZlRWRneE9ocFVrSnF0MFl6SDhLT0M2bXkyRDFmMmMrdmR1M2hUakZz?=
 =?utf-8?B?ZnlFQThMNW14UTFzc3hvNFZIZU9aN0ZFa1NrZHI1Q0VmZUlaaXptc1RZZSs4?=
 =?utf-8?B?Y0xpRjhEc0p4VXpHd2FaWWpXYlRia2xCZ1BNNjE1c3dwN2Z0d3hzWTVQTk1E?=
 =?utf-8?B?U1JJaWVLamR6WUNtU0UzaXdGMDFpck5EY3NZSHFpdGtwTkVTNWxrSmMyZ29J?=
 =?utf-8?B?U1JuMSt0bGp2RkswMFhUQXBCT3ZKaEx5TzdMeW9OV09VQTk3VDVxd0tCdFFM?=
 =?utf-8?B?YnBjc282U0tOd3k1dFJYTzJMaTdKci9WdlZmazlTZ1JrK25oQTU0bmpkWTRa?=
 =?utf-8?B?cEduSGc1QWRtaTZJYldlOEQ3bnNWbFlDVnZhZjVvbitOWUsvbE5vdGxCakNT?=
 =?utf-8?B?eHhsai8wTWwrTHhqWER0NHVtMlhMQWxlVmJwRElSY2hVNFlaeTRMYkpuQlFw?=
 =?utf-8?B?b2dhZ0c5dThMcTk3WTdQa0hWa0xuVjB5aW9JTjNiYTB6b29VMlExU1d5RDV2?=
 =?utf-8?Q?WBHBdT0LSDJriM9glKeK4I6s5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d04b141-2185-48f3-995a-08de0164abb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 03:35:02.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8VhpzoB0evtd0mIaxWiZLFAcSzsEenEMFhSw/rxJqKL3ei2lzu9dFh7DLp0mDHrZDHPOtHoqXTJTpHHF0AyDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1


On 9/10/25 13:42, James Morse wrote:
> The ACPI MPAM table uses the UID of a processor container specified in
> the PPTT to indicate the subset of CPUs and cache topology that can
> access each MPAM System Component (MSC).
>
> This information is not directly useful to the kernel. The equivalent
> cpumask is needed instead.
>
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.
>
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


