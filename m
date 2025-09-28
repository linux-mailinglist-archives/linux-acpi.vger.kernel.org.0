Return-Path: <linux-acpi+bounces-17378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72760BA6DF9
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377A61893506
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0682D5927;
	Sun, 28 Sep 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKLvtXkB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB02D9ED5;
	Sun, 28 Sep 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052406; cv=none; b=dWeEEcwBkjasl3Lj7yRwgFEtfbTlfvCrQXcqRfrgG+Zbms94SfhAzLme4DuuqIoM4kTC4WjntUU2+cEoPMjI87iRnANfTiLzU41h9byhK991MTPwyFtyWChysSXKj4StTLnZS21JoJ/HHW5zAvnazy/pXnWD6Hi0VWxPSt4PmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052406; c=relaxed/simple;
	bh=B9r5gvsQl0PZnU9EjoIiATzXx4uh+4J6dxXjBZ2Pt9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bgB4KyL6gyzW92x6mIDuhGD6yxOoMjMQbXG1wqIMbyQpqYC7t82hz7lDvE+R62wFpPX8owd7CExVgqGKtBNwKAynPR2BeZcYy2/STKnX1Aj/V7ReH7X2Q4WVq3JosJpvSVY/H2+fKICYAtq6to49ync+dC6NWFcjCUGMEkSSaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKLvtXkB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759052405; x=1790588405;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9r5gvsQl0PZnU9EjoIiATzXx4uh+4J6dxXjBZ2Pt9Q=;
  b=DKLvtXkBR37cFYXuEe2buiHBATxqw3gkhnsTP5SmXRNtimGMsOtq9Wl0
   +IEDcuAYLKcVVM4+F8PrQqcnRA9ARYTrXXwRfHGqKk9CiQGLJXcgL39+V
   LVGNl5qquV7TaIdGmvOcxION45WR+Zm7FhIr3FUAjtDbqW6k5UykKWAjz
   cOn0TQ3xx2uedGSeJMSXFzIvGEjBVEu8P5G26vVDAhNSutRG7rLkOXpHO
   DiJtXzwlXZDxUZjgXVFR9A4jjzkTa/NXJ12jaNhve25+PFb9+sZbQrWcY
   rDxr0Qt4dsB5X/Pumy3En3HHGAeyLTKeYJAAY2vkJr9w9NPdGPSnMi9yi
   w==;
X-CSE-ConnectionGUID: G01YSDi7S9CLwNAhw5iiHA==
X-CSE-MsgGUID: RLGhTGvWR4KQjw/ugGjNxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="64955152"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="64955152"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 02:40:01 -0700
X-CSE-ConnectionGUID: ZKD/9LMzS2alx4NOWML7VQ==
X-CSE-MsgGUID: yDVKJSA9QqyobiyjuVk+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="178380199"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2025 02:39:58 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2nsq-0007i1-25;
	Sun, 28 Sep 2025 09:39:56 +0000
Date: Sun, 28 Sep 2025 17:39:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 209/212] drivers/acpi/battery.c:1267:2:
 error: expected expression
Message-ID: <202509281730.ovd46eNe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   95b83771c9f38207ff42311ccc4739db76d19f33
commit: ef688d5100e8f263ae94a2c86260e7231d600c84 [209/212] ACPI: battery: Add synchronization between interface updates
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250928/202509281730.ovd46eNe-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250928/202509281730.ovd46eNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509281730.ovd46eNe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/battery.c:1267:2: error: expected expression
           guard(mutex)(&battery->update_lock);
           ^
   include/linux/cleanup.h:401:2: note: expanded from macro 'guard'
           CLASS(_name, __UNIQUE_ID(guard))
           ^
   include/linux/cleanup.h:290:2: note: expanded from macro 'CLASS'
           class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
           ^
   <scratch space>:99:1: note: expanded from here
   class_mutex_t
   ^
   1 error generated.


vim +1267 drivers/acpi/battery.c

  1212	
  1213	static int acpi_battery_add(struct acpi_device *device)
  1214	{
  1215		int result = 0;
  1216		struct acpi_battery *battery;
  1217	
  1218		if (!device)
  1219			return -EINVAL;
  1220	
  1221		if (device->dep_unmet)
  1222			return -EPROBE_DEFER;
  1223	
  1224		battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
  1225		if (!battery)
  1226			return -ENOMEM;
  1227		battery->device = device;
  1228		strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
  1229		strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
  1230		device->driver_data = battery;
  1231		result = devm_mutex_init(&device->dev, &battery->lock);
  1232		if (result)
  1233			return result;
  1234	
  1235		result = devm_mutex_init(&device->dev, &battery->update_lock);
  1236		if (result)
  1237			return result;
  1238	
  1239		if (acpi_has_method(battery->device->handle, "_BIX"))
  1240			set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
  1241	
  1242		result = acpi_battery_update_retry(battery);
  1243		if (result)
  1244			goto fail;
  1245	
  1246		pr_info("Slot [%s] (battery %s)\n", acpi_device_bid(device),
  1247			device->status.battery_present ? "present" : "absent");
  1248	
  1249		battery->pm_nb.notifier_call = battery_notify;
  1250		result = register_pm_notifier(&battery->pm_nb);
  1251		if (result)
  1252			goto fail;
  1253	
  1254		device_init_wakeup(&device->dev, 1);
  1255	
  1256		result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
  1257							 acpi_battery_notify, device);
  1258		if (result)
  1259			goto fail_pm;
  1260	
  1261		return 0;
  1262	
  1263	fail_pm:
  1264		device_init_wakeup(&device->dev, 0);
  1265		unregister_pm_notifier(&battery->pm_nb);
  1266	fail:
> 1267		guard(mutex)(&battery->update_lock);
  1268	
  1269		sysfs_remove_battery(battery);
  1270	
  1271		return result;
  1272	}
  1273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

