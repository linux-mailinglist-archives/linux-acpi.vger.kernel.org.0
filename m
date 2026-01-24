Return-Path: <linux-acpi+bounces-20603-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL7uDGApdWmwBQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20603-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:19:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121C7ED8A
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37542300A631
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CB237A4F;
	Sat, 24 Jan 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaUI8yz8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823135972;
	Sat, 24 Jan 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769285981; cv=fail; b=Hx/Z6SrgfQXNULN94aVEo6JofXkOZqOE3FVrNGt4WYJbknWiPJhVq0nZmtTHCdPMKYUBfylgq+hlTvgxeEvZJEMDmnVQbCc+kVCxKlGLCkO/bJrkysRH01vwfHQRKUsufhMDFLMqB3+DgGRNb3zbL5XCv44RIAw4Z1MIBg2vNEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769285981; c=relaxed/simple;
	bh=V3Ft7zBvORrPm6E2rJ2Tfp9+XhDBpPicOJLMcA31ty8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XfHJ0CYKrRYFMgiZzNGHy6RDHWBC0MW0WiHTpfim1UAft2AsisMgMY5WyZ8zucVp8BrUxCiHeXzPo/qVZntke2iyP7sxmL0ss/UIpprMEd0sa5aMS0HexFn7ZMcDgTM0VRsmnw8tKC9l4M54RL+iVO9/f00TzyD7Z8baVIBx5ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaUI8yz8; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV+bKY6kYOM974r34UgD0IUr/vYMBwowL8btweBh1p7ENpcbWMTIwPUHVOINPDpMQQxEPpMYCb8UCy4AlgGMft+cEA3ivUml+oRiRffZecbx3V2I9Pr+0Iblc2r1Ho790Qav5nRSPv9cee9z3QmlW10vEz0GEeooI7seYkhWy/s6pChID1HvchtSGqDUsmOzz7IwzPbWvqOMXOWIJ8W2RtzHW8nfy3XNr3sXEe0mVt8PKz/8LrTH5mK0FykYcQZ+lCvC+apXPM9331G8ljERY5jpv+7A0LqHbppMhtHYuRGX7s+oPJn6vJNSKV9uaA0GXAd7Sv+SwRgBoRefZywA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1ofkzNCXGAuVo108NNuylgdh8/PswXDnUI4MhJpiN0=;
 b=B4XZuTVNJMkJynzm3GWj8pc1uRTXNTwoU/K6FdR8D/NGwn5kNrfJoEmQEGxOzakPnnzeVYvV2GQ4jqjtl+wJ/Z3GF0b9IbRKS58WrujXlljeTjPlCPd/JfcZeJ94HhWYAdeyVDa7Ae9mXyk3XwNfsPJ4Ppy/okF8mQNo6U6e2WUvqJZiasyw8hnA9abRl/N28IfWWe6mb5GmGiS13szIKKXWUKqaD6LBLfbU+qHvLM2Y++mf8h7ijDG/oXohbBk/nZLJPti/e9hus1le4pYOdbWZFZgeAmt6aEhGWu2sTU90MQElwuNpeYPVGp/1qmfOXg/6aONxjgisgxxnceG5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1ofkzNCXGAuVo108NNuylgdh8/PswXDnUI4MhJpiN0=;
 b=AaUI8yz8/9/FQTio0JWApCW3ArJX6IpI1picFqEHrWRRTgx3f8WaNyy3OBOSG8jUIgaP3I4DsgfLgOWZe+GOPib/VjDInWpx5vNcaV+vvnpuXrbuqLEY+ok6m9akSni0RxNpNc8dtgcyXLjIPv7mR2PiM3djvU21Y92CAC26MDZ4Lb1pPjqZdmmSKMPpghrCQ8F+MuZ5xOoB5C4PsVyxkczodkwGs87Ksfa9SJ4RzeJPhTXgcmH8HmGggLpnAmchval1zqcnPN4piS/yidkDx0oKkbvCDO99P5FeqNJLVhoKdKI35ibi8DSRQklQb67EWxUawwUgHYs5ajtbjOukCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 20:19:36 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 20:19:36 +0000
Message-ID: <53827af7-f3b6-4e1c-8c8d-2f57ef5be97e@nvidia.com>
Date: Sun, 25 Jan 2026 01:49:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
 <fb4b68f7-ec64-4660-99a3-d288bc20ffac@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <fb4b68f7-ec64-4660-99a3-d288bc20ffac@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::19) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 593305e3-7737-40cb-10d3-08de5b85e499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWUvdmQ2cmdDZnpiTzBidG9iOUFiY2treHN6MDFjeXlQbmV1c1cyVlJFZjNX?=
 =?utf-8?B?KytpWUVoYWRCS3c4UExObzBMRXhMVzdTOHY4OUdmeUZ5bGpHWkE0anlqK2Ji?=
 =?utf-8?B?OG8yVWN5eitXbmRVOTF5SGJ2SE9qazgram9RSklkeUdYVW5ScHNRdmh2WWU5?=
 =?utf-8?B?RlN5Q0tDWHAxT3cwUWI2dDA2VW9FWENYQXQvS1NVODZCU3RFSDIrdk1aZ3NY?=
 =?utf-8?B?bFIzQmg2b3NLZWRJeFViVHhOaUcyV1pmVENXMlQvUjM2aHBvZGpiRHI0WGh2?=
 =?utf-8?B?MGVaM0R5ekh2V0FFa3BEVHVDdHJJdVRvZjlkcEMxMzFWZExBYTJ0alVuVXlL?=
 =?utf-8?B?ak1sVlNoejlHQmlFSU9ieVYvVVdOQkIyeThFMW4zdjlGbGVWZ013U3R5YmlS?=
 =?utf-8?B?d1RoR0V0S1JNWDk0ejNhbVErc3ZGcmpTdTI3aUdxNTAydFlsdXVlL0xCVFI2?=
 =?utf-8?B?dFVObkdmOHVrYlBNaGRwc3VhNld0QlNLQ2NhakFkemZ0Q3QzdlE1MXNKWDlY?=
 =?utf-8?B?bEh3amFETzIzemozY0VpcEdaTGZVL2FBd3d0NXpRNC8wSTNkS1dBaUhXR3Ri?=
 =?utf-8?B?a2p1OVJuRFFzMGgzcTJ4cm53ZHZRN3hLZkVNenNJQWNRdFAxWi93RjRiNlBI?=
 =?utf-8?B?b1hMcGNMSTBvSlJFTG9wTDczU1p2dGx3cE9Wc0NWaS9LcVpRSisyNkQ2cDFU?=
 =?utf-8?B?NzA3aWlETUVUUUJsWlEvL3dOV1gwWTNkenVzdEc4Yy9jY0xMemRYTjJ3OG9y?=
 =?utf-8?B?cU9TVXIwWHdGS1pZY1FzWjhmUGMxazVDaXpBY3pnQ1JoRnpiV3Rhbitrd2V6?=
 =?utf-8?B?a0ZLWUF3RWRTQ2ltZmFJV1hOVUpLeUxwSlBGSFhON0FRTGtsNFhoM2VFTkhT?=
 =?utf-8?B?S1M0NFJLQUtBWmtRTlFBYUI1UEgvdTdkQmhSV3UzellERHZaNTB0d3RkTnRr?=
 =?utf-8?B?dVlTR1NSNDZwODRRbXplanBEQ2lBU1ZjSENQOVRSck8zMDBWV0U3Nml2Nkhh?=
 =?utf-8?B?d3piNytpcTlZd216emtoQ2xqb1U2UWhvS2ZvZi9UbnIyVDFFdEh6Mi9BUXZ4?=
 =?utf-8?B?bTBab0pkNFBnZTZMQW96V1pCVXk1S003c1BSa3ZqWDhyV1FPQTVsVlBBeGRj?=
 =?utf-8?B?YVU0NWZHUGFPamdUbGNoTjVaMWcrQ2xCQlNwOVFFRmdEak9CdzRPcDN3MVBl?=
 =?utf-8?B?dENVbHpVM2dxbDBvRmNhZ2NtUEwwUVcrN2ZLRndTa0JDTyttTmQ0Tkk3L2dv?=
 =?utf-8?B?RmFZcHpmTUQ5WDJzZDRYd29OVUhTdmtpc0V1RTNIMGh5L0RSUS9RQmd4WGU3?=
 =?utf-8?B?Ry9kdXdUUTY3WjRTVVVHTStZa2pROFBOR24rdURYd3VYUWdjTVY2ZEU4ME9J?=
 =?utf-8?B?NWVJT2FiQWVQVmN0WjdpSXBRQ0Njc013R04zWlVZTU9YalIrNjRvVldxYVNu?=
 =?utf-8?B?aXdTSWM1cVo1MS95M2tMRUljcUlNNjV5UzNUWXZDUUo2QU0rdkxmWlFBWDdo?=
 =?utf-8?B?a3NLczJZeE5WcmxCTitLTzFQR1d3NDY4MVlsNldiNnF5WExsVEw5NkUxQkpF?=
 =?utf-8?B?Wmh4V3JBRWxCNmM4MnRtNXdmZm45Tkk2RzF2akVRdUg4OENoMlB1VUFlZlJ5?=
 =?utf-8?B?TFlubmd5RkhDUzFwMEsxMlc5OTNhYWpnUnMrd1ZaNWsxdmZ4WkpOa1U4WDdN?=
 =?utf-8?B?clc2N2lPZVNxSmZscHF4V0Z1L3FTK2gzaHplL1AyamlJYTZtTFN0Z0YvZGwr?=
 =?utf-8?B?NmVISzFzczZkakcrOXVBRWxxRjNLclY5eWl2MEFuWDB4elRDYWVBYWpPMXVk?=
 =?utf-8?B?dFl3SUdiTi9wNmMrUm1wT2prVU8vNnNTdUFQbnhFOVpnV3FGRHoxOWVEQ2U5?=
 =?utf-8?B?eGRUdEdYbndNMDdGa3BRRGpmZk9paFFCZURZUmFEd3oyTGRrY2llODZCakFm?=
 =?utf-8?B?WlYrSDhxRWVxa1ZkY3ZyVmZkWUJXMVJidUgrRGgyVlErdVJsNnNrcGJPeVF2?=
 =?utf-8?B?UXcxdXZpTEZSemJjc001NzJDMUhWTXNUUDNubCtGeGt2WmJ6ellOb2ZEVUhQ?=
 =?utf-8?B?SVRJN2I3bndzNXR3THVhdnUyd09oWE5KVk5lQzNMZzc1bUxjQm1vcTluTU8v?=
 =?utf-8?Q?Ql+sDvDBN7/deAyiQctCnf5po?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em5SYlVHZDdjSnNwa2JFK3RkeVc5Rm5PUDFTMkpMYmNVMGh1UEEyd0xwRHVI?=
 =?utf-8?B?bU5OdXJXR3BESm5uai8rdHNFWnR6OFZ0ZGlkbDRkUDVGYjRhZ1UyL3VBWGtH?=
 =?utf-8?B?Nm9Gak5BdlVCaFByaUZLTTNLS0ZGNXJpb1lTWEhkTHBiWTQwcERQcmUxQ2dh?=
 =?utf-8?B?TkpjQ2g5Q0VsUTVGTnZkT0ppMXNicmhJcWxlY0RqbndJVUl3YkdIZDNRMm1y?=
 =?utf-8?B?cjF5cFI3L0ZqUysyWWxua09ZeE52NmtLV01FT05MaExUK2E0TjhnR2xrR0p2?=
 =?utf-8?B?aUpKb0oxNDMrdDAyMnhvV2h3dmc0WEFZTzQvQ0Zhc29QSjBkeGVwMWZZWHJi?=
 =?utf-8?B?UmxLdjd5STF6UGRnNmFmdWszeFg3ZEtmSXdkVUFJRXhGeGFlUkVSSS93cG5B?=
 =?utf-8?B?NGpPZDFQMi9UNHp4UlhlWXNSYmhvNTJlQTZiZXR1RzI2VzdEVDBWN2JZMFNa?=
 =?utf-8?B?a2hDSjZGbDV3ZDRwZnBhZVNRSk0vaEE0Z0JoL0JyZ2VUMmxrejVualFNV09I?=
 =?utf-8?B?dU9OMkw3b0wrcWhUNVNoUVJQeUtDaTYxMmxjczhLVlljOWFWeEpoaGtUeDl1?=
 =?utf-8?B?WndObHdzZWEvTW1ESGR5MWpkRmd3bVp0WktPa2xuak80aSt4Ti9XeVN6Zjdr?=
 =?utf-8?B?WThSVWI3V2JNYXVBWEwxNjFOaHF1MVdENEJwSCtXeXZoUFcxaXlHQ0pNOFAz?=
 =?utf-8?B?aDJITStMcy9Ua2NjaFhLR0pMRmJTQ1BrdFk5QjZNRHhLMVgvaExoNDArNnVY?=
 =?utf-8?B?ZDZVOTdRNG1oVTVjMUVoTU53UVRhT2VpZ0Z6K3F5UVMyeGVwMjJEckpQMlVD?=
 =?utf-8?B?M29xRjJTWXJtaGd3dVBua1JtZHF4NjE5Q0JWRm5LNmdYZXBoZjBWa2xWZmFU?=
 =?utf-8?B?RUN4WUNOZldOcS95cnlXQnJhMHBaQjd5aURKUFg4dFUyNHNxTUNiU2VvbWxp?=
 =?utf-8?B?Zk4xaXpIYVlvaWdoK1MyWDV4Y1Jxa2F6bXJOeEU0d3RmUjczZFpGR3E3WDNC?=
 =?utf-8?B?eTNzU3lhall5TXZWWGIyWnJqV0VkbkJET0dlQ21HZnQyUnJpajZuUDJSTjB4?=
 =?utf-8?B?QjV6YXFja0w3QkNDZzlGN2ZkVVF0SFR0TU9YTkhELzZwZlZRYUZjQnNyS0lj?=
 =?utf-8?B?N1pmbTcxbkxFN0F5L1QycFVscHA0c2JSTEFrcE44dHpqdDlCUGhDRHcvRE1B?=
 =?utf-8?B?WTNjcEpBTk5YTGF5MUQxdytXb0svK3dtT0pSNmxRbElIeVE4UG0rSFJRZ2RQ?=
 =?utf-8?B?NHlRdXBkYjl5aUcvREk5cEViSmhRTjdnOGQwdFUvSU9ReDQ0YmM1UUhKYjN6?=
 =?utf-8?B?NzJ2azA5aVJXYVpROFhmTUFJdWFHMkFEa0VZYWVVMDhQTmpsV1V4L3l4b0xL?=
 =?utf-8?B?T0VaSlJ0cG9oLzZrM0JIZnBPRmJGOTZ5RHhwbFM5Z3BCL1RtOUFMbUduWkRk?=
 =?utf-8?B?L3g3bllGWWFDZ2orRUJnbHFuanBOOXZucHlXRUJPNnMrV1d0S0JGMTBFNE9m?=
 =?utf-8?B?SVdRVnF4a00wMEhyV2t6OEg5bk1NSXA2enh0dCtNRGZUK2Q2THdOM3BJcEM4?=
 =?utf-8?B?ZFlTb0pqOHRqN2hiZ1pnZ3JlQXVrcHpiSXRyNExQaVptTmQ1MFFqUkJlbG5C?=
 =?utf-8?B?TUFweVUzbEdzYzZ3RE1xUkY1K0JZWUJMTlFDSW1uL0NBMlp3L0F0TGVjdGg0?=
 =?utf-8?B?U2tuWHhSV0pVbnlqNHFva25pZDU1QVBIeE15ZGpqTWZ6TnhHL2dTOFB6ZUhn?=
 =?utf-8?B?NjdXci9QS2Y1cDY2WHQzR0FNM1M4QTdYMzh5dTI0NkJkb1hRakgrQVp5cXVo?=
 =?utf-8?B?Ky9lR2ppckw2WEJXclRjK3JSUkpWeEpQbmZxVjFBdHNaTGk3M0FYRzdqQ1g4?=
 =?utf-8?B?WDFVMFphKyt6QVlDV1hHeGdSdDRHWk5Bb1p1bEhWWFBRdWNzdnlpQ3VYcDF6?=
 =?utf-8?B?LzdhYVBOeENRWC9JemZwK1NabmFDZXcyRnZmVjNYdjVCdUVleGczNVVNc3RK?=
 =?utf-8?B?cXFRMnBneHdBb0VzVndVRzRMcVljd1hnWGpDRVMvYTZnWXhMeStDWTJzYkNM?=
 =?utf-8?B?SXRjbjdjMit2S3RVR2ZSZnVMZkZZbEdWM0poNmpVbG9WT2FQeWtEd2ZubndE?=
 =?utf-8?B?eGlYbllSWjdCSGxrL3BxQVl2MWZpOW1aL1YwaWJ0YW5MSTV5akxCMU9lWThM?=
 =?utf-8?B?T281dmZOWG5nSWJxTkJpZ2ZOdDcyNUx6RHRJZEM1WmpVdStraDlBZWgxMWU2?=
 =?utf-8?B?SVJCUENTQU9yZW9KSnhCWVhWb0NGUE5XeHFQMW9xU3pUbEhIR2g2WVRhUG0w?=
 =?utf-8?B?R1IxSWNsL0ExeVNXVkcvVWxMMzF4dXg3a002bG5hUmVqdUQxcE1hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593305e3-7737-40cb-10d3-08de5b85e499
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 20:19:36.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MebDGbP7601im+NWwb3KvqfICwIHwnEQlJQ3V6aeFrbaPjMiUOCBjjaGtPlo/xl68jYauGv4t9jb09Lket/mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20603-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8121C7ED8A
X-Rspamd-Action: no action


On 25/01/26 01:35, Sumit Gupta wrote:
>
> On 22/01/26 14:26, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>> Add cppc_get_perf() function to read values of performance control
>>> registers including desired_perf, min_perf, max_perf, energy_perf,
>>> and auto_sel.
>>>
>>> This provides a read interface to complement the existing
>>> cppc_set_perf() write interface for performance control registers.
>>>
>>> Note that auto_sel is read by cppc_get_perf() but not written by
>>> cppc_set_perf() to avoid unintended mode changes during performance
>>> updates. It can be updated with existing dedicated cppc_set_auto_sel()
>>> API.
>>>
>>> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>>> perf_ctrls with current hardware register values during cpufreq
>>> policy initialization.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c       | 80 
>>> ++++++++++++++++++++++++++++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>>   include/acpi/cppc_acpi.h       |  5 +++
>>>   3 files changed, 91 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index a09bdabaa804..de35aeb07833 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>>
>>> +/**
>>> + * cppc_get_perf - Get a CPU's performance controls.
>>> + * @cpu: CPU for which to get performance controls.
>>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>>> + *
>>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>>> + */
>>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>> +{
>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>> +     struct cpc_register_resource *desired_perf_reg,
>>> +                                  *min_perf_reg, *max_perf_reg,
>>> +                                  *energy_perf_reg, *auto_sel_reg;
>>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, 
>>> auto_sel = 0;
>>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>>> +     int ret = 0, regs_in_pcc = 0;
>>> +
>>> +     if (!cpc_desc) {
>>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     if (!perf_ctrls) {
>>> +             pr_debug("Invalid perf_ctrls pointer\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>> +
>>> +     /* Are any of the regs PCC ?*/
>>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>>> +         CPC_IN_PCC(auto_sel_reg)) {
>>> +             if (pcc_ss_id < 0) {
>>> +                     pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>>> +                     return -ENODEV;
>>> +             }
>>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>>> +             regs_in_pcc = 1;
>>> +             down_write(&pcc_ss_data->pcc_lock);
>>> +             /* Ring doorbell once to update PCC subspace */
>>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>>> +                     ret = -EIO;
>>> +                     goto out_err;
>>> +             }
>>> +     }
>>> +
>>> +     /* Read optional elements if present */
>>> +     if (CPC_SUPPORTED(max_perf_reg))
>>> +             cpc_read(cpu, max_perf_reg, &max);
>>> +     perf_ctrls->max_perf = max;
>>> +
>>> +     if (CPC_SUPPORTED(min_perf_reg))
>>> +             cpc_read(cpu, min_perf_reg, &min);
>>> +     perf_ctrls->min_perf = min;
>>> +
>>> +     if (CPC_SUPPORTED(desired_perf_reg))
>>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>>> +     perf_ctrls->desired_perf = desired_perf;
>> desired_perf_reg is not an optional one, so it has to be supported.

Please ignore my previous reply on this. Had some problem with my email
client and both mails got mixed.

The register is optional when Autonomous mode is enabled.
Seems the comment here is already resolved with Pierre's reply.
We discussed this during v4 [1] also.
[1] 
https://lore.kernel.org/lkml/ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com/

Thank you,
Sumit Gupta



