Return-Path: <linux-acpi+bounces-1172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8467E018C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948652810B6
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8015485
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4sIQ/7Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5936FA3
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 08:36:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E61BC
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699000591; x=1730536591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BzvPuEQhky6pqshwY2tg00PWOHk2hYzUsgLpgGF9vRA=;
  b=H4sIQ/7ZIkl8P3PJNvm1pTzl9VamU0O50L7WjjdFcSHC+zJuoMh9Rtgx
   2oV6Yv/nwEa0Sdq2N2tqna0FgE63aO1k2067cB7vwHkHTlh9Strt/NNqz
   stywYMkkdCCNAey1YQdl9tYoYPvIB6wZLptsBo96kuKZbKGoF52B5qDrB
   g2JIjBPW4nFbMLQtWwytnOz5IhSAtg2/ml4YDQmyyTyuPoOlUSxBrJGMZ
   fQlEwlIw17vAE7sKxhDOLF9J0Hvw5iaJKo+6iDrafiY8Vze7dYcf2JCHM
   XhJLJEPhMFNXuoL2Ga9pVQYRh+yDYpVLBulYwtArrOpFtTjbQIXmPIuyU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373943759"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373943759"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878574855"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878574855"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:29 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9AF43120F5B;
	Fri,  3 Nov 2023 10:36:26 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 0/3] Make fwnode_property_get_reference_args accept NULL args
Date: Fri,  3 Nov 2023 10:36:22 +0200
Message-Id: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
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

since v3:

- Return 0 early if args is NULL (1st patch).

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

 drivers/acpi/property.c | 4 ++++
 drivers/base/property.c | 1 +
 drivers/base/swnode.c   | 3 +++
 3 files changed, 8 insertions(+)

-- 
2.39.2


