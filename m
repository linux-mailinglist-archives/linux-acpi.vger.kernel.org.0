Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7D2E232E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgLXBKH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLXBKH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF5C0617A7;
        Wed, 23 Dec 2020 17:09:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so863280wrb.0;
        Wed, 23 Dec 2020 17:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvDqehonh9fJU3lIRKp5e7XlhCvPU40zhGdMSiw+RMQ=;
        b=pfR/x2jjqaVFnwEQUAurcsb7F7wLH78sdSxLj/YvQic35Kc7FHoZBMqtkianzPN7UC
         chkfTHYaB5Gf9jkr1c5Vt/qnvnmOQ7H4j4Dyd2H6qSSI0ElDqT04m++TdXCwgc5g24bX
         RY4DvClbL+d59qZ1aG6OGAXzsdEge5IxJFR/O/3Qw92fXIhkUqRrFw738V//hXwWzbVs
         E3SO8cQRIhsxY3wCMmAzE0Dp6sKdCPYNU9aSYD+vUvPxIfTD89SqoALjG+ZYU+vy6JZL
         554TamctZqHhyloiMqJQbf0eFkaMIi+HPXaJVI18GOkyjPK3dCkvchshziZAUSMdG2O+
         D6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvDqehonh9fJU3lIRKp5e7XlhCvPU40zhGdMSiw+RMQ=;
        b=MACVDh7Esvnjunr3g7WIhc9Rge6U+HIRoqMXAaQcGtV/XEXht5dZGUIU1u+nI03rri
         XDcr7czvDhme5HajTO9ZofLTSlMvfR0Jti+I0KA/dv7BALYrF8u/gOB24pm9bgbR0RJR
         HLQmwCMEVv8v9CUmfv/poehWD3tOe/kqWq0H2uDJqYkm5xSORYhvh5uCdvVzp4dK6s1K
         EKHiKVrzNyZhg/yHbUFBSEbeB+ocamiSRbmluBWDS9N70yjGxtcG706+1BYlOuoIjZ2r
         ZOu4bWnt2VuQBABC+ZVXT+9JgnSvgAlLWZPxKMCfJpV5Ys/KuIM/Aycdt80vykm2D9Ge
         vF5g==
X-Gm-Message-State: AOAM530UszS4xtI7h0V4vBEaiBZkprx1UBYnvtL0Ype0GUvEkcgvg3Mh
        4vA2UgU1PbDsMpaegJqe2v4YluBCf4CasOLh
X-Google-Smtp-Source: ABdhPJw9zP6EglJ8DwOvG/RvMN7mU/zAxnkt4abmaLIL16MH6/j/6H2GghVT0trn76cwDNzGfT8HCw==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr31544825wrn.333.1608772165748;
        Wed, 23 Dec 2020 17:09:25 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:25 -0800 (PST)
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
Subject: [PATCH v3 03/14] property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
Date:   Thu, 24 Dec 2020 01:08:56 +0000
Message-Id: <20201224010907.263125-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
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

