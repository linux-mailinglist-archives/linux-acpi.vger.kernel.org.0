Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBD2DDC1F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgLQXp3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbgLQXpS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28DAC0611CB;
        Thu, 17 Dec 2020 15:44:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so250744wrt.2;
        Thu, 17 Dec 2020 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxoF/I7GjnQos9P0XrAdNbghzE7MUAe2eW4mMwyagRA=;
        b=qV0/mL37jO+KmDWIDMJcAcXwHiw6GUsCZZiX1E1mWbt+CKDKTUCjsimECFkCHzU2xb
         oGgP7dOOxVuIJpccmebUs9NRjf9NNvsI/RofiS+YjbDKr7hgei+RcTOpK+TCDZyK1Y8e
         DGqI28OmbcFkYN8WtlnjDiyg1OsInh9sE2+YjGpxtgzttirRMtkQF+H8uiigNA5QOfp5
         MLlROH2wqE3nBhBWGwM+k/hDR6MpHE82OKZdidjcTO8kKgK3Lcihw/p6DZPHe+JwiFM5
         8ARI+hheGuzK/OkoxoULcPGtzhihQLLLk9AdcrDyrBmYlBhDcr//dEKC0DljJu7hFXRb
         DGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxoF/I7GjnQos9P0XrAdNbghzE7MUAe2eW4mMwyagRA=;
        b=kBbiAxDxcmhcoJzCbkcr1OARK7m/uRvQrzEEewCOpPfG2d9VueYfmUiuidTkz2/JxM
         TcdlTsiLKoP28f+sKn7Cqex5BIplwMSxa+Ffncdn9HDB4oem/I0Yuq9k+g+dOaZI0dnd
         wMDh6vxwXUJsIIHO09UjtbTz98MCO2aqF8O8oAkRkxhzTcB3jV7MZSpbqL/asKBeZ6Tg
         UkY6ejC9PYgai37y0sYXOoULOykqfzfHvgQqUkhhTqRplmzDvFQFVSGDs3QuN2ZkHoLb
         hhI+BkR1EqS48wuQGvZNneAdJb18HwhmKIX8F6D9UOCsa6RnXJ4DjzhNBpp21fNt+hs7
         i5pg==
X-Gm-Message-State: AOAM530c8Thzn5XgEp04g+ITUBJUUxflKSjb0oka29AQvwrDd+DeCOMy
        RtzXY+MjFLw+TaamGRTRtIXlF0lpwiBW2dP/
X-Google-Smtp-Source: ABdhPJzDyKCaJKHq6s9CdN5vYZ6BgtJ6VkOwN/2pZfZtcYbibNIvU/g2usqcXUqHxdpUex5JmyGIuQ==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr1218180wre.413.1608248645403;
        Thu, 17 Dec 2020 15:44:05 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:44:04 -0800 (PST)
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
Subject: [PATCH v2 10/12] media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in match_fwnode()
Date:   Thu, 17 Dec 2020 23:43:35 +0000
Message-Id: <20201217234337.1983732-11-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
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
Changes in v2:

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

