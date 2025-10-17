Return-Path: <linux-acpi+bounces-17932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16227BEBF78
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF54D4E10D9
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DC2D780C;
	Fri, 17 Oct 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="am+i869q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5675261595;
	Fri, 17 Oct 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742226; cv=fail; b=swcrlCFBAWXCB/qdv7towrBRHcjcLS2JowIL4LpKA+sPBKbp0l5HnTlKP5cKMh8QJzbG7oNhas0EWtO3jj4Eeve40d0PP6ZOLI1btf8cJSfY560hnuv0iPlYFBHFIrzj45p0B+isLmngf00ROFkpCShy9/rlnxJx0FD7BSbwCXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742226; c=relaxed/simple;
	bh=kHWphzIg/s47qk/n94rjDTbpvvV4eccZXhqfDUEek8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDszx+dZrW5acvlVjtcd7neVEtYhVLV7aJUNhghQeNOrxORGdNFPYJoLrke/tHKRftxXDA3k2Q10TBBjLnoCiWeWo6g8P7ustThxbupYEiu7QnvHUNfmnvGrDppmPezkvNUrWuXAv0VZEuq0g2FvG31paaVAd4KPGaeZWbSyfZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=am+i869q; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4zNExr6vVBDKQEfXHd0l5fVzDx1XvBkYCFpGyHqtC8JdARiU/pV0qW8oZoZQ40Ty5WWBOR9XJu3OccLm1+By4AwdhiKKdel0HBE4qyIyAPmTiQaP7os6Quk2Gl56dNw2IfxfhLEO6FH9vZlVuqmZT0oSo+x1IFnwVwtV5UopinmbAZB/gj8Sy26CyJyZG5htiV53SlRLO/08u1MjTd4evsAe9a6f5YsT/90OizyNAyEKLhuq5Jvext9EFVQ9VeVVhf/c9bHNTQZOw/G/U2Zt3WhUt1MgezJinnh+GacztVvfQwSbFjnco8EzrGhgjEm0ohdNwOPhtZ1AF2zxWHaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1EmKoBZwEzitwkRG7kwU+x6ipyjlmT50Mvxc2n3feA=;
 b=c8yvMuXzkyDDkpni7KXO3EPuQ43/YByrUUmDDEdHz81AECeD8Hsdx4mVE/R2TC9mMW1GYxjSSTivpOvDSfwIFpNx2MXe82bqaEpOc0tyKNqm5prxKDczKbg3LzbKkzaikE9h2A9hN+hzVO4w9ySf6/TydxpUhwjOOw4GiqSAx6EVVY7b4rGLdb01fAM8XcaJG0DBFpTnDlPCPnHGEtrbBD97U+bHvhzj3EAbz54qo0OPMSHHalK3XQTdrDtK5sVEMu449cuYuofrZVdU8TWPvE7+1nVdWvTAiKY2YjYYClh177HOVzoLMqkMXs4xwDq18YPmdq+bnpR6Zpq0Z1itIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1EmKoBZwEzitwkRG7kwU+x6ipyjlmT50Mvxc2n3feA=;
 b=am+i869qeCa6Js8HWBNOQF+UdJaCTewIIIQD9SOrIkSo8R4b9u2TTOl6JSVFS3ZGl2ki0ctM/XdbxLIAoBidi5Fj5ItoG68IWTTk40lEcGyokQB99+iAJPiWfUI9VTcMioMiSApPy/fRJoA4JAVdXG0ZkYzU2vN+6b1Mlvth33wAqqFHj90RDJv2/BrvgS5DkvGvJ6q1fOjxPWTB/XWfTvPcCDLelO5X4v6Rq8mqrinO7J1hWDWNza1Cbxpkcjb1JRLfcpNcAPd6u1Txe6/ik4CB1AfLzUG/FRyZ7IxulK+bxkcEAVHQnUWCRINeaF2t9IBJY2H6NkDkkMBDqlpamg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 23:03:39 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 23:03:39 +0000
Message-ID: <fa7ed4fd-c1d7-405e-bdbc-443b8eea4b89@nvidia.com>
Date: Fri, 17 Oct 2025 16:03:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>, Ben Horgan <ben.horgan@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-10-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251017185645.26604-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a29e39f-07a1-4817-85d7-08de0dd1691b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHlMVng4Rm5TMHlkTjl1bzFyZzJxRi9KajZEb2IraHFBT2txK2N0RnRacmVp?=
 =?utf-8?B?R05IcC9PL0xmNHFBdE5JREdsR2k2MWxCMUtMM2FpT0lCZUdaV0Mxb3BUYWZU?=
 =?utf-8?B?Y1d6MEhEZ1loakdHQUIzZm85WHp5eHQ5VG1sazJ3VmJsWnVBVUtUSkttcm42?=
 =?utf-8?B?TEhRdzgwYTBXcE1Xa0g5VEt1MEtDSFdqdEpYMXpGODh3WmcyRmlvU2ltY0Vs?=
 =?utf-8?B?T3hweGhvN25jaHFzQlY4TW1UaFNYTlozbERoTmJHUmhMYzJFdkcwaStTbUFU?=
 =?utf-8?B?eDZrbjZ2cEhEVnZMOHZnZlE4bUJxem1zR2dRNExZTEdaRjMrTTd3QXdTV2Fl?=
 =?utf-8?B?UjVGT1R1MUdLcTJPZ3F1ZmVCU1NvV1ZmNTRQMkRNWTBueEpwdkJ4cHJzRnpM?=
 =?utf-8?B?ZkpzampreCs2eEV4aGN4MlpYc0ZJaWlPS3hoQ3BleHNIZitsbSt2Szk1VVdp?=
 =?utf-8?B?a3ZlZGFTNHE0ZytLVFVIbWJwM0gxUmRmeFVhd2dkU0s1bHN4bHFDK0VPTWFF?=
 =?utf-8?B?TzVFeklXQjlhS2hua2dMbEtvU2lhN0RNSXgrTjlGYm1SWmZlKzhGWmV3SnBO?=
 =?utf-8?B?Z29LYzdFQmI1MnJiUWR1anhjZDZzNnZSN1JXUVd5WURkR1F6WDBtS25LMlJt?=
 =?utf-8?B?dFlTSjFoeWtheEJmZ254T0ZYOW9TUEVmNEFXVEZkeGhlWGtNT0hYSVd3TVVy?=
 =?utf-8?B?Qy9BRTg4QW9wd3NQTXBEaEVxcmdRenViMVQ5eDlickNNODltUlZhbkFTUzNK?=
 =?utf-8?B?V2c3SWNJMGZ0Q0ZzOWpOOHdXMllFRDJBN1loL1ZESGZyaDRoN3d3VjBXNVVN?=
 =?utf-8?B?R3FKUTF4L25RRlkyKzc3WWpRTGphWVk4SGxqZDd3cjJOU3dqRmhmQlJxdC85?=
 =?utf-8?B?eXFQL285NHgvRW05MU84Z1BRV3hKdHljc1U5c1hiT0RSQ0I0OEJTakJrUUtG?=
 =?utf-8?B?TjdKbmRtbzJjUVRlQnltVnQ4a3M0MjNzTG5reDl2dW8rRUN6T2Zxd2lacEUz?=
 =?utf-8?B?eHpIbmJWYjRxTk9DK0RkZWVLNjgyb0JXbmNYTjZLaUs5ZldzbW9lc1dHZEUr?=
 =?utf-8?B?SS9uT2k4ZzBiZ2pheWVlc3ZaUGJOYURkNGZKczdMRzN5dGdqNU9aZU9lQyts?=
 =?utf-8?B?VmkyS2pCQzdxVk5wdXAzeVQ2MjU4OVNLUk5BWkp0aXRnSDFNbmtrMkRzQnlO?=
 =?utf-8?B?RTNzaG9RUDhPTUo2V3ZVYXQ4SUNyckdBbDlMU2JueVRBMmFFMzR6cTQ0UWFv?=
 =?utf-8?B?U0lhRk1MMDBYWGVsRW5SMHJnaUloTlZ2QktrdklZQURpUGJ1alJQU0lBLzJG?=
 =?utf-8?B?SmNHTldvaWFNbEl3Zy9NcnhQbTBNVWRVZDZyVE1xYWJyUHJML0J4cVhoN2w2?=
 =?utf-8?B?Uy84SENsblRRcXVZOEJPT1A2MmNLd1hWVDdHT2JrYmxtV1F5b28rOWNUUzIw?=
 =?utf-8?B?NktibERCaE5NV0l1aHFibFlPSllsTTNrSlJIdngzMFZKeFZkT0hjM3oyTkF4?=
 =?utf-8?B?ZG1SYUpFaDFtdjN0TVlBZjU1bWxFZm0zNzNIaG5LbG5GazVHWkpNNWUvTUZH?=
 =?utf-8?B?djlxTkdka1hVeS90eXV0dmlDb2kxQ3llalZiNzAwRVNXdEtzdzVDcDIrNWp2?=
 =?utf-8?B?d1lWSm9DVmVnZXdlNjNXeVh2UTBnMkU1MEo4K2tjTmVPNENSK2Y2NzVtclhN?=
 =?utf-8?B?dnpPc2IzWkkyREFYandMSUNnL1dFNnYyV1lQSnNHU0VJY1puMHNDL1RHUUd4?=
 =?utf-8?B?TU8xWmNhbXRrcDZaZk02UUxEWUdUQTNxb240RDlDS2M2bmZxK3Zzbm9OcjhF?=
 =?utf-8?B?bGZPYlJSNnZpZHRYWXg1N1JoNFd2NnZWWTBxNXVUWWFTOG1ldXVqRVdRMGt6?=
 =?utf-8?B?WFRoaHdhNUM0SlJTQVFlY1RoOEFWT2k2RDViQmdPdGNpdTVBbDlLcEdhdGZI?=
 =?utf-8?B?QU51S2REY245WGY3QWUyaU5nRENsOXBDUXBsSSs3SmtFdm5YZjRtMGtjQ0xh?=
 =?utf-8?B?QmlweFh0czJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpCZzkwT05YcEpUWEVHM2dEb2JmM094dlYwTG5DcTFBNDFrM3d1REJ3M3NW?=
 =?utf-8?B?am56Z2l3aXFXWTdCeXQ0QUdrRExqc3VqazNmb1IrWjkyMjdFMnB3YnZ6MU5k?=
 =?utf-8?B?Tmk2KzF3YlA0SDZHejIrZVFMNGF4bTJOOGhsd1pnT2kxdGorUUs0b3gvNWJF?=
 =?utf-8?B?SmlTSnEzTUxsQUFFVkN2c0tDZ3A4MUo5cFU0eVQwdlNHdDVVbm5HcFY5Q0Jt?=
 =?utf-8?B?Y2pMYTBDWWNZS2syZUYxWkVQRGZ2NVh3QzF2L05obHMvc0FFeGpnWDdzMlM3?=
 =?utf-8?B?QTFrSU1ocUx5OTMvcU0wa2hpRzFiRmVWREh2UWJ2Q01ZbFJjc1RMS0RjajhK?=
 =?utf-8?B?cTYvYnZhWnFYbHZxWVFxNXNlMXdwNTFSWDlNVWlySGVjRENsbTM3cXYweFh4?=
 =?utf-8?B?SlFFbUNqYzRuYkJtZHdkYzRwRDBHbzZiOTNGRXRTTlM3ZDJ0Ujd3WW9qTlFr?=
 =?utf-8?B?U3hXMmg4UVJKdGNIbjJkY2VKMTlRdjA4S1pUeHVLWUREeEkydFBsMkk3d0c0?=
 =?utf-8?B?bVFpN0x6MHVJcDg4bi9SV0Y0L3hQZElWUjJyS3pKZlBIK2NOR0cramJlekxV?=
 =?utf-8?B?cUY4TTdMQTB6UEVwZHFrZGNsdERadEZ0bE9FRUo0QWJYbWJIQ3QzMWo3ajZa?=
 =?utf-8?B?NXFFQ1pBSUFvU1B4RjYyb0xFT3lHWE5RNktJWHNJUHlrQ1JJTGI5ZitraDVV?=
 =?utf-8?B?c045dVg3UkN3R1d5R3FtSzFzMlhBTzg3OGxIejl1Ulc1cS9vZGlKbDlRcXZY?=
 =?utf-8?B?UEpTczFPOVRZdW83SWc3T3lMMUVzK3dNTllOWEp6U3c0VzJBRktOWDZLRnBi?=
 =?utf-8?B?U2tFbFpnR1pXUlR2M2hjZStvUGF0V0hCeFFORCtCeVBiRUVRQWhvY2hISExL?=
 =?utf-8?B?TnZEdjNhczFEdlZDeEhEVDhNUDlXMTR3elFDVDYxdXRvRnQwT0JSa2tUaTEw?=
 =?utf-8?B?aThETWhlcDVoanhSQzIvQk9ZMjJsRWw0bnA0TFBzcVE0amdORi9Nd3RXcDl6?=
 =?utf-8?B?eS9RclNaZDN3QUxFcFA4QlNRNXpQN3U4V3oxZmQ0ZTFjYzUyd3A4Rjc0SmJS?=
 =?utf-8?B?bHNlSHpMSU9mWlVtSFFtOUJUN0o2YTlhRExmNHRjdncxQW1ObFllQi82by9L?=
 =?utf-8?B?VytUTS8vOXU3ZnNmdDl2MzdRcmYwVFo4YW5kNWZ4a3RPeW9KMCt1L3Qrcms3?=
 =?utf-8?B?bGlxUHBlSFVHYklzNDF3K25kbU9Xazd0Z0dlL0pqYlhnWC9KMXNxWnJKWnpM?=
 =?utf-8?B?RmpQS0UvVWpDQjFTaWY2OWVsVkVIZWZadzAzUEdiK1U2NkUxaVp2WWhOUVpU?=
 =?utf-8?B?QmR2Zzc1eVcxU09RZHA5bnFXVmdJWnBIWnAzblNKRG8vdmJ0SWJHNHBDNXA2?=
 =?utf-8?B?NThXbGNBVDQ3T1JSdmtjWEFnSHlwNTNlZnJta1RHZE9pNUszVHBSdkJsTHd3?=
 =?utf-8?B?d0NsS2JOUWZ6MFRBa0lYSXdzN29reXhhL1lDc2ZNUUMzaUpzYTZreFBGa0xo?=
 =?utf-8?B?bDBMUWdndW9ldUE0RzQ3VUZJM3RwdGtiRTVuYlFSM3U0aHROaFAzM1dINmM2?=
 =?utf-8?B?UjlYMUNZUmRwaVZNUTBDZU9KSHR6UjBIL2dDMDZsWWdKc3YrQVNTQ0szN1Vh?=
 =?utf-8?B?MThDWm1hblNFYWJSVjRiSFJFWVlWSmtxVkJDL1NuUlU3TVZsajRBOXJPNEJh?=
 =?utf-8?B?RnVyeHFkOXRaOSs5alJEMnFsOVpIdzNaVFBqNFNTSXc1TzBvSVJPWndJRmlG?=
 =?utf-8?B?TXhxZmNIbmVaQkFMVVZaZ1RXY2pYNFVVdFg5ZDU1dGQ3aGR4N1dHZUxjdkN1?=
 =?utf-8?B?RHArai83Y0FxNk90bzdrYkxOQXo5Wi9LSGgzVDFJQWw0eHRhVEEzVTBBR1pl?=
 =?utf-8?B?NnFybWsxZzVXdWdRRW52R3huTFJ0ZHRJK3Ayb0RxWVNWdE14QXpLUHJzZGox?=
 =?utf-8?B?cEk2cExsS0dXYjZUUnBDdFBDdGdwbDZUYUhWT2J0alYwMXBOajNDb2N4SzJl?=
 =?utf-8?B?Q1VkUHRDczZ5aHhncnhKRVFzdWNpSm5rbXhaSmJuUTZsQjc1LzNsZFlBelY0?=
 =?utf-8?B?Y01WWHZGajhucEQwbkloZTRsRUJ4Y2J3cjBSNkFDajJyK24xK0lIbkZBQ2hp?=
 =?utf-8?Q?0gzNq1a5wFJJEqzMbXRxvUmsp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a29e39f-07a1-4817-85d7-08de0dd1691b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 23:03:39.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuYBWHfgG0HSsLaJ9BKSyj91krf14pOUy2x7OQm/nHfFQfiYotGx17V+0xgebpdEwkODHjwvvMmkgZil9+DSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

Hi, James,

On 10/17/25 11:56, James Morse wrote:
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
>
> Add the definitions for these registers as offset within the page(s).
>
> Link: https://developer.arm.com/documentation/ihi0099/latest/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>   * Removed a few colons.
>   * fixed a typo.
>   * Moved some definitions around.
>
> Changes since v1:
>   * Whitespace.
>   * Added constants for CASSOC and XCL.
>   * Merged FLT/CTL defines.
>   * Fixed MSMON_CFG_CSU_CTL_TYPE_CSU definition.
>
> Changes since RFC:
>   * Renamed MSMON_CFG_MBWU_CTL_TYPE_CSU as MSMON_CFG_CSU_CTL_TYPE_CSU
>   * Whitepsace churn.
>   * Cite a more recent document.
>   * Removed some stale feature, fixed some names etc.
> ---
>   drivers/resctrl/mpam_internal.h | 268 ++++++++++++++++++++++++++++++++
>   1 file changed, 268 insertions(+)
>
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 1a5d96660382..1ef3e8e1d056 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -142,4 +142,272 @@ extern struct list_head mpam_classes;
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/
> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages */
> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR		0x0000  /* features id register */
> +#define MPAMF_IIDR		0x0018  /* implementer id register */
> +#define MPAMF_AIDR		0x0020  /* architectural id register */
> +#define MPAMF_IMPL_IDR		0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR		0x0030  /* cache-portion partitioning */
> +#define MPAMF_CCAP_IDR		0x0038  /* cache-capacity partitioning */
> +#define MPAMF_MBW_IDR		0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR		0x0048  /* priority partitioning */
> +#define MPAMF_MSMON_IDR		0x0080  /* performance monitoring features */
> +#define MPAMF_CSUMON_IDR	0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR	0x0090  /* mem-bw usage monitor */
> +#define MPAMF_PARTID_NRW_IDR	0x0050  /* partid-narrowing */
> +
> +/* Configuration and Status Register offsets in the memory mapped page */
> +#define MPAMCFG_PART_SEL	0x0100  /* partid to configure */
> +#define MPAMCFG_CPBM		0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX		0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN		0x0110  /* cache-capacity config */
> +#define MPAMCFG_CASSOC		0x0118  /* cache-associativity config */
> +#define MPAMCFG_MBW_MIN		0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX		0x0208  /* max mem-bw config */
> +#define MPAMCFG_MBW_WINWD	0x0220  /* mem-bw accounting window config */
> +#define MPAMCFG_MBW_PBM		0x2000  /* mem-bw portion bitmap config */
> +#define MPAMCFG_PRI		0x0400  /* priority partitioning config */
> +#define MPAMCFG_MBW_PROP	0x0500  /* mem-bw stride config */
> +#define MPAMCFG_INTPARTID	0x0600  /* partid-narrowing config */
> +
> +#define MSMON_CFG_MON_SEL	0x0800  /* monitor selector */
> +#define MSMON_CFG_CSU_FLT	0x0810  /* cache-usage monitor filter */
> +#define MSMON_CFG_CSU_CTL	0x0818  /* cache-usage monitor config */
> +#define MSMON_CFG_MBWU_FLT	0x0820  /* mem-bw monitor filter */
> +#define MSMON_CFG_MBWU_CTL	0x0828  /* mem-bw monitor config */
> +#define MSMON_CSU		0x0840  /* current cache-usage */
> +#define MSMON_CSU_CAPTURE	0x0848  /* last cache-usage value captured */
> +#define MSMON_MBWU		0x0860  /* current mem-bw usage value */
> +#define MSMON_MBWU_CAPTURE	0x0868  /* last mem-bw value captured */
> +#define MSMON_MBWU_L		0x0880  /* current long mem-bw usage value */
> +#define MSMON_MBWU_CAPTURE_L	0x0890  /* last long mem-bw value captured */
> +#define MSMON_CAPT_EVNT		0x0808  /* signal a capture event */
> +#define MPAMF_ESR		0x00F8  /* error status register */
> +#define MPAMF_ECR		0x00F0  /* error control register */
> +
> +/* MPAMF_IDR - MPAM features ID register */
> +#define MPAMF_IDR_PARTID_MAX		GENMASK(15, 0)
> +#define MPAMF_IDR_PMG_MAX		GENMASK(23, 16)
> +#define MPAMF_IDR_HAS_CCAP_PART		BIT(24)
> +#define MPAMF_IDR_HAS_CPOR_PART		BIT(25)
> +#define MPAMF_IDR_HAS_MBW_PART		BIT(26)
> +#define MPAMF_IDR_HAS_PRI_PART		BIT(27)
> +#define MPAMF_IDR_EXT			BIT(28)
> +#define MPAMF_IDR_HAS_IMPL_IDR		BIT(29)
> +#define MPAMF_IDR_HAS_MSMON		BIT(30)
> +#define MPAMF_IDR_HAS_PARTID_NRW	BIT(31)
> +#define MPAMF_IDR_HAS_RIS		BIT(32)
> +#define MPAMF_IDR_HAS_EXTD_ESR		BIT(38)
> +#define MPAMF_IDR_HAS_ESR		BIT(39)
> +#define MPAMF_IDR_RIS_MAX		GENMASK(59, 56)
> +
> +/* MPAMF_MSMON_IDR - MPAM performance monitoring ID register */
> +#define MPAMF_MSMON_IDR_MSMON_CSU		BIT(16)
> +#define MPAMF_MSMON_IDR_MSMON_MBWU		BIT(17)
> +#define MPAMF_MSMON_IDR_HAS_LOCAL_CAPT_EVNT	BIT(31)
> +
> +/* MPAMF_CPOR_IDR - MPAM features cache portion partitioning ID register */
> +#define MPAMF_CPOR_IDR_CPBM_WD			GENMASK(15, 0)
> +
> +/* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID register */
> +#define MPAMF_CCAP_IDR_CMAX_WD			GENMASK(5, 0)
> +#define MPAMF_CCAP_IDR_CASSOC_WD		GENMASK(12, 8)
> +#define MPAMF_CCAP_IDR_HAS_CASSOC		BIT(28)
> +#define MPAMF_CCAP_IDR_HAS_CMIN			BIT(29)
> +#define MPAMF_CCAP_IDR_NO_CMAX			BIT(30)
> +#define MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM		BIT(31)
> +
> +/* MPAMF_MBW_IDR - MPAM features memory bandwidth partitioning ID register */
> +#define MPAMF_MBW_IDR_BWA_WD		GENMASK(5, 0)
> +#define MPAMF_MBW_IDR_HAS_MIN		BIT(10)
> +#define MPAMF_MBW_IDR_HAS_MAX		BIT(11)
> +#define MPAMF_MBW_IDR_HAS_PBM		BIT(12)
> +#define MPAMF_MBW_IDR_HAS_PROP		BIT(13)
> +#define MPAMF_MBW_IDR_WINDWR		BIT(14)
> +#define MPAMF_MBW_IDR_BWPBM_WD		GENMASK(28, 16)
> +
> +/* MPAMF_PRI_IDR - MPAM features priority partitioning ID register */
> +#define MPAMF_PRI_IDR_HAS_INTPRI	BIT(0)
> +#define MPAMF_PRI_IDR_INTPRI_0_IS_LOW	BIT(1)
> +#define MPAMF_PRI_IDR_INTPRI_WD		GENMASK(9, 4)
> +#define MPAMF_PRI_IDR_HAS_DSPRI		BIT(16)
> +#define MPAMF_PRI_IDR_DSPRI_0_IS_LOW	BIT(17)
> +#define MPAMF_PRI_IDR_DSPRI_WD		GENMASK(25, 20)
> +
> +/* MPAMF_CSUMON_IDR - MPAM cache storage usage monitor ID register */
> +#define MPAMF_CSUMON_IDR_NUM_MON	GENMASK(15, 0)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_CAPT	BIT(24)
> +#define MPAMF_CSUMON_IDR_HAS_CEVNT_OFLW	BIT(25)
> +#define MPAMF_CSUMON_IDR_HAS_OFSR	BIT(26)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_LNKG	BIT(27)
> +#define MPAMF_CSUMON_IDR_HAS_XCL	BIT(29)
> +#define MPAMF_CSUMON_IDR_CSU_RO		BIT(30)
> +#define MPAMF_CSUMON_IDR_HAS_CAPTURE	BIT(31)
> +
> +/* MPAMF_MBWUMON_IDR - MPAM memory bandwidth usage monitor ID register */
> +#define MPAMF_MBWUMON_IDR_NUM_MON	GENMASK(15, 0)
> +#define MPAMF_MBWUMON_IDR_HAS_RWBW	BIT(28)
> +#define MPAMF_MBWUMON_IDR_LWD		BIT(29)
> +#define MPAMF_MBWUMON_IDR_HAS_LONG	BIT(30)
> +#define MPAMF_MBWUMON_IDR_HAS_CAPTURE	BIT(31)
> +
> +/* MPAMF_PARTID_NRW_IDR - MPAM PARTID narrowing ID register */
> +#define MPAMF_PARTID_NRW_IDR_INTPARTID_MAX	GENMASK(15, 0)
> +
> +/* MPAMF_IIDR - MPAM implementation ID register */
> +#define MPAMF_IIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define MPAMF_IIDR_REVISION	GENMASK(15, 12)
> +#define MPAMF_IIDR_VARIANT	GENMASK(19, 16)
> +#define MPAMF_IIDR_PRODUCTID	GENMASK(31, 20)

Just a friendly reminder:

v2 defines _SHIFTs for each field in MPAMF_IIDR. They are removed here 
but will be used in the 2nd series.

It's not an issue for this series but just a friendly reminder to add 
them back in the 2nd series or the mpam/snapshot/6.18-rc1 cannot be built.

[SNIP]

Thanks.

-Fenghua


