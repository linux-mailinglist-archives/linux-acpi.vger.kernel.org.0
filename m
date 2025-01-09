Return-Path: <linux-acpi+bounces-10486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D50A07DF3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2064016805B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F452D052;
	Thu,  9 Jan 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P4Er6K1z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5742B9BF;
	Thu,  9 Jan 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441140; cv=fail; b=IwSkAuGPhFOpxRiIUhWhpGLbGec6iNroj/NI5/A21onSvIqrwsd3r9dbEMliQgv96rJst2c5+Xn156oggNG+r1Ib7jbVHfSRFaAeLgz8oL7BVZGsjr3fYDliqUk6tI9LByT+DSGKe0K4larpNCf/0+8+9SbuMhr3kQQRacME7LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441140; c=relaxed/simple;
	bh=YHGjG5z7UUaovwqFIkPgQ6u/m52ped7zVakM7dtpqtQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TayzjaTkpLIuSq+vu/yWUUdL2QEdz19ZMsT5teSjIa/v8s97IaA3a92T+h0GRMfofQYDJVND6xKaOE8Uwd5oajGNEpnPuWlWFB57a/ElcIWtIaJr3r3jUq0lNQ5HPEgclHynBpaiOwcrPKThAf1PZcOubWKRO0KzTlaU39qnp+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P4Er6K1z; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJKdWuhvMxQ7gUrft4cjSyjve9HhgXceqPf1fV8OuSq1Ws1655iVnNfnpPBlIYmcqxVwKbm25YbdCKoqdgnE9NI62ghCUfmkJzI/15jzCaFgzC3Gmnqk9aWNlundKQ4eUuJ6b86VgZXi3yFzufTWLrSDe5DvJeEXfHJ3TT6eTG6dCwHQp3LmMHacya2zvq6SX7LCCXiMNHLgSbBBdDfXgQ7tvk5j5pzN4s1tTA26GJltWCocaGYvCDhcC4+LZi4ISPsyPhuLUW1zlzA3UOdhzmkdSzhH+6lmiv5h5BFQrV77pXTd2/IbEATVWQNEJzn8OHbMhi/cBHGjIwjZ6ezgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kw4IUSEnqRME/qKLUWK7hFoab/rpiZoRSkGDqLRNnY=;
 b=I8n8Al/ZkKnp0QiWJy+DZwwQAr4IOOHGftghu9bUZFjPwibgcROKnnAVW9nY04tj8r8gmVjuYvq6cleaIPqrmTy08smVRjSQcbEj1OLSH0ZGFNHulLTg15oDePX5fDcdq1rnylYjqlbaG2AMuPXm5lATs4kfzinrduxUjekwD0WVVIzvhJpoL4bY/EbgR9HcdRSwMms0uBKexo5+tWcw4JDaRhSppomduTlHWm/yDhtQuKU726YLeVkg9fGTaF0mGfBZpXlA9MrWiMSR3pEKM5DqzGAYaCNt27iRpSdNaHW875IhmNBpxm6TMKaOQuowq22D7aoSJtGvgsryC+CkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kw4IUSEnqRME/qKLUWK7hFoab/rpiZoRSkGDqLRNnY=;
 b=P4Er6K1zwtDo6wNSWPD+uuEeG0Xj3wcGgE3jv4K6wE3CATTu8uBoZJWZD9TDdeYqYLDxwVUxQDk31rhmeOHZZ0MW95u6d7RMq+M/36nHuugB8aSrSgK8Mgpi+UyRpqSiN9cN1fcWEspvhzXxx5KL77rI1Sh5/RKwUL6KX3fCIxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 9 Jan
 2025 16:45:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:45:34 +0000
Message-ID: <8263323b-2eae-4158-acbf-5ca830d9aa79@amd.com>
Date: Thu, 9 Jan 2025 10:45:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] ACPI: platform_profile: Remove
 platform_profile_handler from exported symbols
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
 <20250109150731.110799-15-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-15-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:806:120::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: c22c4872-ff5d-42a3-ba6b-08dd30cd098b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXV4bkQwNXJXMnVWQ2ZYUHF2R3hGTmFvaXIyNnpDdTNweWhTYjVCcTlNWkFR?=
 =?utf-8?B?TDlkUk5UVzhqdWpwT0o0eEw3NFZGYVZnS2E1MEwyLzVxSEZJWUtvN1ZOZGFY?=
 =?utf-8?B?ZlBTeDUyS0U0K1FCZmJsdVB5UTJ4THNsa0dZWkFGbjVtWjBGVWtLVDNCdC9C?=
 =?utf-8?B?dk5jRDRDQnhWQ3E1YXBWMjBIcUxydkFGQ0FTZ2dmcGpydEE0bXN3U3hEOVlm?=
 =?utf-8?B?Nno0VzBXeDYwL2pkM1hiZVh3U1BtTXhlWENQUVM0bXZmbTV6eURvQlNBV0d0?=
 =?utf-8?B?NFdvTHU5MUJ0M280LzQ2eHd4eml6Mm10QXJ4WUFrVlBlZTQ1aHY3MmF2Mndr?=
 =?utf-8?B?VVNtbXpUdkg2VUI3b3pSb0xQeU9lNTNxOUFwRFVNUjFFODRnc0pvRFRjdmlI?=
 =?utf-8?B?SU02cmsvTktWaEFYY0xjbzhiNWpRbDVJSnR2ci9UeEZwd3F4OFdBa3ZzdnVm?=
 =?utf-8?B?a2RtdE1TZ2lueXJvZ1R4MmtYL3poOXFraE5NaEtwVVRJeHFWS09xUDAwZ0dB?=
 =?utf-8?B?MlN5MXZtUVRHWk0vZ29hYW5IMGUwbzZTTlhvSkZVNmttMm9pNkRhbDRxNzVR?=
 =?utf-8?B?UW1yNXpKRGhISkRkSi9iVjQxWDJrNnRZS3ROb1JOdEhOeURxcHIzT0w1dnl1?=
 =?utf-8?B?NVRKNkFndmoyckxIUG5CcFd5TUVGQVRCSTdFclRKZi81TmVqTllrUUdkZlF3?=
 =?utf-8?B?ZDM3UktWT280eHNyRG5IL2ROQ3V1cldPODFXT0krMFlsalh5Uk9zS3AzY1k5?=
 =?utf-8?B?b2pQbzRTLzJHSkRCMXlFSkpLMlpoQy9WSFJiQWNJVkFxelJIZUN1L21WQUhJ?=
 =?utf-8?B?bkkyS3NvWnZoTmpBRTVTNWFweXh1dzB5MkpvWGRLUW4rZytnSWxiWmdhMGx3?=
 =?utf-8?B?cEQ4d1RKaExqOXVjRG4rS0VjTUthWnF5cjl4N0hCc2tZbk80a1g4Z1hMZWtI?=
 =?utf-8?B?TWNQZndRb3QzL0crYU80N0JXNCtWS1VLMm9pOFBaMHEvMGRUcmJHR0d4dFVQ?=
 =?utf-8?B?K2RtVXFXOWlWUDlLTVZFbDAwcXIxdEY4YkxKOHp2K3kvMDI2WTFsWFZOcDRq?=
 =?utf-8?B?UC9nSzJTV1Q1NVljYzRWWkRSSVh0M1RsV2g3S2ZJL2xpaFRCVEpaR2dpMHZ2?=
 =?utf-8?B?NWRSNWhkaFMzY1c2QkdLWlpIS1pwWXkwdGtQN1liZUorWUVObVVDS2hqRlpB?=
 =?utf-8?B?R2wycDNSTEcwRGNaRnAvWW9BNGgrNTBwV1Y0OElqOFpCUXZlcDJYUjdUUUdX?=
 =?utf-8?B?TklFMm9zbFpwM0xxc0pxb0VwRlY1Sm9xeWI0V2U2RXpyZjE5OGlpU3pETmRX?=
 =?utf-8?B?VkE5cVNONnZHOUZ5U0paQ2VCdHFxU2FWanNNL0pVMjZJbEJyaERzVElnTHJ6?=
 =?utf-8?B?eklDUmdyQWFSeis4ZFM1Ri9zUUtkVDllSzRGNUJ0WnBRT2VYWWVPbmNnQ1Jy?=
 =?utf-8?B?ZW43bVh5dW9tT0Q5OHZyS0lWM3prU2ZsYi9lTldTZE1mQ0UrdTJkRGhyUS9W?=
 =?utf-8?B?TWg2cE9CcXZ5NFY5SGZVdE8xeVJEa1F6blRCZVEzS29PcFZKL3F0YVJoeE1B?=
 =?utf-8?B?SWZOSXk1VUJZUGlQNmVNTSt3MTFPbnJCeUkrQXZuTk0wb05IVTcxQnR0ODRW?=
 =?utf-8?B?eHUzc282M2RzaE10WHhseS9pSTJYMHhPVE03V1pPUDBNeDdoTStBQ3EyZERU?=
 =?utf-8?B?dHJJWS9ORHVYN0FTWjNZb3FKUzB4Wnh6Z1Z6QkVLYmhJL3g4WnIrOTNnWGll?=
 =?utf-8?B?Q200dG5yWlp3eU55OHV3SlJwY3A3UVk3b3Z6N0RkNWF0c0lBbmFaOW1ndXJV?=
 =?utf-8?B?WlQ3R3JYRDluVlBxMHBHN2Y5UVhpbFB1RmFkdXhFdmdYc2lPU0w0YUNLL0tY?=
 =?utf-8?Q?TCkbM0fOpXV2i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTVJdUNPNzRnbUNCamVhOHZNOHRMZU5nOGhMNWRnR3lqcnFLdVVvS0cveEtE?=
 =?utf-8?B?VjVYYzU3SXVrMU5EeFNLM1VXd2NVeTZhMDV1NWZIOU1UZFhFUkl5MnNpS2pT?=
 =?utf-8?B?NXc5cFJRc1U1K0NwVFRhb1N5bE4wVHZTblI3NFR1Q0lmbkhaUm55cy9wZUF4?=
 =?utf-8?B?aU9ZeWlWaUhKOVJhbDJaeU1NSDZSQTVRWmhmUnhVNEswL2NWUnVKbkhFL1dU?=
 =?utf-8?B?SUhSczlBblIvWE16eUlzN1lnY0QvR3NDRmZPeW44ZkJtVnVQUFBiazQ1dnZB?=
 =?utf-8?B?WXE1aTg1NFZ6QkRlNllHdVkrQjBic1ppMng1Skt1ZDM5TUdJRVY1WlBGdit5?=
 =?utf-8?B?bklvd3Eza2lUc1daM0xRQ09vZHlJSXZrWHhQU28zTlRQOCtjVlJCWDVLU3ls?=
 =?utf-8?B?VWxSRkk2NGJKQ0k0bHNQRnVsVjNPOU84alRHcTBjWjU1TmJoSDlCdnZPYWsz?=
 =?utf-8?B?a1ZMUEVRQ0FFM3h6T3J6OWtERHdmek9ZQng2akVNOU9rOXFhdnlFS1NuSENG?=
 =?utf-8?B?V1FoemZBTTR6dW9ZV3hhYitXaEVNS0pEbDlBdmJTOTdyZDBzM2pvMXZSenpV?=
 =?utf-8?B?YzJkNXJzNVhMYWZLVjlxQy9haGRISXBLYlk2Q05PcGg3R2ZkT0pFNEVjb2dB?=
 =?utf-8?B?Y2lYY09NMlVNR2I4Q0twRDNkUFg0MzI4TjZEN3g2NGZUV0FUY3p1RW9HODRB?=
 =?utf-8?B?Z245dEpEYWlIMHRLVzZIelV4eWFoWUtFbDNmOWJVKytFRjhrbkhudDZqRkkw?=
 =?utf-8?B?TCs2dDY2OXJVbTRTNnljY0pkdFRNNUlENXh5WkxDRWVaWk5wOEZjSFJYR3ow?=
 =?utf-8?B?REV3YjRNcXZhRmxrUmNTV0JxaWI0aXRML015c0RaTDhrcVJ4WDJVS1VqVkpO?=
 =?utf-8?B?T2s0WFhnOHRUcGRiY3JqZFVrWVZvbS9EeW9DSHZJejVGYkptaEJTYzZTUUx0?=
 =?utf-8?B?dlZJNllzNGZPNWcrNXU4blBJdlZQaXhTaCtac1JyNGRadkNhNmtGcUdqNjJw?=
 =?utf-8?B?Wkt4YncyTXRGRmhIZXk4VUtMczZPS2pKeGRZUTUxVytoTWhTMExlUW95dHIz?=
 =?utf-8?B?aktiWXg0UGV2Uzd3WllENlB2TS9VTWFWaVpuK2Nwc0FBQXdad2lBTS93Z2d4?=
 =?utf-8?B?YWp4ZVpWcnB5OWVyVFMvUnJLdmlHWXBlZTFrM1FkV3Z0eUdNR0lHNzVZR0NT?=
 =?utf-8?B?ZmlkQUFpNVFpaUtGYW9IQ2RmTGJjOXNIUUNjSTAvVzQ4NTZOT0swNEE5WEtY?=
 =?utf-8?B?ZERHbDFteXVlK1NKMVgvbGtZakVrR3A2dkpFQkJrVDlWTyswSkRjdC9KZUpQ?=
 =?utf-8?B?SmtaSERMaGJHTnpqVHF1N2JmSzZ4MTlTbmlxbjEzWWw0SkJ0ODdMUUZtR3Fr?=
 =?utf-8?B?UnRKeVI2dnR3SjJpdTg0R0Z6b1dLeGdnWC9RRzBNT2JJZ0dDVHZScmd6ckZt?=
 =?utf-8?B?T080RWlYTU9DdnVOYmF2ejExWFJZazdGMWNJSWZMWmFwcENMcjhaeEtOTFd0?=
 =?utf-8?B?K2JKMTRHby84MGVPTUxtSi9JUDhaU2VlcjhNTUNDc1hxR05FREhuSUZCNUJt?=
 =?utf-8?B?MzM3Y3J2VlFSaTB3Q0RjK0dFRmtDeW4xWHpFOXlSdVcwbmtZSUxkbzdVVnB0?=
 =?utf-8?B?SjVacGlwL0JNZGFXS1ZGd2JWOE1TbUJzSi9IUUN2a3ZWMmpyUzRBSUx3S0ZS?=
 =?utf-8?B?UDl5bTRvQlFQTHZMaCtkOWpoVzEyM1ZnbnhUKzg0WTNKMGwvb01CNDZKd3RG?=
 =?utf-8?B?bWt6SlFmNDZzNW92aXlPb2NDclBzVmhjck0xTTRXY2ZHeGUrakRJVFF0aDRi?=
 =?utf-8?B?cUpDUFd4S2NGdUs3QzNPRlRoYmdyVVRGSmt3YUxCV2U1UzUxcEpiQ3o1elpR?=
 =?utf-8?B?bHdrdFZhbWJmdXk3YmFpckpvVlFTM2F3VlB5empnMlIwZUVtdEVIajRYeUtL?=
 =?utf-8?B?VWFXOGhMU2czVFEyWk8rUExtN0xXWWtWY0ZqK0FUVVIxbHc4Wk9McFdDdVRZ?=
 =?utf-8?B?QmNuTURLdVlicjVHTnVCVXllZEhCVk54Wmp5OTFwelJmVXYvQXdUZWhvT2Jz?=
 =?utf-8?B?V2kwYk1jdk5qVlVJRmZKcGFnT1pUU0Q2L1Q5K29CR29LaU5aK0dwa0lMWTZ3?=
 =?utf-8?Q?Hf7oHyXLI+Zhk792bq6PbVyXS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c4872-ff5d-42a3-ba6b-08dd30cd098b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:45:34.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQKKDPe9rbdn+snLPTS+2EayHBYp/zUVp/eycg98NmPepgRKOdw+AJcdaIrKqRak8Mf+hddsvOJrE7SiAq7LkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On 1/9/2025 09:06, Kurt Borja wrote:
> In order to protect the platform_profile_handler from API consumers,
> allocate it in platform_profile_register() and modify it's signature
> accordingly.
> 
> Remove the platform_profile_handler from all consumer drivers and
> replace them with a pointer to the class device, which is
> now returned from platform_profile_register().
> 
> Replace *pprof with a pointer to the class device in the rest of
> exported symbols.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c               | 93 ++++++++++++-------
>   .../surface/surface_platform_profile.c        | 11 +--
>   drivers/platform/x86/acer-wmi.c               | 18 ++--
>   drivers/platform/x86/amd/pmf/pmf.h            |  2 +-
>   drivers/platform/x86/amd/pmf/sps.c            | 15 +--
>   drivers/platform/x86/asus-wmi.c               | 17 ++--
>   drivers/platform/x86/dell/alienware-wmi.c     | 10 +-
>   drivers/platform/x86/dell/dell-pc.c           | 22 ++---
>   drivers/platform/x86/hp/hp-wmi.c              | 19 ++--
>   drivers/platform/x86/ideapad-laptop.c         | 14 +--
>   .../platform/x86/inspur_platform_profile.c    |  9 +-
>   drivers/platform/x86/thinkpad_acpi.c          | 14 +--
>   include/linux/platform_profile.h              | 12 ++-
>   13 files changed, 131 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 5a867b912964..fdf79b81b62e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -3,6 +3,7 @@
>   /* Platform profile sysfs interface */
>   
>   #include <linux/acpi.h>
> +#include <linux/cleanup.h>
>   #include <linux/bits.h>
>   #include <linux/init.h>
>   #include <linux/kdev_t.h>
> @@ -213,9 +214,17 @@ static struct attribute *profile_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(profile);
>   
> +static void pprof_device_release(struct device *dev)
> +{
> +	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> +
> +	kfree(pprof);
> +}
> +
>   static const struct class platform_profile_class = {
>   	.name = "platform-profile",
>   	.dev_groups = profile_groups,
> +	.dev_release = pprof_device_release,
>   };
>   
>   /**
> @@ -409,10 +418,10 @@ static const struct attribute_group platform_profile_group = {
>   	.is_visible = profile_class_is_visible,
>   };
>   
> -void platform_profile_notify(struct platform_profile_handler *pprof)
> +void platform_profile_notify(struct device *dev)
>   {
>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> -		_notify_class_profile(&pprof->class_dev, NULL);
> +		_notify_class_profile(dev, NULL);
>   	}
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
> @@ -461,40 +470,57 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> -int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
> +struct device *platform_profile_register(struct device *dev, const char *name,
> +					 void *drvdata,
> +					 const struct platform_profile_ops *ops)
>   {
> +	struct device *ppdev;
> +	int minor;
>   	int err;
>   
> -	/* Sanity check the profile handler */
> -	if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_get ||
> -	    !pprof->ops->choices) {
> +	/* Sanity check */
> +	if (!dev || !name || !ops || !ops->profile_get ||
> +	    !ops->profile_set || !ops->choices) {
>   		pr_err("platform_profile: handler is invalid\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   
> -	err = pprof->ops->choices(pprof);
> +	struct platform_profile_handler *pprof __free(kfree) = kzalloc(
> +		sizeof(*pprof), GFP_KERNEL);
> +	if (!pprof)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = ops->choices(pprof);
>   	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
>   
>   	if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
>   		pr_err("platform_profile: no available profiles\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   
>   	guard(mutex)(&profile_lock);
>   
>   	/* create class interface for individual handler */
> -	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> -	if (pprof->minor < 0)
> -		return pprof->minor;
> +	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> +	if (minor < 0)
> +		return ERR_PTR(minor);
>   
> +	pprof->name = name;
> +	pprof->ops = ops;
> +	pprof->minor = minor;
>   	pprof->class_dev.class = &platform_profile_class;
> -	pprof->class_dev.parent = pprof->dev;
> +	pprof->class_dev.parent = dev;
>   	dev_set_drvdata(&pprof->class_dev, drvdata);
>   	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
>   	err = device_register(&pprof->class_dev);
> -	if (err)
> +	if (err) {
> +		put_device(&no_free_ptr(pprof)->class_dev);
>   		goto cleanup_ida;
> +	}
> +
> +	/* After this point, device_unregister will free pprof on error */
> +	ppdev = &no_free_ptr(pprof)->class_dev;
>   
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   
> @@ -502,20 +528,21 @@ int platform_profile_register(struct platform_profile_handler *pprof, void *drvd
>   	if (err)
>   		goto cleanup_cur;
>   
> -	return 0;
> +	return ppdev;
>   
>   cleanup_cur:
> -	device_unregister(&pprof->class_dev);
> +	device_unregister(ppdev);
>   
>   cleanup_ida:
> -	ida_free(&platform_profile_ida, pprof->minor);
> +	ida_free(&platform_profile_ida, minor);
>   
> -	return err;
> +	return ERR_PTR(err);
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>   
> -int platform_profile_remove(struct platform_profile_handler *pprof)
> +int platform_profile_remove(struct device *dev)
>   {
> +	struct platform_profile_handler *pprof = to_pprof_handler(dev);
>   	int id;
>   	guard(mutex)(&profile_lock);
>   
> @@ -533,30 +560,32 @@ EXPORT_SYMBOL_GPL(platform_profile_remove);
>   
>   static void devm_platform_profile_release(struct device *dev, void *res)
>   {
> -	struct platform_profile_handler **pprof = res;
> +	struct device **ppdev = res;
>   
> -	platform_profile_remove(*pprof);
> +	platform_profile_remove(*ppdev);
>   }
>   
> -int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
> +struct device *devm_platform_profile_register(struct device *dev, const char *name,
> +					      void *drvdata,
> +					      const struct platform_profile_ops *ops)
>   {
> -	struct platform_profile_handler **dr;
> -	int ret;
> +	struct device *ppdev;
> +	struct device **dr;
>   
>   	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
>   	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
> -	ret = platform_profile_register(pprof, drvdata);
> -	if (ret) {
> +	ppdev = platform_profile_register(dev, name, drvdata, ops);
> +	if (IS_ERR(dev)) {
>   		devres_free(dr);
> -		return ret;
> +		return ppdev;
>   	}
>   
> -	*dr = pprof;
> -	devres_add(pprof->dev, dr);
> +	*dr = ppdev;
> +	devres_add(dev, dr);
>   
> -	return 0;
> +	return ppdev;
>   }
>   EXPORT_SYMBOL_GPL(devm_platform_profile_register);
>   
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index efb6653ed1d5..965940223892 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -40,7 +40,7 @@ struct ssam_tmp_profile_info {
>   
>   struct ssam_platform_profile_device {
>   	struct ssam_device *sdev;
> -	struct platform_profile_handler handler;
> +	struct device *ppdev;
>   	bool has_fan;
>   };
>   
> @@ -228,13 +228,12 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   	tpd->sdev = sdev;
>   	ssam_device_set_drvdata(sdev, tpd);
>   
> -	tpd->handler.name = "Surface Platform Profile";
> -	tpd->handler.dev = &sdev->dev;
> -	tpd->handler.ops = &ssam_platform_profile_ops;
> -
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	return devm_platform_profile_register(&tpd->handler, tpd);
> +	tpd->ppdev =  devm_platform_profile_register(
> +		&sdev->dev, "Surface Platform Profile", tpd, &ssam_platform_profile_ops);
> +
> +	return PTR_ERR_OR_ZERO(tpd->ppdev);
>   }
>   
>   static const struct ssam_device_id ssam_platform_profile_match[] = {
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 70ec667e0cbf..2059b29dd36b 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -742,7 +742,7 @@ static const struct dmi_system_id non_acer_quirks[] __initconst = {
>   	{}
>   };
>   
> -static struct platform_profile_handler platform_profile_handler;
> +static struct device *platform_profile_device;
>   static bool platform_profile_support;
>   
>   /*
> @@ -1921,16 +1921,10 @@ static const struct platform_profile_ops acer_predator_v4_platform_profile_ops =
>   static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
> -		int err;
> -
> -		platform_profile_handler.name = "acer-wmi";
> -		platform_profile_handler.dev = &device->dev;
> -		platform_profile_handler.ops =
> -			&acer_predator_v4_platform_profile_ops;
> -
> -		err = devm_platform_profile_register(&platform_profile_handler, NULL);
> -		if (err)
> -			return err;
> +		platform_profile_device = devm_platform_profile_register(
> +			&device->dev, "acer-wmi", NULL, &acer_predator_v4_platform_profile_ops);
> +		if (IS_ERR(platform_profile_device))
> +			return PTR_ERR(platform_profile_device);
>   
>   		platform_profile_support = true;
>   
> @@ -2017,7 +2011,7 @@ static int acer_thermal_profile_change(void)
>   		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
>   			last_non_turbo_profile = tp;
>   
> -		platform_profile_notify(&platform_profile_handler);
> +		platform_profile_notify(platform_profile_device);
>   	}
>   
>   	return 0;
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 198bfe3306be..3806f9efaff8 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -338,7 +338,7 @@ struct amd_pmf_dev {
>   	struct mutex lock; /* protects the PMF interface */
>   	u32 supported_func;
>   	enum platform_profile_option current_profile;
> -	struct platform_profile_handler pprof;
> +	struct device *ppdev; /* platform profile class device */
>   	struct dentry *dbgfs_dir;
>   	int hb_interval; /* SBIOS heartbeat interval */
>   	struct delayed_work heart_beat;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 4f80a73eff9f..e8d2de9bb646 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -420,15 +420,16 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   		amd_pmf_set_sps_power_limits(dev);
>   	}
>   
> -	dev->pprof.name = "amd-pmf";
> -	dev->pprof.dev = dev->dev;
> -	dev->pprof.ops = &amd_pmf_profile_ops;
> -
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&dev->pprof, dev);
> -	if (err)
> +	dev->ppdev = devm_platform_profile_register(
> +		dev->dev, "amd-pmf", dev, &amd_pmf_profile_ops);
> +	if (IS_ERR(dev->ppdev)) {
> +		err = PTR_ERR(dev->ppdev);
>   		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
>   			err);
>   
> -	return err;
> +		return err;
> +	}
> +
> +	return 0;

Maybe instead of:

if (IS_ERR()) {
	err = PTR_ERR();
	dev_err();
	return err;
}

return 0;

You do this:

if (IS_ERR()) {
	err = PTR_ERR();
	dev_err();
}

return err;


>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 5c7099dc6109..809ab0353b68 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -313,7 +313,7 @@ struct asus_wmi {
>   	bool mid_fan_curve_available;
>   	struct fan_curve_data custom_fan_curves[3];
>   
> -	struct platform_profile_handler platform_profile_handler;
> +	struct device *platform_profile_device;
>   	bool platform_profile_support;
>   
>   	// The RSOC controls the maximum charging percentage.
> @@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   	 * Ensure that platform_profile updates userspace with the change to ensure
>   	 * that platform_profile and throttle_thermal_policy_mode are in sync.
>   	 */
> -	platform_profile_notify(&asus->platform_profile_handler);
> +	platform_profile_notify(asus->platform_profile_device);
>   
>   	return count;
>   }
> @@ -3891,15 +3891,10 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
>   
> -	asus->platform_profile_handler.name = "asus-wmi";
> -	asus->platform_profile_handler.dev = dev;
> -	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
> -
> -	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
> -	if (err == -EEXIST) {
> -		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> -		return 0;
> -	} else if (err) {
> +	asus->platform_profile_device = devm_platform_profile_register(
> +		dev, "asus-wmi", asus, &asus_wmi_platform_profile_ops);
> +	if (IS_ERR(asus->platform_profile_device)) {
> +		err = PTR_ERR(asus->platform_profile_device);
>   		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
>   		return err;
>   	}
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index a8961de004ab..1eaa746eb4f1 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -414,7 +414,6 @@ static struct platform_device *platform_device;
>   static struct device_attribute *zone_dev_attrs;
>   static struct attribute **zone_attrs;
>   static struct platform_zone *zone_data;
> -static struct platform_profile_handler pp_handler;
>   static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>   
>   static struct platform_driver platform_driver = {
> @@ -1165,11 +1164,12 @@ static const struct platform_profile_ops awcc_platform_profile_ops = {
>   
>   static int create_thermal_profile(struct platform_device *platform_device)
>   {
> -	pp_handler.name = "alienware-wmi";
> -	pp_handler.dev = &platform_device->dev;
> -	pp_handler.ops = &awcc_platform_profile_ops;
> +	struct device *ppdev;
>   
> -	return devm_platform_profile_register(&pp_handler, NULL);
> +	ppdev = devm_platform_profile_register(
> +		&platform_device->dev, "alienware-wmi", NULL, &awcc_platform_profile_ops);
> +
> +	return PTR_ERR_OR_ZERO(ppdev);
>   }
>   
>   static int __init alienware_wmi_init(void)
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index dda6f13295e8..4ff80ed4f157 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -109,8 +109,6 @@ MODULE_DEVICE_TABLE(dmi, dell_device_table);
>   #define DELL_ACC_SET_FIELD	GENMASK(11, 8)
>   #define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
>   
> -static struct platform_profile_handler *thermal_handler;
> -
>   enum thermal_mode_bits {
>   	DELL_BALANCED    = BIT(0),
>   	DELL_COOL_BOTTOM = BIT(1),
> @@ -254,6 +252,7 @@ static const struct platform_profile_ops dell_pc_platform_profile_ops = {
>   
>   static int thermal_init(void)
>   {
> +	struct device *ppdev;
>   	int ret;
>   
>   	/* If thermal commands are not supported, exit without error */
> @@ -271,26 +270,17 @@ static int thermal_init(void)
>   	if (IS_ERR(platform_device))
>   		return PTR_ERR(platform_device);
>   
> -	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
> -	if (!thermal_handler) {
> -		ret = -ENOMEM;
> -		goto cleanup_platform_device;
> -	}
> -	thermal_handler->name = "dell-pc";
> -	thermal_handler->dev = &platform_device->dev;
> -	thermal_handler->ops = &dell_pc_platform_profile_ops;
> -
>   	/* Clean up if failed */
> -	ret = devm_platform_profile_register(thermal_handler, NULL);
> -	if (ret)
> +	ppdev = devm_platform_profile_register(
> +		&platform_device->dev, "dell-pc", NULL, &dell_pc_platform_profile_ops);
> +	if (IS_ERR(ppdev)) {
> +		ret = PTR_ERR(ppdev);
>   		goto cleanup_thermal_handler;
> +	}
>   
>   	return 0;
>   
>   cleanup_thermal_handler:
> -	thermal_handler = NULL;
> -
> -cleanup_platform_device:
>   	platform_device_unregister(platform_device);
>   
>   	return ret;
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 8a620d36f926..1b9e176f8d6f 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -273,7 +273,7 @@ static DEFINE_MUTEX(active_platform_profile_lock);
>   static struct input_dev *hp_wmi_input_dev;
>   static struct input_dev *camera_shutter_input_dev;
>   static struct platform_device *hp_wmi_platform_dev;
> -static struct platform_profile_handler platform_profile_handler;
> +static struct device *platform_profile_device;
>   static struct notifier_block platform_power_source_nb;
>   static enum platform_profile_option active_platform_profile;
>   static bool platform_profile_support;
> @@ -1602,6 +1602,7 @@ static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
>   
>   static int thermal_profile_setup(struct platform_device *device)
>   {
> +	const struct platform_profile_ops *ops;
>   	int err, tp;
>   
>   	if (is_omen_thermal_profile()) {
> @@ -1617,7 +1618,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.ops = &platform_profile_omen_ops;
> +		ops = &platform_profile_omen_ops;
>   	} else if (is_victus_thermal_profile()) {
>   		err = platform_profile_victus_get_ec(&active_platform_profile);
>   		if (err < 0)
> @@ -1631,7 +1632,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.ops = &platform_profile_victus_ops;
> +		ops = &platform_profile_victus_ops;
>   	} else {
>   		tp = thermal_profile_get();
>   
> @@ -1646,15 +1647,13 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err)
>   			return err;
>   
> -		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
> +		ops = &hp_wmi_platform_profile_ops;
>   	}
>   
> -	platform_profile_handler.name = "hp-wmi";
> -	platform_profile_handler.dev = &device->dev;
> -
> -	err = devm_platform_profile_register(&platform_profile_handler, NULL);
> -	if (err)
> -		return err;
> +	platform_profile_device = devm_platform_profile_register(
> +		&device->dev, "hp-wmi", NULL, ops);
> +	if (IS_ERR(platform_profile_device))
> +		return PTR_ERR(platform_profile_device);
>   
>   	platform_profile_support = true;
>   
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index d34d565172f5..55aac0190624 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -142,7 +142,7 @@ enum {
>   
>   struct ideapad_dytc_priv {
>   	enum platform_profile_option current_profile;
> -	struct platform_profile_handler pprof;
> +	struct device *ppdev; /* platform profile device */
>   	struct mutex mutex; /* protects the DYTC interface */
>   	struct ideapad_private *priv;
>   };
> @@ -1050,7 +1050,7 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
>   
>   	if (profile != priv->dytc->current_profile) {
>   		priv->dytc->current_profile = profile;
> -		platform_profile_notify(&priv->dytc->pprof);
> +		platform_profile_notify(priv->dytc->ppdev);
>   	}
>   }
>   
> @@ -1117,15 +1117,15 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   
>   	mutex_init(&priv->dytc->mutex);
>   
> -	priv->dytc->pprof.name = "ideapad-laptop";
> -	priv->dytc->pprof.dev = &priv->platform_device->dev;
>   	priv->dytc->priv = priv;
> -	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
> -	if (err)
> +	priv->dytc->ppdev = devm_platform_profile_register(
> +		&priv->platform_device->dev, "ideapad-laptop", &priv->dytc, &dytc_profile_ops);
> +	if (IS_ERR(priv->dytc->ppdev)) {
> +		err = PTR_ERR(priv->dytc->ppdev);
>   		goto pp_reg_failed;
> +	}
>   
>   	/* Ensure initial values are correct */
>   	dytc_profile_refresh(priv);
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 543e4bce1a57..9e2f24de0207 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -32,7 +32,7 @@ enum inspur_tmp_profile {
>   
>   struct inspur_wmi_priv {
>   	struct wmi_device *wdev;
> -	struct platform_profile_handler handler;
> +	struct device *ppdev;
>   };
>   
>   static int inspur_wmi_perform_query(struct wmi_device *wdev,
> @@ -190,11 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->wdev = wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>   
> -	priv->handler.name = "inspur-wmi";
> -	priv->handler.dev = &wdev->dev;
> -	priv->handler.ops = &inspur_platform_profile_ops;
> +	priv->ppdev = devm_platform_profile_register(
> +		&wdev->dev, "inspur-wmi", priv, &inspur_platform_profile_ops);
>   
> -	return devm_platform_profile_register(&priv->handler, priv);
> +	return PTR_ERR_OR_ZERO(priv->ppdev);
>   }
>   
>   static const struct wmi_device_id inspur_wmi_id_table[] = {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index a0b8987bc328..964f842ef756 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -962,6 +962,7 @@ static const struct proc_ops dispatch_proc_ops = {
>   static struct platform_device *tpacpi_pdev;
>   static struct platform_device *tpacpi_sensors_pdev;
>   static struct device *tpacpi_hwmon;
> +static struct device *tpacpi_pprof;
>   static struct input_dev *tpacpi_inputdev;
>   static struct mutex tpacpi_inputdev_send_mutex;
>   static LIST_HEAD(tpacpi_all_drivers);
> @@ -10553,11 +10554,6 @@ static const struct platform_profile_ops dytc_profile_ops = {
>   	.choices = dytc_profile_choices,
>   };
>   
> -static struct platform_profile_handler dytc_profile = {
> -	.name = "thinkpad-acpi",
> -	.ops = &dytc_profile_ops,
> -};
> -
>   static void dytc_profile_refresh(void)
>   {
>   	enum platform_profile_option profile;
> @@ -10586,7 +10582,7 @@ static void dytc_profile_refresh(void)
>   	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
>   	if (!err && profile != dytc_current_profile) {
>   		dytc_current_profile = profile;
> -		platform_profile_notify(&dytc_profile);
> +		platform_profile_notify(tpacpi_pprof);
>   	}
>   }
>   
> @@ -10647,14 +10643,14 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   	dbg_printk(TPACPI_DBG_INIT,
>   			"DYTC version %d: thermal mode available\n", dytc_version);
>   
> -	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
> -	err = devm_platform_profile_register(&dytc_profile, NULL);
> +	tpacpi_pprof = devm_platform_profile_register(
> +		&tpacpi_pdev->dev, "thinkpad-acpi", NULL, &dytc_profile_ops);
>   	/*
>   	 * If for some reason platform_profiles aren't enabled
>   	 * don't quit terminally.
>   	 */
> -	if (err)
> +	if (IS_ERR(tpacpi_pprof))
>   		return -ENODEV;
>   
>   	/* Ensure initial values are correct */
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index cadbd3168d84..97ce9bd476ab 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -47,10 +47,14 @@ struct platform_profile_handler {
>   	const struct platform_profile_ops *ops;
>   };
>   
> -int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
> -int platform_profile_remove(struct platform_profile_handler *pprof);
> -int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
> +struct device *platform_profile_register(struct device *dev, const char *name,
> +					 void *drvdata,
> +					 const struct platform_profile_ops *ops);
> +int platform_profile_remove(struct device *dev);
> +struct device *devm_platform_profile_register(struct device *dev, const char *name,
> +					      void *drvdata,
> +					      const struct platform_profile_ops *ops);
>   int platform_profile_cycle(void);
> -void platform_profile_notify(struct platform_profile_handler *pprof);
> +void platform_profile_notify(struct device *dev);
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/


