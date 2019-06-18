Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2174A0F1
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRMiH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 08:38:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:64478 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMiH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 08:38:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 05:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="161863794"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.66.75.132]) ([10.66.75.132])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2019 05:38:03 -0700
Subject: Re: [pm:bleeding-edge 51/55] drivers//powercap/intel_rapl.c:1148:2:
 note: in expansion of macro 'INTEL_CPU_FAM6'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <201906181829.CstPoifV%lkp@intel.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <ae09fe46-2263-711d-de24-6b8158ca2bbd@linux.intel.com>
Date:   Tue, 18 Jun 2019 18:08:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906181829.CstPoifV%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 18-Jun-19 3:59 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   02f436aad250841d42baf9a3c47ad5646eb4ad31
> commit: d2658d7b4985a4fdbdab02e0e651a5778ccfcf1c [51/55] powercap: rapl: Add Ice Lake NNPI support to RAPL driver
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          git checkout d2658d7b4985a4fdbdab02e0e651a5778ccfcf1c
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from drivers//powercap/intel_rapl.c:25:0:
>>> arch/x86/include/asm/intel-family.h:97:23: error: 'INTEL_FAM6_ICELAKE_NNPI' undeclared here (not in a function); did you mean 'INTEL_FAM6_ICELAKE_X'?

This patch depends on 
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e32d045cd4ba06b59878323e434bad010e78e658 
and that patch is already accepted.


>       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
>                            ^
>     arch/x86/include/asm/intel-family.h:91:12: note: in definition of macro 'INTEL_CPU_FAM_ANY'
>       .model  = _model,    \
>                 ^~~~~~
>>> drivers//powercap/intel_rapl.c:1148:2: note: in expansion of macro 'INTEL_CPU_FAM6'
>       INTEL_CPU_FAM6(ICELAKE_NNPI,  rapl_defaults_core),
>       ^~~~~~~~~~~~~~
> --
>     In file included from drivers/powercap/intel_rapl.c:25:0:
>>> arch/x86/include/asm/intel-family.h:97:23: error: 'INTEL_FAM6_ICELAKE_NNPI' undeclared here (not in a function); did you mean 'INTEL_FAM6_ICELAKE_X'?
>       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
>                            ^
>     arch/x86/include/asm/intel-family.h:91:12: note: in definition of macro 'INTEL_CPU_FAM_ANY'
>       .model  = _model,    \
>                 ^~~~~~
>     drivers/powercap/intel_rapl.c:1148:2: note: in expansion of macro 'INTEL_CPU_FAM6'
>       INTEL_CPU_FAM6(ICELAKE_NNPI,  rapl_defaults_core),
>       ^~~~~~~~~~~~~~
>
> vim +/INTEL_CPU_FAM6 +1148 drivers//powercap/intel_rapl.c
>
>    1123	
>    1124	static const struct x86_cpu_id rapl_ids[] __initconst = {
>    1125		INTEL_CPU_FAM6(SANDYBRIDGE,		rapl_defaults_core),
>    1126		INTEL_CPU_FAM6(SANDYBRIDGE_X,		rapl_defaults_core),
>    1127	
>    1128		INTEL_CPU_FAM6(IVYBRIDGE,		rapl_defaults_core),
>    1129		INTEL_CPU_FAM6(IVYBRIDGE_X,		rapl_defaults_core),
>    1130	
>    1131		INTEL_CPU_FAM6(HASWELL_CORE,		rapl_defaults_core),
>    1132		INTEL_CPU_FAM6(HASWELL_ULT,		rapl_defaults_core),
>    1133		INTEL_CPU_FAM6(HASWELL_GT3E,		rapl_defaults_core),
>    1134		INTEL_CPU_FAM6(HASWELL_X,		rapl_defaults_hsw_server),
>    1135	
>    1136		INTEL_CPU_FAM6(BROADWELL_CORE,		rapl_defaults_core),
>    1137		INTEL_CPU_FAM6(BROADWELL_GT3E,		rapl_defaults_core),
>    1138		INTEL_CPU_FAM6(BROADWELL_XEON_D,	rapl_defaults_core),
>    1139		INTEL_CPU_FAM6(BROADWELL_X,		rapl_defaults_hsw_server),
>    1140	
>    1141		INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		rapl_defaults_core),
>    1142		INTEL_CPU_FAM6(SKYLAKE_MOBILE,		rapl_defaults_core),
>    1143		INTEL_CPU_FAM6(SKYLAKE_X,		rapl_defaults_hsw_server),
>    1144		INTEL_CPU_FAM6(KABYLAKE_MOBILE,		rapl_defaults_core),
>    1145		INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>    1146		INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
>    1147		INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
>> 1148		INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
>    1149	
>    1150		INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>    1151		INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
>    1152		INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	rapl_defaults_tng),
>    1153		INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	rapl_defaults_ann),
>    1154		INTEL_CPU_FAM6(ATOM_GOLDMONT,		rapl_defaults_core),
>    1155		INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	rapl_defaults_core),
>    1156		INTEL_CPU_FAM6(ATOM_GOLDMONT_X,		rapl_defaults_core),
>    1157		INTEL_CPU_FAM6(ATOM_TREMONT_X,		rapl_defaults_core),
>    1158	
>    1159		INTEL_CPU_FAM6(XEON_PHI_KNL,		rapl_defaults_hsw_server),
>    1160		INTEL_CPU_FAM6(XEON_PHI_KNM,		rapl_defaults_hsw_server),
>    1161		{}
>    1162	};
>    1163	MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
>    1164	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
