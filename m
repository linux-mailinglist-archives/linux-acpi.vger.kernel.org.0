Return-Path: <linux-acpi+bounces-9701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927E9D3F32
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED772852F9
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5F1369B4;
	Wed, 20 Nov 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vgdaiSeS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59D12BF02;
	Wed, 20 Nov 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117045; cv=fail; b=MUam/U/ZBHpDEBfP4OnGSoLPoJtmZ9qiHUrP+Ep9jVwtOGPVC25sOEByL5M3ryH/ti6U6wGaYzAxQw/S3Jx2WUOv1wZe12Vq94k3+RGoSVn18nrBovZzx2Xydqc/8qL71Ue+mTqDkpobtjf6o9b3shectp6b1w6EjuMfLjHSlVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117045; c=relaxed/simple;
	bh=KJntywUoaopbVl8cV/NnUfVElhm4AOKorZ3DIXXbyEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SeCyHkKBYzHuAnr/2QAFbPqljPnuKpWwsaOHMMXsHw4/VrdnLlc/9TLG5EhIHQjcc44G8IETV67vTww/U559RpYQeiSpc98kAJTdArNcONgDse91HtFsbkPvlJNhX238nOZLB6Bec7dRrKUCsTraTRAUSzwbWi2tdIzKB6N/llM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vgdaiSeS; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwws51rIfCHv0Plj2s9sWjCwEMq1ImrMXFSd2Fu3isZPtZ/ML4GZKKd9kDwwnZCa/EG8BcGZQInmEGG/aT/u3l0ddWMeFB7/MXH6Jtcte4eAIzKkjPUfZlcjN93Idtk2tu3gIfiui/RRH7SsA19882k1EjT9LbP323keWFJfhchnlSLkAf+ROYwqBu/9uYKu5Eplw+GYcZmIUPjXwVyZcFBc0XLlgH2OPOAJSNIbXlk1CwkZIt2efCsMcY96YMMhDDeGtEqWVuyjVHHdWWNtY4pidCohxYIuabyqtE3xRgmZa6FGEYN9g/9Q7CWx/Q9kTqqv3GYP5zz9oZHwP1qlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izWfrNyXRDMQRGIDTPLIK7rVkenWyyOhTrKoqVgUNp8=;
 b=k5cD+Qg632FK9/xfT+OJE3RECy/gNxZynG2KEf54v2hXuRy5xzJLdwlrVCDqbccxXFNIVDdbosDsUbJGwaYEFc/e3XHhSt10D0K86bIHPWPQhXcZPZisGSXjfA806axQ9XhGHWHLMqXo8xWDvGzPVu8Ll9uyOgLnsKOWa2gWGFXNXe5Dh1hR1iAHsMbr1D2qZvenZZH6hjH0hQnyvlWXtRClsBvAS8hVWB9ArfJRAqDrpAX9V0P1zLRrEOeUVwts6u6enn1odnWR/2AQg9vGQfvl5QwZTwc5i/gJ2YMvkEEZgpuQLXokraWkmeUp3/2WWnu68TeFMn1MOJNzt7XWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izWfrNyXRDMQRGIDTPLIK7rVkenWyyOhTrKoqVgUNp8=;
 b=vgdaiSeSCLJ+ksocbGBktDNgrSCJGLpYK9+e2EUmytRkgl7UoQleqD9u5kfVglhZ7PeDpmYWts1wopjKjhwQRLILFeObYSeY4z3jxKdExnQotTWhxtARfQWFTaNwuW8pfRkKv0zIHUB+wHmJb43IHEwuTzia//LEGuYjfjpOxO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 15:37:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 15:37:20 +0000
Message-ID: <46b822e9-8bfd-462e-9f2f-acddd44bba30@amd.com>
Date: Wed, 20 Nov 2024 09:37:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/22] ACPI: platform_profile: Notify change events on
 register and unregister
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
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-15-mario.limonciello@amd.com>
 <31d48b10-87e1-1064-b25a-71f55736e504@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <31d48b10-87e1-1064-b25a-71f55736e504@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcfa29c-49ab-4b72-3a1a-08dd09793895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z29UY2FqQnVHdXh4RkpTWlZDN2xkM0E4U1BGNFN5Y09QUlFvVVJZUndiWFFy?=
 =?utf-8?B?LzNoN09QMlMyMWFpQXdOSStVTjVXT09TeThMNWVaMDdFTWp0eWM1ZWJXQ0pI?=
 =?utf-8?B?RG4rcE5oVGZpMFZxS1hSdm80TEtwM3NsUHZCdGN4REx6UHpzOS8zdmJ6QTJr?=
 =?utf-8?B?TVdnb1B5NkNrOVpxQXpYaTU1SEpxeHFTblQ3MFZsNEpyd2VGT21GL3dXMHhV?=
 =?utf-8?B?Z29FVFc0cU9BTWZPU0pOcmRzRGsxVVNJSU5URGZYRGh3Rk5pZkM0aFJBbisv?=
 =?utf-8?B?WTFkRmVoMlE4VERmNmJDWTg2eUNrVm5uQmpJblV1TC95QldFdjh0M2hFaWJm?=
 =?utf-8?B?L2YzQ0FqT3YzKytsR2wxTERuVkkxd1h2aVpUS1lwYlU3RkxyT1Q4d1FxUUpU?=
 =?utf-8?B?RGNxdGRkNFl1blFkakJNbVhxUE5xalVrTGgycWZZbUx6bmlXNkhGNDRSd1VX?=
 =?utf-8?B?Wk5URDR4SVZuWUxlRVlLdFZMN1VZUGtwVVFaWEc2V1BkVlRpWjhPQWlzQnlR?=
 =?utf-8?B?cXV5SXBlY2pZWlNMUVRKMVNTMGhHMkFjcXMyR0M3blgvL1FXZUJSMi9neEgy?=
 =?utf-8?B?YkluQm5jd2I1dms4S2lZR25RaWN5N3VLRURYYWJsKzV2aktraW9PRVRtNUdD?=
 =?utf-8?B?R1RPTjFZL1YrTHBHckZMWjFYdWNJQzRBOVJ0OVIraVhlenJKbnFacXNQS3Z4?=
 =?utf-8?B?TlR3bldUQURLSFQyU3lIaGYrbjIxYWhXbFZDb1BXbGJmQURyYlJaNVpvWVRr?=
 =?utf-8?B?eXBtaUpTakRJYVBRZEgvRGpwMjd3UEVwL21CcTdwQU8vMFVzc1dWMGZ5dlV3?=
 =?utf-8?B?SzRrbjVmdlJxV3YrTDBYZW9hYUFvM05rTkZUZWE5aUZSV2hzYUdVbzdmZGow?=
 =?utf-8?B?Yzh1amVNMDZEaW5rNUFDeG9nb2syOEpaNXEvT01aT21lVUVJQ3IxRHlDemxX?=
 =?utf-8?B?bGFodkhETGtBRUdEMnpPd2NaWWI2bkFaZkMxQ05NY28zUmg3bFpOeENnejE4?=
 =?utf-8?B?RTRKd05lTVc2czFsSDZQR3dETHMvZWRwWUx0WWtFU2FRRHdiQ0VldWo0TlBG?=
 =?utf-8?B?UUhQTXN4bU04NVhkcTQ1ajFTNXNRWTN3Zzd0b2ZsUXlsd2J2U3BzTCtDT2xP?=
 =?utf-8?B?dGNSL3J5QUpFNERTRmZRdlhNM1lLTnpKNXRKQzNrYU0wQmhMSnF1YmlYQy9Y?=
 =?utf-8?B?TWFOdzQvM0huK1RPdzlla2tCekxpNDNFa0NZVGpnZWZOTDBPU3VLYWxPbUJX?=
 =?utf-8?B?RCtBZXVwSFZRaWFtK21KOG1LcnlycjVRSlN5aFJRaGpnMzc0YUVLa1BZQUdZ?=
 =?utf-8?B?VWMvMmpBSUVLN3QyeUoyMkdNN0NWaFVtNVNOcGNjbkdjY0pmNy84QUx3WDVo?=
 =?utf-8?B?WUVqV1pDbVVKTWtZZmwzRGNTNHlWM1o1S3poR2dBUnQxV1BKUGxSa3VwemR4?=
 =?utf-8?B?QXRHN3ZIT3RCNzBicHNIa3NJejhEa3dzS0UrWkRWckRxdzJGQnJuOWRqVGhS?=
 =?utf-8?B?VlkyOXdtbVdRMHlXTkh4TFlYdkhoRHpnT0YvbjVPUTh1RlhLWjRwNEFYaVJs?=
 =?utf-8?B?bEJyeEJRYlR3elFxclF4T1B4dDNKamU2UkU1VTdyNTRLb0YxMVdRbTZLdW1j?=
 =?utf-8?B?UnZZSk1rZ0tuUHJNbzJYTStHVFpnUlM0YzBPd3pBMHlxa29vSFhvbFZRR0ZE?=
 =?utf-8?B?aEw0ekhGa0wxOUlmK1ZJejBCcHBHMWlTazhyVlFhWWpnVStqLzFnOTFSODJB?=
 =?utf-8?Q?EGa+0iJDs2spmZuyLDdILJWo2pd8N1TzPlzzu0j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxoZkNwUEFMRmZteUhDL0ljMTM5TnBodHFPcG1GZUR1U05FOUMyRUt1TTNw?=
 =?utf-8?B?Nkl4azlCOG9wMWxaaWlWNG5sbDlnWmpLdjVtRTZUck5NdEJsY0RZMHNQcDZC?=
 =?utf-8?B?QjBJQ1BNaU85SWtwdVFIdm4zVlZoTXlzbE1vcm42NHdsaEE5U2IxZ1cvUGw3?=
 =?utf-8?B?Lzkwa2NJTUN1aURNQkZKQTV2Q1ZINFZaR0FrTkY3U3JtRVpmS1UzVkxBa0Mw?=
 =?utf-8?B?MWtac3pJVzRsekY5Z0wySE5xc2svN3dSQkMwZmg4NzNHWnh0UTdINWxEb1Z0?=
 =?utf-8?B?MDJsdnd3aW9leE9ra1hic2ZoNnpndExoWVB0Rjh4Z2ZMb2dQd1Q5MjNkRFJk?=
 =?utf-8?B?Y3FPRzFPdVVGaU1MYVZaVE0wSTVaL1k4QXI5ODIrY0w4WEFYN1ZTNmwrTjZ3?=
 =?utf-8?B?RERvK2laYldjUVQ2a2lHSnZTSU94RU9tZVpyRUlXcU9MajZXdDAyVmNjUFpn?=
 =?utf-8?B?T1VpUVJCTHo0bDRwa2RaV1JpNnc2ZXNqQ1VoakhqL0FJbWo5aWpsRmZUM25K?=
 =?utf-8?B?dldFeHR1WWI3T0NGblNDWjZTaW9EU1VhTHc4WGlTdTFMMksyMjNiNVJpbmJU?=
 =?utf-8?B?RVdTK2dEejRWOEJBM21HLzJZMm1DSGtMcWIybTFTSHRTTVl6aHVDTExmaTFB?=
 =?utf-8?B?cWZ6UzB4ZDRUbUhvQUFUaXExTGcyUW9XMmZvTzhjczlOb2Q4TlFsZ3ZQQVFl?=
 =?utf-8?B?MUxqalpMQjdaRk4rUGovNVhncFdSYXFtVklIMDBUQ0hFUVloZG9CWFI1ZkVz?=
 =?utf-8?B?d1hVMnozV3V5SFB5RGZIdHZwYzA3Z2hwakxKQ3ZDNmE3Vk1Lemxrb2dQTnU2?=
 =?utf-8?B?UlVlU3MvbFdWRytTVlJGZFhacnIwZElpL1dxczhnN1YxT2RtMWpYL3VMZVdK?=
 =?utf-8?B?cUVtQ0FacFpwNmVjYjM2dmxQaVRZUktZWFZLdUR6RytEWEdrTE1TOVpyRk5p?=
 =?utf-8?B?VzJyNHVBdUpWT2ZzSFJ0MkU3Q3F0dnJTbDBDSG82SEh6UGYxMVk1Q0UwR1Fk?=
 =?utf-8?B?VFc0VEY5d1hvbnI4QzdtbCtPektYeHBZaXZEcWc0dXlVMVJvelNDWHRtOGQ5?=
 =?utf-8?B?UTJUdVFMb3dxc21xOWRTWTBFQVpCK2FNNDhtS2Yrd0prYzhSR25IZ2czWlV1?=
 =?utf-8?B?dmJXNnRDeDBYbmxTUzFNTnVCTFVlYUhwTVVkUVBZempVbXBXQmxnUHg5LzU1?=
 =?utf-8?B?M0dVd05YTkIwN1RMVGVZdTVGYVRMWkJjYVRaYzVRUnNVY0VDZXZNbXBjWGJr?=
 =?utf-8?B?amw1MVVtL3VjbERkKzhPdW1naUExazBKSi8vbkwwTWpxUDVHTmtPNjFxY1dl?=
 =?utf-8?B?S1RIZnZQOGl2Nmlqa1plU3FBQmgrenhzRGJxdEh0ZDYrWTF0Y3FRNFFtamdV?=
 =?utf-8?B?VW9aSUZRYUlWMzN5bWhEY0dNazNUL2MxMjVFY0hLNlh0eVVVZzZibUVpeVZK?=
 =?utf-8?B?WDNsa2l0SHVmM3JFMmRmNURnU1ZKYVVyS3BDWDk5R016TStyeTRkWjJ2RFFV?=
 =?utf-8?B?L05RSFVsbWNyYnRMb1dTNDNDTVUzbzFha3pTRVp3dnF4MlNpNFhKMVBhVlFR?=
 =?utf-8?B?dXZabVJhbnRkclhsNDJzREhYKzdFVXcwdDRBMVdOTWlpRVZxeUxFb0V1NUE3?=
 =?utf-8?B?VzNUTm51N1hCZXBuSlYxd2FTak5Tem81RWZpbXB2MzM1L0tMMGsvajVURFQv?=
 =?utf-8?B?eEpnV2VibWJXM1BuU1pncVE1ckQxRXlHbm9WM0RKZUNaTW9xRFRJTHo4aDVh?=
 =?utf-8?B?ekdsd2UybmpsQlppN3c4SUZMZ281azV6RENmSzdSVUpiMUpFczA2S1JmU2tO?=
 =?utf-8?B?Z0dqZHRzdG1vek1NVDhNZHVQY2liaHd4WWVaTWhLeEt1SDZqeXpGUVlwVStI?=
 =?utf-8?B?UDdRNkNlZ01XZzBydlFjYjJBQm4wSVNPbkNTOEd5K2tST0NlU2lrUW5Ja3VL?=
 =?utf-8?B?WDRqcGpidVpzU3VHeXdIaHpyVzl3blI0T1pFRVZIY25RZTNucFBxQWxYQnNI?=
 =?utf-8?B?K2I4clJmS04yN2VlTTBwMjdIbFN0N2QyaXhNU3NTZjFCMitURktPdUZRV25D?=
 =?utf-8?B?UHlmUW1kUzhkTnNwSzhjSFY3ZFJvMEZqbEc0YmFuNURSSWhoaWcxVW5CZnFO?=
 =?utf-8?Q?YtxLVZE/26ESSZVGphdbjIuLK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcfa29c-49ab-4b72-3a1a-08dd09793895
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:37:20.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgCSOGCglCKv+6+0A8hDAdWn6lQaKV+pftoVSudg6Y8JyiSQcEoIVx8dUp2oI6Rl9blc5FBMqqYNCA9k5hNdsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

On 11/20/2024 09:09, Ilpo Järvinen wrote:
> On Tue, 19 Nov 2024, Mario Limonciello wrote:
> 
>> As multiple platform profile handlers may come and go, send a notification
>> to userspace each time that a platform profile handler is registered or
>> unregistered.
>>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v7:
>>   * Add Armin's tag
>> ---
>>   drivers/acpi/platform_profile.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 1530e6096cd39..de0804305b02c 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -363,6 +363,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>>   		goto cleanup_ida;
>>   	}
>>   
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +
>>   	cur_profile = pprof;
>>   
>>   	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
> 
> Is the ordering problematic here, how long userspace has to wait for the
> update to become visible?

TBH - this feels like an artifact of the earlier patches.  I don't know 
that we really need the notify anymore since calling sysfs_update_group().

I'm tending to think drop this patch entirely.

> 
>> @@ -393,6 +395,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>>   	device_unregister(pprof->class_dev);
>>   	ida_free(&platform_profile_ida, id);
>>   
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +
>>   	sysfs_update_group(acpi_kobj, &platform_profile_group);
> 
> 


