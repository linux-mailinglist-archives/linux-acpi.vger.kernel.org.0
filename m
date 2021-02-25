Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708BA325396
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBYQfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 11:35:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:15707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBYQfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 11:35:25 -0500
IronPort-SDR: 5zZprOLL8FNecS1zquve5t9wNLj3onEzYV0+Ih49Rad9JsNEj1VZOLgs7S5B5rFAUnDeeth6Ht
 vQ3A0nWXjRDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="184880950"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="184880950"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 08:33:37 -0800
IronPort-SDR: rWMGcMXbtewIeX9E5koaAOJeIlnkNv4lmTPCvdgaPffxuQXV3YO/PRWA+gsC3BbceZ3Lv2xK2k
 i/yzKAIRjyfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="594150866"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2021 08:33:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3A9C11F; Thu, 25 Feb 2021 18:33:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/3] gpio: pca953x: Better quirk for Intel Galileo Gen 2
Date:   Thu, 25 Feb 2021 18:33:17 +0200
Message-Id: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It appears that after commit to the gpio-dwapb driver the quirk for Intel
Galileo Gen 2 stopped working. I tried a few approaches but none of them
worked besides the fact that they copy like a ~10% of the gpiolib-acpi
functionality.

Instead I decided to come back to a mix of v1 [1] of the initial series
(the v3 has been applied) and Mika's suggestion about using gpio_to_desc()
API.

Unfortunately it requires to have a quirk in the core, but in comparison
to v1 it much less intrusive and doesn't use any predefined numbers.

I would like to create an immutable branch and send TWIMC (GPIO and ACPI
subsystems I guess). This is material for v5.12-rcX.

[1]: https://lore.kernel.org/linux-gpio/20200520211916.25727-1-andriy.shevchenko@linux.intel.com/

Andy Shevchenko (3):
  gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
  gpiolib: acpi: Allow to find GpioInt() resource by name and index
  gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2

 drivers/gpio/gpio-pca953x.c   | 78 +++++++++++------------------------
 drivers/gpio/gpiolib-acpi.c   | 19 ++++++---
 include/linux/acpi.h          | 10 ++++-
 include/linux/gpio/consumer.h |  2 +
 4 files changed, 47 insertions(+), 62 deletions(-)

-- 
2.30.0

