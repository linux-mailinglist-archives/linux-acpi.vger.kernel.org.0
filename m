Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C648D32D5DE
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhCDPEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:04:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:45930 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhCDPEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:04:16 -0500
IronPort-SDR: Zo4zdZXTnekuS2g1zk5giu5yinYDaFLKZbzBgSzH0tcfNWk7wCl43tVcomEMtwaHpVnMTV555h
 SxsahD5b3whg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272434293"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="272434293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:02:28 -0800
IronPort-SDR: c7E+e/77C6cbOs08NKsRoyDeWLORjfhidlqk5LwX29INUmE0+c1g02/l9lxno+hA3PjNdeKnUQ
 MYXbozP4eBJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="445758443"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2021 07:02:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B1A329E; Thu,  4 Mar 2021 17:02:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/5] gpiolib: switch to fwnode in the core
Date:   Thu,  4 Mar 2021 17:02:10 +0200
Message-Id: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
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

In v2:
- added a new patch due to functionality in irq_comain_add_simple() (Linus)
- tagged patches 2-4 (Linus)
- Cc'ed to Rafael

Andy Shevchenko (5):
  irqdomain: Introduce irq_domain_create_simple() API
  gpiolib: Unify the checks on fwnode type
  gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
  gpiolib: Introduce acpi_gpio_dev_init() and call it from core
  gpiolib: Reuse device's fwnode to create IRQ domain

 Documentation/core-api/irq/irq-domain.rst | 22 ++++----
 drivers/gpio/gpiolib-acpi.c               |  7 +++
 drivers/gpio/gpiolib-acpi.h               |  4 ++
 drivers/gpio/gpiolib-of.c                 |  6 ++-
 drivers/gpio/gpiolib.c                    | 66 +++++++++--------------
 include/linux/irqdomain.h                 |  5 ++
 kernel/irq/irqdomain.c                    | 16 ++++--
 7 files changed, 71 insertions(+), 55 deletions(-)

-- 
2.30.1

