Return-Path: <linux-acpi+bounces-12562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E313A76813
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19332167369
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD4121770B;
	Mon, 31 Mar 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yk2QFb6c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E221577E;
	Mon, 31 Mar 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431665; cv=fail; b=awyYmtr0QON5k0/x05VrJeWQP3k5aclr5yb5L3qn3X4bnJdNwKPBilKMIAYSWT/pobcJAeFrG1IVVHRnCPdJGbyKbnzWWU61Tgyn6fIHZd2jXE55DUlPLvK9EMaDX1Ry0tm0oVWVllkNQLVw3jHQkYHIf+1i3wd2r6SnKNMARVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431665; c=relaxed/simple;
	bh=47pZGroAsK/2MpWX4X1QXasealCE/qRmQTtTQhPCMvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVDjXR3GqzcEtVhTOsnIorc+IBB62QwQKwFrQjt3iVH5otAKb/g7YeYPLQguq6xRr9P8PFA5HywRTIfH1J/fIbLIC7Th20J6EzaXNFxFLI9w0hPxozxdnecPVh4IjVUpa4zt5qXIkgH5GROi6nevkK4O8ZKUpvR8zGy5jYRV0vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yk2QFb6c; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5iGpNStNl0IXN9/zq9Ps+Wh9d+QB/IFlhiOCMXxtzE/N0V0XsaZTtygAuDVaUVBTL8u1qfv6EiLEBwdRKmMpoRvJ3lnxBzxklRGiaIQRdMiSiFXcdeNcp6kw+oRbQnl07yr5Q1fOSGIK0xKrOqZSXRBRftqdctdtezY0+/k/n49+Ibwm4rZUd3YOv/Ws7q9HQM2sRqLK7yVwAEQHNgfKiiphO4TMddPjQnSLLJlEOrLraUt9oGUpSJ5SuN5T15GYJPEJfERYkQQUW+i0uog/ewPhrG6hD4gCxJTVuVF78BP09MlxSejzU3tW+00fWe/7Nlxz1zeHZVMw2E22w2/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuiztvmF8rYrvqAJDjvNjMSUWD6R3brnJiGmsw6zLNI=;
 b=fncGNzwnfdNZiMfhihNdZb8v4M1t8jvEytyOAbys0LQzHE31/Ag9GPDgJ7o7OqY8H3IVgkF5x2+t2yY5KsVEMBi03tEAlUKc0qD/xAkCBMmk5z2AcSWBFLnuxz4ZC2FUSlWjq6YZ6gmNaKArHuD140eWDF2HsTIodprq6TolwAusZPs7q3QjJL9QSNSEUUdHcAz3nJZdsNdOt0nJiKgoZFrXn3iuWeRINk01ECkFlEg2JhqAVF/TeYu3/WSvOHqZ/q9NEpKXPeqFsFH48YrxZmsW36f2LYQOw7T9tWNgbx1WMPmL57L3BhUox5uOGfQk8PbnaXkMtBJ6oEV2Ct36Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuiztvmF8rYrvqAJDjvNjMSUWD6R3brnJiGmsw6zLNI=;
 b=yk2QFb6clsHG2QkHo1XWQR1c4Vy/x+rKVVezgWf6Zib3rgDHCJNvOO8PokALkhAmBiweEwQ8xGcxkc5LzR9xlmTDvB7faeLGOpm8OuKaizJCu6s1vaNJJWhBInWxugzD3cGVTvCA8YPiUoDz+WYjSv5pOCjWg2o8jsnehvSu3io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:34:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 14:34:21 +0000
Message-ID: <492a990e-0af4-4acb-be4c-8821fceea2a0@amd.com>
Date: Mon, 31 Mar 2025 09:34:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
 <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
 <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
 <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 80132f1f-16d9-4e66-6fe4-08dd7061200e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFFHOFYvc0oxY2hoUURBL3pBYUZVVEJhcHFqWmlTTEt1UDNlbkxXS0pZdyt4?=
 =?utf-8?B?Y3hDeE9BamhmcWhXRkMrNkFROCtrbUlPaS9hbHNYdHdydFZEbHRFM2J0TEJa?=
 =?utf-8?B?T21DVmVwM0NkSUx4VXdwUzdleG1FRjExcnh3Sm1vSXlBb0d2bGE5cU5tUDNl?=
 =?utf-8?B?ZDZSUFNsQnJReG5iWG5YaldjZ2U3MC9QTDNVaWJnZkNzeFhTK2hMM2IrazU4?=
 =?utf-8?B?U1dxK2dIS25ZRDlzTUJ0OEdBSVphbTAzOTRVdzg2YmRYSlVpckhSOWVrV2VQ?=
 =?utf-8?B?SkJKRjJkM3NTZkpaSEJnR2Vsd0dTd2NxYm1PRE5QS212S2pFaGEwWVdjc3d2?=
 =?utf-8?B?RFNia3l0QWp4S2pNcWtzellVOTFLbnRsRCtreUN5K1haaFhPY3Q2Y0xaSDda?=
 =?utf-8?B?R3p4a2s2SXlRaXFpU2VqWmNVeHh6ZnJ1SFdRZWRKc0R2Y2lEbzNHOUN1MWJw?=
 =?utf-8?B?VTJmVXNKSEVCeXpVRHZ4VWRMU2czbnFITjVVckI1dHZiaEs2UmFGbHl4QmVm?=
 =?utf-8?B?RUJpR0pNQTh3UnZNQTdhdFY3VnVTSjFKZmZSUVdMNGlKT3VrdWNOeXFkZE95?=
 =?utf-8?B?d2lFUmZkN0dYWEM3RVVEYkFEb1lqd1VFSys1dWJkWFEvTGhXQUJtekhsbTB0?=
 =?utf-8?B?T2YyTFlSVFM2UXNuQU0zOWpmSGtTTDhNWWZWZ3R5eUdOajJ5anhwWWQycTBi?=
 =?utf-8?B?dUVmNk5SVXhTcit4dm9JMmtaQy96ZG4rUjl5eHo0MmwrNWdYSTRXa2dkRTF0?=
 =?utf-8?B?cDZKVFpySkJPZVFBbW9HMUN2WXdIbFRuajloQ3pnVk00aUg4aHpwaWo4ejBS?=
 =?utf-8?B?YWxGTFh0bW80NlQ4bElFa0FUNk13Qlh2VUllSU5TbnZ1ZWJpSU9Lc2xpVndr?=
 =?utf-8?B?M2RsU256Rm8zWDRURTEzSHo0K3N3Vys3L1Q2T2F0TnFvTW1ETndKZElMODdC?=
 =?utf-8?B?bzZHNGxxWHMxV3M4ZVBOS1poak9jdzM2enlpbklnRldqUytMZTNRSng2ZlNR?=
 =?utf-8?B?bXJFUFFReVAwMWY2Ny9KelNiQlVxbXBtclJ2dmJzN2Q1L0ZrSUNxc21ENEIx?=
 =?utf-8?B?WlVCcDdwWGZOTkw3VG1URzN6N1dza29zdWxTMlpnOXQ0eGJwZm4zdDNCQ2hL?=
 =?utf-8?B?RTJxeHNsWXFzTW5DOGwwU0hqMmovUEhBY013aDFWbHJTb2ZFWkx3UjRSMlhZ?=
 =?utf-8?B?YVp6YkdROHl5Umw0TEFPcCswdVR0VTdob3BGak5oTzZ2UHJzQlRQdi94VUZq?=
 =?utf-8?B?Y0o1MmxDM1BPUEpqaW0wamVuTzdsQjNTWExGWXdoSFRRNVZ0K1N1M1lzd3lj?=
 =?utf-8?B?RVU0M0hNZVpDeW1reEhHQzNSUkJuOHVMQyt6cklkZExYMEZIK2VzWkdCUGZF?=
 =?utf-8?B?Qi9kaldnT0dVWWh0Q0NsSWNNUTZoK1pnTXM1ajBpa1hjTkNmMDRQWW9EeFRT?=
 =?utf-8?B?aWdhRCtuL2xHakw3ekxxc0hMb1E1SWFmNzZVMEdBcWxaK2gyQ1hxaUJ3eDJY?=
 =?utf-8?B?NzVWeEVkQzY0N2tZTUorSStDdUxBbmpCVmVWTW9nYThvb0VHZ3lsRy9VZXpy?=
 =?utf-8?B?Y2FscW5EQ0g2WGwwTFk3ZXBTTlNBSVNHc3lOMzBuQUVDWi8zcHR5U1FXL09P?=
 =?utf-8?B?OFp1S2lPK2d5OERGYURydmlFWU16WFh3d2NZQ0MxUHNyZ1FCTjNMT0hzeGEx?=
 =?utf-8?B?di80NUVQM3g5ZXJTYWNwZjNQby9DUHZjTjhBMG5VaFRsMG9zUkZYRmRuNmdt?=
 =?utf-8?B?RWkrL0JLSFY3Q2gwTEM4YkdOQlh4L1BJbHRqWUNpb0tkeCt2L1d1eExILzdG?=
 =?utf-8?B?cXhBTzlwb2dHQmRkYi9qeVgyM3hjZXVQMy9MU0FXazZqUU0rYzdqWGxYSHJZ?=
 =?utf-8?Q?PjyGeRYqKzzGu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzIrRDNoY3orVDVCa041ejVkZmZyZ2hFa1M0MjBud0Q1TElkeGFDbjVQQkwv?=
 =?utf-8?B?TGJqVER2bjVtWmxQZ0xUcXlVZDJuNXJzNEEzZEsrVGJVbHpqcVYwRTlOUUxM?=
 =?utf-8?B?V2c2UUxPYTZndUdwbFRlUGgrbTVQTTR6czNaUGVPYjlMK1RlVmNDM1I2TW43?=
 =?utf-8?B?b2d3K3hYenVDM0NtQVB3bVppZ0tjcDNHNXRvUmFnRFRPTVZmbURZN0laN1Qv?=
 =?utf-8?B?VjVBK1lEMkdyZE85cS9pdnp1S1pCZUdtODVlKzE4WG5GVFUybU1hS2t1U3U1?=
 =?utf-8?B?czY5UldyVlY0RnZtZmN5cnlFbUlhV1BUOWUwQ0hpaXNPUnIrVml4OTRrUFls?=
 =?utf-8?B?Ry9xQ3hLUG5Ub0FHYkNzL1lmOWFOVjBZUVJGb29DRjNUbjF5NFYyVjBiNjRt?=
 =?utf-8?B?WHNLWDliTWFEOVU1ZmtOVElXUTJEZ3o3aEdVUjBWcnB5Y201bk0yMDFtZ1dD?=
 =?utf-8?B?RlV6b0tkQ3lnczduZlQ1QUVFdWRJWXRFOEtCaEhINXNpeFp4ZlBmNFVqYk1Y?=
 =?utf-8?B?blB1SHRYeXpMYzFBZDV0SVZZa2tEc0pCL3RpRTNHck0xc0tkT3FrRys4eDRZ?=
 =?utf-8?B?SGFNUVdtMC9tN21wSkRVZklmeXgxMGh6N2JwUHQ5aGdpei9nOTlNZVpkQS9v?=
 =?utf-8?B?VFFJa2Fzc0ZuL3Fjbk1Vb2lCd3BISFJGK2g0OGt6TyttMHNOVEx4TkVtMkZF?=
 =?utf-8?B?UWNDQmUvOGtHWWZwK0pmY0JmcVFYVml4WEtYYXc1cXd3cFVXR0NoSjhBQ3VZ?=
 =?utf-8?B?cE9NYnFEdkJvbWMrVFFBZFNOa05uNjl0WDB6eE5DMXMyUkRnUTA4SjVKc0Fa?=
 =?utf-8?B?dS9maC8wZk5oeG5Qd05Fcy9sU3NwbFBKV3VvdkhQTWFLTFRBRnhOVDBuZDJ3?=
 =?utf-8?B?UUxIaVF4QmpYK1RsMnhMdXZQeWdOWXkyblBaZEI5ZTIxYUFTY1lOeGFic3lQ?=
 =?utf-8?B?YWpQM2RYaE0yNERCY2VPemNLeXFyaFZncDVXb0YrWmt2eURTVW9MYVY1RjhU?=
 =?utf-8?B?K3crMjdIdk9kRzJSenFiTVNZbXJoYmlnWDNTY3l0YTQyQVJ2elZlWnBqdUJS?=
 =?utf-8?B?NWM5LzdYZ283NHlabWM1WUJMUTZRYTdQY0VTUlhuTzc5ZlRaY2x1cGdXSVp5?=
 =?utf-8?B?dy9JVzZpSU5TTEs5M2U5eVk3WTlZRUlkM213K2JYUFVFM1Y0WEpJK3lpYnBD?=
 =?utf-8?B?aXY4NTMzR1RwT2FnOWd0Ym13ZEN3QTlFZ0lqZ1loUlFCM0FWcXdUZCtORkxZ?=
 =?utf-8?B?aTdBUDdlSTR0MnM3cVU3Mk1XUDNJTitNdlJFRmUrSCtuWWZOZ0pEN3U1Nkwr?=
 =?utf-8?B?SEs5TVVXaVFIV2RWYUYxUVpUaDd5T042MWx0VVhhVEtoMDVXeUdYNjR1NWth?=
 =?utf-8?B?c3piMlNLMkxVaHIvdmNYdEF6bnVXZzdJemM3WThHM1c2bWVxSG91OWhjMGFF?=
 =?utf-8?B?cWZNQnk5bklranE0TjJabGNKWHRSVUxGRVpFNnA1VlpXQ2NrMytEWHVjZTl1?=
 =?utf-8?B?WXR6Y1FIMFZpai9tRDgwR25kVWZibUgyRzBqWVVhMFFWR29wRDNxUHkxbWFu?=
 =?utf-8?B?cm5rR2FpM2tlSXoxY21SV3FHTCtaT0NOTk1jd0xaRnNQSEtxd2FMZzBtMTFq?=
 =?utf-8?B?aDFrKytVVjJWdVM4TElRTlhPMitJVE5JVUhQeDJ1RnBBc1NYMHZUN3FnV0sy?=
 =?utf-8?B?RUR3aEVlL0ZtSjIyT0JGcldzVHhFa0dTNUo4WE5oYlQ5eWZZK3RJN3YwR2Fx?=
 =?utf-8?B?U3M2NXBDZDFtNENNemJJT0owTkhoY2JGWHBkTFpBb1F0WkVFR0psOWhrbUN4?=
 =?utf-8?B?bGpYMExlMGRBRUh1b21SUHI2Wm5WZTdIUXBSTEVHTW5ZZ21PVE9Ca09ZcDVn?=
 =?utf-8?B?MXZCSFowSXR4L1NQRGhCWXc5VGxkYjFEZndDZjUrZnNWck1TanoyeHNlVW44?=
 =?utf-8?B?ZDlsL0lBVTdKSmxuZ3dZb3BSN05Qem5icVJGZlg0TUtabEZ4N3N2RllEa1VH?=
 =?utf-8?B?VG01UWlCTll4ZlNhOHVFQzJTYmF4c3Z3cVdiY0kxSnV3amsxeGoxak1qVEFk?=
 =?utf-8?B?YXhHSE43ZUIzNUVvdjlFcXYybzFqVCt1RjNFckt1SGhldXZhQjU3SHN1b0dN?=
 =?utf-8?Q?vcm+L06k5ic49P3Kda4M1kDsg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80132f1f-16d9-4e66-6fe4-08dd7061200e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:34:21.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayGdlqRYIEiX2mRGB2ZA/3kV3RdglZstPVilH/2GiRZ/mX+PSuZwA8BdWWJy+rBSQ9wSmimMKXTMZup3EeVy4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

On 3/31/2025 08:23, Rafael J. Wysocki wrote:
> On Mon, Mar 31, 2025 at 3:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 31-Mar-25 1:46 PM, Rafael J. Wysocki wrote:
>>> On Fri, Mar 28, 2025 at 10:09 PM Gergo Koteles <soyer@irl.hu> wrote:
>>>>
>>>> The _DDC method should return a buffer, or an integer in case of an error.
>>>> But some Lenovo laptops incorrectly return EDID as buffer in ACPI package.
>>>>
>>>> Calling _DDC generates this ACPI Warning:
>>>> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
>>>> found Package, expected Integer/Buffer (20240827/nspredef-254)
>>>>
>>>> Use the first element of the package to get the EDID buffer.
>>>>
>>>> The DSDT:
>>>>
>>>> Name (AUOP, Package (0x01)
>>>> {
>>>>          Buffer (0x80)
>>>>          {
>>>>          ...
>>>>          }
>>>> })
>>>>
>>>> ...
>>>>
>>>> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
>>>> {
>>>>          If ((PAID == AUID))
>>>>          {
>>>>                  Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>>>>          }
>>>>          ElseIf ((PAID == IVID))
>>>>          {
>>>>                  Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>>>>          }
>>>>          ElseIf ((PAID == BOID))
>>>>          {
>>>>                  Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>>>>          }
>>>>          ElseIf ((PAID == SAID))
>>>>          {
>>>>                  Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>>>>          }
>>>>
>>>>          Return (Zero)
>>>> }
>>>>
>>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
>>>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>>>> ---
>>>> Changes in v2:
>>>>   - Added comment
>>>>   - Improved commit message
>>>>   - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu/
>>>
>>> Hans, any concerns here?
>>
>> No the patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> OK, applied as 6.15-rc material, thanks!

Sorry I'm a bit late to the party; but this looks good to me as well. 
Thanks Gergo for the solution!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

