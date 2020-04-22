Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE91B38D4
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Apr 2020 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgDVHWo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Apr 2020 03:22:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVHWo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Apr 2020 03:22:44 -0400
IronPort-SDR: DW72mMAaUbwAXkUm0t6IJ5tZarEEjNAq+uHj+TqifR8tNoiMAyAZSlchsH62FfN2kq+FzpDxJN
 fUbyx9SZPIPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 00:22:43 -0700
IronPort-SDR: fiT0mkFU71ax0a149oxd1WlMhZqTljfj78m6jFNPGJvnzJfmEXkg4XeO/4/j+BpsPB38rjD5QW
 RAr3T96ZXMGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="429813447"
Received: from power-sh.sh.intel.com ([10.239.48.5])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 00:22:42 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: processor: allowing probing on platforms with one ACPI C-state
Date:   Wed, 22 Apr 2020 15:26:07 +0800
Message-Id: <20200422072607.18179-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is possible for ACPI _CST to return only one ACPI C-state, for
example, when deep cstate disabled in the BIOS.
And it is better for the acpi_idle driver to probe in this case as well
for consistency.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_idle.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dcc289e30166..75534c5b5433 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -308,11 +308,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 	if (ret)
 		return ret;
 
-	/*
-	 * It is expected that there will be at least 2 states, C1 and
-	 * something else (C2 or C3), so fail if that is not the case.
-	 */
-	if (pr->power.count < 2)
+	if (!pr->power.count)
 		return -EFAULT;
 
 	pr->flags.has_cst = 1;
@@ -468,8 +464,7 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		if (pr->power.states[i].valid) {
 			pr->power.count = i;
-			if (pr->power.states[i].type >= ACPI_STATE_C2)
-				pr->flags.power = 1;
+			pr->flags.power = 1;
 		}
 	}
 
-- 
2.17.1

