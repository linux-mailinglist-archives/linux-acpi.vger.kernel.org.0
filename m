Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA43ABF41
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 01:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhFQXSv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 19:18:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:30113 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhFQXSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 19:18:50 -0400
IronPort-SDR: 3kTsVHdeA3jxhL0JrW23uB9N7SogYdr6J8xOg7YOY+DREup/u5+VRHbPMN+DHsy1V46dvD2jzm
 +sIWgRF7YvFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292096152"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292096152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:16:39 -0700
IronPort-SDR: TrG28jaXHtnIKrBIWriMxTIhHNDumT+QcImzXGt9wlC+Wpxm2Neqpn/vEANFWtuCG72lyCjw6O
 F3y2hUj8OMPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452938649"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2021 16:16:38 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v5 0/2] CXL ACPI tables for object creation
Date:   Thu, 17 Jun 2021 16:12:14 -0700
Message-Id: <cover.1623968958.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Changes since v4 [1]:
- Replace dev_WARN_ONCE()'s with dev_warn_once() (Dan)

[1] https://lore.kernel.org/linux-cxl/cover.1623950781.git.alison.schofield@intel.com/

--
Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
when creating port and decoder objects.

CHBS: CXL Host Bridge Structure - Patch 1
CFMWS: CXL Fixed Memory Window Structure - Patch 2

Alison Schofield (2):
  cxl/acpi: Add the Host Bridge base address to CXL port objects
  cxl/acpi: Use the ACPI CFMWS to create static decoder objects

 drivers/cxl/acpi.c | 222 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 5 deletions(-)


base-commit: 21083f51521fb0f60dbac591f175c3ed48435af4
-- 
2.26.2

