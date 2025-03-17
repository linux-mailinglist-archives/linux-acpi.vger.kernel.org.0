Return-Path: <linux-acpi+bounces-12315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D5A66266
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 00:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526E316E314
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD2204C16;
	Mon, 17 Mar 2025 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="1Zmd4bfF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB720468F;
	Mon, 17 Mar 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252880; cv=fail; b=atoSh9SzbEIWKphAGCag6UWelXpOo+Dyp6DS+fq4IEcdtpgHBEzIUDLfsw7+wl3IXxamdLi3OWmnDeluCsyRKNJRNTolCbiqQJ2oQ8atlNyU9IJh/ztgi84IzELZdjK1p4YogtvPwA+tIjAG85UfxU+4Qk8+v79gynGLHltRQsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252880; c=relaxed/simple;
	bh=xf6JxupSUxun34g5a81hhpCttB0uZsClFku2RNYk3HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bJKROHJyuJX8teoE5W0V14F0q7adk/1l+vjItGPbsVZM4l+Kuv91UoRwCle7NHDyANsfTZJi5tdZnHcSQgt/ITVr4Ayaf/T9F5xONnQq+OVejVqhof9VkpQ+XoElr5ZdjIwNdPsZ06Uiw5Cn07LlgC9Vd6s3jrwZsS5EFeqBzQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=1Zmd4bfF reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h467QyuxzhKm8gCneia9cgkKBcjQD0mBmRsLkao21RejDkpRQRW1hchaT/XJNlHSmpoWkaSrHV+mtjlIUSqpoGd/WM/1SIk95mu5hLXDnFm5aVUFXYtBUcGJ8Me49/j/CdDTnFVfz30v5TBIh4jveMQZDItwmlALsTJuQ6h/L42q9/aJzCLPBh/vavYM53DdHuhlg5Dn8+L3qwI+4PO/U5MHq/31TRfcclF0egi2FsJjeND0dPZUif8mF5G9uiQYbkYdj6tNHqkVXr5/Oe7yJnuhm3BHhNGTGW8GQQU5AkoH6T4rqmXLiqTkMtWyda5zIL316N7WlNWcGHvuATKHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcTbpz4sHwCwFPEwwHTR2ThahQQGLoHIpXijrnNoQDY=;
 b=EcskOQ9pLfzxzxk+5KvEDiNGjMfYwgsDJzjGanK/JYOZi0r7Ndjn0SmM5em5Jip+XWYpaDgPo+t9FABCTZbZWXtD5D2mqrwMwDk5ZI+7ixpuEv7BBVCNelvffRf2lCWAyReYi1bYqPlamYXxeeN9hLTuZCgZC9cqIN9kCSExE/XqbJm4aNFDN4WOgbNa1jbfj6Exk2vFKgPAjnaumJdpN/LQPSdZ9kbGOU6qwoQAV/zRW8s4XWBbu2b48+F+o9dcBdYuWdsqFm+k4XRErxv3yndLpKfZ719PFPGJPWvkYjA6mJKqqKgnem05GPXKNA7LyGmIUhhaBJsTgXxIQ4MJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcTbpz4sHwCwFPEwwHTR2ThahQQGLoHIpXijrnNoQDY=;
 b=1Zmd4bfF/jTFqzB9KsYj2Hg2IpuA3t5I/R8nVzePyPZqWj3dJ7c9maxZATBxSWjWYFx52DypsbOjrkPNV/BVfpR5eFgmsoYttZoanC3N3nktjLNI9GCm7E4qRWgnLErAA0azfBjYMkO9zRhUOSFvJS2xCGsksAyxZzMR+o2FNzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW4PR01MB6275.prod.exchangelabs.com (2603:10b6:303:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 23:07:56 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 23:07:55 +0000
Message-ID: <190e3d07-f2b8-4778-b262-24b5650e897b@amperemail.onmicrosoft.com>
Date: Mon, 17 Mar 2025 19:07:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ACPI: PCC: Simplify PCC shared memory region
 handling
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
 <20250313-pcc_fixes_updates-v3-12-019a4aa74d0f@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-12-019a4aa74d0f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW4PR01MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b5901b-7c22-453d-1b6e-08dd65a88c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1QxdUlDdkcwUGZwcHN0VHl4eGZGS0VBZTJJcS95VTlrVXZZWGFKTU5JZTUz?=
 =?utf-8?B?d3RiQm1IZjJqZXp6WllkYWlQYk1MYzloWVhpUXJxYzNDcE1KV2FkdExFTGRK?=
 =?utf-8?B?cXJ1RXVlNW1hVVZka0RZa0p0NHRwOXVXUUc0QVlObldiYXRFVmNQNW9neXcx?=
 =?utf-8?B?MFd6NjRSb3BBT0k2eFB2YS9ld0xYYlVLQ1pWbXVKZnhWVWIyVEdOMEZicVhE?=
 =?utf-8?B?TkFtUTlxVHIwS1J6RSt6USs0ZjZzdEFqR1VyWCtzVXYvUTdibzU5U0JBMkVZ?=
 =?utf-8?B?R29DWlNLWXk2clJYZmFrbERQblF5NHFZTmxBV3RrU0Rod1BWUEErWDdsNW5C?=
 =?utf-8?B?WWZaMHpTbk0yMFFJT3RkMDk1SWJWU3ErV0tHRmE2aVN1MVdEa3g4aEswaWdJ?=
 =?utf-8?B?V0xkam4zcFJYVEZ1R0JjR1Q4bmFPYSs5eG1KdFNuVFdDMkNqd0ZWWFExdDds?=
 =?utf-8?B?NXkyaDR1STVkUlVoUlpRdDJhNXY5NitrbVhaVjhhY2thc3h5UjJHNk52eDBq?=
 =?utf-8?B?RXh3eENiT1ltMVpGalA5QzB3WkdGbkt3N1czdytyb1B5Nzh3eTJGT3Y5K01l?=
 =?utf-8?B?Qm5zN0pRbkFYN0VTckw1RnpBZ3VrbDliZXNacnBLdEswWmpTbzFJTXhSSkk2?=
 =?utf-8?B?Qzh6L1YwbGZraU1IcUEwUE1aUENWd09od3g3OVlONUNjUyt1N29SSUt4MDdp?=
 =?utf-8?B?NTVJYjgvdjl5RjhkWlk1ZmsxR0o0YnRHdVRvUGdBamhnRG9XTWttWS9KM0U2?=
 =?utf-8?B?QTlKREh4cVpzd1VaY3ZQS0p4SG1wRHM0YlJhWE5hOHdhVHpscDgyYXNwUk4r?=
 =?utf-8?B?Rkdpby9icm5aS1RneHNpYkszczBDcEtyNW8xd2xrQ2EyOUg4dlp0SVBpblZM?=
 =?utf-8?B?TWJzOUlyMTM4amZEa0gwd3UwaUcvNnZRcXl0TEo3VEpJTUJOQ1R5bDBrVVRp?=
 =?utf-8?B?c0RZK1hRQWVVbm5VMVhodTRLNldHVkZPUUdYVWM2Sk5GQ1NhWHpTZHRFb1B6?=
 =?utf-8?B?anNvWDdvQXZEQ3loWGo5VVgydG1iMHBQaDRtUGROVmVjL0swVkZUTUJKSlQy?=
 =?utf-8?B?Ui9NY1R5MXU4MlhyN3Q4ZFlFb3g2UTJDTmplTDQyNExuQ0hqOEllZGJ5YnY2?=
 =?utf-8?B?Y2xVNXNFUVVBOUtOQUVoZUtwK3hwaFhzeHZRWkprVXBRWTJGMlIzV2xJMWlS?=
 =?utf-8?B?MkVUVEdodTBFTXEwRFdTUTV2SWxvOStFblMwTWt5OWYrWDA2UDZsdDhsRURG?=
 =?utf-8?B?dGozalJlTFNrSHA0ckNZUUVGam9BMjh0YVJWbWI3WEJjMDV6dEltZU8xZ3Va?=
 =?utf-8?B?UTdLVnJDVk5ubUVUdTNhZlJZRHcwTFBoeEsxVE5uanFnbjR1SkN4Y0U4Z1Nu?=
 =?utf-8?B?T0ZDZ21XczVYQldkdmM4UXFOT0xpTFNnMUY2Q051bHhzRWgxZWpFSjBVa1NH?=
 =?utf-8?B?V1UvcTBMQ3Q3d2h1dGcwdGxIUFNKcW91bldjcktTblg3MHFETFRpWS9EN2xG?=
 =?utf-8?B?M0xkNkpCUy9KQ2ZLL0Jxd2daZVo1d2xxaExjMEVmUzMvRFVxZTFCcDdqL1Vm?=
 =?utf-8?B?UjM2UGpQL0dFVlpiV2xXc095S0NFaUw4L3c2RXMyYktnTHlFN1FGaW9iQ1hU?=
 =?utf-8?B?RGZUNDBxdzZwcXU4WnE0VUpJbWk0MGN6ZkRvT1ZMeWNSSzJsNHRvZWZ1aHd6?=
 =?utf-8?B?THV3MFpXV2hpL1JGTy9HeHdjNkpWbmZoR0JRMTVwQS9hYXd6NEZ0bXA3YUNE?=
 =?utf-8?B?ZThMb1oveHRadEtFaEJaNlVDVTAzZUZ2TCtyS1c4MzE0VGU4OTNQNEZneWhP?=
 =?utf-8?B?TmJ0U0NuZFVFQXBaYWdmWHUvWEVvUDlNbWE3ejZmZU5OeEtsTDlIVkpMUktT?=
 =?utf-8?Q?tymldQd3vG6B+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzBIWnlLVzgwKy9GeDZrRFEzRS9Yc0dtRU1oSEJHeXVYUVJuNFdrTUw2Wk4r?=
 =?utf-8?B?azNjOUwvK0NuL2dDT21WNlV5RTNyTkt4MWUyUmNXTlVYU1Y0Umg0UUxvUGo2?=
 =?utf-8?B?a1B4UHp6Q2hvUjBYai9MRDZKQUJ0RjZlcklTKzhiMHI2TjlVV1A0cVBPV2Jj?=
 =?utf-8?B?NlBFV0lWUDlBZVFjWHNsSGd4cXlVRTc5QzM3WVZMS0dzSHdTamNvWEZpRTE4?=
 =?utf-8?B?alJBRTV5UndwRXF0bTZFVjRrWEFPNW1CZENQQmhac3Fycnc5eC9Kc0Yra0FF?=
 =?utf-8?B?eHRUMWVwWWRIZGpKZ0Y2Sm0vMUlhTzZpMTkra2RSbVZZNERYME1iMldOWUhx?=
 =?utf-8?B?elhjK2dmMlNQT09NeUR5SkpNR0QyREoxZDhXWjNaV0JPcG9OWTJmSFpMNSs3?=
 =?utf-8?B?R0Zaelc1NTA0aytxMndwTnV4WjJlM2tQZ2VaYkVBYW9ZNmVaK1lVVjh2REdL?=
 =?utf-8?B?OGU0Z3RjYzhsQlhhaEQzZ3p2TEozd3IyM0NZMGIvcGM3ZTFTVXBaT3pzQmJz?=
 =?utf-8?B?eWNrSDROUFc0TG5MOHllelJKYXRWVi9ISWd3SFpXUXFUMU1WQTRpMEpUWGU0?=
 =?utf-8?B?dWtveDdrV2lLTnhhMlBtcG05ekkyRWtiVWhWV2duOG9PL24xNjZWOXlCS2Np?=
 =?utf-8?B?OUdHRmtRQXBFZFUxaU13U1g4YVBEOGdnb0hkdko0a3VCejlPYUpJY0N6RXlC?=
 =?utf-8?B?RjVveDhaZXk4Mjl0RWFPQlk1YlR4VVZJTGlncG9Cb0Y5ZmVTdU0rc25NNmQ2?=
 =?utf-8?B?M3J2a0I5cVI2a0E3d0toNW44WHB4eTl5WXkxS1ZyN3kvTUoxeXp0dVhUTmI0?=
 =?utf-8?B?K01yUFFIR1NGSFVwVnhJcWxjdnpJMHVQZFpob1RtaTUvWks4TVRyR2FuRHdS?=
 =?utf-8?B?OXhCSWIrVCtqcUdROW0vcHUyaHJSSVhvcWZ6b1h4ZkRsaVRObndLZHd5dWZC?=
 =?utf-8?B?UmViVFJXcCtzK3FRYjl3WDYrTjVpQkhTaXBDQ0svU2dwRndnVXNRY041ZVZB?=
 =?utf-8?B?WHQ3RDBMUDVYMDVSbFdodXlxYUxVT0Z1ak50K0xFRFhBbzJmeFZOaG9rUE5J?=
 =?utf-8?B?a2NEck01TCtjbkxOekVxQjYwYVh2RjNSbVlJb2JFei9MZXlNNm5lNC90Zjk1?=
 =?utf-8?B?aWRDQzVxd3NKWUNIcmlJMnR3OGEwNjVIMU8yYkZMNTVWSFhwcE83MDZHOGJK?=
 =?utf-8?B?MlQxTm9tY2RSaXhuRTh3eC8yZDhzRFkwSjI0QkZsdkg2UjczS0pqcWtpRWpY?=
 =?utf-8?B?MDdwU2RMc25uMmx6Q3lqZ0twNjg0RkNmYVd2WFFrL2tqbzRnTUNIeUoyNTFa?=
 =?utf-8?B?dE9lRWJGRmx0ZU1wdTFYWGxCQ09rcld1NnlCU2RvUWVJSnFMR2ppekVoVHlL?=
 =?utf-8?B?U20rT3VYaTJYakpwT2tJaXNBL1lOZHpUQWZlWk5WdFI4N2ZZZXI4SHA3TlVT?=
 =?utf-8?B?R2FlQjV0dnpIZU9wVHFJK05lT0ZvZ1FYV3pMTXhDZjM0NVlEc20veHdpV3ZC?=
 =?utf-8?B?NVUyeHkrd1lCRFkxQ0Z1ODJRbUY5VEJpY3pVTHV1aWVYQklzb1drc3RtTWU1?=
 =?utf-8?B?Y0hkeUFvNlBIeGRieS9SaU9RR09aVjNyRnIyT0wvRndsNkswODB5RENCb2o3?=
 =?utf-8?B?TjM2Rmd5bTNpN3dJVFN5ME0xb3JMOGpWNS9SQjdUOVlWc1JxdW5GZjdwWnF2?=
 =?utf-8?B?UEI2QVJ1U2M0aFpmR3FxYUtTWlhiUncxSGtsemZYeWYwL3lkWTlWaE5PL2NE?=
 =?utf-8?B?MUFSbUVVOWVJTjBIKzJpdUQyU1R1ZXNYVlV1bmV3Z3k2OU9YMlZXZlRpZVVK?=
 =?utf-8?B?WUU0WUpiNC9IZ0JvaTFubDYzOW5ja3NteS92eWVGdFJsVUg0STY1aXE4YTVU?=
 =?utf-8?B?bkNDL2JTdkhJQjhvWkUrYnBJU2p2MWRxMGIzYkJ0Umd2VGRjOEx4UktockJo?=
 =?utf-8?B?NzAzRDI2aHIxUk9lQm9QNVNtdVh2dGpoQWU0QURGRitPdm9aK0t4ZkwrTUJV?=
 =?utf-8?B?ZXp0SW5SZ2NibVR3eUdTR09BV0M3d2VNVVRnWEUyYTdQMUVQRG5yWFU5NnJt?=
 =?utf-8?B?d3IyM3JBaDMra1J0UGZsbDRzWTNYZGFqYmluRzJvRk9VU0hEM1o2OEdNVnZ3?=
 =?utf-8?B?K1J3d0tSN1lQbU16M0ZuNDlqQWU4VnJRK3pPQmhRUHRZV3BXS0JhQURwVGZM?=
 =?utf-8?B?b0labEZMZC9lb0lVcXEvaHBWU2lwT3dRTFFVNEhYZHg2Z0FuYWl3ckJkdmpY?=
 =?utf-8?Q?xzOcVYWiHxFAD10O+BgQoB8XOGgSE1v2ndH2kSXVg4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b5901b-7c22-453d-1b6e-08dd65a88c6f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 23:07:55.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90JGw4bapngbU7fu51qJyTM7wD873p4TLKhQfA7qFLIinUg2IIT5/78wJC8bj/K9HSq5MvXAHig4+EL+p3/bkjxhMRiM8kL9ykQvT1Tts18uQZ7vChRSOFjD9KtPHCfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6275


On 3/13/25 11:28, Sudeep Holla wrote:
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this ACPI PCC opregion driver did handling of those mappings like several
> other PCC mailbox client drivers.
>
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
>
> Just use the mapped shmem and remove all redundant operations from this
> driver.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/acpi_pcc.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 07a034a53acac1e8307265bcc5572054d34d971f..97064e943768ad9f1704effa13dddbc0876a9452 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -31,7 +31,6 @@
>   
>   struct pcc_data {
>   	struct pcc_mbox_chan *pcc_chan;
> -	void __iomem *pcc_comm_addr;
>   	struct completion done;
>   	struct mbox_client cl;
>   	struct acpi_pcc_info ctx;
> @@ -81,14 +80,6 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>   		ret = AE_SUPPORT;
>   		goto err_free_channel;
>   	}
> -	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> -					      pcc_chan->shmem_size);
> -	if (!data->pcc_comm_addr) {
> -		pr_err("Failed to ioremap PCC comm region mem for %d\n",
> -		       ctx->subspace_id);
> -		ret = AE_NO_MEMORY;
> -		goto err_free_channel;
> -	}
>   
>   	*region_context = data;
>   	return AE_OK;
> @@ -113,7 +104,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
>   	reinit_completion(&data->done);
>   
>   	/* Write to Shared Memory */
> -	memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
> +	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
>   
>   	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
>   	if (ret < 0)
> @@ -134,7 +125,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
>   
>   	mbox_chan_txdone(data->pcc_chan->mchan, ret);
>   
> -	memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
> +	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
>   
>   	return AE_OK;
>   }
>

tested-by: Adam Young<admiyo@os.amperecomputing.com>


