Return-Path: <linux-acpi+bounces-14276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3CBAD4239
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829103A4D58
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9924A064;
	Tue, 10 Jun 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEWTAoAy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23324679E;
	Tue, 10 Jun 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581361; cv=none; b=Gdk77y339q+fMPYOvoxLlncAsvJ/7f3np/vZUhWO+dJgmW6TquWITT6oVo20L/uydySsICbnnsdQCb5yqJoXiLYrykz+CRTIVcyglo/rw8jQkBi2mn4W5zejPA3ERw+NjoVmWaAoquS5W0ZnvFG5bdTZ/Kb1+7R5PjeRvOFg4eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581361; c=relaxed/simple;
	bh=qUiwFa7AM1VEN+Lw4QKBNhdckuQLX1RyTY7pmz0nqOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0NLwdYH2vquFSjtIaCm3WJYLfvfOZfguwUYAvaJhpm/5yYv4bmGdUGF+3Yx3BweQ8ynLZJH74aAq+V8pfkIWSKJsD4LO6gxalnPcjg+xX96qhGLQgFXVnbPLP+V7m0qJGgVg0Z+X6U2ACbhqrciju94dYHNF/ZsMt2lkbOo2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEWTAoAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148AAC4CEF0;
	Tue, 10 Jun 2025 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581361;
	bh=qUiwFa7AM1VEN+Lw4QKBNhdckuQLX1RyTY7pmz0nqOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BEWTAoAy+YV2uYT/tTNaF9Dcw2pbYzv29X8bxstpeCAo0K94fJcojLdoC2XTfAZ0c
	 N+et58XoiL/fjstKAmSIGqzQ/G5fqZoqwDsuqQhkK8xcvw50/r4Jg1bPAh2sBRVXBt
	 0aA4twRBY1TAZ0sDHv+Me0UXYQgq/Z6NxZ/blR+WlkB3wFSto3LGnc9NkClOtL8xB2
	 I9CVVS4ijr6mL+50KtWsZTjHJVy+kfH+/2Ay8YlBWsr1QNy+71L/FKTWme1hrr5ynj
	 3gyBmxsVXYDZz1vtZV5aFRAgfy0Abp9Cgf9HgzURQN2xQ7B1csj0MagGQMreLaK84t
	 f0Goi8cPCBPDw==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fb01566184so48103006d6.1;
        Tue, 10 Jun 2025 11:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOvzXmPpcOvhZcobbP7xkpuR2ZJhfBgxTyRpa4SqAxqhhYMATS0a1ysOSf4HIkPs252kpJ3wWg7tLgncA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRd8zMB6M5xH/svZWJkjPnW10portgqWwsVO1mFqI7b2lbBopj
	zhH0Ywi7MnyRolFEgOqmnE5OeTxUsc5hRRC1Fwp96iU+2zar938HHeAflbMzLcItpU7wMNqTSiY
	Ij7ylk6cm02ViIK1hzEucHNIE0COwglQ=
X-Google-Smtp-Source: AGHT+IFz62GAyIKh5lmKRhH1ktkgrURaG7uL9lohEJUSlctWiF+ydUnVxRNLdZeIbi0Q4+eNMbX+ILUypt+AXSNR7cE=
X-Received: by 2002:a05:6820:3085:b0:60b:ad9e:2bbf with SMTP id
 006d021491bc7-610ef7c5734mr163663eaf.8.1749581349162; Tue, 10 Jun 2025
 11:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609064235.49146-1-ubizjak@gmail.com>
In-Reply-To: <20250609064235.49146-1-ubizjak@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 20:48:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQJ3rX1Es+MTdqkD80ewufAgJ6whiWDHtCWJ0vvVBPtA@mail.gmail.com>
X-Gm-Features: AX0GCFsY0PQv2-FgRRdDg5dFeSrLiFR_jheI-wAsxzrYmVatR1EOgYBUG_uvyns
Message-ID: <CAJZ5v0jQJ3rX1Es+MTdqkD80ewufAgJ6whiWDHtCWJ0vvVBPtA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_pad: Update arguments of mwait_idle_with_hints()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:42=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> Commit a17b37a3f416 ("x86/idle: Change arguments of mwait_idle_with_hints=
() to u32")
> changed the type of arguments of mwait_idle_with_hints() from unsigned
> long to u32. Change the type of variables in the call to
> mwait_idle_with_hints() to unsigned int to follow the change.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/acpi_pad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 6f8bbe1247a5..c9a0bcaba2e4 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -33,7 +33,7 @@
>  static DEFINE_MUTEX(isolated_cpus_lock);
>  static DEFINE_MUTEX(round_robin_lock);
>
> -static unsigned long power_saving_mwait_eax;
> +static unsigned int power_saving_mwait_eax;
>
>  static unsigned char tsc_detected_unstable;
>  static unsigned char tsc_marked_unstable;
> --

Applied as 6.16-rc material, thanks!

