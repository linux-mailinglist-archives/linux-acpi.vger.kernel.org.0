Return-Path: <linux-acpi+bounces-13085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1AA911AD
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC7A5A147A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6919DF60;
	Thu, 17 Apr 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jn6ducpr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD420330
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857089; cv=none; b=Ou5FgMuWw5uLnCHgyKoKSwBx8iqCbDTGD88jksPCvEBjTJ8vek93cU3o6SwMpuNYe6edNjSM3ur6zMKi9Dzf1tRB2whSeME8B+Qhyc++NStn7c7tEXEpI5uvrYOhDEGna1LYwhpG3yJX2+TRTZ/0FsX/GoLSZorIJ1jakHLZP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857089; c=relaxed/simple;
	bh=96aa4zrzQyGbRlohl9jdB2X82yywOyIXDiPDv8MILe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxQSZPizytQBfTpm3QuboaABZCRI4vJrThny59Pt/UXVOvOQ8Q1fFGNul4IXxOjxG8frYm1lMdduXNH0/F5f5DEgTcCG2hHTDj3auELbe/2vvBytNrxviqKucXXwP5wfkjyC+jo73tMaqrON/wDRe/snLSI8qltEGxXQ7+1FtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jn6ducpr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744857088; x=1776393088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=96aa4zrzQyGbRlohl9jdB2X82yywOyIXDiPDv8MILe4=;
  b=Jn6ducprHU/U/nvH7z/sG7GRJ491IfBXCOG+CN8DtuxYYGtkKZdnYMlp
   I54v5ZojXIH4cg1gcvcQdmjDNujpKi2MNRMrfn3RQcB7sFD30T/C4jPwI
   Pm2mqHfoyLEXfVXAy1x0T1zDD9HrSzxlp1FElRPBMIpAzH6WcEEva7mFy
   isZ54Ux1R6ZuFRUnKgSAU21jRbN2o4fNtwzoKDigz/eq7wuIUeHy+EyGH
   xakwF1j3Gon6P7Kz5es4i+HQ2gmCjXxbBsWCVHldweY0Gja8ryaXpglA0
   0OaPrE2IyOFu4DxLbAuxF8WjbfQj+VpHw2Vj1QgLV8BY9Bz65a2nXClBY
   g==;
X-CSE-ConnectionGUID: Ixxx6XmfQiK4wbRzuQfEWg==
X-CSE-MsgGUID: wZBN5LY5SKOsEwp7nFA97Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="45661966"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="45661966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:31:27 -0700
X-CSE-ConnectionGUID: xirsMLQCQniokGjYoN5jaA==
X-CSE-MsgGUID: IJYqnWkBR+GcE4bWJd7STQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130649828"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2025 19:31:25 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5F2B-000Ko8-08;
	Thu, 17 Apr 2025 02:31:23 +0000
Date: Thu, 17 Apr 2025 10:31:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	robert.moore@intel.com, rafael.j.wysocki@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH] ACPICA: Add support for printing AML arguments when
 trace point enabled
Message-ID: <202504171023.J2JiUDFj-lkp@intel.com>
References: <20250415192614.2042036-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415192614.2042036-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.15-rc2 next-20250416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPICA-Add-support-for-printing-AML-arguments-when-trace-point-enabled/20250416-125019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250415192614.2042036-1-superm1%40kernel.org
patch subject: [PATCH] ACPICA: Add support for printing AML arguments when trace point enabled
config: i386-buildonly-randconfig-006-20250417 (https://download.01.org/0day-ci/archive/20250417/202504171023.J2JiUDFj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250417/202504171023.J2JiUDFj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504171023.J2JiUDFj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/acpica/extrace.c: In function 'acpi_ex_trace_args':
>> drivers/acpi/acpica/extrace.c:174:69: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     174 |                         ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT, " "));
         |                                                                     ^
>> drivers/acpi/acpica/extrace.c:195:74: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
     195 |                         ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, ", "));
         |                                                                          ^


vim +/if +174 drivers/acpi/acpica/extrace.c

   149	
   150	/*******************************************************************************
   151	 *
   152	 * FUNCTION:    acpi_ex_trace_args
   153	 *
   154	 * PARAMETERS:  params            - AML method arguments
   155	 *              count             - numer of method arguments
   156	 *
   157	 * RETURN:      None
   158	 *
   159	 * DESCRIPTION: Trace any arguments
   160	 *
   161	 ******************************************************************************/
   162	
   163	void
   164	acpi_ex_trace_args(union acpi_operand_object **params, u32 count)
   165	{
   166		u32 i;
   167	
   168		ACPI_FUNCTION_NAME(ex_trace_args);
   169	
   170		for (i = 0; i < count; i++) {
   171			union acpi_operand_object *obj_desc = params[i];
   172	
   173			if (!i)
 > 174				ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT, " "));
   175	
   176			switch (obj_desc->common.type) {
   177			case ACPI_TYPE_INTEGER:
   178				ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "%llx", obj_desc->integer.value));
   179				break;
   180			case ACPI_TYPE_STRING:
   181				if (!obj_desc->string.length) {
   182					ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "NULL"));
   183					continue;
   184				}
   185				if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_TRACE_POINT, _COMPONENT))
   186					acpi_ut_print_string(obj_desc->string.pointer, ACPI_UINT8_MAX);
   187				break;
   188			default:
   189				ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "Unknown"));
   190				break;
   191			}
   192			if (i+1 == count)
   193				ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "\n"));
   194			else
 > 195				ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, ", "));
   196		}
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

