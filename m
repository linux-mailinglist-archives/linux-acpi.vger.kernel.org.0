Return-Path: <linux-acpi+bounces-1072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7A7DA1D0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0092825A3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E63FB10
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lm/WGIyR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA53AC22
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 19:14:46 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E312A;
	Fri, 27 Oct 2023 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=s5bWgVKpwmS1KllHLKJH6MgftoWkWiVLZ4YJm3tjFD4=; b=Lm/WGIyRJjJfRsdY53T4rtZXPq
	WgEnLip1WsWSzW7hPSzoqL3CkCULHfUqtiixPcHU4/Sxv9t6be3iGrvGzZew4mdXYdxefVxVgfguG
	1Wc4tIvraqp9VyCAIXs6nZAihLnhEB4BS9+nZgnlNTHc8WRZSWBsPM3vGdiW+KDbyEOJF67JqVEED
	NClrnbYbx/v6G6CiuRkqAqqgHY2C7GJrPGWmPprcbX4CSTgFj2Xkc9tmaQT0DooiOlfp8xPfSC/hs
	nVBRqo+VDeyPMdkfUHOZ0Gg7l3L1PU7qIhMr404RXKYYXSOFWmEhDYADds/a+zdkJq1RZQQsM/Gy9
	qceYikrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qwSHz-0056Vr-SO; Fri, 27 Oct 2023 19:14:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84DA4300392; Fri, 27 Oct 2023 21:14:35 +0200 (CEST)
Date: Fri, 27 Oct 2023 21:14:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
	xen-devel <xen-devel@lists.xenproject.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] acpi_idle: use raw_safe_halt() from acpi_idle_play_dead()
Message-ID: <20231027191435.GF26550@noisy.programming.kicks-ass.net>
References: <a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org>

On Fri, Oct 27, 2023 at 07:36:51PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Xen HVM guests were observed taking triple-faults when attempting to
> online a previously offlined vCPU.
>=20
> Investigation showed that the fault was coming from a failing call
> to lockdep_assert_irqs_disabled(), in load_current_idt() which was
> too early in the CPU bringup to actually catch the exception and
> report the failure cleanly.
>=20
> This was a false positive, caused by acpi_idle_play_dead() setting
> the per-cpu hardirqs_enabled flag by calling safe_halt(). Switch it
> to use raw_safe_halt() instead, which doesn't do so.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> We might {also,instead} explicitly set the hardirqs_enabled flag to
> zero when bringing up an AP?

So I fixed up the idle paths the other day (see all that __cpuidle
stuff) but I've not yet gone through the whole hotplug thing :/

This seems right, at this point everything, including RCU is very much
gone, any instrumentation is undesired.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>=20
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 3a34a8c425fe..55437f5e0c3a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -592,7 +592,7 @@ static int acpi_idle_play_dead(struct cpuidle_device =
*dev, int index)
>  	while (1) {
> =20
>  		if (cx->entry_method =3D=3D ACPI_CSTATE_HALT)
> -			safe_halt();
> +			raw_safe_halt();
>  		else if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
>  			io_idle(cx->address);
>  		} else
> --=20
> 2.41.0
>=20
>=20



