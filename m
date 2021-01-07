Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDA2ED0D0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbhAGNaV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbhAGNaT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:19 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E239C061285;
        Thu,  7 Jan 2021 05:29:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so5539204wmg.4;
        Thu, 07 Jan 2021 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbXPmlsNfj3rZdgW4jkqaOrVVChzq9tlyKQWVU1cs38=;
        b=cFwM/aEFWhr0cvn50i/tgxcNEwYlItPIYysJ85JkIZXRS08YXC0luAFW0ptZim0bB/
         Bc7P9Z51Cps76okxUydaMOAn5HeCNPgdZOE1ReAe6qyRnzw1LNRI+iv/oL17yv3y0k74
         9PieMotLzK5Act48skwSutwkHRrx+eEBneeSwvo1zwcNxwWapO00beYD2snAAOmgjP2d
         oALQ1pcEKNPacGPwOmmXFQp+3rwpzxp/Z9NaG9qZ1EA0+BawCt1xN1v60UhjTsMxZxzd
         un5IzFMyFEsD4zDqWB0Q1//DDNHExaB2x2Xzzlgh9IAtnt9FWgcA61qFyrrFkLG+AVg1
         o0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbXPmlsNfj3rZdgW4jkqaOrVVChzq9tlyKQWVU1cs38=;
        b=Eh2k8drjGJwTDGcPhMYPQnNHImUrWSWJtNM6ISDeurId+qWEcCRyoaZYCmUT9leC0C
         094WQpA1GbL/pe8ebt5q1G1MjY7LfwBR3/iHzeduCXMGo8UsL8rgBskItFeu3cClrSj2
         IyNSOhQxeIlnPTr/7e2VAsy8xd1Iw6e6sU3KQXiutGxTo/9VnlZiMk2+Y2BptmlVWMe3
         WYhHHXT6/PBjLjigTlP9X6Oep0c2JVl+D8x3g9O0OjufIbLW2AeklIel88PHbqCBQSLu
         hQgy5m20OeUk/pFgj3yy+UqYQmjHJ1fwxffW8q7Sr4d6RkDnOZcCmvwoSv7nK+AtAU+g
         RebA==
X-Gm-Message-State: AOAM533peGI5tQkSJqz9dH8xKCJhhLoPcnqi/69QKZnh5UpX/Myk4/oC
        7tAKogeoIDKNaILDourkRFAmIL92TgFCGCk5
X-Google-Smtp-Source: ABdhPJyvu1Z/3WmwtfBkIcQLLlj03xuAxmWGX9Qk5zQFUFieIuMaQLzdC+14Z77Q95nEnWmoO364Sw==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr8066051wml.106.1610026150302;
        Thu, 07 Jan 2021 05:29:10 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:09 -0800 (PST)
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
Subject: [PATCH v5 12/15] media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in match_fwnode()
Date:   Thu,  7 Jan 2021 13:28:35 +0000
Message-Id: <20210107132838.396641-13-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

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

