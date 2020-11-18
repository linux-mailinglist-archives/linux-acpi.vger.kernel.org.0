Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398652B7312
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 01:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKRA3I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 19:29:08 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:41490 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgKRA3I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 19:29:08 -0500
Date:   Wed, 18 Nov 2020 00:28:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605659339;
        bh=pehkG8G4iQ09Ck3PVtlnkmAhnULy/yPsdZZK2bwvpQE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=e1mHoG4tk4d9XEZE3KbUk5H+HR/D68pV8v9BvAGf6trbAhJRWm+hIpJG16UXOEziz
         lP7KtMPttNB+Ezz71RbvnEy/Hour89EP290I9j2x17C99RN2cnpjUIPVTtmXzj/CQr
         NzW3NmhDvH7qEmnF7SBktyHdeTHsyPsEdLqkA9HA=
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
Message-ID: <nJyowYoxGM_0dU6iqDLowrPuVIErZbgZLAkXASFlEKvvSkgGtLxGQ7wGFDpXAaqAc3wourELsji6s3lO7N4aHOb8sK0wI500Oq5ZMdeZwJ8=@protonmail.com>
In-Reply-To: <20201115192143.21571-2-luzmaximilian@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com> <20201115192143.21571-2-luzmaximilian@gmail.com>
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

I have attached some thoughts and comments inline.


2020. november 15., vas=C3=A1rnap 20:21 keltez=C3=A9ssel, Maximilian Luz =
=C3=ADrta:

> [...]
> +/* -- Event notifier/callbacks. ----------------------------------------=
----- */
> +/*
> + * The notifier system is based on linux/notifier.h, specifically the SR=
CU
> + * implementation. The difference to that is, that some bits of the noti=
fier
> + * call return value can be tracked across multiple calls. This is done =
so that
> + * handling of events can be tracked and a warning can be issued in case=
 an
> + * event goes unhandled. The idea of that waring is that it should help =
discover
                                                ^
"warning"


> + * and identify new/currently unimplemented features.
> + */
> +
> +
> +/**
> + * ssam_event_matches_notifier() - Test if an event matches a notifier;
                                                                         ^
Shouldn't it be a period?


> + * @notif: The event notifier to test against.
> + * @event: The event to test.
> + *
> + * Return: Returns %true iff the given event matches the given notifier
> + * according to the rules set in the notifier's event mask, %false other=
wise.
> + */

> [...]

> +static int __ssam_nfblk_remove(struct ssam_nf_head *nh,
> +=09=09=09       struct ssam_notifier_block *nb)
> +{
> +=09struct ssam_notifier_block **link;
> +
> +=09link =3D __ssam_nfblk_find_link(nh, nb);
> +=09if (!link)
> +=09=09return -ENOENT;

I find it odd that here you return ENOENT, but in `__ssam_nfblk_insert()`
EINVAL is returned instead of EEXIST. I believe either both should be EINVA=
L,
or EEXIST+ENOENT.


> +
> +=09__ssam_nfblk_erase(link);

I'm wondering if it's necessary to create a new function which contains jus=
t
a single line.


> +=09return 0;
> +}

> [...]

> +/**
> + * ssam_nf_head_destroy() - Deinitialize the given notifier head.
> + * @nh: The notifier head to deinitialize.
> + */
> +static void ssam_nf_head_destroy(struct ssam_nf_head *nh)
> +{
> +=09cleanup_srcu_struct(&nh->srcu);
> +}

I'm also wondering if there's any reason why these static one-liner functio=
ns are
not explicitly marked inline.


> [...]

> +/**
> + * struct ssam_nf_refcount_entry - RB-tree entry for referecnce counting=
 event
> + * activations.
> + * @node:     The node of this entry in the rb-tree.
> + * @key:      The key of the event.
> + * @refcount: The reference-count of the event.
> + * @flags:    The flags used when enabling the event.
> + */
> +struct ssam_nf_refcount_entry {
> +=09struct rb_node node;
> +=09struct ssam_nf_refcount_key key;
> +=09int refcount;

Is there any reason why a signed type is used for reference counting?


> +=09u8 flags;
> +};
> +
> +
> +/**
> + * ssam_nf_refcount_inc() - Increment reference-/activation-count of the=
 given
> + * event.
> + * @nf:  The notifier system reference.
> + * @reg: The registry used to enable/disable the event.
> + * @id:  The event ID.
> + *
> + * Increments the reference-/activation-count associated with the specif=
ied
> + * event type/ID, allocating a new entry for this event ID if necessary.=
 A
> + * newly allocated entry will have a refcount of one.

Shouldn't it be noted that nf->lock(?) must(?) be held when calling?


> [...]

> +/**
> + * ssam_nf_call() - Call notification callbacks for the provided event.
> + * @nf:    The notifier system
> + * @dev:   The associated device, only used for logging.
> + * @rqid:  The request ID of the event.
> + * @event: The event provided to the callbacks.
> + *
> + * Executa registered callbacks in order of their priority until either =
no
            ^
"execute"


> + * callback is left or a callback returned a value with the %SSAM_NOTIF_=
STOP
> + * bit set. Note that this bit is set automatically when converting non.=
zero
                                                                          ^
maybe "non-zero"?


> + * error values via ssam_notifier_from_errno() to notifier values.
> + *
> + * Also note that any callback that could handle an event should return =
a value
> + * with bit %SSAM_NOTIF_HANDLED set, indicating that the event does not =
go
> + * unhandled/ignored. In case no registered callback could handle an eve=
nt,
> + * this function will emit a warning.
> + *
> + * In case a callback failed, this function will emit an error message.
> + */
> +static void ssam_nf_call(struct ssam_nf *nf, struct device *dev, u16 rqi=
d,
> +=09=09=09 struct ssam_event *event)
> +{
> +=09struct ssam_nf_head *nf_head;
> +=09int status, nf_ret;
> +
> +=09if (!ssh_rqid_is_event(rqid)) {
> +=09=09dev_warn(dev, "event: unsupported rqid: 0x%04x\n", rqid);

A small note, "%#04x" would insert the "0x" prefix.


> +=09=09return;
> +=09}

> [...]

> +/**
> + * ssam_event_item_alloc() - Allocate an event item with the given paylo=
ad size.
> + * @len:   The event payload length.
> + * @flags: The flags used for allocation.
> + *
> + * Allocate an event item with the given payload size. Sets the item
> + * operations and payload length values. The item free callback (``ops.f=
ree``)
> + * should not be overwritten after this call.
> + *
> + * Return: Returns the newly allocated event item.
> + */
> +static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t f=
lags)

The `flags` argument is seemingly ignored.


> +{
> +=09struct ssam_event_item *item;
> +
> +=09item =3D kzalloc(sizeof(*item) + len, GFP_KERNEL);

I believe `struct_size(item, event.data, len)` could be utilized here.


> +=09if (!item)
> +=09=09return NULL;
> +
> +=09item->event.length =3D len;
> +=09return item;
> +}

> [...]

> +static void ssam_event_queue_work_fn(struct work_struct *work)
> +{
> +=09struct ssam_event_queue *queue;
> +=09struct ssam_event_item *item;
> +=09struct ssam_nf *nf;
> +=09struct device *dev;
> +=09int i;
> +
> +=09queue =3D container_of(work, struct ssam_event_queue, work);
> +=09nf =3D &queue->cplt->event.notif;
> +=09dev =3D queue->cplt->dev;
> +
> +=09// limit number of processed events to avoid livelocking
> +=09for (i =3D 0; i < 10; i++) {
> +=09=09item =3D ssam_event_queue_pop(queue);
> +=09=09if (item =3D=3D NULL)

I believe `!item` is preferred.


> +=09=09=09return;
> +
> +=09=09ssam_nf_call(nf, dev, item->rqid, &item->event);
> +=09=09kfree(item);
> +=09}
> +
> +=09if (!ssam_event_queue_is_empty(queue))
> +=09=09ssam_cplt_submit(queue->cplt, &queue->work);
> +}

> [...]

> +static void ssam_handle_event(struct ssh_rtl *rtl,
> +=09=09=09      const struct ssh_command *cmd,
> +=09=09=09      const struct ssam_span *data)
> +{
> +=09struct ssam_controller *ctrl =3D to_ssam_controller(rtl, rtl);
> +=09struct ssam_event_item *item;
> +
> +=09item =3D ssam_event_item_alloc(data->len, GFP_KERNEL);
> +=09if (!item)
> +=09=09return;
> +
> +=09item->rqid =3D get_unaligned_le16(&cmd->rqid);
> +=09item->event.target_category =3D cmd->tc;
> +=09item->event.target_id =3D cmd->tid_in;
> +=09item->event.command_id =3D cmd->cid;
> +=09item->event.instance_id =3D cmd->iid;
> +=09memcpy(&item->event.data[0], data->ptr, data->len);
> +
> +=09WARN_ON(ssam_cplt_submit_event(&ctrl->cplt, item));

I believe that if submission fails, `item` is leaked.


> +}
> +
> +static const struct ssh_rtl_ops ssam_rtl_ops =3D {
> +=09.handle_event =3D ssam_handle_event,
> +};
> +
> +
> +static bool ssam_notifier_empty(struct ssam_controller *ctrl);

I think it'd be better to name it `ssam_notifier_is_empty()` to be consiste=
nt
with the rest of the patch.


> [...]

> +static int ssam_controller_caps_load_from_acpi(
> +=09=09acpi_handle handle, struct ssam_controller_caps *caps)
> +{
> +=09u32 d3_closes_handle =3D false;

Assinging a boolean like this to a `u32` looks very odd to me.


> +=09u64 funcs;
> +=09int status;
> +
> +=09// set defaults
> +=09caps->ssh_power_profile =3D (u32)-1;
> +=09caps->screen_on_sleep_idle_timeout =3D (u32)-1;
> +=09caps->screen_off_sleep_idle_timeout =3D (u32)-1;
> +=09caps->d3_closes_handle =3D false;
> +=09caps->ssh_buffer_size =3D (u32)-1;

> [...]

> +
> +/**
> + * ssam_controller_start() - Start the receiver and transmitter threads =
of the
> + * controller.
> + * @ctrl: The controller.
> + *
> + * Note: When this function is called, the controller shouldbe properly =
hooked
                                                               ^
space


> + * up to the serdev core via &struct serdev_device_ops. Please refert to
                                                                       ^
"refer"


> [...]

> +void ssam_controller_shutdown(struct ssam_controller *ctrl)
> +{
> +=09enum ssam_controller_state s =3D ctrl->state;
> +=09int status;
> +
> +=09if (s =3D=3D SSAM_CONTROLLER_UNINITIALIZED || s =3D=3D SSAM_CONTROLLE=
R_STOPPED)
> +=09=09return;
> +
> +=09// try to flush pending events and requests while everything still wo=
rks
> +=09status =3D ssh_rtl_flush(&ctrl->rtl, msecs_to_jiffies(5000));

Wouldn't it be better to name that 5000?


> +=09if (status) {
> +=09=09ssam_err(ctrl, "failed to flush request transport layer: %d\n",
> +=09=09=09 status);
> +=09}

> [...]

> +
> +/**
> + * ssam_controller_destroy() - Destroy the controller and free its resou=
rces.
> + * @ctrl: The controller.
> + *
> + * Ensures that all resources associated with the controller get freed. =
This
> + * function should only be called after the controller has been stopped =
via
> + * ssam_controller_shutdown(). In general, this function should not be c=
alled
> + * directly. The only valid place to call this function direclty is duri=
ng
                                                                ^
"directly"


> + * initialization, before the controller has been fully initialized and =
passed
> + * to other processes. This function is called automatically when the
> + * reference count of the controller reaches zero.
> + *
> + * Must be called from an exclusive context with regards to the controll=
er
> + * state.
> + */

> [...]

> +int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
> +=09=09=09    struct ssam_request_sync **rqst,
> +=09=09=09    struct ssam_span *buffer)
> +{
> +=09size_t msglen =3D SSH_COMMAND_MESSAGE_LENGTH(payload_len);
> +
> +=09*rqst =3D kzalloc(sizeof(**rqst) + msglen, flags);
> +=09if (!*rqst)
> +=09=09return -ENOMEM;
> +
> +=09buffer->ptr =3D (u8 *)(*rqst + 1);
> +=09buffer->len =3D msglen;
> +
> +=09return 0;
> +}

I think there is a bit of incosistency: sometimes you use ** pointer + retu=
rn int,
sometimes you return a pointer with potentially embedded errno. I think it =
would
be better if you stuck with one or the other.


> [...]

> +static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
> +=09=09=09=09  struct ssam_event_registry reg,
> +=09=09=09=09  struct ssam_event_id id, u8 flags)
> +{
> [...]
> +=09rqst.command_id =3D reg.cid_disable;

If I see it correctly, this line is the only significant difference between=
 this one
and the previous function. Is there any reason they're not combined?


> [...]

> +/**
> + * ssam_notifier_disable_registered() - Disable events for all registere=
d
> + * notifiers.
> + * @ctrl: The controller for which to disable the notifiers/events.
> + *
> + * Disables events for all currently registered notifiers. In case of an=
 error
> + * (EC command failing), all previously disabled events will be restored=
 and
> + * the error code returned.
> + *
> + * This function is intended to disable all events prior to hibenration =
entry.
                                                                   ^
"hibernation"


> [...]

> +void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl)
> +{
> +=09int status;
> +
> +=09if (ctrl->irq.wakeup_enabled) {
> +=09=09status =3D disable_irq_wake(ctrl->irq.num);
> +=09=09if (status)
> +=09=09=09ssam_err(ctrl, "failed to disable wake IRQ: %d\n", status);
> +
> +=09=09ctrl->irq.wakeup_enabled =3D false;

It's set to false even if `disable_irq_wake()` fails?


> +=09}
> +=09disable_irq(ctrl->irq.num);
> +}

> [...]

> +static int ssam_try_set_controller(struct ssam_controller *ctrl)
> +{
> +=09int status =3D 0;
> +
> +=09spin_lock(&__ssam_controller_lock);
> +=09if (!__ssam_controller)
> +=09=09__ssam_controller =3D ctrl;
> +=09else
> +=09=09status =3D -EBUSY;

I feel like EBUSY might not be the best errno here.


> +=09spin_unlock(&__ssam_controller_lock);
> +
> +=09return status;
> +}

> [...]

> +int ssam_client_link(struct ssam_controller *c, struct device *client)
> +{
> +=09const u32 flags =3D DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> +=09struct device_link *link;
> +=09struct device *ctrldev;
> +
> +=09ssam_controller_statelock(c);
> +
> +=09if (c->state !=3D SSAM_CONTROLLER_STARTED) {
> +=09=09ssam_controller_stateunlock(c);
> +=09=09return -ENXIO;
> +=09}
> +
> +=09ctrldev =3D ssam_controller_device(c);
> +=09if (!ctrldev) {
> +=09=09ssam_controller_stateunlock(c);
> +=09=09return -ENXIO;
> +=09}
> +

I'm not sure if ENXIO is the best errno in the last two returns;


> +=09link =3D device_link_add(client, ctrldev, flags);
> +=09if (!link) {
> +=09=09ssam_controller_stateunlock(c);
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09/*
> +=09 * Return -ENXIO if supplier driver is on its way to be removed. In t=
his
> +=09 * case, the controller won't be around for much longer and the devic=
e
> +=09 * link is not going to save us any more, as unbinding is already in
> +=09 * progress.
> +=09 */
> +=09if (READ_ONCE(link->status) =3D=3D DL_STATE_SUPPLIER_UNBIND) {
> +=09=09ssam_controller_stateunlock(c);
> +=09=09return -ENXIO;
> +=09}
> +
> +=09ssam_controller_stateunlock(c);
> +=09return 0;
> +}

> [...]

> +int ssam_client_bind(struct device *client, struct ssam_controller **ctr=
l)
> +{
> +=09struct ssam_controller *c;
> +=09int status;
> +
> +=09c =3D ssam_get_controller();
> +=09if (!c)
> +=09=09return -ENXIO;

To me, ENODEV seems like a better fit here.


> +
> +=09status =3D ssam_client_link(c, client);

> [...]


> +static ssize_t firmware_version_show(struct device *dev,
> +=09=09=09=09     struct device_attribute *attr, char *buf)
> +{
> +=09struct ssam_controller *ctrl =3D dev_get_drvdata(dev);
> +=09u32 version, a, b, c;
> +=09int status;
> +
> +=09status =3D ssam_get_firmware_version(ctrl, &version);
> +=09if (status < 0)
> +=09=09return status;
> +
> +=09a =3D (version >> 24) & 0xff;
> +=09b =3D ((version >> 8) & 0xffff);
> +=09c =3D version & 0xff;
> +
> +=09return snprintf(buf, PAGE_SIZE - 1, "%u.%u.%u\n", a, b, c);

`snprintf()` takes care of the null byte, so simply `PAGE_SIZE` would've be=
en
sufficient. But that doesn't matter much since you should use `sysfs_emit()=
`.


> +}
> +static DEVICE_ATTR_RO(firmware_version);
> +
> +static struct attribute *ssam_sam_attrs[] =3D {
> +=09&dev_attr_firmware_version.attr,
> +=09NULL,
            ^
I believe it is preferred to omit the comma after the terminating entry.


> [...]

> +/**
> + * msgb_push_cmd() - Push a SSH command frame with payload to the buffer=
.
> + * @msgb: The message buffer.
> + * @seq:  The sequence ID (SEQ) of the frame/packet.
> + * @rqid: The request ID (RQID) of the request contained in the frame.
> + * @rqst: The request to wrap in the frame.
> + */
> +static inline void msgb_push_cmd(struct msgbuf *msgb, u8 seq, u16 rqid,
> +=09=09=09=09 const struct ssam_request *rqst)
> +{
> +=09struct ssh_command *cmd;
> +=09const u8 *cmd_begin;
> +=09const u8 type =3D SSH_FRAME_TYPE_DATA_SEQ;
> +
> +=09// SYN
> +=09msgb_push_syn(msgb);
> +
> +=09// command frame + crc
> +=09msgb_push_frame(msgb, type, sizeof(*cmd) + rqst->length, seq);
> +
> +=09// frame payload: command struct + payload
> +=09if (WARN_ON(msgb->ptr + sizeof(*cmd) > msgb->end))
> +=09=09return;
> +
> +=09cmd_begin =3D msgb->ptr;
> +=09cmd =3D (struct ssh_command *)msgb->ptr;

I believe this violates strict aliasing.


> [...]

> + * Note that the packet completion callback is, in case of success and f=
or a
> + * sequenced packet, guaranteed to run on the receiver thread, thus prov=
iding
> + * a way to reliably identify responses to the packet. The packet comple=
tion
> + * callback is only run once and it does not indicate that the packet ha=
s
> + * fully left the system (for this, one should rely on the release metho=
d,
> + * triggered when the reference count of the packet reaches zero). In ca=
se of
> + * re-submission (and with somewhat unlikely timing), it may be possible=
 that
> + * the packet is being re-transmitted while the completion callback runs=
.
> + * Completion will occur both on success and internal error, as well as =
when
> + * the packet is canceled.

If I understand it correctly, it is possible that submission of a packet fa=
ils
for the first time, but it's scheduled for resubmission, and this retransmi=
ssion
happens at the same time when the complete() callback is called. If that's =
the
case, then the callback is called with an error condition, no? Thus it is p=
ossible
that a packet is successfully submitted (for the second, third, etc. time),=
 but the
complete() callback receives notification about failure? Or am I missing so=
mething?


> [...]

> +int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
> +{
> +=09int used;
> +
> +=09if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
> +=09=09return -ESHUTDOWN;
> +
> +=09used =3D kfifo_in(&ptl->rx.fifo, buf, n);

Isn't it possible that `n` is greater than the free space in the fifo? What
happens then?


> +=09if (used)
> +=09=09ssh_ptl_rx_wakeup(ptl);
> +
> +=09return used;
> +}

> [...]

> +void ssh_ptl_shutdown(struct ssh_ptl *ptl)
> +{
> [...]
> +=09 * Note 2: We can re-use queue_node (or pending_node) if we mark the
> +=09 * packet as locked an then remove it from the queue (or pending set
> +=09 * respecitvely). Marking the packet as locked avoids re-queueing
> +=09 * (which should already be prevented by having stopped the treads...=
)
> +=09 * and not setting QUEUED_BIT (or PENDING_BIT) prevents removal from =
a
> +=09 * new list via other threads (e.g. canellation).
                                               ^
"cancellation"


> +=09 *
> +=09 * Note 3: There may be overlap between complete_p and complete_q.
> +=09 * This is handled via test_and_set_bit() on the "completed" flag
> +=09 * (also handles cancellation).
> +=09 */

> [...]

> +#define __ssam_prcond(func, p, fmt, ...)=09=09\
> +=09do {=09=09=09=09=09=09\
> +=09=09if ((p))=09=09=09=09\

I believe `if (p)` is sufficient.


> +=09=09=09func((p), fmt, ##__VA_ARGS__);=09\
> +=09} while (0)

> [...]

> +int sshp_parse_frame(const struct device *dev, const struct ssam_span *s=
ource,
> +=09=09     struct ssh_frame **frame, struct ssam_span *payload,
> +=09=09     size_t maxlen)
> +{
> [...]
> +=09// ensure packet does not exceed maximum length
> +=09sp.len =3D get_unaligned_le16(&((struct ssh_frame *)sf.ptr)->len);
> +=09if (unlikely(sp.len + SSH_MESSAGE_LENGTH(0) > maxlen)) {
> +=09=09dev_warn(dev, "rx: parser: frame too large: %u bytes\n",

I believe `%hu` would be more appropriate.


> +=09=09=09 ((struct ssh_frame *)sf.ptr)->len);

Why isn't `get_unaligned_le16()` used here? (Or simply even `sp.len`.)


> +=09=09return -EMSGSIZE;
> +=09}
> [...]
> +=09*frame =3D (struct ssh_frame *)sf.ptr;

This also violates strict aliasing.


> +=09*payload =3D sp;
> +
> +=09dev_dbg(dev, "rx: parser: valid frame found (type: 0x%02x, len: %u)\n=
",
> +=09=09(*frame)->type, (*frame)->len);
> +
> +=09return 0;
> +}

> [...]

> +int sshp_parse_command(const struct device *dev, const struct ssam_span =
*source,
> +=09=09       struct ssh_command **command,
> +=09=09       struct ssam_span *command_data)
> +{
> +=09// check for minimum length
> +=09if (unlikely(source->len < sizeof(struct ssh_command))) {
> +=09=09*command =3D NULL;
> +=09=09command_data->ptr =3D NULL;
> +=09=09command_data->len =3D 0;
> +
> +=09=09dev_err(dev, "rx: parser: command payload is too short\n");
> +=09=09return -ENOMSG;
> +=09}
> +
> +=09*command =3D (struct ssh_command *)source->ptr;

I'm quite sure this also violates strict aliasing.


> +=09command_data->ptr =3D source->ptr + sizeof(struct ssh_command);
> +=09command_data->len =3D source->len - sizeof(struct ssh_command);
> +
> +=09dev_dbg(dev, "rx: parser: valid command found (tc: 0x%02x, cid: 0x%02=
x)\n",
> +=09=09(*command)->tc, (*command)->cid);
> +
> +=09return 0;
> +}

> [...]

> +#define SSH_MSGOFFSET_FRAME(field) \
> +=09(sizeof(u16) + offsetof(struct ssh_frame, field))
> +
> +/**
> + * SSH_MSGOFFSET_COMMAND() - Compute offset in SSH message to specified =
field
> + * in command.
> + * @field: The field for which the offset should be computed.
> + *
> + * Return: Returns the offset of the specified &struct ssh_command field=
 in
> + * the raw SSH message data.
> + */
> +#define SSH_MSGOFFSET_COMMAND(field) \
> +=09(2ull * sizeof(u16) + sizeof(struct ssh_frame) \
> +=09=09+ offsetof(struct ssh_command, field))

I believe it should be noted (here and for `SSH_MSGOFFSET_FRAME()`) why the
`sizeof(u16)`s are necessary.


> +
> +/*
> + * SSH_MSG_SYN - SSH message synchronization (SYN) bytes as u16.
> + */
> +#define SSH_MSG_SYN=09=09((u16)0x55aa)

> [...]

> +enum ssam_ssh_tc {
> +=09/* Known SSH/EC target categories. */
> +=09=09=09=09// category 0x00 is invalid for EC use
> +=09SSAM_SSH_TC_SAM =3D 0x01,=09// generic system functionality, real-tim=
e clock
> +=09SSAM_SSH_TC_BAT =3D 0x02,=09// battery/power subsystem
> +=09SSAM_SSH_TC_TMP =3D 0x03,=09// thermal subsystem
> +=09SSAM_SSH_TC_PMC =3D 0x04,
> +=09SSAM_SSH_TC_FAN =3D 0x05,
> +=09SSAM_SSH_TC_PoM =3D 0x06,
> +=09SSAM_SSH_TC_DBG =3D 0x07,
> +=09SSAM_SSH_TC_KBD =3D 0x08,=09// legacy keyboard (Laptop 1/2)
> +=09SSAM_SSH_TC_FWU =3D 0x09,
> +=09SSAM_SSH_TC_UNI =3D 0x0a,
> +=09SSAM_SSH_TC_LPC =3D 0x0b,
> +=09SSAM_SSH_TC_TCL =3D 0x0c,
> +=09SSAM_SSH_TC_SFL =3D 0x0d,
> +=09SSAM_SSH_TC_KIP =3D 0x0e,
> +=09SSAM_SSH_TC_EXT =3D 0x0f,
> +=09SSAM_SSH_TC_BLD =3D 0x10,
> +=09SSAM_SSH_TC_BAS =3D 0x11,=09// detachment system (Surface Book 2/3)
> +=09SSAM_SSH_TC_SEN =3D 0x12,
> +=09SSAM_SSH_TC_SRQ =3D 0x13,
> +=09SSAM_SSH_TC_MCU =3D 0x14,
> +=09SSAM_SSH_TC_HID =3D 0x15,=09// generic HID input subsystem
> +=09SSAM_SSH_TC_TCH =3D 0x16,
> +=09SSAM_SSH_TC_BKL =3D 0x17,
> +=09SSAM_SSH_TC_TAM =3D 0x18,
> +=09SSAM_SSH_TC_ACC =3D 0x19,
> +=09SSAM_SSH_TC_UFI =3D 0x1a,
> +=09SSAM_SSH_TC_USC =3D 0x1b,
> +=09SSAM_SSH_TC_PEN =3D 0x1c,
> +=09SSAM_SSH_TC_VID =3D 0x1d,
> +=09SSAM_SSH_TC_AUD =3D 0x1e,
> +=09SSAM_SSH_TC_SMC =3D 0x1f,
> +=09SSAM_SSH_TC_KPD =3D 0x20,
> +=09SSAM_SSH_TC_REG =3D 0x21,
> +};

Is it known what these abbreviations stand for? Maybe I missed them?


> [...]

> +/**
> + * struct ssh_request_ops - Callback operations for a SSH request.
> + * @release:  Function called when the request's reference count reaches=
 zero.
> + *            This callback must be relied upon to ensure that the reque=
st has
> + *            left the transport systems (both, packet an request system=
s).
> + * @complete: Function called when the request is completed, either with
> + *            success or failure. The command data for the request respo=
nse
> + *            is provided via the &struct ssh_command parameter (``cmd``=
),
> + *            the command payload of the request response via the &struc=
t
> + *            ssh_span parameter (``data``).
> + *
> + *            If the request does not have any response or has not been
> + *            completed with success, both ``cmd`` and ``data`` paramete=
rs will
> + *            be NULL. If the request response does not have any command
> + *            payload, the ``data`` span will be an empty (zero-length) =
span.
> + *
> + *            In case of failure, the reason for the failure is indicate=
d by
> + *            the value of the provided status code argument (``status``=
). This
> + *            value will be zero in case of success.

I believe it should be noted if the `status` argument is a regular errno,
or something different.


> + *
> + *            Note that a call to this callback does not guarantee that =
the
> + *            request is not in use by the transport systems any more.
> + */
> +struct ssh_request_ops {
> +=09void (*release)(struct ssh_request *rqst);
> +=09void (*complete)(struct ssh_request *rqst,
> +=09=09=09 const struct ssh_command *cmd,
> +=09=09=09 const struct ssam_span *data, int status);
> +};
> [...]


I have to agree, this is quite a sizable patch, although I think it's well-=
commented,
which helps reading the code by a lot, however, in some places I feel like =
it's a bit
over-engineered (or maybe I just cannot fully appreciate the subject at han=
d at the moment),
nonetheless, I applaud your efforts, I can only imagine the hours that must=
 have gone into it.


Regards,
Barnab=C3=A1s P=C5=91cze
