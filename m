Return-Path: <linux-acpi+bounces-2949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CED832E14
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1E1C22EC5
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AA55C3F;
	Fri, 19 Jan 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E95dfP3W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498D54BEE;
	Fri, 19 Jan 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685029; cv=none; b=YnBVh00GqaKj4HBecJlOmLLn3GpluE8aBky1OJQu5PcBEXnSdvaexGFtcPXEfyASBTMHvpp8eS1phhxRfFIWfBdckwvyY1+GvSYqFBbnII4CwboQ2j+ZLZ49LCeokhUNdHGJBsD6l4jqyuUZ2iE2PGy5EFtBVEogyrx7exF7uuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685029; c=relaxed/simple;
	bh=illgvElS4L54f48pGycWwzP4gI4tCyu/+5f3tRJAyDw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kzw5dFZTJWiRw2EUW1jWRipzs6RZCRa0vZUkUT/J6gqYSPD3e9kMrcIRHN/bSf7gqI76dI0v0x4khj+LwYdfAO5Z8GuMilNAdGUmoVtNXe/2/YFr9XCEw7fg1FZmeH3C/h7ZA1GzqXq6/fyGGSNisKPQ+3qSjV1oYot+FVGhMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E95dfP3W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685027; x=1737221027;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=illgvElS4L54f48pGycWwzP4gI4tCyu/+5f3tRJAyDw=;
  b=E95dfP3W3tUakT4dZI6JcoyvC5t+XdQ56ICfBaVgRF5//br9FC5fhixf
   rli52k7YnXSbs5a+RpYfX01yGhkPD4qUGcNfygP05kKs6P9syH5g1itTn
   BPK41oT3yai6+NEtsFPECM/kSOH0q3MVHNObOjC93kRgl26iWeXlsvRlM
   /l0oQabTtemO//9U2PSXUr/bEp7yE6bRBlfKf6jf9bz//FWvZdZmd83JZ
   K3WsjR+UeNuNs0EhXXcg7wiUT7SPqxg9sf0GLH/gqb6P51lJHHEc+L4iG
   8k0jPUdrgRbGeZtkn84UOlskASDyouHEh6vOy+labHK3hkzT4vopaCe+7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487491"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001795"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001795"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:46 -0800
Subject: [PATCH v4 07/11] cxl: Set cxlmd->endpoint before adding port device
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 brice.goglin@gmail.com, nifan.cxl@gmail.com, rafael@kernel.org,
 gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:46 -0700
Message-ID: <170568502654.1008395.13387080015256084169.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Move setting of cxlmd->endpoint to before calling add_device() on the port
device. Otherwise when referencing cxlmd->endpoint in region discovery code
that is triggered by the port driver probe function, the endpoint port
pointer is not valid.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0e4e65cd3806..f63cc5230269 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -826,6 +826,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		 */
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
+		cxlmd->endpoint = port;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
@@ -1369,7 +1370,6 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 
 	get_device(host);
 	get_device(&endpoint->dev);
-	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;
 	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
 }



