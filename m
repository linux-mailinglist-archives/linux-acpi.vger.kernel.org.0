Return-Path: <linux-acpi+bounces-10489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B30A07E01
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E016188AA51
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66E188580;
	Thu,  9 Jan 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SZn3IJ50"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7C143759;
	Thu,  9 Jan 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441210; cv=fail; b=nVmPsdsI4kIQ5iSLXe81/DehURfR5Cg1KuWLVQdYt5AuCWPs3TdsPWK9lJXSZi7ew1Dno7mGiHiHulBU2flSXyadhGmfLiF/sy/IQ/6lPs1qpEONB0ZoeQ8rhqgl5FoiiHwbLr/VGDHsF8m4WnGRNqaVLC+QY8hK++4dtTIl2R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441210; c=relaxed/simple;
	bh=0wEbMq14Idw/6eANAny5F7VW3zaa8uOATnHoxx8vMdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABCGLMYiEw178Ewf3oIm2VhVSRUBgAtrJ6dfsdfrqbYks2tWvWhsWh2rG82sMSTLf4Ev9w5ruts7TENEa8EnGY6BLVRWaCVTadWvnt0ddETPjhiSa9lKBovd9lHD0REi2D0U5BKT+j6J6lFOTtBbmC8pwVXi43BP8JLPL5VHnOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SZn3IJ50; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud2SaM/eELXY/zfYal5ZXBVO3a6FhcI12pAEhC1VoihJs+O3ekJ422kbhU1aSxVoFUgF7NR2vxtwQAdPBk/gdyg3cVZgFyE7MKFbDIHOozCkrHtg76U2LKQrzll4evMtgOTL8iSOvo11s8MzRjYYHppW1xLhmgHsyBozi+gXwBfh0QqFkx+SboI+hONpolIYE2UlTRQWN2ORRE5T+4cdTsR0yaZa0z3kcOLar8vicshHOtWszCQ+z7YxmRsng/1TIJpgNuLj6TSVECvQ8YzfXBNxRWI4w7sHEsKozErjWrjx1QfyhxrYPWtS20PNmLd0LqIH6ph1tUDP1ofKesi07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qExnvm/WjPB8E5yrcmtwZUPb/iWOmyD8MzGvaPR4VkA=;
 b=G1D0CKYdd2psO+T1oCTuyKzDnWou2BNCXaV4XDHoRoW9huKIEFdwdzQQ5ARPfCLsghzVvlNOVJNT18ygO2pan+ZjEdf9lPKJdFjThS6MQlwukgzrM40HC0oNZLvnSXxJTL/EuD0j0o/z+cppJBCHjvXVb0AJR7GFGKA3P0oBuRwABH2aMpTDHQG0ZopGh60ERNAZrSrfg74x9TxvsFSOt/A3nQu2ouTUUvzdb//lVo7ARBiID7yy0nr6HFoOxISXWhijZY+KYflNt344WZ6wf/1TySlh0O0BhW/fresHezRAo2/ipI4cVQ7dcX8JInX/ktd+12KfK8AbS94i6mzgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qExnvm/WjPB8E5yrcmtwZUPb/iWOmyD8MzGvaPR4VkA=;
 b=SZn3IJ50Rzi7jb6widaRddjBRNIEFBABg84CzYHOhVlzo9QAG8/kDRmijM1Q/J68GnIxza2BXphLK70eTyPoris7qEvPYijrB6zmbuJmDpU0TNCyiPlXR+gpiGWE0XvKK1NXqfOkClcLAOKPp0FEK0zMSHCEkXBK/WSJZkYkrIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 9 Jan
 2025 16:46:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:46:46 +0000
Message-ID: <7e5c1183-e9eb-4e6a-8ee2-7003b60284e4@amd.com>
Date: Thu, 9 Jan 2025 10:46:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] platform/x86: hp-wmi: Use
 devm_platform_profile_register()
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
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-12-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-12-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d79e2c-f967-45be-e67c-08dd30cd348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkRTZ0JxbklKa0Fhc1gxOGlkems2VDdiQ090L2F4VFBvdGpXdmpsVmIwdm9W?=
 =?utf-8?B?VkZDNW1VcG9nMU1JV29ObHlqa1ZwQXcwblRhUUZ3SnNWRWlhUkRCbTJnb3Rs?=
 =?utf-8?B?YzgwNUpmekZSUHBudkZFM2pXbWRTWWgwRGcvak9WVUdsODdXK0JETHl2V2Vw?=
 =?utf-8?B?UmpWWld3UHlLNEI0UmZ6cHFjWHZYdWpEbEU3bDlqMFJzWlU0ZTFJZXJOK2o5?=
 =?utf-8?B?WTkzS3VuSFRLQTZFMGhwREdKQXhTeFpmRldsR1Y4UlE3b05WYmFmNVA3WUNu?=
 =?utf-8?B?TWtSbjltdmw3LzlJamZWaEUxWVE0NmVKTElaZGppRStBbmxOdDFyNFR0U3hC?=
 =?utf-8?B?bmtyMllDdXV0RDA3czUzYmJXM0RHR1RpdVNkSmhUTWZMT1R5RWtscDJNb1o4?=
 =?utf-8?B?V1E4cTBVZmNQNzZKWW5mMksrS3l2VGNpellvSkEzMXF5K2VkbGk1ZkFJWDZx?=
 =?utf-8?B?a2ZHaEtKRk5CM3craGhmeEN5bVNRaGFPSVVzSWREN1BHTExsdDUrcW1GZXNK?=
 =?utf-8?B?eXNSdUhmdDJ2bFl0dUI2UlR5M0IxT29XbXRQaS94aC9RdkNLRTRDSHFONWd2?=
 =?utf-8?B?NFdRMWZEYk5PR1pNU1RWZ0ZLeEFOLytQTGFPWUZ6RGZ6amRrRXBKRWY1cXEv?=
 =?utf-8?B?djBzcEZwbnk1REdjOU83L0lOUXFsTW9nMXhJT2duMkNuTjFTL2JucVIxWjBG?=
 =?utf-8?B?ZGhKWmJOMGJkbWo2K2VWK1ZvaGdBd2k1TXFId0VjOE0vQ2pqYUVzT3lwQTZC?=
 =?utf-8?B?SWRhYnFIc2h2ZWZ6dG8xWEluWU0xazg5OGk0N2NoUU9VU0YySnVna2IxVHZD?=
 =?utf-8?B?WWExL3V5eHBpYXI4Z2ExVUh0OXMwM1RXdnFnUmNua0VJOTBtRWlSdWpuckFT?=
 =?utf-8?B?WFQ3TllWZHFxaGU5NkRRNUg4M3FoMHc4K3QwY29uL0ExNCt2eHFWVEZ5cUJT?=
 =?utf-8?B?MzRxUmVPcEtLNzViWERkMmlSY09oTGt0QWxNajZSU2hNbnlKRTN0VE93WnNp?=
 =?utf-8?B?YnozMmtsVVRZTlY2SXNsQzlTemk3NURiVmJvSjBOeERLNUFmWEVGTlJVR2xN?=
 =?utf-8?B?VTMwTjhPT3MrZEcyK2EvMEplSTM4YTVycmk4MFQwYlIvOTdrUEVOejFWaVVx?=
 =?utf-8?B?dzFCRkRkMU1qQ0N3b093OVJXY1JJOFNEUllqY0JQQnhZZ2dRK0xTTTVLMEFp?=
 =?utf-8?B?OHdFMGp1YWVMRkJHL2hFMXlKUVd0ZHZWYkNFZWpPZVBQakRvSlpDSjd6QlhE?=
 =?utf-8?B?T2R0NEFvL0tGdHhwMzhlZTkxTWJjR1dqUDBMVGFFd1hzNE1rYzJXMFh4YmZG?=
 =?utf-8?B?WUpMaFVtYVQ1enQzcU9tdVFKU3VXa09BSDQ3MUs1cTE0d1ZYMjFPZDlCMklS?=
 =?utf-8?B?MmVuTDk3MXl2MGxoS0JEUmFHR0thcEp4K1BDSTF2TE9CWW1ybWd2Q3ZXajVW?=
 =?utf-8?B?NkNrcENNUEFXWE5Ibk83UmhiSEwvc0p6QlZXdGRPNkxkdWdXZExkOUl3SVFk?=
 =?utf-8?B?TlJHaHN4MmtRdXZiVzRjem1ETnk2V2MxcnVNWE9vZ1VFVllMU2dKaVRTZnFa?=
 =?utf-8?B?KzBEUHRBYnlxRElEOWZ3eHhZcXVZcnQzVnhxTFVmRVI0YXUvK1pQK1dnVDRa?=
 =?utf-8?B?QXR5VW5jOVFNcmlYVVE2TGtvOTlxQTNZNXA5STJZbTNJb3gwUjU0M3BidGg3?=
 =?utf-8?B?QmE2RlErYXlLN1Y4QklHUmtsbk5rUGo4a0dnYTRqL3ZXYkxQK1o5WStlUWN3?=
 =?utf-8?B?ODJXOFF1elhjQ2MzTU1EOWwrMGlORGdQUEs1TzY5djEwdXV3TmpsSGEwYW9L?=
 =?utf-8?B?cEcxMkdZNktod29BZFUxNXQwTi9CTEJFUnIwVDVCQzJtaGlpWDBFdlM3aWFM?=
 =?utf-8?Q?3c2Sfxz2P1EbA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnlsNEttRmJPc3hQeGxPc1BVT0xLMjlrWWFTZStVN1ozMHRxUGR1NmRRNkpv?=
 =?utf-8?B?cUFWajZDMWI1RVRSdEtQbFRaa1ROSFd1a051VHROWDdoZDNybWM5enE4VVcy?=
 =?utf-8?B?dVJVQkpMUlhYQ2dSSVBmOS94ZjdTNW1zSzNJcVhCR3FwSWZnVXFXcW1QRlRq?=
 =?utf-8?B?VTJKRWttMDRRS2FFVEtWa0VBRWZHY2Vnd2s0YW12V1lGVEM3cGhMZGdKT0Za?=
 =?utf-8?B?TjY1amdXTTk5QUlTZTBSeHZqSHFaMjBONTFRSFREOWRCWVJYdFpCZXNRa3I0?=
 =?utf-8?B?NFFOQXEwRmNJSldzemFqVldhamVsVU5rS2llZ2ViY2JMV1R1T3YwMVpJN0Vz?=
 =?utf-8?B?b2F4Wld6SEJIR0ljSlpVaEdRdmdkbmd4V3B0WXM4MVhCMDNRbkI0NzBkSlpl?=
 =?utf-8?B?T3ZCaStYSXNnU2N0RlVNMy9GSys2bHRGelVSNlpIciszMEY4aUdrTFJwSWpP?=
 =?utf-8?B?YTRVWEJSTEVRMGF6T3BiVWxrQW0zN2VUQThZRVRycnJ3dFIzeGE4My9oNFRY?=
 =?utf-8?B?VVNnejBhNEx5eEcrRjhSYTJ2c0xxUFg1Tml6M1orZDF6MThNVWRhL0QvTEo4?=
 =?utf-8?B?Z1pZRUdtWVhuT3l6V3greVhOa3VXK0ZnTThOZmsyZmFJM3Fydk9HK2lNUWw3?=
 =?utf-8?B?NDJrYTQwYjFnV29NR01JeXRqbloxcXdGTm0yVllWbG1rN0VGQUk1bmJ1Ujh0?=
 =?utf-8?B?MHhEQXJ3ZFZLYnUzOFBIRUl5NVBhTnRja0diQ2VvWDQzb2x5N1ZGaXFVNkFo?=
 =?utf-8?B?V0VoWkZrYnFnaFczYjhhQUN3M2FuRUtjdFVUa0lqR1JROFltdjhTK2N4aS9o?=
 =?utf-8?B?a3ovZC84cUZoUUtPaTY1ays3ejVBQ2RrQmpNc2hRWGtKTVRmaExRM0prUGNJ?=
 =?utf-8?B?aysremxTRzJHc2o1WUFTK2dvNTNsbGlrUW9LaTkxTko4enlGR0hadTM4Q3FP?=
 =?utf-8?B?WjB1NmNua1ZWZUtySTgzakU3TUlKalg1YW1GaSsvdUNmR3ptK2ZVSVY2bEtF?=
 =?utf-8?B?VGpDYUlMTnFiRXBHTmZvQTMwQjE0bjBjRDl1RTBpdkRVK0hzaVJQbS9peFZI?=
 =?utf-8?B?YlcxMUZGVTlzTGRhWGl1RW94UXFUSnFuQTJTSnFXR29td1ZoTzI5K2hGbE9x?=
 =?utf-8?B?N0JyYnBKTE9pNytlMnN1blBvSEc2R0hQVVBmeTVFWWVla3F3ZGYzQ0lCS2h0?=
 =?utf-8?B?M1ZVcCtpVHp5ejJncURuTTF4b3krcHZVUjA5OFlxRklwM2FERkdUWEpHRHJk?=
 =?utf-8?B?cnB3TGpsMks5bEdNQW9jYmkyd0psaUlVRWJzbGpON2pVcVNpRDZhTTlkQ1J3?=
 =?utf-8?B?ZTRQUHJDWFNLb0hUekRrRU5CbmptdjViMklOaXNDbHhZWUh6MXpmWE9SOGU5?=
 =?utf-8?B?L21zeXRYYkJ5eHN1aUtwV000VGNWdjBWZ3dpRVYvY3R5eFN2YVQxUENEYlNG?=
 =?utf-8?B?dzJ2dndydXMvcVRCcDRFT2NzTGhtT3NybHpBZXVWUURqYmQxNk5jQkcvcWYy?=
 =?utf-8?B?alY3R1lkS3JxZmlPTGowaVdHUjUxbWh4Y3JvTE1OSG9rRlk1TU5pRnUwOUVx?=
 =?utf-8?B?NStHWjJpcFFyWkRFZGRmSHU2M0NFTDMwaCszQVVVZW9ZQ1hESmtqUzJOaEVj?=
 =?utf-8?B?aFNDT25jeEhNYnZrbEtNZWZVWFA1NENVR2dHRUJ3N0VaZkJROUlpZCtqTDRL?=
 =?utf-8?B?RFk2Ym56VjZmTjh5dTNScFdVL2piZFBBdWY3RTJhdTJJbWpQdEVXcVhWZHd0?=
 =?utf-8?B?SXZnMHV2c1FiVkxFUnVQN0l6bW0rNmwrWHJSMWo5Rmo1NUUxNVhqQlpYOFlR?=
 =?utf-8?B?YjVMeG9OcHNRZTB6UXBiVFBqN2NLdGdKMXRodjhDc0xEeWs4QnpWeGZobU1p?=
 =?utf-8?B?UEN1dUMrWUc5UjllMlFURXpLWUNETzkxRmJVRXJmVXBZSk9GcEpZZzRZMkpP?=
 =?utf-8?B?WmlPNndPRkdJYzNDZFg5Wm5FRVlSQ0NXMHM5ZjIzUFZwSzgyTUEzdkp1OG5Y?=
 =?utf-8?B?TjVRUHhQRTlXRzNpK2NhN2FqbWNCaEdHZnZWL2t1ZTJUY0xyU1hBVXl2dytX?=
 =?utf-8?B?M2t5Q0VSZHhnYjJzeVpvZ2NxQTl6VFZ3QWpxd0hOK1Frdkt4eTNKMjNJcTJX?=
 =?utf-8?Q?GPClmxouS4eY7Lo9rlfl+AHzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d79e2c-f967-45be-e67c-08dd30cd348d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:46:46.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laKlcd87bGoktZnDxlH8PHXH8a435aM+BHIyJAbT1j0+yfy+Mmz06lTEIaVl9D3mkmpzNEYSRdYscJJf8RHURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello@amd.com>

> ---
>   drivers/platform/x86/hp/hp-wmi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 2cf1da00d5f9..8a620d36f926 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   	platform_profile_handler.name = "hp-wmi";
>   	platform_profile_handler.dev = &device->dev;
>   
> -	err = platform_profile_register(&platform_profile_handler, NULL);
> +	err = devm_platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
>   		return err;
>   
> @@ -1714,9 +1714,6 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>   		rfkill_unregister(wwan_rfkill);
>   		rfkill_destroy(wwan_rfkill);
>   	}
> -
> -	if (platform_profile_support)
> -		platform_profile_remove(&platform_profile_handler);
>   }
>   
>   static int hp_wmi_resume_handler(struct device *device)


