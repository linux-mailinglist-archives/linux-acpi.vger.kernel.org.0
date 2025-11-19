Return-Path: <linux-acpi+bounces-19062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DCC6CC86
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 06:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A10334F6BF
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E426B2DC;
	Wed, 19 Nov 2025 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDF7AOXh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCD246781;
	Wed, 19 Nov 2025 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763528607; cv=fail; b=hcUqFymwJvqghSCipU6qwLcLi6+L0eBZamQpFtq8SuH15E3qCeTuDpIc0YFchw4RUoaZ56/SoF7xQEW3L24uTe3LinPABRdrNQs0+gs8/pplHJL1atN3YZc6q0hu7mijk3Hh1jAEW67+wJSfAmPNW2mPGbzA7vz+pFKMhSTejK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763528607; c=relaxed/simple;
	bh=/crfYjzKWbJF1RtR9tH51pDpEtKFiXpGtDtrmiI5o6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSdxfJdpYhpafnzsxMCAWb+ABG2NBW45lpadgBIX2kVqlZIlXFVg8/Z1MhvOWSVR78yLDmVd61Y/q9fdoi2b1DCFpFS0qyvorvo3sBZN8vA22zdxRly3kZpul5X+84+G0KRZgDvOBbn15TVH1kTBuK6MI5EsLl0Ds4Xt5UF6XmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDF7AOXh; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6nrGpYxRHIey9Lt55NBSIZ6hdGHq0JXzHIZ0mndLUEjh+ascWR+5e2213gQ9Io852xHv6g26s7KPqavzF+8ANQpwiJ5b00wkQsXM83vS9X/1yTiMh3eIlCWTkPwmfR6bfe9NqQ5R0/+4Wwqlbgu1UEHJj5mTpA0ukFIpwGq5GVKatSEcbFaC4gMnmOwj0NgSH5SuicJcSMaVN9VhvE4wduIqlB/Eiomq2Jpr6GkbjqW6nM+tYiB1NdNiDiJiwS6FHOQ7dXXE1nFFVBjp/AjIPAuIu5Orok0AJgrKr7lm3LnukInhuqqScN21TZqG4u1me/akVe9D53aLKIMY1D7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErrbjQxo/iY97RmnfAjyNW0S+bWbdxpqKeinb5pWCbU=;
 b=j5vAPMrB8Ax+LEXrcjjAweCjp3B0MTGy9K77czZzqXyiuy1zuOEr7rb/lUGZ35qsueVVdt9IWBrd5qLxy2Zz9SQLY/jAwLFTZyObkve7KA1auONgQeVXfcKdxqggQDxWO4kF2Pbb63uwtgFlZcZKwPEsRroNrUCDRnGSmgkRZ2VqHR/MLnDX9Q9OfYDNI11ZEh3c+02O9dylIn1uyRraV9PN6nUYdYHi5ZjwrqRCTLnQUvd1MzbV7sNYVxHJ7kt4Lro/vZw/U0+/8q3RASsPgwPOgEoRKPWalBqugxXjFweI9LNbwqgzvVI2BhUbUiKNsrq83Z+PMhMiwexTE/L9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErrbjQxo/iY97RmnfAjyNW0S+bWbdxpqKeinb5pWCbU=;
 b=YDF7AOXhPGn/JTCkrkzKlHt5gLGMvFVMvpkFdOC3437BkUv9yDKJp6NUg3W8U/nkq8L0/4AddbMJU9sWqV3k7gyRImxsprpYKrbUmxGwvTIrS6ZD1fUoFhI5WuyxwneDZ+NS8Yb7+XpcdGs30HTqJBehLd0bFwX5CqeEcVmF21p1c0aJ6AfPTTvnz5AfZuUUSrdhYe8RiChstEzIcJdTE2x71lnkCdmMCku8SwwIEMiWYcCUpDzy8nH9v/PIFGdfTfjLOH2l83D65Qu9ZPrDu80Uy2z02A5RVTUQTP2T21P8/L13rQqioaFTkvKv90A46i+s4afafT7wXcy1FEa9+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 05:03:21 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 05:03:21 +0000
Message-ID: <1a7473d6-50f5-43bb-b082-99120d127a1a@nvidia.com>
Date: Tue, 18 Nov 2025 21:03:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/34] arm_mpam: Add mpam_msmon_read() to read monitor
 value
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
 <20251117170014.4113754-27-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-27-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 671e6b1c-4d9d-4053-66ec-08de2728f5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdMTkY2M01USnZ2WXFKQ0s0SVZXK0Zhc05UZWZxb0kyN1dvVkdxUFAyeDlr?=
 =?utf-8?B?M3g4RnRQRDVZb01oTzNEMFc2Tnp5bmlKbDBaUWY0a0ptQXdJU1BqNFdsQUUw?=
 =?utf-8?B?WjRsOGorNjd4RjhYYmFCRUJKbmZNTlNkUWY1aUNiN0dEQWJrd0VmbjFNdmxB?=
 =?utf-8?B?RlhDd2RycDN2T3RVSDBBV3ZzNy9neXN4cUdSMUlTWW1uS3BwY3p1b1Q1Vko0?=
 =?utf-8?B?Q2RSUk16OWhsRTgzOVNtU21sMUdFQktqRkQ5bXNZVVVzczNtaEFXQ3JuVlgx?=
 =?utf-8?B?SGl0d2diRGsrZ2UxSmpsWjhaUWpXaXl1YVU5TldGK0F4Z3NINHYvZXIyM1l3?=
 =?utf-8?B?S29reFNTbDNERjlMU0RhMTVRRDR2M0l4VEZ0REgwRm5SOUxZbitWTm9PeXho?=
 =?utf-8?B?NXJoTm5XS0NwdlBCRE1sRGtJdUl0MHU5cVdZUDNxMldtbTZOY2kzTGNQNEtk?=
 =?utf-8?B?TWJMYnA5WnUvNWc2Z2ZpUmJ2VUU2RmRGRlVlNXoySU9SYWhhMm8vcDR5dERi?=
 =?utf-8?B?NE4yL25GV3dHMXl4WStyVldRV2Iya0lzUmpOS2ZkTWJFRWp1YzlTY05Ka1RJ?=
 =?utf-8?B?YjNWTVZIbXBmdkRuOGpyb2lJMUtjQ3VVcGg2MG9XaGhocXVMakpHdnJiWG1B?=
 =?utf-8?B?MU9VbXgrZVc0WkxxS012cE1uYlBMZ3NsMWFaeEdvZkhwZlQ2YWJ3VXNTVnA5?=
 =?utf-8?B?bFRDcGszaWNYcjA5bEtDSmQyWTdDamZJWWx3U3VJWUdHRGlqTzMxdkxlMGhu?=
 =?utf-8?B?dVE2N05uOW1uTTB3TTdEM1ByamxvZ3hkUDVWaWx1UlQ4ZWdKem9odFU1RS9j?=
 =?utf-8?B?ZHg0ZmRWTHRwOGw2cU5VRHdPYzJ3SExTeXBGVXhtdHJKZEkzS1RVNlYra3BZ?=
 =?utf-8?B?TWNIOUtWVjN6LzZJSnFNUkp5TlJDYXhrS0hmQUk1bGFzY2ZJa0Z0QTRFOGVO?=
 =?utf-8?B?bXhhU3JXeXIwTHYvSFFIaUVmWUxIWkhYUUpyK3FoRVVZQ25iOVNIN1pNS0Ev?=
 =?utf-8?B?eEdWZExRb0t1dHg1Mnp5eXg3ZndOL0dmYVRFWmF3MVdHMDZmVTRKZlp1dVBV?=
 =?utf-8?B?ejBXeXZUKzZUTGI0Z3c0Vm9pamV0ek5QcDBNSEo4V2g0QmRsbmkyWnM1N1ZR?=
 =?utf-8?B?cWpidGVWNUZSQ1RSZ0tlbkdVdEI3R0V6YW1OQkMvMUdsV1RnMWZmbUlVWHgx?=
 =?utf-8?B?UVpwalRLbys2elkrYkY4bHhJTjFNMGwwMnh6WnF1Vm9RS2NSditOUG5scjNw?=
 =?utf-8?B?a1Z6amJKVkJndXRjL2xLQTJLSTJJcUxZdWU0czdPK3dlL0xTWmJkNWt2WGd3?=
 =?utf-8?B?Mm8vczFXeldqK3Z5Mk1XaVZzMXJnTDl6MEkzMm1WNHJEQ01GQWJ0cWZZWjB0?=
 =?utf-8?B?bTJsdFdoL2w2YlRka3ZHUTVOaVVkZ1FqY3NKQ29ZN3EvaGhYdmptZ1kvUDVY?=
 =?utf-8?B?NUprbmxUMVVxSmZYV2xJVnYzYnRSVUNlUmtLaG00VmM0OGxUL0Qrcnl2WnEy?=
 =?utf-8?B?amdYOTRjZXFZeEF3RFM0cXdyb0JVMDV3M3VUdlRHbjkzdVF0MWJxYXJndFhy?=
 =?utf-8?B?ZFBwcnVPLzJUM0Jjc0Jic09hK3J4bWFSMCtyczlMMGRsZWxoN2tlbEZnUzJh?=
 =?utf-8?B?TEl6OE9XSnQ3aGR4Q2tSZmJucVlwd1JOWWJrc2RFYVkzeno2QUg2MGtrbkhI?=
 =?utf-8?B?MjZCendpaG4yRDBVTEt0WEF6RmVBVHlmMnpLU3FKQUlQOTJmSFZNODJnMlRL?=
 =?utf-8?B?WkZnTlNFNCtoYnRra1pMcjhnbTdaWVk1a1lNNnVQa3JEODRUbnpxQUhBcS9k?=
 =?utf-8?B?dDB6a0cwUS9GRC9uQ0NwWWtoY0FhQXNWSWhXMFVXNUsrYkx1ekd1V3ZXeDFy?=
 =?utf-8?B?azlXU1JxSkF3bXp2dmJJcVRoeDU0eU90T0Z5YWlFM3FlRVdLTEhhQ01hRnlS?=
 =?utf-8?Q?ARScGsgs7YVApfJR8m3Q7fB+cJdt069z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WktTZitjMVZzanhkeEIyS2hOdWJiYzgzb09ibUI0ZkpTZDlFdnBWWUZ5aEtW?=
 =?utf-8?B?eUFmMXhuY094aHJlblRVeWRTUE8yQUtxZG9IdHdpY3lxQXZGYmpucG9aY0Z6?=
 =?utf-8?B?Witna0czdXVGeDZjelZlaWxxaWxwNTRVV3BmMENmRVNSUHB6U3Z1NU45c0pq?=
 =?utf-8?B?OHc2NUZPY0VNNGJNcFh5VU5jODFhaVd4L2M3dWU3SU9QY3RxMTB2Ymx4QVk0?=
 =?utf-8?B?UmFCdFc0RURVMmxXOVdOc2UvL2tZYzlCYVl1eUhTUUFUeSs1V0ZwZnFvWjdl?=
 =?utf-8?B?Yy9VWDB1d3BNL3hnazAvekhDUGd0RWw2SmFNVjUwaE9SNTNBc2hmZE5ERHRm?=
 =?utf-8?B?QzFDSzA0MkFUZlFneW5mRFFUZU5JNnVJek9WUkk4cGhiZ3Y0emNiaXI2aWRI?=
 =?utf-8?B?MVFobW5kVmlGb1c3djRuNTIwRHEydUJMRXlHSDhGWlJMVGpJWlBRS1VvNlJa?=
 =?utf-8?B?SW5UVzVGc3JQTXVWU1RYUnhIMC9jeitnU085Wm05Y3U0SUlNT1FDYVhZWDNa?=
 =?utf-8?B?L3VsNVBPZTZISWpvV3RHaDhCamlXVW9qTkF3SHQ2Nnk1Qk1FOVdNaXBYMy9D?=
 =?utf-8?B?YXl4RXkrSTc1VldxSnNJSUNIcDVLVXhYR3F1NTl3RHhlVDNQU0l4SENscU9X?=
 =?utf-8?B?bGkrNmdoejRJQ2sxbGhDcGE5bzNnRHFRSmQ3V0x0dzhkVkh2V3daLzFlVTJw?=
 =?utf-8?B?b3ZhWWtEd1dZbXhFQ0htRFp0Y2krN1lsejRuQ2pKUm11elM3aExvd3puc1Zu?=
 =?utf-8?B?dzR1Sy9lNU54bUJPTWNESFZFdU13RWg5aUIwcGEvVkYwWktnN255KzREdC80?=
 =?utf-8?B?bUxwdzJuT1A0ZWFTd0N0VWU4M1VCSmZmUUU1KytFYk41SXVNdTV4dXJITllY?=
 =?utf-8?B?S1E3amk1aWNrMXFRdTJnOFJISW9xSjZvSGZGcUxESHZnVktjYVI5QVJrcW5l?=
 =?utf-8?B?RFd1ZGduMWJFc0huOXlVWG9uc2V6U3dlN0E0YStPd1l2QjZPUUZBcTRHOHpz?=
 =?utf-8?B?ZHBEZ2ErQmVHS3N3b1BNT2Y3TFUxREVxQ3VxaUFEMWFhQzFpVVkwZnpVUnRJ?=
 =?utf-8?B?eStlaG5UOU9odkFWZnF1MHZnQjJNUXVBMVY2NHBlMkNpV1dDZVVvcmIxVFlH?=
 =?utf-8?B?NHNta0ZGaWVwMmlOc3g0ZEcvUXhWYUNnMnFRWThNRFVxcW5OQ3FwU1dlWEpY?=
 =?utf-8?B?M0MrUlQ5dGNUeDI3NklxemczNnJCakhqTDNlNHFPc2dKd1FncEY5dDZNdG5L?=
 =?utf-8?B?VEVMd1pSR3o5RDRLRWlxTzFXR2NUU0gxZCtkR0Zjd0ZQZW9tMnU0bTJWb2pZ?=
 =?utf-8?B?V1lreXFlOHdWTUNuS212YURuT2dxWGZtZlhjc1g0b1ZhNVFvb2ROWXNnMk94?=
 =?utf-8?B?V3YxbDRCSHQxK0hOMCtpZVdZMUZFWUcvdElOSGtaelZqQmZYK1JrQzY2K3dl?=
 =?utf-8?B?SDVaMTVxdVlzZlVHVVdScHR2QVY1bHp1Lys4dlFVNHRsTytwWThvSTNCcnZm?=
 =?utf-8?B?RVBWVnBaTWh4Ylg2YnNKWm5TbmJqOHE3L1FERkhVRWwyTlRVV2EyaURGYm5C?=
 =?utf-8?B?Ni9pcUNQZXFXM2laeHVMc1lxYStSSnlCWFRuaVA5azhNSEhoWFNRYTFGbG1Z?=
 =?utf-8?B?dTZRQWFYNWFYdnNsM3ZBOEFHbXN5OFhSUStiNnUraWlLMTAwSXIybmhOOW1L?=
 =?utf-8?B?cVNRam5hN2tOUWc0NVpkUXcwWTlmYzBlV2NEUnRHUFRrM2xXUTlrcHQ2WTE2?=
 =?utf-8?B?M3RsVzF3bEE1d3JEWUZMeWRuaFRMS1RCdEhpMi9nUjA5d3lyZ25wMEV2VUVx?=
 =?utf-8?B?Yk4wbDRZd2xpSThGcEVKbHJ4NUxvMWY3dURuREU3SS9xMFlvcFk4Z29WT0xy?=
 =?utf-8?B?MXdteExxaEN6a2RCTlhjRlJoeDhXcjhWbjlLT0xhRGFLejkwUUxqemd3bUJY?=
 =?utf-8?B?aWVvbkNGMjM2MmtqcGt3WmFLQ01JdVk3dnJWaFpQWWp3OVNVM0pLTWp6TUF5?=
 =?utf-8?B?ZE9QTEUraEJyeGM5amxNUytQZ1UzKzdBZlRaWWdTL25sekNWS3VRcnZ3cnZV?=
 =?utf-8?B?b2VSV1lEMXBOMi9NZ2pQS3hDZWt3TWU4eGhhZjJkS0JTT2VPb01vL2tFMUJr?=
 =?utf-8?Q?SMG4LYmYyHWeqtcui8+7ydxxf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671e6b1c-4d9d-4053-66ec-08de2728f5ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 05:03:20.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWAF+vpXcwE6VVmFfZlFhMLqQO/wiSiYvkpKPJRF64TTFKRBLkuCvvka/gak4cAsiplyTfISoucAjDjMFYPqzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673



On 11/17/25 09:00, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Reading a monitor involves configuring what you want to monitor, and
> reading the value. Components made up of multiple MSC may need values
> from each MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
> 
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
> not ready, then wait the full timeout value before trying again.
> 
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Cc: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

