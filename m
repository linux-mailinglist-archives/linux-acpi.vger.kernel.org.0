Return-Path: <linux-acpi+bounces-20848-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMrICaUWg2lnhgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20848-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 10:51:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83291E416A
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 10:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE3C301858F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C23B8BB8;
	Wed,  4 Feb 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYFG0kv3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518343A7F5D;
	Wed,  4 Feb 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198687; cv=fail; b=sJ9EOksvJ6WdkBiAr085v8fPRN2QsR9bWIErjVlBlRGL4fqQPjja7JiYbdxhfnuXWhXS4LRpWzK418WTr5RE42jpjX/J4Fpylo6aNZsgXoO1KGxkvfkABS3ZXO5+0jK1nos1729Iy8IskNxvbRa7INSgjSOdOPp9DkY8Yi2dMD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198687; c=relaxed/simple;
	bh=D5GEVAT4LMGPROnDIFtwoE2iQCkbIMFrS4oN1YTugmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VXsbgrF0MvnlnSmLhsy8bvchKiL67nvJVtG4qGNwSH7FddioF/hCxABAKmqgPddEqi8tsuSEls9XhQpDmHQoKQugilt5atI2/68NSPFNHP3M8mibEC9TPGcpyesWNG6BolCra/BvZIdd6ouU6+m1jDJBD74XKBh+zoYy7ITedsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYFG0kv3; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAxzI3gQDHI5d3OYVsriszTZv0nli8ANTeBfJVRTU/Z9hGjA5vzUBIOMDD8ljGVHSPlDj4NWlIYYUXRFXtBNqQCxnqOb5elESSFUkHO5cVUgmrotfyD5qU/crpeOuCABfWOt2SNJu4YpTRxjVAC/0pa1acnCG8ZYGNmPjs9B2gRj1F4kskV9Esu/XXQS9hFmL7Gmb8mZio9BOrOuMd9CUAkT1zvyy8RWvZdhbZtQYnp/wSrqqQETmbKVqqcKXZ/ElpVSCtrdCNfxkuZeLSaMfxyuvN7LBWZ5orWcZUCS0Ry0xwi8tvosRuyKZJDZN9agD5wJmUwm78QbaR0OlbU3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXUQuTaeLXBX747v48dYAm0eS7aTq+bS/XVx/kC+0ds=;
 b=Q8pPU7tlwyYoIjTBLDgqdUG8ERF6LlsxCTVk/LNO3PKwrQrdnMugcPmFniaK0xYuYPQs91GnMdNsbZYxd0bL/BktOtEWPDImfRwOVNfR9iCt3pOtPjeqFI6/PnfxAGBI52oMSpOUSxBfAnz5yXao8ypr7k+tHX2As6R5VOoZuV/FgoTOMXQMofoLoxPgtu54asgAxDfCpN8NRBg2u0ez2DMkSEbYBY9WDfBjLsPYbLnjb9n5XvYAvN5YZtQu+pvPE53THnr04yPP9Cva0Qt1XeTxezDt76r1JM6iRBZISicdTfYpSc0SucId+0MAMcvuZHOBjlIivuyzq5unWCe2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXUQuTaeLXBX747v48dYAm0eS7aTq+bS/XVx/kC+0ds=;
 b=hYFG0kv34A4ayQ4ztncKXR8O/aJSqh6dxFqeV2EqzMVeq2lUSK/Fe2+H6ao5LTw7qj1/qv6UVT7cvw4sU4Z2LrUHKDOVbPJ/ndkniKI1/GEpZ+tiOu0eqjRuhs+zbrjY6rABEpQgt4QNnHqO+4DSGhQOCGk4tDncZuz8eEyDJ/ASaghhAFSrhWWHeq7rveHawsxg7bEksYwNylx6+7txv+a5YMlgq/D1PkutEJhSVPlhIjZcEbf5WXmB3wZNokc7qCKfLN5TaEPncLlglTldN5iJjY6/3S+vwJgzw0G8Sizy1wagsgqOD9JhG3U6FKDJbbP7We7BT3ejdnUYD3Ok0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:51:24 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 09:51:24 +0000
Message-ID: <b8603fcb-b0ab-47da-ae90-e82f7b9bcd67@nvidia.com>
Date: Wed, 4 Feb 2026 15:21:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell Haley <yumpusamongus@gmail.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
 <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
 <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
 <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
 <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
 <e7570bc3-5420-4743-8a75-8602559ca235@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e7570bc3-5420-4743-8a75-8602559ca235@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db859f6-a175-419b-8718-08de63d2f4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlpIWmNDN3JCT0c1MmVxZDJaQVRERkYzUUxDaFJsS0dMU0U5OE5VelhvU1k2?=
 =?utf-8?B?S2I3blFycTQybDdQZWhIVEErRXFEeXVJVWRYVjczakw4M2N1WTRXZnJidENo?=
 =?utf-8?B?TEo5OGpHT1k2a01LQzAxaXdaS3l3RGRHUTE2U3UxZXk3Wm1xVmFwdlpPc3Fa?=
 =?utf-8?B?K0k5WE04dmZ1ZEVvZ0xOYXBlRmkyeTdwZXFjdnh4V01wcmp0T3MvcFZ2OWxv?=
 =?utf-8?B?VlI2OW9FN3poZ1E5Y3pSUWpqSVMwc3REdk13L216MS9JR0RTM1FDYkFCQTd1?=
 =?utf-8?B?d1pRTWkrclFGUGFaMjUzVGdYL01JYjUrOVUzOUljVGhwaFMxOERRc2dObTBN?=
 =?utf-8?B?b1JqOWdadVMyTWJ5WDRRQVlrTkRhMnJKM2ZDVFJRRDd6TzBIYjI3N2dHUGdj?=
 =?utf-8?B?UkFSdDRxM2lET09IdCtmQk4vWVlUWFF4cC9wNlpjOWwxNzZPS2hYVzlHakdr?=
 =?utf-8?B?OUpGYlhSZys3TEIva01rRUd0Nm90dXRDWnZtb1htRkUwWXFXVlBNNUVBRUJ0?=
 =?utf-8?B?L1FMT0xMcHZGNk54RERtYWRDejJjdFQ5ZS81NTlCTnpVaHc1OU9DaWVSZjNZ?=
 =?utf-8?B?QTVjdGRWVUhLZEFZbXNLblB2N3pJL053cUFWeUF5R3lQS0dFZ3pOU2Q2dkpa?=
 =?utf-8?B?ODlmLytuTitsMDZodktUMFBRWHFIUTBJTDVrc2JGTGRyM1YyUG0rTmVZZ1JM?=
 =?utf-8?B?eWlyQ1Z4OFBBWko5Sjh5MTYra2xuMTBhUTNjNGNaMVNPMmd0S1JzNHVoSXlT?=
 =?utf-8?B?bmZ0aWFLVDFoU3d2dnFLeGg0ZmxXa2EvekpSVzFOYStxTmNOS211bzAvWDAv?=
 =?utf-8?B?OUFBWCthTVFiaXFXQnMveGZ4S2RNYlFYQ2xoYW10UlpLVFhYMGJPWTBEcGgy?=
 =?utf-8?B?bGZnWG1SdGlqRVhXZjVQVzdRdFo0b0pkenlDeVFvWnJrQW1uK3pIYzljbjJm?=
 =?utf-8?B?dFFoT2xXNTlwREltTmZESm1wOEthY1VEcFo5VkxPRmNqamZmc25ZZkFMMGRQ?=
 =?utf-8?B?cU5PUUI3M1pXa3FJaW8rVGRDUlZ5Vko0NktxV2l1QmFMSFFqck90WFFnT1FC?=
 =?utf-8?B?ZE1kbEVXaEVhSGVjdXI3dEc0UVkrSUQwSU1YMkkxRkFwNUdhV280eXhkbGJR?=
 =?utf-8?B?N1VYMUw5Q0Z2VTd5WTlnQ2srR3d5VTZUaCtOeHNudlZRVlBFTjFBNG5HTVlV?=
 =?utf-8?B?Und1RUs0YkFRbnlGalJaT004TUR2N2U5THZ5MGhNRXNzNFdZQkQ2Wm82RzYv?=
 =?utf-8?B?VXQ1bjdTNmMvZk1qQUoxSW51RUJ4YWdrQ2grVXFvUk4rcm5RVzJuOTU1c3or?=
 =?utf-8?B?Mi8ycDg1cVlKdjFhaGZlcGpZQUhEbktWRHJWUUJKVVJLeVRjUVZPOGc3TlZt?=
 =?utf-8?B?TlRsN09ZYVRINVZqVUYvYmtMZnJiZTh0V1p4YlhMUTk5WmtHYWpFanJ4WEN6?=
 =?utf-8?B?Qm9qakswUmNyZmprZy9CQzFCdHpNTmFPNDVRejJxRTVIRUtKR1pWMWxQTllz?=
 =?utf-8?B?WEZmWGJPMkg2ME13RVl2UzJNSGZFTGdEVVJUS2dPckZOMy91eFE1NTAxTzEy?=
 =?utf-8?B?SjV3N09MbUFUWWRhRElqZlhPVURrSW1TaEZYTFk3SmpXTkQ0QnBNV3hkaEVS?=
 =?utf-8?B?eUZGZllwaFgwTlZKNy91QnNrM1FBb0YyVXR5cGtEbDRveWlnTUtxZUIrcVMx?=
 =?utf-8?B?TjJrNDRhTEZJcmdabEluQU9QaG1Wa2V1YTJnYTQ3S2Ryd1JuUHFvK3B1eUdz?=
 =?utf-8?B?dXp5b3FaRnNOU3BVUklpUHJ5cGRGNkVUM2YzMWMxSW80MnNWVmR6QWNzcEhR?=
 =?utf-8?B?WWVFenJqRjJMOHBWZlp5dzhaclhSREVNNElCOWRySVg2ZjJ3TWxVSm91aDJo?=
 =?utf-8?B?REZTZmd1cGtwL1p0UGNKenNWU0RFMXVucjBpenUvMHhrMXBvR2V4ZVNuZnpS?=
 =?utf-8?B?K1ZHWS9PN2FCdW9OTlNZQkpVTTZCUHJXUFd5MnpqdytvTG01OThlU1RhQmU4?=
 =?utf-8?B?K29qM3U2WmlzWDhXbk0yZ2NOdmx3THhhMHpLOUUwQ1RiWFQrTlZ0eU05U3Fv?=
 =?utf-8?B?VXhHRnJEVEtMUEdzaThDbVlsVkQyWEtOVlZ3QUZ5QTF0TVlFd0huVGV3QmNS?=
 =?utf-8?Q?Adz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3MvWVZuMGRML3ZFYlpGUXJzOS9hamlKK1VkREdwTFk5MmpCNWhHbmJISy9j?=
 =?utf-8?B?REl4Qy9LU1dibmtZdmJ3Vld3ZEErL2FMSU1MbGxESnR3elZxTFNHY2c3RzZD?=
 =?utf-8?B?SkI5THArdjZGb0RXOGY1Nm1FSVBhMHFtSUk0Vkk1c3hlQjdwQWRwWENJSnFO?=
 =?utf-8?B?U2s5SXhseUZYMHFRSU0ycStDTzRFWWZ5Q25xWVFKdlFTYlM3UEdKQ1hCekl2?=
 =?utf-8?B?UDZ3bzZxZ1FvOUp3MVphZzY2c0J4UU16VitsK3NLUzVnRGJWZFdpaHFKOGdI?=
 =?utf-8?B?NWJ0dldPQWVLOXZTVndFZWpPNk5jMDltOTRTdVBneEJocnk2d1N0TmZRS2pu?=
 =?utf-8?B?YjlIem5LdkNQbGNYOTVRMzNiOERVODlXOW5wdFd4bHI1VXFielZ2dkJydVFZ?=
 =?utf-8?B?R3hVYkE0N0JjTHJ1TDhWd29kc1d5SzFWNGUweml1V2hoRHEvV2JZRDRTazRK?=
 =?utf-8?B?Z1h5ckx0RjVWQTVhZTRQSTJ2VDMyemtOcEwyVjhvenZtb2FDTTFxM09ROTRy?=
 =?utf-8?B?cC9nWjhEb3RJZ3NtV2FpQU9jY09RY04zZDVaZWdTeUZrdktrZGtSa3hUMGZD?=
 =?utf-8?B?dktUaUtWL252SWtYODNsRkUvTjcxaU1iRFdkTGQzT1FKYzRhT01qK0NSbEs5?=
 =?utf-8?B?RUMwZXY2ZnpQNG5pUDE3N1ROOVFYUTRUWnVabDQrTjRMekw1T1VsV0g0TlNp?=
 =?utf-8?B?NlBreXlCNm45ZVNrYzYwOExIdERzZ2dYMFlNMWFyWk90SUpLenhDdjBGak9L?=
 =?utf-8?B?VkFGemh0aFdFYm9XaHNQQWlVdThWbXJWQk53WWliVVorWjJHL29pWXE5K0lB?=
 =?utf-8?B?OWFadEVhMFpyOXN0VTVBdkpNcHRBVlIxNUIwZ3FoYUVkWU82Ung5NzVtbisv?=
 =?utf-8?B?eEJXR2JieHRmeUVPQk9aQ2hiT3o1bDRDZ2xyb1RvREZtd2k4SUFvcXdGZUtJ?=
 =?utf-8?B?aTBGNzBxTVJYSmZnckhjU3BmZTc5c3VLSml3Y2ZtdTZFeTRqdi9La2J2a1d2?=
 =?utf-8?B?RXBzcENJWEdkOXBwakNURFNEUDI3blpWS3VCN24yZmVyZU1SZGt0aWVRdTdG?=
 =?utf-8?B?d3E1OVhsbTZ4clVEVVVaS2Z4NHBnSDArTEhXaUJ5OEkzSTJIcVBLQk1YWGxH?=
 =?utf-8?B?bnVlT3M4SncwM09TMVRGd1dhZmcwNkhISkRvMFFjeVFkUlN1aE12VFdTcUxl?=
 =?utf-8?B?alo2akFVZ2w0SVZ6dlZOUGhEb2hXRUZrdzdtTUt5eHpQY05NUk5wWTM1cis0?=
 =?utf-8?B?MGx4dllaY0lqOFNzUTYwNmRaN050dmFhbnNiYW5zZlFFK0cyUk84cDhrQTdZ?=
 =?utf-8?B?bVJvZzU2U1Vpa0pQb21XdExKeHdSVHZWOFI2V1hmcmIyZmtYUnhlL1o5RDVI?=
 =?utf-8?B?L0s2NnY2cS9ON0tpbTM1Vzdwd0MvS1VnMWE3R253RktDem9uVkZSVkxsSTFF?=
 =?utf-8?B?NkFFSktyS3pRTXREaldDTWFBWmpsNVR5RHdFa3F5Uzh1OEoxNzhpMFhPR3NN?=
 =?utf-8?B?RGhkbDNmL3IrQ2lscmhvN0p3WStYbW1WWkwzbWQzcWlYSTJxNkpzODJsSzEz?=
 =?utf-8?B?R1Ezd0o5R2FoRGF1WE0yNk8wRzFMZkJzRTJDSWJqMk1yR3VKamhadXgraHRi?=
 =?utf-8?B?Z1ZTN0twZGtId2E4VTVnR0xxMWN3T242eG9BZU9VMEZYc2ZsUDgzMldOYjNB?=
 =?utf-8?B?eS9FOEw5U3ZONmt1WmF6eDJxeUJEdUFhV0ZkeVFSSFJtY3RWVW13UjlUV0ds?=
 =?utf-8?B?U1BoZUt5cldTOU8zM1l3ZVViVEN2cEloZDc0Y3p6a091UzBlZ09zVkh0eCtn?=
 =?utf-8?B?R1ZNNGQ5RnBCWXZjUWZ0bW9waHVrTDM1M3RZVXQxeGVRZlVjbjhDM2wwYndk?=
 =?utf-8?B?T21KTFA4cUtGbGRCWCtDSFVqQ3pTS01zVC9hdDBUcGlQRnc3MFhJRmxLeHJo?=
 =?utf-8?B?YkhoZW9yV0VVcnhTc0tvdjg5Y0hMbm92ckM4VEN4aURQMEwwZnhYSkF6L3Vp?=
 =?utf-8?B?VWRzMWNUWlBuMVIyWktjckc3YitoOFdXTVBKWnlIU3gxSDJTckcwdlNwYUVl?=
 =?utf-8?B?bmNQbXpmTjFvMlg3MDFKK1RURElZY205YVA1MUUydTFaNUVXY2FUOEdyL1J1?=
 =?utf-8?B?c0V5VWJoQ2ZHZy9EeWF2V1hhQmo0T1lELzVEZFFaR0V6KzZFUmdwZnJMQXFJ?=
 =?utf-8?B?REsvWnU0RnlObFJBUW93T3BoQit6b3ZQZFBoZzJja0VkYnFra3pmU202dHRu?=
 =?utf-8?B?bnVTNno1MTNnOFFBZVRxK3VPVFk4dWxBUWJON3lIS1FrUGZmRE5GYTE4R3hE?=
 =?utf-8?Q?wOQ38bHf6nhdGqRGpq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db859f6-a175-419b-8718-08de63d2f4fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:51:24.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSt6gzmvHox9IrRQqxbqzkgPD2vGvQ6ZH/cEjcxlxRUoFaagpK68wRaKzBFyBUyH9pzrYeRvjeVmW7nlc9WEfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20848-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 83291E416A
X-Rspamd-Action: no action


On 04/02/26 01:58, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/3/26 2:24 PM, Rafael J. Wysocki wrote:
>> On Tue, Feb 3, 2026 at 3:32 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>>
>>>
>>> On 03/02/26 18:24, Rafael J. Wysocki wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, Feb 3, 2026 at 1:45 PM Rafael J. Wysocki 
>>>> <rafael@kernel.org> wrote:
>>>>> On Tue, Feb 3, 2026 at 10:41 AM Sumit Gupta <sumitg@nvidia.com> 
>>>>> wrote:
>>>>>>>>> Hi Sumit,
>>>>>>>>>
>>>>>>>>> I am thinking that maybe it is better to call these two sysfs 
>>>>>>>>> interface
>>>>>>>>> 'min_freq' and 'max_freq' as users read and write khz instead 
>>>>>>>>> of raw
>>>>>>>>> value.
>>>>>>>> Thanks for the suggestion.
>>>>>>>> Kept min_perf/max_perf to match the CPPC register names
>>>>>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
>>>>>>>> CPPC what's being controlled.
>>>>>>>> The kHz unit is documented in the ABI.
>>>>>>>>
>>>>>>>> Thank you,
>>>>>>>> Sumit Gupta
>>>>>>> On my x86 machine with kernel 6.18.5, the kernel is exposing raw 
>>>>>>> values:
>>>>>>>
>>>>>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568 
>>>>>>>
>>>>>>> del:437439724183386
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615 
>>>>>>>
>>>>>>>
>>>>>>> It would be surprising for a nearby sysfs interface with very 
>>>>>>> similar
>>>>>>> names to use kHz instead.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Russell Haley
>>>>>> I can rename to either of the below:
>>>>>> - min/max_freq: might be confused with scaling_min/max_freq.
>>>>>> - min/max_perf_freq: keeps the CPPC register association clear.
>>>>>>
>>>>>> Rafael, Any preferences here?
>>>>> On x86 the units in CPPC are not kHz and there is no easy reliable 
>>>>> way
>>>>> to convert them to kHz.
>>>>>
>>>>> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
>>>>> in CPPC units, not kHz (unless, of course, kHz are CPPC units).
>>>
>>>
>>> In v1 [1], these controls were added under acpi_cppc sysfs.
>>> After discussion, they were moved under cpufreq, and [2] was merged 
>>> first.
>>> The decision to use frequency scale instead of raw perf was made
>>> for consistency with other cpufreq interfaces as per (v3 [3]).
>>>
>>> CPPC units in our case are also not in kHz. The kHz conversion uses the
>>> existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are 
>>> already
>>> used in cppc_cpufreq attributes. So the conversion behavior is 
>>> consistent
>>> with existing cpufreq interfaces.
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.com/ 
>>>
>>> [2]
>>> https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.com/ 
>>>
>>> [3]
>>> https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com/ 
>>>
>>>
>>>> That said, the new attributes will show up elsewhere.
>>>>
>>>> So why do you need to add these things in the first place?
>>>
>>> Currently there's no sysfs interface to dynamically control the
>>> MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
>>> users tune power and performance at runtime.
>>
>> So what about scaling_min_freq and scaling_max_freq?
>>
>> intel_pstate uses them for an analogous purpose.
>
> FWIW same thing for amd_pstate.
>

intel_pstate and amd_pstate seem to use setpolicy() to update
scaling_min/max_freq and program MIN_PERF/MAX_PERF.
However, as discussed in v5 [1], cppc_cpufreq cannot switch to
a setpolicy based approach because:
- We need per-CPU control of auto_sel: With setpolicy, we can't
   dynamically disable auto_sel for individual CPUs and return to the
   target() (no target hook available).
   intel_pstate and amd_pstate seem to set HW autonomous mode for
   all CPUs, not per-CPU.
- We need to retain the target() callback - the CPPC spec allows
   desired_perf to be used even when autonomous selection is enabled.

[1] 
https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/

Thank You,
Sumit Gupta



