Return-Path: <linux-acpi+bounces-10552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C35A0B944
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC1216233B
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD622A4CE;
	Mon, 13 Jan 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZnPaGKX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FA1CAA6A;
	Mon, 13 Jan 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777983; cv=fail; b=dPLw+ASqh5Xl9TFsyjNR43n8mPP0nHxidV/vcnUtakWI/lQSsJ9bZGJA/WVnd6ztdMtdfsAMY/7gjQ/jIZB4tLHZrA6I8Tt8eSdODn3zcrsOu8KEElb9pV4ZACDKow0T/yDb1kcFoO63m7dasL3EHRyLKWeZrhw/MJ9i1zffl3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777983; c=relaxed/simple;
	bh=aQLWXKSMLEaAnLo0SMPX8eoqeBpwfQUw/wd481VIBLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g5HRRJSuursxrX42A7UJEDViQPF3p+70H41sJFJCx+9vEbVZqXVD5HnOYIBnJO5gL/qpgszuzhtLi0MipMvqB9U7fNgifBjnX+q8SU0lw/2rOaWrqVLx3dlqz6gs3kkAvvK45L1p/9vkicfCMS987AXvwOjNWIUXaB34gC3q01I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZnPaGKX; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqleJPghdV1CJRj/L3kjwW1QXnFdgWg4X9pVVzTeHtRpXE0GbGf2++lfZH+OtqiIQFXFpI+0UJ40iYa49c9xW0Qvr2WWHq24q1J5cuyZUxa092KM42vQjc1flWhSWPjCjgme+u046gbrRJuQTZS15OTRmSCTb77sJZVQQpW9xBMKxlgThLrxuSZuonIG5ieCkts+9wm4C+cxfs+hhbVDXNH3HMtrKd9j70QRhd4hy3EVMVvLin7rLGMIC2NbBj6Zu3P6H67d+6GGTsUyPV/fdf4WgXfyoVnfNaUJKwzyx2hMdBGZ/fKn0ndsqU7ekq2lKHEe/bEKmrdwcfWPksvDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77JDE0LYPx01sP5WqcK/LOu56dFi2UbjJGrydu2sgsk=;
 b=nwhSYjkFJxZtTpXkKDwiq8VFwO8UABMi8aj8irMweh94+X+8F/4bedLeZPyHyUa1UeLdoGh7iuL9XO9j+Yaz45aO5nEeBcti4Dzm31HZFVr0zHwFx0+1ERootRq+cVs16cKVd+chnRcP6AaBO2bQMLOftZ9LaVTmgzPrgjhJVbcIir59u+esI57W4GhMPdNnikwF1/cjnbVhLJWXFXJtTcfmdGTTuu0ktBhUc2nGqzIuBdLl/W701WZWRaeyty4xK6emc3BZfEQq2JqwsVbfGRT9rF8mb52xFE1cBKO80hAK+J+EviwO2D7HRGuEVt3V6s2UyePimfuZKWxl6GGUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77JDE0LYPx01sP5WqcK/LOu56dFi2UbjJGrydu2sgsk=;
 b=rZnPaGKXa4bCQo7VFYLLuIBRsVEPBcxuUvYs7WXs+OMPWZ3jgAhMlsWOp0yJ2Lfs7mQQPQb5H2Mdog1it6pWVXfVM3ecF33T8P7QEcOY+UaAp8GEgcQpB6M2LLl2CaBY48wxrngU1vh5Ym57v/7RmFSt1KdGJ08IENLb6juny4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Mon, 13 Jan
 2025 14:19:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:19:37 +0000
Message-ID: <c6e622b2-64e4-41cf-acfb-31ae493571d2@amd.com>
Date: Mon, 13 Jan 2025 08:19:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z4K_oQL7eA9Owkbs@debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 5248a6a7-b0d3-4343-ff6e-08dd33dd4fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTRkd280eDhJY2c0TU9rYlpZQmZ3QmUrNHJuVEtyMERuT0NZSDR6R0REVEJ4?=
 =?utf-8?B?bnlZampoL01GK3FEeHMvQlgxUVNEVlJYSXhiSnZWS1dwVk45ZCtPUVJ1MUdS?=
 =?utf-8?B?Nkl5QXpYeEhHNnVqUkhoTHJ6N0VpeWJmNkVpZGdrMGhDcC9PM2N2V09tVW5C?=
 =?utf-8?B?R0xBRERpc3VMK05nZCtMVmFUZVN4STlxRDVOOWRkZzhmenQ0MW9ZNVRLd0RB?=
 =?utf-8?B?U1loUHgwZStSWVRHQTZhOWxaZ0NJM0NqN1RCd1RDck9STERTNUZUUEVtWUdi?=
 =?utf-8?B?ZWU1NGpsSHZlMFBJckNwOGwvMXlFRDUzUmFiV3JTbUhhbytONkQwMXpIeDBn?=
 =?utf-8?B?VkN2QUt5d0FUTGQwUlBjUlltYzhkaFlNOS8yaGdnZnlzS2ZUL29yOTRmRDFy?=
 =?utf-8?B?SUtoN3d6bnlEZjNSY0RwbElodkJMM0ZlY0pGVVZXeHRBWHAzZldCMjhkdzk3?=
 =?utf-8?B?U2xPZHlQWkYzMm0vY25CTGcxV21iektRbW1HdysyY1JKZjZNRFkwaDFBT0Er?=
 =?utf-8?B?Qk83Y3pKZnQrNEhoeXNFNVdoaHBsMFBvVVFPZVZvYUkwL0k2NnI1QzVkMVNM?=
 =?utf-8?B?T2Y4bkowUkdGSlFKYUJsdVNNVXNnUmFPTjhoWDB4T3RqeTl2UmY4b3J0Nmxh?=
 =?utf-8?B?KytpUkd4TE1qc0lGUEVCQjdLMG1aRXdGSUNOVnI5SjZCcmdkZ2hlRGltL3RZ?=
 =?utf-8?B?UnZEdmlVTklVdjl5TDFhZm9LSVRSSEl2bUpIVStsYVcyRzNqcFY0S004UTc1?=
 =?utf-8?B?ZVRscFIrenNncllWcWNZdmFDQzdWQTVZL0h5QTAyYlpzUFBQZTZDMUV0a0N1?=
 =?utf-8?B?czlYSDdheUpjU0I5eEVqa3hvWXhIa3BLTlBqTWJ4ZXQ4czVoSXo1UEh0Rkk0?=
 =?utf-8?B?aGZudzZHUEtaTUZNZW8ySzMvRERSQlljNU9ldVBaZDhSWjljZ0ZXMTdnNUZ6?=
 =?utf-8?B?WVV1VCs1MTBYa1dkK0VwaGNXampnN2xPYmdsUTVWdUtGWmp4QUhzZDlibzcx?=
 =?utf-8?B?VlJ2RmRUK2l1RGJMQlFoVXkwUnQ2QmpMZ25vOENoWGFBV09jck5WMjhIT1ZB?=
 =?utf-8?B?OEdNUFlzZWE4aE16WXR5RDhvejVjRms4cVVFMC9EYnJSL0J0bXJRekdURmFw?=
 =?utf-8?B?VXJ1WkhkbUthTkV2SDNzYktBc2c2M3YrblU3Y2RhVDI2MEJjZmdwcmw2TExN?=
 =?utf-8?B?WlR1U3RNaDJ3SkJJU3dZZFFtc2w4ejQrQ2h2ZmpRUExSa3oxMTZtTWdaT3l2?=
 =?utf-8?B?V3NsOXJ3cWhzUi9Va0hrb2xmVGhMQm11ZEQ1b1hhYXNLYlo5U3pBbG1FMFIz?=
 =?utf-8?B?ZXA3UnNVQU1rallqSU03c21qU0ppL1hNS05ZQ0lRMkx1OUJqVExYcXp5YUxs?=
 =?utf-8?B?eVpkZEp0RkZMUm1RRmpkTXQ4eU1nRkpjM2tWM01VM1l1MnJnWUk5dGh1QzdG?=
 =?utf-8?B?c2RZUWhtbVo1dEV2Rit0eGhMTUlETUphazR3SEV4TXM2dWZZU25MQUQycVVT?=
 =?utf-8?B?dG1RLzgwR0psU2x3clAySHBySE9LZHFuVVJ6WklodEdxeVdhcER0cERTRTY0?=
 =?utf-8?B?UGZkQzkwN1hMVDlrdDQ1T2pJY214cUlTQ3JMNnB2bkpRWXVMSGlkRW5TdnZ4?=
 =?utf-8?B?MmRKVnRvRXRVTmFNZmtoSUlKekVqOXp3OHlXQ3hWTEJ0dHRzVStoc0pLNjlu?=
 =?utf-8?B?THhrMUQ1WTVrbDJzbVZ0VnY1U1BCM1hOK0ZlckJnWDZod21zZ1h0NmRPamNm?=
 =?utf-8?B?akVGMkd3OTh5WnA3bUI3M2JNdEsrYkdubjhxaXNYZnhJVFpGTVpBWlgrL083?=
 =?utf-8?B?R1R5ekUvSjJaNVZBdUNDVVMyb242R2FET2F3R084ckVDQjMxS3FVb252T2ZM?=
 =?utf-8?Q?dU3cKz1ROWWCK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTlla3ZMUTZCOEI2eWpyMzlzODRnRXNBeS9LS3E3emQ3KzY4UVZzL25vU2Ez?=
 =?utf-8?B?eUl6T3NJOVgrOSsyWG5HdXNsZnZmcGtIUWxoM0tyL3VncEFvTERoM0ZHaFFC?=
 =?utf-8?B?M3dNdFlJaForYzhxcDk4Y2xyVkVReTNqWlloSjJFUDlBZWxFVm9JQnY1a2pr?=
 =?utf-8?B?NVRjeFdNSE1RSGs2L2thd3drTW1EREIwdWJGNUowY2F6N1lEenVnSG5jQlJi?=
 =?utf-8?B?NEdmc0ZYK0taOCtKRkl0SUlTMlh6Z0J5bnFHTG1TYmpYdDU5dU1zcHNIcmMy?=
 =?utf-8?B?TDMrQlFSY1NTdDFZbU9xeDhBME1HdFVudnNJSDVzME1hWWVCT2FCVUJVUWxS?=
 =?utf-8?B?b2VaMmhSd1ltYVI2d1o3R1BQUFJabEFoczdUMnArVlVyd3FWbFQ5YWprc3F2?=
 =?utf-8?B?R1FYVHNXT0RtbTRYTWlubEp1a2piejV6Ni9LUjU1K0FBT042N2RWV0Nvemdk?=
 =?utf-8?B?NG10d0UvbStNUXJtdDhaY0hxOGIwdUpTVmMySHF1WjZubWhMS04xKzgrb09F?=
 =?utf-8?B?Y0EydWpvOVA1aktyTEgydVE2WFduWGF4Z0o2djNIV3ZoWWF5N3E2VXZGRS9P?=
 =?utf-8?B?Si8xZU1adFVET1RBbFZ4aHdIODV1MlNzU2tuSTRNTk40eVZidDdvbHdWMU1C?=
 =?utf-8?B?ZW5BN3MwZ0ljL2svb0Y0M1F6QXZxYWZKUVJ4KzFsNzhHTzN4L0NrbFVtZENi?=
 =?utf-8?B?Z2FJUkltMkcyalZmZUx2ZFdGZzNTNU9yT3p4ZllMMTlaei93NWUrN0wvWVIw?=
 =?utf-8?B?djdHS3QzdzUwMnMwYjdRS1M3S2ZXY3YzdkVYTllncktETktCNzlyRTY0VHZt?=
 =?utf-8?B?TkVQQnE2ZlFNRjJvc3NEd2xtUkw3MERBRVNUcFA0TWF1V0RjVzI5ZU5vRytK?=
 =?utf-8?B?ZWszQVZBbExSajVlQzJnSUx4bW5nTC9nNXU5RzBjcUswL3BJdkRmOGg4ZnAx?=
 =?utf-8?B?QjZTSzJOTWhzdHoyMlJyTnpVL1FCU09iL3MyYm5LcTU1NW5ERURTazhTMFVI?=
 =?utf-8?B?akpwNzlyZDN0QThTRnA1bThPYXNCRVZWMitvck1EWGhkNmFCcUJYTURjamxY?=
 =?utf-8?B?c1VmYWZLbGlURFMvYjFnVW5rc25XZ0F0ME93RVVrcVQwZDF6QldncEQ4T3dR?=
 =?utf-8?B?OHpFS2QzUU1FNGFrcUd0dzlteElKK09QOGlnclo3bDdaUnBDWkxlNUFtam1w?=
 =?utf-8?B?ZURCRmdFcHZhK3JnNFB4b2Y1dFhvWXRhL0NUUWVXTW9IWms5aGJ5aDRpc2xR?=
 =?utf-8?B?UHVYR2pBWHMzZ2dIemREU2IveDNIdGhKeXFHclo3TlYvc3NLR0s3eG9LZ2ZS?=
 =?utf-8?B?RXNJL2U3bzBQaE5CM29aZlc1ZDU2dXdhRFc3U0FSU1YrL3RJM1E1YU44N2NJ?=
 =?utf-8?B?UURJNDRrNE0zQVBWdVpUT3RtajFKcDhRakJ3My8rVVJaenplY3U0YnQxbDJz?=
 =?utf-8?B?cTZBclB3bGNkaXQ5dW1IMW5XZUFvNmNOWHVpNllLcHlVRkM4WGFPaG9UaStm?=
 =?utf-8?B?VTBpRU5qMUNiekZ0b3hnK243YjE4Q1RFb1kzeUlTV1gwc0NuYUxrYzJxTHE1?=
 =?utf-8?B?REhwdXVadFlJNjRVcnJFdnFQblNuY2s0N0JsNGY0VTVwUnFGMjhEQ2pwUzNT?=
 =?utf-8?B?TzFkZ3dzZ3VST3M2T1hOTzF5MzM3ZS9jdzdmMFVsMFRlM0RiUURGNk92RzJJ?=
 =?utf-8?B?d2RMWjBZem9jakNZUU11QjhHQmYvYkFKWWl3KzFtYXY5WTRkUUk4cTluTDFV?=
 =?utf-8?B?QzMzOXBzSW0veFBZZm85MWhKUm5zd1p0V2M2S0tCdzZCWHVtcUtxSkJyOU1U?=
 =?utf-8?B?c3ZVMnhFeUx4eCtQSnVtZlk1T1lxcDE0REloT0RlcmtjM2FLTVFkWjJGbnY5?=
 =?utf-8?B?RG5yRDhDSzNyOUdmL0Q1QXpRZUFuc2JDeUNiRFZkeXpNYnJaUGNZVDMvcHJ3?=
 =?utf-8?B?Y01ISWhnWTQ3YmlVTmlpd293UmluVFRCN2ZEZzFERjdyRUxvamxiU2M3OWla?=
 =?utf-8?B?ZmlvejRRbFpMZGV3Tnk3S2tSL0l5TzYyWitoTUdlcmVSUEZiR000K1h0a0Ro?=
 =?utf-8?B?cjJKTmtMTGViVXlnTmc1RFIvSEM5MWpKVjJUaW1zZU9TaFZMZkM0NjdydlJz?=
 =?utf-8?Q?m5g2ceYOz2gh8ZQzSkzjHgCwd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5248a6a7-b0d3-4343-ff6e-08dd33dd4fab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:19:37.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29B7LH1ZMSviPry8fITDV4RWUB8kcSGntJeNsDiowqFybxxd53DOiZkrkBAvJol5bylsMIjgbZyG46aT3MrXjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

On 1/11/2025 12:59, Chris Bainbridge wrote:
> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> available for eDP") added function dm_helpers_probe_acpi_edid, which
> fetches the EDID from the BIOS by calling acpi_video_get_edid.
> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
> not originate from kmalloc - it is actually the internal "pointer" field
> from an acpi_buffer struct (which did come from kmalloc).
> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> resulting in memory corruption which leads to random, intermittent
> crashes (e.g. 4% of boots will fail with some Oops).
> 
> Fix this by allocating a new array (which can be safely freed) for the
> EDID data, and correctly freeing the acpi_buffer pointer.
> 
> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> remove the extraneous kmemdup here as the EDID data is now copied in
> acpi_video_device_EDID.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")

Two minor documentation related comments to consider, otherwise I think 
the code change looks good.  Feel free to include:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> Changes in v2:
> 	- check kmemdup() return value
> 	- move buffer management into acpi_video_device_EDID()
> 	- return actual length value of buffer
> ---
>   drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
>   drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
>   2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 8274a17872ed..3c627bdf2d1b 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>   	return 0;
>   }
>   
> +/*
> + *  Arg:

As you've pretty much written kernel doc, us it better to just make this 
proper kerneldoc (IE use /**)?

> + *	device	: video output device (LCD, CRT, ..)
> + *	edid    : address for returned EDID pointer
> + *	length  : _DDC length to request (must be a multiple of 128)
> + *
> + *  Return Value:
> + *	Length of EDID (positive value) or error (negative value)
> + *
> + *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data is written
> + *  to the edid address, and the length of the EDID is returned. The caller is

Since 'EDID' and 'edid' mean different things in the context of this 
description for the purpose of clarity I think it would be better to say 
"the edid pointer address".

> + *  responsible for freeing the edid pointer.
> + */
> +
>   static int
> -acpi_video_device_EDID(struct acpi_video_device *device,
> -		       union acpi_object **edid, int length)
> +acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length)
>   {
> -	int status;
> +	acpi_status status;
>   	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>   	union acpi_object *obj;
>   	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>   	struct acpi_object_list args = { 1, &arg0 };
> -
> +	int ret;
>   
>   	*edid = NULL;
>   
> @@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device *device,
>   
>   	obj = buffer.pointer;
>   
> -	if (obj && obj->type == ACPI_TYPE_BUFFER)
> -		*edid = obj;
> -	else {
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
> +		ret = *edid ? obj->buffer.length : -ENOMEM;
> +	} else {
>   		acpi_handle_debug(device->dev->handle,
>   				 "Invalid _DDC data for length %d\n", length);
> -		status = -EFAULT;
> -		kfree(obj);
> +		ret = -EFAULT;
>   	}
>   
> -	return status;
> +	kfree(obj);
> +	return ret;
>   }
>   
>   /* bus */
> @@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>   {
>   	struct acpi_video_bus *video;
>   	struct acpi_video_device *video_device;
> -	union acpi_object *buffer = NULL;
> -	acpi_status status;
> -	int i, length;
> +	int i, length, ret;
>   
>   	if (!device || !acpi_driver_data(device))
>   		return -EINVAL;
> @@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>   		}
>   
>   		for (length = 512; length > 0; length -= 128) {
> -			status = acpi_video_device_EDID(video_device, &buffer,
> -							length);
> -			if (ACPI_SUCCESS(status))
> -				break;
> +			ret = acpi_video_device_EDID(video_device, edid, length);
> +			if (ret > 0)
> +				return ret;
>   		}
> -		if (!length)
> -			continue;
> -
> -		*edid = buffer->buffer.pointer;
> -		return length;
>   	}
>   
>   	return -ENODEV;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 8f0c69aad248..21b56cc7605c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>   	if (ret < 0)
>   		return NULL;
>   
> -	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
> +	return edid;
>   }
>   
>   bool nouveau_acpi_video_backlight_use_native(void)


