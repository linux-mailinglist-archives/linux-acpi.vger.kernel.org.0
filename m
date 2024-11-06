Return-Path: <linux-acpi+bounces-9380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75A9BF872
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1B628405E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79D209F22;
	Wed,  6 Nov 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbWosbMy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B713A26F;
	Wed,  6 Nov 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928353; cv=fail; b=Hn2M9pFNanNazP7UQnlFrwzd5agEiWwdH4K0UPP2PZxtLmP7Op+y6moBOvYMnbWYPBBVGeEHfoQggmIjo7ruRV0TAjvdOUd0leNmI4iNz/68WFWlysgTKTjlsb+7dkxtf+v6ZEjzQjBPm9sDd6xiN90ptrhZvPupPPIZnt9d1lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928353; c=relaxed/simple;
	bh=XVBeAn6aa3sumcUe+UKTzAmFQXpYnP1py4peV9SYdnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GndhOGUw/2PqdPV7Ml03w42rObynuj/kh4QKxQXkptagH1BSuPlXVGI8QokFUxopout/pdRi5gSyB0Xm0Qdyn/XfEimBY9AFzIKrlNXOFB7KE0ZKu0Kw+4jwku5Yao4ldTkf/lEOVDsuLxYYx7XpvZe4PZwMeqK/dnv7zWfWsAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbWosbMy; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt2dllQH2WsM+waI5JM6umUFnl3hCyxNYcY+xDix+1f3ZkM4UembLW204SX2xVfv6U1Tyb1rIejla4ME8qs+snQ9/18jMvB2YpYUYJePn6+7+IX3ZR6jIcTyJeEH4V0jornNSYD0t4EAB/g//OALFDZU3ZZkmKHOtjDGeLiyyatkUYhhV9qSBLSB7gjqbxm4RUHrHi0JLP7vsRcB5B0WYdt61H30szGlv7TgGHrDAZMDh2eR24gVwjDT0etN0hRSu2EGK2Y+RwRXRQULzORtnp/J2f3SRdGdiEFEBdk+DcVBIcH/9Zo6+iVXwoM3lvHI4Ozrnjtt19Jt9iv/60vsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWbw27tk8UhXlrtjTAbIrJrDXXuEh+2msVIkAEjSzS8=;
 b=eoqqbghMigPM22O8RA4IqNsMwaVfSkepVVQF8oXSR/DMCP19xaok8PmbVkORNJAdLhNlA56kqKKFgRQ30zZzKXJsO6BoDJNgO8eJRfmP4VlvSmR1gGGdvjOt2F/fFNPjRFh979JWLTNotTHH0mlICoCDgPt+qqT0jRykmmsizhvZU40rANDb5T5kPSw03Tw8fMI7hGk4LIQNDRbNIRMiWMjS9UEoc1i6/W3i6uLDLCNoH+QS4ucZMb1/ATfD1ZKIqSURZ1+JJC1f5DPVWf4oJ1nA5mGBcTgUdecU0BuhAUaz1uIw5CcgTYLwLc2e9ItWtCCYfG9kBXkoZ7i9BUvG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWbw27tk8UhXlrtjTAbIrJrDXXuEh+2msVIkAEjSzS8=;
 b=HbWosbMyABgBWfcIsgb1zORMzqy9MH23UV11zbGEovWj7UwdzxVOH0hFyL5hScl9B3KjQ6doMGPaT6gutRZW0z2Ok481QtOqQZC+VDdbsBsGSukz4VZECKVRnQfQiyoSIPNLpL+5nEmtxqu92RjCQxZ3HKHdpWwU0FaPnNQVOLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Wed, 6 Nov
 2024 21:25:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 21:25:48 +0000
Message-ID: <3cbbecf7-bba4-4a45-97da-ec461609b2f9@amd.com>
Date: Wed, 6 Nov 2024 15:25:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/20] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-17-mario.limonciello@amd.com>
 <a2bde9c6-6aa3-445b-b27b-2338d78d132d@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a2bde9c6-6aa3-445b-b27b-2338d78d132d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: cc16418b-8af8-424e-1a52-08dcfea994ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnVhMjRkWjdnY3phSURhRUpjWTVYL3pWelB0ZzVhWkJiKzZyNlppTHFhemtP?=
 =?utf-8?B?YnRKbzdZNk5JWTRMUjRsRk1QZFJETElWVGpZK3BqNTEzenFLa1pMLzFwblox?=
 =?utf-8?B?c0RwL2JESGxoeFJWWmptN0VJRG1QdU5WMGo0bnVjYXRHMTkyVzI0bG1qWXp3?=
 =?utf-8?B?dzFNQkdtV3pPV20wQkMrenVRKzRYeHByUGdVWUdzRHBaN0xRMzVlc1laWkhx?=
 =?utf-8?B?NVFGdW8wekVBS080N1o3a2hmUkI4czB6L09FSFM1TzdUZHVlbnhXVyt6MjJN?=
 =?utf-8?B?RFpSR3F6anZUV3Q5RTJ0MGs4MC9Ca3VIaWxIcnhZMWJldCtHb3dNQS8xSkZE?=
 =?utf-8?B?Zkswb0xWMEdSMGxMYVNNSDZyUHNsTG9CN2Y2emhqQkRMbEJ4bXZITGRlenZC?=
 =?utf-8?B?ZUduelJrWnJxZG45QXhKTll4VHNFVGdCZHVrV2lZNlFKOC9yS1ZQZEVIcExq?=
 =?utf-8?B?dEJqdjFyd1lMTm9VdDJFZUhhTHNFQnA1dlptVmZ0STh0bjVtS3lmWlYxRll0?=
 =?utf-8?B?VkNGNVRPVGJpS1lDOVV1dTFnd3JMcTdnZWJZZWYyREE4NVJ5cVdqQjdOSW15?=
 =?utf-8?B?c0N0UmJieUVLc2pyNG1ZUFg2bGhEWGJKbTVGZEZzSnp2a1UxTzV2K0lUQzRC?=
 =?utf-8?B?SlhFVTVCY3FsYTJ5WE9rS2lLYkRxOGY0QWxFZHZIbll6Tk1FTXlDTFp3UllR?=
 =?utf-8?B?RmNKNG9RRmljZ2hpVkJoNTVsczZWWGdzWFpXci9VU2o4bFM1RWp6Y2NFVit5?=
 =?utf-8?B?RHNiUlpMS2JReThpR3hDdVJFRE5FaGVROVgyUmxUTXc4djh0RWJRaHdQbkg2?=
 =?utf-8?B?VDU1SkFIcGI4ZVhlUndJNm5IckdlOXkvemQ4ZEp5dG9rczFUUERkVWZqd2Fi?=
 =?utf-8?B?c0xLenN4SU9GeWQxeGdXVVdlV0lxZTNDSUJZVGRpOHgwZVlBblkzWFBGVllK?=
 =?utf-8?B?aHhpZ0tlWS9TS1Rua0Y1WGUvMmxQblRiWkdDcGxUY0VUeEpHSGZkSkg5TE9E?=
 =?utf-8?B?WllGb2xhVk5abkt6RnNHdzBTL0xRS05XSTd5Tjl6UWxXTTBBcUZsdytLNzlW?=
 =?utf-8?B?bGxsNklleDVDZU9yeDU1aitmVXFXUThlUGZ0Z2Nzb1E2dFMveFhOSkk4TTNV?=
 =?utf-8?B?OU1ReHV2c2dTTmhQbWkrWFFDRE5YaVZkbEh1RlhRSUtITWVpbC9MV015RTA4?=
 =?utf-8?B?S2ZKUDcyU1ZtVlNvZU5GRHcySWVYOHJOV0pCblg4MkdaQmpSa2ZhNHA0MDBQ?=
 =?utf-8?B?WFlnQy9nam8vRVVOUmlST1dxYmNXZ3NvR2taM3JHamphZnJXUFNWYlRtWjRI?=
 =?utf-8?B?NkY0NERDL0J0akxwV1FaQU9iMGE1K2w4NDYvMHVnRGFJVkw0d1NZNGVMckVr?=
 =?utf-8?B?SVhkZlFnK3FrNnlRaGF3TGhZVnM0Z2ZSRm00RkdkbVVIaEVNSG15VXIyTnpj?=
 =?utf-8?B?UVBlaWFCcE5zcnZXOHpMSm95b2xZU0FsN2VFd25xb3RZeGFoZFlYWGFyM0pk?=
 =?utf-8?B?bTZkU3YrR0NnN1l1R0FyWmxJVFhLd1BQSWk2RDdyeGc1QUNYbEdmakc4emU0?=
 =?utf-8?B?UEw5S0tLWjNKZE1HWU1SUWFVTUpkdWpYWFBYYXNjZ0h4MkRKSDJ6ald3Wno0?=
 =?utf-8?B?ai9xZkphWEY3dnVZZjcrSnkwQjNQa0tpLzRSOGhQVWRIYXdodmk3L0NIeEow?=
 =?utf-8?B?NDAxVEhMK0NyaHdjakJLN2t0QWZ5YTl3eElTckpxTjBFWEhwM0loVVpDOFdu?=
 =?utf-8?Q?danbKFVwrUmB0QNSpdNNO6FbQucB4/QHqbeOvio?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy9WaFlHZEVYZGhDVTQ1STdXaC82QVFmYlc2ZUtGRk5UVGV4cm1pN09iWFQy?=
 =?utf-8?B?U1VtN1kwaWFBZ0JFb05lejk3bnBZSDc0dVU3Z0ZXWkNQRmdXbkdibWpTTXA5?=
 =?utf-8?B?OElNQ0JhNkMySncwZjZYd05oeGJ2ZmRpRXgyaG1NNjlrOUtOUEpnNm1MTnlm?=
 =?utf-8?B?MHdwZ1hYMmUvZGVRVk9xNG1OSHE3c3NlVVVkQkRucC9NMGJwaXNvVUx5ZGdR?=
 =?utf-8?B?NUF6QWt5Z2V0ZGExMk5uZUIrWlJVeHFSUFp5bXAzdzU3VTFtVW0yQWdKZkRS?=
 =?utf-8?B?K1Z1cmZCZkpVbVZ1d3Q4VnB3QmNSTjlUOFg2Rzg5dkNVNi83NTdsV0swWGlP?=
 =?utf-8?B?MlZ0OVdvYUkrWm5ycHphdTdhK0VZMnoyWXYyZStLb3VkeWJlZTRlS3d5T1Ax?=
 =?utf-8?B?NGlzcVVHaUdOSnY4VVZ3d2JKSHplanFQMHEwaTBkWjQ4ZFplZGhveVE3OXdQ?=
 =?utf-8?B?c2YyTUVWdmdSWTBjTnJhVHY3L0R3eC9RcmpKTVRrQ3Z3bnFGOGhoNlFMNXRq?=
 =?utf-8?B?UFZ6eWduMkRFWXJOWlJCYUszZTYrV3ZlcjQ3N2pwUlFUaGYycUV1Yzd2ZHRE?=
 =?utf-8?B?SWVqS2Y2cE41SDBrNlVxMFNvVSthcE9Gem5EZ21tczUwSWZ6QlAyVVJDU0dL?=
 =?utf-8?B?d2lrQ05MZTArdG9XQS9BWU8rNXExbUxoZkI1Tm5pNkxGMlh3ZTE4c2xCYURm?=
 =?utf-8?B?eDdHV2prd1lMc1RGbDZHakVnWkEzaXNwZXpkcWtXY1ZDd3dYa3VwK3RzSnFh?=
 =?utf-8?B?UmtnNmdhNUdJTW5wVkFteUhKbndLMWk0QWcrT05FdHN0K0hhblVhQ0JXR1Az?=
 =?utf-8?B?bG56dHJxK29XUzM2ejZ0Qkdmcmp2ME1CcUxVUUQ0ZlpvaENXMkNWZlp1Qk5h?=
 =?utf-8?B?NFJDdmhubVdSUGM5R3NTbGhsV1dGM1o4NElYT2kwMWozQ2dacFFTQ1ZDdk1L?=
 =?utf-8?B?NHJqMUV4UUtaalV6MFRnSS9ZNVIyZTI3UjlPeTViUmlvQXhNTERpNjRkKzE5?=
 =?utf-8?B?TytFaStyU2J0TzRRUzZVVGJOR2VqMERkdTVVSFREV3pLTjlKR0hQNUpSUHhj?=
 =?utf-8?B?cmU0YlY1aGtjSE82c3BXMVNMQTlKbTBjTVpCeVUxcnd5U0UyazlnY2F4Zlds?=
 =?utf-8?B?N3c4cURRNytPcWpVdTRYUStRUThTb2V5Zjc5UnZsVGVjM2FSbElIeWpLRGhx?=
 =?utf-8?B?aEdMQ3EzU2pwRGZ2M0ZwaE1oQTQyMll2T05qdkllYUFQbEpTYVV4RGErTHpm?=
 =?utf-8?B?MTZQWTlJcjM2elZGMDhONFBvL2FGQURRTGtRZ0dLb2V5L1RkNWNPUFB3bEI5?=
 =?utf-8?B?a1hmK0ptYm02RHV1bkFGeHArdzd0NGsvaVlmekVBTlhCenVXeGd5eVk2MmI2?=
 =?utf-8?B?Y1NNNVRBWHpTS2xaYnNqWFR2MnZCRHcrZ0tGaFZQUm5CV0dndWdOYStKQ2dZ?=
 =?utf-8?B?WGtHbklYZTBlQU9VeHJXbWxPMG1XSlo5cDZRaUJKWmdPUENRbG1TNG1Sb2Jy?=
 =?utf-8?B?b0E0a2dHMHZ6OG1VK3RVU3YwRnI4Y09IVEFubDBEdUp4UDZUS1owRVVJeTJY?=
 =?utf-8?B?M2dYN2tNc2Nidjc2SXk4N3FybUxFeGJIdUJNeVZaTTRidFZhL1BISjNlZkta?=
 =?utf-8?B?R3owS3k4YnE1UXZEWS9pK3pjMmxLOEFkSURGNU1pVnA0MDlXQ0x4SzlraUMv?=
 =?utf-8?B?a3BLZmdBMG9PeEcyMmRVeWFreFNnVGQ1S2NoRHE0Y2s4YjdiSEkzTXRqYXl5?=
 =?utf-8?B?WkFPWXA3OUp6WjNBRWEvTVJUVFNmUngybEdPbnQ4TDFUMzN2YnNCTFo5V05M?=
 =?utf-8?B?UWkrU1RJMC9XRXV3YnJJdVFVdnV1NFFCSEVhcWNMMXJvQkw2YnBMY2hEK0Zr?=
 =?utf-8?B?V1Mwb01MbHFZSE5PZEszSnk5VnVjbjNpVk4zMzFlcjRHZTZWLzFZeG5HcTA1?=
 =?utf-8?B?OU1IUTliUlExbWdvekhuNnlwUjYzbXZwREpxeFE5MTB3UXBPWHB4U2EvUmgv?=
 =?utf-8?B?a2xMeE4rendpM1RtdzZ3ekV1N05YYTNpL0grZU9PVWp3bHZJMmhWMnRWMnp5?=
 =?utf-8?B?Skh1VnJPbHE0b0xDN01CZnN4TTR6elIrUm5kZEdDN0FXazZRL2xIbHJISDV2?=
 =?utf-8?Q?pVum8cUdPYE4hsxNJ5ibDVex4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc16418b-8af8-424e-1a52-08dcfea994ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 21:25:48.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsZAjYMces6YqNtrRjeMQTK3rsBcJkFHpaJljf4++7ScYw6YLegLNExfyULZZQqAP3fapYf4YEm877ID7jdaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

On 11/6/2024 14:58, Armin Wolf wrote:
> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
> 
>> If for any reason multiple profile handlers don't agree on the profile
>> return the custom profile.
>>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 84 +++++++++++++++++++++------------
>>   1 file changed, 53 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index d8c2d195106c2..7861fccc2e58c 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -280,55 +280,77 @@ static ssize_t 
>> platform_profile_choices_show(struct device *dev,
>>       return _commmon_choices_show(aggregate, buf);
>>   }
>>
>> -static ssize_t platform_profile_show(struct device *dev,
>> -                    struct device_attribute *attr,
>> -                    char *buf)
>> +/**
>> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs 
>> interface
>> + * @dev: The device
>> + * @data: The profile to return
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int _aggregate_profiles(struct device *dev, void *data)
>>   {
>> -    enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>> +    enum platform_profile_option *profile = data;
>> +    enum platform_profile_option val;
>>       int err;
>>
>> -    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -        if (!cur_profile)
>> -            return -ENODEV;
>> +    err = get_class_profile(dev, &val);
>> +    if (err)
>> +        return err;
>>
>> -        err = cur_profile->profile_get(cur_profile, &profile);
>> -        if (err)
>> -            return err;
>> -    }
>> +    if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
>> +        *profile = PLATFORM_PROFILE_CUSTOM;
>> +    else
>> +        *profile = val;
>>
>> -    /* Check that profile is valid index */
>> -    if (WARN_ON((profile < 0) || (profile >= 
>> ARRAY_SIZE(profile_names))))
>> -        return -EIO;
> 
> Please check the returned value from profile_get() first before doing
> the custom platform
> profile check.

You might have missed it - that's part of get_class_profile() already.

> 
>> +    return 0;
>> +}
>> +
>> +/**
>> + * platform_profile_show - Show the current profile for legacy sysfs 
>> interface
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t platform_profile_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> +    int err;
>> +
>> +    err = class_for_each_device(&platform_profile_class, NULL,
>> +                    &profile, _aggregate_profiles);
> 
> Missing error handling.
> 

Right, got it.

>>
>>       return sysfs_emit(buf, "%s\n", profile_names[profile]);
>>   }
>>
>> +/**
>> + * platform_profile_store - Set the profile for legacy sysfs interface
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to read from
>> + * @count: The number of bytes to read
>> + * Return: The number of bytes read
>> + */
>>   static ssize_t platform_profile_store(struct device *dev,
>> -                struct device_attribute *attr,
>> -                const char *buf, size_t count)
>> +                      struct device_attribute *attr,
>> +                      const char *buf, size_t count)
>>   {
>> -    int err, i;
>> +    int ret;
>> +    int i;
>>
>>       /* Scan for a matching profile */
>>       i = sysfs_match_string(profile_names, buf);
>>       if (i < 0)
>>           return -EINVAL;
>> -
>> -    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -        if (!cur_profile)
>> -            return -ENODEV;
>> -
>> -        /* Check that platform supports this profile choice */
>> -        if (!test_bit(i, cur_profile->choices))
>> -            return -EOPNOTSUPP;
>> -
>> -        err = cur_profile->profile_set(cur_profile, i);
>> -        if (err)
>> -            return err;
>> +    if (i == PLATFORM_PROFILE_CUSTOM) {
>> +        pr_warn("Custom profile not supported for legacy sysfs 
>> interface\n");
> 
> This would allow userspace applications to spam the kernel log. Please
> just return -EINVAL here
> and document this special case inside the interface specification.
> 
OK.

> Thanks,
> Armin Wolf
> 
>> +        return -EINVAL;
>>       }
>>
>> -    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -    return count;
>> +    ret = class_for_each_device(&platform_profile_class, NULL, &i, 
>> _store_class_profile);
>> +
>> +    return ret ? ret : count;
>>   }
>>
>>   static DEVICE_ATTR_RO(platform_profile_choices);


