Return-Path: <linux-acpi+bounces-12014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76476A5992C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A19B168C53
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80A22E3E2;
	Mon, 10 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGs9iCzJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DF22D79D;
	Mon, 10 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619327; cv=none; b=XtW41eraxXffdQvsniZ4b3/dKy0yqQYtiQh9mOJC/X9Du9Olupyh6b6mR2ypqwiRfYl4+iTTXYumId8mnayWj6ZtfyglgVLdzl8yotkSFXI9+t9Ddve0j65Uk10JTyGMRH96cJIj/szI1oa9JCXQRqNvvTcuyl3XjS393v7+XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619327; c=relaxed/simple;
	bh=kZtafXHrGb7mXS4bvxISt7O8W/fzSi4801NL/wtYIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FICje0UnLZ4//Sf9PHBPxJDlm7Xmw82Uhlwg0GvTOsSBVFXeSlZX/4EMjqXX2pF9ZHYvAixuH04O/iJvu9VZm0R8lryMw2p5C1e3IqEK17NO67ilfiwxxqQX6GDUCB6ezLuaUgoAIR3bhMdiVCz4867zLxF7TSszwzJBcpQtQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGs9iCzJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741619326; x=1773155326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZtafXHrGb7mXS4bvxISt7O8W/fzSi4801NL/wtYIkE=;
  b=iGs9iCzJdcTix69aICGUraExy3DK9OAFgEAqEFSqsHKY3Hcniu+0Rmm6
   3x28uW2H84S7O0uYybf1YsdGxP/3UZOvHTj+8ritiKQ/QhhWtxgjHtlZs
   d1KF6KyT3ZT9Sc0jWggtU0g+p52azvM3j1ef7EtY4vbODKV/xeONBZ3Wx
   UhkIb00Bx2w9w6F+3RNJ42LstKwMUnbufHBIpHKcXlgBpWwcXBSwEi1sn
   q/zhU8GEhNUz+bs2qqw1q+XArYoymgLlWlxGayCrqx+oXn76paDOEKx4Q
   nH8lUoi/9TR6cVVa1MYJKkEeeGZNzRYm15Uf4em5llKaMs7x998vPYPjy
   w==;
X-CSE-ConnectionGUID: fNKlSjufSSegG6GtCF7SCg==
X-CSE-MsgGUID: kDV/KoxNQW6P6NjxhpG2nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42334998"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42334998"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:08:43 -0700
X-CSE-ConnectionGUID: 21gImyG7TTufNq2sz9kIzw==
X-CSE-MsgGUID: +bgqcGd4R9uID+UOQbR6ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119731645"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 08:08:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 05290560; Mon, 10 Mar 2025 17:08:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 4/4] usb: typec: tcpm: Use fwnode_get_child_node_count()
Date: Mon, 10 Mar 2025 16:54:54 +0200
Message-ID: <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since fwnode_get_child_node_count() was split from its device property
counterpart, we may utilise it in the driver and drop custom implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 9c455f073233..8ca2e26752fb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7166,7 +7166,7 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
 
 static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *capabilities, *child, *caps = NULL;
+	struct fwnode_handle *capabilities, *caps = NULL;
 	unsigned int nr_src_pdo, nr_snk_pdo;
 	const char *opmode_str;
 	u32 *src_pdo, *snk_pdo;
@@ -7232,9 +7232,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode
 	if (!capabilities) {
 		port->pd_count = 1;
 	} else {
-		fwnode_for_each_child_node(capabilities, child)
-			port->pd_count++;
-
+		port->pd_count = fwnode_get_child_node_count(capabilities);
 		if (!port->pd_count) {
 			ret = -ENODATA;
 			goto put_capabilities;
-- 
2.47.2


