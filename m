Return-Path: <linux-acpi+bounces-13343-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2396A9FB9A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3597AEF68
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E91FFC48;
	Mon, 28 Apr 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="REbItNOZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5631FDA8C;
	Mon, 28 Apr 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874372; cv=fail; b=rswU/jakRb5osK00r1I05ULAUFirWcX/5OAvKle+72w53v6Dsz0nAvO1Fbhha9N/q33v1heUOd4CUMymHaZbXZsjYqjIG7Mg+bhGUpzg+6bvtcNNV+c8/TW0GZaSdfXJWRldvvamhUMuFPDVNK2S0APM+I52SC3ud/nh0oJUo18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874372; c=relaxed/simple;
	bh=ym7R7iys/e4QOpcwKq13ISfm8leY356z5Rb9ZBv4lXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0i+xBuTyGVcgkdk444siOXeU5MSTIzss2zY72bYoi3OCb2PPcqIGHSbqxmhCaeGNUW7nxtTc5I40CP0kL6qIO+5b4oTgpl5iXuSfZDzF8UPO3WrJBFFpoCIC6DAXE04Vv8apJr2VooQKwTGM/WiWGJyv7PQf7DeLV6dgiccnlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=REbItNOZ; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvfdtUoYzfxWfyFnv0KqF5iR+BTEu3sDLDGs+DD/AvfXPa9X6rmuqwx1QunJ1jpkultUKgsNXvw5lML9s3pwWC+wRhjt7IpkMlkf29YF+/qH63h7d3m+MMBTUq9oKR+A3ky3VYS8Q3cdgoQfino2ik7Xz7ZvmxvLghPl6jdXJMxrjUkJV3bUGpARtd269uH+NVfpWY0Ge5SWzuBaDG+jo+PqmnbXnkPiEiAjZ8peAnaco24zdGEBZadIjfsP1xkRwoHySR+GzCByw2KyWil68qEis1keLRhErarxG23OnUtRj/LBFc2cYgLZvJfS/e36KEus976m8QYmt1WjkJxcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCT6wcI/4OkpqEV2jBBpQj0ISV3voe0SRLQfgwhR5Zc=;
 b=sD7csfK1Vybnjxmosj+JPbqBlK7B5hcQ4OqtSDKmJ5Oxzp1WdqowsWmJrfEdGkQaZFAyipwIPq/y0c67jTnLwS62Ojo9C6G5w3W3gYZaboTyLFs8Rmypx8MQ+bh43XfGNFbmHTlGTVIAWpG/1gfaF1HWsdM/eF1BUguFz3Y162ovu/Pp9/htzEmh4N83zOyJkyTszvJ2c0rlaf7uV8ZCLfx1bSq0Hiq/lRoc1bDviL+MjEigRdLWNQ+RrUYkV0g5evtUtILQTjAzXJa/d79lCOYz6KExnmrSBzP2hB5J6v0vH4Dx3OKyLwCeF/OFpmMWM343yN1HukCzdjX9mIUJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCT6wcI/4OkpqEV2jBBpQj0ISV3voe0SRLQfgwhR5Zc=;
 b=REbItNOZXu91GqMd+2siVJPUaMmYODUfiPmovdJW2fM3y9qX/YD3rhZqYL5aHSpB8ZqgK8HoSM1SlspU7wc3YzT/S3GbkoFVGZB+/fNR9U/KA2xAwxTAV/zNWst3pmZWd3CkT90PZQuydgGyv/M6B3vr20hxZsb6GRYdfywheCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:06:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 21:06:08 +0000
Message-ID: <75faab0b-4514-4678-ba27-af658f6d3485@amd.com>
Date: Mon, 28 Apr 2025 16:06:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: Marcus Bergo <marcusbergo@gmail.com>
Cc: mark.pearson@lenovo.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, lenb@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
 <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
 <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
 <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com>
 <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com>
 <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
 <369d0a74-4d5d-40e9-aa87-86c7563cf019@amd.com>
 <CAJZ5v0i9ZKgybAarKD0DDH1q6k1LKse+kX=Op94zGO+PjyMvGw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0i9ZKgybAarKD0DDH1q6k1LKse+kX=Op94zGO+PjyMvGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3bb97a-d038-462b-0610-08dd86987f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anQ2cGN3YkJxYlRwV3dhbVFtRG9UTnJDZVc4Tyt6NG04bVRyTmt0VXA5Q2lR?=
 =?utf-8?B?SEIrL0s0d1VNa1FHZGJxaWZqZjJXWXkvRllOeUlrTDBxaXV1MGFxLzZ5U0J4?=
 =?utf-8?B?aHluR0kySWwyRkhxa3dnTzl5ZThkSlREMTdBZ1pPY1BsT1I3ckFKc0pWK3B5?=
 =?utf-8?B?NGxUOXZzeXlrR3d0RHBsR1o0ZW1LU0FlL2tZUUdnR2s4QTIzazZBYWpuVlZv?=
 =?utf-8?B?eXVObkNhT2NhWXdJMmRhdy8ySTlQTUhiajNqbnVuczkxeEVqczNWUlFYMEhy?=
 =?utf-8?B?bVdOcUIrQnphdmdtZWE1Y21mQitYTlg4Zi8xVml1ZXF3a3ozMzMwM2kwVGRu?=
 =?utf-8?B?QURUdGhqNlVLVUIxU1grZU1iUXJrWWEvcXJjTzlvZ0c4OHV2a3k2S1Z4SnBB?=
 =?utf-8?B?a1pDclVVUzRBN0JGM01UNlNraTF0SisxVG85OGpPa2E1R2xJWHIxNmxNM0Qv?=
 =?utf-8?B?SUhyNkN6ZXZZOWtLd3ArWnFaYmdTQVFLVG1DangranlrTnJMWW5jZEJnc2l2?=
 =?utf-8?B?WFFLNVhjekhqMGUxV3RpNmhSdnpicVkvMSszR0hWVUwvT1dicXRUeXQxVkxv?=
 =?utf-8?B?MUdCR2NDL3IyWlozc1NoTnBlUmNzcUJUTmtlKys3UisyTFNvYllTQWY3bHlp?=
 =?utf-8?B?Q2NMTy9nUWRyQjBGaWRyNGJBbDFtQzBKRDlxbFY1eDFkb0JPY05qNUN2c2pZ?=
 =?utf-8?B?MTdxaERJYVZUcDEwb0hpMVl4MThRdXVQWkQ5R0FsT0puWWVwbmVFR2JRejk5?=
 =?utf-8?B?Mk4wNU45M2ZDejF6czViaTZzbkU2T01UMGR4bkJTanc0N0d5cnV5aU1IUDg5?=
 =?utf-8?B?TkcrSjcyamhyK2xUd3VlZzBGU2hTM1RmZzF6RktEeDJwL1daOVhCRWpZd3ZJ?=
 =?utf-8?B?YkJsQkJOTVVib01LUGZpOTMwdFlWU0ZVcjdrQlB1bkVtRi9pczJqdGMxSm5X?=
 =?utf-8?B?N0F5Tlh3V01Zamw4K3VHU0M0bm1VYU9YTGFHdFJuZis5UHBTTHN4dGJVRGU2?=
 =?utf-8?B?aTNETzg5clc1a045alV3WVkxWStBcGN4NWt5bHhBL2xOTkZRd0prOGVYQ0dN?=
 =?utf-8?B?Sm1zUlF6YTk0VFUrUTBsdkROMlJrUDU5OWhhWUdvcG03NVB4SVp6WmhrZHRO?=
 =?utf-8?B?eklJRWxwcjErNHpUcFovYzZ3ZjV4YkJiYkZPOFpLaHZOZzlSRmhMU0RiR1U0?=
 =?utf-8?B?L2EyYnFBbjBpYnpSQnRsMWZuSXN5aEhhWWFCMzVtNGFtZFg3ekNNUFl5N0Nv?=
 =?utf-8?B?S2RJU0g5Z1VoYnlsb2dKM0VVM1dkVFBPNlNQbzM0Uzdvdkl0U1pkN2V6dXdo?=
 =?utf-8?B?YUhuMS9KV2w0YUdWSjErWG9wNnFWYVpRK1N3Tm90WlluUGNoWmFkRTA1NDlZ?=
 =?utf-8?B?ci9tOEhWbms3c1lXNWozUCs2bHlrMVZQU2UwRHBUejl6Z1pzNVlmNlFtZkRV?=
 =?utf-8?B?RVptWCtFVFg2bDdwUzFxZDlOS09tbXNva2JORXVxejhFeG5SRHRqZis3Vm5L?=
 =?utf-8?B?MG44QXhUWUVOSHZGNUp5cjI1VWtoeERqS20ydThabjMzUGxmNVRnL1JIMzZ6?=
 =?utf-8?B?Z3o2L0dnTWlUSjU5QXp2dGliUWVLSVhRUytTVWQ4SzRIeTNmQVcxbW1nK01K?=
 =?utf-8?B?dnBuenBSVjc1SjhtUzZndzgraTREYWpsMmMrQ251dWE3Y1BFOTBiQkFxV0t6?=
 =?utf-8?B?dFdqODZ5YTZzWElMOXlQcm5wbGtJeXJOZXpKTnRmbks5bEFlUHdiRUlRNVVv?=
 =?utf-8?B?aDdKYTEvbk02SEc0aWJLZzBpVWZxckM2YXgzYThXc0RqdHAxRmR0VjZ4RGVz?=
 =?utf-8?B?SHltS0wwMUZWaWl6ZjBsb0lvOHZ1SHcwU1lLak9NQnJVN01JaTEwQnRTNUhx?=
 =?utf-8?B?cFppU1FWcHV0NG4rY0VORk5jU1g0YzM5U0pzZ3QyZmxuZWdtRHplUGFZb0Ru?=
 =?utf-8?Q?QkcBT0/YJCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJraTJGMVlHdERxWVdGWiswRlI4TU1GVTlQQktoYmJxS1hwTjFsemZpcVRR?=
 =?utf-8?B?K3F6VjFpdjc2eHh0enlyZi9sMmw0UDIzdVZzeDFieGdsWSt4eVl5UGxNWDdO?=
 =?utf-8?B?SlZaSTRCekdnazJYQVA3SWRxREI1N3NHbm10Z2NKdFRoem9aNGhobHNvS1Ns?=
 =?utf-8?B?bmR5czZHZzNnS29PQ0hxdTBIZ0ZBai9BWDNJdHdmSFBTcWgyODRqY3NDazhK?=
 =?utf-8?B?SWcrRllqZ21hVGdkTVRrWFliQkIyWW1ZV0U1WS9BVm1rdm4rT1NzRksvbGZh?=
 =?utf-8?B?SGJxMXFKdFhnaGdoSnN2cUk5WE5idHhMTTUyaG45NGN3ajE3bVNlUXpxUktL?=
 =?utf-8?B?Wml5MUd4Q0FZYW9mMG1JeDVPbk5QM0dCTzNSa0RNMmdzclRRWnZCOWJaL3Nv?=
 =?utf-8?B?RmFRU043bU13Ymw2MktzMzlNbTZUNmNwZThtZEkxckdjcTFsWnpnLzJmWU54?=
 =?utf-8?B?eHBySGlHTm9EWUNEbHVDcnJRZUNPeTF2VmRieFlVOE5xUmJiU2JQNHFGUnN5?=
 =?utf-8?B?d2pXcmFPeWRoY3VJdWlDbzBscW9CL1IxNGUyL0RtT2crek9SQndTTURFRFRj?=
 =?utf-8?B?WTdDN1QrckR6ZHV5RE5wRFJ6Nm9hYjRaUGVqNk9SUm5pUjErODJsbGhZcktP?=
 =?utf-8?B?cUJ3N2JWSzZHTWVoRVhGNHN0Z1ZpS3hDMEZVRlZMTU40eHNWWmh4cjhPZTFN?=
 =?utf-8?B?M1p3M0lrVUVSTlRybjFnQWgvT1EzdHIzTlloT0dwU29uYlBDZndOUE1oSmpE?=
 =?utf-8?B?S29JeVZJWW5qaVpnUFdwZzUwczVDY2VKMEdtaWhqNjY1RTBsNFptK1lnNGgy?=
 =?utf-8?B?ZFVZcm5vQzN2RlNZS0F1am5ROCtsaUFCdVg0YWNXNGdNVG5wd2trTVg1SEFJ?=
 =?utf-8?B?WVlzT0o5aXZwRjVHYnV3QnRyeTIxaENYSEgwS3drVjlMaGE3cy9pTFRLc2gz?=
 =?utf-8?B?ODh3SStjVXVEOXZTQXI0alpvRDhxZjg1U2pQTlN5akxLSGlvbGVKblp2ejla?=
 =?utf-8?B?eDcybEdEUXdIbUloM0NQT1luY3VnYUEyZXZCTnlhN2xlYi91Mjk0d2RDckdE?=
 =?utf-8?B?WXVKNzJUQktaUHI4N2F2bTVZRE1vV0F5SjU2NFBTaHJzVXdmOGg5M2tjS05P?=
 =?utf-8?B?SjVmYS9vcUE0blp1UVBQeW9nYWZDaXgyRjMrN3UybTY1MitObDdYUWRPUTcy?=
 =?utf-8?B?TjhrTkNFVnRwWS9KVTA2TC9wTVA1WFAyOXNkSnlUaklsN2NPTG9xcG1yYlZa?=
 =?utf-8?B?NHpxVVJFNGVsbmVZSzVMUnRPRnU2aEFMVVhtYmhTb3ZKdENZaXRlZFllUVFI?=
 =?utf-8?B?RTlVK1FHbnBkdjhzSjBWSjh5TXRjbW1iRkd4cHYvWExGcU16TENkYXJNM0dt?=
 =?utf-8?B?QitFRjFSVWVuUWwzaHVMRUdRTEZpc1hzSXVhenA0d2hTVDdubDZYRHk0SWZv?=
 =?utf-8?B?Q1c3c0NmY2NScElsK29mUEQ2SWNGZ1c5QTlhczY1TlJJVU1idVI1cjJHb2xp?=
 =?utf-8?B?TkVzamxQWDVMMEpJby9xWE5JQXdZc1dDTTJEVXh2ckN2NU54a1YzOW1MVnBt?=
 =?utf-8?B?WGsraTlQdmkwbDl0TlZ6L0pqdjFQOHdLWlFYYzRJeDkwaFMwQmRKWVMrTGVw?=
 =?utf-8?B?ZzFlNkNWU2Q4d202WnhUb0N4MW1xTzJjUmpVOWt2NEYybWdvRkpKRjJQOXRO?=
 =?utf-8?B?aUNRZTliVk1Vck1ORUxsUU4rWlIrMDFsdGhDRU80MVhFUTVlVHptb0RzWGYy?=
 =?utf-8?B?WkpldVoxc1NWZitHR1QvMnYwVzlZL0oyYWo1N2lkdVNLWnBlQjBrSm5keVc0?=
 =?utf-8?B?ZElhcDlpNzhUc1dqZ2xxeEt3UDhraU5mQ2NYV3V1UGsrSVE2dzFTMlQ4b251?=
 =?utf-8?B?dUZxL1hZbFQreWc3eVcyVm9PMk5jeDczRzVXb3BMQ1JqemZvSGlZbmVUY2Q2?=
 =?utf-8?B?dEYyQ0VTbEJYYlJIaXFtdW5NTjVyK0pDZzBXeWhjNllXRExVQktKZHU1SFY1?=
 =?utf-8?B?R1BoU2tsdS9YWE1WZ04wc3oxajJ6clZpR0NsRzllRCsrL2dDWm9hajdLcFI4?=
 =?utf-8?B?TnFMSmVNVENweGo5RzdWTlpscFZ3ckVTSW44RDNDa0FzN0NyamtZbTE4VjlK?=
 =?utf-8?Q?kuIy3Ese+pjkAvKQMGnas9F8s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3bb97a-d038-462b-0610-08dd86987f64
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:06:08.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wX9m+CjkEcICQzwcjqlNRurWCOuT1JazXqdVTLdEJ0zzZv3oSTHANIPLsVKGiMp3LhHhvSW9a3qa9BHkiV/6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

On 4/28/2025 2:45 PM, Rafael J. Wysocki wrote:
> On Mon, Apr 28, 2025 at 9:11 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/28/2025 2:02 PM, Rafael J. Wysocki wrote:
>>> On Mon, Apr 28, 2025 at 8:23 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 4/28/2025 4:51 AM, Marcus Bergo wrote:
>>>>> Yes, it does.
>>>>>
>>>>
>>>> OK thanks for confirming.  Considering your finding with this patch
>>>> you've shared and knowing there is a timing dependency that delaying the
>>>> next s2idle cycle helps I do wonder if we should keep exploring.
>>>>
>>>> Rafael, do you have thoughts here?  Specifically do you think it's worth
>>>> revisiting if b5539eb5ee70 was the correct move.
>>>
>>> Well, it was done for a reason that is explained in its changelog.  I
>>> think that the problem addressed by it is genuine, isn't it?
>>>
>> I mean yes - of course.  My inquiry was whether this should be the
>> default behavior or if it should have been a quirked behavior.
> 
> I believe that it should be the default behavior because the EC GPE
> needs to be cleared after handling an EC event which effectively is
> what the suspend-to-idle code does.
> 
>> I don't have a good sense for the rest of the ecosystem what the impacts
>> would really be at flipping it.  Would it be worth adding a module
>> parameter debug knob and survey what happens on a wide variety of machines?
> 
> Maybe, if you suspect that this might be a widespread issue.

Marcus,

Before going down this path I have an important confirmation I need from 
you.

With just /your/ patch in place did you see a message like this in your 
kernel log?

amd_pmc AMDI000A:00: Last suspend didn't reach deepest state

If so; your patch just papered over the real issue and blocked the 
system from getting into a deep state.

