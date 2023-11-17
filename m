Return-Path: <linux-acpi+bounces-1580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB07EF2B4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702F7B207DB
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364718E07
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Nov 2023 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7fzctNC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13FD4B;
	Fri, 17 Nov 2023 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700219683; x=1731755683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nl2Dsw+dPH2fUNbgA5kZPDoI4Q44DM8znc3EQjvjalA=;
  b=O7fzctNCFA+Sg6r5l96ARM2UpVU0LysS6H5HNxW/p//CYqqUR2gQ5bBY
   lZJNZ9AaMGBndblYwGYFKtA5Q9tKyaChtxkRO9eFoetkMVANBaLwsR+84
   qe2Se2QMOcfN6PCX1GiyXkisSeyx4uiHJirLhBveZBrxDoD07fwtGdvb/
   6F0VpXs4oJJzY/pCxYLO3vDoKFEV4ijH5smjXY3HgCvHYhgmpB852T6Nu
   HY3s7Ak2ET2lCOpnkaAssUZiKMz6WHmVtYd/TDEh83R9n9BkwiciIXeHv
   xL2vOMuUXdQm7epcZrL4EU4yu43xcUJ91iARudfjaLKOMgYxP3bATVmL8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9941636"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9941636"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769201197"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769201197"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 03:14:38 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 16409120F14;
	Fri, 17 Nov 2023 13:14:36 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	rafael@kernel.org,
	jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 3/7] ACPI: Documentation: Document acpi_dev_state_d0()
Date: Fri, 17 Nov 2023 13:14:29 +0200
Message-Id: <20231117111433.1561669-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
References: <20231117111433.1561669-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document that acpi_dev_state_d0() can be used to tell if the device was
powered on for probe.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/firmware-guide/acpi/non-d0-probe.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
index 7afd16701a02..815bcc8db69f 100644
--- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
+++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
@@ -24,6 +24,14 @@ there's a problem with the device, the driver likely probes just fine but the
 first user will find out the device doesn't work, instead of a failure at probe
 time. This feature should thus be used sparingly.
 
+ACPI framework
+--------------
+
+Use the Linux ACPI framework function :c:func:`acpi_dev_state_d0()` to tell
+whether the device was powered on for probe. :c:func:`acpi_dev_state_d0()`
+returns true if the device is powered on, false otherwise. For non-ACPI backed
+devices it returns true always.
+
 I²C
 ---
 
-- 
2.39.2


