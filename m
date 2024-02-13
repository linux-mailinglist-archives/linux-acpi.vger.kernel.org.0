Return-Path: <linux-acpi+bounces-3450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D085322F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984E11F22964
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096956465;
	Tue, 13 Feb 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUNrBFFv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389C55C1D
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831973; cv=none; b=eYSHdxIiGXX+PhoVXGPa5a4eJ6KvjjCx+9vmvl98bC9rV6pHEarbeEf2weR7hT/CvE2eNACNa0RpOBR1r9BhM+ns1s8v89eDzfZh2ZQVDRymf2x7MnskOlWrt3UNwHfVWtqZceVVfKXUOYaAC7EZn712/atLKmyDMbciIXHzEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831973; c=relaxed/simple;
	bh=5QM2u73ygfobpkZV5yqxzjPMGYiItAsWdFjxRVG49uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htwlPjR1KZPDwCbEViAV1qiDWWXVzpJBeFYg+e909O7AJZVNP5Em92S3d4KWDI6xttfmWlq2wjv5WQ0R2/kEORi3ZmD0XZXzpApCtmqF94R/OyaqQ8UNn8OLJ1CHH1LDryZGZcLmNYB5cw1F+pZgJ8fy8UFS8hgnace84sWeLMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUNrBFFv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707831972; x=1739367972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5QM2u73ygfobpkZV5yqxzjPMGYiItAsWdFjxRVG49uQ=;
  b=lUNrBFFvPGO6bas55cwzAoOXxSbZPqcikXCV3fg1fEpqDtXgtj8rEsNf
   ZDMAKjOnA9kbFRgsQKPVb8DeBE9dS9dfdZiNhOaSWXObvqk3H1bfMHbEn
   NNZYrOYNeHiaoaAZ0nJVafxflTcx8sdITMTyaxABrH1BFViBWl/7KAy0t
   JYFkxZVJw8sFLiVL/qql1CiHJEY1WLIv2VdR+cN/+M4fv2SOejUW8YQe5
   cHrnTtVxifeFNVIN5QBtEdOPPlrbl23Z/VVx0qP2l27Woq9xsHKqKHX89
   DntepA6WuEbZXje/bvr+AClh+LA3zQC3ZmW2nknlAsKwiHnR2poyrh5ZT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1743672"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1743672"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3207225"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:10 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D5D2B11F855;
	Tue, 13 Feb 2024 15:46:06 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/2] Ignore bad graph port nodes on Dell XPS 9315
Date: Tue, 13 Feb 2024 15:46:04 +0200
Message-Id: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

These two patches skip instantiating bad port nodes on Dell XPS 9315.

The ACPI firmware contains Linux specific camera declarations but they are
missing the IVSC which sits between the camera and the IPU. The IPU bridge
can be instead used to obtain a configuration that is usable in the
system.

I presume there are other models that have the same issue.

since v1:

- Use a better subject for the second patch.

- Don't explicitly initialise static variable (second patch).

- Improve the commit message of the second patch slightly.

Sakari Ailus (2):
  ACPI: utils: Make acpi_handle_path() not static
  ACPI: property: Ignore bad graph port nodes on Dell XPS 9315

 drivers/acpi/internal.h       |  1 +
 drivers/acpi/mipi-disco-img.c | 71 +++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c       |  3 ++
 drivers/acpi/utils.c          |  2 +-
 include/linux/acpi.h          |  1 +
 5 files changed, 77 insertions(+), 1 deletion(-)

-- 
2.39.2


