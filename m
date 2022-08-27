Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056955A3758
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Aug 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiH0LXv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Aug 2022 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH0LXu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Aug 2022 07:23:50 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A9625C7B
        for <linux-acpi@vger.kernel.org>; Sat, 27 Aug 2022 04:23:49 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id E32F514629;
        Sat, 27 Aug 2022 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661599427; bh=l84oPLz+UtilctO7UzUWcjkd2vRQtRIHAVkvKVWjyeI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FocpkHmxUBIf0vOlJSoM/rp8PiukMHt2DweinGRSbsxXuJeNnGdtGXPNO6FEm8sky
         X3uwgKweYyHPxo9pvs4P1YG6naUGSSqc9cOlwO1RxlttuSz1D7izlrZTJksAyc/BZZ
         nh4Yfu9bwxk8J3HuGkvxpETm0hj+Kj3pKolpFaLrG5y0By4ll3HeR0FkkygtCidy0z
         Vchif/dMR4WCY3bVm9KVvehkociuP6VtqUN8C5U/Z29MwexVLdAMhNhE6/sgYnDL+f
         e+gGoWApEhQlLsPsyYQlIptdqXEPNXTmrmQnS12VUIyQF5ohrZoWISGn3Ykyd4RsfH
         sw+qhtYmh92vw==
Message-ID: <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
Date:   Sat, 27 Aug 2022 13:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
From:   Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2022-08-26 13:46, Hans de Goede wrote:
> Hi All,
> 
> [...]
> 
> Arvid, I wonder if instead of using disable_backlight_sysfs_if
> you can try:
> 
> 0. Remove disable_backlight_sysfs_if from cmdline / quirk
> 1. Adding acpi_backlight=native to the kernel commandline
> 2. In toshiba_acpi_resume() add a HCI_PANEL_POWER_ON PANEL_ON
> 
> and see if that also fixes things ?
> 
Yes, this works. I do not have a patch for this (I assume it
would involve creating quirk tables, checking for support for
HCI_PANEL_POWER_ON, etc). I simply hard coded the call in for
the test. I very much doubt I will have time to code this in
the near future as well.

However, do we know what the other Toshiba's that need this
quirk also supports HCI_PANEL_POWER_ON? I obviously can only
test the Z830 that I own.

> If that is the case then we can:
> 
> 1. Move the DMI quirks for disable_backlight_sysfs_if
>    from acpi_video.c to video_detect.c to force native
>    mode by quirk
> 2. Add the DMI table with the models needing this to
>    toshiba_acpi.c and then based on that call
>    HCI_PANEL_POWER_ON PANEL_ON on resume from there
> 3. Since there are no more quirks using it, remove the
>    disable_backlight_sysfs_if hack / workaround from
>    acpi_video.c
> 
> This will give a nice-cleanup of the generic acpi_video.c
> code moving the toshiba specific fixup to toshiba_acpi
> where it really belongs.
> 
> Regards,
> 
> Hans
> 
> 

Best regards,
Arvid Norlander

