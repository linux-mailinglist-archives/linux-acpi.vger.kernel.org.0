Return-Path: <linux-acpi+bounces-17326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E5BA2392
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F427B4AC1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383125F998;
	Fri, 26 Sep 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXjPp13s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A951DE4F6;
	Fri, 26 Sep 2025 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854192; cv=fail; b=hlXzyxHeA9cPJm894e/Z0vxls2styufeOiWXMN6u7D+t4bdDowtPOjMEzQbvMdsoFVi93QQfVqsGJOcQQR2BpOYaGc6ZVUfVYZ7UTO9jdEhNLHo7pJ2aZPPSKVoHYa/Fd3MNxwzxmeeuRDYk8brw0knZiZK5IQikh8Ah0IYjE6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854192; c=relaxed/simple;
	bh=MfZHEWkEwWySyLkDW4DgA2cT7oxhXgixRJSs20hIsA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsxnfLHU88q4/BwwW+1n/heku3twb9imYyTShUdERoK47Hw/3EPxF8+6gUT1CPBbMfGNpLQxHHdygFc5XBmemrntlCbr80soIAUg3UlMZnpOeNxOE/wMnhPcf3LLOReKL24n9qJueIVw+k7RkhUj8FxRxYWegRC0ARvlbAcZetU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXjPp13s; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+6UJbSD4XQwWsNuPfxlH33LFu7s4MgOWnnaiqbhkLnt+DyD3U3lQVeW/LjptgCL2VfkP0/S1c4MuxPm6QoFdMlTBRX0CN7NMU1vsGNfVfe18D4oLA0W7Zf1j4XCFns8lF92R3vYgaKQPb/g/hCEU5Djy2f5NAaeAqSUimodvzd24+AjejybpP51dknLk8V9s5KvX6ip0JykNNJQ4bWK6CQH0DxVzFJeE0oy+hE/xsQ52AhO0XXIlz9kf0e0meKmDINncrVV1rNQ6YqwJdHVcs7C7BoIo7eIaYl23RanUWrkHvS1o+KbEalSWyJgFcko/OEKaBKwbYyMkK8Z3QiKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfZHEWkEwWySyLkDW4DgA2cT7oxhXgixRJSs20hIsA4=;
 b=schcSUrDWwoZap38tlSZECz+CQxXgvDqfBw58iqRbiHN7CO1ktIWlbY2Jd1HHc7h6M19METfACcArGOHK3VH74qCG6O5YPQgyTC9rsa/d6Rgn/cWonZtYKXO8FJWhmsUhsDzH0Cn18hj7hThG05kHsl178lRnBjQA1cBQKnhqWZsQIaLbihKs2U4Qb2S9pznvlPV0m0XcsbpbCH6i7imwEKlL4UStvXpgS5KKW8ukK9jxy1bKthSg1wzWTubV1cqfJnjFFNhaCdjtWlVCAc4CY0pMvw6Oy3xMZoDKwWotmBCCWln03SFBJtHy4VkCv78vMU662+hP990Ep1zdji0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfZHEWkEwWySyLkDW4DgA2cT7oxhXgixRJSs20hIsA4=;
 b=mXjPp13sKhzSLMZK+eNqEyDvfBwn7sx6jlNWsbUrYkPg8qSIxfc15NEpge9+NzJdelcfp/vjlWcWa/pZzmklaJG0j1uk+F9Umzgxqa6WwPKlhEIk+bwk98GJMtxkUZlXTtssLK2KDLfA4dmKBnJ8cWtd+gwYT7T88FaGw4jAoGWDQI7O8uU8pa3yjl9NqgJMZUOzUfCFLuOgz+gryxU39ffXzuHugw703BvfZsPe2jViSQCcO3P9owmr649m5vSycdOQvF5pqlQQJXmY+GbQCbFPOaUcvqSrSzU1Rioke8k+KK8wZVXD8sPN5PeOdQ57cHut0tJtwerhzCojsuv/WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 02:36:27 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Fri, 26 Sep 2025
 02:36:27 +0000
Message-ID: <1c0907cc-5cfe-448e-a308-c347566c1f68@nvidia.com>
Date: Thu, 25 Sep 2025 19:36:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
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
 <20250910204309.20751-30-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-30-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: e76e6679-9462-43e0-a64f-08ddfca57e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3hVbmRYMkFLL2E4K0o3RjV2K3BXMGNRQ2hFcmFVNVlZUTF2SlhRR3lZNUhK?=
 =?utf-8?B?OG15Wk53cW80TFdlVC9za3ZJY3E4VmM0S0E2RXlDd054bHVvVGpiMXpZbm5I?=
 =?utf-8?B?QUhCTThRdkgrWnQ4VzJLWTNLdVlGcWE1V3oxdGp4aWNrNEFra2FnWWhycW1M?=
 =?utf-8?B?cnluT2NESnAwZSt2bC9MbmRNb3NsZG83R05jN2xiUE5EZ2NZMFYvZ2VaSllU?=
 =?utf-8?B?clBpbWRlOXV0UjBWY2ZCLyswd0w3N2tFY1NlVjJJemlDbjhLV1dMU0plUkRl?=
 =?utf-8?B?OWxJMFJMTGM2SkV4N3FKSFYzTzJvbVJLbnRlVWlRblpXTzZIb1FLMG9VN1J4?=
 =?utf-8?B?Y0VDVGdBdm1Ham5ZZmZheCtka2dabm5lQ0hkVnF0ZTY5VVRrZlJ0WnVpSDBJ?=
 =?utf-8?B?SHRmKzV2ZTRSR0VyZkgrTlFMSnEwbFpkdWhYb0NpZ0dTbFJVVXA2VVIweGN3?=
 =?utf-8?B?alJsbkdQUVdIQVB3Y1N2VUsrNUFhR0JzL3NxdFNSQkNwQ2x2ZVEybVg0eVhG?=
 =?utf-8?B?dDBaczdKbVFvVTEzU253VUFaVDVrcmZJS1VBSnBEeEdMY1hiaGxMQ0V6U1ZD?=
 =?utf-8?B?VHZWTVFtdEpSSy9XZkdNZkZJZUU5NnZ3bGlMTkNVVkdFcFU3cG9NMHJFOTk1?=
 =?utf-8?B?L29nVTNUcTVLSHRoeDdWRGprYVBqelpLd25IVmlXeTBVMnFRQzhOSGh4Q25i?=
 =?utf-8?B?dDV4S0Iza2JmcVFZQTVGYThHTjNwTWd3MTZscFVNajdhVDZONUQzUXhHSHJL?=
 =?utf-8?B?UHJJOHkwQlN3UXhVVEpFSmlVTTVMZ0dGNjF3WWpQZEFWcndDdzhmekJyeUZG?=
 =?utf-8?B?VHd2WkdkajA0M0paMnJ0N0lGUFhoUlZjTjU0TEJGR1F1b09nUGZYa28xejZT?=
 =?utf-8?B?bjlWTFBHU1Y1cHhpalB2MGlvNHUrVENrT3FZZUxnY3d6UHdsdDhqYmd4QjIx?=
 =?utf-8?B?d2Q3NFBGMGVBRWxuL3VQSTZVTklDeHNGeDlKbEN1N2I3RFRNbXdVYU5QTEdn?=
 =?utf-8?B?WUhhMlF4UlJLc0prYkNaa3hpY3A2aWdyN1ZLQWNJazkxTnFTcU1EdlMzVE9I?=
 =?utf-8?B?eUpjTm1mb1dobGtTNEZWTlB1UDF0V3Q3Nk1ETmd6bXp5cGNPaFliWGdTU1BO?=
 =?utf-8?B?OXEvTXhSQVRvcFF5NDhXWEI0ajV2TnczSk9SQ1pLWmRzWkttaTZjdzRyL3Z2?=
 =?utf-8?B?TUR1eDZHZmtSSnRVUkcwRDBOeVNCZ2pmejZWSDJpdW1TWm8yWFptSTNZZk9Z?=
 =?utf-8?B?V2FoN2U4VmZsU1VibThBWWdZL1FScm5UbE1zN3g3bkF3eE5lMzRjc2xkdDdi?=
 =?utf-8?B?c3RNeTc2eHdqK2diN3RvMnI4OXFsQUhlZ056eDVMSy8yd2pxVmQwalFyZkJE?=
 =?utf-8?B?MzlxdWN1L1hicXNwdTdVQmNVZTY3UGpaUGRZQ0kxZytORFU4TVYwMHdvN0d2?=
 =?utf-8?B?Uis5ZGx4QjVsd2tBRktVQVpkZHBCZkJvb1JVZEFlV2xMalN4TUhibUl6aXN5?=
 =?utf-8?B?UHhPc2hnc1IrK2YwLy8zMFhVa0lUcWVPWkRkdmJxRWkvK3ZzMDNiQkRDbWVv?=
 =?utf-8?B?RzMzc0k1aGdxVnVyTy95TTBIeCtNOGhVWUhBTFpyc2EyelpHa1hoalMrWTEw?=
 =?utf-8?B?Q1BGSlZPWUMyTkpzZVZmZzkxbjcrWERveU92UXRzRFQzOVFjVHFwR2x4WmJw?=
 =?utf-8?B?cE9tVnlzWUZZM3RLd25YT0lBUGdnSXJWaysxU1VZdXVlMWxpck91SEgzS0lU?=
 =?utf-8?B?cmRIQXRMT3diby81cXhHNUN3eFE2VXRPNnNmOUV3bXR3NVg5RzluR0VnUmRk?=
 =?utf-8?B?dGdJNnF0U2JCYkZuYVV1KzJ0VnlMZlg1V2V4bzhkSGMyR2RRRTF1VFNQMy9a?=
 =?utf-8?B?SVZjT1MxZXN6MTNjQ3I0QnpQditBdHdSVHl4eHlQOGFWamc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkp6YVNSeFpVUVlGWDVJNko3TVBVdlZsQVQvbVRhMkJJZmtvRkQvTm16akNZ?=
 =?utf-8?B?SHZSVWVuWGM5T1FCSDluQVU4YktUZFduQzhQVzVMVHRLdmZObGRXSTN5Q1Js?=
 =?utf-8?B?NjA0TExXVDFON3hGR0dOakxuUzhNQ3hCMjZjbURXbXlYS2U3WEJLcGNUZkgr?=
 =?utf-8?B?Z3FtR0c1NU0yamJjUFZhcjFmZ2x3d2l0WkovakpnSEdyQ29qUWZOT3M4MUll?=
 =?utf-8?B?eGFNemFFWVNqZDNyZDZYVWtnaWg4dXhZQkpPNVdDQkwrLzBYb2tXMXpCWE1V?=
 =?utf-8?B?bXlaYkFPYXlNZnpKS3VLUzdVVC9GUnVGQTRUVjNHVGd0SFRuckJXMVl4bTQy?=
 =?utf-8?B?dFNJRS9LTDFkK1hyMGY2ajdjYkE1R1RzUUZISWlyall5b1ZzYVY1a3d2bGtO?=
 =?utf-8?B?VjdheW9keGRRSzlIM0J5SUhIZzhmenFVMnBNY1ZPQzZQaE85VG5Pck10ZHNn?=
 =?utf-8?B?TzVmUTVVQXRxc1lQWnVjYkVYYTBLTWRLOC9KWWhDNVNGUGYwd0c1dlZLZWJ2?=
 =?utf-8?B?ZXlmWkxPWEhRUkxzSmVtY1crMUphMWFaelZHVy9ENEtJMlVGcURpakRtdFV0?=
 =?utf-8?B?b2dDQU9neTVyMzZQWEdQRkZOSHMyR1pIQURwd0FkVFQ0VkhLa3pRdUdFcmQ4?=
 =?utf-8?B?NlVla2V1YWtBTmZOSmtUU1FWeVJiQzZKUTBKV3dQOFZId2xSMlpQZWtDNE5K?=
 =?utf-8?B?Qm9iNGNlNmwxSGVPdWFpRW5hdXowcHBRSTk4OE5CdEFxMXU1R1Q5TkJ5emhD?=
 =?utf-8?B?c2RpcVlvOHZ6S3Y0ZmhNTGZvWFBlMmEvQ0ZNUzJnT0IvbTIzb0hCclpyVXJN?=
 =?utf-8?B?SVIyQTVURW5PSFl5VGUwUVA4eklmY0c3SVROKytmN3BqZ0ZoK1JpR3ZPWUZ4?=
 =?utf-8?B?UUpncG5RZkpTMUFTMFo2QVllZEJGUmNIOG01bjFwd0M0SFl5OURLaUVKT29T?=
 =?utf-8?B?RVVZM0lodDNQTk5vQ2VxdC9vNHh0NHVSWDRlNUptU3VjcWZpOXh6TWpTdEpG?=
 =?utf-8?B?Qzh0cXRUdXFtT21rb2JFZTRvL3ZGZDVOSFRPckVYQ0FHK09NbkdqWEdwLzlu?=
 =?utf-8?B?RkxvNE0wd1g4djlqWTVOUnZwalgrZVA3eU1XbnZNdWhvaWt1bXpPZkhTTW5V?=
 =?utf-8?B?cjRXVUhNRkN4Z2ZXUnhLa3RZblI5V01nTzU5WXBwcFN6akxHbGRuZ0ZuT3Ex?=
 =?utf-8?B?ZW1oQ0VkTXA0bVZtNTB4OWlBNHp5MWxxVmlka0ZQYkpQcmkwWDgzTGllTHRu?=
 =?utf-8?B?UkdTenROS2J0eXRwK2tFVjErV1JnN1d4UTlVYjdtcDUwZTJnYmpLWi91cERv?=
 =?utf-8?B?UVA2RDN5aFBvaHE0MEdNSUxUczE1SnE5QjFMZ1BsbnhtSGlSRS9RbGRiV01Y?=
 =?utf-8?B?d3Y5c3RwdHB0RTdkSWx5ZXhXeUFwWGY0bHZtQ1lINlNVU092WHRqclV6MlJX?=
 =?utf-8?B?SnFnM3dhTHdTUEdGK0JOTWU0VlFnN1NkTjU5T1BJUTQ4RDR2SDgzZlRvVlJ2?=
 =?utf-8?B?MHloZ0ttY09ZU1pCNVB2MlBRcGhpc243dWcyTDY5cmcyOSt6UzZiQWI1Z3V0?=
 =?utf-8?B?SkZlVy9lQ1ZOblB5c3l6NmR4SEVBOFlOSXdqaE9yWGxWQkk0Uld1QmdNalht?=
 =?utf-8?B?OEtpY2xqY2dOQjFrZnZSdTI4YiswMVhxdDYwR3RYbXhWVllYclJJN0RtcWFB?=
 =?utf-8?B?eXlSZEF0NmExTVJNa1A2LzlUT2YycDVJb1Z4cXY0VUxUOEExRXRaN1JEdE1L?=
 =?utf-8?B?M0RDWnJXWE9oMkJqUW5UUlhuSmg1d2g0Wk9Va1JZSHdLVitqK1ppNC9NLzFz?=
 =?utf-8?B?Q016TWpqZXgwVzNGek1jQnBSb09YMENQZGdjRUx4amJmSU5SVEFybjJENVg3?=
 =?utf-8?B?MEtCNXVQTmo5QUZnWDJRLzlTMnBoQVhFWXFETkdNNWcxekh3ckJQNnBFOTc2?=
 =?utf-8?B?dGp5NCtYNzc5Z05Pb3ROTU85VFIvZHVYUkZjREVJSVNXQ3VnaHRBMzM5Mkkv?=
 =?utf-8?B?RXNpL2NIaFJ0a09nVUtyRXMrWE94TG5aVWEwQ1hpOFZNei9GUDRsVjBrU3RQ?=
 =?utf-8?B?c2w4aXcwK3djU1djNi9JZzA4MitLZUpIQVJrYUcwSXRwN1NYT1VTQklnWUpS?=
 =?utf-8?Q?Drkawbdk5RjS4bIe6BNQQKMGv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76e6679-9462-43e0-a64f-08ddfca57e03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:36:27.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrr0Gd/OxK3LTVux8QxR4ufZCarSr5+IPK84yQZSDaU7CA/IgojRtx/ABVb8zn5S+SLTLAkJYfgUi7Rq2AJ8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787


On 9/10/25 13:43, James Morse wrote:
> When features are mismatched between MSC the way features are combined
> to the class determines whether resctrl can support this SoC.
>
> Add some tests to illustrate the sort of thing that is expected to
> work, and those that must be removed.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


