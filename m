Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6463688BD
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 23:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDVVuJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 17:50:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:1655 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236763AbhDVVuJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:50:09 -0400
IronPort-SDR: AKEY+wKDzhGHW/53nQ5MeHCv6BOHTlcvOnl2Q3qgbKQIwBfI3dyPM16n59eOtJX5ojKhDqcz12
 4fv4JvBIT7VQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281306828"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281306828"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:49:34 -0700
IronPort-SDR: 9v3Jnzo0sau8JhUvLa2YtbH0/lldGzL0vEapv3imVSDVBi8H6TblUsXIQ2t7l3Hpc7Vu6Y8Zmg
 SyP+3KoWw88g==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455965847"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:49:33 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/1] ACPICA: Add SVKL table headers
Date:   Thu, 22 Apr 2021 14:49:30 -0700
Message-Id: <20210422214930.716596-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
---
 include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d6478c430c99..83a9d8b68e3a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -43,6 +43,7 @@
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
+#define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
@@ -1713,6 +1714,35 @@ struct acpi_sdev_pcie_path {
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
2.25.1

