Return-Path: <linux-acpi+bounces-8904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B679AB24E
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A191F21D8B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221D1A070D;
	Tue, 22 Oct 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HB2PageK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73D19D087;
	Tue, 22 Oct 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611682; cv=fail; b=UXWIw4KUf/WVv0BE2SCYhLYW755wUSwjMrIN3iByfu1zA9O9vf/F6JrtSIDo4rBOoiMd9BWveenMSS7AYJdKsePDfbEY2f2Jn4Zv063h2LL1z8DEwOwI8CLm5giUmsBTV+5iS4TI0lTcnqKMxVCOACvvgVvzCRtXLqBNCZ/4ZxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611682; c=relaxed/simple;
	bh=bo627k2HSgiy8+uP2MJ5eckn+lkDUIE5tkz+4YLh7EQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k4NbnX4Kv2ywtha99yTTp2Y76V7rDGtgUxZfIJuBZIi1IsRrkc9EuWpAg5YgMh5/As7LldD7L7B/ciILEhlrzi3DohUHITONj2vLDkEFrCjAHAZj8KSE9+0ZiVmrLQgJGzijNNzzw6CyK81UkUkOzpbyOPxK3pHAVxOg8mbqQRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HB2PageK; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9/vH1jRPHrAcY1eTxzlFbtNuABqGB1062B9gVNcCv1S1Jw7sZC2McveBcimiSBQzn444jj4GbPEMKf/VnxK6HbwLYmg6QeJjqJ9aL9yI7OtHZa/GvuBdKNNauK4chcrcsNi6qPCVpDf5mAlay01E/IGFCbADWowp539a3BAlbOpim67uCLf5Hz4Bxc0Sn37t74n388f1EqGui8LAVduDzLxRtfDmhYnl61C5470lDz0AOJxN73BnGg1Gck5dl84pIuo04sSzz2GFdJjgSDvBm7toxRdOiOU2qn/f0JLWDMLHFDW6R0gaHEWZqcLDkfNbIlHfNW46630El8KuIhDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUIBoin29s9BV4SZIKB48PLcjw0TzkNjUrRMuU5tN5k=;
 b=sZUidZW9BK915oVh1vzdaeuDZ1cxIM/Uj99VOKmzw2zJJGxEVrTRYdPHR301PnRYvUES44jjUF3FbxkUEUf1tIWXNtezXKMhF1/9sdbiZvUP0W7qsZyjpWs9c5DjyVzFRf89UXU/IyiIT1qz0toJamxPSVrAJO3+u4MYBnKlCAKwv0VOdbAu04cXCshFaw6C7Pa/YR/ZqS2vaEMxWmBpwUfPfcRrKJ+18Hux8imEoyKGCzxonVW3PBl5NZ+cplh1+0ga7CovOppmPNCajVLkFfH2XEW2ysPIKQznTBnZR7yqISQO4k7g6Q0xhkhbvvAmhf4CGdEI27OnhtAPrc56Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUIBoin29s9BV4SZIKB48PLcjw0TzkNjUrRMuU5tN5k=;
 b=HB2PageKgT4dQxpbnpMxCqL0qeSNF3YSA+sNeCTLmjx4zDfCLRuCIj9VSQDY7y0uREdCebwDdhuCUruHSBd1H3I/eK4EjoRJ+RjkhLmjrM1X11abkgzWFWqO6F/PBBf4FtqEJIPog9VMO9/Lld6XAAuoqagS0GA0xqTLm2maRwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:41:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:41:16 +0000
Message-ID: <29c7b5b9-3a27-4b3c-85af-e08287944a00@amd.com>
Date: Tue, 22 Oct 2024 10:41:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
 <20241022120336.GCZxeUmHL5p6chpt0m@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241022120336.GCZxeUmHL5p6chpt0m@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 329f5d02-d3da-4185-8b16-08dcf2aff71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?citkMmZpbWo0K2RNS0ZLbGFldWtaeU1NSWpGYmQwcWV1NlBDT3kxVExEQzQ0?=
 =?utf-8?B?OCtxQ3h6UFFEU2svTDVReHZNZEpQUjRXZWZCUUhTMyt4VmdjbjUveEFKQ01N?=
 =?utf-8?B?dm9DTitpbGJzVjJUOTB6UlcyMDJuTG5lN0hXRDBiY0w1SHBsL3hzS0pHY3lj?=
 =?utf-8?B?Ymt1ZmFJdXB4eVNObVlEWnI5TWNqc08wRTBzOG94MU5jeFBXVzA4UmsvNGZZ?=
 =?utf-8?B?UjU5V0JzYnNSMFd6L09keEJXKzRhWm9KdVpQa2I3eWZ6VXdGSlcvVm9EY0dN?=
 =?utf-8?B?M3R6ZmppZ1NwWkhZTHBGcm5Nczh6OHl1dkI0RkpwQTBYa0lRNFQxK08rcklG?=
 =?utf-8?B?aHZUS2MxMkVpU1JYYUN6VEMzRHBDUThhckFDQ1AvdEVxc0NwSkxTWW9uVUE3?=
 =?utf-8?B?WHk2ZzhNcFRVeUU3VUxHWnNNb2tTUEZWdXJrT2JHRUExcnZuVlU4U1Zab1pT?=
 =?utf-8?B?c3hnWEdkTG9Pa1pjSWVnT3dkbnNkMUdKWEZXcVhKeGZ1aUp6b1QrWEdJVm5u?=
 =?utf-8?B?dlBaSWEvOFZQcWlkTXBRNkJCVU9UZWFTTjhtZ1NraDA1SXh6Yzl6VlJIVlVv?=
 =?utf-8?B?cDV3Q0t0WE9jVlFzdUVkT09vSTBCdXdwQitVMUJ4SGRHcEswSnRRTUV4NGJC?=
 =?utf-8?B?WXFzMEtEdTFWTC83WGMyK2hrcGtQNFE5Y2EzYm54V0JpV1pDbWErWHMvdlVP?=
 =?utf-8?B?N0ZPOVFha3hZSWZjbStSekhKWm9WK0ViSmxVK1NsUEsyZEVpUXBGYXE2SnFy?=
 =?utf-8?B?S1ZNbTRlQU9tTldZcGFobzZwdzN1c3IwTWZ2b09qdTg1UDJyNlY5dStmaFlF?=
 =?utf-8?B?NzVpQnJxQnMxakNmRzJiRlJQYlBpUnF4RUp1SjdyODI3emxBbDJIbzZERURW?=
 =?utf-8?B?b3FlWjFab05oWWxFZUJ1YnJVOExzcmtqTzdEVk5hN3pRY1hsRTRGcldLc1k1?=
 =?utf-8?B?NEMzSTNBTDNhSENEb21hVVFaZzhmKzFtMExGWG5tTFV3ZW5ER0xjYmd0OTFQ?=
 =?utf-8?B?ejhaMFZFOUxZaGIwb2lWOTYzSStJMFBKK3B5N3RmMnpDZlJ1NjYvRk54dG9Z?=
 =?utf-8?B?MVhSWUp0djNJelllOGpDdDFqV1AzNTlSby9IVzkxdnBSR1NFclpDazlTeWM4?=
 =?utf-8?B?YjdxVlNwM2lKbWQ2WlFXZDlKS0NmTDA1amNJSkpscDJ1a1EydlVUcFNXV1kx?=
 =?utf-8?B?WjA1QUFYeGJQWFNDR2c4TDVlK1VuL3NUNzdHd1VMN1RDc3dtNUpmZFBSblpP?=
 =?utf-8?B?UHd4YUR6NTBhWmVVcHVYY2ptc1U4b3NqWDRQVEFHRWdjdU4vRGluL0MwODA5?=
 =?utf-8?B?b1hOTlljMjRxTUJ0TUpLU3ZzbWlxUzBwUEhEMUlRRXNxQUdlcGhPODdURzV5?=
 =?utf-8?B?b1RBR3daYkNNQzJNZ1g0aFNUQ1ZkOHU2a29sYjdHUHJlNnNNSk1kMTdlUSsv?=
 =?utf-8?B?bTJCbjU2NXVOZDdMVHZiZm9lZWNVSk9hMkxheURiTUNGM3RBSStSamFGd24z?=
 =?utf-8?B?aXFyc0szTnQ2QzNUWnd0Q25WbUhmQ1FKMHJqVXRiOU1xTm56WXliVnF4V0Fu?=
 =?utf-8?B?b0lXL2UxN0QwR2xZdW5VNjRMMXhzRmJEQk5HcUtsbWpUbWU4Y0JLR3kxbzQ4?=
 =?utf-8?B?UkM1b3BiTUxsZ3JtcXF5VHREaHdKWCs0Uzd2RTI4dFZJdGo2QXFlTS94emJh?=
 =?utf-8?B?U3lWemtyck15V29aOVdLSHdvcHk3QVBsUVpqenF1K3ZkODM4Y2hYcnFLZEVT?=
 =?utf-8?Q?RMhdzvjpXRvZ41pR0bKUz4yWE7Ikk3NMiqUi8jL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjU3UVZBMUdKa1g5Um9EbCtLRDFZK05yYWlzSGhZT3ZxU1prRVgzdWM5YzNm?=
 =?utf-8?B?Z01sNWNGMjUxV2hUdGgxajVUaWo5VXlSSTFlbTNKajIwcVlLcUhiSkNGWmR5?=
 =?utf-8?B?VUNBVTg2NUFyKzBNd3huTFh6cVBTWkd1Zk1WSUM3NHJlaGRXb01VVkh2L25z?=
 =?utf-8?B?T2Q3bHN5dmJtTXMrRy8rZTc4YlZUQTVVQm8wSmxyeTE1dGMzMHg5cDl3SkVq?=
 =?utf-8?B?K09XK3crYWt4NjBxdy9VYzVINUgrVWhIcldiQjR4WjVwMXlQbWJwNUNlRDdW?=
 =?utf-8?B?NENKL3c0MjBITnp5L1pLc3FNMUUxWDVVaC9sendJaUNGQWxGSzdrL1JRbFFC?=
 =?utf-8?B?RENjREVYNXVsVHVDa2dBT0szOHZLMEdQYU52aVNtcEFEWVBldS9wTUVvSGM0?=
 =?utf-8?B?c2xqMndLSVNmbUFucTZpSlRLdy9STzIwMjdRZHZjU3JjRTlUYi9sdGxRMHdz?=
 =?utf-8?B?cDVRak5aQTdjYTdUVm8vYWFkZVZKWFQ1c3JIc3FiUVB2WEdubFNsQTdFcjlu?=
 =?utf-8?B?anNBaTNQbEcwaHZab2w1aXpTcWhwYVFhY0NWL0gzU0grWVArNDZvK1FITUx1?=
 =?utf-8?B?QjYzQTNGcG5jamxTYmFtcHdCcnNTNUp0b0lpRTBLclpLdmJPMWRwSVU4enZU?=
 =?utf-8?B?eWxoL2NHUU54Q3NEbDhObjcyNXVJTzRQQ2svMXBzT0YxMGVlNWJLNUxlc1Zu?=
 =?utf-8?B?Ty9zWTVFUXkxNlJSTXJtRWprbU40VGZhTnY4VXhYRDJuVTdaT0N3V0ozTE1R?=
 =?utf-8?B?d1g1NFF6VnVZSkEyeHBRTmpUM0FmMTlZNFdnVSt1OFVqQm5sTFZGZEJYeE1C?=
 =?utf-8?B?UHRHVlhHeUxhU3ZVQTQ3aTljSUwySDA5OTBEeUc5ZWwrS3Z2Q200ZlVna29x?=
 =?utf-8?B?MTYrTndsQU1mbkRqQUtpWGpuRHhFaWh1d0pBSTB3bzVIa0FKU05hQkg1SFNj?=
 =?utf-8?B?Zi9tdHFkSWNEeEZZSjJxSjBBK1ZmUmR2WTF2OTk4cENyS2Y2d25TakMxaC9Q?=
 =?utf-8?B?K2VibzQrMEpQY1lSMUM1Z2JnZFVDcUlQbnU2NlBzT05jem8zelJ0emVuRi9H?=
 =?utf-8?B?ZkgweUFOUWFXS1BUL1ROc1NvK2t5WjBHcVlNNDZ6S3YzMkh3U2RMRnNIQURE?=
 =?utf-8?B?U1E2ZHpiaVQrU01FMUdPYVNtRjJwVTU3WFlQckZYcXlydGkxaitVN256Z05C?=
 =?utf-8?B?cnhIVzdHSEZVelVRNlZmT1ZRbHJBdHJ1OStCZVcwK0ZkRGFJWUFaTU9GQnFt?=
 =?utf-8?B?STFRMEJMSDlRcjgyaFF0SGIzUFdnaVIrNUhXbkRURXIvU1NPbysxY0VxUTcr?=
 =?utf-8?B?ampTWkd2RnJNL2wrOWtCd2xNVGZkZ1k3aFd2QUZVV3d0SE1xQkR0T0VpNThD?=
 =?utf-8?B?U285clpoellud0M4b0pWcUV3SnJmMVBLUzZsY2R4TllSOUpncHRVb2lWeDR1?=
 =?utf-8?B?akFyMWJCSTl6azRzZnVNcG9Xemd0YjdnSkdNOGlHUDRYbTJvalMwazd1TWRF?=
 =?utf-8?B?YSt5T1hiMDRXNzJWTTIvemtDaHdNQVJzUGQ1dEp6N2R5TDRnRFY4SjJBQ1Zy?=
 =?utf-8?B?bTNpZWRlenRsSitqZ3VsWE14MTNLQTBUN0hPZytmS2xMcGVmby90VDh4RWdv?=
 =?utf-8?B?eXBHRnpDeTNqUDZVK00vKzBMYk9hNEdXd09QYnB6dkhvSUsvc3hnT2FwbG9L?=
 =?utf-8?B?Q0tCclc5U0Y0UEtReTZPbDFWdXozditmbGlhVVc4amlGSDF4S0xVOHVQMjkx?=
 =?utf-8?B?TkdCZmVIQVA3bHFuMVgvYml5S0FaYzNTUW8vTjVaTkdITSszUzRoaTZSa0lu?=
 =?utf-8?B?OUt2M2dtNWVYbm1ybkxtWEpYek5iTmZzWmxhWlN0eDZtclVPcGxGQ2pvbW9r?=
 =?utf-8?B?S3BTYUhzWVY4M3prbmRic2JEUjRaMEZBc3Q0MndtOUNjWUJuZ3VFaXVGR0k2?=
 =?utf-8?B?QzRnQk9leHZaSUtqRGpmUnZnSjZCeTJkb21EUzRJcHB3VDVFQnBZeXZlTGFP?=
 =?utf-8?B?Nlp0U3dINEk5S1Z3V0xDVDYxeWU3a1lnaWVPK3hkRkRRVHpzNlVMMGN3Umhv?=
 =?utf-8?B?bmJFUUtFSld3ZjRvZk9sd1Zoa0dVR0QxUzF0ZHlWcXQ5V1VYbk1pWUZud3hX?=
 =?utf-8?Q?nywGsraI3z6bK9EIq3n2eVdJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329f5d02-d3da-4185-8b16-08dcf2aff71e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:41:16.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baAJvrW/WkRj0eD6opy+GGI7Vbh4ywWKIZKUc/QZUPeh9Q43ivOO7xaCLilKUBY6cWNTy4boX1pGA6ehqOpwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

On 10/22/2024 07:03, Borislav Petkov wrote:
> On Tue, Oct 22, 2024 at 01:57:20PM +0200, Borislav Petkov wrote:
>> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
>> index 9a6069e7133c..38220b64c6b3 100644
>> --- a/arch/x86/kernel/cpu/topology_common.c
>> +++ b/arch/x86/kernel/cpu/topology_common.c
>> @@ -27,6 +27,23 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>>   	}
>>   }
>>   
>> +const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
>> +{
>> +	enum x86_topology_cpu_type type;
>> +
>> +	if (c->x86_vendor == X86_VENDOR_INTEL)
>> +		type = get_intel_cpu_type(c);
>> +	if (c->x86_vendor == X86_VENDOR_AMD)
>> +		type = get_amd_cpu_type(c);
>> +
>> +	if (type == TOPO_CPU_TYPE_PERFORMANCE)
>> +		return "performance";
>> +	else if (type == TOPO_CPU_TYPE_EFFICIENCY)
>> +		return "efficiency";
>> +	else
>> +		return "unknown";
>> +}
> 
> I guess you still need topology_cpu_type() in your next patch but that's easy
> - you simply call it in get_topology_cpu_type_name().
> 
> The point being debugfs will dump the name of the core type and not some magic
> number which no one knows.

Yeah; makes sense.  I'll pull your suggestions in.


