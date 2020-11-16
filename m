Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B6E2B44C3
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgKPNcn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 08:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPNcm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 08:32:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF31C0613CF;
        Mon, 16 Nov 2020 05:32:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so13222606pgg.12;
        Mon, 16 Nov 2020 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MhvQIZx+4WVXltMTHk6NM1rItTX9NEJ32VnNB91hdHk=;
        b=XHbn2J8mnoj7TV74MxBxH47MWzw9dlU8s3waSru0K1QldnT4uulLZwcjbu3Pv0q0Pq
         wRn7YBML1ypolf31Z9tMSgIRjxwzZ7H3KHDy4okTnmZ4RmYEcDhQFkXB9t2R9t1Kw9PU
         z7Ia5EhD5L4is9JNDm1HJNtO+L9O+b2TWYQa4dLPjgIR8vJ6QwdbE8/KXQsQU6ljVvim
         kuRXQjEXixk6Ugyfa0q9llUYsTY1WeqkCPBpLGHpHoskQ7JGG+7miZ08mjLAxoq2FS1C
         OEOcNgaeVHjEaNUkbTOFa5AhlutxHjjY4gv36dFFIyXO34xDDoQGcIHuEvqT9LsJ5TjH
         ztcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MhvQIZx+4WVXltMTHk6NM1rItTX9NEJ32VnNB91hdHk=;
        b=lfKuRWW6GROoy0xDI2+80ABfp18xjmkk3GUt1wLX4Hu0FKMto6C7P1TJMj8vUFlHvS
         5BhnqaiWfWDLHVVT26qb6+FNO9ag4kT0zsFigFuHIM+iHmiNaZlXsjACWr3N0Ne3ADWf
         3yNJx+7r+1N/2uTy4/fI+rcca0rPr/IlI86qazX2pTg6sikrH8Me84ul7QewVb507l0f
         7L1LwoLKmdyKbh/fOnLgx84/H6Wa4wGyiNWgAR86TB7ekV2t7urEh+1nEM7VUmzmkmVV
         UKTYeFMFRLMmjUifANI8dytehanei1PS+yPlVe4s+wDuFcWa53OjD6FPFkcEIAsPaGKF
         Fb7g==
X-Gm-Message-State: AOAM530UcDUgFrkKOYI3it/ejpCyvsH2eAPfpB+V44VvavF5QGGRdFlx
        SDJ6MsZ2gyyKR+Biq+bFh4Bzo5sNtowPkkAAjAo=
X-Google-Smtp-Source: ABdhPJwHIwQ3hD9paSMqYSha+PjuEHPXuAxryI0yMmx201boEP+sef85gkuZ7d1SX1Kdbon3GurrkCvIghyUBPtU2bg=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr13685227pfc.7.1605533561548; Mon, 16
 Nov 2020 05:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20201115192143.21571-1-luzmaximilian@gmail.com> <20201115192143.21571-2-luzmaximilian@gmail.com>
In-Reply-To: <20201115192143.21571-2-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Nov 2020 15:33:29 +0200
Message-ID: <CAHp75VdOnUW6kftkD1zGR345fJUPPv9zfi0YitYJOb1BPxQcPw@mail.gmail.com>
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Nov 15, 2020 at 9:25 PM Maximilian Luz <luzmaximilian@gmail.com> wr=
ote:
>
> Add Surface System Aggregator Module core and Surface Serial Hub driver,
> required for the embedded controller found on Microsoft Surface devices.
>
> The Surface System Aggregator Module (SSAM, SAM or Surface Aggregator)
> is an embedded controller (EC) found on 4th and later generation
> Microsoft Surface devices, with the exception of the Surface Go series.
> This EC provides various functionality, depending on the device in
> question. This can include battery status and thermal reporting (5th and
> later generations), but also HID keyboard (6th+) and touchpad input
> (7th+) on Surface Laptop and Surface Book 3 series devices.
>
> This patch provides the basic necessities for communication with the SAM
> EC on 5th and later generation devices. On these devices, the EC
> provides an interface that acts as serial device, called the Surface
> Serial Hub (SSH). 4th generation devices, on which the EC interface is
> provided via an HID-over-I2C device, are not supported by this patch.
>
> Specifically, this patch adds a driver for the SSH device (device HID
> MSHW0084 in ACPI), as well as a controller structure and associated API.
> This represents the functional core of the Surface Aggregator kernel
> subsystem, introduced with this patch, and will be expanded upon in
> subsequent commits.
>
> The SSH driver acts as the main attachment point for this subsystem and
> sets-up and manages the controller structure. The controller in turn
> provides a basic communication interface, allowing to send requests from
> host to EC and receiving the corresponding responses, as well as
> managing and receiving events, sent from EC to host. It is structured
> into multiple layers, with the top layer presenting the API used by
> other kernel drivers and the lower layers modeled after the serial
> protocol used for communication.
>
> Said other drivers are then responsible for providing the (Surface model
> specific) functionality accessible through the EC (e.g. battery status
> reporting, thermal information, ...) via said controller structure and
> API, and will be added in future commits.

...

> +menuconfig SURFACE_AGGREGATOR
> +       tristate "Microsoft Surface System Aggregator Module Subsystem an=
d Drivers"
> +       depends on SERIAL_DEV_BUS
> +       depends on ACPI
> +       select CRC_CCITT
> +       help
> +         The Surface System Aggregator Module (Surface SAM or SSAM) is a=
n
> +         embedded controller (EC) found on 5th- and later-generation Mic=
rosoft
> +         Surface devices (i.e. Surface Pro 5, Surface Book 2, Surface La=
ptop,
> +         and newer, with exception of Surface Go series devices).
> +
> +         Depending on the device in question, this EC provides varying
> +         functionality, including:
> +         - EC access from ACPI via Surface ACPI Notify (5th- and 6th-gen=
eration)
> +         - battery status information (all devices)
> +         - thermal sensor access (all devices)
> +         - performance mode / cooling mode control (all devices)
> +         - clipboard detachment system control (Surface Book 2 and 3)
> +         - HID / keyboard input (Surface Laptops, Surface Book 3)
> +
> +         This option controls whether the Surface SAM subsystem core wil=
l be
> +         built. This includes a driver for the Surface Serial Hub (SSH),=
 which
> +         is the device responsible for the communication with the EC, an=
d a
> +         basic kernel interface exposing the EC functionality to other c=
lient
> +         drivers, i.e. allowing them to make requests to the EC and rece=
ive
> +         events from it. Selecting this option alone will not provide an=
y
> +         client drivers and therefore no functionality beyond the in-ker=
nel
> +         interface. Said functionality is the responsibility of the resp=
ective
> +         client drivers.
> +
> +         Note: While 4th-generation Surface devices also make use of a S=
AM EC,
> +         due to a difference in the communication interface of the contr=
oller,
> +         only 5th and later generations are currently supported. Specifi=
cally,
> +         devices using SAM-over-SSH are supported, whereas devices using
> +         SAM-over-HID, which is used on the 4th generation, are currentl=
y not
> +         supported.

From this help text I didn't get if it will be a module or what if I
chose the above?

...

> +/* -- Safe counters. ---------------------------------------------------=
----- */

Why can't XArray be used here?

...

> +
> +

One blank line is enough

...

> +static bool ssam_event_matches_notifier(
> +               const struct ssam_event_notifier *notif,
> +               const struct ssam_event *event)

Perhaps

static bool
ssam_event_matches_notifier(const struct ssam_event_notifier *n,
               const struct ssam_event *event)

(or even switch to 100 limit, also note notif ->n =E2=80=94 no need to repe=
at same word)

...

> +       nb =3D rcu_dereference_raw(nh->head);
> +       while (nb) {
> +               nf =3D container_of(nb, struct ssam_event_notifier, base)=
;
> +               next_nb =3D rcu_dereference_raw(nb->next);
> +
> +               if (ssam_event_matches_notifier(nf, event)) {
> +                       ret =3D (ret & SSAM_NOTIF_STATE_MASK) | nb->fn(nf=
, event);
> +                       if (ret & SSAM_NOTIF_STOP)
> +                               break;

The returned value is a bitmask?!
What are you returning at the end?

> +               }
> +
> +               nb =3D next_nb;
> +       }

...

> +static int __ssam_nfblk_insert(struct ssam_nf_head *nh, struct ssam_noti=
fier_block *nb)
> +{
> +       struct ssam_notifier_block **link =3D &nh->head;
> +
> +       while ((*link) !=3D NULL) {
> +               if (unlikely((*link) =3D=3D nb)) {
> +                       WARN(1, "double register detected");
> +                       return -EINVAL;
> +               }
> +
> +               if (nb->priority > (*link)->priority)
> +                       break;
> +
> +               link =3D &((*link)->next);
> +       }
> +
> +       nb->next =3D *link;
> +       rcu_assign_pointer(*link, nb);
> +
> +       return 0;
> +}

If you need RCU (which is also the Q per se), why not use RCU list?

...

> +       while ((*link) !=3D NULL) {

Redundant parentheses, redundant ' !=3D NULL' part.

> +               if ((*link) =3D=3D nb)
> +                       return link;
> +
> +               link =3D &((*link)->next);
> +       }

...

> + * struct ssam_nf_refcount_entry - RB-tree entry for referecnce counting=
 event

In above you mistyped 'which' as 'whic' or so, and here reference.
Perhaps go thru spell checker?

...

> + * registered, or ``ERR_PTR(-ENOMEM)`` if the entry could not be allocat=
ed.

Better to spell out "error pointer" instead of cryptic ERR_PTR().

...

> + * Executa registered callbacks in order of their priority until either =
no
> + * callback is left or a callback returned a value with the %SSAM_NOTIF_=
STOP

returns

> + * bit set. Note that this bit is set automatically when converting non.=
zero
> + * error values via ssam_notifier_from_errno() to notifier values.

...

> +               for (i =3D i - 1; i >=3D 0; i--)

while (i--)

> +                       ssam_nf_head_destroy(&nf->head[i]);

...

> +       // limit number of processed events to avoid livelocking
> +       for (i =3D 0; i < 10; i++) {

Magic number! Also, this will be better to read in a form of

unsigned int iterations =3D 10;

do {
...
} while (--iterations);

> +               item =3D ssam_event_queue_pop(queue);
> +               if (item =3D=3D NULL)
> +                       return;
> +
> +               ssam_nf_call(nf, dev, item->rqid, &item->event);
> +               kfree(item);
> +       }

...

> +static const guid_t SSAM_SSH_DSM_GUID =3D GUID_INIT(0xd5e383e1, 0xd892, =
0x4a76,
> +               0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);

Can you use usual pattern for these UIDs, like
static const guid_t SSAM_SSH_DSM_GUID =3D
        GUID_INIT(0xd5e383e1, 0xd892, 0x4a76,
                 0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);
?

Also put a comment how this UID will look like in a string representation.

...

> +       if (!acpi_has_method(handle, "_DSM"))
> +               return 0;

Hmm... What's the expectation?

> +       obj =3D acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
> +                                     SSAM_SSH_DSM_REVISION, 0, NULL,
> +                                     ACPI_TYPE_BUFFER);
> +       if (!obj)
> +               return -EFAULT;

EFAULT?! Perhaps you can simply return 0 here, no?

> +       for (i =3D 0; i < obj->buffer.length && i < 8; i++)
> +               mask |=3D (((u64)obj->buffer.pointer[i]) << (i * 8));

Don't we have some helpers for this? At least I remember similar code
went to one of PDx86 drivers like intel-vbtn or so.

> +       if (mask & 0x01)

BIT(0) ?

> +               *funcs =3D mask;

...

> +       caps->ssh_power_profile =3D (u32)-1;
> +       caps->screen_on_sleep_idle_timeout =3D (u32)-1;
> +       caps->screen_off_sleep_idle_timeout =3D (u32)-1;
> +       caps->d3_closes_handle =3D false;
> +       caps->ssh_buffer_size =3D (u32)-1;

Use proper types and their limits (limits.h missed?).

...

> +       // initialize request and packet transport layers

Inconsistent style of comments.

...

> + * In the course of this shutdown procedure, all currently registered
> + * notifiers will be unregistered. It is, however, strongly recommended =
to not
> + * rely on this behavior, and instead the party registring the notifier =
should

registering

> + * unregister it before the controller gets shut down, e.g. via the SSAM=
 bus
> + * which guarantees client devices to be removed before a shutdown.

> + * Note that events may still be pending after this call, but due to the
> + * notifiers being unregistered, the will be dropped when the controller=
 is

the?!

> + * subsequently being destroyed via ssam_controller_destroy().

...

> + * Ensures that all resources associated with the controller get freed. =
This
> + * function should only be called after the controller has been stopped =
via
> + * ssam_controller_shutdown(). In general, this function should not be c=
alled
> + * directly. The only valid place to call this function direclty is duri=
ng

directly

> + * initialization, before the controller has been fully initialized and =
passed
> + * to other processes. This function is called automatically when the
> + * reference count of the controller reaches zero.

...

> + * ssam_request_sync_free() - Free a synchronous request.
> + * @rqst: The request to free.

to be freed?

...

> + * Allocates a synchronous request struct on the stack, fully initialize=
s it
> + * using the provided buffer as message data buffer, submits it, and the=
n
> + * waits for its completion before returning its staus. The

status

> + * SSH_COMMAND_MESSAGE_LENGTH() macro can be used to compute the require=
d
> + * message buffer size.

...

> + * This is a wrapper for the raw SAM request to enable an event, thus it=
 does
> + * not handle referecnce counting for enable/disable of events. If an ev=
ent
> + * has already been enabled, the EC will ignore this request.

Grammar and English language style somehow feels not okay.

...

> +       u8 buf[1] =3D { 0x00 };

Can't be simply buf ?

...

> + * This function will only send the display-off notification command if
> + * display noticications are supported by the EC. Currently all known de=
vices
> + * support these notification.

Spell check!

...

> + * This function will only send the display-on notification command if d=
isplay
> + * noticications are supported by the EC. Currently all known devices su=
pport
> + * these notification.

Ditto.

...

> +               ssam_err(ctrl, "unexpected response from D0-exit notifica=
tion:"
> +                        " 0x%02x\n", response);

Don't split string literals. Had you run a checkpatch?
Please do and use strict mode.


...

Overall impression of this submission:
 - it's quite huge as for a single patch
 - it feels like quite an overengineered solution: READ_ONCE, RCU,
list + spin_lock, RB tree of notifiers, my head!
 - where is the architectural document of all these?

--=20
With Best Regards,
Andy Shevchenko
