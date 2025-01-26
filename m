Return-Path: <linux-acpi+bounces-10826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A8A1C635
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 04:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333853A58A4
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3218A6C1;
	Sun, 26 Jan 2025 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVK/SN5h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAA25A625;
	Sun, 26 Jan 2025 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737861503; cv=fail; b=loPF8epQvNpzrtszqVM8bG+JxqCTOdsyz9TtYXn0PWmRwyzlau3jRW1X+u9IImOzK65lmY2NZLBOYOm8oB2lYIBMUkGPW5anzsSNgNNeHLT4UVepLLFRLM2CBsqjMnzW5kf09tKz9hAyYh28lAhaWCic/jOqDb0eqmOhQwz9WHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737861503; c=relaxed/simple;
	bh=fTdy8ZPLIqFSTheYNQb2I1vEANKpSRqJpjteNT+VZ2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jESqT/eAF3pXUfGRv6241mKwLYmijtv3b5fX797D87Wq57q4SFbYenNtLFEp5ulQhYix75uHWmvHM2gg6XpoX73l/+PPUIZKksEqpOfkC5OXMkCz0XxGdWjhA+qs7rCTJlM3RrUw9G33hKUCKO1q/tVnZmBxjIWYwfcE000hK2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KVK/SN5h; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sdn8TOZvEBBR6eYAMKjqSEnUBdqooYq1RxKqM2d0KB4bdVCjz8Oya9Uz9Vq0TEyVqltX35R26ADhIN0Wl40cqp4SMxdflQxIgasyAdGvAR5n8E5W5ByNzGETlLku4k17eMyokJxpFZddQSQ6YFry4c1YDX66KRP43ECXr/mji8ZeMOHuLFVDHxKtagYfevSu8wFAtyCEA6ZeX0OWJniIOk/gqzxxGyCBRkF5LnVRMnf23HajYJtjNJIi9CSB/kMJg6bbxrniFruTyFpcw+ea51/mgUMvXIBEYKP1R3S1kSfDoqWEtruzZneIkf/LjYOTakkeLWoiEPhumvt+nl8Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA6N7X27QcgisNf1j5P8sblt398urqwIV/8f0RAuVxg=;
 b=Kcf16cxw4aHJizS5fKx+z2t4Z9FJPABiZFVmNFLkEirQvo6uCtmnkxnWHjEjuPxKfpwYdFi+vR9c/kW5msUW3VtZJqfIOVOHxBHF5ppMgfcv21ByXnvsVlB7a3648KC/D2mAAlLDin6XmXX9oMa2KKeMVM4gSY1FvA3MdazcFfoVyw9LJQxNkSjFcAWs64rf8IWNs7w1mLa2mvBNR8bC1Hnxa1jcOgTDwLUmgKRsT6kRhxUvMcOJuOhDig+EZ0WUb9F3UCPpRI3aAtKGZimM0wQ9F8JW7NRGm691E0vgsamwFHfjfmhAAoEZJI8WSFa96NT4KCTnadGc4RKNSusIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA6N7X27QcgisNf1j5P8sblt398urqwIV/8f0RAuVxg=;
 b=KVK/SN5h+cF12qiK2pZR2BQtmycWKcSg6LbPJoFhh3qesCNzvBgMTWVRoWHrL8abenvQOqZEycrrheyZIVXGDvLs2dzE9GlboTvNoHeyw2qyrLw1PEFFgkTptL+psUx1kalUtpiKE864dj9Q0ixsj6oZmYcbrdLq94XZTBFO7GuPOyLCmhZWQVpLs5sJq9LQPRqN8UkOCgnz5pHQksN6+QLRNmoTce2Qt7h6kFs+JPa9rzbdTDyHngb7od6guOQI5AW0O24Yx58yKjKk0wkK7dP47zgWedKnnCnnM9GnVTyMALM7uzUhklLxA4Cs8bozdySlmC//07ufas2dbks9wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sun, 26 Jan
 2025 03:18:17 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::2dd7:3733:a8ef:5db9]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::2dd7:3733:a8ef:5db9%3]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 03:18:16 +0000
Message-ID: <27ea8e21-062c-4b00-8331-115039398359@nvidia.com>
Date: Sun, 26 Jan 2025 11:18:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PRM: Remove unnecessary strict handler address
 checks
To: Aubrey Li <aubrey.li@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Matthew R . Ochs" <mochs@nvidia.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shi Liu <aurelianliu@tencent.com>, All applicable <stable@vger.kernel.org>
References: <20250126022250.3014210-1-aubrey.li@linux.intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <20250126022250.3014210-1-aubrey.li@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 08212b1f-b6dc-48f1-e7f1-08dd3db81338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFExcU1ESnI1S0xPZnkrN1U2bkRWVGdxNXZTYnh5SVlKeWpiYy91KzQxenA1?=
 =?utf-8?B?bWc2RUtXd2Z1aVllMGNlWGo5cHJkYU1ERHZodmdLNVpFQi9sS1FGcWNzdXp0?=
 =?utf-8?B?TDgvMGtDK3lMd1E1d3R1ZisrVXB6UzBqM1hCd2lRTFFMUVlyU2lwaGh6NCtx?=
 =?utf-8?B?d2d6U0E2UzU5Z3Ntam1vYzlOc1U2L09BTFlTVCtZZTgvY1ZGSTZsVzFSMTZU?=
 =?utf-8?B?cWZKQlZ1YUNXUi9lbHA0Y3hwQXV5dDk3OVNYbUFZVmtIc283VHMreXB1Lzds?=
 =?utf-8?B?TkhrM0R0ZW91Vk5RbDlmK1c0bWk4a3ZxQnVTU0JTZWpHRm5Xck45elkrR3Bs?=
 =?utf-8?B?TlRCekMvcndZL3ZraG13c2NWdWkxQ2hEbDhYS0MyM1lKSEEzaElSNE9TWDJh?=
 =?utf-8?B?NzRhcWExejJBem5DNW0xM0kwdVVlbUVMVU5JYnljdWwzYk12S2FINWk1bjlw?=
 =?utf-8?B?R2lCZWNHQ3FYTTQ2RXBQOUpFZmF5SE03Zm5pY2sxUld3UUxreU1xTXZ1VlUv?=
 =?utf-8?B?OVhJbXRzZjRIZEFIY2dDSS9RY1ZCSHMydGNPaDZpVGlEamVRbGZ2dDFCRjc0?=
 =?utf-8?B?bEp0YU9SVWs4Smx0SVJqamM1K05tTUY5dFpQc3F6WkpIVlduRDN1NXFoVlln?=
 =?utf-8?B?UnN3SmhuWHFrWktUTExmbDVFaXN3aFNXZW1Gd3VDa0FTOTYvOGl0Y2lTVG5O?=
 =?utf-8?B?ajhDMUJxdjhpME9NaWZwSWs4K0pQNlhiNHc4WWFDZU1pd2p5YUtDaVVDaWVn?=
 =?utf-8?B?UnJMVEJYZjUwL1Ryd2tReGN3T2tSQTNZOHU4WVdLNUM5MklOZ2lkQjd3eVNG?=
 =?utf-8?B?Y0Y0T2FDK0kyZytma3lJUTJlV1c1NU5MMzAyZ2d3UzRXZ0U1Smw3V05DOERV?=
 =?utf-8?B?THhXYWw3dmRyVmRraG9pVHBNd0NORzJpUjRVajhYQmdNWExleStyeEIzMkZH?=
 =?utf-8?B?RjhQd0JIY0YwdHNobHdZZmpFQU8xTklCWDh0RGdLQjYzelNGNnpsS3dIVm8w?=
 =?utf-8?B?MTdKdFZwTWE4OW1BNEV5anF5ZWZySXhXcVFUWFBGdEM2eU10dHZYZnhDcFF5?=
 =?utf-8?B?TFFnRTFrNlBRUzgyODJyZWV1RWcvUnBzN0RBbG5EOWpLRzJOd1VzUGJKa1p3?=
 =?utf-8?B?aXl1OFkxSnJVWGpVUlVJay82dEFndWN6a3MvTzBBaXRHdXZ6aXNLVUtwK1Uy?=
 =?utf-8?B?aHBzSG1jVkFOM1R0SDBwcGYwNEpXbjFCL1pxcEF3ZjArN1Ezb2pBU243U0x0?=
 =?utf-8?B?UmRaNU51Z3E5dU9lUFg2N3o4eUhNTHZNb1J0Wk9KbU0zN1BXcDY5d1JoVEZi?=
 =?utf-8?B?YjI2bjhjMWt4TW1kWkpJSG53OVVNV2FjYWhIcmE0aHFjNXl1cmY4TFd3RW9v?=
 =?utf-8?B?cHZ4L25La0RXSW9neUVCWit5TXYvQm90UjA5T3NpMHVGcUNhZVcxNWJZVzVE?=
 =?utf-8?B?YTF5QUV6THNwL1U3VmY2U3NIVi9YTHlGS2R3Z20xSHdCTlY5TktrTk52cHFl?=
 =?utf-8?B?UHFUejhXWVlmN1cvMFZ3L3VQZTJUZElSMHNRZHl0alNuVWZ4YmY3UVdYVEpB?=
 =?utf-8?B?YU82VEtJZXRnRmNMczZMbDdxSHYxa0o4TW53clNzeHZmTC9haG5YU2ZpYk4r?=
 =?utf-8?B?YURoQ01qdzB3TEo4OEYrelUyUmc4R0laYWVEVG1pcXZtaG9QbkJ2YjNES2Ux?=
 =?utf-8?B?NmY1ODBCL1lKNmJPSFJQZjRzTTRnQ2Z3UW1xL1FHNS95bGFVc0ovdy9pWlFU?=
 =?utf-8?B?eWc4RFVWczU2SXMwYit2T1pSN0xaQ3NwVURYcmhmTno3cXp1U2hjdzF3RFRI?=
 =?utf-8?B?R1dtUHFuM3F2aHRlaGV0Qk5yaE9uY0NianRaeWNmaHQzY0VMSWpMYUFMSVBW?=
 =?utf-8?Q?umy1UDGPDnbSB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDJsSjZ2UUQzdXdDUCtOL2lXY2V3VmVIVFdYSXg2dWtlY0krMTR2NkFnWm11?=
 =?utf-8?B?MUdCTXJDamNiaW1haUt1ZWQveFFFRktVbWg1MjFJYjhiMDBDK1M1WlhDcXJ1?=
 =?utf-8?B?VTVja0xmL3E3MmExRS9pU2tES1JIL0ptRmJRK002bVNtNGlSZEFabmRQZGpr?=
 =?utf-8?B?RlBmL0psZW1RSDJnVVQ0ZHZiYnh1Q1dob2xEV2hXSkdkclBSUG9PeGtlRnhr?=
 =?utf-8?B?TkdCZEVRYzJ4cGJ4QWJvakFIWnZqVzdmVDdSa1ZRRWJmdFI4ZVJZNVdjWFI2?=
 =?utf-8?B?dlpsZUU5UHFublFVTVdRVzVYV2RBQVk2bUxLN0F4WXZRSVlIcENPYlp6NllG?=
 =?utf-8?B?V0grZDZIOHZaaHQrWG1kZlJEUE0vYkZ5RUQ3VEdjems5SjUyK1BpRjIzNmRM?=
 =?utf-8?B?Rk1OUEZQdnFIQ1cvVjczK0tGK1pHM3pWN3FKYStxemxPMEo1elUvUHBnS1Zh?=
 =?utf-8?B?YnMwcENpNnlvdFBISEQxRjl3VEtPaFMxczJDSHFWWDRDeGlJdGd3N2htNVBX?=
 =?utf-8?B?Mm0xRC8vYXJwd0tWMEJPUkNONTdkVE41R2xOWFBoWkFFRHJjWlQ5TFljVWty?=
 =?utf-8?B?bzhYMEQ1dUF1K1JxV3oxS3pjSU9VYzZVRkdJZVdqeGJ4bWJWSTF2ditGRjQ3?=
 =?utf-8?B?d3pmR0w0RFVOLysrK01oU0FPa2ptNnNPalc4Z0hFbzVrd1BSK0dpN1I5MlNO?=
 =?utf-8?B?L08zZm8rSDVvNEhkSHZBU2MwSzg3UlVHVUQ1eVE3aER1YkgwWjNFTWFPY2F6?=
 =?utf-8?B?VGhtUHdhOU0rQzhWMDNic01SWVNNUU5QVW0xMFp2VnZEZjFmQ3ZKMFU3TlpE?=
 =?utf-8?B?M0F2eWJBQzVNTDFzZzlIZktxSlhDUWhBU29Jc285UmphUUhaTEcvOVZqblhm?=
 =?utf-8?B?TitZYVUxVE5icDQwdTJCcUtweFJmUVJ0L1B4ODNsbDlrNUNaMEpYRUMvOFRQ?=
 =?utf-8?B?Q0ZLTVQ5NUNxeHMwYlQycnY1QWdrNHNBb2V6S2M3QkNlM1J4Z1dDb3NrSXdP?=
 =?utf-8?B?YkZ2YkJUVVJEeHJYek84dkZ0ekhFMllBaE1ieCtUM0p0VGg3SXpBWWlsdmxi?=
 =?utf-8?B?VEk1QnMvbE9VZlhLNFFvVFpkWVNYNUExSEJhdTRIYTlCVGFack84cC9KQW5S?=
 =?utf-8?B?QTNnQnpsdVYzU09YVGdYRVpsOGRPOUNZTmV5K0pkRnVaZlJZY0NnK1JyK1hS?=
 =?utf-8?B?Y3Y1Q28zTitnbmN5SDNOdngydVFBNkVhRitoU2dIS3BkcWVOZngvaXdpSVJF?=
 =?utf-8?B?YlY4TVFKZUJDQUVrQmhKS2N5L3pOK0cvdkZCM3JQVkk5aHhMN2FqcldPMlJ5?=
 =?utf-8?B?MVJJL3ZNNnhHWUJZdndtdkJOQTlHVW1JOG9EczV2WUI1elNmWVRxOWNIRmF6?=
 =?utf-8?B?ZVZtbmZPWjRJTzRqcDJpNllLTnRRMS90bEp0YXlkRkEvUmZ1Z1NIK2ZPV2xz?=
 =?utf-8?B?bkhSTGZ0Y3hxd21MTHdGR2dsbnFDYXdybEc4WDdGK000aEVVWFFKaFcyT0Nh?=
 =?utf-8?B?MTJvRWkxTkVZVHAvanQ1UklFNmJFdE5yNnpMcWxaVkczd3laSWtEQVAwazE4?=
 =?utf-8?B?bXJ4bWZGUnJyWkdEVVlNbFNGeXRJUEhlK0RvREF2ZUhvMUZjK3h6TFdjNHN3?=
 =?utf-8?B?MVkxdFJXQ0x4a3F0MHNrZHI4SVFLUlNvTjBSaUVObGFmVTFMY0hOUlpjMlA3?=
 =?utf-8?B?OHBSRld6VlJyMFpTM2g0enNsUWYwaVo2REtnbkNlOW5JbXpmQ2FlWjhTMFJz?=
 =?utf-8?B?RGRnN1NTcDRPWHZ2amZ3TGs5TTNmdG9YNEJNWTVxamlDWjdaaVNYMThOWHdv?=
 =?utf-8?B?SG5vMUsxL1kyWjZGZGx4eWJDc1prcml6T2ZrdFBZc29QUjh1N1RUOTE0b1Vy?=
 =?utf-8?B?UlRPWFprYzhKclVIR1NjZlBqNU5RSnduMGc5a0hwSlJhNGZveHRoOTJjcnNI?=
 =?utf-8?B?VWN0OUFSOTZyR0NoSVViTFBkUTdtTklDUWdJM2cyaDl0ZUF4U05CcFpnUkU5?=
 =?utf-8?B?ZG5McFg0VS9lNzFEZ3NsMERKS3ZieWJUbG1OWkJQWGJyS2xPK1VxdFZVSVNn?=
 =?utf-8?B?OWFqWThEWGtLckZ5aEIwT0ZlTUhtYmMvVVp4Ny9HbkZzc1I5TEdIQys2bi9x?=
 =?utf-8?Q?gEwdPnXSK4g2Ys7odwOEv3mIf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08212b1f-b6dc-48f1-e7f1-08dd3db81338
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 03:18:16.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFO98UwRNTD5/lkXRDlePZXB7cqJFY8dUR2i248VoEZlaMMCUN8ihXcrfNJEm73xVTrkE718GKinDAxjbqRujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Since static_data_buffer_addr and acpi_param_buffer_addr
  would be passed to FW and OS doesn't use these two,
the responsibility of check is transferred to FW.

Please have my
Reviewed-by: Koba Ko <kobak@nvidia.com>

On 1/26/25 10:22, Aubrey Li wrote:
> External email: Use caution opening links or attachments
>
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") added unnecessary strict handler address checks,
> caused the PRM module to fail in translating memory error addresses.
>
> Both static data buffer address and acpi parameter buffer address may
> be NULL if they are not needed, as described in section 4.1.2 PRM Handler
> Information Structure of Platform Runtime Mechanism specification [1].
>
> Here are two examples from real hardware:
>
> ----PRMT.dsl----
>
> - staic data address is not used
> [10Ch 0268   2]                     Revision : 0000
> [10Eh 0270   2]                       Length : 002C
> [110h 0272  16]                 Handler GUID : F6A58D47-E04F-4F5A-86B8-2A50D4AA109B
> [120h 0288   8]              Handler address : 0000000065CE51F4
> [128h 0296   8]           Satic Data Address : 0000000000000000
> [130h 0304   8]       ACPI Parameter Address : 000000006522A718
>
> - ACPI parameter address is not used
> [1B0h 0432   2]                     Revision : 0000
> [1B2h 0434   2]                       Length : 002C
> [1B4h 0436  16]                 Handler GUID : 657E8AE6-A8FC-4877-BB28-42E7DE1899A5
> [1C4h 0452   8]              Handler address : 0000000065C567C8
> [1CCh 0460   8]           Satic Data Address : 000000006113FB98
> [1D4h 0468   8]       ACPI Parameter Address : 0000000000000000
>
> Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
> Reported-and-tested-by: Shi Liu <aurelianliu@tencent.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]
> ---
>   drivers/acpi/prmt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 747f83f7114d..e549914a636c 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -287,9 +287,7 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>                  if (!handler || !module)
>                          goto invalid_guid;
>
> -               if (!handler->handler_addr ||
> -                   !handler->static_data_buffer_addr ||
> -                   !handler->acpi_param_buffer_addr) {
> +               if (!handler->handler_addr) {
>                          buffer->prm_status = PRM_HANDLER_ERROR;
>                          return AE_OK;
>                  }
> --
> 2.34.1
>

