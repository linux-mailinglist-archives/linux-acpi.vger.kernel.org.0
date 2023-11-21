Return-Path: <linux-acpi+bounces-1666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E27F2D58
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED12280ED0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FB4A987
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keJk8CZH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D5C1;
	Tue, 21 Nov 2023 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563118; x=1732099118;
  h=from:to:cc:subject:date:message-id;
  bh=bxtTVb3CSDkXZiM00Vj7mR/GNeU9U6TTLbrsPm7CyvU=;
  b=keJk8CZH/UyyV9yZOw8fMTttimCpo3jOTpoWfeHcfkge6K8cI3sXNh4g
   ykmuGpvYJH1cqoxGYuCp/A9mWcfN90Zpj3lMg3OOesQqIs1UkMLg8K6J+
   spYZX1p8J8dZRLoaeZFE3jY9HC/dDsMmP2Igvh5ujYPZeJ1EkCfZtdZ13
   9aI41aDMqlM7wt/4Amq1fKOxdfbuRA7GMXCLs/StITQWQlymhlbZOLRTp
   DLO6q95VzdXikYErobos0Go25Zl8kAZWFfRU2/u+m6un86Cr0aDdVDUAo
   rjKLYcPn/0ztdHBn2Y67oxMxQPwKqXvl4oh4Ae1xJbFjwy1dJkUmGUHsA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986846"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871909"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:33 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/6] Support _UID matching for integer types
Date: Tue, 21 Nov 2023 16:08:23 +0530
Message-Id: <20231121103829.10027-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Changes since v1:
- Fix build errors

Raag Jadav (6):
  compiler.h: Introduce helpers for identifying array and pointer types
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               | 16 ++-----
 drivers/acpi/utils.c                   | 48 ---------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +--
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 59 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++-----
 include/linux/compiler.h               |  5 +++
 7 files changed, 73 insertions(+), 81 deletions(-)


base-commit: f437a8d1debff5412e36a1c9454adee193b31950
-- 
2.17.1


