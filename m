Return-Path: <linux-acpi+bounces-12687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E227A7A545
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0C818833FE
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9C24EABE;
	Thu,  3 Apr 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AdqLcUOg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B324BBEF
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690805; cv=fail; b=AQtvp3671SjE1Z9dtNNLewX6j/ZTS8/wpja2gNh0D6142N5NK5eUmPyndjnaGCP5348r1BctkhmDnhAa0TUL9x6Qeuy6+slISD2+LLoezfXenEZMGpS6TLR2ceRSyTwnSe6f5uCaR3wT5t0X9oFo2FUHotutRWBJhR+k1CUx46w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690805; c=relaxed/simple;
	bh=nKzfgpKMaRBLHmj8mPtE9+3W2fPCehW71LtnR22nZfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUZGZZ07CHcNcndT68z8jeRAzFk7qkT+Akaqsycry0JSZNDE9ypDmbAuXlPg+ERc4j7ocq1i6sVN7a8oD8j3/IcudUbwsDKN/rieUH4kvfs5e7pj4PmLLJB+zF3e4UdaS+B240AhJyLI/9eIWag5BJqYH9vSNFYgeaxx3swuNX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AdqLcUOg; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKC5UeaXbyoN1vD2YtO9+HQ1u41KAX7UzeEBNylCUnWspfQKvqYSOfPfehhk4YkdYB0rPTbG1AHaMtaitbun1qyU3CUiZRJ5Ro4jzNgsAcNeKAgOlDdVjNMjMdYrA8z8EcHG+jJ8myR5fRw1MQvQa3BTkXw8EguMvAPSzc//pzguzKoPpvyX8MUHzJ1CQdTvxP7oPL3FS10gzRQKL1j3L/IsaSRvpeWLV/xmPxVrsK4t/CcjhpB4u++oeLZPx0o0XO3C1i1rgWc9mv4rpWvP1E0QdgjNL5t0zfQ6xQgdJ0AbVyUHGRDjgklAwTuohF7bguh0rM40/m33zb8A5CWvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkafsVjL0/KNL3UpuFLiqxSvcsWMqR106O8Y/aQop4Y=;
 b=d9xddJ60ilaHXc7Cyt7+eWDeEG2T1+j7uTpllD5hXUh/Q269S7tGnBJAhDVpz83M5Qljp5YCHtZ3DRAkzH2o9dzeF2bY+wzGySDgeKO7XWIyj+dShquCHY3LNyrXy4YMZr+I9GgD4/c429nmn6NpjO1Tp5K5PqAAgwkU+JEgUPoI67YOpsQT9xZ9pq6jo/RM1S92Dqy/szS5Cw/gVX3kUG2FWQoC0wh6+OvA77m8zSxnWedUIqZC+zWI41jJiemOiNVOTkW10rtEU3vVV1VBaV8M0XruAw76WrwhwyRBDpO56EPGfpB9mh+AI1LOmROFqN+GoYlLw36HPVHYNPXaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkafsVjL0/KNL3UpuFLiqxSvcsWMqR106O8Y/aQop4Y=;
 b=AdqLcUOgwPbXtRkwHoJF/HfCyySP+vPjBgjjX/6bbbbYWUfCSsyraEV8IftPstC9Wi/bFUNhU4ZXlGkfO2eRs9I+/iUI7vNbqDlTj1Oh9mzgjfwt7ERjsLWseyVun3wchLGltjTvjxQ/fPTcwuuCEsGWElgskLHdqd5DyrsbvNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Thu, 3 Apr
 2025 14:33:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 14:33:21 +0000
Message-ID: <c3bdb7a0-a604-4084-b302-3575af89641d@amd.com>
Date: Thu, 3 Apr 2025 09:33:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: kernel-6.15 randomly shutting down system on bogus power button
 events
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ian Laurie <nixuser@mail.com>,
 "Shen, Yijun" <Yijun.Shen@dell.com>
Cc: linux-acpi@vger.kernel.org
References: <548ec422-e504-4171-8780-cbd83f877b3e@mail.com>
 <CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b1496c-96b9-4c92-768e-08dd72bc7b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVJNL0hkLzUySDRaNnFSSXVvQm1rTkpqVmN6ZHNIYmh6WkNSbWVIQnVoejR5?=
 =?utf-8?B?cnR2NUlJenpRV0k5WWpEbmpTalFtWVNQL056YnZ5V0VhdjBVYUNheXJ5b1M4?=
 =?utf-8?B?dWJtOVUwbGIvWXc2ZzFoRlp3NGoyU202ekhnQitGTnpJVU1lZ05SSGE3Vnht?=
 =?utf-8?B?a0s2U0RGUVplbnpBZWFNSU1ZQzZmQzlYekpGVGR3bjExUlVwSWhKTlFFWHBI?=
 =?utf-8?B?UENzYUloRnBLUmxkSTBhN1d6TE1TaDZvaWpDTWhKODRRUkxhRDdMOWNSR0E0?=
 =?utf-8?B?U21ydHU2ZThIeW1kUkJyTE1ZV2tMUkEwdTRiWEo3K0tJanhXRGVXM05HY1Rs?=
 =?utf-8?B?dURlaDFWYXlJS1lzcUZjS2JvR1lWckZ0NWF0TjNhb0JURkF6MzFsUFhyUlda?=
 =?utf-8?B?WVgxRXRKdHVLTHNIZ1h6d2FRTDM0ckgxeGk4TEkvWU9TcWloU1dMa3RYM3cy?=
 =?utf-8?B?YUk5ZzJ3dEVSV0NTcTRyTEVmREhSYlBjMUp1Y3pvYTQxUmZKOEtsVEk2b0pI?=
 =?utf-8?B?V0VGM0ZxYXEzbUZuZWw0ZXRVNkIyN1FhWHpKRGQ4d1BKNUdxb3dIU3IrbVN5?=
 =?utf-8?B?ZHBQNDFJZjFiM09kV1luZHpiQ3dWV3dQelVqYmRRbzN5N3RGWlhVcVQvM292?=
 =?utf-8?B?VlMxc2hrY1p4TVptM2k0Nm9oeSs4NmVyNURzS3pOcVZNeGNoVHlVdjRtb2E2?=
 =?utf-8?B?TmlpbFdmMlM1RG55WGhLRHJLVnZDUnpFakpUZmpLd3cxVTNHc3l4d2llRGUy?=
 =?utf-8?B?L0szNkZTNS9iNnpJVEh3eGYzaEtEREw1a1J5WDlZaHZoRFo4YUxJNDdMMjNM?=
 =?utf-8?B?NGlqbzU1Z3ZPekZTV0M2eGZCZjVzbUx0RGRNKzh4N3VJT2MyaHN6V1NTa3l5?=
 =?utf-8?B?VjN1UmdIY040a0d2OWxEd2tiRlpQZHhmSVVKVysvV3RwbWNDRkpUbzRXMXk4?=
 =?utf-8?B?M3U1UWtOR01LdkYycVpYU2F4MmFoMmhtY0lGcUc5WHVoV3hLVlhSOGhyRmRH?=
 =?utf-8?B?MTF6SGYrdUxpNEd4K0djRXJaYkFzdVVKL21UN0M3TlFRNGhNVmgvOG0vUW5Q?=
 =?utf-8?B?VmtNRFMzWGdwQW1WWmwvSmVDb3BteVF3N3NIUk83bnY2RTkvQ2Qwa2ZEQWp4?=
 =?utf-8?B?dHBadDdFUXBSSnBFTVdNZjcxbFNXbjBUQWowbW1zOFFjdGR2VzhCK2ZZQlNk?=
 =?utf-8?B?UjlmelpTSUxEOGFaMlM1MkRtTUtpV1FidzRpeWZvcTBRa1o4azRRRDkzLzJP?=
 =?utf-8?B?WnVCR242R3ZzYXJ2Q254ZUg2bXlueWFKNjEvN3BCOE9sd2k4Z3B4bnFLVjZ5?=
 =?utf-8?B?aDB2L0lLK2VxSkxDVFZjL1crbEQ1SWlRU1RWcEFaelRQaWFnQ1FaNDllMytJ?=
 =?utf-8?B?QWhsaEJhOEhMakNESzcydTJLckpCN1pHeGJKLzdjcVMzN1JHa1lMc1hCWDgz?=
 =?utf-8?B?eFFEUXN6YUlaWHdWS1pOU0xLOGxab1VFZ1F5aXBBSG55V0NmbnBlMTNMY3Q2?=
 =?utf-8?B?WVZXcHZCdmtBUVF6YUFDYmE0VEZXZ0pTVkhNVEk5SzdCQ2pSck9aTForQjVV?=
 =?utf-8?B?ZjNDUXhzejIySDI0a21ncHJaMEVDQjZxUDRqc0hvNGhzeEkwN2syRUs0TUdC?=
 =?utf-8?B?TlNTMlRYUFZzeXRvVWQwejlyZGhVaTBqdm5qQzJ0eG56anA4YWNGWG55WVZL?=
 =?utf-8?B?L0hQb080U3doNXN0N0hkUUpKQzdwRVJpNUZwbzFTSGIvNTVSN2ZvWlZ6TkdU?=
 =?utf-8?B?cG54RW00OFpFZTF2Z0dkSjZtSHBZK2VJTCtadDZ5S2JjcFluZXVYNk9HQzFj?=
 =?utf-8?B?TXZwVDliSUJNTFN3WnlBY3VYeGUrOUJOcVpRdEx3eVRiNzRRNGdEUUtKM0hN?=
 =?utf-8?Q?M1dp3IM+XBpUw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bko3dEM4SENkSlJidFdJWUpRaVlEaDNicCtTQ3lvc2RDTUlXL3J5Yjhwb1I0?=
 =?utf-8?B?anhjbzRpa040T1lEU0hKZHpzR3YzU21Ib2F3RHE1VUh6NlpBY3BXdXptRThj?=
 =?utf-8?B?UGs1UEtyUDNiNzNaemlTa2VYNlBWSnRnOFhXTCtnWWdReEw2dmRLc010Qm1E?=
 =?utf-8?B?UDZxR0hOSTl6WnN2clVGUGpQaDBsb3NLanlTL2h4NkNKQW9VVzJWajdnR0RZ?=
 =?utf-8?B?cUpQcVl3NVFWL29EdzNvQjJxMFFQaXFnVWFwQnZMcEh1Tzh0d0hqRXZ1ZFo4?=
 =?utf-8?B?SHhtb1F2RGZ1UXYwemU1cUxOM0w5cUx6Y3ZnNVZWMFg5R3MyT2hhbVRvckRl?=
 =?utf-8?B?TlZLeEs0VlpQQWpzRFFtUU5hSnpBNTZ1aUFiMWZSRVhtcXZyY0x6MjBIaG95?=
 =?utf-8?B?R0g2dnBWL0NPcysxR3FqWk94cTN1eWkzT1dzdW9hUGNFK3RmamY5ckNyYkQ1?=
 =?utf-8?B?Z0xrQUZCUkJaMGExdVFSaWN0RXVLR3NQMVhHaHlGVy9LSC9NOHBhaHh6WUcv?=
 =?utf-8?B?OTFPMG1ZSTJVK3BCbVJsMW5URTR3VzBJeDRJU2JJUis1UHBDeEdxdHZmaXJQ?=
 =?utf-8?B?OHEyeUo0RFIyU0tmK3ZMNW8yQ3JFZEpzODZTd0FFa2ZreUhnanpZZ3FQV1JM?=
 =?utf-8?B?czFJSmNmNnE0dm8vMFAzeDhHOThmQ3VyUENLS3Rmd3hEMUpCbUhxcEdqaWNP?=
 =?utf-8?B?LzNUQzZoZHJQeHZlMkZFdHNZWW1hMTIzYURiTHI5OWJLeWU0cWtqODlyTFBu?=
 =?utf-8?B?aWdOQk5lb2k2Vmt2MS9NV3d5c01Uckw2UVh1c1FMcUlrZ3AyZUdQcXVlcmpq?=
 =?utf-8?B?NU5VL3o5eWdZT2F4cTZHMXZRVURTNDQ0a1UrbkZVNzZBbzFuS1lEVHRKM1Fh?=
 =?utf-8?B?WGVETEVlRVR4NWtXeFlqSG44RzhSVFNIZjVJbVF2dHJxR0hiZ1FKSG96Z1FZ?=
 =?utf-8?B?VUtwOTY4b0pRQ2JFeDBlVnFMa0tvNGE0Z3YyRURNU0cyZTk4bDRoYkkxVklJ?=
 =?utf-8?B?UitXem13NFI1ak5yNGhXOFUzUCttTk05WW1wNHhQdnl3bHN2V2xSdW1NV0xa?=
 =?utf-8?B?QThqeVhNSTl3SG1pazY1UmdxWUkyY21DVXJOYklEcUxJSVhWeXd0bkFEVHQ3?=
 =?utf-8?B?Y3lKaTBRVnY3ZjFmR3F5ZWR1UlpaZFYxdDhYU1Q4dWI5WGlXZ2RSL1lvU3I5?=
 =?utf-8?B?NWtqc2YrR0ttRUs0YS9iMjlpQkhzbGxLRHpQajc5NlVjNlRqK3ZYa0ZIeUto?=
 =?utf-8?B?TkxEdll5eEg3MHlJalZONGI1Vnl1Y1gxM2E2NURuYnByZ2hmaVJMSTBjV3dh?=
 =?utf-8?B?VlY3Z1l4a0owMytrd3ZLM3Y5Rk1pL0gzNWZITjNMWVJkejNIbUxZTzlsdDVB?=
 =?utf-8?B?dVdmLzBEZUwvTjQ5ak1NSjBMVTNCaFRKQlYwU3IrcXdldjJVcFBUVVFsNUZK?=
 =?utf-8?B?ZUVzQ0tVVVM0eEMydk4xdEhiMGRWZVA1QVpPeTJNbitsYkJpOUE5dU1uZzgr?=
 =?utf-8?B?cVREQXVqd3hMQ3ZteUNaelVrNUNKSGRRMlVjRnJNRjJKRXgxaTIyaDhRVWdz?=
 =?utf-8?B?MkU1Rm1PTUgxWC9jWXhFcVhzNkhhZ3MwbWlmK0UxTjlzQjdTYmJVWkpFZG05?=
 =?utf-8?B?OUF5dHVVNUFwU2VJdVJMazFwNThkTXZjWVRyOFZRV2NUM05pdC9KaTNiOUFK?=
 =?utf-8?B?SjR4ajFaWFNlUU9XUlRLTk8xVlBpWjhyd2hWcDlTR2VzbUJXa2Raa2hFMndi?=
 =?utf-8?B?eDI1NGtGWnJxcmxEMHBtNm90SjJRMFF5ZTNqb1Z2TzVKN2JBZVV6a3o0U3dP?=
 =?utf-8?B?MVpTeUZvZnFuNkpCV043L2c1RmxReTBQRHdFYlFlNGZvNHBNQjNPN2NlUjdx?=
 =?utf-8?B?KzJFMEVBaUIwcDhOa3R0VDM2L2dpMW1GTEFhTTkvbzlvSjBkNjJkZ3JGNVA2?=
 =?utf-8?B?TE12eXFsRE1OWG5RaVhsV2NMejNLNERqN1ltVFFyWEZMenVxbEtOeFNzUEsy?=
 =?utf-8?B?ZVlQWU03RHF4S0QzM3laMmJURHBqMlV4cnhqbjNMTHAzKzhTVFJ4YVU4bko2?=
 =?utf-8?B?Z2ZnY0VFRmxYWDNEZWsrb3llVUJNeElkd1FZWTFUaGVFRzFWZGdmbUUzbEVZ?=
 =?utf-8?Q?VHfkOa5CBASbttTRsuw2Jfg8V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b1496c-96b9-4c92-768e-08dd72bc7b8e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 14:33:21.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWRWODMmf50Cr1hz8Dc3EUWbRNwQiubbOBn7xxip2TSI0apVgBYG2ERLNUR0RuxGExr0RidYcRVBJXKqvlnkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

+ Yijun (awareness)

On 4/3/2025 5:48 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 3, 2025 at 1:30 AM Ian Laurie <nixuser@mail.com> wrote:
>>
>> I am seeing an issue where (in Fedora Rawhide) the following kernels:
>>
>> kernel-6.15.0-0.rc0.20250327git1a9239bb4253.5.fc43.x86_64
>> kernel-6.15.0-0.rc0.20250401git08733088b566.8.fc43.x86_64
>>
>> are randomly shutting the system down because bogus power button events
>> are being received every 10 minutes to about 2 hours.  My actual power
>> button generates an event2, while the bogus events are arriving as event1.
>>
>> Latest available 6.14 kernel:
>>
>> kernel-6.14.0-0.rc7.20250321gitb3ee1e460951.60.fc43.x86_64
>>
>> does not suffer from this issue.
>>
>> Using 'sudo evtest --grab /dev/input/event1' I am able to prevent the
>> system from shutting down and also record the bogus events.
>>
>> The RedHat Bugzilla entry has more details and also links to a thread on
>> the Fedora test mailing list:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2357044
> 
> I would try to revert the following commit and see if that helps:
> 
> commit a7e23ec17feecc7bac0d500cea900cace7b50129
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Mon Mar 3 15:27:09 2025 -0600
> 
>     ACPI: button: Install notifier for system events as well
> 
>     On some systems when the system is put to sleep pressing the ACPI power
>     button will cause the EC SCI to try to wake the system by a Notify(DEV, 0x2)
>     with an intention to wake the system up from suspend.
> 
>     This behavior matches the ACPI specification in ACPI 6.4 section
>     4.8.3.1.1.2 which describes that the AML handler would generate a Notify()
>     with a code of 0x2 to indicate it was responsible for waking the system.
> 
>     This currently doesn't work because acpi_button_add() only configured
>     `ACPI_DEVICE_NOTIFY` which means that device handler notifications
>     0x80 through 0xFF are handled.
> 
>     To fix the wakeups on such systems, adjust the ACPI button handler to
>     use `ACPI_ALL_NOTIFY` which will handle all events 0x00 through 0x7F.

Yeah I think that's a very likely candidate from what you describe.

I'd like to understand how this is actually happening to decide what we 
should do about it.  I'll subscribe to the bug report and we can go back 
and forth there.

1) Could you please add an acpidump into the bug report?
2) Can you please use acpica tracing to determine what is happening when 
this notify event comes in?  The basic way to do it:

echo 0x00000004 | sudo tee /sys/module/acpi/parameters/trace_debug_layer
echo 0x00000004 | sudo tee /sys/module/acpi/parameters/trace_debug_level
echo enable | sudo tee /sys/module/acpi/parameters/trace_state

This should then save to the journal the associated event info.

