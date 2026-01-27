Return-Path: <linux-acpi+bounces-20690-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLFeE5omeWkIvwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20690-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:56:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4859A7F4
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4009C300A776
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A6288C0E;
	Tue, 27 Jan 2026 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpoWTUdF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228452877DE
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547402; cv=none; b=VB8H7YfFGXF9/eh9WtRelvxrGIn9Ey5XJVMJMf/SXa4XlONIq6yNfmFUZB7kefxShq60EIxUadP7OXCtwpIC25Ypxu/p6/ikx8+mPYv2umUE1G7tF6LoxpQ5d6ujpNCV/WAB3DjxdqLeGhBZu4AP6VgdYq9hRGbewJE47CtJ7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547402; c=relaxed/simple;
	bh=jhqmI9JhqrIgXCaKZuPUYXAbZvttEx3objorN5xi3Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cua2M0q8YuHOJd/lwq8jbVAoHmhmOy2YB0VYef8Z4rZrPGv0L0nOU/USE7DGINWFxoURQOwQg+iz4RiGy7ZNZibR+XmrK+5eW+ExlAuTM77O3e8I7RMtvYUkvmzHkpZOBgHf97K7n0F6P55pf1DFpMMlzIL8Wx7GhU0O4RmC0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpoWTUdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC8C2BCB3
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547401;
	bh=jhqmI9JhqrIgXCaKZuPUYXAbZvttEx3objorN5xi3Rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fpoWTUdFkMkGKAc/+2G+cRJjPgzhet5HWc8CgXCp4tohmBODLPkFz15oXSfcxAd0L
	 5jQuxMh/FYd0QQzlGPCS9tU42999JyZSOrWbeZdiWPgxeRJRk3Ps8K3/EAitav7xkP
	 2R3ScXvftWm+0QFlVDI84o9/CQmlKBfrbQOxAID2B7MOlzfV5xH803r+KjXdSmTciF
	 MQDg3Y0sSfEHhOLLiiJQ84RjHpfcnsjQPIcLX2tglySHft4tSMkL+oV0TtFvWMQJKs
	 qfLSSJBqHg3wDul1q//IBxp0Em8j6jWQUvhqD2ha1BA2w0Uv8vGWB+wmPKu+Zs1rML
	 OeqLRIOoC3ybw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so2855895fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 12:56:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqgHdAGFZ+km73sR8vIDsyX//IF11M+RXX5UZqrwVfKDaDjgTcigxoHOgwN9+8h7Rpt+CqN1kvFtCu@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhkVz9TE77yLdnz+ar0JNxHVulS9WIaBgOHZhC/6lWrZ84ESa
	KSE247oICkxGMBmoOYDqb18rh/79bHEpmvcvNf5UQJz9gtbiKoQkzL1midByy6FW4kyM1egrZKE
	PO7jY+A9UyAyGf0AtDQ0EpVrRs6aybBA=
X-Received: by 2002:a05:6820:4888:b0:65f:70b5:1a89 with SMTP id
 006d021491bc7-662f20b3034mr1608291eaf.49.1769547400740; Tue, 27 Jan 2026
 12:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126070427.64574-1-yang.yicong@picoheart.com>
In-Reply-To: <20260126070427.64574-1-yang.yicong@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 21:56:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0igWB+c1ER15_0FSEBXfAaAUBXRwx3K_rt-POdsAYui8Q@mail.gmail.com>
X-Gm-Features: AZwV_QjF0PrSdbh1XYKAYW1Yp9dO9FuE4lVyBbj2_o71QnFScZ9f8mtTic6l7Hw
Message-ID: <CAJZ5v0igWB+c1ER15_0FSEBXfAaAUBXRwx3K_rt-POdsAYui8Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20690-lists,linux-acpi=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[picoheart.com:server fail,sea.lore.kernel.org:server fail,mail.gmail.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AE4859A7F4
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:04=E2=80=AFAM Yicong Yang <yang.yicong@picoheart.=
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
> Change since v1:
> Refine the commit message to:
> - include the issues and the analysis
> - include the reason for using the async schedule rather than
>   a dedicated workqueue
> Link: https://lore.kernel.org/linux-riscv/20260122073446.45628-2-yang.yic=
ong@picoheart.com/
>
>  drivers/acpi/scan.c | 40 ++++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..64fcbd6a6adc 100644
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
> @@ -2360,44 +2361,35 @@ static int acpi_dev_get_next_consumer_dev_cb(stru=
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
> +       if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev=
))
> +               return false;
>
>         return true;

What about doing

    return !!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev);

here?

>  }
> --

