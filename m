Return-Path: <linux-acpi+bounces-18850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13289C558E5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15633B9A4B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 03:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE172882A9;
	Thu, 13 Nov 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSMrQKd3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477A20FA81;
	Thu, 13 Nov 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004247; cv=fail; b=NExFTFLF+txlJCNqEPidkHfnuGvrTKIzcXs3+xPBit2j47XRG+8pCML99bCSK3f++m0zBxlkf1OhEKFXKJJhdXDVYXUcV7vWaFgFYr/yJOyxpmsb1EEm9vRfUUHopDoIMdbQUzB9lH+57g3VgWl3uMprqHM7D/QuCb3ai3MIOnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004247; c=relaxed/simple;
	bh=bvcL74xSWfHyOgJy3ubAyT2qQkf/EesfikcaDDcLJLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AC0aA235pp1DcuLLLKtC9j/NXs3ptyPDyRCe3WvbMJii0IkB1uSn+qbP+iuGKFHBIulwc0QIBKtnLm4LVa6JhzYgjF1d69Vhe0PvYZfEiU8D/Em2kqpPqpPYwfxcJ0SfaFMej6H6ystqNW9fTCuazixD1+X8WGOy4VlIbwa61oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSMrQKd3; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzVjSLmKSUI6o+Zv+7hhiqX+d6w3Hny9yA+uBIxjuyUmq//ZjbEx6rfLXBcdzC+Mo4OW5EXCRfrj3IxbOWF0fHVfrvVh9Qiu1LQjZWjT7J5wvFEGbp5g+LXXuwo8i2J60Fmk8IqLS8EHPrgmCtBcLaAC1ys0GYz7VlLwel9AAcIKBEwzXO/loqvzKahoga8sJ7jCdd6C66Xt0xApdLb0lJMOs0Ztb9MpiDxC5Algavgb5E84uwD2aJh0eMHPHg3utXl9/TQyE68s2cHiD2fFlhZu399JMzazZNKCgx4Vwp4TFvPJGxRMC+gJQCPZU63X2vUFfcc+iqoIjwfCvvTD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGU5qXcWOT5sLgy/gnoA207ph+6+w9luQTZENp36ZGc=;
 b=FtWKZRL23XabZLvJPzOrmSZnJ4+r9u60PJyK/CwF3h/9wg4uu+/kXFt2TCFNWpVLY+gPFmn6oCqGOIjkBnGGFkcM/dx1/FYMIImoj0CEFoIknRX76FqNJcwhkXLB/zYNj6BnsFYRzpzutjB9fgCPgZAgeBwPaBiIzlkhzyIlfbv5GxcQ1wZssqjIPtLEeGu97ZxR+T3YYnqPXBtY5blu1m9Hgrwl0CPlFHwL3zdmdJeslCoXvruIJAqu4cfdkbqs7icF8L3JNaLuQYuvJ4DGnnA0zMp9J3PEe9jkqSoCNakfGPvZgJbS07KdWDak+J1O35ABwWsp+UaXlJMUYQ4HXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGU5qXcWOT5sLgy/gnoA207ph+6+w9luQTZENp36ZGc=;
 b=PSMrQKd3hVNfG794nrY0TbpySW9lhpTwcbmgIbXGvbKA+X/e2JClt+tBPOrW7goyRbRHXXd4pA0rswM9ceFtTT7n6QNSg74W/Liyljp19lCDfJxX0bxJdQazzoNJdwNemPgbOeqPNyk2TfrATFN8bzoy5AvUxlX/drRfcy9vk4W9YEKyBNK/UAIv2VS2QUiwLxM9BgWokTMcz5+3DXf+8hQAZ8UWtVawF0X3G/wlAR4jz+SlEwaAV+uceHg8BzD1qmOy40/WUmiahnPYWyqIW9PgO57/sREP6oSKT8aKw2bcQAEsbPtqg3faWQnPQKdL85y42Gw23p9x7zC5asJSSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 03:24:02 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 03:24:02 +0000
Message-ID: <316b04af-2005-47f0-887d-6e9d4031df5b@nvidia.com>
Date: Wed, 12 Nov 2025 19:23:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add the class and component structures
 for firmware described ris
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-12-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-12-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f68e3b0-b31d-48ef-0535-08de226412c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHVpVUFsV2x1TlIwenRtbXMrMnFYVlBlZlV2KzVVTkk5RENSck5KY1FhenpE?=
 =?utf-8?B?b1A4VExPbW5lS3puaUhoR2NpZ25DTVptanV6dE5wWmhveVQ4R0pWZmhYNmdr?=
 =?utf-8?B?VFBHNHNGZnR2cFFFdjJuWjc5QUhab2tqczRHV25SeTZ1eXdmS1pXSGl0Q1lk?=
 =?utf-8?B?azEyQ01HbUFMcWowQ2o2bGREU0pMNDBBQyt3emh5UXA2b0t5SlNwVGU0eURU?=
 =?utf-8?B?ZlJhNFl0M2dIUVZMekEyMUJQSlVxK0h4dnNoVThvZjMxdTMyNm9ENmNHdUVH?=
 =?utf-8?B?WlJKd0E4VFhwbGRuNGJxL3l6TTVMZVNjcUdlb3ViaTl3Y2JOVjJoUjVlVWZL?=
 =?utf-8?B?V3BzdDIxdW1VOVNGYTBmQmVLUHcwcis4NG1HZk50SGFqdktXVm84enNFUHF5?=
 =?utf-8?B?NkdGSlp0cGlmSFJySlc0cTNMbkJiVDg4Q0l3MldJVzBrZzBuTFdLcGh3dFpF?=
 =?utf-8?B?aERncXpDcnpqbGhKaWQxU2RsQlExRE5CYnR4QVRBSi9KcWNxTWNnemZFTVVo?=
 =?utf-8?B?emNPV0VwTU5temhRWEhZTkVBU0d3bytaeHUwbTFobVNPQm1sLzhZbHR2eHVZ?=
 =?utf-8?B?bDA3c3RxMjVEOGN0d041UWNuQlo5Nk1QaHp4WndnOVZTWWxEbnIyaGd2akpN?=
 =?utf-8?B?RzZ3eUhmVzVQTWVvTXplTmtEODFHZjdhT1RYNU9SUWhEZHJIazRBSXo3YnZ1?=
 =?utf-8?B?eHUwek1kUXNHSUxINzFDWWRrUlJDbGlRbGg0aU1TZkRhRy9sUjRnMTBDZ2ho?=
 =?utf-8?B?VGkvblRvcDBlc0tJSjN6RUpGdy9uQlhtWGJlQjVQME5qME5nTHZ1MUx0YW5F?=
 =?utf-8?B?ZXFIcGlVd0N6VjNnYlZuU1FXM2U1M0NCOGF0NHZ3SkxsMG1hYXNYR216cmdK?=
 =?utf-8?B?Y3FUQlpjRVZ5aENCVkFKSFVGQ3VsYktFTEs2WXRBWklIVyt4U0lQVERIWTRm?=
 =?utf-8?B?aXYyM2M4ZFZFakNzcHk5ZFExamJ1RDVHMkxub3ZtbjVQWERvMWZPTFdlWXZB?=
 =?utf-8?B?YThseURsdFdGd2o1c1lieHBCcXhTMHIwSGZIeEVXZ0R1bzc5Rm5qRjhqR3Bl?=
 =?utf-8?B?TEJyejZZcFJQZk82NWROeWd1Q05ENzB3YVJBcVRqeFFXeWEyNlFJQWlIR1Q1?=
 =?utf-8?B?bkRpWko3d1pMUTcwS3p4aDZmZXhSQzBDd2RLcTZOMnFtZ2g0a245V1ZsQnlh?=
 =?utf-8?B?ejZIM2lCanBvc2x6RmF5NjR2VENCZXlETkFHYzIxc0ZzVXZUREZPQU9Ma2Za?=
 =?utf-8?B?WmZDSXVnblBNdjhxbm02SlJONURFVExLWUEzL09zYlg4VzVhb1BNMHIwZTZa?=
 =?utf-8?B?UGRleVBKcEZNTTd0ekxaeHRQRXhGMnpuR3hGYjJ0cUwrbjdRS1FNVHBoUktR?=
 =?utf-8?B?UEpaK2JWZEVwZzNsOXhZRXJlSUV5OTRPZmNQdnhjSW5uOVpLUUR1cys0YXh2?=
 =?utf-8?B?b2Z0eWh4RGw2UUNMM1JicFF2NTR1NDUxNTRjS3lSbUQvZkVNamlvZTR6aHdq?=
 =?utf-8?B?M3pNRUp6Sy8wQmNOdXd4aVBTUHE5Q2hmVmszdGRla2k3Nk5BK2d3RWFKS2Q2?=
 =?utf-8?B?SW82N0xvTWpRVnRtVEtXK0U0b1JsdnNMOG9BaXFkOStuV3pBa0JNWm0rK3Ex?=
 =?utf-8?B?NkFaLzd1QmY1dzU1T1UrUWQzK3VsUjRSdFJSNkVNanY4b1ErUXQyUXhDajlI?=
 =?utf-8?B?QVZvend6bWNyRUFyVnFLUTJrbXE5bmVBT2llTncxdzBGWjBYRmpNbTQ5ekFn?=
 =?utf-8?B?VzBLcVYrSEhmOVhOWkhjLytFdW5VNFZrSjA4YzMrRHVwYXBickQ5OWF6bitJ?=
 =?utf-8?B?ejAxb1A3bjQxdzFkRzFxNzZVajU4K2NkL1YxdjdkKy96Zjg1M0RuYTBLcGky?=
 =?utf-8?B?ZkIvSkZuZ2hTM1J3UUplRDJkdXI2ZmRiMWNvblF3cGtqc1JDQTBKaWNEblBN?=
 =?utf-8?Q?mp68FcOfdi7MLnVnJVxYtoOeLVhUX9JC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3EyRjIwRitxOC85a3RmZ0ZwaUNEakJ0WUtIV1YyS29iRkoxMStqOW5ONDYz?=
 =?utf-8?B?MVQwTzVYZkNJOS9YWHJ2c3pJK2FyTVo1YlcxSitOSHkzRDZ2UjhXMDA4MUZG?=
 =?utf-8?B?N3BoN1NxbUNEVkcxbzhnSDNXeDBHRTlBb3pjUnRubWZXZWI2Q2k3T3d5MGNX?=
 =?utf-8?B?TG5xa0VLWkgrRGRFcEF6T2dEdFZHM2tLeG9oVEozQW1iUnN2RklWa0FmL0FD?=
 =?utf-8?B?TmJQUEpzS3dyY213OHYrSXpmaE1yYjIvZmpONk5OMmJYenlCN0lYNEhtVFVt?=
 =?utf-8?B?SkVISVVnSXVWQjZXQzVWeWFVY3JmZmxxWHh5cFQ2cytqa25GZUZ4bUMvYXQw?=
 =?utf-8?B?ZVBKQ3hkaWo1UnM5aklXSWR1NGIzb2xrTTZxbXM1MWVmRnJ4K2ZJN1V0bU1l?=
 =?utf-8?B?eHFXK2JxVzZhL3RnaThNaktBVlJnMlpPZVhnanBnY2RESlphcXgzMGRNVThW?=
 =?utf-8?B?aVF5SFgycFJMVGtnVGRjemNaKzhEWnZFWkJEdnJSbEZzYkFtek41NXZhQXRq?=
 =?utf-8?B?blhVaWNxQkwrbStBRE1UTU1lVjZNYndzNFpTMVFFaGxSejR2dTdpQTZLSm5j?=
 =?utf-8?B?MWI4dGwzUFdmd3lFbHlpRndXeGVBdlZqS002M0lUeXdmSksxa2FqMEhhYWx4?=
 =?utf-8?B?TXhvUE1Ga05NVThqcURTUlRkeERYNTI2amxhRjh6eUhmM1JZWDcvT3NTVkhm?=
 =?utf-8?B?RWFqMkE2cmc4c3h5OUJqdXY4MnpvOVhFc3g3MkU4TXE5V0ZZeUlDWEhSWGdG?=
 =?utf-8?B?VHFuUDNPQ1lxbHFKdnI3ZTFIOFR5WU5XTTdaSFVZTHhrOFpHUGNLdkpISmdh?=
 =?utf-8?B?LzdDQ3hPb2VGVm9pR3pyZHBlbXZYS0kxWjNUdGxwR1lBVjdMREJGa3E5M3Nl?=
 =?utf-8?B?bDFoaVdnc09rUmlSSWI0Nkh2b3poNE5FdXNJUWptNVluNzI1cUlhQjV4TkdE?=
 =?utf-8?B?RE9HRVNSR0NpSmV6RDRqSXd3bzVqNEw4dGxsckRLMzVFU1hmTlk3T0x1K0wx?=
 =?utf-8?B?enZyUXJZenpvNVhUZVZlaHhXZ3YrcnRXWFF0NDRyWkdxL040cnNsdVpQclVw?=
 =?utf-8?B?YXBudlZYaXVGdUozK2hsZXl3T1FwM3E0NngyN1c1bXNYci8zQUlySkF3RkhE?=
 =?utf-8?B?bTkyelE4a2d3UGR6L3REU2Z2MEFNdDVIbFZBRHEyK1lEOVNNWDVqQVpQN0xG?=
 =?utf-8?B?NGtBajFrdlNnWUhybjdST2VLTVBIbkt6djhLMzF1NWcvMWpScDJBNktGTWtE?=
 =?utf-8?B?UStnVERJMFNkcHZ6MnZJZ2Q1Tm91eG9DOWFWeXhTcmdnVTVsYlhHOVpkQitR?=
 =?utf-8?B?KzBnazB6VzZJQW1yelJ6K3h2MGcxaU9FcnVYTWpXZklGaVEzbXJCbklid3M5?=
 =?utf-8?B?Y3hDcCtaU3lRSVc3bGNSdnZWem5KelpkZWRaSGFRelRwNWFpai9CNkJMSzhn?=
 =?utf-8?B?MzdsRmlIM2o5a3JvUWVCL3FtR2pqaDRCY3ppR0xGR3NlY21NdFVxL3p3Mys1?=
 =?utf-8?B?NW1scXpKeTdjamFiTmNxSCtGMjRzSzVyNXpDSDNhTWRqNnBCZDUwQWJtbS82?=
 =?utf-8?B?VkJzS1NUWjBCdWVvcElIMXpNQUhJRTZMQnI1YXFNT201YUM1ZlNaQVViQVUw?=
 =?utf-8?B?bTN4a3ZmTEgzTGNZZERZUnVWeFE3MTU1a1VaTnNpUkNMRFhna0d1UzZTVDRZ?=
 =?utf-8?B?cFZITjdEejh4QTdGd3c4MWFhVTdkNEtBMTBKQkIyNFZhZGZZYWt5bEdCVTF6?=
 =?utf-8?B?ZGhvSzBlMzZZMndibkhIWTBvdGUybTJic2FQTUpvcHExQlNZNFhEU3V2YXhP?=
 =?utf-8?B?Qk1VRVZMcGZtUDh5RTY2ZG5vUFAybytrTndKSkRGcHR2eHRHYVhRcENWbzM2?=
 =?utf-8?B?Ulg0NFUrbVFldXFoNTIwYU5aclROOG9yL1BnZk42Ym5WTG90cWdLK3lpcmZR?=
 =?utf-8?B?VjZ0Z3l3ZGYxaWk4NFRHMEk4T3hYejJXVDFoSG5yc0tXbCttZUh1TUpmNVdN?=
 =?utf-8?B?c010dmFobVR2Vk5iM2tKY0h5WU5iVGFTbUhwendKMnhLcmdmeUJsNXBZOWFl?=
 =?utf-8?B?WjZVOVVZWnpoeG8veXRBUHJZNWlMU1VESFE0OU5BMksyYzlvaG45Sm03cjhs?=
 =?utf-8?Q?QUjTK172t+XfNauaZiqGhMSnr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68e3b0-b31d-48ef-0535-08de226412c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 03:24:01.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+TzY0AXrrn1I0DFrRoW67LB876zFmn4bbRAqmjFgRhfp5sQ6rXMtXcj3aTfZJP+cGrFlGh77OLhK3425IR61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

Hi, Ben and James,

On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>

[SNIP]

> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id)
> +{
> +	int err;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +	struct platform_device *pdev = msc->pdev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
> +		return -EINVAL;
> +
> +	if (test_and_set_bit(ris_idx, &msc->ris_idxs))
> +		return -EBUSY;
> +
> +	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
> +	if (!ris)
> +		return -ENOMEM;

The ris_idx bit in msc->ris_idxs is not cleared on error paths in this 
function. The bit cannot be set again.

Not sure if this is a real problem in any case. Clearing the bit on 
error paths may be clean code.

[SNIP]

Thanks.

-Fenghua

