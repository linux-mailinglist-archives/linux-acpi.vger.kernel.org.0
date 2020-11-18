Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86042B8813
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 00:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgKRXGK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 18:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRXGJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 18:06:09 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03C6C0613D4;
        Wed, 18 Nov 2020 15:06:26 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id t9so3803348edq.8;
        Wed, 18 Nov 2020 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eHQW4w+zUxxXYGfv92MYGmtQHJLMrytjOFKIvL33FAI=;
        b=QzkJS2FEBF8oCAKyEtdt3QUMhXX0vv9RQxS8OG2xGoNU4FpOWN6tOseQoHsVMcmQXD
         bf+BZ2LfHjBaVtA2H7XwOU91HrGxYJCS6txr3tUa4reyO6QFCCI6LzjHm7zA9Jig6A8D
         c4Kfo0RIL7rgjp2xz3UVjl22HWQEtC+YB5jhVMhoMzi9K+RdtfFHcFjiNLcSBMsT+rvy
         I9P6ggDDYCBtmTfIgtwrmKX20+K5287/0ajM6u8y0TFPQIAPvF6WMItf3Pc9wRPHurKl
         DaC35mkWo/qhfeGLGAW5JIMnBK8QR0KS+lqoIIxOcP4pCf32GSYZbyUJeyhCp4m39SL0
         S3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eHQW4w+zUxxXYGfv92MYGmtQHJLMrytjOFKIvL33FAI=;
        b=BSg2xvWJod6PjuEq2PH4nbjcxGb1T8uVNuGrgwADQpdVDT9Zcj+ZZpO+xlY+DZP/+7
         k9zIy2opEAZREDudF1Bq5AnvZyXbubTl6IHKhlJ8FqUYDBva8ZESIQzr+x4UBd/RSYfQ
         HMRuJrrWtck7ejBy6uzMZnaQiHJCHKGhkUxA9pDOsu5dPvMhYM1VxIZvnzEWF4eDBz3k
         W/bw0hdiY12H58Ph3NvN7pMf1yPfu+9mNf2jtxAFn5lOJM/q6RdvynuWSra5BsWImjbO
         hdvvvnKlpIylnrMcnTefq9cpxljkpzWaIDVWT/DyOL8eeZgbxD/tZ5cepaz9FHQKg4Sn
         lg2A==
X-Gm-Message-State: AOAM530A7dJZDTQwOmcWJ6wSJM8wfp2sDBdHId3kYBXxe1xUP25AgeKq
        mLHqhRDOEKBIcSN7KiXKk7UUKIMD+SQ=
X-Google-Smtp-Source: ABdhPJwzK4Yqds9AHeWSC58c0UWporAv0aq0KA6bpybcB1QgxTvZoav5aPVF3rbLKG7kv0zbaCk/GA==
X-Received: by 2002:aa7:c44a:: with SMTP id n10mr29225712edr.145.1605740784158;
        Wed, 18 Nov 2020 15:06:24 -0800 (PST)
Received: from [192.168.2.202] (pd9e5ae8d.dip0.t-ipconnect.de. [217.229.174.141])
        by smtp.gmail.com with ESMTPSA id e18sm13582842eja.124.2020.11.18.15.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 15:06:23 -0800 (PST)
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-2-luzmaximilian@gmail.com>
 <nJyowYoxGM_0dU6iqDLowrPuVIErZbgZLAkXASFlEKvvSkgGtLxGQ7wGFDpXAaqAc3wourELsji6s3lO7N4aHOb8sK0wI500Oq5ZMdeZwJ8=@protonmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <68af3474-b576-da7e-2b11-3aa4c319cceb@gmail.com>
Date:   Thu, 19 Nov 2020 00:06:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nJyowYoxGM_0dU6iqDLowrPuVIErZbgZLAkXASFlEKvvSkgGtLxGQ7wGFDpXAaqAc3wourELsji6s3lO7N4aHOb8sK0wI500Oq5ZMdeZwJ8=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/18/20 1:28 AM, Barnabás Pőcze wrote:
> Hi
> 
> I have attached some thoughts and comments inline.

Thanks!

> 2020. november 15., vasárnap 20:21 keltezéssel, Maximilian Luz írta:
> 
>> [...]
>> +/* -- Event notifier/callbacks. --------------------------------------------- */
>> +/*
>> + * The notifier system is based on linux/notifier.h, specifically the SRCU
>> + * implementation. The difference to that is, that some bits of the notifier
>> + * call return value can be tracked across multiple calls. This is done so that
>> + * handling of events can be tracked and a warning can be issued in case an
>> + * event goes unhandled. The idea of that waring is that it should help discover
>                                                  ^
> "warning"

Thanks, I'll run a spell-checker over the comments and (hopefully) fix all typos.

>> + * and identify new/currently unimplemented features.
>> + */
>> +
>> +
>> +/**
>> + * ssam_event_matches_notifier() - Test if an event matches a notifier;
>                                                                           ^
> Shouldn't it be a period?

Yes, it should.

>> + * @notif: The event notifier to test against.
>> + * @event: The event to test.
>> + *
>> + * Return: Returns %true iff the given event matches the given notifier
>> + * according to the rules set in the notifier's event mask, %false otherwise.
>> + */
> 
>> [...]
> 
>> +static int __ssam_nfblk_remove(struct ssam_nf_head *nh,
>> +			       struct ssam_notifier_block *nb)
>> +{
>> +	struct ssam_notifier_block **link;
>> +
>> +	link = __ssam_nfblk_find_link(nh, nb);
>> +	if (!link)
>> +		return -ENOENT;
> 
> I find it odd that here you return ENOENT, but in `__ssam_nfblk_insert()`
> EINVAL is returned instead of EEXIST. I believe either both should be EINVAL,
> or EEXIST+ENOENT.

Yes, EEXIST is better for insert.

>> +
>> +	__ssam_nfblk_erase(link);
> 
> I'm wondering if it's necessary to create a new function which contains just
> a single line.

I prefer to create these sorts of abstractions as this, in my opinion,
keeps things contained and makes things easier to reason about. In this
case, it also allows for documentation.

>> +	return 0;
>> +}
> 
>> [...]
> 
>> +/**
>> + * ssam_nf_head_destroy() - Deinitialize the given notifier head.
>> + * @nh: The notifier head to deinitialize.
>> + */
>> +static void ssam_nf_head_destroy(struct ssam_nf_head *nh)
>> +{
>> +	cleanup_srcu_struct(&nh->srcu);
>> +}
> 
> I'm also wondering if there's any reason why these static one-liner functions are
> not explicitly marked inline.

Isn't inline more of a linkage keyword at this point? I fully expect any
compiler to inline things like this automatically at the first hint of
an optimization flag.

>> [...]
> 
>> +/**
>> + * struct ssam_nf_refcount_entry - RB-tree entry for referecnce counting event
>> + * activations.
>> + * @node:     The node of this entry in the rb-tree.
>> + * @key:      The key of the event.
>> + * @refcount: The reference-count of the event.
>> + * @flags:    The flags used when enabling the event.
>> + */
>> +struct ssam_nf_refcount_entry {
>> +	struct rb_node node;
>> +	struct ssam_nf_refcount_key key;
>> +	int refcount;
> 
> Is there any reason why a signed type is used for reference counting?

Can help to spot overflows when debugging, not that that should happen.
We also don't need values larger than INT_MAX. We shouldn't even get
remotely close to it.

>> +	u8 flags;
>> +};
>> +
>> +
>> +/**
>> + * ssam_nf_refcount_inc() - Increment reference-/activation-count of the given
>> + * event.
>> + * @nf:  The notifier system reference.
>> + * @reg: The registry used to enable/disable the event.
>> + * @id:  The event ID.
>> + *
>> + * Increments the reference-/activation-count associated with the specified
>> + * event type/ID, allocating a new entry for this event ID if necessary. A
>> + * newly allocated entry will have a refcount of one.
> 
> Shouldn't it be noted that nf->lock(?) must(?) be held when calling?

All functions taking 'struct ssam_nf *' as first parameter must run
synchronized with regards to each other, except for ssam_nf_call().
Same for all access to struct ssam_nf directly. Whether that is
guaranteed by nf->lock or other means (de-/initialization) doesn't
really matter. Only higher-level functions may run concurrently.

On the higher level, the lock must also be held to ensure that the EC
requests are sent at the right time (which is its main purpose).

Arguably that's not well documented here, I'll try to fix that.

[...]

>> + * callback is left or a callback returned a value with the %SSAM_NOTIF_STOP
>> + * bit set. Note that this bit is set automatically when converting non.zero
>                                                                            ^
> maybe "non-zero"?

Right.

>> + * error values via ssam_notifier_from_errno() to notifier values.
>> + *
>> + * Also note that any callback that could handle an event should return a value
>> + * with bit %SSAM_NOTIF_HANDLED set, indicating that the event does not go
>> + * unhandled/ignored. In case no registered callback could handle an event,
>> + * this function will emit a warning.
>> + *
>> + * In case a callback failed, this function will emit an error message.
>> + */
>> +static void ssam_nf_call(struct ssam_nf *nf, struct device *dev, u16 rqid,
>> +			 struct ssam_event *event)
>> +{
>> +	struct ssam_nf_head *nf_head;
>> +	int status, nf_ret;
>> +
>> +	if (!ssh_rqid_is_event(rqid)) {
>> +		dev_warn(dev, "event: unsupported rqid: 0x%04x\n", rqid);
> 
> A small note, "%#04x" would insert the "0x" prefix.

Oh neat, didn't know that. Should be "%#06x" though, right?

>> +		return;
>> +	}
> 
>> [...]
> 
>> +/**
>> + * ssam_event_item_alloc() - Allocate an event item with the given payload size.
>> + * @len:   The event payload length.
>> + * @flags: The flags used for allocation.
>> + *
>> + * Allocate an event item with the given payload size. Sets the item
>> + * operations and payload length values. The item free callback (``ops.free``)
>> + * should not be overwritten after this call.
>> + *
>> + * Return: Returns the newly allocated event item.
>> + */
>> +static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
> 
> The `flags` argument is seemingly ignored.

Oh, right.

>> +{
>> +	struct ssam_event_item *item;
>> +
>> +	item = kzalloc(sizeof(*item) + len, GFP_KERNEL);
> 
> I believe `struct_size(item, event.data, len)` could be utilized here.

Right, I'll use that.

>> +	if (!item)
>> +		return NULL;
>> +
>> +	item->event.length = len;
>> +	return item;
>> +}
> 
>> [...]
> 
>> +static void ssam_event_queue_work_fn(struct work_struct *work)
>> +{
>> +	struct ssam_event_queue *queue;
>> +	struct ssam_event_item *item;
>> +	struct ssam_nf *nf;
>> +	struct device *dev;
>> +	int i;
>> +
>> +	queue = container_of(work, struct ssam_event_queue, work);
>> +	nf = &queue->cplt->event.notif;
>> +	dev = queue->cplt->dev;
>> +
>> +	// limit number of processed events to avoid livelocking
>> +	for (i = 0; i < 10; i++) {
>> +		item = ssam_event_queue_pop(queue);
>> +		if (item == NULL)
> 
> I believe `!item` is preferred.

Right.

>> +			return;
>> +
>> +		ssam_nf_call(nf, dev, item->rqid, &item->event);
>> +		kfree(item);
>> +	}
>> +
>> +	if (!ssam_event_queue_is_empty(queue))
>> +		ssam_cplt_submit(queue->cplt, &queue->work);
>> +}
> 
>> [...]
> 
>> +static void ssam_handle_event(struct ssh_rtl *rtl,
>> +			      const struct ssh_command *cmd,
>> +			      const struct ssam_span *data)
>> +{
>> +	struct ssam_controller *ctrl = to_ssam_controller(rtl, rtl);
>> +	struct ssam_event_item *item;
>> +
>> +	item = ssam_event_item_alloc(data->len, GFP_KERNEL);
>> +	if (!item)
>> +		return;
>> +
>> +	item->rqid = get_unaligned_le16(&cmd->rqid);
>> +	item->event.target_category = cmd->tc;
>> +	item->event.target_id = cmd->tid_in;
>> +	item->event.command_id = cmd->cid;
>> +	item->event.instance_id = cmd->iid;
>> +	memcpy(&item->event.data[0], data->ptr, data->len);
>> +
>> +	WARN_ON(ssam_cplt_submit_event(&ctrl->cplt, item));
> 
> I believe that if submission fails, `item` is leaked.

Oh, that is correct. Thanks for spotting that!

>> +}
>> +
>> +static const struct ssh_rtl_ops ssam_rtl_ops = {
>> +	.handle_event = ssam_handle_event,
>> +};
>> +
>> +
>> +static bool ssam_notifier_empty(struct ssam_controller *ctrl);
> 
> I think it'd be better to name it `ssam_notifier_is_empty()` to be consistent
> with the rest of the patch.

Okay, I'll change that.

>> [...]
> 
>> +static int ssam_controller_caps_load_from_acpi(
>> +		acpi_handle handle, struct ssam_controller_caps *caps)
>> +{
>> +	u32 d3_closes_handle = false;
> 
> Assinging a boolean like this to a `u32` looks very odd to me.

The value returned by the corresponding DSM call is an integer, but
essentially only contains a bool value (zero vs. one). I thought using
false here explicitly for initialization helps clarify that. That also
makes it consistent with the "caps->d3_closes_handle = false" line
below.

>> +	u64 funcs;
>> +	int status;
>> +
>> +	// set defaults
>> +	caps->ssh_power_profile = (u32)-1;
>> +	caps->screen_on_sleep_idle_timeout = (u32)-1;
>> +	caps->screen_off_sleep_idle_timeout = (u32)-1;
>> +	caps->d3_closes_handle = false;
>> +	caps->ssh_buffer_size = (u32)-1;

[...]

>> +void ssam_controller_shutdown(struct ssam_controller *ctrl)
>> +{
>> +	enum ssam_controller_state s = ctrl->state;
>> +	int status;
>> +
>> +	if (s == SSAM_CONTROLLER_UNINITIALIZED || s == SSAM_CONTROLLER_STOPPED)
>> +		return;
>> +
>> +	// try to flush pending events and requests while everything still works
>> +	status = ssh_rtl_flush(&ctrl->rtl, msecs_to_jiffies(5000));
> 
> Wouldn't it be better to name that 5000?

I'll do that.

>> +	if (status) {
>> +		ssam_err(ctrl, "failed to flush request transport layer: %d\n",
>> +			 status);
>> +	}

[...]

>> +int ssam_request_sync_alloc(size_t payload_len, gfp_t flags,
>> +			    struct ssam_request_sync **rqst,
>> +			    struct ssam_span *buffer)
>> +{
>> +	size_t msglen = SSH_COMMAND_MESSAGE_LENGTH(payload_len);
>> +
>> +	*rqst = kzalloc(sizeof(**rqst) + msglen, flags);
>> +	if (!*rqst)
>> +		return -ENOMEM;
>> +
>> +	buffer->ptr = (u8 *)(*rqst + 1);
>> +	buffer->len = msglen;
>> +
>> +	return 0;
>> +}
> 
> I think there is a bit of incosistency: sometimes you use ** pointer + return int,
> sometimes you return a pointer with potentially embedded errno. I think it would
> be better if you stuck with one or the other.

My rule of thumb is: If it's one output parameter, use a pointer as
return value. If it's two or more output parameters (as in this case,
"buffer" is written to), use two pointer arguments and an int as return.

I noticed that ssam_client_bind doesn't follow that scheme so I'll
change that.

>> [...]
> 
>> +static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
>> +				  struct ssam_event_registry reg,
>> +				  struct ssam_event_id id, u8 flags)
>> +{
>> [...]
>> +	rqst.command_id = reg.cid_disable;
> 
> If I see it correctly, this line is the only significant difference between this one
> and the previous function. Is there any reason they're not combined?

Debug and error messages are also different. I'll try to put the common
code into one function though.

[...]

>> +void ssam_irq_disarm_wakeup(struct ssam_controller *ctrl)
>> +{
>> +	int status;
>> +
>> +	if (ctrl->irq.wakeup_enabled) {
>> +		status = disable_irq_wake(ctrl->irq.num);
>> +		if (status)
>> +			ssam_err(ctrl, "failed to disable wake IRQ: %d\n", status);
>> +
>> +		ctrl->irq.wakeup_enabled = false;
> 
> It's set to false even if `disable_irq_wake()` fails?

Yes, on purpose. The irq.wakeup_enabled flag is there to ensure that
disable_irq_wake() gets called only if there has been a successful
enable_irq_wake() call.

This seems to be a common pattern, see e.g. /drivers/mmc/host/sdhci.c

>> +	}
>> +	disable_irq(ctrl->irq.num);
>> +}
> 
>> [...]
> 
>> +static int ssam_try_set_controller(struct ssam_controller *ctrl)
>> +{
>> +	int status = 0;
>> +
>> +	spin_lock(&__ssam_controller_lock);
>> +	if (!__ssam_controller)
>> +		__ssam_controller = ctrl;
>> +	else
>> +		status = -EBUSY;
> 
> I feel like EBUSY might not be the best errno here.

Okay, I'll replace it with EEXIST.

>> +	spin_unlock(&__ssam_controller_lock);
>> +
>> +	return status;
>> +}
> 
>> [...]
> 
>> +int ssam_client_link(struct ssam_controller *c, struct device *client)
>> +{
>> +	const u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
>> +	struct device_link *link;
>> +	struct device *ctrldev;
>> +
>> +	ssam_controller_statelock(c);
>> +
>> +	if (c->state != SSAM_CONTROLLER_STARTED) {
>> +		ssam_controller_stateunlock(c);
>> +		return -ENXIO;
>> +	}
>> +
>> +	ctrldev = ssam_controller_device(c);
>> +	if (!ctrldev) {
>> +		ssam_controller_stateunlock(c);
>> +		return -ENXIO;
>> +	}
>> +
> 
> I'm not sure if ENXIO is the best errno in the last two returns;

I guess I can return ENODEV.

>> +	link = device_link_add(client, ctrldev, flags);
>> +	if (!link) {
>> +		ssam_controller_stateunlock(c);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/*
>> +	 * Return -ENXIO if supplier driver is on its way to be removed. In this
>> +	 * case, the controller won't be around for much longer and the device
>> +	 * link is not going to save us any more, as unbinding is already in
>> +	 * progress.
>> +	 */
>> +	if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND) {
>> +		ssam_controller_stateunlock(c);
>> +		return -ENXIO;
>> +	}
>> +
>> +	ssam_controller_stateunlock(c);
>> +	return 0;
>> +}
> 
>> [...]
> 
>> +int ssam_client_bind(struct device *client, struct ssam_controller **ctrl)
>> +{
>> +	struct ssam_controller *c;
>> +	int status;
>> +
>> +	c = ssam_get_controller();
>> +	if (!c)
>> +		return -ENXIO;
> 
> To me, ENODEV seems like a better fit here.

Okay, I'll change it as well as above.

>> +
>> +	status = ssam_client_link(c, client);
> 
>> [...]
> 
> 
>> +static ssize_t firmware_version_show(struct device *dev,
>> +				     struct device_attribute *attr, char *buf)
>> +{
>> +	struct ssam_controller *ctrl = dev_get_drvdata(dev);
>> +	u32 version, a, b, c;
>> +	int status;
>> +
>> +	status = ssam_get_firmware_version(ctrl, &version);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	a = (version >> 24) & 0xff;
>> +	b = ((version >> 8) & 0xffff);
>> +	c = version & 0xff;
>> +
>> +	return snprintf(buf, PAGE_SIZE - 1, "%u.%u.%u\n", a, b, c);
> 
> `snprintf()` takes care of the null byte, so simply `PAGE_SIZE` would've been
> sufficient. But that doesn't matter much since you should use `sysfs_emit()`.

I didn't know about sysfs_emit(), I'll switch to that then. Also you're
right about that "- 1", not sure where I got that from.

>> +}
>> +static DEVICE_ATTR_RO(firmware_version);
>> +
>> +static struct attribute *ssam_sam_attrs[] = {
>> +	&dev_attr_firmware_version.attr,
>> +	NULL,
>              ^
> I believe it is preferred to omit the comma after the terminating entry.

Right.

>> [...]
> 
>> +/**
>> + * msgb_push_cmd() - Push a SSH command frame with payload to the buffer.
>> + * @msgb: The message buffer.
>> + * @seq:  The sequence ID (SEQ) of the frame/packet.
>> + * @rqid: The request ID (RQID) of the request contained in the frame.
>> + * @rqst: The request to wrap in the frame.
>> + */
>> +static inline void msgb_push_cmd(struct msgbuf *msgb, u8 seq, u16 rqid,
>> +				 const struct ssam_request *rqst)
>> +{
>> +	struct ssh_command *cmd;
>> +	const u8 *cmd_begin;
>> +	const u8 type = SSH_FRAME_TYPE_DATA_SEQ;
>> +
>> +	// SYN
>> +	msgb_push_syn(msgb);
>> +
>> +	// command frame + crc
>> +	msgb_push_frame(msgb, type, sizeof(*cmd) + rqst->length, seq);
>> +
>> +	// frame payload: command struct + payload
>> +	if (WARN_ON(msgb->ptr + sizeof(*cmd) > msgb->end))
>> +		return;
>> +
>> +	cmd_begin = msgb->ptr;
>> +	cmd = (struct ssh_command *)msgb->ptr;
> 
> I believe this violates strict aliasing.

It does. The same happens in msgb_push_frame(), too. The kernel is
built with -fno-strict-aliasing though if I remember correctly.

I guess I can try to avoid that in those two functions with
put_unaligned and offsetof to compute the pointers.

>> [...]
> 
>> + * Note that the packet completion callback is, in case of success and for a
>> + * sequenced packet, guaranteed to run on the receiver thread, thus providing
>> + * a way to reliably identify responses to the packet. The packet completion
>> + * callback is only run once and it does not indicate that the packet has
>> + * fully left the system (for this, one should rely on the release method,
>> + * triggered when the reference count of the packet reaches zero). In case of
>> + * re-submission (and with somewhat unlikely timing), it may be possible that
>> + * the packet is being re-transmitted while the completion callback runs.
>> + * Completion will occur both on success and internal error, as well as when
>> + * the packet is canceled.
> 
> If I understand it correctly, it is possible that submission of a packet fails
> for the first time, but it's scheduled for resubmission, and this retransmission
> happens at the same time when the complete() callback is called. If that's the
> case, then the callback is called with an error condition, no? Thus it is possible
> that a packet is successfully submitted (for the second, third, etc. time), but the
> complete() callback receives notification about failure? Or am I missing something?

Not sure I can follow you here. What do you mean by "fails for the first time"?

A couple of notes before I try to explain the error cases:

  - Resubmission only happens on timeout or NAK.

  - Only sequenced packets can be resubmitted (unsequenced are not added
    to the pending set, thus do not have a packet timeout and do not
    react to NAKs).

  - Completion means the packet gets locked, which prevents it from being
    resubmitted and retransmitted, and is removed from all collections.
  
  - Completion cannot be triggered by NAK. In case a NAK is received and
    all tries have been exceeded, the packet still waits for the timeout
    (or ACK, whatever happens first) one last time.

The error cases:

  - serdev: Failure to send via serdev results in immediate completion
    with error on the transmitter thread. Due to a NAK (or a _very_
    unlikely timeout), the packet can be queued for a second time at that
    point, but, as completion runs on the transmitter thread in this
    case, the packet is removed from the queue before the thread goes on
    to get the next packet.

  - Timeout: On resubmission, the timeout of a packet is disabled. It is
    (re-)armed directly before starting transmission on the transmitter
    thread.
    
    What _could_ now happen is that, for some reason, the transmitter
    thread waits the full timeout period between arming the timeout and
    actually sending it (which I'd consider highly unlikely). Note that
    "actually sending it" includes whatever asynchronous stuff the serdev
    core does after serdev_device_write_buf() returns.

    In that case, the packet can be transmitted _after_ it has received a
    timeout. So assuming this is the last try, then the packet can be
    sent after completion with -ETIMEDOUT.

    I believe this is what you meant?

    Again, I consider this highly unlikely as this would require either
    the scheduler to pause our thread for a full timeout period or
    require the serdev core to basically do nothing for a full timeout
    period. I'd argue this is a lot less likely than a dropped ACK packet
    from the EC (which results in the same thing: EC receives data but we
    think it didn't, causing a timeout error).

    Note that putting the timeout (re-)arming step after the last call to
    serdev_device_write_buf() doesn't really help either, as that only
    writes to the transport buffer. If we would want to guarantee that
    this doesn't happen, we'd have to explicitly wait for the hardware to
    finish transmitting, which essentially breaks the whole point of
    buffering.

    Also I prefer to have the timeout cover the transmission part as
    well. In the very least, this simplifies reasoning about it once I've
    restricted it to be (re-)set under the pending lock only (as
    mentioned in the message to Andy).

  - Finally, there is completion by cancellation or shutdown, for which
    the packet can have been (or currently be) transmitted successfully
    but completion returns with -ECANCELLED or -ESHUTDOWN, respectively.
    This is the expected behavior in those cases. Again, the completion
    procedure takes care of locking the packet and removing all
    references from the collections.

Also there's one success case, when we receive an ACK after a timeout
and during the re-transmission. Then the packet is completed with
success, but might still be transmitted once more. The EC should detect
that packet as re-submission via its packet ID and ignore it.

>> [...]
> 
>> +int ssh_ptl_rx_rcvbuf(struct ssh_ptl *ptl, const u8 *buf, size_t n)
>> +{
>> +	int used;
>> +
>> +	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
>> +		return -ESHUTDOWN;
>> +
>> +	used = kfifo_in(&ptl->rx.fifo, buf, n);
> 
> Isn't it possible that `n` is greater than the free space in the fifo? What
> happens then?

If I've read the documentation of kfifo_in() right, it takes at most n
elements. If n is greater than the free space, it will only take as much
elements as it has space. The return value of kfifo_in() is the number
of elements actually consumed. We simply return that here (as elements =
bytes) and ultimately let the serdev/tty core take care of handling
that.

>> +	if (used)
>> +		ssh_ptl_rx_wakeup(ptl);
>> +
>> +	return used;
>> +}

[...]

>> +#define __ssam_prcond(func, p, fmt, ...)		\
>> +	do {						\
>> +		if ((p))				\
> 
> I believe `if (p)` is sufficient.

Right.

>> +			func((p), fmt, ##__VA_ARGS__);	\
>> +	} while (0)
> 
>> [...]
> 
>> +int sshp_parse_frame(const struct device *dev, const struct ssam_span *source,
>> +		     struct ssh_frame **frame, struct ssam_span *payload,
>> +		     size_t maxlen)
>> +{
>> [...]
>> +	// ensure packet does not exceed maximum length
>> +	sp.len = get_unaligned_le16(&((struct ssh_frame *)sf.ptr)->len);
>> +	if (unlikely(sp.len + SSH_MESSAGE_LENGTH(0) > maxlen)) {
>> +		dev_warn(dev, "rx: parser: frame too large: %u bytes\n",
> 
> I believe `%hu` would be more appropriate.

Right.

>> +			 ((struct ssh_frame *)sf.ptr)->len);
> 
> Why isn't `get_unaligned_le16()` used here? (Or simply even `sp.len`.)

This should actually be "sp.len + SSH_MESSAGE_LENGTH(0)", and also
format spezifier %zu with that as SSH_MESSAGE_LENGTH returns size_t.

>> +		return -EMSGSIZE;
>> +	}
>> [...]
>> +	*frame = (struct ssh_frame *)sf.ptr;
> 
> This also violates strict aliasing.

Sure, the whole point of this function (and ssh_parse_command below) is
to get pointers to the data structures in the given buffer, i.e. create
aliases of the right types to the right places in the buffer. Not sure
how I'd do that differently, apart from copying.

I think that this would even work properly (in practice) without setting
-fno-strict-aliasing, as all data at this point is effectively
read-only. Furthermore, after the call access is restricted to the
non-aliasing parts respectively (frame and payload), whereas the
underlying buffer they do alias isn't accessed for the rest of that
scope (i.e. until the other references don't exist any more).

Anyway, as far as I know the kernel is built with -fno-strict-aliasing.
Please correct me if I'm wrong or relying on aliasing is frowned upon.

>> +	*payload = sp;
>> +
>> +	dev_dbg(dev, "rx: parser: valid frame found (type: 0x%02x, len: %u)\n",
>> +		(*frame)->type, (*frame)->len);
>> +
>> +	return 0;
>> +}
> 
>> [...]
> 
>> +int sshp_parse_command(const struct device *dev, const struct ssam_span *source,
>> +		       struct ssh_command **command,
>> +		       struct ssam_span *command_data)
>> +{
>> +	// check for minimum length
>> +	if (unlikely(source->len < sizeof(struct ssh_command))) {
>> +		*command = NULL;
>> +		command_data->ptr = NULL;
>> +		command_data->len = 0;
>> +
>> +		dev_err(dev, "rx: parser: command payload is too short\n");
>> +		return -ENOMSG;
>> +	}
>> +
>> +	*command = (struct ssh_command *)source->ptr;
> 
> I'm quite sure this also violates strict aliasing.

It does, see above.

>> +	command_data->ptr = source->ptr + sizeof(struct ssh_command);
>> +	command_data->len = source->len - sizeof(struct ssh_command);
>> +
>> +	dev_dbg(dev, "rx: parser: valid command found (tc: 0x%02x, cid: 0x%02x)\n",
>> +		(*command)->tc, (*command)->cid);
>> +
>> +	return 0;
>> +}
> 
>> [...]
> 
>> +#define SSH_MSGOFFSET_FRAME(field) \
>> +	(sizeof(u16) + offsetof(struct ssh_frame, field))
>> +
>> +/**
>> + * SSH_MSGOFFSET_COMMAND() - Compute offset in SSH message to specified field
>> + * in command.
>> + * @field: The field for which the offset should be computed.
>> + *
>> + * Return: Returns the offset of the specified &struct ssh_command field in
>> + * the raw SSH message data.
>> + */
>> +#define SSH_MSGOFFSET_COMMAND(field) \
>> +	(2ull * sizeof(u16) + sizeof(struct ssh_frame) \
>> +		+ offsetof(struct ssh_command, field))
> 
> I believe it should be noted (here and for `SSH_MSGOFFSET_FRAME()`) why the
> `sizeof(u16)`s are necessary.

Right, I can add an explanation for this. One is for the SYN bytes, the
other one for the frame CRC (between frame and command).

>> +
>> +/*
>> + * SSH_MSG_SYN - SSH message synchronization (SYN) bytes as u16.
>> + */
>> +#define SSH_MSG_SYN		((u16)0x55aa)
> 
>> [...]
> 
>> +enum ssam_ssh_tc {
>> +	/* Known SSH/EC target categories. */
>> +				// category 0x00 is invalid for EC use
>> +	SSAM_SSH_TC_SAM = 0x01,	// generic system functionality, real-time clock
>> +	SSAM_SSH_TC_BAT = 0x02,	// battery/power subsystem
>> +	SSAM_SSH_TC_TMP = 0x03,	// thermal subsystem
>> +	SSAM_SSH_TC_PMC = 0x04,
>> +	SSAM_SSH_TC_FAN = 0x05,
>> +	SSAM_SSH_TC_PoM = 0x06,
>> +	SSAM_SSH_TC_DBG = 0x07,
>> +	SSAM_SSH_TC_KBD = 0x08,	// legacy keyboard (Laptop 1/2)
>> +	SSAM_SSH_TC_FWU = 0x09,
>> +	SSAM_SSH_TC_UNI = 0x0a,
>> +	SSAM_SSH_TC_LPC = 0x0b,
>> +	SSAM_SSH_TC_TCL = 0x0c,
>> +	SSAM_SSH_TC_SFL = 0x0d,
>> +	SSAM_SSH_TC_KIP = 0x0e,
>> +	SSAM_SSH_TC_EXT = 0x0f,
>> +	SSAM_SSH_TC_BLD = 0x10,
>> +	SSAM_SSH_TC_BAS = 0x11,	// detachment system (Surface Book 2/3)
>> +	SSAM_SSH_TC_SEN = 0x12,
>> +	SSAM_SSH_TC_SRQ = 0x13,
>> +	SSAM_SSH_TC_MCU = 0x14,
>> +	SSAM_SSH_TC_HID = 0x15,	// generic HID input subsystem
>> +	SSAM_SSH_TC_TCH = 0x16,
>> +	SSAM_SSH_TC_BKL = 0x17,
>> +	SSAM_SSH_TC_TAM = 0x18,
>> +	SSAM_SSH_TC_ACC = 0x19,
>> +	SSAM_SSH_TC_UFI = 0x1a,
>> +	SSAM_SSH_TC_USC = 0x1b,
>> +	SSAM_SSH_TC_PEN = 0x1c,
>> +	SSAM_SSH_TC_VID = 0x1d,
>> +	SSAM_SSH_TC_AUD = 0x1e,
>> +	SSAM_SSH_TC_SMC = 0x1f,
>> +	SSAM_SSH_TC_KPD = 0x20,
>> +	SSAM_SSH_TC_REG = 0x21,
>> +};
> 
> Is it known what these abbreviations stand for? Maybe I missed them?

The comments state all we really know about these (through observation
and experimentation). The table itself has been extracted from the
Windows driver, but the abbreviations and values are all we're getting
from it.

I could go ahead and guess for a couple of them but for most of them we
haven't really seen any request at all, let alone know what the request
does.

For those that we now, the abbreviations should be fairly easy to guess
based on the comments, e.g. BAT -> battery, TMP -> temperature. I'm not
sure about BAS, which could mean base (as that's the detachment system
allowing to separate the top part of the Surface Books from the base).

REG is currently missing a comment because I'm not entirely sure if it's
just for registring (enabling/disabling) events or if it also has any
other purpose. I'll add a comment for it though, then we have comments
on all that are somewhat known.

>> [...]
> 
>> +/**
>> + * struct ssh_request_ops - Callback operations for a SSH request.
>> + * @release:  Function called when the request's reference count reaches zero.
>> + *            This callback must be relied upon to ensure that the request has
>> + *            left the transport systems (both, packet an request systems).
>> + * @complete: Function called when the request is completed, either with
>> + *            success or failure. The command data for the request response
>> + *            is provided via the &struct ssh_command parameter (``cmd``),
>> + *            the command payload of the request response via the &struct
>> + *            ssh_span parameter (``data``).
>> + *
>> + *            If the request does not have any response or has not been
>> + *            completed with success, both ``cmd`` and ``data`` parameters will
>> + *            be NULL. If the request response does not have any command
>> + *            payload, the ``data`` span will be an empty (zero-length) span.
>> + *
>> + *            In case of failure, the reason for the failure is indicated by
>> + *            the value of the provided status code argument (``status``). This
>> + *            value will be zero in case of success.
> 
> I believe it should be noted if the `status` argument is a regular errno,
> or something different.

Right, I'll add that.

>> + *
>> + *            Note that a call to this callback does not guarantee that the
>> + *            request is not in use by the transport systems any more.
>> + */
>> +struct ssh_request_ops {
>> +	void (*release)(struct ssh_request *rqst);
>> +	void (*complete)(struct ssh_request *rqst,
>> +			 const struct ssh_command *cmd,
>> +			 const struct ssam_span *data, int status);
>> +};
>> [...]
> 
> 
> I have to agree, this is quite a sizable patch, although I think it's well-commented,
> which helps reading the code by a lot, however, in some places I feel like it's a bit
> over-engineered (or maybe I just cannot fully appreciate the subject at hand at the moment),
> nonetheless, I applaud your efforts, I can only imagine the hours that must have gone into it.

I think much of what's probably considered over-engineered is the result
of reworking the core after that had some reliability issues (dropped
packets and timeouts). Specifically, the introduction of dedicated
transmitter and receiver threads combined with the need to properly
handle NAKs has lead to the current asynchronous system.

I have probably gone a bit too far towards generifying that, but I
belive that this should make it easier to adapt for protocol additions
or errors in the future.

Other parts, like the RB-tree for event reference counting seem,
unfortunately, to be necessary. Events are enabled by registry
(specifying which command to use to enable/disable the event) and ID
(which event to enable/disable on the registry). So without knowing
which registry and ID pairs are valid, we'll have to use some sort of
map. Could have been a simple list, but I think an RB-tree makes a bit
more sense here.

Thank you for your review!

Regards,
Max
