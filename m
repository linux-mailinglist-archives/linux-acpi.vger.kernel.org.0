Return-Path: <linux-acpi+bounces-20478-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI4OOHQOcGlyUwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20478-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 00:23:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEB4DBA7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 00:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF20F969191
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D563EDAC7;
	Tue, 20 Jan 2026 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCJqAM74"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F63EDAAA;
	Tue, 20 Jan 2026 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949826; cv=none; b=OT4lRvzlUHYiM1EbwATgHRbeIbc3aKQMzJvLrTYQBNg/Q9qt/q5R1Wa1eEQuLsdMn6DpSjp/Es9k+PmZL5IxDX/DSoOFCN+irRrj7OE1cSeVGVpTXPKggkvv1fGp3nhet7wMPt5NLkm9u25ecw1yiLd2hrN6klzWCnyr10ufBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949826; c=relaxed/simple;
	bh=+vB/UKL4hvM1dJklctysFJNxYiVUAnlRUuXKbcvOq0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UohVWk2YfCjepQQBMa7ocIHpoqSM3vdwlcsyJhS4+WDsDOfU0KA1cMGAKfVh9a/2rn6x1hqP8W/oWYpO1bhsrW30prPWn2JGaf/PhvQ1bhYinC9Kx2mnHrHKh3ViQfUrJxgBes1YfepmX2BMg6w4+OWw3mYiHBrle7VHPEQBYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCJqAM74; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949824; x=1800485824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vB/UKL4hvM1dJklctysFJNxYiVUAnlRUuXKbcvOq0U=;
  b=nCJqAM74uOIpuexlInNp7h/bIXkXY0WxRDgiKGcm/AnU6ETxuZRq2NmK
   PMvUQyGoDBAw1qwAK9BJHVCvUT3tPa4L10WjhOQsMKV75ucv1zE8+z1KY
   ZOEygJt9ftEtHuV9IRhxs11+m7Sd1w62tQ5Tk/B6+76tChxaz9mQ78lCJ
   1F5rMnu7I42jW0VHG/Z6MGGbjj3Gk8Y9UCjmgq3ch66aBqXKvtoVAhyQ9
   a20kUQhh5Fvadi4OKu2hHZccZKiTPMRNTdPCj1SGvWqgmqzLPm5AvBbt5
   OUugfKe2ng2c9CeKwE9ZvzhYli92JYq6H5NOaTKS5T1nYjRnf5E3TFkbU
   g==;
X-CSE-ConnectionGUID: PIRei7jUS6OrnH5pHd8aEQ==
X-CSE-MsgGUID: M+UJk2DhQx2PerzsQpuXrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70076711"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70076711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:57:04 -0800
X-CSE-ConnectionGUID: lzJkL1L8SYe4gaucgxrCoQ==
X-CSE-MsgGUID: 4J3VcC5+RFqzUhtRC9UElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206307383"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jan 2026 14:57:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viKeg-00000000Pef-2pPp;
	Tue, 20 Jan 2026 22:56:58 +0000
Date: Wed, 21 Jan 2026 06:56:19 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: video: simplify code with
 acpi_get_local_u64_address()
Message-ID: <202601210634.oa0j58TO-lkp@intel.com>
References: <20260120154008.1763983-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120154008.1763983-1-andriy.shevchenko@linux.intel.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20478-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: B4CEB4DBA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.19-rc6 next-20260120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-video-simplify-code-with-acpi_get_local_u64_address/20260121-015338
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260120154008.1763983-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] ACPI: video: simplify code with acpi_get_local_u64_address()
config: i386-defconfig (https://download.01.org/0day-ci/archive/20260121/202601210634.oa0j58TO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210634.oa0j58TO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210634.oa0j58TO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpi_video.c:1137:14: warning: unused variable 'status' [-Wunused-variable]
    1137 |         acpi_status status;
         |                     ^~~~~~
   1 warning generated.


vim +/status +1137 drivers/acpi/acpi_video.c

e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1131  
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1132  static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1133  {
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1134  	struct acpi_video_bus *video = arg;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1135  	struct acpi_video_device_attrib *attribute;
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1136  	struct acpi_video_device *data;
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13 @1137  	acpi_status status;
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1138  	int device_type;
6a9c39632cf1cd drivers/acpi/acpi_video.c Andy Shevchenko             2026-01-20  1139  	u64 device_id;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1140  
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1141  	/* Skip devices without _ADR instead of failing. */
6a9c39632cf1cd drivers/acpi/acpi_video.c Andy Shevchenko             2026-01-20  1142  	if (acpi_get_local_u64_address(device->handle, &device_id))
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1143  		goto exit;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1144  
36bcbec7ce21e2 drivers/acpi/video.c      Burman Yan                  2006-12-19  1145  	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1146  	if (!data) {
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1147  		dev_dbg(&device->dev, "Cannot attach\n");
d550d98d331737 drivers/acpi/video.c      Patrick Mochel              2006-06-27  1148  		return -ENOMEM;
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1149  	}
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1150  
cfc38d432dba56 drivers/acpi/acpi_video.c Muhammad Qasim Abdul Majeed 2024-07-03  1151  	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
cfc38d432dba56 drivers/acpi/acpi_video.c Muhammad Qasim Abdul Majeed 2024-07-03  1152  	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1153  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1154  	data->device_id = device_id;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1155  	data->video = video;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1156  	data->dev = device;
8ab58e8e7e097b drivers/acpi/video.c      Linus Torvalds              2014-07-18  1157  	INIT_DELAYED_WORK(&data->switch_brightness_work,
8ab58e8e7e097b drivers/acpi/video.c      Linus Torvalds              2014-07-18  1158  			  acpi_video_switch_brightness);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1159  
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1160  	attribute = acpi_video_get_device_attr(video, device_id);
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1161  
e50b9be14ab0ed drivers/acpi/acpi_video.c Aaron Lu                    2015-10-28  1162  	if (attribute && (attribute->device_id_scheme || device_id_scheme)) {
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1163  		switch (attribute->display_type) {
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1164  		case ACPI_VIDEO_DISPLAY_CRT:
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1165  			data->flags.crt = 1;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1166  			break;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1167  		case ACPI_VIDEO_DISPLAY_TV:
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1168  			data->flags.tvout = 1;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1169  			break;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1170  		case ACPI_VIDEO_DISPLAY_DVI:
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1171  			data->flags.dvi = 1;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1172  			break;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1173  		case ACPI_VIDEO_DISPLAY_LCD:
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1174  			data->flags.lcd = 1;
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1175  			break;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1176  		default:
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1177  			data->flags.unknown = 1;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1178  			break;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1179  		}
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1180  		if (attribute->bios_can_detect)
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1181  			data->flags.bios = 1;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1182  	} else {
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1183  		/* Check for legacy IDs */
91e13aa3702343 drivers/acpi/video.c      Aaron Lu                    2013-04-25  1184  		device_type = acpi_video_get_device_type(video, device_id);
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1185  		/* Ignore bits 16 and 18-20 */
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1186  		switch (device_type & 0xffe2ffff) {
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1187  		case ACPI_VIDEO_DISPLAY_LEGACY_MONITOR:
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1188  			data->flags.crt = 1;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1189  			break;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1190  		case ACPI_VIDEO_DISPLAY_LEGACY_PANEL:
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1191  			data->flags.lcd = 1;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1192  			break;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1193  		case ACPI_VIDEO_DISPLAY_LEGACY_TV:
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1194  			data->flags.tvout = 1;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1195  			break;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1196  		default:
82cae99980c158 drivers/acpi/video.c      Rui Zhang                   2007-01-03  1197  			data->flags.unknown = 1;
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1198  		}
e92a7162402589 drivers/acpi/video.c      Matthew Garrett             2010-01-12  1199  	}
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1200  
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1201  	acpi_video_device_bind(video, data);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1202  	acpi_video_device_find_cap(data);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1203  
3a0cf7ab8df387 drivers/acpi/acpi_video.c Hans de Goede               2022-06-24  1204  	if (data->cap._BCM && data->cap._BCL)
5ad26161a371e4 drivers/acpi/acpi_video.c Hans de Goede               2022-07-13  1205  		may_report_brightness_keys = true;
3a0cf7ab8df387 drivers/acpi/acpi_video.c Hans de Goede               2022-06-24  1206  
bbac81f5487175 drivers/acpi/video.c      Dmitry Torokhov             2007-11-05  1207  	mutex_lock(&video->device_list_lock);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1208  	list_add_tail(&data->entry, &video->video_device_list);
bbac81f5487175 drivers/acpi/video.c      Dmitry Torokhov             2007-11-05  1209  	mutex_unlock(&video->device_list_lock);
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1210  
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1211  exit:
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1212  	video->child_count++;
0ea3ef240c4911 drivers/acpi/acpi_video.c Rafael J. Wysocki           2022-06-13  1213  	return 0;
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1214  }
^1da177e4c3f41 drivers/acpi/video.c      Linus Torvalds              2005-04-16  1215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

