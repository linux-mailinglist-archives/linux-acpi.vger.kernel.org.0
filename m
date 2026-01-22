Return-Path: <linux-acpi+bounces-20536-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOxYC2AKcmmOagAAu9opvQ
	(envelope-from <linux-acpi+bounces-20536-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:30:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE36602F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1097A707570
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68B436375;
	Thu, 22 Jan 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuB+H2PK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F71436362
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080772; cv=none; b=qOM3ELxUA/zWpLrCNOVvCnl3aXbxkPNrG93HOk1SvU4L3KBP6hNhGjsv6jSdyZwsqbPgmhJ9iuSG/RnQWzLALiVmxGi9k3Q/CmhQExXNiuSTmX9PV8hDJAiD5hIeb+q3IZqagATa65DTSLjEfDlKCXg/Lu8xdHJlSMUGDrso5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080772; c=relaxed/simple;
	bh=h2ozgJA/BVuNcMltVMhZP2i6dw0T5W63Gm0m34za7Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLYZw02+WJfIgjK392RJMc4leABfc5ABJCxbu3lFcuaXFvT5GLRdzze2pRb/yFbhtlTR7GAhP74Yt1xRDYA5WN/re5gjpK+zmpBsuP34CmfXR74+eSKeEBN910cLP73Q25GylswwfQ93lPcyYbsCOX0i2oDVrJJEMdFAUAhlPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuB+H2PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE43BC2BC86
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769080771;
	bh=h2ozgJA/BVuNcMltVMhZP2i6dw0T5W63Gm0m34za7Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cuB+H2PK14zSIcIX6iAWogVlkcFlvOu+XXQu5g1xyVWp6DPbFcNayisJ7dGEs8P/u
	 nIRnlYcsUEncbU7XcT1jiHF+O8EMEjJ2sMCIMt5usp5CEaZ5SZ6yqRSYpd+yf7c69S
	 KJBc9PHcWJoT/9JqvwSlKdrdrs+rc9Vq4pggcDlZYLqmgvcStl18tGQ5S3rZZeBkgO
	 2LLr7Hg+d2+yVYrbJ9hMP6Ks7wuiajD+RRFKOvhSSTlXKcylbwoGimIg5VjSdd7xXH
	 WyVJYWG0i/WKaigqtqXJNvqzWZ8ANZaZqj6mgYyvWZlJr9kTYmZRqEbodgEXmXaFx3
	 CqVgpDg1OUFwA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45ca0d06eddso293725b6e.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 03:19:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5epPnnbRDLdG9tpaEiAP/Aor0N4sc1ZiFUqnxexsEOvz48sswxtT9TtSYeGzGIDs7y7j39BDpzzHv@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5pfhn4IpHBrtg2V526dkVIvaEu/xdzU7SCi92pBKs5n8veEm
	9qo8D4f0u6QaPrF4pQTLyls/VaTgXWcagcVZZBWH+iCNU61qg9ZGMR02KP7I6sNC7VUaKcuZh1m
	NTsKe6XUK1mZ3Htr6RuP4v97aknc1HJw=
X-Received: by 2002:a05:6808:3088:b0:44f:8bff:436e with SMTP id
 5614622812f47-45e8a8f79c3mr4689542b6e.12.1769080770867; Thu, 22 Jan 2026
 03:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073446.45628-1-yang.yicong@picoheart.com> <20260122073446.45628-2-yang.yicong@picoheart.com>
In-Reply-To: <20260122073446.45628-2-yang.yicong@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 12:19:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iwfk4hnj7Lf5hq3uo4p+_CT35ZwJUnenLOzOoGqQcsgw@mail.gmail.com>
X-Gm-Features: AZwV_QhNzuU2Fy-e_RlYyIapwi0uuwzQzar7ec644yn5HdlBYyoNH-OgGilwC8Y
Message-ID: <CAJZ5v0iwfk4hnj7Lf5hq3uo4p+_CT35ZwJUnenLOzOoGqQcsgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: rafael@kernel.org, lenb@kernel.org, tglx@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, akpm@linux-foundation.org, 
	apatel@ventanamicro.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, geshijian@picoheart.com, 
	weidong.wd@picoheart.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20536-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,picoheart.com:email]
X-Rspamd-Queue-Id: D3CE36602F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:35=E2=80=AFAM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> The device object rescan in acpi_scan_clear_dep_fn is scheduled
> in the system workqueue which is not guaranteed to be finished
> before entering userspace. This will cause the problem that
> some key devices are missed when the init task try to find them,
> e.g. console devices and root devices (PCIe nvme, etc).
> This issues is more possbile to happen on RISCV since these
> devices using GSI interrupt may depend on APLIC and will be
> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
>
> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
> schedule function rather than the system workqueue. The deferred
> works will be synchronized by async_synchronize_full() before
> entering init task.
>
> Update the comment as well.
>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..bf0d8ba9ba19 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -5,6 +5,7 @@
>
>  #define pr_fmt(fmt) "ACPI: " fmt
>
> +#include <linux/async.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
>         struct acpi_device *adev;
>  };
>
> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
>  {
> -       struct acpi_scan_clear_dep_work *cdw;
> -
> -       cdw =3D container_of(work, struct acpi_scan_clear_dep_work, work)=
;
> +       struct acpi_device *adev =3D to_acpi_device(dev);
>
>         acpi_scan_lock_acquire();
> -       acpi_bus_attach(cdw->adev, (void *)true);
> +       acpi_bus_attach(adev, (void *)true);
>         acpi_scan_lock_release();
>
> -       acpi_dev_put(cdw->adev);
> -       kfree(cdw);
> +       acpi_dev_put(adev);
>  }
>
>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
>  {
> -       struct acpi_scan_clear_dep_work *cdw;
> -
>         if (adev->dep_unmet)
>                 return false;
>
> -       cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
> -       if (!cdw)
> -               return false;
> -
> -       cdw->adev =3D adev;
> -       INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
>         /*
> -        * Since the work function may block on the lock until the entire
> -        * initial enumeration of devices is complete, put it into the un=
bound
> -        * workqueue.
> +        * Async schedule the deferred acpi_scan_clear_dep_fn() since:
> +        * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
> +        *   be acquired under acpi_dep_list_lock (held here)
> +        * - the deferred work at boot stage is ensured to be finished
> +        *   before entering init task by the async_synchronize_full()
> +        *   barrier
> +        *
> +        * Use _nocall variant since it'll return on failure instead of
> +        * run the function synchronously.
>          */
> -       queue_work(system_dfl_wq, &cdw->work);
> +       if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev=
))

If the problem is that system_dfl_wq is too slow, why don't you just
try a dedicated workqueue for this?

There's no need to modify all of this code.

> +               return false;
>
>         return true;
>  }
> --

