Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4E2BBC03
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 03:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKUCDV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgKUCDS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB6C061A48
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v188so13999953ybc.19
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kkvUYmRSkidNjkTq5GwniBTGKUzDD8tYACZuHPPCtMw=;
        b=C0huOxQfOFIYkmZ5+j5wBG0r+aPmC4/UZ/pyjY13Gqsre385QtU5zpSWQqtLiSK4EC
         DJG49WcUPSMz92mQT8T6Zxckt93Reu6GEAXQO+yNjstfjcXyxQjhricoR5vmJydKCcqT
         W4clRYgmd/+H2PBfwwmEL54kIktmgWsA2vP0leAI328J0tvhKucVE1oyV3otEuzsze0Q
         VxogMphFyQZJGHwXst43+T9wmNbXvyaJUnMaHAlVZFg7Dlf369VoYCx4YlanCeqOPXku
         rlUsaqd6kIfaZWYKUJgQQ6H994f73Sx5bSOOmMPSW62bBO/93wbtorcE7/iH0aY3VEOj
         CZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kkvUYmRSkidNjkTq5GwniBTGKUzDD8tYACZuHPPCtMw=;
        b=DatOwyi8FaHWFSeacrBeJY3KHLZ2w3IoEXD6+NEaAowhAalvoG/9n+WeyhYTjHy9Fl
         vc2muAJSUOOc0AU9PfQGQ6D46axqA57c6jyocpMlsGjrqbsrZo50GFdBS1AvoCHsq3bs
         VcCeZWEDzFWyUtPos6d5kBmYmhhpoekIzIZxnNr0KCxVIKizimUrNzNd+VY5PliUs0te
         UC0QyL34VE261c1B9b8eCUqNbX2bcQv2jQF8IMdqclzQ622VLpTBw2EOJWm2Y2s4XSsC
         r8dAAwyDwosNQ0AYT8XQIqUCrBJPPWYktvsCo/pjopTGGn03DXfT4qMAp64zSMXHN99u
         sFhw==
X-Gm-Message-State: AOAM532PNqjtXI/8YJqxBnHEHaWBVN1CslAmLdVITlSbvtuObXsymei9
        vDfBolKGTVIZvnGe+rPe/gj6FfvDXfCyZQE=
X-Google-Smtp-Source: ABdhPJyV9Uoir3KqyP3MamhCm8qYOnpgbNbEd6xLZ5JjffYqgi0HKnViyZWiFepF+7Lo7+787hyZ2uVL7R2L6mw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:2a4b:: with SMTP id
 q72mr34851917ybq.385.1605924195519; Fri, 20 Nov 2020 18:03:15 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:27 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-13-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 12/17] driver core: Add fw_devlink_parse_fwtree()
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This function is a wrapper around fwnode_operations.add_links().

This function parses each node in a fwnode tree and create fwnode links
for each of those nodes. The information for creating the fwnode links
(the supplier and consumer fwnode) is obtained by parsing the properties
in each of the fwnodes.

This function also ensures that no fwnode is parsed more than once by
marking the fwnodes as parsed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 19 +++++++++++++++++++
 include/linux/fwnode.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 215ce9e72790..395dece1c83a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1544,6 +1544,25 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
 }
 
+static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
+{
+	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
+		return;
+
+	fwnode_call_int_op(fwnode, add_links, NULL);
+	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
+}
+
+static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child = NULL;
+
+	fw_devlink_parse_fwnode(fwnode);
+
+	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+		fw_devlink_parse_fwtree(child);
+}
+
 static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 942a6bb18201..ffa9129182a6 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,12 +15,20 @@
 struct fwnode_operations;
 struct device;
 
+/*
+ * fwnode link flags
+ *
+ * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
+ */
+#define FWNODE_FLAG_LINKS_ADDED		BIT(0)
+
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
+	u8 flags;
 };
 
 struct fwnode_link {
-- 
2.29.2.454.gaff20da3a2-goog

