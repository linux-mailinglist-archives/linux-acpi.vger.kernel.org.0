Return-Path: <linux-acpi+bounces-14306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2AAD7C2C
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0D16CC0F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371682E0B68;
	Thu, 12 Jun 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrAA8lsw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AE2E0B43;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759211; cv=none; b=fz9/RRrS6SYVc7ip0Jf42Yf1zctplZTqDe2eyTbDsluCAGCvW/NBkrisTvuDrMVZxQJQU3KfxlSsSki5zMEomU4nNWbGQ3tdjXWbmZ8vPdCj6u0ytHfiIk1Y1G5942GUbnnAK6WAgSERiOkML64lEWQrbHYtI6ZzXw1LGypdMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759211; c=relaxed/simple;
	bh=EnVJN8LV8zlQmIIqQMgDmiHwPvTuuDXjAG3xnNRsrNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBYPN4WEMYzskssD6zDldGlBdB2+5gfIL74mk0qmeEQL0v18lxWdWBgbE7AYhupZ+YBxzIFjz5G/BS02O46tW7wetOSAms8OaJgDUfEUjkDksYRwSupnMVe9pOw8InydghZjPSwJVvf3mO+/FYK1d00tpquhBCGqXo7tn9zX+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrAA8lsw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759210; x=1781295210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnVJN8LV8zlQmIIqQMgDmiHwPvTuuDXjAG3xnNRsrNA=;
  b=FrAA8lsw7s7rthG9Nx/cGj4TzC/v68pfj92Izg2rjpnQRr4IjL9eB5x6
   AE7SzJtEVSpn6/BO93ohtLB7PW1sj/SANJ/0SOeGuSYmgLInXCk525l1g
   9x4j4BFEmC/CxctTgGCncvpexZx31lAhkNnqlQd2Hrm1CE60sosL3E+pt
   KMOefVyF6Lc4/IyL+YAkgOKz+b+Nc6kM4SymDVHDsVuvVOFRHpdry1s9P
   UYI+6FZ4tCaZiHhyMhBS8qtAY4OaV+HrV0Ii+5p8EdrxtXvM7BWo+rMbZ
   5KpMuW7yz6+dtwWZm025jVb6wPQbg4BjaSFdcpCIUxg/h87qGV+3XoPo2
   A==;
X-CSE-ConnectionGUID: zrb2N3p9Rl2yvVIQGgsWiQ==
X-CSE-MsgGUID: Kn69xNhGSz+nOzu1VmHfMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54588554"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="54588554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:27 -0700
X-CSE-ConnectionGUID: 1WBicYbcSEGilXMCcA8r+w==
X-CSE-MsgGUID: c8exKA/cRQ29cv54MDF1YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152393997"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2025 13:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7E80F3F6; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/5] ACPI: proc: Remove unused header
Date: Thu, 12 Jun 2025 23:11:27 +0300
Message-ID: <20250612201321.3536493-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
References: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With `make W=1` build we get a warning:

drivers/acpi/proc.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present

Fix it by removing unused inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 48215ba09193..8ae85b06c422 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/bcd.h>
 #include <linux/acpi.h>
-- 
2.47.2


