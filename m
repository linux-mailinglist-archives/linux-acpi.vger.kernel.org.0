Return-Path: <linux-acpi+bounces-20698-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLF9DGN4eWkSxQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20698-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:45:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B604E9C640
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12CC830098AF
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51991AF0AF;
	Wed, 28 Jan 2026 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Tf78fwNM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A154652;
	Wed, 28 Jan 2026 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568352; cv=none; b=PT7oHu2woIxdPscbVYoZnDPKYxNcsXHfervN8Obayll/VxSVkzlRJbb6dQfz/zwhi+FwHiRacJAl1gslvuZXzO/H5cJg3pY46qCuFYzg3bi4SE4t3wykrOLnI26meJWIylOd7Thbo7Bcg0+Zl2kC9bwT7JfRb7E+z5xgNr97N/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568352; c=relaxed/simple;
	bh=rBL6RqxDvWj6Hzhmxw39GC5E1HlLF9Zerr8olJ5opXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlSTgJIxPG+legQ3m4AzwBNmycX6iXJNfadxFD70rok+YGTPnCAg/8lPNgyeKNXn0PuuSHHSPrjL30++bSeHQKos7gOgEQYl1k4uhSLp26kaxzPO4FJo6LyCgOzqvWqJLUC5qe6O3oMLXDNbWaxGcjJj7nNZJttQvZk/s6lQpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Tf78fwNM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769568348; x=1770173148; i=w_armin@gmx.de;
	bh=YYHSpp9TLGSY6VAarMlYvKWYTTuQhHq2Z8TvWN48grc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Tf78fwNMSFyXSlSr280ZfBvaDOOHCZA+opM4pONGvuh6SGl/f8S0sGNNDyQgoUP0
	 K0YLmX6bL6ln08CHXoWxjT0EALOIqw5Emc4lHvh998avSygBxZciBtJYen/cc2W1J
	 oBE55+4y+aaqEUSzwgrUpXul+xvHRvTN7ufEMZeJHi+tpb7JZa56HOgwjhcjuoVFP
	 UphHbtNIiD5Tc0szcFxPraErzXaFYBEZax4B47O1TVAv60Z9aZ690ywha7szaZfM+
	 4tsgfaI4caOhZjU+C/1KneRhjrmpvz2/cMTxAL8OrVnMD93bgiqcrNCnyEFcMr15b
	 Y3j+uFXsIGBRYAaURA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1vShv80t1q-00IG10; Wed, 28
 Jan 2026 03:45:48 +0100
Message-ID: <1f76fc7d-3067-4bd8-912d-62ebf68ba696@gmx.de>
Date: Wed, 28 Jan 2026 03:45:47 +0100
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8dmqYBGDaVMezruyAWCftJn0FZZpQWeflvpad8r281ZxRdx+goq
 FXH8Mi3jLnWfUumCsqHskFoQvJ5H3M1Lg6y1AF/pWo4RQj4hdMxv5LppflosIz423fANxpS
 UKRCZP6nsN7eJo8ma4GOT1qfW7C6ywNvl9UwZyM28ygtadD/y+rZ59eV3tUDfVmbaRDOnnj
 AA0PK0TjnyMbHm1vsE6kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jdR1VnuJsbM=;DAao7/pAEyjzXFL0HpW3FMAK9im
 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
 GOthJcbrKQ+
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20698-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uefi.org:url]
X-Rspamd-Queue-Id: B604E9C640
X-Rspamd-Action: no action

Am 27.01.26 um 22:05 schrieb Rafael J. Wysocki:

> On Tue, Jan 27, 2026 at 7:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> The ACPI spec states that the operating system should respond
>> to a fatal ACPI error by "performing a controlled OS shutdown in
>> a timely fashion". Windows complies with this requirement by entering
>> a BSOD upon executing the "Fatal()" ASL opcode, a implementation
>> detail that is used by some firmware implementations for signaling
>> fatal hardware errors.
>>
>> Comply with the ACPI specification by triggering a kernel panic
>> when ACPICA signals a fatal ACPI error.
> I'm not sure if a kernel panic really counts as "a controlled OS shutdow=
n".
>
> Shouldn't this be treated in a similar way to crossing a critical
> thermal trip point?
>
> Also, is there a reason beyond "follow Windows" to do this?

Some firmware implementation use Fatal () to signal fatal hardware errors.
The ThinkPad X1 Yoga Gen 8 for example has something like this:

Method (_Q7F, 0, NotSerialized)  // _Qxx: EC Query, xx=3D0x00-0xFF
{
	Fatal (0x01, 0x80010000, 0x00036C4E)
}

I strongly suspect that the EC issues query 0x7F when encountering a fatal=
 internal error.
Trying to perform an orderly shutdown in this case might cause the whole s=
ystem to hang
or to respond erratically.

The other use cases for Fatal () that i know of are:
- failing if some PCI components refuse to resume (MacBookPro 16)
- failing if a WMI-ACPI device is being accessed while still being disable=
d (Windows WMI-ACPI example code)
- failing if the hardware resource configuration is invalid (ThinkPad T410=
, among others)

In all those cases the firmware developers assume that Fatal () causes the=
 operating system to panic.
This seems to be true even on MacOS: https://discussions.apple.com/thread/=
250384018

We thus should threat the Fatal () opcode like an assert() statement that =
is used to signal
when the firmware has encountered a problem it cannot handle. The only way=
 to safely "recover"
from this is a kernel panic, as a normal shutdown relies on the ACPI firmw=
are still being
operational.

>> Users can still disable
>> this behavior by using the acpi.panic_on_fatal kernel option to
>> work around firmware bugs.
> This is not enough.  You are talking about throwing away user data if
> the firmware asks the kernel to do so.

The kernel also throws away user data if the hardware itself signals a fat=
al error.
Why should we react differently when the ACPI BIOS does the same, especial=
ly when
MacOS and Windows do exactly that?

I agree that being able to differentiate between fatal errors and recovera=
ble errors
would be much better, but sadly that is not how most of the ACPI implement=
ations out
there where designed to work.

Thanks,
Armin Wolf

>> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal=
-error-check
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Changes since v1:
>> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_FA=
TAL
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  9 +++++++++
>>   drivers/acpi/Kconfig                          | 11 +++++++++++
>>   drivers/acpi/osl.c                            | 19 ++++++++++++++++++=
-
>>   3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
>> index 1058f2a6d6a8..140bb239857f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -187,6 +187,15 @@ Kernel parameters
>>                          unusable.  The "log_buf_len" parameter may be =
useful
>>                          if you need to capture more output.
>>
>> +       acpi.panic_on_fatal=3D    [ACPI]
>> +                       {0 | 1}
>> +                       Causes the kernel to panic when the ACPI byteco=
de signals
>> +                       a fatal error. The default value of this settin=
g can
>> +                       be configured using CONFIG_ACPI_PANIC_ON_FATAL.
>> +                       Overriding this value should only be done for d=
iagnosing
>> +                       ACPI firmware problems, as some firmware implem=
entations
>> +                       use this mechanism to signal fatal hardware err=
ors.
>> +
>>          acpi_enforce_resources=3D [ACPI]
>>                          { strict | lax | no }
>>                          Check for resource conflicts between native dr=
ivers
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index df0ff0764d0d..7139e7d8ac25 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
>>          depends on THERMAL
>>          bool
>>
>> +config ACPI_PANIC_ON_FATAL
>> +       bool "Panic on fatal ACPI error"
>> +       default y
>> +       help
>> +         The ACPI bytecode can signal that a fatal error has occurred =
using the Fatal()
>> +         ASL operator, normaly causing a kernel panic. Disabling this =
option causes such
>> +         a condition to be treated like a ordinary ACPI error.
>> +
>> +         This setting can also be overridden during boot using the acp=
i.panic_on_fatal
>> +         kernel parameter.
>> +
>>   config ACPI_DEBUGGER
>>          bool "AML debugger interface"
>>          select ACPI_DEBUG
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index 05393a7315fe..6375db6d22ea 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -11,7 +11,9 @@
>>
>>   #define pr_fmt(fmt) "ACPI: OSL: " fmt
>>
>> +#include <linux/kconfig.h>
>>   #include <linux/module.h>
>> +#include <linux/panic.h>
>>   #include <linux/kernel.h>
>>   #include <linux/slab.h>
>>   #include <linux/mm.h>
>> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
>>   unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>>   bool acpi_permanent_mmap =3D false;
>>
>> +static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATAL);
>> +module_param(panic_on_fatal, bool, 0);
>> +MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encounte=
ring a fatal ACPI error");
>> +
>>   /*
>>    * This list of permanent mappings is for memory that may be accessed=
 from
>>    * interrupt context, where we can't do the ioremap().
>> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(void=
)
>>
>>   acpi_status acpi_os_signal(u32 function, void *info)
>>   {
>> +       struct acpi_signal_fatal_info *fatal_info;
>> +
>>          switch (function) {
>>          case ACPI_SIGNAL_FATAL:
>> -               pr_err("Fatal opcode executed\n");
>> +               fatal_info =3D info;
>> +               if (panic_on_fatal) {
>> +                       panic("Fatal ACPI BIOS error (type 0x%X code 0x=
%X argument 0x%X)",
>> +                             fatal_info->type, fatal_info->code, fatal=
_info->argument);
>> +               } else {
>> +                       pr_emerg("Fatal ACPI BIOS error (type 0x%X code=
 0x%X argument 0x%X)\n",
>> +                                fatal_info->type, fatal_info->code, fa=
tal_info->argument);
>> +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_ST=
ILL_OK);
>> +               }
>> +
>>                  break;
>>          case ACPI_SIGNAL_BREAKPOINT:
>>                  /*
>> --
>> 2.39.5
>>
>>

