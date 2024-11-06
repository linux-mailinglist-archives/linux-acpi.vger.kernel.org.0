Return-Path: <linux-acpi+bounces-9366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1669BF694
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF35AB213B6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B7208204;
	Wed,  6 Nov 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9C8lmc7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D117B4FF;
	Wed,  6 Nov 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921653; cv=fail; b=Z6nEPeFvVKNoquf+nUIpb7v4LHhcniSOh+LNJca3kdPi9FRvrPKT7sQup0os55gLG/iS1ksuqNkrgTrUzqK0LZe5iUSd3q1tGf8YYDnxWHWGb+SEdPXY5vXrBXVQWeuoamee60r90f5rZOY9Eh6twiqo32NRTJjIrCDoM66cAHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921653; c=relaxed/simple;
	bh=uHyN3pQBla/SugLNfdKICZGf0Y/KWo7d78zk1KZaqBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWLtBUcquLOVa1gAIB62/BgA/pceuYfqoDh+/jF54OSSwhE83y89j5vi1nYOQVRze9MRgZjPNvIdEwW8gqk41KxWoDexhvpq5Vrpq1J7r/CNscMsukdYQbf9A6BlYs0RKwZXlencL73Gr4kLqWxDykihWWufzk5AkbjFhkmZ0vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9C8lmc7; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyq7GuWR0eEXVEwMfmrT0Zy0iYk7jcF84oSeaUqC9ZVlL+chynhZkJx7eEjba7zFbOrO0PdNHmzWTd7S9reTrQ9dwbErn6j8EHozcPVyAvASQsMjjRCLMWMVIeKxJhoeXj/1MLdJ6c/odIpSI/Q1xzTVXr9/75fyZqdHmQgQZxsOkhHaLzS+o6vHJvUaJ9+jqQkZ2XiDJjJci6CZnvkZYaxjYE0oCd8quoFtYJND0gpgB+I8q68H641L3qdhwZ+hGf+0pHJolEzgjNOqOXteF1lYfgJtcysVPv4I6XJThfOAIoRP4270kAogRTIAmtcK4xt4X0epuKmaqEJvSarJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrI3TPKs/+TvNlOMVz6d1PiwcoLRNxZIH6wdqHeW6X8=;
 b=avaS1rxPQg6TjV2D9i6U503QGrZh13cxUvJw0qiwxW2CxTvYemkG5rirEku3WxMx98DfgHCMaDQamX92E8/c1HCZ6Ji8EToyzt+ERufzkTh4j/lVffpyaoW49/IWOdDfJn+ON9bLjyyrcVWxvKeF7iBldbfNmc8/5rtcSWgZuY8qeR5L2qXbgxsktALbFQEry+B4kKRjpW05Z5slXD8MwcdeN7MMio42F1RMbTa3HcBpFeFEe/xeuS1F8vdTFX6wV9pFs/oCZB97V5u+EEgKgnD1ONAouzAxoxnbjJP46ib8n0IHZ+9BssSF4tQrpwcDzISF9yzj4ifcGPX9bochtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrI3TPKs/+TvNlOMVz6d1PiwcoLRNxZIH6wdqHeW6X8=;
 b=p9C8lmc7Wfmn2170VfAytDFdGPuRlsheEFaPKYbi3rUlmch5ZWkGWl4FoF2dnTOCPby7PZxlSBpq09xanSDerpPMteHI7GIu1Fr5eptaFO+ejomgKusd4G4ZHMKucDsSrnreiHq3kj6ycZC1IpggQd8l49zgQD7ShM+C4F38AWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 19:34:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 19:34:09 +0000
Message-ID: <220ed38a-14ab-44e5-a8bb-dd5eb2888239@amd.com>
Date: Wed, 6 Nov 2024 13:34:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/20] ACPI: platform_profile: Allow multiple handlers
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
 <20241105153316.378-19-mario.limonciello@amd.com>
 <42623eed-1220-4cdf-aa7f-3a9777a3da4b@gmx.de>
 <cbf90e6e-1522-4235-b1fd-90dc54df35d5@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cbf90e6e-1522-4235-b1fd-90dc54df35d5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0003.namprd05.prod.outlook.com
 (2603:10b6:803:40::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdbb49d-61a0-435b-8dfa-08dcfe99fbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mkh1WXcyVFpKYmYyaXoveEhJMTZYQlQwK1VrUno2R0NabFIzazVSSHdGT1RW?=
 =?utf-8?B?aHFZbGdoR1ZoVjMzRm1JVTN0Z0tRZE9nMXdJNnBwT3M3UWNKMDFGeCtwKy9V?=
 =?utf-8?B?S2kyRzI4dysyZ05McmFESGhNT042emtkWTlIVit0UFoxSDdSOGVoRmVmelIr?=
 =?utf-8?B?QUw2M21kand0OXByY0lEMjdiMHFqbE0yQnVCdEh1dld1ZmFhNHRaS05jVHgv?=
 =?utf-8?B?eEtYbDVaK09nbUp5b3AzRjUwM2ZZUTUzWVljUndEWm1XbUhuNlVWZDNUZTRF?=
 =?utf-8?B?UkhheXlVT3FuNkZoMVBrNHM1N2RHcTVpWWJLck9VYkRFUGlFQnArQWRXVzFE?=
 =?utf-8?B?S0gxZmtWWXgvQjRxNTdHMDFoZHZheGxwUElQcFpROWFHTjk3cW1EOHlnYUxC?=
 =?utf-8?B?L2Z2ZDdJSnRTbVowY21sc2RWUHVhMkZsdEo2RitlTURQMjIyT1VwN1RmYkxE?=
 =?utf-8?B?WUZsN215cGR5ZmtzNVlSeUs2cm9JWllPZ212OEVWYjRidXRPa0lrVzQvZDlI?=
 =?utf-8?B?RnZxQTRDU3ZrQ29EWDd0dWg5STg0ZWlXQWkvY1UzQ213ZC9Fc3VvNmV0eHll?=
 =?utf-8?B?NHk5SEYzOHc2OGlPRTE2L0JCdlg4RnB0UFJNdWlmNDNnTkhtS2NVeTg4b1dL?=
 =?utf-8?B?OGEvWEZTMHIyQlhqUVdjYTI2Y0JyeDRiZkZUOUJWTzZiWGVDVmlSZ0hVYWUz?=
 =?utf-8?B?bDRyclJYekdtbHpESXBZYTM2YVRNdW52MXV6YXE1MnVPSXN3NkRHUTlrcms5?=
 =?utf-8?B?R1ZxL0ZDUWQyblQ2OWRkNHpNeEYvMWYxQ0VNZm9aYnlMREdLZjkyZS9meE1u?=
 =?utf-8?B?YnRMeStQL2lJM2thdFUzMkh2UGJSTmJLWTlWTlVDNXZwcTdTVnRiV0NhdE9S?=
 =?utf-8?B?Z2YyN3h1K082YktIR2JWeGRValRFV0VOMnVYSDdORWdrQVlUTlFKMmc0RGl1?=
 =?utf-8?B?d0xsb1IxZ2RRTCsvYjBUV01BVnA2QnhsbGlHTEYxaFg5b2ZoWEQ5ZjJqemhW?=
 =?utf-8?B?dG9Oak1XYjAwMU9idGZpeDg5bUxEWUswU1VjcG8xcDZmN1R0UWN2WWs3Vjl5?=
 =?utf-8?B?VUhOeUt3SmthRXEzQUdJd0NVYVNsaE1XMUE5T3hGWENYSHlvR0N2dytQVjRC?=
 =?utf-8?B?anJoTURTd3NNdkN4VDk2NFpEVHdTNzNNb294SUFJdjVSd0J6emJKTG56YTB6?=
 =?utf-8?B?SStVNUUrR3FrNDdkM1B3MitKZFpXdHlYN0hRWWEydWFXSXo0ditJc015TVpi?=
 =?utf-8?B?c1NvYnJEUGczbGdWbHdGeDVhOWF3MVhSV3Q5T254dnlWb2Z1bVhnM25LRENx?=
 =?utf-8?B?QTJvNDQ5NFNzY2R6VGU0YVFabjYvMmdYWmNIaVNHN1FvUG84NVVEMlE1ZkdX?=
 =?utf-8?B?QzFwTGpROVlnKzlxb002c2lXTFhHeGZnSjFlRzZIQlhMaUZhdDNIelZIYWZj?=
 =?utf-8?B?OGxkbW1VTytrcy9BUDBrajRwT3ZYY2h2UjBNc25RVVE0dGdRaEdsWDVwa3pT?=
 =?utf-8?B?Y3V1K3U0dHZudkxPQzdLcms0VDlsb1Viek5JOHl0eW9rYUxCTzZSYmM4YVJx?=
 =?utf-8?B?WkN3Q09oODFQcU1aNk9XZ2xsdDRJUXZ5TGtGNHRuWmhxLzdQOHNtUVA0cm83?=
 =?utf-8?B?M3pqaHNlVk80VC9iTjMwdHJZZmpXWHBGcWZnQVdmU0dGdGJZcUxzUEF2anEr?=
 =?utf-8?B?bkFVM3FQS1JwdllJRy9yM0NNcW1qMlVrQWNkLzNVR3lOOGRnVlJ5aEx1cnhm?=
 =?utf-8?Q?OvzVdt9bqndvKx6Kg3qHJZAbe447tQTTOWWfcES?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRCSjBGL1BwdHZCSUt4L3lobUdqWDUzOFpwVncxMldPU2Jlc2NkR3NMbFVu?=
 =?utf-8?B?Nm52RmJZRk41cmpTM1F4Lzh5RWVuUVhmNG5sQjUvZmdJNUpJNllBclB3bGUy?=
 =?utf-8?B?Mi9QQlJxY3hVUy9FTDdzK3FPSDVyV0FoVDNHTCtjSmQ3bzYvVDNZaEtWczFj?=
 =?utf-8?B?RGVLMm4wSlVaSFZIdTZPNU4vMks3Y3YxK2t0NERzNlM5L3M3WXNqd2svVytw?=
 =?utf-8?B?bjdnSS8zcVhrUGNuT3QwajFHWGtvSXRPNVNSdmdFU1V4VHd0NU11M1lnVDVO?=
 =?utf-8?B?RVFzMERNRzdsNVI4T0o1QXdnQVRGSHd5YStYVzVCWU11c21pU3FzVkFCalM4?=
 =?utf-8?B?cDhCenViUWNhekRSN1BoWWxoZFcxZUVqa3JBRVRzbHUxUisvYU1scWR3eXRy?=
 =?utf-8?B?Vy9tYWQ4WWNBWUpKa3lFYmhYK2JyZVBtSkJlamxlakNPbGF6bzJFQzVjeXdr?=
 =?utf-8?B?YWlEdnZsRGl1MlFFclFrK0hyYnJrRjhWelk5dFViWDZkZHk5K0VYYUI2M0t3?=
 =?utf-8?B?d0hrTTdNd29OTW5BUk5Qd0RkZ0taNVFrN0VPMTF0d1M1OFNBSTY2dWVVaC9I?=
 =?utf-8?B?Y0JHakxEbnd4eTVxY1ZIQ0VDNUpwa2hub3A1eWM2L05hZ1p6RTRlMjJMTG5x?=
 =?utf-8?B?cXllb2I3aWRYaXBmMlBsZzVYbVdkUGtUeThJWWFkK0hWMUx6TGFkSzFSYWlE?=
 =?utf-8?B?L0txbTh5L3Z5YXJFdUJkN2x4THh4L0pLSGhXLzNvRmpTL0FaTFNnUWMwdHhs?=
 =?utf-8?B?TnVJd2ZKUFc5bm5xRkVTa0JIei9RZThtcStIS1F0THo4YVNEZDladTlsNWpl?=
 =?utf-8?B?MjlGR05pY1hoU2dkVFdROTVQaXN4UzYzT25HczRMcTJtVjc0WUdQUkxvOFRZ?=
 =?utf-8?B?QVNWWlpRTTU3cXVXcDdUOCtsUFlZallvQnpTL1dCWWFxRWpKOXVhaTZrSDlV?=
 =?utf-8?B?ME1Ma2ZBd3dEbmdXaHRYeUxsVzBnTW9ZRzhXM0hQeFROdStYblhrSG1OYXVr?=
 =?utf-8?B?TFgxY1BKV0cvRmpJWVVMaGdsdkx2d014dzFZc1Q3WDJFR1RPWUtWaTJxQzRD?=
 =?utf-8?B?T0twbmZSZG92QTJRQm1HT0grZkVoaXE0WGpva3F5b0oyKzAyZi9oR1p2amZh?=
 =?utf-8?B?MVplUitpbnFyQ2xHeHNJRWMxdU16empPZ0tZaER5VG5nL09GT3dmYjdKeUtV?=
 =?utf-8?B?RUlsVUs4T3QxRG15T0ZKTEZqdlVRM202Yjd2ZW91dmlnSy8wNHV0bE5RalVt?=
 =?utf-8?B?Z3o4OEl5Z29wNmFlbFhhR3c1Y2krYTdDNlIvamFCaDZlcVAwTktqbnBvTzU0?=
 =?utf-8?B?bFlBYm1lYWZWNnRQdmNrVGFtMmkwRXlkNTFva0J4bGZxeG1TSjRaaWo1NDJy?=
 =?utf-8?B?SDI1aWlMbDVGaXllbDJHaDZiTEtFTTV0NVJTeEtOdUlsQmlKVHExajNUS2VS?=
 =?utf-8?B?ek9raXIvS1FlZWtSeHpoRXZsbGNrUHRYd0NpOTBNTFhCeExXMTQ1Mm93dTFC?=
 =?utf-8?B?Y0FsYU1XdlA2Q1FqSkxoZFdTYUNCZnc1M2ZTOFJBTE5CVkh0cGhXUzBUbEZn?=
 =?utf-8?B?WEUxb1NJUXZRSCswSlNqSmxJU0VJTEc4eFZkdTNxN3p0eTExWHRKZ3NLOSt3?=
 =?utf-8?B?RDArY0ZKdDVhK2MwcHZlRFNjdThrYnNQaU5MWHlFUzV0dlpHQm5mUENmWUR1?=
 =?utf-8?B?eXliK215TEV4cmphRkxsdGR0ZnRDRlN6cmkvdlBlbHVnL1dqZjZhRjhHSE9h?=
 =?utf-8?B?WDU1c0RpME1VVzJVcldZMHdMcFdzckc0WlRXdTBqZlE3d1BYRmd5d09OdkVT?=
 =?utf-8?B?TDFKeis5dW41ZlNoTUh3RS80SnJlSzFmejVYaE9IUlZUSFhYamhzaHR6dU9x?=
 =?utf-8?B?aUtDdURPL20yS3pjZ296bFF0T2xMTzR2MWt6ZS9ySVdSMnRBOVhBQlNTVmdk?=
 =?utf-8?B?bmNYTWpCUm12aDBzY2JTK2tyVDA4YW1KUjZuUjl3SWNQcUZLZlpBRGhkL3Fy?=
 =?utf-8?B?TzdmbUdETlBHWklrV1AzbklPb09MQVBFanRPNEJpTkQ4aHNxV3NiUzJYQ2JR?=
 =?utf-8?B?a0pacDVFd01qMCsyTDR6TEtPcG1JM2FLanBHQThXVGYyZUh3M1FhbjZaOXk2?=
 =?utf-8?Q?igASLeBb7XoxC+Rs+/D4aV1AP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdbb49d-61a0-435b-8dfa-08dcfe99fbe1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 19:34:09.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fz82+J65r4u7WUVWK5UOwPOR9FiUAr9eNzCMgei4AK/u+FfuqTH//v00g31gVssBW1NdQ/xqjDCvkiVWWzqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138

On 11/6/2024 13:33, Armin Wolf wrote:
> Am 06.11.24 um 20:21 schrieb Armin Wolf:
> 
>> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
>>
>>> Multiple drivers may attempt to register platform profile handlers,
>>> but only one may be registered and the behavior is non-deterministic
>>> for which one wins.  It's mostly controlled by probing order.
>>>
>>> This can be problematic if one driver changes CPU settings and another
>>> driver notifies the EC for changing fan curves.
>>>
>>> Modify the ACPI platform profile handler to let multiple drivers
>>> register platform profile handlers and abstract this detail from
>>> userspace.
>>>
>>> To avoid undefined behaviors only offer profiles that are commonly
>>> advertised across multiple handlers.
>>>
>>> If any problems occur when changing profiles for any driver, then revert
>>> back to the balanced profile, which is now required.
>>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>
> I just noticed that the following text might need to be removed:
> 
> "If any problems occur when changing profiles for any driver, then revert
>   back to the balanced profile, which is now required."

Good catch, thanks.

> 
> Thanks,
> Armin Wolf
> 
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/acpi/platform_profile.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c
>>> b/drivers/acpi/platform_profile.c
>>> index 568485e285061..b9eb25f58a2a2 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -10,7 +10,6 @@
>>>   #include <linux/platform_profile.h>
>>>   #include <linux/sysfs.h>
>>>
>>> -static struct platform_profile_handler *cur_profile;
>>>   static DEFINE_MUTEX(profile_lock);
>>>
>>>   static const char * const profile_names[] = {
>>> @@ -368,8 +367,7 @@ static const struct attribute_group
>>> platform_profile_group = {
>>>
>>>   void platform_profile_notify(void)
>>>   {
>>> -    if (!cur_profile)
>>> -        return;
>>> +    guard(mutex)(&profile_lock);
>>>       if (!class_is_registered(&platform_profile_class))
>>>           return;
>>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> @@ -428,9 +426,6 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>>       }
>>>
>>>       guard(mutex)(&profile_lock);
>>> -    /* We can only have one active profile */
>>> -    if (cur_profile)
>>> -        return -EEXIST;
>>>
>>>       if (!class_is_registered(&platform_profile_class)) {
>>>           /* class for individual handlers */
>>> @@ -451,9 +446,9 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>>       if (IS_ERR(pprof->class_dev))
>>>           return PTR_ERR(pprof->class_dev);
>>>       dev_set_drvdata(pprof->class_dev, pprof);
>>> +
>>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>> -    cur_profile = pprof;
>>>       return 0;
>>>
>>>   cleanup_class:
>>> @@ -467,13 +462,10 @@ int platform_profile_remove(struct
>>> platform_profile_handler *pprof)
>>>   {
>>>       guard(mutex)(&profile_lock);
>>>
>>> -    cur_profile = NULL;
>>> -
>>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>>       device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>>>
>>> -    cur_profile = NULL;
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>>


