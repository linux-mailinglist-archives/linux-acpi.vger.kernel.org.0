Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074D755D27E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiF1DMF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiF1DME (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 23:12:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61CC24BC5;
        Mon, 27 Jun 2022 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656385922; x=1687921922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ylASZCejaRNO8p5xafj9qyvpZzJ7dovRfBsTeL6QC50=;
  b=mLPFt6OyZN0ECkOTrzLZGxZzUWXJ3O5XOIb08RbJ6zfm1bZPfh/nj/1i
   7vFsy/OuGFG1unaIYLP8GcwlXXDifEZkqwcPpQMLRi/XdUqsdlWi4J/Ev
   rJmZucyFx8HLAcjJjg3gIfIOSs5T09ME071dkS/QWLPG0nozdXlwVGcDy
   JqbO3Z4ksIDOw8cdkVj/FLqzbJmvu66fpu/zl1NE4BxTHk/10iDXg33Q6
   4lu7PHIBzu/NCzMgHKcND3G3KQIvmhVaQEza6xexl41L0Khpnm8TaZFjS
   DJJHENuMAkYOayhchYHCi6fkVd15RV0orL8fllwU8JM7GCapZdXe4kY4R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262029754"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="262029754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="836480443"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 20:12:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o61dv-0009Ri-WC;
        Tue, 28 Jun 2022 03:12:00 +0000
Date:   Tue, 28 Jun 2022 11:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 29/30] drivers/bus/hisi_lpc.c:488:41:
 error: 'struct acpi_device' has no member named 'children'
Message-ID: <202206281146.iWj1cpqY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   3ea94b067c49378a574fc477647ece5c2f41dccb
commit: 647590eb6f340e8d501b9568e566dfb05c61b245 [29/30] ACPI: bus: Drop unused list heads from struct acpi_device
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220628/202206281146.iWj1cpqY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=647590eb6f340e8d501b9568e566dfb05c61b245
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 647590eb6f340e8d501b9568e566dfb05c61b245
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_remove':
>> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                         ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/list.h:665:16: note: in definition of macro 'list_entry_is_head'
     665 |         (&pos->member == (head))
         |                ^~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                         ^~
   include/linux/list.h:665:27: note: in definition of macro 'list_entry_is_head'
     665 |         (&pos->member == (head))
         |                           ^~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
>> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     488 |         list_for_each_entry(child, &adev->children, node)
         |                                                     ^~~~
   include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                          ^~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
     564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
     676 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
     488 |         list_for_each_entry(child, &adev->children, node)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_probe':
   drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
      18 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/bus/hisi_lpc.c:9:
   drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
     509 |         list_for_each_entry(child, &adev->children, node) {
         |                                                     ^~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:520:9: note: in expansion of macro 'container_of'
     520 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
     531 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
     674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
     509 |         list_for_each_entry(child, &adev->children, node) {
         |                                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~


vim +488 drivers/bus/hisi_lpc.c

99c0228d6ff1fa John Garry 2018-05-08  480  
10e62b47973b0b John Garry 2019-07-30  481  static void hisi_lpc_acpi_remove(struct device *hostdev)
10e62b47973b0b John Garry 2019-07-30  482  {
10e62b47973b0b John Garry 2019-07-30  483  	struct acpi_device *adev = ACPI_COMPANION(hostdev);
10e62b47973b0b John Garry 2019-07-30  484  	struct acpi_device *child;
10e62b47973b0b John Garry 2019-07-30  485  
10e62b47973b0b John Garry 2019-07-30  486  	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
10e62b47973b0b John Garry 2019-07-30  487  
10e62b47973b0b John Garry 2019-07-30 @488  	list_for_each_entry(child, &adev->children, node)
10e62b47973b0b John Garry 2019-07-30  489  		acpi_device_clear_enumerated(child);
10e62b47973b0b John Garry 2019-07-30  490  }
10e62b47973b0b John Garry 2019-07-30  491  

:::::: The code at line 488 was first introduced by commit
:::::: 10e62b47973b0b0ceda076255bcb147b83e20517 bus: hisi_lpc: Add .remove method to avoid driver unbind crash

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Wei Xu <xuwei5@hisilicon.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
