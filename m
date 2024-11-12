Return-Path: <linux-acpi+bounces-9505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C99C6270
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D121F2303D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33888219E2F;
	Tue, 12 Nov 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TwXP5pbG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5E219CB2;
	Tue, 12 Nov 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442814; cv=fail; b=HD8fypAtD0A155lCuoJZgTk0TOufvTJb+G5Tk0t7dxMrkr9mBqwDMWbi//ShAwCnTx0pB9ANpQEeAr96GLKh75Cy4XEaHPh2Mxo9BIvI4qke/zeHCoWyP1IePpQyd7D/SbldW2z3ydZ6uOSfHQpWNbYYrYtWZLghj+nYUfF23mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442814; c=relaxed/simple;
	bh=Wekvs8RrmLzaLGWSqizGERyNywtRpiIjHv3idWhmiU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1hnoalrlUfOgpD08Fatr10IQBCgxEoe6k0cLAZwyZ8iI8qXtSU1vZRHQSrlW+EGW0bFdE94WyyWog4r85Bko+/UbfW31n2fViGnoCqK5ju+NscUK5xJhB4g0aV72UryJebHUCNPVqqGFp30hwZ5ioYRRoRSFRT0HaAesQJt5aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TwXP5pbG; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS/LpyIJN9Obl1UbIk7Zj+wqba6mUwuiS2q1arfoLMcUdADa2Fq27/xF2yQhz11omFK5L+cUsX5Kf9MzGWXs5nfNcWJKzfX4MjGFoZkJ2x71gkeoW8pMj9KCCn0Q4AaEd/mUeMC7BWXK/63fZ38H/HzBzev6mWwqDywBbkTbqObIts8ZYPwAq7oWDwschjdnszuUahNVY/2Rd0KLdE8n2t9BiD0wJf2RuIr2gcfO/w0D9uYw7Fd/7mczyFaPgVHHrZ68+I3LTFbnPnZRLtJhs3cudI7XJ0S3AiEt7prAdeRQNMQUryaxvhvcRq+sBPDF7RuWEV1AWjGeCHiiCAFp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwsD+rYU7CH6IMQn9bazgQv+1XcRk2jx+ktcByD7P+o=;
 b=Ya+/htUD6iONSMbNzaQedwheW45eGjvqpbA0NHQUuqafGo26YaZlo4eeZD4l94xHuo/V0TMW7Hmwh4kc6ywoE4UmeCPiIeJu2SiLNkbHmWsAQtZ7FzkVlW2/Zou58EzOcsC1voVNtD1SdR5jMNzEavdGDRgwhNbZyWnv/YspsC0G1GfdryhYAJOlU/Sze4oAPBPTuo0hGrVptvvDaXjOSp+5Thx8bC6s99MCB6nQVznfvEziIqHPfcvyNGL/tuNCvYqGyKucmHg4/NpdcqNhT6bkSQbLLT/q9XjcVxo74iujN7OzgSO0ZgJWq5IQmU9Dx2KYUwiwBXBuFR2s+x0g/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwsD+rYU7CH6IMQn9bazgQv+1XcRk2jx+ktcByD7P+o=;
 b=TwXP5pbGozK3exndSMOl7UPBzUDF7T1T8qZK4bgbTpQWi9ayMXi4UnaTOH+P00XESdTi2fJTjutFQWhRUfc9q0yr3dKAHRGyB4y5VQ7wi1za9ojkT5E+U5RIOQ7k1MBOr3pfut0X8KLebsVTTvoqoPuhCfWTxeLZTVHX49S+Tk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 20:20:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 20:20:09 +0000
Message-ID: <411286d5-83c2-471f-a723-6a00aee3cc89@amd.com>
Date: Tue, 12 Nov 2024 14:20:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] Add support for binding ACPI platform profile to
 multiple drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <CAJZ5v0gaNKKbf29WD5keQxJdgP93P_iWiQMwp7cOL9NCUumeZA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gaNKKbf29WD5keQxJdgP93P_iWiQMwp7cOL9NCUumeZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd74b93-a929-48a1-b1f9-08dd03576778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enFuWWh5ZnNHMGxzQU43dUNZa3l4cms0MUQySndUUlRHZC96SEtsTDVubGVl?=
 =?utf-8?B?Y0ROSk1JZjRubzUzcDUyWHRkV3VFejgrSEdDdWdaL1NpZGxzUEkrNzhLdnJw?=
 =?utf-8?B?Ty9EcTNNRElsNXNUQ3orUXVPbHN1RFdBeitGWDZyVTBKd3d5aFBIbTYwTjVF?=
 =?utf-8?B?L080b0hxZ1dMTmlpL2U5UUFkUXFvRjF6K0dCYkd1R08xTFhzTklOMkFVbUV5?=
 =?utf-8?B?Uzd2OTIwZ1E3NzlkeWxIT3ZRa0hIK0lUY3dxZDFjMUZodGJwUU1KSkh3cE9M?=
 =?utf-8?B?cnptMnFaekFnZjFMN1g4eVVaWTI5QitVNnVyOXVPWS9CSDZmbFlhQVc0NzFE?=
 =?utf-8?B?WTBVZ01uQVpBQzhta1h1aWtwVDRmYWdBVnFqVzQ3cFRyMUFxQm95dFlIR01D?=
 =?utf-8?B?cE82Y0wvazhDME5TQUtrK2xKenhXanRObTE1cmZKZHd1K0dZaHdUbzBia3Nt?=
 =?utf-8?B?OTZsS0RBUjgyaHZDbE5hZTdsbXAyWUwxaHZIV3g4anlMK2ZsZGsvQWE4dHhZ?=
 =?utf-8?B?WjBPa05mblEvTEVXRkt4d0RWcWprNEVUNTNTMDhGQjZrVTBkN0pNY0pQVVNH?=
 =?utf-8?B?R21DYVZtaUtVbWNDVFQwT2UxZ0I5RTBtRTNjMzFkQll3ck1ibUZISkJhWmZB?=
 =?utf-8?B?ME1CN0x6d2V5aWJPQkMvRFFmVGRORys3Rk5oeENJRkUxNVVuYm9FeDZUcWJa?=
 =?utf-8?B?QWJxakR5bkNTdGFNeDBiNXc4Q2ZvZTNHejZacDF2bXNRS0hDU0hEbFpXejhr?=
 =?utf-8?B?ZTNSeG52UjFQcXpxVXcyN0p0U3ZXS2FiT0VqTzNQRW1YM3FENldlcVpubGVL?=
 =?utf-8?B?clFoOEMxUWxteUgrNDN2cmxFTGprdnpXeW5WZFYvdktaakNUN0lmS0dNUUZW?=
 =?utf-8?B?YmI0dFhMa24rZVU1bGJTU3JWY3UzVWxPa0x5UVR1Q2w2aC9qTVVTVlQ5cnZ2?=
 =?utf-8?B?NTcyVkxHeEpEcmtSdUY2ZGl4WDBvd2M2UmdERCtDT25WS1lneUlNQm1UZ3Na?=
 =?utf-8?B?a3hIdzJnTkFYQ1dnN2dwalBGNGw5c21rSmhmd1gyZzdXVFU1blF1VTY5c2Jn?=
 =?utf-8?B?NjV6N3VFcmFTb3dPM1FPNVZGZ0RLenlzV0YyU0NIQ2VZT3FRaTlYSEhTWWY5?=
 =?utf-8?B?RVZHcGI1MnpTaU5URmtYNUlyTjVLVEI0N3ZNdU9aSTBZVmFjeTByWDdKSXYy?=
 =?utf-8?B?OVhmWkZ2bDJwbkxDVjNpMERBVldrcklxRlhxRlJKOHdtWUJibm4vNU9OV1Rr?=
 =?utf-8?B?OGZCVzRsRnhhQm8xcEhPNmJXT29IWEx4TDNzNk13YVdlOHJmQkVtWXBrZzRy?=
 =?utf-8?B?ZVVBRGFtNTgxdHBQOVZpNXU2NUxXaGcrWW43UFM3K293ZmVXOTdZQjFvSG1i?=
 =?utf-8?B?UWZKYmljNy9VdTdlSWV3SEpVcXRoU1BFbVdsaEx1YVF0NXJNVG93UE1oOTNV?=
 =?utf-8?B?OU9nTVU5R21ROWdUSkN6cTlMTUZtTTRuY0k1NTA2RncvSW5TS2NWZWk2QWh3?=
 =?utf-8?B?ZnpiZ2d2VHMzdjF5a016bjl2VHFPaWVqakVGekFhSk1uTDA3emZxZnlTQmNN?=
 =?utf-8?B?bFNldWNBcXhwYmo5ckZkR0FUVWNsSkVOZjltOGoyZlM0VDlIdE16OWh1USt4?=
 =?utf-8?B?VFNZMjlrT2V6VDRuTjBFU0g2cFVqSlB2VTIzMWlHOTgzN0padkh2Q0thQ2sv?=
 =?utf-8?B?SHliczREUjExYS9hLzdoRVpJV1VNWE5PQkpuOVRzTHJhb0pjR1MvcTJpNElm?=
 =?utf-8?Q?lCPG9DvVZsT/aCuQU2U034GRjRYKtoBdDRFg6ag?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzhKYm1ZcENkUFBtRXc5akhQRng5UUhSekpjY09LZTdwc2JjUHNiK1d4bzVS?=
 =?utf-8?B?TjM0WUhiYXpsUUF1cVdRVEVoR1hVN2ZNRjFGKy96QXpxWkZRSis5NUltL0V3?=
 =?utf-8?B?enZ0cWlLMFNwS0lzWmU3RGVBdEF1alB0a0JzOXppeDNyaFVDQVBtZmNZMElU?=
 =?utf-8?B?SWxoMnV4QVl3dDh1OUtwRkpadUlHS0swdldpTVZ3d2owSmEvNjM2a3JMRENV?=
 =?utf-8?B?UkpjWER5TXV3VzhQYmYxdkJ1QXJvTHQyMEVEQy94TlhaaGMwb1dnTWRBK3pv?=
 =?utf-8?B?eEpkd3JzaHQ5bVlhaEQxS3lRZFh6TXNONitrWlpHc0RtVUw2OUJnMUplT3Q2?=
 =?utf-8?B?R2tpcDNEazgwVmNxajFmZlB6RU5mY21vNW1DUXJydzYvQUNQQ0xweFMvSG9t?=
 =?utf-8?B?UXJDVFUrMXd5Ym5SeHZQRUtwd3FQUW9pbWNNNzNYdWlQbXQwL0ZOeDFPNytx?=
 =?utf-8?B?aGdmVnRaRTdCVk5pSlNnOGdxTVpKc2dMRGpMZmFZdXNSNXhxdkgreUZ5UDFU?=
 =?utf-8?B?VU1tNFh4MGhQRnMzRHhlK0kyeFVIZmtiSllBbEI0TWFpMkVqYjJLMmJrNWRD?=
 =?utf-8?B?dmdlV2xGV3ZGSC8xOUdGMnR3Slo3QmRTZ3hCTUJMSXRPaExmOHcvVENlbUVq?=
 =?utf-8?B?NnNMMklDTGdFVmpuT0oyejJMakRJb3dCZUl4UDVkeklPVFBMOFlZWndpYkxP?=
 =?utf-8?B?Sks4ZW9jVjFMQ3pLOG11d3dud0pTMnhDdXZjVEtwQ0xDZ2dnU0hQV1RwSi83?=
 =?utf-8?B?YVA1Y01XNFFuY000VlZVZENYZGVhRXVBSGJZRnVweUhyNkxwQVRIaU9MRyt3?=
 =?utf-8?B?YW1vWUJYM1UxcllyREF4QWJ2Y09zVUtYcVk5ODZFTXd5b0E4dVVOYy8wa285?=
 =?utf-8?B?UFNOcUpkSThHcTlKK1pQUzJkM0pEZyttanlCUHBkZEVVRTFySjZGOHcxZlRy?=
 =?utf-8?B?ZFgxRnVkVEN6UEZMTGExamdpK2c0NXFZQnN2cmw5M0NoY3ZhSWFJUWZLTVdS?=
 =?utf-8?B?V3poemRnY2F1eG1vWjh5SHUvTnNNTU1ISmc4a1BVeU9lZEQxYzU1VFpFYWhw?=
 =?utf-8?B?Q0ZZYUFaOEphR3VMTXd1Y2NsS1NGQ3NmYlk0N1FCaDRkM1pHajB1cm5xcGtn?=
 =?utf-8?B?Y1B0dG5QMlI2UExPcFBlY0pCRW5JVC91SjhKdm1scDNBWktDclQ1eWp0OVVM?=
 =?utf-8?B?WDRRTWtxU3VybXlkUWpJdDFvMVZkS3cwcnkzVGJpb3U2WmErRVh1NzFaem5v?=
 =?utf-8?B?SGVKc2dJZ2tqYndDRHVrZHBEd2RBVGpUMzVtK0Y4ejBsY1lOZGtmVGhaL21q?=
 =?utf-8?B?bW5QY2FLOXc1eGgxTTIzdm1QRHFRazBheHZjWUpseFFpSUhHVU9CLy95L0hW?=
 =?utf-8?B?SnlSZGtCeEFZOFoyWWRWRThCWWxJZ1EreVdoMHdqazlWeVlrVWNuYTB5OXpH?=
 =?utf-8?B?eHMxeGlMK1pxa1lVQjJqNkRaTkErS2ExelJmK01XcHRjMU5ZUHRMVXRXRWlM?=
 =?utf-8?B?K1RKVGJaZEdySHB5TFN6Zno5NEQrUXl3QitPSDc3Q0dGa0h3elhVeDBnU21S?=
 =?utf-8?B?ZGpXYnhsS0t2NUNPWGp4NDVTdWFvUEtpNTFrdUZ6SjZHa1A2VTRkUjBFN3U2?=
 =?utf-8?B?VjdmcWhsTmR4RHEzOUpFNFc4UVZsZHJyRS9zZExvcVZUeVRDdU5XQ2tFSTM0?=
 =?utf-8?B?ZTJGSkkrbkNKTjZLYjVwcHMreXY1SFF4OVpBdkQvNkFwalVEaFRiUW5seWxo?=
 =?utf-8?B?bmRRL3A2Y3Jjc0FDaHQwUFRYSjdnUCtYM3BRaXkvbFNnOUszTFdpalZFMWFX?=
 =?utf-8?B?aHlhRTZRckFhZUVKYXNvZTl3MEI5Rmx4cDB3Z1dobU5xTmNjVUlQSndiVGp5?=
 =?utf-8?B?OXFQZCtacXovamhzMlhXaVhsZFVNZEVLZ3RxVEhHaSsxaXMydnBZd3dwWC96?=
 =?utf-8?B?UmtKWW1yRnFqUnhWNmpQSEh4MzJiOVF4QWdtUmJSNDhxa1BLZTVMYUNzRVFJ?=
 =?utf-8?B?Tmp3TXNvVnV2R3dzbVNmeDVURzV6aHRhWnhiVngrMnV0V0JNY2NqS0dDbkFT?=
 =?utf-8?B?d0hWd3d4WjVtWVZhb1B2dkJhMHNqTzY3VzVsZ0JwSXlHMFFoTytPcFZzc3JF?=
 =?utf-8?Q?6hTewSp7vuXPWVAxSPK+8zNsF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd74b93-a929-48a1-b1f9-08dd03576778
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:20:09.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH3TiBt+6g/AIiRhFEUuFDRwL0vuBM5i7e0GE1UOHjX2+aNZCq2r/IFXqyngpf5yFn/h1Enla235ad12RkMZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

On 11/12/2024 14:16, Rafael J. Wysocki wrote:
> On Sat, Nov 9, 2024 at 5:42 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently there are a number of ASUS products on the market that happen to
>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
>> profile provided by asus-wmi.
>>
>> The ACPI platform profile support created by amd-pmf on these ASUS
>> products is "Function 9" which is specifically for "BIOS or EC
>> notification" of power slider position. This feature is actively used
>> by some designs such as Framework 13 and Framework 16.
>>
>> On these ASUS designs we keep on quirking more and more of them to turn
>> off this notification so that asus-wmi can bind.
>>
>> This however isn't how Windows works.  "Multiple" things are notified for
>> the power slider position. This series adjusts Linux to behave similarly.
>>
>> Multiple drivers can now register an ACPI platform profile and will react
>> to set requests.
>>
>> To avoid chaos, only positions that are common to both drivers are
>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>> is used.
>>
>> This series also adds a new concept of a "custom" profile.  This allows
>> userspace to discover that there are multiple driver handlers that are
>> configured differently.
>>
>> This series also allows dropping all of the PMF quirks from amd-pmf.
>>
>> ---
>> v6:
>>   * Add patch dev patch but don't make mandatory
> 
> Probably a typo?

Ah whoops, yes.

> 
> Which patch is it, BTW?

Patch 3.

> 
> In any case, if the merge window for 6.13 starts on the upcoming
> weekend, which is likely to happen AFAICS, I'll defer applying this
> series until 6.13-rc1 is out.
> 
> It's larger and it's been changing too often recently for me to catch
> up and I'll be much more comfortable if it spends some time in
> linux-next before going into the mainline (and not during a merge
> window for that matter).
> 

I'm thankful; Armin ended up having a lot of very valuable feedback.

Yeah, it makes sense to defer to next cycle.

Would you prefer me to rebase and resend as v7 after the merge window or 
will you just add it to a TODO?

>>   * See other patches changelogs for individualized changes
>>
>> Mario Limonciello (22):
>>    ACPI: platform-profile: Add a name member to handlers
>>    platform/x86/dell: dell-pc: Create platform device
>>    ACPI: platform_profile: Add device pointer into platform profile
>>      handler
>>    ACPI: platform_profile: Add platform handler argument to
>>      platform_profile_remove()
>>    ACPI: platform_profile: Pass the profile handler into
>>      platform_profile_notify()
>>    ACPI: platform_profile: Move sanity check out of the mutex
>>    ACPI: platform_profile: Move matching string for new profile out of
>>      mutex
>>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>>    ACPI: platform_profile: Use `scoped_cond_guard`
>>    ACPI: platform_profile: Create class for ACPI platform profile
>>    ACPI: platform_profile: Add name attribute to class interface
>>    ACPI: platform_profile: Add choices attribute for class interface
>>    ACPI: platform_profile: Add profile attribute for class interface
>>    ACPI: platform_profile: Notify change events on register and
>>      unregister
>>    ACPI: platform_profile: Only show profiles common for all handlers
>>    ACPI: platform_profile: Add concept of a "custom" profile
>>    ACPI: platform_profile: Make sure all profile handlers agree on
>>      profile
>>    ACPI: platform_profile: Check all profile handler to calculate next
>>    ACPI: platform_profile: Notify class device from
>>      platform_profile_notify()
>>    ACPI: platform_profile: Allow multiple handlers
>>    platform/x86/amd: pmf: Drop all quirks
>>    Documentation: Add documentation about class interface for platform
>>      profiles
>>
>>   .../ABI/testing/sysfs-platform_profile        |   5 +
>>   .../userspace-api/sysfs-platform_profile.rst  |  28 +
>>   drivers/acpi/platform_profile.c               | 537 ++++++++++++++----
>>   .../surface/surface_platform_profile.c        |   8 +-
>>   drivers/platform/x86/acer-wmi.c               |  12 +-
>>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>>   drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>>   drivers/platform/x86/asus-wmi.c               |  10 +-
>>   drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>>   drivers/platform/x86/dell/dell-pc.c           |  36 +-
>>   drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>>   drivers/platform/x86/ideapad-laptop.c         |   6 +-
>>   .../platform/x86/inspur_platform_profile.c    |   7 +-
>>   drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>>   include/linux/platform_profile.h              |   9 +-
>>   18 files changed, 553 insertions(+), 213 deletions(-)
>>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>
>>
>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>> --
>> 2.43.0
>>


