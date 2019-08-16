Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12CA9096F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfHPU0y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 16:26:54 -0400
Received: from mail.klausen.dk ([174.138.9.187]:52666 "EHLO mail.klausen.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfHPU0x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 16:26:53 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 16:26:52 EDT
From:   Kristian Klausen <kristian@klausen.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klausen.dk; s=dkim;
        t=1565986812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9A+nkXWVA/jF2o9MhtP9GY66Zha2aaG5LtnYmm+FZk=;
        b=HbFInzYxixr8DpRdSujExpk4Qnj2TL+nlNzxCd+8zdl9iLRZTJ07PriEb9iDB1TuBHj2MH
        rQaO2qSQpFOawtgs8823BoyI8+EMnRDTVWJJLzAbLbX8dgb1D+8dtEsC+DZ+AW6G8ctcud
        3p/HPeXTs2blBx9pOcLnlMzF81XWVU0=
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to
 suspend-to-idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <5997740.FPbUVk04hV@kreacher>
Message-ID: <800186a2-e912-3498-f08b-47469bbe8b0d@klausen.dk>
Date:   Fri, 16 Aug 2019 22:20:10 +0200
MIME-Version: 1.0
In-Reply-To: <5997740.FPbUVk04hV@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02.08.2019 12.33, Rafael J. Wysocki wrote:
> Hi All,
>
>>> On top of the "Simplify the suspend-to-idle control flow" patch series
>>> posted previously:
>>>
>>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
>>>
>>> sanitize the suspend-to-idle flow even further.
>>>
>>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
>>>
>>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
>>> specification-compliant order with respect to suspending and resuming
>>> devices (patch 2).
>>>
>>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
>>> switch to prevent the LPS0 _DSM from being used.
>> The v2 is because I found a (minor) bug in patch 1, decided to use a module
>> parameter instead of a kernel command line option in patch 4.  Also, there
>> are 4 new patches:
>>
>> Patch 5: Switch the EC over to polling during "noirq" suspend and back
>> during "noirq" resume.
>>
>> Patch 6: Eliminate acpi_sleep_no_ec_events().
>>
>> Patch 7: Consolidate some EC code depending on PM_SLEEP.
>>
>> Patch 8: Add EC GPE dispatching debug message.
> The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
> to the end of the series.   [After applying the full series the code is the same as before.]
>
> For easier testing, the series (along with some previous patches depended on by it)
> is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
It was just testing this patch series(461fc1caed55), to see if it would 
fix my charging issue 
(https://bugzilla.kernel.org/show_bug.cgi?id=201307), which it didn't.

I did however notice that my laptop (ASUS Zenbook UX430UNR/i7-8550U) 
won't wake when opening the lid or pressing a key, the only way to wake 
the laptop is pressing the power button.

I also tested mainline (5.3.0-rc4 b7e7c85dc7b0) and 5.2.8 and the laptop 
wakes without issue when the lid is opened or a key is presed.
> Please refer to the changelogs for details.
>
> Thanks,
> Rafael
>
>
>

