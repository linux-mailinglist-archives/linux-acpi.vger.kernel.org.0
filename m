Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E247309F8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jun 2023 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjFNVsC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jun 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFNVsB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2023 17:48:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0FF268A;
        Wed, 14 Jun 2023 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686779280; x=1718315280;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LQIF5inCfu28gaIYSQc4ijEDRuUeulTBce7NaMHlXvA=;
  b=jERJ+EWPyv54kUxPUMGMBZuZOlvo4R6tVlCkpip2Jbk/77RBvYbZXMCQ
   P6dEL31dlGMjN11ALYewG/f2Dq0cpq2/aQE7TS3NWBypGb3ztQO2XVfa+
   xQl/7urJi7fgkg9/RYA1whs8MKB6b8fB1+Yen3nfn+jacGLWsVeXmp3LG
   CuIs8x3Dx05rOve6EDhuf7uX+kG+CSwr06P/d4f+MbmTlZNc2j2xGNbQW
   6TnpG/stE+3BHvmWk2DZ+j/fjAKaZWgMN+xlwm5oZ26lQZWUuOlA5XDqi
   f/v3KVoHwQxCAv+S0A7jqOVLpZtX+mleOEgaCyljT/sP02Y8dtUJiEfdb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358741577"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358741577"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802091001"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="802091001"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.39])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 14:47:59 -0700
Subject: [PATCH v4 0/4] acpi: Add CDAT parsing support to ACPI tables code
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com, guohanjun@huawei.com
Date:   Wed, 14 Jun 2023 14:47:58 -0700
Message-ID: <168677921156.2787985.6927511816148622557.stgit@djiang5-mobl3>
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

v4:
- Add file entries in MAINTAINERS. (Hanjun)
- Fixed couple 0-day issues.
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

Hi Dan,
Rafael has ack'd the series. Please consider pulling them.

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


 MAINTAINERS              |   2 +
 drivers/acpi/Kconfig     |   1 +
 drivers/acpi/tables.c    | 178 +----------------------------
 include/acpi/actbl1.h    |   5 +-
 include/linux/acpi.h     |  42 ++-----
 include/linux/fw_table.h |  52 +++++++++
 lib/Kconfig              |   3 +
 lib/Makefile             |   2 +
 lib/fw_table.c           | 237 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 315 insertions(+), 207 deletions(-)
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c

--

