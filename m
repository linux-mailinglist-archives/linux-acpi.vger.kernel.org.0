Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E612E8EF6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhACXPJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbhACXOR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F7C06179E;
        Sun,  3 Jan 2021 15:13:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r3so30037538wrt.2;
        Sun, 03 Jan 2021 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7c99QcP7HJtqxvOuQihWzIRVYdHKam5Z74CI2HeAVA=;
        b=JfoOOZ8IkpzEPCxgjfCDrBk/cQtWQOqHhzKYo1iy1kUtShLUec9PZPlo0/7PzDlQst
         FX48joZmVxkL9TglDpGNcnHKBuy+E6QaLxNpGd6ywS75mXT1nofTojgey/h+/OqdSAH7
         AHT7OURrasf+Bpl7QEohZfUfEme8MfalBpPUgwiixSOmbaBI78QWmac/HEAi3Z2OxRqG
         jpWZIgVsusrEeR0OArOmpYJJiYzLBmtLQ6Rz07XH2tJx+ptTPavLwfBi5k28dTI5v1Bq
         NBysZFCFoMaagGJp5wOzGXeR2nFJP4fFiNlqHSK4DkqMn/O33SkjaUZQAdRqNzlZZdjW
         GFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7c99QcP7HJtqxvOuQihWzIRVYdHKam5Z74CI2HeAVA=;
        b=P8qO/QP8jyunAE9BWpKDxDCMvKdxvTYfPoUjYpBZexEKtHQN6WKajbXmDneGxbCAyi
         nB9v0dleIGwNJWCLWsE18RpOkcfsFOTJxtjPnd98VM9bPXjh6nzJn8tCM9QArosTG0mo
         lByRPOrlLlB3q3C9GxBlljH2MYS1h+tCby8ExncgMMna6H9iNnwrLOj1xLfKVydD1AIF
         X7w/5OpD+FtntzNbTZpptkxkC2qRJW/59TWYexQOxT3OyGQOg4P1YRt25xd36tvR8huh
         aRUxMG6EQv7CS1pm/1CIR9/Y/upr6eonbmKOJUAh72aaE0xWOnIztA9Etu9f1N60NmAr
         hKYg==
X-Gm-Message-State: AOAM531kw9YDY3pZUGTh/RmsBq2ZgsIi7CxDvDc715ExvSSmFwZSAPo0
        BU7s/Ytl5Waq7eKzWUxdCdGLNZ6ViYSiq7qB
X-Google-Smtp-Source: ABdhPJwxfydTdYllGAbyvdzh8uTljbgULINJBK7gOn5JXFtw6wWHAN4DHkz+7z6+ckh2mpDu1yGV+Q==
X-Received: by 2002:adf:eec6:: with SMTP id a6mr76921433wrp.239.1609715583202;
        Sun, 03 Jan 2021 15:13:03 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:02 -0800 (PST)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 07/15] include: fwnode.h: Define format macros for ports and endpoints
Date:   Sun,  3 Jan 2021 23:12:27 +0000
Message-Id: <20210103231235.792999-8-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- FORMAT -> FMT
	- Dropped the *_LEN macros, since we settled on using
	  strlen("port@") instead

 include/linux/fwnode.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9506f8ec0974..72d36d46287d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -32,6 +32,13 @@ struct fwnode_endpoint {
 	const struct fwnode_handle *local_fwnode;
 };
 
+/*
+ * ports and endpoints defined as software_nodes should all follow a common
+ * naming scheme; use these macros to ensure commonality.
+ */
+#define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
+#define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
+
 #define NR_FWNODE_REFERENCE_ARGS	8
 
 /**
-- 
2.25.1

