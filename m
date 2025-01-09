Return-Path: <linux-acpi+bounces-10477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D15A07DBD
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A218897F1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2D1223702;
	Thu,  9 Jan 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZZ5HUvf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D32236F8;
	Thu,  9 Jan 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440583; cv=fail; b=cHnxQVXUWMb0tQsAhQYS4fcD/aM+OG2TN/1Tj0fG4C0O9Rrpd3ECUwDk3gOfCQF7e0NOlTMnpc/OkYk58q9r4z5A6ly0+vmysq6z9JW4Q6HytIufwsy2LkZC5/ascRsxil3c+r10Xne6LZXsHCP9lWm4mg9fZcSGWXyQfArThDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440583; c=relaxed/simple;
	bh=eWMRZSc7/9hLWUcNZtVfmyj4TRqydjJyDw523MnR/dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXdhxuac/gFNORKc0zvkCOUjbq/0zz4vAAvYNR33SGWS6BDsecfiZCiqkhB6FbTaMjzD36HFVF3AGL8oR4xsbUjxCD/9BvKfyLm9anoh7YI6s/RZaACrO4jI56EDj/ibtqPRY/YKYxvx5LYUrxHlT7l0AwkzwiJeVr/2lnADISM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZZ5HUvf; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCSYxWEoJVYB1tg06TTrW8D+9LjFnf+7xv09aDR24h1zNiHmTdB7yA1Y+MSdZ5BXbx65tGxzYpIOGgftzTV9Q+2AgsYgc6DE5nSrr17ticLayad1vgL0iRmtr7aSvh9PlX//9sP3vynjvk9GjP6FNUlPfXgUjX0JnqK+he3Ge3J7+JGkmwObOKX9zkiy+lpYh8EX14dmj0BL5ckEsiL5epib/bhclA9D46rGC6ipkiC0t2h1olokpu5cpAYeaxvC6quv4GP94qZh5aY0Zise2OdiRZt5S2lvUc4KGmGxpU1s0zgNhsEpszs9XyJbTIMo3vGzIkyFEoGMJdOWcRmSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuD9p91OURq/UQjG4tpFinS/LtjDDKhpQpsaRvxeifY=;
 b=GIsEj7VGP6KiS8dHX8f6qougo3nN8a7SHhOSkagqsI27qsbyUn2xY+G3hZxHVQXAJFyf1ClEUJ4sM/17IT145P9Dv/K2uG/+jwCd1YpfQg7yklLhvhcceh9r1oT1kszC+oj/NaUcEznSJXE69+E1G24Lxd6MXvYOFVflS/c9WwLzv4JzrEWIjLX0LUDSYVE4hswUgodFdIxkL+8RSzs3z+jB3ep4zKQyyfwn60GxD4vF1PwbYkFPXsx7PokPekTl4iwbeudEbiTUhXnf4IdN55pRXV1t/YAg9df/4b5KonHQ9+YmcTIuUrrMTR/6g0oZLwgAJ27eFwjxtPLgQyMTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuD9p91OURq/UQjG4tpFinS/LtjDDKhpQpsaRvxeifY=;
 b=zZZ5HUvfqKFPjzUglZ7TBxTDsQtN8ue+gRJMyOho+ysYO7dbk/YaFC8rqW/omjPpawPm9oKZkf5ZKMlUOGxBJQrnuLFd975nOu09gOLFwYLJD21SRk4Tnh7yqMULpkI+XZ4A1sRB+Le3gW2Ns4rBVZbuJ7MdvBghTu8v0smF4aQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:18 +0000
Message-ID: <da9494a3-8f8a-44f3-b849-eb24b7564eec@amd.com>
Date: Thu, 9 Jan 2025 10:36:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] platform/x86: amd: pmf: sps: Use
 devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-8-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-8-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 20592069-2680-4cbb-bbc5-08dd30cbbe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnZaV2lWRHhweXIwWGJTd0ZheVZhTlJ6b08yR1B4bnp6SUplUDg0VTMya3FU?=
 =?utf-8?B?SW1WZGJGMWY2MkZqakRuSEVWa2swQVZIQ25DUjFnNjd3dFZMQ0hkMktyZGd0?=
 =?utf-8?B?NmNLa3JmeFVFNzBrZHpjcUJPU1BrWUoxb3U5YWgyNGlNcWYwUTVFOXo2REU0?=
 =?utf-8?B?NFcrLzlOeEJiVnhXcW9uejROdVpGbTVpUmt0ODZCMTU2NksyY09ONXVpRGJL?=
 =?utf-8?B?M3BZd1BwWWpXQ1VIeHZ6bkFxSkxPd2t0VE14U0lCRkVTM1E5RjRoNkhPYWEz?=
 =?utf-8?B?L3ppYURIeXRUcjByRlJPRUpYbjJVUG0rMktwZlRZU2NQVStyZDNCN3NibG9R?=
 =?utf-8?B?Mi9WbFJiTnE1Qk0yNUJzUENNOHZxQlFMekNzbXNPN1R2ditiZHJGbElYeDRz?=
 =?utf-8?B?QzJKYTlXVC9xZVZHSW1WR2ZvNzl5eU1QMFJYdjE5WjAzTWF1WWNaOS9DR2po?=
 =?utf-8?B?RUZZa2U5Q3JncFNRMWh2RFZxOHBMV05PMnBkeVJ0MG56UnpKUDIxOE1wTkhY?=
 =?utf-8?B?R3JNSXZWSDR6Q3lZSCt6cTVYbjA4VGMxNGs1bWpwYjIrM2FybHJzVlhldVdI?=
 =?utf-8?B?Wk5WbUYzeGtObWl1WTRGZlJDV0ZQbG5zZC96VmNHYm0ybExwd29MRHFRQ0pU?=
 =?utf-8?B?WTJ1N2h2dWJlanE3c05pYVpnMS8xZ25MSTJrWndKT0VhSURWdDQrVm9PZUlI?=
 =?utf-8?B?TGpCRHdVcEw1TUM0cjJwMWlOeHpPSzdTMndxWktPeTZwVWN2dEZZMkZsV1pU?=
 =?utf-8?B?WlZNaDk2SU5jU3BHT3BMcEpxSWF1dUZRL09telNNWEE3cTVzREcxOFhDelNw?=
 =?utf-8?B?UzFQUktoeldYcUV6ZnNqMDRoYzdZMDRKaGNpOU1WOFN3L0xESGtVQmFlRTJP?=
 =?utf-8?B?R3ZkaUp2RzJVVE1QdTU4aWFUdWJWYlN1TjFGdTJuajUwSER5S2JzVEZIck50?=
 =?utf-8?B?K2xWd1I4R0MrQ09KNnlHenpVR0g2UTcvdyt5Mi8xL204Z3d4dno2TjRTajJB?=
 =?utf-8?B?V0doaTlDUXJPaXR3U1l3WmI0Tlc0ZFpkSUVuUGdHK0YrZENpMUdCRTB4YWhr?=
 =?utf-8?B?dncxS1R2enJ4Mk5VMnZJbW90bTBha0tSbWZLMHZxTHBKNmNQcDN6dTZFY1hO?=
 =?utf-8?B?YUZxM3YzdWJNZXE1QXdsU1piQzVOZVRWbjRNU3NiR2JEUW9LbUE4djAvRU9L?=
 =?utf-8?B?M2Z5emJoYVI4UENud29lRFo5RklIYTdvTjUvS1lzYjBsN3h2SGhqaGh5V2hD?=
 =?utf-8?B?QUdNdVNsUURNdDVxZlp3NmNlVktGRk9oRm5FOFJWKy9ZYkdiNnRraGlWNlll?=
 =?utf-8?B?MnQydUJSZ0pXbEFLY2ZvZy9HcVZIMDhsNVpsTzJUanFOVXNWK1YxaGdTeENk?=
 =?utf-8?B?cUdZbVZiMkJsamJhT1YzOVZYai9oTmNGc2t2VWxNUkhYQzBpU1VjSXBWNllk?=
 =?utf-8?B?dWVPNDJUMjFKdDZGajFRS3VMK0laMDQ4K2RhYlc3RUlQUU81eVdVR25sNHFq?=
 =?utf-8?B?cWZyYTN2VC84YXlhdTl0STBPZHZuTm5TZkZubDRFbFNERGdUbnQ1T1JhNjZu?=
 =?utf-8?B?NjkxOGhrdUZGTE9LUlJQOFdoVUNrL09BejJ0blBLWkRCcXV4aElBUldFQXJm?=
 =?utf-8?B?Q0x6M2RLUWxldWp2c2x6VzNGWW9UeG5QYUlpcmFvRzdqOGJNVElWTDVnMVRG?=
 =?utf-8?B?cWcvTHZZOGw1bFhVSjJzUTNEcnFENm1lV3hNYlRKOVFRWE1Rdnk2dndTeVls?=
 =?utf-8?B?REJNNFk1ajR1TFpNbWdUTTFLSGdLRzVBb2R1MzB1VGVSaXllcjRQaE1XbGo1?=
 =?utf-8?B?VVMyWW5ESURtZE16VHk4UzZ1dFI1T2pyUEJSWlhLMXJTNlcxYmovd215eElD?=
 =?utf-8?Q?9jODkYsKmugcY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0VRcHBlc0RLL01yNUEzOVo3K0s5TEYwb1VQUmMrKzQ2SGJ3azc3VDR0WDVz?=
 =?utf-8?B?eUxqRDNNTi9sOXhGazZ4VnBPa25nS3R3MnRzdmlabGh5Q3V5R1hZWXEwUnV5?=
 =?utf-8?B?eTM0N0lpT2VReEV6aG56dHVRYnRxNkdqbE13dzRGTHhsSm9hUnFPWm41UWZo?=
 =?utf-8?B?ZHB5alRNRDdUbEJBemt6TzI5bmhHV0hVU1RGNFNkK0JzZlBaUUN0L2tST0pG?=
 =?utf-8?B?STRnc3pkWmZOQ2Z6b01iQUNoK2I2MlJtZnRxMXEySG1wUnBRUS8vRTgwSVZi?=
 =?utf-8?B?V1ppa2pkY1FCVGh0WFpreUp2akJzOWF2bFdhU084VFNRRndjYnd0eDFwWk9n?=
 =?utf-8?B?UXRTdER1ZC9sOS83V3pJMmpoRlJhcnZFWUVlVVZjVHNTSTRMUjJVQXE2ZGtR?=
 =?utf-8?B?QzhnbWFUM2FGY2E2cUcyeDBnZkZmTjVpOXBsUEVDaWc3RFhTSnpJYzRkV1ZT?=
 =?utf-8?B?ekE0TzZWSFdRRmZ0aW5GSnBCOXE1emM4ZkZLVFB5Rlc2VFpWK0JUWlY0ZXlx?=
 =?utf-8?B?eUFIN1lXOTFSWjZiRVhEYzlHYU04ZjNKVGRPUDVmc0dSYVZVK2wwZ0FNYjNL?=
 =?utf-8?B?VUlid1BwT2wrQThWLytKWkM5Ykt6K1poeXY4ZUE5djMwYzlhOC8yVk1OYnA5?=
 =?utf-8?B?YlpkQ3BrWEw5aVdLU3dtN3BMRmJuQlFXcDk2c1oyM2ZoMzgra0NCUVVNMmVH?=
 =?utf-8?B?dSs0aTNUZ1V4cXYwT05PRVhKQmExelpuVHJkYitHNnVzakFrNXc1MmhHbHlv?=
 =?utf-8?B?NFBFeEI4aFJrakRaRFpXZ1BxUVJXcEFoS2RuUXNCWEVFK0s4aXM1SG1ZZUJt?=
 =?utf-8?B?M1pHUzJqY3VLczNHdzdhZ3M1Q0NDYjBNVkRDeHMxdzNyMjAvaWVKN0M0SGhu?=
 =?utf-8?B?MmMxb0FBLzNFYjA0bm1qcXFDWlAvUWJNbEl3QmNVTFpIZEI4V3NhdFpuQXJI?=
 =?utf-8?B?Nk9hK2M4N3dDUk5EdnViKy94cWlzS3A1YkllMTY3MU9IcytYMHFhOFNlZWhk?=
 =?utf-8?B?NVVQQUV4YitOVU1COExoaGZSeDZtdUhaSGsvUHFJNjBhNkJNTkQ5cVd6SGND?=
 =?utf-8?B?eUV6WlgxYTE1d0w1anNtWFF0ZEhSbTZUOEdyYjZjMUpLaW5FMjB6eGw5aWIw?=
 =?utf-8?B?QW5tUFdvMEN5bnppWndCamgzVWVDWTZ2S0ZLcFprN2tZenlSbWttQWtOR1g5?=
 =?utf-8?B?TXlrL3RzQ2hJSHNqM3RkWUV0MEtGa1hNWnZ4SStjR3ZWdHB4UGpQc3VSa2d4?=
 =?utf-8?B?R2xMeUpRVE54b1dVMU9xM2hRSHVjWllXWXBxMHF1UE1CUys0YVlCZVo4anRV?=
 =?utf-8?B?MXhqQWJpZVlvTFZoSFpMQzdJM21RNmtSZHR5U1dkZ2ZlSFRFT25HNjg4cDdO?=
 =?utf-8?B?eEViUUNWWktqVDJReXBEbGI1T3RPUVM5WTd3cGdvRTJXOHJmbDRGWFlzUkZ2?=
 =?utf-8?B?OGFLYjJoRWhJeTZZYWFuTHpuajlyTmpjdFVtTmp6ek03Y3hxTmdyMFA4SUhM?=
 =?utf-8?B?WURieE1rRmlvTFBRZEFBK2ljRlRLdWJ1TVR3anpOd2pQa1RwU3V1alA0Yloy?=
 =?utf-8?B?QmpITVJ2VXhGV0VZaGxoQnNkdVN6UExIYU1Dd2FVUG1Wa1lZdENmd1I4aEIw?=
 =?utf-8?B?dmZkR0lab0JtTlRnQnNoSFJVTXBKVGlsZm5NVFlpdU80UmNsaElUL2F0SW5B?=
 =?utf-8?B?d3Vaa2JwazUrMm95MHF4UUlBTWZnQzJHVjVnb0w0cTRHdXdmK3hDbmZWazg2?=
 =?utf-8?B?QkppZzh5eTZMOHRSdWk5Nys3ZWZiLzJUd04rOTU0TDZzdnlKb2xIQ2pJU1E5?=
 =?utf-8?B?SXhKRUlIQWNtSUgwczYzUWt6ZzNlcGVvLzNpa0tuQUVBVEJLQ2pCTmQrNkxq?=
 =?utf-8?B?U21ibWhUbkZWRzVpbk9lY1hqdytWOXoycDRYZDF1clo1bk1UTGowZU1kWjdx?=
 =?utf-8?B?dTZ3eXR0UlBWZWNWV0p6azFsMU9uM0JxUDM4NHQyMldtM2FWQmZ6dDkyck15?=
 =?utf-8?B?Qk9YenMzNlhsNHNocU5QVk9rV043ZThZRkhzN2ZGenB5TjJ4Y3N2MnBQTjlv?=
 =?utf-8?B?a0ZwdExFUHJ1SW5nY0l4aWI1SldJejdGQ2VVU0JPU1hLQlhUZmhiaHJkeVB4?=
 =?utf-8?Q?o9xmXcp8bpAlyvgV6FihwzCyg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20592069-2680-4cbb-bbc5-08dd30cbbe68
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:18.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0d036rc9/jGKMfqjv8yPKnGP6AUpGRUyvjUA0euOmISYqx7KqLmKXmQVKlRBVglT4/yQWBZ3vVlyB9uaqM6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> While at it, pass amd_pmf_dev to the class device as drvdata and replace
> uses of container_of() with dev_get_drvdata().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/amd/pmf/core.c |  1 -
>   drivers/platform/x86/amd/pmf/pmf.h  |  1 -
>   drivers/platform/x86/amd/pmf/sps.c  | 11 +++--------
>   3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index 57ee95a327be..1211a753fee8 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -371,7 +371,6 @@ static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
>   	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
>   	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
>   		power_supply_unreg_notifier(&dev->pwr_src_notifier);
> -		amd_pmf_deinit_sps(dev);
>   	}
>   
>   	if (dev->smart_pc_enabled) {
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 56024eb40266..198bfe3306be 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -764,7 +764,6 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
>   void amd_pmf_update_slider(struct amd_pmf_dev *dev, bool op, int idx,
>   			   struct amd_pmf_static_slider_granular *table);
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev);
> -void amd_pmf_deinit_sps(struct amd_pmf_dev *dev);
>   int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
>   				    struct apmf_static_slider_granular_output *output);
>   bool is_pprof_balanced(struct amd_pmf_dev *pmf);
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 8e75ebd25e21..4f80a73eff9f 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -285,7 +285,7 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
>   static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
>   			       enum platform_profile_option *profile)
>   {
> -	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
>   
>   	*profile = pmf->current_profile;
>   	return 0;
> @@ -366,7 +366,7 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>   static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
>   			       enum platform_profile_option profile)
>   {
> -	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
>   	int ret = 0;
>   
>   	pmf->current_profile = profile;
> @@ -425,15 +425,10 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	dev->pprof.ops = &amd_pmf_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dev->pprof, NULL);
> +	err = devm_platform_profile_register(&dev->pprof, dev);
>   	if (err)
>   		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
>   			err);
>   
>   	return err;
>   }
> -
> -void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
> -{
> -	platform_profile_remove(&dev->pprof);
> -}


