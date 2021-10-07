Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660274255EA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhJGPBI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 11:01:08 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:37508 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242248AbhJGPBH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 11:01:07 -0400
Received: by mail-oo1-f42.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso1992223oom.4;
        Thu, 07 Oct 2021 07:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFzZAHEX14XZWOHRwUjcD+VXQmrhGTSWpGdCFR4cayg=;
        b=QrmkaZSYVghGS6ZAlbx8+BAy6OVOYfb2Yt8g8d1s588ZwQ0QWfEpPFm68wlWtjVDAl
         lPgooLkhck2mlKvkQVnoSkmiDbs9NeNkFTrKKbxm4KawAYVavZaJ8kztMilljZDmyr+H
         QtbGHTVmKootdbHRKcOkNL4f+zPWWMP3/sdHHgfcWawPD9m0zOEanixSMFkgg/C+3Pxm
         s5THIXEMmeQrjqpTDGSFv6qQRw9aE/Q17vjUyIuggi6I3w0tGsjbl1eRLYJu6pGcNdsh
         /H5c2vf4Ii0dryaxVNVoBamjgBU8ecviGRYqoRj13dOQcgr4vM9je+5hh77Rwq6J84XN
         YKyg==
X-Gm-Message-State: AOAM532jcOvqBYGliELazNyQmOvcuqoef0Xk8Yhmi3Ag3LJwqzbxmJKN
        6VjHzzpDSu3CiWr6Cln5MrBVMeamTItOsbAaWPuh8QoA
X-Google-Smtp-Source: ABdhPJxav79DTvnZ7ENluLEbTka+prn3Eb5bllevPggdVkuTqKx5NoI4AvrvMdyve/m7L2mOSjSJknElLAHfslePx2o=
X-Received: by 2002:a4a:d9c6:: with SMTP id l6mr3720998oou.0.1633618753616;
 Thu, 07 Oct 2021 07:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <202110071853.ds7uW9eM-lkp@intel.com> <20211007112614.GA101488@e120877-lin.cambridge.arm.com>
In-Reply-To: <20211007112614.GA101488@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 16:59:02 +0200
Message-ID: <CAJZ5v0h3HZBDyv-jH7m86kzXk+aG9PvpO1RT1rRfvt2VmurcXg@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 47/54] drivers/cpufreq/mediatek-cpufreq-hw.c:112:17:
 error: too few arguments to function 'cpufreq_table_find_index_dl'
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 7, 2021 at 1:26 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
>
> On Thu, Oct 07, 2021 at 06:35:55PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> > head:   6cb3f7cfca6963de4f486c4bd99fdefa56f75870
> > commit: 1f39fa0dccff71d4788089b5e617229b19166867 [47/54] cpufreq: Introducing CPUFREQ_RELATION_E
> > config: arm-buildonly-randconfig-r001-20211007 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1f39fa0dccff71d4788089b5e617229b19166867
> >         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >         git fetch --no-tags rafael-pm bleeding-edge
> >         git checkout 1f39fa0dccff71d4788089b5e617229b19166867
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/cpufreq/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/cpufreq/mediatek-cpufreq-hw.c: In function 'mtk_cpufreq_hw_fast_switch':
> > >> drivers/cpufreq/mediatek-cpufreq-hw.c:112:17: error: too few arguments to function 'cpufreq_table_find_index_dl'
> >      112 |         index = cpufreq_table_find_index_dl(policy, target_freq);
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/cpufreq/mediatek-cpufreq-hw.c:7:
> >    include/linux/cpufreq.h:814:19: note: declared here
> >      814 | static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
> >          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> Rafael,
>
> The issue is this patch
>
>   cpufreq: Introducing CPUFREQ_RELATION_E
>
> How would you like to proceed? Do you want a v8 patch-set with the fix or just
> that patch updated?

Please send an incremental fix on top of the series.
