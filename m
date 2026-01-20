Return-Path: <linux-acpi+bounces-20455-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOD/N4Osb2miEwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20455-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:25:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 932354772A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7F4C763465
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C943D508;
	Tue, 20 Jan 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhpn8dM2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C243D502
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918716; cv=none; b=VbqbyZU7V6TdOsFhbsUJLbH+GoMObKSrWMW5sTCGxcFpniBZOo0gMZOi5iP/tof+sC+YZ2ai9XhIJiwfBSNtNxhzjojQpouquyRWfS1DRHOwZeRiwhxljts4jGimpIJKKrH0gw2rROMiHLRNEkyKjlHn2nz9LjFeIGLTZXPjxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918716; c=relaxed/simple;
	bh=Jw7qbIy3KUpbgCnoSil3Zz56wqIO7WBDCLT6tIn2ibo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTWbGJ++gwA+fjWhC00zMo7NwX0ByQjh3DDozqfu1ulMjZB2F0K6YXfN/W/hYCsP+QsZc2YDTV8xHzRoEqKIngDGv2Mt0FBUt+0NOUVHAzLLZxiGuJY9BUIYU6TECyIVYnV0cW0hXwtXO6xDnSb1nma8wg7XMzWAgFTsFo8vZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhpn8dM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACADC2BC9E
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768918716;
	bh=Jw7qbIy3KUpbgCnoSil3Zz56wqIO7WBDCLT6tIn2ibo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xhpn8dM25eKFDUCOqABqaoL8waLoBlvq5zq98wbkSyDQHTrnuySxCIBJIhPWuPvPU
	 G/K8PV0UHNMLj4bS03z+n6repihVlOEqjeI6g1AyYGPBGGBhOL2yoDqIZNkuC/JSiv
	 TcpBk0FN3h/4TDqyGUvpc8UvI1rdJVgxiIFsFsB4jDJLP1WwyWQLBsxP0ZmT+xDWos
	 dRWLcnAbW9DlE2iqifbr8OiASYHfkTeYD2SlWkaNJxZmLSW5PEXbJeTuZTxktUByTM
	 8hffS5iwVMoIDSuw83wg2kWNWVltBOFWv8UOk2ao4bmfLp0I9wx2K51Yk5wNUr9qxv
	 RS0lH5zvfOi8w==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4043b909ed4so3334971fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 06:18:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgfmgnnJ1sA+IrYvvYGMQnqq4hDsv8sanXtVwnQb1kCiXiG12HtSBYivB373zwQFIGlRwRT2cvAN9j@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxe4DdW8tI/8l9H3l2AfpxfQSLkkXJaIguBvmC21iexRBLIG3
	ZQGIvJ8UAVA4IKPnUhTCmI+WiXqfm6jQzEpZicoUm0jFNng6nse/kll74vuSv2zCwgXDNQyI9Ne
	hH2SCtwAWV+DVW2H++f7iE3CUVwndqHo=
X-Received: by 2002:a05:6820:4deb:b0:65d:88b:c00b with SMTP id
 006d021491bc7-66117a0dbf6mr5172886eaf.74.1768918715352; Tue, 20 Jan 2026
 06:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch> <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com> <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
 <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com> <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
 <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
 <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com> <aW8sAyChG3hpycwp@smile.fi.intel.com>
 <CAJZ5v0j7hHgs_XEmNm=RKU8d09DMumN+nycfK+xDu-cNVZZOjQ@mail.gmail.com> <aW-Dk7-g5x03RKBT@smile.fi.intel.com>
In-Reply-To: <aW-Dk7-g5x03RKBT@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Jan 2026 15:18:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goFigvWofYC+xu4y0V5if6_KZn0QWwxCWm8+shFBZ7SQ@mail.gmail.com>
X-Gm-Features: AZwV_QiY_RJZXF6RodNX7yOAzmkkRBkGXS8gSs9ZrhhTzZXp3UGFgz3jybua1dU
Message-ID: <CAJZ5v0goFigvWofYC+xu4y0V5if6_KZn0QWwxCWm8+shFBZ7SQ@mail.gmail.com>
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ivan Vecera <ivecera@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-20455-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 932354772A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 2:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 20, 2026 at 01:30:57PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 20, 2026 at 8:17=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Jan 20, 2026 at 06:39:31AM +0100, Ivan Vecera wrote:
> > > > On 1/20/26 12:34 AM, Linus Walleij wrote:
> > > > > On Mon, Jan 19, 2026 at 9:28=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> (...)
>
> > > > > > > > > Based on [1] example this clock relationship can be repre=
sented by _DSD.
> > > > > > > > > Is it correct?
> > > > > > > >
> > > > > > > > I didn't really get, is this a clock provider-consumer rela=
tions or pin
> > > > > > > > connections? If this is a pin connections, why there is no =
pin mux driver
> > > > > > > > for it?
> > > > > > >
> > > > > > > In fact this should be dpll provider-consumer schema. Consume=
r (e.g.
> > > > > > > net device, phy...) uses (consumes) DPLL service (frequency
> > > > > > > synchronization, ...) and DPLL device provides such service.
> > > > > > >
> > > > > > > Note that the pin in this context is DPLL pin not pin related=
 to pinctrl
> > > > > > > or so...
> > > > > >
> > > > > > Right, so these are pins with special functions, which are not =
GPIO like.
> > > > > > But pin mux is not only about GPIO, that's the nice part of it.
> > > > > >
> > > > > > +Cc: Linus for his view on this issue.
> > > > >
> > > > > In theory a pin controller can be instantiated in any random driv=
er that
> > > > > controls a few pins of its own to the outside world, just like we=
 have a few
> > > > > few-pin GPIO chips here and there such as for USB serial adapters=
.
> > > > >
> > > > > In practice nobody does this, they have some driver-local way of =
handling
> > > > > pins and mux them around for their special use case.
> > > > >
> > > > > Graphic cards or audio would be an example. Much custom muxing
> > > > > happening there I think.
> > > > >
> > > > > I have no strong opinion on the subject, it's up to the driver au=
thor I think.
> > > > >
> > > > > ACPI aspects I can't talk about because I don't understand them..=
.
> > > > >
> > > > > Hope this helps!
> > > >
> > > > I think we might be getting sidetracked by the specific subsystems
> > > > (pinctrl/GPIO/Clock).
> > >
> > > Yes, and this happens due to the DT point of view as far as I underst=
ood their
> > > preferences. If it's modeled as clock inputs and outputs we should co=
nsider the
> > > same in ACPI, otherwise it will be custom hack on top of the (agreed)=
 way of
> > > solving the issue.
> > >
> > > Nature of the connection (and hence the responsible subsystem in the =
software)
> > > is the key here. Until we fully understand what's this, we can't prop=
erly model
> > > it.
> > >
> > > > The core problem I am trying to solve is modeling the linkage betwe=
en
> > > > the two devices. The NIC acts as a consumer that needs to "know" ab=
out
> > > > the DPLL (the supplier) in the ACPI table.
> > > >
> > > > We need a way to tell the NIC driver: "Here is a handle to the DPLL
> > >
> > > "handle to device" in ACPI assumes the Device() object somewhere in
> > > the namespace. This is what you have in the ASL example.
> > >
> > > > device you are connected to, and here are the specific resource IDs
> > > > (pins) you are wired to. So a user (userspace) can monitor/configur=
e
> > > > such DPLL inputs and outputs using DPLL Netlink API."
> > > >
> > > > Regardless of whether the underlying signal is a clock or a logic l=
evel,
> > > > the immediate requirement is simply resolving this cross-device dep=
endency
> > > > so the NIC can identify these resources and report their IDs into u=
serspace.
> > >
> > > Yes, but "simply" not always means "the best" in the long-term. As I =
said,
> > > your proposed idea doesn't contradict ACPI concepts, the problem is t=
hat
> > > it may lead to custom solution for the specific hardware and next one=
 will
> > > create their own N + 1 way of solving the same issue.
> >
> > And no one will ship the requisite data in the firmware.
> >
> > > One note nevertheless, instead of "reg" property the ACPI has concept=
 of _ADR
> > > method. We even have acpi_get_local_address() helper for that.
> >
> > It's not exactly that.  _ADR is for device lookup on self-enumerable
> > buses, and I'm not sure if that's the use case here.
>
> Ah, thanks for chiming in. Indeed, 6.1.1. "_ADR (Address)" specifies that=
.
> Although we have some (mis)uses of _ADR in the cases when it corresponds
> to 'reg', exempli gratia the I=C2=B2C mux ASL requires _ADR while I=C2=B2=
C bus (behind
> the mux) is arguably self-enumerable.

There are exceptions, but let's not go into that territory.

As a rule, a "reg" would correspond to a resource in _CRS, except for
the cases like _CPC when registers are pointed to individually through
GAS structures.

Generally speaking, using device properties for describing resources
in ACPI is not something people are used to.  _CRS is used for that in
general.

