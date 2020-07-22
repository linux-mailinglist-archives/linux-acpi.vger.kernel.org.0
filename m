Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D76228D65
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jul 2020 03:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgGVBRg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jul 2020 21:17:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:39854 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgGVBRf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:35 -0400
IronPort-SDR: Sd2o62ZuuapYMxMchrD+xLe8SnQSVWgcGCTvIc3HLeg+0xQ9yA47DWPMbkDJyoYDpQuzl+jgGY
 M2Et2wMZZBjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168399543"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="gz'50?scan'50,208,50";a="168399543"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 18:15:22 -0700
IronPort-SDR: jz+Gx1UaF7hMNR64NMQT8snhUZIqXk5atk0U/y4HrxmF/uIoO7gSzWM8ycvM50kuVurXmSKCC8
 emmYAegO00+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="gz'50?scan'50,208,50";a="488282013"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2020 18:15:19 -0700
Date:   Wed, 22 Jul 2020 09:27:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     kbuild-all@lists.01.org, Pavel Machek <pavel@ucw.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
Message-ID: <20200722012730.GA8345@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 48778464bb7d346b47157d21ffde2af6b2d39110]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/ACPI-NVDIMM-Runtime-Firmware-Activation/20200721-062902
base:    48778464bb7d346b47157d21ffde2af6b2d39110
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago
config: x86_64-randconfig-s021-20200719 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/bluetooth/btusb.c:2245:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2254:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2255:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2256:25: sparse: sparse: cast to restricted __le16
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/cpufreq/cpufreq.c:471:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head @@
   drivers/cpufreq/cpufreq.c:471:17: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:471:17: sparse:     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head
   drivers/cpufreq/cpufreq.c:471:65: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *next @@
   drivers/cpufreq/cpufreq.c:471:65: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:471:65: sparse:     got struct notifier_block [noderef] __rcu *next
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/internal.h:43:42: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:1627:56: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:1629:56: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:455:17: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:455:25: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:469:47: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3347:65: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3823:47: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3965:65: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:5527:54: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:5528:54: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/internal.h:43:42: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/of_regulator.c:18:43: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:193:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:196:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:199:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:202:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:203:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:252:26: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/da9063-regulator.c:514:17: sparse: sparse: Initializer entry defined twice
   drivers/regulator/da9063-regulator.c:515:18: sparse:   also defined here
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/tty/sysrq.c:148:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/base/firmware_loader/main.c:266:9: sparse: sparse: context imbalance in 'free_fw_priv' - wrong count at exit
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   init/do_mounts.c:408:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const [noderef] __user * @@     got char * @@
   init/do_mounts.c:408:30: sparse:     expected char const [noderef] __user *
   init/do_mounts.c:408:30: sparse:     got char *
   init/do_mounts.c:412:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char * @@
   init/do_mounts.c:412:20: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.c:412:20: sparse:     got char *
   init/do_mounts.c:685:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const [noderef] __user * @@     got char * @@
   init/do_mounts.c:685:23: sparse:     expected char const [noderef] __user *
   init/do_mounts.c:685:23: sparse:     got char *
   init/do_mounts.c:686:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char * @@
   init/do_mounts.c:686:21: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.c:686:21: sparse:     got char *
   init/do_mounts.h:19:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *pathname @@     got char *name @@
   init/do_mounts.h:19:21: sparse:     expected char const [noderef] __user *pathname
   init/do_mounts.h:19:21: sparse:     got char *name
   init/do_mounts.h:20:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char *name @@
   init/do_mounts.h:20:27: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.h:20:27: sparse:     got char *name
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/umh.c:74:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/umh.c:74:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/umh.c:74:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/umh.c:76:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/umh.c:76:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/umh.c:76:33: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sys.c:1878:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *[assigned] file @@
   kernel/sys.c:1878:19: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/sys.c:1878:19: sparse:     got struct file *[assigned] file
   kernel/sys.c:1878:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *old_exe @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/sys.c:1878:17: sparse:     expected struct file *old_exe
   kernel/sys.c:1878:17: sparse:     got struct file [noderef] __rcu *[assigned] __ret
   kernel/sys.c:2240:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int [noderef] __user **tid_addr @@
   kernel/sys.c:2240:16: sparse:     expected void const volatile [noderef] __user *
   kernel/sys.c:2240:16: sparse:     got int [noderef] __user **tid_addr
   kernel/sys.c:1049:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1049:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1049:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/core.c:256:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:256:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:256:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:512:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:512:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:512:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1432:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1432:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:1432:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1432:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1432:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:1432:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3650:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3650:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:3650:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4083:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4083:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:4083:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4506:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4506:17: sparse:    struct task_struct *
   kernel/sched/core.c:4506:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:4705:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4705:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:4705:22: sparse:    struct task_struct *
   kernel/sched/core.c:8011:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8011:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:8011:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:256:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1415:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1416:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1419:40: sparse: sparse: dereference of noderef expression
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/cputime.c:316:17: sparse: sparse: context imbalance in 'thread_group_cputime' - different lock contexts for basic block
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/fair.c:881:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:881:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:881:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:5386:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct *
   kernel/sched/fair.c:5401:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:5401:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:5401:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6880:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6880:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:6880:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7131:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7131:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7131:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:10692:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10825:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct *
   kernel/sched/fair.c:5330:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/rt.c:912:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:912:70: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:912:70: sparse:    struct task_struct *
   kernel/sched/rt.c:529:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:529:54: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:529:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:998:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:998:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:998:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1424:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1424:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1424:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2300:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct *
   kernel/sched/rt.c:2320:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/deadline.c:1721:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1721:42: sparse:     expected struct sched_dl_entity *b
   kernel/sched/deadline.c:1721:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1054:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1054:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1054:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1183:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1183:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1183:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2385:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2404:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/debug.c:435:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/debug.c:435:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/debug.c:435:22: sparse:    struct task_struct *
   kernel/sched/debug.c:643:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:643:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:643:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/debug.c:643:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:643:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:643:9: sparse:     got struct task_struct [noderef] __rcu *curr
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/psi.c:1205:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/psi.c:1205:9: sparse:    void [noderef] __rcu *
   kernel/sched/psi.c:1205:9: sparse:    void *
   kernel/sched/psi.c:734:30: sparse: sparse: dereference of noderef expression
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   include/linux/gfp.h:325:27: sparse: sparse: restricted gfp_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/ata/libata-scsi.c:1784:13: sparse: sparse: context imbalance in 'ata_scsi_rbuf_get' - wrong count at exit
   drivers/ata/libata-scsi.c:1814:31: sparse: sparse: context imbalance in 'ata_scsi_rbuf_fill' - unexpected unlock
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/pci/pci-driver.c:494:42: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:494:61: sparse: sparse: restricted pci_power_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/acpi/bus.c:37:20: sparse: sparse: symbol 'acpi_root' was not declared. Should it be static?

# https://github.com/0day-ci/linux/commit/d55d8fef1e62acab40273b953e45a9d58f7e73c9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d55d8fef1e62acab40273b953e45a9d58f7e73c9
vim +470 include/linux/suspend.h

d55d8fef1e62ac Dan Williams  2020-07-20  469  
d55d8fef1e62ac Dan Williams  2020-07-20 @470  static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
d55d8fef1e62ac Dan Williams  2020-07-20  471  	return -ENOTSUPP;
d55d8fef1e62ac Dan Williams  2020-07-20  472  }
fce2b111fae915 Cornelia Huck 2009-06-10  473  #endif /* CONFIG_HIBERNATION */
fce2b111fae915 Cornelia Huck 2009-06-10  474  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
UpJFKz1Dmm1kwsgxWGYqQYDlBGf9OjIXfDM5jBETJX03MwHhfRhvLNRk5gYYHCgCQ29IzooD
YyOJCVaylGpYH5LcdsUrWTKqRBhdSmhIpKFhJy7hKvVYNHmvxF8Zvq8qza8KkuHIBfVjvD8k
aj+obIO/Xvm7qoLlPMn6KjuP53LMkLClwN6TrUWlRCbH4Xi+yi1Kc4LvoWLoQlOYvNKXfaJd
u31/PsAaWtxKDLm2hdgieIcThZhfY+Ny0boilCffml0iDLWPsKpW6eDY/TdPzUrz577Mjtf3
j1WyGMqmusGn6LAwujjO2C9KshccPwdyD0M4G2G1sILa1rWoct91BNp12JscTjbUt5rL5pm+
49QZSy7IfKWkplpfjp7rHBqzrBjI1w0vJrCDzoNvTECElfFcE6jJxqjnkpmVmjHObUOjJiqm
pHG83UO8iF2irDMZGkCbpm3MwhC1OojhgB+gy2tLZmNVtEUWLwjRgr4cLMDnoTncfK6S58f3
d+rEL8Z9Ql0OimWixUWz1Ut4Tm0fdMJZ6RC1FrbK/1yJdujqFu/7v1y/w0r6vnp9WfGE56s/
fnystsUdLjc9T1ffHv+e7Mgfn99fV39cVy/X65frl/+CXK5KSofr8/fV19e31bfXt+vq6eXr
q16niZOarvm3xz+fXv40NaLFyEuTWFY5EzSU10GUU6h5oxmWD7QTNUAXeo/LDv8tJsAKtnkQ
Rl2lIgBanM2PXx5l9+ADbQpOLy8+acV9gtTvWbrPOr2DB8ye8ciABvjnVnVTJtpLDMm0pRQc
xPp/TrTCIEVsdAR59NGv7iAIDGW37zLIk6Jzu7YuzJHQPD9+wBD6tto//5g8oq44JeOIhIwd
cygbazhBrneGjdyIeURNPKOlByuVxy9/Xj/+mf54fP4P2FiuMNi/XFdv1//58fT/lD3LduLI
kvv5Cpbdi57WG1jMQkgC1JZApRSYqg3H16arONcGj43PqZqvn4hMSWSkInHfRXeZiMiH8hkR
GY+3g7qHFUnHlIwuctMcTg//ej48DS5nbAhu5rwCmY7Vo/VU/aCxnbUFqb4WtwQm7AmaGq5r
2FVCZCjozE3WZon+lPrjvQ7dmyv+iqHZHAiKuRh6XCl4lRYhyktevUmIGLUrT9hkC1Zb092W
48g4glogf7dKBCZq4OasI1C7ZbAXWFr7rsFVJ9faIKiFvCeFGHuO2QMUO5k8JlgVZS0t91NW
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

--LQksG6bCIzRHxTLp--
