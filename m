Return-Path: <linux-acpi+bounces-12153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE1A5E763
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA43B3B34
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1241F03C8;
	Wed, 12 Mar 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="twogMkXA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3581E9B32;
	Wed, 12 Mar 2025 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818412; cv=fail; b=kM61etPK8dh0jbktCfkU9jzjRwMxRqDazOoSHzq2bCm8cNtGhELqypMC44/3bG54HcTqVXQkwpXhZkuGLaSvgtIvdg3+Eo1O5gJ/dEcmpxU+ju7F3475zPw6uljCqMtmb7t3Uqb2eaLqpp8VK/BpOBokrX0T56A/pfdPGuUgokw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818412; c=relaxed/simple;
	bh=b3GGlLTmiNVv260rTi61CVKoMNZjdLcampzUFccy3Yg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rgjg1yGwvLZN44dEcyp3AsM1WyKsYe3ZtI6u5yLGmNtA5H3DNULgKAKKSF1UASHXAt1URK3ZdgibBIBOfWhGRSbsHmdjNKWKXHxWzeeDTIV6TSBcLdFcX5OvVFPyicDaugMQxR7Z58hVZ4o9BfTb8GG8VTdR7QH7ke5AuqvJDeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=twogMkXA reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.43.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5Y0Ds0mCa/GSmD5R0FXfU8SPBsjvmmYhWZES7Aa9JtlDymX3h/2VFQEt2W/zlyw4ZnRRrJ09C1gOk62j2pLB5QMtJRWxiJg87YebtqBkVKnPHtkf+fdgAYDAMovj9yP1uBMphsfOsJmaRj5MIiP/Em7DNf6rCb92b80/ywYhZO1I9lbZ1JToancJjv89eLjLeyxQ3DeoAw2Qdpqfo0P0IsronRcmUwVPO9asnOPminXwDsDszwGb21ksC8RjiKAmc3MdrM3rcXyPnJiIoXY+wNYKuZkLVJ2IeHC7kQRWfB5Ux1jqzIeY7LLgHsYM93Np9Mcbuh05n/EdR65Z1K1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFv9RQ/lBbpx41BZZ6hDyZw4zU5Qmjoq7YIiHCegJz4=;
 b=eSH7Xi+sBqsBzt36lkCU1m4ZL/7Mob4bkcN2C54eevdiqg36CIOHz47ZCuBD3ii71qytmMHsUwfZ02bDoyPr39k3tmCg263hgm+wPzC8KSXvPZDBohQAwuZfGDs76tbq37RlzubPTQgACCcxAr9vp0XRSn/H81LOqCtOeCsLDOugQrYr25wMGa24Tzh75i8679wwyHNb2XFlWsPiKnDcrcPngeM0RctT5v1/Wv4mVYIXd45WkPf2S6ZyWBwVnL85Rgb6bNRVH48XRsiEO7B8bufym3VLsO9TN4DrxUSRKf96Z3eUnxljrVRzcStKsoQW5+JLu3FdgCS38uFiYiBIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFv9RQ/lBbpx41BZZ6hDyZw4zU5Qmjoq7YIiHCegJz4=;
 b=twogMkXAt+O5hKzfH+yE/mBra9mOmRxl1btlohW+CZ7o5IqXCoDQC+loP0Vwl51KF31s3qU0ZVjAjjLg6p7TaUUtLtuRB7lE7gy75ENyeaf+igMzJewKgBpEOh+6gnDKzlVNTJs/k9u172wBOnfMyeQypL651RhZTvaK3wN+FHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:26:48 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:26:48 +0000
Message-ID: <824848aa-8d75-4ce5-9db1-f484a5554c58@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:26:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-3-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-3-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeaf8ba-400d-4a45-9307-08dd61b4fab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0h4QVJ5SjE1eWx3UjIvZDA2Y0tWR3o5UVNTOG55VDk4ai9HL3JDOCtGenJj?=
 =?utf-8?B?TUtTWFlPZ3hTSnc1RXl1SFVvRldlbHBHWXUrbGlPVm44d3FZODJBdWtTUm1i?=
 =?utf-8?B?MW51YnN5UlFtKzR3K2FBZGtlSlBoeUNwaVZnN1Vnb2hDbUI4MVoyb2ZrTGdl?=
 =?utf-8?B?NjFXZ3N5RVBwNUlnTTJDUG9NM0N4ZXk1SWVoQWxXNlpibzdtT2tDRk9zSHRN?=
 =?utf-8?B?aGhTNmVFcGkrMjZnTTAzYThvTFpab3k1VjIxSlJtVllHY1BmMWplaU5xTVVp?=
 =?utf-8?B?ZHU1Q0p0QXJTQzJZTXkrOWpucjRuUS96ZGRMUGREcTh1M0U1UTVOODQrbzdy?=
 =?utf-8?B?V2p4REpTd1VVd2ZjL2hnOERQU0JyWjRNNm1iNGh5QmtyeDRNZjg4NzgxS3Jl?=
 =?utf-8?B?d3pzY0VwakdnVTErdTdRd1ZPbFRyZnZlcHNxNGczUE5XSGNzZlFBMGxNYm90?=
 =?utf-8?B?Qjl0RHF6dXFuZlA2RzVFWjU5K3gvQ2sydWxJeHNKNmRjQ3Z0REowUVNmY28r?=
 =?utf-8?B?aktGTm9ocm1idlB5dnNzLzBpVTlsWWcramN5N3lNTUJ2U2FBTUt4Q0pyUnZa?=
 =?utf-8?B?czcraTlOU1h1dkpGUXVwcUtYQndlakoyQksycmFHRFhFSXhyZ29MelpYaWcr?=
 =?utf-8?B?eHczWHVUV2c4TEVocU8wdXNtRDByQmk0Qy96Mmx6Q0RJNWlrdmdQMlNqRmVU?=
 =?utf-8?B?MzV1aE1FL2dhYXJYbGwzOVdsdEo2QWRPcW91SkJtWHFQWXJrZUtidHREWUd0?=
 =?utf-8?B?ZTdSc0dUeGVvcmFESUlqbWlVOW5RV0V5eFlyVGdRM01KempkVmRRNHpaMTh2?=
 =?utf-8?B?V0E3YmZZekpEdW1rdzNKWnlYTXdBamxaMDVxK0FCbCs0TTZrVGx0QmpobGtY?=
 =?utf-8?B?YjRkd0VZUE1uOG82TThxMGIreEs5aXJ6TnczamY2YVM5dURzZ0N6Wk5VWkpx?=
 =?utf-8?B?MGpWMDg5aXdDYkxYTG1iNFc0aFF1bXphby9sR3F4QkxqbXpzR1RSWjlPdlM1?=
 =?utf-8?B?WjJWRmpTNHc2M0FGTU1EOUlyc0puVU1FWHZyV0src0tOQ0p4QkJicll6YlpO?=
 =?utf-8?B?dGgrOGM4dklyVTRPRE0ya1Q4K1QyUHRRZzNMNWhmVERhclV6ZXo5T2J6dlJN?=
 =?utf-8?B?RU9aU2c4OGRXY0xobDhjQlp3ME4yMmFPbWkwR1NPU1dGS3ZreHpWSXhZOXUv?=
 =?utf-8?B?dHlCenhabUtZN2VHcHlodS91WTlHN0FCbnFDaEFRMHBFaXZVYWljRGJhRnUr?=
 =?utf-8?B?NFIrTjBLYmphUFFHVUl4RVFiTGNSZ1R3a3h5b0RFRlA5VUhyQ0E5cThSSHZ4?=
 =?utf-8?B?OGFCSFp0bVd2endpZkN5NWp0Mk9xZVlrdHIvWXNIYXdyRlpRT3VPT0V2dTlp?=
 =?utf-8?B?MGQyVXdlYzdqOGVZek1KTEc1L2xkbWlxSThUczNicVBpS1hScTZzVTBPOXFE?=
 =?utf-8?B?MW1tVHlyVjRBak1MNWtPQkFGMHVOREx3NWt2Ry9NQTBSdlc1T3B2WjRROWJS?=
 =?utf-8?B?eW5FbjBwblJNclNwZHFkcGdDbGNlUnBYajFSZmc3VFNuSTdUUk1iMDloeHFh?=
 =?utf-8?B?OXJtckVFUGFTVUovNm84SHp0TUd6T01iNVY1eGI3dDVHNmgzbUJrSGlPTXEw?=
 =?utf-8?B?WWdNc3N3a0hHTFJsZ0FFZmlkQ1BoMzRjUkVEN1FxdWJOSmtUaitzWGhIZGk4?=
 =?utf-8?B?TVI2MFZkMUNLWnRUc3NUS3J2alF6TlZGWXBUYWs5aytSN2U4YTZzZEQwZU9O?=
 =?utf-8?B?U0NMODJxSW1PTGFTQnlMbzZMSVJ6cXNvQzhjc0NkMmZoNmZWbHB4U3BWUGlx?=
 =?utf-8?B?Q3l2eEFrZE5IbTllcEFOTXRnS3RVT2d2U0M4U0dYem5uWW1Ebm16Y0JDOGFU?=
 =?utf-8?Q?uQw1Q03S9mK/z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGdGS1o5UGQzOXBhYUlVRTF1QXkyTlBGb3J4eEh0enJjZnl5djh1U091a0Vj?=
 =?utf-8?B?NVEwa0k5RFV5WUVtUTdadTQ4SythR2pzdVQzUlVMYkxvazE3bjRGSzBMcUlH?=
 =?utf-8?B?c3NlcEd0QUd3S3NUV2h1YTBCVms1L1orR0ZYWTROR004M2ZhdDZ5bEt3Q2tD?=
 =?utf-8?B?SlhlNktzV1ZqdG43TGYxRU5qNHhsWGxXRjJGeWNHMjhsUE42UnU2NlZ0UTdt?=
 =?utf-8?B?RGJaVVZTS2p2N2VrVnoreWczRi9PeW52Y1pheXU2aEFrb01ra3NRR1Y2OGpB?=
 =?utf-8?B?WncwWnRyQjZxU3B1dW05eFF5QXBZRXpsVDBiSTFaeGZNM1h4Tm1abmhBSHJu?=
 =?utf-8?B?QkxkNWRja3Vmc1JFYmJQOHQ2ODd3RjBSS1JaRm16VTd4bzI3OFM2bnNpL09r?=
 =?utf-8?B?NEZOYk1TMVFuN01WNlowelhKN243bmhMYWxNU2RzY2syS0RRV1Z2eXRna3lu?=
 =?utf-8?B?bGt3UnhlWThubVZpOTRSc2gvSXFqeGtBNWZ4TmgvTlBlamQ5T3d3a21BOEQx?=
 =?utf-8?B?VFNoT1lnd2dMaURXbXl5NHRwbEVzcUVidkYzWkZocW5YVGxaMlIwMDlBWFh6?=
 =?utf-8?B?bjFSOVZ6eDdqR1p1WWkrNThSY1djbmdDZUVwSWFTZUJiTUpSeG5qcEdkRmU0?=
 =?utf-8?B?YjBITWZxcXBoRmd5UFFDMnlPS2JLaFR5c1BuNkc5MUVmVSsrVVp6ejBaYjN5?=
 =?utf-8?B?eStINFJwdDVXU2Y2S0ZBbjdXaGNTbTBOOVBhYVptWitqUWluTUl3Q0JYSjN2?=
 =?utf-8?B?RUJuNVcySDdFWCtEa2Z4NHAxKzJmY3RYbis3UXo1elBCeUh3SzRhUlpoZVVu?=
 =?utf-8?B?UEpHdUduRXh4SEpEdmhaM0gzTVVRNWFBemsxWFM1TUMzdmVGL1BVcGU3dzND?=
 =?utf-8?B?Yk1SUko4QVpETkFYTlg5bnl3Qkc3dTZ4TkVKeUs2OXlTbkZBYWc4akRUOFh5?=
 =?utf-8?B?a0pRRHRjTGZKbWY1bUhOMkpDUk5XclJtZlR3QUJzMkFCY3h1ZXRHOXM0SmxP?=
 =?utf-8?B?ZHVlRFUrLzdCTkEvTWRPZTBrUWZMT0ZsYmt4K3NTcDdQQytqSjgzU3ExTWxY?=
 =?utf-8?B?bDJhRzJUT2J1U3Jwbno1RmNnRWJXek5xSHA0Y0JjMFBzMnVnQk9UZGpIMTFB?=
 =?utf-8?B?Z0NGUHJLVUV2aFRCbzg0czQ1ZHZiRG5EalMvakkwWnBGNTZCejBsNUVEQUhL?=
 =?utf-8?B?Z2c5c3pPcXRPUzB6QTNvR094M1UvNnVXRVIrVzhGbEsxL29GT1hvOHpRaTNU?=
 =?utf-8?B?eEo4bWFlaE9XNk1CZmZZdWhHRkJaOFdvL0xEa3pvQlJjWCs1K3Rwa0NBUEZQ?=
 =?utf-8?B?d1hQNzArb1V4WjdVT3o5dXo1aEo2aWZ5Lyt0cEhkVWJ1cnhVTjhscVhmY3RT?=
 =?utf-8?B?dU51R2ZoYkZUZDhmbHpUTS9DK0NOR2M5d1FzODFyQkZodDFQQU14a1lHWUor?=
 =?utf-8?B?OXdGZGdmN1pNWTNzS2I1Z0huNlVhbHM4SEF3T0h2VXBBYVh2clpTaHhpNlEw?=
 =?utf-8?B?aHdJaXpocDZXYTNYZStkM1U3RFRpSjIyS0wxNFJ6V2JmYUhYZk9nMitlMVI2?=
 =?utf-8?B?M09DS21Mb0FTTHV3Njlhd1pOeDFob3RPZ01QWXFZZ2tweU8xWmZ2eEMxaU93?=
 =?utf-8?B?eWhCa0I2OVIwdnlzQmVTRlRlSnJxZXJHRTBlV2dKUjk3RFZGY0MyUmk2OHAw?=
 =?utf-8?B?WVRIdG9EeVJyTk1KSlR3RGxlckRaOWUraFRTTXFZd2VoOEtveTd5RlVZWCsv?=
 =?utf-8?B?SmE1NFoxY0w4SXlheDNNK292b0Z5enlybWx2NGxCc3FvUC9ya0piRVhpUUxt?=
 =?utf-8?B?MEY2c0FvOE15ajkzV0lJOWRiV3JTWXF0ZElhcGo1WjFZcVNveE9pTkVaKzcz?=
 =?utf-8?B?R2toRk1kWW5NbjcyanFWZDVDajRRVldtSW82SEdwSnVkOEFEc25nSEx5eDJX?=
 =?utf-8?B?ZVpvN0toUHNMVkQ1SFZocnVKbUJrNXBtN2ZUb3hBeWsrZmNVelF5RmpHYlhM?=
 =?utf-8?B?eGM2LzVhdm5UMklITTBoYVBIRFhIU0Z3cnI3T0FvSThuUEhTWEhnUnV5R3Ar?=
 =?utf-8?B?QkhFWjdLa0lwNE5JdlZjL0plcTJ2b0lKQ0hEU0ZhbmYzUDBVdE9IM3BSWlJK?=
 =?utf-8?B?bmZMU1pGcTlyalI3a2dwaVlqWHZDNWkrYVQ0ZXZ2ckRSem9Kd1EzVkcrMm04?=
 =?utf-8?B?bGVhbG0xUk5sQURPMTRhNmxjYjZ0MnNCdHIzc055MXZlZCt5dXFEdUhBQmFF?=
 =?utf-8?Q?JcDkfvqyR7RQ16oWq5d9yjkbvJkgUwk1l33EGXIEUs=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeaf8ba-400d-4a45-9307-08dd61b4fab1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:26:48.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSqhPzBLtB0MPjCXJNVfVdMYmtUPhXaRp6G2DQBOmC/W2wNpZDCNAQuc+V5ZTMtt0zUtgw7bvXEZUQJB99i7i9StJle6jFH/KIEi1WNpnxIIFR+xNFq5fGRZkvU6z2AD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788


On 3/5/25 11:38, Sudeep Holla wrote:
> The Sparse static checker flags a type mismatch warning related to
> endianness conversion:
>
>    |  warning: incorrect type in argument 1 (different base types)
>    |     expected restricted __le32 const [usertype] *p
>    |     got unsigned int *
>
> This is because an explicit endianness conversion (le32_to_cpu()) was
> applied unnecessarily to a pcc_hdr.flags field that is already in
> little-endian format.
>
> The PCC driver is only enabled on little-endian kernels due to its
> dependency on ACPI and EFI, making the explicit conversion unnecessary.
>
> The redundant conversion occurs in pcc_chan_check_and_ack() for the
> pcc_hdr.flags field. Drop this unnecessary endianness conversion of
> pcc_hdr.flags.
>
> Also drop the redundant PCC_ACK_FLAG_MASK definition and use the
> more appropriate and already defined PCC_CMD_COMPLETION_NOTIFY.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 2 +-
>   include/acpi/pcc.h    | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 4c582fa2b8bf4c9a9368dba8220f567555dba963..42dd405482e407cf90e66917a46fb8e350e0eeaf 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>   	 *
>   	 * The PCC master subspace channel clears chan_in_use to free channel.
>   	 */
> -	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> +	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
>   		pcc_send_data(chan, NULL);
>   	else
>   		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 699c1a37b8e7846362bae35477eb5736be15d79e..d1e506f041c5a80857d4a025fa3c1803746ba4b9 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -32,7 +32,6 @@ struct pcc_mbox_chan {
>   #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
>   
>   #define MAX_PCC_SUBSPACES	256
> -#define PCC_ACK_FLAG_MASK	0x1
>   
>   #ifdef CONFIG_PCC
>   extern struct pcc_mbox_chan *
>
Make sense.  The endianess was due to this coming from a network driver 
and should not be here.

tested-by: admiyo@os.amperecomputing.com


