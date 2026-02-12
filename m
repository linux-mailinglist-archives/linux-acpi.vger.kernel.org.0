Return-Path: <linux-acpi+bounces-20960-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEukElEMjmmS+wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20960-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 18:22:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4E12FDC5
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83DD3303A937
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870424503C;
	Thu, 12 Feb 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ7CmjZa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5614224D6
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916941; cv=none; b=IWqXOdU2IKQSN9RA3GJOMn6QppDVsRsq2z05dRRN9b4dSITQMzB31We3N0fK1p6PRdC3q+88otUnpCx+ZrIfQHDRTYku9YaBj3zsgOc6f0T/AsvVmujMKqLxq84y45t8CDITMQC8u2sQ4gMKaIksZ616OTS1kh8cYnQjY41ykLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916941; c=relaxed/simple;
	bh=TIaMzeDrs9/pKeig2XHOTaelc3orvYOlUigF9xQqaKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzOQTUp7SJK+mr4B04GLt5QTaUS4FaXww/H7gJjWWMn/ozZ9nSvjchItWRIorHoeu9zSYaHKdIOzaKavVgyBPF9IcsVoqvk+aVY/ZAVgpgU+hMfxWTzrA41HGLShacHKqCYMMgV2R7YSJTKbu+N3WzgVbx3n8AlvcSjabYiqQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ7CmjZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDC9C2BCAF
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770916941;
	bh=TIaMzeDrs9/pKeig2XHOTaelc3orvYOlUigF9xQqaKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hZ7CmjZao5ZMQc3MoFifi90HaXyt/KCEDck1SskQQwcWSHNE38530m6Rk/UamPNZB
	 tepXyeiQQh41TAgTnJYDqKVKBbjaVcDJCC3iGCY4Rg98tv9Hfy5HrXb91kpji9EH+G
	 bEWOV0madGbOLCE9HSq5q2XXS4whEbwiCABOfjJ3PQtE/JXLKfBLtP9j6harcsEbN9
	 VJNAtcsM7rYaIpkxZsYmcuhj5LCkeLxAD9C3jjfbQBZKHr5AuRhSDG0hwKhn5h4ejC
	 lGTBq8lhroVKp0IdtP1ARqhaoM4Lv8Q3mLeIMQqb7yEjNSxC8Ju7JS7jHRBrJciOgs
	 exjTsahq8ZdyA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40a62601731so28657fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 09:22:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULV+wu2YAb58THsE9Lw+ENEhJ94IwAEBTOyAOqEvvPugBVhqyr4tRYuU9KXLPa04VjmhgC8s3GpRuB@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFEoCGsAXKIEP/K+0oQO24moQn52Fnh1wOKNLzIMM+cJ+SNQK
	9r+17zEttv+oZIJkkAmIL2xKbInZKh9nH2xdoSuTsIYEDMd6y5a/LYPjVBLlTbD5CjEO8cAnP5J
	IzUFJ6pOESncgtfWsYP3NnwPfH5COF2w=
X-Received: by 2002:a05:6871:a10c:b0:3f5:694f:9366 with SMTP id
 586e51a60fabf-40ec717b509mr2159223fac.30.1770916940185; Thu, 12 Feb 2026
 09:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
 <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net> <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net> <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYPnATz1JakV3m7@mail.minyard.net> <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
 <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
 <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com> <aY4EUQcGbmT3Rexz@mail.minyard.net>
In-Reply-To: <aY4EUQcGbmT3Rexz@mail.minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Feb 2026 18:22:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ip-Ke9p-2Qd9EQpp-J4Te53S4WsrJDeJPi_5o+U2_wNA@mail.gmail.com>
X-Gm-Features: AZwV_Qh0UmHRmkEvLuydH78UdsaUws0mud-joDn_yBBS4fNjMAV0T8aEiVFRK54
Message-ID: <CAJZ5v0ip-Ke9p-2Qd9EQpp-J4Te53S4WsrJDeJPi_5o+U2_wNA@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: corey@minyard.net
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>, linux-acpi@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-20960-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email,minyard.net:email,gooddata.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B5E4E12FDC5
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 5:48=E2=80=AFPM Corey Minyard <corey@minyard.net> w=
rote:
>
> On Thu, Feb 12, 2026 at 01:27:41PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 12, 2026 at 10:11???AM Jaroslav Pulchart
> > <jaroslav.pulchart@gooddata.com> wrote:
> > >
> > > >
> > > > On Fri, Feb 6, 2026 at 4:58???PM Corey Minyard <corey@minyard.net> =
wrote:
> > > > >
> > > > > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Thu, Feb 5, 2026 at 11:34???PM Guenter Roeck <linux@roeck-us=
.net> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki w=
rote:
> > > > > > > > Cc: Corey
> > > > > > > >
> > > > > > > > On Thu, Feb 5, 2026 at 6:51???PM Guenter Roeck <linux@roeck=
-us.net> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrot=
e:
> > > > > > > > > > On Wed, Feb 4, 2026 at 11:49???PM Guenter Roeck <linux@=
roeck-us.net> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > > > > > I have written a patch with the help of AI and it f=
ixes the problem. Attached.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > "No MIME, no links, no compression, no attachments.  =
Just plain text"
> > > > > > > > > >
> > > > > > > > > > Sorry for that, I had assumed that attaching the file w=
ould make it in-line.
> > > > > > > > > >
> > > > > > > > > > > ... which means I can not provide inline feedback, wh=
ich is the whole
> > > > > > > > > > > point of the above.
> > > > > > > > > > >
> > > > > > > > > > > Your patch crosses subsystems, so it will need to be =
split in two
> > > > > > > > > > > (assuming the ACPI side is even needed). Also, refere=
nces to iDRAC
> > > > > > > > > > > in common code seem inappropriate.
> > > > > > > > > >
> > > > > > > > > > Yes, this I believe was the essential part (it was the =
last piece in
> > > > > > > > > > my testing which fixed the hanging):
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Then I'll need to ask differently: What happens if you dr=
op the IPMI code,
> > > > > > > > > and just keep the wait_for_completion -> wait_for_complet=
ion_timeout
> > > > > > > > > change ? Would that be sufficient to solve the problem ?
> > > > > > > >
> > > > > > > > I'd rather say "Would that be sufficient to make the sympto=
ms go
> > > > > > > > away?" as it most likely papers over the real problem.
> > > > > > > >
> > > > > > >
> > > > > > > Good point. Worse, it may result in UAF or memory leaks.
> > > > > > >
> > > > > > > > > Either case, the need for this change suggests that the i=
pmi change
> > > > > > > > > may not be complete, since it should send a completion wi=
th an error.
> > > > > > > >
> > > > > > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Grace=
fully
> > > > > > > > handle if the BMC is non-functional") should also be consid=
ered as a
> > > > > > > > possible way forward because it clearly did not improve thi=
ngs as
> > > > > > > > expected, at least in this particular case.
> > > > > > > >
> > > > > > >
> > > > > > > I tend to agree. I ran a number of AI code reviews over the p=
atch, and
> > > > > > > each time it finds new (and different) problems. The fact tha=
t the acpi
> > > > > > > patch is still needed even after applying the ipmi changes su=
ggests that
> > > > > > > something is still missing in the ipmi code.
> > > > > > >
> > > > > > > > It evidently did something that confuses things quite a bit=
.  Either
> > > > > > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIE=
D, or it is
> > > > > > > > the "hosed" state and refusing to accept messages.
> > > > > > > >
> > > > > > >
> > > > > > > More than that. My latest AI results are below, just for refe=
rence
> > > > > > > (using Gemini 3 with Chris Mason's debug prompts). The prompt=
 I used
> > > > > > > for this run is:
> > > > > >
> > > > > > Well, I guess it's time to send a revert patch then.
> > > > >
> > > > > Thanks for the CC.
> > > > >
> > > > > Let's fix it right in the IPMI driver.
> > > > >
> > > > > >
> > > > > > > "
> > > > > > > The top commit in the linux/ directory results in hung tasks =
if the BMC
> > > > > > > stops responding. Using @review-prompts/kernel/debugging.md a=
nalyze the
> > > > > > > patch, identify the reason for the hung task problem, suggest=
 and implement
> > > > > > > a fix. Note that there may be more than one problem in the pa=
tch, so analyze
> > > > > > > the complete patch and do not stop after fiding the first reg=
ression.
> > > > > > > "
> > > > > > >
> > > > > > > I think that catches most of the problem, but not all of it.
> > > > > > >
> > > > > > > Guenter
> > > > > > >
> > > > > > > ---
> > > > > > >
> > > > > > > Summary of crash or warning:
> > > > > > > Hung task detected in ipmi_si driver when BMC becomes non-fun=
ctional.
> > > > > > > Processes waiting for IPMI responses (e.g. ipmitool, monitori=
ng agents) enter D state and never recover.
> > > > > > >
> > > > > > > Kernel version if available:
> > > > > > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > > > > > >
> > > > > > > Machine type if available:
> > > > > > > Generic Server with BMC
> > > > > > >
> > > > > > > Cleaned up copy of oops or stack trace:
> > > > > > > [  120.123456] INFO: task ipmitool:1234 blocked for more than=
 120 seconds.
> > > > > > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > > > > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_s=
ecs" disables this message.
> > > > > > > [  120.123459] task:ipmitool        state:D stack:    0 pid: =
1234 ppid:  100 flags:0x00000000
> > > > > > > [  120.123460] Call Trace:
> > > > > > > [  120.123461]  <TASK>
> > > > > > > [  120.123462]  __schedule+0x123/0x456
> > > > > > > [  120.123463]  schedule+0x45/0x78
> > > > > > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > > > > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > > > > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > > > > > [  120.123467]  ...
> > > > > > > [  120.123468]  </TASK>
> > > > > > >
> > > > > > > Any other kernel messages you found relevant:
> > > > > > > N/A
> > > > > > >
> > > > > > > Explanation of the problem:
> > > > > > > 1. Hung Task:
> > > > > > > The patch "ipmi:si: Gracefully handle if the BMC is non-funct=
ional" introduces a new state `SI_HOSED` to handle BMC failures. When the d=
river detects that the BMC is not responding, it transitions to `SI_HOSED` =
and fails the currently processing message (`curr_msg`). However, if a new =
message is queued via `sender()` (populating `waiting_msg`) during a recove=
ry probe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the=
 state machine transitions back to `SI_HOSED`. In this transition, the driv=
er checks and fails `curr_msg`, but it neglects to check or fail `waiting_m=
sg`. As a result, the `waiting_msg` remains in the queue indefinitely, caus=
ing the waiting process to hang.
> > > > > >
> > > > > > That's quite convincing and it would explain the observed sympt=
oms.
> > > > >
> > > > > Yes, and it's a fairly easy fix, I think.  The waiting message ju=
st
> > > > > needs to be returned in that case.  The following patch should do=
 it:
> > > >
> > > > Jaroslav, it would be good to test the patch below on top of 6.19. =
 I
> > > > can put it on a test git branch if need be, so please let me know.
> > > >
> > > > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi=
/ipmi_si_intf.c
> > > > > index 5459ffdde8dc..ff159b1162b9 100644
> > > > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > > > @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(s=
truct smi_info *smi_info,
> > > > >                          */
> > > > >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > > >                 }
> > > > > +               if (smi_info->waiting_msg !=3D NULL) {
> > > > > +                       /* Also handle if there was a message wai=
ting. */
> > > > > +                       smi_info->curr_msg =3D smi_info->waiting_=
msg;
> > > > > +                       smi_info->waiting_msg =3D NULL;
> > > > > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > > > +               }
> > > > >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSE=
D);
> > > > >                 goto out;
> > > > >         }
> > >
> > > I apply ^ patch to both 6.18.10 and 6.19 and reproduced the issue on
> > > both, so it does not fix the problem.
> >
> > Thanks!
> >
> > With all due respect to everyone involved (including the AI), this
> > means that we are not anywhere close to fixing the problem and it
> > would be a shame to ship 7.0 with it.
> >
> > I'm sending a revert patch shortly.
>
> Unfortunately, that patch fixed an issue others were having.

Granted, it broke something else, so it needs to be fixed or reverted.

Maybe there is a way to address the original problem fixed by it differentl=
y?

Do you have any pointers to any problem reports regarding that one?

