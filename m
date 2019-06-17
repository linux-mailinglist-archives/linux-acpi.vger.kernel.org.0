Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05746480B8
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfFQLbt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 07:31:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59468 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLbt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2019 07:31:49 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4c77d97a5198814f; Mon, 17 Jun 2019 13:31:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH] ACPICA: Clear status of GPEs on first direct enable
Date:   Mon, 17 Jun 2019 13:31:45 +0200
Message-ID: <3650147.WZ2HLy2X9i@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI GPEs (other than the EC one) can be enabled in two situations.
First, the GPEs with existing _Lxx and _Exx methods are enabled
implicitly by ACPICA during system initialization.  Second, the
GPEs without these methods (like GPEs listed by _PRW objects for
wakeup devices) need to be enabled directly by the code that is
going to use them (e.g. ACPI power management or device drivers).

In the former case, if the status of a given GPE is set to start
with, its handler method (either _Lxx or _Exx) needs to be invoked
to take care of the events (possibly) signaled before the GPE was
enabled.  In the latter case, however, the first caller of
acpi_enable_gpe() for a given GPE should not be expected to care
about any events that might be signaled through it earlier.  In
that case, it is better to clear the status of the GPE before
enabling it, to prevent stale events from triggering unwanted
actions (like spurious system resume, for example).

For this reason, modify acpi_ev_add_gpe_reference() to take an
additional boolean argument indicating whether or not the GPE
status needs to be cleared when its reference counter changes from
zero to one and make acpi_enable_gpe() pass TRUE to it through
that new argument.

Fixes: 18996f2db918 ("ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume")
Reported-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@google.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acevents.h |    3 ++-
 drivers/acpi/acpica/evgpe.c    |    8 +++++++-
 drivers/acpi/acpica/evgpeblk.c |    2 +-
 drivers/acpi/acpica/evxface.c  |    2 +-
 drivers/acpi/acpica/evxfgpe.c  |    2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/acevents.h
+++ linux-pm/drivers/acpi/acpica/acevents.h
@@ -69,7 +69,8 @@ acpi_status
 acpi_ev_mask_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 is_masked);
 
 acpi_status
-acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
+acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info,
+			  u8 clear_on_enable);
 
 acpi_status
 acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
Index: linux-pm/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpe.c
+++ linux-pm/drivers/acpi/acpica/evgpe.c
@@ -146,6 +146,7 @@ acpi_ev_mask_gpe(struct acpi_gpe_event_i
  * FUNCTION:    acpi_ev_add_gpe_reference
  *
  * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
+ *              clear_on_enable         - Clear GPE status before enabling it
  *
  * RETURN:      Status
  *
@@ -155,7 +156,8 @@ acpi_ev_mask_gpe(struct acpi_gpe_event_i
  ******************************************************************************/
 
 acpi_status
-acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
+acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info,
+			  u8 clear_on_enable)
 {
 	acpi_status status = AE_OK;
 
@@ -170,6 +172,10 @@ acpi_ev_add_gpe_reference(struct acpi_gp
 
 		/* Enable on first reference */
 
+		if (clear_on_enable) {
+			(void)acpi_hw_clear_gpe(gpe_event_info);
+		}
+
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
 			status = acpi_ev_enable_gpe(gpe_event_info);
Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-pm/drivers/acpi/acpica/evgpeblk.c
@@ -453,7 +453,7 @@ acpi_ev_initialize_gpe_block(struct acpi
 				continue;
 			}
 
-			status = acpi_ev_add_gpe_reference(gpe_event_info);
+			status = acpi_ev_add_gpe_reference(gpe_event_info, FALSE);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 					"Could not enable GPE 0x%02X",
Index: linux-pm/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxface.c
+++ linux-pm/drivers/acpi/acpica/evxface.c
@@ -971,7 +971,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	      ACPI_GPE_DISPATCH_METHOD) ||
 	     (ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
 	      ACPI_GPE_DISPATCH_NOTIFY)) && handler->originally_enabled) {
-		(void)acpi_ev_add_gpe_reference(gpe_event_info);
+		(void)acpi_ev_add_gpe_reference(gpe_event_info, FALSE);
 		if (ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
 
 			/* Poll edge triggered GPEs to handle existing events */
Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -108,7 +108,7 @@ acpi_status acpi_enable_gpe(acpi_handle
 	if (gpe_event_info) {
 		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 		    ACPI_GPE_DISPATCH_NONE) {
-			status = acpi_ev_add_gpe_reference(gpe_event_info);
+			status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
 			if (ACPI_SUCCESS(status) &&
 			    ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
 



