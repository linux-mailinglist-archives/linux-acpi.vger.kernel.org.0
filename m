Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA49443D0AD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhJ0S1C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 14:27:02 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45809 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhJ0S1C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 14:27:02 -0400
Received: by mail-ot1-f50.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so4820586otq.12;
        Wed, 27 Oct 2021 11:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkVrgd5x+vh4lCsQtX27kIwieK51Jd1JvnQfPTz93YI=;
        b=jpHIDnUwcG1KacAPUFZCAfwmRUprxbnCyhKQ4E13Kdw2owmTCozMCORYCzYJ2MaVxj
         HLtyJIJZyQ6PaSKR5944/+plR9uOzQZ6eexa6QP3GbigipQZwfQs8gvHUj45lXDDO2bg
         2mgm3GyABQtHnCU6xmOExPXQTGEF5Mrj/Sh9Fv9mQ8K9w3j3dE1reicRnny77TBiUZl7
         AT3SrUpEHgaflpRIZGGwYaQ+a+VfT8WsbFpBq7wq2eHUe69ozGT12CNcGs86ja6mjWC7
         wQZ5wTDOXdxIlzIL0FEvcRFt/FIdZOXXQVWQ7OwjPLaNEgbYAd57tAbXlsO2QmLSK9lK
         2fEQ==
X-Gm-Message-State: AOAM533LKaWhhygNd4Y544EwL4ovl8kyMJRA7bdmdUdFV8USVN7tPWT5
        zSJc2FlH+WsN8hDHvNTgN1/Ta9mHJqhNHonygf8=
X-Google-Smtp-Source: ABdhPJxK5xrtik4xKVv03jjdkdvigewIlW048G3prkktv6QXSCsn6Tah5WNJ8823gKJmnIYjzPZ2su3IGDAm+WcIVys=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr25672295otd.16.1635359076474;
 Wed, 27 Oct 2021 11:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <20211026072829.94262-1-xueshuai@linux.alibaba.com> <YXg1bWBKja/tqScg@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <YXg1bWBKja/tqScg@agluck-desk2.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 20:24:25 +0200
Message-ID: <CAJZ5v0gULZymuAuLzG74WxdEuLPqAg+HLWkJ_Wv6m3PLq6aJOg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI, APEI, EINJ: Relax platform response timeout to 1 second.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        luanshi <zhangliguang@linux.alibaba.com>,
        zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 7:05 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Oct 26, 2021 at 03:28:29PM +0800, Shuai Xue wrote:
> > When injecting an error into the platform, the OSPM executes an
> > EXECUTE_OPERATION action to instruct the platform to begin the injection
> > operation. And then, the OSPM busy waits for a while by continually
> > executing CHECK_BUSY_STATUS action until the platform indicates that the
> > operation is complete. More specifically, the platform is limited to
> > respond within 1 millisecond right now. This is too strict for some
> > platforms.
> >
> > For example, in Arm platform, when injecting a Processor Correctable error,
> > the OSPM will warn:
> >     Firmware does not respond in time.
> >
> > And a message is printed on the console:
> >     echo: write error: Input/output error
> >
> > We observe that the waiting time for DDR error injection is about 10 ms and
> > that for PCIe error injection is about 500 ms in Arm platform.
> >
> > In this patch, we relax the response timeout to 1 second.
> >
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
>
> Rafael: Do you want to take this in the acpi tree? If not, I can
> apply it to the RAS tree (already at -rc7, so in next merge cycle
> after 5.16-rc1 comes out).

I'll queue it up for 5.16.

Thanks!

> > ---
> > Changelog v2 -> v3:
> > - Implemented the timeout in usleep_range instead of msleep.
> > - Dropped command line interface of timeout.
> > - Link to the v1 patch: https://lkml.org/lkml/2021/10/14/1402
> > ---
> >  drivers/acpi/apei/einj.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > index 133156759551..6e1ff4b62a8f 100644
> > --- a/drivers/acpi/apei/einj.c
> > +++ b/drivers/acpi/apei/einj.c
> > @@ -28,9 +28,10 @@
> >  #undef pr_fmt
> >  #define pr_fmt(fmt) "EINJ: " fmt
> >
> > -#define SPIN_UNIT            100                     /* 100ns */
> > -/* Firmware should respond within 1 milliseconds */
> > -#define FIRMWARE_TIMEOUT     (1 * NSEC_PER_MSEC)
> > +#define SLEEP_UNIT_MIN               1000                    /* 1ms */
> > +#define SLEEP_UNIT_MAX               5000                    /* 5ms */
> > +/* Firmware should respond within 1 seconds */
> > +#define FIRMWARE_TIMEOUT     (1 * USEC_PER_SEC)
> >  #define ACPI5_VENDOR_BIT     BIT(31)
> >  #define MEM_ERROR_MASK               (ACPI_EINJ_MEMORY_CORRECTABLE | \
> >                               ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> > @@ -171,13 +172,13 @@ static int einj_get_available_error_type(u32 *type)
> >
> >  static int einj_timedout(u64 *t)
> >  {
> > -     if ((s64)*t < SPIN_UNIT) {
> > +     if ((s64)*t < SLEEP_UNIT_MIN) {
> >               pr_warn(FW_WARN "Firmware does not respond in time\n");
> >               return 1;
> >       }
> > -     *t -= SPIN_UNIT;
> > -     ndelay(SPIN_UNIT);
> > -     touch_nmi_watchdog();
> > +     *t -= SLEEP_UNIT_MIN;
> > +     usleep_range(SLEEP_UNIT_MIN, SLEEP_UNIT_MAX);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.20.1.12.g72788fdb
> >
