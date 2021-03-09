Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AC332219
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCIJiA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 04:38:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:29451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhCIJhl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Mar 2021 04:37:41 -0500
IronPort-SDR: hiehay2Od8+CHc8TFIjZKaxXAoW2uZtBFKUoxmQ6iE/j7D719j/6UyG1V8TH28fi2Ug2nSP9oz
 vZF7M9GfOmtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175303411"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="175303411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 01:37:40 -0800
IronPort-SDR: nr63oc0PNfB2pHc+gU4StUQ9vGCvf6MqbqzJEXz9VUaBkogbsDsWrt4vbIxG0cqJoTjAQuegqi
 1WVhRNJ+whCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="369725423"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2021 01:37:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B0C11EC; Tue,  9 Mar 2021 11:37:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 0/6] gpiolib: switch to fwnode in the core
Date:   Tue,  9 Mar 2021 11:37:30 +0200
Message-Id: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

GPIO library uses of_node and fwnode in the core in non-unified way.
The series cleans this up and improves IRQ domain creation for non-OF cases
where currently the names of the domain are 'unknown'.

This has been tested on Intel Galileo Gen 2.

It touches GPIO core parts and it's expected that the series is routed via
GPIO tree.

In v6:
- added tag to the patch 5 (Rafael)
- dropped ops temporary variable (Rafael)

In v5:
- same as v4 + v3 (patches 1-4/5) in order to route via GPIO tree (Bart)

In v4:
- based on Rafael's bleeding-edge
- split the rest to two patches (Rafael)
- elaborate WARN() deduplication in the commit message (Rafael)

In v3:
- fixed subtle bug in gpiod_count
- made irq_domain_add_simple() static inline (Marc)

In v2:
- added a new patch due to functionality in irq_comain_add_simple() (Linus)
- tagged patches 2-4 (Linus)
- Cc'ed to Rafael

Andy Shevchenko (6):
  irqdomain: Introduce irq_domain_create_simple() API
  gpiolib: Unify the checks on fwnode type
  gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
  gpiolib: Introduce acpi_gpio_dev_init() and call it from core
  gpiolib: Reuse device's fwnode to create IRQ domain
  gpiolib: Fold conditionals into a simple ternary operator

 Documentation/core-api/irq/irq-domain.rst | 22 ++++----
 drivers/gpio/gpiolib-acpi.c               |  7 +++
 drivers/gpio/gpiolib-acpi.h               |  4 ++
 drivers/gpio/gpiolib-of.c                 |  6 ++-
 drivers/gpio/gpiolib.c                    | 62 +++++++++--------------
 include/linux/irqdomain.h                 | 19 +++++--
 kernel/irq/irqdomain.c                    | 20 ++++----
 7 files changed, 75 insertions(+), 65 deletions(-)

-- 
2.30.1

