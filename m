Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686172A0BF4
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgJ3Q77 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:59:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:47265 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: sSwRuL+FhCfiTtmWMrPYckR4TSM6SdJd24MfQr/EyVND8Z62uAm/9OSXwLpL8J3717zNZ8iNHE
 p5aFoKA8ALWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="148490946"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="148490946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:23 -0700
IronPort-SDR: 9G60NOm2eScybbNRylgFHMmG8M8ESDTATlZl8W62qYYDocRkw4Z9xG0bEAW2mGnfmbS0iL0V/w
 5GSUpfAEWQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537126454"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2020 09:59:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E781567; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] irqdomain: clean up, add irq_domain_create_legacy()
Date:   Fri, 30 Oct 2020 18:59:14 +0200
Message-Id: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In order to make users OF-independent provide irq_domain_create_legacy() API.

Last patch is an example of such user. First three patches are little cleanups.

Rafael, can you have a look at this series?

Changelog v2:
- rebased on top of v5.10-rc1
- dependency-free (they are in v5.10-rc1)
- added Ack (Mark)

Andy Shevchenko (5):
  irqdomain: Remove unused of_device_id forward declaration
  irqdomain: Add forward declaration of fwnode_handle
  irqdomain: Replace open coded of_node_to_fwnode()
  irqdomain: Introduce irq_domain_create_legacy() API
  regmap: irq: Convert to use fwnode directly

 Documentation/core-api/irq/irq-domain.rst |  6 ++++++
 drivers/base/regmap/regmap-irq.c          | 11 +++++------
 include/linux/irqdomain.h                 |  8 +++++++-
 kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
 4 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.28.0

