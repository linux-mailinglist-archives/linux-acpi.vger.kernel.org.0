Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001333AA878
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 03:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFQBRg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 21:17:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:17038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhFQBRg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 21:17:36 -0400
IronPort-SDR: mJcOMfNc4yPuwiGRkpFMo1R3s9H1joekP1LwIGiCO1JcwM/1phkWVbSTqfOadh9feVEqqaSVn4
 43AG+zh7eJ3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="270133091"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="270133091"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 18:15:28 -0700
IronPort-SDR: kbrcli0LowqoWjtkAQYjUv1qFnMojcYJQbL3JG/9EAeU8PKI+l+U/xGjzrmy3ztqYrEWF3Lz3v
 MAKo0uA9foeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="485094075"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2021 18:15:28 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/2] CXL ACPI tables for object creation
Date:   Wed, 16 Jun 2021 18:11:06 -0700
Message-Id: <cover.1623890468.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan - I updated Patch 2 so I didn't keep your Reviewed-by tag.

Changes since v2 [1]:
- Warn and continue, rather than error out, on these acpi table parsing issues:
  table length mismatch for either CHBS or CFMWS; duplicate uid's for CHBS.
  (Ben, Jonathan)
- Update flow in cxl_acpi_match_chbs()  (Ben, Jonathan)
- Improve naming cedt_table->acpi_cedt, cedt_base->cedt_subtable (Ben)
- Emit debug message only if CFMWS is greater than its expected length (Ben)
- Update the dev_err messages wrt the CFMWS expected length failure.
- Remove blank line before error handling block (Jonathan)
- Rebase to the CXL pending branch [2]

[1]: https://lore.kernel.org/linux-cxl/cover.1623800340.git.alison.schofield@intel.com/ 
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=pending

--
Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
when creating port and decoder objects.

CHBS: CXL Host Bridge Structure - Patch 1
CFMWS: CXL Fixed Memory Window Structure - Patch 2

Alison Schofield (2):
  cxl/acpi: Add the Host Bridge base address to CXL port objects
  cxl/acpi: Use the ACPI CFMWS to create static decoder objects

 drivers/cxl/acpi.c | 217 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 5 deletions(-)


base-commit: 21083f51521fb0f60dbac591f175c3ed48435af4
-- 
2.26.2
