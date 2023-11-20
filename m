Return-Path: <linux-acpi+bounces-1639-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED787F2074
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 23:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6761C20F3B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7073A269
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J12vOeiJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9B99;
	Mon, 20 Nov 2023 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700515693; x=1732051693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QOZ009XPlc8q/cW8PvOmx+Fl7NzUUd/iH64JSXsiqKo=;
  b=J12vOeiJoAxK9mMlm/qT0vui9lC1amwW0gsHePt24Lwo5+VSqYnv2RyM
   uVhvlaM+RGehG/25bYsMZIhxyB8353vvCmaY28bEbWp2MeQwqjhNsOGDt
   l1eaYTpN0Ep+lTETcXitRlfUHkPYecvUpGDOMFU8IwQZcJk03ypU5Yu+Z
   aXV9LP9KIvg2Qb3pihkXGs3BQsXyWT73yH/abeJg5y6yN6I2/pVklvDLI
   uzHi1pdZoXieNhHmlGUgn6rSz+CKJ7tG8tGEV0dU3r+WKtUll5a/NG7XH
   JxvfMZq8uEQm89Uv5YKKMqu8WEfUOSUdhoX18qiB9dYaPODIqOtgOKHDg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4823352"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4823352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7688812"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2023 13:28:11 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5BoO-0006wS-09;
	Mon, 20 Nov 2023 21:28:08 +0000
Date: Tue, 21 Nov 2023 05:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 12/27] drivers/acpi/thermal_lib.c:46:5:
 warning: no previous prototype for function 'acpi_active_trip_temp'
Message-ID: <202311210522.8Y0cnwJ2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f437a8d1debff5412e36a1c9454adee193b31950
commit: 932d2c2fd0b1e8242ba7bcb7b8c2553e663e174f [12/27] ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231121/202311210522.8Y0cnwJ2-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210522.8Y0cnwJ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210522.8Y0cnwJ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/thermal_lib.c:46:5: warning: no previous prototype for function 'acpi_active_trip_temp' [-Wmissing-prototypes]
   int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:56:5: warning: no previous prototype for function 'acpi_passive_trip_temp' [-Wmissing-prototypes]
   int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:61:5: warning: no previous prototype for function 'acpi_hot_trip_temp' [-Wmissing-prototypes]
   int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:61:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
>> drivers/acpi/thermal_lib.c:66:5: warning: no previous prototype for function 'acpi_critical_trip_temp' [-Wmissing-prototypes]
   int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
       ^
   drivers/acpi/thermal_lib.c:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
   ^
   static 
   4 warnings generated.


vim +/acpi_active_trip_temp +46 drivers/acpi/thermal_lib.c

    45	
  > 46	int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
    47	{
    48		char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
    49	
    50		if (id < 0 || id > 9)
    51			return -EINVAL;
    52	
    53		return acpi_trip_temp(adev, obj_name, ret_temp);
    54	}
    55	
  > 56	int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
    57	{
    58		return acpi_trip_temp(adev, "_PSV", ret_temp);
    59	}
    60	
  > 61	int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
    62	{
    63		return acpi_trip_temp(adev, "_HOT", ret_temp);
    64	}
    65	
  > 66	int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
    67	{
    68		return acpi_trip_temp(adev, "_CRT", ret_temp);
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

