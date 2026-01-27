Return-Path: <linux-acpi+bounces-20651-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH3GG82ceGlurQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20651-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:09:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDB39362B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 548693009E3A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC888341046;
	Tue, 27 Jan 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0vfQJSV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1F345CA6;
	Tue, 27 Jan 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512115; cv=fail; b=lGDCITKC4Kper1OmSqaGSXN29uMJkOnQeOW5Xk83c7u+TeeEx6HU2JEt8iUD2GQkgSNeSB27YR+HG+GB+1fmuKy7/rAsIv4DeW9ove4RAVP1BslOiZszfHGseB43hsrk5fjQ5sV2e6Z6bbvHkFNv6I1C2na/2FSXR870Kp26hqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512115; c=relaxed/simple;
	bh=cw0RWalwtx3+ZPKtUhuJvykQnUMkDw887Tal6f6KqPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P8hX964syMbTIyay/YipSquLE0IfzVKIYTanQ36aFTKKlK+AZlR3I8HylqkRaOBRUb4o4QN2Kdxbb89mTaGSwq7/aZDAkWnAqotUEec0ch8UrAXlvONhHFpQ85b359WNGXPks8aRtLguQ0wjSUBfQWSgKf8gFTdXc5NwjUnpgZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0vfQJSV; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXR7R3STUycBE9Ueh2bSBboQlwTMhP+Duyyj5jMUd1UXLuOoC2jxnzq2WTW3FoqavLDhoV7XcfVmdYFqGFw3Icusm++QvcEbNDliPy9RlZTthRvF/zGOiMXOP4VfOMT5uvUQcCckl1PDpBqDSCUjlgZWa69qLGEGRHqhwkK1yyrQ87ojWAiDUaUGoI75LONP+UPNLdV6tdv4VzgzPfUr3wZikuzSKc80xxTJkY2PbuzMOG00nmyIvRYxkx4HDP/15xIeNJg3U+Ii+anLUrhhdGKr+ZLIbCyHRw8MSKNj+a4KO1vVjv+POaL0fWr6yW2WcwOV6OgNw1D+F6oWZh6sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHNqRXr1JBM1q+38WjROpOkoF8WoRRJXQq76n7LanlA=;
 b=qP0XeHhFXFXW5VLntgqaA1gqhW1TDGvPK/6ZUinEk31Veez/guY8GDrp0Y1qVEbhAv3agaR5CGwQyjU3FH17ei1Ppk1r+/6nhkAoFK8LcrO9bdkIlrWaScc4G17IV/o2uzzh3OjqumG4NS9CyRm8Y6sOHEbwU4D5HBuPPV62LBD1zItkPVQKudGZZ/rc3Ue9LJ33G0fMnsjg5UUoOPG0RlLE5RC4RXd3jnLqWlmdn18rJoZ86edm8Cz4JyqQ7cE8shbGeAtkwva9ro6IUTrc4UPYUiMrg6fT4Bu91XXtJqYpH3jwlj2dxNSMWZxaZ3zMcsjUWY8+B7FIBHzMlDsDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHNqRXr1JBM1q+38WjROpOkoF8WoRRJXQq76n7LanlA=;
 b=C0vfQJSVjyrNc8SORT0NmeVU//DquOJI+hsiq6ghq1r+3iB0XJB5F3BwhMdJeFE1At9zqabpKMGlcC/GVQv2phlO5BQmSUWFbl8a+x0yIlyodMbfeHEOu4RweafrJsQQQbaoesgX14xA8CoQHJzWfDZEKRc9L/sHolnNlq8BxRyJe1G7yBiUBcvuxwUZ0inUfwORORyX1yKZfPDCEYF/E7n3wB+tftMg36hRPLMMUcoSln8CAI4YidubKE/ZzL/eMmxth6S3BGALoIHaPX0MdnwRjXk2LjlCNStXlv0QbMhmQdrGtnTp9cjzkqN5fT+3bFs9RZGwsjI4jLQc1DUYlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 27 Jan
 2026 11:08:29 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 11:08:29 +0000
Message-ID: <9fa21599-004a-4af8-acc2-190fd0404e35@nvidia.com>
Date: Tue, 27 Jan 2026 16:38:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Pierre Gondois <pierre.gondois@arm.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
 <fb4b68f7-ec64-4660-99a3-d288bc20ffac@nvidia.com>
 <53827af7-f3b6-4e1c-8c8d-2f57ef5be97e@nvidia.com>
 <3097e4dd-a895-4c55-96c7-433ae1d046f9@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <3097e4dd-a895-4c55-96c7-433ae1d046f9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: ac84f9bc-4708-4720-0057-08de5d946672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm5YWVdhQjRDOVFHR0dEMHZuM1hJY1ZBSjQwc0svTzF3Y2tYZG03Q0dsMXhK?=
 =?utf-8?B?OGtndWZxSlp5eklHMS9nYVllVDhGajdqeXdoVUpqdTNkSUZBRTZRUzI0T29t?=
 =?utf-8?B?Y2JMQ2J3c2RadlRNSFBHSlNMRVdxeWJHTWlzUkYyeWR4OEZMNjNleG9xV2Fr?=
 =?utf-8?B?OWJteW05VW01dVo5bUZ4LzBObmdkYWlHeDBwekdSTkwrU0VZdk41Y29wVWk0?=
 =?utf-8?B?WjZEdEJHTTB4WVBQOUtvRzY4U0VLUndDMkVuWmIvQkZNRWVhWjNVYjZ3dmdj?=
 =?utf-8?B?VnZVOEtHcFhZeHRkbFpXUFFhR1gzZ2J1ZStBSTZhY1NDMTR2UjgvOXhWRnl0?=
 =?utf-8?B?eSs0MXNMZ1ptZDg5L2E5ZzZXMUx4bG9kSjJwdVU5ZEJ0ajluTnVPK1lmTkYw?=
 =?utf-8?B?MWgvdDNuY3JqYVdDSTVVM1FxSWZJY2hML2lvZ3pJdkhEWlgwNi9ud29EMUNo?=
 =?utf-8?B?RWFKWGpRVit4RWp2TWNseDYrNmpxUnNoOXQ0RWJFMXArRWh4ZVNFNCszdkJV?=
 =?utf-8?B?QW1PdkduTkFNMXZ1dlpIRERHVnV4MUFLdkxsTnQ4N1ZtZUxhaElLNDYwL1h6?=
 =?utf-8?B?R25qeUFWekxFMXNwU1M4cVQ2ZjJqWHdxUWx0UlBPZWlINWh1Y0J4Qno5eVA5?=
 =?utf-8?B?d29ya3ZMYWNuYnJDK3FUdkpMY1N6emFwOUhyYnI2UnlrS3BnSS94VnBCZXgx?=
 =?utf-8?B?bjRNR3MveUJlcjRuYUsrR29ZdUZ0WTg4WXpqeVFudjFuUlhXYWVxTEtaMEt3?=
 =?utf-8?B?YkR6Y0lrcm9ScFU0TkFqT3JySnc1Zml2LzVEOWo0cThIdGNnNmtLUHdrZjZm?=
 =?utf-8?B?eEpWaTFXOFg5OE1lY2xnUVdySFR6RTRNMm1DYW1kUHViUDhVZ3V6MTVwaW5Y?=
 =?utf-8?B?K2p2YmxyaEpTM3pLUlBrd2hib21rYmt6VURMdEpYMTZZQnMvUjVmVmNadUxk?=
 =?utf-8?B?U05aODY3VDlsMTBiWEplMXlzOVJObmwyd1ROTzcrdU5QaGFPazFVUUh6VEsz?=
 =?utf-8?B?Y3hFR3I0Z3Q2Qk5KUTR1YldyL1lHQ1pYSndDQ1VzOG5OVjd0R0dJQXI4cndQ?=
 =?utf-8?B?ak4zWnZCdEVxcStYb213Q1lnMUpob2FQM085WW5UaWJ1R0Ixdk9Fa3RXOUx4?=
 =?utf-8?B?aDErcmRUblVuczFzZ0lZUDEyTytZQUl1VlR0WWxBRU9yNmZMcjJvQ09WSWg1?=
 =?utf-8?B?a0g1SGlUWFRMWC9CSmVwcjdWN2kwc1ljWGlZUFl1OEhxSEdkTkprRlo5VU5Y?=
 =?utf-8?B?M1NGYXlDSkFnclVVMVFhMnpaZWpTdVVZODJBa1lYKzFuL3h4RzRoZ21ZZ01G?=
 =?utf-8?B?MjlYakxIRnhFZW9Kcnd2Q3lWQ3RVK0pzNkxNd0hFYkdHdFFjaEM5OGtxYjQ0?=
 =?utf-8?B?ME0zYTFWbm4weWt5cXZGcDNhRHF3OWk3RzlVaGlhOC85RlJyV3RPWjBlQ1d6?=
 =?utf-8?B?ZlBGcis5RjBkaFJadzdXN2hGRW8rTnRUQnhUbEJET1Q3dVBqK21LZ1RoenJV?=
 =?utf-8?B?VWljcHpUVXQ0R0hDWS81K0gzQ0JZMUVWRzl2M3B5K1pKVEw2YUpFZDY4V1pG?=
 =?utf-8?B?M1Avdkxkd0NzYk9aN1ZOcjVRald0RHFQTFVYZjA2eTVEY0dCRUlyRGxLVnk1?=
 =?utf-8?B?aENwMjBqNm5PZm9FeERiWDE2MjF0OGh0NWd4WUcrckFSRUNxVzN4ZC9lYUZy?=
 =?utf-8?B?SU5BYkNoNHhwQ3lBbkw3NjNVRDViOXlhR2tqL1cyTnI2bjloczd2Vm1jbXRL?=
 =?utf-8?B?eGlRNXBZZnVjZHg4eXFzVU5LQjF3WW5Mc2p1VnI1MFNWNWZkVWpaREFQZldq?=
 =?utf-8?B?TDluaktReFBnR2xCeFZmaGwwVHVya0kzdlFYeWw4ckc5NlphM1VQdTBidU4r?=
 =?utf-8?B?cVZuanJ5Rk1FSXZJRk1CdmZ0N0Fndll2eUdEV3NDaTJGenFFa3JGZnhVZ2JV?=
 =?utf-8?B?QTRiMFhLVVpEenM3M2drd2dvMzhwQTd5Y3R0NEVmZ0MyeG1UU0dKalZ5cHN6?=
 =?utf-8?B?MzVIL3BQU0xoVGpPMFFWOWt1ODVKU1JYMEdlR1k4VkNDRFpPZzB0RUIwTFRO?=
 =?utf-8?B?ZWFoaVl5UEQxQVVEK1pqL21tb0FtUHd1b0FnNjFWTVlyU091M2pwWUwybEw0?=
 =?utf-8?Q?4AU8IV8YVyIGHF5M16O3ozGA6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmpkOWFOb3h4VkdURDZOLzJKZ0I3bGtaakk0U2EzWXpjQit2ejc3c0R4V003?=
 =?utf-8?B?UXZHZExuZ2RveEtibUFTNzV4bGJ0QWNBV2dmNGNJcW9ER1hBVWg4d1lnQnlz?=
 =?utf-8?B?TklQZ1U2TWtEMUwyV0ppa2xNN0h5SEVTeDdPa3p3em90L1pUak1iZXV6MTZQ?=
 =?utf-8?B?OGIxcDBFNjNFRTJVdXIyeVAwVVgyUFljUmhkRkZDVngxeU9NWVRwcVVWVmlZ?=
 =?utf-8?B?aXJXNmtZOXN1Wi9LMFRvN3BLYmx3NWRobVVCYVNtTTJvK25lQlRvYlA5Zm9m?=
 =?utf-8?B?VjF1OWJvZ1VJbndDOHdzK0h5SjB4UGdOanVWZ2tEVyszSVB1Q0UvT0RGQzBO?=
 =?utf-8?B?NlQ1OVUvNWlaakJCT1g0dTJGcGFrVUFxZzN1MTdLSGdNWEUxdXhsLytJQ0dq?=
 =?utf-8?B?MisvZ1lmK25vbnZmZnlodFFVa0tYVTFmVjMrSEFZSjJKQTZiQldWd2JoekhL?=
 =?utf-8?B?TWVwNHQvZlNvTVlPOXFQVWM5UTZVQklnaWM0a1A1UG1sU0dUclZ0SVV0MHo4?=
 =?utf-8?B?c084MEs4dDZVaGJnTmMvLys5QWhFbE9jTGFTWGRIaGYzTE04dndaUmhSMmJ0?=
 =?utf-8?B?UVM1OHVrQVJlWlpjVHltRmJ4QXBCeXJTME1oNkVoNERQQUE5VDlqbDFudGQ1?=
 =?utf-8?B?L1dYNjR1TFFsRFl2cFVpcFZzR0IxU0M4T0pzeHA2VDV1c2ZIemxFUHpaa0sy?=
 =?utf-8?B?T1padHFVL0syaGxSejc1NjVmbTV4RUtjeGIwOEgzUE1xc3lWbDhrVG51VnJy?=
 =?utf-8?B?andHTmxtMVpvNUtUSHZlbUlJbzE0OUl2cktxcUhoWTNGcTd3WjczMWtDd1F0?=
 =?utf-8?B?ejU4aVJ6eTduUmR5eWVFT3hydGNyOU5YMWQxZFY5NStIK29acVV4aUd5Q1ZQ?=
 =?utf-8?B?emhUMW0vZ0NaNFc1b1RSekpISDhXeURJT2VYalJKUDRlZG1oWEVJK093dkJP?=
 =?utf-8?B?aE5ZdVNMNW0zYmFxVkdGOE1TaDdPOHgrbWVoczhJaUdtRGpReUhQVnBiZjlv?=
 =?utf-8?B?Q1ljdG9HdmNGa2p5ZGFXRTlVRE4zTG9GZzZkUnpvYXkxa2NkZFRYRkpzMEhD?=
 =?utf-8?B?b09INE1nVFFWV0hueENRbGhtZXRra0dZTWJ2eW1JZThhSCtDMHRZbER4ZTFl?=
 =?utf-8?B?R1A4dlk3VXFOMlhUWjVkcFdDSTltR2tkSE05UlM5OW12d1IxQXpYVWlOV1F1?=
 =?utf-8?B?eW5HbEljSUhLaTdVMzRqN3h6c1g3M2FOUkJJTlNGOUh2UmI2bnpISWlCVy9r?=
 =?utf-8?B?Y1FZdlVmazNpR2RET0txRUo5eURpbVNuMUZidkVRMVltQ1oxeDRxYjh1Yzdl?=
 =?utf-8?B?VlVsNm1wNXlBVkROckVnK2toQ3VUZ2FsZHUyT0lLY0g1R3NYa2FuZXVRVW5j?=
 =?utf-8?B?ZTZMWkhZNTdkOUlXb3FVMUI2TGZGaDNWdkZGM1A1NEpPZk45TDhjNWEyOFV5?=
 =?utf-8?B?SFJvZzJ2UTdKY0pPODJNVXFoNkxDK3p6RnBVVHhwT1VNdmdLS1ozVXBmczYw?=
 =?utf-8?B?dzFSZ1k2VHVmZzd1RFlsNm8yb2ZaRm11Q0F3ak5MQ0Q0NEtLY21hMmF2dmlt?=
 =?utf-8?B?WkgyaE5ZNm1CY25LYlRyTmgxNkhrTmE0eit0cTdLMkZNanFnUEJsY3BhNGRu?=
 =?utf-8?B?TlE0OVZiR0pScGo4NEFCQUM2WkRqWWtlMUhZSm5kczdoemlUYjFDSlF0Mmdv?=
 =?utf-8?B?cGJtWHZrZit5b1kzczJPK2pNU3VMZjB4Y2tLZldtTnFrREZzQ2pDM1ZNeStJ?=
 =?utf-8?B?STVoWHJpUTZ2aU5FQkthT1lOSmt1L0R0YWttS0NkMW1uRER5R0toMWN1YW5x?=
 =?utf-8?B?TFoyTCtGdStNL3ZCeGxRUTIyWFFQNEJ5VHB6UU04KzFCRDdNTmdDMmR6ZjBN?=
 =?utf-8?B?NTNqQ09jemZWR3hhS1NaeHowV3BHMngvWk9IdUV2MG02S3VvS1ZDNFBTTjl3?=
 =?utf-8?B?SDYwZnJXS1pRM3VVUXFHRWgzMkVmQnU1SEhscnZYUVEzOTFTeVJvSC9XRW5v?=
 =?utf-8?B?ellnNE5VdW5MZ0VhTkJyVlM0Mm96RllnLzRVZC82ZkhDQ1JQdmxIVktVUmU5?=
 =?utf-8?B?TWFMdGZwbTU3RjBielJKdS9VcmR3SnluU0ZXQTZqdHNIMHFHRWdzazhIN3NR?=
 =?utf-8?B?SXRQNVc5VkdHSktNTTc3TTREVTRUOE9OamV1MTdueWhNU0FNdEF3NC92ckw5?=
 =?utf-8?B?OHh1cnJ4dkYwMFZKU1ZyNGJzVWh4MXBvMDcxY0ZITHZCSDJlejkwZWRrVEl6?=
 =?utf-8?B?dnM0MEFjTFp3U0MzVXFMRTNtQ0RzVEszRzdwSzV2MHBqQll0alBaUHlUc2NU?=
 =?utf-8?Q?pO6XpU9LKMc4JvgdqI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac84f9bc-4708-4720-0057-08de5d946672
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:08:29.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCkzW+rOBWla3d3Ni6aJeCyOkG3pJDaBokoYMH1ypkYuJnf4JOICmhJTvN7d/LbRArClJaoPUo8t+DWm3Tt+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20651-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: CEDB39362B
X-Rspamd-Action: no action


>>>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>>>> Add cppc_get_perf() function to read values of performance control
>>>>> registers including desired_perf, min_perf, max_perf, energy_perf,
>>>>> and auto_sel.
>>>>>
>>>>> This provides a read interface to complement the existing
>>>>> cppc_set_perf() write interface for performance control registers.
>>>>>
>>>>> Note that auto_sel is read by cppc_get_perf() but not written by
>>>>> cppc_set_perf() to avoid unintended mode changes during performance
>>>>> updates. It can be updated with existing dedicated 
>>>>> cppc_set_auto_sel()
>>>>> API.
>>>>>
>>>>> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>>>>> perf_ctrls with current hardware register values during cpufreq
>>>>> policy initialization.
>>>>>
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>>   drivers/acpi/cppc_acpi.c       | 80
>>>>> ++++++++++++++++++++++++++++++++++
>>>>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>>>>   include/acpi/cppc_acpi.h       |  5 +++
>>>>>   3 files changed, 91 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index a09bdabaa804..de35aeb07833 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>>>>
>>>>> +/**
>>>>> + * cppc_get_perf - Get a CPU's performance controls.
>>>>> + * @cpu: CPU for which to get performance controls.
>>>>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>>>>> + *
>>>>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>>>>> + */
>>>>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>>>> +{
>>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>> +     struct cpc_register_resource *desired_perf_reg,
>>>>> +                                  *min_perf_reg, *max_perf_reg,
>>>>> +                                  *energy_perf_reg, *auto_sel_reg;
>>>>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0,
>>>>> auto_sel = 0;
>>>>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>> +     int ret = 0, regs_in_pcc = 0;
>>>>> +
>>>>> +     if (!cpc_desc) {
>>>>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>>>> +             return -ENODEV;
>>>>> +     }
>>>>> +
>>>>> +     if (!perf_ctrls) {
>>>>> +             pr_debug("Invalid perf_ctrls pointer\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>>>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>>>>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>>>>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>>> +
>>>>> +     /* Are any of the regs PCC ?*/
>>>>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>>>>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>>>>> +         CPC_IN_PCC(auto_sel_reg)) {
>>>>> +             if (pcc_ss_id < 0) {
>>>>> +                     pr_debug("Invalid pcc_ss_id for CPU:%d\n", 
>>>>> cpu);
>>>>> +                     return -ENODEV;
>>>>> +             }
>>>>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>>>>> +             regs_in_pcc = 1;
>>>>> +             down_write(&pcc_ss_data->pcc_lock);
>>>>> +             /* Ring doorbell once to update PCC subspace */
>>>>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>>>>> +                     ret = -EIO;
>>>>> +                     goto out_err;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     /* Read optional elements if present */
>>>>> +     if (CPC_SUPPORTED(max_perf_reg))
>>>>> +             cpc_read(cpu, max_perf_reg, &max);
>>>>> +     perf_ctrls->max_perf = max;
>>>>> +
>>>>> +     if (CPC_SUPPORTED(min_perf_reg))
>>>>> +             cpc_read(cpu, min_perf_reg, &min);
>>>>> +     perf_ctrls->min_perf = min;
>>>>> +
>>>>> +     if (CPC_SUPPORTED(desired_perf_reg))
>>>>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>>>>> +     perf_ctrls->desired_perf = desired_perf;
>>>> desired_perf_reg is not an optional one, so it has to be supported.
>>
>> Please ignore my previous reply on this. Had some problem with my email
>> client and both mails got mixed.
>>
>> The register is optional when Autonomous mode is enabled.
>> Seems the comment here is already resolved with Pierre's reply.
>> We discussed this during v4 [1] also.
>> [1]
>> https://lore.kernel.org/lkml/ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com/ 
>>
>>
>> Thank you,
>> Sumit Gupta
>>
>>
> As suggested at:
>
> https://lore.kernel.org/all/5afea521-7d80-4e72-8809-77af60b0d957@arm.com/
>
> Maybe it would be useful to add a patch checking this:
>
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>
> index e3796b520e473..7db74e19425e6 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -854,6 +854,12 @@ int acpi_cppc_processor_probe(struct acpi_processor
> *pr)
>         }
>         per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
>
> +       if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
> +           (!osc_sb_cppc2_support_acked ||
> + !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
> +               pr_warn("Desired perf. register is mandatory if CPPCV2
> is not supported "
> +                       "or autonomous selection is disabled.\n");
> +
>         /*
>          * Initialize the remaining cpc_regs as unsupported.
>          * Example: In case FW exposes CPPC v2, the below loop will
> initialize
>

Thanks for the suggestion. I will add this as a separate patch in v7.

Thank you,
Sumit Gupta



