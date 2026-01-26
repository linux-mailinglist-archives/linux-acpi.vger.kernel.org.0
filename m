Return-Path: <linux-acpi+bounces-20626-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKsxLm2Td2n0iwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20626-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:16:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 162FA8A8F5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF6B30547D9
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87A2D9EC2;
	Mon, 26 Jan 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zp88GvYp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022114.outbound.protection.outlook.com [52.101.101.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC12DB7B4;
	Mon, 26 Jan 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443913; cv=fail; b=aVsmTl77YuikYLyB45k7UspPwaV5qnd5pn6ArJnRANwXlTrQCYKHyDdeBA8Ns8d8lHkjpB5yalljVE0/MsH4crLobGDnx2f+EZsSBvYTmlr7A4ZNX6prMWnC2LB9TuB53DEKFtb5BnYALQaGlzRFosXIYu/JppFGBQzj09IlKG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443913; c=relaxed/simple;
	bh=iv59j2SgYDEoAa8OqPbYRSuSkQgQ/T7ob45bKb+s2dw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=uF/hbTddJ4QgjDkNgUkR765AibkNhzan6C9TbewHv9FksdRePKVracFLwJaslhl+5i4Tg7yhSeFSaSFvjeup5YIQL1K8c1NZ4t2LEeVhoFrbSwy3oN0lLyPtd4ReJFKud6ZF4x6XYuFsTXGc7SfTu/8hVIE1b+weRO6Bt62VuaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zp88GvYp; arc=fail smtp.client-ip=52.101.101.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNJ+2w5iyIfzo1IILxKCxkeEmYgvNCZIz4kefojjbdHko5MHfdI2IKO2FVhfqXlRn+ujPdcTWYUDtyyQH3h1UzsCrDEjwS3Jzx8y6u+MD3ZiN9NPaotME41Lw2kE5E78iElny5u9vy1SP3eNG60tUeNmdOUWudE98ucFOHVdVRUj4Flu4xx3/kklAr4g9j30KkEAUo/fnBNjckOIVGrPRLDt+gHynz7bd1hTBO9qEOxaZZscK2RQv9HAnxmU4DP7U2wecrYahca4hUfkj2KPZ1zrA3IMPZrUDF9rkMEfA74QdfKUxS934EEIp87AYfzAdnR3bUKdCdv0q0sdnEKykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv59j2SgYDEoAa8OqPbYRSuSkQgQ/T7ob45bKb+s2dw=;
 b=oD0/o/H9v3c4xvUvf94XPg8QlrZrZav0TzThxPeiVCzD9L0PJyx2gjQuBrNPgVMCz1DV/2xIDZfcBdndO9GPG1qkEMDGCJlMzJF+PnaH1xPG6a7524sObpC2xx9NxFUrEPQxkwi4SIRJkST4KsUtu2AZ8hleaPcTDzW8k/S1ey73KdkS/OqhvcJYmMNGY3LWPG3aVups2F2Bwvi2rrposMrpGdkoBlM/PERp4oz4Y3tRDg2jWmVafkB/dMGkXKxVq0kSbUK4NSVSYqLzzCs1/MrPgAX2BJMPhsXNJM8kbjOXeuVWKw5+/3+cS386q/pbgM4X6Ax6Y3iRfqI3kYLdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv59j2SgYDEoAa8OqPbYRSuSkQgQ/T7ob45bKb+s2dw=;
 b=zp88GvYpV7ynFeU6h17qC4gSX+AvKhyclOZP4DwBjarOUIqOs2aE5xDOE5GRl01EjjlVakGKO2Zwn7mL92ch2kmicZhgyju1w14Cs/oaG0jbMg1SEKooKSCJ73T/FzQ94XqDH/HemMB9jFFqBAwYoDH8rljatJl+Fcn/bbR2uHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3268.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 16:11:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:11:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 16:11:48 +0000
Message-Id: <DFYNILJPAYJE.3CFM49W80ED4O@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Len Brown" <lenb@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
From: "Gary Guo" <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
 <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net> <aXdrUsrKVmzpBVd8@google.com>
 <DFYNFSOP2UVY.27KHATUQMCXHQ@kernel.org>
In-Reply-To: <DFYNFSOP2UVY.27KHATUQMCXHQ@kernel.org>
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3268:EE_
X-MS-Office365-Filtering-Correlation-Id: a826486f-8045-4af0-9b65-08de5cf59be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0FqdkE4S0RqWlVpbXE2WWpQeGNVMjErTC8xemlvN1VId1F0OXdCT2pHeDlj?=
 =?utf-8?B?VXZVUC9nYTVXOVdXZVAyZ3FFR1hwbkl1TWhlV0FndmxlSk9Qeks1NWQ5c1Fy?=
 =?utf-8?B?VEQzb0JPQnFnZWZmd0VLTm0yQzduQ25LVEZKbHFCbDUyanBSZzJIRlRSSjIz?=
 =?utf-8?B?QVhmK3lXdlBuQUdTZlRPUEIrUTZuMjMrU3Q5d1FST2FqaE5TQ3FXcC9EYUQv?=
 =?utf-8?B?bnl2Y1BYbCsyR3QxRGRBYVcvMUdzY0d2cWYwNjhMNjRiTHZXbE1TKzloa2Fk?=
 =?utf-8?B?WjR5UWNWUDZpRHRKOGh0VW9zRTZxZDBQSytZR2R4YS9QVVp4YWlHTGNBcVF2?=
 =?utf-8?B?OXRHbGtrN0d4NlNlNjNzL1ZIWkVuLzBmV21OZVJGOVp2YTY5QzlDR3dIcHNW?=
 =?utf-8?B?cjdYMk9CWk1KcFZMTnhSZjFrRlNSRXd0c2dXU0xWTGFjbG1jWUpDT1h6aTlj?=
 =?utf-8?B?QkptVWhqbXpKTTBXY0gwTWFRM0FWVFBka1k1SlVqZ2U2eTZaSHhMcUJsRXlh?=
 =?utf-8?B?eUxLWFRBb2Q5bkd5eE5XaW1FRVRlck5GTytWZFQzZU94ZU9UUVBwRjdQeU85?=
 =?utf-8?B?OEJodGFTYlJ3RFF2UEhNWWZ4Nk1SRHpvdCt3UzBldUp5ZjBGQkpQUEdBUEFM?=
 =?utf-8?B?Nk43aDhvN0VCTEgzRGxwNm9YaXoweFRuZWJrdUZ5elhsVnlMVE5vR2dQR1BW?=
 =?utf-8?B?YjBtdkhpUWVTQzNhWkpQVmNIMGZzR1IwNXhTNVlQSVVSTytpYjJDUjcrcUdI?=
 =?utf-8?B?djBYekhmRFVyZVJpUmhCVEM1bUU4NzNOZ1RRRHMreVg3Y05RYkJkeG9qVXJE?=
 =?utf-8?B?bkIxYVB2UmdhbWpIYTZKcWRXbkppa21neWw1aGFISmx0WVVUSkV5eHZaUkhR?=
 =?utf-8?B?R2xkdkZaOThwc2ErNUVRbytvS3FtQUxTRHBJOXdtWStYclpmWUprSVU1UzNv?=
 =?utf-8?B?VWFUbFFkYytvcVBCQ04zUkhrN1pTUDV3elJuWndFeDd3WG51cFFPL3JQTkZu?=
 =?utf-8?B?eVJycGpKb1JCT21JOUZFRmNkaDAyRmNXV2h0ajI0RldKMm81UkRTR09IMm5X?=
 =?utf-8?B?ZHMyNDVsM0FKOHRoZCtqNm1NS1RQRnplMTE2cUYwQlkraU0rbDlGM1hVb0NL?=
 =?utf-8?B?M2JRVFhZcVVyaFNsUDFmODdWcmhoSFJ0SDNDL0ZCbHp3ZFRUTnZlMFY1ZFBT?=
 =?utf-8?B?T2dDOFVwWFQ2RGdpZzk5SUxRakx0UFk2YVUwV05rU0hWQTQyLzRoVW95Vk5k?=
 =?utf-8?B?d0JOL0N5YnJYRXVidmVpQ3BNRzRNWkplaFN5Q0VnTkNjckFiUlgzSTFsbWdr?=
 =?utf-8?B?dVZMUS93OWVEem14dE5BOTJpbGZxOFA2aThuQ0NnZ05oVEpuVTdMckNyTVEv?=
 =?utf-8?B?Mmg0TEltYng5M21LZFJTcVBtdmszeWZNaUQrQXNTaGVMV0M3Qjd2bnFuZVVt?=
 =?utf-8?B?cUs0SHc3MXhIVFhqMUdJUnlFS2wyNStOUVRZdDg3MzNsa1R3ckpZcjRTU2tF?=
 =?utf-8?B?cUpwMGp0eFAyell2Vm1yM0pxSEJMK0FwVThDQUhqc242cHFKQitib3FlS0R4?=
 =?utf-8?B?SnNUYXVzelFYMVh2VWpFUi8wWThDMTltcUJ0ZE82K3JPa1g4Mm0rWkZhVm9J?=
 =?utf-8?B?RktERjJGZkhuSmFZT0F1L3hubHpZTktvZHdCK1Eyajd2RzZkLzZUQU42NmEv?=
 =?utf-8?B?bmFoU2RNUzRwOUhTSzhFT2o5N1hzNXJCK3B4K2xUTnh4MVFOK2Z5S2FCUWF5?=
 =?utf-8?B?K1JBTjcwRGxodEVmS3htQ1M4cWd1YVhCVkJBWUZLeXJrVnB6U1RXaFRGeFNV?=
 =?utf-8?B?eU1Fak1xMHlVUkdvOUwzclh5UUdtOGdLMGJ0aW9EeWNuaFpNMjRxR1ZleWRI?=
 =?utf-8?B?allJKzA3ZUZGZlduYXBaUHpYYVcxV0tieVY3Sk56UVFlcGkvd3U2b1RCU0Ey?=
 =?utf-8?B?ZVdFZHljS0hoTEYvc252UnVwalVWSWFabTdEa2lNdlgzSVBNNk5CZ1hvTXNT?=
 =?utf-8?B?VTdNcXdNaWYxWUt3cVE4ZytsZDNsaWhGclZ3bjVHNVkvK3pCRUhOZHJiejlK?=
 =?utf-8?B?L0FlVFQyUmxYNnV2NitCM3lwbHgyeS9UcVhHUlpNUVNoVHdFRnY4VlFWQSs0?=
 =?utf-8?Q?PKWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBydG91ck4xT3M3UUZXOE1yMHBmR0p4cDlqKzlOcmcrZmhNQ2hEc1ZIRTVG?=
 =?utf-8?B?aFVWNHVZYzZrUUtFRVZvZ0V6YUpOMFA3d0o0NzdGRW45UXczWGVIK1hwMW05?=
 =?utf-8?B?eXk5eUlUcVBJZVl3RXduY2tyWXBabjZDOXdvYTRnL291OWpDTFY4dyt1SDRk?=
 =?utf-8?B?bi9rWHhhcngwc0FsNXJrYWFKQ01IMEN3ZkQvUEFkZGtISEM1eFRKVjFiTEhK?=
 =?utf-8?B?UjhmekRmcW5JOVkzYk5TNmdMWDZ2Tis3Nm85S0F4a2F4YkhlWjh4Y0tQSXM1?=
 =?utf-8?B?TmpPaUEvbXpKcW5wY0RZc3d1SjFoTllHaTZma1RZT1p2Sit1NlVzeUFYNlFl?=
 =?utf-8?B?QkxSK250RnVaOGd5Z0QyN2hXaS9aSUZOQkNsckVvUGdlK1JqN0JBb2luUWlw?=
 =?utf-8?B?RjJZNFFpS20ranV5cmxMZmk0RjV6MXpCMWlodVYrMmsxejNVemV0ZnpNbm45?=
 =?utf-8?B?VWZYeHRJR0N6b3QrUnVoOXZ1WGE1bWNNbkt5SzZhQVRiK1JHVmhvMzVsb0Q3?=
 =?utf-8?B?aU44QjlJVEZ0amJmODZlcVdyLzlBMlFNQVZ2KzE3SFJJNXExenRSdkRYWG5U?=
 =?utf-8?B?T1c5OUVqSmE3aGxkLzlSTXlPZEpDSzhURk9ZVDA3MmVqeENsVE1Xc0ppRjlS?=
 =?utf-8?B?VlVDbGRHNXhUelV6NlB6eGlpRXNoRlRJL0RPL2F6VkRRM3NhYjlPOXFvSjVB?=
 =?utf-8?B?Q1I5VVFBK0Z2bittN1BKckJFYnJSN0QrRUNqVWF1YW54elRlWVlJdW5NQjhv?=
 =?utf-8?B?cDlVWjFYeGVvRVNGRVdldzltMUNkZWNuR1ZHakR3cnNERVBzREc4QVZEbGtD?=
 =?utf-8?B?a1pTdEI1QTJnTGo0dzBhMnBvbmZnYXlZZUtoYVFwVHd1dDF4RFluZU0zYy80?=
 =?utf-8?B?UUhTYkQzZTd2ZmxsaEUwb2JXZWhlWGZDKzRjazVXbVlWZlNJekk5L0MxaTlo?=
 =?utf-8?B?aHQ0Y2p0KzV6YjJGWjVEZDhtOFhrL2R0YUk0Uk0vS1hoYVE1R3JINTFiOXpG?=
 =?utf-8?B?cFBOSE5NMGQvRGZIS2pqMEFpUTJreGxENlBrWTZyY09ObFloRUMvNHVIengz?=
 =?utf-8?B?cHQ0cHczTEl6NktXL2lGZW9IZjBBZ0dQV0hBZExocHd0Yk9sMUdqZTFKWjZm?=
 =?utf-8?B?T0QvWmZzZTlHK1FUMXRnYVdBcHU5R01ERE5RLzhNc01KYmZRVGtQVHZDL1JD?=
 =?utf-8?B?cDVtdlBYZnBDYityVElZc05ibkFzSUs0bnhJeEEvNFJVNXcyUDdFZkkrMHpB?=
 =?utf-8?B?T1FYSTVYTFdEUVZ6R1FMNWJaUFBGWkVRZGxUdjRzSnJKNkdUM3lRQ3JsVGM4?=
 =?utf-8?B?M2pOa0xuWmJXZCtONW4zN0hpQ0d2YjRNclJLdVhWY3RjQVoyK3hISHBJUEZq?=
 =?utf-8?B?NU9VUlVYY0R5T3luQzZhelUvTWtjeXk4RFBKU2pCN3NFTUxCVW1LT091RUdi?=
 =?utf-8?B?TUZFaHRMQUdmVXIzSHpVMkFOUUgrdThBVW5WUDRnc0hreEdkMkxGRk4ySTRG?=
 =?utf-8?B?TnUya3hLQkdxT1NQcVBNN1RMdVhPREZTaFNwWm5jaDRJcHFTdEFrZm5Venl6?=
 =?utf-8?B?OUwwYVA5N2V3T3dScHNaaDZmVTJvS0QwdzJQc1l6Ny9hb0haK0ZKQVpFL1h1?=
 =?utf-8?B?bE0wdmtFc2Z1SlJRbHdOaUhxLzBNeCtsZE9ENHhGWlN5QW11M0ZISEd2UENn?=
 =?utf-8?B?R1ViVk84WE9ta1AzNTJhUjk0N1k4enhOcFloSTVyZmlzQWFHYVZEOFNmTVM3?=
 =?utf-8?B?VzA5VXo2VTBwczRqTEZSV25KN1pBVmV5bFQyV1oweUpEanc4Q1RFR0h3NFZU?=
 =?utf-8?B?VWNHcTJwQXp1eGprOHZhbUJaWXBPQlRlc0VYc0VNTzRJR2J0TVh0ZnBaL2Na?=
 =?utf-8?B?amNCdVpidUF2czQyQ3ltUHVtWHBia3hkOGd4NkJ1cUl0Qy9GY0NWZU9vcUpZ?=
 =?utf-8?B?eDVjbkZDWGpNWU5CU3UwWitHRDNUNnF5blBiTHAzVXVLSjh6UjBRYmNNeXhP?=
 =?utf-8?B?VDNBOXRBZDhraStUTDVrbFBnQmRSTG9QVHhRVDYzTXVlQ0RWaUYxZnRWeEpy?=
 =?utf-8?B?RWJ0Uy8xRXg0MW4xU0xVVGVSZ0xFNVAwSjRaZEZEc1lIWXF2bXBrTUUyTzNP?=
 =?utf-8?B?WHZxaWhONmpxUVlrRW1MeEVFZ09PeDlmWnhGMkRaLzZKR1djUmRvaG5TZGFk?=
 =?utf-8?B?NVlCK2xMVzNBMWw0MlBYYXMrVG5kUEpGcjMrV2JpUWgwV21mVHBQSXVZaTI1?=
 =?utf-8?B?UDQ5L3MrRGt6SUR3Q0Q0bCs5b1BITTV3K2dEaDZ1T3pWdHpuTHRPK1dBaWNh?=
 =?utf-8?B?VmtWZTlOYTVSUjhXWlpLbEtMcndoVWVtb245T2VqTDQybi9CVVNyZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a826486f-8045-4af0-9b65-08de5cf59be4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:11:48.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4T8ayC7xsAjFry95Nhy8sXZ2Qq3IYMUVacE1chMpqAFzLDmvDfVwG5E4RpwnyMughf8f5FSCk+YNFfxpSSPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20626-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,linaro.org,collabora.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 162FA8A8F5
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 4:08 PM GMT, Benno Lossin wrote:
> On Mon Jan 26, 2026 at 2:25 PM CET, Alice Ryhl wrote:
>> On Mon, Jan 26, 2026 at 01:15:53PM +0000, Gary Guo wrote:
>>> On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
>>> > Currently, the Zeroable trait is defined by pin-init because pin-init
>>> > happens to use the trait. However, zeroed types are useful for many
>>> > purposes other than pin-init. Also, we wish to implement Zeroable for
>>> > types generated by bindgen. For both of these reasons, re-export
>>> > Zeroable from the ffi crate, which is a already dependency of the cra=
tes
>>> > with bindgen output.
>>>=20
>>> I don't see a benefit of re-exporting these from the `ffi` crate? Espec=
ially
>>> that we re-export `ffi` crate from kernel crate anyway, and `Zeroable` =
is
>>> already in the kernel prelude.
>>>=20
>>> We already derive `Zeroable` for bindgen via `MaybeZeroable` derive in
>>> rust/bindgen_parameters.
>>
>> I can't find the convo now, but this change is on my list from when we
>> discussed also implementing FromBytes / IntoBytes for the bindings
>> types. To do that, we need to move our FromBytes / IntoBytes traits
>> somewhere that bindings/uapi can access, and we agreed that the ffi
>> crate was a good place for it.
>>
>> And then for consistency, also reexport Zeroable from the same location.
>
> I think you also mentioned at some point that using `pin_init` from
> `bindings` seemed strange and also using the `pin_init::zeroed()`
> function also doesn't fit, since it doesn't have to do with pinned
> initialization.

Shouldn't it be that a crate that implements Zeroable / FromBytes / IntoByt=
es
and then pin_init becoming an user of that crate, then?

Best,
Gary

