Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C067B2DDC13
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgLQXpS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgLQXpP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017CC061257;
        Thu, 17 Dec 2020 15:44:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y23so572821wmi.1;
        Thu, 17 Dec 2020 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhV0D9xuOLKxtzOWkibLn3uvxzcSBCPiXhXcwXUTilM=;
        b=g2TSU9X4omWopl89Jo0LZ6GhwCl0vy3NOdWDxlgJzd9MJ4kD23p2lAXsB1ak/v9AYP
         p6bRMhpmRYZBdJeolDOkLPzHHvX/pTgW9VVmlM0Wu+bgvzoCI25B2SAJ5/o+0DDFRUH0
         H3I86/Y7jKjQwjjWJ/Ph6ltdqzuWCO90o56tQ3/3YuuLvtuhL8SLBKO2rZVzzFzsp+b0
         z88YNdTY+tW0TrDTHOfkgXS8to2MevQ3b4iZTRzqOyQKHVWs8x2xRrFqkjfxPPIqqbpP
         FVOuj99pHEpHNo+sT8r8SjpA6v9iNRevjFEd65ABKnSmx2wBIDucrf29f/+CM3svwdIl
         Z+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhV0D9xuOLKxtzOWkibLn3uvxzcSBCPiXhXcwXUTilM=;
        b=P5nO0nCbqTZ6IhFN9TdP9s7xMW76l/UtEtE39oBW6VWhX/I6w5IzcHcyTx/2TXpA3F
         BZ3deKqAIC3WTlpzfVt4z0CoEJ/sDxs4+hNGt6NsNt27/ND0vJET9TAT8rp/ZlBgeW8A
         9hrP4CqPXU1IIN+QdnRcK+jKguhIvUjZ7W/t2uHJSaGSQRnSdfDpjQwkZbw0hvwztLZb
         xZn+kNf3moBhTvljLPv0uVveH/ho9A1io2lBWqj4OLkKM6Dh6r+3Gl9iSy6HoCPkK4HG
         Pph2yvFme2W8ZXr2fSOQ7prgNQD+a3HbB9KgcjZjGmm8/lyn/hlhhFxq/gg+JKLvicK8
         nZog==
X-Gm-Message-State: AOAM532pZEihYpKRu6QJuz9qH89m6gTscCy+qMW5ypFd0XY1oOrkuxeN
        ZT6A+n0ruLyUpDk8axy5zww47ENtpdJ9qn/9
X-Google-Smtp-Source: ABdhPJzs3MQAOJ62JKkc1AKPkounfyMsx9EiBFgBKAjwzggxEJ3tQ2zekKlfhxG7zlgfn4K0wTcz4w==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr1580311wmb.144.1608248641472;
        Thu, 17 Dec 2020 15:44:01 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:44:00 -0800 (PST)
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
Subject: [PATCH v2 07/12] lib/test_printf.c: Use helper function to unwind array of software_nodes
Date:   Thu, 17 Dec 2020 23:43:32 +0000
Message-Id: <20201217234337.1983732-8-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
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
Changes in v2:

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

