Return-Path: <linux-acpi+bounces-11004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D5A308B1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 11:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7673A2EF7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244D1F791C;
	Tue, 11 Feb 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KAKRAwB7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EC1F76B5;
	Tue, 11 Feb 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270295; cv=fail; b=cubGTF19wg5Df6iTRYJ/vBQXTWUdgi5NttJU0bW/kQfEYWUNDZGvPTohCBBwILp7ppWNE/RFGFzlMSs2y5IZTwMJS3vb6y3d288xuojUfxnVZEf3p7JDj9z+IbUFKJKbOXBMiDJ2k6VhHFUHPC7mbnOmuecrrtdp5v4HayxUp44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270295; c=relaxed/simple;
	bh=fXiRn2vb3+Ruz1L/fU19bRKR92vpjGj2rQCtnprru1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFJNvyC85FGh5mwDkYvguCX0D5TAYgE9vG9o05bQlHCWSkkq9AVob2RgatTUavT7j1Z5YxygcX1h4FFlK9/wxjgBj/yeFHrPZtL+fL5NYUubpSkqeLBpraHABUHmvp/y02hN9gk3RLhlRD4V2FGNiwsOylqdnhwj9otIe0dYQXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KAKRAwB7; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcVJ6Y3wDDhuDoXfpaCMqkdDhj7KajjIbo5NGJQaPgXQBJE4VNDPOiUJcS3EQosh0s+zFOWYTSKqMtpDVvIapSHribt2bqviXyI5vyFo2V7TlVDhtsq39TYyB2+E6oadw9BDYSREkabFscn1T8R3vktrm+O82JZ0jo93K6BCEqDyXAnpAj9u0KSsHJzEuaEbzx26ioswqqQ8Rr+Pyg80a/aXJ++4RvMMBR4b123PrrT7f1t6WptpKTzE7lXkXg5fflKiXi1J/8GoDq5RfC5MV6sQSJUcoqa9GKgajuJBWjJ5ywIkqJWcXCJ/tBaRZLIzqSV9R5LN0auiXNjZnHFlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqqMDDuLhYyDKYlBMOrPSLrXBAJJBB3YpHcLqYSO0f8=;
 b=kBdExlJcL/+ofVwFtymrehmxrdEAgP3tqL01arunNpKlbnk1hi2H30j5lLqUJoKvp7O6Dx7CutB4J8ph5KIIM9MK5wnWnMKSnof2/Q1oboEZxZtr0GejIm9XR1qbXarkVRBmUjiIMN3dKOzXcpCib4afNo0r0AXX6enipxKBQGZfODAhqvrdTV3OUK5kUqSBrXjOxf6Fe8iiP7Li+5PmCGLK+N/iutdVzKOOy06lYaklGipleJ/XmegKmWT97KsVNjyzEfAdQonVqlumDGA6j9hZBAVzMCce4vW93O7kTlHQKhyhpHX/FY/lmiyp5DTrnSfQz6V+IILDZ8qxzRbdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqqMDDuLhYyDKYlBMOrPSLrXBAJJBB3YpHcLqYSO0f8=;
 b=KAKRAwB7GLbvEEcF4lkt+SmmQRQxLYONbl5gfD+a+BSBE2ZdGlNP34rxlnW2D1qUqE1Ql4CZh58pultQtvDKTnkhQwgtjaSKdIJdUpWlcu3Nyhlp/+nOXx/HD6dcP0Xf+e+ksG1KhR/Sh65S1MtRP0fLIU/toQIqyUKtaeuoU/Wq83HdViGg3LC8PqqG5Z7lTN0m5iBnmbEIV23ONOfyPbvLSNj+wRmb+Xmv3fAH2wIT4HjRf7YKX229SK+nMf860GvppWGeRozePm7oQFPBcfrMw0W2YWIQHLbmKdOxlBJ/PXSxXI5rVwtnnKXSzxgysarTA6wDNaVxxSRr5zAybg==
Received: from SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) by CH3PR12MB7739.namprd12.prod.outlook.com
 (2603:10b6:610:151::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 10:38:10 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::51) by SN4PR0501CA0034.outlook.office365.com
 (2603:10b6:803:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Tue,
 11 Feb 2025 10:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 10:38:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 02:38:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 02:38:00 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 02:37:55 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <sashal@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch 2/5] ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
Date: Tue, 11 Feb 2025 16:07:34 +0530
Message-ID: <20250211103737.447704-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211103737.447704-1-sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a95590-d5c9-44c4-e8b4-08dd4a882dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OLAVd3DrmOuOjv+P+dKmyvhvl12OdPTBJX2LgMIBMvIPyuIJcaVKu9YbpBX?=
 =?us-ascii?Q?DNT1872xcLwm2B6NPwo/IzvaZtZDhWBi6yc8tEu+0QzgBGtcNA+rB3YBCg6j?=
 =?us-ascii?Q?MlNXthQ4jBTRJ6Ec6g1ZWny39ldbCoPGiIj8b8/6T5OXsjYGy49//NZWBHxS?=
 =?us-ascii?Q?zX3E7Lt44wk76QivkXpE3yIXw82PPvg6FRALCSzTwwOy+AWDiXJbT2IatxVb?=
 =?us-ascii?Q?Ctd/8phKrLgmP47BuSN9gPYKAL2DLfL03G8JOTBty10BZfg424fzP9IUPPuo?=
 =?us-ascii?Q?gMsu+eunTbuo9UI2MfkJrPyB2Exk6dsQQ8jNywqK8qNVtk/qGy3jOIPQQNRB?=
 =?us-ascii?Q?3CDiUNXRwWa4D9PzkuKnqDe6HfXZSVb3SRWfCqX25rQpjo8+yK+fqgGsiOMS?=
 =?us-ascii?Q?JomKvsAtO/be52fybPniQ2cPZ86K5/v67/VClte3TBHKSYKRKlnbVB4gaFU0?=
 =?us-ascii?Q?48As4lqVHUTDQZoZ4FeNsDW557njBB18kOKoxAR4r0CqGfn8psJ9Myk1pBCr?=
 =?us-ascii?Q?ou7wB7phxvgu5gU25e2arhy1F4rdwfBjPWmg6MzOrSD5JF5ydlEJYLX9mhxv?=
 =?us-ascii?Q?TJiyEtoiDhgfcDErG+k1gM4rai3maAFSk4tWcY9k+fMAG2Ix4yhDw27f6YiY?=
 =?us-ascii?Q?alZ4Fy9cFhozyD7GBzjeACgOeg1/5EV4DQlQ5b15Q1K2xWclj6HcGV4H61ao?=
 =?us-ascii?Q?GeqUoJpWf5EV+HjiyLiswqlfrx+QBQRezXQnIwIc3vtHaqv+LOfoNihakR+f?=
 =?us-ascii?Q?hLFRQTSbX5eyyK9X3zOIDg6bHiuZcJ89ZSZPGlhHDQM5rNVlfKczLIED+d5r?=
 =?us-ascii?Q?c6kxciBO3fRvtYGyVpIg/0FQuS2NPR+g0zJpwEZnZ/+eTQpvWYn1H4QbUGx0?=
 =?us-ascii?Q?NgPaD8V5oMgn4f41WBpN8JefA4rnQV7FP8766WI6V6xRI1S4gzNoCpnOI4l3?=
 =?us-ascii?Q?WAllkWC0MveUez61Sl1SlsGt7SOaGV4r9Tzf72JrAnyVnCRxOW4lrfWJsqeP?=
 =?us-ascii?Q?YisfpyAHRna8zZrivqmWiUcBJ9u2fRY52H5OM5EFzOuOEvKkTBsW8pRg0Hlj?=
 =?us-ascii?Q?NsFhNSKwC9j9kbSfQaGQV0MlICoFjUwVND+xsrugu7hPo69z+7Pvn5nm7UZ3?=
 =?us-ascii?Q?pcxzqeumAQf84Ebm/Tv+dOmQLEXvtzqKE/5BGgO+zSp406cTBBEtFdWsTmjv?=
 =?us-ascii?Q?0YCKCt0wtd9Fsj4sL/mdfKOPJAoJ+hIQB2odkbTO7eHycqyLuFBdI9dEY2Ai?=
 =?us-ascii?Q?gSOWbWpYkCXZBPxcjbEfg1ECyGxH5zLNgSlEcbsqju4qSV2yvn7JVoLnq7b5?=
 =?us-ascii?Q?ITojfs22rb/bvm2VA0LZxb2g8ngrv/+p14VX2pF2zRIt5AJWgMTHXsxYGr30?=
 =?us-ascii?Q?GPaztuBwpa3NOLqapICRXPUIny6Kgjbctt3HSY29h5JSZP34FVO/aoWK3J+d?=
 =?us-ascii?Q?IU+qm3FSIATeQNGufYodNHXW2TRou0jyG0r6HaqDaqY66+KUsmj0JqSrl85H?=
 =?us-ascii?Q?RhwPZ0f7u0iGfS0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:38:09.8737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a95590-d5c9-44c4-e8b4-08dd4a882dc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

Rename show_cppc_data() macro to sysfs_cppc_data() and expand
it to enable creating the acpi_cppc sysfs store node.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 297e689f8214..cc2bf958e84f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -139,12 +139,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 #define OVER_16BTS_MASK ~0xFFFFULL
 
 #define define_one_cppc_ro(_name)		\
-static struct kobj_attribute _name =		\
+	static struct kobj_attribute _name =	\
 __ATTR(_name, 0444, show_##_name, NULL)
 
+#define define_one_cppc_rw(_name)		\
+	static struct kobj_attribute _name =	\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
 
-#define show_cppc_data(access_fn, struct_name, member_name)		\
+#define define_one_cppc(member_name, mode)       define_one_cppc_attr(mode, member_name)
+#define define_one_cppc_attr(mode, member_name)  define_one_cppc_attr_##mode(member_name)
+#define define_one_cppc_attr_ro(member_name)     define_one_cppc_ro(member_name)
+#define define_one_cppc_attr_rw(member_name)     define_one_cppc_rw(member_name)
+
+#define sysfs_cppc_data(access_fn, struct_name, member_name, mode)	\
 	static ssize_t show_##member_name(struct kobject *kobj,		\
 				struct kobj_attribute *attr, char *buf)	\
 	{								\
@@ -159,18 +168,18 @@ __ATTR(_name, 0444, show_##_name, NULL)
 		return sysfs_emit(buf, "%llu\n",		\
 				(u64)st_name.member_name);		\
 	}								\
-	define_one_cppc_ro(member_name)
-
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
-
-show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf);
-show_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+	define_one_cppc(member_name, mode)
+
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq, ro);
+sysfs_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq, ro);
+
+sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, reference_perf, ro);
+sysfs_cppc_data(cppc_get_perf_fb_ctrs, cppc_perf_fb_ctrs, wraparound_time, ro);
 
 /* Check for valid access_width, otherwise, fallback to using bit_width */
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
-- 
2.25.1


