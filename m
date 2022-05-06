Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988751D85B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392203AbiEFNCQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392141AbiEFNCP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7006338C
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841912; x=1683377912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PX2fTtw9stqx+nodH42XF2tRh9CfUYugeGA/EAUIRV4=;
  b=H4Pmd2TolC/u0xa+64o9FKY61ppQ1Oof5gwcVvmgO1kSSxXgJ3s0Et1d
   RnQyL0i+bYa9n7l7pIqDTARdr0+qBZ62YTTBXSGWD3KxnO2bGQvzLReui
   cMtlpGrHNKfWhEbFLGBrONkRMialXSf8efAmbp86NB17aE8/H+rCifRFc
   lo0aTuwihnLp9vcqVaik7bq/26yrhuZuoxf16QgUupsW6I13OxNGv1qSw
   s9b+fAU91DlM0KKA42ANBooRYgwC7Re/eyoI5vSGj2NTXEqbKDx2r7Vxd
   SPioHIJJZ/hIQfTy8iI4Epj72D6LluNh/P7FcXVo2MDe417H0lFMBlMIe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250459075"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250459075"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537875687"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:30 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 9672F201D7;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480M-5Z; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 00/11] ACPI: Buffer property and reference as string support
Date:   Fri,  6 May 2022 16:00:14 +0300
Message-Id: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello everyone,

This set adds support for _DSD buffer properties (specified by DSD Guide
<URL:https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.md>) as well as
support for references as strings. Reference property type was previously
supported for device objects only, whereas string references enable
referencing also _DSD sub-node objects --- also included in the set.

The ACPICA patch has been submitted to upstream but not merged yet.


Sakari Ailus (11):
  ACPI: property: Return type of acpi_add_nondev_subnodes() should be
    bool
  ACPI: acpica: Constify pathname argument for acpi_get_handle()
  ACPI: property: Tie data nodes to acpi handles
  ACPI: property: Use acpi_object_type consistently in property ref
    parsing
  ACPI: property: Move property ref argument parsing into a new function
  ACPI: property: Switch node property referencing from ifs to a switch
  ACPI: Initialise device child list early to access data nodes early
  ACPI: property: Parse data node string references in properties
  ACPI: property: Unify integer value reading functions
  ACPI: property: Add support for parsing buffer property UUID
  ACPI: property: Read buffer properties as integers

 drivers/acpi/acpica/nsxfname.c |   2 +-
 drivers/acpi/property.c        | 517 ++++++++++++++++++++++++---------
 drivers/acpi/scan.c            |   2 +-
 include/acpi/acpi_bus.h        |   3 +-
 include/acpi/acpixf.h          |   2 +-
 include/linux/acpi.h           |   2 +-
 6 files changed, 382 insertions(+), 146 deletions(-)

-- 
2.30.2

