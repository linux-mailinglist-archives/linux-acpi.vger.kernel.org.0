Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA32480599
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Dec 2021 02:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhL1B4s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Dec 2021 20:56:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:58929 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhL1B4s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Dec 2021 20:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640656608; x=1672192608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DKwG8lWbT6mngDQUOHLQ6ktH2iz4mmzsTr40NcmYb+Y=;
  b=PNnnzuko1SMhgGqQDRtyPtvcUDD5ahWi+pk7E8CqYUCYXn+OhnvgX3Mq
   RbePo6ZaPGrPPleGwhOKO2ogjL6ZtTu5IduspHrVSbtXOXbwznHcwXj5w
   +rL3pxdtjYyOoUjzZGKvXHppoL/xDR8PatC8CjeCTqPdTwiuPHLpFBjx8
   LSh3zgBIAng+qhK6rAsRWLV4gfgE+3P8nM5na0dWlb+yyMy/19YVu5giq
   okSDRg3apZQBlNSItxrh2q8pwT7fNeHVkq0RkQ9rElBEfHbQeh0fWAXJg
   x4i2T0OjYoPi5ZZ70atQWHFEpL8wXTMUD5AEy2ENIAJp73R6e3nGu+xxU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="228125906"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="228125906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 17:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="468001512"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2021 17:56:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n21jI-000761-UL; Tue, 28 Dec 2021 01:56:44 +0000
Date:   Tue, 28 Dec 2021 09:56:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bob Moore <robert.moore@intel.com>
Subject: [rafael-pm:bleeding-edge 97/119]
 drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer
 subtraction with a null pointer has undefined behavior
Message-ID: <202112280907.gTYYYuB4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   86e4182dd2d1465f6446863dd26da97ea069c8a2
commit: ca25f92b72d25457653dbf2a81f322235804fb05 [97/119] ACPICA: Use original data_table_region pointer for accesses
config: i386-randconfig-a012-20211228 (https://download.01.org/0day-ci/archive/20211228/202112280907.gTYYYuB4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=ca25f92b72d25457653dbf2a81f322235804fb05
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout ca25f92b72d25457653dbf2a81f322235804fb05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/acpica/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtraction with a null pointer has undefined behavior [-Wnull-pointer-subtraction]
               (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:513:41: note: expanded from macro 'ACPI_PTR_TO_PHYSADDR'
   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
                                           ^~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:510:41: note: expanded from macro 'ACPI_TO_INTEGER'
   #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
                                                                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +519 drivers/acpi/acpica/exregion.c

   486	
   487	/*******************************************************************************
   488	 *
   489	 * FUNCTION:    acpi_ex_data_table_space_handler
   490	 *
   491	 * PARAMETERS:  function            - Read or Write operation
   492	 *              address             - Where in the space to read or write
   493	 *              bit_width           - Field width in bits (8, 16, or 32)
   494	 *              value               - Pointer to in or out value
   495	 *              handler_context     - Pointer to Handler's context
   496	 *              region_context      - Pointer to context specific to the
   497	 *                                    accessed region
   498	 *
   499	 * RETURN:      Status
   500	 *
   501	 * DESCRIPTION: Handler for the Data Table address space (Op Region)
   502	 *
   503	 ******************************************************************************/
   504	
   505	acpi_status
   506	acpi_ex_data_table_space_handler(u32 function,
   507					 acpi_physical_address address,
   508					 u32 bit_width,
   509					 u64 *value,
   510					 void *handler_context, void *region_context)
   511	{
   512		struct acpi_data_table_space_context *mapping;
   513		char *pointer;
   514	
   515		ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
   516	
   517		mapping = (struct acpi_data_table_space_context *) region_context;
   518		pointer = ACPI_CAST_PTR(char, mapping->pointer) +
 > 519		    (address - ACPI_PTR_TO_PHYSADDR(mapping->pointer));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
