Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA534DBFE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhC2Wjf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhC2WjD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 18:39:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81FC061762
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 15:39:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so5132292plr.4
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt+/KTchiEi7SRqxK7aMCZQW49hw+aThg0jidlExq98=;
        b=oR3NzwyZzBfo9kEnzyV5vBSb2VSgssDHyQsvopt2CAWVjo4x0SC37sfkune2S2xnwE
         L3Jd51xuuJetASuuHItNskLXdViv4w/XUt33e34X8PniD6yzh2FcN6qICSAZXlu3HEAi
         vz3GiIVy8yWp0VzE4uuioxX6VR9jpJLVtXaj2lbvPVnSx7gn0ML3EXwiOiiyh8VarrHG
         C7Oc4BbaOoJ8l4tSxuQf7wLKv/XHnofQWNZOD0ubZ8Jy16q5fCcTFWkh84NdLUYoWWi4
         91IMVzaganWxJWZySiRxdHUpa9d5rmlPD7/QrtdVKlP/JOaNPaoL3kX5bYCieuqUz9K3
         /vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt+/KTchiEi7SRqxK7aMCZQW49hw+aThg0jidlExq98=;
        b=ZHLGaOXzByGXS0YJT9ojMVMnTAihP/j4USusHcz8nHuADVerUcfUYSE1xTL1F3wb76
         Iipco0ej4/n4FZM9mn7NIbVOvEWsBp4xosxfpXvyQX2BbM5/V0n+J9zsntKsavhqfRp8
         eZZFvIAdp8YuyoMDLu5wD0TnTuHkqCIl7s132MX1NwB1utgxIWs6phz2hN7RIqPIf20d
         rOWsW+4MUa/Ga1rc+MLHg0f2HTHcepjmqUwfpOHAjtittSDcA7XhqaN17koO7/TEhHBp
         hQt2kCgEaHzNEEaKYInq51YOmZBWfvN8loFXF+QHVsi8Yzu/eMVPaIRgl0X5tyji8qz8
         Z+jA==
X-Gm-Message-State: AOAM533wZ9e7nkfKfVwDQ6W21FsZIZ/eKXsW906drp21kTY9UJ3mBh8n
        gS80JLtg39BpiOtp6rdFdEpGow==
X-Google-Smtp-Source: ABdhPJxgrTMdNaXnmufpECMBW46sGGnkKIdnNAEAp7UrCVwOznH1fdKc35SbsUFWwkKbxChVqMR/Rw==
X-Received: by 2002:a17:90a:5d8f:: with SMTP id t15mr1293430pji.28.1617057542658;
        Mon, 29 Mar 2021 15:39:02 -0700 (PDT)
Received: from localhost.localdomain ([207.53.255.56])
        by smtp.gmail.com with ESMTPSA id y23sm18229857pfo.50.2021.03.29.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 15:39:02 -0700 (PDT)
From:   Kevin Paul Herbert <kph@platinasystems.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Tom Grennan <tgrennan@platinasystems.com>,
        linux-kernel@vger.kernel.org,
        Kevin Paul Herbert <kph@platinasystems.com>
Subject: [PATCH] nvmem: Change to unified property interface
Date:   Mon, 29 Mar 2021 15:38:27 -0700
Message-Id: <20210329223827.2851916-1-kph@platinasystems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Change from using device tree (Open Firmware) APIs to the unified
'fwnode' interface.

Change of_nvmem_cell_get() to fwnode_nvmem_cell_get(), and add a
wrapper for of_nvmem_cell_get().

Change of_nvmem_device_get() to fwnode_nvmem_device_get(). There
are no known accessors to the OF interface, so no need for a wrapper.

Signed-off-by: Kevin Paul Herbert <kph@platinasystems.com>
---
 drivers/nvmem/core.c           | 176 ++++++++++++++++++++-------------
 include/linux/nvmem-consumer.h |  27 ++---
 2 files changed, 123 insertions(+), 80 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a5ab1e0c74cf..2e49304cd9a8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/fs.h>
@@ -17,6 +18,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
@@ -52,7 +54,7 @@ struct nvmem_cell {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
-	struct device_node	*np;
+	struct fwnode_handle	*fwnode;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
 };
@@ -424,7 +426,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
-	of_node_put(cell->np);
+	fwnode_handle_put(cell->fwnode);
 	kfree_const(cell->name);
 	kfree(cell);
 }
@@ -670,39 +672,40 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+static int nvmem_add_cells_from_fw(struct nvmem_device *nvmem)
 {
-	struct device_node *parent, *child;
+	struct fwnode_handle *parent, *child;
 	struct device *dev = &nvmem->dev;
 	struct nvmem_cell *cell;
-	const __be32 *addr;
-	int len;
+	int rval;
+	u32 vals[2];
 
-	parent = dev->of_node;
+	parent = dev_fwnode(dev);
 
-	for_each_child_of_node(parent, child) {
-		addr = of_get_property(child, "reg", &len);
-		if (!addr)
+	fwnode_for_each_child_node(parent, child) {
+		rval = fwnode_property_read_u32_array(child, "reg", NULL, 2);
+		if (rval < 0)
 			continue;
-		if (len < 2 * sizeof(u32)) {
-			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
+		if (rval < 2) {
+			dev_err(dev, "nvmem: invalid reg %d on %pfw\n",
+				rval, child);
 			return -EINVAL;
 		}
-
+		rval = fwnode_property_read_u32_array(child, "reg", vals, 2);
 		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
 		if (!cell)
 			return -ENOMEM;
 
 		cell->nvmem = nvmem;
-		cell->np = of_node_get(child);
-		cell->offset = be32_to_cpup(addr++);
-		cell->bytes = be32_to_cpup(addr);
-		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
-
-		addr = of_get_property(child, "bits", &len);
-		if (addr && len == (2 * sizeof(u32))) {
-			cell->bit_offset = be32_to_cpup(addr++);
-			cell->nbits = be32_to_cpup(addr);
+		cell->fwnode = child;
+		cell->offset = vals[0];
+		cell->bytes = vals[1];
+		cell->name = kasprintf(GFP_KERNEL, "%pfwn", child);
+
+		rval = fwnode_property_read_u32_array(child, "bits", vals, 2);
+		if (rval >= 0) {
+			cell->bit_offset = vals[0];
+			cell->nbits = vals[1];
 		}
 
 		if (cell->nbits)
@@ -715,7 +718,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
 			kfree_const(cell->name);
-			of_node_put(cell->np);
+			fwnode_handle_put(cell->fwnode);
 			kfree(cell);
 			return -EINVAL;
 		}
@@ -789,8 +792,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->reg_write = config->reg_write;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
-	if (!config->no_of_node)
+	if (!config->no_of_node) {
 		nvmem->dev.of_node = config->dev->of_node;
+		nvmem->dev.fwnode = config->dev->fwnode;
+	}
 
 	switch (config->id) {
 	case NVMEM_DEVID_NONE:
@@ -841,7 +846,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_of(nvmem);
+	rval = nvmem_add_cells_from_fw(nvmem);
 	if (rval)
 		goto err_remove_cells;
 
@@ -984,36 +989,46 @@ static void __nvmem_device_put(struct nvmem_device *nvmem)
 	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 
-#if IS_ENABLED(CONFIG_OF)
 /**
- * of_nvmem_device_get() - Get nvmem device from a given id
+ * fwnode_nvmem_device_get() - Get nvmem device from a given id
  *
- * @np: Device tree node that uses the nvmem device.
+ * @fwnode: Firmware node that uses the nvmem device.
  * @id: nvmem name from nvmem-names property.
  *
  * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
  * on success.
  */
-struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
+struct nvmem_device *fwnode_nvmem_device_get(struct fwnode_handle *fwnode, const char *id)
 {
-
-	struct device_node *nvmem_np;
+	struct fwnode_handle *nvmem_fwnode;
 	struct nvmem_device *nvmem;
 	int index = 0;
 
 	if (id)
-		index = of_property_match_string(np, "nvmem-names", id);
-
-	nvmem_np = of_parse_phandle(np, "nvmem", index);
-	if (!nvmem_np)
-		return ERR_PTR(-ENOENT);
+		index = fwnode_property_match_string(fwnode, "nvmem-names", id);
+
+	if (is_of_node(fwnode)) {
+		struct device_node *nvmem_np = of_parse_phandle(to_of_node(fwnode),
+								"nvmem", index);
+		if (!nvmem_np)
+			return ERR_PTR(-ENOENT);
+		nvmem_fwnode = &nvmem_np->fwnode;
+	} else if (is_acpi_device_node(fwnode)) {
+		struct fwnode_reference_args args;
+		int rval = acpi_node_get_property_reference(fwnode,
+							    "nvmem", index, &args);
+		if (rval)
+			return ERR_PTR(rval);
+		nvmem_fwnode = args.fwnode;
+	} else {
+		return ERR_PTR(-ENXIO);
+	}
 
-	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
-	of_node_put(nvmem_np);
+	nvmem = __nvmem_device_get(nvmem_fwnode, device_match_fwnode);
+	fwnode_handle_put(nvmem_fwnode);
 	return nvmem;
 }
-EXPORT_SYMBOL_GPL(of_nvmem_device_get);
-#endif
+EXPORT_SYMBOL_GPL(fwnode_nvmem_device_get);
 
 /**
  * nvmem_device_get() - Get nvmem device from a given id
@@ -1026,16 +1041,15 @@ EXPORT_SYMBOL_GPL(of_nvmem_device_get);
  */
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *dev_name)
 {
-	if (dev->of_node) { /* try dt first */
-		struct nvmem_device *nvmem;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
-		nvmem = of_nvmem_device_get(dev->of_node, dev_name);
+	if (fwnode) { /* try firmware tree first */
+		struct nvmem_device *nvmem;
 
+		nvmem = fwnode_nvmem_device_get(fwnode, dev_name);
 		if (!IS_ERR(nvmem) || PTR_ERR(nvmem) == -EPROBE_DEFER)
 			return nvmem;
-
 	}
-
 	return __nvmem_device_get((void *)dev_name, device_match_name);
 }
 EXPORT_SYMBOL_GPL(nvmem_device_get);
@@ -1171,15 +1185,14 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 	return cell;
 }
 
-#if IS_ENABLED(CONFIG_OF)
 static struct nvmem_cell *
-nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
+nvmem_find_cell_by_fwnode(struct nvmem_device *nvmem, struct fwnode_handle *fwnode)
 {
 	struct nvmem_cell *iter, *cell = NULL;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(iter, &nvmem->cells, node) {
-		if (np == iter->np) {
+		if (fwnode == iter->fwnode) {
 			cell = iter;
 			break;
 		}
@@ -1190,42 +1203,67 @@ nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
 }
 
 /**
- * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
+ * fwnode_nvmem_cell_get() - Get a nvmem cell from given firmwar node and cell id
  *
- * @np: Device tree node that uses the nvmem cell.
+ * @fwnode: Firmware node that uses the nvmem cell.
  * @id: nvmem cell name from nvmem-cell-names property, or NULL
- *      for the cell at index 0 (the lone cell with no accompanying
- *      nvmem-cell-names property).
+ *	for the cell at index 0 (the lone cell with no accompanying
+ *	nvmem-cell-names property).
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer
  * to a struct nvmem_cell.  The nvmem_cell will be freed by the
  * nvmem_cell_put().
  */
-struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
+struct nvmem_cell *fwnode_nvmem_cell_get(struct fwnode_handle *fwnode,
+					 const char *id)
 {
-	struct device_node *cell_np, *nvmem_np;
+	struct fwnode_handle *nvmem_fwnode, *cell_fwnode;
 	struct nvmem_device *nvmem;
 	struct nvmem_cell *cell;
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
-	if (id)
-		index = of_property_match_string(np, "nvmem-cell-names", id);
+	if (id) {
+		index = fwnode_property_match_string(fwnode, "nvmem-cell-names", id);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
 
-	cell_np = of_parse_phandle(np, "nvmem-cells", index);
-	if (!cell_np)
-		return ERR_PTR(-ENOENT);
+	if (is_of_node(fwnode)) {
+		struct device_node *np = to_of_node(fwnode);
+		struct device_node *cell_np = of_parse_phandle(np, "nvmem-cells", index);
+
+		if (!cell_np)
+			return ERR_PTR(-EINVAL);
+		cell_fwnode = &cell_np->fwnode;
+	} else if (is_acpi_device_node(fwnode)) {
+		struct fwnode_reference_args args;
+		struct fwnode_handle *dev_fwnode;
+		int rval;
 
-	nvmem_np = of_get_next_parent(cell_np);
-	if (!nvmem_np)
+		rval = acpi_node_get_property_reference(fwnode,
+							"nvmem-cells", index, &args);
+		if (rval)
+			return ERR_PTR(rval);
+		dev_fwnode = args.fwnode;
+		cell_fwnode = fwnode_get_named_child_node(dev_fwnode,
+							  id ? id : "nvmem");
+		if (!cell_fwnode)
+			return ERR_PTR(-EINVAL);
+	} else {
+		return ERR_PTR(-ENXIO);
+	}
+
+	nvmem_fwnode = fwnode_get_next_parent(cell_fwnode);
+	if (!nvmem_fwnode)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
-	of_node_put(nvmem_np);
+	nvmem = __nvmem_device_get(nvmem_fwnode, device_match_fwnode);
+	fwnode_handle_put(nvmem_fwnode);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	cell = nvmem_find_cell_by_node(nvmem, cell_np);
+	cell = nvmem_find_cell_by_fwnode(nvmem, cell_fwnode);
 	if (!cell) {
 		__nvmem_device_put(nvmem);
 		return ERR_PTR(-ENOENT);
@@ -1233,8 +1271,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 
 	return cell;
 }
-EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
-#endif
+EXPORT_SYMBOL_GPL(fwnode_nvmem_cell_get);
 
 /**
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
@@ -1251,14 +1288,15 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id)
 {
 	struct nvmem_cell *cell;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
-	if (dev->of_node) { /* try dt first */
-		cell = of_nvmem_cell_get(dev->of_node, id);
+	if (fwnode) { /* try firmware tree first */
+		cell = fwnode_nvmem_cell_get(fwnode, id);
 		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
 			return cell;
 	}
 
-	/* NULL cell id only allowed for device tree; invalid otherwise */
+	/* NULL cell_id only allowed for firmware tree; invalid otherwise */
 	if (!id)
 		return ERR_PTR(-EINVAL);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 052293f4cbdb..e52c587d0a23 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -12,12 +12,14 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
 
 struct device;
 struct device_node;
 /* consumer cookie */
 struct nvmem_cell;
 struct nvmem_device;
+struct fwnode_handle;
 
 struct nvmem_cell_info {
 	const char		*name;
@@ -94,6 +96,10 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
 struct nvmem_device *nvmem_device_find(void *data,
 			int (*match)(struct device *dev, const void *data));
 
+struct nvmem_cell *fwnode_nvmem_cell_get(struct fwnode_handle *np,
+					 const char *name);
+struct nvmem_device *fwnode_nvmem_device_get(struct fwnode_handle *np,
+					     const char *name);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -221,25 +227,24 @@ static inline struct nvmem_device *nvmem_device_find(void *data,
 	return NULL;
 }
 
-#endif /* CONFIG_NVMEM */
+static inline struct nvmem_cell *fwnode_nvmem_cell_get(struct fwnode_handle *np,
+						       const char *name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 
-#if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-				     const char *id);
-struct nvmem_device *of_nvmem_device_get(struct device_node *np,
-					 const char *name);
-#else
-static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-						   const char *id)
+static inline struct nvmem_device *fwnode_nvmem_device_get(struct fwnode_handle *np,
+							   const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+#endif /* CONFIG_NVMEM */
+
 static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 						       const char *name)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return np ? fwnode_nvmem_device_get(&np->fwnode, name) : NULL;
 }
-#endif /* CONFIG_NVMEM && CONFIG_OF */
 
 #endif  /* ifndef _LINUX_NVMEM_CONSUMER_H */
-- 
2.25.1

