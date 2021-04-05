Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91C9354853
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhDEVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:26874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241797AbhDEVuJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:09 -0400
IronPort-SDR: cUiJhszA85dOZhzhCOYEa86dwjhrtKgubhFeT7CBNOFXxayngIwcAAQQ22nTVWEk5T6rkuWgOF
 ZTiHnE8H3xhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278756"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278756"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: WjmuH0O79YKMTtfdo+5OPS5Phk/P0gPLvteke+GE0erkhzTQhfu+ZB6W5CSy3yJtUV6WER7NST
 nXLuReQ6CoMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673582"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 01/22] ACPICA: Add parsing for IVRS IVHD 40h and device entry F0h
Date:   Mon,  5 Apr 2021 14:14:49 -0700
Message-Id: <20210405211510.484603-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

