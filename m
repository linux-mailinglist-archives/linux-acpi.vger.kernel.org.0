Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA264ECB90
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349824AbiC3SQv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349920AbiC3SQh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 14:16:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A36DF4C;
        Wed, 30 Mar 2022 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648664090; x=1680200090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CzkTDltQLY529JPckw9IyjtjINE/P9X9eKTMZyoIehw=;
  b=R0ayF46HMoEzWayR66GLZT3z+WXaM+0YWFXHD1et3d/mVqdjzM75YN4I
   9/LhPp56pWtCchaPN/GJrdsQdzojiy1Jwsj4QlCVA+oOJpMRZDwOh+5Mq
   R4eXayKg0OiHBu8jQy0mZayjyhK2uwVAjpG5BbuK2go/+3BwwzBC5TPg9
   4lHY3UpxwT6OVURGbUKNv+7/EH8G1Sid7WRaRIM7blWhrX1DBBclrdXgr
   ymjWgFLEP5I4ZrqY7lO1G3m9CXvwxfJFEhxk6Ou4DKuRbuPgdMuzqZZJp
   2zQe0/tcA4Z0s1MlJ5+aCkGLx2/9g42CHmDHmRpMnSPbgbedjgin0AbtB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241764486"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241764486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:14:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="653992024"
Received: from sbathula-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.170.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:14:49 -0700
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
Subject: [PATCH v3 0/3]  acpi: add support for CXL _OSC
Date:   Wed, 30 Mar 2022 12:14:31 -0600
Message-Id: <20220330181434.1515791-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; h=from:subject; bh=CzkTDltQLY529JPckw9IyjtjINE/P9X9eKTMZyoIehw=; b=owGbwMvMwCXGf25diOft7jLG02pJDEku87gMu9aunOTVH/2ixXiS8nwbucavnunFJ2LNF5mIqbpH PlTtKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwET2KDMydOZkng0L46w5dkTeZVNDkt t559x33LWS0ZaujKqNd02PMjJMNFRh/D/jR7KStssZW79TUj23DvzLqin+Vq92lk3nWy4DAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v2[1]:
- Add a prep patch replacing pointer arithmetic with a helper (David)
- Make is_pcie/is_cxl helpers inline (David)
- Tidy up the if/else in the above helpers (David)

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

[1]: https://lore.kernel.org/linux-cxl/20220326002430.797244-1-vishal.l.verma@intel.com/
[2]: https://gitlab.com/jic23/qemu/-/tree/cxl-v8-draft
[3]: https://gitlab.com/jic23/qemu/-/commit/1d67df6b6e3716c27462873f3451956f5c0673a3

Dan Williams (1):
  PCI/ACPI: Use CXL _OSC instead of PCIe _OSC

Vishal Verma (2):
  acpi: add a helper for retrieving _OSC Control DWORDs
  acpi/pci_root: negotiate CXL _OSC

 include/linux/acpi.h    |  44 ++++++++-
 include/acpi/acpi_bus.h |  12 ++-
 drivers/acpi/bus.c      |   2 +-
 drivers/acpi/pci_root.c | 207 ++++++++++++++++++++++++++++++++++------
 4 files changed, 231 insertions(+), 34 deletions(-)


base-commit: 05e815539f3f161585c13a9ab023341bade2c52f
-- 
2.35.1

