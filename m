Return-Path: <linux-acpi+bounces-9371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5E9BF786
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDCA1C23783
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96920ADE4;
	Wed,  6 Nov 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2353d1i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E420A5F4;
	Wed,  6 Nov 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922281; cv=fail; b=dHfWZYKAZhLft/3bEJ3Xs8ogICijW0mjK5APt/fIHGdUDe4hfGamursNvdBKSPUveIqjR7w5Dy4kBpqNcUb+iCWjr7sfNwDca+RXEqPNNgs4kVog4+mkL8cR2R1GAtTZXvMHAh6Y+IA7ihHKdzBbfwkmzbE4x3eZIi54CXD9eRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922281; c=relaxed/simple;
	bh=gx8NBmYLIDwLJvkq1t1tONyCGhbnr09v97rGKsL2Yz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1xuCmS3moVC/B1wrLFWvNbr1IQilFJ91Rqjz03YlwiTNy4aJpH4YEv/p78G5t91W9mI5/ILCQi4pw3dvs6221GuPNGwIKJlxh7+PyWtjqufONVoYUnl1dfKSuVLuuAPFOJfYhj6q+AaeGA9o0FoMdghu3bMPZ0CWx2IDVTEZYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2353d1i; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWaPDpJW/yd4cTz3Fcwn09G4tK1d9Folim+CkKSog0+djcspjKCkfynZotAwgXzLJSKDcUMsuDcfVmrwhDZ0Q+oIa52xJha9WiQyHt5WlWd/jIH5tBQNzypQWKAmrHocWlD8bHyaKLvAenkIxxUOeZXoyqNDD6Q9Ksnk1s39mruIhd314o5MSKhdeYlEU+bRCNgqCRMo1W0fyxRb7UYNGfOeWEhc6kq+vgStJ1NkcqmtS0uHB2U/dREaBEE3l+ho0tD71nxDz6eTp28YEOzGZWhHbjCI06Skmo+7ZqkOx1n+0qb+PfDvhrIKk4CZ7IM349W2RADWnWf1DT3YfMSCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKam5s2H6+WrPmRg1MA5UmQyLXjPU/v0Pca2vB6k6K0=;
 b=DHBKMpNl0vwwd2u/tz2g2mtUjg+RDDUWLh/7pbsis4lip4f88WLKH71XtTtJ8F/thMN+VloIO7jNXX9jXUuJ3OXfonhINhHjEx9Te44OY0PM1u9ghLw/WfJErXaHvC1WsP8zGarZKk4ChDmbXmm3qPCyaelKmzEK/deBz/aPPqR4Jq1IIqVfCpCaM+LP43WBnwlw63efQxXnQrpH1Ms7rDsyTPiv7gNvWeXtoPR9M1HWXSfp1bmhx4q5QKs8gUZiBdQwXDXqfsGCGs/hdn8J0UdJ7Dwoe6k6+/DdEa3QZs8M5okrNNutM47V3rfejAGLAT8qXkK4N2y/THaa38eQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKam5s2H6+WrPmRg1MA5UmQyLXjPU/v0Pca2vB6k6K0=;
 b=a2353d1i/cJcuwvkudo4BMOHzcSZFbCkwmwqh9iALq7Rv9Mx4ZOIbre6R18vFiknPdESPwDQrHqByE9PB0K6J0JGoa19uZvJJdl29EhNsOc072g7mCVP+bVfojVGQpHBNIHOdazEKmly5yQxFWkcaGHpp7y8e4KTaTYjcv+uvfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:44:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 19:44:32 +0000
Message-ID: <31247970-55b7-4952-a802-a0e2069c1c6d@amd.com>
Date: Wed, 6 Nov 2024 13:44:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/20] ACPI: platform_profile: Notify change events on
 register and unregister
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
 <20241105153316.378-14-mario.limonciello@amd.com>
 <5ad884fc-886e-4924-8c5b-e537846fda60@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5ad884fc-886e-4924-8c5b-e537846fda60@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db36bfe-269b-4948-5f25-08dcfe9b6f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1J6THVaV0RveFJDdmV3UStOejdmWmN3N2FoUGVPYlRqeE5SWVdCdFRON3Rp?=
 =?utf-8?B?MXo3SWl2MmpqbmROU1RYeUt5eExPUDZPd2wyY0pjOXAvZmlFWXBYVHFmaUo5?=
 =?utf-8?B?YW15WnJDZHlpdyt4WkNCS3ZacUVuWDRQVzNIbHdIOW1DejdOUlp3VXlWckFz?=
 =?utf-8?B?ekNCZEJwQk1ZcEIvT1lqakNlSHZRc2YvMmcvbDZoVzN2a2c4aHNuOXFpeFdF?=
 =?utf-8?B?TnhPRGp5VUswTG9nKzVEZFV1OTFpUm1WelFpZDFXNTRtallZSEZHS1NoclNh?=
 =?utf-8?B?eHJCUVREdHR6aVV4aDY5M25MWGlTZkpvNU5iemR2S3poU1oxM042U013bldD?=
 =?utf-8?B?UUR1NmgvMGpjZE1lZEp6UEs0T0dVWHFFL1dUV2dIdm11cC96RjYwckwvQkJS?=
 =?utf-8?B?c0c0RVBhN0I1aThJbkdsc1JEcVNzRFdPSXk1YzBrNnNWdDRxaHo3enB3L0Er?=
 =?utf-8?B?VVJVYjJPaVl5aDFpSzVTOUNvajI2MEsxNURJeG1ZbTVPYTNwYmhIeC9YTVRF?=
 =?utf-8?B?UXpyblNCL1YxZElNaGROdlFla091dk8zVjNWSk1VelZ2K01LQm9oZUp6Z0xv?=
 =?utf-8?B?VnhzTXArQUxUa3BBUmFyQzJSQndpN2xueHVLaDR0RVkxK1FxOXdxMXNqMkox?=
 =?utf-8?B?YlJyOVkvOFByWXphcWF3NFE4OTBtWk8yOWlORXRhbGNLYjM1bE53NTNQMTV2?=
 =?utf-8?B?VWMrUU9iTE9yemltbkpqRjlWVjhnSEh0aDFWTjRYT2dkRFZFejA4MzZ1YXhS?=
 =?utf-8?B?RkdJTnk4Rk1oWElaUGJUYXJGWFJFekJ2TzlaWU1LTlN4UUxQZXdyREZqZW5j?=
 =?utf-8?B?dUUrWmlUY1dPTjhvQnlJM2xNVHBtdzVlM0FMQVcvcE1WMm9tVDJqdHB0cFI2?=
 =?utf-8?B?YmFCNDM1eDV0QkNzcCtvODB0UnNZRkU4TjZtMS9xUkRiaTFDN2hSSHV2Kzha?=
 =?utf-8?B?TUthMnBmcFRVQWsyNlc1QTA2SVVIQ2trbmlqNHZIM0FTcnBvY0QwWGptbGFW?=
 =?utf-8?B?UGowYVNqRmVFb3IwMTVjSHB6Y2Z5ekdhNlNvKzhKL0RUSVVxNFdzcWJFSVNu?=
 =?utf-8?B?bjNhaVNJVFNBVDU2VlNLTjltZmVKNUNpT1VEczUxZVgzKzlRV0FSd2FOWVFD?=
 =?utf-8?B?NlJvNkxzRTc2TEliU1FRNkJlS3pUNCtlQW53SE8vck0xbTRHWEdBQ3A0OExm?=
 =?utf-8?B?VDRoM1M1eURacGlsUEpLRFpHNEEwbmZFdXowZ25uMnlvbVlWWGRKUU9TaTZS?=
 =?utf-8?B?NlRUSUl6TU96eSs3KzA5QmJ6L09IWkNqRFZzeXJ3OFRHYitIb0w0akFwR1RF?=
 =?utf-8?B?bW1SQzNXQS9DWU9EU2FxUk5sZVkrRFJNajVjcUZRZGhkN2c2NDluV0cyVEk5?=
 =?utf-8?B?eW5DYUN4YUt3YkwvUDJ3UitRZXliMW8xYXU1R1R5a000cWFkZEFkUjloakRl?=
 =?utf-8?B?KzE2WHhPazBHMm9RWHl3eVNPQmQycVBoR2ZHVjllR1dWYkpKOFNJTTVzSUkx?=
 =?utf-8?B?Y1QzN1B1N2hob0VKSGd2TGZSQmV0M3hXbzdRQVNwckdqSGY2UDJFbzR3MGI2?=
 =?utf-8?B?cDB1WUh4UGJ1dlRucnhXOCtBc0tPLy9mQnNtQ1NSMGlpbGlLNmo3dDFmYnhX?=
 =?utf-8?B?SjM3NVVQeTNza3p2ZzdzOHNrZXlxZjJGUFRvZlgzY2l6WndzUVVsQy9TOXRn?=
 =?utf-8?B?VDRtN25pZGdLc2wvakVRRDdFbzFuZklHQjZnMHg0NzVMUUd1YXVwWE1RM0NL?=
 =?utf-8?Q?ae/sLuVV1z5mjmV6DR3ZBqYImWZ0ytoKUeyIBHY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNrRXJiRloyQ3JQd1RuTTNpR0xjcmVYMCs4WGdSR2oxSzRnTmFQaDQ2dzRJ?=
 =?utf-8?B?TDV0M2JpL3NwaFI5ZjdOVmVlUUR0S0wzcGhFeXpDUCtIR2x3WFg5VlBLWE5T?=
 =?utf-8?B?bVJvSmw1NElqc2ttM3hwdGRzRFNDY3hwdU8yYm5WK0NWUTJRTlh2L28zczBh?=
 =?utf-8?B?QjR1Wjd5THhwZkhUTS9sMGg2Y0Z0MWxGUEJYZUNWcXpJN1d1Nkx4c0tOSkdF?=
 =?utf-8?B?TWpCR2w4NmM1ZkhCMGNLdy9TczRINDVhZXlOVHZHR3VzWnFnNnRUdkFuaXBh?=
 =?utf-8?B?aVRpTmcySmxzQVhnY2hFRmxiVVdGeFZtSmF0QmFGZDhkNU5LaVdBV2RoQjRk?=
 =?utf-8?B?Yk1FcXYxN2d1SjhON1FvdGtwckxPL3ZFdEhEVFFxUDRrbE42aUdkaURZMklX?=
 =?utf-8?B?aTRXNHVxeW13NW5KTG9taWxCOTgzRGgzMCtlYUl0Q2l1UnY5VkUrVUNzaGo5?=
 =?utf-8?B?QjcvVG9kcUIrWWthR1FTd29HaHVIV1FIZmh0dE9UUmxuVm9PNng5T3VlMlpT?=
 =?utf-8?B?eE1yRmlhMHFvRTdUTmhJNzRkdmxuemxMRXRrRzFsMWo2bkE1c25tWXR6RHVU?=
 =?utf-8?B?c3Vsd2I1aVExY0FrUE9GeDRRL0pQdUw3VEt2QVE2Y0t1ejgvWUQ1SkJzUnI5?=
 =?utf-8?B?RU9Da2U3cDJJU3crRndCTU8wZkp6S2NBN241dWliYjc0ZXhDUTErN2t5RENG?=
 =?utf-8?B?bzUwQ29FbEw4L2tScVZ6TXlWeDhMTEpXOFc2cWdjZWtTUWVJUWxlWnc4ckQ3?=
 =?utf-8?B?SmJxejhBd1ZWb09XcWZWN0x4M05CVTJXTGhnT1djUTl4aEdlREx3M3ZpSHBP?=
 =?utf-8?B?aE1jUU1EbDUyaXhaQ3hxVUpRYTBuVWdUcmwwMFQ2YmZmdENUMEFKN1BqeGtt?=
 =?utf-8?B?aTlaTWo4c3FMdlI0RkNHWG5mSWl2dFE0RVoxMm5tRTZsNjlUTkMvTEl1biti?=
 =?utf-8?B?TDdVaEFGRUZUd0JVT2pSaEpMN2VUYVRnUWZvZGg1QkpWeThkNXM5Y0lKUVdU?=
 =?utf-8?B?SjZlU3d1MUR1emlMWGpiL2d5MUdqdGVHTGpLdXR6ektxWURiZmZNRVVBaDF2?=
 =?utf-8?B?eStpMmRUeHhUU28zcWlML01YL3QxcVFDMForRGZBQkdTN0pTNm5WaUJwamRH?=
 =?utf-8?B?UTYwWDVSWERsNkxXODhFV2JzalFTeUxRQjZndTFhZjgvcnVQK1dGRnlseDRF?=
 =?utf-8?B?TFd6UjJlbTczTHh2NnBHNnNXb0xsOEF2YVQzTGVXclRWQ3Vzb3JZSzlWU25F?=
 =?utf-8?B?d2VwTVpwVTVQcVp3WVFSU2lGUWJGbjlVRTVvOG9iYXcwZVQvcUEyQUtrbWgv?=
 =?utf-8?B?eHVtR2tjeHBOUFpzUnJ3NjNyWWhxODFsV3RPclZ3dXU5Wnd0RWVVWmdERVdO?=
 =?utf-8?B?aHFNU1llaUFPK2hKekhrOHJmbjE1ZmpWT2xlWG5wU1J2RUJQNEFQdVloVno4?=
 =?utf-8?B?VGN4TnB5aWJ3cmx0M1VVTEJNd0x4aVJzVlpXYndDUEovRU5CTlpyZmZmQjNS?=
 =?utf-8?B?LytkTkhuM2tVazJRbWxYT3hjZGhScnpVVlprY3VnSnM3Q3Mzbk9ZbzJZcjJn?=
 =?utf-8?B?b2RVSjA1RFQ0a2xDMDZoWm9za2w3ZUhDMmxjTnJ3MDliNEYzTUtpdFdmdUJm?=
 =?utf-8?B?T3JSQmY4UkNIVTlFNCt4WGVvL1UxTWRMREpRQ3UreXhBbW0rZVBZVXVFUVVo?=
 =?utf-8?B?THRtbG5EMFdWMFk4RW5XSGVnMmQ3S3JMMnhNek1Fcm5xT2pybHJBSHF2cFRO?=
 =?utf-8?B?ZlMwdllza29jeEh5ZDJ6R1lBakRiRmhzd1UwMUpqbWJaNklaVGIwc0kxMDZ0?=
 =?utf-8?B?bThGUVY0R1U4NEF6YXgwYmh4a0JMUGNoTisxUHVTQ3JGUGhLMm5uaWQ3UmFX?=
 =?utf-8?B?ZG81elRVdzVXR3JyR2IxaGRmdTE1Zk9TVWpIQ041TjBudWgrSEJXNGEvTGFt?=
 =?utf-8?B?dVVjRnVoVkx3ejJmam9UNmpZN3dGTkVjazVKaXVrR1Z6YkQzZzA1dFBQYk1V?=
 =?utf-8?B?c2FCcmd3cFh3MDhDZ3BJRXVIYU95YkQxdE5MUFN0T0UzWHIyZ1Zid1FnWVJO?=
 =?utf-8?B?WDNVVFNQMmN0R3N1VWN5NlRoanpHSFliS2JoUmVXSkdKQTlZYXFIRWlJVWRy?=
 =?utf-8?Q?Cc6ujUw6bLn6KCKokUAzySbSh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db36bfe-269b-4948-5f25-08dcfe9b6f5f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:44:32.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t0VtxXxrtH4JqwKNDXUJGbcYxGamTJfnd0sXyLCPQXS6jpfSkSGbjNBUFAA6Y94jHRFnLdMBv8Qp1rEojXjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

On 11/6/2024 13:40, Armin Wolf wrote:
> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
> 
>> As multiple platform profile handlers may come and go, send a 
>> notification
>> to userspace each time that a platform profile handler is registered or
>> unregistered.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index 79083d0bb22e3..c9917daf683cb 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -404,6 +404,7 @@ int platform_profile_register(struct 
>> platform_profile_handler *pprof)
>>       if (IS_ERR(pprof->class_dev))
>>           return PTR_ERR(pprof->class_dev);
>>       dev_set_drvdata(pprof->class_dev, pprof);
>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>>       cur_profile = pprof;
>>       return 0;
>> @@ -419,7 +420,9 @@ int platform_profile_remove(struct 
>> platform_profile_handler *pprof)
>>   {
>>       guard(mutex)(&profile_lock);
>>
>> -    sysfs_remove_group(acpi_kobj, &platform_profile_group);
> 
> When do we remove platform_profile_group now?
> 

When incorporating your other feedback I noticed this was still there 
and it will be removed for the next revision.

The idea will be as soon as a class registers the legacy interface is 
created and will stay for the lifetime of the boot.

If all drivers are unloaded it will return -EINVAL until a new driver is 
loaded.

> Thanks,
> Armin Wolf
> 
>> +    cur_profile = NULL;
>> +
>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>>       device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>>


