Return-Path: <linux-acpi+bounces-12931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D5A8373B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6455E8A7623
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9541F09BC;
	Thu, 10 Apr 2025 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDVj5EZQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D631E520E;
	Thu, 10 Apr 2025 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255846; cv=none; b=AMsA1fu4FdSrzVwKQrdFlcF9yE4Rn8QWCTIBB2xw7L4RECpC6qp35hinGQQwo4DHpxRIxMB4pKP0SSPKv/sbAXsfUUJFqekCngPybjgDNjasng+JEyem/F350ouGerO52lsH7BS1sSsy3gTThL39olz9oYYbvOHDGwioaIMTih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255846; c=relaxed/simple;
	bh=2YIPx1SJM4r8eWGjcyhznHKS7pOdoMuJI3TkU33XceI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R8DbQRuQFO/LMBktyxJCUQrcaMBEQ+pSn6xnDUW0BCtSuOB8Z488pr51LOnKFVTO8LemTMZrPbsWEWgTt7CWBEyE/E6qBoU5WliTZ53kMc9tHhBCvmMXwmp6CenF03wwcLHarnweoebSL2Iz1vJZk86LXxgkx4aQ9rh+5AwOeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDVj5EZQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744255842; x=1775791842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2YIPx1SJM4r8eWGjcyhznHKS7pOdoMuJI3TkU33XceI=;
  b=MDVj5EZQ+C4ykuLmZX/mTe9A7dfLp2ibPbZUu5a3FOBFs02NnNH8Fiti
   +DlMYrgIg1Y6m34Ww2+7mcbvUFVt9OWUBQd+QDq+tiYK5hhSx3zkGAG+j
   qBxIuUcws/D3R9exMVusgJw6aQplClFuf2NkGk45dj884qs0Nc5ikzpx7
   6rAkSnT2QOIkndur+MIcLACgaaUw/qryV6pHGxZexkrUSGri6R80pYljY
   oJTaN+jfe0/rRF3EZMWlIrP4dEyRsSP0H3UhYB8MJ7SBiybz7wCdkH8G9
   2Vk9okZ5FFlu8mxETEHwth6mQOOgnE/cubt/Io5qv9RElyBnbS40jM0Pc
   g==;
X-CSE-ConnectionGUID: o5wCr0GrSGCwSzJR89ACxw==
X-CSE-MsgGUID: QAud9meNSoKyD9E3odzYbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56422483"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56422483"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 20:30:42 -0700
X-CSE-ConnectionGUID: aFtXxdgxRYKD9W0AG9Fo6A==
X-CSE-MsgGUID: TK85AeiwTnWbEFdL+WbvNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128750250"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2025 20:30:40 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2icg-0009Yp-00;
	Thu, 10 Apr 2025 03:30:38 +0000
Date: Thu, 10 Apr 2025 11:30:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 42/56] drivers/pinctrl/pinctrl-amd.c:40:25:
 warning: unused variable 'pinctrl_dev'
Message-ID: <202504101106.hPCEcoHr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   655d33f14d6cebcf46e422bcb9d225d791bba42f
commit: 179db1909c5c4b5300cce626507b0f843f7d2cc2 [42/56] pinctrl: amd: Add an LPS0 check() callback
config: hexagon-randconfig-001-20250410 (https://download.01.org/0day-ci/archive/20250410/202504101106.hPCEcoHr-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504101106.hPCEcoHr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504101106.hPCEcoHr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-amd.c:40:25: warning: unused variable 'pinctrl_dev' [-Wunused-variable]
      40 | static struct amd_gpio *pinctrl_dev;
         |                         ^~~~~~~~~~~
   1 warning generated.


vim +/pinctrl_dev +40 drivers/pinctrl/pinctrl-amd.c

    39	
  > 40	static struct amd_gpio *pinctrl_dev;
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

