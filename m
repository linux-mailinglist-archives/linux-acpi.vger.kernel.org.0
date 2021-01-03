Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E42E8EDE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbhACXOT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbhACXOS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD5C0617A0;
        Sun,  3 Jan 2021 15:13:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so29983006wrm.11;
        Sun, 03 Jan 2021 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAqkkyYwyPFHbEmWCS3R50YVCMCYrcz4Bx/nBN7je3I=;
        b=bAsLflULZRXQExGUX+0UdEP0a1Ns96fYqj/jUjmNEL05faFv6FTb705JQeLXVn7s3t
         ecximccKmAAKVt8gbGlJiPzIkmKk41bfc56zCWYOvCUtEqSNDRVXgjlhleyDua26Zer6
         7iJ1ChFyFnCUtPTK/igfH+UOFQtiSY9RzxtJ9lswzZiIuumuf4V1mE1Gpm0mbMilrZeT
         7OXcZSvywIZ/RLVRh8oYnIvWiooQY8ghXOBEZp1oqsbNqAkGR2yEZinbsHkC5qKwPiQk
         VCuMujgaceVSzKV49Xs+RKOFi9OtWtb/erMNWqif7Hgoampo7Tgk785EMUq6qTVMlz8I
         79Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAqkkyYwyPFHbEmWCS3R50YVCMCYrcz4Bx/nBN7je3I=;
        b=azxe/0qdTCDXMoaER2B3EC/qr6qr6uAiGVbSJijCY054yzD641+UtqbPZI7KroqyfS
         BYge+43AtMB0KVB1SPNaDFbU7Crlt8FwOl79kcI505F3DXF/ha5613M2K7l7nDkHfL5b
         2K5R919RZudjjftpmjiskMC9vQJ+8STHE6zYnprxuQaM5PSH9XkiekXsLxuryu/H7Zld
         /QpaODAJi3O5ZwgRC+fEGZKqWMt/j2g2fu640H3TXxBB32jOmzL7enIxUtLnK2YRKhZw
         6mKzZ1YuJmcS7C+9RsAaxm1HQV77PlCO0l9eMFckrZ/bTKwgDca2HATjw2mRFyBZpDUn
         QxHA==
X-Gm-Message-State: AOAM531ry4n/8ZCJ+9EIwIhuyE6zxmiTW7QjEdvOdfTyq/x6LlEfF2Vd
        JcLuAE/dARlURx1v6Jpu1LVzmnz5Y30uxMXS
X-Google-Smtp-Source: ABdhPJwZpbVvZoi1jbn1ZAbjJknVkdcChkUJA5YNjBA3Xr6NErCmPZlCJwZt4JXAvXELiWprKM15+g==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr77599309wrv.132.1609715585852;
        Sun, 03 Jan 2021 15:13:05 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:05 -0800 (PST)
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
Subject: [PATCH v4 09/15] lib/test_printf.c: Use helper function to unwind array of software_nodes
Date:   Sun,  3 Jan 2021 23:12:29 +0000
Message-Id: <20210103231235.792999-10-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

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

