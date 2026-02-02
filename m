Return-Path: <linux-acpi+bounces-20824-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIUJKuQNgWnfDwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20824-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 21:49:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32FD1470
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 21:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D336300B042
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E730DEB5;
	Mon,  2 Feb 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehGWuJ84"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259C2EA731
	for <linux-acpi@vger.kernel.org>; Mon,  2 Feb 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065157; cv=none; b=inDvD4tp958eJpUQxMn45gv4gGSbABM65BTPSuYBGwIWqZS0my9o26wD/v1CNjCVDtyOKcx5+dNhrhI54MrNqDARmb3VfMNZwRRZ7KUqN5Hl1JY4oVfWcZBZRnbsleGX4E8KSYexxSDqZ9WILSc/AQhgK/b4JSGgi3mAo/YO7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065157; c=relaxed/simple;
	bh=nWA1m2oEBj0vSzr2Kgnujn5WdUq+aw25dXHyMSlll9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJfHrBt3KnB6HtqO75hn1GNQzL7bXfNQLakoCthwuaZ+wA5Y905fDcGb99sDxGoUnKmsc9/siyQgyFFX8jXFfVF4GIKbhqPTfuKQiwur12hK/XbzV+R591uZ8oOf7DefZIFKecDQZWkRatb495jAsR9XpitkCf5iNLxXGAJ5H3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehGWuJ84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5C3C116C6
	for <linux-acpi@vger.kernel.org>; Mon,  2 Feb 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065156;
	bh=nWA1m2oEBj0vSzr2Kgnujn5WdUq+aw25dXHyMSlll9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ehGWuJ84GlStv1PCZCZNtru5KDYfsFOrGsiTsA2NEd/yBfgbBr4NV1BeCPPajzP0u
	 blVOwkKssVK4LFUhPl2+RSqwvl5ylxm8vsQ+fXHzGiu62+h4b1gmP/P1MJDhH8jR5x
	 ppXm3NgdnIuItzqOXQ9eb8xSLaSEwKPPHbAV/RihaxXfgppJQ1Eh6unyrq+pixKPTH
	 tRz8xPlDw3PrpmqSxvs4wx/VnaNQ/+pv4yCI3ef9VOi05u8VN5473wDGJKXHf87/Te
	 2tIEUHVZsr3yZzRFwlaIdaTV/FkcDQ4C6OgohahF1PnVPLLII61uT7wBFtjJlazdv+
	 tTHlsDcd5CE4Q==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662fad2dc91so2935956eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2026 12:45:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN/Mel/r17l7t8TfF/hDlxzCC6gIImuK3+i+kggHrCwjKBOc/sA+LaUS65b8Rt2GWpnwLb0mh8DVOT@vger.kernel.org
X-Gm-Message-State: AOJu0YwgF5Ge1+S8JIs3C+wQdCeOwCDFvMBlK2xgZ4+oLfAd1DK5XJBE
	YsvI2+kkYPtZ8gS4FPTkTE5or8yMtaMJU3udmdkbhdrlnwfyOM9ay8B/CuXrTEdSt94M5JGQehU
	gFEWAgNaBOTVHiaiLtXx5OM7rc3Akm2c=
X-Received: by 2002:a05:6820:a104:b0:663:114a:7e14 with SMTP id
 006d021491bc7-663114a7ffdmr4265984eaf.39.1770065155871; Mon, 02 Feb 2026
 12:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127063216.240911-1-W_Armin@gmx.de> <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
 <1f76fc7d-3067-4bd8-912d-62ebf68ba696@gmx.de> <CAJZ5v0iANSqdP1YQz-XvPsvomVXWttnjYO+u3UBt76-y8gD8vg@mail.gmail.com>
 <8cae7fcc-0edb-4157-80fb-c1c2df02478b@gmx.de>
In-Reply-To: <8cae7fcc-0edb-4157-80fb-c1c2df02478b@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Feb 2026 21:45:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hf5eOEnH-2TU+nYrrrL4i_fgKD9Ff48MMn6QjkV_k5Zg@mail.gmail.com>
X-Gm-Features: AZwV_QhhNZjvrYQgha8VIXcMxXk1h4APhAJQAALyvFE9ip_tB2G-PZVGV8l8Sz4
Message-ID: <CAJZ5v0hf5eOEnH-2TU+nYrrrL4i_fgKD9Ff48MMn6QjkV_k5Zg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20824-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A32FD1470
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 28.01.26 um 21:23 schrieb Rafael J. Wysocki:
>
> > On Wed, Jan 28, 2026 at 3:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 27.01.26 um 22:05 schrieb Rafael J. Wysocki:
> >>
> >>> On Tue, Jan 27, 2026 at 7:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>> The ACPI spec states that the operating system should respond
> >>>> to a fatal ACPI error by "performing a controlled OS shutdown in
> >>>> a timely fashion". Windows complies with this requirement by enterin=
g
> >>>> a BSOD upon executing the "Fatal()" ASL opcode, a implementation
> >>>> detail that is used by some firmware implementations for signaling
> >>>> fatal hardware errors.
> >>>>
> >>>> Comply with the ACPI specification by triggering a kernel panic
> >>>> when ACPICA signals a fatal ACPI error.
> >>> I'm not sure if a kernel panic really counts as "a controlled OS shut=
down".
> >>>
> >>> Shouldn't this be treated in a similar way to crossing a critical
> >>> thermal trip point?
> >>>
> >>> Also, is there a reason beyond "follow Windows" to do this?
> >> Some firmware implementation use Fatal () to signal fatal hardware err=
ors.
> >> The ThinkPad X1 Yoga Gen 8 for example has something like this:
> >>
> >> Method (_Q7F, 0, NotSerialized)  // _Qxx: EC Query, xx=3D0x00-0xFF
> >> {
> >>          Fatal (0x01, 0x80010000, 0x00036C4E)
> >> }
> >>
> >> I strongly suspect that the EC issues query 0x7F when encountering a f=
atal internal error.
> >> Trying to perform an orderly shutdown in this case might cause the who=
le system to hang
> >> or to respond erratically.
> > So if the kernel panics in response to this, it is kind of hard to
> > diagnose anything.
>
> The error codes supplied by Fatal() are displayed inside the panic messag=
e, so looking at
> the ACPI ASL code should make such issues relatively easy to diagnose.
>
> > Also, is panicking really worse than trying to carry out an orderly
> > shutdown and possibly crashing if that doesn't go well?
>
> The EC might still behave erratically and cause hardware damage since the=
 firmware
> expects the OS to halt immediately upon receiving such a event.
>
> >> The other use cases for Fatal () that i know of are:
> >> - failing if some PCI components refuse to resume (MacBookPro 16)
> >> - failing if a WMI-ACPI device is being accessed while still being dis=
abled (Windows WMI-ACPI example code)
> >> - failing if the hardware resource configuration is invalid (ThinkPad =
T410, among others)
> > None of the above qualifies as a reason for a kernel panic IMV.
>
> True, in this case having something like an Error() AML opcode to signal =
non-fatal errors would
> be very useful indeed.
>
> >> In all those cases the firmware developers assume that Fatal () causes=
 the operating system to panic.
> >> This seems to be true even on MacOS: https://discussions.apple.com/thr=
ead/250384018
> > Mac is a vertical platform and the OS probably has a much better
> > reason to trust its firmware than on an average PC.
>
> True :/
>
> >> We thus should threat the Fatal () opcode like an assert() statement t=
hat is used to signal
> >> when the firmware has encountered a problem it cannot handle. The only=
 way to safely "recover"
> >> from this is a kernel panic, as a normal shutdown relies on the ACPI f=
irmware still being
> >> operational.
> > Well, not necessarily and to some extent.  It may not require the EC
> > to be operational, for instance.
> >
> >>>> Users can still disable
> >>>> this behavior by using the acpi.panic_on_fatal kernel option to
> >>>> work around firmware bugs.
> >>> This is not enough.  You are talking about throwing away user data if
> >>> the firmware asks the kernel to do so.
> >> The kernel also throws away user data if the hardware itself signals a=
 fatal error.
> > AML is not hardware and as a rule it is developed by less competent peo=
ple.
>
> True, but since Windows triggers a BSOD upon executing Fatal(), i believe=
 that firmware
> vendors will actually take some care regarding this.

Some of them will, but I'd not expect code paths including Fatal() to
be executed too often during validation.  Some quite sophisticated
error injection would need to be used for this I suppose.

> >> Why should we react differently when the ACPI BIOS does the same, espe=
cially when
> >> MacOS and Windows do exactly that?
> >>
> >> I agree that being able to differentiate between fatal errors and reco=
verable errors
> >> would be much better, but sadly that is not how most of the ACPI imple=
mentations out
> >> there where designed to work.
> > Somebody at one point decided to handle Fatal() in Linux by printing a
> > message and you are asserting that they were wrong because the
> > designers of other OSes apparently disagree with that.
> >
> > Overall this is not super-convincing to me.
> >
> >>>> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fa=
tal-error-check
> >>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >>>> ---
> >>>> Changes since v1:
> >>>> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON=
_FATAL
> >>>> ---
> >>>>    .../admin-guide/kernel-parameters.txt         |  9 +++++++++
> >>>>    drivers/acpi/Kconfig                          | 11 +++++++++++
> >>>>    drivers/acpi/osl.c                            | 19 ++++++++++++++=
++++-
> >>>>    3 files changed, 38 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
> >>>> index 1058f2a6d6a8..140bb239857f 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -187,6 +187,15 @@ Kernel parameters
> >>>>                           unusable.  The "log_buf_len" parameter may=
 be useful
> >>>>                           if you need to capture more output.
> >>>>
> >>>> +       acpi.panic_on_fatal=3D    [ACPI]
> >>>> +                       {0 | 1}
> >>>> +                       Causes the kernel to panic when the ACPI byt=
ecode signals
> >>>> +                       a fatal error. The default value of this set=
ting can
> >>>> +                       be configured using CONFIG_ACPI_PANIC_ON_FAT=
AL.
> >>>> +                       Overriding this value should only be done fo=
r diagnosing
> >>>> +                       ACPI firmware problems, as some firmware imp=
lementations
> >>>> +                       use this mechanism to signal fatal hardware =
errors.
> >>>> +
> >>>>           acpi_enforce_resources=3D [ACPI]
> >>>>                           { strict | lax | no }
> >>>>                           Check for resource conflicts between nativ=
e drivers
> >>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >>>> index df0ff0764d0d..7139e7d8ac25 100644
> >>>> --- a/drivers/acpi/Kconfig
> >>>> +++ b/drivers/acpi/Kconfig
> >>>> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
> >>>>           depends on THERMAL
> >>>>           bool
> >>>>
> >>>> +config ACPI_PANIC_ON_FATAL
> >>>> +       bool "Panic on fatal ACPI error"
> >>>> +       default y
> >>>> +       help
> >>>> +         The ACPI bytecode can signal that a fatal error has occurr=
ed using the Fatal()
> >>>> +         ASL operator, normaly causing a kernel panic. Disabling th=
is option causes such
> >>>> +         a condition to be treated like a ordinary ACPI error.
> >>>> +
> >>>> +         This setting can also be overridden during boot using the =
acpi.panic_on_fatal
> >>>> +         kernel parameter.
> >>>> +
> >>>>    config ACPI_DEBUGGER
> >>>>           bool "AML debugger interface"
> >>>>           select ACPI_DEBUG
> >>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >>>> index 05393a7315fe..6375db6d22ea 100644
> >>>> --- a/drivers/acpi/osl.c
> >>>> +++ b/drivers/acpi/osl.c
> >>>> @@ -11,7 +11,9 @@
> >>>>
> >>>>    #define pr_fmt(fmt) "ACPI: OSL: " fmt
> >>>>
> >>>> +#include <linux/kconfig.h>
> >>>>    #include <linux/module.h>
> >>>> +#include <linux/panic.h>
> >>>>    #include <linux/kernel.h>
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/mm.h>
> >>>> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
> >>>>    unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
> >>>>    bool acpi_permanent_mmap =3D false;
> >>>>
> >>>> +static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATA=
L);
> >>>> +module_param(panic_on_fatal, bool, 0);
> >>>> +MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encou=
ntering a fatal ACPI error");
> >>>> +
> >>>>    /*
> >>>>     * This list of permanent mappings is for memory that may be acce=
ssed from
> >>>>     * interrupt context, where we can't do the ioremap().
> >>>> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(v=
oid)
> >>>>
> >>>>    acpi_status acpi_os_signal(u32 function, void *info)
> >>>>    {
> >>>> +       struct acpi_signal_fatal_info *fatal_info;
> >>>> +
> >>>>           switch (function) {
> >>>>           case ACPI_SIGNAL_FATAL:
> >>>> -               pr_err("Fatal opcode executed\n");
> >>>> +               fatal_info =3D info;
> >>>> +               if (panic_on_fatal) {
> >>>> +                       panic("Fatal ACPI BIOS error (type 0x%X code=
 0x%X argument 0x%X)",
> >>>> +                             fatal_info->type, fatal_info->code, fa=
tal_info->argument);
> >>>> +               } else {
> > I could be convinced to do the part below, maybe except for the
> > message that is not super-precise (something like "Fatal error while
> > evaluating ACPI control method" would be better IMO and you could
> > print the error info in a separate message).
> >
> > Turning the admin's attention to this is a good idea IMV.
> >
> > The panic part, not so much.
>
> Fine, would it be OK if i replace panic() with orderly_poweroff()?

It would not be particularly objectionable as far as I'm concerned.

> This way we are
> still ACPI-compliant regarding the oderly poweroff requirement and usersp=
ace can
> still save (diagnostic) data before powering off the machine.

Sure.

