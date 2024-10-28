Return-Path: <linux-acpi+bounces-9049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8DB9B3740
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCA1F21821
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEA1DF24D;
	Mon, 28 Oct 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KUBUmOyA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC891DEFE0;
	Mon, 28 Oct 2024 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134916; cv=fail; b=oMwEUWGyY/Irg0b4QTbxQzNWD/1mMafU1+YdWOmEiyp0OrBuNm2/95ELruODA4ZIQsiaRxtJN/JwyGat9fK6HoXw0aFV77nj7S+mET/wheHmmhvCqYT9TCYXyR/p0Cd8uXaJ8FicsjvtQ/xb1F0gDUIayGAB7vCbZC7hewBcpV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134916; c=relaxed/simple;
	bh=lHG/1mxEdBkJKudYMblhTHmK2HYY1B0m8LTYFVEgxlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/8/TA+MOi9GFkQbDL+lTo/tpUWyXsbzjMdxCvFk61JOu6Gj2sJlRaq+7eoVKS/yW3gfGGWarqfH29TR32dFZce9eqEd3hBb0uuxnQpCHLtDNny5IsVYgBZ7Lb26gR6sahO/grkttoM0hJvSUr/38tEd0XgmD+i+dR1LcFGg+Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KUBUmOyA; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr1WFFdzYTXQm2aVr+IcMo0VqZs08A2Ws5k37MqASHk/XBZr4L1djZDt64LSnX/dX2piqrdF3rRxh+vocNGU/jtm8QfVYaV7qVhMxHvOzhtRrli41JhFJU8bgVT/h1PK/1WHPdiYy4Z/O3PGpS9raVNQHVKnEvNOlwLomFBJ+e0lKNpCxmppIqRsDBDoHMGiG7Eb/P6QxDG5nx2GVDoTUbpj6Zyk2JdhIHmH2pr0omU4XlbHnjnURDCgkPDRjVZGtbtC05vwGWaTuv63gtJmgwPXl/JMXQzj3zvw7TwgZq/W/5GrOV8P435Plc/JgyAslx2vC5ujc8hl7GWa1OMmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZk1TJ3AzhPc7ywHVIbjEyXaOKGai0FTO6dXwnqBu6Y=;
 b=KeXWp5fQNuhx7GJeVwWiQpxZ6oFk/HIZYwQt8DIoZGMx8peDbjBqpRHeXY+jhVCN/R1viC6N39GpXybIqjgiPVNEje5Nu18aQFVk/vSxZ5EPSLMxOfzhjsUZlxl2V8LQPdo2qBKMR/uBIOIeRo2w7rKNxvSeJL74nRu2gUgLRM68AIkyV3RIcKOQmgAozSJ8EoAVvprmJf4NUMm+igtcLRclsalU4Y1dDUX8F58FFfldtoBkF4KhsMtpqtGW/d2beygiVNUDNeXgLXmyXC1C7bvHcvayc0WS49lV0ltNtxH+tZLlGiBzblCv7OoTYFaJyRBIgeme2Hy341zLPi+xJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZk1TJ3AzhPc7ywHVIbjEyXaOKGai0FTO6dXwnqBu6Y=;
 b=KUBUmOyArVAqG/i7geI9Rfb7hDY1dmLdORz+IdsW8VqBEmobapJUz3LA6CkEBLX/oMSXTX4fGu9pMuuJN2TiPCtZWfk9bNZJzVaETPmn5YENldxKYjXX/tLLBghhr68FXqLwYcVYREStzbRuzk4J9eOuSI6586Kgnx1D2YyotJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 17:01:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 17:01:49 +0000
Message-ID: <c4752d95-9615-4812-bbfa-7730f561517e@amd.com>
Date: Mon, 28 Oct 2024 12:01:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple
 handlers
To: Armin Wolf <W_Armin@gmx.de>, Mark Pearson <mpearson-lenovo@squebb.ca>,
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
 <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
 <058e829f-6200-44e9-9fe9-b606c107a7ba@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <058e829f-6200-44e9-9fe9-b606c107a7ba@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab46339-9fda-456c-c833-08dcf772365e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlBtblFpNkNhZHl2WWtzYmtjVDVUb2NUUFhaSkVvTDdQSW1hL2xYQ1JtVWU2?=
 =?utf-8?B?SE5DV1hsbWd3SzdpYXdCUWFFMkJjRXh6NVY5Z2ZtSk14TVhLcGpIZVhHWTVh?=
 =?utf-8?B?b1cxMnZlcnJ0WHlwdENSYkdPaUNxTTEwNU41dHdpQ2tSbVZoMk1FRnFDU215?=
 =?utf-8?B?ekp3elZwNjNRNUszTXlTNFFEQXIzZVNzV2JQb0ltRm9MUTY4dEhqQkdMeCtP?=
 =?utf-8?B?eExpcXlPT0lMMTdtUHFaN2pKVE40SlZiL0JzQTlqVWdHWnltWHBQZmRVS0NF?=
 =?utf-8?B?UjZTVW5jaDJwd2xkYWN2eElDNmtYcW45Z3F4Rk9uSjFBeUNld0c1WU9SWkd1?=
 =?utf-8?B?MnliMU9uekkyZENaVHRpOFRWbVdZK3FQWGE4VVVNQ2xWbUFxRjFacS9MSFVK?=
 =?utf-8?B?YWdZb3E2R2w1blhEcjB0cjIzUDErU2tTWkgvTk5WQW0vTmVrTmdDbFVRMFZr?=
 =?utf-8?B?UG9GTXREOGZjREM2YmY0QllHT2RiZ0dMbThnRUtPZWFJZHJlNVlmS0hWamJz?=
 =?utf-8?B?Y0E1MzhtQlZuSkNLd3JGdDYxU2dIZ2tpSU5hc01Pd2Y2N3ZaSmpnNUlrcXcr?=
 =?utf-8?B?VjFZWnFacVpIQVVDclA2YjZ3N1QvZlVuVmZaSFh6aDNrdUxNREpLbTdVT251?=
 =?utf-8?B?WHliU2NpcVA0YUhSckN0ZlRiR0NpM1ZXNVIxSmJQS3kyTzVHQkN6dUFDdGh5?=
 =?utf-8?B?OTNTdGUxSlhrRDNwTEZjNFM1THNhWmlxTG9GVlpWc1RMN2x2M2JoV2dBcmJV?=
 =?utf-8?B?eXZoRE9VQ2tpVFpYdE9jZmtQMkhJRHAxeTJDMU82ODRQZG1iMWNUYVUzV3di?=
 =?utf-8?B?YW5PMEFCK3FQU0ZiUkJFMEhMUk9mT1A2YytmWkVkRVUvS1JSN1FnbTlha0hL?=
 =?utf-8?B?RzRzU3NUQ1ppYjJmeVE4UER2bFFJSWNVci9OTkF1Y2lJM05BaWhzREVUOEZs?=
 =?utf-8?B?NmUzS2dsQ2pvV0puZzZ4UjV0N1NaSTRvUGIvNkFBK3Y5RjF3Mkw5MGJLbGM4?=
 =?utf-8?B?alovTy9aWVVWOVBUZ3QyaVdOZDdINEVKNHhxSzFId1ZqQVpMdEwyaDJuUzUz?=
 =?utf-8?B?Wi8wd3VNakNEV054VWdGaFIzTDN2YVZuUDA3aDdwTEtUd3FORGN5S1hRL1pO?=
 =?utf-8?B?ZEpCd2M4eU1TazNCT0RYRU5sakJDR2RZS1hSZTBhMlRjdW1zajhCQlpCZmVK?=
 =?utf-8?B?ellVZ2l0SzhmSU9KTzhvcTVqNVYvMzVyaFVra2xMMTA0dnlOYXZJQWxWUC8x?=
 =?utf-8?B?Wkg5V1BqMDlxRjIrbGpSbkRzRXZnR2RIVkFiL28yWW8zNWwxNUVFdkVlWHkx?=
 =?utf-8?B?RjNRYTRjL0Voek96VEZPL2FwemZXQzh0ZUZjRlNOMWw1Mm5mTDRWS2lLZ1pL?=
 =?utf-8?B?NWhLVG5NUVAwUFZEM1pHc2JPczlpaTArUTVUTzE1RGdLd3d6QUxGay9KeGhj?=
 =?utf-8?B?ZnpVK3Z5eXBCZXRRaEgwbHU2eHVCTFlXZmJUR0MvR0dKVGxqSGZIbkNnaDlB?=
 =?utf-8?B?UmNrNG55WjEzT3VhQStzb1FPTTBJR0djNlZBYy9pb3hJVXo1MSt4Z3dDV1lW?=
 =?utf-8?B?SGxjWnB2YVR6K1hkby9HVTBISFNLcWkzVGMveHJoSjl5NG5FSGNOcXhMdmF0?=
 =?utf-8?B?bW9pTmM3MGUvZGdTYzcxRVBIVFpXQnYxdVdzQlBJcTJMSDBJaExjNHc1SWpv?=
 =?utf-8?B?UGRnSmxIZytjaU8xT3ZPSWdZR3BPVURMbHUrU3VqV1BlSjFWTFZGZUNzbE1C?=
 =?utf-8?Q?BwN8NtEgXKThhdNDb/lmStJyxyjH07WoOhHr2sL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkVCaUZwVlh0ZzFDWkM2ZW9ya3RyMGhMZWs4SnZlYnRqcXR6WHVHcklBYjR1?=
 =?utf-8?B?N0JKSXhwYlA2NGdGVGh6V29sNVF1OXk0cUNaTGlNd1lxN3FETllCeWcxK1ZP?=
 =?utf-8?B?cFdETnYwNGhMRjY5czFlVko1ZkZXbUhJWU44Q0RiaXRFQituZHdXQnRUVkJs?=
 =?utf-8?B?Z2w0djdoNUJyaEsxaEtvY05ISWxuRjF5bmREem42d3VNQXI0V0hCWlVTcU4w?=
 =?utf-8?B?VnhUMUlaekE0TVR4eWttR2JxT1pHelRubXExbWZSeGhsdG1VU3VhNytManhH?=
 =?utf-8?B?akYyWDNMeCtLait5bFJOMXZURUdWaSt5aTJjenpWYktqL2NrMEVueFUvQkNh?=
 =?utf-8?B?dTJrS3QxSkQyUis4ZE1kMnRNSXhTSHVkbzNqUUFnNDBBSkpOQ0JYY3c2c3BC?=
 =?utf-8?B?K0pUVnlwNjdZZjR6Z0NmZGYzdGFkdCs2VnZSOU5RL2MwV1JkVGwyVmkwSWxE?=
 =?utf-8?B?Y2VVT05kemVzd1g1ZXJBRG0wdzVEeExjQzRxcndhUythc3JkMlhCSTRPL2gz?=
 =?utf-8?B?ZDJVU1plYUUwdEpIYTB5OGN6K3JOc29OSVhkVFhEZHhHWGwyRklnMktidy9j?=
 =?utf-8?B?c1N6RisrSUQ4NG5SajZ5dXA2UDNjb2dyMGZrWjFVeWNwK2gvUzEzVUxyZWsy?=
 =?utf-8?B?Zkc3a2V5WHY4WjRFWG50MDJjV1hsc2p5QUg4SmV5a25BSnJRUjYxekFsQTlm?=
 =?utf-8?B?Qk4yWTVyM1dnVm42ckR1d3huYXJRNjR5alpCTlNRYWxVSTVkRUkwKy9xL0FF?=
 =?utf-8?B?cjZpZEVvRlp5NUlxK1crTmRVZ256V3RyYXRJNUhTdGFOazlweHM0T1ZHYlpw?=
 =?utf-8?B?ak54eDlQdVJVbjVrclkyMFRySjJOT21rL29qV2M4VlRmbHZpVWdTRlAvd1Bs?=
 =?utf-8?B?L25zTlpHRStqTy8xTDNBaDkxa25yN0pXZzFWbllsd3k3VUlXZk1HalFLMG1l?=
 =?utf-8?B?NHdPc2NnZTFtRUlralNCaHdja25nS0ZWNXJhUnRLT3I2N09qc3BPTmpKVkxW?=
 =?utf-8?B?Y3I0NGtRcGhvdVFJbitSdnhYRFV0ZGpGdUQ5NFNpQ1dqekNSeWpKSVZCOU13?=
 =?utf-8?B?NkFxaUhoTC9ENDdLRDR2VUFObVZJSDJHc3IvYnJKenZzUk9JSGNtQmpqSlRm?=
 =?utf-8?B?WDJzTnZ4Wk5XU3c1cGpxdnJ6anRKc2NiQ0F5MjR5Vk9NM1lORmxmYzY4aXFu?=
 =?utf-8?B?VW9lRG9SSmljNE5qOFFMWmxycElCMm1YVTNFR3NEZWc0TXNXdi9xM3Q0OGpW?=
 =?utf-8?B?YzZoNEFkejE4MHlTcy9CeW5vejJHV1o5NWJHRTBJMUtRVFZidHB4ZUhpeHdF?=
 =?utf-8?B?UnEyRm94bGwzVEdQT1VhdGg1eVpxa3ZQOCtmNWUrRnk3eDJaUFp6SUEwOHF3?=
 =?utf-8?B?S2hLN1JMNFZiTGlEUnJ1Vmd2b2l4U0VuSzNlQkFuU1MvZnJiWWsxZXlVVnJN?=
 =?utf-8?B?NnFWa3RhSXBFNlROUEE4SjJVdFBZYlVNVEd1UXh1M2UyN0lMeFFsbmZ2V3Zp?=
 =?utf-8?B?ek5PQzNrWWl6TStTczUrT3FNMnFIM0t5dlJIekFHTllyUkppTTFhMUpBOURR?=
 =?utf-8?B?OEMxNjZzL2xidGhsdVRZd2FDZHNnbDRSc2FPM0gyd3gyczNjclliankxNXVO?=
 =?utf-8?B?SFRUR0pBZDVwNy9uNjF4TXN6bGdDUTFKQSsvWGtGMTU5M21iUkR2NmNJc3Rx?=
 =?utf-8?B?bEFoYTYvUnpBWUw3WEpHbHZaUEg3R1FVSkZQcWxTM2tiNzlMUFJIL0YzbTBS?=
 =?utf-8?B?cGxkdDIxQ3pBVmVzTWFKTU5SNVhQTFVRQnhleG5qSmRFQW4vbjJteUp5OXli?=
 =?utf-8?B?RUd2VGozRWNLcm1YMHVrL3EvdGxOY1pFTzVwem0rM2tKaDRlN3JhV0RNQWM1?=
 =?utf-8?B?NFVGSFBtdEQ2dXNJZGRwTy9YeVVISXg4ZFVZNVFZbUlEVEJYZDBIaEFpNUt0?=
 =?utf-8?B?U0JyVG1iaVNQdm1VOU9ZYmhpSUVrd0t3RU8ram05YytYR3JuNllDZStTY2JZ?=
 =?utf-8?B?OXU1VXBEVEJJbzhoREgvMkNOU3lHZzdpNjE4OTFwOFZCRWNucXhUek1ndkRP?=
 =?utf-8?B?amdKMm0rNHhwMlJoRW0zZmN2SUhDK1BUbXA1M2hyM3lBS3JkdnVXYkZxOHBW?=
 =?utf-8?Q?B8J2iB4B5zW/lhXUINpVtPCwY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab46339-9fda-456c-c833-08dcf772365e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:01:49.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5IiaT1ywS5eSStVGqYY62aL2yyImkcCm2L2ZJObvaA0/5HV2JRiRM7Po7P7U7nNNvW1HQoJsxTlNAk1hQ5unA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363

On 10/28/2024 11:51, Armin Wolf wrote:
> Am 28.10.24 um 15:10 schrieb Mario Limonciello:
> 
>> On 10/28/2024 06:01, Mark Pearson wrote:
>>> Hi Mario,
>>>
>>> On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
>>>> Multiple drivers may attempt to register platform profile handlers,
>>>> but only one may be registered and the behavior is non-deterministic
>>>> for which one wins.  It's mostly controlled by probing order.
>>>>
>>>> This can be problematic if one driver changes CPU settings and another
>>>> driver notifies the EC for changing fan curves.
>>>>
>>>> Modify the ACPI platform profile handler to let multiple drivers
>>>> register platform profile handlers and abstract this detail from 
>>>> userspace.
>>>>
>>>>  From userspace perspective the user will see profiles available across
>>>> both drivers.  However to avoid chaos only allow changing to profiles
>>>> that are common in both drivers.
>>>>
>>>> If any problems occur when changing profiles for any driver, then 
>>>> revert
>>>> back to the previous profile.
>>>>
>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/acpi/platform_profile.c | 203 +++++++++++++++++ 
>>>> +--------------
>>>>   1 file changed, 117 insertions(+), 86 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>>>> platform_profile.c
>>>> index 091ca6941a925..915e3c49f0b5f 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -9,7 +9,6 @@
>>>>   #include <linux/platform_profile.h>
>>>>   #include <linux/sysfs.h>
>>>>
>>>> -static struct platform_profile_handler *cur_profile;
>>>>   static LIST_HEAD(platform_profile_handler_list);
>>>>   static DEFINE_MUTEX(profile_lock);
>>>>
>>>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct
>>>> device *dev,
>>>>                       struct device_attribute *attr,
>>>>                       char *buf)
>>>>   {
>>>> +    struct platform_profile_handler *handler;
>>>> +    unsigned long seen = 0;
>>>>       int len = 0;
>>>> -    int err, i;
>>>> -
>>>> -    err = mutex_lock_interruptible(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>> -
>>>> -    if (!cur_profile) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -ENODEV;
>>>> +    int i;
>>>> +
>>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, 
>>>> &profile_lock) {
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +            for_each_set_bit(i, handler->choices, 
>>>> PLATFORM_PROFILE_LAST) {
>>>> +                if (seen & BIT(i))
>>>> +                    continue;
>>>> +                if (len == 0)
>>>> +                    len += sysfs_emit_at(buf, len, "%s", 
>>>> profile_names[i]);
>>>> +                else
>>>> +                    len += sysfs_emit_at(buf, len, " %s", 
>>>> profile_names[i]);
>>>> +                seen |= BIT(i);
>>>> +            }
>>>> +        }
>>>>       }
>>>>
>>>> -    for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
>>>> -        if (len == 0)
>>>> -            len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>> -        else
>>>> -            len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>> -    }
>>>>       len += sysfs_emit_at(buf, len, "\n");
>>>> -    mutex_unlock(&profile_lock);
>>>>       return len;
>>>>   }
>>>>
>>>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct 
>>>> device *dev,
>>>>                       char *buf)
>>>>   {
>>>>       enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>>>> +    struct platform_profile_handler *handler;
>>>>       int err;
>>>>
>>>> -    err = mutex_lock_interruptible(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>>
>>>> -    if (!cur_profile) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -ENODEV;
>>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, 
>>>> &profile_lock) {
>>>> +        if (!platform_profile_is_registered())
>>>> +            return -ENODEV;
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +            err = handler->profile_get(handler, &profile);
>>>> +            if (err)
>>>> +                return err;
>>>> +        }
>>>>       }
>>>>
>>>> -    err = cur_profile->profile_get(cur_profile, &profile);
>>>> -    mutex_unlock(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>> -
>>>>       /* Check that profile is valid index */
>>>>       if (WARN_ON((profile < 0) || (profile >= 
>>>> ARRAY_SIZE(profile_names))))
>>>>           return -EIO;
>>>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct 
>>>> device *dev,
>>>>                   struct device_attribute *attr,
>>>>                   const char *buf, size_t count)
>>>>   {
>>>> +    struct platform_profile_handler *handler;
>>>> +    enum platform_profile_option profile;
>>>>       int err, i;
>>>>
>>>> -    err = mutex_lock_interruptible(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>> -
>>>> -    if (!cur_profile) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -ENODEV;
>>>> -    }
>>>> -
>>>>       /* Scan for a matching profile */
>>>>       i = sysfs_match_string(profile_names, buf);
>>>>       if (i < 0) {
>>>> -        mutex_unlock(&profile_lock);
>>>>           return -EINVAL;
>>>>       }
>>>>
>>>> -    /* Check that platform supports this profile choice */
>>>> -    if (!test_bit(i, cur_profile->choices)) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -EOPNOTSUPP;
>>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, 
>>>> &profile_lock) {
>>>> +        if (!platform_profile_is_registered())
>>>> +            return -ENODEV;
>>>> +
>>>> +        /* Check that all handlers support this profile choice */
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +            if (!test_bit(i, handler->choices))
>>>> +                return -EOPNOTSUPP;
>>>> +
>>>> +            /* save the profile so that it can be reverted if 
>>>> necessary */
>>>> +            err = handler->profile_get(handler, &profile);
>>>> +            if (err)
>>>> +                return err;
>>>> +        }
>>>> +
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +            err = handler->profile_set(handler, i);
>>>> +            if (err) {
>>>> +                pr_err("Failed to set profile for handler %s\n", 
>>>> handler->name);
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +        if (err) {
>>>> +            list_for_each_entry_continue_reverse(handler,
>>>> &platform_profile_handler_list, list) {
>>>> +                if (handler->profile_set(handler, profile))
>>>> +                    pr_err("Failed to revert profile for handler 
>>>> %s\n",
>>>> handler->name);
>>>> +            }
>>>> +            return err;
>>>> +        }
>>>>       }
>>>>
>>>> -    err = cur_profile->profile_set(cur_profile, i);
>>>> -    if (!err)
>>>> -        sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>> -
>>>> -    mutex_unlock(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>       return count;
>>>>   }
>>>>
>>>> @@ -140,7 +148,8 @@ static const struct attribute_group
>>>> platform_profile_group = {
>>>>
>>>>   void platform_profile_notify(void)
>>>>   {
>>>> -    if (!cur_profile)
>>>> +    guard(mutex)(&profile_lock);
>>>> +    if (!platform_profile_is_registered())
>>>>           return;
>>>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>   }
>>>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>>>
>>>>   int platform_profile_cycle(void)
>>>>   {
>>>> +    struct platform_profile_handler *handler;
>>>>       enum platform_profile_option profile;
>>>> -    enum platform_profile_option next;
>>>> +    enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>>> +    enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>>>>       int err;
>>>>
>>>> -    err = mutex_lock_interruptible(&profile_lock);
>>>> -    if (err)
>>>> -        return err;
>>>> -
>>>> -    if (!cur_profile) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -ENODEV;
>>>> -    }
>>>> -
>>>> -    err = cur_profile->profile_get(cur_profile, &profile);
>>>> -    if (err) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return err;
>>>> -    }
>>>> -
>>>> -    next = find_next_bit_wrap(cur_profile->choices, 
>>>> PLATFORM_PROFILE_LAST,
>>>> -                  profile + 1);
>>>> -
>>>> -    if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
>>>> -        mutex_unlock(&profile_lock);
>>>> -        return -EINVAL;
>>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, 
>>>> &profile_lock) {
>>>> +        /* first pass, make sure all handlers agree on the 
>>>> definition of
>>>> "next" profile */
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +
>>>> +            err = handler->profile_get(handler, &profile);
>>>> +            if (err)
>>>> +                return err;
>>>> +
>>>> +            if (next == PLATFORM_PROFILE_LAST)
>>>> +                next = find_next_bit_wrap(handler->choices,
>>>> +                              PLATFORM_PROFILE_LAST,
>>>> +                              profile + 1);
>>>> +            else
>>>> +                next2 = find_next_bit_wrap(handler->choices,
>>>> +                               PLATFORM_PROFILE_LAST,
>>>> +                               profile + 1);
>>>> +
>>>> +            if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>>>> +                return -EINVAL;
>>>> +
>>>> +            if (next2 == PLATFORM_PROFILE_LAST)
>>>> +                continue;
>>>> +
>>>> +            if (next != next2) {
>>>> +                pr_warn("Next profile to cycle to is ambiguous between
>>>> platform_profile handlers\n");
>>>> +                return -EINVAL;
>>>> +            }
>>>> +            next = next2;
>>>> +        }
>>>> +
>>>> +        /*
>>>> +         * Second pass: apply "next" to each handler
>>>> +         * If any failures occur unwind and revert all back to the 
>>>> original
>>>> profile
>>>> +         */
>>>> +        list_for_each_entry(handler, 
>>>> &platform_profile_handler_list, list) {
>>>> +            err = handler->profile_set(handler, next);
>>>> +            if (err) {
>>>> +                pr_err("Failed to set profile for handler %s\n", 
>>>> handler->name);
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +        if (err) {
>>>> +            list_for_each_entry_continue_reverse(handler,
>>>> &platform_profile_handler_list, list) {
>>>> +                err = handler->profile_set(handler, profile);
>>>> +                if (err)
>>>> +                    pr_err("Failed to revert profile for handler 
>>>> %s\n",
>>>> handler->name);
>>>> +            }
>>>> +        }
>>>>       }
>>>>
>>>> -    err = cur_profile->profile_set(cur_profile, next);
>>>> -    mutex_unlock(&profile_lock);
>>>> -
>>>> -    if (!err)
>>>> -        sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>
>>>> -    return err;
>>>> +    return 0;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>>
>>>> @@ -190,21 +224,19 @@ int platform_profile_register(struct
>>>> platform_profile_handler *pprof)
>>>>       int err;
>>>>
>>>>       guard(mutex)(&profile_lock);
>>>> -    /* We can only have one active profile */
>>>> -    if (cur_profile)
>>>> -        return -EEXIST;
>>>>
>>>>       /* Sanity check the profile handler field are set */
>>>>       if (!pprof || bitmap_empty(pprof->choices, 
>>>> PLATFORM_PROFILE_LAST) ||
>>>>           !pprof->profile_set || !pprof->profile_get)
>>>>           return -EINVAL;
>>>>
>>>> -    err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>> -    if (err)
>>>> -        return err;
>>>> +    if (!platform_profile_is_registered()) {
>>>> +        err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>> +        if (err)
>>>> +            return err;
>>>> +    }
>>>>       list_add_tail(&pprof->list, &platform_profile_handler_list);
>>>>
>>>> -    cur_profile = pprof;
>>>>       return 0;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>>>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct
>>>> platform_profile_handler *pprof)
>>>>
>>>>       list_del(&pprof->list);
>>>>
>>>> -    cur_profile = NULL;
>>>>       if (!platform_profile_is_registered())
>>>>           sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>>>
>>>> -- 
>>>> 2.43.0
>>>
>>> I'm still going thru the code changes - but I'm a bit unsure on the 
>>> implementation itself.
>>
>> FYI, I split it up in v2 to make each chunk and intent behind it more 
>> manageable to review instead of patch 7 being "so" big.
>>
>> V2 covers some of the points below as well based on some feedback from 
>> Hans and Armin.
>>
>>>
>>> I'd expect that one of the advantages of having different profile 
>>> handlers register is that you could support extra & new profiles that 
>>> might be wanted. For example the recent discussion of the AMD handler 
>>> providing better tools to tweak advanced system settings for gaming 
>>> etc. Won't this approach limit that? You'll only be able to have 
>>> common settings.
>>
>> Well that RFC it turns out won't really be scalable because SPS is 
>> done differently in AMD Strix and newer.  I haven't revisited it yet.
>>
>> But yes this approach would conceptually limit that idea because 
>> common settings are all that is presented.
>>
>>>
>>> I find having a common profile and two different handlers a bit 
>>> tricky on how to handle. My concern is it can easily lead to conflict 
>>> in settings.
>>> If two handlers are doing different operations to provide the same 
>>> effect - then neither handler is (probably) providing what they think 
>>> is required. With your CPU vs EC example, the EC will often set CPU 
>>> clock thresholds and the CPU profile handler will be changing that. 
>>> If this is done I think it should be explicit to the user (admittedly 
>>> I'm doing this with my Lenovo hat on - but we certify our platforms 
>>> with our EC profile handler)
>>>
>>> I could see providing two separate handlers. e.g. balanced-A and 
>>> balanced-B (for driver-A and driver-B) and the user maybe choosing 
>>> which one they want (or both - though the user interface for that is 
>>> definitely tricky)
>>> But choosing one option for two different drivers seems confusing and 
>>> with unknown side-effects. I appreciate it's complicated by your 
>>> example wanting to add CPU and EC - I know how much work you've been 
>>> doing on the AMD CPU front which benefits all systems.
>>>
>>
>> Thinking through your comments I guess another way to approach this 
>> would be "per-driver" sysfs knobs.  Here's my thought.
>>
>> 1) /sys/firmware/acpi/platform_profile_choices would contain only 
>> things that are common and if there is something NOT common then also 
>> the string "custom".
>>
>> 2) /sys/firmware/acpi/platform_profile would accept writes for 
>> everything in platform profile choices except "custom".
>>
>> 3) Each driver handler would also export it's own sysfs files to 
>> represent the driver state.
>>
>> 3) If the user changed the main knob at /sys/firmware/acpi/ 
>> platform_profile then it would change all driver handlers.
>>
>> 4) If the user changed sysfs for any driver individually then the main 
>> knob /sys/firmware/acpi/platform_profile would export "custom".
>>
> Sound like a good idea to me. Maybe we can create a "platform-profile" 
> class for the per-driver sysfs interface?
> The legacy platform profile sysfs interface can then use 
> class_for_each_device() when getting/setting the current profiles.
> 
> For handling notifications we can add a notifier similar to the power 
> supply subsystem. The legacy platform profile sysfs interface
> can use this to receive notifications and forward those to the global 
> sysfs attrs.
> 
> In the end old userspace applications can continue to use the legacy 
> platform profile sysfs interface while new applications can
> use the platform-profile class.

OK, to keep sanity and keep it bisectable I think the way I want to do 
this is:
* keep 1-13 as is from the v2 series
* add custom profile and class handling code in
* rebase v2 14 and 15 on top of that.

Any opposition?

> 
> Thanks,
> Armin Wolf
> 
>> Hans what do you think?
>>
>>> Another concern - would this mean that another driver could limit the 
>>> options available? For instance if someone wrote a new 'mega-turbo' 
>>> only profile driver and it loaded - it would then mean no profiles 
>>> were available for anything as no profiles matched?
>>
>> Yes.  I don't think it's a problem in practice right now (as we only 
>> just recently have two drivers vying for this position), but it / 
>> could/ be something that happens.
>>
>>>
>>> Let me know if I've misunderstood the architecture. I didn't fully 
>>> get how the ASUS and Framework platforms were impacted in the intro 
>>> I'm afraid.
>>>
>>> Thanks!
>>> Mark
>>
>> Framework isn't affected, it was just showing that there are platforms 
>> that use the BIOS/EC notification concept and not just SPS values that 
>> the driver programs so it can't "go away" to solve this issue.
>>
>> ASUS is the only thing affected right now.
>>


