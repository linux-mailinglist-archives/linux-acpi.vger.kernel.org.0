Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B848B25FA83
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgIGM36 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 08:29:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728948AbgIGM3j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:29:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B5D8BEF9D15FFFD160BB;
        Mon,  7 Sep 2020 20:29:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 20:29:16 +0800
Subject: Re: [PATCH 5/5] ACPI / APD: Head file including cleanups
To:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <kbuild-all@lists.01.org>, <linux-acpi@vger.kernel.org>,
        Ken Xue <Ken.Xue@amd.com>
References: <1599468981-17301-6-git-send-email-guohanjun@huawei.com>
 <202009071956.VISM8Axu%lkp@intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <d4dfac0b-f843-0905-0ef5-8079633cf435@huawei.com>
Date:   Mon, 7 Sep 2020 20:29:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202009071956.VISM8Axu%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/9/7 19:19, kernel test robot wrote:
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
> config: x86_64-randconfig-s022-20200907 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.2-191-g10164920-dirty
>          # save the attached .config to linux build tree
>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/acpi/acpi_apd.c:250:13: warning: no previous prototype for 'acpi_apd_init' [-Wmissing-prototypes]
>       250 | void __init acpi_apd_init(void)
>           |             ^~~~~~~~~~~~~

Hmm, I didn't get this locally, I think it's because acpi_apd_init()
is added in the head file internal.h, but I removed the internal.h 
inclusion for head file, I will add it back.

Thanks
Hanjun

