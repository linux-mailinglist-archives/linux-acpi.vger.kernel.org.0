Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2F2ED0B2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbhAGN3i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGN3g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:29:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D1C0612F5;
        Thu,  7 Jan 2021 05:28:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e25so5562863wme.0;
        Thu, 07 Jan 2021 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1fz7N9POMQoD6CCZqY3kMF8SoFYGfmyToPF9CiicVo=;
        b=GpoTcUiqt7zCsr4ciVLvJqnKIN1EVzDcfHztob15JYQF9FnxhcJ7pY/aqHHae24fm9
         Gp+0R6niQekZgrGngibDXocCZlyPcxe47oIIK1QUdF2Of0lpSAqh85zRMhO6b64RUDv8
         30KhPxeD6esEYlKGJUV0WIrtOCJ2S9YCFE3fa9Y5X7f4w7Y8EsmPnyqaiBq/yaFlR0+e
         P/pDD0LMxcA7+Xwm+UrNR2QeZia5h6EblohSuORPaNpPa/uR/rDv86dFFZvg4DQjKdJr
         OMAqft+ErPk0opXg5/VnEtvSMY4S8I+t5QvaFewh+j5Zv1QBbYspgRbCO/TKpK2CiYAD
         ys1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1fz7N9POMQoD6CCZqY3kMF8SoFYGfmyToPF9CiicVo=;
        b=VoMMHy/XDZTJKkEMQn8DPlAD6DVs2MPpxTtZwTXEuy2g47bHDvV6VPEtSKEx8473dr
         RsY3fz9gSVLnfv01Q9tzOP+Mfk2Jt9Ya8lzkNCsoCeQSOshZc0S4gBhmzzC+5YnKi4P2
         IPHasU36ZxLZLT1cvy3T7zghYHZO/2PI4Ac7RpBY9hKGWZZu0JB6kmRTlUnBR/7V8dgs
         +4JuPFyPPE6SJm3dKTeLCjei+K3Bosn457pI+xi+KhtT+3j4xRpz+FRcULVyRYz6uBZ0
         OYDew8NBxqyUHpqzdweY2BUR146PJ8Dof5pU/IamDqqYMUA8wfRy1CrVJXh/77wbw80E
         RMaA==
X-Gm-Message-State: AOAM532JWX3rLycoeCBd6oo+0za/JHtQtGnedlMWEZhyUwWSkjYU2/yL
        JIYhJtTCfQ6JJliMmaqoHSOH7yVCkdy7mjwE
X-Google-Smtp-Source: ABdhPJzGXRbTZJZ0wVepDUseUSuWmGPfDhi0fcRCYk6CEareGRffB+lP0XKLPoFK1Q1h3c9sh8ny3g==
X-Received: by 2002:a7b:c930:: with SMTP id h16mr8059143wml.175.1610026134879;
        Thu, 07 Jan 2021 05:28:54 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:54 -0800 (PST)
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
        heikki.krogerus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 01/15] software_node: Fix refcounts in software_node_get_next_child()
Date:   Thu,  7 Jan 2021 13:28:24 +0000
Message-Id: <20210107132838.396641-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

	- None

 drivers/base/swnode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc2..4fcc1a6fb724 100644
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

