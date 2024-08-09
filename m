Return-Path: <linux-acpi+bounces-7472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D568F94D3BD
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C381F21536
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2011990D7;
	Fri,  9 Aug 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hMK0A4xC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF69194C62;
	Fri,  9 Aug 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217919; cv=fail; b=Jndbx/nApM+DWBdF3YDCnSat8/2q18frEJxOnt7pMAbXf4oHCUoo1+9T1BuWn1dbPRMK9q5iYoStnJuoqwu0pCfGLe+Htb9QQhtCeVuYez1mjK+4w+TO9uWB3oMBmaxuxGmqiJpl/pt0j6uRvpFhUa8guAP3QQjoHP71KprWmhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217919; c=relaxed/simple;
	bh=uHIiiaDprwZB9khsaDZh6dY8KvjArNMx1+LTXY41WVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDTWIJ2loezSH4jzNf9nqJSqi7VNawUaFTf5dLj1JEQpDOFUULMjsF22yc5JBJAM4QrzYg3U7PbZaIMWOusIj8FD40X9Rz+cSWO34CnWQwZglGUx76qpzbmXK7ww9CK3J3rOwFYZep3Sw87HN4YlkJSVIb3C99lCCbUwOh9Qe2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hMK0A4xC; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAqTRJXBAzcOtiNcob/+k1EMc+WyTtD+rCwmJCvOZ9yuSuEWbZsBg0MYB8bGwH+FDzjAvxuwQ6dg3ZaHv286hIu/ofmc4O9RnhQP4GyyqtaSlJKLsmpxNtCOMf2SKiADcUp7uU/BTIpmvahkA9vZliDCRIWqHpuuFLEeNxwZpdFKYpf+sWZLoUa5E7IEuthoGQ8CRqNJc2LOhMKJ38AbSbz+pdRSG8SPBEbJftGCH1ELZz0/4m2IN0uXkjYpqEE3WnfFLspO/iJ4+gaWYgHJuWrI8eSzgV2fkJztKZtdWMbLadx36ZFseRcC5JwLNfQOofwldcR9NK9YJbDUwknesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utOH7c1gAZYKQNJpLyw7VI8ixKLHkEcZcNGuGxpTVkY=;
 b=xiiQRaFiLidY1HXefXiiWWKS/X16UVkDJl4feH6Lh1kyR30scRgXn/K4ACvybqmAZAryreWAN8K50XFdhMcKBaRiQ4upCG4fFRod98RXPSYyrVmqYEh4vvGXhdcAPxDOAWQoMYwDpUFCG5wsYQxO97Dv7vv7nSZJhOHludMQ5GWuk7qgvycf9CB5ky9CbfwN7hQfUbptu+uF9uDg/DUyKMb9EL/WS/JfYfI3zqNr5pbwI+iWw/EN1jgAltSDWEMoD5KeB0qm+yyZYFhB9+pEDQRkuEihJUu+k3FFwcmKXuzqfQESMdK5JrY3Ya8fLS0QnJIZI/wKUxLSJeMP3UnbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utOH7c1gAZYKQNJpLyw7VI8ixKLHkEcZcNGuGxpTVkY=;
 b=hMK0A4xCAkH5lSUeiK2xb3BbvX4vS+MdzWGkyAUCf1OPB1M/uSik9OS6hiZols6kzWXEpIWUr+GJ11lDyX7OOjjLp0k9Ttqm7ySDzOm+r7gHGCDBcCOkOAQCXB+Bb3JQh3TkRGlLoDPA9o1KOO/iahsDSuqU7qJpxTferTdLzXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 15:38:32 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 15:38:32 +0000
Message-ID: <7c550151-39a8-4155-ae9e-4796d9463cd4@amd.com>
Date: Fri, 9 Aug 2024 21:08:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: APD: Add AMDI0015 as platform device
Content-Language: en-US
To: rafael@kernel.org, lenb@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sanket Goswami <Sanket.Goswami@amd.com>
References: <20240718152324.3449253-1-Shyam-sundar.S-k@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240718152324.3449253-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: b6368217-2d29-4b10-5d87-08dcb8895291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDMyenBlc3lTaGxYU3RpOUJFQWlpUklOQ0NHUHZsWGFuM3phaHhFY0lqcVBu?=
 =?utf-8?B?WklnRFd5Z1piYlZzWStFVk9zNjdJMUNuVUhLdjAvaXovampRODlTTnVPVzdi?=
 =?utf-8?B?aXJXdnVoYTdBelIvMWQ0MkFSc2VDdFhJZnBiVy9PWmlKT3JjKzN3c0RTbndU?=
 =?utf-8?B?QnN1eWpaNFdURFhWZHZIL0JJc0lUUnp4amxYa3B2Q0VhMGZCd1VmKzQyOWow?=
 =?utf-8?B?eTFUblU4N1V6WjB0SFpWMkVJR2JmbUpTZTdyRjUrVjF2S3NhVVduV0lScG9y?=
 =?utf-8?B?eGFLTFhtUWpaODRkQi9laXZ3dW9ISXkyaUhWWWdhUklFOHlvZ3hzZzIyT2s3?=
 =?utf-8?B?WjNqRG5JNnh5VmRsaGhURkZ6VHp1M3IwSzRDQUpGaVl4YnBlbzgwNVpJczZW?=
 =?utf-8?B?OEJXQy9lbG1iRFVoc3lOVUhDZDJkakNNTFJXTTlmbkIwY2NaRnpDcDh4ZElI?=
 =?utf-8?B?Q2hkbThXM0NNd0dRYy9IM01NNkZlZjB4SWVNYVQ1U0prM2NSS0JBZ1lkcmZk?=
 =?utf-8?B?UTFLSHJJSTFWeEFXYzBaTEQ1cnB6UnJ5bGlreUtLK2tLdlpOMmRDVi94d3M3?=
 =?utf-8?B?VzNYRk4zUVlQRkVpbUFXbGd5VFhSdlRnZDAyOE1IL3FTeUFQcWltUEpsWm9u?=
 =?utf-8?B?Z3R0djA1MG1EaXhkVm9RNEQ1VVNjM29ZR0FjOHlsaHZQYjg1bkYzUlIxQlVZ?=
 =?utf-8?B?bCs2SHphd1ZYc1FCU3BZTlNIZHNHbGg2d0VaNGFsZXBWczllYjFFVm1xS3d2?=
 =?utf-8?B?TzlDZlpoQ243TEgrVmYyWS9wWXNwRm1iV3BDRTFYYXNzRkNlbWNqVmEyaTEr?=
 =?utf-8?B?ZGxhQzBHa2U3dkhsTXBNRDc0R2tUWEJRMTFwVCt5RHVBZUJrRk8zYm9ONmMw?=
 =?utf-8?B?VEp6Z3NkYTBpbUEwblJoaXVKNlE0TUpHYmxtM0swZ0ZXUVdmTFZsTnR1aHE5?=
 =?utf-8?B?S1h5Z1U2b2JIL0VKQUhuUElZZVE1Q0FzQlJpN0x0L2ZFRUJ5UWM0SlhmZFVi?=
 =?utf-8?B?Vlgxbyt1SEJTYTlYQmhyYitsZFZCTTMxNUE5OExHS0RyWG8zY3ZGKzJZS0JY?=
 =?utf-8?B?Ty9OcmhqaE1aZkN1Z054cmJIVUlWTDM3UCtGTFd3Rk5vbGh5dUhTa1BVYkJL?=
 =?utf-8?B?UFNvL3paZ3BhejlEVUdFUnM3N2ptdTJiR2lqdDNZZUxSSHh0ZHVOTytUOUR5?=
 =?utf-8?B?TW1pL1pDNVVML3NGS0JGcFZzUUppcjY1YkJUMGNja0h0RnZvalFIa2xRYkpa?=
 =?utf-8?B?TXhIcFFWWEhRNVlMSDkxY2pIODFSTmpBOGxCUHB1dGY1L1hUTkpXVDUzWjcr?=
 =?utf-8?B?VDhFcGpPOHd1S2UxWFJnN1dza0xGTHhkSFZnUEZYUzJ0d0poOFR4dFkvb0RG?=
 =?utf-8?B?ZGd4aEF4eVgrNzQ4bWk4aS9mZ1RGdmNHbVpOY3RtMm04YkEyWWFhdzZlZitP?=
 =?utf-8?B?K2psbitjSmRNMUNjVFZwMkFRY3lwZVhvNGJETVpnSVFTN0w4OHY1cTlpSkR0?=
 =?utf-8?B?a0R2djRNMERFZTJzZkVHY3J0VzJiSUtKdkViUytVOGRGaEZFSGlxRHhwWWwv?=
 =?utf-8?B?L083NTNLOWhUOWExRmdrTmxaaCtXcGZOSllBeEFjTjVtOWEybUlhcVJPWEho?=
 =?utf-8?B?V21vOUtHNWFDcGx0TUpyTXRmRGRLeFdKSTlHamNLUUx0U3FUemYyYU1nUXlv?=
 =?utf-8?B?d3pGdDJmVDlzWVN1eXhyUmRZc3NxZ2xJcEFGb2xYNGFrZTdzcmFrK2h5dXJO?=
 =?utf-8?B?bHE2VjJkdGcyay8yYjBwY0doUmZoZDY3Znlocmc5aGQ5MlgvdGxldTBMYVcz?=
 =?utf-8?B?ODZZUEs5OVJCeVhwRHZWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UURJSEF3RmJrUnFaTTd3Wk1nQnpvMGx1dEVPVm9kL3cvSVR4TXMrSW0xMlgw?=
 =?utf-8?B?ZVZPR2Z1dTJtQmRWdVNwcmtEeHlQUE10ZGRCTVEvd3JzNUZyWE5EYmpxbW5y?=
 =?utf-8?B?SmNtYUVQeDFlNmJXd2tlS25nR0NBcnVlS1ZsNmhlRE82U2s3R3ZLWFlDSVBK?=
 =?utf-8?B?T3N0VDArekdjdUNqRU05VG14VkJsQzhkV2FaLzhlVmNjeUNHeFArNXIxSTha?=
 =?utf-8?B?RXhycGQxWkdWZVVicU1lcEpuWk1lMlVDTVZndDRrdDBKZlZMWUFaNGpzL3dt?=
 =?utf-8?B?WlRWU05adFhUT1VRTlh6dEo1S2c0bzVodkFPVE1GdCthNzM0dExFM2E5b250?=
 =?utf-8?B?cmtRTVdGSjUzMURoVTFQejQzWThybm1PeHpSVjVURG11aXlzdFJzRmw3NkZ5?=
 =?utf-8?B?Q3B3OE5mNHBaYVRNWG9qdjVKUS9lS0JvbDMvZzZ5bExMYTdyMTF3cXdqUE50?=
 =?utf-8?B?elhGbnNOMXgrbzEvZ0lsdXJlVkNjY2hEZDhTOXlxOWlMT0JzcGVwb3pLMWZt?=
 =?utf-8?B?bEhnUnVBRnB5QWNjRHB4Q0sxRDlScHZZSVo2ZjhtRm9qMWoreG9zdFZqaW81?=
 =?utf-8?B?a3lJZEREeFE2ajdmY1haSFd3cVYvdEpQWEttSTN1NFNjQXEwbGxzSVFYYk0w?=
 =?utf-8?B?Mi93RzMrUTlFdXRScFBqQmMyRXVFY1pOalg4TjF0WDdLSlQ1dE5rS0hQODRW?=
 =?utf-8?B?SUZlYXJCdk9jeEdXK3BOQzRDTEl1SFB2UjdDbmZOWm5HVWpSdzdqSnlGU244?=
 =?utf-8?B?M0pNT0V3YlgwSU1rdlBKd0ZJalo3aC90SWs2YXQ3NGRSRjJSN2tTc2o4cDRs?=
 =?utf-8?B?K2cyenU5VFVENHR0a05BbWlIeDFkVVJNeGFrb0QvUzYxeWpmWDFab0d2dHl4?=
 =?utf-8?B?WVZJaDhiMEtGcXV3ekxOSXU0c2cxZ3dRNUE3VU5YSW8vZXhPVGpiY09ndDd6?=
 =?utf-8?B?Tm00RG9HNDkzand2NkNIWFFvZ2FRK1VVNlE0Yk05ZjcxSm9jb3p2bDVxMndQ?=
 =?utf-8?B?SGpEcEkwL2xZdVExcFVQSC9ad2ZDRUJ0dXd6ZEMzanJPRm9mdmdJK1hKZkUz?=
 =?utf-8?B?UDNLOUdBLzRYV1B5NUxxMm9pczE2MWdOMDl1eE8wa3doWnFTeWwxUHIxOWJy?=
 =?utf-8?B?RlhPaGJSczMrYWVkdWk2WGlWeHJxZGh6dWp2NjVSSWQ5bWkxeE00OHBSWW4x?=
 =?utf-8?B?N3FsM3FoNHI3VTNpV3NhTGxKMHZ0Nnp5SWMvdTlCd29IQjYxWVIyWnk0akF5?=
 =?utf-8?B?bXBqVlRmVlBMc1A4WVFjL0gvOHRNcDZjQUl2UmRQWjNZdVVKOUZvOVE2RjJx?=
 =?utf-8?B?MFZ5NUVxQ1ovRlVjWU1lcXNZam9FRjB0N2I0N01yaDM0MHRmc1BGRHEwMkZR?=
 =?utf-8?B?RFdBUXptSHdtdVZXRVNKRnhBWlA0VXIxOHoxQWcrZmZaNGpGRFNsaFdkS3U3?=
 =?utf-8?B?Rk10TDJkSTF0TldqcWZjY0twZW1YYTlyL1lLNmI4aVRyYXpyWFFubFF5MXNm?=
 =?utf-8?B?RXZ5TTErRHhIeEdYZ1FZc1dWV0JVNHpQem9Kem9QNnNZMzhlVHkvNENkT2hE?=
 =?utf-8?B?WnUzd250MDNkM0p3VUpndHBDaTg2dVFYb3E2V2c5NzRvNzhRdWdiUElVdjJR?=
 =?utf-8?B?QWZyVlY5d0h0aWdEMnFUdElmM3dIeEJOYjZRc3M0T1BpRDh4aHNYd3plaURU?=
 =?utf-8?B?Qkw0bkNoNU11Slh6MDZJZXNMcXBKYUhkbW9EWlhFU2JaUWlkdXNONm1uQWNs?=
 =?utf-8?B?QXB5SXgrTHJQcGI4NHFkWXU1S1JyZWs0MzRCRU1tbmx1RjBhVmE1aGEwRmZi?=
 =?utf-8?B?R3RReG85VVN4T3FKaFNiUEhTQmxvWlJVVGJnNldXeUQwZ1dNMGZiMUZMMFNw?=
 =?utf-8?B?ckxrWUZXSDkxaDRtMWdMYUlnenNlNHo4YTFndzdxZWttenRGRHA1VS95a0F3?=
 =?utf-8?B?dk5MSjd0bmhNMndkSHQxdHJLTHg4aEdzTlRyZ2dYN3Y1K09oMWQwV3g5Tm5C?=
 =?utf-8?B?eUFvdlhQcVlNZ3AxbFF4YWgrdmlZWXp1Tk1JUzJLTTdUUU15K2VzSHlKS1Qv?=
 =?utf-8?B?aXRkT0o4cDNsY3BaREdMUXVCZFhNL0MyVXJzUUtXQ2dKUEI4SVkwcGNLb2Iw?=
 =?utf-8?Q?pveIBhsEeByDp5i5d6/Hu5VTZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6368217-2d29-4b10-5d87-08dcb8895291
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:38:31.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+XQA4EHsyGB9lbKmRC5kpyBtTTskqgKtBPzijXXkOOEJTRstCQq574a8g4UgsRnIHWIttsdyOAnpKWkdnwnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

+Andy

On 7/18/2024 20:53, Shyam Sundar S K wrote:
> Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
> for the I3C device on the latest AMD platforms.
> 
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/acpi/acpi_apd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 80f945cbec8a..6c502268879e 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -118,6 +118,11 @@ static const struct apd_device_desc wt_i2c_desc = {
>  	.fixed_clk_rate = 150000000,
>  };
>  
> +static const struct apd_device_desc wt_i3c_desc = {
> +	.setup = acpi_apd_setup,
> +	.fixed_clk_rate = 125000000,
> +};
> +
>  static struct property_entry uart_properties[] = {
>  	PROPERTY_ENTRY_U32("reg-io-width", 4),
>  	PROPERTY_ENTRY_U32("reg-shift", 2),
> @@ -232,6 +237,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>  	{ "AMD0040", APD_ADDR(fch_misc_desc)},
>  	{ "AMDI0010", APD_ADDR(wt_i2c_desc) },
>  	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
> +	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },

FYI..

AMDI0015 is for MIPI I3C (we call it I3C legacy) version of the
implementation.

and.. MIPI0100 is for HCI based implementation of the MIPI I3C
Specification.

Thanks,
Shyam

>  	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
>  	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
>  	{ "HYGO0010", APD_ADDR(wt_i2c_desc) },

