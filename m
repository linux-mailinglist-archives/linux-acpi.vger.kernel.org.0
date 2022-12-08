Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11B56471A8
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLHOZj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLHOZO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 09:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798749D2E9
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670509427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOMUB2lWTRsp+E5CR6vDQBW+WTM+I1Pqg1TEAks/0WY=;
        b=cFtLW7PCT5WQUKCyUOMP25Xdd2fblj4DbTjAdEq7VfZtZXh5MgSJuzkYysCtW1cGtMPBGt
        z7dctY5KcCzzhddp4oc5TPbolf2iE+3qfftwysY3tx+2YLEbaC1LrFMOtFyP0+zioiTnpD
        touZdJS3aK5hVt8mYdIc/N7yf083mt4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-paFgfWmWO4mOY4pdVXGlLw-1; Thu, 08 Dec 2022 09:23:42 -0500
X-MC-Unique: paFgfWmWO4mOY4pdVXGlLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D29191C05137;
        Thu,  8 Dec 2022 14:23:41 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D04D2024CC0;
        Thu,  8 Dec 2022 14:23:40 +0000 (UTC)
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
Subject: [PATCH 1/4] ACPICA: include/acpi/acpixf.h: Fix indentation
Date:   Thu,  8 Dec 2022 15:23:32 +0100
Message-Id: <20221208142335.488382-2-hdegoede@redhat.com>
In-Reply-To: <20221208142335.488382-1-hdegoede@redhat.com>
References: <20221208142335.488382-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A bunch of the functions declared in include/acpi/acpixf.h have their
name aligned a space after the '(' of e.g. the
`ACPI_EXTERNAL_RETURN_STATUS(acpi_status` line above rather then being
directly aligned after the '('.

This breaks applying patches generated from the ACPICA upstream git,
remove the extra space before the function-names and all the arguments
to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/acpi/acpixf.h | 120 +++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9e49b37fc869..d1329d6d526d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -589,82 +589,82 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_install_initialization_handler
 			    (acpi_init_handler handler, u32 function))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_sci_handler(acpi_sci_handler
-							  address,
-							  void *context))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_sci_handler(acpi_sci_handler
-							 address))
+				acpi_install_sci_handler(acpi_sci_handler
+							 address,
+							 void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_global_event_handler
-				 (acpi_gbl_event_handler handler,
-				  void *context))
+				acpi_remove_sci_handler(acpi_sci_handler
+							address))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_fixed_event_handler(u32
-								  acpi_event,
-								  acpi_event_handler
-								  handler,
-								  void
-								  *context))
+				acpi_install_global_event_handler
+				(acpi_gbl_event_handler handler,
+				 void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_fixed_event_handler(u32 acpi_event,
+				acpi_install_fixed_event_handler(u32
+								 acpi_event,
 								 acpi_event_handler
-								 handler))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_gpe_handler(acpi_handle
-							  gpe_device,
-							  u32 gpe_number,
-							  u32 type,
-							  acpi_gpe_handler
-							  address,
-							  void *context))
+								 handler,
+								 void
+								 *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_gpe_raw_handler(acpi_handle
-							      gpe_device,
-							      u32 gpe_number,
-							      u32 type,
-							      acpi_gpe_handler
-							      address,
-							      void *context))
+				acpi_remove_fixed_event_handler(u32 acpi_event,
+								acpi_event_handler
+								handler))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_gpe_handler(acpi_handle gpe_device,
+				acpi_install_gpe_handler(acpi_handle
+							 gpe_device,
 							 u32 gpe_number,
+							 u32 type,
 							 acpi_gpe_handler
-							 address))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_notify_handler(acpi_handle device,
-							 u32 handler_type,
-							 acpi_notify_handler
-							 handler,
+							 address,
 							 void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_install_gpe_raw_handler(acpi_handle
+							     gpe_device,
+							     u32 gpe_number,
+							     u32 type,
+							     acpi_gpe_handler
+							     address,
+							     void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_remove_gpe_handler(acpi_handle gpe_device,
+							u32 gpe_number,
+							acpi_gpe_handler
+							address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_remove_notify_handler(acpi_handle device,
+			    acpi_install_notify_handler(acpi_handle device,
 							u32 handler_type,
 							acpi_notify_handler
-							handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_address_space_handler(acpi_handle
-								device,
-								acpi_adr_space_type
-								space_id,
-								acpi_adr_space_handler
-								handler,
-								acpi_adr_space_setup
-								setup,
-								void *context))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_remove_address_space_handler(acpi_handle
+							handler,
+							void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_remove_notify_handler(acpi_handle device,
+						       u32 handler_type,
+						       acpi_notify_handler
+						       handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_address_space_handler(acpi_handle
 							       device,
 							       acpi_adr_space_type
 							       space_id,
 							       acpi_adr_space_handler
-							       handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_exception_handler
-			     (acpi_exception_handler handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_interface_handler
-			     (acpi_interface_handler handler))
+							       handler,
+							       acpi_adr_space_setup
+							       setup,
+							       void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_remove_address_space_handler(acpi_handle
+							      device,
+							      acpi_adr_space_type
+							      space_id,
+							      acpi_adr_space_handler
+							      handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_exception_handler
+			    (acpi_exception_handler handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_interface_handler
+			    (acpi_interface_handler handler))
 
 /*
  * Global Lock interfaces
-- 
2.38.1

