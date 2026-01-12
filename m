Return-Path: <linux-acpi+bounces-20178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6AD1148E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 09:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5291B3002D13
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B9342C80;
	Mon, 12 Jan 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHkazIcw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90816342529;
	Mon, 12 Jan 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207392; cv=fail; b=UpL5Af+x+qwXuC2Op/miKKCZfW2FF/OKOUnqrXm2clQOlWl+P6cDzVH8WuxW30G1VpexPb5pbaWL2tlThz49c+Ml6CTlsyatUTaZ/xlbiimHeINoxJe5olK8qJSOs+ZFHKtacSXcOguLZU4hWmOUzQm32syYUSyQQAXB1t11iaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207392; c=relaxed/simple;
	bh=dLXWdY1cNy62OslDBQjmEX0R7OUy5+PsyE4ZRkv+DBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PY5mfAqK/gUQPIXAcUbk2XdwOJ4l1yJpVzg+IYwyweVn1WXWd51X8MTefDyr/pK4+bamM7lGgmoXAaZiVXrZ4WAdJqvJdLv+rD9yIEzTJI823Lrw+ohU2YuEc7zJdsSt8HG43lpEbd9DpGqnloTtOHG6g3+D0MCU8Yg4BGWGHbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHkazIcw; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnmES+glrQofurvtFZy3DdPtLMRIZmrr34+cW1el3pq2N5ZwvLRPz0fS0BBR+e4kRS0VT7328NYM0QOpy/+P4tq5xmQJzMvMvzYAY6WZTJEbPjWsxmeh4EsgEkSTz/LHiIvqMAVN9ULXbod2U8JwBHGVCjJdftweoNo02QZznOZt0O+SYvwUBHEWgaLstj8NmoOAAAlIZfxYymrUHnIFXecsAy3WSnF9C9K/RvZz6Z+dCwiOkR3kDPb3QbPJK45RueVfc4RpzLGIs8Gr946t7T4ryv6oACO4bUcLtCv06FgpCF0qd3SpJVBYVzzkuuPJVuoQ+005Kp35GoAmcmw/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHEdLe6DIXNLDYZ1WdKvjL3t8cVB/ZK0Xh4mTEBQ5+A=;
 b=DkqSvtU6VhsAegytebdaM+SlAM0ZSoVJCnQknOfdZQpGxdQr8YdRrvnb8HB7SUvcngsxIPvIe6JDQdpg0Y2TalC3GO87MoxPfMFehb5W1yphs/F5hCAmdxoFBeu6+FBUMtpLMcktN/rbDSo7JgT/NYjw1qrSBC0RohwhbhMO1haHDi6q8fzP0Xd0k7Ckac6hTG4TPqBYoN4wcYU1nSfU07d8HZ018vy80lMjfZGdsj29R1SGzmg5T7uF239p0CwXf/T5X9v+I8y6KmbXXvcaNt4op97z5Rx0ZhnwDzmrcUlHpZeIGR4teusnRA6O/nVkxn7/P8lhAWd8ryFWOAinOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHEdLe6DIXNLDYZ1WdKvjL3t8cVB/ZK0Xh4mTEBQ5+A=;
 b=cHkazIcwv+m3xggSFZByuimpFYC3bATLrW7DXuuJ6CMW5P9+vdYbgMF4I8k4hlTwqPUqKzO70eysbpfrzt9KnEoNnEFSb5kAyIG5rE/YfdF0KtSGWDnt1kdUxTWtNu3o8cFdPxAKMK7qbpfS1f+GAlh/oqoPQ47MeNyHoaJIBCrt9KW9w4bW1W23wkTNlOtj89yjO+gKpA5zZnL86wGt9sTEupmsc/JikkxnexptsexkHuhKXnzVRjS2fL5sVuJoW+sM2PgSJW2k6kzJelROvlLGpjwoGinQxv2Tq8/AavYboM7VnZ6tOTTHyBBHq4do+5TCGsGMiQjSUettvfvoSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:43:07 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:43:07 +0000
Message-ID: <377fbbc3-5f79-424a-b986-4617048e5e3c@nvidia.com>
Date: Mon, 12 Jan 2026 14:12:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, lenb@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com> <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
 <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
 <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
 <aWQdz37vK-SXVQBv@kekkonen.localdomain>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <aWQdz37vK-SXVQBv@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: f1181785-7ca1-41b4-b208-08de51b69bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWVBajVUcDhNNEJ0b1ArQldZdzlhTEMzWHJEaDNMcitiN3pDdGNiMjhUd3F1?=
 =?utf-8?B?SGk4VisxcDdnbkU1SEhVYm5XQXJKdzIzZHRXYXhYcldFSGx3WGRnRDBXY0ZW?=
 =?utf-8?B?NnNRWWVyMWc3RWY2cVlUclpEOUdNTkVHS0lkM1lKbFVFSXlBSkdhc0ZKdkdJ?=
 =?utf-8?B?dzJzWXpodHdrMmFNUFpzdWIyait1NUV3UnVYempCelAvUVBScU5VMDdlU2Fp?=
 =?utf-8?B?TTNkZW40KzRHcStYbms5NU80QlNSaHU4TjdwZ1RYN2ZGR1YwaS9RY1lPUzFt?=
 =?utf-8?B?L0lrZnZZSHFibm9PME1ZanRZSlJSWi9WdW16NkhQYkhZWVBONGgyOHBnaUUr?=
 =?utf-8?B?VXpzOWtUUStaWDlWbGxEd1FPVnM2cVpuQjU2NUMrc3ZFbUFRUXpQbHViSmFH?=
 =?utf-8?B?bG5UTEZBVTBqendGbEpvN0J3cTd4Slo2QTJBTHljWW9ERlA0V015TFB6VHBn?=
 =?utf-8?B?bjAwWEJqdmZ0Y0djSHBhWElpa2l5TlB4VHRsZ3Vva1hCTDJIWHpCQmdXU01E?=
 =?utf-8?B?bFBXUUhuQTNNVFZRRUdLazlqcFM0eGtGTzkrSTJQYm93NEtma3lSOXFZUzlG?=
 =?utf-8?B?MWVWZDJnRFBqR0hsdnRuYlp0bUdNM1lXR0JyZmdxSmNYZ2dEWXE1Smg2Nmo4?=
 =?utf-8?B?bFVIejNUQS8xbVpEeWJ0N3BCcXhuMDdiSnN2anMyN2h2UzJwNExUM0J2UG1j?=
 =?utf-8?B?ZXd6Vnh5TnF6Vnh2OXV1RWtHM09qVmZuQjhsbXhCUXZYbDFmUFRPa2ttK1Vt?=
 =?utf-8?B?ZnVUa2o2akw2TFh5L2xOWGYrQXEyTWd3UnlZYUJBQS9GUDZNNVE2T2tCczVN?=
 =?utf-8?B?RFVBK1FZWFZyVE81M3hnRWs4dENmQXhiNDNsWEx2TEtralNBdGwzaGVlckFC?=
 =?utf-8?B?dlBrNWd3WTk2alFHd0RQSkpBQ0I2eFJGeEhkaDJIdzZIQWluYllnd0FQdG5H?=
 =?utf-8?B?K2JDbU0rekkraVVjVW5hYUh1Tm4rSTVhR0x4bzZncnBMTVpRVTBvaVhjc01t?=
 =?utf-8?B?MkkyMVJ0VzdKZXp1UTVrNTRUa1RiNy8ybXZGV3JUUkE2aTlCZytUcWZGYUIx?=
 =?utf-8?B?YTZLbm1tVmh3UUlzZDdRNW16NVdNZjc0cUoxN2h6QkthZ1Rlcmo5Y0R4VHhS?=
 =?utf-8?B?TkFmSnkvdUkxRXZxYlFuNzBONjFWRWVsSXFHZFYvUHl4eWd2RExEN2Z5dEtr?=
 =?utf-8?B?aFdzOHpja2ZuWUxOSFkzRmhrY3lrMTlMRE42WlVsa0pVRnhmN0l5b0NzV2NL?=
 =?utf-8?B?K2ZpQ3ZLM3d3NEMxZWp0TzV5VEVJbDFjMGwyL3Q5QXAvYWg3ajl6cllXMjJL?=
 =?utf-8?B?L1Byam5qZVBXZVJJakxYSjI3TFNndTkwd1Q1OGliNmtrSncxbFMwT2RpMEJJ?=
 =?utf-8?B?cGVYRzE2cyt3dG1sYlVyTU94S0N2R21qYVh0S3UrWGRIQnptVlJKbFFycElI?=
 =?utf-8?B?d3BmQ3M1djFIeG5PcnB6ek8zU25VdnZTbTNPUkYwMlYwMTAwNG4ycFJ6aExw?=
 =?utf-8?B?THZOVVcxZGh4NXBlUmhNN3FwbUlDQis0NTQ4b29iQ1kxSDRrbmdqNmlSTy9n?=
 =?utf-8?B?aEc1Yk55dlRoN0Y4YUNOcFQrb1psTWtFT1UxM05yWGZhNUJabHVySnkvUWNq?=
 =?utf-8?B?U1R0QjlPc1NnMnU3cGF3UkxSVVQ0NCtPWGNNWEJiZmU3eVFnOUZHbnpnSWFZ?=
 =?utf-8?B?aHJqSjVRWnVJTDNmMWxuelRPaTF0clJBMk9WaHlzdlpYclBBQlRHbDc1N0Ri?=
 =?utf-8?B?VFdLU0N4ZHdtK05rekV0YWM0S3c4ZXlTbDUvQ3hWZXhYZFAwRXp0ZWg2dXBC?=
 =?utf-8?B?N0kyOFNIVGk5T2Rpa2xyN2xZSVhHNU1rOWh6MndpMldHSkl3TnRlaXZOOWJi?=
 =?utf-8?B?dnIrdTI5MUNHZXR3WVlvUkk2TFc4T1pvNUZTU2RtSksxc1gyejZlZmdMa012?=
 =?utf-8?Q?Zx3ufaM49vXsAMfqQ3eRMHl5uiNTc0vm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3IzSUdIazdxZnFGUjNWNklTVnlsMloxaTFkajNVRExaQWpqZGh4cFIxd1ZS?=
 =?utf-8?B?TTYyQXAweEVPR0kzQmt5SS9JQjdJVFdYWDBQd29POGd6bTlhNXVPblBaWWg2?=
 =?utf-8?B?M2dSK1dQQzlYdGdpRWRFMDBHRHVtbjB0TVZHN0hCZklEWFlIMlltUUpLYjZP?=
 =?utf-8?B?SFhYN1FRdW85MTAwbUYwRzFIc3YwNEErMzFlVVBsSkFBZlNkTVFPMUxWaXFP?=
 =?utf-8?B?NmZhZXI4MzFESGgrMUI5TXdXRSs4MjVYUm01MHh6UUhYOXlzMGxmajJHeng4?=
 =?utf-8?B?eFVzeklCT005WVI5UzhrY3BBWHZGU3N6WjlDd2h6TDNCUUNlNXV6MU04Mlh2?=
 =?utf-8?B?Y1ZGNU5yRzZVWVZGMzExK1pzaG1JR0x2N1FWQ0hUT3B4QUtPSWxzVEptNm02?=
 =?utf-8?B?OENkQk11K0pLKzVXL1JvK2dqa0x5ZnJiejQ0K0srUDRqd3dyU25qUGhaZUh3?=
 =?utf-8?B?ODVPUmk3bHZ4UnJldlM2NGdJUWhhSnBxaXhZYm9wZWs5VWg1OG5XUUVFeDl4?=
 =?utf-8?B?QnArWGNiLy9SMXZtTXpSbWczaGlWZ3NMdXRnZDR6Ymtjd3NjZHpaWTJ3eGdR?=
 =?utf-8?B?V3Z4RTlobU9VMnhxaG5sUVZ6RGlRMFlGcU1ORkFRb2R0R2dGTUxWbW1JZmJD?=
 =?utf-8?B?SDdBamhRS1hoOVlBYkFsZ2cwcEsvMW1lQkFQOVZ3bHAvQnJ4TEdiMjRrNEdY?=
 =?utf-8?B?UGNqSXRSaXhzaVE5N0I2VU5FYk5mekl5VFpEckdQRUhJVkFwaXVxUmJLUzN6?=
 =?utf-8?B?RkZnMENkblpUT3Npb3BPNVRCL1Q5Q3M3MmtScjE1Vk0yUE90bEQ4dFVUZ01R?=
 =?utf-8?B?THo1dGtleWVNcEY0TGJ5U2F5RklpV01ReEdBemxjQW8vN21RdC84cWQ5UWxT?=
 =?utf-8?B?YXpjdytxNy9Qbno4ZUZ3Y25zOVNWTVhaaDRHdHpwdTU4ZVV0MDZ2VnVJaEd2?=
 =?utf-8?B?TFY1TEZyTDlmUkNVTzZTbHF1WE5ybnhNMy8rSzdHU0VpbXBKalJWT3Vhampy?=
 =?utf-8?B?cktWV0hrVTlENnR0M09ZU2E5dWNSaTczS2JBTGUxckU3K2xVL3pyOUdUaVN4?=
 =?utf-8?B?ZTZkNS93R0NLRzd0K1c0b3FleFlOcXdFWGltVENEcEdib3pyK2ZEanhwMHhE?=
 =?utf-8?B?Q3lpeHE2cFlkcVhtT0ZWS1NNOXV4SmlUa04xYjljdkcycjYraFFGTEpXblNO?=
 =?utf-8?B?WENwU2VXdXZEbUYwYXBFT0ZyWjl0bFFKQjBSOFgrbVZOT2lpM3EvRlpkaEZk?=
 =?utf-8?B?RXI5Tk5UV1I5STNSemRhdjZYSGNiOVN4bStaOGQ4QUxwazBkQkoweEVaWFJN?=
 =?utf-8?B?eHRDZ2YwTk5WNGNOUUV0U2JBV2JLUTBoWjlYQ0RzdTZvVDhRd2hScmt2NlN2?=
 =?utf-8?B?ZHFYcVRzUXNKazQwek9TVlBkOENZSklBZkF4amlMbUk0QkpWaU1xaGdyVFhO?=
 =?utf-8?B?S3d6SHFIUlh1RjhybVE1UFZNQUlwZm1uM0xKYjFxY2Q2QWZOUmRSenBpWnhQ?=
 =?utf-8?B?M0pvU20zY3dWT0dJd3F0QkFQVmpMM0xrSTRyRDh6WTNzODc2WUN2OG5PbERp?=
 =?utf-8?B?VDlyYWxYQnl3NzY1UFg3Mks0OWNBSTJqYkRyTEdodGNkYWo5T1V0LzlSSFV4?=
 =?utf-8?B?QlNYNFdUc2wxTi9Eb2VRYW5TUERaK0MvN3crZ3NUWFdSVm55UTUyYkVrUU5p?=
 =?utf-8?B?YVNrMFVLRkNobU8zWDRHRmF4Qjc3WWoyeWFFcSsvQ1RDTk1WVXBhWFBKNHZK?=
 =?utf-8?B?MmlQRDIwbTQ0OXQ1V3B0TVd5aHROalZFUU01NjBtc1BlUUNKWUVIQmJWbGNz?=
 =?utf-8?B?b25NblliakZvelc0RkV4NEpaaEVsYnlLek9sSjY0Y0p2YXRPZWZQSHZLZlFn?=
 =?utf-8?B?bFYzVjdTSWJnZWVxZ1JCZlRTZllYaTY5UmozM0xFUHIwb2tHeTVvY2I4SmY5?=
 =?utf-8?B?NUJ0b3RJd0VYZFV0L3Z5OFlCZ2F0T0J5dnFUK1lqWUJvZ1ZRRjdRcFJpV0gv?=
 =?utf-8?B?enQzdFdIbzM5VUdqaWpNOXFTdnp0ZytXNFk0MFV0ZUtodXVrT1FlSWlQbjk3?=
 =?utf-8?B?SHZ3SmRZTm8wWWFNL0FaMXZRVDNVZlNFQTBScVBQQm9vZWVQYnFjRENvdkcr?=
 =?utf-8?B?WmRhVnNYT1VDeU5kQTRwZ09MZU1ualVhdHRGcVN6ZTB5U0FWcEtEUEdaNjls?=
 =?utf-8?B?c2xJVWY0THUrVElmYXdDemNCSVFlVDBOWmdQcVpNNGxXWVFMa2t2ZXJTeUph?=
 =?utf-8?B?VTYrQ3lTUEtvNWVOTXR1a0dhR3JzZlVyRnJYRktJWDZHd0tKMzZkaWlWMmE0?=
 =?utf-8?B?N1lmN2NFajdRU21QVk1tSmVBazlpUm5QMU9MNmxwOGtIcHpjV3J3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1181785-7ca1-41b4-b208-08de51b69bd4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:43:07.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+OR0NgX4F0mo78K2lH1oa88A91+l57ad8Kot0ejgPBposCiQhtNV9ekYaNDITNA6LhDxV0VBrKCFjqWBngWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471

On 12/01/26 03:31, Sakari Ailus wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Rafael, Andy,
> 
> On Fri, Jan 09, 2026 at 10:11:26PM +0100, Rafael J. Wysocki wrote:
>> On Fri, Jan 9, 2026 at 6:02 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> On Fri, Jan 09, 2026 at 01:29:59PM +0200, Sakari Ailus wrote:
>>>> On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
>>>>> On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
>>>>>> On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
>>>>>>> During pre-production development, drivers may provide both ACPI and OF
>>>>>>> match tables while a formal ACPI HID for the device is not yet
>>>>>>> allocated. Such devices are enumerated via PRP0001. In this case,
>>>>>>> acpi_device_get_match_data() consults only the driver’s ACPI match table
>>>>>>> and returns NULL, even though the device was successfully matched via
>>>>>>> PRP0001.
>>>>>>>
>>>>>>> This behavior also risks breaking existing PRP0001 setups if a driver
>>>>>>> later gains an ACPI HID, as the presence of an ACPI match table changes
>>>>>>> the match-data lookup path.
>>>>>>>
>>>>>>> Explicitly detect PRP0001 and fetch match data from the driver's
>>>>>>> OF match table via acpi_of_device_get_match_data().
>>>
>>> ...
>>>
>>>>>>>          const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>>>>>>> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>>>>>>>          const struct acpi_device_id *match;
>>>>>>>
>>>>>>> -       if (!acpi_ids)
>>>>>>> +       if (!adev)
>>>>>>> +               return NULL;
>>>>>>> +
>>>>>>> +       if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
>>>>>>>                  return acpi_of_device_get_match_data(dev);
>>>>>
>>>>> On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
>>>>> possible that some device may have HID "blablabla" and CID PRP0001, I don't
>>>>> remember what documentation says about this case, though.
>>>>
>>>> According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 is
>>>> also valid for _CID. So yes, I think this should be checked as well -- I'd
>>>> loop over the &device->pnp.ids list.
>>>
>>> Yeah, but if we have a device with
>>>
>>> HID "blablabla"
>>> CID "PRP0001"
>>>
>>> and at the same time the driver has ACPI ID listed, we should probably use that
>>> one as HID should have higher weight for matching. Logic here is not just as simple
>>> as looping over pnp.ids how I see it.
>>
>> Right.
>>
>> What about:
>>
>> if (acpi_ids) {
>>         match = acpi_match_device(acpi_ids, dev);
>>         if (match)
>>                 return (const void *)match->driver_data;
>> }
>> return acpi_of_device_get_match_data(dev);
> 
> That would mean that any ACPI (or PNP) ID has priority over compatible
> matching, wouldn't it? AFAIU the documentation says effectively that
> _HID/_CID priority is upheld, whether matching with PRP0001 or without.
> 
> --
> Regards,
> 
> Sakari Ailus


Hi Rafael, Sakari, Andy,

Since we seem to be using __acpi_match_device() match the device.
What if we directly utilise __acpi_match_device() here?

Something like:

	if (!__acpi_match_device(adev, acpi_ids, of_ids, &acpi_id, &of_id))
		return NULL;

	if (acpi_id)
		return (const void *)acpi_id->driver_data;

	if (of_id)
		return of_id->data;

	return NULL;

Then, we can also remove acpi_of_device_get_match_data()?

Thanks,
Kartik

