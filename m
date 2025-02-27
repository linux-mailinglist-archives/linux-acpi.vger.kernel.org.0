Return-Path: <linux-acpi+bounces-11562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBDDA485B6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30CA188CF58
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AE1B85E4;
	Thu, 27 Feb 2025 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lULS459b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783C14EC5B;
	Thu, 27 Feb 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674768; cv=fail; b=QYicRdFCWr4PeHeru5ddkNqr91OwWZB3IrGdsxJYy3XRZ6ptaKZmjoor5p7z1uRTzdZ/s3jWfdxnYdj1uLMDLAtX4gi4WO+A955XuXjOW3zhgiT87IExelxODQT3+koYjtbE/MzcAyLIpZyLoAsw8a5E+o75rb1cIt0KxOWdoBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674768; c=relaxed/simple;
	bh=Yxm1E7Fe3bUqAmbL+HnoKIDkw48kQLImqYEAUXuEAQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqRQR6/WeOMM2CL9lS3Zq56gDmX+/DeVph3tLGc/p39pyhfRESYP+faAmsDvb2u4H68PJg8ONDZ00535Ew3YML49qJimiUnxJOpN7BfB5Eoj3YGujmSRnyYLuY7SRVX3UJAT0HSfkMwisb8+MkXMHiRNlbX3U2ubnsmuS5UGDSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lULS459b; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7htOEZo0Ykc/A4edPsd3RD/gagq815/02k5k2RL3ZG8HIw7LrnrFE01z3U+gyjeoUv0QkEeL0qnVtOBaDgz9tkZz0qvc2YXrATETAzXLxIdfT6F0x/ThGM+9LuLEHde1JExvIA7Q/9G6h6GI/4kIJ0718GIguEVZltuESxKugzYkU1Ygk4gfI+4aWIxnMHm+C66Lbti0Co/4OBJsF3CAFxHS0aHwaUdDKM+mEJh0CVWmfTIQxZeGeo9ECWpwcOqbPxy9xwxq49tvox2x91p2bkTmsZ3wSh8cRPPP+BcX9QJeAp2rOEUctkSL+z3lodcbvHERb77T7HQAEsh7dPrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrbGd9wASy5xcshY5/xww1q/SHCx930naLW61CkMNE8=;
 b=qO0tBJFxa5lR9B4Yds7R2V9Wf2JQvem2jVuWqEMDUi9n/dYYKNlerQAnjjq63T9T3Al08MjF9evoCEUrqDFAbi2uP+ASSrL1ClH93UgagbEqjhSMhJXl0vyiRzQAMfRUlUmLIwd5l8Eps02hSiR9fQho+e3lO/FM5t6zURqX8/Zf1RmT8//y31AXKB+HXREP6L5G7PMY1fITd5mR1My0VmtQyn7CPVqOeLNpWUHaRly4mrlFAp8/uBgal6NgQWzWjQwBlwYEQpFkUvW7gQ/XN5+QmemurPMasNHjcmCrXDdLUHyI2lkuz9DUWWg3gneMiCKHnp7/3rIYys7Q6EBh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrbGd9wASy5xcshY5/xww1q/SHCx930naLW61CkMNE8=;
 b=lULS459bQYNdCjWBU5237d1mTmy6RK3f5sUjE7mu4ZBfiQAphVKgBkvoFZvh4pQMCS5VbNTdFacn7XKMGULWnJ+Add0dnBHm85pOAW/3WFR0nSL9M1YwTbQjYTtCWAM1WaHepSsIrtXSuaQ58bRtcXG1lAZ5MD4tsOVKodl9p9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:45:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:45:59 +0000
Message-ID: <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
Date: Thu, 27 Feb 2025 10:45:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Antheas Kapenekakis <lkml@antheas.dev>, mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
 me@kylegospodneti.ch, luke@ljones.dev
References: <20250227153603.131046-1-lkml@antheas.dev>
 <20250227153603.131046-3-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250227153603.131046-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0004.namprd05.prod.outlook.com
 (2603:10b6:803:40::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 7784d4e1-8b78-4b12-e744-08dd574e3679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnZSanozczVybFQzdGRoU1hFQkN0eGhkNEJhYkY0Q3lvNzRVaUh4THFvMFFv?=
 =?utf-8?B?Tit6bHZJb091bkVVU1U5WXdxU1UvaFJpVVRmejZCNVhtNTFNUnFSaGdKQlRw?=
 =?utf-8?B?a3JscjBPNkUxSzc2VDBQSzF0Nmk1UGdFc1lOWjBCOEdnTXBzaTJsM2ZESFds?=
 =?utf-8?B?UFBOVG1tV25uUGRVSnZZcC8wZDRhak5iNzVLblRLVHVqQWFkbDZnSGg3a2ZL?=
 =?utf-8?B?UGVkVHdpRmNXeW56N2VTTGYvMXNkYVlhNlVUOHAyQnNDc3hFMlRPLzlza1Nj?=
 =?utf-8?B?UnJsN3c0Sk5yRzA2ZHpDTVJWaHRoTEpKQjNrME84K2hpbWpvSUx3YkI3eVJK?=
 =?utf-8?B?Nk1xTCtHSUxTOHQzOFhpbEhob0hyUUV5NWhSaHAvcFF0ZzEzVngwMU84Vlhh?=
 =?utf-8?B?K3V1d1Z2WUk3YkdpR1VjbktidmhQcEUrZ2swM2NWVDZ1Vms5WXBLTTNXbksy?=
 =?utf-8?B?R0xITlVoaHcxeXRCK2s2VmN3eThwc3JvNTdIcG9BT2h5cWtnNVluN20vVHZm?=
 =?utf-8?B?MWxncnltUHBFcmdIVjVoQUV0NG96YnJmeDY5NXZ6aWsrK20zMG9XVm1vbE5n?=
 =?utf-8?B?eFI5UFJ5VmMwZVp4OHBBNm1BdGlJa05YWk9KR2hURWkwNlJyN3lEMDNhWldQ?=
 =?utf-8?B?eDhsdjNMbUR5Mk8zcDg4WTg4cXBYdUxCbzJ4U0xkcTBEcWE5VHdxaU1qcjk1?=
 =?utf-8?B?ZCtYM1lLa3hmWWwzLzlvUG1obWptcnVkV3BnMlNYREI3RXZLUlJMbE9kV3VO?=
 =?utf-8?B?SGo3V09DekZ2NjVBcWEzZ3FMN25aTXViOVZneEErOVRvMS93TUozTDVsR1ZP?=
 =?utf-8?B?TVhVRVUyRk5yalF4TkxzYmd4UHZzaWEzSUYxTUtIMjMzS21SaWtlcDZZUklp?=
 =?utf-8?B?di9aSVhNaWNYdDVBcmhvaWJjNGdOZS85NDZOTWptbHFLNy9za1BKeTdRYzdn?=
 =?utf-8?B?Wkk2cEtIMElERUhtcjg5Z0U0cnEwOTFYZHFoRTFydDBvWGRDTG82cm9Gb2lD?=
 =?utf-8?B?Qmh3NlR5Y1ZFV0hEVGpJOVVaa3V2bFdWTXQwZURzSllzRFVFQnc5dVJZSkx4?=
 =?utf-8?B?QXZIWlBiVG9DOWI2N0JZQ0Rya0RNR1JyVUdnUDMzTkhKc0QrS1VXcmlyZ1A0?=
 =?utf-8?B?bnBucUw0YmhncjlrT05UQ25ranpMS0JmcWlxRHYrbTJReUZ5ODBRTU95SE53?=
 =?utf-8?B?UmNERExIRkhQZUVuNHV1TmUwZlpMeHVZRWJIa3Q0ZUdUek9ZaTFxZ3NvMGJM?=
 =?utf-8?B?dk1XeHdHZmc4cDIwWlFMVUJaZ2VQdmlkOWhOQjRNdXlnekZUN2V2bi9rbkNm?=
 =?utf-8?B?MnlUOHVlc2ZibWlETktFKzlFaDJnU3hPQzVTSXdkeFFNak5idGRyakxCUU54?=
 =?utf-8?B?RlY4cXJIU2Fza3I4dldCcVZzc2NQQU5rdC9zZFUrb08yUFM1Vk5CcGN5enIr?=
 =?utf-8?B?UXRsWFFteDIzZEFhRDc2a2psTjFFKzVJNUVWWHl6SXdCeThoUXJJRFBMQUFG?=
 =?utf-8?B?bGd5VG1peHljV1M1ZFVNa1JIcEwzTGVPVjVUV0dqaVBCUlVvZGErMW0yTzND?=
 =?utf-8?B?TzlsZDVsR1dEN0JTU3JIWE1oV1hRWXVJZGN5UDB1NzUrQXgxVFd4a1VhRENv?=
 =?utf-8?B?TVpFekFoamNQYUVKenZPbGh2dTIvd2F6SGhBcUJLK2RCU2k3anA5NmZjVVJ5?=
 =?utf-8?B?dVQvejRVa2F2MnJTRXp6djZDUm1WSFB2aDY1ejJ6TEhlYjRpNDhFOUZTaFlL?=
 =?utf-8?B?WmZ0Nk5rV1dtS3NKZnhsVXY0S1RmdmhVS08vSklaWFVwRWhQZFEyOEZaQjZr?=
 =?utf-8?B?Rm96eGtJQWpnWUFVcUVRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3BMc0JlTkVLajlLMHVkd0NLd3JhRmNnenEvT0ZpaHpwUzEwUk9CSFlFRTZZ?=
 =?utf-8?B?cGoxUlFKRWFSZkc2NEYrUGlWM2dsT1ZaTTMwcXNRVlBBWGp2ZUY5MlVuM1FI?=
 =?utf-8?B?MmlWVldtTW8wdjZDMnNXTFdJZXhkd3RIRXJjN3hEWis5VGZHNVF4MXl3TGpZ?=
 =?utf-8?B?NTJFczlRR1JaSGRxODA3SWRtc0FNSXJXVVZQVzRJTFBHY2RnVDEyZHNqRVlh?=
 =?utf-8?B?THM0Tk9aOGV3NFFYV0JOdXRBZ1RUS3UxM0Zkd0lRUkJkTWpiQlJpUlFVUnhE?=
 =?utf-8?B?Vm5mU2dud1BuWGxDNW9oOE1mc3J1UnlIYjVheWk1SnF6Wk5UWlhUSkZVdGJm?=
 =?utf-8?B?azVNZEZwdzZLWkZ0RjZHRndjWFRjY21FcWQ5aktqUUFpZjFXS1VXNmJ0OVU0?=
 =?utf-8?B?cVpjWHIzYWQvOU1VcS9rdGE5NkMzeGxqMm8vbVkxcjVxYVVVUmNiRGhWc3Zz?=
 =?utf-8?B?akRhVXdBZHAzMlQ0V0EvSW1OeDAyU0I4aG9XWFRmazZ0ZVZ6ZDM4Q0RYK3o4?=
 =?utf-8?B?bTh3dDlOTVBLQU8yaEtVQ3luNXIyZEY3M2tnYnk2bFEzdFJUYThBL1pWL3VF?=
 =?utf-8?B?a3pZL21uZitKeGgyT1FwOEY1RHdLajhuSllOUEtoVWpoUWYxdzZySmc5Qzhw?=
 =?utf-8?B?SHgyaStLcHB1UlYvdVdCdWJDd1NQQWJGaDZUSUcvbEdYVk5uLzdJY0NOZk5o?=
 =?utf-8?B?UkY2cmFNL3Awc29DbWV6a0JNaEkzS1JYSDVwSzhVRjRkRFp1bFlLRFRmd3NR?=
 =?utf-8?B?c0lpaGpWV1BJQ2YvV1F3ZG05WUR2UmJwUXF4SUxqdDZsSzcrakhrbTVqU2ta?=
 =?utf-8?B?bHRsczNYVmZlTWxGZFNvYnYySzhYTlNScU8yL3p0YjB6SEEwZ3FOMUlTc0Vt?=
 =?utf-8?B?T3hpQ01vdEplaHRkQVVYL0xyeHdXRTluUS9rbFFTSG1tUnJubEdWY2dYc2px?=
 =?utf-8?B?cUlrbDVtYWpCWXdOSXBTeXc4ZE5hRmgxTmxScHZJdnFCWldZUVV6TElYcHVB?=
 =?utf-8?B?d1NzSGh1YnJFMDMzRmdqN2xCUHNpek41T0oyMUFoWU5NcUhib2J6V2NrWFpp?=
 =?utf-8?B?dHlqbkxsd1RHeDZ5VDFUOU9nNGF5bFpJbWhHbnZYVWxCekJxSGM5L0lpTVdw?=
 =?utf-8?B?T3RKZDBIWW53Rzd0S29NdDFzSHVqZlVLd2VoMmNzWk5Gb3B2Z2hDT3lTeHls?=
 =?utf-8?B?QUwvTVlDVjdoaHhmZEZLN2Z2UTNSdmZMNUIxdWdtSE1IVGczc0lFbk1vdEZH?=
 =?utf-8?B?NWxVRHIzMTA3MTcweFh5elROdEFTUFRnUG1yb1RzYkg0UGZqSUN5b3h3VUhp?=
 =?utf-8?B?VEdXZmFBL0ZZT1NpRkFHOGpWdFg2Y2FsMkJwUnBLbUhNT09CT3NNWmtPTHQy?=
 =?utf-8?B?ODNDSG9jeHo2VmNEUEJDZS9YNXZUMEtJbFV2WnNVOGE1Q0UwTXdIamhqN2F4?=
 =?utf-8?B?Y0hJTEx4VzdlVmdIdE82NFVEazNiRjl3SmtDSDFHNGFwUFJ5MEpCd1NudVJU?=
 =?utf-8?B?K3hudnVha1B2OE1Tckl4OVJmbTZxUDB1eFVSWEkrcHRxTkNYQ2dGK3QxSGNl?=
 =?utf-8?B?dG9LbFViUVVtQTd2dVByTW03MkRGNkRqaklHMFJFRGsxSUI4N1cxNlhzOEVG?=
 =?utf-8?B?MFBBY21Dd3IraGtWUmRxOWl6aUFSc1FHWGhDQXM0NkpQeHo1ZnFGQ3FNdjF3?=
 =?utf-8?B?Z25zMnp5ZFhQbWFHL2xCTE9YYzZ0RVkwVlA5ODlwb3VMWDlvTGh5TGxnRHR6?=
 =?utf-8?B?UWdwMXhuQVhUdUsvZHNNanR2WkxURjFxcU1Dcis3R3ZHV1I0ZHFXVjErOVl3?=
 =?utf-8?B?VlJHcFZEVUh5dnZBRGE3Ym9ZaHdtTjJhUXJxaFoxOWp4ZUhXYnhoRjcwYkE3?=
 =?utf-8?B?eWVsMVFPSVYzTjF4YmpBWEV5QWYxK1J3RDFGZlRDRWlTQ3RxOW5NQ2djY0RU?=
 =?utf-8?B?UURRNCtrNW5QR3BZaXEvWmJhR25mUzhCQSsyTWQwc1dGRUlHV1JBdTNWR2M3?=
 =?utf-8?B?UTBRZXBGdVNBSXo3aUpIRFVINzNEL3JpM3hhRkIrTm1zbE1iQjJ5a0tVWHgy?=
 =?utf-8?B?TzZETVVLMzAxMCsyZllLLzJEOURLaFJlVW05eDNhMkIrQWdJU24zNTZpb1cw?=
 =?utf-8?Q?jZZxd2TVfB8rfxj30bc3E3xD+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784d4e1-8b78-4b12-e744-08dd574e3679
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:45:59.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAUK8gej46bydOdRUz4uudJHfSA0X5Z7g1P7Xv03XGA7K8SVALEaBilDzxj4vIr01GyptroSgwkv3pyUSqC54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228

On 2/27/2025 09:36, Antheas Kapenekakis wrote:
> Since amd-pmf is expected to run alongside other platform handlers, it
> should be able to accept all platform profiles. Therefore, mark it as
> secondary and in the case of a custom profile, make it NOOP without an
> error to allow primary handlers to receive a custom profile.
> The sysfs endpoint will still report custom, after all.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/platform/x86/amd/pmf/spc.c | 3 +++
>   drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> index f34f3130c330..99c48378f943 100644
> --- a/drivers/platform/x86/amd/pmf/spc.c
> +++ b/drivers/platform/x86/amd/pmf/spc.c
> @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>   
>   	switch (dev->current_profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>   		val = TA_BEST_PERFORMANCE;
>   		break;
>   	case PLATFORM_PROFILE_BALANCED:
>   		val = TA_BETTER_PERFORMANCE;
>   		break;
>   	case PLATFORM_PROFILE_LOW_POWER:
> +	case PLATFORM_PROFILE_COOL:
> +	case PLATFORM_PROFILE_QUIET:
>   		val = TA_BEST_BATTERY;

I would really prefer we do the absolute bare minimum to help this issue 
on ASUS (just special case quiet) and leave adding compat for other 
profiles for other development.

The reason for this is that if you look at power_modes_v2 there are 
actually 4 'possible' modes for v2 platforms.  So there is a bit of 
nuance involved and it's really not a 'bug fix' anymore by doing so much 
at once.

>   		break;
>   	default:
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index e6cf0b22dac3..a2a8511768ce 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>   
>   	switch (pmf->current_profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>   		mode = POWER_MODE_PERFORMANCE;
>   		break;
>   	case PLATFORM_PROFILE_BALANCED:
>   		mode = POWER_MODE_BALANCED_POWER;
>   		break;
>   	case PLATFORM_PROFILE_LOW_POWER:
> +	case PLATFORM_PROFILE_COOL:
> +	case PLATFORM_PROFILE_QUIET:
>   		mode = POWER_MODE_POWER_SAVER;
>   		break;
>   	default:
> @@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
>   	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   	int ret = 0;
>   
> +	/* If the profile is custom, bail without an error. */
> +	if (profile == PLATFORM_PROFILE_CUSTOM)
> +		return 0;
> +

The legacy interface doesn't support writing custom.

https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/acpi/platform_profile.c#L382

IoW this is dead code.

>   	pmf->current_profile = profile;
>   
>   	/* Notify EC about the slider position change */
> @@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
>   	.probe = amd_pmf_profile_probe,
>   	.profile_get = amd_pmf_profile_get,
>   	.profile_set = amd_pmf_profile_set,
> +	.secondary = true,

I really don't understand the need for declaring primary / secondary. 
It really doesn't matter which driver can do it.  This same problem 
could happen in any direction.

As a different suggestion; how about a new "generic" callback for
'compatibility' profiles?

Right now the .probe() callback amd_pmf_get_pprof_modes() will set bits 
for visible profiles.

How about an optional .compat_profiles() for the hidden one(s)?  This 
would allow any driver to implement them.

>   };
>   
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev)


