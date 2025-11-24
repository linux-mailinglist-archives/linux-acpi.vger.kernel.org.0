Return-Path: <linux-acpi+bounces-19201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61399C7EF65
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 05:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF0843461E9
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57C2C0F6E;
	Mon, 24 Nov 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eCRt3dNh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FF2BE026
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763959774; cv=none; b=fDhZs27mOQui12Q0n83u//ICfPoUHzONZyoAeWYC5m1xSup0EyeaPdasHdZiwyRyUh1v653DsSl1DxTb//gvPR6lwY/0T02nRnMWv8GVrPPp9vfhxbMskF003YT6spnXAhUZLy0qop6Znc+KCLbZzwFwMhn+sxjRKt7FSjN19i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763959774; c=relaxed/simple;
	bh=5aJklegLdNSi8xVjlH5+D0KRLx+ZHe056Z6FYbiEBXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCLw13e/JH29Pxcl3tVhWpM4ra0vCLoeG58mOzN+NckB8y3kQ0jYaXuvOlg3wpFZ+wPzVjdgo44FlPlXciq2tdlv8RKLebFDI2zwH1WNUNO1Hfcp4fzUuo65KbCk5nUiKfn5UPj1QbencslSiU7aGVTyT4j6SfNjvPuOLUf3/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eCRt3dNh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5945510fd7aso3285679e87.0
        for <linux-acpi@vger.kernel.org>; Sun, 23 Nov 2025 20:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763959770; x=1764564570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOtbFMGWRLmZjtUaI1vJyqoGigotKbiW0HzZimuo/yE=;
        b=eCRt3dNh7dCmJvV9WE8whPOLfUdH0K8wvC3xbgOAveZUzPSwXawe0t2pk4vSVnlej9
         90wP+iOMhv0UJY1terDlrxvFs7xZFbVs5OPcD6tcLDnGQm7g+Tkj3EFpcyNvzduCNc3m
         2LtcXX+r9JbqsLOGAhcnhJXabVBJPNt9Mz2aLAktYr63orMDPyX/JLen+XCCDmR/kP/b
         ETzKScPZmpwUJRpDQoJkg0xl1GAZBkrQKR8ox9+RGCG50kLo04vuE6ZyADNySsh84fL3
         /kaJtCMBkLw41kwrigU/kNLD1dk4vpudJiqOXsOn0WsuOqYWgk62v1F2Skotk9hmlGkO
         OdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763959770; x=1764564570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOtbFMGWRLmZjtUaI1vJyqoGigotKbiW0HzZimuo/yE=;
        b=DbiN3lStOENfVQuMl+p5rAauko5rsdJ2JrWbPSSiaDOV/S1nHE+QXZAf2pk73w87l9
         e4wsz9L19lEMIy2KkrDYQNIRzfyOZxit8lpIKar6/z0U/LgpTvVHvJ/3sgQlxSRnjFB6
         nygXxJoQHLzmN2MoqrYrcOWGEMZD1p7+ri0zKTUJ0iswafieNfQe6zE5JGRiksyDqEmz
         TbfdaUjsNfq+bzJbMWKP6ts0SXp8w9p0h2MiEOjIAViorRiN+NUfK6zWP4PSWlX83y1c
         FQrTgaV8ZwFirDrtjpkshmkIjXPn6ljMpqLn3n1ib4J3DErwmIPR6g0JvXM6ByFVC505
         qkRg==
X-Forwarded-Encrypted: i=1; AJvYcCU2O4kcCy2I7jLSWT+ddKOgt3F569kbN04UH+BPuYlJ5JuDRU5k0el5Ml6nuwhyrj1LuRJfAZdTRVhy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kgCy2PBuP+vcWX5Wkt+kMOydWuCa+KNW2QoY3cBzTHkuBIIA
	27q2FZFbheWzP/JGhQBqGA6Qjlzj9T+RynI6xTro40Zu+Wtk1QFdMMVn96pUFfX8vr9MGgR6OCa
	D6oTqPBv9OMXDBH0hSMrPgRGkmqJlXZARfWu7QKqChKMs2w0b0Dy+u0M=
X-Gm-Gg: ASbGncupW7to6mhRKwbP7NaLxKzdL0EGfiGhS7gS/4yPODgedkqYh27cUs2eF7HF93E
	rrTNqLarr0QY/Cu80xwYFQxzUzcj3hbUyV2j2vn5U1zPZHaP95Z0vsmwxzEs9et6LfpXcbV4Udz
	fTf+j69cCYJdt04f6KMAGg04oNMPrpeeELP5ZGoU5T9RSS/5z+McPWc0FkEijo3zvTNTQhD9xEq
	9f0poaccDIDVrSNtjHxDGOSwI19EccsI4a2NB6gf3PWRTXm99PsadfGEhUQR47BnwHJjzc=
X-Google-Smtp-Source: AGHT+IFjMCCjWgwiJ3CiTwA1NuSg8WtEQQ11Y0ybYypqt/+1bq3xs1SpkJFgmfLa1MTYIdUs2LTrr6ojFUZwZNR2Q/I=
X-Received: by 2002:a05:6512:1320:b0:594:292f:bbe9 with SMTP id
 2adb3069b0e04-596a3ee4fe0mr3485616e87.36.1763959770101; Sun, 23 Nov 2025
 20:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014132106.181155-1-apatel@ventanamicro.com>
 <20251014132106.181155-2-apatel@ventanamicro.com> <012aaa39-a37b-e682-0e34-9b7d7cd87f75@kernel.org>
 <CAAhSdy0iwq_ZPzFY5_x_wsbM_H+npSDVv1F=wP=O-_25VChh6Q@mail.gmail.com> <60f4c500-6e22-ed4b-912b-c9368bad7c9a@kernel.org>
In-Reply-To: <60f4c500-6e22-ed4b-912b-c9368bad7c9a@kernel.org>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 24 Nov 2025 10:19:18 +0530
X-Gm-Features: AWmQ_bmARPpFF_aZDw6BtyE8Zp2IhQfzQ9cWetAY3IX9XiLo5Htf0qi2dL8rOc0
Message-ID: <CAK9=C2VdvPU6b+vbL2KwnvaVo47ayNOLb-bH0UwjRj=MHe0V9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Paul Walmsley <pjw@kernel.org>
Cc: Anup Patel <anup@brainfault.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>, 
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 6:44=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Thu, 30 Oct 2025, Anup Patel wrote:
>
> > On Thu, Oct 30, 2025 at 12:35=E2=80=AFAM Paul Walmsley <pjw@kernel.org>=
 wrote:
> > > On Tue, 14 Oct 2025, Anup Patel wrote:
> > >
> > > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > > number via register so add common csr_read_num() and csr_write_num(=
)
> > > > functions which allow accessing certain CSRs by passing CSR number
> > > > as parameter. These common functions will be first used by the
> > > > ACPI CPPC driver and RISC-V PMU driver.
> > >
> > > This patch also (silently) removes the CSR number filtering, e.g.
> > >
> > > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > > index 42c1a9052470..fe491937ed25 100644
> > > > --- a/drivers/acpi/riscv/cppc.c
> > > > +++ b/drivers/acpi/riscv/cppc.c
> > > > @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
> > > >  static void cppc_ffh_csr_read(void *read_data)
> > > >  {
> > > >       struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_d=
ata;
> > > > +     int err;
> > > >
> > > > -     switch (data->reg) {
> > > > -     /* Support only TIME CSR for now */
> > > > -     case CSR_TIME:
> > > > -             data->ret.value =3D csr_read(CSR_TIME);
> > > > -             data->ret.error =3D 0;
> > > > -             break;
> > > > -     default:
> > > > -             data->ret.error =3D -EINVAL;
> > > > -             break;
> > > > -     }
> > >
> > > ... the above code, and:
> >
> > The switch case is incomplete for cppc_ffh_csr_read().
> > Also, csr_read_num() already does appropriate filtering
> > so the switch case over here is now redundant.
> >
> > >
> > > >  /*
> > > >   * Read the CSR of a corresponding counter.
> > > >   */
> > > >  unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
> > > >  {
> > > > -     if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> > > > -        (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> > > > -             pr_err("Invalid performance counter csr %lx\n", csr);
> > > > -             return -EINVAL;
> > >
> > > ... the above code.
> > >
> > > I'm thinking that we probably want to keep the CSR number filtering c=
ode
> > > in; at least, I can't think of a good reason to remove it.  Care to a=
dd it
> > > back in?
> >
> > We can potentially have custom CSRs as hardware counters
> > hence the CSR filtering over here is already incomplete. Plus,
> > csr_read_num() already does the CSR filtering and returns
> > failure for inappropriate CSR number.
>
> OK.  To me, the most notable changes in this patch are the changes in the
> filters for both reads and writes for the two different call sites, ACPI
> FFH and PMU.  It would be good to document these filter changes directly
> in the patch description, along with the rationale.
>
> I'm also not yet completely convinced that we should allow both of these
> call sites to read and write any custom CSR.  But maybe the updated patch
> description might be convincing...

The RISC-V ACPI FFH specification allows a 12-bit CSR number in
_CPC object encoding so any CSR can be mapped as a CPPC register
(including custom CSRs).

Similarly, the RISC-V SBI PMU specification return 12-bit CSR number
in sbi_pmu_counter_get_info() so a platform can use custom CSRs for
additional HW counters.

I will update the commit description accordingly.

Regards,
Anup

