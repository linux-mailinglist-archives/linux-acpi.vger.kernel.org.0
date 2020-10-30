Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF452A0BF5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJ3RAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:00:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:47265 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: WeBQan7gvinR4B1oRYgl+tWlht+RmMuzCNQBd7d4Pu62wUJqne5vecRJRDzQDXIaIjwVz1j/8j
 VImFaCqI5EMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="148490949"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="148490949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:23 -0700
IronPort-SDR: Mt8T6SlCqGZXvVHCijMrKN/JsrduqCTTegxIp/PLEH9pXxrdvv49gx2fd+iDuz+1vkjug4cBYV
 e5tt7ZQgfb0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537126455"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2020 09:59:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A6BCD4E1; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] irqdomain: Remove unused of_device_id forward declaration
Date:   Fri, 30 Oct 2020 18:59:15 +0200
Message-Id: <20201030165919.86234-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no users of of_device_id in irqdomain.h. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/irqdomain.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e87109f..56642188ec21 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -38,7 +38,6 @@
 
 struct device_node;
 struct irq_domain;
-struct of_device_id;
 struct irq_chip;
 struct irq_data;
 struct cpumask;
-- 
2.28.0

