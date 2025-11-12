Return-Path: <linux-acpi+bounces-18783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB194C501C5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 01:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4564E237A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8EA83A14;
	Wed, 12 Nov 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScVEpeae"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C44502F;
	Wed, 12 Nov 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906063; cv=none; b=ps5m3+mTWdrg3aIqPFhYoVOuXNBT9Tk/dh50P7UFlZMarh2UAeN8T8PPOHV2GaC/AuQOQYkOqLZxy8+8zYeuUP0UL1PhH+LhF2oB4eLaY6Zv9Va54BlnejlpmNv32jxDNy0I18GR24WcREAt33YGTmBEqS4EmJ3pjARJhAuRGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906063; c=relaxed/simple;
	bh=AeZ5+CRwC3gcklLzD8Zp3pnyW1bu7e+fRQnoDRjZ7hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg6dLVb/if6OECk5CuDeOjm6qerEyJ3RnMqeUzUAf8wBSTFiRFYC0q04/9DZa1/vtkyQkV2vqo1EMWKbP2/ZYzsVGID9sCyvlPT2ynAUhvfM/GH4Az5YKexRu/E7JwajIyvO9/z8yw0T6gxSkiAk5RmY5Rgg5pqODEftii3dmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScVEpeae; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762906061; x=1794442061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AeZ5+CRwC3gcklLzD8Zp3pnyW1bu7e+fRQnoDRjZ7hY=;
  b=ScVEpeaeXO4efcNwmL2JxqSkBaux78P5CEMwqyfLnhrWrD81Cx5n1Fnx
   i07ooW7KLfQmt7J7N4cZw6W7VPpWNHkekn+6J0ur6iu05o6E1sPu0j0OS
   /BLZP3VvxRxUgresGiorYS7DGCWrI/8vh9iy0QSjLDbX0Rlm3cX3FaeHZ
   EUg9NmSSatTAE9rlTzWfPY8laUsPQoWvLnuw0XA33mLW4LmZvBDTYylGn
   Jn23OHosJFMRwGeo1VowNycVkRZCTkZF/VUYDOGmF95FovQT6lw/vyuK/
   cDjR5LhTMkvNEbuWxSLq/cSxhiD4wEmFLAe8TvNJ1sC5lfnWLUlDkGxR1
   w==;
X-CSE-ConnectionGUID: ZhApdah4T82ITZwBvQKa0A==
X-CSE-MsgGUID: WhEIHTN1Q92qpssxb6V9tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="82364977"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="82364977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 16:07:41 -0800
X-CSE-ConnectionGUID: iZWW1HrHRR6B/zMyZh0maw==
X-CSE-MsgGUID: go3eZkH9TcyWfVKd7nonUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="193324446"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Nov 2025 16:07:37 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIyOd-0003gR-1l;
	Wed, 12 Nov 2025 00:07:35 +0000
Date: Wed, 12 Nov 2025 08:07:20 +0800
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
Message-ID: <202511120729.R3XQNSnx-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20251112 (https://download.01.org/0day-ci/archive/20251112/202511120729.R3XQNSnx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120729.R3XQNSnx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/acpi_pcc.o: in function `acpi_pcc_address_space_handler':
>> drivers/acpi/acpi_pcc.c:148:(.text+0x7e): undefined reference to `__udivdi3'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
   Selected by [y]:
   - GPIO_TB10X [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC_PLAT_TB10X || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for GPIO_SYSCON
   Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF [=n]
   Selected by [m]:
   - GPIO_SAMA5D2_PIOBU [=m] && GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF_GPIO [=y] && (ARCH_AT91 || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [m]:
   - MFD_SPACEMIT_P1 [=m] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +148 drivers/acpi/acpi_pcc.c

   124	
   125	static acpi_status
   126	acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
   127				       u32 bits, acpi_integer *value,
   128				       void *handler_context, void *region_context)
   129	{
   130		acpi_status ret;
   131		struct pcc_data *data = region_context;
   132		u64 usecs_lat;
   133		bool use_polling = data->pcc_chan->mchan->mbox->txdone_poll;
   134	
   135		reinit_completion(&data->done);
   136	
   137		/* Write to Shared Memory */
   138		memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
   139	
   140		/*
   141		 * pcc_chan->latency is just a Nominal value. In reality the remote
   142		 * processor could be much slower to reply. So add an arbitrary
   143		 * amount of wait on top of Nominal.
   144		 */
   145		usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
   146	
   147		data->cl.tx_block = use_polling;
 > 148		data->cl.tx_tout = usecs_lat / USEC_PER_MSEC;
   149	
   150		if (use_polling)
   151			ret = acpi_pcc_send_msg_polling(data);
   152		else
   153			ret = acpi_pcc_send_msg_irq(data);
   154	
   155		memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
   156	
   157		return ret;
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

