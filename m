Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E33ABBC4
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhFQS3B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 14:29:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:59217 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhFQS2o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 14:28:44 -0400
IronPort-SDR: qtM571ZOqwwCHH7nLx2U734tkQbSAFkF/NECb2v2QAWBUq4WrA4F/WSa2rPYDev96W3LCsBo5J
 K6ikk2AX4JQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="227947786"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="227947786"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 11:25:58 -0700
IronPort-SDR: XqMueJ2pzXcsO73STbWPvBO3YD0SjyKkh5cmX7L8RNUIFGio0TwDXtbDuPXjZxIihJwwiABjC5
 yZu1vzTaUrDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421956685"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2021 11:25:58 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 0/2] CXL ACPI tables for object creation
Date:   Thu, 17 Jun 2021 11:21:36 -0700
Message-Id: <cover.1623950781.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes since v3 [1]:
- Align func params to open parens (Checkpatch, Ben)
- Added Ben & Jonathan Reviewed-by tags

[1] https://lore.kernel.org/linux-cxl/cover.1623890468.git.alison.schofield@intel.com/

--
Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
when creating port and decoder objects.

CHBS: CXL Host Bridge Structure - Patch 1
CFMWS: CXL Fixed Memory Window Structure - Patch 2


Alison Schofield (2):
  cxl/acpi: Add the Host Bridge base address to CXL port objects
  cxl/acpi: Use the ACPI CFMWS to create static decoder objects

 drivers/cxl/acpi.c | 219 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 214 insertions(+), 5 deletions(-)


base-commit: 21083f51521fb0f60dbac591f175c3ed48435af4
-- 
2.26.2

