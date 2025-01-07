Return-Path: <linux-acpi+bounces-10406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBEA04527
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFFE1887A0C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B519E806;
	Tue,  7 Jan 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hfG29Wb8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E22594AB;
	Tue,  7 Jan 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265087; cv=fail; b=Wt1n+sojK92ySE9gwEP0YhtbWk/YwkLw0n4iL66UbHjamDvMqWsWydONt6OVAvPouK/WkxdRwmVMToqD9bfGAzp/nzeMAcN81BNGtw/9x9z2X/dk7JHtfBfsMHaxsjwrfKBYh5tIVxM5PE7HFh63PN0bwbKS+LwVGmsgZC49bm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265087; c=relaxed/simple;
	bh=W4DQcHfRfQ56I7RlLdco769sL6H6kgH9I08F9yi1NN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pc1sTLI2CpJJq31chDQ68qkJr8v8eq42IZXkylems4Gzhko3ikR814hTHKL5J4lwLbli/KxdhPWoptmnppsCWd/cieYW3SM3YMewECCE+CFMNp3+YaJObQNiNC9RNM5V9bLhEgAdQPbeuh5XKueJYr6AC6aIrvixbZ5xEWX2Ar8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hfG29Wb8; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNwfe3OE2mZx4bL1naUQdXGK1iRhlnkb3/qqIiNLXnxq0LSmT9a15gN7qslYBi/Rzq8ZviLGM6smCmtnzZe7B9DuqwwuNZ5z0gjqqcw1Qt2j5mQC6PnHzuk8gPs1c2bvanUwDw9lKaEsfIcWFAnVN57n54lRYByhlEL2vqnTOzcTzb5JXfNAZ14DNNf582pdcUbHNJoGO6Om9rTumqGPfspuek83DImqq9oiBO3+JTe72wRfC3GQN5ccP5HaduxXNqFtj32uVKD6I3U9o0LhPvVGJDMbWXk0IiW2TkBAaWxFgkjZUEfncWDKoOtJwFUb9YLu8qcDiBHKrseU+jBfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyM2rmUuT9Vz5pq2aPDNY8oSRyB3uKdKBjmsikjA5Zw=;
 b=K93A5ZBFkMD3sNpJg3AId6W6ZbzuuNbrlqDQjao62WeZHAfNPQMRntZ8BIrXJ+TJMRs5Lh+aA6vB8uys8oWTNtFkgtbO7FA6WdYWUi1sOIbFMqEosuv1coq9HTe5irlbXEkRIf3q1pRx4WpDCggGXaMwoUfJkHLaNt0xHeazwaU0FpaVlOZHnsRr1EA2bCd9+xgp2Cg35BMzV0YxwmMBnA64e65evM82Y7OhmVSWK4vWx3wllrMPBK7Rx9HXiynsla8Ys2rcpOlXRdC0a1Bb4XSqA7AUSh3Q7hNAgKdlB14IdmNoTVAzmcRS7MNsY4f2y2ETGwSj7MbC6u33B9c/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyM2rmUuT9Vz5pq2aPDNY8oSRyB3uKdKBjmsikjA5Zw=;
 b=hfG29Wb8U4P2a2vFU2RyXztEa5h7nFAdglObIABedkoMyZQXl7Fnm48776JeMCNstnjrHDq5EOymVMTnRpWbJZ31LJjgURitzNVWWf1kRSpeNsiEtI/Ofi2yerqNii6IH86YjqAaMpaxS2n8di93Wrx1oEpCEas1k6OXt6GpQKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:51:21 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 15:51:21 +0000
Message-ID: <2e71a4a9-6ec6-4ac7-8640-d80dcdfd7776@amd.com>
Date: Tue, 7 Jan 2025 09:51:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically
 refresh choices
To: Hridesh MG <hridesh699@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Kurt Borja <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 josh@joshuagrisham.com, "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Armin Wolf <W_Armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250106044605.12494-1-kuurtb@gmail.com>
 <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
 <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CALiyAonc81o1FreDaWiik3XaqKYVf=wYHX+vaE2_1w66LhJTnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0171.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::26) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8809ef7b-702d-4dd5-ea60-08dd2f3321b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0trUys3NFNkK2ViaUlBS2J3UlVacVRMSWROVUdMQkZ4eXVoSlY4UlRzdVRw?=
 =?utf-8?B?YkowMmVyOU5xWWFudGRrd1JOMCtyRnBOaG5GRlFpdkJyZ0kvcHN5VkFtOEgr?=
 =?utf-8?B?TGQyKzRheis5OHFDR0FBL1RIY3c4Q2lzUC9KT1Ywc1RHcjZta3dRUXF5dTNL?=
 =?utf-8?B?YmU5MURsaXo5cnJod3NNNWw5QlUxbHRTeVFDeUtJd1ZIdVZOeDkzZXpud3VZ?=
 =?utf-8?B?SFlWN0xsY21pYzVqOXBURWxELzhidERXME5SY3Nza0hKd3pwbG1WRzNsU2VS?=
 =?utf-8?B?RzJ0dHlYdzF6V3dnR2l4TEIzOUlndHZOTFVSdzlrcWhkS0d0ZVZSV3JsMWdy?=
 =?utf-8?B?NS9JM0poQVhTOG5VRU1pVTFpc3VPZXMzbDU1Mmd0NXBFVGNhditOOEhTM0I3?=
 =?utf-8?B?UmpUenVpekpHbDNiUXROeGowb2xsMit6Y1FmQk9WVkdpWjdDLzlLOHEzK3ha?=
 =?utf-8?B?TW11Q0hWVVlsRHUveGRqZFFlRmYvUmxXSEVMb29Sd3F6Vk90ZnZVeFdxZEgw?=
 =?utf-8?B?V29TUk00dVlwbHM3bW9XSFhPSHNxNkRaNUM0U2E3ajk4Q2hJTElsZkpVQ0Nr?=
 =?utf-8?B?MEM4bUNNcVcwYmM3NTVTZ3dzTm9xS3lWZ3pmaUdWQm0wQ3VhbWJRZWRPZ3I4?=
 =?utf-8?B?RERMNm81SXJKZCs1OUoyY0tKN2NUUVJWNEtaTlBvY1BRTm5pdGpob0ozSmds?=
 =?utf-8?B?YXNBbTZZZHBkOXdTL3ZlM1grYSs1T0dCQWtKQ3dqMWxPOWdXak9PU2dieGxC?=
 =?utf-8?B?ZjBHQUlLak5sUWt1MHRHR0UxdUIvRE1WeDlzOTFvZDZmYWY0dXJzdVBZeEF0?=
 =?utf-8?B?T1lYRXVKSnlXa1owL0p2NmxjOHRkZVY4a0xyek02UlFoQ0V2VUdFbDgwb0E5?=
 =?utf-8?B?UEhnR0VsREI1R0luclFaZDRUZUdIY0o4dUhxc3ZCeitMekIyOTdQVUp0bnEw?=
 =?utf-8?B?cW9vUWJGQTNRbUt2RWlEdW9FRkZCZkZVWkdtY1JJQW9qMXRDUEtkTUIrQUdL?=
 =?utf-8?B?azlsL2R4UFRvcmZoMmt5U2l5cmx5SVVOSjBFbE5NUndzdVhtR1ZEQU9CUDFE?=
 =?utf-8?B?OXRHc25UYkR0RnhWWkV3ZkQ3OSt5V2ZPVzdTZ2JzSkt6REVpVU10M3ptNzdT?=
 =?utf-8?B?eGNUZkl6M2pGWnVvQlF2MktLaTNOODJQRm1pQkFaT2IySy80R2RSUDRxdkxu?=
 =?utf-8?B?QllQQk1xN1I1OW4wRWFsbDRORkkvY29sU1d2TWJrYllXSlF1WFB6VXhmRjdT?=
 =?utf-8?B?V1JOdW9KTWtMVjhRNGkyMWlZSnVRRUxob3IvOU40SzRXN1Y5c3J2NXFBRGpo?=
 =?utf-8?B?ODRtVzU5QVkvR1NaOW5SU1VwMkF4d2g0L3Zqazl0WFhha1VRcEFndHhtb0N1?=
 =?utf-8?B?QkFvVE1iMWREcmhOUW53cERIMDNYREc5eEt5OFBmdzhISy9Ob1BFbHZRSlVI?=
 =?utf-8?B?c3NFWkZ3REhseTh4K0U3RklBd1lOa29FNXRicWpNOWE5QTBCREVZencrM0Fq?=
 =?utf-8?B?NzQwMDU3am84MEQvcXRJeE4vVUtFNC9VWUl0WXhJN1RvTFVvelBPQ2dmWDRz?=
 =?utf-8?B?L1hUYXkzbW8xRkdFTVdZaWFNUnJBdlV1R3VJK2c2UVdVQzVNR0pkeXpsSzdY?=
 =?utf-8?B?eUVwaUZ0QlNSTWlOcFdoNDJqbWhWWWJWR2pnSllMRGV1U3U5K1htWTRycmF5?=
 =?utf-8?B?bmtGMnh6TE5BVStBNmdKUkpWbmtYeXM1TW4wU3d0RkpoM3h1TDNJeWFtcUk3?=
 =?utf-8?B?YVc2WWR2dXFOZkZLZnRCdTVVQmlMWGtzWktNSWkvb3BWSGsyRkJHazNlbUp4?=
 =?utf-8?B?dlJKNU13ZWd6VmlLVVhNa2VKU0RCNXdkS3grOUtNYzV0b2JlaFkyNlV3eXlY?=
 =?utf-8?Q?WE7F7cwJFuiRb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdWWFpDNlpZbmpONlFoakJBdFVsMk5XWndHdjA1VzM1Nm1Tdmk5Wm5HUHV1?=
 =?utf-8?B?UkM5dDk5V1FkM0ExZlhlZmRPbHJWZEdVRkMyTXphaXh4bjg0V2FXVlRzVnNV?=
 =?utf-8?B?Vk5lUUFOME96VnRWK1JQeldMNUFjdXhObjZVeGlyenh0aEI4LzA2T1I1RkRn?=
 =?utf-8?B?c01HSHR5aGNOK0hIdStXdmI3aFZvZ0xhVC9LUS9rUUZER1F4ZHdRTWJlcmdK?=
 =?utf-8?B?dmxDMk8vQk1GeEtSaC9zV0hSZmlQeGp6d2hCanhKT3gxajNrcEFsSWxtVVRo?=
 =?utf-8?B?dDNkV1hETWExakFCRHNKY3hOam5JZUJJOUVmSXJxS250a25wRVBCa3FRSjlL?=
 =?utf-8?B?ejkzVXlGeS9xTURwbGJPdEdOYWpnTkZHSFJkOEdFUWFlcGhXdHRrbWpla3NV?=
 =?utf-8?B?dHNOWkNFQzV5QlpTMjZObVUwRnRLUUN3cU9zVDJUYVU4cXduR0FXTWl0dzl2?=
 =?utf-8?B?S2VqcDEwNks1b1N6dzJrMC9pNStNakFnTWFyeGhHaFlHblBzOTdBVWwrL0ZM?=
 =?utf-8?B?TmQ4WisrcGViblk2Tms0dkRzZFBaaW5oWlEzREpLMHgyWXVEOUszZkNpU0pH?=
 =?utf-8?B?MFRjWitINkdKbkk0dFg5alk0NEFkSEJDRXBNL3grbncvNU1INGt6QW0rTVpl?=
 =?utf-8?B?WDdBQS9IUnRtYU5xYUh3K0RHRHZ6R3o1MzdycVF0U2dmWncvUEE0V25oVzdj?=
 =?utf-8?B?S1ZPYUtXdDNLY1pjL2dDTmsyN29PeUpNWXZlaFg5Q1Z5L1ZTMGdxa1pqTXB4?=
 =?utf-8?B?Z2V5N0FCVE9Fd0RUQ2dnT0s3UjM1QlZHblJSNG1CQUxGN2ZBSEpyeFcyTGdG?=
 =?utf-8?B?aHcvVWhnbVRKNUdKYlp5YTAyVnQrSVdHSnZzNmZjd1pYZ3JaKytMUlVsS1pr?=
 =?utf-8?B?L3Q0UXkvdFAxQkpXQXUxNEJqNk5sTFpmbmNYU1pUd1k3K0lOUHQydnU0alJG?=
 =?utf-8?B?dzYvK2cvaHdWdkZ5MkVaQkVhaERkcC9EY3RORlV6aFU4cHdINEZzY3djTnVP?=
 =?utf-8?B?TjZjOXV0UFIwUWpFVFd0b1dIZDcyTVZPMnd4dXRHZHVCY3VzdkhJaXdCWlUy?=
 =?utf-8?B?dTByUkFzS3NTd1dBSVo1UVFNdzlzOC9CK2VjUVFRQThqSmEwc0daNEhxU3M1?=
 =?utf-8?B?NHFPZmI4bGlDblZqYjZwNEFzSHpVTHdSTExvUG81ZytjZXVTYmtITWl0RnF6?=
 =?utf-8?B?QWhtS1BsT0pyVTJNZG1NeU5kRE1lZGk5UmllSXhlSE9KR0dmbDVvdFdHMklx?=
 =?utf-8?B?TW5pTFhYVys5U3N3SzFqcURQMkVEL05IUGRsM0RGd0c5SHF2OVhoSVBPVGlk?=
 =?utf-8?B?KzlkM0tNdlpLVzMwMWsrR0NucTd6cnlRYitEOXJCcFE1Vm9LT3NXeGJVTE9U?=
 =?utf-8?B?d3l2TlpjcFpiVkhKZDdSU0hQNE9HMWpEcEFtOXlyWXRsbitFQi9ubFZyMEdi?=
 =?utf-8?B?ckZORnY2OEtocjlGSlZhT3Q1TTBWRGZQVE9zUGlsV1g5TjVJSE9aU1hKa2pJ?=
 =?utf-8?B?d2QwVzE3UVpnUTlRUDlTQ3lWTG5mMEFuaEtBaHRHYmM1M09PdXdhNUxLNmRj?=
 =?utf-8?B?N0JIenE4Rm5kd1JOajZxV2pzcnU3dHZlb242Mk5VYUNwVSt5WG9zaXc5dnJJ?=
 =?utf-8?B?VG9WdDdXWXlMWWNRMUhmWmh3dDJ3b2Z4dUswU3N5cXNTQVZDbTZBRjB4NmFr?=
 =?utf-8?B?U3djZlAyazV1MDM0VFZoWlVjZWMyOERtR0psdlE4cXoyUzVqcFk2bGcwV0x5?=
 =?utf-8?B?Mk8vc3pnTlhRYlVJT2FjNGJneUJCVmREZ1JUWmdqcXRsaFpkb2hGd2paYVMr?=
 =?utf-8?B?dGwyUTJGTEhLQlFZaUZuaFpmS2h6UmlrcmdUZ29nS1EwaWVDcDN6TC9ncUEz?=
 =?utf-8?B?WFVoNGRFaHprdERZcmZzaFRRTXBHcWdyWGFjWHpGZTNKLzN3aTRiNUplbk9x?=
 =?utf-8?B?RHNoSmUxOVhTUm1rMy9VcEpuTVIxbWs1NUJ6VVNiTXl4OFZORTBERkZaVDNF?=
 =?utf-8?B?UE9tVlFIQk5pK2JBRUNFODRzc1FQUWVHeWs4SUI2RDJUZkFpZ3V5MTFQQTg5?=
 =?utf-8?B?WTl6cXJadG1HQ3BvVm1ETTJaVHVDL3lEczBlaS9PanBVMm9LdFdQcHRmTDVD?=
 =?utf-8?Q?83sftodcoiUuh9XVGBHnTIa2S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8809ef7b-702d-4dd5-ea60-08dd2f3321b4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:51:21.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCd1Gck+G1kp7pkkZTGOMTp2t7fD9+nz7D7zQYpKHiWZPWGhwKuB0snSEVUOZyKHKhkKuGRGQcH7thRCmbflig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

On 1/7/2025 07:14, Hridesh MG wrote:
> On Tue, Jan 7, 2025 at 7:49 AM Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>>
>> Hi Kurt,
>>
>> On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
>>> Hello,
>>>
>>> Some drivers may need to dynamically modify their selected `choices`.
>>> Such is the case of the acer-wmi driver, which implemented their own
>>> profile cycling method, because users expect different profiles to be
>>> available whether the laptop is on AC or not [1].
>>>
>>> These series would allow acer-wmi to simplify this custom cycling method
>>> to use platform_profile_cycle(), as it's already being proposed in these
>>> series [2]; without changing expected behaviors, by refreshing their
>>> selected choices on AC connect/disconnect events, which would also solve
>>> this discussion [3].
>>>
>>> Additionally, I think the platform_profile_ops approach would enable us
>>> to hide the platform_profile_handler in the future, and instead just pass
>>> the class device to get/set methods like the HWMON subsystem does.
>>>
>>> I think having this kind of flexibility is valuable. Let me know what you
>>> think!
>>>
>>
>> I personally would love to see how this would be used for the acer issue highlighted to see how it would work out. It feels like the series is short a patch :)
> 
> I do think that having this flexibility would be good, as i was
> considering manually clearing the set bits and calling platform_notify
> for the acer series, but in my specific case (for devices using the
> predator v4 interface) it was found that the hardware was responsive
> to all profiles regardless of AC/battery mode so it made sense to
> leave this kind of artificial limiting of profiles to the
> userspace--similar to how the Windows driver handles it through the
> Nitro Sense app.
> 
> I feel like users should have the power to utilize their hardware in
> the way they want it to, though if there is a compelling reason to
> limit the profiles then i'd be more than happy to add this to the
> series :)
> 
> 
> --
> Hridesh MG

I agree with Mark, this series is missing the patch that shows exactly 
how this would be used.  Furthermore; what exactly are the differences 
in choices between AC or DC?

To "userspace" I fail to understand how "balanced" is different from AC 
to DC for example.

If an implementation has differences for AC vs DC would it make more 
sense to have that abstraction in the "profile handlers" instead of the ops?

IE always have "low-power, balanced, performance" for choices. If the 
system is on AC the profile handler might do something different than on 
DC for a given state.

Another idea I had while thinking about this is that the platform 
profile core can have a sysfs file to indicate whether or not to "allow" 
power state sensitive values.

It could default to "1" and then it can send AC/DC events to the 
platform profile handlers when enabled.  If userspace prefers not to use 
it, then they can set it to 0 and then the profile handler would stop 
reacting.

