Return-Path: <linux-acpi+bounces-20722-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHLGNlNwemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20722-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:23:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D73A8754
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D7743006114
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6F32862C;
	Wed, 28 Jan 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOmZU//1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5B2EAB71
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631823; cv=none; b=Yg8yKkrUvypryqDhQBrohW222Clc+5IllNXyM3Ne1DdeHw5BC1Yq1YNloK1TBv9qFpl8VZftcj+RFn+0VjlIJ4QQ0RAvs9BsHR7nNR8xxuKllTvzosiOuLb3p54XEpced7sgn/acbjwbOgqjQN7xu8k5+Woi4JPWmzC6rYgpW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631823; c=relaxed/simple;
	bh=u8nmt4hpnrhnO0R2BJQLnP2k7TkNdv5zf07IWLn++eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPTTOM+k6tG9NfOiCcLRDj3zSUYFVo3lyZ/10jzfNF23pgne/0kCBmRxiA02xsd+t/uB0BuH5nhLIPWQYC4ax1ZYGAKgOznCUQodplQPJCT6yXuzRN+XZ0lEn4bUqb4irqdPYyuX0+pXuCJxOEVFjyfGINckZReYN6dX1PCzJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOmZU//1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487BEC116C6
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769631823;
	bh=u8nmt4hpnrhnO0R2BJQLnP2k7TkNdv5zf07IWLn++eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BOmZU//11Hx90jsMZXoD2Z1qGCmZOtHGNpol2PLu6JvlrLeNjmbY8uavp/6FbIg4e
	 QFwSmHzfwcWWeVsejN5KgQfya9jriUODTFQeImUeWJGYLQ4obvMrkf02rnnewC2sMb
	 deSXlU2v9TjVgR9cODUEeJDdILrYbs3KfIfrYHkGgCBnY5pTw13MqWbwyh1Rd/RoKg
	 PyWrk5lObVOYxyU869wNTlrh4J1tmhUBJpGgv4gc+kG91Gm+84F5zs4RGyRtaq7GAM
	 gsyz8gPunmSNl0txGsn9JlWAcWLUpok3RtH3tqMu5rGreEsPyxtUg/dzxPjZqWzEV+
	 2FwCUnF+qLP9w==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662feac8228so150302eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 12:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6pRP8bKHlEGJwCEWJwf7aW6jrpdHAGDQL/ESPkbWA/o8lUmfagX/WgIy4mrzMIYoGVcd72HZJUBRV@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmvV8MVwakhStqQZFd+O/bMfq10hc+79qOcfC2wAoFjW2zwtM
	C+4tv/pPxKPFbSGNZNOQ2hJ11LDEf/WM7HsdanP5tKOJbLk+zJT8+jzlV//qCOEMTsF/QrZPoJi
	urdMWDOI1MggHccyoF3Vjmi9rvwUUl8A=
X-Received: by 2002:a05:6820:f012:b0:65d:88b:c00d with SMTP id
 006d021491bc7-662f20d44b8mr3871370eaf.66.1769631822257; Wed, 28 Jan 2026
 12:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127063216.240911-1-W_Armin@gmx.de> <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
 <1f76fc7d-3067-4bd8-912d-62ebf68ba696@gmx.de>
In-Reply-To: <1f76fc7d-3067-4bd8-912d-62ebf68ba696@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 21:23:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iANSqdP1YQz-XvPsvomVXWttnjYO+u3UBt76-y8gD8vg@mail.gmail.com>
X-Gm-Features: AZwV_Qgi0b3WgocOIVlXk8WpkxFLF7hGC6llp7Iv_2bXSvtiw-D593P3kmHbBgs
Message-ID: <CAJZ5v0iANSqdP1YQz-XvPsvomVXWttnjYO+u3UBt76-y8gD8vg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: OSL: Panic when encountering a fatal ACPI error
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20722-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,uefi.org:url,gmx.de:email]
X-Rspamd-Queue-Id: 74D73A8754
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 3:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.01.26 um 22:05 schrieb Rafael J. Wysocki:
>
> > On Tue, Jan 27, 2026 at 7:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> The ACPI spec states that the operating system should respond
> >> to a fatal ACPI error by "performing a controlled OS shutdown in
> >> a timely fashion". Windows complies with this requirement by entering
> >> a BSOD upon executing the "Fatal()" ASL opcode, a implementation
> >> detail that is used by some firmware implementations for signaling
> >> fatal hardware errors.
> >>
> >> Comply with the ACPI specification by triggering a kernel panic
> >> when ACPICA signals a fatal ACPI error.
> > I'm not sure if a kernel panic really counts as "a controlled OS shutdo=
wn".
> >
> > Shouldn't this be treated in a similar way to crossing a critical
> > thermal trip point?
> >
> > Also, is there a reason beyond "follow Windows" to do this?
>
> Some firmware implementation use Fatal () to signal fatal hardware errors=
.
> The ThinkPad X1 Yoga Gen 8 for example has something like this:
>
> Method (_Q7F, 0, NotSerialized)  // _Qxx: EC Query, xx=3D0x00-0xFF
> {
>         Fatal (0x01, 0x80010000, 0x00036C4E)
> }
>
> I strongly suspect that the EC issues query 0x7F when encountering a fata=
l internal error.
> Trying to perform an orderly shutdown in this case might cause the whole =
system to hang
> or to respond erratically.

So if the kernel panics in response to this, it is kind of hard to
diagnose anything.

Also, is panicking really worse than trying to carry out an orderly
shutdown and possibly crashing if that doesn't go well?

> The other use cases for Fatal () that i know of are:
> - failing if some PCI components refuse to resume (MacBookPro 16)
> - failing if a WMI-ACPI device is being accessed while still being disabl=
ed (Windows WMI-ACPI example code)
> - failing if the hardware resource configuration is invalid (ThinkPad T41=
0, among others)

None of the above qualifies as a reason for a kernel panic IMV.

> In all those cases the firmware developers assume that Fatal () causes th=
e operating system to panic.
> This seems to be true even on MacOS: https://discussions.apple.com/thread=
/250384018

Mac is a vertical platform and the OS probably has a much better
reason to trust its firmware than on an average PC.

> We thus should threat the Fatal () opcode like an assert() statement that=
 is used to signal
> when the firmware has encountered a problem it cannot handle. The only wa=
y to safely "recover"
> from this is a kernel panic, as a normal shutdown relies on the ACPI firm=
ware still being
> operational.

Well, not necessarily and to some extent.  It may not require the EC
to be operational, for instance.

> >> Users can still disable
> >> this behavior by using the acpi.panic_on_fatal kernel option to
> >> work around firmware bugs.
> > This is not enough.  You are talking about throwing away user data if
> > the firmware asks the kernel to do so.
>
> The kernel also throws away user data if the hardware itself signals a fa=
tal error.

AML is not hardware and as a rule it is developed by less competent people.

> Why should we react differently when the ACPI BIOS does the same, especia=
lly when
> MacOS and Windows do exactly that?
>
> I agree that being able to differentiate between fatal errors and recover=
able errors
> would be much better, but sadly that is not how most of the ACPI implemen=
tations out
> there where designed to work.

Somebody at one point decided to handle Fatal() in Linux by printing a
message and you are asserting that they were wrong because the
designers of other OSes apparently disagree with that.

Overall this is not super-convincing to me.

> >> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fata=
l-error-check
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> ---
> >> Changes since v1:
> >> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_F=
ATAL
> >> ---
> >>   .../admin-guide/kernel-parameters.txt         |  9 +++++++++
> >>   drivers/acpi/Kconfig                          | 11 +++++++++++
> >>   drivers/acpi/osl.c                            | 19 +++++++++++++++++=
+-
> >>   3 files changed, 38 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index 1058f2a6d6a8..140bb239857f 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -187,6 +187,15 @@ Kernel parameters
> >>                          unusable.  The "log_buf_len" parameter may be=
 useful
> >>                          if you need to capture more output.
> >>
> >> +       acpi.panic_on_fatal=3D    [ACPI]
> >> +                       {0 | 1}
> >> +                       Causes the kernel to panic when the ACPI bytec=
ode signals
> >> +                       a fatal error. The default value of this setti=
ng can
> >> +                       be configured using CONFIG_ACPI_PANIC_ON_FATAL=
.
> >> +                       Overriding this value should only be done for =
diagnosing
> >> +                       ACPI firmware problems, as some firmware imple=
mentations
> >> +                       use this mechanism to signal fatal hardware er=
rors.
> >> +
> >>          acpi_enforce_resources=3D [ACPI]
> >>                          { strict | lax | no }
> >>                          Check for resource conflicts between native d=
rivers
> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >> index df0ff0764d0d..7139e7d8ac25 100644
> >> --- a/drivers/acpi/Kconfig
> >> +++ b/drivers/acpi/Kconfig
> >> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
> >>          depends on THERMAL
> >>          bool
> >>
> >> +config ACPI_PANIC_ON_FATAL
> >> +       bool "Panic on fatal ACPI error"
> >> +       default y
> >> +       help
> >> +         The ACPI bytecode can signal that a fatal error has occurred=
 using the Fatal()
> >> +         ASL operator, normaly causing a kernel panic. Disabling this=
 option causes such
> >> +         a condition to be treated like a ordinary ACPI error.
> >> +
> >> +         This setting can also be overridden during boot using the ac=
pi.panic_on_fatal
> >> +         kernel parameter.
> >> +
> >>   config ACPI_DEBUGGER
> >>          bool "AML debugger interface"
> >>          select ACPI_DEBUG
> >> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >> index 05393a7315fe..6375db6d22ea 100644
> >> --- a/drivers/acpi/osl.c
> >> +++ b/drivers/acpi/osl.c
> >> @@ -11,7 +11,9 @@
> >>
> >>   #define pr_fmt(fmt) "ACPI: OSL: " fmt
> >>
> >> +#include <linux/kconfig.h>
> >>   #include <linux/module.h>
> >> +#include <linux/panic.h>
> >>   #include <linux/kernel.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/mm.h>
> >> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
> >>   unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
> >>   bool acpi_permanent_mmap =3D false;
> >>
> >> +static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATAL)=
;
> >> +module_param(panic_on_fatal, bool, 0);
> >> +MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encount=
ering a fatal ACPI error");
> >> +
> >>   /*
> >>    * This list of permanent mappings is for memory that may be accesse=
d from
> >>    * interrupt context, where we can't do the ioremap().
> >> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(voi=
d)
> >>
> >>   acpi_status acpi_os_signal(u32 function, void *info)
> >>   {
> >> +       struct acpi_signal_fatal_info *fatal_info;
> >> +
> >>          switch (function) {
> >>          case ACPI_SIGNAL_FATAL:
> >> -               pr_err("Fatal opcode executed\n");
> >> +               fatal_info =3D info;
> >> +               if (panic_on_fatal) {
> >> +                       panic("Fatal ACPI BIOS error (type 0x%X code 0=
x%X argument 0x%X)",
> >> +                             fatal_info->type, fatal_info->code, fata=
l_info->argument);
> >> +               } else {

I could be convinced to do the part below, maybe except for the
message that is not super-precise (something like "Fatal error while
evaluating ACPI control method" would be better IMO and you could
print the error info in a separate message).

Turning the admin's attention to this is a good idea IMV.

The panic part, not so much.

> >> +                       pr_emerg("Fatal ACPI BIOS error (type 0x%X cod=
e 0x%X argument 0x%X)\n",
> >> +                                fatal_info->type, fatal_info->code, f=
atal_info->argument);
> >> +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_S=
TILL_OK);
> >> +               }
> >> +
> >>                  break;
> >>          case ACPI_SIGNAL_BREAKPOINT:
> >>                  /*
> >> --

