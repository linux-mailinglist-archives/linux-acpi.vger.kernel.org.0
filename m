Return-Path: <linux-acpi+bounces-1812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8A7F73ED
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB90BB209F8
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D42420D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMuzJsfd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB5D6F;
	Fri, 24 Nov 2023 02:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700822730; x=1732358730;
  h=date:from:to:cc:subject:message-id;
  bh=li6aOqwYoWNJHaUmHNwJUFp3HROihw/cRRCtxjgvTNY=;
  b=KMuzJsfdxcOIUaReC9OU7imjn1vVEqH1kBKqpMR0SRGbgwuNRJy9j1iv
   kslH8MzDutltYViJ9+vTBsGOUDmxYSMOcyImsRWhkgRTTnBdeIOqJ+EpT
   jWmiN8LaaJ3fvMjt04Oi9WO/G7Ir9MdvaexGXvsBI+LVkhl453DC9I4Ft
   2MHzUOTxQRJR+ch4ZfreQFFmyLHe0zluaHDs03GTMNcSBcd+C5FTaiCJI
   2PJ3eThSaLSYBrwJ+7HcKgD2BdJ2MlM5itEkDxLwndXubelNcO4ZCoxQf
   N7ti4PuS+E3wGyIcWtim92BL6xvpCt+VYhCsCLQ2/CthjvZi4HeafFoB4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456743754"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456743754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717334869"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="717334869"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2023 02:45:23 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6TgX-0002Qs-1D;
	Fri, 24 Nov 2023 10:45:21 +0000
Date: Fri, 24 Nov 2023 18:45:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 accf6bb711d6819cce89a122ccde4811c58c160e
Message-ID: <202311241802.8WWz80fF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: accf6bb711d6819cce89a122ccde4811c58c160e  Merge branch 'acpi-property' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202311210522.8Y0cnwJ2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311210725.tPlWJipc-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/acpi/thermal_lib.c:46:5: warning: no previous prototype for 'acpi_active_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:46:5: warning: no previous prototype for function 'acpi_active_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:57:5: warning: no previous prototype for 'acpi_passive_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:57:5: warning: no previous prototype for function 'acpi_passive_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:63:5: warning: no previous prototype for 'acpi_hot_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:63:5: warning: no previous prototype for function 'acpi_hot_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:69:5: warning: no previous prototype for 'acpi_critical_trip_temp' [-Wmissing-prototypes]
drivers/acpi/thermal_lib.c:69:5: warning: no previous prototype for function 'acpi_critical_trip_temp' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-keystone_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-002-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-defconfig
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- arm64-randconfig-004-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- csky-randconfig-001-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- i386-buildonly-randconfig-002-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- i386-buildonly-randconfig-003-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- i386-buildonly-randconfig-005-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- i386-buildonly-randconfig-006-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- i386-randconfig-001-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- i386-randconfig-003-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- i386-randconfig-004-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- i386-randconfig-141-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- loongarch-randconfig-001-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- loongarch-randconfig-002-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
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
|-- mips-fuloong2e_defconfig
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
|-- powerpc-chrp32_defconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-001-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-002-20231123
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
|-- powerpc-randconfig-003-20231123
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
|-- powerpc64-randconfig-001-20231123
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
|-- powerpc64-randconfig-002-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-003-20231123
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
|-- riscv-randconfig-001-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- riscv-randconfig-002-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allmodconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-allyesconfig
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sh-sh7724_generic_defconfig
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
|-- sparc-randconfig-002-20231123
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
|-- sparc64-randconfig-002-20231123
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-004-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-defconfig
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
|-- x86_64-randconfig-011-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-randconfig-012-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-randconfig-013-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-014-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-015-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-016-20231123
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
|-- x86_64-randconfig-071-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-randconfig-072-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-randconfig-073-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|-- x86_64-randconfig-074-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
|   |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
|   `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-075-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
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
`-- x86_64-randconfig-161-20231123
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_active_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_critical_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_hot_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-acpi_passive_trip_temp
    |-- drivers-usb-core-hcd.c:warning:s-directive-output-may-be-truncated-writing-up-to-bytes-into-a-region-of-size-between-and
    `-- drivers-usb-core-usb.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
clang_recent_errors
|-- i386-allmodconfig
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|-- i386-randconfig-014-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
|-- i386-randconfig-015-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
|-- i386-randconfig-016-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|-- x86_64-allyesconfig
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|-- x86_64-randconfig-001-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|-- x86_64-randconfig-002-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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
|-- x86_64-randconfig-004-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
|-- x86_64-randconfig-006-20231123
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
|   |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
|   `-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
`-- x86_64-rhel-8.3-rust
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_active_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_critical_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_hot_trip_temp
    |-- drivers-acpi-thermal_lib.c:warning:no-previous-prototype-for-function-acpi_passive_trip_temp
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

elapsed time: 2227m

configs tested: 171
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231123   gcc  
arc                   randconfig-002-20231123   gcc  
arc                           tb10x_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                   randconfig-001-20231123   gcc  
arm                   randconfig-002-20231123   gcc  
arm                   randconfig-003-20231123   gcc  
arm                   randconfig-004-20231123   gcc  
arm                           stm32_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231123   gcc  
arm64                 randconfig-002-20231123   gcc  
arm64                 randconfig-003-20231123   gcc  
arm64                 randconfig-004-20231123   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231123   gcc  
csky                  randconfig-002-20231123   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231123   clang
hexagon               randconfig-002-20231123   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231123   gcc  
i386         buildonly-randconfig-002-20231123   gcc  
i386         buildonly-randconfig-003-20231123   gcc  
i386         buildonly-randconfig-004-20231123   gcc  
i386         buildonly-randconfig-005-20231123   gcc  
i386         buildonly-randconfig-006-20231123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231123   gcc  
i386                  randconfig-002-20231123   gcc  
i386                  randconfig-003-20231123   gcc  
i386                  randconfig-004-20231123   gcc  
i386                  randconfig-005-20231123   gcc  
i386                  randconfig-006-20231123   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231123   gcc  
loongarch             randconfig-002-20231123   gcc  
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
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231123   gcc  
nios2                 randconfig-002-20231123   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231123   gcc  
parisc                randconfig-002-20231123   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc               randconfig-001-20231123   gcc  
powerpc               randconfig-002-20231123   gcc  
powerpc               randconfig-003-20231123   gcc  
powerpc64             randconfig-001-20231123   gcc  
powerpc64             randconfig-002-20231123   gcc  
powerpc64             randconfig-003-20231123   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231123   gcc  
riscv                 randconfig-002-20231123   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231123   clang
s390                  randconfig-002-20231123   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231123   gcc  
sh                    randconfig-002-20231123   gcc  
sh                          sdk7780_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231123   gcc  
sparc64               randconfig-002-20231123   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231123   gcc  
um                    randconfig-002-20231123   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231123   clang
x86_64                randconfig-002-20231123   clang
x86_64                randconfig-003-20231123   clang
x86_64                randconfig-004-20231123   clang
x86_64                randconfig-005-20231123   clang
x86_64                randconfig-006-20231123   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231123   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231123   gcc  
xtensa                randconfig-002-20231123   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

