Return-Path: <linux-acpi+bounces-5930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244078CB626
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53E1282E83
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88706BB4A;
	Tue, 21 May 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcxO7xJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D834168BD;
	Tue, 21 May 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331596; cv=none; b=ja8hyoEGsMpHSAmPcJzzA5kSkONJz6JvlPMAKhw551Z9cRMVcpBfAtHQicEMvenCWXktK+5Sq/W+5U9OrPlKpLy4pykWyLBJts9IwS8/XPRPoOwxpauvYjGgOtGHnNHw1B2/m4U6yGEDKq4VorkY/N3dvMLSXqUfxBc2fsd9KNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331596; c=relaxed/simple;
	bh=BcrLjbagQ0OOp0tcnj3iWcflKGe3jg94wrP0GyeJOLs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=gvM4RQGw+wt4YKvTVd1tOaM95m/2iniyNR9RDeAAazNB0J+0V0XGYmKyfyzBwhFJvjzxtEGKo8A4A5kCP9T6eZ7f676j9h5BHAUyyCPdE/T9j5grynJ9pElTQoT+8w2wS8tHqSJqipVjhIMv6H8kECNdbcxr8l7G6rDZBvxvN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcxO7xJ+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716331595; x=1747867595;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BcrLjbagQ0OOp0tcnj3iWcflKGe3jg94wrP0GyeJOLs=;
  b=YcxO7xJ+syfTNFj+HF0qv4MJawZZwiFr1ZsVaDuGbWsQB2FNYkSHWrcw
   xXeeYlDn8yy6k1SPe85HKA8J4N7GjoCa6ra7LnhIkyw0Qe80X6/F47B/d
   nhWPas3yUNUL+bC7fYLbNwwXvDraa9kgm4DR3tCjT18cAtDLfVQ40m4zr
   PuCfCka7/oqGp0+QRr5pMC0xW4qH/ijdNgYk4b4t9PijdfEw8SHb5flKX
   PVYVOAnTfPX39oUXiFUO067N/u1rVyKqV9S+9ucFRt2TYCf3xgrvujYRJ
   3kHV4BXhSR1SPytHzGiscBGZgksywhjGZLVRuzO1FnCsOYLeOQgmNY8Jq
   w==;
X-CSE-ConnectionGUID: EuX04l8JRQihhpkqplyJBg==
X-CSE-MsgGUID: pcmDdE8xRUyXgQzCD8tG8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16393986"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16393986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 15:46:34 -0700
X-CSE-ConnectionGUID: bMFq7YtmRMmrVh0lYRG46w==
X-CSE-MsgGUID: SURD8LBBQ5mU4l1+I0eyVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="70486013"
Received: from kjajulax-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.227.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 15:46:34 -0700
Subject: [PATCH] ACPI: APEI: EINJ: Fix einj_dev release leak
From: Dan Williams <dan.j.williams@intel.com>
To: rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Date: Tue, 21 May 2024 15:46:32 -0700
Message-ID: <171633159194.398195.10059732788629089925.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The platform driver conversion of EINJ mistakenly used
platform_device_del() to unwind platform_device_register_full() at
module exit. This leads to a small leak of one 'struct platform_device'
instance per module load/unload cycle. Switch to
platform_device_unregister() which performs both device_del() and final
put_device().

Fixes: 5621fafaac00 ("EINJ: Migrate to a platform driver")
Cc: <stable@vger.kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/apei/einj-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 01faca3a238a..bb9f8475ce59 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -903,7 +903,7 @@ static void __exit einj_exit(void)
 	if (einj_initialized)
 		platform_driver_unregister(&einj_driver);
 
-	platform_device_del(einj_dev);
+	platform_device_unregister(einj_dev);
 }
 
 module_init(einj_init);


