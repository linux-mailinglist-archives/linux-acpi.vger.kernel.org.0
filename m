Return-Path: <linux-acpi+bounces-20776-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PzeKzGme2lWHgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20776-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 19:25:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A932B38F7
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A74F330467CF
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247442EDD69;
	Thu, 29 Jan 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9FINoKe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADC2D94BA
	for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710957; cv=none; b=i7hXVdsoUaHmmYU0O3tUa62QkH53QF1r2JLDf+feVJ9u2BzjS+kaP9s4OuX24HvsPBBpE4z4MQEaCAGm13LOziMlEE30cIuAhLnoz0IKBIQXJSQZM1xyNdbgLMNFZs3gL4W9HlHQUzBl3aoSSoFOPKhK5WhhPVyhtFSOKg0zsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710957; c=relaxed/simple;
	bh=ybnp74LygZZXfv1/uQdkiQ7bL0mmvgLcYkfE4JMSbac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr+h9f1nm228K+DNBme0mlzlr1GSgPi6loxBf22uh+FhRlms+EnWLqTOKqLjrlu4grHauIxQCROgiwy0+bsA7qXRQRlgK6ObTaWd/6eof65es0lYpb6tHmemw9PV5uqP6F7UWTNtregeb5auvJkHqjkifiM11NHqI0amsYW4SwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9FINoKe; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b714f30461so1246854eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710955; x=1770315755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMLH33nEOc8yI2rxL7oZJuMyWNyMwxmDMdzy7mG5qTI=;
        b=Y9FINoKeIf8/+rVS4NP3Rr84x+dtmzivm4ti0C7CJ8P25LKj7x6EuBgd04/YxByXvq
         dN1yOO0HUjVw+7GcueOGA51yTW0wqVIOjlirNo9YDuIzW4HyvOCO4isNdX2q/k5QciLj
         z9H/aodJYXieUATgxud51/8eyV0SNSIPWNSf3i3AKc9KHJavXVZuoYYHtBGd9FpO4J6l
         57GZRvEW3GrcP7Tpvk/n55tCY59SA4PLGaebynUjBRc9AvtknH6hXGYr9WqA5ce5DE4d
         FT0rFvvRvmQatHW2E8bwq9RMKw6qN62gVLT/VBlv4FgSOGg9mdndoQmnIO0X7Xewi7H5
         k7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710955; x=1770315755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMLH33nEOc8yI2rxL7oZJuMyWNyMwxmDMdzy7mG5qTI=;
        b=lTBxUGQo5E5Tq8BQPq9zBlWuu6WBdv5lmFNTKJ/w6Ma2vqf5n87BlmkmDrJIiE43CJ
         qz04Ip/yNtrO9wm3/87mudt/Mu7d1ym6lhzYqGJm0oWGzOwhHQAVO00RFr+lVXW8Lx5W
         sPjYlMyCI4xr8Z7TpvV1+rRmVoch7fLmSH8Xovo0ZzzOofabQYJYE7TCPZNMs9cuAUnB
         ZZVGkI92gvON+3exvL0ITgwCqeqiOI+N+DweJKz/8Q/Hccp8xKZnJiiLXPRfSBxLf2Bk
         blOlhz4N8Xtoplm7L4oxXnW3h9hiypfThyKHbmgUfjWp+GULKllxxX6+yanCJQHbC44h
         CBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXsEDrDOsF5xV4eG/aXbhK3YpF30r8zzVNxK4x2TF7KFX5+qWxQ6qAGVpddxzkAMbUOV5AnKhZe1mS2@vger.kernel.org
X-Gm-Message-State: AOJu0YxwquZ4Daz55UvVF1hmAaIhign0YEuizm/S9JSduABMgSzavD2b
	9/teLS+E6mhpwehtLvJJoooLQaNSz1YCzXlGBJWripLlNWMM6sNEo0R7
X-Gm-Gg: AZuq6aIKlkNfAKkR5TweVsFsTw+MAnNLo48gP28NMr3B9BgTuQYWT8q5KLs5of22y3N
	myaLpOD8li8daizExgTG+WqHZ2Z/Ogj+PlbmpkwdS5QpcD6L1T9rMEyZ2ZtSNsDKKlYdyvV6oVk
	gXkIINF4vC0fz7prORdRsZK+Fn6eNGADFrZeIvt+BomxuHeRQCu4t2Y3hYkbQo8RmFweXzFG9xO
	6yYrBBNICcDOSjKMdTWHH4MzF2TVdHW2+c8Jh66gDWPHXuv9jQLUsDGsiQIupS5oKYYWK59jXKD
	blNUbtJqkxYn+wm/JTuuJO7CH2A4SzHwLE91M3QlJM8co4igqjwcGaAIv8KkeJH9S989kkjDaYY
	lBsNMpJsMYlpWEfV1PnEH2XNRBZUxGF53j//guptR4qfTrevFuLvug0JK8kXl1Q+yx3syssptsQ
	eBE1OFENYHlqR9yFntXYN+cF9x
X-Received: by 2002:a05:693c:2c0f:b0:2ae:581f:ce5 with SMTP id 5a478bee46e88-2b7c8638d65mr173862eec.7.1769710954487;
        Thu, 29 Jan 2026 10:22:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm7840104eec.3.2026.01.29.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:22:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Jan 2026 10:22:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex
 deadlock in hwmon_attr_show since v6.18.y
Message-ID: <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
 <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
 <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net>
 <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20776-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A932B38F7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:26:37PM +0100, Jaroslav Pulchart wrote:
> >
> > On 1/27/26 03:58, Jaroslav Pulchart wrote:
> > ...
> > >>> Hello,
> > >>>
> > >>> Thank you for the analysis and insights.
> > >>>
> > >>> To add some context from our side: we observe this issue shortly after
> > >>> a server reinstall or fw updates followed by a reboot, typically when
> > >>> hwmon sensors are accessed for the first time (e.g. by monitoring during
> > >>> early system initialization). We have not seen it trigger during normal
> > >>> operation, such as a simple reboot or on long-running systems.
> > >>>
> > >>> Given this behavior, it is possible that the issue is related to
> > >>> hwmon_device_unregister() being triggered early during system
> > >>> initialization, but I do not have concrete evidence at this point.
> > >>>
> > >>> As a workaround, we will exclude the ACPI power meter from hwmon monitoring
> > >>> (Grafana Alloy) until the mentioned refactoring or a fix becomes available.
> > >>>
> > >>
> > >> Would it be possible for you to test the patch series I just sent out ?
> > >
> > > I suppose these 5 patches from
> > > https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@roeck-us.net/
> > >   ?
> >
> > Correct.
> >
> > > I will try them and let you know.
> > >
> > Thanks !
> 
> 
> The issue is still there:
> ...

Thnaks a lot for testing.

> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.105931] INFO: task alloy:5985 blocked for more than 124 seconds.
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.114475]       Tainted: G            E 6.18.7-2.gdc.el9.x86_64 #1
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.122872] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.132932] task:alloy           state:D stack:0     pid:5985 tgid:5871  ppid:1      task_flags:0x400140 flags:0x00080001
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.145975] Call Trace:
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.149985]  <TASK>
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.154931]  __schedule+0x2b5/0x690
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.160934]  schedule+0x23/0x80
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.166498]  schedule_timeout+0xe8/0x100
> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.172936]  __wait_for_common+0x99/0x1c0
> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.179148]  ? __pfx_schedule_timeout+0x10/0x10
> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.185936]  acpi_ipmi_space_handler.part.0+0x1ac/0x370 [acpi_ipmi]
> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.194929]  acpi_ev_address_space_dispatch+0x16d/0x3c0

Looks like acpi holds another lock. Can you check if the patch submitted by
Rafael fixes the problem ?

Thanks,
Guenter

