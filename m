Return-Path: <linux-acpi+bounces-20965-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPR6E+nKjmm/EwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20965-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA6133503
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7191530530C1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4E26FA5A;
	Fri, 13 Feb 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="UCA+qTFV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A1261B8A
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965735; cv=none; b=nKIt4M0r/jCQqwQx5UUyvpFkMlbn6rnpwg1mb4/ix1R/RzEVFHIVok/ZhQcnn/yrlUxTkSwsB1N3C0M4wT7T1WY3PDEzqifgZu7JTNrvvL85dfpy3scG/QDHlDHyJlZIbNQBihqnsIA6t8A3dNBzmKvL49cBbL4cFdGjSTvjuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965735; c=relaxed/simple;
	bh=3f9GZhs53JjFf7w/T46dEHUkViopYFQYeFiwEdCKr0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlhCjbcw4lrHPYXit2dsMablsRRa/SmfAbz8phE/RxXqiWKhRGwZI2o1avsANINMkDSBx5023w1W0y1DK3rw0MJOeGhnDZGnzHBU3av5X/X1LYnkSxkjdWwnyhPhLiJlbW9XuVyYGVZpZdAPbKs8XOs7PxmlC1wo5ZuWoe/7EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=UCA+qTFV; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45efd53148eso221640b6e.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770965731; x=1771570531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4e7jAbKNE4bD+vS1RSy4Qf8lUvN6hPjXtNCjaFIu1w=;
        b=UCA+qTFVBydZgkYJgznMmD1i7xYiaxuqGrR7dIZFt/yvsl4dp3xh7DGO3HSQbiRNIQ
         V65lLe8M63SplU8I0fJoYQ8Ihctffs5OJi9ujtWPe+BcWAhrDffCmpv00tUgDZTs8iN+
         8d5U1nfg940gfv0tTYJJ+RMszQVDW5dXdpZ0BwJ+3VF/mZfI3WrXesGzXjvsQfLjaVVe
         rYPhWewlJLiszp9EyvY/nD4eH5zOsvCyM1esq69rLN8Ik2Hy2zyX7nIjvQajD5BIx6IW
         GkCjtCfKAjPLkHKm2KEtzCe92bDOhKBiHVA7D9l5i19tCvQLyp5dbHKlSOdARtD7GYTW
         7zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965731; x=1771570531;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4e7jAbKNE4bD+vS1RSy4Qf8lUvN6hPjXtNCjaFIu1w=;
        b=rLTOAH1ZaY95/WRydC63xdA0qV/TuvsyPDSvxl8bncnf7ez50m5XB3oFHujTohw2wM
         27mUU6+sEHk/Ogm7WWdwkY5cpE/r7gXPIzCRoW4u3Z1MKcX0pF2qGBxKnb53sIQma6fW
         3o0ulNBYceldmTtDrpGC9i6/6YJmjzgoYwtG33s/Kq8xZuBe7rQVxoh2z2RSegKIongC
         SoHH/X52E53hfMjcrVah3c8/qxC10Qy+9wslPSxmH3Rx1CL8GjFvo5KXixdjIN4BzWD+
         S2oGX8kkUFD/8/Se+6+RwvF3PCG3LAEygCiwUw7JqPRSkYnJtel2QcUDHhk/tT78rNlB
         haFw==
X-Forwarded-Encrypted: i=1; AJvYcCUsesV+aU8a/qRYvn89P+fxLMe8Z9qflwmU6EmIdRdSFeB/zDAz/vBfVJIxD4sHbs+cHHnSzgm2yfe6@vger.kernel.org
X-Gm-Message-State: AOJu0YzJV67ct5p7OpnEeNwJtR5wwS0YMT08lAvHzYTi8MFfPxkEt8Eb
	1zCheI/JlGv8ThFiLAsKqSgA0GADfbYQIceIIx97N7a+dljQEL0MN29cBlGO+GNNRTE=
X-Gm-Gg: AZuq6aLCWrLuc4oU6INJnkl7FQp++pPH8oJHd1dVjn/iqh16JD3744RoNZvqV1tD0Z3
	Slx7PpJrzvvwbJLhAdlgHFv3Y0BUdYU0Yx3qacP9kB9PjxG4LdJRcsFdCliFYpHSpUI54Q5yZO1
	OCpaZgK+CMxMz7AcS3si/mK5JC2zuct2vfZrgewYmfcE40z5PflC43TPtDX7QaMqquZgceA1H6J
	wwdZDwNAoT3PQgoENrRgcRxDJcVPu5Y67YF8DCYgkXDRWagW8cmNNB34py8gFoMqn39eX7uzPCR
	wgQKalJiwPdK1Fh4oZI1n1HGi3OMcLQr6KgoGmVYqkao7Wt/g/BIdpAhzzh49jLtwDfPU5+jJ9w
	LQffd9t70D1GSWdToi+U02Jl8BZWYOp32zcH9N+DBzq5Do7F0FSV1CrLWdZ/2sXwqb2ZFXWD6XZ
	L8nZKJMuye35Q/X3S2p9VtwuRE9XpHji15iJH0knKFmTmSFY0oBEoV5zJCKUgMLLa/x9u3oRkJw
	SaK7ZV2MiL/NJ4=
X-Received: by 2002:a05:6808:ecb:b0:45e:dbc8:7b18 with SMTP id 5614622812f47-4639ef073b7mr528976b6e.13.1770965731453;
        Thu, 12 Feb 2026 22:55:31 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:a3ab:7352:1dc1:6b46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a754b162sm5404924a34.12.2026.02.12.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:55:29 -0800 (PST)
Date: Fri, 13 Feb 2026 00:55:25 -0600
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
Message-ID: <aY7K3cHE3dgnEC4L@mail.minyard.net>
Reply-To: corey@minyard.net
References: <1642aec8-e8c1-4ad4-a5b7-556feeedfd93@roeck-us.net>
 <CAJZ5v0i_BmeGROzQFpUCyF5MkA7sFkP3y8jjqH0mD2r2Wqj_xA@mail.gmail.com>
 <aYYPnATz1JakV3m7@mail.minyard.net>
 <CAJZ5v0h1irjy_ovyQw9ObGOTAUWajT_BK6u=rWQqR9awQBrY3A@mail.gmail.com>
 <CAK8fFZ4Ut6K-QGpy769_1N1K-GKpReo2wQgA=uXyXdGZ+QgGxA@mail.gmail.com>
 <CAJZ5v0hCEECyuAJZ4GAn=DeJR-UgtUXOMYYN9JQgEyghVnCYsw@mail.gmail.com>
 <aY4EUQcGbmT3Rexz@mail.minyard.net>
 <CAJZ5v0ip-Ke9p-2Qd9EQpp-J4Te53S4WsrJDeJPi_5o+U2_wNA@mail.gmail.com>
 <aY4dT-Mj5ZJIavdP@mail.minyard.net>
 <CAJZ5v0iS939x7VMQoNgks=Edichx2C+Qq8_kfiLpLh0ov=gwpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iS939x7VMQoNgks=Edichx2C+Qq8_kfiLpLh0ov=gwpw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20965-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email,mail.minyard.net:mid,gooddata.com:email]
X-Rspamd-Queue-Id: D3BA6133503
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 10:33:15PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 12, 2026 at 7:35???PM Corey Minyard <corey@minyard.net> wrote:
> >
> > On Thu, Feb 12, 2026 at 06:22:08PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Feb 12, 2026 at 5:48???PM Corey Minyard <corey@minyard.net> wrote:
> > > >
> > > > On Thu, Feb 12, 2026 at 01:27:41PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Feb 12, 2026 at 10:11???AM Jaroslav Pulchart
> > > > > <jaroslav.pulchart@gooddata.com> wrote:
> > > > > >
> > > > > > >
> > > > > > > On Fri, Feb 6, 2026 at 4:58???PM Corey Minyard <corey@minyard.net> wrote:
> > > > > > > >
> > > > > > > > On Fri, Feb 06, 2026 at 01:08:56PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > On Thu, Feb 5, 2026 at 11:34???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 05, 2026 at 08:04:12PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > > Cc: Corey
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Feb 5, 2026 at 6:51???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Feb 05, 2026 at 08:25:57AM +0100, Igor Raits wrote:
> > > > > > > > > > > > > On Wed, Feb 4, 2026 at 11:49???PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 2/4/26 11:54, Igor Raits wrote:
> > > > > > > > > > > > > > > I have written a patch with the help of AI and it fixes the problem. Attached.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > "No MIME, no links, no compression, no attachments.  Just plain text"
> > > > > > > > > > > > >
> > > > > > > > > > > > > Sorry for that, I had assumed that attaching the file would make it in-line.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > ... which means I can not provide inline feedback, which is the whole
> > > > > > > > > > > > > > point of the above.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Your patch crosses subsystems, so it will need to be split in two
> > > > > > > > > > > > > > (assuming the ACPI side is even needed). Also, references to iDRAC
> > > > > > > > > > > > > > in common code seem inappropriate.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, this I believe was the essential part (it was the last piece in
> > > > > > > > > > > > > my testing which fixed the hanging):
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Then I'll need to ask differently: What happens if you drop the IPMI code,
> > > > > > > > > > > > and just keep the wait_for_completion -> wait_for_completion_timeout
> > > > > > > > > > > > change ? Would that be sufficient to solve the problem ?
> > > > > > > > > > >
> > > > > > > > > > > I'd rather say "Would that be sufficient to make the symptoms go
> > > > > > > > > > > away?" as it most likely papers over the real problem.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Good point. Worse, it may result in UAF or memory leaks.
> > > > > > > > > >
> > > > > > > > > > > > Either case, the need for this change suggests that the ipmi change
> > > > > > > > > > > > may not be complete, since it should send a completion with an error.
> > > > > > > > > > >
> > > > > > > > > > > I think that reverting commit bc3a9d217755 ("ipmi:si: Gracefully
> > > > > > > > > > > handle if the BMC is non-functional") should also be considered as a
> > > > > > > > > > > possible way forward because it clearly did not improve things as
> > > > > > > > > > > expected, at least in this particular case.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I tend to agree. I ran a number of AI code reviews over the patch, and
> > > > > > > > > > each time it finds new (and different) problems. The fact that the acpi
> > > > > > > > > > patch is still needed even after applying the ipmi changes suggests that
> > > > > > > > > > something is still missing in the ipmi code.
> > > > > > > > > >
> > > > > > > > > > > It evidently did something that confuses things quite a bit.  Either
> > > > > > > > > > > it is returning IPMI_BUS_ERR instead of IPMI_ERR_UNSPECIFIED, or it is
> > > > > > > > > > > the "hosed" state and refusing to accept messages.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > More than that. My latest AI results are below, just for reference
> > > > > > > > > > (using Gemini 3 with Chris Mason's debug prompts). The prompt I used
> > > > > > > > > > for this run is:
> > > > > > > > >
> > > > > > > > > Well, I guess it's time to send a revert patch then.
> > > > > > > >
> > > > > > > > Thanks for the CC.
> > > > > > > >
> > > > > > > > Let's fix it right in the IPMI driver.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > "
> > > > > > > > > > The top commit in the linux/ directory results in hung tasks if the BMC
> > > > > > > > > > stops responding. Using @review-prompts/kernel/debugging.md analyze the
> > > > > > > > > > patch, identify the reason for the hung task problem, suggest and implement
> > > > > > > > > > a fix. Note that there may be more than one problem in the patch, so analyze
> > > > > > > > > > the complete patch and do not stop after fiding the first regression.
> > > > > > > > > > "
> > > > > > > > > >
> > > > > > > > > > I think that catches most of the problem, but not all of it.
> > > > > > > > > >
> > > > > > > > > > Guenter
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Summary of crash or warning:
> > > > > > > > > > Hung task detected in ipmi_si driver when BMC becomes non-functional.
> > > > > > > > > > Processes waiting for IPMI responses (e.g. ipmitool, monitoring agents) enter D state and never recover.
> > > > > > > > > >
> > > > > > > > > > Kernel version if available:
> > > > > > > > > > Top of tree (commit bc3a9d217755f65c137f145600f23bf1d6c31ea9)
> > > > > > > > > >
> > > > > > > > > > Machine type if available:
> > > > > > > > > > Generic Server with BMC
> > > > > > > > > >
> > > > > > > > > > Cleaned up copy of oops or stack trace:
> > > > > > > > > > [  120.123456] INFO: task ipmitool:1234 blocked for more than 120 seconds.
> > > > > > > > > > [  120.123457]       Not tainted 6.14.0-rc1 #1
> > > > > > > > > > [  120.123458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > > > > > [  120.123459] task:ipmitool        state:D stack:    0 pid: 1234 ppid:  100 flags:0x00000000
> > > > > > > > > > [  120.123460] Call Trace:
> > > > > > > > > > [  120.123461]  <TASK>
> > > > > > > > > > [  120.123462]  __schedule+0x123/0x456
> > > > > > > > > > [  120.123463]  schedule+0x45/0x78
> > > > > > > > > > [  120.123464]  schedule_timeout+0x9a/0xbc
> > > > > > > > > > [  120.123465]  wait_for_completion+0xde/0xf0
> > > > > > > > > > [  120.123466]  ipmi_request_settime+0x123/0x145
> > > > > > > > > > [  120.123467]  ...
> > > > > > > > > > [  120.123468]  </TASK>
> > > > > > > > > >
> > > > > > > > > > Any other kernel messages you found relevant:
> > > > > > > > > > N/A
> > > > > > > > > >
> > > > > > > > > > Explanation of the problem:
> > > > > > > > > > 1. Hung Task:
> > > > > > > > > > The patch "ipmi:si: Gracefully handle if the BMC is non-functional" introduces a new state `SI_HOSED` to handle BMC failures. When the driver detects that the BMC is not responding, it transitions to `SI_HOSED` and fails the currently processing message (`curr_msg`). However, if a new message is queued via `sender()` (populating `waiting_msg`) during a recovery probe (state `SI_GETTING_FLAGS`), and that probe subsequently fails, the state machine transitions back to `SI_HOSED`. In this transition, the driver checks and fails `curr_msg`, but it neglects to check or fail `waiting_msg`. As a result, the `waiting_msg` remains in the queue indefinitely, causing the waiting process to hang.
> > > > > > > > >
> > > > > > > > > That's quite convincing and it would explain the observed symptoms.
> > > > > > > >
> > > > > > > > Yes, and it's a fairly easy fix, I think.  The waiting message just
> > > > > > > > needs to be returned in that case.  The following patch should do it:
> > > > > > >
> > > > > > > Jaroslav, it would be good to test the patch below on top of 6.19.  I
> > > > > > > can put it on a test git branch if need be, so please let me know.
> > > > > > >
> > > > > > > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > > > > > > index 5459ffdde8dc..ff159b1162b9 100644
> > > > > > > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > > > > > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > > > > > > @@ -809,6 +809,12 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
> > > > > > > >                          */
> > > > > > > >                         return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > > > > > >                 }
> > > > > > > > +               if (smi_info->waiting_msg != NULL) {
> > > > > > > > +                       /* Also handle if there was a message waiting. */
> > > > > > > > +                       smi_info->curr_msg = smi_info->waiting_msg;
> > > > > > > > +                       smi_info->waiting_msg = NULL;
> > > > > > > > +                       return_hosed_msg(smi_info, IPMI_BUS_ERR);
> > > > > > > > +               }
> > > > > > > >                 smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
> > > > > > > >                 goto out;
> > > > > > > >         }
> > > > > >
> > > > > > I apply ^ patch to both 6.18.10 and 6.19 and reproduced the issue on
> > > > > > both, so it does not fix the problem.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > With all due respect to everyone involved (including the AI), this
> > > > > means that we are not anywhere close to fixing the problem and it
> > > > > would be a shame to ship 7.0 with it.
> > > > >
> > > > > I'm sending a revert patch shortly.
> > > >
> > > > Unfortunately, that patch fixed an issue others were having.
> > >
> > > Granted, it broke something else, so it needs to be fixed or reverted.
> >
> > Yes, certainly.
> >
> > >
> > > Maybe there is a way to address the original problem fixed by it differently?
> >
> > I'm not sure.  This is not the first attempt...
> 
> I see.
> 
> > >
> > > Do you have any pointers to any problem reports regarding that one?
> >
> > The original problem came as a patch set:
> >
> > https://lore.kernel.org/lkml/20221007092617.87597-1-zhangyuchen.lcr@bytedance.com/
> >
> > That had a lockup problem, and it had some other issues.  So I reworked
> > the code to the current form.
> 
> OK, thanks!
> 
> > I'm working on qemu now.  This needs to be added as part of the test suite, anyway.
> 
> There is something in the current code that seems to be problematic.
> 
> When acpi_ipmi_space_handler() runs, it calls ipmi_request_settime()
> to queue up a message.  AFAICS, if all goes well, this ends up calling
> smi_send() via i_ipmi_request().
> 
> If intf->curr_msg is NULL, the new message will not be added to a list
> in there, but intf->curr_msg will be set to point to it instead and
> handlers->sender() will be called on it.  But handlers->sender points
> to sender() defined in ipmi_si_intf.c which returns IPMI_BUS_ERR
> without doing anything if smi_info->si_state == SI_HOSED and its
> return value is ignored.
> 
> The message is only pointed to by intf->curr_msg at that point and
> AFAICS it will never get actually processed because intf->curr_msg is
> never really dereferenced (it is only compared with other pointers and
> checked against NULL if I'm not mistaken).
> 
> It looks like smi_send() needs to check the handlers->sender() return
> value and maybe return it to the caller so i_ipmi_request() can return
> an error if it fails.

This was indeed an issue, and had to be handled correctly in a lot of
places.  And there were other issues.  I tested a lot of different
scenarios.

Patches are currently in my next tree
https://github.com/cminyard/linux-ipmi.git for-next
and I'll send emails with them, too.

I was able to reproduce the issue with qemu.  Assuming this works, next
step is to automate the tests.

-corey

