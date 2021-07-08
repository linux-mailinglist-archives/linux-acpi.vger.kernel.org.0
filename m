Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2B3C18FA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGHSLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhGHSLv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 675F91424;
        Thu,  8 Jul 2021 11:09:09 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FE4D3F66F;
        Thu,  8 Jul 2021 11:09:08 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 09/13] mailbox: pcc: Add PCC register bundle and associated accessor functions
Date:   Thu,  8 Jul 2021 19:08:47 +0100
Message-Id: <20210708180851.2311192-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extended PCC subspaces introduces more registers into the PCCT. In order
to consolidate access to these registers and to keep all the details
contained in one place, let us introduce PCC register bundle that holds
the ACPI Generic Address Structure as well as the virtual address for
the same if it is mapped in the OS.

It also contains the various masks used to access the register and
the associated read, write and read-modify-write accessors.

We can also clean up the initialisations by having a helper function
for the same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index c4eecccac4b8..7d48e5c1ac52 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -52,6 +52,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
@@ -64,6 +65,23 @@
 
 static struct mbox_chan *pcc_mbox_channels;
 
+/**
+ * struct pcc_chan_reg - PCC register bundle
+ *
+ * @vaddr: cached virtual address for this register
+ * @gas: pointer to the generic address structure for this register
+ * @preserve_mask: bitmask to preserve when writing to this register
+ * @set_mask: bitmask to set when writing to this register
+ * @status_mask: bitmask to determine and/or update the status for this register
+ */
+struct pcc_chan_reg {
+	void __iomem *vaddr;
+	struct acpi_generic_address *gas;
+	u64 preserve_mask;
+	u64 set_mask;
+	u64 status_mask;
+};
+
 /**
  * struct pcc_chan_info - PCC channel specific information
  *
@@ -144,6 +162,53 @@ static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
 	return ret_val;
 }
 
+static int pcc_chan_reg_read(struct pcc_chan_reg *reg, u64 *val)
+{
+	int ret = 0;
+
+	if (!reg->gas) {
+		*val = 0;
+		return 0;
+	}
+
+	if (reg->vaddr)
+		ret = read_register(reg->vaddr, val, reg->gas->bit_width);
+	else
+		ret = acpi_read(val, reg->gas);
+
+	return ret;
+}
+
+static int pcc_chan_reg_write(struct pcc_chan_reg *reg, u64 val)
+{
+	int ret = 0;
+
+	if (!reg->gas)
+		return 0;
+
+	if (reg->vaddr)
+		ret = write_register(reg->vaddr, val, reg->gas->bit_width);
+	else
+		ret = acpi_write(val, reg->gas);
+
+	return ret;
+}
+
+static int pcc_chan_reg_read_modify_write(struct pcc_chan_reg *reg)
+{
+	int ret = 0;
+	u64 val;
+
+	ret = pcc_chan_reg_read(reg, &val);
+	if (ret)
+		return ret;
+
+	val &= reg->preserve_mask;
+	val |= reg->set_mask;
+
+	return pcc_chan_reg_write(reg, val);
+}
+
 /**
  * pcc_map_interrupt - Map a PCC subspace GSI to a linux IRQ number
  * @interrupt: GSI number.
@@ -374,6 +439,31 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
 	return -EINVAL;
 }
 
+static int
+pcc_chan_reg_init(struct pcc_chan_reg *reg, struct acpi_generic_address *gas,
+		  u64 preserve_mask, u64 set_mask, u64 status_mask, char *name)
+{
+	if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		if (!(gas->bit_width >= 8 && gas->bit_width <= 64 &&
+		      is_power_of_2(gas->bit_width))) {
+			pr_err("Error: Cannot access register of %u bit width",
+			       gas->bit_width);
+			return -EFAULT;
+		}
+
+		reg->vaddr = acpi_os_ioremap(gas->address, gas->bit_width / 8);
+		if (!reg->vaddr) {
+			pr_err("Failed to ioremap PCC %s register\n", name);
+			return -ENOMEM;
+		}
+	}
+	reg->gas = gas;
+	reg->preserve_mask = preserve_mask;
+	reg->set_mask = set_mask;
+	reg->status_mask = status_mask;
+	return 0;
+}
+
 /**
  * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
  *
-- 
2.25.1

