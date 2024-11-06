Return-Path: <linux-acpi+bounces-9336-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEF9BDAFA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 02:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF20B20EE0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDF176AC8;
	Wed,  6 Nov 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jkd6e/3O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24413A26F;
	Wed,  6 Nov 2024 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855501; cv=fail; b=RhKrdOEyAThklH+twfOWb3gH9BttD3XZ65Gf/Jr4xxZruQ39ru/XndF97GydJE+zEElUpFxB+xAM3nMgtPmDfSW1yr8C+Ei7Tz655UnmwzgDHz7JnALpzxTTJ2n/r7PqV2KNCZy+DF4gxBnUhtC/gf1REo+ax9PJw4Lnzikvwqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855501; c=relaxed/simple;
	bh=kmp9RnkXSRFcvmUXc/fdCT4GYQmdqRoCI89a8K1798o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuBzoXiG3KB1WouQnuoPH2OnqLQpj8oFa51BM3r1SPon5bSDgk8BcByZXWvitPFxxCh+Hz9ILUXJoKprSHLMUwVnTveDQ4Vpk++JKFscwHGe3Lm1ciSf+cQUUpkd2rj9PtpADPQfkXLEnFY/HIoLIrIc+tMlccTWJUM2eNdH5O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jkd6e/3O; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTTCZVaUMb8MHxmr50A6UnVcFVMqKrsXS22rZimTeQSY4L6ypnNjKQWCjUvJ3NtOniKgpB12McXkeSkew6b0FQ9XbF++Zr8OTb2cJRjtBb/3N24YEwu0KWzmmASe2Z42BUYTtCwPozcWMUfkilqBBL/FL7H2Szy8kzZgrm9zoxyiqPcqumCn8KLjQKIAXt+WWiyq69Y+Qvs47kafgzNRYSoRt3ftZSpBhQ0slj7x4sj8wceU4KIIQ3+7PvEqeiWqSrqYKYHCiSERYtUrIo4I/3aHbMiuka5aMIN8j7SL16zgOgkLtEPtjz/kB0l8p3Nc32druISwGMHC4Ujc0m7JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lreoNL20EmQIyDOKgfeIlnNvIy22vivJlYCErBGXBXI=;
 b=XJWI7IwTQ4jqYFM6ajdFMyTzZj6Ei+EY2si3kNCGNSphXV/Cp8uOqg/QChDgQADsBksv+TW17ROwG0V6y/2nMdvLSVE/x5f0rPA/ZcdXyF8oqSNVN0q8PBwGjEEwmh5DUhsfv1Hgjvl4enpmozAFlJjCetNQWzHhKu9u3erwWLo298J2micxD3uLABQf4N6Hjyzn5330irQ642+uuz9rE1rH7pgZmO+w9zdUwNBFwUxWqn3RCHvH6mZmPwe9XqtZyLsIrRVURMkFflPt2tJLffc98YPFB85ULgKLxmuL3NiI+3witlgAISIN8NeoIav4IoQ5I73w3mJmEQvGsvxgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lreoNL20EmQIyDOKgfeIlnNvIy22vivJlYCErBGXBXI=;
 b=Jkd6e/3OOgiGtXbmFub8DOh+dsPiSBta/YN8cjOkWxNccTuNDyC0BJRpGmhNiftNZ4iqdCGu/154XBlswBAUoAK7hIrztlWy4kv34xfmoW58Y87U1EomhovJDoNOpczqMFOITrmspPznAytbf1zLVIxtA+rryl7WUrTllhQ1MyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 01:11:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 01:11:36 +0000
Message-ID: <4462f1d4-4f10-493c-b7ba-8f8d618a8fd7@amd.com>
Date: Tue, 5 Nov 2024 19:11:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/20] Add support for binding ACPI platform profile to
 multiple drivers
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <26a494ee-d929-4aee-9c2e-d184e0efb842@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <26a494ee-d929-4aee-9c2e-d184e0efb842@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3ddc68-91ea-4e1d-2c9a-08dcfdfff5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk1OMk01ZVIwN2s0M1BFaEpLWTlQd0pHaG1EMUVTVnhXYS9Ga0YrZkE1V0dN?=
 =?utf-8?B?aGxqOXRPZUtmTFZIeXRaZzFWTkFIZ2xjWnhRWk8vNUFTdTZjbDcxeEh1ZGps?=
 =?utf-8?B?cHU3RnJ6VElEMk03aU4vaVpZemxETlhaZm1aUVBpVDR4KzFQS1pmMTZuR1hh?=
 =?utf-8?B?WExPcFBuWFdidjdoVDk0eG1PMWVpQUIyWnVHWGJKWFArbXNDanNGYkRPb3dT?=
 =?utf-8?B?eVU5K251eC9LczVSQ3BMWG5tTXljaVBEOHVQR2l5T2xaY3pVQUlaL2w4Qk5r?=
 =?utf-8?B?UXZZclhiL2NUcHVjNERJKzFkV1lUc1dQWlFjWGxWWWFET1g2b0pLd0ViU0xL?=
 =?utf-8?B?dkNHOU9iOU9QLzJLR2dhU09kWkMyOHJLOHBReDc1N3J4SVhRc3Y5Ymw5VU9F?=
 =?utf-8?B?SVhOMFlxWlExTTdaRW1RYk5uWXhMZCswSklQWkF2eWJSaDh2VzZlUTRtK2R2?=
 =?utf-8?B?ZTNmNzRYd2ZhOHAxSXluOXZwVXRHZFJNcExwYUp4dlkvbkFLcC9YWTN5bmZM?=
 =?utf-8?B?NFNWV1lSOVBNWXRhemdwNWRmMzd4ekY3cGh4Q3AyQnlnWVlVVTJoQ1Z3UmpI?=
 =?utf-8?B?T3ZUTnZuODlDTXFKNDVZdGdDMklWYzRqQXZEM1hxMTVOT3JCb0NvbHdtWDJz?=
 =?utf-8?B?U2NyQ0d3eTBaREE5RTdFdTFHMjRkQXQ4LzhmSS91UHQzU1d3NVg1akp2c1Qv?=
 =?utf-8?B?UEovTnBmZFhGVnJBdmFmUnRHemJyb0Yvd3ZJZTZMenQ3MjRnQllBRWlZd1Z3?=
 =?utf-8?B?TTBDanhMYkJNZWRyNzNPc0VMWWw3dzVRNytTUVRodTdoNEJDRHFmU1k2ZkRk?=
 =?utf-8?B?a0ViNFBTcTdHNjhxYTdBK2N2eDBVSU5uR0c1Vm9IeDVQNnBCd28zZCswcENH?=
 =?utf-8?B?eStpNkl4SWdRMUllUHRudzRrdTN5SmZGMWRVSTd1aVVkODI0T2srcmUya2hQ?=
 =?utf-8?B?Y2hXU1ljSnpMWkZLV1ZZY05NVE9wWlR0T05CdEo0aXFBcy9FbW1rY2YvQWFE?=
 =?utf-8?B?aFdGS1FJVjR4b3ZRLzhWL0RRL0s3UHUxQ3JYdHJ6R1BWWm1UdjdCdGV5bzUv?=
 =?utf-8?B?NjlWRW43anBzemgwUlhOMG0yTy9IUUwwYU5YVDNZRjJnL1RDcmoxckZFWW4w?=
 =?utf-8?B?K0pzVEwzM0w5QlZQYVkydnJvZEUyNDFuTVczbzVadFBwdW5UWG9oUWZwbDZX?=
 =?utf-8?B?d01jWHFFT3hzUUtoQm9sMGRyWHlsSmJ5S3F4Vkk5cXl2eFRSNjdCRVlMRkpN?=
 =?utf-8?B?RXFWazZHYXFiUTZvTSs0Qys1MXZRZXlDeklFSnY5WnVwb2UxdEpFY09Dc1E5?=
 =?utf-8?B?cE9JbkVaTnVyMDNBZzMvUXRNcEhlb01OaDIwaCswbWFKRjBkQjQ5c08zT1Ey?=
 =?utf-8?B?WnpyK2NqOEZZdG5OOFMvYitWVFJJQWdZZjRzWXlDNEVIb3FGZzJtaklYNU12?=
 =?utf-8?B?K3VsSkx1MU9venNEQ3BtV0psTE8vaGRrTEFXYkhKUzd6dUExdTlpT3BkdHpU?=
 =?utf-8?B?bThiTkFTblFoOGxkMnhmSXNjQWNZZGZ3ek50cTI0cTQrVitXdTM2WWN0Y0R1?=
 =?utf-8?B?ZStJeUdrUlpjM1NvNTIwb1A3YTZPc3lMRW1XSnA3bEZ3RE85OWI3VzVHQUd6?=
 =?utf-8?B?eGo3NFRBZVF3VmZscGIyTFVMUjZTUVhzemd1SlJjVXVhK2VRL2huRW1hL1hP?=
 =?utf-8?B?R2M2Q3VTbEdUazlTUXcrUTliWHc4aHBpTWoxKzNBL0Y4OGkzQ2JZS0Z4S0ZQ?=
 =?utf-8?Q?Owa4vKPa5XTzVTJ7FGdWdfiQ6C0hpEphN7L4Ajm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGk5SER3anhsYkZ3ZWM4N2J2TFRlbUF5TjRKSkVUcGxCMi8wYlhuWEE3Y2RD?=
 =?utf-8?B?T0EyL09PajB2SjhFczh0a2k4MlNxUlhmelIydGhrMVlzY1k4b0g2T3YzZTRl?=
 =?utf-8?B?aDB6T1I1Y0hGMklKOE5mQmtndG5xYXV2d3RUSlJ2emVtQ3Z2dVlTMHBiUEUy?=
 =?utf-8?B?bnM5U2pVOXlsL3lOQnRCZzM3VFQrT29oTitCb0xLN3NKV0g0d1owUDJlQ00v?=
 =?utf-8?B?Q3oyNitSRUU0aXplaGxmTmJtaWtVRjJzenBPRVgvbEgxa3pPcjdYcVJZaGFG?=
 =?utf-8?B?TTEyM0pYYlNQait1SGFyZ1FaYkdZcWNOT3IwaENvTllUbWlOTDI4UGJOOW43?=
 =?utf-8?B?WWN4NkFpcUVvT2ZMNm9KREptL255c1NMWldURk5OL3FsSXZUR2dzTDJLWTNm?=
 =?utf-8?B?K2FTZU9iL1Z5Sll5NURQblNoNG0xRkhZcGNKaThNVHJUM3d3M0VGUE94ZmJX?=
 =?utf-8?B?b2MrRThEbXU4Wld6RHBQRnVWVTIvUFRaQ3ZQWUkrK1QxWGsxK0JVbU53VXV5?=
 =?utf-8?B?bFo2TEk4THJ2SHhHWjdGQzZMOFRtODhOMDlqTXQ5WGZJWTMzSTc3UStxSkNw?=
 =?utf-8?B?SWMyckdYK3pXV0VkVkt3cXV1cjg5a2dlZzNCNGtUYU02QVRiR29UbUhpNUdT?=
 =?utf-8?B?NUdIVjN4UjVXM2VJdktualVhTGFWK3dKZDg1UElQemZuc2NBQmdKeVdINmU2?=
 =?utf-8?B?b2k4ajJJNE1OeVJyYzdRNFlPd0dyd3JjZnFoNnJhelFxRExXTzcwdUtPTXNT?=
 =?utf-8?B?MENSTFM0YXFOSEYyNzJjV2JtT0JObGRTUjVJdDh6QVJqTlJjaW56V2NKeGZS?=
 =?utf-8?B?L1dwaUJCWlhjRUxOampNYTVwNXJpL3VGUFdDSCtyVUZnc2FJdldWZzJvVmo4?=
 =?utf-8?B?K0Y3SFN6WkpOMUNSdzdmSVhQZjl3cjVuUW1nOFZwWWpQZk01SFd1dlV2NFZz?=
 =?utf-8?B?ZDR0dk1ZN1RvUXVSbWRVN1VENDVXdDNiZk91OGExNFVVeGtZRkx6QlhxcWNx?=
 =?utf-8?B?aHQyR0hUQ2xWallQeDVyR2M4L21wdm92SHo2Y3Z2d3I5NG5ibzkySUU1b3F2?=
 =?utf-8?B?SVNiem1MTXpSY0VpcDJoRWxuaTdlN3BtdzNEcUozVEJOZUxNZE4xOEVrYWpk?=
 =?utf-8?B?STRsd3FyOHN5TU94MlE4TWZBajRwVElselQ3ckN3TkpOckNRWURlb1BYcUhO?=
 =?utf-8?B?cjE3K1R2Ky83SExhc05SRmR2TTNPSkN2YkVvSHI1d0JQVXQrb2diNnJpcWE3?=
 =?utf-8?B?MzV2cHdpY01RMGpkRWdjVE9UQ0pHZHY2QkdmOHlQd05BU0FoUGttc2lTZWFi?=
 =?utf-8?B?dElYNTd0b2JvMWF6MFp1OGtkZFFnZGVla1J5RkN0YjlkNkV4bVZQeWNDRHRW?=
 =?utf-8?B?UjZ0KzJZY2FweEZoeUFiU3ZZL3BvbWJuWGo1c0FGYmRmVEJ1S0hxTmZ3K2lJ?=
 =?utf-8?B?d3RxbzBLUFJiVzA5ZmNuNmtCRnROckN2SGtWV0tZbmJnSFIvY1hYd2RjOGZk?=
 =?utf-8?B?anVNMXdxNEJhb3BrUTdzNmJyVGlsWHhoWEJLWHdPbS85TGVoR2V1L3hPTzVh?=
 =?utf-8?B?YkpiUlY2VGpDdmE2QW02U1hQM2xrRUVXbVovbXJxaG9JQ1VVSXhraE9sMjZq?=
 =?utf-8?B?L1l3T0tMbWh2b2szU0tvbnRtR1FQeFh6elN1aHRQenR0THZ6SEtiTHBaOUpR?=
 =?utf-8?B?REh6RTdjWExnalUxV3NiY0hCa0Mvb3FvdjlTNTNnVHQzNzRQTkp5NHFKM1ZI?=
 =?utf-8?B?R3JvRjA5L0N4VXV4VWJBMEhpODZoR2ZqKzR2ZUcrZ0lhWVFUSEpUNG5NZFVh?=
 =?utf-8?B?eEZzejNWLzRXa2g4S2R5TTQ1Q1B0YmVad0dhZkFtWHpPQkJ2YTNUdk5xM3NK?=
 =?utf-8?B?TVF2azhVWEowbFpkZkpFVlNkMVRQRGhIdnczUTFWVTM3WUxzeDBPOERZYjg1?=
 =?utf-8?B?VmhpWWp6NDFFTFFvSXprTDB2TE14ZkpRNlZVOHVIcjF2Q1Y3Um5nSTAyUnFm?=
 =?utf-8?B?S1RJbGdjRGxXaXVnM1dibHpKbzRsOGpmRU8zS0EvQm9YV3FuVEhPOEFHVnZj?=
 =?utf-8?B?c1dBaVl3VEZDbHQ5dURXcXdwUHdPWHFWTml4dkRmd2pjT3NsRXBUTVoveW5x?=
 =?utf-8?Q?GkPy9b7/3SORa4ru0Vw8yapkZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ddc68-91ea-4e1d-2c9a-08dcfdfff5e9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 01:11:36.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg1bl9xOA6UNl2zsbu95PEyG2ELjYB3gIds65hoVAriIlh80uw6UvkL0yaL2e4WnHULEDHBy3m1juIDtuorcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On 11/5/2024 16:47, Mark Pearson wrote:
> Hi Mario,
> 
> On Tue, Nov 5, 2024, at 10:32 AM, Mario Limonciello wrote:
>> Currently there are a number of ASUS products on the market that happen to
>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
>> profile provided by asus-wmi.
>>
>> The ACPI platform profile support created by amd-pmf on these ASUS
>> products is "Function 9" which is specifically for "BIOS or EC
>> notification" of power slider position. This feature is actively used
>> by some designs such as Framework 13 and Framework 16.
>>
>> On these ASUS designs we keep on quirking more and more of them to turn
>> off this notification so that asus-wmi can bind.
>>
>> This however isn't how Windows works.  "Multiple" things are notified for
>> the power slider position. This series adjusts Linux to behave similarly.
>>
>> Multiple drivers can now register an ACPI platform profile and will react
>> to set requests.
>>
>> To avoid chaos, only positions that are common to both drivers are
>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>> is used.
>>
>> This series also adds a new concept of a "custom" profile.  This allows
>> userspace to discover that there are multiple driver handlers that are
>> configured differently.
>>
>> This series also allows dropping all of the PMF quirks from amd-pmf.
>>
>> v4:
>>   * Drop the list; iterate classes
>>   * Drop patches that didn't make sense without list
>>   * Cover alienware-wmi as well (recently merged to platform-x86/for-next)
>>   * Drop requirement for balanced
>>   * Rename platform-profile class members to 'profile', 'options', 'name'
>>   * Drop the name in /sys/class/platform-profile and just use ida value.
>>     IE platform-profile-0
>>
>> Mario Limonciello (20):
>>    ACPI: platform-profile: Add a name member to handlers
>>    platform/x86/dell: dell-pc: Create platform device
>>    ACPI: platform_profile: Add device pointer into platform profile
>>      handler
>>    ACPI: platform_profile: Add platform handler argument to
>>      platform_profile_remove()
>>    ACPI: platform_profile: Move sanity check out of the mutex
>>    ACPI: platform_profile: Move matching string for new profile out of
>>      mutex
>>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>>    ACPI: platform_profile: Use `scoped_cond_guard`
>>    ACPI: platform_profile: Create class for ACPI platform profile
>>    ACPI: platform_profile: Add name attribute to class interface
>>    ACPI: platform_profile: Add choices attribute for class interface
>>    ACPI: platform_profile: Add profile attribute for class interface
>>    ACPI: platform_profile: Notify change events on register and
>>      unregister
>>    ACPI: platform_profile: Only show profiles common for all handlers
>>    ACPI: platform_profile: Add concept of a "custom" profile
>>    ACPI: platform_profile: Make sure all profile handlers agree on
>>      profile
>>    ACPI: platform_profile: Check all profile handler to calculate next
>>    ACPI: platform_profile: Allow multiple handlers
>>    platform/x86/amd: pmf: Drop all quirks
>>    Documentation: Add documentation about class interface for platform
>>      profiles
>>
>>   .../userspace-api/sysfs-platform_profile.rst  |  28 ++
>>   drivers/acpi/platform_profile.c               | 446 ++++++++++++++----
>>   .../surface/surface_platform_profile.c        |   8 +-
>>   drivers/platform/x86/acer-wmi.c               |  10 +-
>>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>>   drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>>   drivers/platform/x86/asus-wmi.c               |   6 +-
>>   drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>>   drivers/platform/x86/dell/dell-pc.c           |  39 +-
>>   drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>>   drivers/platform/x86/ideapad-laptop.c         |   4 +-
>>   .../platform/x86/inspur_platform_profile.c    |   7 +-
>>   drivers/platform/x86/thinkpad_acpi.c          |   4 +-
>>   include/linux/platform_profile.h              |   7 +-
>>   17 files changed, 456 insertions(+), 195 deletions(-)
>>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>
>>
>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>> -- 
>> 2.43.0
> 
> For the series - I tried it out on my T14s G6 AMD, and it all looks to be working nicely and as expected.
> The thinkpad-acpi and amd-pmf classes show up. I can tweak them individually and 'custom' shows up under firmware/acpi/platform_profile.
> I tried various combo's and didn't see any issues.
> If you have any recommendations of things to try let me know.
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> Mark

Thanks for testing!  The fact that Lenovo and ASUS are both doing this 
with recent laptops makes it all the stronger of a case to do it rather 
than let them race for who gets the coveted platform profile slot.

If you've already tried mixing and matching combinations that's all I 
was going to suggest.

I'll wait for Armin's review and then I'll respin with the tags and 
small things you and Ilpo found.

BTW if I missed any important feedback of yours from v3 please let me 
know.  It was a lot of overhaul to switch to this way of doing things 
and a lot of it didn't make sense anymore.

