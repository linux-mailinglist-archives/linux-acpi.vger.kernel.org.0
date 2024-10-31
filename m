Return-Path: <linux-acpi+bounces-9194-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B649B7B8A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1821F224CD
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8019D090;
	Thu, 31 Oct 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xz70hqa5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D7156231;
	Thu, 31 Oct 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380694; cv=fail; b=WOa754nn/OKYc52VjOj+uVev7XV4yO2TGNKPfLrpcAzsWchd7JcAgxD2N7RimoBcswfSWVss5wrBzx7RKA4Dv4USNVw+yJ1unTIBIEYcj8ZsRW5qFJXv989rVMZmcEygRtDvU9eZRi0A1z1m8QSZEWaJwiCNx6Y87nlgqhv+rVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380694; c=relaxed/simple;
	bh=82/SxSD1VIVbdMMkoubzzgMyLinC8J2aejIou9mPtOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lWeMb4iAfjcLUW7dkrac1SKTfoMNXdijm1FNuHqR9fRVlMx8BjwGgSv/BZpxqXluIiOmpQhi/w5tLJt0GAIUHWcdR4ieM//tGBA50FZDHFWDzr5H8OQI2+qhWbcJ5HoJ+lTDTz15K9J2fpwbu4kWiVJI7w27U/eOdZCBwQMUN/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xz70hqa5; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnDcClZIn8HQwo8RVCL/Ap1JlTf0jj41HKJAe8hayxaffZcAJUF9rFvbfzcNcvtbMIEcQX8aPY/I9QQjIYPxa/oqcbGHAJPtRvYlmBEtBMb03rdVNGQIHwZpOldQn6J6wojv44BiIN72KYN3wcclyy5ed4rzfGM+5+TNWb565akU97s2o4Dih7DyO1NgafexsdNyKknjy928HdLoU9hkZUBZ5zW7QqlnpIQ4ZcEyjLvHoZGj9uvYGSRgasANjj3W32+9Gtg9eIAjRL6cEEs32JSdWG3TCWkPiIvZMMJjmsQvcXVCZUQH3q4Vu7/s9kAvRQF4j0iPt14vVm2DcL2hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVhoteewv/NfOk09X/q2LzAvhYRpklA37/xvfsmzKqY=;
 b=qa/Zm7XXIprPdzgmgNZFq9WRXVjrb3jwyFsVFHYKviaAkM8ZbjCM8LKGoQgyyfXgmiE4cWbkSVTUMN6oaAwcWrBS+T+b3AL1HhrJSatmbsdDesxbd+OJW5NXzzjoAJUu1HkU0rNYlHiMf53chKIBIstQ1OpG0w7OCiLtCV8q7M4q2opJPZqSfxOGxk0fcplGlu+5EbNSp4C4bZy9sIhlF+Qv++6hIj4pIoBIk3rhfp12zpQf5IMMOCdr2b+AAQe7esVRYDalg8ri7ys3qlxRAvGgdSlUhfbSccoevEONrItuqR8P2ibHkACnQjq+H5sDRQhyEIFkgBukaqNCmnInNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVhoteewv/NfOk09X/q2LzAvhYRpklA37/xvfsmzKqY=;
 b=Xz70hqa5oVdRImRI7F1VWNjZ3csxoHWdRTpPu15+v2Qkl7ATb3TuzwotTfbORPVKXjt4I0N5duLt9n8sFPR9JuEw+vdXN2QKsFoYG4z0Hv58ho956rWMLscej03F4IzF3vt8gagVna67pR3foYHC787+E9Yrishiv3nxIn+7KlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:18:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 13:18:09 +0000
Message-ID: <362d8939-20ed-40c2-95b4-f687dc20f6cc@amd.com>
Date: Thu, 31 Oct 2024 08:18:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/22] ACPI: platform_profile: Set profile for all
 registered handlers
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
 <20241031040952.109057-17-mario.limonciello@amd.com>
 <7e2c26ab-9172-fa82-cd96-7f725d6c7687@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7e2c26ab-9172-fa82-cd96-7f725d6c7687@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: d20dedda-b693-433c-e427-08dcf9ae76e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhydStoWFRoMDd6bUZ2Sm1RcS9wenVzVVZLL1pCbnAwOFRSUXB3anJRTExo?=
 =?utf-8?B?MXlvbUZtV0tKR0V5WnI2emNJMVhnUitpWnFGSWRSVEJ0VkNXRnB1Z2pBcUY4?=
 =?utf-8?B?dEZJMkZUNVdXK3NVSVYzQlRrZ2duMCtnaXNFTlF3L1ppTExYWUJaZkZqcjdJ?=
 =?utf-8?B?c29nUXIvdnhtZ0tGZ0lZUWtHdWlEUTFUajJWU0xsV1NKRTNrZHdlVDZGWUxZ?=
 =?utf-8?B?ZEQrK3ZMWWp5T2NCWWEydzRLUm5qRnFGcFpCM3BWaHNjQTRlNFRGSVJuVi9m?=
 =?utf-8?B?RnhORlRYNk5MR3haN3FpSHhsKzhvZWx4cXdqamFpSW81MndlcEtVODJoZE9l?=
 =?utf-8?B?cld2VDNQaisvWm4zRm44eFBQSnJwUFRuWFRxVERqNUxjbWlOZVdMMVI0ODZy?=
 =?utf-8?B?OVpla1o5RnhLcU9kT1dZdHhxYnBjTXpkdkJmSFRXN0NSUHdpMG9VaGx5T1JK?=
 =?utf-8?B?TDBLK0ZsZEpvR2ZrRGx0V1l2SUNmdk5wSWdiZ0lJbitoRm5wejJVNjdYNFo5?=
 =?utf-8?B?bFdTVHo3WVhmMnBJSUczVGhKWWNEVWUvbFQwUXkrSDQ1THFaVXB5Ly9vdWgx?=
 =?utf-8?B?SDZTSTFBMkUrOU1sUVpiYm0yT1hRWlRNdkM2eXJnTlJvYit3R3ZjSHNDekJ1?=
 =?utf-8?B?dWlZZkZsS3JXMnc3L0tTVXQxcXlWTHZSamdGK2xORkw4M3ZLZXRLMC9jZU1y?=
 =?utf-8?B?OHhpaGQrM2RDeWVwZUVNQ0Y3bWJsc25SM2JCUjQrRG8vY1E2ZVNaUC8xb2tC?=
 =?utf-8?B?bVpUeU56WUtzcXJrREtPaVRuZDh3MEJGbXYvdWNKbURhUjFnRHNxOVozbEpZ?=
 =?utf-8?B?ZW12MXF5ZGFYSSs4QTd5b3lDZ25JMklKOWlZTWJ6cUw2TDZ3Z3VyaDdoOXNw?=
 =?utf-8?B?UTF2OHpoRTFPZS90M3psLzg4TnRDQ0dKTUhOTnlNKzJia0UrVDZQRVY4OGFl?=
 =?utf-8?B?MS9aOWJZK2NTbXNKRmhFZGxaNDZpWnRka2ZxblhIN3Nrc2lHUVhWU1dSdk10?=
 =?utf-8?B?QUlYM3oyK3hLOEtMQi9GSjk0SDlQeDVPUDkzSEJidVB5VjJxcXNieEZKWm9y?=
 =?utf-8?B?TGJLdzZQaHlGNGJvU0JtbnpObzNGK08zbUYzOUdUS3hXTjlQRk5IbFhNR2hk?=
 =?utf-8?B?SnUwS3lQUXYwQ1VOM01RRnJZbGp6NytoZTFiSWN5VUQ1NHp0T1RQVXVFN1JG?=
 =?utf-8?B?NlBScFBoekNzV3RDN0VSRkZBN1dLY29wZ05LOGZoKzBrMnhFWCtCR2N3N0dp?=
 =?utf-8?B?bWpxWjhoVUFtQncxUlduV0o0WGsvMjRaN1ZIMXFBMEZtdkQ4dndOS0pYVlkv?=
 =?utf-8?B?Mk0ydlVCa3VjUlRuYlpHL1F3M25XY05TajU4bWFDN0g0NVdyRkE4b3ljUEZs?=
 =?utf-8?B?d1loK2R1MVprTCsrU2FrMTZha3Y2UFhMbVd1c2puYXUxMDlQTmRHT1QwM2RC?=
 =?utf-8?B?NFZOS3ZDeVVLc1ZlNlc0VGsrZ2RmaFF3UzE4NHBHdnVOc0ZCWTFiKzE2U3pL?=
 =?utf-8?B?M1dnR1NZaW5KbGxHOXdRNjg1bkhsYkIrVnZiVFI4eFc2Skx0L29yMkwrWHBN?=
 =?utf-8?B?QnMzWEozUTAwNjR0eG0ybDVOZk5rLzV5bmVWZU51V3BOVHRIbzE1SUJZUkl1?=
 =?utf-8?B?ZUgrNkVhb0FWN0FXUExUcFVUNDBPNnh1eEZpVEo5UUtrSDdOY3FFS29qcGhy?=
 =?utf-8?B?blJXd2RTYnN5MHFoY0hHakhTVktvZndJcTRiM0hIcmxkRi8rWmozV3FRbTZQ?=
 =?utf-8?Q?vv5ddmFA1s2FDrHSLa47lY1gNyed/FYezxAgvak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXpnL1pZOTRrQUtycmtjbEZWYmJqd3ZVSnA2UjFMNTBwcDJyMFhCMmltWldV?=
 =?utf-8?B?Rmk2TXlvamxHemdmaFJQZVFMOS9lUnBzNlFiYmF0SjNRd0VNSzFORGx4M09B?=
 =?utf-8?B?L0ZKcDBZSTVNTnJjUE1mTE5IcWRydW5SbFVtMUR4dHFFZVQySVVzTTlIVG85?=
 =?utf-8?B?dlpEZzd0RlhuRGNtSTY4dGpSeFcrNysxNW9DaE4yR3dBSE1VMmRUalVTQ2ZR?=
 =?utf-8?B?UDEyOEY2ZWhHS1kzN09kbkRrdDlQY1YzNWhlUnprUEkvcnBRWDNTQzVsQURx?=
 =?utf-8?B?RUhHR1cyallFNnA5aWxrMmQ2Nyt0Skk0azlEK3ZoaitnRW1uUGdjdlNUWWVi?=
 =?utf-8?B?eWNHSkFjQSt1MGp0UGhIQVN2NXM3NkVNd0RXYW4wYURyTE5pZnRCbVl0VE4z?=
 =?utf-8?B?Mmo4V0pnYzBHRXZHTHYzVHl0Y0hLaHZIYUxNUmpza1Y5MVFjaTZkaXNQMzFH?=
 =?utf-8?B?YldiSjFZU2taTnV1cHBpb3VabGRFNCsxV3l6RjUvbWVNOWN3VE0xMnNMOEd6?=
 =?utf-8?B?MlFuKzdLcFNKMU1pVFdMUFlHdEhaWXA4SWJTWlB2NWdzRVRuNFBONlFGVGdj?=
 =?utf-8?B?cTBia1hJYkRHQVZRODRaYTRvMHVMaTF5cDZydllvWkFIc3lmamtEdm92b1Ro?=
 =?utf-8?B?R1FveWhzRVduWjMwVzYzU1RuZXhhSHJjaCtoMFhBY2k0cHJ6RXJhbC9zMVZQ?=
 =?utf-8?B?TFNzZmN5RU5Yb3d2N1JGVnh3YXE5WVlyMDBuTGhyM0p3dG9KWkZHMkZGcXJV?=
 =?utf-8?B?TXBJaExIOFBzaXQ3WVhYNGxxSlhoNS9DRXJ1aVN5T0dNSDF6NmtONGo2ckc0?=
 =?utf-8?B?Rkwxa2w3bGtZelQ2RFovQlJaUmxOcTZueC9tZVJtdHNtY1B0VGdEMDd5cFRN?=
 =?utf-8?B?S1NyS1AxNENZc1BkTmU4SXJtQjQ2R1RDMHV0KzFJdnd0dHo1Rm8rdnNqNUlB?=
 =?utf-8?B?K3lLMXQyT2NIYUJSVXVwR0NLeHFxazFYZVVxelNidEorSlZyZTV3Q1JZS21p?=
 =?utf-8?B?alpoYXRteHAwUE40SzJ4V3NoRi9QMXh6aVpxZU8xMEg4Z0RCMHRBeEpGQ05l?=
 =?utf-8?B?OXVKV2xya2VJUnhlZ2pUMkNLbUpmU0FHQ2hNNEN2RkcvQ3luRys4L0hyYWpP?=
 =?utf-8?B?bEY4b1VrUU9yVkxudTY3Zk1VMGJGZ0wxdGEzUmFzWlpLTVlJWTFNU0tXTXJM?=
 =?utf-8?B?T2hOYjdFaXQ5TktmcUxTZG1DaVhlaExOVmNmeWtQc0NBdVkyZmc1Z1J2SWls?=
 =?utf-8?B?cXhieFhDVHhWQy8yb2V1ZW9JOWdtdnNBeEFZRS9aSURlRE16WjdVNjdLYnU4?=
 =?utf-8?B?MTgybTJ0UmFKdGZQVEd4d0ZDZkRoUWxWMXptRGZEeDFhQXltVWFwQUQwcGZR?=
 =?utf-8?B?eFU4MHl2WkR6TEhuVUhFYTh1WGdBZitYa3ZoTnB3a0tVU2NLNk83dFhDVkc5?=
 =?utf-8?B?QnpPeTRjQ1l1ajN4MmdzRThpT2xDUmYzUkIxSFJBSUx3L1QvQy9RYWU1azdl?=
 =?utf-8?B?dWNSOTFzeDYrbTlNSDNCdWpZV2dFR0hiOXlkOHVYeWFBUWp3WDhLS3FtMEN6?=
 =?utf-8?B?S0tjL1RBZTNTbXZmb0tjWVpaci92aVhucHloaHZKWXZaOGNoZHovRTMrZUho?=
 =?utf-8?B?NnlhZ3dMSW9lU0NNNis5dlV2UEtWT0o3MHE2VEpkUUMzVEY3dHJoZkpTV2Rm?=
 =?utf-8?B?YUJmNWtocVBkajN6cm9kRnVTc2pPYUN4VXVRWlhyRTBhMWdtbWV2OFVHc0gw?=
 =?utf-8?B?Z3JuazNZSmp4Q1RDck5tMnJnM2IyODNaZEZoUnBwL2tCUkJWMUFXZEZLY2Fs?=
 =?utf-8?B?THJvd1BxYkFya0VUcno3YVlXRklKdmNmbkhVTDJ0K3FOblN5NjB0Tkd4RFhW?=
 =?utf-8?B?RC9tdzFjeVBvSk1SdFE4d25qSmp3cWU5UWVwZWYvT3hyVCtYV3gwdDJ3eWVt?=
 =?utf-8?B?TFFBOEZmU20wWUVBSVk2ZUpLeEc4VXRVSjhjUzd4bWJ5T3VVUzh3d3VLRGxB?=
 =?utf-8?B?OW5PQjdWaktHVUk2Z1BBOTg2RlpVL2xIcWMwQkR2NjVSUUJneUt5WFFmZXEy?=
 =?utf-8?B?cVN2bTNVSVFMcFdDbHNkVmxJVCs1RTQzM0ZyRXVYeW9DR1QyWnRqQ0M3cE55?=
 =?utf-8?Q?VJKKJmMxdwNIxQ0PSDb1fg/c0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20dedda-b693-433c-e427-08dcf9ae76e8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:18:09.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys6VEP9U/RnlA1p+KmZCaMITnBa6fStv3rYbR23LOptnHgAA99ANAk15Efrtaz9tkIw5eDDeXwIakb8+aV0+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

On 10/31/2024 05:25, Ilpo Järvinen wrote:
> On Wed, 30 Oct 2024, Mario Limonciello wrote:
> 
>> If multiple platform profile handlers have been registered then when
>> setting a profile verify that all profile handlers support the requested
>> profile and set it to each handler.
>>
>> If this fails for any given handler, revert all profile handlers back to
>> balanced and log an error into the kernel ring buffer.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 90cbc0de4d5bc..c2bb325ba531c 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -99,6 +99,8 @@ static ssize_t platform_profile_store(struct device *dev,
>>   			    struct device_attribute *attr,
>>   			    const char *buf, size_t count)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	unsigned long choices;
>>   	int err, i;
>>   
>>   	/* Scan for a matching profile */
>> @@ -107,16 +109,29 @@ static ssize_t platform_profile_store(struct device *dev,
>>   		return -EINVAL;
>>   
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -		if (!cur_profile)
>> +		if (!platform_profile_is_registered())
>>   			return -ENODEV;
>>   
>> -		/* Check that platform supports this profile choice */
>> -		if (!test_bit(i, cur_profile->choices))
>> +		/* Check that all handlers support this profile choice */
>> +		choices = platform_profile_get_choices();
>> +		if (!test_bit(i, &choices))
>>   			return -EOPNOTSUPP;
>>   
>> -		err = cur_profile->profile_set(cur_profile, i);
>> -		if (err)
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err = handler->profile_set(handler, i);
>> +			if (err) {
>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>> +				break;
>> +			}
>> +		}
>> +		if (err) {
>> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
> 
> Too long line.
> 
> This looks an error rollback though so instead of break inside the loop
> you could goto into a label at the end of the function and have much less
> indentation to begin with.

How does the scoped_cond_guard interact with a goto?  With the jump I 
had guessed it goes out of scope, but I wasn't really sure what the 
compiler does.

I guess in the goto label I'll need another scoped_cond_guard()?

> 
>> +				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
>> +					pr_err("Failed to revert profile for handler %s\n",
>> +					       handler->name);
>> +			}
>>   			return err;
>> +		}
>>   	}
>>   
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
> 


