Return-Path: <linux-acpi+bounces-10811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E4A1B6CD
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC7D16CCBD
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159A35976;
	Fri, 24 Jan 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXo8V1jF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956717BD9;
	Fri, 24 Jan 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737725379; cv=none; b=rEcfahREe/Xd01wUYrYtjo3by//M0eBULLIZrJKzuJ6Opg8GmrPygRDD1bcsW7vXBqbEeUiPuuKiVMFDbiKQ7g1ZpL34WlRL1yxFasf7nFdE3ipijshGoEZthOA79ST3NwedQ0WB7PeqNSkXV0SReH88Whk809Fes8WGc4ODsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737725379; c=relaxed/simple;
	bh=1TDiDxil8IiwUFWFQZShYL2y3d4ADYhTZg1IYepKcOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frE9PNH/9VW0ipuz95FZAa6UA1MZU2i2n+G454jvo1s+gRg3jpmDoGP06QQzKsFSdwEfqnCo26rzi+9G/60Me/RBdMOpNZgz9FAc1dsSUoMm0+HSdkx4BeWiH5dTs9l94yXpDnRAGVGwJmY6QGGkVTEDsFFW9IH5EBKojIy0XsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXo8V1jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA57C4CEDD;
	Fri, 24 Jan 2025 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737725378;
	bh=1TDiDxil8IiwUFWFQZShYL2y3d4ADYhTZg1IYepKcOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oXo8V1jFxl/RGsGdZ1IADBf340UmsADQmcdSZuSl2sdYJNV2lOqm0EJDuC61/eDf8
	 yaY8qRUIy5TCxEQRX4HGRhUsbI7GkMc2v25QVs4/4AkfrGqIv1+p7ev6VlYV8SEXkf
	 LjhBs8Tsa3Gwkm04o/9IQeof8nVKrgBydlXeVvteZ3LH8jeOrctzNs/LOnAntevA6c
	 J6IwPxv/aUmoLA+JFTITfqqiHg/JF7W4AOpG/MlHgkhuZNXn204eqBmx50Hr5YdHl7
	 zN7SzIg/0Ce5vND6l4OdNk9wbvThTtz1egLODkmBegiKHBpl6jbYzRp93K7Mp7myC6
	 oUMr6A37o0G1g==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e3f291ad6so1272975a34.0;
        Fri, 24 Jan 2025 05:29:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Y2qy85OHni1isGNCPtCZUoFmYgSSQmTCJbFvQ0aKL9ZWz1pGkQOHHSOak9/1bKqx40XwySXNOlA9PSVc@vger.kernel.org, AJvYcCU9LFOyU+YydeajgfHw2YCwGrBEBYhsZ1BDvluO2OLNTFV+d9zTUXmohQri2QppDUyryrI4NlpzkEAj@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmm5Pd6XaTe8DJ7wsAS1sR5AHEg4Wl/yNYrzuk1H5RvCgLUnH
	6DnbL7MRpw5utvx5nqcTqly9l0v+3XeOTTYCs5r0IO5JI1hLMSYdW8F15ug+NwJF3Y96Dbzmwyh
	XejSOu+OqBHNL5KM2MoXZ4aZ8f+U=
X-Google-Smtp-Source: AGHT+IFrEIZm/uFHydn9ytBviJmgsBuJlAWOboLRE9YqvgHOuVOi95Vm3QqP4AInZOhVLs40/FPPeHNu8hOj2JDRXG4=
X-Received: by 2002:a05:6830:6404:b0:723:21bd:ed94 with SMTP id
 46e09a7af769-7249da71052mr19194570a34.9.1737725378115; Fri, 24 Jan 2025
 05:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117081420.4046737-1-rui.zhang@intel.com> <CAJZ5v0iy63VakygnMqV4b5yYR2rwGbJ4zM4PbPYX2oH-ry9Evw@mail.gmail.com>
 <87v7u48vsy.ffs@tglx>
In-Reply-To: <87v7u48vsy.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Jan 2025 14:29:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgH-4Njg0_te1WtVLW4dOdGG3j8E+48CZHusUUEavzrA@mail.gmail.com>
X-Gm-Features: AWEUYZkOejoYH6PIyWpym6zobJmTLmLV7FNsNhfaNCarx9osfBr_vrQRMvh82wE
Message-ID: <CAJZ5v0jgH-4Njg0_te1WtVLW4dOdGG3j8E+48CZHusUUEavzrA@mail.gmail.com>
Subject: Re: [PATCH V2] x86/acpi: Fix LAPIC/x2APIC parsing order
To: Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>
Cc: dave.hansen@linux.intel.com, bp@alien8.de, lenb@kernel.org, 
	mingo@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmattson@google.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Jan 23 2025 at 20:12, Rafael J. Wysocki wrote:
> >> 1. https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.=
html#madt-processor-local-apic-sapic-structure-entry-order
> >>
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Jim Mattson <jmattson@google.com>
> >> Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@g=
oogle.com/
> >> Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
> >> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >> Reviewed-by: Jim Mattson <jmattson@google.com>
> >> Tested-by: Jim Mattson <jmattson@google.com>
> >> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > x86 folks, should I apply this?
>
> Sure.

Done, thanks!

