Return-Path: <linux-acpi+bounces-862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DE7D477B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB79C1C20A1D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496AD13FEF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqHnj0PK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40821FB5
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 06:20:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AAC0;
	Mon, 23 Oct 2023 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128437; x=1729664437;
  h=from:to:cc:subject:date:message-id;
  bh=6u6XekGST951M7tNhGalGj6hn+WiLeARLcL22/cN7BU=;
  b=bqHnj0PK9wogBVuKcIpeRjgLuKCpc/iwmJ0vRTDztl/4/mAEJ7bJmb3h
   o3rPadjdlzoAq8pBDLESP1JX1sVI+Mh7ogfIAO1CZ0Z1xiCUE1JtJWBCt
   TYMMkdjYCpyl0ilAte2xY/huSo8JyQFWWCqnLSVEjncUGEdbuM16O6DUN
   28JypIGbcCDR89qTHCxzi/s2dNihKatEK0HdGog4nFvzM7MOxiSWjswF6
   Ry819kn/m+t3s0ePgnn5xWkQ7NW3cFz0HoJHpTdpIGjzpKMKCubIO7H/8
   YNEOnOV5rwyDApeTdz0oCUhUYxz8ThEXCQGuVm4cb5bDgbc+lHasQrohb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806551"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891289"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891289"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:31 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net,
	Jonathan.Cameron@Huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/6] Refine _UID references across kernel
Date: Tue, 24 Oct 2023 11:50:12 +0530
Message-Id: <20231024062018.23839-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use the standard ACPI helpers.

Changes since v2:
- Drop review tags as suggested by Andy.

Changes since v1:
- Change acpi_dev_uid_match() to return false in case of NULL argument.
- Drop accepted patches.

Raag Jadav (6):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
 drivers/acpi/x86/utils.c              |  3 +--
 drivers/hwmon/nct6775-platform.c      |  4 +---
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 7 files changed, 40 insertions(+), 17 deletions(-)


base-commit: a4ed5bffbeb19cfb7e21ac3b3f09d7bfe39a849b
-- 
2.17.1


