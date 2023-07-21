Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15175C381
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGUJsq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 05:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGUJsW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 05:48:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E130DD
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932865; x=1721468865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z+qMhSXihx3+AvTmY3Xg6lH1noCHVwK9rSIcEO2Lt/0=;
  b=J7E/l2krWWOqcv01JLfIIsq2kt76lD+cfOeQ7jrnkxVvNGi44gepJtZE
   WaMH+XwyQZ5mc9JpYa8LzZu5UOJyUZZ/V25EEfetZ67rE61KQ6h9JhEa0
   spp0EI8yjsbED32rcHv/M26XsMwr3tuWrITa/btdByZgLycKP58uv3KF0
   nUMKZgsTZlY9L5T5Mw4WWcxRlCKhBhdMmUg8mghuUnYY+8usC7ywRZHTd
   dnWbppVacpLyD4a2KjnsZhOAp64Syu7SOB+K2ql+zXeA2b00wCA+z77iy
   SnwU45CcUsNlyoMOB2h3aFghyqmQzoIq5SkJZAFSYJs5HdDFNNVaLToS/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367022164"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367022164"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055508021"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055508021"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 02:47:29 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 0/4] ACPI: NHLT: Access and query helpers
Date:   Fri, 21 Jul 2023 11:47:18 +0200
Message-Id: <20230721094722.300586-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

