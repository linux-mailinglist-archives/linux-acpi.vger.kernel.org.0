Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245BE1CEC8D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 07:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgELFwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgELFwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 01:52:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E1B20769;
        Tue, 12 May 2020 05:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589262723;
        bh=/s72hXBEtVh97CNJT+5n4ZXc/V+UPmHBVHcaDXRUQC4=;
        h=From:To:Cc:Subject:Date:From;
        b=h99wYss8+ssH8BEU/yFXk08Ocs2YOryD3QSkzplXc5ML5lroF50c3Pu4+hqOKiwPt
         Yxo7UDScseg8/36+cLIb/FG+rKwd9p1e4xlxS2HnKNP4+RObsoq6+VghTt31LbuWyC
         MctcVj8u0jvqKb2jqhpp907QrDEoKfP937FAi9rc=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jYNpg-001Yqp-K4; Tue, 12 May 2020 07:52:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] Solve a few issues with intel_pmic_chtdc_ti.c 
Date:   Tue, 12 May 2020 07:51:55 +0200
Message-Id: <cover.1589262490.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While doing some tests with a device that I'm using to work with the
atomisp driver (an Asus T101HA), I noticed some warnings  produced
by the i915 driver.

The first one is that building intel_pmic_chtdc_ti as a module is too
late, as fbcon driver (and i915) will need it earlier.

The second one is that the thermal I2C OpRegion needed by the i915
is not registered.

Those patches address the issues I detected.

Mauro Carvalho Chehab (2):
  ACPI / PMIC: Add i2c address for thermal control
  mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool

 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
 drivers/mfd/Kconfig                     | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.26.2


