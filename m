Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC62E2339
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgLXBKo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgLXBKo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D9C061285;
        Wed, 23 Dec 2020 17:09:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r3so854998wrt.2;
        Wed, 23 Dec 2020 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/1UKUJyr0qiUwLluVPA0tlSbSlnFJi05vFYlT35hz4=;
        b=g+km3icySyD/RWdDXjNZc3Loy9M6goJpitJnbHTBEjhGtac7n4yhri+GDfMWTIl5KD
         ezdbublcXNDYBcF0TcHHdnYtQfoed6WWeM0b1ZOWN7v48QvbjW6Fpv0mxOKhKHrXWJR2
         6Arn+1Q0kbJLVfuO1mTXJZ8rUx2DjG17iqaFOeCaNLjKegwiEvyrpoUcGSiPY68YHOnP
         v/bAHxJRun4m77pTkRhBIGIs7TcppEKNMLV/nk4LWpaDdrwtbxjIYe6NtueCWv4FS0A4
         HJ6D0oh0vWSseLvG8ndh1N5kSIW7d5Llvb60uXE+Hj6xZfozw3v2SgjaQZo/+coPAoGY
         MRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/1UKUJyr0qiUwLluVPA0tlSbSlnFJi05vFYlT35hz4=;
        b=pje/9SlhNq7csigvchkflw8HvCIXVKiHySiGWjuy9keiMxSqERCvAjCCWvRPjJCTM4
         zaHNXrjufys95gCLIFbmUmaoJM/ctyVZIJNwDT31ERPW0Y/u1BnSjrAKv5TOfaF6Oc9c
         8YX7yih/SeCA6b1QzGV7c4PD1970Qzt6I0fBoNsSzlw1Bhua4Hn7ysDKogx4guszT5ji
         cYj58BrscHc0B/VwpD6wq9FhYWQge51h+6ic8aZtjIXRPLTwxoMr490Iv0x8nsOQfIED
         aNGnKrtVzGr3H5zD+5tOTLX0HeGOq1E+o7BHqpRM7xGukxBQbMscEWR5u5sXtTNbREpd
         BnMQ==
X-Gm-Message-State: AOAM533CzUIHOgx+9/iSxDp0npylSOMUFGEw3TaBofh/aHveJPq7XlCA
        7uuNFrwampqa/uuSylgR507Aony2q7J+dXZA
X-Google-Smtp-Source: ABdhPJzMoFd7p+QiYEuqc5Pon1T5wPy9pHd4RsygkYw1VGKzelRl8YrfcH400px+thmA4ArsxkatHA==
X-Received: by 2002:adf:d843:: with SMTP id k3mr32177295wrl.346.1608772168630;
        Wed, 23 Dec 2020 17:09:28 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:28 -0800 (PST)
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 05/14] software_node: unregister software_nodes in reverse order
Date:   Thu, 24 Dec 2020 01:08:58 +0000
Message-Id: <20201224010907.263125-6-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
	- Fixed the dereference of the terminating NULL entry
	- Comment cleanup

 drivers/base/swnode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ade49173ff8d..2d07eb04c6c8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -779,16 +779,22 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * software_node_unregister_node_group - Unregister a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be unregistered
  *
- * Unregister multiple software nodes at once.
+ * Unregister multiple software nodes at once. The array will be unwound in
+ * reverse order (i.e. last entry first) and thus if any member of the array
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
+	while (node_group[i])
+		i++;
+
+	while (i--)
 		software_node_unregister(node_group[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
-- 
2.25.1

