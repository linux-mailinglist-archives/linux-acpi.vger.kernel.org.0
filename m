Return-Path: <linux-acpi+bounces-20874-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJG/IpochWkO8gMAu9opvQ
	(envelope-from <linux-acpi+bounces-20874-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 23:41:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC873F82BD
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 23:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA563004205
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AB3358B0;
	Thu,  5 Feb 2026 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neJMixHJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A526AF4
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331278; cv=none; b=KJBiw3IZ0jTKOqb3g3vQGqyIVyIERfTwWuRCqKzo9sYmcBSRVd++KmtoThQQ3ILoLJQDu/ReVoCGm98qz51EKgjWKvAFoqPq0hMwDJIsdCburdB8EI64y66DDfVxnwSWBWm1Da+l5ypzYVXHaCdj3OcAX5WVO3O464YWxvVjhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331278; c=relaxed/simple;
	bh=Juj1bsdRU0I+IrAom3HInXgDgXdJO/+1D0a5t61HPPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cthbOinSXZUOj38pQCLAiRqe5DPGGflV08+gG59lEBLePjA9vxLcMZQo4rH84wtXkX0RaYeNJ+vNOXVPfuJsfKAQvj4NB4Dil7e9Nk7HhDEO1BHg14M6PRwHLFaPBi3kqdSnvY9KFWlT6lmfJfhseok63WS3giup6mm94lHsCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neJMixHJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ca01dc7d40so149555885a.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770331277; x=1770936077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSUkyn5i2wEO3zAje7Mo7JuGzOwqmCv+J4WE0D+9tcU=;
        b=neJMixHJQBlDQkrbq7u+XcHURhEuvuKpyLKJ65Isz2pR4vkNLhJ9FoWRbCHxPicupz
         hHskvm9OqAt6fJK7UhKqSyXpzK1LhRDKcZPO7utvCGtzA9fMOrJfaxhLhLYzNoQ0+YUy
         FRifW3vyf4x6i4saMAvTryw305SpryBGesP/8lVYHtRlqn/DztNT/KGbv1XxyEdxJj4o
         1WoKhat0+TXBS93LVqNEHaVMsHarw8SBvCL8/dZDTshVGmPamz2kOQZjC4A4lfBomWlH
         FzFe571+XgHawosDi1KByNPhA+u4K7cqkH6gOrkaK7fU67MY8yC2Uh/xrPwy8cD66vt8
         aTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331277; x=1770936077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSUkyn5i2wEO3zAje7Mo7JuGzOwqmCv+J4WE0D+9tcU=;
        b=sIgsqOsFzdU+TC7f53t+a/lppgh9YWBQDWL5k9OsY8OCUpbOXkfxeMlBMvLtBGxnx9
         GfXJuctKIk4d4dkVssG7lqyeBUMQtV4hXW5fHjGwor+f9kkcs1dHk77I0Xha/dPc9F+P
         z6NqxgP5P+SY73c5q/ZW0nzyYn+liXvhtvdmPi59y+52i3PJrvkrqNTTbGXeU7AbyshU
         TEsrJcSxqmUZrVIhIo0GTLycNxVuF8YV/FKxjfU6pdgsUcUTxY0MNoXigHJU6lxdqHe2
         xh5q8oAEjpOzUT8IBh1t22+/1vjfoT6ny1hP4X5NwrLBZfR5m86v+Bbyx48TUXKjd8Ss
         HIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXFhmEXECKUriG46WpvpSdw4eouPcwxpPLcKDlBYqo9+9LxSJ8HGTGESMfOUGMh/NTijlaowFTmc5bF@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrDFA8u6PCoi2znWVA//6Az/cyuCaUqUH0PCHMr5EvVZqemlB
	m1dfHSrRM10+rwnzdhJwQBT+F9mG0JtFrRE+cfvrqiv/+gPxGYdGbZYRXfTOTfLY
X-Gm-Gg: AZuq6aL3vwH13W+R9pabo25d1qWmuEXHg4+gbKpsWzZA8n0tCh39Vme6cXQJVenxXX5
	nycqi52JP24o9jAusLCCGwxRAumFldFPLmA7tAb5GX4CWWRb7bVeGBv7H2APK4hlJdDt7EiUoWd
	HupHSEBi9smUWrcxC3JahIREbw7i2kLcgAI5iojb4f8LLl2hVKAmhoNYJb3JwT5UgLIp+dcgnEw
	04gpWhp7VovETGMIFxERxXeajX3E7xo31WrAoGcXqyyFOLH3h5ood1w54JQnEm7QhyiVLM6J/vj
	OmOQcW0hzwGw8q6fT3xPWngOwAwur2x4bUJerFDYs51+ZykDJwD1rqhwN85YFAbSu4+gcS2lHON
	4AnGJlGYuk2+YKf6ng/Yte6unqDe9kRmz7C/fAgV47xF+7C2YLIOpM1784EgpOa7+k8mdAgoNzK
	nrZ3/oxk/ZXcT5J0OH8EMcBjvO
X-Received: by 2002:a05:7022:b9b:b0:11b:9386:8271 with SMTP id a92af1059eb24-1270407446dmr233143c88.46.1770325047565;
        Thu, 05 Feb 2026 12:57:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270414f28bsm360512c88.0.2026.02.05.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:57:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Feb 2026 12:57:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Igor Raits <igor@gooddata.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average
 sysfs read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
Message-ID: <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
References: <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
 <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
 <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net>
 <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20874-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: DC873F82BD
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> Cc: Corey
> 
> On Thu, Feb 5, 2026 at 6:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > On Wed, Feb 4, 2026 at 11:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > I have written a patch with the help of AI and it fixes the problem. Attached.
> > > > >
> > > >
> > > > "No MIME, no links, no compression, no attachments.  Just plain text"
> > >
> > > Sorry for that, I had assumed that attaching the file would make it in-line.
> > >
> > > > ... which means I can not provide inline feedback, which is the whole
> > > > point of the above.
> > > >
> > > > Your patch crosses subsystems, so it will need to be split in two
> > > > (assuming the ACPI side is even needed). Also, references to iDRAC
> > > > in common code seem inappropriate.
> > >
> > > Yes, this I believe was the essential part (it was the last piece in
> > > my testing which fixed the hanging):
> > >
> >
> > Then I'll need to ask differently: What happens if you drop the IPMI code,
> > and just keep the wait_for_completion -> wait_for_completion_timeout
> > change ? Would that be sufficient to solve the problem ?
> 
> I'd rather say "Would that be sufficient to make the symptoms go
> away?" as it most likely papers over the real problem.
> 

Good point. Worse, it may result in UAF or memory leaks.

> > Either case, the need for this change suggests that the ipmi change
> > may not be complete, since it should send a completion with an error.
> 
> I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> handle if the BMC is non-functional") should also be considered as a
> possible way forward because it clearly did not improve things as
> expected, at least in this particular case.
> 

I tend to agree. I ran a number of AI code reviews over the patch, and
each time it finds new (and different) problems. The fact that the acpi
patch is still needed even after applying the ipmi changes suggests that
something is still missing in the ipmi code.

> It evidently did something that confuses things quite a bit.  Either
> it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it is
> the "hosed" state and refusing to accept messages.
> 

More than that. My latest AI results are below, just for reference
(using Gemini 3 with Chris Mason's debug prompts). The prompt I used
for this run is:

"
The top commit in the linux/ directory results in hung tasks if the BMC
stops responding. Using @review-prompts/kernel/debugging.md analyze the
patch, identify the reason for the hung task problem, suggest and implement
a fix. Note that there may be more than one problem in the patch, so analyze
the complete patch and do not stop after fiding the first regression.
"

I think that catches most of the problem, but not all of it.

Guenter

---

Summary of crash or warning:
Hung task detected in ipmi_si driver when BMC becomes non-functional.
Processes waiting for IPMI responses (e.g. ipmitool, monitoring agents) enter D state and never recover.

Kernel version if available:
Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)

Machine type if available:
Generic Server with BMC

Cleaned up copy of oops or stack trace:
[  120.123456] INFO: task ipmitool:1234 blocked for more than 120 seconds.
[  120.123457]       Not tainted 6.14.0-rc1 #1
[  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppid:  100 flags:0x00000000
[  120.123460] Call Trace:
[  120.123461]  <TASK>
[  120.123462]  __schedule+0x123/0x456
[  120.123463]  schedule+0x45/0x78
[  120.123464]  schedule_timeout+0x9a/0xbc
[  120.123465]  wait_for_completion+0xde/0xf0
[  120.123466]  ipmi_request_settime+0x123/0x145
[  120.123467]  ...
[  120.123468]  </TASK>

Any other kernel messages you found relevant:
N/A

Explanation of the problem:
1. Hung Task:
The patch "ipmi:si: Gracefully handle if the BMC is non-functional" introduces a new state `SI_HOSED` to handle BMC failures. When the driver detects that the BMC is not responding, it transitions to `SI_HOSED` and fails the currently processing message (`curr_msg`). However, if a new message is queued via `sender()` (populating `waiting_msg`) during a recovery probe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state machine transitions back to `SI_HOSED`. In this transition, the driver checks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As a result, the `waiting_msg` remains in the queue indefinitely, causing the waiting process to hang.

2. Excessive Polling (Timer Overwrite):
In `smi_timeout()`, the timer is unconditionally reset to a short timeout (e.g., 10ms) at the end of the function, unless the state machine is IDLE. When the state machine returns `SI_SM_HOSED`, `smi_event_handler()` correctly sets the timer to a long backoff (1 second). However, `smi_timeout()` subsequently overwrites this with the short timeout. This causes the driver to poll the hosed BMC every 10ms instead of backing off for 1 second, resulting in unnecessary CPU overhead.

Functions, snippets and call traces of code related to the problem:

drivers/char/ipmi/ipmi_si_intf.c: smi_event_handler()

	} else if (si_sm_result == SI_SM_HOSED) {
		/* ... */
		smi_info->si_state = SI_HOSED;
		if (smi_info->curr_msg != NULL) {
			return_hosed_msg(smi_info, IPMI_BUS_ERR);
		}
		/* BUG 1: waiting_msg is NOT checked here! */

		smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED); /* Sets 1s timeout */
		goto out;
	}

drivers/char/ipmi/ipmi_si_intf.c: smi_timeout()

	smi_result = smi_event_handler(smi_info, time_diff);
	/* ... */
	if (smi_result != SI_SM_IDLE)
		smi_mod_timer(smi_info, timeout); /* BUG 2: Overwrites 1s timeout with ~10ms */

List of potential commits related to the problem:
bc3a9d217755f65c137f145600f23bf1d6c31ea9 ipmi:si: Gracefully handle if the BMC is non-functional

Suggested fix:
1. When entering `SI_HOSED` state in `smi_event_handler`, check for and fail any pending `waiting_msg` in addition to `curr_msg`.
2. In `smi_timeout`, do not reset the timer if the state is `SI_HOSED`, preserving the backoff timeout set by `smi_event_handler`.

---
Suggested diffs from that run:

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 1c65275906b4..023b0e819f91 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -810,6 +810,11 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
 			 */
 			return_hosed_msg(smi_info, IPMI_BUS_ERR);
 		}
+		if (smi_info->waiting_msg != NULL) {
+			smi_info->curr_msg = smi_info->waiting_msg;
+			smi_info->waiting_msg = NULL;
+			return_hosed_msg(smi_info, IPMI_BUS_ERR);
+		}
 		smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
 		goto out;
 	}
@@ -1130,10 +1135,12 @@ static void smi_timeout(struct timer_list *t)
 		timeout = jiffies + SI_TIMEOUT_JIFFIES;
 	}
 
-	if (smi_result != SI_SM_IDLE)
-		smi_mod_timer(smi_info, timeout);
-	else
+	if (smi_result != SI_SM_IDLE) {
+		if (smi_info->si_state != SI_HOSED)
+			smi_mod_timer(smi_info, timeout);
+	} else {
 		smi_info->timer_running = false;
+	}
 	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 }
 


