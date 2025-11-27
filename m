Return-Path: <linux-acpi+bounces-19325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D665C8F37D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195E03B6D14
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D23115A6;
	Thu, 27 Nov 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmxWzcQl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62026257830;
	Thu, 27 Nov 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256270; cv=none; b=nFXdPzP4dj4OPjflTUv3BXEUZW7TAdqlsEn0DMH+WTuePF/0ha7hjGTQE8aSP8zLvMpNfwGvZHJHgp0Kpzg9v6iquHbFfooQ4JAlWy9NXKofLIvf5GemRs1xxiw/vez64MCkAa41x6oUfdPPvVpsuQErzrhAcqYuUsVDgJ1od78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256270; c=relaxed/simple;
	bh=VbGblNVtoDSl589XQ7oYPodErP1t6oS9NvvWeUPMmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq4n+jRRk7rFXzbZ4aS48y0K+jHL2dHKjVSCPjH51hDzcsiX+QOQqTkV38EXElh/D70Us9s3XZu0tvJ5ykybG+Gi8H77ux6OQriuyJVQ7/4U/HMHltwOlxNgnVLs93COsNulDdpr0F2xelAMzAZutyP5+/D3DNNCfSDpLKxvef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmxWzcQl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764256267; x=1795792267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VbGblNVtoDSl589XQ7oYPodErP1t6oS9NvvWeUPMmGU=;
  b=CmxWzcQl6ySzVuEbXBH0HD/L5b7YtvNRK0iXe2S6SHfgeKG0MVVgtQVr
   ZoetXl3jm+uMqQNVkfyOCwGZcVO58sVJzwxT1hTibj8Z2uzoOalJSaP0o
   2oMLVtc9XYlmGp1epCLGt0//iqz7nWgYuO3Pz98glvhcNK0hBmRgG+lbk
   lY358zDtmce2AHjCcZ+QXZqw5Xxxx7g2MjI7eUYjud/QR3yBr6fj1mU+u
   x31FmKnnrrjsS0QJH7N3WxdNHhbAhXheY2SKi6b23XLsjeQqJzv8ybW7f
   8IiBqag2Rm0VnnmoEioNyUNISnC5TvbPW6Inf4HwO9fPi4loj9jTcylJ+
   A==;
X-CSE-ConnectionGUID: N1w8YxQnRB+c1vriB+cDLA==
X-CSE-MsgGUID: USyFNjLlRJu9NtwR5mDdKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77409050"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="77409050"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 07:11:07 -0800
X-CSE-ConnectionGUID: hONJ7WbgQjmgi56mrkxaaQ==
X-CSE-MsgGUID: pV5bBdvaQwOK23dYa6rF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="197569264"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 27 Nov 2025 07:11:04 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOde9-000000005C1-238z;
	Thu, 27 Nov 2025 15:11:01 +0000
Date: Thu, 27 Nov 2025 23:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Huisong Li <lihuisong@huawei.com>, rafael@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	yubowen8@huawei.com, lihuisong@huawei.com
Subject: Re: [PATCH 2/3] ACPI: processor: idle: Disable ACPI idle if get
 power information failed in power notify
Message-ID: <202511272227.w1fgoiKQ-lkp@intel.com>
References: <20251125072933.3706006-3-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125072933.3706006-3-lihuisong@huawei.com>

Hi Huisong,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.18-rc7 next-20251127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huisong-Li/cpuidle-Add-enable_cpuidle-interface/20251125-153615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251125072933.3706006-3-lihuisong%40huawei.com
patch subject: [PATCH 2/3] ACPI: processor: idle: Disable ACPI idle if get power information failed in power notify
config: riscv-randconfig-001-20251127 (https://download.01.org/0day-ci/archive/20251127/202511272227.w1fgoiKQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511272227.w1fgoiKQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511272227.w1fgoiKQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "enable_cpuidle" [drivers/acpi/processor.ko] undefined!
>> ERROR: modpost: "disable_cpuidle" [drivers/acpi/processor.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

