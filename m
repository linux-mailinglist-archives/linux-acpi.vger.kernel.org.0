Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D96652358
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Dec 2022 16:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiLTPBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Dec 2022 10:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiLTPBO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Dec 2022 10:01:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585D1CB26
        for <linux-acpi@vger.kernel.org>; Tue, 20 Dec 2022 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671548462; x=1703084462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eCH+vVzzZOuP/pP9FLSZ/qhBMoVAg7DrcVKiwzyjV1A=;
  b=lr8bGP0rJJWYKeVC5WvqstE7muE6jS/NnyCZeFy4TdxGQNvxbVVAGCFL
   L5E92kKqUbBiiptT2KiWDMVLw4F/AyOY7+Fz/0dgo6+jjSQeZQwCJwupH
   O5aH6lC6kQ8YTEJylWGJYI0s2J4KgbbT4nHLwNmqjugyoNFnZiyJ8CRCi
   cbj53gnYodEK+WclPqMYL4sqI5APunLOzJ+71lCENJo/WuRejzKryNDca
   B7E4uff7JbP5escETWtrZerQW603SARqXTVUBZMvxEt4fHl4VBdFoBseS
   KZAKznpgV6A9681b8JuvkVVIfwFIzMyx4Oh9cOdl7l8F7ApT8KivJoXz0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="346732743"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="346732743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 07:00:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896472622"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="896472622"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 07:00:47 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 716BE20321;
        Tue, 20 Dec 2022 17:00:45 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1p7e7S-006okH-7j; Tue, 20 Dec 2022 17:01:26 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/1] ACPI: acpica: Constify pathname argument for acpi_get_handle()
Date:   Tue, 20 Dec 2022 17:01:26 +0200
Message-Id: <20221220150126.1624988-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_get_handle() uses the pathname argument to find a handle related to
that pathname but it does not need to modify it. Make it const, in order
to be able to pass const pathname to it.

Cc: "Moore, Robert" <robert.moore@intel.com>
Link: https://github.com/acpica/acpica/pull/773
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

