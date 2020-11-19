Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891512B971C
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgKSPyw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 10:54:52 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:52076 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgKSPyv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 10:54:51 -0500
Date:   Thu, 19 Nov 2020 15:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605801283;
        bh=uPFS/bith9eLfCXdncjLAJYXYB1yBuSfgX40JHCMxy8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=lCFtUxqHCZQeajy8m8Oeq8do4XsaMokfOM+V1of2jT7llUm6RuZ3fSPXVvL+y6aTP
         YB2Wxy4mvvVunYs4G6VqS4p75/DbwrM1EhY7c90BF7y7rpxqbUejhk+rruHa2H/KLu
         J1QH3nbe/IOhXsr53jkg+Of86Q+qak1SCt5yWR2I=
To:     Maximilian Luz <luzmaximilian@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?utf-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
Message-ID: <5Qk-wNPtfpjNiK7HHId4qBNTWj9K_2h7fNe15o2J80gZsrSOfVYoKzdzPE8-r3NT7PLjxIgx08YLv2s38CWROho_womMqN2yGl3v13dJlMg=@protonmail.com>
In-Reply-To: <68af3474-b576-da7e-2b11-3aa4c319cceb@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com> <20201115192143.21571-2-luzmaximilian@gmail.com> <nJyowYoxGM_0dU6iqDLowrPuVIErZbgZLAkXASFlEKvvSkgGtLxGQ7wGFDpXAaqAc3wourELsji6s3lO7N4aHOb8sK0wI500Oq5ZMdeZwJ8=@protonmail.com> <68af3474-b576-da7e-2b11-3aa4c319cceb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi


2020. november 19., cs=C3=BCt=C3=B6rt=C3=B6k 0:06 keltez=C3=A9ssel, Maximil=
ian Luz <luzmaximilian@gmail.com> =C3=ADrta:

> [...]

> >> +/**
> >> + * ssam_nf_head_destroy() - Deinitialize the given notifier head.
> >> + * @nh: The notifier head to deinitialize.
> >> + */
> >> +static void ssam_nf_head_destroy(struct ssam_nf_head *nh)
> >> +{
> >> +=09cleanup_srcu_struct(&nh->srcu);
> >> +}
> >
> > I'm also wondering if there's any reason why these static one-liner fun=
ctions are
> > not explicitly marked inline.
>
> Isn't inline more of a linkage keyword at this point? I fully expect any
> compiler to inline things like this automatically at the first hint of
> an optimization flag.
>

I also expect the compiler to inline such functions even without the `inlin=
e`
specifier. In retrospect I'm not sure why I actually made this comment, pos=
sibly
because of my preference, but I believe it's fine either way, so my comment=
 is
moot, sorry.


> [...]

> >> + * error values via ssam_notifier_from_errno() to notifier values.
> >> + *
> >> + * Also note that any callback that could handle an event should retu=
rn a value
> >> + * with bit %SSAM_NOTIF_HANDLED set, indicating that the event does n=
ot go
> >> + * unhandled/ignored. In case no registered callback could handle an =
event,
> >> + * this function will emit a warning.
> >> + *
> >> + * In case a callback failed, this function will emit an error messag=
e.
> >> + */
> >> +static void ssam_nf_call(struct ssam_nf *nf, struct device *dev, u16 =
rqid,
> >> +=09=09=09 struct ssam_event *event)
> >> +{
> >> +=09struct ssam_nf_head *nf_head;
> >> +=09int status, nf_ret;
> >> +
> >> +=09if (!ssh_rqid_is_event(rqid)) {
> >> +=09=09dev_warn(dev, "event: unsupported rqid: 0x%04x\n", rqid);
> >
> > A small note, "%#04x" would insert the "0x" prefix.
>
> Oh neat, didn't know that. Should be "%#06x" though, right?
>

Yes, indeed, sorry, it should be "%#06x".


> [...]

> >> +static int ssam_controller_caps_load_from_acpi(
> >> +=09=09acpi_handle handle, struct ssam_controller_caps *caps)
> >> +{
> >> +=09u32 d3_closes_handle =3D false;
> >
> > Assinging a boolean like this to a `u32` looks very odd to me.
>
> The value returned by the corresponding DSM call is an integer, but
> essentially only contains a bool value (zero vs. one). I thought using
> false here explicitly for initialization helps clarify that. That also
> makes it consistent with the "caps->d3_closes_handle =3D false" line
> below.
>

Although I still find it pretty odd, your explanation makes sense to me.


> >> +int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
> >> +=09=09=09    struct ssam_request_sync **rqst,
> >> +=09=09=09    struct ssam_span *buffer)
> >> +{
> >> +=09size_t msglen =3D SSH_COMMAND_MESSAGE_LENGTH(payload_len);
> >> +
> >> +=09*rqst =3D kzalloc(sizeof(**rqst) + msglen, flags);
> >> +=09if (!*rqst)
> >> +=09=09return -ENOMEM;
> >> +
> >> +=09buffer->ptr =3D (u8 *)(*rqst + 1);
> >> +=09buffer->len =3D msglen;
> >> +
> >> +=09return 0;
> >> +}
> >
> > I think there is a bit of incosistency: sometimes you use ** pointer + =
return int,
> > sometimes you return a pointer with potentially embedded errno. I think=
 it would
> > be better if you stuck with one or the other.
>
> My rule of thumb is: If it's one output parameter, use a pointer as
> return value. If it's two or more output parameters (as in this case,
> "buffer" is written to), use two pointer arguments and an int as return.
>
> I noticed that ssam_client_bind doesn't follow that scheme so I'll
> change that.
>

I see, thanks for the explanation, what prompted me to make this comment
was that, as you noted, there were functions with one output parameter that
were not consistent.


> [...]

> >> + * Note that the packet completion callback is, in case of success an=
d for a
> >> + * sequenced packet, guaranteed to run on the receiver thread, thus p=
roviding
> >> + * a way to reliably identify responses to the packet. The packet com=
pletion
> >> + * callback is only run once and it does not indicate that the packet=
 has
> >> + * fully left the system (for this, one should rely on the release me=
thod,
> >> + * triggered when the reference count of the packet reaches zero). In=
 case of
> >> + * re-submission (and with somewhat unlikely timing), it may be possi=
ble that
> >> + * the packet is being re-transmitted while the completion callback r=
uns.
> >> + * Completion will occur both on success and internal error, as well =
as when
> >> + * the packet is canceled.
> >
> > If I understand it correctly, it is possible that submission of a packe=
t fails
> > for the first time, but it's scheduled for resubmission, and this retra=
nsmission
> > happens at the same time when the complete() callback is called. If tha=
t's the
> > case, then the callback is called with an error condition, no? Thus it =
is possible
> > that a packet is successfully submitted (for the second, third, etc. ti=
me), but the
> > complete() callback receives notification about failure? Or am I missin=
g something?
>
> Not sure I can follow you here. What do you mean by "fails for the first =
time"?
>
> A couple of notes before I try to explain the error cases:
>
>   - Resubmission only happens on timeout or NAK.
>
>   - Only sequenced packets can be resubmitted (unsequenced are not added
>     to the pending set, thus do not have a packet timeout and do not
>     react to NAKs).
>
>   - Completion means the packet gets locked, which prevents it from being
>     resubmitted and retransmitted, and is removed from all collections.
>
>   - Completion cannot be triggered by NAK. In case a NAK is received and
>     all tries have been exceeded, the packet still waits for the timeout
>     (or ACK, whatever happens first) one last time.
>
> The error cases:
>
>   - serdev: Failure to send via serdev results in immediate completion
>     with error on the transmitter thread. Due to a NAK (or a _very_
>     unlikely timeout), the packet can be queued for a second time at that
>     point, but, as completion runs on the transmitter thread in this
>     case, the packet is removed from the queue before the thread goes on
>     to get the next packet.
>
>   - Timeout: On resubmission, the timeout of a packet is disabled. It is
>     (re-)armed directly before starting transmission on the transmitter
>     thread.
>
>     What _could_ now happen is that, for some reason, the transmitter
>     thread waits the full timeout period between arming the timeout and
>     actually sending it (which I'd consider highly unlikely). Note that
>     "actually sending it" includes whatever asynchronous stuff the serdev
>     core does after serdev_device_write_buf() returns.
>
>     In that case, the packet can be transmitted _after_ it has received a
>     timeout. So assuming this is the last try, then the packet can be
>     sent after completion with -ETIMEDOUT.
>
>     I believe this is what you meant?
>

Yes, that's what I meant, thanks for the clarification and broader explanat=
ion
about the things at play here.


>     Again, I consider this highly unlikely as this would require either
>     the scheduler to pause our thread for a full timeout period or
>     require the serdev core to basically do nothing for a full timeout
>     period. I'd argue this is a lot less likely than a dropped ACK packet
>     from the EC (which results in the same thing: EC receives data but we
>     think it didn't, causing a timeout error).
>
>     Note that putting the timeout (re-)arming step after the last call to
>     serdev_device_write_buf() doesn't really help either, as that only
>     writes to the transport buffer. If we would want to guarantee that
>     this doesn't happen, we'd have to explicitly wait for the hardware to
>     finish transmitting, which essentially breaks the whole point of
>     buffering.
>
>     Also I prefer to have the timeout cover the transmission part as
>     well. In the very least, this simplifies reasoning about it once I've
>     restricted it to be (re-)set under the pending lock only (as
>     mentioned in the message to Andy).
>
>   - Finally, there is completion by cancellation or shutdown, for which
>     the packet can have been (or currently be) transmitted successfully
>     but completion returns with -ECANCELLED or -ESHUTDOWN, respectively.
>     This is the expected behavior in those cases. Again, the completion
>     procedure takes care of locking the packet and removing all
>     references from the collections.
>
> Also there's one success case, when we receive an ACK after a timeout
> and during the re-transmission. Then the packet is completed with
> success, but might still be transmitted once more. The EC should detect
> that packet as re-submission via its packet ID and ignore it.
>
> >> [...]
> >
> >> +int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
> >> +{
> >> +=09int used;
> >> +
> >> +=09if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
> >> +=09=09return -ESHUTDOWN;
> >> +
> >> +=09used =3D kfifo_in(&ptl->rx.fifo, buf, n);
> >
> > Isn't it possible that `n` is greater than the free space in the fifo? =
What
> > happens then?
>
> If I've read the documentation of kfifo_in() right, it takes at most n
> elements. If n is greater than the free space, it will only take as much
> elements as it has space. The return value of kfifo_in() is the number
> of elements actually consumed. We simply return that here (as elements =
=3D
> bytes) and ultimately let the serdev/tty core take care of handling
> that.
>

Ahh, sorry, you're right.



> >> +=09if (used)
> >> +=09=09ssh_ptl_rx_wakeup(ptl);
> >> +
> >> +=09return used;
> >> +}


> [...]

> >> +=09=09=09 ((struct ssh_frame *)sf.ptr)->len);
> >
> > Why isn't `get_unaligned_le16()` used here? (Or simply even `sp.len`.)
>
> This should actually be "sp.len + SSH_MESSAGE_LENGTH(0)", and also
> format spezifier %zu with that as SSH_MESSAGE_LENGTH returns size_t.
>

Yes, indeed, sorry, I missed the `+ SSH_MESSAGE_LENGTH(0)` part.


> >> +=09=09return -EMSGSIZE;
> >> +=09}
> >> [...]
> >> +=09*frame =3D (struct ssh_frame *)sf.ptr;
> >
> > This also violates strict aliasing.
>
> Sure, the whole point of this function (and ssh_parse_command below) is
> to get pointers to the data structures in the given buffer, i.e. create
> aliases of the right types to the right places in the buffer. Not sure
> how I'd do that differently, apart from copying.
>
> I think that this would even work properly (in practice) without setting
> -fno-strict-aliasing, as all data at this point is effectively
> read-only. Furthermore, after the call access is restricted to the
> non-aliasing parts respectively (frame and payload), whereas the
> underlying buffer they do alias isn't accessed for the rest of that
> scope (i.e. until the other references don't exist any more).
>
> Anyway, as far as I know the kernel is built with -fno-strict-aliasing.
> Please correct me if I'm wrong or relying on aliasing is frowned upon.
>

I don't believe it could cause issue here, I just wanted to note it.


> [...]

> >> +enum ssam_ssh_tc {
> >> +=09/* Known SSH/EC target categories. */
> >> +=09=09=09=09// category 0x00 is invalid for EC use
> >> +=09SSAM_SSH_TC_SAM =3D 0x01,=09// generic system functionality, real-=
time clock
> >> +=09SSAM_SSH_TC_BAT =3D 0x02,=09// battery/power subsystem
> >> +=09SSAM_SSH_TC_TMP =3D 0x03,=09// thermal subsystem
> >> +=09SSAM_SSH_TC_PMC =3D 0x04,
> >> +=09SSAM_SSH_TC_FAN =3D 0x05,
> >> +=09SSAM_SSH_TC_PoM =3D 0x06,
> >> +=09SSAM_SSH_TC_DBG =3D 0x07,
> >> +=09SSAM_SSH_TC_KBD =3D 0x08,=09// legacy keyboard (Laptop 1/2)
> >> +=09SSAM_SSH_TC_FWU =3D 0x09,
> >> +=09SSAM_SSH_TC_UNI =3D 0x0a,
> >> +=09SSAM_SSH_TC_LPC =3D 0x0b,
> >> +=09SSAM_SSH_TC_TCL =3D 0x0c,
> >> +=09SSAM_SSH_TC_SFL =3D 0x0d,
> >> +=09SSAM_SSH_TC_KIP =3D 0x0e,
> >> +=09SSAM_SSH_TC_EXT =3D 0x0f,
> >> +=09SSAM_SSH_TC_BLD =3D 0x10,
> >> +=09SSAM_SSH_TC_BAS =3D 0x11,=09// detachment system (Surface Book 2/3=
)
> >> +=09SSAM_SSH_TC_SEN =3D 0x12,
> >> +=09SSAM_SSH_TC_SRQ =3D 0x13,
> >> +=09SSAM_SSH_TC_MCU =3D 0x14,
> >> +=09SSAM_SSH_TC_HID =3D 0x15,=09// generic HID input subsystem
> >> +=09SSAM_SSH_TC_TCH =3D 0x16,
> >> +=09SSAM_SSH_TC_BKL =3D 0x17,
> >> +=09SSAM_SSH_TC_TAM =3D 0x18,
> >> +=09SSAM_SSH_TC_ACC =3D 0x19,
> >> +=09SSAM_SSH_TC_UFI =3D 0x1a,
> >> +=09SSAM_SSH_TC_USC =3D 0x1b,
> >> +=09SSAM_SSH_TC_PEN =3D 0x1c,
> >> +=09SSAM_SSH_TC_VID =3D 0x1d,
> >> +=09SSAM_SSH_TC_AUD =3D 0x1e,
> >> +=09SSAM_SSH_TC_SMC =3D 0x1f,
> >> +=09SSAM_SSH_TC_KPD =3D 0x20,
> >> +=09SSAM_SSH_TC_REG =3D 0x21,
> >> +};
> >
> > Is it known what these abbreviations stand for? Maybe I missed them?
>
> The comments state all we really know about these (through observation
> and experimentation). The table itself has been extracted from the
> Windows driver, but the abbreviations and values are all we're getting
> from it.

I see, thanks for the clarification. For some reason, I believed the
"Known SSH/EC target categories" comment means that those are known, as in,
it is known what they are for, etc., not just the abbreviation.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
