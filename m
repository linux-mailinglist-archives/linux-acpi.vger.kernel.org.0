Return-Path: <linux-acpi+bounces-20820-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFSyBX7WgGmFBwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20820-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 17:53:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346FCF346
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F13302D5A6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341E290DBB;
	Mon,  2 Feb 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="og9CIMwr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393F37E310
	for <linux-acpi@vger.kernel.org>; Mon,  2 Feb 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050944; cv=pass; b=gYR/VRngnjdJ9QJ5gyBj1SijY9CKgz/5DqOl7JJ3fQ05XzUhOfwePy1CbGnve+5G/WOmt74hBLi+gKLf1gqvtO+GxXe3CwrIvJz/JUYnx26jrUwsDYzVXai+SmyXrIM9vGDQm9xOw/my6q9VFabZVXSPkx9BDnVPumeSr/52GFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050944; c=relaxed/simple;
	bh=LxjhE4ad+4M4QuDhOSFV4xQtXxPt8C0iZWA46vmpN34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGSqAgj2mHKGUgMe8RGYPoSMjYtYtVZ8Y8aHVoabVnv3Y0maRZzdajg483EVgK5cMviQE5OI7Tpg5rnKd0d9JNLKIck6L498AJOAo4SNwLDF3BE1Vz6mSV0lVd+jz6OneAdLrFZJcZ+KBplH5L3MfUhRTK1YMwGVewIMpWFJcQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=og9CIMwr; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124a1b4dd40so1185797c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2026 08:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770050942; cv=none;
        d=google.com; s=arc-20240605;
        b=DCioDGZJ9X2yH1+3zG1gXGFgm6mPNrksIpdIjs5Y9+DYTJUc4GZDxEyKlmISz/cGEe
         Tlvrzo4ztMutPgH3Qi6gE4X8JLQQ8QHaD8kvR1MQXGf5MSNXr/oqR6TqJDo1yvHBaVr+
         KvZFlQDPy3ER25f8WWn2PuYMHs/VNfyIevP3aofzVV4472JmFZZ41zUyOnaDu9Qj2+jQ
         4DBUnE8fyO7zqZjK5xHmi+WP5YTUMtu+siH2tOH1RWE/pUULSRbLcDj/oEL82JnBOxP0
         lU1+sV4yWESB+uG7MfgmVPNFRPy7oKF75BRBeOPX4fFEazOBSYcgZpWSeEoO0pEThhn2
         eRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BCN8Le0pLyitc3CNSBu8WOx/swSsqQ2swPw/Rz8TUzI=;
        fh=f3LWDRss+M6OOFXDttn2SvULJt9G5godXIhfs2DuczI=;
        b=jpcqJerSPnbIlaSZFFeCga7JrTxyJGDN+845jTXQGj3HQDRJxOIcZUXoLRQ/D3N1Dp
         fgv1KzoAzbAG99RwYeeyd89dlohORnSGTNjjOwjvbSJcgL4q4N7KXJftSxWiPbsNX+P+
         etoaLPkh2wVTr0+MINRyS4fh2PqsZpmv5E7duvod+GiSE2N9xGyBWquHbb0i+OaleShu
         8zRMTs+biBy+o/7xTBYzlbV3N8xpH+J/dfYIklYP2QsDAzV6UJqUpOh8/dwY6y5Fr9rD
         /tjWyZRkBvfU5vwtmUnZISWX+mtj4JxeA27jY75k6xy8bq9rowkwXsplbeKw9ap+LN91
         +n6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770050942; x=1770655742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCN8Le0pLyitc3CNSBu8WOx/swSsqQ2swPw/Rz8TUzI=;
        b=og9CIMwryTcCuW5cHCBToxyHP63/bgLVSKAiSoq7JgTJwHq412dVTREfZBNTuhT09o
         RhOa3fZma8w1tOaRxO2YBhqZaVF/0ErbfA4wms8IgOs9GCO0BlnoFTyBKODEvxJXEvbQ
         65naG0QX+7bal5nXeRwKgJ6LiXCzFieTT+uNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050942; x=1770655742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCN8Le0pLyitc3CNSBu8WOx/swSsqQ2swPw/Rz8TUzI=;
        b=DDfrjQyejFt/5d8cNUfZBjmyzI+J5cF+xy5mCIY7/ArPJURZCAyrNUMQCXHb4FaVQz
         mEIj3zW4q1u71MWkxP6jACfzzv3s6IrndUbHpfUCf7Ej3bTmfD5SFAPOuVOSjlf8q5Rq
         G8xEjzNbyYXx0AW01/Esv3oPI43j+CKUzqAsmdi4eelq083TbbLQVwWT7tV94YCQJMgF
         TbtapUNfS8FxS9J2MPZotpZxciId9uc5cvUgoHpdN+uZ6VnyPvDqALjxU9fmufr/BzwL
         j7RtXNcrCS+jBvUe/jWV4Unc4kvHNMqcc/cTu/xlSggtVaAQXTBFQr2Z98FGe2Q+Itca
         G5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUxiB8FwTYsCLNbdBLYhKJllNPgOqgfXDS0DZmQhC+re0dPC6mUf0wy+CFFmnbhYB1kXkpiaEW+2s2H@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOq828rHot7aNAi/kDf0ptue2PT7J3xc9F96gpswR9dM/TZhE
	GzavCSZqvet8+oSOp14outQ7hY41RXottko3pYMEzyyTibk5IGVTmeksypbNJpRcz/FsnmCCdw6
	MuQkoyU4pQWFdGS5NS/B20REGy4QsFHlJsskRQZBz
X-Gm-Gg: AZuq6aIHxGAGt5YGteA9xJwNser+5pA1YsL3cGGrY7nR+4MDheaMsVdci6LSvEI+fH9
	KAdbSweBbWecEKNGtLxigkYtYJ1R6qOYUMwO7Adlf3veRFeVhn1hTZG+lvZ3iwkzMBEDNCVRMIW
	7IdLuLlsN1UkXrE8sGZhKP/SsD0XYzXjwui4JwV+gbHrkXNLLPaW/liup6/KXWEMt/z3kop5Ifk
	w2d0raSXZjbHTgCLWlqpU0N70hh0HOfOJdPLCQ1VTxJ6qvWLpel9EJ4aT5mhklIc/QUVMQt
X-Received: by 2002:a05:7022:6610:b0:119:e56b:958a with SMTP id
 a92af1059eb24-125c0f88d5dmr5930820c88.15.1770050941664; Mon, 02 Feb 2026
 08:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net> <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net> <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net> <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net> <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net>
In-Reply-To: <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 2 Feb 2026 17:48:35 +0100
X-Gm-Features: AZwV_Qg-Z86It63WG7mLh3EaECuQjkUS0rUhn8KgZZJIYFsFZmHm47Ne5ImaBcU
Message-ID: <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20820-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gooddata.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gooddata.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9346FCF346
X-Rspamd-Action: no action

>
> On Thu, Jan 29, 2026 at 04:26:37PM +0100, Jaroslav Pulchart wrote:
> > >
> > > On 1/27/26 03:58, Jaroslav Pulchart wrote:
> > > ...
> > > >>> Hello,
> > > >>>
> > > >>> Thank you for the analysis and insights.
> > > >>>
> > > >>> To add some context from our side: we observe this issue shortly after
> > > >>> a server reinstall or fw updates followed by a reboot, typically when
> > > >>> hwmon sensors are accessed for the first time (e.g. by monitoring during
> > > >>> early system initialization). We have not seen it trigger during normal
> > > >>> operation, such as a simple reboot or on long-running systems.
> > > >>>
> > > >>> Given this behavior, it is possible that the issue is related to
> > > >>> hwmon_device_unregister() being triggered early during system
> > > >>> initialization, but I do not have concrete evidence at this point.
> > > >>>
> > > >>> As a workaround, we will exclude the ACPI power meter from hwmon monitoring
> > > >>> (Grafana Alloy) until the mentioned refactoring or a fix becomes available.
> > > >>>
> > > >>
> > > >> Would it be possible for you to test the patch series I just sent out ?
> > > >
> > > > I suppose these 5 patches from
> > > > https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@roeck-us.net/
> > > >   ?
> > >
> > > Correct.
> > >
> > > > I will try them and let you know.
> > > >
> > > Thanks !
> >
> >
> > The issue is still there:
> > ...
>
> Thnaks a lot for testing.
>
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.105931] INFO: task alloy:5985 blocked for more than 124 seconds.
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.114475]       Tainted: G            E 6.18.7-2.gdc.el9.x86_64 #1
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.122872] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.132932] task:alloy           state:D stack:0     pid:5985 tgid:5871  ppid:1      task_flags:0x400140 flags:0x00080001
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.145975] Call Trace:
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.149985]  <TASK>
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.154931]  __schedule+0x2b5/0x690
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.160934]  schedule+0x23/0x80
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.166498]  schedule_timeout+0xe8/0x100
> > 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.76  [ 741.172936]  __wait_for_common+0x99/0x1c0
> > 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.179148]  ? __pfx_schedule_timeout+0x10/0x10
> > 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.185936]  acpi_ipmi_space_handler.part.0+0x1ac/0x370 [acpi_ipmi]
> > 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.76  [ 741.194929]  acpi_ev_address_space_dispatch+0x16d/0x3c0
>
> Looks like acpi holds another lock. Can you check if the patch submitted by
> Rafael fixes the problem ?

Hello,

I tested the patch as a standalone change, and the issue is still present.

However, I can now reliably reproduce the problem. It is triggered while
Dell iDRAC is being reset or updated and is temporarily unavailable. During
this time, a [kipmi0] task enters D state for an extended period, and
shortly after (or during this), the ACPI power meter hwmon interface ends up
in the locked state described earlier.

This explains why we mostly observe the issue after redeployments in our
environment: server redeployments typically include iDRAC firmware updates
or resets performed together with operating system installation or updates.

Best

>
> Thanks,
> Guenter

