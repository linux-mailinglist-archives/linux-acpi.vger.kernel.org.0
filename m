Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D11EECCE
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFDVIg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 17:08:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:13291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgFDVIg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jun 2020 17:08:36 -0400
IronPort-SDR: tqb5MHdu9ht0KB3illx2SG8Sh4DGdg2arIti90rPwaEXDnZXB+3EP7xAr30IAyvsYFdxhvckUl
 vK2jGJnkLT+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:08:35 -0700
IronPort-SDR: t7sADnaX4Vsjau0OGhS2w0Y2l9CM5/TiWGJl8wwWIzrPQdtZUDZM3JD3WRpD/bpA5IpeieTHiK
 x0CNRsAW+VFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="287510474"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2020 14:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/3] ACPICA: iASL: add new OperationRegion subtype keyword PlatformRtMechanism
Date:   Thu,  4 Jun 2020 13:44:20 -0700
Message-Id: <20200604204421.592003-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604204421.592003-1-erik.kaneda@intel.com>
References: <20200604204421.592003-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 2c2eefa827bd37297f5f9ca4b263fcba829aaf3f

Link: https://github.com/acpica/acpica/commit/2c2eefa8
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbdisply.c | 2 ++
 drivers/acpi/acpica/utdecode.c | 3 ++-
 include/acpi/actypes.h         | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index f2df416d0d2d..d41eb9e67500 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -51,6 +51,8 @@ static acpi_adr_space_type acpi_gbl_space_id_list[] = {
 	ACPI_ADR_SPACE_IPMI,
 	ACPI_ADR_SPACE_GPIO,
 	ACPI_ADR_SPACE_GSBUS,
+	ACPI_ADR_SPACE_PLATFORM_COMM,
+	ACPI_ADR_SPACE_PLATFORM_RT,
 	ACPI_ADR_SPACE_DATA_TABLE,
 	ACPI_ADR_SPACE_FIXED_HARDWARE
 };
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 177ab88d95de..ed9aedf604a1 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -78,7 +78,8 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"IPMI",			/* 0x07 */
 	"GeneralPurposeIo",	/* 0x08 */
 	"GenericSerialBus",	/* 0x09 */
-	"PCC"			/* 0x0A */
+	"PCC",			/* 0x0A */
+	"PlatformRtMechanism"	/* 0x0B */
 };
 
 const char *acpi_ut_get_region_name(u8 space_id)
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4defed58ea33..aa236b9e6f24 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -815,8 +815,9 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_GPIO             (acpi_adr_space_type) 8
 #define ACPI_ADR_SPACE_GSBUS            (acpi_adr_space_type) 9
 #define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10
+#define ACPI_ADR_SPACE_PLATFORM_RT      (acpi_adr_space_type) 11
 
-#define ACPI_NUM_PREDEFINED_REGIONS     11
+#define ACPI_NUM_PREDEFINED_REGIONS     12
 
 /*
  * Special Address Spaces
-- 
2.25.1

