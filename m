Return-Path: <linux-acpi+bounces-11265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE6A3A507
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9523C3B18A9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F7271265;
	Tue, 18 Feb 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCUakSCA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AB18CC15;
	Tue, 18 Feb 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902315; cv=none; b=ZNC7f/TxhtcxKNh38YIUFqI7oxGUTy4YTCbQC6KMpL69m78efI8bWTRWdqknxiE00uyShV0lnBe6uq8ITZP3gBRbLYu2+KioyBFjuSggwVjKmY/7hWKmjOjrr1LCTYm7MeIh8KA1DjFwLibS4en63DiMd9BMg+jjRkBVxoIONzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902315; c=relaxed/simple;
	bh=L6jtfNthTsF7txY6fasnR3MOiegSAMuJbAVTkGdQhZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myo4CjlWcjJktqBjO6UXu9dpj9MjF8w0ELxrnFwr+hzuOrdYMWqGmWpm5t+03acNhl6GU3NL0LTiSpXcTk1+ePD0NGxiDgLup9tQppwzpMQ4glMa3qudrUu8XbAp8Zw8mso9JsT6jIXXBBZpPJtExZ1TmfsR6390mHfvlArPobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCUakSCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B9C4CEE4;
	Tue, 18 Feb 2025 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739902314;
	bh=L6jtfNthTsF7txY6fasnR3MOiegSAMuJbAVTkGdQhZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OCUakSCARiXqgyyR98tTnw+eQVZicfk5wR1CwOqW+mhd8ZwGmQf4N+w8cqxeiK0L0
	 dFKEiL64XZSPBLYXaJXhFj1YrGT5P7njLITAAepf7lxT/PQKtyisMgpLwEzvgNpcGd
	 a/LbC26HIg572QH/v4SDI3TgTXHT5bWLa6nI48Nj0BXaZyR3E7f/sEMNQjOuuEI+ZC
	 h6ev6I3Hb0aEXTX4/JbbLyE8KSAw26g5Pz+Y+4IxU8Saq2Q6qByNueGLNSqyjSjk9T
	 6sSYUePpgfHHC9c/2MX2NQAzyU4q1l9mzHro3F5PCwUkcLme+ecvMHF/wnJcYHeIto
	 5qQ9wpr9kHQBA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fa2685c5c0so2858648eaf.3;
        Tue, 18 Feb 2025 10:11:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+1WZaiq9klDQ1Ka+HsHZx7b2I1CUZIe2fUATtrKDezrNjyy81PTuN7CvGu+qITkB0MJ6H5MmwltBOE+ai@vger.kernel.org, AJvYcCWcSrmBNF3cpihQSCMxGKDZ9V+4vl3J76RWclbEY0XTLkB86w9GPXnFCJnAx8Llkuw/LxJ6D9joeXO2@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxYNlyX1+4dfxfSQjwYJxuK6OkCwGX1cvJxHoV79fQXq2dpS1
	kFf8JE2mV5ZIkHprO+UnJx8+0cus65ag4ug67Qgfi3ZxGh/Lo32hPGtQ1m8fpR7dnZCC/MyxjV5
	0A+STjyLRsH5MQQS+FUuxWe9pHt8=
X-Google-Smtp-Source: AGHT+IHra6W26CYn3h0Ps8XpOzMvEj6sdAECD9RxyFP9m9PND/S8EZ/XFVkJjJOUlcShUMiDIKUgEvdThbAw+HaSk1E=
X-Received: by 2002:a05:6808:23d6:b0:3f4:9ae:cd60 with SMTP id
 5614622812f47-3f409aecf88mr2719780b6e.13.1739902313819; Tue, 18 Feb 2025
 10:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211104532.699124-1-thorsten.blum@linux.dev>
In-Reply-To: <20250211104532.699124-1-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:11:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gW6E9hnhYbf+bG_8ERR3PqYQ8tMv_j+-MptZEv3awvnA@mail.gmail.com>
X-Gm-Features: AWEUYZnoOEG4QxY-6lBGLYpiJHR8wKfKyOA45Iwy_8vxgFE5dL8J_AUKqq5dg0A
Message-ID: <CAJZ5v0gW6E9hnhYbf+bG_8ERR3PqYQ8tMv_j+-MptZEv3awvnA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ACPI: video: Use str_yes_no() helper in acpi_video_bus_add()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:45=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Remove hard-coded strings by using the str_yes_no() helper function.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/acpi/acpi_video.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index a972831dbd66..efdadc74e3f4 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -27,6 +27,7 @@
>  #include <linux/acpi.h>
>  #include <acpi/video.h>
>  #include <linux/uaccess.h>
> +#include <linux/string_choices.h>
>
>  #define ACPI_VIDEO_BUS_NAME            "Video Bus"
>  #define ACPI_VIDEO_DEVICE_NAME         "Video Device"
> @@ -2039,9 +2040,9 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>
>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> -              video->flags.multihead ? "yes" : "no",
> -              video->flags.rom ? "yes" : "no",
> -              video->flags.post ? "yes" : "no");
> +              str_yes_no(video->flags.multihead),
> +              str_yes_no(video->flags.rom),
> +              str_yes_no(video->flags.post));
>         mutex_lock(&video_list_lock);
>         list_add_tail(&video->entry, &video_bus_head);
>         mutex_unlock(&video_list_lock);
> --

Applied with changelog edits as 6.15 material, thanks!

