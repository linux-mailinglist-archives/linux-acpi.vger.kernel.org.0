Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566539BD55
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFDQik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:38:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:60819 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDQik (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:38:40 -0400
IronPort-SDR: qPJD40rLB22i+Lfl0qSS2U1AXk+j56jsMz/eD0MU0ZvvaVSPJUrWVTtyUOPLGQLt0TJOhhNZEL
 Ki3MhKs92fbA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="289955087"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="289955087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:36:52 -0700
IronPort-SDR: nXdsqksLSufLonxtv7iROUq2XGweccqvieHF3js/nc5MXB779J8NPN1zUwLSR+0X7ipP4a6kkT
 HgLldwhDEn2g==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401009895"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:36:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lpCoQ-00HGWp-Hr; Fri, 04 Jun 2021 19:36:46 +0300
Date:   Fri, 4 Jun 2021 19:36:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Unify access to of_node
Message-ID: <YLpWnjLaxuJOYOHg@smile.fi.intel.com>
References: <20210604131343.62016-1-andriy.shevchenko@linux.intel.com>
 <202106050011.Ex8ymli1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202106050011.Ex8ymli1-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 05, 2021 at 12:14:45AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20210604]
> [cannot apply to driver-core/driver-core-testing linux/master linus/master v5.13-rc4 v5.13-rc3 v5.13-rc2 v5.13-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/device-property-Unify-access-to-of_node/20210604-211443
> base:    ccc252d2e818f6a479441119ad453c3ce7c7c461
> config: sparc64-randconfig-s032-20210604 (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/dfc2a97acf9b5c5ba11d180bf411721f723a9042
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/device-property-Unify-access-to-of_node/20210604-211443
>         git checkout dfc2a97acf9b5c5ba11d180bf411721f723a9042
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Oh là là, just in time when I sent v2...
I'll look at this :-)

> sparse warnings: (new ones prefixed by >>)
> >> drivers/base/property.c:875:55: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct fwnode_handle *fwnode @@     got struct fwnode_handle const *fwnode @@
>    drivers/base/property.c:875:55: sparse:     expected struct fwnode_handle *fwnode
>    drivers/base/property.c:875:55: sparse:     got struct fwnode_handle const *fwnode
>    drivers/base/property.c:890:62: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct fwnode_handle *fwnode @@     got struct fwnode_handle const *fwnode @@
>    drivers/base/property.c:890:62: sparse:     expected struct fwnode_handle *fwnode
>    drivers/base/property.c:890:62: sparse:     got struct fwnode_handle const *fwnode

-- 
With Best Regards,
Andy Shevchenko


