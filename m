Return-Path: <linux-acpi+bounces-1036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E87D919C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D233CB20A19
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844B156D4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48E8489
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 07:29:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EEBC116;
	Fri, 27 Oct 2023 00:29:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4608F143D;
	Fri, 27 Oct 2023 00:30:37 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.32.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D9E03F762;
	Fri, 27 Oct 2023 00:29:50 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/7] Subject: coresight: Move remaining AMBA ACPI devices into platform driver
Date: Fri, 27 Oct 2023 12:59:36 +0530
Message-Id: <20231027072943.3418997-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves remaining AMBA ACPI devices into respective platform drivers for
enabling ACPI based power management support. This series applies on latest
coresight/next branch. This series has been built, and boot tested on a DT
based coresight platform. Although this still requires some more testing on
ACPI based coresight platforms.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-stm32@st-md-mailman.stormreply.com

Changes in V1:

- Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki

Changes in RFC:

https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/

Anshuman Khandual (7):
  coresight: replicator: Move ACPI support from AMBA driver to platform driver
  coresight: funnel: Move ACPI support from AMBA driver to platform driver
  coresight: catu: Move ACPI support from AMBA driver to platform driver
  coresight: tpiu: Move ACPI support from AMBA driver to platform driver
  coresight: tmc: Move ACPI support from AMBA driver to platform driver
  coresight: stm: Move ACPI support from AMBA driver to platform driver
  coresight: debug: Move ACPI support from AMBA driver to platform driver

 drivers/acpi/arm64/amba.c                     |   8 --
 drivers/hwtracing/coresight/coresight-catu.c  | 136 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-catu.h  |   1 +
 .../hwtracing/coresight/coresight-cpu-debug.c | 130 +++++++++++++++--
 .../hwtracing/coresight/coresight-funnel.c    |  49 ++++---
 .../coresight/coresight-replicator.c          |  44 +++---
 drivers/hwtracing/coresight/coresight-stm.c   |  80 +++++++++--
 .../hwtracing/coresight/coresight-tmc-core.c  | 127 ++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  76 +++++++++-
 10 files changed, 549 insertions(+), 103 deletions(-)

-- 
2.25.1


