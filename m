Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C890031A7A3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 23:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBLWaK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 17:30:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:60498 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhBLW3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 17:29:52 -0500
IronPort-SDR: WEGCo0LXJMNHXAQMdFZ9Z972GTKqXgq1833b9JUrxOAZHmSxsHKBQa2UYEHFGo5ZsYRCJXCJJw
 XPA5VV6P0+Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="182555587"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="182555587"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:52 -0800
IronPort-SDR: KD2kkY7bMh3yuejKI5EO+RBvGPg7QpiSxSpT0xPprR61xCSDZOOrbqXxuA6StGmrPILtPWsg79
 lAELZax5Vm/g==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="587605369"
Received: from smandal1-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:51 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 4/9] cxl/mem: Add basic IOCTL interface
Date:   Fri, 12 Feb 2021 14:25:36 -0800
Message-Id: <20210212222541.2123505-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212222541.2123505-1-ben.widawsky@intel.com>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a straightforward IOCTL that provides a mechanism for userspace to
query the supported memory device commands. CXL commands as they appear
to userspace are described as part of the UAPI kerneldoc. The command
list returned via this IOCTL will contain the full set of commands that
the driver supports, however, some of those commands may not be
available for use by userspace.

Memory device commands first appear in the CXL 2.0 specification. They
are submitted through a mailbox mechanism specified in the CXL 2.0
specification.

The send command allows userspace to issue mailbox commands directly to
the hardware. The list of available commands to send are the output of
the query command. The driver verifies basic properties of the command
and possibly inspect the input (or output) payload to determine whether
or not the command is allowed (or might taint the kernel).

Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
---
 .clang-format                                 |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/cxl/mem.c                             | 280 +++++++++++++++++-
 include/uapi/linux/cxl_mem.h                  | 154 ++++++++++
 4 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/cxl_mem.h

diff --git a/.clang-format b/.clang-format
index 10dc5a9a61b3..3f11c8901b43 100644
--- a/.clang-format
+++ b/.clang-format
@@ -109,6 +109,7 @@ ForEachMacros:
   - 'css_for_each_child'
   - 'css_for_each_descendant_post'
   - 'css_for_each_descendant_pre'
+  - 'cxl_for_each_cmd'
   - 'device_for_each_child_node'
   - 'dma_fence_chain_for_each'
   - 'do_for_each_ftrace_op'
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..6eb8e634664d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -352,6 +352,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:michael.klein@puffin.lb.shuttle.de>
 0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h
+0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
 0xCF  02     fs/cifs/ioctl.c
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index f03482aa155d..d764a35afea9 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <uapi/linux/cxl_mem.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
@@ -39,6 +40,7 @@
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
 enum opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
@@ -90,6 +92,49 @@ struct cxl_memdev {
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	struct cxl_command_info info;
+	enum opcode opcode;
+};
+
+#define CXL_CMD(_id, sin, sout)                                                \
+	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
+	.info =	{                                                              \
+			.id = CXL_MEM_COMMAND_ID_##_id,                        \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+	.opcode = CXL_MBOX_OP_##_id,                                           \
+	}
+
+/*
+ * This table defines the supported mailbox commands for the driver. This table
+ * is made up of a UAPI structure. Non-negative values as parameters in the
+ * table will be validated against the user's input. For example, if size_in is
+ * 0, and the user passed in 1, it is an error.
+ */
+static struct cxl_mem_command mem_commands[] = {
+	CXL_CMD(IDENTIFY, 0, 0x43),
+};
+
+#define cxl_for_each_cmd(cmd)                                                  \
+	for ((cmd) = &mem_commands[0];                                         \
+	     ((cmd) - mem_commands) < ARRAY_SIZE(mem_commands); (cmd)++)
+
+#define cxl_cmd_count ARRAY_SIZE(mem_commands)
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const unsigned long start = jiffies;
@@ -311,6 +356,239 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox_mutex);
 }
 
+/**
+ * handle_mailbox_cmd_from_user() - Dispatch a mailbox command.
+ * @cxlmd: The CXL memory device to communicate with.
+ * @cmd: The validated command.
+ * @in_payload: Pointer to userspace's input payload.
+ * @out_payload: Pointer to userspace's output payload.
+ * @s: The command submitted by userspace. Has output fields.
+ *
+ * Return:
+ *  * %0	- Mailbox transaction succeeded.
+ *  * %-EFAULT	- Something happened with copy_to/from_user.
+ *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
+ *  * %-EINTR	- Mailbox acquisition interrupted.
+ *  * %-E2BIG   - Output payload would overrun user's buffer.
+ *
+ * Creates the appropriate mailbox command on behalf of a userspace request.
+ * Return value, size, and output payload are all copied out to @u. The
+ * parameters for the command must be validated before calling this function.
+ *
+ * A 0 return code indicates the command executed successfully, not that it was
+ * itself successful. IOW, the cmd->retval should always be checked if wanting
+ * to determine the actual result.
+ */
+static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
+					const struct cxl_mem_command *cmd,
+					u64 in_payload, u64 out_payload,
+					struct cxl_send_command __user *s)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	struct mbox_cmd mbox_cmd = {
+		.opcode = cmd->opcode,
+		.size_in = cmd->info.size_in,
+	};
+	s32 user_size_out;
+	int rc;
+
+	if (get_user(user_size_out, &s->out.size))
+		return -EFAULT;
+
+	if (cmd->info.size_out > 0) /* fixed size command */
+		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
+	else if (cmd->info.size_out < 0) /* variable */
+		mbox_cmd.payload_out = kvzalloc(cxlm->payload_size, GFP_KERNEL);
+
+	if (cmd->info.size_in) {
+		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
+		if (!mbox_cmd.payload_in) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (copy_from_user(mbox_cmd.payload_in,
+				   u64_to_user_ptr(in_payload),
+				   cmd->info.size_in)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		goto out;
+
+	dev_dbg(dev,
+		"Submitting %s command for user\n"
+		"\topcode: %x\n"
+		"\tsize: %ub\n",
+		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
+		cmd->info.size_in);
+
+	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
+	cxl_mem_mbox_put(cxlm);
+	if (rc)
+		goto out;
+
+	rc = put_user(mbox_cmd.return_code, &s->retval);
+	if (rc)
+		goto out;
+
+	if (user_size_out < mbox_cmd.size_out) {
+		rc = -E2BIG;
+		goto out;
+	}
+
+	if (mbox_cmd.size_out) {
+		if (copy_to_user(u64_to_user_ptr(out_payload),
+				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	rc = put_user(mbox_cmd.size_out, &s->out.size);
+
+out:
+	kvfree(mbox_cmd.payload_in);
+	kvfree(mbox_cmd.payload_out);
+	return rc;
+}
+
+/**
+ * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * @cxlm: &struct cxl_mem device whose mailbox will be used.
+ * @send_cmd: &struct cxl_send_command copied in from userspace.
+ * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ *
+ * Return:
+ *  * %0	- @out_cmd is ready to send.
+ *  * %-ENOTTY	- Invalid command specified.
+ *  * %-EINVAL	- Reserved fields or invalid values were used.
+ *  * %-ENOMEM	- Input or output buffer wasn't sized properly.
+ *
+ * The result of this command is a fully validated command in @out_cmd that is
+ * safe to send to the hardware.
+ *
+ * See handle_mailbox_cmd_from_user()
+ */
+static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
+				      const struct cxl_send_command *send_cmd,
+				      struct cxl_mem_command *out_cmd)
+{
+	const struct cxl_command_info *info;
+	struct cxl_mem_command *c;
+
+	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
+		return -ENOTTY;
+
+	/*
+	 * The user can never specify an input payload larger than
+	 * hardware supports, but output can be arbitrarily large,
+	 * simply write out as much data as the hardware provides.
+	 */
+	if (send_cmd->in.size > cxlm->payload_size)
+		return -EINVAL;
+
+	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
+		return -EINVAL;
+
+	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
+		return -EINVAL;
+
+	/* Convert user's command into the internal representation */
+	c = &mem_commands[send_cmd->id];
+	info = &c->info;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
+		return -ENOMEM;
+
+	/* Setting a few const fields here... */
+	memcpy(out_cmd, c, sizeof(*c));
+	out_cmd->info.size_in = send_cmd->in.size;
+	out_cmd->info.size_out = send_cmd->out.size;
+
+	return 0;
+}
+
+static int cxl_query_cmd(struct cxl_memdev *cxlmd,
+			 struct cxl_mem_query_commands __user *q)
+{
+	struct device *dev = &cxlmd->dev;
+	struct cxl_mem_command *cmd;
+	u32 n_commands;
+	int j = 0;
+
+	dev_dbg(dev, "Query IOCTL\n");
+
+	if (get_user(n_commands, &q->n_commands))
+		return -EFAULT;
+
+	/* returns the total number if 0 elements are requested. */
+	if (n_commands == 0)
+		return put_user(cxl_cmd_count, &q->n_commands);
+
+	/*
+	 * otherwise, return max(n_commands, total commands) cxl_command_info
+	 * structures.
+	 */
+	cxl_for_each_cmd(cmd) {
+		const struct cxl_command_info *info = &cmd->info;
+
+		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+			return -EFAULT;
+
+		if (j == n_commands)
+			break;
+	}
+
+	return 0;
+}
+
+static int cxl_send_cmd(struct cxl_memdev *cxlmd,
+			struct cxl_send_command __user *s)
+{
+	struct device *dev = &cxlmd->dev;
+	struct cxl_send_command send;
+	struct cxl_mem_command c;
+	int rc;
+
+	dev_dbg(dev, "Send IOCTL\n");
+
+	if (copy_from_user(&send, s, sizeof(send)))
+		return -EFAULT;
+
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlm, &send, &c);
+	if (rc)
+		return rc;
+
+	return handle_mailbox_cmd_from_user(cxlmd, &c, send.in.payload,
+					    send.out.payload, s);
+}
+
+static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
+			       unsigned long arg)
+{
+	switch (cmd) {
+	case CXL_MEM_QUERY_COMMANDS:
+		return cxl_query_cmd(cxlmd, (void __user *)arg);
+	case CXL_MEM_SEND_COMMAND:
+		return cxl_send_cmd(cxlmd, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -324,7 +602,7 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
 		return -ENXIO;
 
-	/* TODO: ioctl body */
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
 
 	percpu_ref_put(&cxlmd->ops_active);
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
new file mode 100644
index 000000000000..18cea908ad0b
--- /dev/null
+++ b/include/uapi/linux/cxl_mem.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#include <linux/types.h>
+
+/**
+ * DOC: UAPI
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
+
+#define CXL_CMDS                                                          \
+	___C(INVALID, "Invalid Command"),                                 \
+	___C(IDENTIFY, "Identify Command"),                               \
+	___C(MAX, "invalid / last command")
+
+#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+enum { CXL_CMDS };
+
+#undef ___C
+#define ___C(a, b) { b }
+static const struct {
+	const char *name;
+} cxl_command_names[] = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_command_names[] = {
+ *	[CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
+ *	[CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Command" },
+ *	...
+ *	[CXL_MEM_COMMAND_ID_MAX] = { "invalid / last command" },
+ * };
+ */
+
+#undef ___C
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. This is returned as part of an array from the query ioctl. The
+ * following would be a command that takes a variable length input and returns 0
+ * bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = 0
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
+
+	__s32 size_in;
+	__s32 size_out;
+};
+
+/**
+ * struct cxl_mem_query_commands - Query supported commands.
+ * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
+ *		return min(num_support_commands, n_commands). When @n_commands
+ *		is 0, driver will return the number of total supported commands.
+ * @rsvd: Reserved for future use.
+ * @commands: Output array of supported commands. This array must be allocated
+ *            by userspace to be at least min(num_support_commands, @n_commands)
+ *
+ * Allow userspace to query the available commands supported by both the driver,
+ * and the hardware. Commands that aren't supported by either the driver, or the
+ * hardware are not returned in the query.
+ *
+ * Examples:
+ *
+ *  - { .n_commands = 0 } // Get number of supported commands
+ *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
+ *    supported commands
+ *
+ *  See struct cxl_command_info.
+ */
+struct cxl_mem_query_commands {
+	/*
+	 * Input: Number of commands to return (space allocated by user)
+	 * Output: Number of commands supported by the driver/hardware
+	 *
+	 * If n_commands is 0, kernel will only return number of commands and
+	 * not try to populate commands[], thus allowing userspace to know how
+	 * much space to allocate
+	 */
+	__u32 n_commands;
+	__u32 rsvd;
+
+	struct cxl_command_info __user commands[]; /* out: supported commands */
+};
+
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @in.size: Size of the payload to provide to the device (input).
+ * @in.rsvd: Must be zero.
+ * @in.payload: Pointer to memory for payload input, payload is little endian.
+ * @out.size: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @out.rsvd: Must be zero.
+ * @out.payload: Pointer to memory for payload output, payload is little endian.
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes. In some cases even the
+ * payload may be introspected. Userspace is required to allocate large enough
+ * buffers for size_out which can be variable length in certain situations.
+ */
+struct cxl_send_command {
+	__u32 id;
+	__u32 flags;
+	__u32 rsvd;
+	__u32 retval;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} out;
+};
+
+#endif
-- 
2.30.0

