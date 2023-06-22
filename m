Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59F73ABB2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVVjb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVVja (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:39:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990851FED;
        Thu, 22 Jun 2023 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687469969; x=1719005969;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ux94kaeW0cagMLxe6vfpiYO9zMGHKbIV4O5DxjGcqC4=;
  b=F4thHXpG3YLqfV7K2HsZbpT706feRe5Tmz3DLzZeSqdLg4lGwVZB+Cvh
   oV385zuXK8zRzimFiyeawcFObMFBDKO2n1eF3VgZBSU7Kejb7/G63cHy6
   6i44xooi/nn64fLbP3OPUk775PWMLKAwP+iQOuuC3SktB6R7FiMHmz4r5
   SXMydtxF6ErfP0Hxs/yIc3KLHXTz2x5VuvI9NRTiBGVv+taFQHqbiJTb1
   ButReQCQ2fnvFqsszkcdQUJtlNug2lk1+a3/bHObFJTvDLg3NtE3ALZjE
   FupLwTRxJnV73RCYB8dEg+aStPUrcYh7qSIjA7oQ8ncgjUzYIrI8AbfOQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345381173"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="345381173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715088801"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715088801"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:26 -0700
Subject: [PATCH v4 0/6] acpi: numa: add target support for generic port to
 HMAT parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:39:26 -0700
Message-ID: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v4:
- Rename device_handel to gen_port_device_handle. (Jonathan)
- Reorder setting of access coordinate. (Jonathan)
v3:
- Break out ACPI_SRAT_DEVICE_HANDLE_SIZE define. Merged into ACPICA repo.
- Break out code in hmat_parse_locality() to improve readability. (Jonathan)
- Drop continue after setting gen target access data. (Jonathan)
v2:
- Add check for memory type for setting GENPORT access data. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK
- Change strncmp() to memcmp() for device handle compare

Hi Dan,
Rafale has provided his ack. You can take this series with the QTG series.

This is the second set of ACPI changes that's part of the "cxl: Add support for
QTG ID retrieval for CXL subsystem" [1]. It has dependency on the patch [2]
that was sent to you and GregKH and Greg has ack'd. But it's independent of the first set of
ACPI changes [3]. The series adds support to store the device handle from the
SRAT Generic Port Affinity Structure in correlation with a proximity domain. And
later on the HMAT is parsed and the performance data is stored associated with
the proximity domain. A helper function is added to allow the CXL driver to
retrieve the performance data that matches with the device handle later on. The
full series of CXL code is at this git repo [4] for usage reference.

[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t 
[2]: https://lore.kernel.org/lkml/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
[3]: https://lore.kernel.org/linux-acpi/168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3/T/#t
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

---

Dave Jiang (6):
      acpi: numa: Create enum for memory_target access coordinates indexing
      ACPICA: Add a define for size of acpi_srat_generic_affinity DeviceHandle
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: Break out nesting for hmat_parse_locality()
      acpi: numa: Add setting of generic port system locality attributes
      acpi: numa: Add helper function to retrieve the performance attributes


 drivers/acpi/numa/hmat.c | 154 +++++++++++++++++++++++++++++++++------
 include/acpi/actbl3.h    |   4 +-
 include/linux/acpi.h     |  12 +++
 3 files changed, 147 insertions(+), 23 deletions(-)

--

