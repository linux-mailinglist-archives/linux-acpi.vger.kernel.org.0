Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDB42C37D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJMOjN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 10:39:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:58928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236309AbhJMOjM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Oct 2021 10:39:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="214592952"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214592952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 07:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="592198916"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2021 07:37:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9828E361; Wed, 13 Oct 2021 17:37:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] device property: Add missed header in fwnode.h
Date:   Wed, 13 Oct 2021 17:37:07 +0300
Message-Id: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When adding some stuff to the header file we must not rely on
implicit dependencies that are happen by luck or bugs in other
headers. Hence fwnode.h needs to use bits.h directly.

Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9f4ad719bfe3..3a532ba66f6c 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/bits.h>
 #include <linux/err.h>
 
 struct fwnode_operations;
-- 
2.33.0

