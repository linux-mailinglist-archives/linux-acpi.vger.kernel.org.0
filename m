Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00D2B4C0E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgKPRDo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbgKPRDn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 12:03:43 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA90C0613CF;
        Mon, 16 Nov 2020 09:03:42 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id me8so25427170ejb.10;
        Mon, 16 Nov 2020 09:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdnMZg75Rv+Uq14s89lBvi6kFXxh938HRsQU8MB5ALc=;
        b=fvVuXx796TPJR1O24JKvF+ibusBuahEvutSE0RG1hc9B/OS3VhpYHackCPS6zmCIrI
         +cXVys/RAMl9wRlRyqzxc4K7frkhQYJai1dHKJvlPO+5W2olxunHMFQtsi1dYsaH9n3h
         4AmEON8LtvEd/jYGH/n5Lvzq52mTSQ8RjY0Y7Mvuwk4fqhjom7F5kpSjkl3JX0sfbvIq
         gwQEBxFq5AK3jCy2c5n7tgOh62yF6PNfGjwFXLbu7E5LoZs3O7O42flXsp7oFPzh8Zwc
         I5mc7mpOuzNAsPM8prTTkSCvSFGoBKzIo2JclCW0igqRUNeAGuQa0lTYjB6XX5ohMSvh
         xXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdnMZg75Rv+Uq14s89lBvi6kFXxh938HRsQU8MB5ALc=;
        b=ITWRH6a9yEZE9RiFLV/NvZNLFjZmKkSEIWsDyOZQ/Vre5DQ8/sgD3pb3qtRslppsc1
         WJxYnGfICPaEB2/L2tE+J4Dm6TP1UMrJ2IK8Efm5kIK2qwFXKlEfhMt9+k5AwV5w1EB5
         +0dSyLz1f6TG4YnU9/IqVUDMDlJaolDAWO/ZG7VoL9Lmt+0HZcVlj0Y1JnbbvH/sdcWG
         GNtuVq4inKciARpuydPW+AUlx9QlLbp76dVcrukJf2zx9vj6uwKcUr2PIqlSE811DP8M
         gjI3J5G/qrjY7PuoZHFTW+OVE0dj/B7Dc9H1QQvV+21CTUNCVshrcqBCrjxK6946GOjf
         6ySQ==
X-Gm-Message-State: AOAM5316py93HNTs0zPOCk9r1F5JAgTNw5Vzjo2zqv38qh/PZEqygcQz
        OnRBF/mY9ZLaN9/HS218CM9eD0n+Glw=
X-Google-Smtp-Source: ABdhPJyi/VGG5faJetBPopwxhNX7YKfaoOkRIIDsTKw3Rd3At3VGYMFnC257EryQ98IjyU2DpOk17A==
X-Received: by 2002:a17:906:c8d8:: with SMTP id gc24mr16000911ejb.417.1605546220279;
        Mon, 16 Nov 2020 09:03:40 -0800 (PST)
Received: from [192.168.2.202] (pd9ea31c2.dip0.t-ipconnect.de. [217.234.49.194])
        by smtp.gmail.com with ESMTPSA id f19sm11056135edm.70.2020.11.16.09.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:03:39 -0800 (PST)
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-2-luzmaximilian@gmail.com>
 <CAHp75VdOnUW6kftkD1zGR345fJUPPv9zfi0YitYJOb1BPxQcPw@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <8768d422-15f1-9fa3-481f-53be8549c395@gmail.com>
Date:   Mon, 16 Nov 2020 18:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOnUW6kftkD1zGR345fJUPPv9zfi0YitYJOb1BPxQcPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/16/20 2:33 PM, Andy Shevchenko wrote:
> On Sun, Nov 15, 2020 at 9:25 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> Add Surface System Aggregator Module core and Surface Serial Hub driver,
>> required for the embedded controller found on Microsoft Surface devices.
>>
>> The Surface System Aggregator Module (SSAM, SAM or Surface Aggregator)
>> is an embedded controller (EC) found on 4th and later generation
>> Microsoft Surface devices, with the exception of the Surface Go series.
>> This EC provides various functionality, depending on the device in
>> question. This can include battery status and thermal reporting (5th and
>> later generations), but also HID keyboard (6th+) and touchpad input
>> (7th+) on Surface Laptop and Surface Book 3 series devices.
>>
>> This patch provides the basic necessities for communication with the SAM
>> EC on 5th and later generation devices. On these devices, the EC
>> provides an interface that acts as serial device, called the Surface
>> Serial Hub (SSH). 4th generation devices, on which the EC interface is
>> provided via an HID-over-I2C device, are not supported by this patch.
>>
>> Specifically, this patch adds a driver for the SSH device (device HID
>> MSHW0084 in ACPI), as well as a controller structure and associated API.
>> This represents the functional core of the Surface Aggregator kernel
>> subsystem, introduced with this patch, and will be expanded upon in
>> subsequent commits.
>>
>> The SSH driver acts as the main attachment point for this subsystem and
>> sets-up and manages the controller structure. The controller in turn
>> provides a basic communication interface, allowing to send requests from
>> host to EC and receiving the corresponding responses, as well as
>> managing and receiving events, sent from EC to host. It is structured
>> into multiple layers, with the top layer presenting the API used by
>> other kernel drivers and the lower layers modeled after the serial
>> protocol used for communication.
>>
>> Said other drivers are then responsible for providing the (Surface model
>> specific) functionality accessible through the EC (e.g. battery status
>> reporting, thermal information, ...) via said controller structure and
>> API, and will be added in future commits.
> 
> ...
> 
>> +menuconfig SURFACE_AGGREGATOR
>> +       tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
>> +       depends on SERIAL_DEV_BUS
>> +       depends on ACPI
>> +       select CRC_CCITT
>> +       help
>> +         The Surface System Aggregator Module (Surface SAM or SSAM) is an
>> +         embedded controller (EC) found on 5th- and later-generation Microsoft
>> +         Surface devices (i.e. Surface Pro 5, Surface Book 2, Surface Laptop,
>> +         and newer, with exception of Surface Go series devices).
>> +
>> +         Depending on the device in question, this EC provides varying
>> +         functionality, including:
>> +         - EC access from ACPI via Surface ACPI Notify (5th- and 6th-generation)
>> +         - battery status information (all devices)
>> +         - thermal sensor access (all devices)
>> +         - performance mode / cooling mode control (all devices)
>> +         - clipboard detachment system control (Surface Book 2 and 3)
>> +         - HID / keyboard input (Surface Laptops, Surface Book 3)
>> +
>> +         This option controls whether the Surface SAM subsystem core will be
>> +         built. This includes a driver for the Surface Serial Hub (SSH), which
>> +         is the device responsible for the communication with the EC, and a
>> +         basic kernel interface exposing the EC functionality to other client
>> +         drivers, i.e. allowing them to make requests to the EC and receive
>> +         events from it. Selecting this option alone will not provide any
>> +         client drivers and therefore no functionality beyond the in-kernel
>> +         interface. Said functionality is the responsibility of the respective
>> +         client drivers.
>> +
>> +         Note: While 4th-generation Surface devices also make use of a SAM EC,
>> +         due to a difference in the communication interface of the controller,
>> +         only 5th and later generations are currently supported. Specifically,
>> +         devices using SAM-over-SSH are supported, whereas devices using
>> +         SAM-over-HID, which is used on the 4th generation, are currently not
>> +         supported.
> 
>  From this help text I didn't get if it will be a module or what if I
> chose the above?

I thought this would be implied by the tristate options. So should I
simply add something like

     Choose m if you want to build the SAM subsystem core and SSH driver
     as module, y if you want to build it into the kernel and n if you
     don't want it at all.

> ...
> 
>> +/* -- Safe counters. -------------------------------------------------------- */
> 
> Why can't XArray be used here?

These are basically packet and request IDs (that are sent to the EC and
received from it). XArray is a type of collection. I'm not sure how this
would work.

What happens is: For each new packet/request we get a new ID by
incrementing the counter (with wrap-around). This ID is used, for
example, to match ACK-packets to the corresponding data packet. The EC
will also use this to detect re-transmission, e.g. if we send two
packets with the same ID in sequence, the EC will detect the second
packet as re-transmission of the first one (which is the reason why
simple IDA won't work).

Furthermore, both the Windows driver and the EC itself (for packets sent
by it) use wrapping counters as well, so it seems to be the safest way
to do this without possibly triggering re-transmission detection by
accident.

> ...
> 
>> +
>> +
> 
> One blank line is enough
> 

Can I keep two blank lines for the section separator comments?

> ...
> 
>> +static bool ssam_event_matches_notifier(
>> +               const struct ssam_event_notifier *notif,
>> +               const struct ssam_event *event)
> 
> Perhaps
> 
> static bool
> ssam_event_matches_notifier(const struct ssam_event_notifier *n,
>                 const struct ssam_event *event)
> 
> (or even switch to 100 limit, also note notif ->n — no need to repeat same word)

Ack.

> ...
> 
>> +       nb = rcu_dereference_raw(nh->head);
>> +       while (nb) {
>> +               nf = container_of(nb, struct ssam_event_notifier, base);
>> +               next_nb = rcu_dereference_raw(nb->next);
>> +
>> +               if (ssam_event_matches_notifier(nf, event)) {
>> +                       ret = (ret & SSAM_NOTIF_STATE_MASK) | nb->fn(nf, event);
>> +                       if (ret & SSAM_NOTIF_STOP)
>> +                               break;
> 
> The returned value is a bitmask?!

In part, yes. I've referred to this as the "notifier status value" in
the (function) documentation. This is basically

     | bit 0       | bit 1    | bit 2 to 31         |
     +-------------+----------+---------------------+
     | handled-bit | stop-bit | error-value or zero |

The ssam_notifier_to_errno() function can be used to convert an error
value to this notifier status value. This is the same as the return
value of the notifier function and is described a bit better in the
documentation of struct ssam_notifier_block.

> What are you returning at the end?

The notifier status value as described above. This can be tested for the
SSAM_NOTIF_HANDLED and SSAM_NOTIF_STOP bits. The error value can, as
mentioned in the documentation, be extracted via
ssam_notifier_to_errno().

All in all, this is based on notifier_call_chain() and SRCU notifiers
(linux/notifier.h, kernel/notifier.c) in general, with the key
difference that it includes a bit to indicate if the notification has
been handled (or detect if it goes unhandled).

> 
>> +               }
>> +
>> +               nb = next_nb;
>> +       }
> 
> ...
> 
>> +static int __ssam_nfblk_insert(struct ssam_nf_head *nh, struct ssam_notifier_block *nb)
>> +{
>> +       struct ssam_notifier_block **link = &nh->head;
>> +
>> +       while ((*link) != NULL) {
>> +               if (unlikely((*link) == nb)) {
>> +                       WARN(1, "double register detected");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (nb->priority > (*link)->priority)
>> +                       break;
>> +
>> +               link = &((*link)->next);
>> +       }
>> +
>> +       nb->next = *link;
>> +       rcu_assign_pointer(*link, nb);
>> +
>> +       return 0;
>> +}
> 
> If you need RCU (which is also the Q per se), why not use RCU list?

This part has been mostly copied and adapted from
notifier_chain_register(), which uses the exact same mechanism. I can
change it to use RCU list primitives if that's preferred.

> ...
> 
>> +       while ((*link) != NULL) {
> 
> Redundant parentheses, redundant ' != NULL' part.

Ack.

> 
>> +               if ((*link) == nb)
>> +                       return link;
>> +
>> +               link = &((*link)->next);
>> +       }
> 
> ...
> 
>> + * struct ssam_nf_refcount_entry - RB-tree entry for referecnce counting event
> 
> In above you mistyped 'which' as 'whic' or so, and here reference.
> Perhaps go thru spell checker?

Ack. I'll do that.

> 
> ...
> 
>> + * registered, or ``ERR_PTR(-ENOMEM)`` if the entry could not be allocated.
> 
> Better to spell out "error pointer" instead of cryptic ERR_PTR().

Ack.

> 
> ...
> 
>> + * Executa registered callbacks in order of their priority until either no
>> + * callback is left or a callback returned a value with the %SSAM_NOTIF_STOP
> 
> returns

Ack.

> 
>> + * bit set. Note that this bit is set automatically when converting non.zero
>> + * error values via ssam_notifier_from_errno() to notifier values.
> 
> ...
> 
>> +               for (i = i - 1; i >= 0; i--)
> 
> while (i--)

Ack.

> 
>> +                       ssam_nf_head_destroy(&nf->head[i]);
> 
> ...
> 
>> +       // limit number of processed events to avoid livelocking
>> +       for (i = 0; i < 10; i++) {
> 
> Magic number! Also, this will be better to read in a form of
> 
> unsigned int iterations = 10;
> 
> do {
> ...
> } while (--iterations);

Okay.

> 
>> +               item = ssam_event_queue_pop(queue);
>> +               if (item == NULL)
>> +                       return;
>> +
>> +               ssam_nf_call(nf, dev, item->rqid, &item->event);
>> +               kfree(item);
>> +       }
> 
> ...
> 
>> +static const guid_t SSAM_SSH_DSM_GUID = GUID_INIT(0xd5e383e1, 0xd892, 0x4a76,
>> +               0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);
> 
> Can you use usual pattern for these UIDs, like
> static const guid_t SSAM_SSH_DSM_GUID =
>          GUID_INIT(0xd5e383e1, 0xd892, 0x4a76,
>                   0x89, 0xfc, 0xf6, 0xaa, 0xae, 0x7e, 0xd5, 0xb5);
> ?
> 
> Also put a comment how this UID will look like in a string representation.

Will change that.

> 
> ...
> 
>> +       if (!acpi_has_method(handle, "_DSM"))
>> +               return 0;
> 
> Hmm... What's the expectation?

Depends on the device. Old devices don't have that _DSM (thus fallback
to defaults), newer devices do have it.

> 
>> +       obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
>> +                                     SSAM_SSH_DSM_REVISION, 0, NULL,
>> +                                     ACPI_TYPE_BUFFER);
>> +       if (!obj)
>> +               return -EFAULT;
> 
> EFAULT?! Perhaps you can simply return 0 here, no?

I'd prefer returning an error (_DSM index 0 should always be present and
return a buffer), but I agree that EFAULT is probably the wrong one.

> 
>> +       for (i = 0; i < obj->buffer.length && i < 8; i++)
>> +               mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
> 
> Don't we have some helpers for this? At least I remember similar code
> went to one of PDx86 drivers like intel-vbtn or so.

There is acpi_check_dsm(), which checks if a single function is
supported, but as far as I can tell no helper that returns a bitmask of
all supported functions. I can change it to use acpi_check_dsm() in
ssam_dsm_load_u32() though.

> 
>> +       if (mask & 0x01)
> 
> BIT(0) ?

BIT(0) looks better, ack.

> 
>> +               *funcs = mask;
> 
> ...
> 
>> +       caps->ssh_power_profile = (u32)-1;
>> +       caps->screen_on_sleep_idle_timeout = (u32)-1;
>> +       caps->screen_off_sleep_idle_timeout = (u32)-1;
>> +       caps->d3_closes_handle = false;
>> +       caps->ssh_buffer_size = (u32)-1;
> 
> Use proper types and their limits (limits.h missed?).

Okay.

> 
> ...
> 
>> +       // initialize request and packet transport layers
> 
> Inconsistent style of comments.

Will change that.

> 
> ...
> 
>> + * In the course of this shutdown procedure, all currently registered
>> + * notifiers will be unregistered. It is, however, strongly recommended to not
>> + * rely on this behavior, and instead the party registring the notifier should
> 
> registering

Ack.

> 
>> + * unregister it before the controller gets shut down, e.g. via the SSAM bus
>> + * which guarantees client devices to be removed before a shutdown.
> 
>> + * Note that events may still be pending after this call, but due to the
>> + * notifiers being unregistered, the will be dropped when the controller is
> 
> the?!

Should be "the events".

> 
>> + * subsequently being destroyed via ssam_controller_destroy().
> 
> ...
> 
>> + * Ensures that all resources associated with the controller get freed. This
>> + * function should only be called after the controller has been stopped via
>> + * ssam_controller_shutdown(). In general, this function should not be called
>> + * directly. The only valid place to call this function direclty is during
> 
> directly

Ack.

> 
>> + * initialization, before the controller has been fully initialized and passed
>> + * to other processes. This function is called automatically when the
>> + * reference count of the controller reaches zero.
> 
> ...
> 
>> + * ssam_request_sync_free() - Free a synchronous request.
>> + * @rqst: The request to free.
> 
> to be freed?

I think both should be grammatically correct, but I'll change it.

> 
> ...
> 
>> + * Allocates a synchronous request struct on the stack, fully initializes it
>> + * using the provided buffer as message data buffer, submits it, and then
>> + * waits for its completion before returning its staus. The
> 
> status

Ack.

> 
>> + * SSH_COMMAND_MESSAGE_LENGTH() macro can be used to compute the required
>> + * message buffer size.
> 
> ...
> 
>> + * This is a wrapper for the raw SAM request to enable an event, thus it does
>> + * not handle referecnce counting for enable/disable of events. If an event
>> + * has already been enabled, the EC will ignore this request.
> 
> Grammar and English language style somehow feels not okay.

I'll try to reword that. I agree that this feels a bit off.

> 
> ...
> 
>> +       u8 buf[1] = { 0x00 };
> 
> Can't be simply buf ?

It can be, I'll change that

> 
> ...
> 
>> + * This function will only send the display-off notification command if
>> + * display noticications are supported by the EC. Currently all known devices
>> + * support these notification.
> 
> Spell check!

Will do that.

> 
> ...
> 
>> + * This function will only send the display-on notification command if display
>> + * noticications are supported by the EC. Currently all known devices support
>> + * these notification.
> 
> Ditto.

Ack.

> 
> ...
> 
>> +               ssam_err(ctrl, "unexpected response from D0-exit notification:"
>> +                        " 0x%02x\n", response);
> 
> Don't split string literals. Had you run a checkpatch?
> Please do and use strict mode.

I did run checkpatch, however, I decided to split strings as some of
them are a bit long. When doing that, I only split at places where I
personally wouldn't expect a grep to succeed for, e.g. before or after
format specifiers. I though that this is okay as the main reason for
"don't split string literals" is searchability.

> 
> 
> ...
> 
> Overall impression of this submission:
>   - it's quite huge as for a single patch

I tried to split it into parts, but this is the smallest I've been able
to get it while also keeping it a functional unit.

>   - it feels like quite an overengineered solution: READ_ONCE, RCU,
> list + spin_lock, RB tree of notifiers, my head!

Sorry about any headaches. My main goal was stability and reliability,
while keeping things somewhat performant and generic.

The "generic" part mostly because this whole thing is based on
reverse-engineering, and I believe that makes it easier to correct for
things that we got wrong, e.g. in what we think the protocol looks like.

Packet state is tracked via atomic flags (which is also laid out in a
comment), and is the simplest solution I found to track that. I found
that a simple enum based state will complicate things as the driver has
to support and properly handle re-submission of packets.

READ_ONCE and WRITE_ONCE are used to ensure proper access to state that
can be changed outside of the queue/pending locks (or under any one of
them). In general, I have tried to document all critical access of such
state with an explanation of why it is safe to do so.

RCU is only used for notifier callbacks, which is based on the SRCU
notifiers from linux/notifier.h and kernel/notifier.c, but adapted to
detect unhandled events.

While it is somewhat interwoven, the (RCU-based) notifier chain stores
the notifiers (one chain per target category) and the RB-tree stores the
number of times an event has been enabled. Essentially, those should be
seen as two separate parts (see e.g. documentation of struct ssam_nf,
which brings those two together).

So the RB-tree is not for notifiers, but for tracking which events are
enabled. Basically reference-counting for enabled events, as the EC
itself only allows turning them on/off. It's necessary to do that as
there can be multiple clients listening to the same event. It's also
required to do this with some sort of map, as (in context of
enabling/disabling) the events are uniquely identified by both their
registry and ID. This combination is a bit too complex to do that with a
simple array, so a RB-tree looked like the best solution.

Note that we store notifiers per target category only, so for that we
can use a simple array.

>   - where is the architectural document of all these?

What specifically do you want to see documented? I've documented the
basic communication and principles in another patch of this series, but
kept implementation details somewhat vague as I think those are better
covered by struct and function documentation (which won't become
outdated as easily as a separate documentation).

Thank you for your comments.

Regards,
Max
