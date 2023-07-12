Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039AC750212
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGLIxm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLIxm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 04:53:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21889B7
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689152020; x=1720688020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C7wAYeWvdZRckHeCTkoQUE5acWOVq3h+KTYQtY/tMAU=;
  b=e6kTcoJJCY07aMdKq2i3ieT1kQDG0Pka6E4Ox+nJIRdm6gr3R5w7+jRV
   AWPwjox35pAZATHWLcxMBhRE1pEFIX0hjlBgzsqfbn5SPUUa9hUnAsr52
   ckPRGccc1B8Nq8XSxuZYSQ9Qm/XKfLTfoVo/HjitNWIHr1RCWYyvcyucQ
   n9CntZ2h4laZfU5nn+z57fZY+BpU2x1RHnMEIISeIVYXH1ou3UqA3Wrjg
   oV3mC70aVqLgb5QURTIzkOS2N/pv6HnqTeRsqkeS3gb2iNjIFIiUb5n2h
   L4EXZJ4JoPTKwp26xCOTFv3cdvAiSBc4jc+KfWzYeKRDDmzJ7ih0SY2Fj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363704574"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="363704574"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 01:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724798334"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="724798334"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 01:53:20 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, erik.kaneda@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 0/4] ACPI: NHLT: Access and query helpers
Date:   Wed, 12 Jul 2023 11:10:44 +0200
Message-Id: <20230712091048.2545319-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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

Cezary Rojewski (4):
  ACPI: NHLT: Device configuration access interface
  ACPI: NHLT: Introduce acpi_gbl_NHLT
  ACPI: NHLT: Table manipulation helpers
  ACPI: NHLT: Add query functions

 drivers/acpi/Kconfig  |   3 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/nhlt.c   | 196 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h |  28 ++++++
 include/acpi/nhlt.h   | 206 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 434 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1

