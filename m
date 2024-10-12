Return-Path: <linux-acpi+bounces-8738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCB99B780
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 00:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296C12827E5
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8119ABC5;
	Sat, 12 Oct 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3zml3fN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4F14D457;
	Sat, 12 Oct 2024 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728772766; cv=none; b=N6vZlOJrCOMBofVUCElrga8rbawd1+YlmAwCFCjr85vUIwL4ylUTl9rHAOZ89fTZLysw2odPM6UcbSYid0RE0nRRpOcJS+DA7uclkLh3bUwjbu7gA5wO0QEXDoZZEHvXspzYtNJ7grToXv3WcsTjHLcjwvav0u/MFvgPTEymCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728772766; c=relaxed/simple;
	bh=vUqSywD6bEG5s9eVMG4TABdSWJ+YjqAfWvG2aa+0MbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o85uibdIIPhAT8TkbQwSUOp90zKYQKUecUTald8ULbJrrvO1Bmi4cEp0yXH9NTZod4vYWrn5RbHSOhSrXYOVtngAmNc1N0pF8miwcFcOVG6ioFhX/g32l+SuBrKjCwvb9SRPZZbcjPECQHGPHz8VejsRQ/F4wEU6XNylQLL3SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3zml3fN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728772765; x=1760308765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vUqSywD6bEG5s9eVMG4TABdSWJ+YjqAfWvG2aa+0MbM=;
  b=O3zml3fN0lnQBZPICyPct2wTr8WhVhSpFXFL/zRW9FHTaXsvip12rYkK
   IdRhko+1hdmHGmhW9pEfHEnNHesqreQ72iap20/vvc7rNXjN+D9WDiPE/
   3vJaxuwCalIp2ulvOBEXrZQrLEM5JVps2DjjwSwgQv7nckdyybWFdgXcA
   2NmkPZUTVqpvIKpm872kztV+LEYRVn2mnOW5bS1576Z2zil5Kfmem4GPo
   kEhzM7EftZ5m+4jdiOfdmiJtoOqm/0QmXILkljwSQoagSAGrMoR29ddGn
   AzLnHaeAhYUcJEj9Yi34+zzXQJcZy62DCymbfvzW3vqCuF+IkplqqtxSn
   Q==;
X-CSE-ConnectionGUID: sTmqFo6HRgymnbPYc+2//Q==
X-CSE-MsgGUID: IJhVJsojQ3i0fWrPugVUng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39268038"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39268038"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 15:39:24 -0700
X-CSE-ConnectionGUID: xUWRXF1LQhqVkyRqWFD5Jw==
X-CSE-MsgGUID: E3YglmguSgeChnM50lXO1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107953216"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Oct 2024 15:39:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szklb-000DoJ-2L;
	Sat, 12 Oct 2024 22:39:19 +0000
Date: Sun, 13 Oct 2024 06:38:42 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi: processor_perflib: extend X86 dependency
Message-ID: <202410130611.9S3HzhgF-lkp@intel.com>
References: <20241011061948.3211423-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011061948.3211423-3-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus groeck-staging/hwmon-next soc/for-next linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/acpi-allow-building-without-CONFIG_HAS_IOPORT/20241011-142245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241011061948.3211423-3-arnd%40kernel.org
patch subject: [PATCH v2 3/3] acpi: processor_perflib: extend X86 dependency
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20241013/202410130611.9S3HzhgF-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410130611.9S3HzhgF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410130611.9S3HzhgF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/processor_perflib.c:27:21: warning: unused variable 'performance_mutex' [-Wunused-variable]
      27 | static DEFINE_MUTEX(performance_mutex);
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/mutex.h:112:15: note: expanded from macro 'DEFINE_MUTEX'
     112 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~
   1 warning generated.


vim +/performance_mutex +27 drivers/acpi/processor_perflib.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  26  
65c19bbd28cba5 Arjan van de Ven 2006-04-27 @27  static DEFINE_MUTEX(performance_mutex);
^1da177e4c3f41 Linus Torvalds   2005-04-16  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

