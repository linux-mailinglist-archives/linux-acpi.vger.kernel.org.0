Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941C355E64
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhDFWFV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240277AbhDFWFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:18 -0400
IronPort-SDR: Ct+hqLldQVS6jESZThyw9aUk9FZ4fwZbwKN7q4uD+aRkr236mtOFTEpvAOC6wKiwMC6iOWkyC/
 j+3bQDscb3hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640457"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: BokW5hts6I3vx+9YvYW8+1+Wi3VggseFsFRzTxx/h+Gf40HciVce7P9G6/JgmwOs93DfmiyV4s
 Tr3xInh44FVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581713"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 01/22] ACPICA: Add parsing for IVRS IVHD 40h and device entry F0h
Date:   Tue,  6 Apr 2021 14:30:07 -0700
Message-Id: <20210406213028.718796-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Alexander Monakov <amonakov@ispras.ru>

ACPICA commit eefb865355514048380d921de5efcf30027d6b02

IVHD type 40h uses the same field layout as type 11h, but adds support
for a new device entry type F0h (ACPI HID device entry). The new device
entry type has variable length: after fixed-length fields occupying 22
bytes, there's a field of length up to 255 (as given by the preceding
field).

Link: https://github.com/acpica/acpica/commit/eefb8653
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d6478c430c99..d1178427aa40 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -276,6 +276,7 @@ struct acpi_ivrs_header {
 enum acpi_ivrs_type {
 	ACPI_IVRS_TYPE_HARDWARE1 = 0x10,
 	ACPI_IVRS_TYPE_HARDWARE2 = 0x11,
+	ACPI_IVRS_TYPE_HARDWARE3 = 0x40,
 	ACPI_IVRS_TYPE_MEMORY1 = 0x20,
 	ACPI_IVRS_TYPE_MEMORY2 = 0x21,
 	ACPI_IVRS_TYPE_MEMORY3 = 0x22
@@ -364,7 +365,11 @@ enum acpi_ivrs_device_entry_type {
 	ACPI_IVRS_TYPE_ALIAS_START = 67,	/* Uses struct acpi_ivrs_device8a */
 	ACPI_IVRS_TYPE_EXT_SELECT = 70,	/* Uses struct acpi_ivrs_device8b */
 	ACPI_IVRS_TYPE_EXT_START = 71,	/* Uses struct acpi_ivrs_device8b */
-	ACPI_IVRS_TYPE_SPECIAL = 72	/* Uses struct acpi_ivrs_device8c */
+	ACPI_IVRS_TYPE_SPECIAL = 72,	/* Uses struct acpi_ivrs_device8c */
+
+	/* Variable-length device entries */
+
+	ACPI_IVRS_TYPE_HID = 240	/* Uses ACPI_IVRS_DEVICE_HID */
 };
 
 /* Values for Data field above */
@@ -416,6 +421,16 @@ struct acpi_ivrs_device8c {
 #define ACPI_IVHD_IOAPIC            1
 #define ACPI_IVHD_HPET              2
 
+/* Type 240: variable-length device entry */
+
+struct acpi_ivrs_device_hid {
+	struct acpi_ivrs_de_header header;
+	u64 acpi_hid;
+	u64 acpi_cid;
+	u8 uid_type;
+	u8 uid_length;
+};
+
 /* 0x20, 0x21, 0x22: I/O Virtualization Memory Definition Block (IVMD) */
 
 struct acpi_ivrs_memory {
-- 
2.29.2

