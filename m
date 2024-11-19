Return-Path: <linux-acpi+bounces-9663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7FF9D2A6F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BB31F2200A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D91CF284;
	Tue, 19 Nov 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pccSQ3Pe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921A1CCECE;
	Tue, 19 Nov 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032334; cv=fail; b=Ds1xxhzYjvotjRAPWEKSufbu8uDdBRhC+YPkG88G9Q9oTeE9bQmWKPjeb9gb40riT1PNi/SbyOlfdfv36z3UX4AZEC2yJjNCqQY9Q9ixeiGcprY70hlnBeFUkLfJh493FQ39RjYnpQRpzVQd+Ujgq/coTu0zcr9Qcljv73bPO9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032334; c=relaxed/simple;
	bh=FJnUEL7OLg/h5ebXoUjC8rT3jQNudzS2MJyFS4xOico=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKGIzdMl3BtiNjjsAp1crhK23NKcbENA5swfH+ZazkTqFy/uap1HMqzva3f6a4r0JH8y22FxmSd3qj/1+PPZMZg8/C6ZlHXsis/p8hDevDT7kE73aV0+iIYDpy85VI26e1nhgPurH9x+7T//vwHttKE//h0Ynly6EWTybnWxizE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pccSQ3Pe; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQZhc7OsmmvS9RNXhttr9C2GNUvUg8CYuwf9s3/VR5weZEZxIvDJjVAp1bLUw8ys1nq01y6aorfuPw/9dye8YHfAtykyN7u+RpoD8TrMQhqnojMJ5hO6pF4+x2+TgTHvxZuQkibevXqoDkpBhqqc7nxE8zmbEkyV37/qkPhwCZo6ZgGCHzUiKiZMq2G4QuG4OBYuIIWnUg2l77+eX+pNzX5uLPZn8Llzjw0uGbfTaM5eYVVzcskVFXwToqDEOFtD8OGIAiP6yZlsMTrN/0s0N5xlKx5TUGbTAiUgnoF7QPhTkuVNiG/rdGWYMLqd9sNOQRZ7ZMMIfA0hD4RFJq9Wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt4cPE9280a8xQWznox6syCVkGEoQrq48hVSanTFcJQ=;
 b=Ze6V3GuS+qe3/6sy+jro9BnINFNUY2fag8JXwHJ3kP36dHRCPJ9kEzX1zfYoZbQtYvl87houaeV+gzl8KXWUQIo209ouqktw7dl3N9sFEjVc0yxiCHjpUIUgL06DkYcYI4oB6/XKjZ1YaoincX0Rq9gz6KP9VBQYmyzu93ytwhK5hNzxwMhapZGWxU3SYX5GpAEjcKdmnHXOYo8yL9m/ZD8iZQ1yMJxEVTR37+VAxMMpdP7+swRACbiT7EQvZGcn4ishY5KNinwINOupgQYzxK5mZEFxrQJ103AznmghLG0/XOWsp1PGxzc76ynS8mncxp9furyY/kC0mU2lkjceuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt4cPE9280a8xQWznox6syCVkGEoQrq48hVSanTFcJQ=;
 b=pccSQ3PevSN4ZNTEx1yJFQPLKzBbg8n1NZnPLfkOiP2JkXa+9d54EhjfCL0kE+k5KCh11D2R818RmGkwW0Vl+LUmrfrAiO0o4LWHx6S9aWrHHdv60f+AWJrgm5EzWaJioKeBl0vNQ82MTu5t3ScsPoq+0iUO0UIJl7yuY/jS27I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:05:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 16:05:29 +0000
Message-ID: <6efcfc19-bdf7-4c31-9a18-275dce6b750d@amd.com>
Date: Tue, 19 Nov 2024 10:05:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpuidle: Change :enter_dead() driver callback
 return type to void
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 x86 Maintainers <x86@kernel.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <13636465.uLZWGnKmhe@rjwysocki.net>
 <2285569.iZASKD2KPV@rjwysocki.net> <ZzyqMmzMaCHqE+9m@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZzyqMmzMaCHqE+9m@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To SJ1PR12MB6098.namprd12.prod.outlook.com
 (2603:10b6:a03:45f::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 32852570-8559-4968-1d0e-08dd08b3fbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVKbkxYNWJaUGRDdDNHNndjZFhhSVhyZytwTHptZHJYVzg3VS9BWW8wZEY4?=
 =?utf-8?B?RlUvRlYrT20vUjdTU3NaUzhVZ2FabW9UZEJCcFI5UHdMbzh5MzVYaGNoemVx?=
 =?utf-8?B?eE91ZVVxWEJpUEY0UDBuT2pLZS8xWjJxdDcrbjBUQW1vblcwdmNISkZZbVlq?=
 =?utf-8?B?andtaEVZNFdZc29VcGk2bmRSbGQ0QXFVdkhaK2xiem9OSmx4aTBUSGZDTDk0?=
 =?utf-8?B?YzY3K3MwMlZhVXFNZHZKOE1xSDRETTZpTGRSTS9lSUJLcTcwQW9XZFBrdzJK?=
 =?utf-8?B?VnljblR5Z3phRnd1ZzJCbHRDRUdxOTdXRjlYNC8xZzZpNmlmUy9Ya0tlTmZ0?=
 =?utf-8?B?YzViWVpGMCtiME1pc21HY2dtdXVaYWlURGttTnNNOHk4alBpdDF5SDB0dnhC?=
 =?utf-8?B?M0ZPL2NwVU8wQ29GL3E5Sm5qd3gyajFVMjlqWldlVWNTOWEwNmRNNTg2a2ZF?=
 =?utf-8?B?Q3Z1M21Bd3N6YStTMTRScGdtSU5WcU8yRlFSSmttRTdETXd6Q3ZwaEg3WDYv?=
 =?utf-8?B?R3A4OU1sOVRuaVJhQmRGNzY0eE56K1c3L1E2Z1FEbWppV1lwN0ZnVUtTaEdo?=
 =?utf-8?B?c0YrTmY5bmx5aENTR2lvUW84RmhYQkxUYzg2YUx6VHBUR1JEUkxLOFU0RlBV?=
 =?utf-8?B?d3E4M1ZhamNVaU12K2FhSGs5b25oWFFIY0NDNkt2a0Nnc0p1Wjk5RHdNb3NF?=
 =?utf-8?B?ZGZ0UXhHSCtVa3dQS28xOVVlRDVwa3U1Q1czQ05ReWIwR3hxK3UxNUdseGc4?=
 =?utf-8?B?Rk5MaHdMWDkxaUlCTllHUlBkbk5RazlVNU1MTExPT0JKTTUraFRFMVNaTGIr?=
 =?utf-8?B?MXlrRnpZMWVFUmhQeWMxMnF1ZlBzVWNhYi9iU3M0UGs3bGtaQ1VsQ1hOY2Jr?=
 =?utf-8?B?QjNXUTdjSTFicFFkTDBpbWlnUWUxWndTeGkzblQxTUVoM3NJaENSYlo5NDcr?=
 =?utf-8?B?MTc3N2todk5jdHI1MWFMdDg4N3VmQUQ1OHgxems0MmJZd3Z4cWxjT24yWTBz?=
 =?utf-8?B?L1J3SDN3ZXo4T3Vvam1xazhHQ2d2QzZpRHlBblBYYjRtWFJTa2o4VnlXaGEz?=
 =?utf-8?B?dll6c0M0eFJnWlRQRENvL0FRYTBOdE9LMWF2WkRsY3F2VHh3VlVBMjFDT1pJ?=
 =?utf-8?B?N0xoMS9Ud2lWMzFzSXo4MEZrRGRNOTNHZFpxU1VWMExpT2krV3NXdjRqdE1L?=
 =?utf-8?B?QW5GQkVVVkN6THhrUDMySmd5WFhMY1g1dWRzN3VpRW10WEFCNWdkZGZlZlBO?=
 =?utf-8?B?VGczQlRtcGsxTHc5MWx2QnE1YzFlQzBCeGo3QlpJdTZjU2YxTGtNNmN5dVNR?=
 =?utf-8?B?bzljam9RYndkRFpDT29MckRSVS9JeHg5YVRyZzc4UEtlQU1BcXFIMlpaNmV3?=
 =?utf-8?B?VEFvSjBOcXJGL1ltUXRFWGRlbEdERFVNaXFDdHRmM2JHYkErcTdoVnJhZGZ3?=
 =?utf-8?B?a0xja2J1QWZJempteVpIZmpsZkZYM21KNHBtR0lpWkZsaUNyZnVUczdCaExh?=
 =?utf-8?B?REJIS3VCc0ppaDkwbGhpdVIrMU5TTzBocEl1czBsdExjTzB4NGtlZlZsN1ZL?=
 =?utf-8?B?OVpsNFl2Z1cxVWlBaFRuTEJIRGoxM1cxL2d2ZXJ0cmcvZkFGWS9idTlCV0tD?=
 =?utf-8?B?SDdDWWhSZFhOZWlFNnNpNWtwSDl3R0VSYzhDNFdlZ2RlVUdENnJGaThrYjM2?=
 =?utf-8?Q?NdKAxvQqpt1pv1EZaY1o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFBqN0FPZ0N2SkpZdHJEV2lNTkR3ZUljVFpMaDBod3BrR0k0TWFmU25GVk5x?=
 =?utf-8?B?SmhmMHBZSDdWQXJDS0l3TE5DbjdEMFFDMUVMMjYwMTM3blNKbGlHVGpBRkli?=
 =?utf-8?B?cjU4a1RLRGZlYkgxL2RwRis4MWt3ZjRRakdKWDBnZ1EzSTVCTTlKcGxiZVZj?=
 =?utf-8?B?cHI0U2g4TXVTV3h5SzlUZm0zc0tKRTYxMlpjT1dVYTlTK1BUVHJiWWVycSsr?=
 =?utf-8?B?VXY0Y0lDRkZXdnVnVmtGYzV6dFB1aVNnaGFUQkNiR3Y4Z3gwdUJjc1NoWGp1?=
 =?utf-8?B?bXN1eEx3OEM5Unp2emt5ZFRTT3lpRnB4N2E5V2tVZzlCeVJ3Z0xIbVBBMWR2?=
 =?utf-8?B?RjZaVHZybFIzWnN0NXk2U0dLMkpjNWJmRVRzbUQwWjkvUzJrQ1JIZnU2UDZZ?=
 =?utf-8?B?R3ZvRGlVMG9IWENIQ3gzM1U0RWVHNnd3L0Fmbmc0ekV2WG1Xa3RHb1h4VEov?=
 =?utf-8?B?NkNjS0RXczFpYlV6ZHVUcFUzS1cxOUI4dThFMndKMVJTelBSamp6WmhKVHJq?=
 =?utf-8?B?cytuUFZlQ0lNZVNaRlJHYWFJUEE2S2R0VGszei9wcXBoSVpDRnlldHNjQ25m?=
 =?utf-8?B?K3ZFS2M3V2pkdVI4L01KWExjdmhYNDhWcVE5aUdQYVVsYXZSRE91NjVxdGUy?=
 =?utf-8?B?Q1NlWVlYUjlPRUZxR2Q2KzYxRHJoc0RmQ05UTlBUcHk0K3BRbGRsOHMwOTZI?=
 =?utf-8?B?WFJTdWZkVnJ5YmF3emhKYlhGUXhBVG1VMXJPZk9yYWk1OXg1RWJpSUZ3S0lK?=
 =?utf-8?B?eTQwYTRSckt5cngwTGQyN1NuUFJQVnhmVUVPSUhIS2pwY3ZyTEV6WkxJcVRB?=
 =?utf-8?B?cHRRRDBOQzhzQW1TcXVSZGdGRW5xbnUzVVQvRnVhdTdibHcyOWgvWGtKUmtt?=
 =?utf-8?B?cHZWWmVZcXU4YXQzSUVjQ3NXZnpydmZkT29WQi8vYWpISFBMTEZuTVhLSzNr?=
 =?utf-8?B?UEhmVzkzNlNBSERadWhvSit2cTE3aklLU1hFbVM5Q2hSZjI0UzNLQjdnempy?=
 =?utf-8?B?Q0RlMWxSeTRHbFVBWG1MSjBTWUtmbk5pcHNvbXhFQ2FpNndEOCs1ZzZVVDl4?=
 =?utf-8?B?em5mSTRzNnFSWnlvMnpOVkhqZGtqcGVGZi9rTUVlcTFxTXFpdWNYaUhwOWZx?=
 =?utf-8?B?aEY0Yk5aSS9rWlREbXFkaUVLNG8yL3Bnc1dTa1JyTmpXTFNGYTJNRWhydzAz?=
 =?utf-8?B?TVQySW1PanlnR3pndUVDcmg4d3NiS3laWXVzcitwdzVlK0NoZWJOcDFJaHNY?=
 =?utf-8?B?Z0hmRzZ0dStRUmJFVW05YVZWcUEzN3kvNVdESDYzVUJGeGhYSm4yZllRQlFv?=
 =?utf-8?B?ZWFyRVdKTEVIbFFldS8xYmhQeTE0disvRklYTTdGLytOZEF3VnJoZWVFeEUr?=
 =?utf-8?B?Sm04L1NVam8zUEZEQWptb2xvaU5NN2d3V3AxRE5KZ3pjZWtDMGNHL092bVNZ?=
 =?utf-8?B?azM1czNleEZQdTZLNUpiRVRJWGdoR3NTU2xiSWQvSTV6c0JzeGhwU3o0YzEx?=
 =?utf-8?B?cWlqTW5BU0FuUHFwTUE4S1lFTnRtWHFWbFgvYzlwSnVBMUJsL1V3OHNjUEdM?=
 =?utf-8?B?RGgvRVZnQ2ZLMEtScGVqczJpNTFWMEF6S0VsQkxOWWtITW1KbkMySlpaUWZh?=
 =?utf-8?B?UlZlMjZ6ZEN2dm9SZzRubWh2cEFtTVFFMSs2YXBsMFIxSzFKV1QwVDN4ZWhN?=
 =?utf-8?B?MkRQWitMZXEwV1VQKzhyTTFRV1RqS2k4YzBWamF2allrUXBuamVqazhseVN2?=
 =?utf-8?B?SEJ2cEkyaC9SSi8yQVJyRFQxaFdaU3Axa09rYTVkVmU2K29mZjhOck5INjlF?=
 =?utf-8?B?OFExZEd4c2JEWVE4cHJHeExaNUtYN0lUKytaaXZKeGsxczdFYnVNQndRNUli?=
 =?utf-8?B?cXJPT3dQZFIwM21wVU9GckRrMW5zUXVOdTB6ekIyNEU2ZkRJbkZjS2V2WmFz?=
 =?utf-8?B?NC84ZkIrYSs4d3FmR21ZZUNMYUIvQnk1V0tzZVRmU2pXcXNNSWJCaTNxWnZ4?=
 =?utf-8?B?RldrZUxhU0tFZXR2d0ZEZVllSUNxYUpzT0U4TGpZSCtUQTJReVovczZranBR?=
 =?utf-8?B?VlBqMWYvS1JHd1NaR1gvQys4ZDZEWWFvdjd5Ykl5WHArS2pJYlR2c2hhODNH?=
 =?utf-8?Q?8yNMXQJLJIkKE75NzNVZ7fbTR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32852570-8559-4968-1d0e-08dd08b3fbe5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:05:29.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64mj4XAdmXV/KYOniVIpKjKqTz9XJAV/8Ecwzm/GRazuhd2TH0s/7azCLH3QJ0Cme980gOlfRvnGmk1o00q3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

On 11/19/2024 09:09, Gautham R. Shenoy wrote:
> Hello Rafael,
> 
> On Fri, Nov 15, 2024 at 10:00:25PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> After a previous change, cpuidle_play_dead(), which is the only caller
>> of idle state :enter_dead() callbacks, ignores their return values, so
>> they may as well be void.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
>> ---
>>
>> v1 -> v2: New patch
>>
>> Interestingly enough, the only user of :enter_dead() idle state callbacks
>> in the current mainline turns out to be ACPI idle.
> 
> For that matter, the only user of cpuidle_play_dead() is the
> native_play_dead(). Was that always the case?
> 
> Some of the other architectures select the deepest available idle
> state at boot time, and enter that state when a CPU is offlined.
> 
> In any case I am ok with this.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> --
> Thanks and Regards
> gautham.
>>
>> ---
>>   drivers/acpi/processor_idle.c |    7 ++-----
>>   include/linux/cpuidle.h       |    2 +-
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> Index: linux-pm/include/linux/cpuidle.h
>> ===================================================================
>> --- linux-pm.orig/include/linux/cpuidle.h
>> +++ linux-pm/include/linux/cpuidle.h
>> @@ -61,7 +61,7 @@ struct cpuidle_state {
>>   			struct cpuidle_driver *drv,
>>   			int index);
>>   
>> -	int (*enter_dead) (struct cpuidle_device *dev, int index);
>> +	void (*enter_dead) (struct cpuidle_device *dev, int index);
>>   
>>   	/*
>>   	 * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
>> Index: linux-pm/drivers/acpi/processor_idle.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/processor_idle.c
>> +++ linux-pm/drivers/acpi/processor_idle.c
>> @@ -578,7 +578,7 @@ static void __cpuidle acpi_idle_do_entry
>>    * @dev: the target CPU
>>    * @index: the index of suggested state
>>    */
>> -static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>> +static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>>   {
>>   	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>>   
>> @@ -591,11 +591,8 @@ static int acpi_idle_play_dead(struct cp
>>   		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>>   			io_idle(cx->address);
>>   		} else
>> -			return -ENODEV;
>> +			return;
>>   	}
>> -
>> -	/* Never reached */
>> -	return 0;
>>   }
>>   
>>   static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
>>
>>
>>


