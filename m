Return-Path: <linux-acpi+bounces-20884-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFoLANv6hWmzIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20884-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:29:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F8FEF06
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13A3E301D885
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1A421899;
	Fri,  6 Feb 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LoQKFDoJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B7421886;
	Fri,  6 Feb 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388098; cv=fail; b=OGqavoUGTsFzipZpZziZL+kqlhE7Q5DShqdBdzF6t0+Gsxw0Ok96WdrIBN5Y4idI7+QMZ/Z1z+euCTVKrG/WxL/QHh5zAeNVd46E/vB2zBH9/LOuGo87VnKKtPQhPOXB+s0j4vtqbv/h4HLIeRf6LHoM00UcHxX+tKgcV9cX98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388098; c=relaxed/simple;
	bh=BtfMmw87bYwzhAYzX3Bk3JAU4pU4eGvijvLJjIcRH4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTlwN3ENiYatsFyAuB6lokJONmKeUfypxQE4bQJOnyj4O+l6TfizVilJ+iWPK0dUaTUB6qh24qeVSImopFITYZGOoekRA6gmpejGZmbgSdWOPkXdz9QIBXliWSY2C4W6RLgnu+eqdwmydIrZ4SuKNsVO0RbUFwgUyXB1Tf2CnUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LoQKFDoJ; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8FupAjqz/yYv+WQu2C++XW+5PnM3OD2NQpZB4kW5TjsNgImtcGF8/b5WtpBkUOJV3eRRnrPmTi9iNTF0kzAvd8Pj7A3DQAOT/okHuHqwUgthp6TlI+rGU5HGUy/wD5Y6zqb6Ninjw6wqOhqTJQH6d4BAEoUlL4DmZHAVQuneM+RjOcCTh/ALWfLdkCOq5i0urdJQpCI8HGEIF/hKsraVvEjQKOC2kl8a54kHkJTnp5ACqMteZwI7hbrm1Tp7QDZq/+QZSDR5X0Yrr+iVP/Nvd3vatnzsZ/oYT9gIQsQiunBQdDk0IAbuWDYLPUqdODmFnP13GLL1EdWp2pJ/WfkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z3Uqm+vN4/P0fBODF50hXyX5UjEaIGRHdZsJTHd78I=;
 b=fxq4JImGCFI1t9i8qGdgaQ1q9+TcgT5B5VeZa2PVZ+JG0uQ82dqOt2YcV9+uS4uO+xXNSqezZitM30SPTZF7TWoW0d/aqUHnqdH285dWUFqMIk04CIwYpbuWA9KtG3oWYl2/mYnYu/ger0sRAX+hV/b4h6kGQDQlAXc+tDQlesa3ryH0N1SYCg/uqFKoWx2u7E08Jt+nN5Y6wAv94tDMozdm6YSFdr1EJQSkjloorjszl2gHeTCgGC/KLlZ22v76kNz529oaXT06Mdl/6H0qUu4HIZjRhhgdTKwRXscbWMIsCnE6izdTStv+TXmmXEAf9VqTL5ha8vjOCv0lW8XbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z3Uqm+vN4/P0fBODF50hXyX5UjEaIGRHdZsJTHd78I=;
 b=LoQKFDoJl4Mb7SV9OoNOWB22KIh3mPWV+mkKeONSKwmh1wgFPcONPMoYhLHh7x2wHyw/EQbUpOOZeRUYmK3N1Lodc22LxYgJhWZjMrLuqWfItvF69CcD7ODf5hHgLzeA3H8vCCeIiyu5lhliQOwxuBCPSmAdAwsftG6uMLSMa9+hpGFBW0u+xtxo+yVCYLCvxZHoWdYosIxwdRc4Ej4n6BlF4VdNy9pat8q/AwFGvU9xl0kP/YLHGhUAwKTMncnhwLkBZkOrPH5k0ZsmxI1r3aEixyXNa7wosVWEcgYmkvszq+A13NIlF3ejgLc4XvjyWL/guk/0XdZvSKZz0peJ2w==
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 14:28:10 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::b8) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:28:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:27:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:27:56 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:48 -0800
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
Subject: [PATCH v8 4/7] cpufreq: CPPC: Update cached perf_ctrls on sysfs write
Date: Fri, 6 Feb 2026 19:56:55 +0530
Message-ID: <20260206142658.72583-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bc24e0-f5e9-4ee6-1405-08de658bf3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+TzAFamftdwmo/uq0fO3nJbbeJVgS8CsyFzuZ/gB3h8ljo07tP1pAawn34xo?=
 =?us-ascii?Q?KocJp8FtLZbT0W7+vchOVvZO618jBNxSsZc6wT571l8Nb2X6Tpgi2a6HO2Tz?=
 =?us-ascii?Q?ZxDbq1h4Nk/zig++coYqMrVuu9Bz3T+RMWBVtuEmu/h0HdA7agQS9z/+Fclj?=
 =?us-ascii?Q?hNs3ee97uT4RsfTPAPpmtLjiqnlCdgyCLvizow/muz94C9JBYwFMi+9kQRc/?=
 =?us-ascii?Q?s87tqEfHPvV/9TdMwtMguPpfUfQEjBkOYUYvDt5GsgiubY/0AyZSwBWN1JR1?=
 =?us-ascii?Q?uRAzqDXJRZSUOECbkSqOAKKns9zuqB79mjHVB7TODmSpowbOadap/AYh01Dv?=
 =?us-ascii?Q?iEMvwG1Dqkq53G3+BoM713Q+aZBg25KKnKB04YyUr5SAvrx1qDQpwenN+eVK?=
 =?us-ascii?Q?Z6zKfkar+OwDbeh7YrzQEy8VGl+T5SU3QmOLl5njBmrqJo6V6WZQlrkICC2M?=
 =?us-ascii?Q?REOObBy1LjZ3kxPCfRiSd1UUpdkOvnFQXTQxnroLh3l83B3rCyiYpEfe7ImD?=
 =?us-ascii?Q?puwo3IUm+mk76YmaR7fu5EEYRsYrJkuv/yUx+mz0HRybLhuyJdrfnV5yUNBm?=
 =?us-ascii?Q?1V2E379U6/9MwPmpcPlOhIdsXpRQMEKCymmHwI9IFBP+aTl6yunUBSswE2kb?=
 =?us-ascii?Q?lP3uws7BQ5UEqmi6qC80GIreSMNYljI+Ra0hO5e4zlcyuaw+J5/LZL1/bM1H?=
 =?us-ascii?Q?t+muYvHgydXL4wiJGqYoUhUQjz8ayO0GlmTfA1RiOyeyKljSCINplaEfc4N+?=
 =?us-ascii?Q?wgpw7mN1cqw8IPshnCUvl14+iSt2gdwS7pTMA1DP+gUr4JIeLwlOQnEyNbYF?=
 =?us-ascii?Q?fX/0Au56aGLF3IUvQzLtIqH0jFuMJ4h8wLxPIBDRxdvG1mtYUQloyrUYYqNB?=
 =?us-ascii?Q?dHsb8/l3/PNYVZ033QcPOddcIlzjBg0iTR/IsyCGy3+qdWroPng8uBnQHDFB?=
 =?us-ascii?Q?eK6JfseK2f5IXrxpq9wgKcAFdEGjC8Evd7HVkOtCnt7xkBwamD8VRivJ97Tr?=
 =?us-ascii?Q?8VHxkE64MP1KEWVOOkRznCDShqsb1PNBz4JDVqlx7/g++6q3Xlu4pSAsOqOP?=
 =?us-ascii?Q?4I1ei6cYaBKIYYlMwi0lnSL6euqSGu1zW9VzAwLC+FetFtfA4WogKBZZQFK5?=
 =?us-ascii?Q?/uQUyLHWUgtL7XK1Pvxlw9J3e3C+9nk0yQbhCV8zeg64z3UXSqDCoa8wfpWn?=
 =?us-ascii?Q?Ge04ii+/bNUhq0ZEJJ6+5IuiY6nQUH6IWybDaNUR5LZxumfeAgBYB4NNGd3l?=
 =?us-ascii?Q?BCf/l8x13mgsWx+mP8BeF5gQZaNwglQouEaxhTClRUJ6rmp6VDKTA2lV6qv2?=
 =?us-ascii?Q?inyO+wXJUA0Ftn4W+gXFAAzXXUPM0a50i0flDY1XBUjbCzOUnLSdii1VVkeA?=
 =?us-ascii?Q?QXzyaedwDYheO34uDxGY/BFZLv4PYw3fXPneXrvEukz0lmI8V20KxFf60dUC?=
 =?us-ascii?Q?B2m7/2SkjFLl/h32jlXcguZCM3ySxLSz2blx3MuPp0POcAsHEe7iBf3RgmkH?=
 =?us-ascii?Q?n8YJGwO21Ox+sS2Ig3h1yddyt13oBNLvaMC5caQSwJRKXTvoJxO/l4uygWxk?=
 =?us-ascii?Q?kTHIobRPHSUPjhzDyeRvZhDQlXoFYqiPqi8kRoCYgp4P4DCJxzob9fnwu4SB?=
 =?us-ascii?Q?5b3VLQd/85m4YXaT3DEhjbLkGlNvFmYj4VtlhOuHNDaZPPfvjClmOiGKRr6e?=
 =?us-ascii?Q?hnkRWR1HMj+NbY1SkB/l5DdWWAo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x9THlIwcMlOu3B+Rbv0s0LyvlaNv8BfvOcBBxz/FsBk7un+aM4bbSFjmY6oIdw4d3iFP9Mn9KajE49kfYY7WA2gfiul2C6411WpBCm+KTYtOfGhSEB2CNjaNd88rFEfe7qX88bPjv06qA++dEqIkqiS4kkYgqDi6K11uN5xcW61ptFuM0QnU6dxcWwlmkVEd/cpqH1OWdUL/lgEphepgVapuCYFbMo8uAkUUWBdLmDhjFd6eSqO9NGkA4nS1vPOz3hdhRQpw+4Ur6atjLdyG3qFEbPA0cDPFLLHg7OHd6/E/rP6Apctz6e1PFeqRG5TqrQjZbF9Q5wczWdm8y3qrlwfr++v83JuuquTJ5XnPt02vO2amWUt1VtVS1CEzPgrwEbAGAGEhOzersHCjrG+f2aAfo7B28LN6FQ0FkE/ITJNCPT4e/QbHumwch/6ZFPCd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:28:09.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bc24e0-f5e9-4ee6-1405-08de658bf3d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20884-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B38F8FEF06
X-Rspamd-Action: no action

Update the cached perf_ctrls values when writing via sysfs to keep
them in sync with hardware registers:
- store_auto_select(): update perf_ctrls.auto_sel
- store_energy_performance_preference_val(): update perf_ctrls.energy_perf

This ensures consistent cached values after sysfs writes, which
complements the cppc_get_perf() initialization during policy setup.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1421f30e87e4..e394cdac7f87 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -855,6 +855,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	bool val;
 	int ret;
 
@@ -866,6 +867,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	cpu_data->perf_ctrls.auto_sel = val;
+
 	return count;
 }
 
@@ -916,8 +919,32 @@ static ssize_t store_##_name(struct cpufreq_policy *policy,		\
 CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
 			 cppc_set_auto_act_window)
 
-CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
-			 cppc_get_epp_perf, cppc_set_epp)
+static ssize_t
+show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
+{
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
+}
+
+static ssize_t
+store_energy_performance_preference_val(struct cpufreq_policy *policy,
+					const char *buf, size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_epp(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	cpu_data->perf_ctrls.energy_perf = val;
+
+	return count;
+}
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
-- 
2.34.1


