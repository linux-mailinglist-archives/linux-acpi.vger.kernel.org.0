Return-Path: <linux-acpi+bounces-21526-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O0WOcGArmlfFQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21526-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 09:11:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F462355BB
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 09:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9311D300AC84
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1B36B056;
	Mon,  9 Mar 2026 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RjBWWx34"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E728853A;
	Mon,  9 Mar 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043902; cv=fail; b=tDxP1lutHO642cg88QWF6ZyyObonxhvGgEk8D48V1Za0HAJP5Q6aMMnmBUY/L+hqHhY0k4zXiDSYiIMA8C3jCJKuVSqvcx7fzAvucU7rIO69k7nwbGfQ9WrNhfRjsmNfoT1qpMKMNA/z9S0ZDxIm3TfSQ/aGyn7d+Mmo2uwHXKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043902; c=relaxed/simple;
	bh=WthyZFNQiTueh58ZNmAFuIPRkY33K6UYNNj4xdLNY0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M48IpVvh1AY9URsKH0U50uwJ6A80eXvQkMxrSiv6TMTjUCBkUrcyLz89JBfFxgHaN2uyEkmkVx7MHLkKPMUQQWqJ+Raa8XpSSUrDe1VjFvLI/qA7wHaOcnBbK8oDRlGep2ZjH0Kgoy277EK774OI0mG8AJ6Hwu00fPer9wT02Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RjBWWx34; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF80+w+pGzzFpAQ4bb6OvE7wikvP+SyLV2LCzdWaz5Br26W57kb3n6Ybcs8Xyr+17M9QGaiaq6YMdwXf69TzjKyxxRwRo1dzS6tYbdAhLo0WNHv/zu6veBNgIxYLqR7MydjCHDGVt/+yJ3NE8t40jPD4R7JNqnuQKGwVUItyh2usbisEUxKcKDadLu5D118TsrLlv2H2YOVmbKS3+EN6xqT7haLbevhNTkVaiEzUi5WTjavxQq3pEWlrUGuKT72vFXazqROkhauzm6y3JM8t4OWrvxx7V9/Bb0vnjooVe0cKUhm8A0cyBS3G6ky9KfvCF6XwpMD40MKTa9SWnH01mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R//3Qf1HdeUJ6iRHkGTFVB0F6YqNDdJUoDb0ZgeThng=;
 b=pdmvGGkq/enuaH8JFq5ltK0t0ximTlgisgEYvZLCJVLnAKbia+pfuML94PFmB4Y5bIJpWulVzaHakr+VGdJAYBl9+9QS8/sr+ke/pslriAluvqSWLb/XnfyPR4mN2pSLTHx8VVRBDKlksde0fCrK0O+qDzCpEuCPYCUAKwzOt/x71wTChX7Qn/b9ZsxQA0SfnLOUSqy+40fxVoGuTm2YnOAzCj/AUED2BYXGLFmd9asa+EuDPodE6sqa05hHN4JRtZC8NWPUO7S1RnXvtX0Q+wfrzJpUb2VKyBS/5M8EneKIaOe5nG++jM7UMurTVfSp4QiA+raVkjLhxYU56xm22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R//3Qf1HdeUJ6iRHkGTFVB0F6YqNDdJUoDb0ZgeThng=;
 b=RjBWWx34oaCIBEcFzpvi/3aZ2V01aUZFFIIEBv7fDrPuK60rMH4ZCdtDmuhL2D5QYRxoq5Lla746eZUPGAEQyPlA6DiMuxcSfgA8AArntcJpPmOPQO8C4QY4FtHIx8Abvo8wBZDwoKRYTWQm0blWfmsmoL0Hkdp+JXEL9IgSd+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 08:11:38 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::2bc0:451f:661a:ac32%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 08:11:38 +0000
Message-ID: <20cf0dc1-f1da-464b-9700-e2ce30e438e7@amd.com>
Date: Mon, 9 Mar 2026 16:11:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit:
 02c057ddefef5
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: W_Armin@gmx.de, lenb@kernel.org, benjamin.chan@amd.com, king.li@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
 <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
 <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
 <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
 <44b0ec66-59d0-4c73-807a-790817f22409@amd.com>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <44b0ec66-59d0-4c73-807a-790817f22409@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8235c17a-c2c7-4d4f-0b2d-08de7db37d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	4BlxkYq4HJBrSIAr9aoGpNgtQB/9EgTkkrE9nUkSnqH7FlJCJEls7j4wzgxu47jKPX9YgJEWLH2lbBBqM9f4VAHYJXiTgc2JE9rU/NsLN/LfNwdOfMIBdQ8qn06a+rhs7HR7qcnLicgjaZ/qlWfQ7mp3Dh4bN2iliCPKK6I+EBrVJebE8sDqKwdjWG2/H+ra+nr9qkPN6+ZwcIqe0Lu0PX23hiSkYj7i14GmsjNK9LzEB4O2XwKAH9GNK3E+gBQJoQLpAjPrkiRp1OjJ6GEcS8Iz5NnM90FaRHK+KhmKN/iGtDYrCdDMiMza9yLlIBXpx34PQfkrdrDvxn7hXS2ToGTHi8uKQDjDDSGglvNDKkjdXSJHRJ1lnwXNrM/ywzqDjF1NM2eJuLbQ5E5jAftllWqCath1sa2jh/NJA73Zxkw2w86QG7pLYlxZphD4DeTjY/s/RGPH5XnhkMI8knYkuPrDGhnM5wRMgmEqLmuneOw0UC9jlacSVSYCRrx3NPsERtBg0BxanxoifgeyR11qUlusD7Kl1rJPMCLeqeAg0QOJUQa83f8tGoF6Vgivias7rdd0Pmc6n0zpbeGEMwxJ+hNasVdT+COWVAxAMi6uPMk6UKjyQBEB+2laaOqDwLXjRN83uVAfRexIPaRrZam/tu7eXU2LG6ibYhrFRdHbE9pxpEsSLY906GEpm3tLR4+d/55x2GLr1i9Y7v+Ta3Gctw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxuZ01weCtRaWNBRTBRWDBmN3Zka29hUzAyNkF3R2laM2lwWkl5dVhRVHFZ?=
 =?utf-8?B?cm82eHkxUzNRWTBMcVpnRm1MUlNwYkdPb3VaRkVLdjFySEcycXJwQ2xMamxB?=
 =?utf-8?B?ekpud3JmNHRNbXg3YnBnYnJzRUFhMW1qZ0g3RmZNbnY1TXpsMXZSaTM0dE10?=
 =?utf-8?B?OEVlekRHM3FWcWVTWUhvZDRIM2FTK3E0aXZwem5iUzVBWVFIRjRUaUlDbUlj?=
 =?utf-8?B?YWhUWiswK3QzdERWRUVXRVIxcDc2K1dXS3hYWUxkT0tZczJDOVNlU2doeTcw?=
 =?utf-8?B?bFJFcWIxVWR4YnBlVjhockM5NXF5eml5QWxPTFphTkRSM1R2bGVTdTgwcE1Q?=
 =?utf-8?B?U1JhanJmdDdyZVNYZ3RFaFhDemphZnRSbmUvczhibnVvMkQ5ekZvTlFqSCsw?=
 =?utf-8?B?OUhMenE3b2xlMGgyUWlKajU5c3dnRGlEby9qMFByRk5udTNzQXVkZlRYcTFJ?=
 =?utf-8?B?MjNtVzQwaTl2K0U0Nkl1UjFQWlRrRXZ3N3ZkZFFsMGNDSWFzN0ZFc1lZdzgr?=
 =?utf-8?B?UUZsbnNNMm1qd1RwN2FHZHBRTGFGYVJ5MjJYdVNaTUtzWm53SFhXMmsycnpK?=
 =?utf-8?B?bEJId1BPV3lEVm9KVmVZTlRvVjZsNXpzczFpcUpMN3hkQzc2OGptai91dWNE?=
 =?utf-8?B?Z0JFVTh5alR0UUpSWXA1UEhHQnRFOTl0RVd0QjlmV3JPTXFHK0tSSml6elpS?=
 =?utf-8?B?VTdqQzdRZlZ3K3FXOEU5UEhKSVJyUjZDVm1DWWtMTU5rclMxMUZDNm5PZkRi?=
 =?utf-8?B?Q0czOUpKdmFBL1VVVWpseUEyWkZyV3NXY3E0OFZNOWlQRjBEc2l2VEFwOXRr?=
 =?utf-8?B?L0dxVWwxWGMwaEdIbVJjQnl3dysyTTNWa3VVaUx5S3BHaVh5NEhkMVhaRThh?=
 =?utf-8?B?MHB2UmpwUFBLWEhaL0ROZmZvcVBtMGthVytVcUh2dFJuZUdoM3NKTnEybG1v?=
 =?utf-8?B?VHkvZnVLL24ycFYxc2NtUkFBUXJqMHZXVG84eHhRT2VGYXpZcW9XeFZtZWIw?=
 =?utf-8?B?cmwxNk96ZEtza2wzc29CRkJ6ekxCVWxGMzdFSk1sRFJDZjBISDF6azVUVWlT?=
 =?utf-8?B?RHA0bGVzellsUTdtamVOS1U4OC9HU04zWDUzNzk4ek9QcWlTVmk4b3dQaDFu?=
 =?utf-8?B?NSswTkVTeUhvU25wTkZwbERDU2laRkZDeUJDQmNwdWV3WDJ3a1NGRXpXcGdN?=
 =?utf-8?B?dyt4L0ZWRHRwZjh3NjZiUXNlZWtHMlRrZFZHRWpTQ0V5MVY3cXE5SkE4Rjd3?=
 =?utf-8?B?YU9IUWZ3VDNSd0dHa3pjT3ZuNmw2Qk5wMlc4dXIxMkIveWNvMjFMei93WXF6?=
 =?utf-8?B?Ykw1bStROVcxQm1KY3VPMnVsM0thNEl4d3dreURONzJaOGtYTTd6dE5uTGpo?=
 =?utf-8?B?dlFPYXZGLzdKeEV1T0wwMGpWdXdLUEdOcHVJK2diWWhGRnM1Tm52NUQ1WFVZ?=
 =?utf-8?B?bHp3aW9Iem9tYmxHK282Z0lXVmdQUVJlbDRUclNqekRxTUgxVnhybzIzQ3pN?=
 =?utf-8?B?Uk81clQ0YmFOYUg0RW5tRldZbUpnemM2b3dzVlR0ODd5OEFIMU5hOGo0OE91?=
 =?utf-8?B?VFFhNGFiSE16Vm8wVEZxeUJVTmk4UWhydWVQbWswSENmRSt2U1BKdFBCc2Vv?=
 =?utf-8?B?TWIwTWJMT3R0OEVXaGdrMUhaMVJ5QnNwRHpwM2w0bUt1bjNqTEovSmpRQzhG?=
 =?utf-8?B?K2ZwRWhTSURYYW9QOTl5MHVIVzRLY3RSL3dsM04wT3dXc1RqYWJEaU5UL0Rw?=
 =?utf-8?B?WXREOWV1UnJ6RURKc0luU21TeHAzQi9NdVczd2JpcjBuZ3VtU1UwazJqWGhq?=
 =?utf-8?B?UEJGVmlGcmFrQUdyZ1RTeitReVA3NmEwQTh4c2NPam9zMVVkQlBYMlBkWjRa?=
 =?utf-8?B?cGNWREJoMUtOcitvMVZIS3NpK0FPcncxdWtVQWp4R2VkOTgrQWJBdXVETmt3?=
 =?utf-8?B?aFM1SDlPSmRFOHc5bkcrRFF5K2dpcWVmZ1V5SHp6SVRZMjh2cXFCeFZ0cW04?=
 =?utf-8?B?R0NjQkdNeWFaRFpMaERubjhscXhDM284TVdrYzR5TFNVZmZTTTFnQ09VQjd2?=
 =?utf-8?B?WG9IMXFIa25WQ0MxR2cyNW5UOWFuOW5Zd0h5SEwvbkR6WmdYLzcrYTE0eXI5?=
 =?utf-8?B?bG1IRzJmVlFvMFlwZ3RIR0xwbmZNeG9HNmtDdG0xZnJaT28zNWlDTWdTSCtN?=
 =?utf-8?B?b1pvaWg2MzUrN3RFUW4rMmtTMnpVNWtxOWNTTlNvMFJYeWpvMlhoK3JiajJ6?=
 =?utf-8?B?TGpxbjdQN1dwOW5GRVVGU0ZBeWxCV0ZMaDNaN1cyQVVXZUdaWFpqQWgwcHdP?=
 =?utf-8?Q?4gNy9L4ovVQh+6cZUw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8235c17a-c2c7-4d4f-0b2d-08de7db37d11
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:11:38.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXH8tjpP+MiRxIUMUQS9BvlR/nvNKltfDxn79yvR+sLLpPptRhnoA5EHTRRhT4CS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Rspamd-Queue-Id: 86F462355BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21526-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bin.du@amd.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action



On 3/9/2026 11:52 AM, Nirujogi, Pratap wrote:
> 
> 
> On 3/6/2026 7:45 AM, Mario Limonciello wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
>>> On Fri, Mar 6, 2026 at 1:35 AM Mario Limonciello (AMD) (kernel.org)
>>> <superm1@kernel.org> wrote:
>>>>
>>>>
>>>>
>>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
>>>>> Hi Rafael,
>>>>>
>>>>> In kernel version 7.0-rc2, the AMDISP device reports the following
>>>>> errors when created via mfd_add_hotplug_devices.
>>>>>
>>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
>>>>> no  post: no)
>>>>> [    5.236744] input: Video Bus as /devices/
>>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/ 
>>>>> input21
>>>>> [    5.236779] acpi device:14: Error installing notify handler
>>>>> [    5.236782] acpi device:15: Error installing notify handler
>>>>> [    5.236783] acpi device:16: Error installing notify handler
>>>>> [    5.236784] acpi device:17: Error installing notify handler
>>>>> [    5.236785] acpi device:18: Error installing notify handler
>>>>> [    5.236786] acpi device:19: Error installing notify handler
>>>>> [    5.236786] acpi device:1a: Error installing notify handler
>>>>> [    5.236787] acpi device:1b: Error installing notify handler
>>>>> [    5.236788] acpi device:1c: Error installing notify handler
>>>>>
>>>>> These failures indicate AMDISP device is incorrectly detected as ACPI
>>>>> Video device while it is not.
>>>>>
>>>>> The seems like a regression caused by the change that converts the 
>>>>> ACPI
>>>>> video device to a platform device (commit: 02c057ddefef5).
>>>>>
>>>>> Issue is not observed in 6.19-rc6, and also when this change is 
>>>>> reverted
>>>>> in 7.0-rc2.
>>>>>
>>>>> I really appreciate your inputs on addressing this issue and 
>>>>> helping us
>>>>> make progress on 7.0 rc2.
>>>>>
>>>>> Steps followed to reproduce the issue:
>>>>>
>>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
>>>>> 2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to
>>>>> avoid kernel panic found in v7.0-rc2)
>>>>> 3. Build kernel with:
>>>>>       - CONFIG_AMD_ISP_PLATFORM=y
>>>>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
>>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
>>>>> 5. Boot system to see the failures
>>>>>
>>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1- 
>>>>> Bin.Du@amd.com/
>>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
>>>>> amdgpu/isp_v4_1_1.c#L132
>>>>>
>>>>> Thanks,
>>>>> Pratap
>>>>>
>>>>>
>>>>>
>>>>
>>>> It's a bit weird to see it even probe in this path in the first place.
>>>> acpi_video_bus_probe() getting called with the mfd device doesn't seem
>>>> right to me.
>>>>
>>>> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO
>>>> ends up matching).
>>>>
>>>> Would a sensible solution be to reject mfd device types in
>>>> acpi_video_bus_probe()?
>>>
>>> Every platform device with LNXVIDEO in the device ID list will be
>>> matched and so probed.
>>>
>>> I'm wondering how those devices get that ID though.
>>
>> Yeah me too.  I was surprised an MFD device got it.
>>
>> Pratap - can you figure this out before we go too far in this path?
>>
> yes, MFD child devices in this case have the device ID as that of parent 
> (GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, the 
> MFD child devices are inheriting the parent's ACPI companion device and 
> this is resulting in having the same parent's ACPI device ID.
> 
> device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91
> 
>> If they really shouldn't have LNXVIDEO fixing that may be a better 
>> solution.
>>
> AMD ISP related MFD devices are using the same LNXVIDEO device ID even 
> on 6.19-rc4, no issues observed earlier. I can confirm automatic AMD ISP 
> device probe works and also camera works on 7.0-rc2 if I avoid 
> inheriting ACPI companion of the parent (GPU) in the mfd-core.c
> 
> // device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91
> 
> But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 needs to 
> be root caused.
> 

Possible cause may be.
1. On 6.x (without commit 02c057ddefef5), the ACPI video driver was 
registered as an acpi_driver (static struct acpi_driver acpi_video_bus) 
,  it lives on the ACPI bus (acpi_bus_type). It only binds to struct 
acpi_device objects in the ACPI namespace. MFD children of GFX 
(amd_isp_capture, amd_isp_i2c_designware, amdisp-pinctrl) are platform 
devices on the platform bus, they are completely invisible to 
acpi_driver, so there is no chance of the ACPI video driver matching an 
MFD child.
2. On 7.0 (with commit 02c057ddefef5), the ACPI video driver was 
converted to a platform_driver (static struct platform_driver 
acpi_video_bus), it lives on the platform bus. When the kernel registers 
a new platform device, it checks ALL registered platform drivers to see 
if any match. The matching logic for acpi_match_table works like this:
- Get the platform device's ACPI companion (ACPI_COMPANION(dev))
- Check if the companion's HID/CID matches any entry in acpi_match_table
- If yes, the driver probes the device

amd_isp_capture, amd_isp_i2c_designware, and amdisp-pinctrl are MFD 
children of GFX and inherit their parent's ACPI companion, which uses 
the HID "LNXVIDEO". As a result, all these components will match with 
the ACPI video driver. Consequently, this issue impacts not only 
amd_isp_capture but also the upstreamed driver amd_isp_i2c_designware 
(located in drivers/i2c/busses/i2c-designware-amdisp.c under the 
I2C_DESIGNWARE_AMDISP config) and amdisp-pinctrl (found in 
drivers/pinctrl/pinctrl-amdisp.c under the PINCTRL_AMDISP config).

>>>
>>> Also, is this really a mainline regression?  AMDISP patches are not in
>>> the mainline, no?
>>
>> The amdgpu half of it is mainline, the other half is still on the lists.
> 

-- 
Regards,
Bin


