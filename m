Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38412350BF
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 08:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHAGQf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Aug 2020 02:16:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:60542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHAGQf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 1 Aug 2020 02:16:35 -0400
IronPort-SDR: iV5AVKZq/G9Ptd4d2zx2HaPD9mkvFN72F3znKbWtAEBVSQdrTgEH/ZlkKKYmr8cVpLv+emzz9x
 z9OvFMQAVmGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="139874844"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="gz'50?scan'50,208,50";a="139874844"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 23:14:29 -0700
IronPort-SDR: 1gsV/I8NbV9uZQI/z/9YDyyNicLeFwmCocv8zU0hb04aRAW2mGCCE4mncNBonIQmX8U57vewCa
 MKe/Hi6TnROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="gz'50?scan'50,208,50";a="323485725"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2020 23:14:26 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1kmn-0000L3-EN; Sat, 01 Aug 2020 06:14:25 +0000
Date:   Sat, 1 Aug 2020 14:14:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, Joao Martins <joao.m.martins@oracle.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 21/23] device-dax: Add an 'align' attribute
Message-ID: <202008011419.67BkWnAl%lkp@intel.com>
References: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 01830e6c042e8eb6eb202e05d7df8057135b4c26]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/device-dax-Support-sub-dividing-soft-reserved-ranges/20200801-114823
base:    01830e6c042e8eb6eb202e05d7df8057135b4c26
config: m68k-randconfig-r034-20200731 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
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
   In file included from include/linux/printk.h:405,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c: In function 'dev_dax_validate_align':
   drivers/dax/bus.c:1062:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:125:15: note: in definition of macro '__dynamic_func_call'
     125 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
     157 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:2: note: in expansion of macro 'dynamic_dev_dbg'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:23: note: in expansion of macro 'dev_fmt'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                       ^~~~~~~
   drivers/dax/bus.c:1062:3: note: in expansion of macro 'dev_dbg'
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |   ^~~~~~~
   drivers/dax/bus.c:1062:50: note: format string is defined here
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                                               ~~~^
         |                                                  |
         |                                                  long long unsigned int
         |                                               %u
   In file included from include/linux/printk.h:405,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c:1071:17: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'ssize_t' {aka 'int'} [-Wformat=]
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:125:15: note: in definition of macro '__dynamic_func_call'
     125 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
     157 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:2: note: in expansion of macro 'dynamic_dev_dbg'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:23: note: in expansion of macro 'dev_fmt'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                       ^~~~~~~
   drivers/dax/bus.c:1071:4: note: in expansion of macro 'dev_dbg'
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |    ^~~~~~~
   drivers/dax/bus.c:1071:51: note: format string is defined here
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                                                 ~~^
         |                                                   |
         |                                                   long int
         |                                                 %d
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from arch/m68k/include/asm/pgtable_no.h:5,
                    from arch/m68k/include/asm/pgtable.h:3,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/dax.h:6,
                    from drivers/dax/bus.c:8:
>> include/asm-generic/pgtable-nop4d.h:11:20: error: 'PGDIR_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
      11 | #define P4D_SHIFT  PGDIR_SHIFT
         |                    ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:19: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT P4D_SHIFT
         |                   ^~~~~~~~~
   include/asm-generic/pgtable-nopud.h:20:28: note: in expansion of macro 'PUD_SHIFT'
      20 | #define PUD_SIZE   (1UL << PUD_SHIFT)
         |                            ^~~~~~~~~
   drivers/dax/bus.c:1078:7: note: in expansion of macro 'PUD_SIZE'
    1078 |  case PUD_SIZE:
         |       ^~~~~~~~
   include/asm-generic/pgtable-nop4d.h:11:20: note: each undeclared identifier is reported only once for each function it appears in
      11 | #define P4D_SHIFT  PGDIR_SHIFT
         |                    ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:19: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT P4D_SHIFT
         |                   ^~~~~~~~~
   include/asm-generic/pgtable-nopud.h:20:28: note: in expansion of macro 'PUD_SHIFT'
      20 | #define PUD_SIZE   (1UL << PUD_SHIFT)
         |                            ^~~~~~~~~
   drivers/dax/bus.c:1078:7: note: in expansion of macro 'PUD_SIZE'
    1078 |  case PUD_SIZE:
         |       ^~~~~~~~
>> drivers/dax/bus.c:1082:7: error: 'PMD_SIZE' undeclared (first use in this function); did you mean 'P4D_SIZE'?
    1082 |  case PMD_SIZE:
         |       ^~~~~~~~
         |       P4D_SIZE

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

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
w/8BxrMJCQ1HAQA=

--0OAP2g/MAC+5xKAE--
