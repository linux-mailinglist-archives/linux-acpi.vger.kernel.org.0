Return-Path: <linux-acpi+bounces-9193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2109B7B81
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F0D1C20D40
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5A19CC05;
	Thu, 31 Oct 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5eoyhvdt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145902110E;
	Thu, 31 Oct 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380589; cv=fail; b=pkqM6JNLZDsqvKX8UXu87h5/qx3HAIbkXrMUogXrRpdpCyuWs1wb5zVTdShiOq5BQwAXIcm5BLaSOI+qLgWjKbLCNxw+C1h65TqHzswbaPKEyuD2IOnDpVsru4S1x1pJqHas7frUqTdhjGWc/VTBTBwzAG8mhzLu2JsO52lvN2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380589; c=relaxed/simple;
	bh=fcEt8/DxgUxGdfEZ2Iw/MBn+goMZocGz4HLi46UnHTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tQj8v8RmghEU5KuRXgMh0IJ/xll1IG6jaD8KTznxj4Zs7XASbas4sOx6j0Ppc6Ja6uTez9NUUyP2Vo+RNkefkod1fUxgHrEUM+UbQ3RmMj/XdomgVGrAiCD122e5DtupwnHPc7Qpjn3+mtR31/kd6+hYOEa+bzOWT126KM/S/3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5eoyhvdt; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcPpACCzOcyDHGfnmIOZrd9/wRh9hHH6odwukmO3dIvygIl+C9Yck6K9t/YYkQT84dUocBhR4Hr4DsTipJ6ahXluppDIjyPV+M8AtCIrwyL2ChtnTnUuIsOO5zJRnf3Q+6zkRYyJQf97GqwOWEbYbgx0xxQ/awzGw/h4J3CHqJhijUg8rmjPtK77l14cBOQy8NVO8UwJZyATANCmkYnljqCbOl5z31F23ZNrJArXWmkoY/JlIwbXlNwL5ArBMAREgPOuztMPjLl1qTor36upEZubfgfNvW3KNkd/XCN4IoIvKGC8nCQmjmibSiHd8jt65/maKy9ohvcVsToNLROHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yF3B3yIeSBXBoD0I3XBtgeuspikcNkuTmSODfyxam4=;
 b=C/mNoppGJrvzuPY2pvdAMON01JYHjDswKsOIComVGwcrmOCcaWnprgyfZ4GqBeYAaxw32V4sg4IxDZx8ymWyb9Cfxwq/fbnzQvtUulsmOvjSyJJ0rQxrcXmyPqCiNO60oZ9Lzsxb7g6gpKxkoKxRzaKBiesqyVAwWJRBV1btStINXfYbS26IhzzDW2gg3eX9xYCCoxnqB3JfZCR1ZOaPs3OyLvAOSevvKOLPZvaDAhSsG5LmXbRlBKwr5YLkZEhJ1QyktceSv8CNrgSn8q/KgXUITH4Wn2IUY7OR119UDWdaqp2E9SjvFkw+23H6c9PwKpd0YDIp/iWiT6TImH98ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yF3B3yIeSBXBoD0I3XBtgeuspikcNkuTmSODfyxam4=;
 b=5eoyhvdtAsnf8VYuxE/MqFbGkxev6AHw1FcuiIHJe6P505bqSA8ei2XtJfzO5nnAK/1++WzQeDdz0z8Bzx3C7jDb+z1KIOUrWspNCC5BEG6Hm7qptCXts8dMZDxOe07oL8nULB6PkLThRFQdChIqNi3tiiV04x/uQElOGC3tObA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:16:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 13:16:24 +0000
Message-ID: <26089438-d187-4d0c-a348-3a0d0170585d@amd.com>
Date: Thu, 31 Oct 2024 08:16:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/22] ACPI: platform_profile: Use `scoped_cond_guard`
 for platform_profile_show()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-11-mario.limonciello@amd.com>
 <64f0b33b-3345-d9a6-d174-2a823adee216@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <64f0b33b-3345-d9a6-d174-2a823adee216@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: e75501c7-584e-4e41-cde2-08dcf9ae3822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTVMZDhpclhWT2w1ckdJZjAvZTd0Ynp4OUUvU0xybjZPbUc1VG1UUWN3T0hW?=
 =?utf-8?B?WXo5WDFLbzBoeGRSWU5pQzQ3ZllTaEMraGR3b2p1VTlGY3ZsVmE1T0QzWnZt?=
 =?utf-8?B?bnUzOWNCWDM1WU9tOTNRRGJ3T0xsdVV0eWxsWW02QmpxOTNJYUdxK3hpVmhE?=
 =?utf-8?B?MU5pUksxbWpvTFBxSU9rY0E3eGFoOTJ0aGZFT3VkcGt0RlFLOWxrYmliYTg1?=
 =?utf-8?B?b3NObXJCckR6azVtNGNqNllmbEhDbGVmV0prSFF5dy9sQmtpZnlzUFlKbU9q?=
 =?utf-8?B?UTN2Z3c2eVF4MWg0SjZGNjMxQ3pUaHk2MnczdGNSWDVlcm1KZUE1Tng5dk93?=
 =?utf-8?B?eThVaHpYZC9lSmJqbnpkZ3Q5Q0NWc3k4MWlxVmxnOGJPS2dBWlFRdnBnWElp?=
 =?utf-8?B?ZWZCSXRKVlBycmZ1Z3ZsVWdFQW1JeWVrRG5WMC9mdXZEL0tpVWNpTmFwclZ3?=
 =?utf-8?B?cWpIWnhucEhYdmxscVNYV1JIU2RCTjJZM0JtYjhoSk16N01JMW5xS0tEZVc3?=
 =?utf-8?B?S09RTXlKaGtURWxYeEExMXJ4VFZKdW1BaVNZVmc0cGRYTGhxV2xlQU1udkVN?=
 =?utf-8?B?RmU2Wm1tWEJ4dmNJenZYbElrK3FYNjJ5VnY0REgvK25XMURwYlVRQkwyNjRw?=
 =?utf-8?B?WU9yQS82eXc1VEdXYVdFRTA5K1h5bFdGd1NXdmc2ZnBxSkRlNmhrZGdDZ0lZ?=
 =?utf-8?B?TzNvcnl3bG01UVJPb3dzOS95Ty80ejlMVUhYR25aUEJDRkYvMnVZVGFQcFln?=
 =?utf-8?B?RlYzL2VoMmVzQ0JjeFFVbit0Z3hyQnVkWUNad0FEaXNkVGx4b3E2SHdFei9R?=
 =?utf-8?B?TW1oMG1zc2dIQ2k0d2VRUktGeU5rZ2pUaXRyS1VNMmVTYXByU0JNVElUMmJU?=
 =?utf-8?B?NkE2VUtGUERXWHFYS0MzVGxuOVhoT1F6TEhJbUpMdzlzVE9nNW5FRnZzL1lm?=
 =?utf-8?B?V2Q1d2Z1SEFDam1zUkN3dm51Qkx5eWtKUk1adytveFluQU1aTER3Q284bkpu?=
 =?utf-8?B?YWFSVGRiazF3RTVrYTBTYmNYSktPNVV2dWJEM2lZWTlGSlJobllrcnNMOWF4?=
 =?utf-8?B?VFNJYnRIcm45dUd3alBKdTZpOFVwNk84TjVWNkZLZW5oU0NCdjFCdmJtNzlT?=
 =?utf-8?B?QnJ2U2NtTm1pM1R6dmNNd250TUFOUTdxTS85STJDUE9MWTlKeHdXWVlFT0tQ?=
 =?utf-8?B?VVJXdzVUd3EzMnhTUW96N2Ntc05jL1FqVXh3MEhvZFNyNUhhaWpDcVZpNzR5?=
 =?utf-8?B?THp6ZC9MNEYyWk4yMWRpZDhYK3pmQXRtVWtYOVNBaDdQeVMrNDJpNGZSbml6?=
 =?utf-8?B?cTNlakNkT2Y5WEkzVitxOVpMM3JtemhzQWxWQ05QN1JZWW1weTZFdkVWWjZJ?=
 =?utf-8?B?K2JTa25Fd1BFaktZcnNiaTI3YTNxM0xGczBPdElDU0JNMXBPMVByUEpTWjRr?=
 =?utf-8?B?SHEycnlzV0s5SjBSRUNrdU42dUVvYlA2Q3ZnT2dVVy9VYVBqQSsrV24rK0pL?=
 =?utf-8?B?QmtzY2M2SFhSb29ibWFSTXpacU9KSTNRY0wybkJUTWdTeUNhTDA0YkJ2WUli?=
 =?utf-8?B?UEJrU1NyKzYyVVF4bXJvQ0xOVTM5bCtPU0MvbHFlYk44c280cE1xS2JKZnpn?=
 =?utf-8?B?dXkxSHRhN3Fmek1JR3RzWThTT0w4bzE5REdqc1htVzZVdmdPTm54bk5pZzB2?=
 =?utf-8?B?R2cvVGRDTGVQT0xmUnNUOE1YQVRNWTdPVHBqYXNseC9mSXYvU2h1T1dteEky?=
 =?utf-8?Q?qCB3E7A2o5Ds6sd87o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTNtYi9tWThrQXJCamtYTHJJUFhVWU9tVXorNmJtL0JWbm0ydFBITmdQcVBO?=
 =?utf-8?B?VVJBN2FKcU96Y3owM25qcFBuVjBwWGlJK20vcyt0RGd1a0MwVEZFaDIwWk9G?=
 =?utf-8?B?MkJubmZDK045VnZzMDhJeGlIQzltK05vNFJ0V2xIYWkxOVQzV2dITCtMZ0NR?=
 =?utf-8?B?MGJtVzZWQmRHaDlkRTRuNzNsMEpZL0lRNUhaZGRqV3VzMy9ndDRBSU5tL2Vw?=
 =?utf-8?B?a3ZFa0hrYllsd1QrQ0lPcjZvMjdaZGFvYWhvWm1FN0FVZ1hmcmdSVlQ4SC96?=
 =?utf-8?B?cm80b05QRm9GNjRDN3l6TUswclVDUXQxQ0xLaEx6N3RCaEhMTDFPM2ZzUVla?=
 =?utf-8?B?SFo2bC91UDc1enJuQktyTWJMMjYzRURwUDFORnUyQmF4R3B0TlFaNlpvcjJW?=
 =?utf-8?B?c0JOdHA1dUhsb1laQ2VXQUxYemhIa3pQVlNCYVlZMHlNQVk3VzFrMkV1alA3?=
 =?utf-8?B?OEF2OVBITUs2TFRPcUpwczRYOTBNM2RteXdybFRaYml2UmNTWGhXWXdndmZn?=
 =?utf-8?B?YXpyOG40UTE2SENnZXpGYlZkQTVzNS9MVUZReDBHRStmTGRBUkVQR3FVY0M3?=
 =?utf-8?B?VVlCa1BncWttNDVRS2hOTGxVSzhoU0UzZzBFVDFsb1RGZWc2RmVFblRLOE1u?=
 =?utf-8?B?emRBN0h1YlpmVCtVOWN3MEYwaTEycHJJa0JLMk5lZjFlVi91emVyKzR3eVBa?=
 =?utf-8?B?V3ZFOFlINVVJdlB4a09tSGZLYmY5Y0dETTJPLzFmeW9wQWxTc0l5ZjhWaXd2?=
 =?utf-8?B?MUVzanRkaVZrQnJFRzljT1R2V0IrbEpBT2ZYYmFsK1hPcjI0NUlXMzFMSSsv?=
 =?utf-8?B?NHJZb21RLzQ1SkRFb2JPczBTSFJJTGxUVGVzQ1haZndJZWNubEJkSWVDb2VT?=
 =?utf-8?B?emtQWXFkS0tDUGc0a09YcEtJVXJwT3NOVHFFaDgra2g4MXhEbmNsR0ZORGxU?=
 =?utf-8?B?K2E4cnBEU2Q5TEZxRVg1bWlNekNucFduWWQ2VEl6TlRGUGZtL01NR2V1KzFv?=
 =?utf-8?B?V0s0bTA1Nk9RaG05SWg3TzZjL2dqTG0rQVRIdFNXY3c1bmQ4Y2U3TS9pT2ps?=
 =?utf-8?B?Nlk0dDQza3FKUG1NeDlTVGo5aStLUWl4N3RySTN0MzBkaDBsVjh4bUhJYlBi?=
 =?utf-8?B?YVlGcVZyRHFSU1FUbXExT0U1dGx1YnI4V0d0ME85Y09iRE51MXM1VXU5TE1J?=
 =?utf-8?B?M1gvUmsxS0RFcWZLYzNEYWZvb0Z3M0VkQ1J3SWRLUGdmSGJXVGJpRjczc3Qz?=
 =?utf-8?B?cmpSUzUyVUhmTFJoSS9HQTZUd2QwL2YyY3NXSEdQWDhRSGFhd05qNmdjNDVX?=
 =?utf-8?B?blE3bzJHeUp1aklidVFrUVYrdVBPM0dFM3RMQk9BRW5kODkrODhFTzhyenF0?=
 =?utf-8?B?eTNvSlFVUFpDVXhlUjN6Y25aVlNBaWlsYWNzdGZZRmdkeERIbFNQTFlDRlAw?=
 =?utf-8?B?cndzbTVoQ1NVZTQwRkppMmc4UXhDdjVYU21YWHBiSmNBaDFKNDdUcnFFNjRp?=
 =?utf-8?B?Q2hsVGxTWFVyYVJBRlFqV21Xc3ZhOUhYRVVXcjUrUHk1UXE3S2JoTWs5RnQr?=
 =?utf-8?B?eSt4aWE1QThyWmhhY0tmNjdSeVdyZEsvN09lNWNTRStzU2dmMGplcVpIOVFM?=
 =?utf-8?B?ZHJzMTR6VUNRb3BKVkxvU2hTaUJXeUt4YkZ6QnhKbG1KMWkzN29aTlhYcEt6?=
 =?utf-8?B?MXliVXF2TktJTHkvUEJOR2w1YUZpZ1NockZENkFaeEJTRnU2NXlaV1dmZFgw?=
 =?utf-8?B?alV5NHM5QTZYQm1rRXhvM3hPcjJSZmFIcFZVTmVOSU9nVmMvY3hxam4rY3Q5?=
 =?utf-8?B?SDllQ0lJdFZMN0JmU0QvUjByckRZNFpjV2hWdkVvSHFGSCtjaCsyVTFOMjc3?=
 =?utf-8?B?anpXVGJFSG1FV3o3STFFSEVDL3A0blViRzZWOGFTZUpEalpUZmk4dE1yWXJa?=
 =?utf-8?B?dXFHeWp4ZDZzWHltZ3pSWFFWRFg0YXF0anhXZDlxdXoxQ3JpV1c3U2h2bWRu?=
 =?utf-8?B?ZFlRejcwL3VMdGdHT2NsbFFzYWEyVHMzUUExMVNLc2tLR1lVZVJKVkFHM3pX?=
 =?utf-8?B?bmNJWHBwY0FhTkgxREZNNTk0V0p4Z1N3dDFOMlVpcCtHc2xGclZxaU9GMS9o?=
 =?utf-8?Q?Flr+yll3yOMO496C9JzwTos3g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75501c7-584e-4e41-cde2-08dcf9ae3822
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:16:24.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfpSYl7N33QlkPyrKVGrB6myRMe53y1Q9fK+UAuoPUevudeijZptfj54c2Otp183SkvjuaBKODrWzZK9o2Yo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

On 10/31/2024 05:15, Ilpo Järvinen wrote:
> On Wed, 30 Oct 2024, Mario Limonciello wrote:
> 
>> Migrate away from using an interruptible mutex to scoped_cond_guard.
>> Also move the sysfs string match out of the mutex as it's not needed.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I'd have expected all the mutex_lock_interruptible() ->
> scoped_cond_guard() changes in the same patch. Although this also moves
> the sysfs stuff out which in this smaller form is kind of okay but if it's
> part of larger patch merging all scoped guard conversions, it should be
> in a different change.
> 

OK for the next version I'll merge all the mutex changes to the same 
patch but split the sysfs change to it's own.

