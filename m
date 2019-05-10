Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C119AE3
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEJJqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 05:46:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:4496 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfEJJqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 05:46:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 02:45:58 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2019 02:45:57 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id BE15B204CC;
        Fri, 10 May 2019 12:45:56 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP26N-0003k6-Nc; Fri, 10 May 2019 12:46:03 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 0/2] Fix ACPI object references
Date:   Fri, 10 May 2019 12:46:01 +0300
Message-Id: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This set adds one patch for converting spaces to tabs before fixing the
object references. Also rebased on the patch converting the text
documentation to ReST.

Sakari Ailus (2):
  Documentation: ACPI: Use tabs for indentation
  Documentation: ACPI: Direct references are allowed to devices only

 .../acpi/dsd/data-node-references.rst              |   6 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    | 120 ++++++++++-----------
 2 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.11.0

