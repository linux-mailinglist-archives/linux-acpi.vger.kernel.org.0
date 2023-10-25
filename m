Return-Path: <linux-acpi+bounces-966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F47D6ED5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A51C20359
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F42AB2B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA78467
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:57:06 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB7116;
	Wed, 25 Oct 2023 05:57:04 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b413cc2789so266761b6e.0;
        Wed, 25 Oct 2023 05:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238624; x=1698843424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXkd9CYREbxYom8qIlZV1H5Ayph53CXojJYgpfSQsTw=;
        b=vrxX2PXkT8LPmUYJwTtMZAOHW85b/2vrED+MvJ8RZPLHKZCiQ/S/sV1Cjg/gsaaXoh
         QTb6osh42WwOkVAM+m7X+jVO7VPislGyThYw+5kWNyfSmCoHaohGlRKvLCdRdevvZKXj
         WY9cYO0Vvr/cGC8o24Jmk0ANimye8YU8OD/+TIUxYtjH0ZqlBJFfncyJoTpzW44doEdX
         4le9YYXKN3VslCv6gCirItOlHlTgzEaz8GEhe6d0QIrtMSA4q5qFU5QW1Spd13afYtiy
         7hZSZ+KJQKCA1nHJ6xqCf8K5I8DRTUGezuQPlhfitYUiahA+xSozTUkocnPiyCfHZVj3
         7EGQ==
X-Gm-Message-State: AOJu0YzvG+oEtr6k9tVzQwb57gqIiftUSvpoNeStvOj7/L+edqVLrZuE
	6Iir+KRyKz2XrPGbrbVPRTpuUbvtXBxjwfAh6tuzJOfx
X-Google-Smtp-Source: AGHT+IFa57Vto1+bpGsZj3Sj3ypmLBQMvnjG7z1p5RFQwODE2222n3Z8mQbF79uS7Hlc0CSFdJ/R9suLFz2Epg+GHck=
X-Received: by 2002:a05:6870:818d:b0:1ea:6883:99ff with SMTP id
 k13-20020a056870818d00b001ea688399ffmr16936693oae.5.1698238624011; Wed, 25
 Oct 2023 05:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 14:56:52 +0200
Message-ID: <CAJZ5v0gPhG2VB4p4oXuJ36Qoj-BSEbs1kRyb8jPGVDekk06dJg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Replace acpi_driver with platform_driver
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 2:34=E2=80=AFPM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> This patchset is a continuation of efforts from [1] aiming to replace
> acpi_driver with platform_driver. To ease up review effort I'm sending
> miniseries per driver, with a replacement patch + various improvements
> that were noticed by me, or during internal review.
>
> This mini-series takes care of acpi_video driver.
>
> [1] - https://lore.kernel.org/linux-acpi/20231011083334.3987477-1-michal.=
wilczynski@intel.com/T/#t
>
> Michal Wilczynski (6):
>   ACPI: acpi_video: Remove unnecessary checks
>   ACPI: acpi_video: Use yes_or_no helper instead of ternary operator
>   ACPI: acpi_video: Remove unnecessary driver_data clear
>   ACPI: acpi_video: Replace acpi_driver with platform_driver
>   ACPI: acpi_video: Rename ACPI device instances from device to adev
>   ACPI: acpi_video: Fix holes in acpi_video_bus
>
>  drivers/acpi/acpi_video.c | 101 +++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 55 deletions(-)
>
> --

Because this is not going to get into 6.7 anyway, I'm deferring the
review of it until 6.7-rc1 is out.

Thanks!

