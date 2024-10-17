Return-Path: <linux-acpi+bounces-8832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279329A1B70
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 09:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF251F212B1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EF1C1AD4;
	Thu, 17 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJsqnWmf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF42155A24;
	Thu, 17 Oct 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149139; cv=none; b=top0KS0cH+FkxAhVO52QZO30TccMjI3awZ6vpGh92cRjZ2mLAVvm51ruHnxv1oIIUCT4ULJY5l1w3nsmfvv4K1Y777mosfVrSXsGKZSnPAJjoWN/uSp3mzB4YcPYJFmBBArcoKuxzAPTBhhAUWOUi9AW6UCxkBA6S/WhpGSK+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149139; c=relaxed/simple;
	bh=42g5tVEQu2XF9M+6+sCwBJngAcYz5fH+z4CcJnsK0Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q99tkwg13PpHv7ITtDbYzb5cB8WiK0fRVCojq+9O0q69acG8tKuTxRFGqZKk1jF9dxFhApvpMw1AgtRfFvUaXMCjeuOJknsDMEOg7e5g/NWl29IK19g/wCNN8KSGAar81IKvIkymOSKK2eSuUqNjkfWgHG/036qtjkelt+ppDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJsqnWmf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729149136; x=1760685136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=42g5tVEQu2XF9M+6+sCwBJngAcYz5fH+z4CcJnsK0Ls=;
  b=OJsqnWmfZL5sC8BM0a6jaOEQ7ccryjkYJvz16fhZn3IbeNoT+INujzWf
   27bC02k2NLzYURE97D54xfazMvM3kTxuMLaB16xuDzmKfBqRu+N9dUgzd
   qgk1TEO1dPFgjtgWYeymQd/Lb0Wy+qc7iH701gYxgLaGJmR6L6aKekumB
   8T8xPo+hIjPS0WC6zkMmBs+miqlh3fN1fuYnZ6/aIZ8anO6C84HyLO5r7
   Z+DU8eVi+dp2etMsyC2DIfjwaLIDMlZh+i0yPWErry8GZKoCIPcd7eVxb
   HENXVPkrZckc91rCUyvlScSd+jd7R1wTP30vqYRp7cmpOzdkXNkALf8Aa
   A==;
X-CSE-ConnectionGUID: l4T9FsLqSequ+O0F++itzA==
X-CSE-MsgGUID: m5QE0+VlRr2z3opKTMCxMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="16241321"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="16241321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:12:15 -0700
X-CSE-ConnectionGUID: heUNPcFNQwqnvINBVZmcaw==
X-CSE-MsgGUID: IKkiIo2+QqiDuo/gMAvMLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83238536"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Oct 2024 00:12:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Kfx-000Lrf-0P;
	Thu, 17 Oct 2024 07:12:01 +0000
Date: Thu, 17 Oct 2024 15:11:14 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Heusel <christian@heusel.eu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dirk Holten <dirk.holten@gmx.de>,
	stable@vger.kernel.org, Christian Heusel <christian@heusel.eu>
Subject: Re: [PATCH] ACPI: resource: Add LG 16T90SP to
 irq1_level_low_skip_override[]
Message-ID: <202410171432.vrXoRLhw-lkp@intel.com>
References: <20241016-lg-gram-pro-keyboard-v1-1-34306123102f@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-lg-gram-pro-keyboard-v1-1-34306123102f@heusel.eu>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8e929cb546ee42c9a61d24fae60605e9e3192354]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Heusel/ACPI-resource-Add-LG-16T90SP-to-irq1_level_low_skip_override/20241016-224929
base:   8e929cb546ee42c9a61d24fae60605e9e3192354
patch link:    https://lore.kernel.org/r/20241016-lg-gram-pro-keyboard-v1-1-34306123102f%40heusel.eu
patch subject: [PATCH] ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]
config: x86_64-randconfig-122-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171432.vrXoRLhw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171432.vrXoRLhw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171432.vrXoRLhw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/resource.c:501:18: sparse: sparse: Initializer entry defined twice
   drivers/acpi/resource.c:506:18: sparse:   also defined here
   drivers/acpi/resource.c: note: in included file (through include/linux/resource_ext.h, include/linux/acpi.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +501 drivers/acpi/resource.c

55a93417c27c6ad Christophe Ricard 2015-12-23  387  
d37273af0e428e9 Hans de Goede     2023-09-13  388  /*
d37273af0e428e9 Hans de Goede     2023-09-13  389   * DMI matches for boards where the DSDT specifies the kbd IRQ as
d37273af0e428e9 Hans de Goede     2023-09-13  390   * level active-low and using the override changes this to rising edge,
d37273af0e428e9 Hans de Goede     2023-09-13  391   * stopping the keyboard from working.
d37273af0e428e9 Hans de Goede     2023-09-13  392   */
d37273af0e428e9 Hans de Goede     2023-09-13  393  static const struct dmi_system_id irq1_level_low_skip_override[] = {
892a012699fc0b9 Hui Wang          2021-09-15  394  	{
424009ab2030862 Hans de Goede     2023-09-13  395  		/* MEDION P15651 */
892a012699fc0b9 Hui Wang          2021-09-15  396  		.matches = {
892a012699fc0b9 Hui Wang          2021-09-15  397  			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
892a012699fc0b9 Hui Wang          2021-09-15  398  			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
892a012699fc0b9 Hui Wang          2021-09-15  399  		},
892a012699fc0b9 Hui Wang          2021-09-15  400  	},
1b26ae40092b43b Hui Wang          2021-10-25  401  	{
424009ab2030862 Hans de Goede     2023-09-13  402  		/* MEDION S17405 */
1b26ae40092b43b Hui Wang          2021-10-25  403  		.matches = {
1b26ae40092b43b Hui Wang          2021-10-25  404  			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
1b26ae40092b43b Hui Wang          2021-10-25  405  			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
1b26ae40092b43b Hui Wang          2021-10-25  406  		},
1b26ae40092b43b Hui Wang          2021-10-25  407  	},
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  408  	{
424009ab2030862 Hans de Goede     2023-09-13  409  		/* MEDION S17413 */
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  410  		.matches = {
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  411  			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  412  			DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  413  		},
2d0ab14634a26e5 Aymeric Wibo      2023-03-19  414  	},
e12dee3736731e2 Tamim Khan        2022-08-28  415  	{
424009ab2030862 Hans de Goede     2023-09-13  416  		/* Asus Vivobook K3402ZA */
e12dee3736731e2 Tamim Khan        2022-08-28  417  		.matches = {
e12dee3736731e2 Tamim Khan        2022-08-28  418  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
e12dee3736731e2 Tamim Khan        2022-08-28  419  			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
e12dee3736731e2 Tamim Khan        2022-08-28  420  		},
e12dee3736731e2 Tamim Khan        2022-08-28  421  	},
e12dee3736731e2 Tamim Khan        2022-08-28  422  	{
424009ab2030862 Hans de Goede     2023-09-13  423  		/* Asus Vivobook K3502ZA */
e12dee3736731e2 Tamim Khan        2022-08-28  424  		.matches = {
e12dee3736731e2 Tamim Khan        2022-08-28  425  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
e12dee3736731e2 Tamim Khan        2022-08-28  426  			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
e12dee3736731e2 Tamim Khan        2022-08-28  427  		},
e12dee3736731e2 Tamim Khan        2022-08-28  428  	},
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  429  	{
424009ab2030862 Hans de Goede     2023-09-13  430  		/* Asus Vivobook S5402ZA */
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  431  		.matches = {
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  432  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  433  			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  434  		},
6e5cbe7c4b41824 Kellen Renshaw    2022-09-21  435  	},
b5f9223a105d9b5 Tamim Khan        2022-10-14  436  	{
424009ab2030862 Hans de Goede     2023-09-13  437  		/* Asus Vivobook S5602ZA */
b5f9223a105d9b5 Tamim Khan        2022-10-14  438  		.matches = {
b5f9223a105d9b5 Tamim Khan        2022-10-14  439  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
b5f9223a105d9b5 Tamim Khan        2022-10-14  440  			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
b5f9223a105d9b5 Tamim Khan        2022-10-14  441  		},
b5f9223a105d9b5 Tamim Khan        2022-10-14  442  	},
2f80ce0b78c340e Hans de Goede     2024-09-27  443  	{
2f80ce0b78c340e Hans de Goede     2024-09-27  444  		/* Asus Vivobook X1704VAP */
2f80ce0b78c340e Hans de Goede     2024-09-27  445  		.matches = {
2f80ce0b78c340e Hans de Goede     2024-09-27  446  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
2f80ce0b78c340e Hans de Goede     2024-09-27  447  			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
2f80ce0b78c340e Hans de Goede     2024-09-27  448  		},
2f80ce0b78c340e Hans de Goede     2024-09-27  449  	},
c1ed72171ed580f Hans de Goede     2023-09-12  450  	{
158d0f3700fd719 Hans de Goede     2024-10-05  451  		/* Asus ExpertBook B1402C* */
c1ed72171ed580f Hans de Goede     2023-09-12  452  		.matches = {
c1ed72171ed580f Hans de Goede     2023-09-12  453  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
158d0f3700fd719 Hans de Goede     2024-10-05  454  			DMI_MATCH(DMI_BOARD_NAME, "B1402C"),
c1ed72171ed580f Hans de Goede     2023-09-12  455  		},
c1ed72171ed580f Hans de Goede     2023-09-12  456  	},
bd911485294a6f0 Hans de Goede     2023-11-15  457  	{
158d0f3700fd719 Hans de Goede     2024-10-05  458  		/* Asus ExpertBook B1502C* */
bd911485294a6f0 Hans de Goede     2023-11-15  459  		.matches = {
bd911485294a6f0 Hans de Goede     2023-11-15  460  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
158d0f3700fd719 Hans de Goede     2024-10-05  461  			DMI_MATCH(DMI_BOARD_NAME, "B1502C"),
ca3afc2806046f6 Nicolas Haye      2024-01-30  462  		},
ca3afc2806046f6 Nicolas Haye      2024-01-30  463  	},
77c724888238539 Tamim Khan        2022-12-30  464  	{
564a278573783cd Hans de Goede     2024-10-05  465  		/* Asus ExpertBook B2402 (B2402CBA / B2402FBA / B2402CVA / B2402FVA) */
77c724888238539 Tamim Khan        2022-12-30  466  		.matches = {
77c724888238539 Tamim Khan        2022-12-30  467  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
564a278573783cd Hans de Goede     2024-10-05  468  			DMI_MATCH(DMI_BOARD_NAME, "B2402"),
65eb2867f5bf460 Vojtech Hejsek    2023-02-16  469  		},
65eb2867f5bf460 Vojtech Hejsek    2023-02-16  470  	},
7203481fd12b125 Hans de Goede     2022-12-15  471  	{
435f2d87579e240 Hans de Goede     2024-10-05  472  		/* Asus ExpertBook B2502 (B2502CBA / B2502FBA / B2502CVA / B2502FVA) */
7203481fd12b125 Hans de Goede     2022-12-15  473  		.matches = {
7203481fd12b125 Hans de Goede     2022-12-15  474  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
435f2d87579e240 Hans de Goede     2024-10-05  475  			DMI_MATCH(DMI_BOARD_NAME, "B2502"),
056301e7c7c886f Hans de Goede     2024-09-27  476  		},
056301e7c7c886f Hans de Goede     2024-09-27  477  	},
49e9cc315604972 Tamim Khan        2024-09-02  478  	{
63539defee17bf0 Hans de Goede     2024-09-27  479  		/* Asus Vivobook Go E1404GA* */
49e9cc315604972 Tamim Khan        2024-09-02  480  		.matches = {
49e9cc315604972 Tamim Khan        2024-09-02  481  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
63539defee17bf0 Hans de Goede     2024-09-27  482  			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
49e9cc315604972 Tamim Khan        2024-09-02  483  		},
49e9cc315604972 Tamim Khan        2024-09-02  484  	},
d2aaf19965045f7 Ben Mayo          2024-01-06  485  	{
65bdebf38e5fac7 Hans de Goede     2024-09-27  486  		/* Asus Vivobook E1504GA* */
d2aaf19965045f7 Ben Mayo          2024-01-06  487  		.matches = {
d2aaf19965045f7 Ben Mayo          2024-01-06  488  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
d2aaf19965045f7 Ben Mayo          2024-01-06  489  			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
d2aaf19965045f7 Ben Mayo          2024-01-06  490  		},
d2aaf19965045f7 Ben Mayo          2024-01-06  491  	},
7c52c7071bd403a Tamim Khan        2024-04-28  492  	{
1af7e441feb08cd Hans de Goede     2024-10-05  493  		/* Asus Vivobook Pro N6506M* */
7c52c7071bd403a Tamim Khan        2024-04-28  494  		.matches = {
7c52c7071bd403a Tamim Khan        2024-04-28  495  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
1af7e441feb08cd Hans de Goede     2024-10-05  496  			DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
e2e7f037b400aeb Tamim Khan        2024-07-07  497  		},
e2e7f037b400aeb Tamim Khan        2024-07-07  498  	},
d37273af0e428e9 Hans de Goede     2023-09-13  499  	{
424009ab2030862 Hans de Goede     2023-09-13  500  		/* LG Electronics 17U70P */
d37273af0e428e9 Hans de Goede     2023-09-13 @501  		.matches = {
d37273af0e428e9 Hans de Goede     2023-09-13  502  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
d37273af0e428e9 Hans de Goede     2023-09-13  503  			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
d37273af0e428e9 Hans de Goede     2023-09-13  504  		},
6576e827971bb3b Christian Heusel  2024-10-16  505  		/* LG Electronics 16T90SP */
6576e827971bb3b Christian Heusel  2024-10-16  506  		.matches = {
6576e827971bb3b Christian Heusel  2024-10-16  507  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
6576e827971bb3b Christian Heusel  2024-10-16  508  			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
6576e827971bb3b Christian Heusel  2024-10-16  509  		},
d37273af0e428e9 Hans de Goede     2023-09-13  510  	},
e12dee3736731e2 Tamim Khan        2022-08-28  511  	{ }
e12dee3736731e2 Tamim Khan        2022-08-28  512  };
e12dee3736731e2 Tamim Khan        2022-08-28  513  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

