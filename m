Return-Path: <linux-acpi+bounces-9900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A99E2D08
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF1282615
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88A205E07;
	Tue,  3 Dec 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JEi58Gi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E71205AA0;
	Tue,  3 Dec 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257676; cv=fail; b=LZWU9f1DOHEbDk6DmTFjs1ARLaZkT5PNcW9zV4OgEKGlYEKqQ9OF1uAUdzZbGjubpfzHmc7+0DBXrjxn4L9oRR11HNaITmovS7bRODldLgK1H3KzVz9tOGV1QKOz9EcANytF0Y/kkYKX2VYcrPNXplN38BwPVFZWkNdPV9QN6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257676; c=relaxed/simple;
	bh=T+LGpUoWHXjt3u0V5Pg3DjKZW8OJ+ISnJK2WkMW3B88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E7x1w27ji5KzXKSS9uFscndLtXDhj9D3mtFQymQEa/q3R8SXHOWx21RcEEz0L4mLip67NBRHStNkyAa9VfGPeX5Rr+KWWnqgdT8PGaJwovB9AY4dzqSnufvLbjaFTbwYGBg0o+/VRctCiyLzdF57wYI2K70RBSozg9rNtgT3dFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JEi58Gi; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYpzHHQQHKTjKBwFQu9GbodPKPdqjqWjI1hfU5jvSp2Fkar80npy1tRQVnFY2M2CAiFUhRIHxvbfoxTCyyvr5iQTEniiDtgk0HT3P6v5o4//rTfMBCLnLxoWe2G6lzNkuEWrNfqvFvnY/4ZCOx2KXwgOI9cikev/gZjY6fzImrfqCM/8JbWWgVD7YGj7PwiyiSbRscesllfVE1od1ktVEj0X4wBFAmFbKatibdejDcD8DvhkMn2uxiyD+EdrNvZXxMssaYoy5N0kw9h9lX8ZtA0LrW1ckIfz+p7NTXJgaEm+ix3HH7hWcLSHlsS9BG6CVXTrSbgEvOdX+JHVkxrtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkF9MCFihEM2Y7q2LB2FTx0+Yyr7FjUuAA8DO9BfjxI=;
 b=fUO8E+ZfPY5vfgeVwWDY8Cg6xTsEvdTY5VUpa9HenL0scwMZX8xQu9zc8QSH67e3U+ud8h7qN/nFOojfaqTJ9bYin7jHG0lO+q838dpgaqbs3eARFYpA6ocRdfdQ/t3sjYqLCgjt+WHk7ZX2amc/5SAzXS5DuOqaJsfaLpIyK2l3QSFv2BiojvqWoFgGO2oevxzJunZy4nxzrkcC1cHNGGpegPVoiiu7vy05F+/OtBZxG5Cjed1FVdBU/XoA1O2lVy03LP/OC8sD64u5mhXBJNnPfZ9kEvO3oIT3srXLkF2+x2vpPVzLhkMz7pcWSzyKgt81KcwgEyAhby6+vVmxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkF9MCFihEM2Y7q2LB2FTx0+Yyr7FjUuAA8DO9BfjxI=;
 b=2JEi58Gi8dKaYdrQf/mETKcvkIoqP+2h5Nei0D2i6A8z6umW78lziDP9t5eHPNbghteu912b7d1KEr66YU+HRwGaYWyv8Yla4I+YMqA6UgjsTuBG6HMwwaI65lmRe9bxu3gJ05MuSgQwoNTr4wiWxQFXc3luOEEXOKrLVzEp5bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:27:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:27:50 +0000
Message-ID: <8517db8d-c755-4fa0-8d8e-fd477060d033@amd.com>
Date: Tue, 3 Dec 2024 14:27:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
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
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-5-mario.limonciello@amd.com>
 <20241202113512.GA8562@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241202113512.GA8562@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1b9b44-971d-4f19-7bee-08dd13d8f538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdZdjhhUUk0YXIrVGttNHZWdUtLV3VmSzVBMERHL3VLM2NiNkhycU4rbHZz?=
 =?utf-8?B?cFFFT1k0VWM1NUM3dC9qQ1JRSFFyMFdEQ1dmTXpnTkZFaFVhaVFvRGVxelVQ?=
 =?utf-8?B?ODBNNjBIWDBqaGZ4aERaai8vZzlLTEFvY01UK0d1WkNKMzlxcitKR2JJRVhH?=
 =?utf-8?B?QStidW9DL0NjUW1qbDRUaHFpbVZOMUdDbmFMSFBrK0lwNXluYWhSNjRUYUcw?=
 =?utf-8?B?M0NvL3RIdzdzYkxvenVVc29DQit6b3pIUXZIcnk5eXJuQ0RRVzRpVGlCZHRm?=
 =?utf-8?B?cHJTOWNsdHVtUDRpYWwxUCtReERoTVVaODBlNWowSENpeHhRRmY0N2ZXQjY2?=
 =?utf-8?B?MnRXbUlNSHY3bzhXSXBYdzJCTXZVYjUzSlkrdlhWdE80UTRJU3k5bEtZRHVk?=
 =?utf-8?B?cytuMmFwWnhmUTJHWFU2a1lxVlNucDhEcWNDYlpyK0lxSlF4RUFnOHhaN201?=
 =?utf-8?B?Kzl3NVB5MFFydnVDMjM3SXc0MHFjNFA4czU0RWVaT01zbFBpMzBKRzVjS0Fn?=
 =?utf-8?B?UE5kbzU3RzQxU1p2QU0zQWNrVjQwczRVd2dzV3pXRE5aWVhTck0yTlJFMzlK?=
 =?utf-8?B?eXZnbnNMYzQ2RU84aGU5a2hkN245aThldUZVOENsOFFLY3BOT1hrRitYYk12?=
 =?utf-8?B?SDk4ODVZc1RoZW90dHAvOTAvWmRTcHpyRVF1NUFNYS9KdnpZS1NYdUtMVzdJ?=
 =?utf-8?B?RkhUclFsWUVPWEJSQVJzZk9lR2hNYWp2dXZzZ0oyeVB5YmZ5ZDJPVXc0YWU5?=
 =?utf-8?B?akNQd3NvNnA3cXViMS9wYWtkN0ZWUURRTnAwbXRlalRUTFFOd3BWeUl5cGQz?=
 =?utf-8?B?WFd5ZFZCb3hDbzE1emN5eGRiRVVZTjhPOWgzZWZVSmtQanVHTFJsK3RhM3BN?=
 =?utf-8?B?dWdvRm1rS1drWWRDWFR1bVBIQytielhCL0xCSDlicmMvZTNZb3cyUUVtQWlI?=
 =?utf-8?B?N1VpQmZIaFphWWtadlFnQ0tBYTBTVDZDOWE0WVdBUTNSNk12ZlVwcnduajVJ?=
 =?utf-8?B?bUlrRC9MSnpQbkJvc1NSdHZNWmxncnE2ZEpIUW1LTU4zR0pBcTlHL1l3MFFM?=
 =?utf-8?B?MXJiSDVLVEhYcXRlVTlIV01xYjZnYjZIU2dtNFJhZ0wzMk9tZEwvNUFRcDFI?=
 =?utf-8?B?RWN3M29NaDNnOTJNcDJLU0xTcHk4eU1pK2JZbkYxNndmQnlSeE9UM2pFcng0?=
 =?utf-8?B?YnFGUm81ZHdjZEhjSnUvRHBRYXgvUWpheEpzSHE0azZtVGVvSm42dkptdnZ3?=
 =?utf-8?B?WE5mZ1NjdEpzcHJzK0t3QWh5eElOY29iM012Skg3ZC9aeXE3YWNTYzBJRGJw?=
 =?utf-8?B?QmhLak1oekVXalNxd3JzNGM2Z2o0aU9yL28ydTZJbTI0Sk9mTDZYMitTZTMy?=
 =?utf-8?B?TEFEdzhwZjlJM3U4NFNpM3VjVXgzZ0F2TElWNkFtbTdpcEZ5Mk5vWnBBRGJR?=
 =?utf-8?B?K3NtV3RkdFhFeVY3bEsvdG1Hdm5MK25OMkhyekZXbjQweEszaW1JUlZDdTJ3?=
 =?utf-8?B?a2M4R0k2OHozKzhhcXRlWDlMRFFwOVZXQ2U5Sk1WTlpGb1FjN1lwVUo3c2JG?=
 =?utf-8?B?eEpSYWdYSER3SnA0ekxnNFRmTXBYR1phcGtXL244TitVSTF2WmJTTk13THRw?=
 =?utf-8?B?czE2YXZZbW0yejdMTm9DSVFLVk1SUGl0SXFuVUVtbVlqaGxoYnUwdWp2Ym16?=
 =?utf-8?B?N3NSbDlKMnBNcHdoTE5rOFAzS29Cak15SzlVOFc3UENrcmpoYy8vTlh2YXFV?=
 =?utf-8?B?S3MzUTRyb0cxTmVYUndDMy84YWdpaWZLeng3bWFHdzltNCtXcE9OdEczSytC?=
 =?utf-8?B?WjdyQmdMMnpZNnd5YnFCZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklaSGVwSGhvcmNqNEFldWlSK3Z3N3dSM0JlVlRDZ2cxTCtTVUIrTVR6RlBp?=
 =?utf-8?B?TUpHd0cycHpVUGpBQUFySyszTU8zMmFnT1lWOC9KWUVuQ3kwcFg2VEsyaFpM?=
 =?utf-8?B?YmVHRjZta1hpeTNpOTljejV0YndjcjdvNnBXUzd3MVgwZlMwQkdhalc4cFMw?=
 =?utf-8?B?TmtJcDdCZmozR3VpU3dYeXBFenJpeWRZbWhnb0tKRi9lUEhJcE82Y3RwYjhq?=
 =?utf-8?B?K3V1LzJMb0FlKzRBdVJqUURkSmxtRDU5SXBvQXo2VnJiRjgxdkQrNU0rWnp0?=
 =?utf-8?B?RER1blJaRG40SXA5bzl2QThrQkFlTzBrcnpnUVVHdTBNdWYwNTNzbS82bHJp?=
 =?utf-8?B?WnRVNExIOHhHMksxTHNjZTh1b0EveUZYMFhSZHlrQUpET29XZjJ6akRVbHhX?=
 =?utf-8?B?L1dLSVdMSFFyUHBHY3ZYWTJnV0YrM2VqY2JuZHlSc00zY3ROak9zNDBWMGJ1?=
 =?utf-8?B?d1k0bytMWHhML3p5M0kzVGNpYzNzTzNtWU9kNjllU3RqR09DU1RwdFdFT1dV?=
 =?utf-8?B?Tm5abHJTeGdZcCs4Rlg5MDkzc0J6bXorTVNKcFoyTFVRcVJOWTgwblhFZ20z?=
 =?utf-8?B?OEZKTUVwY0dnZHRJaitiOWxDMmlhSHMvaTBYdm5YMzFsZ2N6dm5ZQ3lrOUZW?=
 =?utf-8?B?Z2tUN1lZVVpDVXVLUGx6OXV6bUF4L2VKZ0t6MTltTnBQNDVwOTRLME5zWXY3?=
 =?utf-8?B?bDV1VUxhS056RzNwNWIvVFZkc1VIcHE5SEJnckxSSlUxb2ZsV3RhMUo1M3hU?=
 =?utf-8?B?Y2hvUVcrQWczZG5CZWFlTDg4TGlDYmQyakR5QkIvbXNFeExWYVdPQU1raVNX?=
 =?utf-8?B?bWUwckFhVnFyS00vdDhzQVRhcnBMSkZvdGgySmtRcWxIbm95RElEemQ2Sy9i?=
 =?utf-8?B?bnBjdkkvNkpzTk1xSEsxclF3RmlZWEZtbTdMTVJaNDdod1J1SWpHYm9kOTd4?=
 =?utf-8?B?VndSSmFSTEUyVHdJbW5Rb09ZQnBvQzZsUmZoY2JaMGxBOW5URDRBek1wcFEz?=
 =?utf-8?B?OXp4Wms2TXUwcXl4Z295MVVwYjB4RnlSL0UvRU1GTU1aUHZaYTd6dlVIaUF5?=
 =?utf-8?B?YzJIN0xQbVA1dHloYndkM3FyR254d1Y5UHlwVkczVGFucDRPT1ViemwwM0J3?=
 =?utf-8?B?TisyZTJCdFBlYW52RHZINVkzV3QzYUx4WTY4UDBDVlQxNE8rZWZuUVpvZlpY?=
 =?utf-8?B?RVVSNzUvMlIwZDBiTGNyNXV0djFoaWdxT0RXSS8xOUR4RnFVeTRUZ3VyNWQx?=
 =?utf-8?B?RGRVN2tPbFowc3o4ejZxWEh6ckNWRkNHa3JONmkycC9TN1kwOHgrRjhPNWxP?=
 =?utf-8?B?VmdrdzFpZHhNWVRHcFFiZ1ZvZXNlSGpVY0FLL1dHMlBRbGxOcSt4SnFpZnc1?=
 =?utf-8?B?V3VndzJiKzhxWFdyL1htVzNrQzZpYmhUanM2NE82QXpmeVhkUUlrY1JPL3Ns?=
 =?utf-8?B?U2EwTUsxQ3Rlc1RFb01Sc2ltckJpbk5mSHFnYTkyeFhFcU1wOVU4OHN0MVRh?=
 =?utf-8?B?UDlJQU5JQXp5YjNoZjhSd3BxSkoxK0JUbSt6c1VXaHVGemNwa200aFo0eHl0?=
 =?utf-8?B?TDdaOUw1SlJxV3pXS1E0ZzVvY3ZJQ1hDUkhGL25iVkh5anFUa01yREVNcmxr?=
 =?utf-8?B?ZlJISjNLaTVMSHpVajVkTXZTb1UxVTM2empsTlJaMXZWWG13UVplK0hldFlQ?=
 =?utf-8?B?QnpWcWFJYlhTeGRzL3FRSUpVZFBvSm8zWjhDWUNYWDlmRFpMTUlQSmpPUjlO?=
 =?utf-8?B?eDZVbkVkNTduVkpaR1RDY1kwRW8zL1RQeDJvcjZaT0xTZnplMldVVUpTSHpH?=
 =?utf-8?B?eE9FSlh0ZHoxamcxenoydDZXQ3pNWFpWM2Q2NmgxZDVlc3RxWFAzbG1EWUJW?=
 =?utf-8?B?dytKWUowekYvYjd3cjl0V2hic2FGMWJFWFpDQnZPUXIxRTZhd0EvMEdzcW5P?=
 =?utf-8?B?SXd5Vy9obzlMdi9oT3p4SlJLYkRHTSt3b29Sa0c5dTVpdkhCaGdYbTMxdWFh?=
 =?utf-8?B?U3JsSWZQbUcrTFkyZlVyRkpzYXNrbmVya0NNbE5vRVg3YmhSVWZIb2xPc0hO?=
 =?utf-8?B?d1dzM3hxQm5sTDJlUjZ0SS9JOFc2dDM2bFZjTVI5cGFudkptVW0yVjllUThR?=
 =?utf-8?Q?JsSoTWuR305forLLIeYsx8ItF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b9b44-971d-4f19-7bee-08dd13d8f538
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:27:50.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +REwfowVVMKaAJO6JD/wclzsJcjsso8V7dROLerSwQMTkrY9QuaSC9246OsMr90dChYuBhdFyU9dVfFttWeVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

On 12/2/2024 05:35, Peter Zijlstra wrote:
> On Sat, Nov 30, 2024 at 08:06:55AM -0600, Mario Limonciello wrote:
> 
>> +/**
>> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>> + * @cpu:		cpu index
>> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>> + * @class_index:	workload class ID index
>> + * @nr_class:		max number of workload class supported
>> + * @amd_hfi_classes:	current cpu workload class ranking data
>> + *
>> + * Parameters of a logical processor linked with hardware feedback class
>> + */
>> +struct amd_hfi_cpuinfo {
>> +	int		cpu;
>> +	cpumask_var_t	cpus;
> 
> This appears unused.
> 
>> +	s16		class_index;
>> +	u8		nr_class;
>> +	struct amd_hfi_classes	*amd_hfi_classes;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>> +
>> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
>> +	struct device *dev = &pdev->dev;
>> +	int idx;
>> +	int nr_class_id;
>> +
>> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>> +	if (nr_class_id < 0 || nr_class_id > 255) {
>> +		dev_err(dev, "failed to get number of supported classes: %d\n",
>> +			nr_class_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_present_cpu(idx) {
> 
> This uses present, but does not have means of handling changes to
> present. Does this want to be possible?
> 
Thanks, I'll adjust this to *_possible().

I think the *_present() calls make sense for the other consumers in 
suspend/resume though. Agree?

