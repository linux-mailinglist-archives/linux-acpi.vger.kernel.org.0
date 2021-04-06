Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9060355E67
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbhDFWF1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242421AbhDFWFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:19 -0400
IronPort-SDR: zyUyoteabYAzGOnhYZTuQ+CqwuO5Y0YzwHKjOKTWH4fAg42YBUOeGkLaPnTqNVx2LZq93B2awK
 6EEm9geUF6zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640459"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: /QyGjzFjvgD3ZbJ02PMPHzercPAnHophnlaHlolc5FIokjVmsPqufbd/ebWp/xdvbWJzuO/Rwm
 2AwycoWZS9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581726"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 06/22] ACPICA: ACPI 6.4: PCCT: add support for subtable type 5
Date:   Tue,  6 Apr 2021 14:30:12 -0700
Message-Id: <20210406213028.718796-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 208d7e27ebc473feb4182cc8e58f3789c4efaca6

Link: https://github.com/acpica/acpica/commit/208d7e27
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c91be6f04fa6..9c674e03eb05 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1209,7 +1209,8 @@ enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2 = 2,	/* ACPI 6.1 */
 	ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE = 3,	/* ACPI 6.2 */
 	ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE = 4,	/* ACPI 6.2 */
-	ACPI_PCCT_TYPE_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_PCCT_TYPE_HW_REG_COMM_SUBSPACE = 5,	/* ACPI 6.4 */
+	ACPI_PCCT_TYPE_RESERVED = 6	/* 6 and greater are reserved */
 };
 
 /*
@@ -1324,6 +1325,24 @@ struct acpi_pcct_ext_pcc_slave {
 	u64 error_status_mask;
 };
 
+/* 5: HW Registers based Communications Subspace */
+
+struct acpi_pcct_hw_reg {
+	struct acpi_subtable_header header;
+	u16 version;
+	u64 base_address;
+	u64 length;
+	struct acpi_generic_address doorbell_register;
+	u64 doorbell_preserve;
+	u64 doorbell_write;
+	struct acpi_generic_address cmd_complete_register;
+	u64 cmd_complete_mask;
+	struct acpi_generic_address error_status_register;
+	u64 error_status_mask;
+	u32 nominal_latency;
+	u32 min_turnaround_time;
+};
+
 /* Values for doorbell flags above */
 
 #define ACPI_PCCT_INTERRUPT_POLARITY    (1)
-- 
2.29.2

