Return-Path: <linux-acpi+bounces-12922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C421A82E4D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 20:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17EE1B80EEA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EC277037;
	Wed,  9 Apr 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xqjx5XGv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E1277020;
	Wed,  9 Apr 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222238; cv=none; b=Gnz4o+QucwjYqlkvSPuSUDC+DWYV4kTh6a5LCxlAHsQh0ldkoOaT6UJ4blf1nJpL3nOgc6EaakXhE0ZxdjRDTFgcsx17bF4n6wnTxdadVJtXkNev8kRKe9ON72gzufLdJufAO4tGz7+E1jH4vVa2oyplTQrZujfayJDk+jdrSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222238; c=relaxed/simple;
	bh=DK5ctdqUuWwG61zHU/doen2mUmd04GA6ljylHuv86v0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mv/lQKtcjhmwy+Q8HpzMxdyQFsaHPA9EQlUeJPA3cKwLE037d1kONY/jcvxTtgzlULhoFVOt9Fj4iwVKtp3lwwra613JZw1MnukhkioV7GEsjcCKti4Ecokl4/jnLtsTVfbhqHywLjvjUPhc/q/YWVkY2aQuibbRDuH6KASUi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xqjx5XGv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744222235; x=1775758235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DK5ctdqUuWwG61zHU/doen2mUmd04GA6ljylHuv86v0=;
  b=Xqjx5XGvHgAjQVyxNVrzg0GtH8sLk8Jecm7+dtIORSG0vZYtPuH+l8Z2
   M7i6nnptDpCJOb4WS8f0Kk5KCIOIfdjtVREs7KXyNQ5Qw/9eQo8lkyAae
   ZoTvO7bDkUyr2/j1pfirc7dALPVRjsJ/p1GXTbIRNs6RnXxtJFfxcO5Mt
   2dLbIcR8RwO2+/EF9+Xn6Xvq/5HUHxzPacHI64C/frSJRPzMtgMMJxFXQ
   JIEeiOPcG0/ZQUeK5JuX3BSdttNGXFLiulB6qDaSwgCITyMFSAi0ZaRvt
   w/+6UEGvuEUTUBW5bu5Per2/mpr6DzjgLXqEJe5LELE/c3TlSHvTE7RGE
   A==;
X-CSE-ConnectionGUID: lVWEruxXQMC90bl8MVStAQ==
X-CSE-MsgGUID: 3mAgYaK2R0euBAjTk1KYUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44855882"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="44855882"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:10:34 -0700
X-CSE-ConnectionGUID: hSrBF16MR/ipFHagVQZGPQ==
X-CSE-MsgGUID: jKVap1QuRPu80Vth7TEg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="151839648"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 11:10:32 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2Zsb-0009B9-36;
	Wed, 09 Apr 2025 18:10:29 +0000
Date: Thu, 10 Apr 2025 02:10:04 +0800
From: kernel test robot <lkp@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 39/52]
 drivers/acpi/apei/einj-core.c:877:43: error: expected identifier
Message-ID: <202504100128.AjbVDQgK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   089d4e79e2c932faef79e0061cb874000f755009
commit: 4ec052af63c58a62a896508cc5f8a0a2f516a590 [39/52] ACPI: APEI: EINJ: Transition to the faux device interface
config: x86_64-buildonly-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250410/202504100128.AjbVDQgK-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504100128.AjbVDQgK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504100128.AjbVDQgK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/apei/einj-core.c:877:43: error: expected identifier
     877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
         |                                           ^
   include/linux/init.h:397:21: note: expanded from macro '__exit_p'
     397 | #define __exit_p(x) NULL
         |                     ^
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^
>> drivers/acpi/apei/einj-core.c:877:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
         | ^
         | int
>> drivers/acpi/apei/einj-core.c:877:19: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
     877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
         |                   ^                                                  
         |                                                                      void
   3 errors generated.


vim +877 drivers/acpi/apei/einj-core.c

   876	
 > 877	module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
   878	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

