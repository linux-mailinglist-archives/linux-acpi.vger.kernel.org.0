Return-Path: <linux-acpi+bounces-20758-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGAzM/s8e2k5CwIAu9opvQ
	(envelope-from <linux-acpi+bounces-20758-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:56:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618AAF3E6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EDE3085FA2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C338550A;
	Thu, 29 Jan 2026 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RM43VPB2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418E381719;
	Thu, 29 Jan 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683760; cv=fail; b=eY5z0AWidMQWRBsAxFeAUNEpg9f57Ujv9OaDt/NlWWUmCkIxiAMYeabsrucwbwN+V5m+z+96J9sF/yxA6qyvGuKQxXaeCIwINAEpkcBk4Lw6pkLu36f1Y3A9PfAp+qK6I70cQEqeK+ttLyWFnyANKaz6HjMMxUwgZmJ6ZccAaS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683760; c=relaxed/simple;
	bh=MBAO4z4QeubmwQCunNrRbw+2+qHt76GC/smfBYfBcSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzHH7UydCQ8Ks+hsBApjAoYtoydCfAoWzJLu3amtlyv2sIMlODwImCSkeX2IOei1jBhWi4xmObpOrfsGo69MCooZ8PDPn5scy425H/0ATrg0JfE0G8vK7mvkr3jNDs9IM4H6zC2spsmGxfXTGDF4yOsHcsQnVLUguRta0cm1Das=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RM43VPB2; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdHvivrE8JWJgQbcp5yh0YQ7GVPzPdpfnRk/pktHB5t1vgmdyUC3NmciJa2mm5iiNBB65GPtxrbmxoaC1amjigM8OG75+0TrQZzcW196N1TcvbZYlSx1ByvCw0VgOCUT4xun4lp7ZT+VrshY+d5qip0gQtHf5ckrjrhI6A7UDUnxaVo8jc+q4ukOg95aIPcscUrn9T4tCR3fO0T45SAA2pZtQ/KbRXeBuVkuEjWebdWmYYLSU5t5Hip/dlOLW9Y1uXvymYhomRToAwMRaTulYNJ4FVPrPEU0A+Lwv9ATqopbX0FhZtQYGDkdR30kaNIem4hxpabuADxioJdYON0K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhy0E15juw/ICfCFuF0xRfUgnVHC4qcDHQSWHBkjKRE=;
 b=bupZex3v4fKG62itPAXwk+uex9uUN2LqGKLa19s/zJ6dZEJiohpOIaf4OkrXVSobzfBsuZd9o5udraJ2eCEs9Q4dEaCUUeKv52tKUP/4BRYUaa7m0KM7+APDkYInxuvOfUrJzNCFcP+5oECamg/UxY6GpDTt3x1Q8ip8OGtcIJtvkjibW4k1oRmDk3jmFjFdM64EEBEp/BuqeOLufVgItVvyPePOgRk6BzKSTOgvIuLGm6ljArocNBZP9wQudb5Ygf7zLdodLCsXVP77Kjc46P+Dqok6XxJmqF5w5Du3lkpg9gKRjRm3XXBnc5m3wRh++NmHMTR22QzHF1DJVUiGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhy0E15juw/ICfCFuF0xRfUgnVHC4qcDHQSWHBkjKRE=;
 b=RM43VPB2B60Z8JZ6ZAF6MLBRIAfAtwqqBixLGqCLaoEhaw17Hj1PK+cyh5doX9l3pAeomytxknZ58Id5ekV5aSx3E/2/ldhVL/+ImtOFvWVY7XzxwqiVjMn6Xi1MaiNSJHu69Q4JpLnfI7EJxdT2udk2D0S9XTKwxGjVmwyo885pnb1Arq2Qc4mToMojGXKIRg9Ul0qdBM+tae16ldGjRQks1JMSD/6VuIfAygidewcUCGD9El6nc1FnL6ef6TPvJ4Cu81vTvpOaPw6jvdWVYb4DXbBgVuetmTGhB50U+ozzTgFcc28aK9r5rrXhQPyVxk7IItyudAhJy8l2JCTnGQ==
Received: from SN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:805:f2::22)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:49:12 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::10) by SN6PR04CA0081.outlook.office365.com
 (2603:10b6:805:f2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 10:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:49:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:49:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:49:01 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:48:54 -0800
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
Subject: [PATCH v7 3/7] ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
Date: Thu, 29 Jan 2026 16:18:13 +0530
Message-ID: <20260129104817.3752340-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3f41d1-2e56-41f5-e403-08de5f2409b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUXlmfO6hfrEw1++puBGSJ9GQJiN/+aoLEAp1/vGbgutrtFZFloJ6IQKl09k?=
 =?us-ascii?Q?u+D879ieSceqePIeG6zGp/as2+H5PqUmJZikTq9Xq+m2/TgE+4lTs8+QMOvY?=
 =?us-ascii?Q?p/I62pZ2km6SbmJcNQDHjFvIFnJFxIzcknScfIAab83FVhrTYvejYaiLWYK6?=
 =?us-ascii?Q?4DRHochH921KqV9/CdLr8pXf0NvCTpNLaefhJcF+2bJkBtOoz5plItBrArvj?=
 =?us-ascii?Q?qrxG36fwAR5eM8Hog6arS0K/3dE4sEcuXR03NcCtgxWjmdw2cri60aePRcNm?=
 =?us-ascii?Q?rln9WLvzqm5L85dC9rr1eRpx0003qDbuIDrquH8o+K5+cQ2dONDTs0heC0I2?=
 =?us-ascii?Q?HpTpffAbukXQXo7ecmPd8JINkbLHDp8Cv0LF78IUDkEUVdOsPPv5/Vhe5HAB?=
 =?us-ascii?Q?2ei/wNU+Zpi5LSglmr51Q5XH0IKIvaB5GmDPqBTumU3yQuo+QaIBcJi+pnLx?=
 =?us-ascii?Q?XUSkGXHWC9K91TkNb+Rl2uCsVyyzNpe0IchIiygIzS1q9X9KtXuQEacsOw1g?=
 =?us-ascii?Q?6AKMoQR4rC6X3rKCUHSu00z6WyH7S/oPcG1BaHelj716Gg6RJMMUg7Q+Lng0?=
 =?us-ascii?Q?sPCQx9BhUyoGWORK7n8eCsU0LkWLFoEfL9xxfqEkbs4Vm04sJ00vEmntdN1z?=
 =?us-ascii?Q?31jJu4EAP4BihtjTT7gMeZeFV3ms2kdB8cGd/DwExKeE6ukIQ64thjsLFtfS?=
 =?us-ascii?Q?XLMHtZG28EjCzakBfbDRamOKtKai/2EVbLbidYI2wamSytOcGjG26s5f/hlk?=
 =?us-ascii?Q?8263FLnyyo2jqPkQKCEToz4aXiQziO8suoOZg83iRtSfraYPhaHJHOM3ovjg?=
 =?us-ascii?Q?mZIAz7jBF0QTx9cJLfe3M5QgHaaUPBeX6cQKAER6CKnO8OBWt7E33/LuZpOP?=
 =?us-ascii?Q?S+HGRNjbYlVGmor3FjUj/CMbQpTDREpX2Yh/tBrMVoCR6fPMPxi7sWhYqyq7?=
 =?us-ascii?Q?T1fp/nFyGbi2K/QqgLrlYJt7lvLXC54wlmzN9HQDs4f5cC/t625mf4VDX9ba?=
 =?us-ascii?Q?ywi1u+wx3zhA3Ts8zDqYoBGq1dLaZP6D7GqP/jiMomhU5M4RbBr0p7B2ryBI?=
 =?us-ascii?Q?tb8MHZ5ekT5ifGEbRHZzHX2lMAfyJ+Gim7YADAA7z2Q25OV0MlXCiXB4gQaY?=
 =?us-ascii?Q?zDzdr++8PkUbVeDE6NMTt6J+CwkfPXeA++ZE8L3yjpOHrUg7swS/QYw7TVSh?=
 =?us-ascii?Q?v/Jv5K9M8ZUc6v+9khYoZdgLer3REv7hzpHSLdcua3JT9y6N8R4hNGlAEQzK?=
 =?us-ascii?Q?loIryeuKAzGkCnq73zENAlDziQ7NYtiIMQHLFEpvAWv7rJVPN8jbyEUdnLeo?=
 =?us-ascii?Q?zh28JTnHqy+mmbEgTkBRBttgC1uEtx3xpWz5RbBwiL3LpJChIL8G2syImFHd?=
 =?us-ascii?Q?hBYkPq5fPm2d24lXa2RHwW3TCgEyb4ozLWnvum5eALdxfGwryPUNirQ3y//2?=
 =?us-ascii?Q?rY88tE6nDoB4cJaJi8WJIznM3JvDyB61sTlNfHB4ygSFWqp9YFBPT3DY8qTW?=
 =?us-ascii?Q?E0lzxTCrENWO4AVeRkZ8RsbLg9ycF9LSjHHCa1YIPCyqheKdCktFXScNVvix?=
 =?us-ascii?Q?dk7N4ofDd9aIdSECHuMR/2hHDxdJswYQBnznQJDsoxtohiw5B3Z3WtSeCcbc?=
 =?us-ascii?Q?n59DDzVMzZ8nzo2jOCCE3RyjFjJabRfWPoYTHuce8R5ILEtGSvDHyemNTHjC?=
 =?us-ascii?Q?yBcyQ2/4Nmbr6rJ8aNJYyaxKBO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:11.8076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3f41d1-2e56-41f5-e403-08de5f2409b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20758-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3618AAF3E6
X-Rspamd-Action: no action

Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
registers when they are in FFH or SystemMemory address space.

This keeps the behavior consistent with PCC case where both registers
are already updated together, but was missing for FFH/SystemMemory.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
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


