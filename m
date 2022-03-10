Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344794D3FD6
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 04:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiCJDuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 22:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCJDuQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 22:50:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B96D946
        for <linux-acpi@vger.kernel.org>; Wed,  9 Mar 2022 19:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646884156; x=1678420156;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zuLq0j0QluqQstMS5jLUVRl9HizLQhz8nCQqtScJQrc=;
  b=XiQTnUf8EtELYWUVTaOw+UykAW+OyfF3aDmtVsInnXdh2aVvoVtLq8P5
   iIlt/CsgyM7EpCLNbVut4BgQxbSSnfdNAKhkh7NGO5ivsawqf0TqqJxO6
   +kqlus5ccscXskwB2eCIcYOU9SUOY8TnLAE547faVB7ub+8ckwHO/ZXWC
   uoFzZkfUSlJzjSPy7ktJofYfVEu8kTMVK1KK346Nv9OEZkT9zChXirh6C
   4vFTQq6wA8CmF0P44VUfEiwgCPEunNsYy6LKCP+RyjmcXLerX5PPx4dVC
   U7uRh+e50b1WehuH4OYGVp6LRzaoZTVb7hf9PIU7IGRIEm6rx/L+9vcxh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242597705"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="242597705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:16 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="538287010"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 19:49:16 -0800
Subject: [PATCH 0/6] libnvdimm: Jettison block-aperture-window support
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     robert.hu@linux.intel.com, vishal.l.verma@intel.com, hch@lst.de,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 19:49:16 -0800
Message-ID: <164688415599.2879318.17035042246954533659.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The block-aperture-window mechanism was originally conceived as a
mechanism for NVDIMM devices to offer a block-device-like error model
whereby poison consumption within a given transaction window could elide
a machine check and instead set a bit in a status register. This
mechanism was abandoned in favor of just teaching software to handle the
machine-check exception (see copy_mc_to_kernel()).

Given there are no known shipping platforms with this capability.
Jettison this code to make room for incoming integrations of CXL
Persistent Regions with LIBNVDIMM Regions.

---

Dan Williams (6):
      nvdimm/region: Fix default alignment for small regions
      nvdimm/blk: Delete the block-aperture window driver
      nvdimm/namespace: Delete blk namespace consideration in shared paths
      nvdimm/namespace: Delete nd_namespace_blk
      ACPI: NFIT: Remove block aperture support
      nvdimm/region: Delete nd_blk_region infrastructure


 Documentation/driver-api/nvdimm/nvdimm.rst |  406 +++++-----------------
 drivers/acpi/nfit/core.c                   |  387 ---------------------
 drivers/acpi/nfit/nfit.h                   |    6 
 drivers/nvdimm/Kconfig                     |   25 -
 drivers/nvdimm/Makefile                    |    3 
 drivers/nvdimm/blk.c                       |  335 -------------------
 drivers/nvdimm/bus.c                       |    2 
 drivers/nvdimm/dimm_devs.c                 |  204 +----------
 drivers/nvdimm/label.c                     |  346 -------------------
 drivers/nvdimm/label.h                     |    5 
 drivers/nvdimm/namespace_devs.c            |  506 ++--------------------------
 drivers/nvdimm/nd-core.h                   |   27 -
 drivers/nvdimm/nd.h                        |   13 -
 drivers/nvdimm/region.c                    |   31 +-
 drivers/nvdimm/region_devs.c               |  157 +--------
 include/linux/libnvdimm.h                  |   24 -
 include/linux/nd.h                         |   26 -
 include/uapi/linux/ndctl.h                 |    2 
 tools/testing/nvdimm/Kbuild                |    4 
 tools/testing/nvdimm/config_check.c        |    1 
 tools/testing/nvdimm/test/ndtest.c         |   67 ----
 tools/testing/nvdimm/test/nfit.c           |   23 -
 22 files changed, 181 insertions(+), 2419 deletions(-)
 delete mode 100644 drivers/nvdimm/blk.c
