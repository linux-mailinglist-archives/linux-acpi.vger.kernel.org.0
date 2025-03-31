Return-Path: <linux-acpi+bounces-12568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66CA76C07
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F471188DA19
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E5214A79;
	Mon, 31 Mar 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeXlmuAk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0845214801;
	Mon, 31 Mar 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438949; cv=none; b=lM7QFJG+8GBdXcuVEmfiovnuZ3vCS3lZZ5EFizk2APU6Yrv97gaCn8CzntdUBNRuY4TaR9vLspl+rSzcS8yf2un686Nsv/HfD61hgDeW+yB5M27JoC3o2VzZCubbqPbqiuOtr/CH5ugO60BnN7kqhEATpSTfS8Wb0y18JucCRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438949; c=relaxed/simple;
	bh=d3VM7U6pE4rZgkBEqC55l1d1U4Vy2P/BcFNrM4p0KZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6qb/LcG/lcaKFMoajnLYvLfFXVtSobDnbyajjQMiYSvk0iqrLHXc0VqSrsz8BA6JH4Q2h0gnQ/zrXc4dS+xjRFZnzseEBb26BuYBcuoPj6JUQMdAuvxcsWlsHEgOPD3zdxukww51F/A/yeSsLVmxD8HZlcpfDrTb4PSCP2J/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeXlmuAk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743438947; x=1774974947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3VM7U6pE4rZgkBEqC55l1d1U4Vy2P/BcFNrM4p0KZ0=;
  b=XeXlmuAky0uM1oafYja850s045Pd0XoU3t/IOfuIzqtZ6HxtIfLy3rPr
   xF3cMW3VcAnD+jDji2cryW/UJlPzC1OS5UtObbvrKVnGsxwuza8mNooA3
   OqShd5RsaO4J/owEozZwjR+EtVx69AO8GwzX1PZgrMKA1J7uG0kwdyJPF
   yK9+BzJPy1GZ/soiePwx834gfXKSRLupeXlwc+CHlyukccVTaS4IQFfY8
   Ei+ROIbNXKgPm8qz/TEkdTeXXLrH4ntaoz+nki3pR88riBJdiYjSno3sj
   BRzNm3FcrApY2wPfUQQ9zlK44RQqpcHWK6xJbMBTNJKf5anq141UMcKsH
   Q==;
X-CSE-ConnectionGUID: qeMIqjlDRPmK1ksIEFuU2Q==
X-CSE-MsgGUID: c0kdEANtTQSUs/ZTRz6+Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="55380215"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="55380215"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:35:47 -0700
X-CSE-ConnectionGUID: SFoniIkkTxmrvKrDwH7BFg==
X-CSE-MsgGUID: zT+743NcTOGYRVpEKZOPtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="125889682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2025 09:35:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 178FB141; Mon, 31 Mar 2025 19:35:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 1/1] device property: Add a note to the fwnode.h
Date: Mon, 31 Mar 2025 19:35:13 +0300
Message-ID: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note to the fwnode.h that the header should not be used
directly in the leaf drivers, they all should use the higher
level APIs and the respective headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: added "...into the driver" piece at the end to remove ambiguity

 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6fa0a268d538..4c4d3f93534c 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -2,6 +2,12 @@
 /*
  * fwnode.h - Firmware device node object handle type definition.
  *
+ * Note, this header is not meant to be used by the leaf drivers.
+ * It provides the low level data types and definitions for the firmware
+ * and device property providers. The respective API headers should
+ * guarantee all the required data types and definitions without including
+ * this header directly into the driver.
+ *
  * Copyright (C) 2015, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
-- 
2.47.2


