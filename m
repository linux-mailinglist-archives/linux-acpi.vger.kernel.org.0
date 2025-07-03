Return-Path: <linux-acpi+bounces-14976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E41AF7595
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13C31BC3A0E
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E505146D6A;
	Thu,  3 Jul 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojpeSv2E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F71DDD1;
	Thu,  3 Jul 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549315; cv=none; b=sfwPjkjTTjIvxpt4o6U+OWV7ZHWayvri4vZRmXOUvq1FAiZtM4VS0kGT2siVeJ4p0oEv4+/IMwQgXM8O7ewRvPIN8a2kYAQDlD9AslMvGl+CnfhEyDDkoLJoiq9amVuFLvYMinYtXMpdktErxJXTADbO4osSFD8p2RzktO2qjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549315; c=relaxed/simple;
	bh=uO7svmE3p5aJ0qQFNv+IETH0e9rvsqr3oPE7wewnXME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ8OBE9ZPgT+13tsoFfYHjIWrBlDUVLkMtrYgvwhiiq7Iv13t0ILHVm5chVS79vj/EFz3IrBHnpkF9ssrpD+4WXb39zwaEsBeVwcLdJxGA0I3pHD6q7ru44TZz+rW/itzAG+dkxfy8kHR38rkUtKd21chR+DLrSNAWBXWIuEjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojpeSv2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC72CC4CEF2;
	Thu,  3 Jul 2025 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549314;
	bh=uO7svmE3p5aJ0qQFNv+IETH0e9rvsqr3oPE7wewnXME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ojpeSv2EXiOCfKfSWMtzVtTyj5d89almMts8kTl59AkkUwOAGOZFXJ/X+DOt+inPU
	 eI9jpzBec4BMZip5+QWKw/fNpJW0VQTmQj7neHXGoPdVe5+Ga4UJEHr5xENGh6l6PG
	 wij7IDGekOg0HN8MqmW2DyfKWAhzm7ytfc6rJpnlMK7wgzvceAewNHRfKB7uNDK7gC
	 bXDzoz14e/7o5utzyBYR1aONg0E5y3qpZNTiWcmBqiAmUNoDPB0qfLvb/QhbA8pEDo
	 bIBvgR/ZFFUJR+usjecXEpDJ1buIk4jpkSEw4geLA482Jnm07m3uFujRTi/merFzQL
	 OdV5AiFLOH5mA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a4bf1ebb7so3108731b6e.0;
        Thu, 03 Jul 2025 06:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlaWPyc6Haz4jGO7HkQdm8GtQ1TJN7p2fIs1Q049z77ZsyDI59ZLBEkrWcF3uQBgfV32SmWw6kKv445Gxd@vger.kernel.org, AJvYcCVJepq3fJQhDO/6jU6tP5AIg/tt2ViYyubLsHU2E3BUd9qezp0ZC4tce9WY1NWznBvPq1ZjwZQTJmkW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6pHAnpZiNWrisM1ojZyrlIRRFg4/orDaIprENwJPNpmMKNJc
	y5EtIG4D+LcB/ff+ihynOPa7ZLSO9AnJ9bNEVsG3AhCDkPKbWjRYccGJ7iNMFRdVAeXYcD7j09A
	/Qkeq0+4k3LHJ93EkcYaMAYau2SaETZg=
X-Google-Smtp-Source: AGHT+IEGCCiKDJLJCENo6kUx0hJBVCZ+uyR95fRlqylKafkB0DIx4T37LrRehxoiB6BAszat+PQ+3QAULARoETwGtaQ=
X-Received: by 2002:a05:6808:8295:b0:40c:5b58:c9f9 with SMTP id
 5614622812f47-40c5b58cbd0mr2167344b6e.22.1751549314163; Thu, 03 Jul 2025
 06:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703124215.12522-1-sebott@redhat.com>
In-Reply-To: <20250703124215.12522-1-sebott@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 15:28:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huBwxiop1ZJ7reXyir42vjgm7xehn+xnhfe7RDwu9EGQ@mail.gmail.com>
X-Gm-Features: Ac12FXzcYgXGY6ZNRymAann1Y9vXuuLgUvTVdkLDdAJaW4gBU1eKxfhu8qmNQJY
Message-ID: <CAJZ5v0huBwxiop1ZJ7reXyir42vjgm7xehn+xnhfe7RDwu9EGQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: fix acpi_object initialization
To: Sebastian Ott <sebott@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:42=E2=80=AFPM Sebastian Ott <sebott@redhat.com> wr=
ote:
>
> Initialization of the local acpi_object in acpi_processor_get_info()
> only sets the first 4 bytes to zero and is thus incomplete. This is
> indicated by messages like:
>         acpi ACPI0007:be: Invalid PBLK length [166288104]
>
> Fix this by initializing all 16 bytes of the processor member of that
> union.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7cf6101cb4c7..2a99f5eb6962 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -275,7 +275,7 @@ static inline int acpi_processor_hotadd_init(struct a=
cpi_processor *pr,
>
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
> -       union acpi_object object =3D { 0 };
> +       union acpi_object object =3D { .processor =3D { 0 } };
>         struct acpi_buffer buffer =3D { sizeof(union acpi_object), &objec=
t };
>         struct acpi_processor *pr =3D acpi_driver_data(device);
>         int device_declaration =3D 0;
> --

Applied as 6.17 material, thanks!

