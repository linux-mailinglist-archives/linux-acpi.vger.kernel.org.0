Return-Path: <linux-acpi+bounces-17031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B7B59CCE
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E461C04664
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5C37426E;
	Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYkd8wHm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C753469F6
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038502; cv=none; b=EPDaqRkYBy7wg2K8LPfyBHoikpgUv0mDLRoCi3d2u8JhvMz++sfM3HYDyucSxxkVxJPZGiWIVNL0y7n2tfKG8lc8/i9Soz9DarMcmyShLGouQxP1ebLZyJlHT3IAc9CjUK90gjVj6CX1Lscc0xeSMKP6dvNAGFUZSu0Kllr3Eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038502; c=relaxed/simple;
	bh=pD53e8hNHTyH8KovHZ1K5E8qWGpPmlnNctSTunSrXwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6rBVP3RqM1jHEeOpkhSu4ItU9aVyqZgVvHDDciXuYchaJIMdsA3/UMMBwiiv2QDtZhm/axKt81T9N/vl+oH4Laa/8REO4R4giD9YWtFrXbwQQZO/pSOuu5uDbTbY5S7hmJQeHJRdjOI9v7tMHNY7kdSw6demG3EhB9fnLy2/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYkd8wHm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038501; x=1789574501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pD53e8hNHTyH8KovHZ1K5E8qWGpPmlnNctSTunSrXwI=;
  b=nYkd8wHmKH8fCmt6MiehYqnMdH5i/lg1UNMqd36aFiF6eglDTvlY815x
   qcGCQ6s7fHKcUf4m9kqrhLnlAXzaL1OExBLlFupcPA9EdkH2GwY//Aq96
   FVmMyRE+NU18f+is1NGXqTUy7Pr2hoTHIuRaEGoeq9puxeKdnJkoiIWqa
   9SMJRvKCcXD8nkVtfhogOnItzJvOo7SOQBeDk53sJTlXI8LtI4u6k2WZ0
   8BlM0Pdp9zxlQ/e87730n1zqYF994a5B5Olwf8IFSvUxlSiUra7n31ZDz
   dXf2R8VKRyRrCFzGNzr7D0fGdJdT739R+Ax3LlZMZbgo3aDKDpLcujWjK
   Q==;
X-CSE-ConnectionGUID: WDihnmN3SGiVYGyfgaGHnw==
X-CSE-MsgGUID: F0KsURlMT6OtOnKBjz3NZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422947"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422947"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:39 -0700
X-CSE-ConnectionGUID: FvXFtLqWQL+HlqC4AaIzzQ==
X-CSE-MsgGUID: KupjwkAJQB6fxIoKjG6aGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091518"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 64702121F00;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gaza-1BHI;
	Tue, 16 Sep 2025 19:01:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 00/14] Align availability checks on fwnode child node enumeration
Date: Tue, 16 Sep 2025 19:01:15 +0300
Message-ID: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Historically the fwnode property API has enumerated only available device
nodes on OF whereas on ACPI, also nodes that haven't been present in the
system have been provided. Both OF and ACPI have similar concepts of node
availbility, on OF it's the "status" property present on device nodes and
on ACPI the _STA object evaluates to device present, enabled and
functional bits, of which the present and functional bits are currently
being used to determine whether to enumerate a device.

Two additional functions, fwnode_get_next_available_child_node() and
fwnode_for_each_available_child_node(), have been provided to enumerate
the available nodes only on ACPI, whereas on OF the implementation has
been the same on the non-available variants. The motivation for providing
these has very likely been to provide fwnode variants of the similarly
named functions but the difference isn't justifiable from API consistency
viewpoint.

This set switches the users away from the "available" fwnode API functions
and later on removes them, aligning the functionality on all fwnode
backends.

I'm posting this to linux-acpi and a small set of reviewers for now and
once we're happy with the ACPI / fwnode changes, to the full list.

Sakari Ailus (14):
  ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
    only
  ACPI: property: Make acpi_get_next_subnode() static
  ACPI: property: Return present device nodes only on fwnode interface
  property: Drop DEVICE_DISABLED flag in
    fwnode_graph_get_endpoint_by_id()
  property: Drop DEVICE_DISABLED flag in
    fwnode_graph_get_endpoint_count()
  property: Document that fwnode API returns available nodes
  driver core: Use fwnode_for_each_child_node() instead
  net: lan966x: Use fwnode_for_each_child_node() instead
  Input: touch-overlay - Use fwnode_for_each_child_node() instead
  media: thp7312: Use fwnode_for_each_child_node() instead
  leds: Use fwnode_for_each_child_node() instead
  leds: Use fwnode_get_next_child_node() instead
  property: Drop functions operating on "available" child nodes
  spi: cadence: Remove explicit device node availability check

 drivers/acpi/property.c                       | 34 ++++++++---
 drivers/base/core.c                           | 10 ++--
 drivers/base/property.c                       | 56 +++----------------
 drivers/input/touch-overlay.c                 |  2 +-
 drivers/leds/flash/leds-rt4505.c              |  2 +-
 drivers/leds/flash/leds-rt8515.c              |  2 +-
 drivers/leds/flash/leds-sgm3140.c             |  3 +-
 drivers/leds/flash/leds-tps6131x.c            |  2 +-
 drivers/leds/leds-max5970.c                   |  2 +-
 drivers/leds/leds-max77705.c                  |  2 +-
 drivers/leds/rgb/leds-ktd202x.c               |  4 +-
 drivers/leds/rgb/leds-ncp5623.c               |  2 +-
 drivers/media/i2c/thp7312.c                   |  2 +-
 .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
 drivers/spi/spi-cadence-xspi.c                |  3 -
 include/linux/acpi.h                          | 10 ----
 include/linux/property.h                      | 14 +----
 17 files changed, 54 insertions(+), 98 deletions(-)

-- 
2.47.3


