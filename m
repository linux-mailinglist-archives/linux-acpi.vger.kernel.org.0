Return-Path: <linux-acpi+bounces-7526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31594E63D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 07:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2140DB20A53
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 05:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA114D6F6;
	Mon, 12 Aug 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXsE+VXm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B69181;
	Mon, 12 Aug 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441623; cv=none; b=t3P51SuyNGg3rOlME/GvG9uica4agN60I8NsHAT70Z3NyAi1/C3SAeH/Bm9KNUEdUqc3kbSVFOTUUaQWFsahoXzi3S0WOLrGdx7w9kOhF6D8AHO8TPISW4P8n9ucf2sK9ubxALjINdpvq19U37Td9ejLUcHLBz5jk8G/YHpCWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441623; c=relaxed/simple;
	bh=mjANdqS4tIqFcNmjfGSk6Mge77SfYTtXt6bEcWungrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bw0Exm4zgp8ETWruf1YcsiBtVZE2TklnnqK6SbvHhMaH3w+NMGLwfWs0K2M6kwl7loZCYY4wQXquQOdYRXGD3jwLDiUKTOgfi0UyXgTzLadyKPr6o171hkOzDlMEeIPSuOUGQdmRm3C88aHGJSZR08AdvMosGJ1SUhql7VpUFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXsE+VXm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723441622; x=1754977622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mjANdqS4tIqFcNmjfGSk6Mge77SfYTtXt6bEcWungrY=;
  b=DXsE+VXmx35olJV2/iyCYi+K4gl2K/oNlLXH2J4rEtCJjFcMi6MN5pLy
   VtH0qyY2aE8KeNoF3o2OReaOv6rzEQTbsmTsPgbs5LF1LfT4gfdU7Byyr
   jGaDVt//OgmnxW9y2JGAeZkBeTGPDWM1iaJpkNMHe7B4TVkpdebd7V+lm
   Ir3d1o1hz1GBRss1jC8Jtqi3s98sbm4w5pZNfYY0BDICwn3FcBSSjaez+
   R1Qqpo2+Dtluz6qcXAla7P1rpDv4diOSZ5QeBzxWNmoXln+IU3phFsosO
   96xwNn2rqbrzD4AZL/xWY/9qQgu/cbfNFTV/SnVitREyvuHhavVF2fHOJ
   Q==;
X-CSE-ConnectionGUID: hUuDREyKR2uTAjERkE6XIw==
X-CSE-MsgGUID: frrVBCRLRIid47DNbl94uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32925973"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32925973"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:47:01 -0700
X-CSE-ConnectionGUID: CVeTr0QIRguTOTMcVG3UAA==
X-CSE-MsgGUID: JkztF/5pT22DUintmr2ZFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57800721"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:46:59 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v2 0/2] S3 wakeup support for hardware reduced model
Date: Mon, 12 Aug 2024 05:46:45 +0000
Message-ID: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S3 wakeup requires waking vector in FACS table, which is typically set
by OS. This patchset enables FACS table support and allows setting
waking vector in "Hardware-reduced ACPI support only" builds
(CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y).

Link: https://github.com/acpica/acpica/pull/960
Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104

v1->v2:
* Not removing acpi_hw_set_firmware_waking_vector() declaration in
  hwxfsleep.c
* Change was merged in ACPICA project, add links to it.

Jiaqing Zhao (2):
  ACPICA: Detect FACS in reduced hardware build
  ACPICA: Allow setting waking vector on reduced hardware platforms

 drivers/acpi/acpica/acglobal.h  |  6 +-----
 drivers/acpi/acpica/hwxfsleep.c | 15 ++++++---------
 drivers/acpi/acpica/tbutils.c   |  5 +----
 drivers/acpi/acpica/utxfinit.c  | 24 ++++++++++++------------
 include/acpi/acconfig.h         |  1 -
 include/acpi/acpixf.h           |  8 ++++----
 6 files changed, 24 insertions(+), 35 deletions(-)

-- 
2.43.0


