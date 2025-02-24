Return-Path: <linux-acpi+bounces-11432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7AA42DBD
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D43B1E19
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65D20D4ED;
	Mon, 24 Feb 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xc3aVuDt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F515530B;
	Mon, 24 Feb 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428842; cv=fail; b=he3eRo+18WgggADpE70lTGS1r10U9besSF4h4QXsBTfeSja/qagEwHzefdsaHjhnQ5WhLQR7BSwRw+jXtAOX1nhszmoLfQPEgT+SWxCa1cXqdKZXOAAk8szOnG+7wUI9uY4rOcjGZUaY3u6SV8IjP2pJLtdh4YRQA8BQ62diCzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428842; c=relaxed/simple;
	bh=Iy3TRB2582cWjeuUzFW3dkkz6Ts/cYnHBIfYTlTu0pU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dI5OhWWfTmI7iJ7ViJLtA2B6/mrTVtj8Ny+iBarYaJAig0f8APUlpIgtI7BS7VweLal1FOxJlHL0GKDbLw2xm/HGh/0n/gi8lkXLI+UPG7Y1wiNsBaecoEFJdAYUN9W1+LXNcbIHmyd46fapZ7syupGbRhKnCgQ7p7VTw/zocqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xc3aVuDt; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlEKbJSL74nlSk9ItbrH9Nd05JqyV8IEtmPPZdsQzzQjMkqr3w7Sii9x1flI9ZvVLi8gv+2nmv5FOO07M054BSNK38tiTZWn4q87j9YSrYsUdaHFxwQcLSUZHV/1T1Ft9ZubAQeFhm7Y7y/6+Taf8l737L/88DfGROVIxVM17C18UG7o6782eLgf8zYKBHZBxqwm0xMxflxOBK5SD+7hH4Oo+MFd6k8XFRX0TLmEaZNMovAk/Jn8zaomKlZH81wU4GMH48m+2wMkqFCGet1FZWobQHnGLGfmliuyjOcPjw6d9lipxoTqTvPTA26c/ziV7eONumNsFBADnoFTvUTC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8WwKha+u0ufCN5OUjbXTjg06UjkMwqyVtcTAlGweP0=;
 b=OPsXjRShodHVw/BvrlCOUE6VA5wZZ8fzpRBUlYtNyGLmfRr5W+/CvF23I5rvZJsxfY3x3TRnJNwiH8LAXQfGFng1oWYJIXZ6k9jv71u9VGEyyRrM0EEjn0emPjJQbhY31LTK04rs9Ss4V5MaGeX6+Ew4Y64Polt7G6bkriH9rMYu+CIlV7Bro9NEaWPEdZqkFQPleZzmi8gY4uyat9sv3eInDGSvCmjx1PGRufj/Kt2+8QXcmMudgCVosFxL0Mj5jTIF2y/ERgwwVwrBhaPO1B/OufAs2jSbyKHzIpGwXbp2HCLhau+tEe5N+qz08z7p4o3I9ZGwru93fs3uz8OZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8WwKha+u0ufCN5OUjbXTjg06UjkMwqyVtcTAlGweP0=;
 b=Xc3aVuDt4VLcfZ4vvA4zMv3wRVxOhTBS7bVyXpRb2omhJ2ApLvCatBJZDeol/2Ugh8Aq4aqTJHuHppTqscmg7Rh8n3JfIFfHlAUjYkOw0Qy3XGVGweszo/X7MOs98tIs7l95VyngMjX/58WjdupjGf8x03fGmuRo1B5y2JWKI80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 20:27:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:27:13 +0000
Message-ID: <681f9ec4-7b43-4e14-b098-dddc3a9ae29b@amd.com>
Date: Mon, 24 Feb 2025 14:27:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Antheas Kapenekakis <lkml@antheas.dev>, mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
 me@kylegospodneti.ch
References: <20250224195059.10185-1-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250224195059.10185-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:d3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9c30f0-42cb-4f19-f309-08dd55119f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk9wSHFJUExqbGVOa2o5MDAzcWNFYkMyMDBKMFhrck5aaEp1NHEvNmxjOUJW?=
 =?utf-8?B?OHRVMFl1eFhKUGZCbG13SlROZjZGbXpFOEdRbHl5a3BmeFhYRDR3TEJBemhh?=
 =?utf-8?B?U0xaSUNQT0tJN0g4eWJwbEZMOFdubjBIS2wxUzk5T2RkWm93Wk5BeUxyWHAw?=
 =?utf-8?B?UFlXbmxLbGpTbGxsWExaY2h4cUZRdzVxR3ZkcVAwNTdLT1JGakZ5Wi9nc2pJ?=
 =?utf-8?B?WXJZOUlxdDkvbnUrZlpHc28yRE1RSzBTU0hvdHBwYXpQWmJNdFBIWE01RzMv?=
 =?utf-8?B?LzNVcFZlNGd1SEs1K04ralc5d1FVWnNSdzBMa0VZNzBpRUZoeWlkMUt3d0Np?=
 =?utf-8?B?elpFNzdXNXVuQ2F5aU1kc2xCNDVHS0VRWWduL3J5WWNRVVdVOGlFQXkzdFdk?=
 =?utf-8?B?SGVPUFdmWHd3R0F5akcxOWtqMDIrK0czdjhLZUFHWWdYL3A1b2orUks4T0FE?=
 =?utf-8?B?U2lvb3IzL0FhbVR6OGhxSzZNRWNpUGIwbUwwV081TGZ5Y1FqdVl2dExaelpI?=
 =?utf-8?B?N3UxckIweEJKVmozWUdNVmFZNWhDOUEvczBSNVh0QkVRMVgzZTRZdTB1VVN3?=
 =?utf-8?B?MzRIbkN4Y1llQkRtQzhWbjd2RmxXL1hqQkZSQXpXT0RUK2EyR0t1VEdYb2tX?=
 =?utf-8?B?ZWNYQ0FmcEpQOW5hRGFRckdKQ2EvaWxWTnZDTm5ELzZrZStOYWk2SThrRFRW?=
 =?utf-8?B?aENXTHFuVjNhdzhmU25PU3l3Z1pkRXlFMCtXZDN1TXQ2WklSS0g1Qi9QUzVW?=
 =?utf-8?B?Q0RYRTE5NzM5bUdvSEhpYkV4NHFCakRiVHZXVWtaRHAwcnVwNCtHWnl5K3Y3?=
 =?utf-8?B?L1VndklENE9ubHpiREsvSmo2QzBtVkJwNjh4ZVYzSngvRktpTmoxTm1ORFEx?=
 =?utf-8?B?dDk1TWlkRGFRcTlDamdEbU1aTnRtU2hCdFhJcXBVMncxV01vWSsyUVkwSzcr?=
 =?utf-8?B?NFB4b28wbFRSTElXQkxoa0EwYWxkU3ZSb1ZEd3ZQM080Y1Jld3NVaDhNV3VU?=
 =?utf-8?B?R3hueXNYR29DVWJuS2dsbVZmTUZBWDRLOFFFQmZQeFdBQjJhd2Y4RFdxMTdj?=
 =?utf-8?B?ZUhjbkRYVEVDYVR3by9FTXlxaTZGTVA2eTlGOWxrQjRPdFBGRHhsM3FUWG04?=
 =?utf-8?B?UHpjQkIwaUVwR1BPb3RBR090czJOc0dvck43clhsZ2VUd1VKazZuekJGaThE?=
 =?utf-8?B?R3VCZUdhcXFCYmtLZGIrazhYejFjazVIa0ZXcXlIQ1VZM0pnL2crN0pDSlR2?=
 =?utf-8?B?ZUJwbjBHSzZIR1YxOGJEWW9ZVTRpZGV3VlVkTE42NGJmOTZoZEF3YnZzZUMr?=
 =?utf-8?B?aElmTFpLMmtuaHpob2RMTDVXV2dKNXdKeWNWVXArRFcwS3NxQlZBS3ZYY01Y?=
 =?utf-8?B?VFVWN0RZMlhvR3k1WUhhZnpUZFFaTnBXbEZ1RGpIVEVzVUFCbS9OYnZsVnJ0?=
 =?utf-8?B?Y29MM1lvbTJLeUVFMHdDdGthL0kzL3ZjdnIxQk1PdjVtcU83aG5ybGRyZElE?=
 =?utf-8?B?QWtPOVpiYzFiMEhseE43b2owazJyNkR6dk1HNWhvQjZxaVBCZkRSZG04TnNt?=
 =?utf-8?B?dVNNWlUwYlBxTGZDMGVES3F6cGRLWitpR2RSdmZWTEFpTWdmNGEwVUwxL0No?=
 =?utf-8?B?NFJDUkVKSUlySU9uZDIrdlVRUXdrbkIyUThUVUxxR0svZkc4dlZiWEhNUEh2?=
 =?utf-8?B?akltTWtaT2tGb1I3bnFQVU9sVVJqMkV1bmtNTHZEWkRPM09aNTBQUmNib1Bo?=
 =?utf-8?B?MGpqdHVINWovTWxtWG1ucFNuUlpleHVBRGxUeVdwWEtWZ3AvSURzeEQ5aEYy?=
 =?utf-8?B?aEVVRXVyQlNOckhwNm8xSk1pYVJvZjZVQXorRFZSdWN2NElLeFRhM2l6ejN0?=
 =?utf-8?Q?/jeL6xEsocxG9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNYUWJ6WlJjOXZ2WlR3cGZLY1ptWEVPektvcWVGdXZMNmFUOFJqNDhZMnl1?=
 =?utf-8?B?VkxLNnVKQi9DT0UzYUN5T1hjcUUxb1UwM2FQY1RzV3VCWGpMM0pTa0hCamU1?=
 =?utf-8?B?UDk5WWtNYjY5N2pJZVlJV1c5V2ZHMDlsNndsSTcySE9SdFF3UGhVbCszcGlK?=
 =?utf-8?B?Smd4VHRqNnVjSDBPbE16SVVRUitNVXB4akRYRjJSbGQ4QXNIQklJZjJjOWZL?=
 =?utf-8?B?aU9PNzBIdUVZUUs5ZncwMUhFdXAvbEdSVFpPbTB5ZVJKNlFselQwd1NrbFZT?=
 =?utf-8?B?OWZTaDFmZG9vQTNHZ3l3NUFRRW5wcHlBdmUrSm4rVnVadG1IK0NzcmluQnJT?=
 =?utf-8?B?Y0NuQVM1YjFaUUZrT2JKdjFCNjRSRmRpWUdVTHVRRzhBNFd4T1RnYXQ2ZkJN?=
 =?utf-8?B?ZHMwd2UzT2lmazcwYXdDZVFPZVRGRjhsZzdrc1ZneEE4T05oc2tlSWJhWTVQ?=
 =?utf-8?B?dnUxRjhvcXVMREJVY0NwTXJHYnU5ZUZ3YWZvWDR1N0JLbHUvTEkvVHlTbFJo?=
 =?utf-8?B?UDBMYzgxbnFlOXVKdUJRRFNXZGpxa2lUN2g2aHZjOWhFZS9HeEpYSFZoYkhL?=
 =?utf-8?B?MmZ0ZHE0RFJMaThNNmdESmVJc1Q5R2o0bHRjMFR6UG5vQ2MzVngvUklLblZa?=
 =?utf-8?B?MHlUcERDcWlpTWdWbDBMM3Bpd04xSmxLNnltSG00QW9yMlFZc25WT2hCVE5X?=
 =?utf-8?B?bEpKM29KWGJ3RkZoWE41dTc3dWxsYmNyR1I5c3ErNEo4SFkrTWw4UGcyUW55?=
 =?utf-8?B?TDdoeVpiVVB6Y1AyVkRQSkhnSW1vbzU2ZXM4MUFhZFh1ZFE4ZjVRNUsxRUNH?=
 =?utf-8?B?c3lhZ3psN2x3eEhQSG9jSm1sNjZiNEpya05SSEhsRlZyZDZsSHZlbWpjZkpK?=
 =?utf-8?B?ODQ4WmhOUUNMRzhBT3BTVGFNbFltTTZmZ2xUS1l5WU1lTkRoSXhyWTBlZGhH?=
 =?utf-8?B?VWZqTTArT3lTclVZUDl1TjFZMlk2SkEyL2VDNnhQMFNIdEozS2FkS1lNclBJ?=
 =?utf-8?B?YmI3MmlnVlJmOEpLMjZqaGdFTDJmUmdxcVNMK2VRUXE4N2VTRDNOLytObnF5?=
 =?utf-8?B?akxyekttVHFvY0p5Z3Vxc0VQclNnajRqdkRVOHpvUWN6cDF6RUJjQUdwbTdG?=
 =?utf-8?B?MmtoK05RZDdqbURwdE9VVEQ1cE9sSVhOMUVLN00zbmt2WVN2TkdUSy8zTTlL?=
 =?utf-8?B?VXo1M3djR0FEdEdOQVlzM0RUeERlcnJGNGVCUENxQUpZazNwWnc3QnFacEZ0?=
 =?utf-8?B?OXRlK0FOeTF6bFVtYzV6Ujdpc0FRajIzZ21DNmxHWFUzNmYxRDBhQUUrVkVs?=
 =?utf-8?B?ZHdqWVFYNitPU1dxblNFUy9KVnA0bW9BdzM1d3VEUzRseWlGaFhNZUhPbXdS?=
 =?utf-8?B?TFdOeW9GQ3NrYmRPeEZPT0gxekZuYjkvYk0rVGx5TlBJWWs1d0Rhc1lsM3F3?=
 =?utf-8?B?eUJLb1lad1RuSXJzcFplNlNVRlAwZkp2bkpWUkZQN0o4N1NGbzdDdmFHcFln?=
 =?utf-8?B?aFpJK1F1ZUVMLzk1c2I1eGxlRFVyM1Fua2Z2NTh1Y2ljb01EMi9XRjZnK1Fa?=
 =?utf-8?B?R25XY2ZQTkZYbWJUQkY0OTczQnZxTGZzbGozNzl1ZjdTK3FnYk1YNVIraUM5?=
 =?utf-8?B?U0x3aGlsTkJVN0U3Tlg0RmlQNXhZWUNhUTc1elBua0NVdFM0MW8wanJFV3NF?=
 =?utf-8?B?WmYvcVlkZTRaYnhrR2tGQi9HbGVhVHRsR3BYZGpCdzg3VzV4TUIrMEtGMGIw?=
 =?utf-8?B?SUM2bFJ3UXdWZlFiNjBpOElqTHhack1XSUk2UStIcW40TkJ4U3NiYjhhbXBL?=
 =?utf-8?B?WXZ3QWd0TFZSTjZqZjhiWWNhcWdDOGZ6MTQ1aXpoZ0N4YmRSLzJOOFAxRHEw?=
 =?utf-8?B?aENyaG9uRUlFWlhHZ0lST3ZqQWZTajJNRlduZFBxU1Rtb1BoYUZhdTJBTmNE?=
 =?utf-8?B?QWJEdHoySHNzR1JJYXNId2JKR3F1K1ZqS0pYNWd1TGdQYjZ0WU4xVDluWmFl?=
 =?utf-8?B?MVZ5Y0dBeGtpLzBqUXJFVDkwVTMrZkVKekhxMFRJOStSbmZueHFaSmgydTNp?=
 =?utf-8?B?Z2QrTHB2RTFpcUExeit1YjluSVE5elM5T0J2eHh4NUJxS2JmeUxCbk9STGtF?=
 =?utf-8?Q?FSqh2f24TDL0flN5JXolpEP4x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9c30f0-42cb-4f19-f309-08dd55119f7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:27:13.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz0zHbM1R5CQtBLbpO3V2b7B6Egy9dOULzQgx7AzE+rG32T1kqRFefbiK0rwZ6ByZfzbjy8hkxOYySsJByIqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

On 2/24/2025 13:50, Antheas Kapenekakis wrote:
> On the Asus Z13 (2025), a device that would need the amd-pmf quirk that
> was removed on the platform_profile refactor, we see the following output
> from the sysfs platform profile:
> 
> $ cat /sys/firmware/acpi/platform_profile_choices
> balanced performance
> 
> I.e., the quiet profile is missing. Which is a major regression in terms of
> power efficiency and affects both tuned, and ppd (it also affected my
> software but I fixed that on Saturday). This would affect any laptop that
> loads both amd-pmf and asus-wmi (around 15 models give or take?).

To me this raises a fundamental question.  What is really different 
between quiet and low-power?  quiet just affects fan curves and 
low-power affects power?

One could argue that changing power will indirectly affect fan performance.

Because it makes me wonder if we really should just make them permanent 
aliases.

> 
> The problem stems from the fact that asus-wmi uses quiet, and amd-pmf uses
> low-power. While it is not clear to me what the amd-pmf module is supposed
> to do here, and perhaps some autodetection should be done and make it bail,
> if we assume it should be kept, then there is a small refactor that is
> needed to maintain the existing ABI interface.
> 
> This is the subject of this patch series.
> 
> Essentially, we introduce the concept of a "secondary" handler. Secondary
> handlers work exactly the same, except for the fact they are able to
> receive all profile names through the sysfs interface. The expectation
> here would be that the handlers choose the closest appropriate profile
> they have, and this is what I did for the amd-pmf handler.
> 
> In their own platform_profile namespace, these handlers still work normally
> and only accept the profiles from their probe functions, with -ENOSUP for
> the rest.
> 
> In the absence of a primary handler, the options of all secondary handlers
> are unioned in the legacy sysfs, which prevents them from hiding each
> other's options.
> 
> With this patch series applied, the sysfs interface will look like this:
> 
> $ cat /sys/firmware/acpi/platform_profile_choices
> quiet balanced performance
> 
> And writing quiet to it results in the profile being applied to both
> platform profile handlers.
> 
> $ echo low-power > /sys/firmware/acpi/platform_profile
> bash: echo: write error: Operation not supported
> $ echo quiet > /sys/firmware/acpi/platform_profile
> $ cat /sys/class/platform-profile/platform-profile-*/{name,profile}
> asus-wmi
> amd-pmf
> quiet
> quiet
> 
> Agreed ABI still works:
> $ echo quiet > /sys/class/platform-profile/platform-profile-0/profile
> $ echo quiet > /sys/class/platform-profile/platform-profile-1/profile
> bash: echo: write error: Operation not supported
> $ echo low-power > /sys/class/platform-profile/platform-profile-0/profile
> bash: echo: write error: Operation not supported
> $ echo low-power > /sys/class/platform-profile/platform-profile-1/profile
> 
> Antheas Kapenekakis (3):
>    ACPI: platform_profile: Add support for secondary handlers
>    ACPI: platform_profile: add all options to amd-pmf as a secondary
>      handler
>    ACPI: platform_profile: Do not hide options missing in secondary
>      handlers
> 
>   drivers/acpi/platform_profile.c    | 57 +++++++++++++++++++++++++-----
>   drivers/platform/x86/amd/pmf/spc.c |  3 ++
>   drivers/platform/x86/amd/pmf/sps.c |  8 +++++
>   include/linux/platform_profile.h   |  7 ++++
>   4 files changed, 67 insertions(+), 8 deletions(-)
> 


