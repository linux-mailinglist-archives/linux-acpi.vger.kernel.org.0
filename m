Return-Path: <linux-acpi+bounces-20913-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZRCyLAhmimnpJwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20913-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 23:56:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988011546B
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 23:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 767E23005D2F
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B33318146;
	Mon,  9 Feb 2026 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXGk/btW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752C314B8C;
	Mon,  9 Feb 2026 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677765; cv=none; b=bUPglIHmomxcDqMTidD/hLiSEmjKANKFoRNFfGqim0DgkPyX6oi46uLqa62fX2roT0/u7PKvSaxOVryyXFV3uUCcAhlCXMIIu1U417oGrb+H3FJBJgrls/1yVjBkdfagWy6tLR8SOYUXG9H1VRftHntWLpM+7+RCgBdkeXKyID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677765; c=relaxed/simple;
	bh=pxllvA1oRU/sAfBMNnSHEOxJ1U5ceEUXW1v/N8Yl2nM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p9ZcL9189IXxgl9g/koM4J3ganQUHoHd4cLmVT6mlJv+/iJ6GvSlI5um1r2juIy1ba/SiF9Thn7qf5YGoBBKumSqL61g9iclaTszmAR33g9rtiHb1I1oWAjeSuqg6KYg9yQ8VSdG0MkGFEu1tPhj9BqM9cRyNL54ttikZyqMyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXGk/btW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770677764; x=1802213764;
  h=date:from:to:cc:subject:message-id;
  bh=pxllvA1oRU/sAfBMNnSHEOxJ1U5ceEUXW1v/N8Yl2nM=;
  b=QXGk/btWWkfX9/3kJiYWBo23dHmPVjey4t1Wu1ekMVb5GxGzXuOl6Wv+
   H1IN/zAVSUgc+LNkEz+yKwwE4H/wBquf2/Kr4lYpNzJNf/JuDUXC1n2Wx
   9e29AEwPoODEy37K1XzhVAyON9pshmH8Lp4BYBBjiQvLy7BO0ZogANuc5
   szY7THzeHRI9hgpzWP8UYi1ibh1owQassS2+lkFRyMhi+jDCbdgsa8ExU
   DkMVxqO+2ybct/Iaa9+5AJ31DII0nbwKhy85niNrteC5FFF5mA/l67asQ
   h3zAF22tTZmR6LSEg7gT2Xqfvkcmo20dyreotUdB3HdufNSdSU7GDzr6l
   w==;
X-CSE-ConnectionGUID: ubBkWAljTp2lljoQXsbJjQ==
X-CSE-MsgGUID: Ed7f0y3gQtaO+97lym/a1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71700447"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71700447"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 14:56:04 -0800
X-CSE-ConnectionGUID: KD/ORIirRvSGt272852uFQ==
X-CSE-MsgGUID: GGBLUy3FSfaQyY1adeMPCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211545461"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Feb 2026 14:56:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpaAh-00000000oOE-2GJp;
	Mon, 09 Feb 2026 22:55:59 +0000
Date: Tue, 10 Feb 2026 06:55:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 321/334]
 drivers/platform/chrome/wilco_ec/event.c:514:33: error: unknown type name
 'platform_device'; did you mean 'to_platform_device'?
Message-ID: <202602100645.LWcwIOMw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20913-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1988011546B
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   8711f3ee7e5efcf1b795c80496b0fb68713e153a
commit: 905eafcac9da580ca476fc3e1c246ca143ae51ed [321/334] platform/chrome: wilco_ec: event: Convert to a platform driver
config: i386-randconfig-005-20260210 (https://download.01.org/0day-ci/archive/20260210/202602100645.LWcwIOMw-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602100645.LWcwIOMw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602100645.LWcwIOMw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/wilco_ec/event.c:514:33: error: unknown type name 'platform_device'; did you mean 'to_platform_device'?
     514 | static void event_device_remove(platform_device *pdev)
         |                                 ^~~~~~~~~~~~~~~
         |                                 to_platform_device
>> drivers/platform/chrome/wilco_ec/event.c:533:19: error: 'event_device_remove' undeclared here (not in a function); did you mean 'event_device_probe'?
     533 |         .remove = event_device_remove,
         |                   ^~~~~~~~~~~~~~~~~~~
         |                   event_device_probe


vim +514 drivers/platform/chrome/wilco_ec/event.c

   513	
 > 514	static void event_device_remove(platform_device *pdev)
   515	{
   516		struct event_device_data *dev_data = platform_get_drvdata(pdev);
   517	
   518		acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
   519					       ACPI_DEVICE_NOTIFY, event_device_notify);
   520		cdev_device_del(&dev_data->cdev, &dev_data->dev);
   521		ida_free(&event_ida, MINOR(dev_data->dev.devt));
   522		hangup_device(dev_data);
   523	}
   524	
   525	static const struct acpi_device_id event_acpi_ids[] = {
   526		{ "GOOG000D", 0 },
   527		{ }
   528	};
   529	MODULE_DEVICE_TABLE(acpi, event_acpi_ids);
   530	
   531	static struct platform_driver event_driver = {
   532		.probe = event_device_probe,
 > 533		.remove = event_device_remove,
   534		.driver = {
   535			.name = DRV_NAME,
   536			.acpi_match_table = event_acpi_ids,
   537		},
   538	};
   539	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

