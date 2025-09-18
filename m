Return-Path: <linux-acpi+bounces-17100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D3B830B2
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699B83B3F11
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15F259CAB;
	Thu, 18 Sep 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iujtcaa5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AC34BA25;
	Thu, 18 Sep 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174557; cv=none; b=lsI7gnHD6mugpiSw57b0lQfQWuiSXoLwbgGhNTkc62OVIzDHHVIeVM5kOouBCsrKv6V67sxtI195YbtWcVq+dpenirboToXnfSgS2aaysowND8ZkZtNz/03+bWdUaUEXE/Z/H+1NYeah6o67DwKuPqaq03RGpdo0BO8zLb5a1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174557; c=relaxed/simple;
	bh=FMI5vLJhbLQPMMxIl/P/O+8VDOpxYiBvnU54PY056v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnXaQmI/ig9CeQjA+Y1ae6pIyekaad10Bo0wBAKCjVWBMXHc1KO+1GjuCP+MXJk8fvIZPaM6jqnjWOXBnoyo8/lp7cH3OtCGFEy2UUATibwsW2IzEETb+pgVz+YWVWQ7REynAPn7DxayV9M4Vp7YIVV+5eTRZyeFck5CVHe3V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iujtcaa5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758174556; x=1789710556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FMI5vLJhbLQPMMxIl/P/O+8VDOpxYiBvnU54PY056v8=;
  b=Iujtcaa5NxlZYLLfROrr3Vv+V+a4HgdsLpbwZHxKO2JN+pe0OqzLhDy4
   iszHQZ6zfGIyMOEKyKr8YaRwHSpWeOB9i8lfOE5Se67AuhciAOnymvlQH
   McP+koRV8xFmsTf/ODLLvIs/GVDGET39kKCf9mK2IWJHy30xlxqDp+F6m
   HneErw3q7F3Mza/NAt8W4MbYshqiFIc2f4wudRIJvBFSV2GtAXqzUpa9O
   TZEiw6jukK0uwz9iahWAolUqeeSbj4eEScfBZsjGTwmSAZw8f3MDQ4vM/
   oyTkzSSf4i8G3DZ7HrKIvGvyYJtycKBAXTcQ0P0R3+rQ6PiwnvtPMtuXj
   w==;
X-CSE-ConnectionGUID: 8wjpIxVERn+bzXAiv5tcTQ==
X-CSE-MsgGUID: EyN64aGTSoucOr5lAI0qHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71862285"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71862285"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:49:14 -0700
X-CSE-ConnectionGUID: sYjqVjXCRVqCzBW3JWT55w==
X-CSE-MsgGUID: G3tz06RZQhOc0MLkJsdMIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175019165"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 22:49:09 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz7Vy-0002nr-0N;
	Thu, 18 Sep 2025 05:49:06 +0000
Date: Thu, 18 Sep 2025 13:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Slawomir Rosek <srosek@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tomasz Nowicki <tnowicki@google.com>,
	Stanislaw Kardach <skardach@google.com>,
	Michal Krawczyk <mikrawczyk@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
	Slawomir Rosek <srosek@google.com>
Subject: Re: [PATCH v2 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
Message-ID: <202509181359.fLTuROj6-lkp@intel.com>
References: <20250917120719.2390847-2-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917120719.2390847-2-srosek@google.com>

Hi Slawomir,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge rafael-pm/thermal driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.17-rc6 next-20250917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Slawomir-Rosek/ACPI-DPTF-Ignore-SoC-DTS-thermal-while-scanning/20250917-201033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250917120719.2390847-2-srosek%40google.com
patch subject: [PATCH v2 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
config: i386-randconfig-003-20250918 (https://download.01.org/0day-ci/archive/20250918/202509181359.fLTuROj6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509181359.fLTuROj6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509181359.fLTuROj6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/intel/int340x_thermal/platform_temperature_control.c: In function 'ptc_mmio_show':
>> drivers/thermal/intel/int340x_thermal/platform_temperature_control.c:110:19: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
     110 |         reg_val = readq((void __iomem *) (proc_priv->mmio_base + data->offset));
         |                   ^~~~~
         |                   readl
   drivers/thermal/intel/int340x_thermal/platform_temperature_control.c: In function 'ptc_mmio_write':
>> drivers/thermal/intel/int340x_thermal/platform_temperature_control.c:142:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Wimplicit-function-declaration]
     142 |         writeq(reg_val, (void __iomem *) (proc_priv->mmio_base + offset));
         |         ^~~~~~
         |         writel
--
   drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c: In function 'int340x_thermal_read_trips':
>> drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:72:15: error: implicit declaration of function 'thermal_acpi_critical_trip_temp'; did you mean 'thermal_zone_set_trip_temp'? [-Wimplicit-function-declaration]
      72 |         ret = thermal_acpi_critical_trip_temp(zone_adev,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               thermal_zone_set_trip_temp
>> drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:79:15: error: implicit declaration of function 'thermal_acpi_hot_trip_temp'; did you mean 'thermal_zone_set_trip_temp'? [-Wimplicit-function-declaration]
      79 |         ret = thermal_acpi_hot_trip_temp(zone_adev,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |               thermal_zone_set_trip_temp
>> drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:86:15: error: implicit declaration of function 'thermal_acpi_passive_trip_temp'; did you mean 'thermal_zone_set_trip_temp'? [-Wimplicit-function-declaration]
      86 |         ret = thermal_acpi_passive_trip_temp(zone_adev,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               thermal_zone_set_trip_temp
>> drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:94:23: error: implicit declaration of function 'thermal_acpi_active_trip_temp'; did you mean 'thermal_zone_set_trip_temp'? [-Wimplicit-function-declaration]
      94 |                 ret = thermal_acpi_active_trip_temp(zone_adev, i,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       thermal_zone_set_trip_temp
--
   drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c: In function 'proc_thermal_read_power_floor_status':
>> drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c:42:18: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
      42 |         status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
         |                  ^~~~~
         |                  readl
   In file included from include/linux/bits.h:5,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:103,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:382,
                    from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from include/linux/pci.h:27,
                    from drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c:29:
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c:32:41: note: in expansion of macro 'BIT'
      32 | #define SOC_POWER_FLOOR_STATUS          BIT(39)
         |                                         ^~~
   drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c:43:26: note: in expansion of macro 'SOC_POWER_FLOOR_STATUS'
      43 |         return (status & SOC_POWER_FLOOR_STATUS) >> SOC_POWER_FLOOR_SHIFT;
         |                          ^~~~~~~~~~~~~~~~~~~~~~
--
   drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c: In function 'workload_type_index_show':
>> drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c:69:18: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
      69 |         status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
         |                  ^~~~~
         |                  readl
--
   drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c: In function 'proc_thermal_clear_soc_int_status':
>> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c:145:18: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
     145 |         status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
         |                  ^~~~~
         |                  readl
>> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c:146:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Wimplicit-function-declaration]
     146 |         writeq(status & ~SOC_WT_RES_INT_STATUS_MASK,
         |         ^~~~~~
         |         writel
--
   drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c: In function 'read_soc_slider':
>> drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c:166:16: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
     166 |         return readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
         |                ^~~~~
         |                readl
   drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c: In function 'write_soc_slider':
>> drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.c:171:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Wimplicit-function-declaration]
     171 |         writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
         |         ^~~~~~
         |         writel

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for INT340X_THERMAL
   Depends on [n]: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86_64 [=n] && ACPI [=y] && PCI [=y] && NET [=y]
   Selected by [y]:
   - INTEL_SOC_DTS_THERMAL [=y] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && PCI [=y] && ACPI [=y]


vim +110 drivers/thermal/intel/int340x_thermal/platform_temperature_control.c

9befea30133ca4 Srinivas Pandruvada 2025-04-28   90  
9befea30133ca4 Srinivas Pandruvada 2025-04-28   91  static ssize_t ptc_mmio_show(struct ptc_data *data, struct device *dev,
9befea30133ca4 Srinivas Pandruvada 2025-04-28   92  			     struct device_attribute *attr, char *buf)
9befea30133ca4 Srinivas Pandruvada 2025-04-28   93  {
9befea30133ca4 Srinivas Pandruvada 2025-04-28   94  	struct pci_dev *pdev = to_pci_dev(dev);
9befea30133ca4 Srinivas Pandruvada 2025-04-28   95  	struct proc_thermal_device *proc_priv;
9befea30133ca4 Srinivas Pandruvada 2025-04-28   96  	const struct mmio_reg *mmio_regs;
9befea30133ca4 Srinivas Pandruvada 2025-04-28   97  	int ret, units;
9befea30133ca4 Srinivas Pandruvada 2025-04-28   98  	u64 reg_val;
9befea30133ca4 Srinivas Pandruvada 2025-04-28   99  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  100  	proc_priv = pci_get_drvdata(pdev);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  101  	mmio_regs = ptc_mmio_regs;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  102  	ret = match_string(ptc_strings, -1, attr->attr.name);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  103  	if (ret < 0)
9befea30133ca4 Srinivas Pandruvada 2025-04-28  104  		return ret;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  105  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  106  	units = mmio_regs[ret].units;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  107  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  108  	guard(mutex)(&ptc_lock);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  109  
9befea30133ca4 Srinivas Pandruvada 2025-04-28 @110  	reg_val = readq((void __iomem *) (proc_priv->mmio_base + data->offset));
9befea30133ca4 Srinivas Pandruvada 2025-04-28  111  	ret = (reg_val >> mmio_regs[ret].shift) & mmio_regs[ret].mask;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  112  	if (units)
9befea30133ca4 Srinivas Pandruvada 2025-04-28  113  		ret *= units;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  114  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  115  	return sysfs_emit(buf, "%d\n", ret);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  116  }
9befea30133ca4 Srinivas Pandruvada 2025-04-28  117  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  118  #define PTC_SHOW(suffix)\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  119  static ssize_t suffix##_show(struct device *dev,\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  120  			     struct device_attribute *attr,\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  121  			     char *buf)\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  122  {\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  123  	struct ptc_data *data = container_of(attr, struct ptc_data, suffix##_attr);\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  124  	return ptc_mmio_show(data, dev, attr, buf);\
9befea30133ca4 Srinivas Pandruvada 2025-04-28  125  }
9befea30133ca4 Srinivas Pandruvada 2025-04-28  126  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  127  static void ptc_mmio_write(struct pci_dev *pdev, u32 offset, int index, u32 value)
9befea30133ca4 Srinivas Pandruvada 2025-04-28  128  {
9befea30133ca4 Srinivas Pandruvada 2025-04-28  129  	struct proc_thermal_device *proc_priv;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  130  	u64 mask, reg_val;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  131  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  132  	proc_priv = pci_get_drvdata(pdev);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  133  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  134  	mask = GENMASK_ULL(ptc_mmio_regs[index].shift + ptc_mmio_regs[index].bits - 1,
9befea30133ca4 Srinivas Pandruvada 2025-04-28  135  			   ptc_mmio_regs[index].shift);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  136  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  137  	guard(mutex)(&ptc_lock);
9befea30133ca4 Srinivas Pandruvada 2025-04-28  138  
9befea30133ca4 Srinivas Pandruvada 2025-04-28  139  	reg_val = readq((void __iomem *) (proc_priv->mmio_base + offset));
9befea30133ca4 Srinivas Pandruvada 2025-04-28  140  	reg_val &= ~mask;
9befea30133ca4 Srinivas Pandruvada 2025-04-28  141  	reg_val |= (value << ptc_mmio_regs[index].shift);
9befea30133ca4 Srinivas Pandruvada 2025-04-28 @142  	writeq(reg_val, (void __iomem *) (proc_priv->mmio_base + offset));
9befea30133ca4 Srinivas Pandruvada 2025-04-28  143  }
9befea30133ca4 Srinivas Pandruvada 2025-04-28  144  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

