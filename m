Return-Path: <linux-acpi+bounces-20951-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHlIGaLHjWnT6gAAu9opvQ
	(envelope-from <linux-acpi+bounces-20951-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:29:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C482E12D77A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C160300B9EF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FF357737;
	Thu, 12 Feb 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td+O60h0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3012299937
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899274; cv=none; b=lmWcxPiLo6HlviNS+8hW3mqHgXCIKkIPy9IowT0uhaBP/HjBY3Wrv1S5IkxF6d5xVYALTTqYACAGlXtpvbY3sX8iMkBSHhk4RTgX9ZRErNtUhIgGNZnlEKzhBstUBH/+yIJ248ROEZpadsF2eNee04LYPb0CB2RvWNKEoPxeVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899274; c=relaxed/simple;
	bh=1TapchaOeDo4DU3RKgLfJoN7iQb9xpdBnAtWjN6Z8AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2eMnNXJFoRgaxdqCUO9gZHBGi02nV6nF+ieWLLXRQNCOCR/0ZxqIUZjDwqic755bSyamuSOeEC1o+iwtIfKNHNB/KYuc8tvQWQNlUSbC0ObxxAY1bzmfxjgb2fFhhXRUf89RCVf+mqKkuIYAfHgAXZFfFfHJF8qO/W65tMi3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td+O60h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94765C2BC86
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770899274;
	bh=1TapchaOeDo4DU3RKgLfJoN7iQb9xpdBnAtWjN6Z8AE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Td+O60h0rWcp5JQItduVLFf7bDC7FDL2BBwJG8nCSt58FQ/ymyQpq6B2ga36bCgLZ
	 VqazjRDgzMzMYGs8q/cbdtXV5S8ALeK43LCYuYC5Sc/3FxylhW0Ed4ffH9btu8ndlt
	 8AeeuJrucgYLlV2uPkvwNaUuGEPTUBkw7iv+3gvxq+2SabQKVDfGgEJx9LDWEcq/Cy
	 DurY/DxLtlEU6mlR41qIS1ZbDazSRg+7pdY7y5KTUGlgUJBqae2S1FK0NwQNfoE2qm
	 uW03SLzgXFTTXviEDaK2q5YkveCM4pKrKI1ih1bbGK261rJv1eJWtZu2E0kmgwhkj0
	 hos0Pcjg/t7nw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-404263bd58fso1283664fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 04:27:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6VeUWaKrJrtRN3k1fWlE3vS5RjAvaqgReWZNCtLI2YxIizDIGKdWe0bpb3cB5dt6I8Est9I2AHadR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ozRywjAV4mU+9nCCUa/fqur0vXtM4Sx7R+A/pCARwMBlkgKQ
	6tWXpiBFWC3LP/fmcq+7fq2WKpSSE4WTKWzR/hYkux038/Xi07C9FcPSBmlWd2PUm1bY1g0Y3VD
	5u0Li6XqWJp91Qtu1kEfYyWpTsgOOIKE=
X-Received: by 2002:a05:6820:4cca:b0:676:66f5:1009 with SMTP id
 006d021491bc7-67666f5120bmr309620eaf.31.1770899273622; Thu, 12 Feb 2026
 04:27:53 -0800 (PST)
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
 <aYYPnATz1JakV3m7@mail.minyard.net> <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
 <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
In-Reply-To: <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Feb 2026 13:27:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com>
X-Gm-Features: AZwV_QjKvCsz5NclIuWsOazHIT-eOAlAhHaLSUS9E0Bj-ltCz7DzkxuCfOYVMN4
Message-ID: <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, corey@minyard.net, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20951-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: C482E12D77A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 10:11=E2=80=AFAM Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> wrote:
>
> >
> > On Fri, Feb 6, 2026 at 4:58=E2=80=AFPM Corey Minyard <corey@minyard.net=
> wrote:
> > >
> > > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Guenter Roeck <linux@roeck-=
us.net> wrote:
> > > > >
> > > > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > Cc: Corey
> > > > > >
> > > > > > On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Guenter Roeck <linux@roe=
ck-us.net> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > > > > On Wed, Feb 4, 2026 at 11:49=E2=80=AFPM Guenter Roeck <linu=
x@roeck-us.net> wrote:
> > > > > > > > >
> > > > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > > > I have written a patch with the help of AI and it fixes=
 the problem. Attached.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > "No MIME, no links, no compression, no attachments.  Just=
 plain text"
> > > > > > > >
> > > > > > > > Sorry for that, I had assumed that attaching the file would=
 make it in-line.
> > > > > > > >
> > > > > > > > > ... which means I can not provide inline feedback, which =
is the whole
> > > > > > > > > point of the above.
> > > > > > > > >
> > > > > > > > > Your patch crosses subsystems, so it will need to be spli=
t in two
> > > > > > > > > (assuming the ACPI side is even needed). Also, references=
 to iDRAC
> > > > > > > > > in common code seem inappropriate.
> > > > > > > >
> > > > > > > > Yes, this I believe was the essential part (it was the last=
 piece in
> > > > > > > > my testing which fixed the hanging):
> > > > > > > >
> > > > > > >
> > > > > > > Then I'll need to ask differently: What happens if you drop t=
he IPMI code,
> > > > > > > and just keep the wait_for_completion -> wait_for_completion_=
timeout
> > > > > > > change ? Would that be sufficient to solve the problem ?
> > > > > >
> > > > > > I'd rather say "Would that be sufficient to make the symptoms g=
o
> > > > > > away?" as it most likely papers over the real problem.
> > > > > >
> > > > >
> > > > > Good point. Worse, it may result in UAF or memory leaks.
> > > > >
> > > > > > > Either case, the need for this change suggests that the ipmi =
change
> > > > > > > may not be complete, since it should send a completion with a=
n error.
> > > > > >
> > > > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefull=
y
> > > > > > handle if the BMC is non-functional") should also be considered=
 as a
> > > > > > possible way forward because it clearly did not improve things =
as
> > > > > > expected, at least in this particular case.
> > > > > >
> > > > >
> > > > > I tend to agree. I ran a number of AI code reviews over the patch=
, and
> > > > > each time it finds new (and different) problems. The fact that th=
e acpi
> > > > > patch is still needed even after applying the ipmi changes sugges=
ts that
> > > > > something is still missing in the ipmi code.
> > > > >
> > > > > > It evidently did something that confuses things quite a bit.  E=
ither
> > > > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, o=
r it is
> > > > > > the "hosed" state and refusing to accept messages.
> > > > > >
> > > > >
> > > > > More than that. My latest AI results are below, just for referenc=
e
> > > > > (using Gemini 3 with Chris Mason's debug prompts). The prompt I u=
sed
> > > > > for this run is:
> > > >
> > > > Well, I guess it's time to send a revert patch then.
> > >
> > > Thanks for the CC.
> > >
> > > Let's fix it right in the IPMI driver.
> > >
> > > >
> > > > > "
> > > > > The top commit in the linux/ directory results in hung tasks if t=
he BMC
> > > > > stops responding. Using @review-prompts/kernel/debugging.md analy=
ze the
> > > > > patch, identify the reason for the hung task problem, suggest and=
 implement
> > > > > a fix. Note that there may be more than one problem in the patch,=
 so analyze
> > > > > the complete patch and do not stop after fiding the first regress=
ion.
> > > > > "
> > > > >
> > > > > I think that catches most of the problem, but not all of it.
> > > > >
> > > > > Guenter
> > > > >
> > > > > ---
> > > > >
> > > > > Summary of crash or warning:
> > > > > Hung task detected in ipmi_si driver when BMC becomes non-functio=
nal.
> > > > > Processes waiting for IPMI responses (e.g. ipmitool, monitoring a=
gents) enter D state and never recover.
> > > > >
> > > > > Kernel version if available:
> > > > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > > > >
> > > > > Machine type if available:
> > > > > Generic Server with BMC
> > > > >
> > > > > Cleaned up copy of oops or stack trace:
> > > > > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120=
 seconds.
> > > > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> > > > > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234=
 ppid:  100 flags:0x00000000
> > > > > [  120.123460] Call Trace:
> > > > > [  120.123461]  <TASK>
> > > > > [  120.123462]  __schedule+0x123/0x456
> > > > > [  120.123463]  schedule+0x45/0x78
> > > > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > > > [  120.123467]  ...
> > > > > [  120.123468]  </TASK>
> > > > >
> > > > > Any other kernel messages you found relevant:
> > > > > N/A
> > > > >
> > > > > Explanation of the problem:
> > > > > 1. Hung Task:
> > > > > The patch "ipmi:si: Gracefully handle if the BMC is non-functiona=
l" introduces a new state `SI_HOSED` to handle BMC failures. When the drive=
r detects that the BMC is not responding, it transitions to `SI_HOSED` and =
fails the currently processing message (`curr_msg`). However, if a new mess=
age is queued via `sender()` (populating `waiting_msg`) during a recovery p=
robe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the sta=
te machine transitions back to `SI_HOSED`. In this transition, the driver c=
hecks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`.=
 As a result, the `waiting_msg` remains in the queue indefinitely, causing =
the waiting process to hang.
> > > >
> > > > That's quite convincing and it would explain the observed symptoms.
> > >
> > > Yes, and it's a fairly easy fix, I think.  The waiting message just
> > > needs to be returned in that case.  The following patch should do it:
> >
> > Jaroslav, it would be good to test the patch below on top of 6.19.  I
> > can put it on a test git branch if need be, so please let me know.
> >
> > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipm=
i_si_intf.c
> > > index 5459ffdde8dc..ff159b1162b9 100644
> > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struc=
t smi_info *smi_info,
> > >                          */
> > >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > >                 }
> > > +               if (smi_info->waiting_msg !=3D NULL) {
> > > +                       /* Also handle if there was a message waiting=
. */
> > > +                       smi_info->curr_msg =3D smi_info->waiting_msg;
> > > +                       smi_info->waiting_msg =3D NULL;
> > > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > +               }
> > >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
> > >                 goto out;
> > >         }
>
> I apply ^ patch to both 6.18.10 and 6.19 and reproduced the issue on
> both, so it does not fix the problem.

Thanks!

With all due respect to everyone involved (including the AI), this
means that we are not anywhere close to fixing the problem and it
would be a shame to ship 7.0 with it.

I'm sending a revert patch shortly.

