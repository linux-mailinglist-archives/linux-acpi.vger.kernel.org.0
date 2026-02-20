Return-Path: <linux-acpi+bounces-21037-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uuPwLDrPmGmcMwMAu9opvQ
	(envelope-from <linux-acpi+bounces-21037-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 22:16:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AA16AF10
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 22:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BFA30379AA
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977322D781E;
	Fri, 20 Feb 2026 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbGgw0G3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FB194C95;
	Fri, 20 Feb 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622196; cv=none; b=kdRjpwnaoBvruBiGpDj2xCXpSjYHihE/Ng+UaSsbYEn7Za6PwULnspANOY8oe2l7l53AEkbQwbmogM/pqImKKN7DUIzpwl8pKsCakn5spPu5cCpP6xFE7ehD+Mge0FLkKdoCjWQGrvcb8QqEJGFPz2avYnElQfwdpo9y4OKHJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622196; c=relaxed/simple;
	bh=/A8VHbK1+BXizuqbisUIPEpsfmgGvZL7TH/qol9/xoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7wOqD6+nH9MYxIfB2PI12ldoDQ8VcOyMG4cs3OS05e3Sohx5+Yu9EV36OdQs0gsBrcq+rzhXFhHWAZWn1D+7xvNLNaBS5hYfkw10bn1aNjqYEvegzJLCu0RJzowjNOt6q16KXAU2v2cvnYT2lRoq08djdufvh5tt2N8Bagw6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbGgw0G3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771622196; x=1803158196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/A8VHbK1+BXizuqbisUIPEpsfmgGvZL7TH/qol9/xoM=;
  b=gbGgw0G3A2ARrRnRClfFYkaLv3zx7+IlGBI1whS3ITEqeh8gmyOWPjBa
   D3q+Mje/wm+270Cknb7SbNjeRIMjHelkPbmazymMgg7KuZXQ0PBM37Zd9
   moirrIMLdmP9D6w1cEW2+57nALNtB9v+7P7YyldCF2Yg4T/DlraVcrtIh
   1OsKNUfXJw5p4fpfr6dIF8MaC2ANh0vBfU2ZokJB+dvUCvygcDHDdb42y
   yi+azchuf4cnge/4zHAYCFX7++c1NzRhcrrudtNH2NdyfOFbEc5IOhWhN
   Tycj8a78IIdZsYt6pKJ+IAJhQ6FeJnlBnvuu4lrtEIXBiR+wLY7Yby/K9
   g==;
X-CSE-ConnectionGUID: cFwGwASaQvOsuDH3G15i4Q==
X-CSE-MsgGUID: kZwYpL8pTGGCBc1nlUIrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="90127567"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="90127567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 13:16:35 -0800
X-CSE-ConnectionGUID: jrP7HSslSDuM1x7mg4dhKQ==
X-CSE-MsgGUID: 9CmteDAqQwyS+15UzI/jaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213976415"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2026 13:16:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtXrQ-000000014U0-2XCC;
	Fri, 20 Feb 2026 21:16:28 +0000
Date: Sat, 21 Feb 2026 05:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com,
	catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org,
	rafael@kernel.org, will@kernel.org, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
Subject: Re: [PATCH v2 09/11] ACPI: APEI: share GHES CPER helpers
Message-ID: <202602210530.ukbF5fjB-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21037-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: EB8AA16AF10
X-Rspamd-Action: no action

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8bf22c33e7a172fbc72464f4cc484d23a6b412ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ACPI-APEI-GHES-share-macros-via-a-private-header/20260220-214812
base:   8bf22c33e7a172fbc72464f4cc484d23a6b412ba
patch link:    https://lore.kernel.org/r/20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-9-347fa2d7351b%40arm.com
patch subject: [PATCH v2 09/11] ACPI: APEI: share GHES CPER helpers
config: x86_64-randconfig-004-20260220 (https://download.01.org/0day-ci/archive/20260221/202602210530.ukbF5fjB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602210530.ukbF5fjB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602210530.ukbF5fjB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/apei/ghes_cper.c:261:6: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     261 |                                  FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
         |                                  ^
   1 error generated.


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

