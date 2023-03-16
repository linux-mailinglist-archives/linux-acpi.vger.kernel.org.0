Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B36BC676
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Mar 2023 08:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCPHGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Mar 2023 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPHGi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Mar 2023 03:06:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC589A90B4
        for <linux-acpi@vger.kernel.org>; Thu, 16 Mar 2023 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678950397; x=1710486397;
  h=from:to:cc:subject:date:message-id;
  bh=ci8vzBFiJ/6eHlk58htxOY9kzden1r0UAPErc9A+pfw=;
  b=R4N/oOdYJkLbzSenY/uvQcq2B/AE0grb0Kry60j4u6Hyl2ZKnE2z3zbT
   uFSeDgF9uEPFmgs79Uyik3q11s6CPRcYzo8xgoLoxhvcmTfHelfYTIdUJ
   1KX7VMMApXv+vlFfX7yyaXc7nrIrIWz8LKOmCKvQDcaw7ptgWZ6Mt1/Sk
   2Mss6mOqOXbaWuXROcmZnB18NZ7z283CAWtSToRLQvWEEepzBjCgw+Wm8
   HpyRJ/ZWvXU9WzX+l/2OhCKycJ4sZpX2Q0asUbIMyRW7LqX1AN8UK7HiL
   GDmKnJJilp2sHsU6q7wPdJChC17YfkX71+5zj9kG2rQdFleCU4z9lgTYL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="326263839"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326263839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853897221"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="853897221"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2023 00:06:34 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.dentz@gmail.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] ACPI: utils: acpi_evaluate_dsm_typed - fix redefinition error
Date:   Thu, 16 Mar 2023 12:47:15 +0530
Message-Id: <20230316071715.2403-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_evaluate_dsm_typed function needs to be gaurded with CONFIG_ACPI to
avoid redefintion error when stub is also enabled.

In file included from ../drivers/bluetooth/btintel.c:13:
../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_dsm_typed'
   57 | acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid,..
      | ^~~~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/bluetooth/btintel.c:12:
../include/linux/acpi.h:967:34: note: previous definition of
'acpi_evaluate_dsm_typed' with type 'union acpi_object *(void *,
const guid_t *, u64,  u64,  union acpi_object *, acpi_object_type)'
{aka 'union acpi_object *(void *, const guid_t *, long long unsigned int,
long long unsigned int,  union acpi_object *, unsigned int)'}
  967 | static inline union acpi_object
*acpi_evaluate_dsm_typed(acpi_handle handle,

Fixes: 1b94ad7ccc21 ("ACPI: utils: Add acpi_evaluate_dsm_typed() and acpi_check_dsm() stubs")
Signed-off-by: Kiran K <kiran.k@intel.com>
---

Steps to reproduce:
1. Apply this bluetooth specific patch - https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/
2. Follow the steps suggedted by lkp bot to compile bluetooth

 include/acpi/acpi_bus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e44be31115a6..fc131b4aee4e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
-
+#ifdef CONFIG_ACPI
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 
 	return obj;
 }
+#endif
 
 #define	ACPI_INIT_DSM_ARGV4(cnt, eles)			\
 	{						\
-- 
2.17.1

