Return-Path: <linux-acpi+bounces-11026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDFA3125E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F20D1887B24
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED9261397;
	Tue, 11 Feb 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6gklH/g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317724E4C2;
	Tue, 11 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293461; cv=fail; b=pxFiF/JqPGT9jb+emQ2ZX5bB0OySCuikWtpxSwfd6FMhwdW7j7ZFWd6tzmttDD0O6Znufzo4H1GqksuvPSdka9FyKnZ6hCqZ6jYdlka/ctZdwX7w+cbeWvrl1LoyOFgaIhb0yoXBDM5HsxAEIjyyRaElV8h0Xj3yeQxcZo4Vihs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293461; c=relaxed/simple;
	bh=AxljqGVymDy7d7Q8C5mSDMdmYh7jBwMccamB65fIj7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfDqVytSf9ZCq4Tz3Fr40v8yjKvBU94p1VVHa3zY8x0IZFznusAVSxmNULhTmbyMI4Qzw+3UnEEjBYHjJSV+P4mKgwsB9KdXUAK2mlPJ07VQnCBA2YnZJdGAIwD8oBPjePIebBgeiWOXTOUp30Y9qa8+fNKtElqphKtqnuN7M4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6gklH/g; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv8ttecaJkWBbatZWfoBSeITY8lTID7ZTOHkA85KnQxUnM1cIMMIOHgC/aY1DkgpcJt9KFmCdznBGHaxocr+MQMbhH7OZe5VMzLDKg6e6zEBLsDeFab/kYLTzLxyCrSVFXJyGqb01z/XrQaRaFJzgaRIo/EXe0BFfQHErdKNwv1mW4EtqjwLeYdkeVmYctf5OFtvI/aVx4++LAwEEywRha+hfHYATn8TFo74WIR289BfMrNSfQZtQQ5aamoA0ifBqDgipbFHBRbLwfOzPS3ZUGmiQR3pGCSmA/uaPRqmc7FWxy2FuQvriF3h/6QNiq1wX4gi6iQ2Imeb5yGw6tv/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfOaxAinkheMRadZIeFf+ruOxOKS1So8JjPPQfoVVZo=;
 b=mlFHqoTR2gNfva0sFt3DH+f95UcPEZg37g5g9PQ6hBggMcNq78Sw/x7RgnUES7+eRr8YP9QS7oB3Ztp4CBm2mrWN3Ps7BWxKZxdam9ecZPFSzjjpvWo1fL5F8hlp52nXW0ZzyMueHi2IURNqc+HcaKSAId8GIzZ1AmVr35PEVHPfd/Uf4plCpu8W3G2EMHGHjBcwHUpH3JljKwXTYAQaOODlNS/RHa5DbIrPUgl9F1QFRoIBo7axwzrcvLrLuhC35dbt/lAeAwLdtph+TRC9LtiYt6iXf7NSUkyXzrFRw38BbCZ3ooKWQhr5uOK6fOcLJ9UjXQSjlK9iUENFXQKs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfOaxAinkheMRadZIeFf+ruOxOKS1So8JjPPQfoVVZo=;
 b=V6gklH/gc5Ix3NlK2HEUv+uorjH8lrbl47e3k3uPF0iBOqA5G7Z6uYi/4t2SqtRmjQxV4fcO+Boq5XiPOXZ24L8l5JMJs0EcneFK9A3JoYt2lWhZx0V8KOGUmtVoZ9PPQ023F2dDbsobLbaebW1CxNBmxXZZCzGhBJ35kaN+w9Qlu2BoJCpoho2QggVg/HgBrQMyDUg7N3EdqLWiHWwkofcZtDV4octlTH+uC4yynJ8RxggJ7RlJbmsLWYdU4RQFiHSjnqm5i95N3OfSf4MmeviyajtNv55ieVKd/IJLCqT/ogt5A1JYTV4aS8MIN20MX9v6vdpfKHSrEULpc4etfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 17:04:16 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 17:04:16 +0000
Message-ID: <23ad27bf-3839-4dcc-989f-89e87d06adc9@nvidia.com>
Date: Tue, 11 Feb 2025 18:04:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: Use str_enabled_disabled() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Robert Richter <rrichter@amd.com>, Haibo Xu <haibo1.xu@intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250209220435.76178-2-thorsten.blum@linux.dev>
Content-Language: fr
From: Bruno Faccini <bfaccini@nvidia.com>
In-Reply-To: <20250209220435.76178-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To MW4PR12MB7261.namprd12.prod.outlook.com
 (2603:10b6:303:229::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7261:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: da546c6b-82eb-4038-f26b-08dd4abe1de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1pRR1R0Snk3K1JyNGUvQjNDT0YvQXpZWldQRnJlamNxTUNUN2Vpc3ZPVS9u?=
 =?utf-8?B?eWZ5VUlZM09Zb2lJdzIwUVVhQXprb1krUkVrTVdMUjVpMzFQZTdMeW13bjFz?=
 =?utf-8?B?TkdrSStpdUV6NDlBUGkwNVFFVXVmT1VBamdSL1g3R29uV2VjTHVFNGNUYTBM?=
 =?utf-8?B?K3V5NWRsMUxHajFLaXVtNUlLTUNHRmlLWDRPcnRrd0dPcnMvS0JVY2w2dzcy?=
 =?utf-8?B?Ym1tVU5kTmxLZHVNc3dCMWpDL052bE5EaVp2MnJKSDQyem5xL1ZzRWZjbE1N?=
 =?utf-8?B?SFhLQXBCQWpDNnVmR0dLbmczTmdHTjc3cktvU2ttUWVHQzdZbDJRNmExVkRi?=
 =?utf-8?B?bGpnMTNLYk1od3BqaVc3eVlpUkdlVkdvTG1LZG5rbWNIaXlMbWlJQ0lEZFd0?=
 =?utf-8?B?eG1mQ3JOZnVudHQ2bTFoNEpOZitvc3k2RjlTRXVXbENHNTBGcktxRlowdzM4?=
 =?utf-8?B?Qm00YTdYQndtcCtnN3Vod0g0MXhXK3hUTVl4NWhCZUtYZ1VpWG9qTUdJS2U3?=
 =?utf-8?B?d3FoOXc2TmgvdmZBYkcrYnJhL0FuQ0pjWjZYWUF1TVlKeTZ0bnBOcjFpaklv?=
 =?utf-8?B?Uy9EeCtiWUkrZk8yMVVVN2hhdktOY0pSK0hxbUxnRG91SHBzaHV6czhVKzB1?=
 =?utf-8?B?amlNbStZYW9WR3dlcFowNE5OejQyK1NXZzAxaVpTbW9JNml4M0thUlFVSkZh?=
 =?utf-8?B?anA1ZHlhc0ZVUzRjaDVFZ2ltTmkxQmJZSldWa0VzdXArSVJmcXhkMHJ6NXdU?=
 =?utf-8?B?c0RDclAxQ2taRVhlVTVGYWxuOXdGZm4vQm5RcUZtb2JIbGVyRG1LSGk3Y21L?=
 =?utf-8?B?R0JCbGZJVVlONkgva2tPSnZLa0FnbDAvTitLVk0vdERqV0RQOTZYSjJCVWFF?=
 =?utf-8?B?bnBaSnNaTWRtQUFYdGF1UkRsZ2sxVk5KdkN6MnczSDdGSmd0SlN2MzBaSGZE?=
 =?utf-8?B?MjB2cUNSUjc1N25CRkQza3dBaWh6cCtpUWtMMWF3MWt4RStJbmVpS0FieDRJ?=
 =?utf-8?B?YUcvWUFXU3RGcG1KVlAydHNYNFJpT3grUytQaElFRTZwZXBlRXg3eEJieXI5?=
 =?utf-8?B?RFZUOGpoU3lKMGVwUmJIWS9TVmlLb0t5R3pEaVY3emZORXlNYkNGaGp5Rldm?=
 =?utf-8?B?VUN5NE5xaWhtK1JjQzgrN3huVGVZZ1JCSFZOTU1Ic0s0eUt5dVB6VWRETThD?=
 =?utf-8?B?dTBtWEt5aWZWU1htZk43MlJvaHkwOTREN1FOSmxxNDhEU2tnOGJTRUZqYXF5?=
 =?utf-8?B?Y09mTnU3Z1FHcXZsWWQrQjlZUDM4OXN4a2NGVThjMXQybXVVUjVhTkdidWda?=
 =?utf-8?B?OXdYa2l1MVVvMDkwbmVMcXFORjJuQ0U0eW1HU1Q3ZGZXbndWTVdYUkwwWGdP?=
 =?utf-8?B?bWQwdmVzbS9tcFEveTMvRG5zaXExMys0ZXU4ZVdUS1hCVkVYMTBOejFYcW5Y?=
 =?utf-8?B?cThDNHVMd2JROGZJQ0VIWEdQYUozNTh6U1duY2N6TVhPNXhnb3A3ZEFJRWph?=
 =?utf-8?B?U3FST09QMUxIMUxGb0E5RlJuZkNhdWgvakdOYVp5UGtSU2FySkxyZkN3RUJY?=
 =?utf-8?B?TzNiWUFBQkVQWVpyaTZPenIvN3VQZHdBemdmeXV4bUtvVC9mSXpMWG01VG5n?=
 =?utf-8?B?YUMwNnhOMGdVdVVsUEx4RUs3M3FTajVNb09Qdmp6c2xSeWhVVTUyc1NTY0tB?=
 =?utf-8?B?Y3dmNlZHSldoWTc0bVRMYzB6STgvU25VMlA5Q29zOHJLbk5tZ1NnRFFmZ3M3?=
 =?utf-8?B?MjNZYVhObDdSbXZibjlyakswanJKZUlrbjlWbGROVmtBSHNEdmNJcHJLd1Vi?=
 =?utf-8?B?WTlnTnJLbjZrSFFqZUZVbDlSWFp1dlExSVl4eEJ2dnhyOHBwOWhMSFZhZXhk?=
 =?utf-8?B?YWFaU0ZxYUhSdWFLL2tBU0NTSVkzczZLT051TkdoeFhzNVk3SSsyVGlmWi9n?=
 =?utf-8?Q?gxORUZhJOdM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVHOUtKdm1MMXc3NTArbkM5cFlLYVNJdEwrRmliSms3eGd2U3JWMUhLNTlQ?=
 =?utf-8?B?NXpPWmJDSktkbkdMWjdNdVRwUGlQNU5XbU12REhnUnB2Zyttb0pKbEh5cUdh?=
 =?utf-8?B?OFBDZnNzTXhIemYvQm9CM2FXdHFRc0VsR3NpN3NlRTJsa3JyOHp6d2JSRVBy?=
 =?utf-8?B?WWx0N2FIWC9GWVBiU2swMVVINHJXL3BrTHpTWEhtQjhtcUJXa3ZyQ3h6R2Nu?=
 =?utf-8?B?a2NWaFErTkcwRWxvTk9pYlJFb1kvT3hMSFdtcndVOUhKS014Nm9OakFpcHBM?=
 =?utf-8?B?c1J4bVdSSWJlazJjdXYwYk1lbFNoV1BPYXZlWVpxOVNDNmdYQ2J5R3l4ZXlq?=
 =?utf-8?B?TUdnMFZoY3c5UldwWW1KYnZHMFVabEVHQ2F2ayszSzVSaGp6Nk9xUTR6V1kx?=
 =?utf-8?B?K2RhUWl3Wm1HOTNDMGhYTnl0SCt6MlBNNllTdTJtNUlkQTNaVENVVTA0RTVq?=
 =?utf-8?B?NW5oTkRKeSs2b2VaU0I4ejhiWTloV0srUzIraEgrN2cyM1VaUEkzWDd5dEJS?=
 =?utf-8?B?YkU5RWdIM2paU3R1Z1NKR3F6K3k0ekQ0K2I5QXZXL0NlMDdlY3FPSWRadkNn?=
 =?utf-8?B?cW1jN0dwSmxJeUJZNkd2T2dRY3R3TnpyUEhOK1hPR3lHNlpKUUFOVW53WHUy?=
 =?utf-8?B?TzEvVjNkZlkwUGlZUU1BK2ZkQ3ZueUU3dmE4UGd6citOdHphZjVlUmdpVzVi?=
 =?utf-8?B?RnFvdkd6WXFkV1JxZmhTYXVOcTVvZ3dJYTlZNnJPeEd0MXRJOG1acDZvVXVT?=
 =?utf-8?B?RDJMcG5sT2RreVQvWC9hSWpGbTVQdWlKdlRvekZyTlo3U3JMdWVCRkhUQytX?=
 =?utf-8?B?ajFuVGNKM0RPTVVIVDQ4b0ZKZTQ1c0NmemQxS3RSVFhndTFqRE5LRU03NG1B?=
 =?utf-8?B?ZmJGS3g1YlhzQktybTJYYk9xQU1sVVJVWWJJb1dYWGFVUDdWMUtWOWZGRzdh?=
 =?utf-8?B?cWU2cHBrbjFuekhnUmxXVUxGK0lrQjF0UzdMUTA2VGhOTis5OTEwbml6bWJT?=
 =?utf-8?B?S0tadWU1aC9YM01wN1REYXVyQ0VMWmNob1FPUEVZY3o4SE8xUGNDbXNha3Jo?=
 =?utf-8?B?ZjdSUXJFeThtUk9xanR0MXovOWZWMStPZ2ZXU0ovUUd1OGsxeW9oR1hMdTFN?=
 =?utf-8?B?UUVMTEJXejdhd2V2R3BBaXZmUGNwTC9BUHJZOFk4RkpGUlhCcUIvY1NkRXJq?=
 =?utf-8?B?NkNTeWVqTk5NeW1yRTY2MFZVeHVIbWNrb2dlc3VSd3NsUUt1eXZSYWZGR2dZ?=
 =?utf-8?B?YzdicGxtNU9YdURSc2JIQUkrSXduRldSQTUwUCtoTCsvSlBIZjFhbE1xdGFw?=
 =?utf-8?B?Wi9JMnZKVndsaG54QlNpK0NrSEdQWE1QOU1YTUVFUk05UHFGWDVaQWpXSXB6?=
 =?utf-8?B?Lyt1K0NZQjNPR0F6WUtUak5KazUzTjhnZ1VYdGFsL3gvSFdEYlYwQ3dJU1kr?=
 =?utf-8?B?MXZpSWEyTUtMRG9weXArdlNoVDcwQmNtYnRLOEZLZmszK2EvaDAwV01KaXUy?=
 =?utf-8?B?UFpPK3MzMnZmZGFrT3p5QnVWcUdLcysxbFQ5UWF0aWdQd1hSNFZjMUpaaWZ4?=
 =?utf-8?B?NDBuNVo1amFCQWpjVlhYSlF0ZjZyMXZPcDMweHptdjQ3TW9lZHFEbWM5ZkdV?=
 =?utf-8?B?NkMyNWw1cjJabGZ3ak1WK1RhTlh5VG4xQW1SZzU1VVFBdG91QnRMNzBPOXFm?=
 =?utf-8?B?UVh5QWluQWQxa0xlYTh4M2UvV0xuTWxCSUhlTnRBQUsvcEZFOStNYi9LKzBy?=
 =?utf-8?B?dnk0UmZlcXdtRnNYZFdwYnp3UjVOcTdyc0g0V1ZWdWt3NTBpbWIwUWJ3ODVZ?=
 =?utf-8?B?WWUxTmppSFNZa1RuKzFrcUNYQTlacFpyMVJxZXNQcUw2ajhHQjA1R1VSNGhs?=
 =?utf-8?B?M1M3NkhGQ0ZkTnl0S0tQRGwrbnZ6VG8vaVEwQnRBK01sSEFkRjg1RUw0cjF6?=
 =?utf-8?B?QW4reUdEbDl2VzdwRnZFZkdlanRXOVZuUVZWOVpvVnRDUTlLZlg2aSsrK3c5?=
 =?utf-8?B?Zm56UythV3ZkaTdBRDFNaDR2RHRTUXFxRVc2TkxkUXVkdzdoUWRMbHlzRC8v?=
 =?utf-8?B?MkNLMFNwSC82cDlIejd2VHQxSXhZQmhPQ00zUk5SZlFQOFptbnB5RXJzajQ5?=
 =?utf-8?Q?/nlHmLuCj7FfLuzzmfnKxsHgu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da546c6b-82eb-4038-f26b-08dd4abe1de9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 17:04:16.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulT8TaHR1bamMxIBdBuQC/3Vfr7+QPo8vili+BO64LoNjhp2YorZ2tQsrksAMiNlUFnn2jknVEdjZpl3Y8CkSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

Le 09/02/2025 à 23:04, Thorsten Blum a écrit :
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/acpi/numa/srat.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)

LGTM,

Acked-by: Bruno Faccini <bfaccini@nvidia.com>


