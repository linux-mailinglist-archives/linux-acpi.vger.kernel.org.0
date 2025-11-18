Return-Path: <linux-acpi+bounces-19006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00969C687AE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC534313C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02F3112C0;
	Tue, 18 Nov 2025 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrhB6NlO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386530649B;
	Tue, 18 Nov 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457462; cv=fail; b=LJVuVpjcy9LpZHghQTVjfPhAKiLOPqf70M0cTBf30dQ1V8pdpxaWMgiOXDPCrLLbixKjclQY7d5sGzthGdUnumONEfu9eJmmRPoFPPMTVfewmybMm3AuS+EpP3D8J4vdE4QQoY5PeUdQCsOzucn1eaQcCm1fk/1Vaoy7CVRNYOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457462; c=relaxed/simple;
	bh=c5f1qwxGH7IkXetRhnXqG2y2jrhs0LFJVzxRBAY1dCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBQqYJVA71nuVnpBU8Dq2b/TumkvcEa+qz+VPckgeTNYsDiL0LSpgg1zjzeXLGe4Om5SZiWPal3YknerZXlp7gAdKHXBwfIsp4HQujlPcL4KaUbOwTcTqU+m1UW/SJNaIiCayYs3BM/RFAeCOAUoXkG4xOoP/cGDX0BFCU0dM2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrhB6NlO; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZS5TJTpnCKUfGQNtBEVJHPa2JK7oKs/hM+tNjQEUgvuLik8FodCFORGg0tTNQrhAvXZW7l7EBLrAGZA8vJwBXCCzaGmRb7FXerfk/qJKLqzHonnwiaBowv2fVazwW7DLE9RCMXhpDBuwkIoEDPcMlw/y5DVo1d/s6fWWeP1COqsEBFRlmKMzBBYTF728cmh1dkE6dUz2iYikhV80KhEYbhONX9rXN1wePdMGJnEMJTHdbjKclMbkNuoaAZkYZxHmewUowskDAIb76H4O/1rfLG0GSqOdZhWiA+Qql7XXKvxWQ49P8J7ME+V2TU0AO/fSvQFvqmlubMRbLqG4A0jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bsoyUBRDbIrjqQ0x1WC85/1rExKyw6Pc9G1B5QoKPA=;
 b=EOiLHJ95V93cAeHa2xb7wGSHHjBeKGcC9gS1ZAlgvuHjjGM05rqXx8A6ISS28Pc8DEr3rGHlSWWQIakfhTLi/4Pr+098TB4Yt+qewkHPT2GH7mSCXVuzJ4vzdVgU/m6mxZ+zDWBp07MS4fuookLWWfY2WcJ67ZetECDQj7NlHG9RREqQ8lriUGo6dPcEcPceIspQYv/nCfiK6HMRwO2062/1S2PLRJUZKAbXZ8plk6d55+aThpkfPrwjAV9d3GDxlBzfsHRXvzrgAHZIlmKrdyFhBdZcVjArTPCC3PRsq/f+MeGtk6BZMhULy6UMEq2ZstgDae1oZpVLuIWaz1zl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bsoyUBRDbIrjqQ0x1WC85/1rExKyw6Pc9G1B5QoKPA=;
 b=VrhB6NlOa6t9bG3L/dWNe3UdtyIdZtMsl1ZDg88b/NJdiLyCJDp6Kd+KT/IG8GKdxfMVQ3IE7Esn7es3pfj6AjUKB23IYJsq63U9dLzJQO2z8JR095Vchmi+GgzMqjNSsSG5KOfU6txJRFGJW1KRn93fU7Tqvr9tmqdP9N8EtDZhLNfNJUjSHJAF37P9zWSCbIOEZ1sIjOFVZCaa79cpNv9GmSv9uPEYByp9T4pbea+WAUux2P5gIj3ftFmOGRvZgmAw0Oy6Ec7RgP7dKkRbDPGfsy+dt4ujik+NUUNszHhVDYa1Vj0g4Usw9c25nt49CXbU4TKplE4GZXEXKa2L3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:17:36 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:17:36 +0000
Message-ID: <eaa37577-006f-42d0-b59c-01a77f30587c@nvidia.com>
Date: Tue, 18 Nov 2025 14:47:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-4-sumitg@nvidia.com> <aRShdY+QNQZdRewN@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aRShdY+QNQZdRewN@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: df297642-a366-43a9-84aa-08de26835050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXMyWDJsMzRkdng4YTMvSUJjLzlUTHdJTU9vYXVmeEdxVWZYU0xHcm9ERjF6?=
 =?utf-8?B?TFVrbzlldWF0UC9VckRqTXpEVEtCbnd5MnpzSWt5VHJ6a2FNUmdERkdPNXNE?=
 =?utf-8?B?L2lYYlJnSWlhMXZ5dkhYOHRWaVFHbDA2czA1NjFFazBmNExZZDFEYXkxeVBM?=
 =?utf-8?B?RGVtU1pjQmNueXhtWm9iY0VNY1RCd3NmSTIySWd6N3NnelBTWm5GL1dXeFBC?=
 =?utf-8?B?a295Q0huNmdOTkpJR3lhbC9oOTVmaUNRWWhBQVF2TjdoSmY3b3JzVG8ralJz?=
 =?utf-8?B?cThqYVZ3SkhNZjNRbUZta0JvZVRvWjc3eHhmLytGYWRiem5RSFlrdHUxSXQv?=
 =?utf-8?B?d1B1aXFIRzVTWG00djdXSWJZVmxrV283aXBhakNkeXFPcHorV3BsdXh4SkZ2?=
 =?utf-8?B?KzRudXhJVzZ2bENtWVBNekRXa0VGc0UzMy9ZUUVveDZBWWJ6ek92V0Q1M1dt?=
 =?utf-8?B?dlJyQjlQVEdyZkdra3A5ZUxldnEwR1dXQWVqRUlwK0ZsY2REMmlDWXZZZWxR?=
 =?utf-8?B?dXhVYSs2NWFINHdhcGNOTVErWXkydFV3eE1JcFB5bFA3Q2ZISTM2QXBUTnZo?=
 =?utf-8?B?bWtNMlpqTGVBY2d3MXY1SFdaU2hUMkVZZ29GSzZteWpLRTJBdjJaM1hJZkMw?=
 =?utf-8?B?UzNQU0JzOHNXQ1BpK05ldnZFbkpoQml3VEhlMk1DQkpGSFkwZndScmRwdFlL?=
 =?utf-8?B?WWhLOWlKNE1IdXJlcEhWYTJLVHpxaVYrVnQ1OGJyOWdqMkZXNFV3UFBzanJ6?=
 =?utf-8?B?RVdOUnpVT0ZUUVFreFV3NWdlNVNodC9oVmhiS2lIUDF3REVTS3ZHZ0hHSXhY?=
 =?utf-8?B?ZEg0bU1WNVNZeUJPM05IR0tSV21QUE5vMWFpRWpQRE5EcW5qdnIwUzFNZWta?=
 =?utf-8?B?cUl6aHZYODl5WHByclRrMnJjeU13MHczZXRHc0d6bERsazZLMjhEOXZ6VStr?=
 =?utf-8?B?K3VCK01uTWtjOTZhNjFaT3pmaWEybzFGdThmSWVxbEJRTVEzQnIwUVdNbkJk?=
 =?utf-8?B?SGZ0WU52SkVQOGQ1eERkNytwbmNyQXRjdmovU1Jod1FGVU9saW9RYlVCMTFK?=
 =?utf-8?B?cE43RmI3YXR5cTJhaEhvdlRySWI4bDczVllhZVo4eEcxYVJYN2YrNzd2SnVW?=
 =?utf-8?B?VU1INHFtT09rZVgyZ0x3Z1czSzdvZFdCajM4MStiaFBEUG9xb1dwOFlqLzNU?=
 =?utf-8?B?cjZueFkvSzdoelY2ZjBvYkhINUhPM0NPQy9EcFhyOW0vN1A0bE12MEQvQ25v?=
 =?utf-8?B?RUw5V3VoeTJ4S3h5U014M05pRmllMUg5ZUxUVzlmQW55L0trS0wrSVY3VXp4?=
 =?utf-8?B?aDhrYm13OU9zOENLSUdPTkNjdFhiRmkwRXprb0QzM0xEeHk0Z0FaMUQwc29C?=
 =?utf-8?B?MDRNRmN6TnhmL0tycUQ5QjRTemZUd3diZTd4WWQwcVhrMytESHVzM2J3aURm?=
 =?utf-8?B?dlZCSXVqcXEwOHVTcGIvcDVLRlJJVnJ2ZlFWN2I1bDY3Vkp0WTBmdnZJQUZY?=
 =?utf-8?B?S3gvSzZSWENwV29KanBxUk5yNWZldW14VUI2MXhoM3QwVWJHZkdFcTRQcUdO?=
 =?utf-8?B?MlZ1Vm5yQWdieGhNeEIrZDh6Y1NyYWJGbFloZDVncTh5ZXg4QmIrYXNDOTAx?=
 =?utf-8?B?NVVOYlp0RStHVVF3RkdUSzJBeVNEZ1hLQ0lMLyttOGZIaldGdnNpcFBUSmw4?=
 =?utf-8?B?Z0lvZmJoa295RC8xUVAvaTNYMktiVU5qcVpPN25VQ1lCTnJXOEhyYUplZFZX?=
 =?utf-8?B?ZjhVOVIxMXkrU0lncnQ5aVBEZS9FQUZKSDdYbnI2SThYMzNzR2VuYXpjb21I?=
 =?utf-8?B?WFpwTWtidzQwbEpXcExuWjdDNmppYjc0UHpwVDlKZFRJT3p3MkwwUjVkUE9Q?=
 =?utf-8?B?UzkxK0dNWE1OVVFROVNjS3E5VVdVY1NOMGdzcnVHN3F1Z3BicTl2cXJNeWQ3?=
 =?utf-8?B?WjZmT2hyMmJsa2RXeDZVSHFVSnYzbFZncTZNZEg2SjY2cUdBazNlbE9STkpO?=
 =?utf-8?B?eE1zdFhqYXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2YvQ3N6eWNvZTQyRnNUUnBqOUFZUm9KV2tlckVEMGROVHAvMnFpeityenFu?=
 =?utf-8?B?OExZYjd3Y1hHa1B3U1RCMGcyM0tWdjMvN20vR2xoK3FqQXJtN1pyNmNadkts?=
 =?utf-8?B?V1hZTlcxelQvSUdFU2N6R0F5M2htdGFmQVBFRVJzMERVZFVjeUpJSGw3azZC?=
 =?utf-8?B?Y3J1ZDRoY0xKckNKcUdHa2pKc0NoeTFqUHFpTkRkelF1T1JwNlk3LzhPL0Vn?=
 =?utf-8?B?SFZZOVpQSXdvSkN0L0NiemQ3c1U4VnRhWjU4cWNJdmt1U3pVVXNVZDEvZmdN?=
 =?utf-8?B?eEtCME1KVVhqeDFkVS9DaGdCblpCQjBCS255ZURsS0VzMWgwUXBKWmw5d2Mx?=
 =?utf-8?B?OWhZdFozUHY4UjdsZ0VQZTVIV1k5V0N2cE80WXFwZXBqNlE0WFFiaW9jd2hv?=
 =?utf-8?B?bExWUm9BSHZNdnFHVmRKZWJVTnFpbU9FaG9sVXV2OTMzS1lYeS91WnUxdFkx?=
 =?utf-8?B?dVVVUktaa2tReFoyaHVKM2xLLzJldUZtNHdTYU9IMmxKUUlvakp5Tk9Ybjhh?=
 =?utf-8?B?a3hOYjFkNU9zZmtEZktZWlFtSXcwUjNRYXJlbHJrWFM1OUZpL2hmWjZKaG5U?=
 =?utf-8?B?c0tjNWtrMmdnTjFqeEFHSWV5SjlLdE82S0EzeWVsaDRMeXFDOW1ZWDN2OFJ3?=
 =?utf-8?B?dXJRUWFQbmVWZ2UyZ1JzcjkzYW9XYndZL2FXM2c2bWduYVJzSlNSTGcvZjBp?=
 =?utf-8?B?c1EvU2Q4YjVwRm5KYTU2M2U2VGE2bVo0cEhWM2Jjd3QxektrWXR3T0dWZjBQ?=
 =?utf-8?B?akgwZCt1T1YrVUoxQ0VvYmdjY3BjRmE5N093a2dENkg3d05NV01DYjBQN0hC?=
 =?utf-8?B?UnBGTmlHQkltR1p2eXRmK3l5bXV3bnZ6aTZaZ3REOEFzZk02eTRTTGNDZkR0?=
 =?utf-8?B?TjJLZlMzSThIeTMwcEc3a0VJZUFKRnVFRWIrT0laMlVUclByUktVQTBQTDAy?=
 =?utf-8?B?aVduamY1VVdndUxpYTR0d1h3MVlnRGVZT1BnSlVNcTdMZVRzS1FQN3BGRVgz?=
 =?utf-8?B?VHZ5clByek44S09rbDl0SDFnSCsxdHp4Qk1jdjhWb0xWbmxLQlRpeFdkNkNw?=
 =?utf-8?B?RFFPcitsT1dFankvRXpQMDI3NCtCdlpPZE5jUFVxU3lrT1JGc0IrMGRmdWNa?=
 =?utf-8?B?Ryt3RDFrQU15Q0RVWlFhaUd2RS93bkpsc2txVjBOelVCT1FMN1VSck1tWlF0?=
 =?utf-8?B?RU1XS2I2c2VIdklsU1pXQTVwM2tBNWdSWlpkNzlsSlp2VVhzVE9LYlAwZ0FC?=
 =?utf-8?B?MEU1VVVRWHk1a3ZwVERvRFNwQU14ZXRWTnk1UnI0NVdVSFlDSWd2bFBmS21E?=
 =?utf-8?B?bUx5SFF3OTRKQ3lJR1F0ZGY0a1gwRmNMQjlMVnlVWjdkZVNKc1orekVudWoz?=
 =?utf-8?B?YzR5WDRnSm1NTFY2eHBLaUpKWmdyc3VoRlJxR3BnNUc2WWYwSmtzS0Jta0xZ?=
 =?utf-8?B?emRYd3F2N0ZpOXZCL3o0NkM2dkc3YWhEMGxyWDZPaWpaUHo1RXI0VjIzQ2Qv?=
 =?utf-8?B?ODNFVVBJYUg3V3BnTG5WK2p3d1ZpUk9ad0g3YTV6UXJUbTJ3T3hyOGlJSlk1?=
 =?utf-8?B?UjlDb09nV0Fsc3lWcUNHWlVMZ3N6U2lWMnpHb01DMlJ3TmRaV0hkK3ZCbXYv?=
 =?utf-8?B?NjN4NlUzSHloc2E4eElsYTFMRG1TMHR4WkNveXdhNTNDdHdMTkZlVm55Qi9m?=
 =?utf-8?B?U3FYckxnVmJjSUFwRmdycEhlaEtFa2d2T1E1cC9zYjMvZGhmR1dBZ0swTU5E?=
 =?utf-8?B?MDBVbTJQeWxTYStzRjJhaXRpSzZlbnVHQTBsWkZOdHpDUmNTOXB0KzJpMWJW?=
 =?utf-8?B?bzNIV2VxUm1icGFPVFFpbUFNNjRhb0p2Mk94UXJRblJraDV5MVJUMm5FN2g3?=
 =?utf-8?B?V2lLQ0t6L3p6YlJQcnVlYWE0MFdCQUovTWt2VEVyUVlqNUNwMkVOYkVzd0NO?=
 =?utf-8?B?a08rSlNVUDcrVXZjaDE4SXVrRHRPcnhEb3NqUFNxakczMjAvSXpPM3ZCN1o0?=
 =?utf-8?B?blBqMy9FejhpOHhUbEtqYTQ4cTAvYjhXZ0xxUWhMWmlIVkpZbjVjQm9ZbWls?=
 =?utf-8?B?eGZJZDNSMGt0RHowSHl3UElZT2Yrd1JiS0twYm1DUVBqcHNiR3A1WEtaUktU?=
 =?utf-8?Q?SUBhyDZ+DqL0vD9iOYfiz8IG6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df297642-a366-43a9-84aa-08de26835050
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:36.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgljCF0ezyAe2ojMa5cLrbbbnNWQ8C3QX2zessVBNE0aenEo9ILhoorNR8hz2ECcBS8AEbrBftgctEbN/cAgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850

Hi Ionela,

On 12/11/25 20:32, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> A small nit that applies to multiple places: let's keep the line length
> under 80 characters - the lines seem easy to split.
Wrapped line length to 100 as per the max limit.
Will change to 80 chars if that's preferred.

   $ grep "max_line_length =" scripts/checkpatch.pl
   my $max_line_length = 100;


>
> On Wednesday 05 Nov 2025 at 17:08:39 (+0530), Sumit Gupta wrote:
>> - Add auto_sel read support in cppc_get_perf_caps().
>> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
>> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>>    the same is available in 'struct cppc_perf_ctrls' which is used.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++--------
>>   include/acpi/cppc_acpi.h |  1 -
>>   2 files changed, 34 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 05672c30187c..757e8ce87e9b 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1344,8 +1344,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>        struct cpc_register_resource *highest_reg, *lowest_reg,
>>                *lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
>> -             *low_freq_reg = NULL, *nom_freq_reg = NULL;
>> -     u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
>> +             *low_freq_reg = NULL, *nom_freq_reg = NULL, *auto_sel_reg = NULL;
>> +     u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0, auto_sel = 0;
>>        int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>>        int ret = 0, regs_in_pcc = 0;
>> @@ -1362,11 +1362,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>        low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>>        nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
>>        guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>
>>        /* Are any of the regs PCC ?*/
>>        if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>>                CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
>> -             CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
>> +             CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>                if (pcc_ss_id < 0) {
>>                        pr_debug("Invalid pcc_ss_id\n");
>>                        return -ENODEV;
>> @@ -1414,6 +1415,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>        perf_caps->lowest_freq = low_f;
>>        perf_caps->nominal_freq = nom_f;
>>
>> +     if (CPC_SUPPORTED(auto_sel_reg))
>> +             cpc_read(cpunum, auto_sel_reg, &auto_sel);
>> +     perf_caps->auto_sel = (bool)auto_sel;
>>
>>   out_err:
>>        if (regs_in_pcc)
>> @@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        struct cpc_register_resource *auto_sel_reg;
>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     bool autosel_support_in_ffh_or_sysmem;
>> +     bool epp_support_in_ffh_or_sysmem;
>>        int ret;
>>
>>        if (!cpc_desc) {
>> @@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>
>> +     epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>> +                             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>> +     autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>> +                             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>> +
>>        if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>                if (pcc_ss_id < 0) {
>>                        pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> @@ -1589,14 +1600,29 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>                /* after writing CPC, transfer the ownership of PCC to platform */
>>                ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>                up_write(&pcc_ss_data->pcc_lock);
>> -     } else if (osc_cpc_flexible_adr_space_confirmed &&
>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>> +     } else if (osc_cpc_flexible_adr_space_confirmed) {
>> +             if (!epp_support_in_ffh_or_sysmem && !autosel_support_in_ffh_or_sysmem) {
>> +                     ret = -EOPNOTSUPP;
>> +             } else {
>> +                     if (autosel_support_in_ffh_or_sysmem) {
>> +                             ret = cpc_write(cpu, auto_sel_reg, enable);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
>> +
>> +                     if (epp_support_in_ffh_or_sysmem) {
>> +                             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>> +                             if (ret)
>> +                                     return ret;
>> +                     }
> Wouldn't it be more clear to have separate functions for setting auto-sel
> and EPP? I think this is functionally correct, but somewhat unclear, given
> the signature of the function. But I do acknowledge that the function was
> like this to begin with.


In v2, changed names of some functions for better clarity. One of those
was rename cppc_set_epp_perf() to cppc_set_epp_and_autosel() to reflect
that the API updates both. Reverted those changes after suggestion from
Rafael in [1] to avoid renaming.
There are existing separate API's cppc_set_auto_sel() & cppc_set_epp()
which set the register directly.
This change keeps the behavior of cppc_set_epp_perf() consistent to update
both together as that is already happening for PCC but not for other cases.

[1] 
https://lore.kernel.org/lkml/CAJZ5v0ipt=zDDORjuHzuerfLryZO5NE1RpPfnADeWEqi6kyv6Q@mail.gmail.com/


>> +             }
>>        } else {
>> -             ret = -ENOTSUPP;
>> -             pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
>> +             ret = -EOPNOTSUPP;
>>        }
>>
>> +     if (ret == -EOPNOTSUPP)
>> +             pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> This message needs updating.
>
> Thank you,
> Ionela.

Sure.

Thank you,
Sumit Gupta

>> +
>>        return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 7190afeead8b..42e37a84cac9 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -119,7 +119,6 @@ struct cppc_perf_caps {
>>        u32 lowest_nonlinear_perf;
>>        u32 lowest_freq;
>>        u32 nominal_freq;
>> -     u32 energy_perf;
>>        bool auto_sel;
>>   };
>>
>> --
>> 2.34.1
>>

