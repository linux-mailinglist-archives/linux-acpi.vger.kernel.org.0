Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A92E232C
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgLXBKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLXBKE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118EC06179C;
        Wed, 23 Dec 2020 17:09:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t16so849214wra.3;
        Wed, 23 Dec 2020 17:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HcWiJxR7Vdz+U5YIfgJBN9KwYNRqEMiMugHQ+pxTa0=;
        b=NcSi3XS8rc3Qz8C8Kfx1QZ7+1iDCwlAO6j4IhXabqvmpj3nwy6x4mZXT6VIXMPx31m
         FsIMHbc/sOlmMUpSJ1q5Io9d3lKcYIdYMwyqPrvUtfi0YikMx56TFXl5jl9i7mpXU15I
         zEPH59AwsAkHgyIMzSjV5Xjgq/8DhYmT7LlZ9eMwZCoivygw4K6AKiI7Il/0ej2EpD7F
         4MBjft/IjMCzgrZn0/iXaYFkIUd3btW/TBKRsvmufJpHZX1/x+0Zsw8MLB3f/SNzJUlr
         Z1+trU+YKfqmyE2XqxBf0wEIXuDM5BdbGnCzk6mQ99SuZxyc85nR8zE8LabTDeoYjD+g
         ZUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HcWiJxR7Vdz+U5YIfgJBN9KwYNRqEMiMugHQ+pxTa0=;
        b=gq6lPOjpcIQAfwLAH0mem1jypPbsNaVrvmGgo53emcQeH1nXvL7/h8vbIWqnTHMHGh
         bCevC4rgfMHKiliKdtAXn3qIJv6PpBvpcMO3log7mZJA1qq/aaq9q+8ELTTOEp33kv6w
         bN8XhihJ5KfOH2Wkf7bfpyKo5QOE7i9r7qqSsc8Lj9GckKlhC1dLQNrw0lYKBxflWDXW
         bO9Xr204rsxR1Alpvplc1LNPC1DcfSj4aeGdlFlZ5oqMFh38PovthHCdRFQl0QruZ8RJ
         cQ8MBLtmQ+6S+M2d1GFQ0IEOyCwniv7bluGo9+BJzV1D6xNIZnN4gqjDCMfRL6M2eeUB
         5rxw==
X-Gm-Message-State: AOAM5305OZwISOPMBgzO7PcCfpKiVjLzSX3NnwUJjWXdKcLG0gzXOeHn
        T5wmQ3HWtHyslawchrrA/J7cVf47eyYOiZZ7
X-Google-Smtp-Source: ABdhPJyAAGg032fJlZ6cOK39iTdcGjogf8AWqshfPu5S1zHyXFXGDfOvSfIW9CZuV8C50QC0/DT8wg==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr31479177wrq.358.1608772163055;
        Wed, 23 Dec 2020 17:09:23 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:22 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 01/14] software_node: Fix refcounts in software_node_get_next_child()
Date:   Thu, 24 Dec 2020 01:08:54 +0000
Message-Id: <20201224010907.263125-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
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

