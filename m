Return-Path: <linux-acpi+bounces-9046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FC9B32E2
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D0FB24972
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8A1DDA1B;
	Mon, 28 Oct 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKKEAxqH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC01DDC09;
	Mon, 28 Oct 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124638; cv=fail; b=nO4Pb3OJUDqXP7XW0sYtQBzy7Nu55Iyi7okFP/q61hKCSeyfi/Mkuqxe+PTWIbUHVx0XEf3ayl2jiofSLrntRdPMOzg1wMoIbWK4PMhYHxDc8Z0sYS/asHTJVFKVwzHn0drhNTmEtRrTFoWNFFk/LmgBoJwKBUZeG76k+ROszg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124638; c=relaxed/simple;
	bh=xp6ibikKCzOHGuGltxUiCTsbvd4JnMzYbX7M91CuBi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEG2i1XHnPx4VrPGvS7/GeC+ydAoyHo7nX/oiXwLqQ4PJPBJ8GSMTTSL7Cl80IZ6uzj834EZ32NBNqNNode/46auvey7+U/EPkGGNPXxUB0Kt4tB0zsSb7DE1dkMRSP8GhTqsCFx2EvECKjy6WhzEZu06MhCx+OupwFzvk5uF/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKKEAxqH; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNQ155KHId4kqJDuKYiN8/FDCHMsry11QcmSa12KgN1+lLXTHAanJv7kYMO0+xWsoA9gBrAw8w0AU7+SDSskrjkR1yUDr6f0QnJq1vJMaXY63s0y8eRnnUBWIBO29JYm2x8bGm8B123sNfFsTWddjXjJCPV0kSYqm7h5NHs68tSA61DcKqc2MEtbFM4fkh8pLl3rc6lelV3duXtC70ti0ipd7c1x+iYAYsjJVIvnFA86GxgAAqGeOD+5JZPB9BmvNcr1RTxAuJA2tyNozh1SSE5ht5xOs6x/YVrYiD8BivSZ9uVHysMyWgGG+YUFk3yaXb8LlBl6RdvLOx97ZPAqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yv7JUmgDMOt3q7yg8l2ICbdO4cOgO+c4C/8HDs2MW0=;
 b=VN1V3UF0w+2kPzUjEW2FbG4NAEAd9ps5Ndqu//2ZZeQrX1gdlRUNE3W6cgEgJTlxzaPJHlilAdBcpGC7HM1Pc+ceK93qFoE95NB49+P8j5NASfdh4B9EikbU57481LG8zvV1HbDM+x24+q/5JBveHH8G//qRbv7X/dJZ78BQ3wpVnauSIvEi85s0Pa05yqC+2T41Tcn3CHzwtX1xefAhxp9y5e02wfMD+NrA8c5MgCsRSkiqNa8mo9fWpoRMZ/ijIFWUAhF0MtKS2ZDyP8llF+amaT/WsKWGAgKISr/0W6Re5MA7u+Pw70CKufoGZQlbP/H5gnd2m/7neGiAcgFZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yv7JUmgDMOt3q7yg8l2ICbdO4cOgO+c4C/8HDs2MW0=;
 b=CKKEAxqH5/7ElE1Y/Pk9KMoeKD+rKG7GY1TvJQ+NaI4AWuXidYaqlaJK4weIqnBRf2ZdQ1IEmt60yxlx/p6viPP9+lQdeqkEeo3ziyHgYv9MvrS7yRMbbkX+ra8KZXrsG7UwDgXcEaSCyc/5EHn4U2dNrPXLxCId9ipmoYHcJeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 14:10:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 14:10:31 +0000
Message-ID: <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
Date: Mon, 28 Oct 2024 09:10:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple
 handlers
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-8-mario.limonciello@amd.com>
 <bfafd7c5-6757-42e5-a3cf-d4695b6723cd@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bfafd7c5-6757-42e5-a3cf-d4695b6723cd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:806:126::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e3708f-2e7e-4e84-75f0-08dcf75a481b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1BHdXcyVUxvaFl5c3lMWWNhQjZDNUwycWJ5TGlsM2M0VjFESThHSjdVSllr?=
 =?utf-8?B?ZjA4Y01rcmE2RjhVWE1WbTlxZlJWRlBIZG10TER6RlB4Q3RIUjdYYUV0bEx2?=
 =?utf-8?B?QVJwcUVMbEYvSjVyUnJ0NUlHOVRscWVncUNxOXQyUHRpUGg4Q3pSZnlRRkc1?=
 =?utf-8?B?bHB1KzE5WVhIdkNnV2NkSVU4dEJ3dUlCNmxWUGpVNGNQOCs0THdSNUxrVXJ4?=
 =?utf-8?B?QkZhejNNTHdVMUtDR2Iza2Nhdkljd1poRndaTTVROHhRbFZaSFRwd1FXM1lB?=
 =?utf-8?B?SUxBSmN2eXZhR1A0ekRGdzRlaDVFZ3ExYnZNdmlMWGJoVXpaRGVxOFZQbDl6?=
 =?utf-8?B?dk1pZTUwQTE1WHFTcjgxNVZKbElseUtGOHBXMko3Y29CRlpVN0ZVYlN1ZFBX?=
 =?utf-8?B?ZElLMUZJQm04MFFHWldFNWRHQXRoc3NxV2lNSVl3dkJzb0FNczhzNm92UzlB?=
 =?utf-8?B?S001TFlMTFN0WjRTRmhMOWE3MERhNVJxNExkdUpUK3pKemR2VXprN2NjcFRt?=
 =?utf-8?B?Zjcyc0FwZlQvZkNBaWpiMmt5Y1llUkNtbXR4b2xNWi9sWkVXUm1KK2F4Y09P?=
 =?utf-8?B?cEY2UUluRnozSFJ3dTdVZW9hdk5YbzZPUXZRZHhraVZxL2F6K3lTTWpiSURs?=
 =?utf-8?B?NW1yL2M1NzRldnU3Y1BtalhlY1JPN0xiVTdmcEZlL29OUHBzK2kzQjhhRW9t?=
 =?utf-8?B?ODRxSGtMcDEvYmUrbjdpc1RWeEdFMTZFVUEwVCtxYytGWURrczFDc1MvS1ha?=
 =?utf-8?B?Nkp5SzNxZnc1eXY0RE1tOUh6dzdOclh4YkUwNTY2eTFtNTBWL01MWkRpeHBO?=
 =?utf-8?B?K2tTbEpHVytiVnBoSHVEZjNhZGtxMkxDZUc5a0Z4VDhvb2p2RjgvOVZWQzhT?=
 =?utf-8?B?ZG1LbGdUOFRLcjR1bFY2SDdmVlRHMDRJL1Vja2pGek1UZ2d1bWoxR3ltV2Jh?=
 =?utf-8?B?bTRKcjVNcGxKV1E2Y241VE1haksvUHlrL3NZVHQydWdGQldHdjhPR0dESkRF?=
 =?utf-8?B?NXlQQ1krMnlBUEdpUTNKRC9acVpMOXYxVkFGR1kyenl2VUNvbW1mSVJabi80?=
 =?utf-8?B?TE5qaFFJTkkxOUljWlJMTVdza0dtUjVDZ09RYnk1RnBzcmNFa3pabnhuR0Ix?=
 =?utf-8?B?eGZ0WE9GU2VYT0RXZ09xMlV1dVorQU9XcmZyUWQxb3JQUUg0QTloVHhUbFBx?=
 =?utf-8?B?QUJkb3VrYU8xVXpodVJqaFdyUmpSQTB4OGMyMjFQZUEzQys5MFlDSlNYQW10?=
 =?utf-8?B?TThMZnV0eEVpU3ZTNFFGNkF3YTdHckdCUHhUaVFtY3VxOVkzZ3gzcjVmYWF3?=
 =?utf-8?B?Z29PUmRNUGdzdXpuQ0YzdEZQQ0VlLzAraDBOcjBQc2k5SXV0UDFHNlRuSjNZ?=
 =?utf-8?B?OXhZVXNoRXBIdnk2R01RcWdNM0lGczM1bDlwcGtHTEFpdXQvTXUzZ0xCaEZm?=
 =?utf-8?B?c1ZJbkJDVkp3VXRicTRDTDI4dnNDVS9PRU94YlY2Y1pSZHhvRitEeEI4Zit1?=
 =?utf-8?B?Uko3WVZOaHRkVmZTYXpvYjVOWFRYUlIxb1ArYktXb2x1cnFWZWtNSnRXVlA4?=
 =?utf-8?B?VU9hN2VuZ1dRQ0VROG1Tc0pEWUhHWGRQT0pIZTFSeXQyVVpvS2xydzhVOUdB?=
 =?utf-8?B?bkZUeGY4Vjc1R2dUb1NiN3ZWbUNmRGg5Z2FYWU42WEZzN3Z3dkx2ZHNDZVhH?=
 =?utf-8?B?UE9zMG9wOXlKTm1ITkdDSld2c2QzSG9raUxKY0tJVjExTEIybVlVaHBvR0gy?=
 =?utf-8?Q?DOj1gBt5hJ7viKddk/zUhVSmX0O5qCmuBs4uy2K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVU0UHdQK2FNWXpaelJya3o1c1RRYlg4VVhDaFdTQW9qejJodGQrVHcyTTQr?=
 =?utf-8?B?alNXR0JXRFJFU1dTUkFLLzIxSW5wWUhrRnZyY29SdHdWek9zdlVWWm1yVXRm?=
 =?utf-8?B?TEVUWndQU2dNMGx2MW12TnVla2NPRE01YktINFljMG1GbE9ZbjZReGdmeFBM?=
 =?utf-8?B?aXRUSmIvZ1hUQkFLWjF5WnB5K1NvbUZzQUNucHVrdGdBNzZaOUpoaE04UkYw?=
 =?utf-8?B?TFpHZTFsL2M5MERQV1luQmxEZTBOOE5uRlNyMXhER21zQXMrNzRxQ1FKTTRD?=
 =?utf-8?B?d2F0ak1RSzE1MWUxTzlCdGhEVmlTdk5NQnVrRGh2SGlMVHZEREFKaHNPRlAx?=
 =?utf-8?B?VmMwT2Z2WlcxQnRVYzladkplTnBlOTUrV1JGS08wSHFiMll2aHY1UjJoK0FC?=
 =?utf-8?B?dmozdXdsL2dPT05KVzNNWUxhcFJTVkc0alQ4UzQ2L1BjVEUyNWw0M04rSDRF?=
 =?utf-8?B?VkZDUUVGbzBzSjBuRXJiYlcyc28xclc0UjhyYXhCaHgxNDQ0TGZ5anJ6R2ls?=
 =?utf-8?B?bVpyVm1wN2d5SkIxbjlMdW9ad0UyZGhsZEtRQVFVQWpyS3JHTUk2SnVwa3RZ?=
 =?utf-8?B?cENxZ1lCakJWR1BCVU5hSi95dE1oU0lIWGpIR05ZV1k0Z3ltc3l4ZExzZ2VD?=
 =?utf-8?B?c0lLbUF4Q3ZPemNEaVJUY2FzeU5kWkx3V2xjL2RCVFVEcVUwSVR5ZVpGRzRq?=
 =?utf-8?B?NExVZE1jRFdFQVdkQU1zcGVuWnlOT0ZXSVhsWmtxWUl2cFhxQi9QUXI5OWhB?=
 =?utf-8?B?RnAxUFVoTVBod3ZJK3YySmtOdmdNdnhiRWJsTURwbGZGNGxFNjUyMGw3UW5S?=
 =?utf-8?B?MzM0bjRaTVpZdEZsK3pHZExManlkQ3pTZVFYN3o0aVhDelFGMnhIZFpqMzFs?=
 =?utf-8?B?Vi9IMHRJbjRYZGJ2aTZ1K1FyWWVFS01pZTZ0VnFldE9UbVpyM0pOVE9jd1hC?=
 =?utf-8?B?WStweEhkWC9kSW9zSk1sRnNTakpPMmhvM1gwMHFBYVFtMTJCbUFUdy8xcDdN?=
 =?utf-8?B?Y3RWdUVnOUNXSE9uVDNEWW9ESHcyelNmWE1CY3lHc3FZeVo0dXA2TllnbDhN?=
 =?utf-8?B?WnpXLzlQcGV3elpOL1g4bVJIRWJNOFlxREp2SmFLWmZqT2hYejlBRzd2QjdR?=
 =?utf-8?B?Y1J1K3NNSFZic0hpUnVIUTZVbS9TNkxaSm4yMGlMb3QydXk1QnVTcDVadENV?=
 =?utf-8?B?QlhlcFQyWnNKZmJzWjlidnVkZ1BmM1R6dWNCejNaUGlEZzc5SGdJcXFXUHIy?=
 =?utf-8?B?YUh3L1h5U1V4aUJGTHVIQXBQbnVvNjJVdDMrTW9OV09pU2orSWVndkozVzdn?=
 =?utf-8?B?SVh6QlJ6YXJWeDVTdFlEN3N5T3FGRjNOVTlTc0p2RVhlaXkrVUZhbkVLT2V1?=
 =?utf-8?B?cnhhMm5jcFY2M0ZHNExLMWRwUHFJY1hhYytvVlZWLy9ielJibWJEUHZ2Y1hi?=
 =?utf-8?B?b1laY0RtYXRwTzhMbUJRU0dJalhQS0dwVU5sZjl0UFdGSWYwS2dYR2RvN0lO?=
 =?utf-8?B?dExmR3l4VDRXOWR2cXdVanB3U29jNVpzL2RrWHpSakhjOXJPM01uZ1d2NVVS?=
 =?utf-8?B?YjZTcE14VlQyZTdGZFJ3Unc3aEtqUUQ4c3NuS09hR2YwdDRqWE12SklNWXM2?=
 =?utf-8?B?UFZNRHkvUnJmMkdIT2ZLemk4ZGpGcFJjTVBDbkVuTmFTZjJCZWpHb1kvZnlj?=
 =?utf-8?B?YTJvSnFuVThXSTJSY2V6eFJZUmZOeS9EZ3AxdTNyQjdBR0VnaE1vcE12ZDZq?=
 =?utf-8?B?aS9xMXU4VHZXenlram9pQ2FrUXNYMjlEN1ZyRGtEZ2tOY2FFVGRSUytKYm1j?=
 =?utf-8?B?bjhzRTFLTkoydDY5czVkajlmWnBmdGlBZnlhSjE1ZHlya3FrZytOTE52Ulk3?=
 =?utf-8?B?cG5vbDVEUkFiUXlKNHRweTNxNkFsN3ltRGxVb1VGWTVZN3NtMjA5NFJkZkU2?=
 =?utf-8?B?b2pnUVJaYklRTFlvZ3ZBbzhXRVh1Y3lNek53bW9aUjZqeENVT2JkTnl6WkdG?=
 =?utf-8?B?SktGSnBLczlUMy9yZzBjc1A2L1owWjV5WXppYjVoanEvVFhDOTM3NVFJeVU2?=
 =?utf-8?B?NlBiV0J4eU5RRVNDRXd0TXVnSnVWdlUrQmY0ZVlrOE9rMFU3dEVSWml1MjVh?=
 =?utf-8?Q?t0J3x/c15vLE5nalVyPjbROU/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e3708f-2e7e-4e84-75f0-08dcf75a481b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:10:31.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECPZO5Td8XguMHaIDAYu64AYO4b1Ja0IltMbBOYHB60cyp++SIH4rOh9ZgDAoyNPEg7nofU0uSMXolBQ/1OgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

On 10/28/2024 06:01, Mark Pearson wrote:
> Hi Mario,
> 
> On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
>> Multiple drivers may attempt to register platform profile handlers,
>> but only one may be registered and the behavior is non-deterministic
>> for which one wins.  It's mostly controlled by probing order.
>>
>> This can be problematic if one driver changes CPU settings and another
>> driver notifies the EC for changing fan curves.
>>
>> Modify the ACPI platform profile handler to let multiple drivers
>> register platform profile handlers and abstract this detail from userspace.
>>
>>  From userspace perspective the user will see profiles available across
>> both drivers.  However to avoid chaos only allow changing to profiles
>> that are common in both drivers.
>>
>> If any problems occur when changing profiles for any driver, then revert
>> back to the previous profile.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
>>   1 file changed, 117 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 091ca6941a925..915e3c49f0b5f 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -9,7 +9,6 @@
>>   #include <linux/platform_profile.h>
>>   #include <linux/sysfs.h>
>>
>> -static struct platform_profile_handler *cur_profile;
>>   static LIST_HEAD(platform_profile_handler_list);
>>   static DEFINE_MUTEX(profile_lock);
>>
>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct
>> device *dev,
>>   					struct device_attribute *attr,
>>   					char *buf)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	unsigned long seen = 0;
>>   	int len = 0;
>> -	int err, i;
>> -
>> -	err = mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> +	int i;
>> +
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
>> +				if (seen & BIT(i))
>> +					continue;
>> +				if (len == 0)
>> +					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> +				else
>> +					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> +				seen |= BIT(i);
>> +			}
>> +		}
>>   	}
>>
>> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
>> -		if (len == 0)
>> -			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> -		else
>> -			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> -	}
>>   	len += sysfs_emit_at(buf, len, "\n");
>> -	mutex_unlock(&profile_lock);
>>   	return len;
>>   }
>>
>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
>>   					char *buf)
>>   {
>>   	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>> +	struct platform_profile_handler *handler;
>>   	int err;
>>
>> -	err = mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>>
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		if (!platform_profile_is_registered())
>> +			return -ENODEV;
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err = handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +		}
>>   	}
>>
>> -	err = cur_profile->profile_get(cur_profile, &profile);
>> -	mutex_unlock(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>>   	/* Check that profile is valid index */
>>   	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>>   		return -EIO;
>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
>>   			    struct device_attribute *attr,
>>   			    const char *buf, size_t count)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	enum platform_profile_option profile;
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
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		if (!platform_profile_is_registered())
>> +			return -ENODEV;
>> +
>> +		/* Check that all handlers support this profile choice */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			if (!test_bit(i, handler->choices))
>> +				return -EOPNOTSUPP;
>> +
>> +			/* save the profile so that it can be reverted if necessary */
>> +			err = handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +		}
>> +
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err = handler->profile_set(handler, i);
>> +			if (err) {
>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>> +				break;
>> +			}
>> +		}
>> +		if (err) {
>> +			list_for_each_entry_continue_reverse(handler,
>> &platform_profile_handler_list, list) {
>> +				if (handler->profile_set(handler, profile))
>> +					pr_err("Failed to revert profile for handler %s\n",
>> handler->name);
>> +			}
>> +			return err;
>> +		}
>>   	}
>>
>> -	err = cur_profile->profile_set(cur_profile, i);
>> -	if (!err)
>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -
>> -	mutex_unlock(&profile_lock);
>> -	if (err)
>> -		return err;
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>   	return count;
>>   }
>>
>> @@ -140,7 +148,8 @@ static const struct attribute_group
>> platform_profile_group = {
>>
>>   void platform_profile_notify(void)
>>   {
>> -	if (!cur_profile)
>> +	guard(mutex)(&profile_lock);
>> +	if (!platform_profile_is_registered())
>>   		return;
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>   }
>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>
>>   int platform_profile_cycle(void)
>>   {
>> +	struct platform_profile_handler *handler;
>>   	enum platform_profile_option profile;
>> -	enum platform_profile_option next;
>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>> +	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>>   	int err;
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
>> -	err = cur_profile->profile_get(cur_profile, &profile);
>> -	if (err) {
>> -		mutex_unlock(&profile_lock);
>> -		return err;
>> -	}
>> -
>> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
>> -				  profile + 1);
>> -
>> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
>> -		mutex_unlock(&profile_lock);
>> -		return -EINVAL;
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		/* first pass, make sure all handlers agree on the definition of
>> "next" profile */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +
>> +			err = handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +
>> +			if (next == PLATFORM_PROFILE_LAST)
>> +				next = find_next_bit_wrap(handler->choices,
>> +							  PLATFORM_PROFILE_LAST,
>> +							  profile + 1);
>> +			else
>> +				next2 = find_next_bit_wrap(handler->choices,
>> +							   PLATFORM_PROFILE_LAST,
>> +							   profile + 1);
>> +
>> +			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>> +				return -EINVAL;
>> +
>> +			if (next2 == PLATFORM_PROFILE_LAST)
>> +				continue;
>> +
>> +			if (next != next2) {
>> +				pr_warn("Next profile to cycle to is ambiguous between
>> platform_profile handlers\n");
>> +				return -EINVAL;
>> +			}
>> +			next = next2;
>> +		}
>> +
>> +		/*
>> +		 * Second pass: apply "next" to each handler
>> +		 * If any failures occur unwind and revert all back to the original
>> profile
>> +		 */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err = handler->profile_set(handler, next);
>> +			if (err) {
>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>> +				break;
>> +			}
>> +		}
>> +		if (err) {
>> +			list_for_each_entry_continue_reverse(handler,
>> &platform_profile_handler_list, list) {
>> +				err = handler->profile_set(handler, profile);
>> +				if (err)
>> +					pr_err("Failed to revert profile for handler %s\n",
>> handler->name);
>> +			}
>> +		}
>>   	}
>>
>> -	err = cur_profile->profile_set(cur_profile, next);
>> -	mutex_unlock(&profile_lock);
>> -
>> -	if (!err)
>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>> -	return err;
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>
>> @@ -190,21 +224,19 @@ int platform_profile_register(struct
>> platform_profile_handler *pprof)
>>   	int err;
>>
>>   	guard(mutex)(&profile_lock);
>> -	/* We can only have one active profile */
>> -	if (cur_profile)
>> -		return -EEXIST;
>>
>>   	/* Sanity check the profile handler field are set */
>>   	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>   		!pprof->profile_set || !pprof->profile_get)
>>   		return -EINVAL;
>>
>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> -	if (err)
>> -		return err;
>> +	if (!platform_profile_is_registered()) {
>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +		if (err)
>> +			return err;
>> +	}
>>   	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>
>> -	cur_profile = pprof;
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct
>> platform_profile_handler *pprof)
>>
>>   	list_del(&pprof->list);
>>
>> -	cur_profile = NULL;
>>   	if (!platform_profile_is_registered())
>>   		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>
>> -- 
>> 2.43.0
> 
> I'm still going thru the code changes - but I'm a bit unsure on the implementation itself.

FYI, I split it up in v2 to make each chunk and intent behind it more 
manageable to review instead of patch 7 being "so" big.

V2 covers some of the points below as well based on some feedback from 
Hans and Armin.

> 
> I'd expect that one of the advantages of having different profile handlers register is that you could support extra & new profiles that might be wanted. For example the recent discussion of the AMD handler providing better tools to tweak advanced system settings for gaming etc. Won't this approach limit that? You'll only be able to have common settings.

Well that RFC it turns out won't really be scalable because SPS is done 
differently in AMD Strix and newer.  I haven't revisited it yet.

But yes this approach would conceptually limit that idea because common 
settings are all that is presented.

> 
> I find having a common profile and two different handlers a bit tricky on how to handle. My concern is it can easily lead to conflict in settings.
> If two handlers are doing different operations to provide the same effect - then neither handler is (probably) providing what they think is required. With your CPU vs EC example, the EC will often set CPU clock thresholds and the CPU profile handler will be changing that. If this is done I think it should be explicit to the user (admittedly I'm doing this with my Lenovo hat on - but we certify our platforms with our EC profile handler)
> 
> I could see providing two separate handlers. e.g. balanced-A and balanced-B (for driver-A and driver-B) and the user maybe choosing which one they want (or both - though the user interface for that is definitely tricky)
> But choosing one option for two different drivers seems confusing and with unknown side-effects. I appreciate it's complicated by your example wanting to add CPU and EC - I know how much work you've been doing on the AMD CPU front which benefits all systems.
> 

Thinking through your comments I guess another way to approach this 
would be "per-driver" sysfs knobs.  Here's my thought.

1) /sys/firmware/acpi/platform_profile_choices would contain only things 
that are common and if there is something NOT common then also the 
string "custom".

2) /sys/firmware/acpi/platform_profile would accept writes for 
everything in platform profile choices except "custom".

3) Each driver handler would also export it's own sysfs files to 
represent the driver state.

3) If the user changed the main knob at 
/sys/firmware/acpi/platform_profile then it would change all driver 
handlers.

4) If the user changed sysfs for any driver individually then the main 
knob /sys/firmware/acpi/platform_profile would export "custom".

Hans what do you think?

> Another concern - would this mean that another driver could limit the options available? For instance if someone wrote a new 'mega-turbo' only profile driver and it loaded - it would then mean no profiles were available for anything as no profiles matched?

Yes.  I don't think it's a problem in practice right now (as we only 
just recently have two drivers vying for this position), but it /could/ 
be something that happens.

> 
> Let me know if I've misunderstood the architecture. I didn't fully get how the ASUS and Framework platforms were impacted in the intro I'm afraid.
> 
> Thanks!
> Mark

Framework isn't affected, it was just showing that there are platforms 
that use the BIOS/EC notification concept and not just SPS values that 
the driver programs so it can't "go away" to solve this issue.

ASUS is the only thing affected right now.

