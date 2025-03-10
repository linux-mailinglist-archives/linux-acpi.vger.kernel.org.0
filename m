Return-Path: <linux-acpi+bounces-12012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D33A59925
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D593A605B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1622DFA0;
	Mon, 10 Mar 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3W2Ur+J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF922D4FB;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619326; cv=none; b=r06iQgYbYZ93f5wK1924sWckOTMpiKi9l7NsfeLAmE4gJFOEOQLqM57w8UFfXNSH7YjtNIQlHmewXTCfj8k16Gj6IlF2tCbgvhO+QxvBYo1xb2F2Issbyor6bDiQ5MiqEPfXGCTNE3Tt9Ns9akMih+t4eKy4jhEjuUkpMUzO214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619326; c=relaxed/simple;
	bh=EpMFSHa1gvbKfDyXibbN9/h7VuT+tFTW2UFp/+p7z6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hD+vFArzAdD5Y+Wgw+lqtEUH+yMl8v8bgExAUQiJ/jJUKLDhYADuXnZoBDEoQBrwrTTNzsuuvp2VixZDGAYU7c53x3XZEqPP3wzGdESKZDqrW+FExzmd/GopuqPW1HPWppver+yenQQXEr/LqVHe0H16A+OSFR5Fe6GYmhN000U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3W2Ur+J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619325; x=1773155325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EpMFSHa1gvbKfDyXibbN9/h7VuT+tFTW2UFp/+p7z6s=;
  b=h3W2Ur+J64iIHh9G4I6TUIcxwuNjtEV9I60Z2T5gwvja9ysTuri9aavw
   gM9M1UkvA2K1dgRyplK/VP32l4ECCa7Kug6vPrsLJemShiOZcbcyf0oYz
   tp4SmZZ7vE9T8xVoWow69STPeGCfVw1b2wxjHm3sK3ZSn59dk3mmlNaLm
   edtbsbiKy1NH/oPS6S0aw1LP3x+UdehyLaHucBCjx1uOs63lt/eM4P02R
   guoC46FjHM3fZBrpaZeawXkn4jOLbTm0Gw1AQa0rDTe1jJUViP4wCVZRF
   y/Dbe2zdB9BSsMw5unhLiDhb08cFRtv4cBWa4F71ZFJZDDeOXV58jqYKt
   w==;
X-CSE-ConnectionGUID: idpDIE95SOyU8Y4daln6OA==
X-CSE-MsgGUID: tgDlIRl1SDOSf3w8tn96dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42470922"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42470922"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:08:43 -0700
X-CSE-ConnectionGUID: 1oHC2dQkSyq+7W0yUn0Wpg==
X-CSE-MsgGUID: VcPVJum6TIyfxFftSp7Wig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124619902"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2025 08:08:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BC5FF156; Mon, 10 Mar 2025 17:08:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 0/4] leds: Introduce and use fwnode_get_child_node_count()
Date: Mon, 10 Mar 2025 16:54:50 +0200
Message-ID: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series was inspired during review of "Support ROHM BD79124 ADC" [1].
The three conversion patches are the examples of the new API in use.

Since the first two examples of LEDS, in case of posotove response it may
be routed via that tree and immutable branch/tag shared with others, e.g.,
IIO which Matti's series is targeting and might be dependent on. The USB
patch can be applied later separately, up to the respective maintainers.

Link: https://lore.kernel.org/r/cover.1741610847.git.mazziesaccount@gmail.com> [1]

Andy Shevchenko (4):
  device property: Split fwnode_get_child_node_count()
  leds: pwm-multicolor: Use fwnode_get_child_node_count()
  leds: ncp5623: Use fwnode_get_child_node_count()
  usb: typec: tcpm: Use fwnode_get_child_node_count()

 drivers/base/property.c                | 12 ++++++------
 drivers/leds/rgb/leds-ncp5623.c        |  5 ++---
 drivers/leds/rgb/leds-pwm-multicolor.c |  7 +++----
 drivers/usb/typec/tcpm/tcpm.c          |  6 ++----
 include/linux/property.h               |  7 ++++++-
 5 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.47.2


