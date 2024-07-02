Return-Path: <linux-acpi+bounces-6745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EC9247E0
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 21:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C691C24B65
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1E1BBBF2;
	Tue,  2 Jul 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olg+0BXS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFA85298;
	Tue,  2 Jul 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947604; cv=none; b=r13G3t2uZRv6DrAKpUw6EqKyW0ik7pty99BXRjX5LE4T6iAFUcll5xlI9eGsAi/l+SNPadre4uJbyyuwZqInk0hEhDeDS2ndPavk0ZAJyqXAl/9bvHcB2lv85lh33yhXGPdslfR96USqLflGs79mXwq4EoAGkNHrS1ugWyzfmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947604; c=relaxed/simple;
	bh=rIpskRIrzPrNyKhqiwRashwSbyo2PIBjK6oaLiX0Pig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqT8Ddy+oJWyDgF6GUoPvsvAVUEOMjXJumAP38QA99IeFkBptyl5RnF9KitF7Tu5UTFOLOzzFqT1/JCJ1F6ZYaZI0gYn8HuAAEB5qyOuKX9ea2raOkC4ayU5xMS3dbdHHBJWAqcB62ikcZzAV+T03a0INtHeT8Xw34rvWPdqdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olg+0BXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C313C4AF0F;
	Tue,  2 Jul 2024 19:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719947604;
	bh=rIpskRIrzPrNyKhqiwRashwSbyo2PIBjK6oaLiX0Pig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Olg+0BXSkiYEbS2EjqZgWTXZs30pY/OQ+Xya2kMZo8zuPSd7EQH/aaQZw1AZ/FHQ0
	 AiQxBpsLIjcYWNPbIiwBz8OiLGRAZfpeR7GCA1m8GqQw6+5DK5JqMCFO9dXhjrfttZ
	 j4u4Ikf1FQeEOLGu5BceH9WUTup3QHg3vkxGrSuCLo3MQnaNJIUWlNLgojOzRLfN/v
	 sIudHQAufNfhcUy2tvcRcanKXe5ALHDi4Hb7wufXwMmVaBymBDTd9Fk+4PQ2e0NQnL
	 +Rtbx1a3eB2DYeP2U2iXlYLYQQrQD/A/QcojkiNg8TSt5LkUFjBW6oR99QBuRgMKOC
	 jcEleotlCVyFA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25dff23459cso73471fac.3;
        Tue, 02 Jul 2024 12:13:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrm/PNGXcDk7FVml0IjtS7yvqamSHS7N1Syi190tWqewK8yLwKX+u7YfVOp7QFJ+oPFFrRdxTc1F44tgyXx5snG1KvDtyEgs0Y8SCTQUS0vO+F7IRjt0F6KxWhPtOjKUFF7SOiVIviLQ==
X-Gm-Message-State: AOJu0Yyt6MiwqiOyI77bnRLoJC3qn/Sa24KgksBjhWoHk/681xIs6X45
	F/gsqc4Bl9/YSmQQAivTZjjCdgnoGd2V309R6h/t84yR7lG2MaNn0cPXIi2xoe7CbGAfUjCCR7S
	zunMD7ij6MD+R6RnnSsDhM+XTqBQ=
X-Google-Smtp-Source: AGHT+IE6Xtw8vsekKJBROnvTJMxwmFbwR9W8uRcbzFcq7ClLO6wpU/p0iDPyQxveWXniZHHgRCYxXOHPxI3vOnnIQOI=
X-Received: by 2002:a05:6870:c68a:b0:254:a7df:721b with SMTP id
 586e51a60fabf-25db36a5391mr9903731fac.5.1719947603513; Tue, 02 Jul 2024
 12:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620085147.1097187-1-hongao@uniontech.com>
In-Reply-To: <20240620085147.1097187-1-hongao@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 21:13:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQvu9hBY_yw2tVX26W=F=x_9em5LTQ2+JMe534Ay+UWg@mail.gmail.com>
Message-ID: <CAJZ5v0jQvu9hBY_yw2tVX26W=F=x_9em5LTQ2+JMe534Ay+UWg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: call input_free_device when
 input_register_device fails
To: hongao <hongao@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:52=E2=80=AFAM hongao <hongao@uniontech.com> wrot=
e:
>
> Call input_free_device when input_register_device fails.

And this is in order to address a memory leak, isn't it?

> Signed-off-by: hongao <hongao@uniontech.com>
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cc61020756be..8765e9a64404 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -602,8 +602,10 @@ static int acpi_button_add(struct acpi_device *devic=
e)
>
>         input_set_drvdata(input, device);
>         error =3D input_register_device(input);
> -       if (error)
> +       if (error) {
> +               input_free_device(input);
>                 goto err_remove_fs;

AFAICS, there is one other case in which something like this would
need to be done and it's better to rearrange the error handling to
cover all of these cases without duplicating input_free_device()
calls.

> +       }
>
>         switch (device->device_type) {
>         case ACPI_BUS_TYPE_POWER_BUTTON:
>
> base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
> --

