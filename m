Return-Path: <linux-acpi+bounces-9892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B69E0E3F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66625164F78
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3241DF73E;
	Mon,  2 Dec 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZ3dpy+v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CFA50;
	Mon,  2 Dec 2024 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176448; cv=fail; b=Y+46LwIpTOHm5zc/1rOL7ZmXmvzKDO4HEuusR6lKxCEhmsHjxZ8gRP3SowTbB7ReJ5SgI4Lokhv0ZGwFA7lnvjb6+lO0pdMLvaUKflC6NZSakw7CGpkepzRf3P/PjkzSmxRHboKfCbxknVT1BneK3giLYZ6SfZGGFJlB5rPStCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176448; c=relaxed/simple;
	bh=UPt9K+rZRbRESLO1MvoF3p2Bo4xTch80E9Huh9sOb40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=unmci2x3PLZooB01Qx3AVBboAlgusEbO/6zl4cYHfET4pHnJRPjuzfE5FPNtxh3CHOGZ8XgS92cMPNUykG+opqYEwZBFzIQTS+AfcsadlSsez+XjhCrcRTklV4l16TSF44lB/E1inBHtRvGSDSZ6PoOgxdfxsZfzSwhZHorkr5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZ3dpy+v; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCtp/6knZyHmvo/kPlAdWwCazVIoVD6yApBHPnLZUmqp8JmUB3aPCl+O4fTHSEVJolYfloXRfkCF9ANWfhYAtJIIIP8tfLse8OIjnPjMAECBhn4YSk88c21zFwmMf3kXmgEyWMTMp5ex0zt8JRGgKSv1GnSY6odAvbV+l7dlLLbDo+giWd1GRSP9QhCUcotPth9noJ21iUbSTcekNVnbCOYNz7XbQfBg6qlUuhPp20fIuzuEp0Cim6q3si9ux16Srz70zivF65SpfFeN+rxyRM/INPQwbbcLix+6GRZE1siMXQEjtPmqvhdUNkOE57lnYPDu8A8Al0cleQRE2GHwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnaEBmH7hzfS2SLWH17pShum0OTVnVW5YG4PLvMv2xA=;
 b=dNzaj2boA1ihdyc/WIILXr7uaqtd3vNxCFS69QjpeR/xc9u6Fn91JA1IfXoFN7GJgOUlxVnGsZGuUkC0toE4csmjjKUlY3vrCw+J2RlowaQ9PxOHDY3lg848ZGQlno0hZ3NX8MsICoWhahtu+KTXZ/wE2mn3GjsT/pOEwPR87XvTcPrZdGfMsu9rHS/S4WYJPjUJrVu11qBCgoPrOKwTIHstfbGikzh3MKguTsaBpxfusWX1aozeAbQobYP7X5rNky+ityNyGQXh/9I/yYlmtISsxBzp6KP+Fd4KJJf2qJ6nNfcIIdsa2ppdeb0iuMczEXlrCGq41FcadtS9iSOw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnaEBmH7hzfS2SLWH17pShum0OTVnVW5YG4PLvMv2xA=;
 b=qZ3dpy+vedZ3yZJjQs+ggCQMQecWjKMSPpc9PXrnQD7rXr0pKCIp6FH+gNYnhvM1Xi+njV4d6B6eCNdyp5t1sPUfmxFJp+eEwiUipX5TkxBjQrDMz3giDHhkXDh2oblSBGm7dRPv+aXcyqTzzyOeKK/etmkVfEbvmw4MENUdy2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 21:54:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 21:54:02 +0000
Message-ID: <35873f78-4935-492e-a9fe-ef06c1b2d0f4@amd.com>
Date: Mon, 2 Dec 2024 15:54:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in
 acpi_os_sleep()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <5839859.DvuYhMxLoT@rjwysocki.net>
 <e7ac7561-f9ff-406a-b2d7-6d9e31ed6e98@amd.com>
 <CAJZ5v0jTxBt8+bc+EgUZmE84N+Vok_aM16D8HyLQUv=BSoqRCw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jTxBt8+bc+EgUZmE84N+Vok_aM16D8HyLQUv=BSoqRCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 95140e06-2c4c-4a3b-7871-08dd131bd5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2xyYmFkWnZIL2paMVpxWWlZTFJ5YStFWmwzVm1yTDNnSE9kVERBcmFGN215?=
 =?utf-8?B?SHdCMUdTQjJRRldYR3dSaTZiWUQ5ZHg0aE9tS1UxS2lwbU15UTZvR2ZCS3Qx?=
 =?utf-8?B?Slp3RUlieUl5V0RBcnBiR05peDFnY3UrOHgwTFVtMFU5amFaTElvWDVqWmhq?=
 =?utf-8?B?a1pxcGpXWjdkS21ONTNSZlc5WXJ4K2pzRURKcVA4QndOLy9oK3NvVXpkU2N6?=
 =?utf-8?B?VURYTEYrV1p1TFQ3NDhhdW82WnVwT3BIQ2MrVmlwTU4yTmp1OUxrZCt1Vlkx?=
 =?utf-8?B?Q25idFF6aHdETS8vLy9sTXI2dFhQS2h3b2RCaWtaR1ZjTjZjZSt3SmkzRUI5?=
 =?utf-8?B?SjJkaEt4SXYxdXI4MUxlQUJlVSs5UVZQVGl5TE55WU8rM0N5OExld3NwWHAr?=
 =?utf-8?B?MzJKMnZxTFhFellIQnBIZUgvVHhubndZKzA0cS9zQVg0Lzh4dUp5ajhDVERT?=
 =?utf-8?B?RWJIdGpFemV3UEVmYncwUFR2N3BIMVV2WWtuc2VENDBaYXMvZzhnR3Q0OXZM?=
 =?utf-8?B?RHpSTXpuVVdxYUZvZWtnWXIxcmd3QlVuaG5YN2F1NEJkL2RlTkxyOUoyZXZ5?=
 =?utf-8?B?ZXFxeC9JMkFrdGF5QVUzdnUzV2ZBR2xUdEhWa3ZTR2ZiZm5janJaYmhtSko2?=
 =?utf-8?B?RlJ5YmJnOTRMT214cUpWUTcrQWRaSUNkTmRDSGgrNFJFOHlPbDNkWVpaOVps?=
 =?utf-8?B?a1FOS2VRc2YvUk9lNEZOMUREa3NMeDNETkszdGIyQ0V5VmpjeHI1cE12Wndv?=
 =?utf-8?B?anNyV05oK3RlUjZZT1hoMWh6cURmemFqY2RtSFd5YzRrQ3N2bGtHQmRmL0xt?=
 =?utf-8?B?MTlOZDR0SnRDODNRM0N1QmFTUDZxYmREYkxrTzVhMmdkTnhsK05semVsMnEr?=
 =?utf-8?B?dTlkWEQwT3RaakFzdkp5V09US3BvZm5OclJBM3FwbFVBbWQ2aFdEL2ZrWXdu?=
 =?utf-8?B?ME9ITS80cGZpdGlZckIzRUVuUk9kMXYwN1lwUk5UYnAxbWFEVGRISWM1VGgz?=
 =?utf-8?B?SFBHemNhbUVqNzdUTVorc0VHdUNqWnMwMVNlTkxBOEcwV0hHVmFMUXZJbkw2?=
 =?utf-8?B?QThWR0p4ZlgvZXJxeTdCUS85SjZJcmU3RnhyMHVTbEFuYnpTdmY0RFJKR1Ry?=
 =?utf-8?B?cEh3cHBXdHgrTHYvZmRiWUlYTVZiL2tIc2dWNktLZ3VoYVc4emx6M2FibElJ?=
 =?utf-8?B?Ky8wY0JPMG5kRTFHUGc1eWFiUHV1WjhTSndBazhEUnRqeGRhcER6MHcxSWxv?=
 =?utf-8?B?TFJPNm5ib2JGK2tTa2xyN0RUaGQvNGdTbWlHUXVaMXVQZkk0OHJUUGVDQWIz?=
 =?utf-8?B?RUdzN1VGNit5RGgvRFhjcFN3Snd2N1JEekVkR0MzeGp2N3Q1WU8zVXN1V3Z2?=
 =?utf-8?B?elQ2Umt5VUE2bUU1ejR5aDBkMWE2bFlMR0hEWit5aXJOb2kyYkpQZEZESTRQ?=
 =?utf-8?B?TTkyczhocHMyVzYzcThpYWNwbmtUQUk4TGpzREZMcXhmM0M4VDRuN1pBejJz?=
 =?utf-8?B?STJFTVEvM01oLysvNnVzVmRHWVlMWHdkb3p1NUFSSlZzc01oYnFLWkpsemcw?=
 =?utf-8?B?Ykc5SnlYKzdJRDNFMDFkWXVlWkpGY1g1eG9jUlhFMjVCdnJ4VGp3UHcwUERT?=
 =?utf-8?B?RGxaMEtkSWxTdnlVR3h5Tm9HMHhqWnVLWTdidld5UStmQmo0Y1FRMVl0eWM5?=
 =?utf-8?B?Y2dQMjJ5ajIwR0tvM29DbTJENjkyNjZkWXZZejNraHBPL0R1Tzd4cmovZCt2?=
 =?utf-8?B?Y2l4ckNFSjJGM0FFRW4yU1NZWStLajFrWDNERkl5cGE0NlVCNkRaUEMveTFZ?=
 =?utf-8?Q?XQdJBaTDpn7WIu8R+CWETE5p58ys1jJ7S0qRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djNhMHNjcjN0eW5YOUJFMjE5NlduYkFublA1R0UyeU5zRVpYR1k1WUJveUxD?=
 =?utf-8?B?Kytvbm8yNHZXUEZGM3lsYkgvTTNIbjdIWE0zNm83ekVDYWdxVUNoNWFqenNB?=
 =?utf-8?B?ejJsM3pGNXdxc1Vjc0l4V3FYbDhJaGw3U2hEQ1RQVlpKUEZHdGFhTVlIYStI?=
 =?utf-8?B?S0lWcmhCUzlwYUJKZEZoWDkrOWsvOXJVd0QzZzE3K1pIVHdVNVFkK2t6d3Vm?=
 =?utf-8?B?WVdMWWhETDN6blA4QXF6TndKU0hzVmh6Wk13bCtIbzc0MC96RFFTQWE3dnhV?=
 =?utf-8?B?UkZxSENRT3lsd1dlaUZTekZHelJoYkJpZnZyNXJRY3owRDFGMnRPZGtrQ2gx?=
 =?utf-8?B?bkY1QUp3aFdoR2RtK0V0dnNjOWZZaWhqZTdTUDVZcjI1aXVmeTRjZXBFNVAw?=
 =?utf-8?B?NU0rZC9xd0NWK08vVHpGQUFQV3VLUkhnRGZEemVpM2hFaWNndWhhQVg4N0Ja?=
 =?utf-8?B?WHkwSERhdVJUQ3krdVk3VnZhNGwwSTVLNHB0cHBEcTlIVnBFREJDQmpNVkJq?=
 =?utf-8?B?dlJuV01SeGZQWDh3VnZ2VjF4V21TTXVZQVFzMWF5dDVkTG9pcC9zdWxwc1M2?=
 =?utf-8?B?WkxDT0dubEZObXZKRjZvdjd5Ly8wajJiY2tiU00xS3V6aElDWUU5ZXJwRGhy?=
 =?utf-8?B?U2xDSURpd21UcE1JWEk3THNhUkEzMlJBaGZNQVhTTmZwNHFnWGJrUkQ4SytY?=
 =?utf-8?B?bFhzZFNiaUViZks1UitDdy91dTZCSUJhTWc0TTJ1TDQxVXFSVFpIU1Bya3ky?=
 =?utf-8?B?TEtpaEZSM0wzSUZ5blR4UkFaWkoxb1NZeFdaOXhMRGdWSUFOZjBzTEQ4bUZu?=
 =?utf-8?B?TmhvMUY5WkRxWDF2K3Q1a3c3bGdIbXE0STJwdXlFTnpWUUhsN0tFbXloL1ZI?=
 =?utf-8?B?S3IwY0JwSmsrNWYzT1l6NDZIcjdaaTFIclRWcUs1Mm41UCsrck1WZkhLUHdt?=
 =?utf-8?B?UHo3SXlMb0RxN09iZGxTalJtd0Q0U3RFdWRlRXJZbEFmNGg2WGZUbVgrZEwy?=
 =?utf-8?B?UTZZbSttK1NETGRUVExVK1UxTUI0QzRVV1pWbHlEQ2w3WEU4RlFqZmpnWVJY?=
 =?utf-8?B?WktKSW1CMWVNaXNjd2FyejZSWlVPZDZzZWwyU1NwMUltVlNlWFgwdWVQVDVO?=
 =?utf-8?B?dDhPM2JRU3luUXJpNDhZZysvTFViUjNmWkJKd0tlMzgrWUVUaVNuRks0S2ta?=
 =?utf-8?B?QitncHlQZjA5OGdxSFdQcGhsSGloK1VUWStDcGNEMmdZWk9MbXgwWDh3dFpN?=
 =?utf-8?B?d2gvZTgrcnRPb3d2K21hUnZoMGZkbURWODYwODNOVTdKZnlISm04L21iVmlZ?=
 =?utf-8?B?aU5JME5ic2xaZlU2elNvMk1mRndRSHVXYW1IbVFxdERZYW9UVVl5bExqUlpS?=
 =?utf-8?B?YkRlNk9CQ1A2VTQyYzBramVVeG9lL05KNzN5cDdQQnlCeG5ncDJTbVp4dW5G?=
 =?utf-8?B?TFVhaHM5Wk40OE1WRWs4SmtVclR4V1lwaTZwOC9mdElQdzN2dkdpRDFYa1pC?=
 =?utf-8?B?R3hkbEdkVFY4dTVVK0FsVnNINTJ6djJwYm9icWxPVWQ0ZmtkcmRNNEFZRXJp?=
 =?utf-8?B?SU16NTYycWRMdURTQlN1eDFSOFoxdEQ3dFJJdE5ndGNoandaNno2MFo4MjZh?=
 =?utf-8?B?QU9ua0o1MjQ1K3JubHN0UEp5YkRMbU1CN2FIOTZ1VXdkay9oTkFGa2dIaTFR?=
 =?utf-8?B?VHpQMEp3a0xFUFMvM3hoR3BGeEo4YTkwNUUxYnJPU1NvS1RRVjFuSjV0dlJ0?=
 =?utf-8?B?QVpYOXJnSjJ3S0w1Wmg4UTkwZUNKbjErMmNmdlBPbEhnQ3lGM0U5TUQrNTFa?=
 =?utf-8?B?czdhc1BmNmpKbnVSZk5TN3dQcmZUWW9YNEg2cTViNUFVY3QwUjZLZWY0VjU1?=
 =?utf-8?B?dTVVbjVOVll3ZE9BZWRYb3lMRkdwdCs1UlZBM04vaGptbUJ0WG9qelZ5Z1FT?=
 =?utf-8?B?Nzhjd2pxQVFqVkZNZUl4MURXaXhOSmVaL0FQL1hlbFBjK0JyVTFvdWZtSnFE?=
 =?utf-8?B?QTZYek5mTjhLMHhGNzgyWHlaN0c5dEdZQUI4SVY4U1pUU2R5TERJTE1RSWl4?=
 =?utf-8?B?emZ5cHdEbFVjVVVBS2V3MUtSakVleFpOMktpdHFYMUNoZzhmRnc3L2RMM2Zm?=
 =?utf-8?Q?VrhDrRxE0bTYWx6z0YiTW9S6s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95140e06-2c4c-4a3b-7871-08dd131bd5b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:54:02.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j72QzZlPB8sMK7W51ILPPqsGPNZJlZ64srtREDajSPnoh2UjaU6FVGrH3xEbjb0wegPjsry0L8I/SFNZzWsA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On 11/22/2024 13:27, Rafael J. Wysocki wrote:
> On Thu, Nov 21, 2024 at 11:27 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 11/21/2024 07:15, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> As stated by Len in [1], the extra delay added by msleep() to the
>>> sleep time value passed to it can be significant, roughly between
>>> 1.5 ns on systems with HZ = 1000 and as much as 15 ms on systems with
>>> HZ = 100, which is hardly acceptable, at least for small sleep time
>>> values.
>>>
>>> Address this by using usleep_range() in acpi_os_sleep() instead of
>>> msleep().  For short sleep times this is a no-brainer, but even for
>>> long sleeps usleep_range() should be preferred because timer wheel
>>> timers are optimized for cancellation before they expire and this
>>> particular timer is not going to be canceled.
>>>
>>> Add at least 50 us on top of the requested sleep time in case the
>>> timer can be subject to coalescing, which is consistent with what's
>>> done in user space in this context [2], but for sleeps longer than 5 ms
>>> use 1% of the requested sleep time for this purpose.
>>>
>>> The rationale here is that longer sleeps don't need that much of a timer
>>> precision as a rule and making the timer a more likely candidate for
>>> coalescing in these cases is generally desirable.  It starts at 5 ms so
>>> that the delta between the requested sleep time and the effective
>>> deadline is a contiuous function of the former.
>>>
>>> Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com/ [1]
>>> Link: https://lore.kernel.org/linux-pm/CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
>>> Reported-by: Len Brown <lenb@kernel.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> You probably should also pick up this tag from the earlier version.
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
> 
> Good point.
> 
>>> ---
>>>
>>> This is a follow-up to the discussion started by [1] above and since
>>> the beginning of it I have changed my mind a bit, as you can see.
>>>
>>> Given Arjan's feedback, I've concluded that using usleep_range() for
>>> all sleep values is the right choice and that some slack should be
>>> used there.  I've taken 50 us as the minimum value of it because that's
>>> what is used in user space FWICT and I'm not convinced that shorter
>>> values would be suitable here.
>>>
>>> The other part, using 1% of the sleep time as the slack for longer
>>> sleeps, is likely more controversial.  It is roughly based on the
>>> observation that if one timer interrupt is sufficient for something,
>>> then using two of them will be wasteful even if this is just somewhat.
>>>
>>> Anyway, please let me know what you think.  I'd rather do whatever
>>> the majority of you are comfortable with.
>>
>> Generally I'm fine with this.
>>
>> I'm about to head on US holiday, but I will forward this to folks that
>> aren't and get some testing input on it to bring back later when I'm back.
> 
> Thanks!

Hi Rafael,

I loaded this onto my personal laptop before the holiday and also got 
others in AMD to do testing on a wider variety of client hardware.
No concerns were raised with this patch.

Feel free to include:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>


