Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FC4EBC0A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiC3HrA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiC3Hqx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 03:46:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3240E5C;
        Wed, 30 Mar 2022 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648626301; x=1680162301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyM15ig4vldj9AXbC0+WK8+a+vBF8gBV0bQd4SURqlA=;
  b=SSamHinFkhvfWicXJQ0ttLemrxKYOYdzdocaFBIoPJImLR0s0TxZv+dc
   f3zRkaX6J7EyC+cEd+J29Z9+kyWC0/O57hwiF4Ndj4Y9ya2i4eeH1u8SB
   /5j2p2cLREHM0ZKof6u4rSWwMWlJs3p+AfGUX5Hx14PgWyQwuE2nO/Cg2
   UXzwl1eIId9Jl85ikmSXhw56L4txxSa9v3TEjEi9oFi52+pNwbkFWzwuT
   dLiTL5rnbJ0gQywY7/cd5w6ZbYB5ZXbLb4qUTQsJ+EtYzg4hoVCafT+fn
   VbffawD+ZBbiozmn39HRkyjSFtzZVWbcnAmWzu96vSSj1fLu92mrv52qD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322656870"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322656870"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 00:45:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565381332"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 00:44:57 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 69B3C20365;
        Wed, 30 Mar 2022 10:44:55 +0300 (EEST)
Date:   Wed, 30 Mar 2022 10:44:55 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org,
        kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 3/4] device property: Add iomap to fwnode operations
Message-ID: <YkQKdyrBjHKfmptm@paasikivi.fi.intel.com>
References: <20220323154737.169483-4-sakari.ailus@linux.intel.com>
 <202203240648.x2upaXar-lkp@intel.com>
 <Yjw5ED+2574cVib6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjw5ED+2574cVib6@smile.fi.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 24, 2022 at 11:25:36AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 24, 2022 at 06:37:19AM +0800, kernel test robot wrote:
> > Hi Sakari,
> > 
> > I love your patch! Yet something to improve:
> 
> ...
> 
> > compiler: s390-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Sakari-Ailus/Shovel-firmware-specific-code-to-appropriate-locations/20220324-000256
> >         git checkout c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> 
> Seems it needs some ifdeffery to be added.

Yeah. What surprises me though is there seem to be quite a few other
sources of such warnings, too.

-- 
Sakari Ailus
