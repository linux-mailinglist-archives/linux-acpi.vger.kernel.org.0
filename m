Return-Path: <linux-acpi+bounces-7633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8009550DA
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEBC1C2165A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5C1C37A1;
	Fri, 16 Aug 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS7y/KyZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBE1BE258;
	Fri, 16 Aug 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832971; cv=none; b=UHlUPwFa95pca/rWl7w3mycZa6VKujyw/sbK6VSpcZQKc2vFTaPaRFow8UeCiwHRdytG4CWkF9C/m8HTQTftl28kjeVg4rgQLUaFGDKOeKDMcTzzk1Rw+91oJXzPbVyy2qbJXv4KI9OVZfr8AtFiQswYACN/ReXRhfFF75vBS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832971; c=relaxed/simple;
	bh=MEnY5dW4BizxQHSga1Zlxnjl7jRyw2lRpBPUuQnt3L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrjcmLCBSlguBCrS+bLSM+Fua0bIHtPECdXaJpwtVoKniKIyTqzjPxQWAt8eb6oDCh4S6gZq/B4mfEnZCq1rogn2ygYBf04Rp5hIh7s/w6bn9Ic2iC/+BuWD9nzmI1hdAR1/CAKGOt3C8aJkM4Jvmg7P2bUUDjoxN2n4gyxDUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS7y/KyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A5C4AF0C;
	Fri, 16 Aug 2024 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832971;
	bh=MEnY5dW4BizxQHSga1Zlxnjl7jRyw2lRpBPUuQnt3L8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uS7y/KyZXlRijF3o9ceCHJPXPE11rMuJwUEaJLAFd7YjEf7vCckXUK9zoQ44eFrDJ
	 zO0ucI14dhHGShenGp0Vhe27e0714oplQfhVgaY/yItZEMKvSTEWTFuyPSGTQwA6TP
	 ES7kWZ02qRk9yK2nX/ws+iau4WpOgMVIHqj5OdQy7Azfx6m07pCjLfnCAxCKt7sZH+
	 vi+6h1mX1fJCRCdST0JdWLOWnTyyjg4aErIJFqDnkZopWyVwRc/PC4ao/f5J9ya9YP
	 H815+Y9bQKw36couhgiGgrKCt2SBZyr34xWhnqeWfTBzaN4t7rA4SG5gM8SEp50Rt9
	 FyScAN1GxhF2A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5bcccb372so320484eaf.3;
        Fri, 16 Aug 2024 11:29:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPsESp4YNX2QD/4xWRuOIVBEvNxYBpSWEqVd9j+Wz1+c8c5dgA2dlwl/N5UZIQ4ygRZWw0Aw+3S1IFT4paiFTLx8KgDrz506j0aHMDHlWxZY1wJ3P8j851LPBfThvCmNWtE5ec0sL9ag==
X-Gm-Message-State: AOJu0YyIXmXdPTMfBaR6E/cQB/AckWudPMcRCsKmw2RZV8YLyp1U/MlJ
	SFTj7qWc3ONS2/YKAqaamO3uMgfP9U9W7wxaTKRBXtDyUGcaz5rvHzTNtLQkykVltoZ4H8NQRll
	H8OjAmJnIgTzEcQaIqSdLa4zcC4k=
X-Google-Smtp-Source: AGHT+IEQDtDifU/ay61Nag/OTb/NwAraSufQacFl3Jwy2M6bzQypfkwBuAVU6h0dCTMxUWcXykK68NNUvQD7CXN0GAY=
X-Received: by 2002:a05:6870:b4a4:b0:268:2075:a41d with SMTP id
 586e51a60fabf-2701c5235a6mr2356726fac.6.1723832970816; Fri, 16 Aug 2024
 11:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org> <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
In-Reply-To: <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 20:29:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Message-ID: <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Subject: Re: ACPI IRQ storm with 6.10
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:48=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 14. 08. 24, 7:22, Jiri Slaby wrote:
> > Hi,
> >
> > one openSUSE's user reported that with 6.10, he sees one CPU under an
> > IRQ storm from ACPI (sci_interrupt):
> >     9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi
> >
> > At:
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1229085
> >
> > 6.9 was OK.
> >
> > With acpi.debug_level=3D0x08000000 acpi.debug_layer=3D0xffffffff, there=
 is a
> > repeated load of:
> >> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D:
> >> Status=3D20, Enable=3D00, RunEnable=3D4A, WakeEnable=3D00
>
> 0x6d seems to count excessively (10 snapshots every 1 second):
> > /sys/firmware/acpi/interrupts/gpe6D:   82066  EN STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:   86536  EN STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:   90990     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:   95468  EN STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  100282  EN STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  105187     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  110014     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  114852     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  119682     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  124194     STS enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe6D:  128641  EN STS enabled      unmas=
ked
>
> acpidump:
> https://bugzilla.suse.com/attachment.cgi?id=3D876677
>
> DSDT:
> https://bugzilla.suse.com/attachment.cgi?id=3D876678
>
> > Any ideas?

GPE 6D is listed in _PRW for some devices, so maybe one of them
continues to trigger wakeup events?

You can ask the reporter to mask that GPE via "echo mask >
/sys/firmware/acpi/interrupts/gpe6D" and see if the storm goes away
then.

The only ACPI core issue introduced between 6.9 and 6.10 I'm aware of
is the one addressed by this series

https://lore.kernel.org/linux-acpi/22385894.EfDdHjke4D@rjwysocki.net/

but this is about the EC and the problem here doesn't appear to be
EC-related.  It may be worth trying anyway, though.

