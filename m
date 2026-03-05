Return-Path: <linux-acpi+bounces-21458-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDKaIxcBqmm9JQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21458-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 23:17:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE6E218D65
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D4E30238CA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B6361665;
	Thu,  5 Mar 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQ7r0W9Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DD3537E5;
	Thu,  5 Mar 2026 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749045; cv=none; b=tXqs00nnYBzuN+ZaFZGJqHkGOHeZfRDtBlPD5RJWofYko3I9hpbUhQAl8Fw8rCeUb+WR7fkadwc1f4C5E7+adj5SyekV0gYPQalY6ODEkfZIx6fKwv7m/QH2nRPEoXwDFdW9ka/orR56vYyFiJGqtU5sx/lnQnvd0y7upg5fdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749045; c=relaxed/simple;
	bh=TOSnNJAcyfszGiciPXHb/LfpyOAnd65hhX0td1m7EMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otvbJ3Km36VRXpMHofeyTW+AMXqX1kn5Fc13B65X9CXmmeZ2R1+sbzg2Pxh02Or1o+/sGEVorK59+6gdrVAuW+ImK6+s+fddoRwV8EcZY33sxgZjNV2H9Bu24LUF305Go562jukgHJY7eIpbvOWMyU6766IBdnTwS5P+hr5Ez+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQ7r0W9Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772749045; x=1804285045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TOSnNJAcyfszGiciPXHb/LfpyOAnd65hhX0td1m7EMs=;
  b=YQ7r0W9QHFsQWkENuYrGaY1/7z78pk2vVFSURJSA86WdKL+2cWm5PDaS
   nwWTkQnRSKhA/Z2onRxJqHJeP8sLSTxTrmLbkNgdoo4lZA9z1OFR/gOcy
   /E9vjZfylvT+lTzmi5YBDFKxh7p9wv/hCfjoV4ubLaxFpmED81HXdT4Hg
   oeFSQkLDm8fbKVAo55VZFr1zU1MVXPrLNb+tuYPB7d0x84BfFPn0zhFVr
   vnz4US07kG0qT96XMhy7cL/ktr6Is1vUJTf0REYz/yoQj0W45xSf+1FjS
   yQa8cDzOVHlQtYTUcBdvp11wFGgpDKM7+u079DNy2xlfA1+vo4bibVNth
   A==;
X-CSE-ConnectionGUID: vqdoJgqBRfKNuLt3+ga8zg==
X-CSE-MsgGUID: QV2tdaX2QbC+zBy0u7nOZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85324191"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85324191"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 14:17:24 -0800
X-CSE-ConnectionGUID: tdYLfnszSNai0UVBAgw4KA==
X-CSE-MsgGUID: MvMd0kxxReqg+fhdyeenGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="256719701"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Mar 2026 14:17:16 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyH0I-000000001Gs-3HQP;
	Thu, 05 Mar 2026 22:17:10 +0000
Date: Fri, 6 Mar 2026 06:16:26 +0800
From: kernel test robot <lkp@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	wei.huang2@amd.com, jonathan.cameron@huawei.com,
	wangzhou1@hisilicon.com, wanghuiqiang@huawei.com,
	liuyonglong@huawei.com
Subject: Re: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Message-ID: <202603060659.PCGzwYNn-lkp@intel.com>
References: <20260305083650.54611-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305083650.54611-1-fengchengwen@huawei.com>
X-Rspamd-Queue-Id: 8DE6E218D65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21458-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Chengwen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus arm64/for-next/core rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v7.0-rc2 next-20260305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-get-cpu-steer-tag-fail-on-ARM64-platform/20260305-164057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260305083650.54611-1-fengchengwen%40huawei.com
patch subject: [PATCH v2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260306/202603060659.PCGzwYNn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060659.PCGzwYNn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060659.PCGzwYNn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:2649:5: warning: no previous prototype for 'acpi_get_cpu_acpi_id' [-Wmissing-prototypes]
    2649 | int acpi_get_cpu_acpi_id(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/acpi_get_cpu_acpi_id +2649 arch/x86/kernel/cpu/common.c

  2648	
> 2649	int acpi_get_cpu_acpi_id(unsigned int cpu)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

