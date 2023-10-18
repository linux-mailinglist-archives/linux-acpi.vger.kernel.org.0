Return-Path: <linux-acpi+bounces-750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AC7CE91B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 22:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EA7B20D22
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5383E01F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPApd0Jy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC688335CA
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 19:10:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BD811F;
	Wed, 18 Oct 2023 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697656208; x=1729192208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZUecB5QU3YRVFjpA+BfFj4FQml103oMvulQUPI1rBM=;
  b=gPApd0Jy1TrXP18KDEj+R7n/EBmHi9C3RTjMiUmglUQgaiu63vjK+D/X
   MhB3/pJHuORHVctiBVh8vHyKUTuGyPaxKTVYxa6rcrhqxaDmQeHiO9UpP
   MWGQACgzHDpjsEhF2NuFi8T/3yMYG+IYdEP7Ir/umEsg1AIjehA9T2Sdg
   5p4CqN6csNz3FshRDOGm3NNir2QKjOlajrxmh7Foha2eqvU0/XiFrVLjN
   WFSm5yKUaD2msA9/NgOyPm729ql1EcZ0Vn4qixLv8ywss8IsxqSRV9H68
   5pTMeWkkGbRRg77WdVdmszEhbFCUJpby4vF/5P7HFRXyFN3lmHe4sJ2UU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472323309"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472323309"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733277256"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733277256"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 12:10:05 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 0/3] Replace acpi_driver with platform_driver
Date: Wed, 18 Oct 2023 22:09:42 +0300
Message-ID: <20231018190945.252428-1-michal.wilczynski@intel.com>
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

This mini-series takes care of acpi_pad driver.

v2:
 - removed all the unnecessary whitespace changes from first commit
 - removed changes to acpi_pad_notify(), and installer/removal handlers

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (3):
  ACPI: acpi_pad: Replace acpi_driver with platform_driver
  ACPI: acpi_pad: Use dev groups for sysfs
  ACPI: acpi_pad: Rename ACPI device from device to adev

 drivers/acpi/acpi_pad.c | 82 ++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

-- 
2.41.0


