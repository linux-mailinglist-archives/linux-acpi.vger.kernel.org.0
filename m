Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2239C320
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFDWCt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:62965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhFDWCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:47 -0400
IronPort-SDR: FWkmneAKmOFy7HnIm3KmFwbW9nIf/6zTlX838KVybZwDgmtLIzX/kgFFv+uZtN7HErxG8IBgwg
 36ABWAuUgyZg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539946"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539946"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:56 -0700
IronPort-SDR: 2q0IJEYXlM/KrbYT3aH+3y8HP+I/oGuj88OKAkX6OUCo+gMiDsozWF0Ja+bTmzJ68pqBPlA9px
 x8VHRDYSveFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146713"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 06/14] ACPICA: iASL Table Compiler: Add full support for RGRT ACPI table
Date:   Fri,  4 Jun 2021 14:26:00 -0700
Message-Id: <20210604212608.2604267-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6949e1dd2d92788a994ce657857fe8809159e71e

Includes compiler, disassembler, and template generator.

Link: https://github.com/acpica/acpica/commit/6949e1dd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d042341e8ba9..f1d5e8950527 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -40,6 +40,7 @@
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -1790,6 +1791,32 @@ enum acpi_rasf_status {
 #define ACPI_RASF_ERROR                 (1<<2)
 #define ACPI_RASF_STATUS                (0x1F<<3)
 
+/*******************************************************************************
+ *
+ * RGRT - Regulatory Graphics Resource Table
+ *        Version 1
+ *
+ * Conforms to "ACPI RGRT" available at:
+ * https://microsoft.github.io/mu/dyn/mu_plus/ms_core_pkg/acpi_RGRT/feature_acpi_rgrt/
+ *
+ ******************************************************************************/
+
+struct acpi_table_rgrt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 version;
+	u8 image_type;
+	u8 reserved;
+	u8 image[0];
+};
+
+/* image_type values */
+
+enum acpi_rgrt_image_type {
+	ACPI_RGRT_TYPE_RESERVED0 = 0,
+	ACPI_RGRT_IMAGE_TYPE_PNG = 1,
+	ACPI_RGRT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+};
+
 /*******************************************************************************
  *
  * SBST - Smart Battery Specification Table
-- 
2.29.2

