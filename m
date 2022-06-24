Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED98559880
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiFXLYF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFXLX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15578562CD
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLS+rTb/joeHyvhLqe9uems9tKBO8o9mAsEEBCpu9f0=;
        b=SO1eqyiRdWItS4zQtZOhXkUVPA4dguEkqJPATuRz6ujuQ1ggJYuk+bYi+mlLGx9WAHJVeg
        KBu7XG6XblcowC1sb5Pvy+raSymNR2LCGteelq/TH85Gh8rMRUrGxajR1Nxs3ULe9AMkoo
        vny4uBgegYD/bhxTNrWMl0oYHAmTpqc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-VaA9sZqfPbqSJiauYO897Q-1; Fri, 24 Jun 2022 07:23:54 -0400
X-MC-Unique: VaA9sZqfPbqSJiauYO897Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D9573C0D86C;
        Fri, 24 Jun 2022 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19A94492CA6;
        Fri, 24 Jun 2022 11:23:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/7] platform/x86: panasonic-laptop: sort includes alphabetically
Date:   Fri, 24 Jun 2022 13:23:36 +0200
Message-Id: <20220624112340.10130-4-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sort includes alphabetically, small cleanup patch in preparation of
further changes.

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/panasonic-laptop.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index ca6137f4000f..26e31ac09dc6 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -119,20 +119,19 @@
  *		- v0.1  start from toshiba_acpi driver written by John Belmonte
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
+#include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/ctype.h>
-#include <linux/seq_file.h>
-#include <linux/uaccess.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
+#include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
 MODULE_AUTHOR("Hiroshi Miura <miura@da-cha.org>");
 MODULE_AUTHOR("David Bronaugh <dbronaugh@linuxboxen.org>");
-- 
2.36.0

