Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942B6F4F77
	for <lists+linux-acpi@lfdr.de>; Wed,  3 May 2023 06:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjECEbW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 May 2023 00:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECEbU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 May 2023 00:31:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49386B5;
        Tue,  2 May 2023 21:31:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b67a26069so5273137b3a.0;
        Tue, 02 May 2023 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683088276; x=1685680276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j36FxbwcTfFp+Gw+OcG7+yTUIaRmnbVgGu4hODtTOa0=;
        b=citAXFKdtFhDlYnMr+GPqWXwjQYIvHLtz/niHkqQih/1UNzeLl3TEUTEeb+3Z21JXJ
         WP0PogRcYNrjxnnih1jSjvxB4iRIrPEv4IV5vmDfIa7cvtGzed2C2bNeFrGR/N/lLmmx
         CndsSzUQd8zF6VqgbCnal2ZGPgIa4wjfHC8uCssmN+6As/oZ1InjHs6GiZ4b2vnSWqqE
         Cn4RSAXzV+1yVvnc1ljIrnfow/J3GuthUY0JN59EfER1TNmyJDIjByOYy2dhdLAujOOd
         UDGMSbS792NCH53/sf23pAg6Ifkh9bnmFdtNR20TrEvH6In0WHiZ30tnAWu7XfZD0tfd
         +Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683088277; x=1685680277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j36FxbwcTfFp+Gw+OcG7+yTUIaRmnbVgGu4hODtTOa0=;
        b=F7APy0VdTF/BnhZ1TWZR1Fziwfsj9o0QM1J/VSc3bTJ+n52rWBtx7/JW5VvEHwDHhd
         OJ83Dv7vM7TBWBO9r46VCxPvUZB36zG/m7gjeg99Ga/DAhvckEjlZBToIROOQa9cBzFx
         0Gx0hFaIXfSV0go7wKvCsnpbiAvLaC2kGvXJI9x+jSqPTfudeWxEIePDuL6YWL+Nw57n
         uvE2WkdvJrhOJ0GYk4D6t3rYQmRTZYJnp6A+fELF9NVfl3CAtvSHCxZ7YC13NYGQ0jT1
         3NSJfyzYnn8m1tc93Gg0FS/aQU/9xIe3t5r5gKA9O3Vf1GKgyJuSetoR1AAEW1w9nVyW
         c8wg==
X-Gm-Message-State: AC+VfDzhDQZQ6eE+hrRBqKqI8CNgxJ1dPWuP2OJwZNYjNniRV1TZ68JF
        GREQbsxjpCbxekGfX8ZCw1j2vBZMg3I=
X-Google-Smtp-Source: ACHHUZ7fgYIek3AW/jmP9fqZIwYfJQKDV4HBGtHSbzm88HjynunVyvK7sLCzkGyJubW9ytiB59fATw==
X-Received: by 2002:a05:6a00:a26:b0:641:3c61:db27 with SMTP id p38-20020a056a000a2600b006413c61db27mr21516460pfh.13.1683088276567;
        Tue, 02 May 2023 21:31:16 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0063b6fb4522esm22460215pfj.20.2023.05.02.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:31:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 61B83106248; Wed,  3 May 2023 11:31:13 +0700 (WIB)
Date:   Wed, 3 May 2023 11:31:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Acid Bong <acidbong@tilde.cafe>, regressions@lists.linux.dev
Cc:     stable@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Message-ID: <ZFHjkb75lgzKRhRr@debian.me>
References: <CRVU11I7JJWF.367PSO4YAQQEI@bong>
 <5f445dab-a152-bcaa-4462-1665998c3e2e@gmail.com>
 <ZE+1pKbfy1l/tTo6@debian.me>
 <CSB8TSV6LXJ8.7SHI9VM2YMAR@bong>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzZ1tcaqoAMep0dQ"
Content-Disposition: inline
In-Reply-To: <CSB8TSV6LXJ8.7SHI9VM2YMAR@bong>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--qzZ1tcaqoAMep0dQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 12:02:26AM +0300, Acid Bong wrote:
> Hi there, and thank you for the reminder.
>=20
> Bisecting, unfortunately, takes a long time: I'm only trying out the 7th
> commit, 15e7433e1dc2 (previous 6 marked as bad). The bug, as noted in
> the head, doesn't have any (strict) patterns and takes randomly long
> times: some kernels hung on the next day after compilation, one took 5
> days. I'm not excluding a possibility that I might've got the versions
> wrong and the bug occured on the update from 6.1-pf1 to 6.1-pf2 (6.1 and
> 6.1.3; could be unrelated, but I saw a bunch of commits related to i915
> and Skylake).

OK, try keep updating on bisection process.

> What exactly do you mean by "swapping the hardware"? I'm already sure
> it's not related to my storage, because a month ago I replaced my faulty
> HDD with an SSD, but the bug still remained. Unfortunately, I don't have
> spare PCs or resources to purchase new hardware.

In case of laptops, I mean buying out new laptop (maybe with similar
hardware specs as your current one) and try reproducing the regression
there.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--qzZ1tcaqoAMep0dQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFHjkAAKCRD2uYlJVVFO
o0hGAP0bEioOcTuwLyb+gkUo3DPx3R9ztyRQPLu3u8KxtSe9LQEAoy7Rm/yGzwrQ
uibC0VjplPdI/WpcMp7epkioqm6SnQY=
=Tnp8
-----END PGP SIGNATURE-----

--qzZ1tcaqoAMep0dQ--
