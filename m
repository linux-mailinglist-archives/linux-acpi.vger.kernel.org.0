Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3127915F66A
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgBNTI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:26795 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388099AbgBNTI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702896"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 05/10] ACPICA: Table Manager: Update comments in a function header
Date:   Fri, 14 Feb 2020 10:47:59 -0800
Message-Id: <20200214184804.15114-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Update acpi_get_table_header to remove text stating that the caller
must unmap any returned memory.

ACPICA commit 4f3a235cf0044b2d91958b1f99b4ca824c63f948

Link: https://github.com/acpica/acpica/commit/4f3a235c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/tbxface.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index f8403d480318..7490429ddbf6 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -202,14 +202,14 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_reallocate_root_table)
  *
  * PARAMETERS:  signature           - ACPI signature of needed table
  *              instance            - Which instance (for SSDTs)
- *              out_table_header    - The pointer to the table header to fill
+ *              out_table_header    - The pointer to the where the table header
+ *                                    is returned
  *
- * RETURN:      Status and pointer to mapped table header
+ * RETURN:      Status and a copy of the table header
  *
- * DESCRIPTION: Finds an ACPI table header.
- *
- * NOTE:        Caller is responsible in unmapping the header with
- *              acpi_os_unmap_memory
+ * DESCRIPTION: Finds and returns an ACPI table header. Caller provides the
+ *              memory where a copy of the header is to be returned
+ *              (fixed length).
  *
  ******************************************************************************/
 acpi_status
-- 
2.21.0

