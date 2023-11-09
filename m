Return-Path: <linux-acpi+bounces-1372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1337E6843
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B53B20B14
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E4199A9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMlNfrDG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6F15EA2
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:10:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A92D76
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699524619; x=1731060619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MHU+fyoufTir+BJ1gfuLXANHyf3wMJwUVmDGwBgKOJQ=;
  b=cMlNfrDGaEqr8eDMwbEStGHgxfIHMukoKMcSkh5oQQb/UP26N1s/Vlt6
   CB7ZwJ0mVYcRdL8GTKMZLYnJYJJAmW7fQpU9XSFSTMbEiGZ5e0/P4EhS7
   4M+McEXcBNjBthIff5B97qot+9TsYTu0LkDACrzrnOZ+p5riupRZaE31z
   f8Yq5f7f1DA/mPeji9jbvRhNZut59a1GP7ZEKGCsgCZRb9dNEHD5i7zS0
   rTo76W0hl6OYMJQ6cmDmdfanWtEMXPRI32gkmkoISUT9YKx+Ks8RenfpH
   R+u+9k4ZB/i6fZWU70YSFlDaCgJdxBib4pPQ2HzAtSEPCCvvS3SFWuwOw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369289667"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369289667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756841699"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="756841699"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:16 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 58CF311F82E;
	Thu,  9 Nov 2023 12:10:13 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v4 0/3 Make fwnode_property_get_reference_args accept NULL args
Date: Thu,  9 Nov 2023 12:10:07 +0200
Message-Id: <20231109101010.1329587-1-sakari.ailus@linux.intel.com>
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

Resending, with Greg cc'd this time.

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


