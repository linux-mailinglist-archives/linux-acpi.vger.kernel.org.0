Return-Path: <linux-acpi+bounces-1150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8207DF010
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717BE281943
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910813FEF
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLEEdWlx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8FCA4D
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:12:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF3112
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698919950; x=1730455950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wokVdbxVQ+OQerFoCr9ANOErJ7IXkunMQzvGnXwIyBA=;
  b=lLEEdWlxGYfEY9CwMd5mPaF+onCpWrPq6dpnV6JvEwDxAhIORblyGbjZ
   1s8AcX+JjNp9CmIKT/whqEh3DNxXpanmRigzwy2xnJl/q61RbYnm1l0v/
   Mk6hywyzhDVTaopYNCDShdUl1PPC/FSnf1cQkSefKXF1T2q4wiYH+IfSe
   jdF1AN7XAq6Cekbn1LDFHcEogsMBjZBQ0/d/7NpI5Q1qeRdtAzfkkoapc
   tKhUsdReSY87315FxO1Q3VfaRztxgOxIgJu2nywz3M6SqWBsElC1TidY4
   Ehv2kpvFlNLkNkmTJKg3hoH4P8uklKy/C2091yZToD77VtgshepEuli4O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1550389"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1550389"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737707815"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737707815"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:12:27 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8DB5D12035D;
	Thu,  2 Nov 2023 12:12:23 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 0/3] Make fwnode_property_get_reference_args accept NULL args
Date: Thu,  2 Nov 2023 12:12:19 +0200
Message-Id: <20231102101223.1186166-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

The of_parse_phandle_with_args() accepts NULL args but
fwnode_property_get_reference_args() does not currently, in its ACPI or
software node implementations. Fix this.

since v2:

- Correct fwnode_property_get_reference_args() name (was
  fwnode_property_get_reference()) in commit messages.

since v1:

- Applies to Rafael's devprop branch now (i.e. not on top of DisCo for
  Imaging set).

- Add Fixes: tags.

- Small documentation line wrap change in the first patch.

Sakari Ailus (3):
  acpi: property: Let args be NULL in __acpi_node_get_property_reference
  software node: Let args be NULL in software_node_get_reference_args
  device property: fwnode_property_get_reference_args allows NULL args
    now

 drivers/acpi/property.c | 7 +++++--
 drivers/base/property.c | 1 +
 drivers/base/swnode.c   | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.39.2


