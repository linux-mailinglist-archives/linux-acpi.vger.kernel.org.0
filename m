Return-Path: <linux-acpi+bounces-20463-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPimIt2rb2mhEwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20463-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:22:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DC47641
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34B197ABD97
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97B47276D;
	Tue, 20 Jan 2026 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="grmVFXmx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299B4534BE;
	Tue, 20 Jan 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921082; cv=fail; b=aZ07/t17SThhk1C2kNxOeTRpMVnIhjDuSu5LouTCkFaW96baSlrb2GaYHVBnaZNqkusAAzof29LdKJXtsJ9JTqLLCabS293LYCbsd1rJN5FXsA0W+HXAzdqbf/emC3u6/MBRPHO/zNc5ZEVPkGUB9jl7hM3qHM+Q2l5Gf2hZ2p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921082; c=relaxed/simple;
	bh=RRGgukfzT+g8CQTSkmbSyLsYazH9DG9VaDzQx6AL+t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m85VFk0Q5jCOdWmJwwEt5tHJaHuvHFJ2n59dVqojn7FfLfTOjeJQgIpyxIXZmacptYAYN3AT+RjhUxMGZqNMCeJ2oCCDfaRI/XLCzdMxr+2Aw6uEGGp7vlpz1tvhGY9H6YB2hVmlQSyRHhgTPsDela8Bhq+gEk8bSMj6fF5WM7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grmVFXmx; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaVfTVhU+ERqywr1wqRP1B176LTVHiuMS8d1g2B0PWWEmiR8nJBsur4QsmwhEBs/ULg8+TiU3FyUGDi4RfoJT235WZTW0xWyMsC+Faov+L+eWXsldqnsLJYBIkfmvs8bOVFVOcA/h7sXOSOzVt8/YS5j71qd4UqAqagsAU59NvirMwjsHa0i8bxfN8K78BhzztrumTFc7ipzqqn9vYOieyzC5n6fLPYEXP13p+r/CMeAe+tJiM8HwNGQ/hGaYBaPDPwyZbF392fTtfqM8GtFxCxqDUWazZADS6enRg85WJUtE1NTlKc5jV8GiY+oBAQQ3v8f4PzRMvqMf7NJJyWg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGbeU+NCJVGDq303lKThgcrjqEaeOgw+rnkdl/1Z8JM=;
 b=NBonIHkfw7SsJaBo178cod9jev1oLztEuYsTo5ptpBWwrXfrv1eBMFSTVQxYwtk+W1KKa+qTeF6UusAntorysZCVoauScoSNVE9t/F+lNrWKWW8FucQ0e26JwTJTdiP9L81xTDH8UZbPTEGj0kC0GEbo6kQtyBA7DYvlfvW/Fa+flL9QyTGKLC/cElqYUZR6E8R1vB0c+P8L6jx0eYZr4nzevkVbWWaLv018H/9Cv2afzzRFU6pgiVnG/HmkfP4v1zU18wAqmvok+fc1o+ijJZvlP+3OEqU+EpX+0VcC+oiUTxvpQwwtf7lqNqHgkTFy6f5ScTeQV7PsM1lflU/L5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGbeU+NCJVGDq303lKThgcrjqEaeOgw+rnkdl/1Z8JM=;
 b=grmVFXmxme1bpD+eUcZhGIsfcP1DqsJPUOzN2HyBOe1TgfUl9rnbo3u2bOOAIDW7+elST0QefCQlUjhMuDhkNTq5GR93fFv28s0OvrDh72tqqnEtDMqarLj4mw5fU7e1cAPbpTrQe5URW/xEsI5qRXCAKYbLj0feuCOIobXI3+j3uVzZG5NIWESOU3K/Sn9rzJiVVQq8iP23O9Lm5x1iBHeqapB4yH+nZb/qgQt0XKl56KZ1sR0uKuxCmchMYvTwFEY5NrGME6f7T5DwFQ5yYwGJ8qZir5FV66QyS2lEqjSSBOie84DVrbgAxlPNjNO0Yh7Cuz5s2pd5JUtGOA3gRw==
Received: from CY8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::20)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 14:57:50 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::94) by CY8P220CA0030.outlook.office365.com
 (2603:10b6:930:47::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:57:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:29 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:57:21 -0800
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
Subject: [PATCH v6 5/9] ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
Date: Tue, 20 Jan 2026 20:26:19 +0530
Message-ID: <20260120145623.2959636-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: a0321ad1-55a7-41d3-d8ae-08de583447f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwrv/7cr9+voZFWx86BzZ3MvKWEnUl0TFPP+5Sz9T/ZXEmzrn6A3RejYVCaC?=
 =?us-ascii?Q?TW3PVDzp7SIyomNKujOaFo9SiGgyoGYs/2Me8V92NGs4dQzAfzK5Nqk84f66?=
 =?us-ascii?Q?XDh5/tshXIq+Ld9O6lQLUVijX6qtgqHXRT0f1d87jzNMbPKVn98O18FVpkAY?=
 =?us-ascii?Q?REqyFtyNr1PYS6hPOWB7xcVPjOxDycUr/3qPeoagrXKePak5RFcKOIJzjcej?=
 =?us-ascii?Q?UkPWM3wJZNOI5ih4ri0lKshU9P8PDigeXTEvBpIvaT/Ck6JV3ENFlAc47xOo?=
 =?us-ascii?Q?Kc9ZyHeYdQec4tYaDcb2YgzKxnk6RKEHicIhe6t0dYq9CtkR6FHuVk6B4A8A?=
 =?us-ascii?Q?WBTJ/iq5qKl3PuXfzP5O2EaKCoMcXUIW3KmuE+2koFC8OnJ3apWE+LHJj3Jw?=
 =?us-ascii?Q?LYNH8IQqx81gm0J6Oazu6ZfXpTCA8gt8w8C48/QEJDwgzw8zoICvy4/Nb1zU?=
 =?us-ascii?Q?oj6us5n53t+L2PVIV+VC+PiK5kiRMtvidYC1WbdiP6HX0rVTzJbDUuOs+fCN?=
 =?us-ascii?Q?BWC6DzH5id1jJOyvOq6me1FlFpUU8/QFWalXQc8EdZO+Y8tABv9JmB7d8hzu?=
 =?us-ascii?Q?N6vbo3K8FGBRB5xeXh19q76d99/muX+G/nfI/EfwEIHG/+zJeurmuQinRhIy?=
 =?us-ascii?Q?8z/26svsq97g7CQ3nxKIn/9CT/QPx+FdAoXlZK999TJBtYp4hnEc3LdJ3EZq?=
 =?us-ascii?Q?kkzte3xlDAFGTUjhT+i2VYoAB4rwIkYYgzBjeuqUEDvRSI6cZWZKHsffnrTw?=
 =?us-ascii?Q?OTMS/9kvO2hXnq9439e8u+/zE6+WcjMN2oLUWRwmPoX2jASUyPvZmDCsgOBC?=
 =?us-ascii?Q?l9iTt6InY8krM4PMMjy2iVE9gcajaaSNApiGYeyeXYK7L+kH7lRIMJgp4479?=
 =?us-ascii?Q?0jrSOkJTI/XUWTCzhhbuzOPBVzEXdDt7oTat5kDspD3DUjtdefgnNljJ9ETX?=
 =?us-ascii?Q?8lE4UX9uXq8/Wug9kWlAvD5ydc4fPJy5B7Y9CqnXNrfKNtsg7w9iI0twPQ71?=
 =?us-ascii?Q?NcjDzzExYx4lMmVHg9b/wAtVAdla/gc8yaxY6rECWC9STbd/w7Ra+8Ij+ClB?=
 =?us-ascii?Q?nhX0akJAi40CjmSO/3thhr2orw9Y9eSJKFvDigv0iCc3sbCHQCFQ3EGpg9Lm?=
 =?us-ascii?Q?753ZzvjxJNlCgOoXBLewZhGBWRUGmEQNoQ1emOlixhlSPhajST3OlDoHKsin?=
 =?us-ascii?Q?sI27vvMhLhg8OxpIWf6JFOq+o3OUgasBfs+yOy/jfmde7vNfcR2IYAH4o2dg?=
 =?us-ascii?Q?e9vdrN2AENulzH1sEZhE4iZsSb5Lv0GWXHq4IxF60MD1q0BWj8iBc/9JG3Zf?=
 =?us-ascii?Q?O9wokdD8Nl5G7Pv5v4WsGzBNpJ+y+F+Bfrjn8lGJ+2kv+gliJGiyJ7OOKSxH?=
 =?us-ascii?Q?8ZRnYWKE+/oz/gYNUmX/fywvBKGUQNN/HsiInUGlKiXo58wof6oVkfqEWZqo?=
 =?us-ascii?Q?hL32HQbUjVXyEXMmslYQe0gsyV1O1ucP0YSo6ZMPD2TRdEMvMkmU+m1EIqEg?=
 =?us-ascii?Q?Je7oXX4PBFkQnri4sZQ93Uve8RXl2TW7UQ+zg93s7zhv90rZ8riSLTiHTTHc?=
 =?us-ascii?Q?DDYv1c4+NPrJCu/ranYwW5mYDYLGANCf2KFoWUWMxT74CiugThJPt5VWNNds?=
 =?us-ascii?Q?/9PHV2m4SMImymNS17AS2lRt19GPjrK4UuXuHSFXMbpZeSUeALO6ahcs9jgs?=
 =?us-ascii?Q?TfoL/y7nilDUNV11iFyYjH0ieAs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:50.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0321ad1-55a7-41d3-d8ae-08de583447f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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
	TAGGED_FROM(0.00)[bounces-20463-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 365DC47641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
registers when they are in FFH or SystemMemory address space.

This keeps the behavior consistent with PCC case where both registers
are already updated together, but was missing for FFH/SystemMemory.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index de35aeb07833..45c6bd6ec24b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1562,6 +1562,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool autosel_ffh_sysmem;
+	bool epp_ffh_sysmem;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1572,6 +1574,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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
@@ -1597,11 +1604,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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


