Return-Path: <linux-acpi+bounces-3962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA88683BA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F8928C04B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFB13329A;
	Mon, 26 Feb 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWBGRAqk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49938131E23;
	Mon, 26 Feb 2024 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986489; cv=fail; b=Q8cbdg+gyQ55YZI9tQ4vBg0sQ1o4qim+bbK3AZ1qXxXfWha32RiFBms4U8SIJivPZf3ZIRUaF23CCInKOSuORwkCl6m6UnQmHLt17zMDyMLewdBwx6OjFk25qe76+PoSaDRdgAJyyGKdase2VwQw7uGaD3Y3+Gc5Q3ZCZX7l/fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986489; c=relaxed/simple;
	bh=ZN/HXXAlnqWE4jwnaBx2xKnUOsErrxKflN7W5Pj96dY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNV3y5QLwkRxW6brkDun6wWySz5RJ1XqV/I0CrF2glsFxlDSjUJwF+YBQIxxOWayGjx0hD6rM5F0Pwq3K5i2/gPhtduxykneAt19Mjrm8U0Dj0butpKrwvwcuvCmcJZY03eggDo4/SUdPtBly+ymUJYr10Ns7WRkjbKeDZx0zNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWBGRAqk; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1sKDG7I85S6QN3y2x26nGP9Lu1Wny6wM55a9gYMSi7qFVROO3sVS0kPMQRrJ7GV2Md95QqzGy1qfJZd5k5tbLfrkZ4erBSLbMTF/tThQb6Ek8uRSz3BB/Od/jdtlqj2GgvyCtt0m1u1MNSnjjQ2uvV+y3QpjKuQPBO/M5zrpYz8ilq2pqf/bsYjZAEvkB5mxZ4Aht4XGdOQ/k85JaX2Hxc3+kii60dMv0MLG44B7JqCwfWZU+pZJipHq2PuJAwDacQAO1HsKaCXoBxd7M4vSdyILsQASZfYsRwaLNUOhWCs7OdW1B6ikDa1zr/GlCr+e4SMvxbBYKtnbr4x2xwNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGrOlPxQObimuLPNMs7cp1YZafu8dhqt27Y8dKSzDvg=;
 b=lyVKi8VViUTahgGZEhCM+cLwjPYDveBJ8EVtQxI9sC2to7EWObUOwY/0blp/zzdQnzRqQEVTJ5ZyOxL3ww78WT8sXMVc3hOzYuynk/CIhenfAHFk21T78vDrNRmx1WkjK6Z2fwJdsdo7lIatAsmwxxEyo1AFUTpW/UWfBLzygpr1r5DDfjFEWX7WAciFMD/hYLjq1n2CJbpj9DPjbeSteTwHdxmWHPDR5ig4eUnQbDzFfLWnBe7uf+shyLQeUp8ZzVoUUxKHK36fnoiJPGck2oMJWqLiiqgO0CpZhMeT7BPBHH5jVWYn9UZA8czLa/T100LTUYWlqsWLZw8DV97unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGrOlPxQObimuLPNMs7cp1YZafu8dhqt27Y8dKSzDvg=;
 b=BWBGRAqk8TbimBBUhP24dYR9hvOPYafqeBPGEjTBVPnmXq2P5nBfAIPjQxd2ny1jcgOULZ0CKGP/mj4Zak2TWe7Y+bBZEYmMBpeXz+ariinAVB7O8DXZJgs2exFVQ1PHQ5StrMAv1PRiNzbaI3tWEsY0y94/Z/eiTcsrXEXQclc=
Received: from CH0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:610:77::23)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:28:06 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::57) by CH0PR04CA0048.outlook.office365.com
 (2603:10b6:610:77::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:28:05 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:28:01 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
Date: Mon, 26 Feb 2024 16:27:03 -0600
Message-ID: <20240226222704.1079449-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d48c8e3-f54e-46e9-1fca-08dc371a33f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t5Hc6YYu7sKj520eirTCjEAqVI3RXgFLembQrw4i6+leNSdP9zF9raycg3/9HInZDcdKwzMBSPeWqsN8zpjThwElvXmOcNjnTrwBaJmoxkPnwaHLhZNDOXTL2HPTv5dyPF8APj0bUx68KVBlwaluaQn40iU0T1VluxYa1w/WOILhjIUeoqZDRCIGfYpCVRgocm4czZ7K8uIHo+KdGXKV2tkySOHxA+2Rt8BRw/vV/+qgTN1YM8Iou/2Y0ZvdSSXJm7wibcZl34EPX+Fv/j4yG3JQykx1fvdoRTHnuj/uB+U1bQ2fn2Ghb8WrSbefBiZ0uqlsNg/Vam+rP+WppU3p9Rb4DSLTCZKWQ6YP6CaUKsAb9NCEI9oYvBAB4xmw4kwhNV438JrNmeQX5mhQglFTRIh57Zf3FJU17nXr36BHSKZE9ixmm/KWonIGfl9mnhUscSRBN2gYJB2SGw+J0s2yyVjHVosXW/tyx4jtN5HWEPByVe9RVpX/CV9KQQKdN+dY7vc2h7lxKlBH2fcEz1pWMfI1dYVi2DQW8ZAPlGkrvEgXhpL7ybcx9tectp/fAuivXEb+M+l6M5iNnc/stfWoPXD1hn+Gi9UguoOU88JiNQTm2Qdknqf35YAVLjRISK9nM8jQgncE2eEutjaJgDuuRqrO7c/d1LqMIYjNXSKlj6xgWcD+2eWheWb39+AOXEp42UIPXR1ABjHTnje+7MItuYJXj0NAIBVz5Qo0Rn281JQNKSPp0eJ8D2wyCz4V05RI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:28:05.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d48c8e3-f54e-46e9-1fca-08dc371a33f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

Export CXL helper functions in the einj_cxl module for getting/injecting
available CXL protocol error types to sysfs under kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the einj_cxl module. The
kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
error_type and error_inject files provided by the EINJ module, i.e.:
writing an error type into $dport_dev/einj_inject will inject said error
type into the CXL dport represented by $dport_dev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 30 ++++++++++++++++++++
 drivers/cxl/core/port.c               | 41 +++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..4c0f62f881ca 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,33 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/einj_types
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The possible error types are (as of ACPI v6.5):
+			0x1000	CXL.cache Protocol Correctable
+			0x2000	CXL.cache Protocol Uncorrectable non-fatal
+			0x4000	CXL.cache Protocol Uncorrectable fatal
+			0x8000	CXL.mem Protocol Correctable
+			0x10000	CXL.mem Protocol Uncorrectable non-fatal
+			0x20000	CXL.mem Protocol Uncorrectable fatal
+
+		The <error number> can be written to einj_inject to inject
+		<error type> into a chosen dport.
+
+What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into $dport_dev ($dport_dev will be a device
+		name from /sys/bus/pci/devices). The integer to type mapping for
+		injection can be found by reading from einj_types. If the dport
+		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected.
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..3b579eef4d23 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,6 +3,7 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
+#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -793,6 +794,39 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (dport->rch)
+		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
+
+	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
+
+static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+{
+	struct dentry *dir;
+
+	if (!einj_cxl_is_initialized())
+		return;
+
+	/*
+	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
+	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 */
+	if (!dport->rch && !dev_is_pci(dport->dport_dev))
+		return;
+
+	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -1149,6 +1183,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2221,6 +2257,11 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
+	if (einj_cxl_is_initialized()) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
-- 
2.34.1


