Return-Path: <linux-acpi+bounces-1138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FFD7DE0CD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318B71C20BA1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D08125B9
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go2aKu5n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8C79E6
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 10:51:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC30E8
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698835867; x=1730371867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAfFTWXIBKBCrtJ60sQ5ZFWEm7FGUgivqH1k+4WAJk8=;
  b=Go2aKu5nMkyajIETv15zq+uCXP9guQtVMD+R49D68zjRsZHV+hE4firC
   zwBqUIW3NPYZm121/5e+EZg5G4eLqnHVueSYPm0B867Cfljgr6ezFSTG1
   VUV6DlPhFBZ0j6nquBhYCFoNz/jxAmhQd5qKZBsrEvjqUCSLnISb/0ttM
   Yn1av/Bdvg8wbd+YHsFFkiv6vvZbQiZkk35k/jjuED6ecX8J9cJn2C5v5
   cLUntg8qHPicqHUPsAMS3MyoE04KEfo48GJcwv+vxlYNiei4LQcuXu0Mm
   3lSDu6g82fTKyVSso1cXSBrmkqMyPfd8bTjVR8nWx7/TvLWfpRHXL0I8G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368682689"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="368682689"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760902859"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760902859"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:05 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6B40F1207A3;
	Wed,  1 Nov 2023 12:51:02 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/3] Make fwnode_property_get_reference_args accept NULL args
Date: Wed,  1 Nov 2023 12:50:59 +0200
Message-Id: <20231101105102.1154620-1-sakari.ailus@linux.intel.com>
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

since v1:

- Applies to Rafael's devprop branch now (i.e. not on top of DisCo for
  Imaging set).

- Add Fixes: tags.

- Small documentation line wrap change in the first patch.

Sakari Ailus (3):
  acpi: property: Let args be NULL in __acpi_node_get_property_reference
  software node: Let args be NULL in software_node_get_reference_args
  device property: fwnode_property_get_reference allows NULL args now

 drivers/acpi/property.c | 7 +++++--
 drivers/base/property.c | 1 +
 drivers/base/swnode.c   | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.39.2


