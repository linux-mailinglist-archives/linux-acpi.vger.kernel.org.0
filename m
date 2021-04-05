Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95E354852
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhDEVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:26882 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241762AbhDEVuI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:08 -0400
IronPort-SDR: kcqsJqfwnTv5Ya4B/orws3RGmYvUSYzPK52QUjGAy75B4z/pTEub+CK6TMFUUh8to8+YHBcZ9I
 v/yifJGl8hFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278755"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278755"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: y1XqeLwMbBji8FV15pGvPlryzKK2V4EU/n2dVZxqYCyZ/7qCnaEuyNJyQdyp9iFZOoYNM12kau
 v3KO0zhxX4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673588"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 05/22] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
Date:   Mon,  5 Apr 2021 14:14:53 -0700
Message-Id: <20210405211510.484603-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

