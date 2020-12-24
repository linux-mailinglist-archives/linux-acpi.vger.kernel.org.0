Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580DF2E2337
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgLXBKo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgLXBKo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E6C061248;
        Wed, 23 Dec 2020 17:09:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so382472wmg.4;
        Wed, 23 Dec 2020 17:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gb2dOp+BlQhkJy4jaAUNLb3VFWY7zuTuzj9/U8tOxQc=;
        b=lE6qJaKLgW7ClKBMnibRkDaSRDaYBdzr3yC/JtukcWTsIgjrB/ovAlfChWKyrUSbd0
         /4Apxj3xrTXRG2xRD/pwae+oAPA7TEzaNJABewKhEs6oL86wwmuCGgenaHwZxPBy0qtD
         WnOC4zG7d/rPPXNePGO5n44xF2+EafnKt1VhTIlPNOmapdw11AkjvaI6Ce0zoOW7ODhj
         pcObVOvul1cDMYNwHGJRFzqsch8f+4ARqcJ7wsx1bZssG6+pf14hiAQRDZzkAn5AHCbG
         j7s9G3Z1PQIbqOXePk1snh+A+8TrNgakE0u276GkuUqIQmjqz1NI7EKV5nXo5bVp1TUG
         SGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gb2dOp+BlQhkJy4jaAUNLb3VFWY7zuTuzj9/U8tOxQc=;
        b=ELx4fU3t6qcCl8xm5883M0MMz45v75a1bA27si+cVMAdJdfXHqctkKTqoziUYbZALG
         F9yA9DO9hsIUWyLZ+y4izrGNffT7401HgNgaA/R/kV7VXtiXIGY4WvvIlXh6Lk19DUIt
         +UNJIx6pVhkfxnoE1e5N7vJRAsiXrkpbo9ms6+nDSBj91H7HWXAQhQ5BQ8H7q4VINH+a
         QVKTXYb0+abyd5ov2zX98YEdqxBuZHoU1RE9HM1cVs+U3wsXn6v0XXmKZaOH2CUzpLjd
         l8x/PeXapzLu/ptYo6pU1HvBY8/R0sYM1FWrAoZ2gr/AzppawFr5kjt994SZbQpAKrB4
         jgxQ==
X-Gm-Message-State: AOAM531BINojp/rRe704+NYjCA7t3Q8XBEufqNRdo4jVbVgx7Dh1HKrk
        Rzv6FW2EJe9csAtv+2j2d6EgECTS28wRX33U
X-Google-Smtp-Source: ABdhPJxaaD2Wz/omnEa5F/In+7imoucZcLAoXctoxjEnj7kUCgw5GI+bxHWUsJMXzc079l0UnqqrCA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr1953635wmi.57.1608772169900;
        Wed, 23 Dec 2020 17:09:29 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:29 -0800 (PST)
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
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v3 06/14] include: fwnode.h: Define format macros for ports and endpoints
Date:   Thu, 24 Dec 2020 01:08:59 +0000
Message-Id: <20201224010907.263125-7-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

OF, ACPI and software_nodes all implement graphs including nodes for ports
and endpoints. These are all intended to be named with a common schema,
as "port@n" and "endpoint@n" where n is an unsigned int representing the
index of the node. To ensure commonality across the subsystems, provide a
set of macros to define the format.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- Patch introduced

 include/linux/fwnode.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9506f8ec0974..52889efceb7d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -32,6 +32,19 @@ struct fwnode_endpoint {
 	const struct fwnode_handle *local_fwnode;
 };
 
+/*
+ * ports and endpoints defined in OF, ACPI and as software_nodes should all
+ * follow a common naming scheme; use these macros to ensure commonality across
+ * the subsystems.
+ *
+ * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoint@"
+ * sections of the naming scheme.
+ */
+#define FWNODE_GRAPH_PORT_NAME_FORMAT		"port@%u"
+#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN	5
+#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT	"endpoint@%u"
+#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN	9
+
 #define NR_FWNODE_REFERENCE_ARGS	8
 
 /**
-- 
2.25.1

