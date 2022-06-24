Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A8559881
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiFXLYF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFXLYC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 07:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 872C47A1B7
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656069840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuk8QZOl+nh2xXZU03NRWI2qOzs4ik4DXsycBssvxiM=;
        b=eTGmzI5LZjOhFmDr//wadkj7QOo/k4Gnlu/Bva6X4NE48sPGVkcHT9OIJdMhyxFb9qHOme
        Glz2HtVbzTnCwgWMX/RTrD6FbCqSE+VmujdM7ivJWrMhz0+628HzI71P8QG7VvxeszBYtf
        79G9quHQJMQBhN7i2mzgr13hW1R7t7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-y_jFnhbaOBeCi6ojkSHYcw-1; Fri, 24 Jun 2022 07:23:53 -0400
X-MC-Unique: y_jFnhbaOBeCi6ojkSHYcw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8D33101AA48;
        Fri, 24 Jun 2022 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C43B492C3B;
        Fri, 24 Jun 2022 11:23:51 +0000 (UTC)
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
Subject: [PATCH 2/7] platform/x86: panasonic-laptop: de-obfuscate button codes
Date:   Fri, 24 Jun 2022 13:23:35 +0200
Message-Id: <20220624112340.10130-3-hdegoede@redhat.com>
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

From: Stefan Seyfried <seife+kernel@b1-systems.com>

In the definition of panasonic_keymap[] the key codes are given in
decimal, later checks are done with hexadecimal values, which does
not help in understanding the code.
Additionally use two helper variables to shorten the code and make
the logic more obvious.

Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/panasonic-laptop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 37850d07987d..ca6137f4000f 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -762,6 +762,8 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	struct input_dev *hotk_input_dev = pcc->input_dev;
 	int rc;
 	unsigned long long result;
+	unsigned int key;
+	unsigned int updown;
 
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
@@ -770,18 +772,22 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 		return;
 	}
 
+	key = result & 0xf;
+	updown = result & 0x80; /* 0x80 == key down; 0x00 = key up */
+
 	/* hack: some firmware sends no key down for sleep / hibernate */
-	if ((result & 0xf) == 0x7 || (result & 0xf) == 0xa) {
-		if (result & 0x80)
+	if (key == 7 || key == 10) {
+		if (updown)
 			sleep_keydown_seen = 1;
 		if (!sleep_keydown_seen)
 			sparse_keymap_report_event(hotk_input_dev,
-					result & 0xf, 0x80, false);
+					key, 0x80, false);
 	}
 
-	if ((result & 0xf) == 0x7 || (result & 0xf) == 0x9 || (result & 0xf) == 0xa) {
+	/* for the magic values, see panasonic_keymap[] above */
+	if (key == 7 || key == 9 || key == 10) {
 		if (!sparse_keymap_report_event(hotk_input_dev,
-						result & 0xf, result & 0x80, false))
+						key, updown, false))
 			pr_err("Unknown hotkey event: 0x%04llx\n", result);
 	}
 }
-- 
2.36.0

