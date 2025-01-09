Return-Path: <linux-acpi+bounces-10481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E96A07DCC
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1682D3A2058
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7E224AF6;
	Thu,  9 Jan 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s38SiKm8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FA22333C;
	Thu,  9 Jan 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440606; cv=fail; b=BcfV7W/3CsyaaNs2YSUoL5Fsvoa8wamPSvO0cA22n+RAhj1wwogtNwzl1aD+GlJ13ALPnHNLtCTEZ9odDpUjFExQWclWhNcOY+oVV9beECxPe/r+Q7IMJNbXVmqA2a3zsFygIrbF4vE92cIQAHGT3X9dQEn1n0FBoHqY9OzBwug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440606; c=relaxed/simple;
	bh=jKSYuBkyT/89ztIbtOF9kGrsX+oJoirTLWUpDGPpnis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XEHI4nJaLOYTReXgRpyCQ8KPFHkhNEUBRxNs4knDfyARpLMOvdblC7zOrVu/zUi9TTgrDd0GL4qxzzVH0pvjEeyUjuE0pfApFOI/alnH7hivpLitB98dyMk6sRfZOAos4oDf79fX9BwzAzFnh9qCJEqMWRIOuSNGP7NiFBIxkKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s38SiKm8; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuSMsokqmI/8rMVABHdD+67k8LgGP3YB8wZ6DIHTyA3UxQM2TUdMEL/JgJi0YQvqpZpxYv0jSgVAnl6fsMvzUoQTqgTM7BjmksBj5YT5Yg5Ean1+aUqLboIjhtwAjz2eo74CJJaDa7Mr1mXGXrnQH5Mcmu/9kKvAv0EvDEtgB/xHzQfxVONcjzCPVfeXqHqKNIyaJKgDFn84vP19nwem6XbswQNzD5/eeMl4HYyfF5Le1onmbUQt9QpheLM8+KQzuOO0uN7Uz1yAf0n/93vkrkzNo4FhcOLlN38ctKEOXAyXq0QavK1YOnAZidWjOfOYDOBtdcfnzYG0CLjh98ynKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32LyRrJgnTwsLRNiVL7T67fi5zxKpv3qtvt11mw4lOY=;
 b=ZpnZyOkTewkheetmLHCyOhQgfBNfMomVDuYKDgsNgzUHV62wvaG+N55klo/Flnp+xvYU9cDGw5DRin4HJAXq3Cq+q7/mYGc2oWIM0WEKIwTiBT2M6K2QD7ra0W9Ipu33x0p0o3MyuXmPAYX3xXs71zkzX93YxMvSo0u+mK2mR/JGg2Oc/T/c05n6gV98TgdRAJ6+ljuC5d/eaJnfAwS5ots5hdwZ7tj3j4/LCxdPuVlFRc8f+8eNqxyVL9oF7mkHnm3bi5OfIn3Wymhv4qKicW1yPaW2wBto7DyYaJgY54sS8WOpyt2E2QNnJyhovCUp0Rs8Tm+yi1CO4KZep1vTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32LyRrJgnTwsLRNiVL7T67fi5zxKpv3qtvt11mw4lOY=;
 b=s38SiKm8jdNVrkcTllkfObZmlWt+PTOpq2QL6YSSeX9yEKiO061mmHGZkr9wFyGqnklFDSvp1/fcPywhJcHIz3m7sX3aKYTefEk0aXG2TV77MqpesNvjg99Y8yPzcZ+opt7MS83tiiJUhMen1RNmmMS7tAaEy9b9W6W9j2X8Jgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:42 +0000
Message-ID: <c6a0685d-e318-4e54-bae4-3d28ee9f7e8b@amd.com>
Date: Thu, 9 Jan 2025 10:36:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] ACPI: platform_profile: Replace *class_dev member
 with class_dev
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
 <20250109150731.110799-4-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-4-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6e32a8-c63f-4744-2b76-08dd30cbcc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnczRi9TV0tQSFQ1NEhibVg0N04xeGZNejcvdEdtZExLZjF5VndYVXdJbC9K?=
 =?utf-8?B?eTJ5MXpablFZeGJicG5VUk1sTmtNSml6aEg5WmlrckVlQzVNb1pXaWRRNnZH?=
 =?utf-8?B?d3gvZkh1L0h2VkRqdkw2dmMyaVM5eHR5UmNheTRBVzR5NXZEbEZ2Q3E1WExG?=
 =?utf-8?B?cnBldTNUWGEzMXNGWWtmTjBRZk14WHNiT3NEZVdzbFY3VnhvNk1YeWtzRHdm?=
 =?utf-8?B?ZFlPSXNZczB5bmtJYzM4TW5rNjV3cHgwbmpDaVQvcHFKS2VwcjBPLzZDQzB6?=
 =?utf-8?B?Q0FyaDY4c1ZJcXVVQ2NMR0ZLSjhJQjlzWVdoYldNSExkRU90TlMwRjdrVVZL?=
 =?utf-8?B?YkRXdkUzVzBWYzBXUEJkbEdvUGZlMVlQaW1FaGNvRTRURWx5UTRyK25DK2p2?=
 =?utf-8?B?clR3eDlRR1dtVXIxajVnUHhUYXh1SGVaNnBKdndXdWFkVy9VQUEyS2pGTHR3?=
 =?utf-8?B?cC8wT05RSnB2Z0VhNlEzNlJBLzhDaHhXd0hvb1FyQTdDYmpEdTgvWXlqblFu?=
 =?utf-8?B?N1lIdTl3MDZDblVGMDBaMFNCZ0d2OXdGRXRzOTkrV1dhTklrQWRSRW5pVGtn?=
 =?utf-8?B?UmdsaDd3cHlSQ2pqbXQ4R0pxVXdZYjlHYWs1cFBPeExscU15aW15OWZxVkR4?=
 =?utf-8?B?NHlpekVLOU92QURrSk9MNUR1bjBKNlJtWWRrSjA0UEMwTm5BVmNIUE5oSGFY?=
 =?utf-8?B?c1pGQjlNaERzeXh2cGk5Q0lpQnRKczJuYmdSeUFGczVESmh4OTkycFZ0ZjR3?=
 =?utf-8?B?ckJObXhnd2RDYXJDc2JtQ3d3SFIrRmxxQTM4SWZVc2lhVDV5T3p6bGR4OHBZ?=
 =?utf-8?B?Zll6TFRkeDFiR1RwekQrQ1JCMlArOVBuaENWQUZDWk1MdUVmOVN1SnFLejhz?=
 =?utf-8?B?QVZuY3RWS3RUVi9xbHZFL3dabXQ1UTRhOXlySXo1WldYMm96Q01WajZtbGpI?=
 =?utf-8?B?MXg0bFBHdzF5SUJnY3dHc1RhZXBxTnVLaE5qd2lhZlRkRUoxVHNzSjBHbHBL?=
 =?utf-8?B?ZGZCSjdOMEw0WFJwSkZaUXk4N0hKNm0xVXBVT2E3N2FKM0RYTmtDditVZ1Jw?=
 =?utf-8?B?YVhSZmdMeVVFLzZIV1JTZlFwWU0za0prako5TFFZYmRoNUYwUlk0clpmcHJs?=
 =?utf-8?B?dkI5ZnJGQU1rMSttOXNGMFprdERKc2RtUDB6TFNlNElVQnU3bVppZFFvVWJW?=
 =?utf-8?B?QkpES3hBZERxRWdWV083WUFOSTZQMVRkRVNRSEt0SlVaOEtaWXByU2JIazRr?=
 =?utf-8?B?UnZNUHcvZnpaMHBPd1BjRWxSZkdxb0NRZHlkZWpjclBML2FtcEdqOG1WRC9L?=
 =?utf-8?B?a0NOdlF3b29OL0NsTWkrbzhWblJ6Ui96YXd1UG9DNldoZUNXYWZpalUyY0I4?=
 =?utf-8?B?SU9FWDVLOEswWmxKQ21mVTgzYUJmUzJlZnVQcEtaOVhJSlU1a2tMTjlsNm53?=
 =?utf-8?B?WW5qR0VwQlFVR293VmtNYlFVVzJLTzEyKzhZOXpjaHhLQm9TVFNvUSt6dXJ3?=
 =?utf-8?B?a3FXY1hJY05PZW1EUndyNEQ3TFhmK0R6U2Z5RVp5L0JDdHNtbWw2akF5c1lR?=
 =?utf-8?B?MTBMazZvdmF4RVpKeDA3NmF6OE9CUWgrUXh5WkhIZ2JTTWpqdzJpQUN0Z3c2?=
 =?utf-8?B?YjR2TW4wMUJDNGNxSENYaU1sL2s4V0VGa3F3RGtEaS9wN01RcmdoZHE2UlBt?=
 =?utf-8?B?aUZuRXlDSmwxS0JjK21UbjhrdVJUSmNaQ3lCZ2NsNXhFNmdNTVRteDlZamNE?=
 =?utf-8?B?VFNGTmNieTVUS0hIR3hDK3F6ZVBQN2Ewc2N0ODdoNmsyZlg0eUZaQmgxV2l2?=
 =?utf-8?B?ZjRuNDdvUWdLZ1hDdEthUFVxTVd6emh0OHBSQm1vM3hrVW16ZEtIaXM3V1pu?=
 =?utf-8?Q?tV4BaJGpqeeuN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWRtaUhBS0xmRitRcjBUbDEvSzFlZjBPOWIrdk5WNlM3OTlSSjNOOEk4bm9a?=
 =?utf-8?B?bHRCcGp1dlFBUTdFTVNsWUNyMzlYcGM2c0xJZ2o0U0ZrZ2xadEYvZ1Z2OVdi?=
 =?utf-8?B?MmllNHpGaURzWFFvOFFSSERyUmdMbWtzbktKSVR4UXRZaDZwbFZXRkhNVTVm?=
 =?utf-8?B?RVpzV2pPMTdMZ1NPOEhTRTdZQ3ZxN3h0bkUwL2tDd0lMR0lwZWdnYURRM0VJ?=
 =?utf-8?B?dFJHSEw0elNzVUx2bnUzcVhCRmp0RGRFRXVGY2lvZ20wZkNzV2N6eGFuK3g5?=
 =?utf-8?B?Q3kvWkdDcUNYdUdUTW1BaEZzRXhnVE9TL2ZXQmNVMFJ1V0lqSlVlQjg3aDRl?=
 =?utf-8?B?djZSbGF1S3NGSHFZeThJZVY5c0J4UnBraTVzSDZZS2E0SDJxWVZMVzlpWkx6?=
 =?utf-8?B?czRsUWJIcnJMaDU2bTEwYVdHRHBXc2t0MGl3cmlUNGFFVGloUlI1d3EyTEVx?=
 =?utf-8?B?TzRMS0k5M0RXQzlTQkVHVzMxSWdmeEMwNzliM0UvZmJYdjJZRGtGMFJnTlMw?=
 =?utf-8?B?T1lQR0tnSjlzQTFQYlRpQUYxRkVnNHZsaXZyYkdJa0d4bGVGSE1MNjZCdjJw?=
 =?utf-8?B?SlNBd0NucE4wZWJ0UE03a0lSelF5OTB4QmMycCtYRmhRZmFVQVZqZnRFQ1hJ?=
 =?utf-8?B?MUlNM0Q3S3AvUUVnUTVQbkFRTE5YU1EzZzNWV0NSZWxjUDdFWjQ1ZTZiNmhO?=
 =?utf-8?B?OURyM3JqR1hlYlV6RkVYM0tzQlVRYmVsOEoxclMrU2hFUlpkN1FudngvNGND?=
 =?utf-8?B?UlNyM0RTRjYvcTcvWXJNZU40eWhGUElLRElKYkRENTFySVRIa20vdDhpdkJU?=
 =?utf-8?B?dThwcldUYmJEQkcxQlBKTU1Ub0c4VW5kYzNJTmhqcE5pbW1sVk9TWitqYU5G?=
 =?utf-8?B?dTJiRlh5ekttTlVpTTAvK3BtdkMwdHNWOUc4V1JvOE5rTzZRL0JhRUNhd3cz?=
 =?utf-8?B?S2hPOXpyc09wSUszaU1OcnFqRStQeC9CelZ3bXcxYjBJN3ZFaUdVWmpsWWhP?=
 =?utf-8?B?dDBmVTUvMm82eTdrNmJKRnhkaitMOXFUbEdRMm5valI3Vnc4NHAwNnUybEtu?=
 =?utf-8?B?YVNlWXNKVGgxaE5CS1pSRytsV0hlcXhWaEZUd29Vc3V1TWhkd2dkN3hIaTMz?=
 =?utf-8?B?WXErWmZhV3ZFZXI0RlB1K04ycU9lN1d2eFlrTVBZU3luTDIvTDZ2cUd6ZGk4?=
 =?utf-8?B?WHN1ZlFZS3hBbnJ4RkdzT2pQSXk0Ri9CdFpQQll4K2JyK0NBdWJkb2JYbDI0?=
 =?utf-8?B?YjRNeGlzRllGT0ZPN21uejBrZno1aFlNdXVsL3hOd0t1MGJ3M1VxRVNhTUVH?=
 =?utf-8?B?eU9WWUtrTWl1QVl4bnVlVk5TNWh4YUdDTUpBRXRVREY4d0xzTDRXQ1hBc1FH?=
 =?utf-8?B?SlpjTHpSZ1VMSkczSnFwZDIyZXdBa2MrRzcwTWprMnNqOVJxRmF1UkhRYThK?=
 =?utf-8?B?Rjhqa0NFdnBnZzVpRFJMQ1BHeTlRVDEvdUEwazFzMXRVMEkxR2JpM0s2MXUz?=
 =?utf-8?B?RFlFdUsyUEQySTU5SUNwVTVkODRjQVIzOE1PTkVudkxQWXhKOC8rZTZCcVc4?=
 =?utf-8?B?Y0dFUEJaTGRhb1IvRGRxTFh1aDVWTjRZdGUvemNud1oydEJyd1pRZ1BkaTBX?=
 =?utf-8?B?V0FFdk1OUlVlczNyUUg1ekR2RXdOa1RLVzQ1UkJacnRGSDlWOWJSdEhRTkJ2?=
 =?utf-8?B?TFV5dytuRVpaMWVFalNlT21odHlxUGYvQ1lIVmNJWlBsVnRLTHhUU1U1eWpr?=
 =?utf-8?B?N2p1UEt1YllHMU04MnZmclc4aU9HZkVjQVlnNzJaUnBjQ2FVRE5WYnJJelYw?=
 =?utf-8?B?Sm5sSENQWDJBZXRmSWk1a1pGOXVoMFU5QmdkSU9RQ2hMaXF1L3JCR3hudjZS?=
 =?utf-8?B?M2c4OGxyN2lJWUtHZVphU0dma0M5WGE4akkxYXJEOFpHRjVXRGNoWElra3Bj?=
 =?utf-8?B?RkUwU1hheVVId2luR3lDWUxmZUJjTUxBRUZSUmNiWDkyOUNFbTVKN3dTR01F?=
 =?utf-8?B?SHdtN3VBRzBrNC9EaHk4dzJwek5tRWNmakRMYVRocXpSR0xScmVMN00waEF0?=
 =?utf-8?B?cFJkY1FwTHo4YUUxVnYvVkxvSmV0b1JlVXg5d1hETkl5YjhLclJXZ2pvTjV1?=
 =?utf-8?Q?LNT0gNDSvIQykwfV2NgJaruJw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e32a8-c63f-4744-2b76-08dd30cbcc7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:42.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2KS5CdFTpQw4W/+4zE4pTmAHA3Ydl4i9H268YNlhb4q2vS41n4u/wg0K3FnvTXswWRsfs/M57vVi7CL35vvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Instead of holding a reference to the class device, embed it the
> platform_profile_handler. This involves manually creating and
> registering the device and replacing dev_get_drvdata() with the newly
> created to_pprof_handler() macro.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 36 +++++++++++++++++---------------
>   include/linux/platform_profile.h |  3 ++-
>   2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 9cb82173947c..3cbde8dfed0b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,6 +10,8 @@
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
>   
> +#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
> +
>   static DEFINE_MUTEX(profile_lock);
>   
>   static const char * const profile_names[] = {
> @@ -60,7 +62,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	int *bit = (int *)data;
>   
>   	lockdep_assert_held(&profile_lock);
> -	handler = dev_get_drvdata(dev);
> +	handler = to_pprof_handler(dev);
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> @@ -76,11 +78,11 @@ static int _store_class_profile(struct device *dev, void *data)
>    */
>   static int _notify_class_profile(struct device *dev, void *data)
>   {
> -	struct platform_profile_handler *handler = dev_get_drvdata(dev);
> +	struct platform_profile_handler *handler = to_pprof_handler(dev);
>   
>   	lockdep_assert_held(&profile_lock);
> -	sysfs_notify(&handler->class_dev->kobj, NULL, "profile");
> -	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
> +	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
> +	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
>   
>   	return 0;
>   }
> @@ -100,7 +102,7 @@ static int get_class_profile(struct device *dev,
>   	int err;
>   
>   	lockdep_assert_held(&profile_lock);
> -	handler = dev_get_drvdata(dev);
> +	handler = to_pprof_handler(dev);
>   	err = handler->ops->profile_get(handler, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
> @@ -124,7 +126,7 @@ static int get_class_profile(struct device *dev,
>    */
>   static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
> -	struct platform_profile_handler *handler = dev_get_drvdata(dev);
> +	struct platform_profile_handler *handler = to_pprof_handler(dev);
>   
>   	return sysfs_emit(buf, "%s\n", handler->name);
>   }
> @@ -142,7 +144,7 @@ static ssize_t choices_show(struct device *dev,
>   			    struct device_attribute *attr,
>   			    char *buf)
>   {
> -	struct platform_profile_handler *handler = dev_get_drvdata(dev);
> +	struct platform_profile_handler *handler = to_pprof_handler(dev);
>   
>   	return _commmon_choices_show(handler->choices, buf);
>   }
> @@ -229,7 +231,7 @@ static int _aggregate_choices(struct device *dev, void *data)
>   	unsigned long *aggregate = data;
>   
>   	lockdep_assert_held(&profile_lock);
> -	handler = dev_get_drvdata(dev);
> +	handler = to_pprof_handler(dev);
>   	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>   		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
>   	else
> @@ -410,7 +412,7 @@ static const struct attribute_group platform_profile_group = {
>   void platform_profile_notify(struct platform_profile_handler *pprof)
>   {
>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> -		_notify_class_profile(pprof->class_dev, NULL);
> +		_notify_class_profile(&pprof->class_dev, NULL);
>   	}
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
> @@ -485,13 +487,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
>   	if (pprof->minor < 0)
>   		return pprof->minor;
> -	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
> -					 MKDEV(0, 0), pprof, "platform-profile-%d",
> -					 pprof->minor);
> -	if (IS_ERR(pprof->class_dev)) {
> -		err = PTR_ERR(pprof->class_dev);
> +
> +	pprof->class_dev.class = &platform_profile_class;
> +	pprof->class_dev.parent = pprof->dev;
> +	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
> +	err = device_register(&pprof->class_dev);
> +	if (err)
>   		goto cleanup_ida;
> -	}
>   
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   
> @@ -502,7 +504,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   	return 0;
>   
>   cleanup_cur:
> -	device_unregister(pprof->class_dev);
> +	device_unregister(&pprof->class_dev);
>   
>   cleanup_ida:
>   	ida_free(&platform_profile_ida, pprof->minor);
> @@ -517,7 +519,7 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>   	guard(mutex)(&profile_lock);
>   
>   	id = pprof->minor;
> -	device_unregister(pprof->class_dev);
> +	device_unregister(&pprof->class_dev);
>   	ida_free(&platform_profile_ida, id);
>   
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 972a62be60b2..f549067539af 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -9,6 +9,7 @@
>   #ifndef _PLATFORM_PROFILE_H_
>   #define _PLATFORM_PROFILE_H_
>   
> +#include <linux/device.h>
>   #include <linux/bitops.h>
>   
>   /*
> @@ -40,7 +41,7 @@ struct platform_profile_ops {
>   struct platform_profile_handler {
>   	const char *name;
>   	struct device *dev;
> -	struct device *class_dev;
> +	struct device class_dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	const struct platform_profile_ops *ops;


