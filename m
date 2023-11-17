Return-Path: <linux-acpi+bounces-1577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAA7EF2AE
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EB1F26C4B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7330F93
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuDhpupZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F9131;
	Fri, 17 Nov 2023 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219682; x=1731755682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dEq8ro/qwe8sVqsG7NZcEIURqHix2i2JgSRLXmWjZmY=;
  b=JuDhpupZ5y+KQR559+GxhPsEXHg8QI7VJfrVfmjHyDuKIz7IfD3+n/3s
   q5piP6hQDYzSCf1tJhnm1YM93b4UK6JzWZ+SHi2KT2ffr9EpQcy0yqCL5
   Cfpz8oGzkjsNjY3UTbVyu2mZVTwr0TznOj9KNFKmrkW36q1R/MHpbeKuA
   8p9DtERP7RgwqD9R5X0L5oQGqb0MUfwtv0lZgXfv4/Ic9fo9kUR6tN2m9
   6ydYpOeItX3UGAlYnka4tqiXKJ7L7CbAWpAhFValsYXrILEi1mUm2npTA
   3lwyhgbqJLcjUVD3YdsfXAAFJMK7e6A55cOZ+dj5JaOoODA12rj8aHeLR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941630"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941630"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201192"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201192"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:37 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9E9DF120E08;
	Fri, 17 Nov 2023 13:14:33 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 0/7] Small Runtime PM API changes
Date: Fri, 17 Nov 2023 13:14:26 +0200
Message-Id: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This small set happily mixes Runtime PM and media patches.

The set does two main things Runtime PM API-wise. Firstly,
pm_runtime_get_if_active() is made more user-friendly by removing the
ign_use_count argument so the users no longer need to call it with that
set to true. Secondly, pm_runtime_put_mark_busy_autosusp() helper is added
to avoid drivers having to call pm_runtime_mark_last_busy() only to be
followed by pm_runtime_autosuspend().

The vast majority of the users of pm_runtime_autosuspend() would probably
have been fine with making pm_runtime_autosuspend() do the last busy
stamping, too, but given the sheer number of users it's hard to tell if
there could be problems here and there. On the other hand, there are
probably a sizable proportion of call sites where the missing
pm_runtime_mark_last_busy() call is simply a bug.

The three last patches are addressing Runtime PM issues in a few sensor
drivers.

Comments would be welcome.

since v1:

- Fix a compilation issue when CONFIG_PM is disabled in the first patch.

- Improve the documentation patch, assume the use of autosuspend (this
  generally makes sense for camera sensor drivers).

- Keep using pm_runtime_get_if_in_use() in imx319 and imx219 drivers (they
  don't use autosuspend).

- Add a patch to document acpi_dev_state_d0() in conjunction of non-D0
  probe.

Sakari Ailus (7):
  pm: runtime: Simplify pm_runtime_get_if_active() usage
  pm: runtime: Add pm_runtime_put_mark_busy_autosusp() helper
  ACPI: Documentation: Document acpi_dev_state_d0()
  media: Documentation: Improve camera sensor runtime PM documentation
  media: ov8858: Use pm_runtime_get_if_active(), put usage_count
    correctly
  media: imx319: Put usage_count correctly in s_ctrl callback
  media: imx219: Put usage_count correctly in s_ctrl callback

 .../driver-api/media/camera-sensor.rst        | 76 +++++++++++++------
 .../firmware-guide/acpi/non-d0-probe.rst      | 10 +++
 Documentation/power/runtime_pm.rst            |  5 +-
 drivers/base/power/runtime.c                  |  9 ++-
 drivers/gpu/drm/i915/intel_runtime_pm.c       |  2 +-
 drivers/media/i2c/ccs/ccs-core.c              |  2 +-
 drivers/media/i2c/imx219.c                    |  8 +-
 drivers/media/i2c/imx319.c                    |  8 +-
 drivers/media/i2c/ov8858.c                    |  8 +-
 drivers/net/ipa/ipa_smp2p.c                   |  2 +-
 drivers/pci/pci.c                             |  2 +-
 include/linux/pm_runtime.h                    | 49 ++++++++++--
 sound/hda/hdac_device.c                       |  2 +-
 13 files changed, 133 insertions(+), 50 deletions(-)


base-commit: 3e238417254bfdcc23fe207780b59cbb08656762
-- 
2.39.2


