Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D6196168
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0WnO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgC0WnN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:13 -0400
IronPort-SDR: DbflW9P+XthKmPAkm439qzfj0dBf8tqqaTBsqtW0fn0yQE8PA0YWhp68gmvUP52S2oiHAG4/sK
 6lInrdfsfpIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:13 -0700
IronPort-SDR: 1gZDFL2m1GieZwiLy9eXk4gxYHCUjfC/aJi929aNK5zmOQa2kUQ21KlZjIzRytq899pn9FCQyI
 +jY7qmyQZXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051987"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:12 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 08/10] ACPICA: Add NHLT table signature
Date:   Fri, 27 Mar 2020 15:21:08 -0700
Message-Id: <20200327222110.1204634-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

ACPICA commit 422166b656565d180bb3aac712009bdce5e70cdd

NHLT (Non-HDAudio Link Table) provides configuration of audio
endpoints for Intel SST (Smart Sound Technology) DSP products.
Similarly to other ACPI tables, data provided by BIOS may not
describe it correctly, thus overriding is required.

ACPI override mechanism checks for unknown signature before
proceeding. Update known signatures array to support NHLT.

Link: https://github.com/acpica/acpica/commit/422166b6
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/tables.c | 2 +-
 include/acpi/actbl2.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 180ac4329763..0e905c3d1645 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -501,7 +501,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	NULL };
+	ACPI_SIG_NHLT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2175b3f84f02..ec66779cb193 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -43,6 +43,7 @@
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
+#define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
-- 
2.25.1

