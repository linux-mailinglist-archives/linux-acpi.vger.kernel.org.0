Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7951D859
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiEFNCP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiEFNCO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FBE606C4
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841912; x=1683377912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZr81lHBwmVS48mZ2YxKgkzFzlCLFj9XCHoAbU1Kvn4=;
  b=Xe+1gP39WySf9l7jOztbLaJt8qzF3nKutb5hesbt/zErnnlm2T79wRjl
   tXH1l99DxwvSbYVJ+2q/IlKaZs2IedVJadGN6X3yu13HdsluBYBy9QF5/
   ECcqlxILk/U3iDNjngjojyb/9b3Bbpcrq4BUQre9RV92Ek+RxqFUBzuxe
   EBI5TMo9w+lgm172jTxC8Zzxr74/YiWjx45ICetJ9KdTADtriRU1DFr1k
   5ToIGKhD3k3Zf3u6WcA7jMxSBQaseAOjECpgZUk77HjW9qVQjrpBshRW8
   neaCnT4uaKl0ahQcTHvyKuzQdAe6frsypkAfA/HNjV0vS4TsefmPljBzw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268603250"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268603250"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585962208"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:30 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A46892062D;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480R-8j; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 02/11] ACPI: acpica: Constify pathname argument for acpi_get_handle()
Date:   Fri,  6 May 2022 16:00:16 +0300
Message-Id: <20220506130025.984026-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_get_handle() uses the pathname argument to find a handle related to
that pathname but it does not need to modify it. Make it const, in order
to be able to pass const pathname to it.

Cc: "Moore, Robert" <robert.moore@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 include/acpi/acpixf.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b2cfdfef31947..a0592d15dd37c 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -44,7 +44,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
 
 acpi_status
 acpi_get_handle(acpi_handle parent,
-		acpi_string pathname, acpi_handle *ret_handle)
+		const char *pathname, acpi_handle *ret_handle)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node = NULL;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 67c0b9e734b64..085f23d833349 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -526,7 +526,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 					   struct acpi_buffer *ret_path_ptr))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_handle(acpi_handle parent,
-					     acpi_string pathname,
+					     const char *pathname,
 					     acpi_handle *ret_handle))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_attach_data(acpi_handle object,
-- 
2.30.2

