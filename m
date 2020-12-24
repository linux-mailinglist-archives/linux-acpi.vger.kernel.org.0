Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9F2E2343
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgLXBKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgLXBKr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C52C0611CC;
        Wed, 23 Dec 2020 17:09:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k10so366314wmi.3;
        Wed, 23 Dec 2020 17:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G12t8SRflSBjWKMkUq7XNfkQwuwAoCsbQPoo07/audU=;
        b=Z9ZRlGCagCA8BVIDRBDaxpm3J4OHx6tAQQEIbgkTiD52AUYY0Va+DHPtHvwXybxdpB
         djTGOCyc9F7NZMksAgiPjrY/opPI8lP9lXnuhpDF8te7Hx+M2tjt7hf1wNTjVho3DPni
         4Y4uz4UmFsx6a5l5htej72AUKZZlEJsSA4/3UezB6YsCECO468cMuaAIbwbcxV2ATh/v
         hokCsXeCAKoMcDpwPKWdF04DLb7yrpOBLpS+SRrHjsvRyYiM2aqEBuv7d9qDDOn1OaYo
         5T85UCyt2IMlbYGVQBmOEduJeRK+RdK2laTe1ydVEbMFZSyBNH8F5kvbITWWINXtEv6B
         L4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G12t8SRflSBjWKMkUq7XNfkQwuwAoCsbQPoo07/audU=;
        b=s5Qk20QL4gpQI8wp4nSlT4M8FepdUTAxQ40OzpwEKSegeB38U9kP276mMS8LQ1k+LM
         GdywAgqgBfV9CJfNaJ5An41p9OmdG59AjYQGqNB2ojjgO6yGQKHf0spSYgQbt3BX7mUu
         89vQAxTuIw4Jn6kgPNLIrV+AphkCtdPMonDRSzs4Qw2Rt69B6QWZ7zSClEYCvqP86+Hy
         2V4jCEwrXQnR8XFywuqdC6/Qy2aLBW/wAN17L+oIcBMSY1cbzpJnpdC+hx5juijmjCss
         PoVagF96G8ffNdDVXcl414cGABzTbUSg7YSRDd/UV904Nmqx+OaChKzMCA+LHwZRn20j
         Hc0w==
X-Gm-Message-State: AOAM533ejRyYKoTpUIO4oZB+ZtwRFkOiLdMWw4LHTzs9EIslwIu5n236
        AaxupZYbwB3e9sN+nxojRLeUOUNXKw9lKUOw
X-Google-Smtp-Source: ABdhPJzsO6LbpwKFGl/e+/23/iGpjR9gpH+ydXmdABuT09bXHOHBrXzayp6TnJwky0ybBmcM0RUe7w==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr1916810wmg.145.1608772176560;
        Wed, 23 Dec 2020 17:09:36 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:36 -0800 (PST)
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
Subject: [PATCH v3 11/14] media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in match_fwnode()
Date:   Thu, 24 Dec 2020 01:09:04 +0000
Message-Id: <20201224010907.263125-12-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Where the fwnode graph is comprised of software_nodes, these will be
assigned as the secondary to dev->fwnode. Check the v4l2_subdev's fwnode
for a secondary and attempt to match against it during match_fwnode() to
accommodate that possibility.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- None

 drivers/media/v4l2-core/v4l2-async.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index e3ab003a6c85..9dd896d085ec 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -87,6 +87,14 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 	if (sd->fwnode == asd->match.fwnode)
 		return true;
 
+	/*
+	 * Check the same situation for any possible secondary assigned to the
+	 * subdev's fwnode
+	 */
+	if (!IS_ERR_OR_NULL(sd->fwnode->secondary) &&
+	    sd->fwnode->secondary == asd->match.fwnode)
+		return true;
+
 	/*
 	 * Otherwise, check if the sd fwnode and the asd fwnode refer to an
 	 * endpoint or a device. If they're of the same type, there's no match.
-- 
2.25.1

