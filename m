Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D185430629E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhA0RvK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 12:51:10 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35940 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbhA0Ruh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 12:50:37 -0500
Received: by mail-ot1-f53.google.com with SMTP id d7so2525645otf.3;
        Wed, 27 Jan 2021 09:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VoZdlg6p8iKV4bxfDFnDFvMGki24ayGxNON2rUTw6k=;
        b=UGhOCUO9IuC5yKuNCWP878b12TYkBolHDZ9zEV8YsgSMX/Ygin9dXcwdJLUoRV1tAI
         KY3NRn+/NWtzZYjGmwVh0y70RbCfoScHIorqVIhZJ9PtuXgMGln90iU1/zW+raLGS13Z
         QB8VziIUJDbYv0TnHromg5u2UpcspfxqIyBaXu/A5j9/K5MsjgwC/+bsfRyajCoVC3qT
         KTQk6IQifmoXaOgjqTjlBxv0oIMCZnU0bzN5qHBeVYNmmC5Zldz+2tHSPwAcQu2AShDp
         DuiBvasnn0JnND3zD7PAXc7WfzileF6URJMVxs6+iR9Cygi3/25EJaGOhRwmyZwsI7XS
         fQ1Q==
X-Gm-Message-State: AOAM533xGo1fXMni+/lg4gfdsHBzHA7X9RxvFYV2hBKO88lsj0Xa5NYZ
        /e8lK6dlVqZp1UAn1BGRG7mnPs9oIDBUdlSLKp4=
X-Google-Smtp-Source: ABdhPJz+yNXOk/Wso29oVIlbS7Yd6sAVLzL8R5I+WOUlhG1roQuEKVLkWo1oJ/dyhtAfXJNQN32CWom0gmk5m99/xI0=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr8693115ote.321.1611769797090;
 Wed, 27 Jan 2021 09:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20210125190909.4384-1-hdegoede@redhat.com> <20210125190909.4384-2-hdegoede@redhat.com>
In-Reply-To: <20210125190909.4384-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 18:49:46 +0100
Message-ID: <CAJZ5v0guG91aM6eiH51H1tVRbsLOWRveKse=q+qy7=tTBEaibw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 3:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> After a rmmod thinkpad_acpi, lockdep pointed out this possible deadlock:
>
> Our _show and _store sysfs attr functions get called with the kn->active
> lock held for the sysfs attr and then take the profile_lock.
> sysfs_remove_group() also takes the kn->active lock for the sysfs attr,
> so if we call it with the profile_lock held, then we get an ABBA deadlock.
>
> platform_profile_remove() must only be called by drivers which have
> first *successfully* called platform_profile_register(). Anything else
> is a driver bug. So the check for cur_profile being set before calling
> sysfs_remove_group() is not necessary and it can be dropped.
>
> It is safe to call sysfs_remove_group() without holding the profile_lock
> since the attr-group group cannot be re-added until after we clear
> cur_profile.
>
> Change platform_profile_remove() to only hold the profile_lock while
> clearing the cur_profile, fixing the deadlock.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied on top of the previous platform-profile material, thanks!

> ---
>  drivers/acpi/platform_profile.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 80e9df427eb8..4a59c5993bde 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -164,13 +164,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>
>  int platform_profile_remove(void)
>  {
> -       mutex_lock(&profile_lock);
> -       if (!cur_profile) {
> -               mutex_unlock(&profile_lock);
> -               return -ENODEV;
> -       }
> -
>         sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
> +       mutex_lock(&profile_lock);
>         cur_profile = NULL;
>         mutex_unlock(&profile_lock);
>         return 0;
> --
> 2.29.2
>
