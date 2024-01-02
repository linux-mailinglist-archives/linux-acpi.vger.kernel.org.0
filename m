Return-Path: <linux-acpi+bounces-2674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7D822320
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8126E1F236AE
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCB19441;
	Tue,  2 Jan 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTa2leDx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75119465
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jan 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so507821439f.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jan 2024 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229742; x=1704834542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6j1jotrF6PIPGIyj1YNZnkSmwkK1WAFrbZbjbyI7go=;
        b=VTa2leDxBK9KlSyJAN+wQVXeA1P9mITLlz8byiLbkbleOsU2gLTU7X0nQz3gcCCSE0
         wj/aQkuDG9REKxEHVAzkvWZ/OldAVYC4tkeCsOvgyWxv2QPLLgy8aelwkID87NWiFtzW
         +YHSpuj+3e2XnAHEZjOe4kTixkYZQnfUHEn40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229742; x=1704834542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6j1jotrF6PIPGIyj1YNZnkSmwkK1WAFrbZbjbyI7go=;
        b=F4sMgHvTR9Y+/85ebLbDjALqLHPifYidb0ykY6Wp/hDTfWvCHNBfC89t9ouaDOL0gE
         tWy87eJw8/mOEb19hZVQd7DldwchiWGoYysh3upqKGGiIoU/7TXYYXewIobl5GMiYVX4
         P662MiwUgrZTa6kMnRjyKqYPz19ohD42/MiZpAP1tzOn5WTlNcUIMZjXVveYgXS2PQu8
         83z8QByL4HQqrKujKvxKzIGKnSLiz2bMHDnbtsjjYZT64NbdqARa1OCnhbXs0YJs2sXx
         KE03mO/9ZI9Mu8qTMEFHwcxbSrK8AfqexJEVZW7nC+0c0b/YErRZ9hJZq5Lk/bPQNZFr
         Ho5A==
X-Gm-Message-State: AOJu0Yx/eKsadonxX9vevymlapEu4dl9RvMddfE/XikKWbX8zlDCp50R
	jT+buYEaymp/GcHz6WzIv2GtD2LL+06k
X-Google-Smtp-Source: AGHT+IEnk7hkWBTpiE59//TC3J8Hc2YJfZJNZSBWZ/zM4jqFy4w9a/MURJc4iEaZLOWtCJ4vPXcb4Q==
X-Received: by 2002:a05:6602:19cf:b0:7ba:8706:3413 with SMTP id ba15-20020a05660219cf00b007ba87063413mr23570270iob.41.1704229742417;
        Tue, 02 Jan 2024 13:09:02 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:02 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 21/24] device property: Modify fwnode irq_get() to use resource
Date: Tue,  2 Jan 2024 14:07:45 -0700
Message-ID: <20240102140734.v4.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The underlying ACPI and OF subsystems provide their own APIs which
provide IRQ information as a struct resource. This allows callers to get
more information about the IRQ by looking at the resource flags. For
example, whether or not an IRQ is wake capable.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Add Sakari's Reviewed-by tag from v2
-Remove ioport.h dependency in fwnode.h
-Use Andy's @linux.intel.com email

Changes in v3:
-Add Suggested-by tag
-Initialize struct resource to 0 on stack
-EXPORT_SYMBOL()->EXPORT_SYMBOL_GPL()
-Remove extra space in commit message
-Reformat fwnode_irq_get_resource() declaration

Changes in v2:
-New patch

 drivers/acpi/property.c  | 11 +++++------
 drivers/base/property.c  | 32 +++++++++++++++++++++++++-------
 drivers/of/property.c    |  8 ++++----
 include/linux/fwnode.h   |  8 +++++---
 include/linux/property.h |  2 ++
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a6ead5204046b..891fff5a16797 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1627,17 +1627,16 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
-			       unsigned int index)
+static int acpi_fwnode_irq_get_resource(const struct fwnode_handle *fwnode, unsigned int index,
+					struct resource *r)
 {
-	struct resource res;
 	int ret;
 
-	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
+	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, r);
 	if (ret)
 		return ret;
 
-	return res.start;
+	return r->start;
 }
 
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
@@ -1664,7 +1663,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 			acpi_graph_get_remote_endpoint,			\
 		.graph_get_port_parent = acpi_fwnode_get_parent,	\
 		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
-		.irq_get = acpi_fwnode_irq_get,				\
+		.irq_get_resource = acpi_fwnode_irq_get_resource,	\
 	};								\
 	EXPORT_SYMBOL_GPL(ops)
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index a1b01ab420528..441899171d19d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1046,6 +1046,29 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 }
 EXPORT_SYMBOL(fwnode_iomap);
 
+/**
+ * fwnode_irq_get_resource - Get IRQ directly from a fwnode and populate
+ *			     the resource struct
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Zero-based index of the IRQ
+ * @r:		Pointer to resource to populate with IRQ information.
+ *
+ * Return: Linux IRQ number on success. Negative errno on failure.
+ */
+int fwnode_irq_get_resource(const struct fwnode_handle *fwnode, unsigned int index,
+			    struct resource *r)
+{
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, irq_get_resource, index, r);
+	/* We treat mapping errors as invalid case */
+	if (ret == 0)
+		return -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_irq_get_resource);
+
 /**
  * fwnode_irq_get - Get IRQ directly from a fwnode
  * @fwnode:	Pointer to the firmware node
@@ -1055,14 +1078,9 @@ EXPORT_SYMBOL(fwnode_iomap);
  */
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
-	int ret;
+	struct resource r = {};
 
-	ret = fwnode_call_int_op(fwnode, irq_get, index);
-	/* We treat mapping errors as invalid case */
-	if (ret == 0)
-		return -EINVAL;
-
-	return ret;
+	return fwnode_irq_get_resource(fwnode, index, &r);
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index afdaefbd03f61..864ea5fa5702b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1425,10 +1425,10 @@ static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
 #endif
 }
 
-static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
-			     unsigned int index)
+static int of_fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+				      unsigned int index, struct resource *r)
 {
-	return of_irq_get(to_of_node(fwnode), index);
+	return of_irq_to_resource(to_of_node(fwnode), index, r);
 }
 
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
@@ -1469,7 +1469,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 	.iomap = of_fwnode_iomap,
-	.irq_get = of_fwnode_irq_get,
+	.irq_get_resource = of_fwnode_irq_get_resource,
 	.add_links = of_fwnode_add_links,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb8..b82c9c072bcc9 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -9,12 +9,13 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
-#include <linux/types.h>
-#include <linux/list.h>
 #include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/list.h>
+#include <linux/types.h>
 
 struct fwnode_operations;
+struct resource;
 struct device;
 
 /*
@@ -164,7 +165,8 @@ struct fwnode_operations {
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
 	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
-	int (*irq_get)(const struct fwnode_handle *fwnode, unsigned int index);
+	int (*irq_get_resource)(const struct fwnode_handle *fwnode,
+				unsigned int index, struct resource *r);
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52a..685ba72a8ce9e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -190,6 +190,8 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
+int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
+			    unsigned int index, struct resource *r);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(const struct device *dev);
-- 
2.43.0.472.g3155946c3a-goog


