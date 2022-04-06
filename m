Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F64F5A0C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiDFJb5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Apr 2022 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580807AbiDFJVK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 05:21:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A0AA024;
        Tue,  5 Apr 2022 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649212678; x=1680748678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uBBoDp9OEecTtULYKqmUDZgqLv9Xxb46gGafhIRRyXs=;
  b=FwV5GBVRvLE72UXpkaVbUIJIiTPcr/++uE3ZzVnUqK9D3zc4MSBYdf/v
   aCABJ+okyqjiqXJfZi5byJy0pTGk9FriQpMn+xvP7zshpHpp1A8dBzG7J
   8QrVDKAzoHIbxkwh+OCn0ybr7YIxV8k7CSWl7r1HW9Lk2D00e4paoFC7n
   aGiUtm1I1rgHSVRLAoQhjV1LeZVib7SZrTz5s9vNJ2Wo77E2o3SmmTBmU
   EgybihQZlRccgGkHdXju5n/6x07/BUtS9ui6Z+jFBWa8BhHrv1Po4Z0sQ
   0x0/wcjaNbfLlGipTgiwsn+9lsj/ZaLcFzaMKRy/l8kTEdI+K3ntXaUtq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241517560"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="241517560"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:37:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="523738416"
Received: from tomasevx-mobl2.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.213.162.23])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:37:57 -0700
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
Subject: [PATCH v5 0/3] PCI/ACPI: add support for CXL _OSC
Date:   Tue,  5 Apr 2022 20:37:43 -0600
Message-Id: <20220406023746.2807328-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; h=from:subject; bh=uBBoDp9OEecTtULYKqmUDZgqLv9Xxb46gGafhIRRyXs=; b=owGbwMvMwCXGf25diOft7jLG02pJDEk+f75eqXTNqSur2L0tsv7h2dczV37++GItW+WkEq74nYtM H2V+7ChlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBELisz/I/mmfyl9u88t9235S68bb nzsN3s1ttdi/zKQ52C9S6ZCX9m+J9Wqtpoujh3i+bxkr3e4tJxzkLtr2ZYHzY6ctfs5Mor53gB
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

Changes since v4[1]:
- Collect an ack for patch 1 (Rafael)
- Fix commit subject wording in patch 2 (Rafael)
- Fix a debug print in patch 2 (Rafael)
- Document the reasoning behind calculation of cxl hotplug support (David)
- A few definition and variable name changes to make the new _OSC DWORDS
  generic instead of CXL specific (Rafael)

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

[1]: https://lore.kernel.org/linux-cxl/20220331202022.1823174-1-vishal.l.verma@intel.com
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

