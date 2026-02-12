Return-Path: <linux-acpi+bounces-20959-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK2hHb0Ejmlf+gAAu9opvQ
	(envelope-from <linux-acpi+bounces-20959-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 17:50:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12E12FA14
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9F430465DD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17335EDD8;
	Thu, 12 Feb 2026 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="MzU6Wr6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8235D60A
	for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914914; cv=none; b=OgvFmaEfIGiBctMSHBaLAVw1Wg5bupyzRp6sJOryV2kY4RIUoSMZOy56F0QHfkeNhXsy5aD57GofKDN5v0f8cngw/lzu/YWST6+Kpjz/CrIUBq/A4tU8RNkVCtDFXHFjAKY+iJXpHd315Ht+a1Qao5nLyW/Cds6JlFNcA08ZANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914914; c=relaxed/simple;
	bh=fSGXWgA+Z1t6lnNjSGb1mftfwvAM5akuIgPQNji/YNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzFZfaf405OcTEbM2xHxRxBY1Tozc2pRlgrWuVKvP/Rng/cBhkSZ7sq/sJW67RxTAV272p3WAT7qcT3W3J3w8j0ytU4fzZIBL2eCZzLnmlFRITzJZ6sdyrey+zvNtVMXCokIpfNIHR8b7p+WCx5aCEiyaAWM6dE9K1pWI43Thro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=MzU6Wr6y; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso125059a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770914902; x=1771519702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dblFMZ/gezfx71l1wXao3YQdpcVcwtxvd9rM0uvxXFA=;
        b=MzU6Wr6yHL5KMeWrTckg41TBrlGIUznOUQUhSF1wOi2jaqweRf/3fn40/2z+3VR18B
         E+0mScgKC5SO6WbfzrTSEBq/Y4zUzpv9qws5NVlLbnhPcUwQ1dZaD6arBZR1hMrhZxYB
         VI1ND41GvlijyNlb4kYp20uTO5qRSJk/fgmmzJuvmZ5oJsuslH2x+wDp63avKl/hrlqn
         C3ptoCvRh2PD94UKGLR7wLK2HiVqnlZyLiIxWa1a1Jly4sDyPlRhNXdcEJkwrYfT0z1L
         AqwObrgoQys3VNP0T/JTbvQtcv/KZNPjr7AGeThtZzWiHH6lJ0QA6GxzILk5wDkC/kqf
         YjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914902; x=1771519702;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dblFMZ/gezfx71l1wXao3YQdpcVcwtxvd9rM0uvxXFA=;
        b=RfE0T89CKpMwYvOgwNvPGgwsssYSQPRKvBzW2Wot7oCdnODLugD6x+Ju5TadPQdWMQ
         6r7KbC7zc4VNvSndxEmVoKeniB6DYs2rFC+KT6qpPGM3lHWCMA1SR7g0Zx1E73G0F1TS
         iQAeXslpVQBssGOSdgWtAtiD3jU1IYrVEE2w3m6yVa/+V/AEJ/SX7YxCTwRDxA4EHtVQ
         0y2VwZQniOijS8CEQ/FGolflvkmcXzDPFq1h06CcVFFyO5HqEijEALgLzSihYX7XRhvm
         pKS7VJ+YvNppxj5EwpX8OizzlOtJOgHNG9nGrwlsKZ/aGG37PezwVyeru6EvnDzGLbkJ
         gb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUku52jLtQEoJiBWdnKsVYorXXA0RfZsZO4lRNLT5OpWN3x6UsDqOgvVt7opGtqlGfExapUIk9L3gdi@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAuE+lOx3I/x1vo6IuOk0bF1lD4diSiEis8oH9RrsGwqLsKcI
	53QyruFfpSpRazPMwBs6IKg4om6XPlPzdQmQgFJOog4FbiKh/mdiVrQPi84qMirflJY=
X-Gm-Gg: AZuq6aL1HubV2hxCyb7PBG/p2i/ThaIJ/wH2+MNdjgTj0hpeipmpsx2R+9jaP665mG5
	0qWsCS8j9PKYpjKgrW1dTOTKyN7GzjwnrplecJ33/J/w4Fgib/JS5OpYFEwyrnCNfZAZSE8lG6z
	r9gugTcZAZeGWBNMNu1uSyIy/UurlgZQlf28Zd4hr7JKY6PHngshorbbdyBvj6I19a6HZ1lv1uF
	GTNZAE0y54FxUiW26uRlToQC0Y9+BoTszTUWqVaesdBy6QtEXoEyD+GqiEsPcqnJCDSImbNN+Ie
	buHElCO7wOGfRSD7uaLe/gPYBUAgnjkk6XgymfMpjO2h1mnWFZVttahm24rDRtrpd2aqxRQxoVp
	ppOyefequwtjpGN0ID8hLHUfIWltVOHk4vDtpgRe4rE9azw0CfxG9MEiyAha0a6oc2wYHDV5YqZ
	5ehhlyYPbG4HYxvea7CGT+cLz9lKXxcx2YcNHs5TgsGPnlPX+ljMu25lOgS2LdClSv0UXo1icsF
	c5H1rkyxsyl7QLGZxoNHsco4g==
X-Received: by 2002:a05:6830:2549:b0:7cf:d0f3:4610 with SMTP id 46e09a7af769-7d4b2abac1emr1481745a34.28.1770914902099;
        Thu, 12 Feb 2026 08:48:22 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ac4f:9c7a:97e9:f745])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a754a764sm3965188a34.10.2026.02.12.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 08:48:21 -0800 (PST)
Date: Thu, 12 Feb 2026 10:48:17 -0600
From: Corey Minyard <corey@minyard.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [BISECTED - impi related]: acpi_power_meter: power*_average
 sysfs read hangs, mutex deadlock in hwmon_attr_show since v6.18.y
Message-ID: <aY4EUQcGbmT3Rexz@mail.minyard.net>
Reply-To: corey@minyard.net
References: <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
 <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
 <39100538-a1f3-48dc-82d6-5e3314a43b4d@roeck-us.net>
 <CAJZ5v0jo4CV__AoUfqxuhVgkw6hA=hM_fBU+W=pTzqDLmNmytw@mail.gmail.com>
 <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
 <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYPnATz1JakV3m7@mail.minyard.net>
 <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
 <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
 <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20959-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:replyto,minyard.net:dkim,minyard.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 8B12E12FA14
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:27:41PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 12, 2026 at 10:11???AM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
> >
> > >
> > > On Fri, Feb 6, 2026 at 4:58???PM Corey Minyard <corey@minyard.net> wrote:
> > > >
> > > > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Feb 5, 2026 at 11:34???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > >
> > > > > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > > > > > > Cc: Corey
> > > > > > >
> > > > > > > On Thu, Feb 5, 2026 at 6:51???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > >
> > > > > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > > > > > On Wed, Feb 4, 2026 at 11:49???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > >
> > > > > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > > > > I have written a patch with the help of AI and it fixes the problem. Attached.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > "No MIME, no links, no compression, no attachments.  Just plain text"
> > > > > > > > >
> > > > > > > > > Sorry for that, I had assumed that attaching the file would make it in-line.
> > > > > > > > >
> > > > > > > > > > ... which means I can not provide inline feedback, which is the whole
> > > > > > > > > > point of the above.
> > > > > > > > > >
> > > > > > > > > > Your patch crosses subsystems, so it will need to be split in two
> > > > > > > > > > (assuming the ACPI side is even needed). Also, references to iDRAC
> > > > > > > > > > in common code seem inappropriate.
> > > > > > > > >
> > > > > > > > > Yes, this I believe was the essential part (it was the last piece in
> > > > > > > > > my testing which fixed the hanging):
> > > > > > > > >
> > > > > > > >
> > > > > > > > Then I'll need to ask differently: What happens if you drop the IPMI code,
> > > > > > > > and just keep the wait_for_completion -> wait_for_completion_timeout
> > > > > > > > change ? Would that be sufficient to solve the problem ?
> > > > > > >
> > > > > > > I'd rather say "Would that be sufficient to make the symptoms go
> > > > > > > away?" as it most likely papers over the real problem.
> > > > > > >
> > > > > >
> > > > > > Good point. Worse, it may result in UAF or memory leaks.
> > > > > >
> > > > > > > > Either case, the need for this change suggests that the ipmi change
> > > > > > > > may not be complete, since it should send a completion with an error.
> > > > > > >
> > > > > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > > > > > > handle if the BMC is non-functional") should also be considered as a
> > > > > > > possible way forward because it clearly did not improve things as
> > > > > > > expected, at least in this particular case.
> > > > > > >
> > > > > >
> > > > > > I tend to agree. I ran a number of AI code reviews over the patch, and
> > > > > > each time it finds new (and different) problems. The fact that the acpi
> > > > > > patch is still needed even after applying the ipmi changes suggests that
> > > > > > something is still missing in the ipmi code.
> > > > > >
> > > > > > > It evidently did something that confuses things quite a bit.  Either
> > > > > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it is
> > > > > > > the "hosed" state and refusing to accept messages.
> > > > > > >
> > > > > >
> > > > > > More than that. My latest AI results are below, just for reference
> > > > > > (using Gemini 3 with Chris Mason's debug prompts). The prompt I used
> > > > > > for this run is:
> > > > >
> > > > > Well, I guess it's time to send a revert patch then.
> > > >
> > > > Thanks for the CC.
> > > >
> > > > Let's fix it right in the IPMI driver.
> > > >
> > > > >
> > > > > > "
> > > > > > The top commit in the linux/ directory results in hung tasks if the BMC
> > > > > > stops responding. Using @review-prompts/kernel/debugging.md analyze the
> > > > > > patch, identify the reason for the hung task problem, suggest and implement
> > > > > > a fix. Note that there may be more than one problem in the patch, so analyze
> > > > > > the complete patch and do not stop after fiding the first regression.
> > > > > > "
> > > > > >
> > > > > > I think that catches most of the problem, but not all of it.
> > > > > >
> > > > > > Guenter
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > Summary of crash or warning:
> > > > > > Hung task detected in ipmi_si driver when BMC becomes non-functional.
> > > > > > Processes waiting for IPMI responses (e.g. ipmitool, monitoring agents) enter D state and never recover.
> > > > > >
> > > > > > Kernel version if available:
> > > > > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > > > > >
> > > > > > Machine type if available:
> > > > > > Generic Server with BMC
> > > > > >
> > > > > > Cleaned up copy of oops or stack trace:
> > > > > > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 seconds.
> > > > > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > > > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppid:  100 flags:0x00000000
> > > > > > [  120.123460] Call Trace:
> > > > > > [  120.123461]  <TASK>
> > > > > > [  120.123462]  __schedule+0x123/0x456
> > > > > > [  120.123463]  schedule+0x45/0x78
> > > > > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > > > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > > > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > > > > [  120.123467]  ...
> > > > > > [  120.123468]  </TASK>
> > > > > >
> > > > > > Any other kernel messages you found relevant:
> > > > > > N/A
> > > > > >
> > > > > > Explanation of the problem:
> > > > > > 1. Hung Task:
> > > > > > The patch "ipmi:si: Gracefully handle if the BMC is non-functional" introduces a new state `SI_HOSED` to handle BMC failures. When the driver detects that the BMC is not responding, it transitions to `SI_HOSED` and fails the currently processing message (`curr_msg`). However, if a new message is queued via `sender()` (populating `waiting_msg`) during a recovery probe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state machine transitions back to `SI_HOSED`. In this transition, the driver checks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As a result, the `waiting_msg` remains in the queue indefinitely, causing the waiting process to hang.
> > > > >
> > > > > That's quite convincing and it would explain the observed symptoms.
> > > >
> > > > Yes, and it's a fairly easy fix, I think.  The waiting message just
> > > > needs to be returned in that case.  The following patch should do it:
> > >
> > > Jaroslav, it would be good to test the patch below on top of 6.19.  I
> > > can put it on a test git branch if need be, so please let me know.
> > >
> > > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > > index 5459ffdde8dc..ff159b1162b9 100644
> > > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > > @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
> > > >                          */
> > > >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > >                 }
> > > > +               if (smi_info->waiting_msg != NULL) {
> > > > +                       /* Also handle if there was a message waiting. */
> > > > +                       smi_info->curr_msg = smi_info->waiting_msg;
> > > > +                       smi_info->waiting_msg = NULL;
> > > > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > > +               }
> > > >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
> > > >                 goto out;
> > > >         }
> >
> > I apply ^ patch to both 6.18.10 and 6.19 and reproduced the issue on
> > both, so it does not fix the problem.
> 
> Thanks!
> 
> With all due respect to everyone involved (including the AI), this
> means that we are not anywhere close to fixing the problem and it
> would be a shame to ship 7.0 with it.
> 
> I'm sending a revert patch shortly.

Unfortunately, that patch fixed an issue others were having.

I'm going to try to hack on qemu and see if I can reproduce this.  I
don't have any hardware where this is feasible.

-corey

