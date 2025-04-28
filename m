Return-Path: <linux-acpi+bounces-13337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71341A9F86A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C076616C330
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CE294A18;
	Mon, 28 Apr 2025 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HEQN5IvN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BE7082F;
	Mon, 28 Apr 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864638; cv=fail; b=kpRVAOGZ811m5m0nN3gxcgUSFt43MqV7aDLfFB0nKbIzTMrB6jqPUxhQGZRLByzgfy1jXLzfwi/KJj88Pb4p1+S1EpWDQEBDu4StLyd1fzuqB6LJB57x5kkQva/8rIKE6sQ63Elw0b5vbN1GO0TRt7xsrGUmYtXz271NXoGsEm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864638; c=relaxed/simple;
	bh=58TyTTt90dqJZfsk9f7hpdKKCe/81e85P8wDhcDJdhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eL/3U+h9VFpeKbshXattYmnNqYjOpft9lGsCOcqpbxVN+xki1EWfHKySXgr+0c/MANx5NfQUda2KVBypLbRHtsTcMw6aeUTr+qLik0717S4Sk+uT1AkDFK5EQPJx/qiMNlo+/JTww4OvG2KTx0FV21vXBmkuZDEGF66lEY/pVwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HEQN5IvN; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcoyX92wRdk+GxQQ4/0UArdasGvDmyZZuH6VnRxpeD1lj2UFb7jtMCa1ImhuwfxV/7n2KNNzBsCkp/8M/VAPbr6IKFHfMQOLx/tifeTVEblGlzLVLC40zXj4+Hc5vmKc9bNUDsNMXlLiOjA/GcHQqIJXCqNUtLO7lfbZ9vi1/9ZKzO+eILEzQQCCat7zd/PN34S6Ha5Fh1MnM5Zbrm3B734DXMBT+fxqoV5sXcekPH/g4PiWpZIzLBUs8IYrlyY4K9JTX9QBh830EOwUpxTVsNR/wgXTGiqxwkuGsU1fh77wYd68UHFVCEQgSvMtdngEX3CS5z/LZwhd+Oy/ENJ55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga3eq+uR0/Bh0kcIlUjNPAHo0ZG7hoQNA3r7EafwX9M=;
 b=Sb5TbEVgNXqteY56a1WA9+TyPtjVPn3i9ai+pYXjc7xcEAWtOsOzIoraopcwHnTVo4MBTGRVBw99cIqHf7LKDb/0ijVFZuR/XlsOEIHaYbMde2XfrDvlKRfBdVyqGIaTc2pCMRIb1vZZE3REZ92rIjKWC7XcZ8IcgKKJ9DXlqBh1wwyvDSWi0jPXn3qzJh0uHvBPmRiOX5ZiLSTOXDja9b5aHUJktHDWBkf1HqgVoC7GWnpt2POrUnhUEKcDJEGCcBIbtkz6WurbK6TaxisQ8pvvJ+yJX8Hhyrc4MpOuo8uCnJgnPskfxr4Imb9y2Vd5GNgGCIAARSQu7/dtYLl4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga3eq+uR0/Bh0kcIlUjNPAHo0ZG7hoQNA3r7EafwX9M=;
 b=HEQN5IvNBxaR5B8nd6ZT/ruzLZjHj8GYB+Hz71/VnGaFBiQ0jnRhjnsPpoFusahze7gFudCBqiQygW53dG5OdDkHptf8r18oX4Aj3sXxa7tE45fmflx2c1zAocV5QOVL6UIEqPzWchJqN2plrtizvyTGIR1A9dmXxrCf51HuOcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Mon, 28 Apr
 2025 18:23:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:23:53 +0000
Message-ID: <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com>
Date: Mon, 28 Apr 2025 13:23:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: Marcus Bergo <marcusbergo@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mark.pearson@lenovo.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, lenb@kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
 <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
 <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
 <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 95131540-fa31-4176-1338-08dd8681d4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QStJVXRpOG5ZQ0dxSUxYZG1LZVFnTE41cGJoL3JwZFdCaGdCRFo4NlhqVStm?=
 =?utf-8?B?TmZHN290dnE4N0hSMnhLQnAxRURxN1lNUGZITjBtM0hZd05aZEllZ1lxN3Vn?=
 =?utf-8?B?YnVYcy9sNnExOU0wanB2MXM1RXp3ajlqMjAzd2c1OXNmSUg2MVZkczFxV3lx?=
 =?utf-8?B?d0JCaWZRZEczU0IzY1htZUlPU3E3b3JVZjdvL1hJS2FhVDlESDM4VzhRK2tT?=
 =?utf-8?B?enUyaFd4RjU3YlJ2MHQ5K2dTbElGNGRJV2VhbTZ5R0YrWktnTmQ1cSsySEda?=
 =?utf-8?B?cHI3U2w5YzZzWDFZZ2cydXBwSUtUMVAyRGx1YzVUZ01Iais5MkJEcmt1NE5a?=
 =?utf-8?B?dmFMdm9hTm94RkorazZUZERUNWJkbGlyNWhpK25yZ1JIUkdnd0xlZjBEQmUx?=
 =?utf-8?B?WGt0MDNYWFZ2V3lPS1YzZTR2TzNnRTJPcm1HOW02cTlJQzJvRVkzZXRZOVdj?=
 =?utf-8?B?TDBGS29vTlVEVkN6Si94MzZsOFF3SmhMT3MwTjl3ZStsV1FkRTA1QXdlL2Ey?=
 =?utf-8?B?aTE0d1cyQ0pLNUpjOExqbjlScS81Ym4rc2ZnUW1iMVB6Ti9hVlpXOUdkTWc2?=
 =?utf-8?B?ZXo4SUF5NUtoVnpwQ3FCOWVuNTEydlhUMGhpS0NGT3AyM2QyWG1xeTUydTVH?=
 =?utf-8?B?VndWZFhDeFpHYW9HNGdlMVZ4a1hWMm8vQ3dmR3JvNExaQklxSmlsNG90bkxk?=
 =?utf-8?B?eGZieTl6Lzh4c0xGQ2hYSWRxamlvZnlPTWVGMGd1NEtDcXB3bzFIa3ZRdXRt?=
 =?utf-8?B?S1NodmNtSnkxeVhIQXI4U21NYW90RDJUR3dUeHMvQjlyWll0RjRJc2ljRjlN?=
 =?utf-8?B?ck4yR2phaG9NeGdEVFZLeGFQeHZCNGl4RTNyc3dPSkl1T1BQMjU4QzFsVlEr?=
 =?utf-8?B?bDBGc0hmUXdIRzhodk1ZQUVNZkxYUTVBUjg5bTNuV3prRGlNMm1aMFBncjcx?=
 =?utf-8?B?dVRkZWxnODZNd2pPZDFwRVB4RVBNd0R1T2hTUmhJZEEyWEFmbk1hUHlvUW5B?=
 =?utf-8?B?anBROGVhQWxIL0Z1UThwVVJUMld3TjdIWmVJSW1VeTNPaHV3VnFweGRkSzZI?=
 =?utf-8?B?bDAzaWNkOS9Fa2c4S0RoQllhWDZTSmV1a0JWeG1GOFdhd29vcjRxRjh4MUdN?=
 =?utf-8?B?eE1UMzEybHhvN3REMi9UaHZQTERSZWk1bGROZis5MXYrTFVRTERKUk5YUG5t?=
 =?utf-8?B?N1h5Q3gxZi9FTm0wNEgrK3lWR001ZzNObmFsQ2FsV1F1TzFHTXd4NTQ0aDcw?=
 =?utf-8?B?U0RPbFRld0pVZ1UrRDZ4bHMza0NvTlljbWtGNDZyTVhjV0VBMzlyRlBaek40?=
 =?utf-8?B?TG8wTTQyeWVocjBicmtiRENXdFpHN01XaFRLQ1RjL2wxNFFLM3JXRnppSG5D?=
 =?utf-8?B?T0phYXNQQkY1N29EV1ZTTDgxem4zZjR6N0ltTnFZeFMrNm9NYWhmNjNHczl3?=
 =?utf-8?B?LzEzQW5VUGt6VXFXaWkzV3FRV0NKYVljZHdvOWc1c053U04rUXlrMzhuUXhs?=
 =?utf-8?B?eG8weUVIcVY1MFhkUkNwaS9mS2Q5Vk84T3ZobWhSdzZ4RXBXWUFNMEkwRGVk?=
 =?utf-8?B?aWhiT2VDTnNhYXovaURNL3FIVCs5Z0NPamkzaWZVWHRUazVOZWxUSXdtdzRO?=
 =?utf-8?B?NG43aXQwT21kcDRqSUcxUjlRNkZOMjhmeWtpWUQvMUdmeVgwSHRKMCsvNDRj?=
 =?utf-8?B?TXh2U2dtWDZ1bmd2dFRKNTRuYi8wcFVFenR5bDNvQmNjYnNjTUc4RVZSNlJY?=
 =?utf-8?B?R1JJcmFETEVPN21NcENlZ1ZsWE9wNDhvSGNrbDViTm5vUEl0ajhWc1lTUWRM?=
 =?utf-8?B?QjY0UTF2UHBERncyc1RmS2Z3OEo1Ui93eDN0dWJQWDhtdGsxS3lpUlJBWDVm?=
 =?utf-8?Q?DqLLqQ5G+6VWT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGRRUkZHNE5iWmNSYWdUWE52NXlTQTVmdWZZS00yemlvRkV5V0oxOXRqK0l2?=
 =?utf-8?B?c1pVS2M2U2dtZTRYdEJ0QkZMWnM3TWJBZUU2amhCYXFFaVQ2TEszT1dvVEdH?=
 =?utf-8?B?eWxVTkkrL0g3Q1oxSzJ2dlBEWks5YVl2WXJqUTN2R2JwOVVtMFpZSDRaZTlF?=
 =?utf-8?B?bVdyMFVZSnF5SS9oOGtmSUkrNmJxZ3VjYnJ1TkVRblU3Y3J0cUxrdktrUzRS?=
 =?utf-8?B?ZmdEQ0VwcEh1dmQwMzFLTkR4MFV3OEFPNis5UGtNL3lUUEg1UVlSRnBkb09o?=
 =?utf-8?B?UHZsSllwUzBUUndHQVlRSm5sTGVkSFdNM1pwbDk5aXRtZU5KZVIrTlB5SXpV?=
 =?utf-8?B?UEN3aFhuWExKdnR1Wk14VG5YZlJUcE5acUtlc2FOQzFGU3JQTDRMNU5NNWxp?=
 =?utf-8?B?enh4SHlxbzY5bzUyN1orOGlOUVBGR2FhRFNuVVNSZnRWVk84VjJMTjd6MUZ1?=
 =?utf-8?B?YXFnay9ZalUvUmpOLzVtd2YyQU4rME83VkQ4bUwycjhOdlJnTDI5aEZoUTk3?=
 =?utf-8?B?WUR2c1ZoRW41R0JzN0diSzh6bDdRYzY0VkZxc3JTS2QvNE9CZ0t0ZThZaWNa?=
 =?utf-8?B?NGk1ZDYwWFhmbHVDNjFnR01PeGpPRzhpR3VjOWlCbXJlRGtkaGZSTWlHUzZa?=
 =?utf-8?B?UG5MVjFVL0NmR3RlakxHY2VUcEcyYlk1aDBsdGVBRVJuY1pBYUE5VzRLZ25W?=
 =?utf-8?B?TnpmMHlDSXd5NExXQ2lScEVPM0ZFbTgzdlczS3ovOFJQd2EzQWFEYmZNNFhY?=
 =?utf-8?B?K2MvYUFHa0tkdzdhcDRhd3lRaTc3MEpqZ1BzRnE3VlU0bXVENE1zNHZ2aDMz?=
 =?utf-8?B?M2ZHTHpYMktLZmVqNWRFdFhYVnZyY0hrVEZ2MndjdzgwWmExL2JZRzhFdkN6?=
 =?utf-8?B?MU9VczE2RyszMy9NWVNpbXlXdnlJcHZ5OGlSSlNLNnJwZEwwZVJZODAyREJU?=
 =?utf-8?B?ekd5Rks1dDBJK0xkWHdHNW02cXdxMlNxakg1eFoxb2pxTDYwWm9oOUZkTTZO?=
 =?utf-8?B?YUpUUk1VbXlVS1pmL1czcmlXcVdHOUt1SDRBUHAvTVBNeTZ5VkJlZXYySHUv?=
 =?utf-8?B?ZjlnbTVxQUhQMFNpdDNDb3FTQUNhSXp1SWJjUGFzck1pckk4L2w3Qk9pTVg4?=
 =?utf-8?B?YlNhNnRtMmJ3VzNMUnY4Y0tCaEhmRnYxZnZPN3NYczFhUWpUcStNNHVocytC?=
 =?utf-8?B?MDdkZFMvMDNYRWR5MTc3SFM1OG1zTnJlelFZQWl2c0Eyd3c5QThFL004bC84?=
 =?utf-8?B?emR1K2xXWFc4Wm9aMGxUc2pFb1RpSDFRTkFCaXB3L3poRGdqN3hKRWNSUmp5?=
 =?utf-8?B?a1FPY250VjY4Qm1CZEV4SzcyY0U0Qmx4WWgyMEx2YW5TM2xDY0MzRnlNTXdr?=
 =?utf-8?B?QVA5U3daWVI0ckZlRms3VTBSWE9CQkROTVpkTjBERzlGeTB1R25OZFBZVG1O?=
 =?utf-8?B?K0F3cDIzQSsyZ0N2SGVYQ09RZHlqcGJZeHMvMlp2ajRoYmFINGVtZUw1WUJ1?=
 =?utf-8?B?N3BTeXhvcWNpT2NBV29ZRzFvSWdKbDFuUGNsMGhRaVhzSGw2SnJrd3BzRVky?=
 =?utf-8?B?VlJocWJMYkpOV0RLUWtwU0FSb3UzU1hGajYxb0NNWW4vTDE0Z3lQR0x5VGF1?=
 =?utf-8?B?YW94V0hMa3hWVVVDV2pWWmZ6MDFQVXNzNFg5ODdFcUpZSmVKdEFRNk9GaFpC?=
 =?utf-8?B?QXdKdnYvZEdiSEJVRDBQcHdPU0hmUVZHY1hLeW5JS0lWK0R3RksyTW0ySVF2?=
 =?utf-8?B?RVpBTU1TczA2MnlHS1FFZ1h4Wmh6UXpGM0ZUYjhPS3dic3hlMXc2ckpUam9y?=
 =?utf-8?B?b2F6RzZqSHgvUEVRN2U4d2RpUkt6Um1rcis4ak9mZGhmOVJmZnA1WjBRSWZy?=
 =?utf-8?B?WjlhaEhOa3BETkpIZVYwbXA5dnpUVDdnMDQyUnlPSDk1bXMyM0FmQ3ZPb3ZJ?=
 =?utf-8?B?dEc5cWhFUjE4TUd4Smp2MWVVaXY5ZHRxK2dhYmNjTUZqNDNzOEpnZjh3S0lN?=
 =?utf-8?B?K0NadFByM0VML1duN2JMUzBDQUJJbmo3WTBvMHlGYjNJWDFLcjZzRnlRREdV?=
 =?utf-8?B?L3JIUWtWRkJUanFheDliVGV3VVFnNExxeEcydndobWFmclBzaHZWWFp2TUp4?=
 =?utf-8?Q?OFbZcE9g8Ui/sUhgIeoyKH5ld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95131540-fa31-4176-1338-08dd8681d4bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:23:53.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHqREvStcCIU6FW3YcxW4grY2rdnIpDrKzDiCLydneiPe/0v7PGkupEFd0uMogQBdpZiaFdzlGlDrMBmUhGIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On 4/28/2025 4:51 AM, Marcus Bergo wrote:
> Yes, it does.
> 

OK thanks for confirming.  Considering your finding with this patch 
you've shared and knowing there is a timing dependency that delaying the 
next s2idle cycle helps I do wonder if we should keep exploring.

Rafael, do you have thoughts here?  Specifically do you think it's worth 
revisiting if b5539eb5ee70 was the correct move.

> On Sun, Apr 27, 2025 at 11:06 PM Mario Limonciello 
> <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
> 
>     On 4/27/2025 1:34 PM, M. Bergo wrote:
>      > It does make it work fine for me, I saw the clock/timing
>     interference
>      > and this sane this problem for Lenovo as well.
> 
>     Huh?  I think you have a typo; but I don't know what you actually meant.
> 
>     So you're saying the timing patch helps your system as well?
> 
>     Thanks,
> 
>      >
>      > On 4/24/25 11:11 AM, Mario Limonciello wrote:
>      >> On 4/19/2025 1:03 PM, Mario Limonciello wrote:
>      >>> On 4/19/2025 4:28 AM, M. Bergo wrote:
>      >>>>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17
>     00:00:00 2001
>      >>>> From: Marcus Bergo <marcusbergo@gmail.com
>     <mailto:marcusbergo@gmail.com>>
>      >>>> Date: Sat, 19 Apr 2025 05:19:05 -0300
>      >>>> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD
>      >>>> platforms after
>      >>>>   suspend/resume
>      >>>>
>      >>>> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen
>     1, HP
>      >>>> EliteBook 845 G10)
>      >>>> experience a CPU frequency limitation issue where the
>     processor gets
>      >>>> stuck at
>      >>>> approximately 544MHz after resuming from suspend when the
>     power cord
>      >>>> is unplugged
>      >>>> during sleep. This issue makes the systems practically unusable
>      >>>> until a full
>      >>>> power cycle is performed.
>      >>>>
>      >>>> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: Fix
>      >>>> acpi_ec_dispatch_gpe()") which restored the behavior of
>     clearing the
>      >>>> GPE
>      >>>> in acpi_ec_dispatch_gpe() function to prevent GPE storms.
>     While this
>      >>>> fix is
>      >>>> necessary for most platforms to prevent excessive power
>     consumption
>      >>>> during
>      >>>> suspend-to-idle, it causes problems on certain AMD platforms by
>      >>>> interfering
>      >>>> with the EC's ability to properly restore power management
>     settings
>      >>>> after resume.
>      >>>>
>      >>>> This patch implements a targeted workaround that:
>      >>>> 1. Adds DMI-based detection for affected AMD platforms
>      >>>> 2. Adds a function to check if we're in suspend-to-idle mode
>      >>>> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD
>      >>>> platforms specially:
>      >>>>     - For affected AMD platforms during suspend-to-idle, it
>     advances
>      >>>> the
>      >>>>       transaction without clearing the GPE status bit
>      >>>>     - For all other platforms, it maintains the existing
>     behavior of
>      >>>> clearing
>      >>>>       the GPE status bit
>      >>>>
>      >>>> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7 PRO
>      >>>> 7840HS and
>      >>>> confirmed that:
>      >>>> 1. Without the patch, the CPU frequency is limited to 544MHz
>     after the
>      >>>>   suspend/unplug/resume sequence
>      >>>> 2. With the patch applied, the CPU properly scales up to its
>     maximum
>      >>>> frequency
>      >>>>     (5.1GHz) after the same sequence
>      >>>> 3. No regressions were observed in other EC functionality
>     (battery
>      >>>> status,
>      >>>>     keyboard backlight, etc.)
>      >>>> 4. Multiple suspend/resume cycles with different power states
>     were
>      >>>> tested
>      >>>>     without issues
>      >>>>
>      >>>> The patch was also verified not to affect the behavior on Intel-
>      >>>> based systems,
>      >>>> ensuring that the GPE storm prevention remains effective where
>     needed.
>      >>>>
>      >>>> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
>      >>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218557
>     <https://bugzilla.kernel.org/show_bug.cgi?id=218557>
>      >>>> Reported-by: Mark Pearson <mark.pearson@lenovo.com
>     <mailto:mark.pearson@lenovo.com>>
>      >>>> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com
>     <mailto:marcusbergo@gmail.com>>
>      >>>
>      >>> Great finding with this being a potential root cause of this
>     behavior
>      >>> (at least from a Linux perspective).
>      >>>
>      >>> Although this helps, I'm not really a fan of the tech debt
>      >>> accumulated by needing to quirk this on a system by system
>     basis as a
>      >>> bandage.
>      >>>
>      >>> At least for HP someone said that this commit happens to help them
>      >>> for the same issue you're describing:
>      >>>
>      >>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-
>     <https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform->
>      >>> drivers- x86.git/commit/?
>      >>> h=fixes&id=9f5595d5f03fd4dc640607a71e89a1daa68fd19d
>      >>>
>      >>> That was surprising to me, but it must be changing the timing
>     of some
>      >>> of the code running in HP's EC.  Since you happen to have a Lenovo
>      >>> system does it happen to help the Lenovo EC too?
>      >>>
>      >>> Mark, comments please?
>      >>>
>      >> Someone just reported that the timing delay patch helped their
>     Lenovo
>      >> system as well.  Can you see if it helps you too?
> 
> 
> 
> -- 
> 
> 
> *
> *
> *
> Marcus Bergo*


