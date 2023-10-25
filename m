Return-Path: <linux-acpi+bounces-949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61157D6BD8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68051C20C65
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4D27EDF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYHD0J1g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049426E19
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:18:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A13128;
	Wed, 25 Oct 2023 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232714; x=1729768714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OZVkAUofT4Hs3fiP8QhnOHXLA4XmUAOuacC4kM7ypAQ=;
  b=DYHD0J1gPKhNl72hYwAQNHnPHbBAh3KN5c1ffLUD3IrTXW/kD1GNEUBS
   Beq0T8mBmkJ8wVPuzlN8BiAhsR5eEuFEaJ/LUVgoJG9zFGKAUiZY5FC7B
   NFZu0Sx6sv05EaMLyDezaw/vlFtBrHH92rKFq0McMz+44CsskzGdXMmlR
   itVrux8IjfS7tcZW0SlPHBCFyrJXOb5j4/4dffRVmaiWCrzX19P+TTwmP
   rqiieHO/5ahi0TPSPmlgUm0yB69TaK+8X/sVuAhTj0lOz6ApCbMFVUsRN
   4sKNndjbNcyYKDDG7cPfMWXr6cIiLVnbMiABPm8lZTsYJTBbSuqAD4Kwm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154604"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425060"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425060"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:14 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/6] Replace acpi_driver with platform_driver
Date: Wed, 25 Oct 2023 14:18:00 +0300
Message-ID: <20231025111806.2416524-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is a continuation of efforts from [1] aiming to replace
acpi_driver with platform_driver. To ease up review effort I'm sending
miniseries per driver, with a replacement patch + various improvements
that were noticed by me, or during internal review.

This mini-series takes care of acpi_video driver.

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (6):
  ACPI: acpi_video: Remove unnecessary checks
  ACPI: acpi_video: Use yes_or_no helper instead of ternary operator
  ACPI: acpi_video: Remove unnecessary driver_data clear
  ACPI: acpi_video: Replace acpi_driver with platform_driver
  ACPI: acpi_video: Rename ACPI device instances from device to adev
  ACPI: acpi_video: Fix holes in acpi_video_bus

 drivers/acpi/acpi_video.c | 101 +++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

-- 
2.41.0


