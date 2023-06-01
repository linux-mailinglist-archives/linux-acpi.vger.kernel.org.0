Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E571F4B9
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjFAVbt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFAVbs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 17:31:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2191184;
        Thu,  1 Jun 2023 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655107; x=1717191107;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KI6JDuT8wxF1HgAlteNxzcKARumuL/cX87STidw8uyg=;
  b=Dhdft37DsDprcLVxWb6lvm6nhQ68/7Yafr/cCDGFt5hEMHVTgeAIRi01
   IWEkNVTcvwZp7QjP6rYXgDvMCunF0Bs03wyW+HuKCAT1Db8EAUIt2rSCe
   NsQtn7b4J3kTBu1xPhYgm+rmjXIbZ9wk4Dd2BzMFBEpb8co1N3PJyKUv5
   YylGrQTgIYQ+H81SqNnG7m2d4vMDEjxBSMYkt+vE0CIXmS6lo9baxUifK
   5qEOAMtmxT5M2zbG637lTGISOyn5R9yBEtMb8a+zwZMCJEIAofcznDt3T
   byEmAtrBbMMEomi9FnpcVCinj07H7En6L3lQzuLaXoFzbnwkJqoK+/8lW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421507361"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421507361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685016401"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="685016401"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.26.132])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:31:46 -0700
Subject: [PATCH v3 0/4] acpi: Add CDAT parsing support to ACPI tables code
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 01 Jun 2023 14:31:45 -0700
Message-ID: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v3:
- Move common code to lib/fw_table.c
v2:
- Split out with CONFIG_ACPI_TABLES_LIB to be independent
- Fixed 0-day issues
- Change CDAT releveant names to prefix with cdat/CDAT instead of
  acpi/ACPI. (Jonathan)
- Make table_header a union with cdat table header instead of
  'acpi_table_header'. (Jonathan)
- Removed ACPI_SIG_CDAT, already defined.

Hi Rafael,
Please consider ack these patches. Dan can take these through the CXL tree. After
attempting to rename the cxl_ prefixes of functions and non ACPICA data structures
to something more common, it seems that significant amount of ACPI code would be
touched for the rename. For this series I left it alone in order to have the minimal
changes to ACPI code.

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

1/4: Split out the common code from drivers/acpi/tables.c to lib/fw_table.c
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
      lib/firmware_table: tables: Add CDAT table parsing support
      acpi: fix misnamed define for CDAT DSMAS
      acpi: Add defines for CDAT SSLBIS


 drivers/acpi/Kconfig     |   1 +
 drivers/acpi/tables.c    | 178 +----------------------------
 include/acpi/actbl1.h    |   5 +-
 include/linux/acpi.h     |  22 +---
 include/linux/fw_table.h |  52 +++++++++
 lib/Kconfig              |   3 +
 lib/Makefile             |   2 +
 lib/fw_table.c           | 236 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 302 insertions(+), 197 deletions(-)
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c

--

