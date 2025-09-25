Return-Path: <linux-acpi+bounces-17312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048DBA0A0F
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 18:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3761C23285
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C1306B20;
	Thu, 25 Sep 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aeFhg905"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C9286D60;
	Thu, 25 Sep 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818156; cv=fail; b=myU13xUbSX+e1u3c2vl+PFCcjw27qNQ0VP0CSWgsW3nMSksITLp4zzlTDR04M6GHQE6oMwtrGUT5vHQO169D+n5iFucbHuBqTQ9jRfDZkfZ6OFeAdWsm7Nk8rQBnUVooTIuJT4omEFDMftBznu2Y6n4BpG/smBLpPn4FpC/ONJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818156; c=relaxed/simple;
	bh=/ETwNW1R9DhMkj04XJnEtfmGIGWE2rSxd0aX4pPhyCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QpDxi0W4ORZv7oXHz8seXSwwEakimfx260ukS4cA3qqzmqb0bHM69ftZGk0iEWIVeRtb7fqz/VDq66UxGSsaIy2eZ5eRKhjpwtwj+PyFRbuIZ0Jr7BDIzc7xQX0Pg2tfivGa+9PiEZFYZgR3s8oC/oT6r3NxzhgHaXMKfmQ3HQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aeFhg905; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwNvE/9Bo6/Smvy01F1sOFGO+cOr00YMsKuooA4o7Nz3oCYxheV2+ghpgBC7rAdjEthgvfBNBuZSwCiX0kHNeN6DuwUN5c5wqrs/7dBFcu0YaPyDGrHPLWdbwlkd87xr42BWjBIO1z0x6GVC+qunEfV7A3w6rOCndzfXw4M9VZREVY3HjKoxdQ+1irxDFyCwVB9NBajrsguMtBOwCRbDyBpOc1S3k0ImF+F4+3AL+P3aWIX+UfD2aKaAdFWFK6kRT4u55LokVse2R2Q/dMka8Wnzfy1RKno59xYPw9/PucuTmjLfVvfBhUthf2OUGR1gal7ulZay84ql7R7sHlPQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guKWXxiwhCQ5JrWZ6yTXqX0t9/cUPomGEyioajDmxcE=;
 b=Z557JTwR36xp1+2NwOoH8pP3eOtf5CXjMiQDCx7yG1qmB9gWHhi2o2paOwVt2lGjoFuHn9JuhYdeJEBEIB9l/47XxlQyTHj8F6qqh7odoALblbhaZdraVTIHmnK/z6HqXm5uQhhnzAgVIir7138QDFgUCYGqII/c2aLa3JyJE9StzYVbGJ8Z7fqw132oMbnI9xs7xQ8mBiy7vZ29Gn6RJCv5GZB8y+CFAJPqIjH9pds3JhK4UuaSdYYIkBNGaR5A1l4T6BwSQwKaTtj40iFLjIO8SXhT7zQlDmsUN2cvdRYTtDkv5QT6GxS+d2GVDhXL6CphIZwJ4+SQ2vgUNiVQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guKWXxiwhCQ5JrWZ6yTXqX0t9/cUPomGEyioajDmxcE=;
 b=aeFhg905fEsXxXF0v0343e8U4cMcxESumSOb6elqF3IZK/MpG9zW8a8LuBxwMM7XNbhXUNO1kL8j8/3IEhdRdzk8CI61JVGp+xIenOEm3oIjPRhL7VbxWYwVHkPDo+cWjYOIUAKvpLevEoMlK7o/CPDCYJSMU4FVIxOnfWabxNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 16:35:51 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:35:49 +0000
Message-ID: <99b90797-50ef-46e9-87a8-5a02b24d4aa6@amd.com>
Date: Thu, 25 Sep 2025 11:35:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ACPI: CPPC: Replace CPUFREQ_ETERNAL with
 CPPC-specific symbol
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <3925838.kQq0lBPeGt@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3925838.kQq0lBPeGt@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:806:24::11) To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff40699-a957-4973-9c76-08ddfc519623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHVIZUtRbDNnUzZsdG1GU2VzaHNHSHk1V2pva0UycGNjYTRsSHFnUERCNDRP?=
 =?utf-8?B?NTlNS0drWUYzZnM0WCt6WTc1cGd1NnMxb0NmT0VVVEtNSTBHc3ZqUmVJTFVC?=
 =?utf-8?B?b0hoKzVUd0YzbVIrUkszc1U3U2IxTGZud1poTUxkSEZJVmkzSnhKcVBXY1Nq?=
 =?utf-8?B?ZDcxcGNFVm42YW1ici9JQzJjRU1SL2J4ZzltdXBJQnJXbTM3M01RNjdTb1g3?=
 =?utf-8?B?Z0MxZ2l6cW9DbEpKN3MxNGU3dVlpc2thaEZwVHlRWndpQ29hRnhmNjNnSi9z?=
 =?utf-8?B?TnFQMjBidkZFL1NMK0ZRQUR3NG9iMnlZT2IyL3hndjhHZ01zV3crdE8xV1VI?=
 =?utf-8?B?eWdqWE4yWWRhem5lNW45MjJodlpFSVRDMEhHU0h4L0lqTXgwSHFaUlBmZEpJ?=
 =?utf-8?B?b1RBbVlrZ3plRUtsbmtwcGVkejc2cDJ4a3ovZmRRVGlHb0tkMHlQeEpPM0Na?=
 =?utf-8?B?YTBtYkVtVjQxZlQwZ1o2UHBxaTFIWStmUnN3Vm9PSGFrZmNZWDIrTTVhY0E1?=
 =?utf-8?B?MmN4c3J5TlNMSTA1NVRZYXFiQlZqODNsZ2RNbHpIMnY2cHZla09sVW5NWm56?=
 =?utf-8?B?UTN5R3FXZjhyZEhYdlR6akpWbGRLcUhQNjAwTVQzU1hwUWlEaFpGN0NLdEVs?=
 =?utf-8?B?Y2tpRlQxOFVDcUtBQ25jWHFZVUUxUXZXQnpzL2ZvR280SVR1TXl1ZTA1YXJ2?=
 =?utf-8?B?QUF0dHBIQ0ozUmlDTTBpUVJmb00wajM2aXFQY0RXQXVIbTBGckNuWUhuL05Z?=
 =?utf-8?B?YWNxeWMxSUJ2R1Z6TEMvVXBGTDNGZHdPbjNaenpycmYreWhlQzFWeXZLSTl4?=
 =?utf-8?B?a2RNVlMwSFNRZnV1U3RNdDF0TnBqQUtneTMzOXhWbnZVN3g5T1dsOUszVlR4?=
 =?utf-8?B?NGRjTllaMXFTenR1eGI0dFVqMjZQaGVPR1NERVp6TE9XTUVUM0JOY2hjL2Fy?=
 =?utf-8?B?b3FkS2hhdXdxQ1ZnQVppeE5pT3B3THVZelRValJ3OTQwV0E2TkxCdXcrVDRD?=
 =?utf-8?B?bEpISUhCdGVGMVJWSXZNVlp2L3JPek1aZVJ6NTlTZWo4ZlZ1WkNIdUpKTW1T?=
 =?utf-8?B?ZTB4a2o5cFpCZmdiSGUyRGhGTXZ5UVVQemVpSGZubDQ3NlRHNDdIOTNTTnp6?=
 =?utf-8?B?SGt2cFNMWmROeGZaazZiNU54bWE4NUtZSTUrYzFnRUNZK1NlY29BYUtUWWVv?=
 =?utf-8?B?ZmdMMEJaOW02cEdoMU94eUt4ZlpSN3JKbW9SYkN6dFpVaHZHV0hhbG9JbjQw?=
 =?utf-8?B?TG5KOFZveDNoRXo3MlkvVURHME0zSXZsZkZYNmluVjI1TUhQOG9KTEtzU0N6?=
 =?utf-8?B?RWhqcHN2c3FBcmpKc0RXQ1R5WERCV0JSakJyeXhQNjNWWUZYMFUramw5enVO?=
 =?utf-8?B?UEE2Sys4SzhMSjN5dHh4ZEJQVmg5UkZldmYza2xMTnk2ZG5laSthdm4xQTgw?=
 =?utf-8?B?akNsdWhaeDdCdGRnRVJvaUZ4SnJEMFVMVjQrcDZGWkR4eTJqZE9jZHZudm1p?=
 =?utf-8?B?cnlsZTNDRExBTmRqdkg1VUhvYlBHUFQyNW1URHplYjJiZStmemV3Z0pNak5I?=
 =?utf-8?B?azl2anZpUFh5ZEd1TXBsVjFuSWlKS1BDVC9FdlRkQUZBbzlTc2ZldVJUZHA3?=
 =?utf-8?B?VVF1ODByaGF2Zm1TTk9zMG5ZWk51UkRZN1lQVUhsbnRxM2VuYms3N3k3QzhV?=
 =?utf-8?B?Q3BZVEhaRUhuMDczSDZTNEh2MDF3eUJnT2RkLzFtYXhDc2k3aXpTN0FnNU1i?=
 =?utf-8?B?TGtRbnNvYWwvVkN0WHpWanRhTnE4a1Vacm1NeHlZcWVyTEQzODNqT2h1N2Qv?=
 =?utf-8?B?dWltakFJSzJCN2F0eHNpenJUR1dsYm0xRTV0R0k1STAwczExbHlOOFNKTGJz?=
 =?utf-8?B?Ukh5bGFYQ2NsUVd0cFp2bWJOV0o2VjJCdEVxSWdCUUpacGVZZ3RrNmF1aDhq?=
 =?utf-8?Q?1DE74X3vOGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0010.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzZ3Mnl1NSszNVg2ZW4yQzZxa0lLVW1zd25saWVDajVVQlYrcWpwamJ3VENC?=
 =?utf-8?B?eXo3eVdLd0tDcDJwNk0wOXZZZkJFSEs5ZkFQOG4wbnhIdkw5d2ljTW16czlZ?=
 =?utf-8?B?UzdsT0tlMFFBUFhibHVseStyVU1HNlVoNlpiZGNtM0lvRkYvSVZxU2FCdGlx?=
 =?utf-8?B?VkR1bHJPamhIR3BlcENGbnVhdTIyRmZDYjdVdDArV2tMVGtxdE9idTRmVktM?=
 =?utf-8?B?aEtVMjRwMzZWK2VxSEptUXlkUzlBVHlaNTRGUDVkVFlTQTJHSllRU0JiUUUz?=
 =?utf-8?B?Z1hnNllrYmFwcDhPWE9FRTlOZWdjdE5oMmx4M3U4QlF6VktWWFpMRDVubWx5?=
 =?utf-8?B?OGQ1c01jbEhrTjlHSXZTZk16Sm9ZR3p5L3FlQ1dhVDFpbGF6S0htWTNWWUVO?=
 =?utf-8?B?MXBHYVhlQmhhZ3YvQlRXSUUxOWxvc2RpcHUza1VzVjEyVlYwb2xRRFZuVjFS?=
 =?utf-8?B?YjEyZFhzOW9Ib0FJbUl6U1Nnd1VaMkFtK3dmVGJFOTJBNDYzUUdWVGwxaVlt?=
 =?utf-8?B?VlJDcG4vWmNjY1hGR3lVRWRmSzNnSGRtV2RnOXJ0QmNlOHNQNG5NTWVUTHJr?=
 =?utf-8?B?eG41SkRreVlzRDltY3VKUjdSMWFVdFFFUXJFM1lURmJqOEVpR1BrcXhDclFq?=
 =?utf-8?B?ZnhKSGxOdlRhUkM2NlBmb1pxeFdqYjIrWnBOTDE0SXNlajd3VnpoL2xGMWR2?=
 =?utf-8?B?dDhpRGZQbU1sNkRya0szOU9qREU0QWFRTzc3T2VxOEN4ZHRNNXJnaWt0aktn?=
 =?utf-8?B?TUNoM2xjOGV5YklQWjZTUFB1MXM3aEdTQVkzY2V4N0tEczlYb2xrMk84eUFo?=
 =?utf-8?B?RXczejFubDVCbFRHc0tZTEU4TEpMOThQUTJsQmh5c3dpOEg5N25BVTFMaW9x?=
 =?utf-8?B?TTRydlJSS3JlUGliSWV1TDQ2ZFBRak1PUTBCYUZWc21TQzhpSWlYZmFZd1kv?=
 =?utf-8?B?enZTcFFTNW5oUGU4ektPMnBXY29XWlFNUGtJeFZTRUpneXRlejBDMEd1cERr?=
 =?utf-8?B?RTRIejN6WS9VeHZzL1IyOWFId05MeDRHcFhieFlXZ09BVi92WTBTMVYvVWNm?=
 =?utf-8?B?Vko3QkFQTUdwWUd0eWV4S0ZCS0xVdkl1akJ0N1dBN1FiajZmczdWYXhscDhH?=
 =?utf-8?B?ZVphRmxHcmEyUjEyWnJqQTNaWlJUNUdzSVQ5QUJFWDcreUNvT2NoR21rOWpO?=
 =?utf-8?B?ZWpIWVJZYVFVaitQSXlKZ2t1TEkvZFgvemEzTWlibUlEZWQvTFdqeVYwaHpr?=
 =?utf-8?B?WVBKT2R4SVFLdjBqNFRjS3haTUFGMkl5OURqUGxLYVo0UzhEdGVOaFlZaFBD?=
 =?utf-8?B?bEZkSDhla3piRHN1RCtkbndCVm4xS1RaQ3YzZjh4bnVadVlFQmV4MHFZcXlr?=
 =?utf-8?B?Y016aUlZdWxpQ05kcHd4R1IwSkw3OFQ0S05Tem94dVQvYnZJL3dPOWxZL3B5?=
 =?utf-8?B?N2ZIZ08ybnlzUmdJL3poV01ibElPaWszaUhVT21uSlpUTTlZYW0zZlpqUnFl?=
 =?utf-8?B?V2ZnU0JjdS81SS9ZRGk3bWhneXFCS2IzTjEzVnJvY0RvNXprMGxhSHdJM3or?=
 =?utf-8?B?bHF3UW9BOWwyMjU4ZjdRSzdTZFN5T0lSL2wyUS9BK09ORUIyd09vK3RQOFpu?=
 =?utf-8?B?dld3akFNeEVnVTA0S1UyVlVIUzk5WTBWb3lGeEh4OWxPNnEyQ0hPUzJsZXZr?=
 =?utf-8?B?V0VDNHpqcEl6S3gxL0hQSm9mYzg0aTFwK0VITDdTUmU3a0Y3dkwyQTBTYkIx?=
 =?utf-8?B?ZDI5NGkwVVVUUkFMcWtvSWtBTW03Y1lkSTM5OHV5UVJLeEpZUmdXU1ZVWE1B?=
 =?utf-8?B?SjBtdmx2Smo0QXg3amYza2ZSMzNIaTIreVdkNTVUUkxUT0ZFNkZJUTVrY2Ro?=
 =?utf-8?B?WExzMnYzNVBhZXhGN2dLZjZDc1VWVHppeWhidi96MXhhR1N0djlWSGdIK1Q1?=
 =?utf-8?B?NTZ2clZuV3hMcisrWDBXOG5aWHYxem5NYVhMT3FvWUt5Z2RMQ29INU8rVnlM?=
 =?utf-8?B?NFkzREFJRlJLM0pGbHpzeFJqVHBoQkhjcEs2aHlwUlFETXdza0J4aEQvVGxF?=
 =?utf-8?B?UnpSVVlwZTNkVUpNUkkrL3VsTmQwc01PRXR6aDEzQmlKVkRlN3AxVGxCSHNp?=
 =?utf-8?Q?ncqqJuUfOqAzvYkJQUPBl4iXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff40699-a957-4973-9c76-08ddfc519623
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:35:49.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DrHVf5I1EHtlDffJ3xgC/qc4Pq16YpVQvSYu8553ITgC72skLj9hM6pQ8VIk8rR5iN5uRtp/8icbRX7i8VLvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349



On 9/25/2025 10:46 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using CPUFREQ_ETERNAL for signaling error conditions in
> cppc_get_transition_latency(), introduce CPPC_NO_DATA specifically
> for this purpose and update all of the callers of this function to
> use it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/cppc_acpi.c       |    6 +++---
>   drivers/cpufreq/amd-pstate.c   |    4 ++--
>   drivers/cpufreq/cppc_cpufreq.c |    2 +-
>   include/acpi/cppc_acpi.h       |    4 +++-
>   include/linux/cpufreq.h        |    3 ---
>   5 files changed, 9 insertions(+), 10 deletions(-)
> 
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1897,16 +1897,16 @@ unsigned int cppc_get_transition_latency
>   
>   	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
>   	if (!cpc_desc)
> -		return CPUFREQ_ETERNAL;
> +		return CPPC_NO_DATA;
>   
>   	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>   	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
>   		return 0;
>   	else if (!CPC_IN_PCC(desired_reg))
> -		return CPUFREQ_ETERNAL;
> +		return CPPC_NO_DATA;
>   
>   	if (pcc_ss_id < 0)
> -		return CPUFREQ_ETERNAL;
> +		return CPPC_NO_DATA;
>   
>   	pcc_ss_data = pcc_data[pcc_ss_id];
>   	if (pcc_ss_data->pcc_mpar)
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -875,7 +875,7 @@ static u32 amd_pstate_get_transition_del
>   	u32 transition_delay_ns;
>   
>   	transition_delay_ns = cppc_get_transition_latency(cpu);
> -	if (transition_delay_ns == CPUFREQ_ETERNAL) {
> +	if (transition_delay_ns == CPPC_NO_DATA) {
>   		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
>   			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
>   		else
> @@ -894,7 +894,7 @@ static u32 amd_pstate_get_transition_lat
>   	u32 transition_latency;
>   
>   	transition_latency = cppc_get_transition_latency(cpu);
> -	if (transition_latency  == CPUFREQ_ETERNAL)
> +	if (transition_latency  == CPPC_NO_DATA)
>   		return AMD_PSTATE_TRANSITION_LATENCY;
>   
>   	return transition_latency;
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -312,7 +312,7 @@ static unsigned int get_transition_laten
>   {
>   	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
>   
> -	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +	if (transition_latency_ns == CPPC_NO_DATA)
>   		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
>   
>   	return transition_latency_ns / NSEC_PER_USEC;
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -41,6 +41,8 @@
>   
>   #define CPPC_ENERGY_PERF_MAX	(0xFF)
>   
> +#define CPPC_NO_DATA	(unsigned int)(-1)
> +

Would it be cleaner to just change all the functions that can return 
CPPC_NO_DATA to int instead of unsigned int and instead use -ENODATA?

>   /* Each register has the folowing format. */
>   struct cpc_reg {
>   	u8 descriptor;
> @@ -218,7 +220,7 @@ static inline bool cppc_allow_fast_switc
>   }
>   static inline unsigned int cppc_get_transition_latency(int cpu)
>   {
> -	return CPUFREQ_ETERNAL;
> +	return CPPC_NO_DATA;
>   }
>   static inline bool cpc_ffh_supported(void)
>   {
> 
> 
> 


