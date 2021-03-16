Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73033DD40
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhCPTTE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbhCPTSv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2021 15:18:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3216C06174A
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o14so7276664wrm.11
        for <linux-acpi@vger.kernel.org>; Tue, 16 Mar 2021 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbwZsYD4Q8bJKtEB6fxh/bFBCimZQTVQVLBghKe6qbw=;
        b=Fw/OojIRjcN1Khd18loli2fVEoX2eO8BxWvGUV/w/gINHwluL30dSWAh6qrJt3Sd/N
         ck2xw1Cjj6Trn4wLHz33y3JImni1Q9YLXkE7sUjgdpk8ct76pvt1ScCTaKNhBzT+gpQ7
         yeLtQMMQ6yJAPa3ql2QOtP6O4VNaswVNnUKrG1wr4ovsscKI50j+nTmVWepaiariJtvd
         gpjHPvJbE/fjajNo9/K5fc6ypFNzPL4XP8X2om88xf094zU8oeD0nTw/JHOiQGj0ffv4
         xv7HYx02Khp62T8TfM6qak2p3lLGu4VSeqwTonb1ORY/cHgGrOZokparIbPY79QU0aHx
         tiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbwZsYD4Q8bJKtEB6fxh/bFBCimZQTVQVLBghKe6qbw=;
        b=MTHfLmfrWREOo5qxxuuSWfdosvv3jH6tS/0xFP9afvx4jD4iMHRfwPB21MS58Nk9qd
         KPLTSMFa8mAlh1GCJZFkR2Oq0CtBPpe78dH6XtvTxT61krZXfB7zyELvYyO5/ygsBWLt
         I4vBM67FEZlJT1/HrjMDGTjzJA5E0pOH91QZiSAxf9eY04YLkhG2dWV0gEiQPFkeSSBJ
         MFR/egOVdXqLEaz3v2oXREO3vzGQF/CjOu/jFTuHRPKqzKzs9cz0KxfO9pTJqkwMdNJA
         tj3JEnr+wYvl1IVjVAzdRCBdrWKSJ/oanePu5RlUvqHhIQk/iMqgBHCiXZlAOYuQ+Gpe
         H64A==
X-Gm-Message-State: AOAM533PYa6mP3S7Fnty1DwTlm0KMqmhcgslHs12XT+l/SAKlzNss0lA
        QUzfJ9E6deI0QTgndmzhBGbC8w==
X-Google-Smtp-Source: ABdhPJymVA+bDQYxQA0i9VexjAgCNYrzeQ8+S/1wLYjWYR0LjtgKCLhBt3in1MQJ33b+oqMmOM4lKA==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr549309wrz.11.1615922329510;
        Tue, 16 Mar 2021 12:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p12sm22690438wrx.28.2021.03.16.12.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:18:49 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH 1/3] ACPICA: iASL: Add definitions for the VIOT table
Date:   Tue, 16 Mar 2021 20:16:52 +0100
Message-Id: <20210316191652.3401335-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316191652.3401335-1-jean-philippe@linaro.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Just here for reference, don't merge!

The actual commits will be pulled from the next ACPICA release.
I squashed the three relevant commits:

ACPICA commit fc4e33319c1ee08f20f5c44853dd8426643f6dfd
ACPICA commit 2197e354fb5dcafaddd2016ffeb0620e5bc3d5e2
ACPICA commit 856a96fdf4b51b2b8da17529df0255e6f51f1b5b

Link: https://github.com/acpica/acpica/commit/fc4e3331
Link: https://github.com/acpica/acpica/commit/2197e354
Link: https://github.com/acpica/acpica/commit/856a96fd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl3.h | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index df5f4b27f3aa..09d15898e9a8 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -33,6 +33,7 @@
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Translation Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
@@ -483,6 +484,72 @@ struct acpi_table_uefi {
 	u16 data_offset;	/* Offset of remaining data in table */
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Translation Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 node_count;
+	u16 node_offset;
+	u8 reserved[8];
+};
+
+/* VIOT subtable header */
+
+struct acpi_viot_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_viot_node_type {
+	ACPI_VIOT_NODE_PCI_RANGE = 0x01,
+	ACPI_VIOT_NODE_MMIO = 0x02,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
+	ACPI_VIOT_RESERVED = 0x05
+};
+
+/* VIOT subtables */
+
+struct acpi_viot_pci_range {
+	struct acpi_viot_header header;
+	u32 endpoint_start;
+	u16 segment_start;
+	u16 segment_end;
+	u16 bdf_start;
+	u16 bdf_end;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_mmio {
+	struct acpi_viot_header header;
+	u32 endpoint;
+	u64 base_address;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_virtio_iommu_pci {
+	struct acpi_viot_header header;
+	u16 segment;
+	u16 bdf;
+	u8 reserved[8];
+};
+
+struct acpi_viot_virtio_iommu_mmio {
+	struct acpi_viot_header header;
+	u8 reserved[4];
+	u64 base_address;
+};
+
 /*******************************************************************************
  *
  * WAET - Windows ACPI Emulated devices Table
-- 
2.30.2

