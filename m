Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B2172B06
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgB0WZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 17:25:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61730 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgB0WZV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Feb 2020 17:25:21 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id af15a1c3c8096ed7; Thu, 27 Feb 2020 23:25:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 3/6] ACPI: EC: Drop AE_NOT_FOUND special case from ec_install_handlers()
Date:   Thu, 27 Feb 2020 23:22:33 +0100
Message-ID: <3205130.aMxiE8xfpn@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
References: <2094703.CetWLLyMuz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

If the status value returned by acpi_install_address_space_handler()
in ec_install_handlers() is AE_NOT_FOUND, it is treated in a special
way, apparently because it might mean a _REG method evaluation
failure (at least that is the case according to the comment in
there), but acpi_install_address_space_handler() does not take
_REG evaluation errors into account at all, so the AE_NOT_FOUND
special handling is confusing at best.

For this reason, change ec_install_handlers() to stop the EC and
return -ENODEV on all acpi_install_address_space_handler() errors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3153e7684053..6f501d552e6e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1489,19 +1489,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 							    &acpi_ec_space_handler,
 							    NULL, ec);
 		if (ACPI_FAILURE(status)) {
-			if (status == AE_NOT_FOUND) {
-				/*
-				 * Maybe OS fails in evaluating the _REG
-				 * object. The AE_NOT_FOUND error will be
-				 * ignored and OS * continue to initialize
-				 * EC.
-				 */
-				pr_err("Fail in evaluating the _REG object"
-					" of EC device. Broken bios is suspected.\n");
-			} else {
-				acpi_ec_stop(ec, false);
-				return -ENODEV;
-			}
+			acpi_ec_stop(ec, false);
+			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
-- 
2.16.4





