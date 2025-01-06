Return-Path: <linux-acpi+bounces-10358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D7A01E33
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 04:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727263A532D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 03:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9D198A2F;
	Mon,  6 Jan 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tpbtAy6u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFE15B547
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jan 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736134326; cv=fail; b=fmnje7tt7lnZ4VPM5r7IuZkhhor1JRu0toWRCekZpK04cJKOS7xvbEN3aDPn6G1q55Pbam8xi68zpbUMaaZmaBN4YjE9U0mBUMdtTgGE4QU4eo3Ur4kxqmVWQQT2fWG+TSWHpuHncXShH5NbeqliFzP9bKc+BaYqUELQoiYitHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736134326; c=relaxed/simple;
	bh=qvqsPP9qi6yCOYX301TAURrNT3nXX4IjPxodf6VLR9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=InkksoKJa5HyBmrhVZgFcI2AcTI/eINRsJ1S6Vjuj0JyM9f779bW8bZr3R6SOoI6E/oshZbIzIC8EI5AMs2OqOjXlUlP8Kk47e1AGeQg7lzmAL+rVTMo9ucmFMzGiSyCghRWbqf6Z+ONfsl7z6RrQ4aJyGJGRdNBaHUSondbjA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tpbtAy6u; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oihEtzr4Rt/maaMTr/CaJu7XA2Gz3QrCsemCL69m7uHzkiUldsOeRt2CpSLSoNCmfNC841KY/6Yh3vQiTJsoWxKAq6zZhcZFlh/u9qIcRjxmwAp+uBnWnVfWoUT2Ik1S2XRS6yVDbaWF7MwRIa3kl+ITxdvq5K1YgG4DVPJkeW2f3UXzQjZZHOmeFngo8ga8lgnLDi1BIvpNxIu3cGkpVcfvmq8HTjv5K0UbWhaKfJLg6PY7lY+uvyYQ8uhC8L9tHtL4XPVgM3Of4tmJ7oqR4UMpNEFpKcevDBll1445XlKcxnuZ+RCa8LMymVzXxMPDd+SmR6rFLRF6ljucuY67aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ8JpWjRjUIL/XuGtWUWngw9mNx0y/yMdjYUz237Tts=;
 b=VIha5oFP4THsF32i9u/tAUcVAGAGRTKGB58reFo9mEZDFcplM7sJImA7H4LecHxX6EijFP+BYRbwqJpZ20K38XiHdJDfoi75wkFQj9BjGeo1nTQExeo1HAKxiDJtjCxhTyXvCPCOUf9KEm6uNwaoUYTuRCA1oDuciFd+zyCgW03yeXmfyaEZNoe6RH8FmGK57EiBrncIr6mFe+VSKKYXUEfynqb6ZjVtiqERbD5saANjof3qlJ7+eNX870rhiqvLZocvsg1OY4blI1nrXcSXd7c6xD9urqOe5FP0rO8FQALyMjeC2RG27VjmVqibTaEGClWFRcX82JQ65NHERJZJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ8JpWjRjUIL/XuGtWUWngw9mNx0y/yMdjYUz237Tts=;
 b=tpbtAy6uSX2gG17dWAgurCg+X/XIjJpSSjK4Kqq07i0MKEzVEbWIr/VgUuUFHHvVCerqKaJ7Lc0MhaYnULKang/SeKoUggRvXHfmcmgyVrQceYQiUy+7IH0mUd+Ah/YpfG2myzaDcnIk+hTXpb/AGFfz3zQ7fqXI4lNuKp55z7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Mon, 6 Jan 2025 03:31:56 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8293.000; Mon, 6 Jan 2025
 03:31:56 +0000
Message-ID: <92c1b02f-d9ba-48a1-80fb-8edd4addba8d@amd.com>
Date: Sun, 5 Jan 2025 21:31:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: acpi_dev_irq_override(): Check DMI match last
To: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>,
 linux-acpi@vger.kernel.org
References: <20241228165253.42584-1-hdegoede@redhat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241228165253.42584-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 0659686a-3e34-4da9-f8ee-08dd2e02abfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVVZU3RhVGpWWDhwMmVwZ1o3MjJFM3dsbUJrUjZ6R3gzYjRqaExmQjZWWlpp?=
 =?utf-8?B?bW1wZWVEYWU2YldlS1RNTGZTSVJSWWFBNDN0a3M5S1o0aW4rYXFlVzBPK0Ru?=
 =?utf-8?B?Ty9zMlJtTDBBRGNYcnFBWEVyM1hnMTVLSmlaSFo3WTNPUGY4YzRSc2doWTlY?=
 =?utf-8?B?aVpPNWZIRC9DeWdkTFRFRXArS3NLcU9raHlVd3YrdVFHcDR0dmlwVjNJemcy?=
 =?utf-8?B?Z2Y3YUJRMndWWUY1U2dYc0h3VzFralg2VEY2aUZSQkZDRHNoNlBFakFxMmNO?=
 =?utf-8?B?RUg5bC9Jek41cEduUHdUcjZIRHBIYVc0RStMUkxVMDRBN3gzNjJ2OTZvNlBo?=
 =?utf-8?B?ZFlrbXg3cjlxaWNONjE0d05QTGtVUHN2bHg2M09melJmNGpKMUJnY3JDZTFX?=
 =?utf-8?B?eDZNaGJ1ZGk5cG9Ta0tnY1djelE3T2luSVQ0Zk9JZm90bngyeWszc1l3VmZS?=
 =?utf-8?B?Vk1aeE8xUE1KOFZGdVIvd1NFVFhxT2dFMkhKbjdpc1dhQ2g3aURNUDBTeDcx?=
 =?utf-8?B?V2pQb3VEd2UwQVgyaWVMblJ2bTRSSElMcC9ISE9aVXZYeEM0b0JKYzBOMC8x?=
 =?utf-8?B?emtsWDBkamlxRGhpRm1XeFNnZ0VQSTBVcWEwYklOODEvSUVsYy9XSFREd0E2?=
 =?utf-8?B?eEVrQzFaWDVGZXhmem9NdnNVNXBDcjQvcTBFU0lMWEU2cVFCV3AzOVRsQ05n?=
 =?utf-8?B?NVJMQlhTa1pCZzgzYnVGZUhEUTBOWVRMQ2huVFUrT3Q1UE43OEtMRTNLRGRv?=
 =?utf-8?B?VVcra2hjeXUwKzd2ZHVQZUpVYjNhdEc2ak1QVTBrd1VoQnk4dTNOblFvVlJN?=
 =?utf-8?B?S0NvZjFhY1llRGZZMUZjVVNGU2N3OXVyZkR6OXhZd21jUHJCK2NJK2Y0eEx5?=
 =?utf-8?B?dC94U2wwUVI5YkJweFFYMXlJaTBIRkZWQnZZdHFLK0R2VFN6K1dZNkVIdlh5?=
 =?utf-8?B?NWlTRG1OSDlDN05pcTREU2FJTWtZSHVJemFBbE00WDduV2VtODRIRDdoQ29x?=
 =?utf-8?B?ZDhUenhDelFLZmt4OXJYUlNMMFFYaXFIYnQxVHQ5eHd5cHBJbXVGQXArSU0y?=
 =?utf-8?B?WTZ5UTFPSm9yRlhRRXU0dW1jeEZTL2Y3WkRZZnBHWW5WdWlOVE9FMld0aWR2?=
 =?utf-8?B?TkNmYk96UHRMWGIvelRCZ1NjRnhydElScExIT0IxazN3cSt4c3J3Z09YaHhh?=
 =?utf-8?B?Vkw1R2NaOGcxZ1hEdDBQd3hYaVZOcDkvM2dWalJvaU1TWWZxMGpjVk5nUzhP?=
 =?utf-8?B?M1FCRmVuOG5jYUt4MXFnUGxFbUJDUGRNdmdnQmZHL2hsc3A0cGJYVkVKVnRo?=
 =?utf-8?B?bFZxbXZoV2VQbjgrcGpKOW9qTW5wWjcwM2g2bTAyS21RV2h3UUdUMC94dm9s?=
 =?utf-8?B?QjV5SlJ4RWNDbXpNcS9iU2xHenNaMEtadk1wVHpEZTNDajdXN1MwOVpNQ25R?=
 =?utf-8?B?Q1RsYXp0Rit0blVHMVhtZW5zVHFpeXF0L1prdTVWektVRFc4c09LYkdQbFRN?=
 =?utf-8?B?eXNvSnVoYW0zOHFDOHN6d1c3YnFML2ZwdVZLYURuYXFEU09FTW5JVmlkSmwr?=
 =?utf-8?B?elRzWFlmMXl0aGZjUzNZbzZoWERkUzVEYXYrK3JYZTBaZGNJc1NqTzZqZEtE?=
 =?utf-8?B?SmQyWitpdUhZTWlLT3ZEK3hoRVM1N1RIZkhKQ3lOUWdxSWhzWWorc1kvRFFW?=
 =?utf-8?B?WEN1c1Jadmo5cFFOUkEzV0w1UnZXOFlHUlhyTkRMdXNRSjBKZnNRcE9jRVd4?=
 =?utf-8?B?TmNrZ0RscC84ajMyWEViV3FRaTl0eUhISWNJNTl0bndPbTVGSDZPbm5EZ3ZL?=
 =?utf-8?B?V2ZBWENiNG85OFY5eFJMTlQySXZ1NUVBa0dhMk9NVVVFSVVFTjNLOVhwNlQ1?=
 =?utf-8?Q?FWb4kTMtekXwp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhyWnU4akh1ZGZrSGFuSDFmMGhBU0VjdndGZlFRMjJia1JvUkppWGpLM3lI?=
 =?utf-8?B?TzM4K3BYUUxUM2UxVkNlSW41cHdMdHdDd2VOSkg3elJrd3pnTHo0NmZ0ZlZ0?=
 =?utf-8?B?dmhKTFlZOUs2MTBDSnBodGNpb3p5UjFxRW8xNXo4ZXhUYjRZbGd1djl4UzhF?=
 =?utf-8?B?M1Z1YVBvSHhFdFlYam9UekVzeWVaMDRzWFNzeVB6T1RoZnpZSDlRTXJKK28w?=
 =?utf-8?B?aTRFQ0NjbXAvMTV2M1Vaa21kbkExSXpoRTQrVHBMS0lUODA2d1pqeVc3Wmdk?=
 =?utf-8?B?RVppWVN3eGhTVzVvRlpuWlRYQmc2bWRNdWlNTG9MWlppd3lTb3BLQXNxWHYv?=
 =?utf-8?B?cFZlbnNhdnlla3dURzA1WFAwL0dkY25mZXAxcUF6YWtHWFZVb0Q4TE1ab3J5?=
 =?utf-8?B?dk9CYm43YnRzZGJuZWFTU2VaTlhjZUlwTmhvem5OU3FYQTRETUpZd012cFN4?=
 =?utf-8?B?N3A2TVpTMWE1TzB0R3lwSXltZmlmdG9MRGoyeVovbnEyY0h0QWVzYkx6WWZW?=
 =?utf-8?B?eDhzblFvZk9SMGZRMFBTU1dLbU81cGszRnVMOS9mYklVN08rQ2RvaVlyNG5m?=
 =?utf-8?B?Z3RYT3F0bkZTZ1JZQi9LK0FjbXEvaWxab1lPclVuOWZ0Y0xhT1U5djVCa09j?=
 =?utf-8?B?RWZ6eHVtMUN3ZXVnbHYwc3FvSUpxT1lUazVGQmNDNUw4aTVEMFI4YzFIcHM3?=
 =?utf-8?B?TzdPcjZhOTRKbkV1aTRpbkRCTTBZdURaQisxRy9pd0todnRzb010Slk1ZHNL?=
 =?utf-8?B?T1VRSy9NNzl6aWxUTVlNWEgxME1OZDRwbVlqZ0RRRCtRV2tHRGNRNkFFbHJZ?=
 =?utf-8?B?eERmZ2M5ZWpqTmQ0RitYNi9kSW1Jc2lYRzY5QVI2T3pIa0FQTzV1RzZGWjZo?=
 =?utf-8?B?b3dsei9XdVRENUtiaFNhYVlIUnN2aUlKK0ZDalNySmVDenNWL3JKblh1Q1Ro?=
 =?utf-8?B?djUwRDREdjZZcHd3LzBBUHFuY1lpU0todzV1azZYWGZ0c3hsZXQreTlUck5l?=
 =?utf-8?B?dUsyMHpNQ29RaEdIMDdRYjNxaUxzR1pYdWJOSVgxaDJTQUpBb3NYNkpaTjY1?=
 =?utf-8?B?SDNVdUs5alFsR1NIWWtidGpjUG5iNnExenhMV25xNHFPYjZqbEljZ0Q2TDh4?=
 =?utf-8?B?MjFMZVZpMmhkM1kvUk5udktEdFlSQkl3cWIwN2VmQk1kMllLVDBsNjVHVXVV?=
 =?utf-8?B?NVA4UjlIdnA5dC8wUEtka0JrQmowVjc3bFZXMVFmNk9leFhQeHZnMG8xTXlN?=
 =?utf-8?B?MzlsT1FnNEJ4Ly9zQTZoQTlXY0c2VkhOVGNJc2VVUTE2UTRVNXh2STd6emFX?=
 =?utf-8?B?N1ZOa09zSmJKSVMybHdlN2FnaWhsMjZobVZNRTJWSFFJaDFhN1ZiOCtZeitn?=
 =?utf-8?B?TXRaS0hKU1RtWEt1UHhPZ1RpbVRZbGZCM2FkVGQ4RW5nRUVkVU9ENWRPWGhU?=
 =?utf-8?B?R09rcDd4VEZoUjNxa2JDM2JOYkVvRkpmRXpvVjExeTdHdk9ibExlZldsODJh?=
 =?utf-8?B?eW5oRUJUTTRUdmQzRGpuZHIxbmFvZXZ6Yy9FaU9vMGdRdmk1Q0d4bmc4eFM3?=
 =?utf-8?B?MWFIcUZnN0pKMlhiTVVjSDU2VUdYS2FMc3Q0dW9SdWFQRWYrZ1I5YVd3cGdX?=
 =?utf-8?B?VUdkS3BiWmVraDQrU21USXRQU3g2VHd0RSt4NkRKcDd2T0V1UGFndmRSaUYr?=
 =?utf-8?B?REpBYi9PRGdodExlbVZYVEdwR0w5cHZ2YW5jeDFGa3krM1V2d0R6aVpseUM5?=
 =?utf-8?B?Q0gwd0FEU0JGWjNLSnYwYzdiajFCVUdjUk5kaldrZGJlTTdzendNMUo5R0ZO?=
 =?utf-8?B?dkx1bVkyV1ppdmU0eHpYaUxGN3ZnOVMwMjZla1E4bzlFS3liUGRwM1dGakZS?=
 =?utf-8?B?bmUxdFZZeU91NkEyNVlrMS96WmdjMUxGY0JTYTVXakhrM2x0bWJWVXpscGlH?=
 =?utf-8?B?U1JVZVhwREV5MmsrYkJHTEtrUXk3QzBGMng4ZHVueGFQSGREV0xNRVgxSUxZ?=
 =?utf-8?B?VHJSRHJ3NkNWNlYyUExCRGRFTWFFNENrMWpGWEJ4UlkxRTRRM1ZRQTE3MUtD?=
 =?utf-8?B?TWFLZHV1TDduY2tNWldKL2EwaDl3ZXRsQ0Evck9LS1JvdVdVRXVxWk14dUlU?=
 =?utf-8?Q?wPpNKyy2boTWceEH/PbGTuHPu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0659686a-3e34-4da9-f8ee-08dd2e02abfe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 03:31:56.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/ojJomCGBnndatOzqrC7LGx9KS5qBtt/zuHfa+R2n3u5do6zpe+OJpz4+j28rVXy8r7y5sWm/zRb0ATZZDafQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

On 12/28/2024 10:52, Hans de Goede wrote:
> acpi_dev_irq_override() gets called approx. 30 times during boot (15 legacy
> IRQs * 2 override_table entries). Of these 30 calls at max 1 will match
> the non DMI checks done by acpi_dev_irq_override(). The dmi_check_system()
> check is by far the most expensive check done by acpi_dev_irq_override(),
> make this call the last check done by acpi_dev_irq_override() so that it
> will be called at max 1 time instead of 30 times.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/resource.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ab4c0e0b6b8e..7d6537ea176f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -678,11 +678,11 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>   	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
>   		const struct irq_override_cmp *entry = &override_table[i];
>   
> -		if (dmi_check_system(entry->system) &&
> -		    entry->irq == gsi &&
> +		if (entry->irq == gsi &&
>   		    entry->triggering == triggering &&
>   		    entry->polarity == polarity &&
> -		    entry->shareable == shareable)
> +		    entry->shareable == shareable &&
> +		    dmi_check_system(entry->system))
>   			return entry->override;
>   	}
>   


