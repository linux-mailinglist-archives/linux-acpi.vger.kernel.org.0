Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14E2DDC03
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgLQXoi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgLQXoh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:44:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EE0C06138C;
        Thu, 17 Dec 2020 15:43:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v14so531558wml.1;
        Thu, 17 Dec 2020 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2D63LdgVtcR4/tv7YaOjAC2rW6v7Ot1epxf/JXyTdFI=;
        b=aDKCoO63cjworyHY5zkMXmUCGgG2xTtZSue16SQEriXx4wn29dqrvrjrqqHEdzoeIQ
         3X+rp09nI04kgEk7BCL68WiCuRrp9xZXmfUG3aTZcz0tBGu2CGz4L6TFIFLyDDri1GrB
         t6wMLhOURcIt5KzV7+UDBfA9vhXlhkT2xn1CVHyD3YBUKi1fmrmiY33l1epNRgFIemUW
         pSZGvb+dY7CwPCOFurNYWiqvGSHXLlBurZxv+2nMFuQmdWixFc/wqQ9t/nB3N+L4babb
         BE817J7hYjSuljVyrLtzmBXaqL6zvn4+CtXV8ymFtSvoBQdXsqZz4C63suuqmxPC4nPv
         AeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2D63LdgVtcR4/tv7YaOjAC2rW6v7Ot1epxf/JXyTdFI=;
        b=F+VqNP9NMA9c2qyIf3knUP8X3OkFjEq0V2KPamRgeEHkENbOkiSAD28t3GbiOGZyPX
         YYNMFJCrKPtMYeWtduit4eXaJ1CnNCIaxJ7VcFMoCs0XpisR8H4ulvkvNZ28/8oSacOi
         toacUZo5AkqxndZpYNi8w2hj8cQbGAbHRBS5niXJw2YJWh7yvkfCVdMy16s4fV6Cf7ks
         s01aypq1KPDwjzqyJ/HwMMavP9rB1LtjAP4TW/yeoYb977c8zS1woYNgXAP18Vb9QIWi
         woGvWY/mZVsGKXX0a7I+KPoEX1ujGyY+F16cWQFVdYiPDfxTnWSaTFuKlYEoW2vzdoV0
         0PRw==
X-Gm-Message-State: AOAM530XMu1+RQoxuFaEiAAohbpb0NygXLzEw5p+segzJc0Ro/WzoF8d
        S8R7OJGOvGrrtWIdz4grgh5mIdpHBjNx/jFV
X-Google-Smtp-Source: ABdhPJw7bOQ5fSHhp8BUhvO0zjhy4WuOaDJPqEu2Unh9jf7ITcX4oaKtn24+FuZ2k+cjGuBNpG6PsA==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr1633738wmc.14.1608248636146;
        Thu, 17 Dec 2020 15:43:56 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:43:55 -0800 (PST)
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
Subject: [PATCH v2 03/12] property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary
Date:   Thu, 17 Dec 2020 23:43:28 +0000
Message-Id: <20201217234337.1983732-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
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
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Some rearranging of the conditionals

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

