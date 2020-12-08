Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9E2D2D51
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgLHOiF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgLHOiE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 09:38:04 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512DAC061749;
        Tue,  8 Dec 2020 06:37:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a6so2253195wmc.2;
        Tue, 08 Dec 2020 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApvRpk4oyBIGBp5s7ODT6z3UED4vgwrNjUYFwBg/syc=;
        b=W6r5fw7KHR9Q5rJmVhX3MIlHcXVaTnb0U8TmX+YdXFqFoYx46eUPO36J2wJcjYgYTB
         Cxtv92f5Ow2GWax9gIyHn40GUJLeyxZ2ecvlq1DAmrSclFtxBiF+QM3HIWWJnx+9erTv
         warMHCOxu06MX5sFMEvvZx63H3jPitOd42FxZKTF52f6dHc3yVIol5m+8CcNSxTT1HIf
         3U3yQDvezI46A8dpTt4OJT4uu+MLTHMb4cxW3pSsAy6HCJWC6Eaqr9DuljmP+Ch0AsIe
         Jr+RAJjWbKUpJfYJQ4yRvoHeODEPYGdo9FzJzrh8/8QYUt9BjpRMn4oKR6qXKv+mQGCT
         srZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApvRpk4oyBIGBp5s7ODT6z3UED4vgwrNjUYFwBg/syc=;
        b=OFTK3r4auxu3USnPqBc15OCDm+ZLgx1FZIVqinK5p8YOdxCXsxUX+eprJx/UmL88Ng
         9/0/+e29FcFDCN9nXhRGgTjCaS55obXOp/2QeHw/YwGjvczbUY1lSVmTGvW2DAABimau
         nF7A8BkJ2wtv1rJymQNkoVZHq8ccFGR6n7rqiI/flI28m//1LmsjUpay63WFly2miiEB
         EsYEu/MfZ6eqPJ0IGEgrIwSJ7q5GWFaket5uWp0eYb2GwJZ3/wWyUCj2+AhxwWwtYBh7
         sYOS75JY9gD0b+yiiTMkLbYokbCuglBRlGcuB1s44x8QBnfPQqsCwY2D1z++K9Iqj/mA
         XjMA==
X-Gm-Message-State: AOAM5309HVzXDIA5BpTqEeGcvZ3d05kexeynBvqSMsi+OWfYlBr5shqj
        vlplfxSKWNv99GX7Nzw6NSUwnlA5t4Y=
X-Google-Smtp-Source: ABdhPJwB5s+EilVJ0+bU1FAtvI/r3ZR0Eqg2AQb3HOBRt+22vIY5RkGSAmZh1xEwpUB/EShmUoNHqQ==
X-Received: by 2002:a1c:9c8e:: with SMTP id f136mr4182956wme.79.1607438242095;
        Tue, 08 Dec 2020 06:37:22 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a486.dip0.t-ipconnect.de. [217.229.164.134])
        by smtp.gmail.com with ESMTPSA id m8sm4011348wmc.27.2020.12.08.06.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:37:21 -0800 (PST)
Subject: Re: [PATCH v2 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-2-luzmaximilian@gmail.com>
 <fd24d99a-e4f4-2030-e9bb-bcd549ce4bb9@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <ac50a0c7-806e-d949-6440-620ec966099a@gmail.com>
Date:   Tue, 8 Dec 2020 15:37:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <fd24d99a-e4f4-2030-e9bb-bcd549ce4bb9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/8/20 2:01 PM, Hans de Goede wrote:
> Hi,
> 
> Thank you for your patch series.
> 
> Full review done, I have a couple of minor review remarks inline below.
> 
> Note these are really all suggestions and not must fix for this to
> be merged items.

Thank you! I will try to address and fix them.

[...]

>> +/**
>> + * ssam_event_matches_notifier() - Test if an event matches a notifier.
>> + * @n: The event notifier to test against.
>> + * @event: The event to test.
>> + *
>> + * Return: Returns %true iff the given event matches the given notifier
> 
> s/iff/if/

Ack.

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
>> + *
>> + * Note: Must be synchronized by the caller with regards to other
>> + * ssam_nf_refcount_inc() and ssam_nf_refcount_dec() calls, e.g. via
>> + * ``nf->lock``. Note that this lock should also be used to ensure the
>> + * corresponding EC requests are sent, if necessary.
> 
> You write "e.g. via ``nf->lock``", are any other locking strategies used
> in the other patches ?  If not then it might be good to change this to just
> stating that nf->lock must be held and adding an assert for that. I would
> prefer a clear set of locking rules like this over rules like:
> "must be synchronized ...".

There are no other locking strategies here. I've worded it this way as
"nf->lock" is mainly intended to synchronize the enable requests and is
just by extension also used to synchronize this (i.e. the lock is on a
different abstraction layer). I agree that for clarity it makes sense to
directly specify "nf->lock", so I will re-write this to just say that
"nf->lock" must be held.
  
> Note I am naively assuming here that it is possible to come up with such a
> clear set of locking rules, I'm not sure if that is the case.
> 
> Note in case it is possible to always take nf->lock but you are not doing
> so in some places because of performance concerns then I would prefer to
> move to a model where the caller simply always takes nf->lock. AFAICT non
> of the events/data going through the SSH are high frequency (iow
> none of them occur at a high rate of see 50 times / second or more) so
> I don't think that we need to focus too much on optimizing things for
> speed.

The registration/deregistration functions are all synchronized via
"nf->lock". I also don't consider that path critical. Event handling
(i.e. the actual critical path) is done via a RCU list (reasoning behind
that is mostly for touchpad input events).

>> + *
>> + * Return: Returns the refcount entry on success. Returns an error pointer
>> + * with %-ENOSPC if there have already been %INT_MAX events of the specified
>> + * ID and type registered, or %-ENOMEM if the entry could not be allocated.
>> + */
>> +static struct ssam_nf_refcount_entry
>> +*ssam_nf_refcount_inc(struct ssam_nf *nf, struct ssam_event_registry reg,
>> +		      struct ssam_event_id id)
>> +{
>> +	struct ssam_nf_refcount_entry *entry;
>> +	struct ssam_nf_refcount_key key;
>> +	struct rb_node **link = &nf->refcount.rb_node;
>> +	struct rb_node *parent = NULL;
>> +	int cmp;
>> +
>> +	key.reg = reg;
>> +	key.id = id;
>> +
>> +	while (*link) {
>> +		entry = rb_entry(*link, struct ssam_nf_refcount_entry, node);
>> +		parent = *link;
>> +
>> +		cmp = memcmp(&key, &entry->key, sizeof(key));
>> +		if (cmp < 0) {
>> +			link = &(*link)->rb_left;
>> +		} else if (cmp > 0) {
>> +			link = &(*link)->rb_right;
>> +		} else if (entry->refcount < INT_MAX) {
>> +			entry->refcount++;
>> +			return entry;
>> +		} else {
> 
> So we hit this only if entry->refcount == INT_MAX, right?
> 
> That seems like something which should never happen, right?
> 
> So maybe add a:
> 
> 			WARN_ON(1);
> 
> here?

Yes and yes. That seems like a good idea, I'll do that.

>> +			return ERR_PTR(-ENOSPC);
>> +		}
>> +	}
>> +
>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	entry->key = key;
>> +	entry->refcount = 1;
>> +
>> +	rb_link_node(&entry->node, parent, link);
>> +	rb_insert_color(&entry->node, &nf->refcount);
>> +
>> +	return entry;
>> +}

[...]

>> +/**
>> + * ssam_nf_call() - Call notification callbacks for the provided event.
>> + * @nf:    The notifier system
>> + * @dev:   The associated device, only used for logging.
>> + * @rqid:  The request ID of the event.
>> + * @event: The event provided to the callbacks.
>> + *
>> + * Execute registered callbacks in order of their priority until either no
>> + * callback is left or a callback returns a value with the %SSAM_NOTIF_STOP
>> + * bit set. Note that this bit is set automatically when converting non-zero
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
>> +		dev_warn(dev, "event: unsupported rqid: %#06x\n", rqid);
>> +		return;
>> +	}
>> +
>> +	nf_head = &nf->head[ssh_rqid_to_event(rqid)];
>> +	nf_ret = ssam_nfblk_call_chain(nf_head, event);
>> +	status = ssam_notifier_to_errno(nf_ret);
>> +
>> +	if (status < 0) {
>> +		dev_err(dev,
>> +			"event: error handling event: %d (tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
>> +			status, event->target_category, event->target_id,
>> +			event->command_id, event->instance_id);
>> +	}
>> +
>> +	if (!(nf_ret & SSAM_NOTIF_HANDLED)) {
> 
> Maybe use "else if" here so that on an error we don't emit both the error
> and the unhandled event warning ?

Right, makes sense. An error should be enough.

>> +		dev_warn(dev,
>> +			 "event: unhandled event (rqid: %#04x, tc: %#04x, tid: %#04x, cid: %#04x, iid: %#04x)\n",
>> +			 rqid, event->target_category, event->target_id,
>> +			 event->command_id, event->instance_id);
>> +	}
>> +}
>> +

[...]

>> +static int ssam_dsm_get_functions(acpi_handle handle, u64 *funcs)
>> +{
>> +	union acpi_object *obj;
>> +	u64 mask = 0;
>> +	int i;
>> +
>> +	*funcs = 0;
>> +
>> +	if (!acpi_has_method(handle, "_DSM"))
>> +		return 0;
> 
> Is this expected on some models?

It is, yes. Specifically: Older models don't have that, newer do.

> If yes then maybe add a comment.

Right. I'll have to look at the DSDTs to check in which generation
specifically that _DSM was introduced and add that as a comment.

> If not then I think this can be dropped as acpi_evaluate_dsm_typed()
> will then error out with -EIO which seems better then return 0
> (while this is not expected).
> 
>> +
>> +	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
>> +				      SSAM_SSH_DSM_REVISION, 0, NULL,
>> +				      ACPI_TYPE_BUFFER);
>> +	if (!obj)
>> +		return -EIO;
>> +
>> +	for (i = 0; i < obj->buffer.length && i < 8; i++)
>> +		mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
>> +
>> +	if (mask & BIT(0))
>> +		*funcs = mask;
>> +
>> +	ACPI_FREE(obj);
>> +	return 0;
>> +}
>> +
>> +static int ssam_dsm_load_u32(acpi_handle handle, u64 funcs, u64 func, u32 *ret)
>> +{
>> +	union acpi_object *obj;
>> +	u64 val;
>> +> +	if (!(funcs & BIT(func)))
>> +		return 0;
> 
> This exit path leaves *ret uninitialized, looking at the usage if this
> function I see that this is intentional, but it did stood out to me, so maybe
> add a comment like this ? :
> 
> 	if (!(funcs & BIT(func)))
> 		return 0; /* Not supported leave *ret at its default value */

Right, will do that.

>> +
>> +	obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
>> +				      SSAM_SSH_DSM_REVISION, func, NULL,
>> +				      ACPI_TYPE_INTEGER);
>> +	if (!obj)
>> +		return -EIO;
>> +
>> +	val = obj->integer.value;
>> +	ACPI_FREE(obj);
>> +
>> +	if (val > U32_MAX)
>> +		return -ERANGE;
>> +
>> +	*ret = val;
>> +	return 0;
>> +}

[...]

>> +/**
>> + * ssam_controller_start() - Start the receiver and transmitter threads of the
>> + * controller.
>> + * @ctrl: The controller.
>> + *
>> + * Note: When this function is called, the controller should be properly
>> + * hooked up to the serdev core via &struct serdev_device_ops. Please refer
>> + * to ssam_controller_init() for more details on controller initialization.
>> + *
>> + * This function must be called from an exclusive context with regards to the
>> + * state, if necessary, by locking the controller via ssam_controller_lock().
> 
> Again you are being a bit hand-wavy (I assume you know what I mean by that)
> wrt the locking requirements. If possible I would prefer clearly spelled out
> locking requirements in the form of "this and that lock must be held when
> calling this function". Preferably backed-up by lockdep_assert-s asserting
> these conditions.

The reason for this is that this function specifically is currently only
called during initialization, when the controller has not been published
yet, i.e. when we have an exclusive reference to the controller.

I'll change this to fully enforce locking (with lockdep_assert).

> And maybe if you are a bit stricter with always holding the lock when
> calling this, you can also drop the WRITE_ONCE and the comment about it
> (in all places where you do this).

The WRITE_ONCE is only there to ensure that the basic test in
ssam_request_sync_submit() can be done. I always try to be explicit
about access that can happen without the respective locks being held.

Unfortunately it's not feasible to hold the reader lock in
ssam_request_sync_submit() due to reentrancy. Specifically, as the lock,
if at all (i.e. if this is not a client driver bound to the controller),
must be held not only during submission but until the request has been
completed. Note that if we would hold the lock during submission, this
is just a smoke-test.

> Note, that like my remarks around the locking docs for
> ssam_nf_refcount_inc() this assumes that it is possible to come
> up with such a clear set of locking rules.  If that for some reason
> is not straight forwardd, then maybe add some docs documenting the
> locking expectations somewhere instead ?

It's possible to fully enforce this here, so I'll do that.

>> + */
>> +int ssam_controller_start(struct ssam_controller *ctrl)
>> +{
>> +	int status;
>> +
>> +	if (ctrl->state != SSAM_CONTROLLER_INITIALIZED)
>> +		return -EINVAL;
>> +
>> +	status = ssh_rtl_start(&ctrl->rtl);
>> +	if (status)
>> +		return status;
>> +
>> +	/*
>> +	 * Set state via write_once even though we expect to be locked/in an
>> +	 * exclusive context, due to smoke-testing in
>> +	 * ssam_request_sync_submit().
>> +	 */
>> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STARTED);
>> +	return 0;
>> +}
>> +
>> +/*
>> + * SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT - Timeout for flushing requests during
>> + * shutdown.
>> + *
>> + * Chosen to be larger than one full request timeout, including packets timing
>> + * out. This value should give ample time to complete any outstanding requests
>> + * during normal operation and account for the odd package timeout.
>> + */
>> +#define SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT	msecs_to_jiffies(5000)
>> +
>> +/**
>> + * ssam_controller_shutdown() - Shut down the controller.
>> + * @ctrl: The controller.
>> + *
>> + * Shuts down the controller by flushing all pending requests and stopping the
>> + * transmitter and receiver threads. All requests submitted after this call
>> + * will fail with %-ESHUTDOWN. While it is discouraged to do so, this function
>> + * is safe to use in parallel with ongoing request submission.
>> + *
>> + * In the course of this shutdown procedure, all currently registered
>> + * notifiers will be unregistered. It is, however, strongly recommended to not
>> + * rely on this behavior, and instead the party registering the notifier
>> + * should unregister it before the controller gets shut down, e.g. via the
>> + * SSAM bus which guarantees client devices to be removed before a shutdown.
>> + *
>> + * Note that events may still be pending after this call, but, due to the
>> + * notifiers being unregistered, these events will be dropped when the
>> + * controller is subsequently destroyed via ssam_controller_destroy().
>> + *
>> + * This function must be called from an exclusive context with regards to the
>> + * state, if necessary, by locking the controller via ssam_controller_lock().
> 
> Same comment as earlier wrt the locking.

Similar to the above, this can be currently called outside of the lock
during initialization failure. I'll change that to fully enforce locking
too.
>> + */
>> +void ssam_controller_shutdown(struct ssam_controller *ctrl)
>> +{
>> +	enum ssam_controller_state s = ctrl->state;
>> +	int status;
>> +
>> +	if (s == SSAM_CONTROLLER_UNINITIALIZED || s == SSAM_CONTROLLER_STOPPED)
>> +		return;
>> +
>> +	/*
>> +	 * Try to flush pending events and requests while everything still
>> +	 * works. Note: There may still be packets and/or requests in the
>> +	 * system after this call (e.g. via control packets submitted by the
>> +	 * packet transport layer or flush timeout / failure, ...). Those will
>> +	 * be handled with the ssh_rtl_shutdown() call below.
>> +	 */
>> +	status = ssh_rtl_flush(&ctrl->rtl, SSAM_CTRL_SHUTDOWN_FLUSH_TIMEOUT);
>> +	if (status) {
>> +		ssam_err(ctrl, "failed to flush request transport layer: %d\n",
>> +			 status);
>> +	}
>> +
>> +	/* Try to flush all currently completing requests and events. */
>> +	ssam_cplt_flush(&ctrl->cplt);
>> +
>> +	/*
>> +	 * We expect all notifiers to have been removed by the respective client
>> +	 * driver that set them up at this point. If this warning occurs, some
>> +	 * client driver has not done that...
>> +	 */
>> +	WARN_ON(!ssam_notifier_is_empty(ctrl));
>> +
>> +	/*
>> +	 * Nevertheless, we should still take care of drivers that don't behave
>> +	 * well. Thus disable all enabled events, unregister all notifiers.
>> +	 */
>> +	ssam_notifier_unregister_all(ctrl);
>> +
>> +	/*
>> +	 * Cancel remaining requests. Ensure no new ones can be queued and stop
>> +	 * threads.
>> +	 */
>> +	ssh_rtl_shutdown(&ctrl->rtl);
>> +
>> +	/*
>> +	 * Set state via write_once even though we expect to be locked/in an
>> +	 * exclusive context, due to smoke-testing in
>> +	 * ssam_request_sync_submit().
>> +	 */
>> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_STOPPED);
>> +	ctrl->rtl.ptl.serdev = NULL;
>> +}
>> +
>> +/**
>> + * ssam_controller_destroy() - Destroy the controller and free its resources.
>> + * @ctrl: The controller.
>> + *
>> + * Ensures that all resources associated with the controller get freed. This
>> + * function should only be called after the controller has been stopped via
>> + * ssam_controller_shutdown(). In general, this function should not be called
>> + * directly. The only valid place to call this function directly is during
>> + * initialization, before the controller has been fully initialized and passed
>> + * to other processes. This function is called automatically when the
>> + * reference count of the controller reaches zero.
>> + *
>> + * Must be called from an exclusive context with regards to the controller
>> + * state.
> 
> Same comment as earlier wrt the locking.

Right, I'll change that as well.

>> + */
>> +void ssam_controller_destroy(struct ssam_controller *ctrl)
>> +{
>> +	if (ctrl->state == SSAM_CONTROLLER_UNINITIALIZED)
>> +		return;
>> +
>> +	WARN_ON(ctrl->state != SSAM_CONTROLLER_STOPPED);
>> +
>> +	/*
>> +	 * Note: New events could still have been received after the previous
>> +	 * flush in ssam_controller_shutdown, before the request transport layer
>> +	 * has been shut down. At this point, after the shutdown, we can be sure
>> +	 * that no new events will be queued. The call to ssam_cplt_destroy will
>> +	 * ensure that those remaining are being completed and freed.
>> +	 */
>> +
>> +	/* Actually free resources. */
>> +	ssam_cplt_destroy(&ctrl->cplt);
>> +	ssh_rtl_destroy(&ctrl->rtl);
>> +
>> +	/*
>> +	 * Set state via write_once even though we expect to be locked/in an
>> +	 * exclusive context, due to smoke-testing in
>> +	 * ssam_request_sync_submit().
>> +	 */
>> +	WRITE_ONCE(ctrl->state, SSAM_CONTROLLER_UNINITIALIZED);
>> +}
>> +

[...]

>> +/* Must be called with queue lock held. */
>> +static struct list_head *__ssh_ptl_queue_find_entrypoint(struct ssh_packet *p)
>> +{
>> +	struct list_head *head;
>> +	struct ssh_packet *q;
>> +
>> +	/*
>> +	 * We generally assume that there are less control (ACK/NAK) packets
>> +	 * and re-submitted data packets as there are normal data packets (at
>> +	 * least in situations in which many packets are queued; if there
>> +	 * aren't many packets queued the decision on how to iterate should be
>> +	 * basically irrelevant; the number of control/data packets is more or
>> +	 * less limited via the maximum number of pending packets). Thus, when
>> +	 * inserting a control or re-submitted data packet, (determined by
>> +	 * their priority), we search from front to back. Normal data packets
>> +	 * are, usually queued directly at the tail of the queue, so for those
>> +	 * search from back to front.
>> +	 */
>> +
>> +	if (p->priority > SSH_PACKET_PRIORITY(DATA, 0)) {
>> +		list_for_each(head, &p->ptl->queue.head) {
>> +			q = list_entry(head, struct ssh_packet, queue_node);
>> +
>> +			if (q->priority < p->priority)
>> +				break;
>> +		}
>> +	} else {
>> +		list_for_each_prev(head, &p->ptl->queue.head) {
>> +			q = list_entry(head, struct ssh_packet, queue_node);
>> +
>> +			if (q->priority >= p->priority) {
>> +				head = head->next;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	return head;
>> +}
>> +
>> +/* Must be called with queue lock held. */
> 
> Maybe add a lockdep_assert for this ?
> 
> (and the same for a bunch of similar cases below)

Right, makes sense. I'll do that.

>> +static int __ssh_ptl_queue_push(struct ssh_packet *packet)
>> +{
>> +	struct ssh_ptl *ptl = packet->ptl;
>> +	struct list_head *head;
>> +
>> +	if (test_bit(SSH_PTL_SF_SHUTDOWN_BIT, &ptl->state))
>> +		return -ESHUTDOWN;
>> +
>> +	/* Avoid further transitions when canceling/completing. */
>> +	if (test_bit(SSH_PACKET_SF_LOCKED_BIT, &packet->state))
>> +		return -EINVAL;
>> +
>> +	/* If this packet has already been queued, do not add it. */
>> +	if (test_and_set_bit(SSH_PACKET_SF_QUEUED_BIT, &packet->state))
>> +		return -EALREADY;
>> +
>> +	head = __ssh_ptl_queue_find_entrypoint(packet);
>> +
>> +	list_add_tail(&ssh_packet_get(packet)->queue_node, head);
>> +	return 0;
>> +}
> 
> <snip about 5000 more lines>
> 
> Snipped because nothing stood out in the rest of this patch.
> 
> Phew that was one large patch to review. I've run out of review
> bandwidth for today, so I will review the rest of the series
> later (probably coming Thursday).

I'm sorry about the size of this. I've tried to split out as much as
possible (caching, tracing, error injection) but couldn't get it smaller
than this while also having something functional.

Please do review this at your own pace. There is no need to hurry.

Thank you for your review!

Regards,
Max
