Return-Path: <linux-acpi+bounces-1127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9397DDF6A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B4FB21011
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2C1079B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfNtVFis"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817026AB2
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:07:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2A10D
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698829662; x=1730365662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aHrvVFHTpNg5ji5cggAHBEQkiG9tuEK9oTx2GK5x8GI=;
  b=MfNtVFisI3CFfUOj1aloVVtLSjriw6w77r2+QsR/Wbc6dV1fZ/sWh27E
   eOD6xh2vUJTD3KQlQEdfF4wFCnDIWNGATMfxBiRY7i7DLhzXgri8mi8p8
   q29yX4u2wAvGvwLyg4V15ZgiYUusR23oyy18xyAvCh5N/Xq2cNDRnIyXO
   OVUMO0rUGPp6qaUHy5Zypa2GLYi8iS97MemI0qAwhl++39mShUl+S6Ouz
   64mRAsH8li3uLsK1qYoCnVpgIwAsCwu2NnyiU+U0lkjI0jJLl0RXACalN
   kgtuOg7k2kc4EYvU2oKBdqBYhonHv8zH3EEib2+tWp/0M2UmyL6gtZgvd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1314617"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1314617"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1008052028"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1008052028"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:41 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1806F11F929;
	Wed,  1 Nov 2023 11:07:38 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL args
Date: Wed,  1 Nov 2023 11:07:34 +0200
Message-Id: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
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

Sakari Ailus (3):
  acpi: property: Let args be NULL in __acpi_node_get_property_reference
  software node: Let args be NULL in software_node_get_reference_args
  device property: fwnode_property_get_reference allows NULL args now

 drivers/acpi/property.c | 15 ++++++++++-----
 drivers/base/property.c |  1 +
 drivers/base/swnode.c   |  3 +++
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.39.2


