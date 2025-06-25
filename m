Return-Path: <linux-acpi+bounces-14605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F1AE885C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96EC189DDAE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F4270554;
	Wed, 25 Jun 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2hrUwVU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEE3074B2;
	Wed, 25 Jun 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865700; cv=fail; b=oo/ZeKxc2bac73ZeAsCFe5rLyk6gqwQ+pwg4XyapbGijh+NbXdgIQlaHZgULaLE4+iifqVsHi3iIWSH9onwKDV8ZjFomY9WgsSc02cDFuBoK9b8LuGvRshmK4b8lyiKfrN5zSpZFEKc/AHLJkutRRlKzdkUwl+phshV/GpOi3lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865700; c=relaxed/simple;
	bh=B9wcHw9G1DCyjqdBJFpRq3ZHdaFbdMySRNEXX097kTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVJVZB+tUpHdd3hcq+ifoldoxPF4U48WjKjlSXas+4cW6WGe9ZQLnPB7LQNNV6da9YYf7q1tnRrAPuhX5Dy+BFRccen1ysj/mLJZI079CNIJUs7Ieb0qEFLg/1ERt+ktlwHnUtrHiGqitOP9P7NqbsGrpGQSyT9hCWxBjRB4KK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2hrUwVU; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSDtpcqyBJEMEqOHlZcoLQUnxiM7ZfgU1EVrSzcKbWva7x5lgSZxdI7cQrc7a3729F9uwwEHf0sGFhi1up7Px0xGRdEh3GZF9v7kMevheBI9JhBBEyf13+2wrXWKX9MfACEksw8UIq2MEa3VrNkJHtbJ8eJFaqyA5P3QWAMnXC7ytw9NDzx8KzJ5RfJMLfxb4vqFobKDOR6MDLCtjUh9GJidaXMwocRUry7Hwm6Y6p3/UvGJ1ifHi84hHpqtsW/+jf51YVY501StC+SUXlV6vPuCd/z8F3gDyN5xsagHA/qh43uQwa5oiI/KxD/hwS5lqmeCJRDT7wTIMOb11HUYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9wcHw9G1DCyjqdBJFpRq3ZHdaFbdMySRNEXX097kTc=;
 b=JRfOcYIv1pyco3ckjM1RuYaxdvb4pWlEeAj6DIhaOW0ShFaHPM+SjSvgwesQ5CgXrqkjUHCvDGAUD7h60TFMBxsQKjmqjyexlNe62Jk/Wyf+TzEFKkauUnmArPwQfOWm0s/FcukkI5fJiPL3SwDW3/q4VyCEWqECLJewaz70otCH/EZao/nQN0EOQEFDbVv9QNprUPX9gShyflGiCJw9ycZLWVFgaIerCwYU98c525q/lpl7zjnLY9Su21F/eXSlK3cKPNP5PbXnyBNZg14HPFoLWl4DJ23B7IzICUq1mKxs0SLISOnYdCpws8VT7he9Vp0cDyDvA6kArrIWVXAMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9wcHw9G1DCyjqdBJFpRq3ZHdaFbdMySRNEXX097kTc=;
 b=q2hrUwVUsXyNYIhqPKbttW8xj3XY3Yg9OlFTblhB24UbV5tVJrGHx11K+YnokNYAR8c+11ovsr9svPg6p8y6dmB7hnGJdBTwXv2JytYzrW77mL91ozszqEdH9ziXOtY7/tkh8YBUCmggdIu5jhPC76+bcdLlFoOcwfXnl3o1xiE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 15:34:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 15:34:55 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Mario Limonciello <superm1@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, "open list:GPIO ACPI SUPPORT"
	<linux-gpio@vger.kernel.org>, "open list:GPIO ACPI SUPPORT"
	<linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
	<linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Thread-Topic: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Thread-Index:
 AQHb5UWwK1dzhg42d0uJNDUCuVsLt7QTlyaAgABT3ACAAAYXAIAAAu6AgAAFtwCAAAJIAIAAASwAgAAAyoCAAATdAA==
Date: Wed, 25 Jun 2025 15:34:55 +0000
Message-ID: <6c0514e5-0ea6-4f66-9bc0-4230d7ef0d4b@amd.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
 <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
 <aFwTCUXQydxRVEfk@smile.fi.intel.com>
In-Reply-To: <aFwTCUXQydxRVEfk@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB9030:EE_
x-ms-office365-filtering-correlation-id: 3d15c1c3-969c-42e4-e726-08ddb3fdd5e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjFjUEN0ZkpYVnh2RnVDbnVRaEczSHFwb2w2NWQxTCt6bUI5dkdvYzZEajVn?=
 =?utf-8?B?UzRHSE5TNWxKYXVZd3RJZytrRkhvZGVyeFpXb041VmY1ZzByZWd4d2RtS211?=
 =?utf-8?B?M1M1SWdYaXR5MHFCN2xOcGdEK0ZrcGdZbDdNc3l0MlRYT2VNV3NwQk1MK0ph?=
 =?utf-8?B?cFhXK3NNVWtxN1hzQ2ZoRi90dlhvVkhCZnY0NjgzS1VxeTJwSHhqbTFldEcz?=
 =?utf-8?B?SHA0MGNoOU8rTng1dmVHRGJZOEc1cE9uVG1RS0pxNGtNSy9iQjdLMGNVZVpT?=
 =?utf-8?B?YWVENUQ2ZFBpdW1Icm50ekR3Q29PckNTSzBGakhYZlc1dUJmV2ljZ1FpT1gx?=
 =?utf-8?B?Vm1UdllGZDZaWlF0NzdXazdPeVd6N2FXYkhGc044djV3R2NIczVPeTJIdFQy?=
 =?utf-8?B?RTRBbU1HSnlIb2NnbUJyVWlQNlg4MHA5a0VUOWxobm50SitpUGFyK1NiaUpz?=
 =?utf-8?B?K21TaUMvQVFXRDNWNW93VEh6cmlxdWVxWUFhcFpOWmEwdTRwMlJ2YmJZWlo0?=
 =?utf-8?B?eGFaL3JnUDVWUmwwSXpPcTY3QTk2VElvekZUTUJQTm1zV2FtZXZYQ2d2TDVk?=
 =?utf-8?B?Zmcya1cyYVljK1JGQkppMlUxTHdOQVVVdjJvNm9UU3dVR3IyU3dSbGZLemdY?=
 =?utf-8?B?MlNKVWJWdHJod0N3TDEvZnh3QmJnbFRXUE5HTUQzYVBzUFJVV1docGJRMTl0?=
 =?utf-8?B?TXlLVDhUdG8ycFlPNUtmSlRPaU9NRkRVeU13YkJIZ0xobGo0aHZyV1llQ1Yx?=
 =?utf-8?B?QjRXcDJYQWVCbHJLb215LzJLZ2xTMCtUd28wWmtSYzU0ZmxmMlJDRjNoaVJv?=
 =?utf-8?B?YjllT3B2MEVmTUozTk4rWFdTSHp5d2dDVDVMZklsV0JzSWpRUHB6RHhULy9Y?=
 =?utf-8?B?QTNERytjdkxyMkh5VkQxN25uT05pM0tEajl0NGd1RzltYUkreHFOYWZJc2lL?=
 =?utf-8?B?eHZ5NEpuMkJ6K3VVS01CWTZoTTE0SDM1bnA5d0hMYWp5Q2I2WjQvbUNkRUVV?=
 =?utf-8?B?U21qekpXaDAydnk1RDFjbk1BRHZOeWs2Y0p1YmZ6U1NsZU1jZWsyR0RJb1B4?=
 =?utf-8?B?RWZtbWJpRHB3TnhmRXB2VjRCR01zN2pxb3IzWDFlNW4xMzZSMFZsa0J1WjZU?=
 =?utf-8?B?dGp0UHBsS0dzL2swdlV4ZTZqR2RONVFOS0FWdG9tWVVzK1VOTGVyVnhDSGVl?=
 =?utf-8?B?YmRMNm11MDV1MmRkSFhwMlg5UHRsT2R5SVZvM3JrcUtYS1E3OWhqUnZwWE5y?=
 =?utf-8?B?ZnBjQUcxd0haYkIvbnoyRUY2dXAyLzlQdnhQME5ieXBaaFpCdFhVeFhYNFNK?=
 =?utf-8?B?U2wwZUNHKzlpNS9oT2JGOHpacXg3bnF0T0E2Ukg1bmhtNmxucW1PT09IdGpW?=
 =?utf-8?B?U3h3cWFTUkdkTXdTSnQrN3drTDRxNkJGRW1Rd1IvT1JpZ25uMTRkY2RDWWdB?=
 =?utf-8?B?T2VmakoraXpmZk10am1vbTBWL3c5ZDc0R09QazVWRnU1bnU2enlUMGd1am5P?=
 =?utf-8?B?WlduUUNmajZORWhORkQzK3Zldm1pRllDbENaUVJrSURLejZON2QrT29mT0NG?=
 =?utf-8?B?eTNUaDhMNE5Razd2bXBPcjRrdFFoRjBvT2dDV09UZEhnRVU0djRlV29BeC94?=
 =?utf-8?B?WUdwSTF4V2JGdVhhVjlQR21GSWJQVW1sdnhMbVA4TkdHZVAzWWZKSXJDYkdG?=
 =?utf-8?B?MENzZG9YY1hEZXVjQXFqT2k5aU04UmxQekt5c0FXNlRnM05rMFg5NWRWNlBn?=
 =?utf-8?B?U2VTWUMyRHZGaUVQR2c3c3lkVEhoRkEwODdlNmp3NUovSGpVbVNzYjhFbmo3?=
 =?utf-8?B?UTUvWjUvaWhXVFQ1RmQ5N0NxbVk1dzVUSkhwMDFUeGhXbnR1Mng3VG11TXhi?=
 =?utf-8?B?UGFoVjB3cVpOTXE5eW9URkttWERPUjQySmdpTEtUVy9lMzR0cGVPWHJjRERT?=
 =?utf-8?B?cU52eXpzWVpGNFI5d0ZzSEkyeU4wcmRrRHRqZ0hBcFEyNFkyYnVpanVmVzFx?=
 =?utf-8?B?SUJqTWUrTzVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2xhaG1YOTdMVThpUGRtcjU2S3dwTDdIRnBWckpwbnVLb1FVVkwydys5SXo5?=
 =?utf-8?B?VDhvellWVCtjSDFaUlJTSWJwY3plRUlmU1NORUVlMmp2UXdlQVZvMmdTVUlM?=
 =?utf-8?B?RzZBWUwzVnMxcmJwcHExR0R0YnpxbVhJQ0lXOGpUMGYwcnB4cm9GVVRWbVpr?=
 =?utf-8?B?SUNta1ViVzlZQ1p6amE5Um1nNkc4b211RW5KYUFLeUp3ZU5qYUZiejR1SVNV?=
 =?utf-8?B?OG5raVQvVnU1Wi9nTGd6QlhyQS9TeVFVZWJHRHhTMlYwM3prdjIxcHJHUmpx?=
 =?utf-8?B?MlNZQlh5dEJ1THF5VGZLOVo2clVVVkRmby9WTXkwb1Q0K2NXUmt6NmovbTh3?=
 =?utf-8?B?Q3FVL2ZhY2dZYnZGQ2F2VGR2dUZmLzJTQ3J0cEtEVTZBM0EyWjRxaUNTTG45?=
 =?utf-8?B?S1FXRld5ZGxPWDJkck44czhMY3MxSWJ1NjlWazc1VjRjQnFXcUI2TDZPNllV?=
 =?utf-8?B?a3pQaDhZbzNUTFF4YVZXVjlHNnBLS29qR1BUOUpGYVMwVWlOckRnNGs5QjQz?=
 =?utf-8?B?N01DTWpXMS9TWGtHMzYwaTF3NGN6S1JLbnJBMlNwZTF6enVQOHNSNGtGKzNN?=
 =?utf-8?B?cnhtZllER3hNTnU3UktpdXM5VmdkWWFsTkUvV0UxM1pzaTNOYitNd0pZOVVo?=
 =?utf-8?B?U3I5TUE0ek16cnAzQzRDclYyN1pWNmtCb0c1MUtyWHM1Sk9jVkd2eTBOb0c1?=
 =?utf-8?B?ZlFUN09xRGVnZFdDeElDZDhFZ2dMQ2pXbmplY0l2NlNnMXRFSmpNYnhITVR0?=
 =?utf-8?B?WTQrNG9UVGtwY0VBTjl3NVliRDlxbGFYN0FCMkE2WGM0ZWwrSnRkVHRuVUtR?=
 =?utf-8?B?UmRLTit0Q2I2MVlVWmhBbzFEN2RtYjNxdUdNVWJZQmEyc2hCUWgwUlJrekZM?=
 =?utf-8?B?QXY3ZDd5RXBLcU5Ta0F2djMreGlwSXQ3YittdFhwMWU3dUFLdlAyMFE4RFFQ?=
 =?utf-8?B?UWxOZVU1Ym1ldUxMSytjYlk4MzM1ZmNzSXNNTmZ3cHJQSEJMVjZQOHhwbGdV?=
 =?utf-8?B?YVg1WXRjaXpXSjc4RElxZWtITHBuSUJObHZxeHFJd1pRYXlzNjNOOUtqck82?=
 =?utf-8?B?YTNlVnFULzZIUHAyM1dsZUNNMFJLd05QbFliUnFEVzY4a0JjSGxXSEoyalNV?=
 =?utf-8?B?TFBYSnBFU0kraUUrVm1JYmNGWTl1NXljWTJSYlFmOTFzZWZNYlhiNEFlTFNq?=
 =?utf-8?B?YnpSY1EvNnRjZjZOZW1vdEx1YjVJNXRLMVQ4bW8rMS9KWnAwWmhTOFBVN0Zh?=
 =?utf-8?B?Y1lnMVhCSFo2K3lBT1RLMWNJWDZ1NldodE1SM0NPMzRGTW5yZ0RkQlF6Nnhi?=
 =?utf-8?B?L0RNN010YzdOR0ppcFVvOC9Ld2xTVEY4Mm9La0RvMS96a3pqNnpwaGhHejIv?=
 =?utf-8?B?T1QyNEhFdU5wS0pyVWlaM3RRVC9FaFU2NnVxQlY0M1o4TFRKU21TMy9ZTFk4?=
 =?utf-8?B?M2JjWXBMU051NGJnN2t0dVVwQWVDbE9mVmx5WFNEV3ZXR3p5K2NMU0NCYkNX?=
 =?utf-8?B?eHpRYjZCemliSUtZSmxlbjFYcjN4U1B0OFZId3RPOXVnSEFNbmlONGE0TURz?=
 =?utf-8?B?Mm8wQkdhWjJWNFJZY2FrZ1NpaDIzR1BRZWpKMk0xcmdMbFZqUjMvR0tXUng4?=
 =?utf-8?B?WHpwSkJRcTVPbFoyOTZZNW5hWUlrOUFVOVlwSlpjTTd2c3dUc3poS1Q5TkVY?=
 =?utf-8?B?dEJ2cHpEc3BCU3lzVUh1Uy9Sbkx0cDNqS2dLZjhmVjU2OEhXYzNCZkV2N3Zn?=
 =?utf-8?B?WnNtR0wrYkdOajN3MUlYL3EvRlpnTHZMS1l0czVTNWZieERqbVl3d21EM2lY?=
 =?utf-8?B?dHFTZW1KbWEycFdOQmpHNmFnRDRPRlpFczBIcGVadEUxVk43SHF3cld1K1Ns?=
 =?utf-8?B?N3VjQ2p2aW0vbWJuSXR1dzBiMXNIRU9Cb3RyNDlNdG1UYzh0U1JmeUYxN3VR?=
 =?utf-8?B?OUllQmpwdE02ekFOYnFBNTZXY1Z2MDNEOVB0R2ttekF3OUN6ckFyMjJMWkFs?=
 =?utf-8?B?SWx6dzRrUmljSzBLVlBjenJ6NlhZUld3enZJNEE3dHRldkczV254MExmeWJl?=
 =?utf-8?B?dmltaVFLQ0JhVTZXaUdUWWZLVUtMdWxuVE9udmVwR25aejVlQjBwVUNMMjhH?=
 =?utf-8?Q?rx5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F161D510C0CC408A386005A859900D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d15c1c3-969c-42e4-e726-08ddb3fdd5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 15:34:55.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SeVXjye9aZe3tDco+v6IsHT7RNDwFH0eiwMZXUrN6bp6xbZYr1u4WH8hPa07VuTxuX/gKZStw1pz6MDWJEA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

T24gNi8yNS8yNSAxMDoxNyBBTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAyNSwgMjAyNSBhdCAwMzoxNDo0MFBNICswMDAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6
DQo+PiBPbiA2LzI1LzI1IDEwOjEwIEFNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24g
V2VkLCBKdW4gMjUsIDIwMjUgYXQgMDM6MDI6MThQTSArMDAwMCwgTGltb25jaWVsbG8sIE1hcmlv
IHdyb3RlOg0KPj4+PiBPbiA2LzI1LzI1IDk6NDEgQU0sIE1hcmlvIExpbW9uY2llbGxvIHdyb3Rl
Og0KPj4+Pj4gT24gNi8yNS8yNSA5OjMxIEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4+Pj4+
IE9uIDI1LUp1bi0yNSA0OjA5IFBNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4+Pj4+Pj4g
T24gNi8yNS8yNSA0OjA5IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4+Pj4+Pj4gT24gMjQt
SnVuLTI1IDEwOjIyIFBNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gDQo+IC4uLg0KPiAN
Cj4+Pj4+PiBPaywgc28gc3BlY2lmaWNhbGx5IHRoZSBncGlvZF9zZXRfZGVib3VuY2UoKSBjYWxs
IHdpdGggNTAgbXMNCj4+Pj4+PiBkb25lIGJ5IGdwaW9fa2V5cy5jIGlzIHRoZSBwcm9ibGVtIEkg
Z3Vlc3M/DQo+Pj4+Pg0KPj4+Pj4gWWVwLg0KPj4+Pj4NCj4+Pj4+PiBTbyBhbWRfZ3Bpb19zZXRf
ZGVib3VuY2UoKSBkb2VzIGFjY2VwdCB0aGUgNTAgbXMgZGVib3VuY2UNCj4+Pj4+PiBwYXNzZWQg
dG8gaXQgYnkgZ3Bpb19rZXlzLmMgYXMgYSB2YWxpZCB2YWx1ZSBhbmQgdGhlbiBzZXR0aW5nDQo+
Pj4+Pj4gdGhhdCBicmVha3MgdGhlIHdha2UgZnJvbSBzdXNwZW5kPw0KPj4+Pj4NCj4+Pj4+IFRo
YXQncyByaWdodC4NCj4+Pg0KPj4+Pj4+PiBBbHNvIGNvbXBhcmluZyB0aGUgR1BJTyByZWdpc3Rl
ciBpbiBXaW5kb3dzICh3aGVyZSB0aGluZ3Mgd29yaykNCj4+Pj4+Pj4gV2luZG93cyBuZXZlciBw
cm9ncmFtcyBhIGRlYm91bmNlLg0KPj4+Pj4+DQo+Pj4+Pj4gU28gbWF5YmUgdGhlIHdpbmRvd3Mg
QUNQSTAwMTEgZHJpdmVyIGFsd2F5cyB1c2VzIGEgc29mdHdhcmUtDQo+Pj4+Pj4gZGVib3VuY2Ug
Zm9yIHRoZSBidXR0b25zPyBXaW5kb3dzIG5vdCBkZWJvdW5jaW5nIHRoZSBtZWNoYW5pY2FsDQo+
Pj4+Pj4gc3dpdGNoZXMgYXQgYWxsIHNlZW1zIHVubGlrZWx5Lg0KPj4+Pj4+DQo+Pj4+Pj4gSSB0
aGluayB0aGUgYmVzdCB3YXkgdG8gZml4IHRoaXMgbWlnaHQgYmUgdG8gYWRkIGEgbm8taHctZGVi
b3VuY2UNCj4+Pj4+PiBmbGFnIHRvIHRoZSBkYXRhIHBhc3NlZCBmcm9tIHNvY19idXR0b25fYXJy
YXkuYyB0byBncGlvX2tleXMuYw0KPj4+Pj4+IGFuZCBoYXZlIGdwaW9fa2V5cy5jIG5vdCBjYWxs
IGdwaW9kX3NldF9kZWJvdW5jZSgpwqAgd2hlbiB0aGUNCj4+Pj4+PiBuby1ody1kZWJvdW5jZSBm
bGFnIGlzIHNldC4NCj4+Pj4+Pg0KPj4+Pj4+IEkndmUgY2hlY2tlZCBhbmQgYm90aCBvbiBCYXkg
VHJhaWwgYW5kIENoZXJyeSBUcmFpbCBkZXZpY2VzDQo+Pj4+Pj4gd2hlcmUgc29jX2J1dHRvbl9h
cnJheSBpcyB1c2VkIGEgbG90IGh3LWRlYm91bmNpbmcgaXMgYWxyZWFkeQ0KPj4+Pj4+IHVudXNl
ZC4gcGluY3RybC1iYXl0cmFpbC5jIGRvZXMgbm90IGFjY2VwdCA1MCBtcyBhcyBhIHZhbGlkDQo+
Pj4+Pj4gdmFsdWUgYW5kIHBpbmN0cmwtY2hlcnJ5dmlldy5jIGRvZXMgbm90IHN1cHBvcnQgaHcg
ZGVib3VuY2UNCj4+Pj4+PiBhdCBhbGwuDQo+Pj4+Pg0KPj4+Pj4gVGhhdCBzb3VuZHMgYSBsaWtl
IGEgZ2VuZXJhbGx5IGdvb2QgZGlyZWN0aW9uIHRvIG1lLg0KPj4+DQo+Pj4gVGhpbmtpbmcgYSBi
aXQgbW9yZSBvZiB0aGlzLCBwZXJoYXBzIHRoZSBIVyBkZWJvdW5jZSBzdXBwb3J0IGZsYWcgc2hv
dWxkIGJlDQo+Pj4gcGVyLUdQSU8tZGVzY3JpcHRvciB0aGluZ3kuIEluIHN1Y2ggY2FzZXMgd2Ug
ZG9uJ3QgbmVlZCB0byBkaXN0aW5ndWlzaCB0aGUNCj4+PiBwbGF0Zm9ybXMsIHRoZSBHUElPIEFD
UEkgbGliIG1heSBzaW1wbHkgc2V0IHRoYXQgZmxhZyBiYXNlZCBvbiAwIHJlYWQgZnJvbQ0KPj4+
IHRoZSBBQ1BJIHRhYmxlcy4gSXQgd2lsbCBhbHNvIGdpdmUgYSBjbHVlIHRvIGFueSBkcml2ZXIg
dGhhdCB1c2VzIEdQSU9zDQo+Pj4gKG5vdCBvbmx5IGdwaW8ta2V5cykuDQo+Pg0KPj4gQnV0IDAg
ZG9lc24ndCBtZWFuIGhhcmR3YXJlIGRlYm91bmNlIHN1cHBvcnQgaXMgdGhlcmUsIDAgbWVhbnMg
dGhhdA0KPj4gaGFyZHdhcmUgZGVib3VuY2UgaXMgbm90IHJlcXVpcmVkIHRvIGJlIHByb2dyYW1t
ZWQgZm9yIHRoaXMgR1BJTy4NCj4+DQo+PiBUaGF0IGlzIC0gaWYgYW5vdGhlciBzeXN0ZW0gaGFk
IGEgbm9uLXplcm8gdmFsdWUgaW4gdGhlIEdwaW9JbnQgZW50cnkgSQ0KPj4gd291bGQgZXhwZWN0
IHRoaXMgdG8gYmUgdHJhbnNsYXRlZCBpbnRvIHRoZSBHUElPIHJlZ2lzdGVyLg0KPiANCj4gQ29y
cmVjdC4gVGhlIHF1ZXN0aW9uIGlzIG9ubHkgYWJvdXQgMC4gU28gdGhlIGZsb3cgd2lsbCBsb29r
IGxpa2UNCj4gDQo+IDEpIGlmIHRoZSBHUElPIGlzIGRlZmluZWQgd2l0aCAwIGRlYm91bmNlLCBz
ZXQgdGhlIGZsYWc7DQo+IDIpIGlmIHRoZSBHUElPIGlzIGRlZmluZWQgd2l0aCBub24temVybyB2
YWx1ZSwgdHJ5IHRvIGFwcGx5IGl0Ow0KPiAzKSBpZiB0aGUgc3RlcCAyKSBmYWlscywgd2FybiBh
bmQgc2V0IHRoZSBmbGFnLg0KPiANCj4gV291bGQgaXQgbWFrZSBzZW5zZT8NCj4gSGFucz8NCj4g
DQoNCkJ1dCBzbyBvbiB0aGVzZSBwcm9ibGVtYXRpYyBCWVQvQ1lUIHRhYmxldHMgd2hpY2ggImxh
eWVyIiBzaG91bGQgYmUgDQpzZXR0aW5nIHRoZSA1MG1zIGRlYm91bmNlPw0KVGhhdCBzaG91bGQg
c3RpbGwgYmUgYSBxdWlyayBhdCB0aGUgc29jX2J1dHRvbl9hcnJheSBsYXllciwgcmlnaHQ/DQoN
CkJlY2F1c2UgZ3Bpb19rZXlzX3NldHVwX2tleSgpIHdpbGwgYWxyZWFkeSBmYWxsYmFjayB0byBz
b2Z0d2FyZSANCmRlYm91bmNlLCBhbmQgdGhlIGdvYWwgaGVyZSBpcyB0aGF0IGJvdGggb2YgdGhv
c2Ugb25seSB1c2UgdGhlIDUwbXMgDQpzcGVjaWZpY2FsbHkgd2l0aCBzb2Z0d2FyZSBkZWJvdW5j
aW5nLg0K

