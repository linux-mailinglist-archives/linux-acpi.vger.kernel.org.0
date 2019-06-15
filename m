Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0BC46D5C
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jun 2019 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfFOBK4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 21:10:56 -0400
Received: from foss.arm.com ([217.140.110.172]:45064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFOBK4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 21:10:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2082B;
        Fri, 14 Jun 2019 18:10:55 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 861A23F718;
        Fri, 14 Jun 2019 18:10:55 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 0/4] arm64: SPE ACPI enablement
Date:   Fri, 14 Jun 2019 20:09:06 -0500
Message-Id: <20190615010910.33921-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series enables the Arm Statistical Profiling
Extension (SPE) on ACPI platforms.

This is possible because ACPI 6.3 uses a previously
reserved field in the MADT to store the SPE interrupt
number, similarly to how the normal PMU is described.
If a consistent valid interrupt exists across all the
cores in the system, a platform device is registered.
That then triggers the SPE module, which runs as normal.

We also add the ability to parse the PPTT for IDENTICAL
cores. We then use this to sanity check the single SPE
device we create. This creates a bit of a problem with
respect to the specification though. The specification
says that its legal for multiple tree's to exist in the
PPTT. We handle this fine, but what happens in the
case of multiple tree's is that the lack of a common
node with IDENTICAL set forces us to assume that there
are multiple non-IDENTICAL cores in the machine.

v3->v4: Rebase to 5.2.
	Minor formatting, patch rearrangement.
	Add missing `inline` in static header definition.
	Drop ARM_SPE_ACPI and just use ARM_SPE_PMU.

v2->v3: Previously a function pointer was being used
	  to handle the more complex node checking
	  required by the IDENTICAL flag. This version
	  simply checks for the IDENTICAL flag and calls
	  flag_identical() to preform the revision
	  and next node checks. (I think after reading
	  Raphael's comments for the Nth time, this is
	  actually what he was suggesting, which I
	  initially miss interpreted).
	Modify subject of first patch so that its clear
	  a that its a capitalization change rather,
	  than a logical C 'case' change.

v1->v2: Wrap the code which creates the SPE device in
	    a new CONFIG_ARM_SPE_ACPI ifdef.
	Move arm,spe-v1 device name into common header file
	Some comment/case sensitivity/function name changes.

Jeremy Linton (4):
  ACPI/PPTT: Modify node flag detection to find last IDENTICAL
  ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/acpi/pptt.c           | 61 +++++++++++++++++++++++++---
 drivers/perf/arm_pmu_acpi.c   | 75 +++++++++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    | 12 +++++-
 include/linux/acpi.h          |  5 +++
 include/linux/perf/arm_pmu.h  |  2 +
 6 files changed, 150 insertions(+), 8 deletions(-)

-- 
2.21.0

