Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7962ED0DF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbhAGNaQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbhAGNaP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA8C0612FB;
        Thu,  7 Jan 2021 05:29:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q18so5674136wrn.1;
        Thu, 07 Jan 2021 05:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q35SKEhUngO2dvKOfSrhZ/DM/hFpMmcFqtJ+mEN4BGI=;
        b=ndhqm8M61RIfCAsPSYD7AISOXvrSOUA3WIdr+dM1k5PTYAm55MN3hvFU3WWDWlPVkY
         932AENhVAyhCL+5XflBKuSsxqLKG06G/eFED3/cdwf3cIeFK/k13qaA2u4RZo+rYr46d
         8lzVgFqoshpd20lxvPlcofVCsCRe7knHTA2ymz1iyKfQMM6BX5TnWoQNgYinVxDehwu7
         Y4qhY5c3LPPPQzVT47WmhbG9snPdR8m+Iuf2QkYCNtRhIJRyQZUVjFE8VadhtvX37gQk
         RlKzLS+W8n1dHMs9qZH+wpN7HxbPl5lrv0Sr2iINHIO26mldoIAIlipy8aRWayQ4oSYH
         /BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q35SKEhUngO2dvKOfSrhZ/DM/hFpMmcFqtJ+mEN4BGI=;
        b=CwOQvRXtdC0maXnZdPA1CGpoAoNUaW00y/txrkqMgYFItgvIJhdPnO4Ja1uk+T2vt6
         VCM7qEwjKuTHUFvwjRAYNlbsE4Lrw2QgglTIDRijoVAS/5OuzcpK9dJS+2IYjfCc4SCQ
         Afrs5dpRevxbs1tIgU3qeV6o18iLJ+mh2pscWIXEZ1hPCdAvr9I12ZxEZau7NKhi20X0
         05miRLNn8uFQNujDmlFo9O57TCeLlysM1Rk5epYkOYy1YxEEBC//AjDJfun1BKcHmDGu
         8OlDM6hHwsBZPBSn5T3Y+zptkdCnOA6/Ge5mvCOHfaYlE6Fe0JTlkEsENfWJg81C+Dz6
         1Oyg==
X-Gm-Message-State: AOAM5338I10SDsKrVFL8qMTYDTWetYfxJFzfxOsk8NWfxCmRJVM0Rr9R
        MhPFU+0g8NtxBzQV3DI73UvgWoGke9qVUZjq
X-Google-Smtp-Source: ABdhPJy7HnqQWMd1WTCWgoR8XrxcIXCcyUNUYXkzZTFW9qT79mLG9hrG+DE28kxd3DPnyi4gxydXIA==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr9086921wrt.49.1610026141885;
        Thu, 07 Jan 2021 05:29:01 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:01 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 06/15] software_node: unregister software_nodes in reverse order
Date:   Thu,  7 Jan 2021 13:28:29 +0000
Message-Id: <20210107132838.396641-7-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

	- None

 drivers/base/swnode.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 166c5cc73f39..6f7443c6d3b5 100644
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

