Return-Path: <linux-acpi+bounces-20909-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF/+Hk8BimluFQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20909-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 16:46:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220651121AD
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3538300B473
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217337FF55;
	Mon,  9 Feb 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3giKneR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40B37E2F1;
	Mon,  9 Feb 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651620; cv=none; b=t8ipfRNmTOeLhKea6BwvHSDR2wUfN7Mc3TpjjmbhudDSmpgt3gF/pgBnQEjEZAO1BzXbjDpPCm9gpfWxDIoTNJx/CbJJzVXeS87Mo/x6TIHHDZOByRBhYYSmtqFBo6ZmC0LRNz1juww7Eruxht4HE5EsXVLMin6q5eSxFJhbR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651620; c=relaxed/simple;
	bh=5DRu3dMpaADpDKLopx8dO5LEkVz+35Fl6LlXv05MFMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd8sG7S6t7IWV/SNaOy9whrrQaDcq2LnzpPaEXkdJa9d1AcjApbyBrmC6V7KAhWNvLx/V81yWCfkyQXX6kkXR43a9Aq5BloxhNu8Wr2nQm6ujEvww6PHXGRgFnCaBPAeDfe5S401Z3jWCqRg+WJRsCPeGBeNiEihVm6tTeso2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3giKneR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3742C116C6;
	Mon,  9 Feb 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770651620;
	bh=5DRu3dMpaADpDKLopx8dO5LEkVz+35Fl6LlXv05MFMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3giKneRdTIS8o5HAfKsCgyA3Vk576TJHuj27G++WpF4bVwo8cqDkL6Qmv+VYPGZ8
	 cuixX8S9UWdGdgfLNEhjWW+EobdUEmwbMpxPsUxHYKe2KuU+agUKPUb/oWYn35b27L
	 +GtecYO4Men19p1sVRPAWK38hPds7C0lkC1Rq2OvR9enQA/5TK2AbLY7olteRNqLCq
	 xJz0El8ZBaNm7AuLJLQxUx/LZGECtS+u6RnXBYid20/LgnxlvkWnspo+l0HdqD8tw6
	 cj29zBhNWE9FTbRHQQ2HoCrzcD3K5DGDHNgsfMuP9tHFWAvFpfgDJ/z1ciUy6p6Lr2
	 MqqCGfPCz2Nig==
Date: Mon, 9 Feb 2026 09:40:15 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: jassisinghbrar@gmail.com, Frank.Li@nxp.com, arm-scmi@vger.kernel.org, 
	cristian.marussi@arm.com, festevam@gmail.com, imx@lists.linux.dev, 
	jay.buddhabhatti@amd.com, jonathanh@nvidia.com, kernel@pengutronix.de, 
	konradybcio@kernel.org, krzk@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-tegra@vger.kernel.org, mathieu.poirier@linaro.org, 
	michal.simek@amd.com, nm@ti.com, rafael@kernel.org, robh@kernel.org, 
	s.hauer@pengutronix.de, shawn.guo@linaro.org, ssantosh@kernel.org, 
	sudeep.holla@kernel.org, tglx@kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v2 01/15] mailbox: Deprecate NULL mbox messages;
 Introduce mbox_ring_doorbell()
Message-ID: <yotr3aia3gra4jmlykqadqwi45lphhdyx7tt4n5cdwcungfpbd@gns6bb6m3vmz>
References: <20260208040240.1971442-1-dianders@chromium.org>
 <20260207200128.v2.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207200128.v2.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20909-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-acpi@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,vger.kernel.org,arm.com,lists.linux.dev,amd.com,nvidia.com,pengutronix.de,kernel.org,lists.infradead.org,linaro.org,ti.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 220651121AD
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 08:01:23PM -0800, Douglas Anderson wrote:
> The way the mailbox core behaves when you pass a NULL `mssg` parameter
> to mbox_send_message() is a little questionable. Specifically, the
> mailbox core stores the currently active message directly in its
> `active_req` field. In at least two places it decides that if this
> field is `NULL` then there is no active request. That means if `mssg`
> is ever NULL it will cause the mailbox core to think is no active
> request. The two places where it does this are:
> 
> 1. When a client calls mbox_send_message(), if `active_req` is NULL
>    then it will call the mailbox controller to send the new message
>    even if the mailbox controller hasn't yet called mbox_chan_txdone()
>    on the previous (NULL) message.
> 2. The mailbox core will never call the client's `tx_done()` callback
>    with a NULL message because `tx_tick()` returns early whenever the
>    message is NULL.
> 
> Though the above doesn't look like it was a conscious design choice,
> it does have the benefit of providing a simple way to assert an
> edge-triggered interrupt to the remote processor on the other side of
> the mailbox. Specifically:
> 
> 1. Like a normal edge-triggered interrupt, if multiple edges arrive
>    before the interrupt is Acked they are coalesced.
> 2. Like a normal edge-triggered interrupt, as long as the receiver
>    (the remote processor in this case) "Ack"s the interrupt _before_
>    checking for work and the sender (the mailbox client in this case)
>    posts the interrupt _after_ adding new work then we can always be
>    certain that new work will be noticed. This assumes that the
>    mailbox client and remote processor have some out-of-band way to
>    communicate work and the mailbox is just being used as an
>    interrupt.
> 
> Doing a `git grep -A1 mbox_send_message | grep NULL` shows 14 hits in
> mainline today, but it's not 100% clear if all of those users are
> relying on the benefits/quirks of the existing behavior.
> 
> Since the current NULL `mssg` behavior is a bit questionable but has
> some benefits, let's:
> 
> 1. Deprecate the NULL behavior and print a warning.
> 2. Add a new mbox_ring_doorbell() function that is very similar to the
>    existing NULL `mssg` case but a tad bit cleaner.
> 
> The design of the new mbox_ring_doorbell() will be to maximize
> compatibility with the old NULL `mssg` behavior. Specifically:
> 
> * We'll still pass NULL to the mailbox controller to indicate a
>   doorbell.
> * Doorbells will not be queued and won't have txdone.
> * We'll call immediately into the mailbox controller when a doorbell
>   is posted.
> 
> With the above, any mailbox clients that don't mix doorbells and
> normal messages are intended to see no change in behavior when
> switching to the new API. Using the new API, which officiall documents
> that mbox_client_txdone() shouldn't be called for doorbells, does
> allow us to remove those calls.
> 
> There are two differences in behavior between the old sending a NULL
> message and the new mbox_ring_doorbell():
> 
> 1. If the mailbox controller returned an error when trying to send a
>    NULL message, the old NULL message could have ended up being queued
>    up in the core's FIFO. Now we will just return the error.
> 2. If a client rings a doorbell while a non-doorbell message is in
>    progress, previously NULL messages would have been "queued" in that
>    case and now doorbells will be immediately posted.
> 
> I'm hoping that nobody was relying on either of the two differences.
> In general holding NULL messages in the mailbox core's queue has odd
> behavior and is hard to reason about. Hopefully it's reasonable to
> assume nobody was doing this.
> 
> As mentioned above, it should be noted that it's now documented that
> "txdone" shouldn't be called (by both mailbox drivers and clients) for
> doorbells. That being said, in most cases it won't hurt since the
> mailbox core will ignore the bogus "txdone". The only case where it's
> critical for a mailbox controller not to call "txdone" for a doorbell
> is when a mailbox channel mixes normal messages and doorbells and
> cares about the txdone callback. Specifically, when you ring a
> doorbell and immediately send a normal message, if the controller
> calls "txdone" for the doorbell it could look as if the normal message
> finished before it should have. This issue also would have happened
> with the old NULL `mssg`, though.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I like how this cleans up the logic hacks, but perhaps even more so how
it takes a step towards cleaning up the mailbox API when it comes to
expectations between client and provider implementations.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

