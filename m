Return-Path: <linux-acpi+bounces-10412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F3A0476D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A60C16645B
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B41F1306;
	Tue,  7 Jan 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zeoyJ4xv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81681EBFE4;
	Tue,  7 Jan 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269207; cv=fail; b=VVp+O8aSV+FTK+aB34iYhf9F7Ct5BeqUwg364NMImUsJE/5q25Z/vrSQbD8pH/RR7j7CK77+xcvqIeKlg6tEVXo1t/TnY12e6SuwNLb9Q2xmZo5K1ZczfdLPs8BiEgsylKHXs9dgNiMqqM+9Fr/BXNpvDcbT9KPtC4yT7KNugB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269207; c=relaxed/simple;
	bh=olJlVousmY2vG3PpuaDn0gsDWLBZjwYfcQRxSPcvrvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAytGBwY1zdZKySupfZ95CjSAV37P9A3IEKML14Vow1sJIoJnSMzZCcSdZtsaBXIbCrPGIOGBFlIXqXVhRnTwrnQSyq58LWEDHp3C2WGizpY6SixGLdsp08O4QSe0y/iJkCjEPHK+Qv5ovI4IVqW4Z+VOKlDrzDv58fDxT/Y2Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zeoyJ4xv; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th2BsHXjgUHg2xOC7eLHiYmdC/xRAP86W6bXwC+VowVmFG+TylQs6L16pyyX9B/EsCqrw8WMRBnehFj66+1p1MQyoV0drYdUj9z3H8qPS8smmu+GS/nHQzl/gOe4FP3HC5yxg348l6euf4YwbcnRI6zwu4dvH+ExNFFsOuJgeXUrLbD6ehWwFVzRLNWa9FChDaC0QbdsKN1AfZX9ZLUPVsdYTAPGDCBEjFDUbv6yquCk7t/wytW9V+x3ixcBHzEFuaqy4qjv04n5LWM3CqVhoOdH7fHhp1ews2dExvcmMeMSrJ98JFKJzscbjamO4P0HgVlzcSFUNNa++1KhucsLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0oeLKFOSMvzPVCR6PKO85rhYJ1r3OXpjfpwbCva/I0=;
 b=AxGWiVcWRvBGDHNmHuqyljX6ESoGmweGkwf8BkfgkaeKH/htDBXUTpM8/rGTL4BMOjm8tRFQan5tlkvXRCgQP/gioZD6GoTGBUkd13zsKIEhfv+SORJGI8oAl6tNuVX4L2w52SgLk6M9XM3irx3kSVhRg3zHTeRfu1y0oGradsn4uiY/et2HjbgogOYRzC8T4WJRILwpyyajS3IURVsiIZDaRp4QWpOZcQlKxkk0iTwgkL+/I6VGkQlTdDTYD3MV8/2Io/vaZrByDrcyqYR9j7dkfjhP8XBgXO2gHNoW4QPY/+gyjeaPOzqV1O8X7YgujFiWOfYV1bVZq1BEFW16sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0oeLKFOSMvzPVCR6PKO85rhYJ1r3OXpjfpwbCva/I0=;
 b=zeoyJ4xv8mkJ8V3hzZBmHUCtAgnx/9x4AobBNRH5PnIsWfreAoFffGKprBcQm0fuFjiaKNcqGKvzfKupha6VzcYCbZGuJS3skzbx172CQjtviz83R9gWP9yIvwt2cZnEHE+laGRvWyWLY2V7gFkRB9t4Lp8xsnjGcF6SKobAUic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Tue, 7 Jan
 2025 16:59:56 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 16:59:56 +0000
Message-ID: <b9b8ea58-1e06-4743-9b6c-7b29eeaff0d2@amd.com>
Date: Tue, 7 Jan 2025 10:59:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, tjakobi@math.uni-bielefeld.de, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <Z2yQvTyg_MWwrlj3@debian.local>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <Z2yQvTyg_MWwrlj3@debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7b27b6-be44-477e-cac6-08dd2f3cb65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmIrQStsVkZiM3FzenFGQlFMZWZ2WnRsb1Y3QVVKdGI5Qng5bGlQUmJLR3RH?=
 =?utf-8?B?VlB4dUg2NGN0bWhuWlJuSWVuRzlaZFhwWmhFWHVBNDdobTYzMXJmaUh3djJt?=
 =?utf-8?B?WjBMT1p6QlRIV29OWTh3dU5uOGI1Wmo1Vk9zeFltTWpud2ZsRFlLSGxPcFY3?=
 =?utf-8?B?ZFRnUHVYZmNqOXh4SmNhamZTR3BCd0ZUYm1NallqemFVbUQzOWQrT2xqK3Q4?=
 =?utf-8?B?b1B6L0JZUlZXTDE1bFpWUHFHcStjUmVTZUFEMDRnY0dCN2l6WktLZUlJZStO?=
 =?utf-8?B?ZXV5SExpYUZ6Z08yVFNoUWYyemtIRW5zdkhNN3JUdEhtVXlBaTRuVHBDUys0?=
 =?utf-8?B?TGEwM1N4ZmRFUU1GRHYzcjV1SWRZZThYcHhkQ0ovZVlheWQvd2grNitUSjRw?=
 =?utf-8?B?d2tKRUZwTnhlVjIzRTIxQ1JwMXFTWDdWL3ZyTENQT2ZlTlRNQ2liYXd4OURP?=
 =?utf-8?B?SnFwVG9qSlhhZ25NVTVzY3piSXhDMWNVd0s1Z1pnOGRhQ2dtQytxajBRTTJp?=
 =?utf-8?B?OGFZVVJkc0N1OS9aOVBIN3dNa05HOS9pNXZKc0t2OGE3MTBLQWlDL2ZoaHdY?=
 =?utf-8?B?UjgxSHp3Ym5mUkNJNHJGQzFjNEQwbWFaQjRnUGFiVFpkajRXOC9oRG5TVFFL?=
 =?utf-8?B?YWgxU2xQM2VoQWwrUVZjWDJOQ3hoT2h3dTdmL0ptS0JqRTJmNS9GNnEyWXNi?=
 =?utf-8?B?VVJ6ZUQ2UlVUZXhIWTR0VVlrcGNUZG42OWMzbkVaSHFVa0draTlnMXdBMGJi?=
 =?utf-8?B?ZDJ4bWV1SW1WaXFrUDJ2SG1RQXFsNTFFY3hMSFJteDJHOHVlQmhpczcwVUlM?=
 =?utf-8?B?bHF3UXQrbmUrUkU3Z2YwUlIwMWo0cTExbnVqbDRyNXFGVEg4eisvYjFWdlll?=
 =?utf-8?B?V0UvanFnS011cnREVmx3b1cybUZWOGwvWmlMTU5iTkFwT2srRy84ODQ5bVVj?=
 =?utf-8?B?VlNVTGlYdUZ1endva0JiU0gvSDRPR25BUm5ld3MyLzRJNDNFOFhuMmkwN2tM?=
 =?utf-8?B?YjJIenRhbnhvNHk0Z2lUL050c01pb096azIyOUtYWURhOUpnRm1BblRvTzYv?=
 =?utf-8?B?NVJuZHcvbVViOEtqc2pUQm9UV1pkT1M0ZGI4UTZYU0xZS0JFNDVIWC9kR2xy?=
 =?utf-8?B?blBRREZRUS9QbVE5ajQ4Ni9CWUM2dmk1Q3k1bXg3Z25uaVVINVpOVTRzQnpW?=
 =?utf-8?B?NGk5QU40V3hZaVBrekpmTU5TNFVGV0F3Nkt0WUhNaW1wMmlkUVBFUGVLRDRi?=
 =?utf-8?B?b3paNDZGMEpUL1UxZ3pXUWUxSDl3c2o0Q3lzdGlXRUpIWDhUbnc5ZUJweHdq?=
 =?utf-8?B?OFc3di9obXVJNjJObkgyMnB6TVpsd0s1R2FFR1NHV29mVkJGUngxZ1lhZGpR?=
 =?utf-8?B?cFR1b0JUc0YzMDNPTWN3Z1FmdVlacXJ5ZjA1MGFJdVBMZEFaRnY2MHYvdVBY?=
 =?utf-8?B?WUJzdFdrdEt4S2c4T2hyTE12S3hsdnhFdUYyd1YyOXcxL0Nwc3BuSSs2eVln?=
 =?utf-8?B?a0s4OVlBak01MFlRaFU2aWJtUHdINlFTOUUrZ1hqcmZsa054R0ZLR0dUWDc1?=
 =?utf-8?B?Y2JnUDBaaGdsWVpkMEFXQW02Yitwd25vbE5zeTRxdjlkUGFBbVFXY0lFZ1da?=
 =?utf-8?B?V0MzL3hYUi9TRzhuWHBCVFVVMTB6WlJGbTd6UGwrY1E4T3liY1NNYzFDWUE0?=
 =?utf-8?B?Y055REIzMGQ1UkpNVVM2TXZlbm5HVVA4WmY4Y3JwWDV2bHNqakFaT3ZVWUVS?=
 =?utf-8?B?a0YrcUlNdTNic3lUMHp1eitISkdjT1pqcnFtWVN4MUxQZDVEWFgwUm55UFpZ?=
 =?utf-8?B?L0FzSUFTQXJWZ1Nzb2NlMWFCb0NldFc3OGtWcXFlRFlXVGxFZnF2bWE2ME56?=
 =?utf-8?Q?S0LsGl1N44mO2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnEwdUlDVjQvOUZlS0VPc2tHRTBJMTdTZytzcFM1MmRUWG9tN1dhSkpFZVpi?=
 =?utf-8?B?UzEydlovcGhUa2tWS2xwaG5kc0FUVWdwdUpRYU9EM0RUQlN0UlR4UXB3Tmdh?=
 =?utf-8?B?aUtkV2N6ak1xMzhmZVZkK25ybS9KNDJhd0s5WXdrODcvQllZUDBpdWlVSjR1?=
 =?utf-8?B?TFFSamR3cStNdVdveEh0Q3ZJamtyNk9jbEpSUkwzek9lZjloNlR6S2lWT3Ni?=
 =?utf-8?B?VEUwWE40aUlqWGlXTmo1eVMvYUR1cHJYN1R6ekNRem95NVBXNi9OZEtGdE9q?=
 =?utf-8?B?b3hkUUduUGVqOUN6ZFpHTkpFTjFGaFg1MGZjemg1UnZHeWFrL1ZQenJQUkJa?=
 =?utf-8?B?ZFZGZGhQRTBTRFNKMjlOSnpDb0pDRzZvS0JrMnkweUFQUVhmMENLL2sycGJL?=
 =?utf-8?B?dG5oejFZcDB5bW1EaDZud2NrNDBpTk5jZXlhM1k5RkU1R2FiaHR2NmxlYmxD?=
 =?utf-8?B?eEcva2RjQ1k3S0pIT0UxR0xidTErQnBKSUtHRE1TaEtDdGNTM2F0cUJFY2Qy?=
 =?utf-8?B?RWsxaXhJUm1DRHByTFNRdTBHaTBJOGhITHUwQU9YVWJvbHBOTzI0aTRRbjhV?=
 =?utf-8?B?RWplS2h1cEFPTkpuRGdndnkzQWdlaUlJVk5rMUtZS3FueEdrR0daZlBXbytr?=
 =?utf-8?B?bmcxekNoVVBVdncvS0NKY0FWWGhYUmpGTUprYTBjbkMzdDVRQVhIZnR1Tk9j?=
 =?utf-8?B?aTNSejhzc1h5bk1rSHVLeUNjczNBUVYvZDhKMklVWitJd3d4MW5WYlhPQ0dq?=
 =?utf-8?B?eUtOcWVRY2FSR0ZHWTc2NXhrdGd5L0pQajEwdjVKYWIxcFA0VHFjeEt4emV2?=
 =?utf-8?B?ckhzbUowSldybjRmL3V4Nk8ycHM2OXlrQWtweVZyTjJzY2dYYUUzVHRKODlS?=
 =?utf-8?B?T1NWcnNCYW90Ni9xRVZkeUNOUDZ3OEFTekM3TzhtMUVRclNWc250RGxwNUQ4?=
 =?utf-8?B?Z3gwL3d3WkVmeGxVWnBqeithN0o1VktWV1pwYUNObENkNWQ3MmQvU29zY0pi?=
 =?utf-8?B?M2NYSjFCVzR1Tmt5SVkxRmJBNzNWY0JtSFFFZE1oNmJTSnN3NVRaQ0czOENo?=
 =?utf-8?B?eUlqbHVZa1VtaEMzc25nNHZlSUpWNW0rYTVha1o1ejhsTDI5VmdKMTVJblNo?=
 =?utf-8?B?clk1cTBWcmxPYlNKcUFYVjhzZU5wMnhFb0FJb2NLb1dhR1NLdHAvbGk4cDRX?=
 =?utf-8?B?dTNTd3FaWW9mSHV2TjdiVGQ5TVlJbElCemxkQkR6cEFwZHZ6cGNCaXAwNUc5?=
 =?utf-8?B?OHAwTE5pZVlJbWFwVkh2Z1ZlaXRhbXlSVmlUUmVuSnhPYkt6WDkzTUoyTGFt?=
 =?utf-8?B?U1Q3MjR2Zy9mRHY0NDJqejZhUzVYTFFvN1FiT29rbUtGY0xxQlVrMy9mRFZj?=
 =?utf-8?B?MU1ZYU5UNFB2UW0rU1BDakRablZuaE5VVkl4YnJKSnJteERCZkFxTmtsRTZR?=
 =?utf-8?B?dFBVc3JOTzZ6cFkrY2F1YWwzZEFoekNERkJGdHYrWDY5dVRpN0crK3N5TDYx?=
 =?utf-8?B?eU1uc2s3KzhmUDcySlhrenI0cUl2S2FpeWxsSUJUTHhlQ1phMHl1ejdZRk5L?=
 =?utf-8?B?eStJUnYvaUZJOEVLbVdMbHMrVTZRVTRLaE1zaVM3MFFYVTRJY3lrSDlLb01w?=
 =?utf-8?B?RGoxRFI5UU9JejhMWjFzUE0weUJKbTJqV2JWNG9DVURaeVNFVWd3UjlKdDg4?=
 =?utf-8?B?Yk1hbzlMaDFrSkVncDJOWGlmR3ZqVjdFc1Rwdi9wbzNyNE9POEJqUThOQXJL?=
 =?utf-8?B?OXJCMmxHb1M0cXZJdk9URG45RE93SWhnYXgxUWlaRWVGYVNYd2Nhc2d0TE9s?=
 =?utf-8?B?Z3pGSUc5QllPNzJnR3VOUFNMWFhYTVF4U3MwemdjMUxybHRZeVAyQkFOUnJF?=
 =?utf-8?B?N2dqLzEzUDBjR01FYSt5VUFOV1ROSm5zS2lySkRnMW5rZHhDWmRRRkxsOTNI?=
 =?utf-8?B?UkdaQ1dtTjZwU0pWYW8ycTZLOC9veGhFb2hQY0VXb05abllydVhuc2YvajRa?=
 =?utf-8?B?bUliNXdHd2d5OG91VGNOVS8rTkYrUEF0c0U5clZuS0M0cWZUOG1wb1V1R1ZE?=
 =?utf-8?B?YmVJa3BqaE9QbGdvbjhmVGJicnd0VUxRRVFuZU5WODNjZjdQZmMrTWg5RFk5?=
 =?utf-8?Q?9+5PTuXjh+0iF++S1Fx4Xmjh+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7b27b6-be44-477e-cac6-08dd2f3cb65a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:59:56.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UZBB9zkMr/Buu4aWl+8OXD2va07RUgaXQMXJk6INCyHdJjliRfecd8FhZJOl0NJ72xkcSjQgIzyY1KGueex1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114



On 12/25/2024 5:09 PM, Chris Bainbridge wrote:
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
> EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
> 
> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> remove the extraneous kmemdup here as the EDID data is now copied in
> acpi_video_get_edid.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")

Thanks, I agree this is a better solution for this issue than 
duplicating in the AMD driver code.

However, the subject seems wrong given where it lands.  This is 
primarily a patch to ACPI video, so it should be prefixed with "ACPI: 
video" like other commits to acpi_video.c.

With that subject fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/acpi_video.c              | 3 ++-
>   drivers/gpu/drm/nouveau/nouveau_acpi.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 8274a17872ed..151d1d534264 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1485,7 +1485,8 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>   		if (!length)
>   			continue;
>   
> -		*edid = buffer->buffer.pointer;
> +		*edid = kmemdup(buffer->buffer.pointer, length, GFP_KERNEL);
> +		kfree(buffer);
>   		return length;
>   	}
>   
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


