Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36970519C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjEPPGu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjEPPGs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 11:06:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98267EF9
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684249602; x=1715785602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f4o+CpwwBOdBb1S5rRa1o8YSDp7PZI5A2YSnveHBSro=;
  b=n+7xzxvnH0JbeBwEtNaafqhqzHDehgJmST48jYnLDv3UmaJjAZzajbOH
   Xz3MljteeSGa4IldJcSUtFSUjYhJpNmVDmB32kY4iOAI2u3nBlGDv3eom
   IZ98+ekjctG18cWBjVs9ISnVPnOvZbNfDI/b0QDse76nQMYsRSjK2eK34
   OudJWeMbVrQPT1Oj5xSOzK0NXW4QOqhr0tdNgWV4uZs67D7uRr2xB7wn+
   T30dqvs2gXKg7Zd2L+M4R4kjBETuOW+xcR8ZvvnqWf2UlDI6moflDsitm
   vQOtrbVzZRJAqfxQBrPRwejZnHHY2jZY0kA5bCtruLYVRCeHTWSj4+OkQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417158341"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417158341"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704446029"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704446029"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 08:06:13 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 0/2] Prefer using _OSC method over deprecated _PDC
Date:   Tue, 16 May 2023 17:05:56 +0200
Message-Id: <20230516150558.149886-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 3.0 introduced a new Operating System Capabilities _OSC control
method. This method is similar to _PDC, which was marked as deprecated
in ACPI 3.0.

Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
case of the failure of the _OSC, try using _PDC as a fallback.

Testing done:
Tested on physical server with BIOS implementing _OSC methods. In this
case acpi_processor_osc() was executed for each CPU core. acpi_run_osc()
returned success indicating that _OSC method succeeded.

Tested on qemu VM to check whether the code would work on a SeaBios (the
default for qemu, doesn't support _OSC methods, or _PDC). This way I was
able to see how code behaves in case BIOS doesn't implement _OSC. In
that case the function
acpi_run_osc() returned failure, which propagated all the way up to
acpi_early_processor_osc(). The logic reponsible for triggering _PDC
execution was triggered correctly.

Tested this using debug messages with printk.

v2:
 - fixed compilation issues on ia64 and arm

Michal Wilczynski (2):
  acpi: Use _OSC method to convey processor OSPM capabilities
  acpi: Move logic responsible for conveying processor OSPM capabilities

 arch/ia64/include/asm/acpi.h  |   4 +-
 arch/x86/include/asm/acpi.h   |  12 ++--
 drivers/acpi/acpi_processor.c | 130 ++++++++++++++++++++++++++++------
 drivers/acpi/bus.c            |  11 +--
 drivers/acpi/internal.h       |   7 +-
 drivers/acpi/processor_pdc.c  |  82 +--------------------
 include/acpi/pdc_intel.h      |   1 +
 include/acpi/processor.h      |   2 +-
 8 files changed, 133 insertions(+), 116 deletions(-)

-- 
2.40.1

