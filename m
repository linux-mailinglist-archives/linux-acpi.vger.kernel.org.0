Return-Path: <linux-acpi+bounces-20462-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B2EGvDBb2lsMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20462-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:57:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF048F39
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 643DA70A055
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D9451073;
	Tue, 20 Jan 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1BQxbdt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6943D508;
	Tue, 20 Jan 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921069; cv=fail; b=V9s13Tfd8rTX7NAswZV5yvY5Eki/4DFdO8ALG3y5XkGLj0bHLa6O+adGYBkImR3VsK2X9vwRQ9uTTZ4JpOr6Ffie46ubXrXa3OemQ6vjWzi9TvFtqs3DzzG3mRNOjhUsfcbeQSZK4BHZYszUe+xrP4BcRElsE7NzzqvretIVzQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921069; c=relaxed/simple;
	bh=Oyr5nTeXvDtFwNO2jJxL7eDPD3VNp54NFy9+gs1EmCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phaiACVskfgR+1eQREW30zX8TtnrvMO9QObz7GzXg0Sm/GZIhp6McU+g7yk0H0/cQpFHV1Linrk/1YGFUZaG3mlm7aN4SVEhfaNBs+RLtzCowJ3ydsBXB3iGk10rTb6pk0fxv5h0rH7/sq8L/1yrGM+pEKO+EfvAvQFkC3Mw8Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1BQxbdt; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qysXFOqdZZ6FoplCK2/55HJZv2rMqk6+W8opEd2/W+pSVvzySD5A7FM7VN+XdWEfDStf4qSDPCP9BsQTKqY3qR+0nk2c88bbTPypIfzZ3tFR+Eo950Q4WDBAfurZOxoCsP/A7ZTCFGNKsXBa/LdLLGingp9ehGZaEtsBzEuqVqiy34XwX66fyolVw1uT9ZcdH6rMnHajVcMNCvmKyCAqSgFGJj9PhtQMti7coJCN1lDTw1dQdpQmMVBnXVpJaiN29NFihGI6GPoV9XrKfcpvG58pC4pYE05R5LJpIMOY1mGXhtdCSDCJvA1/FSN9IQtnwcxcm9jPH6sNNi4jZsY0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LLasmfYyGLSQNaXp+kr63Q3O1ugmiEhMvrUDzgjk5M=;
 b=X6M/TQI1Ue8ASfw9iniAZFiwMyz8K7B/rKyuHe3mhjJTTwQj3gqZzhVpjUHJy/zq6SZm1hnsyi8+0xE0aA4XgBs0xNxMdSbtK2u5UuPokrFQkXhUhLxvuwJnlFzFhAvcG4G/FREkvydvcdqEhfpgu7gOO27imhELKyfm7dzfWCP3OR820/5pc8am43O4AaJ2sQG0fk1Xz+6hJs5K1hTbdJzYND94cfp84unhFvuvE4jIuJMKtaMq42ECVoa1KLvFNoIv6b7yunl9ilpiLjANlGzM5+12apQxn6YneENToLwWkmCIeoxFX+sFD6VeudjuqNSUaimOlCHzv3e1qZRoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LLasmfYyGLSQNaXp+kr63Q3O1ugmiEhMvrUDzgjk5M=;
 b=s1BQxbdtYjQfp4E/bQ3cbvVtyrzpGpbS7dbZuAVmqqEj/51AsUykw/GwQzgjlMlkrAIrApQ1EvEvSmpvdrsY5A0selb0meYIC69PqXHihx/LRXY6NjJ3OxgOvY/e+7NtcZW+S9XKNUpY2srdeMMiAJiRA9Gr2Hrs4ipwFsscgx8D/SpvUFCcAulo0EnGPQU0mxT8G3DbSg/4K4sI64AHAuJszqoDS/AVkGzBzgmhA/ObkEibKgU/VxyQnb0J0upFD1Lv9VPLqQKdshjb2vd3z9MYVXNSiXi4psMwCkO7f62KqU8uY8FUad/7j18EBx/9evrqjzQ3syju506XO4avAw==
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:57:37 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::f4) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:57:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:57:09 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:57:02 -0800
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
Subject: [PATCH v6 3/9] ACPI: CPPC: Rename EPP constants for clarity
Date: Tue, 20 Jan 2026 20:26:17 +0530
Message-ID: <20260120145623.2959636-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b86da8a-cc99-48d7-e2fd-08de58343e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EyWMC/sCUKovGUtTcO4VPQB8ITX+Nr8baAHcdmaVVi4rh/PzP3hzct1i2VFm?=
 =?us-ascii?Q?NuTKy8lIYhbxE3+asMBBv1A8IVh9HwCIsOzVRm75SbcbERyqpB2XEjQvNRlN?=
 =?us-ascii?Q?tmuOMTFQ5m2WjkcUFDvlMQ4UX77Sfv29Kl18q+qq/7J44sJ+MeI4b+6+c7/G?=
 =?us-ascii?Q?B6iP0quVbr4z/sIWyOouSRaBfL/x5OJsGmnBgAUGS9Hj3c7JpptjHvE3kK77?=
 =?us-ascii?Q?szFVDEAzzyDT66Us6OO+u7xv0zknyWVjKfrPbugiwoO+OKpPpFl0d83vaEUm?=
 =?us-ascii?Q?8jGYHl4oUNxswFGiOT2RHQ+JubZfRauTYAQTwcZ2uMJW4n3vDTXllHEforH3?=
 =?us-ascii?Q?lSX3Sx5sx7wua3ns/QLIf4s8pIeoGAX5XVwLJSvQBLLyUzOU9X1ADSECIArW?=
 =?us-ascii?Q?xW3kvRWVIwSJyB2DXD8T1jmhMr+mJ7Yk7gq3M6rl0jgMdqWHvAE4WA1TOF5v?=
 =?us-ascii?Q?MwLvQJeB4KKe7uyBeGOAkRGCvGtSyiczR89yadu8gXTSzpVwpEIc8fdy28Si?=
 =?us-ascii?Q?oTWJgg4cGNY0X6EKWSneHfyIL68JC/9Nn3FCimsCWhHWWYJfdeP0JBkxr+TS?=
 =?us-ascii?Q?LXZI35f81Jz8FwXwPWZHeCbwOXtu7kiArjvmqzQPVUAYPw8+OvEhL9DmPCNg?=
 =?us-ascii?Q?lSKQM29Re5fIj9v5+0G/SSsWJwwlwNqbo9j1vYcEUeb651ycybenWMeuNYox?=
 =?us-ascii?Q?xDJdkcOCa9c2IE5V3fyDHMhzqEe8tcEAPSigrh/jXERS+c52Ers5pjRmxEfo?=
 =?us-ascii?Q?qf5JK8SRYq9Vh6FKHYmb5eRKCX4c49G2IBDPfahPm36Jvsu9C8ZalCn6xpxe?=
 =?us-ascii?Q?SifVnxXx98Ti0+J3WaaTPt8Kz00jZ1fkNhXI6LoiSdkTR+1fYJ/NRhsu7Fxw?=
 =?us-ascii?Q?2GXNIXLEuIpGukeuxlccD0Yc4p2gggXbzYCg9rv7mykoKDjALM4m+IgstW0o?=
 =?us-ascii?Q?v3uzxk4n/7s7zKqg4g6V9qVCaxI85hKw/FRc/MVI/PzrD2fsbmKeyKMcGIZg?=
 =?us-ascii?Q?5u8NdOTEqgV5TaYazD52/pVnMYCkXcwjQK+BJU/anZotbAIXjvCC7gC0iSLw?=
 =?us-ascii?Q?PrGmdeRklhqZSrchpF4pHkoihAjQmbztQ+z2+1bawQLd07tZwxG4UjQL7cq7?=
 =?us-ascii?Q?q0PBEa4oNt8fY6d2n8QrpnhjfEsByi4a2v6WXRw2HCwOxTIG6bJAYS4HoYtv?=
 =?us-ascii?Q?0P0pS6sTfH3iJU3IU4DdP0Ybd7LRsb6jy3FpLD9N5jH3/2XHHbqQ60Oy6t/O?=
 =?us-ascii?Q?wNR8Bp51SccrTsKnpNABGQYgn6AKH5PU8K1RsyoyBsvkGxb77F1WG4DtAVag?=
 =?us-ascii?Q?4cLrUn08YxGuCAGujbk7t3ZEdE8L9jVR0EKzGssm/HwFgokqkxswS2fv7gMn?=
 =?us-ascii?Q?rBtzskFWld41mWT13P/fLGe3kiMbYis1+J58CwSQYhTSi5PIHuLFvBJYlJn6?=
 =?us-ascii?Q?nt0IyW7g2QBFbTRP7lsgTGOI3i0H3TF2NLJ9PhtRhwOJRet8Y6e9sjtGNLVV?=
 =?us-ascii?Q?HHznK+6Jf14MYLgx9el7UQEdqT86MZKFtkknKEgxp+QMEU44hU0x3XUwnFs6?=
 =?us-ascii?Q?PZIdVX1Zbc6PVfrfgJHi/BHZBNUFRaygoQX4yd+l2ZYVT1M9an8sz4i2LdLG?=
 =?us-ascii?Q?/LQQAkXeANV97ILk3LGFCGynsqv3OkYrSm9cIC0CFgAQBpg92jqPOJaWWS7d?=
 =?us-ascii?Q?WAcOVr2BBAdgsSRRqdNHQuKSF1I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:34.2470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b86da8a-cc99-48d7-e2fd-08de58343e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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
	TAGGED_FROM(0.00)[bounces-20462-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,Nvidia.com:dkim];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 41EF048F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update EPP (Energy Performance Preference) constants for better clarity:
- Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
- Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF)
  for energy efficiency

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 include/acpi/cppc_acpi.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 22d7fd669a6c..a09bdabaa804 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1615,7 +1615,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
  */
 int cppc_set_epp(int cpu, u64 epp_val)
 {
-	if (epp_val > CPPC_ENERGY_PERF_MAX)
+	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
 		return -EINVAL;
 
 	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6573a759eb8d..4d644f03098e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -39,7 +39,8 @@
 /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
 #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
 
-#define CPPC_ENERGY_PERF_MAX	(0xFF)
+#define CPPC_EPP_PERFORMANCE_PREF		0x00
+#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
 /* Each register has the folowing format. */
 struct cpc_reg {
-- 
2.34.1


