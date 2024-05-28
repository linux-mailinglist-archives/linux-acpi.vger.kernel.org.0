Return-Path: <linux-acpi+bounces-6023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D718D1696
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E9EB22A96
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B7E13D246;
	Tue, 28 May 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+oxbp/z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE113CA8C;
	Tue, 28 May 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885870; cv=none; b=ojAPFEjDepgovGwKxN+GR8gdkOMrwZ9CDi/CusASpBZ6CfrvgvvU+TynWp2oElqBVQccL8f2VubF/qjK4gkOaa/JovIrObThDvrXoNSD7xHfEErBbmNGQ9U82S/+GAStVAax+CCfD90CuWRpf60LeUR4sZ3K5b7KKV1K3WCn5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885870; c=relaxed/simple;
	bh=ydSlw6qJhZ+PMwAN+v0YFHLkW9KgfIeaM/bmXs0fKWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PE2Ip1IEGADOCUdUM21FfBU0FqeKALN2tp+maY/CUmJmea5+WdYC79ZNW8nadf/YiQFuxgsDagrqU1QaqCNE42EaP4l4KBk6cesIhszEzjaqj7sp5m4LYYst5duex1wQ0z5kZ923R9ZP4O4CExYosRbe4Bka29Pl4gyE9ntYxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+oxbp/z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716885869; x=1748421869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydSlw6qJhZ+PMwAN+v0YFHLkW9KgfIeaM/bmXs0fKWE=;
  b=D+oxbp/zHSNaCcW/G14acQ3Vx04kHUY7j0AnmJp1E28tr075PwSpy/MJ
   3ycn0z6xmKJQLVJwG5OKo1I+1B47W3FO2+Sn1vuGM1UTG13xQlTbcvIqi
   0YEMy6Bx8ipsbvjHAZPnFR7vqxq3XOAL+Ooq2KMufLPP2xHpCNibORoMV
   M8q8UO6cXAD3xWMJTSdUe/paOWpB6uFyyO1G93wcJdBi8MqDWax5XbUNV
   HAdf3OLAttFW4+v+Nh3QS3eOnWJ/D/2c5IcSvRikgfYUfJNhI1l785qf/
   KyJrYOlxj6KpQivxBOlNmRgFvRoxw/dri4YP8YjNJ1cafilrdFcLWT+aB
   g==;
X-CSE-ConnectionGUID: 5iPirMN+QqWPz7VXtcrGlg==
X-CSE-MsgGUID: Y4FuMvhdShWVeXC43CLkjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24630021"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24630021"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:44:28 -0700
X-CSE-ConnectionGUID: mk3Ky/zHTI6B2ny+YzcUzw==
X-CSE-MsgGUID: Kya+lZSxRjWVQEMQoEJsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35059195"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 01:44:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 13F9111FA4A;
	Tue, 28 May 2024 11:44:24 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sBsRT-00B0jn-3C;
	Tue, 28 May 2024 11:44:23 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	laurent.pinchart@ideasonboard.com,
	wentong.wu@intel.com,
	linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port nodes
Date: Tue, 28 May 2024 11:44:13 +0300
Message-Id: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
is buggy, just like it is for Dell XPS 9315. The corresponding software
nodes are created by the ipu-bridge.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi,

Could you test this and see whether it fixes the warning?

The camera might work with this change, too.

- Sakari

 drivers/acpi/mipi-disco-img.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index d05413a0672a..bf9a5cee32ac 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
 		},
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
+		},
+	},
 	{ }
 };
 
-- 
2.39.2


