Return-Path: <linux-acpi+bounces-6057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F78D2360
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322B9B223AD
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025F155C8F;
	Tue, 28 May 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW6FTf6A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAA2563;
	Tue, 28 May 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922057; cv=none; b=c2ZwH8U0R1oN/tSfFyDXxhyZJVDrKBjRwkm+71iAK7ec7r7JLxR6/AD5J8KLQcVx+L4Hg12JpnNd+bWRAQfeJugxXEQiFICfkDAtlj2/G8IP250uXsOFhL9NCNTv54f/sUHDHT/nDeW3UtUSnX+m4Oi4lMhq2wLDF39XI8lyLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922057; c=relaxed/simple;
	bh=xvP1VccHe8rD/xL8zKhQCPBNYlG7U41tzPfwwybLnDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjfBX/f00G8C35G8s+gCd8OMAuD7KYHj5RM/g1AuQxbNOdfOrRk/99StvXcM2T0ZNK+tH3p9EGKAwleta2jNYl+Da4sV6GZnKh5D3M9JdijMrnOszXBbp2zjw+UWjChoEvAuvmKf2KbdAGzxTlfJfTIc2rFqbXbueHZ7m2HLd0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fW6FTf6A; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922056; x=1748458056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvP1VccHe8rD/xL8zKhQCPBNYlG7U41tzPfwwybLnDU=;
  b=fW6FTf6Akilw2xUTHXkDKNZHdhIBZGP4wKEnlc/D1VrvDwxBr399ALJ+
   ot/4tbJQCgK1PFCUDvRIipJ9PtMozCvXsV83g6llUgM6HuY5OcG+2Vo6r
   LlU9faKSdNr+EONu03JkBXU+qEwmT0rStagXhnwrOazriXyczGoc3DCI2
   0RUd8bguqo4+j9ykgBoRQZbMcvD91XICDREFCLc9NAZ++B7HFFBmMzZsf
   L1pNM751y0O5+kdWPaVj8a8nARGN/CRJbkgKP3hFiwhe+MoJvYdPra8tg
   w8l9gzx1DsymlocDKmbWd5ucV2cIYVe4i0+HIykdN3GeUPKgHjMpucb7u
   g==;
X-CSE-ConnectionGUID: VMCRG5bKTcuC1mJxA7PHmQ==
X-CSE-MsgGUID: dI4qQdoEQbiviWGmNY4FCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121547"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
X-CSE-ConnectionGUID: iWvAbibhRl230hIK/RG0Xg==
X-CSE-MsgGUID: H8WBe8U0QYyuD64VG/QGIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605163"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:29 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/8] PM/ACPI - New Intel CPU #defines
Date: Tue, 28 May 2024 11:47:12 -0700
Message-ID: <20240528184720.56259-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches were previously posted in a patch bomb[1] across
all subsystems. The core pieces of that patch bomb are now
upstream, so here are just the PM/ACPI bits (previously
Acked by Rafael).

Signed-off-by: Tony Luck <tony.luck@intel.com>

[1] https://lore.kernel.org/all/ZlYVqSlx8GLwTJEr@agluck-desk3.sc.intel.com/

Tony Luck (8):
  cpufreq: Switch to new Intel CPU model defines
  intel_idle: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines
  ASoC: Intel: Switch to new Intel CPU model defines
  thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model
    defines
  ACPI: LPSS: Switch to new Intel CPU model defines
  cpufreq: intel_pstate: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines

 include/linux/platform_data/x86/soc.h         |  12 +-
 drivers/acpi/x86/lpss.c                       |   4 +-
 drivers/cpufreq/intel_pstate.c                |  90 +++++++------
 drivers/cpufreq/speedstep-centrino.c          |   8 +-
 drivers/idle/intel_idle.c                     | 116 ++++++++---------
 drivers/powercap/intel_rapl_common.c          | 120 +++++++++---------
 drivers/powercap/intel_rapl_msr.c             |  16 +--
 drivers/thermal/intel/intel_soc_dts_thermal.c |   2 +-
 drivers/thermal/intel/intel_tcc_cooling.c     |  30 ++---
 9 files changed, 198 insertions(+), 200 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.0


