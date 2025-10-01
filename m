Return-Path: <linux-acpi+bounces-17468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB2BB0016
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1429B1923EEA
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA42BE059;
	Wed,  1 Oct 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAlCmI+K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822BC2BEFE3;
	Wed,  1 Oct 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314408; cv=none; b=KgyDOKbWTMPMwOoT35gR9Fbu8rfdwY2eRtxCdpeJ2/1c3jsjSlrjpkYNRsqxkwaMfJPY2b9CCBRlU2nEWlOGTA0LnIEcuBE/aBN/c5cfAn2MOpye3GdTvCiTnbYXgFWqv38YRI0OhmQKAhYZyD+OC5LIJPziWV1cr+ezdQU2eYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314408; c=relaxed/simple;
	bh=JtFjGInvbmb30Bugtt8rsida/KNirlcgUPAuxhb1xTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI0MObBYzV+m8Phn6igEGZifXVpZNU/AW6LHniTrouvFy155mC3Lj3y/pmDq/QotZBiMSZBeZXgUGl169LdOUQMUxfgIu4yalgvl+TIlKu9bmjByT8WdMdqosH9lmM1q9ardp8dOibxDOouCXwpq8Fc7r5qdKPLeEj2DimMmetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAlCmI+K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759314407; x=1790850407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtFjGInvbmb30Bugtt8rsida/KNirlcgUPAuxhb1xTY=;
  b=GAlCmI+Ku/w/Fgct9cuoAGyla9Lr/j8e/8nt/+sVVqXKNHh44g/WkaTr
   9ZSJ8FBBiig/9xn3WvU4Y7dHUOvZCSe6h9Qwknl5TC3LOKEvWjcpO2UVb
   TaRBOjQpQBd9/npcr1IEcSC5uZ9U+JUluFZMMlKY/yjtcwHZAasj88xFD
   B3it4srGIQRROt1LZ5uZ49SxPxYY8KH1AyUpa2KxypM/OFSt9c9GrLihv
   Mfi5QOxwUHJVqA/zeO2hKB80RRtVEwOzbLvMqqWGwZUXds1xQMjvktcHe
   6rHC628WmUN9xOWH/0k4KfS49UWtSU4gyjqXpI03CpGR/0E3y4im7FUPW
   w==;
X-CSE-ConnectionGUID: FcQpVNLcQNSHzhFaM4N+6A==
X-CSE-MsgGUID: zCn9hjr2QdaJrqnjILESaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="71834080"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="71834080"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:26:46 -0700
X-CSE-ConnectionGUID: bvcJR3MHQ0GK1FkQjzzHWA==
X-CSE-MsgGUID: gFnIcMeyQJSoE2Lp0WoeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="182778112"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:26:40 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 92CAC11F8D0;
	Wed, 01 Oct 2025 13:26:36 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3u2e-00000005L60-1wvs;
	Wed, 01 Oct 2025 13:26:36 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/1] Add node availability check for child node iteration on ACPI fwnode backend
Date: Wed,  1 Oct 2025 13:26:35 +0300
Message-ID: <20251001102636.1272722-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This patch adds device node availability check to the child device node
iteration in the ACPI fwnode backend.

The previous set including with the tree-wide changes can be found here
<URL:https://lore.kernel.org/linux-acpi/CAJZ5v0gQ9vnT+Z8zryEausp-2xX7HocoBgwmiptxg7BGiU9C8g@mail.gmail.com/T/#t>.
I'll post the other bits separately as they'll be merged at different
moments. The rest of the ACPI changes can also wait until v6.19.

since tree-wide set v2
<20250924074602.266292-1-sakari.ailus@linux.intel.com>, WRT. this patch:

- Don't use kernel-doc functions to document static functions in .c files.

- Add empty lines between sections within a now non-kernel-doc comment.

since v1 <20250916160129.3955410-1-sakari.ailus@linux.intel.com> (entire
tree-wide set):

- Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
  first.

- Add missing parentheses and kernel-doc Return: section in
  acpi_get_next_present_subnode() documentation and move the Return
  section: of fwnode_graph_get_endpoint_by_id() to the end of the
  documentation section (new patch for the latter).

- Use device_get_next_child_node() instead of fwnode_get_next_child_node()
  in flash LED driver drivers.

- Rework iterating port nodes in acpi_graph_get_next_endpoint() as
  suggested by Andy (new patch).

Sakari Ailus (1):
  ACPI: property: Return present device nodes only on fwnode interface

 drivers/acpi/property.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.47.3


