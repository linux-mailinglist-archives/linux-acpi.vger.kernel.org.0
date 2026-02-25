Return-Path: <linux-acpi+bounces-21156-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP84EVEVn2nWYwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21156-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 16:29:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D414A1999A1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEB05301DEFB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20473D3D04;
	Wed, 25 Feb 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko3Ke0Er"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBC3D6463;
	Wed, 25 Feb 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033358; cv=none; b=hy6dat2U2ckHnEFMxqELYyi2yq+G1Q4srzEc8wFcbJ6J0FVAq2+RUibYQgfW/pQDhjYb5a45ayJJ1i68GW4zu569lV3tJNKKHPXhIXmhtdoPSiP4qZODfZnuHY4vkajwxU70d+HkuXtM24y3i28gqppc2VYV2byylaTOrhKCdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033358; c=relaxed/simple;
	bh=yp6DdR+CnUVRzKCo7PdoJuHn56WDTN6i8iN9GtPIOvo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T+91WC7JBID8YIC6g3VVtC3XZM8jB993dm2syZmMU+jxEUyMwfVHMD4r1cYs58NZXHI7O/wSv205bzlDWwXRkt18kgR0dY0hqeb4sc4duOkuQkUauZhGGbzvqD2TdonH+1OKkZuixfaUNXxA4BSGifZTFBpAPALrITHkpgGU6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko3Ke0Er; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772033356; x=1803569356;
  h=date:from:to:cc:subject:message-id;
  bh=yp6DdR+CnUVRzKCo7PdoJuHn56WDTN6i8iN9GtPIOvo=;
  b=ko3Ke0ErVjV2Ihm/bFGUIPtPWtyAtaXQ76qNBYig0SevmdaIhFBH/asb
   hvTiTPvSSkFnYpjQfpj+CUXxZpEqA9VgH8LuSe1ISkLDH+k1ywyNlc4rC
   SG6D7W64fJZQfZXe2q3cvfQncFNwY9ciKYB8lnkHqT451Ym7Lsa66vX9T
   81LgwF5wXMdvQF30vv42Klfw0Hgg/QG7EKehnOWF4FQYpFSRZ1toCHgDR
   PtYrkwoeJmCq8Sts/qneDH1RUHipjmMaUx5vLQ1kwEu5SlXfmPXlCcc/D
   uLQ+sGXab+tSxcYTGTL4GpM+laHu49to9dDREUxInhr0dV9ALGrV7zAAs
   A==;
X-CSE-ConnectionGUID: QhlyF1HYRz6NTlkCaYAbbQ==
X-CSE-MsgGUID: di3I3xb8QaG7KFoIMUXUOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83699580"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83699580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:29:16 -0800
X-CSE-ConnectionGUID: IfCBFC0CRXWmyNQFZmxhEw==
X-CSE-MsgGUID: oraImQJhQnC5gqGLzhiK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215486520"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 25 Feb 2026 07:29:14 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvGp5-000000006IQ-2vVP;
	Wed, 25 Feb 2026 15:29:11 +0000
Date: Wed, 25 Feb 2026 23:28:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:acpi-rtc 13/14]
 drivers/acpi/acpi_tad.c:739:undefined reference to `devm_rtc_device_register'
Message-ID: <202602252305.jArn4xPs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21156-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D414A1999A1
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-rtc
head:   52b552ea2b0e12800942e22f4ed3dbc7f394dec9
commit: ad9f759418050a355eb90ac010b8db05d4d6f23c [13/14] ACPI: TAD: Add RTC class device interface
config: i386-randconfig-014-20260225 (https://download.01.org/0day-ci/archive/20260225/202602252305.jArn4xPs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260225/202602252305.jArn4xPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602252305.jArn4xPs-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/acpi/acpi_tad.o: in function `acpi_tad_probe':
>> drivers/acpi/acpi_tad.c:739:(.text+0xe8e): undefined reference to `devm_rtc_device_register'


vim +739 drivers/acpi/acpi_tad.c

   683	
   684	static int acpi_tad_probe(struct platform_device *pdev)
   685	{
   686		struct device *dev = &pdev->dev;
   687		acpi_handle handle = ACPI_HANDLE(dev);
   688		struct acpi_tad_driver_data *dd;
   689		acpi_status status;
   690		unsigned long long caps;
   691		int ret;
   692	
   693		/*
   694		 * Initialization failure messages are mostly about firmware issues, so
   695		 * print them at the "info" level.
   696		 */
   697		status = acpi_evaluate_integer(handle, "_GCP", NULL, &caps);
   698		if (ACPI_FAILURE(status)) {
   699			dev_info(dev, "Unable to get capabilities\n");
   700			return -ENODEV;
   701		}
   702	
   703		if (!acpi_has_method(handle, "_PRW")) {
   704			dev_info(dev, "Missing _PRW\n");
   705			return -ENODEV;
   706		}
   707	
   708		dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
   709		if (!dd)
   710			return -ENOMEM;
   711	
   712		dd->capabilities = caps;
   713		dev_set_drvdata(dev, dd);
   714	
   715		/*
   716		 * Assume that the ACPI PM domain has been attached to the device and
   717		 * simply enable system wakeup and runtime PM and put the device into
   718		 * runtime suspend.  Everything else should be taken care of by the ACPI
   719		 * PM domain callbacks.
   720		 */
   721		device_init_wakeup(dev, true);
   722		dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
   723					     DPM_FLAG_MAY_SKIP_RESUME);
   724		/*
   725		 * The platform bus type layer tells the ACPI PM domain powers up the
   726		 * device, so set the runtime PM status of it to "active".
   727		 */
   728		pm_runtime_set_active(dev);
   729		pm_runtime_enable(dev);
   730		pm_runtime_suspend(dev);
   731	
   732		ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
   733		if (ret) {
   734			acpi_tad_remove(pdev);
   735			return ret;
   736		}
   737	
   738		if (caps & ACPI_TAD_RT)
 > 739			devm_rtc_device_register(dev, "acpi-tad-rtc", &acpi_tad_rtc_ops,
   740						 THIS_MODULE);
   741	
   742		return 0;
   743	}
   744	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

