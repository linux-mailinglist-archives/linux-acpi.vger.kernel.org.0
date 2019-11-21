Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B8105BC6
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 22:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKUVT4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 16:19:56 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34801 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKUVT4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 16:19:56 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so4808166ilp.1;
        Thu, 21 Nov 2019 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWHhuoQC9uamMGap6hzAY+6LMUghB4KA3RWaxoG6378=;
        b=vfdmju/Pck7qwDgz74JZ92ybIBMvNU+AlllDsoTSSOVYMKnAJlOzxOIBcvXbjki88u
         XIClFncS37ENzvmz3yq4Ia+G/Tb/+0WVj6RHIgQYAdFMYFWKb1QmQHKmHMALAaLk5MOZ
         yinpK6fc5lkMJ5PlNj2eJ+YTVq1Xge8rEemTx8WXdIPzGQQtRjK8k3iA+QoIkRhBKjXM
         XmNtimyvNrxrjNsDzoKc29l2zxCjSAZue4cyS67Xyd/Lon6kaRv2ZGtle7wUwzc87u/c
         X+L7g692tYBjp15hFRAtqLbqB3fQpuanBpGjK9dlDerM1+EdVBCtVhqHXoZkrvVL+evE
         Q1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWHhuoQC9uamMGap6hzAY+6LMUghB4KA3RWaxoG6378=;
        b=o03l/fEe5S4uOklMILWrt1rHGqxJjyLy9LNozKjdI1xvv1WJHM8vKoYGtmUDkp3Qi2
         ZpcmywQ/qKicGXjkM7d4svE9lGa4Ax12M46lNS59JmxbjMxA3rdPbcGMEpAUioqfWmfT
         ERlfCqg1oa9wsL0gxq+c/2TrKFk2ghxxlINsfdnT31FrkeIB53zVN670NNdxBx5vglJO
         x68z/E1JVClZ8jvchIL5RPKd3/mCH81Vvhu7YRu7555jUoSvy1RSkA9Tef5il0iYGc3E
         PABaOPmb5ZNGMvt7bc45l/jFf7WYVKX4t3dKq0uX7c7FomgUIHVGAXWjreT5t4HgV6HO
         dYDw==
X-Gm-Message-State: APjAAAUzwPOicHeBhH8sz0jZius1SvU64ksz9DTf3QdiBH/37WCt+OOx
        Lw+lX1UkIRINIfNc+CV9dNBgIc2OU4LkjDaOpDs=
X-Google-Smtp-Source: APXvYqwZdWGYeVpdsOe2FD6TChURf5kz2k54m79DXjL/ozNIpm90g5TEPJz5Dabxey5rsRdeV80w6YwF3ac4ayPomvc=
X-Received: by 2002:a92:b109:: with SMTP id t9mr12242806ilh.144.1574371195019;
 Thu, 21 Nov 2019 13:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
In-Reply-To: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 21 Nov 2019 21:19:43 +0000
Message-ID: <CAJwJo6ZTSw93zKdN3i-YqVtEEwh4qWc22Hk-emHvJth+HsaQbQ@mail.gmail.com>
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

Hi Francesco,

I believe, there's still an issue with your patch.

On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
> @@ -472,10 +477,11 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>                 mutex_unlock(&acpi_ioremap_lock);
>                 return;
>         }
> -       acpi_os_drop_map_ref(map);
> +       refcount = acpi_os_drop_map_ref(map);
>         mutex_unlock(&acpi_ioremap_lock);

Here comes acpi_os_get_iomem() increasing the refcount again.

>
> -       acpi_os_map_cleanup(map);
> +       if (!refcount)
> +               acpi_os_map_cleanup(map);
>  }
>  EXPORT_SYMBOL(acpi_os_unmap_generic_address);

And you free the acpi_ioremap that's being used:

>  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>  {
> -       if (!map->refcount) {
> -               synchronize_rcu_expedited();
> -               acpi_unmap(map->phys, map->virt);
> -               kfree(map);
> -       }
> +       synchronize_rcu_expedited();
> +       acpi_unmap(map->phys, map->virt);
> +       kfree(map);
>  }

Thanks,
             Dmitry
