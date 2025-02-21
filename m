Return-Path: <linux-acpi+bounces-11365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EEA3EBE2
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 05:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9A19C5B15
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3F1E1A32;
	Fri, 21 Feb 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKQKOVZ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854921D7E4C;
	Fri, 21 Feb 2025 04:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112574; cv=none; b=Lv8IzRY5CwnZmPFkKMO2bM2fUtNGW4rz92C3i9dXv9He44tNTvttLeY7CCGrlS7Ug+yCVPbWMzzN17H8j2M+39EDKIK6BSmjG7apRthQAjbtOXyxVYCihik+JXc5uSErB1jLx+3WfATFW6r1Ew26GJ57Pfro+Sf9kIi7vobwF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112574; c=relaxed/simple;
	bh=EZay6xnveTGa3mB/vfVwn0m9PhN8lyFM4GTXbByCzT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X3nc4UL95FzmTEO6vf3aDjadaryq1eSbHXJu9mIL+7txlGUMhf7/72Nj13qDF3Wcg0BIuBBC07bEbWVZE9ykRgQ0MhMep8wwLReX1pM79g+MdjG7AfEBEftzHAbjTTwZ2VAf3UsBY31PtO9Y7xYGiq0rfodaU+XjBxnmVozqXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKQKOVZ/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740112572; x=1771648572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EZay6xnveTGa3mB/vfVwn0m9PhN8lyFM4GTXbByCzT4=;
  b=LKQKOVZ/gStkUkYixzoGNymmD7wY/CdhHCBFtel+WJ6A07MmL3aG05oM
   SCol/+mF1H76jlKehYLMZajPVmuXYyzrpLjjsNUqbRfJQPOBQ76a4iwgh
   a39ZHz3Xc29Y2HaNV41Zr1N6/7vka3uaFJIDtWZVxvg4VuXg3wfgOcuKi
   bOjmnn4ZXeArwIIjH0WAC7xh2vu3syWtWW4MUGMjvgikgzTjkiiihYnd6
   zIWgPLJkjlEf1x/ZZ+krk1ilQMJBtK4nn5DaNlpqzROwv8cXqelbm0ELv
   rgZJovyNNZgKjb2ioth1HrJUi8PDeoyvHrB1QrgA4HOt/Q2mDjwildRq8
   A==;
X-CSE-ConnectionGUID: ochLk4iZQZ2ZJzAgNTy0yw==
X-CSE-MsgGUID: TGReeEvBTT6gPVVIVMzspQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40636099"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40636099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 20:36:12 -0800
X-CSE-ConnectionGUID: 15O3XsNGQyS5U+dafqk+EA==
X-CSE-MsgGUID: Z9haWoZmTnaHF70a9qpCGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115758422"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Feb 2025 20:36:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlKlj-00057L-0u;
	Fri, 21 Feb 2025 04:36:07 +0000
Date: Fri, 21 Feb 2025 12:36:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 42/43] include/linux/acpi.h:1133:49:
 warning: declaration of 'struct acpi_s2idle_dev_ops' will not be visible
 outside of this function
Message-ID: <202502211223.IKdRg7rk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2c6f7196fd5d56b357e1f68d7be5866963aeea6f
commit: b748ba3ac26ac7c6f5ff7dc55d27583ce6ab4506 [42/43] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
config: x86_64-buildonly-randconfig-002-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211223.IKdRg7rk-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211223.IKdRg7rk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211223.IKdRg7rk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/intel/int1092/intel_sar.c:6:
>> include/linux/acpi.h:1133:49: warning: declaration of 'struct acpi_s2idle_dev_ops' will not be visible outside of this function [-Wvisibility]
    1133 | static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
         |                                                 ^
   include/linux/acpi.h:1137:52: warning: declaration of 'struct acpi_s2idle_dev_ops' will not be visible outside of this function [-Wvisibility]
    1137 | static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
         |                                                    ^
   2 warnings generated.


vim +1133 include/linux/acpi.h

  1105	
  1106	#ifdef CONFIG_ACPI
  1107	void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
  1108				       u32 pm1a_ctrl,  u32 pm1b_ctrl));
  1109	
  1110	acpi_status acpi_os_prepare_sleep(u8 sleep_state,
  1111					  u32 pm1a_control, u32 pm1b_control);
  1112	
  1113	void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
  1114					        u32 val_a,  u32 val_b));
  1115	
  1116	acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
  1117						   u32 val_a, u32 val_b);
  1118	#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
  1119	struct acpi_s2idle_dev_ops {
  1120		struct list_head list_node;
  1121		void (*prepare)(void);
  1122		void (*check)(void);
  1123		void (*restore)(void);
  1124	};
  1125	int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
  1126	void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
  1127	int acpi_get_lps0_constraint(struct acpi_device *adev);
  1128	#else /* CONFIG_SUSPEND && CONFIG_X86 */
  1129	static inline int acpi_get_lps0_constraint(struct device *dev)
  1130	{
  1131		return ACPI_STATE_UNKNOWN;
  1132	}
> 1133	static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
  1134	{
  1135		return -ENODEV;
  1136	}
  1137	static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
  1138	{
  1139	}
  1140	#endif /* CONFIG_SUSPEND && CONFIG_X86 */
  1141	void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
  1142	#else
  1143	#define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
  1144	#endif
  1145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

