Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4892E8ED6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbhACXOQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbhACXOP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671CC061795;
        Sun,  3 Jan 2021 15:13:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r7so29993301wrc.5;
        Sun, 03 Jan 2021 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIiMKxUvrjl1v7PNLYMNnZ+IQw+wXLswE4tV60P7O7c=;
        b=q54/Th1nebndyhOhnssyFvAlCk+0BCmU+1jKZoBXWnAQP5ArzGWKFnGIQQkToFcV7o
         MvMEUnGVElzdwilD1r6djbEKvu2EtlInLk/aq0W3nC0/t3RfyBd++MhMn+850cdQbCNw
         R2DJf28q75KjtKnggvE5x1tSt6tpCi9SVySrMx9Puxb13/b4pikvnqpa3LGzEx3/+Tgh
         5A5+KK6SIQOxnk9z7a89RiA6X8e5dGH3nYm203O9w67+lGTofvCMvEX/X1BwGe99iJ/o
         jrBss5YOhBxsqlv4slE1MB88E+ibX5eAtdpL0iax/dMBbVW5bRO0UlwREml1gIZ2ARSt
         t+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIiMKxUvrjl1v7PNLYMNnZ+IQw+wXLswE4tV60P7O7c=;
        b=d7KKO5RFEAYIu47Vw2OUs71hl00cN4wKdxkdL3XJ5XPaa2a/x5WEwz+RrTN3gFUq8Y
         uZgBPMdy3Z4FYzPMYabY8vXrLAZ6a5F7BveIbMlnOqKFN4M4ylbNmR2vvuLvdySN6sgh
         dTUXpfDmNA8RIOc4VLmWqNQWfNLGEc3FiOD/k9BAINyslr5kFqut/Kg2XyW8MQ3XfnwH
         3VK3FRrQevfi0DL5Ocd1JgRxy12ZB+omEJ3DxdCnBI3VtoltjBPPVu5p7pLzfCNZhkJD
         wL7clVneXppZ+OhrKF/mMqUnKmJCTIgIIW+TX8/GCREP62TkYHgX4Vn9UbQURsSXzenp
         auSA==
X-Gm-Message-State: AOAM533/bpOCUBL0T1QnfWEfxJhaLfzdPZg8vrs0BYa5WYxB5MszOyzx
        38WBIpCQq8fwfpQikJB68pbhxT0MPgfQcPnl
X-Google-Smtp-Source: ABdhPJxDD2mO6ozmKkVDU6qf2Z4SddS6R29MIl4ljgQ0zWXu272tmjtXCZUFkEyJpKbtMhEGwCEYqQ==
X-Received: by 2002:adf:e802:: with SMTP id o2mr79458221wrm.251.1609715581875;
        Sun, 03 Jan 2021 15:13:01 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:01 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 06/15] software_node: unregister software_nodes in reverse order
Date:   Sun,  3 Jan 2021 23:12:26 +0000
Message-Id: <20210103231235.792999-7-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- Changed the language of the comment to be easier to follow

 drivers/base/swnode.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ade49173ff8d..1f43c51b431e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -779,16 +779,23 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * software_node_unregister_node_group - Unregister a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be unregistered
  *
- * Unregister multiple software nodes at once.
+ * Unregister multiple software nodes at once. The array will be unwound in
+ * reverse order (i.e. last entry first) and thus if any members of the array are
+ * children of another member then the children must appear later in the list such
+ * that they are unregistered first.
  */
-void software_node_unregister_node_group(const struct software_node **node_group)
+void software_node_unregister_node_group(
+		const struct software_node **node_group)
 {
-	unsigned int i;
+	unsigned int i = 0;
 
 	if (!node_group)
 		return;
 
-	for (i = 0; node_group[i]; i++)
+	while (node_group[i])
+		i++;
+
+	while (i--)
 		software_node_unregister(node_group[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
-- 
2.25.1

