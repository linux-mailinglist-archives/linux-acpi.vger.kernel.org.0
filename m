Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5105C26243C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 02:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIAyJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 20:54:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgIIAyG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Sep 2020 20:54:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 812B345815EFE1327BCC;
        Wed,  9 Sep 2020 08:54:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 08:54:01 +0800
Subject: Re: [PATCH 5/5] ACPI / APD: Head file including cleanups
To:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>
References: <1599468981-17301-6-git-send-email-guohanjun@huawei.com>
 <202009072027.mQVQ8Jey%lkp@intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <68c45cf3-6d61-3a82-3c24-77ab86283049@huawei.com>
Date:   Wed, 9 Sep 2020 08:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202009072027.mQVQ8Jey%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/9/7 21:07, kernel test robot wrote:
> Hi Hanjun,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on v5.9-rc4 next-20200903]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Hanjun-Guo/Cleanups-for-ACPI-APD-driver/20200907-170548
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-randconfig-r021-20200907 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project ab68517e6b7e51b84c4b0e813a30258ec1ce5da5)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/acpi/acpi_apd.c:250:13: warning: no previous prototype for function 'acpi_apd_init' [-Wmissing-prototypes]
>     void __init acpi_apd_init(void)
>                 ^
>     drivers/acpi/acpi_apd.c:250:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     void __init acpi_apd_init(void)
>     ^
>     static
>     1 warning generated.

I think this was fixed in v2.

Thanks for the report!

Hanjun

