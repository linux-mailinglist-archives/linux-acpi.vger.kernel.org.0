Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E768F8FB
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 21:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBHUoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBHUoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 15:44:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10312202B;
        Wed,  8 Feb 2023 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675889055; x=1707425055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxcMPdK+9hwoTwbHmcfSYBXX8CO2nttWKL0GyfKJSuE=;
  b=Pe04RRicHbFuHWv3C03GMNZJ4TdCIJD9RJz/GQFhfm7n8xuHgWGwy6/W
   FTU7EYP8qCVdyBn2uu8zjjN1nLJ78H2HB2UPrSb9Z4FlxkLCqjp+XRD50
   EJRD463KRL1/FxkqKmgNjp+QlDvbhpcX0BMARP+yV8zu7U5nwSFlx1tvU
   03wI0wkvAa65cYV/CpU++LH6HfGDhNwc2awtbkBlffX+VJfWzV6ka+4un
   fzzsEGtKg7rndoVE7KddAB1qsr8fm16ELAjgWhFdtDyK2/YXE7id7ZSHZ
   9XXBgLI8JSidRaGXYsM2Ab0017XTZONAeTmmLOP/+tUpg8TTgJdlr59Uh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329946884"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329946884"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776188505"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776188505"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 12:44:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPrIa-0004dZ-26;
        Wed, 08 Feb 2023 20:44:12 +0000
Date:   Thu, 9 Feb 2023 04:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <202302090442.og7NHYTZ-lkp@intel.com>
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
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20230209/202302090442.og7NHYTZ-lkp@intel.com/config)
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
