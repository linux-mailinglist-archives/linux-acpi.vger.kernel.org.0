Return-Path: <linux-acpi+bounces-3281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A672684D5F7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A172B2142A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D01D54C;
	Wed,  7 Feb 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a3ygptJd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC51CD22;
	Wed,  7 Feb 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345886; cv=fail; b=kAs4AkdKfYMErJSuBxiYdlHIs1Xa4e+Bu7bNv+TXtVWMJLnBBc0TCmccWy6u54kYlctbsrILyUM4YdRQf9KMM77kpeCCL9eox4wDWHK0IoouK0WLJA6mkYH63nAdVvXcKHFSGbY1IqxoqW2GRCj0Bq6qG1E6KrTnD57cKDJ31oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345886; c=relaxed/simple;
	bh=FCkRKJuUCiBH2bOfKA5F+B2kbip+9+FD9FCS5GkDD6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTnwaA+2IR6zr4hWeSwHk2lUUJUj5qM6/ozlX93PRZMbgOzfu+yCcq1e6CvhJ/0mpsNoOQou7mm4wIQavfXmBpj1sbOxwqI3K/Pi4RlkezEb0CV19on/xeDIC1zfSIXp6DMsCqoGUYIA+YyDynEz+kLooRUzq/N1VP/IyHKqTUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a3ygptJd; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQbtaOcSH+o75VMOjI2s4EcssB/Q3jaGuqUcsfhgghZK7QABM6+28zHQb2PWErfe6A9SYS1JvCTFUG/b0G2w62y2b70Y9M0kosTAYLEj4keiolhJRnBFq++tml5QeIg2+TRQEKgTNbf5EPzT2lNUpYptQrQ80XPWHZxeTegfoUQGnMR5N2cXwIe2/u2MjO2XRmXGF+FsUQ/dnb/T3mThlyq9D2fxGV4VsQy3ZypPDEDrFwgcs64szTBfuxU+v356LjLF/ur/9bQ6pvMZU59o3qC4N/NqWSanEPbz09GPoMLV/RYOF/7wFtrRl4gpnq1S8s73QJEUlzTn6DRV2NR/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3rqjVBUIR34AeU3HejtCIvV9HKWQfFukppU7iPWc4E=;
 b=fd9hFMTL8ZL6ohOF/3RA8TEGgV9AU2/iuOcVzRymQj96D3wh51oJwwDXqcH2Fi/qva1zBtsCoH2jcrI5jANJM8qGONfO02xSunJNIyKOAdNJn4oEA0U8LyBdB6qo8/GsZKwF1nfRezkvxb3NuSaL7FgkxQhT9M41ZHDfCtEY48oDmg6Fqb8PGpwBExAm8gWvlugEQDIBTJn9tlbHmlo8myFykx1Ju9vT3rpGi1+8CdQBblcjanTWnvQQoNDd6oHoSMOf6XePIa2zPA6q9iVlDUt2F6/F92TEVVryJsvg8wnKy3UUQ3xp0z9NZlfZT9DYaWeozY1d+V6piXA80YrFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3rqjVBUIR34AeU3HejtCIvV9HKWQfFukppU7iPWc4E=;
 b=a3ygptJdeFyXkHt8Myu8oMqaoKzl/HTz6zxVEDlQfZdtWmmi2raraM6KeUWvnj5U1LpUCTMPLKjjR65N1CTT6So9dDmpTK8gzlOKSm9ao9Im1YBsbFSsnHVG2HpRdX2Ma85RxaMzgHuK51y78NwcxTCXdoVTHxo4KJc2PmgxSgg=
Received: from CY5PR17CA0037.namprd17.prod.outlook.com (2603:10b6:930:12::16)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Wed, 7 Feb
 2024 22:44:42 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::7f) by CY5PR17CA0037.outlook.office365.com
 (2603:10b6:930:12::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 22:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 22:44:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 16:44:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Melissa Wen <mwen@igalia.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v4 1/3] drm: Add drm_get_acpi_edid() helper
Date: Wed, 7 Feb 2024 16:44:27 -0600
Message-ID: <20240207224429.104625-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207224429.104625-1-mario.limonciello@amd.com>
References: <20240207224429.104625-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1b74a0-4b31-420f-e015-08dc282e5ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HAcJnFd2CZ2XBalbhtWjKA8N/ls1o3T75PEtYjxIEzK5kSH+IqWvRWpvJT5yrwGuk90wD83fcEjf97eFBSrIunztERjyOIY82QZyfytInEEdE4w8O8QFvKHPxJZM8V7EOa2pe05Pfxm70q3V/uTpc1q4FZGr6Y3sPLLa9CSJNxbB+GsEeRpXQWxgKW/EyxqEFIwJO4EuN8zW96RxNt0VDd4Vuyh793VqNjdr+HX6wo0t13dnH7/Ko50hnyM+0tILKYBKvMC2Iv1p2G0gsxHPxPzweSXbE7pXGoqXq3U2WFZgRK1TcArMVvj8NKUhJMj3VUHYjVoKWMEdiVW87oXwDzfG9Xf6fZ2jDElLJB8vqNqXEnoOBLf/t20ZsgHEcHmDTsxjcK/IhyzY69WBly5u29WNiszAX39tW7MZ7wwAovoKPQI8vmG/vJHszUY4s1gBldN3CeBzVzC0kYpFmcB6Vpzba51GqB+TP8pk3K7uTT9Ypx0JqSudBfMem0qcsWPEZagah4FECN56OBtgMtLBPOKa1Tnz/aFWrJbjWjJoNWQthiSs7pzAns5uQ8IXrBD7m/S5DnIZjpzOAvHkfx4mEdBvbYM1dTJZZvsXuQRmav8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(66899024)(478600001)(86362001)(5660300002)(426003)(8676002)(356005)(83380400001)(44832011)(70206006)(8936002)(54906003)(6666004)(4326008)(36756003)(70586007)(7696005)(41300700001)(16526019)(2616005)(110136005)(336012)(82740400003)(81166007)(26005)(316002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:44:42.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b74a0-4b31-420f-e015-08dc282e5ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

Some manufacturers have intentionally put an EDID that differs from
the EDID on the internal panel on laptops.  Drivers can call this
helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/Kconfig    |  5 +++
 drivers/gpu/drm/drm_edid.c | 77 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  1 +
 3 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6ec33d36f3a4..ec2bb71e8b36 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -21,6 +21,11 @@ menuconfig DRM
 	select KCMP
 	select VIDEO_CMDLINE
 	select VIDEO_NOMODESET
+	select ACPI_VIDEO if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select INPUT if ACPI
+	select X86_PLATFORM_DEVICES if ACPI && X86
+	select ACPI_WMI if ACPI && X86
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 923c4423151c..c649b4f9fd8e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -28,6 +28,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <acpi/video.h>
 #include <linux/bitfield.h>
 #include <linux/cec.h>
 #include <linux/hdmi.h>
@@ -2188,6 +2189,49 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
 	return ret == xfers ? 0 : -1;
 }
 
+/**
+ * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
+ * @data: struct drm_device
+ * @buf: EDID data buffer to be filled
+ * @block: 128 byte EDID block to start fetching from
+ * @len: EDID data buffer length to fetch
+ *
+ * Try to fetch EDID information by calling acpi_video_get_edid() function.
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int
+drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
+{
+	struct drm_device *ddev = data;
+	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
+	unsigned char start = block * EDID_LENGTH;
+	void *edid;
+	int r;
+
+	if (!acpidev)
+		return -ENODEV;
+
+	/* fetch the entire edid from BIOS */
+	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
+	if (r < 0) {
+		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
+		return -EINVAL;
+	}
+	if (len > r || start > r || start + len > r) {
+		r = -EINVAL;
+		goto cleanup;
+	}
+
+	memcpy(buf, edid + start, len);
+	r = 0;
+
+cleanup:
+	kfree(edid);
+
+	return r;
+}
+
 static void connector_bad_edid(struct drm_connector *connector,
 			       const struct edid *edid, int num_blocks)
 {
@@ -2643,6 +2687,39 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_get_edid);
 
+/**
+ * drm_get_acpi_edid - get EDID data, if available
+ * @connector: connector we're probing
+ *
+ * Use the BIOS to attempt to grab EDID data if possible.
+ *
+ * The returned pointer must be freed using drm_edid_free().
+ *
+ * Return: Pointer to valid EDID or NULL if we couldn't find any.
+ */
+const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector)
+{
+	const struct drm_edid *drm_edid;
+
+	switch (connector->connector_type) {
+	case DRM_MODE_CONNECTOR_LVDS:
+	case DRM_MODE_CONNECTOR_eDP:
+		break;
+	default:
+		return NULL;
+	}
+
+	if (connector->force == DRM_FORCE_OFF)
+		return NULL;
+
+	drm_edid = drm_edid_read_custom(connector, drm_do_probe_acpi_edid, connector->dev);
+
+	/* Note: Do *not* call connector updates here. */
+
+	return drm_edid;
+}
+EXPORT_SYMBOL(drm_get_acpi_edid);
+
 /**
  * drm_edid_read_custom - Read EDID data using given EDID block read function
  * @connector: Connector to use
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 7923bc00dc7a..ca41be289fc6 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -410,6 +410,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	void *data);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
+const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connector);
 u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
-- 
2.34.1


