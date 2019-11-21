Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D620105CEA
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 23:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUW6f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 17:58:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40147 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUW6f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 17:58:35 -0500
Received: by mail-io1-f67.google.com with SMTP id b26so3620076ion.7;
        Thu, 21 Nov 2019 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uN4hyE3BsXplYJBM6a2D+eSFwcm1JgVbWlkvWiQItuM=;
        b=GNXYPv+MoZ6ufzCOmzmZ3FbAGuNxZFHtzj2f+mLFc4MuUsi8YJcOkyliGl2bInzAI/
         e4Zy5nUd8r4M/WJuXHH69WsI5BOApmhlhe4xbO1CkywTpGBJvqAzk5kzq+IGGuq+HbPF
         CVGiIgsEzJNLWPQbB7z904ZoBU9uwh3kvmd0TjuMX3Gx1s+8e7Nps9W2iWA0lNaS/c88
         5B7REKcrpUQLMjkze2sYAD9dL0OHLNGUlcd34h7NHg9gVsCVES3P+6tciTQCSy8DuC23
         oKWi/dTAt+M5cVXwpI8DInfw8Iznpdpz5JLa23QtpB8QGgoHb+XzGfrmyOtXJyITE9tE
         /dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uN4hyE3BsXplYJBM6a2D+eSFwcm1JgVbWlkvWiQItuM=;
        b=tflF5XoMxZOPv6EiYQWSla8GvLGizFjnICYeY3ZBL32FbzRocSnPG828X4l1JQyd4R
         qb7nXMJTyqU5cAL/xtrexo0mLXS5b8PzeFqm+6HfuuUf8gTGSyp4Z8zldySb8qewWvHY
         Ee0K6zb+VLHLgg5te9MhYXKo2HqSMRbD+3KJak5YHqi1kuAVsBO7PFGv5RZJuJWQbACf
         LeHxKESNJ41XPp2kcBS+hZi3036lZmDWR4KOplQVjYQr+Q05sTCkt/XVinXzze+TKMiH
         zSBsB5QaF5dZwNa1sLGWk1J/R5VMGniswiq+K4dis3rhEON3CWf2Ewn8ybG84dNpTKZR
         7UCQ==
X-Gm-Message-State: APjAAAUTB3xtsAypHmO1xZrLfxTZmIY0krPLT1jcYSxFbsWBO8+b3y7k
        ROdnqThtHrPWlaJ6J7KF4nLuoJcXkh4/96O8FyY=
X-Google-Smtp-Source: APXvYqxt2fyeSeuT7Rks7RsLI5P5xJkkHZ7JT6gT1o753wrBhnsAWRGn8abdnAlt9IuIed0B6IO1Ba87ARUD4oQ+9Z8=
X-Received: by 2002:a02:6a02:: with SMTP id l2mr2823388jac.89.1574377112589;
 Thu, 21 Nov 2019 14:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
In-Reply-To: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 21 Nov 2019 22:58:21 +0000
Message-ID: <CAJwJo6bu0Hkmneg=DuwN=v_G4pkm1JQnUWKEVcudJD5L0pjLiw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: only free map once in osl.c
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
>
> acpi_os_map_cleanup checks map->refcount outside of acpi_ioremap_lock
> before freeing the map. This creates a race condition the can result
> in the map being freed more than once.
> A panic can be caused by running
>
> for ((i=0; i<10; i++))
> do
>         for ((j=0; j<100000; j++))
>         do
>                 cat /sys/firmware/acpi/tables/data/BERT >/dev/null
>         done &
> done
>
> This patch makes sure that only the process that drops the reference
> to 0 does the freeing.
>
> Fixes: b7c1fadd6c2e ("ACPI: Do not use krefs under a mutex in osl.c")
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
             Dmitry
