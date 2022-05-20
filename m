Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91A52E4D0
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbiETGLo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbiETGLl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2167954A5
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027099; x=1684563099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=orlb83eA7H/PGnU8lKOkWG+Ot8/twtIaU3BHaJ54geo=;
  b=BRNLii4w09R+2lncX8EaLCUuFvfNJz+aFd8QRG0O11tr8/bUpcU36YO+
   Gq6EeCbJlGeMjRBKyVFJnYjp8tdnE/kz1P0RDKcERWM6giPiVG1hgHifU
   NuOSTTgaVY9qpcwr0WzVcP5TXJUcKKdzd0I8c8JFBBN6DxPMPKY64cgco
   eKI5kxMF9GopSbkzJ/NTvZFlPUEA3xGijjZKowpi24bxDKWdU/GVZMWD6
   2BX1pWgNwDJ9tZida8NCq4k5tRayGHcrnjfA08v9J1+BCD6/yrLWhRX6K
   0CowmayD25Orndw07HxEFRQqU6JwUizCE5ZQUe3j92R5YONnSv9dby0a7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="260084996"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="260084996"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="662108525"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:37 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DF912203C9;
        Fri, 20 May 2022 09:11:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005ZX-2B; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 0/8] ACPI: Buffer property and reference as string support
Date:   Fri, 20 May 2022 09:11:40 +0300
Message-Id: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

This set currently prepares for data node string reference support and
does not add it anymore.

since v1:

- Drop the ACPICA, data node child list initialisation and data node
  string reference patches.

Sakari Ailus (8):
  ACPI: property: Return type of acpi_add_nondev_subnodes() should be
    bool
  ACPI: property: Tie data nodes to acpi handles
  ACPI: property: Use acpi_object_type consistently in property ref
    parsing
  ACPI: property: Move property ref argument parsing into a new function
  ACPI: property: Switch node property referencing from ifs to a switch
  ACPI: property: Unify integer value reading functions
  ACPI: property: Add support for parsing buffer property UUID
  ACPI: property: Read buffer properties as integers

 drivers/acpi/property.c | 448 +++++++++++++++++++++++++++-------------
 include/acpi/acpi_bus.h |   3 +-
 include/linux/acpi.h    |   2 +-
 3 files changed, 307 insertions(+), 146 deletions(-)

-- 
2.30.2

