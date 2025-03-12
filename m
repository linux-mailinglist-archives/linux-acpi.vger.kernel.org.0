Return-Path: <linux-acpi+bounces-12134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8A4A5E4A6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 20:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E4717B64A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D42586FE;
	Wed, 12 Mar 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8ejfFs7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881111DE894;
	Wed, 12 Mar 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808547; cv=none; b=MMyJFyTSIZD0fCIP19NpD8CxMX3WoXfUVCKU0AgoY8k5CHeiRD6Uo5KhSFyTK1uExr+Cpm6G1d5NfaHPUPdYG1759FtjaCHtGx4/Y5laHUsNY1fqjl9sxY6SQCYf6OKrgjoyxSD5D3X9S6EVz7B14LsKP/OO8Su7ecr9K2sFTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808547; c=relaxed/simple;
	bh=rR9sGvDvTNBxumgD3sshwMYc//HMbHud/yj/n6J26f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAJiAm79QaR0C0yqPuiFhp82p7DA/ufra3H7Zetp5aPzvzLHTazBJMBQONk/IPm91wH3lpeBmG8Qjx5xn45J2tIk1+hDl6yqEmSDIXs1dxzmJRDW1cjwHTYhF7dWj5aQWvJ5UC95tYOQh7qbddQ8k+4w9Lw+n4viSxD6Omq7t64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8ejfFs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C6C4CEDD;
	Wed, 12 Mar 2025 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741808547;
	bh=rR9sGvDvTNBxumgD3sshwMYc//HMbHud/yj/n6J26f4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m8ejfFs7S7gvZAjwVFi7iiCr0PeRC/do7aIRRdyflsY7hQ8wteiVaAfizLGdCb8of
	 8hEs/BUFpGALpTIwTD4aFwUGInbMnWWuSZyvjDGLD50Navj1UGHKtusrOgWqJoAnS5
	 v9P1nervb54P1AqJWOfaZaa9hy0dKGytAsyR8yn3U0MrpvsFHFF8YDgU8DY+h16plr
	 ZfDmIOyxSzxKJYTItaxHYQHPLVW5W1CDcine9ImoqJ0KGkPRvIMFUI2EXSsBL6vSOC
	 TwAFO8CelBfshKFdvxrGDnBAGQLeAb/zoksqCxUzSGI8MhlgWoLMMWmLivDkjszrHe
	 1zND03UUP4sXQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72736498817so111364a34.1;
        Wed, 12 Mar 2025 12:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMFQb3TqFdlYKjb7ylNZTcgeYm4omf1uwZXgnWNFncwwNI1OxMIXL2f0D2O68Tl+CQ34Vd+urcSJl5@vger.kernel.org, AJvYcCWdS89/69Z2vkf0YGnRLt/YR9+FMrGjE391biEU6CODYtJd/Xso1OcH9S+VcpuXik9bLafT4bIxV0CIOjT3@vger.kernel.org, AJvYcCWzCkEs1ZVM8KN2WDok85Or526Qjv5H/cvouKqi/CsDq/NYa48nUMmj03C+S29ogl6l5gigTtarfoHEtkIfymW7@vger.kernel.org
X-Gm-Message-State: AOJu0YyAP9cS+P8RNphSIhgAdovbYJY5q9cM7llbVLyQwZ2bZnVS4dfx
	Zhvt5jS3vxxxwp19KLVvgR27+bqTkQwFPyoSoKx41FxEuSiBpIg7sC2SLtAQHLZ4CBBR7WTRYuy
	ohdLpdMv+cx6IlM6/mZgQ4NlNJiU=
X-Google-Smtp-Source: AGHT+IEB3NZFvCSX7ReDxQhwwLXfmo6c+PjIOwot7ArsH4J6MB0jCwvgW7uZczVb3k8WyB22HuX8jDYDSbid/yESwJo=
X-Received: by 2002:a05:6830:2641:b0:72b:9506:8db6 with SMTP id
 46e09a7af769-72b95069043mr6591433a34.6.1741808546719; Wed, 12 Mar 2025
 12:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310222432.work.826-kees@kernel.org>
In-Reply-To: <20250310222432.work.826-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:42:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxrj-DW7a=3iXmsCFm-K4rJvsrG=f5YLJreVmaZ207Lw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq1Db5q6FqcKbKLJbTnKn0KewEQfAgm5Ujmcc0Zz0yAQlA2Oc6PZgy3cPE
Message-ID: <CAJZ5v0hxrj-DW7a=3iXmsCFm-K4rJvsrG=f5YLJreVmaZ207Lw@mail.gmail.com>
Subject: Re: [PATCH] PNP: Expand length of fixup id string
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> GCC 15's -Wunterminated-string-initialization saw that "id" was not
> including the required trailing NUL character. Instead of marking "id"
> with __nonstring[1], expand the length of the string as it is used in
> (debugging) format strings that expect a properly formed C string.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/pnp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index b7a7158aaf65..23fe3eaf242d 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -290,7 +290,7 @@ static inline void pnp_set_drvdata(struct pnp_dev *pd=
ev, void *data)
>  }
>
>  struct pnp_fixup {
> -       char id[7];
> +       char id[8];
>         void (*quirk_function) (struct pnp_dev *dev);   /* fixup function=
 */
>  };
>
> --

Applied as 6.15 material, thanks!

