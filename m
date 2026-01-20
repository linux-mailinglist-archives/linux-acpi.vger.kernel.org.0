Return-Path: <linux-acpi+bounces-20449-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB18IMAhcGlRVwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20449-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 01:45:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 337814EA9A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 01:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DBED687C9C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D403A9000;
	Tue, 20 Jan 2026 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syNsEsYp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE295345CB0
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912271; cv=none; b=BZIeWnZVNLx4soLhgRe4cSkp65UKt6VTE7cjt3mBpXWQNQ0g1iSZGHqlk2FVGGT9rn6rZ2sEoOgr5lsira2xLeaNiAe3dGwfo5SKSbCVvucphaacbNVapTi1A6Q7htpY90+LPcnF8ILFGHa5Eg1poQvYmCRADlqnsbjz0yTiFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912271; c=relaxed/simple;
	bh=zClkBIBbDbWJMB0XwsO5MC5IgYxJfRWUWnK7vEFoz+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfEXkHRxgJb5PMvxzqGGIcxtoPdYR9X1tzQIkZXgRZlXq7gFtUxyvqwFZRL80EjxSj4RBRcWxSOe8XTlUFKT2+u862WSmDpOUemglcMZyHuMqR42hDfuZvDUl7eAMxTxNaHYPES/1Psx9Geih6HrNKGZDXJiyQeaOFpZnjULO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syNsEsYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFFC19422
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768912271;
	bh=zClkBIBbDbWJMB0XwsO5MC5IgYxJfRWUWnK7vEFoz+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=syNsEsYpjRd4GhF2D3Gu9vGeZAVKfBfFAHj4nfKqsL2HNtsnXYm0j12A7C2GnHcmG
	 ZsZTVly83HwG7Z1iizYMBCvn7FASTeiJzdyQywbRmW22erAqTQAZVVfLdr9Z+JbG/n
	 OmuuEBfB8MSiWS2/rtt/hKhTeNx1GpMyxFGWVlJlSgCQsiHSFyYg1pHoIbii+lh9Dc
	 SHgz8SJXvX/OLQnfqrd+wpvBqC5HSXSektpMRDRQyaTx30zDYoj34J6e6JAmn30ifF
	 S5HWAcIQw8oO+oFJI04pF0f28rtnGT4n3ZsvmdTltIAiVTCJ+yLwgCgyo54GE1a/QZ
	 JI7ISP/L6xrYA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6610b241d19so2586409eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 04:31:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNRqmSHm+o8U4qhVGqPoZpPhi7Cy9enhL4tHAX4GwB8RrurSpCm43hJzJnegFBavDtQsReh4uK6Cr0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFA44xkLnRbq4CombNT0FaGL1Wa/z0YtlbPSP+JJL4VRdaFVAK
	9RmuLdgPqWVtRzXDINeW9icJ//6mJTVd/9KcV/4pbESltPc6/DzQuFB/OSQtoctG+mfMi1/lO1b
	QzBLiBaZyx4nATIxEhyaLr0O1TrnvRfc=
X-Received: by 2002:a05:6820:2219:b0:65c:fe5b:9f4d with SMTP id
 006d021491bc7-662b00a4a88mr570911eaf.47.1768912270702; Tue, 20 Jan 2026
 04:31:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com> <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com> <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com> <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
 <aW6UBBvFHP_gEg-V@smile.fi.intel.com> <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
 <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com> <aW8sAyChG3hpycwp@smile.fi.intel.com>
In-Reply-To: <aW8sAyChG3hpycwp@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Jan 2026 13:30:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j7hHgs_XEmNm=RKU8d09DMumN+nycfK+xDu-cNVZZOjQ@mail.gmail.com>
X-Gm-Features: AZwV_QgfyiQ3zKt27xcWCOkkITCJYhzDIgScK-HwaE39yU55GwNzJI65iNFSrVU
Message-ID: <CAJZ5v0j7hHgs_XEmNm=RKU8d09DMumN+nycfK+xDu-cNVZZOjQ@mail.gmail.com>
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20449-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 337814EA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 20, 2026 at 06:39:31AM +0100, Ivan Vecera wrote:
> > On 1/20/26 12:34 AM, Linus Walleij wrote:
> > > On Mon, Jan 19, 2026 at 9:28=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
>
> (...)
>
> > > > > > > Based on [1] example this clock relationship can be represent=
ed by _DSD.
> > > > > > > Is it correct?
> > > > > >
> > > > > > I didn't really get, is this a clock provider-consumer relation=
s or pin
> > > > > > connections? If this is a pin connections, why there is no pin =
mux driver
> > > > > > for it?
> > > > >
> > > > > In fact this should be dpll provider-consumer schema. Consumer (e=
.g.
> > > > > net device, phy...) uses (consumes) DPLL service (frequency
> > > > > synchronization, ...) and DPLL device provides such service.
> > > > >
> > > > > Note that the pin in this context is DPLL pin not pin related to =
pinctrl
> > > > > or so...
> > > >
> > > > Right, so these are pins with special functions, which are not GPIO=
 like.
> > > > But pin mux is not only about GPIO, that's the nice part of it.
> > > >
> > > > +Cc: Linus for his view on this issue.
> > >
> > > In theory a pin controller can be instantiated in any random driver t=
hat
> > > controls a few pins of its own to the outside world, just like we hav=
e a few
> > > few-pin GPIO chips here and there such as for USB serial adapters.
> > >
> > > In practice nobody does this, they have some driver-local way of hand=
ling
> > > pins and mux them around for their special use case.
> > >
> > > Graphic cards or audio would be an example. Much custom muxing
> > > happening there I think.
> > >
> > > I have no strong opinion on the subject, it's up to the driver author=
 I think.
> > >
> > > ACPI aspects I can't talk about because I don't understand them...
> > >
> > > Hope this helps!
> >
> > I think we might be getting sidetracked by the specific subsystems
> > (pinctrl/GPIO/Clock).
>
> Yes, and this happens due to the DT point of view as far as I understood =
their
> preferences. If it's modeled as clock inputs and outputs we should consid=
er the
> same in ACPI, otherwise it will be custom hack on top of the (agreed) way=
 of
> solving the issue.
>
> Nature of the connection (and hence the responsible subsystem in the soft=
ware)
> is the key here. Until we fully understand what's this, we can't properly=
 model
> it.
>
> > The core problem I am trying to solve is modeling the linkage between
> > the two devices. The NIC acts as a consumer that needs to "know" about
> > the DPLL (the supplier) in the ACPI table.
> >
> > We need a way to tell the NIC driver: "Here is a handle to the DPLL
>
> "handle to device" in ACPI assumes the Device() object somewhere in
> the namespace. This is what you have in the ASL example.
>
> > device you are connected to, and here are the specific resource IDs
> > (pins) you are wired to. So a user (userspace) can monitor/configure
> > such DPLL inputs and outputs using DPLL Netlink API."
> >
> > Regardless of whether the underlying signal is a clock or a logic level=
,
> > the immediate requirement is simply resolving this cross-device depende=
ncy
> > so the NIC can identify these resources and report their IDs into users=
pace.
>
> Yes, but "simply" not always means "the best" in the long-term. As I said=
,
> your proposed idea doesn't contradict ACPI concepts, the problem is that
> it may lead to custom solution for the specific hardware and next one wil=
l
> create their own N + 1 way of solving the same issue.

And no one will ship the requisite data in the firmware.

> One note nevertheless, instead of "reg" property the ACPI has concept of =
_ADR
> method. We even have acpi_get_local_address() helper for that.

It's not exactly that.  _ADR is for device lookup on self-enumerable
buses, and I'm not sure if that's the use case here.

