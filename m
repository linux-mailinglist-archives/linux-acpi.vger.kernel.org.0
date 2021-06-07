Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4739E000
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGPNm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 11:13:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:63736 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhFGPNm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Jun 2021 11:13:42 -0400
IronPort-SDR: uMy17Eh0fopsb346D8+pW+frfGALShcXAoBGxQKh2s6sYAXBNrKLkh9gV3l9jhj3mkYjbm8jNj
 TF8aHGM0wK8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202779581"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="202779581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:11:49 -0700
IronPort-SDR: Y+RITeYsFEf7KoldDvil/YWXAWmTpD2zYXUyN7wOO0g4gJnFltxSL5XOPkKuY9uAjCHyyZbDQO
 R5iJYFZ9Uw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="440081873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2021 08:11:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 524F3C5; Mon,  7 Jun 2021 18:12:10 +0300 (EEST)
Date:   Mon, 7 Jun 2021 18:12:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux GPIO <linux-gpio@vger.kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] intel-gpio for 5.14-1
Message-ID: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linux GPIO and TWIMC maintainers,

This is GPIO material for v5.14 cycle. It contains some stuff that other
subsystems may take due to dependencies. Consider this tag immutable.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel.git tags/intel-gpio-v5.14-1

for you to fetch changes up to 043d7f09bf614809c10c4acbf0695ef731958300:

  gpiolib: acpi: Add acpi_gpio_get_io_resource() (2021-06-04 16:24:19 +0300)

----------------------------------------------------------------
intel-gpio for v5.14-1

* Export two functions from GPIO ACPI for wider use
* Clean up Whiskey Cove and Crystal Cove GPIO drivers

The following is an automated git shortlog grouped by driver:

crystalcove:
 -  remove platform_set_drvdata() + cleanup probe

gpiolib:
 -  acpi: Add acpi_gpio_get_io_resource()
 -  acpi: Introduce acpi_get_and_request_gpiod() helper

wcove:
 -  Split error handling for CTRL and IRQ registers
 -  Unify style of to_reg() with to_ireg()
 -  Use IRQ hardware number getter instead of direct access

----------------------------------------------------------------
Alexandru Ardelean (1):
      gpio: crystalcove: remove platform_set_drvdata() + cleanup probe

Andy Shevchenko (3):
      gpio: wcove: Use IRQ hardware number getter instead of direct access
      gpio: wcove: Unify style of to_reg() with to_ireg()
      gpio: wcove: Split error handling for CTRL and IRQ registers

Daniel Scally (2):
      gpiolib: acpi: Introduce acpi_get_and_request_gpiod() helper
      gpiolib: acpi: Add acpi_gpio_get_io_resource()

 drivers/gpio/gpio-crystalcove.c | 10 +-------
 drivers/gpio/gpio-wcove.c       | 39 +++++++++++++++----------------
 drivers/gpio/gpiolib-acpi.c     | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h            |  7 ++++++
 include/linux/gpio/consumer.h   |  2 ++
 5 files changed, 80 insertions(+), 29 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


