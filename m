Return-Path: <linux-acpi+bounces-17040-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D279B59CDD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12073B23C8
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05637C0E2;
	Tue, 16 Sep 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJrcPJWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BF374291
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038507; cv=none; b=tjEVRi1C8jkfK5uoBEDJ69MyXs9vkCWY0Gk7Q0NP1u/P/jURSlLwmlesYceGWaTxWFIRUZWDTwD4fWTCYRBqhhCZpWY+bPF3r0KU8ek97ufAi591HAFApc6hS+S4YZLGcvjIEBQDaRusNWF3734xptrnYl/bXYA027R6we1hLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038507; c=relaxed/simple;
	bh=cf6lF7LyfM0LBjXxUF4rOsMMBytA+CYr8xHGZ4FGSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU/XubxjegWY4U7n/ZAPlZpMXb5ZbbO8Q0PseqTD6I1XIIUp8jZ1MRpBJLPCwASYo53+QFA4GfPiJzDlTou1STGgf7wjnvcgcSXxPOFN4GjohbAJ8yADQXosomN7u4K23DCt8F0KZ7g3nx/jLuUFhbJEYgaCBrRyay3G3jRTfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJrcPJWN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038506; x=1789574506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cf6lF7LyfM0LBjXxUF4rOsMMBytA+CYr8xHGZ4FGSls=;
  b=MJrcPJWNPfUKRHr/fTRvIC3kYtlT7CqLWHKevyWkM6OylePut5UoGe64
   Tnd5hKscPiPoCdOQPH6JCLbcP94yR6GghEtpnSyZJRxbH8YeEGcRgRmCh
   cqzD6XoxnGYdCyWSatd/mQtV3GFLblq+8hF5IV52xOwK3UpuAprPIPy83
   huvHJq4zca1V4zt5pItcWeDnhLvBI7IsYrww2hUAvdUvX1hbkRWJ0UZkM
   h2mPtQGGgTXzvL1aXRl+uqElsmZArZCVl5hPPeDzsYPbGvWLCw2NqRXdr
   lq/fhqaLbwKTcEbAtu33uHR1X6eXSS92WxKDS7ybRckS9c0hydUGwb4ic
   g==;
X-CSE-ConnectionGUID: X7JTMARnSnix+7T0Rf54Eg==
X-CSE-MsgGUID: Anz7Q9ZoQe2SQ7jAwIy14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422981"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: 8IwIXLLMSCKzbie262KCPA==
X-CSE-MsgGUID: SLe7rRg9TGyxCzal7UxJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091540"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 787FF121F07;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0B-1tP7;
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
Subject: [PATCH 08/14] net: lan966x: Use fwnode_for_each_child_node() instead
Date: Tue, 16 Sep 2025 19:01:23 +0300
Message-ID: <20250916160129.3955410-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 7001584f1b7a..e8f9bf96a63b 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1190,7 +1190,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x_stats_init(lan966x);
 
 	/* go over the child nodes */
-	fwnode_for_each_available_child_node(ports, portnp) {
+	fwnode_for_each_child_node(ports, portnp) {
 		phy_interface_t phy_mode;
 		struct phy *serdes;
 		u32 p;
-- 
2.47.3


