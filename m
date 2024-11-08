Return-Path: <linux-acpi+bounces-9454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7199C2587
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9BBB247AD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B51C1F1F;
	Fri,  8 Nov 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w398Q35M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7971AA1E9;
	Fri,  8 Nov 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093941; cv=fail; b=AZ1GBAgcUOxwg/XHV26GbXNA7TRdaJbJVdxxj6yH2TdihgRnPoCSbsGoKtl0P0+4v6O+hq53RK1IwUNoMq/iJzmMeQALJvr749jds6qoTGb7OxPy8n0ACUMnppRCXDwg93sFANMqF97v2y6m/3el7RNsZEHth0CZrkUknUbayIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093941; c=relaxed/simple;
	bh=Ag+/uK41nmhUgxkHBcppWjjmC7mAInHIxdV/zTEHNQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pjTNlRsBh7u5SsNCTJ2zoGw3KVawLyz53OSiZ+MHh9k3rCfK3MoA9LQG0X4/1PJfKZgWLUtYtMHux+T/n9HoKzCupUFKeqU3dn7X6f3NDhPcr7D3xrUd3p/gVlC2FGR+tKVBhLwHMHI9WhSJa4ANEwYt33aKtE2TIE07X0Br5XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w398Q35M; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dob5Xjhh1SA5BuD2DVYJ+UxBO1dyKsPcst8Og5B5wSn86yzhO4TV+5Luy/MWa0WjuBuEYfxuvgnEioikPTjC3rYas5/qcVuJ+LyaLveIATc6PVrcm7T9NI89N8hJYen44Zbtw3vBTEaYyMai0z5Mqzb5aVy4MmpYzQovebB4w8bAOC+SJkY6mLdy01aBthyC0tEFLZpurv5E/seF1XYi7Z/DmiEBOyKIkanJCJ7CAlE+KXqCq6z4Ge2f3MfBeQHYSPa/hvbNEWdMnPYrJ/g47FeDRBJQYXYIgFduKmOD8A7NbPl8EF/+f5SjstBhbc/pTQRQI/AmdV6QeIVrLQdBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBdfhmzHBn0R9j0IWZVF4cpZsS69Vh0gmju8fhnJOqs=;
 b=nHVMjONnU2ct2HO4anAxO+0TOsKMgiGXsr/kES5m6m4WjD9FMjjmIePTSwdTmiH1HTrFALO9+EZoVTjMNfwPhnlxLNAlZM+vJc4lpu0shDRH/sGt75RGcV/YjZM3eB59Y/K9pLJq2LlN2XPIbENqU50WxvvArZWMNsCTIcBh9DuJZUmhXPTBt2J3YC5EslG5ALP0E97UA7SICBEWZbG5Nfb+NJxqQ3LBaCf6FSq6wr6UaJuQj+Uac3CTbnPWAfwK907cfXC3mM3jKR5OLWgaEDv7EStZ42vNcTrOOo+e94Zin3/uwk4ZdX49nLvYo2H65kPgPo9/xQ7iNCegDw54vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBdfhmzHBn0R9j0IWZVF4cpZsS69Vh0gmju8fhnJOqs=;
 b=w398Q35MBIvglKkpXaMGkflf1Dh/bO/7Lf/Y6fDNK2x/MAkqBL2jSV78Pz33CmY2+KcZRWDp/o8ts//fa4JjM4wGnZszVkMqcLPnQA67IqdF91r1h2zO9/XwZ2BJalVlfQD+90/tbyt8HzG0ljKAXQ6VBAyg2imcFw7wDpQFv9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 19:25:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 19:25:36 +0000
Message-ID: <22fdc5d1-c082-4e60-a6c9-c67bad295fed@amd.com>
Date: Fri, 8 Nov 2024 13:25:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] ACPI: platform_profile: Add choices attribute
 for class interface
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
 <20241107060254.17615-12-mario.limonciello@amd.com>
 <7e302f04-cb4d-4ecd-b1a1-4b89f09e692b@gmx.de>
 <9dd1709c-de87-4aa3-aa33-8a520a305545@amd.com>
 <0ffe9b8b-814e-4b5a-a960-22797e327b4a@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0ffe9b8b-814e-4b5a-a960-22797e327b4a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 629ccc5f-b1b8-450f-5e47-08dd002b1f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0M5ZzE3MVJTR1RFakJqV2N2d2RYa2g1R3ZDamR0OTU2YUFuTWJ6RkhEUGFj?=
 =?utf-8?B?c3hEVkRsWk54cmVBRSt2dDQwNUJMRmdMTllzU2Rqb3pyc2ZJK0I1NThVQ01t?=
 =?utf-8?B?RE4rRkhjNGFDNEkrZ3dpVCtNcEw5N2FGaXNjNVF1djFURjZGU0xST0U1WXF3?=
 =?utf-8?B?Mll4TE5qNjRnZzgrYkI3WDVqbGd0QzZJRjBENXk0U2tiblZLcHdrcGZ6K1hL?=
 =?utf-8?B?Z2FmRFA4QmxNNWtHYUxxOTVnaHNndXVSWW94OXhCeDM0L0RmY205TEVCMjE0?=
 =?utf-8?B?UkpVUFdOSDFLZTFQV3ViRTdMY3Y5Z0h3TXFtYmhsZnBaVEpUalRtNlJOY2pE?=
 =?utf-8?B?eEpKQmJ3VWY3NC9QYWNJSlpXamdLdDVhYmRVdHVSZXU2M29OREM3SndCekZW?=
 =?utf-8?B?Wm1YTzljNHlkY2ZNUzZqS3VlbUFudmsxNkdjaHpTZDIrdURaN3I1WGx5Q0Jr?=
 =?utf-8?B?alF4dkY4Y0ZNeXBxMWtSdnlobVB0am0rbTVlc2dSeEcxcDUzVXhrTVNtWnIr?=
 =?utf-8?B?M0t2N1o3VndQKzRQZmo2WWxNaUc4OFJzYUJPbDNiZHErN3RiVUQrblZ0ZGZY?=
 =?utf-8?B?SWtsWVFuYVp6ekhvb3VhRE1SRWZCaHZtL0xjaU40VzFTaEN0L2ttOGZ6Q0lO?=
 =?utf-8?B?VEEzZ1dlbkpUSmVuR0N2WTdnbzhETkt6Y0pHRFF6SUNwS3A0aEl4OHVLdDBt?=
 =?utf-8?B?cVRNZGVmTmRYSmpFWnIwYTJXWUJXcGV2ZUpJK0QwRHhSd0VFa0lSejI3ZTVU?=
 =?utf-8?B?NkZjTExNL2lDVTJrN3J2QXN0aGh1cWNTNTZzc1U0Rm4zOGxnbXRnSW11SnAv?=
 =?utf-8?B?STVOTzlUbTdRTUo4UW5FdDhOTXU2R0RZajJURzZhWERnUjRpTjRNaTVaVFc5?=
 =?utf-8?B?eVBVUHNlRWxnV2JzTjRSdkRtNmdBS3V2Ym12cjYrNWt5bVFqQWorOWhWODJ4?=
 =?utf-8?B?RW1aZnoveUsxeElTWURxc2daSDl1K3k2R1BQbjJOenE4V2tuWDE4QlM2ZVR4?=
 =?utf-8?B?QmU4cHpMODhHN0tJb2twbkw3SHU4T1ZWMHJETGM5M0VudGdFSUllU3RWUG1a?=
 =?utf-8?B?aCtEQ2pEbG5ZMGg3ZVFFV3MyNWlpbVhDQjhRWU1McEJERkZHSG1xN1JZZWQr?=
 =?utf-8?B?Znc5ZHA4K0RJOEljU2s5Q2ZpNGNJK1gwdndhZEJ5OE9MUmtrN2NRV1A0eDlM?=
 =?utf-8?B?bjhoN1BIWjdlUndXY0J2Zmw1SDk3cXpPenc4R0JiL2FkbU51NUp6ZFU0RTNi?=
 =?utf-8?B?K1l4ZnJMbXc2V1hpSGpkNFQ1WjZsMnBBMVBDRThPZlRtRjFUSDdBaGVZaU11?=
 =?utf-8?B?ZXBJeDRWbmRWeGRRcXhvc09yc3Q5ZVpXSEtncjFDUHRVamUrdUtDdzc5MXlu?=
 =?utf-8?B?ZGVWdjMzdXQrM0pSWmtWbTBiMTIrL2ZGRnRQVmhQaUQrT003WnV1bkgxZnVS?=
 =?utf-8?B?RFQzNGdrdytQYkpVamJ1Q2doREdCWklBcytQRGFHQkgzRkRFZGt1S2dScWlE?=
 =?utf-8?B?ZWo4V2dGM0F5U3JraEY3LzQ4QnpHRm1tVWw2NTdsa3BFNHhOdktlS3Z6WEZD?=
 =?utf-8?B?VXFvUjd1UCtVLzE0blJDQ0pTd0c4UzdkdnduMUk4b0FLanZvWi9oaWtBWk5W?=
 =?utf-8?B?ME5jZExqTkl6Z2YwSDUzVExHTGg1TGtUcThyYTl4VFNBcDR6N0QwUm1KWTZK?=
 =?utf-8?B?YmJZNnVkL1pqU3AvRjlJdVk3dEYvTG1uUERid0FXZ0NIakprNTJYaUM1Y284?=
 =?utf-8?Q?s7BuLlcA0pMQfuNaAE7t5A63JKszGSFYf5hhWxG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2V4U1BvWThkWldCdHFMWVNuL0VZVjRJc0JlSnpkL1k0QWcvOENSZ203Y2lw?=
 =?utf-8?B?U2hwbHZiZmRoZG9aeGNydFV4Vnd1LzdwdEU5aEVmN2pZZG5MZ0Z6a0hPcUlp?=
 =?utf-8?B?YnZVSkhKM2ZlWDZtRnFiOEdXQ29lV2h6RkRHOVlaTWpNeWdKOHlCa2Jpbno5?=
 =?utf-8?B?T2RyZ3QyUXJkR3BpSVFxM3orbXh6MGZFQWxJY1h6Z1Z0cUx5VVJZWTAzelVF?=
 =?utf-8?B?Z2dvQ25Rc05oUFN2bU0zQ1FVbnpjbFVIeHQ4NFdCYm50MFVIT0lnakxYdVN0?=
 =?utf-8?B?TXNCUVJ3RnFuVFVaTzlzMCtRaElkUXk3RFBzVFpQWkJDNTcxNHRlSW1uTmpJ?=
 =?utf-8?B?R2ttalU0eTJTMnp1K3Njdlh6NzgvcXZMQnpYWnBndTE3clM2VHBrRlAzcCtR?=
 =?utf-8?B?MzRHRWJXUzVuSTAvcTV4aVJ1Q2dJWWtYNWNYTW52TjFoOHhwQXJseTVuYkUx?=
 =?utf-8?B?am9oRmtCQnpCVnFHa3BGWFc0Qys5QmJjQ1hjWEJkd0c0QzdiamhvSGtmWEdN?=
 =?utf-8?B?emZZc2NYZUU4VktCRWZvdlViN3Qzbmx2UEsxOEZvQUxTSVN5ckZoMktsdGYr?=
 =?utf-8?B?bkMwVGFVK1VwQzY1ZlFMYU5MR3kvZWk5T1dFUS9YU1FPTDdzVjBGTEhsbEZK?=
 =?utf-8?B?NjhJQXhEL0RFbU5oOTluM2QwKy9XblJhcitrZlRoZTE1QzdVbUg4dktia3lp?=
 =?utf-8?B?eS94eWVFVk5sdzJnbzNscUg0UUoycjAvM0tIUWMrYlV6Unpmb2NlanY5VlQ3?=
 =?utf-8?B?VGZWcWs5ZkRwRFQxSlVLSDdad2NWS0UyK2Z0TjZTZncvb1V0dGFtY0J5ZFJU?=
 =?utf-8?B?VUhzSU44WnV2MS9CNzdqUXorTWFjNUp0UjR5blJpT0VYQ1hRdEZqaVQraTZB?=
 =?utf-8?B?WDlpNVFCNjJjUlhkclYzaWlJZ2FJNHB1d2U3K3lZc2FXN3FnenhqY2IzN1d5?=
 =?utf-8?B?Mmc1SkkvV3VEUndRNEwzeDNOQlpBMG4xNHhEcmRrdEJuRFJXaVNta3E3dWU2?=
 =?utf-8?B?SDhoVzQySzRBMlp1d3I1RzZ1YnJRc1l2Zi9mN3BQVklEdkFFR1daVjBGdEEw?=
 =?utf-8?B?eGwzVnVBVytRT3gwK0FCYlRmMm9rUTF6QXIycm82UW5pNmthTXJKN0NnelAr?=
 =?utf-8?B?cDV1M3BqbFZGT0w0elp0V1AzSXY5dmRsei9RV3lQMmovSWVlSStQUHhPMmRX?=
 =?utf-8?B?dHJhdllaOU84YlRnRlJVUzJmcHM1RE9OSnErQzdaSVNsRm1NRTBWaHI1VlIx?=
 =?utf-8?B?UlduY2hFckNYK2w3ZHJ6VUlidzdqNFFsdUdqRjdlUndVOUlWeHRDaElkWFJY?=
 =?utf-8?B?UEQrTlp6dkJkUW42dThrbENCNXlXc2orcHRFT3ZNZUFrdW5YV0Vpdmx4MTF0?=
 =?utf-8?B?MklNTVFwTTZtVkJjTk9jZGp3MkhjYmkvZ1hSdXdzUGgzODJacFFjcFE3T0sw?=
 =?utf-8?B?Qit5NGZRNFB6aE9yRUhzWjZHT0orMkJObVFVSmp4LzN3L0xrSzV4Mm96QzVC?=
 =?utf-8?B?Rm9vYmtXeHY0b25hY01CdTkrUWJtcUVqRHNwclhnelFKMThHdTFlMEIyZGEv?=
 =?utf-8?B?QVZTNGw0eVpOUnVVWEdRTFdGYWlDRXZyMWdmTnlLdlBkNUU5RzE1MGFucFI4?=
 =?utf-8?B?YnlDbHhGQ2VMemNlcXE1V0xVS0tLVnlTY1BlYzQ4OGlXcmpOeTRvbFNzeFla?=
 =?utf-8?B?Zm04dnFUVDcvdHdoR1VER1BPY3EzRngycnFYenFPMEREOW42bUU5UjV2VWtj?=
 =?utf-8?B?Mk8rcTNIa3JLWVE5NFQrNlVkZThkQU85eUZJUnNidGIvNVhMQkhQUE1OcUFp?=
 =?utf-8?B?S1JmMFA2TkNyLytNNjlReEdLSFJ3c1ZJaWtmZkRlV3pBU2Fsc3JHSG1zam1w?=
 =?utf-8?B?RXNpdkdhbDdkdlc5VDlwOHJkWmZLOU52cklUR3lLWW9naS9jNHpXRDlPbFJL?=
 =?utf-8?B?TTZSR2RTVW1Qak43WGVzTit2UUtFU29WcUZVbWJqdm1lTmp6aVhzZktWMG1w?=
 =?utf-8?B?WWJkUldabHFRMjRKdGdJcVd0SW9zQ0oyaGpKYks3ODZJNlNJM2hQbTlJTlBz?=
 =?utf-8?B?SnR0YnZFVUZJeEhVcGdRazJhbGtQR3k3K3FVSy9tSnowTDdZQ00zZ29ONE9Q?=
 =?utf-8?Q?8LIQ7IhnpE1W+4MqsDMU0IP0O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629ccc5f-b1b8-450f-5e47-08dd002b1f15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:25:36.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxFXErb0U4diAKRU7iQQ+nrhC78BE6UWt5izYuq1WZNm3VDqmCAmp0KM05dXDZxoakyApCWdNk+MneRhu/dyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

On 11/8/2024 12:06, Armin Wolf wrote:
> Am 07.11.24 um 23:09 schrieb Mario Limonciello:
> 
>> On 11/7/2024 02:28, Armin Wolf wrote:
>>> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
>>>
>>>> The `choices` file will show all possible choices that a given platform
>>>> profile handler can support.
>>>>
>>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v5:
>>>>   * Fix kdoc
>>>>   * Add tag
>>>>   * Fix whitespace
>>>>   * Adjust mutex use
>>>> ---
>>>>   drivers/acpi/platform_profile.c | 65
>>>> +++++++++++++++++++++++++++++++++
>>>>   1 file changed, 65 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>>> platform_profile.c
>>>> index f605c2bd35c68..5e0bb91c5f451 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) ==
>>>> PLATFORM_PROFILE_LAST);
>>>>
>>>>   static DEFINE_IDA(platform_profile_ida);
>>>>
>>>> +/**
>>>> + * _commmon_choices_show - Show the available profile choices
>>>> + * @choices: The available profile choices
>>>> + * @buf: The buffer to write to
>>>> + * Return: The number of bytes written
>>>> + */
>>>> +static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
>>>> +{
>>>> +    int i, len = 0;
>>>> +
>>>> +    for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>>>> +        if (len == 0)
>>>> +            len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>> +        else
>>>> +            len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>> +    }
>>>> +    len += sysfs_emit_at(buf, len, "\n");
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +/**
>>>> + * _get_class_choices - Get the available profile choices for a
>>>> class device
>>>> + * @dev: The class device
>>>> + * @choices: Pointer to return the available profile choices
>>>> + * Return: The available profile choices
>>>> + */
>>>> +static int _get_class_choices(struct device *dev, unsigned long
>>>> *choices)
>>>> +{
>>>> +    struct platform_profile_handler *handler;
>>>> +    int i;
>>>> +
>>>> +    lockdep_assert_held(&profile_lock);
>>>> +    handler = dev_get_drvdata(dev);
>>>> +    for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>>>> +        *choices |= BIT(i);
>>>
>>> Maybe just copying the bitmask would be enough here? In this case we
>>> could also drop
>>> this function as well.
>>
>> Right now this could work, but choices and the use of it has gone
>> through great lengths to ensure that once there are too many profiles
>> it automatically becomes a bigger variable.
>>
>>     unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>
>> So I would rather keep this as is.
>>
> I think users of this function can do the locking themself and instead 
> use the functions from bitmap.h. Because _get_class_choices() will break 
> once "choices" becomes bigger.
> 

I am thinking it's better to just switch explicitly to an 'unsigned 
long' and add a static check that all profiles fit.  If ever they don't 
fit, the code can be overhauled at that point.

And yes _get_class_choices can go away then, and this is a lot simpler.

