Return-Path: <linux-acpi+bounces-19056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BCC6CAF2
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3784E8233
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277C2E7F38;
	Wed, 19 Nov 2025 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VB7Oxgqy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960C2EAD09;
	Wed, 19 Nov 2025 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525650; cv=fail; b=KkLtyb0MnisYrMQA4pHTZPlMZZywqeq/5EFrDoQzDW4JR7kQ8ppGnzZm2CFsUZU69m5lua0aEkNQthoc7AK+8EnvBqKa+hAP94Ffwzm+0QOv5prFD0ZT571r9/upddd+7Cgzy7wQaC8/Rj+rSC5nnYyGkCY0C42Qh1wlPT5MUIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525650; c=relaxed/simple;
	bh=6y2oZ/QlYRqRGk3E2VtmMKsWX36CKYbmSo0YBxBMwbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4tchZlcl86X+wxhCN1zbYYjMGTZ/Cae7R05BHngO3lJYc9NwrDNoPzWI2B1P0OylHRndTMrWg5qva0kr+dNhJHfTls9HArVQ5ygtdQexjDqx6oZo9wLUSjdhQKnXDHnyo+wWI8z0xiV2GKXPLRYJY8mqSwTYVE+d1gWSj+RBT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VB7Oxgqy; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py8Cd2MgOTFRWU5xQVbhGLbaq2G/ghT3fgQ6E4rqrHFg2ParAZkPcYGJIMSHPpzfvFoMYZO9UWRzbLMRTJgun3RC/ZZqDxJm4JQMgsAG0//sEzmru0QNgIgHsiC0I2owM3EKp8eEXKs4aJjHpeyOXICaQ3ky2sGKaF+R5YSX75FPfm0sHa90mdVmr62x3ffzvgy4kgkfnds111invDbaysRzQw77MVMSd9hnfXBnyLI95kTfKyWG/977IRhTcKTAQBzM+L0LTJg1Ln/9lnwzNeboAftvoNFQNkRxMyGkXuDz0iNS2emt2Yc/6wph7+bC8lVbXcP2l7zkbkKfVfqAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqHvlD/4FyCDQLcVkwhrh2nTIYvkyHu/R7HXVd02qgE=;
 b=dYzjfJo7mF2NcEW7Q6CPeaxZft46b0cp6KoVF+Ufe7lqavqojKuKIBvC+YUEwds3R4dnJXmHPcONkfi6cgcndUxZCQvoxZaTpEsUp4QRLj+1skDkLjubjABd7EtWYfRTTBhlak+z3AlqyJPLAfvGj+US4+aTaubrCesjaIrX9HHoNL4blHwOZ8ProFcvpRJKa/B4xcqer5Z4c132VrMVQ+NKjHdZDvZ5PNa1vtuZw8Oy50qt3+N04qFTX0yCeXOdBOdDoLxNxDM04LennB6zfbzaqKrx5YEsshPRYUQNjlWolhObbESG4lr/6SMi3W85UcHQUrj+t+bLYVCo/qLsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqHvlD/4FyCDQLcVkwhrh2nTIYvkyHu/R7HXVd02qgE=;
 b=VB7OxgqyF8xl2n/OzWfSzK+kbViAEPPy7+2OfF4E2DgDJ+BZNXuK40JCmrP3Qx6KqAh3lncSwzw6htFQb6n4NX9TzKnRp+o5ZGpH49um/ZRumVoo6LEOLTcDk0UtB7Cqu8OWr23Sr9rJOhXi/2UGdXf6NyUV1+oN8X3lR3OUVgbX0cAACVMUPxCw1WSyAy6VS8K6UMhFIYdVjP7JsAJ5q0DOv8Q8kZmtDJLosXajRMmROYHYgYr/dZFQu0VqSTjTJ4D5kMGdPzBWlMwZhr019nMREFA/xglqGAaziM3cn/lwxNvkxai0FYc/G0YI634XGxMdHREpOayvJT9PKLNGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 04:14:03 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 04:14:02 +0000
Message-ID: <bb238bdc-1870-4888-874e-b3fa466d264b@nvidia.com>
Date: Tue, 18 Nov 2025 20:13:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/34] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
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
 <20251117170014.4113754-16-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-16-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bf301a-bc80-4f8d-7305-08de27221274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnFnaGJmb3F5Z2ROdEdiaW9IZXBydk9BaUVLQWZLWmIweXV2RmhpNHRFeFAz?=
 =?utf-8?B?RnkwSjc3T1FDc0NLaVhWZExOMUxWeEdta1plRG54TkdJSmsvUk9OMjdobVQr?=
 =?utf-8?B?RStnK3pGYUJmU2MzOWJLSURpT1pML1pxY1hueUlxYjdqdzdQNW5lMGZtMThS?=
 =?utf-8?B?YkFzTGlFZmkrRHMzaU1YMk1qUXJOU1NKSDFIZzErSi9TcFhlMHFlWElDMTVQ?=
 =?utf-8?B?MklDNGN5ejZ1Y3V0aFA0MDZNZG9ObFJxRjdydWRKbjRaYk10bm1yYzIzYlpG?=
 =?utf-8?B?R3YvZFdQdFhPSFhiUWNFVlhDajZTNmsrb0N5OGpPbXk2TllpZmdOckdNakI1?=
 =?utf-8?B?aGZOSXYxQUxxZnJ0N0ZYdVZDQnJaNnVSTkVjZmxDYldwcTFWZHVYQzJhRGFp?=
 =?utf-8?B?R2ZYQVBsVGpNb0tIYmxrenpXd1VldmpHUnhBZ3htVU5BblpDdUVjTEZaL3BK?=
 =?utf-8?B?UE1LUnlBVnlnWGt4VGxGa0lxLzY1dFJGdGl3UVcyeHo5N1o4WE8zeG5DQ05V?=
 =?utf-8?B?YnkrY3QyNndad0xleVFVNUZGRURzdTBiSHBvRzBnZFltRkliclVOYkp0S3dy?=
 =?utf-8?B?MEJVMDFZMCtoVVVmclMyT3BHSThKdzExSXpMLzYvZzlxYXZWbjcveHhqbjc3?=
 =?utf-8?B?eGNlY2c4WlBUWkRCS001SFJOOWhTTVZQWXREZVZJZGNlWkJqM0MwQU52MTJZ?=
 =?utf-8?B?MW0zZHhFOHFrQWR2M2lkeWliNkhST1MyeEtxVlN5ZXVRQ2FMOFJhWi9GV1o2?=
 =?utf-8?B?VHVSblRVVkhCMXc4RzM3S3pKY2VkK1hvYmMwR3pZMnlqT2xmOWhUSHhjUXNE?=
 =?utf-8?B?UGc5WFViTXlseWJNNWtsa3pzL2FNT3dEUzFNRmhJeFRvajc4V3B5cFBXS0Jh?=
 =?utf-8?B?NExUcGJFa21zRStBbGtrYUYrcm5namU0VnhOSUtTeVp6cFV2K3U3OTBaSzBS?=
 =?utf-8?B?Mll4MVBWV1h1a2hHekUzZURCVzhEdjdTKzRMKy9YWlV6U1dKWkN0MzAyRlBE?=
 =?utf-8?B?UHpvbUhnMXcwM1NBYWRpbkR4TnFhRVZ1T3RwWDZTOW9waG8xL1lpM0l0UDl3?=
 =?utf-8?B?WkI2RnlaTUZkU0tsUEdtWkQyYVdCWGJ5RWNKT2h5cU1WNXlrVjhQWHQxQ2RT?=
 =?utf-8?B?YzBwanNrQU9qcnovQlRlOERhbDFIM0VaOHZZYTdLdmNnM1hHSUxZZXkrYm00?=
 =?utf-8?B?bDhacmYvTitwMEZXZ3g5SGZGUnBnY3BsYnUzY0RSMmg4VCtmNXhCeVVwNW9T?=
 =?utf-8?B?ZnNjbTl1M3dLTWs3bThjSTNubnUzdkdYT0J1Q1lDRVZ0WnM5bVROS1VzQ1RS?=
 =?utf-8?B?ZTV4TTJDK2VsMVFRZ09qMDZuS1dGbGtKbWRjTG5yTjZzaFNYKzdWRUhWR0dB?=
 =?utf-8?B?T2xiTldwQjFsOGhOVlBCd2ZWUjVqckN3SmhHSFNSM2s3V3NaQzlvRTlSK2hv?=
 =?utf-8?B?R0F2SzRDYWJjM1AxMlRKM1gwcUk0cXVZTEV1TytvRkh3aTJYUXY0bDcxbWQ1?=
 =?utf-8?B?Yzc0dWVhR2pJRm93bGRPTEZzNURhQUVtcmJLa1VRTUE0RlZiVGxPNHpCL2Vx?=
 =?utf-8?B?MWl4d250VE9jQ3RrZko2dVVKaGxzOW92TnN0NHQ5VkxtMEJCUjZLa2Q0Nktm?=
 =?utf-8?B?eUlGWEFlcGJUSlpGeWJsb1kxdWNjTWc4YmtNVFBuTzEvVFhkWnlyUHZiTWs2?=
 =?utf-8?B?a0xKd0FhaldEemdhNW5BbDl5WURaTWNrNm9YVnhxanU2bFBUd1dxY1FxRG1H?=
 =?utf-8?B?MWN3d05aUTNJMWVyMjdsdXdtUjdjdG5MRmhQRmlXOEZyL0Z0ZHM4bDF0T3gy?=
 =?utf-8?B?T3FOcGlPa3Iyc1pCbWx4cm5rTnB5Q0I3RHRTVWowdXZMS0JnZVB4NEp5Y3lx?=
 =?utf-8?B?TWkxbGUyYjZiaGtNZWVOVVR5SjZkdWNVOVZRNm9XR1psVkRRbjQ3N1Ftb3pS?=
 =?utf-8?Q?LehcQepkn5d4G/kpdUT8l4mYOQi9MWNr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZpWE0vNkYvOGFUUDhzT1Y4RXE4eWtVYzBMUGprQXdrNUpmb0JjYmhEZys1?=
 =?utf-8?B?ZmZjZkxLdVpHbW5Na25YRDFIUFUxYnJ2M1Q2Sk04M3lGMXl1dDFNcXNQT1hW?=
 =?utf-8?B?NXd5Z0hGcGFJbWp2a3ZneldSYlZGTnpVbVNvakxwVk0xQlp4NW9HTkIwTXAz?=
 =?utf-8?B?NHFHZ1RLeTRremQ2cXFRVUQ3TCtMQ1BMekhhYjZSME52T29zMGxJd0k2YXVR?=
 =?utf-8?B?bEN2RG1nYjFFbWhqTXRjWXZxcGMwakVWWkVmcnpDMmdPSXZmWG9ZZmhoOHV5?=
 =?utf-8?B?MmdJeUY3SWlJamhZMnUwN3RJcU5kYloxYUhEU05LYzNEb0hWb3U5M1FPSkZZ?=
 =?utf-8?B?emtib0VpZmQzSlFJMDREcWMrRncrcnFXRUZiYzVtQWU2RDhMM1kyajQ3cHZq?=
 =?utf-8?B?eHJOVnN2YksxY2RSaC9wQ0F1THplcWdIN3R2QVdwYTZ1WTVYWlJiU0RpdjYr?=
 =?utf-8?B?NXNYWW9kVDRWWEo1NDB1K1ZFQjRJTFlUb012Ykg4bmZXSmpxUjFxdnQyZVFE?=
 =?utf-8?B?eWFrLzE1SnJSanBrMjd4RVFCWUNTa2hWMTh5M2cybEgrcnp2YU1ES3VXSHg1?=
 =?utf-8?B?Y0o3S1dhNVlIOE10KzZEYnhtNFhyMDZJU29EN01XRjI5NTNOSkhveTViRVJp?=
 =?utf-8?B?eHlZc2lESGdLZ1hUcmZoTDBtZ1Ywb0RUeVhUVFVQc0pZMmsxVU1oZytIK0NY?=
 =?utf-8?B?THhXL1o3M3FMVis1ZFpkRHVMTHFGZklpYVY4WVZscHdtWHR6VDBYN1I0S0s5?=
 =?utf-8?B?WjZkRnZrclBYLzA5bVdWZmwzNUpDOHhmM3FMSDN5dytOeEJWSHBoQWZxR1Vz?=
 =?utf-8?B?M09CYllwQ1h0RjVNM2RPc25iRnpGWGdIaDBkbXIzRTBuQ0plRmJBUHUzb0NW?=
 =?utf-8?B?UG9NQmpoTXRBM05DQlJPa2h2WnN1Z0VTRlZUcC8zbW5uMGRlbThZMDdDRWdP?=
 =?utf-8?B?dFdmV29QVERIaTlBM3YxK2V2UFZvS3haTlh4OEQ0ZWNhTHMvUmk5UWVCdEpK?=
 =?utf-8?B?TFJUcklYODFocHJtRmdLWEFTY3VGRnFKSGxOQ3FIM3ZmMHRzVXd0UGRadm0z?=
 =?utf-8?B?ZHNSc09SZndjajR6Yi9Fc0lTQkd4K0djZmdkTEdvN1ljcS82blNnRWZuRm5Z?=
 =?utf-8?B?UVZLSWtSKzRSTjd6ZzR1Q0RiUS80bGlvZ1RENHJhNm9mc0M5SXIvY1dreWEx?=
 =?utf-8?B?dkhiU1NsOUlURkxzSWl3QlFzNTBJTHQvdHFUMVlISXFsdWpaL2RYa1dITmNy?=
 =?utf-8?B?Tk1YdXQwZ2U3VnFyaDFYbVZWYys5eVFUZXZad0ROY0JSRjlvZ1FzUGVub3Qr?=
 =?utf-8?B?b3ZBazE3V3lURTV0VnlMQ0ZhUnFDeExTTEhiNkVYUjdNT2tKTTAwQUp1ZVB4?=
 =?utf-8?B?S0M1MWl6ckY5QnVEOTNPUU5Ld2l6Ymw4NUsxNXNWL1dLVTQ5S2tYYnV3Nldi?=
 =?utf-8?B?WkJ1T2hYSy9ETjRtVWNWQUFCV2VxY0draXRHWERTNlFwd1hGRDJjbm51N3Bu?=
 =?utf-8?B?NmRVWHFKMDYwLzJDdHpjblpXYm9yRnYraVRmNDIwWmUvRFA3TFJnZDJpNmhH?=
 =?utf-8?B?bUpHWGpVWjRJQ3dIMytKaFdYOFhoemhMS3hEMkJrenlNNnVzZVVlT2dnVnZX?=
 =?utf-8?B?eHBpMnRiQnBRei83eTJ1aExpVkZKSC9laG41S3RvQTJyNGwxcFEzM3pWWEFu?=
 =?utf-8?B?VXk4alRmSlcxKzJkTGVEd1RweDZMbW9VSE1JR0wwa3FIQ0FaTDhKaHI2UERy?=
 =?utf-8?B?ank0emYzNC94Tm5JVzZFdnUvc1k0aFRKQU1iTVp1K0RpSXV5QlExak43cnZ2?=
 =?utf-8?B?c2V1QThBSXBYZ2JHbG9rZEsyMy8xd2x2QzFpaXovK0Q3c1ptcitzeEFUS1Ez?=
 =?utf-8?B?c2hiSmdTQ09nOXFlQ1ZCckIxVlVxZmNQMlNCN3JvQlhmTlZPcVJvZWJOSHhR?=
 =?utf-8?B?VUxHSHNUTVJaZUdQa1dnY0pYWlhFQmd3N3NIUjBDbUM3UWZKSlY0am82NnNl?=
 =?utf-8?B?UC9iZEFsbjYvd01zNlZIRTBvY1BTdFI2ZU56UndXTHhJSC9xai9PclRzOWNv?=
 =?utf-8?B?MHRidmR1dDJRVU9IVGNpT3pqYUpwNXRBZ1BBQnVqdzBxNzJ3dFRDQXB0VU9t?=
 =?utf-8?Q?Dahq6oJhF5g/sGGGz4Ew6EjP1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bf301a-bc80-4f8d-7305-08de27221274
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:14:02.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KV4EkPYx8rLxLk7Kc1zokSMnCjSCbHLfEEh635dEea9xjzMq29kfWmhM8on+acuqEmKtilelLu6UOYi5H3miA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Hi, Ben,

On 11/17/25 08:59, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accessible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> or PCC mailboxes it must be able to sleep, meaning a mutex must be used.
> The SCMI or PCC platforms can't support an overflow interrupt, and
> can't access the registers from hardirq context.
> 
> Clearly these two can't exist for one MSC at the same time.
> 
> Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
> only support 'real' MMIO platforms.
> 
> In the future this lock will be split in two allowing SCMI/PCC platforms
> to take a mutex. Because there are contexts where the SCMI/PCC platforms
> can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
> this now, so that all the error handling on these paths is present. This
> allows the relevant paths to fail if they are needed on a platform where
> this isn't possible, instead of having to make explicit checks of the
> interface type.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com

[SNIP]

> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 768a58a3ab27..b62ee55e1ed5 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h

[SNIP]

> +/* Returning false here means accesses to mon_sel must fail and report an error. */
> +static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
> +{
> +	WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO);
> +
> +	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	return true;
> +}

This helper always returns true, never false. And this may cause issue 
later.

On the bottom line, this causes confusion in the comment and when later 
its return value is always checked by callers.

It's better to improve this helper?

Option 1: warn and return false when ris->iface is not MMIO. No changes 
in other patches which call the helper. Seems this is a better fix.
Option 2: warn on non MMIO iface but no return value. Other patches need 
to be changed when calling the helper.

Thanks.

-Fenghua

