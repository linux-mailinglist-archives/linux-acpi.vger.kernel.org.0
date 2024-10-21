Return-Path: <linux-acpi+bounces-8872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF849A6697
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB01281BC8
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912E194C62;
	Mon, 21 Oct 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7lJvJhG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F78946C;
	Mon, 21 Oct 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510316; cv=none; b=pyWgqKeXFMWYAQVcfsm6hN8rUkq8t0EMBU225ej430oNUTeKlv53p/cW28a8jm1ENAqWxfHBPosevrPXef7iKxPbVVrRXUs3mesqEs/7UJ3uoAuqm+eFSPc/0sVSbu+yQymIqKOcht2OFJpDXz2bioXy0ABjGa0VypBt9q5KAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510316; c=relaxed/simple;
	bh=J0zBoYFiOTykW8Law91kLm0hJhEtQJW6lJdP6o5iTI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXFYvWTlZMPumGyX/cTvxJBLbD/ZO0oie6++wVn43UP1wm+9UiJlsMOn2hgBpUE8uw76Dd2AK6oGks5zniat3tA/XkCbu8oHFOMMOMTT6eY6yCVtu+JFzNp6wNw2Ugusf9WKn7vywhvEmIOf8tHvwoWhQHrgLGpsx42fKrE07rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7lJvJhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E145FC4CEE6;
	Mon, 21 Oct 2024 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510315;
	bh=J0zBoYFiOTykW8Law91kLm0hJhEtQJW6lJdP6o5iTI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7lJvJhGUrxWU2WIY+OI4ktOJEJSJxz33ISShrZpu9ynwuV/uj9iPKkOPEixZIsCF
	 7nAZMNGREsUlJbrxmmrGZS4MiCo/5tqHhh7F3R9wSCRE2f68Fq6nkWKgNN1mpZf1wF
	 8MYmiu5yeJ/nzMaw0tRbTIu6+aAxDUOYmZZ7Z5U/6RlkdU5oQvSt6+/c39FTeBGPTQ
	 5VnqcjClgyUYetB7bVeYLvkXSDg3VB1vk3Sl+qP3P/nRjvxAbKdb6dwzRVkb+xFroN
	 E/4hwruP19EtYqXUz7gAeCxOJZ6PkdR3AeGatPNUNJdfgKIIjDiKYWFtW4jg2eAfQA
	 KPVQ7V6Ifx9SA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2884e7fad77so2184412fac.2;
        Mon, 21 Oct 2024 04:31:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1oGkgwONKj8zdGjtYbKDO2BoAn5HjjSdt3WNMp2Husfunz3r4M/6v65eoOuvBStn8TkeTFheuT8s6C/Na@vger.kernel.org, AJvYcCVDzkUEhDDf5u89Xp+N7WzwLswwvQtIbK8dcHv2FmfGNjvOx1+VFsOjswONlUDaNdjseUC5X011u4aY@vger.kernel.org
X-Gm-Message-State: AOJu0YyEB5CLjK1YXu+YxjNxSL4lI1zfyqspUclKu9yhkc2Y2NcBkbEq
	P4715IzW5ot55Rxg4dM8kXgRTqmEB1F35Jr97n9AW6tb5RTZ/NbytphdZXtkslirB4GAxxWKAcQ
	wml3fG5tWUZLK1Az0OABrriLpSKs=
X-Google-Smtp-Source: AGHT+IFt4ge8WV0JxcxW1+Jvsk3+SEx6KoTHso5Pd7ODssDknRfmMMHS4dTVUQVgmAgWsNQQaJ8yLdnfkV8OSTU/RD4=
X-Received: by 2002:a05:6870:b28c:b0:27b:583b:bfa8 with SMTP id
 586e51a60fabf-2892c302f6bmr7955282fac.17.1729510315090; Mon, 21 Oct 2024
 04:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017035940.4067922-1-payamm@google.com>
In-Reply-To: <20241017035940.4067922-1-payamm@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:31:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbg_5VLCT3cXgK4WkCTwNAUGrUuRe66DoCHf6xydsTzQ@mail.gmail.com>
Message-ID: <CAJZ5v0hbg_5VLCT3cXgK4WkCTwNAUGrUuRe66DoCHf6xydsTzQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: zero-initialize acpi_object union structure
To: Payam Moradshahi <payamm@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 5:59=E2=80=AFAM Payam Moradshahi <payamm@google.com=
> wrote:
>
> The way in which acpi_object union is being initialized varies based on
> compiler type, version and flags used. Some will zero-initialize the
> entire union structure and some will only initialize the first N-bytes
> of the union structure.

Any details?

> This could lead to uninitialized union members.

So this is working around a compiler bug AFAICS.

If the compiler has this bug, is it guaranteed to compile the rest of
the kernel correctly?

> This bug was confirmed by observing non-zero value for object->processor
> structure variables.

Where has it been observed?  What compiler version(s)? etc.

> non-zero initialized members of acpi_object union structure causes
> incorrect error reporting by the driver.
>
> If a BIOS is using "Device" statement as opposed to "Processor"
> statement, object variable may contain uninitialized members causing the
> driver to report "Invalid PBLK length" incorrectly.
>
> Using memset to zero-initialize the union structure fixes this issue and
> also removes the dependency of this function on compiler versions and
> flags being used.
>
> Tested: Tested on ARM64 hardware that was printing this error and
> confirmed the prints were gone.
>
> Also confirmed this does not cause regression on ARM64 and X86
> machines.
>
> Signed-off-by: Payam Moradshahi <payamm@google.com>
> ---
>  drivers/acpi/acpi_processor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7cf6101cb4c73..6696ad4937d21 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -275,7 +275,7 @@ static inline int acpi_processor_hotadd_init(struct a=
cpi_processor *pr,
>
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
> -       union acpi_object object =3D { 0 };
> +       union acpi_object object;
>         struct acpi_buffer buffer =3D { sizeof(union acpi_object), &objec=
t };
>         struct acpi_processor *pr =3D acpi_driver_data(device);
>         int device_declaration =3D 0;
> @@ -284,6 +284,8 @@ static int acpi_processor_get_info(struct acpi_device=
 *device)
>         unsigned long long value;
>         int ret;
>
> +       memset(&object, 0, sizeof(union acpi_object));
> +
>         acpi_processor_errata();
>
>         /*
> --

