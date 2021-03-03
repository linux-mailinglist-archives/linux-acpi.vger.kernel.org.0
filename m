Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75F32C438
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382856AbhCDALz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:7092 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344353AbhCCLCS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 06:02:18 -0500
IronPort-SDR: CGC6y+AKu2zphTak8ddJ+/GEuoRv2MIJw+38xI5x9Bebb5MtX52LmiPAlVdorp26pZDibKONX1
 D8s/0xsTn1Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187201719"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="187201719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:38:16 -0800
IronPort-SDR: QHKceo83s07dhZ95jjEQlocYrhYDj15IZiCOQn3itZ2bzOAjRyxrNhxNgr41BMFsCG31SPB5gl
 xnA1+EoqbM5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="367525470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2021 00:38:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A83DF4; Wed,  3 Mar 2021 10:38:08 +0200 (EET)
Date:   Wed, 3 Mar 2021 10:38:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux GPIO <linux-gpio@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] intel-gpio for 5.12-2
Message-ID: <YD9K8LzSFpuAhDvW@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linux GPIO and ACPI maintainers,

This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
PR is to both subsystems.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel.git tags/intel-gpio-v5.12-2

for you to fetch changes up to 437b57d2085950a813c028215513fe941ca2e616:

  gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2 (2021-03-03 09:49:47 +0200)

----------------------------------------------------------------
intel-gpio for v5.12-2

* Fix IRQ flags for ACPI event handler
* Redo Intel Galileo Gen 2 quirk due to revealed regression

The following is an automated git shortlog grouped by driver:

gpiolib:
 -  acpi: Allow to find GpioInt() resource by name and index
 -  acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
 -  acpi: Add missing IRQF_ONESHOT

pca953x:
 -  Set IRQ type when handle Intel Galileo Gen 2

----------------------------------------------------------------
Andy Shevchenko (3):
      gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
      gpiolib: acpi: Allow to find GpioInt() resource by name and index
      gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2

Yang Li (1):
      gpiolib: acpi: Add missing IRQF_ONESHOT

 drivers/gpio/gpio-pca953x.c   | 78 +++++++++++++------------------------------
 drivers/gpio/gpiolib-acpi.c   | 21 ++++++++----
 include/linux/acpi.h          | 10 ++++--
 include/linux/gpio/consumer.h |  2 ++
 4 files changed, 48 insertions(+), 63 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


