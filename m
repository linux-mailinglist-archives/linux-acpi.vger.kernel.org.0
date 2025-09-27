Return-Path: <linux-acpi+bounces-17371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A319BBA60CD
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8913AF3A0
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE02E6CB2;
	Sat, 27 Sep 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDJXHZb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D42E5B36;
	Sat, 27 Sep 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984933; cv=none; b=i3a83ROBRWDy4MaqVSRMgL4EpCyURyq2CTnMOuyB8S1REkHH4CzbJuHyBh9TkWEgWnRoAgytGwM/vE9IlC6FD9GqRPAp6QBMvH2kmlZiAUMNU7YzfLkhSU+/0lW7JyscQzZ4Sh/Zpp3DwcwF2AAcnZkk60jN3rq03twOL6H/OgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984933; c=relaxed/simple;
	bh=4Xtgvx9h1ZLVPmSFEG38+ykN6s3tgX/8bYENjS2MG38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a11zwNGJUqfI7qxCewCOXlrJ4QTKf9jlqHey3mqn6aO1TbnJJIJEGQfknSeLI4EgjoNGS+feWjp1gho0m1gUUj37jkpgutSY4y6SXobhBy043FLYAqeOUle5YGP2fCMp3clbtRDwAD24imoPpEiQ3JB/q1UcX+SUgGAzXjM68zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDJXHZb/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758984930; x=1790520930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Xtgvx9h1ZLVPmSFEG38+ykN6s3tgX/8bYENjS2MG38=;
  b=nDJXHZb/eP8vOp6gpRGV1xW4pnn/SuUAqfnh2NO7SwTyxC7paTJ4Awf5
   lkd1gB83/+QSw9mH0WScgNAOEt/1BWRAnzgMNKF2WtvnTS4UaJLE+7ZQT
   mBm4Sdma5Q3pLiRRy0nA1yBUuGFkY1llhcIfDIxrVncAnohnJojyPwsDE
   Zq9lY/+ytDe/YEkyJEjx20Eb+54MnFieHJbU6B6OuHcc2w2AbygvbtcN+
   WZvn6B6IEE6YRAy5FsU1ScxSe4tplCbsf/GlvfpOsVcx9toueVIO+JJwi
   D41B5XSnFBjoB/m7Ebiiwj/dAFl7aIVO+9tYhXb6jnwFVKNzbQK4RXL7s
   A==;
X-CSE-ConnectionGUID: E8gpywXUQ72tGfvgPBGqXw==
X-CSE-MsgGUID: z01A0XZlQJmIjyuRD6d1cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65139897"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="65139897"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 07:55:29 -0700
X-CSE-ConnectionGUID: P4rJjU2lThiJKlrOQ4BMRQ==
X-CSE-MsgGUID: 9YTI+B2rRzupoiZZfpcfXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="214986001"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 27 Sep 2025 07:55:26 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2WKX-00077p-0c;
	Sat, 27 Sep 2025 14:55:21 +0000
Date: Sat, 27 Sep 2025 22:54:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>
Subject: [rafael-pm:bleeding-edge 204/212]
 drivers/cpufreq/spear-cpufreq.c:185:52: error:
 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared; did you mean
 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
Message-ID: <202509280108.zOEjD8fx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   95b83771c9f38207ff42311ccc4739db76d19f33
commit: 8cf63e01b6b73132d69c04d35f11738705467281 [204/212] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
config: riscv-randconfig-002-20250927 (https://download.01.org/0day-ci/archive/20250928/202509280108.zOEjD8fx-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250928/202509280108.zOEjD8fx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509280108.zOEjD8fx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/spear-cpufreq.c: In function 'spear_cpufreq_probe':
>> drivers/cpufreq/spear-cpufreq.c:185:52: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
     185 |                 spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                    CPUFREQ_DEFAULT_TANSITION_LATENCY_NS
   drivers/cpufreq/spear-cpufreq.c:185:52: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/cpufreq/scmi-cpufreq.c: In function 'scmi_cpufreq_init':
>> drivers/cpufreq/scmi-cpufreq.c:297:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
     297 |                 latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           CPUFREQ_DEFAULT_TANSITION_LATENCY_NS
   drivers/cpufreq/scmi-cpufreq.c:297:27: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/cpufreq/mediatek-cpufreq-hw.c: In function 'mtk_cpufreq_hw_cpu_init':
>> drivers/cpufreq/mediatek-cpufreq-hw.c:312:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
     312 |                 latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           CPUFREQ_DEFAULT_TANSITION_LATENCY_NS
   drivers/cpufreq/mediatek-cpufreq-hw.c:312:27: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/cpufreq/cpufreq-dt.c: In function 'cpufreq_init':
>> drivers/cpufreq/cpufreq-dt.c:107:38: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
     107 |                 transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      CPUFREQ_DEFAULT_TANSITION_LATENCY_NS
   drivers/cpufreq/cpufreq-dt.c:107:38: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/cpufreq/scpi-cpufreq.c: In function 'scpi_cpufreq_init':
>> drivers/cpufreq/scpi-cpufreq.c:160:27: error: 'CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS' undeclared (first use in this function); did you mean 'CPUFREQ_DEFAULT_TANSITION_LATENCY_NS'?
     160 |                 latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           CPUFREQ_DEFAULT_TANSITION_LATENCY_NS
   drivers/cpufreq/scpi-cpufreq.c:160:27: note: each undeclared identifier is reported only once for each function it appears in


vim +185 drivers/cpufreq/spear-cpufreq.c

   169	
   170	static int spear_cpufreq_probe(struct platform_device *pdev)
   171	{
   172		struct device_node *np;
   173		struct cpufreq_frequency_table *freq_tbl;
   174		u32 val;
   175		int cnt, ret, i = 0;
   176	
   177		np = of_cpu_device_node_get(0);
   178		if (!np) {
   179			pr_err("No cpu node found\n");
   180			return -ENODEV;
   181		}
   182	
   183		if (of_property_read_u32(np, "clock-latency",
   184					&spear_cpufreq.transition_latency))
 > 185			spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
   186	
   187		cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
   188		if (cnt <= 0) {
   189			pr_err("Invalid cpufreq_tbl\n");
   190			ret = -ENODEV;
   191			goto out_put_node;
   192		}
   193	
   194		freq_tbl = kcalloc(cnt + 1, sizeof(*freq_tbl), GFP_KERNEL);
   195		if (!freq_tbl) {
   196			ret = -ENOMEM;
   197			goto out_put_node;
   198		}
   199	
   200		of_property_for_each_u32(np, "cpufreq_tbl", val)
   201			freq_tbl[i++].frequency = val;
   202	
   203		freq_tbl[cnt].frequency = CPUFREQ_TABLE_END;
   204	
   205		spear_cpufreq.freq_tbl = freq_tbl;
   206	
   207		of_node_put(np);
   208	
   209		spear_cpufreq.clk = clk_get(NULL, "cpu_clk");
   210		if (IS_ERR(spear_cpufreq.clk)) {
   211			pr_err("Unable to get CPU clock\n");
   212			ret = PTR_ERR(spear_cpufreq.clk);
   213			goto out_put_mem;
   214		}
   215	
   216		ret = cpufreq_register_driver(&spear_cpufreq_driver);
   217		if (!ret)
   218			return 0;
   219	
   220		pr_err("failed register driver: %d\n", ret);
   221		clk_put(spear_cpufreq.clk);
   222	
   223	out_put_mem:
   224		kfree(freq_tbl);
   225		return ret;
   226	
   227	out_put_node:
   228		of_node_put(np);
   229		return ret;
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

