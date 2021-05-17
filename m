Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935F43832F0
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbhEQOwn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:52:43 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:42791 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbhEQOum (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:50:42 -0400
Received: by mail-oo1-f51.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso1517914oop.9;
        Mon, 17 May 2021 07:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He+qVgUj6KmNb1BGjrbB0Gl63WV0jKVgGssDWDzSwlg=;
        b=lv04GtrJVnx1tnGbc9q1GoskNBgxH34FIyTrv9OdzCIXiL+6UMjpsEHs22ecF3TkA6
         uhZNaBsjQKb5rERcbNJh4jtMXCGnHUTNnsekQYyq8d72LUccC29xz0q6plYf/IOioBUT
         hsfJdkdFwDBqGDW+y/9XbvskGlF6PWDgrqpBJk4yRbH6Zmlkt3jKodXeP5K2es+cNm2l
         pfYmfi5nPkwbcn1d8KMbiayGJ0HligD3sVwU0ZkTw467lV2BDOy4vZzb9sxM7Wr6jv2e
         Uh2kJryzihapcC51l/o4a/hwlLG7rkQ8CfKGqscFTVPa4+nlIrU4nitzwlG9YbberTIl
         sw7g==
X-Gm-Message-State: AOAM533Kr+Vo6t86eShRphjurqG19kOqQEBrSjpsinI1XKQoVCw1gne7
        iQ5RdFN87FHppDLGVfjqa/F7CmRJnpAZC25TnE1cdeFe
X-Google-Smtp-Source: ABdhPJzle0JCLdOfG5zyvu1FOGayw2+umxep8vskH1QiHjZ34VMsXM7C500k/wzWoP9cwYQSShgPIdsoRqx46E4J0dk=
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr251394oon.2.1621262966086;
 Mon, 17 May 2021 07:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210428193901.rqs64di4g2svpaeg@ubuntu>
In-Reply-To: <20210428193901.rqs64di4g2svpaeg@ubuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:49:15 +0200
Message-ID: <CAJZ5v0iCG7WT_hpvJ006_TpVjAeY-SB7z76c2Y5Payu215nk+g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: pnp: proc.c: Removed unnecessary variables
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 9:39 PM Anupama K Patil
<anupamakpatil123@gmail.com> wrote:
>
> de, e are two variables of the type 'struct proc_dir_entry'
> which can be removed to save memory. This also fixes a coding style
> issue reported by checkpatch where we are suggested to make assignment
> outside the if statement.
>
> Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> ---
> v2: Added Reviewed-by: tag
>
>  drivers/pnp/isapnp/proc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..1ae458c02656 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>  static int isapnp_proc_attach_device(struct pnp_dev *dev)
>  {
>         struct pnp_card *bus = dev->card;
> -       struct proc_dir_entry *de, *e;
>         char name[16];
>
> -       if (!(de = bus->procdir)) {
> +       if (!bus->procdir) {
>                 sprintf(name, "%02x", bus->number);
> -               de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> -               if (!de)
> +               bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> +               if (!bus->procdir)
>                         return -ENOMEM;
>         }
>         sprintf(name, "%02x", dev->number);
> -       e = dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, de,
> +       dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
>                                             &isapnp_proc_bus_proc_ops, dev);
> -       if (!e)
> +       if (!dev->procent)
>                 return -ENOMEM;
> -       proc_set_size(e, 256);
> +       proc_set_size(dev->procent, 256);
>         return 0;
>  }
>
> --

Applied as 5.14 material with edits in the subject and changelog, thanks!
