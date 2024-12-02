Return-Path: <linux-acpi+bounces-9893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1129E0E42
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2459B282556
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660F1DF747;
	Mon,  2 Dec 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/4G0Rx+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEB1DF73E;
	Mon,  2 Dec 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176665; cv=none; b=q+fLzpD80/HdYHa1MzAx5su6xWXkXCXZ3zqBU6mpOYZxVQ5A0HDmMVP9yAR76jCydi724uR4ePWXpue6qRm3uccZZqNgyp0RlfoUgMC/BUOpHGAeCsLZA9hf5IOkEjzeoTLmKVHeHD1v8BrZdzyEk/M8EF8cYlJw+AOnZF8ECFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176665; c=relaxed/simple;
	bh=RFvp6yN6jBhOnl9yNX5r6yOEdmP0gF9huWIWIJu8HwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MP+lI7v7kCLaucl3iruUtvudTyXSVGbxd/wIUHyNrNqKEf96aZNmD/h6lVkK1ScFh5HEnpfSAxaus8cTHmEmYfWJdpRkHqrSKnv362sNxtJ3imFLgoF80SNE3eiRhpy408Hpya5en6kVLmfr25rbycxCY6/uuonXccJomLPFheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/4G0Rx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61C1C4AF09;
	Mon,  2 Dec 2024 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733176664;
	bh=RFvp6yN6jBhOnl9yNX5r6yOEdmP0gF9huWIWIJu8HwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f/4G0Rx+gKZ9GabpY6Zj/SHP2Wz2sJQrf2sWAMF/Zc7scxDuK7AZ2DnRAfJgGwZE1
	 GbnHIiKzNOMmNad/8coPkm1QPOBtSUymVIuSaP3oNNgzm6+iS9gJhZXMJA8nsZVR4m
	 KW7wTJpKNP2FioPpKh17fHUSTbiMcT3OZHk7b0SgkJrR0RSkPgW/sWP75xelEEZ5X+
	 bZJvAzmrGlaasL0/tNHPZv915QZ/LMmGc2TTgqZ9f3KDBsuSXtKFzOqhoD4VuiKdVj
	 E+J0+9fl5L1as3mExe0kQKgTWAZTnR8VYuL/tm61XqgVYh5LECdMRvrmpVdYLVGClt
	 nJ5lNhT8OkKsg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29e579b9e9aso1221335fac.1;
        Mon, 02 Dec 2024 13:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUS3WMlUK+CVNLNvvZCU558xVct3Z6lpsfTqMnYZOYe974LOoHLPxN6d6F9pWXxmJHLSNtenCEQEda68v2v@vger.kernel.org, AJvYcCW7h9yZTzkwxJd+RQJ2IGd7Jh+h4tv9D8oOk4Co/McBiD6jIk/bt7WvbsofhWx5S0TdhoBZgAFGbxT/@vger.kernel.org, AJvYcCXNL4Pgji0yXJWNuXdoXkD+VzrE/nL6mOu9mcD6mgbImGqPudXuSIdh2eP8nK3ta6DNhNQOaztqzzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTa8O/TdYkSq4KUdFoQqYvxcTWveVAgvkRYTdvYnktg4i5BlXa
	zHupG/rguu2AoxEATCdNciHV5Pv2oixwA2B+ewK/23oCdQwkfzGus9jy8faINjBXnsipdCjivX6
	hmJwkcdVa7xQ0ULlLsIDCJnz2Y0Q=
X-Google-Smtp-Source: AGHT+IGjT7UhCSlQzCRqiK0vAEcWrtduRuURyCC4FER6z2SA9H1hptDouJ1MiN3IqqnHRP30af/ixc415L8ntrISDkg=
X-Received: by 2002:a05:6870:af0a:b0:29e:559b:d6a0 with SMTP id
 586e51a60fabf-29e885808bemr16554fac.2.1733176663925; Mon, 02 Dec 2024
 13:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5839859.DvuYhMxLoT@rjwysocki.net> <e7ac7561-f9ff-406a-b2d7-6d9e31ed6e98@amd.com>
 <CAJZ5v0jTxBt8+bc+EgUZmE84N+Vok_aM16D8HyLQUv=BSoqRCw@mail.gmail.com> <35873f78-4935-492e-a9fe-ef06c1b2d0f4@amd.com>
In-Reply-To: <35873f78-4935-492e-a9fe-ef06c1b2d0f4@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Dec 2024 22:57:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLtbixTDEeKrEb5m6VjEn6oeXJJDSOTTrcvFe5EEf-gA@mail.gmail.com>
Message-ID: <CAJZ5v0gLtbixTDEeKrEb5m6VjEn6oeXJJDSOTTrcvFe5EEf-gA@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:54=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/22/2024 13:27, Rafael J. Wysocki wrote:
> > On Thu, Nov 21, 2024 at 11:27=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 11/21/2024 07:15, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> As stated by Len in [1], the extra delay added by msleep() to the
> >>> sleep time value passed to it can be significant, roughly between
> >>> 1.5 ns on systems with HZ =3D 1000 and as much as 15 ms on systems wi=
th
> >>> HZ =3D 100, which is hardly acceptable, at least for small sleep time
> >>> values.
> >>>
> >>> Address this by using usleep_range() in acpi_os_sleep() instead of
> >>> msleep().  For short sleep times this is a no-brainer, but even for
> >>> long sleeps usleep_range() should be preferred because timer wheel
> >>> timers are optimized for cancellation before they expire and this
> >>> particular timer is not going to be canceled.
> >>>
> >>> Add at least 50 us on top of the requested sleep time in case the
> >>> timer can be subject to coalescing, which is consistent with what's
> >>> done in user space in this context [2], but for sleeps longer than 5 =
ms
> >>> use 1% of the requested sleep time for this purpose.
> >>>
> >>> The rationale here is that longer sleeps don't need that much of a ti=
mer
> >>> precision as a rule and making the timer a more likely candidate for
> >>> coalescing in these cases is generally desirable.  It starts at 5 ms =
so
> >>> that the delta between the requested sleep time and the effective
> >>> deadline is a contiuous function of the former.
> >>>
> >>> Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf=
46477a2d73.1731708405.git.len.brown@intel.com/ [1]
> >>> Link: https://lore.kernel.org/linux-pm/CAJvTdK=3DQ1kwWA6Wxn8Zcf0OicDE=
k6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
> >>> Reported-by: Len Brown <lenb@kernel.org>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> You probably should also pick up this tag from the earlier version.
> >>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> >
> > Good point.
> >
> >>> ---
> >>>
> >>> This is a follow-up to the discussion started by [1] above and since
> >>> the beginning of it I have changed my mind a bit, as you can see.
> >>>
> >>> Given Arjan's feedback, I've concluded that using usleep_range() for
> >>> all sleep values is the right choice and that some slack should be
> >>> used there.  I've taken 50 us as the minimum value of it because that=
's
> >>> what is used in user space FWICT and I'm not convinced that shorter
> >>> values would be suitable here.
> >>>
> >>> The other part, using 1% of the sleep time as the slack for longer
> >>> sleeps, is likely more controversial.  It is roughly based on the
> >>> observation that if one timer interrupt is sufficient for something,
> >>> then using two of them will be wasteful even if this is just somewhat=
.
> >>>
> >>> Anyway, please let me know what you think.  I'd rather do whatever
> >>> the majority of you are comfortable with.
> >>
> >> Generally I'm fine with this.
> >>
> >> I'm about to head on US holiday, but I will forward this to folks that
> >> aren't and get some testing input on it to bring back later when I'm b=
ack.
> >
> > Thanks!
>
> Hi Rafael,
>
> I loaded this onto my personal laptop before the holiday and also got
> others in AMD to do testing on a wider variety of client hardware.
> No concerns were raised with this patch.
>
> Feel free to include:
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you!

