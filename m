Return-Path: <linux-acpi+bounces-18782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08724C4FE9C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 22:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FE34CFF6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0C28D829;
	Tue, 11 Nov 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqhNjnI5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AED35CBCE;
	Tue, 11 Nov 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897710; cv=none; b=e+FPcJmmDr1fLGfabpS0CYk6iLEXBBXyloPUBFeyat7pmgorgXKKev/1RBWeDhEbEzmZhWRBIjSz8gpUoPOOjHgvKHhPmy4vbGAiZ+VKv5LnBxFAVTTPbLVYivaRqgyjHZZuOBZExGbKI6rWmMRPsoovdz2aFS3+CJcm+zR2Cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897710; c=relaxed/simple;
	bh=F8kUJ5Ca0Q/VLgfjBZjIfls7yiAR0SUZgulcT0hiWGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2XfE1fsJz5XR/hV2KlrODDDZWPvnUxg8lmVfeypoiTDGOYvrE6EIUVoSFR0oiDUG9M7SjmJa8yMfOnxuONHF5tpmjDgSkhd8BM3chQMst6rEeEk9ZnJe7O54YhinsvBQJd4M9/QC6pLXdXUvJmgdgU2xh/gvfzPdzEp1Dq3vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqhNjnI5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762897709; x=1794433709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8kUJ5Ca0Q/VLgfjBZjIfls7yiAR0SUZgulcT0hiWGk=;
  b=jqhNjnI5OufFZwywj04X5HmrbxjUIUqcKWDI7Rk/7DlfXhH+7YMVgmU6
   a6vI7QcvdZmzow2SigxSNJqthbk29ZoQqKKvFJgqSNcP5BI7RDVTIpM8y
   E399c3Q2FjfoZObpz7Pd9FOCqzrrx6d5tOxKU4xsMMhgAqw5d7GVb5t+F
   VOXw4ytcB92C/tlko3n6uyTZ046LRCls429POz03U/VFdMtedxm/duRWn
   9Rv3hjO9t+kf31J+aaI4iFwfZXFyuCpLmf4nXTNFJxygHNyrRWj78J2L2
   /wo87gcf2ViC13F37JTjo/HQbpuRFbzW61MjupSNF5w5G00bnMG9WfWVI
   g==;
X-CSE-ConnectionGUID: 2g680cU4QxC6AjgSsKZozg==
X-CSE-MsgGUID: 5yTvcR+0Q1KsH+AaUED+BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64166130"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64166130"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 13:48:28 -0800
X-CSE-ConnectionGUID: 2wJAG1AZTjCP8UXHia7dOw==
X-CSE-MsgGUID: XFehgl/8R/aZnW+fcpPXZw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Nov 2025 13:48:26 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIwDv-0003bD-1K;
	Tue, 11 Nov 2025 21:48:23 +0000
Date: Wed, 12 Nov 2025 05:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Tomassetti <andrea.tomassetti@sipearl.com>, sudeep.holla@arm.com,
	jassisinghbrar@gmail.com, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrea Tomassetti <andrea.tomassetti@sipearl.com>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	olivierdautricourt@gmail.com,
	Thibault Cantori <thibault.cantori@sipearl.com>,
	Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Subject: Re: [PATCH] mailbox: pcc: support polling mode when there is no
 platform IRQ
Message-ID: <202511120558.Cln7LF6M-lkp@intel.com>
References: <20251110150825.3548819-1-andrea.tomassetti@sipearl.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110150825.3548819-1-andrea.tomassetti@sipearl.com>

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge jassibrar-mailbox/for-next linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Tomassetti/mailbox-pcc-support-polling-mode-when-there-is-no-platform-IRQ/20251110-232950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251110150825.3548819-1-andrea.tomassetti%40sipearl.com
patch subject: [PATCH] mailbox: pcc: support polling mode when there is no platform IRQ
config: i386-buildonly-randconfig-004-20251111 (https://download.01.org/0day-ci/archive/20251112/202511120558.Cln7LF6M-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120558.Cln7LF6M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/acpi_pcc.o: in function `acpi_pcc_address_space_handler':
>> acpi_pcc.c:(.text+0x69): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

