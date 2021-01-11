Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616702F23CF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 01:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391795AbhALA0B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 19:26:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:57916 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390917AbhAKXDA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:03:00 -0500
IronPort-SDR: QQ16fD1ZRjmFXD+OHrIJbhZrjTGMkYaJcB2Y6NBGxEm8jYTsAlSIDJ/25qGp2lkAa7TEos1S/e
 g3CxtjlTB4BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196564965"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="196564965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:28 -0800
IronPort-SDR: nlLORnwx/X3kBWRgCSb+CT0y12Zc3diLfkHPxhaYWWHofD50Tqyb/ttkwOnBakgvJrIURwOdrR
 aHtq9Lvu7aFw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381181306"
Received: from yyang31-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.142.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Mailbox Transport; Mon, 11 Jan 2021 14:51:43 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 14:51:42 -0800
Received: from fmsmga008.fm.intel.com (10.253.24.58) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 14:51:42 -0800
IronPort-SDR: 9vT7xNVlp66s3vmTTHdPG0OuUd7Rp2ye6lDOGC1tN90knAjPBYCiE2JllOTYjWw9EddnHmgeKP
 +1IhX0SVjdNw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778042"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:41 -0800
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
Subject: [RFC PATCH v3 12/16] cxl/mem: Add a "RAW" send command
Date:   Mon, 11 Jan 2021 14:51:17 -0800
Message-ID: <20210111225121.820014-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Exchange-Organization-Network-Message-Id: 1a35c18e-97eb-486e-6f6a-08d8b6837718
Content-Type:   text/plain; charset=US-ASCII
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-Organization-AuthSource: fmsmsx606.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.6090961
X-MS-Exchange-Processed-By-BccFoldering: 15.01.1713.001
MIME-Version: 1.0
X-TUID: w0HWGe4fchEv
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CXL memory device send interface will have a number of supported
commands. The raw command is not such a command. Raw commands allow
userspace to send a specified opcode to the underlying hardware and
bypass all driver checks on the command. This is useful for a couple of
usecases, mainly:
1. Undocumented vendor specific hardware commands
2. Prototyping new hardware commands not yet supported by the driver

While this all sounds very powerful it comes with a couple of caveats:
1. Bug reports using raw commands will not get the same level of
   attention as bug reports using supported commands (via taint).
2. Supported commands will be rejected by the RAW command.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 27 +++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h | 12 +++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index f979788b4d9f..a824cfd4342a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -43,6 +43,7 @@
 
 enum opcode {
 	CXL_MBOX_OP_INVALID	= 0x0000,
+#define CXL_MBOX_OP_RAW		CXL_MBOX_OP_INVALID
 	CXL_MBOX_OP_IDENTIFY    = 0x4000,
 	CXL_MBOX_OP_MAX         = 0x10000
 };
@@ -139,6 +140,7 @@ struct cxl_mem_command {
 static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(INVALID, KERNEL, 0, 0, HIDDEN),
 	CXL_CMD(IDENTIFY, NONE, 0, 0x43, MANDATORY),
+	CXL_CMD(RAW, NONE, ~0, ~0, MANDATORY),
 };
 
 #define cxl_for_each_cmd(cmd)                                                  \
@@ -520,6 +522,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
 		command_names[cmd->info.id].name, mbox_cmd.opcode,
 		cmd->info.size_in);
 
+	if (cmd->info.id == CXL_MEM_COMMAND_ID_RAW)
+		add_taint(TAINT_RAW_PASSTHROUGH, LOCKDEP_STILL_OK);
+
 	rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
 	cxl_mem_mbox_put(cxlmd->cxlm);
 	if (rc)
@@ -581,6 +586,28 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	if (send_cmd->size_in > cxlm->mbox.payload_size)
 		return -EINVAL;
 
+	/* Checks are bypassed for raw commands but along comes the taint! */
+	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
+		const struct cxl_mem_command temp = {
+			{
+				.id = CXL_MEM_COMMAND_ID_RAW,
+				.flags = CXL_MEM_COMMAND_FLAG_NONE,
+				.size_in = send_cmd->size_in,
+				.size_out = send_cmd->size_out,
+			},
+			.flags = 0,
+			.opcode = send_cmd->raw.opcode
+		};
+
+		if (send_cmd->raw.rsvd)
+			return -EINVAL;
+
+		if (cxl_mem_find_command(send_cmd->raw.opcode))
+			return -EPERM;
+
+		return PTR_ERR_OR_ZERO(memcpy(out_cmd, &temp, sizeof(temp)));
+	}
+
 	if (send_cmd->flags & CXL_MEM_COMMAND_FLAG_MASK)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index cb4e2bee5228..50acd6cc14d4 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -32,6 +32,7 @@ extern "C" {
 #define CMDS                                                                   \
 	C(INVALID,	"Invalid Command"),                                    \
 	C(IDENTIFY,	"Identify Command"),                                   \
+	C(RAW,		"Raw device command"),                                 \
 	C(MAX,		"Last command")
 #undef C
 #define C(a, b) CXL_MEM_COMMAND_ID_##a
@@ -117,6 +118,9 @@ struct cxl_mem_query_commands {
  * @id: The command to send to the memory device. This must be one of the
  *	commands returned by the query command.
  * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
  * @rsvd: Must be zero.
  * @retval: Return value from the memory device (output).
  * @size_in: Size of the payload to provide to the device (input).
@@ -135,7 +139,13 @@ struct cxl_mem_query_commands {
 struct cxl_send_command {
 	__u32 id;
 	__u32 flags;
-	__u32 rsvd;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
 	__u32 retval;
 
 	struct {
-- 
2.30.0

