Return-Path: <linux-acpi+bounces-21033-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLTLKsezmGk9LAMAu9opvQ
	(envelope-from <linux-acpi+bounces-21033-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 20:19:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7116A4FB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 20:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8F38300616C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F8365A1C;
	Fri, 20 Feb 2026 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUQ5LJ9O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E71862A;
	Fri, 20 Feb 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615173; cv=none; b=shaoKNSfFotlevwEA3sa5KTj8eY2CWsPjx7U80HHWGd0NLSgzK0ljwroqYkZEN3CciWMd7HoAQ9r2iGCdSuPJk9ojnbHYVwBB2lUzyIpMvau1JE1ViwaJxbFzNiFI2UvtVgWqGzlgjPlRZRGuVYHnr5q4zyTNVZQcDSx3srvf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615173; c=relaxed/simple;
	bh=Er+hsh1gG5ejQ2qPbFqaijfyXtfPJmp/EnPNlRqDWck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajJ2hh5xfC9/j209RLo81Vd84RTLv5WSMCJyvDZFK+v4IgBfDXmfKJp/CghepxrKYOtpNv91te3zOJsj9kw+xdTBvSIFODEiRvD1qXiB4ihZJxmu2qxodaWalY+ZgbIWRRNxCxSHVYn6mb7PDeFkt+YFnzuKmgLMDprQ2iaInVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUQ5LJ9O; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771615171; x=1803151171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Er+hsh1gG5ejQ2qPbFqaijfyXtfPJmp/EnPNlRqDWck=;
  b=jUQ5LJ9OInbRFScsEHWzwn0oAV0FFo+guHgYFGapp+itFBo07YUQp1WC
   rz/UMQso7wOPMXUoFTAc8c0/MTGuTANtSMFKTePlwLamXYvK4CtuPeh2v
   gLGSMkgwc00Zwwry7UNdRzn5Jt4jNvqTfMXdzZeu110aOIJy3eeCkgkIb
   NCUDmV3fM7vpOuaFa4jyHL+sPOfz9JmQerTKCBf0DiG6nH+RPLalig/py
   PGYSqolzLLJA8rZ5Z7exrivYxrHkTjlVpGRq+pgxVMmtq6a0KdPjj+1h0
   7bK1/b0B/y5n/Ef+EGqniLLGVszOt2py1cLCnEiJdtBu4W+zHKhID/wpi
   Q==;
X-CSE-ConnectionGUID: KQ5qjGBpSmytP5EFKB9ngA==
X-CSE-MsgGUID: Hr8X8Uj6SOSnTOxlmfYySQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83031462"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83031462"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 11:19:31 -0800
X-CSE-ConnectionGUID: caaxDMaPSwuglvvX91K68w==
X-CSE-MsgGUID: CNlHRdPdT3isOUcrHIwipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213021977"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Feb 2026 11:19:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtW28-000000014QK-3xTk;
	Fri, 20 Feb 2026 19:19:24 +0000
Date: Sat, 21 Feb 2026 03:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ahmed Tiba <ahmed.tiba@arm.com>,
	Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
	robh@kernel.org, rafael@kernel.org, will@kernel.org,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, krzk+dt@kernel.org,
	Michael.Zhao2@arm.com, tony.luck@intel.com
Subject: Re: [PATCH v2 09/11] ACPI: APEI: share GHES CPER helpers
Message-ID: <202602210334.nHzuTUCB-lkp@intel.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-9-347fa2d7351b@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-9-347fa2d7351b@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21033-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 53B7116A4FB
X-Rspamd-Action: no action

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8bf22c33e7a172fbc72464f4cc484d23a6b412ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ACPI-APEI-GHES-share-macros-via-a-private-header/20260220-214812
base:   8bf22c33e7a172fbc72464f4cc484d23a6b412ba
patch link:    https://lore.kernel.org/r/20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-9-347fa2d7351b%40arm.com
patch subject: [PATCH v2 09/11] ACPI: APEI: share GHES CPER helpers
config: i386-randconfig-012-20260220 (https://download.01.org/0day-ci/archive/20260221/202602210334.nHzuTUCB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602210334.nHzuTUCB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602210334.nHzuTUCB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/apei/ghes_cper.c: In function 'ghes_handle_arm_hw_error':
>> drivers/acpi/apei/ghes_cper.c:261:34: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     261 |                                  FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
         |                                  ^~~~~~~~~


vim +/FIELD_GET +261 drivers/acpi/apei/ghes_cper.c

   202	
   203	bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
   204					     int sev, bool sync)
   205	{
   206		struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
   207		int flags = sync ? MF_ACTION_REQUIRED : 0;
   208		int length = gdata->error_data_length;
   209		char error_type[120];
   210		bool queued = false;
   211		int sec_sev, i;
   212		char *p;
   213	
   214		sec_sev = ghes_severity(gdata->error_severity);
   215		if (length >= sizeof(*err)) {
   216			log_arm_hw_error(err, sec_sev);
   217		} else {
   218			pr_warn(FW_BUG "arm error length: %d\n", length);
   219			pr_warn(FW_BUG "length is too small\n");
   220			pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
   221			return false;
   222		}
   223	
   224		if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
   225			return false;
   226	
   227		p = (char *)(err + 1);
   228		length -= sizeof(err);
   229	
   230		for (i = 0; i < err->err_info_num; i++) {
   231			struct cper_arm_err_info *err_info;
   232			bool is_cache, has_pa;
   233	
   234			/* Ensure we have enough data for the error info header */
   235			if (length < sizeof(*err_info))
   236				break;
   237	
   238			err_info = (struct cper_arm_err_info *)p;
   239	
   240			/* Validate the claimed length before using it */
   241			length -= err_info->length;
   242			if (length < 0)
   243				break;
   244	
   245			is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
   246			has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
   247	
   248			/*
   249			 * The field (err_info->error_info & BIT(26)) is fixed to set to
   250			 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
   251			 * firmware won't mix corrected errors in an uncorrected section,
   252			 * and don't filter out 'corrected' error here.
   253			 */
   254			if (is_cache && has_pa) {
   255				queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
   256				p += err_info->length;
   257				continue;
   258			}
   259	
   260			cper_bits_to_str(error_type, sizeof(error_type),
 > 261					 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
   262					 cper_proc_error_type_strs,
   263					 ARRAY_SIZE(cper_proc_error_type_strs));
   264	
   265			pr_warn_ratelimited(FW_WARN GHES_PFX
   266					    "Unhandled processor error type 0x%02x: %s%s\n",
   267					    err_info->type, error_type,
   268					    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
   269			p += err_info->length;
   270		}
   271	
   272		return queued;
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

