Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607B2ED0D6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbhAGNay (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbhAGNaS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03BC0612FE;
        Thu,  7 Jan 2021 05:29:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y23so5550270wmi.1;
        Thu, 07 Jan 2021 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsWfNl/LfJPYltSfgM5k0kShmiXfj0UFMpIcwGS3CSw=;
        b=q5s+uupW2gkoHIZp21Xe/5SEAOCq6vMHXVibD/Ad9n0Obgn5qlboxIVYHE/F767+Pa
         hB6pu8Zgq4L1Jd8L50BWY0Yev5YGNHgAoD6vt5mRbiELfzsLCUw85ve+LGtAQUO7c8hn
         XXYLVF6ElgiOhfVY/lGw+8rrwlY/bH7BqBxGhRI3x8W5T7e0cUobMFBvMf4GbwYqTt4g
         0SRwQlFVApKq7amBmFq8kRjmgsxeP9h3l92LnKumGFy8Td3DS1Lq0eRR38P2lusglZjO
         As+BPJkH0UkwQvkrTffSvZi2S4EyuLK43lWf6onz72i1mo8E78LThQZoCZjH5cSQBC6F
         2f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsWfNl/LfJPYltSfgM5k0kShmiXfj0UFMpIcwGS3CSw=;
        b=ZGVwybUlHXyhU8veK+xZFOLYKC59gwxVqrObc9Q4iBIRAYkAVGaexcCD5hHol99sex
         yUIS/3bUPE3HSjAly3DzEaKl2HFHn9IFxO1U2d3+R+i+JiQfWiShBULS8Snp5vGmcHH+
         rbojiQZ/8hDE7mxR6ttOdgwUXYVvqvUsNydIDr28VV3CvxXo8reMC0Zo/1+mHPvJRB0X
         CiiRcxBtYXvMmdidaRZsXVd+DtSyyn7b4u38kkqCB/p4HQzMQm7qWIbAsYsGhlv15Ql0
         ox3rtN6gawQXjb2telMGgu18R+q+vWzAraMNium4CpV+WyGnDShdQA4BsB/ww0OHw6ad
         cuYw==
X-Gm-Message-State: AOAM531HwPPXVCem1i4k+jWTCNTu2kNTLmpzC/gEb7cSmLykeKoAPNxn
        5IZoXhLnXb27Mjc10DLc5u6PQHDECdwi7wPy
X-Google-Smtp-Source: ABdhPJyKuaTIenzmquxGHWP2i+AduDEM7inet3uRuUb/yiq2bZI+6EQ4tVfIsJF7Hto4otVR7HqM9w==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr8067524wmj.5.1610026146121;
        Thu, 07 Jan 2021 05:29:06 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:05 -0800 (PST)
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
Subject: [PATCH v5 09/15] lib/test_printf.c: Use helper function to unwind array of software_nodes
Date:   Thu,  7 Jan 2021 13:28:32 +0000
Message-Id: <20210107132838.396641-10-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

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

