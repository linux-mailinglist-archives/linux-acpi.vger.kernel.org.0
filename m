Return-Path: <linux-acpi+bounces-20868-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBhWKNvthGkU6wMAu9opvQ
	(envelope-from <linux-acpi+bounces-20868-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:22:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AEFF6C98
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EFE73004DF1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79932694C;
	Thu,  5 Feb 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nytyJqRl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83970325735;
	Thu,  5 Feb 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319318; cv=fail; b=TdVnzgJi4BXjdoXoUqIWmvoebKJAoFBS+B//uAzQN8W7xBpX3LLCL4S/ODXmNUvvJqg/b2xjpofvrhRFOclSsIF/k5YBYYu+AksLKNNBLxcGoh9OXqzc9wpj/+tzLvhx4EONSrWxC4H7ZNtzoCDM5ylCjCB2waTdu6WtRSCFk3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319318; c=relaxed/simple;
	bh=x3dE5FOxKhfGCE9ntPwbaR1+gMQA8uIEksGpgyvkbM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KmGDZX/61Ro6wG7aMZdaLgcSv+3DVS4bGD76xX4F5GsnkkX5ZeEV13hsMIC3sfCwpU2CCrlou4UwfYetX2BlFKqm0AE2GtSbEQ27vbjQ0igg3fd/tChVwiYt6yeLtgc8dd7wFHEjqFfQ8lJQ98yBfVIquOzbeIP/cQrGO4rPiyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nytyJqRl; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNq5wFoihX6TEfb/KWrWhc/qIQrADDIcUqShe8meZZPVXSz8BomH0z6nZo3H+GVYSowj/E2/IVUJ8IAY8EfT1Ldy7yKiJO+oZ0pJONhB1aLwRLCDeXcnD8RQC4nRoRt/L5BqMMJ2440ikvaRrcwjjGeoqdMFW72Qe4jh9io9gC3UUhzWSLkkuO4ET8rVoIldCmrPee5VXOY8xXSm7CCm3qV+BktqQfii7fO4aq7y9oTXQb98gO+xyixZdv/JzlojqyHbt1SSjfgGznvFayLcLHknfc/ZQZFFaZTrbomAN1QD7c+QckQbTD0Vb27X+gfa4x9hUrfUcam/y+xgzHoBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjEYlgk2pPg+xaWMcNln0yU2Aa/TZ2jlwbSwTm87WKA=;
 b=ZEetN3HwxUluOlDMBvG2qxhENNgjt57nI6NiYtQ+m7BDPv0TyRRcVoUewOyK7kkgVCfgVzCNyuDJVQVzjCzaOhzTqs+leKkA1TQluhysAKQR49dzxxk84ii9r5zFuk18rzbVa3knA7M3LHh3234FYVkeJMC3gVX5PfZ1RFIc369LLQ/1Jpwu13S/QLWu8VhWGzyaB3GlUgRQwn/YYnYf8ql/quDhXTYFbJFfX3iWWizvLaZ0/frXGhwqd5kk3iDwGT/xVD5KhrnnhEWzPb5c7XfnA+KkYUwQ5x4dHRAm0C0qf5JI+ZUG5tfbxDLcU1ZrUMdtchsaku4OjRVOpXyQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjEYlgk2pPg+xaWMcNln0yU2Aa/TZ2jlwbSwTm87WKA=;
 b=nytyJqRlKnGhmLiAeJs7BpO5ummctaeUymWPFQz1Ye9laDlS9U0DrwIYT3dtS+ua8l9R0ZuTx94HZTf+dkYFo+S4E4oJsW7EWPBp01K9DbWaQ8nA8nDgvtYWyOWtDyb1oR7jIk+qspxtg0XjOKWwyqqSBYYjrdLpSLNgj9ErpnTwFw5P4bbjUjgO+60uAPH+QeNai5rIC4iJndBRv5MgGOa+60RQGbstyqAwilzjOt2mahYEuQN4fmF7U5mnV0ljuGtVqeglC57pS4tK4rGCkdpCbI6PlbFEMLN9+I5m0kJHFkGKJdns37hMbQQSOU/AS5jqjZDArZ2kUD+mbmZDSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 19:21:53 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 19:21:53 +0000
Message-ID: <a1cdc4ee-1aaa-4685-b1a9-a6961a486cd8@nvidia.com>
Date: Fri, 6 Feb 2026 00:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Russell Haley <yumpusamongus@gmail.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
 <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
 <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
 <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
 <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
 <e7570bc3-5420-4743-8a75-8602559ca235@amd.com>
 <b8603fcb-b0ab-47da-ae90-e82f7b9bcd67@nvidia.com>
 <CAJZ5v0h4yOAW5y-B76EooeBLdMBmmL1hRf3PZ0udA+FYR4EPKQ@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0h4yOAW5y-B76EooeBLdMBmmL1hRf3PZ0udA+FYR4EPKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::18) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a42b6a1-5d53-42ee-7628-08de64ebd11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTc5NnJjRUVPQy9sZEpGek5ZRGIzS1VSeVJxeFNUSjBGMkpVWkZuRnFJNGdO?=
 =?utf-8?B?TlRQVzRwYk1wbHV4aFZLcHVQU2FIcGh3Yk4xOEwrM1l1cnQrRmd1VEJXNTR0?=
 =?utf-8?B?Q3psYkFBYUdVQmwvam94dExWQ3RNczlZYkRkMFhiRm4wb1F5T255WmtuUmZ2?=
 =?utf-8?B?Y2NXNVJVUWpnYmdQYURTMHBSeEVHcTUweDZkejVxL2pLaU9ZdUoxTTVrZUpL?=
 =?utf-8?B?SjB0aGhsYStuZTI4dDNIeE8vUGN6VGJQMlpSZ0JJRkVLQ3hSNzFWVlRndUZs?=
 =?utf-8?B?QWtEaERzb29KWm9YVjBXUXkwcUlVK0VnMWVOQVM2MGY3NUJaeVh4WjJtRFVD?=
 =?utf-8?B?VENXc2tySlpEamVhZ0VieFhpbnVGWjlwZzNDcEwxZ1l6VFprVC8rcjFodUZ0?=
 =?utf-8?B?ZDBIV0diWnJ0UDRFcHdmMDc1MnlYTElqNTBKZGFqS1h3VkoxVGwxQzJPUXpR?=
 =?utf-8?B?WTY1VjNKZkRpSEhxTXczZU55NWNQZWVPM2JLMURWS0NtMFVCdk1qdjFTZUJE?=
 =?utf-8?B?TWNKdXdGb1lCRU1TNFhlQ2NPc3FIVXE1TkVia002Tmt5cU9mZUdNWFlPSld1?=
 =?utf-8?B?Wk5qaHhBWVhNVTRKMGJ3clpGWmx0Ky9ib0dMWDJLWThFc3QvbDMya0loQ2JN?=
 =?utf-8?B?OVlLK2pyelRLaTJlOEhua3p6R213ZzMwRGVlYjVVaTY1Z0JjQWRGZFNNZEVP?=
 =?utf-8?B?elM5MU5qSENqWEN6YkIwTXBwSnVRaUNzeGZ5MmptSjR5ekU3RlVuSFZrYmpZ?=
 =?utf-8?B?L251d2ZwUnZ4K2k5RGZ5VmxNZmFETXJiem5ZVVVFa2Q4cXJVcm1BREVRMGQ1?=
 =?utf-8?B?Wk5NVTZjekthVTNyMUoxUGJJSVh3U2NjOVI2SitBV3ZSbE9yOHdMWmU0NkRJ?=
 =?utf-8?B?SzgwOUhVNFdVY0hkS2ExaFBDeWR3VUJtQ0pTQUtKWmt6UHpnY1JhRFZmV0VD?=
 =?utf-8?B?N1grVzRESlE5cU9wQktkR2tGVTJGVVFJNnlTT0RXUlpUcERUYS9tMU90N29s?=
 =?utf-8?B?Z1VIbGdnYU1YaUk2bzhXdmRGcThxY0RrWU83OHRRUm8zaHV6bFAxdmc1VW1E?=
 =?utf-8?B?UEVKQjBwTG5uN0dtc2FPM1AvVnQySUNldHJ5ak1wamMyRVpGN3J6NkxFRzFG?=
 =?utf-8?B?NXNWcExoOVM2K3dQTjZJY0pJOXNyRUs0ODY3cUhSWHJFQlJtTE5NZVFCWWJU?=
 =?utf-8?B?Zzg3N0w2NjhyUjZ0YUFhRHhPdzFSdkdjalNlUlhaYzdtTTV5ckl0REVBV3FN?=
 =?utf-8?B?NFhrazY3d0kzMzdTWW9SNXpTZHlQWGJWWjUwZEhqMk5scHBQeUlRWDhHY0R4?=
 =?utf-8?B?Z0JFc1Z3UTBtNVdWOXN6Nm9WQlJKWThpSkVPS3k5ai9TaVF0a2IyV2FQVm1D?=
 =?utf-8?B?N0hTUHUzaFltbjh0T1N3ZWhFWWpmWlQ0WHRYSFVYcTJwSjdWRXhpdkRsOFJN?=
 =?utf-8?B?TXpNeXlUS3N1aWZOdGpKVXVobHBsbnB3R0UzVmdMY2YybUhaTTlwQ0c3UFo5?=
 =?utf-8?B?MFE4eThZMlR5UjltaE5qeU9YZzNYUzdwS2daQjBScWJzZTR4VGVOeDZRTHcx?=
 =?utf-8?B?OG9MMTNCVGU1VGpKajFUd2FBQy8vdGduUzRqYUM1UEgrZENxL2d3d2RJREY0?=
 =?utf-8?B?MzJHUWJlazdkVWNJOVYrSFdmbFhXL2NCTjl4Y0JMUExheDB1KzA2UE1NTHhH?=
 =?utf-8?B?bDY5dUl4dnBTREZRS0ZqSnJUTWVBU3YyTXBva0VNb1RRSThGbWp6cmRtVlVo?=
 =?utf-8?B?TmdnTTN6cW53a3AxL0VKOHI0VlZFVzZxQ2hIOFJKYmZUWkhVcHZJQjJ2UGNo?=
 =?utf-8?B?cFArYlhBSzlPaWUzd01KcWNPa2RCZWFxYkJRb2dZOGE2Vnp5NVl2OWxIUzZU?=
 =?utf-8?B?alBML0VlSWQ4eXhGd1IzRTd2YVRwR1VmUjNscjlzaDlnMTUrMUt2dUdIb2oy?=
 =?utf-8?B?Q0Q1N29DVFlWWTQxVzhXVVQ3WnFjT3lEdk4zRWM1aFIvWEpsVHBzYkJPUis3?=
 =?utf-8?B?bzVoUmRTS040UlJoZkt4Y2V5STkrdEoxT3hLUWpKOWVUUDZUbjRhM1JtYlBN?=
 =?utf-8?B?MlRZNkE2L3NkczdTMVdwUTkrNzJVR3A4QnRJVU54U0NFcjBrSkRNZlZJS1hJ?=
 =?utf-8?Q?zklg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFc5dEZyblhCR1Z0eElOZkhtanNEV3NFYnNJdGw4VkcvUGNqVW9iTGlIK2l4?=
 =?utf-8?B?cGJ1bEI5bldMTnp6ZzZkY0FRWklYTlJqbDVYSHJKWVVCdkpOdlJscEFmOExP?=
 =?utf-8?B?bE1SR0RHaHhMQ2RwWlUxSFEwZlZuanlqZlVmWTlBcUh5VlNUY3ZVSFB2cEZ4?=
 =?utf-8?B?bUVMNkVIMmhzdWltRXl3T1NheGtOd3FKVjNCU01KelNyM2Y0aVU1TVBZajRR?=
 =?utf-8?B?dGZJaE1TcndYU0JKcldDUUltaFNnUWVnOXhBd29PSnBNUlR5bmVIMEg0SEU0?=
 =?utf-8?B?eUFnNGZrNkEwQ0VkRnVXTWxGdEhoVEtZU1pHbExDOFI3dXQwOUszeFcydU5T?=
 =?utf-8?B?Q2M0QzA4L3Z0Zm9kV3VKemY4UkY3RW13RDYwNGJLTHFhTHFUS3d4Tm1hdWJ6?=
 =?utf-8?B?c3ZBbFptTTViYUFlOXRuWm0rOTE5TVd0ZUhMeHN3Sk0wQ1lVVkVwbnlXOWFR?=
 =?utf-8?B?bkpNanExcWdEK2JwMDdUOUppbHF6QWNpTzFibW9YekRoYVBObXBVcFo2Q2RC?=
 =?utf-8?B?bkZGRVRvVzJjZ0gwWW1JRWZVVUh3VlZuYk0yaWd1OXM2cTZPbWlkU3J6bTIy?=
 =?utf-8?B?bjhIVktEZks3Vmludnp4LzVya3FCWGpGa3BXMUNIaGMrVkZvTFVqWWZQdk50?=
 =?utf-8?B?bGo2ZGNhb29ZZEFaYWdMZ1ZxVjN5VDE4NUE1OHNaejN6K2dPaHVJVUtKdFZj?=
 =?utf-8?B?OStYRDQ2cFZhUVg1T3VuYXFmYnY1bXdBbGJUSmJpZGtrRHhYRFovOVZGQVdD?=
 =?utf-8?B?Qk9xTWhmdFAxQlltL2VOVDFYMEU1RWdaZUdYaXJtZHllaDJ6dzFMYVdBZWpU?=
 =?utf-8?B?RWRmZVNrckViR0V0dnJ6WnpienRNdEx1bjVQcmgzVkdvZFBQbjB5M3JhYmtO?=
 =?utf-8?B?YUZXN1ZFY2VIRy9WcXFkYWZyQzJLOEcvRFVqalJTaXJRQmY0SVhaRWtCb0pQ?=
 =?utf-8?B?ZXhnaGE3WFFwTmxKNHB3bmFXenIwcHdPMU5oZ1BFLzNvL2I2b1VCbmNCN1Nj?=
 =?utf-8?B?VlZYZUdQWDR1NWhLOGptRzZFNG93S2tqQXQxQ3pzWjlMWkI3RXNtZkUvNElF?=
 =?utf-8?B?RXJlNU95YmQzNkpkcVNJOTVkSitYT2tGdHRyRW16YzFDU3lqb2lBOHI5bUk0?=
 =?utf-8?B?dm1DWG8yUWxab3B3LzNxS2RPUXJXeXg3RkkyajFzdnJoNFNOeitxWDQ1NVA0?=
 =?utf-8?B?aVJqZkg4ZTdEazBKVlAvRGU2MC9VcU1oQkE2R1JqRXkrUzdnVFk3c3lSMWNF?=
 =?utf-8?B?ZDBHc05XcldqNWdoNjNvOUZPMDg2V21xcExWTmMrNkRhMmFjZzFndDAxcGtr?=
 =?utf-8?B?eHFBdmhRS29SVG5kVDFrbGRZeUFwazFSZEdtcVJyWU5ZYm1iVkQ2MW5uQ1lm?=
 =?utf-8?B?MVE4UnRUYlZLNmFBN0lvOWVQZnJjT3VOOElVa1ZtM2xWanRDc3ZXSFg1YmJ0?=
 =?utf-8?B?Q2k4L1pBMjN6RnpRQmVxRktBSlZLZGtjeTd5ZytRS0IvSHl2QVhhNkFFOVU4?=
 =?utf-8?B?LzJoWWhBUEp1dk5wVzhxZkNZNFZUdnhPWHBlQnBiSldES2VFVWc5SU41QjVu?=
 =?utf-8?B?M2p5M2NlZEI2dUJNNHZ2RjVDcXB6ZjdFeWk3RllvYUN2UjRZZGwzVzFnTjI0?=
 =?utf-8?B?NGJIb01WR1QrZEQvb0pWWjg2Y0htc2hTWktwTVVNdExpdHBJMzBBdXhHZWNK?=
 =?utf-8?B?ci9Za3JpcENKaXdVRlN4QzdUTUxzbytCUDF6V2FmVFNCb0M1R2N2ZjcvSERx?=
 =?utf-8?B?OTQ1eE16ZENOd2RENHNhQk5EMzZ3dlpOQyt2QndGKzl6RmZZa2ZkMWVVVEZZ?=
 =?utf-8?B?cHI4K0V6QnMzT3RHdERTbS9xdFZUaDJEeTFsT1ExS0FLVThZb2VJeHUrRlV1?=
 =?utf-8?B?M0ZqNXp5ck1nUVQvdS9uQzRaYTdjeTVVb1ArY3U4NVBlM3hOSFRad2hTUEtM?=
 =?utf-8?B?Y1FUcUFycjdjcFgwU1h4bWRFYUJyNExGMVJwNFZ0N25hbGdMbUpacTU3a05r?=
 =?utf-8?B?VXZUM0lGemxEeTVlOFFpSFUrWDY4c0lvOGc2UmQvZ08wekl5NEtPZGFBS3pU?=
 =?utf-8?B?SnRVQ3haaW0zNDlsWVBtZXhmamVsZkpmRi9EVG1wNGZRcUU4WDdTWUVjUVFM?=
 =?utf-8?B?SzMvbXFxazArRnVLVW1XdnRORENleVZhZWFoaUtONHJycVdTNXBZMkdjY1ph?=
 =?utf-8?B?cUpuZ1ZrbElhdnZjYjNVcFdKZVRGNUVpYmgraENOZTQvVzZFNUR2ZjdCdXJo?=
 =?utf-8?B?Y0hkTEVmMmVmUk5OOW9oZmErekpiQkZ4UU9qVEFVOFAvdmczN1BiVE9LdkVk?=
 =?utf-8?Q?GB+emldSPShvprSJi5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a42b6a1-5d53-42ee-7628-08de64ebd11b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 19:21:52.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ4H4UTfQpWXYo7FfgCIZbRI4Hvn2a9MXH8uiLZ9cypTxrGpXpAs3yjsb7JoEbO1wMeAEkcOhiLMHrfOgf28CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20868-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 43AEFF6C98
X-Rspamd-Action: no action

>>>>>>>>>>> Hi Sumit,
>>>>>>>>>>>
>>>>>>>>>>> I am thinking that maybe it is better to call these two sysfs
>>>>>>>>>>> interface
>>>>>>>>>>> 'min_freq' and 'max_freq' as users read and write khz instead
>>>>>>>>>>> of raw
>>>>>>>>>>> value.
>>>>>>>>>> Thanks for the suggestion.
>>>>>>>>>> Kept min_perf/max_perf to match the CPPC register names
>>>>>>>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
>>>>>>>>>> CPPC what's being controlled.
>>>>>>>>>> The kHz unit is documented in the ABI.
>>>>>>>>>>
>>>>>>>>>> Thank you,
>>>>>>>>>> Sumit Gupta
>>>>>>>>> On my x86 machine with kernel 6.18.5, the kernel is exposing raw
>>>>>>>>> values:
>>>>>>>>>
>>>>>>>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
>>>>>>>>>
>>>>>>>>> del:437439724183386
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
>>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It would be surprising for a nearby sysfs interface with very
>>>>>>>>> similar
>>>>>>>>> names to use kHz instead.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Russell Haley
>>>>>>>> I can rename to either of the below:
>>>>>>>> - min/max_freq: might be confused with scaling_min/max_freq.
>>>>>>>> - min/max_perf_freq: keeps the CPPC register association clear.
>>>>>>>>
>>>>>>>> Rafael, Any preferences here?
>>>>>>> On x86 the units in CPPC are not kHz and there is no easy reliable
>>>>>>> way
>>>>>>> to convert them to kHz.
>>>>>>>
>>>>>>> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
>>>>>>> in CPPC units, not kHz (unless, of course, kHz are CPPC units).
>>>>>
>>>>> In v1 [1], these controls were added under acpi_cppc sysfs.
>>>>> After discussion, they were moved under cpufreq, and [2] was merged
>>>>> first.
>>>>> The decision to use frequency scale instead of raw perf was made
>>>>> for consistency with other cpufreq interfaces as per (v3 [3]).
>>>>>
>>>>> CPPC units in our case are also not in kHz. The kHz conversion uses the
>>>>> existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are
>>>>> already
>>>>> used in cppc_cpufreq attributes. So the conversion behavior is
>>>>> consistent
>>>>> with existing cpufreq interfaces.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.com/
>>>>>
>>>>> [2]
>>>>> https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.com/
>>>>>
>>>>> [3]
>>>>> https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com/
>>>>>
>>>>>
>>>>>> That said, the new attributes will show up elsewhere.
>>>>>>
>>>>>> So why do you need to add these things in the first place?
>>>>> Currently there's no sysfs interface to dynamically control the
>>>>> MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
>>>>> users tune power and performance at runtime.
>>>> So what about scaling_min_freq and scaling_max_freq?
>>>>
>>>> intel_pstate uses them for an analogous purpose.
>>> FWIW same thing for amd_pstate.
>>>
>> intel_pstate and amd_pstate seem to use setpolicy() to update
>> scaling_min/max_freq and program MIN_PERF/MAX_PERF.
> That's one possibility.
>
> intel_pstate has a "cpufreq-compatible" mode (in which case it is
> called intel_cpufreq) and still uses HWP (which is the underlying
> mechanism for CPPC on Intel platforms).
>
>> However, as discussed in v5 [1], cppc_cpufreq cannot switch to
>> a setpolicy based approach because:
>> - We need per-CPU control of auto_sel: With setpolicy, we can't
>>     dynamically disable auto_sel for individual CPUs and return to the
>>     target() (no target hook available).
>>     intel_pstate and amd_pstate seem to set HW autonomous mode for
>>     all CPUs, not per-CPU.
>> - We need to retain the target() callback - the CPPC spec allows
>>     desired_perf to be used even when autonomous selection is enabled.
> intel_pstate in the "cpufreq-compatible" mode updates its HWP min and
> max limits when .target() (or .fast_switch() or .adjust_perf()) is
> called.
>
> I guess that would not be sufficient in cppc_cpufreq for some reason?
>
>> [1]
>> https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/

We can do the same as intel_cpufreq. CPPC spec allows setting
MIN_PERF/MAX_PERF even when auto_selection is disabled, so we will
have to update them always from policy limits in target().

However, this would override BIOS-configured MIN_PERF/MAX_PERF values.
Since policy->min/max are set from hardware capabilities during init,
any governor would overwrite BIOS bounds with policy limits (hardware
capability bounds) on their first frequency request - even when user
hasn't explicitly changed scaling_min/max_freq.

Does intel_cpufreq also override BIOS-configured HWP min/max values?
Should we preserve BIOS-configured values until user explicitly changes
scaling_min/max_freq? Is there any mechanism in cpufreq core to detect
explicit user changes to scaling_min/max_freq?

Thank you,
Sumit Gupta



