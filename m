Return-Path: <linux-acpi+bounces-20578-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FBVLaslc2nCsgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20578-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 08:39:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062871D5D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 08:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0F8D3019494
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20B33B96B;
	Fri, 23 Jan 2026 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dluQ0jAB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AC30BF6B;
	Fri, 23 Jan 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153862; cv=none; b=I/aXN440wdnxHkm775Tszr/Fo+yFezw4CiKk+xEynGhrrz0s7yP6Br8yf75GvcEtwvuuz+5lwYwEOQ2HQFapGHI7OaRDb4wCC4Yn9VFfw3Abnynxkg325/Q+WuQsWDIB4tIOdzkOVX6ejIajG929KhSLpPd89Hlre4K3ILyBZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153862; c=relaxed/simple;
	bh=vcTjSfEG+HWTwQpAtVnn3Ke1/38d6OtsJ+AlYoxxhGo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UBl5VsuE0ZCWbCupJ+nD9kyF+hctK/uv6t96sqVWJMXlxyuQXvf+ljPwfcQwD1QZHvnfUoraSiRoPEKCdJKJsseNEZMdYHOFZ9+5PSkbPykUpGrfua5I/civ/QtewvXuG4uzokr6hl0ANrlnHRb9ITUFMRZvVo8UNVCqDnu7mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dluQ0jAB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769153861; x=1800689861;
  h=date:from:to:cc:subject:message-id;
  bh=vcTjSfEG+HWTwQpAtVnn3Ke1/38d6OtsJ+AlYoxxhGo=;
  b=dluQ0jAB4Lv0OSkpSwqg9lA0kg/n+wQhpFwclVJZx6wsqsrTsRTBb73C
   1xd2Rv+NzLzTlN6NO7QEiP/Ae6EVT84PnXhd2r50lIJ5XetcsfqetlLaz
   mAwGX+qGGe2dZgPM7evixLYMZL6BYSgUJtLyD2btAGxBI9xOuRSjdsGGf
   t5okLYI2FqoReXu2x2L8SnfadMm7Vc+oEs4ZUGjuefxtxWq/+IIYGGGVd
   6kDJNOp49aJjHHW010yIPS7niFEU+Rb0JkOADNVPe5J2ElhYirSAtAl1p
   N2ubKfrV5lghh9eyTt4VvLlzCoY6B9L4Attvj3Q8DtRRSF/n10z/HvkkU
   w==;
X-CSE-ConnectionGUID: CqAQuVZtQC+MM3PzNexyvQ==
X-CSE-MsgGUID: Uu+jaiFHR1uWaDTO1vJ6FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70465390"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70465390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:37:40 -0800
X-CSE-ConnectionGUID: kF1AZjb2R5yRqOkfg2SnBw==
X-CSE-MsgGUID: sa/aVqylT3iHBlzQRwT0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211415015"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2026 23:37:38 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjBjc-00000000TeF-0FUA;
	Fri, 23 Jan 2026 07:37:36 +0000
Date: Fri, 23 Jan 2026 15:37:07 +0800
From: kernel test robot <lkp@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 175/176] ERROR: modpost:
 "tick_nohz_enabled" [drivers/cpufreq/cpufreq_ondemand.ko] undefined!
Message-ID: <202601231505.4Q8tb33s-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	TAGGED_FROM(0.00)[bounces-20578-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5062871D5D
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   8a22b02a1427ff0eab01a1b7cd62355238ba3d5b
commit: cc85c350babcb86c65da5393532f1cb255c750bc [175/176] cpufreq: ondemand: Simplify idle cputime granularity test
config: i386-buildonly-randconfig-002-20260123 (https://download.01.org/0day-ci/archive/20260123/202601231505.4Q8tb33s-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231505.4Q8tb33s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601231505.4Q8tb33s-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "tick_nohz_enabled" [drivers/cpufreq/cpufreq_ondemand.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

