Return-Path: <linux-acpi+bounces-1549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF697ED74B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3D91F22E8B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB16446B2
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kR9CZCJl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8AE6;
	Wed, 15 Nov 2023 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700086331; x=1731622331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zx2NhsOFNiuWdJujiQc0qMrvyW6w5wvKsG6uyUIF160=;
  b=kR9CZCJlRpxVcs/O20WfqDK7QY6RWGUbTodqr9QMAayL2uDe8YQUNLp7
   lQtisjBkcvkqnEdC0FMUMFic9aIneAd4zNYc8+4t1+vKkb9N1KH+9CfmL
   tHNOm61n1/4YXwPBYGs0shMs1WOLAfHIm5aRgFgPKYAQ+XFjjElwQ0B4h
   xybEb3Cumb+OARcx1cz5UaTut6vey/TMGf0G3MovUYFbIWOZaHuXQ35aL
   26eIpxrqWZNuMKirUDnvthoveM1hCwOjEhXz5qnFqVJS2jZHq4HKZ47WS
   +x8x2p+xfJaBarhbMctK8mBrxptuavhLYmKMVoxe8WW4+5nr59aM7YTiD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457462919"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="457462919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 14:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="835532799"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="835532799"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2023 14:09:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3O4n-0000tb-0k;
	Wed, 15 Nov 2023 22:09:37 +0000
Date: Thu, 16 Nov 2023 06:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 4/6] media: ov8858: Use pm_runtime_get_if_active(), put
 usage_count correctly
Message-ID: <202311160555.lMNVgFkA-lkp@intel.com>
References: <20231115181840.1509046-5-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115181840.1509046-5-sakari.ailus@linux.intel.com>

Hi Sakari,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3e238417254bfdcc23fe207780b59cbb08656762]

url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/pm-runtime-Simplify-pm_runtime_get_if_active-usage/20231116-022051
base:   3e238417254bfdcc23fe207780b59cbb08656762
patch link:    https://lore.kernel.org/r/20231115181840.1509046-5-sakari.ailus%40linux.intel.com
patch subject: [PATCH 4/6] media: ov8858: Use pm_runtime_get_if_active(), put usage_count correctly
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231116/202311160555.lMNVgFkA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160555.lMNVgFkA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160555.lMNVgFkA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/i2c/ov8858.c: In function 'ov8858_set_ctrl':
>> drivers/media/i2c/ov8858.c:1606:17: error: implicit declaration of function 'pm_runtime_mark_busy_autosusp'; did you mean 'pm_runtime_put_mark_busy_autosusp'? [-Werror=implicit-function-declaration]
    1606 |                 pm_runtime_mark_busy_autosusp(&client->dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 pm_runtime_put_mark_busy_autosusp
   cc1: some warnings being treated as errors


vim +1606 drivers/media/i2c/ov8858.c

  1530	
  1531	static int ov8858_set_ctrl(struct v4l2_ctrl *ctrl)
  1532	{
  1533		struct ov8858 *ov8858 = container_of(ctrl->handler,
  1534						     struct ov8858, ctrl_handler);
  1535	
  1536		struct i2c_client *client = v4l2_get_subdevdata(&ov8858->subdev);
  1537		struct v4l2_mbus_framefmt *format;
  1538		struct v4l2_subdev_state *state;
  1539		u16 digi_gain;
  1540		s64 max_exp;
  1541		int ret, pm_status;
  1542	
  1543		/*
  1544		 * The control handler and the subdev state use the same mutex and the
  1545		 * mutex is guaranteed to be locked:
  1546		 * - by the core when s_ctrl is called int the VIDIOC_S_CTRL call path
  1547		 * - by the driver when s_ctrl is called in the s_stream(1) call path
  1548		 */
  1549		state = v4l2_subdev_get_locked_active_state(&ov8858->subdev);
  1550		format = v4l2_subdev_get_pad_format(&ov8858->subdev, state, 0);
  1551	
  1552		/* Propagate change of current control to all related controls */
  1553		switch (ctrl->id) {
  1554		case V4L2_CID_VBLANK:
  1555			/* Update max exposure while meeting expected vblanking */
  1556			max_exp = format->height + ctrl->val - OV8858_EXPOSURE_MARGIN;
  1557			__v4l2_ctrl_modify_range(ov8858->exposure,
  1558						 ov8858->exposure->minimum, max_exp,
  1559						 ov8858->exposure->step,
  1560						 ov8858->exposure->default_value);
  1561			break;
  1562		}
  1563	
  1564		pm_status = pm_runtime_get_if_active(&client->dev);
  1565		if (!pm_status)
  1566			return 0;
  1567	
  1568		switch (ctrl->id) {
  1569		case V4L2_CID_EXPOSURE:
  1570			/* 4 least significant bits of exposure are fractional part */
  1571			ret = ov8858_write(ov8858, OV8858_REG_LONG_EXPO,
  1572					   ctrl->val << 4, NULL);
  1573			break;
  1574		case V4L2_CID_ANALOGUE_GAIN:
  1575			ret = ov8858_write(ov8858, OV8858_REG_LONG_GAIN,
  1576					   ctrl->val, NULL);
  1577			break;
  1578		case V4L2_CID_DIGITAL_GAIN:
  1579			/*
  1580			 * Digital gain is assembled as:
  1581			 * 0x350a[7:0] = dgain[13:6]
  1582			 * 0x350b[5:0] = dgain[5:0]
  1583			 * Reassemble the control value to write it in one go.
  1584			 */
  1585			digi_gain = (ctrl->val & OV8858_LONG_DIGIGAIN_L_MASK)
  1586				  | ((ctrl->val & OV8858_LONG_DIGIGAIN_H_MASK) <<
  1587				      OV8858_LONG_DIGIGAIN_H_SHIFT);
  1588			ret = ov8858_write(ov8858, OV8858_REG_LONG_DIGIGAIN,
  1589					   digi_gain, NULL);
  1590			break;
  1591		case V4L2_CID_VBLANK:
  1592			ret = ov8858_write(ov8858, OV8858_REG_VTS,
  1593					   ctrl->val + format->height, NULL);
  1594			break;
  1595		case V4L2_CID_TEST_PATTERN:
  1596			ret = ov8858_enable_test_pattern(ov8858, ctrl->val);
  1597			break;
  1598		default:
  1599			ret = -EINVAL;
  1600			dev_warn(&client->dev, "%s Unhandled id: 0x%x\n",
  1601				 __func__, ctrl->id);
  1602			break;
  1603		}
  1604	
  1605		if (pm_status > 0)
> 1606			pm_runtime_mark_busy_autosusp(&client->dev);
  1607	
  1608		return ret;
  1609	}
  1610	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

