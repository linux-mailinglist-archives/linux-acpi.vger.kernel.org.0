Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D224EE28A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Mar 2022 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiCaUWQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Mar 2022 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiCaUWO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2022 16:22:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA819E3B5;
        Thu, 31 Mar 2022 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648758026; x=1680294026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7L5p/Tsn4VQqphAlCBKZLC476uhq6ClY6VH+aZE2W58=;
  b=Uupd/xRciT8URavyAmpwgQPB++qmjplCsKApfWeNU5N9evULI1lLJpcx
   8Z38VLYLBG5LWpGhv3GIb907LKGsUcBbwx/52dBlgrp0wO+xBwAPuod/9
   moMqGXI7+fdGdQv1zIp31Vv1lAKpmVM9eA5gWKibU+LSLI9w3u2s9nSid
   wa8QoJDAVMOHxznrOp4yZRKjinx/7A304pi4/P3nxyweu2pBX3VYO2zHa
   d0d9zpx5GPEHr469KLf+i5KNLFeot266OkzdrWQC966CJeMV628muiC9j
   2nt5m3xxAfem6DQ3VFHLKI5eTVesFF/LxNHsSmePzPgBOudA7XKdHwMUb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="240543568"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="240543568"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:20:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503899653"
Received: from pmuthurs-mobl4.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.72.98])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:20:25 -0700
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
Subject: [PATCH v4 0/3] PCI/ACPI: add support for CXL _OSC
Date:   Thu, 31 Mar 2022 14:20:19 -0600
Message-Id: <20220331202022.1823174-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; h=from:subject; bh=7L5p/Tsn4VQqphAlCBKZLC476uhq6ClY6VH+aZE2W58=; b=owGbwMvMwCXGf25diOft7jLG02pJDEluPL+e9T9OKjcXLlY49Grypupdk9ut6+4c41yeuzR0rXem x/rDHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZgIrwUjw8p7T/azlMaJfz5aYNd07u Pmfb9fy34LUFZR9Z16/6bLumqGP5y1/P1X1wjzHY3aPWdiQEr5K76va93Wthv4X3k39Zn3Cx4A
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

Changes since v3[1]:
- Fix up commit subject prefixes (Bjorn)
- Fix typos in commit messages (Bjorn)
- Drop 0day's reported-by trailer (Bjorn)
- Fix another 0day warning from v3

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

[1]: https://lore.kernel.org/linux-cxl/20220330181434.1515791-1-vishal.l.verma@intel.com/
[2]: https://gitlab.com/jic23/qemu/-/tree/cxl-v8-draft
[3]: https://gitlab.com/jic23/qemu/-/commit/1d67df6b6e3716c27462873f3451956f5c0673a3

Dan Williams (1):
  PCI/ACPI: Use CXL _OSC instead of PCIe _OSC

Vishal Verma (2):
  PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
  PCI/ACPI: negotiate CXL _OSC

 include/linux/acpi.h    |  44 ++++++++-
 include/acpi/acpi_bus.h |  12 ++-
 drivers/acpi/bus.c      |   2 +-
 drivers/acpi/pci_root.c | 207 ++++++++++++++++++++++++++++++++++------
 4 files changed, 231 insertions(+), 34 deletions(-)


base-commit: 05e815539f3f161585c13a9ab023341bade2c52f
-- 
2.35.1

