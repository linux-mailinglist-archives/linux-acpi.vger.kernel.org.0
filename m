Return-Path: <linux-acpi+bounces-2327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4680F6AD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 20:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A771C20C33
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773581E4F;
	Tue, 12 Dec 2023 19:30:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3C94;
	Tue, 12 Dec 2023 11:30:04 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5908b15f43eso479541eaf.1;
        Tue, 12 Dec 2023 11:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409404; x=1703014204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRKkCewynBnoUEfEV1iQ0hY5piRTK7NxRZDv0HhmpCk=;
        b=dQb/cj4EOFndEDhRh9D8+UjgGnQD8Mkn8NVkZH+s/SX7MbuxqY0/58NJF31R/Uogw4
         voswYVcCGNA5L+eA6D08WPm3EP8T2iPy2TSVBMDuKw9CSXtB2Gh/3lPGJ4kcYJ/My0O2
         5L7PdmHPFUHaYSAiwPNkqKPT/rBqap/1TEp1xA4zO/6TU3n/huejIFIH9O6Jku2+fHdc
         PJj+d7ImqWbtRXdgrXGD03ggjk4+JuG89fT4DzTjQBsc/UnIuk6HJ+lPAljlgeG20Lyc
         pcxd0HfhhDK3f6G/SOixcqU5nMpZYmZRX99qcnZSYYczMkDnL3M5Gp+fh/uzQKB2OlBO
         zsLg==
X-Gm-Message-State: AOJu0YyioZma9kGsKCOmRaRxFkcLkmHcDCupWhtHkqpuKZD7YLdPStBa
	yaY53XlM0vM8VJKlf4UPC9u9wwInCbXjmDyvirqaOEap
X-Google-Smtp-Source: AGHT+IG1h2jd1fJkxMNnyA+yoJj/GniGrfHBuQzNL3e1bAlKa4hQQp4/DofaVdGmYKGvNSlIT2Bc/414S7c0IUN6IQI=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13870325oob.1.1702409404156; Tue, 12
 Dec 2023 11:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205225045.32121-1-rdunlap@infradead.org>
In-Reply-To: <20231205225045.32121-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:29:52 +0100
Message-ID: <CAJZ5v0g6mZkhm84AU_LahCfKixRTj5AutFZfuCnLE0kcGxPGxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: watchdog: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:50=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix kernel-doc warnings found when using "W=3D1".
>
> acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a =
kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> acpi_watchdog.c:85: warning: missing initial short description on line:
>  * Returns true if this system should prefer ACPI based watchdog instead =
of
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/acpi_watchdog.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -81,7 +81,7 @@ static const struct acpi_table_wdat *acp
>         return wdat;
>  }
>
> -/**
> +/*
>   * Returns true if this system should prefer ACPI based watchdog instead=
 of
>   * the native one (which are typically the same hardware).
>   */

Applied as 6.8 material, thanks!

