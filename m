Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A890390A8D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHPV6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:56320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfHPV6c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381371"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:31 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 1/9] ACPICA: Debugger: remove redundant assignment on obj_desc
Date:   Fri, 16 Aug 2019 14:43:20 -0700
Message-Id: <20190816214328.3900-2-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit f530f1acb3128136ad97c715fdaebbbeff283ee2

Pointer obj_desc is being initialized with a value that is never
read and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")

Link: https://github.com/acpica/acpica/commit/f530f1ac
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dbobject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index d220168dca01..f9fc84bc3e84 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -394,7 +394,6 @@ void acpi_db_decode_locals(struct acpi_walk_state *walk_state)
 	u8 display_locals = FALSE;
 
 	node = walk_state->method_node;
-	obj_desc = walk_state->method_desc;
 
 	/* There are no locals for the module-level code case */
 
-- 
2.17.2

