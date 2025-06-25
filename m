Return-Path: <linux-acpi+bounces-14597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A7AE875A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7D03A8FC1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5F266B41;
	Wed, 25 Jun 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLFOtN7q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169719D07E;
	Wed, 25 Jun 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863744; cv=fail; b=mc5uljmIPXmelfE3JqFFQ4k5TDGgBjNgXj0EoyyBrAHVEW2X9t/pT+yOAI+FRQcs1+EmD9lGt89tH2WR+ZnuQXg9cf4+/WD/LvweE+us/3P/xkYwkH36ZuxOIx8iFRQJNf6w0TP1qijLLOcXhYm87yMwZ8Q/owpK5x5UqnKKErc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863744; c=relaxed/simple;
	bh=yVTFjdyJ5Tjr2TuAH7d7lexUwlkz1CMwKBmQPaTViQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TBY3foxxL1YeEvbmSjUu6hDb2TYtvXeGw9CM5wEJVD0XlMx+ke7M+hiC8mOrKPrb9Sv0Kk3GD+V+Ec4QWdzCBKLeGexkMLeERQXMwUPYmy/ys073TwcRc9bm9LINRJ936YoVoljaPGZyEmUc5H2UB5YY+KDKsPNdMonTQgLZPbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLFOtN7q; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDxgwDakfGp5hUl/7oP+9MtnMhNAfcB10bhJMhuhE/+jK9vNXgUX+S9nkhIlIPpTpocShQofzyz5VMDEUT7t7gv571DQMQYuHpHu3LeT2odHvgc2rxiHyJHogyii4tPSvNUh05T5QZVFt3Q83+5JBePY29Dbn7d6USMICL8KcOVmnEDjOzzVVZhtrFMVPLl+oEQVvA/RMv5aQaVywnURkrpZuZHubbyjmujTKJt05lZqNYWRN5A7h9X91aqesPi2LWHxsnZ0qVCv2A21gBz6u3MhyhFbYIFkldt6oymg1zELWwBePLwonJ+XfVb+2LC+6flRQMwnayDHUX/ZYSkAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVTFjdyJ5Tjr2TuAH7d7lexUwlkz1CMwKBmQPaTViQE=;
 b=QAtfi3Xv/sv9zN2RmiMhFv0wemFhyhXofUhmmyheTwhqg8uwRiXDecVA+DKCSEvmoeXm4qg4MD3EmelBqOXsPM063pXFyjJE7uXcLhZPafg4Ut/6SECN9nSvUqkLkkVcGfiuqMBtmTHXt9/avqythl3jMew1flVSB4/Mg0C6qMBuyHV7JHw+EVj5vZ22PKNqu5rUc4n4qLa54DnhmomxShcBFF5BQ2T6VxP62l1OddmgOGCuQatJRpcHEsNafZWxWt13QJCY+pMaQqDmmZj9R5Eps4dXWp3PPEUOtxAYywt7QNLRYCBOXSxCxNl0Mn1xDZ6LnHiH4ahKoARx1A1aLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVTFjdyJ5Tjr2TuAH7d7lexUwlkz1CMwKBmQPaTViQE=;
 b=iLFOtN7qIqoJF4Q90oSEVisT3bF7vLb+O0wsnYw7HwZnwmQdtYF0/ndTQZTaONaV0PEdgw2BPbuXbAOlQVRc1URNKVUf60eANV7A2HuGiuTE39dA/Bsr3KTjGNy7dIHE8w36/MgPQJfq8xx5F09DnFhVxae73KxbXKXElp+xwd8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 15:02:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 15:02:18 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>
CC: "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "open
 list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Thread-Topic: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Thread-Index: AQHb5UWwK1dzhg42d0uJNDUCuVsLt7QTlyaAgABT3ACAAAYXAIAAAu6AgAAFtwA=
Date: Wed, 25 Jun 2025 15:02:18 +0000
Message-ID: <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
In-Reply-To: <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN0PR12MB6296:EE_
x-ms-office365-filtering-correlation-id: 816bff5f-390a-417c-23c1-08ddb3f9478b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2dnYkVjN2sybnNCR2kwYytaZU5mSUpYdUlOQVBBR0QzQXR2Q1dIektBMTlj?=
 =?utf-8?B?eHhRNGZNcWsrTGRxVmNlL01iU0FzUjhzTmNFdWhyblVTaVRvS0ZpVmJHa2ph?=
 =?utf-8?B?cTFvOGx5OUpOSzZQOU9rSjZkVm1ZMkdVSnczNXk0NjlXZ1NvSy9IQ09aZ0RG?=
 =?utf-8?B?ZU53NUtETmh3R0p5dHNSNjh6NFVLNFpZMnpoWVo0VzVZT2NHVUZPOGJWQXMv?=
 =?utf-8?B?U1lNNGdMM0NFenpzTzhFbDV6bTVNOUVlSm9Iejd2eFdHcUh5YUpGVzN6enNq?=
 =?utf-8?B?aWNDQlgwVkVsMzlxU0ZkSkREa2ZEcktaMnpPL2Erc0t6cU9aR0FGVHByZysy?=
 =?utf-8?B?NnBVcmhqVG1LdXNNSzlSb1p0MEJlYkFRRS9IZ3BHK1Ezd3AyV2tWbVM1L2px?=
 =?utf-8?B?dmIwaEp2VXBVL3dIczI0SU4wbVl5VlVDa2ROL0RlTkNKQzFuUXEzNU85YVJE?=
 =?utf-8?B?TzdLamRORmdHdm5aOENXbDdwNGloV1ZIWDFvUFNTelMzdzdSU3ZVZ0pQWHVk?=
 =?utf-8?B?OVgxY2Q0bkV6aER0dVBpa2MwVGhtQmVNdVg1OTRjb0NwR281bndOd0dacHlm?=
 =?utf-8?B?VktrU3NHWEVDMWJYVnNuVU0wWVZRT3FRM2tjVFVlTWg1ZVY0SWtmRUUvZm5O?=
 =?utf-8?B?STNWbWFkZk44QzVheW1ubFJRa1RuNHhkK0ZEQllMY1UwWGpzZGtvdTBXTDNJ?=
 =?utf-8?B?VEFEaDhUcng3T3JhWXQ5cFkxRFFCVHFzMTBlWmgzMTV1ZktOeGkyM0FCV09Q?=
 =?utf-8?B?N2FwVjFMcXhZeXdhRG5vODN2M0ZxaDJKeEVmdzh4Nml2anQzbXFyRlAyMVJj?=
 =?utf-8?B?Vjd2TFpHVEZJRmxTNmh5d25yVGdzeUdIREQxaC9hSWYrT25HZHBjZUtOVmpk?=
 =?utf-8?B?MGhUdS9Pa1llUDZGdkpXSjMvbGVna0VOdUo4Tk1WR2R6UnVpbnhFRWtVYkpt?=
 =?utf-8?B?a3JZTlZWYkFDYk5VNkxERlBHekRnK1ZuazQ5VE1QdmZYRzRjeFBISkIxcWNx?=
 =?utf-8?B?NmYvclREUW9TZk5yUis4ZEFQWENMeDdPNlZTRW5lNEZKR3lCN1cwSTVzNlYw?=
 =?utf-8?B?cUI5WFo3bVdCSWlRU0tFMkxBZllIM1dLcSt2MzljcUdRZ1JmaFBSeFVwRmhZ?=
 =?utf-8?B?bWRIa0xYc0MyMHpXK0pNOEJNdXNRbnFKdE1xNnhOTWdic2Z1UDdPdXowd3Aw?=
 =?utf-8?B?YWhwYU1nRjNGNWNTZFpNOEswcjFleXRtTmlzWlJYbUpzQzQydlRtZEdPQlNr?=
 =?utf-8?B?QXRGZkRvNHZaWnV4NG92N09PMVNiTEttdVZRQWNQcGVPVEZrNW01c0RSMEpK?=
 =?utf-8?B?a2s3VlFoMUdwY2Z5L3ptT1BsVUE3aHJzQzJzb1ErSHJFaWZjRmZ1THQrMmtG?=
 =?utf-8?B?Mm1RaldTa1FYdExQV3U1eGlzMHZZY2VHYnBURjRPNlVLM0hNN2wycXUzZ2Qr?=
 =?utf-8?B?NHhjZXZ3UzVBdWdiM0dVcW9UdmNVdy9GZ1cwQ3RTcGIrTEpScUR4N00raWV4?=
 =?utf-8?B?a2FsaE13WHMvR0FQaVFBOTJISDArT1lDUHJhSE93Ym55ZG16MnZXbXdoWW5K?=
 =?utf-8?B?cmhFUFJxOE9HSkpidmsyazU4UnV2dk1namQxSnovZHBEcnhJSFFaTWdKQmdC?=
 =?utf-8?B?TEtLeFBMaVU1eHFZQ2dzNkpwYng3aElkYlZTcUpteEN0NGVjeWwwc1hSdjQ1?=
 =?utf-8?B?NStFdE1idTNHYmJZbmVmUWJId2xIQ3FPb3JRREJxbjlJTFFYVVJvaTZ5UWsv?=
 =?utf-8?B?VGNneVc2b25aWmNKL0NKNlVFOWRPY3VSaTVvNG5KeVdUQzcxREZrYkNvbytE?=
 =?utf-8?B?d01nTGRLUFVyNHRDVlNiVS9yWGFvdnRmbkkxNW1kZUtlcDZmUXpRV2RSNy93?=
 =?utf-8?B?bzBOUFV2aWdrcEhCOHRxZ1VMbXR5LzdmbFJuMnE4MzlTNDlXZ3VLN3EzZVNG?=
 =?utf-8?Q?B/QBlAYvr3Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alM3MEpIRGlzSCtlaFRaZ3Y0Tm13MWl1OUxSTHQ5Sy95VDJlSnd0R0FhaGtM?=
 =?utf-8?B?WVZaTDlIVzVITUY3UHRwd2d0bmsrK25GZTVxZUdkU25LNTgxK3NTaEZRUm1z?=
 =?utf-8?B?SFdyTDhkTmVLMEhMaW44MTY2ZVVnZnNXWmw1U05UK0N3dnA2SCtQKzNPUUFu?=
 =?utf-8?B?WWtwSjRjZW50MWJhc3pjUml1Z1dLZ0l5cWJTcUthMm1peVpYSWlhRU5PK1pv?=
 =?utf-8?B?MWoyNGpubXUzdmVFODZjaXRGa25uUDhzNG9mMVFoamJZZThRVENwSnZFdllp?=
 =?utf-8?B?YnQ1L0U0M25ldHNVeWtMRjNuUWtTSmxOZkFwSElsQkVJK0JvNmc2MmRqOWp4?=
 =?utf-8?B?UEx5UXlYWjdQNkN6VHFBdUoxSTF2R280Q2c4bHhFT05TTXVNSVRVT0l5NXpP?=
 =?utf-8?B?bElMVXp6aVE5dVdNM0FLdDZjUXJoU25zNlFqKzlFcHlucHJwZEtQTko0Q3o1?=
 =?utf-8?B?WkdPSUNYeUdnTi9iR1FiSERzNXNZNEpzM3FBVFNZK0IzUEtGUE1OWnpqdTZL?=
 =?utf-8?B?aXE3MFVtYUpSQUtISDNIc1djdG9ERjJRQXpPdXEvMi9YS1NwRHVhVTZGdmlu?=
 =?utf-8?B?VVJvL3JxcGRwZERvSSttMk5yWGlrOE1Kenl4WXdFQ3RGWkpFZ0w0dzZ5SzB2?=
 =?utf-8?B?Sk5nT3d5QlhMWHhQUWVWUWlGcjNjWTk3ODM0a2doWDFrbkVwd0J3emx2WC8z?=
 =?utf-8?B?WmIyblYyQWFlclplY1hGUm9kNnZDL05BcU8vRGRkU3NqbGp2WEYvWm4yOEpk?=
 =?utf-8?B?ZUh1S29HZHZ0MThZUURwTURKek1MZkFJSVNvZXoxQXh2bTI2VTJSSkc2MEx0?=
 =?utf-8?B?Q3RKNHpkSTM1RWpEMEhVMlRKNlVhVmNRdU85YW8zZFUzY2xjV2xJMldONW5M?=
 =?utf-8?B?T05KQkVnSkpQbFMrVjVHSzl6akw2UHZxbDN6ZDJTRlZVUmlHc0ZXRHdBL0pJ?=
 =?utf-8?B?MW9EeG1FQXAzS0F5cXorbVBtRGpLdDRMUHFYWXFvWXBmTG4rTEhRV2tzUmtV?=
 =?utf-8?B?V1hPd0ZUS053Y0J6Z1ovRXNqNFQwZTFha1Mxc0d1Nk1pbkVmcVo3WXlQeFY1?=
 =?utf-8?B?enZnYzFLTXF3U05NQ3FuNHNLZTU3dHg2WkFPaUJnYUV2MmFmM3hPSXJ2ckpy?=
 =?utf-8?B?UjZqaDU5clM1MU9HRWJHaisrQnRqVnRBaUNsT3lyVUJKUm9pQUwrS1ljb0x2?=
 =?utf-8?B?VlNZMDNTU3dERUtKKy9pVVJaS2tKMkxzN2hIRXhkZ3E5bHdFT2FyMGJRL3JH?=
 =?utf-8?B?eEZ5SkVHOG1ydzl5cUpESXlIcFJZVXpWWUNUTDlZVnF4MFR3Z1ZHcHZidmhB?=
 =?utf-8?B?S0NFWDd2NzFsbzlwMDdUTTI5MGIxRkZ5Nmpqa09JWk1TN1Jkc2NoSUhpUjhZ?=
 =?utf-8?B?U3NORWtudlQ5ZSt4dkFMd3ZnZEhPNmxHeTZWY3UwaDQ0OFlybndqME5hb1ov?=
 =?utf-8?B?M3VMT2U0ZHp6aVhUcUJna21QSEdabHBXVEM4SjF2bkF1VUxjQVZQVVpYZVZz?=
 =?utf-8?B?Y2plYmdJRHIyd29jVHB5VTFrcC9lY2o5SHE2cHl4S1N2bkdqUEZ3SllyVTlL?=
 =?utf-8?B?d2tnTmdoNXRUOUdtL09ORFVKVUxxRDkwZXZDNXc5Q2RJTnZlS2ZrVkZGanZR?=
 =?utf-8?B?QWNtZHZsRkdwUUZmYUtlcW5uVU1heFNZY2JDcjNrM3krWkNxTE9PL21NOTF2?=
 =?utf-8?B?aUFvSUlpd1g0cDVCWWsxSFpFeEpWQVB3ekROZVdjL2lFVGcyQUQvR2hoUEFM?=
 =?utf-8?B?MGMwZzhOMzdrT1V0T2RWbFpaa3VGWGFTVWxLdnN6bGdoMXdTWGFxVUdMZkx3?=
 =?utf-8?B?Q2ZKWFNZM0ZPVG9ZalVYVFQzYWxOUFZ4dlk2TWU4Z1U1K3pTeEJvcGlITHAw?=
 =?utf-8?B?SWp4RjZKVHVLTk43ZTVQL21Xd2RTMUJZcEFxcHhuMW5LK1VqaGFMbnNmb1hz?=
 =?utf-8?B?dWJPOFRyZTh2ZW4rNTFIVGIvMlJLci9NUXNTbW9LNmtsUENSNmU2ZWNDYVQv?=
 =?utf-8?B?dEdCVWR0WU0zV1Q1amw4b296MlBHSFVuSW4zT0ZqNE45MUJQY2FvRlNGbkZo?=
 =?utf-8?B?UFphblAwbzIzTzdwbkhNaWlDL29jMnJ5QllqTFZ2eW1uUWNOc1g5UWM2L0Nn?=
 =?utf-8?Q?nBJI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BE6A0D0EFAAB44299493053D842EE94@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 816bff5f-390a-417c-23c1-08ddb3f9478b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 15:02:18.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5j3R2YBW7wtyqw6tFLgnYPbzPEZ2WLxGFc766IKRWO4DhM6eg2qFJjFNbobTuz9zbJYk4edPKobigtId9HgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296

T24gNi8yNS8yNSA5OjQxIEFNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gT24gNi8yNS8y
NSA5OjMxIEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4gSGkgTWFyaW8sDQo+Pg0KPj4gT24g
MjUtSnVuLTI1IDQ6MDkgUE0sIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPj4+IE9uIDYvMjUv
MjUgNDowOSBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+Pj4gSGkgTWFyaW8sDQo+Pj4+DQo+
Pj4+IE9uIDI0LUp1bi0yNSAxMDoyMiBQTSwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+Pj4+
PiBGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4+
Pj4+DQo+Pj4+PiBjb21taXQgNWM0ZmEyYTZkYTdmYiAoIklucHV0OiBzb2NfYnV0dG9uX2FycmF5
IC0gZGVib3VuY2UgdGhlIA0KPj4+Pj4gYnV0dG9ucyIpDQo+Pj4+PiBoYXJkY29kZWQgYWxsIHNv
Yy1idXR0b24tYXJyYXkgZGV2aWNlcyB0byB1c2UgYSA1MG1zIGRlYm91bmNlIHRpbWVvdXQNCj4+
Pj4+IGJ1dCB0aGlzIGRvZXNuJ3Qgd29yayBvbiBhbGwgaGFyZHdhcmUuwqAgVGhlIGhhcmR3YXJl
IEkgaGF2ZSBvbiBoYW5kDQo+Pj4+PiBhY3R1YWxseSBwcmVzY3JpYmVzIGluIHRoZSBBU0wgdGhh
dCB0aGUgdGltZW91dCBzaG91bGQgYmUgMDoNCj4+Pj4+DQo+Pj4+PiBHcGlvSW50IChFZGdlLCBB
Y3RpdmVCb3RoLCBFeGNsdXNpdmUsIFB1bGxVcCwgMHgwMDAwLA0KPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIlxcX1NCLkdQSU8iLCAweDAwLCBSZXNvdXJjZUNvbnN1bWVyLCAsKQ0KPj4+Pj4g
e8KgwqAgLy8gUGluIGxpc3QNCj4+Pj4+IMKgwqDCoMKgwqAgMHgwMDAwDQo+Pj4+PiB9DQo+Pj4+
Pg0KPj4+Pj4gTGV0IHRoZSBHUElPIGNvcmUgcHJvZ3JhbSB0aGUgZGVib3VuY2UgaW5zdGVhZCBv
ZiBoYXJkY29kaW5nIGl0IGludG8gYQ0KPj4+Pj4gZHJpdmVyLg0KPj4+Pj4NCj4+Pj4+IFRoaXMg
cmV2ZXJ0cyBjb21taXQgNWM0ZmEyYTZkYTdmYmM3NjI5MGQxY2I1NGE3ZTM1NjMzNTE3YTUyMi4N
Cj4+Pj4NCj4+Pj4gVGhpcyBpcyBnb2luZyB0byBjYXVzZSBwcm9ibGVtcyBJJ20gYWZyYWlkIEkg
anVzdCBjaGVja2VkIGFuZA0KPj4+PiBiYXNlZCBvbiByYW5kb21seSBjaGVja2luZyBhIGZldyBE
U0RUcyBvZiB0aGUgdGFibGV0cyB0aGlzIGRyaXZlcg0KPj4+PiBpcyB1c2VkIG9uLCBpdCBzZWVt
cyB0aGUgRFNEVCBhbHdheXMgc3BlY2lmaWVzIGEgZGVib3VuY2UgdGltZW91dA0KPj4+PiBvZiAw
IGxpa2UgeW91ciBleGFtcGxlIGFib3ZlLiBBbmQgb24gbWFueSBtYW55IGRldmljZXMgdXNpbmcN
Cj4+Pj4gdGhlIHNvY19idXR0b25fYXJyYXkgZHJpdmVyIGRlYm91bmNpbmcgaXMgYWN0dWFsbHkg
bmVjZXNzYXJ5Lg0KPj4+DQo+Pj4gVGhhdCdzIHVuZm9ydHVuYXRlIHRvIGhlYXIuDQo+Pj4NCj4+
Pj4NCj4+Pj4gTWF5IEkgYXNrIHdoYXQgcHJvYmxlbSB5b3UgYXJlIHNlZWluZyB3aXRoIHRoZSA1
MG1zIGRlYm91bmNlIHRpbWVvdXQgLw0KPj4+PiB3aGF0IHByb2JsZW0geW91IGFyZSBleGFjdGx5
IHRyeWluZyB0byBmaXggaGVyZSA/DQo+Pj4NCj4+PiBUaGUgcG93ZXIgYnV0dG9uIGRvZXNuJ3Qg
d29yayB0byB3YWtlIGZyb20gc3VzcGVuZC7CoCBJIGJpc2VjdGVkIGl0IA0KPj4+IGRvd24gdG8g
eW91ciBjb21taXQgYW5kIHRoZW4gbGF0ZXIgdHJhY2VkIHRoYXQgZGVib3VuY2UgZnJvbSB0aGUg
QVNMIA0KPj4+IG5ldmVyIGdldHMgc2V0IChwaW5jdHJsLWFtZCdzIGFtZF9ncGlvX3NldF9kZWJv
dW5jZSgpIGlzIG5ldmVyIGNhbGxlZCkuDQo+Pg0KPj4gT2ssIHNvIHNwZWNpZmljYWxseSB0aGUg
Z3Bpb2Rfc2V0X2RlYm91bmNlKCkgY2FsbCB3aXRoIDUwIG1zDQo+PiBkb25lIGJ5IGdwaW9fa2V5
cy5jIGlzIHRoZSBwcm9ibGVtIEkgZ3Vlc3M/DQo+IA0KPiBZZXAuDQo+IA0KPj4NCj4+IFNvIGFt
ZF9ncGlvX3NldF9kZWJvdW5jZSgpIGRvZXMgYWNjZXB0IHRoZSA1MCBtcyBkZWJvdW5jZQ0KPj4g
cGFzc2VkIHRvIGl0IGJ5IGdwaW9fa2V5cy5jIGFzIGEgdmFsaWQgdmFsdWUgYW5kIHRoZW4gc2V0
dGluZw0KPj4gdGhhdCBicmVha3MgdGhlIHdha2UgZnJvbSBzdXNwZW5kPw0KPiANCj4gVGhhdCdz
IHJpZ2h0Lg0KPiANCj4gSGVyZSBpcyB3aGF0IC9zeXMva2VybmVsL2RlYnVnL2dwaW8gaGFzIGZv
ciB0aGUgYmFkIGNhc2UgKG5vIHBhdGNoZXMpOg0KPiANCj4gIMKgZ3Bpb8KgwqDCoMKgIGludHxh
Y3RpdmV8dHJpZ2dlcnxTMGkzfCBTM3xTNC9TNXwgWnx3YWtlfHB1bGx8wqAgb3JpZW50fCANCj4g
IMKgZGVib3VuY2V8cmVnDQo+ICMwwqDCoMKgwqDCoMKgwqAg8J+Ym3zCoMKgwqDCoCBifMKgwqAg
ZWRnZXzCoMKgwqAgfMKgwqAgfMKgwqDCoMKgIHzij7B8wqDCoMKgIHzCoCDihpEgfGlucHV0wqAg
4oaRfGIgKPCflZEgDQo+IDA0Njg3NXVzKXwweDgxNTFjZTMNCj4gDQo+IEFuZCB0aGVuIGZvciB0
aGUgZ29vZCBjYXNlICh0aGVzZSB0d28gcGF0Y2hlcyk6DQo+IA0KPiAgwqBncGlvwqDCoMKgwqAg
aW50fGFjdGl2ZXx0cmlnZ2VyfFMwaTN8IFMzfFM0L1M1fCBafHdha2V8cHVsbHzCoCBvcmllbnR8
IA0KPiAgwqBkZWJvdW5jZXxyZWcNCj4gIzDCoMKgwqDCoMKgwqDCoCDwn5ibfMKgwqDCoMKgIGJ8
wqDCoCBlZGdlfMKgwqDCoCB8wqDCoCB8wqDCoMKgwqAgfOKPsHzCoMKgwqAgfMKgIOKGkSB8aW5w
dXTCoCDihpF8ICAgICAgIA0KPiB8MHg4MTUxYzAwDQo+IA0KDQpPbmUgbW9yZSBjb21tZW50IHRv
IHNoYXJlIGJlY2F1c2UgdGhlcmUgaXMgYSBjb25mdXNpbmcgcmVzdWx0IGluIHRoaXMgDQphYm92
ZSBkZWJ1ZyBsb2cuDQoNClN5c3RlbXMgdGhhdCAiZG9uJ3QgdXNlIiBzb2MtYnV0dG9uLWFycmF5
IHByb2dyYW0gdGhlICJzMGkzIiAvICJzMyIgd2FrZSANCmNvbnRyb2wgYml0cyBhdCBydW50aW1l
Lg0KU3lzdGVtcyB1c2luZyAiZG8gdXNlIiBzb2MtYnV0dG9uLWFycmF5IGRvbid0IHByb2dyYW0g
dGhlc2UgdW50aWwgDQpzdXNwZW5kIHRpbWUgdXNpbmcgZ3Bpb19rZXlzX3N1c3BlbmQoKSBhbmQg
ZGlzYWJsZSB0aGVtIGF0IHJlc3VtZSB0aW1lIA0Kd2l0aCBncGlvX2tleXNfcmVzdW1lKCkuDQoN
CiJGdW5jdGlvbmFsbHkiIHRoaXMgaXMgbm90IGEgcHJvYmxlbSwgYnV0IGl0IHdhcyBhbm90aGVy
IHJhYmJpdCBob2xlIA0KdGhhdCBJIHdlbnQgZG93biBkZWJ1Z2dpbmcgdGhpcyBpc3N1ZSwgc28g
SSB3YW50IHRvIG1ha2Ugc3VyZSBhbnlvbmUgd2hvIA0KY29tZXMgYWNyb3NzIHRoaXMgdGhyZWFk
IGlzIGF3YXJlIG9mIGl0Lg0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi92Ni4xNi1yYzMvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9ncGlvX2tleXMuYyNMMTA0OQ0KDQo+
IA0KPj4NCj4+PiBBbHNvIGNvbXBhcmluZyB0aGUgR1BJTyByZWdpc3RlciBpbiBXaW5kb3dzICh3
aGVyZSB0aGluZ3Mgd29yaykgDQo+Pj4gV2luZG93cyBuZXZlciBwcm9ncmFtcyBhIGRlYm91bmNl
Lg0KPj4NCj4+IFNvIG1heWJlIHRoZSB3aW5kb3dzIEFDUEkwMDExIGRyaXZlciBhbHdheXMgdXNl
cyBhIHNvZnR3YXJlLQ0KPj4gZGVib3VuY2UgZm9yIHRoZSBidXR0b25zPyBXaW5kb3dzIG5vdCBk
ZWJvdW5jaW5nIHRoZSBtZWNoYW5pY2FsDQo+PiBzd2l0Y2hlcyBhdCBhbGwgc2VlbXMgdW5saWtl
bHkuDQo+Pg0KPj4gSSB0aGluayB0aGUgYmVzdCB3YXkgdG8gZml4IHRoaXMgbWlnaHQgYmUgdG8g
YWRkIGEgbm8taHctZGVib3VuY2UNCj4+IGZsYWcgdG8gdGhlIGRhdGEgcGFzc2VkIGZyb20gc29j
X2J1dHRvbl9hcnJheS5jIHRvIGdwaW9fa2V5cy5jDQo+PiBhbmQgaGF2ZSBncGlvX2tleXMuYyBu
b3QgY2FsbCBncGlvZF9zZXRfZGVib3VuY2UoKcKgIHdoZW4gdGhlDQo+PiBuby1ody1kZWJvdW5j
ZSBmbGFnIGlzIHNldC4NCj4+DQo+PiBJJ3ZlIGNoZWNrZWQgYW5kIGJvdGggb24gQmF5IFRyYWls
IGFuZCBDaGVycnkgVHJhaWwgZGV2aWNlcw0KPj4gd2hlcmUgc29jX2J1dHRvbl9hcnJheSBpcyB1
c2VkIGEgbG90IGh3LWRlYm91bmNpbmcgaXMgYWxyZWFkeQ0KPj4gdW51c2VkLiBwaW5jdHJsLWJh
eXRyYWlsLmMgZG9lcyBub3QgYWNjZXB0IDUwIG1zIGFzIGEgdmFsaWQNCj4+IHZhbHVlIGFuZCBw
aW5jdHJsLWNoZXJyeXZpZXcuYyBkb2VzIG5vdCBzdXBwb3J0IGh3IGRlYm91bmNlDQo+PiBhdCBh
bGwuDQo+IA0KPiBUaGF0IHNvdW5kcyBhIGxpa2UgYSBnZW5lcmFsbHkgZ29vZCBkaXJlY3Rpb24g
dG8gbWUuDQo+IA0KPiBJIHRoaW5rIEkgd291bGQgc3RpbGwgbGlrZSB0byBzZWUgdGhlIEFTTCB2
YWx1ZXMgdHJhbnNsYXRlZCBpbnRvIHRoZSANCj4gaGFyZHdhcmUgZXZlbiBpZiB0aGUgQVNMIGhh
cyBhICIwIiB2YWx1ZS4NCj4gU28gSSB3b3VsZCBrZWVwIHBhdGNoIDEgYnV0IGFkanVzdCBmb3Ig
dGhlIHdhcm5pbmcgeW91IGd1eXMgYm90aCBjYWxsZWQgDQo+IG91dC4NCj4gDQo+IEFzIHlvdSBo
YXZlIHRoaXMgaGFyZHdhcmUgd291bGQgeW91IGJlIGFibGUgdG8gd29yayBvdXQgdGhhdCBxdWly
az8NCj4gDQo+IE9yIGlmIHlvdSB3YW50IG1lIHRvIGRvIGl0LCBJJ2xsIG5lZWQgc29tZXRoaW5n
IHRvIGdvIG9uIGhvdyB0byBob3cgdG8gDQo+IGVmZmVjdGl2ZWx5IGRldGVjdCBCWVQgYW5kIENZ
VCBoYXJkd2FyZS4NCj4gDQo+Pg0KPj4+IFNvIHRoYXQncyB3aGVyZSBib3RoIHBhdGNoZXMgaW4g
dGhpcyBzZXJpZXMgY2FtZSBmcm9tLg0KPj4+DQo+Pj4+DQo+Pj4+IGRyaXZlcnMvaW5wdXQva2V5
Ym9hcmQvZ3Bpb19rZXlzLmMgZmlyc3Qgd2lsbCBjYWxsIGdwaW9kX3NldF9kZWJvdW5jZSgpDQo+
Pj4+IGl0IHNlbGYgd2l0aCB0aGUgNTAgbXMgcHJvdmlkZWQgYnkgc29jX2J1dHRvbl9hcnJheSBh
bmQgaWYgdGhhdCBkb2VzDQo+Pj4+IG5vdCB3b3JrIGl0IHdpbGwgZmFsbCBiYWNrIHRvIHNvZnR3
YXJlIGRlYm91bmNpbmcuIFNvIEkgZG9uJ3Qgc2VlIGhvdw0KPj4+PiB0aGUgNTAgbXMgZGVib3Vu
Y2UgY2FuIGNhdXNlIHByb2JsZW1zLCBvdGhlciB0aGVuIG1heWJlIG1ha2luZw0KPj4+PiByZWFs
bHkgcmVhbGx5IChpbXBvc3NpYmxlPykgZmFzdCBkb3VibGUtY2xpY2tzIHJlZ2lzdGVyIGFzIGEg
c2luZ2xlDQo+Pj4+IGNsaWNrIC4NCj4+Pj4NCj4+Pj4gVGhlc2UgYnV0dG9ucyAoZS5nLiB2b2x1
bWUgdXAvZG93bikgYXJlIGFsbW9zdCBhbHdheXMgc2ltcGx5IG1lY2hhbmljYWwNCj4+Pj4gc3dp
dGNoZXMgYW5kIHRoZXNlIGRlZmluaXRlbHkgd2lsbCBuZWVkIGRlYm91bmNpbmcsIHRoZSAwIHZh
bHVlIGZyb20NCj4+Pj4gdGhlIERTRFQgaXMgcGxhaW5seSBqdXN0IHdyb25nLiBUaGVyZSBpcyBu
byBzdWNoIHRoaW5nIGFzIGEgbm90IA0KPj4+PiBib3VuY2luZw0KPj4+PiBtZWNoYW5pY2FsIHN3
aXRjaC4NCj4+Pg0KPj4+IE9uIG9uZSBvZiB0aGVzZSB0YWJsZXRzIGNhbiB5b3UgY2hlY2sgdGhl
IEdQSU8gaW4gV2luZG93cyB0byBzZWUgaWYgDQo+Pj4gaXQncyB1c2luZyBhbnkgZGVib3VuY2U/
DQo+Pg0KPj4gSSdtIGFmcmFpZCBJIGRvbid0IGhhdmUgV2luZG93cyBpbnN0YWxsZWQgb24gYW55
IG9mIHRoZXNlLg0KPj4NCj4+IEJ1dCBiYXNlZCBvbiB5b3VyIHRlc3RpbmcgKyB0aGUgRFNEVCBz
cGVjaWZ5aW5nIG5vIGRlYm91bmNlDQo+PiBmb3IgdGhlIEdQSU8gSSBndWVzcyBXaW5kb3dzIGp1
c3QgZm9sbG93cyB0aGUgRFNEdCB3aGVuIGl0DQo+PiBjb21lcyB0byBzZXR0aW5nIHVwIHRoZSBo
dyBkZWJvdW5jZS1zZXR0aW5ncyBhbmQgdGhlbiB1c2VzDQo+PiBzdy1kZWJvdW5jaW5nIG9uIHRv
cCB0byBhY3R1YWxseSBhdm9pZCB2ZXJ5IHF1aWNrDQo+PiBwcmVzcy1yZWxlYXNlLXByZXNzIGV2
ZW50IGN5Y2xlcyBjYXVzZWQgYnkgdGhlIGJvdW5jaW5nLg0KPj4NCj4gDQo+IFllYWggdGhhdCBz
b3VuZHMgbGlrZSBhIHBsYXVzaWJsZSBoeXBvdGhlc2lzLg0KPiANCj4gDQoNCg==

