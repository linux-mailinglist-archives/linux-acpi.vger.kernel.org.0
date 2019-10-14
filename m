Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8EDD5DF5
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2019 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJNI4N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 04:56:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34110 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfJNI4M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2019 04:56:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so10032607pfa.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2019 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCKkCAhM/OfDBxe+1eOFpGsX1NE/9nuqX7GJgEbv/ww=;
        b=YGc8HNhMWwdbiSo3vpejn2A8USED7w0eu3Do5KM4FbbKNowBWNUXW2UjB99pYz7fyh
         nhM7rezaHbxwX/L679ReSbNV9b0ki3FoLG318aneX4HUXWshUweQUIVWz5zCMhOEw9Oy
         Db5l1DEf6trr+KRpbgfQ8rmjB8rJJkqXM7y2OSWFVy3wG+uh7vtjyueS4PfpnodRmNpE
         SgGzwD3ocdX8zfLDDGzgmc3t9aDQkZrcKFxzX8ypAWXwVDhoy3wDrlvPq7O70K8bqOca
         LnY5OoQAEIaGfaJc35VHxZbnIZjUlUVctzsQ41RkjJEArLjyJB2bUNS0YUfrHE3+eObE
         x+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCKkCAhM/OfDBxe+1eOFpGsX1NE/9nuqX7GJgEbv/ww=;
        b=aqHfOMoIP59JoQl3dVLVeaxh05wKysD9dezYqdBB+vhCTlr4IWni8akoSfLGAnmllx
         N4lsRt52jRlP0Y7kG5CLdLND5KCdzooUuv753LEABfu0PbzMdSmTC52aI0i9UbE30daj
         N7zWgR36fal1u2OotNElw9z6X7KJ8R+OxXdcT1qdAQoOCat7gSkQE7u2Qrt7vxEIRVKe
         68wVNIr/pKtGsxnHBdJrDz7Bb/KI5B7lyx/E4XKjlL/Em2BlOwzhHBN8b0zpCl9uSkIM
         K2YQjU/R8HA/3vAkn44JWWJeo65i3TP1OJ7NFW7N6wB8O8z3EtngVPtCAHAlapaw2PyD
         m/oQ==
X-Gm-Message-State: APjAAAULUbu35bEW8UyIkHPq3Y5ikT1S8sfx0WhU+77ZU4cyLQPNSXIF
        hkDNKo4k93uWyp2AOypFn+qnfw==
X-Google-Smtp-Source: APXvYqzLcZTvMaINThJhH1NqRTa4h8ZK3ErBQO35RAJLYl4XXrHM0xJrP45DNbuCdccZEPPDq0cQmA==
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr33439504pju.3.1571043371666;
        Mon, 14 Oct 2019 01:56:11 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d14sm29701957pfh.36.2019.10.14.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:56:11 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 1/2] ACPI: EC: tweak naming in preparation for GpioInt support
Date:   Mon, 14 Oct 2019 16:56:01 +0800
Message-Id: <20191014085602.10644-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for supporting reduced hardware platforms which use a
GpioInt instead of a GPE, rename some functions and constants to have
more appropriate names. No logical changes.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/acpi/ec.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da1e5c5ce150..97e08d0e3192 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -95,12 +95,12 @@ enum {
 	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
-	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
+	EC_FLAGS_EVENT_HANDLER_INSTALLED,	/* Event handler installed */
 	EC_FLAGS_EC_HANDLER_INSTALLED,	/* OpReg handler installed */
-	EC_FLAGS_EVT_HANDLER_INSTALLED, /* _Qxx handlers installed */
+	EC_FLAGS_QUERY_METHODS_INSTALLED, /* _Qxx handlers installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
-	EC_FLAGS_GPE_MASKED,		/* GPE masked */
+	EC_FLAGS_EVENTS_MASKED,		/* Events masked */
 };
 
 #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte */
@@ -397,7 +397,7 @@ static inline void acpi_ec_clear_gpe(struct acpi_ec *ec)
 static void acpi_ec_submit_request(struct acpi_ec *ec)
 {
 	ec->reference_count++;
-	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags) &&
+	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags) &&
 	    ec->reference_count == 1)
 		acpi_ec_enable_gpe(ec, true);
 }
@@ -407,7 +407,7 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 	bool flushed = false;
 
 	ec->reference_count--;
-	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags) &&
+	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags) &&
 	    ec->reference_count == 0)
 		acpi_ec_disable_gpe(ec, true);
 	flushed = acpi_ec_flushed(ec);
@@ -415,19 +415,19 @@ static void acpi_ec_complete_request(struct acpi_ec *ec)
 		wake_up(&ec->wait);
 }
 
-static void acpi_ec_mask_gpe(struct acpi_ec *ec)
+static void acpi_ec_mask_events(struct acpi_ec *ec)
 {
-	if (!test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
+	if (!test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
 		acpi_ec_disable_gpe(ec, false);
 		ec_dbg_drv("Polling enabled");
-		set_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
+		set_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
 	}
 }
 
-static void acpi_ec_unmask_gpe(struct acpi_ec *ec)
+static void acpi_ec_unmask_events(struct acpi_ec *ec)
 {
-	if (test_bit(EC_FLAGS_GPE_MASKED, &ec->flags)) {
-		clear_bit(EC_FLAGS_GPE_MASKED, &ec->flags);
+	if (test_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags)) {
+		clear_bit(EC_FLAGS_EVENTS_MASKED, &ec->flags);
 		acpi_ec_enable_gpe(ec, false);
 		ec_dbg_drv("Polling disabled");
 	}
@@ -454,7 +454,7 @@ static bool acpi_ec_submit_flushable_request(struct acpi_ec *ec)
 
 static void acpi_ec_submit_query(struct acpi_ec *ec)
 {
-	acpi_ec_mask_gpe(ec);
+	acpi_ec_mask_events(ec);
 	if (!acpi_ec_event_enabled(ec))
 		return;
 	if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags)) {
@@ -470,7 +470,7 @@ static void acpi_ec_complete_query(struct acpi_ec *ec)
 	if (test_and_clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
 		ec_dbg_evt("Command(%s) unblocked",
 			   acpi_ec_cmd_string(ACPI_EC_COMMAND_QUERY));
-	acpi_ec_unmask_gpe(ec);
+	acpi_ec_unmask_events(ec);
 }
 
 static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
@@ -717,7 +717,7 @@ static void advance_transaction(struct acpi_ec *ec)
 				++t->irq_count;
 			/* Allow triggering on 0 threshold */
 			if (t->irq_count == ec_storm_threshold)
-				acpi_ec_mask_gpe(ec);
+				acpi_ec_mask_events(ec);
 		}
 	}
 out:
@@ -815,7 +815,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 
 	spin_lock_irqsave(&ec->lock, tmp);
 	if (t->irq_count == ec_storm_threshold)
-		acpi_ec_unmask_gpe(ec);
+		acpi_ec_unmask_events(ec);
 	ec_dbg_req("Command(%s) stopped", acpi_ec_cmd_string(t->command));
 	ec->curr = NULL;
 	/* Disable GPE for command processing (IBF=0/OBF=1) */
@@ -1456,20 +1456,20 @@ static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 	if (!handle_events)
 		return 0;
 
-	if (!test_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags)) {
+	if (!test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
 		/* Find and register all query methods */
 		acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 				    acpi_ec_register_query_methods,
 				    NULL, ec, NULL);
-		set_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags);
+		set_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags);
 	}
-	if (!test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
+	if (!test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
 		status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
 					  ACPI_GPE_EDGE_TRIGGERED,
 					  &acpi_ec_gpe_handler, ec);
 		/* This is not fatal as we can poll EC events */
 		if (ACPI_SUCCESS(status)) {
-			set_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
+			set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
 			acpi_ec_leave_noirq(ec);
 			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 			    ec->reference_count >= 1)
@@ -1504,15 +1504,15 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	 */
 	acpi_ec_stop(ec, false);
 
-	if (test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
+	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, ec->gpe,
 					&acpi_ec_gpe_handler)))
 			pr_err("failed to remove gpe handler\n");
-		clear_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
+		clear_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
 	}
-	if (test_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags)) {
+	if (test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
 		acpi_ec_remove_query_handlers(ec, true, 0);
-		clear_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags);
+		clear_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags);
 	}
 }
 
-- 
2.20.1

