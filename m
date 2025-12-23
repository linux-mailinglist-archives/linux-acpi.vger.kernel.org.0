Return-Path: <linux-acpi+bounces-19818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058BCD930B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B5B53033724
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856443321A9;
	Tue, 23 Dec 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qgX07Q6v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF387331A6E;
	Tue, 23 Dec 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492039; cv=fail; b=awr49+ejGE5pSA+yhgMzYIcbRRm46Ko2orQuYz6jYBqKWFhQRKDKbNkFfQFrUg7ayNynNDBi5YnqA85ZSnQUVxjtZcMuY9NuvVeT/6UtotYyDI9xdoOJjY31+s43+DJ5KvtfCTEju2WQTwFLi3CgN8O0JPbILCL7ztW+Jtuofck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492039; c=relaxed/simple;
	bh=oPmfzuzdJrvlTsNvYKRYEU2chcOcwtmhWaNmP/PsEBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPFtgGf96n6EQb9MtlvZLvZmMIFUHynF/d+szlrncN2w8h62R+kiHxUS8XePMzDhcx8D5chG6E2LkpPZxO6+ylQLkjqER8I40+dTqBEpTfAcmi+SqU79ldJNxtNlAn7RTe/5IsEVccYTVaF9lQFnFUnpTDmTF5OUMiSFhEG4wRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qgX07Q6v; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NszzYe9CYySmYCt2wQeVZp2E9vQeF1xDxijqLQU7OoTZw9xtjDlP7WteVuvA4LaPS9ElGNII5ruQpdLe7jDxmjdFbyX7Z63U0fzxzwOqUh+cOBrSpY9vSJrTRcf2o9V+GV92SVyQo5UfesIhEIQZHZNHw8HJsOeIoEkb9gk/Mlrqc2Bl1UUAL08I0jlRMZ45Go4h7o8iaSoVMyWeu210pBgBMg2qmDjeR6yTesSruP73KpaT0jAXAV5puNybIszEmtwlx03SFPj3NYAnm0dugiIWp7A39TvSIshkcpNmajAno6uRgigi94abwBXXAoJJ7eqgKLxaosEa6ZvDxxF+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLcwldikhS91ww2sE9IaXldkzy8C8UXJNVDAavCmOS4=;
 b=GVGSPMF8Hb4khHe6CzDuQHnLh+G2pnAWlsuVLJZgIyDHxJmvnCpRWxrhRDK+Y5Wmbt9Vg+yKHL881KPtXYnpy81TeNoSnglyXFXFhRlXYxNFscIEyBw8ue998vvT0PJB+fC/c9FYqk2Vq0/jLfJIFxJXYa6HJoK/OXYhDFLnpjoGrFohNQQyjBaC1YkiN/+5JDA6XIw6dp/vIDBxpFxTmksAwuXuRxW0zXJNie5PJV7MNuRuT1+HKQIGDouS6ZpciEE9GKFG9mpMCrlAh/IQjIFD0G/eHAbEw5CbojkeEJ6IRiRCWDi4lDUOS8QSF5QKunpxzsAdNOdQ36XJ4MBZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLcwldikhS91ww2sE9IaXldkzy8C8UXJNVDAavCmOS4=;
 b=qgX07Q6vR7nuclQgJPsZ0mjjFB9nCA/2LQzXr8580YghFr/pL/vxV2aaO2P54XGW9HIfk9TeIhmdGMguY0QaPsoMs+SZe/wA/YRYnHlV/QC9yPI+SjBbal3Vz5KgcsPS98GbOJISqvW2ljBGszHClLMmPAs6qKLV1a4kI3uce63gZEVo8m7Ji1AxhXSGVL8A9x9tABFCvut6ySyrDzubPu87Y1LQEjwsNk6Y56nB6xA8rVSbL9M0UIwUmNdpCUOpwqhPlmmK7HD+RgJFDS1hQTdmxfvPmZfehQ7iCQEr4jDcRXzjNGuyDEFqbD6W6MXd50cIUVrXW5dUpbFN4XdOJA==
Received: from PH8PR02CA0040.namprd02.prod.outlook.com (2603:10b6:510:2da::17)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 12:13:50 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::a2) by PH8PR02CA0040.outlook.office365.com
 (2603:10b6:510:2da::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 12:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 12:13:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:37 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 04:13:36 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 04:13:29 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v5 02/11] ACPI: CPPC: Clean up cppc_perf_caps and cppc_perf_ctrls structs
Date: Tue, 23 Dec 2025 17:42:58 +0530
Message-ID: <20251223121307.711773-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223121307.711773-1-sumitg@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 117eb132-48c0-49ba-1b0e-08de421cbac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7l3KHNn3ZjsoIZw1hzRSaqYLI+BWxltnL40jUBllYir1cjT/uhZUGlqrDcg?=
 =?us-ascii?Q?ubL7Xg1Z8uz1VaiX+VNNWcs2s7TABiewj5tOnwrpHPE+12e1ZUCH0JyCWiKv?=
 =?us-ascii?Q?SEkZ1GJV5BWCYAkaOk4I81hnBPsgzrhv1pxgb2EScupclo2n0wyPA2Q0arww?=
 =?us-ascii?Q?rmnxNUAN/JNmuqX7M3rQSszsEHxo+SnZO/QTv60GAJDYek1sbU5LM7jjqqIG?=
 =?us-ascii?Q?WsRIbQVkV3CoLOZfd2D9cz+rbJRGhpHFTPDYh/ILjbo7RN/6mEc6aqVKyV73?=
 =?us-ascii?Q?vz0lCsSsPn/V/iF3SFUmxIFRHib/vxoA9ArG+/K28BUTneXxC+IHfN46kHXK?=
 =?us-ascii?Q?rtnoRVxo79s2dtZUAP7mvmFFnitt0Au+QK26z9y0YHE+ioVtzdNGLSuYXGap?=
 =?us-ascii?Q?F237YQCHTtxSQfo2IpmfHXu1qC0L8EWAHwgdUTBvpNOZ1zAnvc32hOGjN6uF?=
 =?us-ascii?Q?HSAwqHJV3+CrYAPpxYlKCRGYiPmAV1GdDtUmPWAyfdgJ6TmAVYN2GTkl14tB?=
 =?us-ascii?Q?qj98IJwHV+YB7fnZdfsk8X7tx0U3tf1EIoBfTUhaOH1Y1bIwksy30LFcN9d7?=
 =?us-ascii?Q?bKE1r5MVy0MbA8GdSVds9S6kvx/t2oAtB42uPe2aTZxuljeycoStv7N1JyJr?=
 =?us-ascii?Q?bS2RelwFIIRYoXICerqylw8JsBLdQzEyK1YUKXymGfg5aAulSAYSPimeUgcm?=
 =?us-ascii?Q?fjCezKSxUnRtHmGBF//ML822NiPpCtzaaSV7lBo2u/QQqNCru4B5rNONhbcp?=
 =?us-ascii?Q?cP1IHwFEh4ftj984Z8Plb6tlh2DRGAzrRKmv2pqeJDPPtOIxc2hx2omoDOD7?=
 =?us-ascii?Q?fAW+vA1qnPvlWP7t2IGrqWt5P3xhwypuLoQYOMl6i52YRX7G9F6nrFZx5cPx?=
 =?us-ascii?Q?NvEg5T5zaGkGfe1rxBwo4ggLU1svDxkL+nkxqzt/6vRqVTFPUCEbo+bEBo68?=
 =?us-ascii?Q?IuIll2zJbT+lBh1w5qA1OEGamosnsfvgsLwUSkqkhfcjU8kpnxjpcMB8PI55?=
 =?us-ascii?Q?WuzKfw3a8jeWZs61/GZInWIIJ5pda/oTbG/ENPL6yVK9YYcY5rTCS5+VtUTX?=
 =?us-ascii?Q?888pFEPzSiJ1yvfUpHcjEY5j8UFVzy8cy8/+4kA1YHHX0hN0xJF0+F6whzyy?=
 =?us-ascii?Q?InD9fTDDgou4GJ1OAeTXoTLr26/QBZbuj7czf9MdFe79dVDTq/IAAbI9XL2f?=
 =?us-ascii?Q?oLUfL5NlZZ6CdXhXW84V8DjIVlOhyP3Omk5HAVVt4HKEvrqqcHxZIJjeWYf2?=
 =?us-ascii?Q?dlSXYrE/dg0vDLbO6/TWqAWUFnBIWi4XfSaOHezxMmrf9YV5wDu01ykIYMm8?=
 =?us-ascii?Q?5JAYp3fjLL9xd9gVciYhvSZbWxGHf6he5k6yzOj2ZQIpUIhDZ5T3cXBqtbwh?=
 =?us-ascii?Q?S5CrljJ2X6S9f2GZW/sJ5bu+BTpQDiUIjdTrePCZA6aOVBzHTQf97TxzqkzV?=
 =?us-ascii?Q?mCFlY1vNnJaxbSdyL4xVqMRMd4P74nkGwL2wmxYpD2fvvYv56xddwacJMzr2?=
 =?us-ascii?Q?FlGp30AxDaW9HmeI5RDvr3P6tB9gTonqi/rKb2XRvvwluP4/2IoOGy3vxsiW?=
 =?us-ascii?Q?5StoByiFkDOK0D8jK+drdiDBSHnbdV437oCOk32J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:13:49.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117eb132-48c0-49ba-1b0e-08de421cbac3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

- Remove redundant energy_perf field from 'struct cppc_perf_caps' as
  the same is available in 'struct cppc_perf_ctrls' which is used.
- Move the 'auto_sel' field from 'struct cppc_perf_caps' to
  'struct cppc_perf_ctrls' as it represents a control register.
---
 include/acpi/cppc_acpi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 13fa81504844..a090b010f5f1 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -119,8 +119,6 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
-	u32 energy_perf;
-	bool auto_sel;
 };
 
 struct cppc_perf_ctrls {
@@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
 	u32 min_perf;
 	u32 desired_perf;
 	u32 energy_perf;
+	bool auto_sel;
 };
 
 struct cppc_perf_fb_ctrs {
-- 
2.34.1


