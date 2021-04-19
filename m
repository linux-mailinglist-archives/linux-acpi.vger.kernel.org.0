Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6036489E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Apr 2021 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhDSQ5b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 12:57:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2884 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSQ5b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 12:57:31 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FPCWq1k9lz6yh5q;
        Tue, 20 Apr 2021 00:51:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 18:56:59 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 17:56:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v3 3/4] cxl/mem: Add CDAT table reading from DOE
Date:   Tue, 20 Apr 2021 00:54:50 +0800
Message-ID: <20210419165451.2176200-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch provides a sysfs binary attribute to
allow dumping of the whole table.

Binary dumping is modeled on /sys/firmware/ACPI/tables/

The ability to dump this table will be very useful for emulation of
real devices once they become available as QEMU CXL type 3 device
emulation will be able to load this file in.

Open questions:
* No support here for table updates via the binary attribute. You
  get whatever was there when it was first cached.. Worth including
  these from the start, or leave that complexity for later?  We could
  read directly from the DOE every time, but need to check we get
  a coherent table.  Let's figure this out once we are making 'real'
  use of the table.
* What is maximum size of the SSLBIS entry - I haven't quite managed
  to figure that out and this is the record with largest size.
  We could support dynamic allocation of the record size, but it
  would add complexity that seems unnecessary.
  It would not be compliant with the specification for a type 3 memory
  device to report this record anyway so I'm not that worried about this
  for now.  It will become relevant once we have support for reading
  CDAT from CXL switches.
* cdat.h is formatted in a similar style to pci_regs.h on basis that
  it may well be helpful to share this header with userspace tools.
* Move the generic parts of this out to driver/cxl/cdat.c or leave that
  until we have other CXL drivers wishing to use this?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since v2:
* Naming changes to match those in the patch introducing DOE support.
* Consistent use of lowercase hexadecimal values.

Thanks to Dan Williams for review

Changes since v1:
* static creation of the binary attribute
* moved the debug print to separate patch to make it easy to drop
  later.
* select PCIE_DOE
* Changes due to interface changes in previous patch.

 drivers/cxl/Kconfig |   1 +
 drivers/cxl/cdat.h  |  78 +++++++++++++++++++
 drivers/cxl/cxl.h   |  13 ++++
 drivers/cxl/mem.c   | 177 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..26cad9fa29f7 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -15,6 +15,7 @@ if CXL_BUS
 
 config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
+	select PCI_DOE
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
new file mode 100644
index 000000000000..da9c147cbdfa
--- /dev/null
+++ b/drivers/cxl/cdat.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Coherent Device Attribute table (CDAT)
+ *
+ * Specification available from UEFI.org
+ *
+ * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
+ * done one entry at a time, where the first entry is the header.
+ */
+
+#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
+#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
+#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
+#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
+#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
+
+/*
+ * CDAT entries are little endian and are read from PCI config space which
+ * is also little endian.
+ * As such, on a big endian system these will have been reversed.
+ * This prevents us from making easy use of packed structures.
+ * Style form pci_regs.h
+ */
+
+#define CDAT_HEADER_LENGTH_DW 3
+#define CDAT_HEADER_DW0_LENGTH		0xffffffff
+#define CDAT_HEADER_DW1_REVISION	0x000000ff
+#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
+#define CDAT_HEADER_DW2_SEQUENCE	0xffffffff
+
+/* All structures have a common first DW */
+#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
+#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
+#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
+#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
+#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
+#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
+
+#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
+
+/* Device Scoped Memory Affinity Structure */
+#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
+#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
+
+/* Device Scoped Latency and Bandwidth Information Structure */
+#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
+#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
+#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
+#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
+#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
+
+/* Device Scoped Memory Side Cache Information Structure */
+#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
+#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
+	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
+
+/* Device Scoped Initiator Structure */
+#define CDAT_DSIS_DW1_FLAGS		0x000000ff
+#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
+
+/* Device Scoped EFI Memory Type Structure */
+#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
+#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
+#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
+
+/* Switch Scoped Latency and Bandwidth Information Structure */
+#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
+#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
+#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
+#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
+#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f14838c2d25..eba3f7e7d997 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/pci-doe.h>
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
@@ -57,10 +58,21 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+#define CXL_DOE_PROTOCOL_COMPLIANCE 0
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
+/* Common to request and response */
+#define CXL_DOE_TABLE_ACCESS_3_CODE GENMASK(7, 0)
+#define   CXL_DOE_TABLE_ACCESS_3_CODE_READ 0
+#define CXL_DOE_TABLE_ACCESS_3_TYPE GENMASK(15, 8)
+#define   CXL_DOE_TABLE_ACCESS_3_TYPE_CDAT 0
+#define CXL_DOE_TABLE_ACCESS_3_ENTRY_HANDLE GENMASK(31, 16)
+
 struct cxl_memdev;
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
+ * @table_doe: Data exchange object mailbox used to read tables.
  * @regs: IO mappings to the device's MMIO
  * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
  * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
@@ -75,6 +87,7 @@ struct cxl_memdev;
  */
 struct cxl_mem {
 	struct pci_dev *pdev;
+	struct pci_doe *table_doe;
 	void __iomem *regs;
 	struct cxl_memdev *cxlmd;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..32354d443f2e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -12,6 +12,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "pci.h"
 #include "cxl.h"
+#include "cdat.h"
 
 /**
  * DOC: cxl mem
@@ -99,6 +100,8 @@ struct mbox_cmd {
  * @ops_active: active user of @cxlm in ops handlers
  * @ops_dead: completion when all @cxlm ops users have exited
  * @id: id number of this memdev instance.
+ * @cdat_table: cache of CDAT table
+ * @cdat_length: length of cached CDAT table
  */
 struct cxl_memdev {
 	struct device dev;
@@ -107,6 +110,8 @@ struct cxl_memdev {
 	struct percpu_ref ops_active;
 	struct completion ops_dead;
 	int id;
+	void *cdat_table;
+	size_t cdat_length;
 };
 
 static int cxl_mem_major;
@@ -968,6 +973,85 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static ssize_t cdat_get_length(struct pci_doe *doe)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	struct pci_doe_exchange ex = {
+		.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+	};
+
+	ssize_t rc;
+
+	rc = pci_doe_exchange_sync(doe, &ex);
+	if (rc < 0)
+		return rc;
+	if (rc < 1)
+		return -EIO;
+
+	return cdat_response_pl[1];
+}
+
+static int cdat_to_buffer(struct pci_doe *doe, u32 *buffer, size_t length)
+{
+	int entry_handle = 0;
+	int rc;
+
+	do {
+		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
+		u32 cdat_response_pl[32];
+		struct pci_doe_exchange ex = {
+			.vid = PCI_DVSEC_VENDOR_ID_CXL,
+			.protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+			.request_pl = &cdat_request_pl,
+			.request_pl_sz = sizeof(cdat_request_pl),
+			.response_pl = cdat_response_pl,
+			.response_pl_sz = sizeof(cdat_response_pl),
+		};
+		size_t entry_dw;
+		u32 *entry;
+
+		rc = pci_doe_exchange_sync(doe, &ex);
+		if (rc < 0)
+			return rc;
+
+		entry = cdat_response_pl + 1;
+		entry_dw = rc / sizeof(u32);
+		/* Skip Header */
+		entry_dw -= 1;
+		entry_dw = min(length / 4, entry_dw);
+		memcpy(buffer, entry, entry_dw * sizeof(u32));
+		length -= entry_dw * sizeof(u32);
+		buffer += entry_dw;
+		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
+
+	} while (entry_handle != 0xFFFF);
+
+	return 0;
+}
+
+static void cxl_mem_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static void cxl_mem_doe_unregister_all(void *data)
+{
+	pci_doe_unregister_all(data);
+}
+
 static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 				      u32 reg_hi)
 {
@@ -975,6 +1059,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	struct cxl_mem *cxlm;
 	void __iomem *regs;
 	u64 offset;
+	int irqs;
 	u8 bar;
 	int rc;
 
@@ -1013,6 +1098,44 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 		return NULL;
 	}
 
+	/*
+	 * An implementation of a cxl type3 device may support an unknown
+	 * number of interrupts. Assume that number is not that large and
+	 * request them all.
+	 */
+	irqs = pci_msix_vec_count(pdev);
+	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
+	if (rc != irqs) {
+		/* No interrupt available - carry on */
+		dev_dbg(dev, "No interrupts available for DOE\n");
+	} else {
+		/*
+		 * Enabling bus mastering could be done within the DOE
+		 * initialization, but as it potentially has other impacts
+		 * keep it within the driver.
+		 */
+		pci_set_master(pdev);
+		rc = devm_add_action_or_reset(dev, cxl_mem_free_irq_vectors,
+					       pdev);
+		if (rc)
+			return NULL;
+	}
+
+	/*
+	 * Find a DOE mailbox that supports CDAT.
+	 * Supporting other DOE protocols will require more complexity.
+	 */
+	rc = pci_doe_register_all(pdev);
+	if (rc < 0)
+		return NULL;
+
+	rc = devm_add_action_or_reset(dev, cxl_mem_doe_unregister_all, pdev);
+	if (rc)
+		return NULL;
+
+	cxlm->table_doe = pci_doe_find(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+				       CXL_DOE_PROTOCOL_TABLE_ACCESS);
+
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
 	return cxlm;
 }
@@ -1103,6 +1226,31 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%#llx\n", len);
 }
 
+static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	return memory_read_from_buffer(buf, count, &offset, cxlmd->cdat_table,
+				       cxlmd->cdat_length);
+}
+
+static BIN_ATTR_RO(CDAT, 0);
+
+static umode_t cxl_memdev_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	if ((attr == &bin_attr_CDAT) && cxlmd->cdat_table)
+		return 0400;
+
+	return 0;
+}
+
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
@@ -1112,6 +1260,11 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
+static struct bin_attribute *cxl_memdev_bin_attributes[] = {
+	&bin_attr_CDAT,
+	NULL,
+};
+
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
 	NULL,
@@ -1124,6 +1277,8 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 
 static struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
+	.bin_attrs = cxl_memdev_bin_attributes,
+	.is_bin_visible = cxl_memdev_bin_attr_is_visible,
 };
 
 static struct attribute_group cxl_memdev_ram_attribute_group = {
@@ -1170,6 +1325,25 @@ static void cxlmdev_ops_active_release(struct percpu_ref *ref)
 	complete(&cxlmd->ops_dead);
 }
 
+static int cxl_cache_cdat_table(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *dev = &cxlmd->dev;
+	ssize_t cdat_length;
+
+	if (cxlm->table_doe == NULL)
+		return 0;
+
+	cdat_length = cdat_get_length(cxlm->table_doe);
+	if (cdat_length < 0)
+		return cdat_length;
+
+	cxlmd->cdat_length = cdat_length;
+	cxlmd->cdat_table = devm_kzalloc(dev->parent, cdat_length, GFP_KERNEL);
+
+	return cdat_to_buffer(cxlm->table_doe, cxlmd->cdat_table, cxlmd->cdat_length);
+}
+
 static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
@@ -1208,6 +1382,9 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);
+	rc = cxl_cache_cdat_table(cxlmd);
+	if (rc)
+		goto err_add;
 
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
-- 
2.27.0

