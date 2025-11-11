Return-Path: <linux-acpi+bounces-18781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5226C4F71A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4ADB4E5F6F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058931F91C8;
	Tue, 11 Nov 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNCxDwSD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC4393DF2;
	Tue, 11 Nov 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885811; cv=none; b=kN8eZfqn3NF0i7hcZ++AW8vWGrYaN+fVdbTc2dNYgisclczslPUddPjQaFeEpBw77bGp6ESNu9hFqOtDEay9kcyhP5S5NzdItwVzl6P6E7Rel3alCbTHx93ltbNak373nrILZbn0wx6vDLvIDt5zSWW4CpxBM2lLk7Xg9L+bCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885811; c=relaxed/simple;
	bh=frb+CMe5pTDhXPmHuFvxkNrj7NrLew9l+h3r+EAkinI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8YUrHTaOgLvWKgsZMMcrJJS6oXxTtjYO/bTgWJtdRsrbYZtBA5xu++CvfBvKXLY1XpZOpvv6B7Scu8ENL9JsmJeUYV8TXapyMyvlRkdsmreeA5eroaSv3SK3bGu7K3AbisxH40K0OnmAW4YWpmyQmhu4oBYOv1+WBK7WY/kSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNCxDwSD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762885810; x=1794421810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frb+CMe5pTDhXPmHuFvxkNrj7NrLew9l+h3r+EAkinI=;
  b=eNCxDwSD444woRvDi/86oVYY8L3gnPG/bGQ0csVwNyapRMrcjD2ovisj
   8fGG5r3Ruwl3FRs+m7uMsk4TV7Dr8yU3jfumofkkS+ligDwN356/sbODj
   gW9l1aL45GqTUeP4tZIyPmjuFFmeR5a5RneR7n6AQdzD11faPHxzH2jSJ
   hV1kOKM1+NWbgE1Xgu5WYBMXIDLAQ1jwjgzNL34WUOlbcSBnO7iUI4U49
   mH4xbZsvbL1pSIg1R4xWobJ44ZkagItdjZeDtCrHLsm150Zh59J0+rrf+
   Euxwm8UNCysezBq5k1SgaSOtaIfdmV5MTMtSv5ILAjoBIFLO4NC0ATp3D
   A==;
X-CSE-ConnectionGUID: AkVFAfOLTuisSC2NKcwwqg==
X-CSE-MsgGUID: UYkWZKN4SLyiVZySlZFjpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68814607"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="68814607"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 10:30:09 -0800
X-CSE-ConnectionGUID: 5AWub5v9Qr6Fkq5BdtFDIw==
X-CSE-MsgGUID: bSMZ8MmNSxyWCMotWrlxAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="189753925"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Nov 2025 10:30:07 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIt81-0003Tb-0X;
	Tue, 11 Nov 2025 18:30:05 +0000
Date: Wed, 12 Nov 2025 02:29:37 +0800
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
Message-ID: <202511120243.soxAFpqQ-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge jassibrar-mailbox/for-next linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Tomassetti/mailbox-pcc-support-polling-mode-when-there-is-no-platform-IRQ/20251110-232950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251110150825.3548819-1-andrea.tomassetti%40sipearl.com
patch subject: [PATCH] mailbox: pcc: support polling mode when there is no platform IRQ
config: i386-randconfig-061-20251111 (https://download.01.org/0day-ci/archive/20251112/202511120243.soxAFpqQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120243.soxAFpqQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/acpi_pcc.c:89:70: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *mssg @@     got void [noderef] __iomem *shmem @@
   drivers/acpi/acpi_pcc.c:89:70: sparse:     expected void *mssg
   drivers/acpi/acpi_pcc.c:89:70: sparse:     got void [noderef] __iomem *shmem

vim +89 drivers/acpi/acpi_pcc.c

    83	
    84	static acpi_status
    85	acpi_pcc_send_msg_polling(struct pcc_data *data)
    86	{
    87		int ret;
    88	
  > 89		ret = mbox_send_message(data->pcc_chan->mchan, data->pcc_chan->shmem);
    90		if (ret == -ETIME) {
    91			pr_err("PCC command executed timeout!\n");
    92			return AE_TIME;
    93		}
    94	
    95		if (ret < 0)
    96			return AE_ERROR;
    97	
    98		if (!mbox_client_peek_data(data->pcc_chan->mchan))
    99			return AE_ERROR;
   100	
   101		return AE_OK;
   102	}
   103	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

