Return-Path: <linux-acpi+bounces-21191-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO4FCz1VoGlLiQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21191-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 15:14:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A31A74C3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AE8030A22FE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2073D3D07;
	Thu, 26 Feb 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZEfKci3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680643D34BD;
	Thu, 26 Feb 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114392; cv=fail; b=r0MCJiOXCJoy68pJwChNQbp2VZVgt9/qEfrBGj36oaeKr/ih0gDDqMLjHI2hLXq8iEcU2dRyMZO3fZ4FHA7BQtfIUBwTaLEa+e2eUi8z31gG0LCFBXQ/2Kb3Ltd/d2rjc63Pry/D8ppXGW+0RjL8Ark6dLRr0WzrHWqaG5fGC1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114392; c=relaxed/simple;
	bh=GgcwJ5DiSSCvX15O/IgbDJF0NW3qwY2HAuNE5KeD6Y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RbB2o/3Eg7oqAWFHUM0+8tL8aMbFcov7jBa1GCgAy9EA+LzatCj/+k19B3wTzI5PiHYUcjSdMQDn4Ai4tG4MCiqjcGlzpmAtRBzz6TsCBfIKQYeKJanZE5rWuaRpO1O2q8BZEWSCWFwkkEfo73m4148HOLiCkAmkC6IVHqEmxno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZEfKci3; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYFftD7zmm/JtbaaZ4K7VuGkFni3FMh+JtKItcRGTnABIEvx50xFf+bVGHx0h9iNgQiNDqaIoRTlAcLPQPXaVL61mO49yJGicYAhyXCwn6Sbva0DQtQL/pdC//u8KDi1YG4/DlL2OxD6fXDczgIQckIcFEWiQIOD5jI0+nvDOsJS5gnsO4zmCuaHgS83Pt9sD4Z7Y6PH78btU0GgVoIKpEFNOT8/0yBxvntoZTx+h14dYbgqg80wOHfwaiDgCkujw53AgyRRfwlGMNV1qWFJi8PX+9fCiBBoojJI/ypWBkZkWarlllCpMP5HXnsVNSkeTQFal81osSnjrqUCAIKzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl9BIvDm33OgP/0zKgy46hyOocKbKotca0EzWuVFc1w=;
 b=cchkpC1R1FZLsEKsChVPTJPKnj22fszjf3vumEC+E/fbSTpBCTrZ17NIKA7CiFc92Fjkg1kZOZS5q+W6wYmyMfO5A4hJ2eZ7D65xbjg2l/LT7pjbbvCg8mGx1fSML+fRlwpFLgt0x9GWe86KAzSyD/m3VZfJEbKVdPbpZftWTmU9Nn4UTu0Tu5wYGGoSBNtgM7upRwiEsxSfNnbKJqYapd7RhgNoXhxyjYu23RDgbN6DFi+n7ybcglY4o09gjWzbUJ35rJKSZDq0YuywXn9R2hZ2IRbGlIVAoEgKgWC5mt/zCWAu8/YOWr1/jDmOo6dPT0/u3eu5sX7tIM9xPBnHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl9BIvDm33OgP/0zKgy46hyOocKbKotca0EzWuVFc1w=;
 b=UZEfKci3EVWCug9unWJ0MzdssFzNnmzsX16sn/s7xLhXCirkHyadNMzcC1dVt4ZCyWD5A7zi2vucN9RTtb26jas3lgrdYlrdCdCVgV9lv0XdgMW+8haNYp6gWUkyupCyFQJLG2/8eu3Mpq97aNorvNo6HsboBPtTuGPzA5AIDUJY9JZBXEyeibbv5CROf5w2/ewT7dwcU6lGx9Nnwwo9EZsxQNNvDENNEuEQfmmXhSlGeG9qcWA2IZViX/gcuK8MTpaXryOjpcsaJjzrhlXsgDx9rLLOc4eEBnUe4jQkwC0J2/I3LtbgY6ZbaiVajmZReOiOr2uMkdTLovLF8SWdZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 26 Feb
 2026 13:59:32 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:59:31 +0000
Message-ID: <48b52f98-119e-4693-806b-78d47f7a43bb@nvidia.com>
Date: Thu, 26 Feb 2026 19:29:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Enhanced autonomous selection and improvements
To: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, ionela.voinescu@arm.com, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, yumpusamongus@gmail.com,
 dedekind1@gmail.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260206142658.72583-1-sumitg@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260206142658.72583-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 11db8885-edf0-47e9-0ec7-08de753f438d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	dMCTXaxB6DycIXQk7GzZVUuvhn8j3+YVnOQFBrOPrXa2o8rsYioItJ+zJK21wIwdGL1YAN+ovWLdp3503ckcqQDMUPc26IV69e0O/VplkzHmQUJPVnp15SHgwl6DW3pyAozM9QxI0u6toFSCG0TWjwKrmEa5x9ILAOzDAodzUXXpePxoJMGD+NF6Sp5FHsmcCMk3URZsr32WE2T9L57T65PPlxTLn3caGXnX2ILAksLJ7DfhCNtP/3gzzSfh1pHrrWx6Wy7jNwFYM+k5AtMY15oYwyiTc1aMQmXYnFVAgBMJETDulhzpWjinxx7Ig2hGb2S+zjz00H8x3BccGYBestnUtTSsIHHvWajyo+JonMyX80pDq0JjVCM0vvP5851INysafZybO5l+TRbjmmlcKrJNYOu93Z1BWgpiXYOAUn8gk1Z8t++0G6vHN9PtebznUADE1N0ZiKOdYo8gHwJGzty7cLiwCfDiVlfRqMFNqqYzysb5OuaDPcNsx+kLFL0NM12588mtbygWfrMlrgyyCRxIPhwqMD3mgIRTEH+IpnGrMp0dQlz5H6x+2S3wi+QiS+JjPZnC251GPQ2LzyG5bsEnUeKjvg+BlmePNJdikUDKB00e6Agfc/EHRdD89WMSUEylLHDqj/I4BFs76FqLp4RW5Atjk6ObAk/YJrtFA5ZZopJYvNyO0yr7O2o4i9VTmMa7LatqyNd5ibuBT9jyjEsq65I75GZci+kptqDr0HbH24qMM3wfstt56wcUQkI9ZLKA29L/6c8V0jg13RWP/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHR5QkIxdUo4R2thR2ZaT0V5SXh0NjhlVEJQMlpIUDJUMThrL2FqMXU1dTla?=
 =?utf-8?B?N1ZEZGl0b3VVNW5FTldXVFpHUXN5eDdxUmZQRkMwVUUyS0Q4OXlEUDFBY0hI?=
 =?utf-8?B?c1JPQldVaUoyaE5zcHdJM1N1T0IvNDhQSlVUUG5IRXhOb09TRVZYMEV5M1lV?=
 =?utf-8?B?NWlGMklJSi8wMERnTU9mYVZWd29LdXVYQ1pKTk5xS050UnR0b2hGWXdtYmxV?=
 =?utf-8?B?UmNORG5TdHRaWnJSb3lOU2Jjd0UrSWUzRERWS3Vubnd3UmpDcUJPM3ZXMnAy?=
 =?utf-8?B?QU5BRGdVczIyVUFtbFFZRzRYN0xOeFkwR3FYWWxNbkhRMkgwZGpHdlhNWU1y?=
 =?utf-8?B?MVQxbXhJL2JHMWJuZnh4VmtTV0ZLUmkyWXJpQ2FtTm81bjhEV2dNS3REcE51?=
 =?utf-8?B?eWtaV0k3KzhRNVVQYWxjQ0o0YkVnSUw5eDUyY2p4N1I1MXVTTlF2Z3BPWFJS?=
 =?utf-8?B?Y09uTERwN3YzNnFIN212U1ZFSFNTVDhNRGROUTkvdnlWMngwbjJGcmkwblM5?=
 =?utf-8?B?b2Qvc3llYndnR3JuaTVnNnp0YlR5Tkp1SjdOODByL1ZxOFI3VnFWaWZMb3Fl?=
 =?utf-8?B?TEJ5bnBEYm92dmJidFdESWxyaStiUkNJR1k3RkcvRGhhbmhKamFYR3BvcGZT?=
 =?utf-8?B?U0VOU3UyZTA1NmE4R3FncGxreUZ6L1pGeXpTNHczTUVPQ245VWFkY000SENX?=
 =?utf-8?B?VHI2cnI2V2EzTE95b05RcW1xeTR1bmNibVp1NFpLcnpQZGFtTVBMNzNNQ21N?=
 =?utf-8?B?Vm5pVFJsdmpMYkhZM1ZiTEJjQ2E2ekg0Q0Z4aDVPSGNSNTlSa3RMTFlsZis2?=
 =?utf-8?B?TXhXcWFXcXBlMmRkVmpxK1doZDA0N3Rya1pQYUh6OWQ2SU16NGdSLzcreHNs?=
 =?utf-8?B?VWlKNXpZN2VyQ0I4KzN1Qk5ZUWZxQ0kwUUNDbWd0S0NVMzB6WmZDOUwzMmxw?=
 =?utf-8?B?WXhjOVhzOHd4RjhnaWdsVEJzZWFXOTNSTkhRNmFIMlVpejdyT25IUDNNNlBj?=
 =?utf-8?B?Wm0ybk9mam43NEhmalBJUWRlYjhycUErck01dHhLYTUyQ0JsZkNBUWp4RDZZ?=
 =?utf-8?B?b1NibWl3VEhyaExFSkdwWVV0bWxGbWhMZUlvWjZHbXZQVy94MlJjbVNNSGFq?=
 =?utf-8?B?QTAzNCtsdFhHMVl2MTR4WlBGa3RvVkxGSTBTUzFMQ0E0NGdIQVBHdGcrS0VX?=
 =?utf-8?B?MFB0U3hKelJ0cVowRXNQUWUrTG41MjZSTkgyRzRxV0JzOE1VTE95M0RVUjRC?=
 =?utf-8?B?N3pwdTFwTitvUndPY0RYeEIvZXQ1MWNrZyttM3JxZXc3ZlpzdjBqRERHb3dI?=
 =?utf-8?B?U2dYbWROY2ZtYUVwS2k1KzJvY1ltSmpHMkI1YnhPWTV5L2FrQVlvR3FvclRv?=
 =?utf-8?B?VDl0VXhXU2pkbTg3bGJGbTJTRkZ1OW8zUGgxb2djT1YzRm1iUDQ4Y2EvMmFw?=
 =?utf-8?B?b2MzUEU4d0pNbUR1WHJwNllUL05XeTZhZG9pdTR0czdrTlhXTXRQZG9XTWdX?=
 =?utf-8?B?V2ZkelRGSGpwcHZyVUlHV2Zpb2xGZDhEaGtnRE9vV3ZwdHZBSkEzSnpRZVJI?=
 =?utf-8?B?dEJNMkdOM3BpMjh4eFVUT0theUI3Z1JPWGN5eXhRQ0psMnF6MkE5Y2ttVDFN?=
 =?utf-8?B?ZjFDeFNtVVlDaUdHMlhtVzhpazR1RTg4TmMxWmVFaCs5UXoyVE9zNVZxbXBo?=
 =?utf-8?B?MVNzM3EzS002MTF4QXRxUi9KL1hYQkdQUUppT09zZUdtYUkvWEl5MUxzUDdw?=
 =?utf-8?B?ejZ0TUt3aXE5K2Yvbjlxak1JYWNXZEhpbWwreGZ0UjltOHFWMkZYYWNibnla?=
 =?utf-8?B?Zmg1VXJOZHBIejU5UmVYUzlxRE5PYnRKY1VOYlEzRWhTbXdBNk5aMTArb2tR?=
 =?utf-8?B?Y2Y1MnRGVXRtYWJOR0U3WGNkT2dIc2VkV1k0c21qYzV4bDBRcjBRUGE4N2Js?=
 =?utf-8?B?Si9Ha2pnSEo2OXNwYkE2SWl1QUYxeGlUOEkrRzJIWFdPNGVSMGQ3bytQbTFG?=
 =?utf-8?B?T1ZhL1BkTkxZZTRDNDQ3eFVZck10Z0swRXZXakNmOEhiWGVNZ3dRTUdLQ2Jk?=
 =?utf-8?B?bjYxV05UYkh4WUl6N0FxczF5WVNoWUEvVnBPQzRWdVJZR3NsRGVNZnJ5aVZW?=
 =?utf-8?B?VVY3MExpTmEwZTkrbGc4LysxNjhaajRadXFLWXJST1hHZi9UUFJvTDRyMzdH?=
 =?utf-8?B?M2h4aldRV1hXQ2pKd2E1M1IvM0hkU1crUXJrUjR0Q1ExbEdORFZKdnBxQ2pQ?=
 =?utf-8?B?TVFxQURTR1FKY29DUTRidlBWUzhLY0dLSHU1SnBnc0oramxoZ0pvWFRhOHVX?=
 =?utf-8?B?QWMxaG9ETmV6TENINU9EY1MvRC9IbENVckdEb0syZUJyTjF0NTdpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11db8885-edf0-47e9-0ec7-08de753f438d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:59:31.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXCNjH+b8awZmd09f/FswJ/CIzSfYy2j1QwP+bf8Mszx4RbMLJJHgkXtAKN0LJXrIYQQ+j1ybuBpniv0vWm3Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21191-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: BD9A31A74C3
X-Rspamd-Action: no action


> This patch series improves the CPPC cpufreq driver with new ACPI APIs
> and enhancements for Autonomous Selection (auto_select).
>
> CPPC auto_select enables hardware-driven CPU performance scaling using
> Energy Performance Preference (EPP) hints. Currently, there's limited
> runtime control and visibility into CPPC performance registers.
>
> The series adds cppc_get_perf() API to read performance controls, updates
> MIN_PERF/MAX_PERF in target callbacks using existing scaling_min/max_freq
> interface similar to intel_cpufreq HWP handling, and exposes perf_limited
> register via sysfs to detect throttling events.
>
> The patches are grouped as below:
> - Patch 1: Add cppc_get_perf() API (independent).
> - Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
> - Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent).
> - Patch 4: Update cached perf_ctrls on sysfs write (independent).
> - Patch 5: Update MIN_PERF/MAX_PERF in target callbacks (depends on 4).
> - Patch 6-7: APIs, sysfs and doc for perf_limited (independent).

Gentle ping.

If there are no further comments, could this be considered for merging.

Thank you,
Sumit Gupta


> ---
> v7[7] -> v8:
> - patch 4 (v7): Dropped min/max_perf sysfs patch.
> - patch 5 (v8): New patch to update MIN/MAX_PERF in target callbacks
>    using scaling_min/max_freq interface similar to intel_cpufreq.
> - patch 1-4, 6-7 (v8): Added Reviewed-by from Pierre and Lifeng on v7.
>
> Sumit Gupta (7):
>    ACPI: CPPC: Add cppc_get_perf() API to read performance controls
>    ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
>    ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
>    cpufreq: CPPC: Update cached perf_ctrls on sysfs write
>    cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks
>    ACPI: CPPC: add APIs and sysfs interface for perf_limited
>    cpufreq: CPPC: Add sysfs documentation for perf_limited
>
>   .../ABI/testing/sysfs-devices-system-cpu      |  18 ++
>   drivers/acpi/cppc_acpi.c                      | 170 +++++++++++++++++-
>   drivers/cpufreq/cppc_cpufreq.c                |  83 ++++++++-
>   include/acpi/cppc_acpi.h                      |  20 +++
>   4 files changed, 285 insertions(+), 6 deletions(-)
>
> [1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
> [3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
> [4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
> [5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
> [6] https://lore.kernel.org/lkml/20260120145623.2959636-1-sumitg@nvidia.com/
> [7] https://lore.kernel.org/lkml/20260129104817.3752340-1-sumitg@nvidia.com/
>

