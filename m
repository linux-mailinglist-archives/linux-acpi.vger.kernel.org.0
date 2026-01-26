Return-Path: <linux-acpi+bounces-20612-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFiTNk1Jd2l9dwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20612-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:00:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52A876FC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B13530055AF
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74055330B07;
	Mon, 26 Jan 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z60AvHJm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z60AvHJm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B93314B6;
	Mon, 26 Jan 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425225; cv=fail; b=lgF/7BKfukJWIAtzY90QtXg8/eYJ8bZMD1U1LUXmWvt1vHl8vPRIiPn5o73DeTLkM98ZoYEXx9ZOJwpbohtX7aIgGFdz3cpw2DaXlm/ry6kkm2F36MFB5/XOlhosnRXDIvyk3KPa3QXjBxWzMQvrpnJtz+JehjN6GebqbmPWuz0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425225; c=relaxed/simple;
	bh=zN7+rcNcM9lJnBDzey3coN43Gut5hs6THoI4dEhFdy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=syaInIQJVJ0aSSz8AwX7XTmj7oneAlq78VMv+OcO0HhVV0CPGm00OBnjHzvQvXdHNwhPn9mTaEho+OlKcsJ73K1dFt7IwCoruKd2wpuK1aPLhym90jcfR68mXJYnJlkEKapPAFMINavCJN72KDoQzSD9ujTKIyy6XWpE+Rhd7Ck=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z60AvHJm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z60AvHJm; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BuederZYa13lfn5OojuO5+Vn9C9r6iThWFx+OAF43JB+WZiO0Wlt5YSmEJa1TT/f/YWt7McUqE8wi8dOqvrRQMvNipCfboUCkmNj2zlvo1E/7oq+ReS8qv5KPmApotZ7E7gunMPethlMBvU2lL9+Z/PxVLgiB4EOqNRjOlI8QaaUUSwQLMqJeTOnoQ7YQQ7kRAsM1OgYXwaBWYKRTMGiC1kL0F5HfxozP1XRjnZQ9dMFd1mQx5/nQp01Zz+LZZ8F3BgcVkmL5gVMQiMaltiWe505EW8dkCiryjIDpBeBlcFh65dI9xVhSkwqpCMV2CFP6KeiUSNO77CbAoS8/JRngw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20s7CA0/2pMbDwh0jf2NM19VtAOIwdyrZ7lmP2Yz+t8=;
 b=bYNIyd5u3gcubLvDrx5YOPkWTi1piRntSKxPqf3wAw3ZON/zKfmMRlAqh+Q0HrReugdR26sf/CfxVLtjfOelnH+ZkxZ3jyA2BijeDyREuZpgjd2Ink/Wxb6245rHjsxTDdmAz1lPm2Wsa+ARYXABtXQe83Po4xW93ah6UwZcUeirh0Pgosf8MSxfOBA19XvFRDoHcWIeI1jizQYKP6GG+CHFP/oa5FLcvcHg4skDwapG+xkYh7c5FIOHIx0U3DEJemyn53/7FXYWX8ZoP3sW34Bp4NwxT01dICbYHwwKruuOmMys+D5rYsbPYZzTlnTQ0zdx3m1WJKQY63wfDjGHMA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20s7CA0/2pMbDwh0jf2NM19VtAOIwdyrZ7lmP2Yz+t8=;
 b=Z60AvHJm6It+sRVvWPIOJhKcb25QJQcJrRV4QuVH2hK0og2u1yq8rVZchyroHimSilJMsM8u/legNrzFGDMYE82rK5spzqk+VCUAz8prNHx/3Jz3u3lw41ni4Z/5oMSJ96+/6zE4MRXE3y8ROzbPS5jXkpGWF5LjiPyit9v42Bg=
Received: from DUZPR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::10) by VE1PR08MB5854.eurprd08.prod.outlook.com
 (2603:10a6:800:1b0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 11:00:19 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::86) by DUZPR01CA0162.outlook.office365.com
 (2603:10a6:10:4bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 11:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 26 Jan 2026 11:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYaessGAHRks2x1T+UeVPT+7nFtEb1mVXhqRqW/Hpp0nyWe1CAyKoc5Bpy/2sPy/7NvjdTjjt7L30FDT4JTFFHENgoVIcINwq2lHzq0xheH3ZoPLXtIYnc4/WkVBkPJ/NaUZtKNdbkzaxEeHbUNrXU1OTLyP6BuMlaE7UFKerFzhrizMfA1d5YjZ/oKYZE9pm9dA5/044JgUE9fvGldgTe76kUR+FcX3c67ymHFaj9BWdD7N2vq1bi0J/KTDA4dInvws7ccLOjT45rdAhF+TSl4P0w2aDjuNZ0rdTL3Tc+FyzbADdHw8zqHiOxSlqRgbZWZETOEge0JRKqqdURKDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20s7CA0/2pMbDwh0jf2NM19VtAOIwdyrZ7lmP2Yz+t8=;
 b=V0IH9DuR/6pzKeA36n22PXImS+2kb5Jip7o9We42Hw6icSPbUcNjy9bd0K17m4w8f9toD8v4uYNtzRU+/spmAQXcvaGxTsnOcIMVVGyp1uVF+ZoOWvP2ZCbOr9IGmlcsFDtYRBBwQO974PEoCL+uwHShHBcZyYDBg9Dnr6rpiYG4yIxO4GTwbUrTqrHYkX5N+oyUJnvbyI2Hy0XeWHYxyVVkORtnGcO4WEcbc29jJo+lsRT3codL9XogKV5HmfF9JM1q4tn3XFCT4rbQiWxigJCzoc7c7EM0hCaUI80GNMk0vv6myeGTi6G8LWpHHcY8NoDOHJp57gz+O1KtEbS5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20s7CA0/2pMbDwh0jf2NM19VtAOIwdyrZ7lmP2Yz+t8=;
 b=Z60AvHJm6It+sRVvWPIOJhKcb25QJQcJrRV4QuVH2hK0og2u1yq8rVZchyroHimSilJMsM8u/legNrzFGDMYE82rK5spzqk+VCUAz8prNHx/3Jz3u3lw41ni4Z/5oMSJ96+/6zE4MRXE3y8ROzbPS5jXkpGWF5LjiPyit9v42Bg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6884.eurprd08.prod.outlook.com (2603:10a6:20b:305::9)
 by DBAPR08MB5608.eurprd08.prod.outlook.com (2603:10a6:10:1a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 10:59:16 +0000
Received: from AM9PR08MB6884.eurprd08.prod.outlook.com
 ([fe80::3d93:3e2a:1a1f:95de]) by AM9PR08MB6884.eurprd08.prod.outlook.com
 ([fe80::3d93:3e2a:1a1f:95de%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:59:15 +0000
Message-ID: <9216ef1b-a3fb-4030-917d-c6141faa186a@arm.com>
Date: Mon, 26 Jan 2026 10:58:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Content-Language: en-GB
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 tony.luck@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com
References: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
 <20251229115440.2734800-1-ahmed.tiba@arm.com>
 <20260114141551.GKaWelF-Gsvzr71LUs@fat_crate.local>
 <dc2f3dd7-b9db-4a2d-b431-f70738cefcfd@arm.com>
 <20260120111509.GAaW9jvTirZhL_pHTT@fat_crate.local>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260120111509.GAaW9jvTirZhL_pHTT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To AM9PR08MB6884.eurprd08.prod.outlook.com
 (2603:10a6:20b:305::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6884:EE_|DBAPR08MB5608:EE_|DB1PEPF0003922F:EE_|VE1PR08MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: d16e9ff4-2607-4f35-58c0-08de5cca17ff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NVBXMkN2QzhYOEZmZ3J1aW9ZSTYyb3drQU45NGplTVRMRWpoY3ZWWXhWajhV?=
 =?utf-8?B?T1lHNVNsQWxGNUU2ZlNoNkhISWw5czgwMTd5a29saHo4RlZ5MXJiR052blNN?=
 =?utf-8?B?cWcvVnpKRlIvbnEzQmdzK3FXRGxLNk95dmxrZXhkczBkZFZqUGs1TjZDZC9D?=
 =?utf-8?B?ZFFiUHI4T0ZDemNqWjQ0WlVQSnI4MU5qanVJemlwR1JoQzJqSzlBRlNJUUU4?=
 =?utf-8?B?bTV0Tzc4akcvUkh6cExLSFhXei96TXluNC8yUTNwSFpoNE1JWEx0UFVnNVpM?=
 =?utf-8?B?d2FBNHpxOStVOTYrK3NsdkVpR2JKY3YzY2k2V1ovdjhTVWQ1YTFCVnkzS29l?=
 =?utf-8?B?Y01WSHRmWmFwdWc1R1RoY01aeHN3eld2azZRVVozOHQ2ejJFWklUbHg4ZGx6?=
 =?utf-8?B?Vi96aUJDWVltcy9HeFVOQzdFd3N3bzNsdG44UzNoUjduTjFLbTV5S3hGSHRK?=
 =?utf-8?B?dFJmTm5YazBLZ2NTbUZBMTJoemlLYlhPREFqTW1ESThLcmVyalI5MDVXU0RB?=
 =?utf-8?B?bFhmTXBQYmI5YTRwN3UyanFOOGtUSjd1bUF4Y0FodWNNcVQxMmdaU1NDUGQx?=
 =?utf-8?B?aFcrdVVMeXR2SG1iS3A0WkRuRHhCcDBjK1RKQWQxTVdVZS9IR05EVENjL0JZ?=
 =?utf-8?B?UUErYXRxRmpqK1ROUFZwd3RXRDE3ZTVhaGNPZmZqYzVNZ3h6Wk1YWHN3bWtx?=
 =?utf-8?B?OHR2MkZ0WVN6QXh2VDhnTVpPd3pSbmdPejJOdGxzaHVXbjBFbzJXMHJNTW8r?=
 =?utf-8?B?U0FJMVB3SW1qOHRmSHdiRHl4YUVuaWR1TzhnU0RBaDhMM3R1UXl3NUp6ZG5F?=
 =?utf-8?B?ZEFSL21vVEF1T1M5akhZQ2k0b2RmTHk1M3ZzLzhBRWV1eGxuQ2VBNTlhenRt?=
 =?utf-8?B?alhEamdIc3NiYWtTMVlYTEhmZ2Vneno5Wm1kaXlhZVhWcnpxL3lZbng0aXNU?=
 =?utf-8?B?U3Jrb1lyQzJzdXM1MjdkTnd0eE1ETDU0UmJNbUZlVDV2cjZJMjVVdDduV0ZU?=
 =?utf-8?B?WkI4cDR4NEZtNC9FSE5xUkt5ZEE2aStEdjJtY3pGN2tJUzlyaGhmY0w3dUor?=
 =?utf-8?B?SXN0RUZJS1dLd0dHaVRSOS94SUhjKzBmZXJHWkgrd0pxeFJWS3JTRWR3MFM5?=
 =?utf-8?B?ZnZuYnk3ZUNzZlJCMDRHdE9pMy9SalZpTEVCbUQ3blhZWmNLMC9KamZVQnBx?=
 =?utf-8?B?QUVXb0Q3bnJQT0J2WjVjdnp0aytwMTlzT1FrMjhNZkd5ZFZXZnJ1UzFiQVBw?=
 =?utf-8?B?YnVaN3dZYVJWVC94OUtDVWJCSENWZE02SkxXeTlic3VUNkJhaVJqeFV3V3Np?=
 =?utf-8?B?STJZQXFZRFFOYUtsTDFrY3Y2WTZZZWF5ckdUeDFHMkg1UVhqVmpKdGcwbm4w?=
 =?utf-8?B?NTI0UVE5VFArT3IyMG1QRmxBNkRITjA5cGR6ejF5SnlZdXBJelVSYzU5Ukx0?=
 =?utf-8?B?dTg5a0tVWktQZHVwc0ZFTzhpSCtDdWF4NGtONU56R0VINUxERXpBNkpEaCtN?=
 =?utf-8?B?dFpTbWtIU3pJOFpGalMxUlNGSXViQnJVeXZGdzFHZTM4K3YvbEx3dktFamZH?=
 =?utf-8?B?WUx1TWw5VC9wUTJxakZRUWJybjY3ckU4ODducFZjQ1ZlYzdlci82VnpqNDgz?=
 =?utf-8?B?OFZ1dzRiSlp3TEtkcldJaWxYQklWdHpYZnFRdHY4am1OeDV5SkY4OUd0SnJz?=
 =?utf-8?B?NktEUmJCWkhaTnJZQTFBMVVRbWk1RkNackE0VmNhckpnVGRZQjZDUEVtVjAy?=
 =?utf-8?B?WWpWMU9Mb1VncFovejhiS0dTdGFBZkkxQkNvR241TUJzSFRnZGpWbHpxa0FX?=
 =?utf-8?B?OGErSUw4bUkyYUY5eWY3c0ZQV2dzVFNHeVp0dzBQZzBvbStNRlU0VmphNnVS?=
 =?utf-8?B?VzJ3L2tNVDd6NEdneDZsM3Q4RVdnbkRFZzBwYTNQdGRMMnJpdUdpMm5MVUxT?=
 =?utf-8?B?RGk4TXNNQWFoalo0YzlPQm13Y1BGam1BOW9seVNUMGZTVTV5MzBkTEUwMjFL?=
 =?utf-8?B?TEJpemFFcDBxbmdMRG1hK0NPUGtqbU5yMXJIOHFkWmxacmcvTjUyaUdKQTho?=
 =?utf-8?B?YVRxbXNvd08zOWdXRXNLN2YzQVdqZUtQK1BkQ0hrcUxMbTBpWG82N0dEMTdH?=
 =?utf-8?Q?DJko=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6884.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5608
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	484aaf3f-370c-47db-9a7a-08de5cc9f1fd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|14060799003|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW41THdGbmo1bHUrMmN3NTJOZEw3TW5OSzJOeWZ6dzFvdUVCN0lWeXliWDdz?=
 =?utf-8?B?WEJtZHRrTjRnUlpCUnlla3FVcDJOdkpIUlJrTmpkUlJ4clJnbWZWNnFoc0dS?=
 =?utf-8?B?SEE5UXJZSHZpSkhRaXVXY1E0RnRRT21XWVpncjRRZE0xMVBhNzR5bkh0dERF?=
 =?utf-8?B?K3ZNNVU3eGp2OVF5empGenFGSW0wUTNoUGlKK1lDVkhnMmN2dGNtTlN4akZB?=
 =?utf-8?B?VnJwU2Y0WC9wWFRPWE4yTzhsYlhpSVFZK1U5MWxKeVY5OG5aTktKVWN3TWZ1?=
 =?utf-8?B?cmVEUE5KQ2luUWNXRkhPTzVuSWtmUmk1MVFENVQ4cUc4NXF5cDdLZUNremhz?=
 =?utf-8?B?YTVpM2pOYzNGb2NpL3czaWF2TERqWU5LV3NqMkI5Nnd1WktWanUxblYvWlR2?=
 =?utf-8?B?VWhMUzNpdWVoalUyN2VwSDFGbUJhNDJXbDFMR1NUZ2VMVUR3cDExYXZ4MHF3?=
 =?utf-8?B?U3krSGxVRGlBZC92MDV2S0IydFhoR3BZdlpCNXVOM2pmWHN4dmJHVjAvekUw?=
 =?utf-8?B?NHFVSWlVVWxHMGNWaHhXeFFrQmNVbWg1WEd6THdMWDlIeGZCMnB3bzhtck5J?=
 =?utf-8?B?S0J5SmpGclRYRlIwRjM3SjVNU1NuOWV4NUMxdVRFbFNtTVZJb1NDUUN4MGhF?=
 =?utf-8?B?LytQR2pQRnZlT1V4RHVEWDZWU0g3SHpOU0Y2eFIwZ2tVVmVyYkJvaGFQa2ls?=
 =?utf-8?B?RFpWV01ma24zUkFtUHg5SjBxbGNWNFpKNFdISU91THZuL21ISVB3L1ExamI2?=
 =?utf-8?B?QVFKWCtXRUp0YUJ4YkZNUG1yYkNXanlaNHR2b1dFWWNZSThGcWJYVittMjBH?=
 =?utf-8?B?S3dYbEdqQ0tjUzNNU2ttMjI0OStmTXNoZXl5VVRzbGN3TFZLZE5rY3VxZlpG?=
 =?utf-8?B?MHJiWHFJSHlqbXk4K201d2hHSjNPNzlWZjZqU1kxeE4vYno2ZHhjdk1lSWNv?=
 =?utf-8?B?ZTlCRGxKVG5RU1lpTTlmcmxtV0FpY3pMQms3eGUxYXdhSm1pK1hRQ2lMMzNO?=
 =?utf-8?B?UXljL3NxK3VQL1pjWDVxWGs1YXd1VWhRNTJmUTcrc0JmL3pFaU40aHk3VER2?=
 =?utf-8?B?L08yVEhNT2NtbFpZRzVENzdEdUJYV1lUUi96WkRkdGlSTXlIcWJ3MWE0V1VU?=
 =?utf-8?B?dTl5V2IxK0ZOUEloRTdFb2dLRUQyN3lXSmhVUXEzOEJUb292SW9hbUw5cVlm?=
 =?utf-8?B?QUdWRE03Yi9jKzIwVTJkV3pqdnhNSzA1aWErNW9PZ05DUVgya2pMNGoxaWRP?=
 =?utf-8?B?TGFCMzg3V1k0N3o0bXJ2MDlFWDhvZGpkZFNUdExnaDdNRGRLcHNtbTEyQ1pT?=
 =?utf-8?B?ZzZQVmJoNVk5YUR5Znc4T2cvczNFSS91d3VCeUZyZThtSmVQTXRWRVFZV0NO?=
 =?utf-8?B?ZVh2UnFxRjYrc2dHUmk2SG5QcTJoYmtKbWlBRnFiL3BxYWZ5OU95d1FFdnJy?=
 =?utf-8?B?Nkp4NGVlL1lZWklCS3dEUHA2bjFDQWVyU1BKdi9Sdk5lUUwvOFFsWDFieUhn?=
 =?utf-8?B?Ukxva3B2TUFSWUVDOWdYOUQxSitwM20xcWVCTXpFeWZKVGZNaytPTnpJWURH?=
 =?utf-8?B?OWg1dk1tdEs0TEhTcm5CRXMyWEpCaExFczA2RXMrbXhXVDVnM1ZFV01LL1RB?=
 =?utf-8?B?SHErVFZJTW9RT3lGSnJmMG5hdlhPaGRIcElkZDFleFlnZWsra3pSOGR6cTRx?=
 =?utf-8?B?SXR4Nm01SGZnNTBNaWJLTUgvU1k5MDJnR3BLREVoQ0FEZ2tLd2lsWVJ2Y1U4?=
 =?utf-8?B?WWNwQ1JKVDd3dHNWSHFtN0hZa3VRMmwxMk9laCtHWFI5K1pXYWNSazN2cnp4?=
 =?utf-8?B?Z0M4YzdkMVB1UmdFUFpaSU1WT3IxZFJzTkVsNVVHSzVxNjdCWVZOTnNXbkNX?=
 =?utf-8?B?dHJGVUpsOWNSa1UvZDAwYnpZQjFiVUphZUhybUIwN3IrcVMyRVlLUFB4eGZq?=
 =?utf-8?B?SEYrZUYvYzFXd1BibWhtMEVDWUhUSEdweHduQXhEMkJxVlplZFRIeFNoa1dj?=
 =?utf-8?B?RG43eWVxSTcxL1Y5N1NoczZXbjlMa0x2UnhWY0h4ak9uc1BGa3JWVzBjaDhQ?=
 =?utf-8?B?OWdrRlk0ZUZMMGluZ0hDbjBva1YxQjJFZlRYZU8yYWFHYW0vOGtNQXBlSU5p?=
 =?utf-8?B?RmMveVVaSzRFSlgyTDQvM05UdTRkVUJXajRYQmthby94MDNkdVoxMDRKemtY?=
 =?utf-8?B?WUpDVzRCejdLcTQwMVQyOUNTZFlJWWxwM3lLTW9RQVhoT0xFMlg1SVlyYW1o?=
 =?utf-8?B?QUtPVllGZkZ4WFZoVEZiWEhGbU5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(14060799003)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:00:18.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e9ff4-2607-4f35-58c0-08de5cca17ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-20612-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9D52A876FC
X-Rspamd-Action: no action

On 20/01/2026 11:15, Borislav Petkov wrote:
> On Thu, Jan 15, 2026 at 12:17:17PM +0000, Ahmed Tiba wrote:
>> In drivers/acpi/apei/ghes.c, this subset of CPER handling
>> is already implemented using a number of helpers mostly named
>> estatus_* rather than cper_*.
> 
> Which helpers are those?
> 
> $ git grep -Ei "\Westatus_" drivers/acpi/apei/ghes.c
> 
> doesn't give me a single one. Maybe I can't grep.

A simpler grep that catches both prefixes and suffixes is:

git grep -E "estatus_|_estatus" drivers/acpi/apei/ghes.c

>> The naming therefore originates from the existing GHES implementation, not
>> from a new abstraction.
> 
> And even if, calling it a "estatus core" and making it a separate thing is
> just confusing and unnecessary.

Agreed. I’ll drop the “core” framing and keep it as a plain shared 
compilation unit with exported helpers.

>> What I did was lift that existing estatus_* logic so it can be reused by a
>> non-ACPI provider, rather than duplicating the CPER handling
>> in a parallel DT path.
> 
> Nothing wrong with that as long as you simply export common helpers and we
> agree on how they're going to be shared. We do stuff like that all the time.

If you have a reference series that demonstrates the preferred pattern 
for doing this, I’d appreciate a pointer and will follow that approach.

>> Because the DT-based path still needs a clean way to call into the shared
>> logic without dragging in ACPI plumbing.
> 
> Yes, carve them out in a separate compilation unit and select it in your DT
> glue and that's it. No need for a Kconfig item and calling it a "core" bla.

Works for me. The only question I had is where you’d prefer that unit to 
live so it can be built without pulling in ACPI/APEI (not gated by 
CONFIG_ACPI), while still staying under the ACPI/APEI maintainer umbrella.

Would you prefer to:

1- Keep the shared unit under drivers/acpi/apei/ but make it buildable
    independent of CONFIG_ACPI, and have both GHES + DT select it.

2- Place the shared unit somewhere APEI-adjacent but not ACPI-gated so
    it remains reviewed by the same folks, and have GHES/DT both link it.

Thanks,
Ahmed

