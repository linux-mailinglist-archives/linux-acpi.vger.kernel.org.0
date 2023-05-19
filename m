Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C5709C59
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjESQYX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESQYW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 12:24:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945418F;
        Fri, 19 May 2023 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684513461; x=1716049461;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JRGEH3KFW6PaD19GRaQJ2lXWU5JPYStEgEq8nxiKb9w=;
  b=lV5gYyitOvverGL5rjLLXOeJjHc5fvzFiTzMtKTvIG3407OtuQSFqbyA
   exDwi5h9BIwSk8yt4BJij3BHC51fOqZRH398qPqQW6iUB5nIiA/qlQTrb
   7KhVmOsgisxsIoTfnDbXGpPvOk4Lni1m9hAVYFfXNloXdqzB9esmtiexO
   IipTA/1TOBYjPpucsc2zSaB/JaM7zDjoFugSIR0Y1kTPWlKQME6Slm6X1
   ggtsqnovL1KoqbnGA5b87g6GcZys7BAx17RoGYh4sFwC8Lpvbirdfg8CR
   32yFbf5OLVBXQCpoEhZG5z2Xh/eI6EZn/DZENyT/hzoMp5vi6HaQWNDYt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="415878633"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="415878633"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 09:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="949171211"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="949171211"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 09:24:20 -0700
Subject: [PATCH v2 0/4] acpi: numa: Add target support for generic port to
 HMAT parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 09:24:20 -0700
Message-ID: <168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v2:
- Add check for memory type for setting GENPORT access data. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK
- Change strncmp() to memcmp() for device handle compare

Hi Rafael,
Please consider this series for the v6.5 merge window.
This is the second set of ACPI changes that's part of the "cxl: Add support for
QTG ID retrieval for CXL subsystem" [1]. It has dependency on the patch [2]
that was sent to you and GregKH. But it's independent of the first set of
ACPI changes [3]. The series adds support to store the device handle from the
SRAT Generic Port Affinity Structure in correlation with a proximity domain. And
later on the HMAT is parsed and the performance data is stored associated with
the proximity domain. A helper function is added to allow the CXL driver to
retrieve the performance data that matches with the device handle later on. The
full series of CXL code is at this git repo [4] for usage reference. Please
review and consider for v6.5 inclusion if acceptable. Thank you!


[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t 
[2]: https://lore.kernel.org/lkml/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
[3]: https://lore.kernel.org/linux-acpi/168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3/T/#t
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

---

Dave Jiang (4):
      acpi: numa: Create enum for memory_target access coordinates indexing
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: numa: Add setting of generic port system locality attributes
      acpi: numa: Add helper function to retrieve the performance attributes


 drivers/acpi/numa/hmat.c | 133 ++++++++++++++++++++++++++++++++++-----
 include/acpi/actbl3.h    |   4 +-
 include/linux/acpi.h     |  12 ++++
 3 files changed, 134 insertions(+), 15 deletions(-)

--

