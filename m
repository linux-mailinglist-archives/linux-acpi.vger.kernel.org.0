Return-Path: <linux-acpi+bounces-1152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064067DF015
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3488A1C20CCE
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C114274
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wk+3lPMh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF2CA4D
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:13:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFBB112
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920003; x=1730456003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wokVdbxVQ+OQerFoCr9ANOErJ7IXkunMQzvGnXwIyBA=;
  b=Wk+3lPMhSHPIXpIy0dFsMTT/igYb/g+mHcpVzu7G0d20bK/yZs2yAJHK
   b4bmwkz6lgcQfbXkWeN1n7bMfUjKBVkCvYpt2nawYK+alVeITqj8unmIK
   oAtu1Tqt1NHLm4XpTLytfh/qX1IFkUTY5wOByKMAP3YythHmHSVkoROLc
   qBOzoatV4wg/S5sE5r0RKqg5LYmoPklmpq3eekNhSHLJWdZlzyqnCwja2
   TH00KSXMIZJE3t7j8i99cf4yK2ETmALqa38j8yy7cGahlL+8pCR+B5EsM
   efISvoZYLWXOGUPXj8QruGoMWvrI/Ah/+tFzm7DYcBKqqYpji8oMFc3KG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7318632"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7318632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904969778"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="904969778"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:20 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 3F66012035D;
	Thu,  2 Nov 2023 12:13:17 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 0/3] Make fwnode_property_get_reference_args accept NULL args
Date: Thu,  2 Nov 2023 12:13:13 +0200
Message-Id: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
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


