Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0940D38F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhIPG7v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 02:59:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:20550 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234539AbhIPG7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 02:59:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202658296"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="202658296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 23:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="610513266"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2021 23:58:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Sep 2021 09:58:16 +0300
Date:   Thu, 16 Sep 2021 09:58:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 6/11] drivers/base/swnode.c:1120:17:
 error: too many arguments to function 'software_node_notify'
Message-ID: <YULrCIRyvuryjoGE@kuha.fi.intel.com>
References: <202109160821.skJVoHhq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109160821.skJVoHhq-lkp@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 08:13:24AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   9808623e1bba7d929b50865d7e2d7042cd4e5e7b
> commit: 810fc8571f8b70a4263266d979f97edec2804574 [6/11] software node: balance refcount for managed sw nodes
> config: arc-randconfig-r001-20210916 (attached as .config)
> compiler: arc-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=810fc8571f8b70a4263266d979f97edec2804574
>         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags rafael-pm bleeding-edge
>         git checkout 810fc8571f8b70a4263266d979f97edec2804574
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/swnode.c: In function 'device_create_managed_software_node':
> >> drivers/base/swnode.c:1120:17: error: too many arguments to function 'software_node_notify'
>     1120 |                 software_node_notify(dev, KOBJ_ADD);
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/base/swnode.c:14:
>    drivers/base/base.h:206:6: note: declared here
>      206 | void software_node_notify(struct device *dev);
>          |      ^~~~~~~~~~~~~~~~~~~~

Ah, that was modified in commit 384f5a857bae ("software nodes: Split
software_node_notify()").

So the patch is OK for stable, but for v5.15-rc1 it has to be changed:

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7bd0f3cfb7eb4..c46f6a8e14d23 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1116,6 +1116,9 @@ int device_create_managed_software_node(struct device *dev,
        to_swnode(fwnode)->managed = true;
        set_secondary_fwnode(dev, fwnode);
 
+       if (device_is_registered(dev))
+               software_node_notify(dev);
+
        return 0;
 }
 EXPORT_SYMBOL_GPL(device_create_managed_software_node);


Rafael, how do want to handle this?

-- 
heikki
