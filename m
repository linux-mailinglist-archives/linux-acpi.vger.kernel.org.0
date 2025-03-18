Return-Path: <linux-acpi+bounces-12317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B9DA66501
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 02:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C03B17A333
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F814B08C;
	Tue, 18 Mar 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WQmKyFmU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A1C2C8;
	Tue, 18 Mar 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261399; cv=fail; b=fSyz7Xb+XFC3PBzgTo5RaTEqWaVuySNS0dSvEl5FSGoV/BDk3jmgemfBqUHGqOvrAMNFaF9ejtvvj2pcjVBroT5akOK+N0gRlFwgeqJSbFscq7HCCAOb5Fv53WT729dMKEpwRBg+mPkzpah+sNTY4rJheP7V8F/ZSXCtZJzMu9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261399; c=relaxed/simple;
	bh=yT28NzlpmjPSlhyr5v7YWlolYA5tsbTXeI8p+IgNxC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/i2AGCGsBrZUqDPzZy7di46VsOIxnHzeLcm2/iQl4Tc7Rbs23ftlPw1FNkjQi35k72dK/ncQFMEdJrknqCEPgrYOj/epu1PVjCmOoZqKmiyeh/s6t5Y5H18dBgiRbhEiakKZ9Av8B5U5Kujo8nEwgPtLH9j02rCydIBKo4tzy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WQmKyFmU; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeFwAZ++gLnfldynJJZ0ZPtG+TerS8aR+9WVWnOfN5Hfd3632GQiWDp2+VQNn4ajQTycfOSw4vHFbs4/+s6RZD8ixBcyhxqOqGcHhxJdbjR1gfTYGIKfPvIo/QOIrwTGw3P5Lt9Vl99KCwbiL1mWrxjayI0KZKLHyEPNfA3iJ60sX/byOFTH2EbpE/5Cfsn5dqopfsM0PQodOvSRXSObxIrIEBphxxHKyJXMJFNdtB1OnsLqaXpoel/it5kRNZZT0+GMLG6QVCODVaAv4bh78LZxhMN8FASgt7iOhUAjXmSCh2l/vJpRidxIl18zInvBoL6CJDFB4Ur1UK3EgWXHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJRfF/HxQ0SijIbO35McZr3JEC2sNrDSxwRoikRdkIw=;
 b=y2O1Q0aHNzShYJoVEb0cL+raFo/w0OYHXkOGaExlMEja8eQ7TOco8ZPmrhZY6pYHaEw04O2+rZnEwOmvXtpHm8pqGJDdeTFqks2Bp5glBozN8mbDpjXA/X/3iVXeiHVYyqizrnnSeFhrhMfhQM4BLzbGN5E9CAi9nlSKFxuCklxtXacBjaEawE9WvD3kpiokH9T+Y8BoUvGCKYtYZybga6TYbVuYtLH2NWTfK3JF9rbc4V15QdjPBPq7p3x759tVcqAiE1dRou0KhEkWajWkz2M3sbESawG8s4K7mBhcUXCqjPPlpDakY+hdDLF04ce543QWcpQM9RC49Qk+0DobUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJRfF/HxQ0SijIbO35McZr3JEC2sNrDSxwRoikRdkIw=;
 b=WQmKyFmUp6Unit4CLaQDLa1+VWlFoE0CyVHqlIbImDsUiaMjuJ/aApDR3mv4gGNy/jvfSscS/tF1Gk2RB0fDz9KFfVxTIUp+HmCb6kF5++ed+ilSswHV2x/djHGXFw7XdjQOJndsXB7M9QcKxOg5zxsgRMXChB48hXMO2Hw07bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:29:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:29:53 +0000
Message-ID: <35c99e60-c44d-433f-8988-62aa94dd924f@amd.com>
Date: Mon, 17 Mar 2025 20:29:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings `Could not retrieve perf counters (-19)` and
 `amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled` (Dell
 PowerEdge R7625, AMD EPYC 9174F)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
 Ray Huang <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, it+linux-dell@molgen.mpg.de
References: <2b811df7-5278-4cfc-b8a0-7d6d72d3358d@molgen.mpg.de>
 <5dff1719-c4e9-4ebf-ae0b-73b9de98df05@amd.com>
 <DS7PR12MB82528A694056F1FBA20CE01E96EF2@DS7PR12MB8252.namprd12.prod.outlook.com>
 <d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de>
 <e26bc00f-1675-4aac-bd02-60774ff5901a@molgen.mpg.de>
 <3ded4075-e2f9-4231-9c3f-49a14fbbde1e@molgen.mpg.de>
 <1ba47782-0035-43c3-9ecd-887f1f60340a@amd.com>
 <73da51ef-a7cc-4c38-8289-09c9cbd0c65d@molgen.mpg.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <73da51ef-a7cc-4c38-8289-09c9cbd0c65d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: e0de9b34-8d95-4e32-46ed-08dd65bc623a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejNEY0lIcXN2VEpmTVduMVRMVDU0b0pqUFR2NEFMS1ZRRmJFMytNck9yU3Mr?=
 =?utf-8?B?RUpaVzZ5ZFVkeHhUaWdKQlZ3RERPZFV3L2VYQkY5VW9VOS9GNUpIK2p1Ykcv?=
 =?utf-8?B?K2c3aTA5cFNYTTd1cWs0Q0h3bzdNdVpWa3ZoQmUzYVZxZGlZQ3BoL0hqZGVX?=
 =?utf-8?B?TURmNGdLWlFrWHo4YjMrN05rL2xYN2RJNXFNVmo0NWkzbTFrVVpxMzZDTis2?=
 =?utf-8?B?dmkvc01RbHUzSTlobkNjZ3lxd1pSdXozZkxEU2x3WWV2ckNTUk4xQlBaOTBR?=
 =?utf-8?B?eGNQY1Q4ZTNyWitLdWVpakJ3cGQySWVMV0c5TXdXZTIvRmk4MHdFMENOYWVK?=
 =?utf-8?B?eWhFV3FFdkpENTczYTIweDVYNVJGcEVjckNSbzJHY2ZsdzBPL1RCYlpvQTFN?=
 =?utf-8?B?QWNWOHc0NHBubEhJWitoSTVtdktUVWh1R1ZmOEt1VGttV1dmYlNLV0x1UXhs?=
 =?utf-8?B?NzVHUDhqT3lZbWlKVXpjbjFNNmx5T2FoK0tnTVROTnQ2Z3B5cG1TRzNVenhi?=
 =?utf-8?B?R0doMGtKZDl3MnhZaFVXMGI2b1RqZ1hpZWlCbkE2VnhWTWdqQ3hqZ3BNOFFP?=
 =?utf-8?B?TllCYk5GbzdJSGpjWnM0NlVQbnozaTBnNDg5MTEvQTg1YVZMSURFNm1yZW02?=
 =?utf-8?B?OW11UzhjSHpQd294SXc4dFZIa1ZxRFR3REROM2JNTXdaL2thcFRaaDFGNnVJ?=
 =?utf-8?B?VUlBeC8weXVBYXZ4eFdwSGYwZGM0cEpQWGF2cFhoVFhEOHllNFFLTENoWE9C?=
 =?utf-8?B?SXNUVDJ3Witad0J6MUFubncxQzVRSFNzV3prQVZDUkhwakJQeFVHd3lEZ3Mv?=
 =?utf-8?B?RVdKcE9iek5BVFZvMUorZFVoWnJua3ZpdkRVd3BkYVNIRUVWaVhxMFNrRnNi?=
 =?utf-8?B?cE04Rys1WEQrMzl3bEdMdkdKait1by96dEx5NDM0b3cxOXZhODVIbUVhZnhr?=
 =?utf-8?B?cDVRZ3NkWVFwMkNtVzlFdmRCSnArTGJsU3h3L04xR0dUZ1FZdjZDRTlZU0tu?=
 =?utf-8?B?SUpoc0pYcXB1TUtLNkozaDA3ZnFrbFRqeUx6bCtvWVlEdEVLNlA1QWdTWjha?=
 =?utf-8?B?bVdUZmhMenhaWm5yNmdkdXN2ZXI0SGdYV1Q1M2s1QSsreWtBRnY1SjNTaEVG?=
 =?utf-8?B?TUdtb2U2N2ZFWUZZT1FYeWxtTklFb3RHUXRxb2twYVhhVlZ3dGdxV3c0V3Ix?=
 =?utf-8?B?Y1lsdVNDNXRZOXg4K2VEak54RHJQVHpLTUFnMkhLaEdZeTRyVzF4d2ZCZEk2?=
 =?utf-8?B?YndEUWVpY2FEUnlTN0Fxa3hBM3dWTlQwODhTUXZ0N1lxQ213c0pzcGV1aGRI?=
 =?utf-8?B?aXcvdGU1dm5makd6VG1zVU9ZaEtnWi9ZSVd2cEkxcG9OZ3F4QVU3R2liZFdZ?=
 =?utf-8?B?eGE0R3AxbGRocnZKV3hrSnhxNExHRkJValI2ZDVwWnhDVjZON2ZYZklFaUVr?=
 =?utf-8?B?MG1VL1RVWnV6U2JnU0dMMkNvL1BjUVVKS2lwQ2xwT0I1TEFEQVo4SzFUeWE1?=
 =?utf-8?B?WXVCQmtxNHFxVEJFU3hPS2tIUUxxdVR5RHNNVjNhU1VqU1NkcWk3b29VV2FP?=
 =?utf-8?B?Q2NqbDI3dUxGaDk1b2RTaTR5cmZkbEJJOUxPRDFBTXJranNHUWpCQmluZElP?=
 =?utf-8?B?VzZEdDRhZEcyK3l6T3NkYW12cWkreUNVOUtUMTJQbkttQ3BWcVh6aDljbU1D?=
 =?utf-8?B?SThrdEtsNm1GWU1JY3VlRFl6VDVCTGdDa2loNWpqTzM0QUZKNXcyenBVNUxs?=
 =?utf-8?B?MU91aDlNck1DTTlzT29QZ2pheHcyblY1aTl2bjBKS0p2NlpRSXlVejRISG0z?=
 =?utf-8?B?ZnliTzRnVUVVZjc0WkIwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGg1Wjl6RGUzSnhFM2E5NTl6djVVQXFka1d4SXRiTmNKb3ZzT05aaWJpY3hz?=
 =?utf-8?B?emdLN3Bia0g5a25zR0RGTlBKckltdDN4UXhzN1gvQVlpTmhTK3lvWkxPNzdU?=
 =?utf-8?B?Q2F5THFnaCtoWEduZU5Bd202OUw4ZTZlU2pDUWtIV0h6Yks3R0t0Z1ZrQ1dq?=
 =?utf-8?B?cisrV0UwenhYdythVmkyR1NvOGtBa2VxeE12S0JNanBlSHpPaVR4M2tZZFJ6?=
 =?utf-8?B?cHczUllseUpGbGRaSThrMGw5OFozaGZUblFWSnEvcWlzWCtueXo5ZTFaQ0ty?=
 =?utf-8?B?ODY4dTZ2NysrTzNHK0IrNm9IVmpiN3o1T1kvQTNQV2FNTlAxbmlIRXlPazll?=
 =?utf-8?B?VFBZR1dxNzlwVkY4QTdaNVNKaEtYTVlhajd4MGRBNFFWb1UxWDJUaHZSQk5X?=
 =?utf-8?B?c3JMbFpVQVkvSTI1ZjYxNWIvVk41cTBNVlRLemd2ZTV3V3VTZHIxcHFCUWo0?=
 =?utf-8?B?RTBUd3UxUWdaUWs3cFhSVDN2UlBlZGdMNTg1WXNKSmJRQjVlQm9oRlB5WFBI?=
 =?utf-8?B?bXJUS3B2bysyS1l5RURZckxzVE05dWVDMm1xNE5Ya1RJU3hPTUk1ZFNTc3lE?=
 =?utf-8?B?YUJMbTRZNEdPMWxkQnRZMjUrVFVwU0o5cDJibW5EK3c4c2ZLbXFUajd6bnRK?=
 =?utf-8?B?MHRnMVVCdG9WeEt6YmVoalpBMlh5SUxrcUFOWGpGbkxOM3paczhtUnhvYkY0?=
 =?utf-8?B?eUIzS3pCU0Foc0lDcExqN2xOMVlqcHd6MEQ3Qm9lMlBtNlp6d0VKZFFHL0VX?=
 =?utf-8?B?M3JNcTNMSVZScE1ac3dFditYRzlOOTZkcXFUUVFCRmFGRFg4OTMwcUdJQTdv?=
 =?utf-8?B?QUVNbkJOUU5FWFJNNlZBem4yTnVOQ21LdmZmRlAxTWw5ZXY3a3I3S25kOHhu?=
 =?utf-8?B?S1g4ZXlzek5Tbm8yQVgyb3JiSGFOZFhFUGhmWmJTSnVkWlFLck1obkVBMysx?=
 =?utf-8?B?T1lVcUlZaFIvT2lBMWYzdWZZeXdHQXFBRWFDRTIrQTIzTWYwMWlVdGtxbXB0?=
 =?utf-8?B?UlZiWG50TDkxb2JoTXRlOGo3YjhiOTJCS3F5Q3pObXN0WHpEczJhZTZrdHVY?=
 =?utf-8?B?YnJOeFo0RXorNjBCeHh0Z3FxNG9mMXpzdGNSMllNZ1V5Ukpsa3dqU05QNlJt?=
 =?utf-8?B?M2FLN0Mvc1VKMFJ0Uk5wYk9USEFhRUcxR0dOZHlac2lVNEl1YnBzc1d1WGRl?=
 =?utf-8?B?VXFqWTYxb3lCYzdualVTbXFVOUxDNzJ3RGh1L0FRVm0yaFlRNSs3NmN0WkJq?=
 =?utf-8?B?RUVJbFl1Nnp3RWxRQ2xVNXVLc0g2UEpBWGZwSDZBLy9Sd2ZiME1LMW1wUkV1?=
 =?utf-8?B?aXVKcmtSRGpMaERPeSs3VGVjcU95L1JhVGFzUWYwUmtJSXBHSzBiL0xQdXM1?=
 =?utf-8?B?SVBJc21SQ1hkdVRNUTRYcEU4VGtEaFFRY25HS2VoWTFTMHRRKzZQOHZGbTlB?=
 =?utf-8?B?UG9SN3R0Q2NDcHhVRnNmdm5PdnlGZ054ZzQxMklLVXNuVGs5cncwb0Z5Wis1?=
 =?utf-8?B?b1JUSUwzbC82NFpVRnBlREJENldDdUZ0NjBnVnhLMmVlWDlrNG0reTZ5dVhO?=
 =?utf-8?B?WGJHRThLZDB6ZldIRXBsYlliNUNRcS9qZnY4b3BvNjhHcm16aWN6bUxzSGFa?=
 =?utf-8?B?L2hDSnlPRWRVZ3BxL05rUThkQmp1UERYV1BvV3BqVU80TjRzUWNidGpYMVRu?=
 =?utf-8?B?bmRVc0U3MTV1RjRZdjhzRUxrQ2NyT0phd2UvaUJzY1V0ekdxdGVvYVhMbitO?=
 =?utf-8?B?aHZYTi9EbnhWWU9ZWXF0UkNVZFozSnZzZ1AyMHkycDQ0c2tHL3QweEtibzhV?=
 =?utf-8?B?eVMvV0xsTVJKR1pKbXgxc1BoRmt5SHhzWVV5NGg3a0JaL3dCbEVxWUVCQnJj?=
 =?utf-8?B?Wjg1a1hnMnVDNkpFNkU1VFpCcUdBcXZzSnczdmtRdHBWc01PbzhvNkl5OFZu?=
 =?utf-8?B?V2kycjVMekVDNUFXWmVqb3NLM1c2anFmTTdlN2tRUUhFN0xEcTNIWTRqVzRs?=
 =?utf-8?B?MjRtbUJUbDlIVWRsT1RmZE81RnRZN1Z1My8rZmxqVnZ4NjA1eXBMWG5oT0JV?=
 =?utf-8?B?b0pCWmhHaDRQQ0F6TWZWWDRrWnlRZlI4ZkZVaUFFY3h1SFJsV1ptMFFzQm1s?=
 =?utf-8?Q?quTDRmfqrsFf4JNKxkK50tIac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0de9b34-8d95-4e32-46ed-08dd65bc623a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 01:29:53.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so1gV4n+Cj2eMkmjq6ULKey6j+udQElJcPkaVHRgn4/fkivRFmjVOseQ8w2lpKh4RCbn64eK0LnI5w3vKBZatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

<snip>
> 
> I made the service request 205423744 on February 12th, 2025, and after 
> collecting the details until February 14th, 2025, Dell replied on March 
> 4th, 2025, that there L3 support and engineering team was able to 
> reproduce the issue, and they are going to provide a firmware update, 
> currently estimated for June.
> 
> I am still surprised, that Dell’s QA overlooked this. Does AMD provide 
> them test suites (does FWTS check for this). `dmesg --level=warning` is 
> unfortunately not empty, so maybe they ignore it.
> 

IIRC FWTS doesn't test for this.  Perhaps you can add check to klog.json 
for the message you saw?  There is an existing pattern for a CPPC 
related error message:

https://github.com/fwts/fwts/blob/ec33c8ee1d99211a9cb2081324ec909a325e93d8/data/klog.json#L56

A similar pattern could be added for your case.

> Would it make sense to make the warning an error, so it’s less likely 
> overlooked?
> 

If they don't run dmesg --level=warning, why would dmesg --level=error 
would be more likely to be run?

FWIW For 6.15 we're introducing another warning for BIOS failures.

https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=linux-next&id=a9ba0fd452d82ca0da170eb6291aac01075a17d5

