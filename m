Return-Path: <linux-acpi+bounces-9952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EA09E59DA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF92289794
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E221D5BD;
	Thu,  5 Dec 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MB1lKLNO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9B21CA1B;
	Thu,  5 Dec 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412964; cv=fail; b=EErgUcU1x7G2RRXNWswO5hwS5yoMM1SLUtesG1SLK3guUKYJS5hLmWGtt6W0VeNYrNWDBXSY070nNxENlWF4Gui7fFJtx71raQCkKm+M4cSeQ9WtLWjIu7aAyafli0Myt3EEYmNYbkxZ9bG/y60NdS1BGLJRJeL7Xz4OGTpl1So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412964; c=relaxed/simple;
	bh=vpOMEw/yXU5A94CNunICGtgm+kov2bH9jmWUXIzByDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=udZl//jE1HKq+Ki7Ex+NX/uODZUPEGmrStZMmPzIMyakeeryyTve7rMQOJXMZSrGBodNN72w77nnwcpWsmONeExLCjVgtoCJmBVyA+fimRwXEmIXqp0gcK4azjlzApUrMoioft4ZXpEby6QtpWa0TH5BGIdR1ijj/63pVqdnF5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MB1lKLNO; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqfwXLAZbMrgZ8cLqkOo5SGKy6ipk68H9cwxgUxP3tHlIpa799eK5SOIR8ETKLpd0fWCWzzR8uOXzUiCnANr6ZvRhipHPKz3o2CVv2DKor/bdOUQfbDGawj6tECt9yUhQRLaNH40BQPP06FbpSqmOj4xnd394wJ++Z4ZrPaUROGrRHunZ6Hrj6+oHozucieUY0DlSEsOLkL2ZEMuu4hl5PEWgcoYGNKpkSqiV4z80s98U29FIZtq8rNPuisjIOaGF5CO/NlnieMfKZlVz/VFRHoybkmAFMxuzG7soqEy5/I8y8Ok3tgHVozHW0fjWSM855norSNgXDVxgvfYc1Qobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ64kbLSIwZOZHEKvy0GJn8D/JkiDEQBHhoxAV8eCmo=;
 b=qURj2VBnMgTh4rh8Vaci4F/JP70fEd17Wrc6pU15R2qUDGuFKhdfjBmyrnDq9+M6acXO/LFumPR0TxhqUMM7SJoBoqdWwvN5v+BIKVFYITS+FP1/QUw3qgbCd0U2cl3t3I3ILIt+hg8S5OGyvc8kpPdpy0H8SSeN8SpymYoAQOcSiQSR1biYILEhnDuUILQdCzpVfhAqkLnY3Q6WaHlNurZwdSi5S4YF/7a9teGNEfgbRdvSBCOm7alE52MrWSk3X6I9xGp9w4GAbXp45XC3bqwi9eGVlyS0aA1vRTo85i5oNWd/a8LPpxOdDptRZfcS4b44RkDxEgnbQ0BQIxq5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ64kbLSIwZOZHEKvy0GJn8D/JkiDEQBHhoxAV8eCmo=;
 b=MB1lKLNOIl0uLS7RLIiMuIn4Xr8x8QIkujTZFzyHK0TxRXUdM9dnlZ5X9YShnMI6DdwJZJ6zPk3foOFTidU2RNxo58LvlCoTdi5YPoOGshQAt5h4LLQmxhC4t35/JHVLXgqdr8FMhzaNLOt0AnPaerkvGwGB+qWOSovrLofK40g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 15:35:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 15:35:56 +0000
Message-ID: <cb5d824f-a146-402a-b489-0d777f267677@amd.com>
Date: Thu, 5 Dec 2024 09:35:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/22] ACPI: platform_profile: Check all profile
 handler to calculate next
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
 Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
 <20241202055031.8038-19-mario.limonciello@amd.com>
 <fc57acd9-396c-e047-12c1-14836e477d14@linux.intel.com>
 <bd079286-b7c9-4231-b8d1-1b0bcf937997@amd.com>
 <b3a7ece2-c49c-5c5a-c53b-99acc10f68fc@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b3a7ece2-c49c-5c5a-c53b-99acc10f68fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0181.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d29b742-22ca-4ec9-e966-08dd1542829f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG52VlRyT1JDcU80aHpsR2FIZ0ZNeGdreS82TGhVdXF5M2JuUTZXaFhhRnd2?=
 =?utf-8?B?a1p4bzZpeHBEWVBaN2RvaUNadWJHY1BpZkhYdVd6SzZ3Ulp5dlFMMmNTc2FU?=
 =?utf-8?B?Z1E2MzV6WThCNkV0a1JlVFpxR2g0aVVMR1pLWloybWVxS2dwZUgyZ3owVkFX?=
 =?utf-8?B?VXc4c3hvN2VYUnpGRnUrT3BXTzA5OW9qUFVzbjdCNHNEbWtXNmQwcVcyYnN4?=
 =?utf-8?B?SUdWNlV5NExJYXluUW9TdkVoWDd2UHBaYnFYZTZpaUppV01BTjdhVTVQWktm?=
 =?utf-8?B?eVVmK3dIcGp4N2ROcDQwcVhKNGpLdUpwWEoxaHBoeDUxb296OTFtRmFCUmVi?=
 =?utf-8?B?aEpneUtKb005Yjlic3NsUmtXZS91Y2kybWdRYS9sOVFYbWQvbUluMUdFeEhN?=
 =?utf-8?B?anJrdEQySEZBM3hnWkwyMkkzZTRObTUzUUZjdzhFZHpSbVlsaEg5MkxtbzVh?=
 =?utf-8?B?MHdTMkVOcnY4VXFSZERzTHdQTWJQT24vRWhtNUNHM28yVDhhMmNvdE42R0dB?=
 =?utf-8?B?a2tPQmN1RzZIM2dnOFA0U1NYZm15cy9uNEx2WVRqZUVDZHF1ME53VytGdUk0?=
 =?utf-8?B?T0l5MjVjT3FzZ0hWTU4xRTRGUTZHVXpKMXQzZy90UjVkbTlraGpNMVpIUjN4?=
 =?utf-8?B?aERVMlhkR21aRGV3enh6VlFDYzU5T1JhVzF1WmFpUnQ4ekhuaVFySlZyWDhR?=
 =?utf-8?B?YWJCREVLWHJsRkx5MW1TMnd1ZTAzTlFpdytuYlMrM2g0ci82MnZudTFkU09s?=
 =?utf-8?B?UEpDNFFJSzE0SDEySDY1L1pBc2t4L1ZoZkxMcVlXY0tIRHNpWFgyYlNaSGlI?=
 =?utf-8?B?M2luaXNrN3ZTQjc2dklmbTU4cVQ1dllIeXVnVTdMT210S2lKaVoyQlBqSlRt?=
 =?utf-8?B?Y0x6UVdRTjZqRFpTQmgwV1RVSHJhcmZiSUtHZTFBd2dtSWlod2FzOFNtWmor?=
 =?utf-8?B?TGd5MSttMEF5MDFKTThGQVY0Vk4vOGphQ2l3TVJDRk9EcUFCeWl1MTRmejVX?=
 =?utf-8?B?UTVKNE5wb0VZd2ZPK25ZT2ltNHBxWFpNejFxL2N0TElZcXFZNlJrdFdXR2FF?=
 =?utf-8?B?YmZ4a3RBanhNZksvNnpBZ3NvWWIzdWxzM1RZWTF1MlE0NVpxemZiRFhqcTd5?=
 =?utf-8?B?dmJldEV1YkVYZUU1cC8yaG5aTEtrVERETEtyN2c1OE5sbGttS2pENUtnd2Vw?=
 =?utf-8?B?eFNEVHZ0NDdObXZsb2tlRE03M0xHcURIWnJHb082UmpIZzgyZ0Rwb1RIaVJ3?=
 =?utf-8?B?Q1lneXcydTJCMXFqWWo1cmVSZzFFSlJrTTRlVklEV1RzZzVtcVp4ZGpwanBH?=
 =?utf-8?B?T29UeXdUU0N5TzdQcmpISk1CcC9GVFpSQmZjZFg1Vjg0ME9MNnNHV3VlV1ZK?=
 =?utf-8?B?b0swMUpUREswSDh1Ty9iQm5maVVjblQvampkNFliRXY2TlV0K3h4ZHFlQ0Zn?=
 =?utf-8?B?NTRzL3k5SUgwdFo5SFdmVHprRjVyTWdPN1VtcGYrNzF4Z1FBc3IxdXd6WlZu?=
 =?utf-8?B?dVJZeWNKWitxV2xNcGk5dnQrZ1R2QUt6RE4vWFE4Z1FTV1VtdTZpeXRjTWRK?=
 =?utf-8?B?bW9BT0NuNjRQSUtCMGVXa0hZYmkwUmpmSnJsaGtZL3NBWnhFMm5XNlVlK3ov?=
 =?utf-8?B?TFpwY1IyMGh4T0NKbjdpUjk5UlIwc0ltbURCSUluTmszWVAwVDN0cFNIWXpn?=
 =?utf-8?B?bEM2eWZWR0xjRGVidVAxVC9mY3VwT0I3QjAzckNSM0FjczlvaXNrZWhSUWE2?=
 =?utf-8?B?WFBHaVR2VGkrUitxK1hTeHorNytRUHM2Y2RtQ2N0b3l1MFVMTyszTVdsSlNN?=
 =?utf-8?B?cS9FNnZvZnhoYXFFckRsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2YwS0J5MmFobEhZYVRHcFN2ZHBzUFlpSm1EQUpRR0hiWTlJcUc5TkowNVdE?=
 =?utf-8?B?TmFjMXE0VldnekJNQXkxQmdZVS9OU2w1R0JhaVA1N3lYUzkrUjdqdDJJbjJ3?=
 =?utf-8?B?N3pMK2ZxRE9tdFVzaFMwdWZERGVUYUhDdDYvNFBYMXFnZUlobExnTzN2Vktp?=
 =?utf-8?B?a0drZCtaS3ZtTzVWTHBpRGE1ckgwQlduRUljS2J3bmRzZ0F1cU1YcEpISGhs?=
 =?utf-8?B?VzZpWC81bnFBZHducTJMcWJkK2JLVnczV0FMcUtNY21YRFIreWYrZTg3ekdp?=
 =?utf-8?B?L2pZTVJDV1RpQWU2QnpGUGFuZVdvSzEwTDdaNXdrS2NCcy83RUk2MDhha3JI?=
 =?utf-8?B?WVZIaU5CSDRTNGRnUWtIdFh3Q2tIOEJlTFZOV3dyRnNWMTIwZG1SdTJwckpK?=
 =?utf-8?B?OCs3dy9XamZKRzF5V0JpZEw5Q1dGcm9pUUorMkVkQWpoQ0FESUc0aWU0a2Vz?=
 =?utf-8?B?MkR2czB6Mnh6eFhTTlg4RUNLZnN5eU9VTWxFenZWVjBzZS9WSTRKQVoyd0Zu?=
 =?utf-8?B?MTkyampVRXZySDJGUGN6bUVESU9OalpadFZmRE1VNUpHWm85UzNEWklReTRM?=
 =?utf-8?B?eTR2TzlHN2tMNlp4OHhMVjE4Yi9XbjduNlpuQ1BXb1RBNkJOUE1LcGdZdG1R?=
 =?utf-8?B?S2ppOFliUmJPVXlpZTd2NWp6NnJGaksrUVBEd3ZNbUhGSXNqa1dGTmdwN0Fy?=
 =?utf-8?B?TnVweS9QU2hHUXdDS2tlVlJIanczZGFGZnBFT3ZobWZrZk1JNG5WUDZvUkti?=
 =?utf-8?B?NVdhZ1BVTnlzNy9wYU5OV3BUc0crUnlEMnJDSzM2SmgxbWRFTUc0VWVQamcv?=
 =?utf-8?B?bUhERGo4eDYxV2UzbGNscElpTlJjRlVjUllBZmRQUm05WElFY1lPS2VQaTd4?=
 =?utf-8?B?cUpVRDFLb1UrOVRMVlZsN3pkME83R2NQTmx4UURrVHJYWXVkTlkydVc2RzM4?=
 =?utf-8?B?SlBHUmNuUjBheHlvaEQzamxURFRCdG4rWWhnTCtwb1VPOXo1YjRTLzE4a1Nn?=
 =?utf-8?B?SzhrRWhSMnd4NGExakxORzV2SEs5ZUZzSnBEeXpLNWNtWTJUK0Zhc3ZweWVL?=
 =?utf-8?B?bHNWSGxhWDZpN05lNXoveEhtcGZDa0xNNGRZT2IwV29hS0pZSGJ2OWJmaUti?=
 =?utf-8?B?NmIwTlBEVVk1K3VxUFFkSG9qbFgzTHFqcUFTMGwvWDJ3Y0VJNkkzOUxJQWx5?=
 =?utf-8?B?cUhETEdNNHowcmNqUEUxTjI2V2hOQ3MvYVNQRWg5SDY4UlF5S3greFpucGZT?=
 =?utf-8?B?TmVycnU1WncwOWdrN2tac3R6Nk94bWdpcmlEK0Z5cDJLVjJTTlpxMXRDU1dC?=
 =?utf-8?B?MXljNk5hUDlxR2k0YkJpTnJERkpGQjRBbWl5R1IyK1FsbWFvNVQ3ZllhU1p3?=
 =?utf-8?B?SGdJQm5pYkdNZFFZcUxFbHVwdWoxVnFXZFQ3UWxabDNYS1FlOVBVdDhWTVUy?=
 =?utf-8?B?ZWIwMWdxZGttc0NwSlVjd1VqOXNERytrNk9VZWhhTlBKUFo0aThmNEF3Rmox?=
 =?utf-8?B?NjNDNE9BaDIvQ0pXZVJrMzNiMEcweW8yY3c0NGVuQkUwZXluZ0k0bmk3QmRn?=
 =?utf-8?B?ZzZwZ0Eyd3NaeXZjOWlGa2hWN1VlQlI2NWl1ajJDV3dtdzJ0d3VHSlgvTExO?=
 =?utf-8?B?ZzdGcHV1M00vWDY2NWtXTCt0L0Q3WlR0Qm1PenI0OHM3dTE5UTZVVjQ4RnY0?=
 =?utf-8?B?WWVnSUVCMUszY0xOb0Z2bXAwNFpNSkRudmdVSzNOemtrcy9pVkR6U0NsQ1B4?=
 =?utf-8?B?UmRiVnI3MDk5cGF6QWhvem96OGZUbGg3K2Nxc0VZOHlVekVxc0VvQThxbnB1?=
 =?utf-8?B?WWRjZFlIZitwTGxPdEpHTUM2Tnc5eUtuaUJJQjFmQm15ckVmakRoTzc2OHZ4?=
 =?utf-8?B?ZEI2ZEdoZlBVTmpuRGRNWUJHZ0VndFVIWEJUTFFMMUZ2akhNNVlsQ0M0SzRG?=
 =?utf-8?B?eVJsYTUrM2ZGTHozYm1BbjliSzVwUFVQYVpEaHZYR1plS0ZVUzdvOVd4Zy9K?=
 =?utf-8?B?enJNeE1vZWZGTFNhYVRxcXpEaTh2NjhKbExyYTFaL2lVQzJpaVlkbnVSQ3c3?=
 =?utf-8?B?eHVpb3VWTG1wK0trSkI5Z1NxbzRvcjZMWWRPSS9OMmhFWGtrV0t1ckZZby9U?=
 =?utf-8?Q?032NmoA7cl4EaDtjSg+0na6Ty?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d29b742-22ca-4ec9-e966-08dd1542829f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:35:56.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDaINen4Aqr1EvAmR2DVABK+fxazoj1RrTawi9nuTpCpsyx21wTuRU9/MWeLMxdJZCRFYli3CJGY9npA1H3ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

On 12/5/2024 09:22, Ilpo Järvinen wrote:
> On Thu, 5 Dec 2024, Mario Limonciello wrote:
> 
>> On 12/5/2024 08:22, Ilpo Järvinen wrote:
>>> On Sun, 1 Dec 2024, Mario Limonciello wrote:
>>>
>>>> As multiple platform profile handlers might not all support the same
>>>> profile, cycling to the next profile could have a different result
>>>> depending on what handler are registered.
>>>>
>>>> Check what is active and supported by all handlers to decide what
>>>> to do.
>>>>
>>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
>>>>    1 file changed, 21 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c
>>>> b/drivers/acpi/platform_profile.c
>>>> index d5f0679d59d50..16746d9b9aa7c 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -407,25 +407,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>>>      int platform_profile_cycle(void)
>>>>    {
>>>> -	enum platform_profile_option profile;
>>>> -	enum platform_profile_option next;
>>>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>>> +	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>>>> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>>    	int err;
>>>>    +	set_bit(PLATFORM_PROFILE_LAST, choices);
>>>>    	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>> -		if (!cur_profile)
>>>> -			return -ENODEV;
>>>> +		err = class_for_each_device(&platform_profile_class, NULL,
>>>> +					    &profile, _aggregate_profiles);
>>>> +		if (err)
>>>> +			return err;
>>>>    -		err = cur_profile->profile_get(cur_profile, &profile);
>>>> +		if (profile == PLATFORM_PROFILE_CUSTOM ||
>>>> +		    profile == PLATFORM_PROFILE_LAST)
>>>> +			return -EINVAL;
>>>> +
>>>> +		err = class_for_each_device(&platform_profile_class, NULL,
>>>> +					    choices, _aggregate_choices);
>>>>    		if (err)
>>>>    			return err;
>>>>    -		next = find_next_bit_wrap(cur_profile->choices,
>>>> PLATFORM_PROFILE_LAST,
>>>> +		/* never iterate into a custom if all drivers supported it */
>>>> +		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
>>>
>>> I'm confused by the comment. I was under impression the custom "profile"
>>> is just a framework construct when the _framework_ couldn't find a
>>> consistent profile? How can a driver decide to "support it"? It sounds
>>> like a driver overstepping its intended domain of operation.
>>>
>>> If the intention really is for the driver to "support" or "not support"
>>> custom profile, then you should adjust the commit message of the patch
>>> which introduced it.
>>>
>>
>> Yes I had envisioned that a driver could potentially set custom as well.
>>
>> This idea was introduced by my RFC series that precluded doing the
>> multiple driver handlers.
>>
>> The basic idea is that some drivers (for example asus-wmi and asus-armoury)
>> have the ability for the user to change a sysfs file that represents sPPT or
>> fPPT directly.
> 
> I recall that series.
>   
>> If this has been done they're "off the beating path" of a predfined
>> profile because they're picking and choosing individual knobs.
> 
> The user would still not set it to "custom" nor driver "support" it,
> right? But it's a consequence of tuning those other knobs? Or do you mean
> user would first have to set "custom" and tuning the knobs is blocked
> otherwise?

I think the driver would have to "support" it.  But in terms of a user 
having to set "custom" and blocking the knobs until they do I think we 
can go back and forth on. I don't feel strongly on how the semantics 
would work.

> 
>> So if a user touches those a driver could set profile as "custom" and if a
>> user chooses the platform profile the driver will override all of those and
>> report a pre-defined profile.
>>
>> So, yes I had that all in my mind but as you point out I definitely forgot to
>> mention it in the commit messages.
>>
>> Do you agree with it?  If so, I'll amend the next version where applicable
>> (probably the patch that introduces custom and the documentation patch).
> 
> I'm a little worried about overloading the meaning from mere profile
> disagreement to truly off the charted waters travel. Albeit, I suppose
> that overloading is just between global "custom" vs per-driver "custom",
> the latter would never be "custom" in case of mere profile disagreement,
> if I've understood everything correctly?
> 

I personally see both as the same.  I think we're in agreement on 
multi-driver handler and why custom makes sense.

But think about the common case of "one driver handler".  For the 
purpose of this conversation let's say it's a system that supports 
asus-armory and not amd-pmf and that asus-armory supports "custom".

If the user enabled custom ('either' directly or by writing a file that 
set it) I think it's best that the "global" platform profile advertises 
it too.

Specifically I think about how it translates over into the power slider 
in GNOME/KDE.  I don't think it's right this slider should show 
power-saver if someone manually tuned sPPT up to a giant value.

However if the global platform profile advertises "custom", then the 
slider behavior could show an overlay string for "custom", "undefined", 
a "!" or something like that.

