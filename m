Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6428E269456
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 20:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgINSFL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINSFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2020 14:05:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542DAC06174A;
        Mon, 14 Sep 2020 11:05:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so258709pjb.4;
        Mon, 14 Sep 2020 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tR/WN80Bew5myqpapBdRqLOLmFrODb/ZsmRad6iDvWc=;
        b=GLoRFWqt0K1bbBB4dMdgN8o53kG3rjKoQUoOnMRWOFWcfrL1oWoxNJ6K0nDP5Bxq2x
         6bcPnwERWHKF7hSyVXnxZ++HJlipXdKEqvzOuyOPmjypP1u5tBMxqsEvyz91k8izuR6l
         dNLsGe4v2QlSn0SjOh23mOt7CmREYpZ1PPuzbX2/Qc2G7zXZ15SR/EDyC7XXW7yjHIDe
         ZV7PhJ150O8uonJP+t2TXxmbCnx1GqrAR8sBApjtMY3CCcmUW6UpU+K+pL8vtPWHx6FQ
         BYhaJjSzw7B83C4qEZQPnvQgzXj/ALQUU9tmEB/YHFPwiN5a8ZXrimhzE5e7hA1jCwGU
         MY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tR/WN80Bew5myqpapBdRqLOLmFrODb/ZsmRad6iDvWc=;
        b=gTB38VjiRdy2UFuHOMF+CbdfejP1c1fwswrf7PUE8jND4/DnmNoD2EnvWIJrCNzdpm
         U67S7GAFePq85EmS4NcW8K73TSANa0SJIK5OL6Bua8fnQcih7xi8E6eAib7wmybXjUuf
         3Rr/WCuoW4/qCNf99FRm/Pmv6ojQKmNkqm180PQPnajNa8ShZQH0FQ/2+HFD+e7Xe6U8
         iq3i8DAfHWHI0kxjEp/7qhD2h9D4Rhy3nSj7uP7ctvcQRME0xSqV3zAVgSNLSdM4SnTK
         2HNZYhZPAolWW6S/Rzm8NcQJepc7ud2necI6Fpj7+iHuEJa+ClI9+uIreE2QjjJKJkGa
         dQfg==
X-Gm-Message-State: AOAM5331txBPVf8Q08gyU9p5NRW6V284pPkfzGRwyRaXsnE3j8w718PT
        StUwp8JsSUmvOuGGEV3A6sP5GBam+mg=
X-Google-Smtp-Source: ABdhPJwOAx+5PEx1NfHyfvJ2Tr/z+yzqffu5BXiYCvNq2tEZwaPMYG1NuNBgPhPVy/1lB35hxlVziA==
X-Received: by 2002:a17:90a:1905:: with SMTP id 5mr486525pjg.169.1600106709736;
        Mon, 14 Sep 2020 11:05:09 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s16sm9019458pgl.78.2020.09.14.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:05:09 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:05:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
Message-ID: <20200914180507.GT1665100@dtor-ws>
References: <20200906122016.4628-1-hdegoede@redhat.com>
 <20200914061246.GO1665100@dtor-ws>
 <61dfb476-2d55-116c-21d6-bf5972929cd3@redhat.com>
 <CAHp75VemDbswE9+yXMut1vbYvWwcTAd+b_Ry05_0QWbfnCSv9g@mail.gmail.com>
 <897df830-4806-0118-6a27-0025268da1f5@redhat.com>
 <ead6b6f3-5fb7-d986-1bba-4f4a9350a369@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead6b6f3-5fb7-d986-1bba-4f4a9350a369@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 14, 2020 at 04:08:09PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/14/20 3:52 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 9/14/20 10:00 AM, Andy Shevchenko wrote:
> > > On Mon, Sep 14, 2020 at 10:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > > > On 9/14/20 8:12 AM, Dmitry Torokhov wrote:
> > > > > On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:
> > > 
> > > ...
> > > 
> > > > > > The soc_button_array code really is x86 specific glue code to translate
> > > > > > various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
> > > > > > As such I wonder if it would not be better to move this driver to
> > > > > > drivers/platform/x86?
> > > 
> > > AFAIU the above is a justification why PDx86 suits better to host it.
> > 
> > Correct.
> > 
> > > > > > I seem to be doing most if not all of the recent work on soc_button_array,
> > > > > > and soon I will be a co-maintainer of drivers/platform/x86. So having it
> > > > > > there and adding me in MAINTAINERS as maintaining it seems to be best?
> > > > > > 
> > > > > > If you want I can do a patch moving soc_button_array to drivers/platform/x86
> > > > > > and then add the other 3 patches on top and then we can merge all of this
> > > > > > through drivers/platform/x86?
> > > > > 
> > > > > Sorry, misread this first time through, so already merged the 3 patches,
> > > > > but I to not mind at all moving the driver to platform tree. If you send
> > > > > me such a patch I will apply it.
> > > > 
> > > > Ok.
> > > > 
> > > > Andy are you ok with moving the driver to the pdx86 tree too?
> > > 
> > > Taking into consideration the above, if I read it correctly, I agree.
> > > Feel free to add my Ack.
> > 
> > Ok, since Dmitry's tree currently has some changes to soc_button_array.c,
> > the plan is to merge the patch through Dmitry's tree.
> > 
> > I will prepare a patch with your Acked-by and submit it.
> 
> So to make sure that there won't be any merge issues,
> I was comparing bases for
> {drivers/input/misc,drivers/platform/x86}/{Makefile,Kconfig}
> looking at the versions in:
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/?h=next
> http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/for-next (which atm is just 5.9-rc1)
> 
> And the latter has a couple of commits to
> drivers/platform/x86/Kconfig which the input tree is missing;
> and these commits touch part of the file which moving the driver
> over will also be touching.
> 
> Dmitry, it seems that your for next-tree is based on 5.7 + 2
> large merges and as such does not have all the commits from
> 5.9-rc1 ?

Yeah, I typically merge with mainline if I need new APIs or to sync up
with shared stuff.

Thanks.

-- 
Dmitry
