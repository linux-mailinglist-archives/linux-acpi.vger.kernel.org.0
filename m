Return-Path: <linux-acpi+bounces-3271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838EE84C19E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119D41F21E19
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1201AB818;
	Wed,  7 Feb 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjSImACd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3ECD268
	for <linux-acpi@vger.kernel.org>; Wed,  7 Feb 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267712; cv=none; b=ihI2WJVB8Ysr6DY88cGZkkDhME9yo+SQkD7LjU1wqGi68ed1ldRmoxmEYS0/HWo6IGKxjZDs+A0skTtRYdmDtpuA4rPgwZPMlAoxZz6fVYQUW33jsRAnMFZdIIPu2rq/MqP5WpYQb/xtPpRwpK1ap/q/HgyKj/iDt4KFCOTMjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267712; c=relaxed/simple;
	bh=GdQk+3hUEcBQqXSTnezPO8QNQjYzLl1Ntih+0TSoTX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mwe+zm6U0rGYqKAl4mK4n/vIwDKzjL/bcO6LND94puvfWF9PIf89n6OLiChU3QtD+1xfaEI9KY6++xEaze3SvxHsJeZmXCwyMmVBVJvKLDuL0S0Nlywk9BmuSy1whgLoXhnbYwmUBggNn4Lkgaoza6zVH9EbU5qIJl7hfUIDLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjSImACd; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707267711; x=1738803711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GdQk+3hUEcBQqXSTnezPO8QNQjYzLl1Ntih+0TSoTX0=;
  b=YjSImACd6W0z351tj1FIYzjfF55ajrr75FR0gvNgEi3qpRuPveML5NIM
   ANrfKBRuP2peiT/guA8kYIBN0aO5tDBKyIrcopstuy14I3ieVu50jRkT8
   nvDB5iC6TMInnQ3FJcLuGBxqhUyRO8z+S0TSCKZXUBTq6Vav9YoBiC0yN
   AIlE0YmEJ8PwbQhxmEz2j4kCcyx3SQwr1FH/r/dESbX1u3kjqUnYvDBk5
   UdFkk7Mjg3OUw/f+67HjTdJokj6cfwW0FOZqN7Cx/vA1oxqjlqaMXYYB7
   fFK0+n9otI0TqLUdxMmYZ77Lsc9LC3l8hPwjENnBmsUh/wm5oocJXbIXS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="395297740"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="395297740"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1225685"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2024 17:01:48 -0800
From: Wentong Wu <wentong.wu@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH] ACPI: scan: Defer enumeration of devices with a _DEP pointing to IVSC device
Date: Wed,  7 Feb 2024 08:59:08 +0800
Message-ID: <20240207005908.32598-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inside IVSC, switching ownership requires an interface with two
different hardware modules, ACE and CSI. The software interface
to these modules is based on Intel MEI framework. Usually mei
client devices are dynamically created, so the info of consumers
depending on mei client devices is not present in the firmware
tables.

This causes problems with the probe ordering with respect to
drivers for consumers of these MEI client devices. But on these
camera sensor devices, the ACPI nodes describing the sensors all
have a _DEP dependency on the matching MEI bus ACPI device, so
adding IVSC MEI bus ACPI device to acpi_honor_dep_ids allows
solving the probe-ordering problem by deferring the enumeration of
ACPI-devices which have a _DEP dependency on an IVSC mei bus ACPI
device.

Add INTC10CF, the HID of IVSC MEI bus ACPI device on MTL platform,
to acpi_honor_dep_ids.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ed1ba91e5c..f32a2c738c8b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -798,6 +798,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
+	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	NULL
 };
 
-- 
2.43.0


