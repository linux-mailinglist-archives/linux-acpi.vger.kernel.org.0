Return-Path: <linux-acpi+bounces-1375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FED7E6847
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A155A1C2040B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C1199A9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5xXrLBQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B9A38
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:10:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08D2D51
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699524621; x=1731060621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2raFpHjB2PaP6prUEiUv6WGseg5qiXtp3vlEzsRSH0=;
  b=L5xXrLBQW1jclprmY+RIJnRBFz4vSUQZ3LM4+vUrFnWO1HA1PX/3AWLv
   NOAP+rBf/U6ny7wifceovi//BxVqUCqnKSyM6IeuxDk8kImDmUdgOUBIS
   JvS8K9zgzwiOO/JnfvzygrsNNxM1tkYOEGj/bJv3BwPl6F1X2Lb5XFzcW
   vXpFJYTtvDrh+JoQsVr45ZIQI2z0131L9PTb+AzA/tsipl9Dm/50N1TXa
   rhAgr68PzH17Cj+H136n2AcYYDEeSmPhBdAtbyXyYDZ/0odBH2JDkUiRM
   09ypAfYL7aNm20TQksvKgzSGj94QNP8vUV5rxghe6opLygF7WRSTylvQA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369289683"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369289683"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756841705"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="756841705"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:19 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1857111FC2D;
	Thu,  9 Nov 2023 12:10:16 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v4 3/3] device property: fwnode_property_get_reference_args allows NULL args now
Date: Thu,  9 Nov 2023 12:10:10 +0200
Message-Id: <20231109101010.1329587-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109101010.1329587-1-sakari.ailus@linux.intel.com>
References: <20231109101010.1329587-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All three fwnode_property_get_reference_args() implemantations now allow
args argument to be NULL. Document this.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..8667b13639d2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -508,6 +508,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
+ *		May be NULL.
  *
  * Obtain a reference based on a named property in an fwnode, with
  * integer arguments.
-- 
2.39.2


