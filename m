Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E634E7E1C
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Mar 2022 01:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiCZA0T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 20:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCZA0R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 20:26:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB3205D5;
        Fri, 25 Mar 2022 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254281; x=1679790281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qch5MSW4NigwHzhibHiE2NKnUAHK5Hhrnj4kWB0eY84=;
  b=YQx8CylPYWUJ6hpYur/8ezMgShg93Vv8ikQQzOWWK/LkDW/FwaPThWWL
   7nggq0sCRyG2CQtp5jHIDIEkZeMqiYDMQGBlV18zpELMxFPbZ68bCYJCN
   uBydyL+FsZVzdnGX84dAlpj61HNvr+Y6qopAzPujOoWz8XuGTKLF9V2de
   34WfksaO8JWKho2/BQWJY8bQ89DPigzOrwY21g4Orr9jPK/kC7sH7SbKp
   aI/dBpMsmhHoT5oCh77Ag9EBbfURmKoMsrWJVNPoaT1x1dBRx33WU7pUv
   m/UfloSEuA+q9uqmsaH0WmVYsCinBrc3/WuOmxrgUzck3kXm4NRocO5Dm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283621480"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283621480"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="617281313"
Received: from jamanorb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.81.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:41 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/2] acpi: add support for CXL _OSC
Date:   Fri, 25 Mar 2022 18:24:28 -0600
Message-Id: <20220326002430.797244-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; h=from:subject; bh=Qch5MSW4NigwHzhibHiE2NKnUAHK5Hhrnj4kWB0eY84=; b=owGbwMvMwCXGf25diOft7jLG02pJDEl2sTqq6XYsEtEm3+rvlkh5P1thbdhRIMQ25c+T87+k9xxY LxvQUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIn0SjP8FflW+GvP5gl/Z9+oyMs+uX Oxx7NKzXcfjzr+ynFS2LjA5i3DPxW+BkeFRpV1a7L8fS+fvey029E19p7dIR5fg/t/osR+swIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v1[1]:
- Reword commit message (Dan)
- Move the OSC capability size definition and usage into patch 1 (Davidlohr)
- Clean up some unnecessary parens (Rafael)
- Avoid repetitive strcmp()'s in is_pcie()/is_cxl() helpers (Rafael)
- Clean up some pointer math (Rafael)
- Fix a copy-paste error in updating the saved OSC mask (Rafael)
- Fix a bug where we'd try to print missing OSC bits when we should've
  been printing missing PCI bits.

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

[1]: https://lore.kernel.org/all/20220318213004.2287428-1-vishal.l.verma@intel.com/
[2]: https://gitlab.com/jic23/qemu/-/tree/cxl-v8-draft
[3]: https://gitlab.com/jic23/qemu/-/commit/1d67df6b6e3716c27462873f3451956f5c0673a3

Dan Williams (1):
  PCI/ACPI: Use CXL _OSC instead of PCIe _OSC

Vishal Verma (1):
  acpi/pci_root: negotiate CXL _OSC

 include/linux/acpi.h    |  20 +++-
 include/acpi/acpi_bus.h |  12 ++-
 drivers/acpi/pci_root.c | 225 ++++++++++++++++++++++++++++++++++------
 3 files changed, 224 insertions(+), 33 deletions(-)


base-commit: 05e815539f3f161585c13a9ab023341bade2c52f
-- 
2.35.1

