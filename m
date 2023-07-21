Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272A875CC67
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGUPsx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGUPsv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 11:48:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBE2D50
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954529; x=1721490529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FOpNTECWJXlTFURxFCaKzG4EeqCkcPi0OxWX6AcnE7c=;
  b=hWE7GDNKns7NmpgWgpImk9moRHdpcOoS+B8B1dS4ya445LUCdhhFNIIh
   RpWZi37lBmAaI5RLfGlGef6jEPDedsNLn4T6eDGEgv8cX+jCcmm3ZUQRY
   e+YMaZ37C77LC8W+Uo5Ld9ih7Y2LbncLrrOshyFr02QtEGCV18NjnHnjO
   s3Cr7SEKCWdjnTNvML7gtYnx88sPglbo076DAMt69WK2SRsbywoCBtwkW
   IMaDQ0LwiHsh1PWB2l09hCCR47rhWAc56RAwTWdKKMZrxmLTv3ITSe96s
   ffeMlI8gQEdgRy0gdoHfzKLW0Vp0ZIjcEcH4LXWJXfj6/4TSyGI7v2Kwt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357043520"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357043520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868275320"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 08:48:48 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, robert.moore@intel.com,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v4 0/4] ACPI: NHLT: Access and query helpers
Date:   Fri, 21 Jul 2023 17:48:09 +0200
Message-Id: <20230721154813.310996-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The goal of this patchset is to enhance existing interface of
NonHDAudioLinkTable (NHLT), that is, accessing device and format
configuration spaces as well as adding query functions for finding
specific endpoints and format configurations. Once that is done,
existing sound-drivers can move from utilizing sound/hda/intel-nhlt.c
to this very code and ultimately the former file can be removed.

It's important to highlight that currently presented implementation is
not final and intention is to first transfer sound-driver to new API and
then provide incremental updates to internal code in drivers/acpi/nhlt.c
to improve reliability and safety.

Series starts with addition of devcfg-access helpers. The main reasoning
for adding access function is inability for a user to predict whether
given space (device config) is valid or not. While inheritance in the
specification is allowed, e.g.: mic_devcfg being inherited by
mic_vendor_devcfg, until size is verified, one shall not be accessing
fields which are not guaranteed by the spec. The only field guaranteed
is "capabilities_size".
The xxx_devcfg structs added here kind of duplicate few existing ones
in actbl2.h. This is mainly motivated by usage improvements -
simplicity, shorten wording. Intention is to have them replacing
existing actbl2.h members in the future.

Follow up is the declaration of acpi_gbl_NHLT. Motivation is to make
sound-drivers life easier i.e.: release them from storing pointer to the
first NHLT in the system internally. Such drivers may utilize
acpi_gbl_NHLT when querying endpoints and formats instead.

Table manipulation functions and macros serve as a base for the
follow-up query functions. So called query functions represent standard
operations performed by user (a sound driver) when attempting to open an
audio stream. These more or less mimic what's present in
sound/hda/intel-nhlt.c.

Changes in v4:
- relocated ACPI_NHLT kconfig in the drivers/acpi/Kconfig to more
  relevant area within the file

Changes in v3:
- uncapitalized acpi_gbl_NHLT
- fixed compilation problems when CONFIG_ACPI_NHLT is disabled
- dropped Reviewed-by tags in the 2/4 patch due to above, those were not
  one-line changes

Changes in v2:
- minor wording improvements in kernel-doc for patch 3/4
- dropped parentheses around loop cursors in for_each_nhlt_*() macros
- readability improvements in compound if-statements within query
  functions
- dropped NULL-checks in query functions

Cezary Rojewski (4):
  ACPI: NHLT: Device configuration access interface
  ACPI: NHLT: Introduce acpi_gbl_nhlt
  ACPI: NHLT: Table manipulation helpers
  ACPI: NHLT: Add query functions

 drivers/acpi/Kconfig  |   3 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/nhlt.c   | 221 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h |  28 ++++++
 include/acpi/nhlt.h   | 212 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1

