Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB1123609
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLQTzB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 14:55:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:56006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLQTzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:55:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217624415"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 11:54:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/5] ACPICA: debugger: fix spelling mistake "adress" -> "address"
Date:   Tue, 17 Dec 2019 11:35:19 -0800
Message-Id: <20191217193523.20204-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217193523.20204-1-erik.kaneda@intel.com>
References: <20191217193523.20204-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 7aa72c5fdf75c5b80adf758980e06bcafb7f8670

There is a spelling mistake in an error message. Fix it.

Link: https://github.com/acpica/acpica/commit/7aa72c5f
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dbinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index e1632b340182..aa71f65395d2 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -816,7 +816,7 @@ acpi_db_command_dispatch(char *input_buffer,
 		if (ACPI_FAILURE(status)
 		    || temp64 >= ACPI_NUM_PREDEFINED_REGIONS) {
 			acpi_os_printf
-			    ("Invalid adress space ID: must be between 0 and %u inclusive\n",
+			    ("Invalid address space ID: must be between 0 and %u inclusive\n",
 			     ACPI_NUM_PREDEFINED_REGIONS - 1);
 			return (AE_OK);
 		}
-- 
2.21.0

