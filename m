Return-Path: <linux-acpi+bounces-18604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F2C3D5A1
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49561891F91
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B852FB62C;
	Thu,  6 Nov 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXWUc2pU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239A2FC02D;
	Thu,  6 Nov 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460886; cv=fail; b=RvRHE2eB0zqvVssrYpbbRnwr654nljj+7T0kBzzfj76Y93msH3GQTy0EfbXGL/OMAbYBuVV1pKGsH7TDdshiwvWwA/XFEkVEuxBeQmfXge82dPjLBHKv1l9gItRHyKy1mJ3qNP1Yxe1WOzS1eZg68Mlitw6uV7QLLvCPlk3m3K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460886; c=relaxed/simple;
	bh=q63L8HQny6ODf6RH+lS+aIr8HiaoiKMHqwIqdQ4yFxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m1W+J2I8i3SAEBjV5EpNeDKuHQev531cgipCMf3bohlVbgkMC+EIspCVY0BCXF+ZdPuCeSfF1ctHErA7RnyMIT4zyFiA6u94doUjL1Ylmk5+y/roJUy9Tzr/IgpF5F99lv/HksCBzhdMa+bR3UbK8HCo/w+lqzI9Ar7ggnnn8wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXWUc2pU; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTOivv+HZ9SA9NwA+DW8t5yhvoBlqAiTNHeFf3rLUC0d0zhIH6lhj2KtyoL3WU8iwX4OFXxiAdGIQgUmXYpUMwj/70ijJpN4tc8Uf3+T3f97H6tZfRegM2vpHiqztYq/kI/Ptwco4Xljlo6qju7nYAHmOwTfn6rJ0dBCigMtappA8+4aWV4dqxVJPszNKoHL1MVolwCnzOvFnQwXpXaqzq32fsWTPg9+J8wUlU4/RoUvXPSb14HadodC7GFEX/DoPsEcjfzVIvSx/OTuw1KX+4keF7qrcAoyMZ+bfxU/xRzILfQz1qVy6/7F/VqOQl+ncUCfngAC0gMe8LnhgqThgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1cCcJV8Fs6hJ8q3U0JW/7KpVpQBbRUZ00Dc3/XN1Co=;
 b=LksWYmm/86+2wQYiBCvm+vwYgT0CeVnQLVDm7hGG3Y44TdLuVWQcC8Qm5ibjTUD1b+3DAzz8blJ7gqFdAz6de2kKbBAT9UqYahLhxGlRgZllfqMzZmsw1WhV+pt+CL/dLePztul0BnJELHypBebm4bLFIW9Wz+hVm1xQZJ7faESFNbRFRtxqGUoN9gfl9btJs09CVZhQXjZ2yWsW2k1RugPnZyEMUBaTyCI0S4PSNNBMwptkIwV6hyEAkKf2ieOGN3wIQqojTE0x9ZhlvYv7UewU+o9iUMoOrjImCgWRQC6Oed8T2Ip8QTlOG1iyEAPQjiTyNUbToa9akQrHlVQz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1cCcJV8Fs6hJ8q3U0JW/7KpVpQBbRUZ00Dc3/XN1Co=;
 b=cXWUc2pU6d0ESks4SzkVidxFDROrUhfET8ua7bIkfKyvxulWQaPhkOPpMc3dtsKyxEept1/AKqGNiN6nny4F8Q+OaXcCaU4FubcGpKHRDi29wonCwP0UdeCihqdbGSCfwg7WINK7nX+z6aCgHQht3DHkeqXckAElU+SwBaFBQHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 20:28:01 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 20:28:00 +0000
Message-ID: <eb2e7040-539b-4406-9d14-3ffd261b07cf@amd.com>
Date: Thu, 6 Nov 2025 12:27:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
To: Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
References: <20251105234851.81589-1-dave.jiang@intel.com>
 <20251105234851.81589-6-dave.jiang@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20251105234851.81589-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::38) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f3dcc9-b52f-45a5-a622-08de1d72fa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWU4bERPb05iYTVJVDAwdjhDUEV2Y3JwdzVQZWxZS0t1U2ZoMnAwOXVoelV1?=
 =?utf-8?B?bXFFUzlUdzdlMjZMSUoyb05BTWozdjJTYkVWMkRXcE00S3lsQ2JDbThLcHFY?=
 =?utf-8?B?dC9IYWtOQW1tanNNLzBuc01ITmwzYmFLOXhlMit1OTFneFUzRTZzWFFzSnJl?=
 =?utf-8?B?TmhzTXYyRm40NTJiMU1HVGliYVVoNUlUUWpzV0Myb2xZWW1obFJTRFJsQThT?=
 =?utf-8?B?dkZYazBiTExsT1lMZ3M5Y0h1MkhNWWVpMTUzeThldktNaXY4N2lqUEhmSURk?=
 =?utf-8?B?akQ4MXgwd1RUYXBoQUtjNnFEVVhJeVZJMW5lbW5rY2VrWklIZ0lyWk9XRGUw?=
 =?utf-8?B?SCsvaGlPeXVYa3o5Q1dvVDBwaCswdW16ZEJTZWVneEUyVmZFMUFvSzZ3VlAw?=
 =?utf-8?B?Mms5ekdaRjBBV09yUlY1ako0Q0ZQNWV3RFlMT0Z3QVZ1b28rcmpnaWQxNzhV?=
 =?utf-8?B?MVZ6N2pkbUpBTkFiZlkyOTBJN3BBSUk1WW4zNXIzSXI4SHdqREk5eS93UDBZ?=
 =?utf-8?B?eWNoV080UzhFYXdYQWVSc0h6Zk0wb09EOG04MStNclV3NjZqYzY1d09LSHQ5?=
 =?utf-8?B?cnhYQUYwL0pXTXg3RHJmY1hUcWVTcmxXYjFYa2JuclRRc2hGVjREOC84Mjdv?=
 =?utf-8?B?OXhmd1RNR3VYbCtuNVMwcmh1N1JIR2xyYTJSbHlqcjVDKzR1N000eWtIaDN6?=
 =?utf-8?B?b1dsTUI5VjRvc01Oc3RhMXFCajdPU00zd25BQURuMXZmVkExUUhIdkVlZ0ZZ?=
 =?utf-8?B?SXk2Y3lsRWNTMFg2WWdJTVl4VGN1eSs5bnNEY1FlMEVTUUNwSC9oZHRHSGJY?=
 =?utf-8?B?OXdhS1R2eFpKTThmT1dpNFlBdVg0K2JIN3VoWk81RDRoaHJUMDlzVlMrR1Ev?=
 =?utf-8?B?SU8wTW44K1p1cDlCdTJhN21kcnkxVm9wNkU1SGh4WDVMMmYwRlNVdmpLckkv?=
 =?utf-8?B?WXFnSlBLTTVONDBsWlZXSFVaQnhsR2tvbFF2NzRlbDJ0TTVzeUZaYnZNL243?=
 =?utf-8?B?WmFJczJpOTRmTVZpMStmVWU5ZUNmaXRTdnJOZVMxYTd3YjBMcDVtYjZNNlI4?=
 =?utf-8?B?emljUm80VFAwUjV2eFpnL1RwWG8zcVk1bGRaSEdTOVNBM2tqUEgyZjB4TEcw?=
 =?utf-8?B?bmZhcFNlOGd2bDZYYk9WYS9uVEVPbTF0SVQ2RnBRTHQ5eGVJVTNhZjVadWtY?=
 =?utf-8?B?NU9zRGN5RkV6RjFNaWNDZGRHZkxoenYrTXIwT2JPZmlZNncyamlQVllqK21O?=
 =?utf-8?B?aGhvbUtUME52KzVIREJjajBkQmpvaW1zSlJ2OWcyRHl2U2I5b2JuZjhkLzBj?=
 =?utf-8?B?R2N5WEFia3h5SUNUT1BhQndUcnhNRDdXNHNyS0ZVYVhqQVZWTlJXR0w1VXJ5?=
 =?utf-8?B?T3hIeDdwcnROK2tYVjJmM3NDV1FabmxFNWFrRi8ycjkxYVhnSXVPc2p2TUtu?=
 =?utf-8?B?dUgvcWVZMGVoYjVrV3F2dWhZdjRJR1FicDQrbEkwYndiSnlUUnNuWXlHclFt?=
 =?utf-8?B?K1ZnN2xNY0pzYW8vTURaTFdiR2RiWkNpTVFVcEdPSGQ0anR0RlN3RDZaeDR4?=
 =?utf-8?B?ejF3L1FFeUlST3pFM0dYWCtXZlUvTmdmWDBNNHprMGNpRm1QekpaRWlRYmtu?=
 =?utf-8?B?bDdNcWh5cnJIR0xKYXByUlNvTXRMN3NkdnpVREVkejY1UWVCTlJzZGNSSmd6?=
 =?utf-8?B?L084eDFKbUtydUdjSTZuSHU2YWJLR3hPaWxnbHBBc0ZnZndIUnJGVzQ0YkVz?=
 =?utf-8?B?b0hxMXFKckxLODQ3VVRFMmVuUFpOKy8raDhPY2ZpVWFEM3ZickhFUDg1TmpT?=
 =?utf-8?B?YzlwNHlEWHFaek5PU2dDYUhvZUsxY25KOWFYTUxXWk4yS1pOZmtaS0xlL1RV?=
 =?utf-8?B?YnJMNUhKcEtsVUFJcFNIdFoyejMwNnpoNDg1OE1xTEgrM3o4UjVHOHY1L0hF?=
 =?utf-8?Q?eBdXTtgRArLU7mAQpQ4pFcj+6rcMILmQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWEwQjMzcWlGQUs3U1ROV0lGZHJVMWJhTEtpZ3hrVTBTTjlUUUp6SnhwMkFy?=
 =?utf-8?B?QVl5QUs3Ni92SlhYcjNyR0JkbUVXN2FMeHZ0NHhLZFJNajhiZjNYcUw5RkRP?=
 =?utf-8?B?VlNLNWs0c2xYa1VpZXJoc2dXdVhEcUFHWFNHamhDMWErUFRwZ3h0WmFQaWJ0?=
 =?utf-8?B?UFhjV0pQbDYzaTlSczFCWnBiMG1XMjB3OXNSS0hQUVRaTmJoWTI0Zk1mVDRO?=
 =?utf-8?B?RFJiV2lpMlZHd2xoRGllWlRMUXl6d08xckx6azlBVTlhMVIwd1RDWmZlWUF5?=
 =?utf-8?B?OGVPMGdhakN2U2h5VTN3ZG1vN0xYNndDam1RaGY0b05WZUNIeXd5VWgxWUJh?=
 =?utf-8?B?RnNyS2VBV0k5dmFSbERTRS9HazdQY0RxQUhzZXRrUHR6aWhuSFExTXNtOTVM?=
 =?utf-8?B?cUcrM1V2WlVqbk5RWEI3TjliOHh5VUdwQkVEQ3ZsY3hGV3paSDhibkk3WEhm?=
 =?utf-8?B?dEIreGV5VFdIc2RuTkJEY2Z3VzJlQ01WT1lhQnhXNkVKVks0bXBCU3IzT2Ur?=
 =?utf-8?B?SVZtMjNjNnMzNnJuOVVUcU9YOG9XMG9rSnJnOTRGYlpXTEEwd2NHTit0WnNq?=
 =?utf-8?B?MWtkN0xzOS9mNzBzWENmSktCdkxIR2tIWlRrYkRTb2VScmF4NW1KU2VZMlRu?=
 =?utf-8?B?eEZDdVN3N24rT1ZnNkhRVmJDTk83TUdVaVdhQkh3QVV5UGtNZkVWMHdyQTFC?=
 =?utf-8?B?cExFQ0RrVkJ2UHp6RTBwWmV0V1lyZHo1LzZYQ1IwdmRsWksrYXdlOGUzYWtQ?=
 =?utf-8?B?emdIRTByNlR4b1k2OFMwTUZSRU5WYWlVYzZxL25XVnc4Q0NxWkNzY1BEOWtO?=
 =?utf-8?B?aTlySUZyWURZZ1Y3ZTRwK0xONEFQM0J1SzBPajJSK3ovQ0NVbHA3TXRza3kv?=
 =?utf-8?B?NEY1UlFhcFZjU1VGamwycGJXM0h1ZllBL1psTEVtaUV1ZVd1R2lwNi85R2l3?=
 =?utf-8?B?Zm5QMmdEd0hrcFdGRjJBdG9iYmdyYXlsUXB1YmE0N010MmQxd2tyVGE5ZlpW?=
 =?utf-8?B?TVMvSEZrR0RLMXpPZDkwU3pBaXlCaUFCc1FVUVhyS3RpVGE0QWU2MGdLNEFr?=
 =?utf-8?B?UFowQThNZVpkKzdJc2JCZ1VES0d1TjVLY0dYbTV0Q3QvQlFhMVRpcUk5dlZD?=
 =?utf-8?B?MS83VnVFeW52VXZFM01IOHpQT2NHMVB5NS9PRGcxcThEaExIRWxoY3psOUV6?=
 =?utf-8?B?T1FIOHpLMnhtam53TWUxdkdVdDZPMGFsd21ma1o4dWhGc1ZPU2llTXFwMU9R?=
 =?utf-8?B?SGRCZDVIUDF0YU5uNWc4aDVHZW44RzRubUlBcHk1U3BYN2s5QmRWUlU1NU4x?=
 =?utf-8?B?eGZVcWJJK01oK0gvTWozYzhHTjlvcWl4dVpvVkROTll5bWhGNkdiWGVPUFBB?=
 =?utf-8?B?dG4rQ3hXWG8rRjF2VkVOaitFck5Nc1hMQzV6bnVrSS9IZVJsUDU5MXQzYTdV?=
 =?utf-8?B?bEZTZVJFbnNEclRDU1R1VDVpRTMrWEV5cTIrL0xzWnNGQS9UWnBsWlYvU0Rv?=
 =?utf-8?B?ME5FaFEzVm8yTncxMVg0b2tSaXZsdE5USGpsT3NUaTMyQm5nb1h4dXBPYlhh?=
 =?utf-8?B?b2dpKzdqVHIzVjJxbE14R0syM1BlTjcwYTJFV2dLcG5EcVJZQ3R6YjFTcVNS?=
 =?utf-8?B?NTBzK1BpMXZzNnhJcVJxL1F5OEJvZzIrVHdpeThBNlpoeXVlWFpLbGVEdUx6?=
 =?utf-8?B?bktrcWlsVTd1TFdnY3prM2cyREZqUDJ6b2N2M0x3cmhmRG5OSW5JTzhHYlp3?=
 =?utf-8?B?S3dDakc3SkVQTkFHaXZNU1Fpc21iTWpaMWE2ZkgydXNiZjZCRFBFNTB3YWFY?=
 =?utf-8?B?bFQwUTRYQXhLSlhpWWVzYVVmV0RyeHorcEVFQ3BXK0lmSnFQbHRjT0M3SU1D?=
 =?utf-8?B?YVIwNHJXY0VpSDJZZlJ2R3pzTTNqMHNxaFJvM29NV2dYaDZtSXhFcjEvZk9j?=
 =?utf-8?B?T0tIR1BuS2NCbGNxTHR6aUlrOVdaTjRaeElJdEhGdm9nQm1EelptOG5hQXhF?=
 =?utf-8?B?V3JYN3Erejl1QmFhM1R5UWp5TFRYSE1JSEFWQi85L2xFbHhGKzJueXZnS1JI?=
 =?utf-8?B?WjE3aytFU3h6QVBqRTlaZ3JxZlArbWsvM1JuSEN0dEdRa1NXd0drZDZYSEFG?=
 =?utf-8?Q?onqeoMt85aNETtxsAW5KLoj5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f3dcc9-b52f-45a5-a622-08de1d72fa87
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:28:00.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIRkAe8syl2QC1hslV1YboifHs5NwApiRbyPnEzLUJ6Almt4gU0AHI/eaAOT0bKh2vty21T4WWACn/X5rDM4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48

Hi Dave,

On 11/5/2025 3:48 PM, Dave Jiang wrote:
> The following lockdep splat was observed while kernel auto-online a CXL
> memory region:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.17.0djtest+ #53 Tainted: G        W
> ------------------------------------------------------
> systemd-udevd/3334 is trying to acquire lock:
> ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50
> 
> but task is already holding lock:
> ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70
> 
> which lock already depends on the new lock.
> [..]
> Chain exists of:
>    hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    rlock((node_chain).rwsem);
>                                 lock(mem_hotplug_lock);
>                                 lock((node_chain).rwsem);
>    lock(hmem_resource_lock);
> 
> The lock ordering can cause potential deadlock. There are instances
> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
> versa.
> 
> Split out the target update section of hmat_register_target() so that
> hmat_callback() only envokes that section instead of attempt to register
> hmem devices that it does not need to.
> 
> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Thanks for this fix.

This resolves a deadlock I was hitting while working on the Soft 
Reserved series.

Before this change, the HMEM deferred work path could hold 
hmem_resource_lock while eventually triggering memory onlining where 
udev holds mem_hotplug_lock.

Tested-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

> v4:
> - Fix fixes tag. (Jonathan)
> - Refactor hmat_hotplug_target(). (Jonathan)
> ---
>   drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
>   1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1dc73d20d989..d10cbe93c3a7 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -874,10 +874,33 @@ static void hmat_register_target_devices(struct memory_target *target)
>   	}
>   }
>   
> -static void hmat_register_target(struct memory_target *target)
> +static void hmat_hotplug_target(struct memory_target *target)
>   {
>   	int nid = pxm_to_node(target->memory_pxm);
>   
> +	/*
> +	 * Skip offline nodes. This can happen when memory
> +	 * marked EFI_MEMORY_SP, "specific purpose", is applied
> +	 * to all the memory in a proximity domain leading to
> +	 * the node being marked offline / unplugged, or if
> +	 * memory-only "hotplug" node is offline.
> +	 */
> +	if (nid == NUMA_NO_NODE || !node_online(nid))
> +		return;
> +
> +	guard(mutex)(&target_lock);
> +	if (target->registered)
> +		return;
> +
> +	hmat_register_target_initiators(target);
> +	hmat_register_target_cache(target);
> +	hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
> +	hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
> +	target->registered = true;
> +}
> +
> +static void hmat_register_target(struct memory_target *target)
> +{
>   	/*
>   	 * Devices may belong to either an offline or online
>   	 * node, so unconditionally add them.
> @@ -896,25 +919,7 @@ static void hmat_register_target(struct memory_target *target)
>   		}
>   	}
>   
> -	/*
> -	 * Skip offline nodes. This can happen when memory
> -	 * marked EFI_MEMORY_SP, "specific purpose", is applied
> -	 * to all the memory in a proximity domain leading to
> -	 * the node being marked offline / unplugged, or if
> -	 * memory-only "hotplug" node is offline.
> -	 */
> -	if (nid == NUMA_NO_NODE || !node_online(nid))
> -		return;
> -
> -	mutex_lock(&target_lock);
> -	if (!target->registered) {
> -		hmat_register_target_initiators(target);
> -		hmat_register_target_cache(target);
> -		hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
> -		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
> -		target->registered = true;
> -	}
> -	mutex_unlock(&target_lock);
> +	hmat_hotplug_target(target);
>   }
>   
>   static void hmat_register_targets(void)
> @@ -940,7 +945,7 @@ static int hmat_callback(struct notifier_block *self,
>   	if (!target)
>   		return NOTIFY_OK;
>   
> -	hmat_register_target(target);
> +	hmat_hotplug_target(target);
>   	return NOTIFY_OK;
>   }
>   


