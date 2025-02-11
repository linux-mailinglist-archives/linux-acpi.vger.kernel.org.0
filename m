Return-Path: <linux-acpi+bounces-11024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C402A31122
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48111882110
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B261EF09B;
	Tue, 11 Feb 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/7pOh9x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742B1EF01;
	Tue, 11 Feb 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290710; cv=fail; b=R6SISRyHeCO+8LOKj/EzZw1m3YlWcUfU3Sar2HItWAPcmsxwbrDqNiu00Ez8y7UTE0Jhon/ucSNYUBu7cMaEaG643/FHrLdId3Z/U1ay6nB4YeetMQu19Nm+Uigf/y4qQyu9PLnILeDZ3G2rMQOa+sM1Vl+uFden//jcw48x9/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290710; c=relaxed/simple;
	bh=364KrliUfEpD2uz+3iiIgYZ+d5Sj2yH2F8/n9R4Yok0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGCD/hY6b8pgUSo8Pe3SLYVfKkaeJJUMBRp/l3RlK6WGbWrcTMik3vEIzu9F4otHsDjo3kEV/gCgx9nZULaMXbygbcOGY9btUyOUqYgQDd2j1JB2CQGczvsPtMrnCENUHQosL25bACRaF9T9UHgEXVlxupufHadty8EbKTbzU6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/7pOh9x; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7TtXqdWW3VyvcM0zGzZ1OCQN5B0Ljs1/KcH0/4S4+t+hEd2gP+8HGdfP2WZuIZMkAgW6PrLfvJ67eu/EATGIR1zjgBnA31+zDdFRo1jx11hENkLhwbpvD//BgI8ol15neXVE69DHIwsVBHt49+cLEcE9BY7jjk5TUGuMVa4xQTyysx/3+RS5MvKks2SgYUUqOSPifXR9tjQJsgu9sZIZSRH9mMenVNAglFs7Rro+TPBxh9Uim+tah2H/gy7PGkCosloP4hqOz7Cr7R75QM8WoXR+j/N4HVEd7iIOEJ/ny9HqDXBJh7Y+CvjvNuilwle5NNP32mcvh5QDq18/L65dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gphvcD+X99J3rxMhlUBSuIf40Cy11EJMDHXCEHgxKQ=;
 b=Sg4S9n3XvpOjGhRyWYe1eZHDnevF4SfEBT+LM0Om6A6LQDd4dt5br4wCVm0N3yAkTIksJHbZujA/ZAtxMo1FIc2wZqhLMbyMlEcrgEZjTM85CybkfBgOC2RIeZ6z7ilBm9Wz4DKZR158JBGb96Si3ks5d4AxUPkV8E3S4t0/RTpaixjf3KEcjvtcaBiBHa7NislYp3eaq2J3MNwIEe2K59VI9YLyhu6Pb05LYhpeikAlSE9kPsxoTAOJx1ELSDPkeAQ+vkVVbVOwCPBMIhNAcMsQuW0h1Rz/eb1dcd8PEs0kNGW/CCfiA8rJshCm8Z21Zom8DmPldeDjmJ+snDcZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gphvcD+X99J3rxMhlUBSuIf40Cy11EJMDHXCEHgxKQ=;
 b=a/7pOh9xOSBubvbh7sHLZhm0Ad5onCOXXwdCZKoXlVqa12w/t8AmypeMdAVVdjE0M9XArSX1vr2fkxILdwD2nzhAVnMKia4FfKCG3i3kJzpH7gL0k/qX8HUUYhH3zXvV5oe8+V4ub/5y8ld0N0gaQL9nXzRwtI54IYRxhU+SErk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 16:18:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:18:24 +0000
Message-ID: <1ba47782-0035-43c3-9ecd-887f1f60340a@amd.com>
Date: Tue, 11 Feb 2025 10:18:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings `Could not retrieve perf counters (-19)` and
 `amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled` (Dell
 PowerEdge R7625, AMD EPYC 9174F)
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Gautham Ranjal Shenoy <gautham.shenoy@amd.com>, Ray Huang
 <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <2b811df7-5278-4cfc-b8a0-7d6d72d3358d@molgen.mpg.de>
 <5dff1719-c4e9-4ebf-ae0b-73b9de98df05@amd.com>
 <DS7PR12MB82528A694056F1FBA20CE01E96EF2@DS7PR12MB8252.namprd12.prod.outlook.com>
 <d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de>
 <e26bc00f-1675-4aac-bd02-60774ff5901a@molgen.mpg.de>
 <3ded4075-e2f9-4231-9c3f-49a14fbbde1e@molgen.mpg.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3ded4075-e2f9-4231-9c3f-49a14fbbde1e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ed15f5-d232-4751-cdc9-08dd4ab7b590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkRzdDJrN1NZTXAzUEZqM2RQUVRjNlFDcWJPb25vcmxOZVZqSkNMaDE5RVNY?=
 =?utf-8?B?WkZBaHdpOGl2UCt0R3ZIR0VxVFJOb3lkRnN6RWhUdGE3UXlFbDRJaG1ZMWhy?=
 =?utf-8?B?TGV5enV5NFNKNmQ3UXE0K1h6bmI3NzhQRUxXbHpURXJ3LzR3TWpGQnZpY0c1?=
 =?utf-8?B?Tk9wYXZvdzZITEJiNmoyS3lwOW9sdHhEdXgwbGpPL2tqSHYrSGNQcXpMc1E3?=
 =?utf-8?B?YTVXZlFzZ0s4OER3U2hmZWZVWHJrMDZNdWR6WFEzL3lnN3ZlL1BRODhOV1A2?=
 =?utf-8?B?TzZjanliS3dhYWNobGl2RTBwL3orRUlPWUllaGJGWjcxN2Q4OEkxVHdlcTgr?=
 =?utf-8?B?OW1laFh5Vkh6YWUvRDhwRzZDUWE0ZjcxZUhQSndnNFdlTnhITTBTT1FoSWE3?=
 =?utf-8?B?YnpzUVBqSnF2UkhpKzJPcGVETEhwczZmRzlnZjBzTURvc25vTG55VStlYkVz?=
 =?utf-8?B?SUx0VlptQkowb1VWU1I0YzBIWnNnblZTcS9uZElHSW90RU8vZzhUN0g3MjNu?=
 =?utf-8?B?UStzbUI5amJ6VFBnUkEyb2dEVFlNbGlPeDBnKzJjeExRK1VnMzlQbkdKZFNW?=
 =?utf-8?B?ZVF5VTBSeUFqVjJyQVJ2a0ZIWHdQdDFvYUVIK29kWEJwKzFDdFpuUDBmK0Z4?=
 =?utf-8?B?Y251TW5HQ2hiY3h2UHhtb0loS3VPZUlUS2l0OGVaQmY5LzBhejFlblMwUmR0?=
 =?utf-8?B?UWJuS2ZBSHdjUnJKNzVCbHIwTzJqSk10WE05K3RacW5mUFZ1ZitRREwrSktW?=
 =?utf-8?B?eGJlU2FUY1pLazNhaDVsdXRKUHRmL1BpY2VQenpzbG9FcERhaTM2YWpnQTlQ?=
 =?utf-8?B?TzdwV21Wb1haOVM5SFc0S1o4dzQvd28vaUFuZlhwOThUYVNlbnhPK0pZKzJp?=
 =?utf-8?B?bG90NGZ3M1VtRDkwMytJZWZZUEZjdHJld1l0UzNmanpJY05ZbVZUZnJJaWlh?=
 =?utf-8?B?Wm1lSllKdllkN1JMVUR4YklMV05iUVljL2ZidFNPaGgzd00zamt1YlVMNHgz?=
 =?utf-8?B?SDhnY3RxWCtwRUlvcHBRbTVsZmxHWVVXN1g1MzB2WFdNR3d3dnBLL1NKbW5t?=
 =?utf-8?B?b0Ruc1hjS1lQbmhwdGh3NFNYUUpmRjZCMWR3ZlN5eC81TXFDT0RsTDRkRUh2?=
 =?utf-8?B?M1liMXNFME1kdndyYk9LOXNLRzduNFVHeGpIWlFUOXcwaENUaU5LZmttazh1?=
 =?utf-8?B?bHhlWElDcTV2aUhMcEZxVm1YTy82S2NxTGt4S2t6MldtWU54TkQ0ZlN5SnVl?=
 =?utf-8?B?ZlpOT3RKekNGUWhDREkvUG5TSzN0djgrcTNTb0JVNGJMMnJaOE9vRmErdWJM?=
 =?utf-8?B?TjMrNGQ4a25iK01FcW9jdEZHRUJ4dndkRUpXb084WG9kTmo2OWlsOStsOWlV?=
 =?utf-8?B?SUZ0NUJvUVN5TEtOTnJBZzVtTWwwSlp6dndCR0hWeFFEY3dWdWRlV1VuaTBy?=
 =?utf-8?B?aG9seVp5dlZSeWorQzNwS2NlekJ5Q3Q4RWJ5SG0vT2VqaWFEZzZLKzFRYklP?=
 =?utf-8?B?U0ZYcnU1d1AzeDNsMUFnZ0Q0NXJzVGc4bXQrdkRyK0dja0JnQnRiUGsyUHo1?=
 =?utf-8?B?SCsxanlSdTZ2MWo1a3RJeFBSRXVTN200MHkvRkV0Z3hDNGxFKy91VzFpVGk1?=
 =?utf-8?B?bEFRcTlSWjdpSWhPYjcvb0k3cmc5WEpTaHhDRS9nalhjeGtQdFYvYmxaRHVr?=
 =?utf-8?B?RVJpTm1nMHZzcnBTV1JnWEFRUWtrREJ4blVWNmJlK0phVmcrWmpoUDBZUTc0?=
 =?utf-8?B?T1JTcnphYmcrS1hUKzZwWjBUZWNkL3RLMU82R0dTZWRwdXJ1WmYxUWhaN3RD?=
 =?utf-8?B?RFE2YkY4RlBFMU95RU0wQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFgrWVJRRnZFNmlocXdVaXJ6dXlUVXlzREViVXJxMWY3WlZTNnRYZ3hSRXRP?=
 =?utf-8?B?RDlmaE05RVJtbkszV2NZYkx5TjRtdk9SSkxRYldoQmVJU3htcFNLQTNVbGxE?=
 =?utf-8?B?Qm1DLzg2dzJpSkNrRlBtMkliLyt0YzY3Tng4bFJBdDBiM3BPL2pJZk1LOTc0?=
 =?utf-8?B?MlR1NXBJOFZRSTdJeElpdWNKTkJsTTNDK1psOGFMSTdaSXNhVzFOamczU3BD?=
 =?utf-8?B?dkNPVGY4UFZJQnRvakg5WFdGdkQ2Yy9jeDZDamF3bEQ5R1pNN05BY0RvSTQw?=
 =?utf-8?B?ZXptWVBnTDVjeTkwUlhQVDdXVE0vNlRLWUlwTUZNNmRGY2sxQ3BQUURVVm91?=
 =?utf-8?B?bkdkdU0yV0ZNb2d3TGwvN1V0VGpWalRtNlQrMmUrdzZLOFQ1ZHBnQ3NJL3hk?=
 =?utf-8?B?eXpZU2xxdXhabWZoQ25OQksrRnhlSXdLMXBZUkZnS1JGY0dabm5sUkRrMEJU?=
 =?utf-8?B?cHhUbVkwTGllRlBaSU1MUDlxdkFkTHI2Y0tmN3NYQTBzN0dXaUxsUXZSTTdU?=
 =?utf-8?B?RUdPZ25Ba2M3WS84WVBFTmpDNTFyYk5WT01iejhjQzljQzNuU1U4TTFsZmdv?=
 =?utf-8?B?a280WXRQZmtZQmIxalVCRWVvbWtESm1ISTljUkRGZDNxcG5FODJtVmRJeERR?=
 =?utf-8?B?b3V3aUU4bGY1QVl6OXJsV2FjMGw1ZmFNakVWV2ZoRjhDMm5BcXM2SWIrZkNP?=
 =?utf-8?B?dXBWcVQzdi9WRzVjbWlYdUJWUENlcE9VTGE1VmpsQll5NE5HaVlOcEVZV010?=
 =?utf-8?B?TTdCSHRTWG11MkZCLzRNekZEK3lmRmh5RUpJZnh6b0V4UERPMEc4N29QVFBs?=
 =?utf-8?B?dm80Tkx2MUMwRml3NVdOc09FcDkxUVVFUDV4ZXZNUGZxTHpEV0lmRnBnSnc4?=
 =?utf-8?B?cFJtcjAxWStwb0RmVnZYSmZRMXVzeTA1UmxoTkNSMHZOcWhvb3NVM28zQ2h1?=
 =?utf-8?B?MnhUVmZ2eVhvZzlQbEthOGE2djdmL1A0S0hTK1M2Z3NUMGcrc0Z4elZTWWpT?=
 =?utf-8?B?TU9NdGVITWdzNUcvU29oK21YUEI0TkFGSDZPc2N1ZS84cmM5UkNGTU1lYWtU?=
 =?utf-8?B?ZXZyWVNzOStndUNOWmpPZHI4aWd6Wk12TVQ0bFZqQ3Fpc1JZYmRBdHRqcm04?=
 =?utf-8?B?UEt5RUpLZHJyclJnckxPanQ0QVhaRmtHTk1OQXRzQlRPZGQ0UHhLVWJxWk9t?=
 =?utf-8?B?K3hQMXpzMTFNK1FUQk5xSHVmbTEyZ1lQalpRSkdhbGVpK1h6c0Q2aGl1N1pl?=
 =?utf-8?B?c1ZoMUgxbHhJdnU3Mm1UNFJibW5sZktCck1uazBQRDlNRkVYQ0tTU2lpU0lV?=
 =?utf-8?B?QnZwdTF2eUpid1BlL0xCRzZZcm9kOWhPeTRxK3BTTlg4WDAwelY4dVBPM1d4?=
 =?utf-8?B?b3JYbFFmTUR0WW5OWWtvUTZ1SUcwcUc4MUtyaEdjbHpYWEFUTEU0WTZ0cjdq?=
 =?utf-8?B?NHFFdXVlZy8zekcxSHZFSEVtWE1iNFBtbDc0M0hTdFlQMjZPYXJmNGxSQ0gx?=
 =?utf-8?B?T1FQSXRUVEhtSnZrQ1k2ZFFPK0JxWWs5QnE1bDlONEdRVUtUL2xZMWhZUG90?=
 =?utf-8?B?aURBVy9vVVRoclowZWg2ZEgvM2tBRVl1VDBXL0dFd2lSNVhNaWxSM1hYZVpw?=
 =?utf-8?B?VGV2QkkxZHhubmlxWlRGR2lYOVlDSG1OUHlHaXZJa0V5Z1BLQnM2VUc3ZkhY?=
 =?utf-8?B?bXcyZEdMZG1LYStGd1FGY0dyR1JmQnJwTzY1MnRhR0NtUk14dkFYVEZPV20y?=
 =?utf-8?B?UVNpL081TzZvN0hjdktEZDhydmVNY2Ftd0dBTC9mczU0VGFFQUl6YWpyRkJo?=
 =?utf-8?B?ZVAyQXJnLzRIZERXMjBHeURqeSs5cTRzaU1VbUxHd0tscExFZ2VicGZQZkF2?=
 =?utf-8?B?WUZlaHFQRXJVQlRFNExKRHZwMjA0aXFBNFppYmhENExML0krSEZ1MUVudWhY?=
 =?utf-8?B?amxYeXJCcEtUWmJMeElYNWZodjFvUmtZSnlSZFJYSDJRTnYvanVTb2RndDFU?=
 =?utf-8?B?T3Z1elRCdTQzSkhySURTUEpIZGRpT1cxWkpaMnBKUTN4UFAzL3BMZlJJem9N?=
 =?utf-8?B?YWFKcVBmR2o5d3krOTZXZ2V0ZURVeDVIZ2lXaFdtbGpDa2lNVTZsMUxzdm5Q?=
 =?utf-8?Q?71/CcxgpqYR4WbMQPS8uFEg2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed15f5-d232-4751-cdc9-08dd4ab7b590
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 16:18:24.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/H7yqlHtBumU0L42Ir88Z24K8+7eMj40wnJlPY9sstwjIW2OiTBap/UldAlMzbjUacM4v3tnB92k87CNVIMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

On 2/11/2025 10:12, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 28.01.25 um 16:08 schrieb Paul Menzel:
>> [Cc: +x86 maintainers and ACPI list]
> 
>> Am 28.01.25 um 11:49 schrieb Paul Menzel:
>>
>>> Thank you for your quick replies. Gautham, messages with HTML are 
>>> rejected by Linux kernel lists.
>>>
>>>
>>> Am 28.01.25 um 04:51 schrieb Shenoy, Gautham Ranjal:
>>>
>>>> As Mario mentioned, you need to enable the CPPC option. Looking for 
>>>> some of the Dell PowerEdge documentation, there is an option called 
>>>> "Collaborative CPU Performance Control" (https://www.dell.com/ 
>>>> support/manuals/en-in/poweredge-r730/r730_ompublication/system- 
>>>> profile-settings-details?guid=guid-2e9b46a1-71e3-4072-9d86- 
>>>> db648757f0e6&lang=en-us).
>>>>
>>>> [cid:fe57df8f-3d99-4ea0-8f6e-b0daae49bb0e]
>>>> Can you please try enabling it ?
>>>
>>> You quoted the Dell PowerEdge R730. I couldn’t find it in the *Dell 
>>> PowerEdge R7625 Installation and Service Manual* [1], and also it’s 
>>> not listed in the iDRAC9 Web site (attached with added `.txt` 
>>> extension to trick the Linux list).
>>
>> The amd_pstate warning seems to be related to the perf counters 
>> warning Linux prints earlier:
>>
>>      $ dmesg --level alert,crit,err,warn
>>      [    2.666393] Spectre V2 : WARNING: Unprivileged eBPF is enabled 
>> with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
>>      [    8.109446] Could not retrieve perf counters (-19)
>>      [    9.386551] scsi 0:0:4:0: set ignore_delay_remove for 
>> handle(0x0012)
>>      [    9.487804] amd_pstate: the _CPC object is not present in 
>> SBIOS or ACPI disabled
>>      [   14.726193] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC 
>> data block query control method not found
>>
>> x86 maintainers, the original report with the Linux logs attached is 
>> in the archive [3].
>>
>> It looks like, there is something missing in the Dell firmware to 
>> enable the feature.
>>
>> The perf counters warning is from `amd_set_max_freq_ratio()` in `arch/ 
>> x86/kernel/acpi/cppc.c`:
>>
>> ```
>> static void amd_set_max_freq_ratio(void)
>> {
>>          struct cppc_perf_caps perf_caps;
>>          u64 numerator, nominal_perf;
>>          u64 perf_ratio;
>>          int rc;
>>
>>          rc = cppc_get_perf_caps(0, &perf_caps);
>>          if (rc) {
>>                  pr_warn("Could not retrieve perf counters (%d)\n", rc);
>>                  return;
>>          }
>>          […]
>> }
>> ```
>>
>> With
>>
>>      include/uapi/asm-generic/errno-base.h:#define    ENODEV        
>> 19    /* No such device */
>>
>> this is returned by in `drivers/acpi/cppc_acpi.c`:
>>
>> ```
>> /**
>>   * cppc_get_perf_caps - Get a CPU's performance capabilities.
>>   * @cpunum: CPU from which to get capabilities info.
>>   * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
>>   *
>>   * Return: 0 for success with perf_caps populated else -ERRNO.
>>   */
>> int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>> {
>>          struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>          […]
>>          if (!cpc_desc) {
>>                  pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>                  return -ENODEV;
>>          }
>>          […]
>> }
>> ```
> 
> @AMD folks, just for clarity. Did Dell something with their firmware? If 
> so, are you going to work with Dell on a solution, or do I need to 
> report the issue to them?
> 

I feel if there is a BIOS bug in hardware you purchased, you should 
report a bug to the hardware creator for them to fix.


