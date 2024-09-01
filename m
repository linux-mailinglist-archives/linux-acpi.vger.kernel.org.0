Return-Path: <linux-acpi+bounces-8055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F996757D
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E51F21C7C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6D14290C;
	Sun,  1 Sep 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx4SsqIS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E237E101;
	Sun,  1 Sep 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177583; cv=none; b=RR+pXKxoYWd2UoWUFE4HS//rLdo+bJrb5XuuxKVBciRl+BH5WnE5gPxfRPOlV4xGgY3cdt/54Iexg26VaVKryPfL5NkA+ObCbAtEY0wO3LEqzbwZCL9zhL8snYazgLpafs/XF71ayol0L8sRIrmyDkr3CxMhHrBjdCJZKRwW2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177583; c=relaxed/simple;
	bh=wvu12Ehzrk6KRlsZVBTLs0SKfiBW/rXovg7gQdDlHHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QOMLave1NJV5nt2FZ7u7/w35vT1HSNzlDTcWXvP+iCuWCdyb4nTKI9WY7/YNMN/DNnTJkFseSKunJJQPjMs3XE6uFrj7nQSvO/GZGHwIvJE+qyznVtTKXqOVVZF4WqRafK52KAlJEy9J2V1jdHcbV0sb17bollVu+bG06IT52hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kx4SsqIS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725177580; x=1756713580;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wvu12Ehzrk6KRlsZVBTLs0SKfiBW/rXovg7gQdDlHHQ=;
  b=kx4SsqISt+qFlaudkMhuyBWZ1kwVsTM1q6BogY5Hnphv7X1dt/muK5+b
   Pvtzk9Ezl9bAIoVRmj7ryCLffaFO/r/iq1pkHP4OF11raj3O04Buk+90M
   FbAp6ZLpXykfr63Zr5TIUdYYkNwPRuKVR4RCXMWCTZiPKZ0d/vc1HhWh0
   EcknxnTfufwS3X/I9qQsYbdNj4sjzcBH894mGvdH09stwPdux+tMEOsPK
   16TKE4bbm4DPJ1ALJ74GerhNjCEFTwwrWNipm3AAXcxss3Jn2Kh6soHMx
   yLZIWcNoNO20iW1sYaqoWE/HDvlhGRGDllR+q4CwYxDoBMnCOOpnhm1KE
   w==;
X-CSE-ConnectionGUID: QATY+5YOTlOt/KMz3Uuu3g==
X-CSE-MsgGUID: U3UATUbeSeGWwjZ0xFcXSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23939676"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="23939676"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 00:59:39 -0700
X-CSE-ConnectionGUID: Gq8oKVflShm0/ar2W4jMwg==
X-CSE-MsgGUID: 4rROlkngSSWdM32NdPJk4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="95010277"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 Sep 2024 00:59:38 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skfUl-0003Ww-33;
	Sun, 01 Sep 2024 07:59:35 +0000
Date: Sun, 1 Sep 2024 15:59:34 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 161/190] drivers/acpi/cppc_acpi.c:1141:3-4:
 Unneeded semicolon
Message-ID: <202409011554.KG79Y5xu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d683340e443e46fafe40b050b5dedb64924bf6c8
commit: d837dbba610b1219f626af9578518ae066ed0571 [161/190] ACPI: CPPC: Fix MASK_VAL() usage
config: x86_64-randconfig-103-20240901 (https://download.01.org/0day-ci/archive/20240901/202409011554.KG79Y5xu-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409011554.KG79Y5xu-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/acpi/cppc_acpi.c:1141:3-4: Unneeded semicolon

vim +1141 drivers/acpi/cppc_acpi.c

  1075	
  1076	static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
  1077	{
  1078		int ret_val = 0;
  1079		int size;
  1080		u64 prev_val;
  1081		void __iomem *vaddr = NULL;
  1082		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
  1083		struct cpc_reg *reg = &reg_res->cpc_entry.reg;
  1084		struct cpc_desc *cpc_desc;
  1085	
  1086		size = GET_BIT_WIDTH(reg);
  1087	
  1088		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
  1089			acpi_status status;
  1090	
  1091			status = acpi_os_write_port((acpi_io_address)reg->address,
  1092						    (u32)val, size);
  1093			if (ACPI_FAILURE(status)) {
  1094				pr_debug("Error: Failed to write SystemIO port %llx\n",
  1095					 reg->address);
  1096				return -EFAULT;
  1097			}
  1098	
  1099			return 0;
  1100		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
  1101			/*
  1102			 * For registers in PCC space, the register size is determined
  1103			 * by the bit width field; the access size is used to indicate
  1104			 * the PCC subspace id.
  1105			 */
  1106			size = reg->bit_width;
  1107			vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
  1108		}
  1109		else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
  1110			vaddr = reg_res->sys_mem_vaddr;
  1111		else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
  1112			return cpc_write_ffh(cpu, reg, val);
  1113		else
  1114			return acpi_os_write_memory((acpi_physical_address)reg->address,
  1115					val, size);
  1116	
  1117		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
  1118			cpc_desc = per_cpu(cpc_desc_ptr, cpu);
  1119			if (!cpc_desc) {
  1120				pr_debug("No CPC descriptor for CPU:%d\n", cpu);
  1121				return -ENODEV;
  1122			}
  1123	
  1124			spin_lock(&cpc_desc->rmw_lock);
  1125			switch (size) {
  1126			case 8:
  1127				prev_val = readb_relaxed(vaddr);
  1128				break;
  1129			case 16:
  1130				prev_val = readw_relaxed(vaddr);
  1131				break;
  1132			case 32:
  1133				prev_val = readl_relaxed(vaddr);
  1134				break;
  1135			case 64:
  1136				prev_val = readq_relaxed(vaddr);
  1137				break;
  1138			default:
  1139				spin_unlock(&cpc_desc->rmw_lock);
  1140				return -EFAULT;
> 1141			};
  1142			val = MASK_VAL_WRITE(reg, prev_val, val);
  1143			val |= prev_val;
  1144		}
  1145	
  1146		switch (size) {
  1147		case 8:
  1148			writeb_relaxed(val, vaddr);
  1149			break;
  1150		case 16:
  1151			writew_relaxed(val, vaddr);
  1152			break;
  1153		case 32:
  1154			writel_relaxed(val, vaddr);
  1155			break;
  1156		case 64:
  1157			writeq_relaxed(val, vaddr);
  1158			break;
  1159		default:
  1160			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
  1161				pr_debug("Error: Cannot write %u bit width to system memory: 0x%llx\n",
  1162					size, reg->address);
  1163			} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
  1164				pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
  1165					size, pcc_ss_id);
  1166			}
  1167			ret_val = -EFAULT;
  1168			break;
  1169		}
  1170	
  1171		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
  1172			spin_unlock(&cpc_desc->rmw_lock);
  1173	
  1174		return ret_val;
  1175	}
  1176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

