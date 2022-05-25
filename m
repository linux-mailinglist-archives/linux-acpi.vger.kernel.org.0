Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEE533D22
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiEYNB1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiEYNBZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8141A76F6
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483678; x=1685019678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RO2xSRtg/yPif3Ff4n0M2NEw8iR1z52sv4Oj2JYARIw=;
  b=IN+2iLschUxnvL05IvFuYzadMz02N/urIfMaNClF5eRmN9wiUJuKNHk5
   ByLWOSTeN4ydt1slVcKCBC20qa87g7sexIuzjQHWjVkhZSanGH5rnhkbf
   /L4DSmyJoYBMxFezuQj7G1RIafIQA0mccgMh5fwlAWn/LnEBo9M7WzhSZ
   tjwxPYkwkfyEFahvr05HPy6PGng4VyIoEqh/J1oiiCiihdHjNgcFJYevO
   y+Sg8JAffyrpu6rFTO/RWxT8Z4cxYDtNrc88wU3QPcKutFfScHNlgFcOO
   /mQasrKWylGDC966fNzcFKwYQoOmuUoGOPX7KkUQVrjtJBo9q1FoHSkBU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271379836"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271379836"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="820727350"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:00:59 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 732B920506;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003DeV-AJ; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 0/8] ACPI: Buffer property and reference as string support
Date:   Wed, 25 May 2022 16:01:15 +0300
Message-Id: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

since v2:

- Use C99 _Generic() in patch unifying reading integer arrays.

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

 drivers/acpi/property.c | 462 +++++++++++++++++++++++++++-------------
 include/acpi/acpi_bus.h |   3 +-
 include/linux/acpi.h    |   2 +-
 3 files changed, 315 insertions(+), 152 deletions(-)

-- 
2.30.2

