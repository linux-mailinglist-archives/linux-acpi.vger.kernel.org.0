Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7554730F6B5
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhBDPr0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 10:47:26 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.112]:61137 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237475AbhBDPqa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 10:46:30 -0500
Received: from [100.112.133.249] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id 43/1D-17150-9851C106; Thu, 04 Feb 2021 15:40:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRWlGSWpSXmKPExsWS8eIhr26HqEy
  CwftnGhZfv91mt3hzfDqTxfJ9/YwWnzsms1is3vOC2eLM6UusDmwev7atYfGYdzLQ4/2+q2we
  W662s3h83iQXwBrFmpmXlF+RwJpxrO04U8EOqYp5l/tYGxhniXUxcnEICfxnlGj8f5MNwnnOK
  PG1cy9TFyMHh7BAosSxlxFdjJwcIgLqElM7esBqmAUWM0pMnnWUHaLhLaPEjqefmEGq2AS0Jb
  Zs+cUGYvMK2Eoc3/OcCcRmEVCReHWtnRHEFhUIl3i96TMjRI2gxMmZT1hAbE4BO4lLT0E2cAB
  t0JRYv0sfJMwsIC5x68l8JghbXmL72znMICUSAgoSm5fzgYQlBBIkev49YpvAKDgLydBZCINm
  IRk0C8mgBYwsqxjNk4oy0zNKchMzc3QNDQx0DQ2NdA2NTXVNTfQSq3ST9EqLdctTi0t0jfQSy
  4v1iitzk3NS9PJSSzYxAiMopaDdbAfjzdcf9A4xSnIwKYnyvnglnSDEl5SfUpmRWJwRX1Sak1
  p8iFGGg0NJgpdHRCZBSLAoNT21Ii0zBxjNMGkJDh4lEd5FgkBp3uKCxNzizHSI1ClGXY7L1+c
  tYhZiycvPS5US590OMkMApCijNA9uBCyxXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzPtS
  GGgKT2ZeCdymV0BHMAEdkbxaCuSIkkSElFQDk3dy+8+N4ZqCrN61RX+ds3elMz2SkFBdVGhuc
  0jRfhfvyhUvYp/+uKFUPVl1UTf3ieW+pa3y00pmlV7epHezWDr8yEeTLW/496W67JObKrPo5Y
  kTBsK7d/LItPu7L2JcejJ7p+NhlvQ32fL8KhOz5+bkTcib2z1v/T0Z5saqC/8LGNdZ5Jd/jpl
  5sHDVv2sWU8r5/f/p+cRqJ/9rDFdadaJgUdjjKh5b19z/woz/vMM8aha18G9kCjv07SLDZaW1
  FYqdQmGPPiU1zpri5XxhHpPjB4nrGsfVvNKuXb2wpy18hs/cbn/WE465t0xiXHcIxQm8Lmazs
  C7JvmO27+X9BxZ7WD3vOpi0qLlYprEpsRRnJBpqMRcVJwIAer5WPqcDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-27.tower-356.messagelabs.com!1612453255!3328!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19943 invoked from network); 4 Feb 2021 15:40:56 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-27.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2021 15:40:56 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 677B173832B7126B3664;
        Thu,  4 Feb 2021 10:40:55 -0500 (EST)
Received: from localhost.localdomain (10.38.61.203) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 10:40:29 -0500
Subject: Re: [External] Re: [PATCH v9] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <mgross@linux.intel.com>, <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <njoshi1@lenovo.com>
References: <markpearson@lenovo.com>
 <20210111162237.3469-1-markpearson@lenovo.com>
 <39c453b5-c6f2-7e45-ee82-64344e800711@redhat.com>
 <ab6d9113-2bc6-3c02-bc08-65a0aa217325@lenovo.com>
 <48752174-26c3-fb83-ddf6-01bf2cafd1ab@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <3c886ad6-9b23-b60b-6422-6bf71627ebcc@lenovo.com>
Date:   Thu, 4 Feb 2021 10:40:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <48752174-26c3-fb83-ddf6-01bf2cafd1ab@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.61.203]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 04/02/2021 04:18, Hans de Goede wrote:
> Hi,
> 
> On 2/3/21 3:46 PM, Mark Pearson wrote:
>> On 02/02/2021 09:49, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 1/11/21 5:22 PM, Mark Pearson wrote:
>>>> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
>>>> version 5 support or newer to use the platform profile feature.
>>>>
>>>> This will allow users to determine and control the platform modes
>>>> between low-power, balanced operation and performance modes.
>>>>
>>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>>
>>> Now that the acpi/platform_profile changes have landed I have
>>> merged this patch (solving a trivial conflict caused by the
>>> keyboard_lang changes).
>>>
>>> Thank you for your patch, I've applied this patch to my review-hans 
>>> branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>>
>>> Note it will show up in my review-hans branch once I've pushed my
>>> local branch there, which might take a while.
>>>
>>> Once I've run some tests on this branch the patches there will be
>>> added to the platform-drivers-x86/for-next branch and eventually
>>> will be included in the pdx86 pull-request to Linus for the next
>>> merge-window.
>>>
>> Thanks Hans - sounds great.
>> Let me know if you find any issues or need any extra tests running.
> 
> So the build-bots have found 2 issues:
> 
> 1. Some symbols which are not exported need to be marked static (I will fix this myself,
> that is the easiest / fastest):
> 
> drivers/platform/x86/thinkpad_acpi.c:10081:5: warning: no previous prototype for 'dytc_profile_get' [-Wmissing-prototypes]
> drivers/platform/x86/thinkpad_acpi.c:10095:5: warning: no previous prototype for 'dytc_cql_command' [-Wmissing-prototypes]
> drivers/platform/x86/thinkpad_acpi.c:10133:5: warning: no previous prototype for 'dytc_profile_set' [-Wmissing-prototypes]
> 
> 2. This is a bigger problem, this is the result of a random-config test-build and I'm
> pretty sure that the issue is that acpi_platform was build as a module while
> thinkpad_acpi was builtin and builtin code cannot rely on modules.
> 
> drivers/platform/x86/thinkpad_acpi.c:10186: undefined reference to `platform_profile_notify'
> drivers/platform/x86/thinkpad_acpi.c:10226: undefined reference to `platform_profile_register'
> drivers/platform/x86/thinkpad_acpi.c:10246: undefined reference to `platform_profile_remove'
> 
> There are 2 ways to solve this:
> 
> 1. Change
> 
> #if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)
> 
> to:
> 
> #if IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)
> 
> Which will disable the platform-profile support in acpi_thinkpad in the above scenario.
> 
> or.
> 
> 2. Drop the #if IS_ENABLED(...) and add a
> 
>         depends on ACPI_PLATFORM_PROFILE
> 
> To the THINKPAD_ACPI Kconfig symbol.
> 
> 
> I personally think 2. would be slightly better as it ensures that platform-profile
> support is always available when thinkpad_acpi is build, hopefully leading to less
> confusing bug-reports about it sometimes not working.
> 
> If you can let me know what you want, then I can fix this locally too and get
> the fix in place before the merge-window opens.
> 
> Regards,
> 
> Hans
> 
I think you've fixed both of those already - and I agree with #2. Thanks
for jumping on these.
Let me know if I need to do anything to help.
Thanks!
Mark
