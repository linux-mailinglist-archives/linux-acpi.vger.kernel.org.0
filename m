Return-Path: <linux-acpi+bounces-19039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904BC6BA93
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 21:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94ACC351DBC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47AA2FFDCF;
	Tue, 18 Nov 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+/1AR35"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03682F7AA3;
	Tue, 18 Nov 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498655; cv=fail; b=ddtbQwwJQ/BahmcW7LBdqXgqOQKv3MIW2Oa9KKrvjVb8O6X7rLFoFMYzl23sDYYwlPtWpFcxeKXTAmT+jnCZCGQD5ucbGediPbvaJmE2faS583BWZidfjO607Qo8BY1jChrf9FtOw3/yKWmTVNWu98eVO9mZvvqRqOyMAad0p+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498655; c=relaxed/simple;
	bh=KVu/Bxc8rypDiWUbpxAU0PAj7Ii3uahvgT17wq7mlpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcgA7vs6jQKUQycwVFxaLrhilerd9N3E3Ga+OuRxDTAwSfmxsQLgy+bGcqVIi4+XZgJ1zevGNRIp+qDMjfEaBPgg1MI8oIU6hEOktSORmNjRj5oothApUciDTc3SqjcAmC8YP2oCyojvm81bWz0JtPDK4Z2lJV4WTz/O8h7T57g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+/1AR35; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM3l8hl325X31pMtXVhNck2vM9MDqQ2qHREAPW4t85JyEvBwTlTdjKB570XqrCOI23+kNW51471NaeiU3s7hMSFyQFcQloSOGCMOlsuLkmdCM5yCzVawk1ytOMGyp8Vu+YtkZO5hH8qMQyg0ErY1X36zewB31tKdPFfonoyVPTWq73R7tKNWpZuXSPxpCXyoimZnBwtnxQrbmEpPHhEyDVOka+l/3lK98ItL3fgm9B5LjpzS0Hf1nd5ybQDZoi37WjZW9TdZPd7qeQ7v8LmaCNhDrECnOGq3XMVlmEggPkHU0k6xMMx6QQOKHClXjZWL7o5jZKcvVQeyaB0N+xzl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtjdGsAbiH48yQIQIuECh2RD1Xh2POr5jgTIhgYElgQ=;
 b=FTtn6UmqUSs/S/JhrosY+ag2tAVqeBQpr5ia/CkqokT/liHU+jPkWqpUutd1PhbjkGRH1a169gXsuHC3SpmVPw5NRuqpqPw5XuCzQ9dtgE8ckJN38FBW2WBuRtbyX8RsQnbcp/SBVBKO4VDfKqsWjLSjmBk0O8js/Wu2gnjnPuLyH04+uFtODLkHXLOyYnVZdM/OiwijtUJx1Lto3N63B1dcvLwJrMawhMcOKgWCRudlxr4kdzlpFdh0UGfSUJwHBBXB37qxzieY6xp62rW3uBLkZmikmA0wwqS78b5vvdkPpyYK+vjI7J6dHN77PDw9kuhyvI4qKx7nt8L2aUQg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtjdGsAbiH48yQIQIuECh2RD1Xh2POr5jgTIhgYElgQ=;
 b=V+/1AR35qGgkV30Mpjd1XXv52bBNCLBLTtQHmtCD5X97JmZg6/MA7LrGtLPPi1rEX1V2bGNl/bOiQzVn4IHuYba+VGBZp0ZH0AY7pPpbWH1U1WWBo0wfK9aqco7hvhKohPPg5AUntumeU3X/qsmkkqhug3oef5J2svGrWrDb47DoY8DAMVuggRnwvEPvpJFzUlcoBrAdw0lqdt+goKtDRZE9L+HKNhDxtLdecY+BdCUG5RPKwNkeMZOT0fFkW+aG1sHsQHisBpM78yQV11FmWjCLDGfUJYIBRArGukpgzePgb3CUbEUSMZw3yN1lQm4x8sqxV/KgHAvfkEgXKNTT7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 20:44:10 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 20:44:09 +0000
Message-ID: <193fbf3a-2417-4595-8717-43f43ef14b14@nvidia.com>
Date: Tue, 18 Nov 2025 12:44:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/34] arm_mpam: Add helpers to allocate monitors
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
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-26-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-26-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f87f346-476d-4888-8da3-08de26e33910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFFhT2l2ODZKc2FPaG5pSDRLMy8wN0ZzQjBOZ1FLOUR5ck9FRWdWbTlGQ0F1?=
 =?utf-8?B?ZWdmZ2pEd3BnTm1xUVZmNWhjK09LNmJDQXA0SGRqMXhYcGwrSHJ1VVFVcFNv?=
 =?utf-8?B?M1lHamg1SVI1OUF4Q0w2MDlhU1J6bWRXdWpDc3U4a2VVS0dVMVVMTFFEVW5M?=
 =?utf-8?B?Zzh3bTdOYjlJQzZMaG1kUk95RnVob1RKZG1KMmhCcUNLN2dsczZITE83RDh3?=
 =?utf-8?B?Z0pMNzdlR2dHaDVMQ0VyTVNYRlVycjFRcnB4VUJheHlSYlE4dWFpdDZMRnVk?=
 =?utf-8?B?OVJZN00xNmUvVHIvT2MvdFNpdmhUclA4UHNBdXBnUkdWU2hGYlN4ek5EdXQ4?=
 =?utf-8?B?OGt2UUVHdlFEejR2UDZlOEVVakRFQW1RTG0vT2t2aUJvK1loVFBnRFNnc2VQ?=
 =?utf-8?B?QUVTdWVrNmRCUWpDRG5zYk0xK3IzOFY5RWZwd0w4VkRFVlQ2UldDTm9MbjZK?=
 =?utf-8?B?dVBvMjJtTGxRMVZRVVJ6MzBBZXViMVNDRjY3U3pxcGRFaVd2MDdPcTd3Qjh1?=
 =?utf-8?B?TWk5ZGZiZGVCMGJIQW0rczZTMmNUMWJWRHZoOSs0S2NwK2ZIcnlhWWdSM0NB?=
 =?utf-8?B?U2NhSzYydVdlRFlsRGVYZGdEOUQ3OXNGcVo1UnhUUmFNeE1jTmhNL3crekRM?=
 =?utf-8?B?eWR3Yjl4OXlpRG1rTWJUL09semtDK29jSmt1Tm5GampNWjJXb2xiK2tNWUJj?=
 =?utf-8?B?aytuWEd1VWphT3J3NnhUVHRQbGJCWHhTV0FFTWVNbVJ6MTRlQ2lLNnVUZzBV?=
 =?utf-8?B?VFBQYXQrR3I2Mk9MT2Q3L0FwK3J4SXYzdzNjbmZGSkZBeVBmZUw0dkw2NW83?=
 =?utf-8?B?cDRoeXVwS0g1MFFwaVo0OS83SnM0cU9hZFNtUTFySHFLelRKc3haVFBKenFW?=
 =?utf-8?B?M2MxMytTMm96d29yanN0amFkamR5Rk5qMVo1L0M0R1d5blZzc0ZSOUxLdi9F?=
 =?utf-8?B?MkFSUkNhOHdUZEd5U3p6MDB6cDUva3pGVysyZjV5OVpta1N6bnFUR2EwWkY1?=
 =?utf-8?B?R2dZeU9KSFZxc0JDNFNMcEl3aXhBSG9hcVc5SDRTa3dLcEcvOU9nTFFIRSs3?=
 =?utf-8?B?Zjc1d2dYbjV3NkpPdEVheDRQY296bjYwZjNHZFdjT056b1lRd0NZclJtQ3E0?=
 =?utf-8?B?UGxtbWJzbDM0N0JRdnlJRWxoc0VRNXNBdURxMGlkZDNRaGtUcmp6amFIbjAw?=
 =?utf-8?B?dTM3Q0t2NEFTR1ljcHBBc3FuQTBqTHNOd1FBTXBja1lmemdWNWRoYVFFNlVo?=
 =?utf-8?B?cXJKemI1WEpkeWtxLytkRzd6RFA2U1luR2l6N0JDQjk4ZDlGSHJlZ0YvY1hr?=
 =?utf-8?B?SzJTdUo2VHZlSmt5dnJPRXkxQlhmYnQxMjRGU1R5YU5zdFFsSGY1d3Y0c2ZM?=
 =?utf-8?B?bDZ0VDVGS2R3eWh3OXBndnpCN1Nxb2xjZnd6bGVBb29EaXMzV3A0MW9vZXAw?=
 =?utf-8?B?OG5WTC9PWXZrdlVpU1Ryb1dFM0RpaXRpWUJpSWttei94RFFFZDk5TW5DOHZD?=
 =?utf-8?B?MWNETVlkelFOTWUrRWtUMCs0T3E0L1BJTUFlTCtmWFphK0MrWjMrTlNnRkRn?=
 =?utf-8?B?RHpQem9pR1lHYS8zaFlSQlVzSlVYRGVEYWx5SEJJYzh4WGJTeHc0MytyUmRI?=
 =?utf-8?B?aFFHQ2cwTjV6ZUpmdFNFblUzUUNqUE9iSnE3Tkl2MkRlNkI2Nm5rN0RUZldi?=
 =?utf-8?B?VzZ0VS8wN2NzY2NhTUs1eXc1TkNua3FlOWMzakZUVXkrNzBKanNIa2tLS1RW?=
 =?utf-8?B?bTVrYkFsSXoxV0d0ZHFQOCs0MmlGb01zR0tlSjdCN0U4LzUvSHE2YnF1ck1E?=
 =?utf-8?B?TUprUWNzbm9ISDBuMnZjbWJiTHp4MERISFAvUHdSbXM2c3kwbHVWUTZnbXNM?=
 =?utf-8?B?OU5scll1eUtoSHRBanZRemcva1lnOHdDalFnSFh6dXhuMlZtWkRVbUM3aDdt?=
 =?utf-8?Q?rjMOWMexirycO7zXPKkOgQI9U8CaySDD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXlTRy9HVXBJSnJxVFpNZXBLU00yVDQxQktsc0VjN0RGZEtUU2hJeEY2ZWpl?=
 =?utf-8?B?VWdyWmdFcHd2NG4wZXhFb0I0eTd2VHlYSFBOR1JneXR1NG1HbGw5THlkRk52?=
 =?utf-8?B?MklXZ0gxMEVYQmhqVEJkWW9RZjQzbzJwdTF2TzNUb1RZRlhhSnVFTkc3Rlp2?=
 =?utf-8?B?WE9zcTRtbU15Z3Y4eEVrWGNzamkyaG9xOU9qQUI2Ym5PYnNWbXY5dFlQWnN4?=
 =?utf-8?B?L2ZXbVBJOHNvUXNiblpVWGdLZG1FeE5LU2tjSlZKNnFvVnZ4SWg4aXVLZUpG?=
 =?utf-8?B?aEZUSU01ZldseDNIVWlPNHMrZFZ3dlRpNHl4UjBzUGFIdTUrSWtvdnNraUQw?=
 =?utf-8?B?TDQyVzI2c0JtdDhQa083TGRCT3NtV1RIK0pXSk5aYi9DRG5ZUVFVUkJ3TjM1?=
 =?utf-8?B?aEVsNTB0QmcxNFhQRkFTWjlPc0pRdC9EazdHUUJ0TmZNdmRob0svaE5XNDVh?=
 =?utf-8?B?MEgycCtlazdyNlFZSWxvRjVFN1dGM240dkVkSnBNSnFMRnJMY1FmSHhZZGV6?=
 =?utf-8?B?VkRTUEJVM1VZNW5pZmUyWCt4b2FJK1E0K1VXQXhqd3Z5Q1VWYnVNWWxSNENX?=
 =?utf-8?B?Y29MeDNFOVJBc0RjTUhnbzBwQkMxdU9aaENML1p0emJtbHpjV285cy81cTBq?=
 =?utf-8?B?QzgybHd5NTRUZWlJRzFBQlN3eitscjJzS3FuZW5iMmJUZi8wQldEelkvTjVu?=
 =?utf-8?B?dFdmMU4wbGYvU212eXJ3Z1R4YUkzNXFESG9WaTdSLzd4ZDJqQnlIcXE4dUVy?=
 =?utf-8?B?cWdvUnpvWURtY2I4MzBITTAyMDdRTFNndVdodVdmMXdGM1RNdEpXWnJWUml0?=
 =?utf-8?B?SlVRa3lQbU1BWURPWnhRN3MvU21OcTA1QTdST25ETlVSUHRRdkxlTWM5Z2ky?=
 =?utf-8?B?L1VXZFRUZ283eG1hUTlnL0pDUnBHQk1aQm1DYUpORlY1VjFmZFZ5MEZEQzRx?=
 =?utf-8?B?Z1hnVWp4RUV1SUR4TW8zYnNwODd0ZGVHZHN5b0lxbmNDQy9zQ3l1QTJlTnla?=
 =?utf-8?B?MUJqUkJWYWNpYTFMenZQSXAzTDhvUTBCMGVJU29VdzJVMHpaVjNZcnVHdTV1?=
 =?utf-8?B?WGRob1ZETzE3NVlNSjZiVEprTXpoNk15MXdnK1Rsc3dFRHo4aHRxWmtoTVFu?=
 =?utf-8?B?cnNhUUZpMFpwc0tsRndrWWZZakpva0pVRmlXTVJuYndSazNZM3NaODY0OXhH?=
 =?utf-8?B?U3pycCt2dm8vdlJHSjdoUjBQbW94Nys4TzB3MXZuVTlJZCtzRTZmTk1kSFNv?=
 =?utf-8?B?U1kwNXNOTWpMUzd5bWVnV1krQVZucEFRQzVneXE3KzA0NXhiV1hNd1dNbUcv?=
 =?utf-8?B?MlNKR3o2VTY2d0tzcUJtM0VQb1oveFVSMHg1ZURvN2tONkdxWVpyRS9uaDNY?=
 =?utf-8?B?SlhQMnBwNk9vcEtranFqOEtkZHBXWkYxTTdRalNSaW82T3BmL0J6K09VMkRZ?=
 =?utf-8?B?M2JaUU8xelIwUHRuVnU1bnUvYXpJOEhVRmY3bXgvU2wzQ1M4SHV6ZUVxazl4?=
 =?utf-8?B?Mk9xa3dFdXV2YzFCeER6VVlDRTNRRU0yMHVwWURnc2pTbCtmSjh3VmV5Um9y?=
 =?utf-8?B?bTlSSFAzYlRabTRHcGVSa1RHMTRzZ3IrSU5HZkxlVlhaUTZ4bWRBSmVLeDJl?=
 =?utf-8?B?K3JaSlpJNWNFWGNSVzBsZnJhRXZuVG5xbHM4ZmVaRWdoL2lUN2Y3L0k5Rllp?=
 =?utf-8?B?YnduYmZkWk9IUTZwSXRSVGJ5MGxTNzN1NUUzUU55UzdqUWFOdEh6clVIOGRY?=
 =?utf-8?B?bDg0Ni8xa2c0M2kxcXBvRHBCMHhkdEdmbzl1Uy9QbUJzcm8rRVE3VUZpMWtI?=
 =?utf-8?B?cTVRa0s1QjRzMnlNRG5ncTFYRWxNaldNSjVIelN3djBCRjdNc0JSWkszMUc4?=
 =?utf-8?B?eStucXY1bGRJbWx3blJpS3BkTlZVWTJTQUpaYjBiQThwd2J1RDJFTTFpeEEv?=
 =?utf-8?B?Ti9pRDdpaWxUdE5hTE9YbHliNjdTdVNWZUFvbERBWXlNVGlYNEZBbk9FUVZm?=
 =?utf-8?B?NXF1c3pzOWZhQkgvZmNubmJ4UHN1d1JXTUtWUnM4bW9BZ3cyVUF0VmVKdWZ2?=
 =?utf-8?B?eGxmQWJhVHJqNklJZnoxQ0I0ay9iTkYveGYzdXdHMSttaU51STRjcjdHdS80?=
 =?utf-8?Q?vWWyAGepPNegx0kfY75LkfLnT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87f346-476d-4888-8da3-08de26e33910
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 20:44:09.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9ekg+PJ0C8f1NpbjWf89P/AZ5gJYcYzHk0I2OqNIvCmcsXAgpYezIgB1VuU8bldGtivt0CPhEDuATue+uWpfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335



On 11/17/25 09:00, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM's MSC support a number of monitors, each of which supports
> bandwidth counters, or cache-storage-utilisation counters. To use
> a counter, a monitor needs to be configured. Add helpers to allocate
> and free CSU or MBWU monitors.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

