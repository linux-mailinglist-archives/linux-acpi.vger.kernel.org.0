Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBB2686B0
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgINIAa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgINIA1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2020 04:00:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79DC06174A;
        Mon, 14 Sep 2020 01:00:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so11932228pfn.9;
        Mon, 14 Sep 2020 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWtfnbUAIcfLNSjZEmB/DP0e8Ah3wqyuRKjVuAdbyU0=;
        b=gQHcidFAXkKvHEwYzufedeiy9XCgNMpD51eJozBzqndBe9l3Pkghlr/MgVhSefaxbZ
         BDZMMAsPdjM6Lm/p5q6L+6Lnuxws5bCHBwQ3xutqRPnsDQf5aIg9shwd0XpyTXiLEAZq
         rOpxNzSDAAViZU38yHYgltZKr5mmPnkUWjSEivJVoFWP2agAmOSDmz4sM5JVzabNY8zf
         RsOfBlMIdIsSJpAZsmkxgIPyL8b0q2qOrPV+DU5xYAOf9ZQVkByY+FvW5VMUebwdmoQ+
         LwH3ghMD+9e6yAZXIxVvPKpCHOnepecsqrHR8yiJLzvHZty69FpK3h/aTLTc4LKYYnJd
         BW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWtfnbUAIcfLNSjZEmB/DP0e8Ah3wqyuRKjVuAdbyU0=;
        b=egqNvyqtyiiH/8M5DwM7LW2ha60/amrtFJUtCc/JkJruscCiJ0CaYjuSiYJfSK9MUe
         +QhiHKIj+hYyVqaXz7V+XEk87GrZbkjAaThmlY5JVaH+2bZyAciB5FjbOPEAWdSRLSG5
         VgBkv0q69m2zqIqHWHwM1wT+h+QWC9O/c5XRiXcR3mOStQ4PGsg0t6zaeMrCv62bo+CM
         7BD7j5WHcn7PKftBXQZfe6lI1RAgapOND54odz/Be5VOJ7tIVodxsa98yhswsS/uFmoo
         Ev3L4dt3qvo2pryNam6RTWjFl8kyVMM+30W4Ts3xxHI4hlculORlOhhOdotqD6Ii/TlY
         oQZw==
X-Gm-Message-State: AOAM531l5CNvMm+Cj+S2+WgigN6ZE8b8zyO70Bdic/REAPiVoqeH5qb4
        MzIv0d+CwE+gnyjDjUwdaDpr4asQxtXJvAkndG6YqLeU+slF7w==
X-Google-Smtp-Source: ABdhPJyRFTFkePHLp9vqrq4sbjxnHq0kWH3e3CTmsn3LuuF0tWCn03y/2Voh96TRRY8JHSy5O6XR+EGQJL/LqdZSzTE=
X-Received: by 2002:a05:6a00:22c5:: with SMTP id f5mr12638836pfj.163.1600070426131;
 Mon, 14 Sep 2020 01:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200906122016.4628-1-hdegoede@redhat.com> <20200914061246.GO1665100@dtor-ws>
 <61dfb476-2d55-116c-21d6-bf5972929cd3@redhat.com>
In-Reply-To: <61dfb476-2d55-116c-21d6-bf5972929cd3@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Sep 2020 11:00:10 +0300
Message-ID: <CAHp75VemDbswE9+yXMut1vbYvWwcTAd+b_Ry05_0QWbfnCSv9g@mail.gmail.com>
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 14, 2020 at 10:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 9/14/20 8:12 AM, Dmitry Torokhov wrote:
> > On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:

...

> >> The soc_button_array code really is x86 specific glue code to translate
> >> various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
> >> As such I wonder if it would not be better to move this driver to
> >> drivers/platform/x86?

AFAIU the above is a justification why PDx86 suits better to host it.

> >> I seem to be doing most if not all of the recent work on soc_button_array,
> >> and soon I will be a co-maintainer of drivers/platform/x86. So having it
> >> there and adding me in MAINTAINERS as maintaining it seems to be best?
> >>
> >> If you want I can do a patch moving soc_button_array to drivers/platform/x86
> >> and then add the other 3 patches on top and then we can merge all of this
> >> through drivers/platform/x86?
> >
> > Sorry, misread this first time through, so already merged the 3 patches,
> > but I to not mind at all moving the driver to platform tree. If you send
> > me such a patch I will apply it.
>
> Ok.
>
> Andy are you ok with moving the driver to the pdx86 tree too?

Taking into consideration the above, if I read it correctly, I agree.
Feel free to add my Ack.

-- 
With Best Regards,
Andy Shevchenko
