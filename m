Return-Path: <linux-acpi+bounces-15824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A756B2B83A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 06:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64B31881B43
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 04:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129820B80B;
	Tue, 19 Aug 2025 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ObC2+Mkt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012056.outbound.protection.outlook.com [52.103.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08463451DC;
	Tue, 19 Aug 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576271; cv=fail; b=BpFiPmJyRog9UiqGLHae+7TOTyUBX5PHwwsJayasKkYatBcq39jy+AteI7tBrEBHfmpluN5t3QBuepLNoukwbJ4vKAX8L0wUTg7ybe+DU4ji2WweJzmODPy3KAExg0XVisAkbD5juh6kRdoKUBBPAiZl52BAz7i7aObkzuCh6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576271; c=relaxed/simple;
	bh=SkCAZG5672RFkUk/zl5ocuUKGuU3bEGTjuuF0LWfN00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2+wDCRYTZy/0bIG58V31+85xjjEVgLa5BMfPBESU6hWrXTFIj3+6z/vwEUGifxOgH00GL6QM/xRVQ4Kyga7ITbjK2NUSKKWbXujP1DgsR6imMfrxRTPWu39aUjrdAclrhdcKqcMz8TdDNL9bpwVe0vd1x3wQseuS6wgGjUti4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ObC2+Mkt; arc=fail smtp.client-ip=52.103.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph42v5aGt5Uwba74AAQMRpND27iQV3asO/hymCK/QE1heVq3dUuEfkxT+s9pCAr3jVIV06NcLrnX6uh9EPWZNu2R8qG9PIq6N0jlpdOnvZN0ZJkaf+ZyiUDSBYrtCGmj+c/wcd2sNxa/Qkfo4Bd8r9Nm04FIa3vE77qKV1FhX5kQK3beM3WnSI1u157C7+AIL3AbBdRKx1PNjdPUBwGzOn7Bah/tepdQm9q03rMq9lHa7uVh2Bx8Jn13A1T0AMyAvPWzzBGom8qOqX8lWOqRDn2xElf0E3JdbQfA877dng6HDFXk8cJnbfJbgiboE1usecQCvdZt4Ig7q2TAnNQnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogqP1be7TxQbgOtGK6bF2lVGSbG7ElmEaxaDPLW4w7E=;
 b=BIHmNBUR8DUBAf+RToQSYuKXQ0BosjUwtaKL+GJSJA6If0nJXnsQOmTyrB8kFTfYz2Tt0+GfkYRyPQ2q3TpHgHhIfxacbCWmd4tHzwWDL4wB6jvCx5SmDWKIzBd7wLhWnvrJXo29p3B7fbeaGsO6ltiVIvA5SBI9FY88oxyQb4kugi/Kckxp3lF0w9vcb3pgkoRFno/UUJko8sxCcrQq0+Hz9qAQ2dBVeZNfq5toBmcwyz1EOHMA6ulcCDcfCw4RJdD2yYuvZT0WJhUqaPqDllfmT9K5oJFSeLtfQjtBPsY0nkLo1fITCXSjZxe0RedSXSbIVfrKOxt8CbCFXgfOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogqP1be7TxQbgOtGK6bF2lVGSbG7ElmEaxaDPLW4w7E=;
 b=ObC2+MktqlMs8NDzGguEwFxR1zbl1f6RE8RfiMRlQwoptVNo+p9dgxHrCks9q8gJ3LqOnSDUEsv/yR6eOB/anoXMNNiGYTIdR/6XNs9jm9ds1dsBBl59cOSrFxfAiX0wCBAuhlVSbjnKgK+p0gKugqvB98IF8v1cGcIB+j4owKu9/1MNMnc2xnELGMxCt8Pw/7waNIdS35NmhAlIsKLpmvwZFQEZQOMw9p8lRTiODYlzUY6/A8E+50L0d7FxbKY5cIaakkbZFx2ynbQ/x/ksDjQVyktbflcWDcwwtKDfTc5aYpI2XwbBE0m0cney43/rCcOSZDPzDRiiQjiPMd7Ggw==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by SI2PR02MB5564.apcprd02.prod.outlook.com (2603:1096:4:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 04:04:23 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 04:04:23 +0000
Message-ID:
 <TY1PPFCDFFFA68A5FC785C784C2E55FFF20F330A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Tue, 19 Aug 2025 12:04:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Anup Patel <apatel@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250818143600.894385-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <0f4666c9-79c6-4f07-a929-9b0ccf420ed8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|SI2PR02MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1f4bd6-383c-4fd6-64b9-08ddded57adb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|6090799003|36102599003|19110799012|5072599009|15080799012|23021999003|461199028|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T25JbzdTa0phdjZZUmRFekVOL2x2Q1RQTHhQV2RKUmxqVEJWcU43Y2srZTFh?=
 =?utf-8?B?Z0pjV2pOVmJYayt4RkRlWTVrblR4OUpVdlJMTXZYQWFVK2psa1lhQm9rbFVG?=
 =?utf-8?B?OC9BSmV1aHFianNMSXlncFo1eDFsSHgrdkkxM0pmRmZzWEcxT2hnOUxwL1Fr?=
 =?utf-8?B?Vm80ZlhaUVkvY2lrWTVTdjBMdjNlUWNaTzNQZDVGOWg0aDlkNFYwRHdsbmJD?=
 =?utf-8?B?Ti9xVmlwVnVLNDAwMWpiN25MNzc0V2FlY1NYeTErcUdHaVJrZ0dhVDE4OE90?=
 =?utf-8?B?RnZ3bit3WGdBVklYY2FaNE1GS25HMSt0eHpvZHpuOU5ET2xVMjIrbVNwMVNt?=
 =?utf-8?B?VU1kQlBaa2tRYzVPUVdKUkRrelZ5V0tjM2VnamIwVDE2MjU1ak9qZ0lZcS9K?=
 =?utf-8?B?ZWlZOGFBYlV3eS8vdUJybGoydDd2QlBHSDUrWXJuQkowU1ZGNUtORUx2VENG?=
 =?utf-8?B?a0VKYW1uUjJ3TCs0ZWpMdjg2elh0bTVobWYybVc1NzRITGx6LzF3ZCtrUW9z?=
 =?utf-8?B?Q2pKMUE5TTF0ZEhpSzA2Rmkvd0JKR2tNSFFjbC9jZExoeElGaVUzek4vMGlx?=
 =?utf-8?B?MnBvZEd3R0xmS1diOEhYV2VjRVJtRmhDYnpMRjR2akErWGZZdEVCK0oyRWFn?=
 =?utf-8?B?N3o0ckludi9JUGFNVmtUVmZUVEt3MTNOdkFkeE81SjhXSTdSL2w2VGI0aTJB?=
 =?utf-8?B?VjBaNitMZmZoM202MkZGd1hWc01TTkVWMWhtR0JDNDlibDVDN3ZEWUtRRXh0?=
 =?utf-8?B?QlU2NVhaVW5NU1FsZkE1bUtDSnJkcmlPdjM3bUdUN0NXWk5TYThtckRvaGJO?=
 =?utf-8?B?OHQyckFrM3JOcTVtREx6UTN3ZlgwYkkxaFp6YzZnRm91YVBVc08zbnNXblhF?=
 =?utf-8?B?U2Q5a3JHYndod3A1RGJRdkpPd0FPY1M2N0NucUtrN05UWlA0ZVNaR04ySnFI?=
 =?utf-8?B?akxEUTJ1UHRrVHpBb3lESkp2U0diUEhORHQ2VkFxckVWbUxVSVIyL1Y5NkRJ?=
 =?utf-8?B?TC9sUG9PS3NTSUJvVXJIRzcvSFZya2QwT1h4SGRPdVI5M3lPMVd2M0N3alJH?=
 =?utf-8?B?RW1PeWU5OVpBa0h2Q3NaZCtzblpHWllJRHBFL1U3UWMyMnRTMUttTUF0SnpG?=
 =?utf-8?B?NSttcmJhNEg5ekFtRzRUcmtkRkdCYUd6ZVJpM2cvYU85aEw1eG8yeG54dytq?=
 =?utf-8?B?ZGd5TGZOZ2twTjV6TzA4OHRvcUNDdjhoZE0vRUtsSnlxVFBlR1V3aUo4dVFV?=
 =?utf-8?B?YVJKTE1iM3lMTDJvc1E5N2tzWXVZSnFzZUFZOXRpazFCekNTRTVib0oxcWNR?=
 =?utf-8?B?ekd1V2x1d3RiUUhuRk95OXR3MW1Xd0hQaWQ1MS9qZVluVkNBNGVVTytmeVNV?=
 =?utf-8?B?NkZKK1VCdmhkWVJCM2lHQXRPMVBBUjluSWZpbnRrNFN1WExBemhuUERVenB0?=
 =?utf-8?B?bjdqR3BnaFNlaENqTk1UblR5Y0RhckF0NGJUcnpGSUtQbTJGbTlDUXlpUW5T?=
 =?utf-8?B?dWt6Ui9mekxkQVZWYlUrYm1DYzZBSWE2NGtPeUtZMjdjNThNazdTWEh0Zk04?=
 =?utf-8?B?WEovRmxKbW9MdnE3WEhLcC9oRFdpQnZrZE1kOURpQzA3U2NwTjZTRk1QK1VW?=
 =?utf-8?B?ZGtUcS8rK3hhR0FGRUdld3NvbXZ6dEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBCYkh0T1VmZnpBZUt2a2pITWxOZk5GTlVuY1hPSExtZHRBbGNDWlJIaFBs?=
 =?utf-8?B?a0UrYURPenN6V01vU2wwTmRMRE9nRkVrTVVMMUdEcVg1SW1QZnJ6bEswWXRE?=
 =?utf-8?B?M05lU0NrRWpBMDd6bklZWFloSEdpNXlzd2hsY0dvZUc4cUdxQUVHRk1qZUZ4?=
 =?utf-8?B?aHRkUm1BNVlkMm0waVRmZ2NvL1JBN2J5bWVvdVlmSngvbzR1aXdzUGd5ekU3?=
 =?utf-8?B?ak1kS29VRFBPTXBTdzRsdjhiUmlTcmZyeHRVcWE1c21RM0JCY1c2dStOalBK?=
 =?utf-8?B?aWF0VkQvUjBHOWxaamFJWEVoMzFRcUlReFIwS3B4RG11N0gwaVlodFkvM3ZI?=
 =?utf-8?B?WDAwVWlxRCsyMXNOeXc0WGJXUWdsNk1zNTBWenR5cnBUNVNvakRTMlhwYTZZ?=
 =?utf-8?B?MGxjQ2tDMkxiZEhZUmdpbytLWDhqdHVqVjQwS2ZnbkpLZ2lGcmQrVkJHV3Vw?=
 =?utf-8?B?dXlsaC9XOFpDZitWRnNHK2R4ODRIdTZlNmxUK09LbzdmclhFYldMeVFDQjRz?=
 =?utf-8?B?bHZPdzZoU1RDb3pZOFdVZzdRK0tJTWtDSE1sMElHSHh5SzZBd0dTUEV5cDNK?=
 =?utf-8?B?R0hTSGJ6ajFmTFhLN1VGZUwxU2dHbm9Rby9KR2hLSEVTeUxDWHhWaVBBU28y?=
 =?utf-8?B?MlU5YWt3V1poUVprdXI3a0ozcjZ1bDlJU1JjSjV5K0VFMEE5bHFJeGdPckRr?=
 =?utf-8?B?NG0rU0dXckJsbll4ekxDdERrMzRJQXUvWGhVN2k2VWJsamxma1U3bjV3MURQ?=
 =?utf-8?B?U3o5SURKYzdXT0JpM2t0L0FLdTk1Qm9BU1U1MU9OTjhPbnBDZ3dMZEFTTXBO?=
 =?utf-8?B?bTFmajdraWZ4d3piWDh3VVVEeGs4bnBwYk1GaGoySGlmWlRZWDBGQUFPMHIz?=
 =?utf-8?B?WjZOWkpNNW5GM1QzR2JnMHdvbmQrQTZMQXAwSklNSTNLcTVCclZPRWlzNjl0?=
 =?utf-8?B?TGt5bHNBeEpGamptalpUK0p0bjd3Mm9xd2tBYTBxa2M1Zm92ckQ0aFZlcVNz?=
 =?utf-8?B?MDg1UHJlNC95NEx2TERidFBMS1BER1h5NGlUNENXcnFKWUlpcDdTc205bitP?=
 =?utf-8?B?SUszUERhQ2l1Y1BRVUdVTGljTlBSRm5yUDl3N2gxWERzWkQwWTZXVTY2OVR3?=
 =?utf-8?B?WDBNR1JNT2tLODllWjJwNW11bUNUTHdCeDQ4a3FhOE93RFNaQkdkdmM0b1Rj?=
 =?utf-8?B?Y05UYnFCR1Y1MWl4ZFU3TnVaTGFYMDVyU1pLOVFTckhEanh3dWE1UDBCVTJj?=
 =?utf-8?B?ZnN2cU9Tc2VtS2NucGtiMDc3dWtNcjRvdzlpTEJVSVdBcVVOY3I4WDBpbzNR?=
 =?utf-8?B?bzc2QktSeHRTVEd5WkNJNEVzUW94WmJqbUNaMmZxWENtek92Y2xJbThmeUZv?=
 =?utf-8?B?UjlQUDJWb0dJMXhxU3kxRXNzSTdWWllNZUlkSDl3K1BZcVdNd2h6emNiZXI1?=
 =?utf-8?B?eXR3dGtHdzNkME10dmxudlk5ZVBlTDV5Z25xZGRlSlo3ajdCVlZrMFpvUTVI?=
 =?utf-8?B?a0FuYzVQOGMvVEhRRGVXQlRzNDlFakxXT1Bxd2I3VlZCS2pBemx3ZjVIUW11?=
 =?utf-8?B?dFoySXdFSEhWYUhzVHVLOHZpM3J5YlRtK3BZN0hWSVV0dmJQZUNaTmNnYUlv?=
 =?utf-8?B?WVlBa3E1M01mV2NiNDhrNENLN09vR002TWROWVlhdUkzYjlpMkdYOTRXb0Vo?=
 =?utf-8?Q?gM9zrG5sY+l0MCVbKkUd?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f4bd6-383c-4fd6-64b9-08ddded57adb
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:04:23.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5564


On 8/18/2025 10:36 PM, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>   arch/riscv/include/asm/csr.h |   3 +
>   arch/riscv/kernel/Makefile   |   1 +
>   arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>   drivers/acpi/riscv/cppc.c    |  17 ++--
>   drivers/perf/riscv_pmu.c     |  54 ++----------
>   5 files changed, 184 insertions(+), 56 deletions(-)
>   create mode 100644 arch/riscv/kernel/csr.c
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

