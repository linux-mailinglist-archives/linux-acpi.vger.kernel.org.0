Return-Path: <linux-acpi+bounces-10474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA96A07DB2
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC257188726D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18015221DB3;
	Thu,  9 Jan 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NhRav4uv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECED249E5;
	Thu,  9 Jan 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440566; cv=fail; b=ub3cl1Yytk1arlRXprZcru7uql3YMaOyQ9HPBKQYx7xSL91dK33smu7PICC8izLZ7Ci0Wsnp6+wBAP6R2x6GTP32Yggk7/Jk8SksG6RetcsKEGB8RTEvkNYxvOHSEIoNma0xHMBH2UR9wFfzdKTF1csOLs+aGRvrFdgKV2ScRdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440566; c=relaxed/simple;
	bh=gmAMvvzYTS2bFSFxPERRcoGgOwFzRcyZahN0NuPtFrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPFWZyB85aci+vPD0aVBwyjB5tyyC9joyKlRm5aw4tuvYzItPVoBoGaskJWg9qHTI3K8lJ6btySL4hfk0NWAHE/ROmkf/WqHk2NY499jwR5f9XnUSdSIUDTXpYEUmsCHrHrnF2aTgNm3LhintyTpV++LJgvezvKNY7ONyb5ZLUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NhRav4uv; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH/BLDG9HUJUXMMmiLs+/QEqpKr6qoQiKQfWUQyXuqW9BFiMJ7SXTv70Io6wVhS1GUn4ZSyvsUFpejYmdwKxxGaB1XQYmWdWzLGKklEwTf0+Js9+OuiwXKU+3EKKwYzr5UhvXF8VZF+KNJ6RZJ1qH0oXi7O7tdCnJpbuLbz+tq7edklT1wXzUnd2UIaHVVmP6aXFKPFOWcm16w0FEwg3iq+49I7xLs/17O9nPbQ91gC+7IV0gSQJrF0Usu8PM1zrLDlYiGZEVmO7fwacJwG0Jg2FNiWG2Aut2V7NW4gGWTV+63ZNMAx3QXnLlQ+3plshmerakJdGMhBonT5nG1Yl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfNq+sHPr6BEt9A8YVup+CBAXk5nmEEFT35yv7HgAlI=;
 b=dc+zgLckLF+szxbWB8eMDAzuyohlvhwavmDV0tXflNpWGjG8DKItU4H+5D01N/0HNJACDZ1zKiMVWB89r8Q0wHu44f/fJTLDsSPHjzpctE/Kqj3uuMABhW7zeTjJXmhOcSHYRY+gj7xHDDVGbFhFyrYoEKXancgsHWs7e2G9wsYsu+OrRafSSxVvOCUoKPKj2HI2t/ajgZqMOgIV0sApBXXHmGyYMI7Cb/uUTFZpXYVGFF602syY1LgVEec82XqibmmTTm/VaiRHlGoODpQgnYuKrez/9kzmQNqo8tCIKJICBZhGh+YaxAYbxKv5Q1y5FG+bsY/KA+S9xF8oKO2wAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfNq+sHPr6BEt9A8YVup+CBAXk5nmEEFT35yv7HgAlI=;
 b=NhRav4uvDOYx+yJSRgJRIze2VLNwHZZ8KJmHG9IvSuXJqYj0LQbxt0KtCbeuKBcNc/8GglsBG/p5fbroE7BBRSO4SGf5imNI2eyZc706omHRzmeLczhvaGQ3/Zvz3ziLBO6P18CHR/3iA3v/9YHP6fN7gedkjU1VuGSfFnuh6OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:02 +0000
Message-ID: <76f5b0e9-0f19-497b-86dc-4abce12d304e@amd.com>
Date: Thu, 9 Jan 2025 10:36:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] platform/x86: ideapad-laptop: Use
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
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Ai Chao <aichao@kylinos.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-11-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-11-kuurtb@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 930ab382-edda-48c7-6d68-08dd30cbb472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmRrcHc4QlpHblVROUVOZWxjR0xsNUluWXlTb09aL2o0SDJNdS9kaFpuTlBq?=
 =?utf-8?B?OHBtQ25XSStJdTFhMGZ5bUhaZkk1cDRtbUNlQWs0a0VncjYxM1ZvM1NPMGhw?=
 =?utf-8?B?cEk0QTM2Qng0NjdxRFc3TzNPUExOQzBDZHN4N3l2OG5zUW4wMXc4Y285Q0xV?=
 =?utf-8?B?cVc4dktXekdDQTJjdTZGT205NGt2cUtLSnUzRmh1U0xHVzlHZzZVT0Y3NWlT?=
 =?utf-8?B?N3JKaGR4T2MzNnpSSDROMVI1OWNNdEE3T21DVlRyWjNoZkhnKy9jcDBSTnli?=
 =?utf-8?B?dlUyY1dJVjUwcW1PVkd4WXdKRnl6UUhTRlNKZ0U0RWNCalRRTmlsTGdWU09U?=
 =?utf-8?B?b0dlSDZ1a05VNlBtN0o5NjZFYTZuVjUrUFJ3ZXlmNGZzRWk2K0J2bVBhUnhn?=
 =?utf-8?B?a0E0eUpDTnRaY0tjbk1PZ2orczk1K0pVTHIzZU5SRXkySVhBUVltdnM2SFhI?=
 =?utf-8?B?YUJuVmRVSDJWUEdaM1Y5VzBLZWlxdUVFUHJBditRUXJpaWNhdGx1NTl2OEpm?=
 =?utf-8?B?YmZZMzBTVDhvOTJNaUNVU093ckxwVnhnYk9HSFYvdHRkUUhMbmQ3QS9nek14?=
 =?utf-8?B?UWFrZExjdXlWN29DYTY0QzN2dUh1UFlQd1RQSTF4TE03d1NEYVB0R0lSQkg3?=
 =?utf-8?B?MFJTUVR4MjBhTEZFZmEvT1JZSDhJWXgza2g5aE1lTkJ0d0U0dkdoazczWnd1?=
 =?utf-8?B?V0NMQkh4OU1CSUVTTE5KRHJkdldIemwwSkIranU2OS9qb2NFUGZ4bkZGdU9o?=
 =?utf-8?B?OG01aDB5WGJ3UTQ2MHltZVIvcDdwTkt2ektYeDhVVlEzL1BTdTlMZU13anpy?=
 =?utf-8?B?MWNKZ3R5UFdsc2RnUllGRWtMeEg1OWovWUlnSEcvRGpLYUhabmxrNCt0REJN?=
 =?utf-8?B?Q1BoZGNCSDJ5UW1FWTFTWjBmQjNSRFRySyt2QkNXdU5lU2M3THJ0d3V4Ukov?=
 =?utf-8?B?NmZMTm9xc05zdklkQU01RjRPWHpRR3gxTVI2WG1helpmWmh6TnlYa2hMais4?=
 =?utf-8?B?VDJ3cFNzNUhFRlZaU05WSlBXMFFRLzNCeWNpMmVOc0xDUS9tZzgyTEJodFha?=
 =?utf-8?B?T3RaMXZNeVZiSElOUU91d3l4b2hjdi9NV0V5dEhodkhrK01VSHJ1UHZPcGJI?=
 =?utf-8?B?U01HM2NNSFpCeU44TFlaN0dRWWF6U3BEMGZoMXkrd0NIQzNkZVhsVXVlTUFW?=
 =?utf-8?B?eHNrUWtHKzlUMDA5K2RyZU5zSHF4TkN6L1JIVWN5aTA5UGJ2VXo1SkJqQVYy?=
 =?utf-8?B?cHNNUXNKYjJLOFEyZzZRQlF1TDdvOE42UXl6THh1ODBXcFhpMnhuV2xnYXpq?=
 =?utf-8?B?NzdVdlRkV2tCNDRCTjVTR0tWbnl2NTgxN05hTTBkS2tkQmlwbFlLdlJIT1M5?=
 =?utf-8?B?RldqYkxDaHlHbVdaalJCVTJncWUrRTB0a250SmhoVmNxdXpKY04vTDNLdTFQ?=
 =?utf-8?B?NWpGbG4xUjdUNmdVN2JQZGJDUlJ0RVZ3TXVvdjI4OEhZNlZHRjczdE1TYXhk?=
 =?utf-8?B?Z3J0WVVmUWx0R1AyVU5oYTI0NmxZZklrNU5ENlFPWGpqSmI2VHVyNkh0d1Ur?=
 =?utf-8?B?SExJcWIzNGFyaU50VGNHUWJkNGdMcEtYMEg2dk02RzVtVklFSlNXalBYRkFv?=
 =?utf-8?B?bGJva0VPamNpMHJEd1NMUWMxOS9IeWc4NHpqVU5NdENja1BDTk5ZMnFaMkdL?=
 =?utf-8?B?eGs2T3VYYkxCbmM1UDMzc28zVHRnbWk2aE9wWGsxN0JPUEV6dzNxNFhSSGpO?=
 =?utf-8?B?TVpoaHRRTzNlVnJBNkpNcHNub3N6SWhIcDhybUxOYlBlenZwdDBmMTdvTVhT?=
 =?utf-8?B?MG1KTzdhOTJORVI5SmNrcVVDVEJRQzJUM01JeGc2RjBmcVZhTmx6WkpMZUtT?=
 =?utf-8?Q?Ry3q2/wYTJsxK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0hJbHBSRldLd3R1SnBYVy85T0UrZlpUNGM2VTByVEJ4UWpoQ0I4cXdPL0R1?=
 =?utf-8?B?bk9ENmVUNCtiQ2VUSGhoK1pXNUtIbWVGcnNyeFlaT0RXUGJwbExnZG1KUEdh?=
 =?utf-8?B?MXJZN2RxZE1Dd05xQ3QxU3pYRC9pUDFwTCtqNGpNMVdCWUd0enUwSjdPNFRN?=
 =?utf-8?B?cHhuWnZIT1MzWlVHYkJZTlNVVHdPaWdBUWlOcXc4S3ZuN25BQmpuRStzam5v?=
 =?utf-8?B?QkJ1Yi9BNlRPQmpEQWVhMWlQelFvbDVoYUczU2tLREQ5NVZsVUV5cnlpRDZu?=
 =?utf-8?B?NGJxem1JaFZ3MXNpNDhqd1o2R21GT0F0eWE2WW5tS2VWUGVrK2ZOekNlcnBU?=
 =?utf-8?B?MjdZQXdxcjhxQVNsamd3ak9yblFNdm00ZjMvek1SelpvRTFwUUxYMGVTa1VU?=
 =?utf-8?B?UElzUXhQWUE2a1NpMWJCMFlyZTUyWlhRbWJlN1B3UkNjTHhISXpsbzdpTjNs?=
 =?utf-8?B?aFpqQTdVOGlFaG1zZHk0QjVFaUQ3cHhDUkJXbFVzbFJHZXloMTFyL09nUlpV?=
 =?utf-8?B?azg0YlVwTmsyTHUxMHlKRm9YMDFibzBnSlBFTEVoTzk5QVhHUWpYZ2crTnkv?=
 =?utf-8?B?VytrazU3VU9qT3I5a1V1WTNGWkZPRmw4L09HWXR0YUx5V2NzdGVKMm9MYWZl?=
 =?utf-8?B?RExqdXlXcWYycEJlNVgrM056eTZsQ3haaURSaWxvUkVVTGllWERuT0w5VkFa?=
 =?utf-8?B?U0RnaW1PUTk3VnBuNjZwaGxNNlpuRW9DZVdld3pDZzhRUzZqZTlDVEhidGRo?=
 =?utf-8?B?UHB0by9pRFZ6UTNONnFkWlZaSzAwbCtBbUU3VXlFTUpqRVZxSmpxcUJzTGxt?=
 =?utf-8?B?L2FTcjlOTzI3MzlOVW5zQkFJc3krVmFGbnhjTXRuaktKdEF2YTc5WDdZcVB0?=
 =?utf-8?B?blZ4OHo1Vnl3NitWeS9rcjM2K1BYay9vcmlMY3hVNVFHTmZ1eWdBek1mZjFW?=
 =?utf-8?B?Mi90OEJvM1UvNWNBQis4S3JQMXR2ZFFZRm1MV0lPREZYUnBkVFNuR2Y2WnRJ?=
 =?utf-8?B?NytYQmJ1V2toYjdPeHE5RVdEMXRCeEdHQU1SajhNMEVEajd2bnViVWVrWlZ6?=
 =?utf-8?B?TlEvN3V4RlpYblhLM2NYanVXbFZHbnRuSHBIa0xvUnNadU1kdGJaMFczN2h5?=
 =?utf-8?B?bTBHUnlwVWF3ZkN1Zi9FemNIYXkva3J2MHg1R0lTMXhGL2NRUzJoeTNJZzdG?=
 =?utf-8?B?aFY3SVBUZngzb09oZ1A0clVLYi95aW5Uck04WUdJOXR4dm5CQWhIYks5OHVo?=
 =?utf-8?B?OTRIYkdwd093YytDWHhHRS93N2I2Rjc0b0xtU2lyQk1jeExOQ3U0MitYeHZW?=
 =?utf-8?B?ZUZoMHVMRXNlWlZMbjJMQm5ZbnVzTkwwRHlrQlhHak8wZmc3U3JuaWFpYktz?=
 =?utf-8?B?Y241Y2Q0OUttdlZKSG9Oelk5N1hsdFEwamxHNFFlTnhBa0ZtMHBVNTJVQ1lJ?=
 =?utf-8?B?VTBrZUdPZHJSa1dFTFpMc1E4Nk05bjdiWW1YK0E0ditYYzE3YWtBV1p5cERk?=
 =?utf-8?B?QWRnZ3AxZjgxSm0vVTQ1K1VhME9uTXhlRXViR2tMWlRnQzFUbkNFb2NUV2tx?=
 =?utf-8?B?c3NkbFZxbm5WNnBXd2I1QmFHUldYNFBqTFR0aVJ6eXV5Z0htWFlZaTJHc1Bw?=
 =?utf-8?B?ZkZvdmsxZGtsbVFBdGdYYnRHa3BtSUI1T2VTYTNtWUpJMUdVK09JV3BtQklR?=
 =?utf-8?B?cUxYNXd3ekhhWWtZYUJja3NwTzZXZ1BjcDJzQjNraVArbVlwUmUvVUNVQXlt?=
 =?utf-8?B?djZ2bXhpc0VhVHNsbllpSmk4aVlmcTF5d2lqQ2NIS3ZpbFdrV3FYcnFSeSta?=
 =?utf-8?B?ZmV2RmREbGo4Um9YQjNxSDlyRDJZaUllaXlGU2EwR0laVGhQanIrN21vSmRI?=
 =?utf-8?B?SlNWMmRuUGdnNzdpL3k0YnhXZDhDZ3RiYmg2Sm1FYjAvK2xZa1lLRjZiOE8r?=
 =?utf-8?B?VEtaYVlwSVF1Yjc5dWJ4d3BnNmxHVFVlMVZOcWE2NzhQdXdrTW0rc0ZGaGRy?=
 =?utf-8?B?TDlLcXR5TnhaZEpyTHdIbjQzZVBHZFdBVlc4SnhIbm9WbWVJMnB1OVBJK1E4?=
 =?utf-8?B?eWg0VGdQVmJIWmNWUUdjQ1NGMVAyditsYXdPM1lYazlXemlnZ3QzRkpBQ09U?=
 =?utf-8?Q?Mov2lp0G250KyaniEeuTs9w8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ab382-edda-48c7-6d68-08dd30cbb472
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:02.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xESY7WHSrKowFujGrSt/LzOyxtnxJD4rhlfg8gHTrNUBcH/WeapN/ecqRMqPc5NSf/g++WU47ohA307kbcJ+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> While at it, pass ideapad_dytc_priv to the class device as drvdata and
> replace uses of container_of() with dev_get_drvdata().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/ideapad-laptop.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 43e4d9d8d595..d34d565172f5 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -936,7 +936,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>   static int dytc_profile_get(struct platform_profile_handler *pprof,
>   			    enum platform_profile_option *profile)
>   {
> -	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
>   
>   	*profile = dytc->current_profile;
>   	return 0;
> @@ -989,7 +989,7 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
>   static int dytc_profile_set(struct platform_profile_handler *pprof,
>   			    enum platform_profile_option profile)
>   {
> -	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
>   	struct ideapad_private *priv = dytc->priv;
>   	unsigned long output;
>   	int err;
> @@ -1123,7 +1123,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&priv->dytc->pprof, NULL);
> +	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
>   	if (err)
>   		goto pp_reg_failed;
>   
> @@ -1145,7 +1145,6 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
>   	if (!priv->dytc)
>   		return;
>   
> -	platform_profile_remove(&priv->dytc->pprof);
>   	mutex_destroy(&priv->dytc->mutex);
>   	kfree(priv->dytc);
>   


