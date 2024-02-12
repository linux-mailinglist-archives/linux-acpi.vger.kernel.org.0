Return-Path: <linux-acpi+bounces-3398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277A851056
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 11:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96CE1F2234C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7F17C69;
	Mon, 12 Feb 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1qr+a0u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F917BA1
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732522; cv=none; b=RQohZOSVLR2HdGGTz+fQClELzpPLljyrl8aJV2lBu5ujRH2p5QjZCeViMDQIhtJ8QBUv8pzsqyOZ7GBRmEFfwuWUP+PyST3vyiFbSnN+DbyxkYdhRPnwF8ppX3oJXb1xtrgYZ6ALYflbgcVIuwvxeNWcoGDzRyaacAlddJToG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732522; c=relaxed/simple;
	bh=n3RP9hA84JDLfF7gvR6MAk7+5E54vfA2XVkDCPflTIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6qRT2jeRFiv4zRMlmH2Dpv9m4HTm7KobjYQ6myv6EFhpFjJoIFxAFpd4Tl0wa0mBm6EOVQ23m2A887ZQixK4vVq3i2nIluWcLipmdUEIJGkhhmMovcfK+Eu9qXUvXiCgBMd0cO11uTDNJMffi4juf3NJqoKJJTlnwQ1hBn8Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1qr+a0u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707732521; x=1739268521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n3RP9hA84JDLfF7gvR6MAk7+5E54vfA2XVkDCPflTIc=;
  b=h1qr+a0u68gkotEpkgdgsSgJp5M1BD+/8QodS0KhqcyhNll38f2jBq9X
   nqZIJa1MoRD3J9L/NHEodjPtBOouurc+OlJW/pFYOtTuIBbm66ikllPZK
   uHTWeiL3Vbx6X4JPSxDM7vXMLLT6EzPDc6yPuqqDt2QwREjOTpklNPnTl
   L83V2ieFggOdn/rmR4gKNjiOqlCs8Gbn3rYAPhjDdAPFewIj9zN7YeHny
   D7uGDz2bEoYN6Q5r0DvQqGVBe0h0i+/HDdjz7quTeHNH/QSw6mWzdWHEY
   EA1Ic30OQ3BV/fIR82MENxxOsq/MDulRlIEfiTTwUkkJ5yFgLRsf+hbBI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1828604"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1828604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33617874"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:36 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 0899211F86A;
	Mon, 12 Feb 2024 12:00:32 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2] Ignore bad graph port nodes on Dell XPS 9315
Date: Mon, 12 Feb 2024 12:00:30 +0200
Message-Id: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
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

Sakari Ailus (2):
  ACPI: utils: Make acpi_handle_path() not static
  ACPI: property: Ignore bad data nodes

 drivers/acpi/internal.h       |  1 +
 drivers/acpi/mipi-disco-img.c | 71 +++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c       |  3 ++
 drivers/acpi/utils.c          |  2 +-
 include/linux/acpi.h          |  1 +
 5 files changed, 77 insertions(+), 1 deletion(-)

-- 
2.39.2


