Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894FF440390
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ2Tx5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:53:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:30759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhJ2Tx4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:53:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="229466454"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="229466454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:27 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="499040588"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:27 -0700
Subject: [PATCH 0/6] Introduce acpi_table_parse_cedt and extra nodes for
 CXL.mem
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:27 -0700
Message-ID: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

While reviewing "[PATCH v3] ACPI: NUMA: Add a node and memblk for each
CFMWS not in SRAT" [1]. I noticed that it was open coding CEDT sub-table
parsing in a similar fashion as drivers/cxl/acpi.c. The driver open
coded the parsing because the ACPI sub-table helpers are marked __init.
In order to avoid the ongoing maintenance burden of a split between
"early" and "late" ACPI sub-table parsing this series proposes to make
those helpers available to drivers.

The savings in drivers/cxl/ are:

 drivers/cxl/Kconfig |    1 
 drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
 2 files changed, 88 insertions(+), 147 deletions(-)

...and 15 lines new code not added are saved in this new version of
"ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT".

Let me know if this looks ok to you and I can carry it in the CXL tree
(i.e. after the merge window, for v5.17 consideration).

[1]: https://lore.kernel.org/r/20211019050908.449231-1-alison.schofield@intel.com

---

Alison Schofield (1):
      ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT

Dan Williams (5):
      ACPI: Keep sub-table parsing infrastructure available for modules
      ACPI: Teach ACPI table parsing about the CEDT header format
      ACPI: Add a context argument for table parsing handlers
      cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers
      cxl/test: Mock acpi_table_parse_cedt()


 drivers/acpi/Kconfig          |    3 +
 drivers/acpi/numa/srat.c      |   59 ++++++++++
 drivers/acpi/tables.c         |   87 +++++++++++----
 drivers/cxl/Kconfig           |    1 
 drivers/cxl/acpi.c            |  237 ++++++++++++++++-------------------------
 include/linux/acpi.h          |   34 +++++-
 tools/testing/cxl/Kbuild      |    3 -
 tools/testing/cxl/test/cxl.c  |   68 ++++++++----
 tools/testing/cxl/test/mock.c |   30 ++---
 tools/testing/cxl/test/mock.h |    6 +
 10 files changed, 304 insertions(+), 224 deletions(-)

base-commit: c6d7e1341cc99ba49df1384c8c5b3f534a5463b1
