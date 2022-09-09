Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3C5B2D87
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 06:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIIE1O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 00:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIE1M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 00:27:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5143A1A73
        for <linux-acpi@vger.kernel.org>; Thu,  8 Sep 2022 21:27:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so1138531ejb.13
        for <linux-acpi@vger.kernel.org>; Thu, 08 Sep 2022 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=78SSDgx5J9XWCWtLRsyMtywdcg2ptRehP4M7BKRNRqo=;
        b=aCHFSrXrN9NDG8C6glSw4gM+aXcOSo+XLedXiZpZWzNQlA7n/LMDW1P41Tzp69eS0X
         IYR/vVTPcajNcxo0jf0lcQrjFNjFsBZLQUsRBD5GP25HD2SueVodJReVK2bEg5Cw7OXX
         abQJdPt5419SI9/DWwU0Ys6/UGGblVgf6KOr443hfvTJ2X4aMpsPLuojipGn/jdwQsiy
         RLGNZsNw/Y/vmTdrT60n1+DgzV8tgwH0TQJZ67m2WNT5a01NKSrL7Fw7M6B6J0uPma3U
         MSTSdrJnYkTFaN9nWfqt3Pl29yD0BufcDZN459WUE0nJWHuBdOVLmn8KfEe3wLuDQKzP
         n24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=78SSDgx5J9XWCWtLRsyMtywdcg2ptRehP4M7BKRNRqo=;
        b=CwAe0w7GAn0K2K7OA1kBzvDb5pqxlZcpgJPwf8EJUTJLsuG0JZ/2fumfFAKdn9xNKc
         wBY89kWlZf9ov8vkXANrbMBdK/vVhZrtY+slByKgBtHwHnP2uUPCrWcA8E+iwWqCW/6P
         2097+L6zXLZOwoItepqc2fpoWSWQXRHTFj8y18BOtFfgj2PBNIrT2+4U1wxWjFxYaXXf
         ZoFCYVpNqMqjs9qGLTB4RRfOwhgNDo6X7IWGqkn2uAnsiBGr3hTazjJNM479L1diFIRD
         T7G0ugXUjFp/6RHmOZ/Rx7Uba8ra5a9JRjbpWLPaqbOc8WxENqJFy1SZOAR1lzyUpRrG
         fIpQ==
X-Gm-Message-State: ACgBeo3enOoy+O0jhBZFvD1qrVY1KRrNvt6KqAkyfwLv29vHJCgrMYvp
        nxDktASw9O1BZI+2U0I2JZJVbQDJbw/E3o14Rhl8+Cf3VGj6NQ==
X-Google-Smtp-Source: AA6agR6FH9CHA8YiC9lKvwS6JH5CmAZEVKB/PJstpYfKXp3e3QelRcA/eyCgqh0BQiwtGgMnCYR9pxR7Yy7w1pqfeHU=
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id
 xf9-20020a17090731c900b00740ef932ffdmr8378071ejb.584.1662697629129; Thu, 08
 Sep 2022 21:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <de1cf16c-54cb-316b-3fcb-2520e6bb152f@semihalf.com> <CAJZ5v0hY05BzG=fL78BzyvxeJDZT+5D_ZeyCALt2+0JUDvHnew@mail.gmail.com>
In-Reply-To: <CAJZ5v0hY05BzG=fL78BzyvxeJDZT+5D_ZeyCALt2+0JUDvHnew@mail.gmail.com>
From:   =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mm@semihalf.com>
Date:   Fri, 9 Sep 2022 06:26:41 +0200
Message-ID: <CANxDZGpzB2CdzwT=Z+bvLY-5wBave+tXzcoN03eqx2=RiZ4fPQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Wait for ACPI IRQ to be processed before disable GPE
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07.09.2022 22:26, Rafael J. Wysocki wrote:
> On Wed, Sep 7, 2022 at 7:31 AM Marek Ma=C5=9Blanka <mm@semihalf.com> wrot=
e:
>>
>> On the wake-up, the ACPI GPE that are marked as a wakeup source are
>> turned off. Before turning off, the kernel waits for the currently
>> processing IRQ to finish and assumes that this is an ACPI interrupt that
>> triggered wake-up. In the case the first interrupt after wake-up is not
>> an ACPI interrupt, this might cause the ACPI GPE not to be processed
>> because it will be disabled.
>>
>> The patch makes sure that an ACPI interrupt is processed before
>> disabling GPE that are wakeup sources.
>>
>> This patch fix the issue that is seen on low-end Chromebooks with two
>> cores CPU when HPET IRQ is triggered while resuming the device and is
>> processed before the ACPI GPE interrupt on the same CPU core.
>>
>> Signed-off-by: Marek Maslanka <mm@semihalf.com>
>> ---
>>  drivers/acpi/internal.h |  2 ++
>>  drivers/acpi/osl.c      | 18 ++++++++++++++++++
>>  drivers/acpi/sleep.c    |  6 ++++++
>>  include/linux/acpi.h    |  2 ++
>>  4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 219c02df9a08..e4df1bf2963b 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -251,6 +251,8 @@ static inline bool force_storage_d3(void)
>>  }
>>  #endif
>>
>> +extern bool acpi_resume_gpe_irq_handled;
>> +
>>  /*---------------------------------------------------------------------=
-----
>>                                 Device properties
>>    ---------------------------------------------------------------------=
----- */
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 3269a888fb7a..ea587ac4c68a 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -42,6 +42,8 @@
>>  #define _COMPONENT             ACPI_OS_SERVICES
>>  ACPI_MODULE_NAME("osl");
>>
>> +#define ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS 500
>
> This is a relatively large number.  Doesn't anything smaller work?
>

Smaller values like 5ms also work. I just add extra time just in case. This
long time affects the wakeup time only if something really bad happened, ie=
.
ACPI interrupt is significantly delayed.

>> +
>>  struct acpi_os_dpc {
>>         acpi_osd_exec_callback function;
>>         void *context;
>> @@ -69,6 +71,8 @@ static struct workqueue_struct *kacpi_hotplug_wq;
>>  static bool acpi_os_initialized;
>>  unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>>  bool acpi_permanent_mmap =3D false;
>> +bool acpi_resume_gpe_irq_handled;
>> +static DECLARE_WAIT_QUEUE_HEAD(acpi_irq_after_suspend_wait);
>>
>>  /*
>>   * This list of permanent mappings is for memory that may be accessed f=
rom
>> @@ -549,6 +553,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
>>         handled =3D (*acpi_irq_handler) (acpi_irq_context);
>>
>>         if (handled) {
>> +               if (acpi_s2idle_wakeup()) {
>> +                       acpi_resume_gpe_irq_handled =3D true;
>> +                       wake_up(&acpi_irq_after_suspend_wait);
>> +               }
>>                 acpi_irq_handled++;
>>                 return IRQ_HANDLED;
>>         } else {
>> @@ -1768,3 +1776,13 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
>>                                                reg_a_value, reg_b_value)=
;
>>         return status;
>>  }
>> +
>> +int acpi_wait_for_resume_gpe_irq(void)
>> +{
>> +       int wait_ms =3D msecs_to_jiffies(ACPI_WAIT_FOR_RESUME_GPE_IRQ_MS=
);
>> +       int timeout =3D wait_event_timeout(acpi_irq_after_suspend_wait,
>> +                                        acpi_resume_gpe_irq_handled,
>> +                                        wait_ms);
>> +       return timeout;
>
> So this will wait for the full timeout if there are no ACPI events to
> process, right?
>
> Isn't it a bit excessive?
>

Yes. It waits full time if there is no ACPI interrupt

> Moreover, what if there is an ACPI event right after the wait has complet=
ed?

Further processing just disables the GPE, and GPE won't be processed. The s=
ame
case as we have now.

>> +}
>> +EXPORT_SYMBOL(acpi_wait_for_resume_gpe_irq);
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index ad4b2987b3d6..6ddf28067687 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -721,6 +721,7 @@ int acpi_s2idle_prepare(void)
>>         acpi_os_wait_events_complete();
>>
>>         s2idle_wakeup =3D true;
>> +       acpi_resume_gpe_irq_handled =3D false;
>>         return 0;
>>  }
>>
>> @@ -789,6 +790,7 @@ bool acpi_s2idle_wake(void)
>>
>>  void acpi_s2idle_restore(void)
>>  {
>> +       int timeout;
>>         /*
>>          * Drain pending events before restoring the working-state confi=
guration
>>          * of GPEs.
>> @@ -797,6 +799,10 @@ void acpi_s2idle_restore(void)
>>         acpi_ec_flush_work(); /* flush the EC driver's workqueues */
>>         acpi_os_wait_events_complete(); /* synchronize Notify handling *=
/
>>
>> +       timeout =3D acpi_wait_for_resume_gpe_irq();
>> +       if (timeout =3D=3D 0)
>> +               pr_warn("Failed to wait for ACPI interrupt after resume"=
);
>
> This is perfectly fine, for example if the system is woken up by a
> non-ACPI IRQ (eg. the keyboard one).
>

Right, I wrongly assumed that the wakeup source can be only an ACPI GPE
interrupt.

>> +
>>         s2idle_wakeup =3D false;
>>
>>         acpi_enable_all_runtime_gpes();
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index ed4aa395cc49..ef2ab7990f1c 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1475,4 +1475,6 @@ static inline void acpi_device_notify(struct devic=
e *dev) { }
>>  static inline void acpi_device_notify_remove(struct device *dev) { }
>>  #endif
>>
>> +int acpi_wait_for_resume_gpe_irq(void);
>> +
>>  #endif /*_LINUX_ACPI_H*/
>> --
>
> Overall, I'm not convinced about the approach.
>
> If the goal is to process all of the ACPI wakeup interrupts, this
> doesn't meet it.

The goal is to process the APCI interrupt that woke-up the system, before
disabling GPE. This will assure the GPE handlers will be invoked and GPE st=
atus
bit will be cleared.

I just realised that it should wait for an interrupt only if the wakeup eve=
nt
was an ACPI non-EC GPE interrupt.

> AFAICS the only way to do that which is not racy is to dispatch every
> wakeup GPE in-line (from the ACPICA code) before disabling it in case
> it is active at that point.

TBH I thought about a similar solution but from my (acpica non-expert) poin=
t of
view the patch will be more complex and it needs more effort than kernel pa=
tch.
But I might be wrong.
