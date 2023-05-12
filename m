Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9375F700B86
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbjELP0E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbjELP0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 11:26:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380083AB7
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905162; x=1715441162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mt/rY8nFLqePLy7c6GuHXT4djfF6l4xQGiJ8ioLf4FA=;
  b=id3jZMv9sNqiBrZRd2PfO/F4GxvVdjDEUdmp4yVecH4tlwRPLVDnbCMQ
   CtaP1XNqUrPydWrhLk+EaHcpitE3pc2UduGT62wK8UCVbPWLcWQvoaKuO
   QlX3eO7VpdHXF5mQOdmllZU9inlxtR9vBRj6uavw3idnQQdLkJtof5KzY
   SJ2qXAPPQ9whDXGrvyQx1QiMLiFJhsP1pbInazQiUVj6J6AQ2o/szpXpk
   Atz89YjYIiF5HVPBmXspupXZ1FZ5wYCan9yab8JnoMA7jNi0Rl3peWGn8
   dItf0MJyQFFCZ64DmxHfqta7jDwRXBgOxXq1ETWU5rf3HEw++Ml1ks301
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="330431087"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="330431087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="733078191"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="733078191"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:26:00 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        hanjun.guo@linaro.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/2] Prefer using _OSC method over deprecated _PDC
Date:   Fri, 12 May 2023 17:25:43 +0200
Message-Id: <20230512152545.125302-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 3.0 introduced a new Operating System Capabilities _OSC control
method. This method is similar to _PDC, which was marked as deprecated
in ACPI 3.0.

Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
case of the failure of the _OSC, try to using _PDC as a fallback.

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

Michal Wilczynski (2):
  acpi: Use _OSC method to convey processor OSPM capabilites
  acpi: Move logic responsible for conveying processor OSPM capabilities

 arch/ia64/include/asm/acpi.h  |   4 +-
 arch/x86/include/asm/acpi.h   |  12 ++--
 drivers/acpi/acpi_processor.c | 132 +++++++++++++++++++++++++++-------
 drivers/acpi/bus.c            |  11 +--
 drivers/acpi/internal.h       |   7 +-
 drivers/acpi/processor_pdc.c  |  82 +--------------------
 include/acpi/pdc_intel.h      |   1 +
 include/acpi/processor.h      |   2 +-
 8 files changed, 133 insertions(+), 118 deletions(-)

-- 
2.40.1

