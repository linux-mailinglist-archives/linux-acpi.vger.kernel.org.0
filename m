Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA06C2659
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCUAcV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Mar 2023 20:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAcV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 20:32:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186723113;
        Mon, 20 Mar 2023 17:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679358739; x=1710894739;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JU4Kc/uqdjrN1PEEW3dpytcHVHJaoUaK4J8kmVsnlSc=;
  b=TNaXNWobKX57Hspyowu87OlYXv7CAQoYxPc4ixr8DB4dmeVPeDfnbNPt
   hfow2wcy2p450jk2gnk2r8uNglhGBCxkXqSl2/Y7hJYPDml3NAVkplCda
   Gtdw0+u3VwgtAKdZA2ot9a1aqaxY2V+b0CWuikBzdO4Rg4IbfRS/RJsU9
   PJmjd+SQUiFh9HSqI/pk6d1Gl3hDn4Crn2jf1QMW+hgn9v5cMEhKic4Xq
   gf9YGEs652yQs3pG9FYndsTIKMcJQyJdmmluV9npc9xTPcyXKKpI7LUN2
   PzQ57gIeVah+LZQoc8qsDDzZY9YhEmecHNhbozv2XFbjWUR1asA01sjm5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="327186900"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="327186900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824701151"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="824701151"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 17:32:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pePv1-000BR4-0S;
        Tue, 21 Mar 2023 00:32:03 +0000
Date:   Tue, 21 Mar 2023 08:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juergen Gross <jgross@suse.com>
Subject: [rafael-pm:bleeding-edge 44/49] drivers/acpi/processor_pdc.c:59:10:
 error: implicit declaration of function 'xen_processor_present' is invalid
 in C99
Message-ID: <202303210858.dZnSlO11-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   226ec3112c6fa4db1188828f76319f7eb6eb85ee
commit: 8509b1a86a966321a7ee9163620285f60da40468 [44/49] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
config: i386-randconfig-a004-20230320 (https://download.01.org/0day-ci/archive/20230321/202303210858.dZnSlO11-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8509b1a86a966321a7ee9163620285f60da40468
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 8509b1a86a966321a7ee9163620285f60da40468
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210858.dZnSlO11-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/processor_pdc.c:59:10: error: implicit declaration of function 'xen_processor_present' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   return xen_processor_present(acpi_id);
                          ^
   1 error generated.


vim +/xen_processor_present +59 drivers/acpi/processor_pdc.c

    20	
    21	static bool __init processor_physically_present(acpi_handle handle)
    22	{
    23		int cpuid, type;
    24		u32 acpi_id;
    25		acpi_status status;
    26		acpi_object_type acpi_type;
    27		unsigned long long tmp;
    28		union acpi_object object = { 0 };
    29		struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
    30	
    31		status = acpi_get_type(handle, &acpi_type);
    32		if (ACPI_FAILURE(status))
    33			return false;
    34	
    35		switch (acpi_type) {
    36		case ACPI_TYPE_PROCESSOR:
    37			status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
    38			if (ACPI_FAILURE(status))
    39				return false;
    40			acpi_id = object.processor.proc_id;
    41			break;
    42		case ACPI_TYPE_DEVICE:
    43			status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
    44			if (ACPI_FAILURE(status))
    45				return false;
    46			acpi_id = tmp;
    47			break;
    48		default:
    49			return false;
    50		}
    51	
    52		if (xen_initial_domain())
    53			/*
    54			 * When running as a Xen dom0 the number of processors Linux
    55			 * sees can be different from the real number of processors on
    56			 * the system, and we still need to execute _PDC for all of
    57			 * them.
    58			 */
  > 59			return xen_processor_present(acpi_id);
    60	
    61		type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
    62		cpuid = acpi_get_cpuid(handle, type, acpi_id);
    63	
    64		return !invalid_logical_cpuid(cpuid);
    65	}
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
