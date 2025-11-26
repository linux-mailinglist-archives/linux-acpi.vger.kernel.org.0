Return-Path: <linux-acpi+bounces-19281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2C8A0B6
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 14:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42733AF23F
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE009287272;
	Wed, 26 Nov 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZBRAkqk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697379DA;
	Wed, 26 Nov 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163944; cv=fail; b=jMlmy/vFzW8/rlbvCcJVfOe8Bd4lq/2/7rdo8MeIfEItJvwZUpcKzYA3OJxmVQGjfc+s+oZaHhLS7NgiBiL0l/j9JOG8qntzjaNSlu75bvcvWQB3BhuaHY1lGvO8q7MZcTFvh+nVF4rvkek7cgcvZZWZ0m+e+Ba2+W7E1RVtcFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163944; c=relaxed/simple;
	bh=oFmKCMRZ+qjggf9mzNWPqYHf1T1FQtOEaLi3248nOjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N0m7Pb1HPt+hzne/Qty+YcW060IWg8VLtnoIVVWiAUY//bmX+8bKrnV+Dr2ImOnSiAabg9i+VUo5TUpOTTC8BVN4glfoupRXzoWjrq1U0WgaXsN4A+KaspmSe3G/pXRwgZla0J22j2aadKD369lOHF4bxo+ZsG+HcjVfcEGE56U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZBRAkqk; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1Fj2DW8/9c+rU0acDwYPt1cF1JDedTWoCJF8eNGCGIH8xq2k2Sb75DVbarw8ofIhYSHMSuhtjTgvxdHvOmVwwT7DU6imtn7pRjAYtD3Ms//KAQ6xkL208o70XnR2bQTTnrCc4BmIpbrPGyVefhWYFqnfBt6+H/WP9cbq00xr0gIQeOU1Ib7kcCwBbT4vXkyB8VUmAwwdiIY+08ZopbQ259ORa1VbIY6HaQv07C6k7aPDXlKNCPLMeFQEE4Qy8nRqJyTeV7zZmBPb8EJoDW4GV7SDiEuI41s8CQ40GTxOUf7SpHUKfYyfPxRM6MatFCf5Il8/9AkorWPzKmA/ayvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX0kJgksCH2PLwZ1tW2rfHL1LF+YOOfJm2hjEqX+B8Y=;
 b=XaiTJG5MLPTQ4IvsyJtADFGBwtessNs0tsvl4lq4fznvw2UB1kWAkKX1J49Sn8GHYWZqiiD3ClriXQFqQZ6LGAOLw4yHhCwIdmeUat5UWPh4c0wUrg1Hp89OvoIeWvbNK0BPT+Ba8zwJ+yVj9NV3hLqvMOu2FYFnRImzyC0VR16LigurhpGdxTGZaLaGm75mNjwhoRUqSqfNk2I3WNmEZhnAn1nDejhbE47LUyadM//czIoJ7ptb/5KxWo6gDAaCFZIGKjDLc2aHiaMr2XnuxRPC4JpKb3MMyYdsb5HTfFqjxjoIwtGJ15+fizpcgxtpAU/A7epXWdXAmmBqPG3M2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX0kJgksCH2PLwZ1tW2rfHL1LF+YOOfJm2hjEqX+B8Y=;
 b=YZBRAkqkAzFMV5bjcNAv7HzgKTO9VUjw89tZ+vZa/TdTr0z+LWmviRM87ljd1HVNZwjyC+LtS7B8zbAwpE+gKEEXJAhhxcXAfJBq7X96EL3D+BZKPBP5K4u64o2hcYWHvEd5jpEHWgj7QtGjHOQQ1TaPrHL2+u3fGu2hGukv7CD1LmmpsleBI0AdnYMkBN+QIoZ9JDzfwgQTC/rTbOWKJzKpRmaF7NjI6lV5f8Ucvr6rhDZjiiTYrRfp35sXEe3Tp8pxbxypdYbhMRw3C/eOhV7fb6Qjrz4DtfGFXAOHmUuhOfHtPwgXYLKhigswIjIB7BofQeYzl8iaY7oY8kkBxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:32:17 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9366.012; Wed, 26 Nov 2025
 13:32:17 +0000
Message-ID: <5593d364-ca37-41c5-b33f-f7e245d6d626@nvidia.com>
Date: Wed, 26 Nov 2025 19:02:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-9-sumitg@nvidia.com> <aRX2Iz9+3oMZpX2K@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aRX2Iz9+3oMZpX2K@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f7813c-7e39-4aa2-693c-08de2cf037ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG1LYjB4UE5qUjBxVTF5NG9RNW00b0tIUjRiYWxpSFJVTEdBK1l3Z08vU3l3?=
 =?utf-8?B?ZXRkY1FiMkgrSnl5a01JeG9NOEV6MGhJdDhKL2VWME5RR2w2UTdlQXpJQU83?=
 =?utf-8?B?OEtPejVCZG1oWmNCMWo4SC9VblFJSkRwdXh5eHlVdk02eSthT3diZmY2U0tn?=
 =?utf-8?B?NkgyQmJoTFVtN3psd2Jhb1pXYm9nNVhSbi96YnlNajZIYVVjcGVvMVZDM0Yz?=
 =?utf-8?B?aDVCcmF4U2QwK2dLczJMWW04emlpTTA3bTJVTzlCUHZRb1FEeGxoTkd4UEM5?=
 =?utf-8?B?VkJIUktJS3lWSlFRbE9yMVVRRnJDTzNyTUZ2dTR4YVNEb09uMXdvTWl5bkx6?=
 =?utf-8?B?bHlVWkZYcmV2elp1cWIwb1Uyc3RrN28zS3JuZVNyTmxXaXkxcUlNSGdUeDAv?=
 =?utf-8?B?TWY1cXpnOTNqNUpvbktRTWtoZldncDBmVWJQU29LbUtRRXlWQjNwY1NBRkgv?=
 =?utf-8?B?TmVMbStERTdzZFdEYTRIWWs3eHBXa0R2eFVjRnUvdExBTzI3eUZ2aXFWeTdJ?=
 =?utf-8?B?N3JtK3oxWm9jN2VrYkdnT2pZc29keExEQ1phTmxoNFpOUk5uRzhZU203cGFF?=
 =?utf-8?B?WmhWUGFuZ1F0MlM2aGt2aW0rZ0YzdGpwUnVsSzdrQnFhTUFkaDhDTFZ4azhv?=
 =?utf-8?B?ZlpjNUd3VnZWK3FpSFRQTE1JdU1ja2ZveHBHTmJHNHlXcFlXUmdXL1BJRUJF?=
 =?utf-8?B?Z2tsRHgxWVEzTXZiNytwalNBVWFMazBUSmoxWGxHa3d5RVRPY3lEaXRVc0Y5?=
 =?utf-8?B?RlJTWDRwVlpBeG1wVXRxMFNwd2FJN0lqZ2FNMytiK1pTejZ1RXFyOUtTZ1BS?=
 =?utf-8?B?VGtibGVUVjFvU1p5dU1na3o0d3JPKzlYNnBiUUdtZE5IcGlIV2NwOGhLbElB?=
 =?utf-8?B?QkV2NnZyUFJ5U1RibGg4UUZGejZmbHozanVDS0owT0RVUWZ6UGYveHR3YjVD?=
 =?utf-8?B?cDlDaVdvcTA0MEl4SnpvUG1sV0lDU09PNjNKSW1ndE8zZTA5cGtibXhyZ1Js?=
 =?utf-8?B?UElBZmJDMDByQkFuUGJKNUd2Y1BMVUgyUWRkeWlvd0t5NmlhYlVrVnM2K2Qx?=
 =?utf-8?B?ZGY0MDZUVURHSXhFUFl4UW9HVjR5MG9YMjludzM2K3VYWTFqbkJ0WFIwZmZE?=
 =?utf-8?B?WisyaVZSVWVWMEJSL25JUjBwcjdhTk91N0dialQ1dlJISmFwV0VvMkRVb0JY?=
 =?utf-8?B?MXk5SDRxWTVFamttb25DcXU1TTFpNE9SUlJOSHBWY1dqaDZZVE9SWjVUM2l2?=
 =?utf-8?B?eGZneU5KbVBpYTRzU1FLczJNM01jVmg1L2w0OGFQODZKenFLNEVSRDNNbWdy?=
 =?utf-8?B?TGw2OGZ5U1VMTDlBZGhLamVIS3NleFVjZjgxU2JvL0lFZXc1ZmJOYStZU1FK?=
 =?utf-8?B?K2lpSUpBSmYyMHRMb29STjRZdytuT2NmQXVKK1Rvb3FSTnNlRVVqUWJCVHJG?=
 =?utf-8?B?MmV6ZVppY1hjMlhJTFpDV2RCeUxZelZsTFl2TG1kLzBEY2ZCZndVNkFDSE1x?=
 =?utf-8?B?ZHl3cFJVcjJoSFllaGV4dkpDd3daeDVmUTUxZlNsZGZ0TUVNbHFqV2trZEdo?=
 =?utf-8?B?bnl1ZGpCNkFOKzEwb3JlVUd1cHRLd3FNdG5jWEN0VWxzK242dGM4dVFZd2Fs?=
 =?utf-8?B?dys1TFFWOFNlU2pBT01OU285SURNYnQxVU1WMHl3bUFFY3FnOCtPZFcvSXRM?=
 =?utf-8?B?VVNjaVpPMFErWWRyYnl6M3h3M25oL0ZoN2tsbldkVmpTQlZ5bStqb2c3azg1?=
 =?utf-8?B?c01xUDV3OEt6OE5leXNWWG1ldVNyRlVuWUhDcDBNZnhPaDQvM0ZxY1V1b1Fz?=
 =?utf-8?B?M0lFb1JxS29qVWZNNGNOd1RZU1hsU0cvZGpNbWtEZjRUZTNoT3VKNlNPaTJ0?=
 =?utf-8?B?cFN3R0Y3SXhiMnMzWmN5SnMwR3VXOGswTDB3T1J4UHI3ZGxoeU04TklJbjhX?=
 =?utf-8?Q?+fT/Wkw9oMZltHMtsNdfvg79YgjkTA40?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkltdzRDak5ydGFuWllIUlUraDhSZXJuT2YwRDNsWWNXZ2VQOHV4dDNxKzVI?=
 =?utf-8?B?Y1pTRUkzWWVOU1BpcG5XNWo4MXhyY2F4ZXZFM2JzOWdxUHdKKzJHMnlGY294?=
 =?utf-8?B?b29lVlZoVGNkbzlMY3V5QzdXb1hHcmNKMGdRRW5qUU1mRThqWTYwQy9lOWFR?=
 =?utf-8?B?aHY4Z1JGQ2VoVEpheE54TEZ0VWl6TEY4bVJObEFQeDZpeEZacEd0Uy9yOGlQ?=
 =?utf-8?B?bU9HclpSNmhUV01BWWhhOElNc3pSbXg5Tm94LzVVVGtvSUFCNWY3THJkeERV?=
 =?utf-8?B?NUlIcnd3QmhKQW84U0JJd1BCelZ5a2F4bXAxTS9zNURjSDRJOFE2ZjNDbTk1?=
 =?utf-8?B?ZDRvQ0VIUXhCRGJ4QWV4QXFIV1RtWlBFNFZMdVNvZUdLd3U5amRMcGtlSjZB?=
 =?utf-8?B?Q3AxVWc3YlI5Rmcwclp5b2U2S0Ryai9RbzRaanFDVjNFcUN2ZWZBMW51SU4y?=
 =?utf-8?B?VHFGcHRMVjNxWlYrTnRSOHR1RUxYRlh5amE5UEdyUFRTS3ZmMkN3dmFMbDNR?=
 =?utf-8?B?amplNjJPdTZ6UUFSbWp1WncyS20ycTlxNk11UC9EYVZZY1RvdW5ONXpXeVpi?=
 =?utf-8?B?ZFZqdXhnamRaKzNXd2QyRGhadXVpZENnUS9qcjA0Z1FycWtMQ3JnUVkxZnIz?=
 =?utf-8?B?Vm5oQVIvMFNKcjNaWFRnbVBVUlUrNW1mQU5QakpQNTBvb2lIbFNQUU9ZWjFG?=
 =?utf-8?B?VFZvcHRVK044eDRsRlBqbGUxWFZSTkc0Vm9EV0RCNFpWaUJCRnJXSnBLU0xw?=
 =?utf-8?B?R1pnWlQrUUNPWW5BbmJiS1NhRjVZVWNzdnlpNlFNT09oNXRmMWdELy9TRWVZ?=
 =?utf-8?B?U1pQOEM5VGZ2VXgzSE5oU1N3b21saUhjNFRNSFBIaElVSDBqeE9ES0FFMFlN?=
 =?utf-8?B?QkEwdXd2T0NKaXdqQ0ZuTnozRTlwN3MrYTIyUU5qcFVKOERzaGFHc0dtQlR6?=
 =?utf-8?B?SkV0M2xQTTdKVndkcjhJa0hoa2hxaldrYjI1MXU1ZkJvYnlJbkxkUzlIa2l1?=
 =?utf-8?B?WHZsRGVvV3g0M0Ewd2Q4ejFqOGdDSVBJVkFsUFBac3I0cG5ka0RFMU9uWEgw?=
 =?utf-8?B?RXZrTTRWekczTGY1NE9NdGxaM3dUWVFwYlN1NERoZTZwVDFDZi8ybzFjK1U1?=
 =?utf-8?B?UnUrcHY3L3ZmcCtHelRVcCtUbFN2RVR1b0Z3OTZmMXV6NVRhTWdkMUdGalNO?=
 =?utf-8?B?VXY2T0Rmc0dDRkJYNUh4U1M4VlFEOE0xYjBMMDg1ajJJY1p2WlZUL3lJZ0tj?=
 =?utf-8?B?WTVPY2JtNS9KbXh4dVkzenB4TFZGTFNVOThoL1hRZlpRdlJyWWNhamdCWFNK?=
 =?utf-8?B?OG5jNkdXbkpYQnREU1FaYXJ5b1BGZ0JvY2FpOW80VldBTFo3bkxzODdLczh5?=
 =?utf-8?B?M0J1bnpzV2RkVUlCS1dDMmYrajNHbWJ1ckwwWmthTnJTTGxhRFl4QThWT0M3?=
 =?utf-8?B?MUJGajExTUJTcnovVEYwU0NYTDlvQ3lXRlg5bXdHWEk5Rm5RUTJuQmpYTVVO?=
 =?utf-8?B?NW0xRGg2dXd6TlVOWnZkZUdtMFdUWTdSb081aTU4emlZcCtKVHFCZm0wejdD?=
 =?utf-8?B?ekFSS1Y5YmIwYWpHMG1DaXIrSG55WlZuT2RKZzRWMExqMlJGNHQ2Q0dzdDFw?=
 =?utf-8?B?dGI0TWZzU1dkdU83eWs2SVV5bVJxK0g3am9jVmI4ZG94Kzc5RlRpTFk2b3lj?=
 =?utf-8?B?V21PK21UaVBRWnRSVDIwNnZvVFdKTG5pd05IMjk0V01ncERBRVVxVUQvZlVk?=
 =?utf-8?B?TGpFanhKaGZrc2xzU1QxMTBKUHNWOWtrSFB6ckMrVForc0ZmcGJsTDgxM0Mz?=
 =?utf-8?B?am9oWU5OMjI5YUVKMmZmbDlOM1dQL3dGR3IwTHlxRXBIL0lWdEZaVXNKeG8y?=
 =?utf-8?B?bDNJaWx3bTdTdFNKeVF6SXljQ0lPaURwdm9GbEtUUTJBYkc3dkNHc25ZTU56?=
 =?utf-8?B?dXRocUFGYkhTQ2h0cUFUanc3dit2Z0VFeGw0WUhaM2V2NlBqTkNicFJ2KzhO?=
 =?utf-8?B?SEYrSDFJUnpwL3pkZndUb0FaQ05tRmhiVXRTQ0xTSEZGdG83VnZ1cWdJWUE2?=
 =?utf-8?B?cGxhaEFxNW9iMHI1SFBxR3RNMGY1OW82ZGhhYTM5MGtqQVVJQVJWSmlZN1dQ?=
 =?utf-8?Q?rmP47UL9RH6abDwlgDzhzmX7j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7813c-7e39-4aa2-693c-08de2cf037ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:32:17.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4Hf4c8XsTaCnL4gyPVZaixZr3Mtk+6i6VJ5BaLLWdLKA3qEfRP+ukauiYtqzN9WjKU3Et7D2ejX11U4CdaZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140


On 13/11/25 20:45, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> As an overall comment, there are now various functions that modify the
> autonomous selection configuration in various degrees:
> cppc_cpufreq_update_autosel_config, cppc_cpufreq_update_auto_select,
> cppc_cpufreq_set_epp_autosel_allcpus.
>
> Are these all really necessary? Some seem single use functions that
> make the intention very confusing through the use of several bool
> parameters. I think a lot of this complexity can be avoided, so
> I'd recommend to re-think the software design a bit.
>
> I've added more details below (and I've skipped review of the previous
> patch).

Sure, will do the changes in v5.

> On Wednesday 05 Nov 2025 at 17:08:44 (+0530), Sumit Gupta wrote:
>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>> autonomous performance selection at system startup. When autonomous mode
>> is enabled, the hardware automatically adjusts CPU performance based on
>> workload demands using Energy Performance Preference (EPP) hints.
>>
>> This parameter allows to configure the autonomous mode on all CPUs
>> without requiring runtime sysfs manipulation if the 'auto_sel' register
>> is present.
>>
>> When auto_sel_mode=1:
>> - All CPUs are configured for autonomous operation during module init
>> - EPP is set to performance preference (0x0) by default
>> - Min/max performance bounds use defaults
>> - CPU frequency scaling is handled by hardware instead of OS governor
>>
>> For Documentation/:
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>   drivers/cpufreq/cppc_cpufreq.c                | 197 +++++++++++++++---
>>   2 files changed, 182 insertions(+), 27 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b8f8f5d74093..048f84008a7e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -929,6 +929,18 @@
>>                        Format:
>>                        <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance selection.
>> +                     When enabled, hardware automatically adjusts CPU frequency
>> +                     on all CPUs based on workload demands. In Autonomous mode,
>> +                     Energy Performance Preference(EPP) hints guide hardware
>> +                     toward performance(0x0) or energy efficiency (0xff).
>> +                     Requires ACPI CPPC autonomous selection register support.
>> +                     Format: <bool>
>> +                     Default: 0 (disabled)
>> +                     0: use cpufreq governors
>> +                     1: enable if supoorted by hardware
>> +
>>        cpuidle.off=1   [CPU_IDLE]
>>                        disable the cpuidle sub-system
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index d1b44beaddda..0a55ab011317 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,8 +28,12 @@
>>   #include <acpi/cppc_acpi.h>
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>> +
>>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>
>> +/* Autonomous Selection */
>> +static bool auto_sel_mode;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>        freqs.old = policy->cur;
>>        freqs.new = target_freq;
>>
>> +     /*
>> +      * In autonomous selection mode, hardware handles frequency scaling directly
>> +      * based on workload and EPP hints. So, skip the OS frequency set requests.
>> +      */
>>        cpufreq_freq_transition_begin(policy, &freqs);
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (!cpu_data->perf_caps.auto_sel)
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> "When Autonomous Selection is enabled, it is not necessary for OSPM to assess
> processor workload performance demand and convey a corresponding performance
> delivery request to the platform via the Desired Register. If the Desired
> Performance Register exists, OSPM may provide an explicit performance
> requirement hint to the platform by writing a non-zero value."
>
> Therefore I believe it's up to the platform to decide if it wants to use
> the software hint.

Ok, will remove the check in v5.


>>        cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>
>>        if (ret)
>> @@ -565,6 +574,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>                goto free_mask;
>>        }
>>
>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret) {
>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
>> +             goto free_mask;
>> +     }
>> +
> This belongs to patch 2/8.

will move in v5.

>
>>        return cpu_data;
>>
>>   free_mask:
>> @@ -666,11 +681,81 @@ static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>>        return 0;
>>   }
>>
>> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy *policy, u32 epp)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     pr_debug("cpu%d, epp curr:%u, new:%u\n", cpu, cpu_data->perf_ctrls.energy_perf, epp);
>> +
>> +     guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>> +
>> +     ret = cppc_set_epp(cpu, epp);
>> +     if (ret) {
>> +             pr_warn("failed to set energy_perf for cpu:%d (%d)\n", cpu, ret);
>> +             return ret;
>> +     }
>> +     cpu_data->perf_ctrls.energy_perf = epp;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection configuration
>> + * @policy: cpufreq policy for the CPU
>> + * @min_perf: minimum performance value to set
>> + * @max_perf: maximum performance value to set
>> + * @auto_sel: autonomous selection mode enable/disable (also controls min/max perf reg updates)
>> + * @epp_val: energy performance preference value
>> + * @update_epp: whether to update EPP register
>> + * @update_policy: whether to update policy constraints
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>> +                                           u64 min_perf, u64 max_perf, bool auto_sel,
>> +                                           u32 epp_val, bool update_epp, bool update_policy)
>> +{
>> +     const unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     /*
>> +      * Set min/max performance registers and update policy constraints.
>> +      *   When enabling: update both registers and policy.
>> +      *   When disabling: update policy only.
>> +      * Continue even if min/max are not supported, as EPP and autosel
>> +      * might still be supported.
>> +      */
>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, update_policy);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             return ret;
>> +
>> +     if (update_epp) {
>> +             ret = cppc_cpufreq_update_epp_val(policy, epp_val);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
>> +     if (ret)
>> +             return ret;
>> +
>> +     pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", min_perf, max_perf, cpu);
>> +
>> +     return 0;
>> +}
> I think cppc_cpufreq_update_auto_select() can be removed and
> cppc_cpufreq_update_autosel_config() used in its place.
>
> cppc_cpufreq_update_autosel_config() would not even need min/max as
> arguments as they can be obtained from perf_caps (low/nominal range)
> or perf_ctrls (current min/max). This would also simplify
> cppc_cpufreq_cpu_init().

Will change in v5.


>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>        unsigned int cpu = policy->cpu;
>>        struct cppc_cpudata *cpu_data;
>>        struct cppc_perf_caps *caps;
>> +     u64 min_perf, max_perf;
>>        int ret;
>>
>>        cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>        cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     if (cpu_data->perf_caps.auto_sel) {
>> +             ret = cppc_set_enable(cpu, true);
> Isn't auto-sel enabled at this point? Also, if the auto-sel is
> ACPI_TYPE_INTEGER, cppc_set_enable() will return an error,
> isn't it?

Do you mean CPPC enable rather than auto-sel?
Some platforms may require the Kernel to explicitly set the CPPC Enable
register which is of type ACPI_TYPE_BUFFER. I will add error handling for
cases where this register is not supported, not visible, or is read-only of
ACPI_TYPE_INTEGER to the Kernel.

>> +             if (ret) {
>> +                     pr_err("Failed to enable CPPC on cpu%d (%d)\n", cpu, ret);
>> +                     goto out;
> Do you really want to bail out of the rest of the cpufreq CPU
> initialisation, if only auto-select configuration fails?

Will do the change  in v5.


>> +             }
>> +
>> +             min_perf = cpu_data->perf_ctrls.min_perf ?
>> +                        cpu_data->perf_ctrls.min_perf : caps->lowest_nonlinear_perf;
>> +             max_perf = cpu_data->perf_ctrls.max_perf ?
>> +                        cpu_data->perf_ctrls.max_perf : caps->nominal_perf;
>> +
>> +             ret = cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, true,
>> +                                                      CPPC_EPP_PERFORMANCE_PREF, true, false);
>> +             if (ret) {
>> +                     cppc_set_enable(cpu, false);
>> +                     goto out;
>> +             }
>> +     } else {
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>        }
>>
>>        cppc_cpufreq_cpu_fie_init(policy);
>> @@ -910,7 +1015,6 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>        u64 min_perf = caps->lowest_nonlinear_perf;
>>        u64 max_perf = caps->nominal_perf;
>> -     int ret;
>>
>>        if (enable) {
>>                if (cpu_data->perf_ctrls.min_perf)
>> @@ -919,26 +1023,8 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>>                        max_perf = cpu_data->perf_ctrls.max_perf;
>>        }
>>
>> -     /*
>> -      * Set min/max performance registers and update policy constraints.
>> -      *   When enabling: update both registers and policy.
>> -      *   When disabling: update policy only.
>> -      * Continue even if min/max are not supported, as EPP and autosel
>> -      * might still be supported.
>> -      */
>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
>> -     if (ret && ret != -EOPNOTSUPP)
>> -             return ret;
>> -
>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
>> -     if (ret && ret != -EOPNOTSUPP)
>> -             return ret;
>> -
>> -     ret = cppc_cpufreq_update_autosel_val(policy, enable);
>> -     if (ret)
>> -             return ret;
>> -
>> -     return 0;
>> +     return cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, enable,
>> +                                               0, false, true);
>>   }
>>
>>   static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
>> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .name = "cppc_cpufreq",
>>   };
>>
>> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
>> +{
>> +     int cpu, ret;
>> +
>> +     for_each_present_cpu(cpu) {
>> +             ret = cppc_set_epp(cpu, epp);
>> +             if (ret) {
>> +                     pr_warn("Failed to set EPP on CPU%d (%d)\n", cpu, ret);
>> +                     goto disable_all;
>> +             }
>> +
>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>> +             if (ret) {
>> +                     pr_warn("Failed to set auto_sel on CPU%d (%d)\n", cpu, ret);
>> +                     goto disable_all;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +
>> +disable_all:
>> +     pr_warn("Disabling auto_sel for all CPUs\n");
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>> +
>> +     return -EIO;
>> +}
>> +
>>   static int __init cppc_cpufreq_init(void)
>>   {
>> +     bool auto_sel;
>>        int ret;
>>
>>        if (!acpi_cpc_valid())
>>                return -ENODEV;
>>
>> +     if (auto_sel_mode) {
>> +             /*
>> +              * Check if autonomous selection is supported by testing CPU 0.
>> +              * If supported, enable autonomous mode on all CPUs.
>> +              */
>> +             ret = cppc_get_auto_sel(0, &auto_sel);
>> +             if (!ret) {
>> +                     pr_info("Enabling auto_sel_mode (autonomous selection mode)\n");
>> +                     ret = cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
>> +                     if (ret) {
>> +                             pr_warn("Disabling auto_sel_mode, fallback to standard\n");
>> +                             auto_sel_mode = false;
>> +                     }
>> +             } else {
>> +                     pr_warn("Disabling auto_sel_mode as not supported by hardware\n");
>> +                     auto_sel_mode = false;
>> +             }
>> +     }
>> +
> Why not check at cppc_cpufreq_cpu_init? In the unlikely case that one
> CPU does not support it, I would recommend to issue a warning, rather
> than disable auto-sel on all the other CPUs. It is possible that some
> CPUs support auto-sel and they have it enabled by default without
> exposing that control to the OS.

Will move to cppc_cpufreq_cpu_init in v5.

Thank you,
Sumit Gupta


>>        cppc_freq_invariance_init();
>>        populate_efficiency_class();
>>
>> @@ -1165,10 +1299,19 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> +     int cpu;
>> +
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>> +     auto_sel_mode = false;
>> +
>>        cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>        cppc_freq_invariance_exit();
>>   }
>>
>> +module_param(auto_sel_mode, bool, 0000);
>> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
>> +
>>   module_exit(cppc_cpufreq_exit);
>>   MODULE_AUTHOR("Ashwin Chaugule");
>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
>> --
>> 2.34.1
>>

