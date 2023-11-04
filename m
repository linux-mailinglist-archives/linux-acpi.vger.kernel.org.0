Return-Path: <linux-acpi+bounces-1233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EF7E105C
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371661C2090B
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679622305
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lz5P2KbV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC016414
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 15:51:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DAFD4E;
	Sat,  4 Nov 2023 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699113059; x=1730649059;
  h=date:from:to:cc:subject:message-id;
  bh=Cu6Q+DOWau4zLogEACm8X/WCT+ene9aEnSSzDyNhGE4=;
  b=lz5P2KbVP/YkAu4l2HlKbQ38SkXVh0QWVCQvAeB9hiyNK+9mFUhqseBT
   BmrVnV8Rjzwyr1igPEoqdbSiq5mZU5YZ+KwBTuwyd6M+dlB/MggdNJCot
   2KDTWb90EmZlmTvQIQM7DNeX9o516SaP8YaTyC+YwG0Uh5sDK6LGmOqK6
   W+8Ta+SWjrzpTVYlMKyjbMAeLzk8wN0sUbaFbLqhfP1XzjeQF+6foIcJi
   ZEkvc2hc82LrPB3LcKT2y1sZ8f4q+zWAzY4n+8HUH2Z6CxYf2AEZRvIme
   yAJbuhLnNLHF5wJVW6cRLtuGpf4ne6HVtxs41/fqXoGS+3UcURj2U+V/7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="420212767"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="420212767"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 08:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009103145"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="1009103145"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2023 08:50:57 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzIvH-0004WK-0i;
	Sat, 04 Nov 2023 15:50:55 +0000
Date: Sat, 04 Nov 2023 23:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 742513f48261e9dd7c74e179f96afa1674acfe37
Message-ID: <202311042341.nftbFzf5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 742513f48261e9dd7c74e179f96afa1674acfe37  Merge branch 'pm-cpufreq' into linux-next

Warning ids grouped by kconfigs:

gcc_recent_errors
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
|-- mips-allmodconfig
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
|-- powerpc-randconfig-002-20231104
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
|-- powerpc64-randconfig-002-20231104
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
|-- sparc64-allmodconfig
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
|-- sparc64-randconfig-002-20231104
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
`-- x86_64-defconfig
    |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
    |-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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

elapsed time: 1451m

configs tested: 191
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
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231104   gcc  
arc                   randconfig-002-20231104   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231104   gcc  
arm                   randconfig-002-20231104   gcc  
arm                   randconfig-003-20231104   gcc  
arm                   randconfig-004-20231104   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231104   gcc  
arm64                 randconfig-002-20231104   gcc  
arm64                 randconfig-003-20231104   gcc  
arm64                 randconfig-004-20231104   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231104   gcc  
csky                  randconfig-002-20231104   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231104   gcc  
i386         buildonly-randconfig-002-20231104   gcc  
i386         buildonly-randconfig-003-20231104   gcc  
i386         buildonly-randconfig-004-20231104   gcc  
i386         buildonly-randconfig-005-20231104   gcc  
i386         buildonly-randconfig-006-20231104   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231104   gcc  
i386                  randconfig-002-20231104   gcc  
i386                  randconfig-003-20231104   gcc  
i386                  randconfig-004-20231104   gcc  
i386                  randconfig-005-20231104   gcc  
i386                  randconfig-006-20231104   gcc  
i386                  randconfig-011-20231104   gcc  
i386                  randconfig-012-20231104   gcc  
i386                  randconfig-013-20231104   gcc  
i386                  randconfig-014-20231104   gcc  
i386                  randconfig-015-20231104   gcc  
i386                  randconfig-016-20231104   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231104   gcc  
loongarch             randconfig-002-20231104   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231104   gcc  
nios2                 randconfig-002-20231104   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231104   gcc  
parisc                randconfig-002-20231104   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc               randconfig-001-20231104   gcc  
powerpc               randconfig-002-20231104   gcc  
powerpc               randconfig-003-20231104   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231104   gcc  
powerpc64             randconfig-002-20231104   gcc  
powerpc64             randconfig-003-20231104   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231104   gcc  
riscv                 randconfig-002-20231104   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231104   gcc  
s390                  randconfig-002-20231104   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231104   gcc  
sh                    randconfig-002-20231104   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231104   gcc  
sparc                 randconfig-002-20231104   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231104   gcc  
sparc64               randconfig-002-20231104   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231104   gcc  
um                    randconfig-002-20231104   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231104   gcc  
x86_64       buildonly-randconfig-002-20231104   gcc  
x86_64       buildonly-randconfig-003-20231104   gcc  
x86_64       buildonly-randconfig-004-20231104   gcc  
x86_64       buildonly-randconfig-005-20231104   gcc  
x86_64       buildonly-randconfig-006-20231104   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231104   gcc  
x86_64                randconfig-002-20231104   gcc  
x86_64                randconfig-003-20231104   gcc  
x86_64                randconfig-004-20231104   gcc  
x86_64                randconfig-005-20231104   gcc  
x86_64                randconfig-006-20231104   gcc  
x86_64                randconfig-011-20231104   gcc  
x86_64                randconfig-012-20231104   gcc  
x86_64                randconfig-013-20231104   gcc  
x86_64                randconfig-014-20231104   gcc  
x86_64                randconfig-015-20231104   gcc  
x86_64                randconfig-016-20231104   gcc  
x86_64                randconfig-071-20231104   gcc  
x86_64                randconfig-072-20231104   gcc  
x86_64                randconfig-073-20231104   gcc  
x86_64                randconfig-074-20231104   gcc  
x86_64                randconfig-075-20231104   gcc  
x86_64                randconfig-076-20231104   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231104   gcc  
xtensa                randconfig-002-20231104   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

