Return-Path: <linux-acpi+bounces-9901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47B9E2D0C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 21:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DB4165A9D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC73205AD6;
	Tue,  3 Dec 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQuf+iQj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541F20124F;
	Tue,  3 Dec 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257731; cv=fail; b=i0mI22oUq9kN8L+ICWRQSzFtcrFjDCTQyUWdBFvA0wkM8izTFLLGlVo6PGsYApRENLHcGlFmQZDw7fC3Nl803IwjPNQKGKduR2/QV78c6iEaInmKoRxyfqI/sYwvEFoMzhzXaePx7vyRW/8uUl3i+xfKXPQ9Zkf+H0+rg8qRpjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257731; c=relaxed/simple;
	bh=NW6ETDCNcbw5gvZpQsBJiTx2Kut0MZAUSEz58rauMuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+9VzpGH8A3dOSXCWVTgEvYuuJ68MG+zGhCaYPdupAZKQx1HL3HE5KCLeaTjH1xfajPMDwOKJbDgD29wFYnEwSEkmzqBIeb4OLcuR0ldQlBcaXiKGokX90XVwt3h6zUtvqPfxe9kshS1CaClYVRTia70k8I/RHI+272hArtC+FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQuf+iQj; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXMxdUao0g/sjCPUr//zskohFR16TWAWvbW2dl1GIwmmMdRSawyQp9z/haHHkY70M5DMCK5Z4ePlm8Os2BBfm01U32N1DNS30+C/VNZcJzrn+0lMp4zwykLa27BWqnFgKyzcsCFLdz0q8Dm6uzVZyDkk7X4qH7NQW1PNvApgcctk7Dhs2Cad7a99k6DMCU37KBEV40nWFRr7KwoR0nVPczxxqmKbkE8UWlYxG88lFWGpFqMX2Cbxp0dTIieL6lWYlkHArTQ6wLrz9NqjK2GyYenMsgHwwJgPI7uqEGCDPUyYiPYE06rrdSg01W+Pqz+ahrhu4or8uWTlS8dS6E1oCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FVIDjYaLNM5BsYglvLZStD4k0S5iqEIqw5voWWMxIY=;
 b=m6myEuDEfRtYG0cVFoXkujOqnQtBjJJgbdYtnKSvxG+ap+p3ROSLeXbFkx3E+SM/i7gCWea9ACvRKgOIDUI0dD13E8+1Vs1FQP8zJI3BGRLkoZt/gh22V2ns4eUYo7XdPT0A3ZeEdi8+oWAvBJqfjUSSOy5tpUxUiglqKjOGqoISCyAhueasOFof4xg5H9iGVzv5sSq2DeCAOtQedrc1r20+2VcJwcflI4cA9MN0SnUcMc0iBrZH4+huL5vDxLSZcGB7pFlYkJ/+liZ3hkpjOtVvDoeHxNhhELdfPqeHQv5rXihbhnnbvfGy6NfXbrTmN0PUTasn1ivWF934IA7PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FVIDjYaLNM5BsYglvLZStD4k0S5iqEIqw5voWWMxIY=;
 b=KQuf+iQj/3Qf1iR3fgH8/eHIP622UuuPyYUryacneNFEbCiBDJpZmaxzELZbRrpNTPGlGvQfUi8ZCZkKc+bOn08zpjkOVWtFpCvzZe97li8rh13STl0ruN7KSHrNO5FOlnlniZkvlHdIwPRcLGNbGqw2nSoViWncaZbxrPag7K4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:28:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:28:41 +0000
Message-ID: <89e53b9e-5cb1-4ef9-b3dc-10263f141cfd@amd.com>
Date: Tue, 3 Dec 2024 14:28:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/12] platform/x86: hfi: add online and offline
 callback support
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
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-8-mario.limonciello@amd.com>
 <20241202113858.GB8562@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241202113858.GB8562@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 10571791-8d9e-4ac3-68e7-08dd13d9139d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmRTZmNhdElNWk1aNXJtbi9QUkg4VW00R2FLWWcremZES0o5YW1EUjhYWnNm?=
 =?utf-8?B?QmNnZ05hUTNJTWMyNUx6QTNEQkNnSW1tYkJIa0hCaGQwTlNkQ3FVU3FkNktB?=
 =?utf-8?B?NjI0ZW42UmZSQzZwb2JUQm90SDBybUF6d2pjckpoRjRRSmR5VU1WSDYrNVpv?=
 =?utf-8?B?NEY3bC9YQWVXTnd1ZEJQWHovSm1xOGdqeVpZbkFZVW9Qd29ZejA4alhSdmV4?=
 =?utf-8?B?UTZYWVhJeUVxbDNmcno2KzZCOGlsWlpOcXZNQkJJaUZnOXUrVy9rcU4rZEl5?=
 =?utf-8?B?UEZvNTRycGY1SjBaUU1rajZSL2NLY050Ly8wU2RaN3lsSVBNbVlhOUtXZjRF?=
 =?utf-8?B?KzkwNFlvMjRJNVhRQ0lLYUJOVjV0OHp6d2t1RWNDQlpzRGxqMGluZWwvYXdM?=
 =?utf-8?B?R1VyTHIwUmN0WmtWL2xTbHkrQW1NMjZyMElxbytIL3g4WVNwK2NFMU1vZ3Zt?=
 =?utf-8?B?cFRZRGZ1VkRQajZINzg2Y0ZXVTZrbzR5aVF6SUlnV3lEWExzUlhyMjBvZFBt?=
 =?utf-8?B?dFQvRGt5R1JQNnVkbmlHeGp6ZzQ0MXJaVm1odXZKN3lYT2VQVTI0cmNNbkRh?=
 =?utf-8?B?OEhvc2toL3VhQjkvQTJpSXRDNUkrWUZ0VnY4RUJDWnZNL056Z1dwaHhvYzJF?=
 =?utf-8?B?OTRmNWxsNGNqeEpXWmhNUWRWT0x2enlGQUMrK2RpemdVUERTUEZ0ZzRlbm1W?=
 =?utf-8?B?N2dzaktDVkQxa0MzbDUwZGZSY3J6NEV6SHFpaktRVkFQWUdyUnpLQkVFNGNW?=
 =?utf-8?B?SDM2elFzdTY3Uzd6R0l0c0pPQzY4LzE5Y2tTODB6UW92dWo5YVpid0FlRnB0?=
 =?utf-8?B?ZVpzNEVmaWVyVXZPaDJaYmZjMDZ5R2phZm5KVkpydVhKaEtQYnE5VjJMVUZM?=
 =?utf-8?B?Qi9pWFIxQnFPbFQ3eXR1d3RscHJBSlN4TTlLYkVSeXhYL2VLK3JadElnZmU1?=
 =?utf-8?B?Q3ZVQm1mZUxzNkJDTW5BN0hXdDRaaTZKS2h0QzFvSGVaMm9Xd2kwZE9RbVZu?=
 =?utf-8?B?alJvOS95MFo2R3krQXFEZ0RvTzhpOHlaeFVlb2pBcWJ3dGwxbFlROGxlc0xk?=
 =?utf-8?B?b0kvTXVLanZqYzdaWGtIcG1jdGd2RDZ0RHJYb0RLYW9KM3c3eS9qUlczN25T?=
 =?utf-8?B?UXNpR0VReHoxc3RyNHp1U3BBdGRHWVp1SEg0N0I5S2NPaU01dzE2dVlNU05a?=
 =?utf-8?B?QU84SDlqbFR3STJvSmJhdVhXdGd6UGV0Y2VJZnlaSnJ2b3ltRDNtdHJrenZm?=
 =?utf-8?B?V3BIU3J3cUZ3WW1HcXNQTzd4OEVJNkVhR1QyZ2E1dFAwT3RBcVlVUi96UG8y?=
 =?utf-8?B?dVlTY2lxRXlXQmUrMXRlVU9sdnV3cUpZOEF5SzAvRjEwaVVJUjBGeHRhRXYx?=
 =?utf-8?B?aXRKRktsMmtnU2RFOTNSTDZMR2VkaXJqSTBSNUJRTTRhY25STkpvejFCcTJJ?=
 =?utf-8?B?U0tVL21KRzBGczB3d0NNTTgrWXdJYXM1a1lmWGtibmFTcFpGd0wyYTdoc3FF?=
 =?utf-8?B?NXY5UWtNck1MRFFWSGZaV2tLMUFZLzdrcUtXN0JQalF0Q1pVMnowUHlSaXdH?=
 =?utf-8?B?L29leVJVQ2xYdTFoY3JlUTlmZDlYN2hBL1l6MmJSY3B6R3U0cU9VSE0wSE1B?=
 =?utf-8?B?azV1cVJWcC83NkpjSlIrYlUrVXZQUlNMSWU3cGtlaVFKd2dIVDlKeGlBYWE1?=
 =?utf-8?B?cE83SUYzdElUV0JWSnE0OFBJaXE4WnNSMVBHYVpPd1VtY01VdUFVK3BubEJy?=
 =?utf-8?B?Z2psOFMrVVZZV2k0WFZhTzRXQ1NGS1RYdmZpMVEza2t4c2RZK2ZwcHNVbGxy?=
 =?utf-8?B?dGQzNC95MjNjOUgyN2U0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCs5NExIcGw4bkV6eVprVUNkTEhwczNkMDZMMUlkMEtRK0ZKcXIvRW9kcllG?=
 =?utf-8?B?b3BCc2tZdjJITmVRUUxLdzlwM1B2TnJSZDJiVXFyWGJXeHVIdU1uZmxTQytw?=
 =?utf-8?B?RmpvRWx1Q01DRm1zUWI5SzF3QmxqaGYrQmxxa2wwZzNFUWdkSnp3STc3anp3?=
 =?utf-8?B?b2E3QTV6WmlXamsrTjhmZU9wTFJRTzZUT3hQbTNKV0MyV3MydmRpYjMzaDd5?=
 =?utf-8?B?cDVaRE5NUm8wMi9zUXYvS2ZaSUlHdGJpQXlEYndwVkVHNXdmc0FObTZ0NEFM?=
 =?utf-8?B?NnhOd0ErbGFpb0ZDQUVtN0pndHl2SDdZWDZHamNrWHJpaFhWZ1huQ1FWU1c3?=
 =?utf-8?B?MTE0cklrY09BZXNvZTB4SjR0S1BOdVBzOXB0c0pEblNGZmJxclRBSmtOdmJ5?=
 =?utf-8?B?QzRsWUw4M1FFRUZENjZvb2ljNUZqcHEwVi9IVjdnVnRSRVRiSkQ5M285RHRq?=
 =?utf-8?B?LzVqbXNGSUZPd01vMUpoWVZ1K2Q3a1U4KzZWd0M2eEJKZW43WmZXcmFMb25x?=
 =?utf-8?B?NmZ5dU1LZmtwOWFDODJJRUFTZTc0VGllUENuS0N5aGd6UDErTkVvYU5lWE1Z?=
 =?utf-8?B?Yk5qR1VyWlR5OVV6L2xQTi9vaHBvQkNvNGtPQXd3ekVlM3JTclE0SnFpejZ2?=
 =?utf-8?B?QWtNdkxPTFpEQ0tmRG5rWHdTdk5jQllNYURCTEZUUVBwSVZmWm8zYTNpNEZK?=
 =?utf-8?B?YmpXZGt2OGs1OXJhRzEvZUkxWjBpRFdvcUlEQ2pVNHZQODZTR2ZHYk1HVDhu?=
 =?utf-8?B?YUgzOVJWZHNLaHlXa080VFhKNXZNeGJRa3F0NFp6cHVyeEgxU1g3bU1VMURF?=
 =?utf-8?B?MVVyR2dnN3dqUkl0T2pwNnp1SnN1RWlRRlJsbW1QcVlic3habUZRK2NsWGZy?=
 =?utf-8?B?TEk5b2VsZHk5aTFTSXVtaDRDRmVzWEw0YjJBSFJIK1AwazJLWnorcUVZOFhj?=
 =?utf-8?B?NitnTFROeUd6Z1ZicXRUbGd0RnBLdUFWZmZIWlpXeHZwWHFWRmRUdENjV1dp?=
 =?utf-8?B?S1huZGVHK0xHUVRNYlpvNVBGMEtjSmdHZk1YMjVMYngyNGRSa0s2b1JYMVJW?=
 =?utf-8?B?MnNoMVI0aGFLZnpHWStJb3dSWmR0djlMUm1Sd3VXQ0JmWXdlQWxCdERaVzlP?=
 =?utf-8?B?cUF3cWNpM202K1F2VC8wOS9EZnFxUFFUZml4ZGg4eG9Ma0xRSXczdVFVUTBT?=
 =?utf-8?B?c3E4L0NCUVhMd0RxV2JQTi8rVjloanJUUTRaSVhxNWw5cHQ2U3haWjhYSERI?=
 =?utf-8?B?MVJhd0RmZi8rbmVKRUN3V29BTzY3MWhyTDFld0JueldvV2FpWVF6QlBDdW41?=
 =?utf-8?B?VlRNSmF4UytXdFcwRlF5b0dPWDRjRkFqTWc1Rlg3SU1uWlFmZ2l5SHNOaUkw?=
 =?utf-8?B?andCYzJicVYzY3BrSXRLRFpzQmtGUmpVb2RVZ0hBcUlid1A0UExJQytpV0Fk?=
 =?utf-8?B?N0ZFZjdDREtoYlMwc2pDWUpWdXo3WS9rZXA2THpTb0lVNVFHR1FkbTJnQ2pQ?=
 =?utf-8?B?S2N1U0NQYmxQWXk2TnhGVm9qMmFNaitXVzhqQXI1Ty9JZ3AxMHJnTndpT2xY?=
 =?utf-8?B?OTFmWGlFcU9LWGMvdjJSUU9ESjNIRGVaRFIxWlorQWJHWEFUK3ZIRkpDQ3M3?=
 =?utf-8?B?YkREdjgyRlI0TnFCZGppTEZaWU04RDE1d3l4VHZjK2UvWWZPSWRYQ1RsYUxD?=
 =?utf-8?B?M3dKaFdZYXBwbmNYblJ3MTJkeE9hZitJU0xSOFlKdXl2Rk9MY2cxWmRmSXA0?=
 =?utf-8?B?bWlYRnhiVXc3aHJucGtzUlRPRzVJYkhldk1MV0JYVjZCNGRmb3hGbWkyMVhE?=
 =?utf-8?B?YitxREhZRm9ETnFpdUpYNFYwcVZ4NlppVm5hN2V1UmZoV0NmdVNDWFJLWXds?=
 =?utf-8?B?aWJGWUo2NmF5L2ZNSlRvd29Yc1g1UVBVZVN5dklPOVNwaTR6dFhJMHNycHF4?=
 =?utf-8?B?RlFZcDRMamxxa2JwUEcrRGZxaXNwczQyMnE4a3I0RjVkOXpUYWRjWDdWNG5m?=
 =?utf-8?B?bmYwSTRtRUphVDZQc0lYNDBBZ2RHSkQxeFFBcW0xUUFsRnhtSU9yd1JLaHZS?=
 =?utf-8?B?WjhQQVdNYTJrZDBacGVXVU5BTnpuU3VFVG94ZEpsb0s5bFN3SURKZDdITjRj?=
 =?utf-8?Q?A7VLNw+pZ9MecIXDDNFNSk5/3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10571791-8d9e-4ac3-68e7-08dd13d9139d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:28:41.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJh2jA0+PbanhhZ0PFdqH+wGKfAGzD6YA8jnRIyKwURQ7S0ni40o5w4cUUl/teJPVR1EbgpBUL2PFepaxHGR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

On 12/2/2024 05:38, Peter Zijlstra wrote:
> On Sat, Nov 30, 2024 at 08:06:58AM -0600, Mario Limonciello wrote:
> 
>> @@ -340,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
>> +				amd_hfi_online, amd_hfi_offline);
> 
> By using online notifier, you will already have tasks running on this
> CPU before you initialize the HFI bits, is that okay?

Yeah; AFAICT it should be fine.

