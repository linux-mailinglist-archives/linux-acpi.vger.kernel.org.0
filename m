Return-Path: <linux-acpi+bounces-21157-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD3dNwMzn2mtZQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21157-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 18:36:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E119B9FE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E98F300B290
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FED3D7D7E;
	Wed, 25 Feb 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDu4rfoc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E9329C6D;
	Wed, 25 Feb 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040957; cv=none; b=brXMU3OpUZ0WgFdHagjbrjYGLYqGOgv5bosOaBOfu7PcfR50IkFnKL2o3B69DUEXD7QrfEOgeoimNlypr2U9a1KFJe2b12MUCAe4ktbqmZTabUIlkfim75E1Hl4AgoqC2SZ2NVhZzmisc3C6p8ag1CLifIDM3UWuhVIQqQhh5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040957; c=relaxed/simple;
	bh=qEluW86xMkOYUJUl0za5dS2NhxcLy9wJwObTxQDqauU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PbsZyNYF9LApOPCf0D5fMjNolrpHL8yUK6UIIxTfMH4FarChwf9jh7TrdhizvHMGcvsiHHldjj7VGpobhIpbVG/qTfnTfaukOuHVfE+v/+Yv3XHTJ/3qKT2T8/Aej1Cfd8ozvOHajZ/q8kYVvpxuwlmp2KVBTA0wX0iieDmcqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDu4rfoc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772040956; x=1803576956;
  h=date:from:to:cc:subject:message-id;
  bh=qEluW86xMkOYUJUl0za5dS2NhxcLy9wJwObTxQDqauU=;
  b=gDu4rfoct8RkXS5NqlPGYOrJ8kjLPWu3TIcN/F+O7d66vXVQnxFbN2Mb
   wZ+V/27bIOmxZdv8dfKKmKMG8lpX4z1AqWvO5IWHK7PApL48fwIqE2hWk
   UosiA8z5cBxUxzfGXbRj7F6b38lgtlPEgCkUmvqwzV+X382azj3AoYt6j
   Lc30gU7hIYTecuuVMW4HHPxrLwyDBirTCJBp/7JCI3QZpW4vRkOmWZz6M
   pWrEJ10YXBVumS6q6bYVWadQk43iuogGc6Z/VjBNzRPjLvARd2SRQpsdx
   jtiWI+YBXsbihk+mzyGPMKPLBILtFSje3jufJwc2E6y7ckFOnhqtesyKw
   g==;
X-CSE-ConnectionGUID: XQfo0ZxJTg6jK2IBc5P7pw==
X-CSE-MsgGUID: fSczmrp7QA6d4jI9L3M1cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73264682"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73264682"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:35:55 -0800
X-CSE-ConnectionGUID: 5IbQpk4WRmSIuP72j5fHpg==
X-CSE-MsgGUID: HZrjwSK9RQySFovmWgdUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="254059905"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Feb 2026 09:35:54 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvInf-000000006oi-2K7v;
	Wed, 25 Feb 2026 17:35:51 +0000
Date: Thu, 26 Feb 2026 01:35:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 76/102]
 drivers/platform/chrome/chromeos_tbmc.c:50:9: error: expected ',' or ';'
 before 'struct'
Message-ID: <202602260106.dVqBEPAB-lkp@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21157-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E74E119B9FE
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   afb26ba421df11fad71fc4be9b874a901efb0388
commit: 37ca8e5f81981188405d5722825b58173c275fb5 [76/102] platform/chrome: chromeos_tbmc: Convert to a platform driver
config: x86_64-randconfig-161-20260225 (https://download.01.org/0day-ci/archive/20260226/202602260106.dVqBEPAB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260106.dVqBEPAB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260106.dVqBEPAB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/chrome/chromeos_tbmc.c: In function 'chromeos_tbmc_notify':
>> drivers/platform/chrome/chromeos_tbmc.c:50:9: error: expected ',' or ';' before 'struct'
      50 |         struct acpi_device *adev = ACPI_COMPANION(dev);
         |         ^~~~~~
   In file included from include/linux/acpi.h:38,
                    from drivers/platform/chrome/chromeos_tbmc.c:15:
>> include/acpi/acpi_bus.h:531:10: error: expected statement before ')' token
     531 |         })
         |          ^
   include/linux/acpi.h:58:41: note: in expansion of macro 'to_acpi_device_node'
      58 | #define ACPI_COMPANION(dev)             to_acpi_device_node((dev)->fwnode)
         |                                         ^~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/chromeos_tbmc.c:50:36: note: in expansion of macro 'ACPI_COMPANION'
      50 |         struct acpi_device *adev = ACPI_COMPANION(dev);
         |                                    ^~~~~~~~~~~~~~
>> drivers/platform/chrome/chromeos_tbmc.c:52:31: error: 'adev' undeclared (first use in this function); did you mean 'dev'?
      52 |         acpi_pm_wakeup_event(&adev->dev);
         |                               ^~~~
         |                               dev
   drivers/platform/chrome/chromeos_tbmc.c:52:31: note: each undeclared identifier is reported only once for each function it appears in


vim +50 drivers/platform/chrome/chromeos_tbmc.c

    46	
    47	static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
    48	{
    49		struct device *dev = data
  > 50		struct acpi_device *adev = ACPI_COMPANION(dev);
    51	
  > 52		acpi_pm_wakeup_event(&adev->dev);
    53		switch (event) {
    54		case 0x80:
    55			chromeos_tbmc_query_switch(adev, dev_get_drvdata(dev));
    56			break;
    57		default:
    58			dev_err(dev, "Unexpected event: 0x%08X\n", event);
    59		}
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

