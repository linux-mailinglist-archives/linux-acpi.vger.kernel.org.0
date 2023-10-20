Return-Path: <linux-acpi+bounces-777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4827D0D5A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA3B280E74
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13B17981
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiGzTaeP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B044211A
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 08:48:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD331A8;
	Fri, 20 Oct 2023 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791690; x=1729327690;
  h=from:to:cc:subject:date:message-id;
  bh=55kFwQ1dJ+2JNO1s52sQQCyE+DnzabG8i8c9Ir2rEwI=;
  b=LiGzTaePRnnr4rShhjxisC82fwc5QWFK7iH60WI7wDsDQxYZIi4C5Iss
   jbH/dQj37MTs3XoswEZ9ZxafNXhCb50UvA3ZElVtKjmfCOskiv0imFWZM
   ChMIz1KO5Zt7Y4rr67VUuNj2ix03/uA92fHBPh/wzmQ3sajZtzwM5Ifhq
   OXYFxzB6UI+J3km9MWKyAVgQJEAzCv3zqEhSUqMqFQDYaLm+ByE1547JT
   WQ1bfkz6NBxM57+rHKRMSkXFLG6In+2BvCPTG5k+63bUBqvxTVrDfTI6z
   8oWlgemlrLmZ1Oh4YPiN0GDAlTxvma9MM5fX15VSKgITEoSFXy+rZB3bR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683485"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832155"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832155"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:47:42 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/8] Refine _UID references across kernel
Date: Fri, 20 Oct 2023 14:17:24 +0530
Message-Id: <20231020084732.17130-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This series refines _UID references across kernel by:

- Extracting _UID matching functionality from acpi_dev_hid_uid_match()
  helper and introducing it as a separate acpi_dev_uid_match() helper.

- Converting manual _UID references to use standard ACPI helpers.

Raag Jadav (8):
  ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
  pinctrl: intel: use acpi_dev_uid_match() for matching _UID
  ACPI: sysfs: use acpi_device_uid() for fetching _UID
  ACPI: utils: use acpi_dev_uid_match() for matching _UID
  ACPI: x86: use acpi_dev_uid_match() for matching _UID
  perf: qcom: use acpi_device_uid() for fetching _UID
  hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
    _UID
  perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
    _UID

 drivers/acpi/device_sysfs.c           |  6 ++--
 drivers/acpi/utils.c                  | 43 +++++++++++++++++++++------
 drivers/acpi/x86/utils.c              |  3 +-
 drivers/hwmon/nct6775-platform.c      |  4 +--
 drivers/perf/arm_cspmu/arm_cspmu.c    |  8 ++---
 drivers/perf/qcom_l3_pmu.c            |  4 +--
 drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
 include/acpi/acpi_bus.h               |  1 +
 include/linux/acpi.h                  |  5 ++++
 9 files changed, 51 insertions(+), 25 deletions(-)


base-commit: 9bc2fb9a7e41542a193658deff3df572fa24cb68
-- 
2.17.1


