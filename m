Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE044DE38B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiCRVbc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiCRVbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 17:31:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA817A2FA;
        Fri, 18 Mar 2022 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647639012; x=1679175012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tbh7fT+5716maWcpGZHWrhJ1lNkaQOxmLvbZuPafsEQ=;
  b=eeXfAF7pe1juUyKi+LM7wHkQCudUTLMauIDTvD8cJIWRDUjFq577Q0EP
   +19xzJ1T7Rw6u6gxtE63gdvW63pECelARFg7jDWDOjbb5pR+CgeqJjJGX
   HFOjplMMJrF7nfDIlW1c8O/n0amJj8e9t5kdgE1M6KCoS20xTpMoxL9v3
   sU5JZQv9RbLLXJDcsBR8SnRU8NHoE7WGdooRSw0zCXGRb2lMFTK3Whaip
   7ZVCXEXRu6rHyS2v0abNxfuuMzeD7fOId7TLBVYpeitjv3oKLcdQyn1lV
   48yt/hiUiJ5cFCz4i7yYf6Vw/xOuty+ZN+D0Iyp4Z84Zmd4T6rmD3cwHb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256956854"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256956854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:30:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715660973"
Received: from jreis-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.154.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:30:11 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/2] acpi: add support for CXL _OSC
Date:   Fri, 18 Mar 2022 15:30:02 -0600
Message-Id: <20220318213004.2287428-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; h=from:subject; bh=Tbh7fT+5716maWcpGZHWrhJ1lNkaQOxmLvbZuPafsEQ=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkmP29PDzQXWXlV8n22rBnj2Wn7qxWXs61w+7hKNv2Gr9Wl VelXOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCR26kMf6WLFnYfLkqYI7Z765Wp0S 7SK4MmxK7IXMFgvU7KOYD7tjIjw5WnEUu2nXKaE/+3vprDf973yH//tQSvPPpyMeCh8PLICh4A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v1[1]:
- Update changelogs for both patches (Dan)
- Fix support/control calculation to be based off CONFIG_MEMORY_FAILURE
  (Dan)
- Use defines instead of magic numbers in a few places in patch 2
  (Jonathan)
- Fix 'capbuf' array to be the correct 5 elements. ACPI previously had
  '6' where only 3 were needed. With CXL capabilities, now, 5 are
  needed. (Jonathan).
- Fix a couple of uninitialized variable warnings reported by 0day/lkp.
- Drop 'RFC' annotation for the set

Add support for using the CXL definition of _OSC where applicable, and
negotiating CXL specific support and control bits.

Patch 1 adds the new CXL _OSC UUID, and uses it instead of the PCI UUID
when a root port is CXL enabled. It provides a fallback method for
CXL-1.1 platforms that may not implement the CXL-2.0 _OSC.

Patch 2 performs negotiation for the CXL specific _OSC support and
control bits.

I've tested these against a custom qemu[2], which adds the CXL _OSC (in
addition to other CXL support). Specifically, _OSC support is added
here[3].

[1]: https://lore.kernel.org/linux-cxl/146514b2e5237a3c027239a75ace69e72671d4c8.camel@intel.com/T/#t
[2]: https://gitlab.com/jic23/qemu/-/tree/cxl-v7-draft-2-for-test
[3]: https://gitlab.com/jic23/qemu/-/commit/31c85054b84645dfbd9e9bb14aa35286141c14cf


Dan Williams (1):
  PCI/ACPI: Use CXL _OSC instead of PCIe _OSC

Vishal Verma (1):
  acpi/pci_root: negotiate CXL _OSC

 include/linux/acpi.h    |  14 +++
 include/acpi/acpi_bus.h |   7 +-
 drivers/acpi/pci_root.c | 204 ++++++++++++++++++++++++++++++++++------
 3 files changed, 193 insertions(+), 32 deletions(-)


base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
-- 
2.35.1

