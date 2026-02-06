Return-Path: <linux-acpi+bounces-20878-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEzWFurZhWlZHQQAu9opvQ
	(envelope-from <linux-acpi+bounces-20878-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 13:09:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34CFD7A2
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9126E3006D47
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AD3A0B05;
	Fri,  6 Feb 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msRoMfjU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2914309EE7
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379749; cv=none; b=jxSqoZjlmCGRD8zO+qZQsLXxdweLY7G0vq7PWfOEb+KsVnDSWB+30N1QppybUzZUmZ7yCrpJwCkUg7j8O5t1RjKFkSvMPnKrdrcbe8e1VjswNezDWSjyOzfYtbJsmYBDaMVdb5e1QA3yEK1l9jJA6y61AVRiwkWT2EkA/7xuaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379749; c=relaxed/simple;
	bh=YhG37LeR9IP7/7ZENXZfb+hZAsjNbmgjXLGpt1n63Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl/rBVHhRZU5ml4GRQHGamBZI54VAFFshfUsvIeyP6G0RmvUnjuyNvz4P85gMxJhCqnbLQrKSqAIyPpnvd+LiEHm2C1Z9gPMgcuInvFATQvJkXHTQaJFWilz86ufRje8KZWks4rGSB75pHgH/38Ec9nuhnAsjXRh+rQYQWF/GzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msRoMfjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C12BC2BCB1
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770379749;
	bh=YhG37LeR9IP7/7ZENXZfb+hZAsjNbmgjXLGpt1n63Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=msRoMfjUNYZLVWSFNPALKU4CRj1M4YsVLdoGppduDnAA1HF6rgD1IwSFh+HxxS5F3
	 HojO2hiMoYCX2E5pIylsScXB6aUIfI9+GONpORIFxgWvSjwyEXKW3JskE7rxNWHkZ3
	 WsOpXq1tJOmIXleWqCJQzlVv3aDVzpb8tjTrlXGQKotl3sLWA8kb/Ulwo7cSxNQ8VM
	 fnsXP3cLtBH/sioDUJGOI3fPUlyZIOrkfJ/uoZxkwkcRCHF3A94uQ7enQOkLM+CXbE
	 gug/SDbMQcU2idsaYgK77mQrzMQNSn40c3o5zu9+kZBUKZUnUicdFt5EF6M8TxHklX
	 8lXEtlT0EbWJQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4094d7d71a9so206070fac.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 04:09:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWsxot4z/MyWTHxbld2Vc/WJIDPXDkardy72gCIAgLn/e4ZIyOyS0hC9sgFqKd/2iCRs6C4VQqFVSC@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtdD3N6pspgQqM2qNa3NOpHFtqLYoJXkH7RZzdoqVXKLe+fiU
	siphbLIe7xp1qgF87LDoZRNx3zX6fJakzzoJWzLyZX7zahldGZumj38Rq1Akm8Lq61l+sEgOyB+
	1dSyfJl4XCNHZoxmHSKR50up56CUWV6M=
X-Received: by 2002:a05:6870:d06:b0:3e8:983c:c8a with SMTP id
 586e51a60fabf-40a96e80e57mr1332822fac.37.1770379748073; Fri, 06 Feb 2026
 04:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net> <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net> <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net> <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
In-Reply-To: <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Feb 2026 13:08:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
X-Gm-Features: AZwV_Qi1z9oFoRF9DTyjg8MChUsKPf90ghSceMYHLJww31ZKI2B7idUzdkUm9ac
Message-ID: <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Igor Raits <igor@gooddata.com>, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>, Corey Minyard <corey@minyard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20878-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6C34CFD7A2
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > Cc: Corey
> >
> > On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> > >
> > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > On Wed, Feb 4, 2026 at 11:49=E2=80=AFPM Guenter Roeck <linux@roeck-=
us.net> wrote:
> > > > >
> > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > I have written a patch with the help of AI and it fixes the pro=
blem. Attached.
> > > > > >
> > > > >
> > > > > "No MIME, no links, no compression, no attachments.  Just plain t=
ext"
> > > >
> > > > Sorry for that, I had assumed that attaching the file would make it=
 in-line.
> > > >
> > > > > ... which means I can not provide inline feedback, which is the w=
hole
> > > > > point of the above.
> > > > >
> > > > > Your patch crosses subsystems, so it will need to be split in two
> > > > > (assuming the ACPI side is even needed). Also, references to iDRA=
C
> > > > > in common code seem inappropriate.
> > > >
> > > > Yes, this I believe was the essential part (it was the last piece i=
n
> > > > my testing which fixed the hanging):
> > > >
> > >
> > > Then I'll need to ask differently: What happens if you drop the IPMI =
code,
> > > and just keep the wait_for_completion -> wait_for_completion_timeout
> > > change ? Would that be sufficient to solve the problem ?
> >
> > I'd rather say "Would that be sufficient to make the symptoms go
> > away?" as it most likely papers over the real problem.
> >
>
> Good point. Worse, it may result in UAF or memory leaks.
>
> > > Either case, the need for this change suggests that the ipmi change
> > > may not be complete, since it should send a completion with an error.
> >
> > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > handle if the BMC is non-functional") should also be considered as a
> > possible way forward because it clearly did not improve things as
> > expected, at least in this particular case.
> >
>
> I tend to agree. I ran a number of AI code reviews over the patch, and
> each time it finds new (and different) problems. The fact that the acpi
> patch is still needed even after applying the ipmi changes suggests that
> something is still missing in the ipmi code.
>
> > It evidently did something that confuses things quite a bit.  Either
> > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it is
> > the "hosed" state and refusing to accept messages.
> >
>
> More than that. My latest AI results are below, just for reference
> (using Gemini 3 with Chris Mason's debug prompts). The prompt I used
> for this run is:

Well, I guess it's time to send a revert patch then.

> "
> The top commit in the linux/ directory results in hung tasks if the BMC
> stops responding. Using @review-prompts/kernel/debugging.md analyze the
> patch, identify the reason for the hung task problem, suggest and impleme=
nt
> a fix. Note that there may be more than one problem in the patch, so anal=
yze
> the complete patch and do not stop after fiding the first regression.
> "
>
> I think that catches most of the problem, but not all of it.
>
> Guenter
>
> ---
>
> Summary of crash or warning:
> Hung task detected in ipmi_si driver when BMC becomes non-functional.
> Processes waiting for IPMI responses (e.g. ipmitool, monitoring agents) e=
nter D state and never recover.
>
> Kernel version if available:
> Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
>
> Machine type if available:
> Generic Server with BMC
>
> Cleaned up copy of oops or stack trace:
> [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 seconds=
.
> [  120.123457]       Not tainted 6.14.0-rc1 #1
> [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppid:  =
100 flags:0x00000000
> [  120.123460] Call Trace:
> [  120.123461]  <TASK>
> [  120.123462]  __schedule+0x123/0x456
> [  120.123463]  schedule+0x45/0x78
> [  120.123464]  schedule_timeout+0x9a/0xbc
> [  120.123465]  wait_for_completion+0xde/0xf0
> [  120.123466]  ipmi_request_settime+0x123/0x145
> [  120.123467]  ...
> [  120.123468]  </TASK>
>
> Any other kernel messages you found relevant:
> N/A
>
> Explanation of the problem:
> 1. Hung Task:
> The patch "ipmi:si: Gracefully handle if the BMC is non-functional" intro=
duces a new state `SI_HOSED` to handle BMC failures. When the driver detect=
s that the BMC is not responding, it transitions to `SI_HOSED` and fails th=
e currently processing message (`curr_msg`). However, if a new message is q=
ueued via `sender()` (populating `waiting_msg`) during a recovery probe (st=
ate `SI_GETTING_FLAGS`), and that probe subsequently fails, the state machi=
ne transitions back to `SI_HOSED`. In this transition, the driver checks an=
d fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As a re=
sult, the `waiting_msg` remains in the queue indefinitely, causing the wait=
ing process to hang.

That's quite convincing and it would explain the observed symptoms.

> 2. Excessive Polling (Timer Overwrite):
> In `smi_timeout()`, the timer is unconditionally reset to a short timeout=
 (e.g., 10ms) at the end of the function, unless the state machine is IDLE.=
 When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` correc=
tly sets the timer to a long backoff (1 second). However, `smi_timeout()` s=
ubsequently overwrites this with the short timeout. This causes the driver =
to poll the hosed BMC every 10ms instead of backing off for 1 second, resul=
ting in unnecessary CPU overhead.

Well, that's not nice, but it doesn't seem to be related to the
observed symptoms.

> Functions, snippets and call traces of code related to the problem:
>
> drivers/char/ipmi/ipmi_si_intf.c: smi_event_handler()
>
>         } else if (si_sm_result =3D=3D SI_SM_HOSED) {
>                 /* ... */
>                 smi_info->si_state =3D SI_HOSED;
>                 if (smi_info->curr_msg !=3D NULL) {
>                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
>                 }
>                 /* BUG 1: waiting_msg is NOT checked here! */
>
>                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED); /* S=
ets 1s timeout */
>                 goto out;
>         }
>
> drivers/char/ipmi/ipmi_si_intf.c: smi_timeout()
>
>         smi_result =3D smi_event_handler(smi_info, time_diff);
>         /* ... */
>         if (smi_result !=3D SI_SM_IDLE)
>                 smi_mod_timer(smi_info, timeout); /* BUG 2: Overwrites 1s=
 timeout with ~10ms */
>
> List of potential commits related to the problem:
> bc3a9d217755f65c137f145600f23bf1d6c31ea9 ipmi:si: Gracefully handle if th=
e BMC is non-functional
>
> Suggested fix:
> 1. When entering `SI_HOSED` state in `smi_event_handler`, check for and f=
ail any pending `waiting_msg` in addition to `curr_msg`.
> 2. In `smi_timeout`, do not reset the timer if the state is `SI_HOSED`, p=
reserving the backoff timeout set by `smi_event_handler`.
>
> ---
> Suggested diffs from that run:
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si=
_intf.c
> index 1c65275906b4..023b0e819f91 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -810,6 +810,11 @@ static enum si_sm_result smi_event_handler(struct sm=
i_info *smi_info,
>                          */
>                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
>                 }
> +               if (smi_info->waiting_msg !=3D NULL) {
> +                       smi_info->curr_msg =3D smi_info->waiting_msg;
> +                       smi_info->waiting_msg =3D NULL;
> +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> +               }
>                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
>                 goto out;
>         }
> @@ -1130,10 +1135,12 @@ static void smi_timeout(struct timer_list *t)
>                 timeout =3D jiffies + SI_TIMEOUT_JIFFIES;
>         }
>
> -       if (smi_result !=3D SI_SM_IDLE)
> -               smi_mod_timer(smi_info, timeout);
> -       else
> +       if (smi_result !=3D SI_SM_IDLE) {
> +               if (smi_info->si_state !=3D SI_HOSED)
> +                       smi_mod_timer(smi_info, timeout);
> +       } else {
>                 smi_info->timer_running =3D false;
> +       }
>         spin_unlock_irqrestore(&(smi_info->si_lock), flags);
>  }

Well, I'd leave fixing the IPMI handling to somebody familiar with that cod=
e.

