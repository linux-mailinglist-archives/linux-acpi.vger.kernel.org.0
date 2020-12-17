Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B122DDC01
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbgLQXog (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgLQXof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:44:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C77C0617A7;
        Thu, 17 Dec 2020 15:43:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 3so559247wmg.4;
        Thu, 17 Dec 2020 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGjgXza+FG01h/JQoRfmC2web91PoTk50kjVfFmC+Bk=;
        b=rrPRKNOXArB8EfEK9dLFvQBlLOialUzkQJzDKZTV7W2AhNCRFWtQCObbaPjbbB5nsC
         ln0NgkU9Y7P/tfB5lzhCk+pCcfnV87PMdCD26G8/VqFzVbKBLE/NqrmgnDWYF/PdLg4R
         d7szjyZw2dDGXQXDWt6fsmZUMo5youg442pZ7xrrldIRGMayHn5iCrPA5/hNpLKOGLm6
         bMgi1gSnxxG7cu+HbB3qysA7FXl8mUovsvzN+f4wo82V8Zc/76vBKW1Lf0dA8NKbIVTm
         xblbMBqyX/6trN6Pradf4hZK17t8cpsq4mbJn6gI7o8xnbwHRjcXapOpgoPO2ofLdc6Y
         FLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGjgXza+FG01h/JQoRfmC2web91PoTk50kjVfFmC+Bk=;
        b=L3nCnBFJ037RO2Vb9Aubro1Na1r6Tk1X96peKTM+VU5XVZmQRunU1f3POpUFvn/BQM
         k9goucwAiObhKNp9zoiHzw0JFjrUOrlcySITHyRG9A8FNFXsABKArmrhz8MWXOehIUtx
         gFPk7Cxe9QBxhKptIxdLu7joPX9UFw/dmTQzjI/NqzpQGOhtfTtJSOkxdJGy2+FFq6Bh
         ypOA97KAeo0UXpnGG+A4o1er11CfvHC44S89/w+GAnVhZqs4TXXhMTihOTp9bFJY3fy/
         QQ24w2neEJZktbcD+yxMxAjrRo/xAo0nfBVeONCDgSFY9/IKs82mXsrC37Ge0zm5rWyQ
         gSAg==
X-Gm-Message-State: AOAM530i4Rog7228j6+y+jixUTglmAcnLppow+tBVkG/zYgg83qp0eMz
        VTPuQLn+mji6VWvgLsCOws37X8wFdyDG1GW6
X-Google-Smtp-Source: ABdhPJzwmyCMhBM+WTNgZczB1JPvQA344VXaJM58xVEVaqhr6tzOBXfPz9up3q+ofqYPcrGJRCxkOg==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr1586073wmc.10.1608248633449;
        Thu, 17 Dec 2020 15:43:53 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:52 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 01/12] software_node: Fix refcounts in software_node_get_next_child()
Date:   Thu, 17 Dec 2020 23:43:26 +0000
Message-Id: <20201217234337.1983732-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The software_node_get_next_child() function currently does not hold
references to the child software_node that it finds or put the ref that
is held against the old child - fix that.

Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 drivers/base/swnode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 010828fc785b..615a0c93e116 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -443,14 +443,18 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 	struct swnode *c = to_swnode(child);
 
 	if (!p || list_empty(&p->children) ||
-	    (c && list_is_last(&c->entry, &p->children)))
+	    (c && list_is_last(&c->entry, &p->children))) {
+		fwnode_handle_put(child);
 		return NULL;
+	}
 
 	if (c)
 		c = list_next_entry(c, entry);
 	else
 		c = list_first_entry(&p->children, struct swnode, entry);
-	return &c->fwnode;
+
+	fwnode_handle_put(child);
+	return fwnode_handle_get(&c->fwnode);
 }
 
 static struct fwnode_handle *
-- 
2.25.1

