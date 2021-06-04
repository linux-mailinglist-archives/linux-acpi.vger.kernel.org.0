Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A439C31C
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFDWCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:62958 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhFDWCq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:46 -0400
IronPort-SDR: 9OYUXyZr08mXW+KNkPm/qeb/fIrJCjuUtyUfkYvop0o9xlGItezlZmM4Hvjgs+weS4KF4feRCR
 ESKzVGzUlAlw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539942"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:55 -0700
IronPort-SDR: zYE8vwRpRP1S2AC+tI7d0Vt6ZvPIsvxEVzQuNDc/GzWXfcK/vg0eueSlDk5tp3jk2FboliuWTj
 qJCSLbNY3MTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146700"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 02/14] ACPICA: Add SVKL table headers
Date:   Fri,  4 Jun 2021 14:25:56 -0700
Message-Id: <20210604212608.2604267-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8

SVKL (Storage Volume Key Location Table) is used by BIOS/Firmware
to share storage volume encryption key's with OS. It will be used
by userspace to decrypt and mount encrypted drives.

So add SVKL table signature and add it to known signatures array
support SVKL.

You can find details about the SVKL table in TDX specfication
titled "Guest-Host-Communication Interface (GHCI) for Intel
Trust Domain Extensions (Intel® TDX)", sec 4.4 and in ACPI
specification r6.4, sec 5.2.6.

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Cc: Robert Moore <robert.moore@intel.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Link: https://github.com/acpica/acpica/commit/b5e6bcf6
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3b6f45a2edc8..d8fec67e4c8c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -44,6 +44,7 @@
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
+#define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -1913,6 +1914,35 @@ struct acpi_sdev_pcie_path {
 	u8 function;
 };
 
+/*******************************************************************************
+ *
+ * SVKL - Storage Volume Key Location Table (ACPI 6.4)
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_svkl {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 count;
+};
+
+struct acpi_svkl_header {
+	u16 type;
+	u16 format;
+	u32 size;
+	u64 address;
+};
+
+enum acpi_svkl_type {
+	ACPI_SVKL_TYPE_MAIN_STORAGE = 0,
+	ACPI_SVKL_TYPE_RESERVED = 1	/* 1 and greater are reserved */
+};
+
+enum acpi_svkl_format {
+	ACPI_SVKL_FORMAT_RAW_BINARY = 0,
+	ACPI_SVKL_FORMAT_RESERVED = 1	/* 1 and greater are reserved */
+};
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.29.2

