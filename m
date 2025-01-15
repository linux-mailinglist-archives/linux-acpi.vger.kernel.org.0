Return-Path: <linux-acpi+bounces-10690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51941A12905
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676C51885AA9
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FE19E7ED;
	Wed, 15 Jan 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TA7RfNDe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8215199244;
	Wed, 15 Jan 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959414; cv=fail; b=pqA/7knUs5llfwp2JsO8tbPgWdHaZfeZBzQ3PTzAUYlzapS0PLgLH2HMVksCTG35ZgqV4HTxT4QMuZi+IlbP/onUoIQoJAfk3zoQkUgixGVsnZqHq7dNlsMb31GiavJD74joUiJx8a6d270V0Jw1om7ZQp/BaHiMXD9BYkJ1CwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959414; c=relaxed/simple;
	bh=ZYdoikWWDnW3KtcHEDtHSIzspj39vGYjbxA/9dyA1fI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+zyDI8z2gesIHxuOldAtAu6S9tvaod8lu7PuD2xBjPIcdtRWucizYrr8HrmISbJEkD75EK+fFoWXo400+Q9Q4tC5AIA60fYzJO/cqRuwx+XFS7ggolIn9A96hFWDGuCDyKawtzkWlYEnzXtFD+ZdVy06QvEUp1ZPGDJNg4Sy/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TA7RfNDe; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkqQNTHRYr9c5BHN+GkvlDbFxvBreAeqh64mt1FHFKpVaKlv4ZjdViroRnn3ZDPqTuFRw6BHvJB/LqQ3MyU/V1FGjVOhI2+zyEAoHgib+v9V/1CJWNJm+iuQ/FVW1U9Zjz41NAjuAg4JbgIoMKHSt2GDxmxudOCUxgdKg0PklY1cDDj6CGfguEjcWYvFa13vQ3AnNyQ04NR+KAgpa+0nVuIJfByQ6N6Oas5BTn8KuwQHcYtoBNPDA/8zwfoSeRybG+tfOEDs+Rb1j566PBL19etNsERBwneHa43nJrJ7Wp6vF6GGdhEJ2whasbMSk0Qqw6wWjJeXoY7TObwUqT+gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+2GWsAy/mABlOOYa3TyplSn1VJitm8OHSnIR1HHQpA=;
 b=x/9T2TNpwRnUkk4H+iw3eVa5EnrLgSPv5xg01mm24d9NN93Pp4FcEKNt3faXp4RSqTjAKKz3Ag5otenoRIFBztigFYICzH9kNpGmdLinnLvFDKFj1XiH96MsHJJmTZCvJuV8/975KzkqF+743r0+hFv2tBeT5UxOAED5wOVloGqtePKwC8zKr+//DF7tH/Ggh3wQ3kyPvhp1w04XFwYdrmn+fB0ir7z0ccSSi4rUpQ1CL74OqVYeigvHMXdNd0v100pBkeD3Pei/fEVgCGR4kU7xbyZ4sX8o4sPHi5bApMivXqezO3pK7SsZ1UZ7IyoZ7L101UAvJiVRtNktNyDLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+2GWsAy/mABlOOYa3TyplSn1VJitm8OHSnIR1HHQpA=;
 b=TA7RfNDeWoVe7ja+NtpgUbZKXTxoCVGCV0VSL0d6xDHEEUACvk2BDuyKy5f4sD72z0VtRsg/Y7SITvFaTXKtGUIVS4q/EoQq1vjG1D5iE+R83T3MFWEyV0LJjppohwl9oD9xz7lMbDErVSOGMx2HhYNrfbw8S5uOX5u/04X2iss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:43:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 16:43:29 +0000
Message-ID: <0cb4dece-e67e-4209-bbc9-352ed50e8ac2@amd.com>
Date: Wed, 15 Jan 2025 10:43:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] ACPI: platform_profile: Add `probe` to
 platform_profile_ops
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250115071022.4815-1-kuurtb@gmail.com>
 <20250115071022.4815-6-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250115071022.4815-6-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0193.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5604c6-67cc-4c0b-7f49-08dd3583bdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3BndDlqeVBQNUd5SzhrSkpYcmZhaUtkQ0I3Z3VrSjZad21haUhCK0ZtTlFJ?=
 =?utf-8?B?d2swNDBkS0RZUW5lN3ZWQlVsbkFoNHFNYnBwbUFmODl1NUdKSTFJYzZJd3B3?=
 =?utf-8?B?U2JveDBxZkVPbHdlaWhScmdVSDFTTzIweSs4RjRFT3EvWENXeE5MeXdrOFdx?=
 =?utf-8?B?amY2a3dadGhGbDZvNHZvYTRteW50SlJCQVhiMmtQTndiREdlcE5nbnNhdGFR?=
 =?utf-8?B?UGVEYmJtR3VwOENCZ2xyY21ZNzJpd003WGg1RzVsR0VvdTNZbmJobFhrajNW?=
 =?utf-8?B?cHgraXpHVlBhNW5MT0IzWUxrbUdIWEpRMnBFeHljc0RyQmpwUmthR2VwbzNy?=
 =?utf-8?B?b2ZpR1A3NFBjT1ZHU2M1RlR2dlJpZHM4WUxNdDE0WVZ2d3lQVUdsMHdiTTN6?=
 =?utf-8?B?UGY2UXVackhDM1pNWW9SNUx4bnQvZXBtdG1nd0lNdEZGK3NZYXJ1cTZ2cVZP?=
 =?utf-8?B?MGltdXpUb3ZtUEpKbjloVEhIdFlLeWY1d2lGVTNpOHNkbVRPdEtvQloyWGMz?=
 =?utf-8?B?cUtrVGg3Z3ZDQndsRUJibUF1NzhIbWhhM3VlWHQrRUdZNVpnbm9tcUhUNkRQ?=
 =?utf-8?B?ZEk2NloreWRlN21mcGlRSzdhSUQxTFB2aFFCdmh4QldVbDQvNG5GR0Y5Y211?=
 =?utf-8?B?SHFCdE1wTEtoUG4wZjBicysxZFpiUG1YdEJzQ3ROUXVsRkR5S25zaDNFVVRr?=
 =?utf-8?B?Ykp2UFRKbTVuRjdjWU1haWtwVWJ4WGpBcmpsd3FRSlR6ZmZEb00wNzdzaytF?=
 =?utf-8?B?cEw2SnJheVZqNUdnM3NKZ3lCOW9LZnUwTUExUWpGVDBpZFVhdGxIWVJtdlFv?=
 =?utf-8?B?SklZWm91YmUxSWRPRm1iSnhkSENlKzAzdUgzWHhWNW1MNVBFc0NrZVRmNTd2?=
 =?utf-8?B?UkQ5M0hEMzNYUGRKQzF6OEtwVTZ0VnVEaEgwemJOQ1JNMXRhYWhIZTZmRUxO?=
 =?utf-8?B?KzVsVHFrY0xTQUdMSmVDNHh0SmFlQ1NEVGd6SDJGbnR6eEVoRjdzZnNOSVA5?=
 =?utf-8?B?ZjRuUkZtMy9VRWJlTUJBRmx6U0hodWFkYUw4cWhlcmpDWFRsM0xML1NwSWFt?=
 =?utf-8?B?a215SUIySFR6WHdTUVN0K1k4WDdPcjgzeWJXeUtzb1RsSks4SW8zWkVCcFF2?=
 =?utf-8?B?STBaZjYvZDZTKzFMMjdkMmV4VDJSb0hmY3BnUFVEZVJQMzR2UXJKS2Q4L1Ro?=
 =?utf-8?B?eEVPY2ZqWjV6dkZ4R3piTjlwR1JCMzdpZWM4UDhwb1ViYUlBd2h6OFBJVlkz?=
 =?utf-8?B?TjFWbXlDbkk3OWFXcXpSYXJLTXpSMXdZOVIzbnVOVDNFOXFYT3FUOXVxWXIr?=
 =?utf-8?B?THp6eWpYanFubnNmWDZKbG4weTBwbkk0ZXF4NDVuRERHL0tYY1B5Rm5uTUlh?=
 =?utf-8?B?UlNDVDFWakYzM3ZCTlFiNkRMcUh0SzZFVnFYZ1JPMWd4QUd5Nk5xQVFQRHJO?=
 =?utf-8?B?bjhIUnhRdVlzc0Ztd0thZit5T2dVZTBKTGxob0xpUnRMQTZIeFVtZG1zb0do?=
 =?utf-8?B?a05oV0t1MXJYL1dnVmtaSFprVWVZMHUwc2xXV0F0NTlqK001OWJVK0lsVzJz?=
 =?utf-8?B?RnMwUGhEU3c4dEhaWWxMMFdxNnZKVDYxRGpoNUdtcFlRbVpvQUorRDYxWFFU?=
 =?utf-8?B?MGVyOVU1cmc2ME4vejdndHJiVjVSRDRCVUFxRk5kakgwdktVZjMyWE5KSVNW?=
 =?utf-8?B?cWR3N012SnVkb0xXVGRXOWlSN3lJMVNhaTRrY3VIOXdZOUZ5ZDNpL2c2WmRh?=
 =?utf-8?B?UW10K2NBaUEyL3h1bDA4R2lZWnhWUVpxQmd5QVhhVzJ5aW93MnBNZnpYbmFt?=
 =?utf-8?B?cVZROU52Wkl1b1dwUzJzUUJwZGZNWHEzYW90NzcrVjRmNDhTemlLZXIrM1U5?=
 =?utf-8?Q?Z4/Jkz0mxOo+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NENnc0JPUWUvZW9XYzZYY1AxWFF5YWt2NVNXeW9NNXBraGVub2lmUVNuaS9K?=
 =?utf-8?B?OTRqVmMxLzNvSUhGZ3BId3JtaisvdlJ3QXNoTHVzSnRPV0dIK2lCTHplNTRQ?=
 =?utf-8?B?Uk1aaGQ1bElsNVhvRzV0RzJQZEJlckNPdzBqNENyQkVRcGtGNUFtUmFaN0ha?=
 =?utf-8?B?R0NTdWRoeTlGUC9VS05ES3dFM3p6ZkVXaWR3cmI0WDRjYUU4emxhTGxVeU9a?=
 =?utf-8?B?V1hpd0o0eU9ab25xQ1g2SFNzdyswaGRvTDJEbWV3NEF5enV1TXFQUU4wL2JB?=
 =?utf-8?B?d0hBTWpselJwc2JBL0FGcmVuKzVMajhUMFhpNHJwTGI4eDhIZVp2Vk9KaTlL?=
 =?utf-8?B?b2laK1RTOU5oSE1EQ0UrZ2hkV2ZLWGFydXJ2YTNmRGJtTnNOcStKWFYzKzVs?=
 =?utf-8?B?UnRQNlh1cm5OdlpSZ2FrZzVoK3JZQVFjc2NMWVlwaCtoWkloeC93OHJKcCs2?=
 =?utf-8?B?dTFidVZEbG5qSDVTTUFyVFBwSjJHcjNvMFN0SFNXTkpFZkVQNlFXMFVpWEZm?=
 =?utf-8?B?UDNyRWd6ZnhkbnhzSmVKcE5PUjZkRmdpMEpoaDRYbUU2L0cxdzhtQlJjc3dX?=
 =?utf-8?B?NTQ3YnUxVzhkcEd2QWhteEFJTjB6M2lscVloU0FxcEFtclBRd1JBNmhKbGxG?=
 =?utf-8?B?Kyt4ajhOY1hTUTl4enhUUDdQTTB0L053YjRORnV3cUYvS09xelZGeXRwNktB?=
 =?utf-8?B?dklocUNWazBLM1p3NGlIaG50T0NTdGVpODJNcmtMT3NlYldEZnNzTnJyS3dV?=
 =?utf-8?B?OXBrWlBzMXRyeDUxK2NnZ0hDK3RxaE9tdW41b2JxYU5mcFRVQ2hiTEpkdzVH?=
 =?utf-8?B?RW1iY1FwdWVmWVdlUGFEZHlQSzZMa0lWbnVVWlJhOFB2T1o2TG1WSDR3ZGpP?=
 =?utf-8?B?ajlWMEFwQTVJWkxUdkRkY291eDJ5bEQ4ZFpPam5OVDJEZDI2cFhZN29iWER6?=
 =?utf-8?B?ZjdvcFhTR0kwTG4xWDdNUHJHR3RTdnJVRERka3l5TDdVampTNmRsRVpZVlB2?=
 =?utf-8?B?czk5WmQvd0ZnUng5eXVxeFVCQncrbEV0VEhvMFNTQWh5bFBxUlVzVDlNVExB?=
 =?utf-8?B?T0ErRTNSUWlNMEpqR3A1enpVaFNQMEtMbFNaNC9PbnlIN3R1aUxhUDVTUGk5?=
 =?utf-8?B?Y0g1SkYyNTFrNEZLKzJsK3RoWkZnQmtPZnNaOGdrTy9zdDZNZFljWk9Nb2NO?=
 =?utf-8?B?L0RQMzgySnNKY2ZLdVJnd2VUTGN2QTJxa3lHV2kzSXdMd1ZiUjdQQjZJM3Fh?=
 =?utf-8?B?Sk9UZGpvWUJBWmZBRi9uOXhQTm1aM2Z5SG1ld3pTNm9XTm85SldyZWRGSXV0?=
 =?utf-8?B?RVVtN2tpcW1UY0taYktXRVIxbmdGcFpkcjZGeEtnVUg1YTNJK3ZaT1dpN2FH?=
 =?utf-8?B?bjJDeWJJTlRkSGRUTSs4WndJWkNUVEZTY3ZtVzZxeStQeXZBZDIzTXlGS1ZI?=
 =?utf-8?B?c0RaemNmMVQ0b3orZXZWVnd2LzY2OVVXSVFFS2FTWEdXNm9vTC9iaDlPZ2d1?=
 =?utf-8?B?WmhTcTZJc29CKy9nWGE5Rmsvd3hKaHl1ZmNzY0JwYjUvSDRhTUViSnBtQm05?=
 =?utf-8?B?OTVWYThiTFE5MG5RY0taenNoTzAyS1dhaHBHaWw0ZlFZN1JTeGtLN1RyTm5l?=
 =?utf-8?B?VlhPK0NyQ1BHVXkrekRNZ3dWVE5ESUN0SmFtTEVtOERGQVdHeVNjQUtqZ0Fp?=
 =?utf-8?B?WjRleUROT1Q3Ri9oNnVvNTBCdEtiV0loRzhpR09yZWFld005Q3kxY2ZBNDlH?=
 =?utf-8?B?RmIzNDRlVnZxdTdVRVQvWXV1VzdJOUhNaFN6a29yVk12MGV2UzA4QnlMNWw5?=
 =?utf-8?B?dmRWczZ6UWw4eTkzQks2djQ0TGRxSXFhVkpuV01oTFFYVXlmU240MlhWM2wr?=
 =?utf-8?B?SnhMTlVKYWwyVEFJazRrSW9FWXZaVFRtNUhBL0x5WmdKUHZmUWZRcFNXY09K?=
 =?utf-8?B?UlgwQzhkMHFJKzhyMUVTam9CWW9JRzN5QUhkTWJHSFFHZzVlZkhHNzJSbDZG?=
 =?utf-8?B?MGdJQkhKOHp5enRNOHd3RnQ0TnJXNEZNNS9CQlR0LzAyYllHL0ovNmZhWDRB?=
 =?utf-8?B?aGpONHlEcmp2U0NsWVdLK0FXajlOUDNYdUUvcHczNXJEV2VpN2U5eDBrUDRZ?=
 =?utf-8?Q?6h7LmcHLRBZMKqK9+JuSA43sc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5604c6-67cc-4c0b-7f49-08dd3583bdab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:43:29.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuvn/3VEl2gjGb7Ma7q2RZBOVZy45HVOeCKEOa8nrmhtUIysQMALvlpsnWVMZg6RoQpS199rjQDDLXVTBX9m2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On 1/15/2025 01:10, Kurt Borja wrote:
> Add a `probe` callback to platform_profile_ops, which lets drivers
> initialize the choices member manually.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c               | 15 ++++++++--
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
>   12 files changed, 139 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 161a05d57b0f..120f8402facd 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -465,12 +465,23 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   	int err;
>   
>   	/* Sanity check the profile handler */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
> +	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> +	    !pprof->ops->probe) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
>   
> +	err = pprof->ops->probe(drvdata, pprof->choices);
> +	if (err) {
> +		dev_err(pprof->dev, "platform_profile probe failed\n");
> +		return err;
> +	}
> +
> +	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> +		dev_err(pprof->dev, "Failed to register a platform_profile class device with empty choices\n");
> +		return -EINVAL;
> +	}
> +
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 76967bfeeef8..48cfe9cb89c8 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,7 +201,18 @@ static int ssam_platform_profile_set(struct device *dev,
>   	return tp;
>   }
>   
> +static int ssam_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops ssam_platform_profile_ops = {
> +	.probe = ssam_platform_profile_probe,
>   	.profile_get = ssam_platform_profile_get,
>   	.profile_set = ssam_platform_profile_set,
>   };
> @@ -223,11 +234,6 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> -
>   	return platform_profile_register(&tpd->handler, tpd);
>   }
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 91ae48adf6cf..6953e36dbfde 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1916,7 +1916,20 @@ acer_predator_v4_platform_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int
> +acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> +	.probe = acer_predator_v4_platform_profile_probe,
>   	.profile_get = acer_predator_v4_platform_profile_get,
>   	.profile_set = acer_predator_v4_platform_profile_set,
>   };
> @@ -1931,17 +1944,6 @@ static int acer_platform_profile_setup(struct platform_device *device)
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
>   		err = platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 6ae82ae86d22..e710405b581f 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,7 +387,17 @@ static int amd_pmf_profile_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int amd_pmf_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops amd_pmf_profile_ops = {
> +	.probe = amd_pmf_profile_probe,
>   	.profile_get = amd_pmf_profile_get,
>   	.profile_set = amd_pmf_profile_set,
>   };
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
>   	err = platform_profile_register(&dev->pprof, dev);
>   	if (err)
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index d88860dd028b..3d77f7454953 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,7 +3852,17 @@ static int asus_wmi_platform_profile_set(struct device *dev,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> +	.probe = asus_wmi_platform_profile_probe,
>   	.profile_get = asus_wmi_platform_profile_get,
>   	.profile_set = asus_wmi_platform_profile_set,
>   };
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
>   	err = platform_profile_register(&asus->platform_profile_handler, asus);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index f7a854d40575..0146d2f93be6 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1078,12 +1078,7 @@ static int thermal_profile_set(struct device *dev,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> -static const struct platform_profile_ops awcc_platform_profile_ops = {
> -	.profile_get = thermal_profile_get,
> -	.profile_set = thermal_profile_set,
> -};
> -
> -static int create_thermal_profile(struct platform_device *platform_device)
> +static int thermal_profile_probe(void *drvdata, unsigned long *choices)
>   {
>   	enum platform_profile_option profile;
>   	enum wmax_thermal_mode mode;
> @@ -1116,19 +1111,30 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		profile = wmax_mode_to_platform_profile[mode];
>   		supported_thermal_profiles[profile] = out_data;
>   
> -		set_bit(profile, pp_handler.choices);
> +		set_bit(profile, choices);
>   	}
>   
> -	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>   
>   	if (quirks->gmode) {
>   		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
>   			WMAX_THERMAL_MODE_GMODE;
>   
> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}
>   
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.probe = thermal_profile_probe,
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +};
> +
> +static int create_thermal_profile(struct platform_device *platform_device)
> +{
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
>   	pp_handler.ops = &awcc_platform_profile_ops;
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 9010a231f209..32b3be0723f8 100644
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
> @@ -231,7 +232,22 @@ static int thermal_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int thermal_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> +	.probe = thermal_platform_profile_probe,
>   	.profile_get = thermal_platform_profile_get,
>   	.profile_set = thermal_platform_profile_set,
>   };
> @@ -239,7 +255,6 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
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
>   	ret = platform_profile_register(thermal_handler, NULL);
>   	if (ret)
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 60328b35be74..75bcd8460e7c 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1488,6 +1488,23 @@ static int platform_profile_victus_set(struct device *dev,
>   	return 0;
>   }
>   
> +static int hp_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	if (is_omen_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	} else if (is_victus_thermal_profile()) {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +	} else {
> +		set_bit(PLATFORM_PROFILE_QUIET, choices);
> +		set_bit(PLATFORM_PROFILE_COOL, choices);
> +	}
> +
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static int omen_powersource_event(struct notifier_block *nb,
>   				  unsigned long value,
>   				  void *data)
> @@ -1566,16 +1583,19 @@ static inline void omen_unregister_powersource_event_handler(void)
>   }
>   
>   static const struct platform_profile_ops platform_profile_omen_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_omen_get,
>   	.profile_set = platform_profile_omen_set,
>   };
>   
>   static const struct platform_profile_ops platform_profile_victus_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = platform_profile_victus_get,
>   	.profile_set = platform_profile_victus_set,
>   };
>   
>   static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> +	.probe = hp_wmi_platform_profile_probe,
>   	.profile_get = hp_wmi_platform_profile_get,
>   	.profile_set = hp_wmi_platform_profile_set,
>   };
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
>   	err = platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 96e99513b0b5..050919a28d2b 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1023,6 +1023,15 @@ static int dytc_profile_set(struct device *dev,
>   	return -EINTR;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static void dytc_profile_refresh(struct ideapad_private *priv)
>   {
>   	enum platform_profile_option profile;
> @@ -1064,6 +1073,7 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   };
>   
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
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
>   	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>   	if (err)
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index d0a8e4eebffa..06df3aae9a56 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -164,7 +164,17 @@ static int inspur_platform_profile_get(struct device *dev,
>   	return 0;
>   }
>   
> +static int inspur_platform_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops inspur_platform_profile_ops = {
> +	.probe = inspur_platform_profile_probe,
>   	.profile_get = inspur_platform_profile_get,
>   	.profile_set = inspur_platform_profile_set,
>   };
> @@ -184,10 +194,6 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> -	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> -
>   	return platform_profile_register(&priv->handler, priv);
>   }
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 9978fd36a3d1..5c250867678f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10538,7 +10538,17 @@ static int dytc_profile_set(struct device *dev,
>   	return err;
>   }
>   
> +static int dytc_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
>   static const struct platform_profile_ops dytc_profile_ops = {
> +	.probe = dytc_profile_probe,
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
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
> index 6013c05d7b86..5ad1ab7b75e4 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -31,6 +31,7 @@ enum platform_profile_option {
>   struct platform_profile_handler;
>   
>   struct platform_profile_ops {
> +	int (*probe)(void *drvdata, unsigned long *choices);
>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   };


