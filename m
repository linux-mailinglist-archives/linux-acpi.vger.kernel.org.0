Return-Path: <linux-acpi+bounces-20482-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLioDa99cGmxYAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20482-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 08:18:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651D52B31
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 08:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 184B1667750
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A945BD4A;
	Wed, 21 Jan 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7CshbM7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9E4534B6;
	Wed, 21 Jan 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979745; cv=none; b=ArsksY754hqQMwuwmv1KUSmbQIgmlH8+TReqZU55P2k7Tidvx3jwQrJWr+bVd3Sr9GUWhnpc5sBRSIZgWGCunPqn41ff4Au0U9t6XpYOpqaL4BbQ9BqtbXiLAAlboddclTaw2xhWR3+vsE6SHrQndFjE1Tl5xGq+Tsdj6JWfuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979745; c=relaxed/simple;
	bh=pf3mRjeC+BlGoli8DPyQtWoOUlZv7J9jx8lHKT80B8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rddnUvWz60AwMk0zbHXIv9ZDwyH672OSIAz7TRFMC0vcyIEpxI/bvaoi046OnBZo3yywjW1t0DF42dBa34KAscWzIIi5pUKMV+478DubcNflJ7w5vwHzN6QZD5UKBTJ8aT6ACe1UyZIChcyy1ya8l1EPA2kl5ov0COGdyAp2vQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7CshbM7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768979744; x=1800515744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pf3mRjeC+BlGoli8DPyQtWoOUlZv7J9jx8lHKT80B8Q=;
  b=S7CshbM76KJQFCWrD4G/xxzd74KqJGfb/ZovVnxh1j+WcgkTcaZF9OqO
   BsVlLnLjX2hit0MuOqOY3Z1kITOEaPQjQJV+00b267aD5/uPNOaubswdD
   qK2FpjZuK9U41aEeJYjGm4nMZEWfMgPFujmbOslicXgL+0zSt0nngbf5K
   Mp8Al5Tx13cAm2z1cPBJRjQ8yzkkvfxU8DMB6xnJe9K2ss0bVefeUbxKM
   hCxM9uzdgp42MUzoeEFjs9x/ZdIokweVQyjgPh+ZHxzT3ezRQ+lWq9J45
   m0u8O8/SWzoTp4YpkOrHn7OTHcc8yNBBd2Xz4AVs6WQadVZr+9fVyRqoq
   w==;
X-CSE-ConnectionGUID: vhrFL4+/SNCQwzl6Ad7q5w==
X-CSE-MsgGUID: SeIlHX/9RoqWb3S72D1wMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57763798"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57763798"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:15:43 -0800
X-CSE-ConnectionGUID: IiK/5rXBT2yk2dxdBMzsrw==
X-CSE-MsgGUID: gLpJM9hoT2+5bZUjhqOyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="237620931"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jan 2026 23:15:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viSRG-00000000Q7l-3173;
	Wed, 21 Jan 2026 07:15:38 +0000
Date: Wed, 21 Jan 2026 15:15:35 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: PCI: simplify code with
 acpi_get_local_u64_address()
Message-ID: <202601211405.APuSRTdE-lkp@intel.com>
References: <20260120154015.1764021-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120154015.1764021-1-andriy.shevchenko@linux.intel.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20482-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9651D52B31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc6 next-20260120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-PCI-simplify-code-with-acpi_get_local_u64_address/20260121-004826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260120154015.1764021-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
config: x86_64-randconfig-161-20260121 (https://download.01.org/0day-ci/archive/20260121/202601211405.APuSRTdE-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601211405.APuSRTdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601211405.APuSRTdE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/pci_slot.c: In function 'check_slot':
>> drivers/acpi/pci_slot.c:60:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      60 |         if (acpi_get_local_u64_address(handle, &adr))
         |         ^~
   drivers/acpi/pci_slot.c:63:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      63 |                 goto out;
         |                 ^~~~
   drivers/acpi/pci_slot.c:63:17: error: label 'out' used but not defined
>> drivers/acpi/pci_slot.c:44:13: warning: unused variable 'device' [-Wunused-variable]
      44 |         int device = -1;
         |             ^~~~~~
>> drivers/acpi/pci_slot.c:64:9: warning: no return statement in function returning non-void [-Wreturn-type]
      64 |         }
         |         ^
   drivers/acpi/pci_slot.c: At top level:
>> drivers/acpi/pci_slot.c:67:9: warning: data definition has no type or storage class
      67 |         status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
         |         ^~~~~~
   drivers/acpi/pci_slot.c:67:9: error: type defaults to 'int' in declaration of 'status' [-Werror=implicit-int]
   drivers/acpi/pci_slot.c:67:40: error: 'handle' undeclared here (not in a function)
      67 |         status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
         |                                        ^~~~~~
   drivers/acpi/pci_slot.c:67:62: error: 'sun' undeclared here (not in a function)
      67 |         status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
         |                                                              ^~~
   drivers/acpi/pci_slot.c:68:9: error: expected identifier or '(' before 'if'
      68 |         if (ACPI_FAILURE(status)) {
         |         ^~
   drivers/acpi/pci_slot.c:74:9: warning: data definition has no type or storage class
      74 |         device = (adr >> 16) & 0xffff;
         |         ^~~~~~
   drivers/acpi/pci_slot.c:74:9: error: type defaults to 'int' in declaration of 'device' [-Werror=implicit-int]
   drivers/acpi/pci_slot.c:74:19: error: 'adr' undeclared here (not in a function); did you mean 'idr'?
      74 |         device = (adr >> 16) & 0xffff;
         |                   ^~~
         |                   idr
   drivers/acpi/pci_slot.c:75:4: error: expected '=', ',', ';', 'asm' or '__attribute__' before ':' token
      75 | out:
         |    ^
   drivers/acpi/pci_slot.c:77:9: error: expected identifier or '(' before 'return'
      77 |         return device;
         |         ^~~~~~
   drivers/acpi/pci_slot.c:78:1: error: expected identifier or '(' before '}' token
      78 | }
         | ^
   cc1: some warnings being treated as errors


vim +/if +60 drivers/acpi/pci_slot.c

    40	
    41	static int
    42	check_slot(acpi_handle handle, unsigned long long *sun)
    43	{
  > 44		int device = -1;
    45		unsigned long long sta;
    46		acpi_status status;
    47		u64 adr;
    48		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
    49	
    50		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
    51		pr_debug("Checking slot on path: %s\n", (char *)buffer.pointer);
    52	
    53		if (check_sta_before_sun) {
    54			/* If SxFy doesn't have _STA, we just assume it's there */
    55			status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
    56			if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_PRESENT))
    57				goto out;
    58		}
    59	
  > 60		if (acpi_get_local_u64_address(handle, &adr))
    61			pr_debug("_ADR returned with failure on %s\n",
    62				 (char *)buffer.pointer);
  > 63			goto out;
  > 64		}
    65	
    66		/* No _SUN == not a slot == bail */
  > 67		status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
    68		if (ACPI_FAILURE(status)) {
    69			pr_debug("_SUN returned %d on %s\n",
    70				 status, (char *)buffer.pointer);
    71			goto out;
    72		}
    73	
    74		device = (adr >> 16) & 0xffff;
    75	out:
    76		kfree(buffer.pointer);
    77		return device;
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

