Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417B3E152E
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbfJWJDc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 05:03:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43758 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390828AbfJWJDb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 05:03:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id s5so1324378oie.10;
        Wed, 23 Oct 2019 02:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUN9J/2vsghSQEDoYKjkArcf/+ULxW+MHO+ZanwPpo4=;
        b=gsvSpxN8asmmJPaABTh0U7UQr4o1rZIqS6m6NbPa1f9vlQ7DPCM7tz1n9y/Nwa1WfI
         dQVVzLdpzhZ1I0ur3nKHHMl+3CX5ERnkxHNtFUdIBNFqE8Kn2vM6Rjac8qJb0UIV+IQt
         rv3VgX1Vo53WsqiLUfaWEb2e52sZsooDt6XTh1qpSn+e24v+VwbQp3nAxIes8ObbcPiN
         QN/gjimkQpSq/tkzmqHAHi5qXuCPxE3uN2iYg5yaIH4Mnrq6pY8VOmCPIsxTmI9J084S
         TlW+tDSexTnnIY7kb4nU7zi9iAze3agfwMiuKhQ4XzW2TIN/BcNp1TE5b7nLb2AkmPmN
         qKdg==
X-Gm-Message-State: APjAAAUfYFk0i+GW7Qo64YsSi3pTP8HOgQ63O6ckbotBBtcNg9uwe24p
        4iuYMEs5ydQToTc9ILZhc7f+livCDpFoLsOFN54=
X-Google-Smtp-Source: APXvYqzpnyRsjI08y4ZRUgjrw1GIJ1LFN//WuKMFEHxAIcp2foV7Lo1Ho0NyPkQWiuDpIsFmd7Iy31deRT8TXFwo9RE=
X-Received: by 2002:aca:d706:: with SMTP id o6mr6936010oig.57.1571821410371;
 Wed, 23 Oct 2019 02:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191023074945.17016-1-fengwei.yin@intel.com> <30ee0a348f624698801691f65eeecd87@AcuMS.aculab.com>
In-Reply-To: <30ee0a348f624698801691f65eeecd87@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 11:03:19 +0200
Message-ID: <CAJZ5v0jizy95pVh1gek5rmaVvGeZUMkVdKJUdesZeXGbj=mwRw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI/processor_idle: Remove dummy wait if kernel is in
 guest mode
To:     David Laight <David.Laight@aculab.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2019 at 10:45 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Yin Fengwei
> > Sent: 23 October 2019 08:50
>
>
> > In function acpi_idle_do_entry(), an ioport access is used for dummy
> > wait to guarantee hardware behavior. But it could trigger unnecessary
> > vmexit if kernel is running as guest in virtualization environtment.
> >
> > If it's in virtualization environment, the deeper C state enter
> > operation (inb()) will trap to hyervisor. It's not needed to do
> > dummy wait after the inb() call. So we remove the dummy io port
> > access to avoid unnecessary VMexit.
> >
> > We keep dummy io port access to maintain timing for native environment.
> >
> > Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> > ---
> > ChangeLog:
> > v2 -> v3:
> >  - Remove dummy io port access totally for virtualization env.
> >
> > v1 -> v2:
> >  - Use ndelay instead of dead loop for dummy delay.
> >
> >  drivers/acpi/processor_idle.c | 36 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index ed56c6d20b08..0c4a97dd6917 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -58,6 +58,17 @@ struct cpuidle_driver acpi_idle_driver = {
> >  static
> >  DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
> >
> > +static void (*dummy_wait)(u64 address);
> > +
> > +static void default_dummy_wait(u64 address)
> > +{
> > +     inl(address);
> > +}
> > +
> > +static void default_noop_wait(u64 address)
> > +{
> > +}
> > +
>
> Overengineered...
> Just add:
>
> static void wait_for_freeze(void)
> {
> #ifdef  CONFIG_X86
>         /* No delay is needed if we are a guest */
>         if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return;
> #endif
>
>         /* Dummy wait op - must do something useless after P_LVL2 read
>            because chipsets cannot guarantee that STPCLK# signal
>            gets asserted in time to freeze execution properly. */
>         inl(acpi_gbl_FADT.xpm_timer_block.address);
> }
>
> and use it to replace the inl().

I was about to make a similar comment.
