Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176068F1FF
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjBHP25 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjBHP2w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAF2B288;
        Wed,  8 Feb 2023 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870130; x=1707406130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w7nLDSVmhGjGGl39vpX4xdsQvfWtr9fgx4jXl/4aWM0=;
  b=dr3ntOlyAkbS9qnL4FWOPUX9CzpcBgUK4+FG83VN+KoX2XCwE87pUqa7
   8wl76R41ppfXNl1phvCZxdU1kOC3flsUPuueEdzWNIQlYtdS4quSbSwQu
   QcDkk2QhVNjlE6zVifZSoS414pjRVa/loyXsjsV/Fh+mv8R9HpCNSY2sC
   sO4flqeozrN+NOTN6Zhvj0Iu+qXECtudGNyMkcXyepuwdNNQAgqJyAUHR
   pxFCRgkoIWpXE1wjMhrPuaqy0M3R35WfwcNveXp0PRi/QjLr0XnNmarmD
   Xu0deoMJiExZ4Dg/mUXhpvJC89xKeBTKW9wseKlrV12X8Z8qFme+/7fl5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182282"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182282"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237831"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237831"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:45 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 01295120D20;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAB-F2; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 0/8] ACPI _CRS CSI-2 and MIPI DisCo for Imaging support
Date:   Wed,  8 Feb 2023 17:27:59 +0200
Message-Id: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all,

Here's an implementation of ACPI 6.4 _CRS CSI-2 resource descriptor and
MIPI DisCo for Imaging 1.0 [1]. What the two basically provide is an
officially sanctioned way to describe CSI-2 connected cameras to operating
system software, something DT based systems have enjoyed for quite some
time already.

The implementation digs the information from ACPI tables (_CRS descriptors
and data + property extensions) and constructs software nodes that are
compatible with Documentation/firmware-guide/acpi/dsd/graph.rst and
Documentation/devicetree/bindings/media/video-interface-devices.yaml . No
specific driver changes are needed.

These patches are on the testing branch of the linux-acpi tree where they
depend on the patch constifying the ACPI pathname argument for
acpi_get_handle() (commit 91fdb91ccca2b48572a1ccf1d382fd599e3e1237).

[1] https://www.mipi.org/specifications/mipi-disco-imaging

since v3:

- Add comments to data structures and functions, code inside functions.

- Use ACPI_FAILURE() for testing ACPI framework function return values.

- Unwrap a few lines.

- Rename list heads as "head", some were called just "list".

- Count ACPI handles related to _CRS CSI2 resources during tree walk.

- Reshape testing for CSI-2 port allocation in next_csi2_port_index().

- Move allocation of software nodes into a new function,
  acpi_crs_csi2_alloc_fill_swnodes().

- Comments: acpi_bus_scan_crs_csi2() is to be called on the namespace
  root.

- Use size_t for this_count variable in acpi_bus_scan_crs_csi2().

- Revert the NEXT_PROPERTY() macro condition to original (the suggested
  one was different).

- Remove u union in init_port_csi2_common().

- Fix val array size in init_port_csi2_common(). This issue was masked by
  the presence of a u32 field in the union.

- Use "-" for copyright year range.

since v2:

- Unwrap a few lines.

- Copy CSI-2 resource source string using strscpy() instead of memcpy() in
  scan_check_crs_csi2_instance.

- Fix GRAPH_PORT_NAME() sanity check bug introduced in v2.

- Fix snprintf() return value check for port node name in
  get_mipi_port_handle().

- Fix mipi-img-lane-polarities reading.

- Cast bit value to bool instead of using ... ? 1U : 0U.

- Get primary fwnode using acpi_fwnode_handle().

- Don't use MIPI_IMG_PREFIX in the array of renamed properties.

- Use tabs for indenting drivers/acpi/property.c authors.

- Add a comment on assigning ACPI device's secondary fwnode and assign
  ACPI device's secondary fwnode straight to NULL when unassigning it.

since v1:

- Update copyright notices.

- Include linux/types.h instead of linux/kernel.h in drivers/acpi/mipi.c.

- Use SWNODE_GRAPH_PORT_NAME_FMT instead of plain "port@%u" in
  GRAPH_PORT_NAME macro.

- Make the condition in NEXT_PROPERTY() macro easier to read.

- Unwrap lines to make them moderately longer than 80 characters.

- Use * BITS_PER_TYPE(u8) instead of << 3 to convert bytes to bits in
  init_port_csi2_common().

- Test ACPI framework call success using ACPI_SUCCESS() instead of
  comparing with AE_OK. Likewise for ACPI_FAILURE and != AE_OK.

- Use newly added SOFTWARE_NODE() macro to construct the root software
  node.

- Use str_has_prefix() to test for a string prefix instead of memcmp().

- Add pr_fmt() macro to drivers/acpi/property.c.

- Move logical or operators to the end of the line in
  acpi_properties_prepare().

- Improve bad node type error in acpi_parse_string_ref().

Sakari Ailus (8):
  ACPI: property: Parse data node string references in properties
  ACPI: property: Parse _CRS CSI-2 descriptor
  device property: Add SOFTWARE_NODE() macro for defining software nodes
  ACPI: property: Generate camera swnodes for ACPI and DisCo for Imaging
  ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
  ACPI: property: Rename parsed MIPI DisCo for Imaging properties
  ACPI: property: Skip MIPI property table without "mipi-img" prefix
  ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support

 drivers/acpi/Makefile    |   2 +-
 drivers/acpi/internal.h  |   9 +
 drivers/acpi/mipi.c      | 806 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c  | 132 +++++--
 drivers/acpi/scan.c      |  35 +-
 include/acpi/acpi_bus.h  |  82 ++++
 include/linux/property.h |   7 +
 7 files changed, 1042 insertions(+), 31 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

-- 
2.30.2

