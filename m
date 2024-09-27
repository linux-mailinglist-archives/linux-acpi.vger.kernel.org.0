Return-Path: <linux-acpi+bounces-8471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B501988928
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 18:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52B028493F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F851C175B;
	Fri, 27 Sep 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UBoBeA67"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30F13EFFB;
	Fri, 27 Sep 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454911; cv=fail; b=RvuaY84nz6B7XtyPCfLModA87KyEOEw4YozQ4vR8YwuvLqPNvDcGkmP6HxbSK6L0A4WOL0U9Lez3xvkAbZBLBIs2hT1FZvDeoyZqpcyDI9eKMKFCfPqZjG0aPTbGKFmB4C9ycHuTSpXYZlVXmMj8BfGDEs/aMyCvoJ5kbx5Wcwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454911; c=relaxed/simple;
	bh=SUo3VDZ1YDV1H4CstGDL/UgKT14H43BbgkqP5DZh7Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a4mOXagJWnncib8Zubv/RlVoHXWYB1kZHUyvEivqkBu3Xk8k+uZesslG5rNT8150/MTmjQz4+k17PVaHCVM2i8PYvREAEoO4ixTTMAryUY1KPXIQRB5K83lJYqnXhOCcCiRu+wRDzxju7T7EvKDyN+OadZMjo5naB8EhGwSiFgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UBoBeA67; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUfe9GqL/9Va4OfzmRA4nkpHowzFy/Sw/vZdm+OgdaZ6VvzWJluhv1DaYppS+4RNvCJMptDLTBxmIJdujnG8uS+4QwN8qAPf/j7SzGFzocOOdF0RImQPqC6k++RDKpWaaSQ2nPNimwxHpwEz98xEKZ2bq1/TgK8H9DWaQbzgvspeUz0N8cHFIzdVw3C8wUgD7oCVNSzTzLDPcoDwMN7HsPQNFyv+TED2xm2SA1rCOL1enuURkxx3nMkw1SEAkPZO3L+n+7KT/JFx9Re7Czh30i4zG4Fz0epIx4dnGpkdZ3R91sD5KvvPs6xMccZ8wX+RD+zPm8MIQe9cf8p+G+byWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8uD+WIjRxmP8l7R6rweIawgIgxLgnwyW7Xey0zWdfI=;
 b=QTqj3fp2GRZZ6IBV2iwfsrKQPTuWR+FZzCXbAMVuHL6Sj2y6927w7MVudyyuTcZPXoKvPbJADiETUV0x3R7ptrFL3DyEjkgqrtBwSjdGoxuWBfD0FmAqlDg/KK4p7chwz8h0UYbSlB8qC0l1WxpXkbvIToEOiURNsoZuX4ujCh52wfWM/fpLF+ythkgwXv6EeA0NWSoQt75lvOu6lzlnWcdk51HSUZ/75gB69XUu2mzHM2wCViRwG9uKdUPyDKFLB1seMt/0Nm3rGwcz8blKdm1WLlXkb8uEk1iXtyAcgGriEuzZPpUkVhBApSSI62JROzqHZyhdV/IWTGbUWu2vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8uD+WIjRxmP8l7R6rweIawgIgxLgnwyW7Xey0zWdfI=;
 b=UBoBeA676z1a9mA3wG1fH4nmHIR4HNlad3mrHh7Pr/8dUEygTWWb7Y1SlTClWUsfmm+JrLUYcAZVkYv4NnkYJRFpmc/jVxyP6S8L6swy28idINfRLJ8wPp+HIw3nJ8u3JArGsF7Oc0Khl8/usZqEvOZ23RskO9VBJNb+bC9z0Ak=
Received: from PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::15)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 16:35:05 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::3c) by PH7P220CA0153.outlook.office365.com
 (2603:10b6:510:33b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24 via Frontend
 Transport; Fri, 27 Sep 2024 16:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 16:35:04 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 11:35:01 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<sthanneeru@micron.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RESEND][PATCH] EINJ, CXL: Fix CXL device SBDF calculation
Date: Fri, 27 Sep 2024 11:34:28 -0500
Message-ID: <20240927163428.366557-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: ad796d7f-e064-4483-6a09-08dcdf12570a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vP9p8mnm+HZxyLW8IX1xXOfKz4rL5F5SIRengd41baeAL7OM7eQrsumjcUT?=
 =?us-ascii?Q?VX7PYvyt+FlDI3ULn89RtYGRNVpSNQl8cBQ4ZXqWH9SlynMoB+y3WLut5zyS?=
 =?us-ascii?Q?o2HikcL0ZUkh9Z8AGpBVPgjDXMGAoqXxAFdQQxWiIIQfO7FY+jAFNN96gMfj?=
 =?us-ascii?Q?A0p+gYz+6B6nwaKHH6gaSSC1aN5sLW/FES4fdIgxiKqukZhlyvCE8tzTnpLx?=
 =?us-ascii?Q?K7HMMCWIxkInCMNEvSWK54j73IP8uM138A3ZhhhpSy+mtbUKygzshj2HZxYw?=
 =?us-ascii?Q?XABWKS05jqudlDMIzu5gGhbJ9dpnWmMo9FIDs+njMUqKqHmH6oVQ+8N5Sf5y?=
 =?us-ascii?Q?ftYHz/ozBPPlqorDH0HiXbOiJmmKXAzewmD+LzwreFJd4iPGWzXO+Nx6AQhv?=
 =?us-ascii?Q?OIscYr0iG1t2cFXzB6s7sF6PFsCvFLutQzDPfKCpcJMfDkct0h+zX5BhX9Y2?=
 =?us-ascii?Q?9uICSN3gKQm7CvfDw4531qu64ebsdPAqjh/JJ9umt1FIe61hDbEeev/+Co3V?=
 =?us-ascii?Q?WneyA76FgJ4hAkrbAW3fKWFh4dWn1j7GPzjiHQoHY8B66TZ3Z/Au/yHYGXmU?=
 =?us-ascii?Q?uGJsnonbV2ANODhA7iEiTWrGr3NnZHkF7bKKN/qjjJK+IhVXaiWxRU0QanrX?=
 =?us-ascii?Q?csqkuA2ZrPiSz3oAH8aafsaVj6TjUaGbBHO+pnkASYRZCEnPYRBn1M0zNtte?=
 =?us-ascii?Q?oMC80haI9FUJi5lV92mLbwPUJfuRujU1ISXxtPPq2UGUwPvBJo4EXPZ9OtcP?=
 =?us-ascii?Q?aNQ43779G29PKghmfcLmVLKMa/PP59YUx2+q8ZMPV+/V4X6Zt7VPaFdkcDjd?=
 =?us-ascii?Q?E3AGxJLKOTZWypqsaYb7CKgvevNMqymWWaiyuUrmDu6RBozoEetgwL/Duaux?=
 =?us-ascii?Q?x5/z6vnSLjwsPPQWxERDoUGY8VbcXLGYZpiXmlvSHNKkO4H+L1WL66VLtjI7?=
 =?us-ascii?Q?keSUBxR0M7A60f5XUQnv67gnSIEzoQvz2bbU4woEH5KOx1BtPzE/cfoKVMz0?=
 =?us-ascii?Q?FQT+aOX5ta5jXW03owW5u701XxEFG/e9F37Bzr+2Itbtv3BuKY/qar8061sn?=
 =?us-ascii?Q?CJAdNv326ww6LG6SAne+RgUsUZNMSrJ5/HacT2FQR0NewwYV/qDmuIc7vwvn?=
 =?us-ascii?Q?0no2igMj35MJ8rIRzF2ev0mR+g49MXwgCUVgQzgFuEYfVYtnawi9LTlULy6G?=
 =?us-ascii?Q?G9Lu8iQm7sMr4/mPXge38KzbxXQTfMfl33TlaIa1iaMauYbPQ0G3TGkpppBP?=
 =?us-ascii?Q?BSu7BlBStmZ1n9z5yEN4WxZBX+XsK1GpEfAd6L2rC26EKLAOEkwktoRo8Z2X?=
 =?us-ascii?Q?51/O4/Mg5Sy7TZxWOwrEoYOIi1exYjOMw761uT7Pna31IzIuP/cC8fi+98lA?=
 =?us-ascii?Q?F+aTQ1BkfLdXNlwil6rP+ei1P9vCU/Yy5OtTQ1qG/AAHRU10RwtGjR4odJrS?=
 =?us-ascii?Q?NZ3+LtkFfKoznUS19jfUA4ToPN5JL8HZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 16:35:04.0598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad796d7f-e064-4483-6a09-08dcdf12570a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

The SBDF of the target CXL 2.0 compliant root port is required to inject a CXL
protocol error as per ACPI 6.5. The SBDF given has to be in the
following format:

31     24 23    16 15    11 10      8  7        0
+-------------------------------------------------+
| segment |   bus  | device | function | reserved |
+-------------------------------------------------+

The SBDF calculated in cxl_dport_get_sbdf() doesn't account for
the reserved bits currently, causing the wrong SBDF to be used.
Fix said calculation to properly shift the SBDF.

Without this fix, error injection into CXL 2.0 root ports through the
CXL debugfs interface (<debugfs>/cxl) is broken. Injection
through the legacy interface (<debugfs>/apei/einj/) will still work
because the SBDF is manually provided by the user.

Fixes: 12fb28ea6b1cf ("EINJ: Add CXL error type support")
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

Resent to add linux-cxl list and Srinivasulu to CC

---
 drivers/acpi/apei/einj-cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..d64e2713aae4 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -63,7 +63,7 @@ static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
 		seg = bridge->domain_nr;
 
 	bus = pbus->number;
-	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
+	*sbdf = (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
 
 	return 0;
 }
-- 
2.34.1


