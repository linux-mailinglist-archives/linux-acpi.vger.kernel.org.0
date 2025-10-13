Return-Path: <linux-acpi+bounces-17737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D4BD313A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DDCD4E1534
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDFD288CA6;
	Mon, 13 Oct 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYuh+Pex"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC72255F2C;
	Mon, 13 Oct 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359889; cv=fail; b=fogHU20xIEdpVqdQXKriu500aoiuhZq2R1RGME4olyslB5Gq1COBfdX2e06mn+O1dgGNq4FBiVemDO7sAHOIhGiZiYQALHK/nhwaymTkVAHsneucMdenaDqOuobv0ayrQFXmM4tQcIMbEsfKXc3kSm/lTz1y8Ek0u4mHmZoPdjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359889; c=relaxed/simple;
	bh=GKnvOnVjD8J1jLD1ZIGQu0ErbFsqIbbtSPJixQsCbSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vc12ndumUc+k3KqdevZEYExMt6pj+8FXOyRPaqDmCfHTERtyCex4i+OaQ+z0RwOsbaVbPO77+ydZK5XTGuSyvZijtKWhlYa6E3ZvuQpFJNJ/Teqnz/DXSSUvxpnxf8qiR+3Dku77fX4Q2/V93qhoxt+sdjuDWCsWCnBRx85ZfBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYuh+Pex; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXZpF99Ceh7kjTCODtKp8Q9b2M10IvIGEg+JuO+EZ6qst1T9RcJeVeHEouawtbBfks6JuvaED2PHPwxAAqrp/E+vIP0qaDyMJiMA3Xd2aJo7C6HNfgbZraBFjSUnv7L2Yb4ICu3AxqvSW5sHKNJwUXxt0Il0CD7mB2LmG550FebcMrhKtpE750gtDpLCzuTBrKFKf/NXDE6PABVf3J1S8LTQYILHLEO9Xh/1wPnVELji0jHRuXdCOG+lHXlDcdl2852Ec889/dN5W1QIHeaHZMKHSNWqknUWVpesopNbOBiXzZKqdKMTlmtY4gMWB5Qa3r49CHW741r1LApWtYYs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mGF8tLEr96MnShkP5lVeYyNxRDtVJuuF+axlN9VikY=;
 b=ODRjHK8kofypOJMq9V1ONPHknX/s4FgxMFGqCd6p+iBLn5ge9vQBqE68iqsA4J2ugetSb1lrlbFlSIRIPpk7dj2qjlTGmtM7lH5Ghe1yNvTbdttZBXHqS+2/qy5IKDlSbO0pML3ss+it708YpVu8knD2XtPvCzZYAjXNPPng+bCnTOBXTaAD4Dv9p7Zgo15l6Vd8qOzA9/okSn7ZOh9M6fY48p+SkBqM+1CVsqIENDWjMS0fIaP2y0cHQwQzc8pD/13yYE5jKxFpe7MRvr+kGvM/eRZ4B3SmrP7euzzpfw41Y4djaKt2Hee4eMCKmtgOZ0dz7Ynw3Gwz5Z5DsAMTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mGF8tLEr96MnShkP5lVeYyNxRDtVJuuF+axlN9VikY=;
 b=SYuh+PexLybJsKOLYmjku0nL6zY6EPsIXIwvGc2M1Ao4q1V/oYubrvq+3VhqunjluSUUjHyRCUkMeZrRnZiCB53dJdUNmhaoZIBAguQ5jb2QTyrKiFfQ4Z5bgO2NqYW8inNjmBZl4rRYjJvvu0v1OnohuRcUdy6QUEhntihbva08iN2geJ+KTF4wi9ihIQYrThy7ThDRrL67brMp37QZzm6h+gfE6p0/A7rQEffy2JVGiqFoKHY2ZjVic2aSIBkFerM22m6cYWdv2tCpghb++pqvw0hNs0DRvH63CVn05oypUU/1F7N7qcIfk+aIpsPDMlH+ueNdZfpWQWIh/LTTnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 12:51:22 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:51:22 +0000
Message-ID: <5c259029-23cc-4bdd-9012-a6ff8c3583c4@nvidia.com>
Date: Mon, 13 Oct 2025 18:21:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-2-sumitg@nvidia.com>
 <bdd0aa7b-d239-420e-8741-b33d73959412@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <bdd0aa7b-d239-420e-8741-b33d73959412@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c99329-4afb-49f1-0761-08de0a573642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVJ5VkdzNTRyUkFnS21EMUcwMWd3N2hoSS93ajVtVW9mQlVkbU5KaW5yNDZh?=
 =?utf-8?B?QWtOcXUxbmsvZG1WOWdTdnFmcnh5TElLZ050NmdldHpzQVV4a1BuRUFpak82?=
 =?utf-8?B?QzNRVm5Hbk5oZ3lOWkR1MGZCWE9BSGdRQmZTMFRrRUVPT3pMckJBdDhaREVC?=
 =?utf-8?B?K2VSTmxQTEtrKytJeThHZXRlbmRrWWFRUVJUS2puaWZ3N0Q3eCtobUQxZi9k?=
 =?utf-8?B?anNDYThqdmN3bWlEdTU5OTljVnh2Sy9NRnFrUVZISGpVV2tjTUtLMWExblBo?=
 =?utf-8?B?VVNxZkFJTU9zcTE3K2NzNmV2aGt3MXRHQnhRS0VPZXJuMENGSFlFR2ZXb2xE?=
 =?utf-8?B?c0dsay9kT0w1VHVGWTllOGlidUlFMFVZRVZNODBXdzhuSEVNOS9zS3VxWm51?=
 =?utf-8?B?YUtkZ3RsSWJvMmI0N254UHZLc0dSTWpCMzBJNG4yK0ZEMzBiNTdQdHBBU2FC?=
 =?utf-8?B?ZHFoTk9vQWk5Zk92eDB4VnBQZERWd1ZEeGVEZ3pDZ3FNL3FmQTg1QXpsdVFG?=
 =?utf-8?B?Und5a2M0ZFJ2T3NxUlBQdytIVVhRamN0dUNkMkQzbk9iM3JiOWxkQ3IzNU5Z?=
 =?utf-8?B?bDdRdjY4b09RMzB5QjhZbEpmMVNQVTdPS0tXbVVqUklmUHI5QmJiZ3hnWmpl?=
 =?utf-8?B?Z0U1MTJYa0VYeHpPOFhHZHg4dGlrWDdzQ2ZtZW43YktoNmVHMnY4VjgrbC9I?=
 =?utf-8?B?VmRiZW42YWdlNnFwN213V3RKL3diSVMxeURibFIwb2YvWXQvSCtYMVBsbkZP?=
 =?utf-8?B?ZW5ycERDOVJYemNhTysvcGtsU1dXSjJxWVVLOFMybzkxZUlJNVZGeWx0WVVw?=
 =?utf-8?B?OTVValpuU2xSeEQzM2VLOVpENFM0VUlvRFk5clZVeWpGYXBkdE1yZGFuOXdl?=
 =?utf-8?B?T01oeEJ4d3VkM09vUDdpV1lPVXBuM0ZpNUdpSFhESEZZU1dkVUxnU3FxWE54?=
 =?utf-8?B?cmtxdnZxOU1xNnJWaHBpUnFnbkhFQVRJVnp1RmVzRWxXUWVYNnp0MytOM0JP?=
 =?utf-8?B?d0s1RUNVbWwwY0x6SkFtc1U5T253SllPcWxSS0FjWFQ4N0Zza0JoZW9jY2Nz?=
 =?utf-8?B?UndubDNSa1NmaHNqTHZBNko5YytqQ2czMDlIZWlQaEp0M2lCM1BGNE9zeUtZ?=
 =?utf-8?B?bmVlV2VwbElXMXoxL0Y4SmJDb0tsYzNSVEhJUyt6ejZ6UVNyY2swL3NJWDdT?=
 =?utf-8?B?c0N2VDdydTdnRVdlRThudEFPK3BmUHJVbWdKV3prL3h2cmhPUWYwRk5zT3I2?=
 =?utf-8?B?bXZXVGRKMzR1YzFZYSs5T01FMGg1cm9mTkpJMHQ4ajVjNEw4cnZMQ0h6U3J1?=
 =?utf-8?B?UUcxeVpzdzltMmVBbEJtVTdleDhNUG5SOWt4R1R6NlF3cjNkakZtd0V6WEVr?=
 =?utf-8?B?bUdGTy9tSmp1VWdISnlkSkFNWXZsRjIyNStRekJMMEE2U1Zxd25CWEMrMkl1?=
 =?utf-8?B?M1BxVnZzZGUyUU1kVDhJelRWdjZaQ1dXb0xNTHdVYVpEdXpnTXJFd2cvTjZN?=
 =?utf-8?B?NUlSdHJnc3BHTWZ2Rm9HQUNkYllEZmk5ZXAwSWNpTko0RnhiZnN5czNudFNF?=
 =?utf-8?B?THovS2NMNEVLUXhWQmRrRGZ4RzVFbmF1ZEM2ZGt3SUw1cFArRDN0ci8xaENi?=
 =?utf-8?B?WGthR1NUOHY4RHh5MFpRRk8xUGU0YnFnMGtTYk9WYmV5NkpEUmZWYWEzcFVM?=
 =?utf-8?B?V0k4NnVNWHZCRjByRWRBYTIwWXd4OGpEUk4rL0JoWVJmZk1NTFJVM2FZamZx?=
 =?utf-8?B?K0Z6WHNHbkY3V0dFUXU5YXAwNFdobFRrR3dEZHREOVYzY1RPSnhBQm1LYldT?=
 =?utf-8?B?TmVUaTB1aVVuZVdjRzVxanU3eHl2YVpuUndGNnRyUXhoYXZranBKNnh4NjdT?=
 =?utf-8?B?OFdhSXp3NEl0UHJMQXZlSU1sWTZ5K3dsUUxzWlZNNm1ZdEhDOGhvTlV1WnJ5?=
 =?utf-8?B?WGQ1dTB4U1o4STZ6YU9JdTZwN0hFaU56OUs3S3J6MTVDdk93a3c1ekRrV1Ba?=
 =?utf-8?Q?VCMXYZ8K2e7DeTHG2egEsvTpi/itGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlBUG1wMnJyVGpBNjRFWXBsS0Vuc0lZQytCZDNIVDBNU0wwYnZJQlVUUVFn?=
 =?utf-8?B?ZGpkRDRxN1BBWkNvZmJFS0pwakp3cVpNVHhTUFcybSs3dDlkQ252VDFTSjlE?=
 =?utf-8?B?NUJaUmVmMlhtYWEzRlBoMHA5b05FeGJ3Y1dVd2kyZCtlMWFuQkZzdFpkSEdh?=
 =?utf-8?B?cUxxKzNUblFpenZselhndHpZbEVvUnFQanJNeVFMWWxhbEVoV0tJa3ZmWndl?=
 =?utf-8?B?Z3FVNlZaWFRxZlpPUEZEcUY1YkNtRFY5K1Bob1hpblFheW15UjFjayt2QzQy?=
 =?utf-8?B?MzgySTZJYXpJWjI2alozMFdjV1dMQ1MrcjhTNlg1RXZWTWYxZkRUTU4wbEhu?=
 =?utf-8?B?U055d2ZXY085WDFIS3YydGFkM3JlWGRlTjg1dFVocy9nQ2kwb2dQTjVORStq?=
 =?utf-8?B?V0orcWlEOW9iL0kzUmd6TnBCTkVld2owRnNvMCtCUEJrRk5ZK3JGaUZqcE9I?=
 =?utf-8?B?Zlc2Q0lxejJERTBncXlrSE5XTFRyU21Nek9ER1dOMEtVUlVTRnNMYUU4bW9V?=
 =?utf-8?B?dFlON2s0VnVvRVRsakZUZTNnUnBXa0ZDdFpiaFR4QXFFYjMwRGNCT1U0T2lj?=
 =?utf-8?B?V21TMUk3VFQyQm5DbHFEMTVhZmZzUXJPQjllM2pVNmhhTlpvWHdqTm92WFR1?=
 =?utf-8?B?QS9jMVpXNWxLeEhUVVVkQkl1VmpMbURkZE8wY2xGcytzL1l5UEpjVnlvQmZQ?=
 =?utf-8?B?VVVzbzdFRDFwb3NEWVg4bW1KdmpsSVBVVEhrSmpNOFdyUGpLWE9QQUpmUGhX?=
 =?utf-8?B?U0NwNzVsTE51M1hOS0VjeTd0dzFCaWJaNkF4enlSVTBudUpzazIza01ZNm9u?=
 =?utf-8?B?MlhqSWl4RzRKM3EzSEJYZE9ScitZRjNXeEtIQjFwa2VLMytZQXBBclNLbTVq?=
 =?utf-8?B?OVlZYlNrc3hnWCt0VTl4RERGMEJLNDVmRERpMU5sdXRyM3B0M28zbUNlZ1Iv?=
 =?utf-8?B?ZGo3QzA0WmpIV2Q0bDFhcFZKZEkvNW1jNkRoR2VMNE5Ma2lMT2VtN3VCbnZE?=
 =?utf-8?B?YWJYUnlsS3dDM0syM0E0S0JNMENkSlFMTmNFUkRQY2hVcnhvcnpBa3BoY0Vt?=
 =?utf-8?B?REdldzdhckVMWnp2b2FaZmFkZ0R3S0Y4WGtNemtFQy9lblVTUWU4bW5wNENS?=
 =?utf-8?B?OEhvUHk3NUNudjNhcDA1a0oxUkxwRmRSdENibU5abkI0ODhmQlN3cVRaZExi?=
 =?utf-8?B?Z0xNb2U4VkNMOW9SMFkyeGRoOTVBR0pLbGxhTUZjcjFVdXdVMHlGSWpsc05l?=
 =?utf-8?B?dGtJbzBRY1BiQld0ZzBnL0ZTd0Fma0FDUWk0c25ETDNSV0lkRlFOaHFvWTdY?=
 =?utf-8?B?bWE1Qk8rVmlOcExwTE9tbGlPMzkvTDY4TnpZbmZDWnBOWFZOdGJQZ0I0MXp1?=
 =?utf-8?B?aTI0MnhDd0VxY0t5dDEvUzFsNWYrZUxEUExDYlpUWmNMUG5PaytRME5TcHVB?=
 =?utf-8?B?QksrSGVFeDkwWGd2WVRBeTlPOE5kQjR6Yk1DM3F5cFNMaHRYS1NYUURLRUxE?=
 =?utf-8?B?WmdKUHFKOEl6TUgwUkpjRVFqeklOa2R6OWo5MVJoV3JBcDY2RWFGNEJhZUpw?=
 =?utf-8?B?ZGlWVkJwdVlXZjVIcHg0MWhURlB4UElTTUdUTXNyUWo0TC9rUGNRcGo4bWlk?=
 =?utf-8?B?cThERlF0ZURNZmhXQWd0aFhXYVEydGpJa3UvRy96ZDZXd3QxSkRlMUMzeWlO?=
 =?utf-8?B?dTdRbG55MkdSZXRieWhJRy8rbitkWFhFQStWcXcyOFVtNU9FdzdYdTNGSkgv?=
 =?utf-8?B?YlBFYk1YRkNNSmIrVDhoQXl3cWZ4S3JlRDgzUEttbU8wQm1PTTF2V0U0R3Vo?=
 =?utf-8?B?UXVkb09pQVpaUkVoQ0VnUHFLMFB5TkEySG5GRGEyNnl6NHQrQURlU1dVd0RL?=
 =?utf-8?B?Nks5SmNTeGhOelgvSE1zeWZqUXZRdWRub2dWb0ZxNVk0VjFlaEdkQXVCT2FG?=
 =?utf-8?B?dVJSc3hqWkNmVFJiaEdVbU9teFZnYWlmQkV4ajFWMThJVGJLLzNSUU1hVFdo?=
 =?utf-8?B?WFhjUWRiODY0Z3ZYVUlKVXM2NUhnSkp2ckNHMHNKV0hiSEJXcFcrczNXemZB?=
 =?utf-8?B?c1lMay9DTTBhYTJCK0NVLzFMOStMYVhNL1NreFR2bjB3OEVpeUhMM2U2eXZX?=
 =?utf-8?Q?4WZaghujXp9udG5K6sy8dnZbR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c99329-4afb-49f1-0761-08de0a573642
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:51:22.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeJoqdvU7iD9glaS5OGuzcBIg5dpqoLokrGKMprKg5MM0p+KaQvbXGwgM8WkwXbGVS6z07/6w67ZhVeHlK9Bfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705


On 10/10/25 08:54, Jie Zhan wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit,
>
> On 10/1/2025 11:00 PM, Sumit Gupta wrote:
>> Add generic show/store helper functions for u64 sysfs attributes:
>> - cppc_cpufreq_sysfs_show_u64()
>> - cppc_cpufreq_sysfs_store_u64()
>>
>> Refactor auto_act_window and energy_performance_preference_val
>> attributes to use these helpers, eliminating code duplication.
>>
>> No functional changes.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Nice cleanup in general.  Some minor bits inline.
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 87 ++++++++++++++--------------------
>>   1 file changed, 35 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 12de0ac7bbaf..732f35096991 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -781,6 +781,36 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>        return 0;
>>   }
>>
>> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
> Wrap a bit into 80 chars?

Wrapped line length to 100 as per the max limit.

  $ grep "max_line_length =" scripts/checkpatch.pl
  my $max_line_length = 100;


>
> BTW, trivial but I would prefer a symmetric param order, like:
> show(buf, get_func, cpu)
> store(buf, count, set_func, cpu)

Sure, will change the param order.


>> +{
>> +     u64 val;
>> +     int ret = get_func(cpu, &val);
>> +
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     return sysfs_emit(buf, "%llu\n", val);
>> +}
>> +
>> +static ssize_t cppc_cpufreq_sysfs_store_u64(const char *buf, size_t count,
>> +                                         int (*set_func)(int, u64), unsigned int cpu)
>> +{
>> +     u64 val;
>> +     int ret;
>> +
>> +     if (!buf || !set_func)
>> +             return -EINVAL;
> No need.

Ok.


>> +
>> +     ret = kstrtou64(buf, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = set_func((int)cpu, val);
>> +     return ret ? ret : count;
> I suppose it's preferred to avoid using ternary operators like this.

These are commonly use. e.g. within cpufreq:

  $ grep -inr "return ret ?" drivers/cpufreq/*
  drivers/cpufreq/amd-pstate.c:1184:      return ret ? ret : count;
  drivers/cpufreq/cpufreq.c:839:  return ret ? ret : count;
  drivers/cpufreq/intel_pstate.c:897:     return ret ?: count;

>> +}
>> +
> Would be nicer to move cppc_cpufreq_sysfs_show/store_u64() to just above
> where they are used, i.e. just before show_auto_act_window().

Sure.

Thank you,
Sumit

>>   static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>> @@ -824,70 +854,23 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>
>>   static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>>   {
>> -     u64 val;
>> -     int ret;
>> -
>> -     ret = cppc_get_auto_act_window(policy->cpu, &val);
>> -
>> -     /* show "<unsupported>" when this register is not supported by cpc */
>> -     if (ret == -EOPNOTSUPP)
>> -             return sysfs_emit(buf, "<unsupported>\n");
>> -
>> -     if (ret)
>> -             return ret;
>> -
>> -     return sysfs_emit(buf, "%llu\n", val);
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window, buf);
>>   }
>>
>> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>> -                                  const char *buf, size_t count)
>> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy, const char *buf, size_t count)
>>   {
>> -     u64 usec;
>> -     int ret;
>> -
>> -     ret = kstrtou64(buf, 0, &usec);
>> -     if (ret)
>> -             return ret;
>> -
>> -     ret = cppc_set_auto_act_window(policy->cpu, usec);
>> -     if (ret)
>> -             return ret;
>> -
>> -     return count;
>> +     return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_auto_act_window, policy->cpu);
>>   }
>>
>>   static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
>>   {
>> -     u64 val;
>> -     int ret;
>> -
>> -     ret = cppc_get_epp_perf(policy->cpu, &val);
>> -
>> -     /* show "<unsupported>" when this register is not supported by cpc */
>> -     if (ret == -EOPNOTSUPP)
>> -             return sysfs_emit(buf, "<unsupported>\n");
>> -
>> -     if (ret)
>> -             return ret;
>> -
>> -     return sysfs_emit(buf, "%llu\n", val);
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
>>   }
>>
>>   static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
>>                                                       const char *buf, size_t count)
>>   {
>> -     u64 val;
>> -     int ret;
>> -
>> -     ret = kstrtou64(buf, 0, &val);
>> -     if (ret)
>> -             return ret;
>> -
>> -     ret = cppc_set_epp(policy->cpu, val);
>> -     if (ret)
>> -             return ret;
>> -
>> -     return count;
>> +     return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
>>   }
>>
>>   cpufreq_freq_attr_ro(freqdomain_cpus);

