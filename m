Return-Path: <linux-acpi+bounces-20922-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCxNMK5di2mYUAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20922-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 17:32:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9D11D381
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38F23301454A
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C97278156;
	Tue, 10 Feb 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYuvtQrJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9E3A1C9
	for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741114; cv=none; b=T4mlET2Mqvue6Q0ildC9xNLOe8Pe+lyzmRVohUQyUX9FZypX3KHawYCkheb/YPBjYuvkaMWfloRwfIEYQirEFdmZnScW4RhWXaAJNx5N4qIN6zJuP4lO0SVpQ1GOlRq+x96yy2TYP55n12K3DLuZTHbibIrrsGjmjgZoHwuWZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741114; c=relaxed/simple;
	bh=cLkLskF8N+8CApUKd1ekAVZvkESpQzIoWenY+UcixUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSu3kj0hsjsS8lBy3kSzM32nbYIWEM9ca+w5Fot9roD8N4qAuDoENtkg16X72g4X8MEV0OttwEXcMwVEdPIFkvEWxjOszwrtwD1/oHxEOUnIfiPN8MYseASi7hjentMH3HtXv+dPBMnd0OIpj/tSR5GmTozAkFiY2FG+UEuMJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYuvtQrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68B9C4AF0B
	for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741113;
	bh=cLkLskF8N+8CApUKd1ekAVZvkESpQzIoWenY+UcixUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VYuvtQrJkUnhQ8siFmZOOFJbHo0SHFDx9tp5suAECzifROBc0w3dLLKj4w3jXF8bi
	 2mLqwlspAXb+lFH+0OLaLDiZgIJ3QO7PeR92RLTf7+e+Bi4BeOI1n6jTWfXa14fK9S
	 kDCZT7hm8OsnRFdeAnTxokuSzNNl0zaepX2D0jD7ibCsxmU9vUyag9TGsg+Me2mNGo
	 4AJZWwImTwDps3oxZ+yC90uwQmUeAJLntOaTusrOoQHSq0zB++k2Pt4mHps2iJJyGq
	 h7xpwNjnapEexHtn2Ub3OdCthUkp5ZWMNig2VXA7wPeAEfSQQA3QlzuE3Q/56i3jSt
	 MWvwtlGyHMejw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-662efd1bdd4so1031eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 08:31:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/K2pZa/uN/WcHCchVVFocBWPFi19yqcKmYdgn65WCS62RgTwh1rmTM+lJFNTxM2MooHbFwP+r+Jch@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFNFWpUj46idgs4WOyXkmdlFO5wT6Hc74X75zbT3gM0iY9AOe
	M3qSO8IcNsXq3Yzb3Ga6iB6LNdX5WRg+07MYKpfvvXiIAn7+rLhj7JQJdJWgIbg3aIZ3AcFuSN5
	fs1HxbPBJZQ4YQ1iFGs/WOD4CrjeBy4A=
X-Received: by 2002:a05:6820:a00e:b0:673:e982:1c3e with SMTP id
 006d021491bc7-673e98226e9mr196411eaf.8.1770741112792; Tue, 10 Feb 2026
 08:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net> <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net> <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net> <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net> <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYPnATz1JakV3m7@mail.minyard.net>
In-Reply-To: <aYYPnATz1JakV3m7@mail.minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 17:31:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
X-Gm-Features: AZwV_QhFln3Yl-AMb67lS_ZtQvI-dyutZe4l66yKfXWKJvR8XxVHh_H6cwdSbNE
Message-ID: <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: corey@minyard.net, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20922-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,roeck-us.net:email,minyard.net:email]
X-Rspamd-Queue-Id: 1DA9D11D381
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 4:58=E2=80=AFPM Corey Minyard <corey@minyard.net> wr=
ote:
>
> On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> > >
> > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > > > Cc: Corey
> > > >
> > > > On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Guenter Roeck <linux@roeck-u=
s.net> wrote:
> > > > >
> > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > > On Wed, Feb 4, 2026 at 11:49=E2=80=AFPM Guenter Roeck <linux@ro=
eck-us.net> wrote:
> > > > > > >
> > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > I have written a patch with the help of AI and it fixes the=
 problem. Attached.
> > > > > > > >
> > > > > > >
> > > > > > > "No MIME, no links, no compression, no attachments.  Just pla=
in text"
> > > > > >
> > > > > > Sorry for that, I had assumed that attaching the file would mak=
e it in-line.
> > > > > >
> > > > > > > ... which means I can not provide inline feedback, which is t=
he whole
> > > > > > > point of the above.
> > > > > > >
> > > > > > > Your patch crosses subsystems, so it will need to be split in=
 two
> > > > > > > (assuming the ACPI side is even needed). Also, references to =
iDRAC
> > > > > > > in common code seem inappropriate.
> > > > > >
> > > > > > Yes, this I believe was the essential part (it was the last pie=
ce in
> > > > > > my testing which fixed the hanging):
> > > > > >
> > > > >
> > > > > Then I'll need to ask differently: What happens if you drop the I=
PMI code,
> > > > > and just keep the wait_for_completion -> wait_for_completion_time=
out
> > > > > change ? Would that be sufficient to solve the problem ?
> > > >
> > > > I'd rather say "Would that be sufficient to make the symptoms go
> > > > away?" as it most likely papers over the real problem.
> > > >
> > >
> > > Good point. Worse, it may result in UAF or memory leaks.
> > >
> > > > > Either case, the need for this change suggests that the ipmi chan=
ge
> > > > > may not be complete, since it should send a completion with an er=
ror.
> > > >
> > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > > > handle if the BMC is non-functional") should also be considered as =
a
> > > > possible way forward because it clearly did not improve things as
> > > > expected, at least in this particular case.
> > > >
> > >
> > > I tend to agree. I ran a number of AI code reviews over the patch, an=
d
> > > each time it finds new (and different) problems. The fact that the ac=
pi
> > > patch is still needed even after applying the ipmi changes suggests t=
hat
> > > something is still missing in the ipmi code.
> > >
> > > > It evidently did something that confuses things quite a bit.  Eithe=
r
> > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it=
 is
> > > > the "hosed" state and refusing to accept messages.
> > > >
> > >
> > > More than that. My latest AI results are below, just for reference
> > > (using Gemini 3 with Chris Mason's debug prompts). The prompt I used
> > > for this run is:
> >
> > Well, I guess it's time to send a revert patch then.
>
> Thanks for the CC.
>
> Let's fix it right in the IPMI driver.
>
> >
> > > "
> > > The top commit in the linux/ directory results in hung tasks if the B=
MC
> > > stops responding. Using @review-prompts/kernel/debugging.md analyze t=
he
> > > patch, identify the reason for the hung task problem, suggest and imp=
lement
> > > a fix. Note that there may be more than one problem in the patch, so =
analyze
> > > the complete patch and do not stop after fiding the first regression.
> > > "
> > >
> > > I think that catches most of the problem, but not all of it.
> > >
> > > Guenter
> > >
> > > ---
> > >
> > > Summary of crash or warning:
> > > Hung task detected in ipmi_si driver when BMC becomes non-functional.
> > > Processes waiting for IPMI responses (e.g. ipmitool, monitoring agent=
s) enter D state and never recover.
> > >
> > > Kernel version if available:
> > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > >
> > > Machine type if available:
> > > Generic Server with BMC
> > >
> > > Cleaned up copy of oops or stack trace:
> > > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 sec=
onds.
> > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppi=
d:  100 flags:0x00000000
> > > [  120.123460] Call Trace:
> > > [  120.123461]  <TASK>
> > > [  120.123462]  __schedule+0x123/0x456
> > > [  120.123463]  schedule+0x45/0x78
> > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > [  120.123467]  ...
> > > [  120.123468]  </TASK>
> > >
> > > Any other kernel messages you found relevant:
> > > N/A
> > >
> > > Explanation of the problem:
> > > 1. Hung Task:
> > > The patch "ipmi:si: Gracefully handle if the BMC is non-functional" i=
ntroduces a new state `SI_HOSED` to handle BMC failures. When the driver de=
tects that the BMC is not responding, it transitions to `SI_HOSED` and fail=
s the currently processing message (`curr_msg`). However, if a new message =
is queued via `sender()` (populating `waiting_msg`) during a recovery probe=
 (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state m=
achine transitions back to `SI_HOSED`. In this transition, the driver check=
s and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As =
a result, the `waiting_msg` remains in the queue indefinitely, causing the =
waiting process to hang.
> >
> > That's quite convincing and it would explain the observed symptoms.
>
> Yes, and it's a fairly easy fix, I think.  The waiting message just
> needs to be returned in that case.  The following patch should do it:

Jaroslav, it would be good to test the patch below on top of 6.19.  I
can put it on a test git branch if need be, so please let me know.

> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si=
_intf.c
> index 5459ffdde8dc..ff159b1162b9 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struct sm=
i_info *smi_info,
>                          */
>                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
>                 }
> +               if (smi_info->waiting_msg !=3D NULL) {
> +                       /* Also handle if there was a message waiting. */
> +                       smi_info->curr_msg =3D smi_info->waiting_msg;
> +                       smi_info->waiting_msg =3D NULL;
> +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> +               }
>                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
>                 goto out;
>         }

