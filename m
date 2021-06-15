Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18923A7692
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 07:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhFOFp4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 01:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOFpz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 01:45:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B1C061574
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2021 22:43:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so13192301otl.3
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2021 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q+EAnfW54/ZMDPqb/u/PHjOJ/SzWRIAI+GkjQIrE7NY=;
        b=mTIOFOUFkd1vnYT2gzRrXaD2XmLEjh8qTfnGgaYlAg/TjWb5MPlyTRXBVpBQemr65j
         TZF0u+9wyXpqxqYgDJcQSB3MjESSCBP4+n03BiyTYQTlCBL2Z4vJMSCprTi6NHiOwuqh
         U7NZW/zyrIB+oo62zOdxkHt0xNXARSmT39XKGh5r0PQBHiEfRUFvX8A7n+dgS5FkvMSP
         JhdQIIn7F/qYSpe8IjkE7UXnZsSKk6Lu18MBfeMfqcYXG4BBRttv1Lmo8a3T/n+wYQwj
         hKiOuPAImjlLRt8zWrbcD2bXJ9nsbAXR/yMBB9a2wKxkIUSCeShWH1Jhc2WI+ueTr6eA
         VV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+EAnfW54/ZMDPqb/u/PHjOJ/SzWRIAI+GkjQIrE7NY=;
        b=ZJDp6j1hkmlzr6FtiQKx9WfGfvy5uqdnjCLP9t3KAkEPBcy38ZB825DuN+634JFuvl
         rx7LonYfjU9XK/tF3BJKTS+mWmwz+EpBxRNDP3zutH6QAzXlPaibLlUyYrKosaXp+BWF
         N3zhaNdyjIMkttUAZAuMKsi3pI+qDGNvazl9yH7ExvEFeHGrQI3eDnM0CrLLUZxeH3st
         y/G7/iv7g5jtCI/RlMIbN+vHewMOkZJt4H1VXMemCbmUUqEPkM+Zsguygu5bwZ6ynf+h
         1PmKKrJ6CJerABEHYuuN7rYkp71n21LKoCNH0bqVBqAVLI0JB85IpU8q5DCurnAhTJP7
         RkhQ==
X-Gm-Message-State: AOAM530vYAOwXrrPpR0IYMu2i4UbQJej0TPLEZ3lfHlqQZsnh21uZkAD
        BGNzJEp8rrz/2ckIfbSn6XePdqNwZeI=
X-Google-Smtp-Source: ABdhPJxyYCTDYa6Vb4H8XJUPVw+2mUsuCxKPVOAf29WGxGm71hsPCulpQ2pLlWRXCF5nSNB2D/zS0w==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr16407971ota.116.1623735830589;
        Mon, 14 Jun 2021 22:43:50 -0700 (PDT)
Received: from fedora ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id 111sm3894873otg.25.2021.06.14.22.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 22:43:50 -0700 (PDT)
Date:   Mon, 14 Jun 2021 23:43:43 -0600
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: acpi_video: Fixed comment style code issues
Message-ID: <YMg9S2/QI2Zrf/Zg@fedora>
References: <20210612184008.666840-1-majortomtosourcecontrol@gmail.com>
 <CAJZ5v0izub_zSJih1_5rznQPzgpHJ7-LhcWGarg7iyh+U2g-9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izub_zSJih1_5rznQPzgpHJ7-LhcWGarg7iyh+U2g-9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 04:50:05PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jun 12, 2021 at 8:42 PM Clayton Casciato
> <majortomtosourcecontrol@gmail.com> wrote:
> >
> > Fixed coding style issues.
> 
> The comments are broken the way they are to avoid going over 80
> characters.  What's wrong with them?
> 

Checkpatch warns that "block comments use a trailing */ on a separate line".

I believe the patch fixes the style issue and improves readability.

NB: the first comment exceeds 80 characters pre-patch.

From my understanding, the default limit is 100 characters as of bdc48fa11e46.

Thank you for your consideration!

> > Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> > ---
> >  drivers/acpi/acpi_video.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 0c884020f74b..61e52ab5aab6 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -134,8 +134,7 @@ struct acpi_video_device_attrib {
> >         u32 display_type:4;     /* Describe the specific type in use */
> >         u32 vendor_specific:4;  /* Chipset Vendor Specific */
> >         u32 bios_can_detect:1;  /* BIOS can detect the device */
> > -       u32 depend_on_vga:1;    /* Non-VGA output device whose power is related to
> > -                                  the VGA device. */
> > +       u32 depend_on_vga:1;    /* Non-VGA output device whose power is related to the VGA device */
> >         u32 pipe_id:3;          /* For VGA multiple-head devices. */
> >         u32 reserved:10;        /* Must be 0 */
> >
> > @@ -1581,13 +1580,11 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
> >         input = video->input;
> >
> >         switch (event) {
> > -       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> > -                                        * most likely via hotkey. */
> > +       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch, most likely via hotkey. */
> >                 keycode = KEY_SWITCHVIDEOMODE;
> >                 break;
> >
> > -       case ACPI_VIDEO_NOTIFY_PROBE:   /* User plugged in or removed a video
> > -                                        * connector. */
> > +       case ACPI_VIDEO_NOTIFY_PROBE:   /* User plugged in or removed a video connector. */
> >                 acpi_video_device_enumerate(video);
> >                 acpi_video_device_rebind(video);
> >                 keycode = KEY_SWITCHVIDEOMODE;
> > --
> > 2.31.1
> >
