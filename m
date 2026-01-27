Return-Path: <linux-acpi+bounces-20691-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNlHAYEneWkIvwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20691-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:00:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536889A859
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC70303D337
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FD29B79B;
	Tue, 27 Jan 2026 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugb9wMc2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D1299A82
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547614; cv=none; b=ckvV5ItSVEW/C+u4FGtrmqVloiHB+CZH2cFHc7ULIrH/2qonNiJElm/nPA1xxM/g2yLkB+rRx4g8KY+Zb/BNr03QOnR7EmE2cyITjw7slj7c93wpW1qUL3kvWMNdAaX9iC54rOLLg8Dt2EczwjaY4JfTCGkH8qF6NLii2cnh1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547614; c=relaxed/simple;
	bh=OCOXUhmshX8lQ4RJexWvTZS+GGZvNYZYtOFoHXZ4TYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+SwCf4Kz8Q8HZISZqyv5GQT4SYTEoVJbbS7ESgK2PGMrmSPzdIQKBVsrXAYQzpL0oPB/PP55m+ph4wZ8NpvG1mFkVeo0g09BQaxLbacDZvaqnFY8CYoPQ0E5NloYDYhAD2r/CKGen4CVvqCRvy345MqPOS1yaWVo76wrtpSm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugb9wMc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CD9C19422
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547613;
	bh=OCOXUhmshX8lQ4RJexWvTZS+GGZvNYZYtOFoHXZ4TYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ugb9wMc2nBA6a47Gyd0ilGXSUlY6tZJ4AdNyMft+MqSo9tzSoPJ0FxkHYzaZdOg6s
	 HoURK8SBCJLQOgPpf6FjnS25w4fHwMBgdbThxZvsKZZfCmH6P+7+7wvuKlvpkvdgHc
	 qDwmgTYkAr/RfJ2cR9M9X8i3H6PiP1v4pUNrCj8D69ZZTkDigTw8lAJHkp+FQWB9Cs
	 R8N93UNXzgyGGPSatFLkn51yjhGrlJFxrQh9Y4SwCkaFGCHQI+zxProNeDfI3StOTp
	 KVkkiGAbrNWDvQiTPuvJQmAHDmDPjitcfX2WSeNOlyZ1LCTkxGYLfA0bix06aWHZp3
	 6DLSL1BXcQLug==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f87f4dddso129548eaf.3
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 13:00:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe0RhUAnQGQp0H6k8gHfJ2WklwcxRXC8yQBdnX5qW9fz9Utif7CzdLdOdTfFv1rjVn3Ifm3hQJUU/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+NK6AwEr/i3BDxkg+Nq+0vkmN90LE0VLS2CjWLWJc2g5pOjB
	CyhCyLnMRuG9we6E9Qu2hHg9G+DtC20H3NwiyAyCoPNlMGFVyFMl6FfDexUWB3Jb762QyAh1A+F
	aPehrqGyrHfVEgTTm6pK121cJigjJyQ4=
X-Received: by 2002:a05:6820:4df2:b0:662:ecc7:719d with SMTP id
 006d021491bc7-662f20aabbbmr1766269eaf.48.1769547612721; Tue, 27 Jan 2026
 13:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126093949.8910-1-sumeet4linux@gmail.com>
In-Reply-To: <20260126093949.8910-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 22:00:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpkxkG6SPwzUmpJSmDAjkBxEaT=y6CH7hRfxjdmyj4UQ@mail.gmail.com>
X-Gm-Features: AZwV_QiA_d9VmaYttY5mVgCTFnCKj2VgYloXXij9SCJj7klGJX4S8cFj3iVKdso
Message-ID: <CAJZ5v0hpkxkG6SPwzUmpJSmDAjkBxEaT=y6CH7hRfxjdmyj4UQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Replace sprintf with sysfs_emit
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20691-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 536889A859
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:40=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmai=
l.com> wrote:
>
> Replace all sprintf() calls with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred over sprintf() for formatting sysfs output
> as it provides better bounds checking and prevents potential buffer
> overflows.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/acpi/device_sysfs.c | 20 ++++++++++----------
>  drivers/acpi/sysfs.c        | 30 +++++++++++++++---------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index cd199fbe4dc9..a52dc35ff9ba 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -27,7 +27,7 @@ static ssize_t acpi_object_path(acpi_handle handle, cha=
r *buf)
>         if (result)
>                 return result;
>
> -       result =3D sprintf(buf, "%s\n", (char *)path.pointer);
> +       result =3D sysfs_emit(buf, "%s\n", (char *)path.pointer);
>         kfree(path.pointer);
>         return result;
>  }
> @@ -347,7 +347,7 @@ static ssize_t real_power_state_show(struct device *d=
ev,
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%s\n", acpi_power_state_string(state));
> +       return sysfs_emit(buf, "%s\n", acpi_power_state_string(state));
>  }
>
>  static DEVICE_ATTR_RO(real_power_state);
> @@ -357,7 +357,7 @@ static ssize_t power_state_show(struct device *dev,
>  {
>         struct acpi_device *adev =3D to_acpi_device(dev);
>
> -       return sprintf(buf, "%s\n", acpi_power_state_string(adev->power.s=
tate));
> +       return sysfs_emit(buf, "%s\n", acpi_power_state_string(adev->powe=
r.state));
>  }
>
>  static DEVICE_ATTR_RO(power_state);
> @@ -399,7 +399,7 @@ hid_show(struct device *dev, struct device_attribute =
*attr, char *buf)
>  {
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>
> -       return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
> +       return sysfs_emit(buf, "%s\n", acpi_device_hid(acpi_dev));
>  }
>  static DEVICE_ATTR_RO(hid);
>
> @@ -408,7 +408,7 @@ static ssize_t uid_show(struct device *dev,
>  {
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>
> -       return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
> +       return sysfs_emit(buf, "%s\n", acpi_device_uid(acpi_dev));
>  }
>  static DEVICE_ATTR_RO(uid);
>
> @@ -418,9 +418,9 @@ static ssize_t adr_show(struct device *dev,
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
>
>         if (acpi_dev->pnp.bus_address > U32_MAX)
> -               return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_addr=
ess);
> +               return sysfs_emit(buf, "0x%016llx\n", acpi_dev->pnp.bus_a=
ddress);
>         else
> -               return sprintf(buf, "0x%08llx\n", acpi_dev->pnp.bus_addre=
ss);
> +               return sysfs_emit(buf, "0x%08llx\n", acpi_dev->pnp.bus_ad=
dress);
>  }
>  static DEVICE_ATTR_RO(adr);
>
> @@ -482,7 +482,7 @@ sun_show(struct device *dev, struct device_attribute =
*attr,
>         if (ACPI_FAILURE(status))
>                 return -EIO;
>
> -       return sprintf(buf, "%llu\n", sun);
> +       return sysfs_emit(buf, "%llu\n", sun);
>  }
>  static DEVICE_ATTR_RO(sun);
>
> @@ -498,7 +498,7 @@ hrv_show(struct device *dev, struct device_attribute =
*attr,
>         if (ACPI_FAILURE(status))
>                 return -EIO;
>
> -       return sprintf(buf, "%llu\n", hrv);
> +       return sysfs_emit(buf, "%llu\n", hrv);
>  }
>  static DEVICE_ATTR_RO(hrv);
>
> @@ -513,7 +513,7 @@ static ssize_t status_show(struct device *dev, struct=
 device_attribute *attr,
>         if (ACPI_FAILURE(status))
>                 return -EIO;
>
> -       return sprintf(buf, "%llu\n", sta);
> +       return sysfs_emit(buf, "%llu\n", sta);
>  }
>  static DEVICE_ATTR_RO(status);
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index e596224302f4..1bd2f555e673 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -687,7 +687,7 @@ static ssize_t counter_show(struct kobject *kobj,
>             acpi_irq_not_handled;
>         all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
=3D
>             acpi_gpe_count;
> -       size =3D sprintf(buf, "%8u", all_counters[index].count);
> +       size =3D sysfs_emit(buf, "%8u", all_counters[index].count);
>
>         /* "gpe_all" or "sci" */
>         if (index >=3D num_gpes + ACPI_NUM_FIXED_EVENTS)
> @@ -698,29 +698,29 @@ static ssize_t counter_show(struct kobject *kobj,
>                 goto end;
>
>         if (status & ACPI_EVENT_FLAG_ENABLE_SET)
> -               size +=3D sprintf(buf + size, "  EN");
> +               size +=3D sysfs_emit_at(buf, size, "  EN");
>         else
> -               size +=3D sprintf(buf + size, "    ");
> +               size +=3D sysfs_emit_at(buf, size, "    ");
>         if (status & ACPI_EVENT_FLAG_STATUS_SET)
> -               size +=3D sprintf(buf + size, " STS");
> +               size +=3D sysfs_emit_at(buf, size, " STS");
>         else
> -               size +=3D sprintf(buf + size, "    ");
> +               size +=3D sysfs_emit_at(buf, size, "    ");
>
>         if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
> -               size +=3D sprintf(buf + size, " invalid     ");
> +               size +=3D sysfs_emit_at(buf, size, " invalid     ");
>         else if (status & ACPI_EVENT_FLAG_ENABLED)
> -               size +=3D sprintf(buf + size, " enabled     ");
> +               size +=3D sysfs_emit_at(buf, size, " enabled     ");
>         else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
> -               size +=3D sprintf(buf + size, " wake_enabled");
> +               size +=3D sysfs_emit_at(buf, size, " wake_enabled");
>         else
> -               size +=3D sprintf(buf + size, " disabled    ");
> +               size +=3D sysfs_emit_at(buf, size, " disabled    ");
>         if (status & ACPI_EVENT_FLAG_MASKED)
> -               size +=3D sprintf(buf + size, " masked  ");
> +               size +=3D sysfs_emit_at(buf, size, " masked  ");
>         else
> -               size +=3D sprintf(buf + size, " unmasked");
> +               size +=3D sysfs_emit_at(buf, size, " unmasked");
>
>  end:
> -       size +=3D sprintf(buf + size, "\n");
> +       size +=3D sysfs_emit_at(buf, size, "\n");
>         return result ? result : size;
>  }
>
> @@ -937,7 +937,7 @@ static void __exit interrupt_stats_exit(void)
>
>  static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribu=
te *attr, char *buf)
>  {
> -       return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
> +       return sysfs_emit(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
>  }
>
>  static const struct kobj_attribute pm_profile_attr =3D __ATTR_RO(pm_prof=
ile);
> @@ -946,7 +946,7 @@ static ssize_t enabled_show(struct kobject *kobj, str=
uct kobj_attribute *attr, c
>  {
>         struct acpi_hotplug_profile *hotplug =3D to_acpi_hotplug_profile(=
kobj);
>
> -       return sprintf(buf, "%d\n", hotplug->enabled);
> +       return sysfs_emit(buf, "%d\n", hotplug->enabled);
>  }
>
>  static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute=
 *attr,
> @@ -1000,7 +1000,7 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hot=
plug_profile *hotplug,
>  static ssize_t force_remove_show(struct kobject *kobj,
>                                  struct kobj_attribute *attr, char *buf)
>  {
> -       return sprintf(buf, "%d\n", 0);
> +       return sysfs_emit(buf, "%d\n", 0);
>  }
>
>  static ssize_t force_remove_store(struct kobject *kobj,
> --

Applied as 6.20 material, thanks!

