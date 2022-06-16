Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434854DDBE
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jun 2022 11:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiFPJBV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jun 2022 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFPJBT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2022 05:01:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 780E92D1E0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 02:01:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E3712FC;
        Thu, 16 Jun 2022 02:01:18 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B9D03F7F5;
        Thu, 16 Jun 2022 02:01:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/3] ACPI: Implement FFH OpRegion support
Date:   Thu, 16 Jun 2022 10:01:03 +0100
Message-Id: <20220616090106.2154906-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This short series adds supports for ACPI Fixed Function Hardware(FFH) based
Opregion that is being added(via Code First approach[1]) to ACPI v6.5

The first patch added ACPICA support for the same and must be routed via
ACPICA project into the kernel and is part of the series just for the
reference. The pull request is already sent there[2].

The second patch added a generic FFH OpRegion handler. Since handling of
FFH OpRegion is very platform and the generic handlers just call the platform/
architecture specific callbacks for all the work.

The last patch added the ARM64 specific callback which handles FFH
OpRegion using arch specific SMC/HVC instructions using SMCCC. The
specification can be found at [3].

[1] https://bugzilla.tianocore.org/show_bug.cgi?id=3598
[2] https://github.com/acpica/acpica/pull/782
[3] https://developer.arm.com/docs/den0048/latest

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>

Sudeep Holla (3):
  ACPICA: Add support for FFH Opregion special context data
  ACPI: Implement a generic FFH Opregion handler
  arm64: Add architecture specific ACPI FFH Opregion callbacks

 arch/arm64/kernel/acpi.c       | 104 +++++++++++++++++++++++++++++++++
 drivers/acpi/Kconfig           |  10 ++++
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/acpi_ffh.c        |  55 +++++++++++++++++
 drivers/acpi/acpica/evregion.c |   8 +++
 drivers/acpi/acpica/exfield.c  |   8 ++-
 drivers/acpi/acpica/exserial.c |   6 ++
 drivers/acpi/bus.c             |   6 ++
 include/acpi/acconfig.h        |   2 +
 include/acpi/actypes.h         |   7 +++
 include/linux/acpi.h           |   7 +++
 11 files changed, 212 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/acpi_ffh.c

--
2.36.1

