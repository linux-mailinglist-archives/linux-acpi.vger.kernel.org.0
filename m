Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D922AE5638
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJYVy4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:27339 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfJYVyz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936059"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:51 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 11/12] ACPICA: debugger: remove leading whitespaces when converting a string to a buffer
Date:   Fri, 25 Oct 2019 14:36:59 -0700
Message-Id: <20191025213700.14685-12-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025213700.14685-1-erik.schmauss@intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 1b7228072f254a5b02625586ff7d561757b7fc2d

By removing leading whitespaces, the conversion computes the
correct number of elements in a given buffer or field encoding that
contains leading whitespaces.

Link: https://github.com/acpica/acpica/commit/1b722807
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbconvert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 9fd9a98a9cbe..2b84ac093698 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -106,6 +106,10 @@ acpi_db_convert_to_buffer(char *string, union acpi_object *object)
 	u8 *buffer;
 	acpi_status status;
 
+	/* Skip all preceding white space */
+
+	acpi_ut_remove_whitespace(&string);
+
 	/* Generate the final buffer length */
 
 	for (i = 0, length = 0; string[i];) {
-- 
2.21.0

