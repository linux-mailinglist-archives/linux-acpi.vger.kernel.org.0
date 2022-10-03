Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074545F3218
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Oct 2022 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJCOmj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Oct 2022 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJCOmg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Oct 2022 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9602C100
        for <linux-acpi@vger.kernel.org>; Mon,  3 Oct 2022 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664808152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h209OLq5ehOiqnirNnJe5LyWnJQltosaSjjkTAe+sps=;
        b=aoQG9PYp4XjacsRvnoiFWbWVRc1PNTY1vEXrxu1aIYFhfzqJKX78UQKiPnoB2aXGXzZKc7
        knn8SArLSNdbRE2yMG+w0jLXiuNVzMgOHk4h6iGPp1EyyvoSjUloajwmixMIDE3BCwlqTb
        XFbNFumlStPC65+2N4ggJTp6xI9Vt/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-Oly5DiBTPBaTCyDhjIUSDA-1; Mon, 03 Oct 2022 10:42:26 -0400
X-MC-Unique: Oly5DiBTPBaTCyDhjIUSDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 872C887B2A0;
        Mon,  3 Oct 2022 14:42:25 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F040540C206B;
        Mon,  3 Oct 2022 14:42:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [RFC v3 3/4] ACPI: EC: Fix EC address space handler unregistration
Date:   Mon,  3 Oct 2022 16:42:13 +0200
Message-Id: <20221003144214.345279-4-hdegoede@redhat.com>
In-Reply-To: <20221003144214.345279-1-hdegoede@redhat.com>
References: <20221003144214.345279-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When an ECDT table is present the EC address space handler gets registered
on the root node. So to unregister it properly the unregister call also
must be done on the root node.

Store the ACPI handle used for the acpi_install_address_space_handler()
call and use te same handle for the acpi_remove_address_space_handler()
call.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c       | 4 +++-
 drivers/acpi/internal.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95e535035a0..55c503225396 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1479,6 +1479,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
+		ec->address_space_handler_holder = ec->handle;
 	}
 
 	if (!device)
@@ -1530,7 +1531,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
-		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
+		if (ACPI_FAILURE(acpi_remove_address_space_handler(
+					ec->address_space_handler_holder,
 					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 			pr_err("failed to remove space handler\n");
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 628bf8f18130..dd3bcbefbc06 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -173,6 +173,7 @@ enum acpi_ec_event_state {
 
 struct acpi_ec {
 	acpi_handle handle;
+	acpi_handle address_space_handler_holder;
 	int gpe;
 	int irq;
 	unsigned long command_addr;
-- 
2.37.3

