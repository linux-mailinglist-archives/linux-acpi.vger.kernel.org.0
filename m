Return-Path: <linux-acpi+bounces-10472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFEA07D9C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8064E168224
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B0222593;
	Thu,  9 Jan 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3JiMZcFG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21471223333;
	Thu,  9 Jan 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440353; cv=fail; b=AVnwE+4F2unG5mEPW0pz/dEmBDKDCv+2doMID/lNzn9UuIOfvezoVSDXFPSdGk1JNlNgyORHCF5s6T+2i0eXvA+N6AeZQu3lR9/FRgnH4hsMbGPXGW8yq5P1jGq+4L2j+axJC6uc+k4Po2ISaSLMVwisE5cTlciuyjGzEaRN9eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440353; c=relaxed/simple;
	bh=MvD65H2hHcw1ri8SK+NZH3MVYFmdKW58g/iX1uCX2Ps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf+hHc9kaVOR1Eqxi8rWfIptx5wKxaPrWhbC+/bgwcwUfC2cO/m4F6Oy+xqxIjnq6q/A7axXLXs8Kdk69si4KBiUbNRV+elCfQ/LopRe1y72iEKA5J/85xhyOPCIGK8Jawp08lW5qWtW1HYn2I4j6BD0S4leWe+uptdQ0ah1VTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3JiMZcFG; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGIJ/1vUD7VMR/qRKZBVyLBrNaCa6r/qaqEGYyajhcHHXRdtbNDc8owo1sWTjRJeAvAPgt2FmV4YEwE1KBeyXzJWrorA0TAdSURAP7q4FnA8K/pOUupA3x/fF2JHoAvU7tM7bJhSXQFuJyKu3yLvDQd5j5XxxGI98JIejjlEGs6s5RfIkhak0KHbCuHtxJwkJtckHf44ShwxiGkfYPumBoyoltD+1614Fu2Jmq5+V789N4pX3yuXeTfq1ydIFsEgCcpxhq8nwbMzKcTiDFc56M2kLzdf6FbdFpfBFR5nffYAkKwCRj9OvFwXBkEpNlj6xAQQj9Dj8lDiENLdCRFGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNwMIzaG4jrVROEYxxB1nRaorqPKtq2A2nShZKiYwoA=;
 b=JVibpCsTLmmSEnHPeQQ5MJ50vd6mfEM9OkRBNoWkEdKV/k7GJtjVBQ8ndud5eoHPHOAw6mJVAKvulTggDq/NGN8e1skaSMpe6tr0gtinPup/XkoAh1toN9Grof65VSF8g9fmGTrBrEQ8t1MuTDKRY+pwZtRotFBWdIa4JkVFDrZtqLbZnYJ92688hO86iepxA76XIqHYKX9OecnFnPQJMgSCcrlxqx7TU5RVvuwqVYIbHObAEALRFJs1VbD28e4H8dQGNxZNLf4ST/1TwG4ZpU3aQiA+/ztg3bBi+582sRfe43bmDUbQp4P58N3VJ0HRcBQ2WUIjNo72+vyJgJWUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNwMIzaG4jrVROEYxxB1nRaorqPKtq2A2nShZKiYwoA=;
 b=3JiMZcFGO18cGxbV88hqNG3AtieAeYpKSXCvAZkoboau9tOEks6lsfHvcqHXTJqT0bcPONRiaaMr2McQJvO6PS4Rzfg4BAODrYq4wI03ogVuERE8kzBiUqEWak3xWUsJ6SYw0lwIIEWYupvoL4L8ON77r7Et5z0cNyeTI/06HBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:32:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:32:28 +0000
Message-ID: <1c921cca-1ac8-4e73-94e2-79884f596287@amd.com>
Date: Thu, 9 Jan 2025 10:32:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] ACPI: platform_profile: Add `choices` to
 platform_profile_ops
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-3-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4169afc8-f055-4237-922e-08dd30cb34cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlg0NWhndDBQMlVhOEF0ZC9jVE9vTUM0NlVTWnFPUWh0UEpZS1J1c3NXTlo2?=
 =?utf-8?B?MFhiM0JpNXNZMnNWQVhrQ1BxSHgvSi95c3kxMGhPbDhZekk5RSthUHAyYjFj?=
 =?utf-8?B?cml0YVB2QjU4YmZFUlVUYldRVHQ5b0dKUU4wVCtOVzIwMUpjRjQ0WFg5Qjhi?=
 =?utf-8?B?ZGc1d2VmcGxRL3FXNjFoYUxQZFRqWnkzWVZKK0dGQkJwRFpzcFdxSUppTVhz?=
 =?utf-8?B?aVdVWmljN2NQdGhvV2VVZWNrOCtmWkpUTk40cklVZkpWNEZNUG9KTVlRMTRT?=
 =?utf-8?B?eTF2NTFtM3BaeG9NUmFDR3VyQ1dqdGN3R0JnOVBaQ2lPWDBIT1Z5SkNrOFFW?=
 =?utf-8?B?bkdrVzVvaTZ2U1BRNy9vcEFWOU96Tjd6NzhQZC9KTHNJSTJ1ODF3enMyQUc0?=
 =?utf-8?B?cUNoaTJoMFRuNXU5UjFXNVNHcG9XK0VGYUpwZy85UFI0Z0kyTWtCd0M4dzRM?=
 =?utf-8?B?b0gwNVZJaEtzaDV5S0pIWURMenRxWGgrQkhZSkp1THpuTU1JaThWczhuR0FJ?=
 =?utf-8?B?MkJkNlVWVjNLaTJDWUtYZ3YrellMTEpyZUIvSnByU2puY0diVW5pV1NseDdR?=
 =?utf-8?B?UVBTTVZqNXZ6a3hweFQ0b2ZOQ0lNallRT1NtV3NnS2xzaHduZEtiNFNqVmFW?=
 =?utf-8?B?RE9weWJmM3d2Mk9yaGt4NXhiMW5ZcHV5ZTVMU2s4OG9YVjJITXliMU13ODNm?=
 =?utf-8?B?RWpNbFFzemZFaHhPYTlHTm1lZ2lmUFJNVFlaNkkyYTl5cFoyazQrNi9oNlRO?=
 =?utf-8?B?OXVPYWV3b0txNk83MVpxd3lNRHA4TjBvYTVpNGxGdmlVSGluSXJodXBJaEZ3?=
 =?utf-8?B?bWNoZ2pMT3hlRk0zdE1aTG9xSkJSWlN1UjFYSnVqb0h1bE1ycmF2dlBscVUy?=
 =?utf-8?B?YnNGWW9CeTF6YlpHL1NaZFM3dnpadDF4OC8rZytsQmxqK2xZaTA3ekJoVDRU?=
 =?utf-8?B?K0dwOG1oWFB2OExkR1RIZFI2emtkeVd4M1hrSVIyR2duZWdNblBFQU9kbjEy?=
 =?utf-8?B?bVU2TFl4YWJ6Ync0NlAvd3liR1lrbzlncHBzbUhWZWcwRTk2QWtCeDVZbUtM?=
 =?utf-8?B?b1A1c3lhSHlUdlJSS2VJUVVOUkdIWXN2VUFzSHRaOFpRQ2FjRUdndXVBMlBl?=
 =?utf-8?B?aTdDMWd6ZGVRVVBqa3cwaVhWZXdyeEczQjg2czVsWHVjdmN1N0NwSnNRZDJY?=
 =?utf-8?B?MWM1Vy84a0M1b0g4K3dWNzFtK2tCVjgwMjJ2cU9kMFBDTmR0SW5paU56NnZj?=
 =?utf-8?B?RjlhWW0wNDZKc1ljVUp1SzJVYnd1MVpyN0lzK3N4RDhRamNLWE1FV3dwRHha?=
 =?utf-8?B?bGRqUDFXYTBVd1RWOWttTUFWMzZOK1ZrWmdOUzVWSnZKV1FkZGRKRXRMMVp2?=
 =?utf-8?B?bVJ4Rzh4bFp3ZThKcVYrdWtOVlo3S3VHdGVCSU9XTkI5cnFOMmxJdy9HcjlP?=
 =?utf-8?B?YXhuZG5WbEI5eW1yUW1GRzdYT3cvQUZxTzFGOWszc3ZTa1VTbXdhREg3VUZN?=
 =?utf-8?B?OVRtRzkxVGlGU1dDalhXek9iejJJWVR3UUcwQ2RZNnJueEpaRHcxKzZNN085?=
 =?utf-8?B?cDdCWDhoemtqSFVsMEpYNlpRR2NJWFZCMFRsWE5IVFdad2RQQklDbW80dThL?=
 =?utf-8?B?OXhQSnZhZkIyVk9zM204N3U4RUV2TmlRUFJPT3MyYlBZK3l5Zm03VWpDMXFB?=
 =?utf-8?B?V0loeGNpUlBYZTVMNXFTUkY3U2dOamVFa0t6UlpENXMzdW1YK1JTNCtHL3M4?=
 =?utf-8?B?a2pSRTRKQzRDaVZSOXNUc2xObXpoYzBzcFZqTHFSMUhpZ3ZaSTYvSE9SVE92?=
 =?utf-8?B?VnRQUDRjaVpZbXBnQklsTlB2OUQ3MUtheXJTVWdId2MyMCtKeFNNWVFxb3gr?=
 =?utf-8?Q?3raj9y/4aR8BG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0tpdWkzeWcvbDRRRFZpQ3BCSlNYamFRdWtyWVh3aWQrMDZNQ0Y0VThUS1VX?=
 =?utf-8?B?YTVVMStObUFLYVdhV3RNMlZGZEQ2eFpiRlBGdkR3NnVPQUxEVVFWWHFwY1Vu?=
 =?utf-8?B?OGIyL1p5TUdScitXYmJpb1V6WkhmVHhxSUpwNitnQ21IckEvNGtab2tsUmhx?=
 =?utf-8?B?SSt6S3NLWGJrZ0RsWncxZHNlUHVxR0RaVlh1cSt5RHRaY0VlZ3VEQ1g0TDQ4?=
 =?utf-8?B?QndBVHEvN2pnZWlIMUJ1Vmd3cGwwWTBRL3Y0Y1ZqY2lvS1RHbWczamRTaE1C?=
 =?utf-8?B?ZUxyT3AzS1dURUxhZ21aayswcVhYRk9veUM2dDRWRzd5eHNIa3BPMGJPaEZH?=
 =?utf-8?B?cU5pZDc2d0VDQmozS2Z0YmF5YVp2VGtnV2JkSUpSM1hCeS8vQmF6ekpYd1Jt?=
 =?utf-8?B?eHZoUHM3UEdFblRFWGxESDVlMGlUcnphdUVDTjZnUGVUdEc1VHM2MnZxa1pF?=
 =?utf-8?B?Q09ZTXY2cnVlckoxaUlEWHlPdDRwZHozeXBjd0M3N1VYZ1h1enJzUHpjMWJN?=
 =?utf-8?B?RGgwdUJOb0kwOGFZTWRvbHQ0eUU5MnFDdzg4SWFnK2FEejhkK2lrNjNqUHdv?=
 =?utf-8?B?cjhHY1dablRhVjBqeGVMc00wb3E4Z3hsS0M4RkR0ZVhBY0hDcjFTZWJiSjU3?=
 =?utf-8?B?UXNDT1YwVkNFeGt1MG5BbjliMDBES1pxTFJkUS9SU0t6M1lFRmNiTHgzWUlZ?=
 =?utf-8?B?amNGbG1CRGIxOVRSQkgvVVFyQ29rSm9yL3lHOER0SUNTUG8wQ0E0TEQ0VnUz?=
 =?utf-8?B?d1gzdk5mckZBb0FHdGlmWGViZ2Z6M1VHTC96Y1JjSjRkczY3S1dacDhDS0cz?=
 =?utf-8?B?Tmx1VWlGWXhCRWRPNWppMDV5THY1OFYydTZXZUppb2tEc3lWZXYrNlg1VnVK?=
 =?utf-8?B?QnNwTGdVWEZTQ3J2ZEFBWUlnN2t3eEFDcE9kL09VaXlKWmdkWERKMVNuQ1lh?=
 =?utf-8?B?dVFSd0J0RGxKS0Z2Mkp0TjFrRE1td3p2bUlzQkxlZHc1cWdHYUQ5U1BJSFB1?=
 =?utf-8?B?ZTZyTkVaMW9OTkRvOUdPMUhGZlZqRGdLUGp2b1NsbUhhVE5DdUNzaUUvdjFY?=
 =?utf-8?B?N0hOdjE1N05xV0dXNkxRL3R5U1BlNlVMVkxXQXgyV1J1cUYvdzhNaGVaZkhZ?=
 =?utf-8?B?ZnVqYUdNS2owUXZFc1JxaDMwdzBmRytrSGU2cmVOWlNiOTd1NEZqZUdPdGRi?=
 =?utf-8?B?VEVLc05RS3RXUEdkaS9rK2lUWW9ab1BNNUw3Rlh2R0JFb3hiZUw5ZGNUM3pZ?=
 =?utf-8?B?SmsxeWJJN1RkWUp3YTZnRjFKOGorOHRQam5TUnZ6TzFoVWJJQ0ZIZkQ5eGV1?=
 =?utf-8?B?NlpWMllhKzBYa1NENjlsSzdnMGZrQnVvM1p0UmttNG5FZWxmRm5QaHVock1p?=
 =?utf-8?B?NGRFRytuK0pzOUVuTkswL0Q0dEN6bkNiVVpoNklTVnB4ZWtSMytGVllpejBh?=
 =?utf-8?B?NUJFaXdGeHlCMTc5b0ZIa3JmenhPbzZycUUyY1UrRC9Wc1RpMFoyOTlIa21O?=
 =?utf-8?B?amE2b1JLeDZPTWJDR1grT1lhR2VpelBCY1hxN0lDVjVZaHVUQmRpN2JuYVFF?=
 =?utf-8?B?Zm9yYmhtOTdaL1Z1eW0waXFIKzNyR2wxV21DMG5nL1EzZm1wM2c3ZGUvcTZR?=
 =?utf-8?B?M2d4WmRINkVlMDFIQjlKUy9LblR1MVZBRFNpNlBsQlQyWkxPd3lGdXNBWmIv?=
 =?utf-8?B?dS9qc3FCT1NYUkV5bTB3Y3hBTktpMDQ1RHoxMFpmeURNZnN5UkEwRTViTVRR?=
 =?utf-8?B?SXQvTm9VcENGd2hlTDhBU1ByejNuZVFoZG1Pa3ArNnZ6cnFrRGxKMDM4bVpO?=
 =?utf-8?B?b2dQU2d4SmZvR05yY21QTmpPQXZBK21ITUdGU21RQlNpUGdBZy83ZCsxZ2NK?=
 =?utf-8?B?YWt5TWtjdG9xQ2g2T2RVSTRkT0hXOVgrVmpTMUkvYmdSUjNieFIrZXhMUXg0?=
 =?utf-8?B?RWdLYXlreGxWcmkzV0tMSE5QSjBOemxTWG1SazdnTGpTWkFTLzJqT2RRYXNi?=
 =?utf-8?B?YXZrK3MxUVpHY0YyVXRvSVA5dFZVbFlCc2sxYko1bHE3NXluUk9xNXJhWXpS?=
 =?utf-8?B?K3ZkV2IyYm5IWEFCNVVBSXVzWXFiYWZuNlc4NDE2Q3dIaWI0Zlh4a0VqYkha?=
 =?utf-8?Q?4VCBsXSRHKX6YTbsxCocx8+g/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4169afc8-f055-4237-922e-08dd30cb34cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:32:28.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deDWSicmeZRCi+/HvmlhZCYmVmOPYjhCmKO3/XG7mgTtV53FZCf9AfulKTPbIUCfnpsdeGhPilZ8E7iFV4LM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Add a `choices` callback to platform_profile_ops, which lets drivers
> specify how to select available profiles.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c               | 13 +++++++--
>   .../surface/surface_platform_profile.c        | 16 ++++++----
>   drivers/platform/x86/acer-wmi.c               | 24 ++++++++-------
>   drivers/platform/x86/amd/pmf/sps.c            | 15 ++++++----
>   drivers/platform/x86/asus-wmi.c               | 16 ++++++----
>   drivers/platform/x86/dell/alienware-wmi.c     | 24 +++++++++------
>   drivers/platform/x86/dell/dell-pc.c           | 26 ++++++++++-------
>   drivers/platform/x86/hp/hp-wmi.c              | 29 +++++++++++++------
>   drivers/platform/x86/ideapad-laptop.c         | 15 ++++++----
>   .../platform/x86/inspur_platform_profile.c    | 14 ++++++---
>   drivers/platform/x86/thinkpad_acpi.c          | 15 ++++++----
>   include/linux/platform_profile.h              |  1 +
>   12 files changed, 137 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 39a22e27acc5..9cb82173947c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -464,12 +464,21 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   	int err;
>   
>   	/* Sanity check the profile handler */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> +	    !pprof->ops->choices) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
>   
> +	err = pprof->ops->choices(pprof);
> +	if (err < 0)
> +		return err;
> +
> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> +		pr_err("platform_profile: no available profiles\n");
> +		return -EINVAL;
> +	}
> +
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 2a9716372d56..b69fcc4c3858 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,9 +201,20 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>   	return tp;
>   }
>   
> +static int ssam_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;

At first I didn't really like the callback, but it grew on me and I 
realized why I didn't like it is because it's confusing that the 
callback is called .choices() as well as the implementation used is 
called .choices.

If anything it should be "set_choices" or "probe" with a slight leaning 
on probe()..

With probe the flow could be:

driver()
->platform_profile_register(ops)
->->drivers's implementation for platform_profile_probe()


> +}
> +
>   static const struct platform_profile_ops ssam_platform_profile_ops = {
>   	.profile_get = ssam_platform_profile_get,
>   	.profile_set = ssam_platform_profile_set,
> +	.choices = ssam_platform_profile_choices,
>   };
>   
>   static int surface_platform_profile_probe(struct ssam_device *sdev)
> @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> -
>   	return platform_profile_register(&tpd->handler);
>   }
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index ac7b3ab8fd2a..1fa0cd69da8c 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1900,9 +1900,22 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static int
> +acer_predator_v4_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
>   	.profile_get = acer_predator_v4_platform_profile_get,
>   	.profile_set = acer_predator_v4_platform_profile_set,
> +	.choices = acer_predator_v4_platform_profile_choices,
>   };
>   
>   static int acer_platform_profile_setup(struct platform_device *device)
> @@ -1915,17 +1928,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   		platform_profile_handler.ops =
>   			&acer_predator_v4_platform_profile_ops;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_BALANCED,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_QUIET,
> -			platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_LOW_POWER,
> -			platform_profile_handler.choices);
> -
>   		err = platform_profile_register(&platform_profile_handler);
>   		if (err)
>   			return err;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 7c8391ac4dbb..37316bc3e071 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,9 +387,19 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static int amd_pmf_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops amd_pmf_profile_ops = {
>   	.profile_get = amd_pmf_profile_get,
>   	.profile_set = amd_pmf_profile_set,
> +	.choices = amd_pmf_profile_choices,
>   };
>   
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> @@ -414,11 +424,6 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	dev->pprof.dev = dev->dev;
>   	dev->pprof.ops = &amd_pmf_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&dev->pprof);
>   	if (err)
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ef4129d91656..3e94986078a6 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,9 +3852,19 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static int asus_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
>   	.profile_get = asus_wmi_platform_profile_get,
>   	.profile_set = asus_wmi_platform_profile_set,
> +	.choices = asus_wmi_platform_profile_choices,
>   };
>   
>   static int platform_profile_setup(struct asus_wmi *asus)
> @@ -3885,12 +3895,6 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED,
> -		asus->platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> -		asus->platform_profile_handler.choices);
> -
>   	err = platform_profile_register(&asus->platform_profile_handler);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index c824414565b6..386b22e9c922 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1108,12 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> -static const struct platform_profile_ops awcc_platform_profile_ops = {
> -	.profile_get = thermal_profile_get,
> -	.profile_set = thermal_profile_set,
> -};
> -
> -static int create_thermal_profile(struct platform_device *platform_device)
> +static int thermal_profile_choices(struct platform_profile_handler *pprof)
>   {
>   	u32 out_data;
>   	u8 sys_desc[4];
> @@ -1146,19 +1141,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		profile = wmax_mode_to_platform_profile[mode];
>   		supported_thermal_profiles[profile] = out_data;
>   
> -		set_bit(profile, pp_handler.choices);
> +		set_bit(profile, pprof->choices);
>   	}
>   
> -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>   
>   	if (quirks->gmode) {
>   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>   			WMAX_THERMAL_MODE_GMODE;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
>   	}
>   
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +	.choices = thermal_profile_choices,
> +};
> +
> +static int create_thermal_profile(struct platform_device *platform_device)
> +{
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
>   	pp_handler.ops = &awcc_platform_profile_ops;
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 1751b7235031..ba366c28d9a6 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -24,6 +24,7 @@
>   #include "dell-smbios.h"
>   
>   static struct platform_device *platform_device;
> +static int supported_modes;
>   
>   static const struct dmi_system_id dell_device_table[] __initconst = {
>   	{
> @@ -231,15 +232,29 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static int thermal_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>   	.profile_get = thermal_platform_profile_get,
>   	.profile_set = thermal_platform_profile_set,
> +	.choices = thermal_platform_profile_choices,
>   };
>   
>   static int thermal_init(void)
>   {
>   	int ret;
> -	int supported_modes;
>   
>   	/* If thermal commands are not supported, exit without error */
>   	if (!dell_smbios_class_is_supported(CLASS_INFO))
> @@ -265,15 +280,6 @@ static int thermal_init(void)
>   	thermal_handler->dev = &platform_device->dev;
>   	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
> -	if (supported_modes & DELL_QUIET)
> -		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> -	if (supported_modes & DELL_COOL_BOTTOM)
> -		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> -	if (supported_modes & DELL_BALANCED)
> -		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> -	if (supported_modes & DELL_PERFORMANCE)
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> -
>   	/* Clean up if failed */
>   	ret = platform_profile_register(thermal_handler);
>   	if (ret)
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index c37e44f7606c..3c2d4549eb7f 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static int hp_wmi_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	if (is_omen_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +	} else if (is_victus_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +	} else {
> +		set_bit(PLATFORM_PROFILE_QUIET, pprof->choices);
> +		set_bit(PLATFORM_PROFILE_COOL, pprof->choices);
> +	}
> +
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static int omen_powersource_event(struct notifier_block *nb,
>   				  unsigned long value,
>   				  void *data)
> @@ -1568,16 +1585,19 @@ static inline void omen_unregister_powersource_event_handler(void)
>   static const struct platform_profile_ops platform_profile_omen_ops = {
>   	.profile_get = platform_profile_omen_get,
>   	.profile_set = platform_profile_omen_set,
> +	.choices = hp_wmi_platform_profile_choices,
>   };
>   
>   static const struct platform_profile_ops platform_profile_victus_ops = {
>   	.profile_get = platform_profile_victus_get,
>   	.profile_set = platform_profile_victus_set,
> +	.choices = hp_wmi_platform_profile_choices,
>   };
>   
>   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
>   	.profile_get = hp_wmi_platform_profile_get,
>   	.profile_set = hp_wmi_platform_profile_set,
> +	.choices = hp_wmi_platform_profile_choices,
>   };
>   
>   static int thermal_profile_setup(struct platform_device *device)
> @@ -1598,8 +1618,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_omen_ops;
> -
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	} else if (is_victus_thermal_profile()) {
>   		err = platform_profile_victus_get_ec(&active_platform_profile);
>   		if (err < 0)
> @@ -1614,8 +1632,6 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &platform_profile_victus_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   	} else {
>   		tp = thermal_profile_get();
>   
> @@ -1631,15 +1647,10 @@ static int thermal_profile_setup(struct platform_device *device)
>   			return err;
>   
>   		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> -
> -		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> -		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	}
>   
>   	platform_profile_handler.name = "hp-wmi";
>   	platform_profile_handler.dev = &device->dev;
> -	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
>   
>   	err = platform_profile_register(&platform_profile_handler);
>   	if (err)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b49ee94f9bee..f5ea03763a54 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>   	return -EINTR;
>   }
>   
> +static int dytc_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static void dytc_profile_refresh(struct ideapad_private *priv)
>   {
>   	enum platform_profile_option profile;
> @@ -1066,6 +1075,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   static const struct platform_profile_ops dytc_profile_ops = {
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
> +	.choices = dytc_profile_choices,
>   };
>   
>   static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> @@ -1112,11 +1122,6 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->priv = priv;
>   	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->dytc->pprof.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->dytc->pprof.choices);
> -
>   	/* Create platform_profile structure and register */
>   	err = platform_profile_register(&priv->dytc->pprof);
>   	if (err)
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 38d4745f6be1..8fa9308d4686 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -166,9 +166,19 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static int inspur_platform_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops inspur_platform_profile_ops = {
>   	.profile_get = inspur_platform_profile_get,
>   	.profile_set = inspur_platform_profile_set,
> +	.choices = inspur_platform_profile_choices,
>   };
>   
>   static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
> @@ -186,10 +196,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> -
>   	return platform_profile_register(&priv->handler);
>   }
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 04a292af2bfc..a35453c3c605 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10538,9 +10538,19 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>   	return err;
>   }
>   
> +static int dytc_profile_choices(struct platform_profile_handler *pprof)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pprof->choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pprof->choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dytc_profile_ops = {
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
> +	.choices = dytc_profile_choices,
>   };
>   
>   static struct platform_profile_handler dytc_profile = {
> @@ -10584,11 +10594,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   {
>   	int err, output;
>   
> -	/* Setup supported modes */
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, dytc_profile.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, dytc_profile.choices);
> -
>   	err = dytc_command(DYTC_CMD_QUERY, &output);
>   	if (err)
>   		return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index a9db95bc360d..972a62be60b2 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -34,6 +34,7 @@ struct platform_profile_ops {
>   				enum platform_profile_option *profile);
>   	int (*profile_set)(struct platform_profile_handler *pprof,
>   				enum platform_profile_option profile);
> +	int (*choices)(struct platform_profile_handler *pprof);
>   };
>   
>   struct platform_profile_handler {


