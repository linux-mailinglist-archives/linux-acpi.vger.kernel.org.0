Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E868F970
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjBHVFO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBHVEq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:04:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C9125AB;
        Wed,  8 Feb 2023 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675890259; x=1707426259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZG9PLpoY1qYgYnRoz88BAvdkbKCEGF3ZT8rJwxcgmM=;
  b=IHMKQX6I52i1SYeYDHr4jrs3gIuJdgjUh2emylHyWjXuAgWO0tKcU037
   +Ba/dukktNYTMGEAnVdzzB2NS8GMjtl3CT1evCZkN3bm3/MQcz+g86jfn
   DI3ShKEm+KZq9bKRANpaDoh+1F/nxfC6GdBjbRy+4Eun+I8QSjhmS5bqx
   KIM5WYe8viNpsgwL37EulYTCSKP5xUyiKk26bpTgIt0vXF1GmOTeGR0JO
   r/mEK0x21cNZ1xGTD3zddwdI85kV92yEY5Srm6fRlnhzsWmxk8p2yaO5t
   HRguKNf3CGlK/4DvnDT9EfTLVYEoSqjIcv0joQYkz7WJ++SKnmQ/lFbzS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="332048278"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="332048278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="996284230"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="996284230"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2023 13:04:15 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPrby-0004eM-0b;
        Wed, 08 Feb 2023 21:04:14 +0000
Date:   Thu, 9 Feb 2023 05:04:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <202302090459.kIM95vle-lkp@intel.com>
References: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on sailus-media-tree/streams linus/master v6.2-rc7 next-20230208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/ACPI-property-Parse-data-node-string-references-in-properties/20230208-233112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230208152807.3064242-3-sakari.ailus%40linux.intel.com
patch subject: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20230209/202302090459.kIM95vle-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d78f47f2d5051c50bdcea131da1779ec0fc8e266
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sakari-Ailus/ACPI-property-Parse-data-node-string-references-in-properties/20230208-233112
        git checkout d78f47f2d5051c50bdcea131da1779ec0fc8e266
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/20230208152807.3064242-3-sakari.ailus@linux.intel.com

All warnings (new ones prefixed by >>):

>> drivers/acpi/mipi.c:205:6: warning: no previous prototype for 'acpi_crs_csi2_alloc_fill_swnodes' [-Wmissing-prototypes]
     205 | void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_crs_csi2_alloc_fill_swnodes +205 drivers/acpi/mipi.c

   200	
   201	/*
   202	 * Allocate memory and set up software nodes for an ACPI device with given
   203	 * number of CSI-2 ports.
   204	 */
 > 205	void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
   206	{
   207		struct acpi_device_software_nodes *ads;
   208		struct crs_csi2_swnodes *swnodes;
   209		size_t alloc_size;
   210		unsigned int i;
   211		bool overflow;
   212		void *end;
   213	
   214		/*
   215		 * Allocate memory for ports, node pointers (number of nodes +
   216		 * 1 (guardian), nodes (root + number of ports * 2 (for for
   217		 * every port there is an endpoint)).
   218		 */
   219		overflow = check_mul_overflow(sizeof(*ads->ports) +
   220					      sizeof(*ads->nodes) * 2 +
   221					      sizeof(*ads->nodeptrs) * 2,
   222					      ports_count, &alloc_size);
   223		overflow = overflow ||
   224			   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
   225					      sizeof(*ads->nodeptrs) * 2,
   226					      alloc_size, &alloc_size);
   227		if (overflow) {
   228			acpi_handle_warn(handle,
   229					 "too many _CRS CSI2 resource handles (%zu)",
   230					 ports_count);
   231			return;
   232		}
   233	
   234		swnodes = kzalloc(sizeof(*swnodes), GFP_KERNEL);
   235		ads = kzalloc(alloc_size, GFP_KERNEL);
   236		ads->ports = (void *)(ads + 1);
   237		ads->nodes = (void *)(ads->ports + ports_count);
   238		ads->nodeptrs = (void *)(ads->nodes +
   239					 ports_count * 2 + 1);
   240		end = ads->nodeptrs + ports_count * 2 + 2;
   241		if (!swnodes || !ads || WARN_ON((void *)ads + alloc_size != end)) {
   242			kfree(swnodes);
   243			kfree(ads);
   244			acpi_handle_debug(handle,
   245					  "cannot allocate for %zu software nodes\n",
   246					  ports_count);
   247			return;
   248		}
   249	
   250		ads->num_ports = ports_count;
   251		for (i = 0; i < ports_count * 2 + 1; i++)
   252			ads->nodeptrs[i] = &ads->nodes[i];
   253		ads->nodeptrs[i] = NULL;
   254		for (i = 0; i < ports_count; i++)
   255			ads->ports[i].port_nr = NO_CSI2_PORT;
   256		swnodes->handle = handle;
   257		swnodes->ads = ads;
   258		list_add(&swnodes->list, &crs_csi2_swnodes);
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
