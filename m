Return-Path: <linux-acpi+bounces-1407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79617E7D06
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DF7B2047D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50091C2A5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/1dZRlI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A9134A7
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 13:15:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E46371E5;
	Fri, 10 Nov 2023 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699622134; x=1731158134;
  h=date:from:to:cc:subject:message-id;
  bh=nMD928xT0zZM+h3KeUIntxUrTQz+TJNhwP7AE3uKDNE=;
  b=C/1dZRlInb+56TItcbEfa1qOlJwc3DKhsU8vkQvQXKnBWICG5C9oMz8C
   boI5oJhX6BxOLH4lxRFRvVcVAg5j4qPRnI0zg3JA0+f7cobdzwKOTPSEI
   nCDc3darkyMamdl+IcFcEFyxFej7GM2R8HUaUzbLEbdLVkALFDLP7E4+5
   RD2BxfDjgry5W5ErR9s1eghKO+qpGUKqtA5yVCspfaddSjLkoPLcMk9T6
   CRdF2nmXYcBr4+R83DbBz4PtLfvpxW0wDil8mTgtEk7jpVbiFknVZAWFR
   uJ8JNebiK+jVcLgGWg8jjHfr4Zt27DSqYWBiLyryCAk+k95FInjjKInIL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370385422"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="370385422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 05:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11867648"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Nov 2023 05:15:28 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1RM6-0009c2-0S;
	Fri, 10 Nov 2023 13:15:26 +0000
Date: Fri, 10 Nov 2023 21:14:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5bd262f4820f2d5645d8ff1f251ef8e96715ef84
Message-ID: <202311102144.RBauZ6Dv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5bd262f4820f2d5645d8ff1f251ef8e96715ef84  Merge branch 'acpi-mipi-disco-img' into bleeding-edge

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
|-- arm-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-002-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-allyesconfig
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
|-- arm64-randconfig-003-20231109
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
|-- csky-randconfig-001-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- i386-buildonly-randconfig-002-20231109
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
|-- i386-randconfig-001-20231109
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
|-- loongarch-allyesconfig
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
|-- microblaze-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- microblaze-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- openrisc-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- parisc64-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-allmodconfig
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
|-- powerpc-allyesconfig
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
|-- powerpc-pcm030_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-001-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-002-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-003-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-002-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-003-20231109
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
|-- riscv-defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- riscv-randconfig-002-20231110
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- riscv-rv32_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-randconfig-001-20231110
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
|-- sparc-randconfig-001-20231110
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- sparc64-randconfig-001-20231110
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
|-- x86_64-buildonly-randconfig-001-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-005-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-006-20231109
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
|-- x86_64-randconfig-001-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-003-20231109
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
|-- x86_64-randconfig-011-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-012-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-013-20231109
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
`-- x86_64-rhel-8.3
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

elapsed time: 1467m

configs tested: 179
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231109   gcc  
arc                   randconfig-002-20231109   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231109   gcc  
arm                   randconfig-002-20231109   gcc  
arm                   randconfig-003-20231109   gcc  
arm                   randconfig-004-20231109   gcc  
arm                          sp7021_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231109   gcc  
arm64                 randconfig-002-20231109   gcc  
arm64                 randconfig-003-20231109   gcc  
arm64                 randconfig-004-20231109   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231109   gcc  
csky                  randconfig-002-20231109   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231109   gcc  
i386         buildonly-randconfig-002-20231109   gcc  
i386         buildonly-randconfig-003-20231109   gcc  
i386         buildonly-randconfig-004-20231109   gcc  
i386         buildonly-randconfig-005-20231109   gcc  
i386         buildonly-randconfig-006-20231109   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231109   gcc  
i386                  randconfig-002-20231109   gcc  
i386                  randconfig-003-20231109   gcc  
i386                  randconfig-004-20231109   gcc  
i386                  randconfig-005-20231109   gcc  
i386                  randconfig-006-20231109   gcc  
i386                  randconfig-011-20231110   gcc  
i386                  randconfig-012-20231110   gcc  
i386                  randconfig-013-20231110   gcc  
i386                  randconfig-014-20231110   gcc  
i386                  randconfig-015-20231110   gcc  
i386                  randconfig-016-20231110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231109   gcc  
loongarch             randconfig-002-20231109   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231110   gcc  
nios2                 randconfig-002-20231110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231110   gcc  
parisc                randconfig-002-20231110   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231109   gcc  
powerpc               randconfig-002-20231109   gcc  
powerpc               randconfig-003-20231109   gcc  
powerpc64             randconfig-001-20231109   gcc  
powerpc64             randconfig-002-20231109   gcc  
powerpc64             randconfig-003-20231109   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231110   gcc  
riscv                 randconfig-002-20231110   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231110   gcc  
s390                  randconfig-002-20231110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231110   gcc  
sh                    randconfig-002-20231110   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231110   gcc  
sparc                 randconfig-002-20231110   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231110   gcc  
sparc64               randconfig-002-20231110   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231110   gcc  
um                    randconfig-002-20231110   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231109   gcc  
x86_64       buildonly-randconfig-002-20231109   gcc  
x86_64       buildonly-randconfig-003-20231109   gcc  
x86_64       buildonly-randconfig-004-20231109   gcc  
x86_64       buildonly-randconfig-005-20231109   gcc  
x86_64       buildonly-randconfig-006-20231109   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231109   gcc  
x86_64                randconfig-002-20231109   gcc  
x86_64                randconfig-003-20231109   gcc  
x86_64                randconfig-004-20231109   gcc  
x86_64                randconfig-005-20231109   gcc  
x86_64                randconfig-006-20231109   gcc  
x86_64                randconfig-011-20231109   gcc  
x86_64                randconfig-012-20231109   gcc  
x86_64                randconfig-013-20231109   gcc  
x86_64                randconfig-014-20231109   gcc  
x86_64                randconfig-015-20231109   gcc  
x86_64                randconfig-016-20231109   gcc  
x86_64                randconfig-071-20231110   gcc  
x86_64                randconfig-072-20231110   gcc  
x86_64                randconfig-073-20231110   gcc  
x86_64                randconfig-074-20231110   gcc  
x86_64                randconfig-075-20231110   gcc  
x86_64                randconfig-076-20231110   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20231110   gcc  
xtensa                randconfig-002-20231110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

