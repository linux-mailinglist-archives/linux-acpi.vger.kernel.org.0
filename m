Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F56E828D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDSUY6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjDSUYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E62685;
        Wed, 19 Apr 2023 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935752; x=1713471752;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi/+cRiP5twpJFnVkMttJHsIKWLDHj+Sr6u1Wagq1WI=;
  b=n+MVgheUfk7oAesasi6WgBfMzMVeJzMBbbZlHN2UvKzwfBm5FfQZTrka
   0cm7yohnXliUEIkwWUANDSOLs9yoyk6bUvhA+pMgQZj56UHT8FuChj2Pz
   8RU7gcB2WYNqRlEEp2aKCkz2ouKbedaBc7VlvgLil8PhEcfywZLD8dIUK
   eMmI3YFmb3ENK/ufnVbhZ7m51umBRoW6srOjO1JPrAoqz7wHlrLewzwih
   nfyXOmZSdAuMDW5w2YJcs+eukAg+Y2FKmyGZvDApYw9ojHS7HfWDLJcBj
   bwUkdR2AGG3jn0c2o5AOCqozgt+CFe0LyC6QPrbUY4vpvmSu5Q+uPYdAr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347408394"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="347408394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803037731"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="803037731"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:31 -0700
Subject: [PATCH v4 15/23] ACPI: NUMA: Add setting of generic port locality
 attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:22:30 -0700
Message-ID: <168193575089.1178687.8730075132815244419.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add generic port support for the parsing of HMAT locality sub-table. The
attributes will be added to the third array member of the hmem_attrs in
order to not mix with the existing memory attributes it only provides the
locality attributes from initator to the generic port targets and is
missing the rest of the data from the actual memory device.

The actual memory attributes will be updated when a memory device is
attached and the locality information is calculated end to end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d11b4231ae92..ad0cf21700a1 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -367,6 +368,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
+					if (*(target->device_handle)) {
+						hmat_update_target_access(target, type, value,
+								NODE_ACCESS_CLASS_GENPORT);
+						continue;
+					}
+
 					hmat_update_target_access(target, type, value,
 								  NODE_ACCESS_CLASS_0);
 					/* If the node has a CPU, update access 1 */


