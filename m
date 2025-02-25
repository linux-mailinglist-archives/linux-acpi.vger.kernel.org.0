Return-Path: <linux-acpi+bounces-11443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B939A43305
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 03:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F293B8764
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 02:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70591369A8;
	Tue, 25 Feb 2025 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="csnxFQFH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40138DD1;
	Tue, 25 Feb 2025 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450399; cv=none; b=dM6f8q8ckRAB+cZnr5H50qfJG2k3rD1dGo1MRfbtjWWaxZt/jtpNsJaTo19IMVTnSi72K9XBfw3d1fEyHdmOvu5EtVcsO9vMYYj6ZnJI70Lc4Xe5caGtduC8wv67v5BBGdD4R9vjlC/e8T1kIf4wEjUSd4AmcN/ylJcC53QqnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450399; c=relaxed/simple;
	bh=2/S8GzGGp1EAO+ei0U1YohUwTWYIkHcGYkFZnxQKYHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW74mPGHOA+cwjJBJxMo+xD3/MDKJEF/swf0IYqVM8bNm/AoEX+zfU6us387XvS6uDuW73Hybx0OGRxaASClo58TLp5wimVaEoUjBLegSC3+3TBT5oavTYiHbY/vAg/wLYFV5RSf6EUUG2KasTH/TpmM82BHK1YPeqCLvNVZQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=csnxFQFH; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 81A1F2E09903;
	Tue, 25 Feb 2025 04:26:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740450393;
	bh=6yEMucTT/8r8Bz/V5khjoFIdTDerWe8lwET5bE8j/EE=;
	h=Received:From:Subject:To;
	b=csnxFQFHEn5g4APMEJ/PX0g24nzJkFDLawHS+UolJ/Or1DUrZ9DfoIw+zRsmo/hTQ
	 oDvq6/Up5wU3HfLKb/cc3F2ekb42WngBb82UOvHW3Gjq8O7OJ3TlFio7j+g12httZN
	 P0lh+XnVVC8gWDVQgpYH4PuS+8dNagKp+LLeRFtQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3076262bfc6so52757881fa.3;
        Mon, 24 Feb 2025 18:26:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ZQ7RpqOTR3lfX4hUrTblqh3NUBaVzCXQfLy9U5JFE4CaZQ6a8QnoduNupg5IpF3w/BZQ8L+8vxAphto9vyNqmAW2VQ==@vger.kernel.org,
 AJvYcCVUtH+BSDIm2geSVOJv8VEsAPNKnJtUYVlGglvaoNBSAj0AfhtHU1X8N0aMn7b92Oi92TO1PVQjsoQJ@vger.kernel.org,
 AJvYcCXRBSQ/yMXmQwDD5IquqXpSJ/c6gL/asjT+C+MtAHTezPqwwY4la9yfEpQsXxckDu2x/Vmpl7GVhkDXt2Ob@vger.kernel.org
X-Gm-Message-State: AOJu0YwbvEEk63fpchMFhfb0wgHpc+7UWy6uk3574jsheQeOpWhr88E/
	AK1woA8gVU5v/sgX8VNFO6LeIqpuqLUTySDp6GaTz02+GLu27MaV4tZV67QANDDKlcf5Jpg2z+c
	eIxVPD8c7j8ZPNcjG2MTRvaUbcKU=
X-Google-Smtp-Source: 
 AGHT+IEbXET/HeVji31Gvbtzv5tRJY7nNQJckddbQXpoONn6VU1fmF8l63k5Lxzn5lzxvTrreXukJoOVfuteMWOjiYU=
X-Received: by 2002:a2e:9c93:0:b0:306:10d6:28b3 with SMTP id
 38308e7fff4ca-30a80be1ea7mr4923701fa.1.1740450391735; Mon, 24 Feb 2025
 18:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <f5d39d3c932a78a5021877230c212c620edc586e.camel@ljones.dev>
In-Reply-To: <f5d39d3c932a78a5021877230c212c620edc586e.camel@ljones.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Feb 2025 03:26:19 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEWZxWzcTjPby4OeUz+CCXbvQAkvCExo-Qc7=r-0-6BCg@mail.gmail.com>
X-Gm-Features: AWEUYZnmKp-5xyz2Myjf507XBlyebUKTN9ik_I7tNguo3Uj-baR5tj5C16NcIbo
Message-ID: 
 <CAGwozwEWZxWzcTjPby4OeUz+CCXbvQAkvCExo-Qc7=r-0-6BCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Luke Jones <luke@ljones.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174045039299.26735.16345396436918484116@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> If these "scripts" use `platform_profile_choices` to get their
> selections and verify they are available then there should be zero
> breakage. If they don't then they should be updated to be correct.

Yeah, if any Asus users wrote scripts for their laptops to e.g., "echo
quiet | sudo tee /sys/firmware/acpi/platform_profile" or used TLP let
them spend a few days finding out why kernel 6.14 does not work. They
should have written a 300 line bash script instead.

> In any case I am in the process of finalising an update to use the new
> platform_profile API including "custom". Please don't begin trying to
> break things just to be "first". My work has been ongoing for this

 drivers/acpi/platform_profile.c    | 57 +++++++++++++++++++++++++-----
 drivers/platform/x86/amd/pmf/spc.c |  3 ++
 drivers/platform/x86/amd/pmf/sps.c |  8 +++++
 include/linux/platform_profile.h   |  7 ++++

I do not see the name Asus here. This is a compatibility patch. You
should try it before commenting on it further. Looking at my ACPI
database, there are at least a few Ayaneos, GPDs, and Legion laptops
that have the ACPI bindings for pmf, this is not an Asus issue.

By the way, I have merged your patch series on Bazzite (well... a
cleaned up version that does not happen to crash your own software...)
and it happens to work fine with this patch (I know you said platform
profiles are not in yet). I still use the asus-wmi APIs personally.

sudo fwupdmgr get-bios-setting
Authenticating=E2=80=A6          [ -                                     ]
ppt_pl3_fppt:
  Setting type:         Integer
  Current Value:        80
  Description:          Set the CPU slow package limit
  Read Only:            False
  Minimum value:        5
...

> in my spare time for months.

Let me comment on this a bit further. Hobbies are good to have and it
is nice you found one you like. However, a lot of people are spending
a lot of money on their Asus laptops and are actually starting to
depend on Linux. If they cannot depend on you or your hobby for
support, you should at least make sure to not interfere with parallel
efforts for that support, if not try to be synergistic.

I did not make this patch to one up you or rush it. This issue is a
blocker for deploying our 6.13 kernel. Since this kernel needs to work
for the Z13 and pmf quirks are dead ends now (I also got annoyed by
asus users complaining about their fan curves being wrong because pmf
blew up), I pulled in Mario's platform profile series early, only to
find this issue. Botching the asus-wmi platform handler did not meet
my standards, so I had to make this series. Also, since I could not
pull in Kurk's series, and his changes were extensive, I had to make
this series twice, and test it twice.

Good news is this series works and the kernel is on its way to be
deployed in a few days. Flatpak fix came in clutch today too with
6.13.4.

Antheas

