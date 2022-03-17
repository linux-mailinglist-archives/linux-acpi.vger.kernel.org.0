Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFC4DBBAA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 01:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiCQA2X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 20:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCQA2X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 20:28:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC51C930;
        Wed, 16 Mar 2022 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647476827; x=1679012827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lic9ChaQZXkEd9xgaha9i8E77wzSUJy2HT8oCui14Lk=;
  b=UVgytTo4C4hyx91dn/msVxcTXChVef0MuI4CCwPsI/8jbAgavSPFr5rY
   vDpZ0cq6E6P6+gNl+OeuAOPpNN1jy0DZ/F7O6u1bFgUwH0QVWh/l5Nswk
   kQrTCw3HPEXYBZQRTFwYiLDPj5TrsvcUmdtKsiHeN7Ks89zBAEsFjZOsg
   DtRyAP99M+OO1lcd31mBCTDP197gnUi/t48pHlvR85YtCoh4kX6op+t+c
   HlIbgkPBftMFCkrW/7eV3LRJgaD0DLFFNbQ4Ifo1iA5YeRq0TtBAJzvjx
   5PW/hmP/v/zY31IciLsekY9PS/gfws+JZ5qHNJDpTfaAgi4SiJhhNIuH/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256699162"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256699162"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="646860796"
Received: from mjbitsoi-mobl2.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.15.66])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:27:06 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 0/2] acpi: add support for CXL _OSC
Date:   Wed, 16 Mar 2022 18:27:02 -0600
Message-Id: <20220317002704.1835870-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; h=from:subject; bh=Lic9ChaQZXkEd9xgaha9i8E77wzSUJy2HT8oCui14Lk=; b=owGbwMvMwCXGf25diOft7jLG02pJDElGDRESUpml/m0CBWrrNizl8eS9fMr4iP6rEp7ABEW74nf1 7vkdpSwMYlwMsmKKLH/3fGQ8Jrc9HyjpCDOHlQlkCAMXpwBMJMSIkWH1IX3VXZYzAsS2WAg6BsaXFk +f2BXS4e7aUyC+8kKp+k6GvwKhTw1ub5fSjvp4Y/30hvZpF9vPmmzT/MTC/Prgh8M237kB
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for using the CXL definition of _OSC where applicable, and
negotiating CXL specific support and control bits.

Patch 1 adds the new CXL _OSC UUID, and uses it instead of the PCI UUID
when a root port is CXL enabled. It provides a fallback method for
CXL-1.1 devices that may not implement the CXL-2.0 _OSC.

Patch 2 performs negotiation for the CXL specific _OSC support and
control bits.

I've tested these against a custom qemu[1], which adds the CXL _OSC (in
addition to other CXL support). Specifically, _OSC support is added
here[2].

[1]: https://gitlab.com/jic23/qemu/-/tree/cxl-v7-draft-2-for-test
[2]: https://gitlab.com/jic23/qemu/-/commit/31c85054b84645dfbd9e9bb14aa35286141c14cf

Dan Williams (1):
  PCI/ACPI: Use CXL _OSC instead of PCIe _OSC

Vishal Verma (1):
  acpi/pci_root: negotiate CXL _OSC

 include/linux/acpi.h    |  11 +++
 include/acpi/acpi_bus.h |   7 +-
 drivers/acpi/pci_root.c | 201 ++++++++++++++++++++++++++++++++++------
 3 files changed, 187 insertions(+), 32 deletions(-)


base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
-- 
2.35.1

