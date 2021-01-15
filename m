Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419092F854C
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbhAOTWd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 14:22:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:59297 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAOTWc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:22:32 -0500
IronPort-SDR: WyjCPt8hNtIoulRxocWJVH7MB1ULOhc0UqRQVgaGbdhSc+ZfvtMZiebKwWNKELqIEVA8ztiZ3F
 hOEwzg5BZQpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="240139537"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="240139537"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:20:55 -0800
IronPort-SDR: IVMuUKZ1r2hzzugoY0wl+MTvYtlIcjwFkrauizVlZpzpjlHv0SQjSZ/LD39jL7e0TnVm1/8vRW
 yRgjA6FgUQ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="425417899"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 11:20:55 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Al Stone <ahs3@ahs3.net>, Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 6/9] ACPICA: Remove the MTMR (Mid-Timer) table
Date:   Fri, 15 Jan 2021 10:48:23 -0800
Message-Id: <20210115184826.2250-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115184826.2250-1-erik.kaneda@intel.com>
References: <20210115184826.2250-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Al Stone <ahs3@ahs3.net>

ACPICA commit 2c39dcccda4dc250a44379ae086b8b1a3fdad115

This table is no longer in use, and is not officially defined
in the ACPI specification.

Link: https://github.com/acpica/acpica/commit/2c39dccc
Signed-off-by: Al Stone <ahs3@ahs3.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ec66779cb193..94bfc0c2a893 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -33,7 +33,6 @@
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
-#define ACPI_SIG_MTMR           "MTMR"	/* MID Timer table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
 #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
 #define ACPI_SIG_PDTT           "PDTT"	/* Platform Debug Trigger Table */
@@ -935,29 +934,6 @@ struct acpi_table_msdm {
 	struct acpi_table_header header;	/* Common ACPI table header */
 };
 
-/*******************************************************************************
- *
- * MTMR - MID Timer Table
- *        Version 1
- *
- * Conforms to "Simple Firmware Interface Specification",
- * Draft 0.8.2, Oct 19, 2010
- * NOTE: The ACPI MTMR is equivalent to the SFI MTMR table.
- *
- ******************************************************************************/
-
-struct acpi_table_mtmr {
-	struct acpi_table_header header;	/* Common ACPI table header */
-};
-
-/* MTMR entry */
-
-struct acpi_mtmr_entry {
-	struct acpi_generic_address physical_address;
-	u32 frequency;
-	u32 irq;
-};
-
 /*******************************************************************************
  *
  * NFIT - NVDIMM Interface Table (ACPI 6.0+)
-- 
2.29.2

