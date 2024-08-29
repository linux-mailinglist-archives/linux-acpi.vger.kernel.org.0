Return-Path: <linux-acpi+bounces-7950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED47963DF9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F53287826
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B4189F31;
	Thu, 29 Aug 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcXYZKsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cvLYtBtI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27A2BAEB;
	Thu, 29 Aug 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918676; cv=none; b=SNnzNXg/Cl6+kkp0VN95fAHj1ExvXgG/Fr/dfZ+3WeW6yfQ+E0HYbwHEC+em5WI6JgkC1JeKs+PggmuWltPXuPfcEIcVCnVcwFt2+0f7BtSMfQ4TlhY/gU8BUNzgabxEyXOhyS7KjtX5YYkSCj95Q7YJ5oGsdBeNNpexp2p+cXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918676; c=relaxed/simple;
	bh=aI4iTR7tkgxi9E/O+LO3sPJAywLCTCNo4Xh7wlrvrUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocLxSn7T2H/VthcZTVraN/WBNf2pBYsHTgUfyGHnBfO5AMO3pZRcjV/PbKnyn+6BAM5tNJW9og5ozgP+lCbO6YdtyFpUXB1lf7k9uRL/fEYdrZkxN9e3RCXqNAYsWPpu5c8HDXqILv0VFJv78zB97aFGoB55fSDSMjXb3PNvCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcXYZKsa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cvLYtBtI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724918672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LsMX+cDLXM0sEN1H8MTU9ShA0idUI61FD1DCYpj8FI=;
	b=mcXYZKsa7tEJZ8pgx/EiW3ZGvGYudX3dkZb3KEjMACuHI3yGlBjaJiKdA3HugIcL6I3JhP
	FVKWLVLek5y8KsyTbG2x2WiAnJctcBkWng5QIBsmTyWIz1O7jxlftP77WIRJYzFHW4bnPQ
	pNGpxTUOTjImw8wTkUR2x61bHTuS/Cg78+uHGXhfYl8NfaDHo536ycpvUtqWJHw7dIl7TI
	n09K4qJiKXKqFKYSeuv6gAIDUBc4cOKvqiT986P2a5GVgTxOhLZiV1J4A9UGk7Xguhpnzu
	+ToPWp4Y+r3bYMS9uy+jdQR6UPk0/qIaOZ77VZSdMiPsb4T/giuO3IjvmjM1Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724918672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LsMX+cDLXM0sEN1H8MTU9ShA0idUI61FD1DCYpj8FI=;
	b=cvLYtBtI9CHsYKxatQGa4EQW8PBcq9c06EgnLJXDqub2wHfDJ9olq/FK7kRdhpbncgPb68
	6lmUdZVKpN3tiGDA==
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
In-Reply-To: <87frqoig98.fsf@somnus>
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
 <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
 <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
 <CAJvTdK=-ETniiwzwLYH14+TeU0kA49gvTnqyRxH7-Hc6tzTBUw@mail.gmail.com>
 <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com>
 <87frqoig98.fsf@somnus>
Date: Thu, 29 Aug 2024 10:04:32 +0200
Message-ID: <87ikvjah67.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

[...]

> Lets have a deeper look to msleep() internals: msleep() uses timer list
> timers. Because of the design of the timer wheel (granularity of buckets
> increases with the levels) and because of the granularity of jiffies the
> sleep values will be longer as specified. Let's assume we are executing
> a msleep(1) on a HZ=250 system:
>
> First msecs are mapped on jiffies, so this results in a 4ms timeout
> value, as there is nothing shorter than 1 jiffie. Then the jiffie value
> is handed over to timer code and msleep() adds another jiffie to the
> timeout. The timeout is then 2 jiffies or 8ms. With this timeout a timer
> list timer is queued. To make sure that timers will not fire early or
> race with a concurrent incrementation of jiffie, timers are queued
> always into the next bucket. As the timer will end up in the first level
> of the timer wheel the granularity of the buckets is 1 jiffies. This
> means that the timeout would be 3 jiffies in worst case.
>
> The additional jiffie in msleep() is the historical prevention that the
> sleep time is at least the specified time. This is handled by timer
> wheel core code itself, so this extra jiffie could be removed. I will
> provide a patch for it.

I missed to use the whole cc list above when sending the patch:

  https://lore.kernel.org/r/20240829074133.4547-1-anna-maria@linutronix.de/

Thanks,

	Anna-Maria


