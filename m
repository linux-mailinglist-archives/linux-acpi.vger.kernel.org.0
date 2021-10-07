Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72804251F4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhJGL2b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 07:28:31 -0400
Received: from foss.arm.com ([217.140.110.172]:47106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhJGL2b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Oct 2021 07:28:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703246D;
        Thu,  7 Oct 2021 04:26:37 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895713F66F;
        Thu,  7 Oct 2021 04:26:36 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:26:15 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [rafael-pm:bleeding-edge 47/54]
 drivers/cpufreq/mediatek-cpufreq-hw.c:112:17: error: too few arguments to
 function 'cpufreq_table_find_index_dl'
Message-ID: <20211007112614.GA101488@e120877-lin.cambridge.arm.com>
References: <202110071853.ds7uW9eM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110071853.ds7uW9eM-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On Thu, Oct 07, 2021 at 06:35:55PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   6cb3f7cfca6963de4f486c4bd99fdefa56f75870
> commit: 1f39fa0dccff71d4788089b5e617229b19166867 [47/54] cpufreq: Introducing CPUFREQ_RELATION_E
> config: arm-buildonly-randconfig-r001-20211007 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1f39fa0dccff71d4788089b5e617229b19166867
>         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags rafael-pm bleeding-edge
>         git checkout 1f39fa0dccff71d4788089b5e617229b19166867
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpufreq/mediatek-cpufreq-hw.c: In function 'mtk_cpufreq_hw_fast_switch':
> >> drivers/cpufreq/mediatek-cpufreq-hw.c:112:17: error: too few arguments to function 'cpufreq_table_find_index_dl'
>      112 |         index = cpufreq_table_find_index_dl(policy, target_freq);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/cpufreq/mediatek-cpufreq-hw.c:7:
>    include/linux/cpufreq.h:814:19: note: declared here
>      814 | static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>

Rafael,

The issue is this patch

  cpufreq: Introducing CPUFREQ_RELATION_E

How would you like to proceed? Do you want a v8 patch-set with the fix or just
that patch updated?

[...]
