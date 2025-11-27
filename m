Return-Path: <linux-acpi+bounces-19320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E25C8EEE3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 034CC352DAC
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3F334C00;
	Thu, 27 Nov 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LkHboJVD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LkHboJVD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF811334681;
	Thu, 27 Nov 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255292; cv=fail; b=AzWFXaCDS2RwFoc7XSmXvYL8XhgdWyENobSungl0Z6nJIFb3afbWesYQt0FGvJhR3R9AGw+8wV08Z/THJA19Rw9Xkd4B3nFK232RE4bYVw3OagRjUH054HGEedkdd7O1uwdJ7rRjs0MYtXnQZKqF0DViw+vk5BcHilAyH8stBEM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255292; c=relaxed/simple;
	bh=Pt4fcq8dDmFrzL3U4bKskj/JkIjm5/vmEdWrWDjxBEc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZHP4OzcYXF4QvsbxMT8xrAz/berHzw6jeQhoHYk3mgRTT/HoEEdaGGAfSbVYN6DOYbDLewTOeSPd7xGfNCq30Rr7TEE3+7AUGFX+t8UNmrUerh3SEMUnt7osvJN1UFTbNc3fC8Of5kAXa2zWFMc+nWX44qIfXmtou9dhAnbnR8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LkHboJVD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LkHboJVD; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=m9eA8IW18WOcCesIiqn3qto369Q8VXUlO39fgEnAk+6tOJWP4WU4Ng3TmXhIlEJqgWA1UZ+AvIRIhSuS/H7vOY7wz98P+CIb0YQamNKbj9t92CR0Tj4c02dlU4wuNDFZ7lIxcdYh7Nj44NdGmR7DuN17I7tBKkLSduwXmpiUMQADBUlA+6fyh8mTve4qJqdsQ+suPDfUC+nAGs9A6mJ7OUEwijUZPxhIaILu3OPiePQ6OE/xaMyhW2VABt7RgKHQH6cxZiYRpudadOeSFiF+H/R5MhOJdUIs5YmF+yDuY9CwClydIUccYGaoEqEKgJs2eUsOB6eGCPwcI8Ll/g7bOg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5+rK0O1rumH0zS7pbKU1vFJZ0wa1guJTi9ySEwYdAI=;
 b=A+RI7rfGwTMH23OS0QhdrFtTYpe5210/LFUU8wAmU3buG9Khi8pKbSSDwcJ3f+RGWukFwI8CWssx2eve7YIAdjM1UUWbjMmz4uZAyxcvrZ3zStxJZ1T342hq2a0Omf89NpI1ZxO9cVKou688aZjIckUxgsQD2yt2vD4o1ynmTUQBZxvhKmqY6ZhHki6QPlSjxa1Xae5CDT4kMkN7R/JUUH7WY0FP9avCAhIfPfqoqs2NZ3hRl9CnQOXUjRxkI5B2hHYVWjG4NKSa1Qy3bmP5G/BvPXg8dhu8nVeQmHORMxLOHibYXLKePSYmMd0bDEsxxs9TahQ+eQPpR6eH8fdjAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5+rK0O1rumH0zS7pbKU1vFJZ0wa1guJTi9ySEwYdAI=;
 b=LkHboJVDttwQxWPPsfjjCna72HaAhhw6R9zSU/yf9cnZrxuBh4zqqg71zrTIfi/2GKsKHPBkRSHKW4r5UnyUGEBH6evHuF3WsH7JBUpOevo0GCYbfYoKo7/JkpLeMRF0B7KI2tu4InZ7Kd9BsLLU6Jg3zFqb0zpC+SlB4uR+fbo=
Received: from AS9PR06CA0440.eurprd06.prod.outlook.com (2603:10a6:20b:49e::35)
 by AS8PR08MB8777.eurprd08.prod.outlook.com (2603:10a6:20b:5c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:37 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:49e:cafe::1a) by AS9PR06CA0440.outlook.office365.com
 (2603:10a6:20b:49e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctbpGNNORA7dm47A4HxN5/PDsmPxv/ox8jOS90fv8b7rGCE3XKj+kDh4/o62JSIbmSFsmaDPH26lPdyucA6mIgmnc1I3vnP57In5vepTRutTgAW+P/fqXT/0UV2CVRhHR9IHMYnkEAxOi5gjN7LCNJnH8ao2qTOLAhQzymqAeZM2hLNfqC6nfU4EKUGbnDhY2O+g/sR9914pdu/NiMEP/VMWo8OWFbhAg5/LB9xv3pW2WV7k+kpZnJbOo7OhNa/f0kL8OSaiew9CrZSIrEM5RH4zNG11Sjy9gwtq3qDzpnLkTMrvlbRdo+3yTsyR4AokU7DPt+ZmsuqoVYEUPlNlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5+rK0O1rumH0zS7pbKU1vFJZ0wa1guJTi9ySEwYdAI=;
 b=oGeOeJbyUyt889N3FD/o14Xe6QzgObakDZg12f/AtJAuRmY3/4347+PCgX1aTKmj1SVANpizbHi9rd2myFekEtjF9UzmH0wxmx2PogmBNArcYs1oZ0XxLVCefu+NnPhmubHOEuVLcofWKsBsJxsO6Fhib5Whjez3ay5slWa3+1YDASO/HgnKB5O6ACZK89Dl03sG4b5X4lIvYR7Q5kztRHMTeMQ2xHremsCcTFT0IbkYs30PP+01tf4za1XC/tnMPY9sbkOEuq1xL6QcGRCdfRuLBO5ll9rUlCPLHchOPBRH5KX0bPWbrgtlRvmYdBgBup9cTPSci5ph/eolEv0fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5+rK0O1rumH0zS7pbKU1vFJZ0wa1guJTi9ySEwYdAI=;
 b=LkHboJVDttwQxWPPsfjjCna72HaAhhw6R9zSU/yf9cnZrxuBh4zqqg71zrTIfi/2GKsKHPBkRSHKW4r5UnyUGEBH6evHuF3WsH7JBUpOevo0GCYbfYoKo7/JkpLeMRF0B7KI2tu4InZ7Kd9BsLLU6Jg3zFqb0zpC+SlB4uR+fbo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:04 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:54:04 +0000
Message-ID: <08c65096-dc70-42dd-a085-900605c3fe4b@arm.com>
Date: Thu, 27 Nov 2025 15:53:59 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 8/8] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, ray.huang@amd.com, rdunlap@infradead.org,
 zhenglifeng1@huawei.com, robert.moore@intel.com, lenb@kernel.org,
 viresh.kumar@linaro.org, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com,
 rafael@kernel.org, gautham.shenoy@amd.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-9-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-9-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|AM3PEPF00009BA0:EE_|AS8PR08MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cf4477-da55-4af3-c7eb-08de2dc4e2d0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VGl0cXM0Wld1TlB6SzdpSGJSMDd2VFBoTlZXL0FjREVBQklLMmpXZjgvT1FR?=
 =?utf-8?B?OExHSnR1NytVUUsyZ3NhYW84MXE2d3lXRE4vZXVkZmphdzNObFI3RW9yZFF2?=
 =?utf-8?B?alV4a1hKYWFCUEhzL0ZPKzdKSE9yUnBneCtMUlh3d2g0a05sRDM1bmpzLzZ4?=
 =?utf-8?B?MllHdVZZL2YrOTJSV1JMa2MxanoySTN5eHBqK2VSd0RhQ2VyWXpwZiswVGFw?=
 =?utf-8?B?cHprWml3Z0pxeU1DTDl3SmE2NDVOZ2gvMExxKzZzVElJUXRQWm1sMWQwZ3F6?=
 =?utf-8?B?L0FtblFWL3pQV2FXR0psRW1JaEZ6eG4ybTFuZFlUU2paRXJmVjBMQmFrV3h4?=
 =?utf-8?B?NTRFZzE1eG1zbDJLT2RZOXVDUzArY1lMQklzNjNBUWFEMkRLRzdHdHJHQlZD?=
 =?utf-8?B?c1hJU3ZRdStYRXA5b2RUNTJBaXl1a0RkcExDUWZYb0NJa2NRSFV0ajFIMk0r?=
 =?utf-8?B?U1E5cERQbnJUU3B4T2RsQmxoVlVjdkw5K2wxT0JuOGRuSmcwRnBLZ0hjM25q?=
 =?utf-8?B?V0NnS1hqWFdhWWVLbEZGZXEvVG9IcGVSMCtnbzRpZjRrQzA2VGxFQXIrL01H?=
 =?utf-8?B?d25JelNOeis2WGpmc1p5cG1iVVRDNHE2UmlETGpxTTNEQkN1dk5ESk9YVlhl?=
 =?utf-8?B?Tko4cWNFU0FNZU0yeEJLUTYwZ1dhOWRRMmRDSzRDMWVWN3RlR0x3SWtOdTBI?=
 =?utf-8?B?dkp6WlpMMzIvWnMzSDM5ZHE3ZnJtSzI0TDRiSE13UGI2bGV1NitHMlZ0UlFC?=
 =?utf-8?B?L1Q3bzJ4RFpLSUVrSmF6OWZPTFkyLzhpLzl2endTeVpqRVE4VXorNWZuUlNH?=
 =?utf-8?B?YjNHR3hrY2Y0MGlaTGV2TENzN043V2lsUVh0dEhickE1ZVdIYklYVjBhVmlI?=
 =?utf-8?B?dUgzUzE2Z3FDT0grdnRUdVBVQjhVNnRvU0tHaFlHa0M2NlI0RVVmWWdKQ2xk?=
 =?utf-8?B?SlBDUFd4YzJZOFVrS0V4V2phZ3ZMK2svelk2WXdkZktsVWZJTFU2WVRYOTQr?=
 =?utf-8?B?NFpoQTdDNXZSTGNDOURvYUh4Z3NYVE1XblBKNXVoWmxaYkE2THZ3K1BnUU9P?=
 =?utf-8?B?TDNnNm5JWG1TUjhremJ1OUg2cXlFUzhPQ1FaNzY5LzBUR2ZUWWJBRmxOODFV?=
 =?utf-8?B?TCtmTTFxRXJYRUE4alZuV3BvYWZMVkJDdGtVRllOd3l0UXhWMUFDQTcrWlZH?=
 =?utf-8?B?QUhWM2thRVpxMlZJSE4zT09Ca1QxTmtIMmJ5eisydTBDR3NmVHM3MjgxRUFO?=
 =?utf-8?B?bDNxcmFNbW1CRTdBODJBWUZ4cHN2S1Fnc2VQaWROR0RxTVdVTkJRek1zKzNm?=
 =?utf-8?B?RWtxYUtla0pxN1hCakFEd09aVUZZOE5Sc1JoYnptSDBtVHgwaWdpbWxwSk02?=
 =?utf-8?B?SmN4TTU3eklBWmlqZE1tU3NqQm1zZU1QNlVSNmZnYmRrL2tqRkEwY1NTR3c4?=
 =?utf-8?B?Zkw3R2NWN2ZvWjhPVkIyL3JZUHFJZklWVGJmTVAxQitzUlFqSGlnNXMybGNM?=
 =?utf-8?B?ZWlMSTZBNG5RektXd2tNelFONzM0ZTM0RDMvdjZoOW54dUJOVHRSNkhxTkxv?=
 =?utf-8?B?NG5PMjBMcjljb01VYlVlQmYyNkxQT3lyU1R0VlkxcTRFbnljeVkveHNFMVI2?=
 =?utf-8?B?aEQ0d2tkRWI1ekVjS0tmWjFJc2ZyU2E3UFpjNnRDZ1pzUkZ6aHlaTTFFRFFz?=
 =?utf-8?B?NFZXcUlPNzNSV0daVlpDTEx4YTJaSlY1KzNsZk9jc2FMalJSMW5QVU43MjBL?=
 =?utf-8?B?ZitPQlNDN215QjBxVmdZN0NYbGM4dGI2bjAzaVQyVUJxSlV5S1FtaEJZdWZn?=
 =?utf-8?B?TkdWMUs1Yk5ueDVLWjlPSEJYeTA5NTVZeENmUXc4ODB4eDhNaFJMYjBsWkR5?=
 =?utf-8?B?RlZyUEN5OG1xbmRha3VOeEFubmI2S1RROE4raW5UOFlXZlpuWlJHWmlSK2Ny?=
 =?utf-8?Q?5kGvuEKZv1IYHWhRD0gh/lsgFU6Xu9tM?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a6989983-2211-4e1a-6c1b-08de2dc4cef6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|7416014|376014|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTBhQ0VSZEFEVWpMbjlpRGRna2cxUmlINnZBWHpQMU5EWXozMkdpOWhJNGJv?=
 =?utf-8?B?QkwvYXRudEl5UmJYMjhzTmh1VEJBbXRTMGlrMWMrTktnOVluWHh2WnFQZTRq?=
 =?utf-8?B?UmpSU1ZDOWFRRXZrSlFHQ0IxZlY1S1ErcHQyM2h1ZnNaNFRDdElqWUs1N0xG?=
 =?utf-8?B?eCtwSzFRUmw0UjEvckIyRFZCYVRmMHg4WTVmckwvREtMd1R4VjF5Nk9FUnFC?=
 =?utf-8?B?R2dHTXZZdEVMakVsT29SMnhDaHJ3TUFYVWNFWUpQYW41djBDUU0zUEpRaFlY?=
 =?utf-8?B?RWVSUHAvQnA3ZEtGbzJ5eEtRYll2RGVwRWoxRngwcW9RV2ZhbTdMZzdZQ1Rz?=
 =?utf-8?B?dFlleTg2ZS9PYldRZzU0aFE0N3p5TzNJaHp0R29EMlNkSW8vZWIvY2dRMENM?=
 =?utf-8?B?dGcyN01XWkhEMFM1R2NBOUJBYjkzd0wvSzM1bGt4K3A3anBlb1B0OGpyUUJS?=
 =?utf-8?B?T2JwRzdaQkJjZHJvZ1dYZEtlRVFTRWRDUnllTWYxelZkRWs2VVpFOU5PSlFR?=
 =?utf-8?B?ckxuZEVreGxkbTJGZjNUdksyeE5YTkVkaStDMXZuUFVVRTNza1JSTzE4THd0?=
 =?utf-8?B?WDg0UzloUnp5dFRTekhnSDB0MU8xTDlpZFhoYk9MbUo0bFhYS0Y0aXk2T2th?=
 =?utf-8?B?Tlh2emtHZjgvTHNySXQxTVl2VmFRNnhrYXFVbGhGdVNiZmZoTk1wc1RBWG5V?=
 =?utf-8?B?RTczR2RPYXBoQmpTd1ZvbDk1MGhKSndlNUN6UG9jOUM2QlNKRGVMeXJvVnZy?=
 =?utf-8?B?TUI1OGp2eVBEZURBVHFGMDBHL0MzTUNYQjgxZUFFM0llMHFqd1R4SGh2OGtR?=
 =?utf-8?B?aWIydkV2ZkorTS9YQk5oL1R3YUlZM3RYbmloa0l6ZEwrUFNRRVZ1dzRBSTJC?=
 =?utf-8?B?QXFaUHBUK040cUd5QkhMUGxSR0FGMk9RejIrWW1GbkRLZjRZOFc1Q3VmWmd4?=
 =?utf-8?B?ZTI0ditWOFpzalNpNEU0SXNrVzNZUDRYU09YQms3NEJBS3lnbFlxWEZoU2pB?=
 =?utf-8?B?MndzMUk4R3lZbWNnT2ZSMi9oWnNEOEQ0clNqcVpmRGFwMWpYTDkwaW5hRWFN?=
 =?utf-8?B?RXl2YmNLelU5Q2RhWWNhRjhlU3NCQk9TQVcyQm4vNmh1NVNUSkxhcjJqTFZN?=
 =?utf-8?B?emlOcmQzdHZFSlVsbzJxTkhOelA4L2dqR2Rub2FVTFpjdFY5QUlONzJqMklk?=
 =?utf-8?B?MnY1M2cyNFpOWHhuVm5JQXBSWVcyQ3R1dS9YTlFkdUh4S1NScUt4d3dyWkpB?=
 =?utf-8?B?MHRMSHY5UW5NTGxrc3A2MXFML1NVWE9VZWdyMnlWeU9mR1poTy9Kbzd4Y1FY?=
 =?utf-8?B?K2tjamFrdkNqQlZ6NDVPbXNkZlhkK09IeHpxSzdmeUJEOUZZQXFYTlJYTkxC?=
 =?utf-8?B?QWM4Y0pGR3QxdlRpNDZkZDZQMmdkdU85cHNIUkFpL1dSSWxxTGNrYTRJaGdG?=
 =?utf-8?B?UDZpSE4wejNzTDNFWWRicFhtK2x1b0ZUVGxUcUVycVJFYW5PWGNwRmNaTnhM?=
 =?utf-8?B?VFhyRE5EdE1wcWpHYmcxOWlxNFlLWDlGS25RMjJnTzRJdGxtS2dYdGkxcms5?=
 =?utf-8?B?WmhGY1l6MkROWFZONEU2MVd2MDkzL1kxMDdNWjV4a3doVDV0R2xaT0IvejdB?=
 =?utf-8?B?L29tN3ZsUytOV3FwRXJxTFdmRi9kTzhyMlB3RFBLekllTkd5MXJNNlJTSE0r?=
 =?utf-8?B?ZTg3NzZGQldmcTJTcFlLZU56bkFzOGpMemswNE80ZHFWZktSZ00wYVZKR05P?=
 =?utf-8?B?SU5SVTJDK1hoNmIxOWNXQ1l4N0hTTmZOR2dxMFV1TDJvQ2d3Ritycm9XeTla?=
 =?utf-8?B?OHlBVTNZVHVHYmF3a2o0OUhCenFNRVZlbW1tMis5UGUrTjJKVy94bE1Lek44?=
 =?utf-8?B?RGIyaU5xeElSQUhQWXEwQXJqMWtFWXZYN1FzWnA4R3gwWDVBQ2E5UzczRHUx?=
 =?utf-8?B?QjBSa3h6Y2ZmZWEwV2l3cEJzSUdmYmFJZUFXRUk3dm56ZUx3SGNwUFoydkxS?=
 =?utf-8?B?SWFoSG9HVG91STJ3YVN4cm83L2FBT2s2UlM4TzFkWk9pb1ZFeTBGa2oyM0ZP?=
 =?utf-8?B?S3oxd2RadEh1b1ljS2JVektNb2JoUGI2MnRockR0em44VmJBaUpURlV1T3Zu?=
 =?utf-8?Q?5SbY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(7416014)(376014)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:37.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cf4477-da55-4af3-c7eb-08de2dc4e2d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8777


On 11/5/25 12:38, Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection at system startup. When autonomous mode
> is enabled, the hardware automatically adjusts CPU performance based on
> workload demands using Energy Performance Preference (EPP) hints.
>
> This parameter allows to configure the autonomous mode on all CPUs
> without requiring runtime sysfs manipulation if the 'auto_sel' register
> is present.
>
> When auto_sel_mode=1:
> - All CPUs are configured for autonomous operation during module init
> - EPP is set to performance preference (0x0) by default
> - Min/max performance bounds use defaults
> - CPU frequency scaling is handled by hardware instead of OS governor
>
> For Documentation/:
> Reviewed-by: Randy Dunlap<rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  12 ++
>   drivers/cpufreq/cppc_cpufreq.c                | 197 +++++++++++++++---
>   2 files changed, 182 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b8f8f5d74093..048f84008a7e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -929,6 +929,18 @@
>   			Format:
>   			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>   
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance selection.
> +			When enabled, hardware automatically adjusts CPU frequency
> +			on all CPUs based on workload demands. In Autonomous mode,
> +			Energy Performance Preference(EPP) hints guide hardware
> +			toward performance(0x0) or energy efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register support.
> +			Format: <bool>
> +			Default: 0 (disabled)
> +			0: use cpufreq governors
> +			1: enable if supoorted by hardware
> +
>   	cpuidle.off=1	[CPU_IDLE]
>   			disable the cpuidle sub-system
>   
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d1b44beaddda..0a55ab011317 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,8 +28,12 @@
>   #include <acpi/cppc_acpi.h>
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
> +
>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>   
> +/* Autonomous Selection */
> +static bool auto_sel_mode;
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -272,8 +276,13 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>   	freqs.old = policy->cur;
>   	freqs.new = target_freq;
>   
> +	/*
> +	 * In autonomous selection mode, hardware handles frequency scaling directly
> +	 * based on workload and EPP hints. So, skip the OS frequency set requests.
> +	 */
>   	cpufreq_freq_transition_begin(policy, &freqs);
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	if (!cpu_data->perf_caps.auto_sel)
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>   	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>   
>   	if (ret)
> @@ -565,6 +574,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   		goto free_mask;
>   	}
>   
> +	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		pr_debug("Err reading CPU%d perf ctrls:ret:%d\n", cpu, ret);
> +		goto free_mask;
> +	}
> +
>   	return cpu_data;
>   
>   free_mask:
> @@ -666,11 +681,81 @@ static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool a
>   	return 0;
>   }
>   
> +static int cppc_cpufreq_update_epp_val(struct cpufreq_policy *policy, u32 epp)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	pr_debug("cpu%d, eppcurr:%u,new:%u\n", cpu, cpu_data->perf_ctrls.energy_perf, epp);
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
Do we need to take the mutex ? Or is it reserved to auto_sel ?
> +
> +	ret = cppc_set_epp(cpu, epp);
> +	if (ret) {
> +		pr_warn("failed to set energy_perf forcpu:%d (%d)\n", cpu, ret);
> +		return ret;
> +	}
> +	cpu_data->perf_ctrls.energy_perf = epp;
> +
> +	return 0;
> +}
> +
> +/**
> + * cppc_cpufreq_update_autosel_config - Update Autonomous selection configuration
> + * @policy: cpufreq policy for the CPU
> + * @min_perf: minimum performance value to set
> + * @max_perf: maximum performance value to set
> + * @auto_sel: autonomous selection mode enable/disable (also controls min/max perf reg updates)
> + * @epp_val: energy performance preference value
> + * @update_epp: whether to update EPP register
> + * @update_policy: whether to update policy constraints
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
> +					      u64 min_perf, u64 max_perf, bool auto_sel,
> +					      u32 epp_val, bool update_epp, bool update_policy)
> +{
> +	const unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	/*
> +	 * Set min/max performance registers and update policy constraints.
> +	 *   When enabling: update both registers and policy.
> +	 *   When disabling: update policy only.
> +	 * Continue even if min/max are not supported, as EPP and autosel
> +	 * might still be supported.
> +	 */
> +	ret = cppc_cpufreq_set_min_perf(policy, min_perf, auto_sel, update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, max_perf, auto_sel, update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	if (update_epp) {
> +		ret = cppc_cpufreq_update_epp_val(policy, epp_val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = cppc_cpufreq_update_autosel_val(policy, auto_sel);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("Updated autonomous config [%llu-%llu] for CPU%d\n", min_perf, max_perf, cpu);
> +
> +	return 0;
> +}
> +
>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int cpu = policy->cpu;
>   	struct cppc_cpudata *cpu_data;
>   	struct cppc_perf_caps *caps;
> +	u64 min_perf, max_perf;
>   	int ret;
>   
>   	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
> @@ -734,11 +819,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	if (cpu_data->perf_caps.auto_sel) {
> +		ret = cppc_set_enable(cpu, true);
The CPPC enable register is optional.
However this doesn't mean CPPC is not working.
> +		if (ret) {
> +			pr_err("Failed to enable CPPC on cpu%d (%d)\n", cpu, ret);
> +			goto out;
> +		}
> +
> +		min_perf = cpu_data->perf_ctrls.min_perf ?
> +			   cpu_data->perf_ctrls.min_perf : caps->lowest_nonlinear_perf;
> +		max_perf = cpu_data->perf_ctrls.max_perf ?
> +			   cpu_data->perf_ctrls.max_perf : caps->nominal_perf;
> +
> +		ret = cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, true,
> +							 CPPC_EPP_PERFORMANCE_PREF, true, false);
> +		if (ret) {
> +			cppc_set_enable(cpu, false);
> +			goto out;
> +		}
> +	} else {
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>   	}
>   
>   	cppc_cpufreq_cpu_fie_init(policy);
> @@ -910,7 +1015,6 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>   	u64 min_perf = caps->lowest_nonlinear_perf;
>   	u64 max_perf = caps->nominal_perf;
> -	int ret;
>   
>   	if (enable) {
>   		if (cpu_data->perf_ctrls.min_perf)
> @@ -919,26 +1023,8 @@ static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool e
>   			max_perf = cpu_data->perf_ctrls.max_perf;
>   	}
>   
> -	/*
> -	 * Set min/max performance registers and update policy constraints.
> -	 *   When enabling: update both registers and policy.
> -	 *   When disabling: update policy only.
> -	 * Continue even if min/max are not supported, as EPP and autosel
> -	 * might still be supported.
> -	 */
> -	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
> -	if (ret && ret != -EOPNOTSUPP)
> -		return ret;
> -
> -	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
> -	if (ret && ret != -EOPNOTSUPP)
> -		return ret;
> -
> -	ret = cppc_cpufreq_update_autosel_val(policy, enable);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return cppc_cpufreq_update_autosel_config(policy, min_perf, max_perf, enable,
> +						  0, false, true);
>   }
>   
>   static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
> @@ -1146,13 +1232,61 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.name = "cppc_cpufreq",
>   };
>   
> +static int cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64 epp)
> +{
> +	int cpu, ret;
> +
> +	for_each_present_cpu(cpu) {
> +		ret = cppc_set_epp(cpu, epp);
Isn't the EPP optional ?
If autonomous selection is available but not EPP, we will bail out.
> +		if (ret) {
> +			pr_warn("Failed to set EPP on CPU%d (%d)\n", cpu, ret);
> +			goto disable_all;
> +		}
> +
> +		ret = cppc_set_auto_sel(cpu, auto_sel);

Also, it is possible that a platform only supports autonomous selection.
In this case, writing to auto_sel will fail, but auto_sel is still relevant.

> +		if (ret) {
> +			pr_warn("Failed to set auto_sel on CPU%d (%d)\n", cpu, ret);
> +			goto disable_all;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_all:
> +	pr_warn("Disabling auto_sel for all CPUs\n");
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +
> +	return -EIO;
> +}
> +
>   static int __init cppc_cpufreq_init(void)
>   {
> +	bool auto_sel;
>   	int ret;
>   
>   	if (!acpi_cpc_valid())
>   		return -ENODEV;
>   
> +	if (auto_sel_mode) {
> +		/*
> +		 * Check if autonomous selection is supported by testing CPU 0.
> +		 * If supported, enable autonomous mode on all CPUs.
> +		 */
> +		ret = cppc_get_auto_sel(0, &auto_sel);
> +		if (!ret) {
> +			pr_info("Enabling auto_sel_mode (autonomous selection mode)\n");
> +			ret = cppc_cpufreq_set_epp_autosel_allcpus(true, CPPC_EPP_PERFORMANCE_PREF);
> +			if (ret) {
> +				pr_warn("Disabling auto_sel_mode, fallback to standard\n");
> +				auto_sel_mode = false;
> +			}
> +		} else {
> +			pr_warn("Disabling auto_sel_mode as not supported by hardware\n");
> +			auto_sel_mode = false;
> +		}
> +	}
> +
>   	cppc_freq_invariance_init();
>   	populate_efficiency_class();
>   
> @@ -1165,10 +1299,19 @@ static int __init cppc_cpufreq_init(void)
>   
>   static void __exit cppc_cpufreq_exit(void)
>   {
> +	int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +	auto_sel_mode = false;
> +
>   	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>   	cppc_freq_invariance_exit();
>   }
>   
> +module_param(auto_sel_mode, bool, 0000);
> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
> +
>   module_exit(cppc_cpufreq_exit);
>   MODULE_AUTHOR("Ashwin Chaugule");
>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");

