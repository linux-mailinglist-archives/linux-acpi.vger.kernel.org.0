Return-Path: <linux-acpi+bounces-1536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6B7ECA9C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C97281382
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C3364CB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNH8SuVC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A5196;
	Wed, 15 Nov 2023 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072334; x=1731608334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vDsmhnXIvSS4wPk4vVk8AND6/EQE7fhPsvRfxD4Vfxc=;
  b=iNH8SuVCArpS9W3hhVTX7pmJ6Ub3LqlXQfzBy7DrpJFYgRpwEr5rqL7r
   X3ypbZ3nvx7KwVZc8nOa+7wErmoBnN2uTCvWSw/MneS6tCrb0fcWwuqPG
   8PqYstcdASp/MA2dI1AsbBa1e9ybfzFktCEXR1FSE7Z9YxHfUGCBCW/qT
   xTwc3enKq3VjVZpFneK/LaQjEvMKd2CuQpocVxrSGTYY5iGKJqcqNWBrr
   St6ZvQvbekMcv4fIjlDtX7eMJ+w5Aj7SBBDy11FynmDiIBlOXlB65gCIZ
   FBtLrxvuYbm/WucD02zSjxXrjHNmll1nDHahjaJoeWvn4W6DF2YAxx8Hm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381321117"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="381321117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831014654"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="831014654"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:18:44 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9516B11F830;
	Wed, 15 Nov 2023 20:18:40 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/6] Small Runtime PM API changes
Date: Wed, 15 Nov 2023 20:18:34 +0200
Message-Id: <20231115181840.1509046-1-sakari.ailus@linux.intel.com>
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


Sakari Ailus (6):
  pm: runtime: Simplify pm_runtime_get_if_active() usage
  pm: runtime: Add pm_runtime_put_mark_busy_autosusp() helper
  media: Documentation: Improve camera sensor runtime PM documentation
  media: ov8858: Use pm_runtime_get_if_active(), put usage_count
    correctly
  media: imx319: Use pm_runtime_get_if_active(), put usage_count
    correctly
  media: imx219: Use pm_runtime_get_if_active(), put usage_count
    correctly

 .../driver-api/media/camera-sensor.rst        | 28 ++++++++---
 Documentation/power/runtime_pm.rst            |  5 +-
 drivers/base/power/runtime.c                  |  9 ++--
 drivers/gpu/drm/i915/intel_runtime_pm.c       |  2 +-
 drivers/media/i2c/ccs/ccs-core.c              |  2 +-
 drivers/media/i2c/imx219.c                    |  8 ++--
 drivers/media/i2c/imx319.c                    |  8 ++--
 drivers/media/i2c/ov8858.c                    |  8 ++--
 drivers/net/ipa/ipa_smp2p.c                   |  2 +-
 drivers/pci/pci.c                             |  2 +-
 include/linux/pm_runtime.h                    | 48 +++++++++++++++++--
 sound/hda/hdac_device.c                       |  2 +-
 12 files changed, 92 insertions(+), 32 deletions(-)


base-commit: 3e238417254bfdcc23fe207780b59cbb08656762
-- 
2.39.2


