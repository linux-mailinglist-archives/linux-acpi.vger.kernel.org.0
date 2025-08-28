Return-Path: <linux-acpi+bounces-16126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0331B3910D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560B1170E61
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F711F4C8B;
	Thu, 28 Aug 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDPYho6p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C81A9F9D;
	Thu, 28 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344574; cv=fail; b=AB5Q1DBUcJeD7LOv6E3E9/sqaiVJuXwF/NHenxKhHRcS6B+TH0d0X8gToKt1nuLiXGGDNMb51QlNb+9QYa5ja8P18SBTZhRPGsI5n3Zviec1Z/AS32UXPCo6bWrTZytck5AuZRwqMAUdK0/rY3nkilRaHwlPXfgFxdNzVmCZ6Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344574; c=relaxed/simple;
	bh=55ygsZ0IoZzwevp7XuopVg7R/dQ0btRS7/815BUo3mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf20lSAPxLK2xioDEiQLeUkPIBEj5m4GmMR4upgoTTBE4Uq3ucr14Jbw2hyQKHrT9E6Q0zWspGpJ6beH7L2KxPM63NP3tcwEGybEo2ipO8mmYDPaGa//DSl8tndML/APhStCn+dPBLpMmyz57qGS74NqIeOrhJJgrWro4kFY4ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDPYho6p; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIO8ApGuHgFMGCEsZV1MSXn5ltw2zH/nDD0DtbJAfJ3giDKKaIUqfmIMFZkmuwM67kFmrbznaMCybmfj53LRCn894e1LdBZ/GWX7XfUDqy8TtKPGF20NB+Xt7RP5SEx98FtpC9VdYA6SIsAc0CAZKLN4kDVxq8/lhMbFY0uxnzLqGH23FlqD+ysv2FVnfKp3Ct5Wv3wKCFf5kTL82/6Npv3Wh45jR92n2q86KnI4Rz74nF5g9NH6AT2pAk51YTKIpsOiu7qx+uTInHlPIRwj+/Y1eVHPu1M24LX7WVIbmfObwEHYifB5bW/+HFAIWuSRTg+I7dhnnxs7VyuJeEbHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTQ7THQjyQhdT1x2atSwGn0BJsnl/9eO4Lu/2aulbEc=;
 b=uvfBpCHbrCfhw40NSXHjdHqPBZ16tw1tdI3/RLKtrA2PR0C4KoDGZf32x6VeN7Clisdp6fOT44vheBBWUmIAOpKK3OZwL/4HLWaWpHLMNkf6VCGbGT0HfJ5AvJ5Cx3xlZcHItadhKVl7d4NdOxbGSpVlm9k8smc1oySE454CbAYwEPFtP24RV8WeH2EI2LxkfZvEgQS/V4XL1h7ycJNaKmDAnJtYSkGlEN17ieR+NKEQdHp2lwJRe/Ptx3cjHC9jtyZpZtHB1aXHcrp6fk6u/ONLVXSazYRDgSIjZVfo+qTcsJ4YJiICDTRKPvaCdi/cogaFaDmbkqgvBgon5+iOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTQ7THQjyQhdT1x2atSwGn0BJsnl/9eO4Lu/2aulbEc=;
 b=EDPYho6pfroBSX6Qj0gUP8YVaoKZ75m4gd4NA+CxlFeC0cdT7sKduQDTgSKcsFWIR2jgzW70kJMgJRj3ft8RsfHFrqFesnH/QMg7A+gB1aEGZo+mRY4BlmbZSWIxy4zPSbvmdTeq3p6ac5phdqno7pZorB6VrGP6STOPfUYX2QuI6vOmhMP3iQU3ZJCl1nwmuUGLSEkeGWdxkFtHO8D/NCmvqJrNuumwB2Lp8OTG98YheBc4wr0NkGIXNL6euyKeY6QvnD99D9r4wXPvb400srd6aPplGtjxDSnX7/ZF2rfEbGurxcpLJnKkmfl+LAne5iLsKJx1/foKo1Brx+oM0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 01:29:26 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%3]) with mapi id 15.20.8989.017; Thu, 28 Aug 2025
 01:29:26 +0000
Message-ID: <5f2c1bf5-6486-464b-aade-4f55b4c3af9f@nvidia.com>
Date: Wed, 27 Aug 2025 18:29:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-13-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250822153048.2287-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0168.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bed6b8-4e99-434b-3ba9-08dde5d2538d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGxTQnQ4elIrVThLOERQaVpFN1BETG9qbThnT01mOTBTRkxqK1lFbWx3eExW?=
 =?utf-8?B?L3BLZHJWc0JTN05BbG9UM1NML2Y1dktXZTVxdDNsWVJhZDlUSGdQZ1dpNVZh?=
 =?utf-8?B?UDJYNUFCS3NxYXB6Q21ScUU0TmxGSnJJeHBVM0lzaitXU1dFQjRVRGc4S1h0?=
 =?utf-8?B?QXEzVE1HY2FkbFNkRERQeWJWazBSTC9odXhPOTVTb3IzeXlLRUpCU3J6TGhP?=
 =?utf-8?B?UmsyWWViU2JPTVpPYWd4KzRkZlZWcXprQ3hTbnBESkhmeE14Y2NlMmdZeEpL?=
 =?utf-8?B?VEV3T1hlL3l2UDA1THM4SDdWYTZLMjZCbCtxUlV2NlM3S3I0M0djNjFXL0Nx?=
 =?utf-8?B?L1YwUzBQazBBNGlGdjc2cFlxWGtrWS9EdHBUZDJ2Z0hucjMzb2JtM2xmOGlr?=
 =?utf-8?B?dkNMZG11VW5GQ2g2UDlIQ3hTT1VFcXRYVjhwNHZ4OXljSUsvVEZQeGJ5KzV4?=
 =?utf-8?B?YndFa2Nnd3J4TVZISkZIVVp4TURmR1d0V3hQWlNRM1UwdTNsOWJTR0tmTWhS?=
 =?utf-8?B?Q0wwMmh3czY4ejdlRXhCVzVaWFMwenhpUDI0RzlyaVYvN0NzcXhYeXkrZDRk?=
 =?utf-8?B?dWNUN0ZTL3FBd0xSbGJTbzZiT0pCV1N6bFduOXBpMTBTQWdpMXVaeE1SVk9m?=
 =?utf-8?B?UmxJUDljeHgvQUhJZi95Zk1WRTJrbmtuNzRMR0xIaitsMDVNeWlMNXVXazc0?=
 =?utf-8?B?YjFSakZaRXBndGFCMW01ODFmUHVUdEhma055dHpFczBlT0hrZWV2TUNLRHdw?=
 =?utf-8?B?WVJmS2Q4Y0wyMk44MEdQUHFPUVRKeGFwSUVYQVQ3bmU4QzhNVmdhOGlmS2Vr?=
 =?utf-8?B?dEx0VVFFaE1FWjV1bmZlUUNRS0UyRGJLU1dTV1dWTTM2TlF3eGoyS2hhU2J3?=
 =?utf-8?B?VE02T3hxb1ZIbCtNOVVpTkRoY0p1bnprdjEwaDRIZmNGQ09QSFVJVFNGT2sv?=
 =?utf-8?B?dGtkRjJyb2FpMCsvY1pqK1JxaVJzeG9sUS9HcHRmT2RjdnR5UmtpTE9wK2JT?=
 =?utf-8?B?WmVNNHpSR0xpRmZtRnBGWnE2amU1azhYVGJZcExBTmZaSy8zSHgzSTc5Tjdn?=
 =?utf-8?B?NUtFZVh5c25zSmxzbGFFSG55cm00RjA5NkR2QUZtZDBFWW1WMEltbWpYanA1?=
 =?utf-8?B?MkxKbzZ2RjJFcWFHUWZKSW1WUW9YQzVqdjdwbXl2V24rb3FnSUR4VkhETlpP?=
 =?utf-8?B?M0xyT3AwY0ljRzJIU1NjUTlTTGQrUU1FT09kNW9rZHhXd2xwcGNmcmdibUsv?=
 =?utf-8?B?NlRjNlB1dHJMRVBDK1lIeGY3M01tNkZkcXlacDk2NldBc1NBYk42U2ZGbE5w?=
 =?utf-8?B?WURjTDBINHlVaEYzeVhqSXZYcWJLKytSSTYyWFJXQ2o1aktSTnp3bmtGYTBZ?=
 =?utf-8?B?T21Bb2FrTC9WangySUhORmZ2ZW42dHRMN2REK3VjcmxhUDFqbVMwUndPclhx?=
 =?utf-8?B?Z2FjUitrVHBIamo3SWNjRnRjaldqMXFaVk9SYmVBSjVHY241Wk90UFdJQm4y?=
 =?utf-8?B?UXU4ZVh4NjN1Y1dRVmtiTHBQTktZRWJqdkpKTEc5eXcvZGkvUUQyUzF5bE1X?=
 =?utf-8?B?NmxieG1SR0x4Q1hWa3c5Z1ZlQS9oWk01UC9reTJocnF0RG5UVHphblF0YWxL?=
 =?utf-8?B?ZDNpTTZPbjF4ZWJFL1FNK2RnaCtZQTJrMDlKR044bGIydmVzOTdhZGRKdld2?=
 =?utf-8?B?WnFNOU9TbWM0ZmhQZGJwSlprZ3UzU0RuQ1dxMjFiU0piYm9IdmQyUFF6Q2Ny?=
 =?utf-8?B?dDV6Njd6QUw4NEVva3FVK3FxT0xOcG93NG04c3ZtMDFNWmVXRTB4MVpDUTB1?=
 =?utf-8?B?ZVZ3RmZLb2o1Q0JHTGkwOGIyRWtTczdKQVN4YjU5UUFCZTl3TWxqQ3NLNERU?=
 =?utf-8?B?YmFrek4wRkJlRSsvV1dDNUNUK0haeXltZ0FMOGp2WU55RXhkV2NJZTlMdkRp?=
 =?utf-8?Q?zrLfRu+X/g4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZabzEvTElMcU5xZmswQ3R4WFMwNHhMUmM4Y1ZwemY4Ujlaa3duTTFoMWdO?=
 =?utf-8?B?UTlBUUpuL2srWmFYZE9RbjBsd2UvM3V6VU8vM1d6bjAzSTQxOERNTDVpNTB3?=
 =?utf-8?B?bDh1cXFNTHdCZitGbGk4QXZ3ZmxaUmNxZ3cxMlVIeUlPYkUvajRianBvY0Vx?=
 =?utf-8?B?bVZwZHE4c1Z4MWZUQ3JWSGlaNEpHa1VQWUp6SDNkZlUzSW16U1NqcHcvVll6?=
 =?utf-8?B?V2RMRTdqa0dDbDIrTVMrM29jQTlieDJ5WGE5M1ErZTh4ZmRvZzZodU5pcmNO?=
 =?utf-8?B?SS9xaW9KcVdnSXhtdGJBRzBva2I2bVNrS2ZIVVFJVm1DU3EzM3A1R2xicWpF?=
 =?utf-8?B?Q25RVXlkU0taZUdISlNEUFM2NEF0NXZ6NmxmMkUreHIyelVldFlUNS9ORjFa?=
 =?utf-8?B?QlRlNDZvVmdENVE1VkZ3VG4rNGVvUFdkS3NESHdBaEw2ZEY1WXNYRlJVcU5Q?=
 =?utf-8?B?WGpyTTNJYmxPNEtHYnJmWGtEcll1ZTBVV1pHdXpEWDh1dU1NUVBiVjJuUWky?=
 =?utf-8?B?TDlyOVhhQ3FrcDNRT2NTSE9qQjRBTUYydjlRYjFqWk9JTXJER1lDUGwvL3Br?=
 =?utf-8?B?SkZocEdEdTY0c2QrdHZKVERwQXhpV2lFUXpkTjYraDVHR1JjZ3VtczkyNkts?=
 =?utf-8?B?MElDK2hqYmxnT2g3b0R6R2FGajdlM1IxakEyUWxWbm9RS2JHMnlCNUV2Wlc1?=
 =?utf-8?B?UnNCanJ3Q1FUZzZyWHVnWVEwb3ZZalBWaFJmK2lKV3VOdUxhOVc4SWdMUm9F?=
 =?utf-8?B?NnZOTFlQRll2U1ZlL2RaU3d1ODdMeFJqaHpPYytBcGxRKzNIUHdDem1GaTFM?=
 =?utf-8?B?OGNsb1pKT1lIYjdRamEwaThNUWdIeDZ3YXZycWg1akd0WW03UDVSczJhNm9I?=
 =?utf-8?B?R1Fsa1FFdjNSRTR4Rk9FTm0rRTV5dW95bFBvWkx1T0MyME43VVpyMi9oRURu?=
 =?utf-8?B?eVNySG45KzJOcUR6M2tmUjV5OWRqUWM5OFNrV2FSR2FFeTNUb0xZdG9RVGpu?=
 =?utf-8?B?eXBzSHI5NHFOMUNXVmdsMUNUMlMvb0VncDlZamR4SHB5NzVjWlNGbXk2TWQy?=
 =?utf-8?B?VTE1emU2RFUxMXlvcEV3NGdJZ29aclZZUnFMWHVLa2xPdytYQzROVzd3MzVK?=
 =?utf-8?B?SzNPR1FOSkVwMWpwQlpxOU52UldyYkJ0ZXhDbDRIaWhhUFIvVzViM1B4b2h0?=
 =?utf-8?B?TFh5d0ZGYnVoRjZHeUNYb0lNQURmMUNNVGpuUGw0THAzQ3Z0Nm5IeXpHOXhO?=
 =?utf-8?B?YklzVUIxSmlOTXlhM3RIdXRIM245QWJYbVdUTVJSRUJSclN0clBEQXVYMG5W?=
 =?utf-8?B?bC92bm1tQUZ6RXVNY0J2RWhGcjQyOGJUN0dzOE9sN0V4L1owOXl2ZEpoQU00?=
 =?utf-8?B?d01CT29xNVZWZnkvNjJRL1pFRjkzZmRUZGdBaXRTSW1QZDJvcnpWZnhqeHI2?=
 =?utf-8?B?dW8zNU16Y2Q2Y21CN3BTRnJVNTBrZWhTVHEyb3ltMTlXYUUrb0VjVG1NNjIw?=
 =?utf-8?B?c094UXM5ODE4MStGR2gyaWpVaFJrSmoxWDNrek0rVWIxaVFDWWZTS2JidGda?=
 =?utf-8?B?bXVHdkVTaElpSnZoT3hlbFB0Q3NKRk5MRmdsSTV2c0dhM3l1QXh4NFR0Rzd2?=
 =?utf-8?B?eG5WWVNadFFnWEdvSWt5MXl5Q25UdW03VldQbnBtRzExOGRlbDhhZW9oV29F?=
 =?utf-8?B?NGNSdHRwYkxrTmN5M2w0UEo5MTBoRUM1djJrMUtTbmJxVnJZSUlJWnpvSndF?=
 =?utf-8?B?Y3lBWDkxOUoxZ0l0c3RHeFFjOHhmR2ZoTGJHR1ZOM3kzNlhrSzI2U20rcG8y?=
 =?utf-8?B?UU9BNGxLbCt6MS9XM3F4UzYrdzkwZS8yQSsweTFyWGJQUGl1ajFjUGh1UWV1?=
 =?utf-8?B?WVRtWTJ2TEM0K0JSOG55NUtISVFlbndFMHB0MkxyVTNyUkdxUDhCNldoQzJL?=
 =?utf-8?B?Y3NlOG1oYjFCbmdkeFZCK3pyS0djZEpvRkhxK3hzQTZWSGdyb3hXY0lWODBz?=
 =?utf-8?B?QWhvUWlOZUVqRnpUTFNVTS82clpNc1k2N1g0SlBNZC9vdndVOGFWOGNaRzVV?=
 =?utf-8?B?RzMwRlQ2SExmYnZDSXptbklNc1hOcmExL25vSmc4cUdvWWN4em1nZTNiOFcx?=
 =?utf-8?Q?2K+VGsMXDP2KcFTRPDkUcfWe1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bed6b8-4e99-434b-3ba9-08dde5d2538d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 01:29:26.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlJd2dOdH7Ogl3+ou9ggjcTZGC62x4lDWm70lt2kJTsQrh6gcrVgXAPYQ+Uip0Ap3FRhhr5vYKZKsQfFGmh4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

Hi, James,

On 8/22/25 08:29, James Morse wrote:
> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the system.
> Others are discovered when the driver probes the hardware.
>
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which
> are visible to user-space as there are likely to be multiple instances
> of the L2 cache. (e.g. one per cluster or package)
>
> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
> This is to allow hardware implementations where two controls are presented
> as different RIS. Re-combining these RIS allows their feature bits to
> be or-ed. This structure is not visible outside mpam_devices.c
>
> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
> visible as each L2 cache may be composed of individual slices which need
> to be configured the same as the hardware is not able to distribute the
> configuration.
>
> Add support for creating and destroying these structures.
>
> A gfp is passed as the structures may need creating when a new RIS entry
> is discovered when probing the MSC.
>
> CC: Ben Horgan <ben.horgan@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>   * removed a pr_err() debug message that crept in.
> ---
>   drivers/resctrl/mpam_devices.c  | 488 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  91 ++++++
>   include/linux/arm_mpam.h        |   8 +-
>   3 files changed, 574 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 71a1fb1a9c75..5baf2a8786fb 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
[SNIP]
> +static struct mpam_vmsc *
> +mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc, gfp_t gfp)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	vmsc = kzalloc(sizeof(*vmsc), gfp);
> +	if (!comp)

s/if (!cmp)/if (!vmsc)/


> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(vmsc);
> +
> +	INIT_LIST_HEAD_RCU(&vmsc->ris);
> +	INIT_LIST_HEAD_RCU(&vmsc->comp_list);
> +	vmsc->comp = comp;
> +	vmsc->msc = msc;
> +
> +	list_add_rcu(&vmsc->comp_list, &comp->vmsc);
> +
> +	return vmsc;
> +}

Thanks.

-Fenghua


