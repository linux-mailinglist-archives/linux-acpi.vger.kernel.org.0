Return-Path: <linux-acpi+bounces-20883-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKAxNg77hWmzIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20883-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:30:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C42FEF5E
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FC0A301F1C8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3640756B;
	Fri,  6 Feb 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNsRk62O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F4365A18;
	Fri,  6 Feb 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388086; cv=fail; b=GKC+HIguEkUoaMxm6yn/Q05h1DByIsZnuBCvcjuzx2D1xvGTSIFiv2eV1GnHDi5UC18No/NZhc9Efb16lHjl7JnVS9mJ51hV4uCPfBVxNHsH02ifehcmCqRXhoZSICxB7GDk+ddIW6YSLS8W3abnAuh89AJDzhuiVtvkGk/fwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388086; c=relaxed/simple;
	bh=2/Ks56t0nuee37OGHjDw017iohofKQOBqLe2N/LdBvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee2Bf64/yo4Kpi8GPHfk4iKN+F4O/LMa2Lj8WK2FTPKbLVuBJ+IbSUTN4fvv/IN0/oCnEcGI61Iq9WZjlgvggPPAMUhijJW5l5oMBHT0JBdSDWuKA8kagzTRS2Gmjb6bt3WO28oBRYob3gXf0HS6f31/0YJRc3jlM8YVKLooX+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNsRk62O; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNUWdS/yLZbgBZDeL/4OOKDeMBH7nXPyVoJOEjCi1BXfmk7UYQuLTDkqBMjU//GzNkR1JuiKTSJ7LFEPgD0SYUoIjK4h2lseruHIWVMyz6XYYEt/KOvE221lpO+/VmCjsyBg5/igeaqjr0AZTajxg6KkiuvVM4zht+OjpSGtSGkSPS7Z4u7NDsVFAaLWzD96M/AEirvudLXAoQE480Vw3yEPGjkMG7FrZHei8/QW6t2jd4Xq6IoKa5AoEAqIgH1jSgx6mVssBBD6+n7LNr8GrjTREpmO3zUZtOQYeiYSSuaWfLYsJ49wsSCl15MVYkU0a+n1mm+Hz2qSWVdVlf5rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8vZJB8rgtsxsZgkgJnUJmWJG4RLkoX/OO5klTM9D40=;
 b=ZP7Of/nGLG7P4xRtcFZFUt5tgjfMLnW49t54zj8RlO2+oPhAYruluRjTsDk0/RxsfSwAkLqgo4d5FOTFULMvJHiZRIiRXscMyv1IaSBeL8embmA7kuFfmB1oqwsHwQ39kOJK5Kbgrik5OGyjMjcGKXSm4m4x6c/MCAtwzjHhUuy9HDrHNLdf6sSP8G6Se1sBXeCx6YyfNk/3CNcfpW0DZcpwxTFYje0VRfSnaa2DdpyuDHvDJec4ttO9zi6kmykquc95+izx5HMSBeEtMu66vLu77nbZnerCrUC0+NeD57kLAolDDvTZvOjK752rJ03ampEbX0gOUF5Yc/344QqPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8vZJB8rgtsxsZgkgJnUJmWJG4RLkoX/OO5klTM9D40=;
 b=sNsRk62Ovky0S+FAqLZNQ4fk8UggML6l+w+GkNnPLJcRt0qem1h1tZ9vwpSC6jqRHUzy5YlQ63inQU0dN23yaQYohFTXr+KJ0FooR6KbsZP7N9qMbDReLJwo/CTsAsYA6l87zAc0/1XZYRF/UCMGI5LD3LpDgrGr6uF6eiAJNCcaGtZ8T3pqKMNuHthsVAMz9B5gvG1biZgbI0a3zOQSe/fuAq83Tf0kAFFD/kYO4xYGPXj9YWaTrUXbWzSRe1PFRnHac0EIy71mZsiVCMxiEcyZDiWPcsOp+e7SeD79NRgPJXBleLh9JcFSSF/Y1drEud4NLsrd7i58sMGp8LC30A==
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:27:59 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::69) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:27:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:27:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:27:44 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:37 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <yumpusamongus@gmail.com>,
	<dedekind1@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v8 3/7] ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
Date: Fri, 6 Feb 2026 19:56:54 +0530
Message-ID: <20260206142658.72583-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206142658.72583-1-sumitg@nvidia.com>
References: <20260206142658.72583-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: f6959fb7-34a0-42b2-874e-08de658beda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSgVHSppvt1+86vt42195kIRQwk1r3cR3DAc1ZnO7chUNlCA3TGQ0V6oRmfP?=
 =?us-ascii?Q?dmFUw5XgmizSTTStfFsP8XnFqJsWwgGzUpRTSn7VDZkdTXdWUChSMzRPSF05?=
 =?us-ascii?Q?JqLjkbTfHY/t8lDG3Qb54Z1RZHcfXk0hoBt1dHYVVh3EdT/owBtgAkiP4Fz3?=
 =?us-ascii?Q?KBvoYLf+D7nndJL0vw3bs1VUhNaV9ZzPdP9g4LSXGmE/P95GQSCCYSlantEl?=
 =?us-ascii?Q?ZNl36/CXFZZANq1cLN2gs0bEvp6MlyB/beQ0lkSrSqWc1hp9bdmY0Cvj0SQ8?=
 =?us-ascii?Q?GtimdC4fjU8QnUiDqecqOWpHWZkpMX0XshAAJCIHwfaAA+JbKaJ0YDIhC8OO?=
 =?us-ascii?Q?hplgPG1DKQyB4ugUh3iVcX4jv9reRy1HouCPIPom022muit5DDIHvX5yu8H3?=
 =?us-ascii?Q?C/7JP5eCjx0IYe0aTOpN3BrdQrCiRULwGNSOrJQotykGx6619/i5VLBEO8jO?=
 =?us-ascii?Q?FtQDYyr3Ht67dNM1k9WPPFcAAop5YfAkar0hrkID8gbDcbVG55KfAdp+RjpT?=
 =?us-ascii?Q?t+fORxTVijnTRNSBVgq7CaXsKNWEZ8lM3GIqG/c5zSxM1QtCnKI0In3H9w7p?=
 =?us-ascii?Q?LzHDr7dh243+tLUWHcISODGyCZFZBX0zVgAA9k0tSFOFZZahyXKtfuXdiHDc?=
 =?us-ascii?Q?ENkvpN5koCLDzHwvYIWqzePcXJEC8a2ODHX3xB0LmuZMdUu5ap72BfA1uQjA?=
 =?us-ascii?Q?mKE2ImcMtAbMYqsiWsvaZgcqH1F3lG/4qzHkT+NFryUxVIhc2SFQg6RNvEKK?=
 =?us-ascii?Q?YfvMWw5J5mBKAhe1ukwysenFLiVFIu8XyVj/BONVGWG+qVZWhfWr3fXuWfFf?=
 =?us-ascii?Q?YJQDAxW49+JqTOBx+qnRLuURk0P+/Rz+NQptEiAYWX1e2x9MIJZw2MNGMsfE?=
 =?us-ascii?Q?w5J8YB80d9ZpWPd/zcO/dOsWFF2glOYFEPx97IucqvNTcWHPM9ZD0Dg2oseo?=
 =?us-ascii?Q?8gfSvE2cWFTkGnUX2X+DxImTgJRwJDPXa9qOajffasiBmqX8rVfc9N2xJh4w?=
 =?us-ascii?Q?umtM9+vthHHPi+3uNDTW4yJbIzADpbb2csmEZHagWXrgbZr6+JdZSI5kXQ2g?=
 =?us-ascii?Q?vHpQbjGB0m3oeu5ku7tr2I+DO6noclEB65WCXfZgtBllfQ2gWCqlCgaxqTQE?=
 =?us-ascii?Q?TiEahn7oYa/r2G4097Z6Qr8Do6VKQeS2cTU6l0xisopZWX6c01azpWElg2w0?=
 =?us-ascii?Q?Lyu028lfYRm+3/APW1GGVyjWYTK6d3kyCVZYAUWi/BENKphw/9ZtbhJ1t+qw?=
 =?us-ascii?Q?qsivr5JOysO/70KL+0DBnuFUnkTDhjBiiBhR+19IvW+gZI393K1+tw+ApDQY?=
 =?us-ascii?Q?eZSg/tlnRfsmMUVJd9IqL+bir2JaRQI7Ds+iQF9fchJIGeesGDbMFbDAOwe/?=
 =?us-ascii?Q?IPhhFI653MBCS+xRrC1nmvG/rlhfdUXow1kLKRrLcr3vOpnTuyo6BBfFwjqu?=
 =?us-ascii?Q?J5fDyATMmB96ZqQCwDS4Feajjze1BLoQhbKhWfvv53yBBbhOTSwxp1nXZsgT?=
 =?us-ascii?Q?afDHXXP3U56tSA53Je9FVe7KAFd2/BuQKqD86R9cpl4P8rlyHU7McbdXeNMr?=
 =?us-ascii?Q?kULPkYKml4w5oZ2+xQxWnNFd2nKY1FcCmIjR0RT0TGvlFW0gP1r5TfgEpSEf?=
 =?us-ascii?Q?1avPH2bycP+92uH27cXVD1YECQAjfumBThVpYvVKA+O0ncsts58UJ4l8SaNq?=
 =?us-ascii?Q?Bu8NJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pA6ja2F9I6dXchFL3SWmgKrKxEknLOIC4qcwP3gEYcQddWsdsHYK+enIHrOkW9zjZUfne2RkQKjz9GwrqO6KXSrwTW/L9SumYmzF7q5/0aiAvTtAW0SlGfm9sVOzRcREJZRoTa+/iRg61ijMHKxXV6Sr7dip4ISUYOY2zZSXe2QI7KUgZag9iyt4tVdJ3YEFQYQmnhIYehBzKqXfQL6TUPRo8xK50wiGyz23kduZdjG/nGvj0b/vWXwysH3qnUBb1Q5MRNksvUWLvU4diEqlZHBrwikRmykrz6J6efYORX06b2iFQM8xYK2Ch2LS4NYLeOo0DyZIPm7RMsvV6mDowOWV/WKpjal1uJIvMvRWSIqt4weda746OOpzjvBIpAg3QQg6frxjJ3Agiq4gmp96msA0mmKn6p+tFnKFRkjlhIJ5U9oWEQhjQuXGSnq/96XG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:27:59.3626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6959fb7-34a0-42b2-874e-08de658beda3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20883-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E3C42FEF5E
X-Rspamd-Action: no action

Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
registers when they are in FFH or SystemMemory address space.

This keeps the behavior consistent with PCC case where both registers
are already updated together, but was missing for FFH/SystemMemory.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0eb1a6d54e88..08e62b58eb83 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1572,6 +1572,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool autosel_ffh_sysmem;
+	bool epp_ffh_sysmem;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1582,6 +1584,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 
+	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
+		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
+	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
+		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
+
 	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
@@ -1607,11 +1614,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
 	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
-		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {
+		if (autosel_ffh_sysmem) {
+			ret = cpc_write(cpu, auto_sel_reg, enable);
+			if (ret)
+				return ret;
+		}
+
+		if (epp_ffh_sysmem) {
+			ret = cpc_write(cpu, epp_set_reg,
+					perf_ctrls->energy_perf);
+			if (ret)
+				return ret;
+		}
 	} else {
 		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
+		pr_debug("_CPC in PCC/FFH/SystemMemory are not supported\n");
 	}
 
 	return ret;
-- 
2.34.1


