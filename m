Return-Path: <linux-acpi+bounces-1718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF5E7F3793
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EB428239D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796B54663
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F4D45;
	Tue, 21 Nov 2023 12:06:01 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f5ccc1ca61so791729fac.0;
        Tue, 21 Nov 2023 12:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597160; x=1701201960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZdmFrIm/sdRXr/gN6Rcmkno5GanwFZMzxl8GvUJAxk=;
        b=MgNK0ywecweAs4S5/i2nik+5fozXUsRPCpmUbsdwfl+RXc5oD/0di3xHnbOUD4K3pJ
         oVRRhnT7Uv7ZLKF7QcPMymqY7P/q4zaVffrOHMV9oehlCVReIwW8rvqILk2Ite4SCJQz
         BswfPrj9Y4/HSAaHx892LoQqsXj9M6lQZtjE3HpHepZgjyUpE7GsR8LnErX9zURrWpX5
         qh1C+WZX5a4TAKEv7O20JTjXKRbSMRPYEk+N4hIUw9a9z9s0RdZ39gfcomKVWhs9Fuu4
         nBsQwyG9dMd1SgrLsklNOfUqgN9ogoll3r5iRzn1l3Ap4wJa9gJdHqDUjbzXLNedc6uy
         zG4Q==
X-Gm-Message-State: AOJu0Yz7poZRt+8qaDfF7ZnUHUZoW0zkjGo/Hj81KudcH39yXDCCbVfK
	roGJqsakI9JKEFFC6mWYhpD5zzQD+LnKxmr58VE=
X-Google-Smtp-Source: AGHT+IEUTj1Q2x9aQhHHr04XswTW5/vAfHw6sCqC93RK+4mY7Oj098zk0VNw2dddy2WYd0nD4mZbYocawm3vAlqS36I=
X-Received: by 2002:a05:6870:7a18:b0:1e9:9440:fe4a with SMTP id
 hf24-20020a0568707a1800b001e99440fe4amr372851oab.3.1700597160593; Tue, 21 Nov
 2023 12:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
In-Reply-To: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 21:05:49 +0100
Message-ID: <CAJZ5v0hxkoeFYVxQ_ZYCMK+0L=7WdBQHRp6ouv+FzahfMrs_eQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSL: Initialize output value
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, 
	Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 8:45=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
> Buffer variable for result (value32) is not initialized.
> This can lead to unexpected behavior, if underlying platform-specific
> raw_pci_read fails to report error (uninitialized value will be treated
> as valid pci-read result), or exposition of unexpected data to PCI
> config space reader.
>
> Zeroing of buffer value addresses the later problem and makes the
> behavior in the former case somewhat more predictable.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c5f0231ee6b0 ("ACPICA: Fix acpi_os_read_pci_configuration prototyp=
e")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/osl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index c09cc3c68633..d3c0f7f01a29 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -788,7 +788,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id
> *pci_id, u32 reg,
>                                u64 *value, u32 width)
>   {
>         int result, size;
> -       u32 value32;
> +       u32 value32 =3D 0U;

So wouldn't it be better to avoid modifying *value at all if
raw_pci_read() returns an error?

And if it returns a success, why wouldn't it be trusted?

>         if (!value)
>                 return AE_BAD_PARAMETER;
> --

