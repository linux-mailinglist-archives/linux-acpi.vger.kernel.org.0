Return-Path: <linux-acpi+bounces-20843-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKW+DQiDgmneVgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20843-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 00:21:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8683DFB3C
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 00:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4762830484CB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381E31812C;
	Tue,  3 Feb 2026 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="U2MbVl/8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55863176F8
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160895; cv=pass; b=cLQtLutjhjYVFUhJkU4UUoiU0nL+ExqfTrWncW0z+3hY6epCdS2WRqgt7GjyCrf4zzcp2UDLvf9hMF8RSx07t6UxxHZSm11QTabk7rHPqnJtZz9I8yr1gYrcudNVMkp5ug153Hp5I85G36dMQ1LTzcrEpv6GfnrFOw4GAUgFx7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160895; c=relaxed/simple;
	bh=HHCdNXjNBvyPUktGD92dPHiiAIu5rb0UKc9ms87auaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFuztq2o6sUqgJ39zXHXw0PreKOEgqszJ4gl8FkuKmAX4JhBXCK9JNVU3WfJP1/65F10h8v3EGfqSIC7Pnz5grKZnJeKzOcQYRDkMSlBUt3KaypM8E3wR/0I/TauiW8bQX7zHW0ijKuRdu+o3bk8IWdgp15Im6ShxWXQStNwnY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=U2MbVl/8; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so452708c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 15:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770160892; cv=none;
        d=google.com; s=arc-20240605;
        b=eJdyv5Ebu6EitK5rPeibudAAECMXKggm+E+45Hdb6QbD9H2fae97b76PjN5FJvFnQ+
         HMoRyz+p8+HLPI7FxxNKPUoYhYdbitvjWihsvfLlHTLTY1YGJrUXmxfoiEV7B4pwrcl2
         HLJEFA49PZo9AEIZELF/XsqlgZSBZAU8xwAWufWUjpt8E3XBvKPR3mzaSkNIIbsHrJuK
         H/kM6Rh5EuDwkY1HHn9y7+JBhMUy3TAnu//LBTEtlNBGwvmS0X6vzUJxTTSkSJSOtr9U
         Qzte7Q9a0uocFxekL+13XTd0eLDuZZeaWrDWM6Ipfl4WoO2VTSwBbbbht0+Vbzm/eHPw
         U2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2CD/HSXxd0BdU8VhiiV/wF16w0pcfoIwey1akMquXd8=;
        fh=s8+dSTnJ0aPvyrrKyf934Djgb6T5Xcw6+dKySG4BgBs=;
        b=fN+v0SWo3EUrGSwzBpL/7+0W0xacLM3p/bMy9+VsXiupiD9ZCqvOgTLQG2raWhb62j
         8Cct+sWO8ZJVHL4SEckzCUEq5riFl10oinafHS0fDKGStD54r4DsgX5XlIJIgrLnYeKl
         s7vGhoapsCJWT+JTQ174gklLpLvyXMHyH51KGiDNw9OgLxIPge0DHJfpOmIhgpsy+t2k
         UHDWUPFcj5zalglrndKG6DDW1ZGnEpqTi6mqDVdfuQeNDCtZJNoMtQJc9FEaR5bcx8YD
         3i9+CSoJVpPXgXVBOWWz2e0AA87eQC2EjUTpZEPi0Ei6T32zXgoPgSg9+O2JlRJGXbHA
         H80w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770160892; x=1770765692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CD/HSXxd0BdU8VhiiV/wF16w0pcfoIwey1akMquXd8=;
        b=U2MbVl/8ZPJmoDPqZNoRxhaBnV3pOYc5cSg5yO//hIVJwMQTK0uT56GHNY6o/KXiwj
         /qAqcAiZUaMwBfk+fv64d3g0D4gQNEcW3/ZfilLqGGMI83dGTDFavbE53VFdbzxZYzhH
         LI/2okHGFlfQd10w26ftPyKOv+QM2Hl5jBMts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160892; x=1770765692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2CD/HSXxd0BdU8VhiiV/wF16w0pcfoIwey1akMquXd8=;
        b=ExtVbZT5GyVzBXOwpNOYhkm+OFML+hya8HvilLzbRSbChurXexuWaff/hKMT6i6/4h
         yCH0PnKLm2liA3IfJWJn7U3E2OY9PEUVfH7YnXpc61ycQnYbJp8xqsegligTdwKUmr2Q
         24/cbx5sQxrPDMungND6jc/O4bMiGnO2gNMwHBgwJ7+E3LGWZvVDvQ3wwS9UZs4u6fVD
         igPoJWvqjk3dDJlKL3E6m1fGR48mO1fFos3yNvUmuJNMIz86aYq9JfRvGL4Sk5LJw6yL
         5RGYPKVvjVQ9KOlMK7QjcKLMOyvktFLX/7cjWsdK7g6pYfjt64dh2IwDi4XmgKaD71rn
         3AtA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9yzAdo+gqNtO5skDHOlTUa4rDaED6Mz7MDvPAhrys/MelzcxpW8AtaRLTD4677mpD8fTpRdl3E0L@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYMLRoNL5nyUAREkRV9+Zdka0K9Y6WCSehdy7Li7ifhBR/oMz
	9LLJeNGu7mL7q3V6FyKIoLl41PTGHXYNx+nXWEAxcQI3G2mnOf6btodmKIWBeS5UwW/MDYeZW5q
	EtdJtLowJDczpSjr7zStV5F4kNo2KvkyAAZFyLf0b
X-Gm-Gg: AZuq6aKOQZSwKPu1IUkxiWCb1GK557Z8vkcuu+GzH/SuuO1v5dRJnDNsNJTzHTnGIgc
	tmuwfC0e+4sxC9KQhejLUeBX3KFzw01TXWjDhbRrmmcGRzNCi9XHWN2AAcdYFDOEVl0OgukoWhn
	eTEXBkyrBpzjL62YEQLfzPOwBzxn7oT4KdFcQv7mfe2wWtelW/JB0JRO7udq8jS9EWBoBTZ+68R
	vtIx94nMrOlawEgfka+e7kJMIUa6sbyhX+/7+lzbUw+X+H4+vN4xhqAvCPkoIk2cqETlswJ
X-Received: by 2002:a05:7022:6986:b0:11a:51f9:db0 with SMTP id
 a92af1059eb24-126f477dd0fmr633951c88.11.1770160891571; Tue, 03 Feb 2026
 15:21:31 -0800 (PST)
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
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net> <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net> <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com> <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
In-Reply-To: <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 4 Feb 2026 00:21:03 +0100
X-Gm-Features: AZwV_QivSjNFbCKTke7bsHfjftYVCRsA2e4DQKBnzdKoxmd3G2TINGpu-K6brmA
Message-ID: <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
Subject: [BISECTED]: acpi_power_meter: power*_average sysfs read hangs, mutex
 deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20843-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gooddata.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gooddata.com:email,gooddata.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8683DFB3C
X-Rspamd-Action: no action

> > On Mon, Feb 2, 2026 at 7:14=E2=80=AFPM Jaroslav Pulchart
> > <jaroslav.pulchart@gooddata.com> wrote:
> > >
> > > >
> > > > On 2/2/26 08:48, Jaroslav Pulchart wrote:
> > > > >>
> > > > >> On Thu, Jan 29, 2026 at 04:26:37PM +0100, Jaroslav Pulchart wrot=
e:
> > > > >>>>
> > > > >>>> On 1/27/26 03:58, Jaroslav Pulchart wrote:
> > > > >>>> ...
> > > > >>>>>>> Hello,
> > > > >>>>>>>
> > > > >>>>>>> Thank you for the analysis and insights.
> > > > >>>>>>>
> > > > >>>>>>> To add some context from our side: we observe this issue sh=
ortly after
> > > > >>>>>>> a server reinstall or fw updates followed by a reboot, typi=
cally when
> > > > >>>>>>> hwmon sensors are accessed for the first time (e.g. by moni=
toring during
> > > > >>>>>>> early system initialization). We have not seen it trigger d=
uring normal
> > > > >>>>>>> operation, such as a simple reboot or on long-running syste=
ms.
> > > > >>>>>>>
> > > > >>>>>>> Given this behavior, it is possible that the issue is relat=
ed to
> > > > >>>>>>> hwmon_device_unregister() being triggered early during syst=
em
> > > > >>>>>>> initialization, but I do not have concrete evidence at this=
 point.
> > > > >>>>>>>
> > > > >>>>>>> As a workaround, we will exclude the ACPI power meter from =
hwmon monitoring
> > > > >>>>>>> (Grafana Alloy) until the mentioned refactoring or a fix be=
comes available.
> > > > >>>>>>>
> > > > >>>>>>
> > > > >>>>>> Would it be possible for you to test the patch series I just=
 sent out ?
> > > > >>>>>
> > > > >>>>> I suppose these 5 patches from
> > > > >>>>> https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@r=
oeck-us.net/
> > > > >>>>>    ?
> > > > >>>>
> > > > >>>> Correct.
> > > > >>>>
> > > > >>>>> I will try them and let you know.
> > > > >>>>>
> > > > >>>> Thanks !
> > > > >>>
> > > > >>>
> > > > >>> The issue is still there:
> > > > >>> ...
> > > > >>
> > > > >> Thnaks a lot for testing.
> > > > >>
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.105931] INFO: task alloy:5985 blocked for more than 124 seconds.
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.114475]       Tainted: G            E 6.18.7-2.gdc.el9.x86_64 #1
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.122872] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.132932] task:alloy           state:D stack:0     pid:5985 tgid:587=
1  ppid:1      task_flags:0x400140 flags:0x00080001
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.145975] Call Trace:
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.149985]  <TASK>
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.154931]  __schedule+0x2b5/0x690
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.160934]  schedule+0x23/0x80
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.166498]  schedule_timeout+0xe8/0x100
> > > > >>> 1769654277410 2026-01-29T02:37:57.410Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.172936]  __wait_for_common+0x99/0x1c0
> > > > >>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.179148]  ? __pfx_schedule_timeout+0x10/0x10
> > > > >>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.185936]  acpi_ipmi_space_handler.part.0+0x1ac/0x370 [acpi_ipmi]
> > > > >>> 1769654277660 2026-01-29T02:37:57.660Z Jan 29 03:37:57 10.8.8.7=
6  [ 741.194929]  acpi_ev_address_space_dispatch+0x16d/0x3c0
> > > > >>
> > > > >> Looks like acpi holds another lock. Can you check if the patch s=
ubmitted by
> > > > >> Rafael fixes the problem ?
> > > > >
> > > > > Hello,
> > > > >
> > > > > I tested the patch as a standalone change, and the issue is still=
 present.
> > > > >
> > > > > However, I can now reliably reproduce the problem. It is triggere=
d while
> > > > > Dell iDRAC is being reset or updated and is temporarily unavailab=
le. During
> > > > > this time, a [kipmi0] task enters D state for an extended period,=
 and
> > > > > shortly after (or during this), the ACPI power meter hwmon interf=
ace ends up
> > > > > in the locked state described earlier.
> > > > >
> > > > > This explains why we mostly observe the issue after redeployments=
 in our
> > > > > environment: server redeployments typically include iDRAC firmwar=
e updates
> > > > > or resets performed together with operating system installation o=
r updates.
> > > > >
> > > >
> > > > Thanks for the update. Do you have a dmesg log showing the problem =
with Rafael's
> > > > patch applied, by any chance ?
> > >
> > > [  740.004138] INFO: task alloy:8260 blocked for more than 122 second=
s.
> > > [  740.010752]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  740.019257] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  740.030103] task:alloy           state:D stack:0     pid:8260
> > > tgid:8260  ppid:1      task_flags:0x400100 flags:0x00080001
> > > [  740.045068] Call Trace:
> > > [  740.050334]  <TASK>
> > > [  740.055075]  __schedule+0x2b5/0x690
> > > [  740.062073]  schedule+0x23/0x80
> > > [  740.068081]  schedule_preempt_disabled+0x11/0x20
> > > [  740.074962]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  740.083073]  hwmon_attr_show+0x36/0x130
> > > [  740.089081]  dev_attr_show+0x19/0x60
> > > [  740.095876]  sysfs_kf_seq_show+0xbf/0x140
> > > [  740.102810]  seq_read_iter+0x112/0x510
> > > [  740.109070]  ? security_file_permission+0x8e/0xa0
> > > [  740.117100]  vfs_read+0x215/0x340
> > > [  740.123113]  ksys_read+0x61/0xe0
> > > [  740.130088]  do_syscall_64+0x5d/0xb40
> > > [  740.137032]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  740.144601] RIP: 0033:0x408d8e
> > > [  740.151070] RSP: 002b:000000c001cad498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  740.160825] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 00000=
00000408d8e
> > > [  740.170097] RDX: 0000000000000080 RSI: 000000c007c28880 RDI: 00000=
00000000022
> > > [  740.180085] RBP: 000000c001cad4d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  740.190074] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  740.201069] R13: 0000000000000040 R14: 000000c0058b1dc0 R15: fffff=
fffffffffff
> > > [  740.211072]  </TASK>
> > > [  740.215117] INFO: task alloy:8268 blocked for more than 123 second=
s.
> > > [  740.224109]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  740.234089] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  740.243611] task:alloy           state:D stack:0     pid:8268
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  740.258077] Call Trace:
> > > [  740.261260]  <TASK>
> > > [  740.266083]  __schedule+0x2b5/0x690
> > > [  740.273081]  schedule+0x23/0x80
> > > [  740.279055]  schedule_preempt_disabled+0x11/0x20
> > > [  740.286087]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  740.294074]  hwmon_attr_show+0x36/0x130
> > > [  740.300089]  dev_attr_show+0x19/0x60
> > > [  740.306074]  sysfs_kf_seq_show+0xbf/0x140
> > > [  740.313074]  seq_read_iter+0x112/0x510
> > > [  740.319075]  ? security_file_permission+0x8e/0xa0
> > > [  740.326064]  vfs_read+0x215/0x340
> > > [  740.331218]  ksys_read+0x61/0xe0
> > > [  740.337078]  do_syscall_64+0x5d/0xb40
> > > [  740.342083]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  740.349376] RIP: 0033:0x408d8e
> > > [  740.355086] RSP: 002b:000000c008403498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  740.365088] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00000=
00000408d8e
> > > [  740.375072] RDX: 0000000000000080 RSI: 000000c006a47d80 RDI: 00000=
0000000001f
> > > [  740.383669] RBP: 000000c0084034d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  740.393072] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  740.401326] R13: 0000000000000040 R14: 000000c005ea7880 R15: fffff=
fffffffffff
> > > [  740.411087]  </TASK>
> > > [  740.416089] INFO: task alloy:8270 blocked for more than 123 second=
s.
> > > [  740.425081]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  740.434091] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  740.444078] task:alloy           state:D stack:0     pid:8270
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  740.457108] Call Trace:
> > > [  740.462080]  <TASK>
> > > [  740.467073]  __schedule+0x2b5/0x690
> > > [  740.472252]  schedule+0x23/0x80
> > > [  740.478087]  schedule_preempt_disabled+0x11/0x20
> > > [  740.485099]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  740.491096]  hwmon_attr_show+0x36/0x130
> > > [  740.497082]  dev_attr_show+0x19/0x60
> > > [  740.503078]  sysfs_kf_seq_show+0xbf/0x140
> > > [  740.510030]  seq_read_iter+0x112/0x510
> > > [  740.516073]  ? security_file_permission+0x8e/0xa0
> > > [  740.523355]  vfs_read+0x215/0x340
> > > [  740.529077]  ksys_read+0x61/0xe0
> > > [  740.534925]  do_syscall_64+0x5d/0xb40
> > > [  740.540253]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  740.548077] RIP: 0033:0x408d8e
> > > [  740.553078] RSP: 002b:000000c0085cf498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  740.563075] RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00000=
00000408d8e
> > > [  740.572088] RDX: 0000000000000080 RSI: 000000c006d44f80 RDI: 00000=
0000000001b
> > > [  740.582076] RBP: 000000c0085cf4d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  740.591086] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  740.600086] R13: 0000000000000040 R14: 000000c005703c00 R15: 00000=
00000000054
> > > [  740.609481]  </TASK>
> > > [  740.614084] INFO: task alloy:8287 blocked for more than 123 second=
s.
> > > [  740.623089]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  740.632094] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  740.642083] task:alloy           state:D stack:0     pid:8287
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  740.656080] Call Trace:
> > > [  740.660694]  <TASK>
> > > [  740.665087]  __schedule+0x2b5/0x690
> > > [  740.671086]  schedule+0x23/0x80
> > > [  740.677080]  schedule_timeout+0xe8/0x100
> > > [  740.683134]  __wait_for_common+0x99/0x1c0
> >
> > So this is wait_for_completion(&tx_msg->tx_complete) in
> > acpi_ipmi_space_handler(), if I'm not mistaken, which never gets
> > completed, so stuff cannot make progress.
> >
> > I guess what happens is that one of the ACPI methods evaluated by the
> > acpi_power_meter driver trips on an IPMI operation region and locks up
> > because of the above.
> >
> > Did you, by any chance, upgrade the firmware in the time frame between
> > 6.17 and 6.18?
>
> I retested this now with the same firmware versions on both kernel
> lines: an iDRAC reset reliably triggers the issue on 6.18.y, while the
> same reproducer does not trigger any issue on 6.17.12.
>
> >
> > > [  740.690093]  ? __pfx_schedule_timeout+0x10/0x10
> > > [  740.697081]  acpi_ipmi_space_handler.part.0+0x1ac/0x370 [acpi_ipmi=
]
> > > [  740.706086]  acpi_ev_address_space_dispatch+0x16d/0x3c0
> > > [  740.713584]  ? __pfx_acpi_ipmi_space_handler+0x10/0x10 [acpi_ipmi]
> > > [  740.722080]  acpi_ex_access_region+0x5b/0xd0
> > > [  740.729078]  acpi_ex_write_serial_bus+0xb6/0x1e0
> > > [  740.736083]  acpi_ex_store_object_to_node+0x15e/0x200
> > > [  740.744083]  acpi_ex_opcode_1A_1T_1R+0x24c/0x620
> > > [  740.750088]  acpi_ds_exec_end_op+0x287/0x510
> > > [  740.757076]  acpi_ps_parse_loop+0xf6/0x680
> > > [  740.763177]  acpi_ps_parse_aml+0x17a/0x3d0
> > > [  740.770074]  acpi_ps_execute_method+0x137/0x270
> > > [  740.776256]  acpi_ns_evaluate+0x1f4/0x2e0
> > > [  740.783076]  acpi_evaluate_object+0x13c/0x2e0
> > > [  740.790118]  acpi_evaluate_integer+0x4f/0xe0
> > > [  740.796571]  ? obj_cgroup_charge_account+0x187/0x2d0
> > > [  740.804074]  update_meter+0x61/0xd0 [acpi_power_meter]
> > > [  740.811082]  power_meter_read+0x1ea/0x2c0 [acpi_power_meter]
> > > [  740.819088]  hwmon_attr_show+0x5e/0x130
> > > [  740.825093]  dev_attr_show+0x19/0x60
> > > [  740.830810]  sysfs_kf_seq_show+0xbf/0x140
> > > [  740.837076]  seq_read_iter+0x112/0x510
> > > [  740.843079]  ? security_file_permission+0x8e/0xa0
> > > [  740.849058]  vfs_read+0x215/0x340
> > > [  740.855086]  ksys_read+0x61/0xe0
> > > [  740.861058]  do_syscall_64+0x5d/0xb40
> > > [  740.866095]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  740.874104] RIP: 0033:0x408d8e
> > > [  740.880067] RSP: 002b:000000c007e81498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  740.890076] RAX: ffffffffffffffda RBX: 000000000000001d RCX: 00000=
00000408d8e
> > > [  740.900075] RDX: 0000000000000080 RSI: 000000c007383380 RDI: 00000=
0000000001d
> > > [  740.910080] RBP: 000000c007e814d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  740.918446] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  740.928087] R13: 0000000000000040 R14: 000000c00560ec40 R15: fffff=
fffffffffff
> > > [  740.937080]  </TASK>
> > > [  740.942085] INFO: task alloy:8463 blocked for more than 123 second=
s.
> > > [  740.951076]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  740.959660] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  740.970077] task:alloy           state:D stack:0     pid:8463
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  740.983108] Call Trace:
> > > [  740.987305]  <TASK>
> > > [  740.992084]  __schedule+0x2b5/0x690
> > > [  740.998077]  schedule+0x23/0x80
> > > [  741.003472]  schedule_preempt_disabled+0x11/0x20
> > > [  741.009738]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  741.017079]  hwmon_attr_show+0x36/0x130
> > > [  741.023094]  dev_attr_show+0x19/0x60
> > > [  741.029076]  sysfs_kf_seq_show+0xbf/0x140
> > > [  741.035084]  seq_read_iter+0x112/0x510
> > > [  741.039031]  ? security_file_permission+0x8e/0xa0
> > > [  741.045212]  vfs_read+0x215/0x340
> > > [  741.051081]  ksys_read+0x61/0xe0
> > > [  741.056076]  do_syscall_64+0x5d/0xb40
> > > [  741.061744]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  741.069081] RIP: 0033:0x408d8e
> > > [  741.074087] RSP: 002b:000000c006127498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  741.084107] RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00000=
00000408d8e
> > > [  741.093151] RDX: 0000000000000080 RSI: 000000c005b15b00 RDI: 00000=
00000000020
> > > [  741.103087] RBP: 000000c0061274d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  741.113084] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  741.123120] R13: 0000000000000040 R14: 000000c005ba1dc0 R15: fffff=
fffffffffff
> > > [  741.133093]  </TASK>
> > > [  741.138081] INFO: task alloy:8465 blocked for more than 124 second=
s.
> > > [  741.147085]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  741.155079] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  741.165084] task:alloy           state:D stack:0     pid:8465
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  741.178095] Call Trace:
> > > [  741.182595]  <TASK>
> > > [  741.187079]  __schedule+0x2b5/0x690
> > > [  741.193014]  schedule+0x23/0x80
> > > [  741.199071]  schedule_preempt_disabled+0x11/0x20
> > > [  741.206102]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  741.214091]  hwmon_attr_show+0x36/0x130
> > > [  741.221079]  dev_attr_show+0x19/0x60
> > > [  741.226081]  sysfs_kf_seq_show+0xbf/0x140
> > > [  741.232083]  seq_read_iter+0x112/0x510
> > > [  741.237943]  ? security_file_permission+0x8e/0xa0
> > > [  741.245080]  vfs_read+0x215/0x340
> > > [  741.251080]  ksys_read+0x61/0xe0
> > > [  741.257068]  do_syscall_64+0x5d/0xb40
> > > [  741.262084]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  741.270083] RIP: 0033:0x408d8e
> > > [  741.275229] RSP: 002b:000000c007e85498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  741.285086] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00000=
00000408d8e
> > > [  741.294078] RDX: 0000000000000080 RSI: 000000c0066a5180 RDI: 00000=
0000000001e
> > > [  741.304078] RBP: 000000c007e854d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  741.313085] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  741.323084] R13: 0000000000000040 R14: 000000c0040f8fc0 R15: fffff=
fffffffffff
> > > [  741.333078]  </TASK>
> > > [  741.337087] INFO: task alloy:8470 blocked for more than 124 second=
s.
> > > [  741.346079]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  741.355091] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  741.365102] task:alloy           state:D stack:0     pid:8470
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  741.378081] Call Trace:
> > > [  741.383127]  <TASK>
> > > [  741.388089]  __schedule+0x2b5/0x690
> > > [  741.394085]  schedule+0x23/0x80
> > > [  741.400084]  schedule_preempt_disabled+0x11/0x20
> > > [  741.408085]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  741.415246]  hwmon_attr_show+0x36/0x130
> > > [  741.422088]  dev_attr_show+0x19/0x60
> > > [  741.428079]  sysfs_kf_seq_show+0xbf/0x140
> > > [  741.434088]  seq_read_iter+0x112/0x510
> > > [  741.440075]  ? security_file_permission+0x8e/0xa0
> > > [  741.446661]  vfs_read+0x215/0x340
> > > [  741.452104]  ksys_read+0x61/0xe0
> > > [  741.458082]  do_syscall_64+0x5d/0xb40
> > > [  741.464083]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  741.471412] RIP: 0033:0x408d8e
> > > [  741.477072] RSP: 002b:000000c007369498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  741.487081] RAX: ffffffffffffffda RBX: 0000000000000021 RCX: 00000=
00000408d8e
> > > [  741.496078] RDX: 0000000000000080 RSI: 000000c005cff500 RDI: 00000=
00000000021
> > > [  741.506094] RBP: 000000c0073694d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  741.515087] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  741.525084] R13: 0000000000000040 R14: 000000c001db6c40 R15: fffff=
fffffffffff
> > > [  741.534086]  </TASK>
> > > [  741.539094] INFO: task alloy:8474 blocked for more than 124 second=
s.
> > > [  741.548092]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  741.557097] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  741.567095] task:alloy           state:D stack:0     pid:8474
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  741.581079] Call Trace:
> > > [  741.586087]  <TASK>
> > > [  741.591162]  __schedule+0x2b5/0x690
> > > [  741.597103]  schedule+0x23/0x80
> > > [  741.603109]  schedule_preempt_disabled+0x11/0x20
> > > [  741.610098]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  741.617086]  hwmon_attr_show+0x36/0x130
> > > [  741.623137]  dev_attr_show+0x19/0x60
> > > [  741.629087]  sysfs_kf_seq_show+0xbf/0x140
> > > [  741.635090]  seq_read_iter+0x112/0x510
> > > [  741.641083]  ? security_file_permission+0x8e/0xa0
> > > [  741.648095]  vfs_read+0x215/0x340
> > > [  741.654101]  ksys_read+0x61/0xe0
> > > [  741.660087]  do_syscall_64+0x5d/0xb40
> > > [  741.666090]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  741.672343] RIP: 0033:0x408d8e
> > > [  741.678083] RSP: 002b:000000c000b03498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  741.688096] RAX: ffffffffffffffda RBX: 0000000000000025 RCX: 00000=
00000408d8e
> > > [  741.698084] RDX: 0000000000000080 RSI: 000000c0069df000 RDI: 00000=
00000000025
> > > [  741.706728] RBP: 000000c000b034d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  741.716084] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  741.725093] R13: 0000000000000040 R14: 000000c004075340 R15: fffff=
fffffffffff
> > > [  741.735124]  </TASK>
> > > [  741.737900] INFO: task alloy:8726 blocked for more than 124 second=
s.
> > > [  741.747088]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  741.756086] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  741.766111] task:alloy           state:D stack:0     pid:8726
> > > tgid:8260  ppid:1      task_flags:0x400140 flags:0x00080001
> > > [  741.780116] Call Trace:
> > > [  741.785093]  <TASK>
> > > [  741.790100]  __schedule+0x2b5/0x690
> > > [  741.796596]  schedule+0x23/0x80
> > > [  741.802109]  schedule_preempt_disabled+0x11/0x20
> > > [  741.809091]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  741.815262]  hwmon_attr_show+0x36/0x130
> > > [  741.822096]  dev_attr_show+0x19/0x60
> > > [  741.828105]  sysfs_kf_seq_show+0xbf/0x140
> > > [  741.834088]  seq_read_iter+0x112/0x510
> > > [  741.839547]  ? security_file_permission+0x8e/0xa0
> > > [  741.846570]  vfs_read+0x215/0x340
> > > [  741.850048] perf: interrupt took too long (2993 > 2500), lowering
> > > kernel.perf_event_max_sample_rate to 66000
> > > [  741.863112]  ksys_read+0x61/0xe0
> > > [  741.868778]  do_syscall_64+0x5d/0xb40
> > > [  741.875104]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  741.883101] RIP: 0033:0x408d8e
> > > [  741.888436] RSP: 002b:000000c0085cb498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  741.898081] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 00000=
00000408d8e
> > > [  741.907092] RDX: 0000000000000080 RSI: 000000c006424e00 RDI: 00000=
00000000024
> > > [  741.917092] RBP: 000000c0085cb4d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  741.926087] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  741.936089] R13: 0000000000000040 R14: 000000c00565aa80 R15: fffff=
fffffffffff
> > > [  741.945098]  </TASK>
> > > [  862.885552] INFO: task alloy:8260 blocked for more than 245 second=
s.
> > > [  862.892117]       Tainted: G            E       6.18.8-1.gdc.el9.x=
86_64 #1
> > > [  862.904592] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  862.914632] task:alloy           state:D stack:0     pid:8260
> > > tgid:8260  ppid:1      task_flags:0x400100 flags:0x00080001
> > > [  862.928478] Call Trace:
> > > [  862.932477]  <TASK>
> > > [  862.938482]  __schedule+0x2b5/0x690
> > > [  862.944502]  schedule+0x23/0x80
> > > [  862.949478]  schedule_preempt_disabled+0x11/0x20
> > > [  862.955487]  __mutex_lock.constprop.0+0x3c9/0xa00
> > > [  862.962489]  hwmon_attr_show+0x36/0x130
> > > [  862.968485]  dev_attr_show+0x19/0x60
> > > [  862.974482]  sysfs_kf_seq_show+0xbf/0x140
> > > [  862.981517]  seq_read_iter+0x112/0x510
> > > [  862.987485]  ? security_file_permission+0x8e/0xa0
> > > [  862.994505]  vfs_read+0x215/0x340
> > > [  863.000295]  ksys_read+0x61/0xe0
> > > [  863.006484]  do_syscall_64+0x5d/0xb40
> > > [  863.013226]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  863.021497] RIP: 0033:0x408d8e
> > > [  863.027499] RSP: 002b:000000c001cad498 EFLAGS: 00000206 ORIG_RAX:
> > > 0000000000000000
> > > [  863.037483] RAX: ffffffffffffffda RBX: 0000000000000022 RCX: 00000=
00000408d8e
> > > [  863.047483] RDX: 0000000000000080 RSI: 000000c007c28880 RDI: 00000=
00000000022
> > > [  863.057487] RBP: 000000c001cad4d8 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  863.066499] R10: 0000000000000000 R11: 0000000000000206 R12: 00000=
00000000000
> > > [  863.076485] R13: 0000000000000040 R14: 000000c0058b1dc0 R15: fffff=
fffffffffff
> > > [  863.087007]  </TASK>
> > >
> > >
> > > >
> > > > Thanks,
> > > > Guenter
> > > >
> > >

I was able to bisect to first bad commit

$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect good e5f0a698b34ed76002dc5cff3804a61c80233a7a
# status: waiting for bad commit, 1 good commit known
# bad: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
git bisect bad 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
# bad: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag
'media/v6.18-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad f79e772258df311c2cb21594ca0996318e720d28
# bad: [0f048c878ee32a4259dbf28e0ad8fd0b71ee0085] Merge tag
'soc-dt-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 0f048c878ee32a4259dbf28e0ad8fd0b71ee0085
# good: [c050daf69f3edf72e274eaa321f663b1779c4391] Merge tag
'pwm/for-6.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux
git bisect good c050daf69f3edf72e274eaa321f663b1779c4391
# bad: [9792d660a4e91d31a6b1af105ae3f1c29107e94b] Merge tag
'devicetree-for-6.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad 9792d660a4e91d31a6b1af105ae3f1c29107e94b
# good: [f07c3695bf65220a69a848478bd9099bdeaafa78] Merge tag
'firewire-updates-6.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394
git bisect good f07c3695bf65220a69a848478bd9099bdeaafa78
# bad: [080ffb4bec4d49cdedca11810395f8cad812471e] Merge tag
'i3c/for-6.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
git bisect bad 080ffb4bec4d49cdedca11810395f8cad812471e
# good: [da3a88e9656c17a34daf49c9acc6d85f73b4d3d9] pinctrl: use more
common syntax for compound literals
git bisect good da3a88e9656c17a34daf49c9acc6d85f73b4d3d9
# bad: [5fb024931949f3475260c84a0e4b0997af9c5530] Merge tag
'pinctrl-v6.18-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 5fb024931949f3475260c84a0e4b0997af9c5530
# good: [cc3e883a06251ba835f15672dbe8724f2687971b] power: supply:
qcom_battmgr: Add charge control support
git bisect good cc3e883a06251ba835f15672dbe8724f2687971b
# bad: [d46651d4e3c0caab554c4c591c0b6c3b026b1e93] ipmi: Add
Loongson-2K BMC support
git bisect bad d46651d4e3c0caab554c4c591c0b6c3b026b1e93
# good: [627118470fccc61d7763aa667fcab0a9476843f6] ipmi: Add a
maintenance mode sysfs file
git bisect good 627118470fccc61d7763aa667fcab0a9476843f6
# good: [abe4918a942e17f997f62b1e12bc8a15d8ff5f7e] ipmi:si: Move flags
get start to its own function
git bisect good abe4918a942e17f997f62b1e12bc8a15d8ff5f7e
# good: [3bc54ab3b9790ca92f197e9822e486665daa321c] ipmi: Rename
"user_data" to "recv_msg" in an SMI message
git bisect good 3bc54ab3b9790ca92f197e9822e486665daa321c
# bad: [bc3a9d217755f65c137f145600f23bf1d6c31ea9] ipmi:si: Gracefully
handle if the BMC is non-functional
git bisect bad bc3a9d217755f65c137f145600f23bf1d6c31ea9
# first bad commit: [bc3a9d217755f65c137f145600f23bf1d6c31ea9]
ipmi:si: Gracefully handle if the BMC is non-functional

...
$ git bisect bad
bc3a9d217755f65c137f145600f23bf1d6c31ea9 is the first bad commit
commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 (HEAD)
Author: Corey Minyard <corey@minyard.net>
Date:   Wed Aug 20 14:56:50 2025 -0500

    ipmi:si: Gracefully handle if the BMC is non-functional

    If the BMC is not functional, the driver goes into an error state and
    starts a 1 second timer.  When the timer times out, it will attempt a
    simple message.  If the BMC interacts correctly, the driver will start
    accepting messages again.  If not, it remains in error state.

    If the driver goes into error state, all messages current and pending
    will return with an error.

    This should more gracefully handle when the BMC becomes non-operational=
,
    as opposed to trying each messages individually and failing them.

    Signed-off-by: Corey Minyard <corey@minyard.net>

 drivers/char/ipmi/ipmi_si_intf.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

