Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F12E233E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgLXBKq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgLXBKp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3541C0611C5;
        Wed, 23 Dec 2020 17:09:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so855081wrt.2;
        Wed, 23 Dec 2020 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrWZ4vmWcGXVMa9R5napfQoQ5FKRFGqI2Uo6ZMQnL+A=;
        b=pDz5hfUnX3AukEgHxPyP0Yq8OUi6Zp/bNcXsxPhO66zFsjLrP1fV/j1eUNX6voZ4i7
         DMEaFgPx2i2cmSkfqbfZHy11gGvhRYHw5ajKseo36FYzexoqyI/SThOrnYzyAZd4Qn2O
         nXVQtKVQenYpSz9nrEiC/eq7UWkm+R3ngLOQXyjNQksjy/9wBuAbLifh3AVnlT0a7Ysv
         D7RRpuXbE5L+JspyD5vwzlC7l2vIytcbPg6EvCcdzkg0/8CedztiWlqcGJkcAla/Dvu+
         jn288IWVoFBt+RMD6ibjfecPCYfvHYuXSUK27jzxPKATJ7l+AQSZ468egv4RprYP7/up
         dCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrWZ4vmWcGXVMa9R5napfQoQ5FKRFGqI2Uo6ZMQnL+A=;
        b=XNE885t3+UvxJM0wNyemLnrCWAOalRN9YF5s2b56BEclx+mVQfV6HK60XFKLiOZX4g
         UJCnWXa3ffFbOMVg2BxQhJmaQOj5v6hICfWTDb3//JIti1HHbdabYvjI3kdVAIkKH65o
         s+x4oaPdXAWFWiWHIxOinzLroWTpynfCRsn542j2ul03D+9NHeJIslhsZCiWV5Z6JR7v
         5nWrFg0463P/f62F5kg5N75juoNMZh5fDB/f56gNcYmN+B7KcTmEkid/mOczb3p76qud
         VSNoExUvrwdLBhjWH47uDqlNBA2iQW8pdgH5QxVnAXyEvyhTovY0glC+k4wrfm91EgGe
         la8g==
X-Gm-Message-State: AOAM531tuRsAJ5ni1lDCMa+PxLpIo86X+r4vpytyHMMOqgTu6/nWFUEI
        l8PzL25OxNyY1lNBiS9CowyDFiUQz0YvMCfP
X-Google-Smtp-Source: ABdhPJxITjMGrsegwYlQ4qrtkCCofATTFjbq1HCR2i/1CDLo89l6mdFEp2nUewaJ590N3Ndjh0wEGg==
X-Received: by 2002:adf:e443:: with SMTP id t3mr31495512wrm.366.1608772172496;
        Wed, 23 Dec 2020 17:09:32 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:32 -0800 (PST)
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
Subject: [PATCH v3 08/14] lib/test_printf.c: Use helper function to unwind array of software_nodes
Date:   Thu, 24 Dec 2020 01:09:01 +0000
Message-Id: <20201224010907.263125-9-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the software_node_unregister_nodes() helper function to unwind this
array in a cleaner way.

Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- None

 lib/test_printf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..7d60f24240a4 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -644,9 +644,7 @@ static void __init fwnode_pointer(void)
 	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
 	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
 
-	software_node_unregister(&softnodes[2]);
-	software_node_unregister(&softnodes[1]);
-	software_node_unregister(&softnodes[0]);
+	software_node_unregister_nodes(softnodes);
 }
 
 static void __init
-- 
2.25.1

