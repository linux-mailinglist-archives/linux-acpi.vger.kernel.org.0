Return-Path: <linux-acpi+bounces-15604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD434B22804
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C12567742
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A035267B02;
	Tue, 12 Aug 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/GQv5V9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244E265292;
	Tue, 12 Aug 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004077; cv=none; b=b5ZA/SxF5i2w5pOKCrgijOEpcq4Jpd7UI6Iqm21YHZEumrVgmeW0SluWV9fH5VVnON/XBnY82Rb5FF9vp1CUij+XFwVgaaQN5XlEayMFPzv3GxLuOhW4h2m+epMQOqIZtlHYRSGQAlqvgsMpFn3VjJsFynlO35XxGNQbDNisgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004077; c=relaxed/simple;
	bh=Cra1VPgbqnASPwX8o008CBcKLCeKaqYIpAhZOh46rzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQD9i0IzW691T3N3rndXy+EAI58RKikkgtWouxUvAFTy8Tdbg+eIjuLQ5L8G4MiRCCcRpSzGObBIqXnHHxkRXu9IeH96Yaj8O9yi4Ux505M3YX+PrJoZcBkF8iqH6BCSqy9W+BwajAbmQN31DuYTAIq1Y+Z4DX+cdNGVq/rEGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/GQv5V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9660C4CEF7;
	Tue, 12 Aug 2025 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004076;
	bh=Cra1VPgbqnASPwX8o008CBcKLCeKaqYIpAhZOh46rzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A/GQv5V90QgF5pUSQoVc+FeRWo0V5jaapnKyY3mFglLrRHAQRq15rPON2CQezZTk1
	 r9IZCrCh2iDIgaRqPKkvCYJOkeFOpO/ISYzxFGj6spFmsDm4USsneWT8TfRlgH3PBZ
	 ZouVl0cYN1JaRsCwTa4+K0wLmbh3DugaPA1pSA0vfOScm7huxW04VrlaCWSOjC6OGT
	 HABcJz5QuoaZ2+MiWaZ5QpZaI2wVD10Xoo15XWbZT4ovAjdGSXDPXZdkTOg2651KZ1
	 4UhUm/k6gnvQR68b/yMSKxAbBgtcqmagQLqi1l7Z3wHFEmnUfgk7SFOImeZ5UTDTtC
	 /CNUgFdxTViOQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61b4b90fb87so2560140eaf.0;
        Tue, 12 Aug 2025 06:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ4dIAbVZu7FXUFWGCFLoWj33kFeIDN8RQGtizufZNuKTFYeg7PJH7tPT1gG+U8ZeYY9XfkEHlobhF@vger.kernel.org, AJvYcCXy7IWpC1QbAXhVeIqdlICmXng5sOrVR+dcG0y+udI9pQC3NsyryzDIRxl9mhTPzKKs235Mmwz/zS//+Hhb@vger.kernel.org
X-Gm-Message-State: AOJu0YychOaQ6RHW0C4akSR5hdjPbV9ubd7MbsjGJsloCWDBGPyKCcmh
	JxTkZKYhjyEa27lse7/bcxMZYh45EEJqH07Lv66K/u8CHdMQCxVhmX7FrZvfKH/dmdmEDzrzauR
	Uf1KziNKcZXoK4NV2uNanar81LECqV44=
X-Google-Smtp-Source: AGHT+IGv7LOZVB5K28j8sX+pAtpnHEFpK8LB9mW/TbmqQNamcmCY4gLxEhEDPz/2PhkTifKVBiRtrCqa4qK1YjNoCNQ=
X-Received: by 2002:a05:6820:1505:b0:619:844f:2d0e with SMTP id
 006d021491bc7-61bb5d76de1mr1952119eaf.8.1755004076146; Tue, 12 Aug 2025
 06:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803153829.6545-1-dikshakdevgan@gmail.com>
In-Reply-To: <20250803153829.6545-1-dikshakdevgan@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 15:07:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_StL59p=4bD8eQ_40KjtJy293b-M2NfA_HsCPLU_Q-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwBGOMThivpFYUw6DAginI5SpADUYvNeakxOMxvm_gjhC3zmPxgw9rigaU
Message-ID: <CAJZ5v0i_StL59p=4bD8eQ_40KjtJy293b-M2NfA_HsCPLU_Q-Q@mail.gmail.com>
Subject: Re: [PATCH V2] acpi: remove unnecessary parenthesis from return statement
To: Diksha Kumari <dikshakdevgan@gmail.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 5:39=E2=80=AFPM Diksha Kumari <dikshakdevgan@gmail.c=
om> wrote:
>
> checkpatch.pl is generating a warning when return value is enclosed
> in parenthesis. Remove the parenthesis to improve code readability.

Teach checkpatch.pl to skip the ACPICA code instead.  Seriously.

This code is generated semi-automatically out of the upstream ACPICA
code hosted on GitHub and it follows its own code-style rules.  Don't
change it manually unless you have made a corresponding change
upstream.

Thanks!

> Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
> ---
>  drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconv=
ert.c
> index 8dbab6932049..5f53388b6f1e 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -31,9 +31,8 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 =
*return_value)
>
>         /* Digit must be ascii [0-9a-fA-F] */
>
> -       if (!isxdigit(hex_char)) {
> -               return (AE_BAD_HEX_CONSTANT);
> -       }
> +       if (!isxdigit(hex_char))
> +               return AE_BAD_HEX_CONSTANT;
>
>         if (hex_char <=3D 0x39) {
>                 value =3D (u8)(hex_char - 0x30);
> @@ -42,7 +41,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8 =
*return_value)
>         }
>
>         *return_value =3D value;
> -       return (AE_OK);
> +       return AE_OK;
>  }
>
>  /***********************************************************************=
********
> @@ -68,19 +67,17 @@ static acpi_status acpi_db_hex_byte_to_binary(char *h=
ex_byte, u8 *return_value)
>         /* High byte */
>
>         status =3D acpi_db_hex_char_to_value(hex_byte[0], &local0);
> -       if (ACPI_FAILURE(status)) {
> -               return (status);
> -       }
> +       if (ACPI_FAILURE(status))
> +               return status;
>
>         /* Low byte */
>
>         status =3D acpi_db_hex_char_to_value(hex_byte[1], &local1);
> -       if (ACPI_FAILURE(status)) {
> -               return (status);
> -       }
> +       if (ACPI_FAILURE(status))
> +               return status;
>
>         *return_value =3D (u8)((local0 << 4) | local1);
> -       return (AE_OK);
> +       return AE_OK;
>  }
>
>  /***********************************************************************=
********
> @@ -122,9 +119,8 @@ acpi_db_convert_to_buffer(char *string, union acpi_ob=
ject *object)
>         }
>
>         buffer =3D ACPI_ALLOCATE(length);
> -       if (!buffer) {
> -               return (AE_NO_MEMORY);
> -       }
> +       if (!buffer)
> +               return AE_NO_MEMORY;
>
>         /* Convert the command line bytes to the buffer */
>
> @@ -132,7 +128,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_ob=
ject *object)
>                 status =3D acpi_db_hex_byte_to_binary(&string[i], &buffer=
[j]);
>                 if (ACPI_FAILURE(status)) {
>                         ACPI_FREE(buffer);
> -                       return (status);
> +                       return status;
>                 }
>
>                 j++;
> @@ -145,7 +141,7 @@ acpi_db_convert_to_buffer(char *string, union acpi_ob=
ject *object)
>         object->type =3D ACPI_TYPE_BUFFER;
>         object->buffer.pointer =3D buffer;
>         object->buffer.length =3D length;
> -       return (AE_OK);
> +       return AE_OK;
>  }
>
>  /***********************************************************************=
********
> @@ -175,7 +171,7 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>             ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>                                  sizeof(union acpi_object));
>         if (!elements)
> -               return (AE_NO_MEMORY);
> +               return AE_NO_MEMORY;
>
>         this =3D string;
>         for (i =3D 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> @@ -190,7 +186,7 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>                 if (ACPI_FAILURE(status)) {
>                         acpi_db_delete_objects(i + 1, elements);
>                         ACPI_FREE(elements);
> -                       return (status);
> +                       return status;
>                 }
>
>                 this =3D next;
> @@ -199,7 +195,7 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>         object->type =3D ACPI_TYPE_PACKAGE;
>         object->package.count =3D i;
>         object->package.elements =3D elements;
> -       return (AE_OK);
> +       return AE_OK;
>  }
>
>  /***********************************************************************=
********
> @@ -251,7 +247,7 @@ acpi_db_convert_to_object(acpi_object_type type,
>                 break;
>         }
>
> -       return (status);
> +       return status;
>  }
>
>  /***********************************************************************=
********
> @@ -272,9 +268,8 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *p=
ld_info)
>         u32 dword;
>
>         buffer =3D ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
> -       if (!buffer) {
> -               return (NULL);
> -       }
> +       if (!buffer)
> +               return NULL;
>
>         /* First 32 bits */
>
> @@ -331,7 +326,7 @@ u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *p=
ld_info)
>                 ACPI_MOVE_32_TO_32(&buffer[4], &dword);
>         }
>
> -       return (ACPI_CAST_PTR(u8, buffer));
> +       return ACPI_CAST_PTR(u8, buffer);
>  }
>
>  /***********************************************************************=
********
> --
> 2.34.1
>

