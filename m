Return-Path: <linux-acpi+bounces-12983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D76A86556
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A07A938E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAC2586C3;
	Fri, 11 Apr 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvOmKIzR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6E221F36;
	Fri, 11 Apr 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395502; cv=fail; b=ji9Q/XncbhMzfv6k6dIrnRxSb5nRWFGZyRnBQFosgCDPgLJVFjZtbcwASz0/qY+9L446PnL4KPabTS8+WzT5tG8eusYXaUFffhhqKdN+ArHjeH+FF/+lA5uPTV1a2eYDhYMM2RDJ5WW/M8EXCDzSETMTepHPS9Bdv8Xz46rGLMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395502; c=relaxed/simple;
	bh=qOPlC3oOVaMfqst+Uq/6BOKgiMKa3gdjzZQPjKbJ284=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u892f7RF0Mq511uAFh/DkCVpe0wfdBfk2F5T+ZhdQJ8P3nMDXy6Ivnd/BdU1DWBAnFJqkCai86Ny2704KndFCHcOitfqu+nd/B02LWHqSaaQkbGrg/x3YfRDqOrFCDkZspUqw8tiEjbqawgr5sGYk1VgKsTyoRkARaYOWEIdHYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvOmKIzR; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW6zBpfbaOdP6HNG9L9v2HlciI03/U54TQ0loFTtQ/7efRbiAh4rUm06TCCa8Y30r57BJr0VqdrJgG51uEtOXqdCJFoKK57bpa3rcA8Kd/tz4NMv4YaFcF2Gv3rbNV21YianVCjnzvLTQHNf7azJLzwFeF17p8Ot/U8NDFpo4Z9J2wXLGfc7IP8ewy7LIhFT9dJuNLdyqPr1NIFWXXGVU6xWxCLPRZMHtCYAgDVktdPaRmvD4QFZYf7Qufa9VxqA8mW7LBOivhBw7ZGr9he+6XDJcBLkJwxKAuTs1rOnb5n2Q5Y7PEUFeuF1OACiUa8IfCWNqkh/ay9N20d/2mJp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTt0loYWjY08qW5UAZ5IzQCmcRYV0Yb53XEGW71SZgA=;
 b=HoYIQCsRCdPJPnwCRzhVmcN2l7OwG1zqGY15iuESw7nySk8IVtNHK7zPvw1EdFxz3BxSJjEd08UXo+HVA0nD3Fxt9drf2za752sdwhDVWhRs36C+IbxbsYhZbY+3eyQ/k49ot1Xu4RD4gvuqR4W1tMNNKm5rHrEWbhdvMmx141I3L9OuABOo+WhRCZHTwm9I0rhEi6DDr+yaEqiX4nX0eJv5YZK5aGJAU/rHVEWsAeDlRWdNb1Hrb6Dh/+ZmW0kWI1SQYuC/gKF7DeSnk9OuPbdg6I+EDJYsCP2R8vOkq4Mb2tR0EsJ631vAkSzFx868IzlI3pQJqLtIqkqPczRaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTt0loYWjY08qW5UAZ5IzQCmcRYV0Yb53XEGW71SZgA=;
 b=gvOmKIzRbdZHPP3A+A5vaQiMwjHossffnaS9f5QQhZSqvpI3pm0NtHJ/VwYTRKGD08SWQVhHXXHN+JI2kyYVU6q7PB2UFWyqE97RIm4YZRR2s31PsBIeFo+zg/3OMSkGEPOG2U9i5SPe0JJJuTmQ6IUqm/jhY78Xd7R450fhojU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:18:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 18:18:17 +0000
Message-ID: <f6904bb1-f41f-4be9-92bb-92fec509a821@amd.com>
Date: Fri, 11 Apr 2025 13:18:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Add functions for getting and setting registers
 related to autonomous selection in cppc_acpi
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 gautham.shenoy@amd.com, ray.huang@amd.com, perry.yuan@amd.com,
 pierre.gondois@arm.com, sumitg@nvidia.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 cenxinghai@h-partners.com, hepeng68@huawei.com
References: <20250411093855.982491-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250411093855.982491-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd30816-1735-41fd-4cd4-08dd79253b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rmt1cTlzMlJJNlFISGw1c21BMFRjVDEvTXZ1WDRmTmw2d0w2TjR0UlZNenEx?=
 =?utf-8?B?bEtxaGU1M3VTQlFSaGRwemFmWFJZbUkvYUUvakFaaGQvai9IWEQ4UHZBZzh0?=
 =?utf-8?B?VklDTEZuNWE3R3ZJaFNNWWFZNVMySDlIVGhYdzFjclhIMDh2TnJnbzFoWWF6?=
 =?utf-8?B?anFtcTQ3eXN5bVRyTk5VMWZTM3RmOExNTHFJVU1FNkpod2xXOU40NnE5WWZZ?=
 =?utf-8?B?ZHdOSjJqbnlZdkdqdENxcTUrN3dod0UwUTI0QlR5a1Z3Y05NWGNBKzgvV1FP?=
 =?utf-8?B?N0lTVzhtQWdHOW5Hc0FuUlJCVUM1elpkTUpIQk1RY1grMHhhNXRnM29pZUZR?=
 =?utf-8?B?UkpwTGhGNi82M1FZa3JFY0JrckwySUh3aFYwS2hOZmlMSTVvK2NRRDU0RmRZ?=
 =?utf-8?B?WUN4cmJmQWthVVpSVHBxaFI0QXlLNGpBbnNQdm9QaVVJQUV5WHdUUTUxdDQ0?=
 =?utf-8?B?YzZNNWVzMGVmaXB2clFOdE4zYVZ2QmtuWnAwU3NRZ0pTa0lsbTkrbVR0OW1Y?=
 =?utf-8?B?UVpDMloxVmE4L1hSaHo0TEZuSkRWV2hiQWVBdXFLbXRRNGJ4Ukp1a2szWWFa?=
 =?utf-8?B?MXVvc00zK0lBckNnL05sYzN4anp0M1dPTlpxczFLdklwNkptUko5M0x4Q3VC?=
 =?utf-8?B?cmFZa3RkU3czQUxDbG0rRCtHc0xDOEFmZTc0OWVib3EzWTF4bEVldDRMdWs0?=
 =?utf-8?B?MzJLenF4RnhYSHgyMUVkZTkrNk4yVVFzbGdFZm1USTNnVklraHdqRnFNcHY3?=
 =?utf-8?B?dnRZK1pycW1UcytOK2hRTFJUOWdsZGdtYkRxQzVJcGl2QUE3ZnpzUWZiVDY4?=
 =?utf-8?B?VHNVMnBqNXV1WVVPT2h1OXQ5b1B1WmtnSVhsZlhFb2JrQUJOWFptL0FjTkFV?=
 =?utf-8?B?QnJmcG9WNGZtUno3YU1LTFp1YUkzM3U4RjZKbEhCTE9HT0I2cTlWMzNqT2N2?=
 =?utf-8?B?dVp1VGJJZTM0QnlCRkNIUHVGd0JLc1dyMHhXVkJxLzJPU0NvY215S2I3bkFH?=
 =?utf-8?B?SG1NQlkrVXhVQVFzdjJqK2pFVHBxSDczMEVNYVAreWVJUFYyeGlHbXVZbTlJ?=
 =?utf-8?B?bjlSU1k3amVyd3lZZ0s1WGw2TzQ4enZFaGwwUnVRbEVWU2syT1kybWsvdU5O?=
 =?utf-8?B?NGR3Q2ZDUitNeUlpYXZHWjN1SGhLbzdLSjNlQ09Ra2J0M3VSQ0RWamJTMnpa?=
 =?utf-8?B?cEtUYzA5SVBuUUJyL2ZId2NZV2V0V05aS3pROVAxYjFmOE9kdGtER2VTNjJH?=
 =?utf-8?B?eElvSGFQbGlzRCtxY1M5ZEdqMTJSTjVUUnViUWVWKzJIWVFYUVlqOWlqWEd2?=
 =?utf-8?B?ZUZNWlA5M3dLYWxEeGlJaHpLc01sdDV5K0hXanZxL2VERi9ld1lvaWYzblZH?=
 =?utf-8?B?ei9aSzNmZndPRFVKRmMwSEZEc3JVbGFiWE54aTE4b3Nmc2p5a0RnTmRwMnM0?=
 =?utf-8?B?NG9LVkRYVk9GVlRjb0RFR3BaS0p0b0hZdEU0ZC9wN1dxNkdnaHVDSnMzSlpp?=
 =?utf-8?B?MDBYcFk5NW9teE1GS25kU3dVTEluWStCUmlmWHNra3hKbTlHU3pVYmlUaG11?=
 =?utf-8?B?b1p4dys0U1dnMk10NlZNNUZCNlJxWFVlS3huRURDRDdnNDlzb0UyOStvaWJC?=
 =?utf-8?B?L3FZZGhYNzZ0Uit1YWpaR1lFdE1mdEM1NkpqRkIyUG5LT1VMQjJpZ3dYRU1B?=
 =?utf-8?B?RWtRWll2a3NpWUp2UEtYekFLZUEzQTgwUmtPeWUrZUw0cURqclZRUTJRbFh4?=
 =?utf-8?B?OG41U0R2aXU5eVB4WmJEaWdIeVIyRHlDTDF6V25wVFJkVUhsazRLMEJLNlZo?=
 =?utf-8?B?V0YwZnBmUmRuZkhBOFJaVzJYTmFOcEphYW1Uck8wc1grbW55YXBoVDVyR3Vz?=
 =?utf-8?B?STlYdythU1J0U1FLWE4zeTFmemhGUmxUNkJaOEwrMk92endnL0lzMHBOUjd6?=
 =?utf-8?B?YUFzU0xlemZETHJQcnIvRTcyQW53anZKdDM5bmVUbnY3OUlkQ3kzcElwRkQr?=
 =?utf-8?Q?lOb4jPQLd/A1gp5pdhFjsZoXG4CZjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUxvanFGN1NLREd0ZWhqZzZDbGloaE1kR3ViVmdka0FFRmRzTW1ZZDdnWFNF?=
 =?utf-8?B?ZHBkblJoZXNPZi8raXEzZmRxbVp0SUJzOUpodSt2Tzd5NmJuWm0vL0t3dzN5?=
 =?utf-8?B?ZTNHbWJZVEttY1dwSkJ3cktjOUYwOW5PblJYZDFzYjBQOWZVY2tCVGxOWDhw?=
 =?utf-8?B?Y25ab3Z0UXptQzJSSEh1WVdHQ2pvWkp6N1o1dmpnQXVmUnRLbUlBSFFRSkhB?=
 =?utf-8?B?TGVMUGxhQi8yYXJOVmRwWVhZd3NRSE0zVVlQcjNteUlrcWN6UTU4TzJIZ24w?=
 =?utf-8?B?ZWxQQ0dkeFRYUFVIMFh3cHdrVUgxUktBdzBTT0xxM2pzeGVlR3Y4WmQxMUd3?=
 =?utf-8?B?ZytnNGJoNlRvNDZxaHBXSFN3bXRTZEVPclFmVjhHNzlBM2hlWjlpNXJHeHl0?=
 =?utf-8?B?eG5UeFl2K08zS2M1cjIzWTlmZ05hZVhnR3NwdEJaQldTZi9hdjZoNzdMZjdm?=
 =?utf-8?B?UnNQUXVtUU9RdlBINmhxSElzM3pmYUdMeFNxMjhhcU1aMlNQUHQweVBCSkRx?=
 =?utf-8?B?dkRxekNwZTdNT04yODJ3aGJUMzdzQVMxemJLZGEyaFZiaW01THloVldNZHNI?=
 =?utf-8?B?akorMkxSS3RRbUt4ZVhaQlZSQWYzRFZyM0dNbXFhUHVHeFlicnNlZWtPUHZP?=
 =?utf-8?B?VlJwYm5rVWJ1RWZOZE1tdVdaa2k4bXZRNldiUHhSQjhxM3ZQa3pGMk5YUlFu?=
 =?utf-8?B?OVNBVnFCUTJSMVE0TGxkRU4vWjc0dlprOEpKZ1ZBY2pYUEFwQk9CMzZVOTBG?=
 =?utf-8?B?bExmLzY2UUZrRU1oUG80SkVUQmdBWkxiWGZoMHVSek1MWkxkOS8yL3FpclVp?=
 =?utf-8?B?elN1OUlDOUFmRThqeFpoMDB3d2sxaW1EQWNwNXJweUV6VjdsaFg0ajY4NHdP?=
 =?utf-8?B?cHVoczNuZk0vSXNlTEZGaFhlS1JoTHBiaWVQckFxSEtFTml4VnpicGR5S2Ru?=
 =?utf-8?B?QW90SWNCa09oNGx5MkxVTlllM2d1dUhNbk1ZZldyRDl5bU0yQVk0Mk5HTkpm?=
 =?utf-8?B?am9hZGE2bkV5MFV6SVY0M0JSaHFpMm9HaUZqL00yNzRtLy9QOHQxbUpFZFpV?=
 =?utf-8?B?MU1NWEx5ZlVDaTc3OFJHQkV3d1VGVzhIa2I2Z3h0YW91RHlaUUM5RG42TVN0?=
 =?utf-8?B?LzYxbUNGM1I1L0RjTCtCN0Y2OGZlbzUvL3Y4TVI4UFRJZVZ1eHNpWVdQYTVN?=
 =?utf-8?B?NFBuMzZaMkZ4dTI0dFBiNVV2dUd3d1NSbUloT3dHZnZiSXNma1FQMC9IVXVp?=
 =?utf-8?B?WG5EK1UySHJiRGJOTVpmcHp1WmNlNEY0d1JsZVZHVy82aDRSYnRwZ29raWhE?=
 =?utf-8?B?bnpRQ2FjYkJyQkhqenE0N09KRFErUWZJRVUybFR2amp5QWxFZXk3N2xCNlRY?=
 =?utf-8?B?UFZtVjV3K01tRThpM1Z6TjI2L2c2VUROZWNuMUMwcUxYeVpwTjFvSVRKTjBR?=
 =?utf-8?B?aWh5ZnhaS1pzNTZQdkFiTEV0TDI4b1diaWVaTURLcE1QY1kxNFFSSjdpTjI3?=
 =?utf-8?B?OEtNS1lhUThUNkhDdEhKTWJ2Q2tJVVpMdEVHWmE0UGxsR0U1OUdoaldHb1Nk?=
 =?utf-8?B?ZDRGWGJmUnBjU0Z6ZVFZMEhhNkcwcHRpSytOS1lEN0xBTWJHY3J1b0VRbGM5?=
 =?utf-8?B?bjJadm1zMm1lNHROZ0dHbWFid2hESlNnY082d0pMc2RrVXNUQXNUTWxBaGtR?=
 =?utf-8?B?eUxEbWdHMnFnRlhqZlBlWldyRzFGY0xDK3dKYko5QjRoSjlXU21tVUwzeW9Q?=
 =?utf-8?B?bzZHZ3hka1o5WmZKNXRHRFpibi9QRlhVRFVJRUlYZnVKYzgzZDdmOW5oTWN0?=
 =?utf-8?B?WUR4ZVpZSGg5ZzYzTlgweWt4cHp3N0VZVFFCNXpGT2xiTTNSSFN4WlFMZ3pi?=
 =?utf-8?B?cjdOSHBZNlFnekFtcGdOOEZHckFSR25KZi82K3JTTjl5Z2svSVUvOWkyWm50?=
 =?utf-8?B?N0tZbWlVKzhSTmJHZXdWMm14ekdRRlVFVzJYUmpaVkJpc2xoRVZkVHJXVU81?=
 =?utf-8?B?NXA4dW16UWJreHhhSnVNM0Zhc0tlVU9DcWlmWXdNYXIxazZzazc1aXF2WU1I?=
 =?utf-8?B?Ty9nRHIrUC9pQllGbDFZc1pLZjMrRlBvYkF1dUdHMWt4ZFRzaFdNbFdrMWYx?=
 =?utf-8?Q?knAgBeTWJC4zyswisTTkkUGfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd30816-1735-41fd-4cd4-08dd79253b78
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:18:17.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXTjAljbuhZSsCWEvt3eGYXtxgut2mheaardCeddAduW2hZ0WgaVVdGX6nq0PVIIVcyHwBR7HeTPicbWPBiSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

On 4/11/2025 4:38 AM, Lifeng Zheng wrote:
> The patch series is organized in two parts:
> 
>   - patch 1-6 refactor out the general CPPC register get and set functions
>     in cppc_acpi.c
> 
>   - patches 7-8 add functions for getting and setting values of auto_sel,
>     energy_perf and auto_act_window in cppc_acpi.c
> 
> Changelog:
> 
> v7:
> 
>   - Fix some typos
>   - Add check of null pointer in cppc_get_reg_val(),
>     cppc_get_auto_act_window() and cppc_get_auto_sel()
>   - Replace ternary operator with logical expression in cppc_get_reg_val()
> 
> v6:
> 
>   - Remove the last patch, will resent it in the future after reaching an
>     agreement with Sumit
>   - split patch 3 into 2 smaller patches
>   - Remove the printing of reg_idx in cppc_get_reg_val() and
>     cppc_set_reg_val()
>   - Change the logic for determing whether a register is supported in
>     cppc_get_reg_val() and cppc_set_reg_val()
> 
> v5:
> 
>   - add more explanation to the commit logs and comments
>   - change REG_OPTIONAL from bin to hex
>   - split patch 2 into 3 smaller patches
>   - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
>   - move the modification part in patch 5 into a separate patch
>   - rename the sysfs file from "energy_perf" to
>     energy_performance_preference_val
> 
> v4:
> 
>   - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register is
>     an optional one
>   - check whether the register is optional before CPC_SUPPORTED check in
>     cppc_get_reg_val() and cppc_set_reg_val()
>   - check the register's type in cppc_set_reg_val()
>   - add macros to generally implement registers getting and setting
>     functions
>   - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
>   - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
> 
> v3:
> 
>   - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() and
>     cppc_set_reg_val()
>   - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
>   - return the result of cpc_read() in cppc_get_reg_val()
>   - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
>   - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
>   - move some macros from drivers/cpufreq/cppc_cpufreq.c to
>     include/acpi/cppc_acpi.h with a CPPC_XXX prefix
> 
> v2:
> 
>   - fix some incorrect placeholder
>   - change kstrtoul to kstrtobool in store_auto_select
> 
> ---
> Discussions of previous versions:
> v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@huawei.com/
> v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@huawei.com/
> v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@huawei.com/
> v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@huawei.com/
> v5: https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> v6: https://lore.kernel.org/all/20250409065703.1461867-1-zhenglifeng1@huawei.com/
> 
> Lifeng Zheng (8):
>    ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
>      optional
>    ACPI: CPPC: Optimize cppc_get_perf()
>    ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
>    ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
>    ACPI: CPPC: Add cppc_set_reg_val()
>    ACPI: CPPC: Refactor register value get and set ABIs
>    ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
>    ACPI: CPPC: Add three functions related to autonomous selection
> 
>   drivers/acpi/cppc_acpi.c     | 313 +++++++++++++++++++++--------------
>   drivers/cpufreq/amd-pstate.c |   3 +-
>   include/acpi/cppc_acpi.h     |  30 +++-
>   3 files changed, 219 insertions(+), 127 deletions(-)
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

