Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165C82A0BFA
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJ3Q77 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:59:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:54480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: joe+/qAag6vQ7Nn+D7Zk7oEXjxbdsi0XE2ER3Ugc6cLVqQmmilaSV0n7oAD6CnqAggYwsl3viC
 UqWBFqh4qOKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230271386"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="230271386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:23 -0700
IronPort-SDR: 29LgB243tCKX0jFUo7aH/0GANad3+YOiJzCXs44sBOzkj9QW05F0MkMQnsXKfO4AwLPzvn8SEm
 mopvz51qcBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="304814928"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2020 09:59:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADB845F2; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] irqdomain: Add forward declaration of fwnode_handle
Date:   Fri, 30 Oct 2020 18:59:16 +0200
Message-Id: <20201030165919.86234-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

irqdomain.h is a user of struct fwnode_handle. Add forward declaration of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 56642188ec21..d21f75d294d7 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -37,6 +37,7 @@
 #include <linux/radix-tree.h>
 
 struct device_node;
+struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
-- 
2.28.0

