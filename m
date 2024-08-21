Return-Path: <linux-acpi+bounces-7759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F7959668
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B86B286CB1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C91C3317;
	Wed, 21 Aug 2024 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBdxPhzk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99411C32F9;
	Wed, 21 Aug 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226931; cv=fail; b=ghVfWokg66jHyKYQMF9LewnTn0seshbKH55siLEEzFfLQccwDvdYKanBpOTe61vd9feDeZ0HjeUnB0KSsgkOGDcjXPz/84W8P3bTC0BQN6wJVZMXDCuu7rUiw1zwNDdzi/khjOaTASbrspgh1XCgVxs8/iXUf97SlIcCf/DOnus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226931; c=relaxed/simple;
	bh=k5A8QZt6dtpCIMwXvD87hhM6XVN3riDiDn+QNnreX7o=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jDEH4IW4UjVeuVvAd2JaSq5N+/64E7Eowy6ocDCmKJ/G2U3AAETx8nAz02//IUiylLoizo0LxIArHlQ2HpQmdYHi/U7TyQHWf67ygbzdJaxFaKdJLsHsFr+e/kwdbeXl1IA9OB+IrrVjOaqsAIMUQNPy8InWCbNKoMDMhIEhYgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBdxPhzk; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgZ05iCZegw/czv/IM7ceexDEkmTK3GwyitcM3NZZhi4aoJRS4gGOHymGwdJPNz+k0Wj7LWXcPwQxnrXnlP5Gv+thKNwMVtFimPl2xf4oTeSKFHy84MGjBHDflNC5tRKBNIZl7mD75x7RTfUJpum3AFfnqeWnBIzs0XvYePfDS7FRMEdR2NVbuQ5T2VmeUW98SLlZ4fE8+d2oH4CSgO8V5ssL2oMNrfx4acF/tyNsi+ZofmfxE8Gt36Nl0cfh7CdCh3FipayjWg4tKFA9JRz7SPVSNAD7JAEfxi8lsNa22v45JLCpctAEArnnUO+cPtjM5zLF/cmR5JcVMPiSsMZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5A8QZt6dtpCIMwXvD87hhM6XVN3riDiDn+QNnreX7o=;
 b=DNE36Mh98SvgIUPkO6hifnhtJCD6YJV/2xcxYWMb/Q5rPu2OQke5lBkFG4J7Yfd0X8jz1oIcf5XppM6j4tQBCKAcEwffApNTUITbp+VYg5fNhv6l5379xOeHVYw+hm5/XU6p0AwavBWYpivUMQjqk+nNTl69RHKnitS1XApgAGRIYbWPWZGZfV2fLMYwh+nHmgwqhhnc+cuFnfKnve6NOsRSL84cvk+ciYVediw9jo0Typ0Yl71zcsvxFcR8BSxk6vHlKZoBcJuV0QjTLyPZ39El4k1fxdUqpXxj/GQxAi/i0rE7GHbLMeNTL24Ah2oUQ7DSHX+Zh7Xg2W0uZLnb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5A8QZt6dtpCIMwXvD87hhM6XVN3riDiDn+QNnreX7o=;
 b=mBdxPhzk80ZQ8g+FKegM5rNciNTUh6mnha0+Nrgx/jmF7hU5x/YEy5gG2ozUoYvDwzt6CyJhrGx9K6bw9OR2Ioyk8TdBw/a+TOHd25bIDLktMuIXe+WV4L297k98tgbPYozD/4LrdqJF64J3OempSeje1MPVN4oQeFZbl7CHdwrCBmocxZ38/ieoQ3C/zpeoIzyGaPHkLeun2aWh5qnbRBbqcXqs/+xcIpz+JAZqxAdUolN6xJQ2w/9YfAkMKLKedGLJN+Orq4YgNnsF0XtaflDVq5VebLXatbo+Q7GrhWvOMu9X+Txl6X5S4MNLk/sNXfyykN+k1qyPHibU0EApRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:55:27 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 07:55:27 +0000
Message-ID: <29052569-fd2f-401f-ba48-1d7c6d00f207@nvidia.com>
Date: Wed, 21 Aug 2024 15:55:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/prmt: find block with specific type
From: Koba Ko <kobak@nvidia.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240801014853.1594699-1-kobak@nvidia.com>
 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
 <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
 <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
 <519e8e00-cd82-485f-8871-81fb703c7592@nvidia.com>
 <13f458859adcb75d0930f1a76d7c0e2f74f5e7d5.camel@intel.com>
 <a5580488-afd1-4c2f-92e6-e42430d61ea2@nvidia.com>
Content-Language: en-US
In-Reply-To: <a5580488-afd1-4c2f-92e6-e42430d61ea2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c880d5-04da-4eab-8198-08dcc1b69e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWRaMFJFK0JMVEErbGljY3V1TjJnVldiYXYxbjhQTEpWNkVYczVMUTgrSVB4?=
 =?utf-8?B?TjhDK0Ziek9NcHdzcTZGcVN6dFdJcHBsSjBFcVREUlRZNzR4SkhqNy91cDR4?=
 =?utf-8?B?NFh2VTRNbFpHV1lOWVhDUGpWZnNjM3kvUHc5K1lTeWVBTlpKd05lRWdQNkI3?=
 =?utf-8?B?M3NRZGU3YWpoZkw3QVNnRDBmZ1lKdUYxMXNabUxIT1BvaUU4YWNKUXpZYyt1?=
 =?utf-8?B?aldxWHB6M3dBeHU0WVNDVUJLbzkzbEI1VVgyQ2hFamNQU0d1b0txRHhXUisw?=
 =?utf-8?B?Y09uTkZpN3YvaXdSbE1kMmE1WGRoSUZUZG9SZGgrbnpnZUk3UEltQm1qMmJn?=
 =?utf-8?B?UHhuVWZlaVJxVzR5YnpwV3JSVG5WYUV2a2lUaTNoR0d1dlgreU1ac1VsUzFr?=
 =?utf-8?B?enowQ2FPeWdkSGg2Y2lUbHAwTlNBNGx5Y1dHSHZQd1pLN3d2STNaNFkvR0hI?=
 =?utf-8?B?NkhLeVVQamlWUmxNOU5PZGNLUlJpNEJvK2ZHdTRKQzkrMlZsQUNRWjZvOE1t?=
 =?utf-8?B?WDc2Zm9BZE81b0x5N2YwMnVKeU1CeWlCc2RySzVFTnUzbzcyVUpRNGhCU2VD?=
 =?utf-8?B?Smpnb1VKSzhuNmhvUUVlWEpuTTRKdCs0OVZFMDUyV2U2OGdkRFNZaVBlQnY4?=
 =?utf-8?B?clVwQ1hrU09PUHViR0tNZUJjV3duUXYybDU4VGtMRmpzMEFmaDk4RFIrYldK?=
 =?utf-8?B?UGhzN3VPeXlqeUQxZ0ZKTzlGbXJZWVc4OExPSUYzMmcybkNRVGJ2SjNTbzNh?=
 =?utf-8?B?ZGE3UTh3NjRReTRWY3ZpQ1p4bTJzV2R0elBoaHlyY1R5WGJnVzNCNzFhSFJW?=
 =?utf-8?B?SE9BZmxydjhFdHZxUFZ0MFl1dVM5MTBLaW5QVjA5dGJjVkhzVWJlL1ZjLzVu?=
 =?utf-8?B?c2NYL0IrTTJ2QUt1ZHRnNlQ5UmE1VmtEL0puaHpSSjdNcGVjZzZ6Y05kQ2V5?=
 =?utf-8?B?TzlRM1Z5OEpselBvdWZ0Y0w1ZE5lZ24xSVJJS2ZCRVJGeDJJTmtTTy9xREs1?=
 =?utf-8?B?QVRtTGV1aTlwKzBLbzRHZERLVHJXdDYwVUJQeHhZU3AvaDZucnhycWNJRmg4?=
 =?utf-8?B?RUU3U01TK0hHMUpQVG1Udlo3dEQzWjBBVDBoRWhiWmhDQzJHL2t4NlI0S3JP?=
 =?utf-8?B?RGY1czg2ZktPLzJLN0dzNVBaZ2FGeEdkSFlSYkY5ZnVUQ2VseEpRSGhnaXc2?=
 =?utf-8?B?V3dRYWZqUnZwSmZHejZIM0l4YmM5SmZ0dFcwUTN3dGZtdXE3c25uaUpLWXRD?=
 =?utf-8?B?UUVtaDRVd3A2S1VuRVB0T3JmWTJWZWZpMlFUZEUwT1JnUWUzYWtpRFg5d0Fu?=
 =?utf-8?B?NVFCdi9WWVI3SG9xaHJScGg1dDdFSEkvTzFCUWhodk1QVU1vdlI2MXlFNmJQ?=
 =?utf-8?B?QzIvTU5OREphMVZrSFlHdjhnVk15d2d3c2pRbUhwWkJqWklnaWFCRHRUTzVR?=
 =?utf-8?B?MDBnaGpvTCt5NHcyRnE2dG9Jait5S2h6aXNsQ0l6UFFMVFhNRitxZkdTZTRQ?=
 =?utf-8?B?Y2FjbWl0MVJnTWhQNkt4NUlxUkY2THhmMytZRlQxR3I2Umo0dXNCSkQ2NmVk?=
 =?utf-8?B?YnJmWUIwTWx4OWpLb1hSY1o0Q0VKcXpnbFNJRFlibnRnZU1CODNhbll4NGM0?=
 =?utf-8?B?UklNQUdXM2h1SjVkbnJtMkF1RTBBMHJ4RlZIMVI3bk05QkFlN2dtTTkwN2Ny?=
 =?utf-8?B?OUlwcGtHWjM2eTcwT3UzWi9jSkFPQ3ZHRnFOTDRnRlRPTFlMVjJoUllFenlZ?=
 =?utf-8?B?eG11UjJ3KzRiOEt6T25hTGEzWHpiQTF1aUxwdXZqRytxbHd1NFZGSlNWdTg2?=
 =?utf-8?B?VjhwNVE0Z1VvS1NpNlk1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJ4UGsrZERVTjFYYjdXZHdmM1hydTNKY09oOWtvYUxiNEE1akJKQ0k1WkJU?=
 =?utf-8?B?VS9sYi9RSzlwSkhwanJ5WHVWYWd6UjZyVkQ4QnpISWpxTTdYdnB5QkNDTHI0?=
 =?utf-8?B?bitMeWJKcCtTRHVhQm5lQ3JjUk1vUnF5Y0hCcExtZHNDbmpBOFRsT1kvWEhM?=
 =?utf-8?B?ekk3eElvQlF2VWJGejlwdWlzQ3ZqalVmNVZ4VGxQdHlxa0puYWZQR0FpK3h6?=
 =?utf-8?B?M05BUjJ5V0E2SGV0bHZHYlRINzlBNWx1cllMK21Qd09oZFZ5dEo1Njk3S2Zw?=
 =?utf-8?B?VmVWdUZSeVNzSW5QcXZMNVhjeE5FQ3dwaGYzV0w3L005a1JBUnR3YWIyVXhj?=
 =?utf-8?B?NllRTmlDL2E3TFdiR0dkeCsxSmVBcGx0V3d3bGlNTkpIYSs2a1NWVVA2T0hk?=
 =?utf-8?B?REsxakEvRUlPWDcrZ09SQ0tGWks1ODMrd3Z6OVNVeDI3eWQxSzBvTEd4cyto?=
 =?utf-8?B?V3Izb0Z5RWdES0ZwMG41RDVseEhkSlk3WXM2TVlFN1ZXSy9pN1VtbEJ3N3Y4?=
 =?utf-8?B?bFNySFVCcnRjYXExZ2ptTEFWZUlKTUc2THFBaFZBaUFzT25ZSnI5Ryt0YkY2?=
 =?utf-8?B?VDEyVk5CMDVNZ0cxSForY1hZQ3VuZzhhU05HMENyQ0hoekE1Q3cyNHExenh6?=
 =?utf-8?B?RUdPcG4zcVJWdDRHd2ZxLzU3Qi9aYTdFUEVNL2N5czNLR3lSRTdqaEcxSWFz?=
 =?utf-8?B?MU9QSXMvV05TaDk3ZCtnd3BEdFZERUQrUk0xVjFpNWVkTEU5Yy94dnovMHI2?=
 =?utf-8?B?OWduay9FTUdzU3UyMkdIcjZXTHY0SVNoT3dCUVFUaE9sYi9qUzNzLzg5QTJi?=
 =?utf-8?B?aHJLUXBGRVQwNllUNFFoaW80eHRPb2xzbnpUQmJSMk9WbVEySjNJQkRPampa?=
 =?utf-8?B?OFc2a3R2VkhjV2JWQ29saXAwcWVaaUxQZWtNRE1PWjJ5TzJtU1ZhVUtvTDNN?=
 =?utf-8?B?ZjQ1Y3g3NkhrZk5aaXlmSVpHYnBzYkZvZjB3Y1hMTlkydFJIRDJlbUFtbEwz?=
 =?utf-8?B?K2ZYMGNjQUlkMGlvclFuVDRnaDcrZ3loUU5ta1dSR3RtT1JhZzJSVUIvdnM5?=
 =?utf-8?B?ejZVTVpHMEpndTVEUE5rcCs1L1VYMUVHMytELzlobDFSWFpycys4L09HQys5?=
 =?utf-8?B?VlU4WWNGcG1pdzRWSUlxYkJSNlJ3NUlBbEVrREZITUg1b0lEc3ovUzMySVRr?=
 =?utf-8?B?QXVpVXV2blJzZUphZnA5N2htNG1zbUxkSEp1NVMrcWJybDlweUp0MnNmVXUx?=
 =?utf-8?B?OUxIeDFjbE9zSk9WL1F4WkNEQUNQazdWclJ6QWc4Yk9pRlRwZmpmMmFPSkJ1?=
 =?utf-8?B?SVRxMFI5UlA4L0p3REh5TENuSXJCZW02a3QzY1JvWnRBMlFmUlBmS3NvSmh0?=
 =?utf-8?B?Mmd5bUZ1c2wvME0vVlpTZ29kS1BJUmludnJUR0tOSlVDN1BQVnYwZDg1UzJ2?=
 =?utf-8?B?ZTZkOVlYR3VpZ3krVkM3WFNjYzY1d0hBNEZZWFY0S3oydFVnalNUa3VVMWk4?=
 =?utf-8?B?T25vKzdXRWFVbDdDT2tDQzlOWmhvTmViejVPa052QjRweFo0RVBxbkFxWjBp?=
 =?utf-8?B?bkwzcEJyT21HcXk3V0t2VFo3TXJ3TUsycjkzYUZ5OG81OGhLd3lLQUVCYmRk?=
 =?utf-8?B?ZUltYlB4WHNRVDRjTjdoSWJlM0dJL3BmeHRxWGhFVmV1R0tpbjRpdFdRMkU4?=
 =?utf-8?B?RlBlcGl0a292ZGRGZVZrKy9UUE0zOU0yM3NBNTZvazV4dzNrcCtGZ2lrY0Ju?=
 =?utf-8?B?VVBEM1N0dWZsU1R6MGZTaWl1SmVSR0tKK3EzengyelBDRFkrSXJkYm9hbmlU?=
 =?utf-8?B?S2o1VGwxZnAyM3dYWUdoc01yYlpyNGZ4VkREL0p2eWxCd0ZVV1dqNzRhdWRz?=
 =?utf-8?B?bVBPUEZmOS81UVpQRHdYT1psZDB4ZVlKR3pHdGlDK1g1RkxBWWZsMEtKSW1q?=
 =?utf-8?B?aXVrczYzdFJhZkNjc3JBdW13eVVkRVRKS1Bub3NNeGVFZktSbHc5M2E0UDR6?=
 =?utf-8?B?WDRIaFNnN2VZOG43Rmw2NC9Ib3FkRnEyZDlTMG5BOGtGTHRlZGFhMG9wMTFU?=
 =?utf-8?B?R1BOVWJtSEkwTDByb3p5VldxTTVEbTRJbitnNy8yK1ZGaFdXQWMxckRBcjY5?=
 =?utf-8?Q?m8vrXiB0V0MiNOZVtoZkBOcVQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c880d5-04da-4eab-8198-08dcc1b69e92
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:55:26.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr+OCLtPirWk8LvFyJVs3vzqHzNxeYpbWBUd/0ipsziw+3ltwqF5+JVV6AwYtxjZWvsYf7bDJoG1i7VxUChwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249


On 8/21/24 15:03, Koba Ko wrote:
>
> On 8/21/24 14:48, Zhang, Rui wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, 2024-08-21 at 14:36 +0800, Koba Ko wrote:
>>> On 8/21/24 14:33, Zhang, Rui wrote:
>>>> Yeah, but I mean pr_err() may be overkill if the driver is still
>>>> functional.
>>> how about replace with pr_warn?
>> when it fails,
>> 1. the address space handler still returns AE_OK (is it right?)
>> 2. I don't see how PRM_HANDLER_GUID_NOT_FOUND prm_status is handled
>>
>> So, if it is a critical error, we should fail the prmt probe
>> immediately.
>> If it is not, we can let space handler returns AE_OK like you do in
>> this patch, and in this case, even a pr_info() is sufficient IMV.
>>
>> thanks,
>> rui

After reviewed again, I think it's a not critical error here.
Even the current handler fails to get VA from efi_pa_va_lookup,
the next handler still have a chance to get VA successfully.
Block the procedure is overkill.
I would like to use pr_warn because pr_info may not be enough IMV.
How do you think!?
Thanks

> Agree with you. it's worse to determine the failure on another place.
> better way like yours, when get failure,
> just complain and block the procedure in the scene.
> also will modify in the v2.
> thanks
>

