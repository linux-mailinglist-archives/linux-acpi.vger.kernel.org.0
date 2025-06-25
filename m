Return-Path: <linux-acpi+bounces-14599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD29AE87AA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E03816B78E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB526B763;
	Wed, 25 Jun 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byLalVVC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3D26B2DB;
	Wed, 25 Jun 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864485; cv=fail; b=U3XmCF8B4u9WKo8V6Yh0m0aWrOExDTH9Tl8UfBA+7bFx7bs7bqk1Vj+NCbuFbJwk/1y6CvphB8Bz5/hcSLSo5pV/ledLzIQgS/hdk+/G8wsvc+PUVOolwSpJQnUUFV9xJWOE2yt2Ymku1Q4N9ZntjtZUH3+oS9YI/tPclxzE5ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864485; c=relaxed/simple;
	bh=qwFReQrePqC/EXpBP+rnXnMSqJdVyG1j1ABrQEQCRNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bvfAoKiQlLVanWZw005nqQejVtdxsZ5r0pG2JwnsVg/o9QMnLXr8ZvJmahgB4mwjUl44Ro3uE/sGLrV4zdbVNHUSzB3EeeGWke0fEXGGZhanjyy7eSdzRocbZGFXOGgdFOUlILefBbzgUzqlUSMwfHE4vUA/28o6ggVPLV4NfKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byLalVVC; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN/UMQow0CjRZm6rOnCH+OIDxkLHyVU9LL+N4ADjR1b9HtzC8ITYDJ3moki1dnkxreOPg705X8yo21rGS72lo3PwogsqxswDwXyMGxWYifPd2GJY79WbIGb6RdSn5wLhW+5P/1bRp6t6ASYHlrPsFiLs91+ZEbp598UKwgTJRhttYh0bXgpqQVgIKwZUROa8Fnp7wmrruBAQEzNCGzAGdrxAkHz7jPXl/Xonv2R3dADdycGB5FJy3DeYceTkt2b4UY5/fzpMfKz6eguOPfnJMwJCGWVhziYKNkdo3S/Po9OtbAK/wGvJb5aabL3/KLaBD7lRRYeA1mzPqRs0KZiS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwFReQrePqC/EXpBP+rnXnMSqJdVyG1j1ABrQEQCRNM=;
 b=D+P/BhbGjZthrOIaYDbDrAqq9LpGwifrYCFXXAgLEX/wubFrNqHD3277KDYQUxZqm9YU/u2L0zEpE3jmF1Jj1v7il0rOWogD3gtX1JHIXVB/VZafNBcTizzLPhiJN39V4/AGOjnPJl0XAs01iU9gHN7TfJftWyjh7tzGGc3FGVbR3i+5d6cwpYt2PecRAaThNL6/IEBT45M2xFqWy6Wo7NYDZPDYzgda0J5+FVNJd/mgD4UeFzAVr7RjNBx0pt/dRPzPTfnwh/IK+oaHCA3DtPi6e0lafU99dSjOndSGXY8M7WcjTSQd2Kjvh/QIQaxTpl6vG9Ha8/yoPSN0Kh4wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwFReQrePqC/EXpBP+rnXnMSqJdVyG1j1ABrQEQCRNM=;
 b=byLalVVCB+E7ogmBL3zZqtQ52vOHm0LFrwpCQkqQYIZMvS5jHU0TSmr0TGl1QYfKEwXKWDHCtwNnyzHdeBFX1Jwebl721os+O71yLVKmEUQXM/wAnHmtCizIDvjkjCBaMEMrDxie5Uap0BSEXJJTkYpyQjyu0jLeStKY//iYQDc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 25 Jun
 2025 15:14:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 15:14:40 +0000
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
 AQHb5UWwK1dzhg42d0uJNDUCuVsLt7QTlyaAgABT3ACAAAYXAIAAAu6AgAAFtwCAAAJIAIAAASwA
Date: Wed, 25 Jun 2025 15:14:40 +0000
Message-ID: <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
In-Reply-To: <aFwRZO30wf8GxQea@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB9071:EE_
x-ms-office365-filtering-correlation-id: 792c758f-4794-44af-3122-08ddb3fb01cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjluS0dCQnI2RzBlNWcxczRldldlYmNmRGVEYm9CeHBQQ3RzcGhzZ1F0cFNX?=
 =?utf-8?B?d294VG9aZ2xIdWdLTlVsUUFmNDBvUnJMRzNGV3I1U3dpY0tMdTdEeGI2WUNZ?=
 =?utf-8?B?dHgrUGd6YVFXYmhxRUJMeTdLMUxTMnZOQUlSYk81MWUwbTlhdDg3OXlvQ2JE?=
 =?utf-8?B?S1JXT3BDU3JFaUo3eVhuV2JVZ0xhMW9mZGdZb0tXTmFyQjQ1UDQ0MG5rMDRH?=
 =?utf-8?B?bElkUElsNUJkaU11SG5VaFJiUGwzM1NXcU94dTRoOTBJWmRhK0ZucC92eFlk?=
 =?utf-8?B?aXRNR28xT1hpUkFXeFdYRkJHT1dOR3plZUdETkxlYmNueGIrb0R5NlZYNVZp?=
 =?utf-8?B?Y3pmRlptb1VQVU5iTnR2ZG56QVkwN0FUWUo0TkJJYW1NUjZBWEJpYzNkSjlz?=
 =?utf-8?B?eFpqV005dFdRcGVPa1JGcVo3VkF4UktvK2xUN2gydmp0TEZqU2swblY4djFM?=
 =?utf-8?B?WGQyT0IxTHdWUTAraUJFL2gvN1drUlZ5L24vVG45MGF4c0tWU0x6NkVCTWxE?=
 =?utf-8?B?MDJNUjNxWXd4SWhyc1ZOTUM3anpXbzJsR2VLcmY0b0RJRG5zZUJwQzltTTMw?=
 =?utf-8?B?UWp6OXFMTkNqKzhpbWlGUDQ5TzhzeXJOVTFCNEZLV01qd1gzVWFRQkRrYm82?=
 =?utf-8?B?NFVlODkvY3h0dzY3RDRsRDl3U1RQWnljWGU4ZzNvR2l2RVJIK0grajEzbU9R?=
 =?utf-8?B?ZjlSTTVCTWlQTVc1dW1XdHg5cUIyK1dXYWg2ZlhhazBuV1JXTENEN3hWdU5j?=
 =?utf-8?B?NUdHMkkrRm5rYXZzSzZlTllhVklmUU1wOXFXMldVSFZ5YWoyeFdxMlk3NlpT?=
 =?utf-8?B?VEJFVi9PRFUyYWpwV0RFSXZMU0hmd3FQbFZvK3RtamFWZHNsd0RyNzQ5UTVh?=
 =?utf-8?B?bS9Sb2JaNWZFZEJ4NGJuakxlZHdpUWdwWStVWHZDekVVeWJkeldqY1lhWmNk?=
 =?utf-8?B?MCthMjhIdkJLTnI4Y1MraVdBbVlwNjNIYXdKZnRJUGh4ZmEwcVBQTEZvcWFn?=
 =?utf-8?B?WDNud1hkSnMrY3Y2K0NleHVtb3A3MmR4N0szd2FuK2tsTG9LdGFTb0tRQkZC?=
 =?utf-8?B?djFaZkNpMnlGdE85bkRwRy80eUgxTU1WVHN1ajV0dXJ4SUtJdkliSDRxc2Ny?=
 =?utf-8?B?b1JkejVMZEV1T25PdkU2VU5QdEh4U1YrY3AwRXZoZExRQ3NUM2hhR3IwK1F0?=
 =?utf-8?B?dnFhYzVOaElacDROSEVDRmpDSXVVcFpNTThSTk9nS3Y1QkFQb3RTNENiSmxr?=
 =?utf-8?B?bFBFalVQNjVJU3V3RXNkTkhCSE10SGlMQjBCVnBFTmw4bmFHQXFtRnRNRFJX?=
 =?utf-8?B?SlBGaTNOQ3JnV01TTldCYTAxWENsZEREcHVFZGh6TUZYbHRyc1I0WVRFc21k?=
 =?utf-8?B?OU1qWEYzRnRWYTNEUHlTd0l1L2x1SlU0U2w1MytOeWlteUNmMDZJTmg3c0JQ?=
 =?utf-8?B?ZmE4QktLYjJFR2Z2T1d4dmVXR2grdElTSDkrdnBxOEJPUlh3U2hNWm1QZXhu?=
 =?utf-8?B?em12ME80YWtWcG9MNFhjQ2lyU3VQUUVnUk5iaThpUExjMWM3WU5RUmdtQUVI?=
 =?utf-8?B?VHNPZktyYXBMeWwyTUkwVGdiVUs4UU5oVDArdGZhaGdEYTdDYThPdHp1NDl6?=
 =?utf-8?B?ZEFmVDdKVThVdmRhSVZlS2RoelFqZXpKRlJZUWU3dHRMUDZYUjR4VzNxellw?=
 =?utf-8?B?NlRhbENYcC9iTlNOZDY2N1M4bmpxV2VTaVNkdm5hQSthQktKUlpwSG9xUVpv?=
 =?utf-8?B?TjRrMDUxNFg2NlFibUNramdvVzZKV3hVWVdNc0JwUEhaQXdRbDh6RUVzU25h?=
 =?utf-8?B?RDRkczN2eHVJOHV0THVsNnp3Njh2TDI2ZVNnZTJTOWFFdjdOL2lTYXNwT2gx?=
 =?utf-8?B?OEhIenZmdEVZcHpQQytMWmlYZm5idmNsMVpqVVp5TSt2RXJwQnpwQzFvOEZQ?=
 =?utf-8?B?Z1BjQWNIcm5pT1NYVkJlSkVwZDRHeUZMTDVxWEJRUHd2VVdTWE52WjRGK2d4?=
 =?utf-8?Q?HjxACQ8WkdFFB2TVZ+VaYZlo/I1XAs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjU1dW1EK3NZWFAxRWhaSnl2U1ZXbE5FWFZNV25sNTdWUDlNRk4zTlhMeDNM?=
 =?utf-8?B?eHM4RmZwMmR5V0xpQlQrYVJCV2QwWkhET3puUXNyem5pNmFHOWxBT1lXQWli?=
 =?utf-8?B?VnhCTXZOMlZsakl2ZTNYa0xvcWNHVUVVN0taRzdQd0lrbVc3K2w3Q1ZwTENE?=
 =?utf-8?B?U1pvL0NIR0tacWxGQVZMUldrdUxqcjJwUHNPUmpvLzFob05vWGpPb05lZXh1?=
 =?utf-8?B?ZUx6TWM1Rk00L1Rxb2NQazJCdVd2QS9HVnRrbUM3UHR3VkgwWkNCd2swQlpV?=
 =?utf-8?B?eVkvZlBwVHdoc2NQNlhWQ2hPVXI5ZW9Yb0c4Wjd2VjJaZ2xSTVRhaVp0YVcw?=
 =?utf-8?B?V3c5Vm0wVXZQUDBZZDE1TSsvcWJUUWpGd29Gc2xPMWRYWDRsWjZQVjJrWFZw?=
 =?utf-8?B?T2RlQ05RY01YSG9kbVN2VWt1QUhieFA2bG9zSGQ5L21HcE9LaVlvTUhBRE5j?=
 =?utf-8?B?SlhRS3VyWkxmZzdiVFA2aytLMHZQTStKV1ZpQXpTMUdwNEJldEdnc2wrSVVy?=
 =?utf-8?B?YUJ1aEM2Y01LcGdNUWVWS0Nab0RDZzgyTmFocjFkMjNJemFBS3VIclI1UzU3?=
 =?utf-8?B?UlFNK1ZlcVlzSmRtUmFzNWNXRTMxODdOOTN3ZnNrTHhMVHl4OTRWWFdqRWVu?=
 =?utf-8?B?Tm9WRzBzNkl0clJWSzkzdlNNaFpQdDVhbVRyN2ZIM00rb0lubTMxRVVsNDlD?=
 =?utf-8?B?RWZmaTJ6b0hlN1VSV2xOMll1K3pZeDJ6V09QR2ROcU1LUkhkK3VhV0l4YkZV?=
 =?utf-8?B?U3owL0hJS3RBTkc3aTRhb1Z6UmhranhlWFZBcWxiZVhGUDhHVlA4UFB6NTc0?=
 =?utf-8?B?Q2RqMkJ2d3dlbUNIZzFtb05nVTQzQnczS29JdWlNNG9wTTF6V0x5L2ZLYVVx?=
 =?utf-8?B?bmFpNXEyUlpEZzdsT2R1d1o2YWRFMXVnZXhGYUMrWElQVnZEb3pBeTkwbjdM?=
 =?utf-8?B?aXlzR0M2dHBMQUw2b21XcFJVWDQvdkF2V0NCeWJ0THYrQ3c4ZHZNQkh0UFBk?=
 =?utf-8?B?Z3BFZ1IvWlY3bExYSys1bktHazVTWDZKYzZHRmRqVk41N09FVEMrRFNsaXM4?=
 =?utf-8?B?KzA4RjdzVUpPTy9jZXdlL2M2S2hnUEhTTFhHMzhteTN6V2pUVnAzTzBaVDgr?=
 =?utf-8?B?S2xTRC94QTNucmR3RHkvWkVmaFFDMzBQTmhqb0t1dFZkbmdrdGxWYlRHVlR0?=
 =?utf-8?B?SVhJNTVwWGU4TDR2ZldRYWhiZVpFV091TFVubHZoRi9tTlYyZWJWMlA1T0FS?=
 =?utf-8?B?NjlvYmJXREkyWCtKTEoyUzRiZFA4bkk0UlppL3JFMGhFbmxKdmo4ejd5N0w4?=
 =?utf-8?B?V1piZ2FzN3BwR1crWU1JbXdmMmd2QVoyb1RybU4xSkE3OExHY21HSXpCNDBp?=
 =?utf-8?B?VzYyNTA4UlVhODB2U3UxSmNWS1F0WkFqcTY2UHpRWVJkc2VPSFY3aDVXVDc3?=
 =?utf-8?B?Yzd4NEg5c3F3a0NEaVVoeFZuTHhxUWtWblRJYWVrTm0rT0VUdnJsMG9JaFJw?=
 =?utf-8?B?SEJmVTZlcUo1TzdMem9CRStxZXJSUThaZkhVcWRkUnBGZ2hPUW4vd0NGN2dv?=
 =?utf-8?B?WkNHT3BwQkRYS0lTVEhYalhuRXdRR0JNZzh4WXFVZ04vWTNBcllZQ2kyZmR2?=
 =?utf-8?B?MWcyNWoxWDRqUThWTXRET2ttTDR0Rmk2dEYyVGlNeTBpZHc0RXFKYlQ1RUlG?=
 =?utf-8?B?Y0liOE9DSnVlUWV5MG9KMytQNEd0WmxtbG9TMWhDd3VuTlhzYmF2WDBtZEhQ?=
 =?utf-8?B?dkFJb01acm5kKzA3Mm1aTERrSmZtMk5VOG80YndkQVc4SU9tNkhGNGpyZ0Mr?=
 =?utf-8?B?SXJFd09yb0QzQThNbnhXWU45V0UwRUlqanlhR1R3c2U5MThuR3d0VTZHdXcr?=
 =?utf-8?B?allPK2RKMFJPaURwRWJxUlFFbXFsYjVyUjJHbi9YeEoxaW1Pa2FhalVGeFJs?=
 =?utf-8?B?R3NvM1dNWDR3TE8wbGlQUWVYdVY1eGNTd3RPUWZzVTRDRHQ4OFVvVnZGQVZK?=
 =?utf-8?B?VFJ0YlVnYXdlcUlaY2R6RjJZMkRMcXo4NHAvekpDSEdybk10RDdLQjdMMnB5?=
 =?utf-8?B?ejA3a2FXVG9WMHpyOGhRM2ZXaFlIemw0TVovSTRuVTNYOVFOdGRmV2ppY0dX?=
 =?utf-8?Q?59Jo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2DF3BA29B0E444A8986BEBE3E96F3F9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 792c758f-4794-44af-3122-08ddb3fb01cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 15:14:40.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJZDadbDXRQrHLKM5HtQi6uX+RDu+QDkRMtRemEa9D2XH0pTe6r1pVh2NvRcwPxeZpXSFP6muovGsFBA8aT8qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

T24gNi8yNS8yNSAxMDoxMCBBTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAyNSwgMjAyNSBhdCAwMzowMjoxOFBNICswMDAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6
DQo+PiBPbiA2LzI1LzI1IDk6NDEgQU0sIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPj4+IE9u
IDYvMjUvMjUgOTozMSBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4+Pj4gT24gMjUtSnVuLTI1
IDQ6MDkgUE0sIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPj4+Pj4gT24gNi8yNS8yNSA0OjA5
IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPj4+Pj4+IE9uIDI0LUp1bi0yNSAxMDoyMiBQTSwg
TWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+Pj4+IE9rLCBzbyBzcGVj
aWZpY2FsbHkgdGhlIGdwaW9kX3NldF9kZWJvdW5jZSgpIGNhbGwgd2l0aCA1MCBtcw0KPj4+PiBk
b25lIGJ5IGdwaW9fa2V5cy5jIGlzIHRoZSBwcm9ibGVtIEkgZ3Vlc3M/DQo+Pj4NCj4+PiBZZXAu
DQo+Pj4NCj4+Pj4gU28gYW1kX2dwaW9fc2V0X2RlYm91bmNlKCkgZG9lcyBhY2NlcHQgdGhlIDUw
IG1zIGRlYm91bmNlDQo+Pj4+IHBhc3NlZCB0byBpdCBieSBncGlvX2tleXMuYyBhcyBhIHZhbGlk
IHZhbHVlIGFuZCB0aGVuIHNldHRpbmcNCj4+Pj4gdGhhdCBicmVha3MgdGhlIHdha2UgZnJvbSBz
dXNwZW5kPw0KPj4+DQo+Pj4gVGhhdCdzIHJpZ2h0Lg0KPiANCj4+Pj4+IEFsc28gY29tcGFyaW5n
IHRoZSBHUElPIHJlZ2lzdGVyIGluIFdpbmRvd3MgKHdoZXJlIHRoaW5ncyB3b3JrKQ0KPj4+Pj4g
V2luZG93cyBuZXZlciBwcm9ncmFtcyBhIGRlYm91bmNlLg0KPj4+Pg0KPj4+PiBTbyBtYXliZSB0
aGUgd2luZG93cyBBQ1BJMDAxMSBkcml2ZXIgYWx3YXlzIHVzZXMgYSBzb2Z0d2FyZS0NCj4+Pj4g
ZGVib3VuY2UgZm9yIHRoZSBidXR0b25zPyBXaW5kb3dzIG5vdCBkZWJvdW5jaW5nIHRoZSBtZWNo
YW5pY2FsDQo+Pj4+IHN3aXRjaGVzIGF0IGFsbCBzZWVtcyB1bmxpa2VseS4NCj4+Pj4NCj4+Pj4g
SSB0aGluayB0aGUgYmVzdCB3YXkgdG8gZml4IHRoaXMgbWlnaHQgYmUgdG8gYWRkIGEgbm8taHct
ZGVib3VuY2UNCj4+Pj4gZmxhZyB0byB0aGUgZGF0YSBwYXNzZWQgZnJvbSBzb2NfYnV0dG9uX2Fy
cmF5LmMgdG8gZ3Bpb19rZXlzLmMNCj4+Pj4gYW5kIGhhdmUgZ3Bpb19rZXlzLmMgbm90IGNhbGwg
Z3Bpb2Rfc2V0X2RlYm91bmNlKCnCoCB3aGVuIHRoZQ0KPj4+PiBuby1ody1kZWJvdW5jZSBmbGFn
IGlzIHNldC4NCj4+Pj4NCj4+Pj4gSSd2ZSBjaGVja2VkIGFuZCBib3RoIG9uIEJheSBUcmFpbCBh
bmQgQ2hlcnJ5IFRyYWlsIGRldmljZXMNCj4+Pj4gd2hlcmUgc29jX2J1dHRvbl9hcnJheSBpcyB1
c2VkIGEgbG90IGh3LWRlYm91bmNpbmcgaXMgYWxyZWFkeQ0KPj4+PiB1bnVzZWQuIHBpbmN0cmwt
YmF5dHJhaWwuYyBkb2VzIG5vdCBhY2NlcHQgNTAgbXMgYXMgYSB2YWxpZA0KPj4+PiB2YWx1ZSBh
bmQgcGluY3RybC1jaGVycnl2aWV3LmMgZG9lcyBub3Qgc3VwcG9ydCBodyBkZWJvdW5jZQ0KPj4+
PiBhdCBhbGwuDQo+Pj4NCj4+PiBUaGF0IHNvdW5kcyBhIGxpa2UgYSBnZW5lcmFsbHkgZ29vZCBk
aXJlY3Rpb24gdG8gbWUuDQo+IA0KPiBUaGlua2luZyBhIGJpdCBtb3JlIG9mIHRoaXMsIHBlcmhh
cHMgdGhlIEhXIGRlYm91bmNlIHN1cHBvcnQgZmxhZyBzaG91bGQgYmUNCj4gcGVyLUdQSU8tZGVz
Y3JpcHRvciB0aGluZ3kuIEluIHN1Y2ggY2FzZXMgd2UgZG9uJ3QgbmVlZCB0byBkaXN0aW5ndWlz
aCB0aGUNCj4gcGxhdGZvcm1zLCB0aGUgR1BJTyBBQ1BJIGxpYiBtYXkgc2ltcGx5IHNldCB0aGF0
IGZsYWcgYmFzZWQgb24gMCByZWFkIGZyb20NCj4gdGhlIEFDUEkgdGFibGVzLiBJdCB3aWxsIGFs
c28gZ2l2ZSBhIGNsdWUgdG8gYW55IGRyaXZlciB0aGF0IHVzZXMgR1BJT3MNCj4gKG5vdCBvbmx5
IGdwaW8ta2V5cykuDQo+IA0KDQpCdXQgMCBkb2Vzbid0IG1lYW4gaGFyZHdhcmUgZGVib3VuY2Ug
c3VwcG9ydCBpcyB0aGVyZSwgMCBtZWFucyB0aGF0IA0KaGFyZHdhcmUgZGVib3VuY2UgaXMgbm90
IHJlcXVpcmVkIHRvIGJlIHByb2dyYW1tZWQgZm9yIHRoaXMgR1BJTy4NCg0KVGhhdCBpcyAtIGlm
IGFub3RoZXIgc3lzdGVtIGhhZCBhIG5vbi16ZXJvIHZhbHVlIGluIHRoZSBHcGlvSW50IGVudHJ5
IEkgDQp3b3VsZCBleHBlY3QgdGhpcyB0byBiZSB0cmFuc2xhdGVkIGludG8gdGhlIEdQSU8gcmVn
aXN0ZXIuDQo=

