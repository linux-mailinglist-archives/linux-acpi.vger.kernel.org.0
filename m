Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA346296337
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Oct 2020 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902190AbgJVRAM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Oct 2020 13:00:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43744 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902192AbgJVRAM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2020 13:00:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id k68so2101624otk.10;
        Thu, 22 Oct 2020 10:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhY/+goENh+uMPXH9AN4+1ASRSuDIs6jlBTZohR8f0A=;
        b=lW9knr+tv1BGCH9mEFH+Ro9DvVXZalD3vcbxI6fMrYa6xHYG7NQghGxSBkO+zY1skp
         b1dwpq8tIkptxBabtcBFbt5MgKY8dYmjC8C1Om1OJXxUsmlWsEXYQEbtYQe388dLpKPP
         aD0wYbr9yCphG3tqJTikMmzMRkWij1a3kt1oovHvKWHupuDmVcx1Jm+aA0a1garVXoqC
         X8+lvfSbFFCuQ9WbYg4Mtj5a2SEmwOr7o433bcCYqYfeqt/ntkpWH/5nVd54K4LUcZH5
         7Kw2T1lgqsyKa8owh3aR1vzXLGsuk/vlC8/rVx8cFhWO2H00WRg49SHLeoeRNwlrZHxN
         NdjQ==
X-Gm-Message-State: AOAM533fTTOu5tzr+5KvKOG4JVIUicpLHsmXuBH2okYCg3WWCkv0tjkW
        foSdeRDEhyU5ZAITJGxTCVPkN7e4oRgdlZ1iap0=
X-Google-Smtp-Source: ABdhPJwQwFMd5tqWC3eFnRySPxSn75mTBabC9StOcwSledQjIo3+fttoH5OLtoW/qSQ44OLVy/YLy/0huJJpyVchZGE=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr2699189otk.260.1603386009213;
 Thu, 22 Oct 2020 10:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201019200453.16864-1-trix@redhat.com>
In-Reply-To: <20201019200453.16864-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 18:59:58 +0200
Message-ID: <CAJZ5v0gbBb6tXy8R06=5Rmhud4m=FZiu7fW9oDo4+20n_BsZog@mail.gmail.com>
Subject: Re: [PATCH] acpi: utils: remove unneeded break
To:     trix@redhat.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 19, 2020 at 10:05 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/acpi/utils.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 838b719ec7ce..d5411a166685 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -104,7 +104,6 @@ acpi_extract_package(union acpi_object *package,
>                                               " [%c]\n",
>                                               i, format_string[i]);
>                                 return AE_BAD_DATA;
> -                               break;
>                         }
>                         break;
>
> @@ -129,7 +128,6 @@ acpi_extract_package(union acpi_object *package,
>                                               " expecting [%c]\n",
>                                               i, format_string[i]);
>                                 return AE_BAD_DATA;
> -                               break;
>                         }
>                         break;
>                 case ACPI_TYPE_LOCAL_REFERENCE:
> @@ -144,7 +142,6 @@ acpi_extract_package(union acpi_object *package,
>                                               " expecting [%c]\n",
>                                               i, format_string[i]);
>                                 return AE_BAD_DATA;
> -                               break;
>                         }
>                         break;
>
> @@ -155,7 +152,6 @@ acpi_extract_package(union acpi_object *package,
>                                           i));
>                         /* TBD: handle nested packages... */
>                         return AE_SUPPORT;
> -                       break;
>                 }
>         }
>
> --

Applied as 5.10-rc material with subject and changelog edits, thanks!
