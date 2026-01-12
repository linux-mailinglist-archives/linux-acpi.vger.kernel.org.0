Return-Path: <linux-acpi+bounces-20190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C607D125DE
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B0130317B0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD38356A2D;
	Mon, 12 Jan 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fpx6A2kG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fpx6A2kG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD030C61E;
	Mon, 12 Jan 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218322; cv=fail; b=qmdDv20L3Vnx1lOzxzeOac4+VIqE7KGLu9eC3jdR+sdHNxBcMR9YJlsNnhZcSFW6SFC/o8rbwsFMVHB8xLqQP4sKpv79/jBBdRs8pJJUlXfXvP98cDlzi++8rmLAzMtYH0qMvx8hydJthj+Od3+vSJa/kF9ecwgNRxxx+omw43w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218322; c=relaxed/simple;
	bh=1+SbpJAo+fhC7INFjh2mKV54BFlFDP0ZI+FjCabKNeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j48GvDu6goAC8dFG9IShL8t4hVSB+/S7rtYSMxFanTR3JBJzb8J53NAOfssEUJPAiNgcSRBO26BbZdElUeO7cf1EFHttnXoF6WcE+rFRILA4GhGSh16jj4P3yFKl1bRftLZUth7rLZsvpUetJOA/IcuIQRgylrL/da1NXuoi8DU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fpx6A2kG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fpx6A2kG; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FAs9FzjyCJjYJy/wKVlqiqME5AL0uYtzEI/phUVdfHP3iIVr9LaK29AFr1Eaj7PuFXRbanKuVloZS5Xj4hdfkz8b0DANrPZo+2upcwG6JeUPSx9x8w/lkh1Tdnj8aqOn8+UhzwEhwlKZA3nI7zMPOUlSTzHcjlWozIFu6YeuJukThVPNTEzsUo6trspbg51lXRGKbJLQt20WcijpNPXiqKiHuZZFaKEZIyrVdIz9arcRNGnqdw6Xj6fqzyREmzbwbHBdIeylrKFxydOo8hvM9HaCcWdBm3n+FkgVrXMA7i9qGCYfXPtM6CKzgoA3p0fzori1VAx1q85xIQbookxLEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlwxxRfUBqHRa7OVpbOWU0kXXXXaaIxlWYzr1pzzpm0=;
 b=JZ5gQF8rhvSXohyJKpU8ESfsThHnAQO+ZNeGlWHUV5ZwFWC3Ewml+8vOiby32o5aZwDdKm7qzdA8P4up4wngJaJ9UktEafF8Q/nTBCj2dBXBtgQxTsLZB+SLc/2pm9cQ785sVCaWitmhI00hq4UHXrD5YROlg1ytQ714mVYrFEg9/oPwc6O7nnti6mbNDo+ieNN2Hyf2AYe9NcbD+WeCsJCo4hER3/yihLlysFjTWq7csheUsAX1vqt7oLVUElYK/XRwhL+syCJslrFyFL6JHHTElbVdXLD3U4i7F01eMmlIQKwHm+e9PdarM0Z1LrEN9InpSDuvZ0/vH3PzTQRiJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlwxxRfUBqHRa7OVpbOWU0kXXXXaaIxlWYzr1pzzpm0=;
 b=Fpx6A2kGVrk3qwJBnPA2eEQXZsddZ33v+lFtXa9YP3KEk+Cx/gINei/W3Btwz9kQWn25z6xIDmfBgsb6j75bzUksB1E/Paru2VqM2ZW5DAvwXycbva6Iq6AVJgZOG9rvn5EAjE635wHjpErL/oIT//ye8JVxUs9VrgPyykl0lGg=
Received: from DU2P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::35)
 by PAXPR08MB6415.eurprd08.prod.outlook.com (2603:10a6:102:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:45:13 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::b2) by DU2P251CA0023.outlook.office365.com
 (2603:10a6:10:230::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 11:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 12 Jan 2026 11:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs443ou8V7/qk83VY+gIiN5jrkINBhWca/joTppgbcEk8s2RR+DIVBsnCZCFZSz3S8Tf9Slx3nHN2f2+vkysHqKWOpOwC0lm551bSNeWAalI52A20obgGvdr8d/yIRoesLcPYn+JDtPwYBg6r6r6n5vtE/vm7fTkXV/sflmq/pWlvgF+NLb4bR7hbfsLrZ92g/cVJ+CJOVziBX4CXDuaeukkj71nUW425u+KJrReO8NoBKVGySViPcyf/eJJZdgikGFFtrVzxCTcHFkriZtNTHhT0H25YNBW8+vaVWUBB18GutiHtr4B+YvcpxnKBZEOG/4CdkN5ZEwKgeFrBUgtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlwxxRfUBqHRa7OVpbOWU0kXXXXaaIxlWYzr1pzzpm0=;
 b=oX5fFS62jAYLb8mvkSljgIuVG/TVV0zLretRejYImp6rWVnUZw3RRC6ghVCPbreUnRzIAG7uKBY007saZZeuoukTiLi1eX7ONKbmoPa904Y54KxZcCFNtdnq+zFA+p4nO112xSWIgMNmu6D8HgIGpq2qyamTcDs1HBAveqEg5lZlQ4jC4+hU8MOzSqjBiZ0ik/24dcTzIrvEKV097EqAglJkFV6Qpmb7J+81zAszir3Q2I34zY8mclC/JymBSYye7kfs7r9Fkmv4FqgwjWom9WsyE7ZE8rXO8+4NqIhwPr0Q1EfdtPe/42DuZg6TXihDmsrUp279btbJBhk4/3Xg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlwxxRfUBqHRa7OVpbOWU0kXXXXaaIxlWYzr1pzzpm0=;
 b=Fpx6A2kGVrk3qwJBnPA2eEQXZsddZ33v+lFtXa9YP3KEk+Cx/gINei/W3Btwz9kQWn25z6xIDmfBgsb6j75bzUksB1E/Paru2VqM2ZW5DAvwXycbva6Iq6AVJgZOG9rvn5EAjE635wHjpErL/oIT//ye8JVxUs9VrgPyykl0lGg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI1PR08MB5423.eurprd08.prod.outlook.com (2603:10a6:803:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:44:09 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:44:08 +0000
Message-ID: <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
Date: Mon, 12 Jan 2026 12:44:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
 <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0231.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::20) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI1PR08MB5423:EE_|DB1PEPF000509F4:EE_|PAXPR08MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: cf70df26-bdac-4504-5d11-08de51d00be4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cVBWdC9BY0xTTCsxM2FFdnpIVG1kb2tiWFFwTEF5M1M4ZHBtTmd1M2lUNGdH?=
 =?utf-8?B?SEs2VHZGcGFtVlUzMzJJZVFMNFQxRFgrTElCTXBVOFFCRGNxeE0wd1M1SWM5?=
 =?utf-8?B?RjFET1JjTjdZcUtVSmlJUkZiNktHR3ZNbGNMUkk0T20yUFAvUE1BblhMQU1U?=
 =?utf-8?B?M2FPN0wwek52QVpuZ3BpS3NwVGdES2JmM2FqM0hVdDQyYmpTOWs2WGgrQmFP?=
 =?utf-8?B?U2FsNjhhUER4N01UTWMxMmlFZTRJSkkwS3FDUzV2clhuTUlCTXRLZjBzZ3hY?=
 =?utf-8?B?eWRob1hJcFlNUUtlYkxKQXdGa2hBdXhFUWNCOUJkTTZrOVdoaTJxd3o4VDFp?=
 =?utf-8?B?elBrY1lXc0s1RDI4ZVFHWU1Na0tkY3cxR2grV3hLRmMrYXpEcDJXaUtjZlVa?=
 =?utf-8?B?SCtkcnJtb3ZGMlplZ2t6Z2ZENFNoRzltWU9UTGFmZzdNNm96dUVzODA0alJY?=
 =?utf-8?B?WnlHMTlFZUhzeVlrNTBLRm5WNjBaLzZKb0dsMjNMQklGVjRuNkpNV1lqeVRW?=
 =?utf-8?B?ek5WRitoYVhCdUJHT055YXA5Z0wwSm1QOUJNM2dWWTlxL040d2I1UXlSYWhY?=
 =?utf-8?B?cS9wMFpMV0dvSHo0VGNzcVUvMkd2bFczaEc4T1d1djBxeTVuczJZd1Flb0c2?=
 =?utf-8?B?Wmw0YXBYZndNNHY1SHhYMW9zWE1Id2ZkNFNua3VWV3VwZTdQdEE5SnRoRWVy?=
 =?utf-8?B?UGhVU0R3a1Y2b2JENWdOQ1pvNjU5QTl4UmxlSnM4SWx2bGpvdi94aEx4M0Nm?=
 =?utf-8?B?M2VsS2FKeE52aGh6aW5WOWlDZmNvQldxei8wSG1Iam1KbXRiSE5mTm5UenBp?=
 =?utf-8?B?M0t0MHA0WXAwdEhCU1YxR3luNUhTK2tYRFJ3L3NlS1ZGWkdDK3V6MW13RjVS?=
 =?utf-8?B?NjZyQVg5OVRxSnp0RFk0ZU00cmd4QmJ3Z3ViVEF3M1lUQ3gxRmFEWXhnaGQ4?=
 =?utf-8?B?WmZGNjRqZ3lWYS9pRys5RUluTjBWVnZrNkdHM2xnRjFGVE1PWVJWZzEwVFNM?=
 =?utf-8?B?ZXF4WndpejM2ekZYQVdXYUY4QkswQ01ERkFzeThiWVQ5QmxPQjdqOHo1bERC?=
 =?utf-8?B?ZTlSbjJ2T1A5YnUyeEFRcTloenZiaVcwRHdOREFDbEZHM1Mra2VORDJmMm56?=
 =?utf-8?B?MDdRY0hsQVF1MkdzVzRwKzRjbm1YMzJod2xEVDhwSUV0bzhLeHZHSUNLZVBq?=
 =?utf-8?B?QUFUaXhZcE5xUGF6ZUFQSGhxOCs3dk91NkdzSHg4aEpQald6WGdvVExITFRh?=
 =?utf-8?B?WFBNc3QyZFpTODBoVG5FSGJVd05tNDBiRlVYZmhDbDVBY2dWTVhZeklxcjln?=
 =?utf-8?B?Zzd0aHVoV29UR1RYNlVLUXJqSWR2clJnSFpXVmNsajZQTFBLUzJ6akQwL1Jm?=
 =?utf-8?B?N3V1MGo4N3BaTmhCQWlmVGJXOXlkVVY0ZGdZL1JHZlJYZFlXbU1zZnpka1lC?=
 =?utf-8?B?ZTBaYjg1VXFEVkcwanhIODYraExXNnI2dDdrMGRtU1ZDQ3pMR3VZVlhHcDE4?=
 =?utf-8?B?OTVXd1N3UHRacmcxbERmUVJLaFl1Y1VoVXFsZGNrY0U4bWJ5VXVXQm5zVSt4?=
 =?utf-8?B?c0Z3MWdPQ2lpQ0VtT3RSUTUrUk8yYm9Rc255dGptRXJnVzIydjltYlJhaHFV?=
 =?utf-8?B?YTlGK1lyN21hZmd1VUx3SGg3ZC94QTJxK1lnZDNKc3VUamJ1Z2N5WUIvTXhY?=
 =?utf-8?B?dkd2RTNKRDJFYWlnRnhiNE5qTmZyQmlwK3NLNzVyQkVWNVE4ZkcxRFdSZ3ZY?=
 =?utf-8?B?UU5NRXVMaVlZMVZTckpLajVGcXlJN3RHMHJMeW9HbzZLUnBsSWxaaHk2RFZN?=
 =?utf-8?B?NGgrM3VFWWxlUlNFWUF4YkNFWlBreUtNaXpiYjgySlpNRGpCSUpyekY3YXFR?=
 =?utf-8?B?NlZmSVlwRnNiNG5OcTc3aWJYNmt3WUQ5R3AvcEpYR3BmKzBVS0trMzNOUEFO?=
 =?utf-8?B?U3ppNDIxR2JUbWd6blNaOHJIeHo1V28wNy9zQmowVGJNNkdQSDhwSWY1WFls?=
 =?utf-8?B?NFpFZkQzazBnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5423
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8156cbe3-89b3-4673-a5cc-08de51cfe56b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N20rUTRvTUN1S0VSZW9MQldHR3dhenpVUVd1Rk5xSFMzSzl4cmhHWnhJdElN?=
 =?utf-8?B?WEx4dStBSll2dlVKTmtpdkJRb01oM2hTMVBUdDl3QkZsbW9JQ2ZlTjYwWG0y?=
 =?utf-8?B?R3dKUldZTkgwWFNzZnpYem5MRFk0anJlUlRyS0w3YzNhMFNYcFhCcTdLa2dV?=
 =?utf-8?B?cEZkaHRrMDcwN3dFT3VEZ3NVOU5zR3o1RWd0R1VFaHBkVG5HSUIyWEdBNEtK?=
 =?utf-8?B?WFdaQURUcndQbXRJS3RDaWc0WnF2V2xsZ2FMNStRVzg4NEV6Z1ZzRzVvam5E?=
 =?utf-8?B?Y1dxaTg4dnVweitZYlpBM09scVhtYnZhaHh2YlhYUFBzVnlFMnQycjdFVVJM?=
 =?utf-8?B?Qit4MHAxSDhyM3FZTGMvQXRzSldQekUrZWN1RTBza1FpTjUvUUZzVUlRQUZX?=
 =?utf-8?B?MElmUTRGZnJaaUZjaFRRTjlTdU9rcmhQbDNjekZlWTB3OTFma1JQUWtYSjZw?=
 =?utf-8?B?MnVlZURxMDhBSFZ1U21aWHFlVzQwZDFSQUJ6M2ttekl6d0wyMUxDL2ZCR3Np?=
 =?utf-8?B?bFVXZHIxRDEwUXNoUy9YKzJXNStpVk1MaXZGY0xBdTlPSDFwZXh6SW5QTGRy?=
 =?utf-8?B?N1pIa0ZnR2QyWGN2aFVpMnFOYVUrYkxQVXNSeWJvSVdTL0xTYXRpQUx4ZUpC?=
 =?utf-8?B?YVBRU2tzSjMvN1VWdkNvZ3lTNWJFM1FVRStjczFVbXZLd1JFMjZUYTdwM0ZE?=
 =?utf-8?B?Qk1xWmI0Tm1HelowRHVreVIyaXl0ZURObVZVaXNYMStYRUppMS9JWjBuQVlk?=
 =?utf-8?B?M3E4b1ZMMy95NlFsQnNlU21vdmg5YytYOEFPN0JLNTNpUGZUUmZMY0dJaFdX?=
 =?utf-8?B?WUc3cHBkRWxWZ1k2ZVhJTTJCR0s0WTlwYnRuYlMzMGNmai94TEVvUGd2Wk9x?=
 =?utf-8?B?R0RDcXdnbUFZc0RFQXVaUm1IbXB3Q0VSeUVmWXE4MUNKNW04VGRvSW5LbElP?=
 =?utf-8?B?ZWdvUEgwbFZMUXZMRGdVNW5nUGpJZngrM2ltYVZLV2dVK2R2OGhMSDZQb3ph?=
 =?utf-8?B?TFl4cTk1N1FkNFp0cEFsZ3p0NVNXV0M2OVVhMjNuSFZrQUpzSDFOdmJFQXA5?=
 =?utf-8?B?Qjhhc2xtb0Y3RFFkVTY3NXlHWGkvdmRDRUpxZDZaMmFkeGRYUTI1MTNJbnlB?=
 =?utf-8?B?Ymtsdm5HVkZHTmc3RlBUaUNmb2pvRnFqRHQzR0c0eWo5VzdIU1AwRjdhZ3F5?=
 =?utf-8?B?aXNMM2srbnhIM0tIWXFtaFFzaWZ4akprb2VrVmFxWG1sQWxpWVkyUytIVGtZ?=
 =?utf-8?B?ajdCNzUzMHVYajNjMFVKTUZtRERIUG95T2s0MCtocVhzRlRqZmx6WFZvQ1RW?=
 =?utf-8?B?cVVOU3RZczlUM3JwRDRFWGdoVGFkL2FNWWthVzRWK0V6cUk5N3JFT3JWT1NJ?=
 =?utf-8?B?STRJL1kxSDkzYTlEWDdMTHJRaUZERE02OWF1SkhnODh0bm0reXZRNXNuc1d5?=
 =?utf-8?B?NVRweHU0YkNmblVuUTZTRTl3RytkQi9ocWFMUmtmQ0krMEFUTEZWVGh3aWxS?=
 =?utf-8?B?MlBPbWZTS3ZFR2hLZS9hRW5ObkpVTndKdVNTVW0wZGdqTzhlT2E5ZFp2OEJm?=
 =?utf-8?B?dWdKSTdncVZkOXd1R0ttVy9EclpIZmJGRDlnV3FpRlpqMmFERmxPc1ZKbmk5?=
 =?utf-8?B?LzMvRTF5b2N1eWN1M3hwTVo1Qlg4ejJUcGVIUEg2RkNIOUtkK2ZidGpqblV4?=
 =?utf-8?B?OE1Fb1VwVi8wcVZUcndVeWtSbU5FRG1EOWpmaGNMenJJakduTVJPaUg5WWVN?=
 =?utf-8?B?cjBHSm5tRW1PQzRhaVlRcnQ2NG9ZMjV6QjN4eFdtc2dDSno5MWRScU1vSzla?=
 =?utf-8?B?MUtMenBwaDBuWGNCS3VtdFdzb2pnZ3N6VnRDNjdtdkRqR2FaTnBzeS9XRldM?=
 =?utf-8?B?MGZKclZVMVRISHZodk5BZGx3aEp4TEVoSTVvcjdFcy9sZk9iWmlLV2pnMVBE?=
 =?utf-8?B?VVdJSCtFOFd6N1o3cVpFV3VzU0l1SmdmWjJSTUs5YVFlMm1CL01FZlJoMTZ2?=
 =?utf-8?B?SDlUY0gyZHJvQ0Nwc1VRUEJ4NGhsdUNsbDJpeFVKakkrMUF6YmZEWk9ESVlj?=
 =?utf-8?B?Sys1ZFNzTDJkcTg4Q0IvZ3p6Ly9ZdkZnQ3NrV0lMR20wRVExM1pGK0lBMm5v?=
 =?utf-8?Q?sI+7LCdh0PDtnGEmjHah0Vypl?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:45:12.6665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf70df26-bdac-4504-5d11-08de51d00be4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6415

Hello Sumit,

On 1/9/26 15:37, Sumit Gupta wrote:
>
> On 08/01/26 22:16, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Sumit, Lifeng,
>>
>> On 12/23/25 13:13, Sumit Gupta wrote:
>>> When autonomous selection (auto_sel) is enabled, the hardware controls
>>> performance within min_perf/max_perf register bounds making the
>>> scaling_min/max_freq effectively read-only.
>>
>> If auto_sel is set, the governor associated to the policy will have no
>> actual control.
>>
>> E.g.:
>> If the schedutil governor is used, attempts to set the
>> frequency based on CPU utilization will be periodically
>> sent, but they will have no effect.
>>
>> The same thing will happen for the ondemand, performance,
>> powersave, userspace, etc. governors. They can only work if
>> frequency requests are taken into account.
>>
>> ------------
>>
>> This looks like the intel_pstate governor handling where it is possible
>> not to have .target() or .target_index() callback and the hardware is in
>> charge (IIUC).
>> For this case, only 2 governor seem available: performance and 
>> powersave.
>>
>
Thanks for pointing me to the first version, I forgot how your
first implementation was.


> In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
> target*() hooks, using setpolicy() instead (similar to AMD pstate).
> However, this approach doesn't allow per-CPU control: if we boot with the
> EPP driver, we can't dynamically disable auto_sel for individual CPUs and
> return to OS governor control (no target hook available). AMD and Intel
> pstate drivers seem to set HW autonomous mode for all CPUs globally,
> not per-CPU. So, changed it in v2.
> [1] 
> https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/
>
Ok right.
This is something I don't really understand in the current intel/amd cpufreq
drivers. FWIU:
- the cpufreq drivers abstractions allow to access different hardware
- the governor abstraction allows to switch between different algorithms
to select the 'correct' frequency.

So IMO switching to autonomous selection should be done by switching
to another governor and the 'auto_sel' file should not be accessible to 
users.

------------

Being able to enable/disable the autonomous selection on a per-policy
base seems a valid use-case. It also seems to fit the per-policy governor
capabilities.
However toggling the auto_sel on different CPUs inside the same policy
seems inappropriate (this is is not what is done in  this patchset IIUC).


>
>> ------------
>>
>> In our case, I think it is desired to unload the scaling governor
>> currently in
>> use if auto_sel is selected. Letting the rest of the system think it has
>> control
>> over the freq. selection seems incorrect.
>> I am not sure what to replace it with:
>> -
>> There are no specific performance/powersave modes for CPPC.
>> There is a range of values between 0-255
>> -
>> A firmware auto-selection governor could be created just for this case.
>> Being able to switch between OS-driven and firmware driven freq. 
>> selection
>> is not specific to CPPC (for the future).
>> However I am not really able to say the implications of doing that.
>>
>> ------------
>>
>> I think it would be better to split your patchset in 2:
>> 1. adding APIs for the CPPC spec.
>> 2. using the APIs, especially for auto_sel
>>
>> 1. is likely to be straightforward as the APIs will still be used
>> by the driver at some point.
>> 2. is likely to bring more discussion.
>>
>
> We discussed adding a hw_auto_sel governor as a second step, though the
> approach may need refinement during implementation.

I didn't find in the thread adding a new governor was discussed in the
threads, in case you have a direct link.

>
> Deferred it (to second step) because adding a new governor requires
> broader discussion.
>
> This issue already exists in current code - store_auto_select() enables
> auto_sel without any governor awareness. These patches improve the
> situation by:
> - Updating scaling_min/max_freq when toggling auto_sel mode
> - Syncing policy limits with actual HW min/max_perf bounds
> - Making scaling_min/max_freq read-only in auto_sel mode
>
> Would it be acceptable to merge this as a first step, with the governor
> handling as a follow-up?
> If not and you prefer splitting, which grouping works better:
>   A) Patches 1-8 then 9-11.
>   B) "ACPI: CPPC *" patches then "cpufreq: CPPC *" patches.
>
If it's possible I would like to understand what the end result should
look like. If ultimately enabling auto_sel implies switching governor
I understand, but I didn't find the thread that discussed about that
unfortunately.


>
>>
>>> Enforce this by setting policy limits to min/max_perf bounds in
>>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
>>> to change performance limits in autonomous mode.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index b1f570d6de34..b3da263c18b0 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -305,7 +305,37 @@ static unsigned int 
>>> cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>
>>>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>>   {
>>> -     cpufreq_verify_within_cpu_limits(policy);
>>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>>> +     struct cpufreq_policy *cpu_policy;
>>> +     struct cppc_cpudata *cpu_data;
>>> +     struct cppc_perf_caps *caps;
>>> +
>>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
>>> +     if (!cpu_policy)
>>> +             return -ENODEV;
>>> +
>>> +     cpu_data = cpu_policy->driver_data;
>>> +     caps = &cpu_data->perf_caps;
>>> +
>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>> +             u32 min_perf, max_perf;
>>> +
>>> +             /*
>>> +              * Set policy limits to HW min/max_perf bounds. In 
>>> autonomous
>>> +              * mode, scaling_min/max_freq is effectively read-only.
>>> +              */
>>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>>> +                        caps->lowest_nonlinear_perf;
>>> +             max_perf = cpu_data->perf_ctrls.max_perf ?: 
>>> caps->nominal_perf;
>>> +
>>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>>
>> policy->min/max values are overwritten, but the governor which is
>> supposed to use them to select the most fitting frequency will be
>> ignored by the firmware I think.
>>
>
> Yes.
>
>>> +     } else {
>>> +             cpufreq_verify_within_limits(policy, min_freq, max_freq);
>>> +     }
>>> +
>>> +     cpufreq_cpu_put(cpu_policy);
>>>       return 0;
>>>   }
>>>

