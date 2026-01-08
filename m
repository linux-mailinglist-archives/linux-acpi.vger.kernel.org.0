Return-Path: <linux-acpi+bounces-20046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BDD0282B
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 12:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE73230F03E1
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243C44A33E3;
	Thu,  8 Jan 2026 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0TLReBb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912994A2E03;
	Thu,  8 Jan 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871156; cv=fail; b=SrHWgSHkA2A5NYyQfTelbONSLR96e3swu0vVstjaCpcUrXPuVtL4a4thIvRj9HKN4INny4OJsQL6ifnl0DY+WeMOZrx+C7XdN8axJltXTxFUst9fwd4HdWdMW6kPn+iohFmPsFu/N6jLRdo09qOWoRzXCejV/66p6bXB3eu65YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871156; c=relaxed/simple;
	bh=3y3cHGZIPruYkshcFxlI8m0jGo6dbXoVVtxquqUjbzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXw7G8TS4+RjWpJUo8Y3Go/HjI8EdcoKPzaU0NiBcWanviHFpAwKdL7S8LO+pYLbEzDNGOjEddGtIgch/xLmI2Y59ZCMieBgeRhwULFr8yYBmgecakQUcAuf/sj1/73hKCCIDyQ14QYBTR4muKelpRVQHY4A5W7j9m06rsCa+Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0TLReBb; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFGdhu8SiZuOZh4XLoxtrxK+QTOHo5b04rhGpyFg2TIlxZeHuXPdAGNN9mRLJEyFcjjwZf/I+AaP0O8K/T6/yOq39Y07SOGe1VG0YRplOt9JAC4hh/9R3rGvkbWIc23P1AHptgKzj225S8ox2IWkJx3zSEahcekwGfIVqxCLY3jpqPaEpdfV8+SsOtrorZPgErOeX7DnSodoGazHEs/8T+83HBdlCdld+rPwfq1foCn29MQDwOcpnwgV3KsGshqqakoysmQKubtdPQUIiAq8rxxHOpmQOxGR9hqeqRv/ItkqYKG/nTPYD+ZE73LKnSA5lqGSEhJ/1EupUyzNCe9Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAQLH2zBK29S218lvi7G0mEI6QXCHdZcZDlA9DttlL4=;
 b=RTiO18ulth5L1WjWigm+H6DX9l6jaLPMc2Ireh7l9LeR21KJ8fJiIkoACv6j4lWaObUoimIANnw/4wnSWP7vIfLGK3s1GUFJkx209KLXt3cktovBlHV+ZhcPQAayVplG+dLb7/5pUGcxciKgQmfcyEMHgG4ZaW43unTcPD5LWHj1KBsIBD73bRJgNVLwHIQtLlSnxDBUWVEE+ccI+XddiyXoXPypHgJ9WylarmbxZjkzuwRT/XHSmdPtvecy0qzTBipBfyzQdFMoSiJ7MU7NMqHIsAVpsPYgWCZRdiiyq0T4dH8roK0dGVnLyIjRbUCy4yZlzVDt77n6dPNhjmmkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAQLH2zBK29S218lvi7G0mEI6QXCHdZcZDlA9DttlL4=;
 b=c0TLReBbpsUE3scu8cXh1AMWWQFN0pzkrfyjUfU5A9nz2rsZIZHAOHiLpdv9a+slSHSTduXlkJYrnR8+XWDCugs3DBmcPDyh2TNmr7mesSXIhB9sLE90xtVl0k787RueRBwf58yN8EE9JncqaHOGPAUUVdZgthMCFmxQmV2Dwk6q8kV8xPhobMOpMa6WnDa03PwGGDMQzom0kRLdPWZlpVkALk6efNuIS/yPAzpcLvQlAq+I1ivf6aZODM/1PPpsKNbhIR1d57KblmN3uA754HmDw7V8N5mTaNWoYpKevmIujOjmwZKxNTNbwjeUgJhld+d0fu+Q6atvXST04x+kQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 11:19:04 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:19:04 +0000
Message-ID: <3207ed15-cdaa-40d4-bce2-9add6a7bc3e8@nvidia.com>
Date: Thu, 8 Jan 2026 16:48:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260107120318.13130-1-kkartik@nvidia.com>
 <aV5T3Lh4TxvpOZi4@kekkonen.localdomain>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <aV5T3Lh4TxvpOZi4@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: d62a29d5-3c62-454c-ea39-08de4ea7bb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpJeXI3N3Q1ZVZBbDJ5Z0IxbVVzNm9BVzM3ZWNOMUt6YytnMTRTWTRGR3VV?=
 =?utf-8?B?NUI5VTQ1V0t2dnZKdFphZncvVlN4VWVBUjFDNnNKYnU5OThhaE95SktIMEh1?=
 =?utf-8?B?elFiWm9QeVkwLzRlbHBpM2JtOElPOUNxZStGa2haRmVBR015UmpWR0tpWWRE?=
 =?utf-8?B?UWN5OXB5RVZHenNUSHBrVVBFeDF2RWt1a0h2QWh5K1loWk5RQzdybVdsMW1x?=
 =?utf-8?B?MEUvQUFWcnhKUWQ5dnpJbDk1SHlGREMwbzl4Sy9TNEtLVjhqcG1XTm02Mm96?=
 =?utf-8?B?alJDaVV1bXdnSUtjM3dWVkpzYnkvZGM4YW1HbDRhazRtM2VFTXk1c3dZb3BY?=
 =?utf-8?B?VGRNQXNBVUNwclA4V21oT1phVXFISlNKV1BPV1pObExsbEVkaTJ0a3BhWnk2?=
 =?utf-8?B?a3ZBajBDMTR3bkJxaitETjNaTWJXUFZWd2IyZmU5cStQMmFiUnF0K2VhZDNZ?=
 =?utf-8?B?WUkxZHBjRjJ4V29JbitxemxGQ2hva0Z5MHBNdHVUSUQ3YWxESDZPSm0vQTNr?=
 =?utf-8?B?QnJxRERXWDhWMUNOZGxjTW1yM2liemNhZGFtaXFhRWp3d3lUd2dPdXBSUVJG?=
 =?utf-8?B?Y1pOajFiS04vbTMrTG9PMFRpVXpiRlZiMWo4bWFkaVFtRC9hNlhPSmZyckVC?=
 =?utf-8?B?S3B6Skp6dE04ekZndTNKRDhEMCs5aEJkUldIbDNaMVA3cDQ5dTMvZWZBQysx?=
 =?utf-8?B?cG5rbjlZRmVpcktaM2NCR09HUGNGY1NHbXBzU3dpT3o0WUVQbGI0cVErMThz?=
 =?utf-8?B?dkp5T05uUU9jRU1iUXBOWmJuY2g5elZDRWRRMWNySGhUMFRHVHo4d1pEaVkw?=
 =?utf-8?B?bzI2ckpwNUVWRXJITEZjTTM3eis4UmFhMlhvKy9vNzdzQ3B6VjRpaGMwMC9L?=
 =?utf-8?B?QVl3QnlUWGFZZXpwa3RxWTBkbkt6WGQybzlMbHBnYVpJWGtTMlh6MVM0cjlp?=
 =?utf-8?B?SVNLWWZVUUdTMndNYWNnaThVY3A4cTVGY093c0FhVUJQZ2h2K3g2cHhhWmpH?=
 =?utf-8?B?MExFS0ZCMnR3a2NLQktrdklUbkFYUStWY0pEWjh3ZG5pWm5rdWYxaXNwTUJE?=
 =?utf-8?B?bGxYN0QzTEkwaWpCT3ZEVUxJT2JmOW9CdlFxMmxWOGFhVHZaTjRsZ2ZuaFZL?=
 =?utf-8?B?ZzhrVnBRUnIvaHg0VG10Zzc2UklhR1krUHBhdnJGSkszb3hydUkva1h3Z3p5?=
 =?utf-8?B?TU1jWlB4QURnK1lUUG9HeUxoWnhvRjREWFlwSWx4MkZaNlg3VkJZVEhHU0Rt?=
 =?utf-8?B?aml3b2c2Z2dTWXlydzV0NEhBVUZhaU90K1Z2TUw4b2dTNXVCU1pjaHRUVW43?=
 =?utf-8?B?UlNkSEc5QmNBZnhsK3ljaDQ4YXlzYmd4MHlMTU4zaUhRdXhaNmJ1Q1U5Z2pB?=
 =?utf-8?B?eVcyczZDL2hlZldscTlmcm01ZnVxR3NKVjJIWlpvam1YUExZanpzNWhmbzdu?=
 =?utf-8?B?NVJMMXRVZzg0TUE3c0xRbVdsanN2a0VxTjNMdEg3UUFEL0l5bzNpSnBiU0tl?=
 =?utf-8?B?YU5ZV2x3THByWWxFVk5NOUNMZWxWQTRYNCtqSGRrTVNPSU1rcThpS3k0SnY5?=
 =?utf-8?B?d0FheUxEQlNuNFZlaHlETTN2Z2Y2V21YQTlYNm5iT09TVFpTVjZZTlpBcGUx?=
 =?utf-8?B?YTErN3NmRXJicitBVkx3YlBiVkFNTk43eVdlZ0lIOXUzVUE4eE82NVhxc05h?=
 =?utf-8?B?eE1xOVV0YlIxb0V4TTJ1Vm5HN0RZaUZOeG9jZ0g2NG1Yb1YwalQrVEhUSnlZ?=
 =?utf-8?B?Qk5UMGg0UGhOa3IyUGwxVWJzYmlleWlGUnVUR01NSTRtQzNBVks3M1dUZkp5?=
 =?utf-8?B?QUNCSjgycWpnNDltZ3dwZURpQW8xVFRDR2FubzZLNDVpalg2aUpXMWpWcWQz?=
 =?utf-8?B?emVmWm5GMVdUcWxpK2JCQlRhaUMrU0pRKzNIQ3RDRFIydnVnVXR5VTBpOG5v?=
 =?utf-8?Q?gZ/an/Q13s6NOQnfhyMcyPapjhDz/VNC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJ0bk1PWUdkMDdlMFA0V0tmc295Njd1WFgzU0Qxb1cwQU5wbDM5WUJESjhB?=
 =?utf-8?B?T3hUb0phUVJMZFVFdUZtSU41WDlJeFJseHRxZjdoWHFOQ0lYeWVtcXV6bEx6?=
 =?utf-8?B?WjU2ZGo4THhPR0x2Sm5ZT0ZXK1BIYWtYT3N0TVcrdGRLS3pUaWhDN2I4Zk5p?=
 =?utf-8?B?RUhnMm9EaWJMUWVDVEFJS0pqN2tWd1VmYUxoQlRnVjlRdDJYemV3eWtud1Nx?=
 =?utf-8?B?Mjkwdm1jQ2NHMnhkOXB1MUxlTlFxT0RYNzhHd3hGS3ZXQ3dnS3JjUWhqTHc5?=
 =?utf-8?B?M3c3WmJBNzh3ZHU4SUZqUStIV21xSmZWNGdNbnlHbGpnRFBFVlhsWXJDY0xH?=
 =?utf-8?B?YVF4eFd6REExcnRjSXlBZ3h3VnN1ZWVGVzlYTjE5VklIdndMVXRYSGJOMkZ3?=
 =?utf-8?B?VzNYOTA0TUJCUk5VMTR1OTE1MkZQcGdEek9EQ0RobzhZVkNJUmJCRzVGQVpG?=
 =?utf-8?B?U2djelk1UUJjeWRBUlFXVWVweVZTWkR5VDdsYThEVVBhQW1QelZTVHc4Q1du?=
 =?utf-8?B?VXkyUmN2cVVMNHBkUDZ4MnczRjhvcWQ4UWVaNjYxZ21OMWFLYWxpbTd2SUhX?=
 =?utf-8?B?Q1hGb1BHeDAwR3RKZVJRbjVOdWNONnlXQXVIam1MYUdrRGdkenQyNXdFa2kx?=
 =?utf-8?B?cnFxTGJUeHU3Z01zeTFnUUk1VHh0STNhdHhBZlVDMFNuL1QrWkJDczI5Rk9o?=
 =?utf-8?B?VThSTlFFVitybWZ1aEIrcUEwbFlDd0t2Skw3eUNxTnBtakRRbVhxdHl3Ymxk?=
 =?utf-8?B?U2hzTzhySXczcWNaTFc0Vkgzb09seTRkejNrNTBTS0owT0dzNm5XMXpNak5Y?=
 =?utf-8?B?bzZ2WE1HQncxelFBVU83Myt2TlloWnZQakxqNmE4d2pCOXE3NERJdGcydE1I?=
 =?utf-8?B?aC9HS1N3RmxXdWlWdzR2TXZ1MHpIQWFJMkw5NGdHMXhXemU0bGtzWTREdDZx?=
 =?utf-8?B?VUJLOXpxRzNWYSt2bEVoQzZOeXpJZlJNMlhzVk1tK0JHY1I1Q3NtKzF0QTJZ?=
 =?utf-8?B?V0pseUh5M1AxSDgvTEJDQkI3K0RIY01hUE9nbzJ5ak1NYXNmNnNhNnVmeE5p?=
 =?utf-8?B?TWFKZElFSHJlUHl0ZFpvd3lxT1h6TVdSTXlyQmVBOENxaFhFbGl5N1UzTllG?=
 =?utf-8?B?SDI0K28xRE5EM1FrWjFXdDA3cGtsaEc0eFlhUlZPMmVlZmFtV1pIRWhlWGdM?=
 =?utf-8?B?OFcvdHpCR2J5WWVuS2FqUHlHYWlDdVk3VThDM3V0VUJGazIvY3FpOG1xZWsw?=
 =?utf-8?B?QmxUdUUyMVQxOXdUK1BVYmtIT0UwZkppeHZhZ2UvV1JmTHlpMEo4aHJCWEdv?=
 =?utf-8?B?V21wZkw4SHBFckpCVzVqdmc4ME14bXRwQWFkS1VXb0szWFNkb2k5WW4xek5p?=
 =?utf-8?B?MGVObFdlV09oOSs5azNkNDAyc3ZjOFV6U0xvbVlxSWtjRU1Sa3RHcjVjeEJV?=
 =?utf-8?B?MVlVeWpBSEgxMklqWXhkYlFZNjFoNHZqOEtiTUdpcmJQY3hVcFdNdEt3cGZp?=
 =?utf-8?B?K2ZhdFRldUN2NmR1dFBLTTNxUEYzQkNMMURsTTFhb3ZhK2tnV0N2bXB1V0Y5?=
 =?utf-8?B?SE9xZThZdEdZN1FpQzBacWFqWXhZZGhGaEpxUHFNM2lkNkpldWJKRGhiaGU5?=
 =?utf-8?B?SGVWOW91bml4bUZmT3g0aGF3ZDdkVHYyS29QK3hMdkRJbitCejJ3ckRpOC9h?=
 =?utf-8?B?Wm5YUDlDTzFCck9vcUlnbWZaNjByMzNBMzdPSXp5MDZOT3RaTmpaRmY3SEo3?=
 =?utf-8?B?QUcyVmd0ZGhaTVJKVXV5bzFYMW1kZjlYellUUFovVUZYYW5Vb1gyb1JIenI2?=
 =?utf-8?B?NSsralhUc3N6RFU3NXNwRSt0NW1FRFU2NTFreWxrWEVlQTFtRlRJM2RUbll6?=
 =?utf-8?B?MGV2MkFFcW9HZU8zTVpWak95cEQ2ckVOalZlOGtpUmpFMmdkVlc4TmNWUUo2?=
 =?utf-8?B?UWhDbDk3S1ozVTlCbFo5MGhLSVVVUGpEQjh6ZXJvbGZIWXBhcjh0TDlsMjlm?=
 =?utf-8?B?Z0xDQk85QlhQS29MQ25ZQm4yOGhaT2s5aWs3TGNKMzJVM1EvYkp1VStkZ3JS?=
 =?utf-8?B?WDRlRkRFU3RWVkh0SkNvVlcwcTBlaEE5R0h5QjFUb1crcUd1R1QwU0hmNnF5?=
 =?utf-8?B?UEFKN0ZpdnNnYWlaNkYxQ1NjZXphSlJlZ1RhODNPZXRLSWJrZEJkVEt6RXVk?=
 =?utf-8?B?bmVKaGVQZHhCN09SZnBJa2VNTE5DaFp6SEROZlVLM0x1aDNoRmVjQkV5Mzln?=
 =?utf-8?B?eTVqMTVpbloxeHRXZ0ZUN2tucXdGREoyT2M2NXc2Mm1mZGNVd0cyRFZoKzhq?=
 =?utf-8?B?ekR3YVdZRTB2SWg1Vlh5bmoxbEtrODYweGZnOWs4OE82TUtmRlE4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62a29d5-3c62-454c-ea39-08de4ea7bb29
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:19:04.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28TuDQyfSTPGmOnhClHx8uBmFlzKtOqytj2JapRf+R+NLdK8E38acmdfmX1mnrzcMDgWUY0rRu+HDaq2LkYgAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

On 07/01/26 18:08, Sakari Ailus wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Kartik,
> 
> On Wed, Jan 07, 2026 at 05:33:18PM +0530, Kartik Rajput wrote:
>> When a device is matched via PRP0001, the driver's OF (DT) match table
>> must be used to obtain the device match data. If a driver provides both
>> an acpi_match_table and an of_match_table, the current
>> acpi_device_get_match_data() path consults the driver's acpi_match_table
>> and returns NULL (no ACPI ID matches).
>>
>> Explicitly detect PRP0001 and fetch match data from the driver's
>> of_match_table via acpi_of_device_get_match_data().
>>
>> Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>> ---
>> Changes in v2:
>>        * Fix build errors.
> 
> Thanks for the update.
> 
>> ---
>>   drivers/acpi/bus.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 5e110badac7b..6658c4339656 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>>   {
>>        const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>>        const struct acpi_device_id *match;
>> +     struct acpi_device *adev = ACPI_COMPANION(dev);
>>
>> -     if (!acpi_ids)
>> +     if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev)))
> 
> I'd swap the arguments to have the static one on the right, i.e.
> 
>          if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
> 
> The patch looks good apart from that IMO.
> 
>>                return acpi_of_device_get_match_data(dev);
>>
>>        match = acpi_match_device(acpi_ids, dev);
> 
> --
> Kind regards,
> 
> Sakari Ailus

Hi Sakari,

Thanks for reviewing the patch!

I will make this change in the next version of this patch.

Thanks,
Kartik

