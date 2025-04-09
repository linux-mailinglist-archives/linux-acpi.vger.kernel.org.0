Return-Path: <linux-acpi+bounces-12874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC69A81A1A
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB90A426B01
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454E3E47B;
	Wed,  9 Apr 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVyxs2pY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F3DDBC;
	Wed,  9 Apr 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744159831; cv=none; b=IpDV23vsF6yX18fqZ/g6Sgg6BIaVOY9/Nq93iiQko1IM+lGzR4nh9WVDS+TH4XY60JBxYKbUqB5UxX/ZA8cCQE7lgb75lkJ3uZamXLg0FloHmisZsbNhrovgo6A767AUgf9SKCl1gH62MJmCth8c3hm9y4FZ6jD0jQjVq3CL0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744159831; c=relaxed/simple;
	bh=ruMRzzQx4ZHRl3cKWLayka5Crex7091j+PQVr8L6/mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ph3l92/+a2InL5dwt0X/WmF5HL00msPzoJbG4QMmBihZAX9zg3gC5qV+zqPywRX8csSBtMg1wOH0ZZTfEW1Wz28m2qzjOR3sNF+hB1tSU3iTM39srtwFr80KlwEqmwupr78ampD/07AHxLaKyTvmDoa9CJG9/aJd19Td7bHyMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVyxs2pY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744159830; x=1775695830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ruMRzzQx4ZHRl3cKWLayka5Crex7091j+PQVr8L6/mo=;
  b=hVyxs2pYAd88qvIteFw4C8YhuMHeOodfeUMh+S1oc6LsTDGiTR6dCrwp
   nuhnKZ1N7L/nFn90YTHBEX5jGLfyDlzrFE24srz3Ns5N59iuKlTD65EAt
   Vl+IrZtd6Dt5sksEVwU/CB+j2jRVfvUP1XE5piEeZFjIK873s6zA69pAT
   Tgtz1coc+oFX7hsMux4QgSeEDW7kEL+SZe3jdWzva6adpv64TvN0y7GYp
   ZZLpzB0XsmbJVHgdz2JWGRQENO/JW7K+XhsovdhYF5wA/ZgVdTe1BM/BN
   6ZyTnbuU2KJ9t9zjPrT+VgPPOCJMXOUrJqFvVx5ZiGTpD/dufitMMc9ne
   A==;
X-CSE-ConnectionGUID: Cq1yNE5kSnStOA5lIW8ZZQ==
X-CSE-MsgGUID: eckLarkCSLOwJJ2Av/xW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68095406"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68095406"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:50:29 -0700
X-CSE-ConnectionGUID: kVCcFimBQLivvzR6CT7ekQ==
X-CSE-MsgGUID: wfI7iQgWR46Q7Puo1AljXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151611724"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2025 17:50:27 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: ggherdovich@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] ACPI: processor: idle: acpi_processor_get_cstate_info() cleanup
Date: Wed,  9 Apr 2025 08:50:24 +0800
Message-ID: <20250409005026.1932637-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series does further cleanups for
acpi_processor_get_cstate_info() on top of
https://lore.kernel.org/all/20250328143040.9348-2-ggherdovich@suse.cz/

thanks,
rui

----------------------------------------------------------------
Zhang Rui (2):
      ACPI: processor: idle: Set pr->flags.power unconditionally
      ACPI: processor: idle: Remove redundant pr->power.count assignment

 drivers/acpi/processor_idle.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

