Return-Path: <linux-acpi+bounces-9059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD19B3B2E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 21:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FA7282F48
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3F1DF98C;
	Mon, 28 Oct 2024 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OI82OWfC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2A18EFC9;
	Mon, 28 Oct 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146554; cv=fail; b=O1pgh9A5QA3+uRzQd5Cb5Lq2yoGMu+PL6oUT58iN5aHzS2i1JkExnYvLTlSVbLyB7EfFNZxC8GhvBccm5qAqWAs4gF32H9ZghKDupdEmxf2YkCoWIgmCZmd5qgfJ5fEXFhIZXkRc2TRuq6gNjU4OE8pOHKx8kSSjMdOIpRKHbVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146554; c=relaxed/simple;
	bh=Y2dJtJyEiWWedERGVa+77fHJNrDEmqUFYmRjZIbQAK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=glYQ23z2UBaehTOklOgJsKn6ywkxE+ZV14PN09Xm8B7UuA+I9Os58Zl7He+Uy9hObFlEjEzyMwf1y3KEpGzGNuQYLS/ozzK6bu4G0GcKjeRkqX/3NLqytVQ9qI9YVH4f456Wshltv8oa+/Ysv9ogDLdMAjg6WYy/l6e7tAyyG3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OI82OWfC; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5DcqTK5cWC6lVIjWZa6f76ZzlYNeZKwLiEfaO7E6bb1a0kYFFV2nkjJcpa+Ad/eiigKW5mR1mzRX9F2bMs6YsrFE+Y1xwDs9sXVlBVphtTyYsTQQ6XKhfdL1IDSLas+eGQN+X++CFXKls/TqwgtgVnfIlFeTY16Y0WksoxqVQFRYlmfc7mNeW3j04ANr1ocbTEEK+Co4U47ZRspsnVC1PKKwsDRYNCWOMT8T6RiAJpclpjEAET50CuZOtYRqLDRyKX7TF6Uke30dY3BT6czZVc7MjYBLYrqYRRqffc5JD/MPIm/Y9jTs+rsr9SwsYX22RfB4JLGMAWYlGzt9iPOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJwwulMC5xLNSbgor6FrttCauWkljZ4kEuz4puVfxFQ=;
 b=b420Y1WsVs5bp2ogkA3q7U0UttE0GdCCNjGSonEYiGqaX+GP9YsrbZgRHMBYDzPgSDHLJIMULf+P/OJ83D92zLed4yYuDOnB++XbwCA3elTNWNVUG/bHlJ5FG9HRv86QTh7OeEO7c8Z5ZjMp9YBWtp6ZRFPYvblWC7Q6PvqEGC7bQXyYffJA9CIy4Gv3OsuufCEV5kyeeWaCJ7t6GFg4E3SXKflkoHKf/AyrgQeKyxZlOvEjDO3IGbghYXw+jUAvZ3lk6Hf57ZiKWG1RWRUHaRDvGxd4c/5tjnHQEuqK7hnT89lggE0SoJi4jZL7T+ekA8Vq61OsNi8YdHN6FqUcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJwwulMC5xLNSbgor6FrttCauWkljZ4kEuz4puVfxFQ=;
 b=OI82OWfCsuvFVskPX7yNYCHQtwXFCs8wBJXJr2oyjj7h++nga1/feiJDq8nlg9VakU5F9RpmmQdURtw4VYdh8qlV4z2oIPI+Dlr7Uqg96lkndnCHKWiPWZn1mwr/fFnYG+6XGaTIm/GX5I0Ck8sRSg4nHli7MpA45HLP8r+LRqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 20:15:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 20:15:43 +0000
Message-ID: <cc03714e-9b29-4d3b-93d9-a5aaf1e10f61@amd.com>
Date: Mon, 28 Oct 2024 15:15:41 -0500
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
 <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
 <93160eab-8b19-4b21-8539-85cf1c2a2dce@app.fastmail.com>
 <d1debdce-5c86-4005-9ca1-29e646694942@amd.com>
 <0e92dd4d-007c-4a73-9ad5-f869520b1373@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0e92dd4d-007c-4a73-9ad5-f869520b1373@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: e41af6dc-2324-4571-44a4-08dcf78d4d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDg1Y1ZTUm9VbzB4MnM4cUUxTUczRS9ZQlhnRUtRS0lnMXlXOHptWHFORnBW?=
 =?utf-8?B?Zk5TRE5lSldkd0xRT2VObTIvQU1ZVDVhRjNmNUdDTmdHZ2R6MlRVMSs2SmZG?=
 =?utf-8?B?ZG5GMjNEZkhRV1BPYXcrbm81TlhLZ200YVpXbi9mTmF1UkJUTHB1L01IMXhI?=
 =?utf-8?B?U3lyQmNDS3dVOWQyM1huTytHeG91RkhYM2hnVzBFeGl3QS9JU1YxYXpEMzYx?=
 =?utf-8?B?YlVSc3g1Ty9RYkd2dlpjSXNnWEdVQXhkczFVZVRxdDB4aUMrMEQya1ZmWVk5?=
 =?utf-8?B?YmFEeGM2REVvUjFFT0pkRUNQMHlyWUVwT1p1Uy95T3FvaE9PanJwc3RKYVYv?=
 =?utf-8?B?bHh3Nk1kWDFldWl3eEM1ME5sSDlBcStHeVZRSkJWTUtWdUxDRy8zdnZqNmVy?=
 =?utf-8?B?d09jTUVYc2FKQVFpMWYrVnp6WmRZcHFUdUIyYlhqaTlidnhBcFZlVkNVT09w?=
 =?utf-8?B?OGF6SlFxdFJKUTJadzdhMnN6QkJjUDFjMDlQZjF1TkE4K2pwMHZ5ekdDUTBn?=
 =?utf-8?B?YmdoZFlvazgyMEl1dERaWkNIYmc5UDYwVlpham1BTGFQWEpiWldmMGVPWlRv?=
 =?utf-8?B?V3dhcW5jY2U3RS8wU3oxN3AzU0RuWll2dXllcy93UGFVNzJ4emhORUkrWnhp?=
 =?utf-8?B?aEg0Wnl5RlNMcW84ZHFoWVJwSGRMZjFqQlprYU51WWZPSEltOUkrRDZRaTdk?=
 =?utf-8?B?N3JIWVpNV0VldUNzNDF2TUdpQkhFakloOEEyMklQVTRDTG9iREtRTi9WRmNI?=
 =?utf-8?B?UkFuMGpNc09YUkpQQ3AzZHA1TDFlNVpDM3ByV0RrQVFtOVB1Mlk0M0diakJW?=
 =?utf-8?B?VFIwNWJ4VVhxRUNaRXBpTzIxbHNZRVhSLzJaMkt4ZGpFTE55eFdHdHhPVkZM?=
 =?utf-8?B?emFQUkhsa3RjWlUyNWNrbXZIeUlQT2NtM29hcU5FQnpYSkNUbmp6WXNqb3I1?=
 =?utf-8?B?aDdBN0ZXdko3TGVpZEN3aFluMVV0dXJlUUZuRXZpMDB6bmZxNjZpZS96UUFS?=
 =?utf-8?B?WW0vdEJ2QnZhU2dnQUlZUGtYdDh3c053bCt2RlUyZUtLbUZvRnJoZjN5b1Ez?=
 =?utf-8?B?RnpIU0ZzWlhQL1dWM0VQYjFHYUlxWktrWFF2ODRPWVNucHhwQVFyNTZUQUpy?=
 =?utf-8?B?MlNZVTcxNFduZjZubzlER1RZMEFIcDBmVFcxU0NNbGRmMVFVa2ZsL2Z2MnMy?=
 =?utf-8?B?ZDlSaFBkQm1qUEZOYkREOUVQT2RYZHlyOUgwdThpbkJtYXQxMUUrR3VLa2Na?=
 =?utf-8?B?WHYvaW9EaE80eENXNmp2NmdKSkMweTVuNFI1UHdZVlNkVDY3QUJ2YUNXTmpF?=
 =?utf-8?B?ZjVFZkdadWtOMmNRazRpYXd6QXZwQTE0eVlPS04xOHladjBoR1ZaMU1pQmFS?=
 =?utf-8?B?TWdMOUpLMkdZSjFFUEt3SlNXSGR0Z21QSWlObjN0Y0plOTh6TVVnV0FnTEFU?=
 =?utf-8?B?Y29WNjJORXNIZkNXc2pSSTlTWDRjNjVwS0dmWm0zeW1jZFBDSWpuaGdINkhi?=
 =?utf-8?B?cy9kK3FQUXRTdXBldllDREpvc1ZIbnZFaUNnTkRQc1ZuVmdwUmZyTm5UU204?=
 =?utf-8?B?SW1xRnA1ZUtQQy9maU10TjVmcjluem1USEVjTjFKOWZmWTR1WWM4K1YrcVll?=
 =?utf-8?B?Zngxc3pQM1YvMDhaTVpNcytRK3NMdlR2UlRqY20yZmd6UmxDeFVpTSt0N0Fu?=
 =?utf-8?B?TnFSUkJJU3J1amFvTEppaHB3VEczYVlqVTJCN0FDVlB0MlphS0RvYm9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtIeFdpbkRrcVNma2JxL3FBUHdST1RvSmdNMFBuN0NVNEZKaFZWbFF5aHhO?=
 =?utf-8?B?S0l3bWdOb296ejV5dXk2R0VENFZNeUxXYjVZZGsxd3Z0RkQ5UVRpRTNYVVRw?=
 =?utf-8?B?bzlHelhIL3JTcm9ITHBpUCsyaTBNQVUzaFFUbXVQUjE1U29zcmM3eGM4Mnpt?=
 =?utf-8?B?R3Z3Q1MzdXV6MDhqSXdKejQrbm12Ni9xSHhIc3BCY3MzWHNKOTNTTTdwdEdM?=
 =?utf-8?B?cUo0alpaQk0wRm1aL1pZS3ZabkJvSzRlTHRUekhjMDdsQy9oOGtGSDVhbzEx?=
 =?utf-8?B?dUdxQmYwaS9ZREF4Tmg4MU1uTzZPNFJyMEZhSnBUTG1KMmw0SkNvTXNmNEFP?=
 =?utf-8?B?WTVpZkdGRXlnRUFDdXNvVmd3anZxYjUvRjNDd1hLd3p6U0ZyNzY3c044VktJ?=
 =?utf-8?B?eVk4TEU3bGtCYjZJWUlFa1hYckFpdTVMcldZQjgzcWJ5S3B1VDhJaEJxYk1a?=
 =?utf-8?B?cmVRUVR0Ly9IcXlBejd3NWFNUDFXemRkeXJ0VzhPaGdaWjlpcnVCaG9Fck45?=
 =?utf-8?B?Rm5RUm03UU5GS2N3MHZNMG5aSW9jVkJMOW9uQ0w0dXZnV3J5MFVIZTBsSks2?=
 =?utf-8?B?VWJBajhONEZiR040a3JURnlxVHlKZ0RQc1gyMDdRL2FpbGo4Smc5VHB3UXFh?=
 =?utf-8?B?Z2k2VEdpMkJFOU9MMDMvU09zQ1hwb3RGT29XdC91emRBTjMwazNhUHB1cWNu?=
 =?utf-8?B?OTJQNFJNYk01aVRTWjNmc2R1TFhhZFBtVSsyRC9FeUFNSy96R3FwbEJJVytW?=
 =?utf-8?B?M0g4di90V0xpdVAyMjVTRE5OQVNTRFZkYUtVSDNRckQwc3NzdUFxREtPNXVG?=
 =?utf-8?B?NFBzZnJBbUlOSkZsQ3BuL1NDaGpMaFN5ZTJVYVdDcWlMVlFFWGhYekZLWWdQ?=
 =?utf-8?B?L29TNzhSMGhQaGYzR0M1d1VQMHF3dHoxM1ZpSDV6dmpVTEE1b2Znb0ZVUFJq?=
 =?utf-8?B?endsYjkvcVp4YUtjQ2FCamJ3SDVOdEZ5ZGdsWW5sVkR0d2wvK3owWFpJTXk4?=
 =?utf-8?B?TWx4RFdFWnRJekp2Z0ZHbnNIVWhwOEdad0hBZmdaM1lWeVduWkRnWExRQ3da?=
 =?utf-8?B?c0lza01OajU5U24vN1J2TW5IRkdmczVVMjl2SklTWjF3WTk1WkdCaHYzT1cx?=
 =?utf-8?B?cStpSmFLT2NOaWpBWEt1RFdPU3JnNzgwTFNjK3FRK0VWY2xIb3FrY2ZRc2ZP?=
 =?utf-8?B?Yk1TdWRRdklwbDVHaktsWU5JeTVsVWpkaUFua2FURFA1MTAwYnJxT2F0RnRy?=
 =?utf-8?B?dEZrUUxSTUErbkZBeXFNMlBKaURPOTAxZExnSDhuTlp2b01PWDVUa3FXdEda?=
 =?utf-8?B?QW5oVmpXT0hTa0tVK25YSXRVbXBINkpwYXduNGo4OUNWRmt1aXFQejNRNkU0?=
 =?utf-8?B?QmFqWTBmUENUb0FJTEk3dG5WdkpiRkV0VXpDMmJTQjRwbWJXTTRjUFpaSG81?=
 =?utf-8?B?WTN4ZjNQM1VuQUVLekJOVTczOHlKdXNFSDR1UllhSlAvLzFWMzk4TWxjU0Ni?=
 =?utf-8?B?WCsyVVlGSnlTelNCTCtqcGhtMU9EWi9kNTJISERrc1ppNndLRkVVMFg4ckZU?=
 =?utf-8?B?L2pMLzJUSDNKZXdKcS9YVHNFRDJQQjFzOFRMWFB1OEFYa1dFN0JnRjlhS0NE?=
 =?utf-8?B?UG50RHRyM09oNWovRUJZaHl5RFcvMVJ4MlJLWkhCTCs0YWF5QXhQWmQrMzV5?=
 =?utf-8?B?RGY1NkhPd2JhUlNhekhZMzNLQ2pqRXZiRkZIbjh5UXFkNldsSzZZUjFtbWE2?=
 =?utf-8?B?YlBjUld6c005UFlwTUsvWHFwTjVGanNuS3VodkE2MXRTWWZuV0tSZEt3clpK?=
 =?utf-8?B?Yjl1YzlzNXdQOGc1L0RVUkJSTzBKcFhDSnpHYncyOU1ZYU5pNDhQSStsV01X?=
 =?utf-8?B?OG1uYVA0N0JKNzFzb3lGZjMvNEI3RnprMjQxZVZKUk1Sa2RZR21YWlllclA2?=
 =?utf-8?B?M3JKRlNhOERZdU12SU9KbHBWaStoZXl4RUF5RVlJbDRVakt0ZFNXKzVPcENO?=
 =?utf-8?B?TXZwYWNveXZBZmpMaUVXOU1RQ09lZHJ0aEN1aXhwSENYNjNZV3M4SFdHbDNH?=
 =?utf-8?B?aXlBQkRmK2JDdEJOVFdkSjdBOWFjMk40YXBlcllEQ3d2dml5ek9aTFViTStC?=
 =?utf-8?Q?MBCd+i8lLE8HrGn9IZP3Wc+y+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41af6dc-2324-4571-44a4-08dcf78d4d0e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:15:43.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1o7h2kGbdbk50nj5tqCZNtKBfWAC/BbnouEUH8ivY4eJH+OokpF2hKV1Ifcmbd7a0cZDKIU0B5SANR5SVIo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

On 10/28/2024 15:11, Mark Pearson wrote:
> 
> 
> On Mon, Oct 28, 2024, at 1:35 PM, Mario Limonciello wrote:
>> On 10/28/2024 12:20, Mark Pearson wrote:
>>> Thanks Mario,
>>>
>>> On Mon, Oct 28, 2024, at 10:10 AM, Mario Limonciello wrote:
>>>> On 10/28/2024 06:01, Mark Pearson wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
>>>>>> Multiple drivers may attempt to register platform profile handlers,
>>>>>> but only one may be registered and the behavior is non-deterministic
>>>>>> for which one wins.  It's mostly controlled by probing order.
>>>>>>
>>>>>> This can be problematic if one driver changes CPU settings and another
>>>>>> driver notifies the EC for changing fan curves.
>>>>>>
>>>>>> Modify the ACPI platform profile handler to let multiple drivers
>>>>>> register platform profile handlers and abstract this detail from userspace.
>>>>>>
>>>>>>    From userspace perspective the user will see profiles available across
>>>>>> both drivers.  However to avoid chaos only allow changing to profiles
>>>>>> that are common in both drivers.
>>>>>>
>>>>>> If any problems occur when changing profiles for any driver, then revert
>>>>>> back to the previous profile.
>>>>>>
>>>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>     drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
>>>>>>     1 file changed, 117 insertions(+), 86 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>>>>> index 091ca6941a925..915e3c49f0b5f 100644
>>>>>> --- a/drivers/acpi/platform_profile.c
>>>>>> +++ b/drivers/acpi/platform_profile.c
>>>>>> @@ -9,7 +9,6 @@
>>>>>>     #include <linux/platform_profile.h>
>>>>>>     #include <linux/sysfs.h>
>>>>>>
>>>>>> -static struct platform_profile_handler *cur_profile;
>>>>>>     static LIST_HEAD(platform_profile_handler_list);
>>>>>>     static DEFINE_MUTEX(profile_lock);
>>>>>>
>>>>>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct
>>>>>> device *dev,
>>>>>>     					struct device_attribute *attr,
>>>>>>     					char *buf)
>>>>>>     {
>>>>>> +	struct platform_profile_handler *handler;
>>>>>> +	unsigned long seen = 0;
>>>>>>     	int len = 0;
>>>>>> -	int err, i;
>>>>>> -
>>>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> -
>>>>>> -	if (!cur_profile) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -ENODEV;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
>>>>>> +				if (seen & BIT(i))
>>>>>> +					continue;
>>>>>> +				if (len == 0)
>>>>>> +					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>>>> +				else
>>>>>> +					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>>>> +				seen |= BIT(i);
>>>>>> +			}
>>>>>> +		}
>>>>>>     	}
>>>>>>
>>>>>> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
>>>>>> -		if (len == 0)
>>>>>> -			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>>>>> -		else
>>>>>> -			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>>>>> -	}
>>>>>>     	len += sysfs_emit_at(buf, len, "\n");
>>>>>> -	mutex_unlock(&profile_lock);
>>>>>>     	return len;
>>>>>>     }
>>>>>>
>>>>>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
>>>>>>     					char *buf)
>>>>>>     {
>>>>>>     	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>>>>>> +	struct platform_profile_handler *handler;
>>>>>>     	int err;
>>>>>>
>>>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>>
>>>>>> -	if (!cur_profile) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -ENODEV;
>>>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>>>> +		if (!platform_profile_is_registered())
>>>>>> +			return -ENODEV;
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +			err = handler->profile_get(handler, &profile);
>>>>>> +			if (err)
>>>>>> +				return err;
>>>>>> +		}
>>>>>>     	}
>>>>>>
>>>>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>>>>> -	mutex_unlock(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> -
>>>>>>     	/* Check that profile is valid index */
>>>>>>     	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>>>>>>     		return -EIO;
>>>>>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
>>>>>>     			    struct device_attribute *attr,
>>>>>>     			    const char *buf, size_t count)
>>>>>>     {
>>>>>> +	struct platform_profile_handler *handler;
>>>>>> +	enum platform_profile_option profile;
>>>>>>     	int err, i;
>>>>>>
>>>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> -
>>>>>> -	if (!cur_profile) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -ENODEV;
>>>>>> -	}
>>>>>> -
>>>>>>     	/* Scan for a matching profile */
>>>>>>     	i = sysfs_match_string(profile_names, buf);
>>>>>>     	if (i < 0) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>>
>>>>>> -	/* Check that platform supports this profile choice */
>>>>>> -	if (!test_bit(i, cur_profile->choices)) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -EOPNOTSUPP;
>>>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>>>> +		if (!platform_profile_is_registered())
>>>>>> +			return -ENODEV;
>>>>>> +
>>>>>> +		/* Check that all handlers support this profile choice */
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +			if (!test_bit(i, handler->choices))
>>>>>> +				return -EOPNOTSUPP;
>>>>>> +
>>>>>> +			/* save the profile so that it can be reverted if necessary */
>>>>>> +			err = handler->profile_get(handler, &profile);
>>>>>> +			if (err)
>>>>>> +				return err;
>>>>>> +		}
>>>>>> +
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +			err = handler->profile_set(handler, i);
>>>>>> +			if (err) {
>>>>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>>>>> +				break;
>>>>>> +			}
>>>>>> +		}
>>>>>> +		if (err) {
>>>>>> +			list_for_each_entry_continue_reverse(handler,
>>>>>> &platform_profile_handler_list, list) {
>>>>>> +				if (handler->profile_set(handler, profile))
>>>>>> +					pr_err("Failed to revert profile for handler %s\n",
>>>>>> handler->name);
>>>>>> +			}
>>>>>> +			return err;
>>>>>> +		}
>>>>>>     	}
>>>>>>
>>>>>> -	err = cur_profile->profile_set(cur_profile, i);
>>>>>> -	if (!err)
>>>>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>>> -
>>>>>> -	mutex_unlock(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>>>     	return count;
>>>>>>     }
>>>>>>
>>>>>> @@ -140,7 +148,8 @@ static const struct attribute_group
>>>>>> platform_profile_group = {
>>>>>>
>>>>>>     void platform_profile_notify(void)
>>>>>>     {
>>>>>> -	if (!cur_profile)
>>>>>> +	guard(mutex)(&profile_lock);
>>>>>> +	if (!platform_profile_is_registered())
>>>>>>     		return;
>>>>>>     	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>>>     }
>>>>>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>>>>>
>>>>>>     int platform_profile_cycle(void)
>>>>>>     {
>>>>>> +	struct platform_profile_handler *handler;
>>>>>>     	enum platform_profile_option profile;
>>>>>> -	enum platform_profile_option next;
>>>>>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>>>>> +	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>>>>>>     	int err;
>>>>>>
>>>>>> -	err = mutex_lock_interruptible(&profile_lock);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> -
>>>>>> -	if (!cur_profile) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -ENODEV;
>>>>>> -	}
>>>>>> -
>>>>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>>>>> -	if (err) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return err;
>>>>>> -	}
>>>>>> -
>>>>>> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
>>>>>> -				  profile + 1);
>>>>>> -
>>>>>> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
>>>>>> -		mutex_unlock(&profile_lock);
>>>>>> -		return -EINVAL;
>>>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>>>> +		/* first pass, make sure all handlers agree on the definition of
>>>>>> "next" profile */
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +
>>>>>> +			err = handler->profile_get(handler, &profile);
>>>>>> +			if (err)
>>>>>> +				return err;
>>>>>> +
>>>>>> +			if (next == PLATFORM_PROFILE_LAST)
>>>>>> +				next = find_next_bit_wrap(handler->choices,
>>>>>> +							  PLATFORM_PROFILE_LAST,
>>>>>> +							  profile + 1);
>>>>>> +			else
>>>>>> +				next2 = find_next_bit_wrap(handler->choices,
>>>>>> +							   PLATFORM_PROFILE_LAST,
>>>>>> +							   profile + 1);
>>>>>> +
>>>>>> +			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>>>>>> +				return -EINVAL;
>>>>>> +
>>>>>> +			if (next2 == PLATFORM_PROFILE_LAST)
>>>>>> +				continue;
>>>>>> +
>>>>>> +			if (next != next2) {
>>>>>> +				pr_warn("Next profile to cycle to is ambiguous between
>>>>>> platform_profile handlers\n");
>>>>>> +				return -EINVAL;
>>>>>> +			}
>>>>>> +			next = next2;
>>>>>> +		}
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * Second pass: apply "next" to each handler
>>>>>> +		 * If any failures occur unwind and revert all back to the original
>>>>>> profile
>>>>>> +		 */
>>>>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>>>> +			err = handler->profile_set(handler, next);
>>>>>> +			if (err) {
>>>>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>>>>> +				break;
>>>>>> +			}
>>>>>> +		}
>>>>>> +		if (err) {
>>>>>> +			list_for_each_entry_continue_reverse(handler,
>>>>>> &platform_profile_handler_list, list) {
>>>>>> +				err = handler->profile_set(handler, profile);
>>>>>> +				if (err)
>>>>>> +					pr_err("Failed to revert profile for handler %s\n",
>>>>>> handler->name);
>>>>>> +			}
>>>>>> +		}
>>>>>>     	}
>>>>>>
>>>>>> -	err = cur_profile->profile_set(cur_profile, next);
>>>>>> -	mutex_unlock(&profile_lock);
>>>>>> -
>>>>>> -	if (!err)
>>>>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>>>>
>>>>>> -	return err;
>>>>>> +	return 0;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>>>>
>>>>>> @@ -190,21 +224,19 @@ int platform_profile_register(struct
>>>>>> platform_profile_handler *pprof)
>>>>>>     	int err;
>>>>>>
>>>>>>     	guard(mutex)(&profile_lock);
>>>>>> -	/* We can only have one active profile */
>>>>>> -	if (cur_profile)
>>>>>> -		return -EEXIST;
>>>>>>
>>>>>>     	/* Sanity check the profile handler field are set */
>>>>>>     	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>>>>>     		!pprof->profile_set || !pprof->profile_get)
>>>>>>     		return -EINVAL;
>>>>>>
>>>>>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>>>> -	if (err)
>>>>>> -		return err;
>>>>>> +	if (!platform_profile_is_registered()) {
>>>>>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>>>>> +		if (err)
>>>>>> +			return err;
>>>>>> +	}
>>>>>>     	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>>>>>
>>>>>> -	cur_profile = pprof;
>>>>>>     	return 0;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(platform_profile_register);
>>>>>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct
>>>>>> platform_profile_handler *pprof)
>>>>>>
>>>>>>     	list_del(&pprof->list);
>>>>>>
>>>>>> -	cur_profile = NULL;
>>>>>>     	if (!platform_profile_is_registered())
>>>>>>     		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>>>>>
>>>>>> -- 
>>>>>> 2.43.0
>>>>>
>>>>> I'm still going thru the code changes - but I'm a bit unsure on the implementation itself.
>>>>
>>>> FYI, I split it up in v2 to make each chunk and intent behind it more
>>>> manageable to review instead of patch 7 being "so" big.
>>>>
>>>> V2 covers some of the points below as well based on some feedback from
>>>> Hans and Armin.
>>>>
>>>
>>> Ack - sorry for that, on PTO this week/last week and not checking email very often. Saw the v2 after I sent the comments on v1 (my inbox is a little bit out of control right now).
>>> I've just started looking thru that - let me know if better to move that conversation there
>>>
>>>>>
>>>>> I'd expect that one of the advantages of having different profile handlers register is that you could support extra & new profiles that might be wanted. For example the recent discussion of the AMD handler providing better tools to tweak advanced system settings for gaming etc. Won't this approach limit that? You'll only be able to have common settings.
>>>>
>>>> Well that RFC it turns out won't really be scalable because SPS is done
>>>> differently in AMD Strix and newer.  I haven't revisited it yet.
>>>>
>>>> But yes this approach would conceptually limit that idea because common
>>>> settings are all that is presented.
>>>>
>>>>>
>>>>> I find having a common profile and two different handlers a bit tricky on how to handle. My concern is it can easily lead to conflict in settings.
>>>>> If two handlers are doing different operations to provide the same effect - then neither handler is (probably) providing what they think is required. With your CPU vs EC example, the EC will often set CPU clock thresholds and the CPU profile handler will be changing that. If this is done I think it should be explicit to the user (admittedly I'm doing this with my Lenovo hat on - but we certify our platforms with our EC profile handler)
>>>>>
>>>>> I could see providing two separate handlers. e.g. balanced-A and balanced-B (for driver-A and driver-B) and the user maybe choosing which one they want (or both - though the user interface for that is definitely tricky)
>>>>> But choosing one option for two different drivers seems confusing and with unknown side-effects. I appreciate it's complicated by your example wanting to add CPU and EC - I know how much work you've been doing on the AMD CPU front which benefits all systems.
>>>>>
>>>>
>>>> Thinking through your comments I guess another way to approach this
>>>> would be "per-driver" sysfs knobs.  Here's my thought.
>>>>
>>>> 1) /sys/firmware/acpi/platform_profile_choices would contain only things
>>>> that are common and if there is something NOT common then also the
>>>> string "custom".
>>>>
>>>> 2) /sys/firmware/acpi/platform_profile would accept writes for
>>>> everything in platform profile choices except "custom".
>>>>
>>>> 3) Each driver handler would also export it's own sysfs files to
>>>> represent the driver state.
>>>>
>>>> 3) If the user changed the main knob at
>>>> /sys/firmware/acpi/platform_profile then it would change all driver
>>>> handlers.
>>>>
>>>> 4) If the user changed sysfs for any driver individually then the main
>>>> knob /sys/firmware/acpi/platform_profile would export "custom".
>>>
>>> I need to think about it a bit more - I still have some concerns about two drivers doing the same thing. In some cases they can complement each other nicely, but in other cases they will treat on each others toes.
>>>
>>> Just to throw another idea on the pile:
>>>
>>>    - If only one profile then it can have low-power, balanced, performance as currently
>>>    - If two or more profiles, belonging as an example to driverA and driverB, their profile names become balanced-driverA and balanced-driverB. You could choose specifically if you wanted to activate one of them by using the driver name
>>>    - Each driver would have a priority. I'm biased here, but a vendor platform driver would have priority 1, a CPU vendor driver priority 2, etc. This would be used to determine which driver version would be used for the cases where multiple options are present and user chooses, for example, just balanced. If two drivers of the same priority compete then first driver loaded wins.
>>>
>>> So as an example: if we have the case where we have thinkpad_acpi (priority 1) and amd (priority 2) profile drivers offering all three profiles then:
>>>
>>> /sys/blah/platform_profile_choices would offer:
>>> lower-power, balanced, performance, low-power-thinkpad_acpi, balanced-thinkpad_acpi, performance-thinkpad_acpi, low-power-amd, balanced-amd, performance-amd.
>>>
>>> If the user chooses balanced - it would activate the balanced-thinkpad_acpi profile as it has the higher priority.
>>> The user could then also activate balanced-amd separately if they choose. Multi balanced profiles are OK.
>>>
>>> Initially this would all be from command line, but I'm sure some nice user space GUI can be done to allow you to choose which profiles are available and active/in-active.
>>>
>>> Maybe also add an option under platform-profiles to have an "enable all matching profiles" to override the priority implementation? In this case choosing balanced would enable all balanced profiles available (in priority order?)
>>>
>>> Would that work for the ASUS case or not?
>>
>> At least for the ASUS case "today" I think "priority" could work, but
>> what happens if one day ASUS prefers to use amd-pmf instead of the
>> custom WMI stuff for some systems?  IMO you don't want to have it set in
>> stone for priorities.
>>
> At that point they can submit a patch to set their priority according to their needs...as it only impacts their machines that's totally their choice how they want to do it.
> But (see below notes), I think I withdraw the idea, it is unnecessarily messy.
> 
>> I do worry that generally though users won't know what they want if
>> there is a "balanced", "balanced-vendor" and "balanced-cpu".
>>
> 
> fair
> 
>> And I don't think we can use the same interface to select multiple at
>> once.  I think if we're to have multiple handlers exposed and allow
>> different options then it needs to be a class interface (or something
>> similar).
>>
> Yeah - saw the class proposal after sending this. That probably makes sense and is simpler.
> 
> Still not sure how that solve the problem with multiple drivers offering the same profile and treading on each other.
> 
> I've been through various arguments in my head and whilst I am selfishly concerned about causing issues and supporting users, I suspect the reality is it will work out just fine and I'm over-thinking it and the profiles will play nicely together.
> 

OK.  I'll work the class approach into the series.

> Can we have a module argument so we can set a preferred profile driver, for cases where things go wrong? e.g platform_profile.use_only=thinkpad-acpi (as an example).
> Just so if there are issues it's easy to debug if a particular profile handler is causing the problem. These changes are going to make debugging profile issues more complicated :)

The absolute easiest debugging method will just be to unload one driver 
or the other.  I think adding extra layer beyond that might be overkill 
(it's essentially modprobe.blacklist=driver for a feature of the driver).

But let's see how it looks when I get the class stuff done.

> 
>>>
>>>>
>>>> Hans what do you think?
>>>>
>>>
>>>>> Another concern - would this mean that another driver could limit the options available? For instance if someone wrote a new 'mega-turbo' only profile driver and it loaded - it would then mean no profiles were available for anything as no profiles matched?
>>>>
>>>> Yes.  I don't think it's a problem in practice right now (as we only
>>>> just recently have two drivers vying for this position), but it /could/
>>>> be something that happens.
>>>>
>>>
>>> I'd certainly like to leave the window open so that there could be, for instance, a 'gaming' profile option that does some high-performance mode with maybe power shifting towards the GPU and some other graphics only tuning things?
>>> I wouldn't like to shut down the ability to have options for things like that.
>>>
>>
>> It comes down to how much of a catch all this knob needs to be in the
>> kernel.  If you put too much into the single knob it doesn't become
>> useful anymore generically.
>>
>> At least for AMD APU + AMD dGPU designs there already exists a bias knob
>> that lets you control the power share.
>>
>> https://docs.kernel.org/gpu/amdgpu/driver-misc.html#gpu-smartshift-information
>>
>> Similarly you can manually adjust clocks and performance profiles for
>> GPU from standard files:
>>
>> https://docs.kernel.org/gpu/amdgpu/thermal.html#gpu-sysfs-power-state-interfaces
>>
>> So my gut says this idea of gaming mode should be stuck to userspace.
>> There is already such a project for that:
>>
>> https://github.com/FeralInteractive/gamemode
>>
> The gaming profile was just an example, but after more consideration, I think you're right that user space makes more sense for these cases, and similar others.
> 
> Mark


