Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409AC691AC3
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBJJGf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjBJJGD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC391C5B2;
        Fri, 10 Feb 2023 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019934; x=1707555934;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9WD4tNW7gQKGRRkfXq/VM0O9cOu0NWS0bJh4WHOXA8=;
  b=S7k9NyP82e1i0I7etgt0z10qYR/eWKFk3yomQcJarzvPZXpnnBvGNzdK
   9myJi9aohZJgVgoB/5xpf2Us49pVSc+aBhLCUIr3cCqOaHFgwKqoKY7AZ
   OHLm3cFtxXP/UVRAr98U8PkY9PjUxHllGHUn/ntJHVwfIwUDPWSwDRij9
   +VnlBU78DDGeZMnADs4JEV3LRjZENkSwVGeLxlvFUWUP6XyUJZDU7/+jF
   11rJjZ1YRVoRIWkpjykDwVlexh38YgiZL7zs8Hay7tUqeQ0CYi4WH+v95
   Qr7vubIii675dYsQmWTjyWlVsm1ZP/ngg3NorHCHcamet3UBWx3yKWaml
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331677022"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331677022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="698364539"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="698364539"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:33 -0800
Subject: [PATCH v2 02/20] cxl/Documentation: Update references to attributes
 added in v6.0
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:33 -0800
Message-ID: <167601993360.1924368.14122892663883462813.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Prior to Linus deciding that the kernel that following v5.19 would be
v6.0, the CXL ABI documentation already referenced v5.20. In preparation
for updating these entries update the kernel version to v6.0.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 329a7e46c805..5be032313e29 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -198,7 +198,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/endpointX/CDAT
 Date:		July, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) If this sysfs entry is not present no DOE mailbox was
@@ -209,7 +209,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
@@ -229,7 +229,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
@@ -240,7 +240,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
@@ -260,7 +260,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/interleave_ways
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) The number of targets across which this decoder's host
@@ -275,7 +275,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/interleave_granularity
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) The number of consecutive bytes of host physical address
@@ -287,7 +287,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
@@ -303,7 +303,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(WO) Write a string in the form 'regionZ' to delete that region,
@@ -312,7 +312,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/uuid
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a unique identifier for the region. This field must
@@ -322,7 +322,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Set the number of consecutive bytes each device in the
@@ -333,7 +333,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/interleave_ways
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Configures the number of devices participating in the
@@ -343,7 +343,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/size
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) System physical address space to be consumed by the region.
@@ -360,7 +360,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/resource
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) A region is a contiguous partition of a CXL root decoder
@@ -372,7 +372,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/target[0..N]
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write an endpoint decoder object name to 'targetX' where X
@@ -391,7 +391,7 @@ Description:
 
 What:		/sys/bus/cxl/devices/regionZ/commit
 Date:		May, 2022
-KernelVersion:	v5.20
+KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a boolean 'true' string value to this attribute to

