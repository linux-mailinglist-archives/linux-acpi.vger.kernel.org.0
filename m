Return-Path: <linux-acpi+bounces-20593-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGU6AIjJc2mQygAAu9opvQ
	(envelope-from <linux-acpi+bounces-20593-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 20:18:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB447A155
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A112B3018BF5
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303F21B9F6;
	Fri, 23 Jan 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRvjQji4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF931DF97C
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195865; cv=none; b=mM8nNJyohkTSaOvFGmzv62/n4w9U0oS0yBf7/RYdBqCvPRzAD58Tv3jY6KoN1jQBsVxUYRcxKd8h+yAoDGIWNq0fZig3C906+IoJv0M5SrylEB3Obkj4ITdsR8EprGnOEtNzWT8LjfArrh/7cPzjwdLSu4i2x9465mOYRICF9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195865; c=relaxed/simple;
	bh=u2IuPhC4btv+zKNq2Pd1GvDxGCHGH6WaxrbB7K3Y9Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdyueL1BDh6G0/Hk/xwUlyNHlZT7/lbgX8hiLNW31YUWQVfeigoF79AUEK9YWdgih1GlbLQiM+MqLQauBGlsuJrC85epVMz6OObsG0y5ZY/iUb61APP+YE/EGDgjvBCcry6kgka9Ou+gJ8Lx424rZOYzXFdbMDRbiA1vZCnpt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRvjQji4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646AFC4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769195865;
	bh=u2IuPhC4btv+zKNq2Pd1GvDxGCHGH6WaxrbB7K3Y9Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jRvjQji4vxXdJ+Muav8VzVA5d8EU3UnSwMKzrugkmk5RpC9z0oaRqEdsigAb6mEKD
	 r3MHCOV85RG9eY2BE+v4qmLEhXGsjLRkeKDzO04RbXZf5Af/1ielCRTBa4L3iWk65t
	 6uzFnK422WQgREgm8+8c2tE/Xe7oKrkhvmbX1vvIy/1U01K4DV+kjPiLZ7zZhKOQ2N
	 J1OF4tacR9FQw3VeUxeh5229ttp+AUgF5FKSq92SGbNsas7+woQZKbYNtIwDUih0ZI
	 lOhh+8JaaxcLD1oLBD4HoeNj0KlW4H6UD5F6GJnnWP414pUSgTuCVi5XpiwrZiYwQv
	 iCoHxQ8woE5Ig==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6610b05b37dso2172191eaf.2
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 11:17:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ1sMgAJU/6JfNxnOchD1bM8A4oDF7da296OcrdmJUgZGf/ykgxJBVXNwrPnQ+vRBTuYqWZM9MQVxt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ROkriDYjWw5jN/opwbiVu6IfbxHpN6mOqtdHotiadb5ORrv5
	VPgs8/pQAqQ4NDXrpHdnoXDewSjvwfMgDC8ZeqpGhVrbSfMwHBZVZolhURUjZ4NFqQfoNeraYCE
	xXH26J6PoCPwHP8GTJ3Cd3vBIPTIWyu0=
X-Received: by 2002:a05:6820:4a8e:b0:662:c17a:2f52 with SMTP id
 006d021491bc7-662d0781125mr783923eaf.66.1769195864510; Fri, 23 Jan 2026
 11:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121084654.2227037-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260121084654.2227037-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 20:17:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-fZLG+4cqtPYYCRZrKqSXHMaaPuGx2UYBCMPY0+_0tg@mail.gmail.com>
X-Gm-Features: AZwV_Qj5DE7BigvCtYthen0g4TLAB4dtp1eMlhxiCRMgmvGRmYhDoMDypxpzt9A
Message-ID: <CAJZ5v0h-fZLG+4cqtPYYCRZrKqSXHMaaPuGx2UYBCMPY0+_0tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: video: simplify code with acpi_get_local_u64_address()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20593-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 6FB447A155
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 9:47=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Now we have a helper so there's no need to open-code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: removed now unused variable (LKP)
>
>  drivers/acpi/acpi_video.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 944aba605c1a..69469757b965 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1134,13 +1134,11 @@ static int acpi_video_bus_get_one_device(struct a=
cpi_device *device, void *arg)
>         struct acpi_video_bus *video =3D arg;
>         struct acpi_video_device_attrib *attribute;
>         struct acpi_video_device *data;
> -       unsigned long long device_id;
> -       acpi_status status;
>         int device_type;
> +       u64 device_id;
>
> -       status =3D acpi_evaluate_integer(device->handle, "_ADR", NULL, &d=
evice_id);
>         /* Skip devices without _ADR instead of failing. */
> -       if (ACPI_FAILURE(status))
> +       if (acpi_get_local_u64_address(device->handle, &device_id))
>                 goto exit;
>
>         data =3D kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
> --

Applied as 6.20 material, thanks!

