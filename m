Return-Path: <linux-acpi+bounces-18847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F1C5568A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 03:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24D8D4E2840
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D06C2F6176;
	Thu, 13 Nov 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="geIiZjsr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117C2F5A1E;
	Thu, 13 Nov 2025 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000211; cv=fail; b=DoDKu6R0vGikaale2AUfnVkYiqsX7U7Swdcfjd3OqjqKKRsohN1ZcHzyOPhuyIUJjgVlFd2Vim1vl+TYGZV4o6qKw7Qwp726jvIKdnsNYH0Jcgn4iWqFsmvN7rqI4Ii/3ZEDQesDwQ9VePkP0xtbyAg3EoYOlS2NyY41h3cZrs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000211; c=relaxed/simple;
	bh=YbV7qloRQUmSoAhqU85ZWTc8ooxy/uPqxEw24hAjtek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8iC/yEFkO3odH41Z8Jol9pvbQWHgWQ352Nxhj4AyyMqx3rHxYqEasgzjv0HoH6L1e9pANtc/O8n3w6Ug74czxFjpxVWf1N86/T7pN9YO35zSxWsvk2qeShvF64gr6/UmNnqJC7yraiyycxwe/JjoMwHYQmrOttfgzcGM9/kY+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=geIiZjsr; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhLgGJnb7O+DalUr8qHUkrVapxJ6pJ5b3Ge4vZBh2lxl34n6Ib9ARfeuW4q7qfJddgxuJt+n+dUV1btzHjUYDS/a00qAlsMfcHNjlsJD8370yPk9GSaJWJvjt1jYYDC4w4+ldWyprn2Opt+almiEPAQDK0iqtrhJaHQsZui9oxSA1dSBkFc08q+nnJgfyaM6JDTRNXjyRMFoRpmVSL9/gwoNgYQHeHwKcRnQ9tTOImsLSyTUy56AKJGomlhayxXBFjErDLP/XczA7Iq8Vl5/tJg7A4vkXRy+pFizW7WmbuTYcuWa4mABIDxwZVO69FZ4WIST/zhvmKEDTOl23QAECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccCL9kUFI/exe7WnYrHYuH+t8oYeJ/H1e0Pae5POy/8=;
 b=T6XxG9Rv3P3aLu2O9a0oPR8jZRNZtU1kHcOu2EMB8GQ9OynjY703P6MaNnOhZX2507ZWuYBXsKskk+7MJOn4bGtJV2RfLMKg+U+kTYwNDWEsjOf0lJkmb5VZpt1X/bd3ySdPIA7h1JIL8+iNYku7/X5rcvjcMYCzEX6hpL2MBjlP+f6j/uVVH8PhzTs/r6fgDlO2iw94WS0hCIlLxp9Gnjsph822reYaZRHK0cXFRvsUR4LbiO9xn7U+Ji8OD9X3t+Rqi5hxwvGT6XnME2FFYrneBrpuG5rI4QUj6+5aeuatsNTgzyhmcPE4mByKNg9Y5aJ4u+TJXCxpwXZVtl5rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccCL9kUFI/exe7WnYrHYuH+t8oYeJ/H1e0Pae5POy/8=;
 b=geIiZjsr7PYmpi/ltlND3Aks9FCqOx0LSj3H/b80c8cJphdZRfH2J4nZeqxn5vKztr2YRgWYqKefJq7sHz1X1c5bJ1LutDvSINHRKFcxMWJq0FapvxErhu4T7MZC8R0EEm3FJ6YrANcLGqC7EIQzxiioK15uD10qjjg1Ml9/8DcJIqXGjcY4nyxgslxJVOyOo+BqbhrInDwY4/9b8cShoVsb112PQQCaR/YMrFJcOSDWF8gojqdT2wOzSHatrx7Z/sil2qXYatF5Dp5UACV/0o/UOgyRM4J+/kMMEi3o+fgJ1ExX+WqWaE7HT8Fi9z56Vjc1MAtdUVSpwxvmUv3Fyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Thu, 13 Nov 2025 02:16:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 02:16:44 +0000
Message-ID: <26396142-4f14-4175-85ba-2e8d780abbd9@nvidia.com>
Date: Wed, 12 Nov 2025 18:16:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-10-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a88385a-055d-4086-a0fd-08de225ab0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZnSTFDdmFmMnBjdGNwbm9wbktibENnVTRxN3RSYS9MQUNTUFJ2Tjcxajky?=
 =?utf-8?B?dDEwdEZXVm1NTWRXdHl0byt3YnlyazQ3eHAranpWSUxReWFMSjhlVlloMndw?=
 =?utf-8?B?RGhHK2hiNXVHZENBS29EZnpJM1FaaUJpeFFLamg5VkZNY3oxWEJDdDBaeXY1?=
 =?utf-8?B?ZzJjWlYzVWZ6Zy9SVmwvZmV2clBaaEl5bG5ibFM4VUh3TWx6TWx5Mk5jOEgr?=
 =?utf-8?B?MGpmQ3I2dFEyTmxPZEc2WStveDM2Uk1uZ29OR1F6a1A1QzJxRHJxeEF3cndD?=
 =?utf-8?B?ZXBHU1QvZnFvZm9NclJQU0JZMnFnaTNqRkRFOXlmcWRVYzdLU2txSEpFLzky?=
 =?utf-8?B?UUZKdzRsa08vRzFpb05SZFhxdXVublZGaWJ5TTJEeGlOK1JURy9vbk5ucUl5?=
 =?utf-8?B?bkVJNlEzOEZXTGQ0UXRZajhrTXJXVEZyYmJnTTdQUzdNV3gvRU1TeFdob0Yv?=
 =?utf-8?B?QUx2K09jZkx1MFdEWHU2MG5mTC9ZZlJiRzd2RGJsaGVWalExK1M2cjN6RGNs?=
 =?utf-8?B?YVppMDQyYjNmN2JBTmZVQmtTNExlYWovRHZYQUdFeU5MdHhCZmdjeEo3a1hv?=
 =?utf-8?B?UUllWFVLcUVRandvQWFEMXFnNEc5dFBxenBidXJYOEJHMktyYlJ2aXd5aVpS?=
 =?utf-8?B?Tk9iOHNzNm9DU3U1amJWcjkzSVMvN3dNN05PNS8xdnB4eWlJSll0VWlmOUE2?=
 =?utf-8?B?VC9oaHlqMkxCSVZFMWJsVm1RdDlmWHY5SVRPM3J3MlR0VkIrSDhRTDczMEVr?=
 =?utf-8?B?MHJKR1JSbWVvSlNYWTUxNU42OHdMQ25zZ3BiRUxJY1RhU3NEMGNQb3hmNHJ3?=
 =?utf-8?B?UTM3dzdYbHZqYUphbnc2OVJtVk1uWEtXNnZ3SXI0NTUwSjdZeW5UU2lWYzAw?=
 =?utf-8?B?MFRtZlM0TXpMa3JFaFdFRlZWakZ6K2R6TFBNaU8yYUZTQW5uaU12WGdHVU1I?=
 =?utf-8?B?U0s5ejFreGNlYTRrUW1ZSDl4cjVUN3NEWEI1bXZ0MEFxb29sQ1daYzUzbU1P?=
 =?utf-8?B?aHBpV25zWnpETTh2Ly9sUUlMUU1XZXlrVXU1SGVtWXdtZ1lzMlo5aVFsTTlK?=
 =?utf-8?B?aXpVT09SeEZzRUhya2tiNHlDQUtkMkFZd2F4VGxqc3pSbG54dGhvWExHUVd1?=
 =?utf-8?B?UzRSOGxPcktzMWJmeHhTeUxqenMwVHVBVnVlVFMvVzNQMVdJLyt0OVllWUlG?=
 =?utf-8?B?MkhoaC9iZzN5TDlmQVBEZzBnK1JuMHhuRVVGYm5wb1pDUlgxc0srM1dibU1Z?=
 =?utf-8?B?aG5aMFpwcjllanZkSFlkSHppaUhnRmkxNVYwWkI1Y3BVWkhkQkVOeTBjTEFm?=
 =?utf-8?B?anM3eDFTWWswWDVnVWhLVzZUajhNYzI3bkpKVXhTd1RrMExBdTZ5VURBSEY0?=
 =?utf-8?B?YmEvZmFPeEc2bklnYVdYMkNjTnJTS2lzb3FocmlYWUxxK3VBV2xsTTV5dkRB?=
 =?utf-8?B?cWhxRDVPZ2JFc0NMS2svSERBZllzeVdiOWdhWVRhY0dkMzd2WVNGVng1T2Vt?=
 =?utf-8?B?bVM4NVZVVldORFRKZEF3Qy95KzV6QmJGdE9YQlBiOWhNRDhTdHBtVTc4ckVL?=
 =?utf-8?B?QzR4dE50TDdCbW5tcUJRNmoySWNMOVFueWtYMVlRSW14T1hMVjMyVVR6Z2Yr?=
 =?utf-8?B?VzhnWEJ6bkkwOUFWWTViY2puazh1ZTQxUHpVdzJpUXdwd3NPWDlTYkk5NDVF?=
 =?utf-8?B?WGR2Zzh2bWlYc3pHdFhEelFJOGFIVitPaURmSExwb0EyVFN2Z1NHRmV5Y1R3?=
 =?utf-8?B?TG1iYVQ4S1Z3Y1FhU3FtaE9HblhTU1FXNTV6cGdPVGg2RXdpQ05QWGx1cHor?=
 =?utf-8?B?ci9FTWRSWVRPTG9oVlJEeE8rSTlLMWRWTG5lODZkV3B4OE9nSlpUUU1kMm4x?=
 =?utf-8?B?NjBicTFMSTh0WDZNNlBTeURCemlxaURxSGUrcXo1dFRsaEUyL0NxZDhtSUk4?=
 =?utf-8?B?REwydURsOHBPUnJENHdYM1hYM2JPeGFBYjhPL1NVTHFwRkYyR1dGTDVJZld4?=
 =?utf-8?B?ZVFzelA3OVdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmJYZUJRZ3N5K29sQVhGNEwwaGJDdFdNY1dvaHVPejVKVlk2aU9FN3ZUamp1?=
 =?utf-8?B?M1M2VmVSTXdPYVdXOFpmUTEvaHhHSldrNlNBQm9uZUlUY0FxYUpDdVZMeHdD?=
 =?utf-8?B?NFJDR1VpSzJzWG1nWG13Vk9vM04zS210eTBXVE5Ydm5ERU5sNVgwTS9DUkpi?=
 =?utf-8?B?Y080elJQOWRoM2FJcEpEL3lrandZNWRxeVQzY2dLdUxndVR5ZGtucDI0V3pC?=
 =?utf-8?B?enBjNXFrODlPK3JWSENxNmpWaEtKSFZOQnZEVzFxdWpwNHI2OHlnRW1WMU0z?=
 =?utf-8?B?V3VYc0c3YnhaeVMvMmpJdkVmNm5hY2tpcTh2b0I1L0JiOExhSTVpR1BFQ1Jh?=
 =?utf-8?B?c3BwbUFkdHNhNEpDMkpnQytyV0tHR2VaNkFSQUo5ZVRRQmdhN2VLbmdGbk5W?=
 =?utf-8?B?UklLazRGK0liVVFLa3lFb1ZVLzBFNC82dmEvbWo0dzNiL3JOSzdkVlFLVm9v?=
 =?utf-8?B?cGFsVERGYS8rdGtkRjhYZVBhSE5ZZFN5emNma2RhWDBkekhiN2ZtNmk1c3Mw?=
 =?utf-8?B?ZXNNZ2xiejV2TnZKV2VSOU9uQmFTWFMwdEdFMVZxdW1lQkJjYmVqc0ZJSFh5?=
 =?utf-8?B?aklkMXZLTHUyMXlWUXI3ekdBejhEbzhHWHJJUkhWMXJ1UW9qdWRKdDRWZE4r?=
 =?utf-8?B?VFlHeHMreTRrYm04T3JwR05qcUlNSCsrQW5MTVREdEM5ZHlkbUljSTdKeGt3?=
 =?utf-8?B?WWZGSXF5MjcxVnI0emtxNVZBMlNHaG9ZYWZjVkhCc1pEK1h4VkxlTEloVEVn?=
 =?utf-8?B?ajAxRDJpYjFMeU4va2NOSWtvS1I5UVRBdjN1YnR5NjNBNGkzeWhpNmlta1Fj?=
 =?utf-8?B?N1ZteU1GRkFWL1lpNklwMDhjODZyZXNJbFFDRW52SnBUZlFaSlFYSG5ORHpK?=
 =?utf-8?B?TjQ0aWQxSWVUcXhVSHNTWFk2WkF6VllwS3F1TWtFbkxjNGo3TStiUmQ2V3gx?=
 =?utf-8?B?bVpRRE00R2ZvSEhuRjJOYVN4ZStYYm9rOFUzRks3WGJkcjREV2pRVDV3NmRO?=
 =?utf-8?B?ZmhhcjQ4eUZGZVRBWHVBYXU1OHVPckxKWUI0SlZzcWlpV25rOGsvSzkzbEpC?=
 =?utf-8?B?NElCZHkwb2Q3MTZJUk9ZYTM5SVdBMDQ0eUczMFlCS1VkWm1YdnVhMlNPcHcv?=
 =?utf-8?B?bTFnRzd1ekozbXJHQnp2dzFlblRPWmNLczRMck9UbU5QWmlLaDBCaWNOMm9S?=
 =?utf-8?B?eGEwMVJsWmZ3SVlFemhid24yWEFtZEVnaE5NbVgwcXZyMUhhb3dxNk5TZ3pX?=
 =?utf-8?B?amd4SGNibXJ5U1VpSC9YSmkyQ0U0MGs1WEY0YlZ1bGRvM0IyOEJwajBxU05h?=
 =?utf-8?B?S1Fid0JQUU9DZ3MrcTc3d0I2dXJBbW00MG9jOE50RDl1V0RHNDhadnAra0Zs?=
 =?utf-8?B?cFgvdXBkQWp1UTE1MU5rYzNnT1RQZE5JZStTVnhBSkJtRGlBbnIxaGhqVDdB?=
 =?utf-8?B?emZQVnRjclg5NFFzaFJ5bXA1bkJOaDdpUWhPVlRCaC9makN0dUk5VmRsdS9L?=
 =?utf-8?B?ZElWTzljcHM4aWpkNG9jbDVkMEx5cTlSZW9SaE85bFYzQ1EwKytxMGJ4d1FH?=
 =?utf-8?B?Y1ZSMGlqNnU1Q3hqTUZQZWVpeER2U1JzSFplMEdtWVdaNjNvVlFFT1U2em94?=
 =?utf-8?B?eUg5aXdxSVUvVWw5bWtvYmdDc2xHeDdnUHh2dE1mYkQwVTNkbUdGVW5QRkJo?=
 =?utf-8?B?Y3BSaHkvTnNHL3hXbGxTMkhWR05sSHNRaGlRWDl0bXJNcE1oSlNnUzdzNUhy?=
 =?utf-8?B?NnRGMUw0OTF4Z0E5QmZ3c2xGU2V1bThzZkNVMkQvRnZnVFdNVDFGRkU1TzNG?=
 =?utf-8?B?RmtFNm9leHpIUFRubFBqbHBnUlhURXZiU0dXa2dnaFFFT0xzWnFic2xmZkxU?=
 =?utf-8?B?SUR5QWVuQTc3aGptakhEckZ4Z29VaDFhd0NrbG16R2hkK2J3STAwZUZ1Nm16?=
 =?utf-8?B?WEliWEp3WWVMVXlkeENWaE96RXRld0hlVW1scUg2VDBrS2U3TW9MNjBwWnA3?=
 =?utf-8?B?anF5SitIUHNzSVcrK0RTOTJ5TkdMdVJ5ZWFvaWhwVDZnQ0FjdlRrWEtGVFF3?=
 =?utf-8?B?NDIvWTlOT1kzbFM3Y1E4S1FtRms1S2lYN2g0NWJpa0RFYmxFRnZoTGFpZ01s?=
 =?utf-8?Q?vVw34G07uibHdem62L8HdkfDO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a88385a-055d-4086-a0fd-08de225ab0d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 02:16:44.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3o3yr6ca4xwDMTGvWj0LwjrGbtYcYCY+Lh5sEKYtmOOwb8a5kIDvnH/lYlRQDPCEdoZ1F2FY6BFs6eiwjwQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

Hi, Ben and James,

On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> This happens in two stages. Platform devices are created first for the
> MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
> to discover the RIS entries the MSC contains.
> 
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data about the RIS entries.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> return irq from acpi_mpam_register_irq (Jonathan)
> err -> len rename (Jonathan)
> Move table initialisation after checking (Jonathan)
> Add sanity checking in acpi_mpam_count_msc() (Jonathan)
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/mpam.c   | 403 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/tables.c       |   2 +-
>   include/linux/arm_mpam.h    |  47 +++++
>   6 files changed, 456 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/acpi/arm64/mpam.c
>   create mode 100644 include/linux/arm_mpam.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 67015d51f7b5..c5e66d5d72cd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
>   
>   config ARM64_MPAM
>   	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>   	help
>   	  Memory System Resource Partitioning and Monitoring (MPAM) is an
>   	  optional extension to the Arm architecture that allows each
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>   
>   config ACPI_APMT
>   	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ACPI_FFH)		+= ffh.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
>   obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>   obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..c199944862ed
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/*
> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE                              BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                         GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                        0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK                BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR           0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER 1
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID                    BIT(4)
> +
> +/*
> + * Encodings for the MSC node body interface type field.
> + * See 2.1 MPAM MSC node, Table 4 of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IFACE_MMIO   0x00
> +#define ACPI_MPAM_MSC_IFACE_PCC    0x0a
> +
> +static bool _is_ppi_partition(u32 flags)
> +{
> +	u32 aff_type, is_ppi;
> +	bool ret;
> +
> +	is_ppi = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_VALID, flags);
> +	if (!is_ppi)
> +		return false;
> +
> +	aff_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK, flags);
> +	ret = (aff_type == ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER);
> +	if (ret)
> +		pr_err_once("Partitioned interrupts not supported\n");
> +
> +	return ret;
> +}
> +
> +static int acpi_mpam_register_irq(struct platform_device *pdev,
> +				  int intid, u32 flags)
> +{
> +	int irq;
> +	u32 int_type;
> +	int trigger;
> +
> +	if (!intid)
> +		return -EINVAL;
> +
> +	if (_is_ppi_partition(flags))
> +		return -EINVAL;
> +
> +	trigger = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE, flags);
> +	int_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags);
> +	if (int_type != ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return -EINVAL;
> +
> +	irq = acpi_register_gsi(&pdev->dev, intid, trigger, ACPI_ACTIVE_HIGH);
> +	if (irq <= 0)
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n", intid);
> +
> +	return irq;
> +}
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx)
> +{
> +	u32 flags, intid;
> +	int irq;
> +
> +	intid = tbl_msc->overflow_interrupt;
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	irq = acpi_mpam_register_irq(pdev, intid, flags);
> +	if (irq > 0)
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
> +
> +	intid = tbl_msc->error_interrupt;
> +	flags = tbl_msc->error_interrupt_flags;
> +	irq = acpi_mpam_register_irq(pdev, intid, flags);
> +	if (irq > 0)
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
> +}
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res)
> +{
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id = res->locator.cache_locator.cache_reference;
> +		level = find_acpi_cache_level_from_id(cache_id);
> +		if (level <= 0) {
> +			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid == NUMA_NO_NODE) {
> +			pr_debug("Bad proxmity domain %lld, using node 0 instead\n",

Typo.
s/proxmity/proximity/

> +				 res->locator.memory_locator.proximity_domain);
> +			nid = 0;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
> +				       255, nid);
> +	default:
> +		/* These get discovered later and are treated as unknown */
> +		return 0;
> +	}
> +}
> +
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	int i, err;
> +	char *ptr, *table_end;
> +	struct acpi_mpam_resource_node *resource;
> +
> +	ptr = (char *)(tbl_msc + 1);
> +	table_end = ptr + tbl_msc->length;

tbl_msc->length equals size of the ENTIRE msc node. ptr points to the 
end of tbl_msc. ptr + tbl_msc->length is past the end of the msc node. 
This will access data outside of this MSC node.

Better to change to:
+	table_end = (char *)tbl_msc + tbl_msc->length;

> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
> +		u64 max_deps, remaining_table;
> +
> +		if (ptr + sizeof(*resource) > table_end)
> +			return -EINVAL;
> +
> +		resource = (struct acpi_mpam_resource_node *)ptr;
> +
> +		remaining_table = table_end - ptr;
> +		max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
> +		if (resource->num_functional_deps > max_deps) {
> +			pr_debug("MSC has impossible number of functional dependencies\n");
> +			return -EINVAL;
> +		}
> +
> +		err = acpi_mpam_parse_resource(msc, resource);
> +		if (err)
> +			return err;
> +
> +		ptr += sizeof(*resource);
> +		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Creates the device power management link and returns true if the
> + * acpi id is valid and usable for cpu affinity.  This is the case
> + * when the linked device is a processor or a processor container.
> + */
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] = { 0 };
> +	bool acpi_id_valid = false;
> +	struct acpi_device *buddy;
> +	char uid[11];
> +	int len;
> +
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));
> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id = tbl_msc->instance_id_linked_device;
> +		acpi_id_valid = true;
> +	}
> +
> +	len = snprintf(uid, sizeof(uid), "%u",
> +		       tbl_msc->instance_id_linked_device);
> +	if (len >= sizeof(uid)) {
> +		pr_debug("Failed to convert uid of device for power management.");
> +		return acpi_id_valid;
> +	}
> +
> +	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
> +	if (buddy)
> +		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);

Refcount leak here?

Refcount of the device object pointed by buddy is not released and 
refcount leaks.

Better to change to:
+	if (buddy) {
+		device_link_add(...);
+		acpi_dev_put(buddy);  <====== release refcount here
+	}

or free refcount automatically:
+DEFINE_FREE(acpi_dev_put, struct acpi_device *, if (_T) acpi_dev_put(_T))
...
+	struct acpi_device *buddy __free(acpi_dev_put);
...

> +
> +	return acpi_id_valid;
> +}
> +
> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
> +				 enum mpam_msc_iface *iface)
> +{
> +	switch (tbl_msc->interface_type) {
> +	case ACPI_MPAM_MSC_IFACE_MMIO:
> +		*iface = MPAM_IFACE_MMIO;
> +		return 0;
> +	case ACPI_MPAM_MSC_IFACE_PCC:
> +		*iface = MPAM_IFACE_PCC;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	struct platform_device *pdev __free(platform_device_put) =
> +		platform_device_alloc("mpam_msc", tbl_msc->identifier);
> +	int next_res = 0, next_prop = 0, err;
> +	/* pcc, nrdy, affinity and a sentinel */
> +	struct property_entry props[4] = { 0 };
> +	/* mmio, 2xirq, no sentinel. */
> +	struct resource res[3] = { 0 };
> +	struct acpi_device *companion;
> +	enum mpam_msc_iface iface;
> +	char uid[16];
> +	u32 acpi_id;
> +
> +	if (!pdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Some power management is described in the namespace: */
> +	err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
> +	if (err > 0 && err < sizeof(uid)) {
> +		companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
> +		if (companion)
> +			ACPI_COMPANION_SET(&pdev->dev, companion);

Ditto. companion's refcount leak here as well?

> +		else
> +			pr_debug("MSC.%u: missing namespace entry\n",
> +				 tbl_msc->identifier);
> +	}
> +
> +	if (decode_interface_type(tbl_msc, &iface)) {
> +		pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (iface == MPAM_IFACE_MMIO)
> +		res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
> +						       tbl_msc->mmio_size,
> +						       "MPAM:MSC");
> +	else if (iface == MPAM_IFACE_PCC)
> +		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> +							tbl_msc->base_address);
> +
> +	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> +
> +	WARN_ON_ONCE(next_res > ARRAY_SIZE(res));

Not sure if this WARN_ON_ONCE() is really helpful.

Even before this WARN happens, previously res[next_res] accesseing 
outside of res[] may hit panic or data corruption already.

Maybe it's better to add a helper to access res[] and report error when 
accessing out of res[] scope. A few places can call the helper to access 
res[]:

+static int add_resource(struct resource *res, int *idx, int max,
+			struct resource new_res)
+{
+	if (*idx >= max) {
+		pr_err("Too many resources (max %d)\n", max);
+		return -ENOSPC;
+	}
+	res[(*idx)++] = new_res;
+	return 0;
+}

Then can call the helper to replace res[next_res++]:
+	if (iface == MPAM_IFACE_MMIO) {
+		err = add_resource(res, &next_res, ARRAY_SIZE(res),
+			     DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
+						       tbl_msc, +							mmio_size,
+						       "MPAM:MSC"));
+		if (err)
+			return ERR_PTR(-ENOSPC);
+	}

> +	err = platform_device_add_resources(pdev, res, next_res);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
> +						tbl_msc->max_nrdy_usec);
> +
> +	/*
> +	 * The MSC's CPU affinity is described via its linked power
> +	 * management device, but only if it points at a Processor or
> +	 * Processor Container.
> +	 */
> +	if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id))
> +		props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity", acpi_id);
> +
> +	WARN_ON_ONCE(next_prop > ARRAY_SIZE(props));

Ditto for this WARN here?

[SNIP]

Thanks.

-Fenghua

