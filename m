Return-Path: <linux-acpi+bounces-1994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252D7FF232
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57E5B217B1
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CEF5100C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3610D9;
	Thu, 30 Nov 2023 05:28:39 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b89d4be037so157501b6e.0;
        Thu, 30 Nov 2023 05:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350919; x=1701955719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UocFr9z4iBYyzRXWEBLNC0QmTk2pcl3A0aXeddwo3SQ=;
        b=VbZu3znvnO27Ks+92eHrYRlRgs3zUT7rCqpFp7K/vz0bK1FmUYgmqYqfuff1Q9THfU
         lXVuzcSaLYC/pQslvSzX9TLUOuVgyzXIhUozwsw65eY8TTqrccwSVgKIVXrhhRl8aBwO
         7xzZQdg9XKyv9+CAsb6WTAoF4TzDEfwfWDqrxH3vmQdRRMPwh/07UjKEYOzIudCl70fh
         dGd6GB3rQa+BuUH+LYJbugo8qm0hpHj8cUntTwnEHJkqIWi94WeU3ONliHcgy8n1m5sq
         x/WmVjbr74iFTnmarwP1za/UwnW2WqFBlDkFVuKKOkFnKm0RfJiqq9Y8dzbtbF3z5C4x
         tSbg==
X-Gm-Message-State: AOJu0YyDR4RCadRzgVEsKLn0qcYWdIWiQhxsWKOyVykIUutthvJ5OE2D
	PifZj0vARmiCCwvKPbbxEVpvB1dLTavDC+GnjW8=
X-Google-Smtp-Source: AGHT+IHbe+EuMC7tz0BG+NmkODy+LOXAd+jgG74MCtOA93Kp5766n5r0h8pso5WKmDjan7SbkpqpYsbsC5uxq0bs/qg=
X-Received: by 2002:a05:6808:2016:b0:3ae:5650:c6ae with SMTP id
 q22-20020a056808201600b003ae5650c6aemr2258178oiw.0.1701350919037; Thu, 30 Nov
 2023 05:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5745568.DvuYhMxLoT@kreacher> <20231129085600.GQ1074920@black.fi.intel.com>
In-Reply-To: <20231129085600.GQ1074920@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Nov 2023 14:28:27 +0100
Message-ID: <CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler for SCI
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika,
Hi Mario,

On Wed, Nov 29, 2023 at 11:39=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 27, 2023 at 08:57:43PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In the current arrangement, all of the acpi_ev_sci_xrupt_handler() code
> > is run as an interrupt handler for the SCI, in interrupt context.  Amon=
g
> > other things, this causes it to run with local interrupts off which
> > can be problematic if many GPEs are enabled and they are located in the
> > I/O address space, for example (because in that case local interrupts
> > will be off for the duration of all of the GPE hardware accesses carrie=
d
> > out while handling an SCI combined and that may be quite a bit of time
> > in extreme scenarios).
> >
> > However, there is no particular reason why the code in question really
> > needs to run in interrupt context and in particular, it has no specific
> > reason to run with local interrupts off.  The only real requirement is
> > to prevent multiple instences of it from running in parallel with each
> > other, but that can be achieved regardless.
> >
> > For this reason, use request_threaded_irq() instead of request_irq() fo=
r
> > the ACPI SCI and pass IRQF_ONESHOT to it in flags to indicate that the
> > interrupt needs to be masked while its handling thread is running so as
> > to prevent it from re-triggering while it is being handled (and in
> > particular until the final handled/not handled outcome is determined).
> >
> > While at it, drop a redundant local variable from acpi_irq().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The code inspection and (necessarily limited) testing carried out by me
> > are good indications that this should just always work, but there may
> > be still some really odd platform configurations I'm overlooking, so if
> > you have a way to give it a go, please do so.
>
> Tried this on ADL-S and ADL-P systems that I have here and both work
> just fine with the patch applied. I can see SCI interrupt count
> increases in /proc/interrupts as expected. Did a couple of s2idle cycles
> too, all good.
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for your replies and tags!

Given the lack of response from anyone else I'm going to move this
towards linux-next with 6.8 as the target.

Thank you!

