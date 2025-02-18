Return-Path: <linux-acpi+bounces-11262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84169A3A4D5
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF9B188DD7B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CB26FA44;
	Tue, 18 Feb 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9OShoef"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B822E401;
	Tue, 18 Feb 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901660; cv=none; b=ADn+glDKvoQ1Su26kQ/8rfGl75zUfS55AGFVkGA2f1m08VpAZdk7QpqpH6JCBvo3LEoaiS3omdadwb7y0XlFiqySqHgUIYE6LsIpIkPaVS1n62+0fyMqHLLrKCyubKwhGsvkuZZhniqxN2SntNe4Ag75E5t6i2e77kSvtADv5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901660; c=relaxed/simple;
	bh=X5cIzxfZwo4klvtzNw2WXQrEgsOXMYEji5/AX5ITIWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3AipNVLqk1fnWuWSumvUHg53KzLXho/EvMCKVUCfToZwgb9HFuy5qT2nDHEd0AcWjH3TY8XJvx49Jd0442Xsf+TS8AOKjoOE3CKCLvlHoMualfrZbddFTo4W62YjCC0dk0jabWKE7UPNQvn4swNAoj4Uy4xXzoOMvCD+4XbJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9OShoef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D91C4CEEA;
	Tue, 18 Feb 2025 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901659;
	bh=X5cIzxfZwo4klvtzNw2WXQrEgsOXMYEji5/AX5ITIWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9OShoeff0MEWqdSawqu7BUaDxShRZlaCP/Hjtxnu+8WTPjbAp6gl5UrOBbgPOEpT
	 9Vkd5F0SFCi+4Hs0flC1y0wZ0FOQysaIOlnFRZCu9pux4KMdyCyR6Ce1O28U48AqUR
	 Wy2GGFB6jlXli7TL0zGbqwpXETSAeNjZ57eyvjHWNnZ6x262KFCtyigZL90xCQZgXj
	 KKH7YqaZevr1eWXOssA3iXQXHeu1MNQA1sR8xMFhOsQ6VP8FTdbtFRAwpsKzvPbIWN
	 ejmgsK+QR7mg21KqheprBt9F1nxuIvfC9etUV79k5NLeBkpxGMiF1mzKDNv/OvqaWk
	 aT/tYr2UuU5+Q==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3e0498beaso14048b6e.1;
        Tue, 18 Feb 2025 10:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1V02IvVM4Ma7H3fjiE7IXyDXZfc8aqHvV5igv/F1kjcl9m9JOX1aPZDZY1BrMhZ41oznhM4Dt@vger.kernel.org, AJvYcCVTIitP6UG6MX4LkPcQOUx6d25VoRn7CA2at5fSRnO4Z7gTfNAAoON9va12G9zlNDQLZTWYCU8UozZs@vger.kernel.org, AJvYcCX06RUtbcCCdSgkqGM2rwqwaFZMPy10FnFVl+dsdy6MUldltlF64oSFpoTXFI7BDoL5aXYfl9riPLeNpbND@vger.kernel.org
X-Gm-Message-State: AOJu0YzajFopBw4XruvfByYZYqs30SSZGjSvl7z123aKqLPX7gLQbrA9
	H8KfFVHkfaouHjGs7NEZk+9mgY71bllDo8tIUbpTFPxwh/odYP3qtcvgeH+lqW0RbK9RY2pCy9B
	hU91n9lS2xM/u5b/PJ49mmPOOVxM=
X-Google-Smtp-Source: AGHT+IETDgAQnHmB1ym4OH/7fYtrH92mUURjm4lU0AE1WtC++HdD+kU9yToWvnK1uP0KyAPNH389H1MMc1SiyZKwJrE=
X-Received: by 2002:a05:6808:360c:b0:3f3:d367:52fa with SMTP id
 5614622812f47-3f40ef62f11mr422255b6e.18.1739901658915; Tue, 18 Feb 2025
 10:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
In-Reply-To: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:00:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hkJPWGv8PaPixC8vsr26vBBdGAL60X9iWwKVji098XRQ@mail.gmail.com>
X-Gm-Features: AWEUYZnLPIAbvPd7TRilaLcKa1PtFaiC5w37sc-4vTEe472uPGyGX93-jh3odew
Message-ID: <CAJZ5v0hkJPWGv8PaPixC8vsr26vBBdGAL60X9iWwKVji098XRQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: platform-profile: Fix CFI violation when
 accessing sysfs files
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Mario Limonciello <mario.limonciello@amd.com>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org, John Rowley <lkml@johnrowley.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:28=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When an attribute group is created with sysfs_create_group(), the
> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
> respectively. These functions use container_of() to get the respective
> callback from the passed attribute, meaning that these callbacks need to
> be the same type as the callbacks in 'struct kobj_attribute'.
>
> However, the platform_profile sysfs functions have the type of the
> ->show() and ->store() callbacks in 'struct device_attribute', which
> results a CFI violation when accessing platform_profile or
> platform_profile_choices under /sys/firmware/acpi because the types do
> not match:
>
>   CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choic=
es_show+0x0/0x140; expected type: 0x7a69590c)
>
> There is no functional issue from the type mismatch because the layout
> of 'struct kobj_attribute' and 'struct device_attribute' are the same,
> so the container_of() cast does not break anything aside from CFI.
>
> Change the type of platform_profile_choices_show() and
> platform_profile_{show,store}() to match the callbacks in
> 'struct kobj_attribute' and update the attribute variables to match,
> which resolves the CFI violation.
>
> Cc: stable@vger.kernel.org
> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> Reported-by: John Rowley <lkml@johnrowley.me>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
> Tested-by: John Rowley <lkml@johnrowley.me>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v3:
> - Rebase on 6.14-rc1, which includes updates to the driver to address
>   Greg's previous concerns but this change is still needed for the
>   legacy sysfs interface. v2 can be used for the stable backport.
> - Link to v2: https://lore.kernel.org/r/20241118-acpi-platform_profile-fi=
x-cfi-violation-v2-1-62ff952804de@kernel.org
>
> Changes in v2:
> - Rebase on linux-pm/acpi
> - Pick up Sami's reviewed-by tag
> - Adjust wording around why there is no functional issue from the
>   mismatched types
> - Link to v1: https://lore.kernel.org/r/20240819-acpi-platform_profile-fi=
x-cfi-violation-v1-1-479365d848f6@kernel.org
> ---
>  drivers/acpi/platform_profile.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index fc92e43d0fe9..1b6317f759f9 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -260,14 +260,14 @@ static int _aggregate_choices(struct device *dev, v=
oid *data)
>
>  /**
>   * platform_profile_choices_show - Show the available profile choices fo=
r legacy sysfs interface
> - * @dev: The device
> + * @kobj: The kobject
>   * @attr: The attribute
>   * @buf: The buffer to write to
>   *
>   * Return: The number of bytes written
>   */
> -static ssize_t platform_profile_choices_show(struct device *dev,
> -                                            struct device_attribute *att=
r,
> +static ssize_t platform_profile_choices_show(struct kobject *kobj,
> +                                            struct kobj_attribute *attr,
>                                              char *buf)
>  {
>         unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> @@ -333,14 +333,14 @@ static int _store_and_notify(struct device *dev, vo=
id *data)
>
>  /**
>   * platform_profile_show - Show the current profile for legacy sysfs int=
erface
> - * @dev: The device
> + * @kobj: The kobject
>   * @attr: The attribute
>   * @buf: The buffer to write to
>   *
>   * Return: The number of bytes written
>   */
> -static ssize_t platform_profile_show(struct device *dev,
> -                                    struct device_attribute *attr,
> +static ssize_t platform_profile_show(struct kobject *kobj,
> +                                    struct kobj_attribute *attr,
>                                      char *buf)
>  {
>         enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> @@ -362,15 +362,15 @@ static ssize_t platform_profile_show(struct device =
*dev,
>
>  /**
>   * platform_profile_store - Set the profile for legacy sysfs interface
> - * @dev: The device
> + * @kobj: The kobject
>   * @attr: The attribute
>   * @buf: The buffer to read from
>   * @count: The number of bytes to read
>   *
>   * Return: The number of bytes read
>   */
> -static ssize_t platform_profile_store(struct device *dev,
> -                                     struct device_attribute *attr,
> +static ssize_t platform_profile_store(struct kobject *kobj,
> +                                     struct kobj_attribute *attr,
>                                       const char *buf, size_t count)
>  {
>         unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> @@ -401,12 +401,12 @@ static ssize_t platform_profile_store(struct device=
 *dev,
>         return count;
>  }
>
> -static DEVICE_ATTR_RO(platform_profile_choices);
> -static DEVICE_ATTR_RW(platform_profile);
> +static struct kobj_attribute attr_platform_profile_choices =3D __ATTR_RO=
(platform_profile_choices);
> +static struct kobj_attribute attr_platform_profile =3D __ATTR_RW(platfor=
m_profile);
>
>  static struct attribute *platform_profile_attrs[] =3D {
> -       &dev_attr_platform_profile_choices.attr,
> -       &dev_attr_platform_profile.attr,
> +       &attr_platform_profile_choices.attr,
> +       &attr_platform_profile.attr,
>         NULL
>  };
>
>
> ---

Applied as 6.15 material with some edits in the changelog, thanks!

