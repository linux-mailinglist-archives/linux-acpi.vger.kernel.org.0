Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E66F3134
	for <lists+linux-acpi@lfdr.de>; Mon,  1 May 2023 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjEAMuu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 May 2023 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjEAMut (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 May 2023 08:50:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D610EA;
        Mon,  1 May 2023 05:50:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aae5c2423dso16638205ad.3;
        Mon, 01 May 2023 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682945448; x=1685537448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwELIRKAHNm5iJVhYK2ZdBO1ZolCnrOqU0qcbC+0lwU=;
        b=T6t2ELZ5f4JYz9xB/8mCO7Jdnhli4M69GZtETvcJyky9QGHltdL/bcrDqLutJMRE89
         arMb05ulDD+57eul6j7Wl7gYfPS3e0UQX9R/lXGIcaXmlyR6JoyypUQ152E84eiDOR+l
         kqbM+wJOsFZrS2WABgdhY/2uEux96MWZU0PlF9yi8/kW5kJinTz9L9pg10YwalMAObuF
         PVEpEICcZnv6JuguTqAkrW0PXJiTi9tLY73vJ+T+8tE9dUGb8g2JBeTysjEN+dbslU0b
         pOeHwdB3UKiXR4IXRXbBgW7sAU40fi1I35//qWFON3t5ZvWYm2R6TdVlMIsKikocWDLp
         kRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945448; x=1685537448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwELIRKAHNm5iJVhYK2ZdBO1ZolCnrOqU0qcbC+0lwU=;
        b=dr0IGdwL/HyC5QNPx4SAzHmKKiVwmXxr5lpQbBBIMP9fxYZtImBBgxysLdbkJViwWR
         2fO/QNjgoiHIGlF6RPPn+7F078toqfBsl2D580FCesgF5xjbFjWe8o06Qog/TekI2BQ0
         Atorb33xLH8QpUAo2zco1XMarrfaT7FwwTeBhQL0XXLHX2LfnfX7AMQHzCzRxsoFMfrX
         nQraH3KQ4JY7DFVWTP4yeSe60YUZDOb/THB2CQ8XxrVRoxsedr5rwiEeu4rZ2nZKV3U/
         buWH4CHaI33HYnauiVdo209gzJ+JhTd8/a01QUBIHmi4QDQfRpn7Py9i2scg5QDuRFeU
         o+9A==
X-Gm-Message-State: AC+VfDzPnOzox9jglFwT0OJR3raY7VerGt6HDy54bXurf2vNT+wguNdJ
        83VJv8JLu9toLYwnO99DfZA=
X-Google-Smtp-Source: ACHHUZ7wz8w7qpe15Q1dZYqVc/oJ7rXHCQIKJ7OkHfP6Yd/pX/FlKcy8GGym+w/XycFcSpB6gLTRcw==
X-Received: by 2002:a17:903:18b:b0:1a5:167f:620f with SMTP id z11-20020a170903018b00b001a5167f620fmr13455068plg.15.1682945448226;
        Mon, 01 May 2023 05:50:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id gb9-20020a17090b060900b0024dee500736sm2648554pjb.57.2023.05.01.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:50:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 482DC106237; Mon,  1 May 2023 19:50:44 +0700 (WIB)
Date:   Mon, 1 May 2023 19:50:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Acid Bong <acidbong@tilde.cafe>, regressions@lists.linux.dev
Cc:     stable@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Message-ID: <ZE+1pKbfy1l/tTo6@debian.me>
References: <CRVU11I7JJWF.367PSO4YAQQEI@bong>
 <5f445dab-a152-bcaa-4462-1665998c3e2e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o8j3sON65QrdRjDT"
Content-Disposition: inline
In-Reply-To: <5f445dab-a152-bcaa-4462-1665998c3e2e@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--o8j3sON65QrdRjDT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 02:51:47PM +0700, Bagas Sanjaya wrote:
> On 4/14/23 02:35, Acid Bong wrote:
> > The issue appeared when I was using pf-kernel with genpatches and
> > updated from 6.1-pf2 to 6.1-pf3 (corresponding to vanilla versions 6.1.3
> > -> 6.1.6). I used that fork until 6.2-pf2, but since then (early March)
> > moved to vanilla sources and started following the 6.1.y branch when it
> > was declared LTS. And the issue was present on all of them.
> >=20
> > The hang was last detected 3 days ago on 6.1.22 and today on 6.1.23.
> >=20
>=20
> Have you tried testing latest mainline to see if commits which are
> backported to 6.1.y cause your regression?
>=20

#regzbot poke

Acid Bong, have you successfully bisected to find the culprit commit?
How about swapping the hardware? I'm poking because the thread looks
stale for a while.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--o8j3sON65QrdRjDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZE+1nwAKCRD2uYlJVVFO
o8f7AP0eyxbUWhfWrmZsy8qwszcvI3TYLD3Dt/xIRbiuZ8d7hQD+KOmcPzg4n8zf
S06EBMian+f5balo8uwcqvk6MomLXAo=
=iMRM
-----END PGP SIGNATURE-----

--o8j3sON65QrdRjDT--
