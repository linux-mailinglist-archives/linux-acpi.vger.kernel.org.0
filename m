Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03144D58
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfFMUYp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 16:24:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41953 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfFMUYp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 16:24:45 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a46fe18529be701e; Thu, 13 Jun 2019 22:24:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Furquan Shaikh <furquan@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com
Subject: Re: [PATCH] ACPI: PM: Clear wake-up device GPEs before enabling
Date:   Thu, 13 Jun 2019 22:24:41 +0200
Message-ID: <13361760.nMXA0SR1Mq@kreacher>
In-Reply-To: <20190516193616.252788-1-furquan@google.com>
References: <20190516193616.252788-1-furquan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, May 16, 2019 9:36:16 PM CEST Furquan Shaikh wrote:
> This change clears GPE status for wake-up devices before enabling that
> GPE. This is required to ensure that stale GPE status does
> not result in pre-mature wake on enabling GPE for wake-up devices.
> 
> Without this change, here is the sequence of events that is causing
> suspend aborts on recent chrome books:
> 
> 1. System decides to enter sleep.
> 2. All devices in the system are put into low power mode.
> 3. This results in acpi_dev_suspend being called for each ACPI
> device.
> 4. If the device is wake capable, then acpi_dev_suspend calls
> acpi_device_wakeup_enable to enable GPE for the device.
> 5. If GPE status is already set, enabling GPE for the wakeup device
> results in generating a SCI which is handled by acpi_ev_detect_gpe
> ultimately calling wakeup_source_activate that increments wakeup
> events, and thus aborting the suspend attempt.
> 
> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
>  drivers/acpi/device_pm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index b859d75eaf9f6..e05ee3ff45683 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -721,6 +721,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>  	if (error)
>  		goto out;
>  
> +	acpi_clear_gpe(wakeup->gpe_device, wakeup->gpe_number);
> +
>  	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_disable_wakeup_device_power(adev);
> 

This patch may cause events to be missed if the GPE.  I guess what you reall mean is
something like the patch below.

This should allow the kernel to see the events generated before the GPEs are
implicitly enabled, but it should clear them for the explicit users of acpi_enable_gpe().

Mika, what do you think?

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
 



