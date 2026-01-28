Return-Path: <linux-acpi+bounces-20748-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJsUB/d7emka7AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20748-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 22:13:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C58A9008
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 22:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D7853015D2F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE118376BF2;
	Wed, 28 Jan 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Z8PFMC60"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C237648A;
	Wed, 28 Jan 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634802; cv=none; b=PsmrnRyGMTIJ3kw+hQccHfPM5FlN0sC7Pa4j3bB7qckoOkPojMRhBbWbIFguqHvrtByuVdnkD28yVf5REjQjOm3C1a4JcAziClj1rNeNsMKYZiSZkeiOfLQ8fMF5QbluvcVBrQaTJiblIqATAJUD+lVFKtabtdn0hdGgKLlgyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634802; c=relaxed/simple;
	bh=cGJZhbFjb8XSm1iAnNyDjNDl8BAk/eQhdyTXokvbsBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9lZG4Kntzu6F77+4HIHSOphvIkPANH3LCzeX0Bk38ESi9fm0oeSu8OaJkj9W9PqwDd3fXm0JFtEyJLAkg0oEyjIcGXZVhjI4GOzK1qhqrumRY+zMBrLIj23+N5z/Lf/N+x+oRUjFZROZMHN1eyiv8EA1Whi0n9pQxxCgP7cakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Z8PFMC60; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769634798; x=1770239598; i=w_armin@gmx.de;
	bh=d5JrsSDai0PZxwX7h/trhuGihihrQ87rZB5DxbOyZT8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z8PFMC60HeWWVDbWjkx+BPJa+amfq4h+jtQ+ye3vltUFMT5jouLtIyaiumLqWylQ
	 bmPW64nWDM4PFZtkT5hoB7YaLmgpuPYvaAXuntMXqm8un1AOlKOmK8yspGF06vokT
	 PUqNqrNRbjVtUy5Mbbp3kinEuPDvzP6PsZCvmGjLmBqn/cPjPlBo3tIg0tNlraOxq
	 E2rcZpBnuYgSMbblHK4ZwvM7EX/aFZnQuwc9fTNPAeQkUgr+t2Pb7o50lRLtVPgyg
	 zhpgX1Eu1JXWxw4CskP8NtstspFyZ13Cb3DefiztD17LNVWV5kUXWZoGcCaqK3QCH
	 3XMZ3fsQ/9d3pb8Xng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1vjGuF0uLJ-006yKr; Wed, 28
 Jan 2026 22:13:18 +0100
Message-ID: <8cae7fcc-0edb-4157-80fb-c1c2df02478b@gmx.de>
Date: Wed, 28 Jan 2026 22:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: OSL: Panic when encountering a fatal ACPI error
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260127063216.240911-1-W_Armin@gmx.de>
 <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
 <1f76fc7d-3067-4bd8-912d-62ebf68ba696@gmx.de>
 <CAJZ5v0iANSqdP1YQz-XvPsvomVXWttnjYO+u3UBt76-y8gD8vg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0iANSqdP1YQz-XvPsvomVXWttnjYO+u3UBt76-y8gD8vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4BW+sQk9ka4U/RlBwvoNtLIY/s8SwqxFPCHvjA9XC165chJLBNM
 pAHi5pRijJSwiws2IITY3Wmv8VPs1zxMwlCOLmPAdt1byVFAP5RaemjbHO7/vXrqlB2/nK4
 mKp/RGJ5p4f6nAs4Yokfcg16NikqrVQx19WCvE4sN/lGX71z2Pz1PsIdReIMPnO+NJqsHa4
 K/xA7/IOCATYhC1aybnuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uGbbbBLBOwA=;vWaGBAHnSpHnG5rvMs3lZ69J5b2
 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
 i6/IpwqlxvoPZbxL0Ad/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20748-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmx.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85C58A9008
X-Rspamd-Action: no action

Am 28.01.26 um 21:23 schrieb Rafael J. Wysocki:

> On Wed, Jan 28, 2026 at 3:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 27.01.26 um 22:05 schrieb Rafael J. Wysocki:
>>
>>> On Tue, Jan 27, 2026 at 7:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> The ACPI spec states that the operating system should respond
>>>> to a fatal ACPI error by "performing a controlled OS shutdown in
>>>> a timely fashion". Windows complies with this requirement by entering
>>>> a BSOD upon executing the "Fatal()" ASL opcode, a implementation
>>>> detail that is used by some firmware implementations for signaling
>>>> fatal hardware errors.
>>>>
>>>> Comply with the ACPI specification by triggering a kernel panic
>>>> when ACPICA signals a fatal ACPI error.
>>> I'm not sure if a kernel panic really counts as "a controlled OS shutd=
own".
>>>
>>> Shouldn't this be treated in a similar way to crossing a critical
>>> thermal trip point?
>>>
>>> Also, is there a reason beyond "follow Windows" to do this?
>> Some firmware implementation use Fatal () to signal fatal hardware erro=
rs.
>> The ThinkPad X1 Yoga Gen 8 for example has something like this:
>>
>> Method (_Q7F, 0, NotSerialized)  // _Qxx: EC Query, xx=3D0x00-0xFF
>> {
>>          Fatal (0x01, 0x80010000, 0x00036C4E)
>> }
>>
>> I strongly suspect that the EC issues query 0x7F when encountering a fa=
tal internal error.
>> Trying to perform an orderly shutdown in this case might cause the whol=
e system to hang
>> or to respond erratically.
> So if the kernel panics in response to this, it is kind of hard to
> diagnose anything.

The error codes supplied by Fatal() are displayed inside the panic message=
, so looking at
the ACPI ASL code should make such issues relatively easy to diagnose.

> Also, is panicking really worse than trying to carry out an orderly
> shutdown and possibly crashing if that doesn't go well?

The EC might still behave erratically and cause hardware damage since the =
firmware
expects the OS to halt immediately upon receiving such a event.

>> The other use cases for Fatal () that i know of are:
>> - failing if some PCI components refuse to resume (MacBookPro 16)
>> - failing if a WMI-ACPI device is being accessed while still being disa=
bled (Windows WMI-ACPI example code)
>> - failing if the hardware resource configuration is invalid (ThinkPad T=
410, among others)
> None of the above qualifies as a reason for a kernel panic IMV.

True, in this case having something like an Error() AML opcode to signal n=
on-fatal errors would
be very useful indeed.

>> In all those cases the firmware developers assume that Fatal () causes =
the operating system to panic.
>> This seems to be true even on MacOS: https://discussions.apple.com/thre=
ad/250384018
> Mac is a vertical platform and the OS probably has a much better
> reason to trust its firmware than on an average PC.

True :/

>> We thus should threat the Fatal () opcode like an assert() statement th=
at is used to signal
>> when the firmware has encountered a problem it cannot handle. The only =
way to safely "recover"
>> from this is a kernel panic, as a normal shutdown relies on the ACPI fi=
rmware still being
>> operational.
> Well, not necessarily and to some extent.  It may not require the EC
> to be operational, for instance.
>
>>>> Users can still disable
>>>> this behavior by using the acpi.panic_on_fatal kernel option to
>>>> work around firmware bugs.
>>> This is not enough.  You are talking about throwing away user data if
>>> the firmware asks the kernel to do so.
>> The kernel also throws away user data if the hardware itself signals a =
fatal error.
> AML is not hardware and as a rule it is developed by less competent peop=
le.

True, but since Windows triggers a BSOD upon executing Fatal(), i believe =
that firmware
vendors will actually take some care regarding this.

>> Why should we react differently when the ACPI BIOS does the same, espec=
ially when
>> MacOS and Windows do exactly that?
>>
>> I agree that being able to differentiate between fatal errors and recov=
erable errors
>> would be much better, but sadly that is not how most of the ACPI implem=
entations out
>> there where designed to work.
> Somebody at one point decided to handle Fatal() in Linux by printing a
> message and you are asserting that they were wrong because the
> designers of other OSes apparently disagree with that.
>
> Overall this is not super-convincing to me.
>
>>>> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fat=
al-error-check
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>> Changes since v1:
>>>> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_=
FATAL
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  9 +++++++++
>>>>    drivers/acpi/Kconfig                          | 11 +++++++++++
>>>>    drivers/acpi/osl.c                            | 19 +++++++++++++++=
+++-
>>>>    3 files changed, 38 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
>>>> index 1058f2a6d6a8..140bb239857f 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -187,6 +187,15 @@ Kernel parameters
>>>>                           unusable.  The "log_buf_len" parameter may =
be useful
>>>>                           if you need to capture more output.
>>>>
>>>> +       acpi.panic_on_fatal=3D    [ACPI]
>>>> +                       {0 | 1}
>>>> +                       Causes the kernel to panic when the ACPI byte=
code signals
>>>> +                       a fatal error. The default value of this sett=
ing can
>>>> +                       be configured using CONFIG_ACPI_PANIC_ON_FATA=
L.
>>>> +                       Overriding this value should only be done for=
 diagnosing
>>>> +                       ACPI firmware problems, as some firmware impl=
ementations
>>>> +                       use this mechanism to signal fatal hardware e=
rrors.
>>>> +
>>>>           acpi_enforce_resources=3D [ACPI]
>>>>                           { strict | lax | no }
>>>>                           Check for resource conflicts between native=
 drivers
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index df0ff0764d0d..7139e7d8ac25 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
>>>>           depends on THERMAL
>>>>           bool
>>>>
>>>> +config ACPI_PANIC_ON_FATAL
>>>> +       bool "Panic on fatal ACPI error"
>>>> +       default y
>>>> +       help
>>>> +         The ACPI bytecode can signal that a fatal error has occurre=
d using the Fatal()
>>>> +         ASL operator, normaly causing a kernel panic. Disabling thi=
s option causes such
>>>> +         a condition to be treated like a ordinary ACPI error.
>>>> +
>>>> +         This setting can also be overridden during boot using the a=
cpi.panic_on_fatal
>>>> +         kernel parameter.
>>>> +
>>>>    config ACPI_DEBUGGER
>>>>           bool "AML debugger interface"
>>>>           select ACPI_DEBUG
>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>> index 05393a7315fe..6375db6d22ea 100644
>>>> --- a/drivers/acpi/osl.c
>>>> +++ b/drivers/acpi/osl.c
>>>> @@ -11,7 +11,9 @@
>>>>
>>>>    #define pr_fmt(fmt) "ACPI: OSL: " fmt
>>>>
>>>> +#include <linux/kconfig.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/panic.h>
>>>>    #include <linux/kernel.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/mm.h>
>>>> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
>>>>    unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>>>>    bool acpi_permanent_mmap =3D false;
>>>>
>>>> +static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATAL=
);
>>>> +module_param(panic_on_fatal, bool, 0);
>>>> +MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encoun=
tering a fatal ACPI error");
>>>> +
>>>>    /*
>>>>     * This list of permanent mappings is for memory that may be acces=
sed from
>>>>     * interrupt context, where we can't do the ioremap().
>>>> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(vo=
id)
>>>>
>>>>    acpi_status acpi_os_signal(u32 function, void *info)
>>>>    {
>>>> +       struct acpi_signal_fatal_info *fatal_info;
>>>> +
>>>>           switch (function) {
>>>>           case ACPI_SIGNAL_FATAL:
>>>> -               pr_err("Fatal opcode executed\n");
>>>> +               fatal_info =3D info;
>>>> +               if (panic_on_fatal) {
>>>> +                       panic("Fatal ACPI BIOS error (type 0x%X code =
0x%X argument 0x%X)",
>>>> +                             fatal_info->type, fatal_info->code, fat=
al_info->argument);
>>>> +               } else {
> I could be convinced to do the part below, maybe except for the
> message that is not super-precise (something like "Fatal error while
> evaluating ACPI control method" would be better IMO and you could
> print the error info in a separate message).
>
> Turning the admin's attention to this is a good idea IMV.
>
> The panic part, not so much.

Fine, would it be OK if i replace panic() with orderly_poweroff()? This wa=
y we are
still ACPI-compliant regarding the oderly poweroff requirement and userspa=
ce can
still save (diagnostic) data before powering off the machine.

Thanks,
Armin Wolf

>>>> +                       pr_emerg("Fatal ACPI BIOS error (type 0x%X co=
de 0x%X argument 0x%X)\n",
>>>> +                                fatal_info->type, fatal_info->code, =
fatal_info->argument);
>>>> +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_=
STILL_OK);
>>>> +               }
>>>> +
>>>>                   break;
>>>>           case ACPI_SIGNAL_BREAKPOINT:
>>>>                   /*
>>>> --

