Return-Path: <linux-acpi+bounces-9372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D399BF78A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E858B1C24074
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0468A20F5D2;
	Wed,  6 Nov 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nh7Tg+e0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37920ADF2;
	Wed,  6 Nov 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922310; cv=fail; b=oLZiWNwnRJSX9W4c7g1acvbOM+Jm8g9tb3PhdExHcWbLoBaoSpuESPSZopqx18vuwxnaoNfghPmuba2J1+OlpPfje00o8hjvCmMZycqMze6gLorPZkW6LgBtgYTvD3ESMlSPnZwayg+1lIeSi3z8Eh0Fw8HiIRv0v+8yl+F9IAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922310; c=relaxed/simple;
	bh=wh2dm56DUgnUf/hb8pta//5NFU7udHK2ahgcilh4+pE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fp+Gbye8tbrMwv0YHD5Zb9NpIFKf41KK3wOEzHOgqNLX78w18r54sMZFxvz9V3pj+JfDOOZiSAypPLp33Lt2y5thjyopJZ/guNhUmCStVmtW6GG3+kSwEg1ZXCbitAN/VNQKZMuvH5m/dZOkof1vcQ6KfjRzn3psYBI/DdKakbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nh7Tg+e0; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3wqDA8hzwOZ6y8TdEMqDo2pyFvdkHyP0cCMg0zcrGbACz7wTKdb+Eu/jecK06V+FQvdVzBKI0GFszFMvr7iKjamgPuaMSq47LpYs5eReE0zuOHZucFeWaQYogd6uVdV1zXySlOt1yRImUcBHzBOMMs2BTk2eHnHRwASzhOxCEh0Qtvspe7UZhBTP2PpRylTrlKEBlfUfRIIajvIRbN1QVkVa1VgoV491leuh/UplIz8QA7l6lkMgwBYRDK4fMJ1iw72rDcOPDmMzTBh7GY1echifhg3muYdEihhrYOtbiXf/gJ+HLo5CDt2bRMX+ZKyrxYroOG+YbzN5eAkZooXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKGXL7kNe0FdkqG+JIm1fGSJ8EUcZQg3zonFmxQa86Q=;
 b=rwsqOAsJzPk4ixbozBcS67VzO+N5tRu/yTSKDHG1XtaAd84iotEs+NFTSn+kRC2D6VUcWHWXvXkmHDagw8KmyFpEziOc2I3c1T8FrgcgGy5AkH4fTuYLBXCAQuHg+OYy/EtgaigcyXLpgoDeNxhlLPVGbZueAKGmSWXPvr3NsN6Pq01G3MkdPotVi5Jx7PnLZurnH32WH4WGhlYgrSB4RDNVNtkAyxFGdXAJEimEF6Bz1om91/ZOgtsVFIkr2j7lIGtxT9uFkJM0Qd3c8uhYfT7833m6pzxGJJr5R22u9UJiboBBtAlnOcoqI6mpzCW/hOJ1jKKRJcUGWTVu8ZXKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKGXL7kNe0FdkqG+JIm1fGSJ8EUcZQg3zonFmxQa86Q=;
 b=Nh7Tg+e0bLCJ2Y24c72obJGdyxoz8uayBDOEblfXR/Dv/5A3FrC/vBTSOBYXlTP7hii715/gcMEm7oG9o0lB2JW3ZKxBfebl5XvlMbx7PxxCRWE4x4SVsoIzcUz2jGaiIIbYB5/SrRYFJMLKtd73wL+4KCY5eJvw49ORn+Sna/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:45:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 19:45:03 +0000
Message-ID: <30f9aeaf-1cda-4da8-8d09-415a9a0055cd@amd.com>
Date: Wed, 6 Nov 2024 13:44:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/20] ACPI: platform_profile: Only show profiles
 common for all handlers
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
 <20241105153316.378-15-mario.limonciello@amd.com>
 <7a6a5c39-6b53-462d-8da8-0d66261c9c67@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7a6a5c39-6b53-462d-8da8-0d66261c9c67@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: d96737aa-1d2c-443b-5934-08dcfe9b81c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0puYTVCNGN0cVduaS9rNWEzVThBZTZaNHdCOXMzZ1ZEdFh3K1AyeHN4cUFX?=
 =?utf-8?B?NXR4SFZaTjZHcmYxcXNKSzA4K3JvQTZTNDRhdVlmeU1IQkFZWmdvUitKZHEv?=
 =?utf-8?B?YXNMaGxSRktuTStzSGQ1czF5cFA2bFF5cHJjdFRScVdudjNFSWlWbWVBdVZI?=
 =?utf-8?B?RWl1YjAzTlBxN0xlcWpMNndPV3ZrRWVxYXJMbVFtOWgvQjlOZ3hDUGlWYm9j?=
 =?utf-8?B?dDM5UENqWDk0Vy9aTnQrTllIWWRMSWRCYU5FVGZoR0ZjYzc5a2tvWThvYitp?=
 =?utf-8?B?bVJ3QlhmR1NrTFIyU2paeGN4Zi9qRXJPMkxVemJYb3F1Sm5Ha1BybSsycDZo?=
 =?utf-8?B?OXNlTnZ5VXF0dngrRC85dXJaaGdXeGRObUFtN3Nkd0ZGR3hHaEZsdm5Objhy?=
 =?utf-8?B?cWtvM2xDb2JCMmlPeXI5WklGWU8zR01jNUtIaUlmcmhXRVE5bWxEZkpKUzFF?=
 =?utf-8?B?akhvR0txakhFQ21vNUExZittZENuM3FHQlkzTFU3eENtd09udThjTmFsV2NU?=
 =?utf-8?B?aEp5Q1RWQ0VuWDNzVThSUU00dW10WDN0K0F0N3FLVUZlVi9oSmxxcERCSjlQ?=
 =?utf-8?B?SDVoM2lxdXl5anl1dytIcUE1OU01NzRidmpKZlIybWxDa2xsL3FESHYvckhP?=
 =?utf-8?B?c0YwQW9lenJmWnNpVzJBYXhsMkhtTGM0S0c2NmlJR1lIbVNsSEdRanV6ek5u?=
 =?utf-8?B?MUJPOWdqdmdMcTlEWW5zeUFhK3hydmJkQzA3dmVhMVpxT3BISnZYbUJOdUFU?=
 =?utf-8?B?NVBDREJKaWVJWTAzM0IvRDFjWHROTUptU3Q5U2NYdFp5S2lZVDhKWUcyZHB1?=
 =?utf-8?B?VUlYNEZ2Z1dMOVYrRzA1c2RuajZrV3B0Q2s4dFhFWFVqZ0RiS3ZWRzFZeWxW?=
 =?utf-8?B?MC9TWXlhaVhkNUlrRDc1UXZvb056WE11Yjk1emN0cG5VdzFBUWhZTDlRYzNt?=
 =?utf-8?B?Zk52SGdYZ3BQanBiRlc5SUxLMjcwQ0FpY2hhOFEzQW1mY2QzUlVKb2RrOE5I?=
 =?utf-8?B?YXZjMjhjbGxEb1RMU0d3M1cwS2lQNFlwUi9LcW5aS3hsSWlmbG5oYXhTZUEv?=
 =?utf-8?B?eFVoUnlwSnRuTFVha3p5em5MTFBzY21FZ0pzMHYwUm4zK205MTFUK2Rwb3BE?=
 =?utf-8?B?MXk0YkpuM2FReWliTlR1b08wRUR3YnNLb1JCenlWN01vUkRPa3QwTUU2VWpM?=
 =?utf-8?B?dEhLd285SmhUUDVHcS9wMDNyUnRyek41N1lzZ2ZFQzBxcG5ieVFoZUQ1SE5D?=
 =?utf-8?B?ZVh2bXVzUjhaMDdYN1MzQXdDMFpuN2RlTDFFOFlMNHFaemlBMHd2bVhOVnZ5?=
 =?utf-8?B?UTQxSUZSVXdYNTduN3lsZUxPRE1CQ3c3bDR2Y0xoWFB6R2kxYktBa1AzbWdQ?=
 =?utf-8?B?T1RVSEgxT0htR1lPVCtrQzhuOVJNekp5TXdjUS9NT2w5OUtmcVZMb1pSZU5v?=
 =?utf-8?B?THJ5RkxTUXcxbGlyVVlyMC9qUlRTTXF1L3FWUmVxd29LNVdhb2ozSDNrRk0x?=
 =?utf-8?B?UGU1YVRKOTZhVjZocjE4SzdYOUJRN3JsNTdpNFpLWTZEZlJYNFREVmw2SFpz?=
 =?utf-8?B?RXF2c21JWm5MYitHMUEzajdTVFdRMDNOWncreFlRNEhnNysrYUpwaHExRk12?=
 =?utf-8?B?ZXhmSEtJWFlPaUtDYllPVDJmaTRQak52eHc4UC93T1hxMWRvUkhPWHhsUzhV?=
 =?utf-8?B?b0RPLzRxUHRBM1I1VGk5VWVTVy9TdGwxeDYxMm1xRUpOSzlkMSsvYzh0eFdi?=
 =?utf-8?Q?tSpK4lVgn4Ae0EJSYDzWsOK8mM/z/rImmDp9nDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVY2M2ZvSWp0MVY3YXhpUmlWQVlDS2lXYlFtaWh6U3BDTXFhb0JQSDBnYnFC?=
 =?utf-8?B?UnIyMTRjcEc2d1VsVFM3RWY2V05aQXN6czNBQU1DSVNBMDl0WEhYNDdqdjhC?=
 =?utf-8?B?MVA5aEhWVHNmSFRYUkcrOGxnQXk1c0RZZnVuRXo0cGhhanVZaHJVdHZBdjZY?=
 =?utf-8?B?WE1nbUx5TnNqSStMWGtWVDhTaDd0d1NXMU9VSjgyZEZhOUVRSHZGbEQ2V05z?=
 =?utf-8?B?MnR2Ukk0TWhrYkNYcUx2U0RpUThzWEp5UnVrMWRwNUg3TXhHaDNoSXR3dmMx?=
 =?utf-8?B?OVVxdW5uUGU3Q09rUGptZ3lsRnFpbWhORzg5V3ZPVFQ4Nm8vLzR2UXlQVU5p?=
 =?utf-8?B?UHNWRkhxYzZWQXA2T256UWduT3NlNTBJVW56Nmc4YXNKYnlrM2pJYllkendj?=
 =?utf-8?B?aDA4QXEzM0RmQ25IZy9JTjlySUIvVkdSSFIxQTAzVk5tSnpBLzdhOUhaTk0v?=
 =?utf-8?B?eEN1eUtKeTJHVjFCbGt3eStzdEpTdE1WOHVXZU9MN2ZyMU9GZlhEMXQwRVNJ?=
 =?utf-8?B?bS85RmdpcUZaaS9pQmpxOFRtenNmL0dtcklnVW85MTcremFPbjg2VWxySDVS?=
 =?utf-8?B?eW1vdGNvUXluNmdaY1h1Q09PRHpwUldFNmQ3Y09BTXYzR0lOMjVrcE9HSVVP?=
 =?utf-8?B?ckpWbWRyMFJQV0owaS9WMkZKSUdEcDhISU1IWm5WK1pJMWtKQy9QNnd4TS8x?=
 =?utf-8?B?WWd3Tksxb2U0S1pqUFlwYlgxTDd3OEU0QVdadnFhYUVGdGJCazg1MEpRZFVp?=
 =?utf-8?B?MkxBTmw5SytzQjE5aVkzSXA3dFYrR3RCdm00Y3NVblhvSGFSMldSaWJBYlo0?=
 =?utf-8?B?Vk54blk1cVh6VCtSYlhpeHdCVEhVUGRaSi9UTExSTkFCL3k3NkU4VXJqeGd1?=
 =?utf-8?B?Nkk2bksxWFN0S2QwbmVvN0hKTUNWNVAwSXhWV3V4L2NlUVRnMGtVMjE5NE83?=
 =?utf-8?B?NGZjclVsdEM5UElyV0R2MVpxV3pUZTVYd0dhaTZtMGZTanY2RS94TFg2ZzY1?=
 =?utf-8?B?dWl4STJPTFJ3djViNm1rWHlKSDJHWmJCVmNoK2NvaGRMR3dOaHd1aGlwSm0v?=
 =?utf-8?B?VkdobjltclAvU0oya2w0S1ZrVGJiZFZJNGUremRJS0VUSzl0SzBYRUFUMU5K?=
 =?utf-8?B?SHFoYW9EbFJ1cEFJQjBpUGE5Wm50Z05XMlRKNDk4Q2pscGtnV2haQ3pMK0VM?=
 =?utf-8?B?RUh6eE9ITVFiWUtqamJMaGRjaDhYek9mcVFhQlRKS2QrbmtVUHk4Ukl2cXpF?=
 =?utf-8?B?NzRZVHRtUk5BUUJNbTNhaVhwUi9sQW91L2lSWUhyRWFRWlRjSkEwK3cvSmVT?=
 =?utf-8?B?TkFva0VWM2NYTjIzOWljVnBWcE5JUFo1cTMyZ1ZlM0RTZXM5RVlkTkhhQjIx?=
 =?utf-8?B?QVE1S1BMM2NGZ1hpY2VObjFNY0M3bXZ5SVVvZmkrMElIUzRrb1VOU1NCTGN2?=
 =?utf-8?B?bzVSdWh1YlBSbFhzS2NzTjBxNllOTFRDbFYxMW1JSGVDbXZ3RnJzdGQzOGJ6?=
 =?utf-8?B?N1MzSnM1T3pNQVR4R3cvRUYwdmZMbU94RGVzNzBNSWxOS2QrN1l1ME9SMTFP?=
 =?utf-8?B?MFNxcnVKVGlDMURWZ3ZTUmswcmU4OERzWkUvS0JhbHFmSHNiZUh5cE1xQmVT?=
 =?utf-8?B?QUJRcWJ4WVBTVTFkZmFHTFluM3Y0VjJBdTc0ZDdxc0lqM2R4RmQ0QmpxUmdO?=
 =?utf-8?B?cTBBNkJqWDBoUm1pZ3ZHR05IWTJmYWp4Y1RDdFBVYzRuZ0gyQ2tETnMxa01D?=
 =?utf-8?B?TFBacTNYNzFKQnBWcmcxN3AwZ3cwZWFWc3ZSSEhRRHdXN2xZZ2hqRzFMY01u?=
 =?utf-8?B?T3Z5R2NteDdJaVF1MkliYTkzMUs5bHVZZHM2MVd5MStTT1dyYldXLzlxR3kv?=
 =?utf-8?B?VDZWb2p1NVFuSmxOYStsQURrM243OHRyNlhiOVVVZzVPVHVXeU1JWkpDd3Ix?=
 =?utf-8?B?NXlUdzlOdGNwOWxXZjI2Uzk0QXhFVWZPS3oxZURIcG5lY0tTdVE0dFMyM1Zu?=
 =?utf-8?B?NUVodnJLVEdJOUpTNjVBd1hadTBlNEgvZUozVlE2Wm1GenFLRklHcmtXT0Z1?=
 =?utf-8?B?QUYvYktmQWRBQjRnTUU0N09MbTUvazhEZTRrQWUxa1oycXVlYVRJZWpKbWYv?=
 =?utf-8?Q?AY4ybp/LJKVNfn6WZhzpfXCml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96737aa-1d2c-443b-5934-08dcfe9b81c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:45:03.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMXj7tOO9ho+IfRjmXvziQujrnhrX5xM+T1vQZYldnt7s22/6fumm1pu0WZku5l4ZqqjFWOOb769bhVke+KaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

On 11/6/2024 13:41, Armin Wolf wrote:
> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
> 
>> If multiple platform profile handlers have been registered, don't allow
>> switching to profiles unique to only one handler.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 55 +++++++++++++++++++++++----------
>>   1 file changed, 38 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index c9917daf683cb..8de7c8352673e 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -235,27 +235,48 @@ static const struct class platform_profile_class 
>> = {
>>       .dev_groups = profile_groups,
>>   };
>>
>> -static ssize_t platform_profile_choices_show(struct device *dev,
>> -                    struct device_attribute *attr,
>> -                    char *buf)
>> +/**
>> + * _aggregate_choices - Aggregate the available profile choices
>> + * @dev: The device
>> + * @data: The available profile choices
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int _aggregate_choices(struct device *dev, void *data)
>>   {
>> -    int len = 0;
>> -    int i;
>> +    unsigned long *aggregate = data;
>> +    unsigned long choices = 0;
>> +    int err;
>>
>> -    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -        if (!cur_profile)
>> -            return -ENODEV;
>> +    err = _get_class_choices(dev, &choices);
>> +    if (err)
>> +        return err;
>>
>> -        for_each_set_bit(i, cur_profile->choices, 
>> PLATFORM_PROFILE_LAST) {
>> -            if (len == 0)
>> -                len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> -            else
>> -                len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> -        }
>> -    }
>> -    len += sysfs_emit_at(buf, len, "\n");
>> +    if (!*aggregate)
>> +        *aggregate = choices;
>> +    else
>> +        *aggregate &= choices;
>>
>> -    return len;
>> +    return 0;
>> +}
>> +
>> +/**
>> + * platform_profile_choices_show - Show the available profile choices 
>> for legacy sysfs interface
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t platform_profile_choices_show(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         char *buf)
>> +{
>> +    unsigned long aggregate = 0;
>> +    int err;
>> +
>> +    err = class_for_each_device(&platform_profile_class, NULL,
>> +                    &aggregate, _aggregate_choices);
> 
> Error handling seems to be missing.
> 
Yup, noticed that when unloading things exploded.
Fixing in the next version.

> Thanks,
> Armin Wolf
> 
>> +
>> +    return _commmon_choices_show(aggregate, buf);
>>   }
>>
>>   static ssize_t platform_profile_show(struct device *dev,


