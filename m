Return-Path: <linux-acpi+bounces-20461-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOZOK7qob2kZEwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20461-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:09:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93A471F2
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE47C9A6760
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24F45091A;
	Tue, 20 Jan 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBBd6B28"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9643D508;
	Tue, 20 Jan 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921060; cv=fail; b=aLjVuQxa6yGHqHmQSSZkPso16HOhXCAjiU1isUjog6C2MUACHrbQNeEZs27SFPl33qfbKohy1bKDgaZ7D8eVdO/lA7Yl3IA3wr91J9zirwPem7eft01kaHUBWufrbVMB3UaWgEuN5ZzIQMcFbZU1CTdbuk86NHdBn2t2r6dwjmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921060; c=relaxed/simple;
	bh=kKjbc5/rEuJMeSfosQtYRLd3tmYKTfO/Gcv2wOLRCxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y58IXlubW8aPzADRcMTTKC6V3GA6UYzkxgsPakibtmEQrZx7nAr1lxXvM5VQDORSw+yiXVidtCz2kEcQCfH9KXuSGY1gi4CCdrDRDHjSfwSAxNrH/g/woLaleExgaNErMr3K3XBeVqj3N51FVKqZJQU2ch4QWbzYy/ZJp+ipSsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBBd6B28; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opUQIXpv5OGe6XMaMsCLbr7MnxbtVdaio0D1K9qElFGLa8oBhIU+kH3SjVnhjbPyyA9z7+ChL/PgPwd426homHOTYPMPRYPMPFDLS13bodYSBeIguICOtmlND/r9bSgbYrYnxE4L2n8X/yKrR3VX5yFBjQ/M1TgTnXn2WEZ7JKJZx1wYuUv1rz3XplyzW5EZE1GzTM4KIF/5GmokJb0XBiHEw3ke8fzXJd/EwD2RU7zD35pxQfHtvUyz1POHdvbAtlrPcPSROr4a4kLCfbOpjkC5szrr6yLqpf3lwPCrg4u8dUkXeZOlOHBzOrIJQrB/3I5gu1stxtLv9eY0JsXFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sY7+EyWP4u7/WVg4gh0uyyfK6MwU23e/Z4gzdc7Mg=;
 b=BtZbts/XeNuWV2OFbSMw4R5VoVdzbrX8TIFl72EzXuzpMOKoYE18eyqcUOuEIYMUnBtHKDCIH3/i6hVE1G+7LqtK519mE1krHOJ8+nANYt70MHOOrlPyrktnEOHuWddK2gGmItjlDzfe7R6PemtMdPj51GU8pqVPVFxBQU6jwDjL4FJgiaHzu2vsZH3pZjDj/1y4EXHjUwYhzox6Lz8lqdgFzMI2QKeo03WUX8jz5SWO5t8c0UTBnKU1nyXUrgdaqoYVhuqJUslV5Pk+jEO2A5pe0X+oIu4NCZqp8WjlbigjagxSjXAbaEX0BDikIpjGOXdyk4PipKmlHZlaAcVwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sY7+EyWP4u7/WVg4gh0uyyfK6MwU23e/Z4gzdc7Mg=;
 b=ZBBd6B28Cg1O/jXUg/XrEpyZD8kOfNK8le1A5s77zJAMdLzRdQcqPW/rPuV5cAjrTAnEXWMpEA2i8uuO3CEGYhnKB3Gp/PIKLFOuNwUsFhijMMfe9K1nD2qPYvdl4xi8P1MGdJNDn4R6cu/I1NaGVpfHKU6bNC8VFQcqsFJNCY3BwcL49JejdkIac+BUKZ3DKUWpjlX1g1BEu90o+KBaRcvlcsUCY/xI+04szJNSeRKRVgVEJ9QjkFiK3fRkGrB1XQXPJJJLrXsxITp0fV04zFuMkvOe4NX/m0JVO/lk2NMlDQTqfMdRtXq190sCxycAi8WgdIs0WMBCpCiA0Obe8w==
Received: from CH0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:610:74::29)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 14:57:32 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::da) by CH0PR04CA0084.outlook.office365.com
 (2603:10b6:610:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 20 Jan 2026 14:57:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:20 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:19 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:57:12 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Tue, 20 Jan 2026 20:26:18 +0530
Message-ID: <20260120145623.2959636-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120145623.2959636-1-sumitg@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: da2754a1-3adc-48c6-62ba-08de58343cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M6+ZoEFv5B7kSFeVRY2gJUTWJhp1Tq/Na0x5tMzKnAmb7lxHocc7r/VVO8jo?=
 =?us-ascii?Q?EhNnrSqvSJExo2VAl/J63wTbFriF5op4ukjM4mAgy1tRArOPMW8+tyl4Mr/h?=
 =?us-ascii?Q?vw6BUSdPUpZ68vrISeX9uHrnXoyWEX0RLIVY/1kGfi4Zco8xHJRsdHzWuGqA?=
 =?us-ascii?Q?9dVFJ/DJ76700zvnPYI5HSuU5eNdOKDdUBIufhB32skNsST34RSBrxDr8FVH?=
 =?us-ascii?Q?OwgaCyavL/B1NDTXC6kF/apuv2eRig2MmVeuf7UoDhnEi8cFZMMM8Ov/KULm?=
 =?us-ascii?Q?NcmFLyJ1favsMaF0PD1cEhu+oyPnwhx/+NUDMdx6OI6DMh97PXVCJswgbU8a?=
 =?us-ascii?Q?JpW6vIderq30Mo6qvZMZjVFz6gmCsg0EXcDlku11jBe82ASNuTHMi79y80ph?=
 =?us-ascii?Q?BwUQDdO23H1ytGMtz61Qb94L0G1S+m4pGRd1KqBsJdA0FgDFF2sZNhYIN+QN?=
 =?us-ascii?Q?Lij2110vQwx3sT8tlMVoQqDhEY9WONHwIKfgnJU9dby+NpF87xKE8bm5iS6S?=
 =?us-ascii?Q?Wx0CUYZA4NbExndv8aQi1jTWlxzWxpckR7XndpIcP61/wp3Bqu4QirYUPAPR?=
 =?us-ascii?Q?+oIsFDgp34KIaKQcQSHJzN9954vuiUNIV7Uq92VlCgWpPcHeO1/eQr+ht1vE?=
 =?us-ascii?Q?hsCHbXMV7CUmieh9JytYaw6zfzaHtmglCmYpv7lpXFCBLS0/FsERUg/zKeT5?=
 =?us-ascii?Q?qBVWq7i+G+7VKYnLsXiAxBKvmGQeyEU6Lah65dHOqsTr5xHYmNexxG3L/ZON?=
 =?us-ascii?Q?3VbEVIrOhm3doRhO7dYXgH+8SH67+qZ0NYq0t51a5LRgb8tw8BuoCGJOmTma?=
 =?us-ascii?Q?UYT850cmpGpuodSXh56dt7osL31PmI7RayRjCfBFQzuGIFhwuQ+sSFbtBaUd?=
 =?us-ascii?Q?tALYNxS55qyck6pFjSHY8W8Ba/MiWwhUN/jA9ISY2p60HT94ftpQmIyyNwKF?=
 =?us-ascii?Q?mYiSgbDsZdYR/+iTdg1DUY9HLnalUFYO9YKrLJhoVwlr6hNpwKToKhHVfUB+?=
 =?us-ascii?Q?25uMsihWlJGCaIH72qioFYXl5fYsgGxYOEHWchA+NFITiGVb/ZjnbYMHhe5k?=
 =?us-ascii?Q?LXAJ7CQUiyOqzne/QNrcTpIaLxAUV6ChfMhxScBRXVZrDxazsc9Dp5eiOJ2r?=
 =?us-ascii?Q?ZJqughOortQt2oXqHvSh9F/WLYPMOhMiGaVzUmr1eHOszu5i0OwMxVSbFbNr?=
 =?us-ascii?Q?DQv8NsqUzn32PRjCtADAZ3S7kgB6/VdKgEH5O/rY2aLYLwQjRfJ4pRa5tKcm?=
 =?us-ascii?Q?cymdPDu87Iz5APkYJYVeyPF3yoKhnHp/CpYCCBDvl7AONz8uOSgrgQfVZexj?=
 =?us-ascii?Q?+jsaEA/as8VeMohcwAz+y3V1TqypG69FHXHud4wBLlSu7pcDt9Mh9Y9jRn0x?=
 =?us-ascii?Q?Ef37gL1OJDOD18ojviZsjti/PEF9VL6v1EVenYduy92uUwL2U6Livx1Ors/T?=
 =?us-ascii?Q?1Hzw1tBv1XsIcE0XKT3QLrR37tV2q5c0G2tKBWmfcXPWY/h66qQW9739Crn4?=
 =?us-ascii?Q?O0+i4+ULbdBbmDYb9SQd4EeQXv9zq2N2dAxBt8Z0y598y1cq5Lxj1/3dCFIF?=
 =?us-ascii?Q?OKkE23LWxFplMSYXabq1McUVAgCEvDeaTX1CBYrn82chaut0C+zh013rxxZT?=
 =?us-ascii?Q?d+O1qvap/mZh73M65X37mt8wO3hyF9M05FZ7DBzB+qv4Kro6JSzwRm9pbIe5?=
 =?us-ascii?Q?rOqNlHep1vkD2PVSPuOQglkNIaU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:31.5638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2754a1-3adc-48c6-62ba-08de58343cf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20461-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1E93A471F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add cppc_get_perf() function to read values of performance control
registers including desired_perf, min_perf, max_perf, energy_perf,
and auto_sel.

This provides a read interface to complement the existing
cppc_set_perf() write interface for performance control registers.

Note that auto_sel is read by cppc_get_perf() but not written by
cppc_set_perf() to avoid unintended mode changes during performance
updates. It can be updated with existing dedicated cppc_set_auto_sel()
API.

Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
perf_ctrls with current hardware register values during cpufreq
policy initialization.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 80 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  6 +++
 include/acpi/cppc_acpi.h       |  5 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a09bdabaa804..de35aeb07833 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
 
+/**
+ * cppc_get_perf - Get a CPU's performance controls.
+ * @cpu: CPU for which to get performance controls.
+ * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ *
+ * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
+ */
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_perf_reg,
+				     *min_perf_reg, *max_perf_reg,
+				     *energy_perf_reg, *auto_sel_reg;
+	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = 0, regs_in_pcc = 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	if (!perf_ctrls) {
+		pr_debug("Invalid perf_ctrls pointer\n");
+		return -EINVAL;
+	}
+
+	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	/* Are any of the regs PCC ?*/
+	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
+	    CPC_IN_PCC(auto_sel_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		regs_in_pcc = 1;
+		down_write(&pcc_ss_data->pcc_lock);
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* Read optional elements if present */
+	if (CPC_SUPPORTED(max_perf_reg))
+		cpc_read(cpu, max_perf_reg, &max);
+	perf_ctrls->max_perf = max;
+
+	if (CPC_SUPPORTED(min_perf_reg))
+		cpc_read(cpu, min_perf_reg, &min);
+	perf_ctrls->min_perf = min;
+
+	if (CPC_SUPPORTED(desired_perf_reg))
+		cpc_read(cpu, desired_perf_reg, &desired_perf);
+	perf_ctrls->desired_perf = desired_perf;
+
+	if (CPC_SUPPORTED(energy_perf_reg))
+		cpc_read(cpu, energy_perf_reg, &energy_perf);
+	perf_ctrls->energy_perf = energy_perf;
+
+	if (CPC_SUPPORTED(auto_sel_reg))
+		cpc_read(cpu, auto_sel_reg, &auto_sel);
+	perf_ctrls->auto_sel = (bool)auto_sel;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c95dcd7719c3..229880c4eedb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -594,6 +594,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	return cpu_data;
 
 free_mask:
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4d644f03098e..3fc796c0d902 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
@@ -193,6 +194,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1


