Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693CA66DD61
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjAQMWR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjAQMWQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47312B297;
        Tue, 17 Jan 2023 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958135; x=1705494135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l4eOcNTnJdXR/2FtwbEAGLoee2hI8rvsTp3Ld43Z0BA=;
  b=b4k6B8hOJHska/bC42MRZemHdTBGoYPNeLLP7ZbN3oj1C/SvpWM11Zpt
   7CP/pCZ3dD/GqGDvl/zJSnhS73TEfI1irN8hs5NBZ6goJlVVp5m9gYqud
   4CWboD9R3FSwIAp/sgerbT3M0BB9NbsTBTXyL6/IvhYOO7p6etK99enl6
   auPkBEljnRBz4iTXkrnLZSenwYO5PmEwmvbRfvDXvakpCAyYQHtVBJjpU
   b0RQUdaCQAf70ZIEwNLkm+uZIU8NOziX3Wbhr0YImvy2x5cKZccYm4QjH
   wMqOTr20BcKJg26dfB2lT9fdzFJXjNGdGithF7i7cSZkb05UYaD2yfJhN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920098"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920098"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772030"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772030"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:14 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id AB62B20165;
        Tue, 17 Jan 2023 14:22:11 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgV4-Dd; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 0/8] ACPI _CRS CSI-2 and MIPI DisCo for Imaging support
Date:   Tue, 17 Jan 2023 14:22:36 +0200
Message-Id: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
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
 drivers/acpi/mipi.c      | 769 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c  | 121 ++++--
 drivers/acpi/scan.c      |  33 +-
 include/acpi/acpi_bus.h  |  61 ++++
 include/linux/property.h |   7 +
 7 files changed, 975 insertions(+), 27 deletions(-)
 create mode 100644 drivers/acpi/mipi.c


base-commit: 837dc62247d5e50a0724af2001f070962300c87e
-- 
2.30.2

