Return-Path: <linux-acpi+bounces-576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CD7C444B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 00:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAEA1C20C77
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB51A290
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnFgvzTT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FC354E1;
	Tue, 10 Oct 2023 22:28:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072913E;
	Tue, 10 Oct 2023 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696976883; x=1728512883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVo+v3mfC9EK3rBZgp1oi3KIb69A6tBkouEsPLy3ri4=;
  b=XnFgvzTT0dR5rtymvH84W/YxLVqQYEka/ZyEgL7zEb939YWml2a0z2Xf
   gWwwFKWEvS7KsNKXsulnRNgDHkybsnRxwnSnT7dK0oEd6vMLhcfaxdQIg
   L43a+qeqSnc3wRNYkX+Fx0fPFbLt0JS8Vmx9Cupzv1OCa9q41tllOoujZ
   DIS0DUuh2YUUurmFc03mN8xoODe+yMbxpfZqUSDVTSRPSXU0yVdY5JIr6
   KV69F315i0j1oFsDMGRfCXgppuj2J+r/aRr+6FwZh+Wc8HvcU4OTYrSjy
   ZThaFv5gnEpa0p9NEcSky2uMJAq3BxHVYGHkIn1qAfcLkYY5ZZyzKvLe+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388388016"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388388016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 15:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788752402"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788752402"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 15:27:30 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqLCK-0001IS-1m;
	Tue, 10 Oct 2023 22:27:28 +0000
Date: Wed, 11 Oct 2023 06:26:38 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, rafael@kernel.org,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
Message-ID: <202310110624.1GjFMfus-lkp@intel.com>
References: <20231010200254.764273-5-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010200254.764273-5-Benjamin.Cheatham@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c66650d29764e228eba40b7a59fdb70fa6567daa]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Cheatham/cxl-port-Add-EINJ-debugfs-files-and-callback-support/20231011-040503
base:   c66650d29764e228eba40b7a59fdb70fa6567daa
patch link:    https://lore.kernel.org/r/20231010200254.764273-5-Benjamin.Cheatham%40amd.com
patch subject: [PATCH v6 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310110624.1GjFMfus-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110624.1GjFMfus-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:SPACING: space required after that ',' (ctx:VxV)
#98: FILE: drivers/acpi/apei/einj.c:699:
+	devfn = (PCI_DEVFN(PCI_SLOT(pdev->devfn),PCI_FUNC(pdev->devfn)) << 8);
 	                                        ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

