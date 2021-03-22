Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69243452CF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCVXKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 19:10:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:20267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhCVXJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 19:09:39 -0400
IronPort-SDR: Lrcq6HrKQ6cxD3r7YbBgPenXoIXi5uTxpYsjZTWmt80Nu69Nh13TC7xYbeLxE8Y0RBjPkhLb50
 NEX7YtRBIJYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251718884"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251718884"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:09:38 -0700
IronPort-SDR: V6pwEcKSYLEIhp8Y9+mh+J2KruorKa8Z0zRe4mR/XRAUE8GuCyamJFV7HMLHfxaln1x6obA4Nt
 /z2p/F2j8Zag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607510505"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2021 16:09:37 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 3/4] PRM: implement OperationRegion handler for the PlatformRtMechanism subtype
Date:   Mon, 22 Mar 2021 15:37:06 -0700
Message-Id: <20210322223707.1838823-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322223707.1838823-1-erik.kaneda@intel.com>
References: <20210322223707.1838823-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform Runtime Mechanism (PRM) is a firmware interface that exposes
a set of binary executables that can either be called from the AML
interpreter or device drivers by bypassing the AML interpreter.
This change implements the AML interpreter path.

According to the specification [1], PRM services are listed in an
ACPI table called the PRMT. This patch parses module and handler
information listed in the PRMT and registers the PlatformRtMechanism
OpRegion handler before ACPI tables are loaded.

Each service is defined by a 16-byte GUID and called from writing a
26-byte ASL buffer containing the identifier to a FieldUnit object
defined inside a PlatformRtMechanism OperationRegion.

    OperationRegion (PRMR, PlatformRtMechanism, 0, 26)
    Field (PRMR, BufferAcc, NoLock, Preserve)
    {
        PRMF, 208 // Write to this field to invoke the OperationRegion Handler
    }

The 26-byte ASL buffer is defined as the following:

Byte Offset   Byte Length    Description
=============================================================
     0             1         PRM OperationRegion handler status
     1             8         PRM service status
     9             1         PRM command
    10            16         PRM handler GUID

The ASL caller fills out a 26-byte buffer containing the PRM command
and the PRM handler GUID like so:

    /* Local0 is the PRM data buffer */
    Local0 = buffer (26){}

    /* Create byte fields over the buffer */
    CreateByteField (Local0, 0x9, CMD)
    CreateField (Local0, 0x50, 0x80, GUID)

    /* Fill in the command and data fields of the data buffer */
    CMD = 0 // run command
    GUID = ToUUID("xxxx-xx-xxx-xxxx")

    /*
     * Invoke PRM service with an ID that matches GUID and save the
     * result.
     */
    Local0 = (\_SB.PRMT.PRMF = Local0)

Byte offset 0 - 8 are written by the handler as a status passed back to AML
and used by ASL like so:

    /* Create byte fields over the buffer */
    CreateByteField (Local0, 0x0, PSTA)
    CreateQWordField (Local0, 0x1, USTA)

In this ASL code, PSTA contains a status from the OperationRegion and
USTA contains a status from the PRM service.

The 26-byte buffer is recieved by acpi_platformrt_space_handler. This
handler will look at the command value and the handler guid and take
the approperiate actions.

Command value    Action
=====================================================================
    0            Run the PRM service indicated by the PRM handler
                 GUID (bytes 10-26)

    1            Prevent PRM runtime updates from happening to the
                 service's parent module

    2            Allow PRM updates from happening to the service's parent module

Note: PRM service updates will be implemented in future patches. This
patch enables command value 0.

[1] https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/Kconfig  |   5 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/bus.c    |   2 +
 drivers/acpi/prmt.c   | 302 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c |   9 ++
 include/linux/acpi.h  |   1 +
 include/linux/prmt.h  |   7 +
 7 files changed, 327 insertions(+)
 create mode 100644 drivers/acpi/prmt.c
 create mode 100644 include/linux/prmt.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index eedec61e3476..3972de7b7565 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -543,3 +543,8 @@ config X86_PM_TIMER
 
 	  You should nearly always say Y here because many modern
 	  systems require this timer.
+
+config ACPI_PRMT
+	bool "Platform Runtime Mechanism Support"
+	depends on EFI && X86_64
+	default y
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 700b41adf2db..efb0d1f64019 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -61,6 +61,7 @@ acpi-$(CONFIG_ACPI_FPDT)	+= acpi_fpdt.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
+acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
 
 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..3484497923d5 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include <acpi/apei.h>
 #include <linux/suspend.h>
+#include <linux/prmt.h>
 
 #include "internal.h"
 
@@ -1330,6 +1331,7 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
+	init_prmt();
 	result = acpi_bus_init();
 	if (result) {
 		disable_acpi();
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
new file mode 100644
index 000000000000..2bc28bdf0998
--- /dev/null
+++ b/drivers/acpi/prmt.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Erik Kaneda <erik.kaneda@intel.com>
+ * Copyright 2020 Intel Corporation
+ *
+ * prmt.c
+ *
+ * Each PRM service is an executable that is run in a restricted environment
+ * that is invoked by writing to the PlatformRtMechanism OperationRegion from
+ * AML bytecode.
+ *
+ * init_prmt initializes the Platform Runtime Mechanism (PRM) services by
+ * processing data in the PRMT as well as registering an ACPI OperationRegion
+ * handler for the PlatformRtMechanism subtype.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
+#include <linux/prmt.h>
+#include <asm/efi.h>
+
+#pragma pack(1)
+struct prm_mmio_addr_range {
+	u64 phys_addr;
+	u64 virt_addr;
+	u32 length;
+};
+
+struct prm_mmio_info {
+	u64 mmio_count;
+	struct prm_mmio_addr_range addr_ranges[];
+};
+
+struct prm_buffer {
+	u8 prm_status;
+	u64 efi_status;
+	u8 prm_cmd;
+	guid_t handler_guid;
+};
+
+struct prm_context_buffer {
+	char signature[ACPI_NAMESEG_SIZE];
+	u16 revision;
+	u16 reserved;
+	guid_t identifier;
+	u64 static_data_buffer;
+	struct prm_mmio_info *mmio_ranges;
+};
+#pragma pack()
+
+
+LIST_HEAD(prm_module_list);
+
+struct prm_handler_info {
+	guid_t guid;
+	u64 handler_addr;
+	u64 static_data_buffer_addr;
+	u64 acpi_param_buffer_addr;
+
+	struct list_head handler_list;
+};
+
+struct prm_module_info {
+	guid_t guid;
+	u16 major_rev;
+	u16 minor_rev;
+	u16 handler_count;
+	struct prm_mmio_info *mmio_info;
+	bool updatable;
+
+	struct list_head module_list;
+	struct prm_handler_info handlers[];
+};
+
+
+static u64 efi_pa_va_lookup(u64 pa)
+{
+	efi_memory_desc_t *md;
+	u64 pa_offset = pa & ~PAGE_MASK;
+	u64 page = pa & PAGE_MASK;
+
+	for_each_efi_memory_desc(md) {
+		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+			return pa_offset + md->virt_addr + page - md->phys_addr;
+	}
+
+	return 0;
+}
+
+
+#define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_offset))
+#define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
+
+static int __init
+acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_prmt_module_info *module_info;
+	struct acpi_prmt_handler_info *handler_info;
+	struct prm_handler_info *th;
+	struct prm_module_info *tm;
+	u64 mmio_count = 0;
+	u64 cur_handler = 0;
+	u32 module_info_size = 0;
+	u64 mmio_range_size = 0;
+	void *temp_mmio;
+
+	module_info = (struct acpi_prmt_module_info *) header;
+	module_info_size = struct_size(tm, handlers, module_info->handler_count);
+	tm = kmalloc(module_info_size, GFP_KERNEL);
+
+	guid_copy(&tm->guid, (guid_t *) module_info->guid);
+	tm->major_rev = module_info->major_rev;
+	tm->minor_rev = module_info->minor_rev;
+	tm->handler_count = module_info->handler_count;
+	tm->updatable = true;
+
+	if (module_info->mmio_list_pointer) {
+		/*
+		 * Each module is associated with a list of addr
+		 * ranges that it can use during the service
+		 */
+		mmio_count = *(u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
+		mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
+		tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
+		temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
+		memmove(tm->mmio_info, temp_mmio, mmio_range_size);
+	} else {
+		mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
+		tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
+		tm->mmio_info->mmio_count = 0;
+	}
+
+	INIT_LIST_HEAD(&tm->module_list);
+	list_add(&tm->module_list, &prm_module_list);
+
+	handler_info = get_first_handler(module_info);
+	do {
+		th = &tm->handlers[cur_handler];
+
+		guid_copy(&th->guid, (guid_t *)handler_info->guid);
+		th->handler_addr = efi_pa_va_lookup(handler_info->address);
+		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
+		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
+
+	return 0;
+}
+
+#define GET_MODULE	0
+#define GET_HANDLER	1
+
+static void *find_guid_info(const guid_t *guid, u8 mode)
+{
+	struct prm_handler_info *cur_handler;
+	struct prm_module_info *cur_module;
+	int i = 0;
+
+	list_for_each_entry(cur_module, &prm_module_list, module_list) {
+		for (i = 0; i < cur_module->handler_count; ++i) {
+			cur_handler = &cur_module->handlers[i];
+			if (guid_equal(guid, &cur_handler->guid)) {
+				if (mode == GET_MODULE)
+					return (void *)cur_module;
+				else
+					return (void *)cur_handler;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+
+static struct prm_module_info *find_prm_module(const guid_t *guid)
+{
+	return (struct prm_module_info *)find_guid_info(guid, GET_MODULE);
+}
+
+static struct prm_handler_info *find_prm_handler(const guid_t *guid)
+{
+	return (struct prm_handler_info *) find_guid_info(guid, GET_HANDLER);
+}
+
+/* In-coming PRM commands */
+
+#define PRM_CMD_RUN_SERVICE		0
+#define PRM_CMD_START_TRANSACTION	1
+#define PRM_CMD_END_TRANSACTION		2
+
+/* statuses that can be passed back to ASL */
+
+#define PRM_HANDLER_SUCCESS 		0
+#define PRM_HANDLER_ERROR 		1
+#define INVALID_PRM_COMMAND 		2
+#define PRM_HANDLER_GUID_NOT_FOUND 	3
+#define UPDATE_LOCK_ALREADY_HELD 	4
+#define UPDATE_UNLOCK_WITHOUT_LOCK 	5
+
+/*
+ * This is the PlatformRtMechanism opregion space handler.
+ * @function: indicates the read/write. In fact as the PlatformRtMechanism
+ * message is driven by command, only write is meaningful.
+ *
+ * @addr   : not used
+ * @bits   : not used.
+ * @value  : it is an in/out parameter. It points to the PRM message buffer.
+ * @handler_context: not used
+ */
+static acpi_status acpi_platformrt_space_handler(u32 function,
+						 acpi_physical_address addr,
+						 u32 bits, acpi_integer *value,
+						 void *handler_context,
+						 void *region_context)
+{
+	struct prm_buffer *buffer = ACPI_CAST_PTR(struct prm_buffer, value);
+	struct prm_handler_info *handler;
+	struct prm_module_info *module;
+	efi_status_t status;
+	struct prm_context_buffer context;
+
+	/*
+	 * The returned acpi_status will always be AE_OK. Error values will be
+	 * saved in the first byte of the PRM message buffer to be used by ASL.
+	 */
+	switch (buffer->prm_cmd) {
+	case PRM_CMD_RUN_SERVICE:
+
+		handler = find_prm_handler(&buffer->handler_guid);
+		module = find_prm_module(&buffer->handler_guid);
+		if (!handler || !module)
+			goto invalid_guid;
+
+		ACPI_COPY_NAMESEG(context.signature, "PRMC");
+		context.revision = 0x0;
+		context.reserved = 0x0;
+		context.identifier = handler->guid;
+		context.static_data_buffer = handler->static_data_buffer_addr;
+		context.mmio_ranges = module->mmio_info;
+
+		status = efi_call_virt_pointer(handler, handler_addr,
+					       handler->acpi_param_buffer_addr,
+					       &context);
+		if (status == EFI_SUCCESS) {
+			buffer->prm_status = PRM_HANDLER_SUCCESS;
+		} else {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			buffer->efi_status = status;
+		}
+		break;
+
+	case PRM_CMD_START_TRANSACTION:
+
+		module = find_prm_module(&buffer->handler_guid);
+		if (!module)
+			goto invalid_guid;
+
+		if (module->updatable)
+			module->updatable = false;
+		else
+			buffer->prm_status = UPDATE_LOCK_ALREADY_HELD;
+		break;
+
+	case PRM_CMD_END_TRANSACTION:
+
+		module = find_prm_module(&buffer->handler_guid);
+		if (!module)
+			goto invalid_guid;
+
+		if (module->updatable)
+			buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
+		else
+			module->updatable = true;
+		break;
+
+	default:
+
+		buffer->prm_status = INVALID_PRM_COMMAND;
+		break;
+	}
+
+	return AE_OK;
+
+invalid_guid:
+	buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+	return AE_OK;
+}
+
+void __init init_prmt(void)
+{
+	acpi_status status;
+	int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt),
+					  0, acpi_parse_prmt, 0);
+	pr_info("PRM: found %u modules\n", mc);
+
+	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
+						    ACPI_ADR_SPACE_PLATFORM_RT,
+						    &acpi_platformrt_space_handler,
+						    NULL, NULL);
+	if (ACPI_FAILURE(status))
+		pr_alert("PRM: OperationRegion handler could not be installed\n");
+}
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index e48690a006a4..69a03d70740c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -39,6 +39,7 @@ static int acpi_apic_instance __initdata;
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
 	ACPI_SUBTABLE_HMAT,
+	ACPI_SUBTABLE_PRMT,
 };
 
 struct acpi_subtable_entry {
@@ -222,6 +223,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return entry->hdr->common.type;
 	case ACPI_SUBTABLE_HMAT:
 		return entry->hdr->hmat.type;
+	case ACPI_SUBTABLE_PRMT:
+		return 0;
 	}
 	return 0;
 }
@@ -234,6 +237,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->common.length;
 	case ACPI_SUBTABLE_HMAT:
 		return entry->hdr->hmat.length;
+	case ACPI_SUBTABLE_PRMT:
+		return entry->hdr->prmt.length;
 	}
 	return 0;
 }
@@ -246,6 +251,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->common);
 	case ACPI_SUBTABLE_HMAT:
 		return sizeof(entry->hdr->hmat);
+	case ACPI_SUBTABLE_PRMT:
+		return sizeof(entry->hdr->prmt);
 	}
 	return 0;
 }
@@ -255,6 +262,8 @@ acpi_get_subtable_type(char *id)
 {
 	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
 		return ACPI_SUBTABLE_HMAT;
+	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
+		return ACPI_SUBTABLE_PRMT;
 	return ACPI_SUBTABLE_COMMON;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9f432411e988..6868b342cdc3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -132,6 +132,7 @@ enum acpi_address_range_id {
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
+	struct acpi_prmt_module_header prmt;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
diff --git a/include/linux/prmt.h b/include/linux/prmt.h
new file mode 100644
index 000000000000..24da8364b919
--- /dev/null
+++ b/include/linux/prmt.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifdef CONFIG_ACPI_PRMT
+void init_prmt(void);
+#else
+static inline void init_prmt(void) { }
+#endif
-- 
2.29.2

