Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5A732196
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjFOVXr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFOVXr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:23:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D92967;
        Thu, 15 Jun 2023 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864226; x=1718400226;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZPKMmEltPj786W57CKF56+/tPQ7KVZQQ9FCw8gYJ4NY=;
  b=PLpozLSKYopiLi0TW7cUaCaddZEVsMyN7JnDDnV1m8Wu5vEZys2HDJFM
   jf0A7Cpj5l8fmOzP++d5FMP7AIp9UgTVL2oej8O9hDyRJJtzsJMmmLLAg
   /ZJdo4zLgmEnfq610dPk8Q37uFj0TelkMnohUSn+XGXxPBlmdPre8k+qG
   GXRuB4HbefIh35WBWbz7v7Jrqf/CE2CIXyZYPNIBUtEIC6qqHQIvCJ+8c
   ZwM9nsuzGVwjauA0vytgjpglIP/MnbzBUSijg+xDBrY5iyYI6lOwU5w3A
   gLlWXV+cCYnIJu6gIIRsnkuZjGE1baF4sM+XFgC8T9gYVOT+aR7s/0bEl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424975384"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424975384"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825457805"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825457805"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:44 -0700
Subject: [PATCH v3 0/6] acpi: numa: add target support for generic port to
 HMAT parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:23:43 -0700
Message-ID: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v3:
- Break out ACPI_SRAT_DEVICE_HANDLE_SIZE define. Merged into ACPICA repo.
- Break out code in hmat_parse_locality() to improve readability. (Jonathan)
- Drop continue after setting gen target access data. (Jonathan)
v2:
- Add check for memory type for setting GENPORT access data. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK
- Change strncmp() to memcmp() for device handle compare

Hi Rafael,
Please consider acking this series. Dan will take it through his CXL tree.
This is the second set of ACPI changes that's part of the "cxl: Add support for
QTG ID retrieval for CXL subsystem" [1]. It has dependency on the patch [2]
that was sent to you and GregKH and Greg has ack'd. But it's independent of the
first set of ACPI changes [3]. The series adds support to store the device handle
from the SRAT Generic Port Affinity Structure in correlation with a proximity
domain. And later on the HMAT is parsed and the performance data is stored
associated with the proximity domain. A helper function is added to allow the CXL
driver to retrieve the performance data that matches with the device handle later
on. The full series of CXL code is at this git repo [4] for usage reference.


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


 drivers/acpi/numa/hmat.c | 151 +++++++++++++++++++++++++++++++++------
 include/acpi/actbl3.h    |   4 +-
 include/linux/acpi.h     |  12 ++++
 3 files changed, 144 insertions(+), 23 deletions(-)

--

