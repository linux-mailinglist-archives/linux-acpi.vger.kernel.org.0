Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB352C14B6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgKWTrt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 14:47:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62098 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbgKWTrs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 14:47:48 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id b6a2e1692c11dd0a; Mon, 23 Nov 2020 20:41:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ACPI: EC: Rename acpi_ec_is_gpe_raised()
Date:   Mon, 23 Nov 2020 20:37:46 +0100
Message-ID: <2429516.i4tuDyKFJZ@kreacher>
In-Reply-To: <3259005.CeRvrUlyd7@kreacher>
References: <3259005.CeRvrUlyd7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Rename acpi_ec_is_gpe_raised() into acpi_ec_gpe_status_set(),
update its callers accordingly and drop the ternary operator
(which isn't really necessary in there) from it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 97e595238a8c..c4be16a495e1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -335,12 +335,12 @@ static const char *acpi_ec_cmd_string(u8 cmd)
  *                           GPE Registers
  * -------------------------------------------------------------------------- */
 
-static inline bool acpi_ec_is_gpe_raised(struct acpi_ec *ec)
+static inline bool acpi_ec_gpe_status_set(struct acpi_ec *ec)
 {
 	acpi_event_status gpe_status = 0;
 
 	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
-	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
+	return !!(gpe_status & ACPI_EVENT_FLAG_STATUS_SET);
 }
 
 static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
@@ -351,7 +351,7 @@ static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
 		BUG_ON(ec->reference_count < 1);
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
 	}
-	if (acpi_ec_is_gpe_raised(ec)) {
+	if (acpi_ec_gpe_status_set(ec)) {
 		/*
 		 * On some platforms, EN=1 writes cannot trigger GPE. So
 		 * software need to manually trigger a pseudo GPE event on
@@ -635,7 +635,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 	 * 2. As long as software can ensure only clearing it when it is set,
 	 *    hardware won't set it in parallel.
 	 */
-	if (ec->gpe >= 0 && acpi_ec_is_gpe_raised(ec))
+	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
 		acpi_clear_gpe(NULL, ec->gpe);
 
 	status = acpi_ec_read_status(ec);
-- 
2.26.2




