Return-Path: <linux-acpi+bounces-7275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A636A94750A
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 08:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2091C20C27
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850513A271;
	Mon,  5 Aug 2024 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM1rk/1C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE22EAE5;
	Mon,  5 Aug 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838123; cv=none; b=jZ38DDuzmlBy1UIpdSQUj4v10sJnpZcyUrYYCcgedEu5AX8ZFTf6+jtweC+d/q/hDr6DjFPJeBY4Sb4vS6pHwXSsdnqvvE+7iwYrnrh4HltZZgCYl+XajrnZ+6XW+ogB8oODldTmXv62JLoQ702ebMytpvOH61ZLtsYOo77Egf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838123; c=relaxed/simple;
	bh=SSF+q2oY5ZPXaKAoXZ86Vlq4jxRfnE2okmXBrTUqbYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdpD8O24Nt6BuRd+5ixOvq5T9quUdoPVzRHM8kCEbgZn/P6jhNqJfVu/6jlFCST9lo/IsSUFuFs/0LsDMM7yl2OuME4MQ9Q/nJzFHp8xsclzrJq/uYWz3GBqjdUVG07fRFk3Hc3Px8Vin1TvQvfp5eko6I/Daid3IsLWrhgM3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM1rk/1C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722838122; x=1754374122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SSF+q2oY5ZPXaKAoXZ86Vlq4jxRfnE2okmXBrTUqbYo=;
  b=ZM1rk/1CrPGHaQPLN9mSREjnXLEipRFa/i4QolVQ6wRjwO7BLHKVyCWR
   ULsug2ECywNcFYAveeCKh1XUfJ88dx8DFEO9TcoiUjcOL+P0R+fgb3PzA
   7t1HDtgivzSGvDIQxra6cnlpgo2nbnRkU3bczj1p+Fkp79SARkGWkXRMJ
   L6JOdtOjvbZTDK4rJ5pnrQIFgyAT4mmdHoh7+P05qG6LnXPoGupkmoFrn
   H5ajOcx0McUB8VivLA8V9T7wAeJNLNebgPN+pJjLNUwddaON842PIAFND
   9RQ8AEPGw3jqL6LKP2UuuXrqC3xQ6w+lHjkdvQ+BwUQT2bsXpvxv0s7Gj
   g==;
X-CSE-ConnectionGUID: UnBSDzoZQ9uI/aecnB7JxQ==
X-CSE-MsgGUID: oz8Zc44nR0Cc1AtnBgtjSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31360130"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31360130"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:41 -0700
X-CSE-ConnectionGUID: AIifB4adRPe+e0cL142mbg==
X-CSE-MsgGUID: 4pAxDCtPTciYzpPxQGD1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="61028934"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:08:39 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 0/2] ACPICA: S3 wakeup support for hardware reduced model
Date: Mon,  5 Aug 2024 06:08:11 +0000
Message-ID: <20240805060812.1002004-2-jiaqing.zhao@linux.intel.com>
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

Jiaqing Zhao (2):
  ACPICA: Detect FACS in reduced hardware model
  ACPICA: Allow setting waking vector in reduced hardware model

 drivers/acpi/acpica/acglobal.h  |  6 +-----
 drivers/acpi/acpica/hwxfsleep.c | 21 ++++++---------------
 drivers/acpi/acpica/tbutils.c   |  5 +----
 drivers/acpi/acpica/utxfinit.c  | 24 ++++++++++++------------
 include/acpi/acconfig.h         |  1 -
 include/acpi/acpixf.h           |  8 ++++----
 6 files changed, 24 insertions(+), 41 deletions(-)

-- 
2.43.0


