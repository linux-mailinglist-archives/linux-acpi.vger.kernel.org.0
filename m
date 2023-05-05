Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD06F87A3
	for <lists+linux-acpi@lfdr.de>; Fri,  5 May 2023 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjEERdH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 13:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjEERdG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 13:33:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEA1A1F1;
        Fri,  5 May 2023 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683307971; x=1714843971;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UG3IantLb/8SeHBFjZJxWPLt2fu+CV/jcov7kLjZ/n4=;
  b=RQI5kEhLYlY6IekotqrwRjfy0+RGRofGXa/LxfMh/FuK2OVv3L4ykF5d
   dluwfwPKU64cR+6nBYty6df47FRkjI4c0Z0tPeKFjZ+AnLcyMMSbQjHqp
   ksnXIRSPFa7DsEyO2B4FIcR36yFb1unjddC+1ixwyfz+Zm6fj0d+HQf84
   ZMqDTA+YI40Rf0gzLm5ubPCZTyNb28J59EMgGDarQ+yC+g3Yf2gf63/kj
   sgZUeOG2TIRy03DLoR8QE97qm1t4m30RQ+VEorCqvxSbkgziWLXwL2buD
   NX9pnO0taRdZkU0IrQTzZRQBvGE8QrOg+EjUv4QilOMEPrfkVel4PpP2S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349301174"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349301174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700531195"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700531195"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:32:51 -0700
Subject: [PATCH 0/4] acpi: Add CDAT parsing support to ACPI tables code
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 10:32:50 -0700
Message-ID: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
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

Hi Rafael,
I've broken out the "cxl: Add support for QTG ID retrieval for CXL subsystem" [1]
series in order to make it more manageable. Here's the first part of the ACPI
changes. These changes are added to allow reuse of ACPI tables code to parse
the CDAT tables. While CDAT is not part of ACPI, the table structures are similar
to ACPI layouts that the code can be reused with some small modifications.

However, in order to be properly utilized by CXL users, the tables code needs
to be refactored out to be independent of ACPI. For example, a PPC BE host may
have CXL and does not have ACPI support. But it will have CDAT to read from
devices and switches. patch 4/4 included is not APCI, but I have included it as
a reference to this problem. Currently as you can see, I have the cdat code in
CXL as "cxl_core-$(CONFIG_ACPI) += cdat.o". That will not work for a scenario
with the PPC host mentioned above since it won't compile in ACPI support. I'm
looking for guidance and to start the discussion on how we want the table handling
code to be broken out to be independent of CONFIG_ACPI. Thank you!

The whole series is at [2] for convenience.

[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t                                                                                               
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

---

Dave Jiang (4):
      acpi: tables: Add CDAT table parsing support
      acpi: Add header struct in CDAT subtables
      acpi: fix misnamed define for CDAT DSMAS
      cxl: Add callback to parse the DSMAS subtables from CDAT


 drivers/acpi/tables.c     | 47 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/cdat.c   | 40 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         | 18 +++++++++++++++
 drivers/cxl/port.c        | 22 ++++++++++++++++++
 include/acpi/actbl1.h     | 11 ++++++++-
 include/linux/acpi.h      |  4 ++++
 7 files changed, 140 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cxl/core/cdat.c

--

