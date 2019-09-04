Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE488A94AA
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfIDVLq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 17:11:46 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52768 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbfIDVLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 17:11:42 -0400
Received: by mail-yb1-f201.google.com with SMTP id n6so17903701ybf.19
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2019 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r0SSGqejS7hGeDjkHLwcULsZg1wwhwR+jJOFpk7tqQw=;
        b=CJsbVD3OcHVO2BmTaHhLdM8R69DPvFiRNpgReK6ZbRstWbyKjnbhe6ob9xYbFOXw1d
         MgZqETZSg7fULSru2GFIe8C5Z2uapR4pGuS/6FFH3pCP7Wu7W7k2dMcwRFSmx/td64KR
         Pyhj32Z2IEUqzkydVkotEzEu2G51r7+D8QAkPZz8X64FQf124OQwAXHSvUGnGeVfONgb
         2uDDjK3kqiHbCwAlnA8ypHK2+gT7peBGKfiNjNhHpKVGYnWg7jDOoQjolPY5JNKp5T4c
         zd9CKkkKohzS06bXCo950XxLkQCIsMSYbwy/Tpf8EqSRke3bSRy6kSiQC2FLfzIBPw9P
         NXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r0SSGqejS7hGeDjkHLwcULsZg1wwhwR+jJOFpk7tqQw=;
        b=Y6KGQqreQHHEqcQZ1LqySXrHbVt4ll/taiErv21LiukbvSHtwznaCZAwDQOUgOZroD
         3ofzM8TsUX9DSPWo3DsmiSXfVnZz43CduxjjpdLEN615/mejV62RCj/S+9bGR0IPR9RR
         QwMhvJQsXBUMyUBobwRwGf3y24xGtk/85eKdrFtka3L096QBxzRa92eSIv7ZBTXikuVs
         HeFHVNnVECT2LgNKtAj7SajFuiAQbndxhm0coj9mac8xJYJkffVzUR4R9CRlLrntZnEp
         pFyMia0KoYmSv3E/mKg5MmS4u2otPbyG3gNQ3yiBOW+dlPRqgQIRRn3t8/BUga+i2NDa
         mm4w==
X-Gm-Message-State: APjAAAVEZAG4+FBIKofMOI5sM3hZ+Q1fCXUaZDya/lSxFFXOvksLIxAe
        INOSJtP92PuXhNy9iqvUSd1VvHgKy156ySs=
X-Google-Smtp-Source: APXvYqw9DYuppXyE9DDBy3s7xj78/nOW7FpktecBcnUmZZTrDPZFDZFeneaB/uBYHKtgK/U/aBRFEykhiwWAWhw=
X-Received: by 2002:a81:8391:: with SMTP id t139mr29431136ywf.182.1567631501027;
 Wed, 04 Sep 2019 14:11:41 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:22 -0700
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
Message-Id: <20190904211126.47518-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 3/6] of: property: Add functional dependency link from DT bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add device links after the devices are created (but before they are
probed) by looking at common DT bindings like clocks and
interconnects.

Automatically adding device links for functional dependencies at the
framework level provides the following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just
  one consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, interconnect providers, etc
  need to keep the resources they provide active and at a particular
  state(s) during boot up even if their current set of consumers don't
  request the resource to be active. This is because the rest of the
  consumers might not have probed yet and turning off the resource
  before all the consumers have probed could lead to a hang or
  undesired user experience.

  Some frameworks (Eg: regulator) handle this today by turning off
  "unused" resources at late_initcall_sync and hoping all the devices
  have probed by then. This is not a valid assumption for systems with
  loadable modules. Other frameworks (Eg: clock) just don't handle
  this due to the lack of a clear signal for when they can turn off
  resources. This leads to downstream hacks to handle cases like this
  that can easily be solved in the upstream kernel.

  By linking devices before they are probed, we give suppliers a clear
  count of the number of dependent consumers. Once all of the
  consumers are active, the suppliers can turn off the unused
  resources without making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier
devices to change the link when they probe.

kbuild test robot reported clang error about missing const
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/of/property.c                         | 241 ++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index d05d531b4ec9..6d421694d98e 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -127,6 +127,7 @@ parameter is applicable::
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
 	NFS	Appropriate NFS support is enabled.
+	OF	Devicetree is enabled.
 	OSS	OSS sound support is enabled.
 	PV_OPS	A paravirtualized kernel is enabled.
 	PARIDE	The ParIDE (parallel port IDE) subsystem is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index af0a62af6fd8..e95f2a58acc5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3181,6 +3181,12 @@
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
+	of_devlink	[OF, KNL] Create device links between consumer and
+			supplier devices by scanning the devictree to infer the
+			consumer/supplier relationships.  A consumer device
+			will not be probed until all the supplier devices have
+			probed successfully.
+
 	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
 			See Documentation/debugging-via-ohci1394.txt for more
 			info.
diff --git a/drivers/of/property.c b/drivers/of/property.c
index d7fa75e31f22..23b5ee5b0570 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/string.h>
+#include <linux/moduleparam.h>
 
 #include "of_private.h"
 
@@ -985,6 +986,245 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 	return of_device_get_match_data(dev);
 }
 
+static bool of_is_ancestor_of(struct device_node *test_ancestor,
+			      struct device_node *child)
+{
+	of_node_get(child);
+	while (child) {
+		if (child == test_ancestor) {
+			of_node_put(child);
+			return false;
+		}
+		child = of_get_next_parent(child);
+	}
+	return true;
+}
+
+/**
+ * of_link_to_phandle - Add device link to supplier from supplier phandle
+ * @dev: consumer device
+ * @sup_np: phandle to supplier device tree node
+ *
+ * Given a phandle to a supplier device tree node (@sup_np), this function
+ * finds the device that owns the supplier device tree node and creates a
+ * device link from @dev consumer device to the supplier device. This function
+ * doesn't create device links for invalid scenarios such as trying to create a
+ * link with a parent device as the consumer of its child device. In such
+ * cases, it returns an error.
+ *
+ * Returns:
+ * - 0 if link successfully created to supplier
+ * - -EAGAIN if linking to the supplier should be reattempted
+ * - -EINVAL if the supplier link is invalid and should not be created
+ * - -ENODEV if there is no device that corresponds to the supplier phandle
+ */
+static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
+{
+	struct device *sup_dev;
+	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	int ret = 0;
+	struct device_node *tmp_np = sup_np;
+
+	of_node_get(sup_np);
+	/*
+	 * Find the device node that contains the supplier phandle.  It may be
+	 * @sup_np or it may be an ancestor of @sup_np.
+	 */
+	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+		sup_np = of_get_next_parent(sup_np);
+	if (!sup_np) {
+		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
+		return -ENODEV;
+	}
+
+	/*
+	 * Don't allow linking a device node as a consumer of one of its
+	 * descendant nodes. By definition, a child node can't be a functional
+	 * dependency for the parent node.
+	 */
+	if (!of_is_ancestor_of(dev->of_node, sup_np)) {
+		dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
+		of_node_put(sup_np);
+		return -EINVAL;
+	}
+	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	of_node_put(sup_np);
+	if (!sup_dev)
+		return -EAGAIN;
+	if (!device_link_add(dev, sup_dev, dl_flags))
+		ret = -EAGAIN;
+	put_device(sup_dev);
+	return ret;
+}
+
+/**
+ * parse_prop_cells - Property parsing function for suppliers
+ *
+ * @np:		Pointer to device tree node containing a list
+ * @prop_name:	Name of property to be parsed. Expected to hold phandle values
+ * @index:	For properties holding a list of phandles, this is the index
+ *		into the list.
+ * @list_name:	Property name that is known to contain list of phandle(s) to
+ *		supplier(s)
+ * @cells_name:	property name that specifies phandles' arguments count
+ *
+ * This is a helper function to parse properties that have a known fixed name
+ * and are a list of phandles and phandle arguments.
+ *
+ * Returns:
+ * - phandle node pointer with refcount incremented. Caller must of_node_put()
+ *   on it when done.
+ * - NULL if no phandle found at index
+ */
+static struct device_node *parse_prop_cells(struct device_node *np,
+					    const char *prop_name, int index,
+					    const char *list_name,
+					    const char *cells_name)
+{
+	struct of_phandle_args sup_args;
+
+	if (strcmp(prop_name, list_name))
+		return NULL;
+
+	if (of_parse_phandle_with_args(np, list_name, cells_name, index,
+				       &sup_args))
+		return NULL;
+
+	return sup_args.np;
+}
+
+static struct device_node *parse_clocks(struct device_node *np,
+					const char *prop_name, int index)
+{
+	return parse_prop_cells(np, prop_name, index, "clocks", "#clock-cells");
+}
+
+static struct device_node *parse_interconnects(struct device_node *np,
+					       const char *prop_name, int index)
+{
+	return parse_prop_cells(np, prop_name, index, "interconnects",
+				"#interconnect-cells");
+}
+
+static int strcmp_suffix(const char *str, const char *suffix)
+{
+	unsigned int len, suffix_len;
+
+	len = strlen(str);
+	suffix_len = strlen(suffix);
+	if (len <= suffix_len)
+		return -1;
+	return strcmp(str + len - suffix_len, suffix);
+}
+
+static struct device_node *parse_regulators(struct device_node *np,
+					    const char *prop_name, int index)
+{
+	if (index || strcmp_suffix(prop_name, "-supply"))
+		return NULL;
+
+	return of_parse_phandle(np, prop_name, 0);
+}
+
+/**
+ * struct supplier_bindings - Property parsing functions for suppliers
+ *
+ * @parse_prop: function name
+ *	parse_prop() finds the node corresponding to a supplier phandle
+ * @parse_prop.np: Pointer to device node holding supplier phandle property
+ * @parse_prop.prop_name: Name of property holding a phandle value
+ * @parse_prop.index: For properties holding a list of phandles, this is the
+ *		      index into the list
+ *
+ * Returns:
+ * parse_prop() return values are
+ * - phandle node pointer with refcount incremented. Caller must of_node_put()
+ *   on it when done.
+ * - NULL if no phandle found at index
+ */
+struct supplier_bindings {
+	struct device_node *(*parse_prop)(struct device_node *np,
+					  const char *prop_name, int index);
+};
+
+static const struct supplier_bindings bindings[] = {
+	{ .parse_prop = parse_clocks, },
+	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_regulators, },
+	{},
+};
+
+/**
+ * of_link_property - Create device links to suppliers listed in a property
+ * @dev: Consumer device
+ * @con_np: The consumer device tree node which contains the property
+ * @prop_name: Name of property to be parsed
+ *
+ * This function checks if the property @prop_name that is present in the
+ * @con_np device tree node is one of the known common device tree bindings
+ * that list phandles to suppliers. If @prop_name isn't one, this function
+ * doesn't do anything.
+ *
+ * If @prop_name is one, this function attempts to create device links from the
+ * consumer device @dev to all the devices of the suppliers listed in
+ * @prop_name.
+ *
+ * Any failed attempt to create a device link will NOT result in an immediate
+ * return.  of_link_property() must create links to all the available supplier
+ * devices even when attempts to create a link to one or more suppliers fail.
+ */
+static int of_link_property(struct device *dev, struct device_node *con_np,
+			     const char *prop_name)
+{
+	struct device_node *phandle;
+	const struct supplier_bindings *s = bindings;
+	unsigned int i = 0;
+	bool matched = false;
+	int ret = 0;
+
+	/* Do not stop at first failed link, link all available suppliers. */
+	while (!matched && s->parse_prop) {
+		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
+			matched = true;
+			i++;
+			if (of_link_to_phandle(dev, phandle) == -EAGAIN)
+				ret = -EAGAIN;
+			of_node_put(phandle);
+		}
+		s++;
+	}
+	return ret;
+}
+
+static int __of_link_to_suppliers(struct device *dev,
+				  struct device_node *con_np)
+{
+	struct device_node *child;
+	struct property *p;
+	int ret = 0;
+
+	for_each_property_of_node(con_np, p)
+		if (of_link_property(dev, con_np, p->name))
+			ret = -EAGAIN;
+
+	return ret;
+}
+
+static bool of_devlink;
+core_param(of_devlink, of_devlink, bool, 0);
+
+static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
+			       struct device *dev)
+{
+	if (!of_devlink)
+		return 0;
+
+	if (unlikely(!is_of_node(fwnode)))
+		return 0;
+
+	return __of_link_to_suppliers(dev, to_of_node(fwnode));
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -1001,5 +1241,6 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
+	.add_links = of_fwnode_add_links,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
-- 
2.23.0.187.g17f5b7556c-goog

