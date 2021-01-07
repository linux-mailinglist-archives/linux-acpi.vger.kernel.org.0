Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4983E2ED0B6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbhAGN3l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbhAGN3k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:29:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF4C0612F9;
        Thu,  7 Jan 2021 05:29:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i9so5659603wrc.4;
        Thu, 07 Jan 2021 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjuAIsCe9VKkF/J+5IX/iTbQDrOnLfNuC/kDWAD2YYc=;
        b=c+p7KuMrhW2Wpo3oPiZ/mr7gyedNEc8AfDZr2cbX9VC3L6GypgWk3uQVMHxYNVlD9m
         AUVnJ+icNAbJ5+a21hyCinmXYO3RgsH8wfpcSc2PHWhJYzGsswu1Zlwd5vrg2nq3gnOQ
         Mhg4pTw1tBGltIMuV2h836qmhxECSMWEejX4roObNIQ8WnGXIW3vaPMyT4Ue7qdMUKy1
         IFZGh1c6z7yz6QIOYvfPQ4gmbmgi0gMwYbKndtpndw7eUstZz+ln+glZQODuOj0cU+cU
         Pdd9OxZhWpLH9uvrP8JDVkYAAD10cZL2yEzVaHsaVTmTtZ9/8N1LABpQpJ2g+/nEwCK2
         qkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjuAIsCe9VKkF/J+5IX/iTbQDrOnLfNuC/kDWAD2YYc=;
        b=qrQNtgM2PytBPNJbSEEbIxbiy3JCi+q0xqH/6gq0v2ji3HkSpIbemUGE9mKBB9PY2G
         tl6kJIrR+yopcAF0ovjwrgxsrpOj1QYoBja2cUZGPTx87P+l2VDrKmMgByDabsAGHn+X
         /jVghjt4rFRRxQGDhFPEuyyeanKTd5q8FyDD0qnd1K65fRf2LMArEbJUAbjG0fIufyCZ
         BVkiksK9rGC/8s4k9tKeaqcelHPaojCaRbThH3s2UCNjeUFf46sTwBpFyLXuuIjsR2aR
         m8wR7QLaDsY7KAuib2v0r7teBRa7EdCPVraAm8eqPZU8O0JgIgnaisqm+E26fNVwOLNd
         JlRw==
X-Gm-Message-State: AOAM533AvVe2XT6UQPQZrf9KoMxwxq01TYA8kDCDBH2CGXYvzz1X7prB
        QoFK98SEQSLcRgIbk99Mork/7XtXg825p4+U
X-Google-Smtp-Source: ABdhPJyc73BrGwv2CU2kAQpV8Ix9IIgMkJ00T1XVmaMV8zQO/qPOmfZQOew9wkccp0UzZNeUh4cJ2Q==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr9205822wrv.92.1610026139072;
        Thu, 07 Jan 2021 05:28:59 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:58 -0800 (PST)
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
Subject: [PATCH v5 04/15] device property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
Date:   Thu,  7 Jan 2021 13:28:27 +0000
Message-Id: <20210107132838.396641-5-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This function is used to find fwnode endpoints against a device. In
some instances those endpoints are software nodes which are children of
fwnode->secondary. Add support to fwnode_graph_get_endpoint_by_id() to
find those endpoints by recursively calling itself passing the ptr to
fwnode->secondary in the event no endpoint is found for the primary.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- Changed the commit subject

 drivers/base/property.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 0bf5260f14c6..1421e9548857 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1215,7 +1215,14 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 		best_ep_id = fwnode_ep.id;
 	}
 
-	return best_ep;
+	if (best_ep)
+		return best_ep;
+
+	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
+		return fwnode_graph_get_endpoint_by_id(fwnode->secondary, port,
+						       endpoint, flags);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 
-- 
2.25.1

