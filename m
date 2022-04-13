Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461C4FF0A4
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Apr 2022 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiDMHis (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Apr 2022 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiDMHiq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2022 03:38:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D94D9E4;
        Wed, 13 Apr 2022 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649835386; x=1681371386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a9FNuEMP61m2fHgMjp7yVJHnXHxuMnWaA8wBp4f2AQI=;
  b=liKETtNJI4N07u79FRFQ+33b2UCN4lYUKs0L2BZXdJbYY+k+C7BsVCIC
   IquIHe7gDCiKwVqzTTKLmfhWMYU5EDzfcssG7V29UFJxYehAHUdV5sHiy
   8StP7ig/z3iafpRAzgoxRday01jBlBlbWsHAYaXbmnCK5aF9RwAZ9WFAN
   rgQ0titugjhENGVjxkg4v1Qy0S7Lsv9JW0CjWupzTmux0aOcJlwd1SdrN
   YKNEPOkaWnCoUAP89yIolwR0LMVc3/9CRrAPV7w4ZUl4ONJ1GIz09OcC3
   lsxi9WeqVXfK5ZjdXE30PJ+7pDhJR/wlmiC2VrCfCL8ruylYGAoyBL38U
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261446325"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261446325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="590658958"
Received: from boturkot-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.35.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:36:25 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
Date:   Wed, 13 Apr 2022 01:36:15 -0600
Message-Id: <20220413073618.291335-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; h=from:subject; bh=a9FNuEMP61m2fHgMjp7yVJHnXHxuMnWaA8wBp4f2AQI=; b=owGbwMvMwCXGf25diOft7jLG02pJDElhtYV/nzuI6++6YSn8rfpnmrWTZdleP9NTkTKLPOcLu6UH f2XoKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwESuXWFkmJsvULsmtONT291dVvvC51 5TiPBp4raPXRaoZHLpSYDvLIZ/pvZJd/+YcrrrSQkueRr/5PPZaQmBs+6zNq4/9n/RldRjPAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v5[1]:
- Collect an reviewed-by tags from Rafael, Adam, and David
- Fix a couple of missed s/CXL/extended/ in acpi_bus.h (Rafael)

Add support for using the CXL definition of _OSC where applicable, and
negotiating CXL specific support and control bits.

Patch 1 is a preliminary cleanup that replaces open-coded pointer
arithmetic to retrieve the Control DWORD with an inline helper.

Patch 2 adds the new CXL _OSC UUID, and uses it instead of the PCI UUID
when a root port is CXL enabled. It provides a fallback method for
CXL-1.1 platforms that may not implement the CXL-2.0 _OSC.

Patch 3 performs negotiation for the CXL specific _OSC support and
control bits.

I've tested these against a custom qemu[2], which adds the CXL _OSC (in
addition to other CXL support). Specifically, _OSC support is added
here[3].

[1]: https://lore.kernel.org/linux-cxl/20220406023746.2807328-1-vishal.l.verma@intel.com
[2]: https://gitlab.com/jic23/qemu/-/tree/cxl-v8-draft
[3]: https://gitlab.com/jic23/qemu/-/commit/1d67df6b6e3716c27462873f3451956f5c0673a3

Dan Williams (1):
  PCI/ACPI: Prefer CXL _OSC instead of PCIe _OSC for CXL host bridges

Vishal Verma (2):
  PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
  PCI/ACPI: negotiate CXL _OSC

 include/linux/acpi.h    |  42 ++++++-
 include/acpi/acpi_bus.h |  12 +-
 drivers/acpi/bus.c      |   2 +-
 drivers/acpi/pci_root.c | 240 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 262 insertions(+), 34 deletions(-)


base-commit: 05e815539f3f161585c13a9ab023341bade2c52f
-- 
2.35.1

