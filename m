Return-Path: <linux-acpi+bounces-10642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C1AA1103F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 19:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D68C3A42DF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69891FC0EF;
	Tue, 14 Jan 2025 18:35:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA51C3BFC;
	Tue, 14 Jan 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879740; cv=none; b=NomNnkpvhCh/QjhxKxzHSwD6HNmLc6RW4gJqKOUvjOxGh7kTvjSun8F0jgkb0R3aSXu2Lu/OSraTkljWsU0XZiDtr2HZPNnq0ECqqFo1kY+rZ9ja71jooNHqkZZiH0fs4oP88y/HLWsjZU7xgKSjC445y2DqEz+wE4PSED1oS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879740; c=relaxed/simple;
	bh=Peh7tzN9nrcPGVnvVlfT5ZdMYbD6PJjw0aUvhULXnR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqEdk3axGkvahwy2ijSSLgsc1G7DpIi0d6YQdwwHuKekk4lyB8hWKmo64tCGqXRXOUJVauI0xRUCUgMEgHW6rkSSrkGry5kLKvp8x8d6fx+5140ez0ZACVeUcVJgLuswC+H85uAOklWHGZXf3oRLDFZ13v8LpLjC2YHdakv+m0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so2039013137.3;
        Tue, 14 Jan 2025 10:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879735; x=1737484535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bQjqJV9++e63u2QsOoRvIM92WKy6Q+3LtcaRgItQ+0=;
        b=Glc8OQ44IGPu/ksBsUB4BjF/hNhgTnjLb/WRcdveO8rC65wGRn9WdP6gtGQehxa2/f
         gc/z2Uzu6PPi+m3myYmQYXz5MbDb21wScaF4f14OBUlpNo6y96wjkao+wX6EVAUxxVkb
         K0OTEXwUO/WXAy8/n8wTecl6JdY898bT1kRppH2RKO5rl2tRL3BSorm9aCTDbcAC9bgk
         jZIYUbWArOpj+Dn1xWB7UCfeSslRaJv4zFfrMNbG3DLyQEi2zMMvuzY24cHFOooZoF6l
         tQpemvQEFGbwdotMJfB8iFBnK4pWxnn9PlQXhWhvYc/3QSaZeFftVnzrPmZEHWCZUX2C
         6ClA==
X-Forwarded-Encrypted: i=1; AJvYcCW9gsr0znQsv8AJvY8Z3qIrb/5lZJmLYbZ0EcB5pVhS58gq9akLwgpr/14TH3CE+RdRhpoayd5u1kXP@vger.kernel.org, AJvYcCWlRpu2RW73mNAgROL9CjR6qJLv8hQ2umdpp3PQyHVhpSdd64gYtgLEE7SWvOLdomNtURceev6rWLIynw==@vger.kernel.org, AJvYcCWusLCe2sTJzYX4U4MmAtHhAgxfUXm8Wuaxf3FUIgJov6jP6z2RFBZmI2L1AEtrh5238ZKFVDBP4dbgsFXL@vger.kernel.org, AJvYcCXnAh6qckOo/zPAkrlxphUIfXveCPItKE5vCPWtH8GEoLmpakZ0BXxFPoas9Ru0yq9SqaQ06mr8SV/4s9XR53AUYIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZM9iYgxww1gHeYvpKWPEJngfN7uersihGIN84pNZqq6+WMrd
	KZjR99jj3yzYW6dBij2Y32O9K0GvfyBlhq2/jHfPrf3JmOZIocDEAHZu/tZC
X-Gm-Gg: ASbGncvmHfd+eOa7FCr1lzWflYIe+nw1dm5mFjoGzB7sClDb0Npxp6FjZSpyPCS0K7w
	GQZToG7DqeGflau/W+ZAr3G8lKv1qVZblQkcbC8QPrgcN6rxlOeL8b1kFYtWZY1QiOptVUwGDX1
	/ypAyQKfg3LfsSCx2W4Q0qjX0pNrk3L/a9HaEvxRnopWtmOZIe8kUTS9KMXmPUhnD92eFM+SBKO
	9K31yuuqkwPGwNDeMZi5tyQc/m6yeoTjresvtmz6MDYZZdZvMmStTv+IdQPuAVFxnSlx4O+/N3N
	NYvpYSVVISjbZVFjN/M=
X-Google-Smtp-Source: AGHT+IFfw7glYdNpvJx8tx+BcCORyPRks9UjA65w2/aHkDwpnT1x/VXo2m00fFZXvsDztxBvl9U1SA==
X-Received: by 2002:a05:6102:1626:b0:4af:f3bd:51cd with SMTP id ada2fe7eead31-4b3d0dd8e02mr22948354137.16.1736879735409;
        Tue, 14 Jan 2025 10:35:35 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86231578d2bsm5370439241.29.2025.01.14.10.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 10:35:34 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afd56903b7so1788591137.1;
        Tue, 14 Jan 2025 10:35:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2leI7YBFaM0odSUXHyZ6QxPtuLsGdW4PzB8RgZ3MwjduA98k75bZbswyD6Zix13aZlfSWV1INvwDTe4NG@vger.kernel.org, AJvYcCXTUBTHJPEzy5P3BkTvnHlQstl8RV0UZSfAzWQesNa4GpmesMv5gp6PqmEEKhhtPZH95crJvFBmmygIqIAH9yJYVu0=@vger.kernel.org, AJvYcCXYq+GuXgggyCjZ9kB/pbm4ItU9Gi1tdfZJYGHaJxpsBEk6Q6/wXsK77WTdl67TY00u2iMF644HQt5o2Q==@vger.kernel.org, AJvYcCXeX5eT14uKODvyFu0tWdR05hosdVvJSMfbCnbzrcszRHqaTnarUPNs5kaYSfUAlTgbBVO+0sjyBEEP@vger.kernel.org
X-Received: by 2002:a05:6102:3c85:b0:4b6:35c4:6fcd with SMTP id
 ada2fe7eead31-4b635c47061mr11100297137.7.1736879734450; Tue, 14 Jan 2025
 10:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org> <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>
In-Reply-To: <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jan 2025 19:35:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
X-Gm-Features: AbW1kvbkSQeGeO8LFBKoGl7mpw2iax8ObeR2aLsDXRLZIyPNtWQTCcu-ht00Szs
Message-ID: <CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, Jan 9, 2025 at 8:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated. The primary use of it was to test property presence, but
> that has been replaced in favor of of_property_present(). With those
> uses now fixed, add a warning to discourage new ones.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your patch, which is now commit c141ecc3cecd7647 ("of:
Warn when of_property_read_bool() is used on non-boolean properties")
in dt-rh/for-next.

I have bisected a failure in secondary CPU bring-up on R-Car H1 (quad
Cortex-A9 MPCore) to this commit:

     Detected Renesas R-Car Gen1 r8a7779 ES1.0
     smp: Bringing up secondary CPUs ...
    -CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
    -CPU1: Spectre v2: using BPIALL workaround
    -CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
    -CPU2: Spectre v2: using BPIALL workaround
    -CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
    -CPU3: Spectre v2: using BPIALL workaround
    -smp: Brought up 1 node, 4 CPUs
    -SMP: Total of 4 processors activated (2000.00 BogoMIPS).
    +CPU1: failed to come online
    +CPU2: failed to come online
    +CPU3: failed to come online
    +smp: Brought up 1 node, 1 CPU
    +SMP: Total of 1 processors activated (500.00 BogoMIPS).
     CPU: All CPU(s) started in SVC mode.

Reverting this commit on top of my work tree fixes the issue, too.
However, I do not see how this commit could impact CPU bring-up?

I added debug code to of_property_read_bool(), to print all look-ups.
I only saw a few before CPU bring-up, nothing relevant:

     NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
    +OF: of_property_read_bool(interrupt-controller): 1
     rcu: srcu_init: Setting srcu_struct sizes based on contention.
    +OF: of_property_read_bool(interrupt-controller): 1
     sched_clock: 64 bits at 250MHz, resolution 4ns, wraps every 4398046511=
102ns
     clocksource: arm_global_timer: mask: 0xffffffffffffffff
max_cycles: 0x7350b89c29, max_idle_ns: 881590431910 ns
     Switching to timer-based delay loop, resolution 4ns
    +OF: of_property_read_bool(interrupt-controller): 1
    +OF: of_property_read_bool(always-on): 0
     Console: colour dummy device 80x30
     printk: legacy console [tty0] enabled

Perhaps something shifted in the code layout?  The obvious suspects
(shmobile_boot_* and shmobile_smp_* asm code, secondary_startup(),
addresses in arch/arm/mach-shmobile/platsmp-scu.c) are still at the
same addresses as before...

Anyone with a clue?
Thanks!

> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -31,6 +31,32 @@
>
>  #include "of_private.h"
>
> +/**
> + * of_property_read_bool - Find a property
> + * @np:                device node from which the property value is to b=
e read.
> + * @propname:  name of the property to be searched.
> + *
> + * Search for a boolean property in a device node. Usage on non-boolean
> + * property types is deprecated.
> + *
> + * Return: true if the property exists false otherwise.
> + */
> +bool of_property_read_bool(const struct device_node *np, const char *pro=
pname)
> +{
> +       struct property *prop =3D of_find_property(np, propname, NULL);
> +
> +       /*
> +        * Boolean properties should not have a value. Testing for proper=
ty
> +        * presence should either use of_property_present() or just read =
the
> +        * property value and check the returned error code.
> +        */
> +       if (prop && prop->length)
> +               pr_warn("%pOF: Read of boolean property '%s' with a value=
.\n", np, propname);
> +
> +       return prop ? true : false;
> +}
> +EXPORT_SYMBOL(of_property_read_bool);
> +
>  /**
>   * of_graph_is_present() - check graph's presence
>   * @node: pointer to device_node containing graph port
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 1cb4eb7fc2eded2246c697c3bcaf1b85d43108ab..0cdd58ff0a4190724309ba1ed=
dbac51b188b6136 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -311,6 +311,7 @@ extern struct device_node *of_find_node_with_property=
(
>  extern struct property *of_find_property(const struct device_node *np,
>                                          const char *name,
>                                          int *lenp);
> +extern bool of_property_read_bool(const struct device_node *np, const ch=
ar *propname);
>  extern int of_property_count_elems_of_size(const struct device_node *np,
>                                 const char *propname, int elem_size);
>  extern int of_property_read_u32_index(const struct device_node *np,
> @@ -615,6 +616,12 @@ static inline struct device_node *of_find_compatible=
_node(
>         return NULL;
>  }
>
> +static inline bool of_property_read_bool(const struct device_node *np,
> +                                       const char *propname)
> +{
> +       return false;
> +}
> +
>  static inline int of_property_count_elems_of_size(const struct device_no=
de *np,
>                         const char *propname, int elem_size)
>  {
> @@ -1242,24 +1249,6 @@ static inline int of_property_read_string_index(co=
nst struct device_node *np,
>         return rc < 0 ? rc : 0;
>  }
>
> -/**
> - * of_property_read_bool - Find a property
> - * @np:                device node from which the property value is to b=
e read.
> - * @propname:  name of the property to be searched.
> - *
> - * Search for a boolean property in a device node. Usage on non-boolean
> - * property types is deprecated.
> - *
> - * Return: true if the property exists false otherwise.
> - */
> -static inline bool of_property_read_bool(const struct device_node *np,
> -                                        const char *propname)
> -{
> -       const struct property *prop =3D of_find_property(np, propname, NU=
LL);
> -
> -       return prop ? true : false;
> -}
> -
>  /**
>   * of_property_present - Test if a property is present in a node
>   * @np:                device node to search for the property.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

