Return-Path: <linux-acpi+bounces-20671-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GWiKs3keGlftwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20671-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:16:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4029793C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24B7301649A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF635EDC8;
	Tue, 27 Jan 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyhKpQ58"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570A350D6E
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530429; cv=none; b=ZZrNPnuqr2GEq51LQqqKLdcy8r7e659uM+G7/YiYIwJOOmHAv1lm8nsOt81flAj4gprruAntltzzGxbxcPNznydP3ZpxT1nzF0OHTUR2YRvnkb9RpLDAM05Z+c0e2h0l5SRZOFWCi8FnB9axJlvN5pSZIdG7HG5tSw5lto4jtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530429; c=relaxed/simple;
	bh=y8v5V+tYIM6n3wnDXvrdbFANd4Jq/4/oDnIJmLqx420=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+QtL2W9EK3E/5sIbhoEE2A/7f5g27Sz8ITDlRPxiV7Zsw5bfPvVWqn7CDY1LEaZrteM961dkeSv81pXAsDPHx3LupH3+GT23DJmW+if/qqLhOYV1BnEUAOKVL71jP7XXqxrJJ9GbxVLdPB9lxCKNoiBz7bl9VM5VrOfBj/w6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyhKpQ58; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b73112ab62so4922293eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769530427; x=1770135227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foZbL69h+8hDXLGAkMe9gWFOExWjvLu/2tjx7FoVudk=;
        b=TyhKpQ58YZbSQd6ipu7/XJocYKNnSrfQ2NZuLhjl+c2hSyz0P4bwmZrSe/Sqb3C997
         a7VXSgtg2PAElc3/HDMBDe+uPU5VTh8F1v1RxLLTZk672ya9beXO7PBkpJwMKBJjBjhX
         QwGoTftN9Miko+F4JSEYBNH3poDJCZAQZHQmlFNaySMgf85IZCZO0Tnf4HqJg30sST2x
         wS2rzvP92zW2ZEgDAxY87w4fMuX2nVhW+o7WvW3t635tXvKgUZZ2MIjWjnplPUQBRXwK
         vfJusUTnowKnuSMI6XYWTphyhQw69xKQqSzMpc02QxVyZJaw6CTHNA3v/G8eamm/zpG1
         FN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530427; x=1770135227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foZbL69h+8hDXLGAkMe9gWFOExWjvLu/2tjx7FoVudk=;
        b=LDOauOtP56b/YuiD2Y271Ra6Nl1F0NWEBvKVV0hnAnQW7xBxLwWm4Kgqed7vpW3pqP
         9t/i9HHz8J2I6aWjZHolOxUO6dDmfX9HdlWXplBu1Ouzm/GDzetZBnbAClOpg5BOgJkX
         Qjf6FuU93OIhlmeba3veHhS9Z32u8B9M4DORkU16fj6D27svkW5J4rBLK5wRHOHKQWfQ
         CKrFsw+R+QCExkNRQTzvWagOHuOrEhsUhyjZ7vpwcXXRNpqr+UBI99XHkpvPR2bK2eNx
         V78+Lgf0b74YQJb99ox/rFyW3nIhrbknNa6wZfzyzmVccmsnrkqriL6aooZk5XTp687X
         1oiw==
X-Forwarded-Encrypted: i=1; AJvYcCV9OZ9sps3B6MoNyrbLgDBDiqxs0bU+4HQ2WCCHqzfGOYu/kwU76xuVfCKgVFye3TDb5Hq2XNVSsaH2@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuneozaWJPyqjm+MxlO/bl6rGWHJrsmCVuarejsL+3IjDEDKJ
	Q3NLmkoH5KIg7eDPuGuNczkg6r+Gg8F8mKV2LsQktxkMo3mAn40ztYFd
X-Gm-Gg: AZuq6aKo8vu4YXt7gWnW8spc10R46oy8dnDmuUzgKaS9+hnbji6F+yF+k39Bz643EhB
	N9S0peeXL1coFGUU2HkkXEsesEONhfpmVhL9srQHdG/qVcdKdMIZ1Q6EX00UBTFhwaDPd2Cnddx
	dN17UJdeXgcBwMml1hkRaNzLqSR1VFcz4A2UX8KEn/lk69r2LO4Z5RLoIJjAQHPn1hObtm3pdtz
	IB04DNhH7NrLDmqk1gr0G/8/igmOGJbxPC3AOpmt1KO426vmEhbAb2LIPvBJh+Lbh+zP+4ruFH2
	3TgArSAJsbe5nJzmwf4sNaxIiT7TALGAX3sjIIsQIA6CiOQqRDR4PFHwwPRj3VkezpyjqikCYbN
	yXmDbQInkm/9RCquZL5mdds65J33F1kL9vuO/weot01a8PjMgtWnTCrk/9K6g4htZ2inMl9FiVD
	gSrTipxo4439lsgcHiRjTaaxF6
X-Received: by 2002:a05:693c:3017:b0:2b7:1d38:3596 with SMTP id 5a478bee46e88-2b78d8cc6e9mr1589269eec.4.1769530427130;
        Tue, 27 Jan 2026 08:13:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1b39sm17459343eec.21.2026.01.27.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:13:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 27 Jan 2026 08:13:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Igor Raits <igor@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex
 deadlock in hwmon_attr_show since v6.18.y
Message-ID: <69665f53-a3ef-4129-afd5-5f7622f70e6b@roeck-us.net>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <483f36e1-4ddc-4c22-aaba-c78156ebc0e2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <483f36e1-4ddc-4c22-aaba-c78156ebc0e2@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20671-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,roeck-us.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E4029793C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:53:02AM +0800, lihuisong (C) wrote:
> 
> On 1/23/2026 4:42 AM, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 8:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 1/22/26 10:55, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
> > > > <jaroslav.pulchart@gooddata.com> wrote:
> > > > > Hello,
> > > > > 
> > > > > after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
> > > > > in the ACPI power meter hwmon interface. Reading power*_average sysfs
> > > > > attributes blocks indefinitely and causes tasks to enter uninterruptible
> > > > > sleep (D state).
> > > > The most recent change in the acpi_power_meter driver was made in
> > > > 6.15, so this is not a regression in that driver.
> > > > 
> > > > Also, nothing suspicious is done in power1_average_min_show() and
> > > > power1_average_min_store() AFAICS.
> > > > 
> > > I suspect a circular locking problem between the hwmon lock and the
> > > resource lock. Unfortunately I don't immediately see it.
> > > 
> > > Would it be possible to test this with a kernel which has lock debugging
> > > enabled ? I'd test it myself but I don't have a system available
> > > that supports the acpi power meter.
> > One problem I found in acpi_power_meter through code inspection is
> > calling hwmon_device_unregister() under resource->lock in
> > acpi_power_meter_notify(), which may be responsible for the observed
> > symptoms, but then I'm not sure why it started to be visible after
> > 6.18.
> The hwmon_attr_show first hold hwdev->lock and then hold resource->lock in
> acpi_power_meter driver.
> Although driver call hwmon_device_unregister under resource->lock in
> acpi_power_meter_notify(),
> hwmon_device_unregister does't hold hwdev->lock.
> So this may not be the root cause of this problem.

It might be if userspace has one or more open attribute file(s). That might
be the case since other code in the driver calls sysfs_notify(), suggesting
that files are expected to remain open. Of course, that would mean that
userspace is all messed up because having an open file descriptor on a
since unregistered hwmon device doesn't really help much - worse, if a read
is executed after unregistering the hwmon driver, using a _different_
instance of the hwmon lock but the same resource lock would really mess
things up.

We'd need some active debugging to figure out if that is the problem.
Either case, re-registering the hwmon driver from acpi_power_meter_notify()
is conceptually wrong, so I am a bit surprised that this ever worked in the
first place.

Guenter

