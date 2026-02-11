Return-Path: <linux-acpi+bounces-20943-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEqnIjnxjGmSvgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20943-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 22:14:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAC127AB7
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166CF3017518
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29B35E522;
	Wed, 11 Feb 2026 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M5upYhY+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E535D616;
	Wed, 11 Feb 2026 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844461; cv=fail; b=PUnx5TB8a7VXc49qXlirMyF2aQyNB8WPXhEONdVjMvyktmZN1hAbO7vUWZFtqOTOyAsHoj9DqnuKfH1rjwndl13v/b4i3MF8SdAe9dkWQyajYNz+JOUsY/IV31g3NyBisxX6yWTKPbgzzYJlOVh8PXTUI/WKXyrNn5eOT59ELNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844461; c=relaxed/simple;
	bh=FVIlX8vekKek02sa0wUdYwSSXAB0GELhgvzHiexTQIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HlJ2E+VUMwwcrUecQPnFTxLfQVDU2yacrP2WveWFnIj+djyDDPSy62ffusRzaUrDnxNazL4umR8ufSn/cWCNAAYIM/Uq8NZZIAZmaldb20uWVHVTD4OrzIaDJSWsVpuPfX4bA36XYoS1th4XQ5yhxzgMSR+7VPJZn/NOy+ddnb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M5upYhY+; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzWtS5cKEf4lhg1eN3+cXst+QcmBi9jBbB5pqnEcAfg4RboGaUeorksA+NlfP1xTWHXc2RtobNxAs1M7IglfXMIbCkvKEonJOm1UlQNt0lQCI7er4PdCAGukDWnBgN6JqWI+Rorx6OGyXyFc1ng4pRxsutHQO+MCM59qOO/K0ZeAm4HWYQ4eCfBFQpK+I1rSMhGy0r/CQJ14aSS6KdOD+EolxJ+5M3VOUv/KOY/Z0qsl34GlpbByUKrUF8eQUMbhDAb0KWmN2RI7q5TAacJ2kqwi9peJNeryL4nYNAIoFCikJs8IBUEmJmvhrGEfN76JlOGcALq660kvIxIu8TeRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0+bLH57BLudZw/5QZUKKxyf0xeRDFB5E+XfUp5Goek=;
 b=Ntz9WY5tYaCHa/Qi9E8ArNfE34pquaP6ZxeZ1aozasWya2uF/XyXjB6RiMQE3I8LTEKkVMnh5eVr+Rl/3Lguy6hs/+JZyk6zvjq71HcKnP+mmUpfydj16OzWpdVQG57/3Y7KsdLtsGVrDPwSOzJOvRBxiAwv+77k932W0qDo76zSNz+tIf9AoRzl9tieU/lcNzBOVPOfa500Q2uLYegyJSI/QPws2WhIIjX89a+ZAubhcuakhafdtWZpX/IzjEdiOtMpwQYxflzxI7eECznc/xmTRDPOXejun8da5JWgl6/XWaRdGrWSS5/GVSolUegWHI8ideYQe86H4mTBMzZq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0+bLH57BLudZw/5QZUKKxyf0xeRDFB5E+XfUp5Goek=;
 b=M5upYhY+9045dyt8yiRUVfhwT8buhRs33Ntcz7amd3Z6x81/TXnTs5HKoMFhZgJJ+mxhmzAaJLvGkmqsH65hYYcpSgFrewNUvFCVIpNVZY5rBYtAEZQb3aECiBdMp3homGm4Tu9NLVx/xg1GHQ1fYfJt3ahPudn50JLxfhBrXShBPVUT0wSDFjbWBZVcF5OEH2Z/YxXxR3RRS0kCCx5kv5St4HVEo+udXOkIgYUtUwbG89hk3xXyQvppxNWxOQDIWN/w1YNTN1KgWlO5amdOCLL/6rvV+o6nBWK9PHXrqoi3MdcTl1+oEjgisQUkRv9MKauOjskxB9zJ8zDrlKyM4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:14:15 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%2]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 21:14:14 +0000
Message-ID: <e97c28e8-b3f2-4a01-880b-c23636b0630f@nvidia.com>
Date: Wed, 11 Feb 2026 13:14:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Fix acpi_get_psd_map() to iterate only online
 CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, pprakash@codeaurora.org, gautham.shenoy@amd.com,
 jamien@nvidia.com, mochs@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260211204838.21269-1-skelley@nvidia.com>
 <CAJZ5v0i_nGinh8ZJjEK0vbn0hoMj41cRt_NuwvrN2JdJen=9HA@mail.gmail.com>
Content-Language: en-US
From: Sean Kelley <skelley@nvidia.com>
In-Reply-To: <CAJZ5v0i_nGinh8ZJjEK0vbn0hoMj41cRt_NuwvrN2JdJen=9HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 570372bb-0b96-47d3-e951-08de69b28274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFDWDNVRnROZ2Q0MHBVN3JqM0tUZFZjdDZnMlVscXJxby9qNHgzU08xdzdp?=
 =?utf-8?B?bTdPMk5KWXBVQ0dpOVorK1Y0TVpQbEFTREEyeGc5TCsrQkF1bVo2ZGRjZ2dX?=
 =?utf-8?B?dG5VQjVQcGJGTlNVaXFaTlRVSm8vM1R2MDlweW5qblR2MjdDWW9mNUYzZVJN?=
 =?utf-8?B?RVorUkFSTmNDdG1zN1RDM1ZYaDFWZnp0eHVmRWs0ZFY3RnA3cVJVQzA3Z3ho?=
 =?utf-8?B?SFIrN2x3T2YvTDA3NmVxLzZPWWR2cHQ5ZEZmSC9CK2tjOHFaZjR6ak1kVm1C?=
 =?utf-8?B?QVRxbjBEUXh6NnRHTzhNenorb2oyR3oxRHlldVdNcC82N3JheTEvaU5URWQ1?=
 =?utf-8?B?TDNSY3NXcWNpZG9Eb0MzMzJFUURpQ3hYVjVZaDZoSWViYXYxS1NNWVZTQ0s1?=
 =?utf-8?B?aWdKNnM0dDBuWkV4c0FrMWpZQ0xKdCtZbUVZRkxodzE5ZGN5L1p1QStEYWJ2?=
 =?utf-8?B?OFBxT0J3NDhrVUlud053MEs3dzZqOXFyZHJrbXRjR0wzTXhwYThxa1BkRFdk?=
 =?utf-8?B?b0pOeXh0TEk5ejk4VmpWNytKTDJBZ25NQ21lOFVFMkl6aHZVZFV1TmRJQWFy?=
 =?utf-8?B?aGZyVER1VVpFcXZFZHZsSXllL0gxZkI2cEUrUWxZQVU3TEhjVjcxZkpMajNH?=
 =?utf-8?B?dllwU0VYNGwrSTdaZmdoeXFOR05ucDZWVk8wNHVDUTF3Y1ljUDlOcVk0N2RI?=
 =?utf-8?B?cnBPMEQzQ3Z3ZmVKUnpyWGFCZ1pCNGJ4eERaMVV6TURZQ3BhaHBoSGhGQVFs?=
 =?utf-8?B?bUpjd3htTlkyZm5mS0FIUUN5a0QrUmtVYzV0VEhYS1dKSWhpK1RaMVZmeW1r?=
 =?utf-8?B?RWlLQkNZczMzTUNERGVHajZpeThLTzFjNXlVUUdtZmdBMGZqaXpUd05mM2g3?=
 =?utf-8?B?Z3pYQS9weXUreTMxVlp2NlcvR1NYNzVrQW5ZY1M0RGdhaU9pRUJ3cTNqZzl3?=
 =?utf-8?B?YmEyWWFucTlFeTFvaXVmWDJtUjNyVEc4TkVOTVNBdVhzZWJKSHJDZng0ZWdN?=
 =?utf-8?B?anU5ME9GV2diSzVjZDhZaDZuMktZNngxSExFY2thenVFSkY5RzF0OG5ySnZQ?=
 =?utf-8?B?NWMwbVNaaFd3NDluWUFyeUtmSEJLMG8rR1RMN0pXcTQvbW1rNGJoS3ZZTjMv?=
 =?utf-8?B?QTg2VTFpcWxNYXA0RVdRTU9WZkdtMktXdERveDRueGcza2R6UlZ6MG16NkRz?=
 =?utf-8?B?bFpzMmxNU1NWdEpqcHpwRm1Xak9VNG1CZFJmYUpneHBXamhjNHRRdmp6VmF3?=
 =?utf-8?B?Y0Nrc3dpYmV5cWhxVy9FWm1kY1ppdU10NW5VaVBYTXkvUXR5QVRVbjVHUXBN?=
 =?utf-8?B?SDBmNVlZeWtqNmdmWC9zNHpIZzVxcVZxRytaRHFXZ3Fhc3AzQStOdFpUTkdw?=
 =?utf-8?B?K0I2eVJ4UUlMWkdrZTVYVmg0YUF1ZkVNbEFSSE9CNVV2dXRHSXhFVFJ1bncr?=
 =?utf-8?B?OHdvTm5yNVlVajlDMnFtR0F5a3o3WHZXRkkrTkVLYnhvV0JzOXhoUW9ONjJY?=
 =?utf-8?B?SWVrVHA2M0Q2MGtEMG05RitHZzRCL3RnUHFKMStqU0F4eGlqWFBOM00zZ3dp?=
 =?utf-8?B?T0Fab3FiMG5HVFg5aCsrTXBZMkc3SWpMc2lwSkZGZ0RoaXRlaXozRHpNVlN4?=
 =?utf-8?B?K29mREpWNHI0TUZIYnBZd3NYcDQ2T3F4Q0I3SVkxc1NxdGtpSFd1VUUrNVRp?=
 =?utf-8?B?RkZkdHFUdVU5ay9OVkxoWnd2L292SUc4KzluZmNJRFI5NzdTL0s3bDFmYUFz?=
 =?utf-8?B?eExoL0RXUEtTK0xvc3c2YmpQRHZoblR4b3k2WHpOTG80SEZONkEvc28wOCtU?=
 =?utf-8?B?SngzOUE0bllTV2ZQZ3JVeHE0WXhnMGEzbERCTWxqSThpS1REWS9HMjJIekhh?=
 =?utf-8?B?ZSt4d0djclB1Qk9TbmhhYy9GZFJLd3cxN0ZFL2JkNDFtMWxwczFITVRBcDha?=
 =?utf-8?B?VjRxL3o2Z1lZdHBzUnBnMEhtejFIWkJOWU1KczIyQWVlQm1KWmNyQ1FwQ2ta?=
 =?utf-8?B?anlNaWJVTXRaaUQrRm5YYTRGNnZPR3dWd0puTGdHemMxTWJaeCtvb0lzVDFR?=
 =?utf-8?B?bndCckN6L1FBUVIyVTZuOWJxWjhvRk51N2h2OTl4WFMxV21leXUwZmhMSmlM?=
 =?utf-8?Q?iosE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEN3RDV5aXRwaVNWU1phVEF6Qmd6VStDbS9RdHhEYk5qekhESUt3Sy9raG03?=
 =?utf-8?B?bXBZY0JlTXJuY3FPT3U3NDZtOWZrelZmYlAyZjk1U0JpMml5eDhXeVBHV1M0?=
 =?utf-8?B?NWFodm4vWUM2Si9uS1ZzL215L0RtOXYyR1ZLVkFFVVFkYThtZWt0YnpQd1gv?=
 =?utf-8?B?b3dCWXFPd0xzTjF4R2tESUdpaHV5cVBaUTdxT09lbzg3MTlvbk9QOTZHWlpM?=
 =?utf-8?B?eHhEZkdTOWd4NnNyWjIzSlYyVituWHU4T2lZdnV3RDNsRVZWN3lpS3hPbk1M?=
 =?utf-8?B?eWR5N2wvWE15T3pKcGhVdDFTMTQyK1pxSENsMEpsMlI2R2dndlAwdExtTTJI?=
 =?utf-8?B?QmxUZG5lM3ZaclNsSVRZMnpGZEhzR1M3a3lCblZUUUViL1BEelYzQ1FmREI1?=
 =?utf-8?B?c2U2TklrTVR3ekdjOFJneVAzSUFBQnBKR0lSODk1c0Vyb3FBd3hwNmFiTkhx?=
 =?utf-8?B?MisxSi8rbFF4VGFmQ1ZBQmNxbk95Um1odUh3NUhPaWZlcWxMTFlDR29xcGNR?=
 =?utf-8?B?YVhZMjk3RGZxdTNmUHh5dkp1TVVBbDRodE1NRmpWR1VuT0hvd053QzlsbGI0?=
 =?utf-8?B?UEZJMEM3UW9LbmZmMzF0bDl0aWRRVDZxQ1Ntc3V0WFBOUElXWHJFMHpzUnBP?=
 =?utf-8?B?MWJnT3BZUTlSemkrZkc1Wk5PZVNick5OaVUzbXF6a3VDMldnQldFYmZvSzlV?=
 =?utf-8?B?eENEdmlKeTZBQVU0SExpbWl3UnN2Sk5DWktwWGtQQzNVVGJuczN4d3FFbXdi?=
 =?utf-8?B?T0h1elBQQm8xdHBwbjZFMnRJbjZEak1BVWVOdUtVMFVkekY2QXJkeThOTVV3?=
 =?utf-8?B?RGFNTzJ4Z08wdVZzck1vV0VoeHZ3THVtSXRCb3E1dkZJWEJCVmxVNEF2d3NU?=
 =?utf-8?B?M0t2TWdFaFhLdG9QSkZOTlV2V0NQR29QWWUrNXlTMVFJREJVL1ZQOHFDcVpv?=
 =?utf-8?B?blpRNGh6Uzh3d0d4RldmRS9JZHhFczYyNEQ2Y1FGVllNemVjcjN5andqZG1Y?=
 =?utf-8?B?b0tuRHRoQzRxMGREOU1QYUJoRGNCVFo4WTJGOVE3SW1TUVdIV2xrYVp2Myt0?=
 =?utf-8?B?NDAwdjUwdUFOdzAxeVJYQ3hrYUw5R3dBdDdNQnNUbllUU2FIVDVFcXE5RUF6?=
 =?utf-8?B?NTZ4YUl2eEJzeGo3Q1A2UC9NdlRBQjZudldoR2V3VTJNOWRKSDYyZWI1bGp1?=
 =?utf-8?B?MmRTWDFZYzJwbVpUVTFzaVhQeVd2NXpoQjZBTTRRbHVwT1BDSGFMQ29hVFZi?=
 =?utf-8?B?bWJtNWw5Y0YxWmc0YzZKSjRqM0Ztb3ZtNVJVRVUydFZOY2EvQXpzWEhGc2VJ?=
 =?utf-8?B?VTdUb1N2RzRhUGV1YnVncXRLVTZCb3FLVklDTUUxbUdLY254N2pzYmR4Mlc1?=
 =?utf-8?B?VWZWMWZ4SWY3aThjemVRT2hDYzNCN3QvL3ZxTUtSdnFzN1V2QmxNVXczeG5r?=
 =?utf-8?B?VUFLVlZTZVRERmlmQlgzUWNQdWd2ZFZ1SU9yQVNVWVpkemt3MHNpcEZVRVQ3?=
 =?utf-8?B?WHAzMWxVM0VtRWYwRVRtQ3lPdGpMYW5WS3JQaDhKZUlCdHFjL25GTlcvbVNQ?=
 =?utf-8?B?MDN6L0MyM3JJQWdaVVBNRzBhazFDVFpJQTNud0ZCdjQ4ekRHekd5UlhUY1lB?=
 =?utf-8?B?U3o0K1hNelJhRkx4TU9YdjM1cnh2aXNTMXZOMXR3SkJWbWwzSmhDUk53eGVT?=
 =?utf-8?B?TGR6YkFvTVF3c2VFR2k1ajFIYStXYUNWcDAvN1RPTU01UjZNdUZmRmh0SitN?=
 =?utf-8?B?TWRHQVQyMVkrUlBGUXJCQlVORkNFWUdYdDdaa1YzekJ1eGRneW9QZEFmZm83?=
 =?utf-8?B?YTIyNnp4bmJKeExSTVJqQUhjbFlPU3F4bzZuQkVqVStIQnUwTXIwMlBLdG42?=
 =?utf-8?B?SzlqdnUrWHdoZW5EQlFRbzFnNXI2RTViL2U3WkhLWlNwYmE0eGdWU25ncGRz?=
 =?utf-8?B?Q082aUZCVTFFNUI1QlgvdkJCWnhqU2V6N2FOS3ZTdlNkTFFxRXlqU0VjQzB6?=
 =?utf-8?B?VXZXMmM5blhXZHVuMkg1ajNhN0Z6NDNVUURXdHhLVVYrRnIrVWo5eFJITUZS?=
 =?utf-8?B?RjB2Z0hRY1JkVWEvVHQ4ZUwyOWpCRWYyUkpVNnlqc3Q2Zm5Wa0lnZDdXcUZz?=
 =?utf-8?B?RFdLOFc3bEt3aW5Hd2JGMlRFL1lCMHliSGRPcjJsTTAzeEt4ZnJvVGJnTWd0?=
 =?utf-8?B?S0YydjNQdlc3b2VYTzlzR1VLMjRxVTBvLzVJbzFrckxLbVk3WEhQZGhWTXRk?=
 =?utf-8?B?Rmphd0pYakh2WjVmeUU3MEw4NGo2cTU3eFluc2xWRlZjdUw3eHl4WXhOWitC?=
 =?utf-8?B?cUx6emtQN3l6aDZCQ3A0RVBLMTdlQ1V4SmI0bDUyN3BQWXUzbVFHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570372bb-0b96-47d3-e951-08de69b28274
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:14:14.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxUO2j4tqN2BJgI98/i36goBcu0aY4XSo09RX4H0JT1iOdJ2UyNLnPmqjNL6Hlr7xK/VOgC9rz6sNv4G7+CLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-20943-lists,linux-acpi=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skelley@nvidia.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Queue-Id: 1FEAC127AB7
X-Rspamd-Action: no action

On 2/11/26 1:06 PM, Rafael J. Wysocki wrote:
> On Wed, Feb 11, 2026 at 9:49 PM Sean V Kelley <skelley@nvidia.com> wrote:
>>
>> per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
>> CPUs via acpi_soft_cpu_online() -> __acpi_processor_start() ->
>> acpi_cppc_processor_probe().
>>
>> However the function acpi_get_psd_map() iterates over all possible CPUs
>> when building the P-state domain map. When it encounters an offline CPU,
>> it returns -EFAULT, causing cppc_cpufreq initialization to fail.
>>
>> This breaks systems booted with "nosmt" or "nosmt=force".
>>
>> Fix by using for_each_online_cpu() so that only CPUs with valid CPC
>> descriptors are considered.
> 
> Thanks for the patch, but there's one more instance of this in send_pcc_cmd().
> 
> Maybe fix both in one go while at it?

Good catch. Will do.

Sean

> 
>> Fixes: 80b8286aeec0 ("ACPI / CPPC: support for batching CPPC requests")
>> Signed-off-by: Sean V Kelley <skelley@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a09bdabaa804..e7cfd4cf029a 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
>>          else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>>                  cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>>
>> -       for_each_possible_cpu(i) {
>> +       for_each_online_cpu(i) {
>>                  if (i == cpu)
>>                          continue;
>>
>> --


