Return-Path: <linux-acpi+bounces-15823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1436B2B835
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 06:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288434E84D1
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 04:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CAE30F556;
	Tue, 19 Aug 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="hOK/fEWb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013075.outbound.protection.outlook.com [52.103.43.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BE26A1AF;
	Tue, 19 Aug 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576176; cv=fail; b=eGx62N+MVaLAZ7U3mnXnnBVjlukXGCfQWJMivD2cH3ONReR41WodEu3zmi0TGWUEOUlRM6BGjiN44IyFwKMFo0lULQ+UfSkYErAJhqF0E4mVw/Z3uRsdHbTZePG5ezyHXh7WvriThG0HpmhriTEiN1uF+P5tmcuBV0SmURv7+Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576176; c=relaxed/simple;
	bh=DDDL/CkeN0w5n8WlPY09YqWYrHEc6t/z6gjktUmX4a0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVfXZ61YZ0aGOBrLxuUEWGMuwdrRv4gW9c+Rfy/fP93np/fC0eCA4ipYJEBp2ZXtg8ZQJOJYnywmi0KcHhChcGEFKMEAvDJx5ratX1SBNgw3lPad/hpWBRBwjtRZYAnDbehg0/MMV3k+ek7J6aPCdixTauDyTIsUGKZsSP0ozZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hOK/fEWb; arc=fail smtp.client-ip=52.103.43.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F82rpXdea4u/DQNByh0wDRPkPbwQCWMqjCJPIKCnywbJ5QVxY/F01ISwedIvORArOopbENwzdITwIlZQo3wrVUgGg9dxNuicf4AekLNGYjKqn7xRhaHjeQ/OGerPBiqAiWfM/icXfXUpqsQ7bE5gRbbTkIGHnWlM8lwaoMDzyhHmNtcRma5CEH4j74ntc4odYsJDmPfNtY65ZrmNcxgifaQnbLABLU3KcPn82BUnefeLsQQgP8MgZNNGzsw9Mdr77c1gOR6mwHGV8JB0F47ZmvmvHwqv2QmzyYf9OXY9JE7BYrKON7VIJlstGvluebrL2HiHtZX/4EdWAF25gcI5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1VWeetUdQML93HGCdMCA9n1amHqC/d2BufQNg2d5bM=;
 b=qse8XfUGuZdrd5IqL6ZbyLRkxo44BwL0KHE6RPEtjKqQgQRpxvRsti4fduWl2lyFF8w9p8QlFrfEyQTtSf793M5BNXj2eeqazE78r7MebBeN+J96mdG66u1t6dftHyknrpI3ZWThKhgg7KeAygC17mgpa/cmIoIW80UOf4Ox8YMBzVRWlFNBeYCzq7chLwPEOuZu24iq77A7HVuqmXrcfzg1H5NGcFD5dugOgCNJoWwf/mPCaKylb2tnCJCE2rSgyebMfz1fizUO9cUd3m9czsTrKS4dp6sc1wJs/4GBZEXs6fdJTHhwA4xf6xXrf9kYZaqco2iW9n8KAxGJv86XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1VWeetUdQML93HGCdMCA9n1amHqC/d2BufQNg2d5bM=;
 b=hOK/fEWbJBmRf6f1tpquIgunV9xZjUp0nHl+Zc0HGlXq7s4wCEIjzu9wrL1HYU96KdVJYqcKIwkjgMj4iPZ4M2w4t4PJOZmDrT1kA9uG7ECfRHMIUg9tKl/mb+/XPB0QCouWm/WLfvTnGIx2AlhJmuT/AxQAGhNUVzo8qTzX8NHcfJo2uQhhSwI7fBw/iOexsgKwmt0A9YSty9+g9gsebRPyRODfdNUBkg/qLqECe3hgvydyNVFG2oW6DQfQCQoDHGYuPv2Jxy/r0+deFa5uJ/WwZxj3mlhK0S8whry7n/nLpmER3LSamnzrWNVe0ZHJqYe5ETpSfvnhfZnu2Wt0dQ==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by TY0PR02MB5480.apcprd02.prod.outlook.com (2603:1096:400:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 04:02:40 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 04:02:40 +0000
Message-ID:
 <TY1PPFCDFFFA68A465CE1E4154E78C65C32F330A@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Tue, 19 Aug 2025 12:02:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
To: Anup Patel <apatel@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Troy Mitchell <troy.mitchell@linux.dev>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-2-apatel@ventanamicro.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250818143600.894385-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0358.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::9) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <8957587a-2e94-4604-99c1-2660182a9d10@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|TY0PR02MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e5483c-4056-4e35-aa37-08ddded53d87
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|6090799003|41001999006|36102599003|19110799012|8060799015|15080799012|23021999003|3412199025|440099028|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJFa2FpbU04dXdheXZCcGZ4Ykt2YlVtZkNlL2pqNCt1aVR2THRGaUo4a3du?=
 =?utf-8?B?Ujc3U25UQ1NWNGR5bjFERVhjY0V6K21FekZwdWUwRklFaG1oUDdnMm56M3pt?=
 =?utf-8?B?WVdIU2hRZnVGN0NPc1dEN3dpMVFGRDIyZTQrT0lwcmZ5b3RyaEV4bnpxTDhX?=
 =?utf-8?B?N1RyOUUrNmIzOUhiTjA2V08yZjlwV2FOYUhXa0c0eUVlM3ZpWFBZaDRDRytw?=
 =?utf-8?B?bTlSamE2aXNCdGZETDBCRnFiUG5uSTZWTnhDYlZKYVNpUXNzb0FuTjA3S1Vw?=
 =?utf-8?B?MVZ3UHlvVzVPdnp2R3NVYjI2Uk5HQkYyRXlUL0t1OURHdlJyQzh3cmNVRUxp?=
 =?utf-8?B?d014SnQrc0V2ZnhqNmpXelpvcWtiakxLL1d0QitvWlFYRnpsU0hrTUJVR3BL?=
 =?utf-8?B?YVVkYXA2N3p3MUdkdlUwclZua1pPREczU0FrTTVOaWVDalRJaHNmdGgwYUdB?=
 =?utf-8?B?RUVXaWZsam4ySnRydXV0L2dFU1AvbGFQVW5ReUw2SUlBTHRzZGNyZ3hMNDRX?=
 =?utf-8?B?V2t0dFJiVXByZUx2SkpQODFrVmJYWWpYclU2K0ZFS3FsNWluMWtyVVdrTmdu?=
 =?utf-8?B?c3R3Z2dJRWU0ajZBNC84NDVqU2p1cVluSEhoZ0xYLzZPUmRxWXlXYngxZ0VS?=
 =?utf-8?B?SDN4ZGQrWEk4Z2ZkR2F1aW1qV3prR1MvOW5VMTZWU3lZdVRRblQxMkJOV2t0?=
 =?utf-8?B?TVBQUUZZa3BKdG5nSnhERkFORnFvR05Fd3pobG96Ymh3NjFLVm1hRVlXdlV3?=
 =?utf-8?B?TnVtVmVHNVdLYldzaE82S0JoenJxNkFHWjdjTmpOYVZRaFZ3SEdTdHA2bDFW?=
 =?utf-8?B?ZUczVHdUOENYVkdtVFB0d3Q3NTZ5TFNRYzE3OWFlT2kyVVA3RkJFSi9vODJE?=
 =?utf-8?B?QzVCeDVYTnpGRi8vVUo5cFgrUzh4Z2t6L3JHOTRGTVFMQ0U2dVk3S2krUm9J?=
 =?utf-8?B?cmdRWU16aVNaMVk1WWZHdlozY0N6bkhlOTlYRUVxeW1jS0lyeTZ4NnJYcDVt?=
 =?utf-8?B?Znl3VGpEcXhNdlZUZGdjdFBrYjdlU2c4YW01VnV5TEJvR1BHQXJKaDB6VS9w?=
 =?utf-8?B?UHcrenE0UkxEQlV1WUVpWHJsclg2RUVEV3JoQVFnZFo3RXoyNmZ6a0ZSUC8v?=
 =?utf-8?B?MG5ja2RJQ2d0cHJDUnhKNlpWOEpFSG45aVo3c0g3aU5XSmRzOGpVRXhKTmk2?=
 =?utf-8?B?OHBnaEVZV2dRQzV6R0RTejdyKzhaaDRack9rZWNkNXgyeG5lNCsxbG5YaERs?=
 =?utf-8?B?cjZFWXRFQmNheFV1ZDZ0RVg3M2ViZnd5bXk0OVdFeGo3anUwVExRemxiSjl3?=
 =?utf-8?B?ajlZLzUvRUJ6aVFBTW1GYWxKVlU0V1dTV3BqNUFnNERlYnBvaFk3a05KNkVC?=
 =?utf-8?B?dE81ZVNpYU1GeWxld21Kd0F2V1VWUGtHSWx6VWdlMFU2aklkdktOV2MvZVoz?=
 =?utf-8?B?cHZpSXA5dWpXUU9SamJjL2dsTlNqZ3RVMmpaWTY5Vk9VNnJFTEJqNzNRRDVL?=
 =?utf-8?B?cHlVWDhna0pRY2FGdE5EcjdncWlRNXlnYUxsVFlZU2QwZEJZQzNqTGludTg2?=
 =?utf-8?B?b3l1SzF6RmtMWEVYQnJtK1NIYmZzMDRxWlZCcjBzaHhXaE52NitWUnY2aUwz?=
 =?utf-8?B?UWQzbEszaE14Mm85dFN1OU5kUzQ2YTcwL1lDZVBPSzI5NkNrR2J5RTlIa3FL?=
 =?utf-8?B?MWREdEJIYnVSTHkvQzhpMG9sSTJqdW1EdDdrL1lMM0RjU3c0K1FpQjd3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0ZXdEJ4T1dib20zVHpjRGpYV0lZcWc2ckE0UDg0bEtlZVBmZ0sxanJQOXBU?=
 =?utf-8?B?ajFkNVFtSmZaaUh3d2xHTk9BajBhSndGTTdvWGUxVGc4RWVRV0xESFhHTG9K?=
 =?utf-8?B?R1ArN0NYY3hUUGNXNlJ0MHNLUWkrYTg4QjRUbHRrUVkveXJ5SC9xZE1xNms4?=
 =?utf-8?B?WDRLeHd1M3VoamFuR2h5UDBQWkN1L00rUnpaaG0wc05rQVBBdHlFSDdXRmpy?=
 =?utf-8?B?MytKSEpFY2h2ZVQ4NUN1VUFIcFp5aldrdHpCZkRQUVZPYjRseVpWRXNOdEJl?=
 =?utf-8?B?L1F2bXdtdXI4c2YyZitJb1M4Rmp5cWowdkVFU2U2aDlLZy9yZnJWRTFYS01l?=
 =?utf-8?B?akJPVDRwT1MxdHg4ZzJvNjhzeU8yVXNLRExFc0hlMlRpL0ptWWVpVjA2YlY0?=
 =?utf-8?B?SkJ1Y3YrbEdZcEovM2NYVmxKVnNMZC81YmsySUxSQUNRZUtrSDgyc0JBZFlQ?=
 =?utf-8?B?Wi90Vm5BM213cTJvdm1wcHdWNlIxZEFIVG1pZzBjd3lsUTNvb0xwZ3RmYlFt?=
 =?utf-8?B?U0lBTE1rSnFLTlc5dkJWODh1aDJsV2Z4QlFHMXlBeFlZL2dPeDl2dXlMUWN5?=
 =?utf-8?B?b280MndiZDFIeSs2SUhlRjVTVWtwUyt3b2lXWEF4WG95aHN1L0Ztd1lEL1c2?=
 =?utf-8?B?c1ljYTRoMDNseFZWM0Y2NXBqZ3lOc1J3czQrb2VRWWNKRm1SZDZzUFQ5T1hB?=
 =?utf-8?B?WmxiNmU4YnFoM1NQYnJlNDV2Q0RUYlJpRzBSU1lsT3FLdkRPYU9yT1BZa2JF?=
 =?utf-8?B?dFZpQ1ZiRk85RWE0Mmh3NTVtVlZ0TG1WVkNuMVhDakJGWS85eld6Z1lJYjVj?=
 =?utf-8?B?bGJCMUx6ck96WHlpdzZTRllpZFFHREJTMm1aWTlSYy9PZ0pVWUVtSFpEcHVu?=
 =?utf-8?B?YlFHY2p2dGdkWEFQY2VaTjF6a3NjZG9GV0FPUGZHWDUxRWw4dzNmTjJ3c3pw?=
 =?utf-8?B?elNRRFZNNHpzTGt3T1UweE5xYjVRR2xMdXNjNWZ5UFEyZEJjNUVsakltY003?=
 =?utf-8?B?WHJtK0U1c1ozUUVxamxHNE00Q3l1TmFjT0JwZzZiZ1NUNnBHbi83WlJLbmw0?=
 =?utf-8?B?OEpxalNScFZuei9LdWpoTkpMUkUzangrdThROXdwOGlTQzZ2L2tYTElsNnNr?=
 =?utf-8?B?U25GRGEwNnZkOTNNM3NWN0ZqVTZiR3o5OU4zNEVuUkJMNWtabms3V3VCcDRn?=
 =?utf-8?B?V3o3RGF0OFVsNlRpSkFkREVMUlViWWRkbWcwWUdxREo1cTZ5ZW9Ud3NhLy9n?=
 =?utf-8?B?Mk56Wm5mdkh3UlJWSHBCRHBGOGR4NTEzZW1aU1BTNE4vY2tXNGdndlh0bFFv?=
 =?utf-8?B?bVY3dnVibGcrR2FtdWh4UkpzbTV1RGdKaGdtbmhhZ3Z0U1BZT1hxY25zS095?=
 =?utf-8?B?ZzBnTjM4eFZhYktYOUlhR1JwQitSZkxUdVo1T0JCakFEUEQzVlBtWnhNaDBk?=
 =?utf-8?B?elJjWDNqOEU1ZVBFM3BLQXhLVHI1TWdGbWtlRXhTeEVHVytrMmthcHlzZUJB?=
 =?utf-8?B?Ty9VeVk4UFcxSHJkeXBJVmo0N3M0d0RadUtYamduTkJ5eG0rOGlFa2h6MHha?=
 =?utf-8?B?dDdEa3lnSjVpai9ZWnRZTUVSQ0ErZlRKOVI4VFJzVG9tbzJiVXhrNFhRYW5Q?=
 =?utf-8?B?bkwyTXJzbWNGVWNveHltRE1sTFhkWjRNRGQyVitWaUxvKzVLdEtyd1F3SERX?=
 =?utf-8?Q?jJfO+Cn5ZNlqusR4pyPb?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-c9a3c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e5483c-4056-4e35-aa37-08ddded53d87
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:02:40.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5480


On 8/18/2025 10:35 PM, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
>
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>   drivers/acpi/riscv/cppc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 440cf9fb91aa..42c1a9052470 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>   
>   		*val = data.ret.value;
>   
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>   	}
>   
>   	return -EINVAL;
> @@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>   
>   		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
>   
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>   	}
>   
>   	return -EINVAL;

