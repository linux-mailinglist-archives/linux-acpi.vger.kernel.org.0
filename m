Return-Path: <linux-acpi+bounces-12761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC37A7C79B
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Apr 2025 06:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E8F1703C5
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Apr 2025 04:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A01B040D;
	Sat,  5 Apr 2025 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlyUtijj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF35953;
	Sat,  5 Apr 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743827987; cv=none; b=eEwa9HF67VmUcm6P3/WcLPQH9SEc361H/CAiUgJSlB1UMLmWbaSqocUYHYLNpKtDwkyVYKG0zu+6d07tvHR7wIdEkk2nv6PYJ4SWUweatS8cock3WKVoElWc8OoSBQPDTfOl6HEDEuXpiAamBrfeIJw2VOEidsjOy3DsY9uRRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743827987; c=relaxed/simple;
	bh=d2pgQYlkYLdy1r+Ab47pFziwrYKE6o0bQV2lrsGKecU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ9d476mGPsG4gq48ULWUNeGPfkDIWTRbMCEac4mT8+ZKzgdZAvKmsVBd2TMWcsat8cGX/WQuWzT9KzkrtKvCV5JbNvJbvO0j+nxbqjvhsoIij1hIQCm0UNtCshhsZAWrvixmI4f4PdYYJRacDioC6MZAcHDvQroLVSIDrzxV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlyUtijj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743827985; x=1775363985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2pgQYlkYLdy1r+Ab47pFziwrYKE6o0bQV2lrsGKecU=;
  b=SlyUtijjBCXirRUFWP6/ZYfG1DFYkGdlAuPEMxY1fpNFWVXX6Q2d6pQ5
   GxZPW0edIfryPiAlCsgF28nPZRaQnZZjo7Lm1QMOGZoLg2/L4GdATrzUQ
   zfiQ02yWq4AIw8N6+yFsVLB6R7a834a4w2tfdUl+AplPjk904aaHPvSoJ
   EopjfPqAEi3uDMGueSwa7o2yU24PIqViNwa7d0BNuXAu4/ubMwJjV0+Hp
   asgG7NAiPXxKHxrdkXDRNOeaOuWohltTBcT/CNGK3901MdJHSBi56POJl
   O9QczrXg+FGJs2cD3NkPoxLtUt2/KGn1WszdRqCBOJiufF1DTOB4xeGm4
   Q==;
X-CSE-ConnectionGUID: 3YEmLrEkRBCiihYsqNbbuA==
X-CSE-MsgGUID: PtinCn1VRfu2qunrRU5PWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="44523601"
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="44523601"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 21:39:44 -0700
X-CSE-ConnectionGUID: MMkCpUBEQDa4JhAgjHJeWg==
X-CSE-MsgGUID: pWpUwB2MTUmYN3wS8xnBEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="127997702"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Apr 2025 21:39:41 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0vJi-0001oZ-2W;
	Sat, 05 Apr 2025 04:39:38 +0000
Date: Sat, 5 Apr 2025 12:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Salem <x0rw3ll@gmail.com>, robert.moore@intel.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
Message-ID: <202504051219.T47PnjYj-lkp@intel.com>
References: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll@gmail.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on b3c623b9a94f7f798715c87e7a75ceeecf15292f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Salem/ACPI-PRM-apply-ACPI_NONSTRING-annotation/20250404-162651
base:   b3c623b9a94f7f798715c87e7a75ceeecf15292f
patch link:    https://lore.kernel.org/r/dcc3a018fb28899b277df2e154740d59d4e404af.1743754416.git.x0rw3ll%40gmail.com
patch subject: [PATCH 2/2] ACPI: sysfs: apply ACPI_NONSTRING annotation
config: loongarch-randconfig-002-20250405 (https://download.01.org/0day-ci/archive/20250405/202504051219.T47PnjYj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504051219.T47PnjYj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504051219.T47PnjYj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/sysfs.c:310:38: error: expected ':', ',', ';', '}' or '__attribute__' before 'ACPI_NONSTRING'
     310 |         char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
         |                                      ^~~~~~~~~~~~~~
   drivers/acpi/sysfs.c: In function 'acpi_table_show':
>> drivers/acpi/sysfs.c:331:43: error: 'struct acpi_table_attr' has no member named 'name'
     331 |         status = acpi_get_table(table_attr->name, table_attr->instance,
         |                                           ^~
>> drivers/acpi/sysfs.c:331:61: error: 'struct acpi_table_attr' has no member named 'instance'
     331 |         status = acpi_get_table(table_attr->name, table_attr->instance,
         |                                                             ^~
   In file included from include/acpi/acpi.h:24,
                    from include/linux/acpi.h:26,
                    from drivers/acpi/sysfs.c:8:
   drivers/acpi/sysfs.c: In function 'acpi_table_attr_init':
   drivers/acpi/sysfs.c:351:37: error: 'struct acpi_table_attr' has no member named 'name'
     351 |         ACPI_COPY_NAMESEG(table_attr->name, table_header->signature);
         |                                     ^~
   include/acpi/actypes.h:501:66: note: in definition of macro 'ACPI_CAST_PTR'
     501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
         |                                                                  ^
   drivers/acpi/sysfs.c:351:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
     351 |         ACPI_COPY_NAMESEG(table_attr->name, table_header->signature);
         |         ^~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12:
>> include/linux/container_of.h:20:54: error: 'struct acpi_table_attr' has no member named 'node'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:770:20: note: in expansion of macro 'list_first_entry'
     770 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:27: error: expression in static assertion is not an integer
     498 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:770:20: note: in expansion of macro 'list_first_entry'
     770 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/loongarch/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:370,
                    from include/linux/build_bug.h:5:
>> include/linux/stddef.h:16:33: error: 'struct acpi_table_attr' has no member named 'node'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:612:9: note: in expansion of macro 'list_entry'
     612 |         list_entry((ptr)->next, type, member)
         |         ^~~~~~~~~~
   include/linux/list.h:770:20: note: in expansion of macro 'list_first_entry'
     770 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
         |                    ^~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/resource_ext.h:9,
                    from include/linux/acpi.h:13:
>> include/linux/list.h:761:26: error: 'struct acpi_table_attr' has no member named 'node'
     761 |         list_is_head(&pos->member, (head))
         |                          ^~
   include/linux/list.h:771:15: note: in expansion of macro 'list_entry_is_head'
     771 |              !list_entry_is_head(pos, head, member);                    \
         |               ^~~~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:5:
   include/linux/list.h:645:25: error: 'struct acpi_table_attr' has no member named 'node'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:25: error: 'struct acpi_table_attr' has no member named 'node'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/container_of.h:20:54: error: 'struct acpi_table_attr' has no member named 'node'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:25: error: 'struct acpi_table_attr' has no member named 'node'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                         ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:27: error: expression in static assertion is not an integer
     498 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct acpi_table_attr' has no member named 'node'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:28: note: in expansion of macro 'offsetof'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   include/linux/list.h:601:9: note: in expansion of macro 'container_of'
     601 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ^~~~~~~~~~
   include/linux/list.h:772:20: note: in expansion of macro 'list_next_entry'
     772 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:353:9: note: in expansion of macro 'list_for_each_entry'
     353 |         list_for_each_entry(attr, &acpi_table_attr_list, node) {
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:354:52: error: 'struct acpi_table_attr' has no member named 'name'
     354 |                 if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
         |                                                    ^~
   include/acpi/actypes.h:501:66: note: in definition of macro 'ACPI_CAST_PTR'
     501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
         |                                                                  ^
   drivers/acpi/sysfs.c:354:21: note: in expansion of macro 'ACPI_COMPARE_NAMESEG'
     354 |                 if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:354:64: error: 'struct acpi_table_attr' has no member named 'name'
     354 |                 if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
         |                                                                ^~
   include/acpi/actypes.h:501:66: note: in definition of macro 'ACPI_CAST_PTR'
     501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
         |                                                                  ^
   drivers/acpi/sysfs.c:354:21: note: in expansion of macro 'ACPI_COMPARE_NAMESEG'
     354 |                 if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:355:39: error: 'struct acpi_table_attr' has no member named 'instance'
     355 |                         if (table_attr->instance < attr->instance)
         |                                       ^~
   drivers/acpi/sysfs.c:355:56: error: 'struct acpi_table_attr' has no member named 'instance'
     355 |                         if (table_attr->instance < attr->instance)
         |                                                        ^~
   drivers/acpi/sysfs.c:356:43: error: 'struct acpi_table_attr' has no member named 'instance'
     356 |                                 table_attr->instance = attr->instance;
         |                                           ^~
   drivers/acpi/sysfs.c:356:60: error: 'struct acpi_table_attr' has no member named 'instance'
     356 |                                 table_attr->instance = attr->instance;
         |                                                            ^~
   drivers/acpi/sysfs.c:358:19: error: 'struct acpi_table_attr' has no member named 'instance'
     358 |         table_attr->instance++;
         |                   ^~
   drivers/acpi/sysfs.c:359:23: error: 'struct acpi_table_attr' has no member named 'instance'
     359 |         if (table_attr->instance > ACPI_MAX_TABLE_INSTANCES) {
         |                       ^~
   In file included from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:61,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11:
   drivers/acpi/sysfs.c:360:72: error: 'struct acpi_table_attr' has no member named 'name'
     360 |                 pr_warn("%4.4s: too many table instances\n", table_attr->name);
         |                                                                        ^~
   include/linux/printk.h:479:33: note: in definition of macro 'printk_index_wrap'
     479 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:560:9: note: in expansion of macro 'printk'
     560 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/acpi/sysfs.c:360:17: note: in expansion of macro 'pr_warn'
     360 |                 pr_warn("%4.4s: too many table instances\n", table_attr->name);
         |                 ^~~~~~~
>> drivers/acpi/sysfs.c:364:37: error: 'struct acpi_table_attr' has no member named 'filename'
     364 |         ACPI_COPY_NAMESEG(table_attr->filename, table_header->signature);
         |                                     ^~
   include/acpi/actypes.h:501:66: note: in definition of macro 'ACPI_CAST_PTR'
     501 | #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
         |                                                                  ^
   drivers/acpi/sysfs.c:364:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
     364 |         ACPI_COPY_NAMESEG(table_attr->filename, table_header->signature);
         |         ^~~~~~~~~~~~~~~~~
   drivers/acpi/sysfs.c:365:19: error: 'struct acpi_table_attr' has no member named 'filename'
     365 |         table_attr->filename[ACPI_NAMESEG_SIZE] = '\0';
         |                   ^~
   drivers/acpi/sysfs.c:366:23: error: 'struct acpi_table_attr' has no member named 'instance'
     366 |         if (table_attr->instance > 1 || (table_attr->instance == 1 &&
         |                       ^~
   drivers/acpi/sysfs.c:366:52: error: 'struct acpi_table_attr' has no member named 'instance'
     366 |         if (table_attr->instance > 1 || (table_attr->instance == 1 &&
         |                                                    ^~
   drivers/acpi/sysfs.c:370:36: error: 'struct acpi_table_attr' has no member named 'instance'
     370 |                          table_attr->instance);
         |                                    ^~
   drivers/acpi/sysfs.c:371:34: error: 'struct acpi_table_attr' has no member named 'filename'
     371 |                 strcat(table_attr->filename, instance_str);
         |                                  ^~
   drivers/acpi/sysfs.c:376:48: error: 'struct acpi_table_attr' has no member named 'filename'
     376 |         table_attr->attr.attr.name = table_attr->filename;
         |                                                ^~
   drivers/acpi/sysfs.c: In function 'acpi_sysfs_table_handler':
>> drivers/acpi/sysfs.c:397:42: error: 'struct acpi_table_attr' has no member named 'node'
     397 |                 list_add_tail(&table_attr->node, &acpi_table_attr_list);
         |                                          ^~
   drivers/acpi/sysfs.c: In function 'acpi_tables_sysfs_init':
   drivers/acpi/sysfs.c:545:42: error: 'struct acpi_table_attr' has no member named 'node'
     545 |                 list_add_tail(&table_attr->node, &acpi_table_attr_list);
         |                                          ^~


vim +310 drivers/acpi/sysfs.c

   307	
   308	struct acpi_table_attr {
   309		struct bin_attribute attr;
 > 310		char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
   311		int instance;
   312		char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] ACPI_NONSTRING;
   313		struct list_head node;
   314	};
   315	
   316	struct acpi_data_attr {
   317		struct bin_attribute attr;
   318		u64	addr;
   319	};
   320	
   321	static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
   322				       const struct bin_attribute *bin_attr, char *buf,
   323				       loff_t offset, size_t count)
   324	{
   325		struct acpi_table_attr *table_attr =
   326		    container_of(bin_attr, struct acpi_table_attr, attr);
   327		struct acpi_table_header *table_header = NULL;
   328		acpi_status status;
   329		ssize_t rc;
   330	
 > 331		status = acpi_get_table(table_attr->name, table_attr->instance,
   332					&table_header);
   333		if (ACPI_FAILURE(status))
   334			return -ENODEV;
   335	
   336		rc = memory_read_from_buffer(buf, count, &offset, table_header,
   337				table_header->length);
   338		acpi_put_table(table_header);
   339		return rc;
   340	}
   341	
   342	static int acpi_table_attr_init(struct kobject *tables_obj,
   343					struct acpi_table_attr *table_attr,
   344					struct acpi_table_header *table_header)
   345	{
   346		struct acpi_table_header *header = NULL;
   347		struct acpi_table_attr *attr = NULL;
   348		char instance_str[ACPI_INST_SIZE];
   349	
   350		sysfs_attr_init(&table_attr->attr.attr);
   351		ACPI_COPY_NAMESEG(table_attr->name, table_header->signature);
   352	
   353		list_for_each_entry(attr, &acpi_table_attr_list, node) {
   354			if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
   355				if (table_attr->instance < attr->instance)
   356					table_attr->instance = attr->instance;
   357		}
   358		table_attr->instance++;
   359		if (table_attr->instance > ACPI_MAX_TABLE_INSTANCES) {
   360			pr_warn("%4.4s: too many table instances\n", table_attr->name);
   361			return -ERANGE;
   362		}
   363	
 > 364		ACPI_COPY_NAMESEG(table_attr->filename, table_header->signature);
   365		table_attr->filename[ACPI_NAMESEG_SIZE] = '\0';
   366		if (table_attr->instance > 1 || (table_attr->instance == 1 &&
   367						 !acpi_get_table
   368						 (table_header->signature, 2, &header))) {
   369			snprintf(instance_str, sizeof(instance_str), "%u",
   370				 table_attr->instance);
   371			strcat(table_attr->filename, instance_str);
   372		}
   373	
   374		table_attr->attr.size = table_header->length;
   375		table_attr->attr.read_new = acpi_table_show;
   376		table_attr->attr.attr.name = table_attr->filename;
   377		table_attr->attr.attr.mode = 0400;
   378	
   379		return sysfs_create_bin_file(tables_obj, &table_attr->attr);
   380	}
   381	
   382	acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
   383	{
   384		struct acpi_table_attr *table_attr;
   385	
   386		switch (event) {
   387		case ACPI_TABLE_EVENT_INSTALL:
   388			table_attr = kzalloc(sizeof(*table_attr), GFP_KERNEL);
   389			if (!table_attr)
   390				return AE_NO_MEMORY;
   391	
   392			if (acpi_table_attr_init(dynamic_tables_kobj,
   393						 table_attr, table)) {
   394				kfree(table_attr);
   395				return AE_ERROR;
   396			}
 > 397			list_add_tail(&table_attr->node, &acpi_table_attr_list);
   398			break;
   399		case ACPI_TABLE_EVENT_LOAD:
   400		case ACPI_TABLE_EVENT_UNLOAD:
   401		case ACPI_TABLE_EVENT_UNINSTALL:
   402			/*
   403			 * we do not need to do anything right now
   404			 * because the table is not deleted from the
   405			 * global table list when unloading it.
   406			 */
   407			break;
   408		default:
   409			return AE_BAD_PARAMETER;
   410		}
   411		return AE_OK;
   412	}
   413	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

