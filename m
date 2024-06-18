Return-Path: <linux-acpi+bounces-6498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF290DBA5
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16021F2240E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529415E5CC;
	Tue, 18 Jun 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LcVYjlBn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638A2139C6;
	Tue, 18 Jun 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735767; cv=fail; b=P6vF8KwFXWnuteoWd3bPYsGtSTR+vMoZMrKMzdljzDPJDjSu9A4eggwl87m9iGLlKx/uSqt7/BVHapafcdoZozZzXFjZCNDyLn09PAhjgZg5QMMRfFQm6lM3/+aIgcswJBdyqjIKxEHNW9O3Ij243GKHyNJLbAf5lF2DdIJsEaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735767; c=relaxed/simple;
	bh=Ixz5YO/mzJtZDihoKhzHcIBG86Z3xegxykYmjFwAH2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NuLWbEjTI30iKnDTD/bpIosNWYnXPF4KdvnD+qCT4VqZBDfduEwgPP0HipSA4SkgZSBI0NgiLyHzVR4ctrsfcKb4e5Y8s7ia5v+LuZZNJC9ZE3nGDpTaj2FOUzrnwUMsBAfDmmlt2eqXRDwGG9g60Xot+Y9Thf6vPnrNmaRTErA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LcVYjlBn; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pet+wxXzMha+j5JIM65qVwQXcm8zw9hGg60TzJOpkiUUNutUWx2rpQd67a3HJGKG5U9mYKVV3f+fs4O4/y2uBcjFI+vM3VX4EBPkjTqfTtgE9jze3ax7Hb/5SzD/fuW3t0AJcoVFIndcrMLd7Yq3+XnNIe0AkycDOGSw585UdfKhu1tyylzqkFbtI/Eh4sY+DJ1akxBRq/8+BtsBjobIpeep4S5n1I1jHs5KBR7cnAHD+qrgVSX3nEH7+JY6eVNTaNZkhcW3uTxQ7oPAwXnXqTBTPqUFeQRcgxsJrU2gYGIBZevJmpNIdj9mVJso64vQP493b+EqBrVC16i1ug/Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWBmVmmO93tXYIArE6rWVx5aHrtcV9C0QvaRmZencrA=;
 b=I9f8RHNdy4OcxTDRDQztD9pn5l9kZm4PndDzO0uW9GS3fjVOq8dHF4lfZmErfXIZLKDQCWXb8iinfV43HR7dSDr08W0OVXFxUVH3zrXL9OJe4nkqh4+pzq+Q4Af6bOIHHWCJknXuEYVaAP7sVuTw7JKu9g0ZC/XAJt9bWF6hdLUhmRG7bbh0vXhtzwsvvhp+Tn56jFc0YNYvToXXRIW/zsovPOpDxVx5SQSPyUZ3UBzY2m3Oz+DtrR34hBf+GSQnYCk1S/TGIL242xaXWV7yMBIm3MgnIPOd1HUTOTD6JPy1KniGfvRFyJ5J5hp2JRwLalkumtiiSsd+a5VpT3JV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWBmVmmO93tXYIArE6rWVx5aHrtcV9C0QvaRmZencrA=;
 b=LcVYjlBndP3k63xI5VPvgT83nodv8v6N842NLIQ1ZT7lKcsVNBm0xDtdvudfR1LoR7zCpqdORb/Vv13m4LmKM6BWstTXwhSR8KENrxfjCdnq1GuNMy4e44qw39ISVqiiaR+7BrXc+rcd/l+4I6aRKA+Qljc0DWzEall4zHmK5iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:35:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 18:35:59 +0000
Message-ID: <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
Date: Tue, 18 Jun 2024 13:35:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnHSKiaYf2tIQo58@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnHSKiaYf2tIQo58@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:805:66::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae69fd9-6869-435a-5c6b-08dc8fc57fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWI0L2xQK01FTmwrQjZtK1ZnZ0R3L2s0SlZ4MDQ5UU8zTzZZMHgycVB1RnJq?=
 =?utf-8?B?cktqcmViNi9qaUhnL0tPT0k0Vk9zMkI1NkF3TWZDMEkvQUhkdDNqQVg4YXdS?=
 =?utf-8?B?T0RWekIyZm9IeFFoajN0WlJVMDljV0tmZUpoV2U3L01PMmhnNzhOZFRMZ1Zm?=
 =?utf-8?B?RTRUMGZQZWFuSmlENS8wS284VzI4ejZMcEhFOUdRb3hYc3VWamVXZS9BOVNR?=
 =?utf-8?B?VERGTHlSZDE3UitLdjZKZ3JaZXdMMzVpWUJYb24yZlZLT1BiaSthM2h5WGt4?=
 =?utf-8?B?WGpXNkRuTzhKbEkrMDcrV0luNW4rZTZ2N1Y0L1hyemdtdEFyNCtLMnRXc1JB?=
 =?utf-8?B?ak53QzgvSUl5cVhGUUhGZExTS3AzRlh1UG10KzVMaXhVNE8yS2xjN1VjanpH?=
 =?utf-8?B?SmdZUjJqeWVsOXFHbUcrZ0JXSDZvbTJLUDhLMmpGS2hkaHFrVWYwb2tiTk5w?=
 =?utf-8?B?NVgvU2FUMGNPOXZvUmgwZFlRREQzbUxPa0pyMWoxQU01TWZmZWhrUko4Zjla?=
 =?utf-8?B?NVZkR1ppRm1STHNpcUdFQ2pyY09TLzFFYnl5U2Fmem5PTldsM1gxdEo4L3RN?=
 =?utf-8?B?K2g5cGU4UmpVbG41ZU1UdWIxVGtDOTBnaUw3c0dZUXFhSVhJSWtPUDhsMHg0?=
 =?utf-8?B?THNKdFpBbG9WZzRDbjc0TU1SSHhWNVRSLytnZ2xzZ2xHd3hqcmRMU3hnQjY1?=
 =?utf-8?B?YXYyLy92VG1TU3FhS2lzcGxWT0pONlFOL1U4SjROdHhPN05ESDhlT1BBandO?=
 =?utf-8?B?TWlacHp5K2E0N3E1dTY3U0pJbU1EdXZCN3FNMHF6QmhPVGNUZzJNTHVrSm9w?=
 =?utf-8?B?cHBTQ2VXaDFoWk44eEh2SGNic2Z0OVkrYlAzdnpSQmFycUZncjdhcGQvendq?=
 =?utf-8?B?K0hDaklUYjV1WVF2cUY2aEIyU2Vqa0NhZ3FYUzZkeUt3RmZHNU1WV0NXU013?=
 =?utf-8?B?eFZhdGxRenJhL0RNL2x0c3JiZU9hb0lIcUZUTDdTRG1aWkt5RWxjTUdLdlB6?=
 =?utf-8?B?bm1uVHRRK3ZPZVVRUnk2Qk5GZTR0azI0S1YxK1YvaUp4UitNSFVTek94Y0xv?=
 =?utf-8?B?TmtPUlZYU1phRGdrSW9VenUyTTVtcTZ3YU9MeTEyT1k5WmpjOWdPSFNjSExF?=
 =?utf-8?B?M2xONVNoS0hVblRKOVQzSnlPNUxFM1QwUHdHMmRKZWNKdDVDZkZQSUJXVDJ5?=
 =?utf-8?B?ZFgyeDJMMlcyaldwV0RIb01uOVhrYllyc2hLem5FMHhLcTIwNGg5MUFlYlk4?=
 =?utf-8?B?WjNpRXBZNGtZdThDaVU0L0pCZDF6TjlVRWg3NHRpc3dZbFlBMk9vM3R2dFpj?=
 =?utf-8?B?bmdwMWJMNU16eUJ2U0FJY0U1VmxtVmRxdEtHZkFWNjl6alFsT21ySytTZUM4?=
 =?utf-8?B?TTVtbDRCQnVwck9uVjdYOVRKU21sa1hrUkVqelR6c0tqVDZYNDJxL2drdUhw?=
 =?utf-8?B?U1BwVFNOVkVzTmxqMFdPRlV3ZXl5a0N5eUgwR2IzYWVpV2xGVWlWaTFBY0lp?=
 =?utf-8?B?RVlqU0o0M1A1R1oyZTFQNVZNZHR3eHh1cEtNd0hlcXJKek1Ja2huMkhHbEZa?=
 =?utf-8?B?S2VOV0FSTDhQMmlLMGNuSWNaYjJySTZjTUVCdVBBK0ZDWGtaa0JnUFpFd2ZL?=
 =?utf-8?B?SHdWZC9sMFpjdFZrYnN4UmVHcG1DYlhtVTZxcXhwSnRaQkQ3QTlIdkpRbUZs?=
 =?utf-8?Q?RAijmdkSaS82Z1UXXsUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnU3ckZBYjNVQ3IyM2ZNdG84cHd3OGpmeUY4Z3FKS01ZZGpPdHc0SmFINmtY?=
 =?utf-8?B?QWUyV0JySy9jUmZqMS9uRnZXUDNZemxsYklVYTZ6Yi8rWUxMd05yRXhMd2hn?=
 =?utf-8?B?R09NMUxvU3NNSnVBNkU4Rk5xVnU0Y2tySGJLOFl5RlBub0EzTTV1UHFVZmR2?=
 =?utf-8?B?aS9PeHdPQ01rUk9LY0txeFpTOUtEazlZVnplaFNTYmtXZ0MvK2gvZUEza1dH?=
 =?utf-8?B?RUpCbFFPNkM1Q3FFcnE5UEtkZjdPa2hWZmI4VDcvNEs4TmZqanVRS3lhQlpE?=
 =?utf-8?B?RkhxT1FDeEtybmxJWUh5SVZ6VlB0RStYYWl0WkdFdVNHUzdiTDNKVnc2U0M1?=
 =?utf-8?B?bzUxbmo3Zm1BaVdyZlh1ZDYrNUhyUzRwemxaSUNOZW41UTg5Szhhb2tNTGVN?=
 =?utf-8?B?SGppczFHWk4vQnprMXhVTng3MlZEb3ZlWEUrcEtZWE1CNkx5YXdQN2ZlV3dK?=
 =?utf-8?B?NnhDQWlIaUlzR3BFQjlXdGMxMGJnSEh0UHZlYmtZb1FEald6T0VBVlVpYThl?=
 =?utf-8?B?MzBjNnJrWVJ2LzNDMWxUZWs5ak9vbUJWZ1BUdDJaQmZ6UHFHZEMrejlGUVA5?=
 =?utf-8?B?a2ZaY3hvMlRDaE1IR0FJMWswR3ZJbTVWY2JqNStheVMwV3NuQXZTSXo1MFNY?=
 =?utf-8?B?aXN6aUZrdUY5Wnp5NkVkK3hlY2x1eHdpMlhMM1JUT2l1NTI1Z0htMkhIcXlx?=
 =?utf-8?B?YXlmME9INGFHQXhHaGNQcnQ1UHBPTDlveGUxK2g0ZXNlUENZRDlwYUFoVEQy?=
 =?utf-8?B?Sko4TDUzOEtRQXl3aXoyY2ExTm42Q29McG10S2JEYjkvL1N6RHZCYW1rbENO?=
 =?utf-8?B?ejlqbytnQjZqR1AyeGp0WEdaVjRXSXl6L0IrNkZwTkt0Z3N4aFdNK05FU2Qx?=
 =?utf-8?B?UWw1cGltdHFEWlBWMjdYY1o5NXFmbnp3aURtYUNLR3IyM3FXRzJlMWhMNmxX?=
 =?utf-8?B?TDlHdWcyRE9BNmVuQ2xwU2JiSUlvYWs0N2VaeUQ4dk9PYkcrTFBNUWp2ZEpM?=
 =?utf-8?B?Q2RzWUF6M0tFSHdiVnE2a2w0cGNUcG9ObVpzc2oxL1hRWm1NOWp4U0RWVXBu?=
 =?utf-8?B?MXgrTEx5UVI4WitYU0FnMWdLeFp3SVc5Sy9oVmhhOFhmWkVnQ0lYWW8zNm1B?=
 =?utf-8?B?bnJ2VnNYNm9ucHE4c3JkUnRDSVB3dWFBZnJFU1lzbFVXQTJ2MFVDb2JYT2Z1?=
 =?utf-8?B?NTRjdHVQOWUzZWJPaXNDYmg3SVpTSHJnNDd3UWhIQklobDhEbGt3L2hBbExm?=
 =?utf-8?B?T1kvVzMxSmN5cTFjMDh5TGJyaFZrM2FIVFJPOTc3V1hyN2NCZ2M0RXRad3do?=
 =?utf-8?B?ZEFESGlQclBhTmJMZ25lTmU2SEhhOU5TOUVrTmE1Wk5iY3o4Q3hrYmNKSDlN?=
 =?utf-8?B?WkJubkx5MzF3dmZXWWZrUVpNNDB5T1EwelhXbnl3NC8rcjc4cmhEd2M3bnk5?=
 =?utf-8?B?VnZReHp0clJZdnJNeVlqU3dxUHJKeE16ai9Bb3IwS1BubFNuVWxZSDhLajFv?=
 =?utf-8?B?eVNBSTFJWHplUXFnTEFsR0xkdC9FenQ3cDFWZ1YrQkJIQUdPdEZZRWxGbDgw?=
 =?utf-8?B?T0N0QXdRcWxnN0JxN1lhRktYZGdwME1DUW92cFV6M3VFcGpDVGp2QVF4bGZU?=
 =?utf-8?B?M2ZWZ01xV2l3Q1YxVTJvVU8xeHo0aWg1em1uWTlnSVZiZFdCYkRpeDhUYUJm?=
 =?utf-8?B?VzJJa1g1QmxlUlVaUGs2ZytyMk9kdVkwN3puMlJLbHZLL3BkS2RaVHNrdGdp?=
 =?utf-8?B?YmI2MGx0SWRkZ0V2WlZucDdLejkxUWsrRDZqUkZYeXpCR1pJaDlCR1poS1BO?=
 =?utf-8?B?Uk9uRkRMUEV4bDByVGN2WXZxSEQwbHdGaVZONE9OVHlaTS9Kb3VVOERscHhl?=
 =?utf-8?B?eDg2VTZaR0ROVUVhbGNZVTFyNWlscU90R3ZKZmpGZFlQMk5wSFJwNHJtazNP?=
 =?utf-8?B?UjNDWHhYRHllUUhYQkJ2QS9qZy9BQnJTNFFnNlNSUllwMGlMOGpYUEZlOHd5?=
 =?utf-8?B?SHZIV3lXNTdwT2RkUUFjK1RwZFpySHNiazA3TDdtNCtmdmtNWkI1VDF0aHds?=
 =?utf-8?B?eXJnQS93WHpQRndkcVB1Y1Q4VHd3Yk44cHU1MkdaZUdhOXppYkhMM0dTSGdD?=
 =?utf-8?Q?gwADkCMYS/6DMXgMPAux4BiWl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae69fd9-6869-435a-5c6b-08dc8fc57fdc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:35:59.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6QJCR298ImEv6NffYbipt1kG4IJfKZeYwzY8vEzguj37jGpySMXtwXqLUCGFFxFHPao/A+CrVSgOPleabU67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On 6/18/2024 13:30, Aaron Rainbolt wrote:
> On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
>> On 6/17/2024 21:54, Aaron Rainbolt wrote:
>>> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
>>>
>>> The _OSC is supposed to contain a bit indicating whether the hardware
>>> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
>>> be considered absent. This results in severe single-core performance
>>> issues with the EEVDF scheduler.
>>>
>>> To work around this, provide a new kernel parameter,
>>> "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
>>> CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
>>> properly detected even if not "enabled" by _OSC, allowing users with
>>> problematic hardware to obtain decent single-core performance.
>>>
>>> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
>>> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
>>
>> This sounds like a platform bug and if we do accept a patch like this I
>> think we need a lot more documentation about the situation.
> 
> It is a platform bug, yes. See my previous email,
> https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
> (I meant to send this email as a reply to that one, but failed to do so.)
> 
>> Can you please share more information about your hardware:
>> 1) Manufacturer?
> 
> Carbon Systems, models Iridium 14 and Iridium 16.
> 
>> 2) CPU?
> 
> Intel Core i5-13500H.
> 
>> 3) Manufacturer firmware version?
> 
> The systems use an AMI BIOS with version N.1.10CAR01 according to
> dmidecode. This is the latest BIOS available from the manufacturer.
> 
>> 4) If it's AMD what's the AGESA version?
> 
> Both affected systems are Intel-based and use heterogenous cores, not AMD.
> 
>> And most importantly do you have the latest system firmware version from
>> your manufacturer?  If not; please upgrade that first.
> 
> We are using the latest firmware. (We're trying to work with the ODM to
> potentially get a firmware update, but since this affects more than just
> us and a firmware update may not be possible for everyone, this would
> likely be worth providing a kernel-level workaround for.)
> 
> I can easily provide more detailed information - would the full output of
> 'dmidecode' and 'acpidump' be useful?

Does your BIOS offer any options for these?

Intel(R) SpeedStep(TM)
Intel Speed Shift Technology(TM)

I believe you need those enabled for this to work properly.

