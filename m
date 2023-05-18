Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC777087DB
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjERSdV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjERSdV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:33:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72951E4A;
        Thu, 18 May 2023 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684434788; x=1715970788;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/eNA6BJzzTyV60RnRwAj1mjCPR5eRqWCes49Y+DoTUY=;
  b=n0mdcd54GpKOhZDUK+JIpuniOvLne8KXDkqzQI/NishutcC2iCvWPTnE
   /fmXPUTCdgjEEL/zKYp9jQNPf8V3JIp8ivFTXV8voVbaFpWq13HbP4Ngg
   VWoLuBPJ53v2EJ8li/23ySsiUIsya2wc+diwCFKfmb69geHqu8V6karNQ
   lhg31zrazTSIQYeygd+FjCO1hlbITpdcMafSouT/hAYDzBxPk8PfRNaJF
   eOi9WTeSE7ROXjY2kvTWNoTNh/Rz9ixxBLPZIn+CQ7x07pvOSWI02lB0/
   5D80aa5CFXussoy4ikDhmc6PSuC5vKzu1xoYF3JcM5xZKjdJH9F2ONe4l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349669742"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="349669742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652767522"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="652767522"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:32:56 -0700
Subject: [PATCH v2 0/4] acpi: Add CDAT parsing support to ACPI tables code
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 11:32:56 -0700
Message-ID: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
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

v2:
- Split out with CONFIG_ACPI_TABLES_LIB to be independent
- Fixed 0-day issues
- Change CDAT releveant names to prefix with cdat/CDAT instead of
  acpi/ACPI. (Jonathan)
- Make table_header a union with cdat table header instead of
  'acpi_table_header'. (Jonathan)
- Removed ACPI_SIG_CDAT, already defined.

Hi Rafael,
Please consider these for 6.5 merge window.

I've broken out the "cxl: Add support for QTG ID retrieval for CXL subsystem" [1]
series in order to make it more manageable. Here's the first part of the ACPI
changes. These changes are added to allow reuse of ACPI tables code to parse
the CDAT tables. While CDAT is not part of ACPI, the table structures are similar
to ACPI layouts that the code can be reused with some small modifications.

However, in order to be properly utilized by CXL users, the tables code needs
to be refactored out to be independent of ACPI. For example, a PPC BE host may
have CXL and does not have ACPI support. But it will have CDAT to read from
devices and switches. I have created CONFIG_ACPI_TABLES_LIB in order to allow
the common code to be independent. 0-day seems to be happy now for all the
different configs and archs.

1/4: Split out the common code from drivers/acpi/tables.c
2/4: Add CDAT support
3,4/4: These two are minor patches that has ACPICA impact. Has been merged into
       the ACPICA git repo [3].

The whole series is at [2] for convenience.

[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t                                                                                               
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
[3]: https://github.com/acpica/acpica/pull/874

---

Dave Jiang (4):
      acpi: Move common tables helper functions to common lib
      acpi: tables: Add CDAT table parsing support
      acpi: fix misnamed define for CDAT DSMAS
      acpi: Add defines for CDAT SSLBIS


 drivers/Makefile          |   2 +-
 drivers/acpi/Kconfig      |   4 +
 drivers/acpi/Makefile     |   3 +
 drivers/acpi/tables.c     | 178 +---------------------------
 drivers/acpi/tables_lib.c | 240 ++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl1.h     |   5 +-
 include/linux/acpi.h      |  81 +++++++++----
 7 files changed, 312 insertions(+), 201 deletions(-)
 create mode 100644 drivers/acpi/tables_lib.c

--

