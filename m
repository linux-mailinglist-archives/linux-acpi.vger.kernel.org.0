Return-Path: <linux-acpi+bounces-20682-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEi7AQUOeWmHuwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20682-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:12:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4B99B10
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B05883000B8C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BB27CB0A;
	Tue, 27 Jan 2026 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wfrteh2n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55145038;
	Tue, 27 Jan 2026 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540498; cv=fail; b=I0oNJMo9TYDmtJk/RbEHJJxs3Z0ROw3DhwUVJkRdFqQMD3wqKOSWEbC13uKmAgxUu3bCZuh663P25h8AV3pyefG8pMWcTdvV8mcrNaEX0PW3kRfL/QCnRZHK/av78I2EVXGlOU5rJVj+WHGIxm3gb9f7D4CXHHxXqFJlJvIcmo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540498; c=relaxed/simple;
	bh=DQ1D3WvVsPTYZVq1Ef7cjJ+SK1+qg13EUEqEywa6akk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EiZAh+QMUEYWOjyyFFNTDTY5amOQSQFpxZ7EcxNaiF2BGSFoza4Vrgn2fTLsc7CP1TWGuefFO3Oomufqn6ZYnHTTY1Y4uVrOJSgDZ2Gh+qKbbQodBCM/9iWutFKG9dtq+uS9UeLojAVpTPPYP954Xr+oj8S/B+tob7F6uPQbdH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wfrteh2n; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JClFQPdyw/krgDm/vJcP5/u/zD9Fzu4eiehs7qp70hsr8VpVlCWqRRKVHEMby78MSU33Je2Kk2pLZ/mWwHufHBifJ6bhXl/2DwTBCqFcf7D36+xgph0Lwd6pZUwB+JW3DIGYCqdkBA1l+c8UmMI5RWaUzzDliw+nmRCeQYrPvgBm0wvmdyWtWQpx9mt0WkpIv6R3LAQsfAZ3NerDm+KaPgZT96uxQEftaI1b9DAJbw77xygz+VUZMJ34bFiqSzkCS0UaVCohHo2znU91E8PE0OLE+7vg60bUNLp2ZJVDQ/RgiPiea2Nw+r1OexJA/LFn55GG0UI8k346y83n7NAcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnMfaCRxBFuK3EJ1cd4T1qpC79Aw7KkejtmbsV2KZqI=;
 b=HbQqV1/sQ+KmYWIcLX2yxQ5+eWkUs2uJO+7bN0nu44dNqo+8oFwqeASRsZY3m96WjzvxQPex7EqbIz16s6U8XXS0NYZgKi25yVSdDw2hZEI7nMR8NNmqOz/B+1SlWXWPMhtvss52EQMvrzjPajutc3KyP4SMCB4tsexZ06a8pIb6ZcHefGEk+Vkm6zxUmgHMXy9E7Pwm/Za95zUTJCrp1uvlmMJlp/Ro0Zc1o3tU5gXaOAD8pYSAiKbYgaRq5ba0L/pyZO1BlW3izg4kLliBZF1kUEeQGcYXRm1fmvwBONBcGDC1Ydr2tQa8VWskP7QFU0LH9ZqA/lPmtu9OaDGuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnMfaCRxBFuK3EJ1cd4T1qpC79Aw7KkejtmbsV2KZqI=;
 b=Wfrteh2nCFRsZSBCV4Diqv5tPOSG926Af21sjX3eFA2UIUB51+eg9a2AR20zfwk5HlGu5SR7VROJ5v4XVgjEhrO4DhTB5kxNgbcLtb1g9bzOf4eyyWmqSwFjKDHfM0ghYmyJND8fbiofobzzYJTxlC1/jd4RCEv1GF/gaZ+HtP7syiT+bMcQ3O1mHE+TwZIe1VkVZLY676oJ3vVknzDN7lI4lEfa9QMh6JaqyEO7kYYRnxIAHfW2CABiw0U4l7prElXbjfAj0Xkf10jVf/pKF7Mg8VtnY2DTLqTyqYOw8BD7g2D5oaGKaJbihz9C1ensex/wo5tQI1L74fJwURhAEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:01:32 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:01:32 +0000
Message-ID: <6be02e54-dd4a-4d8f-b2ee-291da63b0bf2@nvidia.com>
Date: Wed, 28 Jan 2026 00:31:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
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
 <20260120145623.2959636-2-sumitg@nvidia.com>
 <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0ipgGt7tetY6p0CW0jyOh9TVeWxgXpFzveTa2CaGB8ZpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0235.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b2b827-c5ed-4801-695e-08de5dd67bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0dBOTk4L245MkF2RUhSUEFPaHk4Yk1wYnZHL0pCYWl4eWxnbldrZjBGenZw?=
 =?utf-8?B?YVJPeGFXZUR1SjVIdmJxa1Jod0JUM0VyMHJpRmwxTk1halg5M01ja2E0eEIx?=
 =?utf-8?B?V2Urd254NDNDQW9KeWZCcEYrYWNMcUx6ZU5GQ1BLbGJqa3VlQU11am1VSXF2?=
 =?utf-8?B?djFFMWs3QUdDWThUYzVEeDFwV2tvaUYwaDM5Z25vT0N6NDQyOTNxZi84ZUd0?=
 =?utf-8?B?VjdOeDRnVnB2SGtrLzgyWjNKQmhVT1lGM3o1NUUyVFROSjk1Q2NhQnAvaEVZ?=
 =?utf-8?B?aUZxZEpISVI1V2k5dkpsTitycHhSSEZjSTVpaWNEM3A3Wnd0L0UwT0tScmE2?=
 =?utf-8?B?Q1UrbloxV0paSjJPTHFsb3NZWU9HOGZ1YVpwSE05ckJTSVZJSXptdEVJQk56?=
 =?utf-8?B?ekthRW5mbnRtZW5meWtpMVNocTFlb0puaVIvUWNCUTdhbzBESUhMN2lDVnRV?=
 =?utf-8?B?NTN4UUsvc0ljNldHRklvUmM3YUo4NzhjcHRodzlXWVY5ZzZBK3lUdElIRG9v?=
 =?utf-8?B?SU1tTElHckxnUldnd0JYR3g5Q0J0MllxNThGVklhWGhDeEt0QkVSd01VMTVm?=
 =?utf-8?B?bmR3OG5VbG9wN2RMN2xncnRjd2xnekZLMThuTG13MndqR2lCRWE4bWk2WVhu?=
 =?utf-8?B?RE5RbkVsb3J2NVZXa25rK2VkUGlaWFNrRjAxQjJRWDlvNTkvOUR3MENJMUNF?=
 =?utf-8?B?b3hINGV2YkRMV09oa1p3Ny8xV2s4NWYyb3luNkd5SmkrYnl1Tm1hdEhpTWxt?=
 =?utf-8?B?blRaeEQ0OUpWMUg2R2JOdlJsbGFHOExYcUlNeUdIWGN4d0xUb3A4eHVHWFlM?=
 =?utf-8?B?NUVFclZQUXJnck9WM3gvMjRzYUIrWWFJNW96ck5QcC9wNFVYTlIwUkNIWnpv?=
 =?utf-8?B?QWtpK1JiQzBNZFZhNEU2ajhkZ0JxUjFUMEpPYmpJeUtDK2M4clVlR2o5Q3Br?=
 =?utf-8?B?ZUJ4L3R4VU9FWm05emxvMGhibWVYeVBVVjRxVEJzazJyNjNUb2VMRlRjR1p2?=
 =?utf-8?B?Z2NQTUZja29HMGNBN3JiZlEyUVplQ0hrSU1uOEswWUtBMkpLUkN3b1lFUEtK?=
 =?utf-8?B?YURhcjFWeXRaQ29ZQStXanlNbkdDSVUrckU4MTRHOStrUHFGeHpLTnhnR2R1?=
 =?utf-8?B?N3hXZXZyV0tNUWJVcDJoZERsWTVRRFRKV3FLRGhmNm02blZsc0h2QlJjZE1h?=
 =?utf-8?B?N0hlNysrUFQxM1c1N09reGZydG5sL2dReHN4bFZRM2FQTmZyZ3oySjlidGxO?=
 =?utf-8?B?MkRyUU1yd0VFVVdMUXo4aFJaaExxazBza2M4NHFvMWpQQ1AvNTg0ODVyMEpV?=
 =?utf-8?B?YzhvdE5OMlpiaG1wRjZobXM3dTQxanRGbjNVVmFNZkVySlFlQWovQ1JsdlRy?=
 =?utf-8?B?YTdQeGtIQ1lIa2sxRW1pR1J4M2hJOGVJdDRsZjB3amc3ODRrZW40TUozM0o0?=
 =?utf-8?B?a1U4QzU2eTgrSzMxSndNK1psRk0yNklVQW9ybTQyTWQ3b3VwL3JJQVZjZWlm?=
 =?utf-8?B?SEpWMFpwbWZkSmdtb3RZaFNIbERZaDEvVk1CQVdoOVZnTHRqdEQ3TnhaTnJU?=
 =?utf-8?B?T01FcFJDZ0dzRmtVZHo3UzgzeXZEN2tDTXRmQnA0T25yOTJHZkkyWVNHZTBh?=
 =?utf-8?B?NnVMRW1EOTBDQTAvSlN2am9KZ3pLWW9OTnowWVZITElzSnJpRkh5Rmhod1BW?=
 =?utf-8?B?bUttTEtTazFqeERHTkFmUFdobnN6ek5iQVpyT0dtcXc1Syt1aTBraDBzZnFI?=
 =?utf-8?B?THZVMWJVVEgyUDZpM0RxTENlejM5c1MvMENTVmx3alhQOXFnS1hLL0dXNVFJ?=
 =?utf-8?B?ZEJyKzA2RGRXR0tmLzlscVhMUU1XOWZMdXRXQTdueWk2SisrUzBGcUI2VUov?=
 =?utf-8?B?NDJINGEyR2ZTaXI0ckU1aklLdkthMEd3SnVKdmdoUW5BT24zVmU3dW9jOTNa?=
 =?utf-8?B?YlBTMWowK2t5YWErSXVaSzRVakZQTjhqbkRRY3k5SFZMOFZLY2g3TElNdW11?=
 =?utf-8?B?RVFadTg3OVc5cDF0SkpXYnNORTg0QWJWTjFUcDRIbkZCYXk2UFZ2RFhiU3Mr?=
 =?utf-8?B?VU9Bc0Y1Nll1K2VGMHN5WDd5bVlnVUlzN2R0RTlDMkNrMW5GbW1HMVBWZEdC?=
 =?utf-8?Q?C4R4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFjTEc2QUR0R0VLT0lvdUZQb1Z5ejBDNnBmTWdKdzRiYU93U04vdTBNOW1N?=
 =?utf-8?B?bmJtQm10UVI2RlpBOTFOTFYvdWFWcGVsUEkya01DMEoweEVjdFZTOGRiS2tW?=
 =?utf-8?B?MmwwSlowZ1R5bEcwTGFqWG9QaldaZXAvZ2F2NlA1UDU0dHhsN01ucUJCTTF4?=
 =?utf-8?B?dXBZMEV6UDdDNm9TMXJiczZpQmlTNXlkdXZnbUxvT3JWQ3FoSWJKd2ZGQUN4?=
 =?utf-8?B?MkE2MTRCeHNwemNlcFQwNThRWDBlSy95VzdHclpZclJ2TGtRazVvM0tnTHp5?=
 =?utf-8?B?SjlhcFp3dmJOL1RqT3paTTlqZ2kzWFljdFpxM1JKVDBxMmUrYkhobG1yelht?=
 =?utf-8?B?bkJKTXMyeE1yaFRyQjRpc3NoWVpkNFhFR3A1L2ZJckRYN0VaQzlpeHVGTFVn?=
 =?utf-8?B?dHQ4RzBuUlI5cEc4QW5mY3VlK3IyekVzZXdFcEh1YzBzYUwvZVNieW80MmZ0?=
 =?utf-8?B?aEhBd0szQmNIRHBNSlVZOWJSVmxmcU15T0dhSmx2ZEdUWXJCN3hoYkVyVDIr?=
 =?utf-8?B?WERkcTQ0bDlqRzI1NkQrR2RhY0N3TjcrL3RLeDRWRjFZOXY3Zk1GQTRMak5T?=
 =?utf-8?B?MDc0ZmxmTUpUOVpLcWFTWDF3cE40dUJqeC9jSkRjMUtXZTBDd3RYNWZxdGNS?=
 =?utf-8?B?a0MxS1hTUFU0VXQrV0N3RUliclAwc1ZDSktWR1lYVkk3Z1B1QS9UWGJROFM3?=
 =?utf-8?B?YWtMcW9zZHJyWXZ6MndIMk5jRWlSODE4THdMVWZVZHVhZ3hqVzlObDU0RXVS?=
 =?utf-8?B?NWdpUktLR2hSNW00RnhTSEdRNytTb1hKeHdxMXc5RDI5OTZOMFZwcXg5SXlp?=
 =?utf-8?B?Q2w4cEtSQmxKYWlCOUJ4NSt6RVJmVGhlK2dRejdwNUhoTWNzRzUxa2UzeGJw?=
 =?utf-8?B?Zk9UZG1xYy8vTngrM0xVNTBGVHc3TUtqWCt1emlzb29HSjBQVGNyUFk1aVdL?=
 =?utf-8?B?NkNvWWRhZ3NIVlhqejVZVWdRL2ErODFXUVM5YnNnMHRzMXJNWWxzaU84bUp4?=
 =?utf-8?B?TUVvYXpmajdkUm9hdktrQ21uTERVNno5R0JUTU1ic0ZOS3pIMlZMZmVidjV1?=
 =?utf-8?B?YVhwRmZCejdwZGRTSWJQKzVxd0kvZVF3eXZ6a3ZCcW9GQWhDTlFwNUtDN2VM?=
 =?utf-8?B?RktEMnhXaWxjZFU3Y0NaZERZanh6NXcweDJvOFlLdXJIOWVxZFloNXQzUnAv?=
 =?utf-8?B?N2xWaEFpb3VHNDJpZm5Jc1ZnYjM1TWo4Vkpxc3RreWRib2VHaHhZVlgzb2x0?=
 =?utf-8?B?eTVBb0xpbGNWTHZ2bGp5OWY2MmdrUDllQmVLK3ZRemQ4Qm9HbTdkb05wK2Rn?=
 =?utf-8?B?U3hWcVNVSW1FNm9mei9kMm9aVW9jUzZhRzNHQTZNdHIrRlhacWJ5UVczRldP?=
 =?utf-8?B?S1NEbktET004eUlXSTdkQUl1aWYxVW9CRUgrNEpvbGlRbXFVV3BEUkxITzM0?=
 =?utf-8?B?NFBQbmFEeWtZelFmODVrTndxN0VjYWtJbG8vMTd5cVgxcmRVVWdWeUg0cXlm?=
 =?utf-8?B?NEYvRENoaVNYeml5NnFjWUdZTXNnVkh2b0ZjT1RkK2pSSFlUVnl5TnpUZzhq?=
 =?utf-8?B?SEc2VFRnRm9xVlBzU0FBcnhCbGlpbmhwbzV1RDVaYVVwRUI2bm9UNUlKTHpF?=
 =?utf-8?B?WVR0TmIzN3Yzbnp1TXFzSXpZbm9jZjNFa2VmaDVsQ2phS3ZTVWdDRm5YZzMw?=
 =?utf-8?B?cHhja2l6TkRaakVGWmRkRXBYaE4zd0V4cVdsUlRIWjlGRjVpMjRXNzN5RkVQ?=
 =?utf-8?B?VjVOWFZUNlhzUGNpcm9MM2xkTFQvcTVGdDFCZ2duOWRWbXRXSmlkMzVKOXcy?=
 =?utf-8?B?Y3JERlVFUk5QNnpETHo4Mkd5c2xLSytSY2dsWnFEcGZaNmdQVS9OWWp5Y1Q5?=
 =?utf-8?B?cnZuVTlWT094VnZIMFhFcVZwZTJaSitQV2tKN3l4RzlkYXMyMDljWDRKaWFP?=
 =?utf-8?B?Q1d0VllBMCs5QkJoQjBtZ2VibUVSa0hnOHVCR0dDVHE0OC80eVo1R0R5YW5L?=
 =?utf-8?B?cTIyeUM5MEN6TmRzVW5vVTBpN2NNWHVxTjFtN1Y2WHV6RW1XdXk4RUtVTVFh?=
 =?utf-8?B?dnVNSyt2WWVDU3grWG1JTmloZjAwb09kVDdMU04wS0dLVTJMbU5oMlRSZkNu?=
 =?utf-8?B?aWxPWWk3ZEdUektZblZxK20xUWVwbXQ0MlVaaEZCMWxuUVQ5dmZobVNvdHBs?=
 =?utf-8?B?aFB5V3FGQnRsNEFIcC9HR1U0aVJJbTJ2dlpCV0NRYTh0aTA3VVdGWnVlVTBk?=
 =?utf-8?B?WVZLRDZNdkVtTU00Tk5JUXEybVp6b211K0FDVWg2c0RwSEhoRzgzSXBKMTR5?=
 =?utf-8?Q?lj1brSS6eKiUdq6Bxb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b2b827-c5ed-4801-695e-08de5dd67bf5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:01:32.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrNWDeuqvhynyTQOIzW7z77UKRlASYn5/TX+mmdevgkprIgxp2TCg23GqLa59LyHk9U8l+EYDuv97rTVWjbC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20682-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 5FF4B99B10
X-Rspamd-Action: no action


On 27/01/26 21:54, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jan 20, 2026 at 3:57 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>> Add generic helper functions for u64 sysfs attributes that follow the
>> common pattern of calling CPPC get/set APIs:
>> - cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
>> - cppc_cpufreq_sysfs_store_u64(): parses input and calls set function
>>
>> Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
>> using these helpers, reducing boilerplate for simple attributes.
>>
>> Convert auto_act_window and energy_performance_preference_val to use
>> the new macro.
>>
>> No functional changes.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++----------------------
>>   1 file changed, 25 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 36e8a75a37f1..c95dcd7719c3 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>          return count;
>>   }
>>
>> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
>> +                                          int (*get_func)(int, u64 *),
>> +                                          char *buf)
>>   {
>>          u64 val;
>> -       int ret;
>> -
>> -       ret = cppc_get_auto_act_window(policy->cpu, &val);
>> +       int ret = get_func((int)cpu, &val);
>>
>> -       /* show "<unsupported>" when this register is not supported by cpc */
>>          if (ret == -EOPNOTSUPP)
>>                  return sysfs_emit(buf, "<unsupported>\n");
>> -
>>          if (ret)
>>                  return ret;
>>
>>          return sysfs_emit(buf, "%llu\n", val);
>>   }
>>
>> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>> -                                    const char *buf, size_t count)
>> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
>> +                                           int (*set_func)(int, u64),
>> +                                           const char *buf, size_t count)
>>   {
>> -       u64 usec;
>> +       u64 val;
>>          int ret;
>>
>> -       ret = kstrtou64(buf, 0, &usec);
>> +       ret = kstrtou64(buf, 0, &val);
>>          if (ret)
>>                  return ret;
>>
>> -       ret = cppc_set_auto_act_window(policy->cpu, usec);
>> -       if (ret)
>> -               return ret;
>> +       ret = set_func((int)cpu, val);
>>
>> -       return count;
>> +       return ret ? ret : count;
>>   }
>>
>> -static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
>> -{
>> -       u64 val;
>> -       int ret;
>> -
>> -       ret = cppc_get_epp_perf(policy->cpu, &val);
>> -
>> -       /* show "<unsupported>" when this register is not supported by cpc */
>> -       if (ret == -EOPNOTSUPP)
>> -               return sysfs_emit(buf, "<unsupported>\n");
>> -
>> -       if (ret)
>> -               return ret;
>> -
>> -       return sysfs_emit(buf, "%llu\n", val);
>> +#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)          \
>> +static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)  \
>> +{                                                                      \
>> +       return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf);\
>> +}                                                                      \
>> +static ssize_t store_##_name(struct cpufreq_policy *policy,            \
>> +                            const char *buf, size_t count)             \
>> +{                                                                      \
>> +       return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,     \
>> +                                           buf, count);                \
>>   }
>>
>> -static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
>> -                                                      const char *buf, size_t count)
>> -{
>> -       u64 val;
>> -       int ret;
>> +CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
>> +                        cppc_set_auto_act_window)
>>
>> -       ret = kstrtou64(buf, 0, &val);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ret = cppc_set_epp(policy->cpu, val);
>> -       if (ret)
>> -               return ret;
>> -
>> -       return count;
>> -}
>> +CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>> +                        cppc_get_epp_perf, cppc_set_epp)
>>
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>> --
> It looks like this patch could be applied independently of the other
> patches in the series.
>
> Do you want me to do so?

Yes, this patch is independent and can be applied.

Thank you,
Sumit Gupta



