Return-Path: <linux-acpi+bounces-20888-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP9iEz0Qhmk1JgQAu9opvQ
	(envelope-from <linux-acpi+bounces-20888-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:01:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AEFFF96
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A394A30416D9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31E2E8DE5;
	Fri,  6 Feb 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="PPC5rNS7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BF2E7BD2
	for <linux-acpi@vger.kernel.org>; Fri,  6 Feb 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393506; cv=none; b=J4gqFF/PJ1lz5iGz01R2RpA7K+nSDJ/8ePWUtL2PuhHC3Eye7P0iskz6iUugR2TOaD/+giuMZtRpdtzFDmQW78i8TUHe9tcN2r8Pnx+M4oekn9gqVtNn4hXFP5qVQ8Nn51uns6OaprFboSeTsd1wDVzvuETdutxEGMuuGAZWSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393506; c=relaxed/simple;
	bh=k43UdQ9Re1TzNFIkJqfnQF93crpnlpYPjCvi4ztDVrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFszPt5hqBGB/8JnelKIm7Wyapx9hpKyzAaMUhcPX3LWsWtpba5WRZ3Sprih2VPpl0rZPPSLksDnUjfx+DjoaltCwGyvUNjM0EQDPAdBWlCmbcs7k4UyrBrQaLWNeg9rJa5+GB/FvvSeD97JseNnYipiIrn2nazU+FZUbe5Omc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=PPC5rNS7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d195166b2cso1728366a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2026 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770393505; x=1770998305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjbSJlcsw5yIkoZdZ3xPdlH3uqkpByDwo5mEd4lWTgY=;
        b=PPC5rNS7G0aachJPV0y9pgW0Iqccy1WPlAwFNEuDkiAAR+NNeVtCaHsIX8QDXtw7vS
         TBou0ia9mQq4xhbWamNlD2SXfeI5a38Jd94bF8ICcf84UmAdMf6dr4w5Ut5bzz8/daYF
         yDS84bnDAtooIHL38Djetkmp4NTRLF0OuIF/G58QmN0R1mYOf8NHCtl8ONLk+iZLXFIu
         olqiv11ogIL4COQ/RqH+mjYIg7cd075qVvoZqODe4TnhPQNA1mR9ki1rUqtzK5TV9d23
         l+HJuNNNLJnjHYQprmxpQP1snibOPD/PUtne/6XmivWIjOKTuERlRnwoX96lvEQD7NNR
         Cxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393505; x=1770998305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjbSJlcsw5yIkoZdZ3xPdlH3uqkpByDwo5mEd4lWTgY=;
        b=RLEMCDX3FAj1aKqiOMKxD/9ictL6SKeJtUFqYzGgFBw2tVE6Qqd8uU5Jke143HCRVg
         gXol12z1tY8Fjg13FlTCILBJ912JvuWF0t/sdTAWAxZm/h5F1LQ5q0ndmyDI506HHySj
         NpARD6K3Y8qfKuKxuRsxcqx9mpAmpkov+BL+9TyUupdGJcIIfVukGw0JKQOY24euFdLu
         qOJXUAo96Lkqws3rEiJkQFpYPgS/4vWqRzL2b92qecjOmbItDOH+PCye3WYN2f+27VL1
         7JpZUayleMzSRUd/MX8IbozYinTxyuSefaJSEM9ksIrC0TXI9EyI2vsFTylOZNjCMKR8
         V8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPqkTlQOUrMdfOPKspaVZKMuT5q4hN8cCWhXUKrBEOTic1w9p9ZeYnoPe5tGyJZFvTBUsGH4aw+VU@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPdMqoSY914p+uOz+BAgGLciMfzCgEQlMWOxpUQJQGLlORHyq
	2uQG2Y+uhP5mkg2JFCHNnUCgiFHCubV5ejUYB1OoWp0q7RW2nipEgEUiXAh5A3iUIFE=
X-Gm-Gg: AZuq6aKASvELx+auSZ2ArVIXWQwhTlG/U1ZnEI0mgWZp8lvyw7v5KZqyY94EG/0ImdW
	4jR96dY/kuYCEBM3DMs+SSJy3NSbZXUJwAEZ1LpqFa2cpEZ5E/UQwDQBan8OEFiqtR09RV/l9pR
	I5ho7oQ3FHDQbmgio6lOTYi/CQKLeh8fy588MeDJEEIDjDKtBK6i1PY4ispRmhl8u+azHAxY/tM
	QgXgoH3gNw/yIGwanEqgDv1IEp3GL58HZKHb2kYrnpYc+bUT3qgMR13tikwhCisxrGv2TZOjXlw
	WeeDHdI7lxOiA9Wmsp1qcK22tmf9eHmPbJT7R7MadIrxtJCMzdgopjsKLlSr4ki9jvrWaEpCFUJ
	uaXC3Z4kISrcWRjVHcGMJ+N2dLu/Upfl4XadfoohNoC4id6Zw0pJBis/aTT7GcPZS25UNoQiK+J
	+PVQsGWvvgA0rxkAfsZBZgqSaj/oL0R6E81FNpDxYktPDicO0zBUIfcCf1OGQgDS7UULkNrws+7
	3zgoQzAvfQ08A==
X-Received: by 2002:a05:6830:268c:b0:7cf:e4e6:2ce9 with SMTP id 46e09a7af769-7d46440ace6mr1396357a34.9.1770393504747;
        Fri, 06 Feb 2026 07:58:24 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:aed7:ea82:7abb:dd28])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470df08sm1947716a34.8.2026.02.06.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:58:24 -0800 (PST)
Date: Fri, 6 Feb 2026 09:58:20 -0600
From: Corey Minyard <corey@minyard.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average
 sysfs read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
Message-ID: <aYYPnATz1JakV3m7@mail.minyard.net>
Reply-To: corey@minyard.net
References: <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
 <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
 <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net>
 <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
 <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20888-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.minyard.net:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 9F2AEFFF96
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 5, 2026 at 11:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > > Cc: Corey
> > >
> > > On Thu, Feb 5, 2026 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > On Wed, Feb 4, 2026 at 11:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > >
> > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > I have written a patch with the help of AI and it fixes the problem. Attached.
> > > > > > >
> > > > > >
> > > > > > "No MIME, no links, no compression, no attachments.  Just plain text"
> > > > >
> > > > > Sorry for that, I had assumed that attaching the file would make it in-line.
> > > > >
> > > > > > ... which means I can not provide inline feedback, which is the whole
> > > > > > point of the above.
> > > > > >
> > > > > > Your patch crosses subsystems, so it will need to be split in two
> > > > > > (assuming the ACPI side is even needed). Also, references to iDRAC
> > > > > > in common code seem inappropriate.
> > > > >
> > > > > Yes, this I believe was the essential part (it was the last piece in
> > > > > my testing which fixed the hanging):
> > > > >
> > > >
> > > > Then I'll need to ask differently: What happens if you drop the IPMI code,
> > > > and just keep the wait_for_completion -> wait_for_completion_timeout
> > > > change ? Would that be sufficient to solve the problem ?
> > >
> > > I'd rather say "Would that be sufficient to make the symptoms go
> > > away?" as it most likely papers over the real problem.
> > >
> >
> > Good point. Worse, it may result in UAF or memory leaks.
> >
> > > > Either case, the need for this change suggests that the ipmi change
> > > > may not be complete, since it should send a completion with an error.
> > >
> > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > > handle if the BMC is non-functional") should also be considered as a
> > > possible way forward because it clearly did not improve things as
> > > expected, at least in this particular case.
> > >
> >
> > I tend to agree. I ran a number of AI code reviews over the patch, and
> > each time it finds new (and different) problems. The fact that the acpi
> > patch is still needed even after applying the ipmi changes suggests that
> > something is still missing in the ipmi code.
> >
> > > It evidently did something that confuses things quite a bit.  Either
> > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it is
> > > the "hosed" state and refusing to accept messages.
> > >
> >
> > More than that. My latest AI results are below, just for reference
> > (using Gemini 3 with Chris Mason's debug prompts). The prompt I used
> > for this run is:
> 
> Well, I guess it's time to send a revert patch then.

Thanks for the CC.

Let's fix it right in the IPMI driver.

> 
> > "
> > The top commit in the linux/ directory results in hung tasks if the BMC
> > stops responding. Using @review-prompts/kernel/debugging.md analyze the
> > patch, identify the reason for the hung task problem, suggest and implement
> > a fix. Note that there may be more than one problem in the patch, so analyze
> > the complete patch and do not stop after fiding the first regression.
> > "
> >
> > I think that catches most of the problem, but not all of it.
> >
> > Guenter
> >
> > ---
> >
> > Summary of crash or warning:
> > Hung task detected in ipmi_si driver when BMC becomes non-functional.
> > Processes waiting for IPMI responses (e.g. ipmitool, monitoring agents) enter D state and never recover.
> >
> > Kernel version if available:
> > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> >
> > Machine type if available:
> > Generic Server with BMC
> >
> > Cleaned up copy of oops or stack trace:
> > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 seconds.
> > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppid:  100 flags:0x00000000
> > [  120.123460] Call Trace:
> > [  120.123461]  <TASK>
> > [  120.123462]  __schedule+0x123/0x456
> > [  120.123463]  schedule+0x45/0x78
> > [  120.123464]  schedule_timeout+0x9a/0xbc
> > [  120.123465]  wait_for_completion+0xde/0xf0
> > [  120.123466]  ipmi_request_settime+0x123/0x145
> > [  120.123467]  ...
> > [  120.123468]  </TASK>
> >
> > Any other kernel messages you found relevant:
> > N/A
> >
> > Explanation of the problem:
> > 1. Hung Task:
> > The patch "ipmi:si: Gracefully handle if the BMC is non-functional" introduces a new state `SI_HOSED` to handle BMC failures. When the driver detects that the BMC is not responding, it transitions to `SI_HOSED` and fails the currently processing message (`curr_msg`). However, if a new message is queued via `sender()` (populating `waiting_msg`) during a recovery probe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state machine transitions back to `SI_HOSED`. In this transition, the driver checks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As a result, the `waiting_msg` remains in the queue indefinitely, causing the waiting process to hang.
> 
> That's quite convincing and it would explain the observed symptoms.

Yes, and it's a fairly easy fix, I think.  The waiting message just
needs to be returned in that case.  The following patch should do it:

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 5459ffdde8dc..ff159b1162b9 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
                         */
                        return_hosed_msg(smi_info, IPMI_BUS_ERR);
                }
+               if (smi_info->waiting_msg != NULL) {
+                       /* Also handle if there was a message waiting. */
+                       smi_info->curr_msg = smi_info->waiting_msg;
+                       smi_info->waiting_msg = NULL;
+                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
+               }
                smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
                goto out;
        }


Thanks,

-corey

> 
> > 2. Excessive Polling (Timer Overwrite):
> > In `smi_timeout()`, the timer is unconditionally reset to a short timeout (e.g., 10ms) at the end of the function, unless the state machine is IDLE. When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` correctly sets the timer to a long backoff (1 second). However, `smi_timeout()` subsequently overwrites this with the short timeout. This causes the driver to poll the hosed BMC every 10ms instead of backing off for 1 second, resulting in unnecessary CPU overhead.
> 
> Well, that's not nice, but it doesn't seem to be related to the
> observed symptoms.
> 
> > Functions, snippets and call traces of code related to the problem:
> >
> > drivers/char/ipmi/ipmi_si_intf.c: smi_event_handler()
> >
> >         } else if (si_sm_result == SI_SM_HOSED) {
> >                 /* ... */
> >                 smi_info->si_state = SI_HOSED;
> >                 if (smi_info->curr_msg != NULL) {
> >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> >                 }
> >                 /* BUG 1: waiting_msg is NOT checked here! */
> >
> >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED); /* Sets 1s timeout */
> >                 goto out;
> >         }
> >
> > drivers/char/ipmi/ipmi_si_intf.c: smi_timeout()
> >
> >         smi_result = smi_event_handler(smi_info, time_diff);
> >         /* ... */
> >         if (smi_result != SI_SM_IDLE)
> >                 smi_mod_timer(smi_info, timeout); /* BUG 2: Overwrites 1s timeout with ~10ms */
> >
> > List of potential commits related to the problem:
> > bc3a9d217755f65c137f145600f23bf1d6c31ea9 ipmi:si: Gracefully handle if the BMC is non-functional
> >
> > Suggested fix:
> > 1. When entering `SI_HOSED` state in `smi_event_handler`, check for and fail any pending `waiting_msg` in addition to `curr_msg`.
> > 2. In `smi_timeout`, do not reset the timer if the state is `SI_HOSED`, preserving the backoff timeout set by `smi_event_handler`.
> >
> > ---
> > Suggested diffs from that run:
> >
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > index 1c65275906b4..023b0e819f91 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -810,6 +810,11 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
> >                          */
> >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> >                 }
> > +               if (smi_info->waiting_msg != NULL) {
> > +                       smi_info->curr_msg = smi_info->waiting_msg;
> > +                       smi_info->waiting_msg = NULL;
> > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > +               }
> >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
> >                 goto out;
> >         }
> > @@ -1130,10 +1135,12 @@ static void smi_timeout(struct timer_list *t)
> >                 timeout = jiffies + SI_TIMEOUT_JIFFIES;
> >         }
> >
> > -       if (smi_result != SI_SM_IDLE)
> > -               smi_mod_timer(smi_info, timeout);
> > -       else
> > +       if (smi_result != SI_SM_IDLE) {
> > +               if (smi_info->si_state != SI_HOSED)
> > +                       smi_mod_timer(smi_info, timeout);
> > +       } else {
> >                 smi_info->timer_running = false;
> > +       }
> >         spin_unlock_irqrestore(&(smi_info->si_lock), flags);
> >  }
> 
> Well, I'd leave fixing the IPMI handling to somebody familiar with that code.

