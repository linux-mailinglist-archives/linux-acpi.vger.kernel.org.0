Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86D756702
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGQPBB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGQPBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 11:01:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20286E5E
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689606060; x=1721142060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tEeEnmMMWGmmPyYf2uYTzj8y3MR48t2NpiLeDD+QUmI=;
  b=nQeW/+OcrgQt7qxw9EtpNscsZTrQo1lY0hPPiG94TZwxjL8na0rEyU/X
   coeGcRJfHkhib5Ef9eEr5uWre7BNLmo/2JLRjcUyLNhHWuFi5Vl8EUZlr
   p6DLbKzEJRbnnIiPzxsZ2AsiLA7Dvx2TpNmtAtwMY8ZO2dyIjiOrOqKA6
   7bmRnyqdM9XuuvIJMrs4K67TvxdOs7U19qzczTksTadwUU52Ir/ntW4vY
   Zkc+al4kThiA817xh2A6zSeyzAo/wqj0KcwJISxe5ps+/lHobXrJg2Ixm
   A1TiR2Z7ljCXF6+yVbU3cDO7taDZy4TspkLdqApD0A4BwP59B043hHzui
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345541868"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345541868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726567322"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726567322"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 08:00:53 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 0/4] ACPI: NHLT: Access and query helpers
Date:   Mon, 17 Jul 2023 17:00:43 +0200
Message-Id: <20230717150047.15196-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
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

Changes in v2:
- minor wording improvements in kernel-doc for patch 3/4
- dropped parentheses around loop cursors in for_each_nhlt_*() macros
- readability improvements in compound if-statements within query
  functions
- dropped NULL-checks in query functions

Cezary Rojewski (4):
  ACPI: NHLT: Device configuration access interface
  ACPI: NHLT: Introduce acpi_gbl_NHLT
  ACPI: NHLT: Table manipulation helpers
  ACPI: NHLT: Add query functions

 drivers/acpi/Kconfig  |   3 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/nhlt.c   | 187 ++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h |  28 ++++++
 include/acpi/nhlt.h   | 206 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 425 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1

