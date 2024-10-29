Return-Path: <linux-acpi+bounces-9083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8E9B4F70
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797DC1C227D2
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E019B5B1;
	Tue, 29 Oct 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uefamZ5M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92C192D68;
	Tue, 29 Oct 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219782; cv=fail; b=Yku4c9b0Z0niaJC037NP4Y4YjixZ28UUMDob5AKvDXgSJ6sQf9nRzz4EGcfb4ALzVR/NtnV4T6kYe+LZzl2nleiHdRnPrmKaKaLg27N801CtcRY0S6YR5KKE2tVhIUVwkbu8cwYvECGUVdOMy8KcL75fRLmw2EJHkZcyJD9oeEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219782; c=relaxed/simple;
	bh=4bestx0TpAUToclOvHn5mIrGFyuAnxT1Y8RpJ655q8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ysgnsf0Z+AbpuP8wJLwN7sQc0BZ/oYpQEvPieE17CcqjYPd07vcAZQ5tJjoEpqvdE90RVji+hSmeHMEqho0oSPL7/HZNpt4jWoCp8wi6okrB58EQuH9x+eDYKPKcbrZCXkP+QB9PIZDyGNk15cXofjgEKsgsvU2nkvuIak7H9uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uefamZ5M; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNgS6r06R/htB+g067ehN0M0PtCKJl4je+3UPGTmCmjwWFGvWP9FPNVbSIcLFLfy/MC6rvDx0RQt+4LFcWtjScxxahYNO7fv/grP7eT6pJrGqpOhjKoz9HJ7Z8Hk0ZOXE9t3VH/o8Gx3ex3W4G+AJYR5tP6krGr3b0E99Nzh2F/RsRo8l6gVgirQcH/Q8sHIyt9WyvwQXrE7E/qRtc1hkXD54SkjSW/it05wgYq4hTMgxi3/3j7CpB5gjlIqeoFq6OgGgQTBvcbAJcukWw+c7x1V3QDJkZcJt7LWscmRuCfcob4iG4gs+QL+wlnO96MGIWMlKy8BWsI0wRqu/uDOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPSzUz1m1e/se6dUK5dAAmuZRDUxgUWAISpUueNBq74=;
 b=aSaZylBD+ztRtZTHIRp8Nm4JTg5fFCeSg1nglDkL9xZK3b20K4PqGx2dsOuICE5rfqCR3yR7+t+UXnkoGDE7vhlViGxCh6Vti05aVcefaKAZwBvBg7cXIJZJSYsUD2+9myDN1fFaDkAQGRjzV5YgJ0XuEMnW+J4yUX9meaEOGJ8wCjdtH98Pr4Mu3jp5TXjuRwmx1iHOhieN2q3GVeB1M3VDHgXQRcq2/GOGYoqCui++x0IFRtwxge9NYQ0LYzg8pRiyWC8IbVw8hAj3nO7SConyFSXUV9k7xnmkXPtJQ76yfF8x3/0k57/1cKqI1be/zkqmJ8v0DFmSixJMr+sxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPSzUz1m1e/se6dUK5dAAmuZRDUxgUWAISpUueNBq74=;
 b=uefamZ5Mf+1xwzDLL5ogvYH6lcVVQXYCWu6dHefywCyz/TFCV6UeGAssjzlw0LjdHW6TbJH/wuVJ6VB5Qdww4YvXCAiasimzuXbhFcUvFyDK9EeEhOQPBbctDGRB+PsQEKtKDzuM4gLOQZN0K/muRVEBYDZS37OtIbzrGT/CxFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 16:36:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:36:15 +0000
Message-ID: <3fc47497-de43-4d77-8352-d6c0886e2db0@amd.com>
Date: Tue, 29 Oct 2024 11:36:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] ACPI: platform_profile: Set profile for all
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
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-12-mario.limonciello@amd.com>
 <46e19bc3-2624-f4b9-a946-050c92c0591d@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <46e19bc3-2624-f4b9-a946-050c92c0591d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:806:122::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e4ba9e-35b8-4ec5-2ed4-08dcf837ce66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWRhZTBSWm92d255TUl4MUs3dzBhY2JMRmtWKzBsNElsQmhTdXk3TE1qa3V5?=
 =?utf-8?B?WUdRU3JNS0FnSkY1OFFyRC9pcHlWQmFsZUdDS0RaOW5HNGkrb25VNUdsMDlG?=
 =?utf-8?B?d0lnVS9hN0JaT2NIWGZKZFNqTE9HQ0lLU0xuMVd5dHpHYXhGZ0ZTSUdZbVB1?=
 =?utf-8?B?aXFKd3d5aTFyOEFyRHJGQ1pWT01ZbzZVeFdGTDVPR2p3K1V2a0QzNXpkQVlV?=
 =?utf-8?B?WXo0Ymp2bTN4Y1ljaVh3c2M1cVh4S1drQnhpL0w1cEphdmh5d01yVlRqZUNL?=
 =?utf-8?B?WHRsVFBENjR2ZkYwWlFlOWlJRm04Zy9ZUlZGb0pmV3UrU051WURGNnZSWFJL?=
 =?utf-8?B?OXFlMW9GRGhyOXF6aU92L3NjL1VPTU5XZ2dTNUVWb2d3b0ZQb1RHQmQ2bEFT?=
 =?utf-8?B?MmoycmduS1ZleGRkbXQwdk9EczF4R3NDT051UmVlSDJlQnpGZEh0bVFEOE42?=
 =?utf-8?B?aUliQ0tZcjdpakdPV2xzeWRWb216UU1CSGsyeTM5VDFER2c1TngvVWVnK3pI?=
 =?utf-8?B?S2lnNDdiLzNLNG0rZmtzVDA1Njl2SmUyYjJOanFmTmY2Z1B4VmVlaVB6eWNZ?=
 =?utf-8?B?SEwwS1BmaEJ0clBFRFJBVWhROGluQ1VhRHQ1eGV0VTlJVEtNbDJEcTkwTk1Z?=
 =?utf-8?B?UXgrUVRZTStsNEtQWW5Sbmw3MEM1clZrVk9pbzh6b3UvRXQvNTdac0FwS0V6?=
 =?utf-8?B?VHZCaW1qU3pxSzFuRGRuN05Qckl6blJDd1c1QlJNTWpRaWtMMjloSUgzUTc4?=
 =?utf-8?B?ZTl2S294Vko1VVNFTEJSMEF6R3FlenpKZEcwbDdlSVdLYWpTanY1Y1lPeGxv?=
 =?utf-8?B?THFmcFYzRFpCQ2xzN2VJUTZZSi9vcXVWamFFdXJyNFV5WXNYdE82TnRJSnl3?=
 =?utf-8?B?V1M3K3NhWkVzdnk1a3Z0bXE0SUNsUnBUVUxySGFibHljZytWOEtMMmQrR3Va?=
 =?utf-8?B?N0N2R2pmb0tYVGJSR3BqZ0VXeFBOZVMzTDBoeW13S0wyZXF2cUJkT0llT2pZ?=
 =?utf-8?B?TnJkWHVyejBBc2xrOTFyQXZjUGVqaDlSVGI1NUpFMFRRY0piNHJ4a2tBSWNW?=
 =?utf-8?B?SDVmSWlqeXhEL3htNEtWTkwzVVlMNVJNWVNqQnMrd1lrWDZyNmhpdjNVQ01r?=
 =?utf-8?B?R2piZkk5ZWNab0pLSFJKQ3YyanJqVDJtVVJoS1luVU90aXBwZnJ2eGxyeCtp?=
 =?utf-8?B?bS9RVS9DK3VrV01oZWFFTGpXRkp2UWlxRGlHZHVoMk8rb3dKN3FVTWlKUmxH?=
 =?utf-8?B?NWR4eWZGQVJiWWgzWkErOWgydEx5djdZZ0IzUno2OWJuOE1ONFlsaW1qUUdQ?=
 =?utf-8?B?eTVFVko3Yy94NUtEcHF0RmN2OGJacDBxZFdxWFZ1ZE94QkRLVVhrMzRIYUVL?=
 =?utf-8?B?ZWExa3FIelU4ZGs0QzY5eUJFT09tdG9pRmdFdXNyZXdkVlQ0dW5BRjdJNDZz?=
 =?utf-8?B?bkI3SC8vWE5RWittdURKeFpPa24vRFBjOHdHSVR1NkhLNEpnMFl0SVFPc2lO?=
 =?utf-8?B?QkEzRjV3YkRhQnlsQzFGdGRrd0RBUEhOUXl2ZkpEQ04vNHlVSWlZU1ZIakFB?=
 =?utf-8?B?ZjJUc05UeHh0SGpBNHFoblZPcytBS1BGUnRsTklYT0IwcDV6NnFQV1lRcFZk?=
 =?utf-8?B?V2hVL1J6UStSY2t2UHU2SS9vRUI0Ty90MHAySlNBTkRGYzAzcnhoUEtVdkFU?=
 =?utf-8?B?UW9UY0cxQXRZc3JMRnZ4emFTbUpWenpUU2hJRWtpdG9kekgvVCtpaFU3cnVM?=
 =?utf-8?Q?qGaBosnmOuX2lgQNLepu2Gbki9wRi3/BZs+r80H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2Z1V1huaWJtalpIM2d0QU1xUW5maE9wUm5nTjBvRkRKMlNwS3JHMnFXWmkw?=
 =?utf-8?B?azdWbS9tRnBDTWZUWXY3dFpGMm9xUGd0S0xEdEZWRzNtT1ViSkZlWnp3OFNR?=
 =?utf-8?B?Q1FuSzJvS1lmaWV3SytqZ0xhSjFVenNVSDFOMVJPZ1dDMDhlS3BNaDQvK1JZ?=
 =?utf-8?B?SUlGOEE4c3pqYnJnN1RrY2xSeStvTVJqSzVXMXU1WEUvY1Z5dWNCbWJZcGRM?=
 =?utf-8?B?QmRWRllSckcycXFLWi83TUtkc2Z3MEF5U2pLVXhJeGtsMVpIeDB2QzZQRlVU?=
 =?utf-8?B?c1NVZUdjUmFZckY1THY2QW5FaCswSlRWRVlPYnZVZ2xtVUZqbkt0ZHNGamta?=
 =?utf-8?B?UFZYaFhLZ3lhOTdUeTJrNEZIeHhDakw1ZC9IYjIvYUhRNFJIQnJVWVF1Qmt0?=
 =?utf-8?B?d3F1b2VwOWZCaDJDRWxoUGlnV3podGZjdzZOYzRtTHVuRm94WDY5QkVsOGxR?=
 =?utf-8?B?M2o4Q3gwYlFrTXhVQnpHMzB2WFRCdERHY1FsUEpwNlprZCswbkRsME5nYVEw?=
 =?utf-8?B?cDhLMFNjdmg1Vm1TeXU3OW44aHBOcExlTVpHZHpyMmFIb0dON0xQNk9PNHl1?=
 =?utf-8?B?RFphbEY2ZldOdlVUZkxadE9LZkswMDBTck1PVjhOWjhKRjhXdFIxRnBNcU9B?=
 =?utf-8?B?V09icTBFckd5N2l4S0V0aGV2a3NpSHR6dm5UdG9JSEMxNDY4VUoyVFBlSkIz?=
 =?utf-8?B?K0FOaGZaUHRwNTVxR1JIc0hBVk9YVjB0eHQzMUFqV1RHT3BHNzk3a0hFUWd2?=
 =?utf-8?B?UUt1Um1zeWs1WklLRm05cklwSG1YTHZMdWNHMmNPR1B3NnpSK1h4d28ycjNn?=
 =?utf-8?B?WkdqY0pFa3Z0VTRjUTlubkpHK2tVbUYwdnA1Wkh4VHh1aXREY2IwaHlYQ0Vx?=
 =?utf-8?B?MkhWUTlVK1hXem1tK3pUQkhVbmpYdDJ0QjkwTEIra0t6N3Z1ZGxPem5tbENn?=
 =?utf-8?B?R21MNDFYOHhrNnpjRFdYeGNYV0pKL2lQaWt0dW9UTmdOLys3SGtQb1h0NTY3?=
 =?utf-8?B?ajljWmdZSWxoYlcxQlEwb2VSdGFrTHJUNkx2S3B6cy9IMGpCODFzOVcrWlNY?=
 =?utf-8?B?czlrTVljKy83YjdPWDZzRTRPT25jWnh3cm5kTGZ4aWxoRjlITGwwNG1TcFpK?=
 =?utf-8?B?S21tenI4bFYvR0FwMDNIZFkyaCtKQ3UzcWs3ZkpyeFFSSEN6djRueitQZXlo?=
 =?utf-8?B?L2FLbWczb0drV1BxcTNabnJKMjZtdmo5ZkQrZ3RTUVhQaDIzMjlxcEpUanlJ?=
 =?utf-8?B?NEV6eWc2L2lhNnVldXZVSTV1QnpkNlNBUnl6TzVUclcraGRBdXVPV01IeGVY?=
 =?utf-8?B?dHFDVDJ6K2tTd0lNMTViQ3U1ZkVtdVhnVTdrb0R4S2R5dER4UDlhVVRia3Na?=
 =?utf-8?B?eUliMjJDOVRWTkZQSUJtbzJkN0RucDVialV4U2FXTnNvSUgzZWZGd3o2UW5T?=
 =?utf-8?B?SStTVFNycFRpR2gwRXRNWGlpMHpTRTlza2pyd1IyTnFlTC9RWksxUkVSOW1a?=
 =?utf-8?B?ZVpqWE1DNHZxNEllOUZDQjZWVk5yZXFOUFMrZWVYaGVPYUJxQzVTRDQwYXhR?=
 =?utf-8?B?YUxLckRjWDduNW5zNUh5RTZjL0xuOG5tM292WlV3Nk9YWDRvVDEyM1IyQ2Vy?=
 =?utf-8?B?ekJlQzhxcG9pMzcvNXd0YnF3dUN4S2xhdjNVL0d4WEdkZ2pPQzBNbkNaYk83?=
 =?utf-8?B?Y084bmNMK2IrMjlsdWNxSHRJOGp2dTd5TWJIR3NBWWNidE12RDBiOWo2SHN2?=
 =?utf-8?B?Z0hoNGZZelFLcFU4ZXRQQmlrMzM1bEFVSG5oWmhGRWEvdHBZbnZpeUtLZ1hq?=
 =?utf-8?B?enFPY25UaERTd2VXL1ByZTNmZmlQVk9LRkhBZXQxdWxYcEZqRUtIUHQ3djMx?=
 =?utf-8?B?N25UbllDQ09TOURZUWhvU1BwcWcvOWt2RjEyZ0RJMHI3T044dUlkVXRjWC9Q?=
 =?utf-8?B?bHVEbnhvaDAxMUtMTi81N1pabENhajZOU1ZGQjZ2WlNGNDNYRzYwQUppOUtq?=
 =?utf-8?B?RmVDT2tzZFlLd254aHJETnZUMG5uQnIwcEwyY0FOZVFSRUF6R1AxeVkxdlVq?=
 =?utf-8?B?U25zOEFKeWRxYVY5ZVVXNnJ3TjhSbllIRExzY056RkIwSUJtc2dtUzBVMUFT?=
 =?utf-8?Q?B4koG04kLQuFlxq5CyA2xj/Rn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e4ba9e-35b8-4ec5-2ed4-08dcf837ce66
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:15.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0vk58K7jsElIfXPwViRXwBJp1xXdeB1PM79MKC+c9jyXgk5mdUhdq7nQE07FFXb29Y7VLqk5vNPaxY8s8bQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

On 10/29/2024 05:22, Ilpo Järvinen wrote:
> On Sun, 27 Oct 2024, Mario Limonciello wrote:
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
>>   drivers/acpi/platform_profile.c | 47 ++++++++++++++++++---------------
>>   1 file changed, 26 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index a83842f05022b..db2ebd0393cf7 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -105,37 +105,42 @@ static ssize_t platform_profile_store(struct device *dev,
>>   			    struct device_attribute *attr,
>>   			    const char *buf, size_t count)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	unsigned long choices;
>>   	int err, i;
>>   
>> -	err = mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> -	}
>> -
>>   	/* Scan for a matching profile */
>>   	i = sysfs_match_string(profile_names, buf);
>>   	if (i < 0) {
>> -		mutex_unlock(&profile_lock);
>>   		return -EINVAL;
>>   	}
>>   
>> -	/* Check that platform supports this profile choice */
>> -	if (!test_bit(i, cur_profile->choices)) {
>> -		mutex_unlock(&profile_lock);
>> -		return -EOPNOTSUPP;
>> -	}
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> 
> You made guard() conversions in the earlier patch but for some reason
> left scoped_cond_guard() ones mixed into other changes still. Is there
> a very good reason for that?
> 

Using scoped_cond_guard() requires changing the indentation which meant 
a bit of back and forth with code coming and going.  If you think it 
makes more sense to split up even considering the indentation changes 
I'll do another set of patches for the scoped_cond_guard changes only.

