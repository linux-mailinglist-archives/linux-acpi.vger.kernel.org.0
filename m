Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740D03A8D6F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFPA06 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 20:26:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:22073 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFPA06 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Jun 2021 20:26:58 -0400
IronPort-SDR: LhXGibnrl02eqN0kjbJzcQDeWdRgYQ6F7E2iuzIIYO9zwahUdcTy7z7Q58xguzvsJdq/V10CLm
 GWrivTrctyLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="227577360"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="227577360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:24:53 -0700
IronPort-SDR: dqqL+la4M1ZDgwWgSJoeLRw667wGToK2w/Z8dX4qL0mmXmBZixRDgef+PxDO5zyDxvUyvEXXPn
 ZdyQXGQ3/82Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="484671486"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2021 17:24:52 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 0/2] CXL ACPI tables for object creation
Date:   Tue, 15 Jun 2021 17:20:37 -0700
Message-Id: <cover.1623800340.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Changes since v1 [1]:
- open code the cfmws restrictions to decode flags work (Dan)
- add range info on error messages when adding a decoder fails (Dan)
- make find_dport_by_dev() static (Dan)
- add linux-acpi to cc list (Dan)

[1] https://lore.kernel.org/linux-cxl/cover.1623705308.git.alison.schofield@intel.com/


Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
when creating port and decoder objects.

CHBS: CXL Host Bridge Structure - Patch 1
CFMWS: CXL Fixed Memory Window Structure - Patch 2

Alison Schofield (2):
  cxl/acpi: Add the Host Bridge base address to CXL port objects
  cxl/acpi: Use the ACPI CFMWS to create static decoder objects

 drivers/cxl/acpi.c | 219 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 6 deletions(-)


base-commit: 195d5a63f0f9a47aa128a5050fe4ad7f5d27a901
-- 
2.26.2

