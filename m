Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9535731532D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 16:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhBIPuj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 10:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhBIPua (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 10:50:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAEFC06174A
        for <linux-acpi@vger.kernel.org>; Tue,  9 Feb 2021 07:49:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s26so18602619edt.10
        for <linux-acpi@vger.kernel.org>; Tue, 09 Feb 2021 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VecoGZ4GzWVFIM0otW3JLzPjrBseKAGL1qDTMuL9rhQ=;
        b=CIlh381kw95e85vYr57RlSuDC8kY8uEDiHm3Z8pePwVEf5EWMktOAJ8fGRfI8LyX79
         kO9nexVJp1Drhi5KDy+WElL2nlFVJNS4sVk60qwTKrQjxfmYIaG63VGkNeCsomyiLBGB
         ympVvtXZztYSxkyGsegiNStxZyW3MiGeRjmRTq8b6fYNiohin0XYQA0pMZPKtkC6ecEl
         pQqqwB4hWjBMRzfrJKQiuAT+/W9aP9UU3cFW4cBq8WMuMntzUHQ3LOqpc3+qdriViebo
         S+js95KFw5dV3JIc7xY0dJlwoY/0500CIrFUNNQhH2I2/yOgoOLP3mp7ZpaTltK07skQ
         cynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VecoGZ4GzWVFIM0otW3JLzPjrBseKAGL1qDTMuL9rhQ=;
        b=nD4OHPcMswG4YfCWRehpC2rYUll30zpPH+wEPHwzwRYd6STKJj1uVTBXErKhkHHqV7
         s7y4C4VxU8CAUMM1AXVOMgRI7rgSe//j6C6cLODvOaRnPRyMju7pHG4DH2icuNPN+Qba
         RPVrAhD0TfjLMwuMsvA5BGvjoeTguI4WQ6JgWfkj5uBKvXrtlT7o+imkxhI0YlcOnNL3
         hkNTia7rT5r53My5h2QiWgzGn8TYdYClb5ZEu4C30yb9nXr97VIPM9wUJtXu2bjFoa44
         BmW2clj43oCEmccKkcV0nEg3EK/uI5GeEWLOrfyEixFDeqbm14bi0MllgEQUH2/wtMMq
         1gLg==
X-Gm-Message-State: AOAM5310GiOfsJGT/gYbvKz79Myc2OZA4W9kuS4j8kGAAOnxIj5VnQZT
        Ot1YokMpGzIDt7Zc2heT0+lpEKKNAjsBwK4D1HTBSQ==
X-Google-Smtp-Source: ABdhPJxY4AjMbkZIQt1FqfH6XSv98lRusycD/W81ImCx2ZhTZq/tiEGg+xyJm+Pfkabf+n79kGMITiS2GYWaVpasTic=
X-Received: by 2002:aa7:c98e:: with SMTP id c14mr20178301edt.213.1612885788168;
 Tue, 09 Feb 2021 07:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20210205132505.20173-1-sakari.ailus@linux.intel.com>
 <20210205132505.20173-8-sakari.ailus@linux.intel.com> <CAMpxmJU7J9JBSwCN+GLDpuOL=iZ1PH=oZZuGiAyovuf2TQ=o9A@mail.gmail.com>
 <CAJZ5v0jUqtYDpBn-ezsftCrY=9iD3sAKhyyFf_+CMkthLnsZow@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUqtYDpBn-ezsftCrY=9iD3sAKhyyFf_+CMkthLnsZow@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 9 Feb 2021 16:49:37 +0100
Message-ID: <CAMpxmJW61Bd1SR3-i6=OV6RgafiEdfp4sNN0M6EYa7NSeOTFKg@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] at24: Support probing while off
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 8, 2021 at 5:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 8, 2021 at 5:44 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 2:25 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > In certain use cases (where the chip is part of a camera module, and the
> > > camera module is wired together with a camera privacy LED), powering on
> > > the device during probe is undesirable. Add support for the at24 to
> > > execute probe while being powered off. For this to happen, a hint in form
> > > of a device property is required from the firmware.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > ---
> >
> > I'll ack this but I still claim that the name
> > acpi_dev_state_low_power() is super misleading for this use-case and
> > I've been saying that for 10 versions now with everyone just ignoring
> > my remarks. :/
>
> Well, the function in question simply checks if the current ACPI power
> state of the device is different from "full power", so its name
> appears to be quite adequate to me.
>
> If the way in which it is used is confusing, though, I guess
> explaining what's going on would be welcome.
>

Yes, I have explained it multiple time already - last time at v9 of this series:

    https://www.spinics.net/lists/kernel/msg3816807.html

Bartosz

> > Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
