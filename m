Return-Path: <linux-acpi+bounces-831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F97D2A6F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17C7B20CB4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3581860
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGO9k8G1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E6257A
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 05:36:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7AE9;
	Sun, 22 Oct 2023 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039383; x=1729575383;
  h=from:to:cc:subject:date:message-id;
  bh=A+HHnsIqeJDnLwMTstSYgBGn2R5+0SVjEsJpoHcWuWs=;
  b=TGO9k8G1c5+7JQ5W/JSs6rz3xPLUTQLZwJhSVqYyuUjXYT9rubqvwW1D
   TLY0opmXW/D46E3e0LsZcPLyzzv8QnL4CilngWbKoELxQ5wxrsUoKnwwn
   PAoIR1geXFZ1dONm/0Rn6Mr67kP09gLBFLO1z3Um/jDXjn6a/kEuhp2DP
   5OTPglWz/iSk3ULduiaXNdfFMzpkUamJo/csBuJy25seqb0O72FORMIFm
   3kDa9iNlXZOcKcTHg9SkUDnojS79oAfIlVOSmM/Ut1mfGBEjltHQgNYQn
   na+qpFS7tSrPtHlcAzbuFsLrFy6NPaRK354wWwTMsZQQ8npqi4HWV80cs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905358"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556671"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556671"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:35:53 -0700
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
Subject: [PATCH v2 0/6] Refine _UID references across kernel
Date: Mon, 23 Oct 2023 11:05:24 +0530
Message-Id: <20231023053530.5525-1-raag.jadav@intel.com>
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


base-commit: 64b6555f2fe6b43fb6782aa3e2cbb34bfe39047d
-- 
2.17.1


