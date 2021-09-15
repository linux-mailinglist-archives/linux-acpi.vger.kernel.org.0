Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A740C16B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhIOINc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhIOINP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 04:13:15 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFEC0613D8
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r6-20020a05622a034600b002a0ba9994f4so1780109qtw.22
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tE5kGBxc9PR5MYieHfGicxhFgO1boA1xk2XZYsANqZE=;
        b=KN5josXRk6vEJRYv7Y1XeBMkRQ8IZkeHu44xya1+5GcI4HNGbxj/PzNhRJv03Gm7gz
         vwZ+eUszHx3DpNx65e2e5tZwGBh4E735USu8tG5dL74IvqQS7GCR28Zet9kaZOkKGvfO
         1YhaL/yYj9lv4TJfaP0O95HgWwVHMxevZNv5+x9HkCTw8gLypeb4HuL1IHfm3jfS4XTH
         kgoGDssnvd/dlvR7WgNGENS05/uC5nXpQCEZw/0JIG5MksUhDetVqUVN7J3YRjO+aXuD
         xrMHTI1av5a7LngEXrGJW1Q3kTesixXypTyLae2F+0L6oZw4+JAiS73jCRIQsnHE+vJg
         obag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tE5kGBxc9PR5MYieHfGicxhFgO1boA1xk2XZYsANqZE=;
        b=pVv4j/U5UCGrynhW+5ISeXPQ9HXoOMTdGdl0ZOa4aDysXPFHKRg9/j0s/D3G+qEjGY
         55kc5tQV7sqGoH/uBvdXvRoENcarirqaHfg/ZZkcuo0knO6K4TtX5VgRlBz1R5C8xS1u
         LfIkKai3mgKk0XTP8586QNETAzVVWRUVi/w2eO9ERNycnPctpFTaSigPc35jQdWRZk0s
         IAtUTd55F5aisOWgr6MmUcLV3bNOB+BvBGQ+ckR5hwPKbycfldKtKuQa4yciR+UmqBxG
         JI/8lFn00oWUlLQSwc8qeeJYInmuKrdQvcOJ3q5G1Cznscg+vuvYvKdXZ+89XRvPmWBF
         lcGg==
X-Gm-Message-State: AOAM530jz4lYLJ9sHSdSRixJ18J8QtJLB+1J9bJzNAEldOBVEv7VfIxu
        eFyUuhH4OuuAEjzPZCsU/iooa7pqopZN480=
X-Google-Smtp-Source: ABdhPJymuo/nGsFPIwVrp7CZBqqkEkLsixu4nf/KlVnpN+10WWdFz1i21Iee5Xghf2MWQiCPsNtZaWmaSD1VQvY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a0c:fca2:: with SMTP id
 h2mr9492302qvq.5.1631693511580; Wed, 15 Sep 2021 01:11:51 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:35 -0700
In-Reply-To: <20210915081139.480263-1-saravanak@google.com>
Message-Id: <20210915081139.480263-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 3/6] driver core: Create __fwnode_link_del() helper function
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The same code is repeated in multiple locations. Create a helper
function for it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/core.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ca6c61a2e2e9..5e7faad4e083 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -101,6 +101,19 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 	return ret;
 }
 
+/**
+ * __fwnode_link_del - Delete a link between two fwnode_handles.
+ * @link: the fwnode_link to be deleted
+ *
+ * The fwnode_link_lock needs to be held when this function is called.
+ */
+static void __fwnode_link_del(struct fwnode_link *link)
+{
+	list_del(&link->s_hook);
+	list_del(&link->c_hook);
+	kfree(link);
+}
+
 /**
  * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
  * @fwnode: fwnode whose supplier links need to be deleted
@@ -112,11 +125,8 @@ static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
 	struct fwnode_link *link, *tmp;
 
 	mutex_lock(&fwnode_link_lock);
-	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
-	}
+	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook)
+		__fwnode_link_del(link);
 	mutex_unlock(&fwnode_link_lock);
 }
 
@@ -131,11 +141,8 @@ static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
 	struct fwnode_link *link, *tmp;
 
 	mutex_lock(&fwnode_link_lock);
-	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
-	}
+	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook)
+		__fwnode_link_del(link);
 	mutex_unlock(&fwnode_link_lock);
 }
 
@@ -1868,9 +1875,7 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 	}
 }
 
@@ -1922,9 +1927,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
-		list_del(&link->s_hook);
-		list_del(&link->c_hook);
-		kfree(link);
+		__fwnode_link_del(link);
 
 		/* If no device link was created, nothing more to do. */
 		if (ret)
-- 
2.33.0.309.g3052b89438-goog

