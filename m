Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667E76CBC38
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjC1KNi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjC1KNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:13:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED37A9A;
        Tue, 28 Mar 2023 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998406; x=1711534406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fus+a+KmleeQeycvuRBUvNwNERyzDYM1tSlfjNbNn84=;
  b=Qpb2AIVAp5+dKjtL1O//Ra/K9E4LOH2W+LkvW4anGIM2PuNVKj4hs8/Q
   Epr+i8b0uyAu7cXbN5xWm1bVGhBrZBDGGV91gbWxqzkwyMvR0Wxzk2+Ty
   ljgVMv6DBbbKk35nW+Atzvzjf5lHLIWm6DymLsNeD1MugYi18wscIdpA2
   jl5+01WB6/rHp3GM218qfy5phOm/4fzL/YWAZne8vQ/AuOmBy50oEoT+C
   sOgHAGn/NZYjhvP/6BykHOEk5ZuDz5XCSEm1gn28JHphcbSpr/j51Q06Z
   ECd4mE5QhgltllBblEoVZawdPkFFkKNbcoVZlvyNYdnEanEvmuPtmCVnf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985322"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432629"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432629"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:07 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 2D26711F937;
        Tue, 28 Mar 2023 13:13:03 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 00/10] ACPI _CRS CSI-2 and MIPI DisCo for Imaging support
Date:   Tue, 28 Mar 2023 13:12:53 +0300
Message-Id: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

The first patch of the set also removes the second namespace walk from DSDT
root.

[1] https://www.mipi.org/specifications/mipi-disco-imaging

since v6:

- Avoid including an extra patch in the set. Otherwise the set is unchanged.

since v5:

- Add a high level description of the mipi.c file in the heading.

- Add a missing memory allocation check (thanks to Dan Carpenter).

- Prepend a patch to the set that removes the second ACPI namespace walk due
  _DEP. Instead, the devices that can't be initialised yet are collected to
  a linked list that is revisited after initialising the rest of the
  devices.

- Collect information on _CRS CSI2 records during the same, single namespace
  walk. Effectively since v5, two namespace walks from the namespace root
  are removed.

- The former requires passing state information between functions during the
  _DSD property initialisation, among other things, introducing additional
  function arguments in _DSD parsing functions.

- The order of the patches has changed somewhat, as the parsing process has
  changed. Also a patch has been added to collect ACPI devices for which
  software nodes need to be initialised for DisCo for Imaging.

- Elsewhere, acpi_bus_scan() becomes easier to grasp. Comments are also
  added in acpi_bus_scan() to explain what is being done.

- Change the wrong node type warning from acpi_parse_string_ref() to use
  debug level.

since v4:

- Add leading dots to comment sentences.

- Use UINT_MAX - 1 to denote an unallocated port instead of ~1U.

- Unwrap a line.

- Get ACPI handle into a local variable in acpi_init_swnodes() for easier
  use, use acpi_device_handle() to obtain it.

- Rework "rotation" property checking and _PLD object access.

- Also obtain return value of acpi_get_name() into a local variable before
  testing it.

- Use a local variable for the first element string pointer in
  acpi_properties_prepare_mipi().

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

Sakari Ailus (10):
  ACPI: scan: Remove the second DSDT traversal
  ACPI: property: Parse data node string references in properties
  ACPI: property: Parse _CRS CSI-2 descriptor
  device property: Add SOFTWARE_NODE() macro for defining software nodes
  ACPI: property: Prepare generating swnodes for ACPI and DisCo for
    Imaging
  ACPI: scan: Generate software nodes based on MIPI DisCo for Imaging
  ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
  ACPI: property: Rename parsed MIPI DisCo for Imaging properties
  ACPI: property: Skip MIPI property table without "mipi-img" prefix
  ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support

 drivers/acpi/Makefile    |   2 +-
 drivers/acpi/internal.h  |  41 +-
 drivers/acpi/mipi.c      | 796 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/power.c     |   2 +-
 drivers/acpi/property.c  | 180 +++++++--
 drivers/acpi/scan.c      | 227 +++++++++--
 include/acpi/acpi_bus.h  |  82 ++++
 include/linux/property.h |   7 +
 8 files changed, 1252 insertions(+), 85 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

-- 
2.30.2

