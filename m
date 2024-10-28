Return-Path: <linux-acpi+bounces-9056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F889B37BC
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B41A1C219FD
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4311DF720;
	Mon, 28 Oct 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I9y47d75"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386F1DF279;
	Mon, 28 Oct 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136941; cv=fail; b=Jd0prT0UQvL9nNSDj5BURbiYBuyUfTw35vVMgQyT8LsPCWJT7gjKmOvHdIinriBlT6meQz95GcBQtdqts6AkVhJRlAKxIIXErnJLVkCvAlb/Dfomp+GuPzn8yEx757pTIYu5h7+H3ivM38sA4ysZ3kSbbHxMITOGu0r6fV8MK/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136941; c=relaxed/simple;
	bh=E+Klp9eyajQX4oy/Qs4ItDNkpSPFlPOEcepSWcJ7BtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOQsICOnYkcv82+J+pfaaG1I6chu0HCrLg8sMLrbBPyqqzolBU1BQHyBZ33tLTw/xcnrP8ZncwnI8UfEoHls2DGHczaZLq6oBlWPHr/ZxNvXkKzPhB3raJUHWm2WJbzonsoFXPT9AIusnANBeW+oXRJjAM3nGThr6N9j0mKgCGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I9y47d75; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu4Duxlo10mt5uqXM+kkv2b4YSfn7JAmc5tnXmjIYv9sgJWFNaK26vrko/cUKo5Bkw1fR2j9nns1RfIbFMk3CP17T/m3ka42v8YOleah8RD8M/19C7fCuQvlW9M1cBJri0VUfnAhi0JwXwQDYzgl90h4aNFcN6cO7YogBkaHOn0o8DIYanB2cysFfOHCLPuVjDfyaap2z8T7GzLhFtfwy43B8KHvlO9gY16q2rI0MCwAr7ptsxZPv3yjv0SU7vHAqLWOKmDRVm6nd0LB7vgpGm7vsC9egaAqpN8lZ2/9zwTCqfbe0PcYlfigVcxlv6oYa9eAYCk6i+I1R5BX5ooIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdQoSew7J+J1xPn1npmC5qzEWm8YHjNtB74rBpYWs24=;
 b=LS7btxXKJbjQeDFTJF1qsC11OFm2oTs1UpCgoGJfgBR+KnBsVgBfUrc7aGhiMmrPWhdxffHtqcJlsRXMA1AMiLFztWCn9gp8dRYygXGJXa4FfnZ7qedNmnrd1XFdE/re9cF7opC6gWDd4IF57iEO14/itfMqcyePJh549fGK+mjIEq7FSVZqU4ULFzExn5c3vZ8xD3UxOB0vx6r2s2F3uwU5YdvGGI3/bSTLJgJYzwbHrAv2fTNQoWDllGV/G88oP0ud7ErZgcsvqWa7qNFyiKGXY37IK/SD06aUoVtrhdUgXXBigXeOaH2zfNNcYNtkGBHlRvR3QbOh/ZML7Ux3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdQoSew7J+J1xPn1npmC5qzEWm8YHjNtB74rBpYWs24=;
 b=I9y47d75caBMXKVZH7c5MyLYlStOYei1MBwi1wvtdxg0ppLeE8C+VmBNDwaMGVEaJfC+JWpSmIYG2fy9khti0Hr1QafrUY0NAZ38jV80UfyRHeOrdGCP1cLDA0q2PN96kqL3C7VoU1V6mCaeMKgpnwEMkgeWabI7RvlQ4nO6uec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 17:35:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 17:35:32 +0000
Message-ID: <d1debdce-5c86-4005-9ca1-29e646694942@amd.com>
Date: Mon, 28 Oct 2024 12:35:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple
 handlers
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-8-mario.limonciello@amd.com>
 <bfafd7c5-6757-42e5-a3cf-d4695b6723cd@app.fastmail.com>
 <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
 <93160eab-8b19-4b21-8539-85cf1c2a2dce@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <93160eab-8b19-4b21-8539-85cf1c2a2dce@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:806:120::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d16763-fdb9-4ac4-f588-08dcf776ec72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC9md2xUMTQ0NExRZER0QUF4S3YvWmlnQVRLVGltWk9mNnowV3pyOVY4eDNK?=
 =?utf-8?B?eDdaMXFnd1BrNVNoWERhejZ0aXcxK00zNFFTYktGdWlYVXVCdko3Rm9rdDln?=
 =?utf-8?B?cEhOOFlCZ3NYOUtvRFdoSVdLWnhZQVFFTlJzdkJ2ZEJzam52S0E3eEJpemFW?=
 =?utf-8?B?eS9sSjg2TlVndkl5TXkzdTY1WjJEc3ZrSjVUL3pDWkRnMGNYaDlTdDc4TDdY?=
 =?utf-8?B?dTc0bEFXOXA2OUMraW5aTURVTTJ5MDR5a2FEWXZlQjF2UkVzb0Y5N1U2UGR1?=
 =?utf-8?B?TEJGMjA3OUhKWTlDTnlPTVloUktkUndQU09sTzgrdkllWWZyaEpHK0FRRlJa?=
 =?utf-8?B?RENkcVdiR29xT29MVEVMZlhCSzlNRmg1cEt1R05XWjNpei85cjBta3U4aHVk?=
 =?utf-8?B?cGxpZVFJcDd5UFF3a0pldDlFMUJCQytrZElUR0NJUTUzU2NGWERGWEhpeTUy?=
 =?utf-8?B?eEp6b3pYYUEyK3QySCt0eVdJZnh3Y2hUT3RSdmRQN2hkUG9SSUFYZkRJOG5s?=
 =?utf-8?B?Mjlxc2ZBbyswbXNGUGdrcHlGb0Z6Q1JoVEVxVStxaTRkaDBZQmFtMkEvQm8z?=
 =?utf-8?B?cGJ0N3Y1NmdVWlhwUXFNYTVFV2lWUnhIWkhGaXNPSHNaUkRzampUZWdZL1hY?=
 =?utf-8?B?MzRITnVLU2VuT1RNWk12UGdLU0VhNXNGTE5GV2lZb1AyaDVTSlhLdjRheEhx?=
 =?utf-8?B?MWZVekJodXhHckI2WFhMeGhNTnNHOXVTMDZENlYxK204ZFJ0WldsOHFqVjF2?=
 =?utf-8?B?ZkZKb0xxYktNOTFnQktPMVBnQjVLQTFhZUpJU0xhNjJoY0lrUmV2dGxKdlpR?=
 =?utf-8?B?U1ovNGY2czl5TzhmYmdwL21qazFIdlBqQzFMUVB4cHhEWmFjK3NOR0QzMjR3?=
 =?utf-8?B?ZkV3UzJBRzRkUGkvaFN3Q1czWE1ZZFEvUkZwTlhnaittUDVDNjhtQnlXTkxx?=
 =?utf-8?B?aDh2KzRkS0haek5YczhvT3hxRHBoSnloNnY0Uyt3cEtSdmlpY1NGN041UWdP?=
 =?utf-8?B?UnZCWGNZS1lyL3VFa1IzZlloR1JCU3JzZitjOHdXUDRZM09EK2V4SzMzR0Y0?=
 =?utf-8?B?VTVrSHM3NWtpVE5MRml4SWRDSHI3d3VibDhHY3pWQjl0RExxR2dCenRtMUlj?=
 =?utf-8?B?WnlPcSt2ZktYa2xyYVQ0TG9kYlp3R1R4STdFdm9mN2NVZGY1U0RocE5Sa3JU?=
 =?utf-8?B?TXVmeDZlek4yWGQ2b1ZUanZSRTZZcUtYVUFzTmxqTWEvZHk0Q3pXSkttbmty?=
 =?utf-8?B?MjNvbjBPM2pGeDlUNzZwZ0c3MVVpZTk4bkZtOGZUT05iK1l6cGI3R1M0RkFX?=
 =?utf-8?B?TENDMmVxS1IzYTVjTDkzS3JvQ20zQlZabnZWalg4Q2E1Vll5dE1Ybmk4NmhU?=
 =?utf-8?B?bmJ3NjJ4MXhaWjIyZ0FTZ2xxY1lIMXR6ZldZbGtQemg5VGN6M2lHbUFTRTRN?=
 =?utf-8?B?Mnk3emkvSjlkdkxjVHBDQk1mVDJibi9VYytrY3dmdmhBdXg4d1VnRU5NR3JF?=
 =?utf-8?B?L2JxM1ZDSk5LV0U1dUZPaFd1c1JpUXlhTElWSXFsRnhCd3BaYmJNOG1Zc0VO?=
 =?utf-8?B?cDhaUHVVWksrOC9BY0RMOEE2anBaSWFORkFkMXQxSExjT2RVczhySmdrYUtS?=
 =?utf-8?B?UlNVRWd1ZFJsejRZTlNrK0NEVnpCVHBXZGNKdkhLdisrN1AzenNCOEdjM2Ju?=
 =?utf-8?B?MTBuTGpmSWxLZXg3S2xaWkt5WXh1VHE4SUNSWkFDZW10ZWJsb3BCRTFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVF2MFZSWDRkSStiZzRVZU1RVDlEczNiYlBuemlWMnhFbkxLeE1XYTNEd2xi?=
 =?utf-8?B?RC93YXBSM0twTmxxMnZlM0pUMXpZZFNoL25DUWxqQmtsMWQweDRlYkZyQlBG?=
 =?utf-8?B?QVZzZmFNTnpLaWtxVnQwNzd5QndIc2FVSjNlRGJEeWsxVWVsaTIzSk9nT1BS?=
 =?utf-8?B?MGVxaERQeWZNa2Fzbk92VWRrRk5GNkFWZHcwSzhBS1V2bzVFVEp2WTJDTkFH?=
 =?utf-8?B?YjRWa2lFZXgxWDhzdHJhcUdYblNGeDFrMHgzU3YrcWptVEs0NGhiWWZpcTBO?=
 =?utf-8?B?SWhyTTlWdTJwaDFYTW1BcUJ0aGo5QTFXODB5TXBGaWRtQUt4ZE5iSG1peGxl?=
 =?utf-8?B?cDkyTERVWC9tS29mY2RPd2NVWEovTHN3d2lhb2M5OVNBYnhuMkgySGF4NTN6?=
 =?utf-8?B?M3c4VUh4TEtLc0UwSjRndjg2dVpCaEpmMUxiUVVmd0hEOFNua1kvN1pwa1pR?=
 =?utf-8?B?ejl3VEUvVEg0TzY5K1Z3RDNyQmxTdUhPNldUbGVZMjZRSWtVcE9pSytJVWpu?=
 =?utf-8?B?aksxbEFwUktub2tMd2FxbSsvNGx4TytBTHNMcHNVYm1RbW1TY0MvaDl1YmFP?=
 =?utf-8?B?aGIxbTcrdStDSWE1aU94WTM3S2xTbE51di9HblhYYUI5SXNsZThKL1ZqMDJ4?=
 =?utf-8?B?bkYrbTl5K2ltTVlCWHk0WFprZUNXM25XekxMWTFwWHdoTGpZUHFRenRCQVR3?=
 =?utf-8?B?Qm5ydzFtTjhIZWZpK0VaaXVkcy9TOHkyYUxGcW4rKzZUZ1pEdmUvZEFTN2FF?=
 =?utf-8?B?Z25oTW9VbEZMNjB0MzJ1MzZzelhhQVRmVkJQMXBVRDRmQjFWbXI5QjBhcW9w?=
 =?utf-8?B?YlYvaGRWSkZYK2N2cTdzSFVnRkVHOENWb2xPdUdKandlaUZHeUZtM0gxSGJF?=
 =?utf-8?B?a1p4Mm9SdjM3TXYweVh3K08wTjB3VWk1MjFtdDVuUndScUxZS1Y0a0hGR0R4?=
 =?utf-8?B?TXZrUzdEUzVOTmNRL1h2RXEzRHV0dThSYzNVY3VWUnorRWowSEVielhOQ1FN?=
 =?utf-8?B?dUdTdEx6czJ3SjJuU3M0MnQ4Z0RObkVua09DdUpiNWRvWDNIeGFWNHRSWDZS?=
 =?utf-8?B?TERrclAxcThkbGRqaEJqanJndklIZmxzSEZ4NVBUdlRKMVFuN1BKSDNjWndL?=
 =?utf-8?B?YWZub1FuTG9qREF0cU5ib3FPaTMvRklpdnl4UHVEMXUySHpkNmF2eTBleHhP?=
 =?utf-8?B?UGNYR2JqcjMrNnphRGFiWUxEWitiQ0FjMm5UQktQRVNQcEpGaDhubVN6WnpN?=
 =?utf-8?B?bVF1ZzlzdjdGeUMwNE1sNHRvSEc2S0xVdXBnQ1FOKy9JR0J1dGF1MHpkWFd5?=
 =?utf-8?B?a21ndVJOd2hQcmt0RG5jWWZHK1UvR1JXSFcxcGU0TkllcUQrZ3hjNUNtcDA2?=
 =?utf-8?B?bUJTOHRTVEpGSDVzZU9zTzhxWWplZjFUMzhFSG5xamRSaWZvZVhvT2ZQOWU4?=
 =?utf-8?B?Y3ZpczBOdnpFa29WbTRIRldXUE1KVGIxTlpkZE5Sd09mU3dsdC96K09GOTRE?=
 =?utf-8?B?SS9UQ1grS0FpTG5lL3BHcHBJcFlOMUx4bnRNRFY1VDN4SDlMcXIyV1VsYUcz?=
 =?utf-8?B?MW9Va0VNME5OV2oyRWtvaVk0K1RSM2NDWWVpakF1aHNYUlRLU0lYWXNneFlT?=
 =?utf-8?B?bnVNQ3A1SnJ4M2FXUGtJNUJZdjVhY3ZSUFB0TW5jUk5wR3VwMGRLbS81QkZu?=
 =?utf-8?B?akljWUY1YjV0SEN3QytZSUd3a2N6OVpmKzJBWUhHaEJBR0Zuai84MlJMMjB4?=
 =?utf-8?B?YnNkOUtIcTRpeXFudW5ia1pRcEdtbmtDQmYyMlpheHFpTzN0Z1FLRUlXSnpv?=
 =?utf-8?B?cVMwb0RFcisvNGhPWVhpU0xveGNqdEU1VmE3VXZRZEVHWFg4RURTWFl5ODJl?=
 =?utf-8?B?Sng4SWZZL2NtYkRkVGhFN1MzSy83ZkVrSWxER2QrQVBPZWp0c0M3c01NOVpK?=
 =?utf-8?B?c2VveUJQSGhVQXNocVlwVG1INGIvRHZUcnlsVjJJSjVXMy9LeTJja3B6d3VP?=
 =?utf-8?B?QnhUK1FYMTdqUWRNc2RZL0VQTDhyVTZZTnhMT2E1NTRYSWRqR0JuemlSMzlF?=
 =?utf-8?B?QXN3N3E4alRxVWVkTklNMGxnaVdPT3pNVk11VzM2a2Z6Z2NzNG1oenEyQjU0?=
 =?utf-8?Q?xIVDklA9XArh3enChYXqmoiQH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d16763-fdb9-4ac4-f588-08dcf776ec72
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:35:32.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/O4Tda/1Vhj7PChPvmTRwRpXhTPGsh0QXoTCAoWSsx50pBtGIvU3a/1V+ybAikldbTQHZLBrJAVp17YIly2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782

On 10/28/2024 12:20, Mark Pearson wrote:
> Thanks Mario,
> 
> On Mon, Oct 28, 2024, at 10:10 AM, Mario Limonciello wrote:
>> On 10/28/2024 06:01, Mark Pearson wrote:
>>> Hi Mario,
>>>
>>> On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
>>>> Multiple drivers may attempt to register platform profile handlers,
>>>> but only one may be registered and the behavior is non-deterministic
>>>> for which one wins.  It's mostly controlled by probing order.
>>>>
>>>> This can be problematic if one driver changes CPU settings and another
>>>> driver notifies the EC for changing fan curves.
>>>>
>>>> Modify the ACPI platform profile handler to let multiple drivers
>>>> register platform profile handlers and abstract this detail from userspace.
>>>>
>>>>   From userspace perspective the user will see profiles available across
>>>> both drivers.  However to avoid chaos only allow changing to profiles
>>>> that are common in both drivers.
>>>>
>>>> If any problems occur when changing profiles for any driver, then revert
>>>> back to the previous profile.
>>>>
>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
>>>>    1 file changed, 117 insertions(+), 86 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>>> index 091ca6941a925..915e3c49f0b5f 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -9,7 +9,6 @@
>>>>    #include <linux/platform_profile.h>
>>>>    #include <linux/sysfs.h>
>>>>
>>>> -static struct platform_profile_handler *cur_profile;
>>>>    static LIST_HEAD(platform_profile_handler_list);
>>>>    static DEFINE_MUTEX(profile_lock);
>>>>
>>>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct
>>>> device *dev,
>>>>    					struct device_attribute *attr,
>>>>    					char *buf)
>>>>    {
>>>> +	struct platform_profile_handler *handler;
>>>> +	unsigned long seen = 0;
>>>>    	int len = 0;
>>>> -	int err, i;
>>>> -
>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>> -	if (!cur_profile) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -ENODEV;
>>>> +	int i;
>>>> +
>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
>>>> +				if (seen & BIT(i))
>>>> +					continue;
>>>> +				if (len == 0)
>>>> +					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>> +				else
>>>> +					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>> +				seen |= BIT(i);
>>>> +			}
>>>> +		}
>>>>    	}
>>>>
>>>> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
>>>> -		if (len == 0)
>>>> -			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>> -		else
>>>> -			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>> -	}
>>>>    	len += sysfs_emit_at(buf, len, "\n");
>>>> -	mutex_unlock(&profile_lock);
>>>>    	return len;
>>>>    }
>>>>
>>>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
>>>>    					char *buf)
>>>>    {
>>>>    	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>>>> +	struct platform_profile_handler *handler;
>>>>    	int err;
>>>>
>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>>
>>>> -	if (!cur_profile) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -ENODEV;
>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>> +		if (!platform_profile_is_registered())
>>>> +			return -ENODEV;
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +			err = handler->profile_get(handler, &profile);
>>>> +			if (err)
>>>> +				return err;
>>>> +		}
>>>>    	}
>>>>
>>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>>> -	mutex_unlock(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>>    	/* Check that profile is valid index */
>>>>    	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>>>>    		return -EIO;
>>>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
>>>>    			    struct device_attribute *attr,
>>>>    			    const char *buf, size_t count)
>>>>    {
>>>> +	struct platform_profile_handler *handler;
>>>> +	enum platform_profile_option profile;
>>>>    	int err, i;
>>>>
>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>> -	if (!cur_profile) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>>    	/* Scan for a matching profile */
>>>>    	i = sysfs_match_string(profile_names, buf);
>>>>    	if (i < 0) {
>>>> -		mutex_unlock(&profile_lock);
>>>>    		return -EINVAL;
>>>>    	}
>>>>
>>>> -	/* Check that platform supports this profile choice */
>>>> -	if (!test_bit(i, cur_profile->choices)) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -EOPNOTSUPP;
>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>> +		if (!platform_profile_is_registered())
>>>> +			return -ENODEV;
>>>> +
>>>> +		/* Check that all handlers support this profile choice */
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +			if (!test_bit(i, handler->choices))
>>>> +				return -EOPNOTSUPP;
>>>> +
>>>> +			/* save the profile so that it can be reverted if necessary */
>>>> +			err = handler->profile_get(handler, &profile);
>>>> +			if (err)
>>>> +				return err;
>>>> +		}
>>>> +
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +			err = handler->profile_set(handler, i);
>>>> +			if (err) {
>>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +		if (err) {
>>>> +			list_for_each_entry_continue_reverse(handler,
>>>> &platform_profile_handler_list, list) {
>>>> +				if (handler->profile_set(handler, profile))
>>>> +					pr_err("Failed to revert profile for handler %s\n",
>>>> handler->name);
>>>> +			}
>>>> +			return err;
>>>> +		}
>>>>    	}
>>>>
>>>> -	err = cur_profile->profile_set(cur_profile, i);
>>>> -	if (!err)
>>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>> -
>>>> -	mutex_unlock(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>    	return count;
>>>>    }
>>>>
>>>> @@ -140,7 +148,8 @@ static const struct attribute_group
>>>> platform_profile_group = {
>>>>
>>>>    void platform_profile_notify(void)
>>>>    {
>>>> -	if (!cur_profile)
>>>> +	guard(mutex)(&profile_lock);
>>>> +	if (!platform_profile_is_registered())
>>>>    		return;
>>>>    	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>    }
>>>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>>>
>>>>    int platform_profile_cycle(void)
>>>>    {
>>>> +	struct platform_profile_handler *handler;
>>>>    	enum platform_profile_option profile;
>>>> -	enum platform_profile_option next;
>>>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>>> +	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>>>>    	int err;
>>>>
>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>> -	if (!cur_profile) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>>> -	if (err) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return err;
>>>> -	}
>>>> -
>>>> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
>>>> -				  profile + 1);
>>>> -
>>>> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -EINVAL;
>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>> +		/* first pass, make sure all handlers agree on the definition of
>>>> "next" profile */
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +
>>>> +			err = handler->profile_get(handler, &profile);
>>>> +			if (err)
>>>> +				return err;
>>>> +
>>>> +			if (next == PLATFORM_PROFILE_LAST)
>>>> +				next = find_next_bit_wrap(handler->choices,
>>>> +							  PLATFORM_PROFILE_LAST,
>>>> +							  profile + 1);
>>>> +			else
>>>> +				next2 = find_next_bit_wrap(handler->choices,
>>>> +							   PLATFORM_PROFILE_LAST,
>>>> +							   profile + 1);
>>>> +
>>>> +			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>>>> +				return -EINVAL;
>>>> +
>>>> +			if (next2 == PLATFORM_PROFILE_LAST)
>>>> +				continue;
>>>> +
>>>> +			if (next != next2) {
>>>> +				pr_warn("Next profile to cycle to is ambiguous between
>>>> platform_profile handlers\n");
>>>> +				return -EINVAL;
>>>> +			}
>>>> +			next = next2;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * Second pass: apply "next" to each handler
>>>> +		 * If any failures occur unwind and revert all back to the original
>>>> profile
>>>> +		 */
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>> +			err = handler->profile_set(handler, next);
>>>> +			if (err) {
>>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +		if (err) {
>>>> +			list_for_each_entry_continue_reverse(handler,
>>>> &platform_profile_handler_list, list) {
>>>> +				err = handler->profile_set(handler, profile);
>>>> +				if (err)
>>>> +					pr_err("Failed to revert profile for handler %s\n",
>>>> handler->name);
>>>> +			}
>>>> +		}
>>>>    	}
>>>>
>>>> -	err = cur_profile->profile_set(cur_profile, next);
>>>> -	mutex_unlock(&profile_lock);
>>>> -
>>>> -	if (!err)
>>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>
>>>> -	return err;
>>>> +	return 0;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>>
>>>> @@ -190,21 +224,19 @@ int platform_profile_register(struct
>>>> platform_profile_handler *pprof)
>>>>    	int err;
>>>>
>>>>    	guard(mutex)(&profile_lock);
>>>> -	/* We can only have one active profile */
>>>> -	if (cur_profile)
>>>> -		return -EEXIST;
>>>>
>>>>    	/* Sanity check the profile handler field are set */
>>>>    	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>>>    		!pprof->profile_set || !pprof->profile_get)
>>>>    		return -EINVAL;
>>>>
>>>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>> -	if (err)
>>>> -		return err;
>>>> +	if (!platform_profile_is_registered()) {
>>>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>> +		if (err)
>>>> +			return err;
>>>> +	}
>>>>    	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>>>
>>>> -	cur_profile = pprof;
>>>>    	return 0;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(platform_profile_register);
>>>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct
>>>> platform_profile_handler *pprof)
>>>>
>>>>    	list_del(&pprof->list);
>>>>
>>>> -	cur_profile = NULL;
>>>>    	if (!platform_profile_is_registered())
>>>>    		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>>>
>>>> -- 
>>>> 2.43.0
>>>
>>> I'm still going thru the code changes - but I'm a bit unsure on the implementation itself.
>>
>> FYI, I split it up in v2 to make each chunk and intent behind it more
>> manageable to review instead of patch 7 being "so" big.
>>
>> V2 covers some of the points below as well based on some feedback from
>> Hans and Armin.
>>
> 
> Ack - sorry for that, on PTO this week/last week and not checking email very often. Saw the v2 after I sent the comments on v1 (my inbox is a little bit out of control right now).
> I've just started looking thru that - let me know if better to move that conversation there
> 
>>>
>>> I'd expect that one of the advantages of having different profile handlers register is that you could support extra & new profiles that might be wanted. For example the recent discussion of the AMD handler providing better tools to tweak advanced system settings for gaming etc. Won't this approach limit that? You'll only be able to have common settings.
>>
>> Well that RFC it turns out won't really be scalable because SPS is done
>> differently in AMD Strix and newer.  I haven't revisited it yet.
>>
>> But yes this approach would conceptually limit that idea because common
>> settings are all that is presented.
>>
>>>
>>> I find having a common profile and two different handlers a bit tricky on how to handle. My concern is it can easily lead to conflict in settings.
>>> If two handlers are doing different operations to provide the same effect - then neither handler is (probably) providing what they think is required. With your CPU vs EC example, the EC will often set CPU clock thresholds and the CPU profile handler will be changing that. If this is done I think it should be explicit to the user (admittedly I'm doing this with my Lenovo hat on - but we certify our platforms with our EC profile handler)
>>>
>>> I could see providing two separate handlers. e.g. balanced-A and balanced-B (for driver-A and driver-B) and the user maybe choosing which one they want (or both - though the user interface for that is definitely tricky)
>>> But choosing one option for two different drivers seems confusing and with unknown side-effects. I appreciate it's complicated by your example wanting to add CPU and EC - I know how much work you've been doing on the AMD CPU front which benefits all systems.
>>>
>>
>> Thinking through your comments I guess another way to approach this
>> would be "per-driver" sysfs knobs.  Here's my thought.
>>
>> 1) /sys/firmware/acpi/platform_profile_choices would contain only things
>> that are common and if there is something NOT common then also the
>> string "custom".
>>
>> 2) /sys/firmware/acpi/platform_profile would accept writes for
>> everything in platform profile choices except "custom".
>>
>> 3) Each driver handler would also export it's own sysfs files to
>> represent the driver state.
>>
>> 3) If the user changed the main knob at
>> /sys/firmware/acpi/platform_profile then it would change all driver
>> handlers.
>>
>> 4) If the user changed sysfs for any driver individually then the main
>> knob /sys/firmware/acpi/platform_profile would export "custom".
> 
> I need to think about it a bit more - I still have some concerns about two drivers doing the same thing. In some cases they can complement each other nicely, but in other cases they will treat on each others toes.
> 
> Just to throw another idea on the pile:
> 
>   - If only one profile then it can have low-power, balanced, performance as currently
>   - If two or more profiles, belonging as an example to driverA and driverB, their profile names become balanced-driverA and balanced-driverB. You could choose specifically if you wanted to activate one of them by using the driver name
>   - Each driver would have a priority. I'm biased here, but a vendor platform driver would have priority 1, a CPU vendor driver priority 2, etc. This would be used to determine which driver version would be used for the cases where multiple options are present and user chooses, for example, just balanced. If two drivers of the same priority compete then first driver loaded wins.
> 
> So as an example: if we have the case where we have thinkpad_acpi (priority 1) and amd (priority 2) profile drivers offering all three profiles then:
> 
> /sys/blah/platform_profile_choices would offer:
> lower-power, balanced, performance, low-power-thinkpad_acpi, balanced-thinkpad_acpi, performance-thinkpad_acpi, low-power-amd, balanced-amd, performance-amd.
> 
> If the user chooses balanced - it would activate the balanced-thinkpad_acpi profile as it has the higher priority.
> The user could then also activate balanced-amd separately if they choose. Multi balanced profiles are OK.
> 
> Initially this would all be from command line, but I'm sure some nice user space GUI can be done to allow you to choose which profiles are available and active/in-active.
> 
> Maybe also add an option under platform-profiles to have an "enable all matching profiles" to override the priority implementation? In this case choosing balanced would enable all balanced profiles available (in priority order?)
> 
> Would that work for the ASUS case or not?

At least for the ASUS case "today" I think "priority" could work, but 
what happens if one day ASUS prefers to use amd-pmf instead of the 
custom WMI stuff for some systems?  IMO you don't want to have it set in 
stone for priorities.

I do worry that generally though users won't know what they want if 
there is a "balanced", "balanced-vendor" and "balanced-cpu".

And I don't think we can use the same interface to select multiple at 
once.  I think if we're to have multiple handlers exposed and allow 
different options then it needs to be a class interface (or something 
similar).

> 
>>
>> Hans what do you think?
>>
> 
>>> Another concern - would this mean that another driver could limit the options available? For instance if someone wrote a new 'mega-turbo' only profile driver and it loaded - it would then mean no profiles were available for anything as no profiles matched?
>>
>> Yes.  I don't think it's a problem in practice right now (as we only
>> just recently have two drivers vying for this position), but it /could/
>> be something that happens.
>>
> 
> I'd certainly like to leave the window open so that there could be, for instance, a 'gaming' profile option that does some high-performance mode with maybe power shifting towards the GPU and some other graphics only tuning things?
> I wouldn't like to shut down the ability to have options for things like that.
> 

It comes down to how much of a catch all this knob needs to be in the 
kernel.  If you put too much into the single knob it doesn't become 
useful anymore generically.

At least for AMD APU + AMD dGPU designs there already exists a bias knob 
that lets you control the power share.

https://docs.kernel.org/gpu/amdgpu/driver-misc.html#gpu-smartshift-information

Similarly you can manually adjust clocks and performance profiles for 
GPU from standard files:

https://docs.kernel.org/gpu/amdgpu/thermal.html#gpu-sysfs-power-state-interfaces

So my gut says this idea of gaming mode should be stuck to userspace. 
There is already such a project for that:

https://github.com/FeralInteractive/gamemode

>>>
>>> Let me know if I've misunderstood the architecture. I didn't fully get how the ASUS and Framework platforms were impacted in the intro I'm afraid.
>>>
>>> Thanks!
>>> Mark
>>
>> Framework isn't affected, it was just showing that there are platforms
>> that use the BIOS/EC notification concept and not just SPS values that
>> the driver programs so it can't "go away" to solve this issue.
>>
>> ASUS is the only thing affected right now.


