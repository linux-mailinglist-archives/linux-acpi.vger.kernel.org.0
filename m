Return-Path: <linux-acpi+bounces-670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54E7CB2B2
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8265E280F97
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC330D0B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXZqeHl2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D730FBD
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:01:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80B30D2;
	Mon, 16 Oct 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475710; x=1729011710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKww6SjCEG/wpwZG3DM33NqeeIEdYlnk1Zx568Ludko=;
  b=TXZqeHl2u9skQJfihU3Qa8vQkh9qa11a2/omh9KZrh7/8lzGOqu75vCt
   niItsHXfaZr49swNR+/SrxA+0XzZsD2q15Dm3sMIIzjG0J1LhpwlBxgl4
   VNflmiAZ3haBDTsqxBbbpSPK5QC/VoTAkYA/maEHOYFzezNvlR/HbCR1m
   l0LAICYrKV/m4xkRseJCH3jx+sn6ztdQJFYZOYduScu+n6UZsPNgJmQmw
   1qchPP7G4W7L5Mw+YjRlrL87mCBKrp2QHh6dxj/wKu5KSOxhDUgu0nZU9
   qwW7RtYtyU3ky8Wkv1CXG67vg2aavcYC1nr4NqKxny5qJ6Vu53gmAaKn3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385427222"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385427222"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087133794"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087133794"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:33 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/3] Replace acpi_driver with platform_driver
Date: Mon, 16 Oct 2023 20:01:22 +0300
Message-ID: <20231016170125.576159-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset is a continuation of efforts from [1] aiming to replace
acpi_driver with platform_driver. To ease up review effort I'm sending
miniseries per driver, with a replacement patch + various improvements
that were noticed by me, or during internal review.

This mini-series takes care of acpi_pad driver.

[1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.wilczynski@intel.com/T/#t

Michal Wilczynski (3):
  ACPI: acpi_pad: Replace acpi_driver with platform_driver
  ACPI: acpi_pad: Use dev groups for sysfs
  ACPI: acpi_pad: Rename ACPI device from device to adev

 drivers/acpi/acpi_pad.c | 93 +++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

-- 
2.41.0


