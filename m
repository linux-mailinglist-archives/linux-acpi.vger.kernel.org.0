Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0EC354856
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbhDEVuN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:26877 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241844AbhDEVuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:11 -0400
IronPort-SDR: j0tT4v8sv3JZKFMM+aLGLQZDtG25w0gaiNwWssI5yZWMQT9mbkEL0IpbGfG/lkZWW6C7NENRCO
 4I22y/JSOE3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278758"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278758"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: 12x/2u4Cls0EqXhS/PNLWvlTxeAtVoFaQ4LjgYkK1LNdOCWqgRiC1fB4BH7191gOZE/u/8acEC
 GYTuMY9fit2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673591"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 06/22] ACPICA: ACPI 6.4: PCCT: add support for subtable type 5
Date:   Mon,  5 Apr 2021 14:14:54 -0700
Message-Id: <20210405211510.484603-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

