Return-Path: <linux-acpi+bounces-20074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F9D03AEA
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8282315A915
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6B474BFF;
	Thu,  8 Jan 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnxbBQ3c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A68474BF6;
	Thu,  8 Jan 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883127; cv=fail; b=Lo60ZktueS2MxETUHoCLc+mvb674HozS3FiiDbQjwz0llGrBFdt6gtsNtoZBD2BJGFUUcMZAKjI4qq3jzFxdCNyNJR31yGOcUuydlFV4rKif25xLI3/zrrkgTewV461Xsv+Dfm01tb6I+J0ynt6I+sEesVpOOEnQKWLbnkOEN4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883127; c=relaxed/simple;
	bh=sB382uQFQ4C9iuzerHEQPiIhQh9IyOh9IpX3hVHoxUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFXd7Wth55IiGMKsl6HLbEBHlxi8voU7rgJSLZ/SP0iebGJWRouivyzWDOEG6aDoZ6L5e1oFZGzoc9Stqxg7JEgOoXKqc9axGxVX19iadzoVwYNZIgId4MsxwgyQE+N3WWb1d5vyG/zJyXfbn2L2b+4qkBg5Dq/ezPNxCcbOnAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnxbBQ3c reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrPY6S6vsHCZtSb5t6xYw0Za2j/IXr/rQPD20SEMFL8ffge4h0wuN5l1qpGL8YMtwz77v5kWnzig1BsmEyI+S9JnBp5QrP7iYxoJIujVaG68KbLekQZk0hI+Um69Z42/bCu+oHA/DlLgQYPJf2VBw342Br/FYYh+3b5iyCkODwMTGfAwxSlagulIuNJmCCP8Z6zB/sXaGfqrVHyFnsjZH1MshKtAkMcDf8EbgtPaj+qQvnr1rJuUANg7P/watm7oZnDpomScvd0R0vEl4v5W1pbUAXMYf2ejsZMfzf/cUttNbtYr8jClBKGnjdCdcLfuWFzmSfJPj0WWYUTJigTdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dHZ1WgT4ikYOHFH8NUwRepj+JduOV6sPoRsJpwtR1I=;
 b=lyJpAJcdGEcqGB/3eFTVRvhauFGMGIK0s9oSjMgCtXFcp71z3JJ5zV17fR6/eRsIlOhru+lHcCL8Y0SuRZSgHSflCCYQ4iIYrfhYpTZ6t1qDBEj6hdVYwiIwoJ7eiQ8JNzppK1fBT8B2O9Ui+tBqPymmjrycoktjclUzmeymyJCMsGz8EQ4Qgjj849ExSlu6tG/XtGKg1/WeJ067NEiR0L34mJWLDV1S9DaAexWfIJJxoPtoR+ky9uUpopaWpTqqNjY2ccZ33l40hUIOX1w4oGCwb6DeHDWSyO8SLPDRWM0qevuiM2xJq6mOufXH1usumUFGXTHxKpFuq83t2UQA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dHZ1WgT4ikYOHFH8NUwRepj+JduOV6sPoRsJpwtR1I=;
 b=mnxbBQ3cmHd5RyhB/awCW05EajsaJb8qNmsYpYoGjcavdKAPz/eSKqBZ32oEg6KwlXTgDLl1wEZKF89D41aEKuApPV5IJfV6YsR7R5jchON21U5c+M55tBbXB77mENapo03q89B2El3KOYDslclhZzfeJ+2pM/knKPfb0X9EyCYYSpo4U/wx5Q8pQIClnYjVjkmE0t0SEVmSqXZBJ8vE5aBSEuoPsvaSDvk1GfMHUeAhGViXQLLRF7RZoGnYvWO4JGMSJtNj5K8oHseu/1148aTPYbZzIEQ7YkmNQWXXQEx+KOxi7LfrjNL9RYSOecNecAn1Ke6YY09hN+MkF59fyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:38:41 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:38:41 +0000
Message-ID: <0a2b7d49-bd1f-442e-9247-705cd2eb0d1c@nvidia.com>
Date: Thu, 8 Jan 2026 20:08:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-7-sumitg@nvidia.com>
 <14851f8e-b6ac-42ff-9623-b7ac8d8893e2@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <14851f8e-b6ac-42ff-9623-b7ac8d8893e2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 069f0078-3869-43b1-5b78-08de4ec39e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjV3VDVRbG5oWUFrMyt1SkJoZnZVMk5qNnl1UWh5ZFRFZHlyQVAvaUdQRWRq?=
 =?utf-8?B?MGQ2QlVWQm9URjBRYmgvNStkcC82d3B3R3lzZG95RWdUSEI1QkYwUDRpZTlF?=
 =?utf-8?B?VU55TEZUSmNkbXpoR0VMdWZjWE9MVWtnWWJEQWI2Qnc2REpPUXJHTGhXYkNk?=
 =?utf-8?B?RXZsZnVnb3E5d2VRTE43UjloaE9CeHl4TGhBNm81UnFPOEhMdTRhckFZeXVZ?=
 =?utf-8?B?RFo1OEw4Z2hzZW5GUlQ0SzkrMm9kNC9WZHAxTC95emRLc0EvTVJEVTlxaUVw?=
 =?utf-8?B?Mlk1RzUrZDlDb1V5cGZnWVBnUnlCZ1Z3RUlyZzRLUnhFRmhSdkw2RjVvWG9u?=
 =?utf-8?B?SXhUUHpFbkcvK1lUUm5aSytKUk5YN1JWRGlsWDB4Y0Q1aXhvRVlZcC9WQmVL?=
 =?utf-8?B?OW4vTStCVkJ5TXlWVXJCZ3JTZ1MrT2UyR2VTMloraEsxMHNzY3Z4dmNjdU1P?=
 =?utf-8?B?MWJEb2UrRWNlNTZLOFRQVDE0RUw1bnQzdVAvM0FMRkZ3dU9tZjBzSjk1K2d5?=
 =?utf-8?B?ZjZCTW9JSjVhQmw0WmxqTTdCVTQ1eTJtL0lOL3M4UXlGTVVtdDlMT0crRlZz?=
 =?utf-8?B?YnMwOWlsaUdyVzVsTWNhMGdiSHJVbW5sT2ltNnNLeTArSk1SdFFXK0k3Y1JY?=
 =?utf-8?B?ZHBqRld0cnJ4eng0M1BmbnRhWkdDRlRBTDdTbzQ1OXZ2M1RDckFFaFdBbnJW?=
 =?utf-8?B?ZGFHVjlpemViQVcvMTlpMU83R1pPamRQNy9mOWxOTlhYK0hxVG9rQkZ4WUky?=
 =?utf-8?B?RTNLQWdVdjdVYmpHR05MY2F6VVEyZ2svVkRKVkh1MEkyMEo4K2dvaWI3Vm4w?=
 =?utf-8?B?RDBzODQ5YlZndjNkWlZIclYxMjNHNVhCM2U0bmQzaTlPV3dFdG84YjhqOHJR?=
 =?utf-8?B?cFViaVJjdVdCeXRnaTVnY29oNXBhb0lJS1NLbkQzRmZ4RGRRMmNvMFMzeVd4?=
 =?utf-8?B?djMwanE3QUNkSU5CUjMwcmtvRXdKOFRLaXZpNGJVeFdXZGtaMGtNa0YxZXgz?=
 =?utf-8?B?RnBGSE1wRTFEUFBMMzM5Yi9oWitSRlQzUXF3VEtSa2RmWlBvTUMrNTZDbWJH?=
 =?utf-8?B?anpqa3RWRUxOdFhucWVKOFdPbEhlNVg5aWNObUJRdHlDSXgzTzBNOXM0UzF2?=
 =?utf-8?B?OVYxYTFXS1B5aExrZ2VtUm1tclQ4VUtPNDNtdXlBMGNNRlY3TnEybUZLYzhP?=
 =?utf-8?B?RGdNcWlsaExYMHZwb2ZCcGE4eXJjOU9pc3ZWY1ljanN1alo5NnNmRGVEZ1J3?=
 =?utf-8?B?QTlFS28xUTZPTlBUQXBOeC9iNmF3Sk56QUx2RWh3RmNoRGs1OGM1TjRGbmxF?=
 =?utf-8?B?MkNPQzVNWVBMdTludWVPWVVPY2Q2a2JFUXVxSzZXWjhiNnpuTHpmYUNWcmg2?=
 =?utf-8?B?WHpTdTk1aE9zTU5Qdm04QzhuQXRnNjVPZE5pdCtySEZTK0pISGlNVzJkSzJz?=
 =?utf-8?B?cXBKenU4Qk9hdnlmamJRMXVuLzJrK3F1eTVvMHZxMkhjU1RHc3ZZdUFzN1Fp?=
 =?utf-8?B?YUFTaDRzcmRNallaTFF0OUdFRDM3Zzl6WVBRR2lnMGNWSHMwOWhCL2diMW9v?=
 =?utf-8?B?NG1VUmJaWEhHUTd2M2dDMklJcTB4cDdvVFZqQldWZ2Yxa2NMcExLek1mVERv?=
 =?utf-8?B?WVd4eTA5Z1JkM2swOUdXejZSdURYY0RBWjNEdVBqRS9RRmN3MGdMUGxEUmZ3?=
 =?utf-8?B?MjlMUWNseTNRTDNkK2I2TUZBS2ovb3pNSkJvWXd6cG9YNWIxL0lFS29IOHBs?=
 =?utf-8?B?ZllPRzM2ekFvUkZyVmg0amJuOVd5akd1Ui9jRkRXOE5hNXFUU2dJR3JHZWRZ?=
 =?utf-8?B?VVFOdTVZZmN1MitvVFNWeVQ1UURrSzc1TVh0YjhHL2h5K3ZrZ0tKSThiYUZX?=
 =?utf-8?B?dTdnSUMrTWRJb1Y1TGFIYnRRWjRFY1RGeWxlZHcxdjd5WENYaUxMQ2lWNWtS?=
 =?utf-8?B?eVM5a3hLSUg5azVCQUs4dSt4aXJmQzkrNzRVTnpYMU1WTzlTWmNmRjBJSUtp?=
 =?utf-8?Q?De4eJW+MXwj+EXPMGQV/MGxRuVEqRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWRFTDBIRW9JaHNuL3l1MytJa2xEUysyeUd6NndNb3pqS2ZWUjVJVStwTnpS?=
 =?utf-8?B?RHJ4NW0xMG5DUVBhL1BzNzNuekppREF1Undtekk3R3ZOMkFCUWNVV1NKSzh2?=
 =?utf-8?B?c3pFM2ZWdUZzV3A3RnRSUkhjVm1kN3NaRXMrMmJIemkzRHJ0RWRzdUplMm9J?=
 =?utf-8?B?SndSVGNwU0lQODZUT3ZpajVTMjVJL0Z6NjZlb2RsZDBBV2ZzUzlrbmhhUkxT?=
 =?utf-8?B?eWFZZUVuL1U3UUlvQW5udnE2Q25OQVB1bmtLSlIwUVBYTHdmbW5WVHNWaGk5?=
 =?utf-8?B?UXQ2bVJjZTJIQ2l1Q00xKy9vczVMbWFtaFVsMkVGcDdPdW4wbzVETDBCQTVv?=
 =?utf-8?B?bC9CMG83WHRPSHNJWGVFaE52dEQ3VktFZURRSDIreDFVbU9FdElWYjFMdWlP?=
 =?utf-8?B?TUZBWW9WSFAzUU1OZ3ZaK25yZHdLNDJpWDFjQ2J0L2hmMWhoSmlCY1BLeGdh?=
 =?utf-8?B?dFZYbFhrcFZvc2dBcFYyaklGMmk3SjgxWW5KT3E1WnRjSVhPTFRkTXVVc1NP?=
 =?utf-8?B?RTEwclp2YTN6cVRzZjVGcS84QmF2ckpyM3ErR2ZtUG1KWDlKM2dyUFJXa3d4?=
 =?utf-8?B?N3k0Z3ZTb3cvMzNjZWJhS09KS0lOT3JTVWtIdHhxY3ZQeDJhdjUrbnlGeSts?=
 =?utf-8?B?WUpZS1Q1amlqSXc2T0EwTmpUdFNuUHBKRXBtZFo3WDgyVUxDM1VqMkdnOGgw?=
 =?utf-8?B?ajkrQnFrS0VJbTR1eXgvK2lSYkNBU1dxeng3bmp6Q1F3a00vc1ZROFM4TVVv?=
 =?utf-8?B?WllCRlJVZ2ZTTGQ0eEI4c09nNnEwbkpqWG41Q2tIZHNTSVlnRTF4RHJrZ0VO?=
 =?utf-8?B?NnZRUDdRMko5S0xNcXpSTXlkSTVnOE5CVWUwNEVaZkV1cFRDaUo2NkE4b05n?=
 =?utf-8?B?SUFDSHRTTWE2bjF5c3hyRWV0c1Z4cE80YkNNRWNDZjBkMExBdmxqNVN2L2V5?=
 =?utf-8?B?cnNmNmd3TTFTWnpTK3kwMWFHL2Rla291U3V3TmxLLzFaQ29Qdk9aSHhIYUQx?=
 =?utf-8?B?RkptcEh0NHVSZlgwNzhCK1RNUk9RR3JERkhxNi9ib3h4Ym5MK3RXTDRQMEFB?=
 =?utf-8?B?bGN4dU5XSm8yVU5QMDVvbGxmeVdSZ0poUklNbEYxbTVjdUxhSzFOQ1Ixd2Rs?=
 =?utf-8?B?eEFGRU9oNFhQMU9hdUJjZXJKWitBWDVNN3BIMVdFSzJJeXJVc1N5K1hwRVpP?=
 =?utf-8?B?SldURDZaM2llNXQ5bCtRQ2c1dHNJTXBTcCt6Wk8yN3NsNjNSdHBLUkhNU0dX?=
 =?utf-8?B?VTdRQ1RYSm1hRE1VUExRUGt1TTRqTURWUWhncWxSZk1SSDVxZnB0eW9XeW4r?=
 =?utf-8?B?bVY4Z1dnMkRXRFRtUnZyVXZvdjlDQzY4TUFHZVNSL1ZrczRFK3lSUjdBdThP?=
 =?utf-8?B?Qmp1Kzc0dnJxdGZMSTVnYkdhRkZLN251V2c2Y1ZpZHYxUXlLalBaMHA2eXNt?=
 =?utf-8?B?bFdYVkFlTnlzcVZqcWtxeFFDWkJpOGEzSm5NSEU1N1hPQXBzMklMcGZVWTZH?=
 =?utf-8?B?eDdBYWh2OEpQaksvdEFKTC9sTCtrbTJ3blo4OENmR20zcm56QXJKa1ZBZS81?=
 =?utf-8?B?TGJhSTdkUkxFa2VvVzZRVVpER3ZMdy9leWhhS3RLdEN1dEdxUTFKSzFnald4?=
 =?utf-8?B?OFpBaXFqWEtIUThIN1M3dFZ4cHN1Vm56My85U3cyV2lTMDNKSlk4ZVZzb2x0?=
 =?utf-8?B?OEZJNUpyYnRaSUZqcXh1dFhsQUlFOTlWR1h0MnV0YytmUUdoKzY1NkNtalBi?=
 =?utf-8?B?Z3JxRG9mZVhQVHlJYlA0QnFZd0NpbDU3a3o2aXl0QnErbGJwWVorNkRXM3A3?=
 =?utf-8?B?VGJWMzBSNXp3WGYvalhETnBaVXF0QXkrVkloRjBMamVrYXNnUnZaaGVDVDdL?=
 =?utf-8?B?YjFPTFlvTTg0em9kUXJxYnRZbFJKOFpoNnRqSG1rQ3BDeWlQazZSYSt4bmZX?=
 =?utf-8?B?TWVMNFJ3VDBlcjZqKzhhZndIOWYrQmovY3h5bTU2S1VPbTV1WWIxb3FKT0hS?=
 =?utf-8?B?R1pQSllvMlljek5SMkNXOGlTdmtpU21DK05kMHUwZVBCVG55SFdkZzVsaEdo?=
 =?utf-8?B?dVpIUSt4d21rdEZnV0YvbkptcTJkbDlncDB0UWhCT3c5OW1rWWp1ZjgyUHlE?=
 =?utf-8?B?cUw3V0VheFdXQXZRZkxCcEZSOWZBdXhzQS9ZdXV4Umxadm9Za08rUGJnNTQv?=
 =?utf-8?B?RDM3SWFtNFJHTEFjQUVsTThyTXI4ak1ia2JvL1pvRlgvQlo2cGdtT0JxdmY1?=
 =?utf-8?B?c3pIcmpVL1Jvbk9FU3ZCNVEwQ0JLSkdkbWU0LzdJMVN1QjFyRjZwdlBPVFNK?=
 =?utf-8?B?emZCNy8yNzhGSFY4MlRnSXN1UGF2Y1dWQUpFUWRya25mYkt2VnlRQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069f0078-3869-43b1-5b78-08de4ec39e2e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:38:41.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2g1yfZo9FbEQDQb3WXumMuGFfngKyfQKAXfppn1DkToFzhL+1o5MTzB4qIRVWD21dbKZ8graEg9qscgEoZ1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704


On 25/12/25 17:36, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> Add sysfs interface to read/write the Performance Limited register.
>>
>> The Performance Limited register indicates to the OS that an
>> unpredictable event (like thermal throttling) has limited processor
>> performance. It contains two sticky bits set by the platform:
>>    - Bit 0 (Desired_Excursion): Set when delivered performance is
>>      constrained below desired performance. Not used when Autonomous
>>      Selection is enabled.
>>    - Bit 1 (Minimum_Excursion): Set when delivered performance is
>>      constrained below minimum performance.
>>
>> These bits remain set until OSPM explicitly clears them. The write
>> operation accepts a bitmask of bits to clear:
>>    - Write 1 to clear bit 0
>>    - Write 2 to clear bit 1
>>    - Write 3 to clear both bits
> It's a bit odd that users write a 1 to and then read a 0 from the sysfs
> file. I think it is better to seperate these two bits, as two sysfs files.
> Then users can write '0' or 'clear' or others into them to clear each bit.

I think its better to keep one sysfs interface per HW register.
Can change the perf_limited write interface to accept bit index
instead of bitmask.
  - Write 0 to clear bit 0 (desired performance excursion)
  - Write 1 to clear bit 1 (minimum performance excursion)

Thank you,
Sumit Gupta


>
>> This enables users to detect if platform throttling impacted a workload.
>> Users clear the register before execution, run the workload, then check
>> afterward - if set, hardware throttling occurred during that time window.
>>
>> The interface is exposed as:
>>    /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h       | 15 +++++++++
>>   3 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 9f28c20d902d..ffd866c1c00d 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1786,6 +1786,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>
>> +/**
>> + * cppc_get_perf_limited - Get the Performance Limited register value.
>> + * @cpu: CPU from which to get Performance Limited register.
>> + * @perf_limited: Pointer to store the Performance Limited value.
>> + *
>> + * The returned value contains sticky status bits indicating platform-imposed
>> + * performance limitations.
>> + *
>> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>> +{
>> +     return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>> +
>> +/**
>> + * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
>> + * @cpu: CPU on which to write register.
>> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
>> + *
>> + * The Performance Limited register contains two sticky bits set by platform:
>> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
>> + *     below desired performance. Not used when Autonomous Selection is enabled.
>> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
>> + *     below minimum performance.
>> + *
>> + * These bits are sticky and remain set until OSPM explicitly clears them.
>> + * This function only allows clearing bits (the platform sets them).
>> + *
>> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
>> + *         access failure, -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>> +{
>> +     u64 current_val, new_val;
>> +     int ret;
>> +
>> +     /* Only bits 0 and 1 are valid */
>> +     if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
>> +             return -EINVAL;
>> +
>> +     if (!bits_to_clear)
>> +             return 0;
>> +
>> +     ret = cppc_get_perf_limited(cpu, &current_val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Clear the specified bits */
>> +     new_val = current_val & ~bits_to_clear;
>> +
>> +     return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
>> +
>>   /**
>>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>>    * Continuous Performance Control package EnableRegister field.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 1e282dfabc76..1f8825006940 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1052,12 +1052,42 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>>        return count;
>>   }
>>
>> +/**
>> + * show_perf_limited - Show Performance Limited register status
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the value to
>> + *
>> + * Read the Performance Limited register to check if platform throttling
>> + * (thermal/power/current limits) occurred.
>> + */
>> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu,
>> +                                        cppc_get_perf_limited, buf);
>> +}
>> +
>> +/**
>> + * store_perf_limited - Clear Performance Limited register bits
>> + * @policy: cpufreq policy
>> + * @buf: buffer containing the bitmask of bits to clear
>> + * @count: number of bytes in buf
>> + *
>> + * Write 1 to clear bit 0, 2 to clear bit 1, or 3 to clear both.
>> + */
>> +static ssize_t store_perf_limited(struct cpufreq_policy *policy,
>> +                               const char *buf, size_t count)
>> +{
>> +     return cppc_cpufreq_sysfs_store_u64(policy->cpu,
>> +                                         cppc_set_perf_limited, buf, count);
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(min_perf);
>>   cpufreq_freq_attr_rw(max_perf);
>> +cpufreq_freq_attr_rw(perf_limited);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>        &freqdomain_cpus,
>> @@ -1066,6 +1096,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>        &energy_performance_preference_val,
>>        &min_perf,
>>        &max_perf,
>> +     &perf_limited,
>>        NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index a49b50bddaf9..57e04326a4b6 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -42,6 +42,11 @@
>>   #define CPPC_EPP_PERFORMANCE_PREF            0x00
>>   #define CPPC_EPP_ENERGY_EFFICIENCY_PREF              0xFF
>>
>> +#define CPPC_PERF_LIMITED_DESIRED_EXCURSION  BIT(0)
>> +#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION  BIT(1)
>> +#define CPPC_PERF_LIMITED_MASK               (CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
>> +                                      CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
>> +
>>   /* Each register has the folowing format. */
>>   struct cpc_reg {
>>        u8 descriptor;
>> @@ -177,6 +182,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>>   extern int cppc_set_min_perf(int cpu, u32 min_perf);
>>   extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>>   extern int cppc_set_max_perf(int cpu, u32 max_perf);
>> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>>   extern int amd_detect_prefcore(bool *detected);
>> @@ -285,6 +292,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
>>   {
>>        return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>   {
>>        return -ENODEV;

