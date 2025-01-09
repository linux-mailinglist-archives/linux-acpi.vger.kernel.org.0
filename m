Return-Path: <linux-acpi+bounces-10482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D85A07DD3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0767160CB6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91EF221DB3;
	Thu,  9 Jan 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O5KUT+4x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBD190472;
	Thu,  9 Jan 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440779; cv=fail; b=WwO16KyBs9flj0tuBZb3FU/clJe6ulpaOTH3oD0hUF//F8b9qS9v0o2autcqz/hYsEleQwSsU64AoV4NVioYZNhyFm0FqKaXPEn1Vft4o6cRouU12ZDZWyNntT1UZAFb9HEfvucm25H9xbDyujl1xVpM6NKoAy9uw7K7CFx5kFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440779; c=relaxed/simple;
	bh=CAh1yQ8g/RaEUTIUyJHBgN3flWPWWe4DHX7c9ibw0GY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ph04CCD4px++gRKKUm4GbpiQLd4+Zi8MWEVt1N2tW0saerXz6LWCExN8W8bubkj3Fz/QtvCvx2Tuv8qZhhvLjMJgV4Cnyop3xErivtRTrpDJ3m/pv48kb7y1fwnRkqz2G822etJMdrRo81WZuXLfVIC5nbZIRpWXXwZauwurLMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O5KUT+4x; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2cWE16qdXK6dn2rNnyIZwBl22OGUHeG6keSzKAmXKhkSNPveTjRBvBTxW2AyaE5mVRHoCcfqkvzKldh/GB7gaHtBD0vgL+Lo+NoauwmlIobYQrxP8/Z0NTGvfdQhegrGCI6Zu05f0sww/frIDtAcAD7Xg5eo5Ac2uGYnTU40QtXgvU2XRKT4fkijyjFXn5gHYx4nzFy8sR80LPj4gzdGjrRJGibiJK1CyvZqNTu33B4xBOHtKKGEpu3XvzF4Av9extSDtWMtWvUcNeQOF3xdrliIsWO43f76pnFzGRRtWp7VgH2IdtTgrEnOWJtt6DAymFCUDTy50sxYXlI34bOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC4WvP1GMxkGknZTclMVT0XFCr/2d+CYw9JozrvB5kw=;
 b=rFcqt0MohogFST/TkScPrHwRND+sCmBj/xKHx0nBVOA3Y9+IpLA8uJFM9HmUb7uJ/NMhmZniVljTovVMGKsbME2mFyr5WOQtQ0oLiUCiTnPQ9EylB2frnv6ngUzD0nLAXPb2qeqsu7x8IF1duqEPl1ltPkOLvteHADhE5k0imX0e8vmdmpohnbzMocDnFAmcfXHDWmvl/VNFHOz9Z7gQAxb9w6prXWxjxER92fYYfmLeW0j0QMKkSo/aGowAytz99cZwYeuzNpPPThZfpImI8/2tJCz3MO+wIpjPXx2QQ3XKz6kQbQSbsKBidFL7IUNB9taJkfHxiz5SV8WOGirI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC4WvP1GMxkGknZTclMVT0XFCr/2d+CYw9JozrvB5kw=;
 b=O5KUT+4xCa1bx/r46wu55C56hZuuXtTe1/lQqzK6qghhmBtrQlSodKRUi/5OwYE4Rj/O0T4nzWE4w/o9DKKwB0b4Lk8ZC1+mVm3Tc1OQv0bud83JF2c4bStm6bggWuuMvZZLvtYMJuWxl+nQDI41iHzp3z32CFdq/QW9SV7g7r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:39:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:39:35 +0000
Message-ID: <a81ef96a-e436-44ef-9ae1-e19d55c57438@amd.com>
Date: Thu, 9 Jan 2025 10:39:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] ACPI: platform_profile: Add documentation
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
 <20250109150731.110799-19-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-19-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 770e794f-f00b-4bbe-95af-08dd30cc339e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkpaT3RWZGhFWHdaaVFSMTNJejF6M0RoNTB3WHVDdCtNMTkxWlMrbGltU09N?=
 =?utf-8?B?R1FrME5qN0FTM2tzRVhsNm9Lb2RsbTJEL3dkUy9uZUlxTnZIL2hEY2RPQnBH?=
 =?utf-8?B?UTMyRUNKVFM0cXVRRzlnTjk5ZTJqRVdJWmw3WGduK1kwdE5uS2FnWVZJTUsw?=
 =?utf-8?B?YzZiRTF5OHNtQVlvYnFsQ0plVVdkemdvbzA5MGkxaTB3aUd4TUtmaXJQRitV?=
 =?utf-8?B?V1RDODhBRFpFMndjNEw3eENEUGJnVTY1RkwyYWxSWTIwc1ZmYW9ZcTRnbTFq?=
 =?utf-8?B?ZGtVRHBFeGc2d05SQ1VURTBEaWJGU21Jeld2Nm1YMmJ1MkNmOWxVK2VWelNh?=
 =?utf-8?B?czE0R29rRGROU2lvc1EwT1RTemhiU3JMbUdDTXJPOS8rMXVueE5EK0tucFQ1?=
 =?utf-8?B?SVhpWHlvQ0k2ODI5ZllPMnpTWXVWeGpjN0FnR08rZG5LUWs1aWRPNnB6NVlT?=
 =?utf-8?B?UFhRYUNzMElyVVNPT0xaTU9qNnppK2RBc0RYNFZTSk5ic1VaUFgrYjlQcHA0?=
 =?utf-8?B?V3ZPUlZlT1IvVm9RWEtJaWpHMTVzOEpwbE1JdFR6RWVBTjZDdU9UZHdzVGhH?=
 =?utf-8?B?OXJldndFRXc5dFVCN2RseUJLZTZOM3dORERGMmhxTHdqWnBuTW5UaHYwVjFU?=
 =?utf-8?B?U0M5V0RhV2xuU0kvS1JtZy9yOSs0eGtYTVlJajdQQlMxSHpwNE5MUXdHTWZH?=
 =?utf-8?B?MEg3UFRxVDVnMWE0dE0wNENjaE9HSkEyRGpBSXgwQ1ZBYklIenQ3N055Qlpn?=
 =?utf-8?B?QnErZDRzTjlJVi9WU1lVVnlmeXZUc0RmR0llZTJDUTlCMnBpWnZxV2QxNDJx?=
 =?utf-8?B?dHhPMnJYVVBHVUZ5TjNRNm9ob2YzUm1ST1NKQkpxMjNsb3BFSnFOWTBvZlBu?=
 =?utf-8?B?NE1GTm1qUnFPMlNoS2NaOUJDMDJ5ZVJ4VWxjcG9hNlpnKzNrajA3b2VPQkth?=
 =?utf-8?B?UGZmZ3l0aWxDc0NrZ01sVXRUMXpOelhkdFg5d1pESzVxZkxacTN4MzVFQjdk?=
 =?utf-8?B?RSt5OWFzRG9IQ2xKKzdkSXZBZUUwUFQ2NGJUdjhqeUVHZXROcURpaFdUOFZm?=
 =?utf-8?B?VGZCVzdTMGczcUx1OG5XN2hIZkl6N2RZNnNsY05RNktOTWtYUGpEV3Q4QjFN?=
 =?utf-8?B?U0daa1JYZHh4clZaVnZtUUs5VzQyMERzZytvZDZiVjYwbjlsTUZGVm9IdW03?=
 =?utf-8?B?YndDQk04NVV2aGprNHRIdmxjYjBDUkVadXVFcVMzVmFnNmxrcU1qbGhGem1Y?=
 =?utf-8?B?b1Vqc1VQaUFPYUFRcU9UWVFObWcycGVJZkJidlppWnlCekFuSDdSRUFVc292?=
 =?utf-8?B?K1JaWk9XQnFuKzA0WmtkUVZ1bU1tYjVMR01FRkkxSDFZc2NUeVR1SzJDN3hP?=
 =?utf-8?B?MWM5VysrU0lBTFhEc212WXUvMDJmOElzR3czUG5xWlZHZ1NPN2laenRuWUtV?=
 =?utf-8?B?MzZjcjJaY3A0cTRpcWYvYURkSWJiWWlFeWVmdVNCRkNoeWFCNFZpMm5zd01x?=
 =?utf-8?B?TWY3SEdTU1FWYmFXdkdjamY2ckRhemo3aXNmM3dtWXkzVVByY2JxV2RKMVFW?=
 =?utf-8?B?emlyb09BYnF6alg3K2VxWUV3dUR4LzBOdmdhdzNybWRaeXgvOUEzd1V1L0dm?=
 =?utf-8?B?ZFVxR2V4dFM4VFNUNGJrOXZuT1BMa0QvUU8xNW5ZV1ZCdlRBK1Q4ZXhVd3R4?=
 =?utf-8?B?ZUowTW5YZHVTaTJtY3E0MlJ6ZzFxa2lGZkJMdlVKZTlVQnNoTXlYTTBFM3kv?=
 =?utf-8?B?ZmFPM2I0TVVlaDQ5ZzFTQXVLQ29vZ3dTS1VKV01pckFXL2xnYTB1Vlpad2Vw?=
 =?utf-8?B?ekltM1E1aWFCVHNCMmw0MG9IY1VMTVpvWTJWeTlLUEVWd2x1VVVUZFZaT29J?=
 =?utf-8?Q?F3mFwrCP49f8z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXJOU1ZpTjJ0Tm9hcmxmakhzeUhTcFNZSUdJYU9jemw0aW4xcGpJbHl2TmxL?=
 =?utf-8?B?blRjT3p1TUZteUo5RUF6azVhTFJQaUJMMldmdFV3UFZjM0pkNHJ4MzhKWGFL?=
 =?utf-8?B?U2VCbUI5NUZnYzNXdGNMTm9WclhtQitSYVdtSm52YVNsV1B3K2FGZzdhMVBS?=
 =?utf-8?B?TWRKTnZWaFJaNlg4UnU2bEdsV1phYUVYa0xNNGRJZDZVYjd2bUtVd2FPaU9q?=
 =?utf-8?B?dWVUaStRcW56ZFlUMkRoMWYxUVJEVnhDRWFGalZJL0l2clRlVDF5VjFMWjNX?=
 =?utf-8?B?ajQwNmpRb0VCdDlkQ0lkYXAwV3d3WjR4eHVjRlE1cUo5YitzbytyMkw3UDBz?=
 =?utf-8?B?d1pQc0M3bkNXdzNDdE5PM1lvUlNUTlArQzU4OXg4emlDbkpNZzRKWHVwYXBT?=
 =?utf-8?B?YSt1blNPdzlTV1pLVjg2S2c0VnpsWE81VnVWYlgxVlVFNVgzUmplbjVyTjN6?=
 =?utf-8?B?OFJjQ256b29sUFVySkt1MUtjSlRZM2JyTkZ2bUNHUGc2eXNjU2ZIQlBGK1ly?=
 =?utf-8?B?RE1UdGhTcnFLcXlIRU1NS1B2RE42M1lqZE9uMUNpODJuaFhZWm1WbERidjdB?=
 =?utf-8?B?aStFTTJRbVU4RHdtdGs4VndTLzIva1hEbkhieDVsNVRTSXBWNGxSR3pXYUo3?=
 =?utf-8?B?VnNzNmsxNyt5WHp6MGRwVGV1ZGs0eHlQdHEwVmkxa3orWDlZUGJVcjl0MFAw?=
 =?utf-8?B?MnIwUGJnSkVIMGY5U3ZlM2NiVkxxSEx2UUdlSGErRVUvNU1aNk1sdmtobHdr?=
 =?utf-8?B?Z1dNVTczMWJYektYbjlFdVQzWWdzNE9rbkJMMHhub0YwZkZud1R3UnZVcnZY?=
 =?utf-8?B?TlNDd25obThuY3YzUFlsMFYvNk9uS3VINUdOZUtmbXJla1ZRampsczhxV1Bm?=
 =?utf-8?B?b1FvWWRtZGUwK2RtaXhsc2N2ZGtwa2FJS0l2eVk2TU5ya0FRZHpadzB4R2Rw?=
 =?utf-8?B?cVBpRXRNQ3NqRVhWQ095a1NkTkZNRVZ4N1hWRHZIbk5QcVpIYTYzb254MTQw?=
 =?utf-8?B?ZVU3MG43b2JPS2hOWEtXMXZBMHVxZE5iRytFTmRWa0lTY1A3c00ycHJDTm5j?=
 =?utf-8?B?QktUd0UwU01HYW9IQU1qZ1Iyb1RVcTBJTUpoZW14T2NYYlBzWDNGU3ZVZFVS?=
 =?utf-8?B?cWFLeG1Ua05RUGtsWVQ2QkFoSTVxRWNNa1lqYXkyazYwQktBNWozRmJoNm5W?=
 =?utf-8?B?V2g3eHBvMFdaeFU0cWxxSEVscmwzV2xiYXVYTklQUUdlUEo5T3ROeHVwU1VL?=
 =?utf-8?B?SzNDY01qRitYUHpIcUN2VlpyTUVCd0F6WTBtMkJ6bmJwcytlNzZ4cjMrUTll?=
 =?utf-8?B?alhDRTlCYnREU2tYbndwRzVsVmNDZGdvVlhhdTJGK2Y5UjF3KzhNYWtodS83?=
 =?utf-8?B?ZFd3eTFSTmhGYUZUZ0gzMnJvRGp3M1hiMWNnY3gweDFzRE1IU0k3UWNicWdD?=
 =?utf-8?B?NDJGVnQxUHpPVVFXMEVsZk16Ykh4YmQrY1l5RVV1OS9paWhObmJrZ2Qva0RB?=
 =?utf-8?B?SlpXT29CWHl3WitDQnNIL3hURDZHem1MckNQc1ord3JwSjBsajNqRm5NQnUz?=
 =?utf-8?B?UUQwOHpjS0kxZkFmWStQU1JidXVtNExjNmtEeC8wOGZpL2RDT1dkOTQxVE1w?=
 =?utf-8?B?M2Y0YUp4MUsrNzVxU0NNM0JQejFvKzBCaTFmRXByY0Y3a012Mm9KVmtLdmly?=
 =?utf-8?B?ZFFtVjFOOUx1alJ4dVBCL3p3bndqbGU3WnE5UkFXdDdwMU5uZ0xlL3ltN2l4?=
 =?utf-8?B?M1ByY1J5U1FLS3NXSlRXVDdPejRDNFBaQVRNa2JEZVhodC9Fd2I4UWZWZzdq?=
 =?utf-8?B?bU9xMU5qNTF6TXFUcjFNeTFqdlF5cmhKcU1ReW8rbU5xMXlkUHJxZjFKVE1Y?=
 =?utf-8?B?TGt5Vk1nK05KbHRaMkF1TDBhZEFvNWw1Z0FvQ1JWSFdHOG9CaVdMWjBueHJv?=
 =?utf-8?B?bys2RVV3UkdjSmJzTkszR0dzQVBkcE5GVnVVTTlwUlBEWWh6RkhadHZEMHdw?=
 =?utf-8?B?QlhINDFIK0FDUENRL01odG1HVFp4eHpUUk0xOHdMNmpWQUNyMnFCUm9SenBI?=
 =?utf-8?B?NFppaVBxdmxqbFRaV2pXQ0tHckR2YWgwbGI3YTJyL05NeTdTNU43enRyOXJa?=
 =?utf-8?Q?+MRUPcLxO0cu91X6zZ5A/DA8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770e794f-f00b-4bbe-95af-08dd30cc339e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:39:35.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bCmN/CWzStIT5bXhLRgHexM7/kEMsEHVqVWSSyFzLRamO+Ry6RmSiy5oxQo/x9vW27R01a9YuiaG9mRr4aU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On 1/9/2025 09:06, Kurt Borja wrote:
> Add kerneldoc and sysfs class documentation.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
>   drivers/acpi/platform_profile.c               | 33 ++++++++++++++
>   2 files changed, 77 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> new file mode 100644
> index 000000000000..59486dc4313f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -0,0 +1,44 @@
> +What:		/sys/class/platform-profile/platform-profile-X/name
> +Date:		January 2025
> +Description:	Name of the class device given by the driver.
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/choices
> +Date:		January 2025
> +Description:	This file contains a space-separated list of profiles supported for this device.
> +
> +		Drivers must use the following standard profile-names:
> +
> +		====================	========================================
> +		low-power		Low power consumption
> +		cool			Cooler operation
> +		quiet			Quieter operation
> +		balanced		Balance between low power consumption
> +					and performance
> +		balanced-performance	Balance between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance		High performance operation
> +		custom			Driver defined custom profile
> +		====================	========================================
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/profile
> +Date:		January 2025
> +Description:	Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		platform_profile_choices changes the profile to the new value.
> +
> +		This file can be monitored for changes by polling for POLLPRI,
> +		POLLPRI will be signalled on any changes, independent of those
signaled
> +		changes coming from a userspace write; or coming from another
> +		source such as e.g. a hotkey triggered profile change handled
> +		either directly by the embedded-controller or fully handled
> +		inside the kernel.
> +
> +		This file may also emit the string 'custom' to indicate
> +		that the driver is using a driver defined custom profile.
> +
> +		RW
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 8c79ecab8a6d..5d74675c5419 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -426,6 +426,10 @@ static const struct attribute_group platform_profile_group = {
>   	.is_visible = profile_class_is_visible,
>   };
>   
> +/**
> + * platform_profile_notify - Notify class device and legacy sysfs interface
> + * @dev: The class device
> + */
>   void platform_profile_notify(struct device *dev)
>   {
>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> @@ -435,6 +439,11 @@ void platform_profile_notify(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> +/**
> + * platform_profile_cycle - Cycles profiles available on all registered class devices
> + *
> + * Return: 0 on success, -errno on failure
> + */
>   int platform_profile_cycle(void)
>   {
>   	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> @@ -478,6 +487,15 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> +/**
> + * platform_profile_register - Creates and registers a platform profile class device
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>   struct device *platform_profile_register(struct device *dev, const char *name,
>   					 void *drvdata,
>   					 const struct platform_profile_ops *ops)
> @@ -548,6 +566,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>   
> +/**
> + * platform_profile_remove - Unregisters a platform profile class device
> + * @dev: Class device
> + *
> + * Return: 0
> + */
>   int platform_profile_remove(struct device *dev)
>   {
>   	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> @@ -573,6 +597,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
>   	platform_profile_remove(*ppdev);
>   }
>   
> +/**
> + * devm_platform_profile_register - Device managed version of platform_profile_register
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>   struct device *devm_platform_profile_register(struct device *dev, const char *name,
>   					      void *drvdata,
>   					      const struct platform_profile_ops *ops)


