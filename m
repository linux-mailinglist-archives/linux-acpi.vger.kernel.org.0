Return-Path: <linux-acpi+bounces-12157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBFA5E775
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09CC17C9D3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA31F03CD;
	Wed, 12 Mar 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="kdSKeqSL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021110.outbound.protection.outlook.com [52.101.57.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71419E96D;
	Wed, 12 Mar 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818569; cv=fail; b=Kc3gtaEU71pcVRqz/vDbcjLZsHxp60NZ5QpqVoW6QTQ2XnwyNiFAtgu6ECJA/BPhBl1WQTbJLGAP8TVFY9db+PK/ChzoNoKQasp4nUDQBBG1Nr3mxRxQQdLxzvcKUFHaSbnCrJI4qrqyCYr86YVUXux6+aqwfDBK2oztOEq71wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818569; c=relaxed/simple;
	bh=CABVmJM+dBh+z4Pfs2v82vFKd4neFpw5976y/DZRSaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyDNLEXJSqAZQFQXGBGj2l15+TxnNlNHdQeYngXBoGLK5eBvCh5aKzdEnXdJHTtK70PHZF8FlRXA89VjV83C+rqoTvFSd/YPcTS1CnuZfOtkgp9d+SN76GxN8Lc6ChdOND068nRpEr0jKXEFaLzOCmvX+GJ3ryUJ9e2LRN5tGs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=kdSKeqSL reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.57.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4AKNDQBSreEoiF/4BN46b+X9OLw25OA13kUPA2bs6tGQ77H3Ii4SSnmTvTC/FF3upvgH0yO+g96s3Npb8RqDzNx3/p7k0UpeGEG6KdEbkoAudafp08Sh1GqT4GlD9KLAz7oWxKuca8XuQ8DH04NStIqkwL9KLvBhbJjVRL90lGO4Mecd6/QpWgilpiRGm46PHh7XI+4O4ps+wS+iq4vyLRuIRrWuQQm+ArxbMERC74k+7mv4R3DdgKUd6Wylt+xQ45a1tOXwo8BPQ8LcMj1SNgOwdJexpNXNIECNpVet7FsdBoE77bHMfMrj+fkQCUYWO3SKoFicKhVi/O+sBghBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14wLKePOP0Osn+wLD7uQhzmmgAbz+VHRCrlqcgtaAac=;
 b=KMbA4oGO/rc6iAYZVzAUX5k6Dh/bdfvJu8xuUKiy0DbNUzvVkf8MTvhCJKEXv26HjytSFBFF1r2exi8cd9mvxk43mtCQGOzCawh2hxlhXXndrCrwOD0H01fLd2KqY/o2rrobsVzIOGe3O0qnwDXopjEhgP5OS+yNzjRs7BoAE1pp4NXlktklvVwMY6TI9O24wvIsyG43CyFIkcOBAGDQuqy9ELZgJPpHsjM/Rxyiuz+gRg01FnpLvVu0z1fUoKQnH6R4o/RTviuALNQE1XaCIr4FdSA8VKgO/lrdkQ5ca0n+S2zELixAEtgZk+8Uje1wWU0oYaihT+1tYVs1G8zLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14wLKePOP0Osn+wLD7uQhzmmgAbz+VHRCrlqcgtaAac=;
 b=kdSKeqSL8cGFM4kf5or/dQuHlHY6PtZW8BLYfhgeAcyeY0w3qncnnJXWULKfSzcJ9ObY83jIWboAb7UWRKKcRcebDxO30AL+GZ/pCjKcqhiYTgD6QCEpg7P7Q3ZUDpPRnO4Sf9VlFDa3qODm5zyRa/kWcl49sDqDvOPcz8Et/KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8402.prod.exchangelabs.com (2603:10b6:a03:536::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:29:13 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:29:13 +0000
Message-ID: <4428c08c-4477-4053-ab30-81a9a075c10a@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:29:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] mailbox: pcc: Always map the shared memory
 communication address
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b35a8e-04ca-4242-afdf-08dd61b5511f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFpHODZ4OXZ6WjRMMzVnYmxaOStGWldYR3VzdmpEMGlqZVNYM0ZaVUtMRndZ?=
 =?utf-8?B?Qm5JV2trUkFqdnA2OVVCQkFsY01CQVFZWmxtclQyMm1SSmFqVVROTnEzRmQ2?=
 =?utf-8?B?RnRxaVB0UHgvS25GTHM3eFVkY1NIMFhlNUpjUmNMYldNQ2VsTFlFRHdtYTdl?=
 =?utf-8?B?anZnd3diMUdoZ2ZiajRYYURoM0tpVHlGc0J2dzlXeE95cW00ZVRpOUNlOEpW?=
 =?utf-8?B?VGNGaUFoVGNNTWFhN3BpWGNER0ROUkwzbXpONzZxMlNWYllmQzY1eXdSak1D?=
 =?utf-8?B?UkRqenpzS0x3cjV1SVdSSVRQL3YwZ1dtVmJuYkN4Qm1hWWFuaTVURDhQeDhE?=
 =?utf-8?B?cnFKbCtUZlRuc29RVms0dU5PNUdYZG9ENmJUMENqQjFkd2hHc2lrbFR6UHdK?=
 =?utf-8?B?SklSUDdjSGJkaUE5cGliM2prTlFVcnNjOURsVWpkZDB6S1VTd3hqTS94Q2l3?=
 =?utf-8?B?VU1HR1Z6bGJVOTJpcm9wRitPazZ4REdNOVZLNHdiWXN5bnNZeG52VmlJYWxB?=
 =?utf-8?B?ekc0SlBHclNBVUFqRlVoOUdkQU96WlEwdG5LSXo2K1o1NzdYSTl0NVhUc2No?=
 =?utf-8?B?bTJTZzhqY1hmdUJXbDViT1ByOXF6am0zeEdCMXMwMFZvaG9rcXM4eVUrRU1G?=
 =?utf-8?B?UGVQd0tXNUJPZCtkMXkrTWV2QjUxcWdUTGNndkozbFNEai9BSXl1VllnMnpn?=
 =?utf-8?B?MnpPNUhXR1FrcHpFckZsSlJXWHB3Tk1SRnQ4TURPcVE4U2sxbU1ZcEI3UEdr?=
 =?utf-8?B?MVcxa0hzc3k2QytySGthaDZScXR3YjZzNXlOVlEvcWRyMGxNL3luYUVLQ0ZZ?=
 =?utf-8?B?L1BSTzlsV2wweXovQmFET0xsNmQ5aG4vSSs5VFdUMk1wMm9yUWx5am9kUU9D?=
 =?utf-8?B?ODBPNWRnSFFFS2k0L2N6MUxINmNHN3lkbHhlL1FuMWllQVJoeGoxbG9lSE5C?=
 =?utf-8?B?Um5jQ1d5RjZPZDdSM2RMNlkrZUJwb2lEYUFzSWpUNmRkSm82L0xRekZsUW05?=
 =?utf-8?B?dGdGZ0hWemd4SEdCaFpnWlZjMkJqcGNHSDNJS0xDemMvUkc5VkdTMWdCS3po?=
 =?utf-8?B?b0lZRURlYWhmcW1RZnhKY05rR0g1NlR0djJDVmk2S3BUYXkvSTIydjJVbSts?=
 =?utf-8?B?b24vOTNTR2pOQ042cmhUWHNkTEt2WlRyaE0xVlVRdkIxSXdqaG1HbkNaYndv?=
 =?utf-8?B?K1FRamZKWGF3M0IvZW1QekZKUnYzU01vcHVlNlpUdUhrekhaVHZGdW1UNS85?=
 =?utf-8?B?ZE9rSWF5SkFxM2p1SS9rZEwreE4wR0NzajNhNDg3djZqNkVMMXlWM28vdlFi?=
 =?utf-8?B?UzlhVnlTdnNaRzVPNTFsNzJKYTVUTHZOTWxDUmNqTUtsNGprRmdURjZvdjlz?=
 =?utf-8?B?M3JyYm5NUFlMMytPajNDbmMwTDJNKzZKdjk0ZzlpRnlrRFpQOUdtSFR1ZTRv?=
 =?utf-8?B?TE93SjZ0WGQ2aDhHT0I0T2k5bjFzZ2JTa2Mzbm9KTkJvcmxmVXkvRldIcmhh?=
 =?utf-8?B?ODl6UERhaW1YeEJKbXJaSHMrbXZ6dmQ4SUxGQTNhbTl2bDh6QU9LS25odWg0?=
 =?utf-8?B?Z3AzTThSRzBESEQxRnh4T2pOZWZReTYwd2Z4UldQdytOUTZSSDRGSDJQbVNJ?=
 =?utf-8?B?VXczeDExUW9IbnZyK0JwOS9Ebml0YkxNZkc5SDJ4TUJOOGhkMm9SQkRrazE3?=
 =?utf-8?B?T0ZvS016cDVNdExJMjgzK0ROSmExd3g4U3kyWE1Yc3ZHZTB5WXc2djVacU5M?=
 =?utf-8?B?MGtoRklCVGxHTjdRVEw3UnlQVUdKT0lJNWRNNWNXUUpWTEk0SExYS1FhYWVO?=
 =?utf-8?B?bUkxWjJsSHJKaDdSc1ZYTU1XQkZBNHVVV3RDTVNjQWZVVU5Yc1VSRlR1aXJp?=
 =?utf-8?Q?qCY0pfrii7846?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUI2dGd5eVBvaDJGMmF6UlQxYXJzeFZJTUZzOVc4bndwUTc1OWdROE8xTno1?=
 =?utf-8?B?a0NIVnZPekJ0Z3ZqTysrVFR0WmNDeW9ZcUpMcW5WMkpJTlRvV0RTditKZ0R6?=
 =?utf-8?B?ZjQ0aXI3WDdUQzlKY3BjNjdiTlhENDBDLzBHVldNYUlIUDI3ZGpvWmpOblp2?=
 =?utf-8?B?NHRDSDlUZXh0eHVjNUFtUFpENk9UZEhrUWNIeTBWVzNQUG80YWhXYWxORmpW?=
 =?utf-8?B?RTgvWkxHSHBmSXVTRFEwRGZJU29ISVFMTkxCM1hZOGhLbDIxdW9BdTdtMzZh?=
 =?utf-8?B?VzBraTJab01XZm1sZlVKQmFVR3E3bXZXMjZUeVQ2Wm1aaThHbTFySXkvSHla?=
 =?utf-8?B?TG0vSEpEdXpLRFJFMTNXWUdvUFlyUCs2MGM4QnJnblp2KzludG9pMk9QMGJF?=
 =?utf-8?B?blRwODVvV2oxOHd4R205aVcxVUlOeURwRDVaMGszLzgrdzJjSnltbVpsNDBi?=
 =?utf-8?B?azNMVElaVVNyVzRXNmd0K1YvcUFWMXNCbXR0ZkJ0YVZSdnE3d0YrMzI1eklX?=
 =?utf-8?B?TngxWW04KzFJQS94MjBWOS9GdzVaWWhYZ3pBQ3c0NW9nTVo1OUpDYi9ZWEhh?=
 =?utf-8?B?U29JWmNrSmgrQU5Sa0d5V1JDQUg5STNidTVvdk9wY0VxRFpVd2pqTzBheVpl?=
 =?utf-8?B?bnlhdjB1ajJFR3RvaDRiWURQdms5azdIVEtTTW5STWl0eXRPUStWY3M4TFNq?=
 =?utf-8?B?MzBVbnFMckU0U3BIQnlKdFhveVRIb1BBUHMzcUZwVlRrazM4dnI3akFtbmtv?=
 =?utf-8?B?dVJFRnpLaWtmMHpMK2NqVS82dUtYaUx2bVFtZS9teG5YNEI5bDYweG1KTFhD?=
 =?utf-8?B?Q2ZndjRJNnRvbjhPWnBaMGtaSndmN09yS0VFdm9mY3VBSnY1eE52UU9iTXZM?=
 =?utf-8?B?WUtyN1VkQmNKSU44SlpZTHIwbmhjY2NHS3d2ajFJM1FRZlRaUXdPU0wyeXNG?=
 =?utf-8?B?V09vakpnYlBlcndDWW1kc20yUEhrTkh5TDNjV3hLZS9OZlJ2SE9rNmx1WEUx?=
 =?utf-8?B?VE5ERStZeXY1ck0yU0lyc2dXbXdkQThnNnlOVUh5OHJMMTN6WGlqK0ZIM0hh?=
 =?utf-8?B?a0wrVXBuRDVjRytzNTlXN1RaZndIWGEvTXpvWUlOakMvbzB4SjI1Rm9Hcm03?=
 =?utf-8?B?bFhTa1RhUW0vdFdGY1pVeVNFeUVmZ2hkRUtERDFxNGRWTU9WUlVuT0l2RkdN?=
 =?utf-8?B?WVpaYXJlTHNBVzNzY2R1QjB6dmRLaWZMeVZ1T1FsR2sxdHFxZXhZdTJmZ2xP?=
 =?utf-8?B?TkdwNjA1d2YyRmFZVzhIODdmQmpPa0wwY1ZYbkhKcEVTRkhXVnhpbUZ2d0d6?=
 =?utf-8?B?Ny9SbG9uWXcvMEZEdGJlZGxzV1g1Y2VLc2VEUFZ2TVhOMHdEWFFGZDNVWXFr?=
 =?utf-8?B?U2t2TlhhOEI3alhYa3plRHZHWjlDZW84a0JjM2JzYW5KVUM3R3k5aXl4MUVi?=
 =?utf-8?B?YjZCalIrZ2dySkZ1MFBVbDZkK3kwQ0NQbndvYWVLU3hYZVVkVFpRM2xvWHls?=
 =?utf-8?B?NlkrSFRrNUc4c29xdjBIMXVQQStCOWJDRk8rdSs1eVZnL0MzMmpIeWZGbVIw?=
 =?utf-8?B?dXY3MEpENFY0QllwT0YweEk1UHlVeFFzd2JVdWl2OVNyV3pIa1J4RFYwaG1D?=
 =?utf-8?B?TTM1aStiN2VxbytvOU1KOVhHRzAvQ21jRG05dmNLRm9hNUhPWUtJTjBTYjQy?=
 =?utf-8?B?Z2czYmhkN2c2ck54dFFKTHZ4OFFDS3dGNU55UDJVejRpYWZiazBaeDdlci9T?=
 =?utf-8?B?b3ZqMHJYTEs5WXVqWkF5YTI3MEEvdWwrRm1RZ25NNzJQNlRmOFh2MncwOGYr?=
 =?utf-8?B?QmpLU1k2ZlFvK25xcDNROVRSQ25ETERQRU41UmRzWWQ5OUtSczdKVHBNOGpO?=
 =?utf-8?B?ZmpkY3hza1VmUFFyMmFJVmR6LzRIMTZBc2xFcGNydHVpQm5HbFhtcXhvT0VQ?=
 =?utf-8?B?SkdHdHZCd2pMbjUrZ0wxSGN4ZXVob29TanJVKy80NzcweTRXL1BDNS9GL25u?=
 =?utf-8?B?VTM0NkNPRktDRDBuNm5JQ3FiUDRpTmYwQThmMlRyRjMrWlhSa3gvUkovZ1pG?=
 =?utf-8?B?NlB1UzNHM29WeExJcDREWHNkdTlGMXhJbHVNbjl0S3MrUUlDMXM2a3AxYXFP?=
 =?utf-8?B?VEVXYzFNK3ZkUzJsSkxpVGJnbmJ2ZjNrYzhaemhkUnJvdkF4dlZvK2VYOUVF?=
 =?utf-8?B?QnRHKy8raVVUOUJ0QXBTNjVDVkNJbkxRcFVnUGJ1NWEzY0JhNmdhRGtWcnhM?=
 =?utf-8?Q?iViVT+NU3wvAqvXkWnpjjiCc8eKxV+dQ5kvdpw5MT8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b35a8e-04ca-4242-afdf-08dd61b5511f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:29:13.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKtSBvZhl/PxlEsN+ilpUa9idwnXQDR2vUUa4q/3zbNAThsllHwJlZiVqzJbhxd5NqMjhoFlLqxDUs/zfVFqnW3xQNBGPcj81A40hs9yHxpoZFl5JbOWZ9YUs5QHb11l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8402


On 3/5/25 11:38, Sudeep Holla wrote:
> Currently the shared memory communication address was mapped by the
> mailbox client drivers leading to all sorts of inconsistencies.
>
> It also has resulted in the inconsistent attributes used while mapping
> the shared memory regions.
>
> In order to remove/eliminate any issues, let us ensures the shared
> memory address is always mapped and unmapped when the PCC channels are
> requested and release.
>
> We need to map them as the ACPI PCCT associates these shared memory
> with each channel subspace and may need use the status or the flags in
> the headers of those shared memory communication address regions to
> manage the transport/channel.
>
> Since there are no users of pcc_chan_ioremap() and also it is mapped
> by default, we can stop exporting it and merge the functionality into
> pcc_mbox_request_channel().
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 29 +++++++++--------------------
>   include/acpi/pcc.h    |  5 -----
>   2 files changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 41bd14851216e8c4f03052c81aaf938a5e5c5343..b3d133170aac7f8acfd1999564c69b7fe4f6d582 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -372,6 +372,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   {
> +	struct pcc_mbox_chan *pcc_mchan;
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan;
>   	int rc;
> @@ -390,7 +391,14 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return &pchan->chan;
> +	pcc_mchan = &pchan->chan;
> +	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
> +					   pcc_mchan->shmem_size);
> +	if (pcc_mchan->shmem)
> +		return pcc_mchan;
> +
> +	mbox_free_channel(chan);
> +	return ERR_PTR(-ENXIO);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
> @@ -419,25 +427,6 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> -int pcc_mbox_ioremap(struct mbox_chan *chan)
> -{
> -	struct pcc_chan_info *pchan_info;
> -	struct pcc_mbox_chan *pcc_mbox_chan;
> -
> -	if (!chan || !chan->cl)
> -		return -1;
> -	pchan_info = chan->con_priv;
> -	pcc_mbox_chan = &pchan_info->chan;
> -
> -	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
> -					       pcc_mbox_chan->shmem_size);
> -	if (!pcc_mbox_chan->shmem)
> -		return -ENXIO;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
> -
>   /**
>    * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index d1e506f041c5a80857d4a025fa3c1803746ba4b9..840bfc95bae3329605da5f66cf37b7d2ca183f48 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -37,7 +37,6 @@ struct pcc_mbox_chan {
>   extern struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
>   extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
> -extern int pcc_mbox_ioremap(struct mbox_chan *chan);
>   #else
>   static inline struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
> @@ -45,10 +44,6 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	return ERR_PTR(-ENODEV);
>   }
>   static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
> -static inline int pcc_mbox_ioremap(struct mbox_chan *chan)
> -{
> -	return 0;
> -};
>   #endif
>   
>   #endif /* _PCC_H */
>
tested-by: Adam Young <admiyo@os.amperecomputing.com>




