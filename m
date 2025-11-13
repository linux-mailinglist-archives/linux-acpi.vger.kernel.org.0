Return-Path: <linux-acpi+bounces-18851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E9C55965
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 04:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DC073459B6
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 03:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED982877DC;
	Thu, 13 Nov 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lk0FCw/Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C217E0E4;
	Thu, 13 Nov 2025 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005849; cv=fail; b=Hm3gX9NzyaezdUOAXfnRToFt4xQXfKOaZyMeVf7bA8er+ikZMG+C/hERhpPMYraAqr2ZideQ3V20ovtErGvg59QXnJHi23Y/6/TcZMVLG2hIsI27kEVvSaN1ny2dXPiMetB6XMJ1iD8pwwyT2XY0V8mHvSpc8g87U4MZUNq1gB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005849; c=relaxed/simple;
	bh=1HV4AFuw8uWyNWv/4DdV5JElGt9Ca4vnSTNI+nNtdJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CConFMOd+YoFBKWRp8TsahcFXBE2pTLjYcqYG0WzrLlmD09HNqxUfcvzVK4EzvmYsA+2OrTX+xV2IZScELuagStI9/UODBQ9YJYzo2cbszpauKtZxABU97l48naSMzRSB0JTzz4TeriQL+sEOhVR0ST8Lv0dXQbKkwC2zoVRRc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lk0FCw/Q; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoXutE4bxQebf59Kp8QMVk7EPlWxBTxbMG6fpyShI37jxkDVnQ1qMWZl/XoQDuVl1ZNLLm/BWGgArCaLy5Sq0fzGnhSIdvPv78h27H7QOv/KnLK7lNL8y4u6Gwk38n1r4L0b3s4+jYyfQMfnxhoKBOk3kESwcJIHu63f01H6fGABRQBPYRy99d2YiSQa67AOAMchdVy76ocYaKjR6YpipshmveIU8CSjPWja8Tk2AvDJ6T/giuk1Ux40ATrC+BQB5QsqfanI/7cAiU3xkD9YfynpSP9eEg2WUyJhoJKiYJrCCL6/k2TZjNzpigJhON+sI5T79ZOLhJsjKSeJ2DkVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdRnTu69i8PUr82EMIxGa0RgX1TMB4OIskH7AxmE4e8=;
 b=Jz8EXYuIHt+4ZvA9f+mT0XaHgZeiX9lTA7QsmutAa5XuWvYnfMYmONoXSNYjPfeeowRIQm4HSqDX5AKzemkuZUqhUsNM3cl/r/SF4AEVTz/K9rkam8vLu5chj2HJNI4fcDLa4F+QLvZdB3AhUnj0jMbt8FnifUtI+GRkZRx3za9+F3/NmHvffF+1FcoCEm+BknAJZ7IVTQSvvPfEgHX+kmhKw+g0gNIiu+v0N16WkZKPX7fy2wYOr3qE3ZUecZb8PWLsNPb/HgLZD72lz/W/kZFThTPdUWFKd5YHYV1fz4csF4Ud3Rj/z2/xq1o3UGynBjunWiCA+iV3Khx/6etbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdRnTu69i8PUr82EMIxGa0RgX1TMB4OIskH7AxmE4e8=;
 b=Lk0FCw/QNaBXBqKkZ+pXHlAcZkOoxoE4zaDDQVdMSrNCuPp7RUp0oUZ1CkGAbIxw+OePUQFYKX0pLlY5HsJbemu99WBCt18uA/0SmJzubzNajTyWklPFpMGP0HLim04HrKAZACq9ONMtw0REOhQDvh251zo6MOURciouymrBmHX4Me0QvQrn8QxqI+caq1k/ugSja4VsTbfzFDGyNRUXv0BTYPrcGQvi7phNbXvRpzalGFkNjuWJvjOARj/a+q/CMTHdjDvAeQuQZ0Jv8Pp1DgOw7D3RC8fdcHM7onr2cT/2+9x6cgJBQThCWWGXBRgFXMGPAzYbt7W/KweKSBoTxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 03:50:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 03:50:44 +0000
Message-ID: <90c483a2-a7e0-4c87-a3da-8643bec63879@nvidia.com>
Date: Wed, 12 Nov 2025 19:50:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
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
 <20251107123450.664001-15-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-15-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fc967e-6616-4f02-d637-08de2267d23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enAxVnFGU2dlVk5VQXpnK3hXdytFS0RjOGRtUlZWbklqZjJWZHpCZXppUWNE?=
 =?utf-8?B?TUlqQmRnb3dNOVJLMDhzUUVQZ3dJdUV5cnNaWHBIQWxZL3NJZ3ZUZ0ErTm56?=
 =?utf-8?B?ekF6OFNkZjF2a21qa05Yc2NlcWNuMzg0VXpwWndxRS9qb255NStsVmpOU0dU?=
 =?utf-8?B?ZklHTmt1YXNmSUZ4NGhTZkx0eU9tUEZ5SzJKN3pmMnlPY0xRdlZvSVVLV05G?=
 =?utf-8?B?Vyt1QUp4RXMyb1NXUUFrb3pkaTVFUlBVbkwwdWtNUUhjT21FYUFNNFRWR2l0?=
 =?utf-8?B?clZEWTdZZ0d3dWM3S2dFY0xvaGEyNTlRV2dLQkFlTTloQUUrYVpDd1g3aUZR?=
 =?utf-8?B?LzRydTVueW42UVlBR0dld2g5Y1JEd2ZyUWU3VkFxWW44RmVCbEZtSGFla3M0?=
 =?utf-8?B?MkRWL2xMRnRvQjBibjdVdnNWVG1MamN6RnlkVlFwaWdFcHprTERxMzlJckVO?=
 =?utf-8?B?N3o0aGlqUm1Cbzh3bCtHczBMMS9YVEx5N3Z3QWJrVDNMMmZJZ0dqUm52U1E3?=
 =?utf-8?B?MDNvVUtDaUcvVVFqanVXdzhzcnYrTUxvUnU5MG4yblJEVUxoR01UeDVmTmdP?=
 =?utf-8?B?TDhPc0xGVlNLOFZpQkpjdndRNGVqSDVDNk1CTlhlVkk4K3hTalVyc25OMDlM?=
 =?utf-8?B?OTV3MThYZDNNWU9lMGJDSmRpVUs2WW1DODBmTUlHcndYYmRVcnFtd0wyaGNr?=
 =?utf-8?B?RFk0LzNDTkViMVdjMjIrcDBIbW1XemdxcTI3djh4dGtkYTdjRGpxNUExMEcx?=
 =?utf-8?B?WGVsem9Lc0JmcHNGSGNUZkpyVFF6T3BHUmVRK215Ky9rWmxHb21IdFJDd0JZ?=
 =?utf-8?B?a1k2RklSb05mY3YwRHBSRHJYUi85NzRIbUhqTTdMVlRPNm5hQ2tFL3lqRFNz?=
 =?utf-8?B?TlJtZFlaWmlJeVpVY0ZyS3RCZDJ3TDdxdlorVmdZUDRBQlVIY0lDdzVoTUVE?=
 =?utf-8?B?eWNPTVZid3B1MzR4V1Mvak96eE82RFJJZU9ROXgwZWsrRVkrSkVTYXRva0dx?=
 =?utf-8?B?OXBaNi9zdDB3Y2dRNnZkeDJMWjJ2bDZTVFg5OTA4Tnh5ZkZEaDh3MUFaSytK?=
 =?utf-8?B?L1hYUmpXMVRoa0NtU3N5SE9LbHJDQ3hVWHhLeitqS2wzTnVTajhLcm0vRVBR?=
 =?utf-8?B?bzZYc1FhYWkzM0tOTjVJY0RBWUQ4VWtHc1dNT2hnbmZYay83VXR2WGFCUGhZ?=
 =?utf-8?B?SGIySjZ3MjNoQnBmM3crZU05L1FwekRqaVhjQWN4WEEyYmtQTW9SRldmMG9x?=
 =?utf-8?B?MUp3RzJWMnJaMllLM2lZdTV0cWtmR04wbStNUmxWZ2psSUlaRFEwTXhGY2pE?=
 =?utf-8?B?MHhXSWdUUXBRSjUrb2dpWkIzZXBKbUdWTjVVeEZZdG5mVWVtOGtjUE5MaVJE?=
 =?utf-8?B?WnFwMk5BajZoRHBEUDFTNWNyV3lQR1lFNkQ2bjJpOXEwd0JiZmNTNDg0cVlK?=
 =?utf-8?B?Y2pxK2o5cG5sU1BXQmNIbnMrRkg1WUpaR2RiZmVTeWthNG9RSmNiWGVGSmRr?=
 =?utf-8?B?bSt0RE9mNS9VbXdYVWVORFZwY3BscGtjMk9ad2dIclFvYnJsclZkem5YVkx0?=
 =?utf-8?B?emlYVlJoaXd0SnFhd0V5NW8yY0ZXWDcwSnpwSGxwcHhONUh5MGlSRWY3ZDNB?=
 =?utf-8?B?STlwNWoveHdrUVNQL3hzSFJLbCtLK3h2U1pFVm9UU25xS3hXTXJsS0F6K2M5?=
 =?utf-8?B?cE1melNQMjZGVWtXdDhXY1lMV2J0MFVrajRsVFZCbVVrMnlmNDc2UnlqOFhS?=
 =?utf-8?B?TksvUVdOandpdllDajVEWkdFQU4wb0lXRXE4eWk4MFV2eVNEcERDZ2hxK0lM?=
 =?utf-8?B?U1EyWkhvQ1ZnTENZbFhhbzRGOHF1TjFMek1zdGNpRW5pdlRPKytVeUJUaFc3?=
 =?utf-8?B?dWFTd3RqUEp1S3g4ZjA3dEZkUVVVK1ZQYm5peUgrZHJEamN4YmJxYU5qSHRG?=
 =?utf-8?Q?AnnFWiq99Q7PuEp22Z/HB1Vl0iobuztA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlFOTHdudkU1QkxHMk12S2NpZDdKY1FRc2JXNksxYkdNUG8vT3YwT08xTFp1?=
 =?utf-8?B?d3NBQ242MlhrSFVpZHdIellZNjVnU3ZSc3BMS0taci9pRkwzSWsyaHZZTWlF?=
 =?utf-8?B?b2svQkVvRENSWHBnK1FhbUVDVFZJajdGNmhyZE1wRVdVTWpYWjIvUURkUXBq?=
 =?utf-8?B?WjdrU3RqbGlNVjBaRlVpY2YvUUpYekU5OFlEb25RS256dHR5RVh0ZkttOXhG?=
 =?utf-8?B?R2RUdDQzUFRyQWpSSjBUeWI0dlM3MjV3ZGRRRitwL0doSGJ3Y2hla1JZdHpv?=
 =?utf-8?B?Z0VMOXNXOFRna1pqanRKb0NkbnNTcUk3ejdhazdjcHF5bURMc096NlB4ak43?=
 =?utf-8?B?dmlqbkJ6MGtQZU80cVlkcXo5QmVNNGROT0Q1cEU2VTROMHpqUktOcTd6c1lk?=
 =?utf-8?B?cG9xQ0Q4dW0vSzQ4TU1uUkN1MGhaTW9zeUQwMVZXbEkvNlhRNUZ4UExxRGQ0?=
 =?utf-8?B?cDVlZlFPQ2RWaW5La0hqOTVuZTIvL3ZBY0tlY1BodGJYY2JEa0YxV1RnZVRw?=
 =?utf-8?B?QU1WOFRtVXQxcGI5RTNIQ3oyd0pEWkRPY2V5MytGbzlCNXdySmdVYjJ0SjNO?=
 =?utf-8?B?Tm9nQm1DbWtSbnJKUmxQSFlqcklzNGRIWG9WWHJVckk2clkyMkZUY1FUeVY5?=
 =?utf-8?B?TEhpQ3lWYnVFRFhvcmJ2Ylh5dzhkZUpodmJyc0tqdVNLM0JxMkdRY3lFaGtz?=
 =?utf-8?B?VTBFN0djVCtlMVNQWTVhNTRYOVhrdS9NbE9rN2o3RzZkaEk3VHVRL3pMb2dY?=
 =?utf-8?B?elRqM1MvOXRoVGZwbmVOblE4cXdQRExJS0RQRm9FVDl5UnowK0pGV3M1Zmx0?=
 =?utf-8?B?YTBYeVRmRnFpVnRyUjhCczZMM1cvb2tXeWFYajNvQTB1RGhsbnFEaU1OTWJP?=
 =?utf-8?B?UEFaM3FFbGViVmxoNzlEUE1lK3FUbGVoMWovR0UwQTAxT1ByUTFVNXNOOVZ6?=
 =?utf-8?B?VHBOVllGbDVsdzJ6elJPZmNzbklmQy83b1dZK2U1U0lKMTBOaVRPVzI3T1Bm?=
 =?utf-8?B?SXBHR21NbEhROVNKMlBQcE1wVHlTSzNXeXhsR3A3UEw2SjdreTc2TU4wREE3?=
 =?utf-8?B?MkVQd1N0SVJNYWFPZTM3bllTVmdtRmU4UWtlTVJRbGVFZUJyRXFqd0ZreTZi?=
 =?utf-8?B?NzU3VnB0T2hacmVWL3R1ejZlZGg4d2ppNjdwdGhIVi9EQkpPNUtZY3hzU2ZL?=
 =?utf-8?B?Tlh2cWVuRzhMZDIvajk4WUFGYkkzd1UvdWhFQ0oyRzE3MzBEa0o0Ynhtemht?=
 =?utf-8?B?eWlnWjQ4WW1GdXZ0WU03eDM5RTVNODdhelBoMjBvRFBhNnpDVy9hb3BQYUFy?=
 =?utf-8?B?eEVKcDBsekhHYXJSMW5QZkorbWo4ZGlnc3hXN0JnVDB5MElxRFJTLzZqTGhV?=
 =?utf-8?B?UjhrcHppaTlNOG1WeDBHWURWNHJyNEJBR0lIMTZtOWxIRnFDcFo0My80dWxp?=
 =?utf-8?B?ZnJpQmhnUGpPdWgxYU9mTUUxN2crMHhoNGRaMldtV2tVQm5mMHRaV3hzNnA1?=
 =?utf-8?B?NnJhbWpxenY2YUFkMnRXUFhLOTkyYXZzZGhsWGRNNG9PTVNEOUhZajZmakRI?=
 =?utf-8?B?Q3RnRmUydVJkV1plZUVtSWlZZ2Z3dE45T0tzNHlMZWU2NFlnME9kVnRTQUQ1?=
 =?utf-8?B?U2VXQjJaSHdTekZMSWZhQnJGL3VYWVU0c1dGWmN3N0krRGRLaDUycE52eXVT?=
 =?utf-8?B?aVREUzhEa25XbDFIaVZJMlNNYXVDWTNCc0FvNzNhZjJxdU52QTY5YnBFaGc4?=
 =?utf-8?B?RkxMa05XUUtSZEdrTlhkcXc0MERqNExsbkhROHRjKzlCa3NzOHlBb250Yk0y?=
 =?utf-8?B?bDBLWXJwUEdkbjJoOTdVYTZZVDRmN2Z3bXlqMExTdE5CTXlKdjRwOTM0aHFy?=
 =?utf-8?B?TXdkbWZHL0xhY25TRFZJb0F2VmdCY205NVZiRVdEQzJhMGlXQ0pybS9OYlNO?=
 =?utf-8?B?dHBqTDJaN1lSMy9LOWRIczZPaXU0UFo0UTlvWDcyUEhIWnpQQXJsZG56eFBP?=
 =?utf-8?B?Y1NlM1c0U2h4SXgrSHdETXhEMmUvMXNvU3JkU0xaeGczMUNkOWVJSmhvMTVn?=
 =?utf-8?B?bWNPY1VSVWZrSnJJVzlrU1dBazdXeTRZWmc2V2NoOHJCcGdaQ0RVbzVxY0Nu?=
 =?utf-8?Q?rqIycst6Mw+tiURhh61tUNND3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc967e-6616-4f02-d637-08de2267d23b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 03:50:43.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sMBdWCm4j3+bQ5HEmiAnW1ajKNtJ15lu2duqHOP6ZIjG1Ib1WHyV0P89GSgmMLuDtuaj6LM1tw6qmr/y22FGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

Hi, Ben and James,

On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
[SNIP]

> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
> +						   u8 ris_idx)
> +{
> +	int err;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (!test_bit(ris_idx, &msc->ris_idxs)) {
> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
> +					     0, 0);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	list_for_each_entry(ris, &msc->ris, msc_list) {
> +		if (ris->ris_idx == ris_idx)
> +			return ris;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +
>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   {
>   	u64 idr;
> +	u16 partid_max;
> +	u8 ris_idx, pmg_max;
> +	struct mpam_msc_ris *ris;
>   	struct device *dev = &msc->pdev->dev;
>   
>   	lockdep_assert_held(&msc->probe_lock);
> @@ -464,6 +564,40 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		return -EIO;
>   	}
>   
> +	/* Grab an IDR value to find out how many RIS there are */
> +	mutex_lock(&msc->part_sel_lock);
> +	idr = mpam_msc_read_idr(msc);
> +	mutex_unlock(&msc->part_sel_lock);
> +
> +	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
> +
> +	/* Use these values so partid/pmg always starts with a valid value */
> +	msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
> +	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
> +
> +	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
> +		mutex_lock(&msc->part_sel_lock);
> +		__mpam_part_sel(ris_idx, 0, msc);
> +		idr = mpam_msc_read_idr(msc);
> +		mutex_unlock(&msc->part_sel_lock);
> +
> +		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
> +		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
> +		msc->partid_max = min(msc->partid_max, partid_max);
> +		msc->pmg_max = min(msc->pmg_max, pmg_max);
> +
> +		mutex_lock(&mpam_list_lock);
> +		ris = mpam_get_or_create_ris(msc, ris_idx);
> +		mutex_unlock(&mpam_list_lock);
> +		if (IS_ERR(ris))
> +			return PTR_ERR(ris);

It's better to destroy ris's that were previously created before this 
failed ris? Otherwise, there is a memory leak for those allocated ris's?

Thanks.

-Fenghua

