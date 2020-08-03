Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8575D239EF3
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 07:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHCFTZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 01:19:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:43886 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgHCFTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Aug 2020 01:19:25 -0400
IronPort-SDR: /8qX50LK2/HHhJcssv2Sb1Tr1qkwvSVEh9ZL89vtncrN/HRoA/G+o42ppP9CeIJs8Lm4h/nnrM
 RR2flyLUqNjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="170149623"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="170149623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:21 -0700
IronPort-SDR: Bf8V6g2L1auHJzH78LC49D2bN1y5zY1ENkS7gVgamn40maMCkeKjWz4yWkdrDemY6dWcNPbzOt
 r9bDWU0JZASQ==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="287876643"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:21 -0700
Subject: [PATCH v4 07/23] ACPI: HMAT: Attach a device for each soft-reserved
 range
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeff Moyer <jmoyer@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        vishal.l.verma@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Sun, 02 Aug 2020 22:03:03 -0700
Message-ID: <159643098298.4062302.17587338161136144730.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
"soft reserved" memory as an "hmem" device")' only registered ranges to
the hmem driver for each soft-reservation that also appeared in the
HMAT. While this is meant to encourage platform firmware to "do the
right thing" and publish an HMAT, the corollary is that platforms that
fail to publish an accurate HMAT will strand memory from Linux usage.
Additionally, the "efi_fake_mem" kernel command line option enabling
will strand memory by default without an HMAT.

Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
to be published as raw resource ranges for the hmem driver to consume.

Include a module parameter to disable either this fallback behavior, or
the hmat enabling from creating hmem devices. The module parameter
requires the hmem device enabling to have unique name in the module
namespace: "device_hmem".

The driver depends on the architecture providing phys_to_target_node()
which is only x86 via numa_meminfo() and arm64 via a generic memblock
implementation.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/Makefile |    3 ++-
 drivers/dax/hmem/device.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
index a9d353d0c9ed..57377b4c3d47 100644
--- a/drivers/dax/hmem/Makefile
+++ b/drivers/dax/hmem/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
-obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device.o
+obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
 
+device_hmem-y := device.o
 dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index b9dd6b27745c..cb6401c9e9a4 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -5,6 +5,9 @@
 #include <linux/dax.h>
 #include <linux/mm.h>
 
+static bool nohmem;
+module_param_named(disable, nohmem, bool, 0444);
+
 void hmem_register_device(int target_nid, struct resource *r)
 {
 	/* define a clean / non-busy resource for the platform device */
@@ -17,6 +20,9 @@ void hmem_register_device(int target_nid, struct resource *r)
 	struct memregion_info info;
 	int rc, id;
 
+	if (nohmem)
+		return;
+
 	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
 			IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
@@ -63,3 +69,32 @@ void hmem_register_device(int target_nid, struct resource *r)
 out_pdev:
 	memregion_free(id);
 }
+
+static __init int hmem_register_one(struct resource *res, void *data)
+{
+	/*
+	 * If the resource is not a top-level resource it was already
+	 * assigned to a device by the HMAT parsing.
+	 */
+	if (res->parent != &iomem_resource) {
+		pr_info("HMEM: skip %pr, already claimed\n", res);
+		return 0;
+	}
+
+	hmem_register_device(phys_to_target_node(res->start), res);
+
+	return 0;
+}
+
+static __init int hmem_init(void)
+{
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
+	return 0;
+}
+
+/*
+ * As this is a fallback for address ranges unclaimed by the ACPI HMAT
+ * parsing it must be at an initcall level greater than hmat_init().
+ */
+late_initcall(hmem_init);

