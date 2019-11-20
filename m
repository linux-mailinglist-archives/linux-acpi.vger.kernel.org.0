Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2920810443E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 20:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKTTZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 14:25:51 -0500
Received: from goliath.siemens.de ([192.35.17.28]:43211 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTZu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2019 14:25:50 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 14:25:50 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id xAKJKFXC030983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 20:20:15 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xAKJKFQd024611;
        Wed, 20 Nov 2019 20:20:15 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 0/2] gpio: sch: Interrupt support
Date:   Wed, 20 Nov 2019 20:20:12 +0100
Message-Id: <cover.1574277614.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes in v3:
 - split-up of the irq enabling patch as requested by Andy

Jan

Jan Kiszka (2):
  gpio: sch: Add edge event support
  gpio: sch: Hook into ACPI SCI handler to catch GPIO edge events

 drivers/gpio/gpio-sch.c | 144 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 137 insertions(+), 7 deletions(-)

-- 
2.16.4

