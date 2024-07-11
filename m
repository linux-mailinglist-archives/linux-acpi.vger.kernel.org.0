Return-Path: <linux-acpi+bounces-6860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9E92E46D
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE51B22A9A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01367158A35;
	Thu, 11 Jul 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSEZov2p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34C157A59;
	Thu, 11 Jul 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693276; cv=none; b=ILRiH0vuxyTB1SXsuYuJlZw1I4UsITGIuKwBw8fNurgdYb7t5CMQOBS5ABx1lQTEckN1RmpMwQSzDfN6n/ZM24wZrr6mtyueCyQHdVOVjohJpxyxK672w9ohOaFE5mhs8yIHif7L7LmR41GmUOHEglANS/1RvrR42xEnlVoGUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693276; c=relaxed/simple;
	bh=j25o/Qob8Alr59DZNCfHMzseZ54egNEwBktZQ1r19VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG8etz0N2OeXKwFl90GCw5Y2Hu9u8xVto9iYZkniEkph6gvf+AUYiYv9czvCajQ8raJTXQUyqcYvgtMlDavZN2Rj4995bmFHt3eK9C+5PxRRr8nAKbz3m9gRk/wF495/YZnkpekhjulcgbon7Hl4+0mOe4PRSWpcZpAC3PDWl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSEZov2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A88C4AF0A;
	Thu, 11 Jul 2024 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693276;
	bh=j25o/Qob8Alr59DZNCfHMzseZ54egNEwBktZQ1r19VY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tSEZov2pJZobOIzBI4XqvCzRsVTYy/x6GTxotfnYw/sZT0sJTuvpsYxsP5zZgWZOg
	 BNPIuyOViW5b4Td348Q4/40ttTm9aYTRVWpuz6EEARhnRgOdRNQOC88Mp7tYl0LBPa
	 /Qjf/GrfSuKogEXi+PQgn8+jai8Z9VED9cjKZ9/NIJG0lVtNoy18NUp+0M0Kfwhu3G
	 aF94ISNk8WFQ7kmi024K0ivzMpgUF9g3tuaBKimY4DOFe2ixiCXB3x+WwZ2Mfl4qzO
	 4lx5QLqO3mJ1Un5I89kcRFxitSpnWalg1lsf0/9d3zDR9vGPqUoxOLtRfz+uqQwVoC
	 WHZOGfuTbXEtA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d92ab6f34cso35541b6e.1;
        Thu, 11 Jul 2024 03:21:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjlb8eYeqGTNmezj3BJjnjBfRmgxetIaPcSpByarJLIY0NqLBDiFYCL7kkESGiTUztRKktcWFgSUdWRKwtSoot+rOeCMWelgnElPjFePXp3IiywD4hHflcWIOAiVQDJUqjhDD6ufK/pQ==
X-Gm-Message-State: AOJu0Yx5AkLNe77XqMh3x8CHGEx5qWB0FPFh3BwfNC+PUwcsGC4PeJ9g
	F26GFXaKNlEFALlX99KjIp1Fx6rUkP6FEVwdCEzVC2EemQFTBd1vS0WNsa9kytMJMU/k0859hon
	GpDa4ZyZt2HzQ5Qy11peV8RAsh+8=
X-Google-Smtp-Source: AGHT+IEsVVvCwqVOuMCI3ObNf4O5mY0G1M8NrIcjumiF91h349aZaObr1EVuFSCYNUdWfhBpzuv0lSDIx2YjeZbJzs8=
X-Received: by 2002:a05:6870:d88f:b0:25e:1817:e4a8 with SMTP id
 586e51a60fabf-2603aa6fe26mr2050001fac.4.1720693275603; Thu, 11 Jul 2024
 03:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com>
 <67d74985-7be5-4e29-aab2-97a08208ca3f@intel.com> <CAJZ5v0i0jJBDqYjp+9_Bmhhf67SrWNXaRY1ZfDx6GEKfCLcGVQ@mail.gmail.com>
 <454710cf-38b4-459a-8b5f-e40bcd7f20e8@message-id.googlemail.com>
In-Reply-To: <454710cf-38b4-459a-8b5f-e40bcd7f20e8@message-id.googlemail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Jul 2024 12:21:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjpkDiiP0ogc956E=pEY_jSeuXRgNONWQe0D4yO3mXEw@mail.gmail.com>
Message-ID: <CAJZ5v0gjpkDiiP0ogc956E=pEY_jSeuXRgNONWQe0D4yO3mXEw@mail.gmail.com>
Subject: Re: Regression in 6.8 from "ACPI: OSL: Use a threaded interrupt
 handler for SCI"
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Thu, Jul 11, 2024 at 7:04=E2=80=AFAM Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
>
> Hi Rafael,
>
> Am 10.07.24 um 15:13 schrieb Rafael J. Wysocki:
> > On Mon, Jul 8, 2024 at 3:51=E2=80=AFPM Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com> wrote:
> >>
> >
> > So can you please check if the attached patch helps?
>
> Yes, everything works perfectly fine with that applied.
>
> Thanks and best regards,
>

Thanks for testing!

Patch submitted, let's see what Thomas has to say about it.

Cheers, Rafael

