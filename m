Return-Path: <linux-acpi+bounces-10509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8406A09444
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF97A43D7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419492116E5;
	Fri, 10 Jan 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNCaBU/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FA211473;
	Fri, 10 Jan 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520486; cv=fail; b=r/RgB07MUtJjpU16O6MuVQ94JBYnaAUNVKe+zY1BKr0VYQaqjHLBFq3/thkeypXUbQIa/puoMEDgsIM/da+MXyiQbRAAoFESBJ6gkinaanQKDdXejXmslD7VrtL2uqjXGJxyTVN0qqFlsxYf+6ZyzsIPvb5QlhRx9lBYI5ba3t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520486; c=relaxed/simple;
	bh=QoO60ZlLnJbC8z7BwMwGSquRKXksY/lTFSety/Dufuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJCz6fZ56w9tndYWyizrJHFSqSckV5Fwq++cXIBERuw2kOj1ZmAiOeBdnx8pdrsHc/If+ZbjvHu8K0CxSY80xm3+FKweQFrpVRGKjzPrkvwcDx7vdrrkKqos2pKNDwWAiCJcFK4H5EVyXEGFlBw5I+Nt2zR/S95pV5aU3Q4htvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNCaBU/L; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAFCsYMO+9r60cvguRkgQmA3dhT41NFWyvJd4IVtNyr4megENujNfKdGrPpMmwNigx6mw80dg+pnyONHRt1tAe7+vF3z36mdqD/rE4DDlMUN5zay+6HxnEyx5225cLiEfB0Dt2GW0DYefQ6R6MOig45X6a/k9wgpztuQX7eWQ5wG0bNNRh2k92N329/H6MJ5p/9ocWlJjQOGXlvrYYmZYxdXskT6j2pH0i4qU8VAHC7XTsTwtI6ZfFP2aFm1yOSh5W8lEFcuUgEkjxR0JdU3ANCxQmsY8hX7z+VYyVBE2Oh4sfW922GHJsngHD/kyRGCUB7YlcMJFSgYZEK2LuAI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xozXw7goWLCytuhOg7HsNeNxtNEXnG0C3i0npPVqNFU=;
 b=OYyWwKKUjupZgJYKMtLeNuwejFE2Njh6XObVkQ31MbjBJXMJtbPRgFzWPZC4R0atgkuIDXULZmcmeVY1mRMh2EwlH9z59jmQ7qtBzwZzCzp5XlL3AR6wdAAPCMHr1KoqM+jSGU2xSXJ8mN4xDqRxOcHl9TnzU5xxCmJXwyvB3PTyBSr7k1C4ywR9L4TMXNuj13MG4SOQWiNpX+UCBJibACAkfloXpYqcO4aG313kjyXzpK5kaQIYvsJILVkRoo8CZDOr7aUP1SSjgu4qwzcz0aGSU4AKRtelnob1vEbj+0I/fMH8qE0mZJ0XqXDW8HoSH/S8bM1r1eQz31XjIim8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xozXw7goWLCytuhOg7HsNeNxtNEXnG0C3i0npPVqNFU=;
 b=WNCaBU/LZVUWJrNa3bv98vVvkPd8cDlvGPv1fOjun7IcgwE7o+j+309YGVEetnN7odG6orXVagE4zmrqBTJatIT9/GMvVzlzGWsH7O4WuHIgweIUt1E+KdvlVqILCbyVDARRKSiuoeIfwptqiaPptQMpm2aVEnqyH/QBAMuk2rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 14:48:02 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 14:48:02 +0000
Date: Fri, 10 Jan 2025 09:47:57 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Allen <john.allen@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h
Message-ID: <20250110144757.GA1641025@yaz-khff2.amd.com>
References: <20250107161923.3387552-1-rrichter@amd.com>
 <20250108151037.GA1221136@yaz-khff2.amd.com>
 <Z3-2TWSdt2vFzUll@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3-2TWSdt2vFzUll@rric.localdomain>
X-ClientProxiedBy: BN9PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:408:f4::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: c25d489f-94d4-42a0-b86e-08dd3185c857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFNTbUFVSk1BaFJ4b2xqRmRERHF1S1A3c0huRTRpblBtUG8rNktRTUhQbzR0?=
 =?utf-8?B?WlFhK2FydmtOaUJxNkFjeGZ3V2xhSzA0d0g5Skh6UFBUQ1JMdlJYRFhLTHd2?=
 =?utf-8?B?RHdFMmZ1WUNwcENCV0UyTGZyWGpySXNBczByUG0xYVlZOUxBNm1NdVlqOXl5?=
 =?utf-8?B?OFY1Z2Q3RmVvQ0pERUNOSnBHVjhUV3QzYzgvKzVnQk5kaFNSQzU3K3I4cUZi?=
 =?utf-8?B?VlFZdW1meG9WUjFjcS9ya29OZUt5T3VTbHM5OFp3eE1xZUR3T2ZxM1N2ZkJ1?=
 =?utf-8?B?ZmFMcURUd3Q2N0RlM3lsSVZxSTh5Mkc4ZkxuN1QweEg2dUV5MTVrUWFlTEdm?=
 =?utf-8?B?WG1OM044c3VKSzluZ0hUN1NSQVVNQXRIT2kyMHBOVmVad0JsQjF0a2ljc3ZD?=
 =?utf-8?B?aElrbGhpTVF4QUk5QUpNRnV6WTFmTG1rWWJSbXFHTXBoUFlORTJHSFlaUERF?=
 =?utf-8?B?cW5JYVRNcDFXdktaVXJ3SDlCMisyem5yT0RDMHdGbHRJVDVZVTF1ZGRLZUNH?=
 =?utf-8?B?ZHpsUVllMnJtY0pZajUyeG01R1dxdnUyd1FkL2NtWlN4NEhhTXV0ZHVCVXNh?=
 =?utf-8?B?MEFCclJCc2xqSGhoZWlRZ2p2MVZpZjMyK0RwN2NvemFtUXByN0xLR0Y0MHZC?=
 =?utf-8?B?QWQycjJBVW5wK2JkVDFaclA0ZUxYazcvYmxVM3JUVmJqZDZac3NpUFdmc1kz?=
 =?utf-8?B?UGxFaCtNT1d3dndVa2IzaWdZUVhTWnk0RUEvSHMvMS9XWGlqL1pqUStmWkk4?=
 =?utf-8?B?dFRROXQxNGtCQzJuMGRJZWYwS1FjdzhpVEhoRS9SQkt4M1RnUU5RanhEemlR?=
 =?utf-8?B?VEZOeXJBdnU2UHJISEtDZkFYRlNRQjMrL1hzWkRtZHJBVzg5TVlEelQ1cFIr?=
 =?utf-8?B?YUlSbnRNNVozU2dKWS9mSW5CS2U5bUpEVWlGYUQvdTVpYUhHQUVlemVTWHkw?=
 =?utf-8?B?RkI5U0dvd1cxT1ZMbEZzMnR0WlNkdzh5SFV3TzdhZm5vNGh1MnE3R3BJbHZt?=
 =?utf-8?B?b3BlWEhjQmQ1Z05ZYkRqK3BKc3g5cWhWNjFCTzNJc0ljdHdvbVB3UkNoQWJn?=
 =?utf-8?B?K1JFU3V0YkJVVlF6dEZLYXRYOHZvMXVlbE0wbmZpZ1Blb3JpTXpoWmwvVSs1?=
 =?utf-8?B?OG5qSitQVFhabmk3blNlVzJReDZqSzFJaVhRck5YRjV5YlM0WDN5clJ3YzIy?=
 =?utf-8?B?TzVRYXlIbnNreG04ditIelYwRVN6RzhCZ0E5aXZqbGZISE14VnNxdWgyalZo?=
 =?utf-8?B?WmtXWUlIejRoaE5aeS9OcmZ1ZEdpdlA1Ylk1TGFtcWUyMjZ3TWtMOGN1NEhG?=
 =?utf-8?B?QzA2ZG10STJzZVR0UUhaQnQyTzBOTUtkV2VJSzZtYTNjdjBMR1VVNWRpV0NT?=
 =?utf-8?B?WFVPblhnQWFsaE1CVFlpVHhJeDNmWVVVYTAwbmJMMzlWeFNYK1FucHozQk52?=
 =?utf-8?B?eTAxLzVXY05UdC92NkhPNkJrKzJmd0R2cUxLSHlIMmREQzJPYkdsRDdRMzBG?=
 =?utf-8?B?eFNQRHlYakZjZnEwUmdTOG9rTDhMaFNYVnQyNkdsL1ovVW5VT1dMbXdYaVEy?=
 =?utf-8?B?V055a1M0TytBbjF6YVA3dVk5REdRWjZFUzNuZWVRTG1sdS8yZGtFaG9tOU9Y?=
 =?utf-8?B?RjN1OENxNktQaFBsTndvVWlMZm8zYzIvMkpBVmZoNDk3QTcvOENmL1FJWnJy?=
 =?utf-8?B?Wk1PdFE5YXFsSStqajFpN2dibUE4bEhxaVd6dFN6WjNXYWJsWTdySnVMUlN5?=
 =?utf-8?B?b3JKWGc0NktEN3piSFM2OXRLMXFGSFQ3MnBuOGxyWTJTY2g2c0JoN252SWpL?=
 =?utf-8?B?eUJNYWVVY25Fb1pVSnJmREFkc05ZTDN5QXEvdjVTeCtBb1RXaEpwTlhJaUZx?=
 =?utf-8?Q?OugEVnInDnPUq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU40TzQ4cjRFcXJRQU5DNFlwUzN3V0l4cThoN09hbThzOXZOODV4T2l6dHZB?=
 =?utf-8?B?Nzl1UWVydE9aZENGdTlEZEgvbmZuRkpYWkxPc1VHZnh6VStVT3JvZGlqaGUw?=
 =?utf-8?B?RGp1ME9UNVpoa0pOOEFaUzZUQnNBbDlRWXNOM3FDWFVvNE1JbXkrYnRFUDVi?=
 =?utf-8?B?ZkVYQ1RFNWNmRVJFeDZsOHNKUXpBN3NRdU9ialRLQ294b2xPcHVLWE1vc29W?=
 =?utf-8?B?b0w2RmNiMGtqOUhFWW43SjJJZE0xMitNVnVpNThDU1pndWVzcVFIdXM1c2to?=
 =?utf-8?B?c0RSZlhNYyt2Z0JjWGlqWmc2cmRVZ0t4bWMwTklGeDI3QWlrV0MwKzRxb0Zs?=
 =?utf-8?B?S216WDJrQ0JWT2tXOFB1U1pXbkRYZXJURWhVSjlqbGoxeDBzb3F0UUMrRnpO?=
 =?utf-8?B?OFRReHFSSHF2TlhHZDBZOVZMR1VWMFhyV25zV0ZYYTJCQ3hBcGZmWWYra2Zh?=
 =?utf-8?B?bGo3WEFvZVcySG04S2c2clBKcGFUSm9RZEJydWVxNkJYdXpCOFBxbWY2dDU3?=
 =?utf-8?B?QUd3eDFyamlTZ3hvU3VnL3oyUzR4Y041eWt2bm03Z1VsT3B5RUQ1cnR1amcw?=
 =?utf-8?B?elkyd3BLZ0JndjdoR1VTR3U2dW9RWTBucEJiSmZ5dVR4Y2Uzam40aXFZM1RC?=
 =?utf-8?B?RkdJR1hncmRNMm42dWhlVkVxcG1aZ0VjbTFoenVaRmNtZzFCRWNCVUJDZXFO?=
 =?utf-8?B?ZHBsaWYxb3BYZnYzajI3TnpDcC9DVTZPRG52NGdoSzJWWHF1YkJ0KzRicmpS?=
 =?utf-8?B?YzZwanowUlpIaVRGMXRKYS9LYXJrUnJxcnRvcUhTOHRsRlhWdk16anFqS2lo?=
 =?utf-8?B?TWdQRWRpTXcyTnJGZEc1LzZxSlp2SVROMTk2M3pHRURRY3p2Q3BtUU1VVDhY?=
 =?utf-8?B?aTFWYnByOHJMdVQ1a253VXRPQkp4bGhZTUNkaW0yZ0ZZTGVnUDlDc09DMWZ5?=
 =?utf-8?B?YURqeG5FanJlQzFVRFhsZnNmS1plYmthc3phbUwwMUpRWXVmT0w5MWQ4bmxL?=
 =?utf-8?B?Qjd1UjFyVnE5V2R2bUdja1pXMGhzQkl0Z1cwMlpVaXp5MzJLTXc5WG9zNjlu?=
 =?utf-8?B?YWI2N1lpdHRkWHJOdEFDaFBYMDhkWGg5M0VkTkdoN0pVV211TzhXTEdkby8r?=
 =?utf-8?B?SVFkWElhT1lEc09CVnB3eXhJQ0dlbExFMnhZSGIxOUt3KzRVcHpmMXNNNksv?=
 =?utf-8?B?VmZhVmFFb3RtemI1cW5VdDRZMmRJMndtdUg4c2huSnNnRVVES0Jpd2F5K1Va?=
 =?utf-8?B?L0hVRWNUcTgzcVVOY3FUQit2V3VxWC9RdURJeUYzYXVycmI4VHVZdUJhU3ZE?=
 =?utf-8?B?QklnWUlPZGFvLzFjWSt6NkplbmFnVWNFS2RzdU9oNTR4WVZvMCtERlZhbWRN?=
 =?utf-8?B?WUZoZ09ERStBN0hCUTI0ODdEenVCKzJuSkJTQ1AvNGRyWXRLd1ExYXFPY25w?=
 =?utf-8?B?M0NmMXRLY0RxeWIvLzBiNGh4L25mdW0wWlhnbncwSUlmcWl5UFZIZkErNXZJ?=
 =?utf-8?B?TDViR0ZyN1UxeExqWEFkTFp4ZVJoYk9xQk8vSzVSVUpJZFZzbVlsMCtDS1Jq?=
 =?utf-8?B?bk1hYjFvZWdYcCtrZGEvbjY5U0E5UHllVXVFUVNQWjlJeFAyRjkyQkw5bEhq?=
 =?utf-8?B?Q1dUSGNmVG1NUW5RK1pNQnlvbjEvaDBhUUJ6NG1wMVVONHlKSWt5ZGg4cDVC?=
 =?utf-8?B?YVg3aUlVT0RuWEtjaUlZZFZrcWVFZjFQYllkbXFHdFJXWjJVTGxrNUxaRHNT?=
 =?utf-8?B?R0V5dGZnZHVwdm9CS0VUemFBZzVGNEVIa3U5cHkyY0cxdjc3RmF1K09rUHBN?=
 =?utf-8?B?TkUxbjB4ajR2NG80NVpsazFmZXhROW5RR1dMTnh5NDdUZ2xKdWl1NmhDNUQ3?=
 =?utf-8?B?b2hOQS82bUdGS0NCdU9SRHRETWd5Nmx6YlVDTVpkbFJxa0hvK2lEczBIVkpY?=
 =?utf-8?B?TDdHb0puOStDTDhCMGVZQ2JmNUQ0TlJWbTFRRkROSk0zclR4TmkzNHZlWGIz?=
 =?utf-8?B?amdKLy9iYTViWDBxNzE5YytYNGVlY1hqdU9wMXFjMndUSGZsNmdQNlM3Y0p0?=
 =?utf-8?B?amo1b3g1WEU3ejR4YWFGQzZRUVl6d3JUQlI5RVhQNDhtbG5lK3BodU02VHYx?=
 =?utf-8?Q?cpBwvhdCZtN89M5EMGQHVCcoN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25d489f-94d4-42a0-b86e-08dd3185c857
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:48:02.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Aal+a4eISwIU8ZQJs/yI9RB7lWbAzPlhr3//4MYQaVOPhaJu/N02B3km3KXqAIz9CyeVdSWPslpsOYH5Qu34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

On Thu, Jan 09, 2025 at 12:43:09PM +0100, Robert Richter wrote:
> Yazen,
> 
> On 08.01.25 10:10:37, Yazen Ghannam wrote:
> > On Tue, Jan 07, 2025 at 05:19:22PM +0100, Robert Richter wrote:
> > > Seen the following build error:
> > > 
> > >  ./include/linux/prmt.h:5:27: error: unknown type name ‘guid_t’
> > >      5 | int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> > >        |                           ^~~~~~
> > > 
> > > The include file uses guid_t but it is not declared. Include
> > > linux/uuid.h to fix this.
> > > 
> > > Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > > Cc: John Allen <john.allen@amd.com>
> > > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

> > > ---
> > >  include/linux/prmt.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> > > index 9c094294403f..c53ab287e932 100644
> > > --- a/include/linux/prmt.h
> > > +++ b/include/linux/prmt.h
> > > @@ -1,5 +1,7 @@
> > >  /* SPDX-License-Identifier: GPL-2.0-only */
> > >  
> > > +#include <linux/uuid.h>
> > > +
> > >  #ifdef CONFIG_ACPI_PRMT
> > >  void init_prmt(void);
> > >  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> > > -- 
> > 
> > Hi Robert,
> > 
> > This looks correct. But can you please share how you've encountered the
> > issue?
> 
> sure, I have used it here:
> 
>  https://lore.kernel.org/all/20250107141015.3367194-26-rrichter@amd.com/
> 
> I just included linux/prmt.h to get the declaration of
> acpi_call_prm_handler() without anything else. I assume other users of
> linux/prmt.h indirectly include linux/uuid.h with some other include
> file.
> 

Thanks Robert. This reminded me of a rule, but it took me a bit to find
it again.

Documentation/process/submit-checklist.rst -> "Review your code" #1

I wonder: is there a script, coccinelle test, or something that will
catch this in case we forget?

Thanks,
Yazen

