Return-Path: <linux-acpi+bounces-9423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F1F9C1138
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 22:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C2D285B59
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDC217F3D;
	Thu,  7 Nov 2024 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IVkb/W1l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725BDDBE;
	Thu,  7 Nov 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015939; cv=fail; b=Aukzya/LQUcBBnAFxlSSavQxY939vSpT8kgmLLLtaHPk1eRvlejRhtpWMidWXGEDDuUc1QCO/kAH5xzDetbBUE/iqgsme+plgVBz4Ppx9O2Uq7aX99MziI8OoMuCTsQsCdl0oTRGQLad3GvX114/uXsar1gZN9g5WFuYSvDaGWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015939; c=relaxed/simple;
	bh=NTs7L1waJXgFW7JLcvGZLWfzVvDcewepvtRwvCg990g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HMmOWSF1FXwWvSPYr6j41U/luoKGNE4YbET+WCDSVjbgy8mtsjP0T/aSl+hOjlODuztyqjHvw3MYW17OCKd0ZuF+UJHAXooIV2cXFl1XxgSNvyeJL6wLGoReJsGiHJDK6fJ/TTt38mFhexyZHRZHPMIErBHtpQw2QIfvhY1wEBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IVkb/W1l; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1nnWAIR1ZXAoJY19OB287OROMe0t33RsnNwUb0SuRg25IdxlFthoj4uBmM0aKXFIkUIZBUCuEeutSAg4qoAD6RgZorVD//lA4hX00Xu/uk5PNP0jJ6GKSaYYUA66nSGm2QO0i+wJXtqXq9oEWTgObhdLzW0CG8AGIDacxZfe4qsRsz7PIQk8S96mb+aYxKOXuLbjsIr8FArwvUUiC9M/oip/otBsmYnVb6LUAbJ8h8wXVe9ke0Xqj9m5T3PeZ3+fp1weZLHnCswWUnhaC1vr74sj1EFbXzjAYh7+ukmTonyUlgBPSJWQjSDF0qIv4KZso+dJWm5vZe4srPGvWUP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egk05qeA2KTbUAv8FvWbY4zrw6XR5LEp5nRGUXq0uOM=;
 b=qhvFsGEZ3eWs5M0J/rF8m1CWjnXAZuR17QdzPTkyj7ykY3jA2jQLzrs/ubGSy3A88ZWJzLSH2akU1Eo9RcBHqpyrTGfVAu7xxfVNCf73fsuM80UvymAXPoFih3cZkCGBgWgs8jt0Oh2lwQZG9qFqeJgCtP6h4IhsKJ+UinZSc4G30ukd1wm4EV827J/mDA6aS0D0vVepfvHDrmdv7rd0aEVIWfp90atvII/Jv4zCbmkxKHtijeXA8o6iB8GRiX9O4HJ2lppDaAA0Iz6X6VSQsIvLyvX9UKKgs8QSN9GLGG2VJOh6U60Rw1jZPvdveLK+NSMwiuke75tHcyBSZ7PXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egk05qeA2KTbUAv8FvWbY4zrw6XR5LEp5nRGUXq0uOM=;
 b=IVkb/W1l4V4T7n4+0Uso0gBhBzaZER1efgZpDCTJsK8MnIU5NxskppFaKKonpU9nEQKdMGz5Q4nFN08/0qjp7Pn4cFt5BZ9CE49OQBDEUBYjugvGx3K7L58zgULLsF3AH7/xTDgYnr4gOTSRITJ1+rgYKlet6g+wNjupFMJUo40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 21:45:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 21:45:31 +0000
Message-ID: <fde868fa-d664-42bd-b6d4-6c3f2928f1cc@amd.com>
Date: Thu, 7 Nov 2024 15:45:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Add support for binding ACPI platform profile to
 multiple drivers
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <d08d40f5-5482-4e7f-99b4-a5d9e403b828@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d08d40f5-5482-4e7f-99b4-a5d9e403b828@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:806:28::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8486ad-4ebf-47c0-11ee-08dcff7580ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2VVMysvbnF1M25WWGlwZjI3eFVuc1IvOEN2bWxLK0Y2bC9rWS9rQUlIZDF4?=
 =?utf-8?B?RUxYVXF0UUJEZC9IbmFESFpGVDNRT29pUHk1TTExZHpHY24xZ3dLeWlERjJq?=
 =?utf-8?B?bDNkSEV5azdiMEJ4elYrZndka2VqOE4xT3FaTVVNU3RZV1pWWm00L0ZMUHRL?=
 =?utf-8?B?STJIWGhhZjlyZkI0RS9HVUdQV0F4dnlZK3VQblBHWjJpc1FsenJIRWZ2eW8x?=
 =?utf-8?B?WDJaMldBd3ZxMmxJdkFINXIzdzZSKzhjSEpNSU9QczlZQWZqYVJ5dGpvTFg0?=
 =?utf-8?B?SUdVVmplOENDR0pPSWo2U1kzdVRKcVNWYjZHVTZJU0ZiZFdtQkl2TXdMejdt?=
 =?utf-8?B?T0VCbEpDRWZNT2djNnhUSkFVQUpyVU5SVGFSU2VRWEo1QnRtSlRIbWFKeVky?=
 =?utf-8?B?SmVzdkxNTFlvSFdyVVZHK2JTR1F2M1RQVHpDY2I5NkNBV3JGRkgxLzgxSlpq?=
 =?utf-8?B?aElzVzBPTHJSckZvL2pQSk1Wb1ZmM3gxenZpalVaNld5YTZJNjZKNFluc1NR?=
 =?utf-8?B?SUYzVXZJbm5lWXZaVzFFYWFhYklkSUNnMkc5RFVGamtSWGlUWTlJZ1hsMVhy?=
 =?utf-8?B?ZEw5b1hVNldvS09jYmFrdDRxUU55dE9jY0E1b1ZJNHV6RCtWRmxaL3NuYUlI?=
 =?utf-8?B?UnNjRmNrT1NrbWRvdzF4UGwrcThENW01a2xZRFFJczFqWm44V3NKbWlpbTUx?=
 =?utf-8?B?ZWhkMVRmcHVYOENSYWlBUG10eHBEbXc1NjNUd21QWjQvbVVvcVdUL3lmN0RE?=
 =?utf-8?B?UmhNZVFmODduZzd5QldDeGxsMjRGTjZxTWRQMzBaU00rVGp1OUZkb2lIeUhL?=
 =?utf-8?B?dXVsVXFXcWhaRm00TFJKbTB6ZDVvNWFObHRScmliTDYzb1R0UzJXUklEdXFa?=
 =?utf-8?B?MnlDaEZQQUs0bUU4WmhhMUVzNWFmUWlmRjZjMFMra2RJclpTeTRlOC9Fc2FQ?=
 =?utf-8?B?cDBKMmNoMFJod2tOaE9oU3UyQW1VYTZBZHcyd1h1QjJBa3k4QlJMSEo2NUVC?=
 =?utf-8?B?VFVUa2twb0M1cE9IUFJqejIrU1NlRlFLb2xGZDh5cCtKTXF4cmJKcG1aajhl?=
 =?utf-8?B?WmJVT0hsZk4zMlhrTVBjSkVKYzAwWmVuaHBHSi9idUxRKzg3WTZ1R08vOG9C?=
 =?utf-8?B?SzVqRnd1anhvUzV0YWVicFJFWWQrcjl1NFRUMGhBNUFoMkFjNGo2SFJNMzlw?=
 =?utf-8?B?UEFVTk5pYlFlSkFXaHhVQkt2RUd1L1p3ZGZ1ZnZuRURsQ1hUbnAwZmpEcUgr?=
 =?utf-8?B?OTZNbzFPYStleG1RQ1A0WHlicmJDSmpZVWpsS21iQlg2ZjNEeWdUaWYzdkpC?=
 =?utf-8?B?blkzRWxWdkM4RGV6Q0xMM3BSZ0thai9UWXppNDdmbXUraFp5Vi9lYmNFRHNj?=
 =?utf-8?B?YzhMRWQ2TzU0VTgxQ1dJbDJ5Q0ZyQmJnaVNYSUJLY3lqZEZ4a1MzNmg5clc0?=
 =?utf-8?B?a0RBRlBMSkJwSU5NdUFQZ3F1OEkyREpxbFU3Y2JtK0MweDgrZ0VteGhGYm05?=
 =?utf-8?B?Q0tsS2ZkREJub0RsNFVNbGVxd2tOdmNxdmxNL2J4anlPVUt2OTdBdEZZMHRH?=
 =?utf-8?B?ZzN1cEF3SVJBRGs3Mi9MK1dWVy9UZ0dlYng2cDZZalhJSGpnNUVNSFQzQlAz?=
 =?utf-8?B?eDNUcVk4YjF3VTVjalROS2t0MDZqVHZjNHRmajJFR3ZZWk5qcE9IcUJ4MklV?=
 =?utf-8?B?NkQ1aUg3dVFCOHpOM3FDQkhTLzB5eEsremsrQ1ZjaEptL3BRVEEvcGR1SEZo?=
 =?utf-8?Q?h5gySgRdkZD3dRVD48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2ExK21iOXdqeXZIRUdHSUFhS1d5ZkdidTZzbmlxVUphSjBIdjB4WGNwZTZa?=
 =?utf-8?B?eW1hcUV1c2ZZUFd0ZjhjQzhtbnRyRVRKeDRhZlNheDFHSHVhVmhpa3ovSzYw?=
 =?utf-8?B?aEI5RGY1VmxOL3RYMnQ2WEc4MjBQa1RnbmEva2hiL1hsZWdsT0RXVlZhTHE5?=
 =?utf-8?B?RktqckFCVVdmWURKcjZNSVJZV0FrZlRvS1ArUStTeDF0YVNQc2V3M1JRR1hK?=
 =?utf-8?B?OWxxNVVFWTRjRDhqcWwxbENvV1oyZnN3RGlseTRZMWx3STAvcG02eVFhQzNn?=
 =?utf-8?B?MzFIbmpqNFB4R2VVVStHOTRtd0E2K2VVZWRxTmczdkpQZllMZm1xME1wMjFQ?=
 =?utf-8?B?aFFqTElRb2Njcm5OdnJueDZuYk9tenk1ckxEMHA1MEorSmxST2NQU0JSaEZz?=
 =?utf-8?B?ZHhUQXJUZUhjRjQ1ektFVmkxWVBQMkh6MStkNXNBaWhrK1g2djBsOTBpTHhI?=
 =?utf-8?B?U2Rib3V5cVBiSDRGM0dEMzBiaFQvdm9tb2krM1lvcEZ0VEd6WWFDVnN5VUJR?=
 =?utf-8?B?YU9nYk1KajdmRnVxQUtsUUVyckZwSVhLakMzbXZvZWdzaCtqbXZweFMwWVgy?=
 =?utf-8?B?OHJqOTl3bVdEV254T0s3TWRWZFMwa2V3SFJieG54N3RMUVNLeGQ5NWlWRWkw?=
 =?utf-8?B?L0l5Wm1ZMmx2Z215ekZBVll0Y1AzR1VDM2dsVjhXcnd0L1RFVlJKTG9PSk9E?=
 =?utf-8?B?bkptbG4vcFFnY0ZFcW5HRUJYdS9oUHMwUXVYWWdLWXc2RHVRNy9WbjgxRFps?=
 =?utf-8?B?TkwxTENHbU9rQnJrMVEwUWg1bS9CTGtaNTcvUkRwMVFYNmdYTzE2dGpIenAz?=
 =?utf-8?B?YUNnRWtkek1lemMwQVRvV0g0WTVYU3RDdFdmR1J0Vm9hcHlncWxyRHkyM0Zs?=
 =?utf-8?B?Y3U0eE1NY2thc2dVa0hac003VFlVYTkyK25GZDNaS3NUcG1BOTZTUTFUMDZV?=
 =?utf-8?B?TGVGZmdhU1JLMmZDSUJFcFBxRnhieFk4UEIwT2VIMlRseGp0cWk5Q0FCN21v?=
 =?utf-8?B?RFlFUlcwOTg4bGFoZDZEQ1NCZ2NzSk5HUUMrVnFUbkVKTHUxeXhWOHlOTGNE?=
 =?utf-8?B?US83N0RZSGFwV3l5TzlTTk1LY203YUlOYlhTUlcwclZWaGo0RXNpcmdDZkdL?=
 =?utf-8?B?QkpnTjVqd25FejR2RGVud250dHFvMlZTYjdxSVZiVVBvbXpRRzhCWXBBT01T?=
 =?utf-8?B?Lzd4bHBJSG94ZWdaeVFXWGNlbG80TmxjaHdqYXNTNEw1ZGhnbVRKa1hSSmxC?=
 =?utf-8?B?clJoL0xCd2NIV0l4ZnpiMDl0SUZSZ1lFYTNqMi9UUXZpaHZ0VkFSdzh2ejlW?=
 =?utf-8?B?TzFkY3FJZ0FWaS8yaFEvcm4razNJWWxDemE4TDMrdmFWM0RuNUY0WmpXaXJS?=
 =?utf-8?B?UFZGRndrVE1BN1c0Zk1MemdndzRBWnk5SHYrRm05RHB2UWg3eThyM2ZaUURt?=
 =?utf-8?B?WXhKZ21PMGM0d1M1V280Sm84U2lUWjhkQ3k5V1ZBUC9lWWRzdWRLazRIbmFh?=
 =?utf-8?B?dDR3b1VGTktvUU1ES3hsRGJSRVcvRVlaYUY5OExkbVNNaVBsVGhOVGZRYUYr?=
 =?utf-8?B?b0FEdnZqelFUUlZPWnRDWXh2Y29LZzE3TndkY0RpRXBnYTJFQnkwV0FiZk5J?=
 =?utf-8?B?cE5wb1g4aU9MeWtmUU5YaEx5T1pob1hONm9RUFYzangyWUxPLy9tdFZObERF?=
 =?utf-8?B?V0lCZUU0L0ZZWlpRZ0RDNDRXQUQ2K0NBUnVjai95Nk9XN0NaaklPczlQZ0xr?=
 =?utf-8?B?bGI3TDJiNmNJbllFaWhaYkJXQXBWOStvakZFejFUNk1aYUxqc2RYVnM5NTFy?=
 =?utf-8?B?VlZYZnB1OEk1K1Nxb2hocTlXZjJlN3prTjNZckw2b0F0eVVaaUVjSHV5V3o5?=
 =?utf-8?B?TXdRYjJLcHR1dUZaUXpqOEpkN3lkdFlPQmR2ZDlLT3dPUExXWFNkTjJjMjR2?=
 =?utf-8?B?NDBHLzV1VGVVamxrTWNrVzRqVGp3T2ZLcUppSElnUWdOZVRKeGVoVXEvQ3hU?=
 =?utf-8?B?SWltejhKN1phWW91akNzNFdjWDhUWnpuUmVaZnVtS1pMaE42eXlGVUNBcDli?=
 =?utf-8?B?NVdZL2R4c3E5UVkvN3lvdkFJcmNSZVJqYmNEY3AzQTFuODk0ZEZ0Rko2eTBI?=
 =?utf-8?Q?i8q6KiEmbUxW64AngHTF816s/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8486ad-4ebf-47c0-11ee-08dcff7580ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:45:31.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0ttYtlbE+z7TZ0gTzloNWvi3ZD5IRcUAK4UTGQy7slotI21fRQhlEcR9x2r1cu1X4GYffi2J1+raziMx5jc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On 11/7/2024 03:06, Armin Wolf wrote:
> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
> 
>> Currently there are a number of ASUS products on the market that 
>> happen to
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
>> This however isn't how Windows works.  "Multiple" things are notified for
>> the power slider position. This series adjusts Linux to behave similarly.
>>
>> Multiple drivers can now register an ACPI platform profile and will react
>> to set requests.
>>
>> To avoid chaos, only positions that are common to both drivers are
>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>> is used.
>>
>> This series also adds a new concept of a "custom" profile.  This allows
>> userspace to discover that there are multiple driver handlers that are
>> configured differently.
>>
>> This series also allows dropping all of the PMF quirks from amd-pmf.
> 
> Thank you for this patch series. The overall design seems good to me, 
> but i think
> you forgot to extend platform_profile_notify().

What did you have in mind?  platform_profile_notify() is called from 
drivers and just used to notify the legacy sysfs in the event of a change.

Were you thinking it also needs to notify the class device perhaps?

> 
> Thanks,
> Armin Wolf
> 
>> ---
>> v5:
>>   * Adjust mutex handling
>>   * Add missing error handling
>>   * Drop dev member
>>   * Add cleanup handling for module unload
>>   * Fix crash on accessing legacy files after all drivers unloaded
>>
>> Mario Limonciello (20):
>>    ACPI: platform-profile: Add a name member to handlers
>>    platform/x86/dell: dell-pc: Create platform device
>>    ACPI: platform_profile: Add platform handler argument to
>>      platform_profile_remove()
>>    ACPI: platform_profile: Move sanity check out of the mutex
>>    ACPI: platform_profile: Move matching string for new profile out of
>>      mutex
>>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>>    ACPI: platform_profile: Use `scoped_cond_guard`
>>    ACPI: platform_profile: Create class for ACPI platform profile
>>    ACPI: platform_profile: Unregister class and sysfs group on module
>>      unload
>>    ACPI: platform_profile: Add name attribute to class interface
>>    ACPI: platform_profile: Add choices attribute for class interface
>>    ACPI: platform_profile: Add profile attribute for class interface
>>    ACPI: platform_profile: Notify change events on register and
>>      unregister
>>    ACPI: platform_profile: Only show profiles common for all handlers
>>    ACPI: platform_profile: Add concept of a "custom" profile
>>    ACPI: platform_profile: Make sure all profile handlers agree on
>>      profile
>>    ACPI: platform_profile: Check all profile handler to calculate next
>>    ACPI: platform_profile: Allow multiple handlers
>>    platform/x86/amd: pmf: Drop all quirks
>>    Documentation: Add documentation about class interface for platform
>>      profiles
>>
>>   .../ABI/testing/sysfs-platform_profile        |   5 +
>>   .../userspace-api/sysfs-platform_profile.rst  |  28 +
>>   drivers/acpi/platform_profile.c               | 494 ++++++++++++++----
>>   .../surface/surface_platform_profile.c        |   7 +-
>>   drivers/platform/x86/acer-wmi.c               |   5 +-
>>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>>   drivers/platform/x86/amd/pmf/sps.c            |   3 +-
>>   drivers/platform/x86/asus-wmi.c               |   5 +-
>>   drivers/platform/x86/dell/alienware-wmi.c     |   3 +-
>>   drivers/platform/x86/dell/dell-pc.c           |  35 +-
>>   drivers/platform/x86/hp/hp-wmi.c              |   3 +-
>>   drivers/platform/x86/ideapad-laptop.c         |   3 +-
>>   .../platform/x86/inspur_platform_profile.c    |   6 +-
>>   drivers/platform/x86/thinkpad_acpi.c          |   3 +-
>>   include/linux/platform_profile.h              |   6 +-
>>   18 files changed, 488 insertions(+), 190 deletions(-)
>>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>
>>
>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2


