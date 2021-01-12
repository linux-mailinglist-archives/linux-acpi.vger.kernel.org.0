Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13612F23D7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 01:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391797AbhALA0C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 19:26:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:57931 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390921AbhAKXDJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:03:09 -0500
IronPort-SDR: HJzS7ERHAenvRHW4qhxraHOyb/imLmsxpiwadlNHT5qPwN8NPXjsmMa3vGTEycqKUPZ9knFo4r
 4JHsxF4RzH4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196564972"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="196564972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:30 -0800
IronPort-SDR: lXcIYZVY4PcjbiE++8OUyum1OGEdsq9JASc8OB05Bv1UuHnOb0qEW4iBcULX6If6mIsIHt7sBj
 ZVuxeyUiEQwg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381181321"
Received: from yyang31-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.142.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Mailbox Transport; Mon, 11 Jan 2021 14:51:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 14:51:43 -0800
Received: from fmsmga008.fm.intel.com (10.253.24.58) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 14:51:43 -0800
IronPort-SDR: VJOTcjm/dpby0S70mG4OmSZIUeCRFhAMGMF18ZGz7HHVUBRiBvVhxbqNaKGjQatvF/YNEP9HAp
 Ap62qn3RKaSg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778046"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:42 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: [RFC PATCH v3 13/16] cxl/mem: Create concept of enabled commands
Date:   Mon, 11 Jan 2021 14:51:18 -0800
Message-ID: <20210111225121.820014-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Exchange-Organization-Network-Message-Id: 3d3d0b7c-b869-43b6-0e89-08d8b6837764
Content-Type:   text/plain; charset=US-ASCII
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-Organization-AuthSource: fmsmsx609.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.8120281
X-MS-Exchange-Processed-By-BccFoldering: 15.01.1713.001
MIME-Version: 1.0
X-TUID: +HndTNvdUblX
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CXL devices must implement the Device Command Interface (described in
8.2.9 of the CXL 2.0 spec). While the driver already maintains a list of
commands it supports, there is still a need to be able to distinguish
between commands that the driver knows about from commands that may not
be supported by the hardware. No such commands currently are defined in
the driver.

The implementation leaves the statically defined table of commands and
supplements it with a bitmap to determine commands that are enabled.

---

There are multiple approaches that can be taken, but this is nice for a
few reasons.

Here are some of the other solutions:

Create a per instance table with only the supported commands.
1. Having a fixed command id -> command mapping is much easier to manage
   for development and debugging.
2. Dealing with dynamic memory allocation for the table adds unnecessary
   complexity.
3. Most tables for device types are likely to be quite similar.
4. Makes it difficult to implement helper macros like cxl_for_each_cmd()

If the per instance table did preserve ids, #1 above can be addressed.
However, as "enable" is currently the only mutable state for the
commands, it would yield a lot of overhead for not much gain.
Additionally, the other issues remain.

If "enable" remains the only mutable state, I believe this to be the
best solution. Once the number of mutable elements in a command grows,
it probably makes sense to move to per device instance state with a
fixed command ID mapping.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  4 ++++
 drivers/cxl/mem.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 537ac4d8e6bd..963ba30cb200 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -17,6 +17,9 @@
 
 #define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
 
+/* XXX: Arbitrary max */
+#define CXL_MAX_COMMANDS 32
+
 /* Device  (CXL 2.0 - 8.2.8.3) */
 #define CXLDEV_CAP_ARRAY_REG 0x0
 #define CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -88,6 +91,7 @@ struct cxl_mem {
 	} ram;
 
 	char firmware_version[0x10];
+	DECLARE_BITMAP(enabled_cmds, CXL_MAX_COMMANDS);
 
 	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
 	struct {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a824cfd4342a..20b26fa2c466 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -114,6 +114,8 @@ static struct {
  *    would typically be used for deprecated commands.
  *  * %CXL_CMD_FLAG_MANDATORY: Hardware must support this command. This flag is
  *    only used internally by the driver for sanity checking.
+ *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
+ *    a direct mapping to hardware. They are implicitly always enabled.
  *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
@@ -129,6 +131,7 @@ struct cxl_mem_command {
 #define CXL_CMD_INTERNAL_FLAG_NONE 0
 #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
 #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
+#define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
 };
 
 /*
@@ -140,7 +143,7 @@ struct cxl_mem_command {
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
-	CXL_CMD(RAW, NONE, ~0, ~0, MANDATORY),
+	CXL_CMD(RAW, NONE, ~0, ~0, PSEUDO),
 };
 
 #define cxl_for_each_cmd(cmd)                                                  \
@@ -618,6 +621,10 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	c = &mem_commands[send_cmd->id];
 	info = &c->info;
 
+	/* Check that the command is enabled for hardware */
+	if (!test_bit(cxl_cmd_index(c), cxlm->enabled_cmds))
+		return -ENOTTY;
+
 	if (info->flags & CXL_MEM_COMMAND_FLAG_KERNEL)
 		return -EPERM;
 
@@ -1029,6 +1036,31 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return rc;
 }
 
+/**
+ * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
+ * @cxlm: The device.
+ *
+ * Returns 0 if enumerate completed successfully.
+ *
+ * CXL devices have optional support for certain commands. This function will
+ * determine the set of supported commands for the hardware and update the
+ * enabled_cmds bitmap in the @cxlm.
+ */
+static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
+{
+	struct cxl_mem_command *c;
+
+	/* All commands are considered enabled for now (except INVALID). */
+	cxl_for_each_cmd(c) {
+		if (c->flags & CXL_CMD_INTERNAL_FLAG_HIDDEN)
+			continue;
+
+		set_bit(cxl_cmd_index(c), cxlm->enabled_cmds);
+	}
+
+	return 0;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -1147,6 +1179,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		goto err;
 
+	rc = cxl_mem_enumerate_cmds(cxlm);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_identify(cxlm);
 	if (rc)
 		goto err;
-- 
2.30.0

