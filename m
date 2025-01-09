Return-Path: <linux-acpi+bounces-10475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41276A07DBB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B23A83FA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83501221DB9;
	Thu,  9 Jan 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VrXcUWAq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66E223336;
	Thu,  9 Jan 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440572; cv=fail; b=YCXiVAtKKkM/kmd+/pSxIjf2xRzT7GpssaEo+kOvoN3XomW4Y9A9PBCZcskZt+2HG6pE0Ys4HqUhZjHScDjlxzVC4jToC/bI1KyaT66E5urpdWcsWU9GVHuU+BZ0rrxwHXdN/EEdODStQuxElbiEypux1p8zupYBLxLvN6hWakk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440572; c=relaxed/simple;
	bh=Esg3JzRAhhqwD9A1UZVUDtcW3vRgjuZot5AxhD1zkeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAEsItDpf3fz4dzhyFUGu7CzhGyDUobrNAPJKLBt3e2FXi4BC2JO/7mzi7SSrr62GTNR7drwkZEPyLfAC+XtXRPFvMVY3qGFtzW0metfUpp06XiL8SKGIJ2YBdEhgx8aDzAwNuEBH6Qq5tyHy3Rl6Etwn8V3KxZXlVK36Yhs+9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VrXcUWAq; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOlyJOOxJMEkFmIO6Fq3K7CHpm52aU6cXJUXYf6GVtZi+CbPf5Ts5518Fz1GAv5d77y3Hdojzn6cjiRfmvVA9K3deBeufgoAlTru66BaEanzDpIeu/v1sKDiOECKyDUgWQXMRsOZKWpswwGKEduD8gZy8dihYejCJaGEc7+UbMPuEdYxL41XMAGAIwPqexfAeQbZQ4jbIeBIa1yrKyC+dV4tZ/HCc+pzTsuYvxcBC0f8+h8slLwqYZcrjsg1chWlt8aLGUd+qwOaMaNKbd2V7A+N7ReaUjYBD7Orm/UQqBx2ovagSuJfcwjaeIx3i35FS61febfUdjZwJKh6QqmMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtGROn6nUomJdhmvcjHPr3Q0lujaWboXoHK8x08Sh8E=;
 b=OSXFi4Dhd71xv64ps5Gg8nNyv5C72KIlsjzHejb1XC59udlATH22/pTC9/o0fEHEI10oEIYoeCjrB21wbi+jRRDqb6TAD561pjqgbbWawxyFLEghwdPDRx860ZIMu8nnkbFS3ao+r47xzcLAJiaBKHWpEG3SBPSnbtgyVQR91Iu0k9KzmOtz590J+IqNLgHxZR2BmRq7m7DhLyaizw3uVWCMtBkw45jNfF6F5gOIH2EIZ5F+a3lyPKRx9pdnt6g6364Q93T3tSiJqkDjJBt+1vdD6sjxEUK2pMcj+jyE+xcwq1e5HK5A/tutOkIi635IN2mvkMAA41Jnk08yEEyrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtGROn6nUomJdhmvcjHPr3Q0lujaWboXoHK8x08Sh8E=;
 b=VrXcUWAq75usDbJLeNSU7eojjGGp5p5mvSOtt8NsSZhguk2t5JBVv/pgWKWAJtQXHnO16rESSnefRvHDKBzOu6H5F7UfMfS90JECUL+y3KbQrHxxF0NQ7Mtpv5fQgi8Zky5TaLu2NyBbUvQK6q7wqOAq7fVr2/2313HWvnAUCRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:08 +0000
Message-ID: <fe620a84-6e4c-45b8-a53a-4f176c666f9a@amd.com>
Date: Thu, 9 Jan 2025 10:36:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] platform/x86: dell-pc: Use
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
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-10-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-10-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3079a000-983a-44d3-5b5f-08dd30cbb818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0hiY0x6Ym1GQnlHYWRUU1hoanlaWFVqU2cwcWQ3TW1za0VGMDNnVjBJTnVM?=
 =?utf-8?B?VitqR05RVEE4em44dExaVmwySHVqZ29EVjVrblJWdXdUWkpDN21nTzBIdTZi?=
 =?utf-8?B?YVRCQkdmNDhabGRLTWRPcDFQYXJ4MGRKVVduWjVtVmRWakVQZHZoeFpCQ3B0?=
 =?utf-8?B?VlVEUEM2YVE4eG0vcnNHUGdSZjRPV01vdmNtQlNQNlhsbGk5NWNhSkUrbnBR?=
 =?utf-8?B?N0NSOCtZeEJxMW5QYlNGTnBoSTJIMXB6dHA2Z28yaVRxQ1E2RlVvY0E1UlNR?=
 =?utf-8?B?cTY0WUdhZmxXZkxwZFIyTmJnUk9XTkt6a0Z1K2llUkVLYkloVlphL3JwS1Bx?=
 =?utf-8?B?SXRjMGplemlyNzJ3M3FVa0R0dnh6RzYvQUp5WUxMV2hNVERjQnlPWXN6Z1FF?=
 =?utf-8?B?YnpKY1lqMGdWeFJQVlBZeHVJYmswc2VNRTB4OUhuRHUxUUZQcm0vTE1EM1V5?=
 =?utf-8?B?cHV4K0l3dUtsaHJDQ0dpbE5IdHBzOWFzeTQ0SERpSlBUS2YyaSszYjZqT1hX?=
 =?utf-8?B?Umo5cjlnQWNGYjhBaitIdmozT2F5RjZBeHhaZFBVRmE1TXBORWxEdU9CR1Fq?=
 =?utf-8?B?MSt6K0MvRGR5aTRUOGUybEFkL3huQTBGamxSU29LaVJSQng2U1lqQjNGSW8z?=
 =?utf-8?B?Mm5SQm9vd3cyM0xma0ROWWdXckpabllISTVITGlrQVdBT2JKU0hQWDBtU0hm?=
 =?utf-8?B?a0M1WXR5U3ZuZEE3RFM1bE1pL2cvdHUrNkJzcjJWcFQ3TFFIQjFmbi9Nellu?=
 =?utf-8?B?UytvWXBZY2JadmJkZFhxbUYyM05uTkZ1WFhEdm9xTTZITUw4YnR6Z1BmNEky?=
 =?utf-8?B?Rm8yWnYxa1ZsdTQ4cTd5WTJkcXZkWUM3ZEliQWpFaDd6eDdXWndPZkd4RmRa?=
 =?utf-8?B?Q0lxNTB0M29DQ2kyeGY1NDlqSm96OVUxOVkycFNFMG54MlQxYmNINXVhWklF?=
 =?utf-8?B?UU4xVGVyWW5OOWVxSjUwWVpOY3FhWTFrczhaNi85T3pOZEdwenc1am5CSkkr?=
 =?utf-8?B?YUlDK0JCanlQMUhmYkhNaGZHa3RqR3lqbWVxUFlLeXZ3MFExUGFWRVg5Ni9E?=
 =?utf-8?B?bWcycXRjN3lxeldFTWZVQzQxWndKenJwc1UycnVBYkpxdmlrazNzUC80ZnpE?=
 =?utf-8?B?NElVRkNYaXBVZERDTkNrVGJPNFh0VmM4by9HY1N1MERKWE1pM05ja3pWdjd6?=
 =?utf-8?B?Z1lETVFMaVovc2diOHFmYzRBRGNSdmQ5a2xSdG85Wng2dENQcGRNeG16cndj?=
 =?utf-8?B?TnlmNStWTnozcmlEMC9Ndk5FOWlFdjFSSTVLcnE0cE9OTUdabDhzanplbjNJ?=
 =?utf-8?B?Z3Q2SS9rZGNaVTVPL2xKUktEcExWMkNUMWREb2M2ZHo1WFVhRnhYTWJKNlVh?=
 =?utf-8?B?TUNyRVJTZEorNGFUazNianc5ZitUZWVuZVpLZTdmamJFbEVvR21tN2dQbjdL?=
 =?utf-8?B?VU1XWDFEdnU4SmNNanlGL2FSdU84ZkUxamVaM1VLTEZwbmUrdFVFbVRodG5o?=
 =?utf-8?B?ZGdoNGlEdTcrZ3ltUzNKc0phWlpaek1MZWJWZHliQzZiNHY5UVNXUURjdlhq?=
 =?utf-8?B?S05PQzczd1NDUE1YUlVrYnhKMlhuZXA4dW5mMitJQndtZjNpRjZzV2tVMnFj?=
 =?utf-8?B?MnEvNHprTUFJSGh1bkRtNFNtb1NNVmVBMm9SVFUwdVRtRkpPdXpadE1lTnRS?=
 =?utf-8?B?NlNQMmx5WDF3a2pianhVa1VERGFRM3pjNEhBM2tOdnZkRzJ4T2dRVWl1UnBl?=
 =?utf-8?B?SWtPK0RTOGJidTUwb0xETWIxZ3hQVHNpTTdTeDdhZkVZNTNYMnp4Z01rUUl4?=
 =?utf-8?B?cTBoSnpxYTVOdTVRcDBvUHAwbGNDWXhTYmZ4R0xUS1JXQUZvMnc5V2RJa0Vq?=
 =?utf-8?Q?EJQE5S+rfbfOL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdCaVIvY2ZkNVdkZjY3UFd3dE4ySEJFcHYycWVibnhaMkdUTi9XV3BBKzVw?=
 =?utf-8?B?YURTWDRuM3hHaVJlMWpyTFJBWUxIWkNXbHpXUm8zQU1TOStQbVRHM3dVVmtD?=
 =?utf-8?B?RWlQRzEzNDgrUUw4TVpFUnk5QUlnVWFuY0tQdEdpaWpYYkp2NXlZaDdDYTNn?=
 =?utf-8?B?TlhRemJFSXEySnI0TkU5TE5DRGxtQ05rL1ZOeW9lYkwvTkFJa3pMeVU5RHBK?=
 =?utf-8?B?WEN0VEZVenczUnMrL1pYUVFURGdqZkVISFVCR0RqT0c4bzV1WnZmY04xRExD?=
 =?utf-8?B?cWlHSGp5Z1ZuRXViWC9KWVFlU2dKKytUMjBnSUZzSU9aL0thY2VXRFVreEhH?=
 =?utf-8?B?RWpKV0FsVUlseVF4MUdwQ2JUZ1cvVXJMTU41T2VjRzF3RXI1enhxdjVrVzhi?=
 =?utf-8?B?YjNOKzdoUWdpSW9oNlNTdVZ0YWRMYm1ZV09XeWlHZnZ3aFltb3REc2hVSmFw?=
 =?utf-8?B?blVqdTUxZ2RRVFp1NFhrM1FOeEM3Y2JzYmJqR0loTk1TQ3A3K1NDTWJyZGhL?=
 =?utf-8?B?dkhuM3ZEandLQzhjRm5xR3NXNHBYanBTUVRNTWtFYS9xUjF2UlRhUnFiRjZC?=
 =?utf-8?B?UDEwNkNybEdaSml1dkFQOEtxQm02LzR1SW81VTVvd0ZHYkJIbXVIOWozTGMv?=
 =?utf-8?B?S2dCTkl5VUppT0ZBZzdWc0lVWHZkSFRReGNvaldmQ1BSSFk0bjRrRUtIWS9M?=
 =?utf-8?B?eUtUa2tBbSs2K1IzTDUvM01oS0ttY01JTWhmY3JoRm9jek91SE1HSUNZNnRG?=
 =?utf-8?B?L1NrOUdnejVwZ1A0ZWgxblN0NHJoSGhXUklEUkNpRVZuOGlLbWVHejZlZTU1?=
 =?utf-8?B?WVJJeVVKV0xiNXJmYW9GTFJQb1haYkpZSy9jWXR1cGxrUnNNL3dJcEpFMDZv?=
 =?utf-8?B?ZnJud3NXUUNrdFE5REpnazlndmplTllXYmFKeGRZNzNuN3p3UHk2Z2dkYzQ1?=
 =?utf-8?B?YUtYaXlKaVBZMjI2NXJYcGNSRk1heVlzVjJLclU4Z1RlbGZobGpSMUZhWXdH?=
 =?utf-8?B?RmVGbnJhZXBQSkpMUHhBSDE0UTBWUVg0OHZGOCtFR25QTDNxWWxQM3NyRUR3?=
 =?utf-8?B?TDVuV1BpNGdjWjNYdGVWQVNjKzQwUUhYcEh3dWV3c0o0U1RQTDByRG84ZDFH?=
 =?utf-8?B?WmJ2bGtmRTVxZDR3eVlSc0RaVmorYTVIakpZM09ZaEc0NEM0STRSYWc0SWlk?=
 =?utf-8?B?RzN0ZmRoN0tWcURHTy9ibWtSbk00Y3hrbmk2enA4dzZNSkVJNmlMdERTK2d1?=
 =?utf-8?B?OUFENmVlYm5kL1cveHJlK1lNK2phUWxsTVBjalMwMDZQZ2F2VC9TUmJQY2xP?=
 =?utf-8?B?aWNDcXgvc2k5eGR5NlY3SytWN0Rjd3ErOVNISHMzNGJRMUxIU0Zoa3FvZ2kx?=
 =?utf-8?B?THBFMzJxOGphMVd2cEdyTjJETDc1T0JiTDBDYVRCZW5BWTBFWTJ0cXRLekFU?=
 =?utf-8?B?QUxNQ0JOUGQwdWh2QW9QbkRDUGRkSzc5c2F0c0RkblR3NCtBMFowRGtvTUVF?=
 =?utf-8?B?eS9EMkpobklNSlEvdjA0elQ1VkplaStETTZWWGkxZE42OWgyUzVwaytNdEla?=
 =?utf-8?B?V0Y4cGovTDd2cnYxMEpUdVlDeENsVlh1aWF2Umd0d2dFOG9lNysrZTkzYU1w?=
 =?utf-8?B?SzZBTW5LZENlUW5CMkZRMnlLVkZRdHpna09LSGF6VVM3MjhOWXdEUThsOFRi?=
 =?utf-8?B?TWRwbVhna1ptdTRIVGhBNHF6RSsxRmNpclJQVkY2VXJVeU5Mc0xKaXpBT3cv?=
 =?utf-8?B?QmN6a1phTzh3a1BVMGxtME1nTVFPdFlSTDRta2Y5amk4L2ZPMjNjNTY1ZXIv?=
 =?utf-8?B?QkllM0hkRE5YenFzd29OVVRFOEVjb3hoNWdzNXh1UFNsNDVxRkhmYWZuRTQv?=
 =?utf-8?B?L3padERmK2dCd2IrWEJlcU8zbGRad2xXRXRYTGlLakNLT2E2SHRHZ2NJVUhi?=
 =?utf-8?B?TVEvMDZrMVpxSmJlVTZ3SWxBK2dIZW5TQkF0RjFRaytUb3g3OGlDSGo4OHR3?=
 =?utf-8?B?Z05BeUNpSUpTN0ZoSGc1biszTmlmZkM0S2ttMjYrU0dKYzFxYU5yUGFWeFhI?=
 =?utf-8?B?NlU0bmN1VmJUNUxtVmtnWlhhTmViZmhZMVBXd0RLMzZreUhkbWdMSlVVRU0x?=
 =?utf-8?Q?NylfRbVEXnST3541IyjMN+27J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3079a000-983a-44d3-5b5f-08dd30cbb818
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:08.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5EtvubjPdVle8F77pAInCRnmAz77U4axhuukb7nMa8SHvMQ2rUx0Pltqk8DE1o198vLr2HtrWsKq12fQSBPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/dell/dell-pc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 1b6e60a63491..dda6f13295e8 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -281,7 +281,7 @@ static int thermal_init(void)
>   	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
>   	/* Clean up if failed */
> -	ret = platform_profile_register(thermal_handler, NULL);
> +	ret = devm_platform_profile_register(thermal_handler, NULL);
>   	if (ret)
>   		goto cleanup_thermal_handler;
>   
> @@ -298,8 +298,6 @@ static int thermal_init(void)
>   
>   static void thermal_cleanup(void)
>   {
> -	if (thermal_handler)
> -		platform_profile_remove(thermal_handler);
>   	platform_device_unregister(platform_device);
>   }
>   


