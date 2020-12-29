Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016992E71E1
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgL2Pkk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Dec 2020 10:40:40 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:53329 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgL2Pkk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Dec 2020 10:40:40 -0500
Received: from [100.112.5.40] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id BA/F1-29370-7EC4BEF5; Tue, 29 Dec 2020 15:36:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRWlGSWpSXmKPExsWSLveKXfe5z+t
  4g18reSwevJnNZrFz2nUmizfHpzNZnO2+xmixfF8/o8Xn3iOMFq+aH7FZzP0yldnizOlLrA6c
  HhO/r2L32DPxJJvH4j0vmTw2repk8+ie/Y/F4/2+q2weW662s3h83iQXwBHFmpmXlF+RwJqxa
  +YUpoJd4hUN22ezNjDOEO5i5OIQEvjPKHFz3Xc2COcZo8THOf/AHGGBNYwS63vvsHQxcnKICG
  hLLFl0lRkkwSxwnUli6aUTrBAtdxklpi5pYgepYgOq2rLlFxuIzStgK/Fv7nygIg4OFgFVieO
  z5EDCogLhEuuXrGSEKBGUODnzCdgCToFAibbGzcwg5cwCmhLrd+mDhJkFxCVuPZnPBGHLS2x/
  O4cZxJYQkJP4vuIhO4SdILHs5R3mCYyCs5BMnYUwaRaSSbOQTFrAyLKK0SypKDM9oyQ3MTNH1
  9DAQNfQ0EjXTNfQwlgvsUo3Wa+0WDc1sbhE11AvsbxYr7gyNzknRS8vtWQTIzACUwrYtu9g3P
  v6g94hRkkOJiVRXmOv1/FCfEn5KZUZicUZ8UWlOanFhxhlODiUJHibQHKCRanpqRVpmTnAZAC
  TluDgURLhlQdJ8xYXJOYWZ6ZDpE4xZnJcvj5vETPHu5+LgeSbtUuA5FswefM9iGy7dxdItoPJ
  mQsOrmbmmAUm77cfApIPQKQQS15+XqqUOK+oN9ACAZAFGaV5cOthCfESo6yUMC8jAwODEE9Ba
  lFuZgmq/CtGcQ5GJWFeN5ApPJl5JXBXvgJ6gAnogYDy5yAPlCQipKQamHSNZqSKbLrqaOxnpJ
  q/VjnLJaAr7eGVy+mzOQ6+lEn8e15qv7jFNJOt30OXfvoXuKvZqUyeqcLpc30RM+vK3toFfNI
  RBsads/9MvrlqzcRo70OvpfMz2IXkF1fVy+sdTdrE+3LZoTQHlUiPdd3mNxpCL9wrXnx99YL7
  GWU7eDJ4uTtrjY3s7ENfLv29XyaQ73u56dxvgYJOnBqiLfIerBWSe2w35LI8uZ7578h1pXvnN
  +yaWvZYLiX0lVSym+xSyzPcMu8W7H1nz9gyeZE+l0qhl3B9oMWzMk2JNIaDhnG/Up688ZVrb5
  SKWrlVoH9XTfPRR+enbM76539Lq+nr7yDJ7gu6JyMbnh06MadSiaU4I9FQi7moOBEA95M7bwM
  EAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-8.tower-416.messagelabs.com!1609256165!631355!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1302 invoked from network); 29 Dec 2020 15:36:06 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-8.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Dec 2020 15:36:06 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id CB687752948C4D78ECDE;
        Tue, 29 Dec 2020 23:36:02 +0800 (CST)
Received: from localhost.localdomain (10.38.50.3) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 29 Dec
 2020 07:36:00 -0800
Subject: Re: [External] Re: [pm:bleeding-edge 8612/8615]
 drivers/acpi/platform_profile.c:147:24: warning: address of array
 'pprof->choices' will always evaluate to 'true'
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <clang-built-linux@googlegroups.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202012271352.JvNDF17O-lkp@intel.com>
 <34a43212-ff2b-cbc6-a670-975d39ac9f12@redhat.com>
 <16284400-7c71-ee40-b694-614d6daf21f5@lenovo.com>
 <CAJZ5v0je=BeU98tkXmE9Mu1aiqc4=o288S=uOuFwh=okWJC2eQ@mail.gmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <22e7ec14-faab-bddd-fff2-303ab3bff01e@lenovo.com>
Date:   Tue, 29 Dec 2020 10:35:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0je=BeU98tkXmE9Mu1aiqc4=o288S=uOuFwh=okWJC2eQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.50.3]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael

On 29/12/2020 10:23, Rafael J. Wysocki wrote:
> On Tue, Dec 29, 2020 at 12:18 AM Mark Pearson <markpearson@lenovo.com> wrote:
>>
>> Hi Hans
>>
>> On 27/12/2020 06:56, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12/27/20 6:11 AM, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>>>> head:   a33520709645543f108361fe21fa9434a351c4e9
>>>> commit: 8c9b909fb1282e43792433e6c1cba125ccfc6201 [8612/8615] ACPI: platform-profile: Add platform profile support
>>>> config: x86_64-randconfig-a015-20201221 (attached as .config)
>>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # install x86_64 cross compiling tool for clang build
>>>>         # apt-get install binutils-x86-64-linux-gnu
>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8c9b909fb1282e43792433e6c1cba125ccfc6201
>>>>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>>>>         git fetch --no-tags pm bleeding-edge
>>>>         git checkout 8c9b909fb1282e43792433e6c1cba125ccfc6201
>>>>         # save the attached .config to linux build tree
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
>>>>            if (!pprof || !pprof->choices || !pprof->profile_set ||
>>>>                          ~~~~~~~~^~~~~~~
>>>>    1 warning generated.
>>>
>>>
>>> Ah, this is caused by changing choices from a single long to:
>>>
>>>       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>
>>> So that we can use for_each_set_bit and are future proof for more then
>>> 32 profiles.
>>>
>>> To fix this the check should be changed into this (untested):
>>>
>>> #include <linux/bitmap.h>
>>>
>>>       if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>>           !pprof->profile_set || !pprof->profile_get) {
>>>               mutex_unlock(&profile_lock);
>>>               return -EINVAL;
>>>       }
>>>
>>> Mark can you provide a (tested) patch for this?
>>>
>>> Regards,
>>>
>>> Hans
>>>
>> Will do!
> 
> Please note that I'm not going to push the material to Linus with this
> warning, so if you want it to go into 5.11, that needs to be addressed
> timely.
> 
> Thanks!
> 
Understood :) I tested this last night and it looks good. Do I push this
as a v8 patch on the current series or as a new standalone patch?

Mark
