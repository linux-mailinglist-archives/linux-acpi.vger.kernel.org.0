Return-Path: <linux-acpi+bounces-20537-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC1YOSURcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20537-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:59:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A1D66506
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE53ABA9F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4B426D37;
	Thu, 22 Jan 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wha1JTQ3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wha1JTQ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBB34B1AC;
	Thu, 22 Jan 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081486; cv=fail; b=RJEtPwbdTeehUhcNyhckWx4JntmGo62bJZFywgEPpZO9/CJcGjPypQgZ8ykTgNMXY0hj1pUnH/26y4wu9SWKzg1nl5Igwh8jclgRejnA0f+0ikMM9P7qLKzRjP/k0uJDKQMUlLVyetWlLcvjyj6DxTuchMkpU2jscDjVc2euu98=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081486; c=relaxed/simple;
	bh=U8eE/Y6ynWFxSqmKUiW4BbnUBuG33siHLUamXX6aQSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gvh4W/86Vha3R3dXtUVTLN7O615KD6OAp447c/kKvP7AG19xwjZfHhjfbE0WV1h9sz1ioScGdV3L6F/r6R/ipMvzH25SC38Qv5zgbyv9vaPIklwiQy8cYwRXnLQFun2NkRJqnbtSFq+3XPk32VbU8cApNFJFf6M0k6LhfquLyGc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wha1JTQ3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wha1JTQ3; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qZaPWfKkU0IxOImVztMFE0Xfbi/gTP4jjsrTUyxikssAFKtSJSJQRlnpglk+0ylMapqUjN69J82pAkhOkEH1HPNvNUDOm1/E0TGK9ExtEg45Dc9axm9erBTNOxyFed3YMVsoHgcLn+BEZFgrnwfgmrsITJSuN33BJSW/rYqZInjoyzDHDNuMNwhoU/DbHDh+UdPgtpvtIApNo8ns9Dvmo+ubMETvaaIutWj8p7V+d/JLelATigOrNiwASqvL8LQKFOZdFbVJD9w4vWqydKSDa32JgzfgBxW2wC5hFnOPIWA8LMkyDdSqw2pDVU2wdVhvN4nstOKFEDgB4iTwrfp7Vg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9AvdHT5721FjOHp9HF/y8JE3N/ke03f5N3QhOr6bQw=;
 b=mxbSPRywrPjClSa6ystP1E/6tdmpLlUKSDY7M+V0a9DWAiFjLYaAw/YJGf7U59YTgB6NnkyE3YFFIx+XrVMj/bPqacv1P40/l+dCp2Tg07Tpw048KRrMWHumWfXaeC3maRqswTlF0Gf4gggvWG8fTSxgl2xVsvtnGcYR2WrINDnCV91qa31aHFRmnEW8zoAUFC3bb59MoPStz3IREsXRvY38pYwt+BDLX8Cv1FuHYOjoSvYssoDtGE8MT9eMJx3AvbsCqJzt1JUuQRVip8mhv7ujuRolWcd/iucrHIryfFsuK1bFK94YcS6yBVdlehEgen6Yxzk/AwLIV6KAqZEzCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9AvdHT5721FjOHp9HF/y8JE3N/ke03f5N3QhOr6bQw=;
 b=Wha1JTQ3nBen8nXMbuQGK7JrIEymYEbhOfr6B+WpdxtrzuXspecUrO3p1NJIwOv46lIQJUlLnPeO3aqkEu18Ka0zxObnTyJGydC9yw6Tmk+0xvirw1dEbAOgmDLsAZVOeTlP8QSl2qiAUzTBZOlGIQtnSKBP4H1T5jZkjmrKANs=
Received: from CWLP123CA0262.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::9)
 by AS8PR08MB8828.eurprd08.prod.outlook.com (2603:10a6:20b:5b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:31:12 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::1) by CWLP123CA0262.outlook.office365.com
 (2603:10a6:400:1d5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 11:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Thu, 22 Jan 2026 11:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXiArNseEN8YbkNQz0FsC3YhuSvYF9k2jxDhrPW+/jq2k5UK2YDdfW3QGnsKo6rbgL2vcte3XyRgv29uZl1RQGpDa8juncJnaFXGKjYvxS7neNRCFlVZJzgMFihevViy0VLrMMYwJwkKd4wHJGlVZKjeeC2XCTBxLoWkLtoDTAofJeIUWiRs60uohu3M7YCi2DLIPWfr5v3PIrQx0xP9vfbl8gfxU/14iUK78Z0R1+icJb8sSiaYhi0z6dEKb69xso4lfxpCdHU6W3WM1dop7pT7byA9CnQx336ICb7JSw+CjsJ6IF8v8B/E0xmMw1q0P8anNL6LHajBDdGu7EYxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9AvdHT5721FjOHp9HF/y8JE3N/ke03f5N3QhOr6bQw=;
 b=PEjhdZ+aTJPOrWMXcFDfQHE0OBp8J7xbvmx3uEaF5T0qA1GIryVTBPEbfqujOeP2suYin+97v0w7MKmmbVOiabIzOMqPh5/BFXOjpOe9/5TKe4aUa2AoNJb4LzIt3orBn8VnKMH1qrQpddDYD/OtXl1BJXjfiO4RdhSI0n1EgLDuk9VgiibHrirnKmjjYzQkKLO5Kj4KKidAGS0Wy+i1/C8O8ab2fkRzBkU0T5l4H3bl5M5GonUwLY2RYQcaJ4uq7kz3Odp6iPxardcnVQgc3g/TxfyhCMEJw/vRrMNHzvJ3ERcoY5Td0BsXExC/ELuEOR+iUdCsmirL95AMHGsgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9AvdHT5721FjOHp9HF/y8JE3N/ke03f5N3QhOr6bQw=;
 b=Wha1JTQ3nBen8nXMbuQGK7JrIEymYEbhOfr6B+WpdxtrzuXspecUrO3p1NJIwOv46lIQJUlLnPeO3aqkEu18Ka0zxObnTyJGydC9yw6Tmk+0xvirw1dEbAOgmDLsAZVOeTlP8QSl2qiAUzTBZOlGIQtnSKBP4H1T5jZkjmrKANs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU0PR08MB9656.eurprd08.prod.outlook.com (2603:10a6:10:446::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:30:05 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:30:03 +0000
Message-ID: <5afea521-7d80-4e72-8809-77af60b0d957@arm.com>
Date: Thu, 22 Jan 2026 12:30:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU0PR08MB9656:EE_|AM3PEPF0000A79B:EE_|AS8PR08MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e49757-dc8d-4c83-06da-08de59a9befc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eGhMaHdRb2hVb3ZNMllxbEFIdVpSUCtpRVA1dW5vcE80NWtUcjBIYzI4Nm1Y?=
 =?utf-8?B?eTdad2M5bFM0SVVnZ0k3SXk0OHFlNC9lWU5hUTBPdVNXM1EvYmJlRTMwZWxR?=
 =?utf-8?B?dXFoNTlvV2Z3UnVyZFBBeElmRVFiZHVJcGpnRDZ4TzZQMmxVQi9BM1Uzd1JY?=
 =?utf-8?B?aExSeldJNWhWaXJyT21oWVFoOGlvemxROHhoWDdBTkI4dDlFT0UxZjV3UjFx?=
 =?utf-8?B?UG5RblRHVUgzTytMdGJSZVNETVlkR0paWXFWNWdQNlN2YU93b0NpdWJBQ1lz?=
 =?utf-8?B?RmFJdFVBTzRlSXpBWGh5OXNqaGZoNFc0RVVNYml2dStWbVhyUVhkWlRrMitX?=
 =?utf-8?B?OGlBZ0ZoVVplS1BsY0FLSG9MSTcxaXIxR25EMlZWS2JDT3dnV2FJL0ZxakYz?=
 =?utf-8?B?V1RsMlB4ZFRiV25jQ0tXa0xRaHJYU0dwajVsN2dWTjdUN0UxRHZLU2tya3A5?=
 =?utf-8?B?cXowTitXS0VKY3RDcnZpSnBZMXhMYUMvcUJacmNodTVwZ0FxY3lKSmcyMkJK?=
 =?utf-8?B?KzlyY0Y4UVloUXhrOU9rcTFVVHBoNFNIeGp1YlprcEp2a21ic0lEUE5WZy9n?=
 =?utf-8?B?aFNqUFNIRkZjbDRvUUJRUlZETDFqSjhxejF5Y2NUN2pSd0dLVVlrK1ROUjFO?=
 =?utf-8?B?aW03S0xXYlo2dlRPNUQzRkFWWkE3UHpJWnRWMGhHNDhOMVA0TEhTZVBjeXBX?=
 =?utf-8?B?ZDUvbktuSlJJTjJkYUlFd3AwN1Z5b0N4b0FQMVFQOWdsNlg0OUx1WXNLeE1S?=
 =?utf-8?B?dkNlNlNVTTJ4T3ZDYmJUaE56d1JFSzBLcTZPZHFuZVpEbjZzaHd2QWZXYlIz?=
 =?utf-8?B?cDRnVjRaV0lURXVGdDNHZ3o4MnRYbWJWVHRmWEh0b2FZK1RiZWtUUkh5UFQ1?=
 =?utf-8?B?WkFUM2xtWWZlZUNiZS9nSXo5SThCby93Q2oraE9YZktvMTFjRWpYRmpxU3Ny?=
 =?utf-8?B?WWJ1Vm9GNmtnSVZZMmdiWU84NkNoMkEzZlVpZDhXV09lcWk1MFNKc0lEUEFN?=
 =?utf-8?B?bis4cFdLMFJzcWxRL00wd2xNMHhyUnhUOWgrUG5kaFlDYWNlcGtDZUNhcXpi?=
 =?utf-8?B?K2R1NTF4dUVjQ0tMWFNEZlJIMkFieGVQZnJQMFlranY3N3V1ejJPK2tBZ0x0?=
 =?utf-8?B?ckt0UG9Gc0liNjVIbldHcmVBU0xya1NKTUdsY3dLQ1F2c0RzSlZxZWNVMXMw?=
 =?utf-8?B?SGltRDVPSCtqUHNaWldiR2NDUU1xVWZXTmx5L0lma3Z3dkpkTVBVU1JJRGN0?=
 =?utf-8?B?TW9XYVpvVUViVmhGWWM3RUhSUGNGZSs5R0Rid0RwaFNMckU4NVgreDJ6cGlu?=
 =?utf-8?B?aGNRUHNnY0E1TDNuQ0d6MURndjJsM0xLeUU4R3l5U0Y5Rjk1dzhad2FSYjBL?=
 =?utf-8?B?RTM5cTZ1SnNzTStIYzd0czRvaXEzNVl2ek12YW5yak1WYUduSGR5dlV1L0d6?=
 =?utf-8?B?NFM2WkhqbTVhdjJHeTM5cXUrRlQ1VzdHY2pkQmJ3WmhjaWs0MkJpRXJPcXBl?=
 =?utf-8?B?UlVUSHBOSTRNWTI1TWV5VkRpajdPdjZydldnalNNano3Q1hscmhBeUF5QlZu?=
 =?utf-8?B?K0xET0xzNktDS3duVGwrTzFzYUthNEVQNzhwR3pHK1FhbzFsVVBGdjJic1RO?=
 =?utf-8?B?RGRxdHJzOEVCMHkxenM3VHdEWnF3cmk2T1NlT3lkUmZaSEJ2Nit2M0djRHNJ?=
 =?utf-8?B?amNmOXN1VnloM2ZoellvL0w2UEowU0labXRDaXo1cFQ5OHZPWXFMSmZJQzVD?=
 =?utf-8?B?Q0c3SUNsR3pyWkJxZE8zN3YwVGFFK0E5N1pjYXcvRXdXNExUd3JISkhzN2Mr?=
 =?utf-8?B?SnZEbUNsbG1BZUZFb0trQ1p1YXVlb2Y4QnVna3FhdXkvK3ovWU9GdC9oQjJr?=
 =?utf-8?B?Rmo5QXRmTWw2dFhvQ0lTL3NuZFhRbGN4ZHFBZGpzK0pmRjFPRXRKUG9PN21T?=
 =?utf-8?B?c3p4VG81ZzZxU25wWlE2V1ZIN3gySkg0QkprVkplenpIZHVQV3paRXJtd2p0?=
 =?utf-8?B?TFNmbEE1dXdraC9LcFpGallETExhY0hta1g1aVZHWmdzelh6b2U1T2poWXY1?=
 =?utf-8?B?d3hlRGJ0S25mWUpLWGdtT2R5akYwTzZxQnlqR1lpdDdWd3Bxc2pGeGY3c0xi?=
 =?utf-8?Q?POZs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9656
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dbbcd614-3eff-41ee-1369-08de59a995d9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzk5Ty9yaFBUK1lwWWJzZENpaWx0TlFNWDNwT3hTVnVQbDhxUEJkZUIrd2RY?=
 =?utf-8?B?SWZmcEhGeEthUXJBMVp5VUdCOURJMDk5MDRiOFVRcXFCcDI0N0NIZzdQa3dP?=
 =?utf-8?B?VkFhNkE1enB0TFlJWjZmVmgvK1F0UHF4Y0JzenBpajFLK2VNdFBvV2RNYmdB?=
 =?utf-8?B?bk1RNlFCQTU0eWZydGdNZWFkK21FbFdwV1d0TC9JRjRXV2lUemJJeDhIN01F?=
 =?utf-8?B?ekpmRmR0MmlRM1d2dm8zUWhRSVlGMU1sUnRCckV4NWlsQ3FWSDFRalZHV2Z1?=
 =?utf-8?B?S2ZHTUc1Y0F5UWo3OUJwM3IwbW1KSUFIMStReFkrNjN4a1VzVHE5L1cxdytK?=
 =?utf-8?B?SStQbHBnNTZnVDVwa0orNE53T0xGWGZsZHJsbXN3NXppOVhXOE1KbTRjNVdj?=
 =?utf-8?B?ckdVbmc2QnVTOTVrMlVNN25JOXg3dzlURmd5MG83UDFGcjZ5L0tvTlF6clVj?=
 =?utf-8?B?VE9ncEZsMnhLK2ZZYkhmdFBuZk4wR1JsMjgyL01Ib0hzd1NkcFFIT1RWZ3dm?=
 =?utf-8?B?cm96RDlqOTBoL2JIc3VINXJTK0l0WHkyL0RKM0tmdUxGWUNaeWdraWRNcnQ3?=
 =?utf-8?B?UWY5aVBsRml0aUhWVTdSNjkrQVZFLzBudXdFM2FxbW1HY3dwVFNVQUJsMS9C?=
 =?utf-8?B?YnVBR3J1dXNZVUNiNmhyVG84anlYWWpXVko1UDQxaEpKWEVwUlpBSnZjbWJy?=
 =?utf-8?B?dXFRYk9zZHd0WWozSGdvMGw2YkRTZVdVUkYyRnYza1g2UXZEejdDM05nTGFj?=
 =?utf-8?B?d0JMQWxicTE3aXVsb3ZHRG5lK1kvajZaQ3crVFpRaUhpR0VoRUNGVG1kWnNU?=
 =?utf-8?B?c3cyYW8zbThNbkE5SmFEOGtSd3ZKZW1HbFlTSXhpdDZuQ2cwcU1OM3I3QlBP?=
 =?utf-8?B?VFhsYmRKT3RMT3NQSkcwUGdJc0VrTVZyUHZNVDVEeHFJc3A0a3l2Z2hkN3ZH?=
 =?utf-8?B?ZlEva01BcDl6VUo1eGFRaVhGTmFsQzcya1h1L1RsaTNjVHRXK2EzTDVlV2RW?=
 =?utf-8?B?MitFUzgzZWlKck9UN1ZiR1pLVXVRYW9EVWphNWI2N1RIZmlDS04xeDV1VnM4?=
 =?utf-8?B?enhpMDcwcnpmbU5sbWVmdVBKY0RMOUQ3NktQWGthK0xHdlBxYnVhWnY2TExG?=
 =?utf-8?B?MHB1UFFTdkR4Wk82K2ZCQUdPYkFja0VoL2tlZlphLzl2bnlNd2twTGVvN3du?=
 =?utf-8?B?TFVQT205R2w2OXZWVFhDN0tZdDd4QzNQcEN6cUR2M2xUQVpWQTNlMkNaR2xC?=
 =?utf-8?B?VkpuZVNKRCtOSlVFV2xTTlkrUDNrMHo2V1VGU0dSVnhsYXdpbUJ4UzBVRUxK?=
 =?utf-8?B?Y01jdkw4YTJKNXp0UzB1Vi8zN1lmUlBkamcrQnlNeUFrOHc0cW1Gc3NaUi9z?=
 =?utf-8?B?d1RMcFJneTlqQmpQakxxdWRyQzZXR2J4WTlNR1hONVpyRTdvaXk0ZkpoZ3lL?=
 =?utf-8?B?cTFTYUh6NUJRTnZyQ3granlpMFIyTXcvNVlmVkRJQk1ZeHpGR2RXNTVGRmxi?=
 =?utf-8?B?bkdvVTE0c2U0Z0tGVUd4eFFwb00rVnVycWJuMmg0cXM2Z0Juc01IQnZ4STRi?=
 =?utf-8?B?V3crOUcvcE01Titaa21tRlJMTk81SnpFUDd2bEpmdStrVTh3WnFPejdNY0xI?=
 =?utf-8?B?Ykk0MmN2VmcyNFQ2cTdReVY0R2JkdFlYREg5TUxubFlFZDY4alhQZ1FrRElw?=
 =?utf-8?B?V2lmWkFtTHVYeFJIR1VTL1RScENQaE43NlFoWWFQK2tzQ1lwYWYvbnF5K2tO?=
 =?utf-8?B?UzI1NzY0VWt4SVdEMi92ZDVpOVY3V21uOEQ4amJwUkJGZ3ZKeWtJR0prbUts?=
 =?utf-8?B?dkd2OS9ubERKUXMxSTd3QURIODhBMVlBTnN4b050WjBiNkFJV1hTa3NpV0t1?=
 =?utf-8?B?ODFsTXFUa1dFMU13NS85SmVaSEpTakQ2amgyREgxMCt1eFo5Wnd4REhPem90?=
 =?utf-8?B?aisyTDhabUNocUFlK21aekx0NTNsNzhuVkljV3NwcWdPZnZnMzhGY3NGZjE2?=
 =?utf-8?B?TlJoT1ZBK2RUK2xXV3RZWlhxb2VmZXdXcG12SXNZKytscHFMMmdNNjVrK3NG?=
 =?utf-8?B?eGZuWDVaQ1cxQWxyT0VxcDgxNzdYMmhXYVJMZWpWVG1GelovRFpJQjZ5RUZB?=
 =?utf-8?B?TU9WU3djQnJuK29icFg3OVFnN1UzeWF3TXJsMnVFOVp1NDI5WDQ2Si90NG94?=
 =?utf-8?B?V2p4b3oyU0N0dFJjWWdUUExUWWF3OTR4K3ZBM01uRytXZG52ZlV3aFZPR3My?=
 =?utf-8?B?aUZWRVFlWHEwMVJESFZSWFprRlV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:31:12.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e49757-dc8d-4c83-06da-08de59a9befc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20537-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[arm.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,arm.com:mid,arm.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B3A1D66506
X-Rspamd-Action: no action


On 1/22/26 09:56, zhenglifeng (A) wrote:
> On 2026/1/20 22:56, Sumit Gupta wrote:
>> Add cppc_get_perf() function to read values of performance control
>> registers including desired_perf, min_perf, max_perf, energy_perf,
>> and auto_sel.
>>
>> This provides a read interface to complement the existing
>> cppc_set_perf() write interface for performance control registers.
>>
>> Note that auto_sel is read by cppc_get_perf() but not written by
>> cppc_set_perf() to avoid unintended mode changes during performance
>> updates. It can be updated with existing dedicated cppc_set_auto_sel()
>> API.
>>
>> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>> perf_ctrls with current hardware register values during cpufreq
>> policy initialization.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 80 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>   include/acpi/cppc_acpi.h       |  5 +++
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a09bdabaa804..de35aeb07833 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>   
>> +/**
>> + * cppc_get_perf - Get a CPU's performance controls.
>> + * @cpu: CPU for which to get performance controls.
>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>> + *
>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>> + */
>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +	struct cpc_register_resource *desired_perf_reg,
>> +				     *min_perf_reg, *max_perf_reg,
>> +				     *energy_perf_reg, *auto_sel_reg;
>> +	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
>> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +	struct cppc_pcc_data *pcc_ss_data = NULL;
>> +	int ret = 0, regs_in_pcc = 0;
>> +
>> +	if (!cpc_desc) {
>> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!perf_ctrls) {
>> +		pr_debug("Invalid perf_ctrls pointer\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>> +
>> +	/* Are any of the regs PCC ?*/
>> +	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>> +	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>> +	    CPC_IN_PCC(auto_sel_reg)) {
>> +		if (pcc_ss_id < 0) {
>> +			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> +			return -ENODEV;
>> +		}
>> +		pcc_ss_data = pcc_data[pcc_ss_id];
>> +		regs_in_pcc = 1;
>> +		down_write(&pcc_ss_data->pcc_lock);
>> +		/* Ring doorbell once to update PCC subspace */
>> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>> +			ret = -EIO;
>> +			goto out_err;
>> +		}
>> +	}
>> +
>> +	/* Read optional elements if present */
>> +	if (CPC_SUPPORTED(max_perf_reg))
>> +		cpc_read(cpu, max_perf_reg, &max);
>> +	perf_ctrls->max_perf = max;
>> +
>> +	if (CPC_SUPPORTED(min_perf_reg))
>> +		cpc_read(cpu, min_perf_reg, &min);
>> +	perf_ctrls->min_perf = min;
>> +
>> +	if (CPC_SUPPORTED(desired_perf_reg))
>> +		cpc_read(cpu, desired_perf_reg, &desired_perf);
>> +	perf_ctrls->desired_perf = desired_perf;
> desired_perf_reg is not an optional one, so it has to be supported.

The ACPI spec seems to say it is optional under some circumstances.

Cf:
"""
This register is optional when OSPM
indicates support for CPPC2 in the platform-wide _OSC
capabilities and the Autonomous Selection Enable reg-
ister is Integer 1
"""


Maybe it is ok to let this check here and to a more complex verification
in acpi_cppc_processor_probe()


>
>> +
>> +	if (CPC_SUPPORTED(energy_perf_reg))
>> +		cpc_read(cpu, energy_perf_reg, &energy_perf);
>> +	perf_ctrls->energy_perf = energy_perf;
>> +
>> +	if (CPC_SUPPORTED(auto_sel_reg))
>> +		cpc_read(cpu, auto_sel_reg, &auto_sel);
>> +	perf_ctrls->auto_sel = (bool)auto_sel;
>> +
>> +out_err:
>> +	if (regs_in_pcc)
>> +		up_write(&pcc_ss_data->pcc_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>> +
>>   /**
>>    * cppc_set_perf - Set a CPU's performance controls.
>>    * @cpu: CPU for which to set performance controls.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index c95dcd7719c3..229880c4eedb 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -594,6 +594,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>   		goto free_mask;
>>   	}
>>   
>> +	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>> +	if (ret) {
>> +		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
>> +		goto free_mask;
>> +	}
>> +
>>   	return cpu_data;
>>   
>>   free_mask:
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 4d644f03098e..3fc796c0d902 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>>   extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_enable(int cpu, bool enable);
>>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>> @@ -193,6 +194,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>   {
>>   	return -EOPNOTSUPP;

