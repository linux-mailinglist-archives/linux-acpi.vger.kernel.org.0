Return-Path: <linux-acpi+bounces-11684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B4A4AF42
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 05:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B50188DF92
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6F1BD9E3;
	Sun,  2 Mar 2025 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGC/cJGi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CB17C9F1
	for <linux-acpi@vger.kernel.org>; Sun,  2 Mar 2025 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740890360; cv=none; b=KtgVaWyvMwMhvQrJQmtQzevqFL/GWcEfBbWRe8UJuwwpr7ECqZHH2Fuit5G5tuPkjjp0Ieyznd8dUxIg/LmLnYpsrOnEla2joYIHthMxvZeMZS7YmTJ4TlI4M0vScAiSY9ocGOiUGWxtBqcY1/7MjvSovSZTf8PdW3qkxh7eW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740890360; c=relaxed/simple;
	bh=9PhrIp9yv02RWqI/rCYrohMCSsLmzPYpYHEMpgzUTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq+pceq9YntezwIBty0HMLrYLLDiiPJM1LLgyYyJcO+T0j70YIl8klG2hMWN5ge1Qp8HO1wyPbPLEZfP5UBOCo4e1wv8oT5k4caTf83qs1lTvjRrfjBhVWmQvUuTIVy7ypAeAkfrUTlzPCkllIDYRsxXwAvgrLsPquwSVEsS1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGC/cJGi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740890359; x=1772426359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PhrIp9yv02RWqI/rCYrohMCSsLmzPYpYHEMpgzUTzg=;
  b=BGC/cJGiVyccz2FAEjDThLDl/JeICcYfMdv0rr8Xt5s3bIGitxU/+VE2
   q7f4GZHUVNATd1ycpDkeLdxEyS0aYlUbqjpOhavLMvuPY49+grX5VBKYE
   qbM3S1awIkZ+XdGW6NKeyCsYiLltje6CSQAMMMg0dtmn/ckZmGg9vxE6k
   yB9/uPZKnB0qqXZEzgqBBBi3E1Jrg5GuptkdaiT7BTIuY+LKHQlu+CNYf
   DKrB1gDd9w56ORdyE6rha6UuzpYE1Ohv+9vuibhu5EY1kuN3685BL8rGC
   faqzbNTZZ+4gu1RK6RFZfQ8eP8aa3gwsc0rzITJrGXr4YUYse2HdkXCzu
   Q==;
X-CSE-ConnectionGUID: +dpdz0LDS+uo6gj48Lk4eA==
X-CSE-MsgGUID: cFoVv2GFSG+hA3wqFvBBUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41972370"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41972370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 20:39:18 -0800
X-CSE-ConnectionGUID: rIHpzWWYSsGmjxlQ73kKAw==
X-CSE-MsgGUID: SWt4Nsu8T2igf8jTX7YjWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="140922587"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Mar 2025 20:39:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tob6f-000H3m-2t;
	Sun, 02 Mar 2025 04:39:13 +0000
Date: Sun, 2 Mar 2025 12:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: mpagano@gentoo.org, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robert.moore@intel.com,
	rafael.j.wysocki@intel.com, Mike Pagano <mpagano@gentoo.org>
Subject: Re: [PATCH] ACPICA: fix build with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <202503021209.06wcSVPg-lkp@intel.com>
References: <20250228210834.811164-1-mpagano@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228210834.811164-1-mpagano@gentoo.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mpagano-gentoo-org/ACPICA-fix-build-with-GCC-15-due-to-Werror-unterminated-string-initialization/20250301-051004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250228210834.811164-1-mpagano%40gentoo.org
patch subject: [PATCH] ACPICA: fix build with GCC 15 due to -Werror=unterminated-string-initialization
config: x86_64-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503021209.06wcSVPg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021209.06wcSVPg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021209.06wcSVPg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/acpi/nfit/core.c: In function 'nfit_init':
>> include/linux/compiler_types.h:542:45: error: call to '__compiletime_assert_1081' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct acpi_table_nfit) != 40
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:523:25: note: in definition of macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/acpi/nfit/core.c:3489:9: note: in expansion of macro 'BUILD_BUG_ON'
    3489 |         BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_1081 +542 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  528  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  529  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  530  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  531  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  532  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  533   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  534   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  535   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  536   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  537   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  538   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  539   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  540   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  541  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @542  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  543  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

