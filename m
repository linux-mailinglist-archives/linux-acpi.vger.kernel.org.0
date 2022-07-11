Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC05700C2
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiGKLhJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiGKLgw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4808BAB8
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538649; x=1689074649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ypwq61mMJ8LaVX5BCtII3+V3oGw4zsujAA02inXbayw=;
  b=iK8HTdwKcjUin04TPBJ0Nu9glATMNOXTCHqNh/tYWEkwR4vvEVN17e6S
   UnUfdX05Cr7AaRaIlIzA3quA13HlZrknelntTeLNa1llfh/f0Vpwh74Fm
   hQgzo/ugWMDuNFZdLBRmSSZrksk965aELQGKkhHBjkkOphaUeD+8mtnXB
   +oJ7Aylk6UrfnrRy71MLEQmqmWHLIaaEqlnoACNlkbx1OH6+oR38E//v8
   9vHf6IofiEyduzXjy/Waz0Ot4E2EDt2bfK5nQ5JPRyrr/Ni3sc08KlNVS
   Dn+lCX0l1IAGHk93vT/tJ8wikdq0fbQciyOQ/fTyvMRXSelxkoYpG456z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="265046036"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="265046036"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="627456551"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:00 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id D5AB7204FB;
        Mon, 11 Jul 2022 14:23:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYP-6p; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 0/8] [PATCH v3 0/8] ACPI: Buffer property and reference as string support
Date:   Mon, 11 Jul 2022 14:25:58 +0300
Message-Id: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

since v3:

- Use bool return type for acpi_tie_nondev_subnodes. Return false on
  failure.

- Print ACPI buffer parsing error references as %*pE (was %s).

- Unwrap a few lines (i.e. non-functional changes).

- Declare local variables for acpi_copy_property_array_uint().

- Clean up buffer size check in acpi_data_prop_read(), add break at the
  end of the default case.

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

 drivers/acpi/property.c | 465 +++++++++++++++++++++++++++-------------
 include/acpi/acpi_bus.h |   3 +-
 include/linux/acpi.h    |   2 +-
 3 files changed, 318 insertions(+), 152 deletions(-)

-- 
2.30.2

