Return-Path: <linux-acpi+bounces-20946-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIsYOkKZjWkt5AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20946-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 10:11:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C512BC89
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 10:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 782A23009E18
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F662DE1E0;
	Thu, 12 Feb 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="TYH2NCIF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A72DAFAC
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887485; cv=pass; b=K8qnZdD7te9zGKdBLoGoYPEeNV0lPa9j9iQ+PVVa5O6k7R5NoLM5lzvFRBz8jxiVbWxIjEtEh3Hdk+2+SVMr07c7LGJTDb1WrY/Vaqqrp+KLiaq6FZmx6tVFWTV0L5qxDHFbDEVvqj8926OXIuyFa64CRBs9hSNSBlc1/Agcu+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887485; c=relaxed/simple;
	bh=cRNC+rdtEtUaGQagx+0fcxkvHbJbpHUxRpDsY7egkro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfh3AxeOzztoZWhoA5/V7K8DA08C4C+Xuj5rYjWjnhRyNHBL50eXthmRIoDyz9Qda2qB4UeNoiLk0b3lLDb5AmWsHv73LFrhlwOcIAS9i0T6Ea4ED6XJAeMZPF+ZC/6q0+Z4i10xvhoPH9+rhTyC9WrKUabyhKiakpweGJXYB0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=TYH2NCIF; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so7575801c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 01:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770887483; cv=none;
        d=google.com; s=arc-20240605;
        b=QaHxIsUaJXyh6pXje5Pohdnn3ApbTq7jhIt947YfuHOzsulcTWz/p12TEG3iadlJNl
         aKwhpwVDGBiwsbl8ZAGg5swg4KydRY5nSnyN2On6PbZTGfe/1aYgD/DG0yJwqxxWu7Ww
         x+65arrZczMnSqYkcEm010rDo7D764ABj+2t+l0nwHskSz8gwF/OZ1g5DvWfGpnNIkeQ
         KDwr7fKzA1LYMcIszLxHtz1wn6s8KWMGafDRPV5Wif8jBlIQeyWhOrE/m9N0aC9eXO6x
         4ylfEWHLDE5m2XldbY03VIBoetXpNHRYx0+mAtmAZeYIEegRnFaMkk1NDn3EnTQMgD2e
         CaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VfDX2mgTB1Ian4nv+rxpJLQ0hBYYCnjiqqwkDC/FZZM=;
        fh=myEvFG7wwL+RQCdDq5uNCj/ZzaWBBs5SnNl9O9J1o10=;
        b=kN5V0F/l71oSKrdgAOORQPyRzkWraokQmqo/hbVixMY6G89axjopZz2nOJiyKQwkTZ
         nk2v3wZ8Zf186GjNSeV6gs15VGDH9uGR5Pv8pVci3yhy5vavbn5qmkH4Pho1NOogh1bu
         XS+TaHN9ZlP00nhDe/YDBWj6Yqf6/EXYqHTiFSnwTmz2brUVY2NTzvdSIYnnjqpG5c0E
         Y311wx5fzYX1qH7WxonzBOVL/+Sa7UeiMjgkePYcLXHN1qtacExoQWpU0C0JGuYm3UQB
         f9/y0HYmXh+BDfEUOI6K+EXXfCABb88/T5opDpbq9d7o+gHgLxKHvrTwR3k+7yUoG1Wu
         fvmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770887483; x=1771492283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfDX2mgTB1Ian4nv+rxpJLQ0hBYYCnjiqqwkDC/FZZM=;
        b=TYH2NCIFIrRBxyDA3VAE3/yDli4I2tjY06S7CoGuDJKU2erCZboRU0P/Pd3GJa24IY
         Hpx2lLOkLYF5/Pfs3Ur/TvzsDG9+60F0kpWwGj4we9JfmrR9HY1mLGJPscXRxTCyrlz1
         49xkU1Dglg84GLsi7tSvtTGkzix0NBfx0tjdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770887483; x=1771492283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfDX2mgTB1Ian4nv+rxpJLQ0hBYYCnjiqqwkDC/FZZM=;
        b=sHHxiSmSbGgtubNuFbzQLF0+4cE4bxeWOSRpsvGFDZxe/MuSDaMoxHZd2eNE6AVwVw
         aBIEWEkBMMNh2FvfczVPYJtn3n22x2T3//Cr6PeSyxOAMfgN0s/6mAsmq4k5Sti+aSQu
         MOgCMg5bq0Ogm0BjD7Yrnc8Clb7qLbsiR+5o19TUS8wqOQA1sHs4YCst071jiXRdaUCD
         HXPT8iwHoY0KgUAGMcQwqEGOpmRafh0wO9NjWnasV+0YRW9wbbt70IWQnNvQ01fjxvuJ
         n4QS3Udumvb/6f/HXlwuO2RvSu8t30Bwh89UL8sfhODjKSC6QdTJSRzgnrXzJgBYepeg
         QBEw==
X-Forwarded-Encrypted: i=1; AJvYcCWt3scdfEEV4EYlPoKLJshTV9y2KgbYUhingLee1qp0NydCwPQYiVt0xXziVcv3TWOaVmbjYI+ZDFzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WdRlex2MygG6oiBHPOAqxTGi96bKAK3NLKLfTCmyzvSYSGag
	gIYKibRmoithjLAlnlkFb3ku5mAQK5eTi/unQIGqAQM69dqhmecSE/DU2Jxj4SoHkq+BmUjNnVF
	lqTGhY8kP5XHTwY6SuNVSaRIVdxUEpJrINshIsYg0
X-Gm-Gg: AZuq6aKUs83LSEG0jFu0wlGVEA2uURs96Brb+4QYiTMsRYhIBQjzUAcaZikOeNOfK/9
	mBEWN50u6lyrQc4ekenIDXWAhPQD8zptrD3ILnHWY8A5MjMXK90x+SnV/ysQQAzgrPC7U9TywkJ
	nZEfxBCUL9wfJr3QU6eTKPbscwrNMKi+FYB5rUm1pEI30xOzFCumQ8VyRijfWN4/HS8WQiHcl5d
	3GSrC1fHsr3FK1w93qUPh/Wi1phWy5paDcdTSx8nMY8lEaqU216j8DtGWRM5z7evNN7DIWIt6fs
	H5ZPT654
X-Received: by 2002:a05:7022:6097:b0:11a:e426:911a with SMTP id
 a92af1059eb24-1272f74833fmr788891c88.15.1770887482648; Thu, 12 Feb 2026
 01:11:22 -0800 (PST)
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
In-Reply-To: <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 12 Feb 2026 10:10:54 +0100
X-Gm-Features: AZwV_QjMkP0Mzlfv9lfzRC-S8o3p0hVOyW_B-0D-12PMwrgPARLIql3K_dtUFbQ
Message-ID: <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average sysfs
 read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: corey@minyard.net, Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20946-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gooddata.com:+]
X-Rspamd-Queue-Id: 120C512BC89
X-Rspamd-Action: no action

>
> On Fri, Feb 6, 2026 at 4:58=E2=80=AFPM Corey Minyard <corey@minyard.net> =
wrote:
> >
> > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> > > >
> > > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > > > > Cc: Corey
> > > > >
> > > > > On Thu, Feb 5, 2026 at 6:51=E2=80=AFPM Guenter Roeck <linux@roeck=
-us.net> wrote:
> > > > > >
> > > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > > > On Wed, Feb 4, 2026 at 11:49=E2=80=AFPM Guenter Roeck <linux@=
roeck-us.net> wrote:
> > > > > > > >
> > > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > > I have written a patch with the help of AI and it fixes t=
he problem. Attached.
> > > > > > > > >
> > > > > > > >
> > > > > > > > "No MIME, no links, no compression, no attachments.  Just p=
lain text"
> > > > > > >
> > > > > > > Sorry for that, I had assumed that attaching the file would m=
ake it in-line.
> > > > > > >
> > > > > > > > ... which means I can not provide inline feedback, which is=
 the whole
> > > > > > > > point of the above.
> > > > > > > >
> > > > > > > > Your patch crosses subsystems, so it will need to be split =
in two
> > > > > > > > (assuming the ACPI side is even needed). Also, references t=
o iDRAC
> > > > > > > > in common code seem inappropriate.
> > > > > > >
> > > > > > > Yes, this I believe was the essential part (it was the last p=
iece in
> > > > > > > my testing which fixed the hanging):
> > > > > > >
> > > > > >
> > > > > > Then I'll need to ask differently: What happens if you drop the=
 IPMI code,
> > > > > > and just keep the wait_for_completion -> wait_for_completion_ti=
meout
> > > > > > change ? Would that be sufficient to solve the problem ?
> > > > >
> > > > > I'd rather say "Would that be sufficient to make the symptoms go
> > > > > away?" as it most likely papers over the real problem.
> > > > >
> > > >
> > > > Good point. Worse, it may result in UAF or memory leaks.
> > > >
> > > > > > Either case, the need for this change suggests that the ipmi ch=
ange
> > > > > > may not be complete, since it should send a completion with an =
error.
> > > > >
> > > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > > > > handle if the BMC is non-functional") should also be considered a=
s a
> > > > > possible way forward because it clearly did not improve things as
> > > > > expected, at least in this particular case.
> > > > >
> > > >
> > > > I tend to agree. I ran a number of AI code reviews over the patch, =
and
> > > > each time it finds new (and different) problems. The fact that the =
acpi
> > > > patch is still needed even after applying the ipmi changes suggests=
 that
> > > > something is still missing in the ipmi code.
> > > >
> > > > > It evidently did something that confuses things quite a bit.  Eit=
her
> > > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or =
it is
> > > > > the "hosed" state and refusing to accept messages.
> > > > >
> > > >
> > > > More than that. My latest AI results are below, just for reference
> > > > (using Gemini 3 with Chris Mason's debug prompts). The prompt I use=
d
> > > > for this run is:
> > >
> > > Well, I guess it's time to send a revert patch then.
> >
> > Thanks for the CC.
> >
> > Let's fix it right in the IPMI driver.
> >
> > >
> > > > "
> > > > The top commit in the linux/ directory results in hung tasks if the=
 BMC
> > > > stops responding. Using @review-prompts/kernel/debugging.md analyze=
 the
> > > > patch, identify the reason for the hung task problem, suggest and i=
mplement
> > > > a fix. Note that there may be more than one problem in the patch, s=
o analyze
> > > > the complete patch and do not stop after fiding the first regressio=
n.
> > > > "
> > > >
> > > > I think that catches most of the problem, but not all of it.
> > > >
> > > > Guenter
> > > >
> > > > ---
> > > >
> > > > Summary of crash or warning:
> > > > Hung task detected in ipmi_si driver when BMC becomes non-functiona=
l.
> > > > Processes waiting for IPMI responses (e.g. ipmitool, monitoring age=
nts) enter D state and never recover.
> > > >
> > > > Kernel version if available:
> > > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > > >
> > > > Machine type if available:
> > > > Generic Server with BMC
> > > >
> > > > Cleaned up copy of oops or stack trace:
> > > > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 s=
econds.
> > > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
> > > > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 p=
pid:  100 flags:0x00000000
> > > > [  120.123460] Call Trace:
> > > > [  120.123461]  <TASK>
> > > > [  120.123462]  __schedule+0x123/0x456
> > > > [  120.123463]  schedule+0x45/0x78
> > > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > > [  120.123467]  ...
> > > > [  120.123468]  </TASK>
> > > >
> > > > Any other kernel messages you found relevant:
> > > > N/A
> > > >
> > > > Explanation of the problem:
> > > > 1. Hung Task:
> > > > The patch "ipmi:si: Gracefully handle if the BMC is non-functional"=
 introduces a new state `SI_HOSED` to handle BMC failures. When the driver =
detects that the BMC is not responding, it transitions to `SI_HOSED` and fa=
ils the currently processing message (`curr_msg`). However, if a new messag=
e is queued via `sender()` (populating `waiting_msg`) during a recovery pro=
be (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state=
 machine transitions back to `SI_HOSED`. In this transition, the driver che=
cks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. A=
s a result, the `waiting_msg` remains in the queue indefinitely, causing th=
e waiting process to hang.
> > >
> > > That's quite convincing and it would explain the observed symptoms.
> >
> > Yes, and it's a fairly easy fix, I think.  The waiting message just
> > needs to be returned in that case.  The following patch should do it:
>
> Jaroslav, it would be good to test the patch below on top of 6.19.  I
> can put it on a test git branch if need be, so please let me know.
>
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_=
si_intf.c
> > index 5459ffdde8dc..ff159b1162b9 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struct =
smi_info *smi_info,
> >                          */
> >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> >                 }
> > +               if (smi_info->waiting_msg !=3D NULL) {
> > +                       /* Also handle if there was a message waiting. =
*/
> > +                       smi_info->curr_msg =3D smi_info->waiting_msg;
> > +                       smi_info->waiting_msg =3D NULL;
> > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > +               }
> >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
> >                 goto out;
> >         }

I apply ^ patch to both 6.18.10 and 6.19 and reproduced the issue on
both, so it does not fix the problem.

