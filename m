Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F0677CED
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAWNrg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 08:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjAWNrX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 08:47:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD2274B1;
        Mon, 23 Jan 2023 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674481618; x=1706017618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zIJ+8QFxdJv20vfJDFS1O/q0SqmyJ4JFUQEDctJGrrY=;
  b=CY9QEEsYOrKZ1ACC4kyLxuT525HOezMK599T+h8G3sFk4Q9ARTJk0IAu
   h7mnk27cjDf+A0sU8mlE9Pd50Q4RUHexXq12iYJFvz/KAfgF1VMBR0je7
   WLwLZCVIM0QdgPUw+0UsX+spIw5vWvSiwk5TT7r5yrVWgh6B3v+ny2Or7
   sqMxbpLZTtTqt2sKhiKkFI4ZErEv6AiBGVQOE+Rif5AhdpdC0xZy3vEh2
   ckENdXixB51tYbMkZ85i8nClizxSsq0Ich87KIQDw8tIOVX3hXwufkL/9
   2jA3Qdi/FZ0D/gnvXW86UhsasyCnZcgB4xzGCbRLNZowDCMrdUrs7UKJa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390542156"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390542156"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785601919"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="785601919"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:36 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id AF2B1204A8;
        Mon, 23 Jan 2023 15:46:33 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pJx9X-00173H-V5; Mon, 23 Jan 2023 15:46:27 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v2 0/8] ACPI _CRS CSI-2 and MIPI DisCo for Imaging support
Date:   Mon, 23 Jan 2023 15:46:09 +0200
Message-Id: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/mipi.c      | 761 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c  | 128 +++++--
 drivers/acpi/scan.c      |  33 +-
 include/acpi/acpi_bus.h  |  61 ++++
 include/linux/property.h |   7 +
 7 files changed, 972 insertions(+), 29 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

-- 
2.30.2

