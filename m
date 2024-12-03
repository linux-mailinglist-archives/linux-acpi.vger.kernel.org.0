Return-Path: <linux-acpi+bounces-9902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391A9E2E64
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 22:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B1B44587
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C721E1023;
	Tue,  3 Dec 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dv+/s5wJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F418A6D7;
	Tue,  3 Dec 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257814; cv=fail; b=D/cWRWrhYyAOXtoT+hXahQCVYksCETnFhQhXGDpvmTv62hfgXTV3dNjt/b/YhPXXJnb22Gashxr5tJLwtERvyn2FuqZs28siGNOdBeO7zpMQ9PfZ05p+yU0rE8+8GJPvvuEc9tBEZZItpeORwnHVpYaNBhBr9zeS/aCxGWr+n8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257814; c=relaxed/simple;
	bh=CjW55TrN6dWeqLBFFDV7ZIM4u1uG1XO1VhS3tgxY/aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FV8X9g7QNldFgBVIQr3FLmlaP9MZmQ7NyH0TyZ8R+utalCHTN9M1hq4o4h/fQrpLtAKvPmHV+TqY97j5CvY5mO9FXqwybnBW89Icdot02WW6AkYofz/wBP2XhsHzpqfgB0tbwMSKWJkwX5kbQiWCfvOjmSbuv7IdgH3d/SIMV8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dv+/s5wJ; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICaIUnjFKTRgUc45HlI3N8y8mJ9UEUQQThF2hPOnWyKATxhunD637aIflmTiR1+CJ1+CfcfEAFbaxMqhHtuZb7o4TRD8s78+JGxmTqHe8wXn+U1PDlVlQ9pVH/6SSoUJ0dPSgQ9Qj8DgL30Ktvwu2DjN2joCdxoLDAynP5OFw6uE3uYfg0lPSjO8Re778Xl7UhI26PF8w9JmbqWjxUHtznI5beiPuAVF08/w8sS5jiCP1seyakhr8wyNnouqCi6dQnzYRX9yrjbCSz85SjEFwWMR89I6Gdahg685l8Lsc5SSNaztEi+SQa/rDeTXBBQ4EUxyTAPbWIVccyc1m0925A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATRdlHgiejewlgipmCz/dE/0EbiGR4rD40YkAWyuhqM=;
 b=UdcR2JaEcLlJd8k6X52Qx/kUKTWfz3GuqK61PHXAJh8T2V0DYtD+xBtBV4s9J1L8u4KLKl369HwPBw8ueG6ScHCqbWx7+lG72t4yZb7oHX5kzMOk8bEdAZWTDsGrCHYUrpKJ5N6OvThhmHgwwLCOlpkQlqzfQkhuQtgg+lxLW2ldkV+1YQNW30tMj+Oo/nO6fK2gXhtgxgFYQtc5tCOjmaoeAanvrWjNSDj1BHO7gUZbAD3BSHg+Pu3RiJwWE2f3mFiq8rYeoArW0i0HZSkY+QAf9ehQyEgV2Vq4mlcb97ucB+ZMrwbp3oKHac+dlu4JRCvpVU1TsUAPiRN9jSRhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATRdlHgiejewlgipmCz/dE/0EbiGR4rD40YkAWyuhqM=;
 b=dv+/s5wJeoTJvhlnaIIerFjw1W0swVSgcypklvb72TFUr075iXcBqDoz0U+Kdss5Bd/mpKiSQqLm+QhNIziHFi0bTXLxXOKFmkDAsD2ZBB7KAkmrNU4XsC02b11q4lf5HMHXevhXkhcY0j9sUne4nEvKSSw6IEgSS69zoNOycIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:30:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:30:09 +0000
Message-ID: <fb5ad3d3-b9a0-4018-9495-b7dbb5dae180@amd.com>
Date: Tue, 3 Dec 2024 14:30:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/12] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-2-mario.limonciello@amd.com>
 <20241202114513.GD8562@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241202114513.GD8562@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: dce9bb9d-fc6a-4060-147d-08dd13d94802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDhDUGRpMFB4M2F5RE1tVEVhRnRkRUR6ZUMwb2luRjRrNHAvUTFNME44Q1ky?=
 =?utf-8?B?bCtSaytpbHJrRkMyKzMyT1A0dG9RNU5yUGxRZDRLQXg0L2pBQXlSL3NSeTgx?=
 =?utf-8?B?NUlLcUpVWUZ6OTNlMXMxUTRidUZONFJPTnhOcnlWMnphbTQrcEd3S1dGdGdr?=
 =?utf-8?B?RmowZE51MzNYZWxmWmNoWXExM2czRXZMbitFd3ZVNkF0dGU5Vm5aQm1IQ2Zz?=
 =?utf-8?B?dHBBVHloYVR6andLZ1ppTmZqMXcxay9GWFZzVkRqaXNTL045b0N3d3YyZFUv?=
 =?utf-8?B?WVlHM1c2K2NEUlk5NjBFanNjWkE5UE1STkptZytkQnlHR210SnB6anhVRi9j?=
 =?utf-8?B?RlJiVW5uelhvUFA3STJtSzE5OWduejhTZWo0M1A1TDBjVEFTUk1zUy96QkJI?=
 =?utf-8?B?V3dLRmxTdXpYM25LUW5GVkg5cW01My95MURvU3c4anRTeXBUci9FblBYNEdI?=
 =?utf-8?B?U1NPdE5sU3Q1dUlVZnErMDdoUXR5RklucGJmSWpQTDZ0T3B3cm5mOVNRWFlB?=
 =?utf-8?B?dFYwMGJCRFhUU3RraHRlVkd2Ni82c2g2ZmxLKzkxbVRwVmUyc0Z6d1diZzRi?=
 =?utf-8?B?L0NkVndYa0pFWkRwQmRHU3hKOGpWbkhzSkNhYnhnNVhSZlZkYXJ6SkkycHNW?=
 =?utf-8?B?M3NHd0lVaUp0Z0t6aTVjV25nMWp4RlIzc0tqR0RXRkdXZGpvUnAvbTduaERa?=
 =?utf-8?B?c2lNTTNwTG5TcGpSMlFMV1RGcnU0MWJOZzRPSWZHeXF5MEpIQXMzNUxrOTFD?=
 =?utf-8?B?bWlZUHJIY1pOMWR3UE9wYVAyVXRiazFaNmo1RUFZL0wyUGI5MzMvTUo4Uzdo?=
 =?utf-8?B?Q1crMlErWXdqSHZxRkxva3gyUGFzRlgxY2JmWGFiNU5NcXFmSk9DSk9jTXR5?=
 =?utf-8?B?RTVJanExZksvUVdFUk9uSXdEQ2Mxd0t5bW0wQWMxL3RUNWkrM2xjam53RWtt?=
 =?utf-8?B?Vlg4MHpMaXZqbnE3WVVxcTg4ZHhpbWlLQmhmcTFnV3Fvdkp1RjhnVHFGeVhh?=
 =?utf-8?B?bUJWZVN6TFpMR0l4V1hBRFI4Z0VJTjB0dnVncEFmQTAvYWpPcHJCbU1DT2s4?=
 =?utf-8?B?TEFiekp4bllxWjVub2RYOU16c0d2SWNqb0JnckI2NHgxaFY2eVRMaC9GR2tK?=
 =?utf-8?B?SXhqTlpieXNIQjJtaDNwU2NoRk1JZml0ZDJVZEpXcERtamllY1VGajRsZ1o2?=
 =?utf-8?B?M1pmZ0cwWnU5TzJMQnp5ek53dXZTYWp6cHd6ZG44RllMMGxUNEJuVFpDQWNn?=
 =?utf-8?B?TjcrR2MyeEVCcWo2TEIwaE8wUlYwejR1a0ZVSXBGQVErbm1uaVVpc1BGMHUx?=
 =?utf-8?B?M1ZNR1A0VkVwbm1leGFZMVlqTnowNklsbG9FeUtmeVFuL3lzeWg2bkpqUnIr?=
 =?utf-8?B?aHl1a2FDdGlvUlJvM1dBWDh1S3hpc2JVODV1TURObERkVS9CdnJ4OXJGK200?=
 =?utf-8?B?eTdrOTl3YU9YUGlhVHIxWVQwQllDVDcwNExRZW5JQXBIVWVJK0VjVWNpcXlR?=
 =?utf-8?B?cVdqeUJKTnRWSDh5aWR4YUIwL1FxQ3kyV1NIbWhrMkxVMm5xZDl6Smpra1Bp?=
 =?utf-8?B?bHYzTHZFUjJSeG5xZENTQ0x0SUU5blVHWWd3WUR1TVlrY2pOS2hPNDRvTnpj?=
 =?utf-8?B?WVI3TkJ4UHBlRWdzVUJDRVY3QW1FemgvdUp3dHZIM1c1dkVsdVRUdUd2c3g5?=
 =?utf-8?B?cTFxUUw5MkdPakRiTXVYT1dwTUs1bmUya0RyWG9kT001R2lzZnJGay9xVnRY?=
 =?utf-8?B?R1BLaW9nd2NmRTVJTWxwaHBMdjBDdkZqRU9oUnNRS0pRMGpvM042aXI3UDJQ?=
 =?utf-8?B?RUtDV0Y3ZzBnSVQzUkgrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1h6aFFOWEV6R1d2ZXRFVWlBNEdnQVYyQXRHdlF1Zis3bGpVc0NhQktPbXpm?=
 =?utf-8?B?QXVxbTNDZVBwUGhVSitSaXVJSnNPYTF5TlY3N096YXVhRmJGaE1acGttK28y?=
 =?utf-8?B?RUhyN2U4OTErbkQ5QVJNbDNURGViMnpzeHN5NmZ3Q2NnRVZYbHNWZ0Z3ZVBq?=
 =?utf-8?B?SzBaYWtkU3d2WThxM3ljemVzSXpWczZ3eG9CanB6ZVZuZ3Bqcit6M3ZnazlP?=
 =?utf-8?B?eDVBZ0pxS2h1OHhxa2htUzBGOEhWODlWWTI1NjdFa3dSaFM5T1JURDlHSllK?=
 =?utf-8?B?VWdNOTBSam9WS29iaHNNOFJ0MUdZRHlyQWtwY2g3d1I4RFNWNDVuR0pHNWw1?=
 =?utf-8?B?Z0Q1Q2h3N0RrWlkvbEdVTGRhZGk3czFTN0xoL2IyREgxOVNkSmN4MVBjSCts?=
 =?utf-8?B?a2RjVG9PN2ZnQUFmNDg4bUZQUjJOeGZBaWZHVENUaGV3RldraGh0Ty9pU0F0?=
 =?utf-8?B?cU5yOTNOeE5MV3RWcmwxaUtpMW9icWRxMlpjOHN6MS9GdnBhaDFRa0JEMEVj?=
 =?utf-8?B?bEdaQ1ZlcnVXT1dpNzJPcE9Lc0FWS2xlbGw1RjV3dUtUVlIwVjJoVHpnbCti?=
 =?utf-8?B?N1R0Z3R3SGRFSFkxdUJoenl4ZkJXYmE2bEM0dHdBY2w2MkdDb3VCb1FZQ3NM?=
 =?utf-8?B?OXpwOFZqeVpraCs2WWozNkt4SFRtWVQ1T3AwYzZIdCtRVWY2eVdUbGwzT0Jj?=
 =?utf-8?B?QjM1M1kxck50aDZnTHROSWlxSzljQ1ZacnlBWnhEKzhKRS9CaWRMUzM4RVBW?=
 =?utf-8?B?Wks5K2cxemIxWHFhcS9WR1dkZmRKMU00SGtYMVVJb2Q0TlZGUmFENWREdWd1?=
 =?utf-8?B?YzJsRHU1dGk2MnlQMXJicFB2TDNIckNIS2h0UjBlMTB4YUxrTlpNakF5enVw?=
 =?utf-8?B?bUIyWG5NSE5XM2VucDZ0aFJzR3Nid1BXOWRRZTBnV0xyR3FJKy80UktENS94?=
 =?utf-8?B?Q3FNbGRMTEdmekRJT29KaVFQeFFPVnJWSW10bmJFSm5nRDI0M3hLRmVKaFZJ?=
 =?utf-8?B?WWxQc0lqTFZaT1dqRjIwRUw3YUxVRmNBZVkwMjMzcFcrMXlCdE9aaWYrcisr?=
 =?utf-8?B?bDNWR0NVYVZUWnE5RE9aTlJXREpaalBtVThyY05tTno1T0Rtdm5HMWdFZFY5?=
 =?utf-8?B?cllKWDM5YkxTUTdTYUxnRzhPUnR4bmdqdENGbTJsWUhqdnFVWVg0V3BMRE1r?=
 =?utf-8?B?c3JudUpBOW1IRXlGL09hVnBveUU2YXo5d3lUVE14R0w2WlRKSDM4VWpPeUM5?=
 =?utf-8?B?TnhpY3V5N3MreUgyZ29Zb0tsdkdKSmpWWE9RWDhVZHFpaUFxbXdFNmN6YmEx?=
 =?utf-8?B?NWtBK3hwZ1NXSFNvaTBvblo1OVNxdlU3TnVzZWlRdW1LR040bVgyM3IrdWdT?=
 =?utf-8?B?ZTIwb0huajhycVdxTnQ5WVY3d1c2VUxGdFVhNlRYaG1IQXdxSURUT2xvcWVY?=
 =?utf-8?B?U3c5V3hmd0hEa21lQ1Z5MFY2dmQrVENGNktxSmFBbHU1RG85TzZ4L0VlTlZn?=
 =?utf-8?B?eWV4elh2ZmxqcmlFM1VtU0dKZkJybjlpVWFDMGVHYy9vaFVvWWZRY2RnOG5H?=
 =?utf-8?B?cVFHUUh3c0E1Q2FTVmUxVS9TelZiRGsrRVYrUHhqVUlMQkN5dXo5SHRhRWpz?=
 =?utf-8?B?cGFqMGU5Ynl1ci9LMlVCUDl4dWQ5RS9taVBSWGd6Sk0yWFpMdXMrTXNka0o5?=
 =?utf-8?B?bjdUcTlGdzl5REFTaDBQd2hnVU42V2oybkMzc056NUQzQUFkUkhyTFV0d282?=
 =?utf-8?B?cStVdEcvNWVyTkpzTWN4UGNIUWY4b2ZHV2pma2lUbEQ2bUw0SnRKdHBwMzMr?=
 =?utf-8?B?cUMzM2M5SzRET3lYTHZ3VFVJYUk3UWdRMWlTNU5kUmVPZU9waWpZN0I5WmFa?=
 =?utf-8?B?NWNiYkxKZlcyQi9xTlFlM0VneXh0a0VzUUczMGR1blduK0xneDEwMk8wamJM?=
 =?utf-8?B?bDVLV3RzYkhwME9QT0pyQjE1U2taWGJZN1NXd0M0dlF6blEvRTRud1F5V3Yv?=
 =?utf-8?B?TFd2U0ZuSEcrdnFZanFDTm5UUzNKMkd4U2FBemRuSE5sN0pRRXNYcm9tNVlF?=
 =?utf-8?B?NzFITThDN2Y1RmRmR0ZFTzF5c2hzdFhMT1RYN253RVVaWFFHOTNQVzUxZmVu?=
 =?utf-8?Q?lUZeeINmcaVMyh+sONdwKtY7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce9bb9d-fc6a-4060-147d-08dd13d94802
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:09.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DYQ1/h5dtUYXca6f5E5cbTDMJd1as+Q8IrmoI5XY6Rtil6HVrGkJyyKzNdd+ujOwOUbxCVGT8cbVhfTJ06ZvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

On 12/2/2024 05:45, Peter Zijlstra wrote:
> On Sat, Nov 30, 2024 at 08:06:52AM -0600, Mario Limonciello wrote:
> 
>> +Thread Classification and Ranking Table Interaction
>> +----------------------------------------------------
>> +
>> +The thread classification is used to select into a ranking table that describes
>> +an efficiency and performance ranking for each classification.
>> +
>> +Threads are classified during runtime into enumerated classes. The classes represent
>> +thread performance/power characteristics that may benefit from special scheduling behaviors.
>> +The below table depicts an example of thread classification and a preference where a given thread
>> +should be scheduled based on its thread class. The real time thread classification is consumed
>> +by the operating system and is used to inform the scheduler of where the thread should be placed.
>> +
>> +Thread Classification Example Table
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 0        | Default        | Performant                    | Highest             |         |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +
>> +Thread classification is performed by the hardware each time that the thread is switched out.
>> +Threads that don't meet any hardware specified criteria will be classified as "default".
> 
> I'm not seeing this part in the patches, am I needing to read more
> careful?

Patch 1 is intended to explain how it should/would work, it's not 100% 
implemented in the patch series.  After the baseline plumbing is landed, 
use of thread classification information in the scheduler should be 
future development.

