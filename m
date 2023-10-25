Return-Path: <linux-acpi+bounces-955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1F7D6BE7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FED1C20C65
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3D27ECF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh9Gv0dT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E901273D1
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:18:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EE18E;
	Wed, 25 Oct 2023 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232718; x=1729768718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxS//e/ZqjIB0NhbIBluRHpqaStKqMVqrAs7nUrO30A=;
  b=eh9Gv0dTUI1E0jFNHkSYABwrN+ihY+6BYLLbG5iBBlZwxgJTt1ST2VuX
   Q2J2j5uLjkwfuhj/ewWJMPu03pgshcH6ozOb2FCxXwnk0Z4yHQYBW1+pe
   UFmwrpicpCe9CqyV2zbjzlDbCJX8RSWMrgJeUMfN8vyX4xA/1RPVbT1pl
   Gt87B8Amnf7ZYt+oUPFS9sPS+7rX8fGukFfNJESG1Cm+Za4vfkx5cLO1w
   QIcgKGaepK+J/OBwJPJYj2UEjfggL6qDy5LI+IJYw/LsAkeFL7QaCMib/
   5t/dOYdtdif0BYkfABZMDBecNHUj2hAuXvAP73jATyhs0RXmSWfNZSLRK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154641"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154641"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425139"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425139"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:28 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 6/6] ACPI: acpi_video: Fix holes in acpi_video_bus
Date: Wed, 25 Oct 2023 14:18:06 +0300
Message-ID: <20231025111806.2416524-7-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As identified by 'pahole' utility there are holes in acpi_video_bus
struct. Rearrange elements to get rid of the holes. Put elements
biggest in size first, and one-byte elements later.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bfc7f51a527d..1e10d5b748b2 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -155,19 +155,19 @@ struct acpi_video_enumerated_device {
 
 struct acpi_video_bus {
 	struct acpi_device *device;
+	struct acpi_video_enumerated_device *attached_array;
+	struct list_head video_device_list;
+	struct mutex device_list_lock;	/* protects video_device_list */
+	struct list_head entry;
+	struct input_dev *input;
+	struct notifier_block pm_nb;
 	bool backlight_registered;
 	u8 dos_setting;
-	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
 	u8 child_count;
 	struct acpi_video_bus_cap cap;
 	struct acpi_video_bus_flags flags;
-	struct list_head video_device_list;
-	struct mutex device_list_lock;	/* protects video_device_list */
-	struct list_head entry;
-	struct input_dev *input;
 	char phys[32];	/* for input device */
-	struct notifier_block pm_nb;
 };
 
 struct acpi_video_device_flags {
-- 
2.41.0


