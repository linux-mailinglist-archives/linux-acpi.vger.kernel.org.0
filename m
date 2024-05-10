Return-Path: <linux-acpi+bounces-5757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC38C29B1
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BAA287598
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E41E525;
	Fri, 10 May 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1SkcAHV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508818EA2;
	Fri, 10 May 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364385; cv=none; b=Fot+cqh6gu5jIpn/oXDNpYiOVZ+CyB0hLQfhJdnzCUTlDxGbwhxgDSqCXwOXifzPF23yLIQyCAKI7iNfBR6DoMqhh0FW9fayM8BYdbrUJuC9wfmZvt2mkG3i5rniHmeoGSXlMZu7f1FtGrGYKtrlEcOcHiNU1gcd27ziK1NOkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364385; c=relaxed/simple;
	bh=pDK2he9KeGXWjli/boof22TeDiv4PEIudBXfbVKGCKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvwTVnA7RfEpZYBuhHSpdwhy+PmSqWtUekxNekG86bVMW4tJHv8nYlv8zWMPBXY5wRuB4OP/joK2I7xS0a8OvxikZCURhQjvixdv6jxg05LELDAoLsvvmJZiW4E5aE+1jtUk0yNmqZh5CGKpjHy83QUW9yrYeq0tW2dXifR4mKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1SkcAHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89660C4AF07;
	Fri, 10 May 2024 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715364383;
	bh=pDK2he9KeGXWjli/boof22TeDiv4PEIudBXfbVKGCKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r1SkcAHVOyhXBlsJnPfLQVRV4wcLncznZyHpwii6VcrmiyYqi53wDNSCHqtDUaICL
	 Xj+hY7Ow9tBmAA4g/Ov88Ur1nWV5oKdcm/c0htpZQAjnMpP/M/DCtCFe3ZCBnmlWd0
	 gRmEyHNybV+mp/1B/GbDlOtoKF1sF38e8/ZyMZq2CBTBG9/bIgthIIC8L9XRbLKgVZ
	 ayqUHAs+giQnsTOrtWrFwIew9GUSemM1PNijzTifV1+de20vBduQQlMSbsU5ZAqJGi
	 BCxh6P2KB+keB5MUoEOiv7DO6h8mAihNysH9HDOKrae2eTTdBM49CJ14lVXfaldhRB
	 awOP7u5SYpVOw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2770fc936so451379eaf.2;
        Fri, 10 May 2024 11:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXydFufcqLdCSyeHKPx+8nVrgHHGsvJqelLwqAMiuj3L1jge89I46Iykr7OJLJnm9NaEi6PntpNDw7CTcQKYqyMHNXHb61O9qewMLqTOGek1c7KmjvJavu6jrhbBNKarwY62MQpjnTW4Q==
X-Gm-Message-State: AOJu0Yyn3tIm7d8cFjblBofZcvq6w6jfoVoZdPMsJMq41RobXUXs3p0M
	uZ676DmnRVAIiUCTkrYWqPQDsJDaOvV+IZQCL2VOKKdJdbk/HMMLTgDtTJANRMKZ91NBvsRD/if
	jRX8hceU7WmFllaJsZNzTlxwAm9A=
X-Google-Smtp-Source: AGHT+IEqaXMtf9jRjZ4QqRKKkH8RcKRFSZVtKHoKMbZYVDYFl+B32nDN693R+H9mzQw9WKBnPcEuJRuNWchaRIKEXvI=
X-Received: by 2002:a05:6820:2602:b0:5b2:8017:fb68 with SMTP id
 006d021491bc7-5b2815cd95fmr3384445eaf.0.1715364382864; Fri, 10 May 2024
 11:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de> <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de> <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com> <Zj5eZKgpg3LFpne8@smile.fi.intel.com>
In-Reply-To: <Zj5eZKgpg3LFpne8@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 May 2024 20:06:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geYUx6G_ZnTX7+BjEbkqdSovdwriMHBoBXMyvrPjqFmg@mail.gmail.com>
Message-ID: <CAJZ5v0geYUx6G_ZnTX7+BjEbkqdSovdwriMHBoBXMyvrPjqFmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 10, 2024 at 12:40:05PM -0500, Mario Limonciello wrote:
> > On 5/10/2024 12:29, Andy Shevchenko wrote:
> > > On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
> > > > Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
> > > > > On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.d=
e> wrote:
> > > > > > Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> > > > > >
> > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >
> > > > > > > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() =
on Lenovo
> > > > > > > IdeaPad Pro 5 due to a missing address space handler for the =
EC address
> > > > > > > space:
> > > > > > >
> > > > > > >     ACPI Error: No handler for Region [ECSI] (000000007b8176e=
e) [EmbeddedControl] (20230628/evregion-130)
> > > > > > >
> > > > > > > This happens because the EC driver only registers the EC addr=
ess space
> > > > > > > handler for operation regions defined in the EC device scope =
of the
> > > > > > > ACPI namespace while the operation region being accessed by t=
he _DSM
> > > > > > > in question is located beyond that scope.
> > > > > > >
> > > > > > > To address this, modify the ACPI EC driver to install the EC =
address
> > > > > > > space handler at the root of the ACPI namespace.
> > > > > > >
> > > > > > > Note that this change is consistent with some examples in the=
 ACPI
> > > > > > > specification in which EC operation regions located outside t=
he EC
> > > > > > > device scope are used (for example, see Section 9.17.15 in AC=
PI 6.5),
> > > > > > > so the current behavior of the EC driver is arguably question=
able.
> > > > > > Hi,
> > > > > >
> > > > > > the patch itself looks good to me, but i wonder what happens if=
 multiple
> > > > > > ACPI EC devices are present. How would we handle such a situati=
on?
> > > > > I'm wondering if this is a theoretical question or do you have an=
y
> > > > > existing or planned systems in mind?
> > > > >
> > > > > ec_read(), ec_write() and ec_transaction() use only the first EC =
that
> > > > > has been found anyway.
> > > >
> > > > Its a theoretical question, i do not know of any systems which have=
 more than
> > > > one ACPI EC device.
> > >
> > > The specification is clear about this case in the "ACPI Embedded Cont=
roller
> > > Interface Specification":
> > >
> > >   "The ACPI standard supports multiple embedded controllers in a syst=
em,
> > >    each with its own resources. Each embedded controller has a flat
> > >    byte-addressable I/O space, currently defined as 256 bytes."
> > >
> > > However, I haven't checked deeper, so it might be a leftover in the d=
ocumentation.
> > >
> > > The OperationRegion() has no reference to the EC (or in general, devi=
ce) which
> > > we need to speak to. The only possibility to declare OpRegion() for t=
he second+
> > > EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI spe=
cification
> > > supports 2+ ECs, it doesn't support OpRegion():s for them under the s=
ame
> > > RegionSpace.
> > >
> > > That said, the commit message might be extended to summarize this, bu=
t at
> > > the same time I see no way how this series can break anything even in=
 2+ ECs
> > > environments.
> >
> > It's deviating from the patch, but in practice /why/ would you even wan=
t to
> > have a design with two ECs?  In general that is going to mean a much mo=
re
> > complex state machine with synchronizing the interaction between both o=
f
> > them and the host.
> >
> > Understanding the benefit of such a design might make it easier to
> > hypothesize impacts.
>
> First that comes to my mind (but hypothetical), is the separate CPU/EC ad=
d-on
> cards. If the main firmware somehow supports all of these add-on platform=
s,
> it might need to handle 2+ ECs.
>
> Again, it might be ACPI specification issue. For instance, the cited piec=
e
> doesn't tell about 16-bit EC accesses.

IMV this is a matter of what is testable.

We can only seriously say that we support 1 EC in the system, because
that's what we can test.

Now, the specification allows (theoretically) multiple ECs to be
supported which does not mean that it will ever be done in practice
and it also does not mean that this is a good idea.

