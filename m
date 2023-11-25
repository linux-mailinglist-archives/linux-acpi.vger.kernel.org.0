Return-Path: <linux-acpi+bounces-1826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BF7F8EC2
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Nov 2023 21:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B4280DBD
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Nov 2023 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073118F79
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Nov 2023 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS/v8cey"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F12C5;
	Sat, 25 Nov 2023 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700941175; x=1732477175;
  h=date:from:to:cc:subject:message-id;
  bh=1ixJ2VaP+B9u4S9RPgWXeMXdCfeafWSKYeIPVy4gVus=;
  b=bS/v8ceysvkXhGToN6vK/nxianqhIfEdHizp+NVz31ko3nG4qR+MA7iD
   iTDTcJ5M6eOPDu/rnpU3LkvL131PGC2glkJZMb8rOvzQL+Lu9VH7lweky
   DMzw4BVnsnZEXskgjXbsaFIjI+DiPXpX3865qZ9dPzDKX+7dZSA4hqEHT
   vHYBmlKZnvTcnR9ncVa3pnazIZixVruCHEhYQU6LPvGa/hXfBIt0MAfsl
   wrW8blZAUrbCtgz1kuh5MKpk9XtLRto7tIFst3BUa2X964kRz5hMu83yF
   xBcDATo0WtBwfav4srrWB9h29yF2L9m4K0hEQlgvbJCtTqxbbmsmWT48H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="382932312"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="382932312"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 11:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="771537927"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="771537927"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2023 11:39:32 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6yV0-0004Li-2c;
	Sat, 25 Nov 2023 19:39:30 +0000
Date: Sun, 26 Nov 2023 03:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9795b7a7c21ef0f9dca1ace3954513e2b1e58c96
Message-ID: <202311260336.TbgcyQSW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9795b7a7c21ef0f9dca1ace3954513e2b1e58c96  Merge branch 'acpi-thermal' into linux-next

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
|-- arm-mvebu_v7_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-001-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-002-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-003-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-004-20231125
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
|-- arm64-randconfig-004-20231125
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
|-- csky-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- csky-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- i386-buildonly-randconfig-002-20231125
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
|-- i386-randconfig-006-20231125
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
|-- loongarch-randconfig-002-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- microblaze-randconfig-r113-20231125
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
|-- powerpc-mpc834x_itx_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-001-20231125
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
|-- powerpc-randconfig-002-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-003-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-002-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- sparc-allyesconfig
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
|-- sparc-randconfig-001-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc-randconfig-002-20231125
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
|-- sparc64-randconfig-001-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-002-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-001-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-004-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-005-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-006-20231125
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
|-- x86_64-randconfig-011-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-012-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-014-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-015-20231125
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
|-- x86_64-randconfig-073-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-074-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-075-20231125
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
`-- x86_64-randconfig-161-20231125
    |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
    `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
clang_recent_errors
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
|-- powerpc64-randconfig-r131-20231125
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
|-- x86_64-randconfig-004-20231125
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

elapsed time: 1459m

configs tested: 221
configs skipped: 2

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
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20231125   gcc  
arc                   randconfig-002-20231125   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231125   gcc  
arm                   randconfig-002-20231125   gcc  
arm                   randconfig-003-20231125   gcc  
arm                   randconfig-004-20231125   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231125   gcc  
arm64                 randconfig-002-20231125   gcc  
arm64                 randconfig-003-20231125   gcc  
arm64                 randconfig-004-20231125   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231125   gcc  
csky                  randconfig-002-20231125   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231125   clang
hexagon               randconfig-002-20231125   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231125   gcc  
i386         buildonly-randconfig-002-20231125   gcc  
i386         buildonly-randconfig-003-20231125   gcc  
i386         buildonly-randconfig-004-20231125   gcc  
i386         buildonly-randconfig-005-20231125   gcc  
i386         buildonly-randconfig-006-20231125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231125   gcc  
i386                  randconfig-002-20231125   gcc  
i386                  randconfig-003-20231125   gcc  
i386                  randconfig-004-20231125   gcc  
i386                  randconfig-005-20231125   gcc  
i386                  randconfig-006-20231125   gcc  
i386                  randconfig-011-20231125   clang
i386                  randconfig-012-20231125   clang
i386                  randconfig-013-20231125   clang
i386                  randconfig-014-20231125   clang
i386                  randconfig-015-20231125   clang
i386                  randconfig-016-20231125   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231125   gcc  
loongarch             randconfig-002-20231125   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231125   gcc  
nios2                 randconfig-002-20231125   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231125   gcc  
parisc                randconfig-002-20231125   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231125   gcc  
powerpc               randconfig-002-20231125   gcc  
powerpc               randconfig-003-20231125   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231125   gcc  
powerpc64             randconfig-002-20231125   gcc  
powerpc64             randconfig-003-20231125   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231125   gcc  
riscv                 randconfig-002-20231125   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231125   clang
s390                  randconfig-002-20231125   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231125   gcc  
sh                    randconfig-002-20231125   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231125   gcc  
sparc64               randconfig-002-20231125   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231125   gcc  
um                    randconfig-002-20231125   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231125   gcc  
x86_64       buildonly-randconfig-002-20231125   gcc  
x86_64       buildonly-randconfig-003-20231125   gcc  
x86_64       buildonly-randconfig-004-20231125   gcc  
x86_64       buildonly-randconfig-005-20231125   gcc  
x86_64       buildonly-randconfig-006-20231125   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231125   clang
x86_64                randconfig-002-20231125   clang
x86_64                randconfig-003-20231125   clang
x86_64                randconfig-004-20231125   clang
x86_64                randconfig-005-20231125   clang
x86_64                randconfig-006-20231125   clang
x86_64                randconfig-011-20231125   gcc  
x86_64                randconfig-012-20231125   gcc  
x86_64                randconfig-013-20231125   gcc  
x86_64                randconfig-014-20231125   gcc  
x86_64                randconfig-015-20231125   gcc  
x86_64                randconfig-016-20231125   gcc  
x86_64                randconfig-071-20231125   gcc  
x86_64                randconfig-072-20231125   gcc  
x86_64                randconfig-073-20231125   gcc  
x86_64                randconfig-074-20231125   gcc  
x86_64                randconfig-075-20231125   gcc  
x86_64                randconfig-076-20231125   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231125   gcc  
xtensa                randconfig-002-20231125   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

