Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9013318D863
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Mar 2020 20:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTT2N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Mar 2020 15:28:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:32545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTT2N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Mar 2020 15:28:13 -0400
IronPort-SDR: QGMDbq2j2oV/5Fm3JJN9HYNEL5TqSf4U63TRwArg4/xProb2Sch0ifl+C+5FB70dGv0H91GlAB
 orQz8sx3LrLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 12:28:12 -0700
IronPort-SDR: Yetx+1ziaSCB5Y1zU6AmK+/oXrtZVEj07pPS9ynG1p+MBVtT8mt9WCMYXJpLL9+i+N9hnqj4Vq
 qKEP38mY9BNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="280521980"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2020 12:28:09 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, erik.schmauss@intel.com,
        lenb@kernel.org, rafael@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RESEND PATCH] acpi: Add NHLT table signature
Date:   Fri, 20 Mar 2020 20:27:27 +0100
Message-Id: <20200320192727.20560-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

NHLT (Non-HDAudio Link Table) provides configuration of audio
endpoints for Intel SST (Smart Sound Technology) DSP products. Similarly
to other ACPI tables, data provided by BIOS may not describe it
correctly, thus overriding is required.

ACPI override mechanism checks for unknown signature before proceeding.
Update known signatures array to support NHLT.

Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
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
index e45ced27f4c3..876ccf50ec36 100644
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
2.17.1

