Return-Path: <linux-acpi+bounces-21420-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KIPD1aeqWnGAwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21420-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:16:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D68DC2144D3
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BC930D730A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C423BED66;
	Thu,  5 Mar 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSQAipHh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CE3BED2C;
	Thu,  5 Mar 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723787; cv=none; b=H5fyhi7Cb5vskUUesnmk0lehCLqsdEtBHna9Z8w6nTcgJKD7AhbwWXzxtd/D+JLQuvIsQ+aS4F7NZa9jPHtLzp4HwcU0saRoyWe+nONxRkUwrwhmC6PX+NlG5Uqb5NOyw4NJYO41Ew/KlAbbGSAtsU9FrqJHwxpFnY9QsQjZ9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723787; c=relaxed/simple;
	bh=NIqGePwhMB9v9rBzNePQxONPR4S/D8k+T7Bqpz8eGUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGSipjiSTkoyx6O+2efaz1aR510EhODJgM8jJmx9yuebWcugeqLLXvu9z7vUvHw93HWy1mUvMfflxqf+o3Dhfdmug817mMJFBCxFvMpFr+3mmNgxfxy0MMDEUJjTJ2UJqMOV4WjEdwdbgUktT5dzXOb05sMvgFmXMVXdJqk0Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSQAipHh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772723785; x=1804259785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIqGePwhMB9v9rBzNePQxONPR4S/D8k+T7Bqpz8eGUc=;
  b=dSQAipHhmy0H+N9tDTM/nvs8Plu35JsKm2ZAaxdmLrHKda6QVmmkQ6Yj
   AMZOnxrKYyl1iKZGX8SeuQH7gKeW/K5H059TlKAy5C1r+F/LA4uyd3H+G
   JzYDK74MuhXUQjsJXTzxQ9XhZDclUIv7FUroMJ+6GUJYmROuttz8nF1bY
   MGlWkETNaD/9DU2ZMBe+I3v2ybml5R1OiwpfPMNV2m0Xlw7Q/OQfjwySR
   KqeJsRj/SM8Z4k31wVCX04UM1SBtAXoDG7AqXYuYYnVUltnuiAB+q11JL
   rJc19CglQuGCK5DN/2Y0mMlluRGWnn1Bp59oZhXS+O0Wkt5hz/rBaPeTo
   w==;
X-CSE-ConnectionGUID: CR7Or4veS+SQgoBNdMK4TQ==
X-CSE-MsgGUID: r/fVigRNSzK8OB/S2sN1qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="96431008"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="96431008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:16:19 -0800
X-CSE-ConnectionGUID: wnCKV1F1Q4ykB5mWY2Gqag==
X-CSE-MsgGUID: Qs67a8/fRH2sHp+KnOhEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="223667087"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Mar 2026 07:16:13 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyAQs-000000000oU-2KhI;
	Thu, 05 Mar 2026 15:16:10 +0000
Date: Thu, 5 Mar 2026 23:15:45 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	jgg@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
	lenb@kernel.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <202603052303.jrfwR7CV-lkp@intel.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
X-Rspamd-Queue-Id: D68DC2144D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21420-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Nicolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge soc/for-next linus/master v7.0-rc2 next-20260304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-Do-not-call-pci_dev_reset_iommu_done-unless-reset-succeeds/20260305-132923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc%40nvidia.com
patch subject: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
config: arm64-randconfig-003-20260305 (https://download.01.org/0day-ci/archive/20260305/202603052303.jrfwR7CV-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603052303.jrfwR7CV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603052303.jrfwR7CV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:467:2: error: call to undeclared function 'pci_dev_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           pci_dev_lock(pdev);
           ^
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:471:2: error: call to undeclared function 'pci_dev_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           pci_dev_unlock(pdev);
           ^
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:480:7: error: call to undeclared function 'pci_reset_function'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!pci_reset_function(pdev)) {
                ^
   3 errors generated.


vim +/pci_dev_lock +467 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

   431	
   432	static void arm_smmu_atc_recovery_worker(struct work_struct *work)
   433	{
   434		struct arm_smmu_atc_recovery_param *param =
   435			container_of(work, struct arm_smmu_atc_recovery_param, work);
   436		struct pci_dev *pdev;
   437	
   438		scoped_guard(mutex, &param->smmu->streams_mutex) {
   439			struct arm_smmu_master *master;
   440	
   441			master = arm_smmu_find_master(param->smmu, param->sid);
   442			if (!master || WARN_ON(!dev_is_pci(master->dev)))
   443				goto free_param;
   444			pdev = to_pci_dev(master->dev);
   445			pci_dev_get(pdev);
   446		}
   447	
   448		scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock) {
   449			struct arm_smmu_atc_recovery_param *e;
   450	
   451			list_for_each_entry(e, &param->smmu->atc_recovery.list, node) {
   452				/* Device is already being recovered */
   453				if (e->pdev == pdev)
   454					goto put_pdev;
   455			}
   456			param->pdev = pdev;
   457			list_add(&param->node, &param->smmu->atc_recovery.list);
   458		}
   459	
   460		/*
   461		 * Stop DMA (PCI) and block ATS (IOMMU) immediately, to prevent memory
   462		 * corruption. This must take pci_dev_lock to prevent any racy unplug.
   463		 *
   464		 * If pci_dev_reset_iommu_prepare() fails, pci_reset_function will call
   465		 * it again internally.
   466		 */
 > 467		pci_dev_lock(pdev);
   468		pci_clear_master(pdev);
   469		if (pci_dev_reset_iommu_prepare(pdev))
   470			pci_err(pdev, "failed to block ATS!\n");
 > 471		pci_dev_unlock(pdev);
   472	
   473		/*
   474		 * ATC timeout indicates the device has stopped responding to coherence
   475		 * protocol requests. The only safe recovery is a reset to flush stale
   476		 * cached translations. Note that pci_reset_function() internally calls
   477		 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
   478		 * if PCI-level reset fails.
   479		 */
 > 480		if (!pci_reset_function(pdev)) {
   481			/*
   482			 * If reset succeeds, set BME back. Otherwise, fence the system
   483			 * from a faulty device, in which case user will have to replug
   484			 * the device to invoke pci_set_master().
   485			 */
   486			pci_dev_lock(pdev);
   487			pci_set_master(pdev);
   488			pci_dev_unlock(pdev);
   489		}
   490		scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock)
   491			list_del(&param->node);
   492	put_pdev:
   493		pci_dev_put(pdev);
   494	free_param:
   495		kfree(param);
   496	}
   497	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

