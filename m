Return-Path: <linux-acpi+bounces-7901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27779617A3
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31333B21B59
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B41D2F48;
	Tue, 27 Aug 2024 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fn4C3U4O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8669146590;
	Tue, 27 Aug 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785351; cv=fail; b=UYBt9YUd2vCZs+fvbMbsQOcGeAU0cJ5wn9w8NM2KG8350PjtnV8enE16SYU5+M7lMFSBuVJrel10tCEq5ufx6hK+OnSsqfX4LRePZafez2bfc3QxE+7uG2fC/b3j9Ukz670lK0L6WC3uy1cLWPMUu+TC7eE6h62FRVbo2BogRWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785351; c=relaxed/simple;
	bh=sRQxn/tBerOCoB2lqwvfcpnKxzJIOdBZyR0/khy3VmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5VcYdwRjjHF110PB191Rc3rRVBESgY8iqAsYSIu2AZZFtyHYXXhy4YYK8yrWb/vbhKtCH/TF5nngo5KB+BbOkd6l+A3bWKVkjpryVb0mJmd4HKqoY2doQiGUnFZAiHIlfBRbA6q8kDsMXyDdknlq+wZubey6KfFDzqUadgksOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fn4C3U4O; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+rm8RwIqDFcnoF0O2NOncfnxjSDzeV7lrDc1jYdjLeTAAKDC83R/w7a32Ne6Wx28layTBcjiLy7H3kMaQBTMY9sBwd6usafF/qPBnIfEulwa/ua2nFjMQnCUfkbNNnQ2JHmExEcO0Hss9mysRZxRd7n6VLga0WSukJ5C+8mBJ7a3LFv6lf7W0d6rIac8LfZKI7pOSyGFXUXTJNMWwdxsSS8VOc4AUey0UGXKNJf5fSVRBuuCnjCuYRMvV9I9CsFzz8z5tZTlcrZrIZkJRADiQo33CSLE6C9zkxsgWbH877mi+GXeQJBY7JesMZX/qB+yQyvqnpJx1QZ4B6AOVjsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n47N3Y8I1SbvPk1o//hH/rIqQhHwjpvFCLokk+9vJXg=;
 b=HeXjHxUALQDQBUlJPbNcs6771IVUllwOd/wJCi/KoZuK+j5WOWd8FIrvmNl6C8FI8TUrj54khFH+INYHee0HNL0chqhFXD4JS9h91i/7kO56zUc0CaMjpxlICRj3mFFVL1PSoW24xYZ7MKKYIYdklXpvm3I2247cZntmsBWbF8+WxmNHJowxYRTq+NCPcjFoDXHMY927o+QLGwK05rABC0KyVNDsb4XeYXHQppt3gJme0OYuTpQlMNKv0nrU6jH6lh9iRuK8Mi5Q3YxzE9daknhNdcFZtCbzBrjURjdnC8l43mQ3U6Th3uM/ym4dGCxEQiNVcPq4FKH/bRTL33aAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n47N3Y8I1SbvPk1o//hH/rIqQhHwjpvFCLokk+9vJXg=;
 b=Fn4C3U4OHJx3nZzP0/gZpfVH/YP03RoDcuAWK8n21ycoQhNlY7ZQML/V9IVDndlUc6ASHYVcCdfkr+TML8VehFi7E/+qOSWbzoKIf5W1qMaeCPSIRKRDAfc0K9lRoWFhKNDItvIpiYKDuFscpg6jni7C1V/29u9GoRL0HlNDJAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 19:02:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 19:02:27 +0000
Message-ID: <8acd43d7-3eb6-4cba-b962-e6b32c620b51@amd.com>
Date: Tue, 27 Aug 2024 14:02:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cpufreq: amd-pstate: Optimize
 amd_pstate_update_limits()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-8-superm1@kernel.org>
 <Zs4FaUoKzlKpoCDV@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs4FaUoKzlKpoCDV@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: f241634a-b37c-44d6-8aee-08dcc6cacb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEREbHRKMXI2bW1seFpGNEttRFAvOTJOTHZ2OEdrS0ZNL0htbjlua0orK2Q2?=
 =?utf-8?B?Wkxqd2dtTWtRa0pSRmUvSUtZSFlFUnVwMWpzSTVjcHBoV0hveGx0YzYwU2M1?=
 =?utf-8?B?UWFKQnJ0bk12Rzdkamx6TG5EMWpUKzlPVmhuc1BLeXF1MVpXTGxjWW51NjFr?=
 =?utf-8?B?SVFXeUNSM2o3UkZydFZ1OThQK1dyY09vdkZ5MG5MSDljamhzUWtSbUU5eWN0?=
 =?utf-8?B?QVRsQjJraysyZjlMQkxlN1hiNXNUSXY3Umg1Y1RSYW55NFFjYUhQRWlQejlk?=
 =?utf-8?B?SE5nL2NsTlJEc0pIeVdlRStrRHpmeWljcHMvS0FiZFIydG5saTBiNDMxblhy?=
 =?utf-8?B?MkRKSTU3UENNZHZlRk1CRVNZNzg1d2ZnR3F6d0RiOE9Qc0wyQVBZdld3Zllx?=
 =?utf-8?B?ZnloNktJOThIT29vZWJ2WmVwOVl5K29tQVhuV2FsUk84cGRIclJuSThmb1JH?=
 =?utf-8?B?ZzYyaHJSUEt3OXhWc29jUlYrT0J2RnAwVlRNKzBoMlh6UmRRTXdhTHViMXRG?=
 =?utf-8?B?MUpIeTFvcDNpNVk1MFVCakp0YVZlVlJyNm50dXpjSGxTTG9KaGROR2tSMzhI?=
 =?utf-8?B?cElnS3ZzUVMrWTduaG4wYUNWbWRESEVLSDVLYUsybXorYzNQdUNFUUplVC9J?=
 =?utf-8?B?TkRYRC92V2oxeWNvZWZ1bHY2NWt3VFlFTFNJOHFySEYvNnRNdldncTh3bm1i?=
 =?utf-8?B?QnFvbjRBamNsazJlNTBZQ0NjcVhLSHdSa1NWKzArNmkwblR4blplSGJDTVgr?=
 =?utf-8?B?M1c3R2diRWtwZ1NMa2Zxd1E5YnphYURnMUVQQkREbUdHZUVLVUFzaXljNyty?=
 =?utf-8?B?SHVXaWk2TURXUEtWbGQ0QUJpMU03RGZETi9YQmRVWUIwYWpCYk1JQWFidUZZ?=
 =?utf-8?B?ZDNDRzVYeWhkRU40TEFsQS90OCtQRFF5VnV6NmdUL054SFNNbUUwdFpaYkFp?=
 =?utf-8?B?bmlPZUxMQ1pBQzBnUzVhZzZhb09TUTl5YXFtY0JXSHd5VjdiTCtIRlpCUTl6?=
 =?utf-8?B?MnNvbTA1ems2WUVyRVNGdzdpejhtTkdaU0tKdk5QRUZqL2M4bzJlV1VYVjZi?=
 =?utf-8?B?QStDTHBRcG5OeCtaUnB6bUxuMmVKMk96R2FuUlFoeGhKUlVobkNBM3c1dE1L?=
 =?utf-8?B?T240SnFHclZIMU04MGRhRWdRVGFnRUhzOUtNRXV5eVYwdDZFRXJYdXZKZXhv?=
 =?utf-8?B?UndMdzBlMDNwOVBWRWVrWlhFVTFyQ3JDTTZvVzlWSFN3SUxnKzNCVGNKOHBH?=
 =?utf-8?B?cE0xUk4yaC9taXA0NFcvbWVscUxTWFIrcElyYk1HK0xCOXlCcGh3aSt0Qith?=
 =?utf-8?B?MVp6ejhVVDFaVHpwMGVaZ1dWUlM1cXYyRkQ2MVRVMFFmR1BEbDJSbFRCVU5u?=
 =?utf-8?B?c2pidHdLT2FmM0haUUtqZVdFTkpidWdwODEzNkdEbFhiYVoyS1JnTHFuYTYv?=
 =?utf-8?B?Y2EzeGtJaHA3VW9UUWFybnZyb0ZZbnU2djY4cVl3a0VrZm5BQkI0aFNkbkor?=
 =?utf-8?B?Z2NTM3NqRE9aQ0E2UFZwcXJFampRcjJDZ1RncUNTNnZEWUFBK1dPYlpVd1Y4?=
 =?utf-8?B?OUI4L0J1VG9IcmZDQVlHVlp3alpzN2pHQUtSZDg3QmM5Nk5MY3lSQndKTDIx?=
 =?utf-8?B?Q0tkNXVJYk1QN1pFbUxvaG1OUThnYXc4UW0xdmxkOTJNUUw2cXZVd1JjTDd0?=
 =?utf-8?B?RXljTVRtV2x1ZUZNWjhtQTRiV1VkdGxyZWhEN01LaDVkWXRVVThPNk1nSnY3?=
 =?utf-8?B?M1FGS2JFdmhEOTRQVk5OVVF6WlhpQ29OU1FaN25INkRnMitWMm55aWhRUnVF?=
 =?utf-8?B?YW95STlJYXNDSHRiemxkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTdxblArRjV6aXJoQW4wcTFqQTRmTk9oSWsybnA5TU9NQWVNek9LcmhZbFBU?=
 =?utf-8?B?d2s5d21wTll0SlNlaFZjcXMvZ05SWTNObW5tRThWSFdURWl5RHdqY1ZlK3Jw?=
 =?utf-8?B?cVFFV0tkRXVOWlFTcm04b2l5MnBrSDBlSHpqVkFPUFJEcFkyWDlJaG1Obytt?=
 =?utf-8?B?ZDl2ZG9jc2FXTWlCbnBRc0VMWWZkb0xNWjVPN3NzZFJCOXVDYWpmYzRFcS83?=
 =?utf-8?B?elhUSkZPdTVSRmtXY251SktuTVRXSG1zaUg4MjhDMUFjVHlGSlpjeitIL2ds?=
 =?utf-8?B?WXZDU2JoN29LRWhXcUI1aXVRZjlJU3k5OThFayt5dkp0KzQxSHRmNGxud3J2?=
 =?utf-8?B?QzRpT3ZVUENZSHRSK0hoZmNnejk2bDgwQVcwR1FkSUJXNXlYc0QvVTF0OGRF?=
 =?utf-8?B?OTk1L0lhUkV1VG13SXc1Y0V4am5Rd3Rkb210L0o4OFd0SXVTZXlVdWpQNlNU?=
 =?utf-8?B?TDI3ekxYLzAxUVQ3TWRJY25QbFhMUHB4aDVxMkxYaUZiV2xaZlYwRlVvWFhB?=
 =?utf-8?B?NmdiODREWDR6UlNsMVd5VndzUVlSRURPNGl0TkpvOE1Ub1NKVTRQZXBUOFdz?=
 =?utf-8?B?N0JHd3V0QzJIK1g4Q1M5Yi94ekh5bGNpN3NNd3VqSkh2ejJvMlBscHp2akVE?=
 =?utf-8?B?V042UWZmKzZ6eXUwRy80R0N6ZHZncWh3d01BY01FVmxRVUNFR3RaOXNITlJ5?=
 =?utf-8?B?Ni9vUVRnMHNVU213dWZCbHpMZm9Nd2l6L2VsOE9SNzJtcFhNaFBJSEdqejBo?=
 =?utf-8?B?cjlNcHRuZ2FoQTFZWjBBQWVLdWswZHdHSGVaTkxHbDdmMm9GQ3pOSTFGY3py?=
 =?utf-8?B?OHd3dU5DQzk3bGprNmtLR0tlTXRYWk5TZk1tNUJtaWEybHJjVkpjQWFwUmVX?=
 =?utf-8?B?aitpcGtaaGtCTGhSeVVpVy9aNkNiWWl4QnRPcnUwbXBLQTFFaTVxczZTQjdi?=
 =?utf-8?B?KzZwSHR1SGRVTVRJcHIrNUd5SFNtbStIQ2dROE9uNzBhZXdoREREM2hSVFRj?=
 =?utf-8?B?NWlkenUrVHhMKzNHWVRQMTQ0QTNmRTdKbDIwdEVlYkowKytBTXdLbVJ6WWow?=
 =?utf-8?B?blVEYW1iMDRaN3huaCtlOWZYM0NySDNvSG5jVEFwSUNNTXFhdThpN3BUUFFr?=
 =?utf-8?B?Rkx2c2s2OUF1NGdaYk01dDNVWUd2ZGh1b3hrY2YwY05kRndrY1krZjZSSXFa?=
 =?utf-8?B?QnNkUUlHQUI4RDAwV3dqTW9UL2RmeU5yUHY5aW1sZUlydkRhNXVhdW0wTXpw?=
 =?utf-8?B?MWFUNzRiTGVDOVYvcUtkRWh0UFFhSDJha1l3aWZ2WGdkMnNFM3dFZG5ZdG9Y?=
 =?utf-8?B?WlBKbnBJUkZIeHoxK1ArNWdyd0tpeDN3Ymh3V0tIMG9uWnRrRGdZU1pxbVpy?=
 =?utf-8?B?cVNPMWZaajlQVU5TVUlwSm5rMExTU1UwRjlrNFEraXVnYjdrVStzMjRTUWc4?=
 =?utf-8?B?OW5yL2VzWjdXU2tMSGxDelFrSUFKeGtZUVQyOXM1b2dNWk5WdzFlNnFNV2hx?=
 =?utf-8?B?T0I3TXBJam8rZUZSN2UrNkZ5bkpUVGJnekJJSnNaMGVBZ20xbEc1YWw5QUNr?=
 =?utf-8?B?YzBvbFdZZHhFWVJQaEZuVWRhL3pTSEhxOGgybHBncHhpT1hsTmFvWGk0V3JF?=
 =?utf-8?B?MGlVek9CK1k1eTBZZDcyU2xpK1NNdG12NHpWTkZOZjNZRVZqS2VQUjRYc0sr?=
 =?utf-8?B?a0Z1ZHczUW9rSi9PRXRUWFNpbE1zNzZjYTBHVTFOYXR0L1NrblU4dWRJL0Ry?=
 =?utf-8?B?SDl5c01Ed01wV0x0N3Z3cnhUQXBzMWdHN2tDeGduTE5rU0dyU1pXdUNOcVJH?=
 =?utf-8?B?VVdhYU9QdjZGMG5GNUQ3OXJzdnN6Y2lQMjRqeFlWaGkxWEsvVDBRejJuaFN1?=
 =?utf-8?B?TWp1eGlpZFpMR0ZJZ0x2bWlVMzRGZ05TalBhd1hSZ3J6V0lxMEEwL0E3MXQ0?=
 =?utf-8?B?Ly9CR01qQXJWL2RYVm5kejJ2QWdudzNVZ0NWajY2S0c3N1Z0NWpFdnJ4Tk10?=
 =?utf-8?B?SmlhTVFrcXN4b1NKQnpONDgrUEQ2eUlZZERCQTJsK0pjbzAwbFEwM2NMb0hV?=
 =?utf-8?B?OTg3N2NTbmJDaGp5VnZRZ1d4MElCczMyb2ZrZkxTV3VYRzZndndnYnpOWDFY?=
 =?utf-8?Q?Fh74ka+BWhb79C7644VKLo0q8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f241634a-b37c-44d6-8aee-08dcc6cacb02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:02:27.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVbfByu4u8wfEVNsS6o80IUHcDwrvXOVSxdZVaYuMtydZHH22jwyay3GAb0GkaestEGNRUtkSFD+6gk7bU4vGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

On 8/27/2024 11:57, Gautham R. Shenoy wrote:
> On Mon, Aug 26, 2024 at 04:13:57PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Don't take and release the mutex when prefcore isn't present and
>> avoid initialization of variables that will be initially set
>> in the function.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
>> ---
>>   drivers/cpufreq/amd-pstate.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 75568d0f84623..ed05d7a0add10 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -798,17 +798,17 @@ static void amd_pstate_update_limits(unsigned int cpu)
>>   	int ret;
>>   	bool highest_perf_changed = false;
>>   
>> -	mutex_lock(&amd_pstate_driver_lock);
>> -	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
>> -		goto free_cpufreq_put;
>> +	if (!amd_pstate_prefcore)
>> +		return;
> 
> Looks good to me.
> 
> Wondering if it is worth maintaining a static key for
> amd_pstate_prefcore. Anyway it doesn't change after boot.

As there is a kernel command line option how would you pass the early 
param parsing result over without a static variable?

> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 
Thanks!

> 
> --
> Thanks and Regards
> gautham.


