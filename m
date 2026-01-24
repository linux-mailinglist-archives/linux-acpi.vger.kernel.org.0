Return-Path: <linux-acpi+bounces-20606-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IVGBHeczdWmECAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20606-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 22:04:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C294E7EFB9
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 22:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D9C300B451
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E927B340;
	Sat, 24 Jan 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsOlRGji"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D571CD1E4;
	Sat, 24 Jan 2026 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769288676; cv=fail; b=Q5Nk4zF9EZJSX4M/slCkVrzKRpzthJlBY3/eUMaITAjXLamNuZdFFJmcK/dPP75lbiTD3gbHThB3Y5L0Ed5LJw9Gms68nmreUEgbgX6QvRnDV9RGiQwrWs3KDYkMpRp2dzXo3rLYd9NAI+TETVILMktJX7BXQtaaASv+/p3Hgco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769288676; c=relaxed/simple;
	bh=Xx84WXcaB7q0Z7w5+9xUwSJikY7pUDUIY48KC/mmoQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qZmMiIGXlClv/SZ6RVqnTjNQ/s9mawimYD7Hp0speRd+1wYPYgiqjBYcwmjk7NV61E25RdCfM4Vsnv1YGQAhbTNmVJVCe7KTIPFka+nW9uOEA2P39sr9wsAQPI3C8ZZLAtB43x5zFaw6E00aj2+KVZWZ+22jtLfGxQSNuGcqQ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AsOlRGji; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO3Rxcp9rNpYc0EIJB8r1odetSTpuSkwcrz/OL5wK7crdK2f0wD1Svj7b79I9HJW5QozCqGirUjFfYIzUoIW3oqAiSH12UayQfxqSU4jMHuvcPlbkNmvDrAHcRcfVzG+qb2mAOuIYe8ZuQ6FQtzwr/zcoYutnHocMqu49fyTvxeXUEXaNlAGm/SiIyeh6RK+friisdpvQQcyX3jDO5edeMeexlu7TpEzp1VYYyBgCZEC5JnMTqbjVHPwjOaux6Gkk7y8rVeNkps3WBBKroeeHUJ0+px7t0xw7YGq9ojv1s3JLh/O7Qp8GTW5n/xKw82Mm1Aw8aCZCFHs6rJIPcriWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QPsscGpiDoycNxt2XFTkipkdALNRlKwq2Adjyi97fQ=;
 b=qLoxasypKbmLuzksY8Oug4KOPV3JvMk9iDK+ayeLVQn+z/QOJ75O3hK/GhcPokZLM44yX84WyUCsvbFlg5sRIVdUT0g4tkiol1yhbWwXnWBm6L2O3UlaMBqiCvTUQSSyTg5YJW/6nbgEickji1sJALmQXAZFiLCEhT2dKs90zl6Tw4QOtKNQtOMH4cJHnOFSqbOl+EM//hO0C8lHaHjZHLzJbTvfzYo4DwW9+C+wlsDsJK8N8HpsXhH6M20R0fBKip4WLIGI2Qo7Q52LsJ9cZpPzZgHl+s+XtbCbegMH/W5xzbHp8p3NsouulJ6IqFzJB4P7vZnzfb4Kh3iOSP9qEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QPsscGpiDoycNxt2XFTkipkdALNRlKwq2Adjyi97fQ=;
 b=AsOlRGjiU1NKojMDe5ThbhBsVjt1MsOycatWt21XofO+Lib7k/VGdcI/VHMOyn/PYuIkx5FsUz8BHgwcbE/IzWEo+m53lRjLMWSxpBl3hTCjw3+9zcw/eF5wh3MeiBrPdsfd+TkgZdSVnqH1jBc+CLLo+Ja1KYPmvw4F8bcASlarBjjwJVr+IQUqKXlvl2dXw8kYgh5KN+7U6Zrl4whp908DTHFf0ViDR2Rzsq51uoVsId1g+bBP+Q7x3mZd6sM38yiZ9uTnxtCeHBthLRGLU+6lhkX/XOjobwO1lDGq0CXmIw3CUyfW5avKn0bIr51l+GcZ03kHTtbUHIE4RuOvOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH1PPFB21296325.namprd12.prod.outlook.com (2603:10b6:61f:fc00::620) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 21:04:31 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 21:04:30 +0000
Message-ID: <7d2ad4f1-7d04-4032-bff9-65eed15c7318@nvidia.com>
Date: Sun, 25 Jan 2026 02:34:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-8-sumitg@nvidia.com>
 <e47509a2-c1fc-45b7-828b-b957b9f8ce1a@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e47509a2-c1fc-45b7-828b-b957b9f8ce1a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH1PPFB21296325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0c1591-90ab-412e-2fb1-08de5b8c2abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0NzcGlaRTBrbDNDQkVZTERqK2pockFZLzZrTTlHRi9aQklETkV0VkxiNzZi?=
 =?utf-8?B?ZzRBcndqWWZkUFA1a3lyMUwxL0FRZThrUnhqV3MycjdOYTlJLzg3dGFKV2Jx?=
 =?utf-8?B?WlJpNmE3TkZLdXF0ejdjdmxtaC9zRUtrd1k0VzBnVDh0b2tpbmVvZDN0enEw?=
 =?utf-8?B?WTUvNmVzbDU2VEVQaEQ3TXdkR2tkZ1Q2VEN0Zk5tNHpicUoxUlM0UFQyTXZY?=
 =?utf-8?B?Sll5Q05zaElrcjhsKzNMY1NBOVdxQmhoWFE5bHpmYWxrRHptOVlVNzhZWXpE?=
 =?utf-8?B?Qlg1RG45Y0NTZy95aFJJS2lGZHlGQmdtOGlPWDRRbmJhSUgyRnRSdU9wNklN?=
 =?utf-8?B?V2hURmpxeHh6eUQzdW5pc0xJRWRVcFpWRmRqczl0bWVjMFVnM215dWdySEkr?=
 =?utf-8?B?VTYvdTBEVEtCaHVWdnhGTXd5Sk82MVc3dnpMR0tQemFqcjljL0d2ZlI0Mnk1?=
 =?utf-8?B?M3VZU2pneFVCNjZrbjNreTZQZ2ZBL0ZUa2JwdWp6aUpKNnljTkxYQ0ltaDJK?=
 =?utf-8?B?TVN4QVZvTXNaaXMvaVFqRGNLUnphKzc2N1lXeURhNSt1bkJUN3lpeU8waXR5?=
 =?utf-8?B?M01zZllHS0ZpbDdjWGtJMDI4cnBNSUtOa2pES0ZQR3V0ZnF6V0xBN3N1UVBx?=
 =?utf-8?B?S1l0cFJsSFdmMWtQQ3UrQ3hRMy9JM3ovRWlRRkZMSzJQS0xCZ1VjbXpzR014?=
 =?utf-8?B?dWI1cVYvY2hlQWJTb29udkJ2Vm96bGk5WjRRRUdRWER2OEFhNThqZmhlczJw?=
 =?utf-8?B?TTlMZTNveFE1aWxqcDBpZmQ3MC9hem1rNHJwYmZTU0VqNzJTb0dady9SODhu?=
 =?utf-8?B?VExBV3dlYXYyRmFKM3RySXFIOEZmU1g3bjdrbXcwZ0xibUZobFJueFI1Rksz?=
 =?utf-8?B?TThNbHJOdTFGZXVEMUEvaWJRTUc0Sll0NEdxUzBzY29oWGg3Ymh0QmxNU0di?=
 =?utf-8?B?anVYSEdCSTlVZGpqOExCVThvYlN0ZDB4VTR0U0tLNnZtbFhqcDJzbFI3bm5R?=
 =?utf-8?B?WFVSV2xUT044bHZoeXhOT0xBOWRUejIvb0tWbGlobmd0Y0cyL0t5WjFjYVVQ?=
 =?utf-8?B?dFZYMjRDWkROT24rTUxKRE01cE1XUm4xT1dBVERYYkpwSmxLRkFXRnFFdnRp?=
 =?utf-8?B?S3Bpa3ppSWNlRWJ1cCtoc1YyRUd6TEtaa0M0eDVPL1grdmdSTHlyQzBNMTU0?=
 =?utf-8?B?T0pwaUVyQWpnZmFkV01yZmFkaStzeGpLa0J1OGhKb1EvUHVkV281ODVOdVBq?=
 =?utf-8?B?VTdzaFpSVDRzaXVBdVNSd2s1VThDdDZUcDM3aUdHdks0U20wekFQa0NaMEUx?=
 =?utf-8?B?Ymx1aDJTb0paeUpKUGVXWTJpWTZ4Y0srWHZoZVRBTHJOWFg0dk0wQ1JXalp6?=
 =?utf-8?B?bXZCRU11a1k2cXJGclNiczJZQnB6bU1tN0N2VVFjNEtmT1J6aUw2TWJSQ3Ir?=
 =?utf-8?B?MDdNRHlnUEtvL0hjcUJsaGMwZ3FWVnhjaVVxcDlVZUpxS1h1RGpOWHBYS3NF?=
 =?utf-8?B?UXBYaDNkcTNEMDZjdkljTlhsaDZvdVJKTWFrb0FvT3dQeEU3dGdUYTNGcFI1?=
 =?utf-8?B?QlJ6N3ZjZ2ExM0dnVUFtZDNmZ3dpN0luaE04enl0WGV0VmtVVGZyd2lwRDdO?=
 =?utf-8?B?RjlGV0RrTG91c3Z6OGRPMTRhci9zVzk3MHcxUGs2dUQ1WVNPQ1VHNld4VVd0?=
 =?utf-8?B?dXFuNzhNTEJLSFRUelROb0llcStISzBHcEZ1TDlqai9QdlIyZnorMVBTNWVx?=
 =?utf-8?B?TjhLUVFQc0dLL3g3TzBLN0JkNDM5NXp4U2dFVnVhZkRsZ1V1MGVUTkYvTUlY?=
 =?utf-8?B?Rk9sRkJ1MDR1NTlrbU5kdUd5a3I5enYxQ0N5WDNMZnpMRi9CK3RwcXQrWTR1?=
 =?utf-8?B?QzBBVDdhRUQyNUY2cjI2ci9wSndBZVplRUlNVHA2U0s3K0RhbXlNekt4VWpZ?=
 =?utf-8?B?d1lVakUwQkVyMkplSjRPNHRRaUJlTkNYb1d2Z1EwNm1DRkV1OS9XQmVYYUtx?=
 =?utf-8?B?WnBCYlpsbFFrT1JGQmFpL2xSWkpzQzEyQk1oNmcrU2ZNVkpBL1hDWm9qc09O?=
 =?utf-8?B?M0NVVjR2YTltQ1BVL3lkcmJ1dFhUVnp1ZVZ4dVRKNFBUbWcxL2JET0lqcnd0?=
 =?utf-8?B?WEFXYUhiRGR3Y3oxMFU4Vy96N05JWWJsRVhCWkhzelRUS3djV093UlVORTZx?=
 =?utf-8?B?MHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5PdmxPL2FCVlkyaDlsaGpVQmdzRXpwYndFZUk1S3hXcnh2dkVVU3VQckRC?=
 =?utf-8?B?WHJNK3lHUkgxeG5HVFdPZ0RFT09CcjA1eW43ekZCL3hnMEoyK2pRTHFsNGFK?=
 =?utf-8?B?NGcrSGlCd21FVWNZdlNGRnowa0QwMWxSWTI3Nkw5TUhnTlJ2QmNsV2phd1hU?=
 =?utf-8?B?cy81TGE5Y1NtZW5Uck5RR2NtRmo5WmZDSnJoRVJaNmlLK1F3RjB0VUE5WXBT?=
 =?utf-8?B?Zk9xZVplaTZEMTU0R1Q5Z1p1Qkc2TnNTMVFpUEM0Smw3cTQ3T1lRbmhPYU1M?=
 =?utf-8?B?OEp6eFQxMFpiajVva010YkNMbWEvbi95RWdndnJ3WDdYQWlwMzFYZ1BpcUp3?=
 =?utf-8?B?VFJOZStwRWhsc3FSN1dCTDlqTFRIWmhtektZMEJXVThLQW8ydlY5bDRnM2c3?=
 =?utf-8?B?Q1Avc1l4S0VRbWMyb0tKM3Vvd0d3QVdXZHozZ3FUMldvbU9vK3YzV2N1dTFL?=
 =?utf-8?B?OVN6YUNET2s3MDhnMHBrYlVWZGhpYTEzMWlPS1k3TndmUnhVUm5YU2lNNGV1?=
 =?utf-8?B?NlExeVY2QjdDelNVck41Z0NtbTd4My9ZRUVZN3JJRDdSV0pzQnBENUE2a0Vm?=
 =?utf-8?B?WEVKWlh2bEVQK3Fya1YyK3Z4WU5neS9wOHdwMWF0VkhQLzZpOFlxK2lGajlL?=
 =?utf-8?B?eG9rTlNZM1djTTNxOHM5YkltMkoyWnlrZStiS1Blem5KakhCVkc2Tnl2Z2dI?=
 =?utf-8?B?a3laa2lMVXdJYkY2Z0Izc2JRQklvbVpJS1NDaEZYRTM2bTBuOVRXTHdMTFhs?=
 =?utf-8?B?VE9mRG1LQndTRkk3amJGUFlIdzJkMElFL1dHZEVKZFBLWGJiQ2pSSzY2QVp4?=
 =?utf-8?B?cTJ6RzZ0YWFJWUR0WWpsNUVXSTIwTW9Ib3JZQUZqR2NYWkFqNVdLQmpTSTVo?=
 =?utf-8?B?K1JCSlBRL29QNzdTNXNoZTdNcUxFUEFwTzk2Rkd3eUNmM04wVTQ2b3d6d2lt?=
 =?utf-8?B?eGdtVUo3dUo1Skg4d2FSSlVSM2Z3SjdEZnFvRkxsR2kyYzZHSVhVenZXYzls?=
 =?utf-8?B?Z0Y1c29vMTdab1RvdXZKalhkNnBpMGVBMzRuWHh6NDkvUm1YNVV4a01LSWlD?=
 =?utf-8?B?SWxmSFZKeVkxSHZ1cDJnVTB0MTlDUWFWUjNRRWFWZ296Y2duQjNCVk00d0RF?=
 =?utf-8?B?YUc5cnZKc3JlcFRsV0VLeW1BWXZldVBDNUVnWUxXdmc3TUpzSnpUc1Uybnl5?=
 =?utf-8?B?NVVDUlR1STVPL0VESEgrb1pwckNKd2VQcWF0UHdYS0Jyck1nSk5QNnVCQTds?=
 =?utf-8?B?Z0lKalh0Ym9xeHA5dWMzeHgzc0FGQlErMFB1a2liOWFBbkk2NElMSmpqdU01?=
 =?utf-8?B?Nnc4Y0lkYVBEK3dCaWU5MUhYZUlzWmMyWlZPQ25mVU9zY09EUVlXbStMZ1dZ?=
 =?utf-8?B?a3J2NEN4ckdDalAxVHNEY08xek1rVjRMTUJtZWxTUTlJOEYxdndHQ1lsWlM1?=
 =?utf-8?B?UFZ2VG1xcWg2L3BKSzdzVHhNRjFPbFloQjhxczltUXl3QWJWbVpCTGpPTFNt?=
 =?utf-8?B?bzRCMHdZaW0raEd2K3BMSlNuV0t6b1F3LzNyTXh2aW9CUUJ5VWJyMDlUMTlV?=
 =?utf-8?B?VHBHRWM0eWZnZnFVR2czdjcwb1p0SUVkc29YZzVsWUg3N2JUQnU1OUQyY0V5?=
 =?utf-8?B?U0tLRlc3Y2lOTU1TeDNUdHlZd3hNWWNYbU1hb2phTVE0SUNEVUI2UEh5TGxn?=
 =?utf-8?B?ZGhvWDZ0NFJKaVptTTAzS0JITnlZL2lGMzl2dTdCWHUyN1JVVG12WmpubitI?=
 =?utf-8?B?RW9SbmJRUmY3Qlo4aEgyQVdaNzFXMCtsZExoZkdNTzcwZ1phZ0cxN09TQVpu?=
 =?utf-8?B?cnZLVHNGQ1hSdTlkOTRVVUlGWVVXTUxaTlhiZ1FzSW0zbWxkK0xHdTZmaTVl?=
 =?utf-8?B?c0hwMmgyYTdMQ0VNdzUxNFZzL2ZuTDF4eHpZVlZZd2JuWUY2T0xUTzBRM0tj?=
 =?utf-8?B?Z2RWb2ZBOE5CQ0tFdlRWbHlQdEcwa2FsS29JMW9sTlRaZUg0QjJlVG9CcUN4?=
 =?utf-8?B?U1o0VEc2SkFZZzUyT1RtbnBheDJFcnZONGEvTUIvMU5PYk5JdjNaU3E3R01a?=
 =?utf-8?B?WHVTRmlyUzZscFNNQ3BZdFhYNzIvaktTZlE2VmRlY0pOeE00QWxTempFTWcv?=
 =?utf-8?B?K0cwRk9WcW9wZjlJN2p1S05IN0RhNVNkTTcyUVA2a3kyaUFXUThhclN0V24r?=
 =?utf-8?B?d2ZzZjJZMHdtWm5CRkFsNUJYaWlXQmRIMkovRmh1NDB2TmF4cS8vV3d6a21x?=
 =?utf-8?B?L2FNMWViNkdGRlF4YWMvRXBldVljaXRYTU83bVFKNEc1SG9mbE9MbVBjSmRP?=
 =?utf-8?B?SGxTc1ovZDJ4d2RkMWVmMDBXQnlpOVB3US92cnh6dDJmLzFnUTFIZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0c1591-90ab-412e-2fb1-08de5b8c2abd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 21:04:30.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9/gWW2oOwjWQVVHHo9hNMKi8qXljAYMxuj5v8sCEGJPGA14Zx5dJ7OiDDGFx+wmlR/C/TYYISYEo7kSaqXsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20606-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C294E7EFB9
X-Rspamd-Action: no action


On 22/01/26 17:21, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 1/20/26 15:56, Sumit Gupta wrote:
>> Add sysfs interface to read/write the Performance Limited register.
>>
>> The Performance Limited register indicates to the OS that an
>> unpredictable event (like thermal throttling) has limited processor
>> performance. It contains two sticky bits set by the platform:
>>    - Bit 0 (Desired_Excursion): Set when delivered performance is
>>      constrained below desired performance. Not used when Autonomous
>>      Selection is enabled.
>>    - Bit 1 (Minimum_Excursion): Set when delivered performance is
>>      constrained below minimum performance.
>>
>> These bits remain set until OSPM explicitly clears them. The write
>> operation accepts a bitmask of bits to clear:
>>    - Write 0x1 to clear bit 0
>>    - Write 0x2 to clear bit 1
>>    - Write 0x3 to clear both bits
>>
>> This enables users to detect if platform throttling impacted a workload.
>> Users clear the register before execution, run the workload, then check
>> afterward - if set, hardware throttling occurred during that time 
>> window.
>>
>> The interface is exposed as:
>>    /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c |  5 +++
>>   include/acpi/cppc_acpi.h       | 15 +++++++++
>>   3 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 46bf45f8b0f3..b46f22f58f56 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1787,6 +1787,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>
>> +/**
>> + * cppc_get_perf_limited - Get the Performance Limited register value.
>> + * @cpu: CPU from which to get Performance Limited register.
>> + * @perf_limited: Pointer to store the Performance Limited value.
>> + *
>> + * The returned value contains sticky status bits indicating 
>> platform-imposed
>> + * performance limitations.
>> + *
>> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not 
>> supported.
>> + */
>> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>> +{
>> +     return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>> +
>> +/**
>> + * cppc_set_perf_limited() - Clear bits in the Performance Limited 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited 
>> register.
>> + *
>> + * The Performance Limited register contains two sticky bits set by 
>> platform:
>> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is 
>> constrained
>> + *     below desired performance. Not used when Autonomous Selection 
>> is enabled.
>> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is 
>> constrained
>> + *     below minimum performance.
>> + *
>> + * These bits are sticky and remain set until OSPM explicitly clears 
>> them.
>> + * This function only allows clearing bits (the platform sets them).
>> + *
>> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
>> + *         access failure, -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>> +{
>> +     u64 current_val, new_val;
>> +     int ret;
>> +
>> +     /* Only bits 0 and 1 are valid */
>> +     if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
>> +             return -EINVAL;
>> +
>> +     if (!bits_to_clear)
>> +             return 0;
>> +
>> +     ret = cppc_get_perf_limited(cpu, &current_val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Clear the specified bits */
>> +     new_val = current_val & ~bits_to_clear;
>> +
>> +     return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
>> +
>>   /**
>>    * cppc_set_enable - Set to enable CPPC on the processor by writing 
>> the
>>    * Continuous Performance Control package EnableRegister field.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 66e183b45fb0..afb2cdb67a2f 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1071,12 +1071,16 @@ static ssize_t store_max_perf(struct 
>> cpufreq_policy *policy, const char *buf,
>>       return count;
>>   }
>>
>> +CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>> +                      cppc_set_perf_limited)
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(min_perf);
>>   cpufreq_freq_attr_rw(max_perf);
>> +cpufreq_freq_attr_rw(perf_limited);
>
> If the OS wants to get regular feedback about whether the platform had
> to limit
> the perf. level, it will likely try to frequently probe the register.
> In order to see new events, the register must be cleared. So:
> - is it a good idea to allow users to write this register ?
> - is it useful to expose this register if the OS frequently clears it ?
>
> I think the functions are useful, it might just be questionable to expose
> the register in the sysfs.
>

Currently the kernel doesn't automatically poll or clear perf_limited,
so sysfs exposure is for manual monitoring. I can make it read-only
but then users can only observe throttling events and can't clear
them (though bits stay sticky). So, better to expose as RW attribute.

Thank you,
Sumit Gupta


>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &freqdomain_cpus,
>> @@ -1085,6 +1089,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &energy_performance_preference_val,
>>       &min_perf,
>>       &max_perf,
>> +     &perf_limited,
>>       NULL,
>>   };

....



