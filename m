Return-Path: <linux-acpi+bounces-14616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CCAE8BE1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399DE4A3CDD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72842D5417;
	Wed, 25 Jun 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q3tlo2HE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBE2C3769;
	Wed, 25 Jun 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874394; cv=fail; b=TO8WhMbYjWKB3KSN9RzZZ4t5z1ZPO94lmGoXnzcFHY8Ora5ZGz0PgBq/girfhw5Dpkol1Qdo0ZfQAyQkwGlbF3yGylioKEXZ6dF7PtaT+UmsWmtFpHQb9D6CdkUs+763a3YZf/4CrjxcS5VMREv8ZBe4Ce0b+mkKAib77mNsXiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874394; c=relaxed/simple;
	bh=BV6WYaZad4/NocwbC2SyxDQgdp9BM8sIjyWdAAmqEqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBAXDKs1TXVae4YNGR+W0ckdV2GZJodifvsVcStLGckaAL7p30Zzd5vOb4bFNUYWyaaqPpb31SKp2qzhdgRbhWa2iXa9Xy8CGVRBjNo0Bp8urE3wfcNJVYepLj9kezOFyzyXu9Cm/Q+/uw3Yp8UIQBZYq4NF28pe6nXKGKGpCJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q3tlo2HE; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9UQBoAtaOeM5Pg13y7zJOYyFT5XwX3Q+EPlopb734BD1Bjv2KFv/BflAP7jBiXgTtUx1FL1BayqTzRzS9uXbUwb0TuhmTU1zIDxJ/faV7/wWMSsrKARLxwkXrZZEiZYHhKtAJ97DA/XqEUtPvYnY7gHYJEuTJGvAuZr4KoP21CRTpXi/CRTMBd0qo70V3g5SaIYZrjrUJq8J78BGY9/hkOBvVJtjEexx5/ufU0jQXszk+jtP++vtpnCrtkcjT1IDdF7/ZHARNaTdJRNqTHutd++Sguk9n3poPM0hWUMfdKTHjoXwkMAqgZEqsF8j/oexEb0xIcFC/3lYihnWULf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV6WYaZad4/NocwbC2SyxDQgdp9BM8sIjyWdAAmqEqM=;
 b=tG4u6l9NRgq5oOqXnV/jel91/cx+Id8X7S8DY9x20cWR556ecl5siM76IFCcCvNI8Dpf0xByOXLGJuXjxnFFwIAAVDtJ1SrcGC9/w9jakEzE0qXEyY5ExtWChSZp9DiYhfhIC9uy/9bZHP4LgarRotBbSbxarh/ApsMCArN+JW9qJ47ARwxwj+srD74PY5aSu2yz3j0bf88NPoAkqoabp7iczjpWBeXL29PD4YC8Ehxl+F40wdtV0qOJs7r4qbIwKeBC0yyBH1Uqx+yktjJGEEIB/Nq7WHAsZTKN22DyJpcDVveZ7I5fYfyUPYs2+c+RoHdlUemME/vp5YJnaS4L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV6WYaZad4/NocwbC2SyxDQgdp9BM8sIjyWdAAmqEqM=;
 b=Q3tlo2HE2kOYuVNs1vIf26piqf2Ye9hCtE9youZd6v1Ydvv0lLYCUAHARB6VvCqIhMC9+fn1eMDuVKUzAvHA4bxzUEXu2Rv9sPJDEkbyWz3BvhS0UWTVg3yU9uSQC3NvMxgdBzwJ5PTcmXcOOybmTWG/gM2cjuMcJJQaeI31MWA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 17:59:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 17:59:50 +0000
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
 AQHb5UWwK1dzhg42d0uJNDUCuVsLt7QTlyaAgABT3ACAAAYXAIAAAu6AgAAFtwCAAAJIAIAAASwAgAAAyoCAAATdAIAAJvMAgAABi4A=
Date: Wed, 25 Jun 2025 17:59:50 +0000
Message-ID: <eb0a872e-0c96-43be-a583-49d221db661d@amd.com>
References: <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
 <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
 <aFwTCUXQydxRVEfk@smile.fi.intel.com>
 <6c0514e5-0ea6-4f66-9bc0-4230d7ef0d4b@amd.com>
 <aFw3yhVUkdtNnWXT@smile.fi.intel.com>
In-Reply-To: <aFw3yhVUkdtNnWXT@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB5975:EE_
x-ms-office365-filtering-correlation-id: 17371f03-d123-4648-ff0b-08ddb4121467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R01nNFJvLzA3WU1CL3BWL3BWNkEvWHgyTmV4ZmNzQUdvZmRxREZjTFZlTllt?=
 =?utf-8?B?ZFdLM1JNL3kzbU9mUkVkUXRCNVhkN08rUXlVZ3M2amwxWXFqeDJ6TjQ3RWJq?=
 =?utf-8?B?MUZMbGJtSzdPQzlqTUJkSHlnVmcycVdlWEtDTUFFZm1IckoxMDUvSkNxWjFX?=
 =?utf-8?B?NlZMcEkyMWRCL1hDVExUdVJ4Zk1JQUt1TWpsb0RTTkRaZkpEbmRidjUweVB4?=
 =?utf-8?B?SEp1bmFJTXU5cjY3bEJBQmRxS3h2SFBWbmFDR0pZekJmTmEvZFJPd0YyVXg0?=
 =?utf-8?B?MHdaZ2hUNHB1Sll4bUZzd0VmQWJraDVTenlqZk4wTFVEY1pDSVNrTHYxNEc4?=
 =?utf-8?B?dEIycXF2Sk1hS0ZCbzlhR3BFY2FrRnRLSUpmNTdtek54c096YjdZcjVabDlZ?=
 =?utf-8?B?YW02ZGdVei9zYXNKSzFzb283VVZrelA3TUxaZU1pVTd1anlGMkdWTjlQQk5E?=
 =?utf-8?B?elBQMnNqT1QrbU1RWHBqSTAzNGE0ZEtpQ1d2M3dBTjNJb080UWZxTGlkOWVW?=
 =?utf-8?B?bGtBZ0RuTVdHTlNHUzZwMk1MOFpwbkcwNU4wOWl6UGlmYUJIR2pQQkZkblBx?=
 =?utf-8?B?QlUwLzVGeVJzMHRENUgrck9KRWhTelBCaTVOaHJyUXlsWWRUUWYwUE0xZjF3?=
 =?utf-8?B?MExNdlpSZUJ4czVpcGI3L0RxaUNBVUVFdGpYU2t5OFBjU1VRRmk2TjZzOFdu?=
 =?utf-8?B?UmxoRy93ZW9vVzZMbisyclJabkVERkVKbjR5cVBaYXd0TzhPZ1BucHdBbDIr?=
 =?utf-8?B?TStYcGFqMnFrMXJ4TlArdjVmZDEvWTRNdkRnaEZTdDhYZVExNnM1V0Q1aVBS?=
 =?utf-8?B?Q0k0WS8vWVhyTVo4M2lUQWYySVRuSkVXOWZVQUcxalNoZjNNUXZvTk9vR2pu?=
 =?utf-8?B?ajUzVTlMQ05CRGFYeWZEbzh0Snk4T2lSU2ZxZVRsYUs5WVB3YWgzTlJ0eXdo?=
 =?utf-8?B?RUk2TmtHVGF0ZTE1VUQrMkI4U1pKM3VzUk1mMmg3Q29QZmVXNUhPQm1nQk50?=
 =?utf-8?B?Z3UxWGhIekxtN01EY1h5YzJITEFvcnp1NGRabUVrdENxM2ZLbzB2S09CNndU?=
 =?utf-8?B?VkxYbnN6dmlMb00xeFYrY0pmRFNTNk95N1krbFZkVG1FTnl1dWdFdDIyeEho?=
 =?utf-8?B?WjZkQ2FxVE8rUW83VWlqWlg1dEhvYXF5LzF3a0RUU2VxRHE5SFlvSzl2NUFB?=
 =?utf-8?B?aUFvbXhVWmsyY3ZxR3VUcE5ISDNqNEVmQTRwN0F5T1ZBdHMvUVozQWZ1dGxm?=
 =?utf-8?B?VHZDSzg4NUZ2aWtDeEVxbjZrK096UG9GSkFBL285Z2NWREpZaWM2elBNeUhp?=
 =?utf-8?B?a3VGbEphNmJQeFZJSTlEcmk5UUkwdVhmeXh1NjQ3SDVGMHpySXJrNDB1NEdB?=
 =?utf-8?B?elBsVUtuUEdTcHAvS25CbnJQRWZZTE9mbDdpZnFFVGM0enJUSytXRG9WbEJB?=
 =?utf-8?B?QjBUK0UxbUVnemRyd3FGNnBZQk1qNXF4eW1UdXdvTUNUbWFoSS9NRFJZU0lW?=
 =?utf-8?B?Zy95U05DcGQ3MEFnbXBoUW9JNlk5d3g4cXg3THhQTzk5ZG5tMXVSUG0xRUda?=
 =?utf-8?B?OVI2SWdnV0h5SGhZTHhiQ2FVYlBzcnJ1ZEFhN081ZXpQeDc0M2ZCUmNHa25T?=
 =?utf-8?B?QkVKOVV6SmwxWGJHa0RGOFR3K2UwRllHQlVKeVB0THpLMUhGVUF4VmlnV1lQ?=
 =?utf-8?B?N2RZcHVxeThkTnFRVGhiaDdpWThQNUovdk0yckowak90dHVna29rSzVoY2h3?=
 =?utf-8?B?U24xa3p6NUpNL3FGR1FnSzdUamFveGlGblRqbkpXdVViVmlUWmQza0M1Qk1t?=
 =?utf-8?B?eGVERUNBQ09uN0piQ2VnQks4Y3V6Q0VIT2JDaVl4TnhHUUh4U09tWDdFUUpl?=
 =?utf-8?B?R096RWNLSWNOcjQyZG9Cc0dUSGZxZTZUaFF0cXJZVmF4bWVhZjAzSG9HdXdi?=
 =?utf-8?B?Y3JBVW43bUdhcEkva240TDhadGdoVjZtRzN5K05TVVdtempXRWY0cEkwbHVK?=
 =?utf-8?B?a2hadkl6TnNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlpNQ2hNWmlpOHBzK2Y4SVZZNytrQzlwa2pIeWNFeitmZ21FcDVHdkZSQmlZ?=
 =?utf-8?B?Tk8vV05wcHJqVUtYT1pVYzBxVHpTTjZZdGU1RVVnanl5OGliZ1hBT0ZXTzhP?=
 =?utf-8?B?NXBndG9tQmRTbzd1a2dJWm5oSzBuZXpnUWk5ZHowcEs5NFB5cDk2MG44S3Np?=
 =?utf-8?B?UmROTEJtTHcwUEx4Wk9QY3dqWlI1OFFVYnhVWXRGd2xIK0Y2WlR1WFFPOGF2?=
 =?utf-8?B?eHZwblFIaFBTNERVblY0c01YMlZLRlNmUWNUR3duL3BZbFV2WlppSGt2SS9V?=
 =?utf-8?B?Q3pnL0x3aXhXT0ZJL2NQdUw5emIxeUtjb1pheXFzMkpVTUVBYzF6TGFkZWZl?=
 =?utf-8?B?VDJIZEUvZDR6UmFvUTNINmNqbElRQVA5bS9sd2RZOEZ2K0hneVJmQlNXQ1VE?=
 =?utf-8?B?VWx4QVh5b1Fnai9BdXVmdDUzK1FCaWJMdFhra2R2ZTRWUXZ3bjFyNkFFeERP?=
 =?utf-8?B?cVZDOXo4U0VSWHVqT3NvSGhkQVdHSEp5SGs2d3ppZGE0SWQ4OGlFRmhCemVm?=
 =?utf-8?B?YzZZS3dIWnhvZlpMbDV4bnRmWVRvTVNpWjBnOWM0TVh4K09pVllXMk9BclBP?=
 =?utf-8?B?M1NnREdLdEhPbHV6WGpIWTFNWmpvbGgrTDlITTFscUNOOXBCaEJ2bG1WTGVN?=
 =?utf-8?B?Q2pVMXZXZDc3OUNLVjNkUnNHUFpOSHBldjJvOHU2NFhvQ1FVb2s5ejJBRWdz?=
 =?utf-8?B?OGZpT2lvTFRTemxJOHZQaVFhMm9LRk14U1NPQXRzbVdUY3VGR3MrbThWNWdI?=
 =?utf-8?B?cE5STk5NcTZ3VmpoUUNPRVdQSTlubDU2a2sya3hNc2ZuVHo4OFd4Y3ErL2w2?=
 =?utf-8?B?bXBZNWVWeEVxV1NaQ3AvemdCRDJIUUk5ZjEza0g5U1dPajUzUkdUdWUzbHFJ?=
 =?utf-8?B?UGgzK2JCRjUwMjhCNEYvSytsZGFYTE5PZDlxbnJtWmJjTENPT1lhU1RacDJ1?=
 =?utf-8?B?d2F4NDlYM2diVDBPV0ZHQVBqZGpvSmoxc3lwSWIzbytodUlNTDdBTzVaM0xr?=
 =?utf-8?B?bE1nVzdDK3pwSDN4Y0tGY0ErWXMwMEFjcEVZWDZzWjJSNW8yMEViR2pnUktv?=
 =?utf-8?B?R2w1c1ltNE1ZMVMyR003S2k0S1J2YXVsaXppSkpmdU5uOWhvdXZ1WTBLV0Mv?=
 =?utf-8?B?VXRBWkVGNVJ2WlNqcE1GNHVROWZsbWp0RkM3aXJ6ZUk5MUpQK3BzeGRYRSsz?=
 =?utf-8?B?cVYzOGdiWjFBeDY5YU5EVjhtRnM3RGVPeVI4S1FOOURLcE8wWFZjQmpvR0E1?=
 =?utf-8?B?Q3dtYkpjajkrV29FRlpJRzJnaEkzV3RJblNmWkpFdVVTYXdzblNyNVFzeFFQ?=
 =?utf-8?B?Q2RMMGZIN1RRaG5xSEdHdy83L2ZlZTB2NEMrMXZQMCtYWWZQZ0lacWFrRnF2?=
 =?utf-8?B?SlU0QnFMMTVpYktiZCtJbmJSekZsVmpaVGdlb09xbThrbFJ5aUZ2czNtRE9R?=
 =?utf-8?B?YWpvYkdsOEFwU1dFVWVUZXZEN3FpbmpYaVY3ZlBFZXhZcWRKMUFidk9saURU?=
 =?utf-8?B?OFhPaGRRTVoxSFhUQXppOVhoZGIwUFY5YlJQVDZNNUQyQVFwN3FGTnRXMFdx?=
 =?utf-8?B?ODBHblJNb2xxU01Ic3FPVUNNeEpmL0JuQXQ1U3BlY0dhaEFFQ2VOOGhnR09L?=
 =?utf-8?B?aWJ2c3pPeXRWRlJLWUVGemdhMG12VHFrQ3RFWERRekFpcnhPZ25LaVZRVmdS?=
 =?utf-8?B?QXdQM0lBNmVYWUNCYXZ1MkFGc3F0eUYzczl0UmQ2U0ZBSENuRG1sNER1WDJr?=
 =?utf-8?B?WmpkZHVDemthYzQrVThsNFV2VUZhOXhmbTFieTZtY1JsN2hmY3E0eFhrMG85?=
 =?utf-8?B?UHFkcjFQVlp4OFV0WEpWcFBBQjBYdUdlLzkya0ZQYUFjd0ZSVTZuUFhISE1y?=
 =?utf-8?B?dU12NDVHRlhvdlZORVRLcmtSZHFJMDdCVFpLczFDQ2o3Q1BQMW9YcmJjZ1Y0?=
 =?utf-8?B?WlB6QXR0VE1IdnZKdGkvU1IxR0gzQ3R0ZDlxbktieGx3Z3JjWTlqQmpCUGJr?=
 =?utf-8?B?VU56MWJlaDdCYzV3Vk5WU0xLbUhQWGFUN1NhUGJZN0UvWWhZcDdiRUtzT2pn?=
 =?utf-8?B?UlZjMXoza3pmNlNVYk5kLzQ4ekpCTmluVUlkVEF6cW1EcmRPMmZDem1xc0FF?=
 =?utf-8?Q?BqsQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C46C9CAAB16A7E41933E9ADB8A85DA1E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17371f03-d123-4648-ff0b-08ddb4121467
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 17:59:50.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCtcZWucqR7CDOEWX+uVVu9xuYX465s0GiAVo3V1Gcr1V9fc+KEHYaLDGBrFju2MZoQzuw80TI7WpDvxnlCvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

T24gNi8yNS8yNSAxMjo1NCBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAyNSwgMjAyNSBhdCAwMzozNDo1NVBNICswMDAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6
DQo+PiBPbiA2LzI1LzI1IDEwOjE3IEFNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24g
V2VkLCBKdW4gMjUsIDIwMjUgYXQgMDM6MTQ6NDBQTSArMDAwMCwgTGltb25jaWVsbG8sIE1hcmlv
IHdyb3RlOg0KPj4+PiBPbiA2LzI1LzI1IDEwOjEwIEFNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+Pj4+PiBPbiBXZWQsIEp1biAyNSwgMjAyNSBhdCAwMzowMjoxOFBNICswMDAwLCBMaW1vbmNp
ZWxsbywgTWFyaW8gd3JvdGU6DQo+Pj4+Pj4gT24gNi8yNS8yNSA5OjQxIEFNLCBNYXJpbyBMaW1v
bmNpZWxsbyB3cm90ZToNCj4+Pj4+Pj4gT24gNi8yNS8yNSA5OjMxIEFNLCBIYW5zIGRlIEdvZWRl
IHdyb3RlOg0KPj4+Pj4+Pj4gT24gMjUtSnVuLTI1IDQ6MDkgUE0sIE1hcmlvIExpbW9uY2llbGxv
IHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIDYvMjUvMjUgNDowOSBBTSwgSGFucyBkZSBHb2VkZSB3cm90
ZToNCj4+Pj4+Pj4+Pj4gT24gMjQtSnVuLTI1IDEwOjIyIFBNLCBNYXJpbyBMaW1vbmNpZWxsbyB3
cm90ZToNCj4gDQo+IC4uLg0KPiANCj4+Pj4+Pj4+IE9rLCBzbyBzcGVjaWZpY2FsbHkgdGhlIGdw
aW9kX3NldF9kZWJvdW5jZSgpIGNhbGwgd2l0aCA1MCBtcw0KPj4+Pj4+Pj4gZG9uZSBieSBncGlv
X2tleXMuYyBpcyB0aGUgcHJvYmxlbSBJIGd1ZXNzPw0KPj4+Pj4+Pg0KPj4+Pj4+PiBZZXAuDQo+
Pj4+Pj4+DQo+Pj4+Pj4+PiBTbyBhbWRfZ3Bpb19zZXRfZGVib3VuY2UoKSBkb2VzIGFjY2VwdCB0
aGUgNTAgbXMgZGVib3VuY2UNCj4+Pj4+Pj4+IHBhc3NlZCB0byBpdCBieSBncGlvX2tleXMuYyBh
cyBhIHZhbGlkIHZhbHVlIGFuZCB0aGVuIHNldHRpbmcNCj4+Pj4+Pj4+IHRoYXQgYnJlYWtzIHRo
ZSB3YWtlIGZyb20gc3VzcGVuZD8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhhdCdzIHJpZ2h0Lg0KPj4+
Pj4NCj4+Pj4+Pj4+PiBBbHNvIGNvbXBhcmluZyB0aGUgR1BJTyByZWdpc3RlciBpbiBXaW5kb3dz
ICh3aGVyZSB0aGluZ3Mgd29yaykNCj4+Pj4+Pj4+PiBXaW5kb3dzIG5ldmVyIHByb2dyYW1zIGEg
ZGVib3VuY2UuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU28gbWF5YmUgdGhlIHdpbmRvd3MgQUNQSTAw
MTEgZHJpdmVyIGFsd2F5cyB1c2VzIGEgc29mdHdhcmUtDQo+Pj4+Pj4+PiBkZWJvdW5jZSBmb3Ig
dGhlIGJ1dHRvbnM/IFdpbmRvd3Mgbm90IGRlYm91bmNpbmcgdGhlIG1lY2hhbmljYWwNCj4+Pj4+
Pj4+IHN3aXRjaGVzIGF0IGFsbCBzZWVtcyB1bmxpa2VseS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJ
IHRoaW5rIHRoZSBiZXN0IHdheSB0byBmaXggdGhpcyBtaWdodCBiZSB0byBhZGQgYSBuby1ody1k
ZWJvdW5jZQ0KPj4+Pj4+Pj4gZmxhZyB0byB0aGUgZGF0YSBwYXNzZWQgZnJvbSBzb2NfYnV0dG9u
X2FycmF5LmMgdG8gZ3Bpb19rZXlzLmMNCj4+Pj4+Pj4+IGFuZCBoYXZlIGdwaW9fa2V5cy5jIG5v
dCBjYWxsIGdwaW9kX3NldF9kZWJvdW5jZSgpwqAgd2hlbiB0aGUNCj4+Pj4+Pj4+IG5vLWh3LWRl
Ym91bmNlIGZsYWcgaXMgc2V0Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkndmUgY2hlY2tlZCBhbmQg
Ym90aCBvbiBCYXkgVHJhaWwgYW5kIENoZXJyeSBUcmFpbCBkZXZpY2VzDQo+Pj4+Pj4+PiB3aGVy
ZSBzb2NfYnV0dG9uX2FycmF5IGlzIHVzZWQgYSBsb3QgaHctZGVib3VuY2luZyBpcyBhbHJlYWR5
DQo+Pj4+Pj4+PiB1bnVzZWQuIHBpbmN0cmwtYmF5dHJhaWwuYyBkb2VzIG5vdCBhY2NlcHQgNTAg
bXMgYXMgYSB2YWxpZA0KPj4+Pj4+Pj4gdmFsdWUgYW5kIHBpbmN0cmwtY2hlcnJ5dmlldy5jIGRv
ZXMgbm90IHN1cHBvcnQgaHcgZGVib3VuY2UNCj4+Pj4+Pj4+IGF0IGFsbC4NCj4+Pj4+Pj4NCj4+
Pj4+Pj4gVGhhdCBzb3VuZHMgYSBsaWtlIGEgZ2VuZXJhbGx5IGdvb2QgZGlyZWN0aW9uIHRvIG1l
Lg0KPj4+Pj4NCj4+Pj4+IFRoaW5raW5nIGEgYml0IG1vcmUgb2YgdGhpcywgcGVyaGFwcyB0aGUg
SFcgZGVib3VuY2Ugc3VwcG9ydCBmbGFnIHNob3VsZCBiZQ0KPj4+Pj4gcGVyLUdQSU8tZGVzY3Jp
cHRvciB0aGluZ3kuIEluIHN1Y2ggY2FzZXMgd2UgZG9uJ3QgbmVlZCB0byBkaXN0aW5ndWlzaCB0
aGUNCj4+Pj4+IHBsYXRmb3JtcywgdGhlIEdQSU8gQUNQSSBsaWIgbWF5IHNpbXBseSBzZXQgdGhh
dCBmbGFnIGJhc2VkIG9uIDAgcmVhZCBmcm9tDQo+Pj4+PiB0aGUgQUNQSSB0YWJsZXMuIEl0IHdp
bGwgYWxzbyBnaXZlIGEgY2x1ZSB0byBhbnkgZHJpdmVyIHRoYXQgdXNlcyBHUElPcw0KPj4+Pj4g
KG5vdCBvbmx5IGdwaW8ta2V5cykuDQo+Pj4+DQo+Pj4+IEJ1dCAwIGRvZXNuJ3QgbWVhbiBoYXJk
d2FyZSBkZWJvdW5jZSBzdXBwb3J0IGlzIHRoZXJlLCAwIG1lYW5zIHRoYXQNCj4+Pj4gaGFyZHdh
cmUgZGVib3VuY2UgaXMgbm90IHJlcXVpcmVkIHRvIGJlIHByb2dyYW1tZWQgZm9yIHRoaXMgR1BJ
Ty4NCj4+Pj4NCj4+Pj4gVGhhdCBpcyAtIGlmIGFub3RoZXIgc3lzdGVtIGhhZCBhIG5vbi16ZXJv
IHZhbHVlIGluIHRoZSBHcGlvSW50IGVudHJ5IEkNCj4+Pj4gd291bGQgZXhwZWN0IHRoaXMgdG8g
YmUgdHJhbnNsYXRlZCBpbnRvIHRoZSBHUElPIHJlZ2lzdGVyLg0KPj4+DQo+Pj4gQ29ycmVjdC4g
VGhlIHF1ZXN0aW9uIGlzIG9ubHkgYWJvdXQgMC4gU28gdGhlIGZsb3cgd2lsbCBsb29rIGxpa2UN
Cj4+Pg0KPj4+IDEpIGlmIHRoZSBHUElPIGlzIGRlZmluZWQgd2l0aCAwIGRlYm91bmNlLCBzZXQg
dGhlIGZsYWc7DQo+Pj4gMikgaWYgdGhlIEdQSU8gaXMgZGVmaW5lZCB3aXRoIG5vbi16ZXJvIHZh
bHVlLCB0cnkgdG8gYXBwbHkgaXQ7DQo+Pj4gMykgaWYgdGhlIHN0ZXAgMikgZmFpbHMsIHdhcm4g
YW5kIHNldCB0aGUgZmxhZy4NCj4+Pg0KPj4+IFdvdWxkIGl0IG1ha2Ugc2Vuc2U/DQo+Pj4gSGFu
cz8NCj4+DQo+PiBCdXQgc28gb24gdGhlc2UgcHJvYmxlbWF0aWMgQllUL0NZVCB0YWJsZXRzIHdo
aWNoICJsYXllciIgc2hvdWxkIGJlDQo+PiBzZXR0aW5nIHRoZSA1MG1zIGRlYm91bmNlPw0KPj4g
VGhhdCBzaG91bGQgc3RpbGwgYmUgYSBxdWlyayBhdCB0aGUgc29jX2J1dHRvbl9hcnJheSBsYXll
ciwgcmlnaHQ/DQo+Pg0KPj4gQmVjYXVzZSBncGlvX2tleXNfc2V0dXBfa2V5KCkgd2lsbCBhbHJl
YWR5IGZhbGxiYWNrIHRvIHNvZnR3YXJlDQo+PiBkZWJvdW5jZSwgYW5kIHRoZSBnb2FsIGhlcmUg
aXMgdGhhdCBib3RoIG9mIHRob3NlIG9ubHkgdXNlIHRoZSA1MG1zDQo+PiBzcGVjaWZpY2FsbHkg
d2l0aCBzb2Z0d2FyZSBkZWJvdW5jaW5nLg0KPiANCj4gUHJvYmFibHkgZ3Bpb2Rfc2V0X2RlYm91
bmNlKCkgc2hvdWxkIGJlY29tZSBhIG5vLW9wIGluIHRoaXMgY2FzZT8NCj4gDQoNCkJ1dCBteSBw
b2ludCBpcyB0aGlzIDUwIG5lZWRzIHRvIGJlIGEgcXVpcmsgL3NvbWV3aGVyZS8uICBJdCBzaG91
bGRuJ3QgDQpiZSBhIGRlZmF1bHQgYmVoYXZpb3IuDQoNCkl0IGNhbiBiZSBpbiB0aGUgR1BJTyBk
cml2ZXIocyksIGl0IGNhbiBiZSBpbiBzb2MtYnV0dG9uLWFycmF5LCBvciBpdCANCmNhbiBiZSBp
biBncGlvX2tleXMuDQoNCkkndmUgZ290IGFuIGlkZWEgbW9ja2VkIHVwIGZvciBhIHYyLCBJJ2xs
IHNlbmQgdGhhdCBvdXQgYW5kIEkgdGhpbmsgd2UgDQpjYW4gZGlzY3VzcyB0aGUgbWVyaXRzIG9m
IGl0IG9uIHRoYXQgc2VyaWVzLg0K

