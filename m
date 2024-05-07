Return-Path: <linux-acpi+bounces-5647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919D8BEC46
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 21:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B521C2155E
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690316D9DF;
	Tue,  7 May 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzTJXt3u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51316D9D2;
	Tue,  7 May 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108862; cv=none; b=KFmjRA+g8MBr5szvustSOhBsaGVJf+UuOZUCZ8fFj2SvXORXI6gPSk4Xi+WY+N+wk0kVlZPV4RmMshUkRtjJAYhlExar59JJuRDnBVzbLV5PA4WXV6b0Lcbx6i512LX1BvdK66bfA5hFvg+0sfUZJqPfIbnMqVg0FWBV3y43e+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108862; c=relaxed/simple;
	bh=qtqaN9rr9Eia+Kj5bbQi1idKK6zzUOOP4FFtQwkfURk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WCiv2UEh4+FArbpSagz1qbZaGd1RhznkwX/4EQ9CO6ANZOa2XAamAsfOa6u8sQ8Uw+ONJrsmr6zBPHAxKQTPuM7A4ExT4SL/TjoiIXh6+dKMYFC+r/WlRDIt3ButRiwGYESSLTjYERIK0Kda8jjQ81devwl3h2xXH8cm3Hl0w+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzTJXt3u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715108861; x=1746644861;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qtqaN9rr9Eia+Kj5bbQi1idKK6zzUOOP4FFtQwkfURk=;
  b=XzTJXt3uyY8rXsApfVyXz/CUTs0klInrlaHMuGQ9WfA+pX/7/K8z+iyw
   iZXGifMXuqDjBGHY+lsW4bxXjH/EB5/qQ2TOM5zf7M5S/sXZH15hnA1i1
   rNmqR+JouMuZkjO+jZnrJaYPAgsOsiygBTxncTF4I89beTWRp/a/Cg6sV
   aHSN3S47iXuPkeqaI5cFTzQtX3oRNF7lNCuj2/i2P4P9qU00az9oXh6GU
   mnVTh0k8DWM4Vctbhlnh85mchi86ILTcGZi2R93Dxnm4mKyRyQCXiQAtL
   qsoTaIWd+0tAvOYMw7cpd503LBeokytHicI9gHtD+bTktJrq0M8sgyH6E
   A==;
X-CSE-ConnectionGUID: 0D7NITnZTmymV+OpcJjOEw==
X-CSE-MsgGUID: W8eX5E7RSwW2+VWCQXOLoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11087450"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11087450"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:40 -0700
X-CSE-ConnectionGUID: izlBBsaRQVi3CHDR1zVxOg==
X-CSE-MsgGUID: uLqVrdvRTACG8tNkElYvSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28682089"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:38 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH 0/3] ACPI: extlog: Log and trace similarly to GHES
Date: Tue,  7 May 2024 21:02:19 +0200
Message-ID: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it
makes them available to the kernel via the Common Platform Error Record
(CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
via two similar paths, ELOG and GHES.

Currently, ELOG and GHES show some inconsistencies in how they print to
the kernel log as well as in how they report to userspace via trace
events.

This short series wants to make these two competing path act similarly.

This is an RFC mainly because of patch 3/3 which enables kernel logging
even in precence of userspace monitoring events. I'm not sure if this
behavior is wanted.

Fabio M. De Francesco (3):
  ACPI: extlog: Trace CPER Non-standard Section Body
  ACPI: extlog: Trace PCI Express Error Section
  ACPI: extlog: Make print_extlog_rcd() log unconditionally

 drivers/acpi/acpi_extlog.c | 44 +++++++++++++++++++++++++++++++++-----
 drivers/ras/debugfs.c      |  6 ------
 include/linux/ras.h        |  2 --
 3 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.45.0


