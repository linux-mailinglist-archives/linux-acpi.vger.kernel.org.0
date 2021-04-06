Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3631C355E65
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhDFWFW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDFWFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:19 -0400
IronPort-SDR: lORqf7O/SSTvPaVHbrTxhAskMx85KuIV8pVWr58YBieuGwfyqSj42zZY0iz/yyjZYE1eWH7O58
 GSqJbmU1snwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640458"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640458"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: iKTfv+OVDGib9C13q8krSM3Ynxew8CJM3k6mPKo9v3z/bd79M3AqtNFHkmOPF0sXFmnamE1HAZ
 OY1b4xM1QVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581723"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 05/22] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
Date:   Tue,  6 Apr 2021 14:30:11 -0700
Message-Id: <20210406213028.718796-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit b9eb6f3a19b816824d6f47a6bc86fd8ce690e04b

Link: https://github.com/acpica/acpica/commit/b9eb6f3a
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d1178427aa40..c91be6f04fa6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -531,7 +531,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
-	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
+	ACPI_MADT_TYPE_MULTIPROC_WAKEUP = 16,
+	ACPI_MADT_TYPE_RESERVED = 17	/* 17 and greater are reserved */
 };
 
 /*
@@ -738,6 +739,15 @@ struct acpi_madt_generic_translator {
 	u32 reserved2;
 };
 
+/* 16: Multiprocessor wakeup (ACPI 6.4) */
+
+struct acpi_madt_multiproc_wakeup {
+	struct acpi_subtable_header header;
+	u16 mailbox_version;
+	u32 reserved;		/* reserved - must be zero */
+	u64 base_address;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.29.2

