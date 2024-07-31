Return-Path: <linux-acpi+bounces-7169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00194320B
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E4F1F25C44
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90F1BB6AC;
	Wed, 31 Jul 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcU1/CDC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E571BBBC1;
	Wed, 31 Jul 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436342; cv=none; b=ViODdupOZPA+MCXkolcHFa0/jpwmQk2ArdaFa+IFEQY/nywj/w76bBaYlF1Upt56eb1At5ik+0VhXH2Y+m6Xqkrd+OWi2C10E4/r2L4g7ruwJ2lZW1V4myBv+Jas2JbRmyhOLG4tJkpD9Bryrd6zUZ/iOyGc+hT/Z/8L1yoLYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436342; c=relaxed/simple;
	bh=KgJyeoelKhXsq6qgvciyvzOwPuIVE24oAsXBYIEN8NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPrCYNn99HW+XXHl0fR98hvZ2F9y2aerY2jJKZuZg9OsfD1zFGZIRHTFzB17N2e7XFwbR2Dps+1qIPk7TRMlBQOPjJ9Sy9mA4Hqk/qpFJMCF3nQ/0n6tuGAx+c9OZG/JaESCzx7UXUwqgeaYzRaNL8jW89J+FZfLRa1j60QRYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcU1/CDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE08C116B1;
	Wed, 31 Jul 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722436342;
	bh=KgJyeoelKhXsq6qgvciyvzOwPuIVE24oAsXBYIEN8NY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fcU1/CDCm+CKPqKOSkNtK5LtgyNUVHjwmVRWYky5MoQ7wkvXbVgwwLAcmDDmWKvrE
	 Kdy9NNIG0cRYwAY37Pwhxp6KvUPxZlCtwV+hPZNn5TpFacn8nQV11S4hVOvDtPSRIq
	 8hBhHdQQ/3UVk9r6XWpjkT+5sJSiHAsE/GhA/Ynhdjt9W3ODgdA/v1OoA5BY1q3woN
	 3Z8zv5tlH+Gu4OMelvsWJz4xiP2GOePgaZizE/nmmyzDdNdHMG5b0AIaw04h+PUPPJ
	 mIULf4KuwJJx+HLv52sIOAuxD4vWQefb2i00s0Ol/pj/WZoSnevjLz1BgqZWe7+8kD
	 C6N8PpoQvCyMg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5bafd2c42so468589eaf.2;
        Wed, 31 Jul 2024 07:32:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1hs8TM8Zd8XVfT//jAaTAZlrIDSlZVXEMMmuycFqBbSM+/x0y8qlvrGbFqzcA+7rmgo67Vgh0umOmn19n45oVZ1HMa8S4i0fWyH0DIbVWIQvwWb79vhYOQhzSZaOOxdgGRqLQxUmDbwFQkfak7h+kyZ22aTqPkwPpylON59kLd4Dftvj3fszZkWgYwvAuT6wFlsrydkvWaa4h
X-Gm-Message-State: AOJu0Yx48kA+z0cibBZ7JVjCPW8jIaPBlKy+VzO2aFlHMfsmZh0uA/G/
	IpvJYmWfhCrTxbGmMWqQvf8tJNt/NOoSy0iNMh1AywBV8ke2yb8+WUiRoP4ElNyuHClWpM29EB0
	l1jTNVmaWKIS1bycULg3G+cXOhGE=
X-Google-Smtp-Source: AGHT+IGC79vQI8gKkKMLbf5Z2nk0fsL4RPtGcqnkOCJHg3r38IP5gYjvd0iMmESMbIzUUvEYjYDElbTrm8FgZCsWIMY=
X-Received: by 2002:a05:687c:2c19:b0:259:f03c:4e90 with SMTP id
 586e51a60fabf-264a35d1c79mr12193987fac.4.1722436341440; Wed, 31 Jul 2024
 07:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <9002154.VV5PYv0bhD@rjwysocki.net>
 <ZqoxXdQRxhfr5cHY@shredder.mtl.com> <CAJZ5v0h7T27fcL5-Wp5cjxi7mqKVh3_jk-8KwXPGWRbO31sm7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7T27fcL5-Wp5cjxi7mqKVh3_jk-8KwXPGWRbO31sm7Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jul 2024 16:32:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX+HyNB5Xqwr6Q44rgAThNLqp5PUQXN-uTC+cDqdjpqA@mail.gmail.com>
Message-ID: <CAJZ5v0hX+HyNB5Xqwr6Q44rgAThNLqp5PUQXN-uTC+cDqdjpqA@mail.gmail.com>
Subject: Re: [PATCH v1 13/17] mlxsw: core_thermal: Use the .should_bind()
 thermal zone callback
To: Ido Schimmel <idosch@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000047dd61061e8bf630"

--00000000000047dd61061e8bf630
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 2:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> =
wrote:
> >
> > On Tue, Jul 30, 2024 at 08:34:45PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Make the mlxsw core_thermal driver use the .should_bind() thermal zon=
e
> > > callback to provide the thermal core with the information on whether =
or
> > > not to bind the given cooling device to the given trip point in the
> > > given thermal zone.  If it returns 'true', the thermal core will bind
> > > the cooling device to the trip and the corresponding unbinding will b=
e
> > > taken care of automatically by the core on the removal of the involve=
d
> > > thermal zone or cooling device.
> > >
> > > It replaces the .bind() and .unbind() thermal zone callbacks (in 3
> > > places) which assumed the same trip points ordering in the driver
> > > and in the thermal core (that may not be true any more in the
> > > future).  The .bind() callbacks used loops over trip point indices
> > > to call thermal_zone_bind_cooling_device() for the same cdev (once
> > > it had been verified) and all of the trip points, but they passed
> > > different 'upper' and 'lower' values to it for each trip.
> > >
> > > To retain the original functionality, the .should_bind() callbacks
> > > need to use the same 'upper' and 'lower' values that would be used
> > > by the corresponding .bind() callbacks when they are about about to
> >
> > Nit: s/about about/about/
>
> Yes, thanks!
>
> > > return 'true'.  To that end, the 'priv' field of each trip is set
> > > during the thermal zone initialization to point to the corresponding
> > > 'state' object containing the maximum and minimum cooling states of
> > > the cooling device.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Please see more comments below, but this patch is going to conflict wit=
h
> > the series at [1] which is currently under review. How do you want to
> > handle that?
> >
> > https://lore.kernel.org/netdev/cover.1722345311.git.petrm@nvidia.com/
>
> I may be missing something, but I don't see conflicts between this
> patch and the series above that would be hard to resolve at merge
> time.
>
> Anyway, I'll try to apply the above series locally and merge it with
> this patch, thanks for the heads up!

So there is only one merge conflict that's straightforward to resolve
(as far as I'm concerned).  My resolution of it is attached, FWIW.

In my view the changes in the series above and this patch are mostly
independent of each other.

Thanks!

--00000000000047dd61061e8bf630
Content-Type: text/x-patch; charset="US-ASCII"; name="merge.patch"
Content-Disposition: attachment; filename="merge.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz9y1cmo0>
X-Attachment-Id: f_lz9y1cmo0

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3L2NvcmVfdGhlcm1h
bC5jCmluZGV4IDMwM2QyY2U0ZGMxZSwwYzUwYTBjYzMxNmQuLmU3NDZjZDljNjhlZAotLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9jb3JlX3RoZXJtYWwuYworKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9jb3JlX3RoZXJtYWwuYwpAQEAgLTQ1
MCw4IC0zODksMTIgKzM4OCw5IEBAQCBtbHhzd190aGVybWFsX21vZHVsZV9pbml0KHN0cnVjdCBt
bHhzd18KICAJCQkgIHN0cnVjdCBtbHhzd190aGVybWFsX2FyZWEgKmFyZWEsIHU4IG1vZHVsZSkK
ICB7CiAgCXN0cnVjdCBtbHhzd190aGVybWFsX21vZHVsZSAqbW9kdWxlX3R6OworIAlpbnQgaTsK
ICAKICAJbW9kdWxlX3R6ID0gJmFyZWEtPnR6X21vZHVsZV9hcnJbbW9kdWxlXTsKIC0JLyogU2tp
cCBpZiBwYXJlbnQgaXMgYWxyZWFkeSBzZXQgKGNhc2Ugb2YgcG9ydCBzcGxpdCkuICovCiAtCWlm
IChtb2R1bGVfdHotPnBhcmVudCkKIC0JCXJldHVybjsKICAJbW9kdWxlX3R6LT5tb2R1bGUgPSBt
b2R1bGU7CiAgCW1vZHVsZV90ei0+c2xvdF9pbmRleCA9IGFyZWEtPnNsb3RfaW5kZXg7CiAgCW1v
ZHVsZV90ei0+cGFyZW50ID0gdGhlcm1hbDsKQEBAIC00NjEsOCAtNDA0LDggKzQwMCwxMCBAQEAK
ICAJICAgICAgIHNpemVvZih0aGVybWFsLT50cmlwcykpOwogIAltZW1jcHkobW9kdWxlX3R6LT5j
b29saW5nX3N0YXRlcywgZGVmYXVsdF9jb29saW5nX3N0YXRlcywKICAJICAgICAgIHNpemVvZih0
aGVybWFsLT5jb29saW5nX3N0YXRlcykpOworIAlmb3IgKGkgPSAwOyBpIDwgTUxYU1dfVEhFUk1B
TF9OVU1fVFJJUFM7IGkrKykKKyAJCW1vZHVsZV90ei0+dHJpcHNbaV0ucHJpdiA9ICZtb2R1bGVf
dHotPmNvb2xpbmdfc3RhdGVzW2ldOwogKwogKwlyZXR1cm4gbWx4c3dfdGhlcm1hbF9tb2R1bGVf
dHpfaW5pdChtb2R1bGVfdHopOwogIH0KICAKICBzdGF0aWMgdm9pZCBtbHhzd190aGVybWFsX21v
ZHVsZV9maW5pKHN0cnVjdCBtbHhzd190aGVybWFsX21vZHVsZSAqbW9kdWxlX3R6KQo=
--00000000000047dd61061e8bf630--

