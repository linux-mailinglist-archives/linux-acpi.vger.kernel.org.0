Return-Path: <linux-acpi+bounces-11363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933DA3EB7E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 04:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D506617B576
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 03:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3DD1F7910;
	Fri, 21 Feb 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPs8T5dd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B931519A2;
	Fri, 21 Feb 2025 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109497; cv=none; b=WAuQ/LzYabLU1jHh/UiRQlvFfX72dzsK65CzOJveOHqh+afltmuvToEiQCzi86jv8WeDNZTVbxkYBRpXoxdZx/ZlVq2QWu+Uq67RnExtORp7WGOOcepBfZZv3pWVbMvfi3vpd3oEOc8cfFsILaFrxB2prplLDDLh310hECwGc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109497; c=relaxed/simple;
	bh=KUTLgK2Xp2SvcKFL6jmGIV78nc4eHUxmVQMR4wPZNvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=llyzGy9JQ2Rm4dMC6NUPPE7QHP81EuqtruXO3BvmlCV8P6veTHVwobD6KYD81LX1M2OmSjiiP8IyvzmW+5RrEhwlCi3fO+Vs/15PDBpk1EkrPP5W7WPoRoBcdQycafaLLuE4/QRTYErqSJCYJlmTTllALWO5MF8r9PSWC4JShpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPs8T5dd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740109495; x=1771645495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KUTLgK2Xp2SvcKFL6jmGIV78nc4eHUxmVQMR4wPZNvU=;
  b=hPs8T5ddbDfwMptq02S98/rPPclo2HRPWX0YzqVBr2+2XWcqP8Keynqh
   /mpfezmdm3pN0DvA7xx6kla7HnLNvMesNmftHz28pyg6GXySuU2qB6pP2
   tW46CS2pLybxbGJrotCMjW81FQKEhhBU3tTRicMG2jJkNlaXUuB62cagN
   nGA5QUpwRxYja8M/sM9WE5DdROBW/kj91K9fTKRBQcvycU8T+RAZCqUet
   G455uAX7X8XP8FovoOkWBOAVl/Jd9pzTJvYDsY58oUCv9pj0pAYfb+jIY
   k4F05SFtIXu5i0s5fWrAO6qshOTHsLffC6pqjXVnNFrseYU7NgdsPwDRQ
   g==;
X-CSE-ConnectionGUID: lBIAe/YySs2EuxvoCOZQuA==
X-CSE-MsgGUID: nIUc0WdjT6C7ePhpMafMvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51536851"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="51536851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 19:44:54 -0800
X-CSE-ConnectionGUID: w6YGOm9tR0+73hlzEeyd8g==
X-CSE-MsgGUID: 5EQxgGyCR0yZTXGM6KdmQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115746845"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Feb 2025 19:44:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlJy5-00054f-2Z;
	Fri, 21 Feb 2025 03:44:49 +0000
Date: Fri, 21 Feb 2025 11:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 42/43] include/linux/acpi.h:1133:49:
 warning: 'struct acpi_s2idle_dev_ops' declared inside parameter list will
 not be visible outside of this definition or declaration
Message-ID: <202502211150.aq1wxCVv-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211150.aq1wxCVv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211150.aq1wxCVv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211150.aq1wxCVv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/tpm.h:21,
                    from include/keys/trusted-type.h:12,
                    from crypto/af_alg.c:26:
>> include/linux/acpi.h:1133:49: warning: 'struct acpi_s2idle_dev_ops' declared inside parameter list will not be visible outside of this definition or declaration
    1133 | static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
         |                                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/acpi.h:1137:52: warning: 'struct acpi_s2idle_dev_ops' declared inside parameter list will not be visible outside of this definition or declaration
    1137 | static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
         |                                                    ^~~~~~~~~~~~~~~~~~~


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

