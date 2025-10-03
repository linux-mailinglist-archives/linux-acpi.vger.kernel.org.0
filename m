Return-Path: <linux-acpi+bounces-17582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91456BB7E29
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FDDE4E4E8A
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA26F2DCF43;
	Fri,  3 Oct 2025 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYGbtgdO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E22DC771
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516100; cv=none; b=AeBIBtqs05oIra/bNZIVD98+RMfsG2BV+Mk97DEY56YR42/ciFOJaGhDIG6A72U88k0mutGkIEISjahpYjbrxrXtHtlHXWVBVUxn3uhM6rMpzH+gJwLK3j2U6m6AxoTXN3JBA2trR9ZWhjRpiWyDgWdjyc3rmIRQ3HWiDN5rmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516100; c=relaxed/simple;
	bh=wnwCmayrbuMzsNdbdzK787r5mtfWIdvorjhY+0+9AHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+GKckJjAxhvK/PPooH56XwNvuaBlaK8TGFsmxJAa4emRgVkRad/PXUluh6x2wqy5nAp7SSq4e1RGc+lbb95sAxleKc80u0nCx5/ox9EgAUx8c2EVBBupaMdXj/8fEsJSYyTJxScgrTRtp1ztTQRPnpbEViat/Gkf0GakqEzJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYGbtgdO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-362e291924aso22065991fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759516097; x=1760120897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnwCmayrbuMzsNdbdzK787r5mtfWIdvorjhY+0+9AHk=;
        b=gYGbtgdOliI0jLep4Hb1UN7b+BL47pyUTnIByarJ2N3YxKdi0CcoWPl+00PwLS1Um6
         SB0qCr2NcC8zkigCLSztQ24z2POxVGgHER3Xn+NGYS9wKG7UqctY7/QPjZhWuo4lJLuH
         1y2Y47g/+aTI8LQlXsl1xw/U2kHlSS23nyhk3gpqrTwyk0QzK7mvHXBdjC7epTdzX3wq
         0sJzlCVnbAqGo+yyrXu0FhHgyjRyKZrv6Tpwj1Qm3Vz6WRpE85n+TUMUQfBu4H7bb6IU
         WN8DdTRNPUj+y9V6rJrNyrwTilo7XfBKrtFQCIDlgqBA9PMRdciqAiBmtd5KUQCBrHUX
         AQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516097; x=1760120897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnwCmayrbuMzsNdbdzK787r5mtfWIdvorjhY+0+9AHk=;
        b=L22lkSgCxkE23GEvUAU+BfmjEK8zlQlgC4spB7YqCrdnsqpBgRv2nyigfUvLgMcF1f
         bOEV6WsO2GsuUtOP+7ezfCzFPvw3f7hbY8RUXBVUAdP5R/nWK5R5SbWt8YysqyAw121v
         fNkDNy3n3BpSUrob0hyqQAz/2Gh5aXF0F5mQK6Qpn2/agJxtUNOoN63nBQ0tvFAzVUvG
         YDNTurX9XHfaBw4cuDoahCg6aUIrg5f70lOrDJXlCWEr/tatLZwwO4JOiWNGLYoafusM
         p3+pNMvRQZVfITGXmuLxDcJnkEW6HyR+nLcQmNackfHdDyZ0Cl6Rg0+IzzQyXjH5ONw9
         HwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/zO+8qHlMhB5XZWjVl1TZdx7p000IZcFZZGe1S2XedWmLtn4uGz8et23Ze3kEghf5lWqc99HZgzoC@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMmzxBae3SsDmmKpHWATDLXLFgIEbuNuKLMrHDAwEq5gHAYV0
	VgtYpcs5F7y0XdY7mS0GsZ/BVLADDZD4Wek8Ptguo+4eFS0YwdYdW5L3XcUb6YhquAy2oZshetH
	TrC4S/Ckhu918r8a1TaJ82ysvoWeDdhHMuh2sd3WD
X-Gm-Gg: ASbGnctbAhd9rqp+c3v4PCBwX4X/HwqcDHuSuLwAtngpeaRy9UuMJhbFJZ8TXeo9JCI
	duheoRPOTaIlmGY9p7KCar4h96jrDt8+1SlIcz8fbJgDM3qr7Yc7d1s51+I+WYB193VRX00YsW3
	k3dj5fcUsJ8Zyi5E+VGK/hcaMxH60Ubc6JWqZpBv9ruItBK1KIuhYNSYXL2s7HhGkGDq7IJEz0o
	rDzaoRJ5UHhhmmEwp47RXpNIcRFcH3L9tHEANSTE4wx48rN
X-Google-Smtp-Source: AGHT+IGroolGta644QVXsh1xa+w2xupl+/hpahHuoQAgZeCtUBKLQ/4tZ1bVzl+o9pzNo0LzYHlwZfombCeZ9ICqGlw=
X-Received: by 2002:a05:651c:1509:b0:36c:c5d0:715 with SMTP id
 38308e7fff4ca-374c38450bamr11715751fa.29.1759516096518; Fri, 03 Oct 2025
 11:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <2025093044-icky-treat-e1c3@gregkh>
 <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
 <2025100323-sneer-perennial-55e1@gregkh> <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>
 <2025100317-backroom-upside-c788@gregkh> <CACePvbW031fW8dqswwXp=Z6H3jv2BiBSJFyGiXCKzZUSKRnxqQ@mail.gmail.com>
In-Reply-To: <CACePvbW031fW8dqswwXp=Z6H3jv2BiBSJFyGiXCKzZUSKRnxqQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 11:27:44 -0700
X-Gm-Features: AS18NWB6obQVy6GItlQp9C5kT9T7IKSBb_ab1Dq-pe9ihGV-Q4Ff1PkgyH6kMWc
Message-ID: <CALzav=edEDvz98KKtmMLWcW33PgE4aTy6K7YLSK0_jx1PdRqBw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Chris Li <chrisl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:49=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Oct 3, 2025 at 5:26=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 03, 2025 at 12:26:01AM -0700, Chris Li wrote:
> >
> > > It is more than just one driver, we have vfio-pci, idpf, pci-pf-stub
> > > and possible nvme driver.
> >
> > Why is nvme considered a "GPU" that needs context saved?
>
> NVME is not a GPU. The internal reason to have NVME participate in the
> liveupdate is because the NVME shutdown of the IO queue is very slow,
> it contributes the largest chunk of delay in the black out window for
> liveupdate. The NVME participation is just an optimization to avoid
> resetting the NVME queue. Consider it as (optional ) speed
> optimization.

This is not true. We haven't made any changes to the nvme driver
within Google for Live Update.

The reason I mentioned nvme in another email chain is because Google
has some hosts where we want to preserve VFs bound to vfio-pci across
Live Update where the PF is bound to nvme. But Jason is suggesting we
seriously explore switching the PF driver to vfio-pci before trying to
upstream nvme support for Live Update, which I think is fair.

