Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F776C2629
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCUABL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Mar 2023 20:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCUABL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 20:01:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59CE303EB;
        Mon, 20 Mar 2023 17:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679356869; x=1710892869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2eWlwvhO9plCeyGPyu9VLJzDkUBKUo2VSuRYtqtRQzM=;
  b=VNkZkFwSSM/dif4DjbIAqKY/dB9O6WO4K37wEvkx91t8aacVrxa2AcHD
   tpd50ekiBeL+/TwgVp6PFEBbN4Rzh/kOQr1ncJZNQniHyo4QO84nGD/iW
   seg888VuofKfIzr8eDHxQJOotmEiGc4Pnhn/jeLW/gvKQr43L2zVs86Ow
   TZ5wNbP8SUVhLE/OhlSXobaLNtoVX8Jn4omk+ZaMTAt83z/YhF5gEqUwe
   uIpjHI+jJcZzzU8zYPPAIRJAkYDIkaHJ1aiGPizyO3k/dJee7JCEIoD3N
   aVF5KHQ2wehiW7EOpRpCJZB41tlhNW8U5aRfmIOU3kfNAGZXtZ0YIV0ML
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403681998"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="403681998"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674612515"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="674612515"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 17:01:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pePQz-000BPm-0r;
        Tue, 21 Mar 2023 00:01:01 +0000
Date:   Tue, 21 Mar 2023 08:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juergen Gross <jgross@suse.com>
Subject: [rafael-pm:bleeding-edge 44/49] drivers/acpi/processor_pdc.c:59:24:
 error: implicit declaration of function 'xen_processor_present'
Message-ID: <202303210729.DvRvIUla-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2a191fe33656f0fdff33b061fb03b1ffeb75b3f6
commit: 8509b1a86a966321a7ee9163620285f60da40468 [44/49] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20230321/202303210729.DvRvIUla-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8509b1a86a966321a7ee9163620285f60da40468
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 8509b1a86a966321a7ee9163620285f60da40468
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210729.DvRvIUla-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/processor_pdc.c: In function 'processor_physically_present':
>> drivers/acpi/processor_pdc.c:59:24: error: implicit declaration of function 'xen_processor_present' [-Werror=implicit-function-declaration]
      59 |                 return xen_processor_present(acpi_id);
         |                        ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
