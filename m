Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485422E6C44
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgL1XRq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:17:46 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.5]:50617 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgL1XRo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 18:17:44 -0500
Received: from [100.112.1.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-east-1.aws.symcld.net id DB/07-54546-0566AEF5; Mon, 28 Dec 2020 23:12:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRWlGSWpSXmKPExsWSLveKXdc/7VW
  8wfu9xhYP3sxms9g57TqTxZvj05ksznZfY7RYvq+f0eJz7xFGi1fNj9gszpy+xOrA4THx+yp2
  jz0TT7J5LN7zksmje/Y/Fo/3+66yeWy52s7i8XmTXAB7FGtmXlJ+RQJrxsUl6xgLvklX3G5/y
  tbAuE6si5GLQ0jgP6PE75ONrBDOM0aJTcf2sIM4wgJrGCXW995h6WLk5BAR8JJ42HIaLMEssI
  dRovPWM7CEkECKRMO7B0wgNpuAtsSWLb/YQGxeAVuJe193gtWwCKhK9H6/xw5iiwqES6xfspI
  RokZQ4uTMJ2A1nAJ2Es3T54L1MgsYSBxZNIcVwhaXuPVkPhOELS+x/e0cZhBbQkBO4vuKh+wQ
  doLEspd3mCcwCs5CMnYWklGzkIyahWTUAkaWVYymSUWZ6RkluYmZObqGBga6hoZGusa6piZ6i
  VW6SXqlxbqpicUluoZ6ieXFesWVuck5KXp5qSWbGIHxllLAbLaD8efrD3qHGCU5mJREeZMSX8
  UL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuB9kwSUEyxKTU+tSMvMAcY+TFqCg0dJhLcgFSjNW1y
  QmFucmQ6ROsWYyXH5+rxFzBzvfi4Gkm/WLgGSb8Hkzfcgsu3eXSDZDiZnLji4mpljFpi8334I
  SD4AkUIsefl5qVLivIdTgBYIgCzIKM2DWw9Lf5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqC
  fOmgkzhycwrgbvyFdADTEAPBJQ/B3mgJBEhJdXA5BDAP5t3c4uGuMrJJLHXMs9dph2zX3N/Hv
  sjNy4OhlcnslyXhydNzj6RP9N35pN1tm9ErG4UyeqeimHkcTjO82wW6+cUV57Zqz9Zdpg4y03
  NOqtce+/EomN2zHd8zY6++FIW2bo59W916/IfundedfwPCXf7fFCZh2fhnYnW9W2T2DUNntgt
  47wiY/Wk4EcUk25g0///s6LCpQrn6HpKtzyzdmx9138hZ9f1ZeKvn3N2+AQGuy/9fnfqpec8h
  t+muW3eoWj51Na3wWm1Tp627uU9fyQjJNgUD9sKeHNntfw9GbFpTsSuZPW0G6LLY9M9dVw23W
  V9Vb2xfEvjnDlx/Ba/eFoL/ZIucP+1F7qsxFKckWioxVxUnAgA0ZFYV/oDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-386.messagelabs.com!1609197133!604423!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23068 invoked from network); 28 Dec 2020 23:12:15 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-9.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Dec 2020 23:12:15 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B262F57C6C913E92313F;
        Tue, 29 Dec 2020 07:12:11 +0800 (CST)
Received: from localhost.localdomain (10.38.50.3) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 28 Dec
 2020 15:12:09 -0800
Subject: Re: [External] Re: [pm:bleeding-edge 8612/8615]
 drivers/acpi/platform_profile.c:147:24: warning: address of array
 'pprof->choices' will always evaluate to 'true'
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202012271352.JvNDF17O-lkp@intel.com>
 <34a43212-ff2b-cbc6-a670-975d39ac9f12@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <16284400-7c71-ee40-b694-614d6daf21f5@lenovo.com>
Date:   Mon, 28 Dec 2020 18:12:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <34a43212-ff2b-cbc6-a670-975d39ac9f12@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.50.3]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 27/12/2020 06:56, Hans de Goede wrote:
> Hi,
> 
> On 12/27/20 6:11 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>> head:   a33520709645543f108361fe21fa9434a351c4e9
>> commit: 8c9b909fb1282e43792433e6c1cba125ccfc6201 [8612/8615] ACPI: platform-profile: Add platform profile support
>> config: x86_64-randconfig-a015-20201221 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install x86_64 cross compiling tool for clang build
>>         # apt-get install binutils-x86-64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8c9b909fb1282e43792433e6c1cba125ccfc6201
>>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>>         git fetch --no-tags pm bleeding-edge
>>         git checkout 8c9b909fb1282e43792433e6c1cba125ccfc6201
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
>>            if (!pprof || !pprof->choices || !pprof->profile_set ||
>>                          ~~~~~~~~^~~~~~~
>>    1 warning generated.
> 
> 
> Ah, this is caused by changing choices from a single long to:
> 
> 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> 
> So that we can use for_each_set_bit and are future proof for more then
> 32 profiles.
> 
> To fix this the check should be changed into this (untested):
> 
> #include <linux/bitmap.h>
> 
> 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> 	    !pprof->profile_set || !pprof->profile_get) {
> 		mutex_unlock(&profile_lock);
> 		return -EINVAL;
> 	}
> 
> Mark can you provide a (tested) patch for this?
> 
> Regards,
> 
> Hans
> 
Will do!

Mark

> 
> 
> 
> 
> 
> 
> 
>>
>>
>> vim +147 drivers/acpi/platform_profile.c
>>
>>    134	
>>    135	int platform_profile_register(const struct platform_profile_handler *pprof)
>>    136	{
>>    137		int err;
>>    138	
>>    139		mutex_lock(&profile_lock);
>>    140		/* We can only have one active profile */
>>    141		if (cur_profile) {
>>    142			mutex_unlock(&profile_lock);
>>    143			return -EEXIST;
>>    144		}
>>    145	
>>    146		/* Sanity check the profile handler field are set */
>>  > 147		if (!pprof || !pprof->choices || !pprof->profile_set ||
>>    148				!pprof->profile_get) {
>>    149			mutex_unlock(&profile_lock);
>>    150			return -EINVAL;
>>    151		}
>>    152	
>>    153		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>    154		if (err) {
>>    155			mutex_unlock(&profile_lock);
>>    156			return err;
>>    157		}
>>    158	
>>    159		cur_profile = pprof;
>>    160		mutex_unlock(&profile_lock);
>>    161		return 0;
>>    162	}
>>    163	EXPORT_SYMBOL_GPL(platform_profile_register);
>>    164	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
