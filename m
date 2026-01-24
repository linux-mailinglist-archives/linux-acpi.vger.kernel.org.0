Return-Path: <linux-acpi+bounces-20599-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPJAMVOOdGmS7AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20599-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 10:18:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4126F7D0EA
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91C613012C8C
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B11ADC83;
	Sat, 24 Jan 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyV+KhCq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEB3EBF34;
	Sat, 24 Jan 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246288; cv=none; b=cdpcBkc2t3BURqJsWCjLMeZUOzt+IyMvqR6Nf9/YU0vnOcFIHvMD4SqjjtMJzhOSg59YH+kiuyYF9arMZ7KjTv6ZEvFCsN7mSIQb8pJVnOvcI7CySNhqSMZAFEa0QXz8xSCUG300n0hBO7eA9bXako50pIEYPwMg0MSiLZfzAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246288; c=relaxed/simple;
	bh=Oik2bgXeF+0A9Nkt9f8qvBU6aAWFORrEGwS+kqJusmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmQQ4KO+qxGwiotyPukZwLkHdaoKfO8n2lhR1TQI/NmqZtilg8pYTtHTOup0OF/LO7aofooB4me001pVmCnkjFlor1NozgQ386vIVFhx2+TfYjWhLe8wFdCskYO3bnzbJ0+aNX9C/neGBVkuJnZ4VQPHxqmaqqVltX7k+fiBndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyV+KhCq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769246286; x=1800782286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oik2bgXeF+0A9Nkt9f8qvBU6aAWFORrEGwS+kqJusmo=;
  b=WyV+KhCqOutFj4L28PPPw3Gqh1iTW2OoZb83+5Jh+Ixx4v9jwCjfkfE8
   LHoBbr1onzd5Fi2KsEFgAftkgzfBdMqZRhvEK5tJDINA/5T8eeDvgT2OT
   iEhtkmVmvidWYQw7vR0k0PjBvlj3sX4shRz0ed3GcDArn/v9JsBqM+g4J
   xhmw6QZ5GgdMPvJNFOaOT5jGaxEb4lou0Z+TgySa1qX/PPFPOB8FmWR2A
   OVe2W9m7IQH1yPEeC7d9Li0+1FLQX4DjXnF2jkc6wwYcW5YVS1Urfy9jI
   ihx6pXxaA17a1uO/qvvVZZgHV5eGXqxgFdO4xqsG8lEnd6/9eUwh0S3b+
   w==;
X-CSE-ConnectionGUID: RBVrxTxnReirZVecgcRw/Q==
X-CSE-MsgGUID: j3yKSUO6Re+cvnSg3r+6ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81924533"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="81924533"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 01:18:06 -0800
X-CSE-ConnectionGUID: 6ETZ6+tuS4ijJFlisht7CA==
X-CSE-MsgGUID: wLtX6H13Tv2RaPerotSSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="211346252"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Jan 2026 01:18:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjZmK-00000000V3G-2HNd;
	Sat, 24 Jan 2026 09:18:00 +0000
Date: Sat, 24 Jan 2026 17:17:33 +0800
From: kernel test robot <lkp@intel.com>
To: Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: OSL: Panic when encountering a fatal ACPI error
Message-ID: <202601241717.giql6AU7-lkp@intel.com>
References: <20260124021859.8337-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124021859.8337-1-W_Armin@gmx.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20599-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4126F7D0EA
X-Rspamd-Action: no action

Hi Armin,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.19-rc6 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Armin-Wolf/ACPI-OSL-Panic-when-encountering-a-fatal-ACPI-error/20260124-102043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260124021859.8337-1-W_Armin%40gmx.de
patch subject: [PATCH] ACPI: OSL: Panic when encountering a fatal ACPI error
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260124/202601241717.giql6AU7-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601241717.giql6AU7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601241717.giql6AU7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/osl.c:74:30: error: use of undeclared identifier 'CONFIG_ACPI_PANIC_ON_FATAL'
      74 | static bool panic_on_fatal = CONFIG_ACPI_PANIC_ON_FATAL;
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/CONFIG_ACPI_PANIC_ON_FATAL +74 drivers/acpi/osl.c

    73	
  > 74	static bool panic_on_fatal = CONFIG_ACPI_PANIC_ON_FATAL;
    75	module_param(panic_on_fatal, bool, 0);
    76	MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encountering a fatal ACPI error");
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

