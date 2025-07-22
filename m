Return-Path: <linux-acpi+bounces-15279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF4B0DFF2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E858A6C45D9
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0E273D6E;
	Tue, 22 Jul 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1h+YCFX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6A26E6FA;
	Tue, 22 Jul 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196603; cv=none; b=U+Gfud1bk7tf3J82C+Wmntoam4SlnxBh0ha8LOaJRaa+UPxr/DX+M2l7z2uU4UxjAh9ibeoRA0rDvcQGLySnzC6zxEW8/tCCHZIhV99gzXZK9lHHIBrhn4TQyRLnhzCc0e2AoOzWUKF6iZVExeTOGHQIArDGUjGoWmtOv2vveRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196603; c=relaxed/simple;
	bh=WrJfhW2FFrEF+JQZ8I5Jn8OMm3uwbSOIl4zkfTApTBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsIqBIzzNZyDML/d++xvWIRlzcIT62YdPMTqsGFKTXqZxviLreWyCFGqVBKfs2smerQdGjm0LYpJ3rfaNGV4xHpPc7Ld8xxfwxfQgGQtuZ56zSwLZDljtAD62kQZOsZaLV4a9al8CUrpXzNdm1d1awXm+KF8DHVKopArjjcN5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1h+YCFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06758C4CEF6;
	Tue, 22 Jul 2025 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196603;
	bh=WrJfhW2FFrEF+JQZ8I5Jn8OMm3uwbSOIl4zkfTApTBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K1h+YCFXb1/0DYQGo8pS/HTyHovKPNqg80SN3t6kfOXeeSy1RlpIuTKctrxHXJn07
	 OugEnVTd7Wgv6y172Kcu1hD5l7cnJENVKdH83vIOacMwNtbpAhfMfcUxBwSXXP+7Jt
	 bAjvW5c4N4t3iSEuNaxS0QAA12oPmuJf1VomphoJqCvb1M+FrX1AYo8MiLyDHQ9brj
	 5L+YGOf/eifYswNPpaf4lnrx+cV3I7e1OJaTC5umdpZhWBvpzaMQcEO9nsibVAEGiH
	 ORaEjDLL7tLAvIwh6iM2H0eRyNendzgOnuhMB7L3PiF4ErpH46ZtiSrByuY6rAyEqb
	 w3POI6vw1i5Pw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615da180061so1207126eaf.2;
        Tue, 22 Jul 2025 08:03:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9dJKyber/KG/BvvrmoqTNeYrVJU3DhFEaJqua7jrVlMLM8uEgJ5WlYCd3oiNViJqljmuYkDYFM0tUVQkA@vger.kernel.org, AJvYcCWKl9b0TpZ93pvnHjEfIWG0qs9Gyd7igNYwKMDjk6LtuMkc6eW8v5f1s5w04TtlKVPotjqBy054nqBu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZpqhuaOC8YjOxsYTlPMpMfkKPQl6PsLc3fdxv66fDPJOdpn/
	3co439ZG4zJkViRzHqNqAT8aMnFDGMbLlaMSSUJS2M61xJd50IEpVrQT8y5hIw5cPL9W3OoEqoS
	STyBCzC6dLQ66sOqnYyqT354tRAIvCNU=
X-Google-Smtp-Source: AGHT+IH0PlftDSNVnw1T1Idhd4i3XAxqQOFc54z8aiS56mvx/uvEmDvq16gM0Wl98Cpztj4H4E59EMPC4c3eJ1d2hpw=
X-Received: by 2002:a05:6808:4f22:b0:40c:f220:67fd with SMTP id
 5614622812f47-41d036edf01mr16442152b6e.9.1753196597403; Tue, 22 Jul 2025
 08:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722143233.3970607-1-yu.c.chen@intel.com>
In-Reply-To: <20250722143233.3970607-1-yu.c.chen@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 17:03:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hskeS3fKU3OPow=i8Nh4NojsUrJJrW=oNJAb7tP9P6=g@mail.gmail.com>
X-Gm-Features: Ac12FXyl9FBnG7SOF-FL2Kagr1SkzlQKPJqC8-4NX8asBX1zPGXFF1yyyhXl9-8
Message-ID: <CAJZ5v0hskeS3fKU3OPow=i8Nh4NojsUrJJrW=oNJAb7tP9P6=g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: Fix the driver update version check
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@foxmail.com>, 
	"Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:39=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> The security-version-number check should be used rather
> than the runtime version check for driver update. Otherwise
> the firmware update would fail when the update binary
> has a lower number of the runtime version than the
> current one.
>
> Reported-by: "Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.=
com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

A Fixes: tag, please?

Also, this is unlikely to get into 6.17-rc1, but I can make it into
6.17-rc2 if it is urgent enough, so how urgent is it?

> ---
>  drivers/acpi/pfr_update.c  | 2 +-
>  include/uapi/linux/pfrut.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 031d1ba81b86..08b9b2bc2d97 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -310,7 +310,7 @@ static bool applicable_image(const void *data, struct=
 pfru_update_cap_info *cap,
>         if (type =3D=3D PFRU_CODE_INJECT_TYPE)
>                 return payload_hdr->rt_ver >=3D cap->code_rt_version;
>
> -       return payload_hdr->rt_ver >=3D cap->drv_rt_version;
> +       return payload_hdr->svn_ver >=3D cap->drv_svn;
>  }
>
>  static void print_update_debug_info(struct pfru_updated_result *result,
> diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
> index 42fa15f8310d..b77d5c210c26 100644
> --- a/include/uapi/linux/pfrut.h
> +++ b/include/uapi/linux/pfrut.h
> @@ -89,6 +89,7 @@ struct pfru_payload_hdr {
>         __u32 hw_ver;
>         __u32 rt_ver;
>         __u8 platform_id[16];
> +       __u32 svn_ver;
>  };
>
>  enum pfru_dsm_status {
> --
> 2.25.1
>

