Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF3426CFF
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbhJHOvd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 10:51:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47437 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242817AbhJHOv0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 10:51:26 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 8 Oct 2021 17:49:26 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 198EnQ3W017353;
        Fri, 8 Oct 2021 10:49:26 -0400
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 198EnNlr011023;
        Fri, 8 Oct 2021 10:49:23 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>, andrew@lunn.ch, kuba@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        davem@davemloft.net, rjw@rjwysocki.net, davthompson@nvidia.com
Subject: [PATCH v4 0/2] gpio: mlxbf2: Introduce proper interrupt handling
Date:   Fri,  8 Oct 2021 10:49:18 -0400
Message-Id: <20211008144920.10975-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a follow up on a discussion regarding
proper handling of GPIO interrupts within the
gpio-mlxbf2.c driver.

Link to discussion:
https://lore.kernel.org/netdev/20210816115953.72533-7-andriy.shevchenko@linux.intel.com/T/

Patch 1 adds support to a GPIO IRQ handler in gpio-mlxbf2.c.
Patch 2 is a follow up removal of custom GPIO IRQ handling
from the mlxbf_gige driver and replacing it with a simple
IRQ request. The ACPI table for the mlxbf_gige driver is
responsible for instantiating the PHY GPIO interrupt via
GpioInt.

Andy Shevchenko, could you please review this patch series.

v4 vs. v3 patch:
- Remove IRQ_TYPE_LEVEL* from mlxbf2_gpio_irq_set_type
  since LEVEL interrupts are not supported by internal
  BlueField GPIO HW.

Asmaa Mnebhi (2):
  gpio: mlxbf2: Introduce IRQ support
  net: mellanox: mlxbf_gige: Replace non-standard interrupt handling

 drivers/gpio/gpio-mlxbf2.c                    | 147 +++++++++++-
 .../net/ethernet/mellanox/mlxbf_gige/Makefile |   1 -
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige.h |  12 -
 .../mellanox/mlxbf_gige/mlxbf_gige_gpio.c     | 212 ------------------
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     |  22 +-
 5 files changed, 154 insertions(+), 240 deletions(-)
 delete mode 100644 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c

-- 
2.30.1

