Return-Path: <linux-acpi+bounces-2083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188E80165A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 23:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6DC1F2103F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46483619C5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhdCiN+P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC441F1;
	Fri,  1 Dec 2023 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701463264; x=1732999264;
  h=date:from:to:cc:subject:message-id;
  bh=eysuvSwfArXAoZIw5373vtX98VH6jduhvKyIAw83bJM=;
  b=jhdCiN+P93aRE3HLBzo+xRETehYiDyaLjWCKhxlMo1Ui2Yxl/fzt6Suh
   lZaqQFtlUp3TAnqvRq3oeQr3BUVFAoLPUetyXrgPpPMQ70o6UGqGmmODZ
   fXgYPy2iQ/FCLOZjTxAzeYf5eSS+op09NW0TLmxXDX/DUxjtQr6FqUiti
   51jVxiCnIRidkIqjd+7ykGDxDSLPxpisSNLcCe3/3uRkIh+miqMDds/Q6
   33Jf+vJr1Zh7+08u/w6stdgQ4wOue24PrGM/R+oFn0hZ2ODkjnTUN94LD
   AfQ8LuUKXbuOEq1PKk+pFAQxv0gkQqHCqH6r7MftvlWLQvqAEhG6PjkE6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396352657"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="396352657"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804183193"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="804183193"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2023 12:41:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r9AJn-0004Gs-21;
	Fri, 01 Dec 2023 20:40:59 +0000
Date: Sat, 02 Dec 2023 04:40:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6e8a583bdee5da9bc9eb72d08ee2348dfff36f27
Message-ID: <202312020455.nUAcWLw7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6e8a583bdee5da9bc9eb72d08ee2348dfff36f27  Merge branch 'thermal-core' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- arm-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- arm64-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- arm64-randconfig-001-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-randconfig-003-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- csky-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- csky-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- csky-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- i386-buildonly-randconfig-002-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-buildonly-randconfig-005-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-buildonly-randconfig-006-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-defconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-001-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-052-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-r111-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- loongarch-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- loongarch-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- loongarch-loongson3_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- loongarch-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- loongarch-randconfig-r062-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- microblaze-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- microblaze-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- mips-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- openrisc-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-generic-64bit_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc64-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-001-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- powerpc-randconfig-002-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- powerpc-sam440ep_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-001-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- powerpc64-randconfig-003-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- riscv-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- riscv-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- riscv-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- riscv-randconfig-r063-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- sparc64-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- sparc64-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- sparc64-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-001-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-002-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-buildonly-randconfig-003-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-006-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-randconfig-011-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-012-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-013-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-randconfig-015-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-073-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-075-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-101-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-randconfig-102-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-104-20231201
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
`-- xtensa-randconfig-r061-20231201
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
    `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
clang_recent_errors
|-- arm64-allmodconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- arm64-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-allmodconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-011-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-014-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- i386-randconfig-016-20231201
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- powerpc-allmodconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- powerpc-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-allmodconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
|-- x86_64-allyesconfig
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
|   |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
|   `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page
`-- x86_64-rhel-8.3-rust
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-addr-not-described-in-memory_bm_find_bit
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-base-not-described-in-__fraction
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-multiplier-not-described-in-__fraction
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_highmem-not-described-in-enough_free_mem
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-nr_pages-not-described-in-enough_free_mem
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_highmem_page
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-pfn-not-described-in-saveable_page
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-safe_needed-not-described-in-get_highmem_buffer
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-start_pfn-not-described-in-register_nosave_region
    |-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_highmem_page
    `-- kernel-power-snapshot.c:warning:Function-parameter-or-member-zone-not-described-in-saveable_page

elapsed time: 1458m

configs tested: 177
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231201   gcc  
arc                   randconfig-002-20231201   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                        neponset_defconfig   clang
arm                   randconfig-001-20231201   gcc  
arm                   randconfig-002-20231201   gcc  
arm                   randconfig-003-20231201   gcc  
arm                   randconfig-004-20231201   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231201   gcc  
arm64                 randconfig-002-20231201   gcc  
arm64                 randconfig-003-20231201   gcc  
arm64                 randconfig-004-20231201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231201   gcc  
csky                  randconfig-002-20231201   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231201   clang
hexagon               randconfig-002-20231201   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231201   gcc  
i386         buildonly-randconfig-002-20231201   gcc  
i386         buildonly-randconfig-003-20231201   gcc  
i386         buildonly-randconfig-004-20231201   gcc  
i386         buildonly-randconfig-005-20231201   gcc  
i386         buildonly-randconfig-006-20231201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231201   gcc  
i386                  randconfig-002-20231201   gcc  
i386                  randconfig-003-20231201   gcc  
i386                  randconfig-004-20231201   gcc  
i386                  randconfig-005-20231201   gcc  
i386                  randconfig-006-20231201   gcc  
i386                  randconfig-011-20231201   clang
i386                  randconfig-012-20231201   clang
i386                  randconfig-013-20231201   clang
i386                  randconfig-014-20231201   clang
i386                  randconfig-015-20231201   clang
i386                  randconfig-016-20231201   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231201   gcc  
loongarch             randconfig-002-20231201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231201   gcc  
nios2                 randconfig-002-20231201   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231201   gcc  
parisc                randconfig-002-20231201   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20231201   gcc  
powerpc               randconfig-002-20231201   gcc  
powerpc               randconfig-003-20231201   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231201   gcc  
powerpc64             randconfig-002-20231201   gcc  
powerpc64             randconfig-003-20231201   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231201   gcc  
riscv                 randconfig-002-20231201   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231201   clang
s390                  randconfig-002-20231201   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231201   gcc  
sh                    randconfig-002-20231201   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231201   gcc  
sparc64               randconfig-002-20231201   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231201   gcc  
um                    randconfig-002-20231201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20231201   gcc  
x86_64       buildonly-randconfig-002-20231201   gcc  
x86_64       buildonly-randconfig-003-20231201   gcc  
x86_64       buildonly-randconfig-004-20231201   gcc  
x86_64       buildonly-randconfig-005-20231201   gcc  
x86_64       buildonly-randconfig-006-20231201   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231201   clang
x86_64                randconfig-002-20231201   clang
x86_64                randconfig-003-20231201   clang
x86_64                randconfig-004-20231201   clang
x86_64                randconfig-005-20231201   clang
x86_64                randconfig-006-20231201   clang
x86_64                randconfig-011-20231201   gcc  
x86_64                randconfig-012-20231201   gcc  
x86_64                randconfig-013-20231201   gcc  
x86_64                randconfig-014-20231201   gcc  
x86_64                randconfig-015-20231201   gcc  
x86_64                randconfig-016-20231201   gcc  
x86_64                randconfig-071-20231201   gcc  
x86_64                randconfig-072-20231201   gcc  
x86_64                randconfig-073-20231201   gcc  
x86_64                randconfig-074-20231201   gcc  
x86_64                randconfig-075-20231201   gcc  
x86_64                randconfig-076-20231201   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231201   gcc  
xtensa                randconfig-002-20231201   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

