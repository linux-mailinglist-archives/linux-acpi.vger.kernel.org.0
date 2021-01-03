Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA22E8ECE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbhACXNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhACXNg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:13:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B525C0613C1;
        Sun,  3 Jan 2021 15:12:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t16so30019144wra.3;
        Sun, 03 Jan 2021 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj8Kk41KDbEvFLR6VVSK7iwBFdicxvK1tQNgP1oE8J8=;
        b=LOqr2nPjnGwuOf6I0blQ6EE2xh+NavKW8DbropEelg4A/lD4K7NDpbL1mH7X+fpS9T
         vsVUlFtwiEQztq1lH7G2h97l6XsS+Fd3L9/sdwx2LqByoA7fBK+cGzM+rMOjEcDV7ls4
         30V+44nZB7C3nfj0tX+QvsYRTd67lRq72IxAvHMI3PJPiuHCfAqNrAhtM7O1O/Bgku5Z
         2BoD+sy63Rr6xBpxzhGnQ0H/J6+aYCN+6ZFBY93n2L6K4F2qTgl+UqBsgm0V606+cB0a
         XCdk6jqT0xX+CXXBU5P/P8Q3pa8YF2sDhTzfcuVh9jSyQbTICEKbcJYCoBrAvHHAtHwq
         +aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj8Kk41KDbEvFLR6VVSK7iwBFdicxvK1tQNgP1oE8J8=;
        b=bJgkAB9umsj2v6EyzX0S1y8xCWGRaN6v0jAC3ZXR8bXHxlEjFcqWjJn/R7wb4CpGja
         zUQ+yKAiJuDbQIyxd/ukbm9FBDEB8nH/UDVKCeykjiXUAm0z5z5nyur2KLNB7xeeNUXs
         sQ5RsNcAwKwGJwDXl3mBwUTemaJlrii2e1UZDGDty3MhEuQLdl7LbRajRAr0VqjbP5YQ
         11yZ7nf6wCakw3TVGVObAyVjMrKLgAqXmwR8fseiSLtpgo6VsZ8aICqy+RO1GFeaM9gO
         bQTFbmjfXpYyOdURPvQd8K3RYK9pkjRolKsHMnJy8reVFael75cFMVgUY/0GkwOPvdGA
         vTxA==
X-Gm-Message-State: AOAM532+d2bkMUbKfgF/I99rvI6oQNUTG5/lR2Znh9Le4naGAntkTRan
        70WAqmHEfwltu55lB6hpmIof4J1sFhu2ihEf
X-Google-Smtp-Source: ABdhPJxyoycOlujBIr+fRlhxn+S2GEHyrNdgui7hSt2Zg5gWSbLuUvqNH9J/w1b2BMP95YTNSj8fEA==
X-Received: by 2002:adf:e704:: with SMTP id c4mr77855006wrm.355.1609715575108;
        Sun, 03 Jan 2021 15:12:55 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:12:54 -0800 (PST)
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 01/15] software_node: Fix refcounts in software_node_get_next_child()
Date:   Sun,  3 Jan 2021 23:12:21 +0000
Message-Id: <20210103231235.792999-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

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

