Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E43769F0B
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjGaRMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jul 2023 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGaRMA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2023 13:12:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3541FD2
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 10:08:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so7688605e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690823270; x=1691428070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW6vy9kvGdKvD3u4Nu2jLKjjS6qQrgIUKZoDVHDe5bU=;
        b=JhlA7AdvTSq3lBkXf6xjbdCWbWkH7dCBiF0IlHKZ+zeP/5T8wsFGMpAyE3lfanorP2
         YtDyeeWisDL7PcXE/v/thVoCdvbsKRyKvmMLZf8g2PL7C5ngd9Gl2aSc6ZCc8l1w0/Rl
         0vgEsFt9iDtTwVtG5RDrvyckIB+C3BuPJmYfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823270; x=1691428070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW6vy9kvGdKvD3u4Nu2jLKjjS6qQrgIUKZoDVHDe5bU=;
        b=hlPdbwxDj0L1dkah36iphtr7HGvGQThZmUy0TxKatdvReCWB4gZtkPGXeDXiTUnQvW
         7qFEfHqYAazYRFlMrmbrXsQyGLAvbuoqSD3hadh/a71fXh8qKEIH45psdnExP8PGcM9X
         UxazJteD8oB2bRHVeb3MFEX+1OWmz3KNsRgEgLhWkQAftM/qvYnGODEdcl2b2jm9qwtD
         B7FY5cAIXreHh7QXlWE2I1IUhhmzICsl5X9iOM1HnoCidnlYFAO2PDXW45PYax20ISCq
         Ur64de/AblTOJ3dACbebqxy2YC0jBREReAKnMYY6WKD+mkN/BUFULZrbWTNwdlT2Tuah
         nz3w==
X-Gm-Message-State: ABy/qLZnnsYPV5cu08z74WRIKefaAljQhrLTbv0x0472nnn75LlrbhSf
        GVrbfJw9Pm6tcEg7UHLPXGX1a2w/JM2t/1eiNhgjBA==
X-Google-Smtp-Source: APBJJlG5FCsdMcAADrC+kYsMy9T918yeKXkMbL+laCmYy1npxFTcJzjk3B5ejgakPPXd5kZLPq12SFOJlhqGW6mN3Zk=
X-Received: by 2002:ac2:5319:0:b0:4fb:7c40:9f97 with SMTP id
 c25-20020ac25319000000b004fb7c409f97mr296332lfh.27.1690823270238; Mon, 31 Jul
 2023 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230731024214.908235-1-tzungbi@kernel.org> <ec78c7ba-11ea-97ec-fa5d-5cfceec7c7ba@collabora.com>
In-Reply-To: <ec78c7ba-11ea-97ec-fa5d-5cfceec7c7ba@collabora.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 31 Jul 2023 11:07:33 -0600
Message-ID: <CAPnjgZ08pCcZ9P+6mr6dfr-swS05L8h_G1M2NKtZg3R7B2=DMg@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: chromeos_acpi: support official HID GOOG0016
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        groeck@chromium.org, rafael@kernel.org, lenb@kernel.org,
        guillaume.tucker@collabora.com, denys.f@collabora.com,
        ricardo.canuelo@collabora.com, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 31 Jul 2023 at 01:29, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 7/31/23 7:42=E2=80=AFAM, Tzung-Bi Shih wrote:
> > Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
> >
> > [1]: https://crrev.com/c/2266713
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> > ---
> > Changes from v2[2]:
> > - Instead of replacing, appending "GOOG0016" in sysfs-driver-chromeos-a=
cpi.
> >
> > Changes from v1[3]:
> > - Preserve the PNP ID GGL0001 for backward compatible to older firmware=
s.
> > - Modify commit title and message accordingly.
> >
> > [2]: https://patchwork.kernel.org/project/chrome-platform/patch/2023072=
8065438.4026629-1-tzungbi@kernel.org/
> > [3]: https://patchwork.kernel.org/project/chrome-platform/patch/2023072=
8014256.3836298-1-tzungbi@kernel.org/
> >
> >  .../ABI/testing/sysfs-driver-chromeos-acpi        | 15 +++++++++++++++
> >  .../firmware-guide/acpi/chromeos-acpi-device.rst  |  5 ++---
> >  drivers/platform/chrome/chromeos_acpi.c           |  2 +-
> >  3 files changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
