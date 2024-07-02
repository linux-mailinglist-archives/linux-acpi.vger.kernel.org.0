Return-Path: <linux-acpi+bounces-6737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88109923E42
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 15:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0AAB22C69
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C84168C3F;
	Tue,  2 Jul 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b4BAr1dl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C06166311;
	Tue,  2 Jul 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925209; cv=fail; b=h4tHVsXscDMKRimkNDL61znykmi9LewckbqZ+3wc99UJzglFL8rRpTM46NqkNkMbBFFGHB5Aw2vhWwnEOOmj+mbZ6HAYia+I4sbmTtD40OaNrVJ+pmds0Phb5y7WXWuX0G95QZFTZD64TbjZTydK+BFYfLIFTt6cF0Nai7gxoGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925209; c=relaxed/simple;
	bh=XUJfsMCk/AjsXwSVTKuTMTY7Qw1nuQyqjil4SUbg49I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aSOJjTqIRpThIT9iLrwd3mRETgQAEXKB4uzLOGTuQXzDJ1N02agiWq7LA0/IoA8uOi4nhTcpRviVlq6nS3QGcWJLbmjZVvn2aI7JiIae5Dbvo3tMG3/u7AAnccsw/Jfk7DUSnvqC7kXNxRDTjtJYersFAtyCs/2WGTAzcHOeQQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b4BAr1dl; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emGc/jjqgUJFCRzhWXtmGwTUoca+FohLkSK4rDTpNJ+YVIUTx6yv9i3Jww+pf70rt+yYR/kXFgrqJD3/2xSsM4e6mJKpNgeigSgxKvlUp66LtFceFMxtix+y+mGjoeGdwCHk2Bj9P3450Rd/rya509TcKWOYEEKZTfcqooCbIBCVO8xvPbLXvn5MogJutX4qDGHlJQ1jPEzO+JER8vDfnaY1+3G/vUNn1AQcAYYZB2fhTD8cLMRhRspLmzywMC73oAeQQTHcDZjPDGpq04uk3UgD25Bx0OawBNz5/Ze680mqMla7QvIv4VgP8qNNzYXXlBogjwFNQsNYM94LpsVkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTTiR4eF1we/D2qmAlRCkmTLXXIraAULlNw1BbTvslo=;
 b=BXphjX5HFZPpCfbcruuoeyvfdvFzAXkxmAKWcOoWmi7mMIg8FpzX4mP7pae2MXmvEBPMPAB3EFCaiPGJFnCNdFtDRKYUJTt2ZzckUAiPIIgsmcH1Z0Fh4V2x6sfsjZFx3JJT3RGqPCoDQTkjq0srCSXwWFI36tddkR+6QYvTWua52v+TE65aJg3vDKdXosYSUZQJ6Id7enfqa5eSJGYazFPwt5Z79WlSaTrJIoxmKucvkgydmyMwc6dmA8e0OwJxZsOEZuaxqGd3V6VItbHvDlKH/NOxZcWssxogKoVWrcHACDHcrdSvvxjesVIHkF95+0JrazhK2rbhClsENP1t9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTTiR4eF1we/D2qmAlRCkmTLXXIraAULlNw1BbTvslo=;
 b=b4BAr1dlH1N6InVVvN1x/OeOJv9nLfYalNUJUTl11dRyuNNuFF+KdiZYbVgaFcuTs/7plveSgwApPeTTwT7rWgHJ6ch6Cvta/+xPrKL9iF7GlF/TZ5YHHEKdgRN9iezQybddsh/UURWmE2a9nc/K77Lbm37k0QhAOcwFTLQDvgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 13:00:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 13:00:02 +0000
Message-ID: <c2c9fcc6-6b72-4225-a66b-8172ab8ddbab@amd.com>
Date: Tue, 2 Jul 2024 07:59:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
To: Julian Sikorski <belegdol@gmail.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, rafael@kernel.org
Cc: lenb@kernel.org, akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 alexdeucher@gmail.com, regressions@leemhuis.info,
 linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
 <20240701205639.117194-1-visitorckw@gmail.com>
 <81aa100e-044c-4ea8-a2ff-cd34711e137e@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <81aa100e-044c-4ea8-a2ff-cd34711e137e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:806:126::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa2e87b-238c-42f9-699a-08dc9a96e2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUl4aEJDRVYxYXVhZDVyMkppdzB1V0lhOE9MY0NuU2ZVR0pHVWc5MTBrR2Rw?=
 =?utf-8?B?SGEyaGFPVi9Na3Jmb3ZLZklLc2s3MG8zSHl4czE4ckJpQmJDOVFxSDZHVkQr?=
 =?utf-8?B?SWpUQmJ0R1JNb2tnVkxCZ3VNeXNObG9LTTNOOERJemprWS9nRHpRWU9mM1M3?=
 =?utf-8?B?bTdpTlFET1FyNG1FdkcrVGJ2QXlTY3kxSnRMRy9WNnBlNVZLQUo3TmxWTkhC?=
 =?utf-8?B?VVVIaXpCL2pZZU5QWDVtcWJSNDlndmlTRi9rdmNrbHF6VHErZkF4TU13NkY1?=
 =?utf-8?B?SWp2TjRuRlU3NUtGQUV1a0JTWXdUdUdVK2ppMjdMVm1EQnlYSWdLNTU4cWs5?=
 =?utf-8?B?U3NOM0ljU2J5S2sydlk1a2hOaWV6YjgwMzZsL25vMFl1MCt3aVlzZUdWUWlR?=
 =?utf-8?B?ZXY0RUYwM21wV25laXptcVpHZ1dXalFaY2ZMUlh5eERLVUtTbG1EaDRpTVMw?=
 =?utf-8?B?dk1RL1lZTUE2YUw5eFVjMjZXQzNqRWhQRUYzS1lsdFVGbGFsMkw4L2FOc0Jo?=
 =?utf-8?B?QkJzbEJzbWsvR2JBVFE1R0ExQjVuWG5JRHkxaGxFWHh0NDVRbldDR2RYa3Rk?=
 =?utf-8?B?N0lydWtnVDloMzY0emcrWnkvMCt3SytuNVQyU1VNbkk2UDE4cTVDNWVOQ2lN?=
 =?utf-8?B?dit6a1lkTTVlYjlnMm5IQkZLTGFya1JjKzc4NFAyQ01VUEE2Y0VML0R3SjVk?=
 =?utf-8?B?RjJWUzhDbjFQWG9iTGJJaU5rUEQ5VjlRbG45eGlDOG1aQUVzbGt3MFJvRjZB?=
 =?utf-8?B?OEl0OXRFSlhPd0xUT1BXSTlXV0FZZVJLTExad3d2eDRWaU1PUzMrbmdUdTRw?=
 =?utf-8?B?bmlVajFLZjB5NmRleWZkaXQzRGxEMnhFSHZrYVN2ZWVFZ29rQ3JaTzVOV0Fs?=
 =?utf-8?B?Q1lic1JBem80UFlVdlVqOWtsNlZrTEpGd3ZjajBBdlo3VHJkM1hDRjU1RWNx?=
 =?utf-8?B?OVQvWEl6TVoxclJVVFVvTmVSTGlLMSt3VzBFZWFNU3ovS1dUOXNrcDhBWmxP?=
 =?utf-8?B?MStEWkJYcWsrWHNsUVprTDZzM0Zzc1BVd2NWY1phb3VKR3N1THJMYmxGaXpQ?=
 =?utf-8?B?bjc4azJsKzRkVTdZUCtGY1lEL0J6RitVclVsWTZ5eXNrUTcyNmNsOG1HVWMr?=
 =?utf-8?B?T0FUTHk4ZFFLOXl5R3ZkZVFtOWlvVWhENjVQbnlIeld3VTZEdUplMlY0Q0N6?=
 =?utf-8?B?T0lXWWE2ZXhOVVJ2eks0blF3blhCVjBoRG5NcDVJUjMveFVtMi8wc1NHakJN?=
 =?utf-8?B?WWp1NDc0d2JjbHJBSHdwdWlUMEJRQnNxUU1vMFFHcGpLdEMvd0xHdGxsMGRo?=
 =?utf-8?B?WllFNnQzOXNRZWpHbCt1RE5vUm1WdWVPNGJpZ3FwMWdNZXFFZVdJdHBhQXgr?=
 =?utf-8?B?N0RyMnlxWEEvenNlMDdUc2ZuMGNyU2lQWjNyckNSUEdCK1ZmVU4xNW9BenNs?=
 =?utf-8?B?NzJSdXhudE1tRjlwS25la1VSZ05MOHRZeUV6bkw3K3EzcXd5ZmkwczdsQjQy?=
 =?utf-8?B?NzBGUDdIUHdQek90ZTE2bnJTdkdHRWRaRUY0MHJJaDMyZFNzUTA0M2NmK0Zq?=
 =?utf-8?B?WUdTYWF5TFFQN3ZscXZraG8wdWxsbTN5cDR5Smo5WUwyTHJDNU1BL3QxTjVk?=
 =?utf-8?B?L2VHVnJhd2h6UzRnbTVIUWE2U0Z4QXZVYzVCcGg1NksvTVdMUXJWOXRVV0li?=
 =?utf-8?B?Y1FNMjlOQU8xaFVsS3lLZks5M0doUmN0MjlmemZPUXpiNFJEaUhDbXR3VFli?=
 =?utf-8?Q?hE8q/+/sFsp6t+49wA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVBKRTc3V2x0T0cyZmdDK2xOK2xmcXZqRm15LzJDdzByOVBNZlBuM0dqWXFM?=
 =?utf-8?B?REZuWlh6WHdxaDMyRGE3aDB4VEFGaGppc3NTM2ZmYjY2SVJTU3lqbDl4UUs2?=
 =?utf-8?B?emNTbHlwY3RYbDNyUWM5M3lSbVE0c1hhQ0VZWDRwVHVjME4ybCtaVzBkdG9C?=
 =?utf-8?B?eWM1YXp1S3pFWTFtazRNaUhwMlR1YVg1cnRVUElCL1hYRmZPandNN3pMclFR?=
 =?utf-8?B?bWlJNkRwMXZSY0EzOElaVWs5V2J0MGNJOTdWWDdydEpmL3RyYU5rTkZZRmxX?=
 =?utf-8?B?d1RYYzBlVS9IN2RZT29xWGhHRXM4SWRiOGdkVG9TWmFTTmlxK21MNnEvTTZv?=
 =?utf-8?B?MnVydmlNZm1ibk5seXplOUtwc0hkZ3c2Zk9rL3NGajJBRzI1ZFVBNFArc1Jm?=
 =?utf-8?B?ZFFBNFhremYwKzFWU2IwdlE1ZnAvYXdteXU3VHlONHFRTzRVMERQTlVZdTJ3?=
 =?utf-8?B?M0xvdmlGWDJPblRDNTFYR2lrTElsY0d2cGwxUU9MQ3NKdm50dWdENU9VcXVG?=
 =?utf-8?B?ODBPS3c5MFFYa1l6eE9RSHRjRXVLd0p4QmNjSFRKNzlwRU1vY1ZzN09xam1L?=
 =?utf-8?B?V2g1ZjUza25lQjZlSWhrNXRoTE1nUkVZOFBvVjJXdlFoWVc3QVJxSjZBVm1C?=
 =?utf-8?B?RXI5OEZJaFhZRlUxUEl1TU9CNGZRMXZjUlQzY20rY281SlJFOE5VTUI1NVFy?=
 =?utf-8?B?TmZKTHhYY2ZlNHhMUWlXelFBRm9USDNVMWNhVWdTWTB3ZTAyYzJOeWg2Vm42?=
 =?utf-8?B?a0JYS0xTR1UwNWY4TnRQYTZBSmNpb3E0L3lCOWZRUklrZGNYUzRJRzMxYlY1?=
 =?utf-8?B?WlBheVNXb04wUGlhWXVmRWhTNVVtVnB3VGNtYk1DL3Z4d1Z0S2lmdDRRZTls?=
 =?utf-8?B?ZDhiRmtsNEFRaTFBSlFUN2Z5MVJwR25HYm9TSENsZXVVNmxXN2Z2MTEyNjBH?=
 =?utf-8?B?SHUvQmFzdHVzcGZuZmNGbThJK2pQUmVoRUNENkxSV3NXeWJZL2pNWFdGcktI?=
 =?utf-8?B?UlJTaGVxOWJtZVl2RXBadUY4NXN3cndJQXlmWWtDYm5sUHRCZDFMSHBUd3dJ?=
 =?utf-8?B?MjBEWVNlR3d5RjhSWklHWVRBeW9BNGpvUzg4dzB4cTdwOUdLd252LzVLa252?=
 =?utf-8?B?SHJSdG5zZTRmM2R2NC83RzZsRmpNdU5qQVhQdFNkZkx2enNIRkJSMWt4Sm5P?=
 =?utf-8?B?TUtYUUxiTWg4UGw3Q0JqTFd6cXJGb1VIWHdlUlQxWXBzaGdpbnVQSGpwMlMr?=
 =?utf-8?B?TnREaWVRaFJSeDR6dGNpYlhuQ254S3lxN3BMOVJqRFlFRHd5T2RBL0pqUGhT?=
 =?utf-8?B?NU1BLzRsSjNHWGFjWDlFbTVoSTlabjNiNnR3ZUpnQWorVkpMMFI3bkUvRzVQ?=
 =?utf-8?B?aWJDRG9sMVZWVUtiZlQvMXhvYkd2cS9LajlpRERUMFJDaGlLa2R3NWVZQjg1?=
 =?utf-8?B?V0NYTDNrY0hieFRzU2VlWUxaUGZqeVBhZ0c1MFI4VDdUa3JUaTNPVzZJR3FR?=
 =?utf-8?B?WmNOTWpManlSUjlBdXR5Zm0xazJDT0tuWFRqd0RSMXVvdkE5S1VCNlh5MXdT?=
 =?utf-8?B?QWlUak9NcDhXcW9NZ24vQVVIc3grc2g4bWRob3BKenpWSEdKQ1dyUDBnQXkz?=
 =?utf-8?B?NHZhQnVZbExtemJnTFM4eEtpZUFFcThtMHN3b1hlYTR0bGd1LzJkMEYyWGo2?=
 =?utf-8?B?KzAydHFjSnBvdjl0ZEFUZGdvNmwybVE5eUk2T21HNlE3TEQ1ZC9lY0RoSU4z?=
 =?utf-8?B?Z3p6cTdHaUtSQ1Y1MHBBTjRBQXhuTWVlZjFaYytOL28yQTEzSnFIN296YzVj?=
 =?utf-8?B?TGxWMmZweEpNZGNUVWRzQkh4SGUxUDBqRFZpS2JDbVFwVGhoTktaMGhzWGhU?=
 =?utf-8?B?eWx0MDA1TFFxQndSK2FXb3Q4QVlLRUppeldESVlENWJDcDN4bXozNUE5enhY?=
 =?utf-8?B?UGxsSTFTbzdZazNjWUZDMkxWbytBNEQwL0NBSjl2WkpKanVDUm5laEtzVmlS?=
 =?utf-8?B?aTdkbVJoYUNOc1kxL1ltQm83cGRlbGw3YWpEaEVJN3FVRjZBUHJvWENURzR5?=
 =?utf-8?B?TXVsT0pLQXFXVFZydWZwRWtOdzNFYWZBOXMySlpsRlM1UkFnV0dPRTRZT0N4?=
 =?utf-8?Q?iDHi6hxi/8pxW9hkzVmRQ+P+5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa2e87b-238c-42f9-699a-08dc9a96e2f8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:00:02.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8SfrUsZIl1DohWXukzZUAJtEOPwyJW9DA9myOQRCC/sABcKqzGw3DYtGtoOoWgdlKtIY7busvmiUTHc6jL89A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

On 7/2/2024 2:28, Julian Sikorski wrote:
> Am 01.07.24 um 22:56 schrieb Kuan-Wei Chiu:
>> The acpi_cst_latency_cmp comparison function currently used for sorting
>> C-state latencies does not satisfy transitivity, causing incorrect
>> sorting results. Specifically, if there are two valid acpi_processor_cx
>> elements A and B and one invalid element C, it may occur that A < B,
>> A = C, and B = C. Sorting algorithms assume that if A < B and A = C,
>> then C < B, leading to incorrect ordering.
>>
>> Given the small size of the array (<=8), we replace the library sort
>> function with a simple insertion sort that properly ignores invalid
>> elements and sorts valid ones based on latency. This change ensures
>> correct ordering of the C-state latencies.
>>
>> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if 
>> not ordered")
>> Cc: stable@vger.kernel.org
>> Reported-by: Julian Sikorski <belegdol@gmail.com>
>> Closes: 
>> https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>> ---
>> v3 -> v4:
>> - Rename the parameter 'arr' to 'states'.
>> - Add empty lines to enhance readability.
>>
>> Note: I only performed a build test and a simple unit test to ensure
>>        the latency of valid elements is correctly sorted in the randomly
>>        generated data.
>>
> 
> Hello,
> 
> thanks for the patch. I have tested this applied on top of Fedora 6.9.7 
> kernel on my Asus laptop and the message about suspend not reaching the 
> deepest state is gone. Thank you.

That's great news.

> I wonder whether this will also fix random S3 suspend issues I have been 
> seeing on my 5600x since 6.9 kernel too. I will definitely try.

Does your 5600x also sort C states?  You'll see message in the logs.  If 
so yes it could help.  If not; you probably will need to bisect that 
separately.

> 
> Best regards,
> Julian
> 
> Tested-by: Julian Sikorski <belegdol@gmail.com>
> 
>>   drivers/acpi/processor_idle.c | 37 +++++++++++++++--------------------
>>   1 file changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c 
>> b/drivers/acpi/processor_idle.c
>> index bd6a7857ce05..831fa4a12159 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -16,7 +16,6 @@
>>   #include <linux/acpi.h>
>>   #include <linux/dmi.h>
>>   #include <linux/sched.h>       /* need_resched() */
>> -#include <linux/sort.h>
>>   #include <linux/tick.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/cpu.h>
>> @@ -386,25 +385,24 @@ static void 
>> acpi_processor_power_verify_c3(struct acpi_processor *pr,
>>       acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>>   }
>> -static int acpi_cst_latency_cmp(const void *a, const void *b)
>> +static void acpi_cst_latency_sort(struct acpi_processor_cx *states, 
>> size_t length)
>>   {
>> -    const struct acpi_processor_cx *x = a, *y = b;
>> +    int i, j, k;
>> -    if (!(x->valid && y->valid))
>> -        return 0;
>> -    if (x->latency > y->latency)
>> -        return 1;
>> -    if (x->latency < y->latency)
>> -        return -1;
>> -    return 0;
>> -}
>> -static void acpi_cst_latency_swap(void *a, void *b, int n)
>> -{
>> -    struct acpi_processor_cx *x = a, *y = b;
>> +    for (i = 1; i < length; i++) {
>> +        if (!states[i].valid)
>> +            continue;
>> -    if (!(x->valid && y->valid))
>> -        return;
>> -    swap(x->latency, y->latency);
>> +        for (j = i - 1, k = i; j >= 0; j--) {
>> +            if (!states[j].valid)
>> +                continue;
>> +
>> +            if (states[j].latency > states[k].latency)
>> +                swap(states[j].latency, states[k].latency);
>> +
>> +            k = j;
>> +        }
>> +    }
>>   }
>>   static int acpi_processor_power_verify(struct acpi_processor *pr)
>> @@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct 
>> acpi_processor *pr)
>>       if (buggy_latency) {
>>           pr_notice("FW issue: working around C-state latencies out of 
>> order\n");
>> -        sort(&pr->power.states[1], max_cstate,
>> -             sizeof(struct acpi_processor_cx),
>> -             acpi_cst_latency_cmp,
>> -             acpi_cst_latency_swap);
>> +        acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>>       }
>>       lapic_timer_propagate_broadcast(pr);
> 


