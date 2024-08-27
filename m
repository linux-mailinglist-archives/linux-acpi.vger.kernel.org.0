Return-Path: <linux-acpi+bounces-7851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA695FF72
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 04:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BF82834FD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE7168BE;
	Tue, 27 Aug 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/FdYYU3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3617557;
	Tue, 27 Aug 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727518; cv=none; b=hpIkOmJZlPT12Z8Z4o+rne7wE8AmYRt6zcfZe1yPb1hhUzV9HRDlOcld21E6Hjof6UFSOd9oihFxRVOs6mbF/n2URDM3NouCOXP3Pb79op0GCX2C/Rge81pG3MvIBlJyN+gNCT4H+1GBcBf+eFQWYjVOzZZ0TQmbDuNACqhe+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727518; c=relaxed/simple;
	bh=jqyKjeT+R4Fk0oV/newEmCCJjx15nG/UAsgJcEBYdQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zmx0GNZsdQ4H+1HZeDvufmiHcMkiOr/wtlt6YaYsTWaPyUSBXd3K522pkYHKx38A/exF8FHMnnTuAVxxL7Fr88Wd2DMQxqNJwzvyCVnZPMUTvTon2UMF5mjgWveN1BMRYoA5R81nSkxkT1+gdnp00sD0fD0SpWVSAxajhQ7odcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/FdYYU3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724727516; x=1756263516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqyKjeT+R4Fk0oV/newEmCCJjx15nG/UAsgJcEBYdQg=;
  b=i/FdYYU385dITiGIAGZFP1L/1MaNy4Z1mmEr9RBlCsZnP99ikrhdCmaF
   TrpMjYStfPfAAb6w9hRZXkB4p5fqNN4EqTpcJSUnkxAVQbOFo+/51ufW1
   k1IOeFcpx2uLm4A4tjP79An0iDe38CGSCqbtngu8Uwed6OqDMsJw/L8hc
   JoCxQAynjjxODPgS8t2f8sOSwEtQPyILzLyVJSEP4c4En3gErudORxOOa
   C3AUhvs5vM5KfvH5RfYrz6myAbMRnK7FHV6kZC+5QC3iohAnPiCQuqFBI
   gs5ZohMGgSKSTX9nFfhfbEFs5/QXqFwLuh9SS19kmotwhkqFr7FNi3n1C
   w==;
X-CSE-ConnectionGUID: Z5SPWsOjQu6zXQge203I7Q==
X-CSE-MsgGUID: HwI30/rXTwKiNHJpHes9Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40654895"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40654895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:36 -0700
X-CSE-ConnectionGUID: mnJTibRmRsSifiWvKkI+Bg==
X-CSE-MsgGUID: Gl/duOj7Q7ahMb/TqejOiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="93512976"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:58:32 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3 0/2] S3 wakeup support for hardware reduced model
Date: Tue, 27 Aug 2024 02:58:19 +0000
Message-ID: <20240827025821.2099068-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S3 wakeup requires waking vector in FACS table, which is typically set
by OS. This patchset enables FACS table support and allows setting
waking vector in "Hardware-reduced ACPI support only" builds
(CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y).

Link: https://github.com/acpica/acpica/pull/960
Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104

v2->v3:
* Remove extra code style changes to align with original ACPICA commit.
v1->v2:
* Not removing acpi_hw_set_firmware_waking_vector() declaration in
  hwxfsleep.c
* Change was merged in ACPICA project, add links to it.

Jiaqing Zhao (2):
  ACPICA: Detect FACS in reduced hardware build
  ACPICA: Allow setting waking vector on reduced hardware platforms

 drivers/acpi/acpica/acglobal.h  |  6 +-----
 drivers/acpi/acpica/hwxfsleep.c | 15 ++++++---------
 drivers/acpi/acpica/tbutils.c   |  2 --
 drivers/acpi/acpica/utxfinit.c  | 24 ++++++++++++------------
 include/acpi/acconfig.h         |  1 -
 include/acpi/acpixf.h           |  8 ++++----
 6 files changed, 23 insertions(+), 33 deletions(-)

-- 
2.43.0


