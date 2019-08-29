Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4219CA12E9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfH2HqX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 03:46:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40399 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfH2HqW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 03:46:22 -0400
Received: by mail-pl1-f201.google.com with SMTP id k7so1540786plt.7
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2019 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=LBG2uKzUyf+lgCiiz1TCYPvqtTg8O75lmZkz3K9OnVAOegYlB2t8YC0L5P2YU6zU5j
         hMLIBnxwaAnmCIb3RjfHdxwX7hzF4AwQL0ymNEJ9RIhELNDRGn3q76ImBKR/jtT7JmW4
         G9BDxC3L/EXqCFj/8/eY75Qu3105luXea9dY4/owBiGMk9pp5/WKeuwdONwXpWGBHqTK
         Np6bsfEOV0Foi+N5sRYmp0kxzgoRgRlGXKpiZDsH9DCcL97pi0t1okzaQsuNnHPjgobv
         SemQ2cAXS+wRtE4/D4FAZMMtN5x1ekLi9jOXnbZRtdybxOFMNEFGLiaqcuWZJPzHYFna
         1zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BNYZzlx9aTQ+LCgQZ8IG6mRelU0sVitbFkM6D5hbnnk=;
        b=XIJZxOuOv0s9YhOsTY5TRFKpwowr2d0NsPsUufsdTXxavmirE7EoHIkQthqJfgSihF
         VoGRQWDc57ck3Tj+ZIz2VeOS7xcrlqInDeLwvKaYhtWJZR152ZmyIGXiBNKe4z/fSDZi
         Jtk5bmX7SU9i/U5mFJU4N5IiPW6YSFbP7c5IyZ9NR1l69Nxw+t3Mroo+RCqPkeg72K4O
         qM41n2HWKvlmhF/xUmDd5ukX9K3A4Zb2JM/DRbfoqJAvOve7O/9SLOeEx+wQgWnlAsr/
         ksjdvapHl2VLlKqNTcrUBEpPDGCvte9uTD4h7+LdzcZpHoMBHqElR1eJMUCLBoZesDmt
         aCZw==
X-Gm-Message-State: APjAAAUr9VKbs8UmNGwOQwgdk1csLRshd/hK8uygOQ8Vk6+lJEP/r/bW
        Go2PVvazrwKjkiUXC6DmVO0zHv4dbKUTHIQ=
X-Google-Smtp-Source: APXvYqx+RvJoMMYz7ltcPQy/uFdoUYJU6ahjc36Dl7f/s2wwI7J6sQL8aP+UHuzb8PASIQh6oHx8vPGvic4jh1k=
X-Received: by 2002:a65:4243:: with SMTP id d3mr7249704pgq.119.1567064781369;
 Thu, 29 Aug 2019 00:46:21 -0700 (PDT)
Date:   Thu, 29 Aug 2019 00:46:00 -0700
In-Reply-To: <20190829074603.70424-1-saravanak@google.com>
Message-Id: <20190829074603.70424-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190829074603.70424-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v10 4/7] of/platform: Pause/resume sync state during init and of_platform_populate()
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

