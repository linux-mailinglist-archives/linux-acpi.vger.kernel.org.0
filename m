Return-Path: <linux-acpi+bounces-20664-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D8ZNDzUeGmNtQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20664-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:05:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B79646D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C741300844C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61D35D5EE;
	Tue, 27 Jan 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPH7x2+p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794C359714
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524949; cv=none; b=UNCZdx11bI4B7AQw7HrsP5OBJ4YoFmGKHNfqpWZMrJUCQxYa1rZkjHStVKc4CrwLlyn3QCDW/sM8R8RH9Geo0HSON485YYjk0r+jt/36h505nME/T14CxvZXSGDoo9Sbtt9wbcjzQttTgcVBCQwAMyv6Gt2FvgwLSfSH3Zu2xpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524949; c=relaxed/simple;
	bh=LTTABU341mk+8DNI37Wpjv9Le3xFvm+L+nfyEaXJ5gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKnLJIfu8E3rlbpWOKCqqcXuDJU2lGiUR9o3Gtvxh+CHbgNw98RF2tbPenKySApqdwSi/9N7ZGYGplrhKcpdgVSZuAdGqemzY0UF6sCujYtu6tvZJb10sQdtsksYIgCe8gZXfK/Ieedhsp5Ko2o8zgbbS4TryLEVk7JR2N/vuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPH7x2+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00592C2BCB2
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524949;
	bh=LTTABU341mk+8DNI37Wpjv9Le3xFvm+L+nfyEaXJ5gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EPH7x2+pQWLgqzdf3Kq8zCOE2F1/W7BedgDEeBaZWJf9aFPgHzHMMdQsbR7lFVavM
	 AFO4KmBcJyZS7A6EQ1WmY5oR4T5Qjc/ExoOWolIzNWhvWZ5BgxIf4ElnuFNVJZ7438
	 TZKnl2AexHTJm//5/2O2CL3zHx8+YXy+qmK6X/PP8cIWtCeLCXXZveBNLK/3NHAJ9g
	 0DICPSOE9JAiEd1RC7kZ4C+wFniQOCBscyBz5fo7jPPXJ+Yn194tPFR5KykBNGvASE
	 8yboTQ6f4eiseGLYMvzwgKM7jhMOd/juXuF4zvLQWxOgcKAvMu3GvA7pEmNjjng6BF
	 WzkqaCtQzAcGw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4094b31a037so210403fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 06:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVqCUDMLs1qIUoBKoSzidwnKjVUOTfXzxSl0wc+44u0TP07sKEA7qr4zZ0Pt3LOdWTdNbRN6/lSp6q@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMvcv1LsYuYM86Rd5kTCM3bqMWWVbH3R49fHvpqbpbCv+SQO4
	Znn29FGzA1U9R1X1NEiuvNh70OkZ+RRuL46kGJXTEexAUSpl/Dj7KO4x4dF7HzpBYhpLPPKKJ5K
	R1CgJWk3RUB2fWwcd0X2uN9p6fXVB4gI=
X-Received: by 2002:a05:6871:88b:b0:3e8:98d7:72e5 with SMTP id
 586e51a60fabf-4093ff8774cmr1113391fac.46.1769524947956; Tue, 27 Jan 2026
 06:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
In-Reply-To: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 15:42:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com>
X-Gm-Features: AZwV_QgZb6LD1n_OwUR9x3_tzRjGXHN2vhZkiDanug5QO1OQbZv8DcDB0vtBEW8
Message-ID: <CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse
 _CPC tables before CPU online
To: Lifeng Zheng <zhenglifeng1@huawei.com>, jonathan.cameron@huawei.com
Cc: catalin.marinas@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, gshan@redhat.com, 
	miguel.luis@oracle.com, guohanjun@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20664-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E77B79646D
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 12:33=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq drive=
r
> will fail to register. Because it requires the domain information of all
> possible CPUs to construct shared_cpu_map, which shows the CPUs that shar=
e
> the same domain.
>
> Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
> same path for cold and hotplug") removes probe() of acpi_processor_driver
> and makes acpi_cppc_processor_probe() only being called the first time CP=
U
> goes online. This means that CPUs that haven't yet gone online will not
> have pre-parsed _CPC objects and causes cppc_cpufreq driver register fail=
.
>
> Add acpi_processor_start() back as the probe() callback of
> acpi_processor_driver and call acpi_cppc_processor_probe() in it to make
> sure all _CPC tables will be parsed when acpi_processor_driver registered=
.
>
> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use s=
ame path for cold and hotplug")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 65e779be64ff..c8b4daf580b0 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
>  MODULE_LICENSE("GPL");
>
> +static int acpi_processor_start(struct device *dev);
>  static int acpi_processor_stop(struct device *dev);
>
>  static const struct acpi_device_id processor_device_ids[] =3D {
> @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver =3D {
>         .name =3D "processor",
>         .bus =3D &cpu_subsys,
>         .acpi_match_table =3D processor_device_ids,
> +       .probe =3D acpi_processor_start,
>         .remove =3D acpi_processor_stop,
>  };
>
> @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_device=
 *device)
>         if (!pr)
>                 return -ENODEV;
>
> -       result =3D acpi_cppc_processor_probe(pr);
> -       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> -               dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
> -
>         if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
>                 acpi_processor_power_init(pr);
>
> @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_device=
 *device)
>         return result;
>  }
>
> +static int acpi_processor_start(struct device *dev)
> +{
> +       struct acpi_device *device =3D ACPI_COMPANION(dev);
> +       struct acpi_processor *pr;
> +       int result;
> +
> +       if (!device)
> +               return -ENODEV;
> +
> +       pr =3D acpi_driver_data(device);
> +       if (!pr)
> +               return -ENODEV;
> +
> +       /* Protect against concurrent CPU hotplug operations */
> +       cpu_hotplug_disable();
> +       result =3D acpi_cppc_processor_probe(pr);
> +       cpu_hotplug_enable();

This means that CPPC will be initialized for vCPUs that are not
enabled on ARM if I'm not mistaken.

I'm not sure if it is valid to do so.

Jonathan?

> +
> +       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> +               dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
> +
> +       return 0;
> +}
> +
>  static int acpi_processor_stop(struct device *dev)
>  {
>         struct acpi_device *device =3D ACPI_COMPANION(dev);
> --
> 2.33.0
>
>

