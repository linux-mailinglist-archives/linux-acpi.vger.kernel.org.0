Return-Path: <linux-acpi+bounces-311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4097B489F
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D169F1C20825
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADABD2E1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 16:31:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30A9CA61
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 14:35:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A57DD
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696170931; x=1727706931;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v342V+y+GIhN+HsWThKLeqUFXkwOLpg7S9hImipM4d0=;
  b=KaigZ2kxCMK6WNolnx0HAwSVsZSltXf9S5HxgN6SDvGgJNVVxRa2PxLY
   3oyIf6GuQ7rSTsjQxjL3jzkCRwvUnLyCj5yDN/TnSHy5PTP31sxHS+oSp
   VtKx5rncgGXPkNEOqY8dANH/NdWu4TymIOksImTiJiyAYaellhjN+kASH
   JEaOE+JoKYhU74epIZwyO8iYTlADgrTvA5Kz+AAyiK83l+GsyLeTyEdyl
   wQnkfK50kuFPP3n7GAXvoKjLL35Gm9Uk9PTVXu1G+0hD5vAu+o/1/MA1U
   jUxw4HmjsBmqIasMDxBG3qt8FSyHEPvCG6u9xQY6h8Ld14NZz30/myGSt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361906329"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="361906329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 07:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="779717273"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="779717273"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.134.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 07:35:29 -0700
Subject: [PATCH] acpi: Add defines for CDAT SSLBIS
From: Dave Jiang <dave.jiang@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Date: Sun, 01 Oct 2023 07:35:29 -0700
Message-ID: <169617092924.200640.7431532323074217381.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add upstream port and any port definition for SSLBIS.

Link: https://github.com/acpica/acpica/pull/898
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
---
 include/acpi/actbl1.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..a33375e055ad 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -465,6 +465,9 @@ struct acpi_cdat_sslbe {
 	u16 reserved;
 };
 
+#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
+#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
+
 /*******************************************************************************
  *
  * CEDT - CXL Early Discovery Table



