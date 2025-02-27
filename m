Return-Path: <linux-acpi+bounces-11567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700EA4868D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484BB16A86C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A441DD0D6;
	Thu, 27 Feb 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxW8VlOR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9E1A841B;
	Thu, 27 Feb 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677045; cv=fail; b=P7ETQIPxJDNkvpBPCHZtLB5FCKuX2ftlqOO2gLA8jW43O+KrYl2CfvmIALRvb72DJ4BqFzm8i9wUTi9uWqwUHR9KKKvexmZlf5oTRsjo+6LnUQ0Mx5Okhxfva/wf8ps/GAaSwqoy0H3Yxs2Q516sQWkw58RdtTmtzbF79VK9QNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677045; c=relaxed/simple;
	bh=XWK39sA29K13W+mW98C8Jm9QDLwr9USxRwEG+urduJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XAFj23xU8BepFw+k0Yv9znEhxAC7nNGPs89w5+fqzQDzgbr8VpH9UcDq1JY0i8k/Npsay6Qxt+YD6xIZ+lvt4Ck4BKeuqVK88BDdpsTvj4XTPNiVMvQVdPpreZwWXdnNcF6cMrhpkX3hGvCHiJ4zeKwg8YX3IlrYIPK3ZQvfbFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxW8VlOR; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYld4JJHZYgaWqj+9v5tdwOH3hvB2HEG32APHHmO9pGijSusfZwe9jyrCm/5Fyu3+AcqoA/2EpdZhVnRTWAgjpuMxipzSvLUlLdg16zv4Sf1UVUJCKE1BtTbjty2LsxioLnYWLzapvx82UTtNsOksgRKOxNeVntbJEzggyy3ZmpBs7ts2cR4Ahzavtsjg/HEKQ0BJoo9N6vsn/E+GD5LMQDv4UIdcNV5oK0gWkWzxL4YOKvmswbms9mZ3FIDER7eosqLWBnZ/FIZjDg46j17DGbrCVXo+zBM2LbcDWz/+lnE9XPwY7bcjACZ3s5xQ0+rAVlQEzd2PTnvb5tIEAvQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evqV+yKqaPhO6fwP7QLZL08u+u9xrGj0VSWPdOyxrlA=;
 b=w6Fvwb5Uie59PnFdCwBsdDjzFlIV3uLLr8mPISp3GunYd6yEuTW/SiV+RISAOiOwJgFZ7pOZpL9ADj0SlfyIb1x+18SvyKVyoa0fXsBhE6YIymQaOUqNsu1v6zYmn+nxxM+KZw5nlD3I0OdfkjoQ8uf4UWUoUbeMsKNXgYSKsW+oerpL4Gq3vEc9x37OJgRgrY5YRAmEsYGRFHS8kmLdBqaq40LKI+mk0L6/u32ArMkuAa3bKvZ/xwGVp+v7Fm1GcW0VUSuwpVMibakRV4KpNooYsphwRdbKWMeWMp3rRWl4+Pa7BE3RFgaTm42Bp/qm7X/hcUQCt5GeDSgsXtjTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evqV+yKqaPhO6fwP7QLZL08u+u9xrGj0VSWPdOyxrlA=;
 b=RxW8VlORI4xMtIH90eY/qLxSKlwKsopG+nU0wGdE17RQuKsdIJ8wbNL8+Ah34fz5VWTaexzakjz4QVCxJ8qgNsVpiQH5PSxW0uWt9f15FgurkL73hp0mFQJqNblD+bJQbKpKL7QO61dDTkGuBPzaCJFWOBQQiRlHI/oLCY4t1bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 17:24:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 17:24:01 +0000
Message-ID: <1722456c-1c1d-4213-a7dd-926a650fd0c6@amd.com>
Date: Thu, 27 Feb 2025 11:23:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
 me@kylegospodneti.ch, luke@ljones.dev
References: <20250227153603.131046-1-lkml@antheas.dev>
 <20250227153603.131046-3-lkml@antheas.dev>
 <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
 <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
 <1ba0c88f-e0dc-4b9b-9ea2-47a6295910ce@amd.com>
 <CAGwozwGNV0gccAH-TXCi4PCnuWFOA0v8KkiZJ8Z+fZ+_ft6UAA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwGNV0gccAH-TXCi4PCnuWFOA0v8KkiZJ8Z+fZ+_ft6UAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0095813f-d49b-4d89-7f93-08dd575386b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDBmeFR6dXQ1VG5XV25PT0x1aUt0UGZDZGVEdjBGMXR2UGMxdmNWaDNEd1Va?=
 =?utf-8?B?WWQ4MDRRSzhUUFN2WW1vazJTYldLVjlLN0FrY1R6SFdOTnpMNW1RampqdGZM?=
 =?utf-8?B?T1c1dERHQnFEU2tTV3dqeGQrNUJwb20zM1VXMVBuSUZzZnhSM1VwaWJHK1dJ?=
 =?utf-8?B?elRWWHppRkVIeG9nUGN6SE5CU1FzVnZhK0ZXVnlDNEVCMU1IZ2RFY2x2dzNr?=
 =?utf-8?B?ZVhQQnZXbEw4SGVSYTQ0aTYrMzFVQ1I4K2cwUU8wQXo2QWpnS05WZWU5TWZo?=
 =?utf-8?B?SXh6eWNUazJoem9KYlZ5MkQ5bUNBNEZSVjlqQ1lUaWNmME1XMytHTklKLzFp?=
 =?utf-8?B?cVJISWJmRGlYZDBNNlVUNTZuYUpYNWxXdU9YN1FPNUtkbGt1bS9jTlg4eVBx?=
 =?utf-8?B?MzhUUUhZbDRWdHpKZEtTdHBGNUJDWSt1Um9sdmYxR0YwUTZUb3ZCYi9CMU4w?=
 =?utf-8?B?MjdkemdCeTFlNXYvTGxVYWI4SXNDMk1JSWlQVzh1cldXUUpVdGVrZW5nanl5?=
 =?utf-8?B?TWozTEx3cHJSV2hZUEd2aGthVTJQSVJuSVZXRnplUytndkp5TW53bHlGbHBm?=
 =?utf-8?B?bFNLM2k0RGVrRlJ4NkNHaGZmWXptb1IvUzZHdzVJMHBDcklJb1ZSd3AzSTRR?=
 =?utf-8?B?bjN4ZjRzVE5aNlZoL3hIZXloMzR2L0oyaUk1QlBtSXVzSDJvK1A3MVZsa2l0?=
 =?utf-8?B?Z3hzc29CU1puSmVtU05yaDFabE8rSnovVGZJbEVhdjU0MnBCWTc3MkpXU2h0?=
 =?utf-8?B?a1IyQzFON1dkVkE0OU5mNUpPaVkyNjdqME5zemZTcjZhdWZoTGIwRmhuTTVk?=
 =?utf-8?B?ekVVWmZsL0NnZ3NKeU1pTy9kNVMvbzlPMkc2R1VmNVd0dVBoOWlxU0Nic0Qz?=
 =?utf-8?B?UG80MndzUFB2M0hJbTRzU09UazhvbCthL0FoeE5SV3lUbkhiRVlFRThFVERp?=
 =?utf-8?B?MjcwM1FubnFENWt3V1dMSE04M29tY1ZkMzU2eUdsWCtXeXFuM0U2a05NMUg1?=
 =?utf-8?B?MWNqTURTNkQ1Z0picFB6aUV1UEwvRG5hbzJPL1JNVk9OVzFDWllHYzhjM0xa?=
 =?utf-8?B?b2xqTlRvblhRZ2FNeGlQWjBPb0w3bWhGWUpvK0RpVEFJNHNoM0pjcm4wUjEy?=
 =?utf-8?B?ZVFlczRvalcyMk81NVVYbWxzNnVaU0VPZ2xoZkM0NWZ6czRKTEZYR2RSK3M0?=
 =?utf-8?B?YjMyVG5LWDR6VkY1QjJFbWRGdjBCanMxV2tvSWR4R3JybzNJUW1ZY24rd3lE?=
 =?utf-8?B?bFpOaFlORGhLOFRKbFJ6NWFqUXJtTFlGNDgrczRwa3FXWHpZYTk0VmpWbEZE?=
 =?utf-8?B?ZytyUVc5aVB2L0dYR1czU3pEdmZjSmFLMHJpUGpzYStERFVXOUtURUJPNmNL?=
 =?utf-8?B?SjZ6cVNKR3pnS0xGTTM0T2llUGMvTWllb2RtZ1VoTDdpSy9zbWVoT0RWb01V?=
 =?utf-8?B?Qzk2VmY4R3Mzd013a1NJdUlrYlVmYUwvWDZtek9Jd3Bkc0hmWDM2aXlib2JZ?=
 =?utf-8?B?VkRiTVVNR2hZUFRWTVNUbEd4RU1xOFd4bWlrNVZJUDhFWE1ZNGZpbHBwVHRr?=
 =?utf-8?B?cHAvL3Vma0VsbWphcCtreVRXYVdxMHJIbDlkM3F4clc3ZThRSktnNU85WlpF?=
 =?utf-8?B?blhwY3BFeFVOeDZHQnR3MU8vbDNUdTZGOTJWU0lkZDhWT2FQcVFzTFRxbmxX?=
 =?utf-8?B?bUNlbnZYUEpHZ2xnMVZwS3FsYjFja2hHRzE0bUxVMFJwRjVHcnVEK2RyUU5W?=
 =?utf-8?B?NmI5OTBMRHFSZWtjbVFSUFNNRjNNK2xSZmtZTU01T29PcmpaL3B1M3dkVUFl?=
 =?utf-8?B?akVTNnNqTzhNaVhRNEJXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3NwT2k5dCtvbHdLSXc0WHZPWFo4c1hXOEdOQmhsSFNVZ21hWEF2OGtCSndo?=
 =?utf-8?B?NWRWVmFSTVdYTTMzVkxERm1wRW5xekxTSzRmTHc0a0swamZsYUt6OHlrWE9R?=
 =?utf-8?B?N0VmV252YnEzRURjdnpEcTBmYWgranp3RThyYWtRMzVVcEZqdUEyV0RlUEQr?=
 =?utf-8?B?WHFldkJvLzFQd1ZFQ3pRMnZBb29BTmtXdW1BUTFqZnNlUHRaUzlmV1ZEZ0ps?=
 =?utf-8?B?ODUxVUVOV3U1QnZ0eGJGb2Q5NVFvRDBTcFp5eVp5U0IvS3QwM2x0bXRNRmU2?=
 =?utf-8?B?cnRleFc1dkJyeHpjVG5jdVlqTHozbnd2UzlSZ3VmTFZ2aU9IUzZHS3BGbVho?=
 =?utf-8?B?WmtmMGptRC9NbGpXbWpPVlJNejFoWFAyR2x1ZVZ1NGNYY3VXU2J4cTNkVlB5?=
 =?utf-8?B?alhnSm5pNTBHRndHL1lzTnNnaE51eFUvSUQwRTJXaUl6MVp5R3hNbVhueXJX?=
 =?utf-8?B?bzV6Zi9nWEZBSGxCMk11OWZGc3hCZ0RYdVV1ZU5tYjZYc3V6UG5IZzIwTkFE?=
 =?utf-8?B?VFVlSmpyQk5sbTQwU0VQV2pSaW5OWmgyVmFrNzNwMExJQStDRDYwZ21pWDBj?=
 =?utf-8?B?MWlhbGtsRW1ZYzA2bkI1NnhZeGdMNnBMV2k0V3hIaFpzWW0vMkdSVXRRcFh0?=
 =?utf-8?B?blFwV2xQdVI5NGtiTFlXWVhWeUFKTDNmNmJGY2hvcURxOEhDQUp4bHBqMmhO?=
 =?utf-8?B?Q0pIYmxtUTJ6cGJVekwydjUvaGZyRGptSW42YVNDOWpEdi9CMm9kYzdjTkZk?=
 =?utf-8?B?UGxUT29HV1h6aTV3bUpkT1MxZ1JlOFRDY29tTzR6Z01XcHUzTXpEUk8vVnUy?=
 =?utf-8?B?M3ErYmlocm9PZkhpaEMrcVFJYUlDa0FwS01OTEdOcCsyZnF6b0NMLzkzUEkw?=
 =?utf-8?B?eW5vZmlNekZKVUgwd1VGdmorek15K1V6KzNWTkQzekV5bG1KQjJnWnFWMzJy?=
 =?utf-8?B?LzNRaWZDUEV0NW1IaGR0dVhsaVRQNUFmK2ZkNy9aMzI4b0llUHI3ZzNUMnFm?=
 =?utf-8?B?Y2lIc3cwQWR3QnY4ajhZWkJUL1lKQmZTZE1rbWRRQWVpbmxIay9QZlcwM2Va?=
 =?utf-8?B?RmtnaFRPeGU4Q0x5a2gzUzQreUJ5U1UxcW5UV0wrbzlQWStSQTEyZnFnQktm?=
 =?utf-8?B?ZkFKSWRweFBsbUdGd2xJNFFra0JjdDVSdFMwQXJtdEtiSWxMQXQzUStoL0hR?=
 =?utf-8?B?UFB2RzYveDJKN25qS3k4VDE3RnB5U1JIS2NmbDJOb2xTM3R4VGQ2eVBkYVor?=
 =?utf-8?B?dlRSTmIveXFLVGtTQ2tZbGE0MWI0bFF4QUwveTFXWE1MSGMwY1hvcTZCeFUr?=
 =?utf-8?B?bVFsUVk1bVQ1REpzTWRKZWZoMWFhendaQm9wdTNHYkVIWGhyV0U4TFhvQ1lz?=
 =?utf-8?B?b2cwM2JaKzNzRmxTblVQVVRXcnJYYUoySi9NVmdTTyt0VGV0ckM1TS9KY2tT?=
 =?utf-8?B?eTcvOVlTRUEzN0hCcmJBeWpFWXZkZFBicmJ1N0hPWHNpbTlTRUNwSWFqSUlv?=
 =?utf-8?B?WUJNVEUrbWs5K1FzVGZVRCs4Q3UyT2RDWHRURHI3UC9WNll3aWYzbFlwUkQw?=
 =?utf-8?B?VUFqT2IrSjRlNmE2Ylc2REhwT1RCMVVyVzVjNmZJR3k0K2EwU0NwYnZLaEZ1?=
 =?utf-8?B?Q21YRVBMV1dHTDZ3RjBDRUZkM3dEWDBmcTZYcHZESkpmVTNsZTlRV3NrNDhS?=
 =?utf-8?B?RjlZc2ZQU3pmQW12OTRzOWc2ck5DVjYrRmZzT2lNWHlTY1kxQWNIOGZob25y?=
 =?utf-8?B?U0JuWVU0R1pyWk9Rb0diZ1MvczFvYlg5dm5qUkVVZVpDUmRzTFZ4bzBNR1dW?=
 =?utf-8?B?cDVqN3Zjb1dQb0d0SDNPZFdqTWZ0azRTVURSMk5uKzdtekhlaFhjU3c0MjA2?=
 =?utf-8?B?ZjJXV1c4Y3NESjNucGZHdG90dnB2UG1SaHpEbE0vaVJMZ3JTb1I3VlBNNVo5?=
 =?utf-8?B?Um8yZDVMTTZ4dGI1UWZpVjdVVmphM0g5ZlRwTTJ3MHVsWDNHd004SGRnTTI4?=
 =?utf-8?B?T2NsRzM5SWFyZU5CdWxESXdOdmNDQjZ1OXcwNytVR1ZvUThjZWJrbUIzakxB?=
 =?utf-8?B?QmlPMjVtMnVMcWNKaDJXU3Y5SnB0T09GMzRxNmdEQS96M1dEcFcwYnJSODJs?=
 =?utf-8?Q?zvQRQDYEIp/qbTvixiDqoPAtS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0095813f-d49b-4d89-7f93-08dd575386b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:24:01.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loGkl1wll+HzzQpurrYuJ0Gfq6NRojwF8+zh0hrdUBPTvaRz7Z9Np2vrm4U466/HoU1dswF8eq++0kO+rcG7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

On 2/27/2025 11:18, Antheas Kapenekakis wrote:
> On Thu, 27 Feb 2025 at 18:10, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 2/27/2025 11:04, Antheas Kapenekakis wrote:
>>> On Thu, 27 Feb 2025 at 17:46, Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 2/27/2025 09:36, Antheas Kapenekakis wrote:
>>>>> Since amd-pmf is expected to run alongside other platform handlers, it
>>>>> should be able to accept all platform profiles. Therefore, mark it as
>>>>> secondary and in the case of a custom profile, make it NOOP without an
>>>>> error to allow primary handlers to receive a custom profile.
>>>>> The sysfs endpoint will still report custom, after all.
>>>>>
>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>> ---
>>>>>     drivers/platform/x86/amd/pmf/spc.c | 3 +++
>>>>>     drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
>>>>>     2 files changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
>>>>> index f34f3130c330..99c48378f943 100644
>>>>> --- a/drivers/platform/x86/amd/pmf/spc.c
>>>>> +++ b/drivers/platform/x86/amd/pmf/spc.c
>>>>> @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>>>>>
>>>>>         switch (dev->current_profile) {
>>>>>         case PLATFORM_PROFILE_PERFORMANCE:
>>>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>>>                 val = TA_BEST_PERFORMANCE;
>>>>>                 break;
>>>>>         case PLATFORM_PROFILE_BALANCED:
>>>>>                 val = TA_BETTER_PERFORMANCE;
>>>>>                 break;
>>>>>         case PLATFORM_PROFILE_LOW_POWER:
>>>>> +     case PLATFORM_PROFILE_COOL:
>>>>> +     case PLATFORM_PROFILE_QUIET:
>>>>>                 val = TA_BEST_BATTERY;
>>>>
>>>> I would really prefer we do the absolute bare minimum to help this issue
>>>> on ASUS (just special case quiet) and leave adding compat for other
>>>> profiles for other development.
>>>
>>> I cannot risk other drivers having their options disabled. This can
>>> have carry-on effects in other drivers too.
>>>
>>> Including in the legion v3 driver, in which you will end up disabling
>>> balanced-performance. Since Derek posted the v3 for that today.
>>>
>>
>> Sure - but let's handle that separately from this bug fix.  That driver
>> will be targeted to 6.15 or later.
>>
>> We need to be cognizant about what can go into 6.14 needs to be bug
>> fixes for drivers in tree.
> 
> For me to consider this problem resolved, I need a mitigation that
> matches the behavior of this patch series 1-1.
> 
> If you have a better suggestion, I can implement it and test it real quick.

I think just covering the QUIET == LOW_POWER is the important one for now.

> 
> If this issue is not fully resolved, it will cause a lot of downstream
> issues that will result in the legacy interface becoming unusable.
> 
> Acer and alienware implement balanced performance too. In the current tree.

But do Acer and Alienware have designs that amd-pmf will bind at the 
same time?

I'm not so sure.

> 
>>>> The reason for this is that if you look at power_modes_v2 there are
>>>> actually 4 'possible' modes for v2 platforms.  So there is a bit of
>>>> nuance involved and it's really not a 'bug fix' anymore by doing so much
>>>> at once.
>>>>
>>>>>                 break;
>>>>>         default:
>>>>> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
>>>>> index e6cf0b22dac3..a2a8511768ce 100644
>>>>> --- a/drivers/platform/x86/amd/pmf/sps.c
>>>>> +++ b/drivers/platform/x86/amd/pmf/sps.c
>>>>> @@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>>>>>
>>>>>         switch (pmf->current_profile) {
>>>>>         case PLATFORM_PROFILE_PERFORMANCE:
>>>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>>>                 mode = POWER_MODE_PERFORMANCE;
>>>>>                 break;
>>>>>         case PLATFORM_PROFILE_BALANCED:
>>>>>                 mode = POWER_MODE_BALANCED_POWER;
>>>>>                 break;
>>>>>         case PLATFORM_PROFILE_LOW_POWER:
>>>>> +     case PLATFORM_PROFILE_COOL:
>>>>> +     case PLATFORM_PROFILE_QUIET:
>>>>>                 mode = POWER_MODE_POWER_SAVER;
>>>>>                 break;
>>>>>         default:
>>>>> @@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
>>>>>         struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>>>>>         int ret = 0;
>>>>>
>>>>> +     /* If the profile is custom, bail without an error. */
>>>>> +     if (profile == PLATFORM_PROFILE_CUSTOM)
>>>>> +             return 0;
>>>>> +
>>>>
>>>> The legacy interface doesn't support writing custom.
>>>>
>>>> https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/acpi/platform_profile.c#L382
>>>>
>>>> IoW this is dead code.
>>>
>>> Noted.
>>>
>>>>>         pmf->current_profile = profile;
>>>>>
>>>>>         /* Notify EC about the slider position change */
>>>>> @@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
>>>>>         .probe = amd_pmf_profile_probe,
>>>>>         .profile_get = amd_pmf_profile_get,
>>>>>         .profile_set = amd_pmf_profile_set,
>>>>> +     .secondary = true,
>>>>
>>>> I really don't understand the need for declaring primary / secondary.
>>>> It really doesn't matter which driver can do it.  This same problem
>>>> could happen in any direction.
>>>
>>> No. amd-pmf is responsible here. That's why you made the multiple
>>> platform profile series after all. Other WMI drivers never load
>>> together. To maintain existing compatibility, those drivers need to
>>> still show the same options under the legacy endpoint.
>>
>> My point is mostly hypothetical right now because the realistic
>> combinations right now are amd-pmf + other driver.
>>
>>>
>>>> As a different suggestion; how about a new "generic" callback for
>>>> 'compatibility' profiles?
>>>>
>>>> Right now the .probe() callback amd_pmf_get_pprof_modes() will set bits
>>>> for visible profiles.
>>>>
>>>> How about an optional .compat_profiles() for the hidden one(s)?  This
>>>> would allow any driver to implement them.
>>>
>>> amd-pmf cannot obscure any settings of the primary platform, so even
>>> in this case it ends up implementing all of them, and compat profiles
>>> becomes equivalent to .secondary with more steps (incl. a probe).
>>>
>>>>>     };
>>>>>
>>>>>     int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>>>>
>>


