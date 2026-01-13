Return-Path: <linux-acpi+bounces-20263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1966D1B794
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7140A302A449
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069534FF59;
	Tue, 13 Jan 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cneznT/z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08834F24F;
	Tue, 13 Jan 2026 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340924; cv=fail; b=ulBL+SfcmD+1Yz2XuZuXZDNXlkuNzg52ZlwxDd+OAHlTQq9sGKMnuxmkWOVGNAAu+dY/xJRIE8b4UWJ+4fq6enIQJEGc33SuAbr5HosGSv5RJRiKh+E6G96pDmVepOUfUO2GB6XyHr8ibNDnDYxI6JcezCukLKJ77kkrt28+nXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340924; c=relaxed/simple;
	bh=E0IM4LoDlt0TXXa1O6makIVBMOmUZa4Tnlu9SFlnb0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKqncA13SiDi5UkPFoBTg+OBSvQCLkknl4+nAk04PoHg+A8EOWbC8mdKVy+cI8LbcL/I9syRKI5uCE2KxXNbRBuHuzWvKlxPt8DvKDK1XsFv1sIqIECpDF8XCwLgR9vmL9Mj+7eomInon37zIdULgWRIDjUIuRC5Aq5/NnIALfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cneznT/z; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6401iEVJc2AHMSmHLZMWQJcDEB4M7UJrfeyCN1Dw2My9b6QIo/G1lmX6iBZez82FJnW27c5zCFxw13icXz/dHI8EefYXGevlS+E2uEboK3tIkhiYkSzcRcnvTM7SrBjfSFnt3subxT55LSJCfauzBg1REZmnaXcM4CAXjd5A2uiGoTW53kqtRq2AI0DKppYymzWFwwrph2iSVFe/MLcBbLHlwlEr6j9sHH+efddJFc8XcM9PksGrUHDv7/V1caEX//SDdnwqjiR0Lpkkv0qgZz3Y2lSsTGG885Fnlp/qZuRRkEmeUNgGfNqWjIHyMvwqnXa6EjuSY9Ur2z1yU0EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogccI4m9qO/5L4bBXAvfEuURF9gQA7wssbH7Lgu6vrc=;
 b=O3Q/u0ToQhF5oMY2xtKkOPIHUDdJNhwJTVPwk5hEtqBEYz5NokqDOYk7mJkqtw8OzihRq98RWHdpAKAMwtqkBYWLisWF0DTFwjSR6KmjOVsJvwHD9GsSJ7epylvo4UzlRYIQmVW0pAx7jhEB9MNCZ8iBwCHjT/axf/fPE5fwKWN5MBIbUnBFQwI2LeIsfZeMOs9H2e8LRRaI3kuLQ5dFKx/wHmK/GoJNREn4yowU53NrAOPuIY79J6alczQqKyZL6jHHJIq8m4Ubuf7KlsGQ4xzbLScVkP2hFEUf+jFwIViCFQM0//Y44Wnr4Ox+qBFkqEwnZZVppNpJPcSuyo/PHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogccI4m9qO/5L4bBXAvfEuURF9gQA7wssbH7Lgu6vrc=;
 b=cneznT/zskYvh+HiJgA5R8QKg4f3Uxxy2iRVI6CL31myOQ8woG1v4rcAQRs1BX2AL60vjsd2AtYKZCa4FZLJOHSUBL8NckTVTICp/wxETxJqkqX5ogGcMDTHJBzmP4Ml5vep8tKkANSbzB8B0th8OUqj+zt10p/9WU40j+QtRvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 21:48:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 21:48:39 +0000
Message-ID: <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
Date: Tue, 13 Jan 2026 15:48:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0
 constraints checking
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2827214.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2827214.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0196.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9329d4-8945-42c1-16a4-08de52ed82cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sys1cGo1UkpPRjRsM29xL3RPTTNjUXVRbFdRNHp1VkVHN2JRZTJxcmpKZVNQ?=
 =?utf-8?B?UzFtRXZSNW9sdG9GTGVyZTFJQ1M4dU9oZmM5TDJQWG9TSWcxQzVZaS9BTlpa?=
 =?utf-8?B?MU9qOThPVlB5WWhNd0J2YlZpUEdlVzFTa1oxS0lzejdLNEVNbnJLMnZIT3FV?=
 =?utf-8?B?ZFJuSXdETjAzZHZDUDF4TXJRVkUrSmw5S3Q1STlSUmRaeThoUWFaSEJKZWc2?=
 =?utf-8?B?dXArUkhES1pxSzVYV0JKVXFYb0xDOUxYMnQxeEZRWGhIQVpxVGVJdFVDY0FI?=
 =?utf-8?B?bzI5WVlMUGcrR0h2dFNvT0Z4VDBiQ0tTdkhpeEwyVVZ3TmxCM2s2ejRIL2t4?=
 =?utf-8?B?enZRa1BIbk0rcktOVTVqVXE5SU5wVFBzb2FQakY3M3VsS3dkaHpVUWtodmF4?=
 =?utf-8?B?T2hjbitIallnc3BzZjBpM1VQME5mKzVpbFpBOG9nYjUxZkQvUU9YOXBvcUNk?=
 =?utf-8?B?Tmd6WktwczN5Q1NvNWhWWFU0bGtYanlzaVMwTGJEdlZKRmJzYm9kRDBtb0lE?=
 =?utf-8?B?cWVXWElMc0Uwc3dvTmhMelpJWS9jS0NiTWZySm5DRUtuM1dqaSs2aFc0dTFK?=
 =?utf-8?B?Zk56Y3lacWpFY25ZV2V0MS9jbTkzS1NMTjFWUFlIUFJ1VnJWNHFITkFVUENL?=
 =?utf-8?B?V0lSVkVNWDYrZURhZ1ljVEFtNTNjcEVOWEg0NTNjbUJFNmt0Y1ZPTW5RZWpa?=
 =?utf-8?B?OEF1SzZ5OWdYcE5wbFFsbDgvOFFHKzQ5U2tDK2hrYVU4dE9OaFA5TlFQSEti?=
 =?utf-8?B?VzZwaC9kbTRMVWZPenNNZGg1WVA3bHZFL3h6VFFzMkIyS2Rjd0U0NzJMMllj?=
 =?utf-8?B?VEk3bVY2NG13OThDN3BiQlpnUms1TFpmczVFT2VCOCt1czN4ZFJJWDBDckhF?=
 =?utf-8?B?aHJ0YmRnMi9RMHg5YnZGZFMyLzlmSXpIZ28xcVpFM00vTTR2cU9UaDhJcmlo?=
 =?utf-8?B?NjFtNE9CZW9vbktzQ1N1OVl3R3RMbXNVZXBBRkh3d1VZd1BReFF0bFVraVlu?=
 =?utf-8?B?L2J6UXZpaVhIQVFqeUQyWklsa2RQdlpaVStoeTkvSzNYS2tFU1p1b2RpT0JM?=
 =?utf-8?B?L0RuaTFQZnJIUXoyRjhCNzVpQjdtZysrcVhnSnZlV2d4c1YyRW9XOWZUTVZK?=
 =?utf-8?B?OFR5Skw5MTZtMDlJcG9rZU9hK1NwTkZSZzY2Yit6UjhEWUV6cFpXM1NUc29p?=
 =?utf-8?B?cGVLTlc3UUVqY0ZsNXJ3QUR3Zkl5YWtTaDdHZ2diS2w0d1hpLzIvRk9rUVpG?=
 =?utf-8?B?L2dYWHUzVFdTYXduenZzN3p2dUpnUUUzTkZPTFpYQ1BCL0lTYk1OaS9jTzRn?=
 =?utf-8?B?SnZDeUZmWDE4bk9PaVJwbkJiTGpmVmhqVXRZNXdkNTBJZnR2QnB1TUpiNGNI?=
 =?utf-8?B?NzdBN1c3WWVUSTR0RXVlNjE3Vit5alVsQkZWNWdMWFZkRGErRi9heFYrZWtM?=
 =?utf-8?B?VjNjaHd6Qml4L2FKc0dxYUxSWWk2enhqcGk0VG9ZcDh6ekdWd0RmcG0wdTRL?=
 =?utf-8?B?SHRZajJiLy9NRWM0SThGQ0cyR0VSaTZ5eFVRVGZhQmplSzZDYlBJUjhhNnlC?=
 =?utf-8?B?a1FRbE53L25LVHd1Nkt5cEVWMGlaZmFGeHZWWnNiSWRoTjFRZkt5cWlxSytQ?=
 =?utf-8?B?V2Fib2pDSGRUZ1FhYWR2NEVaRWx1S2lIMzN1dG53TE0yc21YM0ZBQWF3VFpk?=
 =?utf-8?B?RE93aXBoTWcrY2NtNDE5ejNTSTlqV1JXSWlNOGVkbEI3V2R6SDl4TlhDNkhn?=
 =?utf-8?B?VCtUejRPeUFLaUFCVmJQeEtvYytCYlJveWFsQnErRHFMTjZzb1lhNVFpVmhR?=
 =?utf-8?B?NVZTRDVsZFdzNGVNUDRPanIwZUFmY3dPSUNXSUxpTW1PUERSL2lHRGpaeVdu?=
 =?utf-8?B?ZGhrTkNsUkFrK21Nc1NObzdSUHdoUlVOMEhxM3I0dWo4bmVGeE9GYzYwbzB3?=
 =?utf-8?Q?AJ/BMxNL5R0xq6oxW8xBjB6LpMejJ0oq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTRZb3gzT0lGWjZES0NlbVNIZldVRC9CdVcwSmdiS0ZmREtaUWV1S0IzTExm?=
 =?utf-8?B?eDI5enhBWVE4TWFJbFUvSHhDWEFrbXNCUTVGcTRVdTVvZjBaT2x0SWRSMmIv?=
 =?utf-8?B?ays3cXI2Vk5NQVFqQTFUaVB4WVZzeEg2R2tVQUc2NzdHa3NDWXFtYUsvck5a?=
 =?utf-8?B?ekpKZXNrUks1WWJRUUpCK0RzQzV1M29YR2FOMnBaY0dmSjRZR3V4MnRyQWNR?=
 =?utf-8?B?OGI4OHJWUmpKU0xqSFA1YVpwcVJwblRlWlZMTTZqVTNudWFRS1NjanlqcnNF?=
 =?utf-8?B?UUUrUHc4R0U5bGcvd3JkbGdkNXRDbWhMdnl3MVZLUC9mWDhlaFZNcm1BN1Fh?=
 =?utf-8?B?OGV2bGc1WUMzOTloNmpBdXRlYTQ1RjhhZjQzNnVvWlBRZ3ZuVE02ajk4MG9s?=
 =?utf-8?B?WVhGcWNpZE5WbDJwWVRVQ0tWWjhkQ0Jnb2U2TytXRUlTZmxzYldMblJFREgr?=
 =?utf-8?B?Y21EcHErb092bW1kS0xTNm1jNnl0aEptV0U0NnJmMS81NVlJelF2SGxUaXpr?=
 =?utf-8?B?T0VsV0xHQzhKZ1E3MjQzMnpoWis5NDVXL2xiSFBVYmlsL1JJSTFLOHFGSGkw?=
 =?utf-8?B?YUNmQzdhMUlCeDdpaGhiOERRV3FnaVUvR0xQcTNwVU1OS2J3WVNPd2RFRWY4?=
 =?utf-8?B?enBNNlBhQ2Vndk9ucUJieCtua3g5UnNIemRrazA1QmNKM0x3VkhhL0RtaHBo?=
 =?utf-8?B?elg1WXdMUlBhT0FvMXd4aTROaE5vM3lCM1llVTFWNTUwN01xK2krZmhqWWFq?=
 =?utf-8?B?WmhSczVGdC9DNExzYkJBVjNnVEFwY2VZVjI4WXkraHFUV1JiV0I2Q3dxUndr?=
 =?utf-8?B?cW1oSnUyRVc4endrTkZkbEhLVVNYNHlYRVlqQVpGdVc1Yi9ubXZnbjl6czI0?=
 =?utf-8?B?QVhaRGhNL1p5MUxud0psK2VrRzVTdVRlUGhQTnpqQ3RMTEhnaWFUdnJJMWJa?=
 =?utf-8?B?YW4zallOUlhNM1NiQWphK0NXeG5RSlRDMkhTb3RwbStqMVlDUEw5ZzZWREd3?=
 =?utf-8?B?S3QvWWF4em8wa1JVaGhJTXl4N3pxL3R1Q20ybDFjNTJTTFNuUVdJdHhTeW92?=
 =?utf-8?B?WFhFZjBpL29BSXVFdUtTbVMybnV3T2YxMXFkaExsc2dkTjBnWmhuaVIrZFNM?=
 =?utf-8?B?ZHVod1dpMkZUUUJ4TTZmS2JwWThVVzJ1V3VEWWx3bmhJbWV0c1FXeXc1SUFJ?=
 =?utf-8?B?NG9mMWxiaXVEd2N2ak9MSE9nYy9BM2NtNTBWekxZbFlqdy9UbGJ1ZTgrMjNv?=
 =?utf-8?B?L0tzZXV6dWtiYTNMODhDRWhRNzFPVVQySjZzVjU0T1BlZzRFeDI0SkcxcUtu?=
 =?utf-8?B?bFA1RmN6d255enRHZzJLeTNkQXE0eGxsTk4reDgwbGFXUVJpby9YZ3FibExr?=
 =?utf-8?B?Y2FpRmRZQXd6bnR0RUhiZTRiS2dYMW4vRnlmNXlBUDhwRGRWZXhYQ0JaeUg3?=
 =?utf-8?B?VnN3RVRGZlczOThBUHRDdnc1Rkx6eG1mbkM4VzRoNDVHUER1ZWZlcTVkcDJV?=
 =?utf-8?B?SmFzbklmcmhPWGNsNDlQZnJGUkZrd2ZXUEZsWmwwRTJwYkZLekY1eGIyZzBV?=
 =?utf-8?B?eGlsYVhhSGJYUmtEZmEwWHdUQlJHQzFqL1owVk1zYTJ2ZXFRS3Y1UE4yMWpw?=
 =?utf-8?B?eldvSWxjUURYYWgxczZlSnBNT1p5S2JGbHVWTHRWNlVBeGdONS9JWE84eW95?=
 =?utf-8?B?Z0xoR3QyS2pJZUhNalk3ZUQ1cjlvQ0tGYmtOUThJSXpzMXdkU1Q3Ymp3dnVB?=
 =?utf-8?B?WDYydkVJc3QydEpydUdvczVlZXBFWDNyR3JwRk5aMjN5bE53NGJxVzRLTGxw?=
 =?utf-8?B?WWp1TXlKU0xoVStQdDdNOFZoU2xDeERobjdYdXVoWEJrTEhrWkxmWW9tTkkv?=
 =?utf-8?B?UFI5WTJzMUNHNVh6SzJXU3BNclp5NXlIdXNPMzVTZy9xVDlCNHZYL2p2SVVh?=
 =?utf-8?B?Y1Rob1c4R1YxQkhKY0hjcnRJNzlOa2ZzOUtnNjhCTjE5elhrUDc0b2E4NENL?=
 =?utf-8?B?TElFa2Z2aG9PU2hpYjMxQjYxbk5ady9rSzNnYVczb0dhYUVMR2lnWkhQVWpV?=
 =?utf-8?B?ZnQvZVlvZGJQOURqUDRpc21LOU51Z0JIaDdoUklCTmxWYWRSS3luaVYyMVpN?=
 =?utf-8?B?Qm5XSlZBaWdGMkZCd1VFY1RUL0Nma3pXSHB1RmhNc040ZWp2SkFrQTdXZ3lS?=
 =?utf-8?B?YVZnUi9uaWZ2REx0d21xUERoMms5bjI1NjNpUjYvNXZnZ0hwUjR2K1F1YzVl?=
 =?utf-8?B?MXJ3VGpRQXA5blVCell6Z0pvTkxibHU5M0lXSUZJck9mS1ZoZkhBMG9SdW1N?=
 =?utf-8?B?WmgzNHBHZUppTjhudE9rWHNuTlRmQWdCRFZlQTVCdWpqRVVMTDB5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9329d4-8945-42c1-16a4-08de52ed82cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 21:48:39.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChufQvald2NlDeWcEEgdov6luyJMejPJZ537iPzjTeEFbnIh64lPDeRoEQlgncP+hnS+jmJtBWxxa+As/ekxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545



On 1/13/2026 7:36 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when
> needed") attempted to avoid useless evaluation of LPS0 _DSM Function 1
> in lps0_device_attach() because pm_debug_messages_on might never be set
> (and that is the case on production systems most of the time), but it
> turns out that LPS0 _DSM Function 1 is generally problematic on some
> platforms and causes suspend issues to occur when pm_debug_messages_on
> is set now.

Any ideas why it's causing problems?  AML doing something it shouldn't?

> 
> In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and only
> in the cases when the system does not reach the deepest platform idle
> state during suspend-to-idle for some reason.  If such diagnostics is
> not necessary, evaluating it is a loss of time, so using it along with
> the other pm_debug_messages_on diagnostics is questionable because the
> latter is expected to be suitable for collecting debug information even
> during production use of system suspend.
> 
> For this reason, add a module parameter called check_lps0_constraints
> to control whether or not the list of LPS0 constraints will be checked
> in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
> LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().
> 
> Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/x86/s2idle.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
>   module_param(sleep_no_lps0, bool, 0644);
>   MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
>   
> +static bool check_lps0_constraints __read_mostly;
> +module_param(check_lps0_constraints, bool, 0644);
> +MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraints");

I'm personally not really a fan of another module parameter for 
debugging.  I know some other subsystem maintainers are very anti-module 
parameters too.

I did like having /sys/power/pm_debug_messages able to be a one stop 
shop for debugging messages at runtime.

So I had another idea I wanted to throw around.  What if instead we had 
a file /sys/kernel/debug/x86/lps0_constraints?

If the file is never accessed never evaluate constraints.  If you read 
it once then you can get a dump of all the current constraints and any 
future suspends during that boot will also include constraints in the 
logs (IE call lpi_check_constraints()).

> +
>   static const struct acpi_device_id lps0_device_ids[] = {
>   	{"PNP0D80", },
>   	{"", },
> @@ -515,7 +519,7 @@ static struct acpi_scan_handler lps0_han
>   
>   static int acpi_s2idle_begin_lps0(void)
>   {
> -	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on &&
> +	if (lps0_device_handle && !sleep_no_lps0 && check_lps0_constraints &&
>   	    !lpi_constraints_table) {
>   		if (acpi_s2idle_vendor_amd())
>   			lpi_device_get_constraints_amd();
> @@ -540,7 +544,7 @@ static int acpi_s2idle_prepare_late_lps0
>   	if (!lps0_device_handle || sleep_no_lps0)
>   		return 0;
>   
> -	if (pm_debug_messages_on)
> +	if (check_lps0_constraints)
>   		lpi_check_constraints();
>   
>   	/* Screen off */
> 
> 
> 


