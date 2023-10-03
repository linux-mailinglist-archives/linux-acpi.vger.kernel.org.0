Return-Path: <linux-acpi+bounces-378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DC7B6BC9
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3251281725
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA031A89
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426523758
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:59:40 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA271AB;
	Tue,  3 Oct 2023 06:59:38 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b68555467so81057eaf.0;
        Tue, 03 Oct 2023 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696341578; x=1696946378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq1Clg4a1kKbu7pmXR4HdVffolvp2P+JTuU/UrDnGUQ=;
        b=EC6wudZeSVJtwtc9NEoz17y3ukbVOOzhosy/qaoVpniclG1P6sLnMtqHcv5B1+21CA
         BIopuxTnZx/hNOefH02unwlFzYt3cS5EcY70pWyWJM7V9rajCvcznup5GmkuU5aVxk8l
         t2SqkmsmC7fkJsPCzDI8xkn3xEgQR8IouCUmuYgcsre3ug0DzIDorWM2DF8QVL3nTbC7
         l6FOJxxQWmUP/1/79T9WBHMqpXzHfWfiuOGuskKAJSzWuXsw7rn60wfE5V8/F1X5fUo+
         /bF15IiOFvV/p1uSZMlcLiNxuj3Z9sFMvcx+UjafTRZ1frIjnZwNKXDz24hy2PkGIFgf
         9svg==
X-Gm-Message-State: AOJu0YxSriwA5aHeTt76azPs59g6PoZAc6hI//h8f4ov7mgQ0eyc5Cdn
	rmoH7G8Wpixljm6J1QjxHi+MTcHClaOND9qZfZA=
X-Google-Smtp-Source: AGHT+IFPU3gZRpubYTBPXLnn2ap+DdEYPgfKr0BV5Ro2mPw3Pj481PgTJd+av7mBFohs06B5Vaojab+D16Dgp+FbQf4=
X-Received: by 2002:a4a:2542:0:b0:57b:3b64:7ea5 with SMTP id
 v2-20020a4a2542000000b0057b3b647ea5mr12208047ooe.1.1696341578006; Tue, 03 Oct
 2023 06:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 15:59:26 +0200
Message-ID: <CAJZ5v0ib_N_ojhoC_z9YCOgmT7q2zy1jMBAFc=pmBmrX-j5Drg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: property: Allow _DSD buffer data only for
 byte accessors
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 3:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In accordance with ACPI specificication and _DSD data buffer
> representation the data there is an array of bytes. Hence,
> accessing it with something longer will create a sparse data
> which is against of how device property APIs work in general
> and also not defined in the ACPI specification (see [1]).
> Fix the code to emit an error if non-byte accessor is used to
> retrieve _DSD buffer data.
>
> Fixes: 369af6bf2c28 ("ACPI: property: Read buffer properties as integers"=
)
> Link: https://uefi.org/specs/ACPI/6.5/19_ASL_Reference.html#buffer-declar=
e-buffer-object [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied along with the [2/2] as 6.7 material.

> ---
>  drivers/acpi/property.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 413e4fcadcaf..06550d8c619d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1102,25 +1102,25 @@ static int acpi_data_prop_read(const struct acpi_=
device_data *data,
>         switch (proptype) {
>         case DEV_PROP_STRING:
>                 break;
> -       case DEV_PROP_U8 ... DEV_PROP_U64:
> +       default:
>                 if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                         if (nval > obj->buffer.length)
>                                 return -EOVERFLOW;
> -                       break;
> +               } else {
> +                       if (nval > obj->package.count)
> +                               return -EOVERFLOW;
>                 }
> -               fallthrough;
> -       default:
> -               if (nval > obj->package.count)
> -                       return -EOVERFLOW;
>                 break;
>         }
>         if (nval =3D=3D 0)
>                 return -EINVAL;
>
> -       if (obj->type !=3D ACPI_TYPE_BUFFER)
> -               items =3D obj->package.elements;
> -       else
> +       if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> +               if (proptype !=3D DEV_PROP_U8)
> +                       return -EPROTO;
>                 items =3D obj;
> +       } else
> +               items =3D obj->package.elements;

The braces that are missing here (as per the coding style) were added
while applying the patch.

>
>         switch (proptype) {
>         case DEV_PROP_U8:
> --

Thanks!

