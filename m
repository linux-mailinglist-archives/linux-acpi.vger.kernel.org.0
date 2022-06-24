Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F541559887
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiFXLYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFXLX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC0F1794FB
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82Ij3KY5/BEOv2r3usw7/HjDI9/3Y74cnsWAOy3KvOo=;
        b=U84gCUCAb0gmDp9rxr6bYB75ZeYWuWpJXPdtElEiKPmHb+3hJLQiWZMcNnXdsI176x4+FU
        JfciikFfQ2PakbC7YtEWdbcK+XOVhGgogsUciKm1Le+tljnTGSKo0gK2bf2267QuZ4QWsU
        1kt6rKLaOl1Y8fBEjz7SRXwO/yu7bsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-blujtiqwMFCeIb8ntadJlA-1; Fri, 24 Jun 2022 07:23:56 -0400
X-MC-Unique: blujtiqwMFCeIb8ntadJlA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1D8F801756;
        Fri, 24 Jun 2022 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932CC492C3B;
        Fri, 24 Jun 2022 11:23:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 4/7] platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
Date:   Fri, 24 Jun 2022 13:23:37 +0200
Message-Id: <20220624112340.10130-5-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In hindsight blindly throwing away most of the key-press events is not
a good idea. So revert commit ed83c9171829 ("platform/x86:
panasonic-laptop: Resolve hotkey double trigger bug").

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/panasonic-laptop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 26e31ac09dc6..2e6531dd15f9 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -783,12 +783,8 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 					key, 0x80, false);
 	}
 
-	/* for the magic values, see panasonic_keymap[] above */
-	if (key == 7 || key == 9 || key == 10) {
-		if (!sparse_keymap_report_event(hotk_input_dev,
-						key, updown, false))
-			pr_err("Unknown hotkey event: 0x%04llx\n", result);
-	}
+	if (!sparse_keymap_report_event(hotk_input_dev, key, updown, false))
+		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
-- 
2.36.0

