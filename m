Return-Path: <linux-acpi+bounces-20747-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AoTDh96emkC7AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20747-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 22:05:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61EDA8EE8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 22:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05633014777
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2842376BF2;
	Wed, 28 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+ZLoujw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81637646A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634332; cv=none; b=LgU3ePGRdnY3UcjoqaSfX0kmWsUQLHIibdubgUquRrbYOlG8haDHSiBgtorF1Lvl5SQbLJ0xVej7NicmQfORmall7koMGDz9k8f1y236m98I4HHdOVUxkg8by7gRMRHe2Q+SWrBg6ImeXZGGc9F8cP1KXhrdlQI54kFoWym3pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634332; c=relaxed/simple;
	bh=NgrRq4o1L7r38FwOhKpRHvhj1gslFKnkb8X6Mt0E+2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QihPTzshR04AWLW4RSqOSsHSQNPuyErEAp6dwBow1y/P8JDCQPvSQoCK3WxvokbrWeIR0cu+/CCpNhavZve6FttcI3J4ggLrmgjOBWpKSwC30a5I2XqdDXdGF2Hymnoi9Z5ra9Upt1wtNjAoQrMwgs+pCDzIFd0of58HjgynT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+ZLoujw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F8C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634332;
	bh=NgrRq4o1L7r38FwOhKpRHvhj1gslFKnkb8X6Mt0E+2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h+ZLoujwO3j+4qRMwqwJLnBGnTHRgre1cGvZ2xu02TB/fOMGNfFSBeXv9NZU7OSOs
	 zCw0BsbYRmQ2XNsUa/e5Lclzn1rN9Pgn8qOeRTb+Haqod2S5r2o6vfpjrp8AUW4QmI
	 2CQkp8CwFekKKb1xaFCqxgd5dyt6ShPxVtMUFKFeYBpmxNcGRZ0a+ZUVecvkrc1MY3
	 SqqQCC65uUybg+l+eP8r4oIcKdFBX84rj9JvLv1PdwD7a4qqQp7KAl2ga6DeFHKpXl
	 3I0FgunKHJqDtzpkxzk4uF+9PKz5dDoIHp+vQJt1pQBuwAM3seKJPs2Y4EPw/sj0fJ
	 zTnje5a8gEQRg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f0dbe7dafso141445b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 13:05:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWshXjNhlkvtE3Q46daEzBrpv37OfU1J3T5c3XetuW9kKKwHtIBRK/qsW7ppWzTNOyAAlwj4+JgSsrK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Bk/epN8k8kfesP+OAIDHtQgs6Tm3YtDif7Su5rJu5tKlE/nV
	fl2uBsChnplCleYlQFF1KZnkGujJzOtfVMmdGenZqkdU62JN5ERF8cSh7DFl+9FQu+zMHeK/IJY
	ocFtNPLm4iI5xkW5vdWGfI5dlgtirEog=
X-Received: by 2002:a05:6820:7058:b0:662:f42e:7cfe with SMTP id
 006d021491bc7-662f42e82e9mr2919779eaf.54.1769634331217; Wed, 28 Jan 2026
 13:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128132848.93638-1-yang.yicong@picoheart.com>
In-Reply-To: <20260128132848.93638-1-yang.yicong@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 22:05:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZxEtkyY8EgvaZPSBDG20jw5UaVDKP0nvcQwf_wOVJ2Q@mail.gmail.com>
X-Gm-Features: AZwV_QjWDlmR50mAHWtl2Dyyjj-B_lHLZDTuZb8q7OjCNTZmGbxFlCcl5stEUo4
Message-ID: <CAJZ5v0hZxEtkyY8EgvaZPSBDG20jw5UaVDKP0nvcQwf_wOVJ2Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20747-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[picoheart.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A61EDA8EE8
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 2:29=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> The device object rescan in acpi_scan_clear_dep_fn is scheduled
> in the system workqueue which is not guaranteed to be finished
> before entering userspace. This will cause the problem that
> some key devices are missing when userspace init task tries to
> find them. Two issues observed on our RISCV platforms:
>
> - kernel panic due to userspace init cannot have an opened
>   console. the console device scanning is queued by
>   acpi_scan_clear_dep_queue and not finished by the time
>   userspace init process running, thus by the time userspace
>   init running, no console is created
> - entering rescue shell due to no root devices (PCIe nvme in
>   our case) found. same reason as above, the PCIe host bridge
>   scanning is queued in above and finished after init process
>   running.
>
> The reason is because both devices (console, PCIe host bridge)
> depend on riscv-aplic irqchip to serve their interrupts (console's
> wired interrupt and PCI's INTx interrupts). In order to keep the
> dependency these devices are scanned and created after riscv-aplic
> initialized. The riscv-aplic is initialized in device_initcall and
> queue the device scan work with acpi_scan_clear_dep_queue, it's
> close to the time running userspace init process. Since system_dfl_wq
> is used in acpi_scan_clear_dep_queue and no synchronization,
> the issues will happen if userspace init runs before these devices
> are ready.
>
> The solution is to wait for the queued work finished before
> entering userspace init. One possible way is to use a dedicated
> workqueue instead of the system_dfl_wq, and explicitly flush
> it somewhere in the initcall stage before entering userspace.
> One other way is to use async_schedule_dev_nocall() for these
> device scanning. It's designed for asynchronous initialization
> and will work same as before since it's using a dedicated
> unbound workqueue as well, but the kernel init code will
> wait for the work finished (async_synchronize_full) right before
> entering userspace init.
>
> This patch use the second approach. Compared to a dedicated
> workqueue, it's simpler since the async schedule framework have
> handled most works like synchronization, memory allocation of
> works and workqueue. The ACPI code only needs to focus on its
> work. A dedicated workqueue for this could also be redundant
> since some platforms don't need acpi_scan_clear_dep_queue()
> for their device scanning.
>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
> Change since v2:
> - minor code cleanup for return path per Rafael
> Link: https://lore.kernel.org/all/20260126070427.64574-1-yang.yicong@pico=
heart.com/
>
> Change since v1:
> Refine the commit message to:
> - include the issues and the analysis
> - include the reason for using the async schedule rather than
>   a dedicated workqueue
> Link: https://lore.kernel.org/linux-riscv/20260122073446.45628-2-yang.yic=
ong@picoheart.com/
>
>  drivers/acpi/scan.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..b78f6be2f946 100644
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
> @@ -2360,46 +2361,34 @@ static int acpi_dev_get_next_consumer_dev_cb(stru=
ct acpi_dep_data *dep, void *da
>         return 0;
>  }
>
> -struct acpi_scan_clear_dep_work {
> -       struct work_struct work;
> -       struct acpi_device *adev;
> -};
> -
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
> +        *   before userspace init task by the async_synchronize_full()
> +        *   barrier
> +        *
> +        * Use _nocall variant since it'll return on failure instead of
> +        * run the function synchronously.
>          */
> -       queue_work(system_dfl_wq, &cdw->work);
> -
> -       return true;
> +       return async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->d=
ev);
>  }
>
>  static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
> --

Applied as 6.20 material, thanks!

