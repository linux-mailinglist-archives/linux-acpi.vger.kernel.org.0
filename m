Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F342E8ED4
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbhACXNm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbhACXNk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:13:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE6C0613ED;
        Sun,  3 Jan 2021 15:13:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y23so17210158wmi.1;
        Sun, 03 Jan 2021 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehPrHZn7ZZzvSS78OjTsxhmL98CBAFkSirXNPUU4jAA=;
        b=j0pfKVC/7N7YaIP3FiNaGJehrinCecyLVqkZxBeKcfuftdNjmIbdyXdbNtHeezvXGi
         wrmAQdmTHF9+lmAFLzxbAlIUvv0ygLyDEcG1LS7PR6W/iUk+1LyttKIICByxMA9PRleh
         S0aszZtyP4xRM5jFn4irYTcae9yR+7jem7+ao6TTL5YEuZ5kYnRJjqQzLwGYF9zTYzf3
         uAUbwbGNPHzPeYCOcRWJgerk5eiPJuefIR0ry2WlXV4mmsUx04VdIvM4GUzbQA1R/iML
         TN+Bdhfzh9BYN9f/ee+Lf5XQ6Fu6ErlEj4vtY2hMwAtLfWvXkM5UTi+VbIbcFFDY+uzm
         EqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehPrHZn7ZZzvSS78OjTsxhmL98CBAFkSirXNPUU4jAA=;
        b=S/cUR9NHKdm/6w+SoJ+Smr+K+lN2p/iOxY7yQLxyz1mmgWySOcH2gDZr6TP7R20Ab7
         bgI7neaUQLxiFJcAg/DSA1pUs9q2jp9uPMsCk37M8FjFMUs5FliL8xhGc1fI9IRdsMDO
         iRqrDl2tvHMrlyMIlVj9nTY4+ovd3wgRkC93egTtqm7oqdxMuqjhJkg3vIXP3mZH8qDp
         po4INhZoEGMvpO+Yhxn/8U+VJ1vcO9LX6puisXFkanlvUnVVpewIeNM9JXHjxKaKIeYV
         V93TmgbjmISR6dWEMv5EyjFrCk9VY3edXywCmSd4ndxhqFkuWpxAVj3yfjhkFZd6H48i
         9MGQ==
X-Gm-Message-State: AOAM532BbdX9WPcWESfKtRjQtf0AerDspP7y6RFBmOWJMTiQGjADhK26
        hCny4QHiTmrE4R6rql6wAiQ5tJA/KhUIbcTF
X-Google-Smtp-Source: ABdhPJyPhaqRj8QfXs6oxohhlgHo/czPiAWUCmg6dJILSsulSRuV6EMerOq4ZN2pY7i7yzb0XZx8Nw==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr24988982wmh.114.1609715579148;
        Sun, 03 Jan 2021 15:12:59 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:12:58 -0800 (PST)
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
Subject: [PATCH v4 04/15] property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
Date:   Sun,  3 Jan 2021 23:12:24 +0000
Message-Id: <20210103231235.792999-5-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

	- None

 drivers/base/property.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index bc9c634df6df..ddba75d90af2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1163,7 +1163,14 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
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

