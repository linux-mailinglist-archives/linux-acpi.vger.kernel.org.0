Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374AD62437A
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKJNpK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 08:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKJNpK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 08:45:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E263A64A23
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 05:45:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC2BF1FB;
        Thu, 10 Nov 2022 05:45:14 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0C9A3F703;
        Thu, 10 Nov 2022 05:45:07 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 0/2] ACPI: Implement FFH OpRegion support
Date:   Thu, 10 Nov 2022 13:45:03 +0000
Message-Id: <20221110134505.1375955-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This short series adds supports for ACPI Fixed Function Hardware(FFH) based
Opregion that is being added to ACPI v6.5

The ACPICA support for the same is now merged and imported into linux-next
via PM tree.

The first patch adds a generic FFH OpRegion handler. Since handling of
FFH OpRegion is very platform and the generic handlers just call the platform/
architecture specific callbacks for all the work.

The last/second patch adds the ARM64 specific callback which handles FFH
OpRegion using arch specific SMC/HVC instructions using SMCCC. The
specification can be found at [1].

[1] https://developer.arm.com/docs/den0048/latest

Sudeep Holla (2):
  ACPI: Implement a generic FFH Opregion handler
  arm64: Add architecture specific ACPI FFH Opregion callbacks

 arch/arm64/kernel/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/Kconfig     |  10 ++++
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/acpi_ffh.c  |  55 ++++++++++++++++++++
 drivers/acpi/bus.c       |   6 +++
 include/linux/acpi.h     |   7 +++
 6 files changed, 185 insertions(+)
 create mode 100644 drivers/acpi/acpi_ffh.c

-- 
2.38.1

