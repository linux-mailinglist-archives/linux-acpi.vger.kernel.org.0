Return-Path: <linux-acpi+bounces-87-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C167ADD23
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB85128163C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF81B270
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:31:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5621B26E
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 14:49:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE410D;
	Mon, 25 Sep 2023 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653360; x=1727189360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kKM0C1N1K+zAFPffptjtDRXafSmi9wPq9IOl4rSEZ+w=;
  b=KU7oTXe589HSPT7zJQNqxkMYszEiWVPVwB3Ob9lQJeP2teERWklZmlKK
   BbpTAIA8nQPi3RMDrja5G3Y53A41uLYcfL35dqkfr2aSMmN9AFYtxfedX
   YORFQpdbhlw6Rm8bYgf1iyNST45NOgTM/FBNyb6l/fqXbiiIyQP1rkJs3
   22YFkdUIanBMjGGSAxEcrSo6RAAoNRE6v+jPCUTglXIw83Vpd3SFKQasG
   pbLV4I71ZlpsZFFvDYI09CygX7Bat/LHJT5mXHEMnwsP6TeRICVLGZx4j
   9ffGpeOooFxyVVpLhbcyDbtbvFuF35k8+ngqThQzctUWH2/SzAs2w6a7S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378547987"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378547987"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409451"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409451"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:17 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@intel.com,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rui.zhang@intel.com,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus concepts
Date: Mon, 25 Sep 2023 17:48:35 +0300
Message-ID: <20230925144842.586829-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some devices implement ACPI driver as a way to manage devices
enumerated by the ACPI. This might be confusing as a preferred way to
implement a driver for devices not connected to any bus is a platform
driver, as stated in the documentation. Clarify relationships between
ACPI device, platform device and ACPI entries.

Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 56d9913a3370..f56cc79a9e83 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -64,6 +64,19 @@ If the driver needs to perform more complex initialization like getting and
 configuring GPIOs it can get its ACPI handle and extract this information
 from ACPI tables.
 
+ACPI bus
+====================
+
+Historically some devices not connected to any bus were represented as ACPI
+devices, and had to implement ACPI driver. This is not a preferred way for new
+drivers. As explained above devices not connected to any bus should implement
+platform driver. ACPI device would be created during enumeration nonetheless,
+and would be accessible through ACPI_COMPANION() macro, and the ACPI handle would
+be accessible through ACPI_HANDLE() macro. ACPI device is meant to describe
+information related to ACPI entry e.g. handle of the ACPI entry. Think -
+ACPI device interfaces with the FW, and the platform device with the rest of
+the system.
+
 DMA support
 ===========
 
-- 
2.41.0


