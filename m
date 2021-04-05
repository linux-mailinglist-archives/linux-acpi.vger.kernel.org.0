Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74615354854
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbhDEVuM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:38284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241727AbhDEVuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:11 -0400
IronPort-SDR: Sd9y41enHBWjTBmfORbBqcNeNekZE/LolPSnNVi1EuB7SeLBtnRLuGDwinOOfnlqPCwALuDHjT
 RVsKPgExxrnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914968"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914968"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: eI18sQmY4vjLHOJ7SZcZc8z6myFqjyRxNmO2hAaESXrNTwW8IKLL6vcbFgbQ0YAtB5HeOotmVF
 EhCFZf9Gkfsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673604"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 10/22] ACPICA: ACPI 6.4: HMAT: add new fields/flags
Date:   Mon,  5 Apr 2021 14:14:58 -0700
Message-Id: <20210405211510.484603-11-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 18a77ca6fc3edd26a24d8f32ae5c0ea66d84ccff

Link: https://github.com/acpica/acpica/commit/18a77ca6
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl1.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index af0a8c3b87b7..2ee7eeea783b 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1445,7 +1445,8 @@ struct acpi_hmat_locality {
 	struct acpi_hmat_structure header;
 	u8 flags;
 	u8 data_type;
-	u16 reserved1;
+	u8 min_transfer_size;
+	u8 reserved1;
 	u32 number_of_initiator_Pds;
 	u32 number_of_target_Pds;
 	u32 reserved2;
@@ -1454,15 +1455,18 @@ struct acpi_hmat_locality {
 
 /* Masks for Flags field above */
 
-#define ACPI_HMAT_MEMORY_HIERARCHY  (0x0F)
+#define ACPI_HMAT_MEMORY_HIERARCHY  (0x0F)     /* Bits 0-3 */
 
-/* Values for Memory Hierarchy flag */
+/* Values for Memory Hierarchy flags */
 
 #define ACPI_HMAT_MEMORY            0
 #define ACPI_HMAT_LAST_LEVEL_CACHE  1
 #define ACPI_HMAT_1ST_LEVEL_CACHE   2
 #define ACPI_HMAT_2ND_LEVEL_CACHE   3
 #define ACPI_HMAT_3RD_LEVEL_CACHE   4
+#define ACPI_HMAT_MINIMUM_XFER_SIZE 0x10       /* Bit 4: ACPI 6.4 */
+#define ACPI_HMAT_NON_SEQUENTIAL_XFERS 0x20    /* Bit 5: ACPI 6.4 */
+
 
 /* Values for data_type field above */
 
-- 
2.29.2

