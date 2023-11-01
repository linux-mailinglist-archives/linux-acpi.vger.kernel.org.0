Return-Path: <linux-acpi+bounces-1139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201897DE0CE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DB7280C62
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC6125A4
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4Q/NStV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A81079B
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 10:51:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29089119
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698835872; x=1730371872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKFzF32oVi7oNhOUD5npF4DwwVaEgqx+4gwIyc8RAIg=;
  b=H4Q/NStVptArjg844KXfPh47UgMxQ3laE8Pu5JNQsE1CEVeestsj5tNo
   zXpzk6DxEYgekEfMCq31pTKVlPrYyNVrDxWSecNrOeaM6a277iq6zJKvP
   KyzJ/AwCZ06q0YYYnpBYcgjHRWUmbfcSIVwOhIFIKNtcVQ9EuZPQVX+6a
   RyB4N95zPvqvLFcn9Ycsg5CZgt1qT5qXsQeMRCweoX5LVpO7WaE7o3XSo
   aP5SeyMLSYVWfM6ZjdH6SPK4VqozLFh/Q94hOIYFN68ayAPzb+vu51J1O
   Zt7L8NFvzI91cQ38FmGMge0fYq3xYUIURWWrz+Y/aiAN2uk2EL/0baWUn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368682699"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="368682699"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760902866"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760902866"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:07 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DEB11120BD3;
	Wed,  1 Nov 2023 12:51:04 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/3] device property: fwnode_property_get_reference allows NULL args now
Date: Wed,  1 Nov 2023 12:51:02 +0200
Message-Id: <20231101105102.1154620-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101105102.1154620-1-sakari.ailus@linux.intel.com>
References: <20231101105102.1154620-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three fwnode_property_get_reference() now allow args argument to be
NULL. Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..8667b13639d2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -508,6 +508,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
+ *		May be NULL.
  *
  * Obtain a reference based on a named property in an fwnode, with
  * integer arguments.
-- 
2.39.2


