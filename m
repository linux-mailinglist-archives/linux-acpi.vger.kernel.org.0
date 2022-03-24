Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0D4E6111
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Mar 2022 10:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbiCXJ2J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Mar 2022 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiCXJ17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Mar 2022 05:27:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBB9E9DE;
        Thu, 24 Mar 2022 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648113988; x=1679649988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Td8YsXMpI4YXozqUJGH+dpvAo9Uu+wpZGTwGaP5ufBs=;
  b=c48QdDBYEJ5YKWI69wgWICCk5eC5LdLO+evGx8OAGOHlkskpfhNXDWuI
   WW7hU7f9NEPhBzI7GUSeCZxnP3Zoo1A3+2RujnIApfdWEf8/ssMGKr8pX
   fGDlI5XwyydJmAVvaen0bn+lGWW+/5O1++NZqhX1MvGMWbfQ1bgrNq5SK
   nP4s28N9FvTop+bTLgOCFfd98v418qXEyUkXExVtAkZCQV9iXnUM3R+4g
   6yqCDhW6SpuQNxd+ucP6oHu4YECtaNEbT3kxlX3p8JsR/Sjrbckdwbhr1
   S/emm0jJosEtaNBEgylM4J+5HRTiY8kVIUXM4RpvYHJ3OTvSeJlbW5AIf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255894410"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="255894410"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:26:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="501326676"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:26:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXJiq-005ioX-Nz;
        Thu, 24 Mar 2022 11:25:36 +0200
Date:   Thu, 24 Mar 2022 11:25:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 3/4] device property: Add iomap to fwnode operations
Message-ID: <Yjw5ED+2574cVib6@smile.fi.intel.com>
References: <20220323154737.169483-4-sakari.ailus@linux.intel.com>
 <202203240648.x2upaXar-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203240648.x2upaXar-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 24, 2022 at 06:37:19AM +0800, kernel test robot wrote:
> Hi Sakari,
> 
> I love your patch! Yet something to improve:

...

> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Sakari-Ailus/Shovel-firmware-specific-code-to-appropriate-locations/20220324-000256
>         git checkout c9025bc8f89f50eaf9b9d628f1ac5d47b77c6bc8
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Seems it needs some ifdeffery to be added.

-- 
With Best Regards,
Andy Shevchenko


