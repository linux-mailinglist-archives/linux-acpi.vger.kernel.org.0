Return-Path: <linux-acpi+bounces-10442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D2A074F8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 12:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333C43A738E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B712165FD;
	Thu,  9 Jan 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVB+OdJG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4A1EBA19;
	Thu,  9 Jan 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423001; cv=fail; b=KkLkGMVRYvhwMOY6m1cpebjtt34Nqbvg5zsoBqVyVC75n3LS1hiqWyFhyXRZsnpzDp9jbSUcV1w117TJ3+BZm1kQU/LvSjl+Gnz+BFRtkQezQUhom62EeT8AQkqYCc6invA2wYj9paXXEvZ+1TTqyXnIxTYKbQJepdMNtVKJDBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423001; c=relaxed/simple;
	bh=DCJcsQxeCws1mfoal5BLW/gG8ejbqAQTzxflPRkHPwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqB53ktjUaDJeo+lbBZf/bfC7RKtavwFQZ8oCo/amSJPex6ozi8BZCUOIl/wHGShwsFBdwnxui4hXLo6FDhEUeL0CHJdMWzeIsRu7U4T+YW2x527ko2P7dI7OJfOy4EZBfi5p8ebTgqAzZlrV1wODYhFGifJLuK3i4fttXonzRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVB+OdJG; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6pKBnV/6boQHmMk1iqzq5Qd2VemkSGYOkjYRyQM2c9cK9967WS6b3vuEL/lbpwbYtyPMPWgJ80NLeuv5YlsIs22wJoPWmvjoJFAicqfEHyJLy7QnAORWicb0kXxKCvs9yLXJq9F2aCFI3cAU2wFcBBqw0oUY9ocj/3YeLdxuDi1IYoQS7i+2dsUikeZRWWcXeh3SOYEBcLcFN4v6EdO3Ev27TBDm+dflp1aIbDtGvoK5pTLsJFTRt939TDlLOG2lkmWcuesCcmC3KRxyzuoG0Ye81UtR0rzQEJeZR9OUU43KdjMhv2AYCQi/8nJLGtlB+NFM6cVR7ylnGK9+5AFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq5S7zUSJ8Ha0/h2Gk3J8zATbzZlYI4CHGHCmd1yjsk=;
 b=jLJgqzT6kRp8PFzB287lBD6r2UVjvsSRFF8u7a1/uthMm4h4Lh/ET8cZkK9VYrNc8WM/+3+F+S1Yf3rxatsYEzhUJPuFmWUKOPoQvPnWg12Dfm1zKLNMrTj+IhbDvtPeRlARyhcxiaudRZ2ZmLNRoGpzShO+YXR5mqr71guOKljn3LwfxXCXB59Bmc6U1oUJEailJi+9qVXyC+VEYoSNv/k5jj2mjSwIebnxneaZUmobVlAPF6j6j5OoAVuKvp5TraL9f0HAMAPQcawcR2xXooxHIb5zB7o05cEzGFHXbREWFPTftFAmufLmSmM0LFNeWqEelqdhjCj9zPCe9TwtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mq5S7zUSJ8Ha0/h2Gk3J8zATbzZlYI4CHGHCmd1yjsk=;
 b=oVB+OdJG3qWtkS5FwKHqZICm7jEe24Qwylg5jvUpCzQl3a+UR1w46wH+KAHtACwL4cMWHmILhy1+4m3ZfKQuvjEshk1p28AgT0+4VOrqLhcQb+UfdNPfBHRM3Bnyjtlb6+RaJNLPz7A/CgTiJtkvieCL3dOgP/a6DrgHGopPQRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 11:43:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:43:16 +0000
Date: Thu, 9 Jan 2025 12:43:09 +0100
From: Robert Richter <rrichter@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Allen <john.allen@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h
Message-ID: <Z3-2TWSdt2vFzUll@rric.localdomain>
References: <20250107161923.3387552-1-rrichter@amd.com>
 <20250108151037.GA1221136@yaz-khff2.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108151037.GA1221136@yaz-khff2.amd.com>
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0860a99c-c7fa-471c-42ee-08dd30a2ce21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWsyVEw0eHVlMmlxV21qQTFEbFRNTy9Wak0xYXpJZUZCNGlqZ0c4NUJYSDdL?=
 =?utf-8?B?bFh5YkdlR3U5QnlyamwwNE1HYkluZ3VpUS9rM2VkSnBoNWxvRTRTUTdIWHdp?=
 =?utf-8?B?WnRsNmJsQUxxenlKQnoxT2ZsOGZvc0xtN0hGbDJGRk5ScVR2RkM3VzR1OWp3?=
 =?utf-8?B?cDV3NFRpemdGQjc5YXIwV1RxRXJESEVNMUFYNjRyRTdUTldqUjhLYXc0dnZa?=
 =?utf-8?B?TnpIZ3liZnBoWE8zMzE0Qzl6cWlxWGNIT296c0ZLMGJzY0wxdzdaNWFLTzF2?=
 =?utf-8?B?M2hJZldCU2pLNEZFY1ErcGtRalE2RWJGOTZuK3lINzA3bkRsbjhZTnJjN2Jk?=
 =?utf-8?B?dmVSa1NiZHcyajF0Q1JPb0JHRXdFSnB4OWV2TXBoZW0wSElsR0RDSXdHU2RT?=
 =?utf-8?B?WENtd2tSaUl6VUdKdC81dFNjaTBHaWNXRDcraFRNZ2NpZERYN0hLUGo5R01E?=
 =?utf-8?B?Wkg1dmV0VkFRV091MzJuOUFsdCtRcGx4N0I1VkU0TWVxMDRYVm9ETnVCaWJK?=
 =?utf-8?B?R0hacmZNd3dIelJGSFJDL2pZYm40V1RLODBTMzg2N2FRZ21aWHdpbE5iT2Zt?=
 =?utf-8?B?V0c0NVhYejR2RlJMVXE5akNwUWszOWdKck9UamQ3cXFoa1UvNU41MG80T2tC?=
 =?utf-8?B?MmY3Uld0Rk90blRVQzdMWFRnbmFwQWtySGZ2WjJUZmVnbjY4WUw0b3pNTEd2?=
 =?utf-8?B?S1pXaStsQit0b3dkMkQwZldEc0hxb28zVXpRZjBCM1F3UTR0WSs4aElRQmxQ?=
 =?utf-8?B?NXk0eklFRmhGU3BsT01lQkJSclEvczhvVWlTVTRRNUpXUFJYYS9PcG9lSXF4?=
 =?utf-8?B?MEVBcXljTktaQlQ1SCtENEVDOXFKVHpWSEZtU2dQUjc0VmVUaThSb1QwaWVm?=
 =?utf-8?B?b2lrc2RwbmI4bDdlQ0ZzSDdIZzZIcDFTL3dGaExnRW5UQlM4dkc5azljb0VQ?=
 =?utf-8?B?dGkvNXRsQTFRWHhHaEQrWCswQ0hWUk1iMFNTSnJ3czJ0dk5zL09ONDc5Y1Uw?=
 =?utf-8?B?OWFEclJqTEdDRkYrZlBZYlozZ0NnaHRCeXBLNXNEazJwUXRJMzI5MXV5OXA0?=
 =?utf-8?B?NC9CbU90MkFlTm0zbU1pcHNaMlpHUGhrNlVrLzg0Ui90RkROSlpUbTJxeXRu?=
 =?utf-8?B?TVVMS3YvNFlwVFdzV3Y1b0NpVUpPdkFkeTBXQytqVlNSU2E2SEp3K3Q5MTY0?=
 =?utf-8?B?em1CY1oyS29GT1FJN3A3YUc4cnFvbXF3N2F1QzAvbTBRNXpsYVBFSVAyY1lT?=
 =?utf-8?B?WEFYajZkcjlqdVpQekhFVmpRREg2VnEwZ3BXbUtFcnZUZGtCL3NLM0xVdmZ4?=
 =?utf-8?B?UGRWQzA1cm45R3pydjh5eU5GNE9zR0Rac0ZMbTE4Z2ViVzR6QXF0enZvUTl4?=
 =?utf-8?B?bzVFa2pyRFRYRkIybG96TUorby9xeHQvZlN5Vmg1Q1dHS0Q3QU8yc0NCNUJ1?=
 =?utf-8?B?ZW82MnZJeUt1NDhnUVRvYnIySitUd2h2R0N2ajVkYmJ3ZmxMd2ZqUDB6KzNG?=
 =?utf-8?B?dkQvUm5Rd2k2SUI0TExMRWNKUkFFbUNHVk5LMVlCQXVtVHp0QVNIQU9LUEZK?=
 =?utf-8?B?UVUxTk5qRE1hUFd5MzlITmtrOXBVVGx2ano2NStsVTF0RXVqZ1hlS2QyZ3dD?=
 =?utf-8?B?U3c5MnRvakFwS0F6b2xsTU9ZSHhTUnIxZlFKOW5nZ0tBVWdUTjk3Uk9SWHVP?=
 =?utf-8?B?SHdKMFhCYk9Wd05lcERqS3RQYkxqcjRweWxtQXh6VUI2MHRpcnQ4MGFNQy9S?=
 =?utf-8?B?aWQxdThvQW5XVnRaS1U0Z2xMVjAweXJZS1BPN3BZTGZidDk4M2ZScHFmMHRs?=
 =?utf-8?B?MEJQcWFkc0JLVUxiRFg5UU1kSXJockxaV1Mya1BPRnJIRUxWTmZNOWxHMW1z?=
 =?utf-8?Q?W4zX3HNDNohpP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REExWVJEalh5MGFqRGtSM20zaGhrTzB2OXhwOHRMTGFmQ2RqMDhUUzVXays5?=
 =?utf-8?B?WW9OcnNEN1NMRGRISG1wT1dJTmpPWFJlQnIvY2VmSHpDUFdjUVlTNmNQUklq?=
 =?utf-8?B?WXR6RjhIVDRyb1ExWFdwMlFxRXFuVWwrVHJRLytMeW9IVGd2T3ZjZ2RyMkRX?=
 =?utf-8?B?Z1g0WGUyNTAybVI5d3k2Szc0aElPNGtPdG9GK3dUT1NIZ1VOOU80a2F5ZGho?=
 =?utf-8?B?elhvM1NUc09FaGRsT0FGT1grVHJ6SG1jbURoY2xKTmRIQzZIR1JxeGJId0VH?=
 =?utf-8?B?OGxFT2RHaFhER29xbXlweCtLTW1QOUVKa0NuNlhFdktJQ2plclZsYWtzTllC?=
 =?utf-8?B?SVJtZUVoNjQvM0Y4MlFnNkN3TDlpRlJaNktydU5ReFlDa2N0cWJReGYzcU55?=
 =?utf-8?B?TEkwUU10WDRYeWxqVGN6YjdGTElodWlwM0JmR29ndkJIU0FUODJ6Uyt5TVFs?=
 =?utf-8?B?MkovSEhVOTVWMXlnaVFNbk0zc0tQZWtpQkF3d3dieEJSVjg5WHQzK3ZIWk5X?=
 =?utf-8?B?WXpiK21VSFFqR01Nb3RTWFU5SU1GZldNRG1xaGlqcm9HQkhKVGc5MERwelVv?=
 =?utf-8?B?elpJMVJnYmpnUnVvc2VjWC9sN0Z6YUdobG1jcUl4NlF2U1pKWHp5dko3dFBM?=
 =?utf-8?B?YVo5QlprNmJlZnhpaXF6ZXFLbmhhVGkvUWx0YkVmeG05eWg4ZzEvb1paYjRF?=
 =?utf-8?B?a09Pam1OM1o5R2wzQ0kydERST2M3UWZ6YWRjY1lYalhsclNJUUtYUm81dDRm?=
 =?utf-8?B?R0RmV2xNVVRiSDc4SXI3SGUvV0NLTzU1eVBZVm1SUmpOazFKUXRzNXc2QXpO?=
 =?utf-8?B?LzBIVWNuQXd0Ykc5V0tscHNVQVVDNWI3WjMwNkx3MTJETWxTSmlSSnFCUFNx?=
 =?utf-8?B?WElYYjhSM2U1VEdYb1puN1Q5ZkJUdDFnNVlSQkJzZDZ0WUlhYWtJODVwMTJV?=
 =?utf-8?B?eWYwMFZGVDA2c3RGYnNObVd4RnF3dStEZWwzNEQwV1hLMTBGY2dKWVpHMVlE?=
 =?utf-8?B?RjZTVGpyZDMrQk52eUxUR2hFVmdNL3NKL01Ca3JTVlhHUkZMb01IZXBYQis3?=
 =?utf-8?B?WGFldnpzU3pDbXdXSGplWFVrNEFaZmI1NGR5ODFzdDQzQ1hWWk42UFl3cHNM?=
 =?utf-8?B?UEsvaGI4djAvK20rT01ZUlVBeHJzTzhzb3ppVHBXS3lybXpEVmIwSXNROTVZ?=
 =?utf-8?B?Zmh0L081S2ZLSEMxMVhodjdqTVQ3SHN3WEJkTUR0YzR4WExYNHFBMEFxbmxw?=
 =?utf-8?B?aCtkS0tMZzBLaEZtZDIxblVWem05Vkp2Zm16R1pNTHVBeXE0MDdobitzRjdt?=
 =?utf-8?B?RFd4V1pIcTl6NkpDdXlIOWhkVytGUTRxRG8zdmp4WC8wL01WVUxsVmUyMHlw?=
 =?utf-8?B?alJTOGRKbkdUUXN3dVFVUTBoM09la1lVMTJNSk9UTEZvNGl4QWZwTW9iUlUw?=
 =?utf-8?B?TWEydVcwbm5rZmJrb1B1eGVBd2ZUUUhnYlNGck0wdVpIRlBaVXlCMXhOZHcr?=
 =?utf-8?B?NkN5dmwvalZZbkZicTYvYzl3ZTFzcGZEM0pJQXNZbzRoR3FKUU5MYU5VQXdu?=
 =?utf-8?B?M1M1bWxHNTBISkU5aDlFQUdNcCtCZ21pWUp1NDhIVHlHUGF2UVpKTlgveGl5?=
 =?utf-8?B?WFJjOCt4ZHNpUHk1NmRhbnVLcDJYVHJPSkhuV1k3bFRsVEJzQU5ZNFFZRUl5?=
 =?utf-8?B?Z0h4azJJemNoYkwrOEhJaS9CYWRXbkNSTkNFczJ4MWdJYkpTQmMxVmMxL0t0?=
 =?utf-8?B?WWtpRFJXbUFURWJaUktHdGdBOGFJd210TzgvRE9nZ3B6YlVLZnNiRFo5cll0?=
 =?utf-8?B?SEJGWm9YTUgrdVFwNW1zVmNGYVJxS203ckxiSUN0OHBwbEJEQm9LdnlOTlFP?=
 =?utf-8?B?eEVoSzBsMzU5aXk0V0dLdzFUNGswTjhJUHRFbjNuazR0azRqK0FOdTg4aXhI?=
 =?utf-8?B?VkVDai9Scm5FK0tRWFhDSnRuZTBzaVVsUHUwa1FMenpwL2FoanJaak9uanJw?=
 =?utf-8?B?Nmh2ZC83V29lZ1ltUjJFaFpFSE00VGRuSGcrQnlBbkVuV2ZZYWFxaXcrMTV5?=
 =?utf-8?B?cVcwTEtQc0tsbXdCVEdiQ1ZsVVN4b2dUNks3Wk5maUFuT2grUmRieXJSeFVn?=
 =?utf-8?Q?UDoaeMorSo2vT/7T6V+2pz3/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0860a99c-c7fa-471c-42ee-08dd30a2ce21
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:43:15.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6In1BwFzvGDDPDpIL8ei3SUBoQDzzSXuyl2CPIVvD1k9C09AdgDDq/42qKB+fe0n+lxnVHF1qcDghg+gMzsO4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

Yazen,

On 08.01.25 10:10:37, Yazen Ghannam wrote:
> On Tue, Jan 07, 2025 at 05:19:22PM +0100, Robert Richter wrote:
> > Seen the following build error:
> > 
> >  ./include/linux/prmt.h:5:27: error: unknown type name ‘guid_t’
> >      5 | int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> >        |                           ^~~~~~
> > 
> > The include file uses guid_t but it is not declared. Include
> > linux/uuid.h to fix this.
> > 
> > Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  include/linux/prmt.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> > index 9c094294403f..c53ab287e932 100644
> > --- a/include/linux/prmt.h
> > +++ b/include/linux/prmt.h
> > @@ -1,5 +1,7 @@
> >  /* SPDX-License-Identifier: GPL-2.0-only */
> >  
> > +#include <linux/uuid.h>
> > +
> >  #ifdef CONFIG_ACPI_PRMT
> >  void init_prmt(void);
> >  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> > -- 
> 
> Hi Robert,
> 
> This looks correct. But can you please share how you've encountered the
> issue?

sure, I have used it here:

 https://lore.kernel.org/all/20250107141015.3367194-26-rrichter@amd.com/

I just included linux/prmt.h to get the declaration of
acpi_call_prm_handler() without anything else. I assume other users of
linux/prmt.h indirectly include linux/uuid.h with some other include
file.

Thanks for review,

-Robert

