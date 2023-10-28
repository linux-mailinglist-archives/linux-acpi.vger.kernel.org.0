Return-Path: <linux-acpi+bounces-1087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B767DA78D
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F079A282081
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7D15AE0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgSJU0Ai"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99568156E3
	for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2023 14:04:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769349C;
	Sat, 28 Oct 2023 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698501869; x=1730037869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOaWX51maDQCrLVl5or5Zw+K/QttpP/7VXGhY2cK+wI=;
  b=UgSJU0AiQ/WwEbVUHadAzfxGwyGdKJVfnBJ+iGMQ23wUo/AM7jYTCBvl
   3yCXdksBmTpXfoIihQFwrHxmGYHXzbLbGAzyc9XoEQ1XT9lZANNeR2I8k
   j64BVcHzPV2WzMI7iBshz3DiEjSB3sqRQ7AK9h+2BXtb2PoqGKbGvdkBJ
   wzAdsQSRTxWHm8UOLfPFTICxOio9b+A4vrTuUDZwrL40XdDCDKy+2TB2p
   jBT8cYBesClxWKYY+Tpf1Tha6LdXhiSBELUaPv0aslH3CRhKYGLAEjwog
   SgZPaxhFvfuDC8Mm2R/y2wwAVsX40TKwujhVUZZ7VBsXoOyBvduvqsqmx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454368160"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="454368160"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 07:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="763501664"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="763501664"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Oct 2023 07:04:24 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwjvK-000Bnf-0r;
	Sat, 28 Oct 2023 14:04:22 +0000
Date: Sat, 28 Oct 2023 22:03:42 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] coresight: replicator: Move ACPI support from AMBA
 driver to platform driver
Message-ID: <202310282118.A4PM0Rdg-lkp@intel.com>
References: <20231027072943.3418997-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027072943.3418997-2-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/acpi-bus soc/for-next atorgue-stm32/stm32-next linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-replicator-Move-ACPI-support-from-AMBA-driver-to-platform-driver/20231027-153540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231027072943.3418997-2-anshuman.khandual%40arm.com
patch subject: [PATCH 1/7] coresight: replicator: Move ACPI support from AMBA driver to platform driver
config: arm-randconfig-002-20231028 (https://download.01.org/0day-ci/archive/20231028/202310282118.A4PM0Rdg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310282118.A4PM0Rdg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310282118.A4PM0Rdg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-replicator.c:45: warning: Function parameter or member 'pclk' not described in 'replicator_drvdata'


vim +45 drivers/hwtracing/coresight/coresight-replicator.c

0f5f9b6ba9e1a7 drivers/hwtracing/coresight/coresight-replicator.c Suzuki K Poulose   2019-06-19  28  
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  29  /**
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  30   * struct replicator_drvdata - specifics associated to a replicator component
455328b1772a19 drivers/hwtracing/coresight/coresight-replicator.c Suzuki K Poulose   2019-04-25  31   * @base:	memory mapped base address for this component. Also indicates
455328b1772a19 drivers/hwtracing/coresight/coresight-replicator.c Suzuki K Poulose   2019-04-25  32   *		whether this one is programmable or not.
9875cd9ce2b536 drivers/hwtracing/coresight/coresight-replicator.c Linus Walleij      2015-05-19  33   * @atclk:	optional clock for the core parts of the replicator.
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  34   * @csdev:	component vitals needed by the framework
edda32dabedb01 drivers/hwtracing/coresight/coresight-replicator.c Yabin Cui          2019-11-04  35   * @spinlock:	serialize enable/disable operations.
8f3ce74c20f21e drivers/hwtracing/coresight/coresight-replicator.c Sai Prakash Ranjan 2020-07-16  36   * @check_idfilter_val: check if the context is lost upon clock removal.
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  37   */
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  38  struct replicator_drvdata {
455328b1772a19 drivers/hwtracing/coresight/coresight-replicator.c Suzuki K Poulose   2019-04-25  39  	void __iomem		*base;
9875cd9ce2b536 drivers/hwtracing/coresight/coresight-replicator.c Linus Walleij      2015-05-19  40  	struct clk		*atclk;
bed4866511371a drivers/hwtracing/coresight/coresight-replicator.c Anshuman Khandual  2023-10-27  41  	struct clk		*pclk;
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  42  	struct coresight_device	*csdev;
edda32dabedb01 drivers/hwtracing/coresight/coresight-replicator.c Yabin Cui          2019-11-04  43  	spinlock_t		spinlock;
8f3ce74c20f21e drivers/hwtracing/coresight/coresight-replicator.c Sai Prakash Ranjan 2020-07-16  44  	bool			check_idfilter_val;
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03 @45  };
ceacc1d9b7ae41 drivers/coresight/coresight-replicator.c           Pratik Patel       2014-11-03  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

