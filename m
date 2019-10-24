Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78194E3BD6
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392913AbfJXTNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:13:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:56945 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392897AbfJXTNo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:13:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="188686266"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 12:13:43 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 02/12] ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
Date:   Thu, 24 Oct 2019 11:55:46 -0700
Message-Id: <20191024185556.4606-3-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7bc16c650317001bc82d4bae227b888a49c51f5e

Avoid possible overflow from get_tick_count. Also, cast math
using ACPI_100NSEC_PER_MSEC to uint64.

Link: https://github.com/acpica/acpica/commit/7bc16c65
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dscontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 4847f89c678c..5034fab9cf69 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -85,7 +85,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 		    walk_state->parser_state.pkg_end;
 		control_state->control.opcode = op->common.aml_opcode;
 		control_state->control.loop_timeout = acpi_os_get_timer() +
-		    (u64)(acpi_gbl_max_loop_iterations * ACPI_100NSEC_PER_SEC);
+		    ((u64)acpi_gbl_max_loop_iterations * ACPI_100NSEC_PER_SEC);
 
 		/* Push the control state on this walk's control stack */
 
-- 
2.21.0

