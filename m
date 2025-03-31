Return-Path: <linux-acpi+bounces-12547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42680A75FE7
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC667A2957
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B31ADC7E;
	Mon, 31 Mar 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAz+ZZxT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717D41760;
	Mon, 31 Mar 2025 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405798; cv=none; b=LhwZarlsbKydlHTi9ua+9gpzyBO9AL/UN6eRo9+0stF7rx+Qi+SqgSC1Ny3NDt5kme3b/gu3q+Fq963JXDibSA6xMPlpQ2CIoS+R2PX67XbJdNOC5o95DCS+VEGyRoB0yNspsOFspWTYWpEFdv6ZIo3b/3zn3qfe/gY9i/8S0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405798; c=relaxed/simple;
	bh=J72FR0c0pkPAoRPukKWi2UAtfRD5G9v+Zv6nBsRj8H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeGauArbbB0rMbGoRRVYGqccnygsqzJO8GuZvwJu7g/Mk4+C0jVjfmEDKmuCnYZkp30K8RdTBA8h8DuWIXrT+ccBNlZKPL1dkCcYkT9s6NSqJLGBOt2U3WzIk2skF6189xh4V0rNb78TuKLq3n4h8+NXjYftGIeK2x2mL4xhA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAz+ZZxT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743405797; x=1774941797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J72FR0c0pkPAoRPukKWi2UAtfRD5G9v+Zv6nBsRj8H0=;
  b=VAz+ZZxTN+a1grO8+CW/HawA2YzuMBHbTv5XjYDticHbQfoilZej1DHa
   PQ2a/wyaVTSVsccTKjpDAnUbtDblF+/lZ2sUaKUGdlf05oV6vrjjzDnf3
   xmnHl8nk/SEL7VWtyJCfxwvONNCyZzISLXd24MOPHIRjkpDmrEklGD4jC
   SnDPT1rx8YD3DaeHwpeYNnk5girzFxbeSl6vAtpqf2LC5gOLMrSQMxw0m
   mdBrALIHacODvokb9vvP2oCtVJFo+kixjP0xsFmywLDFQ/tCZQiGUWPhZ
   9F8EL9gy3XLEGQ3fuwvULi0lrVnqN3wH/epRIIRQy6yw491qjBgU5Wakr
   w==;
X-CSE-ConnectionGUID: ZnQVbmYBTxySXwXoPR7m8Q==
X-CSE-MsgGUID: R0BPARL2TAOyTYFeflcmUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44858641"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44858641"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:23:16 -0700
X-CSE-ConnectionGUID: zy3YoCT2TUm8qijMD71ikQ==
X-CSE-MsgGUID: MV8kfjhNRuW0IUQb1scrEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="125765167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2025 00:23:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DFB61B4; Mon, 31 Mar 2025 10:23:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: VIOT: Remove (explicitly) unused header
Date: Mon, 31 Mar 2025 10:23:11 +0300
Message-ID: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fwnode.h is not supposed to be used by the drivers as it
has the definitions for the core parts for different device
property provider implementations. Drop it.

Note, that fwnode API for drivers is provided in property.h
which is included here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/viot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 2aa69a2fba73..c13a20365c2c 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -19,11 +19,11 @@
 #define pr_fmt(fmt) "ACPI: VIOT: " fmt
 
 #include <linux/acpi_viot.h>
-#include <linux/fwnode.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 struct viot_iommu {
 	/* Node offset within the table */
-- 
2.47.2


