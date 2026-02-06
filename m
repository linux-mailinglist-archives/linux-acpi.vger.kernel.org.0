Return-Path: <linux-acpi+bounces-20887-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBhyAzr8hWmzIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20887-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:35:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDAFF09B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 518193046F8D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3A421888;
	Fri,  6 Feb 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EEa46VYt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007741C2F9;
	Fri,  6 Feb 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388131; cv=fail; b=sCnmDFd4zthnLJWG9aTLm59l61K2QK+6fIrWzP5EygHukurwOPk2RBoHN/BaR28knmRGHxp0i0ZSivcpi37WcPab40tXxc23fR8Wmw72x1mZ3aKKxulcT5obYWIRcrKEQ2RkjmOya/4LeZEIFRr1/j5hhpyQq7sXYDw3Bcf4x3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388131; c=relaxed/simple;
	bh=WoFEsz8qAarwMMNeP1B3gn7PRI97qF66i8DKREJfwfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAXhBuKwJheo8WZuUkOl8o5QUzhsEoi0bT085s2pnvI6f0Vw3jRNX15p5Hx1sZsVNBV7dxNfrtpqNjpk/xo0oX3OZOQYvHLsJkWma/v43j79g5H9cNLSqnu3lAclBP2NXbRNMwRdUcSj1OT+gcM3EzPwuvk7Y60183HW9C11y2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EEa46VYt; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn3qtEj7qs/GSCT8giq7OKcqZfPBD06XHZli1nSAIAN1xRliWNgm9gH8WbiAxMe0eqKlEhmC264NBWOUCS5GHo0RsugCStKOFT0uWvkWu75yoxqI32VZ6goJMWXDzen47WhmifO0ZCvk0BjScuZYG2PHqZumkx10RwIpIJfIwT+bk3fjDAJnAPqU89PpOfWY3hHMBaQDaYiulJki9aXY+Dl14nU4ZMS5pf97ggq1GG1BGmaJbpwgJ7YhOE2Qc0AqrFRyR/M32gec8OYZJZNuC1o7VbxSjB+jU665WPRR/9NvYCIgHZWo7FzhLWLDTPOeztP1y69xUgYLlr/KDDCH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD12oTLV7Uzmr02nBbZuUPyEIB/YGtF1Y6Vg8oLsyQw=;
 b=Y0fFuhwiSVrp1PvB9ShH+K2pMX1Hgy9qa5648maD1arJOMykNl7frqCZ0VstfSbgD5d+oM7WUBCByHLmVtlDx9onhq4C/EkA5F0MLoH7zhMxVEfkfKWADKPSfz/+JrTnoOP9RDdKhe08WwUYSoqCR+0bdmDSukGPIDRwnTim2GjApKIZ0m9BxsaV6JiaVygFxkiT71vYCNHvL6jhFTluVYxR6tVdoJbiUc2J5cY0UysPR/1Rbtzh43VzYPADffVpmyDSTQRFLPQGV9VxiRZyNYy4b5LdxW18Szh2Ks5jDk6VOH1UXccyV6sEFD19Mm8jqxS/5jvFJ0EakfCiboqRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD12oTLV7Uzmr02nBbZuUPyEIB/YGtF1Y6Vg8oLsyQw=;
 b=EEa46VYtnu4/tQ0KzFHCHXoEbgsKZTD+NdFNA6X9yvUbkVzecdFKZtuZZB0wPk2jy7LyYVgc8itxv4DPH/idY6zT8f1iSfCxbaUZ3z8W4dki3mn976BLlAuOM7qJY5J34nAuAKVRVH6eEOPrjBcXxHuXIcoMo0qD2vHOSMcGySayjFMtz08j2VjM7rMfHT0Jpck9JfWAWKiaH9wTVQsSwRtMlY3WMOfqE+UX7kzsnRwbNpbUoSjt+HXfIKndmQ0E9evsBjZ8o3nU6mtMXi7KTNf4P8q2CCNPI/eytNpEm6UaSHJPI8vYbJ4TY8UhVlrM0LAlX6lpiyoT45JtJs7X0Q==
Received: from PH7P220CA0174.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::21)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:28:47 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::91) by PH7P220CA0174.outlook.office365.com
 (2603:10b6:510:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:28:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:28:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:28:25 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:28:18 -0800
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
Subject: [PATCH v8 7/7] cpufreq: CPPC: Add sysfs documentation for perf_limited
Date: Fri, 6 Feb 2026 19:56:58 +0530
Message-ID: <20260206142658.72583-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 375623dc-06c9-4e0a-7e10-08de658c0a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqVuWevdpoIdINj3NKO3rVlKZvLjuUGi6/zlL+1qeQCvEufMdcq0VEPHqbFt?=
 =?us-ascii?Q?eVSInk4kGxvw61023e5yDHoKxgc3+MTqmsK0Ku2YwAVQODJ9kcFYiArdFgr1?=
 =?us-ascii?Q?/eO28tLoD6rYXOhA7qmABdwUEAPeXz5bHc92n9bcr6ckCGhwjq4krl38W3+n?=
 =?us-ascii?Q?xjuaV7ec34kHlVjoVENTqFGhHw5EIVLNAfZILtHoHRa9foARyITP5wvWhFFq?=
 =?us-ascii?Q?wxF8mePdpxzv35zTmBpdvUv2rN95QW8frzYamUa5H+AqxvT1wmb36xH3Y4ii?=
 =?us-ascii?Q?qm7msDKDHHLTtKXqex7e7sJrTecFTC6HiF7YpkXpKjhMxIZWGcYdvPE/WZet?=
 =?us-ascii?Q?1NJ3CLS5jO64vPLTv1WCKUKULJ2Thvj8LEB11AKOhMjomHH/+sqDswqyAkZ/?=
 =?us-ascii?Q?mPzAPyoM3Y9QOYsIsh2dBauqtglRnrmw+u0RvRli54q7kKYWHsRTKW9RSwlj?=
 =?us-ascii?Q?6rOS3OW0daNGR50HHvlGAuiYZ2IVxAbN7cx2lOZ+qfng5bMXfJNy3/uMiAdK?=
 =?us-ascii?Q?8oyeuEo8nOOtvm2Sx/UvVniRRHu7RySzX7X7cpmeJF/9gDMCXUukzQX2RZ3h?=
 =?us-ascii?Q?36wETl2/neTF3qQJINElbo1w72Ankeo07+Z5Z2Ew1yU88rrfXjF5RebPa74v?=
 =?us-ascii?Q?AnKEHYgql04a833BYLdtNrk04oU7Lz/nhUAllbg7Mre/KbxlqbgzzuKz9Qvd?=
 =?us-ascii?Q?5my5fjNYMc0XTAgusPsd0Z3PuMaHpN5Vm7iRVNtAr4qjGzPqVGQXzm4OfJ2V?=
 =?us-ascii?Q?eP+5aHsg3O2MQbZsNA6tF/HurejBdOG3x98mCfgA5Wx7ET/QNHeeC45/YwNJ?=
 =?us-ascii?Q?pzNWa5HmOwNtmCywutbxN5wAkO3zVrnaqGNgkMiIADtURZR/DO4xbeM/PePw?=
 =?us-ascii?Q?fPtWkK5CzwDrynZvmjkgpcWRY9gLTTjqjYtaRo/yG99NLUHkxacCsQxEDPNw?=
 =?us-ascii?Q?tWIeNoJJFP8hbYiq09R2bEVy5N2gvs7CIwVY6UpdGfBQ8wQCgLApOmHpAtsI?=
 =?us-ascii?Q?+YnV2eZocbFlr32AXHbfT5hhdJYng3V3HzpXD5TYO73ILnGmfmghrPia6B6F?=
 =?us-ascii?Q?Dqv2zyOONWFmLghJLki1awLSSCsbe4B6hMtBS39oFa2CwstKazC8Bxl35zuw?=
 =?us-ascii?Q?BD8d+7PStVr5TktuTR8cNveD2KOj6Z4V7Rtb7LLmYaMVG5gAsd9Q6g+SYhvx?=
 =?us-ascii?Q?Br7OXcPXnLLMoaWHbVOUBKLt3fto7Z80BCA1rG7BNkJb7AvetqYPt8cHAA5/?=
 =?us-ascii?Q?iRas/qVlChqpW/SH9P+1AEKQEfE+YWYs1M8kEB8i3B74k8rueJtiaxrpwLDw?=
 =?us-ascii?Q?+Ew5NU6S6teRykL7QXC/AC+mDvv0M16k2LXX0LpBaId/e34VG4aQan3/6p7t?=
 =?us-ascii?Q?IQvS4AIj6vr6Mg0jhCkwY9VNxaislHjT9ZDpvvUM2QkZkN5ccBow++PClrsg?=
 =?us-ascii?Q?c/0Upc/xTaHZ7wsk8a2NQZVlfYPdRqsPKtXMBkKkYBq3xPWFRZ95M4ITmHTW?=
 =?us-ascii?Q?KiC6L4Ikg9t+Sic56NwgLUVxQR5pcdAXjTDHAtZLfqAIO76wReXN0KtyGu/y?=
 =?us-ascii?Q?jQyv6tSdV8U3rdSy9fTnIAhGbMSf4wl3t4Cg31pJWcgvVa6NQVd9w/zwHgPE?=
 =?us-ascii?Q?FxlDOHBir4gDG8apzXqxYv9cSP3PcfJ1WxkvnD5wuma9zcXxJtqKBU+bS4EK?=
 =?us-ascii?Q?9n8um4d8AsvYe8O3NgFcHtUzwII=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	naJmgl0aykeq4Z02WHCUcb4uVmiz9fG9pbp20Kfds9yjjz2XYzo+wGSVEDzR6XxO+7IlZXJFhxnLlIOOEwMYJ6NLP8HV2lFUXYgIcpRS14a975eqiXXnIsVhDIu6ZFcZ5GeJtUZxONNrEYiQI2hxNV16w3ArPj55X45JSzJRO4dvtZYvIdmUdXVFWwrM9aXXwoe5DWT5Z0csyCDcu1dr6Nlm1ZZmya3boywPwC7BSw+lkfUoOg2vOkTof7iopc/2xUnoczMpk5EK8AOtaEvNWAvM18Jq9jXL8xhabbqqwbk/OqgpMTY7TnpZRrzMSiMTaag1UiadiXVhTgCkuPRRTNDYOpNuMRC6KR394xsdTQhPxxQJJOz8NsYtVtQZoynYRAjiyy5pXrm3jgoYi8saduC2lLCHgyrUH8P4iwIY8uCR7uyfWaCcUzS+do83gK1R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:28:47.2206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375623dc-06c9-4e0a-7e10-08de658c0a2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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
	TAGGED_FROM(0.00)[bounces-20887-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,infradead.org:email,huawei.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 27BDAFF09B
X-Rspamd-Action: no action

Add ABI documentation for the Performance Limited Register sysfs
interface in the cppc_cpufreq driver.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 .../ABI/testing/sysfs-devices-system-cpu       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 3a05604c21bf..82d10d556cc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,24 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Performance Limited
+
+		Read to check if platform throttling (thermal/power/current
+		limits) caused delivered performance to fall below the
+		requested level. A non-zero value indicates throttling occurred.
+
+		Write the bitmask of bits to clear:
+
+		  - 0x1 = clear bit 0 (desired performance excursion)
+		  - 0x2 = clear bit 1 (minimum performance excursion)
+		  - 0x3 = clear both bits
+
+		The platform sets these bits; OSPM can only clear them.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


