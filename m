Return-Path: <linux-acpi+bounces-17473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22969BB00B2
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C904C4A0F0B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9382C08D0;
	Wed,  1 Oct 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na/AvAzy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722612C0269;
	Wed,  1 Oct 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315411; cv=none; b=hL7Y1RhESWvvlJXxP/KIeKyfWE1rzVVXdSduIrsTS7rgNSEQ2tVD2M5KlQPx84Of0C/sXsP9Wjwu/topANhO8s9lDsbx/GIbmIyxtVpRajx248hVMHVcKSu65+ROoe/sNgMRJ3268MBwrwXX/kzMFYhwNu8qGfRZvaIiwnGtItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315411; c=relaxed/simple;
	bh=pjc0ltiFlsJ+gTtE2O50XCnYwZNXXpBhCmtux4LT//I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5PSvQjSLCwXRHGVIgXKwc1NLTrgvUx6GNaehMY7hwW7WtWvOBa0p8R+p0JJZAlHWiLJ0Vg4l1LqlReQ9OkToE6wfigtEdJzOoyXnBEGSlvUYITkeNs08h5ofA0kHOVnbf4jaxdjUHSv6NExwhSnN852AtycHiPTUPoO1HE7g+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na/AvAzy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759315409; x=1790851409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjc0ltiFlsJ+gTtE2O50XCnYwZNXXpBhCmtux4LT//I=;
  b=Na/AvAzyRyYYEdW/L4fmtwQ7tByg0u8T4jzulVcO8f1zOcGmpLbNo/Gf
   3/UsChfjZVQ41DWrXnML4p1H6Yx4ew9RtRwUhj1VArPl2PWNnpyWZI47v
   RVkq+duTO9uzH8BRUZiarz/R+kVPgrCsxnw/noJJr1b+mI+8NGwvFih3T
   B/+7n1AWii8lr6D81BGkjSPHqDG/BT0ZsjMo5tjv9IOOypRMo5gZm0lSW
   JawIMG+QAL2ZCcsI/7yBGBZF9ZwQ/AZlKE1VYuM2F/OFFafs+G98f0EO9
   1dWmM9+L1FGe/Wel+2VR0qDpf0FO5hZJnFqBsf6OeIFNrbeVGUV81kppq
   w==;
X-CSE-ConnectionGUID: sq6o5oxgTYKZqt8bq/fVQA==
X-CSE-MsgGUID: IAIylTUMQ7acSZ9DMBdmCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61293956"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61293956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:26 -0700
X-CSE-ConnectionGUID: 75zEa4eMS3Ckjz2ZYlVGuA==
X-CSE-MsgGUID: DuiZQoVlSdO9D6kYxW0e1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178357470"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:43:24 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 922C311F8D0;
	Wed, 01 Oct 2025 13:43:20 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3uIq-00000005L6Y-2DFh;
	Wed, 01 Oct 2025 13:43:20 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] ACPI property cleanups
Date: Wed,  1 Oct 2025 13:43:17 +0300
Message-ID: <20251001104320.1272752-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This is a small set of ACPI property cleanups.

The previous set including with the tree-wide changes can be found here
<URL:https://lore.kernel.org/linux-acpi/CAJZ5v0gQ9vnT+Z8zryEausp-2xX7HocoBgwmiptxg7BGiU9C8g@mail.gmail.com/T/#t>.

No functional change intended.

since tree-wide set v2
<20250924074602.266292-1-sakari.ailus@linux.intel.com>, WRT. this patch:

- Don't use kernel-doc functions to document static functions in .c files.

- Use more robust algorithm for enumerating sub-nodes (thanks to Laurent).

since v1 <20250916160129.3955410-1-sakari.ailus@linux.intel.com> (entire
tree-wide set):

- Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
  first.

- Add missing parentheses and kernel-doc Return: section in
  acpi_get_next_present_subnode() documentation and move the Return
  section: of fwnode_graph_get_endpoint_by_id() to the end of the
  documentation section (new patch for the latter).

- Use device_get_next_child_node() instead of fwnode_get_next_child_node()
  in flash LED driver drivers.

- Rework iterating port nodes in acpi_graph_get_next_endpoint() as
  suggested by Andy (new patch).

Sakari Ailus (3):
  ACPI: property: Make acpi_get_next_subnode() static
  ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
    only
  ACPI: property: Rework acpi_graph_get_next_endpoint()

 drivers/acpi/property.c | 26 +++++++++++++++-----------
 include/linux/acpi.h    | 10 ----------
 2 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.47.3


