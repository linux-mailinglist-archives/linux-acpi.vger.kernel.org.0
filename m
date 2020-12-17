Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EDF2DDC0B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgLQXpO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgLQXpO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F2C061285;
        Thu, 17 Dec 2020 15:43:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d13so200861wrc.13;
        Thu, 17 Dec 2020 15:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9hWyCxdl7BaMDXzs37QSeG0VlHKb85UKoJQ04gptnE=;
        b=eLaJcbeBCaeFtHSgKWBkcouRygDfUOsGhvnFKtJmjREtgycPYnhiOyiGwwxU6wQ4PA
         2f8jfeHO2hk8zawm7ShOqaqyoj8bkKb2GFFBBn6hfUY2od97El4842jkBjIsJZ9RpUJ0
         NlJSkAWsAt+WNVkZzOeHGfT95gNPt8wk8W1dtlgHcvuoQlLv3BNL8ShEBvYD3aP3D3dB
         AdgpxwtMGuwLVq+mUi2+zZb5//JuLPyxHB9nJeClQmCO6BDVMtY5hmWA4fauC6zwUC1W
         EgeWQt1TKXxnB6CwE50LUqJx0aPK7E8A4RjzA1YoLec2SGNEpFld6jrJqzwgTfX9s/zC
         qMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9hWyCxdl7BaMDXzs37QSeG0VlHKb85UKoJQ04gptnE=;
        b=uI7wRUav4VmFU/Ekn9Wd56EtGYskRVqxQyy4K5Uv4DJpWHcNveaDd9YAHp/oEuN3mr
         ZdhyAjwa4GPOGm1/2b/sAFOX8VKjxaYvSsLXuvXfUE6Fq8h7znCJFmvGiRifco8h3b1r
         zbyUa2vrHyKoBQz80hGFyEOo3KSUVOVDPDPeOHUdohOl0o22Sdo0DQ9+7j4F2Hu0xz3y
         yPtfdaeSw9VbO4intxEkvm/S9xcRkrBhwovCJc68np0s8fAEJq7AKbejQZ8kV6/+A+uw
         04kyvbcvVVuoTt7jXczP2suixLhpOvhqRvUsnHC5/NWO6SaE4MlTYaXgXJN5nqQAecUB
         UtVg==
X-Gm-Message-State: AOAM533IlA3Z3K+2T+DWYgV5i3bPIRTUKqixBodQ3MGOWnQgC0b7d4Vh
        2mzEhFV2P+1wVwNlC16UKJ9i4OKVLJByhkfd
X-Google-Smtp-Source: ABdhPJwRogkY05VU9Y1LkJwAM7Oisn574vwGXScbZrpMXHJGJBpVQiK78bbLfBuM+lgEaVNS1B0NLA==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr1230073wru.410.1608248638775;
        Thu, 17 Dec 2020 15:43:58 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:58 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 05/12] software_node: unregister software_nodes in reverse order
Date:   Thu, 17 Dec 2020 23:43:30 +0000
Message-Id: <20201217234337.1983732-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To maintain consistency with software_node_unregister_nodes(), reverse
the order in which the software_node_unregister_node_group() function
unregisters nodes.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Initialised i properly

 drivers/base/swnode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index cfd1faea48a7..2b90d380039b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -778,16 +778,22 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * software_node_unregister_node_group - Unregister a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be unregistered
  *
- * Unregister multiple software nodes at once.
+ * Unregister multiple software nodes at once. The array will be unwound in
+ * reverse order (I.E. last entry first) and thus if any member of the array
+ * has its .parent member set then they should appear later in the array such
+ * that they are unregistered first.
  */
 void software_node_unregister_node_group(const struct software_node **node_group)
 {
-	unsigned int i;
+	unsigned int i = 0;
 
 	if (!node_group)
 		return;
 
-	for (i = 0; node_group[i]; i++)
+	while (node_group[i]->name)
+		i++;
+
+	while (i--)
 		software_node_unregister(node_group[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
-- 
2.25.1

