Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C12ED0D5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbhAGNay (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbhAGNaS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB43C0612FF;
        Thu,  7 Jan 2021 05:29:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r4so5518340wmh.5;
        Thu, 07 Jan 2021 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JGyD3hkdJmnqfda58CfnRRt8A27y2P17+ogpq3Ke0k=;
        b=d/DQ9wOXKQ+qi4Ft4lpUYczdF56IZocYPZ1DC5JNHHIJexOrr6kxvoZU0NW/hPrQDy
         2K54DMUlIGxR4i0A12dGic8KVpLCAG7o1SiWrfzqMZv96AbXGXcbPrjs+khYRN/Vgrv5
         WyKRLX9TtnHMhSodsp47tdRRI/Pv1LN0wp2yQQqpOFaE2zvrXabQ09pq/l4yDEFaEJH/
         BzcOmJUJtL3ySIsY7qUOm1vhEFDUgIARUUnwdLuGUPl8ji8UctzDQN+tSySTRbzPNpi+
         AzgYzLQwIWaUwhLjLBOMGH7hpv8Rb9gq+WwNgSYRXC5vz8Prwi6RJfyjBZArWBFgYpZq
         NWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JGyD3hkdJmnqfda58CfnRRt8A27y2P17+ogpq3Ke0k=;
        b=NPoJNJcVsuJ4j3l6NIG1Sm5HhaosxNcyF7Xwwe9KLIL1vnXYdbfw01Ho7TLIBgDyou
         32rrymPZ9GO4FiqoMLmT8+CIHNdGdnD0ZKo/vDDpAwVX3ozgb8Bo9+y/VQPUl114RHGg
         f74HtgsGLnJqTk3kSCYB3w3pLq19qOLCbEga5X+3fMZWkP+wRHrufSsZK4j0S+ITqNz9
         K042zuJTSw1VaCv8fMgIHe+wUSKb7w4ks/GGzOPSdR9uAWlKMOcfrpgwVppALNhYjxdU
         wlp2esKedPRUp9FydmHqoMjsoO9PzmkxwzLnHoYnmlFVex+6M4N1WrTHzsxv6r0SojDW
         iBdg==
X-Gm-Message-State: AOAM530Cva1QwMhzt3XhLnwh4Xo2eY4jCumXZmdYmHj+vG1I4J93dEVT
        bwkXZAbRbrCuC0cB3AskuDMNlSLkd8aNtGPv
X-Google-Smtp-Source: ABdhPJwqziNHSBuuiilYRk59tWjXNnZELM2SRFY3MWLfDTUKakbrUnC1FeE2G6OcXLO8ZDBXK9WI0Q==
X-Received: by 2002:a1c:6287:: with SMTP id w129mr7904442wmb.71.1610026147499;
        Thu, 07 Jan 2021 05:29:07 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:06 -0800 (PST)
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
Subject: [PATCH v5 10/15] ipu3-cio2: Add T: entry to MAINTAINERS
Date:   Thu,  7 Jan 2021 13:28:33 +0000
Message-Id: <20210107132838.396641-11-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Development for the ipu3-cio2 driver is taking place in media_tree, but
there's no T: entry in MAINTAINERS to denote that - rectify that oversight

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- None

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 471561d9d55f..92228e8dd868 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9017,6 +9017,7 @@ M:	Bingbu Cao <bingbu.cao@intel.com>
 R:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
 F:	drivers/media/pci/intel/ipu3/
 
-- 
2.25.1

