Return-Path: <linux-acpi+bounces-18839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B26C5478A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4413B3AF722
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6302E2DEF;
	Wed, 12 Nov 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ELuYSRaK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117262E2661;
	Wed, 12 Nov 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979567; cv=fail; b=aISvsggbCXBl+H6i8QosYqtYIVE3GqSTUc4Bt0IlyLYHxHoEJWJFOq3uuUmXEK/FltR7i70zwTYoyr/e6DmJJcw3yyFICFOKb4vL3n5bvZdBT3t5g9essEm+vA9Ft1d5FFokGmy8MtyiZ3p2CFnUa1USQ4xzjW4M9DeagNUIir4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979567; c=relaxed/simple;
	bh=BTxpu6ypNmC5+2ykkUsrDabW8wPYs9AK0wNEsUERyOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKJuxwdtb8w297OiA+vMS2BZiDu+kMF4DbcUE0wQJRLOcdYsnt26GOM6briUttIZ5/w+9+L+nU8Mn7D2xNOKEUXo1eIjn5LQSpdv6iV1KkwkW9wtRLCasw1qQbA0aOVaf67sP2hSQsTMP8/vbHdDHqbMyW90/yyjrgMCaa5leHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ELuYSRaK; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHD2Qda9Yz8xYE/j0dnRvuF2pU97A8FRebvovn8B4epB6Mrn5UIwR2ydXQi01EE9S2DAIxjRxl9idtUpI7hf1oDccHtyexWAqr8/e0R5R6rS8y2lITleWx2ZxMt00RCMnP3LGIexDIMxMX7gNmJh9pzSlTutrDvWPMFj4Nc35h4CZJnoZB+Ta/EsTo9EkcsYsnsiM22AIccddVSNwEuM4n4QMTTyhATcRt0OgizdG61nJG2DQuSWqY+t1lER+tD9ISMPsegKRHLHRRQdxXfiqmrDNyf540vX+vgD9NMqD4HgJJr2EBYa5BrN9uau+HbxGF3NVsQde68wQjVZvZiUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy5iEsB8lh3Vgutt5b0Z2rhcTIjFTBE+3e3HbP3ujrM=;
 b=NqIs5CBBuES4YRoTDt25+gKOdu98tFNHCfV40L1CRVh2clCV6m1njuxHA2cCCET0PgeCQ1RgJwNiX5LHdmEnTjSdJ7Kw/9xIJl3xX2hpY8C5U4fMM0AqPvPb3c5oh9zbHjZEg5UrxdK7X53o0ur1CUaX00nqXfaHTTbYanMabYM6yM2vEpwfBQERWV5z3euN4UfUL2/p/xwRov1GhGVBOAoe05ka5pItvHwEIkP/6X86qH2gsI3R/4VoWScX5AUFh6UK+LNmtWFXP7gWRrR/jSDkxDP1A18h4F6j0ympHlsMRiPoaS2guKPN6lRxF9KICc5cmMaOBP2uxJxe883ytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy5iEsB8lh3Vgutt5b0Z2rhcTIjFTBE+3e3HbP3ujrM=;
 b=ELuYSRaKXwpSpLPN/40KpClss+bHc384XEB5S2DZKyYKGpSTPs4/14lk1MCAvN5mgDfsY7xeDh/Gh3Ft2K7xG43wa1pJz8qRox4tT4p3IdCjhgm/hJXU40vVIKh16ym612WEcbtjyM5cfO4VjjOUF5GEknx5P+rDxZbf3PqX49ZKNcPGkCLTDD6UNXVtW32bYcPhnNvx5VrLYrSJXFzNzlq6P5TbRWaocNSS8LEK1KUawv3SyAa8hv5zEx6s+lyzpN+5JI+gMm8ucxuVQv8gJKX/WLK+56FY75c5a2fy1P3GyxREUtXGz67ocorwr5Z1VWlVcv7OH9zHYeO6pPhbXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:32:41 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 12 Nov 2025
 20:32:41 +0000
Message-ID: <7abc217a-7218-4231-994a-870a0e95896f@nvidia.com>
Date: Wed, 12 Nov 2025 12:32:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] platform: Define platform_device_put cleanup
 handler
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-8-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-8-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e76ed73-13e4-403b-7a36-08de222aa09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTdLcTJIdGUvVDZ2cENsWWhTekg1ZW1OL0l2RVRuemhnTk5wbXFQOVRkaVpJ?=
 =?utf-8?B?VHc4SVVSWENMdU82L3YyYmJvaGQycnJPZndCQVlreXpGNXp6RVd4K0R2L1JH?=
 =?utf-8?B?SjlUQUo4RDdOdC9JQ0ZMRGhOZDBVdFVNdUxSRHFmZXoxd3FNRjV0ZlNIQmJD?=
 =?utf-8?B?RmZIVjMrcTh1MlE3TUN2a2J0QU1xN0lkMjRBamFtYVUvWThpNjBQOGVYT3Jn?=
 =?utf-8?B?U0hNRTBIdzJGUmt2Wmh3R3ZUUFg0czhZQStDdXoybjc5QTBxc1hycUdQRFZT?=
 =?utf-8?B?REw4enBkMjFidXJKY0dGRmRZTWJXaWtuUXB3TlpMbTFrWXQ3WDRyRDhzemhR?=
 =?utf-8?B?cXQzNCswbjFkb1FVeWJrZHluQ3FJM2JYdy8zSkRVV2E5OU1CdE1EYmd6dTlt?=
 =?utf-8?B?N2tuY2NYNWZSenJXQWQxcktLSTZqR3BjaWNHUlJNdzVlTzJld0dYTzVuYkpT?=
 =?utf-8?B?SXpYZzlvbys1SlFLM1JoSVZnZjB0UmthQzFCbFUvNnpZUVNDTUxwV25ZODhN?=
 =?utf-8?B?RjBlYXlVNS9lVzRaNFZtdmFDYTZvMmd0NjVyU3c3SjlSODVlaUV6ZjRFNnJp?=
 =?utf-8?B?TjFVN21lTkl0WEp5bjI1S0dSNmo4TlRzQXJsbkptN1RmbVhGeklKTTVBeFpS?=
 =?utf-8?B?UmJFem9XNmFoTGRDZ0dPWGJXdW1tM2ZKZlk4TjJOOTMwLzFzakFURTZ2SjZi?=
 =?utf-8?B?ekk4elNueWt4Y0sxTEJoSUpOTS9rU2dLbmxlbWxmN0RONjlDL3BrSVB1Wkg0?=
 =?utf-8?B?NEw5cHVxM25ZSzc5YXR5ek1McFRBUjMzUDVjQXhBRFd5VTFzRzduQldydmcr?=
 =?utf-8?B?VytrZzNzZXo0aUpOd3FteVhpblZlajZaVVRVc1RiRWxuOVVuQzk3NCtQeG5z?=
 =?utf-8?B?MXdHTlZhbWxVQUpGV1k4dDEyTEpUdmtla2I1MiszZ3cvTFp3dkduVjJpQ09u?=
 =?utf-8?B?VVMySWd1R1QvSm9BZ3VvN0xFOThOWWwxY3JoUEY3MzBOR212clVIRTVWUWpa?=
 =?utf-8?B?SmhRVU9xMU4wMjJCYXBBYkIrSWhicTR6QUYxT0JkUkRRWFZwVU5LR1RLMzQ1?=
 =?utf-8?B?M3hzanlOV0o4UURkYmdIUHFmK3o5UXJLMWRQUlVZMDZWUUN4QmZLbzhMTGZs?=
 =?utf-8?B?SXZRcUkxOXcrMXVkc1dYWFZieFdYaStZWWJZNnBoYU1HV1B3UXZuR1FWbWtT?=
 =?utf-8?B?bkdndkxjRE14Q2RTZ25BUis0cXYyMnF6aHVxT2hKWGNJUm0xeW1rMlVJRzBH?=
 =?utf-8?B?K2tlbmxXbk1hYzgwNWJzcnMwcDEzY3Mybjc3d05ieFpsTEJjeVd4VW8yYS9k?=
 =?utf-8?B?eUh5c0tvYUYrek82MG5Wa3VCei92MEcybFE5MEZSS3NVMGIzNVBia09oN0pX?=
 =?utf-8?B?MEZYQ2pyblRacTRzdEFXdjI4aHltY2NIQnQ0TzBIV0tKZ1hDK2J4dTNJZUIv?=
 =?utf-8?B?WXYzQnFPU1ZtditaTTVsZkI3bDlWemRVRXA5cU5UOExpbE5qN2RQZGoxckF1?=
 =?utf-8?B?d3IxT0dSdVFxbE1EQUpPQ1lsU3BubkhvT2IzZzdWWXJVdFdKV0g1WjNpMjF6?=
 =?utf-8?B?TjJPUVkzakJYZ1R5OXNWV2FLcUljRkJ0RTFoaFFrUWVKb1dCZCswcWFjUjli?=
 =?utf-8?B?RkJxWjZzMDNsU1dvK1duNmsxTFQ0STc0ckhhazBJNlU5Yk9vVzNxYkxFNTlw?=
 =?utf-8?B?WThvMWlJVUI2MUNXT1NIODl5ZEpaa1lub3pLQ21sMHlML0ZDRjZxQThkT2tk?=
 =?utf-8?B?aTNZSzhkTnB1K1hsQXFpcWVTcG91WUVUdkFQT0VyYlN4TlZhTGppSlZ3Yk5y?=
 =?utf-8?B?THdITytqOE5tMTV0WFplQ2NDUWUwRkxFL3BRNjlGTG9mNThjdjMvU0JhRXNq?=
 =?utf-8?B?VXlvd0JYRHRqaG5aOFhtL2NhQlpEM0hrQVc4SnY4eTlYd3VIYkRJUTN1b1JP?=
 =?utf-8?Q?OwZMwT1S+QfQ4M/24mPl3viyLMWPrkSD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1hZLzJoY2NwRlkrS3UrQWdJdXhPSTJnMFpkb0F6c3p3b3ZlR2UxRHFCc3NZ?=
 =?utf-8?B?dzZWbXZUcW1zdVRXZVJYYVJuUmFreU16b1l1V0kvVTRMeStMWFZkZW0wL2FO?=
 =?utf-8?B?QWF0S2JPZ25ZUTZ2d1AzaVhDaEhFRkVBRSt3a0RUREJKd3MzTGg3WDQrUHR3?=
 =?utf-8?B?MGJHYzdqckhZQ0hpeC9UZDhZY2RJR0FvN2gzMGZDWGFmWGVYd2tlL3FZalp5?=
 =?utf-8?B?THErVlpFQVhvTjgyQmtpUWhHbVBmTTBZVVU1N0pmc3NGYlg0UDVzMUdCTkdj?=
 =?utf-8?B?TzNFR2NJZStoNGpzOTZSUDNhK3gyV1ZWc2NvcUNjZVlNTCtXbzlsZkNxNjZi?=
 =?utf-8?B?OWFJcFdXL1N4M1VuaHU4R1cxNHhXRW1jaGt1SThGMTVSN2w5RzNTMUVnT0tt?=
 =?utf-8?B?ZmhTeDQ5elpOZVRkemZMNVQ0TXl5WTRQTjVMUzZQbHdPekVuNHExN3NaNS9Y?=
 =?utf-8?B?S3FXTWlEOUFYWmYzR0dEMVZMMGRYSGNRbkhzeVhqNkNxWVFvd1NDanh5RkM5?=
 =?utf-8?B?bmF3RGc4VllhVVBxNFEwYS9NK3plVGYvSVROS0QxRk43R1RMeTVyV2d6WXVG?=
 =?utf-8?B?d2ZNTklRd1VZQmZSVmc4Q0Q1NUw3VjZtUllGMjhaV0wyVDBDaUZBNkt0bEVn?=
 =?utf-8?B?QVA5SWR6NjBHL0ZDUWlsems1OXNVWTEvRjJ1ZXRKN0lXUXRhcWhqbkVxNlc1?=
 =?utf-8?B?cHM2OWdYbkh6eC9sTnZOU3FGTzZ3bEtDU2hxc2hYSFNqVFY3RlJZWEwxSHNI?=
 =?utf-8?B?R0tab2Y1WjV1S0dQajg4RTFuSFd6YmFlamFtSEhaelRVUnFKRDN0dFIwZThM?=
 =?utf-8?B?K3B6eFNDQXkxZWVXWEZUaWFoNVUvT1c3NEZzemZnNjBnVmwwandQejRjTkNF?=
 =?utf-8?B?VkwrRjRld0thK0I5RVpMQkxWZlkxaVFYbnY2TEhiZVpMTG5CSFBJMzhIUDlk?=
 =?utf-8?B?em4vTDlHblV4V1JSaVJMdStxZ1RuaXQxM29yaUhUandhc0Z5eEZwU2NwQzlk?=
 =?utf-8?B?WUZPcHFQY1ZQZ1dlSjJEOTVyYnAzQkMvaklCZ1MwcTkvRVBQVGpZcFhldi9W?=
 =?utf-8?B?Unh1RVhoUTQwU0ZhcmNGUmdrV3NpT01PNXFJNkgxWjduaFhzYXZNRUprWGc4?=
 =?utf-8?B?ODRLUGZ4V1U2SmlFRWtOb01jcVk4ZEc1UXpUeENOUFpIR0phS1EveHl2YVdF?=
 =?utf-8?B?ejBSK1VSQlAxNThkMkhqWGhTRjVQZ1o3Ty9QcEhEbDVhS0VpVE4vSGZOVHFW?=
 =?utf-8?B?MWIrK25JcDgzTDNCN1dZajRNdkpSdzI2Y3ZLREkvUDl4VFVMRnluKzl3aDJh?=
 =?utf-8?B?eVJ2OGJ0WWE2cCtNLzJ4ejBSTmFUdkR5Y3Y2ZkZKK0ppdDh5d2NiTkNXZ280?=
 =?utf-8?B?UFFZdTJLSzdyMXd2WnFLdWlGeVVueE1YWStpTWp6MUg1TmhLcVlnSzlrL2Rs?=
 =?utf-8?B?MzRtWUpRYVRLVmhkT2l1d1hLY2FzNGx6MDBWakFyWDh2SStoV0VqazBHM09B?=
 =?utf-8?B?VGhkWmJaTkxIOENPMC9GajhSeklUMnV6VDBHcXBHb21rWmFiY2R2ekZxbjZ3?=
 =?utf-8?B?Y0tjOGZJMWIzQnFpaWtmZHhwa3RVRmVmQ2pyRUljZktuTEc0bWpxaUppWTFu?=
 =?utf-8?B?QitCdytzdEJPWndtOWpCUXQ1ZmU3UDl6TVdOYlpnL1hMRlBOb25zZERqdnc1?=
 =?utf-8?B?NlJZaVdoVExhNWF3bXZxbXp5anczcUhMamRpZHp5YktrUXBCd3FEY3VrUTRC?=
 =?utf-8?B?MUlBdkJrRm1QY0o5SlZIOGtWa3U3TmdLVDVTWmNJR2xERE1oUzhzQXZLWjg0?=
 =?utf-8?B?QWxJbGhRQjZ4Q1hVa1RJZmZrTnh3ZUlDUkU4dXBLNUZxS3NyaG9LTzV1dk9S?=
 =?utf-8?B?MHJDRTBidmF4OG5YbXo3ZUtIcTdTeEwxL1NqNnBSVjhublpBbDFCMElMSXVH?=
 =?utf-8?B?dG4zSy9pSnJGZTY1NTgwWlh0dDlWZW5vV2JWSGNWOWlybXJxbmpCU1pFZnZ6?=
 =?utf-8?B?dk81MkpsWDNpWFFWV2JSdVVjMkZLTFA4OVFDR2tLWGl6WEVtWFRSMjVvQWVS?=
 =?utf-8?B?cStoRlRBdk5HRnJPakpaaDdtTmtTRDUvSUdzNGJzbXZtRzdnTGhTcEJUMHRi?=
 =?utf-8?Q?UQAa3AH4Y2IPQKfYwx2mDzEtd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e76ed73-13e4-403b-7a36-08de222aa09b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:41.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4ahxqckG450GcfCjCivjnoXkER5JYkH6w33YrpM0F2lNGGwFZfVyR4c5CHbA3OCSny3bCAOfMQufgRrSu+sgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945



On 11/7/25 04:34, Ben Horgan wrote:
> Define a cleanup helper for use with __free to destroy platform devices
> automatically when the pointer goes out of scope. This is only intended to
> be used in error cases and so should be used with return_ptr() or
> no_free_ptr() directly to avoid the automatic destruction on success.
> 
> A first use of this is introduced in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

