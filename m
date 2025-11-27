Return-Path: <linux-acpi+bounces-19319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15382C8EF76
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7FBB4EED73
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9F33374E;
	Thu, 27 Nov 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OXx++mJ3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OXx++mJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FE333456;
	Thu, 27 Nov 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255284; cv=fail; b=VHB+ep2sKKPC/tiVupHWsfbzbHETSdMRJWJvXmWBuwXDtmaLaqlVCHGaZ1tv38tmkBE0e2TyBfpgHkuamQekbpjCJwsoDHnacTaPgHEb/250juyMi/fXFafiW9C199xZBfJgAXyt3gBLG337IY2QPEim0ostVrJ+VwEu9YCTrV8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255284; c=relaxed/simple;
	bh=WUQDkE0H3+UE1Zx2edd6IxSEQiIcynizBI7JYj3iMcU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KR2VvbY1gbumG2Axd1Z/JVegdET8+P+ay40z8820hhDi1bA3hOpFqAY6z5DJie6XTAcqFYrMGg+by2AZcb0BcV0eyenyuFiZd+lpxzQbATYGC/SLZ5EMfcTWtt2ikEVIP90h/qE/Hq1PbNa0Kp31i9P6XMhMptfik51bNoNU/zE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OXx++mJ3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OXx++mJ3; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=x7wNCwcckQOAHCu2k9aGlInG23XPC1vAKQuMYlAbhQXzZYcuoSxout70zwjk9ZgtZl5x+ucff2bWXPqKHtVaDzEd/qXGZsRWpK0lWgLTfoBhh8hspbr+UMNbuuKZ900ZwLInENTmXU6o59AV23LcI7xbdPBEVeCL7idWmYlxu2E0toLQ6aV5X5tDuvBvTW4TwuyKbtdwRfZe985K/LVmpXWW+Y73yD1f42jliVZGmg5gidzuVgtgUIkaOrwOq4/XQzBsyaHpOUOnza8KgfHXu4CIffK1LFx3kFNVSrvXZmSlEIjgoR1RI7ahcM+02mJ7yMxY40fkBna0gPCcewjnVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQVCiee3ZbGkIE1xXjsvfwf2pdroaeUJ6cABhFXoEwU=;
 b=J42P4Cu44S/5OXdHy4z+jBkL15dLND7PwY9UdYzD6mDMctosqRCH/V28xQMVssZ8t3ouCGxs2uWherpb73w16z/gBDGPo0lQqCEVWpZzE8h+sPTFwCyBoYDFzBcycQJ2NEg5Yc1L9BG8SMJQQJhJi15l/waIzcQ/1tDgBEcR642vFtOhwtLIBsBfja1nDdoQRhFv39YSPBtKxwPd7V6y6Frh0ufB2ft8e14+W8M812cPcYWCV2CVZxCHgLPqwq0yByNlnAjo1AHBQfa7PLBuaGtkdNNOyhnWknWWntEdIqNlHaO6oSFyeQ+/I2ELL+YnWbPqWiaULsrURGZHTc1xRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQVCiee3ZbGkIE1xXjsvfwf2pdroaeUJ6cABhFXoEwU=;
 b=OXx++mJ3j/oJ/lbYH2hYp7OpseI4C2Zmp79g3nutQqlZzk9+l8BQXLIBhggDFN4Ko1wwvSbeQrpaRaX4clkG7U0BklJoYE9XPX1KRFWMw7PMbRuNVbyWnI0/iZB1yGwzKREuTYHRxL23x4YbX1Od4NfwgTIwsIhxONgpX0ORMIo=
Received: from AS4P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::19)
 by GVXPR08MB10761.eurprd08.prod.outlook.com (2603:10a6:150:151::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 14:54:32 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::d1) by AS4P251CA0029.outlook.office365.com
 (2603:10a6:20b:5d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Esdtc3W4zFVS45pU/7KS4vCPcf6GVbSVMuevvtrYc9Okyz3n7vYvHXnxVOrYX4a023WNiGMnWQg2NrjLzGDoWy03s8zCcswitU3xaKx8XQW3lA3EYBGqlu4p7Zxajc9Ajm9TyQd89yLhgxgGn/ZVXt5rVT7N2XVgOa+jh4vGon+ExfUtS+qJF1k+C0xnaZ755iLMm3Fw+xeQXezFiCTLZWMB71AI3SjLNUegt0YEbif7jhYL4Ika8/HCurWAQ6K1mel4ipi6Qr1pduZJlFtfxUrc9x04TYDydiwZ6Tzg28yFvrvFJVlBT5Rdvc2gAS0J/MjT0Bd9C7ZR5dTrk2D/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQVCiee3ZbGkIE1xXjsvfwf2pdroaeUJ6cABhFXoEwU=;
 b=vPSmqvsCoY4g58IORaSKST5eW8lXUQfQ1ZsmfWXjuvokCV7YZkoFj+d8l5R1bQV6W2jD8AFCfb/QjdM+ZLaSd6C17LH94QHlP8ODPr2999V6C78hcuNz4QYeoSTk7Yy9EOqC+vAefgCglPRFa/4zWtipVTgYx+wzQjf9gayT+pGVo9I3CF7rju9x0yGWQrDaBgEJUaHvkl1bm2ocC4DiMou5DdVNNlX5KXaONV1xV6RjwfX/gSBjCrtE5KP9m9UGkkPZflqvyinQJ8k+Keor13TcWWS5pwQ4dytT+4Lsp4MqcYq0N0T2pFLhlmXr+Th9v6FQtF0aeAWKcNZZN2lz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQVCiee3ZbGkIE1xXjsvfwf2pdroaeUJ6cABhFXoEwU=;
 b=OXx++mJ3j/oJ/lbYH2hYp7OpseI4C2Zmp79g3nutQqlZzk9+l8BQXLIBhggDFN4Ko1wwvSbeQrpaRaX4clkG7U0BklJoYE9XPX1KRFWMw7PMbRuNVbyWnI0/iZB1yGwzKREuTYHRxL23x4YbX1Od4NfwgTIwsIhxONgpX0ORMIo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:53:58 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:53:58 +0000
Message-ID: <4e80be28-df9c-4c73-a8fd-a28cf3f8f3ad@arm.com>
Date: Thu, 27 Nov 2025 15:53:52 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 7/8] cpufreq: CPPC: update policy min/max when toggling
 auto_select
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, mario.limonciello@amd.com, ray.huang@amd.com,
 zhenglifeng1@huawei.com, corbet@lwn.net, robert.moore@intel.com,
 lenb@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rdunlap@infradead.org,
 gautham.shenoy@amd.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-8-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-8-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|AM4PEPF00027A69:EE_|GVXPR08MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: 18af1190-236d-457a-a9d0-08de2dc4dfe2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bHFSK0dLWFJVQzZtQWxRZVpEcERTUHA3eStTbzEwS3didUxhalhiNzU4Y3JK?=
 =?utf-8?B?YzltNHhIVTdYNXQwVWZXRzd1MVNVcUd0OC9JWUNubzdtQlIrcHUwcDBnY0VN?=
 =?utf-8?B?SDJYcDQ5SmMrdjZzNDJnR0lkN3duSThVN0tqOHMvOHg5SHYraUZ2WmVvaFY5?=
 =?utf-8?B?Q1VHb1NIR2ZIUVcvOTdWVTUxYXFSemZKRzk1QUhNK0FnejFUOTFGVTdWbHRn?=
 =?utf-8?B?WS80eWlkN3dJZGJtY2RNR1cyMXc3WHhKYUhFeHNNYkdqRDF6eDJNYjhZUE1X?=
 =?utf-8?B?UnIwMTg0WDZSanErQXg1NTdsOW0ySXZFQzIvblNIdm90NnNicEZndmZlSHBi?=
 =?utf-8?B?disvZlkzM3NKdTRFRCsyc2Rrd2tNbnpyWlBCcnNiaC84Q09PWDEyckxhNGp4?=
 =?utf-8?B?U3hWSlVaR3lTdDRxR043cFkvakJ5OUZrUjFObTNyUkNwZXBzUWN6T0pkcnZH?=
 =?utf-8?B?bHltc0xrNDlQZXByVXJrZ0ZVSVN0aG1yZzg3b2pIa3dGd3dCSW5CT2lqL0dM?=
 =?utf-8?B?Q3ZQcUMyWlNZbTF0MnlqODErRWFBdy9sbXVRUHpmaU5EeGx4MnI5VXBrQXkv?=
 =?utf-8?B?RmxSUDhKSUJVSXkxOUVuU1M4Uy82b0poOVV0ZERkY0orcTVaL1pDVWo2ZVdz?=
 =?utf-8?B?UkVUWHd0RjBFeWhDUVIzQ3c5bVJFMENuSjU2dkdHSkd2eExvU2hrbmdNanM1?=
 =?utf-8?B?dzVhWUF4Qm1tbUI3ZnEzTlNKbGVqMHAyaEw0aXVIUE81VFNXREZJRDljYTVw?=
 =?utf-8?B?OUZzKzV4SzlVOUFwZy9yR2V3aTlpU3ZsbTY3RVRMb1ZuUnVxYTZjZXNhVWZG?=
 =?utf-8?B?WTRyRHNLNUJNTmNHMENnWEJpZnlpL25qcnFCZHJ2RlNLajkxN1lPeVpMZWwx?=
 =?utf-8?B?VjJvcXorcTZqVk1QYTJUMmlOTHFsWXI0NG56RFBQMVR5eFM1aDR2Sy9vTEZT?=
 =?utf-8?B?Qk1yeTR4R0lLQUxoejhQZEdNNmNmMXd4dmNoVlJiTlJRNkVaWFpkZXZFNHY0?=
 =?utf-8?B?eGdxUXVrSHdxVWh3cWFpVC9XZ3c3TUlNeUtWQ1hXenNMdm93ckxZS2tTaExM?=
 =?utf-8?B?eDNZUlVkd0p2UjRMNk4yYzZiSnh6S0taQ0t1S2FPNklkS2tZT0t5ZmtmL0ZZ?=
 =?utf-8?B?NFN6WEJMMS8xMC9uaTYvR29na3BEMzl4NTczWnJySmJ5UTJPSUt2cHd3VUtn?=
 =?utf-8?B?MCsxVXVUYkNvTkEzRmplZ3NOTmNWOG5lMUlORmVBS2RCUzhsS0RySHBWUVVT?=
 =?utf-8?B?NFZCKzNvdEEyZVZGZmJYTE1PejFXR1VkS2FybkZuNStqd2VhajlPM1RTbmhO?=
 =?utf-8?B?WXNIRmN2NGhTTVRrWk9ia2hMRnRXSFVaNkZyNGxmMWZ5TkYvcWFnakpiVFNG?=
 =?utf-8?B?SXEreHB6MklsWGx4NE8zVlkrZEluam54VGdhOHdUb1R6Q0Zsd3ltOTFuQzZp?=
 =?utf-8?B?dW1WUkoyUTlLMWJ3VmRlU1RodlpVei9ab21EQWZJWFFYeGhYcEQrMWQ4U3hK?=
 =?utf-8?B?R0Evd2pFclpQNEIzY1Zjc205TlgzeVJYcyt4UG5mbzVFdzVnb1BJY2VuVjZQ?=
 =?utf-8?B?SHBEb1dVZk1GTkhidXYzTFhyS0NqcWl5ZWN0QjBSd3BOMzV4eXd6VDBMbUYv?=
 =?utf-8?B?Ym83TFRnRE9JY1Q1VWpITWgvbmhQUlJ5WUcxTDBCWnNxM2NZdktuU2RPVTdu?=
 =?utf-8?B?Z09wZjBrNGNsTTJrdnBEUmNZblZudDQzdU1MZ3V0V25malBlUDJQVFYrSTZy?=
 =?utf-8?B?NUdNT2N1MjBlKzFXV1F0OWdTbE1HaG9IVXJjWFRZTzBXeGVSUmR5dXBoQ0sw?=
 =?utf-8?B?MGlFRTBWekU5Y0hsckRSMXVrZFBqVDZnQVViRWVBVHFNYVJ2ZitNYk9tYTR2?=
 =?utf-8?B?L2VLSG1uTEJzQ2RYZDEwT3BpY0tRZ01Ccm1QeE96cW8ydG1veER3QVkwVXo3?=
 =?utf-8?Q?lSrWzwsp56//942qUQRNZrn+rDm9g+M/?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	36ac4084-db19-4a44-9f5d-08de2dc4cb2d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|7416014|376014|14060799003|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZTRWRvTlZ0VE1PMHhscHVrRzUzbGJJQzJQa0dSRTRIbEFKM3lwQWNLYjAr?=
 =?utf-8?B?QWZ6TUFkK3I0TlFlblJOc1YwaENvM2F3Z3pWYmhML2tUd29RZU9yRjM2Snln?=
 =?utf-8?B?enNkYnBRWmxjUzhhWExpS0JNNjdsOElvYjNPaFlXVERydHJteXN4b1VkUlRm?=
 =?utf-8?B?cTUyemRqenkvTU9ZVzRoQVkwV0ZmR1hlb1Y1NFFpQlB3TlFvWlNGL0FqVTMy?=
 =?utf-8?B?MW9QMkpMVG1VMGt6TFVWNlA0TzNRcVdTSDNLZ0tIbWp6ckhIYlNPaktaaWFa?=
 =?utf-8?B?c01zZ1ZqcWpITm1hWHNObk9tQU1GYXhhclB0ZFNGNnRCakNNUndOUTNYTG10?=
 =?utf-8?B?L2loNldrSG94dUhmZk9mMTMxTDRVckJQeUh0M0VQaE9sdzJtK1V2Wk5DQ1V6?=
 =?utf-8?B?WTFrbE5OWnVGSDNBVmR3R1k1b2p3ZVQ5Zkh2cGE1RkhWdUpmb2diYVZyUmFk?=
 =?utf-8?B?VkUzWko4MUNzZmdCZmluMm9mbXJiaTcxV3lGVEw0WkUvNS9iV0JpMU5NYXhP?=
 =?utf-8?B?d3RWRlV0T2wrZ29EQityeVJqbnV6Q1UyVVE4OUo3ZW5yajZ6RTB2V0FmeVBE?=
 =?utf-8?B?TnlvVTU1OFFVT25iRjkwRERTbnZjZVpVWm1GblltbFVrSTBhV1F2Y0ZVRWlY?=
 =?utf-8?B?VEFrWS9aR3dua2g1RE52L1V3cC9HS0N1b2pJWkxPQ3VpRi9oWThpam5MRy8y?=
 =?utf-8?B?VUtOUEcwTUtxR1hxdHR0VmJzNmNNY0t4ZG5uMzRqY0JUWUtxdVRmY0xMZ0FR?=
 =?utf-8?B?L3U2bU8xWWZJWEhYdCszRnBDVzlyTFN3N3N1OHlkTTljV1pSZ01oc251SDVa?=
 =?utf-8?B?dUZUNmdmZG12bTdtNkhhTW9TSXp5NUZLUnJEWGRrbllCRUZ0YUNPTTlqL2da?=
 =?utf-8?B?L1ZITVM1MUhoaytveUdBVDY5NzVxN1VOSVNFQ2MrQjNIQUptbDViNjFRaUFN?=
 =?utf-8?B?K0J3UW1BaGlpMFo3bWppK0VvWEVYSjVGNXdqNHMvNGpOQy9EemxQd0hOZG02?=
 =?utf-8?B?RE9ldURsbDVnWFhKK09KbzhydnZxQUpBc1pob0JNMmMxczdpaVdnMHp2dy9l?=
 =?utf-8?B?aGZuRlkweGRJcVcrU3l5aW1lbFhNUk9Qd3pYM1BDaVpvQ2hXazRvQWJ4QUJH?=
 =?utf-8?B?NVkwQzlSaGZpRFhVWkc5eEo5YnpybDRDdGhkWmZZUC8vZXZZR210VEpMOXBI?=
 =?utf-8?B?V3pOZGhJaU05b3p3VnFaSk5iMUJBVWJ0U2VEUmg0amY2aXJuTTcxNTdxLzlK?=
 =?utf-8?B?R3p0RFozTGxyanpGVWZlbkdIbi9ZWGQySUFVYjFXWXhhQ2had0pwckdEeUh0?=
 =?utf-8?B?eHlZMHVaMG1aSGtTTklKTFV6c3lVZDFuQzdGSm4xUXJVOURYOUpSSThVNEFH?=
 =?utf-8?B?Z3dtbDlkdnNBeTNPYk4xNEVjRGJNOVRmWFZNRzJYUWFVTE9TMWRLNU1UaGNh?=
 =?utf-8?B?eThvZ2lkNllRMUNLdWRLV0FHYlpGRlEyejRtQ0xWYjFYQldORTFZeEFCRnpt?=
 =?utf-8?B?M3FPMFN2VktOd3ZsVFN6UjJDMEJxUkd2eC9iTGhzL2tqV3Qxdm10bW5XMlpa?=
 =?utf-8?B?YWw1YkZUbmxmeDhZVlFNRFgreG5qM2lhWnlERytsVVg5dVVJOXJ0amM2Vzl2?=
 =?utf-8?B?c2pnQmFvcW5rZWVmcksrNEQrOU11Y0JBeno4WnhJZHpWdjVkblcwb0hhNk9M?=
 =?utf-8?B?MGNPSGMvQXdDMlczc1dnbGdob0hNSlNBVlZ6SzVIelJRbjRSOUhrMmw1UlRO?=
 =?utf-8?B?UEpyWXVmSVp2OHlhRk9ZdnVkdEdDL2VESDJRUGJFTkxVRmQzUmNLUjZFSkxH?=
 =?utf-8?B?UUg3dlBITno2LzF3T0JKWnV6QnFVYTFYMC80OVY5NmwyQ3RSUFRxRDhuY1Jz?=
 =?utf-8?B?aHEvUUIwMWJ1a1ZiRGxZMlFVcndkSXVUdEtoRVIwalFJU1R0dm1WSVFIdVBy?=
 =?utf-8?B?U0Q0SFF4bDhqUElRMjRhSFFEcnVTNUhyT0tSNVFhcy9wOVRMWHFlTWVNUUJO?=
 =?utf-8?B?cUxHZmpKdjdCQzRyYnhRNUIrR3U3ZVNINCtsanoxYkYvSGJxa1lJUnBvdEYy?=
 =?utf-8?B?S2R3U0ZEb1Erai9QZmt6M25rcnd1bXlQN2ZHOWw3cUE1UWdzZjlOcW1HQm5U?=
 =?utf-8?Q?PLlg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(7416014)(376014)(14060799003)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:32.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af1190-236d-457a-a9d0-08de2dc4dfe2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10761


On 11/5/25 12:38, Sumit Gupta wrote:
> When CPPC autonomous selection (auto_select) is enabled or disabled,
> the policy min/max frequency limits should be updated appropriately to
> reflect the new operating mode.
>
> Currently, toggling auto_select only changes the hardware register but
> doesn't update the cpufreq policy constraints, which can lead to
> inconsistent behavior between the hardware state and the policy limits
> visible to userspace and other kernel components.
>
> When auto_select is enabled, preserve the current min/max performance
> values to maintain user-configured limits. When disabled, the hardware
> operates in a default mode where the OS directly controls performance,
> so update the policy limits accordingly.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 67 ++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a425ad575aa6..d1b44beaddda 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -646,6 +646,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>   #define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
>   	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
>   
> +static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool auto_sel)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	pr_debug("cpu%d, auto_selcurr:%u,new:%d\n", cpu, cpu_data->perf_caps.auto_sel, auto_sel);
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
Would it be possible to explain why we need this mutex specifically for 
auto_sel ?
> +
> +	ret = cppc_set_auto_sel(cpu, auto_sel);
> +	if (ret) {
> +		pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n", auto_sel, cpu, ret);
> +		return ret;
> +	}
> +	cpu_data->perf_caps.auto_sel = auto_sel;
> +
> +	return 0;
> +}
> +
>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   {
>   	unsigned int cpu = policy->cpu;
> @@ -879,8 +899,49 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>   	return sysfs_emit(buf, "%d\n", val);
>   }
>   
> -static ssize_t store_auto_select(struct cpufreq_policy *policy,
> -				 const char *buf, size_t count)
> +/**
> + * cppc_cpufreq_update_auto_select - Update autonomous selection config for policy->cpu
> + * @policy: cpufreq policy
> + * @enable: enable/disable autonomous selection
> + */
> +static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool enable)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 min_perf = caps->lowest_nonlinear_perf;
> +	u64 max_perf = caps->nominal_perf;
> +	int ret;
> +
> +	if (enable) {
> +		if (cpu_data->perf_ctrls.min_perf)
> +			min_perf = cpu_data->perf_ctrls.min_perf;
> +		if (cpu_data->perf_ctrls.max_perf)
> +			max_perf = cpu_data->perf_ctrls.max_perf;
> +	}

I think the min/max performance values are still relevant when auto_sel is
disabled/absent. So:
- enabling/disabling autonomous selection
- setting min/max perf values
should not have any dependency I think.


> +
> +	/*
> +	 * Set min/max performance registers and update policy constraints.
> +	 *   When enabling: update both registers and policy.
> +	 *   When disabling: update policy only.
> +	 * Continue even if min/max are not supported, as EPP and autosel
> +	 * might still be supported.
> +	 */
> +	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = cppc_cpufreq_update_autosel_val(policy, enable);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
>   {
>   	bool val;
>   	int ret;
> @@ -889,7 +950,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>   	if (ret)
>   		return ret;
>   
> -	ret = cppc_set_auto_sel(policy->cpu, val);
> +	ret = cppc_cpufreq_update_auto_select(policy, val);
>   	if (ret)
>   		return ret;
>   

