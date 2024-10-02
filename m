Return-Path: <linux-acpi+bounces-8532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB098D4D2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73750283A62
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99221D0430;
	Wed,  2 Oct 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cc2gdsxk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32151D043C;
	Wed,  2 Oct 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875466; cv=fail; b=t8YURTB6ltNtUBejwEsodXTJ+g7Ld1kE+QqkkeDD/VxxJ9Df17h4dAEcU4AvCqHBjUVAfX1xmOwvPhrhF9/ODE65zz3/gUIc723aowPAGjEaPe47DM/pQKl2bQxxtrwFa3B85NzkrNAHelPGG5b0aPhrocgGfxRnnwMmBleB/S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875466; c=relaxed/simple;
	bh=CUz9tNqPQw9H2JJkV9FYrcTOwgpIRyP41D1v6PtYJfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqsMDOXkk3QMCvAoXO3fOCcTC0e+FwwMgazjIeEOuzTwGzEZB9HnjqSbOsCShIOR9wjDEN+hbfbG5qX5fU6tGF2jHjQRlm6GcXEy5NsGT0QOm6+diPZliPnbGOt9YFv1JZqNoItg6mIiURdoQVYLPHDJQTap/Tcp2sI0oLBt7OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cc2gdsxk; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcTi3TE2ONAjB4pfDIW6AcvH5AB1YL1LvZM7QRMaFzOXPOjZYX/1pYZwYg6NBd/wjFYXkC5Hxi3n8wWUGS03Ajy9KFDqUTXrD0qv0J4FNQah/glHV9Uvin066kPJ8LPPh4/7Kicb61zAD8RMzE/fx7KwNXwH6Tkzo3XbHrud7Uuip2Ljqc6xUAwq1fr0EmeSUA73z2r7/fCODtWXCht0yXX4GsKybgwxcFvh/djQk4QAvC4f9gQQYDIMQ7gD59wRKyzYHCN/Tz10bfTTBzffMCcfcqIeE/zwJjkSMgY/Baxeq0D1jlIPI+Pe3+yXMbJBAN5BWIVEbSSeHgCxSflpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMc3CRaHMSAgoRdAN1ydC2xhAd9CMc7KpEqW+jLCj/4=;
 b=pxUXV+CDdb/OevBJOLZJYMUGx3kDdBnORgwf2km/589M7gxKwxa6FDB1foWBJttwwDzRWHxM4cOZZ42P+cKIP4/wFEM3tgq/4HGPQHeabuKVMY3CrcslU5mzIwZqZMwEK8I6rPr60Mt8z5jg81tHZkf4QZFiPLhdnmg9G9dThM5IiriExQUMPe9zH3RCKDFi0MGa8YwyVwy+GCDi309rWhxc+QmJUpxxGKapnd8nkL0TyoXCnWuvQvNeez8ldzvcFC/R7t9dVbkR+0q/P+OLOWwdR5B4VtWz4sZ6N++Kh9KK2iLWyVxnwIFM1YgV/ahqavKSDAi2AQjUJLhQYyf6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMc3CRaHMSAgoRdAN1ydC2xhAd9CMc7KpEqW+jLCj/4=;
 b=cc2gdsxkLSaX+N+lt92wIhancnT+wi8qohBR80YAev1LZe2S+X7WEMZkirdcZOF9uoSU/8yPGZltKIvxQZbd/kTwFtmn4IdRpw4qH79UUysSSM7GLOZjNK+Fh9yhMFsrM9o3LS7nCjMAPN/lJMio4LNGNW4Hysw+M0i2L4RvbfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 13:24:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 13:24:20 +0000
Message-ID: <fd9a3ed9-08a5-48c2-af96-573c010439c1@amd.com>
Date: Wed, 2 Oct 2024 08:24:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: s2idle issue on Dell G51 5155
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <6274fdb7-ba80-4c34-94c8-04b7ff29a8c9@gmx.de>
 <CAJZ5v0hwUrnooYRTvpRogDjmn=tsEsR=uSPHkDAOtoDNT+poBg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hwUrnooYRTvpRogDjmn=tsEsR=uSPHkDAOtoDNT+poBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a659758-40f1-4416-009a-08dce2e585fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bS9QeE83R2xVMmJFMWpBN2NYZ29YSlpmOW5LSXhoMjJ0NnAyR1ZUVXpiUlNi?=
 =?utf-8?B?NEFIVmdsUkR0M2dVME5Sc2p2NW1YQVhPbFN5NVJnaFVyVGZsSFZuTUlIQ1Rw?=
 =?utf-8?B?QVE2UENLbTBHUUVRQnJVb0J0dFNXNVpRZUtDRW9yZzZmNlVsbnhVODJBQ01E?=
 =?utf-8?B?L1hGV1lGKzZkV2ErUFNEbGhrMVEvMWhqVWJ1ZlFVRE84MU5UNzdOMnpzZzZ1?=
 =?utf-8?B?VUN4Z3dxT0FQR3ZOajYramhza0J1Z1cvcU01cEhEQXBhK3RFV0w1TUxFRGc0?=
 =?utf-8?B?aWg1SUh3Qk0wWFNLM3Y2c1lEdFRGaU1UaHRxQzJ6OXNHQWFYQ3h5TGw4M0pK?=
 =?utf-8?B?S2doVUVLUjNsTDJMcHBvRHN3dmUrNWZTWm9SWXU4ZEpoemxidE5ZTUpSUUc2?=
 =?utf-8?B?VGhwTHN5MFN2TzB2OFF1L2FZMzJXNWJjaVB1dXhCT0FFYVNqYjJVNmxNV3hQ?=
 =?utf-8?B?bDlVdVhNbHpqKytsd3VPS05kZU11YmhEaHloNlZBYkI3S0NkSGFkY3FEV0Qx?=
 =?utf-8?B?ZDlhc2ZBdDUzYnJtN2hKaWxJOWFhbUpyaHF0WDc3YlNvVXNQYk1BNDhJVHRM?=
 =?utf-8?B?eWlRWDVYNVVWdFhaMDdLYXZ5VjJXYUY2SE1PcDRlamxITnNoUTlTajBvb3Jn?=
 =?utf-8?B?Y3BncklKbWdVajNSbkwwNFVCWUtCdjNLb29qaHpYbjR1RnNWRUlTOGhGZVJm?=
 =?utf-8?B?dndYbFlKTWN1UnN1WHJYWk52anVtRlF4eFlFRS9yMC9IU3JaaGRpVTRTbnNw?=
 =?utf-8?B?cGNjY3RyendSd3dkTDMrcXgwQ080RVdaMjdGbGdEemQ3cnR0a3Baa1B4ZE5t?=
 =?utf-8?B?Y2lSR1MvR1p1TXlrWXNQaDV4NWM5aG43YjhPNzU0RGJndzN0V0xGTVQ1RFRn?=
 =?utf-8?B?dmQyOFZNYnNiSUNkV210QTRQTnNtUnZUNFRRMGdaNnhWd0g2WXhqTko4cVZS?=
 =?utf-8?B?K2NaSTA4THhwRU8yN050c3pNL1ZNcE5Mcm5qc1RFdTFhZ0Z1ZU95SmI5enha?=
 =?utf-8?B?SDJSdlJReHE4NEVIRThhUEJXcXJmZXlyb3NJRHFyTzNiWm81Y0Fha2pUVGx1?=
 =?utf-8?B?SVc0c3d1WjR5Qm0wNzh2Y3dJc3FNd0U0SEkxNnBiRDl4aXVIQ3ovMVNGQS9F?=
 =?utf-8?B?SlpSOTFUVHVzY1dpVXhxMmh3eTB3N09Lb2NmMmdxRkZFZkpJVzBtUC8vR0V6?=
 =?utf-8?B?OUJUWlhtUXgzdDR1dkp5N21NR2RHWEZNMmUvVEI5YUh0REg5dVBlekRWMm1Q?=
 =?utf-8?B?c1ZsZzdjTDNaNVFQQ0RmSjdHQlBhb0thcm1Xd0grZjNmd2trTnJNN0d0anUz?=
 =?utf-8?B?dnJFZnE1aUxlaWdsSTdnLyt6T3NodjdGaE5PbGh1NlRWU255ZkwyQXg0With?=
 =?utf-8?B?RlRRdEUyWW1Nd0p4dVFSd2E4V1ozc3dRWUhtWS9VdFJnNVVFdzlMM0FodWs3?=
 =?utf-8?B?OHN4Q2gvVVhSbkxzemhqQ3VwQkhiMEh6aFY1T1BtcWdMQmV6RlJ4TTBpV1Bo?=
 =?utf-8?B?SGg5N2lrYTNWYkluSlpiVGlIdkZvWFBpbkxPeVUzZlgrYjhqcHBydlVXZkxK?=
 =?utf-8?B?MkRVWGJvTmZRMmRJb3B2ZVBqKzZvT0tLeFkxam53d3FzUFNVMmYvN2JoOEhV?=
 =?utf-8?B?ZzUvdEpQTnRtUTlFQy96Z3BscEVCdVIrTDBZVkxGRSt3a3dvdCs2eGcvQ0x3?=
 =?utf-8?B?bElFTUg3R0ovclV5d1dXUjExVThYWmNNdkt5Vm00YUZFSjdqVXZ3NS93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStya0VZazNtQitnRGVTZDNBeUtWU0tZdjI5R3F2Z1QrTXZSVWdtMTRnWVJL?=
 =?utf-8?B?ekloek9wY0NnaEhNQzlneGFSR3k3aTNiVWI5SURUNENKWTYxS3lrWXNsbWNT?=
 =?utf-8?B?Qi8yZUFwUWVuajA5c2xIVU5ydStXNTVrVDA5QkxTd2NTZmJZREhydzBzcUlR?=
 =?utf-8?B?b3kvbndKOWNha0w4NTk0eE1vNElJSm5Gak1sVVl4cnNxTzlKRTBYSWExbW5R?=
 =?utf-8?B?ZDNsQ3g4bCtsUXc1ZzVyM2JXZTc3MldhZm4vSkk0MVJPbk04eXF3TVQ4eFds?=
 =?utf-8?B?VmQyK2hkSUNhVnZ1dVd1VlVxMDRTZm9pZStrZGp6THhrSlY1V0VPSkdHRVUv?=
 =?utf-8?B?eWdML2N1NVpRYU8wajBpWjRPejJpQWlrM0VSVktlaW5lb0VpZFhwTkhGZExk?=
 =?utf-8?B?cmhGVm1TWnNvU2FRa0w5WWJLcmIyZ0NZbENndVpOTnVMT0tjdzJib285TnE0?=
 =?utf-8?B?ZFZuc2M5TlJHUEprY2h4S1pSakhvUitza1Myb0x4dDFxczlXU09iVmpSQlp6?=
 =?utf-8?B?L0VWeGtpaWNFS2RONG9idGRRS1lqUHlubGVxV3EvR2J3RXY4ellacUEyUjVa?=
 =?utf-8?B?TU41Y0dmb3FBcVlsQWNVV25XNFdTU0lrT2xHZ2lCTG1OZUZEdGUwLzFuM1dV?=
 =?utf-8?B?WDI2NE1MT29WNlJTOW1oeWF4cUtwT2dFcTJMM2RKSmxCQVlkaHlYNmZ0ekNH?=
 =?utf-8?B?YXY4NVl0V2pUNUcxZ1NubS96ZmZvWFJXNFVTbjkzYklNMXV6K01VcWVKLzE3?=
 =?utf-8?B?ek1vb2k1SWJ3OStHcnRya2YrcWUxT3V0em5ldkdBTzg3R0gvQXVKTWZBaW1T?=
 =?utf-8?B?WDhzTDUwYU1HNzRWVEdCa3Vlc3pERW9aUmhDaUkwc3g4S25LbFg3RFMzUEpR?=
 =?utf-8?B?VjM4dXRRb2NDYVVLZlgyRlNJVnRSZHIxaGRlZEdBTjd6eWthQ3JEaHE1VVcv?=
 =?utf-8?B?cjM4SW5uUHppK3czdFc3bVk3Ymcya1VJVVVUTU5LZ1pTUC9UcFk1S3dSV04x?=
 =?utf-8?B?ZVk5ZFRpU0h5WFF1bVNTcXRzaERTd3dUQkNYVllzbzV5a0FjakdTYVk4NW1Y?=
 =?utf-8?B?a3VDZ2tSRjgzV1RLdDg3MHBJS2dLUU5YU1Z1RnNyL1IrbGEvNjJwSFRsREhk?=
 =?utf-8?B?QmZFK0dpYkozS210N1E0Z3BuTGZQcGJ2cVIxKzV3N3h6aUMybDJNakR3b3JB?=
 =?utf-8?B?MlNGSjJkaU5EeGFlai90M001RTVwN3lFcnNaQVl6YzJmWmJmZzJqKzQxU21l?=
 =?utf-8?B?YTlzNDZrYVRxU1M5dEJSZTY4bDlHMThPOTV1VXVHT2ZTejFPbVRPWm5qYVRB?=
 =?utf-8?B?OHpWS2p0TGI2R2JqSkI0RFAzVzMvbkNuQjV1N21BaXR5QkIwcEVqNVdJV1Yy?=
 =?utf-8?B?dmdwdGZMK0krL2FnamFOMWdRSjdMOFd2RnQzQzVra1N0a1Rvc3VLQmRyUGZU?=
 =?utf-8?B?NzNzZmVaNGtYZmhRMHNycE5jeFM5aHhpdG9ZYVRIblI2Y0N1R2lja1BJVDF6?=
 =?utf-8?B?bjlmVldzd2JFdksvb3ZyaUFvUnRCZ1R4Y0kvWmlZNGdJUkU4TWlQOVF3cE9u?=
 =?utf-8?B?aE44TTJ5WlpFNmZKVXEwa3l0ZUo5azFhU2lhbWhabWhQZXhUVmpOVzJtdmdm?=
 =?utf-8?B?VzFSaWR5KzIxQzVlUHBpb0wxMnAwNFFZOERMZlI5YnY5MWV5cHdVUUI3YWdk?=
 =?utf-8?B?NkNEKzhxUU81d2swOFpmVHEwNXQwZUhPUzdXUHR4T1FxUnY5cGp0cjRUS2Rw?=
 =?utf-8?B?a0w1ZFY2eHFLVkNBVWRrQWZWbFhPZVhpNUIzMTZJUmV4Wm5ZS1JVSklIYXhX?=
 =?utf-8?B?UTJXaFFqWW9BZUNTdng0anlObkplcjcwQ1dJU3JSMkpYaFhNMlFzVjNuZm5M?=
 =?utf-8?B?eW55WUVZNFd3YkFCZWZCQzhGRE9jd2RaQnRKYkp6YUhZKzd0WGFwRUF5em1i?=
 =?utf-8?B?OXdXajVyZjRqamtRNy9DRlllSFFXajk0ZXdiMm96bW5BQ3lwSGgwYURGK1dR?=
 =?utf-8?B?OVArNlNDS2o0SDErOG9BSzdtd01xMDMvZDk3eitIL1dRaFJvUHg3dUh5cHlh?=
 =?utf-8?B?RFU1YkYvK3RPdFUvY1RwekpjTFRPM0c2MzN0NlM1WFpPWTlGbzVLMDd1cndM?=
 =?utf-8?Q?oMh/9S+J+6tvvCfYKDE8FNd9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a659758-40f1-4416-009a-08dce2e585fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:24:20.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvVME2UppKrre+y2A6cHax2MSzPU60X7zEFRHizOcPfX5t7acH/jBI9cSsv7QVkv1lfglDwEjjXMpoDLakPauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On 10/2/2024 07:00, Rafael J. Wysocki wrote:
> +Mario and linux-pm
> 
> On Wed, Oct 2, 2024 at 10:08 AM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Hello,
>>
>> it seems a user has problems suspending its Dell G51 5155 using s2idle, see
>> https://bugzilla.kernel.org/show_bug.cgi?id=218337 for details.
>>
>> Does anyone have an idea on how to debug this?
>>
>> Thanks,
>> Armin Wolf
>>
>>

Thanks, I'll drop a suggestion on the bug and add myself to it.

