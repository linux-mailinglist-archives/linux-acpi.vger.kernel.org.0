Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03E5B401D
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiIITrc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiIITrP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 15:47:15 -0400
Received: from vorpal.se (unknown [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FC2102A;
        Fri,  9 Sep 2022 12:44:25 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id 645D4142D4;
        Fri,  9 Sep 2022 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662752648; bh=GP+MSYE65OoUV9voAxXbxbEJEZlFVVgEIaFmMVF8Yak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HXQCdkESwt/vmeF1dEnHdwWcklLRJ4LcpzzyxWIingsiqCplRVu/9Fhqg7t6nnLxR
         8dvWjBvZv03/CejPVKaVMXSBIlgZrY6xuUljYEPP2tdyDsdVbH0F9xiviG124DpzVT
         UUcM2RMjFwk0kDhOEJ8IVQCq8PfjtBFey2jJ2gIVItSnHmCSS54xIsjmfLsRlN5IDt
         5OuXXNSyIFQ8T1Cx2KU2mtbnBEnRWuGglkPbYmhcJbjtu5Fvq4H0a4NetgdSVDM7zL
         lfqYZYezzuINirzaLO/CYUwwqMGNtssvZ7N4wHozEYsR4EHd2A67wwG/D3eLpjRBpM
         fl/FRaCNOk0iw==
Message-ID: <7b55c9ed-e25b-fb8d-ad62-426ffbeeef6d@vorpal.se>
Date:   Fri, 9 Sep 2022 21:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] drivers/platform: toshiba_acpi: Call
 HCI_PANEL_POWER_ON on resume on some models
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20220909153239.34606-1-hdegoede@redhat.com>
 <ee77aadf-8adc-c812-55ae-c534fb523de5@vorpal.se>
 <cc8ae460-9ebd-6c47-a938-eb515ce42104@redhat.com>
 <de8a1f37-414d-3a06-0b56-54b0daa4a250@vorpal.se>
 <0a3cc313-2f7d-ed99-392f-92cad2838a1d@redhat.com>
Content-Language: en-US
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <0a3cc313-2f7d-ed99-392f-92cad2838a1d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-09-09 21:20, Hans de Goede wrote:
> Hi,
> 
> On 9/9/22 20:32, Arvid Norlander wrote:
>> Hi,
>>
>> On 2022-09-09 19:42, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 9/9/22 19:29, Arvid Norlander wrote:
>>>> Hi,
>>>>
>>>> Given the changes, do you want me to test this again? If so, on what branch?
>>>
>>> I have just pushed this new version + all your pending toshiba_acpi patches
>>> to my review-hans branch:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans\
>>>
>>> If you can give this branch a quick test and let me know if everything works
>>> as expected that would be great.
>>
>> My changes (battery charge threshold, fan HWMON support, ECO LED work as
>> expected.
>>
>> Display does come on after resume. Unfortunately the computer also
>> completely locks up (I can't even switch from X to a VT). SSH is dead.
>> When I suspend with a VT active the cursor is no longer blinking on resume.
>> So something else is severly broken in this version and I cannot fully test
>> this.
>>
>> I notice your tree is based on rc1. I was previously testing with 5.19 as
>> well as rc2 and newer. Is it possible this is a bug from mainline?
> 
> Ah yes, sorry about that. There is a scsi bug which causes any sata
> disks to become inaccessible after suspend/resume in rc1.
> 
> If you cherry pick this commit on top of my tree the problem should be gone:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=785538bfdd682c8e962341d585f9b88262a0475e

This fixed it. Resume works properly, as does backlight controls after resume.

Tested-by: Arvid Norlander <lkml@vorpal.se>
(For the relevant toshiba_acpi patches)

However I notice that the laptop is hung for about a second after resume. I
had not noticed this before. But I went back and checked on 5.19 and it
happens there too, so presumably I just ended up being hyper-aware about
resume issues after this...

> 
>> Or is
>> it something introduced by your tree? I'm wondering it it would be easier
>> to first rebase your tree on the latest RC rather than trying to bisect it
>> as is.
>>
>> Or the easiest test is perhaps: Does suspend and resume with this tree work
>> on your computer? I remember hearing that there were SATA issues in early
>> 6.0-rcs (don't remember the details), the Toshiba uses mSATA.
> 
> Right, see above.
> 
> Regards,
> 
> Hans
> 

Best regards,
Arvid Norlander
