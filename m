Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989A92350C9
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgHAGSd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Aug 2020 02:18:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:28681 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgHAGSd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 1 Aug 2020 02:18:33 -0400
IronPort-SDR: /EO+5hQ8iQuxllQgs3zYCxUqpuGzuI2aSLvEsrbW++rGgh8G9yYs19t1vrfY1HrUcbI6p2go2x
 xHxf76vyWdyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="170015519"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="gz'50?scan'50,208,50";a="170015519"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 23:18:30 -0700
IronPort-SDR: 1N1pJo/BGwcS5rmwpT0YPe1jggo5XRW+dtbFLeNfsTVl+LU8hSYnW88onORbE5EszHn5qOWWB4
 KM9Fae43l/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="gz'50?scan'50,208,50";a="465882780"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2020 23:18:26 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1kqf-0000L6-G2; Sat, 01 Aug 2020 06:18:25 +0000
Date:   Sat, 1 Aug 2020 14:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, Joao Martins <joao.m.martins@oracle.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 21/23] device-dax: Add an 'align' attribute
Message-ID: <202008011403.PtFkHpqE%lkp@intel.com>
References: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 01830e6c042e8eb6eb202e05d7df8057135b4c26]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/device-dax-Support-sub-dividing-soft-reserved-ranges/20200801-114823
base:    01830e6c042e8eb6eb202e05d7df8057135b4c26
config: arm-randconfig-r006-20200731 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dax/bus.c: In function 'do_id_store':
   drivers/dax/bus.c:94:27: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
      94 |    /* nothing to remove */;
         |                           ^
   drivers/dax/bus.c:99:29: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
      99 |   /* dax_id already added */;
         |                             ^
   In file included from include/linux/percpu-refcount.h:54,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c: In function 'dev_dax_shrink':
   include/linux/kernel.h:850:29: warning: comparison of distinct pointer types lacks a cast
     850 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                             ^~
   include/linux/kernel.h:864:4: note: in expansion of macro '__typecheck'
     864 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/kernel.h:874:24: note: in expansion of macro '__safe_cmp'
     874 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/kernel.h:883:19: note: in expansion of macro '__careful_cmp'
     883 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   drivers/dax/bus.c:881:12: note: in expansion of macro 'min'
     881 |   shrink = min(to_shrink, range_len(range));
         |            ^~~
   In file included from include/linux/device.h:15,
                    from drivers/dax/bus.c:4:
   drivers/dax/bus.c: In function 'dev_dax_validate_align':
   drivers/dax/bus.c:1062:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dax/bus.c:1062:3: note: in expansion of macro 'dev_dbg'
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |   ^~~~~~~
   drivers/dax/bus.c:1062:50: note: format string is defined here
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                                               ~~~^
         |                                                  |
         |                                                  long long unsigned int
         |                                               %u
   In file included from include/linux/device.h:15,
                    from drivers/dax/bus.c:4:
   drivers/dax/bus.c:1071:17: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'ssize_t' {aka 'int'} [-Wformat=]
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/dax/bus.c:1071:4: note: in expansion of macro 'dev_dbg'
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |    ^~~~~~~
   drivers/dax/bus.c:1071:51: note: format string is defined here
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                                                 ~~^
         |                                                   |
         |                                                   long int
         |                                                 %d
>> drivers/dax/bus.c:1082:7: error: 'PMD_SIZE' undeclared (first use in this function); did you mean 'PUD_SIZE'?
    1082 |  case PMD_SIZE:
         |       ^~~~~~~~
         |       PUD_SIZE
   drivers/dax/bus.c:1082:7: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/compiler_types.h:65,
                    from <command-line>:
   include/linux/compiler_attributes.h:214:41: warning: attribute 'fallthrough' not preceding a case label or default label
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                         ^~~~~~~~~~~~~
   drivers/dax/bus.c:1081:3: note: in expansion of macro 'fallthrough'
    1081 |   fallthrough;
         |   ^~~~~~~~~~~

vim +1082 drivers/dax/bus.c

  1050	
  1051	static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
  1052	{
  1053		resource_size_t dev_size = dev_dax_size(dev_dax);
  1054		struct device *dev = &dev_dax->dev;
  1055		ssize_t rc, i;
  1056	
  1057		if (dev->driver)
  1058			return -EBUSY;
  1059	
  1060		rc = -EINVAL;
  1061		if (dev_size > 0 && !alloc_is_aligned(dev_dax, dev_size)) {
  1062			dev_dbg(dev, "%s: align %u invalid for size %llu\n",
  1063				__func__, dev_dax->align, dev_size);
  1064			return rc;
  1065		}
  1066	
  1067		for (i = 0; i < dev_dax->nr_range; i++) {
  1068			size_t len = range_len(&dev_dax->ranges[i].range);
  1069	
  1070			if (!alloc_is_aligned(dev_dax, len)) {
  1071				dev_dbg(dev, "%s: align %u invalid for range %ld\n",
  1072					__func__, dev_dax->align, i);
  1073				return rc;
  1074			}
  1075		}
  1076	
  1077		switch (dev_dax->align) {
  1078		case PUD_SIZE:
  1079			if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
  1080				break;
  1081			fallthrough;
> 1082		case PMD_SIZE:
  1083			if (!has_transparent_hugepage())
  1084				break;
  1085			fallthrough;
  1086		case PAGE_SIZE:
  1087			rc = 0;
  1088			break;
  1089		}
  1090	
  1091		return rc;
  1092	}
  1093	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
R+c48BfWduL/A+O2XAMcbwEA

--huq684BweRXVnRxX--
