Return-Path: <linux-acpi+bounces-156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D47AF533
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1E8782833D8
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000571FB5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BFFA3D
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 18:45:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CD11D;
	Tue, 26 Sep 2023 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753942; x=1727289942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wALDOfDch1TypPPb0YRrudhRYM25aDx55qWGrSyEGzQ=;
  b=guiyNTX9wWq2ZDr/h2kpebrT7/oGhhp9gIVi6tQkI1MyXKy22ry/PNVs
   2V5H+pDOZVj+tgrKrf0+CJW7IMpDnNAb3F0IgRFKpRC5XkKYp2YOepRMj
   14kCMbzAGkQ/oh3HnK/Qd9u/6ZRdAW5/cYCa4hPhlKbXFxYiuUPBl8l8H
   F+MkU9eHdgFKq14THWso8M21WC5+vazbiOSzif3Sukm9PFSUkp9i9nf20
   gSDz1sKvLtQPGyHjxPLCjb1HdCw9hLDkEgfxrNoAuwVu9h4sDZLwZxcJv
   RpQquDvdWHfs3pZ/GuxCReHBnwEzKKXdmgV/GbYVBp8V1DXKH47RiSIuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378920251"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378920251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752279630"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752279630"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:28 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@intel.com,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/2] Fix memory leak and move to modern scope based rollback
Date: Tue, 26 Sep 2023 21:45:18 +0300
Message-ID: <20230926184520.2239723-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In acpi_nfit_init_interleave_set() there is a memory leak + improper use
of devm_*() family of functions for local memory allocations. This patch
series provides two commits - one is meant as a bug fix, and could
potentially be backported, and the other one improves old style rollback
with scope based, similar to C++ RAII [1].

Link: https://lwn.net/Articles/934679/ [1]

Michal Wilczynski (2):
  ACPI: NFIT: Fix memory leak, and local use of devm_*()
  ACPI: NFIT: Use modern scope based rollback

 drivers/acpi/nfit/core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.41.0


