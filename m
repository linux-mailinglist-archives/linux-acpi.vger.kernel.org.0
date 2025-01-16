Return-Path: <linux-acpi+bounces-10723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D94A13C50
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BCC7A04A1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C31A08BC;
	Thu, 16 Jan 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjKzav/Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03624A7C9;
	Thu, 16 Jan 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038011; cv=fail; b=ZWjLKtEJLjGC9NJ4yTmVVaLZJ6zZvzLeSZksBpUpoDCP52MLEpzcoOOfNQmgQx6Y+vcY2yYparTnfgeuNa9XBCFuANKLad1kY7xIV4zqRrvHr5SfkqidiPINejKeJRtLlHAYp7sG0Tu4RWUnjhGSwsQduysUFiLsD+zReJF0mE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038011; c=relaxed/simple;
	bh=+wCFR4cbTtpCXxTPQ73IG2OhbulkuGfw/3f2cKhJyw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m4mLrF8wHukT5dzSK4eiyrndQAvLYvQpSGUkaAIbJozDbr7tUFGTy+1JBCEmYM2dGn6NUZv35WYnFEi8Fwa6S7koIL/S+SLNTCOlTtBqW9E56TYnp8prhYAHjuxeDtr6KDhMgs03f4K+KGQsLTfVA4b8qd7E1qnR+69sg3uHVr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjKzav/Q; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azZiUESP2tvceq3DoWtsrAx+ggVB8i0aTW23lnSea4BHL03g9zrnwCFulqtosvWCpoAQtg6ZEBI/nMkl6ryFyeIPliFbC9XpHvhEJEpbbqePgRhip1Q4BDE0iEJ1LWv8Q1/ijDBcLfGLUnidjugldovSJNS6V292cxDZ55c+Ta3WeV7nohEepgL9JyOj3msKMvZRt2JKm6MiRv8GFXUGqxUngwVB60hdQCd4kGUIyXbtkA7pt6Fh1EKQHfjBkkqi1PLIflNRG6qWgBcoSKrL9HQw0PtgRRvWljqkiab4d+Y6uWRbLvOMMWWEOSwGHedLdWsCRj2z79BTtKLw0ZNLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW2XgVxHvxxZIbt/kIgbWtUXpJO2SXqbjzzAD1tiq+w=;
 b=dqLJyrbNjSi2wFYfyZozCkYHS9oc28Yp6zAvCIQKxz68VPpXlIaamb8pnvNm49Fp38YcqZwQ/X4Lp/Lx46q7rQerBARu3+5xiZ3rsjaT1uKmsq7w3GPDXCl5ZA111vFkIO5blmEMJ10dwM8VsBPK4ttp9p95kiBLph5GCvcIuziG2jp5B8/7vERfVNQ6XWkuIeRuTEId1sMxdfdNInL0MaqY7+iRinh7sto6X4fknBYpZiWAwJMbTmRjN96Fd5c1rPmHVIHMmi+34F1UULSiWHNKiGSVoR3UPwgFlmKVygwrGv9c8Ip2g0QuVShcwSRUQafxT7DvEzUCcThVW9MPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW2XgVxHvxxZIbt/kIgbWtUXpJO2SXqbjzzAD1tiq+w=;
 b=GjKzav/QSryx3MtZeAIIaz4CWpFDbGFw0w+QQ5cVRjJEKoBufp+u3j+KQOdDUV7boDryO/zhdYmU/yIKHz25V6ps689Qz7KiK7Bb7qXZJ2YBykkfxCTIGxi3tzf4Jw7Kzi0Q9y7KVy/Bp6nOY+g+GNKzc+7OUF7Foehs23saYUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 14:33:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:33:26 +0000
Date: Thu, 16 Jan 2025 20:03:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	viresh.kumar@linaro.org, mario.limonciello@amd.com,
	ray.huang@amd.com, pierre.gondois@arm.com,
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection
 in cppc_cpufreq
Message-ID: <Z4kYq7JChZ+6ZKpx@BLRRASHENOY1.amd.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <Z4fLXPgMvwGur+pz@BLRRASHENOY1.amd.com>
 <f89fc07a-1c65-4d1e-9ad8-76c6c9a15b25@huawei.com>
 <Z4ijkAFOMtVAOY6u@BLRRASHENOY1.amd.com>
 <ad254dd8-24f7-4aee-9f68-5d1890e87c81@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad254dd8-24f7-4aee-9f68-5d1890e87c81@huawei.com>
X-ClientProxiedBy: PNYP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 701044fa-93fa-404d-a15c-08dd363abd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oX+XM2cto/RbLhJEk77QEsplJNRXUer0sErpPqryQyVIUbRIgibGj8XvuA1u?=
 =?us-ascii?Q?i53MaSKz5HIAxGLgMHb1iLlyQya1AqdqF8Aex+vbFMcu59P//MEUhGngxlbo?=
 =?us-ascii?Q?yARLSaTYkV1Pt6/xWXIwNof5oi8vOVLhV4VmEhUlNaFUhVDMXsGr+n8EMOxM?=
 =?us-ascii?Q?O36AnsnTJaYnXSqv9XZNLcm1bSGkpse1doexvzrjx+LSHA+LzLol1ypq/kA4?=
 =?us-ascii?Q?IkwIk7Y89NR1/AtlmLeJ2mJmitKA10LZSg9ImjxPEleP065JEtrMqG1R7gjd?=
 =?us-ascii?Q?EOzOHdjxwosCmkm6sxIKbZfL2So7CDpd0rUfFpJmCYvRpvRztZMNlTF/Tkd7?=
 =?us-ascii?Q?v61/uniDD3IGZweoVmYUj2Rb9RyfBtAIYlWtMitzxxzOrzaIhz5NHkxRLr0O?=
 =?us-ascii?Q?/DMqH3RaHsj/uUL7XRMu+jcGnXc3v0wYbkmg0dhnKcGmQAwiNEouLij44xru?=
 =?us-ascii?Q?yMIc5QYNDEPQ8GlNPELaypW5rxhjCu8RUrzXTvvBiCYgaYle9ce/nwarKSQQ?=
 =?us-ascii?Q?hlEt5inem2WrzbmpYarzb3ImcLdKkPu/YaXNk6vUraRx0OwAUvYMZyTQIl1t?=
 =?us-ascii?Q?wjxvDAzxsxeMnM+g9UDjrq/t0Z/qk4Aoqmamw5456y7gPOOpl4p13Hf3HRP9?=
 =?us-ascii?Q?WQH04COBAcIqiHEiohRMQ8Bl4JBbOrc/tyYPdHk2cWx/fN2ERvv3iUXLr96W?=
 =?us-ascii?Q?KqvQ70/wto+AcI7xQNrz11DbKdVwC4BgibcF2Sv+18o6Bx5uQJfJtHcREN7S?=
 =?us-ascii?Q?SNLzlACr/Z4jxhxgcSSZrvpI6nIgJCSzSCxF8rj67xKw0SwCh4Vrthhz7UUY?=
 =?us-ascii?Q?pNeMPGshLvsmuHnnS967ait/9l+BR4ASaPOEFr6bwyRHcZ4aFJJekMg3k2wd?=
 =?us-ascii?Q?/sS/i8USM/YAl3ztUfBTgzEkwsGw593WuDfmxs9okQeQiESXVVd0OHyY+c8H?=
 =?us-ascii?Q?/Bv2qh80FebTtkOCAxzRhoiDNdU+JsR225XyflUQBvyRfVDRF7xdGXKWWkyD?=
 =?us-ascii?Q?ykFsG2jLAekqXHYmZ07z2FY/2T1PYPohNDldFSQAlcjsaYWxS+a+KifFgPSg?=
 =?us-ascii?Q?HqE3mMeIImz9+I738cBdY02bCWkoyfXRZg0cmy/JgR2k2Wjw0NXdLOYQ0Ebs?=
 =?us-ascii?Q?ST5yln0WPpu0j0+/WLx0wj5/kz6mVQEmrPLz+wW80CGC/dgE9h63j9LQeZuI?=
 =?us-ascii?Q?VR7OC9yuuGTg8qw2rum5RLuxUB5CfjhDLn/LWw0R8fAuog79w2m8v+yD4Ash?=
 =?us-ascii?Q?IQ9UglVzIfain7qcRswpHirqzTcSy+sVHoGAwvbM6OPMcf8ol/9ykQhtCmxA?=
 =?us-ascii?Q?V8EzOCh5fF2AiTWTB4UMKkTHPec9gnKbkgXkQFFVX8HejqgsJcQpJEjvrMix?=
 =?us-ascii?Q?EeeCip0B9aQEOaic1qKKU+/vAUty?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dyC6b2Vq1dAYcfpXdbYAHKw+56njR8ji6UI7N83IdYyQMQwV1Q8cRQsR5F5?=
 =?us-ascii?Q?KNENxWyeMn+VjBHhapa/w8u+9aXJJL/+Z/DPjR4AOrsHfKbqDGY1YQORrJmh?=
 =?us-ascii?Q?qYUfJbcUkQ0OINLfKZpFVtOuPDqrcdFQHz0kJZGrLvN2b2wGilba0BjeeLDk?=
 =?us-ascii?Q?HlpexwtaTwDq/mRHPbcAsj/q4LCLTyZ3hFX3ICp4UFzrvCfPKnc3oiiojLCk?=
 =?us-ascii?Q?Lst4EMLKHT/3ZLFZ75msVOJCbyYNwRcRV5ofDRZzws7wXQlrX/e9hFg9MAV5?=
 =?us-ascii?Q?VNMriVm1EOx69bXWLYXpKLrxhe8zjcy5OYpGt2NzAbFtB2hNdgNjhwRg2ePA?=
 =?us-ascii?Q?f0o9FTHwNzmdoLbEcRNGY5OVxpH47UJQ6gBUV0iYcOE/RlKprMf7qJ3EzOFf?=
 =?us-ascii?Q?L7od7QEwHyM5gLVXHLim+bBLX4uuEMnQZXMbQ38EJ9NDqinjL4ePNmAZWq8r?=
 =?us-ascii?Q?NYZ0HCTNnqFL9HlUFLBFz/pLro+1ZQhr/cUCzJvDoxbOEE2yMhaifqC/KnXx?=
 =?us-ascii?Q?OAoqfgEIH1zQhBzqv1P/KTgLGeYjbeZYD3mMH9zdgF2guakZBXKxlkoItNcU?=
 =?us-ascii?Q?022Z5R/G1VPKO7ZtvZ/0TtOG9f/XCxaKgO8g/627H1ieH6jg++sR0hmQx+Km?=
 =?us-ascii?Q?IXkbNQ8hl1BiCMd8q3TqkmhUJXdLfH1Oz9aGlWEk5754sPXqtcmOdlOkXrmD?=
 =?us-ascii?Q?nhnFA8+1ELxXL/cJoKPd/ImCivc433KTudA/c3Jv5bHtICTpr5k7XguAfMvi?=
 =?us-ascii?Q?HIMKV1T1EHRlff4niEratjQzjNxD/q1bE9ET94Q/Q7qaJyctY14fXelLvyhq?=
 =?us-ascii?Q?rhBJzIXxAYAOSehhGFIfMCz+2Y0fX4EJLLV+2ODxkSsPdhkoNgQszYk5yd6o?=
 =?us-ascii?Q?no5WnrnRB3iDvHl1LXsOgtf5KwhcXnfsw90Eb0LRoBGdLj3mre3hKQEwmX1Q?=
 =?us-ascii?Q?2f0sI5XRfjGTrcrECWBV+I9crSHbxIPdofB9HlhWrvm26jG8SVCJOGYW68yH?=
 =?us-ascii?Q?7bnNDgLePHfqN0ewShWzcdEZlw6ih2+DlExOyyKgKSJcmVMWnXXQ0R8HU4B6?=
 =?us-ascii?Q?v0xSXHJLPmqoSLnNfPPcf9SH18vNUBV1fe17IxpQ3LDhDFRA7GOKjrHJBk+n?=
 =?us-ascii?Q?JD3emVnBr4tY6MJQyz/1jGMv5EUrpQEh8kBxTy+PwcVi5Uf3APVBAw3BtzS9?=
 =?us-ascii?Q?6pYHFXS+m5jxrV5ojVMEAKFEbcvSlIfwb6HMT/HT7TP3Xy6IhzePBQUfhnbA?=
 =?us-ascii?Q?j5RDoOwh+CeFqNqxfdnYD61JIoLSw7+UyeWbPG/k89iz8e9p1rKyVyHMw8YU?=
 =?us-ascii?Q?YYJQB+rqKPmW8pXfEMFlDKQzRdDdHdR3cBEyAL5QUS1w3fOfKgrt/kqPzmx5?=
 =?us-ascii?Q?89jvOyHdXCuONjhA2DrM03yZW1XEHpSOrnVEbKZAWtpS4cSnu32HDBE2XBg8?=
 =?us-ascii?Q?xIoiONWbz9+GD3B2aIsqJ06PA2mYrVwUfmq157wqeieNyE79pEv1CxdcyHMv?=
 =?us-ascii?Q?8GRQj5KTykeIL+GIn4JNm3+6T2PiFwahVYosbUZFFoWjjfsczdv/LnkcilE3?=
 =?us-ascii?Q?ZapcZc90YZT5rTNOvuEOm99ElGXzX99/yeKVQFNf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701044fa-93fa-404d-a15c-08dd363abd1d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:33:26.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J8DPWyXcN9nVobxy6Mag/LQk/hXjCRzIFRL4Qw+mwl1hP2Wv+MJlGwNfL1EBu70MGXU2wbmACAxUeS7ykVebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On Thu, Jan 16, 2025 at 04:01:08PM +0800, zhenglifeng (A) wrote:

> > @@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
> >  {
> >  	struct cppc_perf_caps cppc_perf;
> >  	u64 numerator;
> > +	bool auto_sel; <--- Not needed.
> >  
> >  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> >  	if (ret)
> > @@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
> >  	if (cppc_state == AMD_PSTATE_ACTIVE)
> >  		return 0;
> >  
> > -	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);   <--- Not needed.
> > +	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);         <--- Not needed.
> >  	if (ret) {                                                <--- Not needed.
> >  		pr_warn("failed to get auto_sel, ret: %d\n", ret); <--- Not needed.
> > 
> 
> If auto_sel is not supported, this function will return 0 after getting
> fail. But after removing cppc_get_auto_sel(), this function will return
> -EOPNOTSUPP by setting. Is this alright?

This is not ok. The shmem_init_perf() function shouldn't error out if
the auto-selection register is not supported.

Also, looking at the function, there may be a few additional cleanups
required in that one. For now, let us just retain the
cppc_get_auto_sel() and cppc_set_auto_sel() functions as you have done
in this patchset.

--
Thanks and Regards
gautham.

