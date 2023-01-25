Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4767C009
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjAYWlZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYWlX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 17:41:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007A611CB;
        Wed, 25 Jan 2023 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686481; x=1706222481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tDb1Scfh4aTgt6tuliNy2M86smXuglvmLK+G3aH+MSI=;
  b=GLGzvdKhqer8ynQ+2g4rAxPwe3y0Qg0TRzi4mBiODYjvnIYLmLCvmwgY
   aK2BLqcLgGlXLfFWgi3YgWVWXT2uaRzBN6qIYsylInnNHWhV+5ja/H5FK
   yQgxtUzB1YAjDU8mh1HEWS53A/LmCwwNe5NW/hdOiRNKxJgoquLdFeZSR
   8mqSFa774R3BiyQRbOyJem/NIwtz0jgd0P4ya3XvH0qsfJu1HZVL0I0dI
   83HNjFy7XL8sHX6vKC6i5qtyVIKPJq7kcSBxa3WnqzmgcZZCJlWCey9cO
   q+UguNJo1haRJ+4ZL7jEVY6IYVq0lSOcgSzsoUdf9kWs+hwk0ZIifLvGN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="389040010"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="389040010"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786604545"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="786604545"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 370D91221E5;
        Thu, 26 Jan 2023 00:41:14 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pKoS7-001gPG-6K; Thu, 26 Jan 2023 00:41:11 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v3 0/8] ACPI _CRS CSI-2 and MIPI DisCo for Imaging support
Date:   Thu, 26 Jan 2023 00:40:53 +0200
Message-Id: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/mipi.c      | 768 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c  | 132 +++++--
 drivers/acpi/scan.c      |  35 +-
 include/acpi/acpi_bus.h  |  61 ++++
 include/linux/property.h |   7 +
 7 files changed, 983 insertions(+), 31 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

-- 
2.30.2

