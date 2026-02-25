Return-Path: <linux-acpi+bounces-21158-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM5xBwMzn2lXZQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21158-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 18:36:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B499D19B9FD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECEDD300D377
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458F73BFE2D;
	Wed, 25 Feb 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFi4eQZt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BA33AD82;
	Wed, 25 Feb 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040958; cv=none; b=cG27sbUDOvbyuhkBPH3PJBuMlk0nH9NXSEb5C9C4X541jtp5JbIKWZ+57JFNjrTxa6CKtyickMF0xeQtM/XNEIk3L/PqnOvpqKwTdiR21fEpm+bLGoVGIgKYh6FU/RSW7td1hARCALr8ftyX1IDkp8KLEqnDZptkrofJNpEDJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040958; c=relaxed/simple;
	bh=jTkuq+opRJ8JdWnn0p+R4+vuxQ1w+E8Ucex1LO69KGM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LkHVyyHHQec7MAMcvJ4O4ovPigcSDsKdpUUhokF09s6AGC7raDo6QCcGxFHXe3HIwb6BD0lnHNA+hPVjb8vRAxbIvT/GQU8uu3nfVfpfd5AXl+W/3VzqgQa6647+TL/L47yc7bBRnVSSHkEpmJQ6qjvAH+wYBNYvkgCa0YOBDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFi4eQZt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772040956; x=1803576956;
  h=date:from:to:cc:subject:message-id;
  bh=jTkuq+opRJ8JdWnn0p+R4+vuxQ1w+E8Ucex1LO69KGM=;
  b=cFi4eQZtSkFJsQzdcX7zw2dXefN2RkTDdcJCGLxesLl85mz7X2VWKFrV
   61uaVPMzku9/DPAuH2aYCnvz3l49+yGH2oj0zZZCqEVMud7M/wT5PwAUf
   QIDutrGyLIl1QzXZnd35FMdhjomJ3qzNhBwWPy60YHckMCuv/K5OevTrB
   ADpm//DpYZUHbVSgtwxsFVtbuVSqm6wsTr1iSOpbp5EP+fw3KhXTijDt3
   0NE2hGfWh7a6tJdiD4GFWclsJztZqOfWRfxP8YawKHWndEmy3BlGdc/DD
   FHqwgD1Mbn3VR6E4UWS2C0yiYn2pxwOa0/n9leGwq2kJFFatG3ccKhr10
   w==;
X-CSE-ConnectionGUID: ysHo3fp6T/GUdJUNr6kllQ==
X-CSE-MsgGUID: mLlsoUi4T8eaUXcd0ukCsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84182785"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="84182785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:35:56 -0800
X-CSE-ConnectionGUID: lRQqfHoJS7CPFodJMr/hYw==
X-CSE-MsgGUID: BNOSVnv5Qh2FXNuzzhu5VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="214576039"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2026 09:35:53 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvInf-000000006ok-2aJt;
	Wed, 25 Feb 2026 17:35:51 +0000
Date: Thu, 26 Feb 2026 01:35:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 76/102]
 drivers/platform/chrome/chromeos_tbmc.c:49:27: error: expected ';' at end of
 declaration
Message-ID: <202602260154.XIWu0fTw-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21158-lists,linux-acpi=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B499D19B9FD
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   afb26ba421df11fad71fc4be9b874a901efb0388
commit: 37ca8e5f81981188405d5722825b58173c275fb5 [76/102] platform/chrome: chromeos_tbmc: Convert to a platform driver
config: x86_64-randconfig-072-20260225 (https://download.01.org/0day-ci/archive/20260226/202602260154.XIWu0fTw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260154.XIWu0fTw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260154.XIWu0fTw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/chromeos_tbmc.c:49:27: error: expected ';' at end of declaration
      49 |         struct device *dev = data
         |                                  ^
         |                                  ;
   1 error generated.


vim +49 drivers/platform/chrome/chromeos_tbmc.c

    46	
    47	static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
    48	{
  > 49		struct device *dev = data
    50		struct acpi_device *adev = ACPI_COMPANION(dev);
    51	
    52		acpi_pm_wakeup_event(&adev->dev);
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

