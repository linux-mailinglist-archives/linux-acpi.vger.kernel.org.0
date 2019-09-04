Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0027A94A4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfIDVLs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 17:11:48 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34771 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfIDVLs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 17:11:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so130565pfe.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2019 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=YRrXlCAVnzOOK2AfKz9blA2WPrjNpEFwO6Leu6qgi/oZvs/DH9zgLemvWVbfxKWe0s
         YCxi/y1Mm7LjwnUr7HhL0vUqE/tbkSq31IsqlVHfvBPhSpEC4XwJGtllRI+Aph4kHhz5
         w35aCIKvqsH6vrHDhJYqLhBJmU0Py9hgPWxl5VpPKN8gMj2iaNMdX1oqh9SuENVPRlE0
         vuL7OAgySwzO1pszYEoAHk5QI404dziPwjaKEx5Dp0Ys9UTaBYjuXGHRiXIDK4HZQuTs
         97JdZlBhmpkBtfEIiemSRvuK+M7OqFzBYTaVLRdKXAsDFNHkmFldBvv6wGYmveq1NB66
         cqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=h/75oK3WjRuE16bsFgHewwt+ibNFHrUU5TOJu9Puzv5si/TJeHyjcRhpXsZeZC4uq3
         G8s8wEvy2At7K5ERTK0vCBCr7YFUKCRog7ZHcth29TRwow3KtZKihEMr+ApLBlZBzzSJ
         Z+uVVPUnmlGWt+OAfm/ZcniVjGcSDQskY+7t8h33+F2GO+7UeB3HWWDPpx0/5WiWSm17
         hezi/KDHcJ7wI9lntR6Vhp/7kdx0+zio6R/178pUtddKjISq8DVW0f1ARoDpdfA/frff
         jwXfihqXZMml3hRzSbXIEAn+zzGL8DP+yWHlxUlHG7nJbMbbU+GEFNn+SjpRN0TnQ6Bf
         HItA==
X-Gm-Message-State: APjAAAV18vIeAaeE7zfqmlH7ZDv+W+L9bjPykXVq2z9LDxOn1B+Pgc0g
        iE0VQK0bdDQ87h8CMXjWeomlPUWxj/lINIA=
X-Google-Smtp-Source: APXvYqxa0Q445BT0USKWHcd+K+nDsZIoXWF5ccMgBrzd0E7J8jAJCvSVyiJOr/BJ7oiKfX/XVA1lQD7iaFaxsQU=
X-Received: by 2002:a63:2a08:: with SMTP id q8mr101014pgq.415.1567631507124;
 Wed, 04 Sep 2019 14:11:47 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:24 -0700
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
Message-Id: <20190904211126.47518-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 5/6] of/platform: Pause/resume sync state during init and of_platform_populate()
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When all the top level devices are populated from DT during kernel
init, the supplier devices could be added and probed before the
consumer devices are added and linked to the suppliers. To avoid the
sync_state() callback from being called prematurely, pause the
sync_state() callbacks before populating the devices and resume them
at late_initcall_sync().

Similarly, when children devices are populated from a module using
of_platform_populate(), there could be supplier-consumer dependencies
between the children devices that are populated. To avoid the same
problem with sync_state() being called prematurely, pause and resume
sync_state() callbacks across of_platform_populate().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b47a2292fe8e..d93891a05f60 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -480,6 +480,7 @@ int of_platform_populate(struct device_node *root,
 	pr_debug("%s()\n", __func__);
 	pr_debug(" starting at: %pOF\n", root);
 
+	device_links_supplier_sync_state_pause();
 	for_each_child_of_node(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
 		if (rc) {
@@ -487,6 +488,8 @@ int of_platform_populate(struct device_node *root,
 			break;
 		}
 	}
+	device_links_supplier_sync_state_resume();
+
 	of_node_set_flag(root, OF_POPULATED_BUS);
 
 	of_node_put(root);
@@ -518,6 +521,7 @@ static int __init of_platform_default_populate_init(void)
 	if (!of_have_populated_dt())
 		return -ENODEV;
 
+	device_links_supplier_sync_state_pause();
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
@@ -538,6 +542,14 @@ static int __init of_platform_default_populate_init(void)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
+
+static int __init of_platform_sync_state_init(void)
+{
+	if (of_have_populated_dt())
+		device_links_supplier_sync_state_resume();
+	return 0;
+}
+late_initcall_sync(of_platform_sync_state_init);
 #endif
 
 int of_platform_device_destroy(struct device *dev, void *data)
-- 
2.23.0.187.g17f5b7556c-goog

