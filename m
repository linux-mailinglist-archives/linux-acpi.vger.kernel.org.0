Return-Path: <linux-acpi+bounces-13330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B1A9E60E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 04:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D293A8203
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE8145B16;
	Mon, 28 Apr 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mNcVsyFT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488692BD04;
	Mon, 28 Apr 2025 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806019; cv=fail; b=R4QkKNUZwh/LI96E6HIv23cVrzovhpepe2XonEgR5aXvgyW1D8BaikT3axZ28HIHjpW5cpV9XKlb/kVCWpdoixxILCTyFnD/z/dIJrNvVNN8M4Do2kkieFBucyL9GYaLh9tlYQiNME3WfsInb9nv9fVfDQv3EtMeBFTH8eR4jY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806019; c=relaxed/simple;
	bh=D5i6iJ0yrlUYv1qpnQ9jgMylYvmfU0TYJbNdn2Lb5bQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ea0DF68MyewY2gv+X/SoCMB2HdGZ9lHpAN3Fklr9MMeCriZNNQX38Uwzv4KJVzWncwInGdcQgdETVeNzHMJV7QlkSQb6zPDMisxcALsDKrmxiPjwTMjInle39+qL1olPOSDIELPZJkSU4AWcEcFEtA8UW0vAskFCbbM6cuolmqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mNcVsyFT; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe3z0nfg3UB80DialPpoJ4QUgtWIb09cqroVz3SeId7LTV2t09b/Kds7wJSvqeSyYkMzYUPj/9CuCmqBF3ZC2hzPcjHiNqcQsv6qN0EtVS3Zyc31F7iPOOk7Y3us3SOsWTuJIYOBvnXvlZt2XhW02L/CY4DMDnnxBOERKlTrnEem5A/kQ5YVY1VVh2/4ynQP52L8+CqS3NWTahkvpidrp5TWBMLtrTpbMRd8nEpg0xRF6ofQTHoPuZHzuQ7oJ4cjSNo49QYZnsevut8Dg17lMj0SqwfykQaAyFVGmExJFvPWz2sRKxnX+1ZLSqBWKoXBlnyDgjH/8C8qZTJFLyQ1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v70nU81XU2xh3FGjFmhv97qtrYCgLNJsD5MXcQOn+10=;
 b=kGQKpanWBxZg7Zgvo9Bneu5B5AvHt1Kv+/JpASmfk2Fj2A1zSKM2y5JLO0brfEgPnLZ/A/BiJp4S0VFOMrcO1Cbi/zdMnQQQ4wniQ8ZrNWfyiBax7Dt3jlOPGbgTIJ4Xy86c3x6Iz9C2OWlpliNcptn7ZOigoT4/dBJnPZzAKIdewayxh6/X6+ciNEHAj62fGXItUc69gdnDzGi1+hkFsPQFsI5wHtRN2nBiEUQLHmhUBL8u+s3LMpMqTsQ9jhL65PZfvhgnMwGfEL/Na5bvQaRBi0D6NXY+qYnollfphHytpfEZ+QkWsifDmVS31ByehS/V6d+pBwtqh/vr3QiD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v70nU81XU2xh3FGjFmhv97qtrYCgLNJsD5MXcQOn+10=;
 b=mNcVsyFTSMARaagVuhO9Aokz6RzjuKcVzlIdIGnHVlX/jSmWzVQXxHwFYN6xJ2LOOtLl8ot9LQ2yKMy9LK6VEqy7bPD/R+nSI6CQL/5/Ol/v8jX+c3b/ZuFLO51zOxv+okAia8/XUZvclRfrIhH2jo8SREXcIhX48xTfrBBhsY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 02:06:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 02:06:54 +0000
Message-ID: <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
Date: Sun, 27 Apr 2025 21:06:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: "M. Bergo" <marcusbergo@gmail.com>, mark.pearson@lenovo.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
 <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e0bb9f-6ab8-47eb-64a3-08dd85f958aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUlyNGZXU0UxNUI4VGRvbitNRmJwclNYUFNoOHJmeFZPanZxelFjNjJsbHpG?=
 =?utf-8?B?L1hhUXZsSHZNS1lOL0ltenlmTkZRdkUyRFUwK2s1ODFIcGs3Y1pNMk1Tc00x?=
 =?utf-8?B?eTFuRnZ6THFDQmR4cHdreFhtdUU4SG81SnEvOVhINXBWMWYyT0h3Ymg4NHFV?=
 =?utf-8?B?QXVTdCtsS3VNQ0dIcFA0RmlsSlFybWxiUkFNenlVckVaMS9XZmZTV1Y0UTN3?=
 =?utf-8?B?TUdkZ2NvYlBUS1RDTDN0SHZwMklNM25JMGRObTd6T1Q3cWhVRnJKVlJPSUQv?=
 =?utf-8?B?NFhuU0pRdmQyeXBFdGcrVFFUeTRKMk83Y0pEQm5YM2hLYzJXVHUyRnJ1cDli?=
 =?utf-8?B?cjB0VWNJK1k0azdSNitxWk5DSnFLK21Vb3J6TmhiSkRUbmYzdVZ0L245ZlI4?=
 =?utf-8?B?ZDlFMXduKzkvc1FmaWN1UTM5YzZkV1JyTG00QXlUaFR4OGFYdEtzbjc2MmFB?=
 =?utf-8?B?T21aNWpoZWxucUtQV1NRNG5iUUR2Q2JURWVkVFBKNGxkSjdWNCsvNGxPUmxs?=
 =?utf-8?B?bm1ieTJrU1pwNmZuRlEyV0lJcDF3TTF6TFExU3ZLY2NRSUsxY0FwZlRIL2li?=
 =?utf-8?B?TmF6aE5DZ1pEMTBrL2o2MGJtSGJqWEg3T2hVQzFnU3phQVB6RnVBM2JGNGU0?=
 =?utf-8?B?ZExCcXBDVFhNbS9nK1pabTdjRnJwVW4rOGtGUEw3N28yMGVjaFUvQXRwM2dq?=
 =?utf-8?B?ZDJLZFFwZVloWHVGem5ObGFUekZ1bVZrWXVsWHdWUm04U1cwSVh5NDhZclRo?=
 =?utf-8?B?MWFWTjJRdzZSTUp0RHFDQVhyclNLa3I2dWRmcjdNMEQ5dk0vUnFnZ3BNWDFL?=
 =?utf-8?B?K2NQQmRmZVlqQUtKSmZMaER0NEpVVEdPUnJrc25DTGd3cGpBR01tY1YyV0JN?=
 =?utf-8?B?QTZ0L0xDaVhKVmsvQStGK25nbjRDbGFpbTBMSE5oYUVWWWJxSG9hMFpIejBH?=
 =?utf-8?B?QTF1eXpEeVZpeUtSWDg3QlMxajBkcnpzbVZ2eHNjRVNhbWloYThvc00rWnNp?=
 =?utf-8?B?c2E0NitITmQ4U0JTRlc5elAvN1VJMHA2by9UUndDNW13MU42Y1Jxb2E3TllQ?=
 =?utf-8?B?ckN4SW9ieU12QTUzZDFwSXJnQmJrdlBma1FRQk9MN2h5WTd2SHVMMTkvQk4x?=
 =?utf-8?B?ZHBIekZqRk1VbmlLNXlkSW5tUHZYRkFtRFZaa0FNWno3NWlMcWUzaE8yekd0?=
 =?utf-8?B?Rms0ZWFqZnpxcUtxZEIvUmZQSHVnNjc0UDVMeDV3UnJKMTJxME1sT2tQU2lq?=
 =?utf-8?B?UFAzN3RudmxIVlE4MVpydldOY3BHMHYwTGlHeE1IMUtmVlYrZmhYdDBSMldn?=
 =?utf-8?B?NUNDUStXOXlJelBmVVI1eWR5am1CMFZzNTVZUmhaYU9aUWNYUnduM2RFMnhr?=
 =?utf-8?B?RTM0VnN3N0ZSNDRack9nbUJreFdMRjZLY3dRbVdTeVJMSmlXTDRlS1F5Q2NR?=
 =?utf-8?B?cUpnMWw0Vll5Tjh6RkFPQiswNkk1c09tcGJqZlZHRTNJOXFJUXR0NjlTU0lX?=
 =?utf-8?B?Tlc2N2RIOFAzNmV1ZkEzelhUam1hdzNrRTE3N3dDTFBCek5rNVdsek1DUmhB?=
 =?utf-8?B?aWNpR0JNNHphK25TMFg0NzdsbXYrOFpMRlRCSU80YzQ3Y1J3bmZOcE9jd0hU?=
 =?utf-8?B?czlza3ZiTU5zQ3cyOVJFbm9Vdnl5ZWdqei9PNWNJaHRrYVE3cDJxQWUwZGVl?=
 =?utf-8?B?THJoMng4Ri9zcWloZlJiS1lTY1VMQzNXa1NnR3JPUmI2ckppWCtjRVQ5SVg3?=
 =?utf-8?B?N2thd1pzY1lTZUE3TmU0bXVHSUhHMnVmcElOaUp2KzlyOTVzS2JMc3JocWE3?=
 =?utf-8?B?blFFTGttbGszUU8xMFErY3VrckZHaTlDWDRiVnhtQ2htays1RHV5dm5wY0tS?=
 =?utf-8?Q?tdl6zqiWSvKRH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZzdkFIV3VFNGlVTXRhcm9OTHdPV0I1V285dnJhdnQvUjJYZGJCdzRvaG5W?=
 =?utf-8?B?ZDg4MkdPdjN2TFlGQVNKWXVHRVJPdGozQmtCN1d1M3B4TkdNSDZJQ013VGg1?=
 =?utf-8?B?cUhDUW5ZVmZ3KzJmejN3Y3JUM0V3OXN5aXprUjhpVk5ROTVaR1RzT0lsTm82?=
 =?utf-8?B?TXh3ODhtMTJRTHdTd29tT0k2M2JRNUMzSzdBWkkxYm1nQnlUd2hDRFF1UWdX?=
 =?utf-8?B?VnpwZUJramsrQVFTMVZWVjVNUFRDWHhTdWkzL2RJTU9OMStYemJGeGpGd3Va?=
 =?utf-8?B?R0ovNVNNbEZVL0lHcnJUM0FrR2t4dnpackcyS1J0N2RsZ1NYN2hUVzFJc0dV?=
 =?utf-8?B?THBDNng0bUcxZ3ozdlhRNndhazUrclpMQ201Mm5XMVovMmpZbXh1ZkM2ck9N?=
 =?utf-8?B?MDdkTXJpSVYxTXhsTk5Ub1pZem5WM3lxSSs5cDNqZjNhdklPbjNOY2N0RzZp?=
 =?utf-8?B?cmU4TnhpT2hyQ252UmUvTUtld0NWUjRvS1FuQWZGWjIvWld5Qi9YcFIwUTQ2?=
 =?utf-8?B?Vm9DQ2crbHZaTzMydFZxK0FwYjkxemFIVWxaa2ZPb0VJNTdHbXlObEYyZDV6?=
 =?utf-8?B?OGxLdlFqNFpqYWx3QVk2VEhHNFExcytRdDM0UElpSWMyRmFwUFhsazRkdldG?=
 =?utf-8?B?QWh4SWgrSG9VQ2RyYVlQcjl5R2UyUnB0N2oxb0JsY01iUVIyRUZLWkg5NGZE?=
 =?utf-8?B?Q2tVczFuN1hISVJmenRzallETEZEem1FMzluS0tMeFZuaWJCWWszVW1IZkNO?=
 =?utf-8?B?enIvZjhHNDZSTWc4RFduaEYzNXR6OW5LbWs5NmV5cXpxakN3TlFiQkF3VEM5?=
 =?utf-8?B?WGdkWGVYS3grSW1NK0hIVWgyM3NUMnV3ZjBSWDNSUHhLMThlTjQxZUtXTlpv?=
 =?utf-8?B?YWtUYXh5MUxheUs4MGg5MThTTTF2UVYyS2IwVWE5bmVYa2pLK2RpNVFFUzh3?=
 =?utf-8?B?ZkQ2N2hqYkhKOGcyZGdOMTRjY0ZSRlNwaDZrRVN2L0FHcTBaUW5BdmRmN1hq?=
 =?utf-8?B?Q0FNVWVSSGlIZnpLWVFsUW1iVXd2VTA1TG9uU2lMNEdxNkRWYjFHazdaSjNk?=
 =?utf-8?B?bGNuYUFCSzR4Wjh1T3ROUFRDc1JibCtvZmxBZk5ja2Rwc0hGcW9Ic3BRMjVZ?=
 =?utf-8?B?d0V2RUQzQ3JKajZyZ2xGV0dCODlmWnZGYkVHMFJJNmYzSGQ0RHc3a20zWk04?=
 =?utf-8?B?NU4yNlV3dTFENXVaNTd3L2dYUG9OMTVuWE1zK1RCd1VzYlIxdjBPNEEzTDh0?=
 =?utf-8?B?WUJHbi9TTFZXRDNUUDVnRHRWWk5odFRnY0R5a1g0cEMwMDdQcllNbThVK2Rx?=
 =?utf-8?B?eHM4cnB3eTRjYk04QXhhMHFhOHNIcEcrR0xtaThtMTBTZDRFTktsbGZpdThB?=
 =?utf-8?B?b0ZwVzhId0pra01kcFo4ZFdrTUZFdVBueml4SllXN0ZvR2xpQktWazhNR1pp?=
 =?utf-8?B?ZitJZU5RQmVRZStzbUd6TG1HK2FVdFptaGl4SkxTSTRuZUtlNUhoNUcvbDJy?=
 =?utf-8?B?V3RyN05JRUx0L3NEbmhRcnoyQ29lSGlxczJyOFF5ZVh3QlR3VmhiSEdVbUJ0?=
 =?utf-8?B?Rk15cnF1d3ZLejNWemRHR3pNTm1iSC9XSExIRUJCRmFveE5BeVVzVVk2QzNW?=
 =?utf-8?B?ajUwVUJJV2dMSnFxY1lpaDcxdnlYUURONUVXWnk3a2lvNndqKzFKdk1hR1Zr?=
 =?utf-8?B?QkZZUFZOY0ZTYm1SZ3FXc2h6RCtkRU1sbVlMc2VvYmxIWnJYUnZJclJTNXlh?=
 =?utf-8?B?djYzU2pBM3VBOHlsTGdydWw4eFl1SW9GZVZoczQ2K2dOZ1kwSXZLVm5lN1JX?=
 =?utf-8?B?NTBMVE5hVUxrZmJWVW5oRTF1eTlDY1Q4YTJWdWxtV2NUZ1ZJWWRzSkE5VU9z?=
 =?utf-8?B?cmRqWC9vMDFPUEZQbHZSTDV0ZFFRZWw2dDJXbkNUM1BYZVlZK1VLQVhyMVpB?=
 =?utf-8?B?aitsVjA3NzlSbnpQWXcwL00zSkVlVm85TWh4TFh2Ymk3eEoyajJ5dVdYMHpL?=
 =?utf-8?B?eHdkZG9mY20yWldvdUlwL08rUXB3VUZ6MEdDVnBBWlFJUDA1WUZYWDVsclZF?=
 =?utf-8?B?ODZWamxQSmhoRU5DWmRZZWdlb05vaHNTQTVhMXVvaUNCL3ppYU9tZHZuUlBu?=
 =?utf-8?Q?AkrqPbwuZFjtEfxYLF/ZK/cYS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e0bb9f-6ab8-47eb-64a3-08dd85f958aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 02:06:53.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqDVt0ThZMLo3i7MqlILgZinm6EJ/xJOhDDNC0/h+Owzxiw2NekDNCawwE61tMaNaqPnY4HyQlgqetHIJpdYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

On 4/27/2025 1:34 PM, M. Bergo wrote:
> It does make it work fine for me, I saw the clock/timing interference 
> and this sane this problem for Lenovo as well.

Huh?  I think you have a typo; but I don't know what you actually meant.

So you're saying the timing patch helps your system as well?

Thanks,

> 
> On 4/24/25 11:11 AM, Mario Limonciello wrote:
>> On 4/19/2025 1:03 PM, Mario Limonciello wrote:
>>> On 4/19/2025 4:28 AM, M. Bergo wrote:
>>>>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17 00:00:00 2001
>>>> From: Marcus Bergo <marcusbergo@gmail.com>
>>>> Date: Sat, 19 Apr 2025 05:19:05 -0300
>>>> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD 
>>>> platforms after
>>>>   suspend/resume
>>>>
>>>> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen 1, HP 
>>>> EliteBook 845 G10)
>>>> experience a CPU frequency limitation issue where the processor gets 
>>>> stuck at
>>>> approximately 544MHz after resuming from suspend when the power cord 
>>>> is unplugged
>>>> during sleep. This issue makes the systems practically unusable 
>>>> until a full
>>>> power cycle is performed.
>>>>
>>>> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: Fix
>>>> acpi_ec_dispatch_gpe()") which restored the behavior of clearing the 
>>>> GPE
>>>> in acpi_ec_dispatch_gpe() function to prevent GPE storms. While this 
>>>> fix is
>>>> necessary for most platforms to prevent excessive power consumption 
>>>> during
>>>> suspend-to-idle, it causes problems on certain AMD platforms by 
>>>> interfering
>>>> with the EC's ability to properly restore power management settings 
>>>> after resume.
>>>>
>>>> This patch implements a targeted workaround that:
>>>> 1. Adds DMI-based detection for affected AMD platforms
>>>> 2. Adds a function to check if we're in suspend-to-idle mode
>>>> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD 
>>>> platforms specially:
>>>>     - For affected AMD platforms during suspend-to-idle, it advances 
>>>> the
>>>>       transaction without clearing the GPE status bit
>>>>     - For all other platforms, it maintains the existing behavior of 
>>>> clearing
>>>>       the GPE status bit
>>>>
>>>> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7 PRO 
>>>> 7840HS and
>>>> confirmed that:
>>>> 1. Without the patch, the CPU frequency is limited to 544MHz after the
>>>>   suspend/unplug/resume sequence
>>>> 2. With the patch applied, the CPU properly scales up to its maximum 
>>>> frequency
>>>>     (5.1GHz) after the same sequence
>>>> 3. No regressions were observed in other EC functionality (battery 
>>>> status,
>>>>     keyboard backlight, etc.)
>>>> 4. Multiple suspend/resume cycles with different power states were 
>>>> tested
>>>>     without issues
>>>>
>>>> The patch was also verified not to affect the behavior on Intel- 
>>>> based systems,
>>>> ensuring that the GPE storm prevention remains effective where needed.
>>>>
>>>> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218557
>>>> Reported-by: Mark Pearson <mark.pearson@lenovo.com>
>>>> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com>
>>>
>>> Great finding with this being a potential root cause of this behavior 
>>> (at least from a Linux perspective).
>>>
>>> Although this helps, I'm not really a fan of the tech debt 
>>> accumulated by needing to quirk this on a system by system basis as a 
>>> bandage.
>>>
>>> At least for HP someone said that this commit happens to help them 
>>> for the same issue you're describing:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform- 
>>> drivers- x86.git/commit/? 
>>> h=fixes&id=9f5595d5f03fd4dc640607a71e89a1daa68fd19d
>>>
>>> That was surprising to me, but it must be changing the timing of some 
>>> of the code running in HP's EC.  Since you happen to have a Lenovo 
>>> system does it happen to help the Lenovo EC too?
>>>
>>> Mark, comments please?
>>>
>> Someone just reported that the timing delay patch helped their Lenovo 
>> system as well.  Can you see if it helps you too?


