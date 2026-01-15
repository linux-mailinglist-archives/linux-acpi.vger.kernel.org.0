Return-Path: <linux-acpi+bounces-20377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 954D1D246AE
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C17E300290D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914DD13AF2;
	Thu, 15 Jan 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LedpObgB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LedpObgB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54451327C05;
	Thu, 15 Jan 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479512; cv=fail; b=TnfsINj5OOgAVN1IT5pO65+p7RjDdanvfVEMJNVCNyLu+7Jf1LOsFljFhpbw1NbEsNA651qdj5Ye8CQsf35TkYjstpbh/mLhVgwjQbsANUQpBL+aGC9/rJk9WPmeV1Kb4tYWOUdzcFBz5u5UYVMxr+34xfGpwOrZleH028XA7i8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479512; c=relaxed/simple;
	bh=PvNcKKPpgp6pDONwlMDnPapW4HqxL6EfC1QynTWJSTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uVfksfnux/tJ/q0k7Iwa2qJ4orhLLRa1bCoqnQXbnZJvmOkFn6F0QVHZRbcXMvT18rCkAW2ERYHEDzVCCPOR24ZgUFUt7OfxXMoc7OJapV4TFW0FZE0mh0NRsgEvZnhjl768fXfjkmwmJbjrpThlLNuqM8+/rYgfSLwf5YzJq2s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LedpObgB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LedpObgB; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=olVgyjpCrLXtLjW2jFdbq5+wQDyRWHQQhnbgCYVX61Bac3YB7yJDVit3r7gr4Zm0A/sma/DMYPvR7BwEI6Q5VUsbPSYM5huxTDQR5iAW4KLswgPO6XL3iNXp07F+wtFZ6kaRacl7Fmt3vYiy0KFNvXozbnobk6Bp7EqDFeWSXmTFiYEU8HmL65JTQU1gHYwrdU56M+vDJFl/nipUN1Cdh1cyMUFoJTHTAq9Nu+gyHuEE9Kp6eXkRG7kTSzuNznOJ1pcFplJXx7he/pyk1RyTZtnT+1hhnPmQ+ilfAW+6uTL8KB6u67V/JQUlMylXD6Zgh1uWMBBnlOi2IoWerMzQuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acmnvqUX5n4urxyM6FJqHr4KhlJgEVAxE9soFFSMhck=;
 b=AZ7Gf1kjJatnis555c3Bi+8Y6GaieK/l9xS5DJPntFyg8t0/NDvHncZTDbIP5CCpuMyK3ibv3xN5YIIz4HBbNqgysIN2GDafkz2Ync0Xx8x1fc50pbV4gKQ6mYQkxmnzgETlgjGg2DIj1+ybPWkCmRrMVCNBrrALbQCuY9B4gl6V6Nrr6Z49BrQvHbJtjMw8RmY9NFvVh9gvfhfJu1QRzEZbvvA8rBZwECHfOFqbkn0nctbfRQYgPSlakAj+anvXQ0OVfhnDD3TS5GTm0ujU+/a0UO640FmAHmMR1QmKrG1OJg4t/Df3X046whTisr2BJjrQ1K3Bm94JSxHrtOT+7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acmnvqUX5n4urxyM6FJqHr4KhlJgEVAxE9soFFSMhck=;
 b=LedpObgBztQoCPp9czkDKRBVwMgnXM6NMpOJlyQ4B9wUkGrUmV3L9pjq/Val+lbbIA9rnQVS15CFgulz1mG0C4PVtw7QO3ou3dlCsNuVGaYLFhGKinmsqf0I/EDt2WHrxLhk7c5SivLdmUgspwEySDl/VLk/zPmPktpsH7uIE9c=
Received: from AS4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::6)
 by DBBPR08MB6123.eurprd08.prod.outlook.com (2603:10a6:10:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:18:24 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::f2) by AS4P190CA0021.outlook.office365.com
 (2603:10a6:20b:5d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 15 Jan 2026 12:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfsqXWPcMw8xQkX5ogmgoDJ0bv+fg+E9wzHG2NbQ36LV4aJ4Hc1QxUCjM48/g8D4k66Sj2IRlcfAEn5rSJUdmFC9h4xGo0P12zDKwr/vBGYfJW9MXgsiIU3XOPuvlttTDyI0nh42nkqnyvxsdclwD72tRhgTUGMEeoEMGgwpRFQLPW56We+TuIic0qYxug66vLHC1bLGwV7GdSqAWyvlhWENQ/j6wirNpdl+Jqj/UvGvrrSlgVsPdw6i2TTQkmEUbfpKRHaSF455Ild5cvmfupORpTTemc35UtN3MjKpueu6uwXSVqK1e8OCsg9/QfbsFTMO9XTzz2dl/AtdYCN4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acmnvqUX5n4urxyM6FJqHr4KhlJgEVAxE9soFFSMhck=;
 b=xd/x+drfwlnPdLhP9vPTSPYzsnam3IGZk7L/4a5M4pYkTFFwLekz2Owoh66Gq5r9DcnAhj4dnnt2NStdz5pd0S3J3IPYpatSfPRaiV+HTqDPY4x/CktMKto+ecCJ188+kPrTDg5FuOfAOuVh3MQlQLHOQFTk4iTcxpOZNM24XM3SrTdT1SbGINiJNQjhIYMDBrQCJ1yZY3szQ3L7JrH98/0z4azIxHb7ZdBnEd3oR/Kv+iciRs5vftM4iDTiu/+BJTjjbdDvA3BTvKOerdm7FRKD51OqsaSQK2gHYFrrf15wYSNfx/jpFS5YRdjZxEAPE2aati3vwJTpU8/mulJEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acmnvqUX5n4urxyM6FJqHr4KhlJgEVAxE9soFFSMhck=;
 b=LedpObgBztQoCPp9czkDKRBVwMgnXM6NMpOJlyQ4B9wUkGrUmV3L9pjq/Val+lbbIA9rnQVS15CFgulz1mG0C4PVtw7QO3ou3dlCsNuVGaYLFhGKinmsqf0I/EDt2WHrxLhk7c5SivLdmUgspwEySDl/VLk/zPmPktpsH7uIE9c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6884.eurprd08.prod.outlook.com (2603:10a6:20b:305::9)
 by DU0PR08MB9322.eurprd08.prod.outlook.com (2603:10a6:10:41d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:17:19 +0000
Received: from AM9PR08MB6884.eurprd08.prod.outlook.com
 ([fe80::3d93:3e2a:1a1f:95de]) by AM9PR08MB6884.eurprd08.prod.outlook.com
 ([fe80::3d93:3e2a:1a1f:95de%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 12:17:19 +0000
Message-ID: <dc2f3dd7-b9db-4a2d-b431-f70738cefcfd@arm.com>
Date: Thu, 15 Jan 2026 12:17:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Content-Language: en-GB
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 tony.luck@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com
References: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
 <20251229115440.2734800-1-ahmed.tiba@arm.com>
 <20260114141551.GKaWelF-Gsvzr71LUs@fat_crate.local>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260114141551.GKaWelF-Gsvzr71LUs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0487.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::12) To AM9PR08MB6884.eurprd08.prod.outlook.com
 (2603:10a6:20b:305::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6884:EE_|DU0PR08MB9322:EE_|AM4PEPF00027A6A:EE_|DBBPR08MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd7891c-c3f9-48ca-a244-08de54302df3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b2xuSWp5aDVCNmlZbjhQUjZKeWtpTzAwNHdRd0F5OWpWQTZ4OEJUTDg5QU5S?=
 =?utf-8?B?SEJkbXd3bVM3cFg2eXF6RzFYMWprM0ZsMHRJakVYMnNHRUNxc0NOVGhUMFlH?=
 =?utf-8?B?SndWem1HdlcwczNIZVJzTE9mZ1dNaFZQRXhHVXBkUTR5Q3VBNXZ1QTh1bTQx?=
 =?utf-8?B?S3dqT2R1SG0xdWtNSjlRWktlYXZPZ1J2VjZIZ0twWWdzZndlSUhqdXRFZEVv?=
 =?utf-8?B?VHNOalVBSnpUNElNVmNNMzg5TUFVTGRzUmMrSGNkWXFPSElIVGpCZldUT09m?=
 =?utf-8?B?R3NzQTdwem9qUjRySnk2UTNkR1hRZm10S3hvR1ZRb3hJZVMyWk0xYXN3Z1A2?=
 =?utf-8?B?SGdnbFMzaGZ4NnZYa0NlbnpyamZPaklXTlBqeENJcHdkY0F0a2t0ZWpFQkdS?=
 =?utf-8?B?cDBDOGNMMnh6dFk5RVlJMURwUFJQbUh2bEdHTGhUZWk5MXBsQWl6QVN6N3JP?=
 =?utf-8?B?UXhjdFNVdUMwMFI0L0s1S2RQbFF4OGRmOWYrSUVabHp1TzZQTFZTa1pmNlVv?=
 =?utf-8?B?R0lJQlZiRnFpRGo4ZFR6SmxnUmZSdy9EakdUcUFXb0N1NUZEb2hhN3plK1o5?=
 =?utf-8?B?dGxBTEEreDdJeE12Wnd3RnhFYzRRUi9PUFMxSTNZYmhKMnlOR21sdFNBaklv?=
 =?utf-8?B?Zlc0eEljWm93ZnhiaUpVRkFHbWtaMy9UWFZrOXlsdnlFd2I4ajErYmVjeHF4?=
 =?utf-8?B?dnQ2djlUSXVEUXU1emJiYjBoSFBwWHlLdkpnVjlHeEF1UUdqS3YzK1RKVi9x?=
 =?utf-8?B?bGNHVG9KV3hrY1hoTEJTVnhPUFZYa1FmdW9uUFBvTHFKRTJpRVFVT1ByYk95?=
 =?utf-8?B?aDV1RGFyTkk3SzR4WHRuU3F4NkFtUk5JTVhKQ1NKL04zcUpMdHN1QVNUTXgz?=
 =?utf-8?B?M3JERzJLa0NZVzFBS0xETmZiNGdSMVlqRy9tY0N0U3NvdWZwa3J6U09ucGNS?=
 =?utf-8?B?NmVaNi9sVVhqTDU0YjFTdXRHazJ2em9PSlVWSi9ad0NGUDNydnlNYnJiR1li?=
 =?utf-8?B?Mk5HYWNQeWxTamhLS2h6Z29zK0kyLzJXVmdFdEdldE52bE8xMjZGb3c2MUV3?=
 =?utf-8?B?RGRhOU1jYjFJbGV4WXp6bERYOU1aNnRjWEREUlFrM3RTL3hiQkw3Rm12bEVm?=
 =?utf-8?B?TFM0TDJqc1BjQzdXVWpWdHBJaFhwckFNYXpUWWNOdmlxT0s2eW9IWWpmSGVD?=
 =?utf-8?B?bWlIbmpjd1ZDWnd1U292bHNXSVIySkF2MmNBTlZUQ1ZrZC9QVTVNcHBJSldX?=
 =?utf-8?B?S3ozenY2eFk5TFRHUkE5elI4aFM3SGxPSFRxbmE5QnFHaEFoT3ZYRUlKV25E?=
 =?utf-8?B?aTUzSElDU042MnBzaGE5d3YvVnlpZVlKS25NQ3d4a1BTTHNpZFJSdWNJcWV1?=
 =?utf-8?B?UTRjdDg0ZCtLSEFIYjFNU0xPZWFEcjByRzZ1YXJmbm5vY3QrWnF2Z294ZjNt?=
 =?utf-8?B?WXBhNEVyUDkraWYzL3R3OE53U3ltK20yOVBMVkFSQkJhQnlHR0x1RzZ5K01K?=
 =?utf-8?B?R0taVUg5ckNSUTZYb2llVFJPaHpEWEp4UGljNXpIZGlmQmxnRUxaaHhndk1v?=
 =?utf-8?B?Qy9xc3lwYkwrdkppSlorcVN6YWFnbWxPT1VIMEZuQTVlbzRVem1JQ3RmdHJp?=
 =?utf-8?B?Zlo4dEE0Qm9wc2owKzlDd2IyZU1teDEwVXZEbW9icWxxcU1KRTlKRDJwQ21M?=
 =?utf-8?B?bFREWUdhQkltZDN5bWh4SXRHMDdEOW9jcU9LSm92bXZIY2NXbTg2aW5mNnFX?=
 =?utf-8?B?a0EyKzI0czJTVVlGbEZTNm1jOGsvcXBQUk9NMHQyVXdhb3ZmY1RianJ5bkox?=
 =?utf-8?B?MlgxZ3Jmc0JsOGxRcTR4UXRGK0pRMlJUR25Fb3F6WlJsOUpHQW9xTjlkVnd6?=
 =?utf-8?B?VWx5VmtWekRMMjBmN21FcjBhMkxQZHgxT0pTbk5QSVhDRWpZUUpqK0oxY0dv?=
 =?utf-8?B?UUliL2E0L3BabVpJczZhQjhnSFp3L3RxYjBPbTZCVVBoSTcxZW1xV2EzcW5n?=
 =?utf-8?B?RHRIYTRtTjY4MkovanFuRWk4L2UyTGtrUXBka2xWaHcvS240bTNheTJwVmFR?=
 =?utf-8?B?S0lndm0yVUY5YlcwWDhxQXpEaUN1SU5wZnJFcWc2U0xlbW1OeXJwa2JaZ2hJ?=
 =?utf-8?Q?7PwQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6884.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9322
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9ac1501c-9218-44ac-14e4-08de54300703
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|36860700013|7416014|82310400026|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmpIWVhyS2p4R1YwdzQybDdhZDBVUFpHK3lxVHRMYUF1cGRlZ0cvTmg4SEt3?=
 =?utf-8?B?bEZscnliNElGaDlTNGQxdnVhYmplSDJLa0FuaEZKSGVnekdxc2YrcmFjaEhP?=
 =?utf-8?B?UGZIQlcvY1FVeXBjRVhIYTFhTWRGanVKYUJsNmtUdWZrcUFXVXhsdHVmVmhM?=
 =?utf-8?B?dnh6YmlqZ1E4bmkxYkhYeWhaZ3pWL0dnNU1JNlRlbmo5aU5pbDVWY0s3Tnl2?=
 =?utf-8?B?bHZzTlV3UW9jc2x2akR6K3hCbzRhWEpnTG04VGpZZkhFUFI3L2ZBdnVlT1Y2?=
 =?utf-8?B?QUFoMnZsSWJzMHd0UzYyQWhOaGN5bVZwcml5TmVrRDhzb0x5eG9mMlJ1YmlE?=
 =?utf-8?B?b3A4bmQxV0dhN05VRDJGQkpveW1wNDM1MkpSRXVCYklSVllpbmFWc1ZDNGtx?=
 =?utf-8?B?V0loZlZHSE5hbVhzb1JhempvdlNCNWdIdVFUNHlVemNUcXoxTlVweDlVMDZ1?=
 =?utf-8?B?c1I5aGtDdE9RRktKZUNzb3hUL2o5VUlkRXhnQWVJSzhoVUFwYWRDVU1wQkFF?=
 =?utf-8?B?dXpMTXcyS1lsNFIrU1hXU0tUeFFqalFuR0F3Q1Uyd1BFNmJ1ZkR5WG5kSDBk?=
 =?utf-8?B?SVBjb1JhcVFlUmM0NVdxTjVKY24xWndKY0NOUzVUVkR6OG9uNU83RHRUUWVS?=
 =?utf-8?B?c2psWGpxSW1SM204ZGRaV0RoTUtMU1JHVXpvRk95cW8vdXlxRnlaeXRFQ3Bo?=
 =?utf-8?B?WjY2NUZCOExlUmlSd0VSNjRaQXIyajJMdFg3WlV5NlVuNGgvaEVKR3lwenFm?=
 =?utf-8?B?Y1JFOEp5dE16TEkyZWo4Zm9zY1RBNkJvdTF6T0lXMVJRdFlwamFTRFNtWjZD?=
 =?utf-8?B?M2ZnQWJOTTFZRFBPSTk5OG1zUmVkZFd1TjI5VUorWGZCcHFLQkduMlBZcUJ0?=
 =?utf-8?B?ZHZUc2ozWjBpaS8rMzNtdlBSekNzYWpra00xNDdvd2MwK2pRTTJ5dnowVFZC?=
 =?utf-8?B?K01SaWt6ZDJTekQrQUkraEcyTG44Y0dWakt3eldMbkc5aSttYklIVTh5TEU5?=
 =?utf-8?B?NjF6Znk1TUJnZU9lODNVeEUyUmEzeE1va2VpMnhYTytXZnprSm5sUzFSaWly?=
 =?utf-8?B?TTVheGNuUDE0ZDJLZ0N3bkFZVFdoc1BjYUFGOHJJQ29NY1B6cml5OGNIUGlH?=
 =?utf-8?B?STdhTnprVDBvTHJaTkFUbEUvTW9SU0gzOTQyR2EwMUYxNE9kUm9Vc0VKV1BH?=
 =?utf-8?B?RUdzeEdZa0lNSzdtbWZnZUxQVXRuak5zRXE4azZzNjZvNEx4WFk3RnZFYldS?=
 =?utf-8?B?dUEreFY3SGZmUE9yN3RWZlc2bGNxT2k3UnVqRnc3aHhjVWloay92TFNlRkZW?=
 =?utf-8?B?MnE5WjNtbFFBTUIyN2l6ZE0wZ0RPR0Z4cVhQd2RGY1M5ZTMxcmhOekJaTFZZ?=
 =?utf-8?B?ZUxLZGV4QlhMMXdrditHTGthdU1TcFUwQ094eHlWb2NFOVhPR29GV3Izbzkw?=
 =?utf-8?B?MGltT1NwQ3lETWwzY0g0Q05LUUdwOGh1aFZmWmtqNGxhYjdHMnFtRVFkVVdl?=
 =?utf-8?B?M09va2Z5Y1R3VHJVUWwvbWh1UnVWSnNtY00yY0RabFpOa2t0NUZZa1FJVk96?=
 =?utf-8?B?d0d3c0xENURzUXdnTkp1djhZSHVpSGtHL1p0MVh6VnZBRm4wQ1ovdi9yUDFZ?=
 =?utf-8?B?aDN4aGFaMGdpdW5DK2l5WStsUWplYTRENmIvM1RpZWFhZE9pQXFaNWFXaFVv?=
 =?utf-8?B?Z3ZxdzBuL3FDbStVcjFIdDlGQ205bWZyU0pnSmpCMXA3ZXB4dlNwa1Uydk1F?=
 =?utf-8?B?ci9WcURFNFgxMlhIQ0VYbDZFdnY5QWJsYkNCUElVeHQ0VnBTcFFkZUdRMVlD?=
 =?utf-8?B?VnRuaUo4SFZtckQ3YThuTU5jS3R1MkdxTFdQMGlldlhVeUw2ZG00YWlGMUNK?=
 =?utf-8?B?b2hmTTBiTHpVYXdlYytWQ1QwQ3RVNnVTd1ZHT0VBR3N2eEJYbHNEZ2dpYzFm?=
 =?utf-8?B?RXI2NFN0Z2dCdGZXOFpIelNZemhtYkdaV2hpNE9zWU1FbDJsOTdRM2pKcTl2?=
 =?utf-8?B?UTROc2xaQWtUbEk4VlhUekh5VFIwSFhpVnA3VGFTWDYwb3d6TmVEbG5UZnVG?=
 =?utf-8?B?TzFaKzR2cmQ0RDJrb25kd2JSZ1N2SkF5RFJpdlhCMGpTSUF2TUk3cG1nNXo4?=
 =?utf-8?B?WWJnYlZFS3FOMGI5aGtONDBQM0JmVXF5M0ZGaXAzMHVXa3J2eTBPdENUT0ts?=
 =?utf-8?B?MUdZUmNOY24zVGYwdk94a3dMR0NaRy9jaGQ5VTJXU1lyTGFEd1NxZFR5Qi9s?=
 =?utf-8?B?ZzlkZXVOUHRkci9uV2lIRnVDQklnPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(7416014)(82310400026)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:18:23.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd7891c-c3f9-48ca-a244-08de54302df3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6123

On 14/01/2026 14:15, Borislav Petkov wrote:
> On Mon, Dec 29, 2025 at 11:54:36AM +0000, Ahmed Tiba wrote:
>> By “error status” I’m referring to the UEFI CPER Generic Error Status block,
>> which is the standard firmware-produced error payload that Linux already
> 
> Standard, schmandard - a bunch of fw crap.
> 
> That's UEFI's understanding of a common platform error record, no?
> 
> So why is this a generic estatus and not part of CPER-something?
> 
> You're calling something "estatus" which sounds like a generic thing but it is
> simply a subset of functionality you need to make it work on ARM without
> ACPI and have packaged whatever you need under the name "estatus".
> 
> Why does this thing need to be called an "estatus core"?

The CPER records are defined as part of UEFI specs, but its primary way 
to report it is via APEI/GHES.

In drivers/acpi/apei/ghes.c, this subset of CPER handling
is already implemented using a number of helpers mostly named
estatus_* rather than cper_*. The naming therefore originates
from the existing GHES implementation, not from a new abstraction.

What I did was lift that existing estatus_* logic so it can be reused by 
a non-ACPI provider, rather than duplicating the CPER handling
in a parallel DT path.

> I'd expect to see a compilation unit which contains shared functionality, gets
> linked to your stuff and that's it. No "fanfares", no CONFIG symbols, no
> nothing.

That’s a reasonable expectation, and I’m fine aligning with it.The 
approach mirrors drivers/firmware/efi/cper.c, which factors out shared 
functionality for reuse without adding extra fanfare.

>> consumes via GHES on ACPI systems. I’m not introducing a new error model
>> here; the intent is to reuse the existing CPER decoding and handling once
>> that payload exists.
> 
> So why aren't you doing only that? Why are you doing all that extra stuff?

Because the DT-based path still needs a clean way to call into the 
shared logic without dragging in ACPI plumbing.

>> The practical use case is firmware-first RAS platforms that emit CPER
>> records but do not use ACPI/APEI GHES for discovery or notification. Today,
>> those platforms either have to duplicate CPER parsing logic or miss out on
>> the common Linux RAS handling (standard logging, memory failure flow,
>> vendor notification paths). As a result, the full firmware-first RAS
>> pipeline effectively only works when CPER arrives through GHES.
> 
> Yah, got it.
> 
> But see above.
> 
> Please do not "over-design" this into a separate thing but simply carve out
> the functionality and share it. And leave it where it belongs
> - drivers/firmware/efi/ is not the right place as this isn't really EFI. This
> is a piece of APEI/GHES crap you need.

As it stands, that code is coupled to APEI/GHES and ACPI assumptions. 
Reusing it directly from a DT-based path would implicitly require ACPI, 
which defeats the purpose of supporting firmware-first RAS
on non-ACPI platforms.

Thanks for the discussion.

Regards,
Ahmed

