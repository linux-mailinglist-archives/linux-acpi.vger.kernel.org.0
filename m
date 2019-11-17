Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8233FFFB32
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKQSAC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 13:00:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:26318 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQSAC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 13:00:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:01 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="258213501"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 10:00:01 -0800
Subject: [PATCH v2 13/18] libnvdimm: Export the target_node attribute for
 regions and namespaces
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:45:45 -0800
Message-ID: <157401274500.43284.2369509941678577768.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Aneesh points out that some platforms may have "local" attached
persistent memory and "remote" persistent memory that map to the same
"online" node, or persistent memory devices with different performance
properties. In this case 'numa_node' is identical for the two instances,
but 'target_node' is differentiated so platform firmware can communicate
distinct performance properties per range. Expose 'target_node' by
default to allow for disambiguation of devices that share the same
numa_map_to_online_node() result.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 1d330d46d036..f76d709426f7 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -685,17 +685,46 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static int nvdimm_dev_to_target_node(struct device *dev)
+{
+	struct device *parent = dev->parent;
+	struct nd_region *nd_region = NULL;
+
+	if (is_nd_region(dev))
+		nd_region = to_nd_region(dev);
+	else if (parent && is_nd_region(parent))
+		nd_region = to_nd_region(parent);
+
+	if (!nd_region)
+		return NUMA_NO_NODE;
+	return nd_region->target_node;
+}
+
+static ssize_t target_node_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", nvdimm_dev_to_target_node(dev));
+}
+static DEVICE_ATTR_RO(target_node);
+
 static struct attribute *nd_numa_attributes[] = {
 	&dev_attr_numa_node.attr,
+	&dev_attr_target_node.attr,
 	NULL,
 };
 
 static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+
 	if (!IS_ENABLED(CONFIG_NUMA))
 		return 0;
 
+	if (a == &dev_attr_target_node.attr &&
+			nvdimm_dev_to_target_node(dev) == NUMA_NO_NODE)
+		return 0;
+
 	return a->mode;
 }
 

